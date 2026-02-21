# Code example from 'DiffExpressVignette' vignette. See references/ for full tutorial.

### R code from vignette source 'DiffExpressVignette.Snw'

###################################################
### code chunk number 1: DiffExpressVignette.Snw:84-85
###################################################
options(width=95)


###################################################
### code chunk number 2: getData
###################################################
library('ChimpHumanBrainData')
library(affy)
celfileDir = system.file('extdata',package='ChimpHumanBrainData')
celfileNames = list.celfiles(celfileDir)
brainBatch=ReadAffy(filenames=celfileNames,celfile.path=celfileDir,compress=TRUE)



###################################################
### code chunk number 3: createNames
###################################################
sampleNames(brainBatch)
sampleNames(brainBatch)=paste(rep(c("CH","HU"),each=12),rep(c(1:3,1:3),each=4),
  rep(c("Prefrontal","Caudate","Cerebellum","Broca"),6),sep="")


###################################################
### code chunk number 4: DiffExpressVignette.Snw:107-111
###################################################
brain.expr=exprs(brainBatch)
library(hexbin)
plot(hexplom(log2(brain.expr[,paste(rep(c("CH","HU"),each=3),
  c(1:3,1:3),rep("Prefrontal",6),sep="")])))


###################################################
### code chunk number 5: DiffExpressVignette.Snw:121-124
###################################################
trts=factor(paste(rep(c("CH","HU"),each=12),
  rep(c("Prefrontal","Caudate","Cerebellum","Broca"),6),sep=""))
blocks=factor(rep(1:6,each=4))


###################################################
### code chunk number 6: DiffExpressVignette.Snw:127-128
###################################################
brain.rma=rma(brainBatch)


###################################################
### code chunk number 7: DiffExpressVignette.Snw:156-158
###################################################
library(limma)
design.trt=model.matrix(~0+trts)


###################################################
### code chunk number 8: DiffExpressVignette.Snw:170-172
###################################################
library(statmod)
corfit <- duplicateCorrelation(brain.rma, design.trt, block = blocks)


###################################################
### code chunk number 9: DiffExpressVignette.Snw:178-179
###################################################
hist(tanh(corfit$atanh.correlations))


###################################################
### code chunk number 10: DiffExpressVignette.Snw:190-191
###################################################
fitTrtMean <- lmFit(brain.rma, design.trt, block = blocks, cor = corfit$consensus.correlation)


###################################################
### code chunk number 11: DiffExpressVignette.Snw:212-224
###################################################
colnames(design.trt)
contrast.matrix=makeContrasts(
  (trtsCHBroca+trtsCHCaudate+trtsCHCerebellum+trtsCHPrefrontal)/4
     -(trtsHUBroca+trtsHUCaudate+trtsHUCerebellum+trtsHUPrefrontal)/4,
  trtsCHBroca-trtsHUBroca,
  trtsCHCaudate-trtsHUCaudate,
  trtsCHCerebellum-trtsHUCerebellum,
  trtsCHPrefrontal-trtsHUPrefrontal,
  (trtsCHCerebellum-trtsHUCerebellum)-(trtsCHBroca-trtsHUBroca),
 levels=design.trt)
colnames(contrast.matrix)=
  c("ChVsHu","Broca","Caudate","Cerebellum","Prefrontal","Interact")


###################################################
### code chunk number 12: DiffExpressVignette.Snw:233-234
###################################################
fit.contrast=contrasts.fit(fitTrtMean,contrast.matrix)


###################################################
### code chunk number 13: DiffExpressVignette.Snw:242-243
###################################################
efit.contrast=eBayes(fit.contrast)


###################################################
### code chunk number 14: DiffExpressVignette.Snw:256-260
###################################################
par(mfrow=c(2,3))
for (i in 1:ncol(efit.contrast$p.value)) {
hist(efit.contrast$p.value[,i],main=colnames(efit.contrast$p.value)[i])
}


###################################################
### code chunk number 15: DiffExpressVignette.Snw:285-288
###################################################
genes=geneNames(brainBatch)
topTable(efit.contrast,coef=1,adjust.method="BY",n=10,p.value=1e-5,genelist=genes)
topTable(efit.contrast,coef=6,adjust.method="BY",n=10,p.value=1e-5,genelist=genes)


###################################################
### code chunk number 16: DiffExpressVignette.Snw:297-302
###################################################
write.table(file="fits.txt",
  cbind(genes,fitTrtMean$coefficients,efit.contrast$coefficients,efit.contrast$p.value),
  row.names=F,
  col.names=c("GeneID",colnames(fitTrtMean$coefficients),colnames(efit.contrast$p.value), 
  paste("p",colnames(efit.contrast$coefficients))),sep=",")


###################################################
### code chunk number 17: DiffExpressVignette.Snw:308-310
###################################################
library(qvalue)
q.values=apply(efit.contrast$p.value,2, function(x) qvalue(x)$qvalues)


###################################################
### code chunk number 18: sessionInfo
###################################################
toLatex(sessionInfo())


###################################################
### code chunk number 19: DiffExpressVignette.Snw:337-338
###################################################
print(gc())


