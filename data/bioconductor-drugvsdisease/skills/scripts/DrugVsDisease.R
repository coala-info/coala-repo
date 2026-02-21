# Code example from 'DrugVsDisease' vignette. See references/ for full tutorial.

### R code from vignette source 'DrugVsDisease.Rnw'

###################################################
### code chunk number 1: DrugVsDisease.Rnw:29-30
###################################################
options(width=60)


###################################################
### code chunk number 2: DrugVsDisease.Rnw:37-39 (eval = FALSE)
###################################################
## library(DrugVsDisease)
## profileAE<-generateprofiles(input="AE",accession="E-GEOD-22528")


###################################################
### code chunk number 3: DrugVsDisease.Rnw:44-45 (eval = FALSE)
###################################################
## names(profileAE)


###################################################
### code chunk number 4: DrugVsDisease.Rnw:50-51 (eval = FALSE)
###################################################
## colnames(profileAE$ranklist)


###################################################
### code chunk number 5: DrugVsDisease.Rnw:56-57 (eval = FALSE)
###################################################
## selprofiles<-selectrankedlists(profileAE,1)


###################################################
### code chunk number 6: DrugVsDisease.Rnw:63-64 (eval = FALSE)
###################################################
## default<-classifyprofile(data=selprofiles$ranklist, signif.fdr=1.1)


###################################################
### code chunk number 7: DrugVsDisease.Rnw:66-69 (eval = FALSE)
###################################################
## library(xtable)
## default<-as.data.frame(default[[1]])
## xtable(default[,2:4])


###################################################
### code chunk number 8: AEx (eval = FALSE)
###################################################
## profileAE<-generateprofiles(input="AE",accession="E-GEOD-22528")


###################################################
### code chunk number 9: GEO (eval = FALSE)
###################################################
## gds1479<-generateprofiles("GEO",accession="GDS1479",
## annotation="hgu133a",factorvalue="specimen",case="disease")


###################################################
### code chunk number 10: DrugVsDisease.Rnw:120-121 (eval = FALSE)
###################################################
## sel1479<-selectrankedlists(gds1479,c(3,18))


###################################################
### code chunk number 11: DrugVsDisease.Rnw:123-124 (eval = FALSE)
###################################################
## sel22528<-selectrankedlists(profileAE,1)


###################################################
### code chunk number 12: DrugVsDisease.Rnw:137-138 (eval = FALSE)
###################################################
## default<-classifyprofile(data=sel22528$ranklist, signif.fdr=1.1)


###################################################
### code chunk number 13: DrugVsDisease.Rnw:153-155 (eval = FALSE)
###################################################
## c1<-classifyprofile(data=sel22528$ranklist,type="fixed",lengthtest=100,
## cytoout=FALSE,noperm=100)


###################################################
### code chunk number 14: DrugVsDisease.Rnw:160-162 (eval = FALSE)
###################################################
## c2<-classifyprofile(data=sel22528$ranklist,type="range",range=c(100,200),
## cytoout=FALSE,noperm=100)


###################################################
### code chunk number 15: DrugVsDisease.Rnw:166-168 (eval = FALSE)
###################################################
## c3<-classifyprofile(data=sel22528$ranklist,pvalues=sel22528$pvalues,
## cytoout=FALSE,type="dynamic",dynamic.fdr=0.5,adj="BH")


###################################################
### code chunk number 16: DrugVsDisease.Rnw:177-179 (eval = FALSE)
###################################################
## dynamicfdr<-classifyprofile(data=sel22528$ranklist,pvalues=sel22528$pvalues,
## cytoout=FALSE,type="dynamic",dynamic.fdr=0.5,signif.fdr=0.15,adj="BH")


###################################################
### code chunk number 17: DrugVsDisease.Rnw:187-189 (eval = FALSE)
###################################################
## clusteraverage<-classifyprofile(data=sel22528$ranklist,cytoout=FALSE,
## clustermethod="average",avgstat="median")


###################################################
### code chunk number 18: DrugVsDisease.Rnw:196-203 (eval = FALSE)
###################################################
## data(customDB,package="DrugVsDisease")
## data(customClust,package="DrugVsDisease")
## data(customedge,package="DrugVsDisease")
## data(customsif,package="DrugVsDisease")
## customRefData<-classifyprofile(data=sel22528$ranklist, lengthtest=100,
## customRefDB=customDB, customClusters=customClust, 
## customedge=customedge, customsif=customsif, cytoout=FALSE,signif.fdr=1.1)


###################################################
### code chunk number 19: DrugVsDisease.Rnw:209-211 (eval = FALSE)
###################################################
## CytoOut<-classifyprofile(data=sel22528$ranklist,cytoout=TRUE,
## cytofile="CytoscapeOutput",adj="BH")


