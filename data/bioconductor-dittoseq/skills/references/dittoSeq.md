# Using dittoSeq to visualize (sc)RNAseq data

Daniel Bunis1\*

1Bakar Computational Health Sciences Institute, University of California San Francisco, San

\*daniel.bunis@ucsf.edu

#### May 25th, 2021

#### Package

dittoSeq 1.22.0

# 1 Introduction

dittoSeq is a tool built to enable analysis and visualization of single-cell
and bulk RNA-sequencing data by novice, experienced, and color-blind coders.
Thus, it provides many useful visualizations, which all utilize red-green
color-blindness optimized colors by default, and which allow sufficient
customization, via discrete inputs, for out-of-the-box creation of
publication-ready figures.

For single-cell data, dittoSeq works directly with data pre-processed in other
popular packages (Seurat, scater, scran, …). For bulk RNAseq data,
dittoSeq’s import functions will convert bulk RNAseq data of various different
structures into a set structure that dittoSeq helper and visualization
functions can work with. So ultimately, dittoSeq includes universal plotting
and helper functions for working with (sc)RNAseq data processed and stored in
these formats:

Single-Cell:

* SingleCellExperiment
* Seurat (v2 onwards)

Bulk:

* SummarizedExperiment (the general Bioconductor Seq-data storage system)
* DESeqDataSet (DESeq2 package output)
* DGEList (edgeR package output)

For bulk data, or if your data is currently not analyzed, or simply not in one
of these structures, you can still pull it in to the SingleCellExperiment
structure that dittoSeq works with using the `importDittoBulk` function.

## 1.1 Color-blindness friendliness:

