Toggle navigation

[Seurat](/seurat/)
5.4.0

* [Install](/seurat/articles/install_v5)
* [Get started](/seurat/articles/get_started_v5_new)
* Vignettes
  + Introductory vignettes
    - [PBMC 3K guided tutorial](/seurat/articles/pbmc3k_tutorial)
    - [Data visualization vignette](/seurat/articles/visualization_vignette)
    - [SCTransform, v2 regularization](/seurat/articles/sctransform_vignette)
    - [Using Seurat with multi-modal data](/seurat/articles/multimodal_vignette)
    - [Seurat v5 Command Cheat Sheet](/seurat/articles/essential_commands)
  + Data integration
    - [Introduction to scRNA-seq integration](/seurat/articles/integration_introduction)
    - [Integrative analysis in Seurat v5](/seurat/articles/seurat5_integration)
    - [Mapping and annotating query datasets](/seurat/articles/integration_mapping)
  + Multi-assay data
    - [Dictionary Learning for cross-modality integration](/seurat/articles/seurat5_integration_bridge)
    - [Weighted Nearest Neighbor Analysis](/seurat/articles/weighted_nearest_neighbor_analysis)
    - [Integrating scRNA-seq and scATAC-seq data](/seurat/articles/seurat5_atacseq_integration_vignette)
    - [Multimodal reference mapping](/seurat/articles/multimodal_reference_mapping)
    - [Mixscape Vignette](/seurat/articles/mixscape_vignette)
  + Massively scalable analysis
    - [Sketch-based analysis in Seurat v5](/seurat/articles/seurat5_sketch_analysis)
    - [Sketch integration using a 1 million cell dataset from Parse Biosciences](/seurat/articles/parsebio_sketch_integration)
    - [Map COVID PBMC datasets to a healthy reference](/seurat/articles/covid_sctmapping)
    - [BPCells Interaction](/seurat/articles/seurat5_bpcells_interaction_vignette)
  + Spatial analysis
    - [Analysis of spatial datasets (Imaging-based)](/seurat/articles/seurat5_spatial_vignette_2)
    - [Analysis of spatial datasets (Sequencing-based)](/seurat/articles/spatial_vignette)
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

# Seurat - Guided Clustering Tutorial

#### Compiled: October 31, 2023

