# Code example from 'NetSAM' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(eval = FALSE)
knitr::opts_chunk$set(tidy.opts=list(width.cutoff=65),tidy=TRUE)

## -----------------------------------------------------------------------------
# install.packages("igraph")
# install.packages("seriation")
# install.packages("WGCNA")
# install.packages("snow")
# install.packages("doSNOW")
# install.packages("foreach")
# source("http://bioconductor.org/biocLite.R")
# biocLite("biomaRt")
# biocLite("GO.db")
# install.packages("R2HTML")
# install.packages("survival")

## ----eval=FALSE---------------------------------------------------------------
# library("NetSAM")
# inputNetworkDir <- system.file("extdata","exampleNetwork.net",package="NetSAM")
# outputFileName <- paste(getwd(),"/NetSAM",sep="")
# result <- NetSAM(inputNetwork=inputNetworkDir, outputFileName=outputFileName, outputFormat="nsm",
# edgeType="unweighted", map_to_genesymbol=FALSE, organism="hsapiens", idType="auto", minModule=0.003,
# stepIte=FALSE, maxStep=4, moduleSigMethod="cutoff", modularityThr=0.2, ZRanNum=10,
# PerRanNum=100, ranSig=0.05, edgeThr=(-1), nodeThr=(-1), nThreads=3)

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputNetwork <- system.file("extdata","exampleNetwork.net",package="NetSAM")
# outputFileName <- paste(getwd(),"/NetSAM",sep="")
# NetAnalyzer(inputNetwork,outputFileName,"unweighted")

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputMatDir <- system.file("extdata","exampleExpressionData_nonsymbol.cct",package="NetSAM")
# inputMat <- read.table(inputMatDir,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
# mergedData <- mergeDuplicate(id=inputMat[,1],data=inputMat[,2:ncol(inputMat)],collapse_mode="maxSD")

## -----------------------------------------------------------------------------
# library("NetSAM")
# print("transform ids from a gene list to gene symbols...")
# geneListDir <- system.file("extdata","exampleGeneList.txt",package="NetSAM")
# geneList <- read.table(geneListDir,header=FALSE,sep="\t",stringsAsFactors=FALSE)
# geneList <- as.vector(as.matrix(geneList))
# geneList_symbol <- mapToSymbol(inputData=geneList, organism="hsapiens", inputType="genelist",idType="affy_hg_u133_plus_2")
# 
# print("transform ids in the input network to gene symbols...")
# inputNetwork <- system.file("extdata","exampleNetwork_nonsymbol.net",package="NetSAM")
# network_symbol <- mapToSymbol(inputData=inputNetwork,organism="hsapiens",inputType="network",idType="entrezgene",edgeType="unweighted")
# 
# print("transform ids in the input matrix to gene symbols...")
# inputMatDir <- system.file("extdata","exampleExpressionData_nonsymbol.cct",package="NetSAM")
# matrix_symbol <- mapToSymbol(inputData=inputMatDir,organism="hsapiens",inputType="matrix",idType="affy_hg_u133_plus_2",collapse_mode="maxSD")
# 
# print("transform ids in the sbt file to gene symbols...")
# inputSBTDir <- system.file("extdata","exampleSBT.sbt",package="NetSAM")
# sbt_symbol <- mapToSymbol(inputData= inputSBTDir,organism="hsapiens",inputType="sbt",idType="affy_hg_u133_plus_2")
# 
# print("transform ids in the sct file to gene symbols...")
# inputSCTDir <- system.file("extdata","exampleSCT.sct",package="NetSAM")
# sct_symbol <- mapToSymbol(inputData= inputSCTDir,organism="hsapiens",inputType="sct",idType="affy_hg_u133_plus_2",collapse_mode="min")

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputMatDir <- system.file("extdata","exampleExpressionData.cct",package="NetSAM")
# matNetwork <- MatNet(inputMat=inputMatDir, collapse_mode="maxSD", naPer=0.7, meanPer=0.8, varPer=0.8,
# corrType="spearman", matNetMethod="rank", valueThr=0.6, rankBest=0.003, networkType="signed",
# netFDRMethod="BH", netFDRThr=0.05, idNumThr=(-1), nThreads=3)

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputMatDir <- system.file("extdata","exampleExpressionData.cct",package="NetSAM")
# data <- read.table(inputMatDir, header=TRUE, row.names=1, stringsAsFactors=FALSE)
# net <- consensusNet(data=data, organism="hsapiens",bootstrapNum=10, naPer=0.5, meanPer=0.8,varPer=0.8,method="rank_unsig",value=3/1000,pth=1e-6, nMatNet=2, nThreads=4)

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputMatDir <- system.file("extdata","exampleExpressionData.cct",package="NetSAM")
# sampleAnnDir <- system.file("extdata","sampleAnnotation.tsi",package="NetSAM")
# formatedData <- testFileFormat(inputMat=inputMatDir,sampleAnn=sampleAnnDir,collapse_mode="maxSD")

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputMatDir <- system.file("extdata","exampleExpressionData.cct",package="NetSAM")
# sampleAnnDir <- system.file("extdata","sampleAnnotation.tsi",package="NetSAM")
# data(NetSAMOutput_Example)
# outputHtmlFile <- paste(getwd(),"/featureAsso_HTML",sep="")
# featureAsso <- featureAssociation(inputMat=inputMatDir, sampleAnn=sampleAnnDir, NetSAMOutput=netsam_output, outputHtmlFile=outputHtmlFile, CONMethod="spearman", CATMethod="kruskal", BINMethod="ranktest", fdrmethod="BH",pth=0.05,collapse_mode="maxSD")

## -----------------------------------------------------------------------------
# library("NetSAM")
# data(NetSAMOutput_Example)
# outputHtmlFile <- paste(getwd(),"/GOAsso_HTML",sep="")
# GOAsso <- GOAssociation(NetSAMOutput=netsam_output, outputHtmlFile=outputHtmlFile, organism="hsapiens", fdrmethod="BH", fdrth=0.05, topNum=5)

## -----------------------------------------------------------------------------
# library("NetSAM")
# inputMatDir <- system.file("extdata","exampleExpressionData.cct",package="NetSAM")
# sampleAnnDir <- system.file("extdata","sampleAnnotation.tsi",package="NetSAM")
# outputFileName <- paste(getwd(),"/MatSAM",sep="")
# matModule <- MatSAM(inputMat=inputMatDir, sampleAnn=sampleAnnDir,
#                     outputFileName = outputFileName, outputFormat="msm",
#                     organism="hsapiens", map_to_symbol=FALSE, idType="auto", collapse_mode="maxSD", naPer=0.7, meanPer=0.8, varPer=0.8,
# corrType="spearman", matNetMethod="rank",
# valueThr=0.6, rankBest=0.003, networkType="signed", netFDRMethod="BH",
# netFDRThr=0.05, minModule=0.003, stepIte=FALSE,
# maxStep=4, moduleSigMethod="cutoff", modularityThr=0.2, ZRanNum=10, PerRanNum=100, ranSig=0.05, idNumThr=(-1), nThreads=3)

