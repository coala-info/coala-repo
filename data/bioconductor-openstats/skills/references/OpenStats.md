# **OpenStats**: A Robust and Scalable Software Package for Reproducible Analysis of High-Throughput Phenotypic Data

#### Hamed Haseli Mashhadi

#### Marina Kan

marinak@ebi.ac.uk

#### 30 October 2025

* [0.1 Building block of the software](#building-block-of-the-software)
* [0.2 Data preprocessing](#data-preprocessing)
  + [0.2.1 OpenStatsList Object](#openstatslist-object)
* [0.3 Data Analysis](#data-analysis)
  + [0.3.1 OpenStatsAnalysis output object](#openstatsanalysis-output-object)
* [0.4 Examples](#examples)
  + [0.4.1 Linear mixed model framework](#linear-mixed-model-framework)
    - [0.4.1.1 Sub-model estimation](#sub-model-estimation)
  + [0.4.2 Reference range plus framework](#reference-range-plus-framework)
  + [0.4.3 Fisher’s exact test framework](#fishers-exact-test-framework)
* [0.5 Summary and export](#summary-and-export)
* [0.6 Graphics](#graphics)
  + [0.6.1 Session information](#session-information)

*OpenStats* is a freely available R package that presents statistical methods and detailed analyses to promote the hard process of identification of abnormal phenotypes. The package incorporates several checks and cleaning on the input data prior to the statistical analysis. For continuous data, Linear Mixed Model with an optional model selection routine is implemented, whilst for categorical data, Fisher’s Exact Test is implemented. For cases where the linear mixed model fails, Reference Range Plus method has been employed for a quick, simple analysis of the continuous data. User can perform inspections and diagnostics of the final fitted model by the visualisation tools that come with the software. Furthermore, the user can export/report the outputs in the form of either standard R list or JavaScript Object Notation (JSON). OpenStats has been tested and demonstrated with an application of \(2.5M+\) analyses from the Internationa Mouse Phenotyping Consortium (IMPC).

The User’s Guide with more details about the statistical analysis is available as part of the online documentation from <https://rpubs.com/hamedhm/openstats>. Project Github repository including *dev* version of the package is available on <https://git.io/JeOVN>.

**OpenStats** can be installed using the standard R package installation routin:

**R code here**

## 0.1 Building block of the software

*OpenStats* consists of one input layer and three operational layers:

* **(Input layer)** Input data and specifiying model: this includes the input data and an initial model in the form of standard R formula, e.g. \(y \sim x+1\).
* **(Operational layer 1)** Dataset preprocessing: this includes checking, cleaning and terminology unification procedures and is completed by the function *OpenStatsList* which creates an *OpenStatsList* object.
* **(Operational layer 2)** Data analysis: this is managed by the function *OpenStatsAnalysis* and consists of Linear Mixed Model, Fisher’s Exact test and Reference Range plus framework implementations. The results are stored in an *OpenStatsMM/FE/RR* object.
* **(Operational layer 3)** Report/Export: the exports/reports are managed by the function *OpenStatsReport*. *OpenStats* reports the outputs in the form of either List or JSON objects.

## 0.2 Data preprocessing

*OpenStatsList* function performs data processing and creates an *OpenStatsList* object. As input, *OpenStatsList* function requires dataset of phenotypic data that can be presented as data frame. For instance, it can be dataset stored in csv, tsv or txt file. Data is organised with rows and columns for samples and features respectively. Following shows an example of the input data where rows and columns represent mice and features (mouse id, treatment group, gender, age of animal in days):

```
library(OpenStats)
```

```
## Loading required package: nlme
```

```
##
##  >===============================================================================<
##  OpenStats is developed by International Mouse Phenotyping Consortium (IMPC)
##  More details           : https://www.mousephenotype.org/
##  Source code and issues : https://git.io/Jv5w0
##  Contact us             : https://www.mousephenotype.org/contact-us/
##  >===============================================================================<
```

```
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
```

```
##    external_sample_id biological_sample_group    sex age_in_days
## 60             C10058                 control female          53
## 61             C10059                 control female          53
## 62             C10060                 control female          53
## 63             C10061                 control female          53
## 64             C10062                 control female          53
## 65             C10063                 control   male          53
## 66             C10064                 control   male          53
## 67             C10065                 control   male          53
## 68             C10066                 control   male          53
## 69             C10067                 control   male          53
## 70             C10192            experimental   male          46
## 71             C10193            experimental   male          46
## 72             C10194            experimental   male          46
## 73             C10195            experimental   male          46
## 74             C10197            experimental   male          46
## 75             C10199            experimental   male          46
```

The main preprocessing tasks performed by the *OpenStatsList* function are:

* terminology unification,
* filtering out undesirable records (when the argument *dataset.clean* is set to TRUE),
* imputing missings such as blanks, spaces or user-specified terms with NA,
* and checking whether the dataset can be used for the statistical analysis.

We define “terminology unification” as the terminology used to describe data (variables) that are essential for the analysis. *OpenStats* package uses the following nomenclature for the names of columns: “Genotype”, the only mandatory variable, “Sex”, “Batch” “LifeStage” and “Weight”. In addition, expected (default) Sex, LifeStage values are “Male/Female” and “Early/Late” respectively. However, the user can define the custom levels by setting *dataset.values.male*, *dataset.values.female*, *dataset.values.early* and *dataset.values.late* in the OpenStatsList function. Missing value is specified by *dataset.values.missingValue* argument and set to *NA*.

The statistical analysis requires exactly two “Genotype” groups for comparison (e.g. wild-type versus knockout). Thus the function *OpenStatsList* requires users to define the reference genotype (mandatory argument *refGenotype* with default value “control”) and test genotype (mandatory argument *testGenotype*), defaulted to “experimental”. If the *OpenStatsList* function argument *dataset.clean* is set to TRUE then all records with genotype values others than reference or test genotype are filtered out.

All tasks in OpenStats are accompanied by step-by-step reports, error messages, warnings and/or other useful information about the progress of the function. If messages are not desirable, *OpenStatsList* function’s argument *debug* can be set to FALSE meaning there will be no messages.

The chunk of code below demonstrates an example of using *OpenStatsList* when the user sets out-messages to TRUE/FALSE:

```
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
```

```
## 2025-10-30 01:31:05.347297. Input data of the dimensions, rows = 410, columns = 75
```

```
## 2025-10-30 01:31:05.348477. Checking the input data in progress ...
```

```
## 2025-10-30 01:31:05.34964. Checking the specified missing values [x2] (` `, ``) ...
```

```
## 2025-10-30 01:31:05.350306.  1/2. Checking (` `) ...
```

```
## 2025-10-30 01:31:05.355039.  2/2. Checking (``) ...
```

```
## 2025-10-30 01:31:05.360911. Checking whether variable `biological_sample_group` exists in the data ...
## 2025-10-30 01:31:05.360911.  Result = TRUE
```

```
## 2025-10-30 01:31:05.362543.   Levels (Total levels = 2, missings = 0%):
## 2025-10-30 01:31:05.362543.    1. control
## 2025-10-30 01:31:05.362543.    2. experimental
```

```
## 2025-10-30 01:31:05.363228. Checking whether variable `sex` exists in the data ...
## 2025-10-30 01:31:05.363228.  Result = TRUE
```

```
## 2025-10-30 01:31:05.364307.   Levels (Total levels = 2, missings = 0%):
## 2025-10-30 01:31:05.364307.    1. female
## 2025-10-30 01:31:05.364307.    2. male
```

```
## 2025-10-30 01:31:05.364949. Checking whether variable `date_of_experiment` exists in the data ...
## 2025-10-30 01:31:05.364949.  Result = TRUE
```

```
## 2025-10-30 01:31:05.366181.   Levels (Total levels = 43, missings = 0%):
## 2025-10-30 01:31:05.366181.    1. 2012-07-23T00:00:00Z
## 2025-10-30 01:31:05.366181.    2. 2012-07-30T00:00:00Z
## 2025-10-30 01:31:05.366181.    3. 2012-08-06T00:00:00Z
## 2025-10-30 01:31:05.366181.    4. 2012-08-13T00:00:00Z
## 2025-10-30 01:31:05.366181.    5. 2012-08-20T00:00:00Z
## 2025-10-30 01:31:05.366181.    6. 2012-11-26T00:00:00Z
## 2025-10-30 01:31:05.366181.    7. 2012-12-24T00:00:00Z
## 2025-10-30 01:31:05.366181.    8. 2013-01-02T00:00:00Z
## 2025-10-30 01:31:05.366181.    9. 2013-01-15T00:00:00Z
## 2025-10-30 01:31:05.366181.    10. 2013-01-21T00:00:00Z
## 2025-10-30 01:31:05.366181.    ...
```

```
## 2025-10-30 01:31:05.366843. Checking whether variable `weight` exists in the data ...
## 2025-10-30 01:31:05.366843.  Result = TRUE
```

```
## 2025-10-30 01:31:05.368039.   Summary:
## 2025-10-30 01:31:05.368039.    mean      = 20.0036585365854
## 2025-10-30 01:31:05.368039.    sd        = 2.63972182732584
## 2025-10-30 01:31:05.368039.    Missings  = 0%
```

```
## 2025-10-30 01:31:05.368984. Variable `biological_sample_group` renamed to `Genotype`
```

```
## 2025-10-30 01:31:05.369775. Variable `sex` renamed to `Sex`
```

```
## 2025-10-30 01:31:05.370436. Variable `date_of_experiment` renamed to `Batch`
```

```
## 2025-10-30 01:31:05.371089. Variable `weight` renamed to `Weight`
```

```
## 2025-10-30 01:31:05.380342. Total samples in Genotype:Sex interactions:
## 2025-10-30 01:31:05.380342.   Level(frequency):
## 2025-10-30 01:31:05.380342.    1. control.Female(196)
## 2025-10-30 01:31:05.380342.    2. experimental.Female(5)
## 2025-10-30 01:31:05.380342.    3. control.Male(201)
## 2025-10-30 01:31:05.380342.    4. experimental.Male(8)
```

```
## 2025-10-30 01:31:05.384463. Total `Weight` data points for Genotype:Sex interactions:
## 2025-10-30 01:31:05.384463.   Level(frequency):
## 2025-10-30 01:31:05.384463.    1. control.Female(196),
## 2025-10-30 01:31:05.384463.    2. experimental.Female(5),
## 2025-10-30 01:31:05.384463.    3. control.Male(201),
## 2025-10-30 01:31:05.384463.    4. experimental.Male(8)
```

```
## 2025-10-30 01:31:05.385561. Successfully performed checks in 0.04 second(s).
```

```
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
```

### 0.2.1 OpenStatsList Object

The output of the *OpenStatsList* function is the *OpenStatsList* object that contains a cleaned dataset as well as a copy of the original dataset. *OpenStats* allows **plot** and **summary/print** of the OpenStatList object. Below is an example of the OpenStatsList function accompanied by the plot and summary:

```
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
```

```
## 2025-10-30 01:31:05.516472. Working on the plot ...
```

```
# Plot categorical variables
p$Categorical
```

![](data:image/png;base64...)

```
# plot continuous variable
p$Continuous
```

![](data:image/png;base64...)

```
summary(OpenStatsList,
  style = "grid",
  varnumbers = FALSE, # See more options ?summarytools::dfSummary
  graph.col = FALSE, # Do not show the graph column
  valid.col = FALSE,
  vars = c("Sex", "Genotype", "data_point")
)
```

```
## Loading required namespace: summarytools
```

```
## 2025-10-30 01:31:06.505869. Working on the summary table ...
```

```
## Error in match.call(f, call): ... used in a situation where it does not exist
```

```
## Warning in parse_call(mc = match.call(), var_name = get_var_info, var_label =
## get_var_info, : metadata extraction terminated unexpectedly; inspect results
## carefully
```

```
## Data Frame Summary
## Dimensions: 410 x 3
## Duplicates: 0
##
## +------------+----------------------+---------------------+---------+
## | Variable   | Stats / Values       | Freqs (% of Valid)  | Missing |
## +============+======================+=====================+=========+
## | Sex        | 1. Female            | 201 (49.0%)         | 0       |
## | [factor]   | 2. Male              | 209 (51.0%)         | (0.0%)  |
## +------------+----------------------+---------------------+---------+
## | Genotype   | 1. control           | 397 (96.8%)         | 0       |
## | [factor]   | 2. experimental      |  13 ( 3.2%)         | (0.0%)  |
## +------------+----------------------+---------------------+---------+
## | data_point | Mean (sd) : 11 (1.7) | 408 distinct values | 0       |
## | [numeric]  | min < med < max:     |                     | (0.0%)  |
## |            | 7 < 10.9 < 16.7      |                     |         |
## |            | IQR (CV) : 2.6 (0.2) |                     |         |
## +------------+----------------------+---------------------+---------+
```

*OpenStatsList* object stores many characteristics of the data, for instance, reference genotype, test genotype, original column names, factor levels etc.

## 0.3 Data Analysis

*OpenStats* package contains three statistical frameworks for the phenodeviants identification:

* Simple Linear/Linear Mixed Models framework that assumes baseline values of the dependent variable are normally distributed but batch (defined as the date of experiment in the IMPC) is the between-group source of variation.
* Reference Range Plus framework identifies the normal variation form a group called *Reference variable* (wild-type animals in the IMPC), classifies dependent variable as *low*, *normal* or *high* and compare proportions. This framework recommended for the sufficient number of controls (more than 60 records) to correctly identify normal variation.
* Fisher’s Exact Test is a standard framework for categorical data which compares data proportions and calculates the percentage change in classification.

OpenStats’s function **OpenStatsAnalysis** works as a hub for the different statistical analysis methods. It checks the dependent variable, the data, missings, not proper terms in the model (such as terms that do not exist in the input data) and runs the selected statistical analysis framework and returns modelling testing results. All analysis frameworks output a statistical significance measure, effect size measure, model diagnostics, and graphical visualisations.

Here we explain the main bits of the *OpenStatsAnalysis* function:

* **OpenStatsListObject**: defines the dataset stored in an *OpenStatsList* object. OpenStatsAnalysis also supports the *PhenList* object from Bioconductor *PhenStat* package.
* **model**: defines the fixed effect model for example, \(Response \sim Genotype + Sex\)
* **method**: defines which statistical analysis framework to use.

The possible values for the *method* arguments are “MM” which stands for mixed model framework, “FE” to perform Fisher’s exact test model and “RR” for Reference Range Plus framework. The semantic naming in the input arguments of the OpenStatsAnalysis function allows natural distinction of the input arguments For example, \(MM\\_\), \(RR\\_\) and \(FE\\_\) prefixes represent the arguments that can be set in the corresponging frameworks. Having said that,

* MM\_fixed, MM\_random, MM\_weight refer to the fixed effect terms, random effect term and between group variation
* FE\_formula refers to the model that need to be analysed by Fisher’s exacts test (the default \(category \sim Genotype + Sex + LifeStage\) in the IMPC)
* RR\_formula, RRrefLevel, RR\_prop refer to the Reference Range plus model (default \(data\\_point \sim Genotype + Sex + LifeStage\) in the IMPC). Note that the first term on the right hand side of the model (here \(Genotype\)) is the *Reference Variable* and the reference level is defined by “RRrefLevel” (default is set to “control” in the IMPC). Finally the natural variation of the reference level to define the so called “NORMAL” category is determined by “RR\_prop” (defaulted to \(0.95\) that is mutants outside the \(.025\) quantile from right/left tails of the distribution are labeles as high/low respectively).

The *OpenStatsAnalysis* function performs basic checks to ensure that the data and model match, the model is feasible for the type of the data and reports step-by-step progress of the function. Some of the checks and operations are listed below:

* Mixed Model (MM) frameworks:
  + *MM\_checks*: A vector of four 1/0 or TRUE/FALSE values such as c(TRUE, TRUE, TRUE, TRUE)[default]. Performing pre-checks on the input model for some known scenarios. The first element of the vector activates checks on the model terms (in MM\_fixed) to have existed in data. The second term removes any single level -factor- from the model (in MM\_fixed). The third term removes the single value (such as a column of constants/no variation) from the -continuous- terms in the model (in MM\_fixed). The Fourth element checks the interaction term to make sure all interactions have some data attached. Caution is needed for this check as it may take longer than usual if the formula in MM\_fixed contains many factors.
  + Note that OpenStatsAnalysis function always removes duplicated columns in the dataset prior to applying the linear mixed model.
  + Regardless of the check settings, the OpenStatsAnalysis function always checks for the existence of the “MM\_random” terms (provided “MM\_random” is set) in the input data
* Reference Range Plus (RR) and Fisher’s exact test (FE) framework’s:
  + *FERR\_FullComparisions* Only applies to the “RR” or “FE” frameworks. A vector of two logical flags, default c(TRUE, FALSE). Setting the first value to TRUE, then all combinations of the effects (all levels of factors in the input model - for example Male\_LifeStage, Male\_Genotype, Male\_Mutant, Male\_control, Female\_control, Female\_Mutant, Female\_LifeStage and so on) will be tested. Otherwise only *main effects* (no sub-levels - for example Sex\_LifeStage [not for instance Male\_LifeStage]) will be tested. Setting the second element of the vector to TRUE (default FALSE) will force the Fisher’s Exact test to do all comparisons between different levels of the RESPONSE variable. For example, if the response has three levels such as 1) positive, 2) negative and 3) neutral then the comparison will be between 1&2, 1&3, 2&3 and 1&2&3 (obviously the latter is the full table).
* All frameworks
  + OpenStatsAnalysis allows confidence intervals for all estimates in three frameworks. One can set the confidence level by setting MMFERR\_conf.level to a value in \((0,1)\) interval (default \(0.95\)).

All frameworks are equipped with the step-by-step report of the progress of the function. Warnings, errors and messages are reported to the user. In the situation where the function encounters a critical failure, then the output object contains a slot called \(messages\) that reports back the cause of the failure.

### 0.3.1 OpenStatsAnalysis output object

OpenStatsAnalysis output consists of three elements namely, *input*, *output* and *extra.* The *input* object encapsulate the input parameters to the function, *output* hold the analysis results and the *extra* keeps some extra processes on the data/model. Below is an example output from the Reference Rage plus framework:

```
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
```

```
## $output
## [1] "SplitModels"
##
## $input
##  [1] "OpenStatsList"     "data"              "depVariable"
##  [4] "rep"               "method"            "formula"
##  [7] "prop"              "ci_level"          "refLevel"
## [10] "full_comparisions"
##
## $extra
## [1] "Cleanedformula"    "TransformedRRprop"
```

```
# lapply(RR_result$output,names)
```

## 0.4 Examples

In this section, we show some examples of the functionalities in *OpenStats* for the continuous and categorical data. Each section contains the code and different possible scenarios.

### 0.4.1 Linear mixed model framework

The linear mixed model framework applies to continuous data. In this example, data is extracted from the sample data that accompany the software. Here, “Genotype” is the effect of interest. The response is stored in the variable “data\_point” and genotype (Genotype) and body weight (Weight) are covariates. The model selection is left to the default, stepwise, and between-group covariance structure are assumes proportional to the genotype levels (different variation for controls than mutants):

```
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
```

```
## 2025-10-30 01:31:07.502565. OpenStats loaded.
```

```
## 2025-10-30 01:31:07.504358. Checking the input model for including functions ...
```

```
## 2025-10-30 01:31:07.505089. Linear Mixed Model (MM framework) in progress ...
```

```
## 2025-10-30 01:31:07.508085. Removing possible leading/trailing whitespace from the variables in the formula ...
```

```
## 2025-10-30 01:31:07.510001. Checking duplications in the data model:
## 2025-10-30 01:31:07.510001.   Genotype, data_point, Weight
```

```
## 2025-10-30 01:31:07.512402.  No duplicate found.
```

```
## 2025-10-30 01:31:07.514345. Checking for the feasibility of terms and interactions ...
## 2025-10-30 01:31:07.514345.   Formula: data_point ~ Genotype + Weight
```

```
## 2025-10-30 01:31:07.515413.  1 of 1. Checking for the feasibility of terms and interactions ...
```

```
## 2025-10-30 01:31:07.516308.       Checking Genotype ...
```

```
## 2025-10-30 01:31:07.518364.  Checked model: data_point ~ Genotype + Weight
```

```
## 2025-10-30 01:31:07.518973. Check missings in progress ...
```

```
## 2025-10-30 01:31:07.519736.   Missings in variable `data_point`: 0%
```

```
## 2025-10-30 01:31:07.520447.   Missings in variable `Genotype`: 0%
```

```
## 2025-10-30 01:31:07.521161.   Missings in variable `Weight`: 0%
```

```
## 2025-10-30 01:31:07.5223. Checking the random effect term ...
## 2025-10-30 01:31:07.5223.    Formula: ~1 | Batch
```

```
## 2025-10-30 01:31:07.523066. Lme: Fitting the full model ...
```

```
## 2025-10-30 01:31:07.523902.  Applied model: lme
```

```
## 2025-10-30 01:31:07.582156.  The full model successfully applied.
```

```
## 2025-10-30 01:31:07.583371.  Computing the confidence intervals at the level of 0.95 ...
```

```
## 2025-10-30 01:31:07.587515.   CI for `all` term(s) successfully estimated
```

```
## 2025-10-30 01:31:07.588346. The specified "lower" model:
## 2025-10-30 01:31:07.588346.  ~Genotype + 1
```

```
## 2025-10-30 01:31:07.589439. The model optimisation is in progress ...
```

```
## 2025-10-30 01:31:07.590069.  The direction of the optimisation (backward, forward, both): both
```

```
## 2025-10-30 01:31:07.59067.   Optimising the model ...
```

```
## 2025-10-30 01:31:07.698861.  Optimised model: data_point ~ Genotype + Weight
```

```
## 2025-10-30 01:31:07.743315.  Computing the confidence intervals at the level of 0.95 ...
```

```
## 2025-10-30 01:31:07.747089.   CI for `all` term(s) successfully estimated
```

```
## 2025-10-30 01:31:07.747906. Testing varHom ...
```

```
## 2025-10-30 01:31:07.766409.  Computing the confidence intervals at the level of 0.95 ...
```

```
## 2025-10-30 01:31:07.76934.    CI for `all` term(s) successfully estimated
```

```
## 2025-10-30 01:31:07.831862.  VarHom checked out ...
```

```
## 2025-10-30 01:31:07.83276. Testing Batch ...
```

```
## 2025-10-30 01:31:07.837026.  Computing the confidence intervals at the level of 0.95 ...
```

```
## 2025-10-30 01:31:07.838686.   CI for `all` term(s) successfully estimated
```

```
## 2025-10-30 01:31:07.873325. Estimating effect sizes ...
```

```
## 2025-10-30 01:31:08.024951.  Total effect sizes estimated: 2
```

```
## 2025-10-30 01:31:08.025917. Quality tests in progress ...
```

```
## 2025-10-30 01:31:08.030147. MM framework executed in 0.52 second(s).
```

#### 0.4.1.1 Sub-model estimation

*OpenStats* allows fitting submodels from an input model. This is called Split model effects in the outputs and it is mainly useful for reporting sex/age-specific etc. effects. This is performed by creating submodels of a full model. For instance, for the input fixed effect, MM\_fixed, model \(Response\sim Genotype+Sex+Weight\) a possible submodel is \(Response \sim Sex+Sex:Genotype + Weight\) that can be used to estimate sex-specific effects for genotype. This model is then estimated under the configuration of the optimal model. One can turn off Split model effects by setting the fourth element of “MM\_optimise” to FALSE.

An alternative to the analytically estimating the sub-models is to break the input data into splits and run the model on the subset of the data. This can be performed by passing the output of the OpenStatsAnalysis function, *OpenStatsMM*, to the function, *OpenStatsComplementarySplit*. This function allows the *OpenStatsMM* object as input and a set of variable names that split the data. The output is stored in an *OpenStatsComplementarySplit* object. The example below shows a split on “Sex”:

```
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
```

```
## 2025-10-30 01:31:08.570197. Split effects in progress ...
```

```
## 2025-10-30 01:31:08.570947. Variable(s) to split:
## 2025-10-30 01:31:08.570947.  Sex
```

```
## 2025-10-30 01:31:08.571649.  Splitting in progress ...
```

```
## 2025-10-30 01:31:08.572426.  Spliting on Sex ...
```

```
## 2025-10-30 01:31:08.575519. Processing the levels: Female
```

```
## 2025-10-30 01:31:08.996485. [Successful]
```

```
## 2025-10-30 01:31:08.99745. Processing the levels: Male
```

```
## 2025-10-30 01:31:09.511633. [Successful]
```

```
class(Spliteffect)
```

```
## [1] "OpenStatsComplementarySplit"
```

### 0.4.2 Reference range plus framework

Reference range plus framework applies to continuous data. In this example, data is extracted from the sample data that accompany the software. Here, “Genotype” is the effect of interest. The response is stored in the variable “data\_point” and genotype (Genotype) and sex (Sex) are covariates.

```
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
```

```
## 2025-10-30 01:31:09.595311. OpenStats loaded.
```

```
## 2025-10-30 01:31:09.597065. Checking the input model for including functions ...
```

```
## 2025-10-30 01:31:09.59776. Reference Range Plus (RR framework) in progress ...
```

```
## 2025-10-30 01:31:09.598406. Optimisation level:
```

```
## 2025-10-30 01:31:09.599066.  Estimation of all factor combination effects = TRUE
```

```
## 2025-10-30 01:31:09.599705.  Estimation of inter level factors for the response = FALSE
```

```
## 2025-10-30 01:31:09.600827. The input formula: data_point ~ Genotype + Sex
```

```
## 2025-10-30 01:31:09.60155. The reformatted formula for the algorithm: ~data_point + Genotype + Sex
```

```
## 2025-10-30 01:31:09.602359. The probability of the middle area in the distribution: 0.95
```

```
## 2025-10-30 01:31:09.602987.   Tails probability: 0.025
## 2025-10-30 01:31:09.602987.   Formula to calculate the tail probabilities: 1-(1-x)/2, (1-x)/2 where x = 0.95
```

```
## 2025-10-30 01:31:09.603667. Discritizing the continuous data into discrete levels. The quantile = 0.975
```

```
## 2025-10-30 01:31:09.604309. Stp 1. Low versus Normal/High
```

```
## 2025-10-30 01:31:09.605069. Removing possible leading/trailing whitespace from the variables in the formula ...
```

```
## 2025-10-30 01:31:09.60719. Preparing the reference ranges ...
```

```
## 2025-10-30 01:31:09.607823. Preparing the data for the variable: Genotype
```

```
## 2025-10-30 01:31:09.608532. Reference level is set to `control`
```

```
## 2025-10-30 01:31:09.612101.  Initial quantiles for cutting the data
## 2025-10-30 01:31:09.612101.           Probs: 0, 0.025, 1
## 2025-10-30 01:31:09.612101.           N.reference: 397
## 2025-10-30 01:31:09.612101.           Quantiles: 6.04, 8.08, 17.73
```

```
## 2025-10-30 01:31:09.613203.   Detected percentiles in the data (8 decimals): Low = 0.02518892, NormalHigh = 0.97481108
```

```
## 2025-10-30 01:31:09.617017.  Spliting on Sex ...
```

```
## 2025-10-30 01:31:09.618273. Preparing the data for the combined effect: Female
```

```
## 2025-10-30 01:31:09.618996. Reference level is set to `control`
```

```
## 2025-10-30 01:31:09.620846.  Initial quantiles for cutting the data
## 2025-10-30 01:31:09.620846.           Probs: 0, 0.025, 1
## 2025-10-30 01:31:09.620846.           N.reference: 196
## 2025-10-30 01:31:09.620846.           Quantiles: 7.579, 9.267, 17.73
```

```
## 2025-10-30 01:31:09.62187.    Detected percentiles in the data (8 decimals): Low = 0.0255102, NormalHigh = 0.9744898
```

```
## 2025-10-30 01:31:09.623804. Preparing the data for the combined effect: Male
```

```
## 2025-10-30 01:31:09.624546. Reference level is set to `control`
```

```
## 2025-10-30 01:31:09.626343.  Initial quantiles for cutting the data
## 2025-10-30 01:31:09.626343.           Probs: 0, 0.025, 1
## 2025-10-30 01:31:09.626343.           N.reference: 201
## 2025-10-30 01:31:09.626343.           Quantiles: 6.04, 7.673, 15.645
```

```
## 2025-10-30 01:31:09.627338.   Detected percentiles in the data (8 decimals): Low = 0.02985075, NormalHigh = 0.97014925
```

```
## 2025-10-30 01:31:09.629321. Stp 2. Low/Normal versus High
```

```
## 2025-10-30 01:31:09.630147. Removing possible leading/trailing whitespace from the variables in the formula ...
```

```
## 2025-10-30 01:31:09.632192. Preparing the reference ranges ...
```

```
## 2025-10-30 01:31:09.632799. Preparing the data for the variable: Genotype
```

```
## 2025-10-30 01:31:09.633539. Reference level is set to `control`
```

```
## 2025-10-30 01:31:09.636978.  Initial quantiles for cutting the data
## 2025-10-30 01:31:09.636978.           Probs: 0, 0.975, 1
## 2025-10-30 01:31:09.636978.           N.reference: 397
## 2025-10-30 01:31:09.636978.           Quantiles: 6.04, 14.5, 17.73
```

```
## 2025-10-30 01:31:09.63802.    Detected percentiles in the data (8 decimals): LowNormal = 0.97481108, High = 0.02518892
```

```
## 2025-10-30 01:31:09.641979.  Spliting on Sex ...
```

```
## 2025-10-30 01:31:09.643339. Preparing the data for the combined effect: Female
```

```
## 2025-10-30 01:31:09.6441. Reference level is set to `control`
```

```
## 2025-10-30 01:31:09.646036.  Initial quantiles for cutting the data
## 2025-10-30 01:31:09.646036.           Probs: 0, 0.975, 1
## 2025-10-30 01:31:09.646036.           N.reference: 196
## 2025-10-30 01:31:09.646036.           Quantiles: 7.579, 14.744, 17.73
```

```
## 2025-10-30 01:31:09.647063.   Detected percentiles in the data (8 decimals): LowNormal = 0.9744898, High = 0.0255102
```

```
## 2025-10-30 01:31:09.648953. Preparing the data for the combined effect: Male
```

```
## 2025-10-30 01:31:09.649659. Reference level is set to `control`
```

```
## 2025-10-30 01:31:09.651537.  Initial quantiles for cutting the data
## 2025-10-30 01:31:09.651537.           Probs: 0, 0.975, 1
## 2025-10-30 01:31:09.651537.           N.reference: 201
## 2025-10-30 01:31:09.651537.           Quantiles: 6.04, 13.527, 15.645
```

```
## 2025-10-30 01:31:09.652614.   Detected percentiles in the data (8 decimals): LowNormal = 0.97014925, High = 0.02985075
```

```
## 2025-10-30 01:31:09.654553. Fisher exact test with 1500 iteration(s) in progress ...
```

```
## 2025-10-30 01:31:09.655168. Analysing Low vs NormalHigh ...
```

```
## 2025-10-30 01:31:09.738743. Analysing LowNormal vs High ...
```

```
## 2025-10-30 01:31:09.81813. RR framework executed in 0.22 second(s).
```

### 0.4.3 Fisher’s exact test framework

Fisher’s Exact test framework applies to categorical data. In this example, data is extracted from the sample data that accompany the software. Here, Genotype is the effect of interest. The response is stored in the variable *category* and Genotype and Sex are the covariates.

```
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
```

```
## 2025-10-30 01:31:09.911995. OpenStats loaded.
```

```
## 2025-10-30 01:31:09.913794. Checking the input model for including functions ...
```

```
## 2025-10-30 01:31:09.914516. Fisher Exact Test (FE framework) in progress ...
```

```
## 2025-10-30 01:31:09.915101. Optimisation level:
```

```
## 2025-10-30 01:31:09.915694.  Estimation of all factor combination effects = TRUE
```

```
## 2025-10-30 01:31:09.916304.  Estimation of inter level factors for the response = FALSE
```

```
## 2025-10-30 01:31:09.917345. The input formula: Thoracic.Processes ~ Genotype + Sex
```

```
## 2025-10-30 01:31:09.918082. The reformatted formula for the algorithm: ~Thoracic.Processes + Genotype + Sex
```

```
## 2025-10-30 01:31:09.918719.  Top framework: FE
```

```
## 2025-10-30 01:31:09.919319. Fisher exact test with 1500 iteration(s) in progress ...
```

```
## 2025-10-30 01:31:09.91997. Check missings in progress ...
```

```
## 2025-10-30 01:31:09.920686.   Missings in variable `Thoracic.Processes`: 0.32%
```

```
## 2025-10-30 01:31:09.921414.   Missings in variable `Genotype`: 0%
```

```
## 2025-10-30 01:31:09.922069.   Missings in variable `Sex`: 0%
```

```
## 2025-10-30 01:31:09.922732. Removing possible leading/trailing whitespace from the variables in the formula ...
```

```
## 2025-10-30 01:31:09.925076. Step 1. Testing "Thoracic.Processes"
```

```
## 2025-10-30 01:31:09.926126. The data (variable(s) = Thoracic.Processes) contain 2 missing(s) ...
## 2025-10-30 01:31:09.926126.  Missing data removed
```

```
## 2025-10-30 01:31:09.927323.  The response variable `Thoracic.Processes` is not categorical.
```

```
## 2025-10-30 01:31:09.927913. Step 2. Testing "Genotype"
```

```
## 2025-10-30 01:31:09.929451.  Testing for the main effect: Sex
```

```
## 2025-10-30 01:31:09.933441. Total tested categories = 1: Genotype
```

```
## 2025-10-30 01:31:09.934101.  Total tests =  1
```

```
## 2025-10-30 01:31:09.934826. FE framework  executed in 0.02 second(s).
```

## 0.5 Summary and export

*OpenStats* package stores the input data in *OpenStatsList* and the results of statistical analyses in the *OpenStatsMM/RR/FE* or *OpenStatsComplementarySplit* object. The standard *summary/print* function applies to print off a summary table. The summary table encompasses:

* **OpenStatsList** object: descriptive statistics such as counts, missing, mean, sd etc.
* **OpenStatsMM/RR/FE** object:
  + Applied model
  + Checked/optimised model
  + Treatment group
  + Control group
  + If possible, whether sexual dimorphism is detected from the analysis
  + Genotype effect p-value
  + Genotype effect p-value for females
  + Genotype effect p-value for males
  + If LifeStage existed in the data, LifeStage p-value
  + Genotype effect for early adults
  + Genotype effect for late adults
  + If Sex existed in the data, Sex p-value
  + If bodyweight existed in the data, bodyweight p-value
* **OpenStatsComplementarySplit** object: A set of summaries similar to *OpenStatsMM/RR/FE* for each level of splits, for example, separate summaries for males and females.

The function *OpenStatsReport* can be used to create a table of detailed summary from *OpenStatsMM/RR/FE* object in the form of either list or JSON. The following is an example of the summary output of the liner mixed model framework.

```
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
```

```
## 2025-10-30 01:31:10.589702. Working out the summary table ...
```

```
##
##
## =============================  =============================================================================================
## Statistic                      Value
## =============================  =============================================================================================
## Applied framework              Linear Mixed Model framework, LME, including Weight
## Final model                    data_point ~ Genotype + Weight
## ............................   ............................
## Tested Gene                    experimental
## Reference Gene                 control
## ............................   ............................
## Sexual dimorphism detected?    FALSE, Genotype-Sex interaction is not part of the input (it is not part of the final) model.
## ............................   ............................
## Genotype contribution overall  0.343064968220182
## Genotype contribution Females  -
## Genotype contribution Males    -
## ............................   ............................
## LifeStage contribution         -
## Genotype contribution Early    -
## Genotype contribution Late     -
## ............................   ............................
## Sex contribution               -
## Body weight contribution       0
## =============================  =============================================================================================
```

*OpenStatsReport* function was developed for large scale application where automatic implementation is require. Following is the JSON output of the function from an *OpenStatsMM* object (cut to the first 1500 charachters):

```
strtrim(
  OpenStatsReport(
    object = MM_result,
    JSON = TRUE,
    RemoveNullKeys = TRUE,
    pretty = TRUE
  ),
  1500
)
```

```
## {
##   "Applied method": "Linear Mixed Model framework, LME, including Weight",
##   "Dependent variable": "data_point",
##   "Batch included": true,
##   "Residual variances homogeneity": false,
##   "Genotype contribution": {
##     "Overall": 0.343064968220182,
##     "Sexual dimorphism detected": {
##       "Criteria": false,
##       "Note": "Genotype-Sex interaction is not part of the input (it is not part of the final) model. "
##     }
##   },
##   "Genotype estimate": {
##     "Value": -0.502512881011737,
##     "Confidence": {
##       "Genotypeexperimental lower": -1.54340604650595,
##       "Genotypeexperimental upper": 0.538380284482477
##     },
##     "Level": 0.95
##   },
##   "Genotype standard error": 0.529316714411108,
##   "Genotype p-value": 0.343064968220182,
##   "Genotype percentage change": {
##     "control Genotype": -4.66480561595459,
##     "experimental Genotype": 8.36889856564581
##   },
##   "Genotype effect size": {
##     "Value": -0.572742110247569,
##     "Variable": "Genotype",
##     "Model": "data_point ~ Genotype",
##     "Type": "Mean differences. Formula = (mu_treatment - mu_control)/sd(residuals)",
##     "Percentage change": {
##       "control Genotype": -4.66480561595459,
##       "experimental Genotype": 8.36889856564581
##     }
##   },
##   "Weight estimate": {
##     "Value": -0.390270185750165,
##     "Confidence": {
##       "Weight lower": -0.432146253284604,
##       "Weight upper": -0.348394118215727
##     },
##     "Level": 0.95
##   },
##   "Weight standard error": 0.0212948871359552,
##   "Weight p-value": 0,
##   "Weight effect size": {
##     "Value": -0.598034137811873,
##     "Variable": "Weight",
##     "
```

## 0.6 Graphics

Graphics in *OpenStats* are as easy as calling the **plot()** function on a OpenStatsList or the OpenStatsMM/FE/RR object. Calling the plot function on the OpenStatsList object is shown below:

```
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
```

```
## 2025-10-30 01:31:10.883745. Working on the plot ...
```

![](data:image/png;base64...)

```
summary(
  OpenStatsList,
  style     = "grid",
  varnumbers = FALSE, # See more options ?summarytools::dfSummary
  graph.col = FALSE, # Do not show the graph column
  valid.col = FALSE
)
```

```
## 2025-10-30 01:31:11.112554. Working on the summary table ...
```

```
## Error in match.call(f, call): ... used in a situation where it does not exist
```

```
## Warning in parse_call(mc = match.call(), var_name = get_var_info, var_label =
## get_var_info, : metadata extraction terminated unexpectedly; inspect results
## carefully
```

```
## Data Frame Summary
## Dimensions: 410 x 6
## Duplicates: 320
##
## +--------------------+------------------------------+--------------------+---------+
## | Variable           | Stats / Values               | Freqs (% of Valid) | Missing |
## +====================+==============================+====================+=========+
## | Genotype           | 1. control                   | 397 (96.8%)        | 0       |
## | [factor]           | 2. experimental              |  13 ( 3.2%)        | (0.0%)  |
## +--------------------+------------------------------+--------------------+---------+
## | Sex                | 1. Female                    | 201 (49.0%)        | 0       |
## | [factor]           | 2. Male                      | 209 (51.0%)        | (0.0%)  |
## +--------------------+------------------------------+--------------------+---------+
## | Batch              | 1. 2012-07-23T00:00:00Z      |  10 ( 2.4%)        | 0       |
## | [factor]           | 2. 2012-07-30T00:00:00Z      |  10 ( 2.4%)        | (0.0%)  |
## |                    | 3. 2012-08-06T00:00:00Z      |  10 ( 2.4%)        |         |
## |                    | 4. 2012-08-13T00:00:00Z      |  10 ( 2.4%)        |         |
## |                    | 5. 2012-08-20T00:00:00Z      |   9 ( 2.2%)        |         |
## |                    | 6. 2012-11-26T00:00:00Z      |  10 ( 2.4%)        |         |
## |                    | 7. 2012-12-24T00:00:00Z      |  10 ( 2.4%)        |         |
## |                    | 8. 2013-01-02T00:00:00Z      |  10 ( 2.4%)        |         |
## |                    | 9. 2013-01-15T00:00:00Z      |   9 ( 2.2%)        |         |
## |                    | 10. 2013-01-21T00:00:00Z     |   4 ( 1.0%)        |         |
## |                    | [ 33 others ]                | 318 (77.6%)        |         |
## +--------------------+------------------------------+--------------------+---------+
## | age_in_weeks       | Mean (sd) : 7.5 (0.6)        | 6 :   8 ( 2.0%)    | 0       |
## | [integer]          | min < med < max:             | 7 : 216 (52.7%)    | (0.0%)  |
## |                    | 6 < 7 < 9                    | 8 : 174 (42.4%)    |         |
## |                    | IQR (CV) : 1 (0.1)           | 9 :  12 ( 2.9%)    |         |
## +--------------------+------------------------------+--------------------+---------+
## | phenotyping_center | 1. JAX                       | 410 (100.0%)       | 0       |
## | [character]        |                              |                    | (0.0%)  |
## +--------------------+------------------------------+--------------------+---------+
## | metadata_group     | 1. 1d91d45f80eed65ea2122ebeb | 410 (100.0%)       | 0       |
## | [character]        |                              |                    | (0.0%)  |
## +--------------------+------------------------------+--------------------+---------+
```

There are also graphics for the OpenStatsMM/FE/RR. Here is the list of plots for each framework:

Linear mixed model framework:

* Residual versus fitted values
* Residual density plot and the normality test p-value
* Residual Q-Q plot
* The density plot of the response variable and the normality test p-value

Reference Range plus frameworks:

* Mosaic plot of the discretised response versus Genotype/Sex/LifeStage (if they exist in the data
* Mosaic plot of the Sex versus Genotype (if they exist in the data)

Fisher’s exact test framework:

* Mosaic plot of the response versus Genotype/Sex/LifeStage (if they exist in the data
* Mosaic plot of the Sex versus Genotype (if they exist in the data)

Below shows an example for the *OpenStatsMM* output:

```
plot(MM_result, col = 2)
```

```
## 2025-10-30 01:31:11.437175. Working on the plot ...
```

```
## 2025-10-30 01:31:11.440594. The normality test result/p-value should be considered carefully.
```

![](data:image/png;base64...)

### 0.6.1 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] OpenStats_1.22.0 nlme_3.1-168
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6       xfun_0.53          bslib_0.9.0        ggplot2_4.0.0
##  [5] htmlwidgets_1.6.4  rlist_0.4.6.2      lattice_0.22-7     summarytools_1.1.4
##  [9] vctrs_0.6.5        tools_4.5.1        generics_0.1.4     stats4_4.5.1
## [13] parallel_4.5.1     tibble_3.3.0       cluster_2.1.8.1    pkgconfig_2.0.3
## [17] Matrix_1.7-4       data.table_1.17.8  checkmate_2.3.3    pryr_0.1.6
## [21] RColorBrewer_1.1-3 S7_0.2.0           lifecycle_1.0.4    compiler_4.5.1
## [25] farver_2.1.2       stringr_1.5.2      rapportools_1.2    codetools_0.2-20
## [29] carData_3.0-5      htmltools_0.5.8.1  AICcmodavg_2.3-4   sass_0.4.10
## [33] yaml_2.3.10        htmlTable_2.4.3    Formula_1.2-5      tidyr_1.3.1
## [37] pillar_1.11.1      car_3.1-3          jquerylib_0.1.4    MASS_7.3-65
## [41] cachem_1.1.0       magick_2.9.0       Hmisc_5.2-4        rpart_4.1.24
## [45] abind_1.4-8        tidyselect_1.2.1   digest_0.6.37      stringi_1.8.7
## [49] purrr_1.1.0        reshape2_1.4.4     pander_0.6.6       dplyr_1.1.4
## [53] labeling_0.4.3     splines_4.5.1      fastmap_1.2.0      grid_4.5.1
## [57] colorspace_2.1-2   cli_3.6.5          magrittr_2.0.4     base64enc_0.1-3
## [61] dichromat_2.0-0.1  survival_3.8-3     foreign_0.8-90     withr_3.0.2
## [65] scales_1.4.0       backports_1.5.0    unmarked_1.5.1     lubridate_1.9.4
## [69] timechange_0.3.0   rmarkdown_2.30     matrixStats_1.5.0  nnet_7.3-20
## [73] gridExtra_2.3      VGAM_1.1-13        evaluate_1.0.5     knitr_1.50
## [77] tcltk_4.5.1        rlang_1.1.6        Rcpp_1.1.0         xtable_1.8-4
## [81] glue_1.8.0         rstudioapi_0.17.1  jsonlite_2.0.0     plyr_1.8.9
## [85] R6_2.6.1
```