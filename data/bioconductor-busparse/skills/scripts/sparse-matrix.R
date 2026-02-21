# Code example from 'sparse-matrix' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE------------------------------------------------------------
# The dataset package
library(TENxBUSData)
library(BUSpaRse)
library(Matrix)
library(zeallot)
library(ggplot2)

## -----------------------------------------------------------------------------
TENxBUSData(".", dataset = "hgmm100")

## -----------------------------------------------------------------------------
tr2g <- transcript2gene(species = c("Homo sapiens", "Mus musculus"), 
                        kallisto_out_path = "./out_hgmm100", ensembl_version = 99,
                        write_tr2g = FALSE)

## -----------------------------------------------------------------------------
head(tr2g)

## -----------------------------------------------------------------------------
c(gene_count, tcc) %<-% make_sparse_matrix("./out_hgmm100/output.sorted.txt",
                               tr2g = tr2g, est_ncells = 1e5,
                               est_ngenes = nrow(tr2g))

## -----------------------------------------------------------------------------
dim(gene_count)

## -----------------------------------------------------------------------------
tot_counts <- Matrix::colSums(gene_count)
summary(tot_counts)

## -----------------------------------------------------------------------------
df1 <- get_knee_df(gene_count)
infl1 <- get_inflection(df1)

## -----------------------------------------------------------------------------
knee_plot(df1, infl1)

## -----------------------------------------------------------------------------
gene_count <- gene_count[, tot_counts > infl1]
dim(gene_count)

## -----------------------------------------------------------------------------
dim(tcc)

## -----------------------------------------------------------------------------
tot_counts <- Matrix::colSums(tcc)
summary(tot_counts)

## -----------------------------------------------------------------------------
df2 <- get_knee_df(tcc)
infl2 <- get_inflection(df2)

## -----------------------------------------------------------------------------
knee_plot(df2, infl2)

## -----------------------------------------------------------------------------
tcc <- tcc[, tot_counts > infl2]
dim(tcc)

## -----------------------------------------------------------------------------
sessionInfo()

