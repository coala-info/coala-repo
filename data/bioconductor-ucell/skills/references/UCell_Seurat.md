# Using UCell with Seurat

Massimo Andreatta1 and Santiago J. Carmona1

1Department of Pathology and Immunology, Faculty of Medicine, University of Geneva, 1206, Geneva, Switzerland; Swiss Institute of Bioinformatics, 1015, Lausanne, Switzerland

#### 30 October 2025

#### Package

UCell 2.14.0

# 1 Introduction

The function `AddModuleScore_UCell()` allows operating directly on Seurat objects. UCell scores are calculated from raw counts or normalized data, and returned as metadata columns. The example below defines some simple signatures, and applies them on single-cell data stored in a Seurat object.

To see how this function differs from Seurat’s own `AddModuleScore()` (not based on per-cell ranks) see [this vignette](https://carmonalab.github.io/UCell_demo/UCell_Seurat_vignette.html).

# 2 Get some testing data

For this demo, we will download a single-cell dataset of lung cancer ([Zilionis et al. (2019) Immunity](https://pubmed.ncbi.nlm.nih.gov/30979687/)) through the [scRNA-seq](https://bioconductor.org/packages/3.15/data/experiment/html/scRNAseq.html) package. This dataset contains >170,000 single cells; for the sake of simplicity, in this demo will we focus on immune cells, according to the annotations by the authors, and downsample to 5000 cells.

```
library(scRNAseq)

lung <- ZilionisLungData()
immune <- lung$Used & lung$used_in_NSCLC_immune
lung <- lung[,immune]
lung <- lung[,1:5000]

exp.mat <- Matrix::Matrix(counts(lung),sparse = TRUE)
colnames(exp.mat) <- paste0(colnames(exp.mat), seq(1,ncol(exp.mat)))
```

Save it as a Seurat object

```
library(Seurat)
seurat.object <- CreateSeuratObject(counts = exp.mat,
                                    project = "Zilionis_immune")
```

# 3 Define gene signatures

Here we define some simple gene sets based on the “Human Cell Landscape” signatures [Han et al. (2020) Nature](https://www.nature.com/articles/s41586-020-2157-4). You may edit existing signatures, or add new one as elements in a list.

```
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)
```

# 4 Run UCell on Seurat object

```
library(UCell)
seurat.object <- AddModuleScore_UCell(seurat.object,
                                      features=signatures, name=NULL)
head(seurat.object[[]])
```

```
##              orig.ident nCount_RNA nFeature_RNA Tcell   Myeloid NK Plasma_cell
## bcHTNA1 Zilionis_immune       7516         2613     0 0.5227121  0  0.00000000
## bcHNVA2 Zilionis_immune       5684         1981     0 0.5112892  0  0.00000000
## bcALZN3 Zilionis_immune       4558         1867     0 0.3584502  0  0.07540874
## bcFWBP4 Zilionis_immune       2915         1308     0 0.1546426  0  0.00000000
## bcBJYE5 Zilionis_immune       3576         1548     0 0.4629927  0  0.00000000
## bcGSBJ6 Zilionis_immune       2796         1270     0 0.5452238  0  0.00000000
```

Generate PCA and UMAP embeddings

```
seurat.object <- NormalizeData(seurat.object)
seurat.object <- FindVariableFeatures(seurat.object,
                     selection.method = "vst", nfeatures = 500)

seurat.object <- ScaleData(seurat.object)
seurat.object <- RunPCA(seurat.object, npcs = 20,
                        features=VariableFeatures(seurat.object))
seurat.object <- RunUMAP(seurat.object, reduction = "pca",
                         dims = 1:20, seed.use=123)
```

Visualize UCell scores on low-dimensional representation (UMAP)

```
library(ggplot2)
library(patchwork)

FeaturePlot(seurat.object, reduction = "umap", features = names(signatures)[1:2]) &
  theme(aspect.ratio = 1,
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())
```

![](data:image/png;base64...)

# 5 Signature smoothing

Single-cell data are sparse. It can be useful to ‘impute’ scores by neighboring cells and partially correct this sparsity. The function `SmoothKNN` performs smoothing of single-cell scores by weighted average of the k-nearest neighbors in a given dimensionality reduction. It can be applied directly on Seurat objects to smooth UCell scores:

```
seurat.object <- SmoothKNN(seurat.object,
                           signature.names = names(signatures),
                           reduction="pca")
```

```
FeaturePlot(seurat.object, reduction = "umap", features = c("NK","NK_kNN")) &
    theme(aspect.ratio = 1,
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())
```

![](data:image/png;base64...)

Smoothing (or imputation) has been designed for UCell scores, but it can be applied to any other data or metadata. For instance, we can perform knn-smoothing directly on gene expression measurements:

```
genes <- c("CD2","CSF1R")
seurat.object <- SmoothKNN(seurat.object, signature.names=genes,
                 assay="RNA", reduction="pca", k=20, suffix = "_smooth")

DefaultAssay(seurat.object) <- "RNA"
FeaturePlot(seurat.object, reduction = "umap", features = genes) &
  theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

```
DefaultAssay(seurat.object) <- "RNA_smooth"
FeaturePlot(seurat.object, reduction = "umap", features = genes) &
  theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

# 6 Resources

Please report any issues at the [UCell GitHub repository](https://github.com/carmonalab/UCell).

More demos available on the [Bioc landing page](https://bioconductor.org/packages/release/bioc/html/UCell.html) and at the [UCell demo repository](https://github.com/carmonalab/UCell_demo).

If you find UCell useful, you may also check out the [scGate package](https://github.com/carmonalab/scGate), which relies on UCell scores to automatically purify populations of interest based on gene signatures.

See also [SignatuR](https://github.com/carmonalab/SignatuR) for easy storing and retrieval of gene signatures.

# 7 References

# Appendix

* Andreatta, M., Carmona, S. J. (2021) *UCell: Robust and scalable single-cell gene signature scoring* Computational and Structural Biotechnology Journal
* Zilionis, R., Engblom, C., …, Klein, A. M. (2019) *Single-Cell Transcriptomics of Human and Mouse Lung Cancers Reveals Conserved Myeloid Populations across Individuals and Species* Immunity
* Hao, Yuhan, et al. (2021) *Integrated analysis of multimodal single-cell data* Cell

# A Session Info

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
##  [1] patchwork_1.3.2             ggplot2_4.0.0
##  [3] UCell_2.14.0                Seurat_5.3.1
##  [5] SeuratObject_5.2.0          sp_2.2-0
##  [7] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22         splines_4.5.1            later_1.4.4
##   [4] BiocIO_1.20.0            bitops_1.0-9             filelock_1.0.3
##   [7] tibble_3.3.0             polyclip_1.10-7          XML_3.99-0.19
##  [10] fastDummies_1.7.5        lifecycle_1.0.4          httr2_1.2.1
##  [13] globals_0.18.0           lattice_0.22-7           ensembldb_2.34.0
##  [16] MASS_7.3-65              alabaster.base_1.10.0    magrittr_2.0.4
##  [19] plotly_4.11.0            sass_0.4.10              rmarkdown_2.30
##  [22] jquerylib_0.1.4          yaml_2.3.10              httpuv_1.6.16
##  [25] otel_0.2.0               sctransform_0.4.2        spam_2.11-1
##  [28] spatstat.sparse_3.1-0    reticulate_1.44.0        cowplot_1.2.0
##  [31] pbapply_1.7-4            DBI_1.2.3                RColorBrewer_1.1-3
##  [34] abind_1.4-8              Rtsne_0.17               purrr_1.1.0
##  [37] AnnotationFilter_1.34.0  RCurl_1.98-1.17          rappdirs_0.3.3
##  [40] ggrepel_0.9.6            irlba_2.3.5.1            spatstat.utils_3.2-0
##  [43] listenv_0.9.1            alabaster.sce_1.10.0     goftest_1.2-3
##  [46] RSpectra_0.16-2          spatstat.random_3.4-2    fitdistrplus_1.2-4
##  [49] parallelly_1.45.1        codetools_0.2-20         DelayedArray_0.36.0
##  [52] tidyselect_1.2.1         UCSC.utils_1.6.0         farver_2.1.2
##  [55] spatstat.explore_3.5-3   BiocFileCache_3.0.0      GenomicAlignments_1.46.0
##  [58] jsonlite_2.0.0           BiocNeighbors_2.4.0      progressr_0.17.0
##  [61] ggridges_0.5.7           survival_3.8-3           tools_4.5.1
##  [64] ica_1.0-3                Rcpp_1.1.0               glue_1.8.0
##  [67] gridExtra_2.3            SparseArray_1.10.0       xfun_0.53
##  [70] GenomeInfoDb_1.46.0      dplyr_1.1.4              HDF5Array_1.38.0
##  [73] gypsum_1.6.0             withr_3.0.2              BiocManager_1.30.26
##  [76] fastmap_1.2.0            rhdf5filters_1.22.0      digest_0.6.37
##  [79] R6_2.6.1                 mime_0.13                scattermore_1.2
##  [82] tensor_1.5.1             spatstat.data_3.1-9      dichromat_2.0-0.1
##  [85] RSQLite_2.4.3            cigarillo_1.0.0          h5mread_1.2.0
##  [88] tidyr_1.3.1              data.table_1.17.8        rtracklayer_1.70.0
##  [91] htmlwidgets_1.6.4        httr_1.4.7               S4Arrays_1.10.0
##  [94] uwot_0.2.3               pkgconfig_2.0.3          gtable_0.3.6
##  [97] blob_1.2.4               lmtest_0.9-40            S7_0.2.0
## [100] XVector_0.50.0           htmltools_0.5.8.1        dotCall64_1.2
## [103] bookdown_0.45            ProtGenerics_1.42.0      scales_1.4.0
## [106] alabaster.matrix_1.10.0  png_0.1-8                spatstat.univar_3.1-4
## [109] knitr_1.50               reshape2_1.4.4           rjson_0.2.23
## [112] nlme_3.1-168             curl_7.0.0               cachem_1.1.0
## [115] zoo_1.8-14               rhdf5_2.54.0             stringr_1.5.2
## [118] BiocVersion_3.22.0       KernSmooth_2.23-26       parallel_4.5.1
## [121] miniUI_0.1.2             AnnotationDbi_1.72.0     restfulr_0.0.16
## [124] pillar_1.11.1            grid_4.5.1               alabaster.schemas_1.10.0
## [127] vctrs_0.6.5              RANN_2.6.2               promises_1.4.0
## [130] dbplyr_2.5.1             xtable_1.8-4             cluster_2.1.8.1
## [133] evaluate_1.0.5           magick_2.9.0             tinytex_0.57
## [136] GenomicFeatures_1.62.0   cli_3.6.5                compiler_4.5.1
## [139] Rsamtools_2.26.0         rlang_1.1.6              crayon_1.5.3
## [142] future.apply_1.20.0      labeling_0.4.3           plyr_1.8.9
## [145] stringi_1.8.7            deldir_2.0-4             viridisLite_0.4.2
## [148] alabaster.se_1.10.0      BiocParallel_1.44.0      Biostrings_2.78.0
## [151] lazyeval_0.2.2           spatstat.geom_3.6-0      Matrix_1.7-4
## [154] ExperimentHub_3.0.0      RcppHNSW_0.6.0           bit64_4.6.0-1
## [157] future_1.67.0            Rhdf5lib_1.32.0          KEGGREST_1.50.0
## [160] shiny_1.11.1             alabaster.ranges_1.10.0  AnnotationHub_4.0.0
## [163] ROCR_1.0-11              igraph_2.2.1             memoise_2.0.1
## [166] bslib_0.9.0              bit_4.6.0
```