# Code example from 'milo_glmm' vignette. See references/ for full tutorial.

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
library(scRNAseq)
library(scuttle)
library(irlba)
library(BiocParallel)
library(ggplot2)
library(sparseMatrixStats)

## -----------------------------------------------------------------------------
# uncomment the row below to allow multi-processing and comment out the SerialParam line.
# bpparam <- MulticoreParam(workers=4)
bpparam <- SerialParam()
register(bpparam)

pbmc.sce <- KotliarovPBMCData(mode="rna", ensembl=TRUE) # download the PBMC data from Kotliarov _et al._

# downsample cells to reduce compute time
prop.cells <- 0.75
n.cells <- floor(ncol(pbmc.sce) * prop.cells)
set.seed(42)
keep.cells <- sample(colnames(pbmc.sce), size=n.cells)
pbmc.sce <- pbmc.sce[, colnames(pbmc.sce) %in% keep.cells]


# downsample the number of samples
colData(pbmc.sce)$ObsID <- paste(colData(pbmc.sce)$tenx_lane, colData(pbmc.sce)$sampleid, sep="_")
n.samps <- 80
keep.samps <- sample(unique(colData(pbmc.sce)$ObsID), size=n.samps)
keep.cells <- rownames(colData(pbmc.sce))[colData(pbmc.sce)$ObsID %in% keep.samps]
pbmc.sce <- pbmc.sce[, colnames(pbmc.sce) %in% keep.cells]

pbmc.sce

## -----------------------------------------------------------------------------
set.seed(42)
# remove sparser cells
drop.cells <- colSums(counts(pbmc.sce)) < 1000
pbmc.sce <- computePooledFactors(pbmc.sce[, !drop.cells], BPPARAM=bpparam)
pbmc.sce <- logNormCounts(pbmc.sce)

pbmc.hvg <- modelGeneVar(pbmc.sce)
pbmc.hvg$FDR[is.na(pbmc.hvg$FDR)] <- 1

pbmc.sce <- runPCA(pbmc.sce, subset_row=rownames(pbmc.sce)[pbmc.hvg$FDR < 0.1], scale=TRUE, ncomponents=50, assay.type="logcounts", name="PCA", BPPARAM=bpparam)
pbmc.sce

## ----fig.height=4.1, fig.width=10.5-------------------------------------------
set.seed(42)
pbmc.sce <- runUMAP(pbmc.sce, n_neighbors=30, pca=50, BPPARAM=bpparam) # add a UMAP for plotting results later

pbmc.milo <- Milo(pbmc.sce) # from the SCE object
reducedDim(pbmc.milo, "UMAP") <- reducedDim(pbmc.sce, "UMAP")

plotUMAP(pbmc.milo, colour_by="adjmfc.time") + plotUMAP(pbmc.milo, colour_by="sampleid")

## -----------------------------------------------------------------------------
set.seed(42)
# we build KNN graph
pbmc.milo <- buildGraph(pbmc.milo, k = 60, d = 30)
pbmc.milo <- makeNhoods(pbmc.milo, prop = 0.05, k = 60, d=30, refined = TRUE, refinement_scheme="graph") # make nhoods using graph-only as this is faster
colData(pbmc.milo)$ObsID <- paste(colData(pbmc.milo)$tenx_lane, colData(pbmc.milo)$sampleid, sep="_")
pbmc.milo <- countCells(pbmc.milo, meta.data = data.frame(colData(pbmc.milo)), samples="ObsID") # make the nhood X sample counts matrix
pbmc.milo

## -----------------------------------------------------------------------------
plotNhoodSizeHist(pbmc.milo)

## -----------------------------------------------------------------------------
pbmc.design <- data.frame(colData(pbmc.milo))[,c("tenx_lane", "adjmfc.time", "sample", "sampleid", "timepoint", "ObsID")]
pbmc.design <- distinct(pbmc.design)
rownames(pbmc.design) <- pbmc.design$ObsID
## Reorder rownames to match columns of nhoodCounts(milo)
pbmc.design <- pbmc.design[colnames(nhoodCounts(pbmc.milo)), , drop=FALSE]
table(pbmc.design$adjmfc.time)

## ----warning=FALSE------------------------------------------------------------
set.seed(42)
rownames(pbmc.design) <- pbmc.design$ObsID

da_results <- testNhoods(pbmc.milo, design = ~ adjmfc.time + (1|tenx_lane), design.df = pbmc.design, fdr.weighting="graph-overlap",
                         glmm.solver="Fisher", REML=TRUE, norm.method="TMM", BPPARAM = bpparam, fail.on.error=FALSE)
table(da_results$SpatialFDR < 0.1)

## -----------------------------------------------------------------------------
which(is.na(da_results$logFC))

## -----------------------------------------------------------------------------
which(checkSeparation(pbmc.milo, design.df=pbmc.design, condition="adjmfc.time", min.val=10))

## -----------------------------------------------------------------------------
plotNhoodCounts(pbmc.milo, which(checkSeparation(pbmc.milo, design.df=pbmc.design, condition="adjmfc.time", min.val=10)), 
                design.df=pbmc.design, condition="adjmfc.time")

## -----------------------------------------------------------------------------
head(da_results[!is.na(da_results$logFC), ])

## -----------------------------------------------------------------------------
ggplot(da_results, aes(x=Converged, y=`tenx_lane_variance`)) +
    geom_boxplot() + 
    scale_y_log10() +
    NULL

## ----fig.width=10, fig.height=4.5---------------------------------------------
pbmc.milo <- buildNhoodGraph(pbmc.milo, overlap=25)

# we need to subset the plotting results as it can't handle the NAs internally.
plotUMAP(pbmc.milo, colour_by="adjmfc.time") + plotNhoodGraphDA(pbmc.milo, da_results,
                                                                alpha=0.1) +
  plot_layout(guides="auto" )

## -----------------------------------------------------------------------------
set.seed(42)
# we need to use place the test variable at the end of the formula
glm_results <- testNhoods(pbmc.milo, design = ~ tenx_lane + adjmfc.time, design.df = pbmc.design, fdr.weighting="graph-overlap",
                          REML=TRUE, norm.method="TMM", BPPARAM = bpparam)
table(glm_results$SpatialFDR < 0.1)

## ----fig.width=10, fig.height=4.5---------------------------------------------
plotUMAP(pbmc.milo, colour_by="adjmfc.time") + plotNhoodGraphDA(pbmc.milo, glm_results, alpha=0.1) +
  plot_layout(guides="auto" )

## -----------------------------------------------------------------------------
comp.da <- merge(da_results, glm_results, by='Nhood')
comp.da$Sig <- "none"
comp.da$Sig[comp.da$SpatialFDR.x < 0.1 & comp.da$SpatialFDR.y < 0.1] <- "Both"
comp.da$Sig[comp.da$SpatialFDR.x >= 0.1 & comp.da$SpatialFDR.y < 0.1] <- "GLM"
comp.da$Sig[comp.da$SpatialFDR.x < 0.1 & comp.da$SpatialFDR.y >= 0.1] <- "GLMM"

ggplot(comp.da, aes(x=logFC.x, y=logFC.y)) +
    geom_point(data=comp.da[, c("logFC.x", "logFC.y")], aes(x=logFC.x, y=logFC.y),
               colour='grey80', size=1) +
    geom_point(aes(colour=Sig)) +
    labs(x="GLMM LFC", y="GLM LFC") +
    facet_wrap(~Sig) +
    NULL

## -----------------------------------------------------------------------------
sessionInfo()

