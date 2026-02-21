# Code example from 'profileScoreDist-vignette' vignette. See references/ for full tutorial.

## ----init---------------------------------------------------------------------
library(profileScoreDist)

## ----inr----------------------------------------------------------------------
data(INR)
INR

## ----regularize---------------------------------------------------------------
inr.reg <- regularizeMatrix(INR)
inr.reg

## ----dist params--------------------------------------------------------------
granularity <- 0.05
gcgran <- 0.01
gcmin <- 0.01
gcmax <- 0.99
## gc fractions to consider
gcs <- seq(gcgran*round(gcmin/gcgran), gcgran*round(gcmax/gcgran), gcgran)

## ----dist---------------------------------------------------------------------
## compute probability distributions
distlist <- lapply(gcs, function(x) computeScoreDist(inr.reg, x, granularity))


## ----plot, fig.cap="Reproduction of Figure 1 in the article by Rahmann et al."----

distlist[[50]]
plotDist(distlist[[50]])


## ----cutoffs------------------------------------------------------------------

ab5 <- scoreDistCutoffs(distlist[[50]], 500, 1, c=1, 0.05)

## 5% FDR
ab5$cutoffa
## 5% FNR
ab5$cutoffb
## FDR = FNR
ab5$cutoffopt


