# Utilities for multi-modal single-cell analyses

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 8 November 2020

#### Package

mumosa 1.18.0

# 1 Overview

The *[mumosa](https://bioconductor.org/packages/3.22/mumosa)* package implements a variety of utilities for analyses of single-cell data with multiple modalities.
This usually refers to single-cell RNA-seq experiments with proteomics, epigenomics or other data collected from the same cells.
The aim is to investigate how different modalities relate to each other via analyses of correlations,
and to combine data together from multiple modalities for integrated downstream analyses.
The actual analyses of each individual modality are deferred to other packages;
the scope of *[mumosa](https://bioconductor.org/packages/3.22/mumosa)* is limited to the sharing of information across modalities.

# 2 Setting up the dataset

To demonstrate the functionalities of this package, we will use a subset of a CITE-seq experiment from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
The main Experiment contains the RNA-seq counts while the `adt` alternative Experiment contains the CITE-seq counts -
see the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* package documentation for more details.

```
library(scater)
library(scran)
library(scRNAseq)
sce <- KotliarovPBMCData()
sce <- sce[,1:1000] # subset for speed.
sce
```

```
## class: SingleCellExperiment
## dim: 32738 1000
## metadata(0):
## assays(1): counts
## rownames(32738): MIR1302-10 FAM138A ... AC002321.2 AC002321.1
## rowData names(0):
## colnames(1000): AAACCTGAGAGCCCAA_H1B1ln1 AAACCTGAGGCGTACA_H1B1ln1 ...
##   ATAACGCGTTTGGGCC_H1B1ln1 ATAACGCTCAACGCTA_H1B1ln1
## colData names(24): nGene nUMI ... dmx_hto_match timepoint
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(1): ADT
```

We perform some cursory analyses on the RNA component:

```
stats <- perCellQCMetrics(sce, subsets=list(Mito=grep("^MT-", rownames(sce))))
filter <- quickPerCellQC(stats, sub.fields="subsets_Mito_percent")
sce <- sce[,!filter$discard]
sce <- logNormCounts(sce)
dec <- modelGeneVar(sce)
set.seed(10000)
sce <- runPCA(sce, ncomponents=25, subset_row=getTopHVGs(dec, n=5000))
```

And again on the protein component.

```
# TODO: sync this with the book.
sceA <- as(altExp(sce), "SingleCellExperiment")
statsA <- perCellQCMetrics(sceA)
keep <- statsA$detected > 50
sceA <- sceA[,keep]

library(DropletUtils)
amb <- inferAmbience(assay(sceA))
sceA <- computeMedianFactors(sceA, reference=amb)
sceA <- logNormCounts(sceA)

set.seed(10000)
sceA <- runPCA(sceA, ncomponents=15)
```

Finally, we put everything back into the same object, only considering the cells passing QC in both modalities.

```
sce2 <- sce[,keep]
altExp(sce2) <- sceA
```

# 3 Rescaling by neighbors

The easiest way to combine data for the same set of cells is to simply `cbind` their matrices together prior to downstream analyses like clustering.
However, this requires some rescaling to adjust for the differences in the number of features and variation of each modality;
otherwise, the modality with more features or stronger (technical) variation would just dominate later calculations.
`rescaleByNeighbors()` quantifies the “noise” of each modality using on the median distance to the \(k\)-th nearest neighbor,
and then rescales each expression/PC matrix by that distance to equalize the noise across modalities.

```
library(mumosa)
output <- rescaleByNeighbors(list(reducedDim(sce2), reducedDim(altExp(sce2))))
dim(output)
```

```
## [1] 911  40
```

The result is a `cbind`ed matrix that can be used directly in downstream analyses like clustering and dimensionality reduction.

```
set.seed(100001)
library(bluster)
sce2$combined.clustering <- clusterRows(output, NNGraphParam())

reducedDim(sce2, "combined") <- output
sce2 <- runTSNE(sce2, dimred="combined")
plotTSNE(sce2, colour_by="combined.clustering")
```

![](data:image/png;base64...)

Advanced users can also adjust the weight given to each modality via the `weights=` argument;
a modality assigned a weight of 2 will mean that the rescaled distance is twice that of a modality with a weight of 1.

# 4 Intersecting clusters

In other situations, we may already have a clustering for each modality.
For example, we might have one clustering for each of the gene expression and ADT PCs:

```
g.rna <- buildSNNGraph(sce2, use.dimred="PCA")
rna.clusters <- igraph::cluster_walktrap(g.rna)$membership
table(rna.clusters)
```

```
## rna.clusters
##   1   2   3   4   5   6   7
## 115 218  24  84  92 254 124
```

```
g.adt <- buildSNNGraph(altExp(sce2), use.dimred='PCA')
adt.clusters <- igraph::cluster_walktrap(g.adt)$membership
table(adt.clusters)
```

```
## adt.clusters
##   1   2   3   4   5   6   7   8
## 111 191 122 181 122  82  20  82
```

We can naively “intersect” these clusters by concatenating their identities, as shown below.
Cells are only assigned to the same intersected clusters if they belong to the same per-modality clusters.
In practice, this often creates a large number of irrelevant clusters with small numbers of cells.

```
intersected <- paste0(adt.clusters, ".", rna.clusters)
table(intersected)
```

```
## intersected
## 1.2 1.4 1.5 2.2 2.5 2.6 3.7 4.2 4.4 4.6 5.1 5.3 5.6 6.2 6.6 7.3 7.7 8.4 8.5
##  39   2  70 155  20  16 122   6   2 173 115   6   1  18  64  18   2  80   2
```

A more refined approach is implemented in the `intersectClusters()` function.
This performs the intersection as described but then performs a series of pairwise merges to eliminate the small clusters.
It will stop merging when the within-cluster sum of squares exceeds that of the original clustering in any modality;
this ensures that any within-modality structure captured by the original clustering is preserved.

```
intersected2 <- intersectClusters(list(rna.clusters, adt.clusters),
    list(reducedDim(sce2), reducedDim(altExp(sce2))))
table(intersected2)
```

```
## intersected2
##   1   2   3   4   5   6   7   8   9
## 124  92  39  82  84 180 115 171  24
```

# 5 Multi-metric UMAP

Another approach is to take advantage of UMAP’s ability to combine information on different scales.
This is achieved by - roughly speaking - creating nearest-neighbor graphs within each modality,
and then “intersecting” the graphs such that cells are only considered to be neighbors if they are neighbors in each modality.
In this manner, we incorporate locality information from all modalities without explicitly comparing distances.
We apply this strategy using the `calculateMultiUMAP()` function,
increasing the number of components to avoid loss of information.

```
set.seed(100002)
umap.out <- calculateMultiUMAP(list(reducedDim(sce2), reducedDim(altExp(sce2))),
    n_components=20)
dim(umap.out)
```

```
## [1] 911  20
```

Again, we can use this in downstream analyses like clustering:

```
library(bluster)
sce2$umap.clustering <- clusterRows(umap.out, NNGraphParam())
```

And also visualization, though perhaps it is more natural to just compute the UMAP on two dimensions for this purpose.
`runMultiMap()` is just a wrapper around `calculateMultiUMAP()` that conveniently stores the output in the `reducedDims` of the input `SingleCellExperiment`.

```
set.seed(100002)
sce2 <- runMultiUMAP(sce2, dimred="PCA", extras=list(reducedDim(altExp(sce2))))
plotReducedDim(sce2, "MultiUMAP", colour_by="umap.clustering")
```

![](data:image/png;base64...)

# 6 Intersecting graphs

Inspired by the UMAP approach, we can perform intersections on arbitrary graphs with the `intersectGraphs()` function.
This is relevant in cases where we have nearest-neighbor graphs constructed separately for each modality, e.g., for graph-based clustering.
We intersect these graphs by setting the weights of edges to the product of the edge weights from each individual graph.

```
g.com <- intersectGraphs(g.rna, g.adt)
```

Two cells will only be connected by a high-weighted edge if that edge is of high weight in each original graph,
i.e., cells must be nearest neighbors in all modalities to be considered as nearest neighbors in the intersection.
We can then use this graph for clustering, which hopefully gives us clusters where cells are similar across all modalities.

```
com.clusters <- igraph::cluster_walktrap(g.com)$membership
table(com.clusters)
```

```
## com.clusters
##   1   2   3   4   5   6   7   8   9  10
## 123 124 118 169 178  70  21  22  84   2
```

# 7 Correlation analyses

Given two modalities, we may be interested in knowing which features in one modality are correlated to the features in another modality.
The `computeCorrelations()` function does exactly this:

```
cor.all <- computeCorrelations(sce2, altExp(sce2)[1:5,])
cor.all[order(cor.all$p.value),]
```

```
## DataFrame with 163690 rows and 5 columns
##           feature1      feature2       rho     p.value         FDR
##        <character>   <character> <numeric>   <numeric>   <numeric>
## 1            CD79A     BTLA_PROT  0.443223 4.01052e-45 2.89580e-40
## 2         HLA-DRB1    CD123_PROT  0.430457 2.17126e-42 7.83878e-38
## 3          HLA-DRA    CD123_PROT  0.403383 5.75021e-37 1.38398e-32
## 4             FCN1     CD13_PROT  0.397864 6.38599e-36 1.15275e-31
## 5            TCL1A     BTLA_PROT  0.383289 2.97413e-33 4.29495e-29
## ...            ...           ...       ...         ...         ...
## 163686      snoU13 AnnexinV_PROT       NaN          NA          NA
## 163687      snoU13     BTLA_PROT       NaN          NA          NA
## 163688      snoU13    CD117_PROT       NaN          NA          NA
## 163689      snoU13    CD123_PROT       NaN          NA          NA
## 163690      snoU13     CD13_PROT       NaN          NA          NA
```

For multi-batch experiments, we can specify blocking factors to avoid being confounded by the batch effect.
Each batch receives equal weight when averaging correlations and in computing the final combined \(p\)-value.

```
b <- rep(1:3, length.out=ncol(sce2))
cor.all.batch <- computeCorrelations(sce2, altExp(sce2)[1:5,], block=b)
```

However, this approach can be very slow when dealing with large numbers of features;
indeed, one may note the subsetting to the first 5 features in the code above.
Users can enable parallelization via `BPPARAM=` to speed up the process but this will only go so far.

An alternative approach is to, for each feature in one modality, perform an approximate search for the top most-correlated features in another modality.
This assumes that only the strongest correlations (positive or negative) are of actual interest, while the bulk of weak correlations can be ignored.
We use the `findTopCorrelations()` function with a specified number of top features to extract:

```
set.seed(100001) # for IRLBA.
top.cor <- findTopCorrelations(sce2[1:100,], y=altExp(sce2), number=10)
top.cor
```

```
## List of length 2
## names(2): positive negative
```

```
top.cor$positive
```

```
## DataFrame with 530 rows and 5 columns
##         feature1              feature2        rho   p.value       FDR
##      <character>           <character>  <numeric> <numeric> <numeric>
## 1   RP11-34P13.7 RatIgG2bkIsotype_PROT  0.0550420 0.0484271         1
## 2   RP11-34P13.7            CD194_PROT  0.0519342 0.0586247         1
## 3   RP11-34P13.7             CD19_PROT  0.0310772 0.1743962         1
## 4   RP11-34P13.7             CD34_PROT  0.0301584 0.1816169         1
## 5   RP11-34P13.7             CD1c_PROT  0.0300619 0.1823858         1
## ...          ...                   ...        ...       ...       ...
## 526     C1orf222             CD19_PROT 0.03895679  0.120066         1
## 527     C1orf222            CD141_PROT 0.03693348  0.132724         1
## 528     C1orf222             CD10_PROT 0.02722832  0.205866         1
## 529     C1orf222            CD184_PROT 0.00819402  0.402461         1
## 530     C1orf222            CD273_PROT 0.00572678  0.431477         1
```

This returns the top 10 features in the CITE-seq data (`y`) for each feature in the main RNA-seq data.
As the search is approximate, some features may not be ranked as highly as they would be under an exact search -
the approximation quality can be modified by increasing the number of PCs (`d`) used for data compression.
Blocking is also supported with `block=`, in which case correlations are only computed within each level of the blocking factor.

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
##  [1] bluster_1.20.0              mumosa_1.18.0
##  [3] DropletUtils_1.30.0         scRNAseq_2.23.1
##  [5] scran_1.38.0                scater_1.38.0
##  [7] ggplot2_4.0.0               scuttle_1.20.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           knitr_1.50
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] ggbeeswarm_0.7.2          GenomicFeatures_1.62.0
##   [7] gypsum_1.6.0              farver_2.1.2
##   [9] rmarkdown_2.30            BiocIO_1.20.0
##  [11] vctrs_0.6.5               DelayedMatrixStats_1.32.0
##  [13] memoise_2.0.1             Rsamtools_2.26.0
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
##  [51] compiler_4.5.1            bit64_4.6.0-1
##  [53] withr_3.0.2               S7_0.2.0
##  [55] BiocParallel_1.44.0       viridis_0.6.5
##  [57] DBI_1.2.3                 R.utils_2.13.0
##  [59] alabaster.ranges_1.10.0   HDF5Array_1.38.0
##  [61] alabaster.schemas_1.10.0  rappdirs_0.3.3
##  [63] DelayedArray_0.36.0       rjson_0.2.23
##  [65] tools_4.5.1               vipor_0.4.7
##  [67] beeswarm_0.4.0            R.oo_1.27.1
##  [69] glue_1.8.0                batchelor_1.26.0
##  [71] h5mread_1.2.0             restfulr_0.0.16
##  [73] rhdf5filters_1.22.0       grid_4.5.1
##  [75] Rtsne_0.17                cluster_2.1.8.1
##  [77] gtable_0.3.6              R.methodsS3_1.8.2
##  [79] ensembldb_2.34.0          BiocSingular_1.26.0
##  [81] ScaledMatrix_1.18.0       metapod_1.18.0
##  [83] XVector_0.50.0            ggrepel_0.9.6
##  [85] BiocVersion_3.22.0        pillar_1.11.1
##  [87] limma_3.66.0              dplyr_1.1.4
##  [89] BiocFileCache_3.0.0       lattice_0.22-7
##  [91] FNN_1.1.4.1               rtracklayer_1.70.0
##  [93] bit_4.6.0                 tidyselect_1.2.1
##  [95] locfit_1.5-9.12           Biostrings_2.78.0
##  [97] gridExtra_2.3             bookdown_0.45
##  [99] ProtGenerics_1.42.0       edgeR_4.8.0
## [101] xfun_0.53                 statmod_1.5.1
## [103] UCSC.utils_1.6.0          lazyeval_0.2.2
## [105] yaml_2.3.10               evaluate_1.0.5
## [107] codetools_0.2-20          cigarillo_1.0.0
## [109] tibble_3.3.0              alabaster.matrix_1.10.0
## [111] BiocManager_1.30.26       cli_3.6.5
## [113] uwot_0.2.3                jquerylib_0.1.4
## [115] GenomeInfoDb_1.46.0       dichromat_2.0-0.1
## [117] Rcpp_1.1.0                dbplyr_2.5.1
## [119] png_0.1-8                 XML_3.99-0.19
## [121] parallel_4.5.1            blob_1.2.4
## [123] AnnotationFilter_1.34.0   sparseMatrixStats_1.22.0
## [125] bitops_1.0-9              alabaster.se_1.10.0
## [127] viridisLite_0.4.2         scales_1.4.0
## [129] crayon_1.5.3              rlang_1.1.6
## [131] cowplot_1.2.0             KEGGREST_1.50.0
```