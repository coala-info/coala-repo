# Code example from 'geneClassifiers' vignette. See references/ for full tutorial.

### R code from vignette source 'geneClassifiers.Rnw'

###################################################
### code chunk number 1: geneClassifiers.Rnw:43-44
###################################################
library(geneClassifiers)


###################################################
### code chunk number 2: geneClassifiers.Rnw:70-71
###################################################
showClassifierList()


###################################################
### code chunk number 3: geneClassifiers.Rnw:75-80
###################################################
EMC92Classifier<-getClassifier("EMC92")
EMC92Classifier

HM19Classifier<-getClassifier("HM19")
HM19Classifier


###################################################
### code chunk number 4: geneClassifiers.Rnw:92-93
###################################################
getWeights(EMC92Classifier)[1:10]


###################################################
### code chunk number 5: geneClassifiers.Rnw:97-98
###################################################
getDecisionBoundaries(HM19Classifier)


###################################################
### code chunk number 6: geneClassifiers.Rnw:101-102
###################################################
getEventChain(EMC92Classifier)


###################################################
### code chunk number 7: geneClassifiers.Rnw:112-117
###################################################
library(Biobase)
data(exampleMAS5)
class(exampleMAS5) #an object of class ExpressionSet
dim(exampleMAS5) 
preproc(experimentData(exampleMAS5))


###################################################
### code chunk number 8: geneClassifiers.Rnw:122-124
###################################################
fixedData <- setNormalizationMethod( exampleMAS5, method="MAS5.0", targetValue = 500 )
fixedData


###################################################
### code chunk number 9: geneClassifiers.Rnw:149-154
###################################################
resultsEMC92  <- runClassifier( "EMC92" , fixedData )
resultsUAMS70 <- runClassifier( "UAMS70", fixedData )

resultsEMC92
resultsUAMS70


###################################################
### code chunk number 10: geneClassifiers.Rnw:160-166
###################################################
data.frame(
    "score_EMC92"  = getScores( resultsEMC92 ),
    "class_EMC92"  = getClassifications( resultsEMC92 ),
    "score_UAMS70" = getScores( resultsUAMS70 ),
    "class_UAMS70" = getClassifications( resultsUAMS70 )
)


###################################################
### code chunk number 11: geneClassifiers.Rnw:192-215
###################################################
resultsEMC92.reWeighted <- runClassifier( 
    "EMC92" , 
    fixedData[1:70,] ,
    allow.reweighted=TRUE
)

resultsEMC92.reWeighted

plot(
    x = getScores(resultsEMC92),
    y = getScores(resultsEMC92.reWeighted), 
    xlab = "complete", 
    ylab = "reweighted", 
    main = "EMC92 scores",
    pch = 21,
    bg  ='black'
)
lines(c(-10,10),c(-10,10),col=2,lty=2)
abline(
    v = getDecisionBoundaries( getClassifier( resultsEMC92           )),
    h = getDecisionBoundaries( getClassifier( resultsEMC92.reWeighted)),
    col='red'
)


###################################################
### code chunk number 12: geneClassifiers.Rnw:218-219
###################################################
sessionInfo()


