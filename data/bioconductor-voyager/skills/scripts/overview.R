# Code example from 'overview' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", fig.align = "center"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager")) install.packages("BiocManager")
# BiocManager::install("Voyager")
# # Devel version
# # install.packages("remotes")
# remotes::install_github("pachterlab/Voyager")

## ----message=FALSE------------------------------------------------------------
library(SFEData)
library(SpatialFeatureExperiment)
library(SpatialExperiment)
library(ggplot2)
library(Voyager)
library(scater)
library(scran)
library(pheatmap)

## -----------------------------------------------------------------------------
if (!file.exists("tissue_lowres_5a.jpeg")) {
    download.file("https://raw.githubusercontent.com/pachterlab/voyager/main/vignettes/tissue_lowres_5a.jpeg",
                  destfile = "tissue_lowres_5a.jpeg")
}

## -----------------------------------------------------------------------------
knitr::include_graphics("tissue_lowres_5a.jpeg")

## -----------------------------------------------------------------------------
sfe <- McKellarMuscleData()

## -----------------------------------------------------------------------------
sfe <- addImg(sfe, imageSource = "tissue_lowres_5a.jpeg", sample_id = "Vis5A", 
              image_id = "lowres", scale_fct = 1024/22208)

## -----------------------------------------------------------------------------
sfe <- mirrorImg(sfe, sample_id = "Vis5A", image_id = "lowres")

## -----------------------------------------------------------------------------
# Only use spots in tissue here
sfe <- sfe[,colData(sfe)$in_tissue]
sfe <- logNormCounts(sfe)
sfe

## -----------------------------------------------------------------------------
colGraph(sfe, "visium") <- findVisiumGraph(sfe)

## -----------------------------------------------------------------------------
features_use <- c("Myh1", "Myh2")

## -----------------------------------------------------------------------------
sfe <- runUnivariate(sfe, type = "moran", features = features_use, 
                     colGraphName = "visium", swap_rownames = "symbol")
# Look at the results
rowData(sfe)[rowData(sfe)$symbol %in% features_use,]

## -----------------------------------------------------------------------------
sfe <- runUnivariate(sfe, type = "localG", features = features_use,
                     colGraphName = "visium", include_self = TRUE, 
                     swap_rownames = "symbol")
# Look at the results
head(localResults(sfe, name = "localG")[[1]])

## -----------------------------------------------------------------------------
gs <- modelGeneVar(sfe)
hvgs <- getTopHVGs(gs, fdr.threshold = 0.01)

## -----------------------------------------------------------------------------
res <- calculateBivariate(sfe, "lee", hvgs)

## ----fig.width=6, fig.height=6------------------------------------------------
pheatmap(res, color = scales::viridis_pal()(256), cellwidth = 1, cellheight = 1,
         show_rownames = FALSE, show_colnames = FALSE)

## -----------------------------------------------------------------------------
hvgs2 <- getTopHVGs(gs, n = 1000)
sfe <- runMultivariate(sfe, "multispati", colGraphName = "visium", subset_row = hvgs2,
                       nfposi = 10, nfnega = 10)

## -----------------------------------------------------------------------------
plotSpatialFeature(sfe, c("nCounts", "Myh1"), colGeometryName = "spotPoly", 
                   annotGeometryName = "myofiber_simplified", 
                   aes_use = "color", linewidth = 0.5, fill = NA,
                   annot_aes = list(fill = "area"), swap_rownames = "symbol")

## -----------------------------------------------------------------------------
plotLocalResult(sfe, "localG", features = features_use, 
                colGeometryName = "spotPoly", divergent = TRUE, 
                diverge_center = 0, swap_rownames = "symbol",
                image_id = "lowres", maxcell = 5e+4)

## -----------------------------------------------------------------------------
ElbowPlot(sfe, ndims = 10, nfnega = 10, reduction = "multispati") + theme_bw()

## -----------------------------------------------------------------------------
spatialReducedDim(sfe, "multispati", ncomponents = 2, image_id = "lowres", 
                  maxcell = 5e+4, divergent = TRUE, diverge_center = 0)

## -----------------------------------------------------------------------------
sessionInfo()

