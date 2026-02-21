# Code example from 'covEB' vignette. See references/ for full tutorial.

### R code from vignette source 'covEB.Rnw'

###################################################
### code chunk number 1: covEB.Rnw:30-31
###################################################
options(width=60)


###################################################
### code chunk number 2: covEB.Rnw:39-47
###################################################
library(covEB)
 	sigma <- matrix(c(4,2,2,3), ncol=2)
	x <- rmvnorm(n=500, mean=c(1,2), sigma=sigma)
 
 	samplecov<-cov(x)


 	test<-EBsingle(samplecov,startlambda=0.4,n=500)


###################################################
### code chunk number 3: covEB.Rnw:51-60
###################################################

 	sigma <- matrix(c(4,2,0.5,0.5,2,3,0.5,0.5,0.5,0.5,3,2.5,0.5,0.5,2.5,4), ncol=4)
	x <- rmvnorm(n=500, mean=c(1,2,1.5,2.5), sigma=sigma)
 
 	samplecov<-cov(x)
	vnames<-paste("a",1:4,sep="")
	rownames(samplecov)<-vnames
	colnames(samplecov)<-vnames
	test2<-EBsingle(samplecov,groups=list(c("a1","a2"),c("a3","a4")),n=500)


###################################################
### code chunk number 4: covEB.Rnw:64-69
###################################################
library(curatedBladderData)

data(package="curatedBladderData")
data(GSE89_eset)
Edata<-exprs(GSE89_eset)


###################################################
### code chunk number 5: covEB.Rnw:74-80
###################################################
variances<-apply(Edata,1,var)
edata<-Edata[which(variances>quantile(variances,0.8)),]
covmat<-cov(t(edata))
cormat<-cov2cor(covmat)
#we are now able to use covmat as input into covEB:
out<-EBsingle(covmat,startlambda=0.5,n=40)


###################################################
### code chunk number 6: covEB.Rnw:84-87
###################################################
outmat<-out
outmat[abs(out)<0.5]<-0
outmat[abs(out)>=0.5]<-1


###################################################
### code chunk number 7: covEB.Rnw:90-99
###################################################
clusth<-clusters(graph.adjacency(outmat))
sel<-which(clusth$membership==6)
subgraphEB<-outmat[sel,sel]
subgraph<-cormat[sel,sel]
subgraph[subgraph<0.5]<-0
subgraph[subgraph>=0.5]<-1

diag(subgraph)<-0
diag(subgraphEB)<-0


###################################################
### code chunk number 8: covEB.Rnw:102-105 (eval = FALSE)
###################################################
## 
## plot(graph.adjacency(subgraph,mode="undirected"))
## plot(graph.adjacency(subgraphEB,mode="undirected"))


