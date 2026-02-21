# Code example from 'workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  message = FALSE, 
  warning = FALSE
)

## ----loadPackage, echo = FALSE------------------------------------------------
require(utils)
require(VDJdive)

## ----installation, eval = FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("VDJdive")

## ----eval = FALSE-------------------------------------------------------------
# # Read in a single file
# contigs <- readVDJcontigs("path_to_10X_files")
# 
# # Read in files for multiple samples
# path1 <- "sample1"
# path2 <- "sample2"
# contigs <- readVDJcontigs(c("path1", "path2"))

## ----echo = FALSE-------------------------------------------------------------
data("contigs")

## -----------------------------------------------------------------------------
require(SingleCellExperiment)
ncells <- 24
u <- matrix(rpois(1000 * ncells, 5), ncol = ncells)
barcodes <- vapply(contigs[,'barcode'], function(x){ x[1] }, 'A')
samples <- vapply(contigs[,'sample'], function(x){ x[1] }, 'A')
sce <- SingleCellExperiment(assays = list(counts = u),
                            colData = data.frame(Barcode = barcodes,
                                                 group = samples))
sce <- addVDJtoSCE(contigs, sce)
sce$contigs

## -----------------------------------------------------------------------------
UNstats <- clonoStats(contigs, method = 'unique')
class(UNstats)

## -----------------------------------------------------------------------------
EMstats <- clonoStats(contigs, method = "EM")
class(EMstats)

## -----------------------------------------------------------------------------
sce <- clonoStats(sce, method = 'EM')
metadata(sce)

## -----------------------------------------------------------------------------
head(clonoAbundance(sce)) # access output of abundance for clonotypes for clonoStats class
clonoFrequency(sce) # access output of frequency for clonotypes for clonoStats class
clonoFrequency(sce) # access output of clonotypes assignment for clonoStats class
clonoGroup(sce) # access output of clonotypes grouping for clonoStats class
clonoNames(sce) # access output of clonotypes samples for clonoStats class

## -----------------------------------------------------------------------------
div <- calculateDiversity(EMstats, methods = "all")
div

## -----------------------------------------------------------------------------
#divBreakaway <- runBreakaway(EMstats, methods = 'unique')
#divBreakaway

## -----------------------------------------------------------------------------
EMstats <- clonoStats(contigs, method = "EM", assignment = TRUE)

clus <- sample(1:2, 24, replace = TRUE)

EMstats.clus <- clonoStats(EMstats, group = clus)

## ----fig.width= 3, fig.height= 2----------------------------------------------
barVDJ(EMstats, title = "contigs", legend = TRUE)

## ----fig.width= 2.5, fig.height= 2--------------------------------------------
pieVDJ(EMstats)

## -----------------------------------------------------------------------------
sampleGroups <- data.frame(Sample = c("sample1", "sample2"), 
                           Group = c("Tumor", "Normal"))
scatterVDJ(div, sampleGroups = NULL, 
       title = "Evenness-abundance plot", legend = TRUE)

## -----------------------------------------------------------------------------
abundanceVDJ(EMstats)

## -----------------------------------------------------------------------------
sessionInfo()

