# Code example from 'GUIDEseq' vignette. See references/ for full tutorial.

### R code from vignette source 'GUIDEseq.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: GUIDEseq.Rnw:21-25
###################################################
library(knitr)
opts_chunk$set(
concordance=TRUE
)


###################################################
### code chunk number 3: GUIDEseq.Rnw:102-109
###################################################
library(GUIDEseq)
umifile <- system.file("extdata", "UMI-HEK293_site4_chr13.txt", 
                       package = "GUIDEseq")
bedfile <- system.file("extdata","bowtie2.HEK293_site4_chr13.sort.bed",
                       package = "GUIDEseq")
bamfile <- system.file("extdata","bowtie2.HEK293_site4_chr13.sort.bam",
                       package = "GUIDEseq")


###################################################
### code chunk number 4: GUIDEseq.Rnw:148-151
###################################################
uniqueCleavageEvents <- getUniqueCleavageEvents(bamfile, umifile, n.cores.max =1)
#uniqueCleavageEventsOld <- getUniqueCleavageEvents(bedfile, umifile)
uniqueCleavageEvents$cleavage.gr


###################################################
### code chunk number 5: GUIDEseq.Rnw:165-168
###################################################
peaks <- getPeaks(uniqueCleavageEvents$cleavage.gr, min.reads = 80)
peaks.gr <- peaks$peaks
peaks.gr


###################################################
### code chunk number 6: GUIDEseq.Rnw:183-187
###################################################
mergedPeaks <- mergePlusMinusPeaks(peaks.gr = peaks.gr,  
    output.bedfile = "mergedPeaks.bed")
mergedPeaks$mergedPeaks.gr
head(mergedPeaks$mergedPeaks.bed)


###################################################
### code chunk number 7: GUIDEseq.Rnw:201-216
###################################################
library(BSgenome.Hsapiens.UCSC.hg19)
peaks <- system.file("extdata", "T2plus100OffTargets.bed",
    package = "CRISPRseek")
gRNAs <- system.file("extdata", "T2.fa",
    package = "CRISPRseek")
outputDir <- getwd() 
offTargets <- offTargetAnalysisOfPeakRegions(gRNA = gRNAs, peaks = peaks,
    format=c("fasta", "bed"),
    peaks.withHeader = TRUE, BSgenomeName = Hsapiens,
    upstream = 50, downstream =50, PAM.size = 3, gRNA.size = 20,
    PAM = "NGG", PAM.pattern = "(NAG|NGG|NGA)$", max.mismatch = 2,
    outputDir = outputDir,
    orderOfftargetsBy = "predicted_cleavage_score",
    allowed.mismatch.PAM = 2, overwrite = TRUE
   )


###################################################
### code chunk number 8: GUIDEseq.Rnw:231-239
###################################################
gRNA.file <- system.file("extdata","gRNA.fa", package = "GUIDEseq")
system.time(guideSeqRes <- GUIDEseqAnalysis(
    alignment.inputfile = bamfile, 
    umi.inputfile = umifile, gRNA.file = gRNA.file, 
    orderOfftargetsBy = "peak_score",
    descending = TRUE, n.cores.max = 1,
    BSgenomeName = Hsapiens, min.reads = 1))
names(guideSeqRes)


###################################################
### code chunk number 9: GUIDEseq.Rnw:274-275
###################################################
sessionInfo()


