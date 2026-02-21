# selectKSigs: a package for selecting the number of mutational signatures

Zhi Yang1\*

1Department of Preventive Medicine, University of Southern California, Los Angeles, USA

\*zyang895@gmail.com

#### 2025-10-30

#### Abstract

Instructions on using *selectKSigs* on selecting the number of mutational
signatures using a perplexity-based measure and cross-validation

# 1 Introduction

The R package **HiLDA** is developed under the Bayesian framework to select the
number of mutational signatures based on perplexity and cross-validation. The
mutation signature is defined based on the independent model proposed by
Shiraishi’s et al.

## 1.1 Paper

* Shiraishi et al. A simple model-based approach to inferring and visualizing
  cancer mutation signatures, bioRxiv, doi:
  <http://dx.doi.org/10.1101/019901>.
* **Zhi Yang**, Paul Marjoram, Kimberly D. Siegmund. Selecting the number of
  mutational signatures using a perplexity-based measure and cross-validation.

# 2 Installing and loading the package

## 2.1 Installation

### 2.1.1 Bioconductor

**selectKSigs** requires several CRAN and Bioconductor R packages to be
installed. Dependencies are usually handled automatically, when installing the
package using the following commands:

```
install.packages("BiocManager")
BiocManager::install("selectKSigs")
```

[NOTE: Ignore the first line if you already have installed the
*[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)*.]

You can also download the newest version from the GitHub using *devtools*:

```
devtools::install_github("USCbiostats/selectKSigs")
```

# 3 Input data

`selectKSigs` is a package built on some basic functions from `pmsignature`
including how to read the input data. Here is an example from `pmsignature` on
the input data, *mutation features* are elements used for categorizing mutations
such as:

* 6 substitutions (C>A, C>G, C>T, T>A, T>C and T>G)
* 2 flanking bases (A, C, G and T)
* transcription direction.

## 3.1 Mutation Position Format

```
sample1 chr1  100   A   C
sample1 chr1    200 A   T
sample1 chr2    100 G   T
sample2 chr1    300 T   C
sample3 chr3    400 T   C
```

* The 1st column shows the name of samples
* The 2nd column shows the name of chromosome
* The 3rd column shows the coordinate in the chromosome
* The 4th column shows the reference base (A, C, G, or T).
* The 5th colum shows the alternate base (A, C, G, or T).

# 4 Workflow

## 4.1 Get input data

Here, *inputFile* is the path for the input file. *numBases* is the number of
flanking bases to consider including the central base (if you want to consider
two 5’ and 3’ bases, then set 5). Also, you can add transcription direction
information using *trDir*. *numSig* sets the number of mutation signatures
estimated from the input data. You will see a warning message on some mutations
are being removed.

```
library(HiLDA)
```

```
## Loading required package: ggplot2
```

```
library(tidyr)
library(ggplot2)
library(dplyr)
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
inputFile <- system.file("extdata/esophageal.mp.txt.gz", package="HiLDA")
G <- hildaReadMPFile(inputFile, numBases=5, trDir=TRUE)
```

```
## Warning in hildaReadMPFile(inputFile, numBases = 5, trDir = TRUE): Out of 24861
## mutations, we could obtaintranscription direction information for 24819
## mutation. Other mutations are removed.
```

Also, we also provided a small simulated dataset which contains 10 mutational
catalogs and used it for demonstrating the key functions in selectKSigs. We start
with loading the sample dataset G stored as extdata/sample.rdata.

```
library(selectKSigs)
load(system.file("extdata/sample.rdata", package = "selectKSigs"))
```

### 4.1.1 Perform the selecting process

After we read in the sample data G, we can run the process from selectKSigs.
Here, we specify the *inputG* as *G*, the number of cross-validation folds,
*kfold* to be 3, the number of replications, *nRep*, to be 3, and the upper
limit of the K values for exploration to be 7.

### 4.1.2 Visualizing the results

After we obtained the results, we can plot each measure by the range of K values
that were refitted during the calculation. The optimal value of K is achieved at
its minimum value highlighted in grey.

