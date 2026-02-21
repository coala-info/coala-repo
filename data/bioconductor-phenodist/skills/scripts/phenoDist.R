# Code example from 'phenoDist' vignette. See references/ for full tutorial.

### R code from vignette source 'phenoDist.Rnw'

###################################################
### code chunk number 1: init
###################################################
display <- function(...) {invisible()}


###################################################
### code chunk number 2: library
###################################################
library('imageHTS')


###################################################
### code chunk number 3: imageHTSSetup
###################################################
localPath <- file.path(tempdir(), 'kimorph')
serverURL <- 'http://www.ebi.ac.uk/huber-srv/cellmorph/kimorph/'
x <- parseImageConf('conf/imageconf.txt', localPath=localPath, serverURL=serverURL)
x <- configure(x, 'conf/description.txt', 'conf/plateconf.txt', 'conf/screenlog.txt')
x <- annotate(x, 'conf/annotation.txt')


###################################################
### code chunk number 4: imageHTSAnalysis (eval = FALSE)
###################################################
## unames <- setdiff(getUnames(x), getUnames(x, content='empty'))
## segmentWells(x, uname=uname, segmentationPar='conf/segmentationpar.txt')
## extractFeatures(x, uname, 'conf/featurepar.txt')


###################################################
### code chunk number 5: library
###################################################
library('phenoDist')


###################################################
### code chunk number 6: PDM (eval = FALSE)
###################################################
## profiles <- summarizeWells(x, unames, 'conf/featurepar.txt')
## load(system.file('kimorph', 'selectedFtrs.rda', package='phenoDist'))
## pcaPDM <- PDMByWellAvg(profiles, selectedWellFtrs=selectedWellFtrs, transformMethod='PCA',
## distMethod='euclidean', nPCA=30)
## svmAccPDM <- PDMBySvmAccuracy(x, unames, selectedCellFtrs=selectedCellFtrs, cross=5, cost=1,
## gamma=2^-5, kernel='radial')


###################################################
### code chunk number 7: loadSvmAccPDM_Pl1
###################################################
load(system.file('kimorph', 'svmAccPDM_Pl1.rda', package='phenoDist'))
dim(svmAccPDM_Pl1)
svmAccPDM_Pl1[1:5,1:5]


###################################################
### code chunk number 8: repDistRank
###################################################
ranking <- repDistRank(x, distMatrix=svmAccPDM_Pl1)
summary(ranking)


###################################################
### code chunk number 9: distToNeg
###################################################
pheno <- distToNeg(x, distMatrix=svmAccPDM_Pl1, neg='rluc')
df <- data.frame(pheno=pheno,gene=getWellFeatures(x, uname=rownames(svmAccPDM_Pl1),
feature='GeneID'))
df <- df[order(pheno, decreasing=T),]
head(df)


###################################################
### code chunk number 10: repCorr
###################################################
repCorr(x, pheno)


###################################################
### code chunk number 11: ctlSeparation
###################################################
ctlSeparatn(x, pheno, neg='rluc', pos='ubc', method='robust')


###################################################
### code chunk number 12: clustering
###################################################
phenoCluster <- clusterDist(x, distMatrix=svmAccPDM_Pl1, clusterFun='hclust', method='ward')


###################################################
### code chunk number 13: enrichment (eval = FALSE)
###################################################
## library('GOstats')
## GOEnrich <- enrichAnalysis(x, cl=cutree(phenoCluster, k=5), terms='GO', annotation='org.Hs.eg.db',
## pvalueCutoff=0.01, testDirection='over', ontology='BP', conditional=TRUE)


###################################################
### code chunk number 14: sessionInfo
###################################################
toLatex(sessionInfo())


