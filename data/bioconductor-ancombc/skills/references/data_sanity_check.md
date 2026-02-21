# Tutorial on Data Sanity and Integrity Checks

#### Menglu Liang\(^1\), Huang Lin\(^1\)

#### \(^1\)University of Maryland, College Park, MD 20742

#### October 29, 2025

```
knitr::opts_chunk$set(warning = FALSE, comment = NA,
                      fig.width = 6.25, fig.height = 5)
library(ANCOMBC)
library(tidyverse)
```

# 1. Introduction

The `data_sanity_check` function performs essential validations on the input data to ensure its integrity before further processing. It verifies data types, confirms the structure of the input data, and checks for consistency between sample names in the metadata and the feature table, safeguarding against common data input errors.

# 2. Installation

Download package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ANCOMBC")
```

Load the package.

```
library(ANCOMBC)
```

# 3. Examples

## 3.1 Import a `phyloseq` object

The HITChip Atlas dataset contains genus-level microbiota profiling with HITChip for 1006 western adults with no reported health complications, reported in (Lahti et al. 2014). The dataset is available via the microbiome R package (Lahti et al. 2017) in phyloseq (McMurdie and Holmes 2013) format.

```
data(atlas1006, package = "microbiome")

atlas1006
```

```
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 130 taxa and 1151 samples ]
sample_data() Sample Data:       [ 1151 samples by 10 sample variables ]
tax_table()   Taxonomy Table:    [ 130 taxa by 3 taxonomic ranks ]
```

List the taxonomic levels available for data aggregation.

```
phyloseq::rank_names(atlas1006)
```

```
[1] "Phylum" "Family" "Genus"
```

List the variables available in the sample metadata.

```
colnames(microbiome::meta(atlas1006))
```

```
 [1] "age"                   "sex"                   "nationality"
 [4] "DNA_extraction_method" "project"               "diversity"
 [7] "bmi_group"             "subject"               "time"
[10] "sample"
```

Data sanity and integrity check.

```
# With `group` variable
check_results = data_sanity_check(data = atlas1006,
                                  tax_level = "Family",
                                  fix_formula = "age + sex + bmi_group",
                                  group = "bmi_group",
                                  struc_zero = TRUE,
                                  global = TRUE,
                                  verbose = TRUE)
```

```
Checking the input data type ...
```

```
The input data is of type: phyloseq
```

```
PASS
```

```
Checking the sample metadata ...
```

```
The specified variables in the formula: age, sex, bmi_group
```

```
The available variables in the sample metadata: age, sex, nationality, DNA_extraction_method, project, diversity, bmi_group, subject, time, sample
```

```
PASS
```

```
Checking other arguments ...
```

```
The number of groups of interest is: 6
```

```
The sample size per group is: underweight = 21, lean = 484, overweight = 197, obese = 222, severeobese = 99, morbidobese = 22
```

```
PASS
```

```
# Without `group` variable
check_results = data_sanity_check(data = atlas1006,
                                  tax_level = "Family",
                                  fix_formula = "age + sex + bmi_group",
                                  group = NULL,
                                  struc_zero = FALSE,
                                  global = FALSE,
                                  verbose = TRUE)
```

```
Checking the input data type ...
```

```
The input data is of type: phyloseq
```

```
PASS
```

```
Checking the sample metadata ...
```

```
The specified variables in the formula: age, sex, bmi_group
```

```
The available variables in the sample metadata: age, sex, nationality, DNA_extraction_method, project, diversity, bmi_group, subject, time, sample
```

```
PASS
```

```
Checking other arguments ...
```

```
PASS
```

## 3.2 Import a `tse` object

```
tse = mia::convertFromPhyloseq(atlas1006)
```

List the taxonomic levels available for data aggregation.

```
mia::taxonomyRanks(tse)
```

```
[1] "Phylum" "Family" "Genus"
```

List the variables available in the sample metadata.

```
colnames(SummarizedExperiment::colData(tse))
```

```
 [1] "age"                   "sex"                   "nationality"
 [4] "DNA_extraction_method" "project"               "diversity"
 [7] "bmi_group"             "subject"               "time"
[10] "sample"
```

Data sanity and integrity check.

```
check_results = data_sanity_check(data = tse,
                                  assay_name = "counts",
                                  tax_level = "Family",
                                  fix_formula = "age + sex + bmi_group",
                                  group = "bmi_group",
                                  struc_zero = TRUE,
                                  global = TRUE,
                                  verbose = TRUE)
