# Code example from 'SpeCond' vignette. See references/ for full tutorial.

### R code from vignette source 'SpeCond.Rnw'

###################################################
### code chunk number 1: SpeCond.Rnw:53-56
###################################################
d=tempdir()
oldir=getwd()
setwd(d)


###################################################
### code chunk number 2: SpeCond.Rnw:59-67
###################################################
library(SpeCond)
data(expSetSpeCondExample)
expSetSpeCondExample
class(expSetSpeCondExample)
data(expressionSpeCondExample)
Mexp=expressionSpeCondExample
class(Mexp)
dim(Mexp)


###################################################
### code chunk number 3: SpeCond.Rnw:71-75
###################################################
generalResult=SpeCond(Mexp, param.detection=NULL, multitest.correction.method="BY",
  prefix.file="E", print.hist.pv=TRUE, fit1=NULL, fit2=NULL, specificOutlierStep1=NULL)
names(generalResult)
specificResult=generalResult$specificResult


###################################################
### code chunk number 4: SpeCond.Rnw:79-83 (eval = FALSE)
###################################################
## generalResult=SpeCond(expSetSpeCondExample, param.detection=NULL, 
##   multitest.correction.method="BY", prefix.file="E", print.hist.pv=TRUE, fit1=NULL,
##   fit2=NULL, specificOutlierStep1=NULL, condition.factor=expSetSpeCondExample$Tissue,
##   condition.method="mean")


###################################################
### code chunk number 5: SpeCond.Rnw:86-88 (eval = FALSE)
###################################################
## MexpS=getMatrixFromExpressionSet(expSetSpeCondExample,
##   condition.factor=expSetSpeCondExample$Tissue,condition.method="mean")


###################################################
### code chunk number 6: SpeCond.Rnw:104-108
###################################################
getFullHtmlSpeCondResult(SpeCondResult=generalResult, param.detection=
  specificResult$param.detection, page.name="Example_SpeCond_results",
  page.title="Tissue specific results", sort.condition="all", heatmap.profile=TRUE,
  heatmap.expression=FALSE, heatmap.unique.profile=FALSE, expressionMatrix=Mexp)


###################################################
### code chunk number 7: SpeCond.Rnw:125-127
###################################################
genePageInfo=getGeneHtmlPage(Mexp, specificResult, name.index.html=
  "index_example_SpeCond_Results.html", gene.html.ids=c(1:20))


###################################################
### code chunk number 8: SpeCond.Rnw:157-159
###################################################
param.detection=getDefaultParameter()
param.detection


###################################################
### code chunk number 9: SpeCond.Rnw:162-167
###################################################
param.detection2=createParameterMatrix(mlk.1=10)
param.detection2
param.detection2B=createParameterMatrix(param.detection=param.detection2, 
  mlk.1=15, rsd.2=0.2)
param.detection2B


###################################################
### code chunk number 10: SpeCond.Rnw:189-195
###################################################
param.detection2=createParameterMatrix(param.detection, mlk.1=10)
param.detection2
generalResult2=SpeCond(Mexp, param.detection=param.detection2,
  multitest.correction.method="BY", prefix.file="E2", 
  print.hist.pv=TRUE, fit1=generalResult$fit1, fit2=NULL, 
  specificOutlierStep1=NULL)


###################################################
### code chunk number 11: SpeCond.Rnw:198-204
###################################################
param.detection3=createParameterMatrix(param.detection, rsd.2=0.2, per.2=0.2)
param.detection3
generalResult3=SpeCond(Mexp, param.detection=param.detection3,
  multitest.correction.method="BY", prefix.file="E3", print.hist.pv=TRUE,
  fit1=generalResult$fit1, fit2=generalResult$fit2,
  specificOutlierStep1=generalResult$specificOutliersStep1)


###################################################
### code chunk number 12: SpeCond.Rnw:219-221
###################################################
param.detection
fit1=fitPrior(Mexp, param.detection=param.detection)


###################################################
### code chunk number 13: SpeCond.Rnw:224-225 (eval = FALSE)
###################################################
## fit1=fitPrior(Mexp, lambda=param.detection[1,"lambda"], beta=param.detection[1,"beta"])


###################################################
### code chunk number 14: SpeCond.Rnw:228-231
###################################################
specificOutlierStep1=getSpecificOutliersStep1(Mexp, fit=fit1$fit1,param.detection,
  multitest.correction.method="BY", prefix.file="run1_Step1",
  print.hist.pv=FALSE)


###################################################
### code chunk number 15: SpeCond.Rnw:234-236
###################################################
fit2=fitNoPriorWithExclusion(Mexp, specificOutlierStep1=specificOutlierStep1,
  param.detection=param.detection)


###################################################
### code chunk number 16: SpeCond.Rnw:239-241 (eval = FALSE)
###################################################
## fit2=fitNoPriorWithExclusion(Mexp, specificOutlierStep1=specificOutlierStep1, 
##   lambda=param.detection[2,"lambda"], beta=param.detection[2,"beta"])


###################################################
### code chunk number 17: SpeCond.Rnw:244-248
###################################################
specificResult=getSpecificResult(Mexp, fit=fit2,
  specificOutlierStep1=specificOutlierStep1, param.detection, 
  multitest.correction.method="BY", prefix.file="run1_Step2",
  print.hist.pv=FALSE)