The default colors of this package are red-green color-blindness friendly. To
make it so, I used the suggested colors from (Wong [2011](#ref-wong_points_2011)) and adapted
them slightly by appending darker and lighter versions to create a 24 color
vector. All plotting functions use these colors, stored in `dittoColors()`, by
default.

Additionally:

* Shapes displayed in the legends are generally enlarged as this can be almost
  as helpful as the actual color choice for colorblind individuals.
* When sensible, dittoSeq functions have a shape.by input for having groups
  displayed through shapes rather than color. (But note: even as a red-green
  color impaired individual myself writing this vignette, I recommend using color
  and I generally only use shapes for showing additional groupings.)
* dittoDimPlots can be generated with letters overlaid (set do.letter = TRUE)
* The `Simulate` function allows a cone-typical individual to see what their
  dittoSeq plots might look like to a colorblind individual.

## 1.2 Disclaimer

Code used here for dataset processing and normalization should not be seen as
a suggestion of the proper methods for performing such steps. dittoSeq is a
visualization tool, and my focus while developing this vignette has been simply
creating values required for providing “pretty-enough” visualization examples.

# 2 Installation

dittoSeq is available through Bioconductor.

```
# Install BiocManager if needed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Install dittoSeq
BiocManager::install("dittoSeq")
```

# 3 Quick-Reference: Seurat<=>dittoSeq

As of May 25th, 2021, Seurat-v4.0.2 & dittoSeq v1.4.1

Because often users will be familiar with Seurat already, so this may be 90% of
what you may need!

## 3.1 Functions

| Seurat Viz Function(s) | dittoSeq Equivalent(s) |
| --- | --- |
| DimPlot/ (I)FeaturePlot / UMAPPlot / etc. | dittoDimPlot / multi\_dittoDimPlot |
| VlnPlot / RidgePlot | dittoPlot / multi\_dittoPlot |
| DotPlot | dittoDotPlot |
| FeatureScatter / GenePlot | dittoScatterPlot |
| DoHeatmap | dittoHeatmap\* |
| [No Seurat Equivalent] | dittoBarPlot / dittoFreqPlot |
| [No Seurat Equivalent] | dittoDimHex / dittoScatterHex |
| [No Seurat Equivalent] | dittoPlotVarsAcrossGroups |
| SpatialDimPlot, SpatialFeaturePlot, etc. | dittoSpatial (coming soon!) |

\*Not all dittoSeq features exist in Seurat counterparts, and occasionally the
same is true in the reverse.

## 3.2 Inputs

See reference below for the equivalent names of major inputs

Seurat has had inconsistency in input names from version to version. dittoSeq
drew some of its parameter names from previous Seurat-equivalents to ease
cross-conversion, but continuing to blindly copy their parameter standards will
break people’s already existing code. Instead, dittoSeq input names are
guaranteed to remain consistent across versions, unless a change is required for
useful feature additions.

| Seurat Viz Input(s) | dittoSeq Equivalent(s) |
| --- | --- |
| `object` | SAME |
| `features` | `var` / `vars` (generally the 2nd input, so name not needed!) OR `genes` & `metas` for dittoHeatmap() |
| `cells` (cell subsetting is not always available) | `cells.use` (consistently available) |
| `reduction` & `dims` | `reduction.use` & `dim.1`, `dim.2` |
| `pt.size` | `size` (or `jitter.size`) |
| `group.by` | SAME |
| `split.by` | SAME |
| `shape.by` | SAME and also available in dittoPlot() |
| `fill.by` | `color.by` (can be used to subset `group.by` further!) |
| `assay` / `slot` | SAME |
| `order` = logical | `order` but = “unordered” (default), “increasing”, or “decreasing” |
| `cols` | `color.panel` for discrete OR `min.color`, `max.color` for continuous |
| `label` & `label.size` & `repel` | `do.label` & `labels.size` & `labels.repel` |
| `interactive` | `do.hover` = via plotly conversion |
| [Not in Seurat] | `data.out`, `do.raster`, `do.letter`, `do.ellipse`, `add.trajectory.lineages` and others! |

# 4 Setup: Some simple preprocessing

For examples, we will use a pancreatic
Baron et al. ([2016](#ref-baron_single-cell_2016)) is not normalized nor dimensionality reduced upon

```
## Download Data
library(scRNAseq)
sce <- BaronPancreasData()
# Trim to only 5 of the cell types for simplicity of vignette
sce <- sce[,sce$label %in% c(
    "acinar", "beta", "gamma", "delta", "ductal")]
```

Now that we have a single-cell dataset loaded, we are ready to go. All
functions work for either Seurat or SCE encapsulated single-cell data.

But to make full use of dittoSeq, we should really have this data
log-normalized, and we should run dimensionality reduction and clustering.

```
## Some Quick Pre-processing
# Normalization.
library(scater)
sce <- logNormCounts(sce)

# Feature selection.
library(scran)
dec <- modelGeneVar(sce)
hvg <- getTopHVGs(dec, prop=0.1)

# PCA & UMAP
library(scater)
set.seed(1234)
sce <- runPCA(sce, ncomponents=25, subset_row=hvg)
sce <- runUMAP(sce, pca = 10)

# Clustering.
library(bluster)
sce$cluster <- clusterCells(sce, use.dimred='PCA',
    BLUSPARAM=NNGraphParam(cluster.fun="louvain"))

# Add some metadata common to Seurat objects
sce$nCount_RNA <- colSums(counts(sce))
sce$nFeature_RNA <- colSums(counts(sce)>0)
sce$percent.mito <- colSums(counts(sce)[grep("^MT-", rownames(sce)),])/sce$nCount_RNA

sce
```

```
## class: SingleCellExperiment
## dim: 20125 5416
## metadata(0):
## assays(2): counts logcounts
## rownames(20125): A1BG A1CF ... ZZZ3 pk
## rowData names(0):
## colnames(5416): human1_lib1.final_cell_0001 human1_lib1.final_cell_0002
##   ... human4_lib3.final_cell_0700 human4_lib3.final_cell_0701
## colData names(7): donor label ... nFeature_RNA percent.mito
## reducedDimNames(2): PCA UMAP
## mainExpName: NULL
## altExpNames(0):
```

Now we have a single-cell dataset loaded and analyzed as an SCE, but note:
**All functions will work the same for single-cell data stored as either**
**Seurat or SCE.**

# 5 Getting started

## 5.1 Single-cell RNAseq data

dittoSeq works natively with Seurat and SingleCellExperiment objects. Nothing
special is needed. Just load in your data if it isn’t already loaded, then go!

```
library(dittoSeq)
dittoDimPlot(sce, "donor")
```

![](data:image/jpeg;base64...)

```
dittoPlot(sce, "ENO1", group.by = "label")
```

![](data:image/jpeg;base64...)

```
dittoBarPlot(sce, "label", group.by = "donor")
```

![](data:image/jpeg;base64...)

## 5.2 Bulk RNAseq data

```
# First, we'll just make some mock expression and conditions data
exp <- matrix(rpois(20000, 5), ncol=20)
colnames(exp) <- paste0("donor", seq_len(ncol(exp)))
rownames(exp) <- paste0("gene", seq_len(nrow(exp)))
logexp <- logexp <- log2(exp + 1)

pca <- matrix(rnorm(20000), nrow=20)

conditions <- factor(rep(1:4, 5))
sex <- c(rep("M", 9), rep("F", 11))
```

dittoSeq works natively with bulk RNAseq data stored as a SummarizedExperiment
object, and this includes data analyzed with DESeq2.

```
library(SummarizedExperiment)
bulkSE <- SummarizedExperiment(
    assays = list(counts = exp,
             logcounts = logexp),
    colData = data.frame(conditions = conditions,
                          sex = sex)
)
```

Alternatively, or for bulk data stored in other forms, such as a DGEList or as
raw matrices, one can use the `importDittoBulk()` function to convert it into
the SingleCellExperiment structure.

Some brief details on this structure: The SingleCellEExperiment class is very
similar to the base SummarizedExperiment class, but with room added for storing
pre-calculated dimensionality reductions.

```
# dittoSeq import which allows
bulkSCE <- importDittoBulk(
    # x can be a DGEList, a DESeqDataSet, a SummarizedExperiment,
    #   or a list of data matrices
    x = list(counts = exp,
             logcounts = logexp),
    # Optional inputs:
    #   For adding metadata
    metadata = data.frame(conditions = conditions,
                          sex = sex),
    #   For adding dimensionality reductions
    reductions = list(pca = pca)
    )
```

Metadata and dimensionality reductions can be added either directly within the
`importDittoBulk()` function via the `metadata` and `reductions` inputs,
as above, or separately afterwards:

```
# Add metadata (metadata can alternatively be added in this way)
bulkSCE$conditions <- conditions
bulkSCE$sex <- sex

# Add dimensionality reductions (can alternatively be added this way)
bulkSCE <- addDimReduction(
    object = bulkSCE,
    # (We aren't actually calculating PCA here.)
    embeddings = pca,
    name = "pca",
    key = "PC")
```

Making plots for bulk data then operates similarly as for single-cell except
for one slight caveat for SummarizedExperiment objects

```
library(dittoSeq)
dittoDimPlot(bulkSCE, "sex", size = 3, do.ellipse = TRUE)
```

![](data:image/jpeg;base64...)

```
dittoBarPlot(bulkSCE, "sex", group.by = "conditions")
```

![](data:image/jpeg;base64...)

```
dittoBoxPlot(bulkSCE, "gene1", group.by = "sex")
```

![](data:image/jpeg;base64...)

```
dittoHeatmap(bulkSCE, getGenes(bulkSCE)[1:10],
    annot.by = c("conditions", "sex"))
```

![](data:image/jpeg;base64...)

For making dittoDimPlots (and dittoHexPlots) with SummarizedExperiment objects,
the dimensionality reduction of interest must be supplied to

```
# SummarizedExperiment dim-plots:
dittoDimPlot(
    bulkSE,"sex", size = 3, do.ellipse = TRUE,
    reduction.use = pca
    )
```

#### 5.2.0.1 Additional details on bulk data import:

By default, sample-associated data from original objects are retained. But
metadata provided to the `metadata` input will replace any similarly named
slots from the original object. The `combine_metadata` input can additionally
be used to turn retention of previous metadata slots off.

DGEList note: The import function attempts to pull in all information stored in
common DGEList slots ($counts, $samples, $genes, $AveLogCPM,
$common.dispersion, $trended.dispersion, $tagwise.dispersion, and $offset),
but any other slots are ignored.

When providing `x` a list of a single or multiple matrices, it is recommended
that matrices containing raw feature counts data be named `counts`,
log-normalized counts data be named `logcounts`, and otherwise normalized data,
be named `normcounts`. Then you can give the `assay` input of dittoSeq
functions “counts” to point towards the raw data for example. This is not a
requirement, but the default assay used in dittoSeq functions will be one of:
1) “logcounts” if it exists, 2) “normcounts” if it exists, 3) “counts” if it
exists, or 4) whatever the first assay is in the object.

