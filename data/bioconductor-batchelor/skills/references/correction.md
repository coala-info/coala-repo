# Correcting batch effects in single-cell RNA-seq data

Aaron Lun1

1Cancer Research UK Cambridge Institute, Cambridge, United Kingdom

#### Revised: 3 February 2019

#### Package

batchelor 1.26.0

# 1 Introduction

Batch effects refer to differences between data sets generated at different times or in different laboratories.
These often occur due to uncontrolled variability in experimental factors, e.g., reagent quality, operator skill, atmospheric ozone levels.
The presence of batch effects can interfere with downstream analyses if they are not explicitly modelled.
For example, differential expression analyses typically use a blocking factor to absorb any batch-to-batch differences.

For single-cell RNA sequencing (scRNA-seq) data analyses, explicit modelling of the batch effect is less relevant.
Manny common downstream procedures for exploratory data analysis are not model-based, including clustering and visualization.
It is more generally useful to have methods that can remove batch effects to create an corrected expression matrix for further analysis.
This follows the same strategy as, e.g., the `removeBatchEffect()` function in the *[limma](https://bioconductor.org/packages/3.22/limma)* package (Ritchie et al. [2015](#ref-ritchie2015limma)).

Batch correction methods designed for bulk genomics data usually require knowledge of the other factors of variation.
This is usually not known in scRNA-seq experiments where the aim is to explore unknown heterogeneity in cell populations.
The *[batchelor](https://bioconductor.org/packages/3.22/batchelor)* package implements batch correction methods that do not rely on *a priori* knowledge about the population structure.

# 2 Setting up demonstration data

To demonstrate, we will use two brain data sets (Tasic et al. [2016](#ref-tasic2016adult); Zeisel et al. [2015](#ref-zeisel2015brain)) from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
A more thorough explanation of each of these steps is available in the [book](http://bioconductor.org/books/devel/OSCA).

```
library(scRNAseq)
sce1 <- ZeiselBrainData()
sce1
```

```
## class: SingleCellExperiment
## dim: 20006 3005
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(3005): 1772071015_C02 1772071017_G12 ... 1772066098_A12
##   1772058148_F03
## colData names(9): tissue group # ... level1class level2class
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

```
sce2 <- TasicBrainData()
sce2
```

```
## class: SingleCellExperiment
## dim: 24058 1809
## metadata(0):
## assays(1): counts
## rownames(24058): 0610005C13Rik 0610007C21Rik ... mt_X57780 tdTomato
## rowData names(0):
## colnames(1809): Calb2_tdTpositive_cell_1 Calb2_tdTpositive_cell_2 ...
##   Rbp4_CTX_250ng_2 Trib2_CTX_250ng_1
## colData names(12): mouse_line cre_driver_1 ... secondary_type
##   aibs_vignette_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(1): ERCC
```

We apply some quick-and-dirty quality control to both datasets,
using the outlier detection strategy from the *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* package.

```
library(scuttle)
sce1 <- addPerCellQC(sce1, subsets=list(Mito=grep("mt-", rownames(sce1))))
qc1 <- quickPerCellQC(colData(sce1), sub.fields="subsets_Mito_percent")
sce1 <- sce1[,!qc1$discard]

sce2 <- addPerCellQC(sce2, subsets=list(Mito=grep("mt_", rownames(sce2))))
qc2 <- quickPerCellQC(colData(sce2), sub.fields="subsets_Mito_percent")
sce2 <- sce2[,!qc2$discard]
```

Some preprocessing is required to render these two datasets comparable.
We subset to the common subset of genes:

```
universe <- intersect(rownames(sce1), rownames(sce2))
sce1 <- sce1[universe,]
sce2 <- sce2[universe,]
```

We compute log-normalized expression values using library size-derived size factors for simplicity.
(More complex size factor calculation methods are available in the *[scran](https://bioconductor.org/packages/3.22/scran)* package.)

```
out <- multiBatchNorm(sce1, sce2)
sce1 <- out[[1]]
sce2 <- out[[2]]
```

Finally, we identify the top 5000 genes with the largest biological components of their variance.
We will use these for all high-dimensional procedures such as PCA and nearest-neighbor searching.

```
library(scran)
dec1 <- modelGeneVar(sce1)
dec2 <- modelGeneVar(sce2)
combined.dec <- combineVar(dec1, dec2)
chosen.hvgs <- getTopHVGs(combined.dec, n=5000)
```

As a diagnostic, we check that there actually is a batch effect across these datasets by checking that they cluster separately.
Here, we combine the two `SingleCellExperiment` objects without any correction using the `NoCorrectParam()` flag,
and we informally verify that cells from different batches are separated using a \(t\)-SNE plot.

```
combined <- correctExperiments(A=sce1, B=sce2, PARAM=NoCorrectParam())

library(scater)
set.seed(100)
combined <- runPCA(combined, subset_row=chosen.hvgs)
combined <- runTSNE(combined, dimred="PCA")
plotTSNE(combined, colour_by="batch")
```

![](data:image/png;base64...)

# 3 Function organization

The batch correction functions in *[batchelor](https://bioconductor.org/packages/3.22/batchelor)* are organized into three levels:

* At the lowest level, we have the functions that implement a single type of correction, e.g., `fastMNN()`, `rescaleBatches()`.
  These will return a `SummarizedExperiment` object containing the corrected values and other statistics.
* At the next level, we have the `batchCorrect()` function that wraps the single-correction function into a common interface.
  This allows developers to switch between correction functions by simply passing a different `BatchelorParam` object.
* At the highest level, we have the `correctExperiments()` function that wraps the `batchCorrect()` function.
  This is intended for the specific case where correction is applied on data in existing `SingleCellExperiment` objects and we wish to preserve the pre-existing data and metadata from those objects in the corrected output.

For brevity, we will demonstrate the lowest-level functions in this vignette; however, it is easy to perform the exact same correction with `correctExperiments()` by switching the above call to, e.g., `PARAM=FastMnnParam()`.

# 4 Mutual nearest neighbors

## 4.1 Overview

Mutual nearest neighbors (MNNs) are defined as pairs of cells - one from each batch - that are within each other’s set of `k` nearest neighbors.
The idea is that MNN pairs across batches refer to the same cell type, assuming that the batch effect is orthogonal to the biological subspace (Haghverdi et al. [2018](#ref-haghverdi2018batch)).
Once MNN pairs are identified, the difference between the paired cells is used to infer the magnitude and direction of the batch effect.
It is then straightforward to remove the batch effect and obtain a set of corrected expression values.

## 4.2 The new, fast method

The `fastMNN()` function performs a principal components analysis (PCA) on the HVGs to obtain a low-dimensional representation of the input data.
MNN identification and correction is performed in this low-dimensional space, which offers some advantages with respect to speed and denoising.
This returns a `SingleCellExperiment` containing a matrix of corrected PC scores is returned, which can be used directly for downstream analyses such as clustering and visualization.
(We set the seed as we default to a stochastic method for PCA - see comments on `multiBatchPCA()` below.)

```
library(batchelor)
set.seed(101)
f.out <- fastMNN(A=sce1, B=sce2, subset.row=chosen.hvgs)
str(reducedDim(f.out, "corrected"))
```

```
##  num [1:4464, 1:50] -0.0729 -0.0853 -0.0886 -0.1021 -0.0832 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:4464] "1772071015_C02" "1772071017_G12" "1772071017_A05" "1772071014_B06" ...
##   ..$ : NULL
```

The batch of origin for each row/cell in the output matrix is also returned:

```
rle(f.out$batch)
```

```
## Run Length Encoding
##   lengths: int [1:2] 2874 1590
##   values : chr [1:2] "A" "B"
```

Another way to call `fastMNN()` is to specify the batch manually.
This will return a corrected matrix with the cells in the same order as that in the input `combined` object.
In this case, it doesn’t matter as the two batches were concatenated to created `combined` anyway,
but these semantics may be useful when cells from the same batch are not contiguous.

```
set.seed(101)
f.out2 <- fastMNN(combined, batch=combined$batch, subset.row=chosen.hvgs)
str(reducedDim(f.out2, "corrected"))
```

```
##  num [1:4464, 1:50] -0.0729 -0.0853 -0.0886 -0.1021 -0.0832 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:4464] "1772071015_C02" "1772071017_G12" "1772071017_A05" "1772071014_B06" ...
##   ..$ : NULL
```

As we can see, cells from the batches are more intermingled in the \(t\)-SNE plot below.
This suggests that the batch effect was removed - assuming, of course, that the intermingled cells represent the same population.

```
set.seed(103)
f.out <- runTSNE(f.out, dimred="corrected")
plotTSNE(f.out, colour_by="batch")
```

![](data:image/png;base64...)

We can also obtain per-gene corrected expression values by using the rotation vectors stored in the output.
This reverses the original projection used to obtain the initial low-dimensional representation.
There are, however, [several caveats](https://osca.bioconductor.org/integrating-datasets.html#using-corrected-values) to using these values for downstream analyses.

```
cor.exp <- assay(f.out)[1,]
hist(cor.exp, xlab="Corrected expression for gene 1", col="grey80")
```

![](data:image/png;base64...)

While the default arguments are usually satisfactory, there are many options for running `fastMNN()`, e.g., to improve speed or to achieve a particular merge order.
Refer to the documentation at `?fastMNN` or [the book](https://osca.bioconductor.org/integrating-datasets.html#performing-mnn-correction) for more details.

## 4.3 The old, classic method

The original method described by Haghverdi et al. ([2018](#ref-haghverdi2018batch)) is implemented in the `mnnCorrect()` method.
This performs the MNN identification and correction in the gene expression space, and uses a different strategy to overcome high-dimensional noise.
`mnnCorrect()` is called with the same semantics as `fastMNN()`:

```
# Using fewer genes as it is much, much slower.
fewer.hvgs <- head(order(combined.dec$bio, decreasing=TRUE), 100)
classic.out <- mnnCorrect(sce1, sce2, subset.row=fewer.hvgs)
```

… but returns the corrected gene expression matrix directly, rather than using a low-dimensional representation111 Again, those readers wanting to use the corrected values for per-gene analyses should consider the caveats mentioned previously..
This is wrapped in a `SingleCellExperiment` object to store various batch-related metadata.

```
classic.out
```

```
## class: SingleCellExperiment
## dim: 100 4464
## metadata(1): merge.info
## assays(1): corrected
## rownames(100): Plp1 Gad1 ... Olfm1 Ndrg4
## rowData names(0):
## colnames(4464): 1772071015_C02 1772071017_G12 ...
##   CAV_VISp_Contra_tdTpos_cell_4 CAV_VISp_Contra_tdTpos_cell_5
## colData names(1): batch
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

For scRNA-seq data, `fastMNN()` tends to be both faster and better at achieving a satisfactory merge.
`mnnCorrect()` is mainly provided here for posterity’s sake, though it is more robust than `fastMNN()` to certain violations of the orthogonality assumptions.

## 4.4 The cluster-based method

In some scenarios, we have already separately characterized the heterogeneity in each batch,
identifying clusters and annotating them with relevant biological states.
The `clusterMNN()` function allows us to examine the relationships between clusters across batches,
as demonstrated below with the Tasic and Zeisel datasets using the author-provided labels.

```
# Removing the 'unclassified' cluster, which makes no sense:
not.unclass <- sce2$broad_type!="Unclassified"
clust.out <- clusterMNN(sce1, sce2[,not.unclass],
    subset.row=chosen.hvgs,
    clusters=list(sce1$level1class, sce2$broad_type[not.unclass]))
```

The most relevant output is extracted from the metadata and describes the “meta-clusters”,
i.e., groupings of matching clusters corresponding to the same biological state across different batches.

```
clust.info <- metadata(clust.out)$cluster
split(clust.info$cluster, clust.info$meta)
```

```
## $`1`
## [1] "astrocytes_ependymal" "Astrocyte"
##
## $`2`
## [1] "endothelial-mural" "Endothelial Cell"
##
## $`3`
## [1] "interneurons"      "GABA-ergic Neuron"
##
## $`4`
## [1] "microglia" "Microglia"
##
## $`5`
## [1] "oligodendrocytes" "Oligodendrocyte"
##
## $`6`
## [1] "pyramidal CA1"
##
## $`7`
## [1] "pyramidal SS"         "Glutamatergic Neuron"
##
## $`8`
## [1] "Oligodendrocyte Precursor Cell"
```

The output object itself is a `SingleCellExperiment` that can be used for downstream processing in the same manner as the output of `fastMNN()`.
Compared to `fastMNN()`, `clusterMNN()` is more faithful with respect to preseving the separation between clusters;
however, it will not attempt to adjust for differences in intra-cluster structure between batches.
This can generally be considered a more conservative strategy than `fastMNN()` for merging batches.

# 5 Batch rescaling

`rescaleBatches()` effectively centers the batches in log-expression space on a per-gene basis.
This is conceptually equivalent to running `removeBatchEffect()` with no covariates other than the batch.
However, `rescaleBatches()` achieves this rescaling by reversing the log-transformation,
downscaling the counts so that the average of each batch is equal to the smallest value, and then re-transforming.
This preserves sparsity by ensuring that zeroes remain so after correction, and mitigates differences in the variance when dealing with counts of varying size between batches222 Done by downscaling, which increases the shrinkage from the added pseudo-count..

Calling `rescaleBatches()` returns a corrected matrix of per-gene log-expression values, wrapped in a `SummarizedExperiment` containin batch-related metadata.
This function operates on a per-gene basis so there is no need to perform subsetting (other than to improve speed).

```
rescale.out <- rescaleBatches(sce1, sce2)
rescale.out
```

```
## class: SingleCellExperiment
## dim: 18698 4464
## metadata(0):
## assays(1): corrected
## rownames(18698): Tspan12 Tshz1 ... Uty Usp9y
## rowData names(0):
## colnames(4464): 1772071015_C02 1772071017_G12 ...
##   CAV_VISp_Contra_tdTpos_cell_4 CAV_VISp_Contra_tdTpos_cell_5
## colData names(1): batch
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

While this method is fast and simple, it makes the strong assumption that the population composition of each batch is the same.
This is usually not the case for scRNA-seq experiments in real systems that exhibit biological variation.
Thus, `rescaleBatches()` is best suited for merging technical replicates of the same sample, e.g., that have been sequenced separately.

```
rescale.out <- runPCA(rescale.out, subset_row=chosen.hvgs,
    exprs_values="corrected")
plotPCA(rescale.out, colour_by="batch")
```

![](data:image/png;base64...)

Alternatively, a more direct linear regression of the batch effect can be performed with `regressBatches()`.
This does not preserve sparsity but uses a different set of tricks to avoid explicitly creating a dense matrix,
specifically by using the `ResidualMatrix` class from the *[ResidualMatrix](https://bioconductor.org/packages/3.22/ResidualMatrix)* package.

```
regress.out <- regressBatches(sce1, sce2)
assay(regress.out)
```

```
## <18698 x 4464> ResidualMatrix object of type "double":
##                         1772071015_C02                1772071017_G12 ...
##  Tspan12                   -0.22000582                   -0.22000582   .
##    Tshz1                    1.28232832                    0.43041200   .
##   Fnbp1l                    0.95064469                    0.09872836   .
## Adamts15                   -0.03420318                   -0.03420318   .
##   Cldn12                    0.45006856                    0.44471813   .
##      ...                             .                             .   .
##     Mid1                 -0.0439706444                 -0.0439706444   .
##     Asmt                 -0.0007053182                 -0.0007053182   .
##    Kdm5d                 -0.1204722330                 -0.1204722330   .
##      Uty                 -0.1956776800                 -0.1956776800   .
##    Usp9y                 -0.0021688275                 -0.0021688275   .
##          CAV_VISp_Contra_tdTpos_cell_5
##  Tspan12                    1.04604715
##    Tshz1                    1.07604070
##   Fnbp1l                    0.11072581
## Adamts15                   -0.06552555
##   Cldn12                   -0.60704202
##      ...                             .
##     Mid1                   0.041071303
##     Asmt                   0.000000000
##    Kdm5d                   1.488443414
##      Uty                  -0.576539486
##    Usp9y                  -0.001372457
```

# 6 Using data subsets

## 6.1 Selecting genes

As shown above, the `subset.row=` argument will only perform the correction on a subset of genes in the data set.
This is useful for focusing on highly variable or marker genes during high-dimensional procedures like PCA or neighbor searches, mitigating noise from irrelevant genes.
For per-gene methods, this argument provides a convenient alternative to subsetting the input.

For some functions, it is also possible to set `correct.all=TRUE` when `subset.row=` is specified.
This will compute corrected values for the unselected genes as well, which is possible once the per-cell statistics are obtained with the gene subset.
With this setting, we can guarantee that the output contains all the genes provided in the input.

## 6.2 Restricted correction

Many functions support the `restrict=` argument whereby the correction is determined using only a restricted subset of cells in each batch.
The effect of the correction is then - for want of a better word - “extrapolated” to all other cells in that batch.
This is useful for experimental designs where a control set of cells from the same source population were run on different batches.
Any difference in the controls between batches must be artificial in origin, allowing us to estimate and remove the batch effect without making further biological assumptions.

```
# Pretend the first X cells in each batch are controls.
restrict <- list(1:100, 1:200)
rescale.out <- rescaleBatches(sce1, sce2, restrict=restrict)
```

# 7 Other utilities

## 7.1 Multi-batch normalization

Differences in sequencing depth between batches are an obvious cause for batch-to-batch differences.
These can be removed by `multiBatchNorm()`, which downscales all batches to match the coverage of the least-sequenced batch.
This function returns a list of `SingleCellExperiment` objects with log-transformed normalized expression values that can be directly used for further correction.

```
normed <- multiBatchNorm(A=sce1, B=sce2,
    norm.args=list(use_altexps=FALSE))
names(normed)
```

```
## [1] "A" "B"
```

Downscaling mitigates differences in variance between batches due to the mean-variance relationship of count data.
It is achieved using a median-based estimator to avoid problems with composition biases between batches (Lun, Bach, and Marioni [2016](#ref-lun2016pooling)).
Note that this assumes that most genes are not DE between batches,
which we try to avoid violating by performing the rescaling on all genes rather than just the HVGs.

## 7.2 Multi-batch PCA

Users can perform a PCA across multiple batches using the `multiBatchPCA()` function.
The output of this function is roughly equivalent to `cbind`ing all batches together and performing PCA on the merged matrix.
The main difference is that each sample is forced to contribute equally to the identification of the rotation vectors.
This allows small batches with unique subpopulations to participate in the definition of the low-dimensional space.

```
set.seed(100)

# Using the same BSPARAM argument as fastMNN(), for speed.
pca.out <- multiBatchPCA(A=sce1, B=sce2, subset.row=chosen.hvgs,
    BSPARAM=BiocSingular::IrlbaParam(deferred=TRUE))
names(pca.out)
```

```
## [1] "A" "B"
```

This function is used internally in `fastMNN()` but can be explicitly called by the user.
Reduced dimensions can be input into `reducedMNN()`, which is occasionally convenient as it allows different correction parameters to be repeated without having to repeat the time-consuming PCA step.
We use the IRLBA algorithm by default, which means that we need to set seed to guarantee reproducible results.
We also set `deferred=TRUE` to speed up the calculations when using a custom weighting scheme for the batches - see `?"BiocSingular-options"` for more details.

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

# References

Haghverdi, L., A. T. L. Lun, M. D. Morgan, and J. C. Marioni. 2018. “Batch effects in single-cell RNA-sequencing data are corrected by matching mutual nearest neighbors.” *Nat. Biotechnol.* 36 (5): 421–27.

Lun, A. T., K. Bach, and J. C. Marioni. 2016. “Pooling across cells to normalize single-cell RNA sequencing data with many zero counts.” *Genome Biol.* 17 (April): 75.

Ritchie, M. E., B. Phipson, D. Wu, Y. Hu, C. W. Law, W. Shi, and G. K. Smyth. 2015. “limma powers differential expression analyses for RNA-sequencing and microarray studies.” *Nucleic Acids Res.* 43 (7): e47.

Tasic, B., V. Menon, T. N. Nguyen, T. K. Kim, T. Jarsky, Z. Yao, B. Levi, et al. 2016. “Adult mouse cortical cell taxonomy revealed by single cell transcriptomics.” *Nat. Neurosci.* 19 (2): 335–46.

Zeisel, A., A. B. Munoz-Manchado, S. Codeluppi, P. Lonnerberg, G. La Manno, A. Jureus, S. Marques, et al. 2015. “Brain structure. Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq.” *Science* 347 (6226): 1138–42.