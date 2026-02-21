# Code example from 'QSUtils-Alignment' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation,message=FALSE-----------------------------------------------
library(Biostrings)
library(ape)
library(ggplot2)

BiocManager::install("QSutils")
library(QSutils)

## ----exdata-------------------------------------------------------------------
filepath<-system.file("extdata","ToyData_10_50_1000.fna", package="QSutils")
cat(readLines(filepath) , sep = "\n")

## ----readampl-----------------------------------------------------------------
filepath<-system.file("extdata","ToyData_10_50_1000.fna", package="QSutils")
lst <- ReadAmplSeqs(filepath,type="DNA")
lst

## ----getqsdata----------------------------------------------------------------
filepath<-system.file("extdata","ToyData_10_50_1000.fna", package="QSutils")
lstG <- GetQSData(filepath,min.pct= 2,type="DNA")
lstG

## ----exgaps-na----------------------------------------------------------------
filepath<-system.file("extdata","Toy.GapsAndNs.fna", package="QSutils")
reads <- readDNAStringSet(filepath)
reads

## ----collapse-----------------------------------------------------------------
lstCollapsed <- Collapse(reads)
str <- DottedAlignment(lstCollapsed$hseqs)
data.frame(Hpl=str,nr=lstCollapsed$nr)

## ----correctgaps-na-----------------------------------------------------------
lstCorrected<-CorrectGapsAndNs(lstCollapsed$hseqs[2:length(lstCollapsed$hseqs)],
                lstCollapsed$hseqs[[1]])
#Add again the most abundant haplotype.
lstCorrected<- c(lstCollapsed$hseqs[1],lstCorrected)
lstCorrected

## ----recollapse---------------------------------------------------------------
lstRecollapsed<-Recollapse(lstCorrected,lstCollapsed$nr)
lstRecollapsed

## ----forward------------------------------------------------------------------
filepath<-system.file("extdata","ToyData_FWReads.fna", package="QSutils")
lstFW <- ReadAmplSeqs(filepath,type="DNA")
cat("Reads: ",sum(lstFW$nr),", Haplotypes: ",length(lstFW$nr),"\n",sep="")

## ----reverse------------------------------------------------------------------
filepath<-system.file("extdata","ToyData_RVReads.fna", package="QSutils")
lstRV <- ReadAmplSeqs(filepath,type="DNA")
cat("Reads: ",sum(lstRV$nr),", Haplotypes: ",length(lstRV$nr),"\n",sep="")

## ----intersect ,results='hold'------------------------------------------------
lstI <- IntersectStrandHpls(lstFW$nr,lstFW$hseqs,lstRV$nr,lstRV$hseqs)

cat("FW and Rv total reads:",sum(lstFW$nr)+sum(lstRV$nr),"\n")
cat("FW and Rv reads above thr:",sum(lstI$pFW)+sum(lstI$pRV),"\n")
cat("FW haplotypes above thr:",sum(lstFW$nr/sum(lstFW$nr)>0.001),"\n")
cat("RV haplotypes above thr:",sum(lstRV$nr/sum(lstRV$nr)>0.001),"\n")
cat("\n")
cat("Reads in FW unique haplotypes:",sum(lstI$pFW[lstI$pRV==0]),"\n")
cat("Reads in RV unique haplotypes:",sum(lstI$pRV[lstI$pFW==0]),"\n")
cat("\n")
cat("Reads in common:",sum(lstI$nr),"\n")
cat("Haplotypes in common:",length(lstI$nr),"\n")

## ----loadexample--------------------------------------------------------------
filepath<-system.file("extdata","ToyData_10_50_1000.fna", package="QSutils")
lst <- ReadAmplSeqs(filepath,type="DNA")
lst

## ----consensus----------------------------------------------------------------
ConsSeq(lst$hseqs)

## ----dotted-------------------------------------------------------------------
DottedAlignment(lst$hseqs)

## ----sortbymut----------------------------------------------------------------
lstSorted<-SortByMutations(lst$hseqs,lst$nr)
lstSorted

## ----frequencymat-------------------------------------------------------------
FreqMat(lst$hseqs)

## ----frequencymat-abundance---------------------------------------------------
FreqMat(lst$hseqs,lst$nr)

## ----tablmutations------------------------------------------------------------
MutsTbl(lst$hseqs)

## ----tablmutations-abundance--------------------------------------------------
MutsTbl(lst$hseqs, lst$nr)

## ----summarymuts--------------------------------------------------------------
SummaryMuts(lst$hseqs,lst$nr,off=0)

## ----polydist-----------------------------------------------------------------
PolyDist(lst$hseqs,lst$nr)
PolyDist(lst$hseqs)

## ----report-variants----------------------------------------------------------
ReportVariants(lst$hseqs[2:length(lst$hseqs)],lst$hseqs[[1]],lst$nr)

## ----getinf-------------------------------------------------------------------
GetInfProfile(lst$hseqs,lst$nr)

## ----plotic ,fig.cap="Information content per position in the alignment"------
dplot <- data.frame(IC=GetInfProfile(lst$hseqs,lst$nr),
                    pos=1:width(lst$hseqs)[1])

ggplot(dplot, aes(x=pos, y=IC)) + geom_point() +
scale_x_continuous(minor_breaks = 1:nrow(dplot), breaks = 1:nrow(dplot)) +
theme(axis.text.x = element_text(angle=45))


## ----genotyping---------------------------------------------------------------
filepath<-system.file("extdata","Unknown-Genotype.fna", package="QSutils")
lst2Geno <- ReadAmplSeqs(filepath,type="DNA")
hseq <- lst2Geno$hseq[1]
hseq

## ----genotyping-read----------------------------------------------------------
filepath<-system.file("extdata","GenotypeStandards_A-H.fas", package="QSutils")
lstRefs <- ReadAmplSeqs(filepath,type="DNA")
RefSeqs <- lstRefs$hseq
{ cat("Number of reference sequences by genotype:\n")
    print(table(substr(names(RefSeqs),1,1)))
}

## ----DBrule-------------------------------------------------------------------
dm <- as.matrix(DNA.dist(c(hseq,RefSeqs),model="K80"))
dgrp <- dm[-1,-1]
d <- dm[1,-1]
grp <- factor(substr(rownames(dgrp),1,1))
hr <- as.integer(grp)
dsc <- DBrule(dgrp,hr,d,levels(grp))
print(dsc)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

