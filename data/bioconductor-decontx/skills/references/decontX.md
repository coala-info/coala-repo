# Decontamination of ambient RNA in single-cell genomic data with DecontX

Shiyi (Iris) Yang1, Zhe Wang1, Yuan Yin1 and Joshua Campbell1\*

1Boston University School of Medicine

\*camp@bu.edu

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Importing data](#importing-data)
* [4 Load PBMC4k data from 10X](#load-pbmc4k-data-from-10x)
* [5 Running decontX](#running-decontx)
* [6 Plotting DecontX results](#plotting-decontx-results)
  + [6.1 Cluster labels on UMAP](#cluster-labels-on-umap)
  + [6.2 Contamination on UMAP](#contamination-on-umap)
  + [6.3 Expression of markers on UMAP](#expression-of-markers-on-umap)
  + [6.4 Barplot of markers detected in cell clusters](#barplot-of-markers-detected-in-cell-clusters)
  + [6.5 Violin plot to compare the distributions of original and decontaminated counts](#violin-plot-to-compare-the-distributions-of-original-and-decontaminated-counts)
* [7 Other important notes](#other-important-notes)
  + [7.1 Choosing appropriate cell clusters](#choosing-appropriate-cell-clusters)
  + [7.2 Adjusting the priors to influence contamination estimates](#adjusting-the-priors-to-influence-contamination-estimates)
  + [7.3 Working with Seurat](#seurat)
* [8 Session Information](#session-information)

# 1 Introduction

Droplet-based microfluidic devices have become widely used to perform single-cell RNA sequencing (scRNA-seq). However, ambient RNA present in the cell suspension can be aberrantly counted along with a cell’s native mRNA and result in cross-contamination of transcripts between different cell populations. DecontX is a Bayesian method to estimate and remove contamination in individual cells. DecontX assumes the observed expression of a cell is a mixture of counts from two multinomial distributions: (1) a distribution of native transcript counts from the cell’s actual population and (2) a distribution of contaminating transcript counts from all other cell populations captured in the assay. Overall, computational decontamination of single cell counts can aid in downstream clustering and visualization.

# 2 Installation

DecontX Package can be installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("decontX")
```

Then the package can be loaded in R using the following command:

```
library(decontX)
```

To see the latest updates and releases or to post a bug, see our GitHub page at <https://github.com/campbio/decontX>.

# 3 Importing data

DecontX can take either a [SingleCellExperiment](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) object or a counts matrix as input. `decontX` will attempt to convert any input matrix to class `dgCMatrix` from package [Matrix](https://cran.r-project.org/web/packages/Matrix/index.html) before starting the analysis.

To import datasets directly into an SCE object, the [singleCellTK](https://bioconductor.org/packages/release/bioc/html/singleCellTK.html) package has several importing functions for different preprocessing tools including CellRanger, STARsolo, BUStools, Optimus, DropEST, SEQC, and Alevin/Salmon. For example, the following code can be used as a template to read in the filtered and raw matrices for multiple samples processed with CellRanger:

```
library(singleCellTK)
sce <- importCellRanger(sampleDirs = c("path/to/sample1/", "path/to/sample2/"))
```

Within each sample directory, there should be subfolders called `"outs/filtered_feature_bc_matrix/"` or `"outs/raw_feature_bc_matrix/"` with files called `matrix.mtx.gz`, `features.tsv.gz` and `barcodes.tsv.gz`. If these files are in different subdirectories, the `importCellRangerV3Sample` function can be used to import data from a different directory instead.

Optionally, the “raw” or “droplet” matrix can also be easily imported by setting the `dataType` argument to “raw”:

```
sce.raw <- importCellRanger(sampleDirs = c("path/to/sample1/", "path/to/sample2/"), dataType = "raw")
```

The raw matrix can be passed to the `background` parameter in `decontX` as described below. If using Seurat, go to the [Working with Seurat](#seurat) section for details on how to convert between SCE and Seurat objects.

# 4 Load PBMC4k data from 10X

We will utilize the 10X PBMC 4K dataset as an example in this vignette. This data can be easily retrieved from the package [TENxPBMCData](http://bioconductor.org/packages/release/data/experiment/html/TENxPBMCData.html). Make sure the the column names are set before running decontX.

```
# Load PBMC data
library(TENxPBMCData)
sce <- TENxPBMCData("pbmc4k")
colnames(sce) <- paste(sce$Sample, sce$Barcode, sep = "_")
rownames(sce) <- rowData(sce)$Symbol_TENx
counts(sce) <- as(counts(sce), "dgCMatrix")
```

# 5 Running decontX

A SingleCellExperiment (SCE) object or a sparse matrix containing the counts for filtered cells can be passed to decontX via the `x` parameter. The matrix to use in an SCE object can be specified with the `assayName` parameter, which is set to `"counts"` by default. There are two major ways to run decontX: with and without the raw/droplet matrix containing empty droplets. Here is an example of running decontX without supplying the background:

```
sce <- decontX(sce)
```

In this scenario, `decontX` will estimate the contamination distribution for each cell cluster based on the profiles of the other cell clusters in the filtered dataset. The estimated contamination results can be found in the `colData(sce)$decontX_contamination` and the decontaminated counts can be accessed with `decontXcounts(sce)`. `decontX` will perform heuristic clustering to quickly define major cell clusters. However if you have your own cell cluster labels, they can be specified with the `z` parameter. These results will be used throughout the rest of the vignette.

The raw/droplet matrix can be used to empirically estimate the distribution of ambient RNA, which is especially useful when cells that contributed to the ambient RNA are not accurately represented in the filtered count matrix containing the cells. For example, cells that were removed via flow cytometry or that were more sensitive to lysis during dissociation may have contributed to the ambient RNA but were not measured in the filtered/cell matrix. The raw/droplet matrix can be input as an SCE object or a sparse matrix using the `background` parameter:

```
sce <- decontX(sce, background = sce.raw)
```

Only empty droplets in the background matrix should be used to estimate the ambient RNA. If any cell ids (i.e. `colnames`) in the raw/droplet matrix supplied to the `background` parameter are also found in the filtered counts matrix (`x`), decontX will automatically remove them from the raw matrix. However, if the cell ids are not available for the input matrices, decontX will treat the entire `background` input as empty droplets. All of the outputs are the same as when running decontX without setting the `background` parameter.

> Note: If the input object is just a matrix and not an SCE object, make sure to save the output into a variable with a different name (e.g. `result <- decontX(mat)`). The result object will be a list with contamination in `result$contamination` and the decontaminated counts in `result$decontXcounts`.

# 6 Plotting DecontX results

## 6.1 Cluster labels on UMAP

DecontX creates a UMAP which we can use to plot the cluster labels automatically identified in the analysis. Note that the clustering approach used here is designed to find “broad” cell types rather than individual cell subpopulations within a cell type.

```
library(celda) # To use plotting functions in celda
```

```
## Registered S3 method overwritten by 'pROC':
##   method   from
##   plot.roc spatstat.explore
```

```
##
## Attaching package: 'celda'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     params
```

```
## The following objects are masked from 'package:decontX':
##
##     decontX, decontXcounts, decontXcounts<-, plotDecontXContamination,
##     plotDecontXMarkerExpression, plotDecontXMarkerPercentage,
##     retrieveFeatureIndex, simulateContamination
```

```
umap <- reducedDim(sce, "decontX_UMAP")
plotDimReduceCluster(x = sce$decontX_clusters,
    dim1 = umap[, 1], dim2 = umap[, 2])
```

![](data:image/png;base64...)

## 6.2 Contamination on UMAP

The percentage of contamination in each cell can be plotting on the UMAP to visualize what what clusters may have higher levels of ambient RNA.

```
plotDecontXContamination(sce)
```

![](data:image/png;base64...)

## 6.3 Expression of markers on UMAP

Known marker genes can also be plotted on the UMAP to identify the cell types for each cluster. We will use CD3D and CD3E for T-cells, LYZ, S100A8, and S100A9 for monocytes, CD79A, CD79B, and MS4A1 for B-cells, GNLY for NK-cells, and PPBP for megakaryocytes.

```
library(scater)
sce <- logNormCounts(sce)
plotDimReduceFeature(as.matrix(logcounts(sce)),
    dim1 = umap[, 1],
    dim2 = umap[, 2],
    features = c("CD3D", "CD3E", "GNLY",
        "LYZ", "S100A8", "S100A9",
        "CD79A", "CD79B", "MS4A1"),
    exactMatch = TRUE)
```

```
## Warning in asMethod(object): sparse->dense coercion: allocating vector of size
## 1.1 GiB
```

![](data:image/png;base64...)

## 6.4 Barplot of markers detected in cell clusters

The percetage of cells within a cluster that have detectable expression of marker genes can be displayed in a barplot. Markers for cell types need to be supplied in a named list. First, the detection of marker genes in the original `counts` assay is shown:

```
markers <- list(Tcell_Markers = c("CD3E", "CD3D"),
    Bcell_Markers = c("CD79A", "CD79B", "MS4A1"),
    Monocyte_Markers = c("S100A8", "S100A9", "LYZ"),
    NKcell_Markers = "GNLY")
cellTypeMappings <- list(Tcells = 2, Bcells = 5, Monocytes = 1, NKcells = 6)
plotDecontXMarkerPercentage(sce,
    markers = markers,
    groupClusters = cellTypeMappings,
    assayName = "counts")
```

![](data:image/png;base64...)

We can then look to see how much decontX removed aberrant expression of marker genes in each cell type by changing the `assayName` to `decontXcounts`:

```
plotDecontXMarkerPercentage(sce,
    markers = markers,
    groupClusters = cellTypeMappings,
    assayName = "decontXcounts")
```

![](data:image/png;base64...)

Percentages of marker genes detected in other cell types were reduced or completely removed. For example, the percentage of cells that expressed Monocyte marker genes was greatly reduced in T-cells, B-cells, and NK-cells.
The original counts and decontamined counts can be plotted side-by-side by listing multiple assays in the `assayName` parameter. This option is only available if the data is stored in `SingleCellExperiment` object.

```
plotDecontXMarkerPercentage(sce,
    markers = markers,
    groupClusters = cellTypeMappings,
    assayName = c("counts", "decontXcounts"))
```

![](data:image/png;base64...)

Some helpful hints when using `plotDecontXMarkerPercentage`:

1. Cell clusters can be renamed and re-grouped using the `groupCluster` parameter, which also needs to be a named list. If `groupCluster` is used, cell clusters not included in the list will be excluded in the barplot. For example, if we wanted to group T-cells and NK-cells together, we could set `cellTypeMappings <- list(NK_Tcells = c(2,6), Bcells = 5, Monocytes = 1)`
2. The level a gene that needs to be expressed to be considered detected in a cell can be adjusted using the `threshold` parameter.
3. If you are not using a `SingleCellExperiment`, then you will need to supply the original counts matrix or the decontaminated counts matrix as the first argument to generate the barplots.

## 6.5 Violin plot to compare the distributions of original and decontaminated counts

Another useful way to assess the amount of decontamination is to view the expression of marker genes before and after `decontX` across cell types. Here we view the monocyte markers in each cell type. The violin plot shows that the markers have been removed from T-cells, B-cells, and NK-cells, but are largely unaffected in monocytes.

```
plotDecontXMarkerExpression(sce,
    markers = markers[["Monocyte_Markers"]],
    groupClusters = cellTypeMappings,
    ncol = 3)
```

![](data:image/png;base64...)

Some helpful hints when using `plotDecontXMarkerExpression`:

1. `groupClusters` works the same way as in `plotDecontXMarkerPercentage`.
2. This function will plot each pair of markers and clusters (or cell type specified by `groupClusters`). Therefore, you may want to keep the number of markers small in each plot and call the function multiple times for different sets of marker genes.
3. You can also plot the individual points by setting `plotDots = TRUE` and/or log transform the points on the fly by setting `log1p = TRUE`.
4. This function can plot any assay in a `SingleCellExperiment`. Therefore you could also examine normalized expression of the original and decontaminated counts. For example:

```
library(scater)
sce <- logNormCounts(sce,
    exprs_values = "decontXcounts",
    name = "decontXlogcounts")

plotDecontXMarkerExpression(sce,
    markers = markers[["Monocyte_Markers"]],
    groupClusters = cellTypeMappings,
    ncol = 3,
    assayName = c("logcounts", "decontXlogcounts"))
```

![](data:image/png;base64...)

# 7 Other important notes

## 7.1 Choosing appropriate cell clusters

The ability of DecontX to accurately identify contamination is dependent on the cell cluster labels. DecontX assumes that contamination for a cell cluster comes from combination of counts from all other clusters. The default clustering approach used by DecontX tends to select fewer clusters that represent broader cell types. For example, all T-cells tend to be clustered together rather than splitting naive and cytotoxic T-cells into separate clusters. Custom cell type labels can be suppled via the `z` parameter if some cells are not being clustered appropriately by the default method.

## 7.2 Adjusting the priors to influence contamination estimates

There are ways to force `decontX` to estimate more or less contamination across a dataset by manipulating the priors. The `delta` parameter is a numeric vector of length two. It is the concentration parameter for the Dirichlet distribution which serves as the prior for the proportions of native and contamination counts in each cell. The first element is the prior for the proportion of native counts while the second element is the prior for the proportion of contamination counts. These essentially act as pseudocounts for the native and contamination in each cell. If `estimateDelta = TRUE`, `delta` is only used to produce a random sample of proportions for an initial value of contamination in each cell. Then `delta` is updated in each iteration. If `estimateDelta = FALSE`, then `delta` is fixed with these values for the entire inference procedure. Fixing `delta` and setting a high number in the second element will force `decontX` to be more aggressive and estimate higher levels of contamination in each cell at the expense of potentially removing native expression. For example, in the previous PBMC example, we can see what the estimated `delta` was by looking in the estimates:

```
metadata(sce)$decontX$estimates$all_cells$delta
```

```
## [1] 9.287164 1.038217
```

Setting a higher value in the second element of delta and `estimateDelta = FALSE` will force `decontX` to estimate higher levels of contamination per cell:

```
sce.delta <- decontX(sce, delta = c(9, 20), estimateDelta = FALSE)

plot(sce$decontX_contamination, sce.delta$decontX_contamination,
     xlab = "DecontX estimated priors",
     ylab = "Setting priors to estimate higher contamination")
abline(0, 1, col = "red", lwd = 2)
```

![](data:image/png;base64...)

## 7.3 Working with Seurat

If you are using the [Seurat](https://cran.r-project.org/web/packages/Seurat/index.html) package for downstream analysis, the following code can be used to read in a matrix and convert between Seurat and SCE objects:

```
# Read counts from CellRanger output
library(Seurat)
counts <- Read10X("sample/outs/filtered_feature_bc_matrix/")

# Create a SingleCellExperiment object and run decontX
sce <- SingleCellExperiment(list(counts = counts))
sce <- decontX(sce)

# Create a Seurat object from a SCE with decontX results
seuratObject <- CreateSeuratObject(round(decontXcounts(sce)))
```

Optionally, the “raw” matrix can be also be imported and used as the background:

```
counts.raw <- Read10X("sample/outs/raw_feature_bc_matrix/")
sce.raw <- SingleCellExperiment(list(counts = counts.raw))
sce <- decontX(sce, background = sce.raw)
```

Note that the decontaminated matrix of decontX consists of floating point numbers and must be rounded to integers before adding it to a Seurat object. If you already have a Seurat object containing the counts matrix and would like to run decontX, you can retrieve the count matrix, create a SCE object, and run decontX, and then add it back to the Seurat object:

```
counts <- GetAssayData(object = seuratObject, slot = "counts")
sce <- SingleCellExperiment(list(counts = counts))
sce <- decontX(sce)
seuratObj[["decontXcounts"]] <- CreateAssayObject(counts = decontXcounts(sce))
```

# 8 Session Information

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
##  [3] scuttle_1.20.0              celda_1.26.0
##  [5] TENxPBMCData_1.27.0         HDF5Array_1.38.0
##  [7] h5mread_1.2.0               rhdf5_2.54.0
##  [9] DelayedArray_0.36.0         SparseArray_1.10.0
## [11] S4Arrays_1.10.0             abind_1.4-8
## [13] Matrix_1.7-4                SingleCellExperiment_1.32.0
## [15] future_1.67.0               dplyr_1.1.4
## [17] Seurat_5.3.1                SeuratObject_5.2.0
## [19] sp_2.2-0                    SingleCellMultiModal_1.21.4
## [21] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
## [23] Biobase_2.70.0              GenomicRanges_1.62.0
## [25] Seqinfo_1.0.0               IRanges_2.44.0
## [27] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [29] generics_0.1.4              MatrixGenerics_1.22.0
## [31] matrixStats_1.5.0           decontX_1.8.0
## [33] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] spatstat.sparse_3.1-0    doParallel_1.0.17        httr_1.4.7
##   [4] RColorBrewer_1.1-3       tools_4.5.1              sctransform_0.4.2
##   [7] R6_2.6.1                 lazyeval_0.2.2           uwot_0.2.3
##  [10] rhdf5filters_1.22.0      withr_3.0.2              gridExtra_2.3
##  [13] progressr_0.17.0         cli_3.6.5                spatstat.explore_3.5-3
##  [16] fastDummies_1.7.5        enrichR_3.4              labeling_0.4.3
##  [19] sass_0.4.10              S7_0.2.0                 spatstat.data_3.1-9
##  [22] ggridges_0.5.7           pbapply_1.7-4            QuickJSR_1.8.1
##  [25] StanHeaders_2.32.10      dbscan_1.2.3             dichromat_2.0-0.1
##  [28] WriteXLS_6.8.0           parallelly_1.45.1        RSQLite_2.4.3
##  [31] combinat_0.0-8           ica_1.0-3                spatstat.random_3.4-2
##  [34] dendextend_1.19.1        inline_0.3.21            loo_2.8.0
##  [37] ggbeeswarm_0.7.2         lifecycle_1.0.4          yaml_2.3.10
##  [40] BiocFileCache_3.0.0      Rtsne_0.17               grid_4.5.1
##  [43] blob_1.2.4               promises_1.4.0           ExperimentHub_3.0.0
##  [46] crayon_1.5.3             miniUI_0.1.2             lattice_0.22-7
##  [49] beachmat_2.26.0          cowplot_1.2.0            KEGGREST_1.50.0
##  [52] magick_2.9.0             pillar_1.11.1            knitr_1.50
##  [55] rjson_0.2.23             future.apply_1.20.0      codetools_0.2-20
##  [58] glue_1.8.0               V8_8.0.1                 spatstat.univar_3.1-4
##  [61] data.table_1.17.8        vctrs_0.6.5              png_0.1-8
##  [64] spam_2.11-1              gtable_0.3.6             cachem_1.1.0
##  [67] xfun_0.53                mime_0.13                RcppEigen_0.3.4.0.2
##  [70] survival_3.8-3           iterators_1.0.14         tinytex_0.57
##  [73] fitdistrplus_1.2-4       ROCR_1.0-11              nlme_3.1-168
##  [76] bit64_4.6.0-1            filelock_1.0.3           RcppAnnoy_0.0.22
##  [79] rstan_2.32.7             bslib_0.9.0              irlba_2.3.5.1
##  [82] vipor_0.4.7              KernSmooth_2.23-26       otel_0.2.0
##  [85] DBI_1.2.3                tidyselect_1.2.1         bit_4.6.0
##  [88] compiler_4.5.1           curl_7.0.0               httr2_1.2.1
##  [91] BiocNeighbors_2.4.0      ggdendro_0.2.0           plotly_4.11.0
##  [94] bookdown_0.45            scales_1.4.0             lmtest_0.9-40
##  [97] rappdirs_0.3.3           stringr_1.5.2            SpatialExperiment_1.20.0
## [100] digest_0.6.37            goftest_1.2-3            spatstat.utils_3.2-0
## [103] rmarkdown_2.30           XVector_0.50.0           htmltools_0.5.8.1
## [106] pkgconfig_2.0.3          dbplyr_2.5.1             fastmap_1.2.0
## [109] rlang_1.1.6              htmlwidgets_1.6.4        shiny_1.11.1
## [112] farver_2.1.2             jquerylib_0.1.4          zoo_1.8-14
## [115] jsonlite_2.0.0           BiocParallel_1.44.0      BiocSingular_1.26.0
## [118] magrittr_2.0.4           dotCall64_1.2            patchwork_1.3.2
## [121] Rhdf5lib_1.32.0          Rcpp_1.1.0               viridis_0.6.5
## [124] reticulate_1.44.0        pROC_1.19.0.1            stringi_1.8.7
## [127] MCMCprecision_0.4.2      MASS_7.3-65              AnnotationHub_4.0.0
## [130] plyr_1.8.9               pkgbuild_1.4.8           parallel_4.5.1
## [133] listenv_0.9.1            ggrepel_0.9.6            deldir_2.0-4
## [136] Biostrings_2.78.0        splines_4.5.1            tensor_1.5.1
## [139] igraph_2.2.1             spatstat.geom_3.6-0      RcppHNSW_0.6.0
## [142] reshape2_1.4.4           ScaledMatrix_1.18.0      rstantools_2.5.0
## [145] BiocVersion_3.22.0       evaluate_1.0.5           RcppParallel_5.1.11-1
## [148] BiocManager_1.30.26      foreach_1.5.2            httpuv_1.6.16
## [151] RANN_2.6.2               tidyr_1.3.1              purrr_1.1.0
## [154] polyclip_1.10-7          scattermore_1.2          BiocBaseUtils_1.12.0
## [157] rsvd_1.0.5               xtable_1.8-4             RSpectra_0.16-2
## [160] later_1.4.4              viridisLite_0.4.2        tibble_3.3.0
## [163] memoise_2.0.1            beeswarm_0.4.0           AnnotationDbi_1.72.0
## [166] cluster_2.1.8.1          globals_0.18.0
```