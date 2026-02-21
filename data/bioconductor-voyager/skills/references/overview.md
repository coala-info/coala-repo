# Overview of Voyager

Lambda Moses, Lior Pachter

#### Oct 30, 2025

As including a more detailed vignette inside the package makes the package exceed the tarball size, more detailed vignettes are hosted on [an external website](https://pachterlab.github.io/voyager/index.html). This is a simplified vignette.

# 1 Installation

This package can be installed from Bioconductor:

```
if (!requireNamespace("BiocManager")) install.packages("BiocManager")
BiocManager::install("Voyager")
# Devel version
# install.packages("remotes")
remotes::install_github("pachterlab/Voyager")
```

# 2 Introduction

In non-spatial scRNA-seq, the [`SingleCellExperiment`](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) (SCE) package implements a data structure and other packages such as [`scater`](https://bioconductor.org/packages/release/bioc/html/scater.html) implement methods for quality control (QC), basic exploratory data analysis (EDA), and plotting functions, using SCE to organize the data and results. `Voyager` to [`SpatialFeatureExperiment`](https://bioconductor.org/packages/release/bioc/html/SpatialFeatureExperiment.html) (SFE) aims to be analogous `scater` to SFE, implementing basic exploratory *spatial* data analysis (ESDA) and plotting. SFE inherits from SCE and [`SpatialExperiment`](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) (SPE), so all methods written for SCE and SPE can be used for SFE as well.

In this first version, ESDA is based on the classic geospatial package [`spdep`](https://r-spatial.github.io/spdep/index.html), but future versions will incorporate methods from [`GWmodel`](https://cran.r-project.org/web/packages/GWmodel/index.html), [`adespatial`](https://cran.r-project.org/web/packages/adespatial/index.html), and etc.

These are the main functionalities of the `Voyager` at present:

* Univariate global spatial statistics, such as Moran’s I, Geary’s C, permutation testing of I and C, correlograms, global G, and semivariogram.
* Univariate local spatial statistics, such as local Moran’s I, local Geary’s C, Getis-Ord Gi\*, Moran scatter plot, and local spatial heteroscedasticity (LOSH).
* Multivariate spatial statistics, such as MULTISPATI PCA and a multivariate generalization of local Geary’s C.
* Bivariate spatial statistics, such as Lee’s L (global and local) and cross variograms.
* Plotting gene expression and `colData` along with annotation geometries, with colorblind friendly default palettes. The actual geometries are plotted, not just centroids as in `Seurat`. The tissue image can be plotted behind the geometries.
* Plotting permutation testing results and correlograms, multiple genes in the same plot, can color by gene, sample, or any other attribute.
* Clustering correlograms and Moran’s scatter plots
* Plotting local spatial statistics in space
* Plotting dimension reduction in space
* Plotting spatial neighborhood graphs
* Plotting variograms and variogram maps

Future versions may add user friendly wrappers of some successful spatial transcriptomics data analysis packages for spatially variable genes, cell type deconvolution, and spatial regions on CRAN, Bioconductor, pip, and conda, to provide a uniform syntax and avoid object conversion, as is done in `Seurat` for some non-spatial scRNA-seq methods.

# 3 Dataset

Here we use a mouse skeletal muscle Visium dataset from [Large-scale integration of single-cell transcriptomic data captures transitional progenitor states in mouse skeletal muscle regeneration](https://www.nature.com/articles/s42003-021-02810-x). It’s in the `SFEData` package, as an SFE object, which contains Visium spot polygons, myofiber and nuclei segmentations, and myofiber and nuclei morphological metrics.

```
library(SFEData)
library(SpatialFeatureExperiment)
library(SpatialExperiment)
library(ggplot2)
library(Voyager)
library(scater)
library(scran)
library(pheatmap)
```

This is the H&E image:

```
if (!file.exists("tissue_lowres_5a.jpeg")) {
    download.file("https://raw.githubusercontent.com/pachterlab/voyager/main/vignettes/tissue_lowres_5a.jpeg",
                  destfile = "tissue_lowres_5a.jpeg")
}
```

```
knitr::include_graphics("tissue_lowres_5a.jpeg")
```

![](data:image/jpeg;base64...)

```
sfe <- McKellarMuscleData()
#> see ?SFEData and browseVignettes('SFEData') for documentation
#> loading from cache
```

This dataset was not originally in the standard Space Ranger output format, so we can’t use `read10xVisiumSFE()`. But the image can be added later for plotting.

```
sfe <- addImg(sfe, imageSource = "tissue_lowres_5a.jpeg", sample_id = "Vis5A",
              image_id = "lowres", scale_fct = 1024/22208)
```

The image needs to be flipped to match the spots, because the origin of the image is at the top left corner while the origin of the spots is at the bottom left.

```
sfe <- mirrorImg(sfe, sample_id = "Vis5A", image_id = "lowres")
```

```
# Only use spots in tissue here
sfe <- sfe[,colData(sfe)$in_tissue]
sfe <- logNormCounts(sfe)
sfe
#> class: SpatialFeatureExperiment
#> dim: 15123 932
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(15123): ENSMUSG00000025902 ENSMUSG00000096126 ...
#>   ENSMUSG00000064368 ENSMUSG00000064370
#> rowData names(6): Ensembl symbol ... vars cv2
#> colnames(932): AAACATTTCCCGGATT AAACCTAAGCAGCCGG ... TTGTGTTTCCCGAAAG
#>   TTGTTGTGTGTCAAGA
#> colData names(13): barcode col ... in_tissue sizeFactor
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : imageX imageY
#> imgData names(4): sample_id image_id data scaleFactor
#>
#> unit: full_res_image_pixels
#> Geometries:
#> colGeometries: spotPoly (POLYGON)
#> annotGeometries: tissueBoundary (POLYGON), myofiber_full (POLYGON), myofiber_simplified (POLYGON), nuclei (POLYGON), nuclei_centroid (POINT)
#>
#> Graphs:
#> Vis5A:
```

# 4 Univariate spatial statistics

A spatial neighborhood graph is required for all `spdep` analyses.

```
colGraph(sfe, "visium") <- findVisiumGraph(sfe)
```

All of the numerous univariate methods can be used with `runUnivariate()`, which stores global results in `rowData(sfe)` and local results in `localResults(sfe)`. Here we compute Moran’s I for one gene. While Ensembl IDs are used internally, the user can specify more human readable gene symbols. A warning will be given if the gene symbol matches multiple Ensembl IDs.

```
features_use <- c("Myh1", "Myh2")
```

```
sfe <- runUnivariate(sfe, type = "moran", features = features_use,
                     colGraphName = "visium", swap_rownames = "symbol")
# Look at the results
rowData(sfe)[rowData(sfe)$symbol %in% features_use,]
#> DataFrame with 2 rows and 8 columns
#>                               Ensembl      symbol            type     means
#>                           <character> <character>     <character> <numeric>
#> ENSMUSG00000033196 ENSMUSG00000033196        Myh2 Gene Expression   0.97476
#> ENSMUSG00000056328 ENSMUSG00000056328        Myh1 Gene Expression   4.82572
#>                         vars       cv2 moran_Vis5A   K_Vis5A
#>                    <numeric> <numeric>   <numeric> <numeric>
#> ENSMUSG00000033196   24.0374   25.2984    0.625500   2.21641
#> ENSMUSG00000056328  302.2385   12.9785    0.635718   2.68736
```

Since Moran’s I is very commonly used, one can call `runMoransI` rather than `runUnivariate`.

Compute a local spatial statistic, Getis-Ord Gi\*, which is commonly used to detect hotspots and coldspots. The `include_self` argument is only for Getis-Ord Gi\*; when set to `TRUE` Gi\* is computed as the spatial graph includes self-directing edges, and otherwise Gi is computed.

```
sfe <- runUnivariate(sfe, type = "localG", features = features_use,
                     colGraphName = "visium", include_self = TRUE,
                     swap_rownames = "symbol")
# Look at the results
head(localResults(sfe, name = "localG")[[1]])
#>       localG          G*i      E(G*i)      V(G*i)     Z(G*i) Pr(z != E(G*i))
#> 1  0.9539649 0.0013011969 0.001072961 5.72403e-08  0.9539649    0.3401014102
#> 2  2.2196433 0.0014737468 0.001072961 3.26030e-08  2.2196433    0.0264429927
#> 3 -1.4500290 0.0008111398 0.001072961 3.26030e-08 -1.4500290    0.1470504457
#> 4  3.5457397 0.0017131908 0.001072961 3.26030e-08  3.5457397    0.0003915127
#> 5  1.1947382 0.0012886869 0.001072961 3.26030e-08  1.1947382    0.2321893509
#> 6 -1.4750237 0.0008066266 0.001072961 3.26030e-08 -1.4750237    0.1402061682
#>     -log10p -log10p_adj cluster
#> 1 0.4683916   0.0000000    High
#> 2 1.5776894   0.6745994    High
#> 3 0.8325337   0.0000000    High
#> 4 3.4072541   2.5041641    High
#> 5 0.6341577   0.0000000    High
#> 6 0.8532329   0.0000000     Low
```

Spatial statistics can also be computed for numeric columns of `colData(sfe)`, with `colDataUnivariate()`, and for numeric attributes of the geometries with `colGeometryUnivariate()` and `annotGeometryUnivariate()`, all with very similar arguments.

# 5 Bivariate spatial statistics

Akin to `runUnivariate()` and `calculateUnivariate()`, the uniform user interface for bivariate spatial statistics is `runBivariate()` and `calculateBivariate()`. Here we find top highly variable genes (HVGs) and compute a spatially informed correlation matrix, with Lee’s L. Note that global bivariate results can’t be stored in the SFE object in this version of `Voyager`.

```
gs <- modelGeneVar(sfe)
hvgs <- getTopHVGs(gs, fdr.threshold = 0.01)
```

```
res <- calculateBivariate(sfe, "lee", hvgs)
```

```
pheatmap(res, color = scales::viridis_pal()(256), cellwidth = 1, cellheight = 1,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)
Here we see groups of genes correlated to each other, taking spatial autocorrelation into account. This matrix can be used in WGCNA to find gene coexpression modules. Note that Lee’s L of a gene with itself is not 1, because of a spatial smoothing factor.

# 6 Multivariate spatial statistics

Multivariate spatial statistics also have a uniform user interface, `runMultivariate()`. The matrix results will go to `reducedDims`, while vector and data frame results can go into `colData`. Here we perform a form of spatially informed PCA, which maximizes the product of Moran’s I and variance explained by each principal component. This method is called MULTISPATI, which is originally implemented in the `adespatial` package, but a much faster albeit less flexible implementation is used in `Voyager`. Because of the Moran’s I, MULTISPATI can give negative eigenvalues, signifying negative spatial autocorrelation. The number of the most negative components to compute is specified in the `nfnega` argument.

```
hvgs2 <- getTopHVGs(gs, n = 1000)
sfe <- runMultivariate(sfe, "multispati", colGraphName = "visium", subset_row = hvgs2,
                       nfposi = 10, nfnega = 10)
```

# 7 Plotting

Plot gene expression and `colData(sfe)` together with annotation geometry. Here `nCounts` is the total UMI counts per spot, which is in `colData`.

```
plotSpatialFeature(sfe, c("nCounts", "Myh1"), colGeometryName = "spotPoly",
                   annotGeometryName = "myofiber_simplified",
                   aes_use = "color", linewidth = 0.5, fill = NA,
                   annot_aes = list(fill = "area"), swap_rownames = "symbol")
```

![](data:image/png;base64...)

Plot local results, with the image. The `maxcell` argument is the maximum number of pixels to plot from the image. If the image has more pixels than that, then it will be downsampled to speed up plotting.

```
plotLocalResult(sfe, "localG", features = features_use,
                colGeometryName = "spotPoly", divergent = TRUE,
                diverge_center = 0, swap_rownames = "symbol",
                image_id = "lowres", maxcell = 5e+4)
```

![](data:image/png;base64...)

Plot the eigenvalues:

```
ElbowPlot(sfe, ndims = 10, nfnega = 10, reduction = "multispati") + theme_bw()
```

![](data:image/png;base64...)

Plot dimension reduction (projection of each cell’s gene expression profile on each dimension) in space:

```
spatialReducedDim(sfe, "multispati", ncomponents = 2, image_id = "lowres",
                  maxcell = 5e+4, divergent = TRUE, diverge_center = 0)
```

![](data:image/png;base64...)

# 8 Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] pheatmap_1.0.13                 scran_1.38.0
#>  [3] scater_1.38.0                   scuttle_1.20.0
#>  [5] Voyager_1.12.0                  ggplot2_4.0.0
#>  [7] SpatialExperiment_1.20.0        SingleCellExperiment_1.32.0
#>  [9] SummarizedExperiment_1.40.0     Biobase_2.70.0
#> [11] GenomicRanges_1.62.0            Seqinfo_1.0.0
#> [13] IRanges_2.44.0                  S4Vectors_0.48.0
#> [15] BiocGenerics_0.56.0             generics_0.1.4
#> [17] MatrixGenerics_1.22.0           matrixStats_1.5.0
#> [19] SpatialFeatureExperiment_1.12.0 SFEData_1.11.0
#> [21] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1             bitops_1.0-9
#>   [3] filelock_1.0.3            tibble_3.3.0
#>   [5] R.oo_1.27.1               lifecycle_1.0.4
#>   [7] httr2_1.2.1               sf_1.0-21
#>   [9] edgeR_4.8.0               lattice_0.22-7
#>  [11] MASS_7.3-65               magrittr_2.0.4
#>  [13] limma_3.66.0              sass_0.4.10
#>  [15] rmarkdown_2.30            jquerylib_0.1.4
#>  [17] yaml_2.3.10               metapod_1.18.0
#>  [19] sp_2.2-0                  DBI_1.2.3
#>  [21] RColorBrewer_1.1-3        multcomp_1.4-29
#>  [23] abind_1.4-8               spatialreg_1.4-2
#>  [25] purrr_1.1.0               R.utils_2.13.0
#>  [27] RCurl_1.98-1.17           TH.data_1.1-4
#>  [29] rappdirs_0.3.3            sandwich_3.1-1
#>  [31] ggrepel_0.9.6             irlba_2.3.5.1
#>  [33] terra_1.8-70              units_1.0-0
#>  [35] RSpectra_0.16-2           dqrng_0.4.1
#>  [37] DelayedMatrixStats_1.32.0 codetools_0.2-20
#>  [39] DropletUtils_1.30.0       DelayedArray_0.36.0
#>  [41] tidyselect_1.2.1          memuse_4.2-3
#>  [43] farver_2.1.2              viridis_0.6.5
#>  [45] ScaledMatrix_1.18.0       BiocFileCache_3.0.0
#>  [47] jsonlite_2.0.0            BiocNeighbors_2.4.0
#>  [49] e1071_1.7-16              survival_3.8-3
#>  [51] tools_4.5.1               ggnewscale_0.5.2
#>  [53] Rcpp_1.1.0                glue_1.8.0
#>  [55] gridExtra_2.3             SparseArray_1.10.0
#>  [57] xfun_0.53                 EBImage_4.52.0
#>  [59] dplyr_1.1.4               HDF5Array_1.38.0
#>  [61] withr_3.0.2               BiocManager_1.30.26
#>  [63] fastmap_1.2.0             boot_1.3-32
#>  [65] rhdf5filters_1.22.0       bluster_1.20.0
#>  [67] spData_2.3.4              digest_0.6.37
#>  [69] rsvd_1.0.5                R6_2.6.1
#>  [71] wk_0.9.4                  LearnBayes_2.15.1
#>  [73] jpeg_0.1-11               dichromat_2.0-0.1
#>  [75] RSQLite_2.4.3             R.methodsS3_1.8.2
#>  [77] h5mread_1.2.0             data.table_1.17.8
#>  [79] class_7.3-23              httr_1.4.7
#>  [81] htmlwidgets_1.6.4         S4Arrays_1.10.0
#>  [83] spdep_1.4-1               pkgconfig_2.0.3
#>  [85] scico_1.5.0               gtable_0.3.6
#>  [87] blob_1.2.4                S7_0.2.0
#>  [89] XVector_0.50.0            htmltools_0.5.8.1
#>  [91] bookdown_0.45             fftwtools_0.9-11
#>  [93] scales_1.4.0              png_0.1-8
#>  [95] knitr_1.50                rjson_0.2.23
#>  [97] coda_0.19-4.1             nlme_3.1-168
#>  [99] curl_7.0.0                proxy_0.4-27
#> [101] cachem_1.1.0              zoo_1.8-14
#> [103] rhdf5_2.54.0              BiocVersion_3.22.0
#> [105] KernSmooth_2.23-26        vipor_0.4.7
#> [107] parallel_4.5.1            AnnotationDbi_1.72.0
#> [109] s2_1.1.9                  pillar_1.11.1
#> [111] grid_4.5.1                vctrs_0.6.5
#> [113] BiocSingular_1.26.0       dbplyr_2.5.1
#> [115] beachmat_2.26.0           sfheaders_0.4.4
#> [117] cluster_2.1.8.1           beeswarm_0.4.0
#> [119] evaluate_1.0.5            tinytex_0.57
#> [121] zeallot_0.2.0             magick_2.9.0
#> [123] mvtnorm_1.3-3             cli_3.6.5
#> [125] locfit_1.5-9.12           compiler_4.5.1
#> [127] rlang_1.1.6               crayon_1.5.3
#> [129] labeling_0.4.3            classInt_0.4-11
#> [131] ggbeeswarm_0.7.2          viridisLite_0.4.2
#> [133] deldir_2.0-4              BiocParallel_1.44.0
#> [135] Biostrings_2.78.0         tiff_0.1-12
#> [137] Matrix_1.7-4              ExperimentHub_3.0.0
#> [139] patchwork_1.3.2           sparseMatrixStats_1.22.0
#> [141] bit64_4.6.0-1             Rhdf5lib_1.32.0
#> [143] KEGGREST_1.50.0           statmod_1.5.1
#> [145] AnnotationHub_4.0.0       igraph_2.2.1
#> [147] memoise_2.0.1             bslib_0.9.0
#> [149] bit_4.6.0
```