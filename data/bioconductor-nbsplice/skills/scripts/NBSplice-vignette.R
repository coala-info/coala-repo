# Code example from 'NBSplice-vignette' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"-----------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=TRUE, dev="png", message=FALSE, 
    error=FALSE, warning=TRUE)

## ----bioC, eval=FALSE----------------------------------------------------
#  ## try http:// if https:// URLs are not supported
#  if (!require("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install("NBSplice", version="devel")

## ----expMat built, eval=FALSE--------------------------------------------
#  fileNames<-c(paste(rep("C1R",4), 1:4,"/abundance.tsv", sep=""),
#              paste(rep("C2R",4), 1:4,"/abundance.tsv", sep=""))
#  
#  myInfo<-lapply(seq_along(fileNames), function(x){
#      quant<-read.delim(fileNames[x], header = TRUE)
#      expression<-quant[,"est_counts"]
#      return(expression)
#  })
#  # Adding the isoform IDS as row names
#  isoform_id<-read.delim(fileNames[x], header = TRUE)[,"target_id"]
#  expressionMatrix<-(do.call(cbind, myInfo))
#  rownames(expressionMatrix)<-isoform_id
#  # Adding the samples names as column names
#  colnames(expressionMatrix)<-c(paste(rep("C1R",4), 1:4, sep=""),
#                                  paste(rep("C2R",4), 1:4, sep=""))

## ----expMat, eval=TRUE---------------------------------------------------
data(isoCounts, package="NBSplice")
head(isoCounts)
dim(isoCounts)

## ----geneIsoMat, eval=TRUE-----------------------------------------------
data(geneIso, package="NBSplice")
head(geneIso)
dim(geneIso)

## ----designMat, eval=TRUE------------------------------------------------
designMatrix<-data.frame(sample=c(paste(rep("C1R", 4), 1:4, sep=""),
                        paste(rep("C2R", 4), 1:4, sep="")), condition=c(rep(
                        "Normal", 4), rep("Tumor", 4)))
rownames(designMatrix)<-designMatrix[,"sample"]
designMatrix

## ----colData, eval=TRUE--------------------------------------------------
colName<-"condition"
levels(designMatrix[,colName])

## ----objectBuild, eval=TRUE----------------------------------------------
library(NBSplice)
myIsoDataSet<-IsoDataSet(isoCounts, designMatrix, colName, geneIso)

## ----objectInsp, eval=TRUE-----------------------------------------------
show(myIsoDataSet)

head(isoCounts(myIsoDataSet))

## ----lowExp, eval=TRUE---------------------------------------------------
myIsoDataSet<-buildLowExpIdx(myIsoDataSet, colName, ratioThres = 0.01, 
                            countThres = 1)

## ----NBTest, eval=TRUE---------------------------------------------------
myDSResults<-NBTest(myIsoDataSet, colName, test="F")

## ----object loading2, echo=FALSE, eval=TRUE, results="hide"--------------
data(myDSResults, package="NBSplice")

## ----NBRes, eval=TRUE----------------------------------------------------
head(lowExpIndex(myDSResults))
contrast(myDSResults)
head(results(myDSResults))

## ----lowExpRes, eval=TRUE------------------------------------------------
head(results(myDSResults, filter = FALSE))

## ----getDSGe, eval=TRUE--------------------------------------------------
mySignificantRes<-GetDSResults(myDSResults)
head(mySignificantRes)
dim(mySignificantRes)
myDSGenes<-GetDSGenes(myDSResults)
head(myDSGenes)
length(myDSGenes)

## ----plotD, eval=TRUE----------------------------------------------------
plotRatiosDisp(myDSResults)

## ----plotv, eval=TRUE----------------------------------------------------
plotVolcano(myDSResults)

## ----plotGene, eval=TRUE-------------------------------------------------
## Select the first differentially spliced gene
gene<-GetDSGenes(myDSResults)[1]
GetGeneResults(myDSResults, gene)
plotGeneResults(myDSResults, gene)

## ----plotGene2, eval=TRUE------------------------------------------------
## Keeping non-reliable and non-significant isoforms
plotGeneResults(myDSResults, gene, filterLowExpIso = FALSE, 
                filterNotSignificant = FALSE)


## ----sessionInfo---------------------------------------------------------
sessionInfo()

