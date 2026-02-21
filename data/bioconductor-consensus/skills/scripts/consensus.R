# Code example from 'consensus' vignette. See references/ for full tutorial.

## ----setup, include=FALSE, cache=FALSE--------------------------------------------------
library(knitr)
# set global chunk options
opts_chunk$set(fig.path='figure/minimal-', fig.align='center', fig.show='hold')
options(formatR.arrow=TRUE,width=90)

## ----checkinstall, eval=FALSE-----------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("consensus")

## ----loaddata, message=FALSE------------------------------------------------------------
library(consensus)
data("TCGA")

## ----lookatdata-------------------------------------------------------------------------
sapply(mget(c("U133A", "Huex", "Agilent", "RNASeq")), dim)
rnames <- sapply(mget(c("U133A", "Huex", "Agilent", "RNASeq")), rownames)
head(rnames)
apply(rnames[,2:ncol(rnames)], 2, function (x) all(x==rnames[,1]))
cnames <- sapply(mget(c("U133A", "Huex", "Agilent", "RNASeq")), colnames)
head(cnames)
apply(rnames[,2:ncol(rnames)], 2, function (x) all(x==rnames[,1]))
rm(rnames, cnames)

## ----mm---------------------------------------------------------------------------------
tcga_mm <- MultiMeasure(names=c("U133A", "Huex", "Agilent", "RNA-Seq"), 
                        data=list(U133A, Huex, Agilent, RNASeq))
tcga_mm

## ----tp53-------------------------------------------------------------------------------
plotOneFit(tcga_mm, "TP53", brewer.pal(n = 4, name = "Dark2"))

## ----fit--------------------------------------------------------------------------------
fit <- fitConsensus(tcga_mm)
fit

## ----margave----------------------------------------------------------------------------
plotMarginals(fit, "average", brewer.pal(n = 4, name = "Dark2"))

## ----margsens---------------------------------------------------------------------------
plotMarginals(fit, "sensitivity", brewer.pal(n = 4, name = "Dark2"))

## ----margprec---------------------------------------------------------------------------
plotMarginals(fit, "precision", brewer.pal(n = 4, name = "Dark2"))

## ----pmdsens----------------------------------------------------------------------------
plotMostDiscordant(fit, "sensitivity", 15)

## ----my07b------------------------------------------------------------------------------
plotOneFit(tcga_mm, "MYO7B", brewer.pal(n = 4, name = "Dark2"))

## ----sessionInfo------------------------------------------------------------------------
sessionInfo()

