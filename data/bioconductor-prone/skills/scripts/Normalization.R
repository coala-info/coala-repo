# Code example from 'Normalization' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = TRUE, warning = FALSE,
  fig.width=8,
  fig.height =6
)

## ----message = FALSE----------------------------------------------------------
# Load and attach PRONE
library(PRONE)

## ----load_real_tmt------------------------------------------------------------
data("tuberculosis_TMT_se")
se <- tuberculosis_TMT_se

## ----eval = TRUE, include = TRUE----------------------------------------------
se <- subset_SE_by_norm(se, ain = c("raw", "log2"))

## -----------------------------------------------------------------------------
get_normalization_methods()

## -----------------------------------------------------------------------------
se_norm <- normalize_se(se, c("RobNorm", "Mean", "Median"), 
                        combination_pattern = NULL)

## -----------------------------------------------------------------------------
se_norm <- normalize_se(se, c("RobNorm", "Mean", "Median", "IRS_on_RobNorm", 
                        "IRS_on_Mean", "IRS_on_Median"), 
                        combination_pattern = "_on_")

## -----------------------------------------------------------------------------
se_norm <- medianNorm(se_norm, ain = "log2", aout = "Median")

## -----------------------------------------------------------------------------
names(assays(se_norm))

## ----fig.cap = "Boxplots of protein intensities of all normalization methods of the SummarizedExperiment object. This plot shows the protein distributions across samples.", fig.height = 8----
plot_boxplots(se_norm, ain = NULL, color_by = NULL, 
              label_by = NULL, ncol = 3, facet_norm = TRUE) + 
  ggplot2::theme(legend.position = "bottom", legend.direction = "horizontal")


## ----fig.cap = "Boxplots of protein intensities of a selection of normalization methods and colored by batch. This plot shows the protein distributions across samples."----
plot_boxplots(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"), 
              color_by = "Pool", label_by = NULL, facet_norm = TRUE)

## ----fig.cap = "Single boxplot of protein intensities per selected normalization method and colored by batch .This plot shows the protein distributions across samples."----
plot_boxplots(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"), 
              color_by = "Pool", label_by = NULL, facet_norm = FALSE)

## ----fig.cap = "Density plot of protein intensities of for a selection of normalization method."----
plot_densities(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"), 
               color_by = NULL, facet_norm = TRUE)

## ----fig.cap = "Single PCA plot per normalization method, colored and faceted by condition, and shaped by batch effect. This plot helps to identify batch effects."----
plot_PCA(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"), 
         color_by = "Group", label_by = "No", shape_by = "Pool", 
         facet_norm = FALSE, facet_by = "Group")

## ----fig.cap = "Combined PCA plot of a selection of normalization methods, colored by condition and shaped by batch effect. This plot helps to identify batch effects."----
plot_PCA(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"), 
         color_by = "Group", label_by = "No", shape_by = "Pool", 
         facet_norm = TRUE)

## ----fig.cap = "Intragroup similarity measured by Pearson correlation for all normalization methods of the SummarizedExperiment object. The correlation between samples within the same group was calculated for all normalization methods and sample groups.."----
plot_intragroup_correlation(se_norm, ain = NULL, condition = NULL, 
                            method = "pearson")

## ----fig.cap = "Intragroup variation by calculation of the pooled coefficient of variation (PCV) for all normalization methods of the SummarizedExperiment object. The PCV was calculated for all normalization methods and sample groups."----
plot_intragroup_PCV(se_norm, ain = NULL, condition = NULL, diff = FALSE)

## ----fig.cap = "Intragroup variation by calculation of the pooled estimate of variance (PEV) for all normalization methods of the SummarizedExperiment object. The PEV was calculated for all normalization methods and sample groups."----
plot_intragroup_PEV(se_norm, ain = NULL, condition = NULL, diff = FALSE)

## ----fig.cap = "Intragroup variation by calculation of the pooled median absolute deviation (PMAD) for all normalization methods of the SummarizedExperiment object. The PMAD was calculated for all normalization methods and sample groups."----
plot_intragroup_PMAD(se_norm, ain = NULL, condition = NULL, diff = FALSE)

## ----fig.cap = "Reduction of intragroup variation, here using PCV, for all normalization methods of the SummarizedExperiment object compared to log2."----
plot_intragroup_PCV(se_norm, ain = NULL, condition = NULL, diff = TRUE) 

## ----fig.cap = "Reduction of intragroup variation, here using PEV, for all normalization methods of the SummarizedExperiment object compared to log2."----
plot_intragroup_PEV(se_norm, ain = NULL, condition = NULL, diff = TRUE)

## ----fig.cap = "Reduction of intragroup variation, here using PMAD, for all normalization methods of the SummarizedExperiment object compared to log2."----
plot_intragroup_PMAD(se_norm, ain = NULL, condition = NULL, diff = TRUE)

## -----------------------------------------------------------------------------
se_no_MAD <- remove_assays_from_SE(se_norm, assays_to_remove = c("Mean"))

## -----------------------------------------------------------------------------
se_subset <- subset_SE_by_norm(se_norm, 
                               ain = c("IRS_on_RobNorm", "IRS_on_Median"))

## -----------------------------------------------------------------------------
utils::sessionInfo()

