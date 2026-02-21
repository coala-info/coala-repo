# Gene signature scoring with UCell

Massimo Andreatta1 and Santiago J. Carmona1

1Department of Pathology and Immunology, Faculty of Medicine, University of Geneva, 1206, Geneva, Switzerland; Swiss Institute of Bioinformatics, 1015, Lausanne, Switzerland

#### 30 October 2025

#### Package

UCell 2.14.0

# 1 Introduction

In single-cell RNA-seq analysis, gene signature (or “module”) scoring constitutes a simple yet powerful approach to evaluate the strength of biological signals, typically associated to a specific cell type or biological process, in a transcriptome.

UCell is an R package for evaluating gene signatures in single-cell datasets. UCell signature scores, based on the Mann-Whitney U statistic, are robust to dataset size and heterogeneity, and their calculation demands less computing time and memory than other available methods, enabling the processing of large datasets in a few minutes even on machines with limited computing power. UCell can be applied to any single-cell data matrix, and includes functions to directly interact with Seurat objects.

# 2 Quick start

To test your installation, load a small sample dataset and run UCell:

```
library(UCell)

data(sample.matrix)
gene.sets <- list(Tcell_signature = c("CD2","CD3E","CD3D"),
                  Myeloid_signature = c("SPI1","FCER1G","CSF1R"))

scores <- ScoreSignatures_UCell(sample.matrix, features=gene.sets)
head(scores)
```

```
##                       Tcell_signature_UCell Myeloid_signature_UCell
## L5_ATTTCTGAGGTCGTGA               0.8991989                       0
## L4_TCACTATTCATCTCTA               0.6900312                       0
## L1_TCCTTCTTCTTTACAC               0.5932354                       0
## L5_AAAGTGAAGGCGCTCT               0.6090343                       0
## E2L3_CCTCAGTAGTGCAGGT             0.8506898                       0
## L5_CCCTCTCGTTCTAAGC               0.6557632                       0
```

# 3 Get some testing data

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

**Note:** becase UCell scores are based on relative gene ranks, it can be applied both on raw counts or normalized data. As long as the normalization preserves the relative ranks between genes, the results will be equivalent.

# 4 Define gene signatures

