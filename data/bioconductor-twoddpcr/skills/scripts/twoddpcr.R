# Code example from 'twoddpcr' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("twoddpcr")

## ----eval=FALSE---------------------------------------------------------------
# library(devtools)
# install_github("CRUKMI-ComputationalBiology/twoddpcr")

## ----eval=FALSE---------------------------------------------------------------
# install.packages("</path/to/twoddpcr/>", repos=NULL, type="source")

## ----results="hide", warning=FALSE, message=FALSE-----------------------------
library(twoddpcr)

## -----------------------------------------------------------------------------
plate <- ddpcrPlate(wells=KRASdata)

## ----fig.ext='png'------------------------------------------------------------
dropletPlot(plate)

## ----fig.ext='png'------------------------------------------------------------
heatPlot(plate)

## ----fig.ext='png', fig.width=6, fig.height=5---------------------------------
facetPlot(plate)

## -----------------------------------------------------------------------------
commonClassificationMethod(plate)

## ----fig.ext='png'------------------------------------------------------------
dropletPlot(plate, cMethod="Cluster")

## -----------------------------------------------------------------------------
names(plate)

## ----fig.ext='png'------------------------------------------------------------
dropletPlot(plate[["F03"]], cMethod="Cluster")
dropletPlot(plate[["E04"]], cMethod="Cluster")

## -----------------------------------------------------------------------------
plate <- thresholdClassify(plate, ch1Threshold=6789, ch2Threshold=3000)

## -----------------------------------------------------------------------------
commonClassificationMethod(plate)

## ----fig.ext='png'------------------------------------------------------------
dropletPlot(plate, cMethod="thresholds")

## ----fig.ext='png'------------------------------------------------------------
plate <- kmeansClassify(plate)
commonClassificationMethod(plate)
dropletPlot(plate, cMethod="kmeans")

## ----fig.ext='png'------------------------------------------------------------
dropletPlot(plate[["F03"]], cMethod="kmeans")
dropletPlot(plate[["E04"]], cMethod="kmeans")

## -----------------------------------------------------------------------------
plate <- mahalanobisRain(plate, cMethod="kmeans", maxDistances=3)

## -----------------------------------------------------------------------------
commonClassificationMethod(plate)

## ----fig.ext='png', fig.width=5, fig.height=4---------------------------------
dropletPlot(plate, cMethod="kmeansMahRain")

## -----------------------------------------------------------------------------
plate <- mahalanobisRain(plate, cMethod="kmeans",
                         maxDistances=list(NN=35, NP=35, PN=35, PP=35))
commonClassificationMethod(plate)

## ----fig.ext='png', fig.width=5, fig.height=4---------------------------------
dropletPlot(plate, cMethod="kmeansMahRain")

## ----fig.ext='png', fig.width=5, fig.height=4---------------------------------
kmeansMahRainSummary <- plateSummary(plate, cMethod="kmeansMahRain")
head(kmeansMahRainSummary)

## -----------------------------------------------------------------------------
inputNg <- c(rep(64, 3), rep(16, 3), rep(4, 3), rep(1, 3))
mtConcentrations <-
  data.frame(
    x=inputNg,
    Cluster=plateSummary(plate, cMethod="Cluster")$MtConcentration, 
    kmeans=plateSummary(plate, cMethod="kmeans")$MtConcentration, 
    kmeansMahRain=kmeansMahRainSummary$MtConcentration)
knitr::kable(mtConcentrations)

## ----fig.width=9, fig.height=3.5----------------------------------------------
library(ggplot2)
library(reshape2)
mtConcentrationsLong <- melt(mtConcentrations, id.vars=c("x"))
ggplot(mtConcentrationsLong, aes_string("x", "value")) +
  geom_point() + geom_smooth(method="lm") + facet_wrap(~variable)

