# An introduction to the SingleCellExperiment class

Davide Risso1 and Aaron Lun\*

1Division of Biostatistics and Epidemiology, Weill Cornell Medicine

\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Package

SingleCellExperiment 1.32.0

# 1 Motivation

The `SingleCellExperiment` class is a lightweight Bioconductor container for storing and manipulating single-cell genomics data.
It extends the `RangedSummarizedExperiment` class and follows similar conventions,
i.e., rows should represent features (genes, transcripts, genomic regions) and columns should represent cells.
It provides methods for storing dimensionality reduction results and data for alternative feature sets (e.g., synthetic spike-in transcripts, antibody-derived tags).
It is the central data structure for Bioconductor single-cell packages like *[scater](https://bioconductor.org/packages/3.22/scater)* and *[scran](https://bioconductor.org/packages/3.22/scran)*.

# 2 Creating SingleCellExperiment instances

`SingleCellExperiment` objects can be created via the constructor of the same name.
For example, if we have a count matrix in `counts`, we can simply call:

```
library(SingleCellExperiment)
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(counts)
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
## altExpNames(0):
```

In practice, it is often more useful to name the assay by passing in a named list:

```
sce <- SingleCellExperiment(list(counts=counts))
sce
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

It is similarly easy to set the column and row metadata by passing values to the appropriate arguments.
We will not go into much detail here as most of this is covered by the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* documentation,
but to give an example:

```
pretend.cell.labels <- sample(letters, ncol(counts), replace=TRUE)
pretend.gene.lengths <- sample(10000, nrow(counts))

sce <- SingleCellExperiment(list(counts=counts),
    colData=DataFrame(label=pretend.cell.labels),
    rowData=DataFrame(length=pretend.gene.lengths),
    metadata=list(study="GSE111111")
)
sce
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(1): study
## assays(1): counts
## rownames: NULL
## rowData names(1): length
## colnames: NULL
## colData names(1): label
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Alternatively, we can construct a `SingleCellExperiment` by coercing an existing `(Ranged)SummarizedExperiment` object:

```
se <- SummarizedExperiment(list(counts=counts))
as(se, "SingleCellExperiment")
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Any operation that can be applied to a `RangedSummarizedExperiment` is also applicable to any instance of a `SingleCellExperiment`.
This includes access to assay data via `assay()`, column metadata with `colData()`, and so on.
Again, without going into too much detail:

```
dim(assay(sce))
```

```
## [1] 10 10
```

```
colnames(colData(sce))
```

```
## [1] "label"
```

```
colnames(rowData(sce))
```

```
## [1] "length"
```

To demonstrate the use of the class in the rest of the vignette, we will use the Allen data set from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.

```
library(scRNAseq)
sce <- ReprocessedAllenData("tophat_counts")
sce
```

```
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(1): tophat_counts
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(0):
## mainExpName: endogenous
## altExpNames(1): ERCC
```

# 3 Adding low-dimensional representations

We compute log-transformed normalized expression values from the count matrix.
(We note that many of these steps can be performed as one-liners from the *[scater](https://bioconductor.org/packages/3.22/scater)* package,
but we will show them here in full to demonstrate the capabilities of the `SingleCellExperiment` class.)

```
counts <- assay(sce, "tophat_counts")
libsizes <- colSums(counts)
size.factors <- libsizes/mean(libsizes)
logcounts(sce) <- log2(t(t(counts)/size.factors) + 1)
assayNames(sce)
```

```
## [1] "tophat_counts" "logcounts"
```

We obtain the PCA and t-SNE representations of the data and add them to the object with the `reducedDims()<-` method.
Alternatively, we can representations one at a time with the `reducedDim()<-` method (note the missing `s`).

```
pca_data <- prcomp(t(logcounts(sce)), rank=50)

library(Rtsne)
set.seed(5252)
tsne_data <- Rtsne(pca_data$x[,1:50], pca = FALSE)

reducedDims(sce) <- list(PCA=pca_data$x, TSNE=tsne_data$Y)
sce
```

```
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(2): tophat_counts logcounts
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(2): PCA TSNE
## mainExpName: endogenous
## altExpNames(1): ERCC
```

The coordinates for all representations can be retrieved from a `SingleCellExperiment` *en masse* with `reducedDims()`
or one at a time by name/index with `reducedDim()`.
Each row of the coordinate matrix is assumed to correspond to a cell while each column represents a dimension.

```
reducedDims(sce)
```

```
## List of length 2
## names(2): PCA TSNE
```

```
reducedDimNames(sce)
```

```
## [1] "PCA"  "TSNE"
```

```
head(reducedDim(sce, "PCA")[,1:2])
```

```
##                   PC1       PC2
## SRR2140028  -70.23670  33.78880
## SRR2140022  -41.00366  49.76633
## SRR2140055 -133.70763   7.68870
## SRR2140083  -36.26099 113.18806
## SRR2139991 -100.86439  15.94740
## SRR2140067  -97.71210  35.77881
```

```
head(reducedDim(sce, "TSNE")[,1:2])
```

```
##                 [,1]       [,2]
## SRR2140028 11.467008 -0.2228169
## SRR2140022  8.658670 -0.8465634
## SRR2140055  1.188523 -1.8503291
## SRR2140083  6.930242  6.2650701
## SRR2139991  8.728013  0.6892645
## SRR2140067  4.428082 -4.3259717
```

Any subsetting by column of `sce_sub` will also lead to subsetting of the dimensionality reduction results by cell.
This is convenient as it ensures our low-dimensional results are always synchronized with the gene expression data.

```
dim(reducedDim(sce, "PCA"))
```

```
## [1] 379  50
```

```
dim(reducedDim(sce[,1:10], "PCA"))
```

```
## [1] 10 50
```

# 4 Convenient access to named assays

In the `SingleCellExperiment`, users can assign arbitrary names to entries of `assays`.
To assist interoperability between packages, we provide some suggestions for what the names should be for particular types of data:

* `counts`: Raw count data, e.g., number of reads or transcripts for a particular gene.
* `normcounts`: Normalized values on the same scale as the original counts.
  For example, counts divided by cell-specific size factors that are centred at unity.
* `logcounts`: Log-transformed counts or count-like values.
  In most cases, this will be defined as log-transformed `normcounts`, e.g., using log base 2 and a pseudo-count of 1.
* `cpm`: Counts-per-million.
  This is the read count for each gene in each cell, divided by the library size of each cell in millions.
* `tpm`: Transcripts-per-million.
  This is the number of transcripts for each gene in each cell, divided by the total number of transcripts in that cell (in millions).

Each of these suggested names has an appropriate getter/setter method for convenient manipulation of the `SingleCellExperiment`.
For example, we can take the (very specifically named) `tophat_counts` name and assign it to `counts` instead:

```
counts(sce) <- assay(sce, "tophat_counts")
sce
```

```
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(3): tophat_counts logcounts counts
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(2): PCA TSNE
## mainExpName: endogenous
## altExpNames(1): ERCC
```

```
dim(counts(sce))
```

```
## [1] 20816   379
```

This means that functions expecting count data can simply call `counts()` without worrying about package-specific naming conventions.

# 5 Adding alternative feature sets

Many scRNA-seq experiments contain sequencing data for multiple feature types beyond the endogenous genes:

* Externally added spike-in transcripts for plate-based experiments.
* Antibody tags for CITE-seq experiments.
* CRISPR tags for CRISPR-seq experiments.
* Allele information for experiments involving multiple genotypes.

Such features can be stored inside the `SingleCellExperiment` via the concept of “alternative Experiments”.
These are nested `SummarizedExperiment` instances that are guaranteed to have the same number and ordering of columns as the main `SingleCellExperiment` itself.
Data for endogenous genes and other features can thus be kept separate - which is often desirable as they need to be processed differently - while still retaining the synchronization of operations on a single object.

To illustrate, consider the case of the spike-in transcripts in the Allen data.
The `altExp()` method returns a self-contained `SingleCellExperiment` instance containing only the spike-in transcripts.

```
altExp(sce)
```

```
## class: SingleCellExperiment
## dim: 92 379
## metadata(0):
## assays(4): tophat_counts cufflinks_fpkm rsem_counts rsem_tpm
## rownames(92): ERCC-00002 ERCC-00003 ... ERCC-00170 ERCC-00171
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Each alternative Experiment can have a different set of assays from the main `SingleCellExperiment`.
This is useful in cases where the other feature types must be normalized or transformed differently.
Similarly, the alternative Experiments can have different `rowData()` from the main object.

```
rowData(altExp(sce))$concentration <- runif(nrow(altExp(sce)))
rowData(altExp(sce))
```

```
## DataFrame with 92 rows and 1 column
##            concentration
##                <numeric>
## ERCC-00002      0.034970
## ERCC-00003      0.979286
## ERCC-00004      0.171510
## ERCC-00009      0.577606
## ERCC-00012      0.965111
## ...                  ...
## ERCC-00164     0.2945227
## ERCC-00165     0.4449455
## ERCC-00168     0.2821027
## ERCC-00170     0.0817114
## ERCC-00171     0.4178510
```

```
rowData(sce)
```

```
## DataFrame with 20816 rows and 0 columns
```

We provide the `splitAltExps()` utility to easily split a `SingleCellExperiment` into new alternative Experiments.
For example, if we wanted to split the RIKEN transcripts into a separate Experiment
- say, to ensure that they are not used in downstream analyses without explicitly throwing out the data -
we would do:

```
is.riken <- grepl("^[0-9]", rownames(sce))
sce <- splitAltExps(sce, ifelse(is.riken, "RIKEN", "gene"))
altExpNames(sce)
```

```
## [1] "ERCC"  "RIKEN"
```

Alternatively, if we want to swap the main and alternative Experiments -
perhaps because the RIKEN transcripts were more interesting than expected, and we want to perform our analyses on them -
we can simply use `swapAltExp()` to switch the RIKEN alternative Experiment with the gene expression data:

```
swapAltExp(sce, "RIKEN", saved="original")
```

```
## class: SingleCellExperiment
## dim: 611 379
## metadata(2): SuppInfo which_qc
## assays(3): tophat_counts logcounts counts
## rownames(611): 0610007P14Rik 0610009B22Rik ... 9930111J21Rik1
##   9930111J21Rik2
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(2): PCA TSNE
## mainExpName: RIKEN
## altExpNames(2): ERCC original
```

# 6 Storing row or column pairings

A common procedure in single-cell analyses is to identify relationships between pairs of cells,
e.g., to construct a nearest-neighbor graph or to mark putative physical interactions between cells.
We can capture this information in the `SingleCellExperiment` class with the `colPairs()` functionality.
To demonstrate, say we have 100 relationships between the cells in `sce`, characterized by some distance measure:

```
cell1 <- sample(ncol(sce), 100, replace=TRUE)
cell2 <- sample(ncol(sce), 100, replace=TRUE)
distance <- runif(100)
```

We store this in the `SingleCellExperiment` as a `SelfHits` object using the `value` metadata field to hold our data.
This is easily extracted as a `SelfHits` or, for logical or numeric data, as a sparse matrix from *[Matrix](https://CRAN.R-project.org/package%3DMatrix)*.

```
colPair(sce, "relationships") <- SelfHits(
    cell1, cell2, nnode=ncol(sce), value=distance)
colPair(sce, "relationships")
```

```
## SelfHits object with 100 hits and 1 metadata column:
##              from        to |     value
##         <integer> <integer> | <numeric>
##     [1]         2       224 | 0.3155391
##     [2]         2       311 | 0.0554668
##     [3]        12       200 | 0.6148850
##     [4]        16       304 | 0.0174597
##     [5]        21       244 | 0.9801941
##     ...       ...       ... .       ...
##    [96]       349       369 |  0.662352
##    [97]       349       372 |  0.839914
##    [98]       352        10 |  0.540362
##    [99]       360       172 |  0.392147
##   [100]       360       237 |  0.626605
##   -------
##   nnode: 379
```

```
class(colPair(sce, asSparse=TRUE))
```

```
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
```

A particularly useful feature is that the indices of the interacting cells are automatically remapped when `sce` is subsetted.
This ensures that the pairings are always synchronized with the identities of the cells in `sce`.

```
sub <- sce[,50:300]
colPair(sub) # grabs the first pairing, if no 'type' is supplied.
```

```
## SelfHits object with 46 hits and 1 metadata column:
##             from        to |      value
##        <integer> <integer> |  <numeric>
##    [1]         7       157 |   0.748443
##    [2]        11         2 |   0.260945
##    [3]        18       203 |   0.857025
##    [4]        19       217 |   0.967591
##    [5]        32       249 |   0.608411
##    ...       ...       ... .        ...
##   [42]       236         3 | 0.17149734
##   [43]       240       245 | 0.98800819
##   [44]       245        52 | 0.00164622
##   [45]       248       208 | 0.53441707
##   [46]       250        65 | 0.31503674
##   -------
##   nnode: 251
```

Similar functionality is available for pairings between rows via the `rowPairs()` family of functions,
which is potentially useful for representing coexpression or regulatory networks.

# 7 Additional metadata fields

The `SingleCellExperiment` class provides the `sizeFactors()` getter and setter methods,
to set and retrieve size factors from the `colData` of the object.
Each size factor represents the scaling factor applied to a cell to normalize expression values prior to downstream comparisons,
e.g., to remove the effects of differences in library size and other cell-specific biases.
These methods are primarily intended for programmatic use in functions implementing normalization methods,
but users can also directly call this to inspect or define the size factors for their analysis.

```
# Making up some size factors and storing them:
sizeFactors(sce) <- 2^rnorm(ncol(sce))
summary(sizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.1336  0.6761  1.0082  1.2365  1.5034  9.8244
```

```
# Deleting the size factors:
sizeFactors(sce) <- NULL
sizeFactors(sce)
```

```
## NULL
```

The `colLabels()` getter and setters methods allow applications to set and retrieve cell labels from the `colData`.
These labels can be derived from cluster annotations, assigned by classification algorithms, etc.
and are often used in downstream visualization and analyses.
While labels can be stored in any `colData` field, the `colLabels()` methods aim to provide some informal standardization
to a default location that downstream functions can search first when attempting to retrieve annotations.

```
# Making up some labels and storing them:
colLabels(sce) <- sample(letters, ncol(sce), replace=TRUE)
table(colLabels(sce))
```

```
##
##  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z
## 18 14 15 13 16 12 19 14 10 12 14 13 16 10 25 22 15  8 12 19 14 19 12 17 11  9
```

```
# Deleting the labels:
colLabels(sce) <- NULL
colLabels(sce)
```

```
## NULL
```

In a similar vein, we provide the `rowSubset()` function for users to set and get row subsets from the `rowData`.
This will store any vector of gene identities (e.g., row names, integer indices, logical vector)
in the `SingleCellExperiment` object for retrieval and use by downstream functions.
Users can then easily pack multiple feature sets into the same object for synchronized manipulation.

```
# Packs integer or character vectors into the rowData:
rowSubset(sce, "my gene set 1") <- 1:10
which(rowSubset(sce, "my gene set 1"))
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```
# Easy to delete:
rowSubset(sce, "my gene set 1") <- NULL
rowSubset(sce, "my gene set 1")
```

```
## NULL
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
##  [1] Rtsne_0.17                  scRNAseq_2.23.1
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         alabaster.se_1.10.0      dplyr_1.1.4
##  [4] blob_1.2.4               filelock_1.0.3           Biostrings_2.78.0
##  [7] bitops_1.0-9             lazyeval_0.2.2           fastmap_1.2.0
## [10] RCurl_1.98-1.17          BiocFileCache_3.0.0      GenomicAlignments_1.46.0
## [13] XML_3.99-0.19            digest_0.6.37            lifecycle_1.0.4
## [16] ProtGenerics_1.42.0      alabaster.matrix_1.10.0  KEGGREST_1.50.0
## [19] alabaster.base_1.10.0    RSQLite_2.4.3            magrittr_2.0.4
## [22] compiler_4.5.1           rlang_1.1.6              sass_0.4.10
## [25] tools_4.5.1              yaml_2.3.10              rtracklayer_1.70.0
## [28] knitr_1.50               S4Arrays_1.10.0          bit_4.6.0
## [31] curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8
## [34] BiocParallel_1.44.0      HDF5Array_1.38.0         gypsum_1.6.0
## [37] grid_4.5.1               ExperimentHub_3.0.0      Rhdf5lib_1.32.0
## [40] cli_3.6.5                rmarkdown_2.30           crayon_1.5.3
## [43] httr_1.4.7               rjson_0.2.23             DBI_1.2.3
## [46] cachem_1.1.0             rhdf5_2.54.0             parallel_4.5.1
## [49] AnnotationDbi_1.72.0     AnnotationFilter_1.34.0  BiocManager_1.30.26
## [52] XVector_0.50.0           restfulr_0.0.16          alabaster.schemas_1.10.0
## [55] vctrs_0.6.5              Matrix_1.7-4             jsonlite_2.0.0
## [58] bookdown_0.45            bit64_4.6.0-1            ensembldb_2.34.0
## [61] alabaster.ranges_1.10.0  GenomicFeatures_1.62.0   h5mread_1.2.0
## [64] jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20
## [67] GenomeInfoDb_1.46.0      BiocVersion_3.22.0       UCSC.utils_1.6.0
## [70] BiocIO_1.20.0            tibble_3.3.0             pillar_1.11.1
## [73] rhdf5filters_1.22.0      rappdirs_0.3.3           htmltools_0.5.8.1
## [76] R6_2.6.1                 dbplyr_2.5.1             httr2_1.2.1
## [79] alabaster.sce_1.10.0     evaluate_1.0.5           lattice_0.22-7
## [82] AnnotationHub_4.0.0      png_0.1-8                Rsamtools_2.26.0
## [85] cigarillo_1.0.0          memoise_2.0.1            bslib_0.9.0
## [88] Rcpp_1.1.0               SparseArray_1.10.0       xfun_0.53
## [91] pkgconfig_2.0.3
```