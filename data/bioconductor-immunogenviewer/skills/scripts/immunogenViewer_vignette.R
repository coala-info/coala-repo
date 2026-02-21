# Code example from 'immunogenViewer_vignette' vignette. See references/ for full tutorial.

## ----options, include = FALSE-------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  message=FALSE, 
  warning=FALSE
)

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("immunogenViewer")

## ----load---------------------------------------------------------------------
library(immunogenViewer)

## ----get-features-------------------------------------------------------------
protein <- getProteinFeatures("Q9NZC2")
# check protein dataframe
DT::datatable(protein, width = "80%", options = list(scrollX = TRUE))

## ----add-immunogens-----------------------------------------------------------
protein <- addImmunogen(protein, start = 142, end = 192, name = "ABIN2783734_")
protein <- addImmunogen(protein, start = 196, end = 230, name = "HPA010917")
protein <- addImmunogen(protein, seq = "HGQKPGTHPPSELD", name = "EB07921")
# check that immunogens were added as columns
colnames(protein)

## ----rename-immunogen---------------------------------------------------------
protein <- renameImmunogen(protein, oldName = "ABIN2783734_", newName = "ABIN2783734")
# check that immunogen name was updated
colnames(protein)

## ----remove-immunogen---------------------------------------------------------
protein <- removeImmunogen(protein, name = "HPA010917")
# check that immunogen was removed
colnames(protein)

## ----visualize_protein, fig.fullwidth=TRUE, fig.width=10, fig.height=10, out.width = "100%"----
plotProtein(protein)

## ----visualize_immunogen, fig.fullwidth=TRUE, fig.width=10, fig.height=10, out.width = "100%"----
plotImmunogen(protein, "ABIN2783734")

## ----evaluate-----------------------------------------------------------------
immunogens <- evaluateImmunogen(protein)
# check summary dataframe
DT::datatable(immunogens, width = "80%", options = list(scrollX = TRUE))

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

