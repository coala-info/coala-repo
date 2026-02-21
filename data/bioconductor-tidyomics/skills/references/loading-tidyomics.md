# Loading the *tidyomics* ecosystem

## William Hutchison

### 2025-10-30

## Overview

The [tidyomics](https://github.com/tidyomics) ecosystem is a set of packages for omics data analysis that work together in harmony; they share common Bioconductor data representations and API design consistent with the [tidyverse](https://www.tidyverse.org/) ecosystem. The **tidyomics** package is designed to make it easy to install and load core packages from the *tidyomics* ecosystem with a single command.

The core packages are:

```
tidyomics_packages()
```

```
#  [1] "tidySummarizedExperiment" "tidySingleCellExperiment"
#  [3] "tidyseurat"               "plyranges"
#  [5] "tidySpatialExperiment"    "tidyomics"
```

## The tidyomics ecosystem

### Core packages

The core packages are automatically loaded when you run `library(tidyomics)`:

| Package | Intro | GitHub | Description |
| --- | --- | --- | --- |
| [tidySummarizedExperiment](https://stemangiola.github.io/tidySummarizedExperiment/) | [Vignette](https://stemangiola.github.io/tidySummarizedExperiment/articles/introduction.html) | [GitHub](https://github.com/stemangiola/tidySummarizedExperiment) | Tidy manipulation of SummarizedExperiment objects |
| [tidySingleCellExperiment](https://stemangiola.github.io/tidySingleCellExperiment) | [Vignette](https://stemangiola.github.io/tidySingleCellExperiment/articles/introduction.html) | [GitHub](https://github.com/stemangiola/tidySingleCellExperiment) | Tidy manipulation of SingleCellExperiment objects |
| [tidySeurat](https://stemangiola.github.io/tidyseurat/) | [Vignette](https://stemangiola.github.io/tidyseurat/articles/introduction.html) | [GitHub](https://github.com/stemangiola/tidyseurat) | Tidy manipulation of Seurat objects |
| [tidySpatialExperiment](https://william-hutchison.github.io/tidySpatialExperiment/) | [Vignette](https://william-hutchison.github.io/tidySpatialExperiment/articles/overview.html) | [GitHub](https://github.com/william-hutchison/tidySpatialExperiment) | Tidy manipulation of SpatialExperiment objects |
| [plyranges](https://sa-lee.github.io/plyranges/) | [Vignette](https://sa-lee.github.io/plyranges/articles/an-introduction.html) | [GitHub](https://github.com/sa-lee/plyranges) | Tidy manipulation of genomics ranges |

### Additional manipulation packages

| Package | Intro | GitHub | Description |
| --- | --- | --- | --- |
| [plyinteractions](https://tidyomics.github.io/plyinteractions/) | [Vignette](https://tidyomics.github.io/plyinteractions/articles/plyinteractions.html) | [GitHub](https://github.com/tidyomics/plyinteractions) | Tidy manipulation of genomic interactions |

**plyinteractions** is under evaluation for inclusion in the core packages in future Bioconductor releases.

### Analysis packages

| Package | Intro | GitHub | Description |
| --- | --- | --- | --- |
| [tidybulk](https://stemangiola.github.io/tidybulk/) | [Vignette](https://stemangiola.github.io/tidybulk/articles/introduction.html) | [GitHub](https://github.com/stemangiola/tidybulk/) | Tidy bulk RNA-seq data analysis |
| [nullranges](https://nullranges.github.io/nullranges/) | [Vignette](https://nullranges.github.io/nullranges/articles/nullranges.html) | [GitHub](https://github.com/nullranges/nullranges/) | Generation of null genomic range sets |

## Installation

Installing the **tidyomics** package will install all core packages of the *tidyomics* ecosystem. The **tidyomics** package can be installed from Bioconductor:

```
BiocManager::install("tidyomics")
```

Additional packages can be installed independently as needed:

```
# Additional manipulation package
BiocManager::install("plyinteractions")

# Analysis packages
BiocManager::install("tidybulk")
BiocManager::install("nullranges")
```

## Loading the *tidyomics* ecosystem

The core *tidyomics* packages can be attached with:

```
library(tidyomics)
```

This command also produces a summary of package versions and function conflicts. Function conflicts are a point of ongoing development and will be addressed over time.

Additional packages can be loaded independently as needed:

```
# Additional manipulation package
library(plyinteractions)

# Analysis packages
library(tidybulk)
library(nullranges)
```

You are now ready to start using the *tidyomics* ecosystem.

```
sessionInfo()
#  R version 4.5.1 Patched (2025-08-23 r88802)
#  Platform: x86_64-pc-linux-gnu
#  Running under: Ubuntu 24.04.3 LTS
#
#  Matrix products: default
#  BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#  LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#
#  locale:
#   [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#   [3] LC_TIME=en_GB              LC_COLLATE=C
#   [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#   [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#   [9] LC_ADDRESS=C               LC_TELEPHONE=C
#  [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#
#  time zone: America/New_York
#  tzcode source: system (glibc)
#
#  attached base packages:
#  [1] stats     graphics  grDevices utils     datasets  methods   base
#
#  loaded via a namespace (and not attached):
#   [1] compiler_4.5.1  magrittr_2.0.4  cli_3.6.5       tools_4.5.1
#   [5] glue_1.8.0      tidyomics_1.6.0 vctrs_0.6.5     stringi_1.8.7
#   [9] knitr_1.50      stringr_1.5.2   xfun_0.53       lifecycle_1.0.4
#  [13] rlang_1.1.6     evaluate_1.0.5  purrr_1.1.0
```