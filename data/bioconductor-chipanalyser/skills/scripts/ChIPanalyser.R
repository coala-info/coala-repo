# Code example from 'ChIPanalyser' vignette. See references/ for full tutorial.

## ----eval=TRUE, warnings = FALSE, echo=TRUE,message=FALSE---------------------

library(ChIPanalyser)

#Load data
data(ChIPanalyserData)


# Loading DNASequenceSet from BSgenome object
# We recommend using the latest version of the genome 
# Please ensure that all your data is aligned to the same version of the genome

library(BSgenome.Dmelanogaster.UCSC.dm6)

DNASequenceSet <- getSeq(BSgenome.Dmelanogaster.UCSC.dm6)



#Loading Position Frequency Matrix

PFM <- file.path(system.file("extdata",package="ChIPanalyser"),"BEAF-32.pfm")

#Checking if correctly loaded
ls()


## ----eval=TRUE, warnings = FALSE----------------------------------------------
chip <- processingChIP(profile = chip,
                      loci = top,
                      cores = 1)
chip

## ----eval =TRUE---------------------------------------------------------------
# PFMs are automatically converted to PWM when build genomicProfiles
GP <- genomicProfiles(PFM = PFM, PFMFormat = "JASPAR")
GP

## ----eval=FALSE---------------------------------------------------------------
# GP <- genomicProfiles(PWM=PositionWeightMatrix)

## ----eval=TRUE,warnings=FALSE-------------------------------------------------
## surpress dependency warnings
optimal <- suppressWarnings(computeOptimal(genomicProfiles = GP,
                        DNASequenceSet = DNASequenceSet,
                        ChIPScore = chip,
                        chromatinState = Access))

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
 ## Lambda Values
 seq(0.25,5,by=0.25)

 ## Bound Molecule Values
 c(1, 10, 20, 50, 100,
    200, 500,1000,2000, 5000,10000,20000,50000, 100000,
    200000, 500000, 1000000)

## ----eval =T------------------------------------------------------------------
optimalParam <- optimal$Optimal
optimalParam$OptimalParameters

## ----eval=TRUE, warnings = FALSE, fig.width=10, fig.height=8------------------
# Plotting Optimal heat maps
par(oma=c(0,0,3,0))
layout(matrix(1:8,ncol=4, byrow=T),width=c(6,1.5,6,1.5),height=c(1,1))
plotOptimalHeatMaps(optimalParam,layout=FALSE)


## ----eval=TRUE----------------------------------------------------------------
optimalParam <- searchSites(optimal,lambdaPWM = 1.25,BoundMolecules = 10000)

## ----eval=TRUE,fig.width=15, fig.height=8-------------------------------------
plotOccupancyProfile(predictedProfile = optimalParam$ChIPProfiles,
                     ChIPScore = chip,
                     chromatinState = Access,
                     occupancy = optimalParam$Occupancy,
                     goodnessOfFit = optimalParam$goodnessOfFit,
                     geneRef = geneRef)

## ----eval =TRUE---------------------------------------------------------------
## Suggested Parameters to start with.
parameterOptions()

## Changing parameters
PO <- parameterOptions(noiseFilter="sigmoid",chipSd=150,chipMean=150,lociWidth=30000)

## ----eval=FALSE---------------------------------------------------------------
# ## Top 50 loci based on ChIP score
# processingChIP(profile = "/path/to/ChIP",
#                loci = NULL,
#                reduce = 50,
#                parameterOptions = PO)
# 
# ## Top 50 loci ALSO containing peaks
# processingChIP(profile = "/path/to/ChIP",
#                loci = NULL,
#                reduce = 50,
#                peaks = "/path/to/peaks",
#                parameterOptions=PO)
# 
# ## Top 50 loci containing BOTH peaks and Accessible DNA
# processingChIP(profile = "/path/to/ChIP",
#                loci = NULL,
#                reduce = 50,
#                peaks = "/path/to/peaks",
#                chromatinState = "/path/to/chromatinState",
#                parameterOptions = PO)
# 

## ----eval=TRUE----------------------------------------------------------------
str(genomicProfiles())

GP <- genomicProfiles(PFM=PFM, PFMFormat="JASPAR", BPFrequency=DNASequenceSet)
GP

## ----eval=FALSE---------------------------------------------------------------
# ## Parsing pre computed parameters (processingChIP function)
# GP <- genomicProfiles(PFM = PFM,
#                      PFMFormat = "JASPAR",
#                      BPFrequency = DNASequenceSet,
#                      ChIPScore = ChIPScore)
# 
# ## Parsing pre assigned function (parameterOptions)
# parameterOptions <- parameterOptions(lambdaPWM = c(1,2,3),
#                                      boundMolecules = c(5,50,500))
# GP <- genomicProfiles(PFM = PFM,
#                      PFMFormat = "JASPAR",
#                      BPFrequency = DNASequenceSet,
#                      parameterOptions = parameterOptions)
# 
# ## Direct parameter assignement
# 
# GP <- genomicProfiles(PFM = PFM,
#                      PFMFormat = "JASPAR",
#                      BPFrequency = DNASequenceSet,
#                      lambdaPWM = c(1,2,3),
#                      boundMolecules = c(4,500,8000))

