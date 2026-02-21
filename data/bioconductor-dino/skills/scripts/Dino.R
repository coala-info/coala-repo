# Code example from 'Dino' vignette. See references/ for full tutorial.

## ----Initialize, echo=FALSE, results="hide", message=FALSE--------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----Install Dino BioC, eval = FALSE------------------------------------------
# # Install Bioconductor if not present, skip otherwise
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # Install Dino package
# BiocManager::install("Dino")
# 
# # View (this) vignette from R
# browseVignettes("Dino")

## ----Install Dino Github, eval = FALSE----------------------------------------
# devtools::install_github('JBrownBiostat/Dino', build_vignettes = TRUE)

## ----Quick Start, eval = FALSE------------------------------------------------
# library(Dino)
# 
# # Return a sparse matrix of normalized expression
# Norm_Mat <- Dino(UMI_Mat)
# 
# # Return a Seurat object from already normalized expression
# # Use normalized (doNorm = FALSE) and un-transformed (doLog = FALSE) expression
# Norm_Seurat <- SeuratFromDino(Norm_Mat, doNorm = FALSE, doLog = FALSE)
# 
# # Return a Seurat object from UMI expression
# # Transform normalized expression as log(x + 1) to improve
# # some types of downstream analysis
# Norm_Seurat <- SeuratFromDino(UMI_Mat)

## ----load pbmcSmall data------------------------------------------------------
set.seed(1)

# Bring pbmcSmall into R environment
library(Dino)
library(Seurat)
library(Matrix)
data("pbmcSmall")
print(dim(pbmcSmall))

## ----clean data---------------------------------------------------------------
# Filter genes for a minimum of non-zero expression
pbmcSmall <- pbmcSmall[rowSums(pbmcSmall != 0) >= 20, ]
print(dim(pbmcSmall))

## ----normalize data, eval = FALSE---------------------------------------------
# # Normalize data
# pbmcSmall_Norm <- Dino(pbmcSmall)

## ----normalize data background, echo = FALSE----------------------------------
invisible(capture.output(pbmcSmall_Norm <- Dino(pbmcSmall)))

## ----Seurat clustering--------------------------------------------------------
# Reformat normalized expression as a Seurat object
pbmcSmall_Seurat <- SeuratFromDino(pbmcSmall_Norm, doNorm = FALSE)

# Cluster pbmcSmall_Seurat
pbmcSmall_Seurat <- FindVariableFeatures(pbmcSmall_Seurat, 
                        selection.method = "mvp")
pbmcSmall_Seurat <- ScaleData(pbmcSmall_Seurat, 
                        features = rownames(pbmcSmall_Norm))
pbmcSmall_Seurat <- RunPCA(pbmcSmall_Seurat, 
                        features = VariableFeatures(object = pbmcSmall_Seurat),
                        verbose = FALSE)
pbmcSmall_Seurat <- FindNeighbors(pbmcSmall_Seurat, dims = 1:10)
pbmcSmall_Seurat <- FindClusters(pbmcSmall_Seurat, verbose = FALSE)
pbmcSmall_Seurat <- RunUMAP(pbmcSmall_Seurat, dims = 1:10)
DimPlot(pbmcSmall_Seurat, reduction = "umap")

## ----SinglleCellExperiment, eval = FALSE--------------------------------------
# # Reformatting pbmcSmall as a SingleCellExperiment
# library(SingleCellExperiment)
# pbmc_SCE <- SingleCellExperiment(assays = list("counts" = pbmcSmall))
# 
# # Run Dino
# pbmc_SCE <- Dino_SCE(pbmc_SCE)
# str(normcounts(pbmc_SCE))

## ----SinglleCellExperiment Background, echo = F-------------------------------
# Reformatting pbmcSmall as a SingleCellExperiment
library(SingleCellExperiment)
pbmc_SCE <- SingleCellExperiment(assays = list("counts" = pbmcSmall))

# Run Dino
invisible(capture.output(pbmc_SCE <- Dino_SCE(pbmc_SCE)))
str(normcounts(pbmc_SCE))

## ----Scran depths, eval = FALSE-----------------------------------------------
# library(scran)
# 
# # Compute scran size factors
# scranSizes <- calculateSumFactors(pbmcSmall)
# 
# # Re-normalize data
# pbmcSmall_SNorm <- Dino(pbmcSmall, nCores = 1, depth = log(scranSizes))

## ----Unimodal Simulation, echo = FALSE, warning = FALSE-----------------------
library(ggplot2)
library(gridExtra)
library(ggpubr)
library(grid)

themeObj <- theme(
    title = element_text(size = 17),
    plot.subtitle = element_text(size = 15),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    strip.text = element_text(size = 14),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
)

p1_func <- function(simDat, dinoLam, muVec, themeObj) {
    p1 <- ggplot(simDat, aes(x = LS, y = y)) +
        theme_classic() +
        geom_hex(aes(fill = log10(..count..))) +
        scale_fill_viridis_c() +
        labs(
            x = "log-Depth", y = "Expression (log)",
            title = "Fitted means", fill = "Count\n(log10)"
        )
    for(i in 1:length(dinoLam)) {
        p1 <- p1 +
            geom_abline(
                slope = 1, intercept = log1p(dinoLam[i]),
                col = 1, alpha = 0.5, lwd = 0.75
            )
    }
    for(i in 1:length(muVec)) {
        p1 <- p1 +
            geom_abline(
                slope = 1, intercept = log1p(muVec[i]),
                col = 2, lwd = 1.5
            )
    }
    p1 <- p1 +
        themeObj
}

p2_func <- function(plotDat, themeObj) {
    x.dens <- plotDat$x[plotDat$model == "NB"]
    y.dens <- plotDat$y[plotDat$model == "NB"]
    p2 <- ggplot(plotDat, aes(x = x, y = y, color = model)) +
        theme_classic() +
        geom_line() +
        scale_color_manual(values = 1:2) +
        labs(
            x = "Expression", y = "Density", color = "Model",
            title = "Reference vs.\nFitted distribution"
        ) +
        themeObj
    xInd <- which.max(
        y.dens < 1e-3 * max(y.dens) &
            x.dens > x.dens[which.max(y.dens)]
    )
    if(xInd > 1) {
        p2 <- p2 +
            xlim(c(
                0, 
                x.dens[which.max(
                    y.dens < 1e-3 * max(y.dens) &
                        x.dens > x.dens[which.max(y.dens)]
                )]
            ))
    }
    dinoDens <- data.frame(
        x = plotDat$x[plotDat$model == "Dino"],
        y = plotDat$y[plotDat$model == "Dino"]
    )
    if(max(y.dens) < max(dinoDens$y)) {
        p2 <- p2 +
            ylim(c(0, min(c(1.025 * max(dinoDens$y), 1.5 * max(y.dens)))))
    }
    return(p2)
}

plotSim_func <- function(plotList, themeObj) {
    p1 <- p1_func(plotList$simDat, plotList$dinoLam, plotList$muVec, themeObj)
    p2 <- p2_func(plotList$plotDat, themeObj)
    
    p <- grid.arrange(
        p1, p2, nrow = 1,
        top = textGrob(paste0("K = ", plotList$k), gp = gpar(fontsize = 17))
    )
    return(p)
}

data("unimodalDat")
plotSim_func(unimodalDat, themeObj)

## ----Multimodal Simulation, echo = FALSE, warning = FALSE---------------------
data("multimodalDat")
plotSim_func(multimodalDat, themeObj)

## -----------------------------------------------------------------------------
sessionInfo()

