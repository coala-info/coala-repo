# Code example from 'AffiXcan' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressMessages(library(MultiAssayExperiment))
tba <- readRDS(system.file("extdata","training.tba.toydata.rds",
    package="AffiXcan")) ## This is a MultiAssayExperiment object
names(assays(tba))

## -----------------------------------------------------------------------------
assays(tba)$ENSG00000139269.2[1:5,1:4]

## -----------------------------------------------------------------------------
suppressMessages(library(SummarizedExperiment))
load("../data/exprMatrix.RData")
assays(exprMatrix)$values[,1:5]

## -----------------------------------------------------------------------------
load("../data/regionAssoc.RData")
regionAssoc[1:3,]

## -----------------------------------------------------------------------------
load("../data/trainingCovariates.RData")
head(trainingCovariates)

## -----------------------------------------------------------------------------
suppressMessages(library("AffiXcan"))

trainingTbaPaths <- system.file("extdata","training.tba.toydata.rds",
    package="AffiXcan")
data(exprMatrix)
data(regionAssoc)
data(trainingCovariates)
assay <- "values"

training <- affiXcanTrain(exprMatrix=exprMatrix, assay=assay,
    tbaPaths=trainingTbaPaths, regionAssoc=regionAssoc, cov=trainingCovariates,
    varExplained=80, scale=TRUE)

testingTbaPaths <- system.file("extdata","testing.tba.toydata.rds",
    package="AffiXcan")
exprmatrix <- affiXcanImpute(tbaPaths=testingTbaPaths,
    affiXcanTraining=training, scale=TRUE)

grexMatrix <- assays(exprmatrix)$GReX
as.data.frame(grexMatrix)[,1:5]

## -----------------------------------------------------------------------------
trainingTbaPaths <- system.file("extdata","training.tba.toydata.rds",
package="AffiXcan")

data(exprMatrix)
data(regionAssoc)
data(trainingCovariates)

assay <- "values"

training <- affiXcanTrain(exprMatrix=exprMatrix, assay=assay,
tbaPaths=trainingTbaPaths, regionAssoc=regionAssoc, cov=trainingCovariates,
varExplained=80, scale=TRUE, kfold=5)

