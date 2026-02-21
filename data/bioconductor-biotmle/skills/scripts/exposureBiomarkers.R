# Code example from 'exposureBiomarkers' vignette. See references/ for full tutorial.

## ----setup_data, message=FALSE, warning=FALSE---------------------------------
library(dplyr)
library(biotmle)
library(biotmleData)
library(BiocParallel)
library(SuperLearner)
library(SummarizedExperiment, quietly=TRUE)
data(illuminaData)
set.seed(13847)

## ----clean_data---------------------------------------------------------------
# discretize "age" in the phenotype-level data
colData(illuminaData) <- colData(illuminaData) %>%
  data.frame %>%
  mutate(age = as.numeric(age > median(age))) %>%
  DataFrame
benz_idx <- which(names(colData(illuminaData)) %in% "benzene")

## ----biomarkerTMLE_eval, message=FALSE, warning=FALSE-------------------------
# compute TML estimates to evaluate differentially expressed biomarkers
biotmle_out <- biomarkertmle(se = illuminaData[1:20, ],
                             varInt = benz_idx,
                             g_lib = c("SL.mean", "SL.glm"),
                             Q_lib = c("SL.bayesglm", "SL.ranger"),
                             cv_folds = 2,
                             bppar_type = SerialParam()
                            )

## ----limmaTMLE_eval-----------------------------------------------------------
modtmle_out <- modtest_ic(biotmle = biotmle_out)

## ----pval_hist_limma_adjp, eval=FALSE-----------------------------------------
# plot(x = modtmle_out, type = "pvals_adj")

## ----pval_hist_limma_rawp, eval=FALSE-----------------------------------------
# plot(x = modtmle_out, type = "pvals_raw")

## ----heatmap_limma_results----------------------------------------------------
benz_idx <- which(names(colData(illuminaData)) %in% "benzene")
designVar <- as.data.frame(colData(illuminaData))[, benz_idx]
designVar <- as.numeric(designVar == max(designVar))

# build heatmap
heatmap_ic(x = modtmle_out, left.label = "none", scale = TRUE,
           clustering.method = "hierarchical", row.dendrogram = TRUE,
           design = designVar, FDRcutoff = 1, top = 10)

## ----volcano_plot_limma_results-----------------------------------------------
volcano_ic(biotmle = modtmle_out)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

