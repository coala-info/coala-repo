# Code example from 'RIPSeeker' vignette. See references/ for full tutorial.

### R code from vignette source 'RIPSeeker.Rnw'

###################################################
### code chunk number 1: RIPSeeker
###################################################
library(RIPSeeker)


###################################################
### code chunk number 2: helppage (eval = FALSE)
###################################################
## ?RIPSeeker


###################################################
### code chunk number 3: fullPRC2dataDownload (eval = FALSE)
###################################################
## biocLite("RIPSeekerData")
## 
## library(RIPSeekerData)
## 
## extdata.dir <- system.file("extdata", package="RIPSeekerData")
## 
## bamFiles <- list.files(extdata.dir, "\\.bam$", 
##                        recursive=TRUE, full.names=TRUE)
## 
## bamFiles <- grep("PRC2/", bamFiles, value=TRUE)


###################################################
### code chunk number 4: bamFiles
###################################################
# Retrieve system files
# OR change it to the extdata.dir from the code chunk above
# to get RIP predictions on the full alignment data
extdata.dir <- system.file("extdata", package="RIPSeeker") 

bamFiles <- list.files(extdata.dir, "\\.bam$", 
                       recursive=TRUE, full.names=TRUE)

bamFiles <- grep("PRC2", bamFiles, value=TRUE)

# RIP alignment for Ezh2 in mESC
ripGal <- combineAlignGals(grep(pattern="SRR039214", bamFiles, value=TRUE, invert=TRUE),
                           reverseComplement=TRUE, genomeBuild="mm9")

# Control RIP alignments for mutant Ezh2 -/- mESC
ctlGal <- combineAlignGals(grep(pattern="SRR039214", bamFiles, value=TRUE, invert=FALSE), 
                           reverseComplement=TRUE, genomeBuild="mm9")

ripGal

ctlGal


###################################################
### code chunk number 5: plotCoverage
###################################################
ripGR <- as(ripGal, "GRanges")

ripGRList <- split(ripGR, seqnames(ripGR))

# get only the nonempty chromosome
ripGRList <- ripGRList[elementNROWS(ripGRList) != 0]

ctlGR <- as(ctlGal, "GRanges")

ctlGRList <- GRangesList(as.list(split(ctlGR, seqnames(ctlGR))))

ctlGRList <- ctlGRList[lapply(ctlGRList, length) != 0]

binSize <- 1000

#c(bottom, left, top, right)
par(mfrow=c(1, 2), mar=c(2, 2, 2, 0) + 0.1)

tmp <- lapply(ripGRList, plotStrandedCoverage, binSize=binSize, 
              xlab="", ylab="", plotLegend=TRUE, 
              legend.cex=1.5, main="RIP", cex.main=1.5)

tmp <- lapply(ctlGRList, plotStrandedCoverage, binSize=binSize, 
              xlab="", ylab="", plotLegend=TRUE, 
              legend.cex=1.5, main="CTL", cex.main=1.5)


###################################################
### code chunk number 6: ripSeek (eval = FALSE)
###################################################
## # specify control name
## cNAME <- "SRR039214"
## 
## # output file directory
## outDir <- file.path(getwd(), "RIPSeeker_vigenette_example_PRC2")
## 
## # Parameters setting
## binSize <- NULL      # set to NULL to automatically determine bin size
## minBinSize <- 10000  # min bin size in automatic bin size selection
## maxBinSize <- 10100	 # max bin size in automatic bin size selection
## multicore <- TRUE		 # use multicore
## strandType <- "-"		 # set strand type to minus strand
## 
## biomart <- "ENSEMBL_MART_ENSEMBL"           # use archive to get ensembl 65
## biomaRt_dataset <- "mmusculus_gene_ensembl" # mouse dataset id name	
## host <- "dec2011.archive.ensembl.org"       # use ensembl 65 for annotation for mm9
## goAnno <- "org.Mm.eg.db"                    # GO annotation database
## 
## ################ run main function ripSeek to predict RIP ################
## seekOut.PRC2 <- ripSeek(bamPath = bamFiles, cNAME = cNAME,
##                    reverseComplement = TRUE, genomeBuild = "mm9", 
##                    strandType = strandType, 
##                    uniqueHit = TRUE, assignMultihits = TRUE, 
##                    rerunWithDisambiguatedMultihits = TRUE,
##                    binSize=binSize, minBinSize = minBinSize, 
##                    maxBinSize = maxBinSize,
##                    biomart=biomart, host=host, 
##                    biomaRt_dataset = biomaRt_dataset, goAnno = goAnno,
##                    multicore=multicore, outDir=outDir)


###################################################
### code chunk number 7: ripSeekOutputs (eval = FALSE)
###################################################
## names(seekOut.PRC2)
## 
## df <- elementMetadata(seekOut.PRC2$annotatedRIPGR$sigGRangesAnnotated)
## 
## # order by eFDR
## df <- df[order(df$eFDR), ]
## 
## # get top 100 predictions
## df.top100 <- head(df, 100)
## 
## head(df.top100)
## 
## # examine known PRC2-associated lncRNA transcripts
## df.top100[grep("Xist", df$external_gene_id), ]


###################################################
### code chunk number 8: ripSeekOutFiles (eval = FALSE)
###################################################
## list.files(outDir)


###################################################
### code chunk number 9: ucsc (eval = FALSE)
###################################################
## viewRIP(seekOut.PRC2$RIPGRList$chrX, 
##         seekOut.PRC2$mainSeekOutputRIP$alignGalFiltered, 
##         seekOut.PRC2$mainSeekOutputCTL$alignGalFiltered, scoreType="eFDR")


