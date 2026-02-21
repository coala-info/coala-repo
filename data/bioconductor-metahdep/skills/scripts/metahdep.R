# Code example from 'metahdep' vignette. See references/ for full tutorial.

### R code from vignette source 'metahdep.Rnw'

###################################################
### code chunk number 1: metahdep.Rnw:155-164 (eval = FALSE)
###################################################
## library(AnnotationDbi)
## library(hgu133a.db); library(hgu133b.db); library(hgu95a.db); library(hgu95av2.db)
## EID.hgu133a <- unlist(mget(mappedkeys(hgu133aENTREZID),hgu133aENTREZID))
## EID.hgu133b <- unlist(mget(mappedkeys(hgu133bENTREZID),hgu133bENTREZID))
## EID.hgu95a <- unlist(mget(mappedkeys(hgu95aENTREZID),hgu95aENTREZID))
## EID.hgu95av2 <- unlist(mget(mappedkeys(hgu95av2ENTREZID),hgu95av2ENTREZID))
## chip <- c(rep("hgu133a", length(EID.hgu133a)), rep("hgu133b", length(EID.hgu133b)), rep("hgu95a", length(EID.hgu95a)), rep("hgu95av2", length(EID.hgu95av2)))
## EID <- c(EID.hgu133a, EID.hgu133b, EID.hgu95a, EID.hgu95av2)
## newnames <- data.frame(chip=chip, old.name=names(EID), new.name=EID)


###################################################
### code chunk number 2: metahdep.Rnw:174-181 (eval = FALSE)
###################################################
## set.seed(1234)
## use.new.name <- sample(unique(newnames$new.name),1000)
## use.hgu133a.gn <- names(EID.hgu133a[is.element(EID.hgu133a,use.new.name)])
## use.hgu133b.gn <- names(EID.hgu133b[is.element(EID.hgu133b,use.new.name)])
## use.hgu95a.gn <- names(EID.hgu95a[is.element(EID.hgu95a,use.new.name)])
## use.hgu95av2.gn <- names(EID.hgu95av2[is.element(EID.hgu95av2,use.new.name)])
## HGU.newnames <- newnames[is.element(EID,use.new.name),]


###################################################
### code chunk number 3: metahdep.Rnw:242-244 (eval = FALSE)
###################################################
## library(ALLMLL); data(MLL.A)
## ES.exp1 <- getPLM.es(abatch=MLL.A, trt1=list(c(1:5),c(6:10)), trt2=list(c(11:15),c(16:20)), sub.gn=use.hgu133a.gn, covariates=data.frame(Tissue=c(0,1)), dep.grp=1 )


###################################################
### code chunk number 4: metahdep.Rnw:259-262 (eval = FALSE)
###################################################
## library(SpikeInSubset)
## data(spikein95)
## ES.exp2 <- getPLM.es(abatch=spikein95, trt1=1:3, trt2=4:6, sub.gn=use.hgu95a.gn, covariates=data.frame(Tissue=0), dep.grp=1 )


###################################################
### code chunk number 5: metahdep.Rnw:271-273 (eval = FALSE)
###################################################
## data(Dilution)
## ES.exp3 <- getPLM.es(abatch=Dilution, trt1=1:2, trt2=3:4, sub.gn=use.hgu95av2.gn, covariates=data.frame(Tissue=0), dep.grp=2 )


###################################################
### code chunk number 6: metahdep.Rnw:282-284 (eval = FALSE)
###################################################
## data(MLL.B)
## ES.exp4 <- getPLM.es(abatch=MLL.B, trt1=1:9, trt2=10:20, sub.gn=use.hgu133b.gn, covariates=data.frame(Tissue=1), dep.grp=3 )


###################################################
### code chunk number 7: metahdep.Rnw:294-295 (eval = FALSE)
###################################################
## HGU.DifExp.list <- list(ES.exp1, ES.exp2, ES.exp3, ES.exp4)


###################################################
### code chunk number 8: metahdep.Rnw:313-314 (eval = FALSE)
###################################################
## HGU.prep.list <- metahdep.format(HGU.DifExp.list, HGU.newnames)


###################################################
### code chunk number 9: metahdep.Rnw:348-353
###################################################
library(metahdep)
data(HGU.newnames)
data(HGU.prep.list)
set.seed(123)
gene.subset <- sample(HGU.newnames$new.name, 50)


