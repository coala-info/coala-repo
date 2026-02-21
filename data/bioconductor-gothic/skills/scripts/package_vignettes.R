# Code example from 'package_vignettes' vignette. See references/ for full tutorial.

### R code from vignette source 'package_vignettes.Snw'

###################################################
### code chunk number 1: package_vignettes.Snw:31-33 (eval = FALSE)
###################################################
## library(GOTHiC)
## data(lymphoid_chr20_paired_filtered)


###################################################
### code chunk number 2: package_vignettes.Snw:79-84 (eval = FALSE)
###################################################
## dirPath = system.file("extdata", package="HiCDataLymphoblast")
## fileName1 = list.files(dirPath, full.names=TRUE)[1]
## fileName2 = list.files(dirPath, full.names=TRUE)[2]
## paired = pairReads(fileName1, fileName2, sampleName="lymphoid_chr20", 
## DUPLICATETHRESHOLD = 1, fileType="Table")


###################################################
### code chunk number 3: package_vignettes.Snw:91-96 (eval = FALSE)
###################################################
## data(lymphoid_chr20_paired_filtered)
## mapped=mapReadsToRestrictionSites(filtered, sampleName="lymphoid_chr20", 
## BSgenomeName="BSgenome.Hsapiens.UCSC.hg18", 
## genome=BSgenome.Hsapiens.UCSC.hg18, 
## restrictionSite="A^AGCTT", enzyme="HindIII", parallel=FALSE, cores=1)


###################################################
### code chunk number 4: package_vignettes.Snw:103-111 (eval = FALSE)
###################################################
## dirPath = system.file("extdata", package="HiCDataLymphoblast")
## fileName1 = list.files(dirPath, full.names=TRUE)[1]
## fileName2 = list.files(dirPath, full.names=TRUE)[2]
## binom=GOTHiC(fileName1,fileName2, sampleName="lymphoid_chr20", 
## res=1000000, BSgenomeName="BSgenome.Hsapiens.UCSC.hg18",
## genome=BSgenome.Hsapiens.UCSC.hg18, 
## restrictionSite="A^AGCTT", enzyme="HindIII" ,cistrans="all", filterdist=10000,
## DUPLICATETHRESHOLD=1, fileType="Table", parallel=FALSE, cores=NULL)


###################################################
### code chunk number 5: package_vignettes.Snw:114-119 (eval = FALSE)
###################################################
## dirPath <- system.file("extdata", package="HiCDataLymphoblast")
## fileName <- list.files(dirPath, full.names=TRUE)[4]
## restrictionFile <- list.files(dirPath, full.names=TRUE)[3]
## binom=GOTHiChicup(fileName, sampleName='lymphoid_chr20', res=1000000, 
## restrictionFile, cistrans='all', parallel=FALSE, cores=NULL)


