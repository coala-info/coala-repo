# A quick introduction to the BSgenomeForge package

Atuhurira Kirabo Kakopo and Hervé Pagès

#### Modified: April 8, 2024; Compiled: December 01, 2025

#### Package

BSgenomeForge 1.10.2

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Basic usage](#basic-usage)
  + [3.1 Using `forgeBSgenomeDataPkgFromNCBI()`](#using-forgebsgenomedatapkgfromncbi)
  + [3.2 Using `forgeBSgenomeDataPkgFromUCSC()`](#using-forgebsgenomedatapkgfromucsc)
* [4 Final steps](#final-steps)
* [5 sessionInfo()](#sessioninfo)

# 1 Introduction

BSgenome data packages are one of the many types of annotation packages
available in [*Bioconductor*](https://bioconductor.org). They contain the
genomic sequences, which comprise chromosome sequences and other DNA
sequences of a particular genome assembly for a given organism. For example
*[BSgenome.Hsapiens.UCSC.hg19](https://bioconductor.org/packages/3.22/BSgenome.Hsapiens.UCSC.hg19)* is a BSgenome data package that
contains the genomic sequences of the hg19 genome from
[UCSC](https://genome.ucsc.edu/cgi-bin/hgGateway).
Users can easily and efficiently access the sequences, or portions of the
sequences, stored in these packages, via a common API implemented in the
*[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* software package.

Bioconductor currently provides more than [100 BSgenome data packages](https://bioconductor.org/packages/release/BiocViews.html#___BSgenome),
for more than 30 organisms. Most of them contain the genomic sequences of
*UCSC genomes* (i.e. genomes supported by the UCSC Genome Browser) or
*NCBI assemblies*. The packages are used in various Bioconductor workflows, as
well as in man page examples and vignettes of other Bioconductor packages,
typically in conjunction with tools available in the
*[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* and *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* software packages.
New BSgenome data packages get added on a regular basis, based on user demand.

The *[BSgenomeForge](https://bioconductor.org/packages/3.22/BSgenomeForge)* package provides tools that allow the user
to make their own BSgenome data package. The two primary tools in the package
are the `forgeBSgenomeDataPkgfromNCBI` and `forgeBSgenomeDataPkgfromUCSC`
functions. These functions allow the user to forge a BSgenome data package
for a given NCBI assembly or UCSC genome.

For other genome assemblies please consult the *Advanced BSgenomeForge usage*
vignettes also provided in this package.

# 2 Installation

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("BSgenomeForge")
```

# 3 Basic usage

## 3.1 Using `forgeBSgenomeDataPkgFromNCBI()`

```
library(BSgenomeForge)
```

**Example 1:** Information about assembly ASM972954v1 can be found at
<https://www.ncbi.nlm.nih.gov/assembly/GCF_009729545.1/>, including the assembly
accession, *GCA\_009729545.1* and organism name, *Acidianus infernus*. Assembly
ASM972954v1 does not contain any circular sequences to be specified:

```
forgeBSgenomeDataPkgFromNCBI(assembly_accession="GCA_009729545.1",
                             pkg_maintainer="Jane Doe <janedoe@gmail.com>",
                             organism="Acidianus infernus")
```

```
## Creating package in ./BSgenome.Ainfernus.NCBI.ASM972954v1
```

**Example 2:** Information about assembly ASM836960v1 can be found at
<https://www.ncbi.nlm.nih.gov/assembly/GCA_008369605.1/>, including the assembly
accession, *GCA\_008369605.1* and organism name, *Vibrio cholerae*.
Assembly ASM836960v1 contains three circular sequence, “1”, “2” and “unnamed”.
See CP043554.1, CP043556.1, and CP043555.1 in the NCBI Nucleotide database at
<https://www.ncbi.nlm.nih.gov/nuccore/>. They must be specified as shown in the
example below:

```
forgeBSgenomeDataPkgFromNCBI(assembly_accession="GCA_008369605.1",
                             pkg_maintainer="Jane Doe <janedoe@gmail.com>",
                             organism="Vibrio cholerae",
                             circ_seqs=c("1", "2", "unnamed"))
```

```
## Creating package in ./BSgenome.Vcholerae.NCBI.ASM836960v1
```

Check `?forgeBSgenomeDataPkgFromNCBI` for more information.

## 3.2 Using `forgeBSgenomeDataPkgFromUCSC()`

**Example 3:** Information about genome wuhCor1 can be found at
<https://genome.ucsc.edu/cgi-bin/hgGateway>. This belongs to the organism
*Severe acute respiratory syndrome coronavirus 2*. Genome wuhCor1 does not
contain any circular sequences to be specified:

```
forgeBSgenomeDataPkgFromUCSC(
    genome="wuhCor1",
    organism="Severe acute respiratory syndrome coronavirus 2",
    pkg_maintainer="Jane Doe <janedoe@gmail.com>"
)
```

```
## Creating package in ./BSgenome.Scoronavirus2.UCSC.wuhCor1
```

Check `?forgeBSgenomeDataPkgFromUCSC` for more information.

# 4 Final steps

`forgeBSgenomeDataPkgfromNCBI` or `forgeBSgenomeDataPkgfromUCSC` returns the
path to the created package at the end of its execution. This can be used to
find the package location, and afterwards carry out the following commands to
build the package source tarball via command line (i.e. in a Linux/Unix terminal
or Windows PowerShell terminal).

```
R CMD build <pkgdir>
```

where <pkgdir> is the path to the source tree of the package. Then check the
package with

```
R CMD check <tarball>
```

where <tarball> is the path to the tarball produced by R CMD build. Finally
install the package with

```
R CMD INSTALL <tarball>
```

These operations can also be carried out within R, instead, using the
*[devtools](https://CRAN.R-project.org/package%3Ddevtools)* package

```
devtools::build("./BSgenome.Ainfernus.NCBI.ASM972954v1")
```

```
## ── R CMD build ─────────────────────────────────────────────────────────────────
## * checking for file ‘/tmp/RtmpkvbJQL/Rbuild14550d312c16d2/BSgenomeForge/vignettes/BSgenome.Ainfernus.NCBI.ASM972954v1/DESCRIPTION’ ... OK
## * preparing ‘BSgenome.Ainfernus.NCBI.ASM972954v1’:
## * checking DESCRIPTION meta-information ... OK
## * checking for LF line-endings in source and make files and shell scripts
## * checking for empty or unneeded directories
## * building ‘BSgenome.Ainfernus.NCBI.ASM972954v1_1.0.0.tar.gz’
```

```
## [1] "/tmp/RtmpkvbJQL/Rbuild14550d312c16d2/BSgenomeForge/vignettes/BSgenome.Ainfernus.NCBI.ASM972954v1_1.0.0.tar.gz"
```

```
devtools::check_built("BSgenome.Ainfernus.NCBI.ASM972954v1_1.0.0.tar.gz")
```

```
devtools::install_local("BSgenome.Ainfernus.NCBI.ASM972954v1_1.0.0.tar.gz")
```

# 5 sessionInfo()

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenomeForge_1.10.2 BSgenome_1.78.0      rtracklayer_1.70.0
##  [4] BiocIO_1.20.0        GenomicRanges_1.62.0 Biostrings_2.78.0
##  [7] XVector_0.50.0       GenomeInfoDb_1.46.1  Seqinfo_1.0.0
## [10] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [13] generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
##  [3] xfun_0.54                   bslib_0.9.0
##  [5] devtools_2.4.6              remotes_2.5.0
##  [7] processx_3.8.6              Biobase_2.70.0
##  [9] lattice_0.22-7              callr_3.7.6
## [11] ps_1.9.1                    vctrs_0.6.5
## [13] tools_4.5.2                 bitops_1.0-9
## [15] curl_7.0.0                  parallel_4.5.2
## [17] Matrix_1.7-4                desc_1.4.3
## [19] cigarillo_1.0.0             lifecycle_1.0.4
## [21] compiler_4.5.2              Rsamtools_2.26.0
## [23] codetools_0.2-20            htmltools_0.5.8.1
## [25] usethis_3.2.1               sass_0.4.10
## [27] RCurl_1.98-1.17             yaml_2.3.11
## [29] crayon_1.5.3                jquerylib_0.1.4
## [31] ellipsis_0.3.2              BiocParallel_1.44.0
## [33] DelayedArray_0.36.0         cachem_1.1.0
## [35] sessioninfo_1.2.3           abind_1.4-8
## [37] digest_0.6.39               purrr_1.2.0
## [39] restfulr_0.0.16             bookdown_0.45
## [41] fastmap_1.2.0               grid_4.5.2
## [43] cli_3.6.5                   SparseArray_1.10.4
## [45] magrittr_2.0.4              S4Arrays_1.10.1
## [47] XML_3.99-0.20               pkgbuild_1.4.8
## [49] UCSC.utils_1.6.0            rmarkdown_2.30
## [51] httr_1.4.7                  matrixStats_1.5.0
## [53] memoise_2.0.1               evaluate_1.0.5
## [55] knitr_1.50                  rlang_1.1.6
## [57] glue_1.8.0                  BiocManager_1.30.27
## [59] pkgload_1.4.1               rstudioapi_0.17.1
## [61] jsonlite_2.0.0              R6_2.6.1
## [63] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
## [65] fs_1.6.6
```