###################################################
### code chunk number 10: metahdep.Rnw:358-359
###################################################
FEMA <- metahdep(HGU.prep.list, method="FEMA", genelist=gene.subset, center.X=TRUE)


###################################################
### code chunk number 11: metahdep.Rnw:366-368
###################################################
REMA <- metahdep(HGU.prep.list, method="REMA", genelist=gene.subset, delta.split=FALSE, center.X=TRUE)
REMA.ds <- metahdep(HGU.prep.list, method="REMA", genelist=gene.subset, delta.split=TRUE, center.X=TRUE)


###################################################
### code chunk number 12: metahdep.Rnw:375-377
###################################################
HBLM <- metahdep(HGU.prep.list, method="HBLM", genelist=gene.subset, delta.split=FALSE, center.X=TRUE, two.sided=TRUE)
HBLM.ds <- metahdep(HGU.prep.list, method="HBLM", genelist=gene.subset, delta.split=TRUE, center.X=TRUE, two.sided=TRUE)


###################################################
### code chunk number 13: metahdep.Rnw:395-398
###################################################
pvals <- data.frame(FEMA=FEMA$Intercept.pval, REMA=REMA$Intercept.pval, REMA.ds=REMA.ds$Intercept.pval,
  HBLM=HBLM$Intercept.pval, HBLM.ds=HBLM.ds$Intercept.pval)
plot(pvals, main='Comparison of Intercept P-values from Meta-Analysis',pch=16,cex=.5)


###################################################
### code chunk number 14: metahdep.Rnw:425-428
###################################################
library(metahdep)
data(gloss)
gloss.Table1


###################################################
### code chunk number 15: metahdep.Rnw:435-436
###################################################
gloss.Table1


###################################################
### code chunk number 16: metahdep.Rnw:448-452
###################################################
attach(gloss.Table1)
sp <- sqrt( ((n1-1)*s1^2+(n2-1)*s2^2) / (n1+n2-2) )
c.correct <- (1-3/(4*dfE-1))
theta <- c.correct * (y2-y1)/sp


###################################################
### code chunk number 17: metahdep.Rnw:460-463
###################################################
pE <- c.correct^2*dfE/(dfE-2)
var.theta <- pE*(1/n2+1/n1) + (pE-1)*theta^2
V <- diag(var.theta)


###################################################
### code chunk number 18: metahdep.Rnw:475-480
###################################################
V[2,3] <- V[3,2] <- (pE[2]-1)*theta[2]*theta[3]
V[4,5] <- V[5,4] <- (pE[4]-1)*theta[4]*theta[5]
V[10,11] <- V[11,10] <- (pE[10]-1)*theta[10]*theta[11]
V[10,12] <- V[12,10] <- (pE[10]-1)*theta[10]*theta[12]
V[11,12] <- V[12,11] <- (pE[11]-1)*theta[11]*theta[12]


###################################################
### code chunk number 19: metahdep.Rnw:488-496
###################################################
X <- matrix(0,nrow=18,ncol=6)
X[,1] <- 1
X[Rec==2,2] <- 1
X[Time==2,3] <- 1
X[Part==2,4] <- 1
X[Part==3,5] <- 1
X[Pct==2,6] <- 1
colnames(X) <- c('Intercept','Rec2','Time2','Part2','Part3','Pct2')


###################################################
### code chunk number 20: metahdep.Rnw:518-534
###################################################
# define dependence groups for delta-splitting models
dep.groups <- list( c(2,3,4,5), c(10,11,12) )

# fixed effects meta-analysis
FEMA.indep <- metahdep.FEMA(theta, diag(diag(V)), X, center.X=TRUE)
FEMA.dep <- metahdep.FEMA(theta, V, X, center.X=TRUE)

# random effects meta-analysis
REMA.indep <- metahdep.REMA(theta, diag(diag(V)), X, center.X=TRUE)
REMA.dep <- metahdep.REMA(theta, V, X, center.X=TRUE)
REMA.ds <- metahdep.REMA(theta, V, X, center.X=TRUE, delta.split=TRUE, dep.groups=dep.groups)

# hierarchical Bayes meta-analysis
HBLM.indep <- metahdep.HBLM(theta, diag(diag(V)), X, center.X=TRUE, two.sided=TRUE)
HBLM.dep <- metahdep.HBLM(theta, V, X, center.X=TRUE, two.sided=TRUE)
HBLM.ds <- metahdep.HBLM(theta, V, X, center.X=TRUE, two.sided=TRUE, delta.split=TRUE, dep.groups=dep.groups, n=20, m=20)


