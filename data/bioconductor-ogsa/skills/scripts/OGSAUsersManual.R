# Code example from 'OGSAUsersManual' vignette. See references/ for full tutorial.

### R code from vignette source 'OGSAUsersManual.Rnw'

###################################################
### code chunk number 1: Load format setup
###################################################
library('OGSA')
data('ExampleData')
data('KEGG_BC_GS')


phenotype <- pheno  
names(phenotype) <- colnames(cnv)

tailLRL <- c('left','right','left')   
tailRLR <- c('right','left','right') 
offsets <- c(1.0, 0.1, 0.5)

dataSet <- list(expr,meth,cnv)




###################################################
### code chunk number 2: Process Gene Sets
###################################################

tibLRL <- copaInt(dataSet,phenotype,tails=tailLRL)
gsTibLRL <- testGScogps(tibLRL,pathGS)
tibLRLcorr <- copaInt(dataSet,phenotype,tails=tailLRL,corr=TRUE)
gsTibLRLcorr <- testGScogps(tibLRLcorr,pathGS)

tibRLR <- copaInt(dataSet,phenotype,tails=tailRLR)
tibRLRcorr <- copaInt(dataSet,phenotype,tails=tailRLR,corr=TRUE)
gsTibRLR <- testGScogps(tibRLR,pathGS)
gsTibRLRcorr <- testGScogps(tibRLRcorr,pathGS)

rankLRL <- copaInt(dataSet,phenotype,tails=tailLRL,method='Rank')
rankLRLcorr <- copaInt(dataSet,phenotype,tails=tailLRL,method='Rank',corr=TRUE,
                       offsets=offsets)
gsRankLRL <- testGScogps(rankLRL,pathGS)
gsRankLRLcorr <- testGScogps(rankLRLcorr,pathGS)

rankRLR <- copaInt(dataSet,phenotype,tails=tailRLR,method='Rank')
rankRLRcorr <- copaInt(dataSet,phenotype,tails=tailRLR,method='Rank',corr=TRUE,
                       offsets=offsets)
gsRankRLR <- testGScogps(rankRLR,pathGS)
gsRankRLRcorr <- testGScogps(rankRLRcorr,pathGS)


###################################################
### code chunk number 3: Process Outlier Maps
###################################################

outRankLRLcorr <- outCallRank(dataSet, phenotype, names=c('Expr','Meth','CNV'),tail=tailLRL,
                              corr=TRUE,offsets=offsets)
outRankRLRcorr <- outCallRank(dataSet, phenotype, names=c('Expr','Meth','CNV'),tail=tailRLR,
                              corr=TRUE,offsets=offsets)
print("Corrected Rank Outliers Calculated")

outTibLRL <- outCallTib(dataSet, phenotype, names=c('Expr','Meth','CNV'),tail=tailLRL)
outTibRLR <- outCallTib(dataSet, phenotype, names=c('Expr','Meth','CNV'),tail=tailRLR)
print("Tibshirani-Hastie Outliers Calculated")

pdgfB <- pathGS$'BIOCARTA_PDGF_PATHWAY'
map1 <- outMap(outTibLRL,pdgfB,hmName='BC_PDGF_TIB.pdf',
               plotName='PDGF Outlier T-H LRL Calls')

ecmK <- pathGS$'KEGG_ECM_RECEPTOR_INTERACTION'
map4 <- outMap(outRankRLRcorr,ecmK,hmName='KEGG_ECM_RANKcorr.pdf',
               plotName='ECM Outlier Corr Rank RLR Calls')



