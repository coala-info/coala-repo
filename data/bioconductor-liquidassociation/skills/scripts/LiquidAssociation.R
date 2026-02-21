# Code example from 'LiquidAssociation' vignette. See references/ for full tutorial.

### R code from vignette source 'LiquidAssociation.Rnw'

###################################################
### code chunk number 1: loadData
###################################################
library(LiquidAssociation)
library(yeastCC)
library(org.Sc.sgd.db)
data(spYCCES)
lae <- spYCCES[,-(1:4)]
### get rid of the NA elements
lae <- lae[apply(is.na(exprs(lae)),1,sum) < ncol(lae)*0.3,]
probname<-rownames(exprs(lae))
genes <- c("HTS1","ATP1","CYT1")
geneMap <- unlist(mget(genes,revmap(org.Sc.sgdGENENAME),ifnotfound=NA))
whgene<-match(geneMap,probname)


###################################################
### code chunk number 2: Preprocessing
###################################################
data<-t(exprs(lae[whgene,]))
eSetdata<-lae[whgene,]
data<-data[!is.na(data[,1]) & !is.na(data[,2]) & !is.na(data[,3]),]
colnames(data)<-genes
str(data)


###################################################
### code chunk number 3: GLAplot
###################################################
plotGLA(data, cut=3, dim=3, pch=16, filen="GLAplot", save=TRUE)


###################################################
### code chunk number 4: Calculate GLA
###################################################
LAest<-LA(data)
GLAest<-rep(0,3)
for ( dim in 1:3){
	GLAest[dim]<-GLA(data, cut=4, dim=dim)		
}
LAest
GLAest


###################################################
### code chunk number 5: ExpressionSet
###################################################
eSetGLA<-GLA(eSetdata, cut=4, dim=3, geneMap=geneMap)
eSetGLA


###################################################
### code chunk number 6: CNM model
###################################################
FitCNM.full<-CNM.full(data)
FitCNM.full


###################################################
### code chunk number 7: Calculate sGLA
###################################################
sGLAest<-getsGLA(data, boots=20, perm=50, cut=4, dim=3)
sGLAest
sLAest<-getsLA(data,boots=20, perm=50)
sLAest


###################################################
### code chunk number 8: Extend Example filter small variance
###################################################
lae<-t(exprs(lae))
V<-apply(lae, 2, var, na.rm=TRUE)
ibig<-V > 0.5
sum(ibig)
big<-which(ibig)
bigtriplet<-lae[,big]
dim(bigtriplet)


###################################################
### code chunk number 9: Annotation
###################################################
x <- org.Sc.sgdGENENAME
mappedgenes <- mappedkeys(x)
xx <- as.list(x[mappedgenes])
mapid<-names(xx)
orfid<-colnames(bigtriplet)
genename1<-xx[match(orfid, mapid)]
imap<-which(sapply(genename1, length) !=1)
bigtriplet<-bigtriplet[,-imap]
colnames(bigtriplet)<-genename1[-imap]


###################################################
### code chunk number 10: Calculate GLA for all triplets
###################################################
num<-choose(ncol(bigtriplet),3)
pick<-t(combn(1:ncol(bigtriplet),3))
GLAout<-matrix(0, nrow=100, 3)
for ( i in 1:100){
	dat1<-bigtriplet[,pick[i,]]
	for ( dim in 1:3 ){
		GLAout[i,dim]<-GLA(dat1, cut=4, dim=dim)
	}
}


###################################################
### code chunk number 11: Find large GLA
###################################################
GLAmax<-apply(abs(GLAout),1, max)
imax<-which(GLAmax > 0.20)
pickmax<-pick[imax,]
GLAmax<-GLAout[imax,]
trip.order<-t(apply(t(abs(GLAmax)), 2, order, decreasing=TRUE))


###################################################
### code chunk number 12: HypothesisTesting
###################################################
whtrip<-1
data<-bigtriplet[,pickmax[whtrip,]]
data<-data[,trip.order[whtrip,]]
data<-data[!is.na(data[,1]) & !is.na(data[,2]) & !is.na(data[,3]),]
data<-apply(data,2,qqnorm2)
data<-apply(data,2, stand)
FitCNM1<-CNM.full(data)
FitCNM1
sGLA1<-getsGLA(data, boots=20, perm=50, cut=4, dim=3)
sGLA1



