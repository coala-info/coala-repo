# Code example from 'EBSEA' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(EBSEA)
data("exonCounts")
head(exonCounts)

## -----------------------------------------------------------------------------
filtCounts <- filterCounts(exonCounts)

## -----------------------------------------------------------------------------
group <- data.frame('group' = as.factor(c('G1', 'G1', 'G1', 'G2', 'G2', 'G2', 'G2')))
row.names(group) <- colnames(filtCounts)
design <- ~group
ebsea.out <- EBSEA(filtCounts, group, design)

## -----------------------------------------------------------------------------
group <- data.frame('group' = as.factor(c('G1', 'G1', 'G1', 'G2', 'G2', 'G2', 'G2')), 'paired' = as.factor(c(1,2,3,1,2,3,3)))
row.names(group) <- colnames(exonCounts)
design <- ~paired+group
ebsea.out <- EBSEA(exonCounts, group, design)

## -----------------------------------------------------------------------------
head(ebsea.out$ExonTable)

## -----------------------------------------------------------------------------
head(ebsea.out$GeneTable)

## ----fig.width = 6, fig.height= 6---------------------------------------------
visualizeGenes('FBgn0000064', ebsea.out)

