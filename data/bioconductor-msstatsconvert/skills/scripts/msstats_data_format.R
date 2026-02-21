# Code example from 'msstats_data_format' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
  knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  )

## ----logs---------------------------------------------------------------------
library(MSstatsConvert)
# default - creates a new file
MSstatsLogsSettings(use_log_file = TRUE, append = FALSE) 

# default - creates a new file
MSstatsLogsSettings(use_log_file = TRUE, append = TRUE, 
                    log_file_path = "log_file.log") 

# switches logging off
MSstatsLogsSettings(use_log_file = FALSE, append = FALSE) 

# switches off logs and messages
MSstatsLogsSettings(use_log_file = FALSE, verbose = FALSE) 

## -----------------------------------------------------------------------------
MSstatsSaveSessionInfo()

## -----------------------------------------------------------------------------
maxquant_evidence = read.csv(system.file("tinytest/raw_data/MaxQuant/mq_ev.csv",
                                         package = "MSstatsConvert"))
maxquant_proteins = read.csv(system.file("tinytest/raw_data/MaxQuant/mq_pg.csv",
                                         package = "MSstatsConvert"))
maxquant_imported = MSstatsImport(list(evidence = maxquant_evidence,
                                       protein_groups = maxquant_proteins),
                                  type = "MSstats", tool = "MaxQuant")
is(maxquant_imported)

openms_input = read.csv(system.file(
  "tinytest/raw_data/OpenMSTMT/openmstmt_input.csv",
  package = "MSstatsConvert"
))
openms_imported = MSstatsImport(list(input = openms_input),
                                "MSstatsTMT", "OpenMS")
is(openms_imported)

## -----------------------------------------------------------------------------
getInputFile(maxquant_imported, "evidence")[1:5, 1:5]

## -----------------------------------------------------------------------------
maxquant_cleaned = MSstatsClean(maxquant_imported, protein_id_col = "Proteins")
head(maxquant_cleaned)

openms_cleaned = MSstatsClean(openms_imported)
head(openms_cleaned)

## -----------------------------------------------------------------------------
maxquant_annotation = read.csv(system.file(
  "tinytest/raw_data/MaxQuant/annotation.csv",
  package = "MSstatsConvert"
))
maxquant_annotation = MSstatsMakeAnnotation(maxquant_cleaned,
                                            maxquant_annotation,
                                            Run = "Rawfile")
m_filter = list(col_name = "PeptideSequence", 
                pattern = "M", 
                filter = TRUE, 
                drop_column = FALSE)

oxidation_filter = list(col_name = "Modifications", 
                        pattern = "Oxidation", 
                        filter = TRUE, 
                        drop_column = TRUE)

feature_columns = c("PeptideSequence", "PrecursorCharge")
maxquant_processed = MSstatsPreprocess(
  maxquant_cleaned, 
  maxquant_annotation,
  feature_columns,
  remove_shared_peptides = TRUE, 
  remove_single_feature_proteins = FALSE,
  pattern_filtering = list(oxidation = oxidation_filter,
                           m = m_filter),
  feature_cleaning = list(remove_features_with_few_measurements = TRUE,
                          summarize_multiple_psms = max),
  columns_to_fill = list("FragmentIon" = NA,
                         "ProductCharge" = NA,
                         "IsotopeLabelType" = "L"))
head(maxquant_processed)

# OpenMS - TMT data
feature_columns_tmt = c("PeptideSequence", "PrecursorCharge")
openms_processed = MSstatsPreprocess(
  openms_cleaned, 
  NULL, 
  feature_columns_tmt,
  remove_shared_peptides = TRUE,
  remove_single_feature_proteins = TRUE,
  feature_cleaning = list(remove_features_with_few_measurements = TRUE,
                          summarize_multiple_psms = max)
)
head(openms_processed)

## ----eval = FALSE-------------------------------------------------------------
# list(
#   list(score_column = "Intensity", score_threshold = 1,
#        direction = "greater", behavior = "remove",
#        handle_na = "remove", fill_value = NA, filter = TRUE, drop = FALSE
#        )
# )

## -----------------------------------------------------------------------------
maxquant_balanced = MSstatsBalancedDesign(maxquant_processed, feature_columns)
head(maxquant_balanced)
dim(maxquant_balanced)
dim(maxquant_processed)

openms_balanced = MSstatsBalancedDesign(openms_processed, feature_columns_tmt)
head(openms_balanced)
dim(openms_balanced)
dim(openms_processed)

