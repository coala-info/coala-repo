# Code example from 'POMA-workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.align = "center",
  comment = ">"
)

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("BiocManager")
# BiocManager::install("POMA")

## ----warning = FALSE, message = FALSE-----------------------------------------
library(POMA)
library(ggtext)
library(magrittr)

## ----eval = FALSE-------------------------------------------------------------
# # create an SummarizedExperiment object from two separated data frames
# target <- readr::read_csv("your_target.csv")
# features <- readr::read_csv("your_features.csv")
# 
# data <- PomaCreateObject(metadata = target, features = features)

## ----warning = FALSE, message = FALSE-----------------------------------------
# load example data
data("st000336")

## ----warning = FALSE, message = FALSE-----------------------------------------
st000336

## -----------------------------------------------------------------------------
imputed <- st000336 %>% 
  PomaImpute(method = "knn", zeros_as_na = TRUE, remove_na = TRUE, cutoff = 20)

imputed

## -----------------------------------------------------------------------------
normalized <- imputed %>% 
  PomaNorm(method = "log_pareto")

normalized

## ----message = FALSE----------------------------------------------------------
PomaBoxplots(imputed, x = "samples") # data before normalization

## ----message = FALSE----------------------------------------------------------
PomaBoxplots(normalized, x = "samples") # data after normalization

## ----message = FALSE----------------------------------------------------------
PomaDensity(imputed, x = "features") # data before normalization

## ----message = FALSE----------------------------------------------------------
PomaDensity(normalized, x = "features") # data after normalization

## -----------------------------------------------------------------------------
PomaOutliers(normalized)$polygon_plot
pre_processed <- PomaOutliers(normalized)$data
pre_processed

## -----------------------------------------------------------------------------
# pre_processed %>% 
#   PomaUnivariate(method = "ttest") %>% 
#   magrittr::extract2("result")

## -----------------------------------------------------------------------------
# imputed %>% 
#   PomaVolcano(pval = "adjusted", labels = TRUE)

## ----warning = FALSE----------------------------------------------------------
# pre_processed %>% 
#   PomaUnivariate(method = "mann") %>% 
#   magrittr::extract2("result")

## -----------------------------------------------------------------------------
# PomaLimma(pre_processed, contrast = "Controls-DMD", adjust = "fdr")

## -----------------------------------------------------------------------------
# poma_pca <- PomaMultivariate(pre_processed, method = "pca")

## -----------------------------------------------------------------------------
# poma_pca$scoresplot +
#   ggplot2::ggtitle("Scores Plot")

## ----warning = FALSE, message = FALSE, results = 'hide'-----------------------
# poma_plsda <- PomaMultivariate(pre_processed, method = "plsda")

## -----------------------------------------------------------------------------
# poma_plsda$scoresplot +
#   ggplot2::ggtitle("Scores Plot")

## -----------------------------------------------------------------------------
# poma_plsda$errors_plsda_plot +
#   ggplot2::ggtitle("Error Plot")

## -----------------------------------------------------------------------------
# poma_cor <- PomaCorr(pre_processed, label_size = 8, coeff = 0.6)
# poma_cor$correlations
# poma_cor$corrplot
# poma_cor$graph

## -----------------------------------------------------------------------------
# PomaCorr(pre_processed, corr_type = "glasso", coeff = 0.6)$graph

## -----------------------------------------------------------------------------
# alpha = 1 for Lasso
# PomaLasso(pre_processed, alpha = 1, labels = TRUE)$coefficientPlot

## -----------------------------------------------------------------------------
# poma_rf <- PomaRandForest(pre_processed, ntest = 10, nvar = 10)
# poma_rf$error_tree

## -----------------------------------------------------------------------------
# poma_rf$confusionMatrix$table

## -----------------------------------------------------------------------------
# poma_rf$MeanDecreaseGini_plot

## -----------------------------------------------------------------------------
sessionInfo()

