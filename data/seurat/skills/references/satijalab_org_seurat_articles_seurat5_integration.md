Toggle navigation

[Seurat](/seurat/)
5.5.0

* [Install](/seurat/articles/install_v5)
* [Get started](/seurat/articles/get_started_v5_new)
* Vignettes
  + Introductory vignettes
    - [Guided clustering tutorial (PBMC 3k)](/seurat/articles/pbmc3k_tutorial)
    - [Data visualization methods](/seurat/articles/visualization_vignette)
    - [Using sctransform in Seurat](/seurat/articles/sctransform_vignette)
    - [Using Seurat with multimodal data](/seurat/articles/multimodal_vignette)
    - [Essential commands](/seurat/articles/essential_commands)
  + Data integration
    - [Introduction to scRNA-seq integration](/seurat/articles/integration_introduction)
    - [Integrative analysis in Seurat v5](/seurat/articles/seurat5_integration)
    - [Mapping and annotating query datasets](/seurat/articles/integration_mapping)
  + Multi-assay data
    - [Dictionary learning for cross-modality integration](/seurat/articles/seurat5_integration_bridge)
    - [Weighted nearest neighbor analysis](/seurat/articles/weighted_nearest_neighbor_analysis)
    - [Integrating scRNA-seq and scATAC-seq data](/seurat/articles/seurat5_atacseq_integration_vignette)
    - [Multimodal reference mapping](/seurat/articles/multimodal_reference_mapping)
    - [Using mixscape in Seurat](/seurat/articles/mixscape_vignette)
  + Massively scalable analysis
    - [Sketch-based analysis in Seurat v5](/seurat/articles/seurat5_sketch_analysis)
    - [Sketch integration using a 1m cell dataset](/seurat/articles/parsebio_sketch_integration)
    - [Reference mapping analysis with 1.5m cells](/seurat/articles/covid_sctmapping)
    - [Using BPCells with Seurat objects](/seurat/articles/seurat5_bpcells_interaction_vignette)
  + Spatial analysis
    - [Analysis of spatial datasets (imaging-based)](/seurat/articles/seurat5_spatial_vignette_2)
    - [Analysis of spatial datasets (sequencing-based)](/seurat/articles/spatial_vignette)
    - [Analysis of Visium HD spatial datasets](/seurat/articles/visiumhd_analysis_vignette)
    - [Analysis of Visium HD with cell segmentations](/seurat/articles/visiumhd_analysis_cell_segmentations)
  + Other
    - [Cell-cycle scoring and regression](/seurat/articles/cell_cycle_vignette)
    - [Differential expression testing](/seurat/articles/de_vignette)
    - [Demultiplexing with hashtag oligos (HTOs)](/seurat/articles/hashing_vignette)
