# Code example from 'gagamanual' vignette. See references/ for full tutorial.

### R code from vignette source 'gagamanual.Rnw'

###################################################
### code chunk number 1: one
###################################################
library(gaga)
set.seed(10)
n <- 100; m <- c(6,6)
a0 <- 25.5; nu <- 0.109
balpha <- 1.183; nualpha <- 1683
probpat <- c(.95,.05)
xsim <- simGG(n,m=m,p.de=probpat[2],a0,nu,balpha,nualpha,equalcv=TRUE)


###################################################
### code chunk number 2: two
###################################################
xsim
featureData(xsim)
phenoData(xsim)
a <- fData(xsim)[,c("alpha.1","alpha.2")]
l <- fData(xsim)[,c("mean.1","mean.2")]
x <- exprs(xsim)


###################################################
### code chunk number 3: fig1aplot
###################################################
plot(density(x),xlab='Expression levels',main='')


###################################################
### code chunk number 4: fig1bplot
###################################################
plot(l[,1],1/sqrt(a[,1]),xlab='Group 1 Mean',ylab='Group 1 CV')


###################################################
### code chunk number 5: fig1a
###################################################
plot(density(x),xlab='Expression levels',main='')


###################################################
### code chunk number 6: fig1b
###################################################
plot(l[,1],1/sqrt(a[,1]),xlab='Group 1 Mean',ylab='Group 1 CV')


###################################################
### code chunk number 7: three
###################################################
groups <- pData(xsim)$group[c(-6,-12)]
groups
patterns <- matrix(c(0,0,0,1),2,2)
colnames(patterns) <- c('group 1','group 2')
patterns


###################################################
### code chunk number 8: threebis
###################################################
patterns <- matrix(c(0,0,0,0,1,1,0,0,1,0,1,2),ncol=3,byrow=TRUE)
colnames(patterns) <- c('CONTROL','CANCER A','CANCER B')
patterns


###################################################
### code chunk number 9: four
###################################################
patterns <- matrix(c(0,0,0,1),2,2)
colnames(patterns) <- c('group 1','group 2')
gg1 <- fitGG(x[,c(-6,-12)],groups,patterns=patterns,nclust=1,method='Gibbs',B=1000,trace=FALSE)
gg2 <- fitGG(x[,c(-6,-12)],groups,patterns=patterns,method='EM',trace=FALSE)  
gg3 <- fitGG(x[,c(-6,-12)],groups,patterns=patterns,method='quickEM',trace=FALSE)  


###################################################
### code chunk number 10: five
###################################################
gg1 <- parest(gg1,x=x[,c(-6,-12)],groups,burnin=100,alpha=.05)
gg2 <- parest(gg2,x=x[,c(-6,-12)],groups,alpha=.05)
gg3 <- parest(gg3,x=x[,c(-6,-12)],groups,alpha=.05)
gg1
gg1$ci
gg2
gg3


###################################################
### code chunk number 11: seven
###################################################
dim(gg1$pp)
gg1$pp[1,]
gg2$pp[1,]


###################################################
### code chunk number 12: fig4aplot
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='data',main='')


###################################################
### code chunk number 13: fig4bplot
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='shape',main='')


###################################################
### code chunk number 14: fig4cplot
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='mean',main='')


###################################################
### code chunk number 15: fig4dplot
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='shapemean',main='',xlab='Mean',ylab='1/sqrt(CV)')


###################################################
### code chunk number 16: fig4a
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='data',main='')


###################################################
### code chunk number 17: fig4b
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='shape',main='')


###################################################
### code chunk number 18: fig4c
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='mean',main='')


###################################################
### code chunk number 19: fig4d
###################################################
checkfit(gg1,x=x[,c(-6,-12)],groups,type='shapemean',main='',xlab='Mean',ylab='1/sqrt(CV)')


