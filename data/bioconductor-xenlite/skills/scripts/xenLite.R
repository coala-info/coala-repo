# Code example from 'xenLite' vignette. See references/ for full tutorial.

## ----doinst,eval=FALSE--------------------------------------------------------
# BiocManager::install("xenLite")

## ----dolung, fig.width=7, fig.height=7,message=FALSE--------------------------
library(xenLite)
pa <- cacheXenLuad()
luad <- restoreZipXenSPEP(pa)
rownames(luad) <- make.names(SummarizedExperiment:::rowData(luad)$Symbol, unique = TRUE)
out <- viewSegG2(luad, c(5800, 6300), c(1300, 1800), lwd = .5, gene1 = "CD4", gene2 = "EPCAM")
legend(5800, 1390, fill = c("purple", "cyan", "pink"), legend = c("CD4", "EPCAM", "both"))
out$ncells

## ----lkmap,echo=FALSE,fig.cap="Map based on cell centroids."------------------
knitr::include_graphics("fblmap.png")

## ----lkzm,echo=FALSE,fig.cap="Zoom to slider-specified subplot."--------------
knitr::include_graphics("FBLsketch.png")

## ----doprost1,eval=FALSE------------------------------------------------------
# prost <- cacheXenProstLite()

## ----doprost2,eval=FALSE------------------------------------------------------
# dir.create(xpw <- file.path(tempdir(), "prost_work"))
# unzip(prost, exdir = xpw)
# dir(xpw)

## ----doprost3,eval=FALSE------------------------------------------------------
# prostx <- HDF5Array::loadHDF5SummarizedExperiment(file.path(xpw, "xen_prost"))
# prostx

## ----lksi---------------------------------------------------------------------
sessionInfo()

