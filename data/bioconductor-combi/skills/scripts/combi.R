# Code example from 'combi' vignette. See references/ for full tutorial.

## ----load-packages, warning=FALSE, message=FALSE, echo=FALSE------------------
knitr::opts_chunk$set(cache = FALSE, autodep = TRUE, warning = FALSE, 
                      message = FALSE, echo = TRUE, eval = TRUE, 
                      tidy = TRUE, fig.width = 9, fig.height = 6, purl = TRUE, 
                      fig.show = "hold", cache.lazy = FALSE)
palStore = palette()
#Load all fits, to avoid refitting every time rebuilding the vignette
load(system.file("extdata", "zhangFits.RData", package = "combi"))

## ----install, eval = FALSE----------------------------------------------------
# library(BiocManager)
# BiocManager::install("combi", update = FALSE)

## ----installDevtools, eval = FALSE--------------------------------------------
# library(devtools)
# install_github("CenterForStatistics-UGent/combi")

## ----loadcombipackage---------------------------------------------------------
suppressPackageStartupMessages(library(combi))
cat("combi package version", 
    as.character(packageVersion("combi")), "\n")

## ----loadData-----------------------------------------------------------------
data(Zhang)

## ----unconstr-----------------------------------------------------------------
microMetaboInt = combi(
 list("microbiome" = zhangMicrobio, "metabolomics" = zhangMetabo),
 distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE),
 logTransformGaussian = FALSE)

## ----show---------------------------------------------------------------------
microMetaboInt

## ----simplePlot---------------------------------------------------------------
plot(microMetaboInt)

## ----colourPlot---------------------------------------------------------------
plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX")

## ----cloudPlot----------------------------------------------------------------
plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX", 
     featurePlot = "points")

## ----denPlot------------------------------------------------------------------
plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX", 
     featurePlot = "density")

## ----projections--------------------------------------------------------------
#First define the plot, and return the coordinates
mmPlot = plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX", returnCoords = TRUE, featNum = 10)
#Providing feature names, and sample coordinates, but any combination is allowed
addLink(mmPlot, links = cbind("Staphylococcus_819c11","OTU929ffc"), Views = 1, samples = c(0,1))

## ----extractCoords------------------------------------------------------------
coords = extractCoords(microMetaboInt, Dim = c(1,2))

## ----constr-------------------------------------------------------------------
microMetaboIntConstr = combi(
     list("microbiome" = zhangMicrobio, "metabolomics" = zhangMetabo),
     distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE),
     logTransformGaussian = FALSE, covariates = zhangMetavars)

## ----printConstr--------------------------------------------------------------
microMetaboIntConstr

## ----colourPlotConstr---------------------------------------------------------
plot(microMetaboIntConstr, samDf = zhangMetavars, samCol = "ABX")

## ----convPlot-----------------------------------------------------------------
convPlot(microMetaboInt)

## ----inflPlot-----------------------------------------------------------------
inflPlot(microMetaboInt, samples = 1:20, plotType = "boxplot")

## ----linFewVars, eval = FALSE-------------------------------------------------
# #Linear with only 2 variables
# microMetaboIntConstr2Vars = combi(
#      list("microbiome" = zhangMicrobio, "metabolomics" = zhangMetabo),
#      distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE),
#      logTransformGaussian = FALSE, covariates = zhangMetavars[, c("Sex", "ABX")])

## ----plotFewVars--------------------------------------------------------------
plot(microMetaboIntConstr2Vars, samDf = zhangMetavars, samCol = "ABX")

## ----Tweak, eval = FALSE------------------------------------------------------
# #Linear with only 2 variables
# microMetaboTweak = combi(
#      list("microbiome" = zhangMicrobio, "metabolomics" = zhangMetabo),
#      distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE),
#      logTransformGaussian = FALSE, initPower = 1.5, minFraction = 0.25, prevCutOff = 0.8)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

