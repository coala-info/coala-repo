# Code example from 'manual' vignette. See references/ for full tutorial.

## ----style, include=FALSE, results='hide'-------------------------------------
BiocStyle::markdown()
library(kableExtra)
library(magrittr)
library(SummarizedExperiment)

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("evaluomeR")

## ----sample-input, message=FALSE----------------------------------------------
library(evaluomeR)
data("ontMetrics")
data("rnaMetrics")
data("bioMetrics")

## ----correlations-1, echo=TRUE------------------------------------------------
library(evaluomeR)
data("rnaMetrics")
correlationSE <- metricsCorrelations(rnaMetrics, margins =  c(4,4,12,10))
# Access the correlation matrix via its first assay:
# assay(correlationSE,1)

## ----stability-1, results='hide', echo=TRUE, message=FALSE--------------------
stabilityData <- stability(rnaMetrics, k=2, bs = 100)

## ----stability-0-assay, echo=TRUE---------------------------------------------
stabilityData

## ----stability-1-assay, results='hide', echo=TRUE, eval=FALSE-----------------
# assay(stabilityData, "stability_mean")

## ----stability-1-table, results='asis', echo=FALSE----------------------------
data <- assay(stabilityData, "stability_mean")
kable(data) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))

## ----stabilityRange-1, results='hide', echo=TRUE, message=FALSE---------------
stabilityRangeData = stabilityRange(rnaMetrics, k.range=c(2,4), bs = 100)

## ----quality-1, results='hide', eval=TRUE, echo=TRUE, message=FALSE-----------
qualityData = quality(rnaMetrics, k = 4)

## ----quality-1-assay, results='hide', eval=FALSE, echo=TRUE-------------------
# assay(qualityData,1)

## ----quality-1-table, results='asis', echo=FALSE------------------------------
data <- assay(qualityData,1)
kable(data) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%")

## ----quality-range-1, results='hide', eval=TRUE, echo=TRUE, message=FALSE-----
k.range = c(4,6)
qualityRangeData = qualityRange(rnaMetrics, k.range)

## ----quality-range-2, eval=TRUE, echo=TRUE------------------------------------
diff(k.range)+1
length(qualityRangeData)

## ----quality-range-3, eval=FALSE, echo=TRUE-----------------------------------
# k5Data = qualityRangeData$k_5
# k5Data = qualityRangeData[["k_5"]]
# k5Data = getDataQualityRange(qualityRangeData, 5)
# assay(k5Data, 1)

## ----quality-range-table, results='asis', echo=FALSE--------------------------
data <- assay(qualityRangeData$k_5, 1)
kable(data) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "150px")

## ----general-func-noplot, eval=FALSE, echo=TRUE-------------------------------
# stabilityData <- stability(rnaMetrics, k=5, bs = 50, getImages = FALSE)

## ----getOptimalKValue, results='hide', eval=TRUE, echo=TRUE, message=FALSE----
stabilityData <- stabilityRange(data=ontMetrics, k.range=c(2,4), 
                                bs=20, getImages = FALSE, seed=100)
qualityData <- qualityRange(data=ontMetrics, k.range=c(2,4),
                            getImages = FALSE, seed=100)

kOptTable <- getOptimalKValue(stabilityData, qualityData)

## ----getOptimalKValue-table, results='asis', echo=FALSE-----------------------
data <- kOptTable
kable(data) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "150px")

## ----getOptimalKValue-delimited, results='hide', eval=TRUE, echo=TRUE---------
kOptTable <- getOptimalKValue(stabilityData, qualityData, k.range=c(3,4))

## ----getOptimalKValue-table-delimited, results='asis', echo=FALSE-------------
data <- kOptTable
kable(data) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "150px")

## ----plotMetricsMinMax, results='hide', eval=TRUE, echo=TRUE------------------
plotMetricsMinMax(ontMetrics)

## ----plotMetricsBoxplot, results='hide', eval=TRUE, echo=TRUE-----------------
plotMetricsBoxplot(rnaMetrics)

## ----plotMetricsCluster, results='hide', eval=TRUE, echo=TRUE-----------------
plotMetricsCluster(ontMetrics)

## ----plotMetricsViolin, results='hide', eval=TRUE, echo=TRUE------------------
plotMetricsViolin(rnaMetrics)

## ----sessionInfo, eval=TRUE---------------------------------------------------
sessionInfo()

