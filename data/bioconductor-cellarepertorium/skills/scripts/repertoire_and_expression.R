# Code example from 'repertoire_and_expression' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>")

## ----setup--------------------------------------------------------------------
library(CellaRepertorium)
library(SingleCellExperiment)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
library(purrr)

## -----------------------------------------------------------------------------
set.seed(1345)
data(ccdb_ex)
barcodes = ccdb_ex$cell_tbl[ccdb_ex$cell_pk]

# Take a subsample of almost all of the barcdes
barcodes = barcodes[sample(nrow(barcodes), nrow(barcodes) - 5),]
samples = unique(ccdb_ex$cell_tbl[setdiff(ccdb_ex$cell_pk, 'barcode')])

# For each sample, generate  0-100 "extra" barcodes for which only 5' expression is recovered
extra = samples %>% rowwise() %>% mutate(extrabc = {
  extra_bc = floor(runif(1, 0, 100))
  list(tibble(barcode = paste0('barcode', seq_len(extra_bc))))
}) 
extra = extra %>% unnest(cols = c(extrabc))
all_bc = bind_rows(extra, barcodes)


## -----------------------------------------------------------------------------
genes = 200
cells = nrow(all_bc)
array_size = genes*cells
expression = matrix(rnbinom(array_size, size = 5, mu = 3), nrow = genes, ncol = cells)
sce = SingleCellExperiment(assay = list(counts = expression), colData = all_bc)

## -----------------------------------------------------------------------------
ccdb2 = ccdb_join(sce, ccdb_ex)

ccdb2 = cdhit_ccdb(ccdb2, 'cdr3', type = 'AA', cluster_pk = 'aa80', identity = .8, min_length = 5)
ccdb2 = fine_clustering(ccdb2, sequence_key = 'cdr3', type = 'AA', keep_clustering_details = FALSE)


## -----------------------------------------------------------------------------
colData(sce)$alpha =  canonicalize_cell(ccdb2, chain == 'TRA', contig_fields = c('chain', 'v_gene','d_gene', 'j_gene', 'aa80'))

colData(sce)$beta =  canonicalize_cell(ccdb2, chain == 'TRB', contig_fields = c('chain', 'v_gene','d_gene', 'j_gene', 'aa80'))

colData(sce)$pairing = enumerate_pairing(ccdb2, chain_recode_fun = 'guess')

## -----------------------------------------------------------------------------
library(scater)
sce = logNormCounts(sce)
sce = runPCA(sce)
plotReducedDim(sce, dimred = 'PCA', colour_by = I(sce$pairing$pairing), point_alpha = 1)

## ----  out.height='500px', out.width = '500px'--------------------------------
only_paired = sce[,which(sce$pairing$pairing == 'paired')]
plotReducedDim(only_paired, dimred = 'PCA', colour_by = I(only_paired$alpha$j_gene), point_alpha = 1)
plotReducedDim(only_paired, dimred = 'PCA', colour_by = I(only_paired$beta$j_gene), point_alpha = 1)

## -----------------------------------------------------------------------------
sessionInfo()

