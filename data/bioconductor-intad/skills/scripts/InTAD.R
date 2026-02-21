# Code example from 'InTAD' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----quick-start,  message=FALSE, warning=FALSE-------------------------------
library(InTAD)
# normalized enhancer signals table
enhSel[1:3,1:3]
# enhancer signal genomic coordinates 
as.data.frame(enhSelGR[1:3])
# gene expression normalized counts
rpkmCountsSel[1:3,1:3]
# gene coordiantes
as.data.frame(txsSel[1:3])
# additional sample info data.frame
head(mbAnnData)

## ----input-check1,  warning=FALSE---------------------------------------------
summary(colnames(rpkmCountsSel) == colnames(enhSel))

## ----input-check2,  warning=FALSE---------------------------------------------
# compare number of signal regions and in the input table
length(enhSelGR) == nrow(enhSel)

## ----test,  warning=FALSE-----------------------------------------------------
inTadSig <- newSigInTAD(enhSel, enhSelGR, rpkmCountsSel, txsSel,mbAnnData)

## ----test2,  warning=FALSE----------------------------------------------------
inTadSig

## ----filter-genes,  warning=FALSE---------------------------------------------
# filter gene expression
inTadSig <- filterGeneExpr(inTadSig, checkExprDistr = TRUE)

## ----tad1,  warning=FALSE-----------------------------------------------------
# IMR90 hg19 TADs
head(tadGR)

## ----tad2,  warning=FALSE-----------------------------------------------------
# combine signals and genes in TADs
inTadSig <- combineInTAD(inTadSig, tadGR)

## ----cor,  warning=FALSE------------------------------------------------------
par(mfrow=c(1,2)) # option to combine plots in the graph
# perform correlation anlaysis
corData <- findCorrelation(inTadSig,plot.proportions = TRUE)

## ----cor2,  warning=FALSE-----------------------------------------------------
head(corData,5)

## ----loopsDf,  warning=FALSE--------------------------------------------------
loopsDfSel[1:4,1:6]

## ----loopsDf2,  warning=FALSE-------------------------------------------------
inTadSig <- combineWithLoops(inTadSig, loopsDfSel)

## ----loopsDf3,  warning=FALSE-------------------------------------------------
loopEag <- findCorFromLoops(inTadSig,method = "spearman")

## ----loopsDf4,  warning=FALSE-------------------------------------------------
loopEag

## ----plot0, warning=FALSE-----------------------------------------------------

# example enhancer in correlation with GABRA5
cID <- "chr15:26372163-26398073" 
selCorData <- corData[corData$peakid == cID, ]
selCorData[ selCorData$name == "GABRA5", ] 

## ----plot1,fig.align = "center", warning=FALSE--------------------------------

plotCorrelation(inTadSig, cID, "GABRA5",
                xLabel = "RPKM gene expr log2",
                yLabel = "H3K27ac enrichment log2", 
                colByPhenotype = "Subgroup")

## ----plot3, fig.align = "center", warning=FALSE-------------------------------
plotCorAcrossRef(inTadSig,corData,
                 targetRegion = GRanges("chr15:25000000-28000000"), 
                 tads = tadGR)

## ----plot4, fig.align = "center", warning=FALSE-------------------------------
plotCorAcrossRef(inTadSig,corData,
                 targetRegion = GRanges("chr15:25000000-28000000"), 
                 showCorVals = TRUE, tads = tadGR)

## ----plot5, fig.align = "center", warning=FALSE-------------------------------
plotCorAcrossRef(inTadSig,corData,
                 targetRegion = GRanges("chr15:25000000-28000000"), 
                 showCorVals = TRUE, symmetric = TRUE, tads = tadGR)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

