# Code example from 'hapfabia' vignette. See references/ for full tutorial.

### R code from vignette source 'hapfabia.Rnw'

###################################################
### code chunk number 1: hapfabia.Rnw:81-85
###################################################
options(width=60)
set.seed(0)
library(hapFabia)
hapFabiaVer<-packageDescription("hapFabia")$Version


###################################################
### code chunk number 2: gotoTempDir
###################################################
old_dir <- getwd()
setwd(tempdir())


###################################################
### code chunk number 3: loadLibs
###################################################
library(hapFabia)


###################################################
### code chunk number 4: makeVCFfile
###################################################
data(chr1ASW1000G)
write(chr1ASW1000G,file="chr1ASW1000G.vcf")


###################################################
### code chunk number 5: createPipeline
###################################################
makePipelineFile(fileName="chr1ASW1000G",shiftSize=500,
                 intervalSize=1000,haplotypes=TRUE)


###################################################
### code chunk number 6: executePipeline
###################################################
source("pipeline.R")


###################################################
### code chunk number 7: listFiles
###################################################
list.files(pattern="chr1")


###################################################
### code chunk number 8: showResultSummary
###################################################
print("Number IBD segments:")
print(anaRes$noIBDsegments)
print("Statistics on IBD segment length in SNVs (all SNVs in the IBD segment):")
print(anaRes$avIBDsegmentLengthSNVS)
print("Statistics on IBD segment length in bp:")
print(anaRes$avIBDsegmentLengthS)
print("Statistics on number of individuals belonging to IBD segments:")
print(anaRes$avnoIndividS)
print("Statistics on number of tagSNVs of IBD segments:")
print(anaRes$avnoTagSNVsS)
print("Statistics on MAF of tagSNVs of IBD segments:")
print(anaRes$avnoFreqS)
print("Statistics on MAF within the group of tagSNVs of IBD segments:")
print(anaRes$avnoGroupFreqS)
print("Statistics on number of changes between major and minor allele frequency:")
print(anaRes$avnotagSNVChangeS)
print("Statistics on number of tagSNVs per individual of an IBD segment:")
print(anaRes$avnotagSNVsPerIndividualS)
print("Statistics on number of individuals that have the minor allele of tagSNVs:")
print(anaRes$avnoindividualPerTagSNVS)


###################################################
### code chunk number 9: loadSegment5
###################################################
posAll <- 5
start <- (posAll-1)*shiftSize
end <- start + intervalSize
pRange <- paste("_",format(start,scientific=FALSE),"_",
                format(end,scientific=FALSE),sep="")
load(file=paste(fileName,pRange,"_resAnno",".Rda",sep=""))
IBDsegmentList <- resHapFabia$mergedIBDsegmentList
summary(IBDsegmentList)
IBDsegment1 <- IBDsegmentList[[1]]
summary(IBDsegment1)
IBDsegment2 <- IBDsegmentList[[2]]
summary(IBDsegment2)


###################################################
### code chunk number 10: goBackToOldDir
###################################################
new_dir <- getwd()
setwd(old_dir)


###################################################
### code chunk number 11: plotIBDsegment1
###################################################
plot(IBDsegment1,filename=paste(new_dir,"/",fileName,pRange,"_mat",sep=""))


###################################################
### code chunk number 12: plotIBDsegment2
###################################################
plot(IBDsegment2,filename=paste(new_dir,"/",fileName,pRange,"_mat",sep=""))


###################################################
### code chunk number 13: gotoTempDir
###################################################
old_dir <- getwd()
setwd(tempdir())


###################################################
### code chunk number 14: createData
###################################################
data(simu)
namesL <- simu[["namesL"]]
haploN <- simu[["haploN"]]
snvs <- simu[["snvs"]]
annot <- simu[["annot"]]
alleleIimp <- simu[["alleleIimp"]]
write.table(namesL,file="dataSim1fabia_individuals.txt",
    quote = FALSE,row.names = FALSE,col.names = FALSE)
write(as.integer(haploN),file="dataSim1fabia_annot.txt",
    ncolumns=100)
write(as.integer(snvs),file="dataSim1fabia_annot.txt",
    append=TRUE,ncolumns=100)
write.table(annot,file="dataSim1fabia_annot.txt", sep = " ",
    quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)
write(as.integer(haploN),file="dataSim1fabia_mat.txt",ncolumns=100)
write(as.integer(snvs),file="dataSim1fabia_mat.txt",
    append=TRUE,ncolumns=100)

for (i in 1:haploN) {

  a1 <- which(alleleIimp[i,]>0.01)

  al <- length(a1)
  b1 <- alleleIimp[i,a1]

  a1 <- a1 - 1
  dim(a1) <- c(1,al)
  b1 <- format(as.double(b1),nsmall=1)
  dim(b1) <- c(1,al)

  write.table(al,file="dataSim1fabia_mat.txt", sep = " ",
     quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)
  write.table(a1,file="dataSim1fabia_mat.txt", sep = " ",
     quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)
  write.table(b1,file="dataSim1fabia_mat.txt", sep = " ",
     quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)

}


