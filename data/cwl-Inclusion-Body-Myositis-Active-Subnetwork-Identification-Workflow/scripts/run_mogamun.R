#!/usr/bin/env Rscript
library(MOGAMUN)

run_mogamun <- function(mogamun_dir, generations = 500, cores = 1, runs = 30,
                        layers = NULL, MinSize = 15, MaxSize = 50){

  parameters <- mogamun_init(Generations = generations, PopSize = 100,
        Measure = "PValue", MinSize = MinSize, MaxSize = MaxSize)

  dePath <- file.path(mogamun_dir, "pvals.csv")
  scoresPath <- file.path(mogamun_dir, "NodeScores.csv")
  layersPath <- file.path(mogamun_dir, "networks/")
  result_dir <- "MOGAMUN_results"

  loadedData <-
    mogamun_load_data(
      EvolutionParameters = parameters,
      DifferentialExpressionPath = dePath,
      NodesScoresPath = scoresPath,
      NetworkLayersDir = layersPath,
      Layers = layers
    )

  mogamun_run(LoadedData = loadedData, ResultsDir = result_dir, Cores = cores, NumberOfRunsToExecute = runs)
}

args <- commandArgs(trailingOnly=TRUE)
run_mogamun(args[1], generations = args[2], runs = args[3], cores = args[4], layers="12")
