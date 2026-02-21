# Code example from 'IMPCdata' vignette. See references/ for full tutorial.

### R code from vignette source 'IMPCdata.Rnw'

###################################################
### code chunk number 1: IMPCdata.Rnw:58-60
###################################################
library(IMPCdata)
getName("pipeline_stable_id","pipeline_name","MGP_001")


###################################################
### code chunk number 2: IMPCdata.Rnw:63-65
###################################################
library(IMPCdata)
getName("gene_accession_id","gene_symbol","MGI:1931466")


###################################################
### code chunk number 3: IMPCdata.Rnw:83-86
###################################################
library(IMPCdata)
getPhenCenters()
printPhenCenters()


###################################################
### code chunk number 4: IMPCdata.Rnw:94-98
###################################################
library(IMPCdata)
getPipelines("WTSI")
getPipelines("WTSI",excludeLegacyPipelines=FALSE)
printPipelines("WTSI")


###################################################
### code chunk number 5: IMPCdata.Rnw:109-112
###################################################
library(IMPCdata)
head(getProcedures("WTSI","MGP_001"),n=2)
printProcedures("WTSI","MGP_001",n=2)


###################################################
### code chunk number 6: IMPCdata.Rnw:119-122
###################################################
library(IMPCdata)
head(getParameters("WTSI","MGP_001","IMPC_CBC_001"),n=2)
printParameters("WTSI","MGP_001","IMPC_CBC_001",n=2)


###################################################
### code chunk number 7: IMPCdata.Rnw:133-136
###################################################
library(IMPCdata)
head(getStrains("WTSI","MGP_001","IMPC_CBC_001","IMPC_CBC_003_001"),n=2)
printStrains("WTSI","MGP_001","IMPC_CBC_001","IMPC_CBC_003_001",n=2)


###################################################
### code chunk number 8: IMPCdata.Rnw:146-150
###################################################
library(IMPCdata)
head(getGenes("WTSI","MGP_001","IMPC_CBC_001","IMPC_CBC_003_001"),n=2)
printGenes("WTSI","MGP_001","IMPC_CBC_001",
"IMPC_CBC_003_001","MGI:2159965",n=2)


###################################################
### code chunk number 9: IMPCdata.Rnw:160-164
###################################################
library(IMPCdata)
head(getAlleles("WTSI","MGP_001","IMPC_CBC_001",
"IMPC_CBC_003_001","MGI:5446362"),n=2)
printAlleles("WTSI","MGP_001","IMPC_CBC_001","IMPC_CBC_003_001",n=2)


###################################################
### code chunk number 10: IMPCdata.Rnw:177-180
###################################################
library(IMPCdata)
getZygosities("WTSI","MGP_001","IMPC_CBC_001","IMPC_CBC_003_001",
StrainID="MGI:5446362",AlleleID="EUROALL:64")


###################################################
### code chunk number 11: IMPCdata.Rnw:215-217 (eval = FALSE)
###################################################
## library(IMPCdata)
## getIMPCTable("./IMPCData.csv","WTSI","MGP_001","IMPC_CBC_001")  


###################################################
### code chunk number 12: IMPCdata.Rnw:232-235 (eval = FALSE)
###################################################
## library(IMPCdata)
## IMPC_dataset1 <- getIMPCDataset("WTSI","MGP_001","IMPC_CBC_001",
## "IMPC_CBC_003_001","MGI:4431644") 


###################################################
### code chunk number 13: IMPCdata.Rnw:238-243 (eval = FALSE)
###################################################
## library(PhenStat)
## testIMPC1 <- PhenList(dataset=IMPC_dataset1,
## testGenotype="MDTZ",
## refGenotype="+/+",
## dataset.colname.genotype="Colony") 


