# Code example from 'clusterStab' vignette. See references/ for full tutorial.

### R code from vignette source 'clusterStab.Rnw'

###################################################
### code chunk number 1: clusterStab.Rnw:105-114
###################################################
library(clusterStab)
library(genefilter)
library(fibroEset)
data(fibroEset)
exprs(fibroEset) <- log2(exprs(fibroEset))
filt <- cv(0.1, Inf)
index <- genefilter(fibroEset, filt)
fb <- fibroEset[index,]
bh <- benhur(fb, 0.7, 6, seednum = 12345) #seednum only used to ensure reproducibility


###################################################
### code chunk number 2: clusterStab.Rnw:129-130
###################################################
hist(bh)


###################################################
### code chunk number 3: clusterStab.Rnw:145-146
###################################################
plot(hclust(dist(t(exprs(fibroEset[index,])))), labels = pData(fibroEset)[,2], sub="", xlab="")


###################################################
### code chunk number 4: clusterStab.Rnw:162-164
###################################################
plot(hclust(dist(t(exprs(fibroEset[index,])))), labels = pData(fibroEset)[,2], sub="", xlab="")
ecdf(bh)


###################################################
### code chunk number 5: clusterStab.Rnw:176-178
###################################################
cmp <- clusterComp(fb, 2)
cmp


