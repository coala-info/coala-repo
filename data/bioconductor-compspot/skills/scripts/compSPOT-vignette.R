# Code example from 'compSPOT-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("compSPOT")

## -----------------------------------------------------------------------------
library(compSPOT)

## ----load mutations-----------------------------------------------------------
data("compSPOT_example_mutations")

## ----load regions-------------------------------------------------------------
data("compSPOT_example_regions")

## ----sig.spots----------------------------------------------------------------
significant_spots <- find_hotspots(data = compSPOT_example_mutations, 
                                   regions = compSPOT_example_regions, 
                                   pvalue = 0.05, threshold = 0.2, 
                                   include_genes = TRUE, 
                                   rank = TRUE)

## ----table 1------------------------------------------------------------------
head(significant_spots[[1]])

## ----group.spot---------------------------------------------------------------
hotspots <- subset(significant_spots[[1]], type == "Hotspot")

group_comp <- compare_groups(data = compSPOT_example_mutations, 
                             regions = hotspots, pval = 0.05, 
                             threshold = 0.2, 
                             name1 = "High-Risk", 
                             name2 = "Low-Risk", 
                             include_genes = TRUE)

## ----table 2------------------------------------------------------------------
group_comp[[1]]

## ----feature.spot-------------------------------------------------------------
features <- c("AGE", "SEX", "SMOKING_HISTORY", "TUMOR_VOLUME", "KI_67")
feature_example <- compare_features(data = compSPOT_example_mutations, 
                                    regions = compSPOT_example_regions, 
                                    feature = features)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

