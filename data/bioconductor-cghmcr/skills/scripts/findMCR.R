# Code example from 'findMCR' vignette. See references/ for full tutorial.

### R code from vignette source 'findMCR.Rnw'

###################################################
### code chunk number 1: findMCR.Rnw:37-41
###################################################
require("limma")
arrayFiles  <- list.files(system.file("sampleData", package = "cghMCR"), 
     full.names = TRUE, pattern = "TCGA")
arrayFiles


###################################################
### code chunk number 2: findMCR.Rnw:46-53
###################################################
rawData <- read.maimages(arrayFiles, source = "agilent", columns = 
    list(R = "rMedianSignal", G = "gMedianSignal", Rb = "rBGMedianSignal", 
    Gb = "gBGMedianSignal"), annotation = c("Row", "Col", "ControlType", 
    "ProbeName", "GeneName", "SystematicName", "PositionX", "PositionY", 
    "gIsFeatNonUnifOL", "rIsFeatNonUnifOL", "gIsBGNonUnifOL", "rIsBGNonUnifOL",
    "gIsFeatPopnOL", "rIsFeatPopnOL", "gIsBGPopnOL", "rIsBGPopnOL", 
    "rIsSaturated", "gIsSaturated"), names = basename(arrayFiles))


###################################################
### code chunk number 3: findMCR.Rnw:58-59
###################################################
rawData$design <- c(-1, -1, -1)


###################################################
### code chunk number 4: findMCR.Rnw:64-65
###################################################
ma <- normalizeWithinArrays(backgroundCorrect(rawData, method = "minimum"), method = "loess")


###################################################
### code chunk number 5: findMCR.Rnw:70-72
###################################################
chrom <- gsub("chr([0-9XY]+):.*", "\\1", ma$genes[, "SystematicName"])
dropMe <- c(which(!chrom %in% c(1:22, "X", "Y")), which(ma$genes[, "ControlType"] != 0))


###################################################
### code chunk number 6: findMCR.Rnw:77-85
###################################################
require(DNAcopy, quietly = TRUE)
set.seed(25)
cna <- CNA(ma$M[-dropMe, ], 
    gsub("chr([0-9XY]+):.*", "\\1", ma$genes[-dropMe, "SystematicName"]),
    as.numeric(gsub(".*:([0-9]+)-.*", "\\1", 
      ma$genes[-dropMe, "SystematicName"])),
    data.type = "logratio", sampleid = colnames(ma$M)) 
segData <- segment(smooth.CNA(cna)) 


###################################################
### code chunk number 7: findMCR.Rnw:90-92
###################################################
mySeglist <- segData[["output"]]
head(mySeglist)


###################################################
### code chunk number 8: findMCR.Rnw:99-102
###################################################
require(CNTools, quietly = TRUE)
data("sampleData", package = "CNTools")
head(sampleData)


###################################################
### code chunk number 9: findMCR.Rnw:107-112
###################################################
data(geneInfo)
data(sampleData, package = "CNTools")
set.seed(1234)
convertedData <- getRS(CNSeg(sampleData[which(is.element(sampleData[, "ID"], sample(unique(sampleData[, "ID"]), 20))), ]), by = "gene", imput = FALSE, 
XY = FALSE, geneMap = geneInfo, what = "median")


###################################################
### code chunk number 10: findMCR.Rnw:119-122
###################################################
require(cghMCR, quietly = TRUE)
SGOLScores <- SGOL(convertedData, threshold = c(-0.2, 0.2), method = sum)
plot(SGOLScores)


###################################################
### code chunk number 11: findMCR.Rnw:135-140
###################################################
GOIGains <- SGOLScores[which(as.numeric(unlist(gol(SGOLScores[, "gains"]))) > 
     20), "gains"]
GOILosses <- SGOLScores[which(as.numeric(unlist(gol(SGOLScores[, "losses"]))) < 
     -20), "losses"]
head(gol(GOIGains))


###################################################
### code chunk number 12: findMCR.Rnw:160-163
###################################################
cghmcr <- cghMCR(segData, gapAllowed = 500, alteredLow = 0.9,
 alteredHigh = 0.9, recurrence = 100)
mcrs <- MCR(cghmcr)


###################################################
### code chunk number 13: findMCR.Rnw:168-170
###################################################
head(cbind(mcrs[, c("chromosome", "status", "mcr.start", "mcr.end", 
                     "samples")])) 


###################################################
### code chunk number 14: findMCR.Rnw:175-178
###################################################
mcrs <- mergeMCRProbes(mcrs[mcrs[, "chromosome"] == "7", ], as.data.frame(segData[["data"]]))
head(cbind(mcrs[, c("chromosome", "status", "mcr.start", "mcr.end", 
                     "probes")]))


###################################################
### code chunk number 15: findMCR.Rnw:186-187
###################################################
sessionInfo()


