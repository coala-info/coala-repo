# Code example from 'fastLiquidAssociation' vignette. See references/ for full tutorial.

### R code from vignette source 'fastLiquidAssociation.Rnw'

###################################################
### code chunk number 1: SuppressLoadData
###################################################
suppressPackageStartupMessages(library(WGCNA))
library(impute)
library(preprocessCore)
library(LiquidAssociation)
library(parallel)
library(doParallel)


###################################################
### code chunk number 2: loadData
###################################################
library(fastLiquidAssociation)
suppressMessages(library(yeastCC))
suppressMessages(library(org.Sc.sgd.db))
data(spYCCES)
lae <- spYCCES[,-(1:4)]
### get rid of samples with high % NA elements
lae <- lae[apply(is.na(exprs(lae)),1,sum) < ncol(lae)*0.3,]
data <- t(exprs(lae))
data <- data[,1:50]
dim(data)


###################################################
### code chunk number 3: calculate top MLA
###################################################
detectCores() 
example <- fastMLA(data=data,topn=50,nvec=1:5,rvalue=0.5,cut=4,threads=detectCores())
example[1:5,]


###################################################
### code chunk number 4: stopCluster1
###################################################
stopImplicitCluster()
# closeAllConnections()


###################################################
### code chunk number 5: Calculate CNM
###################################################
 
#from our example with fastMLA
CNMcalc <- mass.CNM(data=data,GLA.mat=example,nback=5)
CNMcalc


###################################################
### code chunk number 6: Calculate CNM boots
###################################################
 
fulldata <- t(exprs(lae))
load(system.file('data','testmat.RData',package='fastLiquidAssociation'))
notsense <- testmat
CNMother <- mass.CNM(data=fulldata,GLA.mat=notsense,nback=5)
CNMother


###################################################
### code chunk number 7: Time comparison
###################################################
 
#determine number of processors for multicore systems
clust <- makeCluster(detectCores())
registerDoParallel(clust)
boottrips <- CNMother[[2]]
dim(boottrips)


###################################################
### code chunk number 8: Speed Test
###################################################
 
#We take the results for the single triplet and put it in matrix format 
example.boots <- boottrips[1, , drop = FALSE]
dim(example.boots)
set.seed(1)
system.time(GLAnew <- fastboots.GLA(tripmat=example.boots,data=fulldata, 
clust=clust, boots=30, perm=500, cut=4))
GLAnew

#the matrix conversion is not needed for the 2 line result
set.seed(1)
system.time(GLAtwo <- fastboots.GLA(tripmat=boottrips,data=fulldata, 
clust=clust, boots=30, perm=500, cut=4))
GLAtwo

#close the cluster
stopCluster(clust)


###################################################
### code chunk number 9: Extend Example
###################################################
library(GOstats)
library("org.Sc.sgd.db")
##X3 genes
topX3 <- unique(example[,3])
hyp.cutoff <- 0.05
####
params <- new("GOHyperGParams", geneIds=topX3,universeGeneIds=colnames(data),
annotation="org.Sc.sgd.db",ontology="BP",pvalueCutoff=hyp.cutoff,conditional=TRUE,
testDirection="over")
GOout <- hyperGTest(params)
summary(GOout,categorySize=5)


###################################################
### code chunk number 10: Obtain gene list
###################################################
###extracts GO list elements of summary(hyperGtestobj)<cutoff
###converts ORFids to Gene names and returns under GO list element
##for ontology BP
GOids <- summary(GOout,categorySize=5)$GOBPID
check <- GOout@goDag@nodeData@data
subset <- check[GOids]
terms <- summary(GOout,categorySize=5)$Term
test <- sapply(subset,function(m) m[1])
orflist <- lapply(test,function(x) intersect(x,topX3))
##creates mapping of ORFids to gene names
x <- org.Sc.sgdGENENAME
mappedgenes <- mappedkeys(x)
xx <- as.list(x[mappedgenes])
mapid <- names(xx)
##creates list of GO ids
genename1 <- lapply(orflist,function(x) xx[match(x,mapid)])
###
### if reduced num of terms desired run for statement below ##
# for(i in 1:length(genename1)){
# if (length(genename1[[i]])>10) genename1[[i]] <- genename1[[i]][1:10]
# }
## for full list use below
genelist <- lapply(genename1,function(x) paste(x,collapse=", "))
ugenes <- unlist(genelist)
names <- sapply(names(ugenes), function(x) unlist(strsplit(x, split='.', fixed=TRUE))[1])
umat <- matrix(ugenes)
umat <- cbind(terms,umat)
rownames(umat) <- names
colnames(umat) <- c("GO description","Associated genes")
umat


###################################################
### code chunk number 11: Session info
###################################################
sessionInfo()


