# Code example from 'QFeatures_nutshell' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## cf https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----hierarchy, message = FALSE, out.width = "600px"--------------------------
library(scp)
data("scp1")
plot(scp1)

## ----assay_data---------------------------------------------------------------
assay(scp1, "190321S_LCA10_X_FP97AG")[1:5, ]

## ----names--------------------------------------------------------------------
names(scp1)

## ----rowData------------------------------------------------------------------
rowData(scp1)
rowData(scp1)[["proteins"]]

## ----rowDataNames-------------------------------------------------------------
rowDataNames(scp1)

## ----rbindRowData-------------------------------------------------------------
rbindRowData(scp1, i = 1:5)

## ----colData------------------------------------------------------------------
colData(scp1)

## ----colData_dollar-----------------------------------------------------------
scp1$SampleType

## ----subset_assay-------------------------------------------------------------
scp1[, , "190321S_LCA10_X_FP97AG"]

## ----subsetByAssay------------------------------------------------------------
subsetByAssay(scp1, "190321S_LCA10_X_FP97AG")

## ----subset_samples-----------------------------------------------------------
scp1[, scp1$SampleType == "Macrophage", ]

## ----subsetByColData----------------------------------------------------------
subsetByColData(scp1, scp1$SampleType == "Macrophage")

## ----subset_features----------------------------------------------------------
scp1["Q02878", , ]

## ----subsetByFeature----------------------------------------------------------
subsetByFeature(scp1, "Q02878")

## ----filterFeatures-----------------------------------------------------------
filterFeatures(scp1, ~ Reverse != "+")

## ----filterNA-----------------------------------------------------------------
filterNA(scp1, i = "proteins", pNA = 0.7)

## ----zeroIsNA-----------------------------------------------------------------
table(assay(scp1, "peptides") == 0)
scp1 <-zeroIsNA(scp1, "peptides")
table(assay(scp1, "peptides") == 0)

## ----aggregateFeatures--------------------------------------------------------
aggregateFeatures(scp1, i = "190321S_LCA10_X_FP97AG", fcol = "protein",
                  name = "190321S_LCA10_X_FP97AG_aggr",
                  fun = MsCoreUtils::robustSummary)

## ----normalize----------------------------------------------------------------
normalize(scp1, "proteins", method = "center.mean",
          name = "proteins_mcenter")

## ----sweep--------------------------------------------------------------------
sf <- colSums(assay(scp1, "proteins"), na.rm = TRUE) / 1E4
sweep(scp1, i = "proteins",
      MARGIN = 2, ## 1 = by feature; 2 = by sample
      STATS = sf, FUN = "/",
      name = "proteins_sf")

## ----logTransform-------------------------------------------------------------
logTransform(scp1, i = "proteins", base = 2, pc = 1,
             name = "proteins_log")

## ----impute-------------------------------------------------------------------
anyNA(assay(scp1, "proteins"))
scp1 <- impute(scp1, i = "proteins", method ="knn", k = 3)
anyNA(assay(scp1, "proteins"))

## ----vis1, message = FALSE, fig.width = 6.5-----------------------------------
rd <- rbindRowData(scp1, i = 1:3)
library("ggplot2")
ggplot(data.frame(rd)) +
    aes(y = PIF,
        x = assay) +
    geom_boxplot()

## ----longForm-----------------------------------------------------------------
lf <- longForm(scp1[, , 1], colvars = c("SampleType", "Channel"))
ggplot(data.frame(lf)) +
    aes(x = Channel,
        y = value,
        colour = SampleType) +
    geom_boxplot()

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

