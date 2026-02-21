# Code example from 'hcadata' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = FALSE,
  warning = FALSE,
  message = FALSE
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("HCAData")

## ----loadpkg------------------------------------------------------------------
library("HCAData")

## ----firstcall----------------------------------------------------------------
HCAData()

## ----fetchingdata-------------------------------------------------------------
suppressPackageStartupMessages({
  library("ExperimentHub")
  library("SingleCellExperiment")
})

eh <- ExperimentHub()
query(eh, "HCAData")

# these three are the components to the bone marrow dataset
bonemarrow_h5densematrix <- eh[["EH2047"]]
bonemarrow_coldata <- eh[["EH2048"]]
bonemarrow_rowdata <- eh[["EH2049"]]

# and are put together when calling...
sce_bonemarrow <- HCAData("ica_bone_marrow")
sce_bonemarrow

# similarly, to access the umbilical cord blood dataset
sce_cordblood <- HCAData("ica_cord_blood")
sce_cordblood

## ----subset-------------------------------------------------------------------
library("scran")
library("BiocSingular")
library("scater")
library("scuttle")

set.seed(42)
sce <- sce_bonemarrow[, sample(seq_len(ncol(sce_bonemarrow)), 1000, replace = FALSE)]

## ----featureanno--------------------------------------------------------------
rownames(sce) <- uniquifyFeatureNames(rowData(sce)$ID, rowData(sce)$Symbol)
head(rownames(sce))

is.mito <- grep("MT-", rownames(sce))

counts(sce) <- as.matrix(counts(sce))
sce <- scuttle::addPerCellQC(sce, subsets=list(Mito=is.mito))

## ----clustnorm----------------------------------------------------------------
lib.sf.bonemarrow <- librarySizeFactors(sce)
summary(lib.sf.bonemarrow)

set.seed(42)
clusters <- quickCluster(sce)
table(clusters)
sce <- computeSumFactors(sce, min.mean=0.1, cluster=clusters)
sce <- logNormCounts(sce)
assayNames(sce)

## ----hvg----------------------------------------------------------------------
dec.bonemarrow <- modelGeneVarByPoisson(sce)
top.dec <- dec.bonemarrow[order(dec.bonemarrow$bio, decreasing=TRUE),] 
head(top.dec)

fit.bonemarrow <- metadata(dec.bonemarrow)
plot(fit.bonemarrow$mean, fit.bonemarrow$var, xlab="Mean of log-expression",
    ylab="Variance of log-expression", pch = 16)
curve(fit.bonemarrow$trend(x), col="dodgerblue", add=TRUE, lwd=2)
plotExpression(sce, features=rownames(top.dec)[1:10])

## ----dimred-------------------------------------------------------------------
hvg.bonemarrow <- getTopHVGs(dec.bonemarrow, prop = 0.1)

set.seed(42)
sce <- denoisePCA(sce, 
                  technical=dec.bonemarrow, 
                  subset.row = hvg.bonemarrow, 
                  BSPARAM=IrlbaParam())
ncol(reducedDim(sce, "PCA"))
plot(attr(reducedDim(sce), "percentVar"), xlab="PC",
     ylab="Proportion of variance explained")
abline(v=ncol(reducedDim(sce, "PCA")), lty=2, col="red")
plotPCA(sce, ncomponents=3, colour_by="subsets_Mito_percent")

set.seed(42)
sce <- runTSNE(sce, dimred="PCA", perplexity=30)
plotTSNE(sce, colour_by="subsets_Mito_percent")

## ----clusters-----------------------------------------------------------------
snn.gr <- buildSNNGraph(sce, use.dimred="PCA")
clusters <- igraph::cluster_walktrap(snn.gr)
sce$Cluster <- factor(clusters$membership)
table(sce$Cluster)
plotTSNE(sce, colour_by="Cluster")

## ----launchisee, eval=FALSE---------------------------------------------------
# if (require(iSEE)) {
#   iSEE(sce)
# }

## ----save, eval=FALSE---------------------------------------------------------
# destination <- "where/to/store/the/processed/data.rds"
# saveRDS(sce, file = destination)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

