# Clone ID with cardelino

Davis McCarthy1,2 and Yuanhua Huang1,3

1EMBL-EBI, Hinxton, UK
2St Vincent's Institute of Medical Research, Melbourne, Australia
3University of Hong Kong, Hong Kong

#### 30 October 2025

#### Package

cardelino 1.12.0

# Contents

* [1 Introduction](#introduction)
* [2 Clone ID with a clonal tree provided](#clone-id-with-a-clonal-tree-provided)
* [3 Clone ID without input clonal tree](#clone-id-without-input-clonal-tree)
  + [3.1 Clone ID on mitochondrial variations](#clone-id-on-mitochondrial-variations)
* [Session information](#session-information)

# 1 Introduction

This document gives an introduction to and overview of inferring the **clone** identity of cells using the *[cardelino](https://bioconductor.org/packages/3.22/cardelino)* package using a given clonal structure.

*[cardelino](https://bioconductor.org/packages/3.22/cardelino)* can use variant information extracted from single-cell RNA-seq reads to probabilistically assign single-cell transcriptomes to individual clones.

Briefly, *[cardelino](https://bioconductor.org/packages/3.22/cardelino)* is based on a Bayesian mixture model with a beta-binomial error model to account for sequencing errors as well as a gene-specific model for allelic imbalance between haplotypes and associated bias in variant detection. Bayesian inference allows the model to account for uncertainty in model parameters and cell assignments.

We assume that clones are tagged by somatic mutations, and that these mutations are known (e.g. from exome sequencing or equivalent). Given a set of known mutations, these sites can be interrogated in scRNA-seq reads to obtain evidence for the presence or absence of each mutation in each cell. As input, the model requires the count of reads supporting the alternative (mutant) allele at each mutation site, the total number of reads overlapping the mutation site (“coverage”).

Typically, coverage of somatic mutations in scRNA-seq data is very sparse (most mutation sites in a given cell have no read coverage), but the *[cardelino](https://bioconductor.org/packages/3.22/cardelino)* model accounts for this sparsity and aggregates information across all available mutation sites to infer clonal identity.

# 2 Clone ID with a clonal tree provided

In many clone ID scenarios, a clonal tree is known. That is, we have been able to infer the clones present in the sampled cell population, for example using bulk or single-cell DNA-seq data, and we know which mutations are expected to be present in which clones.

To infer the clonal identity of cells when a clonal tree is provided, *[cardelino](https://bioconductor.org/packages/3.22/cardelino)* requires the following input data:

* A: a variant x cell matrix of integer counts, providing the number of reads supporting the alternative allele for each variant in each cell;
* D: a variant x cell matrix of integer counts, providing the total number of reads overlapping each variant in each cell;
* Config: a variant x clone “configuration” matrix of binary values providing the clone-variant configuration by indicating which mutations are expected to be present in which clones.

The configuration matrix, Config, can be provided by other tools used to infer the clonal structure of the cell population. For example, the package *[Canopy](https://CRAN.R-project.org/package%3DCanopy)* can be used to infer a clonal tree from DNA-seq data and the “Z” element of its output is the configuration matrix.

Here, we demonstrate the use of *[cardelino](https://bioconductor.org/packages/3.22/cardelino)* to assign 77 cells to clones identified with *[Canopy](https://CRAN.R-project.org/package%3DCanopy)* using 112 somatic mutations.

We load the package and the example clone ID dataset distributed with the package in VCF ([variant call format](https://github.com/samtools/hts-specs)) format, which is mostly used for storing genotype data. Here, the `cellSNP.cells.vcf.gz` is computed by using [cellsnp-lite](https://cellsnp-lite.readthedocs.io) on a list pre-identified somatic variants from bulk WES.

```
library(ggplot2)
library(cardelino)
```

There are many possible ways to extract the data required by `cardelino` from a VCF file, here we show just one approach using convenience functions in `cardelino`:

```
vcf_file <- system.file("extdata", "cellSNP.cells.vcf.gz",
                        package = "cardelino")
input_data <- load_cellSNP_vcf(vcf_file)
```

```
## Scanning file to determine attributes.
## File attributes:
##   meta lines: 37
##   header_line: 38
##   variant count: 112
##   column count: 86
##
Meta line 37 read in.
## All meta lines processed.
## gt matrix initialized.
## Character matrix gt created.
##   Character matrix gt rows: 112
##   Character matrix gt cols: 86
##   skip: 0
##   nrows: 112
##   row_num: 0
##
Processed variant: 112
## All variants processed
## [1] "112 out of 112 SNPs passed."
```

Alternatively you can load the `A` and `D` matrices yourself and combine them into a list, for example `input_data = list('A' = A, 'D' = D)`.

We can visualize the allele frequency of the mutation allele. As expected, the majority of entries are missing (in grey) due to the high sparsity in scRNA-seq data. For the same reason, even for the non-missing entries, the estimate of allele frequency is of high uncertainty. For this reason, it is crucial to probabilistic clustering with accounting the uncertainty, ideally with guide clonal tree structure from external data.

```
AF <- as.matrix(input_data$A / input_data$D)

p = pheatmap::pheatmap(AF, cluster_rows=FALSE, cluster_cols=FALSE,
                   show_rownames = TRUE, show_colnames = TRUE,
                   labels_row='77 cells', labels_col='112 SNVs',
                   angle_col=0, angle_row=0)
```

![](data:image/png;base64...)

Next, we will load the Canopy tree results for the same individual. The clonal tree inferred by Canopy for this donor consists of three clones, including a “base” clone (“clone1”) that has no subclonal somatic mutations present.

```
canopy_res <- readRDS(system.file("extdata", "canopy_results.coveraged.rds",
                                  package = "cardelino"))
Config <- canopy_res$tree$Z
```

Be careful to ensure that the same variant IDs are used in both data sources.

```
rownames(Config) <- gsub(":", "_", rownames(Config))
```

We can visualize the clonal tree structure obtained from `Canopy`:

```
plot_tree(canopy_res$tree, orient = "v")
```

![](data:image/png;base64...)

The included dataset contains the A and D matrices, so combined with the Canopy tree object provided, we have the necessary input to probabilistically assign cells to clones. Note, `min_iter = 800, max_iter = 1200` is used only for quick illustration. Please remove them for the default values or set higher number of iterations to ensure convergence of the Gibbs sampling. Convergence is checked automatically in `clone_id()`, using the Geweke z-statistic.

```
set.seed(7)
assignments <- clone_id(input_data$A, input_data$D, Config = Config,
                        min_iter = 800, max_iter = 1200)
```

```
## 100% converged.
## [1] "Converged in 800 iterations."
## DIC: 1398.26 D_mean: 1232.3 D_post: 1201.67 logLik_var: 49.15
```

```
names(assignments)
```

```
##  [1] "theta0"         "theta1"         "theta0_all"     "theta1_all"
##  [5] "element"        "logLik"         "prob_all"       "prob"
##  [9] "prob_variant"   "relax_rate"     "Config_prob"    "Config_all"
## [13] "relax_rate_all" "DIC"            "n_chain"
```

We can visualise the cell-clone assignment probabilities as a heatmap.

```
prob_heatmap(assignments$prob)
```

![](data:image/png;base64...)

We recommend assigning a cell to the highest-probability clone if the highest posterior probability is greater than 0.5 and leaving cells “unassigned” if they do not reach this threshold. The `assign_cells_to_clones` function conveniently assigns cells to clones based on a threshold and returns a data.frame with the cell-clone assignments.

```
df <- assign_cells_to_clones(assignments$prob)
head(df)
```

```
##         cell  clone  prob_max
## 1 ERR2806034 clone2 1.0000000
## 2 ERR2806035 clone1 0.9999962
## 3 ERR2806036 clone1 0.9998902
## 4 ERR2806037 clone1 0.9996968
## 5 ERR2806038 clone1 0.9999999
## 6 ERR2806039 clone2 1.0000000
```

```
table(df$clone)
```

```
##
##     clone1     clone2     clone3 unassigned
##         44         24          7          2
```

Also, Cardelino will update the guide clonal tree Config matrix (as a prior) and return a posterior estimate. In the figure below, negative value means the probability of a certain variant presents in a certain clone is reduced in posterior compared to prior (i.e., the input Config). Vice verse for the positive values.

```
heat_matrix(t(assignments$Config_prob - Config)) +
  scale_fill_gradient2() +
  ggtitle('Changes of clonal Config') +
  labs(x='Clones', y='112 SNVs') +
  theme(axis.text.y = element_blank(), legend.position = "right")
```

![](data:image/png;base64...)

Finally, we can visualize the results cell assignment and updated mutations clonal configuration at the raw allele frequency matrix:

```
AF <- as.matrix(input_data$A / input_data$D)
cardelino::vc_heatmap(AF, assignments$prob, Config, show_legend=TRUE)
```

![](data:image/png;base64...)

# 3 Clone ID without input clonal tree

As shown above, the Config can be updated by the observations from scRNA-seq data. A step further is to not including the Config entirely. This can be possible, as there could be no clonal tree available. In this case, you can use cardelino in its de-novo by set `Config=NULL` and set a number for `n_clones`. Note, by default we will keep the first clone as base clone, i.e., no mutations. You can turn it off by set `keep_base_clone=FALSE`.

```
assignments <- clone_id(input_data$A, input_data$D, Config=NULL, n_clone = 3)
```

## 3.1 Clone ID on mitochondrial variations

As an further illustration, we will show how cardelino can be used to infer the clonal structure from mitochondrial variations, that called from [MQuad](https://github.com/single-cell-genetics/MQuad). Again, we have included the MQuad output in `.mtx` format in the cardelino package. Note, this mitochondrial data is from the same SMART-seq data set above.

First, let’s import these two AD and DP matrices and together with their variant names.

```
AD_file <- system.file("extdata", "passed_ad.mtx", package = "cardelino")
DP_file <- system.file("extdata", "passed_dp.mtx", package = "cardelino")
id_file <- system.file("extdata", "passed_variant_names.txt",
                       package = "cardelino")

AD <- Matrix::readMM(AD_file)
DP <- Matrix::readMM(DP_file)
var_ids <- read.table(id_file, )
rownames(AD) <- rownames(DP) <- var_ids[, 1]
colnames(AD) <- colnames(DP) <- paste0('Cell', seq(ncol(DP)))
```

Same as above, AD and DP are matrices with variants as rows and cells as column. In this case we have 25 variants (rows) and 77 cells (columns). As expected, the coverage of mtDNA is a lot higher than the nuclear genome above (much fewer missing values).

```
AF_mt <- as.matrix(AD / DP)
pheatmap::pheatmap(AF_mt)
```

![](data:image/png;base64...)

Now, we can run cardelino on the mitochondrial variations. Note, as there is no prior clonal tree, the model is easier to return a local optima. Generally, we recommend running it multiple time (with different random seed or initializations) and pick the one with highest DIC.

```
set.seed(7)
assign_mtClones <- clone_id(AD, DP, Config=NULL, n_clone = 3,
                            keep_base_clone=FALSE)
```

```
## Config is NULL: de-novo mode is in use.
```

```
## 100% converged.
## [1] "Converged in 5000 iterations."
## DIC: NaN D_mean: Inf D_post: Inf logLik_var: NaN
```

Then visualise allele frequency along with the clustering of cells and variants:

```
Config_mt <- assign_mtClones$Config_prob
Config_mt[Config_mt >= 0.5] = 1
Config_mt[Config_mt <  0.5] = 0
cardelino::vc_heatmap(AF_mt, assign_mtClones$prob, Config_mt, show_legend=TRUE)
```

![](data:image/png;base64...)

# Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] cardelino_1.12.0 ggplot2_4.0.0    knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] permute_0.9-8               rlang_1.1.6
##   [5] magrittr_2.0.4              vcfR_1.15.0
##   [7] matrixStats_1.5.0           compiler_4.5.1
##   [9] RSQLite_2.4.3               mgcv_1.9-3
##  [11] GenomicFeatures_1.62.0      systemfonts_1.3.1
##  [13] png_0.1-8                   vctrs_0.6.5
##  [15] combinat_0.0-8              memuse_4.2-3
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] XVector_0.50.0              labeling_0.4.3
##  [23] Rsamtools_2.26.0            rmarkdown_2.30
##  [25] UCSC.utils_1.6.0            tinytex_0.57
##  [27] purrr_1.1.0                 bit_4.6.0
##  [29] xfun_0.54                   cachem_1.1.0
##  [31] cigarillo_1.0.0             aplot_0.2.9
##  [33] GenomeInfoDb_1.46.0         jsonlite_2.0.0
##  [35] blob_1.2.4                  DelayedArray_0.36.0
##  [37] BiocParallel_1.44.0         cluster_2.1.8.1
##  [39] parallel_4.5.1              R6_2.6.1
##  [41] VariantAnnotation_1.56.0    bslib_0.9.0
##  [43] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [45] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [47] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [49] bookdown_0.45               SummarizedExperiment_1.40.0
##  [51] IRanges_2.44.0              Matrix_1.7-4
##  [53] splines_4.5.1               tidyselect_1.2.1
##  [55] dichromat_2.0-0.1           abind_1.4-8
##  [57] yaml_2.3.10                 vegan_2.7-2
##  [59] codetools_0.2-20            curl_7.0.0
##  [61] lattice_0.22-7              tibble_3.3.0
##  [63] treeio_1.34.0               Biobase_2.70.0
##  [65] withr_3.0.2                 KEGGREST_1.50.0
##  [67] S7_0.2.0                    evaluate_1.0.5
##  [69] pinfsc50_1.3.0              gridGraphics_0.5-1
##  [71] survival_3.8-3              snpStats_1.60.0
##  [73] Biostrings_2.78.0           pillar_1.11.1
##  [75] BiocManager_1.30.26         ggtree_4.0.1
##  [77] MatrixGenerics_1.22.0       stats4_4.5.1
##  [79] ggfun_0.2.0                 generics_0.1.4
##  [81] RCurl_1.98-1.17             S4Vectors_0.48.0
##  [83] scales_1.4.0                tidytree_0.4.6
##  [85] glue_1.8.0                  gdtools_0.4.4
##  [87] pheatmap_1.0.13             lazyeval_0.2.2
##  [89] tools_4.5.1                 BiocIO_1.20.0
##  [91] BSgenome_1.78.0             GenomicAlignments_1.46.0
##  [93] ggiraph_0.9.2               fs_1.6.6
##  [95] XML_3.99-0.19               grid_4.5.1
##  [97] tidyr_1.3.1                 ape_5.8-1
##  [99] AnnotationDbi_1.72.0        patchwork_1.3.2
## [101] nlme_3.1-168                restfulr_0.0.16
## [103] cli_3.6.5                   rappdirs_0.3.3
## [105] fontBitstreamVera_0.1.1     viridisLite_0.4.2
## [107] S4Arrays_1.10.0             dplyr_1.1.4
## [109] gtable_0.3.6                yulab.utils_0.2.1
## [111] fontquiver_0.2.1            sass_0.4.10
## [113] digest_0.6.37               BiocGenerics_0.56.0
## [115] ggplotify_0.1.3             SparseArray_1.10.0
## [117] htmlwidgets_1.6.4           rjson_0.2.23
## [119] farver_2.1.2                memoise_2.0.1
## [121] htmltools_0.5.8.1           lifecycle_1.0.4
## [123] httr_1.4.7                  MASS_7.3-65
## [125] fontLiberation_0.1.0        bit64_4.6.0-1
```