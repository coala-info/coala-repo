# Code example from 'SingleCellMultiModal' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(SingleCellMultiModal)
library(MultiAssayExperiment)

## ----echo=FALSE---------------------------------------------------------------
imgurl <- paste0(
    "https://github.com/waldronlab/MultiAssayExperiment/blob/",
    "c3c59a094e5a08111ee98b9f69579db5634d9fd4/vignettes/",
    "MultiAssayExperiment.png?raw=true"
)
knitr::include_graphics(
    path = imgurl
)

