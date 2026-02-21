# Code example from 'SEPA' vignette. See references/ for full tutorial.

## ------------------------------------------------------------------------
library(SEPA)
library(topGO)
library(ggplot2)
library(org.Hs.eg.db)
data(HSMMdata)
truepattern <- truetimepattern(HSMMdata,truetime)
head(truepattern)

## ------------------------------------------------------------------------
patternsummary(truepattern)

## ------------------------------------------------------------------------
truetimevisualize(HSMMdata,truetime,"ENSG00000122180.4")

## ------------------------------------------------------------------------
data(HSMMdata)
pseudopattern <- pseudotimepattern(HSMMdata,pseudotime)

## ------------------------------------------------------------------------
patternsummary(pseudopattern)

## ------------------------------------------------------------------------
head(pseudopattern$pattern$constant_up)

## ------------------------------------------------------------------------
pseudotimevisualize(pseudopattern,"ENSG00000122180.4")

## ------------------------------------------------------------------------
pseudotimevisualize(pseudopattern,c("ENSG00000122180.4","ENSG00000108821.9"))

## ----message=FALSE-------------------------------------------------------
patternGOanalysis(truepattern,type=c("constant_up","constant_down"),termnum = 5)

## ----message=FALSE-------------------------------------------------------
patternGOanalysis(pseudopattern,type=c("constant_up","constant_down"),termnum = 5)

## ----message=FALSE-------------------------------------------------------
(GOresults <- windowGOanalysis(pseudopattern,type="constant_up",windowsize = 20, termnum=5))

## ------------------------------------------------------------------------
windowGOvisualize(GOresults)