The SCE object created by `importDittoBulk()` will contain an internal metadata
slot which tells dittoSeq that the object holds bulk data. Knowledge of whether
a dataset is single-cell versus bulk is used to aadjust parameter defaults for
in few functions; “samples” vs “cells” in the y-axis label of `dittoBarPlot()`,
and whether cells (no) versus samples (yes) should be clustered by default for
`dittoHeatmap()`.

# 6 Helper Functions

dittoSeq’s helper functions make it easy to determine the metadata, gene, and
dimensionality reduction options for plotting.

## 6.1 Metadata

```
# Retrieve all metadata slot names
getMetas(sce)
```

```
## [1] "donor"        "label"        "sizeFactor"   "cluster"      "nCount_RNA"
## [6] "nFeature_RNA" "percent.mito"
```

```
# Query for the presence of a metadata slot
isMeta("nCount_RNA", sce)
```

```
## [1] TRUE
```

```
# Retrieve metadata values:
meta("label", sce)[1:10]
```

```
## human1_lib1.final_cell_0001 human1_lib1.final_cell_0002
##                    "acinar"                    "acinar"
## human1_lib1.final_cell_0003 human1_lib1.final_cell_0004
##                    "acinar"                    "acinar"
## human1_lib1.final_cell_0005 human1_lib1.final_cell_0006
##                    "acinar"                    "acinar"
## human1_lib1.final_cell_0007 human1_lib1.final_cell_0008
##                      "beta"                    "acinar"
## human1_lib1.final_cell_0009 human1_lib1.final_cell_0010
##                    "acinar"                    "acinar"
```

```
# Retrieve unique values of a metadata
metaLevels("label", sce)
```

```
## [1] "acinar" "beta"   "delta"  "ductal" "gamma"
```

## 6.2 Genes/Features

```
# Retrieve all gene names
getGenes(sce)[1:10]
```

```
##  [1] "A1BG"   "A1CF"   "A2M"    "A2ML1"  "A4GALT" "A4GNT"  "AA06"   "AAAS"
##  [9] "AACS"   "AACSP1"
```

```
# Query for the presence of a gene(s)
isGene("CD3E", sce)
```

```
## [1] TRUE
```

```
isGene(c("CD3E","ENO1","INS","non-gene"), sce, return.values = TRUE)
```

```
## [1] "CD3E" "ENO1" "INS"
```

```
# Retrieve gene expression values:
gene("ENO1", sce)[1:10]
```

```
## human1_lib1.final_cell_0001 human1_lib1.final_cell_0002
##                    2.168578                    2.013074
## human1_lib1.final_cell_0003 human1_lib1.final_cell_0004
##                    1.551996                    1.234598
## human1_lib1.final_cell_0005 human1_lib1.final_cell_0006
##                    3.064644                    1.802279
## human1_lib1.final_cell_0007 human1_lib1.final_cell_0008
##                    2.301963                    1.066135
## human1_lib1.final_cell_0009 human1_lib1.final_cell_0010
##                    2.398596                    1.450935
```

## 6.3 Reductions

```
# Retrieve all dimensionality reductions
getReductions(sce)
```

```
## [1] "PCA"  "UMAP"
```

These are what can be provided to `reduction.use` for `dittoDimPlot()`.

## 6.4 Characteristic: Bulk versus single-cell

Because dittoSeq utilizes the SingleCellExperiment structure to handle some
bulk RNAseq data, there is a getter and setter for the internal metadata which
tells dittoSeq functions which resolution of data a target SCE holds.

```
# Getter
isBulk(sce)
```

```
## [1] FALSE
```

```
isBulk(bulkSCE)
```

```
## [1] TRUE
```

```
# Setter
mock_bulk <- setBulk(sce) # to bulk
isBulk(sce)
```

```
## [1] FALSE
```

```
mock_sc <- setBulk(bulkSCE, set = FALSE) # to single-cell
isBulk(bulkSCE)
```

```
## [1] TRUE
```

# 7 Visualizations

There are many different types of dittoSeq visualizations. Each has intuitive
defaults which allow creation of immediately usable plots. Each also has many
additional tweaks available through discrete inputs that can help ensure you
can create precisely-tuned, deliberately-labeled, publication-quality plots
out-of-the-box.

## 7.1 dittoDimPlot & dittoScatterPlot

These show cells/samples data overlaid on a scatter plot, with the axes of
`dittoScatterPlot()` being gene expression or metadata data and with the axes
of `dittoDimPlot()` being dimensionality reductions like tsne, pca, umap or
similar.