```
results$Kvalue <- seq_len(nrow(results)) + 1
results_df <- gather(results, Method, value, -Kvalue) %>%
  group_by(Method) %>%
  mutate(xmin = which.min(value) + 1 - 0.1,
         xmax = which.min(value) + 1 + 0.1)

ggplot(results_df) +
  geom_point(aes(x = Kvalue, y = value, color = Method), size = 2) +
  facet_wrap(~ Method, scales = "free") +
  geom_rect(mapping = aes(xmin = xmin, xmax = xmax,
                          ymin = -Inf, ymax = Inf),
            fill = 'grey', alpha = 0.05) +
  theme_bw()+
  xlab("Number of signatures")
```

![](data:image/png;base64...)

## 4.2 Session info

Here is the output of `sessionInfo()` for reproducibility in the future.

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
## [1] selectKSigs_1.22.0 dplyr_1.1.4        tidyr_1.3.1        HiLDA_1.24.0
## [5] ggplot2_4.0.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1
##  [2] blob_1.2.4
##  [3] farver_2.1.2
##  [4] rjags_4-17
##  [5] Biostrings_2.78.0
##  [6] S7_0.2.0
##  [7] bitops_1.0-9
##  [8] fastmap_1.2.0
##  [9] RCurl_1.98-1.17
## [10] GenomicAlignments_1.46.0
## [11] XML_3.99-0.19
## [12] digest_0.6.37
## [13] lifecycle_1.0.4
## [14] R2jags_0.8-9
## [15] KEGGREST_1.50.0
## [16] RSQLite_2.4.3
## [17] magrittr_2.0.4
## [18] compiler_4.5.1
## [19] rlang_1.1.6
## [20] sass_0.4.10
## [21] tools_4.5.1
## [22] yaml_2.3.10
## [23] rtracklayer_1.70.0
## [24] knitr_1.50
## [25] labeling_0.4.3
## [26] S4Arrays_1.10.0
## [27] bit_4.6.0
## [28] curl_7.0.0
## [29] DelayedArray_0.36.0
## [30] RColorBrewer_1.1-3
## [31] abind_1.4-8
## [32] BiocParallel_1.44.0
## [33] withr_3.0.2
## [34] purrr_1.1.0
## [35] BiocGenerics_0.56.0
## [36] grid_4.5.1
## [37] stats4_4.5.1
## [38] gtools_3.9.5
## [39] scales_1.4.0
## [40] tinytex_0.57
## [41] dichromat_2.0-0.1
## [42] SummarizedExperiment_1.40.0
## [43] cli_3.6.5
## [44] rmarkdown_2.30
## [45] crayon_1.5.3
## [46] generics_0.1.4
## [47] httr_1.4.7
## [48] rjson_0.2.23
## [49] DBI_1.2.3
## [50] cachem_1.1.0
## [51] stringr_1.5.2
## [52] parallel_4.5.1
## [53] AnnotationDbi_1.72.0
## [54] BiocManager_1.30.26
## [55] XVector_0.50.0
## [56] restfulr_0.0.16
## [57] matrixStats_1.5.0
## [58] vctrs_0.6.5
## [59] boot_1.3-32
## [60] Matrix_1.7-4
## [61] jsonlite_2.0.0
## [62] bookdown_0.45
## [63] IRanges_2.44.0
## [64] S4Vectors_0.48.0
## [65] bit64_4.6.0-1
## [66] magick_2.9.0
## [67] GenomicFeatures_1.62.0
## [68] jquerylib_0.1.4
## [69] R2WinBUGS_2.1-23
## [70] glue_1.8.0
## [71] codetools_0.2-20
## [72] cowplot_1.2.0
## [73] stringi_1.8.7
## [74] gtable_0.3.6
## [75] BiocIO_1.20.0
## [76] GenomicRanges_1.62.0
## [77] tibble_3.3.0
## [78] pillar_1.11.1
## [79] htmltools_0.5.8.1
## [80] Seqinfo_1.0.0
## [81] BSgenome.Hsapiens.UCSC.hg19_1.4.3
## [82] BSgenome_1.78.0
## [83] R6_2.6.1
## [84] evaluate_1.0.5
## [85] lattice_0.22-7
## [86] Biobase_2.70.0
## [87] png_0.1-8
## [88] Rsamtools_2.26.0
## [89] cigarillo_1.0.0
## [90] memoise_2.0.1
## [91] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [92] bslib_0.9.0
## [93] Rcpp_1.1.0
## [94] coda_0.19-4.1
## [95] SparseArray_1.10.0
## [96] xfun_0.53
## [97] MatrixGenerics_1.22.0
## [98] forcats_1.0.1
## [99] pkgconfig_2.0.3
```