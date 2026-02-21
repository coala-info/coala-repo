# Applying a function over a SingleCellExperiment’s contents

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Package

SingleCellExperiment 1.32.0

# 1 Motivation

The `SingleCellExperiment` is quite a complex class that can hold multiple aspects of the same dataset.
It is possible to have multiple assays, multiple dimensionality reduction results, and multiple alternative Experiments -
each of which can further have multiple assays and `reducedDims`!
In some scenarios, it may be desirable to loop over these pieces and apply the same function to each of them.
This is made conveniently possible via the `applySCE()` framework.

# 2 Quick start

Let’s say we have a moderately complicated `SingleCellExperiment` object,
containing multiple alternative Experiments for different data modalities.

```
library(SingleCellExperiment)
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(counts)

altExp(sce, "Spike") <- SingleCellExperiment(matrix(rpois(20, lambda = 5), ncol=10, nrow=2))
altExp(sce, "Protein") <- SingleCellExperiment(matrix(rpois(50, lambda = 100), ncol=10, nrow=5))
altExp(sce, "CRISPR") <- SingleCellExperiment(matrix(rbinom(80, p=0.1, 1), ncol=10, nrow=8))

sce
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(3): Spike Protein CRISPR
```

Assume that we want to compute the total count for each modality, using the first assay.
We might define a function that looks like the below.
(We will come back to the purpose of `multiplier=` and `subset.row=` later.)

```
totalCount <- function(x, i=1, multiplier=1, subset.row=NULL) {
    mat <- assay(x, i)
    if (!is.null(subset.row)) {
        mat <- mat[subset.row,,drop=FALSE]
    }
    colSums(mat) * multiplier
}
```

We can then easily apply this function across the main and alternative Experiments with:

```
totals <- applySCE(sce, FUN=totalCount)
totals
```

```
## [[1]]
##  [1] 116  99 113  97  94 114 112  87 102 111
##
## $Spike
##  [1]  9 11  9 11  6 15 12  8  4  6
##
## $Protein
##  [1] 515 513 484 449 475 540 518 514 504 501
##
## $CRISPR
##  [1] 1 1 3 0 1 1 0 1 1 1
```

# 3 Design explanation

The `applySCE()` call above is functionally equivalent to:

```
totals.manual <- list(
    totalCount(sce),
    Spike=totalCount(altExp(sce, "Spike")),
    Protein=totalCount(altExp(sce, "Protein")),
    CRISPR=totalCount(altExp(sce, "CRISPR"))
)
stopifnot(identical(totals, totals.manual))
```

Besides being more verbose than `applySCE()`, this approach does not deal well with common arguments.
Say we wanted to set `multiplier=10` for all calls.
With the manual approach above, this would involve specifying the argument multiple times:

```
totals10.manual <- list(
    totalCount(sce, multiplier=10),
    Spike=totalCount(altExp(sce, "Spike"), multiplier=10),
    Protein=totalCount(altExp(sce, "Protein"), multiplier=10),
    CRISPR=totalCount(altExp(sce, "CRISPR"), multiplier=10)
)
```

Whereas with the `applySCE()` approach, we can just set it once.
This makes it easier to change and reduces the possibility of errors when copy-pasting parameter lists across calls.

```
totals10.apply <- applySCE(sce, FUN=totalCount, multiplier=10)
stopifnot(identical(totals10.apply, totals10.manual))
```

Now, one might consider just using `lapply()` in this case, which also avoids the need for repeated specification:

```
totals10.lapply <- lapply(c(List(sce), altExps(sce)),
    FUN=totalCount, multiplier=10)
stopifnot(identical(totals10.apply, totals10.lapply))
```

However, this runs into the opposite problem - it is no longer possible to specify *custom* arguments for each call.
For example, say we wanted to subset to a different set of features for each main and alternative Experiment.
With `applySCE()`, this is still possible:

