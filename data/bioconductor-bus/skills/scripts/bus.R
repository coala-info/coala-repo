# Code example from 'bus' vignette. See references/ for full tutorial.

### R code from vignette source 'bus.rnw'

###################################################
### code chunk number 1: bus
###################################################
options(keep.source = TRUE, width = 60)
bus <- packageDescription("BUS")


###################################################
### code chunk number 2: association.genes
###################################################
library(BUS)
library(minet)
data(copasi)
mat=as.matrix(copasi)[1:5,]
rownames(mat)<-paste("G",1:nrow(mat), sep="")
BUS(EXP=mat,measure="MI",n.replica=400,net.trim="aracne",thresh=0.05,nflag=1)


###################################################
### code chunk number 3: association.genes.traits
###################################################
data(tumors.mRNA)
exp<- as.matrix(tumors.mRNA)[11:15,]
rownames(exp)<-rownames(tumors.mRNA)[11:15]
data(tumors.miRNA)
trait<- as.matrix(tumors.miRNA)[11:15,]
rownames(trait)<-rownames(tumors.miRNA)[11:15]
BUS(EXP=exp,trait=trait,measure="MI",nflag=2)


