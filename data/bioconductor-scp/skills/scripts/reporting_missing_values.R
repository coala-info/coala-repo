# Code example from 'reporting_missing_values' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----warning=FALSE, message=FALSE---------------------------------------------
library("scp")
library("scpdata")
leduc <- leduc2022()

## -----------------------------------------------------------------------------
leduc <- leduc[, , 1:30]
leduc <- selectRowData(leduc, c(
    "Sequence", "Leading.razor.protein", "Reverse",
    "Potential.contaminant", "PEP"
))

## ----message=FALSE------------------------------------------------------------
## 1.
leduc <- filterFeatures(leduc, ~ Reverse != "+" &
                           Potential.contaminant != "+" &
                           PEP < 0.01)
## 2.
leduc <- zeroIsNA(leduc, i = names(leduc))
## 3.
leduc <- subsetByColData(
    leduc, leduc$SampleType %in% c("Monocyte", "Melanoma")
)
## 4.
leduc <- filterNA(leduc, i = names(leduc), pNA = 0.9999)
leduc <- dropEmptyAssays(leduc)
## 5.
leduc <- aggregateFeatures(
    leduc, i = names(leduc), name = paste0("peptides_", names(leduc)),
    fcol = "Sequence", fun = colMedians
)
## 6.
leduc <- joinAssays(
    leduc, i = grep("^peptides_", names(leduc)), name = "peptides"
)

## -----------------------------------------------------------------------------
reportMissingValues(leduc, "peptides", by = leduc$SampleType)

## -----------------------------------------------------------------------------
ji <- jaccardIndex(leduc, "peptides", by = leduc$SampleType)

## -----------------------------------------------------------------------------
library("ggplot2")
ggplot(ji) +
    aes(x = jaccard) +
    geom_histogram() +
    facet_grid(~ by)

## -----------------------------------------------------------------------------
csc <- cumulativeSensitivityCurve(leduc, "peptides", by = leduc$SampleType,
                                  batch = leduc$Set, niters = 10,
                                  nsteps = 30)

## -----------------------------------------------------------------------------
(plCSC <- ggplot(csc) +
    aes(x = SampleSize, y = Sensitivity, colour = by) +
    geom_point(size = 1))

## -----------------------------------------------------------------------------
predCSC <- predictSensitivity(csc, nSample = 1:30)
plCSC + geom_line(data = predCSC)

## -----------------------------------------------------------------------------
predictSensitivity(csc, nSamples = Inf)

