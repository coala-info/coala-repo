# Code example from 'OpenStats' vignette. See references/ for full tutorial.

## ----R_hide002, echo=TRUE, eval=TRUE, results='tex'---------------------------
library(OpenStats)
###################
# Data preparation
###################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
read.csv(fileCon, as.is = TRUE)[60:75, c(
  "external_sample_id",
  "biological_sample_group",
  "sex",
  "age_in_days"
)]

## ----R_hide003, results='tex', echo=TRUE, eval=TRUE---------------------------
#######################################
# Default behaviour with messages
#######################################
library(OpenStats)
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex"
)
#######################################
# OpenStatsLis behaviour without messages
#######################################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex",
  debug = FALSE
)
# No output printed

## ----R_hide005, echo=TRUE, eval=TRUE, results='tex'---------------------------
library(OpenStats)
df <- read.csv(system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
))
OpenStatsList <- OpenStatsList(
  dataset = df,
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.sex = "sex",
  dataset.colname.weight = "weight",
  debug = FALSE
)
p <- plot(OpenStatsList, vars = c("Sex", "Genotype", "data_point"), ask = TRUE)
# Plot categorical variables
p$Categorical
# plot continuous variable
p$Continuous
summary(OpenStatsList,
  style = "grid",
  varnumbers = FALSE, # See more options ?summarytools::dfSummary
  graph.col = FALSE, # Do not show the graph column
  valid.col = FALSE,
  vars = c("Sex", "Genotype", "data_point")
)

## ----R_hide01021, results='tex', echo=TRUE, eval=TRUE-------------------------
library(OpenStats)
#################
# Data preparation
#################
#################
# Continuous data - Creating OpenStatsList object
#################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex",
  debug = FALSE
)
#################
# Reference range framework
#################
RR_result <- OpenStatsAnalysis(
  OpenStatsList = test_Cont,
  method = "RR",
  RR_formula = data_point ~ Genotype + Sex,
  debug = FALSE
)
lapply(RR_result, names)
# lapply(RR_result$output,names)

## ----R_hide010, results='tex', echo=TRUE, eval=TRUE---------------------------
library(OpenStats)
#################
# Data preparation
#################
#################
# Continuous data - Creating OpenStatsList object
#################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex",
  debug = FALSE
)
#################
# LinearMixed model (MM) framework
#################
MM_result <- OpenStatsAnalysis(
  OpenStatsList = test_Cont,
  method = "MM",
  MM_fixed = data_point ~ Genotype + Weight
)

## ----R_hide010m2, results='tex', echo=TRUE, eval=TRUE-------------------------
library(OpenStats)
#################
# Data preparation
#################
#################
# Continuous data - Creating OpenStatsList object
#################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex",
  debug = FALSE
)
#################
# LinearMixed model (MM) framework
#################
MM_result <- OpenStatsAnalysis(
  OpenStatsList = test_Cont,
  method = "MM",
  MM_fixed = data_point ~ Genotype + Weight,
  debug = FALSE
)
# SplitEffect estimation with respect to the Sex levels
Spliteffect <- OpenStatsComplementarySplit(
  object = MM_result,
  variables = "Sex"
)
class(Spliteffect)

## ----R_hide01020, results='tex', echo=TRUE, eval=TRUE-------------------------
library(OpenStats)
#################
# Data preparation
#################
#################
# Continuous data - Creating OpenStatsList object
#################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex",
  debug = FALSE
)
#################
# Reference range framework
#################
RR_result <- OpenStatsAnalysis(
  OpenStatsList = test_Cont,
  method = "RR",
  RR_formula = data_point ~ Genotype + Sex
)

## ----R_hide0102, results='tex', echo=TRUE, eval=TRUE--------------------------
library(OpenStats)
#################
# Categorical data - Creating OpenStatsList object
#################
fileCat <- system.file("extdata", "test_categorical.csv",
  package = "OpenStats"
)
test_Cat <- OpenStatsList(
  dataset = read.csv(fileCat, na.strings = "-"),
  testGenotype = "Aff3/Aff3",
  refGenotype = "+/+",
  dataset.colname.genotype = "Genotype",
  dataset.colname.batch = "Assay.Date",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "Weight",
  dataset.colname.sex = "Sex",
  debug = FALSE
)
#################
# Fisher's exact test framework
#################
FE_result <- OpenStatsAnalysis(
  OpenStatsList = test_Cat,
  method = "FE",
  FE_formula = Thoracic.Processes ~ Genotype + Sex
)

## ----R_hide013, results='tex', echo=TRUE, eval=TRUE---------------------------
library(OpenStats)
#################
# Data preparation
#################
#################
# Continuous data - Creating OpenStatsList object
#################
fileCon <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
test_Cont <- OpenStatsList(
  dataset = read.csv(fileCon),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.lifestage = NULL,
  dataset.colname.weight = "weight",
  dataset.colname.sex = "sex",
  debug = FALSE
)
#################
# LinearMixed model (MM) framework
#################
MM_result <- OpenStatsAnalysis(
  OpenStatsList = test_Cont,
  method = "MM",
  MM_fixed = data_point ~ Genotype + Weight,
  debug = FALSE
)
summary(MM_result)

## ----R_hide015, results='tex', echo=TRUE, eval=TRUE---------------------------
strtrim(
  OpenStatsReport(
    object = MM_result,
    JSON = TRUE,
    RemoveNullKeys = TRUE,
    pretty = TRUE
  ),
  1500
)

## ----R_hide017, results='tex', echo=TRUE, eval=TRUE---------------------------
library(OpenStats)
###################
file <- system.file("extdata", "test_continuous.csv",
  package = "OpenStats"
)
###################
# OpenStatsList object
###################
OpenStatsList <- OpenStatsList(
  dataset = read.csv(file),
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.batch = "date_of_experiment",
  dataset.colname.genotype = "biological_sample_group",
  dataset.colname.sex = "sex",
  dataset.colname.weight = "weight",
  debug = FALSE
)
plot(OpenStatsList)
summary(
  OpenStatsList,
  style     = "grid",
  varnumbers = FALSE, # See more options ?summarytools::dfSummary
  graph.col = FALSE, # Do not show the graph column
  valid.col = FALSE
)

## ----R_hide018, results='tex', echo=TRUE, eval=TRUE---------------------------
plot(MM_result, col = 2)

## ----R_hide0175, results='tex', echo=TRUE, eval=TRUE--------------------------
sessionInfo()

