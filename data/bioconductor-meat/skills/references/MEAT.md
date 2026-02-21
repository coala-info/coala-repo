# MEAT (Muscle Epigenetic Age Test)

### 2025-10-30

```
library(knitr)
```

![](data:image/jpeg;base64...)

# Introduction

Welcome to MEAT (Muscle Epigenetic Age Test)! If you are reading these lines, you are probably an inquisitive scientist who has put a lot of effort into collecting skeletal muscle samples from – hopefully – consenting humans. Your coin purse (grant) is now lighter after profiling these muscle samples with the **Illumina HumanMethylation technology (HM27, HM450 and HMEPIC)** and you are yearning to know what the skeletal muscle epigenome has to say about your samples’ age. I am here to guide you in your quest to find out how old your skeletal muscle samples are, by simply looking at their DNA methylation profiles. DNA methylation doesn’t lie, but it can be tricky to understand what it says. Are you ready to undertake your quest to uncover the secrets of the muscle epigenome?

You can view MEAT as a spellbook (package) that contains all the necessary spells (functions) to estimate epigenetic age in human skeletal muscle samples. However, the spells will only work if you cast them in a particular order (1. data cleaning, 2. data calibration, and 3. epigenetic age estimation). Starting from preprocessed data (matrix of beta-values that has been normalized/batch corrected, etc.), MEAT will estimate epigenetic age in each sample, based on a penalized regression model (elastic net regression) essentially similar to [Horvath’s original pan-tissue clock](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2013-14-10-r115). There are two versions of MEAT:

