# lefser: a metagenomic biomarker discovery tool

Asya Khleborodova, Sehyun Oh, Ludwig Geistlinger, and Levi Waldron

#### 2025-11-14

# Contents

* [1 Overview](#overview)
  + [1.1 Background](#background)
  + [1.2 Install and load pacakge](#install-and-load-pacakge)
  + [1.3 Citing *lefser*](#citing-lefser)
* [2 Analysis example](#analysis-example)
  + [2.1 Prepare input](#prepare-input)
  + [2.2 Run `lefser`](#run-lefser)
  + [2.3 Visualization using `lefserPlot`](#visualization-using-lefserplot)
* [3 Benchmarking againt other tools](#benchmarking-againt-other-tools)
* [4 Interoperating with phyloseq](#interoperating-with-phyloseq)
* [5 Session Info](#session-info)

# 1 Overview

## 1.1 Background

*lefser* is the R implementation of the Linear discriminant analysis (LDA)
Effect Size ([LEfSe](https://huttenhower.sph.harvard.edu/galaxy/)), a Python package for metagenomic biomarker discovery
and explanation. ([Huttenhower et al. 2011](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3218848/)).

The original software utilizes standard statistical significance tests along
with supplementary tests that incorporate biological consistency and the
relevance of effects to identity the features (e.g., organisms, clades, OTU,
genes, or functions) that are most likely to account for differences between
the two sample classes of interest. While *LEfSe* is widely used and available
in different platform such as Galaxy UI and Conda, there is no convenient way
to incorporate it in R-based workflows. Thus, we re-implement *LEfSe* as
an R/Bioconductor package, *lefser*. Following the *LEfSe*‘s algorithm including
Kruskal-Wallis test, Wilcoxon-Rank Sum test, and Linear Discriminant Analysis,
with some modifications, *lefser* successfully reproduces and improves the
original statistical method and the associated plotting functionality.

## 1.2 Install and load pacakge

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("lefser")
```

```
library(lefser)
```

## 1.3 Citing *lefser*

Your citations are crucial in keeping our software free and open source. To
cite our package, please use this publication at the link [here](https://doi.org/10.1093/bioinformatics/btae707).

# 2 Analysis example

## 2.1 Prepare input

*lefser* package include the demo dataset, `zeller14`, which is the
microbiome data from colorectal cancer (CRC) patients and controls
([Zeller et al. 2014](https://www.embopress.org/doi/full/10.15252/msb.20145645)).

In this vignette, we excluded the ‘adenoma’ condition and used control/CRC
as the main classes and age category as sub-classes (adult vs. senior) with
different numbers of samples: control-adult (n = 46), control-senior (n = 20),
CRC-adult (n = 45), and CRC-senior (n = 46).

```
data(zeller14)
zeller14 <- zeller14[, zeller14$study_condition != "adenoma"]
```

The class and subclass information is stored in the `colData` slot under the
`study_condition` and `age_category` columns, respectively.

```
## Contingency table
table(zeller14$age_category, zeller14$study_condition)
```

```
#>
#>          CRC control
#>   adult   45      46
#>   senior  46      20
```

If you try to run `lefser` directly on the ‘zeller14’ data, you will get the
following warning messages

```
lefser(zeller14, classCol = "study_condition", subclassCol = "age_category")
```

```
Warning messages:
1: In lefser(zeller14, classCol = "study_condition", subclassCol = "age_category") :
  Convert counts to relative abundances with 'relativeAb()'
2: In lda.default(x, classing, ...) : variables are collinear
```

### 2.1.1 Terminal node

When working with taxonomic data, including both terminal and non-terminal
nodes in the analysis can lead to collinearity problems. Non-terminal nodes
(e.g., genus) are often linearly dependent on their corresponding terminal
nodes (e.g., species) since the species-level information is essentially a
subset or more specific representation of the genus-level information. This
collinearity can violate the assumptions of certain statistical methods, such
as linear discriminant analysis (LDA), and can lead to unstable or unreliable
results. By using only terminal nodes, you can effectively eliminate this
collinearity issue, ensuring that your analysis is not affected by linearly
dependent or highly correlated variables. Additionally, you can benefit of
avoiding redundancy, increasing specificity, simplifying data, and reducing
ambiguity, using only terminal nodes.

You can select only the terminal node using `get_terminal_nodes` function.

```
tn <- get_terminal_nodes(rownames(zeller14))
zeller14tn <- zeller14[tn,]
```

### 2.1.2 Relative abundance

First warning message informs you that `lefser` requires relative abundance of
features. You can use `relativeAb` function to reformat your input.

```
zeller14tn_ra <- relativeAb(zeller14tn)
```

## 2.2 Run `lefser`

The `lefser` function returns a `data.frame` with two columns - the names of
selected features (the `features` column) and their effect size (the `scores`
column).

There is a random number generation step in the `lefser` algorithm to ensure
that more than half of the values for each features are unique. In most cases,
inputs are sparse, so in practice, this step is handling 0s. So to reproduce
the identical result, you should set the seed before running `lefser`.

```
set.seed(1234)
res <- lefser(zeller14tn_ra, # relative abundance only with terminal nodes
              classCol = "study_condition",
              subclassCol = "age_category")
head(res)
```

```
#>                                                                                                                                                                             features
#> 1                                                        k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales|f__Oscillospiraceae|g__Oscillibacter|s__Oscillibacter_unclassified
#> 2                            k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales|f__Peptostreptococcaceae|g__Peptostreptococcus|s__Peptostreptococcus_stomatis|t__GCF_000147675
#> 3 k__Bacteria|p__Bacteroidetes|c__Bacteroidia|o__Bacteroidales|f__Porphyromonadaceae|g__Porphyromonas|s__Porphyromonas_asaccharolytica|t__Porphyromonas_asaccharolytica_unclassified
#> 4                           k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales|f__Clostridiaceae|g__Clostridium|s__Clostridium_symbiosum|t__Clostridium_symbiosum_unclassified
#> 5                                                         k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales|f__Bacillales_noname|g__Gemella|s__Gemella_morbillorum|t__GCF_000185645
#> 6            k__Bacteria|p__Fusobacteria|c__Fusobacteriia|o__Fusobacteriales|f__Fusobacteriaceae|g__Fusobacterium|s__Fusobacterium_nucleatum|t__Fusobacterium_nucleatum_unclassified
#>      scores
#> 1 -3.336133
#> 2 -2.941073
#> 3 -2.834037
#> 4 -2.705037
#> 5 -2.578961
#> 6 -2.431613
```

## 2.3 Visualization using `lefserPlot`

```
lefserPlot(res)
```

![](data:image/png;base64...)

# 3 Benchmarking againt other tools

The codes for benchmarking *lefser* against *LEfSe* and the other R
implementation of *LEfSe* is available [here](https://github.com/shbrief/lefserBenchmarking).

# 4 Interoperating with phyloseq

When using `phyloseq` objects, we recommend to extract the data and create a
`SummarizedExperiment` object as follows:

```
library(phyloseq)
library(SummarizedExperiment)

## Load phyloseq object
fp <- system.file("extdata",
                  "study_1457_split_library_seqs_and_mapping.zip",
                  package = "phyloseq")
kostic <- microbio_me_qiime(fp)
```

```
#> Found biom-format file, now parsing it...
#> Done parsing biom...
#> Importing Sample Metdadata from mapping file...
#> Merging the imported objects...
#> Successfully merged, phyloseq-class created.
#>  Returning...
```

```
## Split data tables
counts <- unclass(otu_table(kostic))
coldata <- as(sample_data(kostic), "data.frame")

## Create a SummarizedExperiment object
SummarizedExperiment(assays = list(counts = counts), colData = coldata)
```

```
#> class: SummarizedExperiment
#> dim: 2505 190
#> metadata(0):
#> assays(1): counts
#> rownames(2505): 304309 469478 ... 206906 298806
#> rowData names(0):
#> colnames(190): C0333.N.518126 C0333.T.518046 ... 32I9UNA9.518098
#>   BFJMKNMP.518102
#> colData names(71): X.SampleID BarcodeSequence ... HOST_TAXID
#>   Description
```

You may also consider using `makeTreeSummarizedExperimentFromPhyloseq` from
the `mia` package.

```
mia::makeTreeSummarizedExperimentFromPhyloseq(kostic)
```

```
#> class: TreeSummarizedExperiment
#> dim: 2505 190
#> metadata(0):
#> assays(1): counts
#> rownames(2505): 304309 469478 ... 206906 298806
#> rowData names(7): Kingdom Phylum ... Genus Species
#> colnames(190): C0333.N.518126 C0333.T.518046 ... 32I9UNA9.518098
#>   BFJMKNMP.518102
#> colData names(71): X.SampleID BarcodeSequence ... HOST_TAXID
#>   Description
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> rowLinks: NULL
#> rowTree: NULL
#> colLinks: NULL
#> colTree: NULL
```

# 5 Session Info

```
sessionInfo()
```

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] phyloseq_1.54.0             lefser_1.20.2
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1                   ggplotify_0.1.3
#>   [3] tibble_3.3.0                    cellranger_1.1.0
#>   [5] DirichletMultinomial_1.52.0     lifecycle_1.0.4
#>   [7] lattice_0.22-7                  MASS_7.3-65
#>   [9] MultiAssayExperiment_1.36.0     magrittr_2.0.4
#>  [11] sass_0.4.10                     rmarkdown_2.30
#>  [13] jquerylib_0.1.4                 yaml_2.3.10
#>  [15] DBI_1.2.3                       RColorBrewer_1.1-3
#>  [17] ade4_1.7-23                     multcomp_1.4-29
#>  [19] abind_1.4-8                     purrr_1.2.0
#>  [21] fillpattern_1.0.2               yulab.utils_0.2.1
#>  [23] TH.data_1.1-4                   rappdirs_0.3.3
#>  [25] sandwich_3.1-1                  gdtools_0.4.4
#>  [27] ggrepel_0.9.6                   irlba_2.3.5.1
#>  [29] tidytree_0.4.6                  testthat_3.3.0
#>  [31] vegan_2.7-2                     rbiom_2.2.1
#>  [33] parallelly_1.45.1               permute_0.9-8
#>  [35] DelayedMatrixStats_1.32.0       codetools_0.2-20
#>  [37] coin_1.4-3                      DelayedArray_0.36.0
#>  [39] scuttle_1.20.0                  ggtext_0.1.2
#>  [41] xml2_1.4.1                      tidyselect_1.2.1
#>  [43] aplot_0.2.9                     farver_2.1.2
#>  [45] ScaledMatrix_1.18.0             viridis_0.6.5
#>  [47] jsonlite_2.0.0                  BiocNeighbors_2.4.0
#>  [49] multtest_2.66.0                 decontam_1.30.0
#>  [51] mia_1.18.0                      survival_3.8-3
#>  [53] scater_1.38.0                   iterators_1.0.14
#>  [55] emmeans_2.0.0                   systemfonts_1.3.1
#>  [57] foreach_1.5.2                   tools_4.5.1
#>  [59] ggnewscale_0.5.2                treeio_1.34.0
#>  [61] ragg_1.5.0                      Rcpp_1.1.0
#>  [63] glue_1.8.0                      gridExtra_2.3
#>  [65] SparseArray_1.10.1              BiocBaseUtils_1.12.0
#>  [67] xfun_0.54                       mgcv_1.9-4
#>  [69] TreeSummarizedExperiment_2.18.0 dplyr_1.1.4
#>  [71] withr_3.0.2                     BiocManager_1.30.27
#>  [73] fastmap_1.2.0                   rhdf5filters_1.22.0
#>  [75] bluster_1.20.0                  digest_0.6.38
#>  [77] rsvd_1.0.5                      R6_2.6.1
#>  [79] gridGraphics_0.5-1              estimability_1.5.1
#>  [81] textshaping_1.0.4               dichromat_2.0-0.1
#>  [83] tidyr_1.3.1                     fontLiberation_0.1.0
#>  [85] data.table_1.17.8               DECIPHER_3.6.0
#>  [87] htmlwidgets_1.6.4               S4Arrays_1.10.0
#>  [89] pkgconfig_2.0.3                 gtable_0.3.6
#>  [91] modeltools_0.2-24               S7_0.2.1
#>  [93] SingleCellExperiment_1.32.0     XVector_0.50.0
#>  [95] brio_1.1.5                      htmltools_0.5.8.1
#>  [97] fontBitstreamVera_0.1.1         bookdown_0.45
#>  [99] biomformat_1.38.0               scales_1.4.0
#> [101] ggfun_0.2.0                     knitr_1.50
#> [103] tzdb_0.5.0                      reshape2_1.4.5
#> [105] coda_0.19-4.1                   nlme_3.1-168
#> [107] cachem_1.1.0                    zoo_1.8-14
#> [109] rhdf5_2.54.0                    stringr_1.6.0
#> [111] parallel_4.5.1                  vipor_0.4.7
#> [113] libcoin_1.0-10                  pillar_1.11.1
#> [115] grid_4.5.1                      vctrs_0.6.5
#> [117] slam_0.1-55                     BiocSingular_1.26.0
#> [119] beachmat_2.26.0                 xtable_1.8-4
#> [121] cluster_2.1.8.1                 beeswarm_0.4.0
#> [123] evaluate_1.0.5                  readr_2.1.5
#> [125] tinytex_0.57                    magick_2.9.0
#> [127] mvtnorm_1.3-3                   cli_3.6.5
#> [129] compiler_4.5.1                  rlang_1.1.6
#> [131] crayon_1.5.3                    labeling_0.4.3
#> [133] plyr_1.8.9                      fs_1.6.6
#> [135] ggbeeswarm_0.7.2                ggiraph_0.9.2
#> [137] stringi_1.8.7                   viridisLite_0.4.2
#> [139] BiocParallel_1.44.0             Biostrings_2.78.0
#> [141] lazyeval_0.2.2                  fontquiver_0.2.1
#> [143] Matrix_1.7-4                    hms_1.1.4
#> [145] patchwork_1.3.2                 sparseMatrixStats_1.22.0
#> [147] ggplot2_4.0.1                   Rhdf5lib_1.32.0
#> [149] gridtext_0.1.5                  igraph_2.2.1
#> [151] bslib_0.9.0                     ggtree_4.0.1
#> [153] readxl_1.4.5                    ape_5.8-1
```