* [Extensions](/seurat/articles/extensions)
* [FAQ](https://github.com/satijalab/seurat/discussions)
* [News](/seurat/articles/announcements)
* [Reference](/seurat/reference/)
* [Archive](/seurat/articles/archive)

# Integrative analysis in Seurat v5

#### Compiled: May 22, 2026

Source: [`vignettes/seurat5_integration.Rmd`](https://github.com/satijalab/seurat/blob/HEAD/vignettes/seurat5_integration.Rmd)

`seurat5_integration.Rmd`

```
library(Seurat)
library(SeuratData)
library(SeuratWrappers)
library(Azimuth)
library(ggplot2)
library(patchwork)
options(future.globals.maxSize = 1e+10)
```

## Introduction

Integration of single-cell sequencing datasets, for example across
experimental batches, donors, or conditions, is often an important step
in scRNA-seq workflows. Integrative analysis can help to match shared
cell types and states across datasets, which can boost statistical
power, and most importantly, facilitate accurate comparative analysis
across datasets. In previous versions of Seurat we introduced methods
for integrative analysis, including our ‘anchor-based’ integration
workflow. Many labs have also published powerful and pioneering methods,
including [Harmony](https://github.com/immunogenomics/harmony) and [scVI](https://yoseflab.github.io/software/scvi-tools/), for
integrative analysis. We recognize that while the goal of matching
shared cell types across datasets may be important for many problems,
users may also be concerned about which method to use, or that
integration could result in a loss of biological resolution. In Seurat
v5, we introduce more flexible and streamlined infrastructure to run
different integration algorithms with a single line of code. This makes
it easier to explore the results of different integration methods, and
to compare these results to a workflow that excludes integration steps.
For this vignette, we use a [dataset of
human PBMC profiled with seven different technologies](https://www.nature.com/articles/s41587-020-0465-8), profiled as
part of a systematic comparative analysis (`pbmcsca`). The
data is available as part of our [SeuratData](https://github.com/satijalab/seurat-data)
package.

## Layers in the Seurat v5 object

Seurat v5 assays store data in layers. These layers can store raw,
un-normalized counts (`layer='counts'`), normalized data
(`layer='data'`), or z-scored/variance-stabilized data
(`layer='scale.data'`). We can load in the data, remove
low-quality cells, and obtain predicted cell annotations (which will be
useful for assessing integration later), using our [Azimuth
pipeline](https://satijalab.github.io/azimuth/articles/run_azimuth_tutorial.html).

```
# load in the pbmc systematic comparative analysis dataset
obj <- LoadData("pbmcsca")
obj <- subset(obj, nFeature_RNA > 1000)
obj <- RunAzimuth(obj, reference = "pbmcref")
# currently, the object has two layers in the RNA assay: counts, and data
obj
```

```
## An object of class Seurat
## 33789 features across 10434 samples within 4 assays
## Active assay: RNA (33694 features, 0 variable features)
##  2 layers present: counts, data
##  3 other assays present: prediction.score.celltype.l1, prediction.score.celltype.l2, prediction.score.celltype.l3
##  2 dimensional reductions calculated: integrated_dr, ref.umap
```

The object contains data from nine different batches (stored in the
`Method` column in the object metadata), representing seven
different technologies. We will aim to integrate the different batches
together. In previous versions of Seurat, we would require the data to
be represented as nine different Seurat objects. When using Seurat v5
assays, we can instead keep all the data in one object, but simply split
the layers. After splitting, there are now 18 layers (a
`counts` and `data` layer for each batch). We can
also run a standard scRNA-seq analysis (i.e. without integration). Note
that since the data is split into layers, normalization and variable
feature identification is performed for each batch independently (a
consensus set of variable features is automatically identified).

```
obj[["RNA"]] <- split(obj[["RNA"]], f = obj$Method)
obj
```

```
## An object of class Seurat
## 33789 features across 10434 samples within 4 assays
## Active assay: RNA (33694 features, 0 variable features)
##  18 layers present: counts.Smart-seq2, counts.CEL-Seq2, counts.10x_Chromium_v2_A, counts.10x_Chromium_v2_B, counts.10x_Chromium_v3, counts.Drop-seq, counts.Seq-Well, counts.inDrops, counts.10x_Chromium_v2, data.Smart-seq2, data.CEL-Seq2, data.10x_Chromium_v2_A, data.10x_Chromium_v2_B, data.10x_Chromium_v3, data.Drop-seq, data.Seq-Well, data.inDrops, data.10x_Chromium_v2
##  3 other assays present: prediction.score.celltype.l1, prediction.score.celltype.l2, prediction.score.celltype.l3
##  2 dimensional reductions calculated: integrated_dr, ref.umap
```

```
obj <- NormalizeData(obj)
obj <- FindVariableFeatures(obj)
obj <- ScaleData(obj)
obj <- RunPCA(obj)
```

We can now visualize the results of a standard analysis without
integration. Note that cells are grouping both by cell type and by
underlying method. While a UMAP analysis is just a visualization of
this, clustering this dataset would return predominantly batch-specific
clusters. Especially if previous cell-type annotations were not
available, this would make downstream analysis extremely
challenging.

```
obj <- FindNeighbors(obj, dims = 1:30, reduction = "pca")
obj <- FindClusters(obj, resolution = 2, cluster.name = "unintegrated_clusters")
```

```
## Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
##
## Number of nodes: 10434
## Number of edges: 412660
##
## Running Louvain algorithm...
## Maximum modularity in 10 random starts: 0.8981
## Number of communities: 48
## Elapsed time: 1 seconds
```

```
obj <- RunUMAP(obj, dims = 1:30, reduction = "pca", reduction.name = "umap.unintegrated")
# visualize by batch and cell type annotation cell type annotations were
# previously added by Azimuth
DimPlot(obj, reduction = "umap.unintegrated", group.by = c("Method", "predicted.celltype.l2"))
```

![](seurat5_integration_files/figure-html/unintegratedUMAP-1.png)

## Perform streamlined (one-line) integrative analysis

Seurat v5 enables streamlined integrative analysis using the
`IntegrateLayers` function. The method currently supports
five integration methods. Each of these methods performs integration in
low-dimensional space, and returns a dimensional reduction
(i.e. `integrated.rpca`) that aims to co-embed shared cell
types across batches:

* Anchor-based CCA integration
  (`method=CCAIntegration`)
* Anchor-based RPCA integration
  (`method=RPCAIntegration`)
* Harmony (`method=HarmonyIntegration`)
* FastMNN (`method= FastMNNIntegration`)
* scVI (`method=scVIIntegration`)

Note that our anchor-based RPCA integration represents a faster and
more conservative (less correction) method for integration. For
interested users, we discuss this method in more detail in our [previous
RPCA vignette](https://satijalab.org/seurat/articles/integration_rpca).

You can find more detail on each method, and any installation
prerequisites, in Seurat’s documentation (for example,
`[?scVIIntegration](https://rdrr.io/pkg/SeuratWrappers/man/scVIIntegration.html)`). For example, scVI integration requires
`reticulate` which can be installed from CRAN
(`install.packages("reticulate")`) as well as
`scvi-tools` and its dependencies installed in a conda
environment. Please see scVI installation instructions [here](https://docs.scvi-tools.org/en/stable/installation.html).

Each of the following lines perform a new integration using a single
line of code:

```
obj <- IntegrateLayers(object = obj, method = CCAIntegration, orig.reduction = "pca",
    new.reduction = "integrated.cca", verbose = FALSE)
```

```
obj <- IntegrateLayers(object = obj, method = RPCAIntegration, orig.reduction = "pca",
    new.reduction = "integrated.rpca", verbose = FALSE)
```

```
obj <- IntegrateLayers(object = obj, method = HarmonyIntegration, orig.reduction = "pca",
    new.reduction = "harmony", verbose = FALSE)
```

```
obj <- IntegrateLayers(object = obj, method = FastMNNIntegration, new.reduction = "integrated.mnn",
    verbose = FALSE)
```

```
obj <- IntegrateLayers(object = obj, method = scVIIntegration, new.reduction = "integrated.scvi",
    conda_env = "../miniconda3/envs/scvi-env", verbose = FALSE)
```

For any of the methods, we can now visualize and cluster the
datasets. We show this for CCA integration and scVI, but you can do this
for any method:

```
obj <- FindNeighbors(obj, reduction = "integrated.cca", dims = 1:30)
obj <- FindClusters(obj, resolution = 2, cluster.name = "cca_clusters")
```

```
## Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
##
## Number of nodes: 10434
## Number of edges: 615781
##
## Running Louvain algorithm...
## Maximum modularity in 10 random starts: 0.8048
## Number of communities: 26
## Elapsed time: 2 seconds
```

```
obj <- RunUMAP(obj, reduction = "integrated.cca", dims = 1:30, reduction.name = "umap.cca")
p1 <- DimPlot(obj, reduction = "umap.cca", group.by = c("Method", "predicted.celltype.l2",
    "cca_clusters"), combine = FALSE, label.size = 2)

obj <- FindNeighbors(obj, reduction = "integrated.scvi", dims = 1:30)
obj <- FindClusters(obj, resolution = 2, cluster.name = "scvi_clusters")
```

```
## Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
##
## Number of nodes: 10434
## Number of edges: 354664
##
## Running Louvain algorithm...
## Maximum modularity in 10 random starts: 0.7942
## Number of communities: 22
## Elapsed time: 1 seconds
```

```
obj <- RunUMAP(obj, reduction = "integrated.scvi", dims = 1:30, reduction.name = "umap.scvi")
p2 <- DimPlot(obj, reduction = "umap.scvi", group.by = c("Method", "predicted.celltype.l2",
    "scvi_clusters"), combine = FALSE, label.size = 2)

wrap_plots(c(p1, p2), ncol = 2, byrow = F)
```

![](seurat5_integration_files/figure-html/integratedprojections-1.png)

We hope that by simplifying the process of performing integrative
analysis, users can more carefully evaluate the biological information
retained in the integrated dataset. For example, users can compare the
expression of biological markers based on different clustering
solutions, or visualize one method’s clustering solution on different
UMAP visualizations.

```
p1 <- VlnPlot(obj, features = "rna_CD8A", group.by = "unintegrated_clusters") + NoLegend() +
    ggtitle("CD8A - Unintegrated Clusters")
p2 <- VlnPlot(obj, "rna_CD8A", group.by = "cca_clusters") + NoLegend() + ggtitle("CD8A - CCA Clusters")
p3 <- VlnPlot(obj, "rna_CD8A", group.by = "scvi_clusters") + NoLegend() + ggtitle("CD8A - scVI Clusters")
p1 | p2 | p3
```

![](seurat5_integration_files/figure-html/vlnplots-1.png)

```
obj <- RunUMAP(obj, reduction = "integrated.rpca", dims = 1:30, reduction.name = "umap.rpca")
p4 <- DimPlot(obj, reduction = "umap.unintegrated", group.by = c("cca_clusters"))
p5 <- DimPlot(obj, reduction = "umap.rpca", group.by = c("cca_clusters"))
p6 <- DimPlot(obj, reduction = "umap.scvi", group.by = c("cca_clusters"))
p4 | p5 | p6
```

![](seurat5_integration_files/figure-html/umaps-1.png)

Once integrative analysis is complete, you can rejoin the layers -
which collapses the individual datasets together and recreates the
original `counts` and `data` layers. You will need
to do this before performing any differential expression analysis.
However, you can always resplit the layers in case you would like to
reperform integrative analysis.

```
obj <- JoinLayers(obj)
obj
```

```
## An object of class Seurat
## 35789 features across 10434 samples within 5 assays
## Active assay: RNA (33694 features, 2000 variable features)
##  3 layers present: data, counts, scale.data
##  4 other assays present: prediction.score.celltype.l1, prediction.score.celltype.l2, prediction.score.celltype.l3, mnn.reconstructed
##  12 dimensional reductions calculated: integrated_dr, ref.umap, pca, umap.unintegrated, integrated.cca, integrated.rpca, harmony, integrated.mnn, integrated.scvi, umap.cca, umap.scvi, umap.rpca
```

Lastly, users can also perform integration using
sctransform-normalized data (see our [SCTransform
vignette](https://satijalab.org/seurat/articles/sctransform_vignette) for more information), by first running SCTransform
normalization, and then setting the `normalization.method`
argument in `IntegrateLayers`.

```
obj <- SCTransform(obj)
obj <- RunPCA(obj, npcs = 30, verbose = F)
obj <- IntegrateLayers(object = obj, method = RPCAIntegration, normalization.method = "SCT",
    verbose = F)
obj <- 