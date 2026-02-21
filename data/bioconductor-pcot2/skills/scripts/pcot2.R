# Code example from 'pcot2' vignette. See references/ for full tutorial.

### R code from vignette source 'pcot2.Rnw'

###################################################
### code chunk number 1: pcot2.Rnw:46-50
###################################################
library(pcot2)
library(multtest)
library(hu6800.db)  
set.seed(1234567)


###################################################
### code chunk number 2: pcot2.Rnw:63-66
###################################################
data(golub)
rownames(golub) <- golub.gnames[,3]
colnames(golub) <- golub.cl


###################################################
### code chunk number 3: pcot2.Rnw:72-73
###################################################
golub.cl


###################################################
### code chunk number 4: pcot2.Rnw:90-94
###################################################
KEGG.list <- as.list(hu6800PATH)
imat <- getImat(golub, KEGG.list, ms=10) 
colnames(imat) <- paste("KEGG", colnames(imat), sep="")
dim(imat)


###################################################
### code chunk number 5: pcot2.Rnw:102-103
###################################################
results <- pcot2(golub, golub.cl, imat, iter=10)


###################################################
### code chunk number 6: pcot2.Rnw:117-119
###################################################
results$res.sig
results$res.all


###################################################
### code chunk number 7: pcot2.Rnw:174-186
###################################################
sel <- c("04620","04120")
pvalue <- c(0.001, 0.72)
library(KEGG.db)
pname <- unlist(mget(sel, env=KEGGPATHID2NAME))
main <- paste("KEGG", sel, ": ", pname, ": ", "P=", pvalue, sep="")
for(i in 1:length(sel)){
fname <- paste("corplot2-KEGG",sel[i] , ".jpg", sep="")
jpeg(fname, width=1600, height=1200, quality=100)
selgene <- rownames(imat)[imat[,match(paste("KEGG",sel,sep="")[i],colnames(imat))]==1]
corplot2(golub, selgene, golub.cl, main=main[i])
dev.off()
}


###################################################
### code chunk number 8: pcot2.Rnw:233-245
###################################################
pathlist <- as.list(hu6800PATH)
pathlist <- pathlist[match(rownames(golub), names(pathlist))]
ids <- unlist(mget(names(pathlist), env=hu6800SYMBOL))
#### transform data matrix only ####
newdata <- aveProbe(x=golub, ids=ids)$newx
#### transform both data and imat ####
output <- aveProbe(x=golub, imat=imat, ids=ids)
newdata <- output$newx
newimat <- output$newimat
newimat <- newimat[,apply(newimat, 2, sum)>=10]
dim(newdata)
dim(newimat)