## -----------------------------------------------------------------------------
bioradLmSummary <- summary(lm(x ~ Cluster, data=mtConcentrations))
kmLmSummary <- summary(lm(x ~ kmeans, data=mtConcentrations))
kmMahRainLmSummary <- summary(lm(x ~ kmeansMahRain, data=mtConcentrations))
knitr::kable(c("Cluster"=bioradLmSummary$r.squared,
               "kmeans"=kmLmSummary$r.squared,
               "kmeansMahRain"=kmMahRainLmSummary$r.squared))

## -----------------------------------------------------------------------------
trainWells <- plate[c("E03", "A04")]
trainPlate <- ddpcrPlate(wells=trainWells)

## ----fig.ext='png'------------------------------------------------------------
trainPlate <- kmeansClassify(trainPlate)
dropletPlot(trainPlate, cMethod="kmeans")

## ----fig.ext='png', fig.width=5, fig.height=4---------------------------------
trainPlate <- mahalanobisRain(trainPlate, cMethod="kmeans", maxDistances=3)
dropletPlot(trainPlate, cMethod="kmeansMahRain")

## -----------------------------------------------------------------------------
trainSet <- removeDropletClasses(trainPlate, cMethod="kmeansMahRain")
trainSet <- do.call(rbind, trainSet)
colnames(trainSet)

## -----------------------------------------------------------------------------
table(trainSet$kmeansMahRain)

## -----------------------------------------------------------------------------
trainAmplitudes <- trainSet[, c("Ch1.Amplitude", "Ch2.Amplitude")]
trainCl <- trainSet$kmeansMahRain
plate <- knnClassify(plate, trainData=trainAmplitudes, cl=trainCl, k=3)

## -----------------------------------------------------------------------------
commonClassificationMethod(plate)

## ----fig.ext='png'------------------------------------------------------------
dropletPlot(plate, cMethod="knn")

## -----------------------------------------------------------------------------
plate <- gridClassify(plate,
                      ch1NNThreshold=6500, ch2NNThreshold=2110,
                      ch1NPThreshold=5765, ch2NPThreshold=5150,
                      ch1PNThreshold=8550, ch2PNThreshold=2450,
                      ch1PPThreshold=6700, ch2PPThreshold=3870)
dropletPlot(plate, cMethod="grid")

## -----------------------------------------------------------------------------
plate <- sdRain(plate, cMethod="kmeans")
dropletPlot(plate, cMethod="kmeansSdRain")

## -----------------------------------------------------------------------------
plate <- sdRain(plate, cMethod="kmeans",
                errorLevel=list(NN=5, NP=5, PN=3, PP=3))
dropletPlot(plate, cMethod="kmeansSdRain")

## ----eval=FALSE---------------------------------------------------------------
# allDrops <- amplitudes(plate)
# allDrops <- do.call(rbind, amplitudes)

## ----eval=FALSE---------------------------------------------------------------
# allDrops$class <- someClassificationMethod(allDrops)

## ----eval=FALSE---------------------------------------------------------------
# plateClassification(plate, cMethod="nameOfCMethod") <- allDrops$class

## ----eval=FALSE---------------------------------------------------------------
# relabelClasses(allDrops, classCol="class")

## ----eval=FALSE---------------------------------------------------------------
# relabelClasses(allDrops, classCol="class", presentClasses=c("NN", "NP", "PN"))

## ----eval=FALSE---------------------------------------------------------------
# shinyVisApp()

## ----eval=FALSE---------------------------------------------------------------
# library(shiny)
# library(twoddpcr)
# 
# # Disable warnings.
# options(warn=-1)
# 
# shiny::shinyApp(
#   ui=shinyVisUI(),
#   server=function(input, output, session)
#   {
#     shinyVisServer(input, output, session)
#   }
# )

## ----eval=FALSE---------------------------------------------------------------
# plate <- ddpcrPlate(well="data/amplitudes")

## -----------------------------------------------------------------------------
citation("twoddpcr")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

