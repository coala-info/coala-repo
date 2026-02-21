# Code example from 'riboSeqR' vignette. See references/ for full tutorial.

### R code from vignette source 'riboSeqR.Rnw'

###################################################
### code chunk number 1: <style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: riboSeqR.Rnw:33-34
###################################################
library(riboSeqR)


###################################################
### code chunk number 3: riboSeqR.Rnw:39-40
###################################################
datadir <- system.file("extdata", package = "riboSeqR")


###################################################
### code chunk number 4: riboSeqR.Rnw:45-49
###################################################
chlamyFasta <- paste(datadir, "/rsem_chlamy236_deNovo.transcripts.fa", sep = "")
fastaCDS <- findCDS(fastaFile = chlamyFasta, 
                    startCodon = c("ATG"), 
                    stopCodon = c("TAG", "TAA", "TGA"))


###################################################
### code chunk number 5: riboSeqR.Rnw:53-57
###################################################
ribofiles <- paste(datadir, 
                   "/chlamy236_plus_deNovo_plusOnly_Index", c(17,3,5,7), sep = "")
rnafiles <- paste(datadir, 
                  "/chlamy236_plus_deNovo_plusOnly_Index", c(10,12,14,16), sep = "")


###################################################
### code chunk number 6: riboSeqR.Rnw:62-63
###################################################
riboDat <- readRibodata(ribofiles, replicates = c("WT", "WT", "M", "M"))


###################################################
### code chunk number 7: riboSeqR.Rnw:68-69
###################################################
fCs <- frameCounting(riboDat, fastaCDS)


###################################################
### code chunk number 8: frameshift
###################################################
fS <- readingFrame(rC = fCs); fS
plotFS(fS)


###################################################
### code chunk number 9: frameshift
###################################################
fS <- readingFrame(rC = fCs); fS
plotFS(fS)


###################################################
### code chunk number 10: riboSeqR.Rnw:92-94
###################################################
ffCs <- filterHits(fCs, lengths = c(27, 28), frames = list(1, 0), 
                   hitMean = 50, unqhitMean = 10, fS = fS)


###################################################
### code chunk number 11: plotcds27
###################################################
plotCDS(coordinates = ffCs@CDS, riboDat = riboDat, lengths = 27)


###################################################
### code chunk number 12: plotcds28
###################################################
plotCDS(coordinates = ffCs@CDS, riboDat = riboDat, lengths = 28)


###################################################
### code chunk number 13: figcds27
###################################################
plotCDS(coordinates = ffCs@CDS, riboDat = riboDat, lengths = 27)


###################################################
### code chunk number 14: figcds28
###################################################
plotCDS(coordinates = ffCs@CDS, riboDat = riboDat, lengths = 28)


###################################################
### code chunk number 15: plottranscript
###################################################
plotTranscript("CUFF.37930.1", coordinates = ffCs@CDS, 
               riboData = riboDat, length = 27, cap = 200)               


###################################################
### code chunk number 16: figtran
###################################################
plotTranscript("CUFF.37930.1", coordinates = ffCs@CDS, 
               riboData = riboDat, length = 27, cap = 200)               


###################################################
### code chunk number 17: riboSeqR.Rnw:145-146
###################################################
riboCounts <- sliceCounts(ffCs, lengths = c(27, 28), frames = list(0, 2))


###################################################
### code chunk number 18: riboSeqR.Rnw:151-152
###################################################
rnaCounts <- rnaCounts(riboDat, ffCs@CDS)


###################################################
### code chunk number 19: riboSeqR.Rnw:157-169
###################################################
library(baySeq)

pD <- new("countData", replicates = ffCs@replicates, 
          data = list(riboCounts, rnaCounts),
          groups = list(NDT = c(1,1,1,1), DT = c("WT", "WT", "M", "M")),
          annotation = as.data.frame(ffCs@CDS),
          densityFunction = bbDensity)
libsizes(pD) <- getLibsizes(pD)

pD <- getPriors(pD, cl = NULL)
pD <- getLikelihoods(pD, cl = NULL)
topCounts(pD, "DT", normaliseData = TRUE)


###################################################
### code chunk number 20: riboSeqR.Rnw:174-175
###################################################
sessionInfo()


