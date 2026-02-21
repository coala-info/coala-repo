# Code example from 'EBSeqHMM_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'EBSeqHMM_vignette.Rnw'

###################################################
### code chunk number 1: EBSeqHMM_vignette.Rnw:110-112
###################################################
library(EBSeq)
library(EBSeqHMM)


###################################################
### code chunk number 2: EBSeqHMM_vignette.Rnw:136-138
###################################################
data(GeneExampleData)
str(GeneExampleData)


###################################################
### code chunk number 3: EBSeqHMM_vignette.Rnw:144-146
###################################################
CondVector <- rep(paste("t",1:5,sep=""),each=3)
print(CondVector)


###################################################
### code chunk number 4: EBSeqHMM_vignette.Rnw:153-156
###################################################
Conditions <- factor(CondVector, levels=c("t1","t2","t3","t4","t5"))
str(Conditions)
levels(Conditions)


###################################################
### code chunk number 5: EBSeqHMM_vignette.Rnw:168-169
###################################################
Sizes <- MedianNorm(GeneExampleData)


###################################################
### code chunk number 6: EBSeqHMM_vignette.Rnw:184-185
###################################################
GeneNormData <- GetNormalizedMat(GeneExampleData, Sizes)


###################################################
### code chunk number 7: EBSeqHMM_vignette.Rnw:193-194
###################################################
PlotExp(GeneNormData, Conditions, Name="Gene_23")


###################################################
### code chunk number 8: EBSeqHMM_vignette.Rnw:211-213
###################################################
EBSeqHMMGeneOut <- EBSeqHMMTest(Data=GeneExampleData, sizeFactors=Sizes, Conditions=Conditions,
			     UpdateRd=5)


###################################################
### code chunk number 9: EBSeqHMM_vignette.Rnw:223-226
###################################################
GeneDECalls <- GetDECalls(EBSeqHMMGeneOut, FDR=.05)
head(GeneDECalls)
str(GeneDECalls)


###################################################
### code chunk number 10: EBSeqHMM_vignette.Rnw:236-238
###################################################
"Gene_23"%in%rownames(GeneDECalls)
GeneDECalls["Gene_23",]


###################################################
### code chunk number 11: EBSeqHMM_vignette.Rnw:253-256
###################################################
GeneConfCalls <- GetConfidentCalls(EBSeqHMMGeneOut, FDR=.05,cutoff=.5, OnlyDynamic=TRUE)
#str(GeneConfCalls$EachPath)
print(GeneConfCalls$EachPath[1:4])


###################################################
### code chunk number 12: EBSeqHMM_vignette.Rnw:271-273
###################################################
Path4 <- GeneConfCalls$EachPath[["Down-Down-Up-Up"]]
print(Path4)


###################################################
### code chunk number 13: EBSeqHMM_vignette.Rnw:279-282
###################################################
head(GeneConfCalls$Overall)
print(GeneConfCalls$NumEach)
str(GeneConfCalls$EachPathNames)


###################################################
### code chunk number 14: EBSeqHMM_vignette.Rnw:285-286
###################################################
GeneConfCalls$EachPathNames["Down-Down-Down-Down"]


###################################################
### code chunk number 15: EBSeqHMM_vignette.Rnw:325-331
###################################################
data(IsoExampleList)
str(IsoExampleList)
IsoExampleData <- IsoExampleList$IsoExampleData
str(IsoExampleData)
IsoNames <- IsoExampleList$IsoNames
IsosGeneNames <- IsoExampleList$IsosGeneNames


###################################################
### code chunk number 16: EBSeqHMM_vignette.Rnw:338-339
###################################################
IsoSizes <- MedianNorm(IsoExampleData)


###################################################
### code chunk number 17: EBSeqHMM_vignette.Rnw:361-364
###################################################
NgList <- GetNg(IsoNames, IsosGeneNames)
IsoNgTrun <- NgList$IsoformNgTrun
IsoNgTrun[c(1:3,101:103,161:163)]


