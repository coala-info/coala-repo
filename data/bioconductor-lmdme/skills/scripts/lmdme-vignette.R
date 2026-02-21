# Code example from 'lmdme-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'lmdme-vignette.Rnw'

###################################################
### code chunk number 1: General R options for Sweave
###################################################
options(prompt="R> ", continue="+  ", width=70, useFancyQuotes=FALSE, digits=4)


###################################################
### code chunk number 2: Loading stemHypoxia
###################################################
library("stemHypoxia")
data("stemHypoxia") 


###################################################
### code chunk number 3: Filtering stemHypoxia
###################################################
timeIndex<-design$time %in% c(0.5, 1, 5)  
oxygenIndex<-design$oxygen %in% c(1, 5, 21) 
design<-design[timeIndex & oxygenIndex, ]
design$time<-as.factor(design$time)  
design$oxygen<-as.factor(design$oxygen)
rownames(M)<-M$Gene_ID
M<-M[, colnames(M) %in% design$samplename]


###################################################
### code chunk number 4: Exploring M and design objects
###################################################
head(design)
head(M)[, 1:3]


###################################################
### code chunk number 5: ANOVA decomposition for PradoLopez data
###################################################
library("lmdme")
fit<-lmdme(model=~time*oxygen, data=M, design=design)
fit


###################################################
### code chunk number 6: ASCA and PLSR decomposition
###################################################
id<-F.p.values(fit, term="time:oxygen")<0.001
decomposition(fit, decomposition="pca", type="coefficient", 
  term="time:oxygen", subset=id, scale="row")
fit.plsr<-fit
decomposition(fit.plsr, decomposition="plsr", type="coefficient", 
  term="time:oxygen", subset=id, scale="row")


###################################################
### code chunk number 7: ASCA and PLSR biplots
###################################################
biplot(fit, xlabs="o", expand=0.7)
biplot(fit.plsr, which="loadings", xlabs="o", 
  ylabs=colnames(coefficients(fit.plsr, term="time:oxygen")),
  var.axes=TRUE)


###################################################
### code chunk number 8: ASCA_biplot
###################################################
biplot(fit,xlabs="o", mfcol=NULL, expand=0.7)


###################################################
### code chunk number 9: PLSR_biplot
###################################################
biplot(fit.plsr, which="loadings", xlabs="o", 
  ylabs=colnames(coefficients(fit.plsr,term="time:oxygen")),
  var.axes=TRUE, mfcol=NULL)


###################################################
### code chunk number 10: Loadingplot
###################################################
loadingplot(fit, term.x="time", term.y="oxygen")


###################################################
### code chunk number 11: Session Info
###################################################
sessionInfo()


