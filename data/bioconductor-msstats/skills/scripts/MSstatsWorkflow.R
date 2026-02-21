# Code example from 'MSstatsWorkflow' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------------------------------------
BiocStyle::markdown()

## ----global_options, include=FALSE--------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=10, fig.height=7, warning=FALSE, message=FALSE)
options(width=110)

## ----code Installation--------------------------------------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstats")
library(MSstats)
library(ggplot2)

## ----code Load Dataset--------------------------------------------------------------------------------------
library(MSstats)

# Load data
pd_raw = system.file("tinytest/raw_data/PD/pd_input.csv", 
                    package = "MSstatsConvert")

annotation_raw = system.file("tinytest/raw_data/PD/annot_pd.csv", 
                   package = "MSstatsConvert")

pd = data.table::fread(pd_raw)
annotation = data.table::fread(annotation_raw)

head(pd, 5)
head(annotation, 5)


## ----code PDtoMSstatsFormat---------------------------------------------------------------------------------
library(MSstatsConvert)

pd_imported = MSstatsConvert::PDtoMSstatsFormat(pd, annotation, 
                                                use_log_file = FALSE)

head(pd_imported)

## ----Converter Files----------------------------------------------------------------------------------------

skyline_raw = system.file("tinytest/raw_data/Skyline/skyline_input.csv", 
                    package = "MSstatsConvert")

skyline = data.table::fread(skyline_raw)
head(skyline, 5)


## ----SkylinetoMSstatsFormat, results='hide', message=FALSE, warning=FALSE-----------------------------------

msstats_format = MSstatsConvert::SkylinetoMSstatsFormat(skyline_raw,
                                      qvalue_cutoff = 0.01,
                                      useUniquePeptide = TRUE,
                                      removeFewMeasurements = TRUE,
                                      removeOxidationMpeptides = TRUE,
                                      removeProtein_with1Feature = TRUE)



## ----SkylinetoMSstatsFormat head----------------------------------------------------------------------------
head(msstats_format)

## ----code dataProcess---------------------------------------------------------------------------------------
summarized = dataProcess(
    pd_imported,
    logTrans = 2,
    normalization = "equalizeMedians",
    featureSubset = "all",
    n_top_feature = 3,
    summaryMethod = "TMP",
    equalFeatureVar = TRUE,
    censoredInt = "NA",
    MBimpute = TRUE
    )

head(summarized$FeatureLevelData)

head(summarized$ProteinLevelData)

head(summarized$SummaryMethod)


## ----echo=FALSE, message=FALSE------------------------------------------------------------------------------
library(kableExtra)

table_data <- data.frame(
  Name = c("Median", "", "Quantile", "", "Global standards", "", "", "None", ""),
  Description = c(
    "Equalize medians of all log feature intensities in each run", "",
    "Equalize the distributions of all log feature intensities in each run", "",
    "Equalize median log-intensities of endogenous or spiked-in reference peptides or proteins. Apply adjustment to the remainder of log feature intensities", "", "",
    "Do not apply any normalization", ""
  ),
  Assumption = c(
    "All steps of data collection and acquisition were randomized",
    "Most of the proteins in the experiment are the same and have the same concentration for all of the runs. The experimental artifacts affect every peptide in a run by the same constant amount",
    "All steps of data collection and acquisition were randomized",
    "Most of the proteins in the experiment are the same and have the same concentration for all of the runs. The experimental artifacts affect every peptide non-linearly, as a function of its log intensity",
    "All steps of data collection and acquisition were randomized",
    "The reference peptides or proteins are present in each run and have the same concentration for all of the runs. All experimental artifacts occur only after standards were added.",
    "The experimental artifacts affect every protein in a run by the same constant amount",
    "All steps of data collection and acquisition were randomized",
    "The experiment has no systematic artifacts or has been normalized in another custom manner"
  ),
  Effect = c(
    "The normalization estimates the artifact deviations in each run with a single quantity, reducing overfitting",
    "The normalization reduces bias and variance of the estimated log fold change",
    "The normalization estimates the artifact deviations in each run with a complex non-linear function, potentially leading to overfitting",
    "The normalization reduces bias and variance of the estimated log fold change but may over-correct",
    "The normalization estimates the artifact deviations in each run with a single quantity, which reduces overfitting",
    "The normalization estimates the artifact deviations from a small number of peptides, which may increase overfitting. The normalization does not eliminate artifacts that occurred before adding spiked references",
    "The normalization reduces bias and variance of the estimated log fold change",
    "All patterns of variation of interest and of nuisance variation are preserved",
    ""
  )
)

tryCatch({
  kable(table_data, "html", escape = FALSE, col.names = c("Name", "Description", "Assumption", "Effect")) %>%
  kable_styling(full_width = FALSE, bootstrap_options = c("striped", "hover"))
}, error = function(e) {
  stop(paste0("Error in rendering the normalization options table: ", e$message))
})

