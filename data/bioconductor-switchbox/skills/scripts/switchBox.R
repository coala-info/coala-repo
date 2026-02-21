# Code example from 'switchBox' vignette. See references/ for full tutorial.

### R code from vignette source 'switchBox.Rnw'

###################################################
### code chunk number 1: start
###################################################
options(width=85)
options(continue=" ")
rm(list=ls())


###################################################
### code chunk number 2: switchBox.Rnw:182-185 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("switchBox")


###################################################
### code chunk number 3: switchBox.Rnw:189-190
###################################################
require(switchBox)


###################################################
### code chunk number 4: trainData
###################################################
### Load the example data for the TRAINING set
data(trainingData)


###################################################
### code chunk number 5: switchBox.Rnw:216-219
###################################################
class(matTraining)
dim(matTraining)
str(matTraining)


###################################################
### code chunk number 6: switchBox.Rnw:225-227
###################################################
### Show group variable for the TRAINING set
table(trainingGroup)


###################################################
### code chunk number 7: testData
###################################################
### Load the example data for the TEST set
data(testingData)


###################################################
### code chunk number 8: switchBox.Rnw:249-252
###################################################
class(matTesting)
dim(matTesting)
str(matTesting)


###################################################
### code chunk number 9: switchBox.Rnw:258-260
###################################################
### Show group variable for the TEST set
table(testingGroup)


###################################################
### code chunk number 10: switchBox.Rnw:285-293
###################################################
### The arguments to the "SWAP.Train.KTSP" function
args(SWAP.Train.KTSP)
### Train a classifier using default filtering function based on the Wilcoxon test
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup, krange=c(3:15))
### Show the classifier
classifier
### Extract the TSP from the classifier
classifier$TSPs


###################################################
### code chunk number 11: switchBox.Rnw:304-309
###################################################
### The arguments to the "SWAP.Train.KTSP" function
args(SWAP.Filter.Wilcoxon)
### Retrieve the top best 4 genes using default Wilcoxon filtering
### Note that there are ties
SWAP.Filter.Wilcoxon(trainingGroup, matTraining, featureNo=4)


###################################################
### code chunk number 12: switchBox.Rnw:316-322
###################################################
### Train a classifier from the top 4 best genes 
### according to Wilcoxon filtering function
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup,
			      FilterFunc=SWAP.Filter.Wilcoxon, featureNo=4)
### Show the classifier
classifier


###################################################
### code chunk number 13: switchBox.Rnw:328-332
###################################################
### To use all features "FilterFunc" must be set to NULL
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup, FilterFunc=NULL)
### Show the classifier
classifier


###################################################
### code chunk number 14: switchBox.Rnw:351-354
###################################################
### An alternative filtering function selecting 20 random features
random10 <- function(situation, data) { sample(rownames(data), 10) }
random10(trainingGroup, matTraining)


###################################################
### code chunk number 15: switchBox.Rnw:362-369
###################################################
### An alternative filtering function based on a t-test
topRttest <- function(situation, data, quant = 0.75) {
	out <- apply(data, 1, function(x, ...) t.test(x ~ situation)$statistic )
	names(out[ abs(out) > quantile(abs(out), quant) ])
}
### Show the top 5% features using the newly defined filtering function
topRttest(trainingGroup, matTraining, quant=0.95)


###################################################
### code chunk number 16: switchBox.Rnw:377-382
###################################################
### Train with t-test and krange
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup,
			      FilterFunc = topRttest, quant = 0.9, krange=c(15:30) )
### Show the classifier
classifier


###################################################
### code chunk number 17: switchBox.Rnw:405-409
###################################################
set.seed(123)
somePairs <- matrix(sample(rownames(matTraining), 6^2, replace=FALSE), ncol=2)
head(somePairs)
dim(somePairs)


###################################################
### code chunk number 18: switchBox.Rnw:416-421
###################################################
### Train
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup,
			      RestrictedPairs = somePairs, krange=3:16)
### Show the classifier
classifier


###################################################
### code chunk number 19: switchBox.Rnw:429-436
###################################################
### Train
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup,
			      RestrictedPairs = somePairs,
			      FilterFunc = topRttest, quant = 0.3,
			      krange=c(3:10) )
### Show the classifier
classifier


###################################################
### code chunk number 20: switchBox.Rnw:459-472
###################################################
### Train a classifier
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup,
			      FilterFunc = NULL, krange=2:8)
### Compute the statistics using the default parameters:
### counting the signed TSP votes
ktspStatDefault <- SWAP.KTSP.Statistics(inputMat = matTraining,
    classifier = classifier)
### Show the components in the output
names(ktspStatDefault)
### Show some of the votes
head(ktspStatDefault$comparisons[ , 1:2])
### Show default statistics
head(ktspStatDefault$statistics)


###################################################
### code chunk number 21: switchBox.Rnw:478-483
###################################################
### Compute
ktspStatSum <- SWAP.KTSP.Statistics(inputMat = matTraining,
    classifier = classifier, CombineFunc=sum)
### Show statistics obtained using the sum
head(ktspStatSum$statistics)


###################################################
### code chunk number 22: switchBox.Rnw:489-494
###################################################
### Compute
ktspStatThreshold <- SWAP.KTSP.Statistics(inputMat = matTraining,
    classifier = classifier,  CombineFunc = function(x) sum(x) > 2 )
### Show statistics obtained using the threshold
head(ktspStatThreshold$statistics)


