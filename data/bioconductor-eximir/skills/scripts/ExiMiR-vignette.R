# Code example from 'ExiMiR-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'ExiMiR-vignette.Rnw'

###################################################
### code chunk number 1: ExiMiR-vignette.Rnw:694-696
###################################################
library(ExiMiR)
data(GSE19183)


###################################################
### code chunk number 2: ExiMiR-vignette.Rnw:699-705
###################################################
library(affy)
eset.rma <- expresso(GSE19183, bgcorrect.method='rma',
			       normalize.method='quantiles',
			       pmcorrect.method='pmonly',
			       summary.method='medianpolish')



###################################################
### code chunk number 3: ExiMiR-vignette.Rnw:708-713
###################################################
eset.spike <- NormiR(GSE19183, bgcorrect.method='rma',
			       normalize.method='spikein',
			       normalize.param=list(figures.show=FALSE),
			       pmcorrect.method='pmonly',
			       summary.method='medianpolish')


###################################################
### code chunk number 4: ExiMiR-vignette.Rnw:723-726
###################################################
library(ExiMiR)
data(galenv)
data(GSE20122)


###################################################
### code chunk number 5: ExiMiR-vignette.Rnw:730-733
###################################################
eset.rma <- NormiR(GSE20122, bg.correct=FALSE,
			     normalize.method='quantile',
			     summary.method='medianpolish')


###################################################
### code chunk number 6: ExiMiR-vignette.Rnw:736-740
###################################################
eset.spike <- NormiR(GSE20122, bg.correct=FALSE,
			       normalize.method='spikein',
			       normalize.param=list(figures.show=FALSE),
			       summary.method='medianpolish')


