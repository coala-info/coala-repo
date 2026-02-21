# Code example from 'QDNAseq' vignette. See references/ for full tutorial.

### R code from vignette source 'QDNAseq.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: QDNAseq.Rnw:23-24
###################################################
library(QDNAseq)


###################################################
### code chunk number 3: QDNAseq.Rnw:27-30
###################################################
## Send verbose output to stdout instead of stderr
options("QDNAseq::verbose"=NA)
options(width=40)


###################################################
### code chunk number 4: QDNAseq.Rnw:65-77 (eval = FALSE)
###################################################
## readCounts <- binReadCounts(bins)
## # all files ending in .bam from the current working directory
## 
## # or
## 
## readCounts <- binReadCounts(bins, bamfiles="tumor.bam")
## # file 'tumor.bam' from the current working directory
## 
## # or
## 
## readCounts <- binReadCounts(bins, path="tumors")
## # all files ending in .bam from the subdirectory 'tumors'


###################################################
### code chunk number 5: QDNAseq.Rnw:95-98
###################################################
data(LGG150)
readCounts <- LGG150
readCounts


###################################################
### code chunk number 6: QDNAseq.Rnw:104-105
###################################################
png("rawprofile.png")


###################################################
### code chunk number 7: rawprofile
###################################################
plot(readCounts, logTransform=FALSE, ylim=c(-50, 200))
highlightFilters(readCounts, logTransform=FALSE,
  residual=TRUE, blacklist=TRUE)


###################################################
### code chunk number 8: QDNAseq.Rnw:112-113
###################################################
dev.off()


###################################################
### code chunk number 9: QDNAseq.Rnw:129-130
###################################################
readCountsFiltered <- applyFilters(readCounts, residual=TRUE, blacklist=TRUE)


###################################################
### code chunk number 10: QDNAseq.Rnw:132-133
###################################################
png("isobar.png")


###################################################
### code chunk number 11: isobar
###################################################
isobarPlot(readCountsFiltered)


###################################################
### code chunk number 12: QDNAseq.Rnw:138-139
###################################################
dev.off()


###################################################
### code chunk number 13: QDNAseq.Rnw:157-158
###################################################
readCountsFiltered <- estimateCorrection(readCountsFiltered)


###################################################
### code chunk number 14: QDNAseq.Rnw:160-161
###################################################
png("noise.png")


###################################################
### code chunk number 15: noise
###################################################
noisePlot(readCountsFiltered)


###################################################
### code chunk number 16: QDNAseq.Rnw:166-167
###################################################
dev.off()


###################################################
### code chunk number 17: QDNAseq.Rnw:181-185
###################################################
copyNumbers <- correctBins(readCountsFiltered)
copyNumbers
copyNumbersNormalized <- normalizeBins(copyNumbers)
copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)


###################################################
### code chunk number 18: QDNAseq.Rnw:187-188
###################################################
png("profile.png")


###################################################
### code chunk number 19: profile
###################################################
plot(copyNumbersSmooth)


###################################################
### code chunk number 20: QDNAseq.Rnw:193-194
###################################################
dev.off()


###################################################
### code chunk number 21: QDNAseq.Rnw:208-211 (eval = FALSE)
###################################################
## exportBins(copyNumbersSmooth, file="LGG150.txt")
## exportBins(copyNumbersSmooth, file="LGG150.igv", format="igv")
## exportBins(copyNumbersSmooth, file="LGG150.bed", format="bed")


###################################################
### code chunk number 22: QDNAseq.Rnw:224-226
###################################################
copyNumbersSegmented <- segmentBins(copyNumbersSmooth, transformFun="sqrt")
copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)


###################################################
### code chunk number 23: QDNAseq.Rnw:228-229
###################################################
png("segments.png")


###################################################
### code chunk number 24: segments
###################################################
plot(copyNumbersSegmented)


###################################################
### code chunk number 25: QDNAseq.Rnw:234-235
###################################################
dev.off()


