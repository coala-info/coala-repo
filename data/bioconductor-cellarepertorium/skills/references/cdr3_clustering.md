# Clustering and differential usage of repertoire CDR3 sequences

Andrew McDavid1\*

1University of Rochester, Department of Biostatistics and Computational Biology

\*Andrew\_McDavid@urmc.rochester.edu

#### 27 October 2020

# Contents

* [1 Load filtered contig files](#load-filtered-contig-files)
* [2 Clustering contigs by sequence characteristics](#clustering-contigs-by-sequence-characteristics)
  + [2.1 Cluster CDR3 DNA sequences](#cluster-cdr3-dna-sequences)
  + [2.2 Cluster by V-J identity](#cluster-by-v-j-identity)
  + [2.3 Expanded clusters](#expanded-clusters)
  + [2.4 Some simple phylogenetic relationships](#some-simple-phylogenetic-relationships)
  + [2.5 Formal testing for frequency differences](#formal-testing-for-frequency-differences)
  + [2.6 Length of CDR3](#length-of-cdr3)
* [3 Clonal pairs](#clonal-pairs)
  + [3.1 Expanded clones](#expanded-clones)
* [4 Permutation tests](#permutation-tests)
* [5 Colophone](#colophone)

In this vignette we demonstrate clustering of 3rd complementary determining region sequence (CDR3) and V-J gene identity of mouse T cells, ways to visualize and explore clusters that are expanded, pairing of alpha-beta clusters, tests of differential CDR3 usage, and permutation tests for overall clonal properties.

```
library(CellaRepertorium)
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
library(purrr)
```

# 1 Load filtered contig files

We begin with a `data.frame` of concatenated contig files (‘all\_contig\_annotations.csv’), output from the Cellranger VDJ pipeline.

```
data(contigs_qc)
MIN_CDR3_AA = 6

cdb = ContigCellDB_10XVDJ(contigs_qc, contig_pk = c('barcode', 'pop', 'sample', 'contig_id'), cell_pk = c('barcode', 'pop', 'sample'))
cdb
#> ContigCellDB of 1508 contigs; 832 cells; and 0 clusters.
#> Contigs keyed by barcode, pop, sample, contig_id; cells keyed by barcode, pop, sample.
```

Initially we start with 832 cells and 1508 contigs. We keep contigs that are

* full - length
* productive
* high-confidence
* only from T cells
* and with CDR3 sufficiently long.

Then we add a descriptive readable name for each contig.

```
cdb$contig_tbl = dplyr::filter(cdb$contig_tbl, full_length, productive == 'True', high_confidence, chain != 'Multi', str_length(cdr3) > MIN_CDR3_AA) %>% mutate( fancy_name = fancy_name_contigs(., str_c(pop, '_', sample)))
```

After filtering, there are 832 cells and 1496 contigs.

# 2 Clustering contigs by sequence characteristics

As a first step to define clonotypes, we will first find equivalence classes of CDR3 sequences with the program [CD-HIT](http://weizhongli-lab.org/cdhit_suite/cgi-bin/index.cgi?cmd=cd-hit). In this case, we use the translated amino acid residues, but often one might prefer to use the DNA sequences, by setting the `sequence_key` accordingly and `type = 'DNA'`. Additionally, a higher identity threshold might be appropriate (see below).

```
aa80 = cdhit_ccdb(cdb, sequence_key = 'cdr3', type = 'AA', cluster_pk = 'aa80',
                  identity = .8, min_length = 5, G = 1)
aa80 = fine_clustering(aa80, sequence_key = 'cdr3', type = 'AA', keep_clustering_details = TRUE)
#> Calculating intradistances on 988 clusters.
#> Summarizing
```

This partitions sequences into sets with >80% mutual similarity in the amino acid sequence, adds some additional information about the clustering, and returns it as a `ContigCellDB` object named `aa80`. The primary key for the clusters is aa80. The `min_length` can be set somewhat smaller, but there is a lower limit for the cdhit algorithm. `G=1`, the default, specifies a global alignment. This is almost always what is desired, but local alignment is available if `G=0`.

```
head(aa80$cluster_tbl)
#> # A tibble: 6 x 4
#>    aa80 avg_distance fc               n_cluster
#>   <dbl>        <dbl> <list>               <int>
#> 1     1            0 <named list [5]>         1
#> 2     2            0 <named list [5]>         1
#> 3     3            0 <named list [5]>         2
#> 4     4            0 <named list [5]>         1
#> 5     5            0 <named list [5]>         1
#> 6     6            0 <named list [5]>         1
head(aa80$contig_tbl) %>% select(contig_id, aa80, is_medoid, `d(medoid)`)
#> # A tibble: 6 x 4
#>   contig_id                    aa80 is_medoid `d(medoid)`
#>   <chr>                       <dbl> <lgl>           <dbl>
#> 1 ATCTACTCAGTATGCT-1_contig_3     1 TRUE                0
#> 2 ACTGTCCTCAATCACG-1_contig_3     2 TRUE                0
#> 3 CACCTTGTCCAATGGT-1_contig_2     3 TRUE                0
#> 4 CACCTTGTCCAATGGT-1_contig_2     3 FALSE               0
#> 5 CGGACGTGTTCATGGT-1_contig_1     4 TRUE                0
#> 6 CTGCTGTTCCCTAATT-1_contig_4     5 TRUE                0
```

The `cluster_tbl` lists the 988 80% identity groups found, including the number of contigs in the cluster, and the average distance between elements in the group.
In the `contig_tbl`, there are two columns specifying if the contig `is_medoid`, that is, is the most representative element of the set and the distance to the medoid element `d(medoid)`.

```
cluster_plot(aa80)
#> Loading required namespace: cowplot
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](data:image/png;base64...)

## 2.1 Cluster CDR3 DNA sequences

```
cdb = cdhit_ccdb(cdb, 'cdr3_nt', type = 'DNA', cluster_pk = 'DNA97', identity = .965, min_length = MIN_CDR3_AA*3-1, G = 1)
cdb = fine_clustering(cdb, sequence_key = 'cdr3_nt', type = 'DNA')
#> Calculating intradistances on 1342 clusters.
#> Summarizing

cluster_plot(cdb)
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](data:image/png;base64...)

We can also cluster by DNA identity.

## 2.2 Cluster by V-J identity

```
germline_cluster = cluster_germline(cdb, segment_keys = c('v_gene', 'j_gene', 'chain'), cluster_pk = 'segment_idx')
#> Warning in replace_cluster_tbl(ccdb, cluster_tbl, cl_con_tbl, cluster_pk =
#> cluster_pk): Replacing `cluster_tbl` with DNA97.
```

We can cluster by any other feature of the contigs. Here we cluster each contig based on the chain and V-J genes. This gives us the set of observed V-J pairings:

```
germline_cluster = fine_clustering(germline_cluster, sequence_key = 'cdr3_nt', type = 'DNA')
#> Calculating intradistances on 700 clusters.
#> Summarizing
#> Warning in left_join_warn(d_medoid, contig_tbl, by = ccdb$contig_pk, overwrite =
#> TRUE): Overwriting fields d(medoid), is_medoid in table contig_tbl
ggplot(germline_cluster$cluster_tbl %>% filter(chain == 'TRB'), aes(x = v_gene, y = j_gene, fill = n_cluster)) + geom_tile() + theme(axis.text.x = element_text(angle = 90))
```

![](data:image/png;base64...)

Number of pairs

```
ggplot(germline_cluster$cluster_tbl %>% filter(chain == 'TRB'), aes(x = v_gene, y = j_gene, fill = avg_distance)) + geom_tile() + theme(axis.text.x = element_text(angle = 90))
```

![](data:image/png;base64...)

Average Levenshtein distance of CDR3 within each pair. This might be turned into a z-score by fitting a weighted linear model with sum-to-zero contrasts and returning the pearson residuals. This could determine if a pairing has an unexpected small, or large, within cluster distance.

## 2.3 Expanded clusters

Next, we will examine the clusters that are found in many contigs. First we will get a canonical contig to represent each cluster. This will be the medoid contig, by default.

```
aa80 = canonicalize_cluster(aa80, representative = 'cdr3', contig_fields = c('cdr3', 'cdr3_nt', 'chain', 'v_gene', 'd_gene', 'j_gene'))
#> Filtering `contig_tbl` by `is_medoid`, override by setting `contig_filter_args == TRUE`
```

`aa80` now includes the fields listed in `contig_fields` in the `cluster_tbl`, using the values found in the medoid contig.

```
MIN_OLIGO = 7
oligo_clusters = filter(aa80$cluster_tbl, n_cluster >= MIN_OLIGO)
oligo_contigs = aa80
oligo_contigs$contig_tbl = semi_join(oligo_contigs$contig_tbl, oligo_clusters, by = 'aa80')
oligo_contigs
#> ContigCellDB of 54 contigs; 832 cells; and 4 clusters.
#> Contigs keyed by barcode, pop, sample, contig_id; cells keyed by barcode, pop, sample.
```

Get contigs/cells/clusters found at least 7 times (across contigs). Note that replacing `contig_tbl` with the subset selected with the `semi_join` also automatically subsetted the `cell_tbl` and `cluster_tbl`.

```
oligo_clusters = oligo_contigs$contig_tbl %>% group_by(aa80) %>% summarize(`n subjects observed` = length(unique(sample))) %>% left_join(oligo_clusters)
#> `summarise()` ungrouping output (override with `.groups` argument)
#> Joining, by = "aa80"

knitr::kable(oligo_clusters %>% select(aa80:cdr3, chain:j_gene, avg_distance, n_cluster))
```

| aa80 | n subjects observed | cdr3 | chain | v\_gene | d\_gene | j\_gene | avg\_distance | n\_cluster |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 111 | 6 | CVVGDRGSALGRLHF | TRA | TRAV11 | None | TRAJ18 | 0.6071429 | 28 |
| 172 | 5 | CAVSRASSGSWQLIF | TRA | TRAV9N-3 | None | TRAJ22 | 2.1111111 | 9 |
| 296 | 6 | CAASASSGSWQLIF | TRA | TRAV14D-2 | None | TRAJ22 | 1.5000000 | 8 |
| 808 | 4 | CATGNYAQGLTF | TRA | TRAV8D-2 | None | TRAJ26 | 1.3333333 | 9 |

Report some statistics about these expanded clusters, such as how often they are found, how many subjects, etc.

```
oligo_plot = ggplot(oligo_contigs$contig_tbl, aes(x = representative, fill = chain)) + geom_bar() + coord_flip() + scale_fill_brewer(type = 'qual') + theme_minimal()
oligo_plot
```

![](data:image/png;base64...)

These always come from a single chain.

```
oligo_plot + aes(fill =   sample) + facet_wrap(~pop)
```

![](data:image/png;base64...)

But come from multiple populations and samples.

## 2.4 Some simple phylogenetic relationships

By using the within-cluster distances, some rudamentory plots attempting to show phylogenetic associations are possible. (These are most biologically appropriate for B cells that undergo somatic hypermutation.)

```
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
#> [[1]]
```

![](data:image/png;base64...)

A full-blown generative model of clonal generation and selection would be recommended for any actual analysis, but these plots may suffice to get a quick idea of the phylogenetic structure.

## 2.5 Formal testing for frequency differences

We can test for differential usage of a clone, or cluster with `cluster_logistic_test` and `cluster_test_by`. The latter splits the `cluster_tbl` by `field = 'chain'`, thereby adjusting the number of cell trials included in the “denominator” of the logistic regression.
The formula tests for differences between populations, including the sample as a random effect, and only tests clusters that are included in the `oligo_clusters` set.

```
mm_out = cluster_test_by(aa80, fields = 'chain', tbl = 'cluster_tbl', formula = ~ pop + (1|sample), filterset = cluster_filterset(white_list = oligo_clusters)) %>%
  left_join(oligo_clusters)
#> Fitting mixed logistic models to 4 clusters.
#> Loading required namespace: broom
#> Loading required namespace: lme4
#> Loading required namespace: broom.mixed
#> Registered S3 method overwritten by 'broom.mixed':
#>   method      from
#>   tidy.gamlss broom
#> boundary (singular) fit: see ?isSingular
#> boundary (singular) fit: see ?isSingular
#> boundary (singular) fit: see ?isSingular
#> Fitting mixed logistic models to 0 clusters.
#> Joining, by = c("chain", "aa80")

mm_out = mutate(mm_out, conf.low = estimate-1.96*std.error,
                conf.high = estimate + 1.96*std.error)
```

```
mm_outj = filter(ungroup(mm_out), term == 'popbalbc') %>% arrange(desc(representative))

ggplot(mm_outj, aes(x = representative, ymin = conf.low, ymax = conf.high, y = estimate)) + geom_pointrange()  + coord_flip() + theme_minimal() + geom_hline(yintercept = 0, lty = 2) + xlab("Isomorph") + ylab("log odds of isomorph")
```

![](data:image/png;base64...)

We test if the binomial rate of clone expression differs between balbc and b6, for the selected clones. None appear to be different.

## 2.6 Length of CDR3

```
aa80$contig_tbl = aa80$contig_tbl %>% mutate(cdr3_length = str_length(cdr3_nt))
ggplot(aa80$contig_tbl, aes(fill = pop, x= cdr3_length)) +
  geom_histogram(binwidth = 1, mapping = aes(y = ..density..)) +
  theme_minimal() + scale_fill_brewer(type = 'qual') +
  facet_grid(sample ~chain) + theme(strip.text.y = element_text(angle = 0)) + coord_cartesian(xlim = c(25, 55))
```

![](data:image/png;base64...)

Some authors have noted that the length of the CDR3 region can be predictive of T cell differentiation. In our study, there doesn’t appear to be a noticeable difference between BALB/c and C57BL/6J (b6) mice, but if we needed to make sure, an appropriate procedure would be to run a mixed model with a random `sample` effect (assumed to represent a biological replicate).

```
cdr_len = aa80$contig_tbl %>% group_by(chain) %>% do(broom::tidy(lme4::lmer(cdr3_length ~ pop + (1|sample), data = .), conf.int = TRUE))
#> boundary (singular) fit: see ?isSingular
#> boundary (singular) fit: see ?isSingular
ggplot(cdr_len %>% filter(term == 'popbalbc'), aes(x = interaction(chain, term), y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_pointrange() + theme_minimal() + coord_flip() +
  ylab('Length(CDR3 Nt)') + xlab('Term/Chain') + geom_hline(yintercept = 0, lty = 2)
```

![](data:image/png;base64...)

We end up with a (harmless) convergence warning about a singular fit. This is expected, because the `samples` aren’t actually replicates – they are just subsamples drawn for illustrative purposes.
The Balbc mice have .5 fewer nucleotides per contig, on average, and this is not significant.

# 3 Clonal pairs

Next, we can examine the pairing between \(\alpha-\beta\) chains and see if any pairs are found more than once.

```
aa80$cluster_pk = 'representative'
aa80 = rank_prevalence_ccdb(aa80)
pairing_list = pairing_tables(aa80, table_order = 2, orphan_level = 1, min_expansion = 3, cluster_keys = c('cdr3', 'representative', 'chain', 'v_gene', 'j_gene', 'avg_distance'))
```

`pairing_tables` finds all contig combinations of order `table_order` across cells. Among those combinations that occur at least `min_expansion` times, the expanded combinations and and any other combinations that shared an expanded combo.

```
pairs_plt = ggplot(pairing_list$cell_tbl, aes(x = cluster_idx.1_fct, y = cluster_idx.2_fct)) + geom_jitter(aes(color = sample, shape = pop), width = .2, height = .2) + theme_minimal() + xlab('TRB') + ylab('TRA') + theme(axis.text.x = element_text(angle = 45))

pairs_plt = map_axis_labels(pairs_plt, pairing_list$idx1_tbl, pairing_list$idx2_tbl, aes_label  = 'chain')
pairs_plt
```

![](data:image/png;base64...)

## 3.1 Expanded clones

```
whitelist = oligo_clusters %>% dplyr::select(cluster_idx.1 = representative) %>% unique()
pairing_list = pairing_tables(aa80, table_order = 2, orphan_level = 1, min_expansion = Inf, cluster_whitelist = whitelist,  cluster_keys = c('cdr3', 'representative', 'chain', 'v_gene', 'j_gene', 'avg_distance'))

pairs_plt = ggplot(pairing_list$cell_tbl, aes(x = cluster_idx.1_fct, y = cluster_idx.2_fct)) + geom_jitter(aes(color = sample, shape = pop), width = .2, height = .2) + theme_minimal() + xlab('TRB') + ylab('TRA') + theme(axis.text.x = element_text(angle = 45))

pairs_plt = map_axis_labels(pairs_plt, pairing_list$idx1_tbl, pairing_list$idx2_tbl, aes_label  = 'chain')
pairs_plt
```

![](data:image/png;base64...)

By setting `min_expansion = Inf, cluster_whitelist = whitelist` we can examine any pairings for a set of cluster\_idx, in this case the ones that were seen multiple times. Interestingly (and unlike some human samples) the expanded clusters are \(\beta\)-chain, and their \(\alpha\) chains are sprinkled quite evenly across clusters.

# 4 Permutation tests

Permutation tests allow tests of independence between cluster assignments and other cell-level covariates (such as the sample from which the cell was derived). The cluster label is permuted to break the link between cell and cluster, and an arbitrary statistic of both cluster label, and cell covariate is evaluated.

```
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
```

The signature of the statistic should be of a vector `cluster_idx` and `data.frame`.

```
set.seed(1234)
perm1 = cluster_permute_test(aa80_chain$TRB, cell_covariate_keys = 'pop', cell_label_key = 'aa80', n_perm = 100, statistic = compare_expanded)

perm1
#> $observed
#> b6
#>  5
#>
#> $expected
#> [1] 4.92
#>
#> $p.value
#> [1] 0.86
#>
#> $mc.se
#> [1] 0.7172732
```

Although b6 mice had 5 more clones observed to be expanded (occuring >=2 times) than balbc, this is not signficant under a null model where cells were permuted between mouse types (populations), where b6 are expected to have about 5 more expanded clones, just due to the additional number of cells sampled in b6 and the particular spectrum of clonal frequencies in this experiment:

```
knitr::kable(table(pop = aa80_chain$TRB$pop))
```

| pop | Freq |
| --- | --- |
| b6 | 398 |
| balbc | 377 |

Indeed if we resample in a way that fixes each group to have the same number of cells:

```
rarify = aa80_chain$TRB$cell_tbl %>% group_by(pop) %>% do(slice_sample(., n = 377))

aa80_chain$TRB$cell_tbl = semi_join(aa80_chain$TRB$cell_tbl, rarify)
#> Joining, by = c("aa80", "barcode", "pop", "sample")

cluster_permute_test(aa80_chain$TRB, cell_covariate_keys = 'pop', cell_label_key = 'aa80', n_perm = 500, statistic = compare_expanded)
#> $observed
#> b6
#> -1
#>
#> $expected
#> [1] 0.726
#>
#> $p.value
#> [1] 0.74
#>
#> $mc.se
#> [1] 0.3024381
```

We see that this discrepacy between the number of expanded clones between subpopulations is mostly explained by a greater number of cells sampled in b6, but also random variability plays a role.

We can also test for oligoclonality, eg, how often is a beta chain expanded in a sample:

```
count_expanded = function(cluster_idx, grp){
  # clusters x sample contigency table
  tab = table(cluster_idx, grp[[1]])
  # number of cluster x samples that occured more than once
  expanded = sum(tab>1)
  expanded
}

perm3 = cluster_permute_test(aa80_chain$TRB,  cell_covariate_keys = 'sample', cell_label_key = 'aa80', n_perm = 500, statistic = count_expanded)
perm3
#> $observed
#> [1] 27
#>
#> $expected
#> [1] 37.046
#>
#> $p.value
#> [1] 0.032
#>
#> $mc.se
#> [1] 0.1999593
```

27 expanded clones were observed in each of the two populations vs 37 expected, and this discrepancy would be significant at \(p<\) 0.04. This is indicating that there is underdispersion – fewer clusters are expanded than expected, given the spectrum of clonal frequencies and the number of cells per sample.

To further elucidate this, we can restrict the permutations to maintain certain margins of the table by specifying `cell_stratify_keys.` This doesn’t effect the observed values of the statistics, but will change the expected values (since these are now conditional expectations.) Here we restrict the permutations within levels of `pop` (eg, only permuting within balbc, and within b6).

```
cluster_permute_test(aa80_chain$TRB,   cell_covariate_keys = 'sample', cell_stratify_keys = 'pop', cell_label_key = 'aa80', n_perm = 500, statistic = count_expanded)
#> $observed
#> [1] 27
#>
#> $expected
#> [1] 44.652
#>
#> $p.value
#> [1] 0.002
#>
#> $mc.se
#> [1] 0.1967007
```

In the restricted permutations, the expected number of expanded clusters is even greater. Both of these effects are due to the fact that the “sample” replicates, within each population actually are not biological replicates, which inflates the `cluster_idx` margin of the table.

# 5 Colophone

```
sessionInfo()
#> R version 4.0.3 (2020-10-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ggdendro_0.1.22        purrr_0.3.4            stringr_1.4.0
#> [4] tidyr_1.1.2            readr_1.4.0            ggplot2_3.3.2
#> [7] dplyr_1.0.2            CellaRepertorium_1.0.0 BiocStyle_2.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] splines_4.0.3       assertthat_0.2.1    statmod_1.4.35
#>  [4] BiocManager_1.30.10 highr_0.8           stats4_4.0.3
#>  [7] broom.mixed_0.2.6   yaml_2.2.1          progress_1.2.2
#> [10] pillar_1.4.6        backports_1.1.10    lattice_0.20-41
#> [13] glue_1.4.2          digest_0.6.27       RColorBrewer_1.1-2
#> [16] XVector_0.30.0      minqa_1.2.4         colorspace_1.4-1
#> [19] cowplot_1.1.0       htmltools_0.5.0     Matrix_1.2-18
#> [22] plyr_1.8.6          pkgconfig_2.0.3     broom_0.7.2
#> [25] magick_2.5.0        bookdown_0.21       zlibbioc_1.36.0
#> [28] scales_1.1.1        lme4_1.1-25         tibble_3.0.4
#> [31] generics_0.0.2      farver_2.0.3        IRanges_2.24.0
#> [34] ellipsis_0.3.1      withr_2.3.0         BiocGenerics_0.36.0
#> [37] TMB_1.7.18          cli_2.1.0           magrittr_1.5
#> [40] crayon_1.3.4        evaluate_0.14       fansi_0.4.1
#> [43] nlme_3.1-150        MASS_7.3-53         forcats_0.5.0
#> [46] tools_4.0.3         prettyunits_1.1.1   hms_0.5.3
#> [49] lifecycle_0.2.0     S4Vectors_0.28.0    munsell_0.5.0
#> [52] Biostrings_2.58.0   compiler_4.0.3      rlang_0.4.8
#> [55] grid_4.0.3          nloptr_1.2.2.2      labeling_0.4.2
#> [58] rmarkdown_2.5       boot_1.3-25         gtable_0.3.0
#> [61] reshape2_1.4.4      R6_2.4.1            knitr_1.30
#> [64] utf8_1.1.4          stringi_1.5.3       parallel_4.0.3
#> [67] Rcpp_1.0.5          vctrs_0.3.4         tidyselect_1.1.0
#> [70] xfun_0.18           coda_0.19-4
```