# Code example from 'controls' vignette. See references/ for full tutorial.

## ----packages, include=F------------------------------------------------------
library(knitr)
opts_chunk$set(
  fig.pos = "!h", out.extra = "",
  fig.align = "center"
)

## ----warning=FALSE, message=F-------------------------------------------------
# For analysis
library(condiments)
library(slingshot)
set.seed(21)

## -----------------------------------------------------------------------------
data("toy_dataset", package = "condiments")
df <- toy_dataset$sd
rd <- as.matrix(df[, c("Dim1", "Dim2")])
sds <- slingshot(rd, df$cl)

## -----------------------------------------------------------------------------
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 10)
knitr::kable(top_res)

## -----------------------------------------------------------------------------
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 10,
                        methods = c("KS_mean", "Classifier"),
                        threshs = c(0, .01, .05, .1))
knitr::kable(top_res)

## -----------------------------------------------------------------------------
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 10,
                        methods = "wasserstein_permutation",
                        args_wass = list(fast = TRUE, S = 100, iterations  = 10^2))
knitr::kable(top_res)

## ----eval = FALSE-------------------------------------------------------------
# library(BiocParallel)
# BPPARAM <- bpparam()
# BPPARAM$progressbar <- TRUE
# BPPARAM$workers <- 4
# top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 100,
#                         parallel = TRUE, BPPARAM = BPPARAM)
# knitr::kable(top_res)

## -----------------------------------------------------------------------------
prog_res <- progressionTest(sds, conditions = df$conditions)
knitr::kable(prog_res)
dif_res <- fateSelectionTest(sds, conditions = df$conditions)
knitr::kable(dif_res)

## -----------------------------------------------------------------------------
prog_res <- progressionTest(sds, conditions = df$conditions, method = "Classifier")
knitr::kable(prog_res)
dif_res <- fateSelectionTest(sds, conditions = df$conditions, thresh = .05)
knitr::kable(dif_res)

## -----------------------------------------------------------------------------
prog_res <- progressionTest(sds, conditions = df$conditions, method = "Classifier",
                            args_classifier = list(method = "rf"))
knitr::kable(prog_res)
dif_res <- fateSelectionTest(sds, conditions = df$conditions)
knitr::kable(dif_res)

## -----------------------------------------------------------------------------
sessionInfo()

