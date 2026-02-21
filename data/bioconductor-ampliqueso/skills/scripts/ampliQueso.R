# Code example from 'ampliQueso' vignette. See references/ for full tutorial.

### R code from vignette source 'ampliQueso.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: camelPlot3
###################################################
library(ampliQueso)
data(ampliQueso)
par(mfrow=c(1,2))
simplePlot(ndMin,exps=1:2,xlab="genome coordinates \n RGS1:NM_002922",
           ylab="coverage")
simplePlot(ndMax,exps=1:2,xlab="genome coordinates \n PLEK:NM_002664",
           ylab="coverage")


###################################################
### code chunk number 2: samplecamelTest
###################################################
library(xtable)
curWd<-getwd()
setwd(path.package("ampliQueso")) ##only for sample report
iCovdesc=system.file("extdata","covdesc",package="ampliQueso")
iBedFile=system.file("extdata","AQ.bed",package="ampliQueso")
iT1="s"
iT2="h"
camelTestTable <- camelTest(iBedFile=iBedFile,iCovdesc=iCovdesc, 
                            iT1=iT1, iT2=iT2,iParallel=FALSE,iNPerm=5)
#print sample p-values,not all of them
camelTestTableDen<-camelTestTable[1:5,6:10]
print(xtable(camelTestTableDen,caption="p-values from camel tests"))
setwd(curWd)


###################################################
### code chunk number 3: sampleCamtable
###################################################
library(xtable)
data(ampliQueso)
print(xtable(camelSampleTable,
             caption="Camel/coverage measures for two sample regions"))



###################################################
### code chunk number 4: camel2
###################################################
library(ampliQueso)
setwd(path.package("ampliQueso"))
cc <- getCountTable(covdesc=system.file("extdata","covdesc",package="ampliQueso"),
                    bedFile=system.file("extdata","AQ.bed",package="ampliQueso"))
cc[1:4,1:2]


###################################################
### code chunk number 5: sampleSNPCaller (eval = FALSE)
###################################################
## #in order to run this example you need provide reference sequence 
## #in FASTA format and set refSeqFile parameter
## curWd<-getwd()
## setwd(path.package("ampliQueso")) ##only for sample report
## iCovdesc=system.file("extdata","covdesc",package="ampliQueso")
## iBedFile=system.file("extdata","AQ.bed",package="ampliQueso")
## snpList <- getSNP(covdesc=iCovdesc, minQual=10, 
##                   refSeqFile="hg19.fa", bedFile = iBedFile)
## setwd(curWd)


###################################################
### code chunk number 6: runQAReport (eval = FALSE)
###################################################
## #########Example##########################
## library(ampliQueso)
## curWd<-getwd()
## setwd(path.package("ampliQueso")) ##only for sample report
## iCovdesc=system.file("extdata","covdesc",package="ampliQueso")
## iBedFile=system.file("extdata","AQ.bed",package="ampliQueso")
## iRefSeqFile=NULL
## iGroup="group"
## iT1="s"
## iT2="h"
## iTopN=5
## iMinQual=NULL
## iReportFormat="pdf"
## iReportType="article"
## iReportPath=curWd
## iVerbose=FALSE
## iParallel=FALSE
## 
## runAQReport(iCovdesc=iCovdesc,iBedFile=iBedFile,iRefSeqFile=iRefSeqFile,
## iGroup=iGroup,iT1=iT1,iT2=iT2,iTopN=iTopN,iMinQual=iMinQual,
## iReportFormat=iReportFormat,iReportType=iReportType,
##             iReportPath,iVerbose=iVerbose,iParallel=iParallel)
## setwd(curWd)


