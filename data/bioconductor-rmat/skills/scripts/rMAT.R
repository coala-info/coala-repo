# Code example from 'rMAT' vignette. See references/ for full tutorial.

### R code from vignette source 'rMAT.Rnw'

###################################################
### code chunk number 1: Loading rMAT
###################################################
library(rMAT)


###################################################
### code chunk number 2: Reading the BPMAP File Header
###################################################
pwd<-"" #INPUT FILES- BPMAP, ARRAYS, etc.
path<- system.file("extdata", "Sc03b_MR_v04_10000.bpmap",package="rMAT")

bpmapFile = paste(pwd, path, sep="")
seqHeader <-ReadBPMAPAllSeqHeader(bpmapFile)  #save the list of output contents to seqHeader
print(seqHeader) # show its content


###################################################
### code chunk number 3: arrayFile
###################################################
pathCEL<- system.file("extdata", "Swr1WTIP_Short.CEL",package="rMAT")
arrayFile<-paste(pwd,c(pathCEL),sep="")


###################################################
### code chunk number 4: BPMAPCelParser
###################################################
ScSet<-BPMAPCelParser(bpmapFile, arrayFile, verbose=FALSE,groupName="Sc")     


###################################################
### code chunk number 5: Summary of Scset
###################################################
summary(ScSet)


###################################################
### code chunk number 6: Normalize array by array
###################################################
ScSetNorm<-NormalizeProbes(ScSet,method="MAT",robust=FALSE,all=FALSE,standard=TRUE,verbose=FALSE)  


###################################################
### code chunk number 7: Summary of ScSetNorm
###################################################
summary(ScSetNorm)


###################################################
### code chunk number 8: COMPUTING rMAT SCORES
###################################################
RD<-computeMATScore(ScSetNorm,cName=NULL, dMax=600, verbose=TRUE) 
Enrich<-callEnrichedRegions(RD,dMax=600, dMerge=300, nProbesMin=8, method="score", threshold=1, verbose=FALSE)  


###################################################
### code chunk number 9: Reading library (eval = FALSE)
###################################################
## library(GenomeGraphs)
## library(rtracklayer)


###################################################
### code chunk number 10: rtracklayer annotation (eval = FALSE)
###################################################
## 
## genome(Enrich)<-"sacCer2"
## names(Enrich)<-"chrI"
## 
## #Viewing the targets
## session<- browserSession("UCSC")
## track(session,"toto") <- Enrich
## 
## #Get the first feature
## subEnrich<-Enrich[2,]
## 
## #View with GenomeBrowser
## view<- browserView(session,range(subEnrich) * -2)


###################################################
### code chunk number 11: Ensembl BioMart (eval = FALSE)
###################################################
## mart<-useMart("ensembl",dataset="scerevisiae_gene_ensembl")


###################################################
### code chunk number 12: Genome Axis (eval = FALSE)
###################################################
## genomeAxis<-makeGenomeAxis(add53 = TRUE, add35=TRUE)
## minbase<-1
## maxbase<-50000


###################################################
### code chunk number 13: Plotting Gene (eval = FALSE)
###################################################
## genesplus<-makeGeneRegion(start = minbase, end = maxbase, strand = "+", chromosome = "I", biomart = mart) 
## genesmin<-makeGeneRegion(start = minbase, end = maxbase, strand = "-", chromosome = "I", biomart = mart)


###################################################
### code chunk number 14: MatScore for chromosome I (eval = FALSE)
###################################################
## RD1<-RD[space(RD)=="chr1",]
## Enrich1<-Enrich[space(Enrich)=="chr1",]
## MatScore<-makeGenericArray(intensity=as.matrix(score(RD1)),  probeStart=start(RD1), dp=DisplayPars(size=1, color="black", type="l"))
## rectList<- makeRectangleOverlay(start = start(Enrich1), end = end(Enrich1), region = c(1, 4), dp = DisplayPars(color = "green", alpha = 0.1))


###################################################
### code chunk number 15: rMAT.Rnw:206-207 (eval = FALSE)
###################################################
## gdPlot(list("score" = MatScore, "Gene +" = genesplus, Position = genomeAxis, "Gene -" = genesmin), minBase = minbase, maxBase = maxbase, labelCex = 1, overlays=rectList) 