## ----eval=FALSE---------------------------------------------------------------
# ## Setting custom parameters
# OP <- parameterOptions(lambdaPWM = seq(1,10,by=0.5),
#                       boundMolecules = seq(1,100000, length.out=20))
# 
# ## Computing ONLY Optimal Parameters and MSE as goodness Of Fit metric
# optimal <- computeOptimal(genomicProfiles = GP,
#                          DNASequenceSet = DNASequenceSet,
#                          ChIPScore = chip,
#                          chromatinState = Access,
#                          parameterOptions = OP,
#                          optimalMethod = "MSE",
#                          returnAll = FALSE)
# 
# ### Computing ONLY Optimal Parameters and using Rank slection method
# optimal <- computeOptimal(genomicProfiles = GP,
#                          DNASequenceSet = DNASequenceSet,
#                          ChIPScore = chip,
#                          chromatinState = Access,
#                          parameterOptions = OP,
#                          optimalMethod = "all",
#                          rank=TRUE)
# 

## ----eval=FALSE---------------------------------------------------------------
# ## Extracted Optimal Parameters
# optimalParam <- optimal$Optimal
# 
# ## Plotting heat maps
# plotOptimalHeatMaps(optimalParam,overlay=TRUE)

## ----eval=TRUE,warnings=FALSE-------------------------------------------------

## Creating genomic Profiles object with PFMs and associated parameters
GP <- genomicProfiles(PFM = PFM,
                      PFMFormat = "JASPAR",
                      BPFrequency = DNASequenceSet,
                      lambdaPWM = 1, 
                      boundMolecules = 58794)

## Computing Genome Wide Score required
GW <- computeGenomeWideScores(genomicProfiles = GP,
                              DNASequenceSet = DNASequenceSet,
                              chromatinState = Access)
GW
## Computing PWM score above threshold
pwm <- computePWMScore(genomicProfiles = GW,
                       DNASequenceSet = DNASequenceSet,
                       loci = chip,
                       chromatinState = Access)
pwm
## Computing Occupancy of sites above threshold

occup <- computeOccupancy(genomicProfiles = pwm)
occup
## Compute ChIP seq like profiles

pred <- computeChIPProfile(genomicProfiles = occup,
                          loci = chip)
pred
## Compute goodness Of Fit of model
accu <- profileAccuracyEstimate(genomicProfiles = pred,
                                ChIPScore = chip)
accu


## ----eval=TRUE,fig.width=12, fig.height=4.5-----------------------------------

plotOccupancyProfile(predictedProfile=pred,
                     ChIPScore=chip,
                     chromatinState=Access,
                     occupancy=occup,
                     goodnessOfFit=accu,
                     geneRef=geneRef)

## ----eval=TRUE,echo=TRUE------------------------------------------------------
parameterOptions()

## ----eval=T, echo=T-----------------------------------------------------------
str(genomicProfiles())

## ----eval=F, echo=T-----------------------------------------------------------
#     ## Accessors and Setters for parameterOptions and genomicProfiles
#     avrageExpPWMScore(obj)
#     backgroundSignal(obj)
#     backgroundSignal(obj)<-value
#     boundMolecules(obj)
#     boundMolecules(obj)<-value
#     BPFrequency(obj)
#     BPFrequency(obj)<-value
#     chipMean(obj)
#     chipMean(obj)<-value
#     chipSd(obj)
#     chipSd(obj)<-value
#     chipSmooth(obj)
#     chipSmooth(obj)<-value
#     DNASequenceLength(obj)
#     drop(obj)
#     lambdaPWM(obj)
#     lambdaPWM(obj)<-value
#     lociWidth(obj)
#     lociWidth(obj)<-value
#     maxPWMScore(obj)
#     maxSignal(obj)
#     maxSignal(obj)<-value
#     minPWMScore(obj)
#     naturalLog(obj)
#     naturalLog(obj)<-value
#     noiseFilter(obj)
#     noiseFilter(obj)<-value
#     noOfSites(obj)
#     noOfSites(obj)<-value
#     PFMFormat(obj)
#     PFMFormat(obj)<-value
#     ploidy(obj)
#     ploidy(obj)<-value
#     PositionFrequencyMatrix(obj)
#     PositionFrequencyMatrix(obj)<-value
#     PositionWeightMatrix(obj)
#     PositionWeightMatrix(obj)<-value
#     profiles(obj)
#     PWMpseudocount(obj)
#     PWMpseudocount(obj)<-value
#     PWMThreshold(obj)
#     PWMThreshold(obj)<-value
#     removeBackground(obj)
#     removeBackground(obj)<-value
#     stepSize(obj)
#     stepSize(obj)<-value
#     strandRule(obj)
#     strandRule(obj)<-value
#     whichstrand(obj)
#     whichstrand(obj)<-value
#     ## ChIPScore slots accessors
#     loci(obj)
#     scores(obj)

## ----eval=T-------------------------------------------------------------------
sessionInfo()

