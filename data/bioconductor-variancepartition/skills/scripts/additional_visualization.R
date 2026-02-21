# Code example from 'additional_visualization' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results='hide'------------------------------------------------------------
library("knitr")
opts_chunk$set(
  tidy = FALSE, dev = "png", fig.show = "show",
  # fig.width=7,fig.height=7,
  echo = TRUE,
  message = FALSE, warning = FALSE
)

## ----initialize, cache=FALSE, echo=FALSE----------------------------------------------------------
# load library
library("variancePartition")

## ----corStruct, results='hide'--------------------------------------------------------------------
# Fit linear mixed model and examine correlation stucture
# for one gene
data(varPartData)

form <- ~ Age + (1 | Individual) + (1 | Tissue)

fitList <- fitVarPartModel(geneExpr[1:2, ], form, info)

# focus on one gene
fit <- fitList[[1]]

## ----corStructa, fig.width=7, fig.height=7--------------------------------------------------------
# Figure 1a
# correlation structure based on similarity within Individual
# reorder samples based on clustering
plotCorrStructure(fit, "Individual")

## ----corStructb, fig.width=7, fig.height=7--------------------------------------------------------
# Figure 1b
# use original order of samples
plotCorrStructure(fit, "Individual", reorder = FALSE)

## ----corStructc, fig.width=7, fig.height=7--------------------------------------------------------
# Figure 1c
# correlation structure based on similarity within Tissue
# reorder samples based on clustering
plotCorrStructure(fit, "Tissue")

## ----corStructd, fig.width=7, fig.height=7--------------------------------------------------------
# Figure 1d
# use original order of samples
plotCorrStructure(fit, "Tissue", reorder = FALSE)

## ----corStructe, fig.width=7, fig.height=7--------------------------------------------------------
# Figure 2a
# correlation structure based on similarity within
# Individual *and* Tissue, reorder samples based on clustering
plotCorrStructure(fit)

## ----corStructf, fig.width=7, fig.height=7--------------------------------------------------------
# Figure 2b
# use original order of samples
plotCorrStructure(fit, reorder = FALSE)

## ----session, echo=FALSE--------------------------------------------------------------------------
sessionInfo()

