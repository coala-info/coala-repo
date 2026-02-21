# Code example from 'Introduction_to_OTUbase' vignette. See references/ for full tutorial.

### R code from vignette source 'Introduction_to_OTUbase.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: preliminaries
###################################################
library("OTUbase")


###################################################
### code chunk number 3: dirPath
###################################################
dirPath <- system.file("extdata/Sogin_2006", package="OTUbase")


###################################################
### code chunk number 4: readOTUset
###################################################
soginOTU <- readOTUset(dirPath=dirPath, level="0.03", samplefile="sogin.groups", fastafile="sogin.fasta", otufile="sogin.unique.filter.fn.list", sampleADF="sample_metadata.txt")
soginOTU


###################################################
### code chunk number 5: readTAXset
###################################################
soginTAX <- readTAXset(dirPath=dirPath, fastafile='sogin.fasta', sampleADF='sample_metadata.txt', taxfile='sogin.unique.fix.tax', namefile='sogin.names', samplefile='sogin.groups')
soginTAX


###################################################
### code chunk number 6: accessors
###################################################
head(id(soginOTU))
head(sread(soginOTU))
head(sampleID(soginOTU))
head(sData(soginOTU))


###################################################
### code chunk number 7: accessors
###################################################
head(otuID(soginOTU))
head(tax(soginTAX))


###################################################
### code chunk number 8: abundance
###################################################
abundOTU <- abundance(soginOTU, weighted=F, collab='Site')
head(abundOTU)
abundTAX <- abundance(soginTAX, weighted=F, taxCol='genus', collab='Site')
head(abundTAX)


###################################################
### code chunk number 9: RichnessEstimate
###################################################
estrichOTU <- apply(abundOTU, 2, estimateR)
estrichOTU
estrichTAX <- apply(abundTAX, 2, estimateR)
estrichTAX


###################################################
### code chunk number 10: clusterSamples
###################################################
clusterSamples(soginOTU, distmethod='jaccard', clustermethod='complete', collab='Site')
clusterSamples(soginTAX, taxCol='genus', distmethod='jaccard', clustermethod='complete', collab='Site')


###################################################
### code chunk number 11: subOTUset
###################################################
soginReduced <- subOTUset(soginOTU, samples=c("137", "138", "53R", "55R"))
soginReduced


###################################################
### code chunk number 12: sessionInfo
###################################################
toLatex(sessionInfo())