```
dittoDimPlot(sce, "label", reduction.use = "PCA")
```

![](data:image/jpeg;base64...)

```
dittoDimPlot(sce, "ENO1")
```

![](data:image/jpeg;base64...)

```
dittoScatterPlot(
    object = sce,
    x.var = "PPY", y.var = "INS",
    color.var = "label")
```

![](data:image/jpeg;base64...)

```
dittoScatterPlot(
    object = sce,
    x.var = "nCount_RNA", y.var = "nFeature_RNA",
    color.var = "percent.mito")
```

![](data:image/jpeg;base64...)

### 7.1.1 Additional features

Various additional features can be overlaid on top of these plots.
Adding each is controlled by an input that starts with `add.` or `do.` such as:

* `do.label`
* `do.ellipse`
* `do.letter`
* `do.contour`
* `do.hover`
* `add.trajectory.lineages`
* `add.trajectory.curves`

Additional inputs that apply to and adjust these features will then start with
the XXXX part that comes after `add.XXXX` or `do.XXXX`, as exemplified below.
(Tab-completion friendly!)

A few examples:

```
dittoDimPlot(sce, "cluster",

             do.label = TRUE,
             labels.repel = FALSE,

             add.trajectory.lineages = list(
                 c("9","3"),
                 c("8","7","2","4"),
                 c("8","7","1"),
                 c("5","11","6"),
                 c("10","0")),
             trajectory.cluster.meta = "cluster")
```

![](data:image/jpeg;base64...)

## 7.2 dittoDimHex & dittoScatterHex

Similar to the “Plot” versions, these show cells/samples data overlaid on a
scatter plot, with the axes of `dittoScatterHex()` being gene expression or
metadata or some other data, and with the axes of `dittoDimHex()` being
dimensionality reductions like tsne, pca, umap or similar.

The plot area is then broken into hexagonal bins and data is presented as
summaries of cells/samples within each of those bins.

The minimal functions will summarize density of cells/samples only using color.

```
dittoDimHex(sce)
```

![](data:image/jpeg;base64...)

```
dittoScatterHex(sce,
    x.var = "PPY", y.var = "INS")
```

![](data:image/jpeg;base64...)

An additional feature can be provided to have that data be summarized in
addition to density. Density will then be represented with opacity, while color
is used for the additional feature. The `color.method` input then controls how
data within the bins are represented.

NOTE: It is important to note that as soon as differing opacity is added, the
color-blindness friendliness of dittoSeq’s default colors is no longer
guaranteed.

```
dittoDimHex(sce, "INS")
```

![](data:image/jpeg;base64...)

```
dittoScatterHex(
    object = sce,
    x.var = "PPY", y.var = "INS",
    color.var = "label",
    colors = c(1:4,7), max.density = 15)
```

![](data:image/jpeg;base64...)

### 7.2.1 Summary function control

`color.method` controls how data within the bins are represented in colors. It
is provided a string, but how that string is utilized depends on the type of
target data.

For discrete data, you can provide either `"max"` (the default) to display the
predominant grouping of the bins, or `"max.prop"` to display the proportion of
cells in the bins that belong to the maximal grouping.

For continuous data, any string signifying a function [that summarizes a
numeric vector input into with a single numeric value] can be provided.
The default is `"median"`, but other useful options are `"sum"`, `"mean"`,
`"sd"`, or `"mad"`.

### 7.2.2 Additional features

Similar to dittoDimPlot and dittoScatterPlot, various additional layers are
built in and their addition is controlled by inputs that starts with `add.` or
`do.` such as:

* `do.label`
* `do.ellipse`
* `do.contour`
* `add.trajectory.lineages`
* `add.trajectory.curves`

Additional inputs that apply to and adjust these features will then start with
the XXXX part that comes after `add.XXXX` or `do.XXXX`, as exemplified below.
(Tab-completion friendly!)

## 7.3 dittoPlot (and dittoRidgePlot + dittoBoxPlot wrappers)

These display *continuous* cells/samples’ data on a y-axis (or x-axis for
ridgeplots) grouped on the x-axis by sample, age, condition, or any discrete
grouping metadata. Data can be represented with violin plots, box plots,
individual points for each cell/sample, and/or ridge plots. The `plots` input
controls which data representations are used. The `group.by` input controls
how the data are grouped in the x-axis. And the `color.by` input controls the
colors that fill in violin, box, and ridge plots.

`dittoPlot()` is the main function, but `dittoRidgePlot()` and
`dittoBoxPlot()` are wrappers which essentially just adjust the default for
the `plots` input from c(“jitter”, “vlnplot”) to c(“ridgeplot”) or
c(“boxplot”,“jitter”), respectively.

```
dittoPlot(sce, "ENO1", group.by = "label",
    plots = c("vlnplot", "jitter"))
```

![](data:image/jpeg;base64...)

```
dittoRidgePlot(sce, "ENO1", group.by = "label")
```

![](data:image/jpeg;base64...)

```
dittoBoxPlot(sce, "ENO1", group.by = "label")
```

![](data:image/jpeg;base64...)

### 7.3.1 Adjustments to data representations

Tweaks to the individual data representation types can be made with discrete
inputs, all of which start with the representation types’ name. For
example…

```
dittoPlot(sce, "ENO1", group.by = "label",
    plots = c("jitter", "vlnplot", "boxplot"), # <- order matters

    # change the color and size of jitter points
    jitter.color = "blue", jitter.size = 0.5,

    # change the outline color and width, and remove the fill of boxplots
    boxplot.color = "white", boxplot.width = 0.1,
    boxplot.fill = FALSE,

    # change how the violin plot widths are normalized across groups
    vlnplot.scaling = "count"
    )
```

![](data:image/jpeg;base64...)