###################################################
### code chunk number 26: QDNAseq.Rnw:248-249
###################################################
copyNumbersCalled <- callBins(copyNumbersSegmented)


###################################################
### code chunk number 27: QDNAseq.Rnw:251-252
###################################################
png("calls.png")


###################################################
### code chunk number 28: calls
###################################################
plot(copyNumbersCalled)


###################################################
### code chunk number 29: QDNAseq.Rnw:257-258
###################################################
dev.off()


###################################################
### code chunk number 30: QDNAseq.Rnw:270-272 (eval = FALSE)
###################################################
## exportBins(copyNumbersCalled, format="vcf")
## exportBins(copyNumbersCalled, format="seg")


###################################################
### code chunk number 31: QDNAseq.Rnw:290-292
###################################################
cgh <- makeCgh(copyNumbersCalled)
cgh


###################################################
### code chunk number 32: QDNAseq.Rnw:328-329 (eval = FALSE)
###################################################
## copyNumbers <- callBins(..., ncpus=4)


###################################################
### code chunk number 33: QDNAseq.Rnw:337-338 (eval = FALSE)
###################################################
## future::plan("sequential")


###################################################
### code chunk number 34: QDNAseq.Rnw:346-347 (eval = FALSE)
###################################################
## future::plan("multisession")


###################################################
### code chunk number 35: QDNAseq.Rnw:360-361 (eval = FALSE)
###################################################
## future::plan("multisession", workers=4)


###################################################
### code chunk number 36: QDNAseq.Rnw:372-374 (eval = FALSE)
###################################################
## cl <- future::makeClusterPSOCK(...)
## future::plan("cluster", cluster=cl)


###################################################
### code chunk number 37: QDNAseq.Rnw:395-400 (eval = FALSE)
###################################################
## readCounts <- binReadCounts(getBinAnnotations(15))
## readCounts <- applyFilters(readCounts)
## readCounts <- estimateCorrection(readCounts)
## readCounts <- applyFilters(readCounts, chromosomes=NA)
## copyNumbers <- correctBins(readCounts)


###################################################
### code chunk number 38: QDNAseq.Rnw:415-417 (eval = FALSE)
###################################################
## readCounts <- estimateCorrection(readCounts,
##   control=loess.control(surface="direct"))


###################################################
### code chunk number 39: QDNAseq.Rnw:431-441 (eval = FALSE)
###################################################
## # load required packages for human reference genome build hg19
## library(QDNAseq)
## library(Biobase)
## library(BSgenome.Hsapiens.UCSC.hg19)
## 
## # set the bin size
## binSize <- 15
## 
## # create bins from the reference genome
## bins <- createBins(bsgenome=BSgenome.Hsapiens.UCSC.hg19, binSize=binSize)


###################################################
### code chunk number 40: QDNAseq.Rnw:458-462 (eval = FALSE)
###################################################
## # calculate mappabilites per bin from ENCODE mapability tracks
## bins$mappability <- calculateMappability(bins,
##   bigWigFile="/path/to/wgEncodeCrgMapabilityAlign50mer.bigWig",
##   bigWigAverageOverBed="/path/to/bigWigAverageOverBed")


###################################################
### code chunk number 41: QDNAseq.Rnw:474-478 (eval = FALSE)
###################################################
## # calculate overlap with ENCODE blacklisted regions
## bins$blacklist <- calculateBlacklist(bins,
##   bedFiles=c("/path/to/wgEncodeDacMapabilityConsensusExcludable.bed",
##              "/path/to/wgEncodeDukeMapabilityRegionsExcludable.bed"))


###################################################
### code chunk number 42: QDNAseq.Rnw:484-487 (eval = FALSE)
###################################################
## # generic calculation of overlap with blacklisted regions
## bins$blacklist <- calculateBlacklistByRegions(bins, 
##   cbind(chromosome, bpStart, bpEnd))


