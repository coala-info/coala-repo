# Extending dispatch to more batch correction methods

Aaron Lun1

1Cancer Research UK Cambridge Institute, Cambridge, United Kingdom

#### Revised: 11 February 2019

#### Package

batchelor 1.26.0

# 1 Overview

The *[batchelor](https://bioconductor.org/packages/3.22/batchelor)* package provides the `batchCorrect()` generic that dispatches on its `PARAM` argument.
Users writing code using `batchCorrect()` can easily change one method for another by simply modifying the class of object supplied as `PARAM`.
For example:

```
B1 <- matrix(rnorm(10000), ncol=50) # Batch 1
B2 <- matrix(rnorm(10000), ncol=50) # Batch 2

# Switching easily between batch correction methods.
m.out <- batchCorrect(B1, B2, PARAM=ClassicMnnParam())
f.out <- batchCorrect(B1, B2, PARAM=FastMnnParam(d=20))
r.out <- batchCorrect(B1, B2, PARAM=RescaleParam(pseudo.count=0))
```

Developers of other packages can extend this further by adding their batch correction methods to this dispatch system.
This improves interoperability across packages by allowing users to easily experiment with different methods.

# 2 Setting up

You will need to `Imports: batchelor, methods` in your `DESCRIPTION` file.
You will also need to add `import(methods)`, `importFrom(batchelor, "batchCorrect")` and `importClassesFrom(batchelor, "BatchelorParam")` in your `NAMESPACE` file.

Obviously, you will also need to have a function that implements your batch correction method.
For demonstration purposes, we will use an identity function that simply returns the input values111 Not a very good correction, but that’s not the point right now..
This is implemented like so:

```
noCorrect <- function(...)
# Takes a set of batches and returns them without modification.
{
   do.call(cbind, list(...))
}
```

# 3 Deriving a `BatchelorParam` subclass

We need to define a new `BatchelorParam` subclass that instructs the `batchCorrect()` generic to dispatch to our new method.
This is most easily done like so:

```
NothingParam <- setClass("NothingParam", contains="BatchelorParam")
```

Note that `BatchelorParam` itself is derived from a `SimpleList` and can be modified with standard list operators like `$`.

```
nothing <- NothingParam()
nothing
```

```
## NothingParam of length 0
```

```
nothing$some_value <- 1
nothing
```

```
## NothingParam of length 1
## names(1): some_value
```

If no parameters are set, the default values in the function will be used222 Here there are none in `noCorrect()`, but presumably your function is more complex than that..
Additional slots can be specified in the class definition if there are important parameters that need to be manually specified by the user.

# 4 Defining a `batchCorrect` method

## 4.1 Input

The `batchCorrect()` generic looks like this:

```
batchCorrect
```

```
## standardGeneric for "batchCorrect" defined from package "batchelor"
##
## function (..., batch = NULL, restrict = NULL, subset.row = NULL,
##     correct.all = FALSE, assay.type = NULL, PARAM)
## standardGeneric("batchCorrect")
## <bytecode: 0x5a4ebd54b858>
## <environment: 0x5a4ebd55e940>
## Methods may be defined for arguments: PARAM
## Use  showMethods(batchCorrect)  for currently available ones.
```

Any implemented method must accept one or more matrix-like objects containing single-cell gene expression matrices in `...`.
Rows are assumed to be genes and columns are assumed to be cells.
If only one object is supplied, `batch` must be specified to indicate the batches to which each cell belongs.

Alternatively, one or more `SingleCellExperiment` objects can be supplied, containing the gene expression matrix in the `assay.type` assay.
These should not be mixed with matrix-like objects, i.e., if one object is a `SingleCellExperiment`, all objects should be `SingleCellExperiment`s.

The `subset.row=` argument specifies a subset of genes on which to perform the correction.
The `correct.all=` argument specifies whether corrected values should be returned for all genes, by “extrapolating” from the results for the genes that were used333 If your method cannot support this option, setting it to `TRUE` should raise an error..
See the Output section below for the expected output from each combination of these settings.

The `restrict=` argument allows users to compute the correction using only a subset of cells in each batch (e.g., from cell controls).
The correction is then “extrapolated” to all cells in the batch444 Again, if your method cannot support this, any non-`NULL` value of `restrict` should raise an error., such that corrected values are returned for all cells.

## 4.2 Output

Any implemented method must return a `SingleCellExperiment` where the first assay contains corrected gene expression values for all genes.
Corrected values should be returned for all genes if `correct.all=TRUE` or `subset.row=NULL`.
If `correct.all=FALSE` and `subset.row` is not `NULL`, values should only be returned for the selected genes.

Cells should be reported in the same order that they are supplied in `...`.
In cases with multiple batches, the cell identities are simply concatenated from successive objects in their specified order,
i.e., all cells from the first object (in their provided order), then all cells from the second object, and so on.
If there is only a single batch, the order of cells in that batch should be preserved.

The output object should have row names equal to the row names of the input objects.
Column names should be equivalent to the concatenated column names of the input objects, unless all are `NULL`, in which case the column names in the output can be `NULL`.
In situations where some input objects have column names, and others are `NULL`, those missing column names should be filled in with empty strings.
This represents the expected behaviour when `cbind`ing multiple matrices together.

Finally, the `colData` slot should contain ‘batch’, a vector specifying the batch of origin for each cell.

## 4.3 Demonstration

Finally, we define a method that calls our `noCorrect` function while satisfying all of the above input/output requirements.
To be clear, it is not mandatory to lay out the code as shown below; this is simply one way that all the requirements can be satisfied.
We have used some internal *[batchelor](https://bioconductor.org/packages/3.22/batchelor)* functions for brevity - please contact us if you find these useful and want them to be exported.

```
setMethod("batchCorrect", "NothingParam", function(..., batch = NULL,
    restrict=NULL, subset.row = NULL, correct.all = FALSE,
    assay.type = "logcounts", PARAM)
{
    batches <- list(...)
    checkBatchConsistency(batches)

    # Pulling out information from the SCE objects.
    is.sce <- checkIfSCE(batches)
    if (any(is.sce)) {
        batches[is.sce] <- lapply(batches[is.sce], assay, i=assay.type)
    }

    # Subsetting by 'batch', if only one object is supplied.
    do.split <- length(batches)==1L
    if (do.split) {
        divided <- divideIntoBatches(batches[[1]], batch=batch, restrict=restrict)
        batches <- divided$batches
        restrict <- divided$restricted
    }

    # Subsetting by row.
    # This is a per-gene "method", so correct.all=TRUE will ignore subset.row.
    # More complex methods will need to handle this differently.
    if (correct.all) {
        subset.row <- NULL
    } else if (!is.null(subset.row)) {
        subset.row <- normalizeSingleBracketSubscript(originals[[1]], subset.row)
        batches <- lapply(batches, "[", i=subset.row, , drop=FALSE)
    }

    # Don't really need to consider restrict!=NULL here, as this function
    # doesn't do anything with the cells anyway.
    output <- do.call(noCorrect, batches)

    # Reordering the output for correctness if it was previously split.
    if (do.split) {
        d.reo <- divided$reorder
        output <- output[,d.reo,drop=FALSE]
    }

    ncells.per.batch <- vapply(batches, FUN=ncol, FUN.VALUE=0L)
    batch.names <- names(batches)
    if (is.null(batch.names)) {
        batch.names <- seq_along(batches)
    }

    SingleCellExperiment(list(corrected=output),
        colData=DataFrame(batch=rep(batch.names, ncells.per.batch)))
})
```

And it works555 In a strictly programming sense, as the method itself does no correction at all.:

```
n.out <- batchCorrect(B1, B2, PARAM=NothingParam())
n.out
```

```
## class: SingleCellExperiment
## dim: 200 100
## metadata(0):
## assays(1): corrected
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): batch
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Remember to export both the new method and the `NothingParam` class and constructor.

# 5 Session information

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
##  [1] scater_1.38.0               ggplot2_4.0.0
##  [3] scran_1.38.0                scuttle_1.20.0
##  [5] scRNAseq_2.23.1             batchelor_1.26.0
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           knitr_1.50
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] ggbeeswarm_0.7.2          GenomicFeatures_1.62.0
##   [7] gypsum_1.6.0              farver_2.1.2
##   [9] rmarkdown_2.30            BiocIO_1.20.0
##  [11] vctrs_0.6.5               memoise_2.0.1
##  [13] Rsamtools_2.26.0          DelayedMatrixStats_1.32.0
##  [15] RCurl_1.98-1.17           tinytex_0.57
##  [17] htmltools_0.5.8.1         S4Arrays_1.10.0
##  [19] AnnotationHub_4.0.0       curl_7.0.0
##  [21] BiocNeighbors_2.4.0       Rhdf5lib_1.32.0
##  [23] SparseArray_1.10.0        rhdf5_2.54.0
##  [25] sass_0.4.10               alabaster.base_1.10.0
##  [27] bslib_0.9.0               alabaster.sce_1.10.0
##  [29] httr2_1.2.1               cachem_1.1.0
##  [31] ResidualMatrix_1.20.0     GenomicAlignments_1.46.0
##  [33] igraph_2.2.1              lifecycle_1.0.4
##  [35] pkgconfig_2.0.3           rsvd_1.0.5
##  [37] Matrix_1.7-4              R6_2.6.1
##  [39] fastmap_1.2.0             digest_0.6.37
##  [41] AnnotationDbi_1.72.0      dqrng_0.4.1
##  [43] irlba_2.3.5.1             ExperimentHub_3.0.0
##  [45] RSQLite_2.4.3             beachmat_2.26.0
##  [47] labeling_0.4.3            filelock_1.0.3
##  [49] httr_1.4.7                abind_1.4-8
##  [51] compiler_4.5.1            withr_3.0.2
##  [53] bit64_4.6.0-1             S7_0.2.0
##  [55] BiocParallel_1.44.0       viridis_0.6.5
##  [57] DBI_1.2.3                 HDF5Array_1.38.0
##  [59] alabaster.ranges_1.10.0   alabaster.schemas_1.10.0
##  [61] rappdirs_0.3.3            DelayedArray_0.36.0
##  [63] rjson_0.2.23              bluster_1.20.0
##  [65] tools_4.5.1               vipor_0.4.7
##  [67] beeswarm_0.4.0            glue_1.8.0
##  [69] h5mread_1.2.0             restfulr_0.0.16
##  [71] rhdf5filters_1.22.0       grid_4.5.1
##  [73] Rtsne_0.17                cluster_2.1.8.1
##  [75] gtable_0.3.6              ensembldb_2.34.0
##  [77] BiocSingular_1.26.0       ScaledMatrix_1.18.0
##  [79] metapod_1.18.0            XVector_0.50.0
##  [81] ggrepel_0.9.6             BiocVersion_3.22.0
##  [83] pillar_1.11.1             limma_3.66.0
##  [85] dplyr_1.1.4               BiocFileCache_3.0.0
##  [87] lattice_0.22-7            rtracklayer_1.70.0
##  [89] bit_4.6.0                 tidyselect_1.2.1
##  [91] locfit_1.5-9.12           Biostrings_2.78.0
##  [93] gridExtra_2.3             bookdown_0.45
##  [95] ProtGenerics_1.42.0       edgeR_4.8.0
##  [97] xfun_0.53                 statmod_1.5.1
##  [99] UCSC.utils_1.6.0          lazyeval_0.2.2
## [101] yaml_2.3.10               evaluate_1.0.5
## [103] codetools_0.2-20          cigarillo_1.0.0
## [105] tibble_3.3.0              alabaster.matrix_1.10.0
## [107] BiocManager_1.30.26       cli_3.6.5
## [109] jquerylib_0.1.4           dichromat_2.0-0.1
## [111] Rcpp_1.1.0                GenomeInfoDb_1.46.0
## [113] dbplyr_2.5.1              png_0.1-8
## [115] XML_3.99-0.19             parallel_4.5.1
## [117] blob_1.2.4                AnnotationFilter_1.34.0
## [119] sparseMatrixStats_1.22.0  bitops_1.0-9
## [121] viridisLite_0.4.2         alabaster.se_1.10.0
## [123] scales_1.4.0              crayon_1.5.3
## [125] rlang_1.1.6               cowplot_1.2.0
## [127] KEGGREST_1.50.0
```