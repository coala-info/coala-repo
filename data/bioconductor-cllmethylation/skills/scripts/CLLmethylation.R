# Code example from 'CLLmethylation' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library("ExperimentHub")
library("SummarizedExperiment")
library("ggplot2")

## -----------------------------------------------------------------------------
eh = ExperimentHub()
query(eh, "CLLmethylation")
meth = eh[["EH1071"]] # extract the methylation data

## -----------------------------------------------------------------------------
methData = t(assay(meth))
#filter to only include top 5000 most variable sites
ntop = 5000
methData = methData[,order(apply(methData, 2, var, na.rm=TRUE),
                          decreasing=TRUE)[1:ntop]]

## -----------------------------------------------------------------------------
# principal component analysis
pcaMeth = prcomp(methData, center=TRUE, scale. = FALSE)

## -----------------------------------------------------------------------------
summary(pcaMeth)

## -----------------------------------------------------------------------------
tmp = data.frame(pcaMeth$x)
ggplot(data=tmp, aes(x=PC1, y=PC2)) + geom_point() + theme_bw()

## -----------------------------------------------------------------------------
sessionInfo()

