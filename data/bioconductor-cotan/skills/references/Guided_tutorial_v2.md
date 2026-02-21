# Guided tutorial to COTAN V.2

Silvia Giulia Galfrè1

1Department of Computer Science, University of Pisa

#### 9 February 2026

#### Package

COTAN 2.10.2

# Contents

* [0.1 Preamble](#preamble)
* [0.2 Introduction](#introduction)
* [0.3 Get the data-set](#get-the-data-set)
* [1 Analytical pipeline](#analytical-pipeline)
  + [1.1 Data cleaning](#data-cleaning)
  + [1.2 COTAN analysis](#cotan-analysis)
  + [1.3 Automatic run](#automatic-run)
* [2 Analysis of the elaborated data](#analysis-of-the-elaborated-data)
  + [2.1 `GDI`](#gdi)
  + [2.2 Heatmaps](#heatmaps)
  + [2.3 Get data tables](#get-data-tables)
  + [2.4 Establishing genes’ clusters](#establishing-genes-clusters)
  + [2.5 Uniform Clustering](#uniform-clustering)
  + [2.6 Vignette clean-up stage](#vignette-clean-up-stage)

## 0.1 Preamble

```
library(COTAN)
library(zeallot)

# necessary to solve precedence of overloads
conflicted::conflict_prefer("%<-%", "zeallot")

options(parallelly.fork.enable = TRUE)
```

## 0.2 Introduction

This tutorial contains the same functionalities as the first release of the
COTAN tutorial but done using the new and updated functions.

## 0.3 Get the data-set

Download the data-set for `"mouse cortex E17.5"`.

```
dataDir <- tempdir()
print(dataDir)
#> [1] "/tmp/RtmpzZHjz1"

GEO <- "GSM2861514"
fName <- "GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz"

dataSetFile <- file.path(dataDir, GEO, fName)

dir.create(file.path(dataDir, GEO), showWarnings = FALSE)

if (!file.exists(dataSetFile)) {
  GEOquery::getGEOSuppFiles(
    GEO,
    makeDirectory = TRUE,
    baseDir = dataDir,
    fetch_files = TRUE,
    filter_regex = fName
  )
}
#> Setting options('download.file.method.GEOquery'='auto')
#> Setting options('GEOquery.inmemory.gpl'=FALSE)
#>                                                                              size
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz 1509523
#>                                                                           isdir
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz FALSE
#>                                                                           mode
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz  644
#>                                                                                         mtime
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz 2026-02-09 17:23:15
#>                                                                                         ctime
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz 2026-02-09 17:23:15
#>                                                                                         atime
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz 2026-02-09 17:23:15
#>                                                                            uid
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz 1002
#>                                                                            gid
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz 1002
#>                                                                               uname
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz biocbuild
#>                                                                              grname
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz biocbuild
#>                                                                                                                    fname
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz
#>                                                                                              destdir
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz /tmp/RtmpzZHjz1/GSM2861514
#>                                                                                                                                            filepath
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz
#>                                                                                  GEO
#> /tmp/RtmpzZHjz1/GSM2861514/GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz GSM2861514

sample.dataset <- read.csv(dataSetFile, sep = "\t", row.names = 1L)
```

Define a directory where the output will be stored.

```
outDir <- dataDir

# Log-level 2 was chosen to showcase better how the package works
# In normal usage a level of 0 or 1 is more appropriate
setLoggingLevel(2L)
#> Setting new log level to 2

# This file will contain all the logs produced by the package
# as if at the highest logging level
setLoggingFile(file.path(outDir, "vignette_v2.log"))
#> Setting log file to be: /tmp/RtmpzZHjz1/vignette_v2.log

message("COTAN uses the `torch` library when asked to `optimizeForSpeed`")
#> COTAN uses the `torch` library when asked to `optimizeForSpeed`
message("Run the command 'options(COTAN.UseTorch = FALSE)'",
        " in your session to disable `torch` completely!")
#> Run the command 'options(COTAN.UseTorch = FALSE)' in your session to disable `torch` completely!

# this command does check whether the torch library is properly installed
c(useTorch, deviceStr) %<-% COTAN:::canUseTorch(TRUE, "cuda")
#> While trying to load the `torch` library Error in doTryCatch(return(expr), name, parentenv, handler): The `torch` library is installed but the required additional libraries are not available yet
#> Warning in value[[3L]](cond): The `torch` library is installed, but might
#> require further initialization
#> Warning in value[[3L]](cond): Please look at the `torch` package installation
#> guide to complete the installation
#> Warning in COTAN:::canUseTorch(TRUE, "cuda"): Falling back to legacy
#> [non-torch] code.
if (useTorch) {
  message("The `torch` library is available and ready to use")
  if (deviceStr == "cuda") {
    message("The `torch` library can use the `CUDA` GPU")
  } else {
    message("The `torch` library can only use the CPU")
    message("Please ensure you have the `OpenBLAS` libraries",
            " installed on the system")
  }
}

rm(useTorch, deviceStr)
```

# 1 Analytical pipeline

Initialize the `COTAN` object with the row count table and
the metadata for the experiment.

```
cond <- "mouse_cortex_E17.5"

obj <- COTAN(raw = sample.dataset)
obj <-
  initializeMetaDataset(
    obj,
    GEO = GEO,
    sequencingMethod = "Drop_seq",
    sampleCondition = cond
  )
#> Initializing `COTAN` meta-data

logThis(paste0("Condition ", getMetadataElement(obj, datasetTags()[["cond"]])),
        logLevel = 1L)
#> Condition mouse_cortex_E17.5
```

Before we proceed to the analysis, we need to clean the data.
The analysis will use a matrix of raw `UMI` counts as the input.
To obtain this matrix, we have to remove any potential cell doublets or
multiplets, as well as any low quality or dying cells.

## 1.1 Data cleaning

We can check the library size (`UMI` number) with an *Empirical Cumulative
Distribution* function

```
plot(ECDPlot(obj))
```

![](data:image/png;base64...)

```
plot(cellSizePlot(obj))
```

![](data:image/png;base64...)

```
plot(genesSizePlot(obj))
```

![](data:image/png;base64...)

```
plot(scatterPlot(obj))
```

![](data:image/png;base64...)

During the cleaning, every time we want to remove cells or genes
we can use the `dropGenesCells()`function.

Drop cells with too many reads as they are probably doublets or multiplets

```
cellsSizeThr <- 6000L
obj <- addElementToMetaDataset(obj, "Cells size threshold", cellsSizeThr)

cells_to_rem <- getCells(obj)[getCellsSize(obj) > cellsSizeThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

plot(cellSizePlot(obj))
```

![](data:image/png;base64...)

To drop cells by gene number: high genes count might also indicate doublets…

```
genesSizeHighThr <- 3000L
obj <-
  addElementToMetaDataset(obj, "Num genes high threshold", genesSizeHighThr)

cells_to_rem <- getCells(obj)[getNumExpressedGenes(obj) > genesSizeHighThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

plot(genesSizePlot(obj))
```

![](data:image/png;base64...)

Drop cells with too low genes expression as they are probably dead

```
genesSizeLowThr <- 500L
obj <- addElementToMetaDataset(obj, "Num genes low threshold", genesSizeLowThr)

cells_to_rem <- getCells(obj)[getNumExpressedGenes(obj) < genesSizeLowThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

plot(genesSizePlot(obj))
```

![](data:image/png;base64...)

Cells with a too high percentage of mitochondrial genes are
likely dead (or at the last problematic) cells. So we drop them!

```
c(mitPlot, mitSizes) %<-%
  mitochondrialPercentagePlot(obj, genePrefix = "^Mt")

plot(mitPlot)
```

![](data:image/png;base64...)

```
mitPercThr <- 1.0
obj <- addElementToMetaDataset(obj, "Mitoc. perc. threshold", mitPercThr)

cells_to_rem <- rownames(mitSizes)[mitSizes[["mit.percentage"]] > mitPercThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

c(mitPlot, mitSizes) %<-%
  mitochondrialPercentagePlot(obj, genePrefix = "^Mt")

plot(mitPlot)
```

![](data:image/png;base64...)

If we do not want to consider the mitochondrial genes we can remove them
before starting the analysis.

```
genes_to_rem <- getGenes(obj)[grep("^Mt", getGenes(obj))]
cells_to_rem <- getCells(obj)[which(getCellsSize(obj) == 0L)]

obj <- dropGenesCells(obj, genes_to_rem, cells_to_rem)
```

We want also to log the current status.

```
logThis(paste("n cells", getNumCells(obj)), logLevel = 1L)
#> n cells 859
```

The `clean()` function estimates all the parameters for the data. Therefore, we have to run it again every time we remove any genes or cells from the data.

```
obj <- addElementToMetaDataset(obj, "Num drop B group", 0L)

obj <- clean(obj)
#> Genes/cells selection done: dropped [4787] genes and [0] cells
#> Working on [12235] genes and [859] cells

c(pcaCellsPlot, pcaCellsData, genesPlot,
  UDEPlot, nuPlot, zoomedNuPlot) %<-% cleanPlots(obj)
#> Clean plots: START
#> PCA: START
#> PCA: DONE
#> Hierarchical clustering: START
#> Hierarchical clustering: DONE
#> Total calculations elapsed time: 2.39831686019897
#> Clean plots: DONE

plot(pcaCellsPlot)
```

![](data:image/png;base64...)

```
plot(genesPlot)
```

![](data:image/png;base64...)

We can observe here that the red cells are really enriched in hemoglobin genes so we prefer to remove them. They can be extracted from the `pcaCellsData` object and removed.

```
cells_to_rem <- rownames(pcaCellsData)[pcaCellsData[["groups"]] == "B"]
obj <- dropGenesCells(obj, cells = cells_to_rem)

obj <- addElementToMetaDataset(obj, "Num drop B group", 1L)

obj <- clean(obj)
#> Genes/cells selection done: dropped [5] genes and [0] cells
#> Working on [12230] genes and [855] cells

c(pcaCellsPlot, pcaCellsData, genesPlot,
  UDEPlot, nuPlot, zoomedNuPlot) %<-% cleanPlots(obj)
#> Clean plots: START
#> PCA: START
#> PCA: DONE
#> Hierarchical clustering: START
#> Hierarchical clustering: DONE
#> Total calculations elapsed time: 2.42773079872131
#> Clean plots: DONE

plot(pcaCellsPlot)
```

![](data:image/png;base64...)

To color the PCA based on `nu` (so the cells’ efficiency)

```
plot(UDEPlot)
```

![](data:image/png;base64...)

`UDE` (color) should not correlate with principal components! This is very important.

The next part is used to remove the cells with efficiency too low.

```
plot(nuPlot)
```

![](data:image/png;base64...)

We can zoom on the smallest values and, if COTAN detects a clear elbow,
we can decide to remove the cells.

```
plot(zoomedNuPlot)
```

![](data:image/png;base64...)

We also save the defined threshold in the metadata and re-run the estimation

```
UDELowThr <- 0.30
obj <- addElementToMetaDataset(obj, "Low UDE cells' threshold", UDELowThr)

obj <- addElementToMetaDataset(obj, "Num drop B group", 2L)

obj <- estimateNuLinear(obj)

cells_to_rem <- getCells(obj)[getNu(obj) < UDELowThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)
```

Repeat the estimation after the cells are removed

```
obj <- clean(obj)
#> Genes/cells selection done: dropped [3] genes and [0] cells
#> Working on [12227] genes and [852] cells

c(pcaCellsPlot, pcaCellsData, genesPlot,
  UDEPlot, nuPlot, zoomedNuPlot) %<-% cleanPlots(obj)
#> Clean plots: START
#> PCA: START
#> PCA: DONE
#> Hierarchical clustering: START
#> Hierarchical clustering: DONE
#> Total calculations elapsed time: 2.24725747108459
#> Clean plots: DONE

plot(pcaCellsPlot)
```

![](data:image/png;base64...)

```
plot(scatterPlot(obj))
```

![](data:image/png;base64...)

```
logThis(paste("n cells", getNumCells(obj)), logLevel = 1L)
#> n cells 852
```

## 1.2 COTAN analysis

In this part, all the contingency tables are computed
and used to get the statistics necessary to `COEX` evaluation and storing

```
obj <-
  proceedToCoex(
    obj,
    calcCoex = TRUE,
    optimizeForSpeed = TRUE,
    cores = 6L,
    deviceStr = "cuda",
    saveObj = FALSE,
    outDir = outDir
  )
#> COTAN dataset analysis: START
#> Genes/cells selection done: dropped [0] genes and [0] cells
#> Working on [12227] genes and [852] cells
#> Estimate `dispersion`: START
#> Total calculations elapsed time: 7.10992789268494
#> Estimate `dispersion`: DONE
#> Estimate `dispersion`: DONE
#> `dispersion` | min: -0.0568524754802774 | max: 372.730736317784 | % negative: 19.5469043919195
#> COTAN genes' COEX estimation: START
#> While trying to load the `torch` library Error in doTryCatch(return(expr), name, parentenv, handler): The `torch` library is installed but the required additional libraries are not available yet
#> Warning in canUseTorch(optimizeForSpeed, deviceStr): Falling back to legacy
#> [non-torch] code.
#> Calculate genes' COEX (legacy): START
#> Warning in asMethod(object): sparse->dense coercion: allocating vector of size
#> 1.1 GiB
#> Total calculations elapsed time: 168.140454530716
#> Calculate genes' COEX (legacy): DONE
#> COTAN dataset analysis: DONE
```

When `saveObj == TRUE`, in the previous step, this step can be skipped
as the `COTAN` object has already been saved in the `outDir`.

```
# saving the structure
saveRDS(obj, file = file.path(outDir, paste0(cond, ".cotan.RDS")))
```

## 1.3 Automatic run

It is also possible to run directly a single function
if we don’t want to clean anything.

```
obj2 <-
  automaticCOTANObjectCreation(
    raw = sample.dataset,
    GEO = GEO,
    sequencingMethod = "Drop_seq",
    sampleCondition = cond,
    calcCoex = TRUE,
    cores = 6L,
    optimizeForSpeed = TRUE,
    saveObj = TRUE,
    outDir = outDir
  )
```

# 2 Analysis of the elaborated data

## 2.1 `GDI`

To calculate and store the Global Differentiation Index (`GDI`) we can run:

```
gdiDF <- calculateGDI(obj)
#> Calculate GDI dataframe: START
#> Calculate `GDI`: START
#> Total calculations elapsed time: 17.3177371025085
#> Calculate `GDI`: DONE
#> Total calculations elapsed time: 25.7488348484039
#> Calculate GDI dataframe: DONE

head(gdiDF)
#>               sum.raw.norm      GDI exp.cells
#> 0610007N19Rik     3.332671 1.626623  2.230047
#> 0610007P14Rik     5.279001 1.349528 18.779343
#> 0610009B22Rik     4.733316 1.281519 11.619718
#> 0610009D07Rik     6.313149 1.364263 43.427230
#> 0610009E02Rik     2.590242 1.016344  1.173709
#> 0610009L18Rik     3.509489 1.256799  3.051643

# This will store only the $GDI column
obj <- storeGDI(obj, genesGDI = gdiDF)
```

The next function can either plot the `GDI` for the dataset directly or
use the pre-computed dataframe.

It marks the given threshold 1.43 (in red) and
the 50% and 75% quantiles (in blue).
We can also specify some gene sets (three in this case) that
we want to label explicitly in the `GDI` plot.

```
genesList <- list(
  "NPGs" = c("Nes", "Vim", "Sox2", "Sox1", "Notch1", "Hes1", "Hes5", "Pax6"),
  "PNGs" = c("Map2", "Tubb3", "Neurod1", "Nefm", "Nefl", "Dcx", "Tbr1"),
  "hk"   = c("Calm1", "Cox6b1", "Ppia", "Rpl18", "Cox7c", "Erh", "H3f3a",
             "Taf1", "Taf2", "Gapdh", "Actb", "Golph3", "Zfr", "Sub1",
             "Tars", "Amacr")
)

GDIPlot(obj, cond = cond, genes = genesList, GDIThreshold = 1.40)
#> GDI plot
#> Removed 0 low GDI genes (such as the fully-expressed) in GDI plot
```

![](data:image/png;base64...)

The percentage of cells expressing the gene in the third column of this
data-frame is reported.

## 2.2 Heatmaps

To perform the Gene Pair Analysis, we can plot a heatmap of the `COEX` values
between two gene sets.
We have to define the different gene sets (`list.genes`) in a list.
Then we can choose which sets to use in the function parameter sets
(for example, from 1 to 3).
We also have to provide an array of the file name prefixes for each condition
(for example, “mouse\_cortex\_E17.5”).
In fact, this function can plot genes relationships across many different
conditions to get a complete overview.

```
plot(heatmapPlot(obj, genesLists = genesList))
#> Heatmap plot: START
#> Hangling COTAN object with condition: mouse_cortex_E17.5
#> calculating PValues: START
#> Get p-values on a set of genes on columns and on a set of genes on rows
#> Total calculations elapsed time: 3.81258916854858
#> calculating PValues: DONE
#> min COEX: -0.475093155067069 max COEX: 0.456661719735678
#> Total calculations elapsed time: 3.90409517288208
#> Heatmap plot: DONE
```

![](data:image/png;base64...)

We can also plot a general heatmap of `COEX` values based on some markers like
the following one.

```
invisible(
  genesHeatmapPlot(
    obj,
    primaryMarkers = c("Satb2", "Bcl11b", "Vim", "Hes1"),
    pValueThreshold = 0.001,
    symmetric = TRUE
  )
)
#> calculating PValues: START
#> Get p-values genome wide on columns and genome wide on rows
#> Total calculations elapsed time: 51.3843870162964
#> calculating PValues: DONE
```

![](data:image/png;base64...)

```
invisible(
  genesHeatmapPlot(
    obj,
    primaryMarkers = c("Satb2", "Bcl11b", "Fezf2"),
    secondaryMarkers = c("Gabra3", "Meg3", "Cux1", "Neurod6"),
    pValueThreshold = 0.001,
    symmetric = FALSE
  )
)
```

## 2.3 Get data tables

Sometimes we can also be interested in the numbers present directly in the
contingency tables for two specific genes. To get them we can use two functions:

`contingencyTables()` to produce the observed and expected data

```
print("Contingency Tables:")
#> [1] "Contingency Tables:"
contingencyTables(obj, g1 = "Satb2", g2 = "Bcl11b")
#> $observed
#>            Satb2.yes Satb2.no
#> Bcl11b.yes        47      149
#> Bcl11b.no        287      369
#>
#> $expected
#>            Satb2.yes Satb2.no
#> Bcl11b.yes  82.78517 113.2149
#> Bcl11b.no  251.21484 404.7851

print("Corresponding Coex")
#> [1] "Corresponding Coex"
getGenesCoex(obj)["Satb2", "Bcl11b"]
#> [1] -0.2027999
```

Another useful function is `getGenesCoex()`. This can be used to extract
the whole or a partial `COEX` matrix from a `COTAN` object.

```
# For the whole matrix
coex <- getGenesCoex(obj, zeroDiagonal = FALSE)
coex[1000L:1005L, 1000L:1005L]
#> 6 x 6 Matrix of class "dspMatrix"
#>             Ap3s1       Ap3s2        Ap4b1       Ap4e1       Ap4m1        Ap4s1
#> Ap3s1  0.91871850 -0.02997450  0.028067281 -0.02866164  0.01372373 -0.032403827
#> Ap3s2 -0.02997450  0.91458950 -0.045829648 -0.03058684 -0.05045263  0.095313445
#> Ap4b1  0.02806728 -0.04582965  0.908003544 -0.03650665  0.02944893  0.009053801
#> Ap4e1 -0.02866164 -0.03058684 -0.036506649  0.82865284 -0.04320217 -0.025652861
#> Ap4m1  0.01372373 -0.05045263  0.029448930 -0.04320217  0.91486698  0.047203197
#> Ap4s1 -0.03240383  0.09531345  0.009053801 -0.02565286  0.04720320  0.908148636
```

```
# For a partial matrix
coex <- getGenesCoex(obj, genes = c("Satb2", "Bcl11b", "Fezf2"))
coex[1000L:1005L, ]
#> 6 x 3 Matrix of class "dgeMatrix"
#>            Bcl11b        Fezf2       Satb2
#> Ap3s1 -0.04615332 -0.003501017  0.01372442
#> Ap3s2  0.01280834  0.026726976  0.01784030
#> Ap4b1  0.04063330  0.010722389 -0.03173056
#> Ap4e1 -0.05291251 -0.015076649 -0.03450755
#> Ap4m1  0.05811967  0.020840590 -0.03964031
#> Ap4s1 -0.06858311  0.006086739 -0.01587822
```

## 2.4 Establishing genes’ clusters

`COTAN` provides a way to establish genes’ clusters given some lists of markers

```
layersGenes <- list(
  "L1"   = c("Reln",   "Lhx5"),
  "L2/3" = c("Satb2",  "Cux1"),
  "L4"   = c("Rorb",   "Sox5"),
  "L5/6" = c("Bcl11b", "Fezf2"),
  "Prog" = c("Vim",    "Hes1", "Dummy")
)
c(gSpace, eigPlot, pcaGenesClDF, treePlot) %<-%
  establishGenesClusters(
    obj,
    groupMarkers = layersGenes,
    numGenesPerMarker = 25L,
    kCuts = 5
  )
#> Establishing gene clusters - START
#> Calculating gene co-expression space - START
#> calculating PValues: START
#> Get p-values on a set of genes on columns and genome wide on rows
#> Total calculations elapsed time: 4.56199240684509
#> calculating PValues: DONE
#> Number of selected secondary markers: 184
#> Calculate `GDI`: START
#> Total calculations elapsed time: 0.232265472412109
#> Calculate `GDI`: DONE
#> Total calculations elapsed time: 10.4804980754852
#> Calculating gene co-expression space - DONE
#> Total calculations elapsed time: 10.9454569816589
#> Establishing gene clusters - DONE

plot(eigPlot)
```

![](data:image/png;base64...)

```
plot(treePlot)
```

![](data:image/png;base64...)

```
colSelection <- vapply(pcaGenesClDF, is.numeric, logical(1L))
genesUmapPl <-
  UMAPPlot(
    pcaGenesClDF[, colSelection, drop = FALSE],
    clusters = getColumnFromDF(pcaGenesClDF, "hclust"),
    elements = layersGenes,
    title = "Genes' clusters UMAP Plot",
    numNeighbors = 32L,
    minPointsDist = 0.25
  )
#> UMAP plot: START
#> 17:28:41 UMAP embedding parameters a = 1.121 b = 1.057
#> 17:28:41 Read 1223 rows and found 12 numeric columns
#> 17:28:41 Using Annoy for neighbor search, n_neighbors = 32
#> 17:28:41 Building Annoy index with metric = cosine, n_trees = 50
#> 0%   10   20   30   40   50   60   70   80   90   100%
#> [----|----|----|----|----|----|----|----|----|----|
#> **************************************************|
#> 17:28:41 Writing NN index file to temp file /tmp/RtmpzZHjz1/file977d674e059e
#> 17:28:41 Searching Annoy index using 1 thread, search_k = 3200
#> 17:28:42 Annoy recall = 100%
#> 17:28:43 Commencing smooth kNN distance calibration using 1 thread with target n_neighbors = 32
#> 17:28:44 Initializing from normalized Laplacian + noise (using RSpectra)
#> 17:28:44 Commencing optimization for 500 epochs, with 50900 positive edges
#> 17:28:44 Using rng type: pcg
#> 17:28:47 Optimization finished
#> Total calculations elapsed time: 6.00430488586426
#> UMAP plot: DONE

plot(genesUmapPl)
```

![](data:image/png;base64...)

## 2.5 Uniform Clustering

It is possible to obtain a cell clusterization based on the concept of
*uniformity* of expression of the genes across the cells.
That is the cluster satisfies the null hypothesis of the `COTAN` model:
the genes expression is not dependent on the cell in consideration.

There are two functions involved into obtaining a proper clusterization:
the first is `cellsUniformClustering` that uses standard tools clusterization
methods, but then discards and re-clusters any *non-uniform* cluster.

Please note that the most important parameters for the users are the
`GDIThreshold`s inside the **Uniform Transcript** checkers: they define how
strict is the check. Default constructed advance check gives a pretty strong
guarantee of uniformity for the *cluster*.

```
# This code is a little too computationally heavy to be used in an example
# So we stored the result and we can load it in the next section

# default constructed checker is OK
advChecker <- new("AdvancedGDIUniformityCheck")

c(splitClusters, splitCoexDF) %<-%
  cellsUniformClustering(
    obj,
    initialResolution = 0.8,
    checker = advChecker,
    optimizeForSpeed = TRUE,
    deviceStr = "cuda",
    cores = 6L,
    genesSel = "HGDI",
    saveObj = TRUE,
    outDir = outDir
  )

obj <-
  addClusterization(
    obj,
    clName = "split",
    clusters = splitClusters,
    coexDF = splitCoexDF
  )

table(splitClusters)
```

In the case one already has an existing *clusterization*, it is possible to
calculate the *DEA* `data.frame` and add it to the `COTAN` object.

```
data("vignette.split.clusters", package = "COTAN")
splitClusters <- vignette.split.clusters[getCells(obj)]

splitCoexDF <- DEAOnClusters(obj, clusters = splitClusters)
#> Differential Expression Analysis - START
#> **********
#> Total calculations elapsed time: 0.423825740814209
#> Differential Expression Analysis - DONE

obj <-
  addClusterization(
    obj,
    clName = "split",
    clusters = splitClusters,
    coexDF = splitCoexDF,
    override = FALSE
  )
```

It is possible to have some statistics about the *clusterization*

```
c(summaryData, summaryPlot) %<-%
  clustersSummaryPlot(
    obj,
    clName = "split",
    plotTitle = "split summary"
  )

summaryData
#>    split NoCond CellNumber CellPercentage MeanUDE MedianUDE ExpGenes25 ExpGenes
#> 1     -1 NoCond         82            9.6    1.09      1.10       1688    10626
#> 2      1 NoCond         69            8.1    1.01      0.91       1469    10620
#> 3      2 NoCond         27            3.2    1.74      1.78       2998     9594
#> 4      3 NoCond        153           18.0    0.62      0.59        865    10675
#> 5      4 NoCond         44            5.2    0.86      0.81       1287     9042
#> 6      5 NoCond        196           23.0    0.75      0.76       1133    11053
#> 7      6 NoCond        126           14.8    1.46      1.38       2248    11322
#> 8      7 NoCond         55            6.5    0.45      0.44        488     8826
#> 9      8 NoCond         52            6.1    1.91      1.94       2807    10627
#> 10     9 NoCond         48            5.6    1.20      1.18       1834     9763
```

The `ExpGenes` column contains the number of genes that are expressed in any
cell of the relevant *cluster*, while the `ExpGenes25` column contains the number of genes expressed in at the least 25% of the cells of the relevant *cluster*

```
plot(summaryPlot)
```

![](data:image/png;base64...)

It is possible to visualize how relevant are the *marker genes’* `lists` with
respect to the given *clusterization*

```
c(splitHeatmap, scoreDF, pValueDF) %<-%
  clustersMarkersHeatmapPlot(
    obj,
    groupMarkers = layersGenes,
    clName = "split",
    kCuts = 5L,
    adjustmentMethod = "holm"
  )

ComplexHeatmap::draw(splitHeatmap)
```

![](data:image/png;base64...)

Since the algorithm that creates the *clusters* is not directly geared to
achieve cluster uniformity, there might be some *clusters* that can be merged
back together and still be **uniform**.

This is the purpose of the function `mergeUniformCellsClusters` that takes a
*clusterization* and tries to merge cluster pairs after checking that together
the pair forms a uniform cluster.

In order to avoid running the totality of the possible checks (as it can explode
quickly with the number of *clusters*), the function relies on a *related*
distance the find the cluster pairs that have the highest chance to be merged.

```
c(mergedClusters, mergedCoexDF) %<-%
  mergeUniformCellsClusters(
    obj,
    clusters = splitClusters,
    checkers = advChecker,
    optimizeForSpeed = TRUE,
    deviceStr = "cuda",
    cores = 6L,
    saveObj = TRUE,
    outDir = outDir
  )

# merges are:
#  1 <- 06 + 07
#  2 <- '-1' + 08 + 11
#  3 <- 09
#  4 <- 01
#  5 <- 02
#  6 <- 12
#  7 <- 03 + 04 + 10 + 13
#  8 <- 05

obj <-
  addClusterization(
    obj,
    clName = "merge",
    override = TRUE,
    clusters = mergedClusters,
    coexDF = mergedCoexDF
  )

table(mergedClusters)
```

Again, here, the most important parameters for the users are the `GDIThreshold`s
inside the **Uniform Transcript** checkers: they define how strict is the
check. Default constructed advance check gives a pretty strong guarantee of
uniformity for the *cluster*. If one wants to achieve a more *relaxed* merge,
it is possible to define a sequence of checkers, each less stringent than the
previous, that will be applied sequentially: First all the merges with the
stricter checker are performed, than those that satisfy the second, and so on.

```
checkersList <-
  list(
    advChecker,
    shiftCheckerThresholds(advChecker, 0.01),
    shiftCheckerThresholds(advChecker, 0.03)
  )

prevCheckRes <- data.frame()

# In this case we want to re-use the already calculated merge checks
# Se we reload them from the output files. This, along a similar facility for
# the split method, is also useful in the cases the execution is interrupted
# prematurely...
#
if (TRUE) {
  # read from the last file among those named all_check_results_XX.csv
  mergeDir <- file.path(outDir, cond, "leafs_merge")
  resFiles <-
    list.files(
      path = mergeDir,
      pattern = "all_check_results_.*csv",
      full.names = TRUE
    )

  prevCheckRes <-
    read.csv(resFiles[length(resFiles)], header = TRUE, row.names = 1L)
}

c(mergedClusters2, mergedCoexDF2) %<-%
  mergeUniformCellsClusters(
    obj,
    clusters = splitClusters,
    checkers = checkersList,
    allCheckResults = prevCheckRes,
    optimizeForSpeed = TRUE,
    deviceStr = "cuda",
    cores = 6L,
    saveObj = TRUE,
    outDir = outDir
  )

# merges are:
#  1 <- '-1' + 06 + 09
#  2 <- 07
#  3 <- 03  + 04 + 10 + 13
#  4 <- 12
#  5 <- 01 + 08 + 11
#  6 <- 02 + 05

obj <-
  addClusterization(
    obj,
    clName = "merge2",
    override = TRUE,
    clusters = mergedClusters2,
    coexDF = mergedCoexDF2
  )

table(mergedClusters2)
```

In the case one already has existing *clusterizations*, it is possible to
calculate their *DEA* `data.frame` and add them to the `COTAN` object.

```
data("vignette.merge.clusters", package = "COTAN")
mergedClusters <- vignette.merge.clusters[getCells(obj)]

mergedCoexDF <- DEAOnClusters(obj, clusters = mergedClusters)
#> Differential Expression Analysis - START
#> *******
#> Total calculations elapsed time: 0.390574932098389
#> Differential Expression Analysis - DONE

obj <-
  addClusterization(
    obj,
    clName = "merge",
    clusters = mergedClusters,
    coexDF = mergedCoexDF,
    override = FALSE
  )

data("vignette.merge2.clusters", package = "COTAN")
mergedClusters2 <- vignette.merge2.clusters[getCells(obj)]

mergedCoexDF2 <- DEAOnClusters(obj, clusters = mergedClusters2)
#> Differential Expression Analysis - START
#> ****
#> Total calculations elapsed time: 0.378765821456909
#> Differential Expression Analysis - DONE

obj <-
  addClusterization(
    obj,
    clName = "merge2",
    clusters = mergedClusters2,
    coexDF = mergedCoexDF2,
    override = FALSE
  )

table(mergedClusters2, mergedClusters)
#>                mergedClusters
#> mergedClusters2   1   2   3   4   5   6   7
#>               1 151   0   0   0   0   0   0
#>               2   0 153  44   0 196   0   0
#>               3   0   0   0 153   0   0 100
#>               4   0   0   0   0   0  55   0
```

Here is possible to visualize how the `split` clusters are merged in to
`merge` and `merge2`

```
c(mergeHeatmap, mergeScoresDF, mergePValuesDF) %<-%
  clustersMarkersHeatmapPlot(
    obj,
    clName = "merge",
    condNameList = "split",
    conditionsList = list(splitClusters)
  )

ComplexHeatmap::draw(mergeHeatmap)
```

![](data:image/png;base64...)

```
c(merge2Heatmap, merge2ScoresDF, merge2PValuesDF) %<-%
  clustersMarkersHeatmapPlot(
    obj,
    clName = "merge2",
    condNameList = "split",
    conditionsList = list(splitClusters)
  )

ComplexHeatmap::draw(merge2Heatmap)
```

![](data:image/png;base64...)

In the following graph, it is possible to check that the found clusters align
very well to the expression of the layers’ genes defined above…

It is possible to plot the *clusterization* on a `UMAP` plot

```
c(umapPlot, cellsRDM) %<-%
  cellsUMAPPlot(
    obj,
    clName = "merge2",
    clusters = NULL,
    useCoexEigen = TRUE,
    dataMethod = "LogLikelihood",
    numComp = 50L,
    genesSel = "HGDI",
    numGenes = 200L,
    colors = NULL,
    numNeighbors = 30L,
    minPointsDist = 0.3
  )
#> Elaborating Reduced dimensionality Data Matrix - START
#> Total calculations elapsed time: 49.4122762680054
#> Elaborating Reduced dimensionality Data Matrix - DONE
#> UMAP plot: START
#> 17:29:45 UMAP embedding parameters a = 0.9922 b = 1.112
#> 17:29:45 Read 852 rows and found 50 numeric columns
#> 17:29:45 Using Annoy for neighbor search, n_neighbors = 30
#> 17:29:45 Building Annoy index with metric = cosine, n_trees = 50
#> 0%   10   20   30   40   50   60   70   80   90   100%
#> [----|----|----|----|----|----|----|----|----|----|
#> **************************************************|
#> 17:29:45 Writing NN index file to temp file /tmp/RtmpzZHjz1/file977d66b659e5
#> 17:29:45 Searching Annoy index using 1 thread, search_k = 3000
#> 17:29:46 Annoy recall = 100%
#> 17:29:47 Commencing smooth kNN distance calibration using 1 thread with target n_neighbors = 30
#> 17:29:48 Initializing from normalized Laplacian + noise (using RSpectra)
#> 17:29:48 Commencing optimization for 500 epochs, with 41324 positive edges
#> 17:29:48 Using rng type: pcg
#> 17:29:51 Optimization finished
#> Total calculations elapsed time: 5.51467490196228
#> UMAP plot: DONE

plot(umapPlot)
#> Warning: No shared levels found between `names(values)` of the manual scale and the
#> data's fill values.
```

![](data:image/png;base64...)

## 2.6 Vignette clean-up stage

The next few lines are just to clean.

```
if (file.exists(file.path(outDir, paste0(cond, ".cotan.RDS")))) {
  #Delete file if it exists
  file.remove(file.path(outDir, paste0(cond, ".cotan.RDS")))
}
if (file.exists(file.path(outDir, paste0(cond, "_times.csv")))) {
  #Delete file if it exists
  file.remove(file.path(outDir, paste0(cond, "_times.csv")))
}
if (dir.exists(file.path(outDir, cond))) {
  unlink(file.path(outDir, cond), recursive = TRUE)
}
if (dir.exists(file.path(outDir, GEO))) {
  unlink(file.path(outDir, GEO), recursive = TRUE)
}

# stop logging to file
setLoggingFile("")
#> Closing previous log file - Setting log file to be:
file.remove(file.path(outDir, "vignette_v2.log"))
#> [1] TRUE

options(parallelly.fork.enable = FALSE)
```

```
Sys.time()
#> [1] "2026-02-09 17:29:51 EST"
```

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] zeallot_0.2.0    COTAN_2.10.2     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.23            splines_4.5.2
#>   [3] later_1.4.5                 tibble_3.3.1
#>   [5] polyclip_1.10-7             XML_3.99-0.20
#>   [7] fastDummies_1.7.5           httr2_1.2.2
#>   [9] lifecycle_1.0.5             doParallel_1.0.17
#>  [11] processx_3.8.6              globals_0.19.0
#>  [13] lattice_0.22-9              MASS_7.3-65
#>  [15] ggdist_3.3.3                dendextend_1.19.1
#>  [17] magrittr_2.0.4              limma_3.66.0
#>  [19] plotly_4.12.0               sass_0.4.10
#>  [21] rmarkdown_2.30              jquerylib_0.1.4
#>  [23] yaml_2.3.12                 httpuv_1.6.16
#>  [25] otel_0.2.0                  Seurat_5.4.0
#>  [27] sctransform_0.4.3           spam_2.11-3
#>  [29] sp_2.2-0                    spatstat.sparse_3.1-0
#>  [31] reticulate_1.44.1           cowplot_1.2.0
#>  [33] pbapply_1.7-4               RColorBrewer_1.1-3
#>  [35] abind_1.4-8                 Rtsne_0.17
#>  [37] GenomicRanges_1.62.1        purrr_1.2.1
#>  [39] BiocGenerics_0.56.0         coro_1.1.0
#>  [41] rappdirs_0.3.4              torch_0.16.3
#>  [43] circlize_0.4.17             IRanges_2.44.0
#>  [45] S4Vectors_0.48.0            ggrepel_0.9.6
#>  [47] irlba_2.3.7                 listenv_0.10.0
#>  [49] spatstat.utils_3.2-1        rentrez_1.2.4
#>  [51] goftest_1.2-3               RSpectra_0.16-2
#>  [53] spatstat.random_3.4-4       fitdistrplus_1.2-6
#>  [55] parallelly_1.46.1           codetools_0.2-20
#>  [57] DelayedArray_0.36.0         xml2_1.5.2
#>  [59] tidyselect_1.2.1            shape_1.4.6.1
#>  [61] farver_2.1.2                ScaledMatrix_1.18.0
#>  [63] viridis_0.6.5               matrixStats_1.5.0
#>  [65] stats4_4.5.2                spatstat.explore_3.7-0
#>  [67] Seqinfo_1.0.0               jsonlite_2.0.0
#>  [69] GetoptLong_1.1.0            progressr_0.18.0
#>  [71] ggridges_0.5.7              survival_3.8-6
#>  [73] iterators_1.0.14            foreach_1.5.2
#>  [75] tools_4.5.2                 ica_1.0-3
#>  [77] Rcpp_1.1.1                  glue_1.8.0
#>  [79] gridExtra_2.3               SparseArray_1.10.8
#>  [81] xfun_0.56                   MatrixGenerics_1.22.0
#>  [83] distributional_0.6.0        ggthemes_5.2.0
#>  [85] dplyr_1.2.0                 withr_3.0.2
#>  [87] BiocManager_1.30.27         fastmap_1.2.0
#>  [89] callr_3.7.6                 digest_0.6.39
#>  [91] rsvd_1.0.5                  parallelDist_0.2.7
#>  [93] R6_2.6.1                    mime_0.13
#>  [95] colorspace_2.1-2            Cairo_1.7-0
#>  [97] scattermore_1.2             tensor_1.5.1
#>  [99] dichromat_2.0-0.1           spatstat.data_3.1-9
#> [101] tidyr_1.3.2                 generics_0.1.4
#> [103] data.table_1.18.2.1         httr_1.4.7
#> [105] htmlwidgets_1.6.4           S4Arrays_1.10.1
#> [107] uwot_0.2.4                  pkgconfig_2.0.3
#> [109] gtable_0.3.6                ComplexHeatmap_2.26.1
#> [111] lmtest_0.9-40               S7_0.2.1
#> [113] SingleCellExperiment_1.32.0 XVector_0.50.0
#> [115] htmltools_0.5.9             dotCall64_1.2
#> [117] bookdown_0.46               zigg_0.0.2
#> [119] clue_0.3-66                 SeuratObject_5.3.0
#> [121] scales_1.4.0                Biobase_2.70.0
#> [123] png_0.1-8                   spatstat.univar_3.1-6
#> [125] knitr_1.51                  tzdb_0.5.0
#> [127] reshape2_1.4.5              rjson_0.2.23
#> [129] curl_7.0.0                  nlme_3.1-168
#> [131] proxy_0.4-29                cachem_1.1.0
#> [133] zoo_1.8-15                  GlobalOptions_0.1.3
#> [135] stringr_1.6.0               KernSmooth_2.23-26
#> [137] parallel_4.5.2              miniUI_0.1.2
#> [139] GEOquery_2.78.0             pillar_1.11.1
#> [141] grid_4.5.2                  vctrs_0.7.1
#> [143] RANN_2.6.2                  promises_1.5.0
#> [145] BiocSingular_1.26.1         beachmat_2.26.0
#> [147] xtable_1.8-4                cluster_2.1.8.2
#> [149] evaluate_1.0.5              magick_2.9.0
#> [151] tinytex_0.58                readr_2.1.6
#> [153] cli_3.6.5                   compiler_4.5.2
#> [155] rlang_1.1.7                 crayon_1.5.3
#> [157] future.apply_1.20.1         labeling_0.4.3
#> [159] ps_1.9.1                    plyr_1.8.9
#> [161] stringi_1.8.7               viridisLite_0.4.3
#> [163] deldir_2.0-4                BiocParallel_1.44.0
#> [165] assertthat_0.2.1            lazyeval_0.2.2
#> [167] spatstat.geom_3.7-0         Matrix_1.7-4
#> [169] RcppHNSW_0.6.0              hms_1.1.4
#> [171] patchwork_1.3.2             bit64_4.6.0-1
#> [173] future_1.69.0               conflicted_1.2.0
#> [175] ggplot2_4.0.2               statmod_1.5.1
#> [177] shiny_1.12.1                SummarizedExperiment_1.40.0
#> [179] ROCR_1.0-12                 Rfast_2.1.5.2
#> [181] memoise_2.0.1               igraph_2.2.1
#> [183] RcppParallel_5.1.11-1       bslib_0.10.0
#> [185] bit_4.6.0
```