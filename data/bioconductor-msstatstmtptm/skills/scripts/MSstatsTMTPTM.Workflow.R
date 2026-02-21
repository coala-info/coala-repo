# Code example from 'MSstatsTMTPTM.Workflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=8, 
  fig.height=8
)

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(MSstatsTMTPTM)
library(MSstatsTMT)
library(MSstats)
library(dplyr)

## ---- eval = FALSE------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("MSstatsTMTPTM")

## -----------------------------------------------------------------------------
# read in raw data files
# raw.ptm <- read.csv(file="raw.ptm.csv", header=TRUE)
head(raw.ptm)

## -----------------------------------------------------------------------------
head(raw.protein)
# raw.protein <- read.csv(file="raw.protein.csv", header=TRUE)

## ---- results='hide', message=FALSE, warning=FALSE----------------------------

# Use proteinSummarization function from MSstatsTMT to summarize raw data
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

## ---- results='hide', message=FALSE, warning=FALSE----------------------------

# test for all the possible pairs of conditions
model.results.pairwise <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein)

## ----  message=FALSE, warning=FALSE-------------------------------------------
# Specify comparisons
comparison<-matrix(c(1,0,0,-1,0,0,
                     0,1,0,0,-1,0,
                     0,0,-1,0,0,-1,
                     1,0,-1,0,0,0,
                     0,1,-1,0,0,0,
                     0,0,0,1,0,-1,
                     0,0,0,0,1,-1,
                     .25,.25,-.5,.25,.25,-.5,
                     1/3,1/3,1/3,-1/3,-1/3,-1/3),nrow=9, ncol=6, byrow=TRUE)

# Set the names of each row
row.names(comparison)<-c('1-4', '2-5', '3-6', '1-3', 
                         '2-3', '4-6', '5-6', 'Partial', 'Third')
# Set the column names
colnames(comparison)<- c('Condition_1', 'Condition_2', 'Condition_3', 
                         'Condition_4', 'Condition_5', 'Condition_6')

comparison

## ---- results='hide', message=FALSE, warning=FALSE----------------------------
# test for specified condition comparisons only
model.results.contrast <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein,
                                       contrast.matrix = comparison)


## -----------------------------------------------------------------------------
names(model.results.contrast)
ptm_model <- model.results.contrast[[1]]
protein_model <- model.results.contrast[[2]]
adjusted_model <- model.results.contrast[[3]]

head(adjusted_model)


## -----------------------------------------------------------------------------
groupComparisonPlots(data = adjusted_model,
                     type = 'VolcanoPlot',
                     ProteinName = FALSE,
                     which.Comparison = '1-4',
                     address = FALSE)


## -----------------------------------------------------------------------------
dataProcessPlotsTMTPTM(data.ptm = raw.ptm,
                       data.protein = raw.protein,
                       data.ptm.summarization = quant.msstats.ptm,
                       data.protein.summarization = quant.msstats.protein,
                       type = 'ProfilePlot',
                       which.Protein = 'Protein_2391_Y40',
                       address = FALSE)


## -----------------------------------------------------------------------------
dataProcessPlotsTMTPTM(data.ptm = raw.ptm %>% filter(
  Condition %in% c('Condition_1', 'Condition_4')),
                       data.protein = raw.protein %>% filter(
                         Condition %in% c('Condition_1', 'Condition_4')),
                       data.ptm.summarization = quant.msstats.ptm %>% filter(
                         Condition %in% c('Condition_1', 'Condition_4')),
                       data.protein.summarization = 
    quant.msstats.protein %>% filter(Condition %in% c(
      'Condition_1', 'Condition_4')),
                       type = 'ProfilePlot',
                       which.Protein = 'Protein_2391_Y40',
                       originalPlot = FALSE,
                       address = FALSE)

model_df <- rbind(adjusted_model %>% filter(
  Protein == 'Protein_2391_Y40' & Label == '1-4') %>% select(-Tvalue),
                  ptm_model %>% filter(
                    Protein == 'Protein_2391_Y40' & Label == '1-4'
                    ) %>% select(-issue),
                  protein_model %>% filter(
                    Protein == 'Protein_2391' & Label == '1-4'
                    ) %>% select(-issue))
model_df <- data.frame(model_df)
rownames(model_df) <- c('Adjusted PTM', 'PTM', 'Protein')
model_df

## -----------------------------------------------------------------------------
dataProcessPlotsTMTPTM(data.ptm = raw.ptm %>% filter(
  Condition %in% c('Condition_2', 'Condition_5')),
                       data.protein = raw.protein %>% filter(
                         Condition %in% c('Condition_2', 'Condition_5')),
                       data.ptm.summarization = quant.msstats.ptm %>% 
    filter(Condition %in% c('Condition_2', 'Condition_5')),
                       data.protein.summarization = quant.msstats.protein %>% 
    filter(Condition %in% c('Condition_2', 'Condition_5')),
                       type = 'ProfilePlot',
                       which.Protein = 'Protein_1076_Y67',
                       originalPlot = FALSE,
                       address = FALSE)

model_df <- rbind(adjusted_model %>% filter(
  Protein == 'Protein_1076_Y67' & Label == '2-5') %>% select(-Tvalue),
                  ptm_model %>% filter(
                    Protein == 'Protein_1076_Y67' & Label == '2-5'
                    ) %>% select(-issue),
                  protein_model %>% filter(
                    Protein == 'Protein_1076' & Label == '2-5'
                    ) %>% select(-issue))

model_df <- data.frame(model_df)
rownames(model_df) <- c('Adjusted PTM', 'PTM', 'Protein')
model_df

## ----session------------------------------------------------------------------
sessionInfo()

