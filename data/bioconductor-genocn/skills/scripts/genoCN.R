# Code example from 'genoCN' vignette. See references/ for full tutorial.

### R code from vignette source 'genoCN.Rnw'

###################################################
### code chunk number 1: genoCN.Rnw:15-16
###################################################
library(genoCN)


###################################################
### code chunk number 2: genoCN.Rnw:28-36
###################################################
data(snpData)
data(snpInfo)

dim(snpData)
dim(snpInfo)

snpData[1:2,]
snpInfo[1:2,]


###################################################
### code chunk number 3: genoCN.Rnw:40-42
###################################################
plotCN(pos=snpInfo$Position, LRR=snpData$LRR, BAF=snpData$BAF, 
main = "simulated data on Chr22")


###################################################
### code chunk number 4: genoCN.Rnw:53-56
###################################################
Theta = genoCNV(snpInfo$Name, snpInfo$Chr, snpInfo$Position, snpData$LRR, snpData$BAF, 
  snpInfo$PFB, sampleID="simu1", cnv.only=(snpInfo$PFB>1), outputSeg = TRUE, 
  outputSNP = 1, outputTag = "simu1")


###################################################
### code chunk number 5: genoCN.Rnw:68-71
###################################################
  
seg = read.table("simu1_segment.txt", header=TRUE)
seg


###################################################
### code chunk number 6: genoCN.Rnw:74-77
###################################################
snp = read.table("simu1_SNP.txt", header=TRUE)
dim(snp)
snp[1:2,]


###################################################
### code chunk number 7: genoCN.Rnw:81-83
###################################################
plotCN(pos=snpInfo$Position, LRR=snpData$LRR, BAF=snpData$BAF, 
main = "simulated data on Chr22", fileNames="simu1_segment.txt")