###################################################
### code chunk number 43: QDNAseq.Rnw:496-501 (eval = FALSE)
###################################################
## # load data for the 1000 Genomes (or similar) data set, and generate residuals
## ctrl <- binReadCounts(bins, path="/path/to/control-set/bam/files")
## ctrl <- applyFilters(ctrl, residual=FALSE, blacklist=FALSE,
##   mappability=FALSE, bases=FALSE)
## bins$residual <- iterateResiduals(ctrl)


###################################################
### code chunk number 44: QDNAseq.Rnw:510-513 (eval = FALSE)
###################################################
## # by default, use all autosomal bins that have a reference sequence
## # (i.e. not only N's)
## bins$use <- bins$chromosome %in% as.character(1:22) & bins$bases > 0


###################################################
### code chunk number 45: QDNAseq.Rnw:519-532 (eval = FALSE)
###################################################
## # convert to AnnotatedDataFrame and add metadata
## bins <- AnnotatedDataFrame(bins,
##   varMetadata=data.frame(labelDescription=c(
##   "Chromosome name",
##   "Base pair start position",
##   "Base pair end position",
##   "Percentage of non-N nucleotides (of full bin size)",
##   "Percentage of C and G nucleotides (of non-N nucleotides)",
##   "Average mappability of 50mers with a maximum of 2 mismatches",
##   "Percent overlap with ENCODE blacklisted regions",
##   "Median loess residual from 1000 Genomes (50mers)",
##   "Whether the bin should be used in subsequent analysis steps"),
##   row.names=colnames(bins)))


###################################################
### code chunk number 46: QDNAseq.Rnw:538-546 (eval = FALSE)
###################################################
## attr(bins, "QDNAseq") <- list(
##   author="Ilari Scheinin",
##   date=Sys.time(),
##   organism="Hsapiens",
##   build="hg19",
##   version=packageVersion("QDNAseq"),
##   md5=digest::digest(bins@data),
##   sessionInfo=sessionInfo())


###################################################
### code chunk number 47: QDNAseq.Rnw:556-589 (eval = FALSE)
###################################################
## # download table of samples
## urlroot <- "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp"
## g1k <- read.table(file.path(urlroot, "sequence.index"),
##   header=TRUE, sep="\t", as.is=TRUE, fill=TRUE)
## 
## # keep cases that are Illumina, low coverage, single-read, and not withdrawn
## g1k <- g1k[g1k$INSTRUMENT_PLATFORM == "ILLUMINA", ]
## g1k <- g1k[g1k$ANALYSIS_GROUP == "low coverage", ]
## g1k <- g1k[g1k$LIBRARY_LAYOUT == "SINGLE", ]
## g1k <- g1k[g1k$WITHDRAWN == 0, ]
## 
## # keep cases with read lengths of at least 50 bp
## g1k <- g1k[!g1k$BASE_COUNT %in% c("not available", ""), ]
## g1k$BASE_COUNT <- as.numeric(g1k$BASE_COUNT)
## g1k$READ_COUNT <- as.integer(g1k$READ_COUNT)
## g1k$readLength <- g1k$BASE_COUNT / g1k$READ_COUNT
## g1k <- g1k[g1k$readLength > 50, ]
## 
## # keep samples with a minimum of one million reads
## readCountPerSample <- aggregate(g1k$READ_COUNT,
##   by=list(sample=g1k$SAMPLE_NAME), FUN=sum)
## g1k <- g1k[g1k$SAMPLE_NAME %in%
##   readCountPerSample$sample[readCountPerSample$x >= 1e6], ]
## 
## g1k$fileName <- basename(g1k$FASTQ_FILE)
## 
## # download FASTQ files
## for (i in rownames(g1k)) {
##   sourceFile <- file.path(urlroot, g1k[i, "FASTQ_FILE"])
##   destFile <- g1k[i, "fileName"]
##   if (!file.exists(destFile))
##     download.file(sourceFile, destFile, mode="wb")
## }


###################################################
### code chunk number 48: QDNAseq.Rnw:604-605
###################################################
toLatex(sessionInfo())


