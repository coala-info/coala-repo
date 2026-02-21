# Code example from 'cdr3_clustering' vignette. See references/ for full tutorial.

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
library(purrr)

## -----------------------------------------------------------------------------
data(contigs_qc)
MIN_CDR3_AA = 6


cdb = ContigCellDB_10XVDJ(contigs_qc, contig_pk = c('barcode', 'pop', 'sample', 'contig_id'), cell_pk = c('barcode', 'pop', 'sample'))
cdb

## -----------------------------------------------------------------------------
cdb$contig_tbl = dplyr::filter(cdb$contig_tbl, full_length, productive == 'True', high_confidence, chain != 'Multi', str_length(cdr3) > MIN_CDR3_AA) %>% mutate( fancy_name = fancy_name_contigs(., str_c(pop, '_', sample)))


## -----------------------------------------------------------------------------
aa80 = cdhit_ccdb(cdb, sequence_key = 'cdr3', type = 'AA', cluster_pk = 'aa80', 
                  identity = .8, min_length = 5, G = 1)
aa80 = fine_clustering(aa80, sequence_key = 'cdr3', type = 'AA', keep_clustering_details = TRUE)

## -----------------------------------------------------------------------------
head(aa80$cluster_tbl)
head(aa80$contig_tbl) %>% select(contig_id, aa80, is_medoid, `d(medoid)`)

## -----------------------------------------------------------------------------
cluster_plot(aa80)

## ---- results = 'hide'--------------------------------------------------------
cdb = cdhit_ccdb(cdb, 'cdr3_nt', type = 'DNA', cluster_pk = 'DNA97', identity = .965, min_length = MIN_CDR3_AA*3-1, G = 1)
cdb = fine_clustering(cdb, sequence_key = 'cdr3_nt', type = 'DNA')

cluster_plot(cdb)

## -----------------------------------------------------------------------------
germline_cluster = cluster_germline(cdb, segment_keys = c('v_gene', 'j_gene', 'chain'), cluster_pk = 'segment_idx')

## -----------------------------------------------------------------------------
germline_cluster = fine_clustering(germline_cluster, sequence_key = 'cdr3_nt', type = 'DNA')
ggplot(germline_cluster$cluster_tbl %>% filter(chain == 'TRB'), aes(x = v_gene, y = j_gene, fill = n_cluster)) + geom_tile() + theme(axis.text.x = element_text(angle = 90))

## -----------------------------------------------------------------------------
ggplot(germline_cluster$cluster_tbl %>% filter(chain == 'TRB'), aes(x = v_gene, y = j_gene, fill = avg_distance)) + geom_tile() + theme(axis.text.x = element_text(angle = 90))

## -----------------------------------------------------------------------------
aa80 = canonicalize_cluster(aa80, representative = 'cdr3', contig_fields = c('cdr3', 'cdr3_nt', 'chain', 'v_gene', 'd_gene', 'j_gene'))

## -----------------------------------------------------------------------------
MIN_OLIGO = 7
oligo_clusters = filter(aa80$cluster_tbl, n_cluster >= MIN_OLIGO)
oligo_contigs = aa80
oligo_contigs$contig_tbl = semi_join(oligo_contigs$contig_tbl, oligo_clusters, by = 'aa80')
oligo_contigs

## -----------------------------------------------------------------------------
oligo_clusters = oligo_contigs$contig_tbl %>% group_by(aa80) %>% summarize(`n subjects observed` = length(unique(sample))) %>% left_join(oligo_clusters)

knitr::kable(oligo_clusters %>% select(aa80:cdr3, chain:j_gene, avg_distance, n_cluster))


## -----------------------------------------------------------------------------
oligo_plot = ggplot(oligo_contigs$contig_tbl, aes(x = representative, fill = chain)) + geom_bar() + coord_flip() + scale_fill_brewer(type = 'qual') + theme_minimal()
oligo_plot

## -----------------------------------------------------------------------------
oligo_plot + aes(fill =   sample) + facet_wrap(~pop)


## -----------------------------------------------------------------------------
library(ggdendro)

dendro_plot = function(ccdb, idx, method = 'complete'){
    h = filter(ccdb$cluster_tbl, !!sym(ccdb$cluster_pk) == idx) %>% pull(fc) %>% .[[1]]
    quer = filter(ccdb$contig_tbl, !!sym(ccdb$cluster_pk) == idx)
    hc = hclust(as.dist(h$distance_mat), method = method) %>% dendro_data(type = "rectangle")
    hc$labels = cbind(hc$labels, quer)
   ggplot(hc$segments, aes(x=x, y=y)) + geom_segment(aes(xend=xend, yend=yend)) + 
  theme_classic() + geom_text(data = hc$labels, aes(color = sample, label = fancy_name), size = 3, angle = 60, hjust =0, vjust = 0) + scale_x_continuous(breaks = NULL) + ylab('AA Distance') + xlab('')
}

to_plot = aa80$cluster_tbl %>% filter(min_rank(-n_cluster) == 1)

map(to_plot$aa80, ~ dendro_plot(aa80, .))


## ----  results = 'hide'-------------------------------------------------------
mm_out = cluster_test_by(aa80, fields = 'chain', tbl = 'cluster_tbl', formula = ~ pop + (1|sample), filterset = cluster_filterset(white_list = oligo_clusters)) %>%
  left_join(oligo_clusters)

mm_out = mutate(mm_out, conf.low = estimate-1.96*std.error, 
                conf.high = estimate + 1.96*std.error)


## ----per_iso_tests------------------------------------------------------------
mm_outj = filter(ungroup(mm_out), term == 'popbalbc') %>% arrange(desc(representative))

