# Code example from 'Codelink_Legacy' vignette. See references/ for full tutorial.

## ----include=FALSE,cache=FALSE------------------------------------------------
library(codelink)
library(knitr)
opts_chunk$set(fig.align = 'center', concordance=TRUE)

## ----input, eval=FALSE--------------------------------------------------------
# # NOT RUN #
# library(codelink)
# foo <- readCodelink()
# summaryFlag(foo) # will show a summary of flag values.
# # NOT RUN #

## ----data, comment=NA---------------------------------------------------------
data(codelink.example)

codelink.example

## ----input-flag, eval=FALSE---------------------------------------------------
# foo <- readCodelink(flag = list(M = 0.01) )

## ----bkgcorrect, eval=FALSE---------------------------------------------------
# foo <- bkgdCorrect(foo, method = "half")

## ----normalize, eval=FALSE----------------------------------------------------
# foo <- normalize(foo, method = "quantiles")

## ----plotMA-------------------------------------------------------------------
plotMA(codelink.example)

## ----plotDensity--------------------------------------------------------------
plotDensities(codelink.example)

## ----image, eval=FALSE--------------------------------------------------------
# imageCodelink(foo)
# imageCodelink(foo, what = "snr")

## ----merge, eval=FALSE--------------------------------------------------------
# foo <- mergeArray(foo, class = c(1, 1, 2, 2), names = c("A", "B"))
# plotCV(foo)

## ----read-fix, eval=FALSE-----------------------------------------------------
# foo <- readCodelink(fix = TRUE)

## ----read-codelinkSet, eval=FALSE---------------------------------------------
# foo <- readCodelinkSet()

