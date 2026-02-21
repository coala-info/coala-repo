# Code example from 'INSPEcT' vignette. See references/ for full tutorial.

## ----INSPEcT_loading,eval=TRUE,echo=TRUE,message=FALSE,warnings=FALSE---------
library(INSPEcT)

## ----quantifyExpressionsFromBAMs,eval=TRUE,message=FALSE,warnings=FALSE-------

require(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

bamfiles_paths <- system.file('extdata/',
  c('bamRep1.bam','bamRep2.bam','bamRep3.bam','bamRep4.bam'), 
  package='INSPEcT')

exprFromBAM <- quantifyExpressionsFromBAMs(txdb=txdb
           , BAMfiles=bamfiles_paths
           , by = 'gene'
           , allowMultiOverlap = FALSE
           , strandSpecific = 0
           , experimentalDesign=c(0,0,1,1))


## ----quantifyExpressionsFromBAMs2,eval=TRUE,message=TRUE,warnings=FALSE-------

names(exprFromBAM)
exprFromBAM$countsStats


## ----quantifyExpressionsFromCountsNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE----

data('allcounts', package='INSPEcT')
data('featureWidths', package='INSPEcT')
data('libsizes', package='INSPEcT')

nascentCounts<-allcounts$nascent
matureCounts<-allcounts$mature
expDes<-rep(c(0,1/6,1/3,1/2,1,1.5,2,4,8,12,16),3)

nasExp_DESeq2<-quantifyExpressionsFromTrCounts(
        allcounts=nascentCounts
        ,libsize=nascentLS
        ,exonsWidths=exWdths
        ,intronsWidths=intWdths
        ,experimentalDesign=expDes)

matExp_DESeq2<-quantifyExpressionsFromTrCounts(
        allcounts=matureCounts
        ,libsize=totalLS
        ,exonsWidths=exWdths
        ,intronsWidths=intWdths
        ,experimentalDesign=expDes)


## ----createExpressions,eval=TRUE,message=FALSE,warnings=FALSE-----------------
    
trAbundancesFromCounts <- function(counts, widths, libsize)
        t(t(counts/widths)/libsize*10^9)
nascentTrAbundance <- list(
  exonsAbundances=trAbundancesFromCounts(
        nascentCounts$exonsCounts, exWdths, nascentLS),
  intronsAbundances=trAbundancesFromCounts(
        nascentCounts$intronsCounts, intWdths, nascentLS))

## ----quantifyExpressionsFromTrAbundancesNascentTimeCourse,eval=TRUE, message=FALSE,warnings=FALSE----

nasExp_plgem<-quantifyExpressionsFromTrAbundance(
        trAbundaces = nascentTrAbundance
        , experimentalDesign = expDes)

## ----newINSPEcTNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE-------

  tpts<-c(0,1/6,1/3,1/2,1,1.5,2,4,8,12,16)
  tL<-1/6
  nascentInspObj<-newINSPEcT(tpts=tpts
                            ,labeling_time=tL
                            ,nascentExpressions=nasExp_DESeq2
                            ,matureExpressions=matExp_DESeq2)

## ----newINSPEcTNascentTimeCourseShowResults,eval=TRUE,message=FALSE,warnings=FALSE----
  
  round(ratesFirstGuess(nascentInspObj,'total')[1:5,1:3],3)
  round(ratesFirstGuessVar(nascentInspObj,'total')[1:5,1:3],3)
  round(ratesFirstGuess(nascentInspObj,'synthesis')[1:5,1:3],3)


## ----subsetObject,eval=TRUE,message=FALSE,warnings=FALSE----------------------
nascentInspObj10<-nascentInspObj[1:10]

## ----inHeatmapNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE, fig.width=10, fig.height=7, fig.cap="inHeatmap of the ratesFirstGuess. Heatmap representing the concentrations of total RNA, of premature RNA and the first guess of the rates of the RNA life cycle", fig.align="center"----

inHeatmap(nascentInspObj10, clustering=FALSE)

## ----newINSPEcTNascentTimeCourseDDP,eval=TRUE,message=FALSE,warnings=FALSE----

  nascentInspObjDDP<-newINSPEcT(tpts=tpts
                            ,labeling_time=tL
                            ,nascentExpressions=nasExp_DESeq2
                            ,matureExpressions=matExp_DESeq2
                            ,degDuringPulse=TRUE)

## ----firstGuessCompareDDP,eval=TRUE,message=FALSE,warnings=FALSE, fig.width=6, fig.height=6, hold=TRUE, fig.cap="Dotplot of degradation rates calculated with or without the assumption of no degradation during pulse. First guess of the degradation rates was calculated with or without degDuringPulse option. In red is represented the line of equation y = x.", fig.align="center"----

k3 <- ratesFirstGuess(nascentInspObj, 'degradation')
k3ddp <- ratesFirstGuess(nascentInspObjDDP, 'degradation')
plot(rowMeans(k3), rowMeans(k3ddp), log='xy', 
     xlim=c(.2,10), ylim=c(.2,10), 
     xlab='no degradation during pulse',
     ylab='degradation during pulse',
     main='first guess degradation rates')
abline(0,1,col='red')


## ----modelRatesNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE-------
nascentInspObj10<-modelRates(nascentInspObj10, seed=1)

## ----viewModelRatesAndInHeatmapNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE, fig.width=10, fig.height=7, fig.cap="inHeatmap of the rates after the second step of modeling. Heatmap representing the concentrations of total RNA, of premature RNA and the rates of the RNA life cycle after the second step of modeling.", fig.align="center"----
round(viewModelRates(nascentInspObj10, 'synthesis')[1:5,1:3],3)
inHeatmap(nascentInspObj10, type='model', clustering=FALSE)

## ----geneClassNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE--------
head(ratePvals(nascentInspObj10),3)
head(geneClass(nascentInspObj10),3)

## ----plotGeneNascentTimeCourse,eval=TRUE,message=TRUE,warnings=FALSE, fig.width=10, fig.height=3, fig.cap="Plot of a single gene resolved using nascent and total RNA. Plot of concentrations and rates over time for the given gene 101206. Total and nascent RNA were used to resolve the whole set of rates and concentrations.", fig.align="center"----

plotGene(nascentInspObj10, ix="101206")

## ----chi2NascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE, fig.width=6, fig.height=6, hold=TRUE, fig.cap="Histogram of the p-values from the goodness of fit test for modeled genes.", fig.align="center"----

chisq<-chisqmodel(nascentInspObj10)
hist(log10(chisq), main='', xlab='log10 chi-squared p-value')
discard<-which(chisq>1e-2)
featureNames(nascentInspObj10)[discard]
nascentInspObj_reduced<-nascentInspObj10[-discard]  

## ----modelRatesNFNascentTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE-----
nascentInspObj10NF<-nascentInspObj[1:10]
nascentInspObj10NF<-modelRatesNF(nascentInspObj10NF)

## ----geneClassNascentTimeCourseNF,eval=TRUE,message=FALSE,warnings=FALSE------
head(ratePvals(nascentInspObj10NF),3)
head(geneClass(nascentInspObj10NF),3)

## ----plotGeneNascentTimeCourseNF,eval=TRUE,message=TRUE,warnings=FALSE, fig.width=10, fig.height=3, fig.cap="Plot of a single gene resolved using nascent and total RNA. Plot of concentrations and rates over time for the given gene 101206. No assumptions on the functional form of the rate was done in this case to calculate confidence intervals.", fig.align="center"----

plotGene(nascentInspObj10NF, ix="101206")

## ----newINSPEcTTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE--------------
matureInspObj<-newINSPEcT(tpts=tpts
                        ,labeling_time=NULL
                        ,nascentExpressions=NULL
                        ,matureExpressions=matExp_DESeq2)

## ----firstGuessCompare,eval=TRUE,message=FALSE,warnings=FALSE, fig.width=6, fig.height=6, hold=TRUE, fig.cap="Dotplot of synthesis rates calculated with or without nascent RNA. First guess of the synthesis rates calculated on the same set of genes with or without the nascent RNA information. In red is represented the line of equation y = x.", fig.align="center"----

cg <- intersect(featureNames(nascentInspObj), 
                featureNames(matureInspObj))
k1Nascent <- ratesFirstGuess(nascentInspObj[cg,], 'synthesis')
k1Mature <- ratesFirstGuess(matureInspObj[cg,], 'synthesis')
smoothScatter(log10(rowMeans(k1Nascent)), 
              log10(rowMeans(k1Mature)),
              main='synthesis rates',
              xlab='nascent + mature RNA', 
              ylab='mature RNA')
abline(0,1,col='red')

## ----modelRatesMatureTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE--------
matureInspObj10 <- matureInspObj[1:10, ]
matureInspObj10 <- modelRates(matureInspObj10, seed=1)

## ----plotGeneMatureTimeCourse,eval=TRUE,message=TRUE,warnings=FALSE, fig.width=10, fig.height=3, fig.cap="Plot of a single gene resolved using only total RNA. Plot of concentrations and rates over time for the given gene 101206. Only total RNA was used to resolve the whole set of rates and concentrations.", fig.align="center"----
plotGene(matureInspObj10, ix="101206")

## ----modelRatesNFMatureTimeCourse,eval=TRUE,message=FALSE,warnings=FALSE------
matureInspObj10NF<-modelRatesNF(matureInspObj[1:10])

## ----generateSimModel,eval=TRUE,message=FALSE,warnings=FALSE------------------
simRates<-makeSimModel(nascentInspObj, 1000, seed=1)
# table(geneClass(simRates))

## ----simulatedDataNascent,eval=FALSE,message=FALSE,warnings=FALSE-------------
# 
# newTpts <- c(0.00, 0.13, 0.35, 0.69, 1.26, 2.16, 3.63,
#              5.99, 9.82, 16.00)
# nascentSim2replicates<-makeSimDataset(object=simRates
#                                    ,tpts=newTpts
#                                    ,nRep=2
#                                    ,NoNascent=FALSE
#                                    ,seed=1)
# nascentSim2replicates<-modelRates(nascentSim2replicates[1:100]
#                                ,seed=1)
# 
# newTpts <- c(0.00, 0.10, 0.26, 0.49, 0.82, 1.32, 2.06,
#              3.16, 4.78, 7.18, 10.73, 16.00)
# nascentSim3replicates<-makeSimDataset(object=simRates
#                                    ,tpts=newTpts
#                                    ,nRep=3
#                                    ,NoNascent=FALSE
#                                    ,seed=1)
# nascentSim3replicates<-modelRates(nascentSim3replicates[1:100]
#                                ,seed=1)

## ----simulatedData,eval=FALSE,message=FALSE,warnings=FALSE--------------------
# 
# newTpts <- c(0.00, 0.13, 0.35, 0.69, 1.26, 2.16, 3.63,
#              5.99, 9.82, 16.00)
# matureSim2replicates<-makeSimDataset(object=simRates
#                                  ,tpts=newTpts
#                                  ,nRep=2
#                                  ,NoNascent=TRUE
#                                  ,seed=1)
# modelSelection(matureSim2replicates)$thresholds$chisquare <- 1
# matureSim2replicates<-modelRates(matureSim2replicates[1:100]
#                              ,seed=1)
# 
# newTpts <- c(0.00, 0.10, 0.26, 0.49, 0.82, 1.32, 2.06,
#              3.16, 4.78, 7.18, 10.73, 16.00)
# matureSim3replicates<-makeSimDataset(object=simRates
#                                  ,tpts=newTpts
#                                  ,nRep=3
#                                  ,NoNascent=TRUE
#                                  ,seed=1)
# modelSelection(matureSim3replicates)$thresholds$chisquare <- 1
# matureSim3replicates<-modelRates(matureSim3replicates[1:100]
#                              ,seed=1)
# 

## ----ROCs, message=FALSE, warnings=FALSE, eval=TRUE, fig.width=10, fig.height=10, fig.cap="ROC analysis of *INSPEcT* classification. For each rate, *INSPEcT* classification performance is measured in terms of sensitivity, TP / (TP + FN), and specificity, TN / (TN + FP), using a ROC curve analysis; false negatives (FN) represent cases where the rate is identified as constant while it was simulated as varying; false positives (FP) represent cases where *INSPEcT* identified a rate as varying while it was simulated as constant; on the contrary, true positives (TP) and negatives (TN) are cases of correct classification of varying and constant rates, respectively; sensitivity and specificity are computed using increasing thresholds for the Brown method used to combine multiple p-values derived from the log-likelihood ratio tests", fig.align="center"----

data("nascentSim2replicates","nascentSim3replicates",
  "matureSim2replicates","matureSim3replicates",package='INSPEcT')

par(mfrow=c(2,2))
rocCurve(simRates,nascentSim2replicates)
title("2rep. 10t.p. Total and nascent RNA", line=3)

rocCurve(simRates,nascentSim3replicates)
title("3rep. 12t.p. Total and nascent RNA", line=3)

rocCurve(simRates,matureSim2replicates)
title("2rep. 10t.p. Total RNA", line=3)

rocCurve(simRates,matureSim3replicates)
title("3rep. 12t.p. Total RNA", line=3)


## ----ROCsThresholds, message=FALSE, warnings=FALSE, eval=TRUE, fig.width=8, fig.height=4, fig.cap="Effect of chi-squared and Brown tests thresholds in *INSPEcT* classification. Plot of the sensitivity (black curve) and specificity (red curve) that is achieved after performing the log-likelihood ratio and Brown method for combining p-values with selected thresholds; thresholds that can be set for chi-squared test to accept models that will undergo the log-likelihood ratio test and for Brown p-value to assess variability of rates"----

rocThresholds(simRates[1:100],nascentSim2replicates)


## ----makeOscillatorySimModel, message=FALSE, warnings=FALSE, eval=FALSE-------
# oscillatorySimRates<-makeOscillatorySimModel(nascentInspObj, 1000
#       , oscillatoryk3=FALSE, seed=1)
# oscillatorySimRatesK3<-makeOscillatorySimModel(nascentInspObj, 1000
#       , oscillatoryk3=TRUE, k3delay=4, seed=1)

## ----makeOscillatoryDataset, message=FALSE, warnings=FALSE, eval=FALSE--------
# newTpts <- seq(0,48,length.out=13)
# oscillatoryWithNascent<-makeSimDataset(object=oscillatorySimRates
#                                    ,tpts=newTpts
#                                    ,nRep=3
#                                    ,NoNascent=FALSE
#                                    ,seed=1)
# oscillatoryWithNascentK3<-makeSimDataset(object=oscillatorySimRatesK3
#                                    ,tpts=newTpts
#                                    ,nRep=3
#                                    ,NoNascent=FALSE
#                                    ,seed=1)

## ----parameters1, message=FALSE, warnings=FALSE, eval=FALSE-------------------
# nascentInspObj10<-modelRates(nascentInspObj10, nInit=20, nIter=1000)

## ----parameters2, message=FALSE, eval=TRUE------------------------------------
matureInspObj10 <- calculateRatePvals(matureInspObj10, p_goodness_of_fit = .2, p_variability = c(.01,.01,.05))

## ----parameters3, message=TRUE, eval=TRUE-------------------------------------
## modeling
str(modelingParams(matureInspObj10))
## model selection and testing framework
str(modelSelection(matureInspObj10))

## ----steadyStateNascent1, message=FALSE, warnings=FALSE, eval=TRUE------------
conditions <- letters[1:11]
nasSteadyObj <- newINSPEcT(tpts=conditions
                        ,labeling_time=tL
                        ,nascentExpressions=nasExp_DESeq2
                        ,matureExpressions=matExp_DESeq2)

## ----steadyStateNascent2, message=FALSE, warnings=FALSE, eval=TRUE------------

diffrates <- compareSteady(nasSteadyObj[,c(1,11)])

head(round(synthesis(diffrates),2))
head(round(processing(diffrates),2))
head(round(degradation(diffrates),2))

## ----steadyStateNascent3, message=TRUE, eval=TRUE, fig.width=6, fig.height=6, hold=TRUE, fig.cap="Representation of rate geometric mean and variation between conditions. plotMA generated image. Orange triangles correspond to genes whose rates are differentially used between the two conditions, blue cloud correspond to the whole distribution of rates.", fig.align="center"----
plotMA(diffrates, rate='synthesis', padj=1e-3)

## ----steadyStateTotal1, message=FALSE, warnings=FALSE, eval=TRUE--------------
conditions <- letters[1:11]
matureInspObj <- newINSPEcT(tpts=conditions
                           ,matureExpressions=matExp_DESeq2)
matureInspObj<-compareSteadyNoNascent(inspectIds=matureInspObj
                  ,expressionThreshold=0.25
                  ,log2FCThreshold=.5)
regGenes <- PTreg(matureInspObj)
regGenes[1:6,1:5]
table(regGenes, useNA='always')

## ----inspectFromBAM, message=TRUE, warnings=FALSE, eval=TRUE------------------
bamfiles_paths <- system.file('extdata/',
  c('bamRep1.bam','bamRep2.bam','bamRep3.bam','bamRep4.bam'), 
  package='INSPEcT')
annotation_table_TOT<-data.frame(
	condition = c('ctrl','ctrl','treat','treat')
	, total = bamfiles_paths
	)
inspectFromBAM(txdb, annotation_table_TOT, 
							 file=tempfile(fileext = 'rds'))

## ----inspectFromPCR, message=TRUE, warnings=FALSE, eval=TRUE------------------
totalAnnTabPCR <- system.file(package = 'INSPEcT', 'totalAnnTabPCR.csv')
nascentAnnTabPCR <- system.file(package = 'INSPEcT', 'nascentAnnTabPCR.csv')
inspectFromPCR(totalAnnTabPCR, nascentAnnTabPCR, labeling_time=1/6, 
							 file=tempfile(fileext = 'rds'))

## ----r------------------------------------------------------------------------
sessionInfo()

