# Code example from 'MOGAMUN_Vignette' vignette. See references/ for full tutorial.

## ----setup, echo = FALSE, include=FALSE---------------------------------------
library(MOGAMUN)

## ----init, echo = TRUE, message = FALSE---------------------------------------
parameters <- mogamun_init(Generations = 1, PopSize = 10)

## ----load, echo = TRUE--------------------------------------------------------
dePath <- system.file("extdata/DE/Sample_DE.csv", package = "MOGAMUN")
scoresPath <-
    system.file("extdata/DE/Sample_NodesScore.csv", package = "MOGAMUN")
layersPath <-
    paste0(system.file("extdata/LayersMultiplex", package = "MOGAMUN"), "/")

loadedData <-
    mogamun_load_data(
        EvolutionParameters = parameters,
        DifferentialExpressionPath = dePath,
        NodesScoresPath = scoresPath,
        NetworkLayersDir = layersPath,
        Layers = "23"
    )

## ----run, echo = TRUE---------------------------------------------------------
mogamun_run(LoadedData = loadedData, ResultsDir = '.')

## ----end, echo = TRUE---------------------------------------------------------
mogamun_postprocess(
    LoadedData = loadedData, 
    ExperimentDir = '.', 
    VisualizeInCytoscape = FALSE
)