```
totals.custom <- applySCE(sce, FUN=totalCount, multiplier=10,
    ALT.ARGS=list(Spike=list(subset.row=2), Protein=list(subset.row=3:5)))
totals.custom
```

```
## [[1]]
##  [1] 1160  990 1130  970  940 1140 1120  870 1020 1110
##
## $Spike
##  [1] 40 40 40 80 30 70 80 20 10 40
##
## $Protein
##  [1] 3160 3100 2970 2620 2870 3220 2970 3120 3060 3020
##
## $CRISPR
##  [1] 10 10 30  0 10 10  0 10 10 10
```

In cases where we have a mix between custom and common arguments, `applySCE()` provides a more convenient and flexible interface than manual calls or `lapply()`ing.

# 4 Simplifying to a `SingleCellExperiment`

The other convenient aspect of `applySCE()` is that, if the specified `FUN=` returns a `SingleCellExperiment`, `applySCE()` will try to format the output as a `SingleCellExperiment`.
To demonstrate, let’s use the `head()` function to take the first few features for each main and alternative Experiment:

```
head.sce <- applySCE(sce, FUN=head, n=5)
head.sce
```

```
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(3): Spike Protein CRISPR
```

Rather than returning a list of `SingleCellExperiment`s, we can see that the output is neatly organized as a `SingleCellExperiment` with the specified `n=5` features.
Moreover, each of the alternative Experiments is also truncated to its first 5 features (or fewer, if there weren’t that many to begin with).
This output mirrors, as much as possible, the format of the input `sce`, and is much more convenient to work with than a list of objects.

```
altExp(head.sce)
```

```
## class: SingleCellExperiment
## dim: 2 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
altExp(head.sce, "Protein")
```

```
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
altExp(head.sce, "CRISPR")
```

```
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

To look under the hood, we can turn off simplification and see what happens.
We see that the function indeed returns a list of `SingleCellExperiment` objects corresponding to the `head()` of each Experiment.
When `SIMPLIFY=TRUE`, this list is passed through `simplifyToSCE()` to attempt the reorganization into a single object.

```
head.sce.list <- applySCE(sce, FUN=head, n=5, SIMPLIFY=FALSE)
head.sce.list
```

```
## [[1]]
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(3): Spike Protein CRISPR
##
## $Spike
## class: SingleCellExperiment
## dim: 2 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
##
## $Protein
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
##
## $CRISPR
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

For comparison, if we had to do this manually, it would be rather tedious and error-prone,
e.g., if we forgot to set `n=` or if we re-assigned the output of `head()` to the wrong alternative Experiment.

```
manual.head <- head(sce, n=5)
altExp(manual.head, "Spike") <- head(altExp(sce, "Spike"), n=5)
altExp(manual.head, "Protein") <- head(altExp(sce, "Protein"), n=5)
altExp(manual.head, "CRISPR") <- head(altExp(sce, "CRISPR"), n=5)
manual.head
```

```
## class: SingleCellExperiment
## dim: 5 10
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(3): Spike Protein CRISPR
```

Of course, this simplification is only possible when circumstances permit.
It requires that `FUN=` returns a `SingleCellExperiment` at each call, and that no more than one result is generated for each alternative Experiment.
Failure to meet these conditions will result in a warning and a non-simplified output.

Developers may prefer to set `SIMPLIFY=FALSE` and manually call `simplifyToSCE()`, possibly with `warn.level=3` to trigger an explicit error when simplification fails.

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
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           DelayedArray_0.36.0 jsonlite_2.0.0
##  [7] htmltools_0.5.8.1   sass_0.4.10         rmarkdown_2.30
## [10] grid_4.5.1          abind_1.4-8         evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [16] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [19] compiler_4.5.1      XVector_0.50.0      lattice_0.22-7
## [22] digest_0.6.37       R6_2.6.1            SparseArray_1.10.0
## [25] Matrix_1.7-4        bslib_0.9.0         tools_4.5.1
## [28] S4Arrays_1.10.0     cachem_1.1.0
```