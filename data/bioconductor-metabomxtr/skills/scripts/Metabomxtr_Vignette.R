# Code example from 'Metabomxtr_Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'Metabomxtr_Vignette.Rnw'

###################################################
### code chunk number 1: Metabomxtr_Vignette.Rnw:34-35
###################################################
  library(metabomxtr)


###################################################
### code chunk number 2: Metabomxtr_Vignette.Rnw:40-42
###################################################
  data(metabdata)
dim(metabdata)


###################################################
### code chunk number 3: Metabomxtr_Vignette.Rnw:47-49
###################################################
  yvars<-colnames(metabdata)[24:27]
apply(metabdata[,yvars],2,function(x){sum(is.na(x))})


###################################################
### code chunk number 4: Metabomxtr_Vignette.Rnw:54-59
###################################################
  par(mfrow = c(2, 2))
hist(metabdata$malonic.acid,main="Malonic Acid",xlab=NULL)
hist(metabdata$ribose,main="Ribose",xlab=NULL)
hist(metabdata$phenylalanine,main="Phenylalanine",xlab=NULL)
hist(metabdata$pyruvic.acid,main="Pyruvic Acid",xlab=NULL)


###################################################
### code chunk number 5: Metabomxtr_Vignette.Rnw:68-70
###################################################
levels(metabdata$PHENO)
metabdata$PHENO<-relevel(metabdata$PHENO,ref="MomLowFPG")


###################################################
### code chunk number 6: Metabomxtr_Vignette.Rnw:75-76
###################################################
table(metabdata$PHENO)


###################################################
### code chunk number 7: Metabomxtr_Vignette.Rnw:81-82
###################################################
fullModel<-~PHENO|PHENO+age_ogtt_mc+ga_ogtt_wks_mc+storageTimesYears_mc+parity12


###################################################
### code chunk number 8: Metabomxtr_Vignette.Rnw:87-88
###################################################
reducedModel<-~1|age_ogtt_mc+ga_ogtt_wks_mc+storageTimesYears_mc+parity12


###################################################
### code chunk number 9: Metabomxtr_Vignette.Rnw:93-95
###################################################
fullModelResults<-mxtrmod(ynames=yvars,mxtrModel=fullModel,data=metabdata)
fullModelResults


###################################################
### code chunk number 10: Metabomxtr_Vignette.Rnw:104-106
###################################################
reducedModelResults<-mxtrmod(ynames=yvars,mxtrModel=reducedModel,data=metabdata,fullModel=fullModel)
reducedModelResults


###################################################
### code chunk number 11: Metabomxtr_Vignette.Rnw:113-115
###################################################
finalResult<-mxtrmodLRT(fullmod=fullModelResults,redmod=reducedModelResults,adj="BH")
finalResult


###################################################
### code chunk number 12: Metabomxtr_Vignette.Rnw:119-120
###################################################
pa.pval<-round(finalResult[finalResult$.id=="pyruvic.acid","adjP"],digits=4)


###################################################
### code chunk number 13: Metabomxtr_Vignette.Rnw:130-133
###################################################
HighFPG.Prop<-round(exp(fullModelResults$xInt+fullModelResults$x_PHENOMomHighFPG)/
(1+exp(fullModelResults$xInt+fullModelResults$x_PHENOMomHighFPG)),digits=2)
LowFPG.Prop<-round(exp(fullModelResults$xInt)/(1+exp(fullModelResults$xInt)),digits=2)


###################################################
### code chunk number 14: Metabomxtr_Vignette.Rnw:138-141
###################################################
HighFPG.Mean<-round(fullModelResults$zInt+fullModelResults$z_PHENOMomHighFPG,digits=2)
LowFPG.Mean<-round(fullModelResults$zInt,digits=2)
FPG.MeanDiff<-round(fullModelResults$z_PHENOMomHighFPG,digits=2)


###################################################
### code chunk number 15: Metabomxtr_Vignette.Rnw:146-150
###################################################
finalResultTable<-data.frame(Metabolite=fullModelResults$.id,HighFPG.Prop=HighFPG.Prop,
LowFPG.Prop=LowFPG.Prop,HighFPG.Mean=HighFPG.Mean,
LowFPG.Mean=LowFPG.Mean,Mean.Difference=FPG.MeanDiff,
FDR.Adj.P=round(finalResult$adjP,digits=4))


###################################################
### code chunk number 16: dTable
###################################################
library(xtable)
finalXTable<-xtable(finalResultTable,digits=c(0,2,2,2,2,2,2,4))
print(finalXTable)


###################################################
### code chunk number 17: Metabomxtr_Vignette.Rnw:165-166
###################################################
toLatex(sessionInfo())


