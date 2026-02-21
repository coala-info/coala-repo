# Code example from 'pwrEWAS' vignette. See references/ for full tutorial.

## ----install, warning=FALSE, message=FALSE, eval=FALSE---------------------
#  if (!requireNamespace("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install("pwrEWAS")

## ----library, warning=FALSE, message=FALSE, eval=TRUE----------------------
library("pwrEWAS")

## ----usage, warning=FALSE, message=FALSE, eval=TRUE, results="hide"--------
# providing the targeted maximal difference in DNAm
results_targetDelta <- pwrEWAS(minTotSampleSize = 10,
    maxTotSampleSize = 50,
    SampleSizeSteps = 10,
    NcntPer = 0.5,
    targetDelta = c(0.2, 0.5),
    J = 100,
    targetDmCpGs = 10,
    tissueType = "Adult (PBMC)",
    detectionLimit = 0.01,
    DMmethod = "limma",
    FDRcritVal = 0.05,
    core = 4,
    sims = 50)

# providing the targeted maximal difference in DNAm
results_deltaSD <- pwrEWAS(minTotSampleSize = 10,
    maxTotSampleSize = 50,
    SampleSizeSteps = 10,
    NcntPer = 0.5,
    deltaSD = c(0.02, 0.05),
    J = 100,
    targetDmCpGs = 10,
    tissueType = "Adult (PBMC)",
    detectionLimit = 0.01,
    DMmethod = "limma",
    FDRcritVal = 0.05,
    core = 4,
    sims = 50)


## ----example running pwrEWAS targetDelta, warning=FALSE, message=FALSE, eval=FALSE, results="hide"----
#  library(pwrEWAS)
#  set.seed(1234)
#  results_targetDelta <- pwrEWAS(minTotSampleSize = 20,
#      maxTotSampleSize = 260,
#      SampleSizeSteps = 40,
#      NcntPer = 0.5,
#      targetDelta = c(0.02, 0.10, 0.15, 0.20),
#      J = 100000,
#      targetDmCpGs = 2500,
#      tissueType = "Blood adult",
#      detectionLimit = 0.01,
#      DMmethod = "limma",
#      FDRcritVal = 0.05,
#      core = 4,
#      sims = 50)
#  
#  results_deltaSD <- pwrEWAS(minTotSampleSize = 20,
#      maxTotSampleSize = 260,
#      SampleSizeSteps = 40,
#      NcntPer = 0.5,
#      deltaSD = c(0.00390625, 0.02734375, 0.0390625, 0.052734375),
#      J = 100000,
#      targetDmCpGs = 2500,
#      tissueType = "Blood adult",
#      detectionLimit = 0.01,
#      DMmethod = "limma",
#      FDRcritVal = 0.05,
#      core = 4,
#      sims = 50)
#  

## ----echo=FALSE, results='hide',message=FALSE------------------------------
load("vignette_reduced.Rdata")

## ----example running pwrEWAS targetDelta time stamps, warning=FALSE, message=FALSE, eval=TRUE----
## [2019-02-12 18:40:23] Finding tau...done [2019-02-12 18:42:53]
## [1] "The following taus were chosen: 0.00390625, 0.02734375, 0.0390625, 0.052734375"
## [2019-02-12 18:42:53] Running simulation
## |===================================================================| 100%
## [2019-02-12 18:42:53] Running simulation ... done [2019-02-12 19:27:03]

## ----example results_targetDelta str, warning=FALSE, message=FALSE, eval=TRUE----
attributes(results_targetDelta)
## $names
## [1] "meanPower" "powerArray" "deltaArray" "metric"

## ----example results_targetDeltaput mean power, warning=FALSE, message=FALSE, eval=TRUE----
dim(results_targetDelta$meanPower)
print(results_targetDelta$meanPower)

## ----example power plot, warning=FALSE, message=FALSE, eval=TRUE-----------
dim(results_targetDelta$powerArray) # simulations x sample sizes x effect sizes
pwrEWAS_powerPlot(results_targetDelta$powerArray, sd = FALSE)

## ----example max delta, warning=FALSE, message=FALSE, eval=FALSE-----------
#  # maximum value of simulated differences by target value
#  lapply(results_targetDelta$deltaArray, max)
#  ## $`0.02`
#  ## [1] 0.02095302
#  ##
#  ## $`0.1`
#  ## [1] 0.1265494
#  ##
#  ## $`0.15`
#  ## [1] 0.2045638
#  ##
#  ## $`0.2`
#  ## [1] 0.2458416
#  
#  # percentage of simulated differences to be within the target range
#  mean(results _ targetDelta$deltaArray[[1]] < 0.02)
#  ## [1] 0.9999999
#  mean(results _ targetDelta$deltaArray[[2]] < 0.10)
#  ## [1] 0.9998882
#  mean(results _ targetDelta$deltaArray[[3]] < 0.15)
#  ## [1] 0.9999386
#  mean(results _ targetDelta$deltaArray[[4]] < 0.20)
#  ## [1] 0.9999539

## ----example density plot, warning=FALSE, message=FALSE, eval=FALSE--------
#  pwrEWAS_deltaDensity(results_targetDelta$deltaArray, detectionLimit = 0.01, sd = FALSE)

## ----example density plot w/o 0.02, warning=FALSE, message=FALSE, eval=FALSE----
#  temp <- results_targetDelta$deltaArray
#  temp[[1]] <- NULL
#  pwrEWAS_deltaDensity(temp, detectionLimit = 0.01, sd = FALSE)

## ----example metrics, warning=FALSE, message=FALSE, eval=TRUE--------------
results_targetDelta$metric

## ----sessionInfo, results='asis', echo=TRUE--------------------------------
toLatex(sessionInfo())

