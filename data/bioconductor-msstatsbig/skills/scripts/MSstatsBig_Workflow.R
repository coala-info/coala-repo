# Code example from 'MSstatsBig_Workflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----load_package-------------------------------------------------------------
library(MSstatsBig)

## ----example_data-------------------------------------------------------------
head(read.csv(system.file("extdata", "fgexample.csv", package = "MSstatsBig")))

## ----conv_example-------------------------------------------------------------
setwd(tempdir())

converted_data = bigFragPipetoMSstatsFormat(
  system.file("extdata", "fgexample.csv", package = "MSstatsBig"),
  "output_file.csv",
  backend="arrow",
  max_feature_count = 20)

# The returned arrow object needs to be collected for the remaining workflow
converted_data = as.data.frame(dplyr::collect(converted_data))

## ----msstats_workflow---------------------------------------------------------

library(MSstats)

# converted_data = read.csv("output_file.csv")
summarized_data = dataProcess(converted_data,
                              use_log_file = FALSE)

# Build contrast matrix
comparison = matrix(c(-1, 1),
    nrow=1, byrow=TRUE)
row.names(comparison) <- c("T-NAT")
colnames(comparison) <- c("NAT", "T")

model_results = groupComparison(contrast.matrix = comparison, 
                                data = summarized_data,
                                use_log_file = FALSE)



## -----------------------------------------------------------------------------
sessionInfo()

