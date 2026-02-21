# Code example from 'Merfish_mouse_hypothalamus' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MerfishData")

## ----message = FALSE----------------------------------------------------------
library(MerfishData)
library(ExperimentHub)
library(ggpubr)

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
AnnotationHub::query(eh, c("MerfishData", "hypothalamus"))

## ----message = FALSE----------------------------------------------------------
spe <- MouseHypothalamusMoffitt2018()
spe

## -----------------------------------------------------------------------------
assay(spe)[1:5,1:5]
assay(spe, "molecules")["Aldh1l1",1]
colData(spe)
head(spatialCoords(spe))

## -----------------------------------------------------------------------------
table(spatialCoords(spe)[,"z"])

## -----------------------------------------------------------------------------
table(spe$cell_class)

## -----------------------------------------------------------------------------
relz <- c(0.26, 0.16, 0.06, -0.04, -0.14, -0.24)
cdat <- data.frame(colData(spe), spatialCoords(spe))
cdat <- subset(cdat, cell_class != "Ambiguous")
cdat$cell_class <- sub(" [1-4]$", "", cdat$cell_class)
cdat <- subset(cdat, z %in% relz)
cdat$z <- as.character(cdat$z)
zum <- paste(0:5 * 100, "um")
names(zum) <- as.character(relz)
cdat$z <- unname(zum[cdat$z]) 

## ----fig.wide = TRUE, fig.width = 10, fig.height = 10-------------------------
pal <- get_palette("simpsons", 9)
names(pal) <- c("Endothelial", "Excitatory", "OD Immature", "Astrocyte", "Mural",
                "Microglia", "Ependymal", "Inhibitory", "OD Mature")
ggscatter(cdat, x = "x", y = "y", color = "cell_class", facet.by = "z",
          shape = 20, size = 1, palette = pal) +
          guides(color = guide_legend(override.aes = list(size = 3)))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

