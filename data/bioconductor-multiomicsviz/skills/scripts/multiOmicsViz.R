# Code example from 'multiOmicsViz' vignette. See references/ for full tutorial.

### R code from vignette source 'multiOmicsViz.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Example
###################################################
library("multiOmicsViz")
sourceOmics <- system.file("extdata","sourceOmics.txt",package="multiOmicsViz")
sourceOmics <- read.table(sourceOmics,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
	
targetOmics1 <- system.file("extdata","targetOmics.txt",package="multiOmicsViz")
targetOmics1 <- read.table(targetOmics1,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
	
targetOmicsList <- list()
targetOmicsList[[1]] <- targetOmics1
	
outputfile <- paste(tempdir(),"/heatmap",sep="")
multiOmicsViz(sourceOmics,"CNA","20",targetOmicsList,"mRNA","All",0.001,outputfile)


###################################################
### code chunk number 2: Example
###################################################

library("multiOmicsViz")
matrix1 <- system.file("extdata","sourceOmics.txt",package="multiOmicsViz")
matrix1 <- read.table(matrix1,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
	
matrix2 <- system.file("extdata","targetOmics.txt",package="multiOmicsViz")
matrix2 <- read.table(matrix2,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
	
sig <- calculateCorForTwoMatrices(matrix1=matrix1,matrix2=matrix2,fdr=0.01)


