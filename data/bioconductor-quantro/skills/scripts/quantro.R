# Code example from 'quantro' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----install-quantro----------------------------------------------------------
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("quantro")

## ----lib-load, message=FALSE--------------------------------------------------
library(quantro)

## ----data-load, message=FALSE-------------------------------------------------
library(minfi)
data(flowSorted)
p <- getBeta(flowSorted, offset = 100)
pd <- pData(flowSorted)
dim(p)
head(pd)

## ----plot-distributions-density, fig.height=5, fig.width=6--------------------
matdensity(p, groupFactor = pd$CellType, xlab = " ", ylab = "density",
           main = "Beta Values", brewer.n = 8, brewer.name = "Dark2")
legend('top', c("NeuN_neg", "NeuN_pos"), col = c(1, 2), lty = 1, lwd = 3)

## ----plot-distributions-boxplot, fig.height=5, fig.width=6--------------------
matboxplot(p, groupFactor = pd$CellType, xaxt = "n", main = "Beta Values")

## ----calculate-quantro1-------------------------------------------------------
qtest <- quantro(object = p, groupFactor = pd$CellType)
qtest

## ----quantro-summary----------------------------------------------------------
summary(qtest)

## ----quantro-medians----------------------------------------------------------
anova(qtest)

## ----quantro-quantroStat------------------------------------------------------
quantroStat(qtest)

## ----flowSorted-fullEx--------------------------------------------------------
is(flowSorted, "MethylSet")
qtest <- quantro(flowSorted, groupFactor = pData(flowSorted)$CellType)
qtest 

## ----quantro-parallel---------------------------------------------------------
library(doParallel)
registerDoParallel(cores=1)
qtestPerm <- quantro(p, groupFactor = pd$CellType, B = 1000)
qtestPerm

## ----quantro-plot, fig.height=5, fig.width=6----------------------------------
quantroPlot(qtestPerm)

## ----sessionInfo, results='markup'--------------------------------------------
sessionInfo()

