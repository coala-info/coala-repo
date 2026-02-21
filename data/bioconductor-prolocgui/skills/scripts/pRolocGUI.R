# Code example from 'pRolocGUI' vignette. See references/ for full tutorial.

## ----env, echo=FALSE----------------------------------------------------------
library("BiocStyle")

## ----loadPkgs, message = FALSE, warning = FALSE-------------------------------
library("pRolocGUI")
library("pRolocdata")

## ----loadData, echo = TRUE, message = FALSE, warning = FALSE------------------
data(hyperLOPIT2015)

## ----example, eval = FALSE, echo = TRUE---------------------------------------
# pRolocVis(object = hyperLOPIT2015, fcol = "markers")

## ----pca1, eval = FALSE, echo = TRUE------------------------------------------
# pRolocVis(object = hyperLOPIT2015, fcol = "markers")

## ----compare, eval = FALSE, echo = TRUE---------------------------------------
# data(hyperLOPIT2015ms3r1)
# data(hyperLOPIT2015ms3r2)
# mydata <- MSnSetList(list(hyperLOPIT2015ms3r1, hyperLOPIT2015ms3r2))
# pRolocVis(mydata, app = "compare", fcol = "markers")

## ----compare2, eval=FALSE, echo=TRUE------------------------------------------
# data("hyperLOPITU2OS2018")
# data("lopitdcU2OS2018")
# xx <- MSnSetList(list(hyperLOPITU2OS2018, lopitdcU2OS2018))
# if (interactive()) {
#   pRolocVis(xx, app = "compare", fcol = c("markers", "final.assignment"))
# }

## ----aggvar, eval = FALSE, echo = TRUE, message = FALSE, warning = FALSE------
# ## load PSM data
# data("hyperLOPIT2015ms2psm")
# 
# ## Visualise the PSMs per to protein group
# pRolocVis(hyperLOPIT2015ms2psm, app = "aggregate", fcol = "markers",
#           groupBy = "Protein.Group.Accessions")

## ----aggvar2, eval = FALSE, echo = TRUE, message = FALSE, warning = FALSE-----
# ## Combine PSM data to peptides
# hl <- combineFeatures(hyperLOPIT2015ms2psm,
#                       groupBy = fData(hyperLOPIT2015ms2psm)$Sequence,
#                       method = median)
# 
# ## Visualise peptides according to protein group
# pRolocVis(hyperLOPIT2015ms2psm, app = "aggregate", fcol = "markers",
#           groupBy = "Protein.Group.Accessions")

