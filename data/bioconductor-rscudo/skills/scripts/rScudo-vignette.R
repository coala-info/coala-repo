# Code example from 'rScudo-vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----message=FALSE------------------------------------------------------------
library(rScudo)
library(ALL)
data(ALL)

bt <- as.factor(stringr::str_extract(pData(ALL)$BT, "^."))

set.seed(123)
inTrain <- caret::createDataPartition(bt, list = FALSE)
trainData <- ALL[, inTrain]
testData <- ALL[, -inTrain]

## -----------------------------------------------------------------------------
trainRes <- scudoTrain(trainData, groups = bt[inTrain], nTop = 100,
    nBottom = 100, alpha = 0.1)
trainRes

## -----------------------------------------------------------------------------
upSignatures(trainRes)[1:5,1:5]
consensusUpSignatures(trainRes)[1:5, ]

## -----------------------------------------------------------------------------
trainNet <- scudoNetwork(trainRes, N = 0.25)
scudoPlot(trainNet, vertex.label = NA)

## ----eval=FALSE---------------------------------------------------------------
# scudoCytoscape(trainNet)

## -----------------------------------------------------------------------------
testRes <- scudoTest(trainRes, testData, bt[-inTrain], nTop = 100,
    nBottom = 100)
testRes

## -----------------------------------------------------------------------------
testNet <- scudoNetwork(testRes, N = 0.25)
scudoPlot(testNet, vertex.label = NA)

## -----------------------------------------------------------------------------
testClust <- igraph::cluster_spinglass(testNet, spins = 2)
plot(testClust, testNet, vertex.label = NA)

## -----------------------------------------------------------------------------
classRes <- scudoClassify(trainData, testData, N = 0.25, nTop = 100,
    nBottom = 100, trainGroups = bt[inTrain], alpha = 0.1)

## -----------------------------------------------------------------------------
caret::confusionMatrix(classRes$predicted, bt[-inTrain])

## -----------------------------------------------------------------------------
isB <- which(as.character(ALL$BT) %in% c("B1", "B2", "B3"))
ALLB <- ALL[, isB]
stage <- ALLB$BT[, drop = TRUE]
table(stage)

## -----------------------------------------------------------------------------
inTrain <- as.vector(caret::createDataPartition(stage, p = 0.6, list = FALSE))

stageRes <- scudoTrain(ALLB[, inTrain], stage[inTrain], 100, 100, 0.01)
stageNet <- scudoNetwork(stageRes, 0.2)
scudoPlot(stageNet, vertex.label = NA)

classStage <- scudoClassify(ALLB[, inTrain], ALLB[, -inTrain], 0.25, 100, 100,
    stage[inTrain], alpha = 0.01)
caret::confusionMatrix(classStage$predicted, stage[-inTrain])

## -----------------------------------------------------------------------------
trainData <- exprs(ALLB[, inTrain])
virtControl <- rowMeans(trainData)
trainDataNorm <- trainData / virtControl
pVals <- apply(trainDataNorm, 1, function(x) {
    stats::kruskal.test(x, stage[inTrain])$p.value})
trainDataNorm <- t(trainDataNorm[pVals <= 0.01, ])

## -----------------------------------------------------------------------------
cl <- parallel::makePSOCKcluster(2)
doParallel::registerDoParallel(cl)

model <- scudoModel(nTop = (2:6)*20, nBottom = (2:6)*20, N = 0.25)
control <- caret::trainControl(method = "cv", number = 5,
    summaryFunction = caret::multiClassSummary)
cvRes <- caret::train(x = trainDataNorm, y = stage[inTrain], method = model,
    trControl = control)

parallel::stopCluster(cl)

classStage <- scudoClassify(ALLB[, inTrain], ALLB[, -inTrain], 0.25,
    cvRes$bestTune$nTop, cvRes$bestTune$nBottom, stage[inTrain], alpha = 0.01)
caret::confusionMatrix(classStage$predicted, stage[-inTrain])

## -----------------------------------------------------------------------------
sessionInfo()

