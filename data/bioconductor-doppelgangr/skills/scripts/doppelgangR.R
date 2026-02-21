# Code example from 'doppelgangR' vignette. See references/ for full tutorial.

## ----echo=FALSE, results='hide', eval=FALSE-----------------------------------
# library(knitr)
# opts_knit$set(cache=TRUE)

## ----echo=FALSE, message=FALSE------------------------------------------------
library(doppelgangR)

## ----message = FALSE----------------------------------------------------------
library(curatedOvarianData)
data(GSE32062.GPL6480_eset)
data(GSE17260_eset)

## ----testesets----------------------------------------------------------------
testesets <- list(JapaneseA=GSE32062.GPL6480_eset,
                  Yoshihara2010=GSE17260_eset)

## ----rundopp, results="hide", message=FALSE, cache=TRUE-----------------------
results1 <- doppelgangR(testesets, phenoFinder.args=NULL)

## ----summarizedop, results='hide'---------------------------------------------
summary(results1)

## ----plotdop, fig.cap="Doppelgängers identified on the basis of similar expression profiles.  The vertical red lines indicate samples that were flagged."----
par(mfrow=c(2,2), las=1)
plot(results1)

## ----plotdop2, fig.cap="Pair plot of JapaneseA:JapaneseA Doppelgängers identified. The vertical red lines indicate samples that were flagged."----
plot(results1, plot.pair=c("JapaneseA", "JapaneseA"))

## ----rundopp2, results="hide", message=FALSE, eval=FALSE----------------------
# results1 <- doppelgangR(testesets,
#         outlierFinder.expr.args = list(bonf.prob = 1.0, transFun = atanh,
#                                        tail = "upper"))

## -----------------------------------------------------------------------------
mat <- matrix(1:4, ncol=2)
library(Biobase)
eset <- ExpressionSet(mat)
class(eset)

## ----eval=FALSE---------------------------------------------------------------
# results2 <- doppelgangR(testesets, BPPARAM = MulticoreParam(workers = 8))

