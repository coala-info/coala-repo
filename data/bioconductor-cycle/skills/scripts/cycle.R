# Code example from 'cycle' vignette. See references/ for full tutorial.

### R code from vignette source 'cycle.Rnw'

###################################################
### code chunk number 1: cycle.Rnw:39-40
###################################################
  library(cycle) 


###################################################
### code chunk number 2: cycle.Rnw:43-44
###################################################
set.seed(1)


###################################################
### code chunk number 3: cycle.Rnw:53-55
###################################################
data(yeast)
  yeast <- yeast[1:200,]


###################################################
### code chunk number 4: cycle.Rnw:63-64
###################################################
yeast <- filter.NA(yeast, thres=0.25)


###################################################
### code chunk number 5: cycle.Rnw:73-74
###################################################
yeast <- fill.NA(yeast,mode="mean")


###################################################
### code chunk number 6: cycle.Rnw:85-86
###################################################
yeast <- standardise(yeast)


###################################################
### code chunk number 7: cycle.Rnw:100-105
###################################################
auto.corr <- 0
for (i in 2:dim(exprs(yeast))[[2]]){
 auto.corr[i] <- cor(exprs(yeast)[,i-1],exprs(yeast)[,i])
 }
auto.corr 


###################################################
### code chunk number 8: cycle.Rnw:125-126
###################################################
T.yeast <- 85  


###################################################
### code chunk number 9: cycle.Rnw:132-134
###################################################
times.yeast <-  pData(yeast)$time 
times.yeast


###################################################
### code chunk number 10: cycle.Rnw:145-146
###################################################
NN <- 100 


###################################################
### code chunk number 11: cycle.Rnw:155-156
###################################################
fdr.rr <- fdrfourier(eset=yeast,T=T.yeast,times=times.yeast,background.model="rr",N=NN,progress=FALSE)


###################################################
### code chunk number 12: cycle.Rnw:165-166
###################################################
fdr.ar1 <- fdrfourier(eset=yeast,T=T.yeast,times=times.yeast,background.model="ar1",N=NN,progress=FALSE)


###################################################
### code chunk number 13: cycle.Rnw:178-180
###################################################
sum(fdr.rr$fdr < 0.25) 
sum(fdr.ar1$fdr < 0.25)


###################################################
### code chunk number 14: cycle.Rnw:186-187
###################################################
fdr.ar1$fdr[which(fdr.ar1$fdr < 0.25)]


