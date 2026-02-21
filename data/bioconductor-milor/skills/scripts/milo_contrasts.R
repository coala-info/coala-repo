# Code example from 'milo_contrasts' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)
library(MouseThymusAgeing)
library(scuttle)

## -----------------------------------------------------------------------------
thy.sce <- MouseSMARTseqData() # this function downloads the full SCE object
thy.sce <- logNormCounts(thy.sce)
thy.sce

## ----fig.height=4.1, fig.width=10.5-------------------------------------------
thy.sce <- runUMAP(thy.sce) # add a UMAP for plotting results later

thy.milo <- Milo(thy.sce) # from the SCE object
reducedDim(thy.milo, "UMAP") <- reducedDim(thy.sce, "UMAP")

plotUMAP(thy.milo, colour_by="SubType") + plotUMAP(thy.milo, colour_by="Age")

## -----------------------------------------------------------------------------
# we build KNN graph
thy.milo <- buildGraph(thy.milo, k = 11, d = 40)
thy.milo <- makeNhoods(thy.milo, prop = 0.2, k = 11, d=40, refined = TRUE, refinement_scheme="graph") # make nhoods using graph-only as this is faster
colData(thy.milo)$Sample <- paste(colData(thy.milo)$SortDay, colData(thy.milo)$Age, sep="_")
thy.milo <- countCells(thy.milo, meta.data = data.frame(colData(thy.milo)), samples="Sample") # make the nhood X sample counts matrix

## -----------------------------------------------------------------------------
plotNhoodSizeHist(thy.milo)

## -----------------------------------------------------------------------------
thy.design <- data.frame(colData(thy.milo))[,c("Sample", "SortDay", "Age")]
thy.design <- distinct(thy.design)
rownames(thy.design) <- thy.design$Sample
## Reorder rownames to match columns of nhoodCounts(milo)
thy.design <- thy.design[colnames(nhoodCounts(thy.milo)), , drop=FALSE]
table(thy.design$Age)

## -----------------------------------------------------------------------------
rownames(thy.design) <- thy.design$Sample
contrast.1 <- c("Age1wk - Age4wk") # the syntax is <VariableName><ConditionLevel> - <VariableName><ControlLevel>

# we need to use the ~ 0 + Variable expression here so that we have all of the levels of our variable as separate columns in our model matrix
da_results <- testNhoods(thy.milo, design = ~ 0 + Age, design.df = thy.design, model.contrasts = contrast.1,
                         fdr.weighting="graph-overlap", norm.method="TMM")
table(da_results$SpatialFDR < 0.1)

## -----------------------------------------------------------------------------
contrast.all <- c("Age1wk - Age4wk", "Age4wk - Age16wk", "Age16wk - Age32wk", "Age32wk - Age52wk")
# contrast.all <- c("Age1wk - Age4wk", "Age16wk - Age32wk")

# this is the edgeR code called by `testNhoods`
model <- model.matrix(~ 0 + Age, data=thy.design)
mod.constrast <- makeContrasts(contrasts=contrast.all, levels=model)

mod.constrast

## -----------------------------------------------------------------------------
contrast1.res <- testNhoods(thy.milo, design=~0+ Age, design.df=thy.design, fdr.weighting="graph-overlap", model.contrasts = contrast.all)
head(contrast1.res)

## -----------------------------------------------------------------------------
# compare weeks 4 and 16, with week 4 as the reference.
cont.4vs16.res <- testNhoods(thy.milo, design=~0+ Age, design.df=thy.design, fdr.weighting="graph-overlap", model.contrasts = c("Age4wk - Age16wk"))
head(cont.4vs16.res)

## ----fig.height=4, fig.width=7.5----------------------------------------------
par(mfrow=c(1, 2))
plot(contrast1.res$logFC.Age4wk...Age16wk, cont.4vs16.res$logFC,
     xlab="4wk vs. 16wk LFC\nsingle contrast", ylab="4wk vs. 16wk LFC\nmultiple contrast")

plot(contrast1.res$SpatialFDR, cont.4vs16.res$SpatialFDR,
     xlab="Spatial FDR\nsingle contrast", ylab="Spatial FDR\nmultiple contrast")


## -----------------------------------------------------------------------------
model <- model.matrix(~ 0 + Age, data=thy.design)
ave.contrast <- c("Age1wk - (Age4wk + Age16wk + Age32wk + Age52wk)/4")
mod.constrast <- makeContrasts(contrasts=ave.contrast, levels=model)

mod.constrast

## -----------------------------------------------------------------------------
da_results <- testNhoods(thy.milo, design = ~ 0 + Age, design.df = thy.design, model.contrasts = ave.contrast, fdr.weighting="graph-overlap")
table(da_results$SpatialFDR < 0.1)
head(da_results)

## ----fig.width=10, fig.height=4.5---------------------------------------------
thy.milo <- buildNhoodGraph(thy.milo)

plotUMAP(thy.milo, colour_by="SubType") + plotNhoodGraphDA(thy.milo, da_results, alpha=0.1) +
  plot_layout(guides="auto" )

## -----------------------------------------------------------------------------
sessionInfo()