## 7.4 dittoBarPlot & dittoFreqPlot

A couple of very handy visualizations missing from some other major single-cell
visualization toolsets, these functions quantify and display frequencies of
clusters or cell types (or other discrete data) per sample (or other discrete
groupings). Such visualizations are quite useful for QC-ing clustering for
batch effects and generally assessing cell type fluctuations.

For both, data can be represented as percentages or counts, and this is
controlled by the `scale` input.

```
# dittoBarPlot
dittoBarPlot(sce, "label", group.by = "donor")
```

![](data:image/jpeg;base64...)

```
dittoBarPlot(sce, "label", group.by = "donor",
    scale = "count")
```

![](data:image/jpeg;base64...)

dittoFreqPlot separates each cell type into its own facet, and thus puts more
emphasis on individual cells. An additional `sample.by` input controls
splitting of cells within `group.by`-groups into individual samples.

```
# dittoFreqPlot
sce$mock.donor.group <- ifelse(sce$donor %in% unique(sce$donor)[1:2], "A", "B")
dittoFreqPlot(sce, "label",
    sample.by = "donor", group.by = "mock.donor.group")
```

![](data:image/jpeg;base64...)

## 7.5 dittoHeatmap

This function is essentially a wrapper for generating heatmaps with pheatmap,
but with the same automatic, user-friendly, data extraction, (subsetting,) and
metadata integration common to other dittoSeq functions.

For large, many cell, single-cell datasets, it can be necessary to turn off
clustering by cells in generating the heatmap because the process is very
memory intensive. As an alternative, dittoHeatmap offers the ability to order
columns in functional ways using the `order.by` input. This input will default
to the first annotation provided to `annot.by` for single cell datasets, but
can also be controlled separately.

```
# Pick Genes
genes <- c("SST", "REG1A", "PPY", "INS", "CELA3A", "PRSS2", "CTRB1",
    "CPA1", "CTRB2" , "REG3A", "REG1B", "PRSS1", "GCG", "CPB1",
    "SPINK1", "CELA3B", "CLPS", "OLFM4", "ACTG1", "FTL")

# Annotating and ordering cells by some meaningful feature(s):
dittoHeatmap(sce, genes,
    annot.by = c("label", "donor"))
```

![](data:image/jpeg;base64...)

```
dittoHeatmap(sce, genes,
    annot.by = c("label", "donor"),
    order.by = "donor")
```

![](data:image/jpeg;base64...)

`scaled.to.max = TRUE` will normalize all expression data to the max expression
of each gene [0,1], which is often useful for zero-enriched single-cell data.

`show_colnames`/`show_rownames` control whether cell/gene names will be
shown. (`show_colnames` default is TRUE for bulk, and FALSE for single-cell.)

```
# Add annotations
dittoHeatmap(sce, genes,
    annot.by = c("label", "donor"),
    scaled.to.max = TRUE,
    show_colnames = FALSE,
    show_rownames = FALSE)
```

![](data:image/jpeg;base64...)

A subset of the supplied genes can be given to the `highlight.features` input to
have names shown for just these genes.

The heatmap can also be rendered by the ComplexHeatmap package, rather than by
the pheatmap package (default), by setting `complex` to TRUE. This package
offers a wide variety of distinct plot customization, including rasterization
when the heatmap would be too complex for editing software like Illustrator.

```
# Highlight certain genes
dittoHeatmap(sce, genes, annot.by = c("label", "donor"),
    highlight.features = genes[1:3],
    complex = TRUE)
```

![](data:image/jpeg;base64...)

Additional tweaks can be added through other built in inputs or by providing
additional inputs that get passed along to pheatmap::pheatmap (see `?pheatmap`)
or to ComplexHeatmap::pheatmap (see `?ComplexHeatmap::pheatmap` and
`?ComplexHeatmap::Heatmap` on which the former function relies.)

## 7.6 Multi-Plotters

These create either multiple plots or create plots that summarize data for
multiple variables all in one plot. They make it easier to create summaries
for many genes or many cell types without the need for writing loops.

Some setup for these, let’s roughly pick out the markers of delta cells in
this data set

```
# seurat <- as.Seurat(sce)
# Idents(seurat) <- "label"
# delta.marker.table <- FindMarkers(seurat, ident.1 = "delta")
# delta.genes <- rownames(delta.marker.table)[1:20]
# Idents(seurat) <- "seurat_clusters"

delta.genes <- c(
    "SST", "RBP4", "LEPR", "PAPPA2", "LY6H",
    "CBLN4", "GPX3", "BCHE", "HHEX", "DPYSL3",
    "SERPINA1", "SEC11C", "ANXA2", "CHGB", "RGS2",
    "FXYD6", "KCNIP1", "SMOC1", "RPL10", "LRFN5")
```

### 7.6.1 dittoDotPlot

A very succinct representation that is useful for showing differences between
groups. The plot uses differently colored and sized dots to summarizes both
expression level (color) and percent of cells/samples with non-zero expression
(size) for multiple genes (or values of metadata) within different groups of
cells/samples.

By default, expression values for all groups are centered and scaled to ensure
a similar range of values for all `vars` displayed and to emphasize differences
between groups.

```
dittoDotPlot(sce, vars = delta.genes, group.by = "label")
```

![](data:image/jpeg;base64...)

```
dittoDotPlot(sce, vars = delta.genes, group.by = "label",
    scale = FALSE)
```

![](data:image/jpeg;base64...)

### 7.6.2 multi\_dittoPlot & dittoPlotVarsAcrossGroups

`multi_dittoPlot()` creates dittoPlots for multiple genes or metadata, one
plot each.

`dittoPlotVarsAcrossGroups()` creates a dittoPlot-like representation where
instead of representing samples/cells as in typical dittoPlots, each data
point instead represents a gene (or metadata). More specifically, the average
expression, within each x-grouping, of a gene (or value of a metadata).

