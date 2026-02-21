# Some important parameters for UCell

Massimo Andreatta1 and Santiago J. Carmona1

1Department of Pathology and Immunology, Faculty of Medicine, University of Geneva, 1206, Geneva, Switzerland; Swiss Institute of Bioinformatics, 1015, Lausanne, Switzerland

#### 30 October 2025

#### Package

UCell 2.14.0

# 1 Introduction

This document describes some **important parameters** of the UCell algorithm, and how they can be adapted depending on your dataset. Here we will use single-cell data stored in a Seurat object, but the same considerations apply to [SingleCellExperiment](https://bioconductor.org/packages/release/bioc/vignettes/UCell/inst/doc/UCell_sce.html) or [matrix](https://bioconductor.org/packages/release/bioc/vignettes/UCell/inst/doc/UCell_vignette_basic.html) input formats.

# 2 Load example dataset

For this demo, we will download a single-cell dataset of lung cancer ([Zilionis et al. (2019) Immunity](https://pubmed.ncbi.nlm.nih.gov/30979687/)) through the [scRNA-seq](https://bioconductor.org/packages/3.15/data/experiment/html/scRNAseq.html) package. This dataset contains >170,000 single cells; for the sake of simplicity, in this demo will we focus on immune cells, according to the annotations by the authors, and downsample to 5000 cells.

```
library(scRNAseq)
library(ggplot2)

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
seurat.object <- NormalizeData(seurat.object)
```

**Note:** becase UCell scores are based on relative gene ranks, it can be applied both on raw counts or normalized data. As long as the normalization preserves the relative ranks between genes, the results will be equivalent.

# 3 Parameters

## 3.1 Positive and negative gene sets in signatures

UCell supports positive and negative gene sets within a signature. Simply append + or - signs to the genes to include them in positive and negative sets, respectively. For example:

```
signatures <- list(
    CD8T = c("CD8A+","CD8B+","CD4-"),
    CD4 = c("TRAC+","CD4+","CD40LG+","CD8A-","CD8B-"),
    NK = c("KLRD1+","NCR1+","NKG7+","CD3D-","CD3E-")
)
```

UCell evaluates the positive and negative gene sets separately, then subtracts the scores. The parameter `w_neg` controls the relative weight of the negative gene set compared to the positive set (`w_neg=1.0` means equal weight). Note that the combined score is clipped to zero, to preserve UCell scores in the [0, 1] range.

```
library(UCell)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      w_neg = 1.0, name = NULL)

scores <- seurat.object[[names(signatures)]]
head(scores,15)
```

```
##              CD8T        CD4       NK
## bcHTNA1  0.000000 0.14975523 0.000000
## bcHNVA2  0.000000 0.02503338 0.000000
## bcALZN3  0.000000 0.00000000 0.000000
## bcFWBP4  0.000000 0.00000000 0.000000
## bcBJYE5  0.000000 0.28627058 0.000000
## bcGSBJ6  0.000000 0.00000000 0.000000
## bcHQGJ7  0.000000 0.00000000 0.000000
## bcHKKM8  0.000000 0.21161549 0.000000
## bcIGQU9  0.000000 0.28649310 0.000000
## bcDVGG10 0.000000 0.21384068 0.000000
## bcEPCC11 0.707374 0.00000000 0.000000
## bcDOHD12 0.000000 0.00000000 0.000000
## bcFPZF13 0.000000 0.27403204 0.274032
## bcHRXV14 0.000000 0.00000000 0.000000
## bcFGME15 0.000000 0.31753449 0.000000
```

## 3.2 The `maxRank` parameter

Single-cell data are sparse. In other words, for any given cell only a few hundred/a few thousand genes (out of tens of thousands) are detected with at least one UMI count. Because UCell scores are based on ranking genes by their expression values, it is essential to account for data sparsity when calculating ranks. This is implemented by capping ranks to a `maxRank` parameter, in other words only the top `maxRank` genes are ranked, and the rest are assumed equivalent at the lowest ranking value.

It is often useful to adjust the `maxRank` depending on the sparsity of your dataset. A good rule of thumb is to examine the median number of expressed genes per cell, and set `maxRank` in that order of magnitude. For example, for the test dataset:

```
VlnPlot(seurat.object, features="nFeature_RNA", pt.size = 0, log = TRUE)
```

![](data:image/png;base64...)
This dataset has relatively low depth, so it is advisable to choose a `maxRank` around 800-1000 (from the default 1500)

```
seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      maxRank=1000)
```

This is even more important when applying UCell to technologies/modalities of much lower dimensionality, for example probe-based spatial transcriptomics data (e.g. Xenium, CosMx), or antibody tags (ADT) in CITE-seq experiments. Xenium panels contain a few hundred/a few thousand genes; CITE-seq can detect a few hundred proteins, as opposed to thousands of genes in scRNA-seq. The `maxRank` parameter should then also be adapted to reflect the new dimensionality, and set it at most to the number of probes in the panel.

## 3.3 Handling missing genes

If a subset of the genes in your signature are absent from the count matrix, how should they be handled?

UCell offers two alternative ways of handling missing genes:

* `missing_genes="impute"` (default): it assumes that absence from the count matrix means zero expression. All values for this gene are imputed to zero. This can sometimes be the case for processed scRNA-seq datasets deposited in public repositories, where poorly detected genes are often dropped from the count matrix.
* `missing_genes="skip"`: simply exclude all missing genes from the signatures; they won’t contribute to the scores.

Here’s an example with a missing gene:

```
signatures <- list(
    Myeloid = c("LYZ","CSF1R","not_a_gene")
)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      missing_genes="impute")
scores1 <- seurat.object$Myeloid_UCell

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      missing_genes="skip")
scores2 <- seurat.object$Myeloid_UCell

scores <- cbind(scores1, scores2)
head(scores)
```

```
##           scores1   scores2
## bcHTNA1 0.3319982 0.4978312
## bcHNVA2 0.5263685 0.7892893
## bcALZN3 0.3333333 0.4998332
## bcFWBP4 0.0000000 0.0000000
## bcBJYE5 0.2078327 0.3116450
## bcGSBJ6 0.4755229 0.7130464
```

## 3.4 Chunk size

UCell scores are calculated individually for each cell (though they may be later [smoothed](https://bioconductor.org/packages/release/bioc/vignettes/UCell/inst/doc/UCell_Seurat.html#5_Signature_smoothing) by nearest-neighbor similarity). This means that computation can be easily split into batches, reducing the computational footprint of gene ranking and enabling parallel processing (see below). The size of the batches is controlled by the `chunk.size` parameter. Large chunks take up more RAM, while small chunk sizes have large overhead from dataset splitting and merging. A sweet spot for `chunk.size` is usually in the order of 100-1000 cells per batch.

```
seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      chunk.size=500)
```

## 3.5 Parallelization

If your machine has multi-core capabilities and enough RAM, running UCell in parallel can speed up considerably your analysis. The example below runs on a single core - you may modify this behavior by setting e.g. `workers=8` to parallelize to 8 processes:

```
BPPARAM <- BiocParallel::MulticoreParam(workers=1)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      BPPARAM=BPPARAM)
```

## 3.6 Signature score smoothing

To mitigate sparsity in single-cell data, it can be useful to ‘impute’ scores by neighboring cells. The function `SmoothKNN` performs smoothing of single-cell scores by weighted average of the k-nearest neighbors in a given dimensionality reduction. A crucial parameter is the number of neighbors `k` that are used for smoothing. A small `k` only borrows from very close neighbors, a large `k` takes weighted averages over large portions of transcriptional space:

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

```
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      name=NULL)
```

```
seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=3, suffix = "_kNN3")

seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=100, suffix = "_kNN100")
```

```
FeaturePlot(seurat.object, reduction = "umap",
            features = c("Tcell","Tcell_kNN3")) &
  theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

```
FeaturePlot(seurat.object, reduction = "umap",
            features = c("Tcell","Tcell_kNN100")) &
  theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

The `decay` parameter controls the relative influence of close vs distant neighbors. Lower the `decay` parameter to increase the weight for distant neighbors, increase `decay` to give higher weight to close neighbors

```
seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=100, decay=0.001, suffix = "_decay0.001")

seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=100, decay=0.5, suffix = "_decay0.5")
```

```
FeaturePlot(seurat.object, reduction = "umap",
            features = c("Tcell_decay0.5","Tcell_decay0.001")) &
  theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

# 4 Resources

Please report any issues at the [UCell GitHub repository](https://github.com/carmonalab/UCell).

More demos available on the [Bioc landing page](https://bioconductor.org/packages/release/bioc/html/UCell.html) and at the [UCell demo repository](https://github.com/carmonalab/UCell_demo).

If you find UCell useful, you may also check out the [scGate package](https://github.com/carmonalab/scGate), which relies on UCell scores to automatically purify populations of interest based on gene signatures.

See also [SignatuR](https://github.com/carmonalab/SignatuR) for easy storing and retrieval of gene signatures.

# 5 References

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
## [118] BiocVersion_3.22.0       KernSmooth_2.23-26       vipor_0.4.7
## [121] parallel_4.5.1           miniUI_0.1.2             AnnotationDbi_1.72.0
## [124] ggrastr_1.0.2            restfulr_0.0.16          pillar_1.11.1
## [127] grid_4.5.1               alabaster.schemas_1.10.0 vctrs_0.6.5
## [130] RANN_2.6.2               promises_1.4.0           dbplyr_2.5.1
## [133] xtable_1.8-4             cluster_2.1.8.1          beeswarm_0.4.0
## [136] evaluate_1.0.5           magick_2.9.0             tinytex_0.57
## [139] GenomicFeatures_1.62.0   cli_3.6.5                compiler_4.5.1
## [142] Rsamtools_2.26.0         rlang_1.1.6              crayon_1.5.3
## [145] future.apply_1.20.0      labeling_0.4.3           ggbeeswarm_0.7.2
## [148] plyr_1.8.9               stringi_1.8.7            deldir_2.0-4
## [151] viridisLite_0.4.2        alabaster.se_1.10.0      BiocParallel_1.44.0
## [154] Biostrings_2.78.0        lazyeval_0.2.2           spatstat.geom_3.6-0
## [157] Matrix_1.7-4             ExperimentHub_3.0.0      RcppHNSW_0.6.0
## [160] bit64_4.6.0-1            future_1.67.0            Rhdf5lib_1.32.0
## [163] KEGGREST_1.50.0          shiny_1.11.1             alabaster.ranges_1.10.0
## [166] AnnotationHub_4.0.0      ROCR_1.0-11              igraph_2.2.1
## [169] memoise_2.0.1            bslib_0.9.0              bit_4.6.0
```