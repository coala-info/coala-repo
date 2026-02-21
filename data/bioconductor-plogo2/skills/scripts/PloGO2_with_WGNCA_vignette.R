# Code example from 'PloGO2_with_WGNCA_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'PloGO2_with_WGNCA_vignette.Rnw'

###################################################
### code chunk number 1: wgcnainput
###################################################
library(PloGO2)
library(xtable)
path <- system.file("files", package = "PloGO2")
print(xtable(read.csv(file.path(path,"rice.csv"))[1:6,c(1:2,5:7)]))


###################################################
### code chunk number 2: wgcnaplots
###################################################
source(file.path(system.file("script", package = "PloGO2"), "WGCNA_proteomics.R"))


###################################################
### code chunk number 3: wgcnaoutput
###################################################
print(xtable(readWorkbook("ResultsWGCNA.xlsx", "red")[1:6,c(1:2,5:7,23:24)]))


###################################################
### code chunk number 4: wgcna2plogo2
###################################################
annot.folder <- genAnnotationFiles("ResultsWGCNA.xlsx", DB.name = file.path(path, "pathwayDB.csv"))
res <- PloPathway(reference="AllData", filesPath=annot.folder,
	data.file.name = file.path(path, "Abundance_data.csv"),
	datafile.ignore.cols = 1)


