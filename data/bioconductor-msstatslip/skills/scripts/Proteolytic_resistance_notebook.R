# Code example from 'Proteolytic_resistance_notebook' vignette. See references/ for full tutorial.

## ----setup--------------------------------------------------------------------
 knitr::opts_chunk$set(include = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MSstatsLiP")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(MSstatsLiP)
library(tidyverse)
library(data.table)
library(gghighlight)

## ----set working drectory, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE, eval = FALSE----
# input_folder=choose.dir(caption="Choose the working directory")
# knitr::opts_knit$set(root.dir = input_folder)

## ----load LiP data, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE, eval = FALSE----
# raw_lip <- read_delim(file=choose.files(caption="Choose LiP dataset"),
#                          delim=",", escape_double = FALSE, trim_ws = TRUE)

## ----load TrP data, eval=FALSE, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE----
# 
# raw_prot <- read_delim(file=choose.files(caption="Choose TrP dataset"),
#                           delim=",", escape_double = FALSE, trim_ws = TRUE)

## ----Adjust aSynuclein nomenclature to match fasta file, eval=TRUE, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE----
raw_lip <- raw_lip %>% mutate_all(funs(ifelse(.=="P37840.1", "P37840", .)))
raw_prot <- raw_prot %>% mutate_all(funs(ifelse(.=="P37840.1", "P37840", .)))

## ----load fasta file, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE, eval = FALSE----
# fasta_file=choose.files(caption = "Choose FASTA file")

## ----include=FALSE------------------------------------------------------------
fasta_file = "../inst/extdata/proteolytic_fasta_data.fasta"

## ----convert to MSstatsLiP format, message=FALSE, warning=FALSE,echo=TRUE,include=TRUE----
msstats_data <- SpectronauttoMSstatsLiPFormat(raw_lip, fasta_file, raw_prot)

## ----find FT peptides, echo=TRUE, message=FALSE, warning=FALSE,include=TRUE----

FullyTrP <- msstats_data[["LiP"]] %>% 
  distinct(ProteinName, PeptideSequence) %>% 
  calculateTrypticity(fasta_file) %>% 
  filter(fully_TRI) %>%
  filter(MissedCleavage == FALSE) %>% 
  select(ProteinName, PeptideSequence, StartPos, EndPos)

## ----select FT peptides in LiP data, echo=TRUE, message=FALSE, warning=FALSE,include=TRUE----
msstats_data[["LiP"]] <- msstats_data[["LiP"]] %>% 
  select(-ProteinName) %>% inner_join(FullyTrP)

## ----select FT peptides in TrP data, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE----
msstats_data[["TrP"]] <- msstats_data[["TrP"]] %>% 
  select(-ProteinName) %>% inner_join(FullyTrP)

## ----Test Condtion nomenclature, echo=TRUE,include=TRUE-----------------------
unique(msstats_data[["LiP"]]$Condition)%in%unique(msstats_data[["TrP"]]$Condition)

## ----Display Condtion nomenclature, echo=TRUE,include=TRUE--------------------
paste("LiP Condition nomenclature:", unique(msstats_data[["LiP"]]$Condition), ",",
      "TrP Condition nomenclature:",unique(msstats_data[["TrP"]]$Condition))

## ----Correct Condition nomenclature, echo=TRUE,include=TRUE-------------------
# msstats_data[["TrP"]] = msstats_data[["TrP"]] %>% 
#   mutate(Condition = case_when(Condition == "Cond1" ~ "cond1",
#                                Condition == "Cond2" ~ "cond2"))

## ----Display BioReplicate nomenclature, echo=TRUE,include=TRUE----------------
paste("LiP BioReplicate nomenclature:", unique(msstats_data[["LiP"]]$BioReplicate), ",",
      "TrP BioReplicate nomenclature:",unique(msstats_data[["TrP"]]$BioReplicate))

## ----Correct replicate nomenclature, echo=TRUE,include=TRUE-------------------
msstats_data[["LiP"]] = msstats_data[["LiP"]] %>% 
  mutate(BioReplicate = paste0(Condition,".",BioReplicate))

msstats_data[["TrP"]] = msstats_data[["TrP"]] %>% 
  mutate(BioReplicate = paste0(Condition,".",BioReplicate))

## ----Display corrected BioReplicate nomenclature, echo=TRUE,include=TRUE------
paste("LiP BioReplicate nomenclature:", unique(msstats_data[["LiP"]]$BioReplicate), ",",
      "TrP BioReplicate nomenclature:",unique(msstats_data[["TrP"]]$BioReplicate))

## ----Data summarization, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE----
MSstatsLiP_Summarized <- dataSummarizationLiP(msstats_data, normalization.LiP = "equalizeMedians")


## ----Inspect summarized data, echo=TRUE,include=TRUE--------------------------
names(MSstatsLiP_Summarized[["LiP"]])

head(MSstatsLiP_Summarized[["LiP"]]$FeatureLevelData)
head(MSstatsLiP_Summarized[["LiP"]]$ProteinLevelData)

head(MSstatsLiP_Summarized[["TrP"]]$FeatureLevelData)
head(MSstatsLiP_Summarized[["TrP"]]$ProteinLevelData)

## ----Save summarized data, echo=TRUE,include=TRUE, eval=FALSE-----------------
# save(MSstatsLiP_Summarized, file = 'MSstatsLiP_summarized.rda')
# load(file = 'MSstatsLiP_summarized.rda')

## ----Modelling, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE----------
MSstatsLiP_model = groupComparisonLiP(MSstatsLiP_Summarized)


## ----Inspect model, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE------
head(MSstatsLiP_model[["LiP.Model"]])
head(MSstatsLiP_model[["TrP.Model"]])

## ----Save model, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE, eval=FALSE----
# save(MSstatsLiP_model, file = 'MSstatsLiP_model.rda')
# load(file = 'MSstatsLiP_model.rda')

## ----calculate accessibility, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE----

Accessibility = calculateProteolyticResistance(MSstatsLiP_Summarized, 
                                               fasta_file, 
                                               differential_analysis = TRUE)

Accessibility$RunLevelData


## ----Barplot of protease resistance of aSynuclein (monomer - M and fibril - F), message=FALSE, warning=FALSE, fig.height=2, fig.width=10,echo=TRUE,include=TRUE----

ResistanceBarcodePlotLiP(Accessibility,
                         fasta_file,
                         which.prot = "P16622",
                         which.condition = "F1",
                         address = FALSE)



## ----Perform Proteolytic resistance differential analysis on Fully tryptic peptides, message=FALSE, warning=FALSE, echo=TRUE,include=TRUE----

Accessibility$groupComparison


## ----Save protection model, echo=TRUE, message=FALSE, warning=FALSE, include=TRUE, eval=FALSE----
# # save(FullyTrp.Model, file = 'Protection_model.rda')
# # load(file = 'Protection_model.rda')

## ----Save output, echo=TRUE,include=TRUE, eval=FALSE--------------------------
# # write.csv(FullyTrp.Model, "Proteolytic_resistance_DA.csv")

## ----Barplot of DA of protease resistance of aSynuclein (monomer - M and fibril - F), message=FALSE, warning=FALSE, fig.height=2, fig.width=10,echo=TRUE,include=TRUE----

ResistanceBarcodePlotLiP(Accessibility,
                         fasta_file,
                         which.prot = "P16622",
                         which.condition = "F1",
                         differential_analysis = TRUE,
                         which.comp = "F1 vs F2",
                         address = FALSE)



