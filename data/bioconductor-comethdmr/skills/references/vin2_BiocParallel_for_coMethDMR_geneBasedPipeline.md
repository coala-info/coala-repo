# Genome-wide methylation analysis using coMethDMR via parallel computing

Gabriel J. Odom, Lissette Gomez, Tiago Chedraoui Silva, Lanyu Zhang and Lily Wang

#### March 2021

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
  + [1.2 Overview](#overview)
* [2 Example Dataset](#example-dataset)
* [3 Analyzing One Type of Genomic Region via BiocParallel](#analyzing-one-type-of-genomic-region-via-biocparallel)
  + [3.1 Compute residuals](#compute-residuals)
  + [3.2 Finding co-methylated regions](#finding-co-methylated-regions)
  + [3.3 Testing the co-methylated regions](#testing-the-co-methylated-regions)
* [4 coMethDMR Analysis Pipeline for 450k Methylation Arrays Datasets via BiocParallel](#comethdmr-analysis-pipeline-for-450k-methylation-arrays-datasets-via-biocparallel)
* [5 A Comment on Using EPIC Methylation Arrays Datasets](#a-comment-on-using-epic-methylation-arrays-datasets)
* [6 Additional Comments on Computational Time and Resources](#additional-comments-on-computational-time-and-resources)
* [7 Session Information](#session-information)

# 1 Introduction

In the previous vignette “Introduction to **coMethDMR**”, we discussed components of the **coMethDMR** pipeline and presented example R scripts for running an analysis with **coMethDMR** serially. However, because identifying co-methylated clusters and fitting mixed effects models on large numbers of genomic regions can be computationally expensive, we illustrate implementation of parallel computing for **coMethDMR** via the **BiocParallel** R package in this vignette.

## 1.1 Installation

The latest version can be installed by:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("coMethDMR")
```

First, we load these two packages.

```
library(coMethDMR)
library(BiocParallel)
```

## 1.2 Overview

In Section 2, we give a brief re-introduction to the example data. In Section 3, we present example scripts for analyzing a single type (e.g. genic regions) of genomic regions using parallel computing. In Section 4, we present example scripts for analyzing genic and intergenic regions on the Illumina arrays using parallel computing.

# 2 Example Dataset

For illustration, we use a subset of prefrontal cortex methylation data (GEO GSE59685) described in Lunnon et al. (2014). This example dataset includes beta values for 8552 CpGs on chromosome 22 for a random selection of 20 subjects.

```
data(betasChr22_df)
```

We assume quality control and normalization of the methylation dataset have been performed by R packages such as **minfi** or **RnBeads**. Further, we assume that probes and samples with excessive missingness have been removed (this task can be completed by subsetting the original methylation data set with the probes and samples identified by the `MarkMissing()` function).

```
# Purge any probes or samples with excessive missing values
markCells_ls <- MarkMissing(dnaM_df = betasChr22_df)
betasChr22_df <- betasChr22_df[
  markCells_ls$keepProbes,
  markCells_ls$keepSamples
]

# Inspect
betasChr22_df[1:5, 1:5]
```

```
##            GSM1443279 GSM1443663 GSM1443434 GSM1443547 GSM1443577
## cg00004192  0.9249942  0.8463296  0.8700718  0.9058205  0.9090382
## cg00004775  0.6523025  0.6247554  0.7573476  0.6590817  0.6726261
## cg00012194  0.8676339  0.8679048  0.8484754  0.8754985  0.8484458
## cg00013618  0.9466056  0.9475467  0.9566493  0.9588431  0.9419563
## cg00014104  0.3932388  0.5525716  0.4075900  0.3997278  0.3216956
```

The corresponding phenotype dataset included variables `stage` (Braak AD stage), `subject.id`, `slide` (batch effect), `sex`, `Sample` and `age.brain` (age of the brain donor).

```
data(pheno_df)
head(pheno_df)
```

```
##    stage subject.id         sex     Sample age.brain       slide
## 3      0          1 Sex: FEMALE GSM1443251        82  6042316048
## 8      2          2 Sex: FEMALE GSM1443256        82  6042316066
## 10    NA          3   Sex: MALE GSM1443258        89  6042316066
## 15     1          4 Sex: FEMALE GSM1443263        81  7786923107
## 21     2          5 Sex: FEMALE GSM1443269        92  6042316121
## 22     1          6   Sex: MALE GSM1443270        78  6042316099
```

Note that only samples with both methylation data and non-missing phenotype data are analyzed by **coMethDMR**. So in this example, the sample with `subject.id = 3` which lacks AD stage information will be excluded from analysis. Please also note the phenotype file needs to have a variable called “Sample” that will be used by **coMethDMR** to link to the methylation dataset.

# 3 Analyzing One Type of Genomic Region via BiocParallel

As mentioned previously in “Introduction to **coMethDMR**”, there are several steps in the **coMethDMR** pipeline:

1. Obtain CpGs located closely in pre-defined genomic regions,
2. Identify co-methylated regions, and
3. Test co-methylated regions against the outcome variable (AD stage).

Suppose we are interested in analyzing genic regions on the 450k arrays. In the following, `closeByGeneAll_ls` is a list, where each item includes at least 3 CpGs located closely (max distance between 2 CpGs is 200bp by default).

```
closeByGeneAll_ls <- readRDS(
  system.file(
    "extdata",
    "450k_Gene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
  )
)
```

We can inspect the first region in the list via:

```
closeByGeneAll_ls[1]
```

```
## $`chr4:91760141-91760229`
## [1] "cg01583657" "cg25325192" "cg06044899"
```

Next, for demonstration, we select regions on chromosome 22.

```
indx <- grep("chr22:", names(closeByGeneAll_ls))

closeByGene_ls <- closeByGeneAll_ls[indx]
rm(closeByGeneAll_ls)
length(closeByGene_ls)
```

```
## [1] 676
```

There are 676 genic regions to be tested for chromosome 22. As an example, this vignette will analyze the first 10 regions, which contain the following CpGs:

```
closeByGene_ls[1:10]
```

```
## $`chr22:30662799-30663041`
## [1] "cg19018155" "cg10467217" "cg24727122" "cg02597698" "cg25666403"
## [6] "cg02026204" "cg05539509" "cg07498879"
##
## $`chr22:18632404-18633123`
##  [1] "cg27281093" "cg18699242" "cg01963623" "cg02169692" "cg00077299"
##  [6] "cg07964128" "cg02518889" "cg01246421" "cg08205655" "cg10685559"
##
## $`chr22:43253145-43253208`
## [1] "cg15656623" "cg10648908" "cg02351223"
##
## $`chr22:43253517-43253559`
## [1] "cg09861871" "cg00079563" "cg26529516" "cg04527868" "cg01029450"
##
## $`chr22:43254043-43254168`
## [1] "cg23778094" "cg00539564" "cg09367092"
##
## $`chr22:30901532-30901886`
## [1] "cg03214697" "cg00093544" "cg02923264" "cg03014622" "cg19964641"
## [6] "cg15829116" "cg07217063"
##
## $`chr22:39883190-39883347`
## [1] "cg00550928" "cg00101350" "cg26692811"
##
## $`chr22:30685584-30685926`
## [1] "cg00101453" "cg23835894" "cg22088670" "cg03652890" "cg24843389"
## [6] "cg15272908" "cg20395643" "cg10998744"
##
## $`chr22:45064086-45064238`
## [1] "cg10031995" "cg21293611" "cg11450750"
##
## $`chr22:45072455-45072724`
## [1] "cg24019054" "cg20339720" "cg16166559" "cg06849477"
```

In order to make these examples as simple as possible, we will remove the CpGs from our data set which are not included in these 10 regions. In practice, you would keep the full data set.

```
keepCpGs_char <- unique(unlist(closeByGene_ls[1:10]))
betasChr22small_df <-
  betasChr22_df[rownames(betasChr22_df) %in% keepCpGs_char, ]
dim(betasChr22small_df)
```

```
## [1] 54 20
```

## 3.1 Compute residuals

This step removes uninteresting technical and biological effects using the `GetResiduals` function, so that the resulting co-methylated clusters are only driven by the biological factors we are interested in. Note that there may be an error with the parallel back-end (`1 parallel job did not deliver a result`); this has occurred rarely for us (and not consistently enough for us to create a reproducible example), but it goes away when we execute the code a second time. We then recommend that you test this with a smaller subset of your data first. If you are able to consistently replicate a parallel error, please submit a bug report: <https://github.com/TransBioInfoLab/coMethDMR/issues>.

```
resid_mat <- GetResiduals(
  dnam = betasChr22small_df,
  # converts to Mvalues for fitting linear model
  betaToM = TRUE,
  pheno_df = pheno_df,
  # Features in pheno_df used as covariates
  covariates_char = c("age.brain", "sex", "slide"),
  nCores_int = 2
)
```

```
## Phenotype data is not in the same order as methylation data. We used column Sample in phenotype data to put these two files in the same order.
```

## 3.2 Finding co-methylated regions

The cluster computing with the **BiocParallel** package involves simply changing the default value of one argument: `nCores_int`. This argument enables you to perform parallel computing when you set the number of cores to an integer value greater than 1. *If you do not know how many cores your machine has, use the `detectCores()` function from the `parallel` package. Note that, if you have many applications open on your computer, you should not use all of the cores available.*

Once we know how many cores we have available, we execute the `CoMethAllRegions()` function using each worker in the cluster, to find co-methylated clusters in the genic regions. As an example, we only analyze the first 10 CpG regions (`CpGs_ls`).

```
system.time(
  coMeth_ls <- CoMethAllRegions(
    dnam = resid_mat,
    betaToM = FALSE,
    method = "spearman",
    arrayType = "450k",
    CpGs_ls = closeByGene_ls[1:10],
    nCores_int = 2
  )
)
```

```
##    user  system elapsed
##   9.217   1.002  10.562
```

```
# Windows: NA
# Mac: ~14 seconds for 2 cores
```

The object `coMeth_ls` is a list, with each item containing the list of CpGs within an identified co-methylated region.

## 3.3 Testing the co-methylated regions

Next we test these co-methylated regions against continuous phenotype `stage`, adjusting for covariates `age` and `sex`, by executing the `lmmTestAllRegions()` function.

```
res_df <- lmmTestAllRegions(
  betas = betasChr22small_df,
  region_ls = coMeth_ls,
  pheno_df = pheno_df,
  contPheno_char = "stage",
  covariates_char = c("age.brain", "sex"),
  modelType = "randCoef",
  arrayType = "450k",
  nCores_int = 2
  # outLogFile = "res_lmm_log.txt"
)
```

Model fit messages and diagnostics for each region will be saved to the log file specified with the `outLogFile` argument. For a single region, this will return a one row of model fit statistics similar to the following:

| chrom | start | end | nCpGs | Estimate | StdErr | Stat | pValue |
| --- | --- | --- | --- | --- | --- | --- | --- |
| chr22 | 24823455 | 24823519 | 4 | -0.0702 | 0.0290 | -2.4184 | 0.0155 |

Finally, we can annotate these results:

```
AnnotateResults(res_df)
```

```
##   chrom    start      end nCpGs     Estimate     StdErr       Stat      pValue
## 1 chr22 30662799 30663041     8 -0.059977631 0.01878100 -3.1935273 0.001405461
## 2 chr22 43253521 43253559     4 -0.007602187 0.02873768 -0.2645373 0.791365960
## 3 chr22 30901532 30901886     7  0.018015623 0.01555597  1.1581162 0.246816609
## 4 chr22 39883190 39883347     3  0.069276861 0.02863864  2.4189998 0.015563247
##           FDR           UCSC_RefGene_Group UCSC_RefGene_Accession
## 1 0.005621842 1stExon;5'UTR;TSS1500;TSS200              NM_020530
## 2 0.791365960                       TSS200 NM_001142293;NM_014570
## 3 0.329088811    1stExon;5'UTR;Body;TSS200 NM_001161368;NM_174977
## 4 0.031126493         1stExon;5'UTR;TSS200 NM_001098270;NM_002409
##   UCSC_RefGene_Name Relation_to_Island
## 1               OSM            OpenSea
## 2           ARFGAP3             Island
## 3           SEC14L4     Island;S_Shore
## 4             MGAT3            N_Shore
```

# 4 coMethDMR Analysis Pipeline for 450k Methylation Arrays Datasets via BiocParallel

In this section, we provide example scripts for testing genic and intergenic regions using **coMethDMR** and **BiocParallel** R packages.

First, we read in clusters of CpGs located closely on the array, in genic and intergenic regions, then combine them into a single list.

```
closeByGene_ls <- readRDS(
  system.file(
    "extdata",
    "450k_Gene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
  )
)

closeByInterGene_ls <- readRDS(
  system.file(
    "extdata",
    "450k_InterGene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
  )
)

# put them together in one list
closeBy_ls <- c(closeByInterGene_ls, closeByGene_ls)
length(closeBy_ls)
```

```
## [1] 42536
```

```
closeBy_ls[1:3]
```

```
## $`chr1:569427-569687`
## [1] "cg08858441" "cg03348902" "cg01070250"
##
## $`chr1:713921-714177`
## [1] "cg10037654" "cg14057946" "cg11422233" "cg16047670" "cg18263059"
## [6] "cg01014490"
##
## $`chr1:834183-834356`
## [1] "cg13938959" "cg12445832" "cg23999112"
```

With this list of regions and their probe IDs, repeat the analysis code in the previous section.

# 5 A Comment on Using EPIC Methylation Arrays Datasets

The analysis for EPIC methylation arrays would be the same as those for 450k arrays, except by testing genomic regions in files “EPIC\_Gene\_3\_200.rds” and “EPIC\_InterGene\_3\_200.RDS”, instead of “450k\_Gene\_3\_200.rds” and “450k\_InterGene\_3\_200.rds”. These data sets are available at <https://github.com/TransBioInfoLab/coMethDMR_data/tree/main/data>.

# 6 Additional Comments on Computational Time and Resources

In this vignette, we have analyzed a small subset of a real EWAS dataset (i.e. only chromosome 22 data on 20 subjects). To give users a more realistic estimate of time for analyzing real EWAS datasets, we also measured time used for analyzing the entire Lunnon et al. (2014) dataset with 110 samples on all chromosomes. These computation times measured on a Dell Precision 5810 with 64Gb of RAM, an Intel Xeon E5-2640 CPU at 2.40Ghz, and using up to 20 cores. More specifically, in Section 4, the entire **coMethDMR** workflow for took 103 minutes with 6 cores and used a maximum of 24Gb of RAM (for the `CoMethAllRegions()` function). We’re currently working improving the speed and reducing the size of **coMethDMR**, so please check back soon for updates.

# 7 Session Information

```
utils::sessionInfo()
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BiocParallel_1.44.0  corrplot_0.95        GenomicRanges_1.62.0
##  [4] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
##  [7] sesameData_1.27.1    ExperimentHub_3.0.0  AnnotationHub_4.0.0
## [10] BiocFileCache_3.0.0  dbplyr_2.5.1         BiocGenerics_0.56.0
## [13] generics_0.1.4       coMethDMR_1.14.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3
##   [2] jsonlite_2.0.0
##   [3] magrittr_2.0.4
##   [4] magick_2.9.0
##   [5] GenomicFeatures_1.62.0
##   [6] farver_2.1.2
##   [7] nloptr_2.2.1
##   [8] rmarkdown_2.30
##   [9] BiocIO_1.20.0
##  [10] vctrs_0.6.5
##  [11] multtest_2.66.0
##  [12] memoise_2.0.1
##  [13] minqa_1.2.8
##  [14] Rsamtools_2.26.0
##  [15] DelayedMatrixStats_1.32.0
##  [16] RCurl_1.98-1.17
##  [17] askpass_1.2.1
##  [18] tinytex_0.57
##  [19] htmltools_0.5.8.1
##  [20] S4Arrays_1.10.0
##  [21] curl_7.0.0
##  [22] Rhdf5lib_1.32.0
##  [23] SparseArray_1.10.0
##  [24] rhdf5_2.54.0
##  [25] sass_0.4.10
##  [26] nor1mix_1.3-3
##  [27] bslib_0.9.0
##  [28] plyr_1.8.9
##  [29] httr2_1.2.1
##  [30] cachem_1.1.0
##  [31] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [32] GenomicAlignments_1.46.0
##  [33] lifecycle_1.0.4
##  [34] iterators_1.0.14
##  [35] pkgconfig_2.0.3
##  [36] Matrix_1.7-4
##  [37] R6_2.6.1
##  [38] fastmap_1.2.0
##  [39] rbibutils_2.3
##  [40] MatrixGenerics_1.22.0
##  [41] digest_0.6.37
##  [42] numDeriv_2016.8-1.1
##  [43] siggenes_1.84.0
##  [44] reshape_0.8.10
##  [45] AnnotationDbi_1.72.0
##  [46] RSQLite_2.4.3
##  [47] base64_2.0.2
##  [48] filelock_1.0.3
##  [49] beanplot_1.3.1
##  [50] httr_1.4.7
##  [51] abind_1.4-8
##  [52] compiler_4.5.1
##  [53] rngtools_1.5.2
##  [54] bit64_4.6.0-1
##  [55] withr_3.0.2
##  [56] S7_0.2.0
##  [57] DBI_1.2.3
##  [58] HDF5Array_1.38.0
##  [59] MASS_7.3-65
##  [60] openssl_2.3.4
##  [61] rappdirs_0.3.3
##  [62] DelayedArray_0.36.0
##  [63] rjson_0.2.23
##  [64] tools_4.5.1
##  [65] rentrez_1.2.4
##  [66] quadprog_1.5-8
##  [67] glue_1.8.0
##  [68] h5mread_1.2.0
##  [69] restfulr_0.0.16
##  [70] nlme_3.1-168
##  [71] rhdf5filters_1.22.0
##  [72] grid_4.5.1
##  [73] gtable_0.3.6
##  [74] tzdb_0.5.0
##  [75] preprocessCore_1.72.0
##  [76] tidyr_1.3.1
##  [77] data.table_1.17.8
##  [78] hms_1.1.4
##  [79] xml2_1.4.1
##  [80] XVector_0.50.0
##  [81] BiocVersion_3.22.0
##  [82] foreach_1.5.2
##  [83] pillar_1.11.1
##  [84] stringr_1.5.2
##  [85] limma_3.66.0
##  [86] genefilter_1.92.0
##  [87] splines_4.5.1
##  [88] dplyr_1.1.4
##  [89] lattice_0.22-7
##  [90] survival_3.8-3
##  [91] rtracklayer_1.70.0
##  [92] bit_4.6.0
##  [93] GEOquery_2.78.0
##  [94] annotate_1.88.0
##  [95] tidyselect_1.2.1
##  [96] locfit_1.5-9.12
##  [97] Biostrings_2.78.0
##  [98] knitr_1.50
##  [99] reformulas_0.4.2
## [100] bookdown_0.45
## [101] SummarizedExperiment_1.40.0
## [102] xfun_0.53
## [103] scrime_1.3.5
## [104] Biobase_2.70.0
## [105] statmod_1.5.1
## [106] matrixStats_1.5.0
## [107] stringi_1.8.7
## [108] yaml_2.3.10
## [109] boot_1.3-32
## [110] evaluate_1.0.5
## [111] codetools_0.2-20
## [112] cigarillo_1.0.0
## [113] tibble_3.3.0
## [114] minfi_1.56.0
## [115] BiocManager_1.30.26
## [116] cli_3.6.5
## [117] bumphunter_1.52.0
## [118] xtable_1.8-4
## [119] Rdpack_2.6.4
## [120] jquerylib_0.1.4
## [121] dichromat_2.0-0.1
## [122] Rcpp_1.1.0
## [123] png_0.1-8
## [124] XML_3.99-0.19
## [125] parallel_4.5.1
## [126] ggplot2_4.0.0
## [127] readr_2.1.5
## [128] blob_1.2.4
## [129] mclust_6.1.1
## [130] doRNG_1.8.6.2
## [131] sparseMatrixStats_1.22.0
## [132] bitops_1.0-9
## [133] lme4_1.1-37
## [134] lmerTest_3.1-3
## [135] illuminaio_0.52.0
## [136] scales_1.4.0
## [137] purrr_1.1.0
## [138] crayon_1.5.3
## [139] rlang_1.1.6
## [140] KEGGREST_1.50.0
```