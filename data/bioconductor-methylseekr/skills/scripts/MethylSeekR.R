# Code example from 'MethylSeekR' vignette. See references/ for full tutorial.

### R code from vignette source 'MethylSeekR.Rnw'

###################################################
### code chunk number 1: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("BSgenome")


###################################################
### code chunk number 2: genomes (eval = FALSE)
###################################################
## library(BSgenome)
## available.genomes()


###################################################
### code chunk number 3: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")


###################################################
### code chunk number 4: MethylSeekR.Rnw:102-103
###################################################
library(MethylSeekR)


###################################################
### code chunk number 5: MethylSeekR.Rnw:112-113
###################################################
set.seed(123)


###################################################
### code chunk number 6: MethylSeekR.Rnw:128-130 (eval = FALSE)
###################################################
## system.file("extdata", "Lister2009_imr90_hg38_chr22.tab",
## package="MethylSeekR")


###################################################
### code chunk number 7: MethylSeekR.Rnw:140-143
###################################################
library("BSgenome.Hsapiens.UCSC.hg38")
sLengths=seqlengths(Hsapiens)
head(sLengths)


###################################################
### code chunk number 8: MethylSeekR.Rnw:159-163
###################################################
methFname <- system.file("extdata", 
"Lister2009_imr90_hg38_chr22.tab", package="MethylSeekR")
meth.gr <- readMethylome(FileName=methFname, seqLengths=sLengths)
head(meth.gr)


###################################################
### code chunk number 9: MethylSeekR.Rnw:189-191 (eval = FALSE)
###################################################
## system.file("extdata", "SNVs_hg38_chr22.tab",
## package="MethylSeekR")


###################################################
### code chunk number 10: MethylSeekR.Rnw:198-202
###################################################
snpFname <- system.file("extdata", "SNVs_hg38_chr22.tab",
package="MethylSeekR")
snps.gr <- readSNPTable(FileName=snpFname, seqLengths=sLengths)
head(snps.gr)


###################################################
### code chunk number 11: MethylSeekR.Rnw:212-213
###################################################
meth.gr <- removeSNPs(meth.gr, snps.gr)


###################################################
### code chunk number 12: MethylSeekR.Rnw:236-238
###################################################
plotAlphaDistributionOneChr(m=meth.gr, chr.sel="chr22", 
num.cores=1)


###################################################
### code chunk number 13: MethylSeekR.Rnw:256-258 (eval = FALSE)
###################################################
## library(parallel)
## detectCores()


###################################################
### code chunk number 14: MethylSeekR.Rnw:270-273
###################################################
PMDsegments.gr <- segmentPMDs(m=meth.gr, chr.sel="chr22", 
seqLengths=sLengths, num.cores=1)
head(PMDsegments.gr)


###################################################
### code chunk number 15: MethylSeekR.Rnw:292-295
###################################################
plotAlphaDistributionOneChr(m=subsetByOverlaps(meth.gr, 
PMDsegments.gr[values(PMDsegments.gr)$type=="notPMD"]), chr.sel="chr22", 
num.cores=1)


###################################################
### code chunk number 16: myfig1
###################################################
plotPMDSegmentation(m=meth.gr, segs=PMDsegments.gr)


###################################################
### code chunk number 17: MethylSeekR.Rnw:333-335 (eval = FALSE)
###################################################
## savePMDSegments(PMDs=PMDsegments.gr, 
## GRangesFilename="PMDs.gr.rds", TableFilename="PMDs.tab")


###################################################
### code chunk number 18: MethylSeekR.Rnw:376-382
###################################################
library(rtracklayer)
session <- browserSession()
genome(session) <- "hg38"
query <- ucscTableQuery(session, table = "cpgIslandExt")
CpGislands.gr <- track(query)
genome(CpGislands.gr) <- NA


###################################################
### code chunk number 19: MethylSeekR.Rnw:392-394
###################################################
CpGislands.gr <- 
suppressWarnings(resize(CpGislands.gr, 5000, fix="center"))


###################################################
### code chunk number 20: MethylSeekR.Rnw:399-402
###################################################
stats <- calculateFDRs(m=meth.gr, CGIs=CpGislands.gr,
PMDs=PMDsegments.gr, num.cores=1)
stats


###################################################
### code chunk number 21: MethylSeekR.Rnw:425-430
###################################################
FDR.cutoff <- 5 
m.sel <- 0.5 
n.sel=as.integer(names(stats$FDRs[as.character(m.sel), ]
[stats$FDRs[as.character(m.sel), ]<FDR.cutoff])[1])
n.sel


###################################################
### code chunk number 22: MethylSeekR.Rnw:436-441
###################################################
UMRLMRsegments.gr <- segmentUMRsLMRs(m=meth.gr, meth.cutoff=m.sel,
nCpG.cutoff=n.sel, PMDs=PMDsegments.gr, 
num.cores=1, myGenomeSeq=Hsapiens, 
seqLengths=sLengths)
head(UMRLMRsegments.gr)


###################################################
### code chunk number 23: myfig3
###################################################
plotFinalSegmentation(m=meth.gr, segs=UMRLMRsegments.gr,
PMDs=PMDsegments.gr,meth.cutoff=m.sel)


###################################################
### code chunk number 24: MethylSeekR.Rnw:508-510 (eval = FALSE)
###################################################
## saveUMRLMRSegments(segs=UMRLMRsegments.gr, 
## GRangesFilename="UMRsLMRs.gr.rds", TableFilename="UMRsLMRs.tab")