```

```
Checking the input data type ...
```

```
The input data is of type: TreeSummarizedExperiment
```

```
PASS
```

```
Checking the sample metadata ...
```

```
The specified variables in the formula: age, sex, bmi_group
```

```
The available variables in the sample metadata: age, sex, nationality, DNA_extraction_method, project, diversity, bmi_group, subject, time, sample
```

```
PASS
```

```
Checking other arguments ...
```

```
The number of groups of interest is: 6
```

```
The sample size per group is: underweight = 21, lean = 484, overweight = 197, obese = 222, severeobese = 99, morbidobese = 22
```

```
PASS
```

## 3.3 Import a `matrix` or `data.frame`

Both abundance data and sample metadata are required for this import method.

Note that aggregating taxa to higher taxonomic levels is not supported in this method. Ensure that the data is already aggregated to the desired taxonomic level before proceeding. If aggregation is needed, consider creating a `phyloseq` or `tse` object for importing.

```
abundance_data = microbiome::abundances(atlas1006)
meta_data = microbiome::meta(atlas1006)
```

Ensure that the `rownames` of the metadata correspond to the `colnames` of the abundance data.

```
all(rownames(meta_data) %in% colnames(abundance_data))
```

```
[1] TRUE
```

List the variables available in the sample metadata.

```
colnames(meta_data)
```

```
 [1] "age"                   "sex"                   "nationality"
 [4] "DNA_extraction_method" "project"               "diversity"
 [7] "bmi_group"             "subject"               "time"
[10] "sample"
```

Data sanity and integrity check.

```
check_results = data_sanity_check(data = abundance_data,
                                  assay_name = "counts",
                                  tax_level = "Family",
                                  meta_data = meta_data,
                                  fix_formula = "age + sex + bmi_group",
                                  group = "bmi_group",
                                  struc_zero = TRUE,
                                  global = TRUE,
                                  verbose = TRUE)
