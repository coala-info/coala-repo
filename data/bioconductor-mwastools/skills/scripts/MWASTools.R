# Code example from 'MWASTools' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, fig.path='figures/')

## ----tidy = TRUE, eval = FALSE, tidy.opts=list(indent = 4, width.cutoff = 90)----
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MWASTools", version = "devel")

## ----tidy = TRUE--------------------------------------------------------------
library(MWASTools)

## ----tidy = TRUE--------------------------------------------------------------
data("metabo_SE")
metabo_SE

## ----tidy = TRUE, results='asis', fig.width = 12, fig.height = 6, fig.pos = "center"----
# PCA model
PCA_model = QC_PCA (metabo_SE, scale = FALSE, center = TRUE)

# Plot PCA scores (PC1 vs PC2 & PC3 vs PC4)
par(mfrow=c(1,2))
QC_PCA_scoreplot (PCA_model, metabo_SE, main = "PC1 vs PC2")
QC_PCA_scoreplot (PCA_model, metabo_SE, px=3, py=4, main="PC3 vs PC4")

## ----tidy = TRUE, eval = TRUE, fig.width = 12, fig.height = 6-----------------
# CV calculation 
metabo_CV = QC_CV (metabo_SE, plot_hist = FALSE)

# NMR spectrum colored according to CVs
CV_spectrum = QC_CV_specNMR(metabo_SE, ref_sample = "QC1")

## ----tidy = TRUE--------------------------------------------------------------
# Filter metabolic-matrix based on a CV cut-off of 0.30
metabo_SE = CV_filter(metabo_SE, metabo_CV, CV_th = 0.30)

## ----tidy = TRUE, tidy.opts=list(indent = 4, width.cutoff = 50)---------------
# Run MWAS
MWAS_T2D = MWAS_stats(metabo_SE, disease_id = "T2D", confounder_ids = c("Age","Gender", "BMI"), 
                      assoc_method = "logistic", mt_method = "BH")

## ----tidy = TRUE, fig.width = 12, fig.height = 8------------------------------
# Visualize MWAS results 
skyline = MWAS_skylineNMR(metabo_SE, MWAS_T2D, ref_sample = "QC1")

## ----tidy = TRUE, fig.width = 12, fig.height = 6------------------------------
stocsy = STOCSY_NMR(metabo_SE, ppm_query = 1.04)

## ----tidy = TRUE--------------------------------------------------------------
kegg_pathways = MWAS_KEGG_pathways(metabolites = c("cpd:C00183", "cpd:C00407"))
head(kegg_pathways[, c(2, 4)])

