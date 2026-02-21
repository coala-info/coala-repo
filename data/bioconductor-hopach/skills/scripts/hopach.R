# Code example from 'hopach' vignette. See references/ for full tutorial.

### R code from vignette source 'hopach.Rnw'

###################################################
### code chunk number 1: golub
###################################################
library(hopach)
data(golub)


###################################################
### code chunk number 2: geneSelection
###################################################
vars<-apply(golub,1,var)
subset<-vars>quantile(vars,(nrow(golub)-200)/nrow(golub))
golub.subset<-golub[subset,]
dim(golub.subset)
gnames.subset<-golub.gnames[subset,]


###################################################
### code chunk number 3: distance
###################################################
gene.dist<-distancematrix(golub.subset,"cosangle")
dim(gene.dist)


###################################################
### code chunk number 4: hopachGene
###################################################
gene.hobj<-hopach(golub.subset,dmat=gene.dist)
gene.hobj$clust$k  
table(gene.hobj$clust$labels) 
gene.hobj$clust$sizes 


###################################################
### code chunk number 5: dplot (eval = FALSE)
###################################################
## dplot(gene.dist,gene.hobj,ord="final",main="Golub AML/ALL Data (1999): Gene Distance Matrix",showclusters=FALSE)  


###################################################
### code chunk number 6: bootstrap
###################################################
bobj<-boothopach(golub.subset,gene.hobj,B=100)


###################################################
### code chunk number 7: bootplot (eval = FALSE)
###################################################
## bootplot(bobj,gene.hobj,ord="bootp",main="Golub AML/ALL Data (1999)",showclusters=FALSE)


###################################################
### code chunk number 8: classes (eval = FALSE)
###################################################
## table(golub.cl)


###################################################
### code chunk number 9: hopachArray
###################################################
array.hobj<-hopach(t(golub.subset),d="euclid")
array.hobj$clust$k


###################################################
### code chunk number 10: output (eval = FALSE)
###################################################
## makeoutput(golub.subset,gene.hobj,bobj,file="Golub.out",gene.names=gnames.subset[,3])


###################################################
### code chunk number 11: fuzzy (eval = FALSE)
###################################################
## boot2fuzzy(golub.subset,bobj,gene.hobj,array.hobj,file="GolubFuzzy",gene.names=gnames.subset[,3]) 


###################################################
### code chunk number 12: hierarchical (eval = FALSE)
###################################################
## hopach2tree(golub.subset,file="GolubTree",hopach.genes=gene.hobj,hopach.arrays=NULL,dist.genes=gene.dist,gene.names=gnames.subset[,3])  