###################################################
### code chunk number 15: callHapFabia
###################################################
hapRes <- hapFabia(fileName="dataSim1fabia",prefixPath="",
   sparseMatrixPostfix="_mat",
   annotPostfix="_annot.txt",individualsPostfix="_individuals.txt",
   labelsA=NULL,pRange="",individuals=0,lowerBP=0,upperBP=0.15,
   p=10,iter=1,quant=0.01,eps=1e-5,alpha=0.03,cyc=50,non_negative=1,
   write_file=0,norm=0,lap=100.0,IBDsegmentLength=10,Lt = 0.1,
   Zt = 0.2,thresCount=1e-5,mintagSNVsFactor=3/4,pMAF=0.1,
   haplotypes=FALSE,cut=0.8,procMinIndivids=0.1,thresPrune=1e-3,
   simv="minD",minTagSNVs=6,minIndivid=2,avSNVsDist=100,SNVclusterLength=100)


###################################################
### code chunk number 16: SummaryHapFabia
###################################################
summary(hapRes$mergedIBDsegmentList)


###################################################
### code chunk number 17: assignIBDsegmentList
###################################################
mergedIBDsegmentList <- hapRes$mergedIBDsegmentList # $
IBDsegment <- mergedIBDsegmentList[[1]]


###################################################
### code chunk number 18: goBackToOldDir
###################################################
new_dir <- getwd()
setwd(old_dir)


###################################################
### code chunk number 19: plotIBDsegment3
###################################################
plot(IBDsegment,filename=paste(new_dir,"/dataSim1fabia_mat",sep=""))


###################################################
### code chunk number 20: gotoTempDirSecond
###################################################
old_dir <- getwd()
setwd(tempdir())


###################################################
### code chunk number 21: secondExampleData
###################################################
simulateIBDsegmentsFabia(minruns=2,maxruns=2)


###################################################
### code chunk number 22: secondExampleCallHapFabia
###################################################
hapRes <- hapFabia(fileName="dataSim2fabia",prefixPath="",
   sparseMatrixPostfix="_mat",
   annotPostfix="_annot.txt",individualsPostfix="_individuals.txt",
   labelsA=NULL,pRange="",individuals=0,lowerBP=0,upperBP=0.15,
   p=10,iter=1,quant=0.01,eps=1e-5,alpha=0.03,cyc=50,non_negative=1,
   write_file=0,norm=0,lap=100.0,IBDsegmentLength=10,Lt = 0.1,
   Zt = 0.2,thresCount=1e-5,mintagSNVsFactor=3/4,pMAF=0.1,
   haplotypes=FALSE,cut=0.8,procMinIndivids=0.1,thresPrune=1e-3,
   simv="minD",minTagSNVs=6,minIndivid=2,avSNVsDist=100,SNVclusterLength=100)


###################################################
### code chunk number 23: secondExampleSummaryHapFabia
###################################################
summary(hapRes$mergedIBDsegmentList)


###################################################
### code chunk number 24: secondExampleAssignIBDsegment
###################################################
mergedIBDsegmentList <- hapRes$mergedIBDsegmentList # $
IBDsegment <- mergedIBDsegmentList[[1]]


###################################################
### code chunk number 25: goBackToOldDirSecond
###################################################
new_dir <- getwd()
setwd(old_dir)


###################################################
### code chunk number 26: secondExamplePlot
###################################################
plot(IBDsegment,filename=paste(new_dir,"/dataSim2fabia_mat",sep=""))


###################################################
### code chunk number 27: histograms
###################################################
data(res)
h1 <- histL(res,n=1,p=0.9,w=NULL,intervv=50,off=0)
print(h1$counts)
h1 <- histL(res,n=1,p=NULL,w=0.5,intervv=50,off=0)
print(h1$counts)


###################################################
### code chunk number 28: plotLhistP
###################################################
data(res)
plotL(res,n=1,p=0.95,w=NULL,type="histogram",intervv=50,off=0,t="p",cex=1)


###################################################
### code chunk number 29: plotLpointsP
###################################################
data(res)
plotL(res,n=1,p=0.95,w=NULL,type="points",intervv=50,off=0,t="p",cex=1)


###################################################
### code chunk number 30: plotLpointsW
###################################################
data(res)
plotL(res,n=1,p=NULL,w=0.5,type="histogram",intervv=50,off=0,t="p",cex=1)


###################################################
### code chunk number 31: plotLsmoothP
###################################################
data(res)
plotL(res,n=1,p=0.95,w=NULL,type="smooth",intervv=50,off=0,t="p",cex=1)


###################################################
### code chunk number 32: plotLsmoothW
###################################################
data(res)
plotL(res,n=1,p=NULL,w=0.5,type="smooth",intervv=50,off=0,t="p",cex=1)


###################################################
### code chunk number 33: topLZ
###################################################
data(res)

topLZ(res,n=1,LZ="L",indices=TRUE,p=0.95,w=NULL)
topLZ(res,n=1,LZ="L",indices=TRUE,p=NULL,w=0.95)

topLZ(res,n=1,LZ="Z",indices=TRUE,p=0.95,w=NULL)
topLZ(res,n=1,LZ="Z",indices=TRUE,p=NULL,w=0.4)

topLZ(res,n=1,LZ="L",indices=FALSE,p=0.95,w=NULL)
topLZ(res,n=1,LZ="L",indices=FALSE,p=NULL,w=0.95)

topLZ(res,1,LZ="Z",indices=FALSE,p=0.95,w=NULL)
topLZ(res,1,LZ="Z",indices=FALSE,p=NULL,w=0.4)


