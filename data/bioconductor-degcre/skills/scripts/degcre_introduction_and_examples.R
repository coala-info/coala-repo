# Code example from 'degcre_introduction_and_examples' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message = FALSE, warning = FALSE, setup----------------------------------
library(GenomicRanges)
library(InteractionSet)
library(plotgardener)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)
library(DegCre)
library(magick)

## ----demo inputs--------------------------------------------------------------
data(DexNR3C1)
lapply(DexNR3C1,head)

## ----demo DegCre default------------------------------------------------------
subDegGR <- DexNR3C1$DegGR[which(seqnames(DexNR3C1$DegGR)=="chr1")]
subCreGR <- DexNR3C1$CreGR[which(seqnames(DexNR3C1$CreGR)=="chr1")]

myDegCreResList <- runDegCre(DegGR=subDegGR,
                             DegP=subDegGR$pVal,
                             DegLfc=subDegGR$logFC,
                             CreGR=subCreGR,
                             CreP=subCreGR$pVal,
                             CreLfc=subCreGR$logFC,
                             reqEffectDirConcord=TRUE,
                             verbose=FALSE)

## ----demo DegCre result list--------------------------------------------------
names(myDegCreResList)
head(myDegCreResList$degCreHits)

## ----demo subsetting----------------------------------------------------------
passFDR <- which(mcols(myDegCreResList$degCreHits)$assocProbFDR <= 0.05)
passProb <- which(mcols(myDegCreResList$degCreHits)$assocProb >= 0.25)

keepDegCreHits <- myDegCreResList$degCreHits[intersect(passFDR,passProb)]

keepDegCreHits

## ----demo GR subset-----------------------------------------------------------

myDegCreResList$DegGR[queryHits(keepDegCreHits)]

myDegCreResList$CreGR[subjectHits(keepDegCreHits)]

## ----demo Alpha opt-----------------------------------------------------------
alphaOptList <- optimizeAlphaDegCre(DegGR=subDegGR,
                                    DegP=subDegGR$pVal,
                                    DegLfc=subDegGR$logFC,
                                    CreGR=subCreGR,
                                    CreP=subCreGR$pVal,
                                    CreLfc=subCreGR$logFC,
                                    reqEffectDirConcord=TRUE,
                                    verbose=FALSE)

alphaOptList$alphaPRMat

bestAlphaId <- which.max(alphaOptList$alphaPRMat[,4])

bestDegCreResList <- alphaOptList$degCreResListsByAlpha[[bestAlphaId]]

## ----demo assoc dist plot, fig.wide=TRUE--------------------------------------
par(mai=c(0.8,1.6,0.4,0.1))
par(mgp=c(1.7,0.5,0))
par(cex.axis=1)
par(cex.lab=1.4)
par(bty="l")
par(lwd=2)

binStats <- plotDegCreAssocProbVsDist(degCreResList=bestDegCreResList,
                                      assocProbFDRThresh=0.05)

## ----demo plot bin algorithm, fig.small=TRUE----------------------------------
par(mai=c(0.8,0.6,0.4,0.1))
par(mgp=c(1.7,0.5,0))
par(cex.axis=1)
par(cex.lab=1.4)
par(bty="l")
par(lwd=1.5)

plotDegCreBinHeuristic(degCreResList=bestDegCreResList)

## ----demo plot PR curve, fig.small=TRUE---------------------------------------
par(mai=c(0.8,0.6,0.4,0.1))
par(mgp=c(1.7,0.5,0))
par(cex.axis=1)
par(cex.lab=1.4)
par(bty="l")
par(lwd=1.5)

degCrePRAUC(degCreResList=bestDegCreResList)

## ----demo expect associations-------------------------------------------------
expectAssocPerDegDf <- getExpectAssocPerDEG(degCreResList=bestDegCreResList,
                                            geneNameColName="GeneSymb",
                                            assocAlpha=0.05)

## ----demo expect DataFrame----------------------------------------------------
head(expectAssocPerDegDf)

## ----demo plot expect hist, fig.small=TRUE------------------------------------
par(mai=c(0.8,0.6,0.4,0.1))
par(mgp=c(1.7,0.5,0))
par(cex.axis=1)
par(cex.lab=1.4)
par(bty="l")
plotExpectedAssocsPerDeg(expectAssocPerDegDf=expectAssocPerDegDf)

## ----browser1, echo=TRUE, fig.wide=TRUE, message=FALSE,warning=FALSE----------
browserOuts <- plotBrowserDegCre(degCreResList=bestDegCreResList,
                                 geneName="ERRFI1",
                                 geneNameColName="GeneSymb",
                                 CreSignalName="NR3C1",
                                 panelTitleFontSize=8,
                                 geneLabelFontsize=10,
                                 plotXbegin=0.9,
                                 plotWidth=5)

## ----demo zoom browser--------------------------------------------------------
zoomGR <- GRanges(seqnames="chr1",
                  ranges=IRanges(start=7900e3,end=8400e3))

## ----plot browser2, echo=TRUE, fig.wide=TRUE, message=FALSE, warning=FALSE----
zoomBrowserOuts <- plotBrowserDegCre(degCreResList=bestDegCreResList,
                                                   plotRegionGR=zoomGR,
                                                   geneNameColName="GeneSymb",
                                                   CreSignalName="NR3C1",
                                                   panelTitleFontSize=8,
                                                   geneLabelFontsize=10,
                                                   plotXbegin=0.9,
                                                   plotWidth=5)

## ----demo highlight browser---------------------------------------------------
geneHighDf <- data.frame(gene=bestDegCreResList$DegGR$GeneSymb,
                         col="gray")
geneHighDf[which(geneHighDf$gene=="ERRFI1"),2] <- "black"

## ----plot browser3, echo=TRUE, fig.wide=TRUE, message=FALSE, warning=FALSE----
highLightBrowserOuts <- plotBrowserDegCre(degCreResList=bestDegCreResList,
                                          plotRegionGR=zoomGR,
                                          CreSignalName="NR3C1",
                                          geneNameColName="GeneSymb",
                                          geneHighlightDf=geneHighDf,
                                          panelTitleFontSize=8,
                                          geneLabelFontsize=10,
                                          plotXbegin=0.9,
                                          plotWidth=5)

## ----demo convert to GInter---------------------------------------------------
degCreGInter <-
    convertdegCreResListToGInteraction(degCreResList=bestDegCreResList,
                                       assocAlpha=0.05)

degCreGInter

## ----demo convert to DataFrame------------------------------------------------
degCreDf <- convertDegCreDataFrame(degCreResList=bestDegCreResList,
                                   assocAlpha=0.05)

head(degCreDf)

## -----------------------------------------------------------------------------
sessionInfo()

