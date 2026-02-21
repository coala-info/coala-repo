# Code example from 'MOFA_example_simulated' vignette. See references/ for full tutorial.

## ---- message=FALSE--------------------------------------------------------
library(MOFA)

## --------------------------------------------------------------------------
set.seed(1234)
data <- makeExampleData()
MOFAobject <- createMOFAobject(data)
MOFAobject

## --------------------------------------------------------------------------
TrainOptions <- getDefaultTrainOptions()
ModelOptions <- getDefaultModelOptions(MOFAobject)
DataOptions <- getDefaultDataOptions()

TrainOptions$DropFactorThreshold <- 0.01

## --------------------------------------------------------------------------
n_inits <- 3
MOFAlist <- lapply(seq_len(n_inits), function(it) {
  
  TrainOptions$seed <- 2018 + it
  
  MOFAobject <- prepareMOFA(
  MOFAobject, 
  DataOptions = DataOptions,
  ModelOptions = ModelOptions,
  TrainOptions = TrainOptions
)
  
  runMOFA(MOFAobject)
})

## --------------------------------------------------------------------------
compareModels(MOFAlist)

## --------------------------------------------------------------------------
compareFactors(MOFAlist)

## --------------------------------------------------------------------------
MOFAobject <- selectModel(MOFAlist, plotit = FALSE)
MOFAobject

## --------------------------------------------------------------------------
plotVarianceExplained(MOFAobject)

## --------------------------------------------------------------------------
sessionInfo()