Here we define some simple gene sets based on the “Human Cell Landscape” signatures [Han et al. (2020) Nature](https://www.nature.com/articles/s41586-020-2157-4). You may edit existing signatures, or add new one as elements in a list.

```
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)
```

# 5 Run UCell

Run `ScoreSignatures_UCell` and get directly signature scores for all cells

```
u.scores <- ScoreSignatures_UCell(exp.mat,features=signatures)
head(u.scores)
```

```
##         Tcell_UCell Myeloid_UCell NK_UCell Plasma_cell_UCell
## bcHTNA1           0     0.5227121        0        0.00000000
## bcHNVA2           0     0.5112892        0        0.00000000
## bcALZN3           0     0.3584502        0        0.07540874
## bcFWBP4           0     0.1546426        0        0.00000000
## bcBJYE5           0     0.4629927        0        0.00000000
## bcGSBJ6           0     0.5452238        0        0.00000000
```

Show the distribution of predicted scores

```
library(reshape2)
library(ggplot2)
melted <- reshape2::melt(u.scores)
colnames(melted) <- c("Cell","Signature","UCell_score")
p <- ggplot(melted, aes(x=Signature, y=UCell_score)) +
    geom_violin(aes(fill=Signature), scale = "width") +
    geom_boxplot(width=0.1, outlier.size=0) +
    theme_bw() + theme(axis.text.x=element_blank())
p
```

![](data:image/png;base64...)

# 6 Pre-calculating gene rankings

The time- and memory-demanding step in UCell is the calculation of gene rankings for each individual cell. If we plan to experiment with signatures, editing them or adding new cell subtypes, it is possible to pre-calculate the gene rankings once and for all and then apply new signatures over these pre-calculated ranks. Run the `StoreRankings_UCell` function to pre-calculate gene rankings over a dataset:

```
set.seed(123)
ranks <- StoreRankings_UCell(exp.mat)
ranks[1:5,1:5]
```

```
## 5 x 5 sparse Matrix of class "dgCMatrix"
##           bcHTNA1 bcHNVA2 bcALZN3 bcFWBP4 bcBJYE5
## 5S_rRNA         .       .       .       .       .
## 5_8S_rRNA       .       .       .       .       .
## 7SK             .       .       .       .       .
## A1BG            .       .       .       .       .
## A1BG-AS1        .       .       .       .       .
```

Then, we can apply our signature set, or any other new signature to the pre-calculated ranks. The calculations will be considerably faster.

```
set.seed(123)
u.scores.2 <- ScoreSignatures_UCell(features=signatures,
                                    precalc.ranks = ranks)

melted <- reshape2::melt(u.scores.2)
colnames(melted) <- c("Cell","Signature","UCell_score")
p <- ggplot(melted, aes(x=Signature, y=UCell_score)) +
    geom_violin(aes(fill=Signature), scale = "width") +
    geom_boxplot(width=0.1, outlier.size = 0) +
    theme_bw() + theme(axis.text.x=element_blank())
p
```

![](data:image/png;base64...)

```
new.signatures <- list(Mast.cell = c("TPSAB1","TPSB2","CPA3","MS4A2"),
                       Lymphoid = c("LCK"))

u.scores.3 <- ScoreSignatures_UCell(features=new.signatures,
                                    precalc.ranks = ranks)
melted <- reshape2::melt(u.scores.3)
colnames(melted) <- c("Cell","Signature","UCell_score")
p <- ggplot(melted, aes(x=Signature, y=UCell_score)) +
    geom_violin(aes(fill=Signature), scale = "width") +
    geom_boxplot(width=0.1, outlier.size=0) +
    theme_bw() + theme(axis.text.x=element_blank())
p
```

![](data:image/png;base64...)

# 7 Multi-core processing

If your machine has multi-core capabilities and enough RAM, running UCell in parallel can speed up considerably your analysis. The example below runs on a single core - you may modify this behavior by setting e.g. `workers=4` to parallelize to 4 cores:

```
BPPARAM <- BiocParallel::MulticoreParam(workers=1)
u.scores <- ScoreSignatures_UCell(exp.mat,features=signatures,
                                  BPPARAM=BPPARAM)
```

# 8 Interacting with SingleCellExperiment or Seurat

[SingleCellExperiment](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and [Seurat](https://github.com/satijalab/seurat) are popular environments for single-cell analysis. The UCell package implements functions to interact directly with these pipelines, as described in dedicated demos available on the [Bioc landing page](https://bioconductor.org/packages/release/bioc/html/UCell.html).

# 9 Resources

Please report any issues at the [UCell GitHub repository](https://github.com/carmonalab/UCell).

More demos available on the [Bioc landing page](https://bioconductor.org/packages/release/bioc/html/UCell.html) and at the [UCell demo repository](https://github.com/carmonalab/UCell_demo).

If you find UCell useful, you may also check out the [scGate package](https://github.com/carmonalab/scGate), which relies on UCell scores to automatically purify populations of interest based on gene signatures.

See also [SignatuR](https://github.com/carmonalab/SignatuR) for easy storing and retrieval of gene signatures.

# 10 References

# Appendix

* Andreatta, M., Carmona, S. J. (2021) *UCell: Robust and scalable single-cell gene signature scoring* Computational and Structural Biotechnology Journal
* Zilionis, R., Engblom, C., …, Klein, A. M. (2019) *Single-Cell Transcriptomics of Human and Mouse Lung Cancers Reveals Conserved Myeloid Populations across Individuals and Species* Immunity

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
##  [1] reshape2_1.4.4              scater_1.38.0
##  [3] scuttle_1.20.0              patchwork_1.3.2
##  [5] ggplot2_4.0.0               UCell_2.14.0
##  [7] Seurat_5.3.1                SeuratObject_5.2.0
##  [9] sp_2.2-0                    scRNAseq_2.23.1
## [11] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0               IRanges_2.44.0
## [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [19] generics_0.1.4              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] ProtGenerics_1.42.0      spatstat.sparse_3.1-0    bitops_1.0-9
##   [4] httr_1.4.7               RColorBrewer_1.1-3       tools_4.5.1
##   [7] sctransform_0.4.2        alabaster.base_1.10.0    R6_2.6.1
##  [10] HDF5Array_1.38.0         lazyeval_0.2.2           uwot_0.2.3
##  [13] rhdf5filters_1.22.0      withr_3.0.2              gridExtra_2.3
##  [16] progressr_0.17.0         cli_3.6.5                spatstat.explore_3.5-3
##  [19] fastDummies_1.7.5        alabaster.se_1.10.0      labeling_0.4.3
##  [22] sass_0.4.10              S7_0.2.0                 spatstat.data_3.1-9
##  [25] ggridges_0.5.7           pbapply_1.7-4            Rsamtools_2.26.0
##  [28] dichromat_2.0-0.1        parallelly_1.45.1        RSQLite_2.4.3
##  [31] BiocIO_1.20.0            ica_1.0-3                spatstat.random_3.4-2
##  [34] dplyr_1.1.4              Matrix_1.7-4             ggbeeswarm_0.7.2
##  [37] abind_1.4-8              lifecycle_1.0.4          yaml_2.3.10
##  [40] rhdf5_2.54.0             SparseArray_1.10.0       BiocFileCache_3.0.0
##  [43] Rtsne_0.17               grid_4.5.1               blob_1.2.4
##  [46] promises_1.4.0           ExperimentHub_3.0.0      crayon_1.5.3
##  [49] miniUI_0.1.2             lattice_0.22-7           beachmat_2.26.0
##  [52] cowplot_1.2.0            GenomicFeatures_1.62.0   cigarillo_1.0.0
##  [55] KEGGREST_1.50.0          magick_2.9.0             pillar_1.11.1
##  [58] knitr_1.50               rjson_0.2.23             future.apply_1.20.0
##  [61] codetools_0.2-20         glue_1.8.0               spatstat.univar_3.1-4
##  [64] data.table_1.17.8        vctrs_0.6.5              png_0.1-8
##  [67] gypsum_1.6.0             spam_2.11-1              gtable_0.3.6
##  [70] cachem_1.1.0             xfun_0.53                S4Arrays_1.10.0
##  [73] mime_0.13                survival_3.8-3           tinytex_0.57
##  [76] fitdistrplus_1.2-4       ROCR_1.0-11              nlme_3.1-168
##  [79] bit64_4.6.0-1            alabaster.ranges_1.10.0  filelock_1.0.3
##  [82] RcppAnnoy_0.0.22         GenomeInfoDb_1.46.0      bslib_0.9.0
##  [85] irlba_2.3.5.1            vipor_0.4.7              KernSmooth_2.23-26
##  [88] otel_0.2.0               DBI_1.2.3                ggrastr_1.0.2
##  [91] tidyselect_1.2.1         bit_4.6.0                compiler_4.5.1
##  [94] curl_7.0.0               httr2_1.2.1              BiocNeighbors_2.4.0
##  [97] h5mread_1.2.0            DelayedArray_0.36.0      plotly_4.11.0
## [100] bookdown_0.45            rtracklayer_1.70.0       scales_1.4.0
## [103] lmtest_0.9-40            rappdirs_0.3.3           stringr_1.5.2
## [106] digest_0.6.37            goftest_1.2-3            spatstat.utils_3.2-0
## [109] alabaster.matrix_1.10.0  rmarkdown_2.30           XVector_0.50.0
## [112] htmltools_0.5.8.1        pkgconfig_2.0.3          dbplyr_2.5.1
## [115] fastmap_1.2.0            ensembldb_2.34.0         rlang_1.1.6
## [118] htmlwidgets_1.6.4        UCSC.utils_1.6.0         shiny_1.11.1
## [121] farver_2.1.2             jquerylib_0.1.4          zoo_1.8-14
## [124] jsonlite_2.0.0           BiocParallel_1.44.0      BiocSingular_1.26.0
## [127] RCurl_1.98-1.17          magrittr_2.0.4           dotCall64_1.2
## [130] Rhdf5lib_1.32.0          Rcpp_1.1.0               viridis_0.6.5
## [133] reticulate_1.44.0        stringi_1.8.7            alabaster.schemas_1.10.0
## [136] MASS_7.3-65              AnnotationHub_4.0.0      plyr_1.8.9
## [139] parallel_4.5.1           listenv_0.9.1            ggrepel_0.9.6
## [142] deldir_2.0-4             Biostrings_2.78.0        splines_4.5.1
## [145] tensor_1.5.1             igraph_2.2.1             spatstat.geom_3.6-0
## [148] RcppHNSW_0.6.0           ScaledMatrix_1.18.0      BiocVersion_3.22.0
## [151] XML_3.99-0.19            evaluate_1.0.5           BiocManager_1.30.26
## [154] httpuv_1.6.16            RANN_2.6.2               tidyr_1.3.1
## [157] purrr_1.1.0              polyclip_1.10-7          future_1.67.0
## [160] scattermore_1.2          alabaster.sce_1.10.0     rsvd_1.0.5
## [163] xtable_1.8-4             restfulr_0.0.16          AnnotationFilter_1.34.0
## [166] RSpectra_0.16-2          later_1.4.4              viridisLite_0.4.2
## [169] tibble_3.3.0             memoise_2.0.1            beeswarm_0.4.0
## [172] AnnotationDbi_1.72.0     GenomicAlignments_1.46.0 cluster_2.1.8.1
## [175] globals_0.18.0
```