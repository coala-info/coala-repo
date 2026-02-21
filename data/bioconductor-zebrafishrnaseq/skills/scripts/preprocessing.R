# Code example from 'preprocessing' vignette. See references/ for full tutorial.

## ----loadData-----------------------------------------------------------------
library(zebrafishRNASeq)
data(zfGenes)

head(zfGenes)

## ----ercc, eval=TRUE, results="markup"----------------------------------------
spikes <- zfGenes[grep("^ERCC", rownames(zfGenes)),]
head(spikes)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

