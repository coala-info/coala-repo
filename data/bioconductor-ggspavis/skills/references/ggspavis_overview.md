# ggspavis overview

Lukas M. Weber1, Helena L. Crowell2 and Yixing E. Dong3

1Boston University, Boston, MA, USA
2University of Zurich, Zurich, Switzerland
3University of Lausanne, Lausanne, Switzerland

#### 30 October 2025

#### Package

ggspavis 1.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Examples](#examples)
  + [2.1 Sequencing-based spatial transcriptomics data](#sequencing-based-spatial-transcriptomics-data)
    - [2.1.1 Spot shape - Slide-seq and Visium](#spot-shape---slide-seq-and-visium)
    - [2.1.2 Quality control (QC) plots](#quality-control-qc-plots)
    - [2.1.3 Bin shape - Visium HD](#bin-shape---visium-hd)
  + [2.2 Imaging-based spatial transcriptomics data](#imaging-based-spatial-transcriptomics-data)
  + [2.3 Reduced dimension plots](#reduced-dimension-plots)
* [3 Session information](#session-information)

# 1 Introduction

The `ggspavis` package contains a set of visualization functions for spatial transcriptomics data, designed to work with the [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment) Bioconductor object class.

# 2 Examples

Load some example datasets from the [STexampleData](https://bioconductor.org/packages/STexampleData) or [spatialLIBD](https://research.libd.org/spatialLIBD/) package and create some example plots to demonstrate `ggspavis`.

```
library(ggspavis)
library(STexampleData)
library(patchwork)
library(scater)
library(scran)
library(OSTA.data)
library(VisiumIO)
library(SpatialExperiment)
```

## 2.1 Sequencing-based spatial transcriptomics data

### 2.1.1 Spot shape - Slide-seq and Visium

First, we start with a demo for Slide-seq V2 mouse brain dataset.

```
spe_slide <- STexampleData::SlideSeqV2_mouseHPC()
spe_slide$loglibsize <- log1p(colSums(counts(spe_slide)))
```

We can visualize the barcoded beads of Slide-seq V2 spatially with `plotCoords()`.

```
(plotCoords(spe_slide, annotate = "celltype",
            in_tissue = NULL, point_size = 0.1) +
  guides(color=guide_legend(override.aes = list(size = 3), ncol = 2)) |
  plotCoords(spe_slide, annotate = "loglibsize",
             in_tissue = NULL, point_size = 0.1) +
  scale_color_gradient(name = "Log library size") + ggtitle("")) +
  plot_annotation(title = 'Slide-seq V2 Mouse Brain')
```

![](data:image/png;base64...)

Similarly, in a 10x Genomics Visium mouse brain dataset, we generate visualizations of library size and expression levels of selected genes. Both `plotVisium()` and `plotCoords()` reflect the spatial coordinates of spots, with the former also overlaying spots on the H&E histology image. Note that `plotVisium()` accepts a `SpatialExperiment` class object (with image data), while other functions in the package accept either `SpatialExperiment` or `SingleCellExperiment` class objects.

```
# load data in SpatialExperiment format
spe_vm <- Visium_mouseCoronal()
rownames(spe_vm) <- rowData(spe_vm)$gene_name
colData(spe_vm)$sum <- colSums(counts(spe_vm))
```

With `plotVisium()` annotated by a continuous variable, you can adjust palette, legend position, scaling of the variable, and whether to highlight spots that are in tissue, etc.

```
p1 <- plotVisium(spe_vm, annotate = "sum", highlight = "in_tissue",
                 legend_position = "none")
p2 <- plotVisium(spe_vm, annotate = "sum", highlight = "in_tissue",
                 pal = "darkred") +
  guides(fill = guide_colorbar(title = "Libsize"))

# display panels using patchwork
p1 | p2
```

![](data:image/png;base64...)

`plotVisium()` can also be used to visualize gene expression.

```
p1 <- plotVisium(spe_vm, annotate = "Gapdh", highlight = "in_tissue")
p2 <- plotVisium(spe_vm, annotate = "Mbp", highlight = "in_tissue")

# display panels using patchwork
p1 | p2
```

![](data:image/png;base64...)

Two other possibilities with `plotVisium()` are to show only spots or only the H&E image.

```
p1 <- plotVisium(spe_vm, annotate = "Mbp",
                 highlight = "in_tissue", image = FALSE)
p2 <- plotVisium(spe_vm, annotate = "Mbp",
                 highlight = "in_tissue", spots = FALSE)

# display panels using patchwork
p1 | p2
```

![](data:image/png;base64...)

`plotCoords()` by default subsets to only spots that are in tissue for a 10x Genomics Visium dataset. You can either leave the palette as NULL for a continuous, or change the palette in `plotCoords()` in a similar manner as in `plotVisium()`.

```
p1 <- plotCoords(spe_vm, annotate = "Gapdh")
p2 <- plotCoords(spe_vm, annotate = "Mbp", pal = "viridis")

# display panels using patchwork
p1 | p2
```

![](data:image/png;base64...)

`plotCoords()` and `plotVisium()` can also be used to visualize discrete or categorical annotation variables, such as cluster labels as colors on the spatial coordinates. We will introduce this functionality using the Visium human brain dorsolateral prefrontal cortex (DLPFC) dataset.

```
# load data in SpatialExperiment format
spe <- Visium_humanDLPFC()
rownames(spe) <- rowData(spe)$gene_name
colData(spe)$libsize <- colSums(counts(spe))
```

First, we check the manually annotated reference labels, highlighting the spots that are in tissue, using `plotVisium()`.

```
plotVisium(spe, annotate = "ground_truth", highlight = "in_tissue",
           pal = "libd_layer_colors")
```

![](data:image/png;base64...)

Here are some other choices of palettes.

```
p1 <- plotCoords(spe, annotate = "ground_truth", pal = "Okabe-Ito") +
  ggtitle("Reference")
p2 <- plotCoords(spe, annotate = "libsize", pal = "rainbow") +
  ggtitle("Library size")

# display panels using patchwork
p1 | p2
```

![](data:image/png;base64...)

### 2.1.2 Quality control (QC) plots

Note that these QC plot functions can be used for any `SpatialExperiment` object, not just Visium. For demonstration, we keep using Visium DLPFC dataset.

#### 2.1.2.1 Spot/bin/cell-level QC

We next derive some spot-level quality control (QC) flags for plotting. We use the `scater` package to add QC metrics to our data object.

```
# calculate QC metrics using scater
spe <- addPerCellQCMetrics(spe,
  subsets = list(mito = grepl("(^MT-)|(^mt-)", rowData(spe)$gene_name)))

# apply QC thresholds
colData(spe)$low_libsize <- colData(spe)$sum < 400 | colData(spe)$detected < 400
colData(spe)$high_mito <- colData(spe)$subsets_mito_percent > 30
```

`plotObsQC(plot_type = "spot")` reflects the spatial coordinates of the spots, where spots of interests can be labeled by a flag with TRUE or FALSE levels. The TRUE level are highlighted by red color.

We can investigate spots with low library size using histograms, violin plots, and spot plots.

```
p1 <- plotObsQC(spe, plot_type = "histogram",
                x_metric = "sum", annotate = "low_libsize")
p2 <- plotObsQC(spe, plot_type = "violin",
                x_metric = "sum", annotate = "low_libsize", point_size = 0.1)
p3 <- plotObsQC(spe, plot_type = "spot", in_tissue = "in_tissue",
                annotate = "low_libsize", point_size = 0.2)

# display panels using patchwork
p1 | p2 | p3
```

![](data:image/png;base64...)

Similarly, we can investigate spots with high mitochondrial proportion of reads.

```
p1 <- plotObsQC(spe, plot_type = "histogram",
                x_metric = "subsets_mito_percent", annotate = "high_mito")
p2 <- plotObsQC(spe, plot_type = "violin",
                x_metric = "subsets_mito_percent", annotate = "high_mito",
                point_size = 0.1)
p3 <- plotObsQC(spe, plot_type = "spot", in_tissue = "in_tissue",
                annotate = "high_mito", point_size = 0.2)

# display panels using patchwork
p1 | p2 | p3
```

![](data:image/png;base64...)

We can also use a scatter plot to check the trend between two variables, for example mitochondrial proportion vs. library size. We can also highlight spots by putting thresholds on the x and/or y axes.

```
plotObsQC(spe, plot_type = "scatter",
          x_metric = "subsets_mito_percent", y_metric = "sum",
          x_threshold = 30, y_threshold = 400)
```

![](data:image/png;base64...)

#### 2.1.2.2 Feature-level QC

Perform feature-level (gene-level) QC and visualize the result with a histogram. For example, for Visium, we demonstrate an arbitrary threshold that a gene should be detected in at least 20 spots to be considered not lowly abundant. The plot includes `log1p` transformation for easier visualization.

```
rowData(spe)$feature_sum <- rowSums(counts(spe))
rowData(spe)$low_abundance <- rowSums(counts(spe) > 0) < 20

p1 <- plotFeatureQC(spe, plot_type = "histogram",
                    x_metric = "feature_sum", annotate = "low_abundance")
p2 <- plotFeatureQC(spe, plot_type = "violin",
                    x_metric = "feature_sum", annotate = "low_abundance")

# display panels using patchwork
p1 | p2
```

![](data:image/png;base64...)

### 2.1.3 Bin shape - Visium HD

Visium HD contains data binned into square shapes. We load an example dataset at 8 \(\mu\)m, and subset to a smaller region.

```
# retrieve dataset from OSF repo
id <- "VisiumHD_HumanColon_Oliveira"
pa <- OSTA.data_load(id)
dir.create(td <- tempfile())
unzip(pa, exdir=td)

# read 8um bins into 'SpatialExperiment'
vhd8 <- TENxVisiumHD(spacerangerOut=td, processing="filtered", format="h5",
                     images="lowres", bin_size="008") |> import()
# subset
vhd8 <- vhd8[, spatialCoords(vhd8)[, 1] * scaleFactors(vhd8) > 430 &
               spatialCoords(vhd8)[, 1] * scaleFactors(vhd8) < 435 &
               spatialCoords(vhd8)[, 2] * scaleFactors(vhd8) > 127 &
               spatialCoords(vhd8)[, 2] * scaleFactors(vhd8) < 132]
rownames(vhd8) <- rowData(vhd8)$Symbol
vhd8
```

```
## class: SpatialExperiment
## dim: 18085 456
## metadata(2): resources spatialList
## assays(1): counts
## rownames(18085): SAMD11 NOC2L ... MT-ND6 MT-CYB
## rowData names(3): ID Symbol Type
## colnames(456): s_008um_00213_00462-1 s_008um_00221_00472-1 ...
##   s_008um_00209_00466-1 s_008um_00216_00470-1
## colData names(6): barcode in_tissue ... bin_size sample_id
## reducedDimNames(0):
## mainExpName: Gene Expression
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

Similar to Visium, we can also plot the data points spatially, with or without the H&E image overlayed. However, we need to change the point shape to square. The default value for `point_shape` is `16` in `plotCoords()` and `21` in `plotVisium()` for Visium spots. These values should be updated to `15` and `22` for Visium HD bins, respectively. Let us visualize the gene expression of *PIGR*, with or without H&E.

```
plotCoords(vhd8, point_shape=15, point_size = 1.7, annotate="PIGR") |
  plotVisium(vhd8, point_shape=22, point_size = 2, annotate="PIGR",
           zoom = TRUE)
```

![](data:image/png;base64...)

## 2.2 Imaging-based spatial transcriptomics data

We load example datasets from Xenium (10x Genomics), CosMx (Nanostring, now Bruker), MERSCOPE (Vizgen), and STARmapPLUS.

```
spe_xen <- STexampleData::Janesick_breastCancer_Xenium_rep1()
spe_cos <- STexampleData::CosMx_lungCancer()
spe_mer <- STexampleData::MERSCOPE_ovarianCancer()
spe_sta <- STexampleData::STARmapPLUS_mouseBrain()
```

Note that `in_tissue = NULL` must be specified for all imaging-based SPE objects. Point size could be adjusted manually if needed.

```
plotCoords(spe_xen, annotate = "cell_area", in_tissue = NULL, pal = "magma",
           point_size = 0.15) + ggtitle("Xenium Breast Cancer") |
  plotCoords(spe_cos, annotate = "Area", in_tissue = NULL, pal = "plasma",
             point_size = 0.1) + ggtitle("CosMx Breast Cancer") |
  plotCoords(spe_mer, annotate = "volume", in_tissue = NULL,
             pal = c("navyblue", "yellow"),
             point_size = 0.05) + ggtitle("MERSCOPE Ovarian Cancer")
```

![](data:image/png;base64...)

Another imaging-based technology STARmapPLUS has annotated mouse brain data. We demonstrate the following visualization on this relatively small dataset. Note, we can overlay text labels over the clusters using the `text_by` argument.

```
plotCoords(spe_sta, annotate = "Main_molecular_tissue_region", in_tissue = NULL,
           point_size = 0.1, text_by = "Main_molecular_tissue_region",
           text_by_size = 4, text_by_color = "#2d2d2d")
```

![](data:image/png;base64...)

Here we perform some quick processing to get reduced dimensions.

```
spe_sta <- logNormCounts(spe_sta)
dec <- modelGeneVar(spe_sta)
hvg <- getTopHVGs(dec, n=3e3)
spe_sta <- runPCA(spe_sta, subset_row=hvg)
spe_sta <- runUMAP(spe_sta, dimred="PCA")
```

## 2.3 Reduced dimension plots

We can also use the `plotDimRed()` function to generate reduced dimension plots, e.g. PCA or UMAP, with on-cluster annotation (at the center location of each cluster) using `text_by`.

```
plotDimRed(spe_sta, plot_type = "UMAP",
           annotate = "Main_molecular_tissue_region",
           text_by = "Main_molecular_tissue_region",
           text_by_size = 3, text_by_color = "#2d2d2d")
```

![](data:image/png;base64...)

# 3 Session information

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
##  [1] VisiumIO_1.6.0              TENxIO_1.12.0
##  [3] OSTA.data_1.2.0             scran_1.38.0
##  [5] scater_1.38.0               scuttle_1.20.0
##  [7] patchwork_1.3.2             STexampleData_1.17.1
##  [9] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
## [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [21] BiocFileCache_3.0.0         dbplyr_2.5.1
## [23] BiocGenerics_0.56.0         generics_0.1.4
## [25] ggspavis_1.16.0             ggplot2_4.0.0
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       magrittr_2.0.4
##   [4] ggbeeswarm_0.7.2     magick_2.9.0         farver_2.1.2
##   [7] rmarkdown_2.30       fs_1.6.6             BiocIO_1.20.0
##  [10] vctrs_0.6.5          memoise_2.0.1        tinytex_0.57
##  [13] htmltools_0.5.8.1    S4Arrays_1.10.0      BiocBaseUtils_1.12.0
##  [16] curl_7.0.0           BiocNeighbors_2.4.0  Rhdf5lib_1.32.0
##  [19] rhdf5_2.54.0         SparseArray_1.10.0   sass_0.4.10
##  [22] bslib_0.9.0          httr2_1.2.1          cachem_1.1.0
##  [25] igraph_2.2.1         lifecycle_1.0.4      ggside_0.4.0
##  [28] pkgconfig_2.0.3      rsvd_1.0.5           Matrix_1.7-4
##  [31] R6_2.6.1             fastmap_1.2.0        digest_0.6.37
##  [34] AnnotationDbi_1.72.0 dqrng_0.4.1          irlba_2.3.5.1
##  [37] RSQLite_2.4.3        beachmat_2.26.0      filelock_1.0.3
##  [40] labeling_0.4.3       urltools_1.7.3.1     mgcv_1.9-3
##  [43] httr_1.4.7           abind_1.4-8          compiler_4.5.1
##  [46] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [49] BiocParallel_1.44.0  viridis_0.6.5        DBI_1.2.3
##  [52] HDF5Array_1.38.0     R.utils_2.13.0       rappdirs_0.3.3
##  [55] DelayedArray_0.36.0  rjson_0.2.23         bluster_1.20.0
##  [58] tools_4.5.1          vipor_0.4.7          beeswarm_0.4.0
##  [61] R.oo_1.27.1          glue_1.8.0           h5mread_1.2.0
##  [64] rhdf5filters_1.22.0  nlme_3.1-168         grid_4.5.1
##  [67] cluster_2.1.8.1      gtable_0.3.6         tzdb_0.5.0
##  [70] R.methodsS3_1.8.2    hms_1.1.4            BiocSingular_1.26.0
##  [73] ScaledMatrix_1.18.0  metapod_1.18.0       XVector_0.50.0
##  [76] RcppAnnoy_0.0.22     ggrepel_0.9.6        BiocVersion_3.22.0
##  [79] pillar_1.11.1        limma_3.66.0         splines_4.5.1
##  [82] dplyr_1.1.4          lattice_0.22-7       bit_4.6.0
##  [85] tidyselect_1.2.1     locfit_1.5-9.12      Biostrings_2.78.0
##  [88] knitr_1.50           gridExtra_2.3        osfr_0.2.9
##  [91] bookdown_0.45        edgeR_4.8.0          crul_1.6.0
##  [94] xfun_0.53            statmod_1.5.1        stringi_1.8.7
##  [97] yaml_2.3.10          evaluate_1.0.5       codetools_0.2-20
## [100] httpcode_0.3.0       tibble_3.3.0         BiocManager_1.30.26
## [103] cli_3.6.5            uwot_0.2.3           arrow_22.0.0
## [106] jquerylib_0.1.4      dichromat_2.0-0.1    Rcpp_1.1.0
## [109] triebeard_0.4.1      png_0.1-8            parallel_4.5.1
## [112] assertthat_0.2.1     readr_2.1.5          blob_1.2.4
## [115] viridisLite_0.4.2    scales_1.4.0         purrr_1.1.0
## [118] crayon_1.5.3         rlang_1.1.6          KEGGREST_1.50.0
```