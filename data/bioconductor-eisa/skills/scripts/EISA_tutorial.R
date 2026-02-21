# Code example from 'EISA_tutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'EISA_tutorial.Rnw'

###################################################
### code chunk number 1: set width
###################################################
options(width=60)
options(continue=" ")
try(X11.options(type="xlib"), silent=TRUE)


###################################################
### code chunk number 2: load the packages
###################################################
library(eisa)


###################################################
### code chunk number 3: load the data
###################################################
library(ALL)
library(hgu95av2.db)
data(ALL)


###################################################
### code chunk number 4: simple ISA
###################################################
thr.gene <- 2.7
thr.cond <- 1.4
set.seed(1) # to get the same results, always
# modules <- ISA(ALL, thr.gene=thr.gene, thr.cond=thr.cond)
data(ALLModulesSmall)
modules <- ALLModulesSmall


###################################################
### code chunk number 5: type in name of ISAModules object
###################################################
modules


###################################################
### code chunk number 6: accessors 1
###################################################
length(modules)
dim(modules)


###################################################
### code chunk number 7: accessors 2
###################################################
featureNames(modules)[1:5]
sampleNames(modules)[1:5]


###################################################
### code chunk number 8: number of features and samples
###################################################
getNoFeatures(modules)
getNoSamples(modules)
colnames(pData(modules))
getOrganism(modules)
annotation(modules)


###################################################
### code chunk number 9: indexing
###################################################
modules[[1:5]]


###################################################
### code chunk number 10: indexing 2
###################################################
chr <- get(paste(annotation(modules), sep="", "CHR"))
chr1features <- sapply(mget(featureNames(modules), chr), 
                 function(x) "1" %in% x)
modules[chr1features,]


###################################################
### code chunk number 11: indexing 3
###################################################
modules[ ,grep("^B", pData(modules)$BT)]


###################################################
### code chunk number 12: list genes in modules
###################################################
getFeatureNames(modules)[[1]]


###################################################
### code chunk number 13: list conditions in modules
###################################################
getSampleNames(modules)[[1]]


###################################################
### code chunk number 14: query scores
###################################################
getFeatureScores(modules, 3)
getSampleScores(modules, 3)


###################################################
### code chunk number 15: query all scores
###################################################
dim(getFeatureMatrix(modules))
dim(getSampleMatrix(modules))


###################################################
### code chunk number 16: seed data
###################################################
seedData(modules)


###################################################
### code chunk number 17: run data
###################################################
runData(modules)


###################################################
### code chunk number 18: GO enrichment
###################################################
GO <- ISAGO(modules)


###################################################
### code chunk number 19: list GO result
###################################################
GO


###################################################
### code chunk number 20: GO summary
###################################################
summary(GO$BP, p=0.001)[[1]][,-6]


###################################################
### code chunk number 21: GO gene ids by category
###################################################
geneIdsByCategory(GO$BP)[[1]][[3]]


###################################################
### code chunk number 22: GO info
###################################################
sigCategories(GO$BP)[[1]]
library(GO.db)
mget(na.omit(sigCategories(GO$BP)[[1]][1:3]), GOTERM)


###################################################
### code chunk number 23: coherence
###################################################
library(biclust)
Bc <- as(modules, "Biclust")
constantVariance(exprs(ALL), Bc, number=1)
additiveVariance(exprs(ALL), Bc, number=1)
multiplicativeVariance(exprs(ALL), Bc, number=1)
signVariance(exprs(ALL), Bc, number=1)


###################################################
### code chunk number 24: coherence all
###################################################
cv <- sapply(seq_len(Bc@Number), 
             function(x) constantVariance(exprs(ALL), Bc, number=x))
av <- sapply(seq_len(Bc@Number), 
             function(x) additiveVariance(exprs(ALL), Bc, number=x))
cor(av, cv)


###################################################
### code chunk number 25: robustness
###################################################
seedData(modules)$rob


###################################################
### code chunk number 26: filtering
###################################################
library(genefilter)
varLimit <- 0.5
kLimit <- 4
ALimit <- 5
flist <- filterfun(function(x) var(x)>varLimit, kOverA(kLimit,ALimit))
ALL.filt <- ALL[genefilter(ALL, flist), ]


###################################################
### code chunk number 27: Entrez
###################################################
ann <- annotation(ALL.filt)
library(paste(ann, sep=".", "db"), character.only=TRUE)
ENTREZ <- get( paste(ann, sep="", "ENTREZID") )
EntrezIds <- mget(featureNames(ALL.filt), ENTREZ)
keep <- sapply(EntrezIds, function(x) length(x) >= 1 && !is.na(x))
ALL.filt.2 <- ALL.filt[keep,]


###################################################
### code chunk number 28: Entrez unique
###################################################
vari <- apply(exprs(ALL.filt.2), 1, var)
larg <- findLargest(featureNames(ALL.filt.2), vari, data=annotation(ALL.filt.2))
ALL.filt.3 <- ALL.filt.2[larg,]


###################################################
### code chunk number 29: normed
###################################################
ALL.normed <- ISANormalize(ALL.filt.3)
ls(assayData(ALL.normed))
dim(featExprs(ALL.normed))
dim(sampExprs(ALL.normed))


###################################################
### code chunk number 30: seeds
###################################################
set.seed(3)
random.seeds <- generate.seeds(length=nrow(ALL.normed), count=100)


###################################################
### code chunk number 31: smart seeds
###################################################
type <- as.character(pData(ALL.normed)$BT)
ss1 <- ifelse(grepl("^B", type), -1, 1)
ss2 <- ifelse(grepl("^B1", type), 1, 0)
ss3 <- ifelse(grepl("^B2", type), 1, 0)
ss4 <- ifelse(grepl("^B3", type), 1, 0)
ss5 <- ifelse(grepl("^B4", type), 1, 0)
ss6 <- ifelse(grepl("^T1", type), 1, 0)
ss7 <- ifelse(grepl("^T2", type), 1, 0)
ss8 <- ifelse(grepl("^T3", type), 1, 0)
ss9 <- ifelse(grepl("^T4", type), 1, 0)
smart.seeds <- cbind(ss1, ss2, ss3, ss4, ss5, ss6, ss7, ss8, ss9)


###################################################
### code chunk number 32: iteration
###################################################
modules1 <- ISAIterate(ALL.normed, feature.seeds=random.seeds, 
                        thr.feat=1.5, thr.samp=1.8, convergence="cor")
modules2 <- ISAIterate(ALL.normed, sample.seeds=smart.seeds,
                        thr.feat=1.5, thr.samp=1.8, convergence="cor")


###################################################
### code chunk number 33: unique
###################################################
modules1.unique <- ISAUnique(ALL.normed, modules1)
modules2.unique <- ISAUnique(ALL.normed, modules2)
length(modules1.unique)
length(modules2.unique)


###################################################
### code chunk number 34: robust
###################################################
modules1.robust <- ISAFilterRobust(ALL.normed, modules1.unique)
modules2.robust <- ISAFilterRobust(ALL.normed, modules2.unique)
length(modules1.robust)
length(modules2.robust)


###################################################
### code chunk number 35: sessioninfo
###################################################
toLatex(sessionInfo())


