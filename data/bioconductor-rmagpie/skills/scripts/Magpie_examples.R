# Code example from 'Magpie_examples' vignette. See references/ for full tutorial.

### R code from vignette source 'Magpie_examples.Rnw'

###################################################
### code chunk number 1: Load package
###################################################
library(Rmagpie)


###################################################
### code chunk number 2: Create genesubsets fast
###################################################
geneSubsets <- new("geneSubsets", speed="high", maxSubsetSize=20)
geneSubsets


###################################################
### code chunk number 3: Create genesubsets slow
###################################################
geneSubsets <- new("geneSubsets", speed="slow", maxSubsetSize=20)
geneSubsets


###################################################
### code chunk number 4: Gene subsets Option values
###################################################
geneSubsets <- new("geneSubsets", speed="high", optionValues=c(1,2,3,5,9,10,15,20))
geneSubsets


###################################################
### code chunk number 5: Specify thresholds
###################################################
thresholds <- new("thresholds", optionValues=c(0,0.1,0.2,0.3,0.4,0.5,1,2))


###################################################
### code chunk number 6: Load Dataset
###################################################
data('vV70genesDataset')


###################################################
### code chunk number 7: Assessment object One
###################################################
myAssessment <- new ( "assessment",
                        dataset = vV70genes,
                        noFolds1stLayer = 9,
                        noFolds2ndLayer = 10,
                        classifierName = "svm",
                        featureSelectionMethod = 'rfe',
                        typeFoldCreation = "original",
                        svmKernel = "linear",
                        noOfRepeats = 3)
myAssessment


###################################################
### code chunk number 8: Assessment object two
###################################################
myAssessment2 <- new ( "assessment",
                         dataset = vV70genes,
                         noFolds1stLayer = 9,
                         noFolds2ndLayer = 10,
                         classifierName = "nsc",
                         featureSelectionMethod = 'nsc',
                         typeFoldCreation = "original",
                         noOfRepeats = 2)
myAssessment2


###################################################
### code chunk number 9: One layer cross validation
###################################################
# Necessary to find the same results
set.seed(234)
myAssessment <- runOneLayerExtCV(myAssessment)
myAssessment


###################################################
### code chunk number 10: Two layer cross validation
###################################################
myAssessment <- runTwoLayerExtCV(myAssessment)
myAssessment


###################################################
### code chunk number 11: Classify observations
###################################################
myAssessment <- findFinalClassifier(myAssessment)


###################################################
### code chunk number 12: Classify new Samples One
###################################################
newSamplesFile <- system.file(package="Rmagpie","extdata", "vV_newSamples.txt")
res <- classifyNewSamples( myAssessment,newSamplesFile)


###################################################
### code chunk number 13: Good prognois table1
###################################################
library(xtable)
goodPrognosis <-names(res)[res=="goodPronosis"]
goodPrognosis


###################################################
### code chunk number 14: poor prognois table1
###################################################
poorPrognosis <-names(res)[res=="poorPronosis"]
poorPrognosis


###################################################
### code chunk number 15: Classify new Samples two
###################################################
newSamplesFile <- system.file(package="Rmagpie","extdata", "vV_newSamples.txt")
res <- classifyNewSamples( myAssessment,newSamplesFile,optionValue=1)


###################################################
### code chunk number 16: Good prognois table2
###################################################
goodPrognosis <-names(res)[res=="goodPronosis"]
goodPrognosis


###################################################
### code chunk number 17: poor prognois table2
###################################################
poorPrognosis <-names(res)[res=="poorPronosis"]


###################################################
### code chunk number 18: Example One
###################################################
# All the information on error rates for the repeated one-layer CV
getResults(myAssessment, 1, topic='errorRate')
# Cross-validated error rates for the repeated one-layer CV: Une value
# per size of subset
getResults(myAssessment, 1, topic='errorRate', errorType='cv')
# Cross-validated error rates for the repeated two-layer CV: Une value 
# only corresponding to the best error rate
getResults(myAssessment, 2, topic='errorRate', errorType='cv')


###################################################
### code chunk number 19: Example 2
###################################################
# Frequency of the genes selected among the folds and repeats 
# of the one-layer CV
res <- getResults(myAssessment, c(1,1), topic='genesSelected', genesType='frequ')
# Genes selected for the 3rd size of subset in the 2nd fold of the
# second repeat of one-layer external CV
getResults(myAssessment, c(1,2), topic='genesSelected', genesType='fold')[[3]][[2]]


###################################################
### code chunk number 20: Example 3
###################################################
# Best number of genes in one-layer CV
getResults(myAssessment, 1, topic='bestOptionValue')
# Best number of genes in the third repeat of one-layer CV
getResults(myAssessment, c(1,3), topic='bestOptionValue')
# Average (over the folds), best number of genes in the two-layer CV
getResults(myAssessment, 2, topic='bestOptionValue')
# Average (over the folds), best number of genes in the 
# third repeat of the two-layer CV
getResults(myAssessment, c(2,3), topic='bestOptionValue')


###################################################
### code chunk number 21: Example 4
###################################################
# Execution time to compute the repeated one-layer CV
getResults(myAssessment, 1, topic='executionTime')
# Execution time to compute the third repeat of the repeated one-layer CV
getResults(myAssessment, c(1,3), topic='executionTime')
# Execution time to compute the repeated two-layer CV
getResults(myAssessment, 2, topic='executionTime')
# Execution time to compute the second repeat of the repeated two-layer CV
getResults(myAssessment, c(2,2), topic='executionTime')


###################################################
### code chunk number 22: PlotErrorSummary1
###################################################
png("plotErrorsSummaryOneLayerCV.png")
plotErrorsSummaryOneLayerCV(myAssessment)
dev.off()


###################################################
### code chunk number 23: PlotErrorSummaryRepeated
###################################################
png("plotSummaryErrorRate.png")
plotErrorsRepeatedOneLayerCV(myAssessment)
dev.off()


###################################################
### code chunk number 24: Two layer cross validation
###################################################
png("twoLayerCrossValidation.png")
plotErrorsFoldTwoLayerCV(myAssessment)
dev.off()


