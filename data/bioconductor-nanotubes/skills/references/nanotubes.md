# Cap Analysis of Gene Expression (CAGE) data from mouse nanotube experiment

Malte Thodberg

#### 4 November 2025

#### Abstract

Cap Analysis of Gene Expression (CAGE) data from mouse lung biopsies, obtained from “Identification of Gene Transcription Start Sites and Enhancers Responding to Pulmonary Carbon Nanotube Exposure in Vivo” by Bornholdt et al. The package includes the study design (Ctrl samples vs Nano samples treated with nanotubes) and CAGE Transcription Start Site (CTSS) data stored as BigWig-files.

#### Package

nanotubes 1.26.0

# Contents

* [1 Installation](#installation)
* [2 Citation](#citation)
* [3 Getting help](#getting-help)
* [4 Data description](#data-description)
* [5 Accessing study design and BigWig-Files](#accessing-study-design-and-bigwig-files)
* [6 Importing into CAGEfightR](#importing-into-cagefightr)
* [7 Session info](#session-info)

# 1 Installation

Install the most recent stable version from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("nanotubes")
```

And load `nanotubes`:

```
library(nanotubes)
```

Alternatively, you can install the development version directly from GitHub using `devtools`:

```
devtools::install_github("MalteThodberg/nanotubes")
```

# 2 Citation

If you use nanotubes, please cite the following article:

```
citation("nanotubes")
```

```
## To cite package 'nanotubes' in publications use:
##
##   Bornholdt et al. Identification of Gene Transcription Start Sites and
##   Enhancers Responding to Pulmonary Carbon Nanotube Exposure in Vivo,
##   ACS Nano (2017)
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {Identification of Gene Transcription Start Sites and Enhancers Responding to Pulmonary Carbon Nanotube Exposure in Vivo},
##     author = {Jette Bornholdt and Anne Thoustrup Saber and Berit Lilje and Mette Boyd and Mette Jørgensen and Yun Chen and Morana Vitezic and Nicklas Raun Jacobsen and Sarah Søs Poulsen and Trine Berthing and Simon Bressendorff and Kristoffer Vitting-Seerup and Robin Andersson and Karin Sørig Hougaard and Carole L. Yauk and Sabina Halappanavar and Håkan Wallin and Ulla Vogel and Albin Sandelin},
##     year = {2017},
##     journal = {ACS Nano},
##     doi = {10.1021/acsnano.6b07533},
##     volume = {11},
##     number = {4},
##     pages = {3597-3613},
##   }
```

# 3 Getting help

For general questions about the usage of nanotubes, use the [official Bioconductor support forum](https://support.bioconductor.org) and tag your question “nanotubes”. We strive to answer questions as quickly as possible.

For technical questions, bug reports and suggestions for new features, we refer to the [nanotubes github page](https://github.com/MalteThodberg/nanotubes/issues)

# 4 Data description

CAGE Transcription Start Sites (CTSSs), the number of CAGE tag 5’-end mapping to each genomic location data was obtained from the authors of the original study. Remaining data used in the study can be downloaded from [GSE70386](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE70386).

One technical replicate was not included.

# 5 Accessing study design and BigWig-Files

Load the data into R to get an overview of the included samples:

```
data("nanotubes")
knitr::kable(nanotubes)
```

|  | Class | Name | BigWigPlus | BigWigMinus |
| --- | --- | --- | --- | --- |
| C547 | Ctrl | C547 | mm9.CAGE\_7J7P\_NANO\_KON\_547.plus.bw | mm9.CAGE\_7J7P\_NANO\_KON\_547.minus.bw |
| C548 | Ctrl | C548 | mm9.CAGE\_ULAC\_NANO\_KON\_548.plus.bw | mm9.CAGE\_ULAC\_NANO\_KON\_548.minus.bw |
| C549 | Ctrl | C549 | mm9.CAGE\_YM4F\_Nano\_KON\_549.plus.bw | mm9.CAGE\_YM4F\_Nano\_KON\_549.minus.bw |
| C559 | Ctrl | C559 | mm9.CAGE\_RSAM\_NANO\_559.plus.bw | mm9.CAGE\_RSAM\_NANO\_559.minus.bw |
| C560 | Ctrl | C560 | mm9.CAGE\_CCLF\_NANO\_560.plus.bw | mm9.CAGE\_CCLF\_NANO\_560.minus.bw |
| N13 | Nano | N13 | mm9.CAGE\_KTRA\_Nano\_13.plus.bw | mm9.CAGE\_KTRA\_Nano\_13.minus.bw |
| N14 | Nano | N14 | mm9.CAGE\_RSAM\_NANO\_14.plus.bw | mm9.CAGE\_RSAM\_NANO\_14.minus.bw |
| N15 | Nano | N15 | mm9.CAGE\_RFQS\_Nano\_15.plus.bw | mm9.CAGE\_RFQS\_Nano\_15.minus.bw |
| N16 | Nano | N16 | mm9.CAGE\_CCLF\_NANO\_16.plus.bw | mm9.CAGE\_CCLF\_NANO\_16.minus.bw |
| N17 | Nano | N17 | mm9.CAGE\_RSAM\_NANO\_17.plus.bw | mm9.CAGE\_RSAM\_NANO\_17.minus.bw |
| N18 | Nano | N18 | mm9.CAGE\_CCLF\_NANO\_18.plus.bw | mm9.CAGE\_CCLF\_NANO\_18.minus.bw |

Load a data from a BigWig-file into R using the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package:

```
library(rtracklayer)
bw_fname <- system.file("extdata", nanotubes$BigWigPlus[1],
                        package = "nanotubes",
                        mustWork = TRUE)
import(bw_fname)
```

```
## GRanges object with 1055261 ranges and 1 metadata column:
##                seqnames    ranges strand |     score
##                   <Rle> <IRanges>  <Rle> | <numeric>
##         [1]        chr1   3297935      * |         1
##         [2]        chr1   3405982      * |         1
##         [3]        chr1   3575580      * |         1
##         [4]        chr1   3612051      * |         1
##         [5]        chr1   3638567      * |         2
##         ...         ...       ...    ... .       ...
##   [1055257] chrY_random  52340197      * |         1
##   [1055258] chrY_random  55206004      * |         1
##   [1055259] chrY_random  55312786      * |         1
##   [1055260] chrY_random  56729517      * |         1
##   [1055261] chrY_random  56966442      * |         1
##   -------
##   seqinfo: 29 sequences from an unspecified genome
```

# 6 Importing into CAGEfightR

The data contained in the package is correctly formatted for analysis with the *[CAGEfightR](https://bioconductor.org/packages/3.22/CAGEfightR)* package:

```
library(CAGEfightR)

# Setup paths
bw_plus <- system.file("extdata", nanotubes$BigWigPlus,
                        package = "nanotubes",
                        mustWork = TRUE)
bw_minus <- system.file("extdata", nanotubes$BigWigMinus,
                        package = "nanotubes",
                        mustWork = TRUE)

# Save as named BigWigFileList
bw_plus <- BigWigFileList(bw_plus)
bw_minus <- BigWigFileList(bw_minus)
names(bw_plus) <- names(bw_minus) <- nanotubes$Name

# Quantify
CTSSs <- quantifyCTSSs(bw_plus, bw_minus, design=nanotubes)
```

See the [CAGEfightR vignette](https://bioconductor.org/packages/release/bioc/vignettes/CAGEfightR/inst/doc/Introduction_to_CAGEfightR.html) for more details.

# 7 Session info

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
## [1] rtracklayer_1.70.0   GenomicRanges_1.62.0 Seqinfo_1.0.0
## [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [7] generics_0.1.4       nanotubes_1.26.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 SparseArray_1.10.1
##  [3] bitops_1.0-9                lattice_0.22-7
##  [5] digest_0.6.37               evaluate_1.0.5
##  [7] grid_4.5.1                  bookdown_0.45
##  [9] fastmap_1.2.0               jsonlite_2.0.0
## [11] Matrix_1.7-4                cigarillo_1.0.0
## [13] restfulr_0.0.16             BiocManager_1.30.26
## [15] httr_1.4.7                  XML_3.99-0.19
## [17] Biostrings_2.78.0           codetools_0.2-20
## [19] jquerylib_0.1.4             abind_1.4-8
## [21] cli_3.6.5                   rlang_1.1.6
## [23] crayon_1.5.3                XVector_0.50.0
## [25] Biobase_2.70.0              cachem_1.1.0
## [27] DelayedArray_0.36.0         yaml_2.3.10
## [29] S4Arrays_1.10.0             tools_4.5.1
## [31] parallel_4.5.1              BiocParallel_1.44.0
## [33] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
## [35] curl_7.0.0                  R6_2.6.1
## [37] BiocIO_1.20.0               matrixStats_1.5.0
## [39] lifecycle_1.0.4             bslib_0.9.0
## [41] xfun_0.54                   GenomicAlignments_1.46.0
## [43] MatrixGenerics_1.22.0       knitr_1.50
## [45] rjson_0.2.23                htmltools_0.5.8.1
## [47] rmarkdown_2.30              compiler_4.5.1
## [49] RCurl_1.98-1.17
```