# Code example from 'SPEM-package' vignette. See references/ for full tutorial.

### R code from vignette source 'SPEM-package.Rnw'

###################################################
### code chunk number 1: libPackage
###################################################
library("Biobase")


###################################################
### code chunk number 2: setPara
###################################################
toy_expression_data<-matrix(data=abs(rnorm(12)),nrow=3,ncol=4,
	dimnames=list(paste("G",c(1:3),sep=''),
	paste("tp",c(0,2,4,6),sep="_")))


###################################################
### code chunk number 3: setPara
###################################################
toy_timepoints_data<-data.frame(index=c(1:4),
	label=paste("tp",c(0,2,4,6),sep='_'),
	time=c(0,2,4,6),row.names=paste("tp",c(0,2,4,6),sep='_'))


###################################################
### code chunk number 4: setPara
###################################################
toy_varMetadata<-data.frame(labelDescription=c("Index number","Label Detail",
	"Time points values"),row.names=c("index","label","time"))
toy_varMetadata


###################################################
### code chunk number 5: setPara
###################################################
toy_phenoData<-new("AnnotatedDataFrame",
	data=toy_timepoints_data,varMetadata=toy_varMetadata)


###################################################
### code chunk number 6: setPara
###################################################
toy_ExpressionSet<-new("ExpressionSet",
	exprs=toy_expression_data,phenoData=toy_phenoData)


###################################################
### code chunk number 7: libPackage
###################################################
library(SPEM)
library(Rsolnp)
library(Biobase)


###################################################
### code chunk number 8: loadData
###################################################
data(sos) 


###################################################
### code chunk number 9: setPara
###################################################
n<- 1
sparsity<- 0.2
lbH<- -3
ubH<- 3
lbB<- 0
ubB<- 10


###################################################
### code chunk number 10: setPara
###################################################
Slope<- s_diff(sos)
S<-Slope[1,]
sparsity<- 0.2
lbH<- -3
ubH<- 3
lbB<- 0
ubB<- 10
beta<-runif(n=1,min=lbB,max=ubB)


