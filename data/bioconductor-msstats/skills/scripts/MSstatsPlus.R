# Code example from 'MSstatsPlus' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------------------------------------
BiocStyle::markdown()

## ----global_options, include=FALSE--------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=10, fig.height=7, warning=FALSE, message=FALSE)
options(width=110)

## -----------------------------------------------------------------------------------------------------------
library(MSstats)
library(MSstatsConvert)
library(data.table)
library(ggplot2)

## -----------------------------------------------------------------------------------------------------------
# Spectronaut quant file
spectronaut_raw = system.file(
    "tinytest/raw_data/Spectronaut/spectronaut_quality_input.csv",
    package = "MSstatsConvert")
spectronaut_raw = data.table::fread(spectronaut_raw)

# Annotation file
annotation = system.file(
    "tinytest/raw_data/Spectronaut/annotation.csv",
    package = "MSstatsConvert")
annotation = data.table::fread(annotation)

# Create temporal run ordering data.table
spectronaut_raw[, `R.Run Date (Formatted)` := as.POSIXct(
    `R.Run Date (Formatted)`, format = "%m/%d/%Y %I:%M:%S %p")]
run_order = unique(spectronaut_raw[, c("R.Run Date (Formatted)", 
                                       "R.FileName")])
run_order = run_order[order(`R.Run Date (Formatted)`)]
run_order$Order = 1:nrow(run_order)
setnames(run_order, c("R.FileName"), c("Run"))

## -----------------------------------------------------------------------------------------------------------
msstats_input = MSstatsConvert::SpectronauttoMSstatsFormat(
    spectronaut_raw, annotation, intensity = 'PeakArea',
    excludedFromQuantificationFilter = TRUE, # Pre-filtering
    calculateAnomalyScores=TRUE, # Key parameter to use MSstats+
    anomalyModelFeatures=c("FGShapeQualityScore(MS2)",
                           "FGShapeQualityScore(MS1)",
                           "EGDeltaRT"), # Quality metrics
    anomalyModelFeatureTemporal=c(
        "mean_decrease", "mean_decrease",
        "dispersion_increase"), # Temporal direction of quality metrics
    runOrder=run_order, # Temporal order of MS runs
    n_trees=100,
    max_depth="auto", # iForest parameter (depth of trees)
    numberOfCores=1) # Cores to use for parallel processing (Mac or Linux only)

head(msstats_input)

## -----------------------------------------------------------------------------------------------------------
health_info = CheckDataHealth(msstats_input)
skew_score = health_info[[2]]

ggplot(skew_score, aes(x = skew)) + 
  geom_histogram(fill = "#E69F00", color = "black", bins=12) + 
  geom_vline(xintercept = 0, linetype = "dashed", 
             color = "black", linewidth = 1.5) + 
  theme_minimal(base_size = 16) + 
  labs(
    title="Distribution of skewness of anomaly scores",
    x = "Pearson's moment coefficient of skewness",
    y = "Count"
  ) +
  theme(
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 16),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  )


## -----------------------------------------------------------------------------------------------------------

# Extract quality metrics from PSM output
quality_join_cols = c("R.FileName", "PG.ProteinGroups", "EG.ModifiedSequence",
                      "FG.Charge", "FG.ShapeQualityScore (MS1)", 
                      "FG.ShapeQualityScore (MS2)", "EG.DeltaRT")
quality_join_df = spectronaut_raw[, ..quality_join_cols]
quality_join_df$EG.ModifiedSequence = stringr::str_replace_all(
    quality_join_df$EG.ModifiedSequence, "\\_", "")
quality_join_df = unique(quality_join_df)

# In case there are duplicates (not common)
quality_join_df = quality_join_df[
  , lapply(.SD, mean, na.rm = TRUE),
  by = .(R.FileName, PG.ProteinGroups, EG.ModifiedSequence, FG.Charge),
  .SDcols = c("FG.ShapeQualityScore (MS1)",
              "FG.ShapeQualityScore (MS2)",
              "EG.DeltaRT")
]

# Extract run order
spectronaut_raw[, `R.Run Date (Formatted)` := as.POSIXct(
    `R.Run Date (Formatted)`, format = "%m/%d/%Y %I:%M:%S %p")]
run_order = unique(spectronaut_raw[, c("R.Run Date (Formatted)", 
                                       "R.FileName")])
run_order = run_order[order(`R.Run Date (Formatted)`)]
run_order$Order = 1:nrow(run_order)
setnames(run_order, c("R.FileName"), c("Run"))

# Run standard MSstats converter without anomaly detection
msstats_input = MSstatsConvert::SpectronauttoMSstatsFormat(
    spectronaut_raw, annotation, intensity = 'PeakArea',
    excludedFromQuantificationFilter = TRUE, # Pre-filtering
    calculateAnomalyScores=FALSE) # Turn anomaly detection off

# Join in quality metrics
msstats_input = merge(as.data.table(msstats_input), 
                      as.data.table(quality_join_df), 
                      all.x=TRUE, all.y=FALSE,
                      by.x=c("Run", "ProteinName", "PeptideSequence", 
                             "PrecursorCharge"),
                      by.y=c("R.FileName", "PG.ProteinGroups", 
                             "EG.ModifiedSequence", "FG.Charge"))