Source: [`vignettes/pbmc3k_tutorial.Rmd`](https://github.com/satijalab/seurat/blob/HEAD/vignettes/pbmc3k_tutorial.Rmd)

`pbmc3k_tutorial.Rmd`

## Setup the Seurat Object

For this tutorial, we will be analyzing the a dataset of Peripheral Blood Mononuclear Cells (PBMC) freely available from 10X Genomics. There are 2,700 single cells that were sequenced on the Illumina NextSeq 500. The raw data can be found [here](https://cf.10xgenomics.com/samples/cell/pbmc3k/pbmc3k_filtered_gene_bc_matrices.tar.gz).

We start by reading in the data. The `[Read10X()](/seurat/reference/read10x)` function reads in the output of the [cellranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger) pipeline from 10X, returning a unique molecular identified (UMI) count matrix. The values in this matrix represent the number of molecules for each feature (i.e. gene; row) that are detected in each cell (column). Note that more recent versions of cellranger now also output using the [h5 file format](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/advanced/h5_matrices), which can be read in using the `[Read10X_h5()](/seurat/reference/read10x_h5)` function in Seurat.

We next use the count matrix to create a `Seurat` object. The object serves as a container that contains both data (like the count matrix) and analysis (like PCA, or clustering results) for a single-cell dataset. For more information, check out our [Seurat object interaction vignette], or our [GitHub Wiki](https://github.com/satijalab/seurat/wiki). For example, in Seurat v5, the count matrix is stored in `pbmc[["RNA"]]$counts`.

```
library(dplyr)
library(Seurat)
library(patchwork)

# Load the PBMC dataset
pbmc.data <- Read10X(data.dir = "/brahms/mollag/practice/filtered_gene_bc_matrices/hg19/")
# Initialize the Seurat object with the raw (non-normalized data).
pbmc <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", min.cells = 3, min.features = 200)
pbmc
```

```
## An object of class Seurat
## 13714 features across 2700 samples within 1 assay
## Active assay: RNA (13714 features, 0 variable features)
##  1 layer present: counts
```

**What does data in a count matrix look like?**

```
# Lets examine a few genes in the first thirty cells
pbmc.data[c("CD3D", "TCL1A", "MS4A1"), 1:30]
```

```
## 3 x 30 sparse Matrix of class "dgCMatrix"
##
## CD3D  4 . 10 . . 1 2 3 1 . . 2 7 1 . . 1 3 . 2  3 . . . . . 3 4 1 5
## TCL1A . .  . . . . . . 1 . . . . . . . . . . .  . 1 . . . . . . . .
## MS4A1 . 6  . . . . . . 1 1 1 . . . . . . . . . 36 1 2 . . 2 . . . .
```

The `.` values in the matrix represent 0s (no molecules detected). Since most values in an scRNA-seq matrix are 0, Seurat uses a sparse-matrix representation whenever possible. This results in significant memory and speed savings for Drop-seq/inDrop/10x data.

```
dense.size <- object.size(as.matrix(pbmc.data))
dense.size
```

```
## 709591472 bytes
```

```
sparse.size <- object.size(pbmc.data)
sparse.size
```

```
## 29905192 bytes
```

```
dense.size/sparse.size
```

```
## 23.7 bytes
```

## Standard pre-processing workflow

The steps below encompass the standard pre-processing workflow for scRNA-seq data in Seurat. These represent the selection and filtration of cells based on QC metrics, data normalization and scaling, and the detection of highly variable features.

### QC and selecting cells for further analysis

Seurat allows you to easily explore QC metrics and filter cells based on any user-defined criteria. A few QC metrics [commonly used](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4758103/) by the community include

* The number of unique genes detected in each cell.
  + Low-quality cells or empty droplets will often have very few genes
  + Cell doublets or multiplets may exhibit an aberrantly high gene count
* Similarly, the total number of molecules detected within a cell (correlates strongly with unique genes)
* The percentage of reads that map to the mitochondrial genome
  + Low-quality / dying cells often exhibit extensive mitochondrial contamination
  + We calculate mitochondrial QC metrics with the `[PercentageFeatureSet()](/seurat/reference/percentagefeatureset)` function, which calculates the percentage of counts originating from a set of features
  + We use the set of all genes starting with `MT-` as a set of mitochondrial genes

```
# The [[ operator can add columns to object metadata. This is a great place to stash QC stats
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
```

**Where are QC metrics stored in Seurat?**

* The number of unique genes and total molecules are automatically calculated during `[CreateSeuratObject()](https://satijalab.github.io/seurat-object/reference/CreateSeuratObject.html)`
  + You can find them stored in the object meta data

```
# Show QC metrics for the first 5 cells
head(pbmc@meta.data, 5)
```

```
##                  orig.ident nCount_RNA nFeature_RNA percent.mt
## AAACATACAACCAC-1     pbmc3k       2419          779  3.0177759
## AAACATTGAGCTAC-1     pbmc3k       4903         1352  3.7935958
## AAACATTGATCAGC-1     pbmc3k       3147         1129  0.8897363
## AAACCGTGCTTCCG-1     pbmc3k       2639          960  1.7430845
## AAACCGTGTATGCG-1     pbmc3k        980          521  1.2244898
```

In the example below, we visualize QC metrics, and use these to filter cells.

* We filter cells that have unique feature counts over 2,500 or less than 200
* We filter cells that have >5% mitochondrial counts

```
# Visualize QC metrics as a violin plot
VlnPlot(pbmc, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
```

![](pbmc3k_tutorial_files/figure-html/qc2-1.png)

```
# FeatureScatter is typically used to visualize feature-feature relationships, but can be used
# for anything calculated by the object, i.e. columns in object metadata, PC scores etc.

plot1 <- FeatureScatter(pbmc, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(pbmc, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot1 + plot2
```

![](pbmc3k_tutorial_files/figure-html/qc2-2.png)

```
pbmc <- subset(pbmc, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
```

---

## Normalizing the data

After removing unwanted cells from the dataset, the next step is to normalize the data. By default, we employ a global-scaling normalization method “LogNormalize” that normalizes the feature expression measurements for each cell by the total expression, multiplies this by a scale factor (10,000 by default), and log-transforms the result. In Seurat v5, Normalized values are stored in `pbmc[["RNA"]]$data`.

```
pbmc <- NormalizeData(pbmc, normalization.method = "LogNormalize", scale.factor = 10000)
```

For clarity, in this previous line of code (and in future commands), we provide the default values for certain parameters in the function call. However, this isn’t required and the same behavior can be achieved with:

```
pbmc <- NormalizeData(pbmc)
```

While this method of normalization is standard and widely used in scRNA-seq analysis, global-scaling relies on an assumption that each cell originally contains the same number of RNA molecules. We and others have developed alternative workflows for the single cell preprocessing that do not make these assumptions. For users who are interested, please check out our `[SCTransform()](/seurat/reference/sctransform)` normalization workflow. The method is described in our[paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02584-9), with a separate vignette using Seurat [here](https://satijalab.org/seurat/articles/sctransform_vignette). The use of `SCTransform` replaces the need to run `NormalizeData`, `FindVariableFeatures`, or `ScaleData` (described below.)

## Identification of highly variable features (feature selection)

We next calculate a subset of features that exhibit high cell-to-cell variation in the dataset (i.e, they are highly expressed in some cells, and lowly expressed in others). We and [others](https://www.nature.com/articles/nmeth.2645) have found that focusing on these genes in downstream analysis helps to highlight biological signal in single-cell datasets.

Our procedure in Seurat is described in detail [here](https://doi.org/10.1016/j.cell.2019.05.031), and improves on previous versions by directly modeling the mean-variance relationship inherent in single-cell data, and is implemented in the `[FindVariableFeatures()](/seurat/reference/findvariablefeatures)` function. By default, we return 2,000 features per dataset. These will be used in downstream analysis, like PCA.

```
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)

# Identify the 10 most highly variable genes
top10 <- head(VariableFeatures(pbmc), 10)

# plot variable features with and without labels
plot1 <- VariableFeaturePlot(pbmc)
plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
plot1 + plot2
```

![](pbmc3k_tutorial_files/figure-html/var_features-1.png)

---

## Scaling the data

Next, we apply a linear transformation (‘scaling’) that is a standard pre-processing step prior to dimensional reduction techniques like PCA. The `[ScaleData()](/seurat/reference/scaledata)` function:

* Shifts the expression of each gene, so that the mean expression across cells is 0
* Scales the expression of each gene, so that the variance across cells is 1
  + This step gives equal weight in downstream analyses, so that highly-expressed genes do not dominate
* The results of this are stored in `pbmc[["RNA"]]$scale.data`
* By default, only variable features are scaled.
* You can specify the `features` argument to scale additional features

```
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
```

**How can I remove unwanted sources of variation**

In Seurat, we also use the `[ScaleData()](/seurat/reference/scaledata)` function to remove unwanted sources of variation from a single-cell dataset. For example, we could ‘regress out’ heterogeneity associated with (for example) [cell cycle stage](https://satijalab.org/seurat/articles/cell_cycle_vignette), or mitochondrial contamination i.e.:

```
pbmc <- ScaleData(pbmc, vars.to.regress = "percent.mt")
```

However, particularly for advanced users who would like to use this functionality, we strongly recommend the use of our new normalization workflow, `[SCTransform()](/seurat/reference/sctransform)`. The method is described in our [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02584-9), with a separate vignette using Seurat [here](https://satijalab.org/seurat/articles/sctransform_vignette). As with `[ScaleData()](/seurat/reference/scaledata)`, the function `[SCTransform()](/seurat/reference/sctransform)` also includes a `vars.to.regress` parameter.

---

## Perform linear dimensional reduction

Next we perform PCA on the scaled data. By default, only the previously determined variable features are used as input, but can be defined using `features` argument if you wish to choose a different subset (if you do want to use a custom subset of features, make sure you pass these to `ScaleData` first).

For the first principal components, Seurat outputs a list of genes with the most positive and negative loadings, representing modules of genes that exhibit either correlation (or anti-correlation) across single-cells in the dataset.

```
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
```

Seurat provides several useful ways of visualizing both cells and features that define the PCA, including `VizDimReduction()`, `[DimPlot()](/seurat/reference/dimplot)`, and `[DimHeatmap()](/seurat/reference/dimheatmap)`

```
# Examine and visualize PCA results a few different ways
print(pbmc[["pca"]], dims = 1:5, nfeatures = 5)
```

```
## PC_ 1
## Positive:  CST3, TYROBP, LST1, AIF1, FTL
## Negative:  MALAT1, LTB, IL32, IL7R, CD2
## PC_ 2
## Positive:  CD79A, MS4A1, TCL1A, HLA-DQA1, HLA-DQB1
## Negative:  NKG7, PRF1, CST7, GZMB, GZMA
## PC_ 3
## Positive:  HLA-DQA1, CD79A, CD79B, HLA-DQB1, HLA-DPB1
## Negative:  PPBP, PF4, SDPR, SPARC, GNG11
## PC_ 4
## Positive:  HLA-DQA1, CD79B, CD79A, MS4A1, HLA-DQB1
## Negative:  VIM, IL7R, S100A6, IL32, S100A8
## PC_ 5
## Positiv