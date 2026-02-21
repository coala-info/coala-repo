# Code example from 'spicyR' vignette. See references/ for full tutorial.

params <-
list(test = FALSE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE
)
library(BiocStyle)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager")) {
#   install.packages("BiocManager")
# }
# BiocManager::install("spicyR")

## ----warning=FALSE, message=FALSE---------------------------------------------
# load required packages
library(SummarizedExperiment)

# code to work around the bug
methods::setClassUnion("ExpData", c("matrix", "dgCMatrix", "ExpressionSet",
                                    "SummarizedExperiment"))

library(spicyR)
library(ggplot2)
library(SpatialExperiment)
library(SpatialDatasets)
library(imcRtools)
library(dplyr)
library(survival)

## ----warning=FALSE, message=FALSE---------------------------------------------
kerenSPE <- SpatialDatasets::spe_Keren_2018()

## -----------------------------------------------------------------------------
spicyTestPair <- spicy(
  kerenSPE,
  condition = "tumour_type",
  from = "CD8_T_cell",
  to = "Neutrophils"
)

topPairs(spicyTestPair)

## -----------------------------------------------------------------------------
spicyTest <- spicy(
  kerenSPE,
  condition = "tumour_type"
)

topPairs(spicyTest)

## -----------------------------------------------------------------------------
bind(spicyTest)[1:5, 1:5]

## -----------------------------------------------------------------------------
signifPlot(
  spicyTest,
  breaks = c(-3, 3, 1),
  marksToPlot = c("Macrophages", "DC_or_Mono", "dn_T_CD3", "Neutrophils",
                  "CD8_T_cell", "Keratin_Tumour")
)

## -----------------------------------------------------------------------------
spicyBoxPlot(results = spicyTest, 
             # from = "Macrophages",
             # to = "dn_T_CD3"
             rank = 1)

## -----------------------------------------------------------------------------
kerenSPE <- imcRtools::buildSpatialGraph(kerenSPE, 
                                         img_id = "imageID", 
                                         type = "knn", k = 20,
                                        coords = c("x", "y"))

pairAbundances <- convPairs(kerenSPE,
                  colPair = "knn_interaction_graph")

head(pairAbundances["B_cell__B_cell"])

## -----------------------------------------------------------------------------
spicyTestColPairs <- spicy(
  kerenSPE,
  condition = "tumour_type",
  alternateResult = pairAbundances,
  weights = FALSE
)

topPairs(spicyTestColPairs)

## -----------------------------------------------------------------------------
signifPlot(
  spicyTestColPairs,
  breaks = c(-3, 3, 1),
  marksToPlot = c("Macrophages", "dn_T_CD3", "CD4_T_cell", 
                  "B_cell", "DC_or_Mono", "Neutrophils", "CD8_T_cell")
)

## -----------------------------------------------------------------------------
kerenSPE$event = 1 - kerenSPE$Censored
kerenSPE$survival = Surv(kerenSPE$`Survival_days_capped*`, kerenSPE$event)

## -----------------------------------------------------------------------------
# Running survival analysis
spicySurvival = spicy(kerenSPE,
                      condition = "survival")

# top 10 significant pairs
head(spicySurvival$survivalResults, 10)

## -----------------------------------------------------------------------------
# filter SPE object to obtain image 24 data
kerenSubset = kerenSPE[, colData(kerenSPE)$imageID == "24"]

pairwiseAssoc = getPairwise(kerenSubset, 
                            sigma = NULL, 
                            Rs = 100) |>
  as.data.frame()

pairwiseAssoc[["Keratin_Tumour__Neutrophils"]]

## -----------------------------------------------------------------------------
pairwiseAssoc = getPairwise(kerenSubset, 
                            sigma = 20, 
                            Rs = 100) |>
  as.data.frame()

pairwiseAssoc[["Keratin_Tumour__Neutrophils"]]

## -----------------------------------------------------------------------------
plotImage(kerenSPE, "24", from = "Keratin_Tumour", to = "Neutrophils")

## ----eval=FALSE---------------------------------------------------------------
# spicyMixedTest <- spicy(
#   diabetesData,
#   condition = "stage",
#   subject = "case"
# )

## -----------------------------------------------------------------------------
sessionInfo()