```
multi_dittoPlot(sce, delta.genes[1:6], group.by = "label",
    vlnplot.lineweight = 0.2, jitter.size = 0.3)
```

![](data:image/jpeg;base64...)

```
dittoPlotVarsAcrossGroups(sce, delta.genes, group.by = "label",
    main = "Delta-cell Markers")
```

![](data:image/jpeg;base64...)

### 7.6.3 multi\_dittoDimPlot & multi\_dittoDimPlotVaryCells

`multi_dittoDimPlot()` creates dittoDimPlots for multiple genes or metadata,
one plot each.

`multi_dittoDimPlotVaryCells()` creates dittoDimPlots for a single gene or
metadata, but where distinct cells are highlighted in each plot. The
`vary.cells.meta` input sets the discrete metadata to be used for breaking up
cells/samples over distinct plots. This can be useful for
checking/highlighting when a gene may be differentially expressed within
multiple cell types or across all samples.

* The output of `multi_dittoDimPlotVaryCells()` is similar to that of
  faceting using dittoDimPlot’s `split.by` input, but with added capability of
  showing an “AllCells” plot as well, or of outputting the individual plots for
  making manually customized plot arrangements when `data.out = TRUE`.

```
multi_dittoDimPlot(sce, delta.genes[1:6])
```

![](data:image/jpeg;base64...)

```
multi_dittoDimPlotVaryCells(sce, delta.genes[1],
    vary.cells.meta = "label")
```

![](data:image/jpeg;base64...)

# 8 Customization via Simple Inputs

**Many adjustments can be made with simple additional inputs**. Here, we’ll go
through a few that are consistent across most dittoSeq functions, but there
are many more. Be sure to check the function documentation (e.g.
`?dittoDimPlot`) to explore more! Often, there will be a dedicated section
towards the bottom of a function’s documentation dedicated to its specific
tweaks!

## 8.1 Subsetting to certain cells/samples

The cells/samples shown in a given plot can be adjusted with the `cells.use`
input. This can be provided as either a list of cells’ / samples’ names to
include, as an integer vector with the indices of cells to keep, or as a
logical vector that states whether each cell / sample should be included.

```
# Original
dittoBarPlot(sce, "label", group.by = "donor", scale = "count")
```

![](data:image/jpeg;base64...)

```
# First 10 cells
dittoBarPlot(sce, "label", group.by = "donor", scale = "count",
    # String method
    cells.use = colnames(sce)[1:10]
    # Index method, which would achieve the same effect
    # cells.use = 1:10
    )
```

![](data:image/jpeg;base64...)

```
# Acinar cells only
dittoBarPlot(sce, "label", group.by = "donor", scale = "count",
    # Logical method
    cells.use = meta("label", sce) == "acinar")
```

![](data:image/jpeg;base64...)

## 8.2 Faceting with split.by

Most diitoSeq plot types can be faceted into separate plots for distinct groups
of cells with the `split.by` input.

```
dittoPlot(sce, "PPY", group.by = "donor",
    split.by = "label")
```

![](data:image/jpeg;base64...)

```
dittoDimPlot(sce, "PPY",
    split.by = c("donor", "label"))
```

![](data:image/jpeg;base64...)

Extra control over how this is done can be achieved with the `split.adjust`
input. `split.adjust` allows inputs to be passed through to the ggplot
functions used for achieving the faceting.

```
dittoPlot(sce, "PPY", group.by = "donor",
    split.by = "label",
    split.adjust = list(scales = "free_y"), max = NA)
```

![](data:image/jpeg;base64...)

When splitting is by only one metadata, the shape of the facet grid can be controlled with `split.ncol` and `split.nrow`.

```
dittoRidgePlot(sce, "PPY", group.by = "donor",
    split.by = "label",
    split.ncol = 1)
```

![](data:image/jpeg;base64...)

## 8.3 All titles are adjustable.

Relevant inputs are generally `main`, `sub`, `xlab`, `ylab`, `x.labels`, and
`legend.title`.

```
dittoBarPlot(sce, "label", group.by = "donor",
    main = "Encounters",
    sub = "By Type",
    xlab = NULL, # NULL = remove
    ylab = "Generation 1",
    x.labels = c("Ash", "Misty", "Jessie", "James"),
    legend.title = "Types",
    var.labels.rename = c("Fire", "Water", "Grass", "Electric", "Psychic"),
    x.labels.rotate = FALSE)
```

![](data:image/jpeg;base64...)

As exemplified above, in some functions, the displayed data can be renamed too.

## 8.4 Colors can be adjusted easily.

Colors are normally set with `color.panel` or `max.color` and `min.color`.
When color.panel is used (discrete data), an additional input called `colors`
sets the order in which those are actually used to make swapping around colors
easy when nearby clusters appear too similar in tSNE/umap plots!

```
# original - discrete
dittoDimPlot(sce, "label")
```

![](data:image/jpeg;base64...)

```
# swapped colors
dittoDimPlot(sce, "label",
    colors = 5:1)
```

![](data:image/jpeg;base64...)

```
# different colors
dittoDimPlot(sce, "label",
    color.panel = c("red", "orange", "purple", "yellow", "skyblue"))
```

![](data:image/jpeg;base64...)

```
# original - expression
dittoDimPlot(sce, "INS")
```

![](data:image/jpeg;base64...)

```
# different colors
dittoDimPlot(sce, "INS",
    max.color = "red", min.color = "gray90")
```

![](data:image/jpeg;base64...)

## 8.5 Underlying data can be output.

Simply add `data.out = TRUE` to any of the individual plotters and a
representation of the underlying data will be output.

