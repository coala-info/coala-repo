# AUCell: Identifying cells with active gene sets

#### 29 October 2025

#### Abstract

This tutorial shows how to use **AUCell** to identify cells with an active ‘gene set’ (i.e. gene signatures) in single-cell RNA-seq data.
AUCell uses the “Area Under the Curve” (AUC) to calculate whether a critical subset of the input gene set is enriched within the expressed genes for each cell. The distribution of AUC scores across all the cells allows exploring the relative expression of the signature. Since the scoring method is ranking-based, AUCell is independent of the gene expression units and the normalization procedure. In addition, since the cells are evaluated individually, it can easily be applied to bigger datasets, subsetting the expression matrix if needed.

#### Package

AUCell 1.32.0

# Contents

* [Overview of the workflow](#overview-of-the-workflow)
* [Before starting](#before-starting)
  + [Setup](#setup)
  + [Some tips…](#some-tips)
    - [Help](#help)
    - [Report template](#report-template)
    - [Video tutorial](#video-tutorial)
* [Running AUCell](#running-aucell)
  + [0. Load scRNA-seq dataset and gene sets](#load-scrna-seq-dataset-and-gene-sets)
    - [Working directory](#working-directory)
    - [Expression matrix](#expression-matrix)
    - [Gene sets](#gene-sets)
  + [1. Score gene signatures](#score-gene-signatures)
    - [1.1. Build gene-expression rankings for each cell](#build-gene-expression-rankings-for-each-cell)
    - [1.2. Calculate enrichment for the gene signatures (AUC)](#calculate-enrichment-for-the-gene-signatures-auc)
  + [2. Determine the cells with the given gene signatures or active gene sets](#determine-the-cells-with-the-given-gene-signatures-or-active-gene-sets)
* [Follow up examples](#follow-up-examples)
  + [Exploring the cell-assignment (table & heatmap)](#exploring-the-cell-assignment-table-heatmap)
  + [Explore cells/clusters based on the signature score](#explore-cellsclusters-based-on-the-signature-score)
* [Why to use AUCell?](#why-to-use-aucell)
  + [Comparison with mean](#comparison-with-mean)
  + [How reliable is AUCell? (Confusion matrix)](#how-reliable-is-aucell-confusion-matrix)
* [sessionInfo](#sessioninfo)

# Overview of the workflow

AUCell allows to identify cells with active gene sets (e.g. signatures, gene modules) in single-cell RNA-seq data.

In brief, AUCell is run with these commands:

```
library(AUCell)
geneSets <- list(geneSet1=c("gene1", "gene2", "gene3"))

# Calculate enrichment scores
cells_AUC <- AUCell_run(exprMatrix, geneSets, aucMaxRank=nrow(cells_rankings)*0.05)

# Optional: Set the assignment thresholds
par(mfrow=c(3,3))
set.seed(123)
cells_assignment <- AUCell_exploreThresholds(cells_AUC, plotHist=TRUE, nCores=1, assign=TRUE)
```

In the following sections we explain the rationale behind the canculations and explore the output of each step. The details of the methods behind AUCell are described in the following article:

```
## Aibar et al. (2017) SCENIC: single-cell regulatory network inference and clustering. Nature Methods. doi: 10.1038/nmeth.4463
```

Please, also cite this article if you use AUCell in your research.

# Before starting

## Setup

By default, AUCell is installed only with the minimum dependencies.
To run AUCell in parallel or run the examples in this tutorial, we recommend to install these packages:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
# To support paralell execution:
BiocManager::install(c("doMC", "doRNG","doSNOW"))
# For the main example:
BiocManager::install(c("mixtools", "SummarizedExperiment"))
# For the examples in the follow-up section of the tutorial:
BiocManager::install(c("DT", "plotly", "NMF", "d3heatmap",
                       "dynamicTreeCut", "R2HTML", "Rtsne", "zoo"))
```

## Some tips…

### Help

At any time, remember you an access the help files for any function (i.e. `?AUCell_buildRankings`). It is also possible to open this tutorial directly from R with the following commands:

```
# Explore tutorials in the web browser:
browseVignettes(package="AUCell")

# Commnad line-based:
vignette(package="AUCell") # list
vignette("AUCell") # open
```

### Report template

To generate an HTML report with your own data and comments, you can use the `.Rmd file` of this tutorial as template (i.e. copy the .Rmd file, and edit it as [R notebook](http://rmarkdown.rstudio.com/r_notebooks.html) in RStudio).

```
vignetteFile <- paste(file.path(system.file('doc', package='AUCell')), "AUCell.Rmd", sep="/")
# Copy to edit as markdown
file.copy(vignetteFile, ".")
# Alternative: extract R code
Stangle(vignetteFile)
```

### Video tutorial

A video tutorial, created by a user ([Mark Sanborn](https://twitter.com/Sanbomics)), is also available in [YouTube](https://www.youtube.com/watch?v=XtjZRZFzUVw).

*(Thank you Mark!)*

# Running AUCell

## 0. Load scRNA-seq dataset and gene sets

The input data for AUCell are the expression matrix and the gene-sets.

### Working directory

During this tutorial some plots and files are saved. To keep them tidy, we recommend to set the working directory to a new folder:

```
dir.create("AUCell_tutorial")
setwd("AUCell_tutorial") # or in the first code chunk (kntr options), if running as Notebook
```

### Expression matrix

The expression matrix, from a single-cell RNA-seq dataset, should be formatted with the genes/features as rows and cells as columns. Ideally, the matrix will be stored in sparse format to save memory.

Typically, this matrix will be loaded from a counts file, or from another R object. i.e.:

```
# i.e. Reading from a text file
exprMatrix <- read.table("myCountsMatrix.tsv")

# or single-cell experiment
exprMatrix <- assay(mySingleCellExperiment)

### Convert to sparse:
exprMatrix <- as(exprMatrix, "dgCMatrix")
```

In this tutorial we use a dataset containing 3005 cells from mouse cortex and hippocampus. The dataset can be downloaded from GEO accession number GSE60361.

*Zeisel, A., et al. (2015). Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq. Science 347, 1138–1142. doi: [10.1126/science.aaa1934](http://dx.doi.org/10.1126/science.aaa1934)*

```
# (Downloads the data)
if (!requireNamespace("GEOquery", quietly = TRUE)) BiocManager::install("GEOquery")
library(GEOquery)
# gse <- getGEO('GSE60361') # does not work, the matrix is in a suppl file
geoFile <- "GSE60361_C1-3005-Expression.txt.gz"
download.file("https://ftp.ncbi.nlm.nih.gov/geo/series/GSE60nnn/GSE60361/suppl/GSE60361_C1-3005-Expression.txt.gz", destfile = geoFile)

library(data.table)
exprMatrix <- fread(geoFile, sep="\t")
geneNames <- unname(unlist(exprMatrix[,1, with=FALSE]))
exprMatrix <- as.matrix(exprMatrix[,-1, with=FALSE])
rownames(exprMatrix) <- geneNames
exprMatrix <- exprMatrix[unique(rownames(exprMatrix)),]
dim(exprMatrix)
exprMatrix[1:5,1:4]

# Remove file(s) downloaded:
file.remove(geoFile)

# Convert to sparse
library(Matrix)
exprMatrix <- as(exprMatrix, "dgCMatrix")

# Save for future use
mouseBrainExprMatrix <- exprMatrix
save(mouseBrainExprMatrix, file="exprMatrix_MouseBrain.RData")
```

To speed-up the execution of the tutorial, we will use only 5000 random genes from this dataset.

```
# load("exprMatrix_MouseBrain.RData")
set.seed(333)
exprMatrix <- mouseBrainExprMatrix[sample(rownames(mouseBrainExprMatrix), 5000),]
```

In this way, we will be using an expression matrix with (5000 gene and 3005 cells):

```
dim(exprMatrix)
```

```
## [1] 5000 3005
```

### Gene sets

The other input AUCell needs is the ‘gene-sets’ or signatures to test on the cells.
They can be provided in several formats (see `?AUCell_calcAUC` for examples). e.g.:

```
library(GSEABase)
genes <- c("gene1", "gene2", "gene3")
geneSets <- GeneSet(genes, setName="geneSet1")
geneSets
```

```
## setName: geneSet1
## geneIds: gene1, gene2, gene3 (total: 3)
## geneIdType: Null
## collectionType: Null
## details: use 'details(object)'
```

In this example we will use gene-sets representing diferent cell types in the brain:

1. Big gene signatures (> 1000 genes) for **astrocytes**, **oligodendrocytes** and **neurons**.

*Cahoy, J.D., et al. (2008). A Transcriptome Database for Astrocytes, Neurons, and Oligodendrocytes: A New Resource for Understanding Brain Development and Function. J. Neurosci. 28, 264–278. doi: [10.1523/JNEUROSCI.4178-07.2008](http://dx.doi.org/10.1523/JNEUROSCI.4178-07.2008)*

2. Big gene signature (> 500 genes) for **microglia**. Obtained by comparing bulk RNA-seq profiles of microglia (brain-resident macrophages) to macrophages from other tissues.

*Lein, E.S., et al. (2007). Genome-wide atlas of gene expression in the adult mouse brain. Nature 445, 168–176. doi: [10.1038/nature05453](http://dx.doi.org/10.1038/nature05453)*

3. Small gene signatures (<100 genes) for astrocytes and neurons.

*Lavin, Y., et al. (2014) Tissue-Resident Macrophage Enhancer Landscapes Are Shaped by the Local Microenvironment. Cell 159, 1312–1326. doi: [10.1016/j.cell.2014.11.018](http://dx.doi.org/10.1016/j.cell.2014.11.018)*

```
library(AUCell)
library(GSEABase)
gmtFile <- paste(file.path(system.file('examples', package='AUCell')), "geneSignatures.gmt", sep="/")
geneSets <- getGmt(gmtFile)
```

Let’s check how many of these genes are in the expression matrix:

```
geneSets <- subsetGeneSets(geneSets, rownames(exprMatrix))
cbind(nGenes(geneSets))
```

```
##                       [,1]
## Astrocyte_Cahoy        526
## Neuron_Cahoy           404
## Oligodendrocyte_Cahoy  469
## Astrocyte_Lein           7
## Neuron_Lein             15
## Microglia_lavin        159
```

To ease the interpretation of the tutorial, we will also add the gene-set size into its name:

```
geneSets <- setGeneSetNames(geneSets, newNames=paste(names(geneSets), " (", nGenes(geneSets) ,"g)", sep=""))
```

For the example, let’s also add a few sets of random genes and 100 genes expressed in many cells (i.e. housekeeping-like):

```
# Random
set.seed(321)
extraGeneSets <- c(
  GeneSet(sample(rownames(exprMatrix), 50), setName="Random (50g)"),
  GeneSet(sample(rownames(exprMatrix), 500), setName="Random (500g)"))

countsPerGene <- apply(exprMatrix, 1, function(x) sum(x>0))
# Housekeeping-like
extraGeneSets <- c(extraGeneSets,
                   GeneSet(sample(names(countsPerGene)[which(countsPerGene>quantile(countsPerGene, probs=.95))], 100), setName="HK-like (100g)"))

geneSets <- GeneSetCollection(c(geneSets,extraGeneSets))
names(geneSets)
```

```
## [1] "Astrocyte_Cahoy (526g)"       "Neuron_Cahoy (404g)"
## [3] "Oligodendrocyte_Cahoy (469g)" "Astrocyte_Lein (7g)"
## [5] "Neuron_Lein (15g)"            "Microglia_lavin (159g)"
## [7] "Random (50g)"                 "Random (500g)"
## [9] "HK-like (100g)"
```

Since we are using an expression matrix with only 5000 random genes, most of these genes are acutally not available in the dataset.
However, AUCell is robust enough to use this ‘noisy’ data.

## 1. Score gene signatures

The function `AUCell_run` calculates calculates the signature enrichment scores on each cell:

```
cells_AUC <- AUCell_run(exprMatrix, geneSets)
save(cells_AUC, file="cells_AUC.RData")
```

> To run in parallel, you can add the argument `BPPARAM=BiocParallel::MulticoreParam(5)`. Modifiying `5` to the number of cores to use.

After obtaining the AUC scores, you can go directly to “Step 2” and “Follow up examples”. However, you can keep reading through section 1.1 and 1.2 if you want to understand better what these scores mean, or if you would like to run AUCell across many gene-sets that need further manipulation.

In brief, the AUC scores are calculated in two steps: 1. Building the rankings (`AUCell_buildRankings`) and 2. Calculate enrichment (`AUCell_calcAUC`). i.e. using `AUCell_run` is equivalent to running:

```
cells_rankings <- AUCell_buildRankings(exprMatrix, plotStats=FALSE)
cells_AUC <- AUCell_calcAUC(geneSets, cells_rankings)
```

```
## Warning in .AUCell_calcAUC(geneSets = geneSets, rankings = rankings, nCores =
## nCores, : Using only the first 250 genes (aucMaxRank) to calculate the AUC.
```

### 1.1. Build gene-expression rankings for each cell

The first step to calculate the enrichment of a signature is to create the “rankings”. These rankings are only an intermediate step to calculate the AUC, but they are kept as a separate step in the workflow in order to provide more flexibility (i.e. to save them for future analyses, to merge datasets, or process them by parts).

For each cell, the genes are ranked from highest to lowest value. The genes with same expression value are shuffled. Therefore, genes with expression ‘0’ are randomly sorted at the end of the ranking. It is important to check that most cells have at least the number of expressed/detected genes that are going to be used to calculate the AUC (`aucMaxRank` in `calcAUC()`). The histogram provided by `AUCell_buildRankings()` allows to quickly check this distribution. `plotGeneCount(exprMatrix)` allows to obtain only the plot before building the rankings.

Since the rankings are created individually for each cell, in principle, it is possible to merge cell-rankings from different datasets. However, the datasets should be similar in regards to their “sensitivity” (e.g. the number of genes detected in the cells of each datasets), and the genes they include (e.g. same gene IDs).

```
cells_rankings <- AUCell_buildRankings(exprMatrix, plotStats=TRUE)
```

![](data:image/png;base64...)

```
## Quantiles for the number of genes detected by cell:
## (Non-detected genes are shuffled at the end of the ranking. Keep it in mind when choosing the threshold for calculating the AUC).
```

```
##     min      1%      5%     10%     50%    100%
##  193.00  271.08  364.20  447.40  921.00 2056.00
```

```
cells_rankings
```

```
## Ranking for 5000 genes (rows) and 3005 cells (columns).
##
## Top-left corner of the ranking:
##           cells
## genes      1772071015_C02 1772071017_G12 1772071017_A05 1772071014_B06
##   Gm5833             3864           1706           2712           1775
##   Gm16119            2852           4008           4720           2561
##   Arhgap44            188           2948            316            357
##   Snord99            1443           1776           4070           3069
##   Ccl5               2599           2294           2225           2990
##   Sox18              2541           4519           4058           1563
##           cells
## genes      1772067065_H06
##   Gm5833             4695
##   Gm16119            3506
##   Arhgap44            153
##   Snord99            2049
##   Ccl5               1268
##   Sox18              3655
##
## Quantiles for the number of genes detected by cell:
##     min      1%      5%     10%     50%    100%
##  193.00  271.08  364.20  447.40  921.00 2056.00
```

The “rankings” can be seen as a new representation of the original dataset. Once they are calculated, they can be saved for future analyses.

```
save(cells_rankings, file="cells_rankings.RData")
```

### 1.2. Calculate enrichment for the gene signatures (AUC)

To determine whether the gene set is enriched at the top of the gene-ranking for each cell, AUCell uses the “Area Under the Curve” (AUC) of the recovery curve.

![](data:image/png;base64...)

The function `AUCell_calcAUC` calculates this score, and returns a matrix with an AUC score for each gene-set in each cell.

```
cells_AUC <- AUCell_calcAUC(geneSets, cells_rankings)
save(cells_AUC, file="cells_AUC.RData")
```

In order to calculate the AUC, by default only the top 5% of the genes in the ranking are used (i.e. checks whether the genes in the gene-set or signature are within the top 5%). This allows faster execution on bigger datasets, and reduce the effect of the noise at the bottom of the ranking (e.g. where many genes might be tied at 0 counts). The percentage to take into account can be modified with the argument *aucMaxRank*.
For datasets where most cells express many genes (e.g. a filtered dataset), or these have high expression values, it might be good to increase this threshold. Check the histogram provided by `AUCell_buildRankings` to get an estimation on where this threshold lies within the dataset.

## 2. Determine the cells with the given gene signatures or active gene sets

> *In summary:* The AUC represents the proportion of expressed genes in the signature, and their relative expression value compared to the other genes within the cell.
> We can use this propperty to explore the population of cells that are present in the dataset according to the expression of the gene-set.

The AUC estimates the proportion of genes in the gene-set that are highly expressed in each cell. Cells expressing many genes from the gene-set will have higher AUC values than cells expressing fewer (i.e. compensating for housekeeping genes, or genes that are highly expressed in all the cells in the dataset). Since the AUC represents the proportion of expressed genes in the signature, we can use the relative AUCs across the cells to explore the population of cells that are present in the dataset according to the expression of the gene-set.

However, determining whether the signature is active (or not) in a given cell is not always trivial. The AUC is not an absolute value, but it depends on the the cell type (i.e. sell size, amount of transcripts), the specific dataset (i.e. sensitivity of the measures) and the gene-set. It is often not straight forward to obtain a pruned *signature* of clear *marker* genes that are completely “on” in the cell type of interest and off" in every other cell. In addition, at single-cell level, most genes are not expressed or detected at a constant level.

The ideal situation will be a bi-modal distribution, in which most cells in the dataset have a low “AUC” compared to a population of cells with a clearly higher value (i.e. see “Oligodendrocites” in the next figure). This is normally the case on gene sets that are active mostly in a population of cells with a good representation in the dataset (e.g. ~ 5-30% of cells in the dataset). Similar cases of “marker” gene sets but with different proportions of cells in the datasets are the “neurons” and “microglia” (see figure). When there are very few cells within the dataset, the distribution might look normal-like, but with some outliers to the higher end (e.g. microglia). While if the gene set is marker of a high percentage of cells in the dataset (i.e. neurons), the distribution might start approaching the look of a gene-set of housekeeping genes. As example, the ‘housekeeping’ gene-set in the figure includes genes that are detected in most cells in the dataset.

Note that the size of the gene-set will also affect the results. With smaller gene-genes (fewer genes), it is more likely to get cells with AUC = 0.
While this is the case of the “perfect markers” it is also easier to get it by chance with smal datasets. (i.e. Random gene set with 50 genes in the figure). Bigger gene-sets (100-2k) can be more stable and easier to evaluate, as big random gene sets will approach the normal distibution.

To ease the exploration of the distributions, the function `AUCell_exploreThresholds()` automatically plots all the histograms and calculates several thresholds that could be used to consider a gene-set ‘active’ (returned in `$aucThr`). The distributions are plotted as dotted lines over the histogram and the corresponding thresholds as vertical bars in the matching color. The thicker vertical line indicates the threshold selected by default (`$aucThr$selected`): the highest value to reduce the false positives.

> Note: This function makes use of package “mixtools” to explore the distributions. It is not essential, but we recommend to install it: `if (!requireNamespace("BiocManager", quietly=TRUE)); BiocManager::install("mixtools")`
> `install.packages("BiocManager"); BiocManager::install("mixtools")`

```
set.seed(333)
par(mfrow=c(3,3))
cells_assignment <- AUCell_exploreThresholds(cells_AUC, plotHist=TRUE, assign=TRUE)
```

![](data:image/png;base64...)

```
warningMsg <- sapply(cells_assignment, function(x) x$aucThr$comment)
warningMsg[which(warningMsg!="")]
```

```
##                                                                                                      Microglia_lavin (159g)
##                                                            "Few cells have high AUC values (0.001% cells with AUC> 0.20). "
##                                                                                                                Random (50g)
##                                                                "Few cells have high AUC values (0% cells with AUC> 0.20). "
##                                                                                                               Random (500g)
## "Few cells have high AUC values (0% cells with AUC> 0.20). The AUC might follow a normal distribution (random gene-set?). "
```

The thresholds calcuated for each gene set are stored in the `$aucThr` slot.
For example, the thresholds suggested for the oligodendrocyte gene-set:

```
cells_assignment$Oligodendrocyte_Cahoy$aucThr$thresholds
```

```
##             threshold nCells
## Global_k1   0.2398199    739
## L_k2        0.2429782    727
## R_k3        0.1773621    960
## minimumDens 0.2384903    742
```

To ease for the inclusion of AUCell in workflows (e.g. SCENIC), this function can also provide the list of cells with an AUC value over this threshold (`$assignment`). However, keep in mind that the threshold selection in the current version is not exhaustive, so we highly recommend to check the AUC histograms and manually select the threshold if needed.

To obtain the threshold selected automatically for a given gene set(e.g. Oligodendrocytes):

```
cells_assignment$Oligodendrocyte_Cahoy$aucThr$selected
```

```
## minimumDens
##   0.2384903
```

```
# getThresholdSelected(cells_assignment)
```

Cells assigned at this threshold:

```
oligodencrocytesAssigned <- cells_assignment$Oligodendrocyte_Cahoy$assignment
length(oligodencrocytesAssigned)
```

```
## [1] 742
```

```
head(oligodencrocytesAssigned)
```

```
## [1] "1772067069_B02" "1772071041_A02" "1772066077_G03" "1772066070_D08"
## [5] "1772067076_A07" "1772067057_G07"
```

Plotting the AUC histogram of a specific gene set, and setting a new threshold:

```
geneSetName <- rownames(cells_AUC)[grep("Oligodendrocyte_Cahoy", rownames(cells_AUC))]
AUCell_plotHist(cells_AUC[geneSetName,], aucThr=0.25)
abline(v=0.25)
```

![](data:image/png;base64...)
Assigning cells to this new threshold:

```
newSelectedCells <- names(which(getAUC(cells_AUC)[geneSetName,]>0.08))
length(newSelectedCells)
```

```
## [1] 2998
```

```
head(newSelectedCells)
```

```
## [1] "1772071015_C02" "1772071017_G12" "1772071017_A05" "1772071014_B06"
## [5] "1772067065_H06" "1772071017_E02"
```

# Follow up examples

## Exploring the cell-assignment (table & heatmap)

The cell assignment is stored in the `$assignment` slot. Here we show a few ideas on how they can be extracted and visualized.

Extract these cells for all the gene-sets and transform it into a table:

```
cellsAssigned <- lapply(cells_assignment, function(x) x$assignment)
assignmentTable <- reshape2::melt(cellsAssigned, value.name="cell")
colnames(assignmentTable)[2] <- "geneSet"
head(assignmentTable)
```

```
##             cell                geneSet
## 1 1772071015_A01 Astrocyte_Cahoy (526g)
## 2 1772066080_D10 Astrocyte_Cahoy (526g)
## 3 1772066099_C03 Astrocyte_Cahoy (526g)
## 4 1772071036_B05 Astrocyte_Cahoy (526g)
## 5 1772067060_G06 Astrocyte_Cahoy (526g)
## 6 1772058148_A03 Astrocyte_Cahoy (526g)
```

Convert into an incidence matrix and plot as a histogram:

```
assignmentMat <- table(assignmentTable[,"geneSet"], assignmentTable[,"cell"])
assignmentMat[,1:2]
```

```
##
##                                1772058148_A01 1772058148_A03
##   Astrocyte_Cahoy (526g)                    0              1
##   Astrocyte_Lein (7g)                       1              1
##   Microglia_lavin (159g)                    0              0
##   Neuron_Cahoy (404g)                       0              0
##   Neuron_Lein (15g)                         0              0
##   Oligodendrocyte_Cahoy (469g)              1              1
##   Random (500g)                             0              0
##   Random (50g)                              0              0
```

```
set.seed(123)
miniAssigMat <- assignmentMat[,sample(1:ncol(assignmentMat),100)]
library(NMF)
aheatmap(miniAssigMat, scale="none", color="black", legend=FALSE)
```

![](data:image/png;base64...)

Some interactive options (output not shown):

```
# if (!requireNamespace("d3heatmap", quietly = TRUE)) BiocManager::install("d3heatmap")
# d3heatmap(matrix(miniAssigMat), scale="none", colors=c("white", "black"))

library(DT)
datatable(assignmentTable, options = list(pageLength = 10), filter="top")
```

## Explore cells/clusters based on the signature score

The AUC score can also be used to explore the output from previous clustering analyses (or vice-versa).

In this example, we will use the AUC obtained for the diferent signatures to color a t-SNE based previously run on the whole expression matrix (i.e. not the 5000 random genes).

```
# Load the tSNE (included in the package)
load(paste(file.path(system.file('examples', package='AUCell')), "cellsTsne.RData", sep="/"))
cellsTsne <- cellsTsne$Y
plot(cellsTsne, pch=16, cex=.3)
```

![](data:image/png;base64...)

This t-SNE was created with this code (it takes a while to run):

```
load("exprMatrix_AUCellVignette_MouseBrain.RData")
sumByGene <- apply(mouseBrainExprMatrix, 1, sum)
exprMatSubset <- mouseBrainExprMatrix[which(sumByGene>0),]
logMatrix <- log2(exprMatSubset+1)
logMatrix <- as.matrix(logMatrix)

library(Rtsne)
set.seed(123)
cellsTsne <- Rtsne(t(logMatrix))
rownames(cellsTsne$Y) <- colnames(logMatrix)
colnames(cellsTsne$Y) <- c("tsne1", "tsne2")
save(cellsTsne, file="cellsTsne.RData")
```

This t-SNE can be colored based on the AUC scores. To highlight the cluster of cells that are more likely of the cell type according to the signatures, we will split the cells into the cells that pass the assignment threshold (colored in shades of pink-red), and the cells that don’t (colored in black-blue).

Of course, the origin of the signatures should also be kept in mind for the interpretation (for example, these signatures were obtained from bulk RNA-seq analyses). Also, running this tutorial only on 5000 genes probably introduced some extra noise.

For this example we have used the thresholds assigned automatically:

```
selectedThresholds <- getThresholdSelected(cells_assignment)
par(mfrow=c(2,3)) # Splits the plot into two rows and three columns
for(geneSetName in names(selectedThresholds)[1:6])
{
  nBreaks <- 5 # Number of levels in the color palettes
  # Color palette for the cells that do not pass the threshold
  colorPal_Neg <- grDevices::colorRampPalette(c("black","blue", "skyblue"))(nBreaks)
  # Color palette for the cells that pass the threshold
  colorPal_Pos <- grDevices::colorRampPalette(c("pink", "magenta", "red"))(nBreaks)

  # Split cells according to their AUC value for the gene set
  passThreshold <- getAUC(cells_AUC)[geneSetName,] >  selectedThresholds[geneSetName]
  if(sum(passThreshold) >0 )
  {
    aucSplit <- split(getAUC(cells_AUC)[geneSetName,], passThreshold)

    # Assign cell color
    cellColor <- c(setNames(colorPal_Neg[cut(aucSplit[[1]], breaks=nBreaks)], names(aucSplit[[1]])),
    setNames(colorPal_Pos[cut(aucSplit[[2]], breaks=nBreaks)], names(aucSplit[[2]])))

    # Plot
    plot(cellsTsne, main=geneSetName,
    sub="Pink/red cells pass the threshold",
    col=cellColor[rownames(cellsTsne)], pch=16)
  }
}
```

![](data:image/png;base64...)

This kind of plots can also be used to explore the assignment thresholds. i.e.:

```
selectedThresholds[2] <-  0.25
par(mfrow=c(2,3))
AUCell_plotTSNE(tSNE=cellsTsne, exprMat=exprMatrix,
cellsAUC=cells_AUC[1:2,], thresholds=selectedThresholds)
```

![](data:image/png;base64...)

# Why to use AUCell?

## Comparison with mean

One of the most intuitive ways to evaluate the expression of a gene signature is to calculate the mean expression. However, calculating the average of the gene signature on the raw counts will lead to cells with more reads (either for technical or biological reasons) to have higher average values for most signatures. To reduce this effect, some kind of library-size normalization would be required.
Since AUCell evaluates the dectection of the signatures on each cell individually, it automatically compensates for library-size and makes its application easier and independent of the units of the data and other normalizations applied (e.g. raw counts, TPM, UMI counts).

```
logMat <- log2(exprMatrix+2)
meanByGs <- t(sapply(geneSets, function(gs) colMeans(logMat[geneIds(gs),])))
rownames(meanByGs) <- names(geneSets)
```

```
colorPal <- grDevices::colorRampPalette(c("black", "red"))(nBreaks)
par(mfrow=c(3,3))
for(geneSetName in names(geneSets))
{
  cellColor <- setNames(colorPal[cut(meanByGs[geneSetName,], breaks=nBreaks)], names(meanByGs[geneSetName,]))
  plot(cellsTsne, main=geneSetName, axes=FALSE, xlab="", ylab="",
  sub="Expression mean",
  col=cellColor[rownames(cellsTsne)], pch=16)
}
```

![](data:image/png;base64...)

```
AUCell_plotTSNE(tSNE=cellsTsne, exprMat=exprMatrix, plots = "AUC",
cellsAUC=cells_AUC[1:9,], thresholds=selectedThresholds)
```

![](data:image/png;base64...)

```
nGenesPerCell <- apply(exprMatrix, 2, function(x) sum(x>0))
colorPal <- grDevices::colorRampPalette(c("darkgreen", "yellow","red"))
cellColorNgenes <- setNames(adjustcolor(colorPal(10), alpha.f=.8)[as.numeric(cut(nGenesPerCell,breaks=10, right=FALSE,include.lowest=TRUE))], names(nGenesPerCell))
plot(cellsTsne, axes=FALSE, xlab="", ylab="",
sub="Number of detected genes",
col=cellColorNgenes[rownames(cellsTsne)], pch=16)
```

![](data:image/png;base64...)

## How reliable is AUCell? (Confusion matrix)

When using AUCell to identify cell types, the reliability of the cells identified will depend on the signatures used, and the differences within the cell types in the dataset. In any case, AUCell is quite robust to noise, both in the data and in the gene-set.

This is the comparison of the cells identified with AUCell (this example) and the cell-types assigned in the initial publication:

```
# "Real" cell type (e.g. provided in the publication)
cellLabels <- paste(file.path(system.file('examples', package='AUCell')), "mouseBrain_cellLabels.tsv", sep="/")
cellLabels <- read.table(cellLabels, row.names=1, header=TRUE, sep="\t")
```

```
# Confusion matrix:
cellTypeNames <- unique(cellLabels[,"level1class"])
confMatrix <- t(sapply(cells_assignment[c(1,4,2,5,3,6:9)],
function(x) table(cellLabels[x$assignment,])[cellTypeNames]))
colnames(confMatrix) <- cellTypeNames
confMatrix[which(is.na(confMatrix), arr.ind=TRUE)] <- 0
confMatrix
```

```
##                              interneurons pyramidal SS pyramidal CA1
## Astrocyte_Cahoy (526g)                  1            0             3
## Astrocyte_Lein (7g)                   266          322           848
## Neuron_Cahoy (404g)                   289          396           937
## Neuron_Lein (15g)                     290          399           935
## Oligodendrocyte_Cahoy (469g)            0            2             3
## Microglia_lavin (159g)                  0            0             0
## Random (50g)                           31           53            41
## Random (500g)                           0            0             0
## HK-like (100g)                          0            0             0
##                              oligodendrocytes microglia endothelial-mural
## Astrocyte_Cahoy (526g)                     10         5                12
## Astrocyte_Lein (7g)                       677        80               229
## Neuron_Cahoy (404g)                        66        11                43
## Neuron_Lein (15g)                          86        16                44
## Oligodendrocyte_Cahoy (469g)              727         3                 1
## Microglia_lavin (159g)                      5        33                 0
## Random (50g)                              382        42                47
## Random (500g)                               0         0                 1
## HK-like (100g)                              0         0                 0
##                              astrocytes_ependymal
## Astrocyte_Cahoy (526g)                        190
## Astrocyte_Lein (7g)                           223
## Neuron_Cahoy (404g)                            33
## Neuron_Lein (15g)                              31
## Oligodendrocyte_Cahoy (469g)                    6
## Microglia_lavin (159g)                          0
## Random (50g)                                   54
## Random (500g)                                   0
## HK-like (100g)                                  0
```

*Notes on interpretation*:

* Interneurons & pyramidal are “neurons”.
* According to other publications that have used this dataset to evaluate new methods, a relevant group of cells marked as oligodendrocytes are likely doublets (i.e. two cells, for example a mix of an oligodendrocyte + another cell type).

# sessionInfo

This is the output of `sessionInfo()` on the system on which this document was compiled:

```
date()
```

```
## [1] "Wed Oct 29 22:35:14 2025"
```

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
##  [1] RColorBrewer_1.1-3   Matrix_1.7-4         GEOquery_2.78.0
##  [4] plotly_4.11.0        ggplot2_4.0.0        NMF_0.28
##  [7] bigmemory_4.6.4      cluster_2.1.8.1      rngtools_1.5.2
## [10] registry_0.5-1       DT_0.34.0            data.table_1.17.8
## [13] GSEABase_1.72.0      graph_1.88.0         annotate_1.88.0
## [16] XML_3.99-0.19        AnnotationDbi_1.72.0 IRanges_2.44.0
## [19] S4Vectors_0.48.0     Biobase_2.70.0       BiocGenerics_0.56.0
## [22] generics_0.1.4       AUCell_1.32.0        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   rlang_1.1.6
##  [3] magrittr_2.0.4              gridBase_0.4-7
##  [5] matrixStats_1.5.0           compiler_4.5.1
##  [7] RSQLite_2.4.3               DelayedMatrixStats_1.32.0
##  [9] png_0.1-8                   vctrs_0.6.5
## [11] reshape2_1.4.4              stringr_1.5.2
## [13] pkgconfig_2.0.3             crayon_1.5.3
## [15] fastmap_1.2.0               magick_2.9.0
## [17] XVector_0.50.0              rmarkdown_2.30
## [19] tzdb_0.5.0                  tinytex_0.57
## [21] purrr_1.1.0                 bit_4.6.0
## [23] xfun_0.53                   cachem_1.1.0
## [25] jsonlite_2.0.0              blob_1.2.4
## [27] DelayedArray_0.36.0         uuid_1.2-1
## [29] parallel_4.5.1              R6_2.6.1
## [31] bslib_0.9.0                 stringi_1.8.7
## [33] limma_3.66.0                GenomicRanges_1.62.0
## [35] jquerylib_0.1.4             Rcpp_1.1.0
## [37] Seqinfo_1.0.0               bookdown_0.45
## [39] SummarizedExperiment_1.40.0 iterators_1.0.14
## [41] knitr_1.50                  mixtools_2.0.0.1
## [43] R.utils_2.13.0              readr_2.1.5
## [45] splines_4.5.1               rentrez_1.2.4
## [47] tidyselect_1.2.1            dichromat_2.0-0.1
## [49] abind_1.4-8                 yaml_2.3.10
## [51] doParallel_1.0.17           codetools_0.2-20
## [53] lattice_0.22-7              tibble_3.3.0
## [55] plyr_1.8.9                  withr_3.0.2
## [57] KEGGREST_1.50.0             S7_0.2.0
## [59] evaluate_1.0.5              survival_3.8-3
## [61] xml2_1.4.1                  kernlab_0.9-33
## [63] Biostrings_2.78.0           pillar_1.11.1
## [65] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [67] foreach_1.5.2               hms_1.1.4
## [69] sparseMatrixStats_1.22.0    scales_1.4.0
## [71] xtable_1.8-4                glue_1.8.0
## [73] lazyeval_0.2.2              tools_4.5.1
## [75] grid_4.5.1                  tidyr_1.3.1
## [77] colorspace_2.1-2            nlme_3.1-168
## [79] cli_3.6.5                   bigmemory.sri_0.1.8
## [81] segmented_2.1-4             viridisLite_0.4.2
## [83] S4Arrays_1.10.0             dplyr_1.1.4
## [85] gtable_0.3.6                R.methodsS3_1.8.2
## [87] sass_0.4.10                 digest_0.6.37
## [89] SparseArray_1.10.0          htmlwidgets_1.6.4
## [91] farver_2.1.2                memoise_2.0.1
## [93] htmltools_0.5.8.1           R.oo_1.27.1
## [95] lifecycle_1.0.4             httr_1.4.7
## [97] statmod_1.5.1               MASS_7.3-65
## [99] bit64_4.6.0-1
```