# Code example from 'MSstatsTMTPTM' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=6, 
  fig.height=6
)

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(MSstatsTMTPTM)
library(MSstatsTMT)

## ---- eval = FALSE------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("MSstatsTMTPTM")

## -----------------------------------------------------------------------------
# read in raw data files
# raw.ptm <- read.csv(file="raw.ptm.csv", header=TRUE)
# raw.protein <- read.csv(file="raw.protein.csv", header=TRUE)
head(raw.ptm)
head(raw.protein)

## ---- results='hide', message=FALSE, warning=FALSE----------------------------
# Run MSstatsTMT proteinSummarization function
quant.msstats.ptm <- proteinSummarization(raw.ptm,
                                          method = "msstats",
                                          global_norm = TRUE,
                                          reference_norm = FALSE,
                                          MBimpute = TRUE)

quant.msstats.protein <- proteinSummarization(raw.protein,
                                          method = "msstats",
                                          global_norm = TRUE,
                                          reference_norm = FALSE,
                                          MBimpute = TRUE)




## -----------------------------------------------------------------------------
head(quant.msstats.ptm)
head(quant.msstats.protein)

# Profile Plot
dataProcessPlotsTMTPTM(data.ptm=raw.ptm,
                    data.protein=raw.protein,
                    data.ptm.summarization=quant.msstats.ptm,
                    data.protein.summarization=quant.msstats.protein,
                    type='ProfilePlot'
                    )

# Quality Control Plot
# dataProcessPlotsTMTPTM(data.ptm=ptm.input.pd,
#                     data.protein=protein.input.pd,
#                     data.ptm.summarization=quant.msstats.ptm,
#                     data.protein.summarization=quant.msstats.protein,
#                     type='QCPlot')


## ----message = FALSE, warning = FALSE-----------------------------------------
# test for all the possible pairs of conditions
model.results.pairwise <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein)
names(model.results.pairwise)
head(model.results.pairwise[[1]])

# Load specific contrast matrix
#example.contrast.matrix <- read.csv(file="example.contrast.matrix.csv", header=TRUE)
example.contrast.matrix

# test for specified condition comparisons only
model.results.contrast <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein,
                                       contrast.matrix = example.contrast.matrix)

names(model.results.contrast)
head(model.results.contrast[[1]])

## ----session------------------------------------------------------------------
sessionInfo()

