# Code example from 'Merfish_mouse_ileum' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----message = FALSE----------------------------------------------------------
library(MerfishData)
library(ExperimentHub)
library(ggplot2)
library(grid)

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
AnnotationHub::query(eh, c("MerfishData", "ileum"))

## ----mol-data, message = FALSE, warning = FALSE-------------------------------
mol.dat <- eh[["EH7543"]]
dim(mol.dat)
head(mol.dat)
length(unique(mol.dat$gene))

## ----dapi-img, message = FALSE, warning = FALSE, fig.height = 10--------------
dapi.img <- eh[["EH7544"]]
dapi.img
plot(dapi.img, all = TRUE)
plot(dapi.img, frame = 1)

## ----mem-img, message = FALSE, warning = FALSE, fig.height = 10---------------
mem.img <- eh[["EH7545"]]
mem.img
plot(mem.img, all = TRUE)
plot(mem.img, frame = 1)

## ----baysor-spe, message = FALSE----------------------------------------------
spe.baysor <- MouseIleumPetukhov2021(segmentation = "baysor")
spe.baysor

## ----baysor-spe-show----------------------------------------------------------
assay(spe.baysor, "counts")[1:5,1:5]
assay(spe.baysor, "molecules")["Acsl1",5]
colData(spe.baysor)
head(spatialCoords(spe.baysor))
imgData(spe.baysor)

## ----cellpose-spe, message = FALSE--------------------------------------------
spe.cellpose <- MouseIleumPetukhov2021(segmentation = "cellpose",
                                       use.images = FALSE)
spe.cellpose

## ----cellpose-spe-show--------------------------------------------------------
assay(spe.cellpose, "counts")[1:5,1:5]
colData(spe.cellpose)
head(spatialCoords(spe.cellpose))

## ----fig.width = 6, fig.height = 4--------------------------------------------
seg <- rep(c("baysor", "cellpose"), c(ncol(spe.baysor), ncol(spe.cellpose)))
ns <- table(seg, c(spe.baysor$leiden_final, spe.cellpose$leiden_final))
df <- as.data.frame(ns, responseName = "n_cells")
colnames(df)[2] <- "leiden_final"
ggplot(df, aes(
    reorder(leiden_final, n_cells), n_cells, fill = seg)) +
    geom_bar(stat = "identity", position = "dodge") +
    xlab("") +
    ylab("Number of cells") + 
    theme_bw() +
    theme(
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1))

## -----------------------------------------------------------------------------
mem.img <- imgRaster(spe.baysor, image_id = "membrane")

## ----viz-cells, results = "asis", fig.height = 8, warning = FALSE-------------
spe.list <- list(Baysor = spe.baysor, Cellpose = spe.cellpose)
plotTabset(spe.list, mem.img)

## ----fig.height = 8-----------------------------------------------------------
gs <- grep("^Cd", unique(mol.dat$gene), value = TRUE)
ind <- mol.dat$gene %in% gs
rel.cols <- c("gene", "x_pixel", "y_pixel")
sub.mol.dat <- mol.dat[ind, rel.cols]
colnames(sub.mol.dat)[2:3] <- sub("_pixel$", "", colnames(sub.mol.dat)[2:3])
plotXY(sub.mol.dat, "gene", mem.img)

## -----------------------------------------------------------------------------
poly <- metadata(spe.baysor)$polygons
poly <- as.data.frame(poly)
poly.z1 <- subset(poly, z == 1)

## -----------------------------------------------------------------------------
poly.z1 <- addHolesToPolygons(poly.z1)

## ----fig.height = 8-----------------------------------------------------------
p <- plotRasterImage(mem.img)
p <- p + geom_polygon(
            data = poly.z1,
            aes(x = x, y = y, group = cell, subgroup = subid), 
            fill = "lightblue")
p + theme_void()

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

