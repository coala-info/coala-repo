# Understanding Intrasample Heterogeneity from ST data with RegionalST

Ziyi Li1\*

1The University of Texas MD Anderson Cancer Center

\*zli16@mdanderson.org

#### 30 October 2025

#### Abstract

Spatial transcriptomics is a rapidly evolving field that has recently led to a better understanding of spatial and intra-sample heterogeneity, which could be crucial to understand the molecular basis of human diseases. However, the lack of computational tools for exploiting cross-regional information and the limited spatial resolution of current technologies present major obstacles to elucidating tissue heterogeneity.Here we present RegionalST, an R software package that enables quantifying cell type mixture and interactions, identifying sub-regions of interest, and performing cross-region cell type-specific differential analysis. RegionalST provides a one-stop destination for researchers seeking to better understand the complexities of spatial transcriptomics data.

#### Package

RegionalST 1.8.0

# Contents

* [1 Install RegionalST](#install-regionalst)
* [2 Preparing your data for RegionalST through BayesSpace](#preparing-your-data-for-regionalst-through-bayesspace)
* [3 Analysis with the incorporation of cell type proportions](#analysis-with-the-incorporation-of-cell-type-proportions)
  + [3.1 Obtain cell deconvolution proportions](#obtain-cell-deconvolution-proportions)
  + [3.2 Load example dataset](#load-example-dataset)
  + [3.3 Identify Regions of Interest (ROIs) with incorporation of proportions](#identify-regions-of-interest-rois-with-incorporation-of-proportions)
    - [3.3.1 Automatic ROI selection](#automatic-roi-selection)
    - [3.3.2 Manual ROI selection](#manual-roi-selection)
  + [3.4 Perform Cross-regional Differential Analysis with proportions](#perform-cross-regional-differential-analysis-with-proportions)
  + [3.5 Perform Cross-regional Cell Type-Specific Differential Analysis with proportions and self-defined regions](#perform-cross-regional-cell-type-specific-differential-analysis-with-proportions-and-self-defined-regions)
* [4 Analysis with cell type information](#analysis-with-cell-type-information)
  + [4.1 Obtain cell type labels](#obtain-cell-type-labels)
  + [4.2 Load example dataset](#load-example-dataset-1)
  + [4.3 Identify Regions of Interest (ROIs) with cell type information](#identify-regions-of-interest-rois-with-cell-type-information)
    - [4.3.1 Automatic selection of the ROIs](#automatic-selection-of-the-rois)
    - [4.3.2 Manual ROI selection with cell type information](#manual-roi-selection-with-cell-type-information)
  + [4.4 Perform Cross-regional Differential Analysis with cell type information](#perform-cross-regional-differential-analysis-with-cell-type-information)
* [5 Pathway GSEA analysis based on the cross-regional DEs](#pathway-gsea-analysis-based-on-the-cross-regional-des)
* [Session info](#session-info)

# 1 Install RegionalST

To install this package, start R (version “4.3”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RegionalST")
```

# 2 Preparing your data for RegionalST through BayesSpace

The data input step of RegionalST package relies on the package *[BayesSpace](https://bioconductor.org/packages/3.22/BayesSpace)*. BayesSpace supports three ways of loading the data for analysis.

First, reading Visium data through `readVisium()`:
This function takes only
the path to the Space Ranger output directory (containing the `spatial/` and
`filtered_feature_bc_matrix/` subdirectories) and returns a
`SingleCellExperiment`.

```
sce <- readVisium("path/to/spaceranger/outs/")
```

Second, you can create a SingleCellExperiment object directly from the count matrix:

```
library(Matrix)

rowData <- read.csv("path/to/rowData.csv", stringsAsFactors=FALSE)
colData <- read.csv("path/to/colData.csv", stringsAsFactors=FALSE, row.names=1)
counts <- read.csv("path/to/counts.csv.gz",
                   row.names=1, check.names=F, stringsAsFactors=FALSE))

sce <- SingleCellExperiment(assays=list(counts=as(counts, "dgCMatrix")),
                            rowData=rowData,
                            colData=colData)
```

Lastly is to use the `getRDS()` function. Please check the manual of *[BayesSpace](https://bioconductor.org/packages/3.22/BayesSpace)* if this step runs into any question.

# 3 Analysis with the incorporation of cell type proportions

## 3.1 Obtain cell deconvolution proportions

For Visium platform, a single spot is usually consisting of multiple cells and thus analyzing it as a whole could reduce the accuracy. As a result, we suggest perform cell deconvolution analysis using *[CARD](https://github.com/YingMa0107/CARD)* or RCTD (*[spacexr](https://github.com/dmcable/spacexr)*) or *[cell2location](https://github.com/BayraktarLab/cell2location)*. Below we show some example code of obtaining cell type proportions using CARD:

```
### read in spatial transcriptomics data for analysis
library(BayesSpace)
outdir = "/Dir/To/Data/BreastCancer_10x"
sce <- readVisium(outdir)
sce <- spatialPreprocess(sce, platform="Visium", log.normalize=TRUE)
spatial_count <- assays(sce)$counts
spatial_location <- data.frame(x = sce$imagecol,
                               y = max(sce$imagerow) - sce$imagerow)
rownames(spatial_location) <- colnames(spatial_count)

### assuming the single cell reference data for BRCA has been loaded
### BRCA_countmat: the count matrix of the BRCA single cell reference
### cellType: the cell types of the BRCA reference data
sc_count <- BRCA_countmat
sc_meta <- data.frame(cellID = colnames(BRCA_countmat),
                      cellType = cellType)
rownames(sc_meta) <- colnames(BRCA_countmat)

library(CARD)
CARD_obj <- createCARDObject(
    sc_count = sc_count,
    sc_meta = sc_meta,
    spatial_count = spatial_count,
    spatial_location = spatial_location,
    ct.varname = "cellType",
    ct.select = unique(sc_meta$cellType),
    sample.varname = "sampleInfo",
    minCountGene = 100,
    minCountSpot = 5)
CARD_obj <- CARD_deconvolution(CARD_object = CARD_obj)

## add proportion to the sce object
S4Vectors::metadata(sce)$Proportions <- RegionalST::getProportions(CARD_obj)
```

## 3.2 Load example dataset

In our package, we create a small example dataset by subsetting the breast cancer Visium data from 10X. We already added the cell type proportion from deconvolution. In case deconvolution couldn’t be performed or the data is of single cell resolution, we also provided the cell type label for each spot. Note that the Visium data is actually not single cell resolution, so the cell type label indicates the major cell type for each spot.

```
set.seed(1234)

library(RegionalST)
library("gridExtra")
data(example_sce)

## the proportion information is saved under the metadata
S4Vectors::metadata(example_sce)$Proportions[seq_len(5),seq_len(5)]
```

```
##                    Cancer Epithelial      CAFs    T-cells Endothelial
## GTAGACAACCGATGAA-1        0.04610997 0.2684636 0.11682355  0.07809853
## ACAGATTAGGTTAGTG-1        0.09078458 0.3380722 0.06542484  0.05633140
## TGGTATCGGTCTGTAT-1        0.05897943 0.4562020 0.02192799  0.09059294
## ATTATCTCGACAGATC-1        0.07374128 0.5029240 0.03206525  0.02884060
## TGAGATCAAATACTCA-1        0.09849148 0.5737657 0.01429222  0.02761076
##                            PVL
## GTAGACAACCGATGAA-1 0.040103174
## ACAGATTAGGTTAGTG-1 0.098474025
## TGGTATCGGTCTGTAT-1 0.056373840
## ATTATCTCGACAGATC-1 0.006084852
## TGAGATCAAATACTCA-1 0.014253759
```

```
## the cell type information is saved under a cell type variable
head(example_sce$celltype)
```

```
## [1] "CAFs" "CAFs" "CAFs" "CAFs" "CAFs" "CAFs"
```

## 3.3 Identify Regions of Interest (ROIs) with incorporation of proportions

First, we want to preprocess the data using the functions from BayesSpace:

```
library(BayesSpace)
example_sce <- example_sce[, colSums(counts(example_sce)) > 0]
example_sce <- mySpatialPreprocess(example_sce, platform="Visium")

### modify example_sce to have the needed parameters for BayesSpace to draw plots
### usually not needed if the data is directly read from Visium platform
example_sce$"array_col" <- example_sce$col
example_sce$"array_row" <- example_sce$row
example_sce$"pxl_col_in_fullres" <- example_sce$imagecol
example_sce$"pxl_row_in_fullres" <- example_sce$imagerow
```

Second, we assign weights to each cell type and check the entropy at different radii.

```
weight <- data.frame(celltype = c("Cancer Epithelial", "CAFs", "T-cells", "Endothelial",
                                  "PVL", "Myeloid", "B-cells", "Normal Epithelial", "Plasmablasts"),
                     weight = c(0.25,0.05,
                                0.25,0.05,
                                0.025,0.05,
                                0.25,0.05,0.025))
OneRad <- GetOneRadiusEntropy_withProp(example_sce,
                             selectN = length(example_sce$spot),
                             weight = weight,
                             radius = 5,
                             doPlot = TRUE,
                             mytitle = "Radius 5 weighted entropy")
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the BayesSpace package.
##   Please report the issue at
##   <https://github.com/edward130603/BayesSpace/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)
Note: Here the `GetOneRadiusEntropy()` will calculate the entropy for all the spots (as `length(example_sce$spot)` is the length of all the spots). If this is too slow with a large dataset, you can specify to compute only a subset of the spots by argument, e.g., `selectN = round(length(example_sce$spot)/10)`. I use one tenth as an example, depending on the size of your data, you can try 1/3, 1/5, or 1/20 to generate entropy figures with different sparsities. The smaller `selectN` is, the faster this function will be.

### 3.3.1 Automatic ROI selection

Then, we can use automatic functions to select ROIs:

```
example_sce <- RankCenterByEntropy_withProp(example_sce,
                                    weight,
                                    selectN = round(length(example_sce$spot)/5),
                                    topN = 3,
                                    min_radius = 10,
                                    radius_vec = c(5,10),
                                    doPlot = TRUE)
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the BayesSpace package.
##   Please report the issue at
##   <https://github.com/edward130603/BayesSpace/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
### visualize one selected ROI:
PlotOneSelectedCenter(example_sce,ploti = 1)
```

![](data:image/png;base64...)
Note: The `min_radius` argument controls the minimum distance between two closest identified ROI centers. If you specify a large min\_radius, the ROIs will tend to have no or less overlaps.

Let’s visualize all the selected ROIs:

```
## let's visualize the selected regions:
palette <- colorspace::qualitative_hcl(9,
                                       palette = "Set2")
selplot <- list()
topN <- 3
for(i in seq_len(topN)) {
    selplot[[i]] <- print(PlotOneSelectedCenter(example_sce,ploti = i))
}
```

```
selplot[[topN+1]] <- print(clusterPlot(example_sce, palette=palette, label = "celltype", size=0.1) )
```

```
do.call("grid.arrange", c(selplot, ncol = 2))
```

![](data:image/png;base64...)
You can save your selected ROIs to an `.RData` file for future analysis and reproducible purposes:

```
thisSelection <- S4Vectors::metadata(sce)$selectCenters
save(thisSelection, file = "/Your/Directory/SelectionResults_withProportions.RData")
```

### 3.3.2 Manual ROI selection

In addition to automatic selections, we can also manually select ROIs through a shiny app:

```
example_sce <- ManualSelectCenter(example_sce)
S4Vectors::metadata(example_sce)$selectCenters
```

![Example of the shiny app](data:image/png;base64...)
### Draw cell type proportions for the selected ROIs

```
DrawRegionProportion_withProp(example_sce,
                              label = "CellType",
                              selCenter = c(1,2,3))
```

![](data:image/png;base64...)

## 3.4 Perform Cross-regional Differential Analysis with proportions

One important downloaded analysis after we identified the ROIs is to understand the differentially expressed genes comparing one ROI to the other. Let’s compare the first and the second ROIs.

```
CR12_DE <- GetCrossRegionalDE_withProp(example_sce,
                                       twoCenter = c(1,2),
                                       label = "celltype",
                                       angle = 30,
                                       hjust = 0,
                                       size = 3,
                                       padj_filter = 0.05,
                                       doHeatmap = TRUE)
```

![](data:image/png;base64...)

```
dim(CR12_DE$allDE)
```

```
## [1] 4 9
```

```
table(CR12_DE$allDE$Comparison)
```

```
##
## Cancer_Epithelial: Region1 vs Region2           Myeloid: Region1 vs Region2
##                                     1                                     1
## Normal_Epithelial: Region1 vs Region2               PVL: Region1 vs Region2
##                                     1                                     1
```

```
## we find very few DE genes in the current dataset as the example data is very small and truncated.
```

We can similarly compare the first and third, the second and the third ROIs.

```
CR13_DE <- GetCrossRegionalDE_withProp(example_sce,
                                       twoCenter = c(1,3),
                                       label = "celltype",
                                       padj_filter = 0.05,
                                       doHeatmap = TRUE)
CR23_DE <- GetCrossRegionalDE_withProp(example_sce,
                                       twoCenter = c(2,3),
                                       label = "celltype",
                                       padj_filter = 0.05,
                                       doHeatmap = TRUE)
exampleRes <- list(CR12_DE,
                   CR13_DE,
                   CR23_DE)
```

As our current dataset is very small, we couldn’t find much signals from it. We prepared another
example DE output. This result has been truncated and thus it is not a full list of genes.
Let’s take a look:

```
data("exampleRes")

## check the number of DEs for each cell type-specific comparison
table(exampleRes[[1]]$allDE$Comparison)
```

```
##
##           B_cells: Region1 vs Region2              CAFs: Region1 vs Region2
##                                    11                                    35
## Cancer_Epithelial: Region1 vs Region2       Endothelial: Region1 vs Region2
##                                    21                                    12
##           Myeloid: Region1 vs Region2 Normal_Epithelial: Region1 vs Region2
##                                    57                                    14
##               PVL: Region1 vs Region2      Plasmablasts: Region1 vs Region2
##                                    27                                    15
##           T_cells: Region1 vs Region2
##                                     8
```

```
table(exampleRes[[2]]$allDE$Comparison)
```

```
##
##           B_cells: Region1 vs Region3              CAFs: Region1 vs Region3
##                                    29                                    32
## Cancer_Epithelial: Region1 vs Region3       Endothelial: Region1 vs Region3
##                                     9                                    20
##           Myeloid: Region1 vs Region3 Normal_Epithelial: Region1 vs Region3
##                                    30                                     6
##               PVL: Region1 vs Region3      Plasmablasts: Region1 vs Region3
##                                    19                                    14
##           T_cells: Region1 vs Region3
##                                    41
```

```
table(exampleRes[[3]]$allDE$Comparison)
```

```
##
##           B_cells: Region2 vs Region3              CAFs: Region2 vs Region3
##                                    15                                    34
## Cancer_Epithelial: Region2 vs Region3       Endothelial: Region2 vs Region3
##                                     2                                    25
##           Myeloid: Region2 vs Region3 Normal_Epithelial: Region2 vs Region3
##                                    85                                     8
##               PVL: Region2 vs Region3      Plasmablasts: Region2 vs Region3
##                                    20                                     6
##           T_cells: Region2 vs Region3
##                                     5
```

## 3.5 Perform Cross-regional Cell Type-Specific Differential Analysis with proportions and self-defined regions

You can also provide the region spot IDs to the function to perform cell type-specific differential analysis.
Here I still use the spot we identified as an example, but you can modify it to your own regions.

```
thisID1 <- S4Vectors::metadata(example_sce)$selectCenters$selectID[1]
thisRadius1 <- S4Vectors::metadata(example_sce)$selectCenters$selectRadius[1]
OutRegRes1 <- RegionalST::FindRegionalCells(example_sce,
                                            centerID = thisID1,
                                            radius = 20,
                                            enhanced = FALSE,
                                            doPlot = FALSE,
                                            returnPlot = FALSE)

thisID2 <- S4Vectors::metadata(example_sce)$selectCenters$selectID[2]
thisRadius2 <- S4Vectors::metadata(example_sce)$selectCenters$selectRadius[2]
OutRegRes2 <- RegionalST::FindRegionalCells(example_sce,
                                            centerID = thisID2,
                                            radius = 20,
                                            enhanced = FALSE,
                                            doPlot = FALSE,
                                            returnPlot = FALSE)
Regional1ID <- OutRegRes1$closeID
Regional2ID <- OutRegRes2$closeID

head(Regional1ID)
```

```
## [1] "GTAGACAACCGATGAA-1" "ACAGATTAGGTTAGTG-1" "TGGTATCGGTCTGTAT-1"
## [4] "ATTATCTCGACAGATC-1" "TGAGATCAAATACTCA-1" "CAACTTGTAGTGGGCA-1"
```

```
head(Regional2ID)
```

```
## [1] "GTAGACAACCGATGAA-1" "ACAGATTAGGTTAGTG-1" "TGGTATCGGTCTGTAT-1"
## [4] "ATTATCTCGACAGATC-1" "TGAGATCAAATACTCA-1" "CAACTTGTAGTGGGCA-1"
```

Perform cell type-specific differential analysis across the two regions:

```
CTS_DE <- GetCellTypeSpecificDE_withProp(example_sce,
                                           Regional1ID = Regional1ID,
                                           Regional2ID = Regional2ID,
                                           n_markers = 10,
                                           angle = 30,
                                           hjust = 0,
                                           size = 3,
                                           padj_filter = 1,
                                           doHeatmap = FALSE)

head(CTS_DE$allDE)
```

```
##                 beta     beta_var            mu effect_size f_statistics
## A3GALT2   0.06242845 0.0009142557 -8.806740e-17   2.0000000     2.791415
## GPR3      0.10695181 0.0048646577 -1.292790e-16   2.0000000     2.351387
## GJA9     -0.05147547 0.0014934478  2.261481e-16   2.0000000     1.774233
## SLFNL1    0.27618187 0.0500184830 -1.297759e-01  33.2148813     1.524965
## CTRC     -0.05805946 0.0025207970  1.719291e-01  -0.4062961     1.337236
## C1orf174 -0.88813725 0.6313005219  1.643379e+00  -0.7405400     1.249465
##             p_value fdr                              Comparison     gene
## A3GALT2  0.09543341   1 Cancer_Epithelial: Region 1 vs Region 2  A3GALT2
## GPR3     0.12584161   1 Cancer_Epithelial: Region 1 vs Region 2     GPR3
## GJA9     0.18350190   1 Cancer_Epithelial: Region 1 vs Region 2     GJA9
## SLFNL1   0.21748409   1 Cancer_Epithelial: Region 1 vs Region 2   SLFNL1
## CTRC     0.24810691   1 Cancer_Epithelial: Region 1 vs Region 2     CTRC
## C1orf174 0.26422334   1 Cancer_Epithelial: Region 1 vs Region 2 C1orf174
```

Perform GSEA analysis using the identified pathways:

```
lCTres <- list(CTS_DE)
CTres <- DoGSEA(lCTres, whichDB = "hallmark", withProp = TRUE)
DrawDotplot(CTres, CT = 1, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

```
DrawDotplot(CTres, CT = 2, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

```
DrawDotplot(CTres, CT = 3, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

```
DrawDotplot(CTres, CT = 4, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

```
DrawDotplot(CTres, CT = 5, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

# 4 Analysis with cell type information

## 4.1 Obtain cell type labels

Here is some example code of annotating cell types for Visium 10X data when the cell type deconvolution is not feasible.

```
outdir = "/Users/zli16/Dropbox/TrySTData/Ovarian_10x"
sce <- readVisium(outdir)
sce <- sce[, colSums(counts(sce)) > 0]
sce <- spatialPreprocess(sce, platform="Visium", log.normalize=TRUE)
sce <- qTune(sce, qs=seq(2, 10), platform="Visium", d=15)
sce <- spatialCluster(sce, q=10, platform="Visium", d=15,
                      init.method="mclust", model="t", gamma=2,
                      nrep=50000, burn.in=1000,
                      save.chain=FALSE)
clusterPlot(sce)

markers <- list()
markers[["Epithelial"]] <- c("EPCAM")
markers[["Tumor"]] <- c("EPCAM","MUC6", "MMP7")
markers[["Macrophages"]] <- c("CD14", "CSF1R")
markers[["Dendritic cells"]] <- c("CCR7")
markers[["Immune cells"]] <- c("CD19", "CD79A", "CD79B", "PTPRC")

sum_counts <- function(sce, features) {
    if (length(features) > 1) {
        colSums(logcounts(sce)[features, ])
    } else {
        logcounts(sce)[features, ]
    }
}
spot_expr <- purrr::map(markers, function(xs) sum_counts(sce, xs))

library(ggplot2)
plot_expression <- function(sce, expr, name, mylimits) {
    # fix.sc <- scale_color_gradientn(colours = c('lightgrey', 'blue'), limits = c(0, 6))
    featurePlot(sce, expr, color=NA) +
        viridis::scale_fill_viridis(option="A") +
        labs(title=name, fill="Log-normalized\nexpression")
}
spot_plots <- purrr::imap(spot_expr, function(x, y) plot_expression(sce, x, y))
patchwork::wrap_plots(spot_plots, ncol=3)

#### assign celltype based on marker distribution
sce$celltype <- sce$spatial.cluster
sce$celltype[sce$spatial.cluster %in% c(1,2,6,8)] <- "Epithelial"
sce$celltype[sce$spatial.cluster %in% c(3)] <- "Macrophages"
sce$celltype[sce$spatial.cluster %in% c(4,5)] <- "Immune"
sce$celltype[sce$spatial.cluster %in% c(9,7,10)] <- "Tumor"
colData(sce)$celltype <- sce$celltype
```

## 4.2 Load example dataset

We still use the same example dataset as the section above for illustration.

```
library(RegionalST)
data(example_sce)

## the cell type information is saved under a cell type variable
table(example_sce$celltype)
```

## 4.3 Identify Regions of Interest (ROIs) with cell type information

```
weight <- data.frame(celltype = c("Cancer Epithelial", "CAFs", "T-cells", "Endothelial",
                                  "PVL", "Myeloid", "B-cells", "Normal Epithelial", "Plasmablasts"),
                     weight = c(0.25,0.05,
                                0.25,0.05,
                                0.025,0.05,
                                0.25,0.05,0.025))
OneRad <- GetOneRadiusEntropy(example_sce,
                              selectN = length(example_sce$spot),
                              weight = weight,
                              label = "celltype",
                              radius = 5,
                              doPlot = TRUE,
                              mytitle = "Radius 5 weighted entropy")
```

![](data:image/png;base64...)

### 4.3.1 Automatic selection of the ROIs

```
example_sce <- RankCenterByEntropy(example_sce,
                           weight,
                           selectN = round(length(example_sce$spot)/2),
                           label = "celltype",
                           topN = 3,
                           min_radius = 10,
                           radius_vec = c(5,10),
                           doPlot = TRUE)
```

Note: The `min_radius` argument controls the minimum distance between two closest identified ROI centers. If you specify a large min\_radius, the ROIs will tend to have no or less overlaps.

Let’s visualize all the selected ROIs:

```
## let's visualize the selected regions:
palette <- colorspace::qualitative_hcl(9,
                                       palette = "Set2")
selplot <- list()
topN = 3
for(i in seq_len(topN)) {
    selplot[[i]] <- print(PlotOneSelectedCenter(example_sce,ploti = i))
}
```

```
selplot[[topN+1]] <- print(clusterPlot(example_sce, palette=palette, label = "celltype", size=0.1) )
```

```
do.call("grid.arrange", c(selplot, ncol = 2))
```

![](data:image/png;base64...)
You can save your selected ROIs to an `.RData` file for future analysis and reproducible purposes:

```
thisSelection <- S4Vectors::metadata(example_sce)$selectCenters
save(thisSelection, file = "/Your/Directory/SelectionResults_withProportions.RData")
```

### 4.3.2 Manual ROI selection with cell type information

This section is exactly the same with or without proportion information. See Section [3.3.2](#manual-roi-selection).

## 4.4 Perform Cross-regional Differential Analysis with cell type information

```
## I didn't run this in the vignette as the current dataset has been truncated and couldn't find any DE genes
CR12_DE <- GetCrossRegionalDE_raw(example_sce,
                                  twoCenter = c(1,2),
                                  label = "celltype",
                                  logfc.threshold = 0.1,
                                  min.pct = 0.1,
                                  angle = 30,
                                  hjust = 0,
                                  size = 3,
                                  padj_filter = 0.05,
                                  doHeatmap = FALSE)
```

Similarly we can perform cross regional analysis for other pairs:

```
CR13_DE <- GetCrossRegionalDE_raw(example_sce,
                                  twoCenter = c(1,3),
                                  label = "celltype",
                                  padj_filter = 0.05,
                                  doHeatmap = FALSE)
CR23_DE <- GetCrossRegionalDE_raw(example_sce,
                                  twoCenter = c(2,3),
                                  label = "celltype",
                                  padj_filter = 0.05,
                                  doHeatmap = FALSE)
```

# 5 Pathway GSEA analysis based on the cross-regional DEs

```
allfigure <- list()
allCTres <- DoGSEA(exampleRes, whichDB = "hallmark", withProp = TRUE)
for(i in seq_len(3)) {
    allfigure[[i]] <- DrawDotplot(allCTres, CT = i, angle = 15, vjust = 1, chooseP = "padj")
}
```

```
do.call("grid.arrange", c(allfigure[c(1,2,3)], ncol = 3))
```

![](data:image/png;base64...)

```
### draw each cell type individually, here I am drawing cell type = 3
DrawDotplot(allCTres, CT = 3, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)
Note: In addition to “hallmark”, the pathway database can also be “kegg” or “reactome”. If you prefer other databases, you can set the `gmtdir=` argument as the directory to the gmt file of another database in `DoGSEA()` function.

```
allCTres <- DoGSEA(exampleRes, whichDB = "kegg", withProp = TRUE)
DrawDotplot(allCTres, CT = 3, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

```
allCTres <- DoGSEA(exampleRes, whichDB = "reactome", withProp = TRUE)
DrawDotplot(allCTres, CT = 3, angle = 15, vjust = 1, chooseP = "padj")
```

![](data:image/png;base64...)

# Session info

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
##  [1] BayesSpace_1.20.0           SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] gridExtra_2.3               RegionalST_1.8.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] spatstat.sparse_3.1-0  bitops_1.0-9           httr_1.4.7
##   [4] RColorBrewer_1.1-3     doParallel_1.0.17      tools_4.5.1
##   [7] sctransform_0.4.2      R6_2.6.1               DirichletReg_0.7-2
##  [10] uwot_0.2.3             lazyeval_0.2.2         rhdf5filters_1.22.0
##  [13] withr_3.0.2            sp_2.2-0               GGally_2.4.0
##  [16] progressr_0.17.0       cli_3.6.5              spatstat.explore_3.5-3
##  [19] fastDummies_1.7.5      microbenchmark_1.5.0   sandwich_3.1-1
##  [22] labeling_0.4.3         sass_0.4.10            Seurat_5.3.1
##  [25] spatstat.data_3.1-9    nnls_1.6               arrow_22.0.0
##  [28] S7_0.2.0               proxy_0.4-27           ggridges_0.5.7
##  [31] pbapply_1.7-4          dichromat_2.0-0.1      scater_1.38.0
##  [34] parallelly_1.45.1      limma_3.66.0           RSQLite_2.4.3
##  [37] spatstat.random_3.4-2  ica_1.0-3              dplyr_1.1.4
##  [40] Matrix_1.7-4           ggbeeswarm_0.7.2       abind_1.4-8
##  [43] lifecycle_1.0.4        yaml_2.3.10            edgeR_4.8.0
##  [46] rhdf5_2.54.0           SparseArray_1.10.0     BiocFileCache_3.0.0
##  [49] Rtsne_0.17             grid_4.5.1             blob_1.2.4
##  [52] promises_1.4.0         dqrng_0.4.1            crayon_1.5.3
##  [55] miniUI_0.1.2           lattice_0.22-7         beachmat_2.26.0
##  [58] cowplot_1.2.0          magick_2.9.0           pillar_1.11.1
##  [61] knitr_1.50             metapod_1.18.0         fgsea_1.36.0
##  [64] rjson_0.2.23           xgboost_1.7.11.1       corpcor_1.6.10
##  [67] future.apply_1.20.0    codetools_0.2-20       fastmatch_1.1-6
##  [70] glue_1.8.0             spatstat.univar_3.1-4  EpiDISH_2.26.0
##  [73] data.table_1.17.8      vctrs_0.6.5            png_0.1-8
##  [76] spam_2.11-1            locfdr_1.1-8           gtable_0.3.6
##  [79] assertthat_0.2.1       cachem_1.1.0           TOAST_1.24.0
##  [82] xfun_0.53              S4Arrays_1.10.0        mime_0.13
##  [85] coda_0.19-4.1          survival_3.8-3         iterators_1.0.14
##  [88] tinytex_0.57           maxLik_1.5-2.1         statmod_1.5.1
##  [91] bluster_1.20.0         fitdistrplus_1.2-4     ROCR_1.0-11
##  [94] nlme_3.1-168           bit64_4.6.0-1          filelock_1.0.3
##  [97] RcppAnnoy_0.0.22       bslib_0.9.0            irlba_2.3.5.1
## [100] vipor_0.4.7            KernSmooth_2.23-26     otel_0.2.0
## [103] colorspace_2.1-2       DBI_1.2.3              tidyselect_1.2.1
## [106] bit_4.6.0              compiler_4.5.1         curl_7.0.0
## [109] httr2_1.2.1            BiocNeighbors_2.4.0    DelayedArray_0.36.0
## [112] plotly_4.11.0          bookdown_0.45          scales_1.4.0
## [115] lmtest_0.9-40          quadprog_1.5-8         rappdirs_0.3.3
## [118] goftest_1.2-3          stringr_1.5.2          digest_0.6.37
## [121] spatstat.utils_3.2-0   rmarkdown_2.30         XVector_0.50.0
## [124] htmltools_0.5.8.1      pkgconfig_2.0.3        dbplyr_2.5.1
## [127] fastmap_1.2.0          rlang_1.1.6            htmlwidgets_1.6.4
## [130] shiny_1.11.1           farver_2.1.2           jquerylib_0.1.4
## [133] zoo_1.8-14             jsonlite_2.0.0         BiocParallel_1.44.0
## [136] mclust_6.1.1           BiocSingular_1.26.0    RCurl_1.98-1.17
## [139] magrittr_2.0.4         Formula_1.2-5          scuttle_1.20.0
## [142] dotCall64_1.2          patchwork_1.3.2        Rhdf5lib_1.32.0
## [145] Rcpp_1.1.0             viridis_0.6.5          reticulate_1.44.0
## [148] stringi_1.8.7          MASS_7.3-65            plyr_1.8.9
## [151] ggstats_0.11.0         parallel_4.5.1         listenv_0.9.1
## [154] ggrepel_0.9.6          deldir_2.0-4           splines_4.5.1
## [157] tensor_1.5.1           locfit_1.5-9.12        igraph_2.2.1
## [160] spatstat.geom_3.6-0    RcppHNSW_0.6.0         reshape2_1.4.4
## [163] ScaledMatrix_1.18.0    evaluate_1.0.5         SeuratObject_5.2.0
## [166] scran_1.38.0           BiocManager_1.30.26    foreach_1.5.2
## [169] httpuv_1.6.16          miscTools_0.6-28       polyclip_1.10-7
## [172] RANN_2.6.2             tidyr_1.3.1            purrr_1.1.0
## [175] future_1.67.0          scattermore_1.2        ggplot2_4.0.0
## [178] rsvd_1.0.5             xtable_1.8-4           e1071_1.7-16
## [181] RSpectra_0.16-2        later_1.4.4            viridisLite_0.4.2
## [184] class_7.3-23           tibble_3.3.0           memoise_2.0.1
## [187] beeswarm_0.4.0         cluster_2.1.8.1        globals_0.18.0
```