###################################################
### code chunk number 18: EBSeqHMM_vignette.Rnw:374-377
###################################################
CondVector <- rep(paste("t",1:5,sep=""),each=3)
Conditions <- factor(CondVector, levels=c("t1","t2","t3","t4","t5"))
str(Conditions)


###################################################
### code chunk number 19: EBSeqHMM_vignette.Rnw:385-389
###################################################
EBSeqHMMIsoOut <- EBSeqHMMTest(Data=IsoExampleData,
			    NgVector=IsoNgTrun,
			    sizeFactors=IsoSizes, Conditions=Conditions,
			    UpdateRd=5)


###################################################
### code chunk number 20: EBSeqHMM_vignette.Rnw:401-404
###################################################
IsoDECalls <- GetDECalls(EBSeqHMMIsoOut, FDR=.05)
str(IsoDECalls)
head(IsoDECalls)


###################################################
### code chunk number 21: EBSeqHMM_vignette.Rnw:420-424
###################################################
IsoConfCalls <- GetConfidentCalls(EBSeqHMMIsoOut, FDR=.05)
head(IsoConfCalls$Overall)
str(IsoConfCalls$EachPath[1:4])
str(IsoConfCalls$EachPathNames)


###################################################
### code chunk number 22: EBSeqHMM_vignette.Rnw:441-443
###################################################
AllPaths <- GetAllPaths(EBSeqHMMGeneOut)
print(AllPaths)


###################################################
### code chunk number 23: EBSeqHMM_vignette.Rnw:450-452
###################################################
AllPathsWithEE <- GetAllPaths(EBSeqHMMGeneOut, OnlyDynamic=FALSE)
print(AllPathsWithEE)


###################################################
### code chunk number 24: EBSeqHMM_vignette.Rnw:458-460
###################################################
GeneConfCallsTwoPaths <- GetConfidentCalls(EBSeqHMMGeneOut, FDR=.05, Paths=AllPaths[c(1,16)])
print(GeneConfCallsTwoPaths)


###################################################
### code chunk number 25: EBSeqHMM_vignette.Rnw:473-474
###################################################
GeneNormData <- GetNormalizedMat(GeneExampleData, Sizes)


###################################################
### code chunk number 26: EBSeqHMM_vignette.Rnw:481-484
###################################################
print(GeneConfCallsTwoPaths$EachPath[["Down-Down-Down-Down"]])
GeneOfInterest <- GeneConfCallsTwoPaths$EachPathNames[["Down-Down-Down-Down"]]
print(GeneOfInterest)


###################################################
### code chunk number 27: EBSeqHMM_vignette.Rnw:489-491
###################################################
par(mfrow=c(2,2))
for(i in 1:3)PlotExp(GeneNormData, Conditions, Name=GeneOfInterest[i])


###################################################
### code chunk number 28: EBSeqHMM_vignette.Rnw:511-513
###################################################
par(mfrow=c(3,2))
QQP(EBSeqHMMGeneOut,GeneLevel=TRUE)


###################################################
### code chunk number 29: EBSeqHMM_vignette.Rnw:529-531
###################################################
par(mfrow=c(3,2))
DenNHist(EBSeqHMMGeneOut, GeneLevel=TRUE)


###################################################
### code chunk number 30: EBSeqHMM_vignette.Rnw:545-547
###################################################
par(mfrow=c(4,4))
QQP(EBSeqHMMIsoOut)


###################################################
### code chunk number 31: EBSeqHMM_vignette.Rnw:559-561
###################################################
par(mfrow=c(4,4))
DenNHist(EBSeqHMMIsoOut)


###################################################
### code chunk number 32: EBSeqHMM_vignette.Rnw:607-608 (eval = FALSE)
###################################################
## IsoNgTrun <- scan(file="output_name.ngvec", what=0, sep="\n")


