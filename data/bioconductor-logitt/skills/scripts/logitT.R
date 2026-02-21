# Code example from 'logitT' vignette. See references/ for full tutorial.

### R code from vignette source 'logitT.Rnw'

###################################################
### code chunk number 1: logitT.Rnw:76-77
###################################################
library(logitT)


###################################################
### code chunk number 2: logitT.Rnw:90-94
###################################################
library(SpikeInSubset)
data(spikein95)  ## get the example data
groupvector<-c("A","A","A","B","B","B")  ## specify group affiliations
logitTex<-logitTAffy(spikein95, group=groupvector) 


###################################################
### code chunk number 3: logitT.Rnw:99-100
###################################################
logitTex[1:10]


###################################################
### code chunk number 4: logitT.Rnw:110-111
###################################################
groupvector<-c("A","A","A","B","B","B")


###################################################
### code chunk number 5: logitT.Rnw:120-123
###################################################
pvals <- (1-pt(abs(logitTex),df=4))*2              ## calculate p-values
signifgenes<-names(logitTex)[pvals<0.01]           ## find probe sets with p-values smaller than 0.01
signifgenes


