# Code example from 'curatedBreastData-manual' vignette. See references/ for full tutorial.

### R code from vignette source 'curatedBreastData-manual.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: curatedBreastData-manual.Rnw:61-66
###################################################
library("curatedBreastData")
#load up datasets that are in S4 expressionSet format.
#clinical data from master clinicalTable already linked to each sample
#in these ExpressionSets in the phenoData slot.
data(curatedBreastDataExprSetList);


###################################################
### code chunk number 3: curatedBreastData-manual.Rnw:70-76
###################################################
#check out the clinical data for dataset 3
#first look at the GEO study name
names(curatedBreastDataExprSetList)[3]
#only take the first 3 patients for sake of printing to screen
#look at first 10 clinical variables
head(pData(curatedBreastDataExprSetList[[3]])[c(1:3), c(1:10)])


###################################################
### code chunk number 4: curatedBreastData-manual.Rnw:82-85
###################################################
#process only the first two datasets to avoid a long-running example:
#take top 5000 genes by variance from each dataset.
proc_curatedBreastDataExprSetList <- processExpressionSetList(exprSetList=curatedBreastDataExprSetList[1:2], outputFileDirectory = "./", numTopVarGenes=5000)


###################################################
### code chunk number 5: curatedBreastData-manual.Rnw:93-109
###################################################
#load up master clinical data table
data(clinicalData)
#look at some of the clinical variable name definitions
clinicalData$clinicalVarDef[c(1:2),]
#Check out the treatment information.
#just do first three patients
head(clinicalData$clinicalTable)[c(1:3),
                                 c(112:ncol(clinicalData$clinicalTable))]
#how many had chemotherapy?
numChemoPatients <- length(which(
  clinicalData$clinicalTable$chemotherapyClass==1))
#around 1500 had chemotherapy
numChemoPatients
#which patients specifically had a taxane chemotherapy?
numChemoTaxane <- length(which(clinicalData$clinicalTable$taxane==1))
numChemoTaxane


###################################################
### code chunk number 6: curatedBreastData-manual.Rnw:114-119
###################################################
#how many had adjuvant therapy?
numAdjPatients <- length(which(
  clinicalData$clinicalTable$neoadjuvant_or_adjuvant=="adj"))
#over a 1000 had (documented) adjuvant therapy
numAdjPatients 


###################################################
### code chunk number 7: curatedBreastData-manual.Rnw:125-136
###################################################
#how many patients have non-NA OS binary data?
length(which(!is.na(clinicalData$clinicalTable$OS)))
#how many have OS data in the more granular form of months until OS? 
#this variable includes studies that had a cieling for tracking OS
length(which(!is.na(clinicalData$clinicalTable$OS_months_or_MIN_months_of_OS)))
#how many patients have OS information that is definitively 
#followed up until their death (details on how studies collect OS data can be surprising!)
length(which(!is.na(clinicalData$clinicalTable$OS_up_until_death)))

#finish up with sessionInfo
sessionInfo()


