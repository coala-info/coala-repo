# eds: Low-level reader function for Alevin EDS format

#### 10/29/2025

# eds package for reading in Alevin EDS format

The R package `eds` provides a single function `readEDS` for efficiently reading Alevin’s EDS format for single cell count data into R, utilizing the sparse matrix format in the `Matrix` package.

**Note:** `eds` provides a low-level function `readEDS` which most users will not need to use. Most users and developers will likely prefer to use `tximport` (for importing matrices) or `tximeta` (for easy conversion to *SingleCellExperiment* objects). This package is primarily developed in order to streamline the dependency graph for other packages.

# About EDS

EDS is an accronym for *Efficient single cell binary Data Storage* format for the cell-feature count matrices.

For more details on the EDS format see the following repository:

<https://github.com/COMBINE-lab/EDS>

# Simple example of reading EDS into R:

The following example is the same as round in `?readEDS`, first we point to EDS files as output by Alevin:

```
library(tximportData)
library(eds)
```

```
## Loading required package: Matrix
```

```
dir0 <- system.file("extdata",package="tximportData")
samps <- list.files(file.path(dir0, "alevin"))
dir <- file.path(dir0,"alevin",samps[3],"alevin")
quant.mat.file <- file.path(dir, "quants_mat.gz")
barcode.file <- file.path(dir, "quants_mat_rows.txt")
gene.file <- file.path(dir, "quants_mat_cols.txt")
```

`readEDS()` requires knowing the number of cells and genes, which we find by reading in associated barcode and gene files. Again, note that a more useful convenience function for reading in Alevin data is `tximport` (matrices) or `tximeta` (for easy conversion to SingleCellExperiment).

```
cell.names <- readLines(barcode.file)
gene.names <- readLines(gene.file)
num.cells <- length(cell.names)
num.genes <- length(gene.names)
```

Finally, reading in the sparse matrix is accomplished with:

```
mat <- readEDS(
    numOfGenes=num.genes,
    numOfOriginalCells=num.cells,
    countMatFilename=quant.mat.file)
```

# Session info

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
## [1] eds_1.12.0          Matrix_1.7-4        tximportData_1.37.5
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
##  [5] lattice_0.22-7    cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1
##  [9] rmarkdown_2.30    lifecycle_1.0.4   cli_3.6.5         grid_4.5.1
## [13] sass_0.4.10       jquerylib_0.1.4   compiler_4.5.1    tools_4.5.1
## [17] evaluate_1.0.5    bslib_0.9.0       Rcpp_1.1.0        yaml_2.3.10
## [21] rlang_1.1.6       jsonlite_2.0.0
```