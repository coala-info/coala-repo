# Code example from 'reb' vignette. See references/ for full tutorial.

### R code from vignette source 'reb.Rnw'

###################################################
### code chunk number 1: reb.Rnw:55-57
###################################################
library(reb)
library(idiogram)


###################################################
### code chunk number 2: reb.Rnw:83-88
###################################################
data(mcr.eset)
data(idiogramExample)

ref.ix <- grep("MNC",colnames(mcr.eset@exprs))
mcr.sum <- summarizeByRegion(mcr.eset@exprs,vai.chr,ref=ref.ix)


###################################################
### code chunk number 3: reb.Rnw:102-104
###################################################
complex.ix <-grep("MCR",colnames(mcr.eset@exprs))
regmap(mcr.sum[,complex.ix],col=.rwb,scale=c(-3,3))


###################################################
### code chunk number 4: reb.Rnw:118-119
###################################################
mcr.cset <- smoothByRegion(mcr.eset@exprs,vai.chr,ref=ref.ix)


###################################################
### code chunk number 5: reb.Rnw:128-135
###################################################
data <- mcr.cset[,complex.ix]
data[abs(data) < 1.96] <- NA
op <- par(no.readonly=TRUE)
layout(rbind(c(1,2),c(3,4)))
for(i in c("2","5","11","6")) 
idiogram(data,vai.chr,method="i",col=.rwb,dlim=c(-4,4),chr=i)
par(op)


###################################################
### code chunk number 6: reb.Rnw:142-144
###################################################
idiogram(mcr.cset[,complex.ix],vai.chr,
method="m",chr=5,dlim=c(-5,5),type="l",lty=1)