###################################################
### code chunk number 21: metahdep.Rnw:548-563 (eval = FALSE)
###################################################
## r1 <- round(c(FEMA.indep$beta.hats[1], FEMA.indep$beta.hat.p.values[1],NA,NA),4)
## r2 <- round(c(FEMA.dep$beta.hats[1], FEMA.dep$beta.hat.p.values[1],NA,NA),4)
## r3 <- round(c(REMA.indep$beta.hats[1], REMA.indep$beta.hat.p.values[1], REMA.indep$tau2.hat, NA),4)
## r4 <- round(c(REMA.dep$beta.hats[1], REMA.dep$beta.hat.p.values[1], REMA.dep$tau2.hat, NA),4)
## r5 <- round(c(REMA.ds$beta.hats[1], REMA.ds$beta.hat.p.values[1], REMA.ds$tau2.hat, REMA.ds$varsigma.hat),4)
## #r5 <- c(0.5261, 0.0026, 0.2936, -0.0816)
## r6 <- round(c(HBLM.indep$beta.hats[1], HBLM.indep$beta.hat.p.values[1],  HBLM.indep$tau.var + HBLM.indep$tau.hat^2, NA),4)
## r7 <- round(c(HBLM.dep$beta.hats[1], HBLM.dep$beta.hat.p.values[1],  HBLM.dep$tau.var + HBLM.dep$tau.hat^2, NA),4)
## r8 <- round(c(HBLM.ds$beta.hats[1], HBLM.ds$beta.hat.p.values[1],  HBLM.ds$tau.var + HBLM.ds$tau.hat^2, HBLM.ds$varsigma.hat),4)
## model <- c(rep('Fixed',2),rep('Random',3),rep('Bayes',3))
## dep <- c('Independent','Dependent',rep(c('Independent','Dependent','Delta-split'),2))
## Table2 <- as.data.frame(cbind(model,dep,rbind(r1,r2,r3,r4,r5,r6,r7,r8)))
## colnames(Table2) <- c('Model','Structure','Intercept','P','tau-square','varsigma')
## rownames(Table2) <- NULL
## Table2


###################################################
### code chunk number 22: metahdep.Rnw:570-585
###################################################
r1 <- round(c(FEMA.indep$beta.hats[1], FEMA.indep$beta.hat.p.values[1],NA,NA),4)
r2 <- round(c(FEMA.dep$beta.hats[1], FEMA.dep$beta.hat.p.values[1],NA,NA),4)
r3 <- round(c(REMA.indep$beta.hats[1], REMA.indep$beta.hat.p.values[1], REMA.indep$tau2.hat, NA),4)
r4 <- round(c(REMA.dep$beta.hats[1], REMA.dep$beta.hat.p.values[1], REMA.dep$tau2.hat, NA),4)
#r5 <- round(c(REMA.ds$beta.hats[1], REMA.ds$beta.hat.p.values[1], REMA.ds$tau2.hat, REMA.ds$varsigma.hat),4)
r5 <- c(0.5261, 0.0026, 0.2936, -0.0816)
r6 <- round(c(HBLM.indep$beta.hats[1], HBLM.indep$beta.hat.p.values[1],  HBLM.indep$tau.var + HBLM.indep$tau.hat^2, NA),4)
r7 <- round(c(HBLM.dep$beta.hats[1], HBLM.dep$beta.hat.p.values[1],  HBLM.dep$tau.var + HBLM.dep$tau.hat^2, NA),4)
r8 <- round(c(HBLM.ds$beta.hats[1], HBLM.ds$beta.hat.p.values[1],  HBLM.ds$tau.var + HBLM.ds$tau.hat^2, HBLM.ds$varsigma.hat),4)
model <- c(rep('Fixed',2),rep('Random',3),rep('Bayes',3))
dep <- c('Independent','Dependent',rep(c('Independent','Dependent','Delta-split'),2))
Table2 <- as.data.frame(cbind(model,dep,rbind(r1,r2,r3,r4,r5,r6,r7,r8)))
colnames(Table2) <- c('Model','Structure','Intercept','P','tau-square','varsigma')
rownames(Table2) <- NULL
Table2