###################################################
### code chunk number 18: SpeCond.Rnw:297-304
###################################################
names(generalResult)
specificResult=generalResult$specificResult
names(specificResult)
names(specificResult$L.specific.result)
dim(specificResult$L.specific.result$M.specific.all)
dim(specificResult$L.specific.result$M.specific)
specificResult


###################################################
### code chunk number 19: SpeCond.Rnw:321-329
###################################################
L.specific.result.profile=getProfile(specificResult$L.specific.result$M.specific)
writeSpeCondResult(specificResult$L.specific.result,file.name.profile=
  "Example_specific_profile.txt", file.specific.gene="Example_list_specific_gene.txt",
  file.name.unique.profile="Example_specific_unique_profile.txt")
writeUniqueProfileSpecificResult(L.specific.result=specificResult$L.specific.result,
  file.name.unique.profile="Example_specific_unique_profile.txt", full.list.gene=FALSE)
writeGeneResult(specificResult$L.specific.result, file.name.result.gene=
  "Example_gene_gummary_result.txt", gene.names=rownames(Mexp)[1:10])


###################################################
### code chunk number 20: SpeCond.Rnw:369-370
###################################################
data(simulatedSpeCondData)


###################################################
### code chunk number 21: SpeCond.Rnw:373-384
###################################################
generalResult_S1=SpeCond(simulatedSpeCondData, param.detection=NULL,
  multitest.correction.method="BY", prefix.file="S1", print.hist.pv=TRUE,
  fit1=NULL, fit2=NULL, specificOutlierStep1=NULL)

specificResult_S1=generalResult_S1$specificResult
getFullHtmlSpeCondResult(L.specific.result=specificResult_S1$L.specific.result,
  page.name="simulatedSpeCondData_results", page.title="Condition specific results mlk 25 
  default", prefix.file="S1", sort.condition="all")
genePageInfo_S1=getGeneHtmlPage(simulatedSpeCondData, specificResult_S1,
  name.index.html="index_simulatedSpeCondData.html", prefix.file="S1",
  gene.html.ids=c(1:20))


###################################################
### code chunk number 22: SpeCond.Rnw:390-392
###################################################
param.detection10=createParameterMatrix(param.detection=param.detection, mlk.2=10)
param.detection10


###################################################
### code chunk number 23: SpeCond.Rnw:395-410
###################################################
generalResult_S2=SpeCond(simulatedSpeCondData, param.detection=param.detection10,
  multitest.correction.method="BY", prefix.file="S2", print.hist.pv=TRUE,
  fit1=generalResult_S1$fit1, fit2=generalResult_S1$fit2, 
  specificOutlierStep1=generalResult_S1$specificOutliersStep1)

specificResult_S2=generalResult_S2$specificResult

genePageInfo_S2=getGeneHtmlPage(simulatedSpeCondData, specificResult_S2, 
  name.index.html="index_simulatedSpeCondData.html", prefix.file="S2", 
  gene.html.ids=c(1:20,200:250))

getFullHtmlSpeCondResult(L.specific.result=specificResult_S2$L.specific.result,
  param.detection=param.detection10, page.name="simulatedSpeCondData_results", 
  page.title="Condition specific results mlk 10",prefix.file="S2", sort.condition="all",
  gene.page.info=genePageInfo_S2)


###################################################
### code chunk number 24: SpeCond.Rnw:415-418
###################################################
param.detection8_0.3=createParameterMatrix(param.detection=param.detection, 
  mlk.2=8, rsd.2=0.3)
param.detection8_0.3


###################################################
### code chunk number 25: SpeCond.Rnw:421-434
###################################################
generalResult_S3=SpeCond(simulatedSpeCondData, param.detection=param.detection8_0.3,
  multitest.correction.method="BY", prefix.file="S3", print.hist.pv=TRUE, 
  fit1=generalResult_S1$fit1, fit2=generalResult_S1$fit2,
  specificOutlierStep1=generalResult_S1$specificOutliersStep1)
specificResult_S3=generalResult_S3$specificResult
genePageInfo_S3=getGeneHtmlPage(simulatedSpeCondData, specificResult_S3,
  name.index.html="index_simulatedSpeCondData.html", prefix.file="S3", 
  gene.html.ids=c(1:20,195:310))

getFullHtmlSpeCondResult(L.specific.result=specificResult_S3$L.specific.result,
  param.detection=param.detection8_0.3, page.name="simulatedSpeCondData_results", 
  page.title="Condition specific results mlk 8, rsd 0.3", prefix.file="S3", 
  sort.condition="all",gene.page.info=genePageInfo_S3)


###################################################
### code chunk number 26: SpeCond.Rnw:436-437
###################################################
setwd(oldir)


###################################################
### code chunk number 27: SpeCond.Rnw:444-446
###################################################
save(fit1,file="fit1.RData")
## load("fit1.RData")


###################################################
### code chunk number 28: SpeCond.Rnw:449-454
###################################################
save(specificOutlierStep1,file="specificOutlierStep1.RData")
## load("specificStep1.RData")
save(fit2,file="fit2.RData")
## load("fit2.Rdata")
save(specificResult,file="specificResult.RData")


###################################################
### code chunk number 29: pkgs
###################################################
toLatex(sessionInfo())


