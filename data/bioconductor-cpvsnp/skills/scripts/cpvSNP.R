# Code example from 'cpvSNP' vignette. See references/ for full tutorial.

### R code from vignette source 'cpvSNP.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: loadLibrariesAndData
###################################################
library(cpvSNP)
data(geneSetAnalysis)
names(geneSetAnalysis)


###################################################
### code chunk number 3: createArrayData
###################################################
arrayDataGR <- createArrayData(geneSetAnalysis[["arrayData"]], 
    positionName="Position")
class(arrayDataGR)


###################################################
### code chunk number 4: geneSets
###################################################
geneSets <- geneSetAnalysis[["geneSets"]]
geneSets
length(geneSets)
head(geneIds(geneSets[[1]]))
details(geneSets[[1]])
head(geneIds(geneSets[[2]]))


###################################################
### code chunk number 5: geneToSNPList
###################################################
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
genesHg19 <- genes(txdb)

snpsGSC <- geneToSNPList(geneSets, arrayDataGR, genesHg19)
class(snpsGSC)


###################################################
### code chunk number 6: readyToRun
###################################################
arrayDataGR
snpsGSC


###################################################
### code chunk number 7: indep
###################################################
indep <- geneSetAnalysis[["indepSNPs"]]
head(indep)
dim(indep)


###################################################
### code chunk number 8: createIndepP
###################################################
pvals <- arrayDataGR$P[is.element(arrayDataGR$SNP, indep$V1)]
names(pvals) <- arrayDataGR$SNP[is.element(arrayDataGR$SNP, indep$V1)]
head(pvals)


###################################################
### code chunk number 9: glossi
###################################################
gRes <- glossi(pvals, snpsGSC)
gRes

gRes2 <- glossi(pvals, snpsGSC[[1]])
gRes2

pValue(gRes)
degreesOfFreedom(gRes)
statistic(gRes)


###################################################
### code chunk number 10: publishMultiple (eval = FALSE)
###################################################
## pvals <- p.adjust( unlist( pValue(gRes) ), method= "BH" )
## library(ReportingTools)
## report <- HTMLReport (shortName = "cpvSNP_glossiResult",
##         title = "GLOSSI Results", reportDirectory = "./reports")
## publish(geneSets, report, annotation.db = "org.Hs.eg",
##         setStats = unlist(statistic (gRes)), 
##         setPValues = pvals)
## finish(report)


###################################################
### code chunk number 11: hapmap (eval = FALSE)
###################################################
## download.file(
##     url="http://hapmap.ncbi.nlm.nih.gov/genotypes/hapmap3_r3/plink_format/hapmap3_r3_b36_fwd.consensus.qc.poly.ped.gz",
##     destfile="hapmap3_r3_b36_fwd.consensus.qc.poly.ped.gz")
## download.file(
##     url="http://hapmap.ncbi.nlm.nih.gov/genotypes/hapmap3_r3/plink_format/hapmap3_r3_b36_fwd.consensus.qc.poly.map.gz",
##     destfile="hapmap3_r3_b36_fwd.consensus.qc.poly.map.gz")
## system("gunzip hapmap3_r3_b36_fwd.consensus.qc.poly.ped.gz")
## system("gunzip hapmap3_r3_b36_fwd.consensus.qc.poly.map.gz")
## system("plink --file hapmap3_r3_b36_fwd.consensus.qc.poly --make-bed --chr 1")
## 
## genos <- read.plink(bed, bim, fam)
## genos$genotypes
## head(genos$map)
## x <- genos[,is.element(genos$map$snp.name,c(geneIds(snpsGSC[[2]])))]
## ldMat <- ld(x,y=x,stats="R.squared")


###################################################
### code chunk number 12: vegas (eval = FALSE)
###################################################
## ldMat <- geneSetAnalysis[["ldMat"]]
## vRes <- vegas(snpsGSC[1], arrayDataGR, ldMat)
## vRes
## summary(unlist(simulatedStats(vRes)))
## 
## pValue(vRes)
## degreesOfFreedom(vRes)
## statistic(vRes)


###################################################
### code chunk number 13: plotb
###################################################
plotPvals(gRes, main="GLOSSI P-values")


###################################################
### code chunk number 14: plot2
###################################################
pvals <- arrayDataGR$P
names(pvals) <- arrayDataGR$SNP
assocPvalBySetPlot(pvals, snpsGSC[[2]])


###################################################
### code chunk number 15: sessInfo
###################################################
toLatex(sessionInfo())


###################################################
### code chunk number 16: resetOptions
###################################################
options(prompt="> ", continue="+ ")


