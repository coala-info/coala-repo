# Code example from 'ClassifyR' vignette. See references/ for full tutorial.

## ----echo = FALSE, results = "asis"---------------------------------------------------------------------------------------------
options(width = 130)

## ----echo = FALSE---------------------------------------------------------------------------------------------------------------
htmltools::img(src = knitr::image_uri("images/ClassifyRprocedure.png"), 
               style = 'margin-left: auto;margin-right: auto')

## ----message = FALSE------------------------------------------------------------------------------------------------------------
library(ClassifyR)

## ----message = FALSE------------------------------------------------------------------------------------------------------------
data(asthma) # Contains measurements and classes variables.
measurements[1:5, 1:5]
head(classes)

## -------------------------------------------------------------------------------------------------------------------------------
set.seed(9500)

## -------------------------------------------------------------------------------------------------------------------------------
result <- crossValidate(measurements, classes, classifier = "SVM",
                        nFolds = 5, nRepeats = 2, nCores = 1)
performancePlot(result)

## -------------------------------------------------------------------------------------------------------------------------------
measurementsDF <- DataFrame(measurements)
mcols(measurementsDF) <- data.frame(
  assay = rep(c("assay_1", "assay_2"), times = c(10, 1990)),
  feature = colnames(measurementsDF)
)

result <- crossValidate(measurementsDF, classes, classifier = "SVM", nFolds = 5,
                        nRepeats = 3, multiViewMethod = "merge")

performancePlot(result, characteristicsList = list(x = "Assay Name"))

## -------------------------------------------------------------------------------------------------------------------------------
# Assigns first 10 variables to dataset_1, and the rest to dataset_2
measurementsList <- list(
  (measurements |> as.data.frame())[1:10],
  (measurements |> as.data.frame())[11:2000]
)
names(measurementsList) <- c("assay_1", "assay_2")

result <- crossValidate(measurementsList, classes, classifier = "SVM", nFolds = 5,
                        nRepeats = 3, multiViewMethod = "merge")

performancePlot(result, characteristicsList = list(x = "Assay Name"))

## ----eval = FALSE---------------------------------------------------------------------------------------------------------------
# CVparams <- CrossValParams(parallelParams = SnowParam(16, RNGseed = 123))
# CVparams

## -------------------------------------------------------------------------------------------------------------------------------
ModellingParams()

## ----tidy = FALSE---------------------------------------------------------------------------------------------------------------
crossValParams <- CrossValParams(permutations = 5)
DMresults <- runTests(measurements, classes, crossValParams, verbose = 1)

## ----fig.height = 8, fig.width = 8, results = "hold", message = FALSE-----------------------------------------------------------
library(grid)
selectionPercentages <- distribution(DMresults, plot = FALSE)
head(selectionPercentages)
sortedPercentages <- head(selectionPercentages[order(selectionPercentages, decreasing = TRUE)])
head(sortedPercentages)
mostChosen <- sortedPercentages[1]
bestGenePlot <- plotFeatureClasses(measurements, classes, names(mostChosen), dotBinWidth = 0.1,
                                   xAxisLabel = "Normalised Expression")
grid.draw(bestGenePlot[[1]])

## -------------------------------------------------------------------------------------------------------------------------------
DMresults <- calcCVperformance(DMresults)
DMresults
performance(DMresults)

## ----tidy = FALSE---------------------------------------------------------------------------------------------------------------
modellingParamsDD <- ModellingParams(selectParams = SelectParams("KL"),
                                     trainParams = TrainParams("naiveBayes"),
                                     predictParams = NULL)
DDresults <- runTests(measurements, classes, crossValParams, modellingParamsDD, verbose = 1)
DDresults

## ----fig.width = 10, fig.height = 7---------------------------------------------------------------------------------------------
resultsList <- list(Abundance = DMresults, Distribution = DDresults)
samplesMetricMap(resultsList, showXtickLabels = FALSE)

## -------------------------------------------------------------------------------------------------------------------------------
performancePlot(resultsList)

## -------------------------------------------------------------------------------------------------------------------------------
rankingPlot(DDresults, topRanked = 1:100, xLabelPositions = c(1, seq(10, 100, 10)))

## ----fig.height = 5, fig.width = 6----------------------------------------------------------------------------------------------
ROCplot(resultsList, fontSizes = c(24, 12, 12, 12, 12))

## -------------------------------------------------------------------------------------------------------------------------------
tuneList <- list(cost = c(0.01, 0.1, 1, 10))
crossValParams <- CrossValParams(permutations = 5, tuneMode = "Resubstitution")
SVMparams <- ModellingParams(trainParams = TrainParams("SVM", kernel = "linear", tuneParams = tuneList),
                             predictParams = PredictParams("SVM"))
SVMresults <- runTests(measurements, classes, crossValParams, SVMparams)

## -------------------------------------------------------------------------------------------------------------------------------
length(tunedParameters(SVMresults))
tunedParameters(SVMresults)[1:5]

