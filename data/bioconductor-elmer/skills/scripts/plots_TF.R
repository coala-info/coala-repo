# Code example from 'plots_TF' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE, warning=FALSE---------------------
library(ELMER.data)
library(ELMER)
library(DT)
library(dplyr)
library(BiocStyle)

## ----eval=TRUE,fig.cap=" TF ranking plot: For a given enriched motif, all human TF are ranked by the statistical $-log_{10}(P-value)$ assessing the anti-correlation level of candidate Master Regulator TF expression with average DNA methylation level for sites with the given motif. As a result, the most anti-correlated TFs will be ranked in the first positions. By default, the top 3 most anti-correlated TFs, and all TF classified by TFClass database in the same family and subfamily are highlighted with colors blue, red and orange, respectively."----
load("result/getTF.hypo.TFs.with.motif.pvalue.rda")
motif <- colnames(TF.meth.cor)[1]
TF.rank.plot(
  motif.pvalue = TF.meth.cor, 
  motif = motif,
  save = FALSE
) 