ggplot(mm_outj, aes(x = representative, ymin = conf.low, ymax = conf.high, y = estimate)) + geom_pointrange()  + coord_flip() + theme_minimal() + geom_hline(yintercept = 0, lty = 2) + xlab("Isomorph") + ylab("log odds of isomorph")

## -----------------------------------------------------------------------------
aa80$contig_tbl = aa80$contig_tbl %>% mutate(cdr3_length = str_length(cdr3_nt))
ggplot(aa80$contig_tbl, aes(fill = pop, x= cdr3_length)) +
  geom_histogram(binwidth = 1, mapping = aes(y = ..density..)) + 
  theme_minimal() + scale_fill_brewer(type = 'qual') + 
  facet_grid(sample ~chain) + theme(strip.text.y = element_text(angle = 0)) + coord_cartesian(xlim = c(25, 55))


## ----cdr3_len, fig.width = 3, fig.height = 3----------------------------------
cdr_len = aa80$contig_tbl %>% group_by(chain) %>% do(broom::tidy(lme4::lmer(cdr3_length ~ pop + (1|sample), data = .), conf.int = TRUE))
ggplot(cdr_len %>% filter(term == 'popbalbc'), aes(x = interaction(chain, term), y = estimate, ymin = conf.low, ymax = conf.high)) + 
  geom_pointrange() + theme_minimal() + coord_flip() + 
  ylab('Length(CDR3 Nt)') + xlab('Term/Chain') + geom_hline(yintercept = 0, lty = 2)


## ----expanded_clones----------------------------------------------------------
aa80$cluster_pk = 'representative'
aa80 = rank_prevalence_ccdb(aa80)
pairing_list = pairing_tables(aa80, table_order = 2, orphan_level = 1, min_expansion = 3, cluster_keys = c('cdr3', 'representative', 'chain', 'v_gene', 'j_gene', 'avg_distance'))



## ----plot_expanded------------------------------------------------------------

pairs_plt = ggplot(pairing_list$cell_tbl, aes(x = cluster_idx.1_fct, y = cluster_idx.2_fct)) + geom_jitter(aes(color = sample, shape = pop), width = .2, height = .2) + theme_minimal() + xlab('TRB') + ylab('TRA') + theme(axis.text.x = element_text(angle = 45))

pairs_plt = map_axis_labels(pairs_plt, pairing_list$idx1_tbl, pairing_list$idx2_tbl, aes_label  = 'chain')
pairs_plt


## -----------------------------------------------------------------------------
whitelist = oligo_clusters %>% dplyr::select(cluster_idx.1 = representative) %>% unique()
pairing_list = pairing_tables(aa80, table_order = 2, orphan_level = 1, min_expansion = Inf, cluster_whitelist = whitelist,  cluster_keys = c('cdr3', 'representative', 'chain', 'v_gene', 'j_gene', 'avg_distance'))

pairs_plt = ggplot(pairing_list$cell_tbl, aes(x = cluster_idx.1_fct, y = cluster_idx.2_fct)) + geom_jitter(aes(color = sample, shape = pop), width = .2, height = .2) + theme_minimal() + xlab('TRB') + ylab('TRA') + theme(axis.text.x = element_text(angle = 45))

pairs_plt = map_axis_labels(pairs_plt, pairing_list$idx1_tbl, pairing_list$idx2_tbl, aes_label  = 'chain')
pairs_plt


## -----------------------------------------------------------------------------
aa80_chain = split_cdb(aa80, 'chain') %>% lapply(canonicalize_cell, contig_fields = 'aa80')

compare_expanded = function(cluster_idx, grp){
  # cluster_idx contains the permuted cluster assignments
  # grp the cell_covariate_keys.
  # NB: this is always a data.frame even if it is just a single column
  # cross tab by pop
  tab = table(cluster_idx, grp[[1]])
  # count number of times an aa80 class was expanded
  expanded = colSums(tab>=2)
  # compare difference
  expanded['b6'] - expanded['balbc']
}

## -----------------------------------------------------------------------------
set.seed(1234)
perm1 = cluster_permute_test(aa80_chain$TRB, cell_covariate_keys = 'pop', cell_label_key = 'aa80', n_perm = 100, statistic = compare_expanded)

perm1

## -----------------------------------------------------------------------------
knitr::kable(table(pop = aa80_chain$TRB$pop))

## -----------------------------------------------------------------------------
rarify = aa80_chain$TRB$cell_tbl %>% group_by(pop) %>% do(slice_sample(., n = 377))

aa80_chain$TRB$cell_tbl = semi_join(aa80_chain$TRB$cell_tbl, rarify)

cluster_permute_test(aa80_chain$TRB, cell_covariate_keys = 'pop', cell_label_key = 'aa80', n_perm = 500, statistic = compare_expanded)

## -----------------------------------------------------------------------------
count_expanded = function(cluster_idx, grp){
  # clusters x sample contigency table
  tab = table(cluster_idx, grp[[1]])
  # number of cluster x samples that occured more than once
  expanded = sum(tab>1)
  expanded
}

perm3 = cluster_permute_test(aa80_chain$TRB,  cell_covariate_keys = 'sample', cell_label_key = 'aa80', n_perm = 500, statistic = count_expanded)
perm3

## -----------------------------------------------------------------------------
cluster_permute_test(aa80_chain$TRB,   cell_covariate_keys = 'sample', cell_stratify_keys = 'pop', cell_label_key = 'aa80', n_perm = 500, statistic = count_expanded)

## -----------------------------------------------------------------------------
sessionInfo()

