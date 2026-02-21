# Saving `MultiAssayExperiment`s to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: December 25, 2023

#### Package

alabaster.mae 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.mae](https://bioconductor.org/packages/3.22/alabaster.mae)* package implements methods to save `MultiAssayExperiment` objects to file artifacts and load them back into R.
Check out the *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

Let’s create a mildly complicated MAE containing RNA-seq and ChIP-seq data with partial overlaps:

```
library(SummarizedExperiment)
rna.counts <- matrix(rpois(60, 10), ncol=6)
colnames(rna.counts) <- c("disease1", "disease2", "disease3", "control1", "control2", "control3")
rownames(rna.counts) <- c("ENSMUSG00000000001", "ENSMUSG00000000003", "ENSMUSG00000000028",
    "ENSMUSG00000000031", "ENSMUSG00000000037", "ENSMUSG00000000049",  "ENSMUSG00000000056",
    "ENSMUSG00000000058", "ENSMUSG00000000078",  "ENSMUSG00000000085")
rna.se <- SummarizedExperiment(list(counts=rna.counts))
colData(rna.se)$disease <- rep(c("disease", "control"), each=3)

chip.counts <- matrix(rpois(100, 10), ncol=4)
colnames(chip.counts) <- c("disease1", "disease2", "control1", "control3")
chip.peaks <- GRanges("chr1", IRanges(1:25*100+1, 1:25*100+100))
chip.se <- SummarizedExperiment(list(counts=chip.counts), rowRanges=chip.peaks)

library(MultiAssayExperiment)
mapping <- DataFrame(
    assay = rep(c("rnaseq", "chipseq"), c(ncol(rna.se), ncol(chip.se))), # experiment name
    primary = c(colnames(rna.se), colnames(chip.se)), # sample identifiers
    colname = c(colnames(rna.se), colnames(chip.se)) # column names inside each experiment
)
mae <- MultiAssayExperiment(list(rnaseq=rna.se, chipseq=chip.se), sampleMap=mapping)
```

We can use `saveObject()` to save it inside a staging directory:

```
library(alabaster.mae)
tmp <- tempfile()
meta <- saveObject(mae, tmp)
list.files(tmp, recursive=TRUE)
```

```
##  [1] "OBJECT"
##  [2] "_environment.json"
##  [3] "experiments/0/OBJECT"
##  [4] "experiments/0/assays/0/OBJECT"
##  [5] "experiments/0/assays/0/array.h5"
##  [6] "experiments/0/assays/names.json"
##  [7] "experiments/0/column_data/OBJECT"
##  [8] "experiments/0/column_data/basic_columns.h5"
##  [9] "experiments/0/row_data/OBJECT"
## [10] "experiments/0/row_data/basic_columns.h5"
## [11] "experiments/1/OBJECT"
## [12] "experiments/1/assays/0/OBJECT"
## [13] "experiments/1/assays/0/array.h5"
## [14] "experiments/1/assays/names.json"
## [15] "experiments/1/column_data/OBJECT"
## [16] "experiments/1/column_data/basic_columns.h5"
## [17] "experiments/1/row_ranges/OBJECT"
## [18] "experiments/1/row_ranges/ranges.h5"
## [19] "experiments/1/row_ranges/sequence_information/OBJECT"
## [20] "experiments/1/row_ranges/sequence_information/info.h5"
## [21] "experiments/names.json"
## [22] "sample_data/OBJECT"
## [23] "sample_data/basic_columns.h5"
## [24] "sample_map.h5"
```

We can then load it back into the session with `readObject()`.

```
roundtrip <- readObject(tmp)
class(roundtrip)
```

```
## [1] "MultiAssayExperiment"
## attr(,"package")
## [1] "MultiAssayExperiment"
```

# Session information

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
##  [1] alabaster.mae_1.10.0        alabaster.base_1.10.0
##  [3] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10              SparseArray_1.10.0       lattice_0.22-7
##  [4] alabaster.se_1.10.0      h5mread_1.2.0            digest_0.6.37
##  [7] evaluate_1.0.5           grid_4.5.1               bookdown_0.45
## [10] fastmap_1.2.0            jsonlite_2.0.0           Matrix_1.7-4
## [13] alabaster.schemas_1.10.0 BiocManager_1.30.26      HDF5Array_1.38.0
## [16] jquerylib_0.1.4          abind_1.4-8              cli_3.6.5
## [19] rlang_1.1.6              XVector_0.50.0           cachem_1.1.0
## [22] DelayedArray_0.36.0      yaml_2.3.10              BiocBaseUtils_1.12.0
## [25] S4Arrays_1.10.0          tools_4.5.1              Rhdf5lib_1.32.0
## [28] alabaster.ranges_1.10.0  alabaster.matrix_1.10.0  R6_2.6.1
## [31] lifecycle_1.0.4          rhdf5_2.54.0             bslib_0.9.0
## [34] Rcpp_1.1.0               xfun_0.53                knitr_1.50
## [37] rhdf5filters_1.22.0      htmltools_0.5.8.1        rmarkdown_2.30
## [40] compiler_4.5.1
```