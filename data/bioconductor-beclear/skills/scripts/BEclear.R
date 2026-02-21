# Code example from 'BEclear' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(pander)
panderOptions('knitr.auto.asis', TRUE)
panderOptions('plain.ascii', TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("BEclear")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE)) {
#   install.packages("devtools")
# }
# devtools::install_github("uds-helms/BEclear")

## -----------------------------------------------------------------------------
library(BEclear)

## ----data---------------------------------------------------------------------
data("BEclearData")

## -----------------------------------------------------------------------------
knitr::kable(ex.data[1:10,1:5], caption = 'Some entries from the example data-set')

## -----------------------------------------------------------------------------
knitr::kable(ex.samples[1:10,], caption = 'Some entries from the example sample annotation')

## ----detection, cache=TRUE----------------------------------------------------
batchEffect <- calcBatchEffects(
  data = ex.data, samples = ex.samples,
  adjusted = TRUE, method = "fdr"
)
mdifs <- batchEffect$med
pvals <- batchEffect$pval

## ----summary, cache=TRUE------------------------------------------------------
summary <- calcSummary(medians = mdifs, pvalues = pvals)
knitr::kable(head(summary), caption = 'Summary over the batch affected gene-sample combination of the example data set')

## ----score, cache=TRUE--------------------------------------------------------
score <- calcScore(ex.data, ex.samples, summary, dir = getwd())
knitr::kable(score, caption = 'Batch scores of the example data-set')

## ----clearBE, cache=TRUE------------------------------------------------------
cleared.data <- clearBEgenes(ex.data, ex.samples, summary)

## ----imputation, cache=TRUE---------------------------------------------------
library(ids)
corrected.data <- imputeMissingData(cleared.data,
  rowBlockSize = 60,
  colBlockSize = 60, epochs = 50,
  outputFormat = "", dir = getwd()
)

## ----replace, cache=TRUE------------------------------------------------------
corrected.data.valid<-replaceOutsideValues(corrected.data)

## ----correction, cache=TRUE---------------------------------------------------
result <- correctBatchEffect(data = ex.data, samples = ex.samples)

## -----------------------------------------------------------------------------
?BiocParallel::BiocParallelParam

## ----boxplot1, fig.wide = TRUE, fig.cap = "Distribution of the example beta values grouped by sample"----
makeBoxplot(ex.data, ex.samples, score,
  bySamples = TRUE,
  col = "standard", main = "Example data", xlab = "Batch",
  ylab = "Beta value", scoreCol = TRUE)

## ----boxplot2, fig.wide = TRUE, fig.cap = "Distribution of the corrected beta values grouped by sample"----
makeBoxplot(corrected.data, ex.samples, score,
  bySamples = TRUE,
  col = "standard", main = "Corrected example data",
  xlab = "Batch", ylab = "Beta value", scoreCol = FALSE)

## ----sessionInfo, echo=FALSE--------------------------------------------------
pander(sessionInfo(), compact=TRUE)

