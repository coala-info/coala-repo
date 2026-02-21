# Code example from 'RTNsurvival' vignette. See references/ for full tutorial.

## ----eval=TRUE----------------------------------------------------------------
library(RTN)
data(stni, package="RTN")

## ----eval=TRUE----------------------------------------------------------------
summary <- tni.get(stni, what = "summary")

## ----eval=FALSE---------------------------------------------------------------
# library(RTNsurvival)
# data(survival.data, package = "RTNsurvival")

## ----eval=TRUE, include=FALSE-------------------------------------------------
library(RTNsurvival)
data(survival.data, package = "RTNsurvival")

## ----eval=TRUE----------------------------------------------------------------
rtns <- tni2tnsPreprocess(stni, survivalData = survival.data, time = 1, event = 2, endpoint = 120, keycovar = c("Grade","Age"))

## ----eval=TRUE, results='hide'------------------------------------------------
rtns <- tnsGSEA2(rtns)

## ----eval=FALSE---------------------------------------------------------------
# rtns <- tnsCox(rtns)
# tnsPlotCox(rtns)

## ----eval=TRUE, include=FALSE-------------------------------------------------
rtns <- tnsCox(rtns)

## ----eval=FALSE---------------------------------------------------------------
# rtns <- tnsKM(rtns, sections = 2)
# tnsPlotKM(rtns, regs="FOXM1", attribs = list(c("ER+","ER-"),c("PR+","PR-"),c("G1","G2","G3"),"HT"))

## ----eval=TRUE, include=FALSE-------------------------------------------------
rtns <- tnsKM(rtns)

## ----eval=FALSE---------------------------------------------------------------
# tnsPlotGSEA2(rtns, "MB-5115", regs = "FOXM1")

## ----eval=TRUE, include=FALSE-------------------------------------------------
tnsPlotGSEA2(rtns, "MB-5115", regs = "FOXM1")

## ----eval = FALSE-------------------------------------------------------------
# library(pheatmap)
# enrichmentScores <- tnsGet(rtns, "regulonActivity")
# survival.data <- tnsGet(rtns, "survivalData")
# annotation_col <- survival.data[,c("ER+", "ER-")]
# pheatmap(t(enrichmentScores$dif),
#          annotation_col = annotation_col,
#          show_colnames = FALSE,
#          annotation_legend = FALSE)

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

