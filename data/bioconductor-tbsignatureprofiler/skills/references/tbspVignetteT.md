# Introduction to the TBSignatureProfiler

Aubrey Odom1\* and W. Evan Johnson2\*\*

1Program in Bioinformatics, Boston University, Boston, MA
2Division of Infectious Disease, Center for Data Science, Rutgers University – New Jersey Medical School, Newark, NJ, USA

\*aodom@bu.edu
\*\*wj183@njms.rutgers.edu

#### October 30, 2025

#### Package

TBSignatureProfiler 1.22.0

# Contents

* [1 Introduction to the TBSignatureProfiler](#introduction-to-the-tbsignatureprofiler)
* [2 Installation](#installation)
* [3 Compatibility with SummarizedExperiment objects](#compatibility-with-summarizedexperiment-objects)
* [4 A Quick Tutorial for the TBSignatureProfiler](#a-quick-tutorial-for-the-tbsignatureprofiler)
  + [4.1 Load packages](#load-packages)
  + [4.2 Run Shiny App](#run-shiny-app)
  + [4.3 Load dataset from a SummarizedExperiment object](#load-dataset-from-a-summarizedexperiment-object)
  + [4.4 Profile the data](#profile-the-data)
* [5 Session Info](#session-info)

# 1 Introduction to the TBSignatureProfiler

Tuberculosis (TB) is the leading cause of infectious disease mortality worldwide, causing on average nearly 1.4 million deaths per year. A consistent issue faced in controlling TB outbreak is difficulty in diagnosing individuals with particular types of TB infections for which bacteria tests (e.g., via GeneXpert, sputum) prove inaccurate. As an alternative mechanism of diagnosis for these infections, researchers have discovered and published multiple gene expression signatures as blood-based disease biomarkers. In this context, gene signatures are defined as a combined group of genes with a uniquely characteristic pattern of gene expression that occurs as a result of a medical condition. To date, more than 75 signatures have been published by researchers, though most have relatively low cross-condition validation (e.g., testing TB in samples from diverse geographic and comorbidity backgrounds). Furthermore, these signatures have never been formally collected and made available as a single unified resource.

We aim to provide the scientific community with a resource to access these aggregated signatures and to create an efficient means for their visual and quantitative comparison via open source software. This necessitated the development of the TBSignatureProfiler, a novel R package which delivers a computational profiling platform for researchers to characterize the diagnostic ability of existing signatures in multiple comorbidity settings. This software allows for signature strength estimation via several enrichment methods and subsequent visualization of single- and multi-pathway results. Its signature evaluation functionalities include signature profiling, AUC bootstrapping, and leave-one-out cross-validation (LOOCV) of logistic regression to approximate TB samples’ status. Its plotting functionalities include sample-signature score heatmaps, bootstrap AUC and LOOCV boxplots, and tables for presenting results.

More recently, the TBSignatureProfiler has undertaken a new role in analyzing signatures across multiple chronic airway diseases, the most recent being COVID-19 (see the `COVIDsignatures` object). As we grow and expand the TBSignatureProfiler, we hope to add signatures from multiple diseases to improve the package’s utility in the area of gene signature comparison.

# 2 Installation

In order to install the TBSignatureProfiler from Bioconductor, run the following code:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("TBSignatureProfiler")
```

# 3 Compatibility with SummarizedExperiment objects

While the TBSignatureProfiler often allows for the form of a `data.frame` or `matrix` as input data, the most ideal form of input for this package is that of the `SummarizedExperiment` object. This is an amazing data structure that is being developed by the as part of the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* package, and is imported as part of the TBSignatureProfiler package. It is able to store data matrices along with annotation information, metadata, and reduced dimensionality data
(PCA, t-SNE, etc.). To learn more about proper usage and context of the `SummarizedExperiment` object, you may want to take a look at the [package vignette](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html). A basic understanding of the `assay` and `colData` properties of a `SummarizedExperiment` will be useful for the purposes of this vignette.

# 4 A Quick Tutorial for the TBSignatureProfiler

## 4.1 Load packages

```
suppressPackageStartupMessages({
  library(TBSignatureProfiler)
  library(SummarizedExperiment)
})
```

## 4.2 Run Shiny App

This command is to start the TBSignatureProfiler shiny app. The Shiny app implements several functions described in this vignette.

```
TBSPapp()
```

The basic functions of the shiny app are also included in the command line version of the TBSignatureProfiler, which is the focus of the remainder of this vignette.

## 4.3 Load dataset from a SummarizedExperiment object

In this tutorial, we will work with HIV and Tuberculosis (TB) gene expression data in a `SummarizedExperiment` format. This dataset is included in the TBSignatureProfiler package and can be loaded into the global environment with `data("TB_hiv")`. The 31 samples in the dataset are marked as either having both TB and HIV infection, or HIV infection only.

We begin by examining the dataset, which contains a matrix of counts information (an “assay” in SummarizedExperiment terms) and another matrix of meta data information on our samples (the “colData”). We will also generate a few additional assays; these are the log(counts), the counts per million (CPM) reads mapped, and the log(CPM) assays.

```
## HIV/TB gene expression data, included in the package
hivtb_data <- get0("TB_hiv", envir = asNamespace("TBSignatureProfiler"))

### Note that we have 25,369 genes, 33 samples, and 1 assay of counts
dim(hivtb_data)
```

```
## [1] 25369    31
```

```
# We start with only one assay
assays(hivtb_data)
```

```
## List of length 1
## names(1): counts
```

We now make a log counts, CPM and log CPM assay.

```
## Make a log counts, CPM and log CPM assay
hivtb_data <- mkAssay(hivtb_data, log = TRUE, counts_to_CPM = TRUE)

### Check to see that we now have 4 assays
assays(hivtb_data)
```

```
## List of length 4
## names(4): counts log_counts counts_cpm log_counts_cpm
```

## 4.4 Profile the data

The TBSignatureProfiler enables comparison of multiple Tuberculosis gene signatures. The package currently contains information on 79 signatures for comparison. The default signature list object for most functions here is `TBsignatures`, although a list with publication-given signature names is also available as `TBcommon`. Data frames of annotation information for these signatures, including information on associated disease and tissue type, can be accessed as `sigAnnotData` and `common_sigAnnotData` respectively.

With the `runTBSigProfiler` function, we are able to score these signatures with a selection of algorithms, including [gene set variation analysis](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-7) (GSVA) (Hänzelmann et al, 2013), [single-sample GSEA](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-7) (ssGSEA) (Barbie et al, 2009), and the [ASSIGN](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-7) pathway profiling toolkit (Shen et al, 2015). For a complete list of included scoring methods, run `?runTBsigProfiler` in the terminal.

Here, we evaluate all signatures included in the package with ssGSEA. Paraphrasing from the [ssGSEA documentation](http://software.broadinstitute.org/cancer/software/genepattern/modules/docs/ssGSEAProjection/4), for each pairing of one of the 31 samples and its gene set, ssGSEA calculates a separate enrichment score independent of the phenotypic labeling (in this case, whether a sample has HIV/TB, or HIV only). The single sample’s gene expression profile is then transformed to a gene set enrichment profile. A score from the set profile represents the activity level of the biological process in which the gene set’s members are coordinately up- or down-regulated.

```
## List all signatures in the profiler
data("TBsignatures")
names(TBsignatures)
```

```
##  [1] "Anderson_42"       "Anderson_OD_51"    "Berry_393"
##  [4] "Berry_OD_86"       "Blankley_380"      "Blankley_5"
##  [7] "Bloom_OD_144"      "Bloom_RES_268"     "Bloom_RES_558"
## [10] "Chen_5"            "Chen_HIV_4"        "Chendi_HIV_2"
## [13] "Darboe_RISK_11"    "Dawany_HIV_251"    "Duffy_23"
## [16] "Esmail_203"        "Esmail_82"         "Esmail_OD_893"
## [19] "Estevez_133"       "Estevez_259"       "Francisco_OD_2"
## [22] "Gjoen_10"          "Gjoen_7"           "Gliddon_2_OD_4"
## [25] "Gliddon_HIV_3"     "Gliddon_OD_3"      "Gliddon_OD_4"
## [28] "Gong_OD_4"         "Heycken_FAIL_22"   "Hoang_OD_13"
## [31] "Hoang_OD_20"       "Hoang_OD_3"        "Huang_OD_13"
## [34] "Jacobsen_3"        "Jenum_8"           "Kaforou_27"
## [37] "Kaforou_OD_44"     "Kaforou_OD_53"     "Kaul_3"
## [40] "Kulkarni_HIV_2"    "Kwan_186"          "LauxdaCosta_OD_3"
## [43] "Lee_4"             "Leong_24"          "Leong_RISK_29"
## [46] "Li_3"              "Long_RES_10"       "Maertzdorf_15"
## [49] "Maertzdorf_4"      "Maertzdorf_OD_100" "Natarajan_7"
## [52] "PennNich_RISK_6"   "Qian_OD_17"        "Rajan_HIV_5"
## [55] "Roe_3"             "Roe_OD_4"          "Sambarey_HIV_10"
## [58] "Singhania_OD_20"   "Sivakumaran_11"    "Sloot_HIV_2"
## [61] "Suliman_4"         "Suliman_RISK_2"    "Suliman_RISK_4"
## [64] "Sweeney_OD_3"      "Tabone_OD_11"      "Tabone_RES_25"
## [67] "Tabone_RES_27"     "Thompson_9"        "Thompson_FAIL_13"
## [70] "Thompson_RES_5"    "Tornheim_71"       "Tornheim_RES_25"
## [73] "Vargas_18"         "Vargas_42"         "Verhagen_10"
## [76] "Walter_51"         "Walter_PNA_119"    "Walter_PNA_47"
## [79] "Zak_RISK_16"       "Zhao_NANO_6"
```

```
## We can use all of these signatures for further analysis
siglist_hivtb <- names(TBsignatures)
```

A more complete tutorial is available by going to [our website](https://wejlab.github.io/TBSignatureProfiler-docs/index.html), and selecting the tab labeled “Command Line Analysis.”

# 5 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] TBSignatureProfiler_1.22.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        limma_3.66.0        jsonlite_2.0.0
##  [4] compiler_4.5.1      BiocManager_1.30.26 jquerylib_0.1.4
##  [7] statmod_1.5.1       yaml_2.3.10         fastmap_1.2.0
## [10] lattice_0.22-7      R6_2.6.1            XVector_0.50.0
## [13] S4Arrays_1.10.0     knitr_1.50          DelayedArray_0.36.0
## [16] bookdown_0.45       bslib_0.9.0         rlang_1.1.6
## [19] cachem_1.1.0        xfun_0.53           sass_0.4.10
## [22] SparseArray_1.10.0  cli_3.6.5           magrittr_2.0.4
## [25] locfit_1.5-9.12     digest_0.6.37       grid_4.5.1
## [28] edgeR_4.8.0         lifecycle_1.0.4     evaluate_1.0.5
## [31] abind_1.4-8         rmarkdown_2.30      tools_4.5.1
## [34] htmltools_0.5.8.1
```