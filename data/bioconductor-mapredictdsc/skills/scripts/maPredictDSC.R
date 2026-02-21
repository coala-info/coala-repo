# Code example from 'maPredictDSC' vignette. See references/ for full tutorial.

### R code from vignette source 'maPredictDSC.Rnw'

###################################################
### code chunk number 1: maPredictDSC.Rnw:72-77
###################################################
library(maPredictDSC)
library(LungCancerACvsSCCGEO)
data(LungCancerACvsSCCGEO)
anoLC
gsLC


###################################################
### code chunk number 2: maPredictDSC.Rnw:95-100
###################################################
modlist=predictDSC(ano=anoLC,
celfile.path=system.file("extdata/lungcancer",package="LungCancerACvsSCCGEO"),
annotation="hgu133plus2.db", preprocs=c("rma"),
filters=c("mttest","ttest"),classifiers=c("LDA","kNN"),
CVP=2,NF=4, NR=1,FCT=1.0)


###################################################
### code chunk number 3: maPredictDSC.Rnw:110-111
###################################################
modlist[["rma_ttest_LDA"]]


###################################################
### code chunk number 4: maPredictDSC.Rnw:119-121
###################################################
trainingAUC=sort(unlist(lapply(modlist,"[[","best_AUC")),decreasing=TRUE)
cbind(trainingAUC)


###################################################
### code chunk number 5: maPredictDSC.Rnw:129-135
###################################################
perF=function(out){
perfDSC(pred=out$predictions,gs=gsLC)
}
testPerf=t(data.frame(lapply(modlist,perF)))
testPerf=testPerf[order(testPerf[,"AUC"],decreasing=TRUE),]
testPerf


###################################################
### code chunk number 6: maPredictDSC.Rnw:141-145
###################################################
best3=names(trainingAUC)[1:3]
aggpred=aggregateDSC(modlist[best3])
#test the aggregated model on the test data
perfDSC(aggpred,gsLC)


