# Code example from 'mouse_tcell_qc' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>")

## ----setup--------------------------------------------------------------------
library(CellaRepertorium)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)

## -----------------------------------------------------------------------------
files = list.files(system.file('extdata', package = 'CellaRepertorium'), pattern = "all_contig_annotations_.+?.csv.xz", recursive = TRUE, full.names = TRUE)
# Pull out sample and population names
samp_map = tibble(anno_file = files, pop = str_match(files, 'b6|balbc')[,1], sample = str_match(files, '_([0-9])\\.')[,2])

knitr::kable(samp_map)

## -----------------------------------------------------------------------------
# read in CSV
all_anno = samp_map %>% rowwise() %>% mutate(anno = list(read_csv(anno_file, col_types = cols(
  barcode = col_character(),
  is_cell = col_logical(),
  contig_id = col_character(),
  high_confidence = col_logical(),
  length = col_double(),
  chain = col_character(),
  v_gene = col_character(),
  d_gene = col_character(),
  j_gene = col_character(),
  c_gene = col_character(),
  full_length = col_logical(),
  productive = col_character(),
  cdr3 = col_character(),
  cdr3_nt = col_character(),
  reads = col_double(),
  umis = col_double(),
  raw_clonotype_id = col_character(),
  raw_consensus_id = col_character()
))))

all_anno = all_anno %>% unnest(cols = c(anno)) 

## -----------------------------------------------------------------------------
cell_tbl = unique(all_anno[c("barcode","pop","sample","is_cell")])
cdb = ContigCellDB(all_anno, contig_pk = c('barcode','pop','sample','contig_id'), cell_tbl = cell_tbl, cell_pk = c('barcode','pop','sample'))

## -----------------------------------------------------------------------------
cdb = mutate_cdb(cdb, celltype = guess_celltype(chain))
cdb = filter_cdb(cdb, high_confidence)

## -----------------------------------------------------------------------------
total_umi = crosstab_by_celltype(cdb)
T_ab_umi = total_umi[c(cdb$cell_pk,"is_cell","T_ab")]

ggplot(T_ab_umi, aes(color = factor(is_cell), x = T_ab, group = interaction(is_cell, sample, pop))) + stat_ecdf() + coord_cartesian(xlim = c(0, 10)) + ylab('Fraction of barcodes') + theme_minimal() + scale_color_discrete('10X called cell?')

## -----------------------------------------------------------------------------
qual_plot = ggplot(cdb$contig_tbl, aes(x = celltype, y= umis)) + geom_violin() + geom_jitter() + facet_wrap(~sample + pop) + scale_y_log10() + xlab("Annotated cell type")

qual_plot 
qual_plot + aes(y = reads)

## ---- results = 'asis'--------------------------------------------------------
# At least 2 UMI mapping to high confidence T cell contigs.
good_bc = total_umi %>% ungroup() %>% filter(is_cell) %>% filter(T_ab >= 2)
total_cells = good_bc %>% group_by(sample, pop) %>% summarize(good_bc = n())
knitr::kable(total_cells)

## -----------------------------------------------------------------------------
contigs_qc = semi_join(cdb$contig_tbl, good_bc %>% select(sample, pop, barcode)) %>% 
  filter(full_length, productive == 'True', high_confidence, chain != 'Multi')

## -----------------------------------------------------------------------------
sessionInfo()

