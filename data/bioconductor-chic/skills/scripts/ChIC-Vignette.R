# Code example from 'ChIC-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'ChIC-Vignette.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: ChIC-Vignette.Rnw:122-133 (eval = FALSE)
###################################################
## 
## system("wget 
## https://www.encodeproject.org/files/ENCFF000BFX/
##     @@download/ENCFF000BFX.bam")
## 
## system("wget 
## https://www.encodeproject.org/files/ENCFF000BDQ/
##     @@download/ENCFF000BDQ.bam")
## 
## chipName <- "ENCFF000BFX"
## inputName <- "ENCFF000BDQ"


###################################################
### code chunk number 2: ChIC-Vignette.Rnw:143-154
###################################################

library(ChIC)

#load tag-list with reads aligned to a subset of chromosomes
data("chipSubset", package = "ChIC.data", 
    envir = environment())
chipBam <- chipSubset

data("inputSubset", package = "ChIC.data", 
    envir = environment())
inputBam <- inputSubset


###################################################
### code chunk number 3: options
###################################################
options(width=60)


###################################################
### code chunk number 4: ChIC-Vignette.Rnw:173-185 (eval = FALSE)
###################################################
## 
## ##calculating EM
## 
## mc=4 ##for parallelisation
## 
## CC_Result <- qualityScores_EM(chipName=chipName, 
##     inputName=inputName, 
##     annotationID="hg19",
##     read_length=36, 
##     mc=mc)
## 
## finalTagShift <- CC_Result$QCscores_ChIP$tag.shift


###################################################
### code chunk number 5: ChIC-Vignette.Rnw:225-227 (eval = FALSE)
###################################################
## chipBam <- readBamFile(chipName)
## inputBam <- readBamFile(inputName)


###################################################
### code chunk number 6: ChIC-Vignette.Rnw:242-244
###################################################
mc=2
data("crossvalues_Chip", package = "ChIC.data", envir = environment())


###################################################
### code chunk number 7: ChIC-Vignette.Rnw:248-268
###################################################

cluster <- parallel::makeCluster( mc )

## calculate binding characteristics 

chip_binding.characteristics <- get.binding.characteristics(
    chipBam, 
    srange=c(0,500), 
    bin = 5, 
    accept.all.tags = TRUE, 
    cluster = cluster)

input_binding.characteristics <- get.binding.characteristics(
    inputBam, 
    srange=c(0,500), 
    bin = 5, 
    accept.all.tags = TRUE,
    cluster = cluster)

parallel::stopCluster( cluster )


###################################################
### code chunk number 8: ChIC-Vignette.Rnw:271-279 (eval = FALSE)
###################################################
## 
## ## calculate cross correlation QC-metrics
## crossvalues_Chip <- getCrossCorrelationScores( chipBam , 
##     chip_binding.characteristics, 
##     read_length = 36, 
##     annotationID="hg19",
##     savePlotPath = filepath, 
##     mc = mc)


###################################################
### code chunk number 9: ChIC-Vignette.Rnw:290-291
###################################################
finalTagShift <- crossvalues_Chip$tag.shift


###################################################
### code chunk number 10: ChIC-Vignette.Rnw:309-317
###################################################

##get chromosome information and order chip and input by it
chrl_final <- intersect(names(chipBam$tags), 
    names(inputBam$tags))
chipBam$tags <- chipBam$tags[chrl_final]
chipBam$quality <- chipBam$quality[chrl_final]
inputBam$tags <- inputBam$tags[chrl_final]
inputBam$quality <- inputBam$quality[chrl_final]


###################################################
### code chunk number 11: ChIC-Vignette.Rnw:320-329
###################################################
##remove positions with extremely high read counts with 
##respect to the neighbourhood
selectedTags <- removeLocalTagAnomalies(chipBam, 
    inputBam, 
    chip_binding.characteristics, 
    input_binding.characteristics)

inputBamSelected <- selectedTags$input.dataSelected
chipBamSelected <- selectedTags$chip.dataSelected


