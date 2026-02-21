# Code example from 'MSstatsPTM_TMT_Workflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=8, 
  fig.height=8
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(MSstatsPTM)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MSstatsPTM")

## ----summarize, echo=FALSE, message=FALSE, warning=FALSE----------------------

MSstatsPTM.summary <- dataSummarizationPTM_TMT(raw.input.tmt, 
                                               use_log_file = FALSE, 
                                               append = FALSE, verbose = FALSE)

## ----show_summ----------------------------------------------------------------
head(MSstatsPTM.summary$PTM$ProteinLevelData)
head(MSstatsPTM.summary$PROTEIN$ProteinLevelData)

## ----qcplot, message=FALSE, warning=FALSE-------------------------------------

dataProcessPlotsPTM(MSstatsPTM.summary,
                    type = 'QCPLOT',
                    which.PTM = "allonly",
                    address = FALSE)

## ----profileplot, message=FALSE, warning=FALSE--------------------------------
dataProcessPlotsPTM(MSstatsPTM.summary,
                    type = 'PROFILEPLOT',
                    which.Protein = c("Protein_12"),
                    address = FALSE)

## ----model, message=FALSE, warning=FALSE--------------------------------------

# Specify contrast matrix
comparison <- matrix(c(1,0,0,-1,0,0,
                       0,1,0,0,-1,0,
                       0,0,1,0,0,-1,
                       1,0,-1,0,0,0,
                       0,1,-1,0,0,0,
                       0,0,0,1,0,-1,
                       0,0,0,0,1,-1),nrow=7, ncol=6, byrow=TRUE)

# Set the names of each row
row.names(comparison)<-c('1-4', '2-5', '3-6', '1-3', 
                         '2-3', '4-6', '5-6')
colnames(comparison) <- c('Condition_1','Condition_2','Condition_3',
                          'Condition_4','Condition_5','Condition_6')
MSstatsPTM.model <- groupComparisonPTM(MSstatsPTM.summary,
                                       ptm_label_type = "TMT",
                                       protein_label_type = "TMT",
                                       contrast.matrix = comparison,
                                       use_log_file = FALSE, append = FALSE)
head(MSstatsPTM.model$PTM.Model)
head(MSstatsPTM.model$PROTEIN.Model)
head(MSstatsPTM.model$ADJUSTED.Model)

## ----volcano, message=FALSE, warning=FALSE------------------------------------
groupComparisonPlotsPTM(data = MSstatsPTM.model,
                        type = "VolcanoPlot",
                        which.Comparison = c('1-4'),
                        which.PTM = 1:50,
                        address=FALSE)

## ----meatmap, message=FALSE, warning=FALSE------------------------------------
groupComparisonPlotsPTM(data = MSstatsPTM.model,
                        type = "Heatmap",
                        which.PTM = 1:49,
                        address=FALSE)