# Run Anomaly Model separately
input = MSstatsConvert::MSstatsAnomalyScores(
    msstats_input, 
    c("FG.ShapeQualityScore (MS1)", "FG.ShapeQualityScore (MS2)", "EG.DeltaRT"), 
    c("mean_decrease", "mean_decrease", "dispersion_increase"),
    .5, 100, run_order, 100, "auto", 1)

## -----------------------------------------------------------------------------------------------------------
summarized = dataProcess(msstats_input,
                         normalization=FALSE, # no normalization
                         MBimpute=TRUE, # Use imputation
                         summaryMethod="linear" # Key MSstats+ parameter
                         )

head(summarized$ProteinLevelData)

## -----------------------------------------------------------------------------------------------------------
dataProcessPlots(summarized, "ProfilePlot", which.Protein = "Q9UFW8", address = FALSE)

## -----------------------------------------------------------------------------------------------------------
comparison = matrix(c(-1,1),nrow=1)
row.names(comparison) = "Condition2-Condition1"
colnames(comparison) = c("Condition1", "Condition2")

comparison_result = groupComparison(
    contrast.matrix = comparison,
    data=summarized)

head(comparison_result$ComparisonResult)

## -----------------------------------------------------------------------------------------------------------
base_msstats_input = MSstatsConvert::SpectronauttoMSstatsFormat(
    spectronaut_raw, annotation, intensity = 'PeakArea',
    excludedFromQuantificationFilter = TRUE, # Pre-filtering
    calculateAnomalyScores=FALSE) # No anomaly model

base_summarized = dataProcess(base_msstats_input,
                         normalization=FALSE, # no normalization
                         MBimpute=TRUE, # Use imputation
                         summaryMethod="TMP" # Tukey median polish summarization
                         )

base_comparison_result = groupComparison(
    contrast.matrix = comparison,
    data=base_summarized)

head(base_comparison_result$ComparisonResult)

## -----------------------------------------------------------------------------------------------------------
comparison_result$ComparisonResult$Model = "MSstats+"
base_comparison_result$ComparisonResult$Model = "MSstats"

merged_results = rbindlist(list(
    comparison_result$ComparisonResult,
    base_comparison_result$ComparisonResult
))

ggplot(data=merged_results) + 
    geom_col(aes(x=Protein, y=abs(log2FC), fill=Model), position="dodge") +
    geom_hline(yintercept=1, linetype="dashed", color="black", linewidth=1) +
    theme_bw(base_size =16) + 
    labs(title="Log fold change comparison",
         x="MSstats+",
         y="Base MSstats")

## -----------------------------------------------------------------------------------------------------------
ggplot(data=merged_results) + 
    geom_col(aes(x=Protein, y=SE, fill=Model), position="dodge") +
    theme_bw(base_size =16) + 
    labs(title="Standard error comparison",
         x="MSstats+",
         y="Base MSstats")

## ----eval=FALSE, include=TRUE-------------------------------------------------------------------------------
# library(MSstatsBig)
# 
# # Define file path to data
# spectronaut_raw = system.file(
#     "tinytest/raw_data/Spectronaut/spectronaut_quality_input.csv",
#     package = "MSstatsConvert")
# 
# # Run MSstatsBig converter
# converted_data = bigSpectronauttoMSstatsFormat(
#   input_file=spectronaut_raw,
#   output_file_name="output_file.csv",
#   intensity = "F.PeakHeight",
#   filter_by_excluded = TRUE,
#   filter_by_identified = FALSE,
#   filter_by_qvalue = TRUE,
#   qvalue_cutoff = 0.01,
#   filter_unique_peptides = TRUE,
#   aggregate_psms = TRUE,
#   filter_few_obs = FALSE,
#   remove_annotation = FALSE,
#   calculateAnomalyScores=TRUE,
#   anomalyModelFeatures=c("FG.ShapeQualityScore (MS1)",
#                          "FG.ShapeQualityScore (MS2)",
#                          "EG.ApexRT"),
#   backend="arrow")
# converted_data = dplyr::collect(converted_data)
# 
# # Prepare info for anomaly model
# # Get temporal ordering from input file (can also be done externally)
# temporal = fread(spectronaut_raw)[
#     , .SD[1], by = .(`R.Run Date (Formatted)`, R.FileName)]
# 
# temporal = temporal[, Run.TimeParsed := as.POSIXct(
#     `R.Run Date (Formatted)`, format = "%m/%d/%Y %I:%M:%S %p")][
#   order(Run.TimeParsed)][
#   , !"Run.TimeParsed"]
# 
# temporal$Order = 1:nrow(temporal)
# temporal$Run = temporal$R.FileName
# temporal = temporal[, c("Run", "Order")]
# 
# # Specify anomaly model parameters
# anomalyModelFeatures=c("FG.ShapeQualityScore (MS2)",
#                        "FG.ShapeQualityScore (MS1)",
#                        "EG.ApexRT")
# anomalyModelFeatures = MSstatsConvert:::.standardizeColnames(anomalyModelFeatures)
# 
# anomalyModelFeatureTemporal=c("mean_decrease",
#                               "mean_decrease",
#                               "dispersion_increase")
# 
# n_trees=100
# max_depth="auto"
# numberOfCores=1
# 
# # Run anomaly detection model
# msstats_input = MSstatsConvert::MSstatsAnomalyScores(
#   as.data.table(converted_data), anomalyModelFeatures,
#   anomalyModelFeatureTemporal, .5, 100, temporal, n_trees,
#   max_depth, numberOfCores)
# head(msstats_input)
# 