###################################################
### code chunk number 20: eight
###################################################
d1 <- findgenes(gg1,x[,c(-6,-12)],groups,fdrmax=.05,parametric=TRUE)
d1.nonpar <- findgenes(gg1,x[,c(-6,-12)],groups,fdrmax=.05,parametric=FALSE,B=1000)
dtrue <- (l[,1]!=l[,2])
table(d1$d,dtrue)
table(d1.nonpar$d,dtrue)


###################################################
### code chunk number 21: fig5plot
###################################################
plot(d1.nonpar$fdrest,type='l',xlab='Bayesian FDR',ylab='Estimated frequentist FDR')


###################################################
### code chunk number 22: fig1
###################################################
plot(d1.nonpar$fdrest,type='l',xlab='Bayesian FDR',ylab='Estimated frequentist FDR')


###################################################
### code chunk number 23: eightbis
###################################################
d2 <- findgenes(gg2,x[,c(-6,-12)],groups,fdrmax=.05,parametric=TRUE)
d3 <- findgenes(gg3,x[,c(-6,-12)],groups,fdrmax=.05,parametric=TRUE)
table(d1$d,d2$d)
table(d1$d,d3$d)


###################################################
### code chunk number 24: fc1
###################################################
mpos <- posmeansGG(gg1,x=x[,c(-6,-12)],groups=groups,underpattern=1)
fc <- mpos[,1]-mpos[,2]
fc[1:5]


###################################################
### code chunk number 25: nine
###################################################
pred1 <- classpred(gg1,xnew=x[,6],x=x[,c(-6,-12)],groups,ngene=50,prgroups=c(.5,.5))
pred2 <- classpred(gg1,xnew=x[,12],x=x[,c(-6,-12)],groups,ngene=50,prgroups=c(.5,.5))
pred1
pred2


###################################################
### code chunk number 26: simulatefs
###################################################
set.seed(1)
x <- simGG(n=20,m=2,p.de=.5,a0=3,nu=.5,balpha=.5,nualpha=25)
gg1 <- fitGG(x,groups=1:2,method='EM')
gg1 <- parest(gg1,x=x,groups=1:2)


###################################################
### code chunk number 27: powfindgenes
###################################################
pow1 <- powfindgenes(gg1, x=x, groups=1:2, batchSize=1, fdrmax=0.05, B=1000)
pow2 <- powfindgenes(gg1, x=x, groups=1:2, batchSize=2, fdrmax=0.05, B=1000)
pow3 <- powfindgenes(gg1, x=x, groups=1:2, batchSize=3, fdrmax=0.05, B=1000)
pow1$m
pow2$m
pow3$m


###################################################
### code chunk number 28: forwsim
###################################################
fs1 <- forwsimDiffExpr(gg1, x=x, groups=1:2,
maxBatch=3,batchSize=1,fdrmax=0.05, B=100, Bsummary=100, randomSeed=1)
head(fs1)


###################################################
### code chunk number 29: fixedn
###################################################
tp <- tapply(fs1$u,fs1$time,'mean')
tp
samplingCost <- 0.01
util <- tp - samplingCost*(0:3)
util


###################################################
### code chunk number 30: seqn
###################################################
b0seq <- seq(0,20,length=200); b1seq <- seq(0,40,length=200)
bopt <-seqBoundariesGrid(b0=b0seq,b1=b1seq,forwsim=fs1,samplingCost=samplingCost,powmin=0)
names(bopt)
bopt$opt
head(bopt$grid)


###################################################
### code chunk number 31: figforwsim
###################################################
plot(fs1$time,fs1$summary,xlab='Additional batches',ylab='E(newly discovered DE genes)')
abline(bopt$opt['b0'],bopt$opt['b1'])
text(.2,bopt$opt['b0'],'Continue',pos=3)
text(.2,bopt$opt['b0'],'Stop',pos=1)


###################################################
### code chunk number 32: figforwsim
###################################################
plot(fs1$time,fs1$summary,xlab='Additional batches',ylab='E(newly discovered DE genes)')
abline(bopt$opt['b0'],bopt$opt['b1'])
text(.2,bopt$opt['b0'],'Continue',pos=3)
text(.2,bopt$opt['b0'],'Stop',pos=1)