###################################################
### code chunk number 23: switchBox.Rnw:502-507 (eval = FALSE)
###################################################
## ### Make a heatmap showing the individual TSPs votes
## colorForRows <- as.character(1+as.numeric(trainingGroup))
## heatmap(1*ktspStatThreshold$comparisons, scale="none",
##     margins = c(10, 5), cexCol=0.5, cexRow=0.5,
##     labRow=trainingGroup, RowSideColors=colorForRows)


###################################################
### code chunk number 24: fig1
###################################################
### Make a heatmap showing the individual TSPs votes
colorForRows <- as.character(1+as.numeric(trainingGroup))
heatmap(1*ktspStatThreshold$comparisons, scale="none",
    margins = c(10, 5), cexCol=0.85, cexRow=1,
    labRow=trainingGroup, RowSideColors=colorForRows)


###################################################
### code chunk number 25: switchBox.Rnw:542-550
###################################################
### Show the classifier
classifier
### Apply the classifier to the TRAINING set
trainingPrediction <- SWAP.KTSP.Classify(matTraining, classifier)
### Show
str(trainingPrediction)
### Resubstitution performance in the TRAINING set
table(trainingPrediction, trainingGroup)


###################################################
### code chunk number 26: switchBox.Rnw:562-569
###################################################
### Usr a CombineFunc based on  sum(x) > 5.5
trainingPrediction <- SWAP.KTSP.Classify(matTraining, classifier,
					 DecisionFunc = function(x) sum(x) > 5.5 )
### Show
str(trainingPrediction)
### Resubstitution performance in the TRAINING set
table(trainingPrediction, trainingGroup)


###################################################
### code chunk number 27: switchBox.Rnw:578-582
###################################################
### Classify one sample
testPrediction <- SWAP.KTSP.Classify(matTesting[ , 1, drop=FALSE], classifier)
### Show
testPrediction


###################################################
### code chunk number 28: switchBox.Rnw:590-596
###################################################
### Apply the classifier to the complete TEST set
testPrediction <- SWAP.KTSP.Classify(matTesting, classifier)
### Show
table(testPrediction)
### Resubstitution performance in the TEST set
table(testPrediction, testingGroup)


###################################################
### code chunk number 29: switchBox.Rnw:605-610
###################################################
### APlly the classifier using sum(x)  > 5.5
testPrediction <- SWAP.KTSP.Classify(matTesting, classifier,
				     DecisionFunc = function(x) sum(x) > 5.5 )
### Resubstitution performance in the TEST set
table(testPrediction, testingGroup)


###################################################
### code chunk number 30: switchBox.Rnw:627-632
###################################################
### Compute the scores using all features for all possible pairs
scores <- SWAP.CalculateSignedScore(matTraining,  trainingGroup, FilterFunc=NULL)
### Show scores
class(scores)
dim(scores$score)


###################################################
### code chunk number 31: switchBox.Rnw:639-643
###################################################
### Get the scores
scoresOfInterest <- diag(scores$score[ classifier$TSPs[,1] , classifier$TSPs[,2] ])
### Their absolute value should corresponf to the scores returned by SWAP.Train.KTSP
all(classifier$score == abs(scoresOfInterest))


###################################################
### code chunk number 32: switchBox.Rnw:653-664
###################################################
### Compute the scores with default filtering function
scores <- SWAP.CalculateSignedScore(matTraining, trainingGroup, featureNo=20 )
### Show scores
dim(scores$score)
### Compute the scores without the default filtering function
### and using restricted pairs
scores <- SWAP.CalculateSignedScore(matTraining, trainingGroup,
				    FilterFunc = NULL, RestrictedPairs = somePairs )
### Show scores
class(scores$score)
length(scores$score)


###################################################
### code chunk number 33: switchBox.Rnw:671-672 (eval = FALSE)
###################################################
## hist(scores$score, col="salmon", main="TSP scores")


###################################################
### code chunk number 34: fig2
###################################################
hist(scores$score, col="salmon", main="TSP scores")


###################################################
### code chunk number 35: switchBox.Rnw:705-712
###################################################
### Phenotypic group variable for the 78 samples
table(trainingGroup)
levels(trainingGroup)
### Turn into a numeric vector with values equal to 0 and 1
trainingGroupNum <- as.numeric(trainingGroup) - 1
### Show group variable for the TRAINING set
table(trainingGroupNum)


###################################################
### code chunk number 36: switchBox.Rnw:717-721
###################################################
### Train a classifier using default filtering function based on the Wilcoxon test
classifier <- KTSP.Train(matTraining, trainingGroupNum, n=8)
### Show the classifier
classifier


###################################################
### code chunk number 37: switchBox.Rnw:727-733
###################################################
### Apply the classifier to one sample of the TEST set using
### sum of votes less  than 2.5
trainPrediction <- KTSP.Classify(matTraining, classifier,
				 combineFunc = function(x) sum(x) < 2.5)
### Contingency table
table(trainPrediction, trainingGroupNum)


###################################################
### code chunk number 38: switchBox.Rnw:741-748
###################################################
### Phenotypic group variable for the 307 samples
table(testingGroup)
levels(testingGroup)
### Turn into a numeric vector with values equal to 0 and 1
testingGroupNum <- as.numeric(testingGroup) - 1
### Show group variable for the TEST set
table(testingGroupNum)


###################################################
### code chunk number 39: switchBox.Rnw:755-763
###################################################
### Apply the classifier to one sample of the TEST set using
### sum of votes less than 2.5
testPrediction <- KTSP.Classify(matTesting, classifier,
     combineFunc = function(x) sum(x) < 2.5)
### Show prediction
table(testPrediction)
### Contingency table
table(testPrediction, testingGroupNum)


###################################################
### code chunk number 40: sessioInfo
###################################################
toLatex(sessionInfo())


