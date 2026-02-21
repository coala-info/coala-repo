# Spaniel 10X Visium

#### Rachel Queen

#### 2025-10-30

## About Spaniel

Spaniel is an R package designed to visualise results of Spatial Transcriptomics experiments. The current stable (or kennel!) version of Spaniel is available from Bioconductor:

```
BiocManager::install('Spaniel')
```

### Spaniel - with 10X import option

This vignette refers uses data from a 10X Genomics Visium experiment.

```
library(Spaniel)
library(DropletUtils)
library(scater)
library(scran)
```

## Data

This vignette will show how to load the results of 10X Visium spatial transcriptomics experiment which has been run through the Space Ranger pipeline. The data is distributed as part of the Space Ranger software package which can be downloaded here:

<https://support.10xgenomics.com/spatial-gene-expression/software/overview/welcome>

The output from from the “spaceranger testrun” is used as an example here.

### Import the expression data

Spaniel can directly load the output from SpaceRanger output using the createVisiumSCE function. This imports the gene expression data, spatial barcodes, and image dimensions into the SingleCellExperiment object.

```
pathToTenXOuts <- file.path(system.file(package = "Spaniel"), "extdata/outs")

sce <- createVisiumSCE(tenXDir=pathToTenXOuts,
                            resolution="Low")
```

### SCE Object

The pixel coordinates are added to the colData of the SCE object shown below:

```
colData(sce)[, c("Barcode", "pixel_x", "pixel_y")]
```

```
## DataFrame with 3352 rows and 3 columns
##                 Barcode   pixel_x   pixel_y
##             <character> <numeric> <numeric>
## 1    AAACAAGTATCTCCCA-1   436.575   217.384
## 2    AAACACCAATAACTGC-1   141.480   161.721
## 3    AAACAGAGCGACTCCT-1   408.176   440.086
## 4    AAACAGCTTTCAGAAG-1   105.955   260.706
## 5    AAACAGGGTCTATATT-1   120.155   235.972
## ...                 ...       ...       ...
## 3348 TTGTTCAGTGTGCTAC-1   301.497   378.227
## 3349 TTGTTGTGTGTCAAGA-1   347.711   334.957
## 3350 TTGTTTCACATCCAGG-1   223.270   167.917
## 3351 TTGTTTCATTAGTCTA-1   180.620   155.525
## 3352 TTGTTTCCATACAACT-1   169.931   248.313
```

The image dimensions are added to the metadata of the SCE object:

```
metadata(sce)$ImgDims
```

```
## [1] "599" "600" "Low"
```

The image is stored as a rasterised grob.

```
metadata(sce)$Grob
```

```
## rastergrob[GRID.rastergrob.11]
```

## Quality Control

Assessing the number of genes and number of counts per spot is a useful quality control step. Spaniel allows QC metrics to be viewed on top of the histological image so that any quality issues can be pinpointed. Spots within the tissue region which have a low number of genes or counts may be due to experimental problems which should be addressed. Conversely, spots which lie outside of the tissue and have a high number of counts or large number of genes may indicate that there is background contamination.

### Visualisation

The plotting function allows the use of a binary filter to visualise which spots pass filtering thresholds. We create a filter to show spots where 1 or more gene is detected. Spots where no genes are detected will be removed from the remainder of the analysis.

**NOTE:** The parameters are set for the subset of counts used in this dataset.
The filter thresholds will be experiment specific and should be adjusted as necessary.

```
filter <- sce$detected > 0
spanielPlot(object = sce,
        plotType = "NoGenes",
        showFilter = filter,
        techType = "Visium",
        ptSizeMax = 3)
```

![](data:image/png;base64...)

Spots where no genes are detected can be removed from the remainder of the analysis.

```
sce <- sce[, filter]
```

The filtered data can then be normalised using the “normalize” function from the “scater” package and the expression of selected genes can be viewed on the histological image.

```
sce <- logNormCounts(sce)

gene <- "ENSMUSG00000024843"
p2 <- spanielPlot(object = sce,
        plotType = "Gene",
        gene = "ENSMUSG00000024843",
        techType = "Visium",
        ptSizeMax = 3)

p2
```

![](data:image/png;base64...)

## Cluster Spots

The spots can be clustered based on transcriptomic similarities. There are mulitple single cell clustering methods available. He we use a nearest-neighbor graph based approach available in the scran Bioconductor library.

```
library(scran)
sce <- logNormCounts(sce)
sce <- runPCA(sce)
sce <- runUMAP(sce)
g <- buildSNNGraph(sce, k = 70)

clust <- igraph::cluster_walktrap(g)$membership
sce$clust <- factor(clust)
```

These clusters can be visualised on a UMAP plot:

```
p3 <- plotReducedDim(sce, "UMAP", colour_by="clust")
p3
```

![](data:image/png;base64...)

Or overlaid onto the the tissue section using Spaniel

```
p4 <- spanielPlot(object = sce,
        plotType = "Cluster",
        clusterRes = "clust",
        showFilter = NULL,
        techType = "Visium",
        ptSizeMax = 1, customTitle = "Section A")

p4
```

![](data:image/png;base64...)