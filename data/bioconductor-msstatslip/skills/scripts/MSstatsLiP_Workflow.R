# Code example from 'MSstatsLiP_Workflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=8, 
  fig.height=8
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MSstatsLiP")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(MSstatsLiP)
library(tidyverse)
library(data.table)

## -----------------------------------------------------------------------------
## Read in raw data files
head(LiPRawData)
head(TrPRawData)

## -----------------------------------------------------------------------------
## Run converter
MSstatsLiP_data <- SpectronauttoMSstatsLiPFormat(LiPRawData, 
                                      "../inst/extdata/ExampleFastaFile.fasta", 
                                      TrPRawData, use_log_file = FALSE, 
                                      append = FALSE)

head(MSstatsLiP_data[["LiP"]])
head(MSstatsLiP_data[["TrP"]])

## Make conditions match
MSstatsLiP_data[["LiP"]][MSstatsLiP_data[["LiP"]]$Condition == "Control", 
                         "Condition"] = "Ctrl"
MSstatsLiP_data[["TrP"]]$Condition = substr(MSstatsLiP_data[["TrP"]]$Condition, 
  1, nchar(MSstatsLiP_data[["TrP"]]$Condition)-1)


## -----------------------------------------------------------------------------
MSstatsLiP_Summarized <- dataSummarizationLiP(MSstatsLiP_data,
                                              MBimpute = FALSE, 
                                              use_log_file = FALSE, 
                                              append = FALSE)
names(MSstatsLiP_Summarized[["LiP"]])

lip_protein_data <- MSstatsLiP_Summarized[["LiP"]]$ProteinLevelData
trp_protein_data <- MSstatsLiP_Summarized[["TrP"]]$ProteinLevelData

head(lip_protein_data)
head(trp_protein_data)


## -----------------------------------------------------------------------------
trypticHistogramLiP(MSstatsLiP_Summarized, 
                    "../inst/extdata/ExampleFastaFile.fasta",
                    color_scale = "bright",
                    address = FALSE)

## -----------------------------------------------------------------------------
correlationPlotLiP(MSstatsLiP_Summarized, address = FALSE)

## -----------------------------------------------------------------------------
MSstatsLiP_Summarized[["LiP"]]$FeatureLevelData %>% 
  group_by(FEATURE, GROUP) %>% 
  summarize(cv = sd(INTENSITY) / mean(INTENSITY)) %>% 
  ggplot() + geom_violin(aes(x = GROUP, y = cv, fill = GROUP)) + 
  labs(title = "Coefficient of Variation between Condtions", 
       y = "Coefficient of Variation", x = "Conditon")

## -----------------------------------------------------------------------------
## Quality Control Plot
dataProcessPlotsLiP(MSstatsLiP_Summarized,
                    type = 'QCPLOT',
                    which.Peptide = "allonly",
                    address = FALSE)

## -----------------------------------------------------------------------------

dataProcessPlotsLiP(MSstatsLiP_Summarized,
                    type = 'ProfilePlot',
                    which.Peptide = c("P14164_ILQNDLK"),
                    address = FALSE)

## -----------------------------------------------------------------------------

PCAPlotLiP(MSstatsLiP_Summarized,
           bar.plot = FALSE,
           protein.pca = FALSE,
           comparison.pca = TRUE,
           which.comparison = c("Ctrl", "Osmo"),
           address=FALSE)

PCAPlotLiP(MSstatsLiP_Summarized,
           bar.plot = FALSE,
           protein.pca = TRUE,
           comparison.pca = FALSE,
           which.pep = c("P14164_ILQNDLK", "P17891_ALQLINQDDADIIGGRDR"),
           address=FALSE)


## -----------------------------------------------------------------------------

feature_data <- data.table::copy(MSstatsLiP_Summarized$LiP$FeatureLevelData)
data.table::setnames(feature_data, c("PEPTIDE", "PROTEIN"), 
                     c("PeptideSequence", "ProteinName"))
feature_data$PeptideSequence <- substr(feature_data$PeptideSequence, 1, 
                                       nchar(as.character(
                                         feature_data$PeptideSequence)) - 2)

calculateTrypticity(feature_data, "../inst/extdata/ExampleFastaFile.fasta")


MSstatsLiP_Summarized$LiP$FeatureLevelData%>%
  rename(PeptideSequence=PEPTIDE, ProteinName=PROTEIN)%>%
  mutate(PeptideSequence=substr(PeptideSequence, 1, 
                                nchar(as.character(PeptideSequence))-2)
         ) %>% calculateTrypticity("../inst/extdata/ExampleFastaFile.fasta")

  

## -----------------------------------------------------------------------------

MSstatsLiP_model <- groupComparisonLiP(MSstatsLiP_Summarized,
                               fasta = "../inst/extdata/ExampleFastaFile.fasta",
                               use_log_file = FALSE, 
                               append = FALSE)

lip_model <- MSstatsLiP_model[["LiP.Model"]]
trp_model <- MSstatsLiP_model[["TrP.Model"]]
adj_lip_model <- MSstatsLiP_model[["Adjusted.LiP.Model"]]

head(lip_model)
head(trp_model)
head(adj_lip_model)

## Number of significant adjusted lip peptides
adj_lip_model %>% filter(adj.pvalue < .05) %>% nrow()


## -----------------------------------------------------------------------------
groupComparisonPlotsLiP(MSstatsLiP_model, 
                        type = "VolcanoPlot", 
                        address = FALSE)

## -----------------------------------------------------------------------------
groupComparisonPlotsLiP(MSstatsLiP_model,
                        type = "HEATMAP",
                        numProtein=50,
                        address = FALSE)

## -----------------------------------------------------------------------------
StructuralBarcodePlotLiP(MSstatsLiP_model, 
                         "../inst/extdata/ExampleFastaFile.fasta", 
                         model_type = "Adjusted", which.prot = c("P53858"),
                         address = FALSE)


## ----calculate accessibility, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE----

Accessibility = calculateProteolyticResistance(MSstatsLiP_Summarized, 
                                               "../inst/extdata/ExampleFastaFile.fasta", 
                                               differential_analysis = TRUE)

Accessibility$RunLevelData


## ----Barplot of protease resistance of aSynuclein (monomer - M and fibril - F), message=FALSE, warning=FALSE, fig.height=2, fig.width=10,echo=TRUE,include=TRUE----

ResistanceBarcodePlotLiP(Accessibility,
                         "../inst/extdata/ExampleFastaFile.fasta",
                         which.prot = "P14164",
                         which.condition = "Osmo",
                         address = FALSE)

ResistanceBarcodePlotLiP(Accessibility,
                         "../inst/extdata/ExampleFastaFile.fasta",
                         differential_analysis = TRUE,
                         which.prot = "P53858",
                         which.condition = "Osmo",
                         address = FALSE)