###################################################
### code chunk number 10: computeRPKM (eval = FALSE)
###################################################
## # Retrieve system files
## extdata.dir <- system.file("extdata", package="RIPSeeker") 
## 
## bamFiles <- list.files(extdata.dir, ".bam$", recursive=TRUE, full.names=TRUE)
## 
## bamFiles <- grep("PRC2", bamFiles, value=TRUE)
## 
## # use biomart
## txDbName <- "biomart"
## biomart <- "ENSEMBL_MART_ENSEMBL"  	# use archive to get ensembl 65
## dataset <- "mmusculus_gene_ensembl"		
## host <- "dec2011.archive.ensembl.org" 	# use ensembl 65 for annotation
## 
## # compute transcript abundance in RIP
## ripRPKM <- computeRPKM(bamFiles=grep(pattern="SRR039214", bamFiles, value=TRUE, invert=TRUE),
##                        dataset=dataset, moreGeneInfo=TRUE, justRPKM=FALSE,
##                        idType="ensembl_transcript_id", txDbName=txDbName, 
##                        biomart=biomart, host=host, by="tx")
## 
## # compute transcript abundance in RIP and control as well as 
## # foldchnage in RIP over control
## rulebase.results <- rulebaseRIPSeek(bamFiles=bamFiles, cNAME=cNAME, myMin=1,
##                                     featureGRanges=ripRPKM$featureGRanges,
##                                     biomart=biomart, host=host, dataset=dataset)
## 
## head(ripRPKM$rpkmDF)
## 
## df <- rulebase.results$rpkmDF
## 
## df <- df[order(df$foldchange, decreasing=TRUE), ]
## 
## # top 10 transcripts
## head(df, 10)


###################################################
### code chunk number 11: ripSeek_CCNT1 (eval = FALSE)
###################################################
## # Retrieve system files
## biocLite("RIPSeekerData")
## 
## extdata.dir <- system.file("extdata", package="RIPSeekerData")
## 
## bamFiles <- list.files(extdata.dir, "\\.bam$", 
##                        recursive=TRUE, full.names=TRUE)
## 
## bamFiles <- grep("CCNT1/firstscreen", bamFiles, value=TRUE)
## 
## # specify control name
## cNAME <- "GFP"
## 
## # output file directory
## outDir <- file.path(getwd(), "RIPSeeker_vigenette_example_CCNT1")
## 
## # Parameters setting
## binSize <- 10000     # automatically determine bin size
## minBinSize <- NULL	 # min bin size in automatic bin size selection
## maxBinSize <- NULL	 # max bin size in automatic bin size selection
## multicore <- TRUE		 # use multicore
## strandType <- "+"		 # set strand type to minus strand
## 
## biomart <- "ensembl"           # use archive to get ensembl 65
## biomaRt_dataset <- "hsapiens_gene_ensembl" # human dataset id name	
## goAnno <- "org.Hs.eg.db"                    # GO annotation database
## 
## ################ run main function ripSeek to predict RIP ################
## seekOut.CCNT1 <- ripSeek(bamPath = bamFiles, cNAME = cNAME,
##                    reverseComplement = TRUE, genomeBuild = "hg19", 
##                    strandType = strandType, 
##                    uniqueHit = TRUE, assignMultihits = TRUE, 
##                    rerunWithDisambiguatedMultihits = TRUE,
##                    binSize=binSize, minBinSize = minBinSize, 
##                    maxBinSize = maxBinSize,
##                    biomart=biomart, goAnno = goAnno,
##                    biomaRt_dataset = biomaRt_dataset,
##                    multicore=multicore, outDir=outDir)
##                    
## df <- elementMetadata(seekOut.CCNT1$annotatedRIPGR$sigGRangesAnnotated)
## 
## # order by eFDR
## df <- df[order(df$eFDR), ]
## 
## # get top 100 predictions
## df.top20 <- head(df, 20)
## 
## # examine known PRC2-associated lncRNA transcripts
## df.top20[grep("RN7SK", df$external_gene_id)[1], ]
## 
## list.files(outDir)


###################################################
### code chunk number 12: ucsc_CCNT1 (eval = FALSE)
###################################################
## viewRIP(seekOut.CCNT1$RIPGRList$chr6, seekOut.CCNT1$mainSeekOutputRIP$alignGalFiltered, seekOut.CCNT1$mainSeekOutputCTL$alignGalFiltered, scoreType="eFDR")


###################################################
### code chunk number 13: computeRPKM_CCNT1 (eval = FALSE)
###################################################
## # use biomart
## txDbName <- "biomart"
## biomart <- "ensembl"
## dataset <- "hsapiens_gene_ensembl"		
## 
## # compute transcript abundance in RIP
## ripRPKM <- computeRPKM(bamFiles=bamFiles[1],
##                        dataset=dataset, moreGeneInfo=TRUE, justRPKM=FALSE,
##                        idType="ensembl_transcript_id", txDbName=txDbName, 
##                        biomart=biomart, by="tx")
## 
## # compute transcript abundance in RIP and control as well as 
## # foldchnage in RIP over control
## rulebase.results <- rulebaseRIPSeek(bamFiles=bamFiles, cNAME=cNAME, myMin=1,
##                                     featureGRanges=ripRPKM$featureGRanges,
##                                     biomart=biomart, dataset=dataset)
## 
## head(ripRPKM$rpkmDF)
## 
## df <- rulebase.results$rpkmDF
## 
## df <- df[order(df$foldchange, decreasing=TRUE), ]
## 
## # top 10 transcripts
## head(df, 10)


###################################################
### code chunk number 14: sessi
###################################################
sessionInfo()


