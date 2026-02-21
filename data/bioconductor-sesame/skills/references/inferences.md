[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/sesame.html)](index.html)

* [Basics](sesame.html)
* [QC](QC.html)
* [Non-human Array](nonhuman.html)
* [Modeling](modeling.html)
* [Inference](inferences.html)
* [KnowYourCG](https://bioconductor.org/packages/release/bioc/html/knowYourCG.html)
* [Supplemental](https://zhou-lab.github.io/sesame/dev/supplemental.html)

# Sample Metadata Inference

#### 25 November 2025

SeSAMe implements inference of sex, age, ethnicity. These are valuable information for checking the integrity of the experiment and detecting sample swaps.

# Sex, XCI

Sex is inferred based on our curated X-linked probes and Y chromosome probes excluding pseudo-autosomal regions and XCI escapes.

Human:

```
betas = openSesame(sesameDataGet("EPICv2.8.SigDF")[[1]])
inferSex(betas)
```

```
## [1] "FEMALE"
```

Mouse:

```
betas = openSesame(sesameDataGet("MM285.1.SigDF"))
inferSex(betas)
```

```
## [1] "MALE"
```

# Age & Epigenetic Clock

SeSAMe provides age regression through multiple previously established models, e.g., the well-known Horvath 353 model ([Horvath 2013](https://pubmed.ncbi.nlm.nih.gov/24138928/)) which returns the chronological age in the number of years. Here is an example:

```
betas <- sesameDataGet('HM450.1.TCGA.PAAD')$betas
## download clock file from http://zwdzwd.github.io/InfiniumAnnotation
model <- readRDS("~/Downloads/Clock_Horvath353.rds")
predictAge(betas, model)
```

And MM285 mouse array data using a set of 347 CpGs (see [Zhou et al. 2022](https://www.cell.com/cell-genomics/fulltext/S2666-979X%2822%2900077-5)) The function returns the age in the number of months. We recommend using SeSAMe preprocessed data as input to the function. Here’s an example:

```
library(SummarizedExperiment)
betas <- assay(sesameDataGet("MM285.10.SE.tissue"))[,1]
## download clock file from http://zwdzwd.github.io/InfiniumAnnotation
model <- readRDS("~/Downloads/Clock_Zhou347.rds")
predictAge(betas, model)
```

This indicates that this mouse is approximately 1.41 months old. The function looks for overlapping probes and estimates age using the corresponding clock models.

# Copy Number

See [Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#cnv)

# Cell Count Deconvolution

SeSAMe estimates leukocyte fraction using a two-component model.This function works for samples whose targeted cell-of-origin is not related to white blood cells.

```
betas.tissue <- sesameDataGet('HM450.1.TCGA.PAAD')$betas
estimateLeukocyte(betas.tissue)
```

```
## [1] 0.2007592
```

# Genomic Privacy

The goal of data sanitization is to modifiy IDAT files in place, so they can be released to public domain without privacy leak. This will be achieved by deIdentification.

Let’s take DNA methylation data from the HM450 platform for example. First, let’s download test IDATs from <https://github.com/zhou-lab/InfiniumAnnotationV1/tree/main/Test>

## De-identify by Masking

This first method of deIdentification masks SNP probe intensity mean by zero. As a consequence, the allele frequency will be 0.5.

```
deIdentify("~/Downloads/3999492009_R01C01_Grn.idat",
    "~/Downloads/deidentified_Grn.idat")
deIdentify("~/Downloads/3999492009_R01C01_Red.idat",
    "~/Downloads/deidentified_Red.idat")

betas1 = getBetas(readIDATpair("~/Downloads/3999492009_R01C01"))
betas2 = getBetas(readIDATpair("~/Downloads/deidentified"))

head(betas1[grep('rs',names(betas1))])
head(betas2[grep('rs',names(betas2))])
```

Note that before deIdentify, the rs values will all be different. After deIdentify, the rs values will all be masked at an intensity of 0.5.

## De-identify by Scrambling

This second method of deIdentification will scramble the intensities using a secret key to help formalize a random number. Therefore, randomize needs to be set to TRUE.

```
my_secret <- 13412084
set.seed(my_secret)

deIdentify("~/Downloads/3999492009_R01C01_Grn.idat",
    "~/Downloads/deidentified_Grn.idat", randomize=TRUE)

my_secret <- 13412084
set.seed(my_secret)
deIdentify("~/Downloads/3999492009_R01C01_Red.idat",
    "~/Downloads/deidentified_Red.idat", randomize=TRUE)

betas1 = getBetas(readIDATpair("~/Downloads/3999492009_R01C01"))
betas2 = getBetas(readIDATpair("~/Downloads/deidentified"))

head(betas1[grep('rs',names(betas1))])
head(betas2[grep('rs',names(betas2))])
```

Note that the rs values are scrambled after deIdentify.

## Re-identify

To restore order of the deIdentified intensities, one can re-identify IDATs. The reIdentify function can thus restore the scrambled SNP intensities.

```
my_secret <- 13412084
set.seed(my_secret)

reIdentify(sprintf("%s/deidentified_Grn.idat", tmp),
    sprintf("%s/reidentified_Grn.idat", tmp))

my_secret <- 13412084
set.seed(my_secret)
reIdentify("~/Downloads/deidentified_Red.idat",
    "~/Downloads/reidentified_Red.idat")

betas1 = getBetas(readIDATpair("~/Downloads/3999492009_R01C01"))
betas2 = getBetas(readIDATpair("~/Downloads/reidentified"))

head(betas1[grep('rs',names(betas1))])
head(betas2[grep('rs',names(betas2))])
```

Note that reIdentify restored the values. Subsequently, they are the same as betas1.

# Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] knitr_1.50          sesame_1.28.1       sesameData_1.28.0
## [4] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
## [7] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] filelock_1.0.3              Biostrings_2.78.0
##  [7] S7_0.2.1                    fastmap_1.2.0
##  [9] digest_0.6.39               lifecycle_1.0.4
## [11] KEGGREST_1.50.0             RSQLite_2.4.4
## [13] magrittr_2.0.4              compiler_4.5.2
## [15] rlang_1.1.6                 sass_0.4.10
## [17] tools_4.5.2                 yaml_2.3.10
## [19] S4Arrays_1.10.0             bit_4.6.0
## [21] curl_7.0.0                  DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] abind_1.4-8                 BiocParallel_1.44.0
## [27] withr_3.0.2                 purrr_1.2.0
## [29] grid_4.5.2                  stats4_4.5.2
## [31] preprocessCore_1.72.0       wheatmap_0.2.0
## [33] colorspace_2.1-2            ggplot2_4.0.1
## [35] MASS_7.3-65                 scales_1.4.0
## [37] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [39] cli_3.6.5                   rmarkdown_2.30
## [41] crayon_1.5.3                reshape2_1.4.5
## [43] httr_1.4.7                  tzdb_0.5.0
## [45] DBI_1.2.3                   cachem_1.1.0
## [47] stringr_1.6.0               parallel_4.5.2
## [49] AnnotationDbi_1.72.0        BiocManager_1.30.27
## [51] XVector_0.50.0              matrixStats_1.5.0
## [53] vctrs_0.6.5                 Matrix_1.7-4
## [55] jsonlite_2.0.0              IRanges_2.44.0
## [57] hms_1.1.4                   S4Vectors_0.48.0
## [59] bit64_4.6.0-1               fontawesome_0.5.3
## [61] jquerylib_0.1.4             glue_1.8.0
## [63] codetools_0.2-20            stringi_1.8.7
## [65] gtable_0.3.6                BiocVersion_3.22.0
## [67] GenomicRanges_1.62.0        tibble_3.3.0
## [69] pillar_1.11.1               rappdirs_0.3.3
## [71] htmltools_0.5.8.1           Seqinfo_1.0.0
## [73] R6_2.6.1                    httr2_1.2.1
## [75] evaluate_1.0.5              Biobase_2.70.0
## [77] lattice_0.22-7              readr_2.1.6
## [79] png_0.1-8                   memoise_2.0.1
## [81] BiocStyle_2.38.0            bslib_0.9.0
## [83] Rcpp_1.1.0                  SparseArray_1.10.3
## [85] xfun_0.54                   MatrixGenerics_1.22.0
## [87] pkgconfig_2.0.3
```