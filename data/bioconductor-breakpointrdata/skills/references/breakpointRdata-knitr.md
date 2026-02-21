Example data for breakpointR

David Porubsky ∗

∗

david.porubsky@gmail.com

October 30, 2025

Contents

1

2

Data description .

Session Info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

3

Example data for breakpointR

1

Data description

This package provides data for demonstration purposes in package breakpointR. It contains
five example BAM files to illustrate functionlities of breakpointR package, as well as corre-
sponding results stored in ’BreakPoint’ objects in order to demonstrate plotting options. The
following example data are present inside the package breakpointRdata:

library(breakpointRdata)
?example_bams
?example_results

Example data can be loaded in the following way:

## Example BAM files
path <- system.file("extdata", "example_bams", package="breakpointRdata")
files <- list.files(path, full.names=TRUE, pattern=".bam$")

files

## [1] "/extdata/example_bams/example_lib1.bam" "/extdata/example_bams/example_lib2.bam"
## [3] "/extdata/example_bams/example_lib3.bam" "/extdata/example_bams/example_lib4.bam"

## Example results
path <- system.file("extdata", "example_results", package="breakpointRdata")
files <- list.files(path, full.names=TRUE)

files

## [1] "/extdata/example_results/example_lib1.RData"
## [2] "/extdata/example_results/example_lib2.RData"
## [3] "/extdata/example_results/example_lib3.RData"
## [4] "/extdata/example_results/example_lib4.RData"

2

Example data for breakpointR

2

Session Info

toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: breakpointRdata 1.28.0

• Loaded via a namespace (and not attached): BiocManager 1.30.26, BiocStyle 2.38.0,
cli 3.6.5, compiler 4.5.1, digest 0.6.37, evaluate 1.0.5, fastmap 1.2.0, highr 0.11,
htmltools 0.5.8.1, knitr 1.50, rlang 1.1.6, rmarkdown 2.30, tools 4.5.1, xfun 0.53,
yaml 2.3.10

3

