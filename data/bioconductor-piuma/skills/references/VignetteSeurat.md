# Topology-based Clustering in Seurat

Mattia Chiesa1,2\*, Laura Ballarini1,3, Alessia Gerbasi3, Giuseppe Albi3, Arianna Dagliati3, Luca Piacentini1 and Carlo Leonardi4

1Bioinformatics and Aritificial Intelligence facility, Centro Cardiologico Monzino, IRCCS, Milan, Italy
2Department of Electronics, Information and Biomedical Engineering, Politecnico di Milano, Milan, Italy
3Dipartimento di Ingegneria Industrale e dell Informazione, Universita' degli studi di Pavia, Pavia, Italy
4Wellcome Sanger Institute, Cambridge, UK

\*mattia.chiesa@cardiologicomonzino.it

#### 5 February 2026

#### Package

PIUMA 1.6.1

# 1 Introduction

This tutorial shows how to seamlessly integrate PIUMA
into the Seurat workflow for scRNA-seq, using datasets from SeuratData, finding
clusters cells with PIUMA and, then, performing downstream analyses again with Seurat.
The update has been inspired by this book (Colleen M. Farrelly [2023](#ref-2023shapeofdata)).

# 2 Installation

PIUMA can be installed by:

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("PIUMA")
```

# 3 Scope of this Vignette

In this vignette, we demonstrate how to integrate PIUMA’s TDA–based
geometry–informed clustering into a Seurat workflow for single‐cell RNA‐seq
data. Due to compilation time constrains of this vignette, we did not execute the chunks of this vignette, thus the user will not see the generated plots.

## 3.1 Seurat pbmc3k testing data

As a practical demo of PIUMA-Seurat integration, we’ll use the pbmc3k dataset.
The idea is simple: run your usual Seurat preprocessing, then hand the data to
PIUMA for TDA and process again with Seurat.
Below we fetch the data and perform the standard scRNA-seq steps
(QC, normalization, feature selection, scaling, and dimensional reduction)
before moving on to Mapper.

```
set.seed(42)
library(Seurat)
library(SingleCellExperiment)
library(SummarizedExperiment)
library(PIUMA)
#devtools::install_github('satijalab/seurat-data')
library(SeuratData)

SeuratData::InstallData("pbmc3k")
pbmc3k <- SeuratData::LoadData("pbmc3k")

pbmc3k <- UpdateSeuratObject(pbmc3k)
pbmc3k <- NormalizeData(pbmc3k)
pbmc3k <- ScaleData(pbmc3k)
pbmc3k <- FindVariableFeatures(pbmc3k)
pbmc3k <- RunPCA(pbmc3k)
pbmc3k <- RunUMAP(pbmc3k,dims = 1:20)
DimPlot(pbmc3k,group.by = 'seurat_annotations')
```

The cells are colored according to cell types. Let’s now convert the S4 Seurat
file into a SummarizedExperiment format, prior to converting it to TDAObj.

```
set.seed(42)
counts_mat <- pbmc3k@assays$RNA@layers$counts
logcounts_mat <- pbmc3k@assays$RNA@layers$data

colnames(counts_mat) <- rownames(pbmc3k@meta.data)
colnames(logcounts_mat) <- rownames(pbmc3k@meta.data)

rownames(counts_mat) <- rownames(pbmc3k@assays$RNA@features@.Data)
rownames(logcounts_mat) <- rownames(pbmc3k@assays$RNA@features@.Data)

counts_dense    <- as.matrix(counts_mat)
logcounts_dense <- as.matrix(logcounts_mat)
cell_meta     <- pbmc3k@meta.data

gene_meta     <- DataFrame(
  gene_id = rownames(counts_mat),
  row.names = rownames(counts_mat)
)

# assemble the SummarizedExperiment
se <- SummarizedExperiment(
  assays   = list(
    counts    = counts_dense,
    logcounts = logcounts_dense
  ),
  colData = cell_meta,
  rowData = gene_meta
)

#refine Seurat annotation
colData(se)$seurat_annotations <- factor(
  ifelse(
    is.na(colData(se)$seurat_annotations),
    "Unknown",
    as.character(colData(se)$seurat_annotations)
  )
)

# Create a PIUMA TDAobj from the SummarizedExperiment
tda_obj <- makeTDAobjFromSE(se,'seurat_annotations')
```

Now we can proceed to run the PIUMA TDA pipeline, using preprocessed dimensional
reductions of Seurat.

```
set.seed(42)
library(umap)
tda_obj <- dfToDistance(tda_obj, distMethod = "euclidean")
umap <- pbmc3k@reductions$umap@cell.embeddings
colnames(umap) <- c('comp1','comp2')

tda_obj@comp <- as.data.frame(umap)
```

Perfect! Now we have everything set up for our mapperCore() TDA call.

## 3.2 PIUMA TDA clustering

With our hyperparameters (nBins = 33, overlap = 0.15), we can now
proceed with the standard PIUMA workflow.

```
set.seed(42)
tda_obj <- mapperCore(x = tda_obj,
                      nBins = 33,
                      overlap = 0.15)
tda_obj <- jaccardMatrix(tda_obj)
tda_obj <- setGraph(tda_obj)
tda_obj <- predict_mapper_class(tda_obj)
tda_obj <- autoClusterMapper(tda_obj,method = 'walktrap')
```

Now we can go back to the Seurat object:

```
set.seed(42)
clusters_piuma <- tda_obj@clustering$obs_cluster
all_cells     <- rownames(pbmc3k@meta.data)
piuma_clusters <- setNames(
  rep(NA_integer_, length(all_cells)),
  all_cells
)
piuma_clusters[ clusters_piuma$obs ] <- clusters_piuma$cluster
pbmc3k@meta.data$PIUMA_clusters <- as.factor(piuma_clusters)

DimPlot(pbmc3k,group.by = 'PIUMA_clusters',label = TRUE,label.box = TRUE,repel = TRUE)+
  DimPlot(pbmc3k,group.by = 'seurat_annotations',label = TRUE,label.box = TRUE,repel = TRUE)
```

Here, we are showing the identified clusters from TDA compared to the original
annotations. Some clusters mostly overlap with Seurat clusters, such as the subdivision between
Naive CD4 T cells and Memory CD4 T cells, while other clusters, such as cluster
11 in PIUMA, do not have a clear corresponding sub-cluster.

## 3.3 Biological Validation: GZMK+ CD8+ T Subset

Let’s investigate what PIUMA has uncovered in this dataset:

```
set.seed(42)
library(dplyr)
library(ggplot2)

Idents(pbmc3k) <- 'PIUMA_clusters'
markers_12 <- FindMarkers(pbmc3k,
                         ident.1    = 12,
                         group.by   = "PIUMA_clusters",
                         test.use   = "wilcox",
                         logfc.threshold = 0.25,
                         only.pos=TRUE)
markers_12_top <- markers_12 %>% filter(pct.1 - pct.2 > 0.7)

FeaturePlot(pbmc3k,features=rownames(markers_12_top),alpha = 1)+ggplot2::ggtitle('Expression of Granzime K')
pbmc3k$GZMK_pos <- FetchData(pbmc3k, vars = "GZMK")[,1] > 2
pbmc3k$GZMK_pos <- factor(pbmc3k$GZMK_pos,
                          levels = c(FALSE, TRUE),
                          labels = c("GZMK–", "GZMK+"))
pbmc3k$Cluster_12 <- pbmc3k$PIUMA_clusters==12
pbmc3k_sub <- subset(pbmc3k, subset = !is.na(seurat_annotations))

VlnPlot(pbmc3k_sub,
        features = "GZMK",
        group.by = "seurat_annotations",
        split.by = "Cluster_12",
        pt.size  = 0,
        assay    = "RNA"
) +
  ggplot2::scale_fill_manual(
    name   = "PIUMA Cluster 12",
    values = c("FALSE" = "grey80", "TRUE" = "steelblue"),
    labels = c("Other cells", "Cluster 12")
  ) +
  ggplot2::guides(fill = ggplot2::guide_legend(override.aes = list(alpha = 1))) +
  ggplot2::theme(
    axis.text.x     = ggplot2::element_text(angle = 45, hjust = 1),
    legend.position = "right"
  ) +
  ggplot2::labs(
    title = "TDA Cluster 12 identifies a GZMK+ CD8+ T subset",
    x     = "Seurat annotation",
    y     = "GZMK expression"
  )
```

PIUMA cluster 12 selectively isolates a
GZMK+ T-cell sub-population. While standard annotation already captures
GZMK+ CD4+ T cells, PIUMA uniquely uncovers a discrete GZMK+ CD8+ T-cell
subset that the original clustering missed.

## 3.4 Quantitative Comparison

Having demonstrated PIUMA’s ability to pinpoint biologically meaningful cellular
subtypes, we now turn to a quantitative comparison with the standard annotation:

```
set.seed(42)
library(mclust)
library(aricode)
library(viridis)
valid   <- which(!is.na(pbmc3k$seurat_annotations) & !is.na(pbmc3k$PIUMA_clusters))
ari     <- mclust::adjustedRandIndex(pbmc3k$seurat_annotations[valid],
                             pbmc3k$PIUMA_clusters[valid])
nmi     <- aricode::NMI(pbmc3k$seurat_annotations[valid],
               pbmc3k$PIUMA_clusters[valid])
df <- data.frame(
  Metric = c("ARI","NMI"),
  Value  = c(ari, nmi)
)

ggplot2::ggplot(df, ggplot2::aes(x = Metric, y = 1, fill = Value)) +
  ggplot2::geom_tile(color = "white", width = 0.9, height = 0.9) +
  ggplot2::geom_text(aes(label = sprintf("%.3f", Value)),
            color = "white", size = 6) +
  viridis::scale_fill_viridis(option = "magma", limits = c(0, 1)) +
  coord_fixed(ratio = 1) +      # force squares
  ggplot2::theme_minimal() +
  ggplot2::theme(
    axis.title    = element_blank(),
    axis.text     = element_blank(),
    axis.ticks    = element_blank(),
    panel.grid    = element_blank(),
    plot.title    = element_text(hjust = 0.5)
  ) +
  ggplot2::labs(
    fill  = "Score",
    title = "Clustering Concordance (ARI & NMI)"
  )
```

We observe an ARI of 0.571 and an NMI of 0.68
between the original Seurat labels and the PIUMA TDA clusters. If PIUMA was
merely recapitulating the standard annotation, both metrics would approach 1.0.
Their lower values here instead reflect PIUMA’s reorganization of cells,
precisely the flexibility needed to reveal previously unrecognized cellular
subpopulations.

## 3.5 Conclusion

This vignette demonstrates that PIUMA achieves strong concordance with
Seurat’s standard annotations (ARI = 0.571, NMI = 0.68) while offering the
flexibility to discover novel cell‐state subpopulations, such as a GZMK+ CD8+
T‐cell cluster unseen by conventional methods.

# Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] dplyr_1.2.0      ggrepel_0.9.6    ggplot2_4.0.2    PIUMA_1.6.1
## [5] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            viridisLite_0.4.3
##  [3] farver_2.1.2                S7_0.2.1
##  [5] fastmap_1.2.0               digest_0.6.39
##  [7] rpart_4.1.24                lifecycle_1.0.5
##  [9] cluster_2.1.8.2             magrittr_2.0.4
## [11] kernlab_0.9-33              dbscan_1.2.4
## [13] compiler_4.5.2              rlang_1.1.7
## [15] Hmisc_5.2-5                 sass_0.4.10
## [17] tools_4.5.2                 igraph_2.2.1
## [19] yaml_2.3.12                 data.table_1.18.2.1
## [21] knitr_1.51                  htmlwidgets_1.6.4
## [23] askpass_1.2.1               S4Arrays_1.10.1
## [25] labeling_0.4.3              reticulate_1.44.1
## [27] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [29] abind_1.4-8                 withr_3.0.2
## [31] foreign_0.8-91              BiocGenerics_0.56.0
## [33] nnet_7.3-20                 grid_4.5.2
## [35] stats4_4.5.2                colorspace_2.1-2
## [37] scales_1.4.0                MASS_7.3-65
## [39] dichromat_2.0-0.1           tinytex_0.58
## [41] SummarizedExperiment_1.40.0 cli_3.6.5
## [43] rmarkdown_2.30              vegan_2.7-2
## [45] generics_0.1.4              umap_0.2.10.0
## [47] otel_0.2.0                  rstudioapi_0.18.0
## [49] RSpectra_0.16-2             cachem_1.1.0
## [51] stringr_1.6.0               splines_4.5.2
## [53] parallel_4.5.2              BiocManager_1.30.27
## [55] XVector_0.50.0              matrixStats_1.5.0
## [57] base64enc_0.1-6             vctrs_0.7.1
## [59] Matrix_1.7-4                jsonlite_2.0.0
## [61] bookdown_0.46               patchwork_1.3.2
## [63] IRanges_2.44.0              S4Vectors_0.48.0
## [65] htmlTable_2.4.3             Formula_1.2-5
## [67] magick_2.9.0                jquerylib_0.1.4
## [69] glue_1.8.0                  stringi_1.8.7
## [71] tsne_0.1-3.1                gtable_0.3.6
## [73] GenomicRanges_1.62.1        tibble_3.3.1
## [75] pillar_1.11.1               htmltools_0.5.9
## [77] Seqinfo_1.0.0               openssl_2.3.4
## [79] R6_2.6.1                    evaluate_1.0.5
## [81] lattice_0.22-7              Biobase_2.70.0
## [83] backports_1.5.0             png_0.1-8
## [85] bslib_0.10.0                Rcpp_1.1.1
## [87] checkmate_2.3.4             gridExtra_2.3
## [89] SparseArray_1.10.8          nlme_3.1-168
## [91] permute_0.9-8               mgcv_1.9-4
## [93] xfun_0.56                   MatrixGenerics_1.22.0
## [95] pkgconfig_2.0.3
```

# References

Colleen M. Farrelly, Yaé Ulrich Gaba. 2023. *The Shape of Data: Geometry-Based Machine Learning and Data Analysis in R*. No Starch Press.