## ----echo=FALSE, message=FALSE------------------------------------------------------------------------------
imputation_table <- data.frame(
  Name = c("Imputation", "No imputation"),
  Description = c(
    "Infer missing feature intensities by using an accelerated failure time model. It will not impute for runs in which all features are missing",
    "Do not apply imputation"
  ),
  Assumption = c(
    "Features are missing for reasons of low abundance (e.g., features are missing not at random)",
    "Assume no information about reasons for missingness or that features are missing at random"
  ),
  Effect = c(
    "If the assumption is true, imputation will remove bias toward high intensities in the summarization step. Otherwise, bias will be introduced via inaccurate imputation",
    "If the assumption is true, no new bias will be introduced. Otherwise, if features are missing for reasons of low abundance, summarized values will be biased toward high intensities"
  )
)

tryCatch({
  kable(imputation_table, "html", escape = FALSE, col.names = c("Name", "Description", "Assumption", "Effect")) %>%
  kable_styling(full_width = TRUE, bootstrap_options = c("striped", "hover", "condensed")) %>%
  column_spec(2:4, width = "30em")
}, error = function(e) {
  stop(paste0("Error in rendering the imputation options table: ", e$message))
})

## ----dataProcessPlots, results='hide', message=FALSE, warning=FALSE-----------------------------------------

# Profile plot
dataProcessPlots(data=summarized, type="ProfilePlot", 
                 address = FALSE, which.Protein = "P0ABU9")

# Quality control plot
dataProcessPlots(data=summarized, type="QCPlot", 
                 address = FALSE, which.Protein = "P0ABU9")

# Quantification plot for conditions
dataProcessPlots(data=summarized, type="ConditionPlot", 
                 address = FALSE, which.Protein = "P0ABU9")


## ----code groupComparison-----------------------------------------------------------------------------------

model = groupComparison("pairwise", summarized)


## ----Model--------------------------------------------------------------------------------------------------

head(model$ModelQC)

head(model$ComparisonResult)


## -----------------------------------------------------------------------------------------------------------
# Order of conditions: control_male, control_female, disease_male, disease_female
contrast.matrix = matrix(c(0.5, 0.5, -0.5, -0.5), nrow = 1)
colnames(contrast.matrix) = c("Control_Male", "Control_Female", "Disease_Male", "Disease_Female")
row.names(contrast.matrix) <- "Control - Disease"

## -----------------------------------------------------------------------------------------------------------
# Order of conditions: control_male, control_female, disease_male, disease_female
contrast.matrix = matrix(c(0.5, -0.5, 0.5, -0.5), nrow = 1)
colnames(contrast.matrix) = c("Control_Male", "Control_Female", "Disease_Male", "Disease_Female")
row.names(contrast.matrix) <- "Male - Female"

## ----GroupComparisonPlots-----------------------------------------------------------------------------------

groupComparisonPlots(
  model$ComparisonResult,
  type="Heatmap",
  sig = 0.05,
  FCcutoff = FALSE,
  logBase.pvalue = 10,
  ylimUp = FALSE,
  ylimDown = FALSE,
  xlimUp = FALSE,
  x.axis.size = 10,
  y.axis.size = 10,
  dot.size = 3,
  text.size = 4,
  text.angle = 0,
  legend.size = 13,
  ProteinName = TRUE,
  colorkey = TRUE,
  numProtein = 100,
  clustering = "both",
  width = 800,
  height = 600,
  which.Comparison = "all",
  which.Protein = "all",
  address = FALSE,
  isPlotly = FALSE
)



groupComparisonPlots(
  model$ComparisonResult,
  type="VolcanoPlot",
  sig = 0.05,
  FCcutoff = FALSE,
  logBase.pvalue = 10,
  ylimUp = FALSE,
  ylimDown = FALSE,
  xlimUp = FALSE,
  x.axis.size = 10,
  y.axis.size = 10,
  dot.size = 3,
  text.size = 4,
  text.angle = 0,
  legend.size = 13,
  ProteinName = TRUE,
  colorkey = TRUE,
  numProtein = 100,
  clustering = "both",
  width = 800,
  height = 600,
  which.Comparison = "Condition2 vs Condition4",
  which.Protein = "all",
  address = FALSE,
  isPlotly = FALSE
)


## ----GroupComparisonQCplots, results='hide', message=FALSE, warning=FALSE-----------------------------------

source("..//R//groupComparisonQCPlots.R")

groupComparisonQCPlots(data=model, type="QQPlots", address=FALSE, 
                       which.Protein = "P0ABU9")


groupComparisonQCPlots(data=model, type="ResidualPlots", address=FALSE, 
                       which.Protein = "P0ABU9")

## ----Sample Size--------------------------------------------------------------------------------------------

sample_size_calc = designSampleSize(model$FittedModel,
                                    desiredFC=c(1.75,2.5),
                                    power = TRUE,
                                    numSample=5)


## ----Sample Size plot---------------------------------------------------------------------------------------

designSampleSizePlots(sample_size_calc, isPlotly=FALSE)


## ----Quantification-----------------------------------------------------------------------------------------
sample_quant_long = quantification(summarized,
                             type = "Sample",
                             format = "long")
sample_quant_long
sample_quant_wide = quantification(summarized,
                              type = "Sample",
                              format = "matrix")
sample_quant_wide
group_quant_long = quantification(summarized,
                                  type = "Group",
                                  format = "long")
group_quant_long
group_quant_wide = quantification(summarized,
                                  type = "Group",
                                  format = "matrix")
group_quant_wide

