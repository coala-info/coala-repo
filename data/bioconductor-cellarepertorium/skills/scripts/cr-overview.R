# Code example from 'cr-overview' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>")

## ---- echo = FALSE------------------------------------------------------------
knitr::include_graphics(system.file('help/figures/contig_schematic.png', package = 'CellaRepertorium'))

## ----  echo = FALSE-----------------------------------------------------------
knitr::include_graphics(system.file('help/figures/table_schematic.png', package = 'CellaRepertorium'))

## -----------------------------------------------------------------------------
library(CellaRepertorium)
library(dplyr)
data("contigs_qc")
cdb = ContigCellDB_10XVDJ(contigs_qc, 
                          contig_pk = c('barcode', 'pop', 'sample', 'contig_id'), 
                          cell_pk = c('barcode', 'pop', 'sample'))

## -----------------------------------------------------------------------------
cdb$contig_tbl$cdr_nt_len = nchar(cdb$contig_tbl$cdr3_nt)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(Biostrings))
cdb = cdb %>% mutate_cdb(cdr3_g_content = alphabetFrequency(DNAStringSet(cdr3_nt))[,'G'], tbl = 'contig_tbl')

head(cdb$contig_tbl, n = 4) %>% 
    select(contig_id, cdr3_nt, cdr_nt_len, cdr3_g_content)

## -----------------------------------------------------------------------------
aa80 = cdhit_ccdb(cdb, 'cdr3', type = 'AA', cluster_pk = 'aa80', 
                  identity = .8, min_length = 5)
aa80 = fine_clustering(aa80, sequence_key = 'cdr3', type = 'AA')

## -----------------------------------------------------------------------------
head(aa80$cluster_tbl)
head(aa80$contig_tbl) %>% select(contig_id, aa80, is_medoid, `d(medoid)`)

## -----------------------------------------------------------------------------
library(ggplot2)

paired_chain = enumerate_pairing(cdb, chain_recode_fun = 'guess')

ggplot(paired_chain, aes(x = interaction(sample, pop), fill = pairing)) + 
    geom_bar() + facet_wrap(~canonical, scale = 'free_x') + 
    coord_flip() + theme_minimal()

## -----------------------------------------------------------------------------
aa80 = canonicalize_cluster(aa80, representative = 'cdr3', 
                            contig_fields = c('cdr3', 'cdr3_nt', 'chain', 'v_gene', 'd_gene', 'j_gene'))
aa80$cluster_pk = 'representative'


## -----------------------------------------------------------------------------
aa80 = rank_chain_ccdb(aa80)

## -----------------------------------------------------------------------------
pairing_list = pairing_tables(aa80, table_order = 2, orphan_level = 1, min_expansion = 3, cluster_keys = c('cdr3', 'representative', 'chain', 'v_gene', 'j_gene', 'avg_distance'))


## ----plot_expanded------------------------------------------------------------
pairs_plt = ggplot(pairing_list$cell_tbl, aes(x = cluster_idx.1_fct, y = cluster_idx.2_fct)) + 
  geom_jitter(aes(color = sample, shape = pop), width = .2, height = .2) + 
  theme_minimal() + xlab('TRB') + ylab('TRA') + 
  theme(axis.text.x = element_text(angle = 45))

pairs_plt = map_axis_labels(pairs_plt, pairing_list$idx1_tbl, pairing_list$idx2_tbl, aes_label  = 'chain')
pairs_plt


## -----------------------------------------------------------------------------
sessionInfo()