```

```
Checking the input data type ...
```

```
The input data is of type: matrix
```

```
The imported data is in a generic 'matrix'/'data.frame' format.
```

```
PASS
```

```
Checking the sample metadata ...
```

```
The specified variables in the formula: age, sex, bmi_group
```

```
The available variables in the sample metadata: age, sex, nationality, DNA_extraction_method, project, diversity, bmi_group, subject, time, sample
```

```
PASS
```

```
Checking other arguments ...
```

```
The number of groups of interest is: 6
```

```
The sample size per group is: underweight = 21, lean = 484, overweight = 197, obese = 222, severeobese = 99, morbidobese = 22
```

```
PASS
```

# Session information

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
 [1] doRNG_1.8.6.2   rngtools_1.5.2  foreach_1.5.2   DT_0.34.0
 [5] lubridate_1.9.4 forcats_1.0.1   stringr_1.5.2   dplyr_1.1.4
 [9] purrr_1.1.0     readr_2.1.5     tidyr_1.3.1     tibble_3.3.0
[13] ggplot2_4.0.0   tidyverse_2.0.0 ANCOMBC_2.12.0

loaded via a namespace (and not attached):
  [1] ggtext_0.1.2                    fs_1.6.6
  [3] matrixStats_1.5.0               DirichletMultinomial_1.52.0
  [5] httr_1.4.7                      RColorBrewer_1.1-3
  [7] doParallel_1.0.17               numDeriv_2016.8-1.1
  [9] tools_4.5.1                     backports_1.5.0
 [11] R6_2.6.1                        vegan_2.7-2
 [13] lazyeval_0.2.2                  mgcv_1.9-3
 [15] rhdf5filters_1.22.0             permute_0.9-8
 [17] withr_3.0.2                     gridExtra_2.3
 [19] textshaping_1.0.4               cli_3.6.5
 [21] Biobase_2.70.0                  sandwich_3.1-1
 [23] slam_0.1-55                     labeling_0.4.3
 [25] sass_0.4.10                     mvtnorm_1.3-3
 [27] S7_0.2.0                        proxy_0.4-27
 [29] systemfonts_1.3.1               yulab.utils_0.2.1
 [31] foreign_0.8-90                  dichromat_2.0-0.1
 [33] scater_1.38.0                   decontam_1.30.0
 [35] parallelly_1.45.1               readxl_1.4.5
 [37] fillpattern_1.0.2               rstudioapi_0.17.1
 [39] generics_0.1.4                  gtools_3.9.5
 [41] crosstalk_1.2.2                 rbiom_2.2.1
 [43] Matrix_1.7-4                    biomformat_1.38.0
 [45] ggbeeswarm_0.7.2                DescTools_0.99.60
 [47] S4Vectors_0.48.0                DECIPHER_3.6.0
 [49] abind_1.4-8                     lifecycle_1.0.4
 [51] multcomp_1.4-29                 yaml_2.3.10
 [53] SummarizedExperiment_1.40.0     rhdf5_2.54.0
 [55] SparseArray_1.10.0              Rtsne_0.17
 [57] grid_4.5.1                      crayon_1.5.3
 [59] lattice_0.22-7                  haven_2.5.5
 [61] beachmat_2.26.0                 pillar_1.11.1
 [63] knitr_1.50                      GenomicRanges_1.62.0
 [65] boot_1.3-32                     gld_2.6.8
 [67] estimability_1.5.1              codetools_0.2-20
 [69] glue_1.8.0                      data.table_1.17.8
 [71] MultiAssayExperiment_1.36.0     vctrs_0.6.5
 [73] treeio_1.34.0                   Rdpack_2.6.4
 [75] cellranger_1.1.0                gtable_0.3.6
 [77] cachem_1.1.0                    xfun_0.53
 [79] rbibutils_2.3                   S4Arrays_1.10.0
 [81] Seqinfo_1.0.0                   coda_0.19-4.1
 [83] reformulas_0.4.2                survival_3.8-3
 [85] SingleCellExperiment_1.32.0     iterators_1.0.14
 [87] bluster_1.20.0                  gmp_0.7-5
 [89] TH.data_1.1-4                   nlme_3.1-168
 [91] phyloseq_1.54.0                 bit64_4.6.0-1
 [93] bslib_0.9.0                     irlba_2.3.5.1
 [95] vipor_0.4.7                     rpart_4.1.24
 [97] colorspace_2.1-2                BiocGenerics_0.56.0
 [99] DBI_1.2.3                       Hmisc_5.2-4
[101] nnet_7.3-20                     ade4_1.7-23
[103] Exact_3.3                       tidyselect_1.2.1
[105] emmeans_2.0.0                   bit_4.6.0
[107] compiler_4.5.1                  microbiome_1.32.0
[109] htmlTable_2.4.3                 BiocNeighbors_2.4.0
[111] expm_1.0-0                      xml2_1.4.1
[113] DelayedArray_0.36.0             checkmate_2.3.3
[115] scales_1.4.0                    rappdirs_0.3.3
[117] digest_0.6.37                   minqa_1.2.8
[119] rmarkdown_2.30                  XVector_0.50.0
[121] htmltools_0.5.8.1               pkgconfig_2.0.3
[123] base64enc_0.1-3                 lme4_1.1-37
[125] sparseMatrixStats_1.22.0        MatrixGenerics_1.22.0
[127] fastmap_1.2.0                   rlang_1.1.6
[129] htmlwidgets_1.6.4               DelayedMatrixStats_1.32.0
[131] farver_2.1.2                    jquerylib_0.1.4
[133] zoo_1.8-14                      jsonlite_2.0.0
[135] energy_1.7-12                   BiocParallel_1.44.0
[137] BiocSingular_1.26.0             magrittr_2.0.4
[139] Formula_1.2-5                   scuttle_1.20.0
[141] patchwork_1.3.2                 Rhdf5lib_1.32.0
[143] Rcpp_1.1.0                      ape_5.8-1
[145] ggnewscale_0.5.2                viridis_0.6.5
[147] CVXR_1.0-15                     stringi_1.8.7
[149] rootSolve_1.8.2.4               MASS_7.3-65
[151] plyr_1.8.9                      parallel_4.5.1
[153] ggrepel_0.9.6                   lmom_3.2
[155] Biostrings_2.78.0               splines_4.5.1
[157] gridtext_0.1.5                  multtest_2.66.0
[159] hms_1.1.4                       igraph_2.2.1
[161] reshape2_1.4.4                  stats4_4.5.1
[163] ScaledMatrix_1.18.0             evaluate_1.0.5
[165] nloptr_2.2.1                    tzdb_0.5.0
[167] BiocBaseUtils_1.12.0            rsvd_1.0.5
[169] xtable_1.8-4                    Rmpfr_1.1-2
[171] e1071_1.7-16                    tidytree_0.4.6
[173] ragg_1.5.0                      viridisLite_0.4.2
[175] class_7.3-23                    gsl_2.1-8
[177] lmerTest_3.1-3                  beeswarm_0.4.0
[179] IRanges_2.44.0                  cluster_2.1.8.1
[181] TreeSummarizedExperiment_2.18.0 timechange_0.3.0
[183] mia_1.18.0
```

# References

Lahti, Leo, Jarkko Salojärvi, Anne Salonen, Marten Scheffer, and Willem M De Vos. 2014. “Tipping Elements in the Human Intestinal Ecosystem.” *Nature Communications* 5 (1): 1–10.

Lahti, Leo, Sudarshan Shetty, T Blake, J Salojarvi, and others. 2017. “Tools for Microbiome Analysis in R.” *Version* 1: 10013.

McMurdie, Paul J, and Susan Holmes. 2013. “Phyloseq: An R Package for Reproducible Interactive Analysis and Graphics of Microbiome Census Data.” *PloS One* 8 (4): e61217.