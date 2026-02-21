# Code example from 'MSstatsPTM_LabelFree_Workflow' vignette. See references/ for full tutorial.

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
# BiocManager::install("MSstatsPTM")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(MSstatsPTM)
library(MSstats)

## ----maxq, eval=TRUE----------------------------------------------------------
# TMT experiment
head(maxq_tmt_evidence)
head(maxq_tmt_annotation)
 
msstats_format_tmt = MaxQtoMSstatsPTMFormat(evidence=maxq_tmt_evidence,
                                    annotation=maxq_tmt_annotation,
                                    fasta=system.file("extdata", 
                                                      "maxq_tmt_fasta.fasta", 
                                                      package="MSstatsPTM"),
                                    fasta_protein_name="uniprot_ac",
                                    mod_id="\\(Phospho \\(STY\\)\\)",
                                    use_unmod_peptides=TRUE,
                                    labeling_type = "TMT",
                                    which_proteinid_ptm = "Proteins")

head(msstats_format_tmt$PTM)
head(msstats_format_tmt$PROTEIN)

# LF experiment
head(maxq_lf_evidence)
head(maxq_lf_annotation)

msstats_format_lf = MaxQtoMSstatsPTMFormat(evidence=maxq_lf_evidence,
                                     annotation=maxq_lf_annotation,
                                     fasta=system.file("extdata", 
                                                       "maxq_lf_fasta.fasta", 
                                                       package="MSstatsPTM"),
                                     fasta_protein_name="uniprot_ac",
                                     mod_id="\\(Phospho \\(STY\\)\\)",
                                     use_unmod_peptides=TRUE,
                                     labeling_type = "LF",
                                     which_proteinid_ptm = "Proteins")

head(msstats_format_lf$PTM)
head(msstats_format_lf$PROTEIN)


## ----fragpipe, eval=TRUE------------------------------------------------------
# TMT example
head(fragpipe_input)
head(fragpipe_annotation)
head(fragpipe_input_protein)
head(fragpipe_annotation_protein)

msstats_data = FragPipetoMSstatsPTMFormat(fragpipe_input,
                                          fragpipe_annotation,
                                          fragpipe_input_protein, 
                                          fragpipe_annotation_protein,
                                          mod_id_col = "STY",
                                          localization_cutoff=.75,
                                          remove_unlocalized_peptides=TRUE)
head(msstats_data$PTM)
head(msstats_data$PROTEIN)

# LFQ Example
input = system.file("tinytest/raw_data/Fragpipe/MSstats.csv", 
                                        package = "MSstatsPTM")
input = data.table::fread(input)
annot = system.file("tinytest/raw_data/Fragpipe/experiment_annotation.tsv", 
                                        package = "MSstatsPTM")
annot = data.table::fread(annot)    
input_protein = system.file("tinytest/raw_data/Fragpipe/msstats_proteome_lf.csv",
                                        package = "MSstatsPTM")

input_protein = data.table::fread(input_protein) # Global profiling run

msstats_data = FragPipetoMSstatsPTMFormat(input,
                                          annot,
                                          input_protein = input_protein,
                                          label_type="LF",
                                          mod_id_col = "STY",
                                          localization_cutoff=.75,
                                          protein_id_col = "ProteinName",
                                          peptide_id_col = "PeptideSequence")
head(msstats_data$PTM)
head(msstats_data$PROTEIN)

## ----pd, eval=TRUE------------------------------------------------------------
head(pd_psm_input)
head(pd_annotation)

msstats_format = PDtoMSstatsPTMFormat(pd_psm_input, 
                                 pd_annotation, 
                                 system.file("extdata", "pd_fasta.fasta", 
                                             package="MSstatsPTM"),
                                 use_unmod_peptides=TRUE, 
                                 which_proteinid = "Master.Protein.Accessions")

head(msstats_format$PTM)
head(msstats_format$PROTEIN)

## ----Spectronaut, eval=TRUE---------------------------------------------------
head(spectronaut_input)
head(spectronaut_annotation)

msstats_input = SpectronauttoMSstatsPTMFormat(spectronaut_input, 
                  annotation=spectronaut_annotation, 
                  fasta_path=system.file("extdata", "spectronaut_fasta.fasta", 
                                         package="MSstatsPTM"),
                  use_unmod_peptides=TRUE,
                  mod_id = "\\[Phospho \\(STY\\)\\]",
                  fasta_protein_name = "uniprot_iso"
                  )
 
head(msstats_input$PTM)
head(msstats_input$PROTEIN)


## ----raw_data, eval = FALSE---------------------------------------------------
# # Add site into ProteinName column
# raw_ptm_df$ProteinName = paste(raw_ptm_df$ProteinName,
#                                 raw_ptm_df$Site, sep = "_")
# 
# # Run MSstats Converters
# PTM_data = MSstats::DIANNtoMSstatsFormat(raw_ptm_df, annotation)
# PROTEIN_data = MSstats::DIANNtoMSstatsFormat(raw_protein_df, annotation)
# 
# # Combine into one list
# msstatsptm_input_data = list(PTM = PTM_data, PROTEIN = PROTEIN_data)

## ----summarize, message=FALSE, warning=FALSE----------------------------------

MSstatsPTM.summary = dataSummarizationPTM(raw.input, verbose = FALSE, 
                                          use_log_file = FALSE, append = FALSE)

head(MSstatsPTM.summary$PTM$ProteinLevelData)
head(MSstatsPTM.summary$PROTEIN$ProteinLevelData)

## ----qcplot, message=FALSE, warning=FALSE-------------------------------------
dataProcessPlotsPTM(MSstatsPTM.summary,
                    type = 'QCPLOT',
                    which.PTM = "allonly",
                    address = FALSE)

## ----profileplot, message=FALSE, warning=FALSE--------------------------------

dataProcessPlotsPTM(MSstatsPTM.summary,
                    type = 'ProfilePlot',
                    which.Protein = "Q9Y6C9",
                    address = FALSE)

## ----model, message=FALSE, warning=FALSE--------------------------------------

# Specify contrast matrix
comparison = matrix(c(-1,0,1,0),nrow=1)
row.names(comparison) = "CCCP-Ctrl"
colnames(comparison) = c("CCCP", "Combo", "Ctrl", "USP30_OE")

MSstatsPTM.model = groupComparisonPTM(MSstatsPTM.summary, 
                                      ptm_label_type = "LF",
                                      protein_label_type = "LF",
                                      contrast.matrix = comparison,
                                      use_log_file = FALSE, append = FALSE,
                                      verbose = FALSE)
head(MSstatsPTM.model$PTM.Model)
head(MSstatsPTM.model$PROTEIN.Model)
head(MSstatsPTM.model$ADJUSTED.Model)

## ----volcano, message=FALSE, warning=FALSE------------------------------------
groupComparisonPlotsPTM(data = MSstatsPTM.model,
                        type = "VolcanoPlot",
                        FCcutoff= 2,
                        logBase.pvalue = 2,
                        address=FALSE)

## ----heatmap, message=FALSE, warning=FALSE------------------------------------
groupComparisonPlotsPTM(data = MSstatsPTM.model,
                        type = "Heatmap",
                        which.PTM = 1:30,
                        address=FALSE)

## ----sample_size, message=FALSE, warning=FALSE--------------------------------

# Specify contrast matrix
sample_size = designSampleSizePTM(MSstatsPTM.model, c(2.0, 2.75), FDR = 0.05, 
                                  numSample = TRUE, power = 0.8)

head(sample_size)

## ----sample_size_plot, message=FALSE, warning=FALSE---------------------------

MSstats::designSampleSizePlots(sample_size)


