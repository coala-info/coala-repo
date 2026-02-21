# Code example from 'alpineData' vignette. See references/ for full tutorial.

## ------------------------------------------------------------------------
library(alpineData)

## ------------------------------------------------------------------------
ERR188297()
ERR188088()
ERR188204()
ERR188317()

## ------------------------------------------------------------------------
eh <- ExperimentHub()
query(eh, "ERR188")
eh[["EH166"]]

## ------------------------------------------------------------------------
library(GenomicAlignments)
gap <- ERR188297()
barplot(sort(table(seqnames(gap))[1:25], decreasing=TRUE),
        las=3, main="Distribution of reads")

## ------------------------------------------------------------------------
gap1 <- gap[seqnames(gap) == "1"]
starts <- start(first(gap1))
par(mfrow=c(2,2))
hist(starts,col="grey")