```
dittoBarPlot(sce, "label", group.by = "donor",
    data.out = TRUE)
```

```
## $p
```

![](data:image/jpeg;base64...)

```
##
## $data
##     label   grouping count label.count.total.per.facet     percent
## 1  acinar GSM2230757   110                        1386 0.079365079
## 2    beta GSM2230757   872                        1386 0.629148629
## 3   delta GSM2230757   214                        1386 0.154401154
## 4  ductal GSM2230757   120                        1386 0.086580087
## 5   gamma GSM2230757    70                        1386 0.050505051
## 6  acinar GSM2230758     3                         886 0.003386005
## 7    beta GSM2230758   371                         886 0.418735892
## 8   delta GSM2230758   125                         886 0.141083521
## 9  ductal GSM2230758   301                         886 0.339729120
## 10  gamma GSM2230758    86                         886 0.097065463
## 11 acinar GSM2230759   843                        2203 0.382660009
## 12   beta GSM2230759   787                        2203 0.357240127
## 13  delta GSM2230759   161                        2203 0.073082161
## 14 ductal GSM2230759   376                        2203 0.170676350
## 15  gamma GSM2230759    36                        2203 0.016341353
## 16 acinar GSM2230760     2                         941 0.002125399
## 17   beta GSM2230760   495                         941 0.526036132
## 18  delta GSM2230760   101                         941 0.107332625
## 19 ductal GSM2230760   280                         941 0.297555792
## 20  gamma GSM2230760    63                         941 0.066950053
```

For dittoHeatmap, a list of all the arguments that would be supplied to
pheatmap are output. This allows users to make their own tweaks to how the
expression matrix is represented before plotting, or even to use a different
heatmap creator from pheatmap altogether.

```
dittoHeatmap(sce, c("SST","CPE","GPX3"), cells.use = colnames(sce)[1:5],
    data.out = TRUE)
```

```
## $mat
##      human1_lib1.final_cell_0001 human1_lib1.final_cell_0002
## SST                     3.367669                   3.3376026
## CPE                     0.000000                   0.5530070
## GPX3                    0.000000                   0.3028399
##      human1_lib1.final_cell_0003 human1_lib1.final_cell_0004
## SST                    2.3925635                    3.018649
## CPE                    0.0000000                    0.000000
## GPX3                   0.4713904                    0.000000
##      human1_lib1.final_cell_0005
## SST                    3.4550443
## CPE                    0.9004598
## GPX3                   0.0000000
##
## $main
## [1] NA
##
## $show_colnames
## [1] FALSE
##
## $show_rownames
## [1] TRUE
##
## $color
##  [1] "#0000FF" "#0A0AFF" "#1414FF" "#1F1FFF" "#2929FF" "#3434FF" "#3E3EFF"
##  [8] "#4848FF" "#5353FF" "#5D5DFF" "#6868FF" "#7272FF" "#7C7CFF" "#8787FF"
## [15] "#9191FF" "#9C9CFF" "#A6A6FF" "#B0B0FF" "#BBBBFF" "#C5C5FF" "#D0D0FF"
## [22] "#DADAFF" "#E4E4FF" "#EFEFFF" "#F9F9FF" "#FFF9F9" "#FFEFEF" "#FFE4E4"
## [29] "#FFDADA" "#FFD0D0" "#FFC5C5" "#FFBBBB" "#FFB0B0" "#FFA6A6" "#FF9C9C"
## [36] "#FF9191" "#FF8787" "#FF7C7C" "#FF7272" "#FF6868" "#FF5D5D" "#FF5353"
## [43] "#FF4848" "#FF3E3E" "#FF3434" "#FF2929" "#FF1F1F" "#FF1414" "#FF0A0A"
## [50] "#FF0000"
##
## $cluster_cols
## [1] FALSE
##
## $border_color
## [1] NA
##
## $scale
## [1] "row"
##
## $breaks
## [1] NA
##
## $legend_breaks
## [1] NA
##
## $drop_levels
## [1] FALSE
```

## 8.6 plotly hovering can be added.

Many dittoSeq functions can be supplied `do.hover = TRUE` to have them convert
the output into an interactive plotly object that will display additional data
about each data point when the user hovers their cursor on top.

Generally, a second input, `hover.data`, is used to tell dittoSeq what extra
data to display. This input takes in a vector of gene or metadata names (or
“ident” for Seurat object clustering) in the order you wish for them to be
displayed. However, when the types of underlying data possible to be shown are
constrained because the plot pieces represent summary data (dittoBarPlot and
dittoPlotVarsAcrossGroups), the `hover.data` input is not used.

```
# These can be finicky to render in knitting, but still, example code:
dittoDimPlot(sce, "INS",
    do.hover = TRUE,
    hover.data = c("label", "donor", "ENO1", "cluster", "nCount_RNA"))
dittoBarPlot(sce, "label", group.by = "donor",
    do.hover = TRUE)
```

## 8.7 Rasterization / flattening to pixels

Often, single-cell datasets have so many cells that working with plots that
show data points for every cell in a vector-based graphics editor, such as
Illustrator, becomes prohibitively computationally intensive. In such
instances, it can be helpful to have the per-cell graphics layers flattened
to a pixel representation. Generally, dittoSeq offers this capability for via
`do.raster` and `raster.dpi` inputs.

```
# Note: dpi gets re-set by the styling code of this vignette, so this is
#   just a code example, but the plot won't be quite matched.
dittoDimPlot(sce, "label",
    do.raster = TRUE,
    raster.dpi = 300)
```

![](data:image/jpeg;base64...)

For `dittoHeatmap()`, where the plotting itself is handled externally,
the control is a bit different and we rely on `?ComplexHeatmap::Heatmap`’s
input for this. First, set `complex = TRUE` to have the heatmap rendered by
ComplexHeatmap, then rasterization should be turned on by default when needed,
but it can also be turned on manually with `use_raster = TRUE`.

