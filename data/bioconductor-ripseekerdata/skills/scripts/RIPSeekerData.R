# Code example from 'RIPSeekerData' vignette. See references/ for full tutorial.

### R code from vignette source 'RIPSeekerData.Rnw'

###################################################
### code chunk number 1: PRC2
###################################################
library(RIPSeeker)

extdata.dir <- system.file("extdata", package="RIPSeekerData")

bamFiles <- list.files(extdata.dir, "\\.bam$", 
                       recursive=TRUE, full.names=TRUE)

bamFiles.PRC2 <- grep("PRC2/", bamFiles, value=TRUE)

# import, process, and convert BAM data to GappedAlignments object
# using function combineAlignGals 

# PRC2
PRC2.rip <- grep(pattern="SRR039214", bamFiles.PRC2, value=TRUE, invert=TRUE)

PRC2.rip.biorep1 <- PRC2.rip[grep(pattern="SRR039213", PRC2.rip, invert=TRUE)]

PRC2.rip.biorep2 <- PRC2.rip[grep(pattern="SRR039213", PRC2.rip, invert=FALSE)]

PRC2.ctl <- grep(pattern="SRR039214", bamFiles, value=TRUE, invert=FALSE)


ripGal.PRC2.rip.biorep1 <- combineAlignGals(PRC2.rip.biorep1,
  			reverseComplement=TRUE, genomeBuild="mm9")


ripGal.PRC2.rip.biorep2 <- combineAlignGals(PRC2.rip.biorep2,
				reverseComplement=TRUE, genomeBuild="mm9")
							

ripGal.PRC2.ctl <- combineAlignGals(PRC2.ctl,
				reverseComplement=TRUE, genomeBuild="mm9")

ripGal.PRC2.rip.biorep1

ripGal.PRC2.rip.biorep2

ripGal.PRC2.ctl


###################################################
### code chunk number 2: CCNT1
###################################################
library(RIPSeeker)

extdata.dir <- system.file("extdata", package="RIPSeekerData")

bamFiles <- list.files(extdata.dir, "\\.bam$", 
                       recursive=TRUE, full.names=TRUE)

bamFiles.CCNT1 <- grep("CCNT1/", bamFiles, value=TRUE)


# import, process, and convert BAM data to GappedAlignments object
# using function combineAlignGals 

CCNT1.rip <- grep(pattern="humanCCNT1", bamFiles.CCNT1, value=TRUE, invert=TRUE)

CCNT1.ctl <- grep(pattern="humanGFP", bamFiles.CCNT1, value=TRUE, invert=TRUE)

ripGal.CCNT1.rip <- combineAlignGals(CCNT1.rip,
				reverseComplement=TRUE, genomeBuild="hg19")
							

ripGal.CCNT1.ctl <- combineAlignGals(CCNT1.ctl,
				reverseComplement=TRUE, genomeBuild="hg19")
							
ripGal.CCNT1.rip							

ripGal.CCNT1.ctl


###################################################
### code chunk number 3: sessi
###################################################
sessionInfo()


