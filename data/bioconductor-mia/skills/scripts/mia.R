# Code example from 'mia' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(
    cache = FALSE,
    fig.width = 9,
    message = FALSE,
    warning = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mia")

## ----load-packages, message=FALSE, warning=FALSE------------------------------
library("mia")

## -----------------------------------------------------------------------------
data(GlobalPatterns, package = "mia")
tse <- GlobalPatterns
tse

## -----------------------------------------------------------------------------
# print the available taxonomic ranks
colnames(rowData(tse))
taxonomyRanks(tse)
# subset to taxonomic data only
rowData(tse)[,taxonomyRanks(tse)]

## -----------------------------------------------------------------------------
table(taxonomyRankEmpty(tse, "Species"))
head(getTaxonomyLabels(tse))

## -----------------------------------------------------------------------------
# agglomerate at the Family taxonomic rank
x1 <- agglomerateByRank(tse, rank = "Family")
## How many taxa before/after agglomeration?
nrow(tse)
nrow(x1)

## -----------------------------------------------------------------------------
# with agglomeration of the tree
x2 <- agglomerateByRank(tse, rank = "Family",
                        agglomerateTree = TRUE)
nrow(x2) # same number of rows, but
rowTree(x1) # ... different
rowTree(x2) # ... tree

## -----------------------------------------------------------------------------
data(enterotype, package = "mia")
taxonomyRanks(enterotype)
agglomerateByRank(enterotype)

## -----------------------------------------------------------------------------
altExp(tse, "family") <- x2

## -----------------------------------------------------------------------------
x1 <- agglomerateByRank(tse, rank = "Species", empty.rm = TRUE)
altExp(tse,"species") <- agglomerateByRank(
    tse, rank = "Species", empty.rm = FALSE)
dim(x1)
dim(altExp(tse,"species"))

## -----------------------------------------------------------------------------
tse <- agglomerateByRanks(tse)
tse
altExpNames(tse)

## -----------------------------------------------------------------------------
taxa <- rowData(altExp(tse,"Species"))[,taxonomyRanks(tse)]
taxa_res <- resolveLoop(as.data.frame(taxa))
taxa_tree <- toTree(data = taxa_res)
taxa_tree$tip.label <- getTaxonomyLabels(altExp(tse,"Species"))
rowNodeLab <- getTaxonomyLabels(altExp(tse,"Species"), make.unique = FALSE)
altExp(tse,"Species") <- changeTree(
    altExp(tse,"Species"),
    rowTree = taxa_tree,
    rowNodeLab = rowNodeLab)

## -----------------------------------------------------------------------------
assayNames(enterotype)
anterotype <- transformAssay(enterotype, method = "log10", pseudocount = 1)
assayNames(enterotype)

## -----------------------------------------------------------------------------
data(GlobalPatterns, package = "mia")

tse.subsampled <- rarefyAssay(
    GlobalPatterns, 
    sample = 60000, 
    name = "subsampled",
    replace = TRUE,
    seed = 1938)
tse.subsampled


## -----------------------------------------------------------------------------
library(MultiAssayExperiment)
mae <- MultiAssayExperiment(
    c("originalTreeSE" = GlobalPatterns,
    "subsampledTreeSE" = tse.subsampled))
mae

## -----------------------------------------------------------------------------
# To extract specifically the subsampled TreeSE
experiments(mae)$subsampledTreeSE

## -----------------------------------------------------------------------------
tse <- addAlpha(tse, index = "shannon")
colnames(colData(tse))[8:ncol(colData(tse))]

## -----------------------------------------------------------------------------
library(scater)
altExp(tse,"Genus") <- runMDS(
    altExp(tse,"Genus"), 
    FUN = getDissimilarity,
    method = "bray",
    name = "BrayCurtis", 
    ncomponents = 5, 
    assay.type = "counts", 
    keep_dist = TRUE)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(phyloseq)
data(esophagus, package = "phyloseq")

## -----------------------------------------------------------------------------
esophagus
esophagus <- convertFromPhyloseq(esophagus)
esophagus

## -----------------------------------------------------------------------------
# Specific taxa
assay(tse['522457',], "counts") |> head()
# Specific sample
assay(tse[,'CC1'], "counts") |> head()


## -----------------------------------------------------------------------------
data(esophagus, package = "mia")
top_taxa <- getTop(
    esophagus,
    method = "mean",
    top = 5,
    assay.type = "counts")
top_taxa

## -----------------------------------------------------------------------------
molten_data <- meltAssay(
    tse,
    assay.type = "counts",
    add.row = TRUE,
    add.col = TRUE
)
molten_data

## -----------------------------------------------------------------------------
sessionInfo()