* [the original version (MEAT)](https://onlinelibrary.wiley.com/doi/full/10.1002/jcsm.12556) that was built on 682 muscle samples from 12 independent datasets. This clock estimates epigenetic age based on 200 CpGs. To access the name and coefficients of these 200 CpGs, run:

```
data("CpGs_in_MEAT",envir = environment())
```

* [the updated version (MEAT 2.0)](https://onlinelibrary.wiley.com/doi/full/10.1002/jcsm.12741) that was built on 1,053 samples from 16 independent datasets. This clock estimates epigenetic age based on 156 CpGs.To access the name and coefficients of these 156 CpGs, run:

```
data("CpGs_in_MEAT2.0",envir = environment())
```

For more information on MEAT and MEAT 2.0, see [our JCSM paper](https://onlinelibrary.wiley.com/doi/full/10.1002/jcsm.12741). You have the choice to use MEAT or MEAT 2.0 in this package.

Once MEAT has calculated epigenetic age, you may provide the actual age of each sample (if known), so MEAT can also calculate age acceleration as the difference between epigenetic age and real age (AAdiff), and as the residuals from a linear regression of epigenetic age against real age (AAresid). For more information on the distinction between AAdiff and AAresid, see [our original paper](https://onlinelibrary.wiley.com/doi/full/10.1002/jcsm.12556).

# Installation

Install the MEAT package:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("MEAT")
```

Then, load the package:

```
library(MEAT)
```

# Step-by-step guide

## Data requirements

To use this guide, you will need in your inventory:

* **a matrix or data frame of beta-values**. Epigenetic age estimation will be more accurate if the beta matrix is already preprocessed using one of the many available R packages intended for this purpose (e.g. [ChAMP](https://bioconductor.org/packages/release/bioc/vignettes/ChAMP/inst/doc/ChAMP.html)). Preprocessing typically involves probe and sample filtering, normalisation of Type I and Type II probes, and correction for batch effects. The beta-matrix should have *CpGs in rows* and *samples in columns*, like this:

```
data("GSE121961", envir = environment())
```

Table: Top rows of the GSE121961 matrix before cleaning and calibration.

|  | GSM3450524 | GSM3450528 |
| --- | --- | --- |
| cg00000029 | 0.35 | 0.35 |
| cg00000103 | NA | NA |
| cg00000109 | 0.77 | 0.79 |
| cg00000155 | 0.94 | 0.96 |
| cg00000158 | 0.96 | 0.96 |
| cg00000165 | 0.23 | 0.20 |

* **an optional phenotype table**. This phenotype table contains information on the samples provided in the beta-matrix, such as age (e.g. 0-122 years old for a human, 0-700 for an elf, 0-500 for a dwarf), sex (male, female, intersex), disease status (healthy/control, diseased/case/zombie delirium/hydrophobia/ogre poisoning), etc. The table should have *samples in rows* and *phenotypes in columns*, like this:

```
data("GSE121961_pheno", envir = environment())
```

Table: Phenotypes corresponding to GSE121961.

| ID | Sex | Age | Group | Batch | Position |
| --- | --- | --- | --- | --- | --- |
| GSM3450524 | M | NA | Control | 202128330007 | R01C01 |
| GSM3450528 | F | 14 | SELENON | 202128330007 | R07C01 |

The phenotype table is useful if you want to discover the AA of your samples and to associate this AA with a phenotype of interest (e.g. do elves show systematically lower AA than humans, therefore explaining their exceptional longevity?)

* **an optional annotation table**. This annotation table contains information on the CpGs in the beta-matrix, such as chromosome and genomic position, location with regards to CpG islands, closest or annotated gene, etc. This annotation table should contain *CpGs in rows* and *annotation in columns*.

## Step 1: Data formatting

A good adventurer never embarks a quest without a minimum of preparation. That is particularly true for your inventory! The beta matrix, the phenotype table and the annotation table should be all bundled up into a single object, to coordinate the meta-data and assays when subsetting. For example, if you have skeletal muscle DNA methylation profiles from humans, elves and dwarves, but you only want to select the samples from humans and elves, you can select these samples *in a single operation* in both the beta-matrix and phenotype table. This ensures the beta matrix, phenotype table and annotation table remain in sync.
[SummarizedExperiment objects](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html#introduction)) have the ideal format for your inventory. Let’s create such an object with the beta matrix and optional phenotype and annotation tables. *Please ensure that you call the beta-matrix “beta”* as it is essential for the upcoming functions.

```
library(SummarizedExperiment)
GSE121961_SE <- SummarizedExperiment(assays=list(beta=GSE121961),
colData=GSE121961_pheno)
GSE121961_SE
#> class: SummarizedExperiment
#> dim: 866091 2
#> metadata(0):
#> assays(1): beta
#> rownames(866091): cg00000029 cg00000103 ... ch.X.97737721F
#>   ch.X.98007042R
#> rowData names(0):
#> colnames(2): GSM3450524 GSM3450528
#> colData names(6): ID Sex ... Batch Position
```

## Step 2: Data cleaning

The first important step is data ‘cleaning’, which essentially means *reducing the beta matrix to the CpGs common to all datasets used in the muscle clock*. If some of the CpGs are not present in your beta-matrix, these missing values will be imputed.

```
GSE121961_SE_clean <- clean_beta(SE = GSE121961_SE,
                                 version = "MEAT2.0")
#> Cluster size 18712 broken into 13355 5357
#> Cluster size 13355 broken into 1809 11546
#> Cluster size 1809 broken into 872 937
#> Done cluster 872
#> Done cluster 937
#> Done cluster 1809
#> Cluster size 11546 broken into 4355 7191
#> Cluster size 4355 broken into 3154 1201
#> Cluster size 3154 broken into 1997 1157
#> Cluster size 1997 broken into 1497 500
#> Done cluster 1497
#> Done cluster 500
#> Done cluster 1997
#> Done cluster 1157
#> Done cluster 3154
#> Done cluster 1201
#> Done cluster 4355
#> Cluster size 7191 broken into 2960 4231
#> Cluster size 2960 broken into 1555 1405
#> Cluster size 1555 broken into 546 1009
#> Done cluster 546
#> Done cluster 1009
#> Done cluster 1555
#> Done cluster 1405
#> Done cluster 2960
#> Cluster size 4231 broken into 3042 1189
#> Cluster size 3042 broken into 2094 948
#> Cluster size 2094 broken into 1061 1033
#> Done cluster 1061
#> Done cluster 1033
#> Done cluster 2094
#> Done cluster 948
#> Done cluster 3042
#> Done cluster 1189
#> Done cluster 4231
#> Done cluster 7191
#> Done cluster 11546
#> Done cluster 13355
#> Cluster size 5357 broken into 3289 2068
#> Cluster size 3289 broken into 1295 1994
#> Done cluster 1295
#> Cluster size 1994 broken into 988 1006
#> Done cluster 988
#> Done cluster 1006
#> Done cluster 1994
#> Done cluster 3289
#> Cluster size 2068 broken into 1043 1025
#> Done cluster 1043
#> Done cluster 1025
#> Done cluster 2068
#> Done cluster 5357
```

Table: Top rows of the GSE121961 beta matrix after cleaning.

|  | GSM3450524 | GSM3450528 |
| --- | --- | --- |
| cg21432842 | 0.30 | 0.39 |
| cg15376097 | 0.20 | 0.26 |
| cg05876918 | 0.11 | 0.10 |
| cg25771195 | 0.64 | 0.67 |
| cg21380842 | 0.12 | 0.13 |
| cg00602891 | 0.09 | 0.08 |

## Step 3: Data calibration

The second step is data ‘calibration’, which essentially means *re-scaling the DNA methylation profiles to that of the gold standard dataset used to develop the muscle clock*. This step harmonises differences in data processing, sample preparation, lab-to-lab variability, to obtain accurate measures of epigenetic age in your samples.
Note that this ‘calibration’ is entirely different from the previously mentioned data preprocessing (i.e. probe and sample filtering, normalisation of Type I and Type II probes, and correction for batch effects). The calibration implemented in *BMIQcalibration()* does use code from the original BMIQ algorithm, but it is **not** used to normalize TypeI and TypeII probe methylation distribution. The *BMIQcalibration()* of the MEAT package re-scales the methylation distribution of your samples to the gold standard dataset GSE50498.

```
GSE121961_SE_calibrated <- BMIQcalibration(SE = GSE121961_SE_clean,
                                           version = "MEAT2.0")
#> [1] Inf
#> [1] 0.001738881
#> [1] 0.00248846
#> [1] 0.002669617
#> [1] 0.002586372
#> ii= 1
#> ii= 2
```

Table: Top rows of the GSE121961 beta matrix after cleaning and calibration.

|  | GSM3450524 | GSM3450528 |
| --- | --- | --- |
| cg21432842 | 0.2982808 | 0.3912860 |
| cg15376097 | 0.2008260 | 0.2645507 |
| cg05876918 | 0.1080761 | 0.0999306 |
| cg25771195 | 0.6296271 | 0.6642543 |
| cg21380842 | 0.1184438 | 0.1321498 |
| cg00602891 | 0.0874385 | 0.0786608 |

You can have a look at the distribution of DNA methylation before and after calibration with a density plot. On this plot, each line is an individual sample, and you can clearly see the bimodal distribution of DNA methylation data, with most CpGs harboring very low methylation levels (left side of the graph), very few CpGs with intermediate methylation levels, and some CpGs with high methylation levels.
Before calibration, the profiles do not align well with that of the gold standard, and this is problematic to obtain accurate estimates of epigenetic age. However, after calibration, the samples’ profiles overlap nicely with that of the gold standard.

```
data("gold.mean.MEAT2.0", envir = environment())
GSE121961_SE_clean_with_gold_mean <- cbind(assays(GSE121961_SE_clean)$beta,
                                           gold.mean.MEAT2.0$gold.mean) # add the gold mean
GSE121961_SE_calibrated_with_gold_mean <- cbind(assays(GSE121961_SE_calibrated)$beta,
                                                gold.mean.MEAT2.0$gold.mean) # add the gold mean
groups <- c(rep("GSE121961",
                ncol(GSE121961_SE_clean)), "Gold mean")

library(minfi)
par(mfrow = c(2, 1))
densityPlot(GSE121961_SE_clean_with_gold_mean,
  sampGroups = groups,
  main = "Before calibration",
  legend = FALSE
)
densityPlot(GSE121961_SE_calibrated_with_gold_mean,
  sampGroups = groups,
  main = "After calibration"
)
```

![plot of chunk DNA methylation profile distribution before and after calibration](figure/DNA methylation profile distribution before and after calibration-1.png)

## Step 4: Epigenetic age estimation

Your quest is almost over! The only spell left to cast is *epiage\_estimation()* that uses methylation levels at the clock CpGs to estimate epigenetic age.
If you do not have information on age, *epiage\_estimation()* will only return epigenetic age (“DNAmage”). However, if you have information on age (and other phenotypes), *epiage\_estimation()* will return:

* epigenetic age (**DNAmage**)
* age acceleration calculated as the difference between epigenetic age and actual age (**AAdiff**)
* age acceleration calculated as the residuals of a regression of predicted age against actual age (**AAresid**) **if you have at least n > 2 samples in your beta-matrix**, since AAresid cannot be estimated with only n = 2 samples.

While AAdiff is a straightforward way of calculating the error in age prediction, it is sensitive to the mean age of the dataset and to the pre-processing of the DNA methylation dataset; AAdiff can be biased upwards or downwards depending on how the dataset was normalized, and depending on the mean age and age variance of the dataset. In contrast, AAresid is insensitive to the mean age of the dataset and is robust against different pre-processing methods.

```
GSE121961_SE_epiage <- epiage_estimation(SE = GSE121961_SE_calibrated,
                                         age_col_name = "Age",
                                         version = "MEAT2.0")
#> function (x)  .Primitive("dim")
```

Table: Phenotypes corresponding to GSE121961 with AAdiff for each sample.

|  | ID | Sex | Age | Group | Batch | Position | DNAmage | AAdiff |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GSM3450524 | GSM3450524 | M | NA | Control | 202128330007 | R01C01 | 48.60063 | NA |
| GSM3450528 | GSM3450528 | F | 14 | SELENON | 202128330007 | R07C01 | 15.87190 | 1.871902 |

## Session information

```
sessionInfo()
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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] minfi_1.56.0                bumphunter_1.52.0
#>  [3] locfit_1.5-9.12             iterators_1.0.14
#>  [5] foreach_1.5.2               Biostrings_2.78.0
#>  [7] XVector_0.50.0              SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [15] generics_0.1.4              MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           MEAT_1.22.0
#> [19] knitr_1.50                  BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
#>   [3] shape_1.4.6.1             magrittr_2.0.4
#>   [5] GenomicFeatures_1.62.0    rmarkdown_2.30
#>   [7] BiocIO_1.20.0             vctrs_0.6.5
#>   [9] multtest_2.66.0           memoise_2.0.1
#>  [11] Rsamtools_2.26.0          DelayedMatrixStats_1.32.0
#>  [13] RCurl_1.98-1.17           askpass_1.2.1
#>  [15] htmltools_0.5.8.1         S4Arrays_1.10.0
#>  [17] dynamicTreeCut_1.63-1     curl_7.0.0
#>  [19] Rhdf5lib_1.32.0           SparseArray_1.10.0
#>  [21] rhdf5_2.54.0              RPMM_1.25
#>  [23] KernSmooth_2.23-26        nor1mix_1.3-3
#>  [25] plyr_1.8.9                impute_1.84.0
#>  [27] cachem_1.1.0              GenomicAlignments_1.46.0
#>  [29] lifecycle_1.0.4           pkgconfig_2.0.3
#>  [31] Matrix_1.7-4              R6_2.6.1
#>  [33] fastmap_1.2.0             digest_0.6.37
#>  [35] siggenes_1.84.0           reshape_0.8.10
#>  [37] AnnotationDbi_1.72.0      RSQLite_2.4.3
#>  [39] base64_2.0.2              mgcv_1.9-3
#>  [41] httr_1.4.7                abind_1.4-8
#>  [43] compiler_4.5.1            beanplot_1.3.1
#>  [45] rngtools_1.5.2            withr_3.0.2
#>  [47] bit64_4.6.0-1             BiocParallel_1.44.0
#>  [49] DBI_1.2.3                 HDF5Array_1.38.0
#>  [51] MASS_7.3-65               openssl_2.3.4
#>  [53] DelayedArray_0.36.0       rjson_0.2.23
#>  [55] tools_4.5.1               rentrez_1.2.4
#>  [57] methylumi_2.56.0          glue_1.8.0
#>  [59] quadprog_1.5-8            h5mread_1.2.0
#>  [61] restfulr_0.0.16           nlme_3.1-168
#>  [63] rhdf5filters_1.22.0       grid_4.5.1
#>  [65] cluster_2.1.8.1           tzdb_0.5.0
#>  [67] preprocessCore_1.72.0     tidyr_1.3.1
#>  [69] data.table_1.17.8         hms_1.1.4
#>  [71] xml2_1.4.1                lumi_2.62.0
#>  [73] pillar_1.11.1             stringr_1.5.2
#>  [75] limma_3.66.0              ROC_1.86.0
#>  [77] genefilter_1.92.0         splines_4.5.1
#>  [79] dplyr_1.1.4               lattice_0.22-7
#>  [81] survival_3.8-3            rtracklayer_1.70.0
#>  [83] bit_4.6.0                 GEOquery_2.78.0
#>  [85] annotate_1.88.0           tidyselect_1.2.1
#>  [87] xfun_0.53                 scrime_1.3.5
#>  [89] statmod_1.5.1             UCSC.utils_1.6.0
#>  [91] stringi_1.8.7             yaml_2.3.10
#>  [93] evaluate_1.0.5            codetools_0.2-20
#>  [95] cigarillo_1.0.0           tibble_3.3.0
#>  [97] BiocManager_1.30.26       affyio_1.80.0
#>  [99] cli_3.6.5                 xtable_1.8-4
#> [101] GenomeInfoDb_1.46.0       Rcpp_1.1.0
#> [103] png_0.1-8                 XML_3.99-0.19
#> [105] readr_2.1.5               blob_1.2.4
#> [107] mclust_6.1.1              doRNG_1.8.6.2
#> [109] sparseMatrixStats_1.22.0  bitops_1.0-9
#> [111] glmnet_4.1-10             affy_1.88.0
#> [113] illuminaio_0.52.0         nleqslv_3.3.5
#> [115] purrr_1.1.0               wateRmelon_2.16.0
#> [117] crayon_1.5.3              rlang_1.1.6
#> [119] KEGGREST_1.50.0
```