```
dittoHeatmap(sce, genes, scaled.to.max = TRUE,
    complex = TRUE,
    use_raster = TRUE)
```

![](data:image/jpeg;base64...)

# 9 Session information

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
##  [1] dittoSeq_1.22.0             bluster_1.20.0
##  [3] scran_1.38.0                scater_1.38.0
##  [5] ggplot2_4.0.0               scuttle_1.20.0
##  [7] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22         BiocIO_1.20.0            bitops_1.0-9
##   [4] filelock_1.0.3           tibble_3.3.0             XML_3.99-0.19
##   [7] lifecycle_1.0.4          httr2_1.2.1              edgeR_4.8.0
##  [10] doParallel_1.0.17        lattice_0.22-7           ensembldb_2.34.0
##  [13] MASS_7.3-65              alabaster.base_1.10.0    magrittr_2.0.4
##  [16] limma_3.66.0             sass_0.4.10              rmarkdown_2.30
##  [19] jquerylib_0.1.4          yaml_2.3.10              metapod_1.18.0
##  [22] cowplot_1.2.0            DBI_1.2.3                RColorBrewer_1.1-3
##  [25] abind_1.4-8              AnnotationFilter_1.34.0  RCurl_1.98-1.17
##  [28] rappdirs_0.3.3           circlize_0.4.16          ggrepel_0.9.6
##  [31] irlba_2.3.5.1            alabaster.sce_1.10.0     pheatmap_1.0.13
##  [34] dqrng_0.4.1              codetools_0.2-20         DelayedArray_0.36.0
##  [37] shape_1.4.6.1            tidyselect_1.2.1         UCSC.utils_1.6.0
##  [40] farver_2.1.2             ScaledMatrix_1.18.0      viridis_0.6.5
##  [43] BiocFileCache_3.0.0      GenomicAlignments_1.46.0 jsonlite_2.0.0
##  [46] GetoptLong_1.0.5         BiocNeighbors_2.4.0      ggridges_0.5.7
##  [49] iterators_1.0.14         foreach_1.5.2            tools_4.5.1
##  [52] Rcpp_1.1.0               glue_1.8.0               gridExtra_2.3
##  [55] SparseArray_1.10.0       xfun_0.53                GenomeInfoDb_1.46.0
##  [58] dplyr_1.1.4              HDF5Array_1.38.0         gypsum_1.6.0
##  [61] withr_3.0.2              BiocManager_1.30.26      fastmap_1.2.0
##  [64] rhdf5filters_1.22.0      digest_0.6.37            rsvd_1.0.5
##  [67] R6_2.6.1                 colorspace_2.1-2         Cairo_1.7-0
##  [70] dichromat_2.0-0.1        RSQLite_2.4.3            cigarillo_1.0.0
##  [73] h5mread_1.2.0            hexbin_1.28.5            rtracklayer_1.70.0
##  [76] httr_1.4.7               S4Arrays_1.10.0          uwot_0.2.3
##  [79] pkgconfig_2.0.3          gtable_0.3.6             blob_1.2.4
##  [82] ComplexHeatmap_2.26.0    S7_0.2.0                 XVector_0.50.0
##  [85] htmltools_0.5.8.1        bookdown_0.45            clue_0.3-66
##  [88] ProtGenerics_1.42.0      scales_1.4.0             alabaster.matrix_1.10.0
##  [91] png_0.1-8                knitr_1.50               rjson_0.2.23
##  [94] curl_7.0.0               cachem_1.1.0             rhdf5_2.54.0
##  [97] GlobalOptions_0.1.2      BiocVersion_3.22.0       parallel_4.5.1
## [100] vipor_0.4.7              AnnotationDbi_1.72.0     ggrastr_1.0.2
## [103] restfulr_0.0.16          pillar_1.11.1            grid_4.5.1
## [106] alabaster.schemas_1.10.0 vctrs_0.6.5              BiocSingular_1.26.0
## [109] dbplyr_2.5.1             beachmat_2.26.0          cluster_2.1.8.1
## [112] beeswarm_0.4.0           evaluate_1.0.5           tinytex_0.57
## [115] GenomicFeatures_1.62.0   magick_2.9.0             cli_3.6.5
## [118] locfit_1.5-9.12          compiler_4.5.1           Rsamtools_2.26.0
## [121] rlang_1.1.6              crayon_1.5.3             labeling_0.4.3
## [124] ggbeeswarm_0.7.2         viridisLite_0.4.2        alabaster.se_1.10.0
## [127] BiocParallel_1.44.0      Biostrings_2.78.0        lazyeval_0.2.2
## [130] Matrix_1.7-4             ExperimentHub_3.0.0      bit64_4.6.0-1
## [133] Rhdf5lib_1.32.0          KEGGREST_1.50.0          statmod_1.5.1
## [136] alabaster.ranges_1.10.0  AnnotationHub_4.0.0      igraph_2.2.1
## [139] memoise_2.0.1            bslib_0.9.0              bit_4.6.0
## [142] ggplot.multistats_1.0.1
```

# References

Baron, Maayan, Adrian Veres, Samuel L. Wolock, Aubrey L. Faust, Renaud Gaujoux, Amedeo Vetere, Jennifer Hyoje Ryu, et al. 2016. “A Single-Cell Transcriptomic Map of the Human and Mouse Pancreas Reveals Inter- and Intra-Cell Population Structure.” *Cell Systems* 3 (4): 346–360.e4. <https://doi.org/10.1016/j.cels.2016.08.011>.

Wong, Bang. 2011. “Points of View: Color Blindness.” *Nature Methods* 8 (6): 441–41. <https://doi.org/10.1038/nmeth.1618>.