###################################################
### code chunk number 12: ChIC-Vignette.Rnw:338-345
###################################################
bindingScores <- getPeakCallingScores(chip = chipBam, 
    input = inputBam, 
    chip.dataSelected = chipBamSelected, 
    input.dataSelected = inputBamSelected, 
    annotationID="hg19",
    tag.shift = finalTagShift, 
    mc = mc)


###################################################
### code chunk number 13: ChIC-Vignette.Rnw:355-361
###################################################
smoothedChip <- tagDensity(chipBamSelected,
    annotationID = "hg19", 
    tag.shift = finalTagShift, mc = mc)
smoothedInput <- tagDensity(inputBamSelected, 
    annotationID = "hg19",
    tag.shift = finalTagShift, mc = mc)


###################################################
### code chunk number 14: ChIC-Vignette.Rnw:386-390 (eval = FALSE)
###################################################
## Ch_Results <- qualityScores_GM(densityChip = smoothedChip,
##     densityInput = smoothedInput, 
##     savePlotPath = filepath)
## str(Ch_Results)


###################################################
### code chunk number 15: Fingerprint (eval = FALSE)
###################################################
## Ch_Results <- qualityScores_GM(densityChip=smoothedChip,
## densityInput=smoothedInput)


###################################################
### code chunk number 16: Fingerprint
###################################################
Ch_Results <- qualityScores_GM(densityChip=smoothedChip,
densityInput=smoothedInput)


###################################################
### code chunk number 17: ChIC-Vignette.Rnw:409-410
###################################################
str(Ch_Results)


###################################################
### code chunk number 18: ChIC-Vignette.Rnw:427-433
###################################################
Meta_Result <- createMetageneProfile(
    smoothed.densityChip = smoothedChip, 
    smoothed.densityInput = smoothedInput, 
    annotationID="hg19",
    tag.shift = finalTagShift, 
    mc = mc)


###################################################
### code chunk number 19: ChIC-Vignette.Rnw:461-463
###################################################
TES_Scores=qualityScores_LM(data=Meta_Result$TES,
    tag="TES")


###################################################
### code chunk number 20: TSS
###################################################
TSS_Scores=qualityScores_LM(data=Meta_Result$TSS, 
    tag="TSS")


###################################################
### code chunk number 21: geneBody
###################################################
geneBody_Scores <- qualityScores_LMgenebody(Meta_Result$geneBody)


###################################################
### code chunk number 22: ChIC-Vignette.Rnw:526-527
###################################################
listAvailableElements(target="H3K36me3")


###################################################
### code chunk number 23: ChIC-Vignette.Rnw:539-540
###################################################
head(listDatasets(dataset="ENCODE"))


###################################################
### code chunk number 24: geneBodyComparison
###################################################

metagenePlotsForComparison(data = Meta_Result$geneBody,
    target = "H3K4me3", 
    tag = "geneBody")
    


###################################################
### code chunk number 25: TSSComparison
###################################################
 
metagenePlotsForComparison(data = Meta_Result$TSS,
    target = "H3K4me3", 
    tag = "TSS")


###################################################
### code chunk number 26: ReferenceDistr
###################################################
plotReferenceDistribution(target = "H3K4me3", 
    metricToBePlotted = "RSC", 
    currentValue = crossvalues_Chip$CC_RSC )


###################################################
### code chunk number 27: ChIC-Vignette.Rnw:652-660
###################################################
EM_scoresNew=NULL

EM_scoresNew$QCscores_ChIP <- crossvalues_Chip
EM_scoresNew$QCscores_binding <- bindingScores
EM_scoresNew$TagDensityInput <- list()
EM_scoresNew$TagDensityChip <-list()

CC_Result <- EM_scoresNew


###################################################
### code chunk number 28: ChIC-Vignette.Rnw:663-670
###################################################
te <- predictionScore(target = "H3K4me3", 
    features_cc = CC_Result,
    features_global = Ch_Results,
    features_TSS = TSS_Scores, 
    features_TES = TES_Scores, 
    features_scaled = geneBody_Scores)
print(te)


