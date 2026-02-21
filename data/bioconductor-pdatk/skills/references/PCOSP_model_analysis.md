# PCOSP: Pancreatic Cancer Overall Survival Predictor

Vandana Sandhu, Heewon Seo, Christopher Eeles1\* and Benjamin Haibe-Kains1,2\*\*

1Bioinformatics and Computational Genomics Laboratory, Princess Margaret Cancer Center, University Health Network, Toronto, Ontario, Canada
2Department of Medical Biophysics, University of Toronto, Toronto, Canada

\*christopher.eeles@uhnresearch.ca
\*\*benjamin.haibe.kains@utoronto.ca

#### 2021-02-01

# Contents

* [1 Pancreatic Cancer Overall Survival Predictor](#pancreatic-cancer-overall-survival-predictor)
  + [1.1 Split Training and Validation Data](#split-training-and-validation-data)
  + [1.2 Setup A `PCOSP` Model Object](#setup-a-pcosp-model-object)
  + [1.3 Training a PCOSP Model](#training-a-pcosp-model)
  + [1.4 Risk Prediction with a PCOSP Model](#risk-prediction-with-a-pcosp-model)
  + [1.5 Validating A PCOSP Model](#validating-a-pcosp-model)
  + [1.6 Plotting Model Performance](#plotting-model-performance)
* [2 Permutations Testing for a PCOSP Model](#permutations-testing-for-a-pcosp-model)
  + [2.1 Random Label Shuffling Model](#random-label-shuffling-model)
    - [2.1.1 Construct the Model Object](#construct-the-model-object)
    - [2.1.2 Train the Model](#train-the-model)
    - [2.1.3 Predict the Classes](#predict-the-classes)
    - [2.1.4 Validate Model Performance](#validate-model-performance)
    - [2.1.5 Compare with a PCOSP Model](#compare-with-a-pcosp-model)
  + [2.2 Random Gene Assignment Model](#random-gene-assignment-model)
    - [2.2.1 Construct the Model Object](#construct-the-model-object-1)
    - [2.2.2 Train the Model](#train-the-model-1)
    - [2.2.3 Predict the Classes](#predict-the-classes-1)
    - [2.2.4 Validate Model Performance](#validate-model-performance-1)
    - [2.2.5 Compare RGAModel to PCOSP](#compare-rgamodel-to-pcosp)
* [3 Pathway Analysis of a PCOSP Model](#pathway-analysis-of-a-pcosp-model)
  + [3.1 Get the Top Predictive Features](#get-the-top-predictive-features)
  + [3.2 Querying Genesets for Enriched Pathways](#querying-genesets-for-enriched-pathways)
* [4 Clinical Model Comparison](#clinical-model-comparison)
  + [4.1 Build the Model](#build-the-model)
  + [4.2 Train the Model](#train-the-model-2)
  + [4.3 Predict the Classes](#predict-the-classes-2)
  + [4.4 Validate the Model](#validate-the-model)
  + [4.5 Visualize Comparison with PCOSP Model](#visualize-comparison-with-pcosp-model)
* [5 Comparing PCOSP Models to Existing Published Classifiers](#comparing-pcosp-models-to-existing-published-classifiers)
  + [5.1 Make the Models](#make-the-models)
  + [5.2 Predict the Classes](#predict-the-classes-3)
  + [5.3 Validate the Models](#validate-the-models)
  + [5.4 Model Performance Meta-Analysis](#model-performance-meta-analysis)
* [6 Comparing PCOSP Models By Patient Subtype](#comparing-pcosp-models-by-patient-subtype)
* [7 References](#references)
* **Appendix**

# 1 Pancreatic Cancer Overall Survival Predictor

As an example of the utility of the PDATK package, we provide code
replicating the analysis published in Sandhu *et al.* (2019). While the
code presented here is run on a subset of the original data to ensure that
the PDATK installation size is not too large, the full data from that study can
is available via the `MetaGxPancreas` Bioconductor data package.

```
data(sampleCohortList)
sampleCohortList
```

```
## CohortList of length 11
## names(11): ICGCMICRO ICGCSEQ PCSI TCGA KIRBY UNC CHEN COLLISON ZHANG OUH WINTER
```

## 1.1 Split Training and Validation Data

To get started using PDATK, place each of your patient cohorts into
`SurvivalExperiment` objects and then assemble those into a master `CohortList`,
which holds the training and validation data for use with the various
`SurvivalModel`s in this package.

```
commonGenes <- findCommonGenes(sampleCohortList)
# Subsets all list items, with subset for specifying rows and select for
# specifying columns
cohortList <- subset(sampleCohortList, subset=commonGenes)

ICGCcohortList <- cohortList[grepl('ICGC', names(cohortList), ignore.case=TRUE)]
validationCohortList <- cohortList[!grepl('icgc', names(cohortList),
    ignore.case=TRUE)]
```

Since we are interested in predicting survival, it is necessary to remove
patients with insufficient data to be useful. In general, we want to remove
patients who did not have an event in our period of interest. As such we remove
samples who dropped out of a study, but did not pass away before the first year.

```
validationCohortList <- dropNotCensored(validationCohortList)
ICGCcohortList <- dropNotCensored(ICGCcohortList)
```

We have now split our patient cohorts into training and validation data. For
this analysis we will be training using the ICGC cohorts, which includes one
cohort with RNA micro-array data and another with RNA sequencing data. When
using multiple cohorts to train a model, it is required that those cohorts share
samples. As a result we will take as training data all patients shared between
the two cohorts and leave the remainder of patients as part of our
validationData.

```
# find common samples between our training cohorts in a cohort list
commonSamples <- findCommonSamples(ICGCcohortList)

# split into shared samples for training, the rest for testing
ICGCtrainCohorts <- subset(ICGCcohortList, select=commonSamples)
ICGCtestCohorts <- subset(ICGCcohortList, select=commonSamples, invert=TRUE)

# merge our training cohort test data into the rest of the validation data
validationCohortList <- c(ICGCtestCohorts, validationCohortList)

# drop ICGCSEQ from the validation data, because it only has 7 patients
validationCohortList <-
    validationCohortList[names(validationCohortList) != 'ICGCSEQ']
```

## 1.2 Setup A `PCOSP` Model Object

We now have patient molecular data, annotated with the number of days survived
since treatment and the survival status and are ready to apply a `SurvivalModel`
to this data. In this example, we are applying a Pancreatic Cancer Overall
Survival Model, as described in . This class uses the
`switchBox` package to create an ensemble of binary classifiers, whos votes are
then tallied into a PCOSP score. A PCOSP score is simply the proportion of
models predicting good survival out of the total number of models in the
ensemble.

```
set.seed(1987)
PCOSPmodel <- PCOSP(ICGCtrainCohorts, minDaysSurvived=365, randomSeed=1987)

# view the model parameters; these make your model run reproducible
metadata(PCOSPmodel)$modelParams
```

```
## $randomSeed
## [1] 1987
##
## $RNGkind
## [1] "Mersenne-Twister" "Inversion"        "Rejection"
##
## $minDaysSurvived
## [1] 365
```

## 1.3 Training a PCOSP Model

To simplify working with different `SurvivalModel` sub-classes, we have
implemented a standard work-flow that is valid for all `SurvivalModel`s.
This involves first training the model, then using it to predict
risk/risk-classes for a set of validation cohorts and finally assessing
performance on the validation data.

To train a model, the `trainModel` method is used. This function abstracts away
the implementation of model training, allowing end-users to focus on applying
the `SurvivalModel` to make predictions without a need to understand the model
internals. We hope this will make the package useful for those unfamiliar or
uninterested in the details of survival prediction methods.

For training a PCOSP model there are two parameters. First, `numModels` is the
number of models to train for use in the ensemble classifier to predict PCOSP
scores. To keep computation brief, we are only training 25 models. However, it
is recommended to use a minimum of 1000 for real world applications. The second
parameter is `minAccuracy`, which is the minimum model accuracy for a trained
model to included in the final model ensemble. Paradoxically, increasing this
too high can actually decrease the overall performance of the PCOSP model. We
recommend 0.6 as a sweet spot between random chance and over-fitting but
encourage experimentation to see what works best with your data.

```
trainedPCOSPmodel <- trainModel(PCOSPmodel, numModels=15, minAccuracy=0.6)

metadata(trainedPCOSPmodel)$modelParams
```

```
## $randomSeed
## [1] 1987
##
## $RNGkind
## [1] "Mersenne-Twister" "Inversion"        "Rejection"
##
## $minDaysSurvived
## [1] 365
##
## $numModels
## [1] 15
##
## $minAccuracy
## [1] 0.6
```

We can see that after training, the additional model parameters are added to the
`modelParams` item in the model `metadata`. The goal is to ensure that your
model training, prediction and validation are fully reproducible by capturing
the parameters relevant to a specific model.

## 1.4 Risk Prediction with a PCOSP Model

After training, a model can now be used with new data to make risk predictions
and classify samples into ‘good’ or ‘bad’ survival groups. To do this, the
standard `predictClasses` method is used. Similar to `trainData`, we have
abstracted away the implementation details to provide users with a simple,
consistent interface for using `SurvivalModel` sub-classes to make patient risk
predictions.

```
PCOSPpredValCohorts <- predictClasses(validationCohortList,
    model=trainedPCOSPmodel)
```

The returned `CohortList` object now indicates that each of the cohorts have
predictions. This information is available in the `elementMetadata` slot of
the cohort list and can be accessed with the `mcols` function from `S4Vectors`.

```
mcols(PCOSPpredValCohorts)
```

```
## DataFrame with 10 rows and 2 columns
##             mDataType hasPredictions
##           <character>      <logical>
## ICGCMICRO   rna_micro           TRUE
## PCSI          rna_seq           TRUE
## TCGA          rna_seq           TRUE
## KIRBY         rna_seq           TRUE
## UNC         rna_micro           TRUE
## CHEN        rna_micro           TRUE
## COLLISON    rna_micro           TRUE
## ZHANG       rna_micro           TRUE
## OUH         rna_micro           TRUE
## WINTER      rna_micro           TRUE
```

Predicting risk with a specific model adds a corresponding metadata
column to the object `colData`. In the case of a `PCOSP` model, the new column
is called `PCOSP_prob_good` and represents the proportion of models in the
ensemble which predicted good survival for a given sample.

```
knitr::kable(head(colData(PCOSPpredValCohorts[[1]])))
```

|  | unique\_patient\_ID | grade | sex | age | T | N | M | sample\_type | sample\_name | survival\_time | event\_occurred | prognosis | PCOSP\_prob\_good |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ICGC\_0001 | ICGC\_0001 | G1 | M | 59 | T2 | N0 | M0 | tumour | ICGC\_0001 | 522 | 1 | good | 0.6666667 |
| ICGC\_0002 | ICGC\_0002 | G2 | F | 77 | T2 | N1a | MX | tumour | ICGC\_0002 | 2848 | 1 | good | 0.4666667 |
| ICGC\_0003 | ICGC\_0003 | G2 | F | 58 | T3 | N1a | MX | tumour | ICGC\_0003 | 1778 | 0 | good | 0.9333333 |
| ICGC\_0004 | ICGC\_0004 | G2 | F | 78 | T2 | N0 | MX | tumour | ICGC\_0004 | 1874 | 1 | good | 1.0000000 |
| ICGC\_0005 | ICGC\_0005 | G3 | M | 63 | T3 | N1b | MX | tumour | ICGC\_0005 | 641 | 1 | good | 0.5333333 |
| ICGC\_0008 | ICGC\_0008 | G2 | M | 72 | T3 | N1b | MX | tumour | ICGC\_0008 | 1209 | 1 | good | 0.8000000 |

Additionally, binary predictions of good or bad survival can be found in the
`PCOSPpredictions` item of each `SurvivalExperiment`s `metadata`. This contains
the raw predictions from the model for each classifier in the ensemble, ordered
by classifier accuracy. This data is not important for end users, but is used
internally when calculating validation statistics for the model. For users
wishing to classify samples rather than estimate risks, we recommend a
PCOSP cut-off of >0.5 for good survival prognosis.

```
knitr::kable(metadata(PCOSPpredValCohorts[[1]])$PCOSPpredictions[1:5, 1:5])
```

|  | ICGC\_0001 | ICGC\_0002 | ICGC\_0003 | ICGC\_0004 | ICGC\_0005 |
| --- | --- | --- | --- | --- | --- |
| rank1 | bad | bad | good | good | good |
| rank2 | good | good | good | good | bad |
| rank3 | good | good | good | good | good |
| rank4 | bad | good | good | good | good |
| rank5 | good | bad | good | good | bad |

## 1.5 Validating A PCOSP Model

The final step in the standard `SurvivalModel` work-flow is to compute
model performance statistics for the model on the validation data. This can be
accomplished using the `validateModel` method, which will add statistics to the
`validationStats` slot of a `SurvivalModel` object and the data to the
`validationData` slot.

```
validatedPCOSPmodel <- validateModel(trainedPCOSPmodel,
    valData=PCOSPpredValCohorts)
```

```
knitr::kable(head(validationStats(validatedPCOSPmodel)))
```

| statistic | estimate | se | lower | upper | p\_value | n | cohort | isSummary | mDataType |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AUC | 0.7070000 | 0.0470000 | 0.6150000 | 0.7990000 | 0.0000142 | 158 | ICGCMICRO | FALSE | rna\_micro |
| log\_D\_index | 0.5956475 | 0.1592665 | 0.4882238 | 0.7030711 | 0.0001668 | 158 | ICGCMICRO | FALSE | rna\_micro |
| concordance\_index | 0.6434057 | 0.0321350 | 0.5804223 | 0.7063892 | 0.0000081 | 158 | ICGCMICRO | FALSE | rna\_micro |
| AUC | 0.6400000 | 0.0570000 | 0.5280000 | 0.7530000 | 0.0088634 | 107 | PCSI | FALSE | rna\_seq |
| log\_D\_index | 0.4697159 | 0.1838308 | 0.3457239 | 0.5937078 | 0.0105421 | 107 | PCSI | FALSE | rna\_seq |
| concordance\_index | 0.6212825 | 0.0387126 | 0.5454073 | 0.6971577 | 0.0017309 | 107 | PCSI | FALSE | rna\_seq |

Examining the `data.table` from the `validationStats` slot we can see that three
model performance statistics have been calculated for all of the validation
cohorts. Additionally, aggregate statistics have been calculated by molecular
data type and for all cohorts combined. This table can be used to generate
model performance plots. We have included several functions for examining
model performance.

## 1.6 Plotting Model Performance

```
PCOSPdIndexForestPlot <- forestPlot(validatedPCOSPmodel, stat='log_D_index')
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the PDATK package.
##   Please report the issue at <https://github.com/bhklab/PDATK/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
PCOSPdIndexForestPlot
```

![](data:image/png;base64...)

```
PCOSPconcIndexForestPlot <- forestPlot(validatedPCOSPmodel, stat='concordance_index')
PCOSPconcIndexForestPlot
```

![](data:image/png;base64...)

```
cohortROCplots <- plotROC(validatedPCOSPmodel, alpha=0.05)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the PDATK package.
##   Please report the issue at <https://github.com/bhklab/PDATK/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the PDATK package.
##   Please report the issue at <https://github.com/bhklab/PDATK/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
cohortROCplots
```

![](data:image/png;base64...)

# 2 Permutations Testing for a PCOSP Model

To compare the performance of a PCOSP model to random chance, we have
included two model classes which permute either patient prognosis labels or
the feature names. These models can be used to evaluate if a PCOSP model
performs better than random chance.

## 2.1 Random Label Shuffling Model

The `RLSModel` class is a `SurvivalModel` using the same risk prediction
algorithm as a `PCOSP` model, but randomizing the patient prognosis labels
in each of the individual KTSP classifiers used in the classification ensemble.
Given this random prognosis label shuffling, we expect the classification
results for this model to be no better than random chance.

The work-flow for this model follows the standard `SurvivalModel` sub-class
work-flow.

### 2.1.1 Construct the Model Object

```
# Merge to a single SurvivalExperiment
ICGCtrainCohorts <- merge(ICGCtrainCohorts[[1]], ICGCtrainCohorts[[2]],
    cohortNames=names(ICGCtrainCohorts))
RLSmodel <- RLSModel(ICGCtrainCohorts, minDaysSurvived=365, randomSeed=1987)
```

### 2.1.2 Train the Model

```
trainedRLSmodel <- trainModel(RLSmodel, numModels=15)
```

### 2.1.3 Predict the Classes

```
RLSpredCohortList <- predictClasses(validationCohortList, model=trainedRLSmodel)
```

```
## Warning in FUN(X[[i]], ...):
## [PDATK::NULL] Dropped samples with NA survival data!
## Warning in FUN(X[[i]], ...):
## [PDATK::NULL] Dropped samples with NA survival data!
## Warning in FUN(X[[i]], ...):
## [PDATK::NULL] Dropped samples with NA survival data!
```

### 2.1.4 Validate Model Performance

```
validatedRLSmodel <- validateModel(trainedRLSmodel, RLSpredCohortList)
```

### 2.1.5 Compare with a PCOSP Model

To compare the performance of a permuted model to that of a PCOSP model, we
have included the `densityPlotModelComparion` method, which plots a
density plot of model AUCs per molecular data type and overall. The dotted
line represents the mean AUC of the PCOSP model. From this plot we can
see that the PCOSP model performs significantly better than the random label
shuffling model.

```
RLSmodelComparisonPlot <- densityPlotModelComparison(validatedRLSmodel,
    validatedPCOSPmodel, title='Random Label Shuffling vs PCOSP',
    mDataTypeLabels=c(rna_seq='Sequencing-based', rna_micro='Array-based',
        combined='Overall'))
RLSmodelComparisonPlot
```

![](data:image/png;base64...)

## 2.2 Random Gene Assignment Model

A `RandomGeneAssignmentModel` (aliased as `RGAModel` for user convenience)
is similar to a `RLSModel` except that the gene labels are randomized for
each KTSP classifier in the ensemble. In this case, we also expect this
model to perform no better than random chance.

### 2.2.1 Construct the Model Object

```
RGAmodel <- RGAModel(ICGCtrainCohorts, randomSeed=1987)
```

### 2.2.2 Train the Model

```
trainedRGAmodel <- trainModel(RGAmodel, numModels=15)
```

### 2.2.3 Predict the Classes

```
RGApredCohortList <- predictClasses(validationCohortList,
    model=trainedRGAmodel)
```

```
## Warning in FUN(X[[i]], ...):
## [PDATK::NULL] Dropped samples with NA survival data!
## Warning in FUN(X[[i]], ...):
## [PDATK::NULL] Dropped samples with NA survival data!
## Warning in FUN(X[[i]], ...):
## [PDATK::NULL] Dropped samples with NA survival data!
```

### 2.2.4 Validate Model Performance

```
validatedRGAmodel <- validateModel(trainedRGAmodel, RGApredCohortList)
```

### 2.2.5 Compare RGAModel to PCOSP

The density plot for the `RGAModel` also shows that the `PCOSP` model does
significantly better than random chance.

```
RGAmodelComparisonPlot <-  densityPlotModelComparison(validatedRGAmodel,
    validatedPCOSPmodel, title='Random Gene Assignment vs PCOSP',
    mDataTypeLabels=c(rna_seq='Sequencing-based', rna_micro='Array-based',
        combined='Overall'))
RGAmodelComparisonPlot
```

![](data:image/png;base64...)

# 3 Pathway Analysis of a PCOSP Model

Confident that the PCOSP model is performing better than random chance at
prediction patient survival, we can now begin to look into the features that
are most relevant to these predictions. Once we have extracted the features,
we will use the `runGSEA` method to evaluate which pathways these genes are
representative of.

## 3.1 Get the Top Predictive Features

We can get the features which are most predictive from a `SurvivalModel`
object using the `getTopFeatures` method. By default this retrieves the
gene names from the top 10% of models in the `SurvivalModel`. Users can
customize the top N models to extract genes from using the `numModels`
parameter.

```
topFeatures <- getTopFeatures(validatedPCOSPmodel)
topFeatures
```

```
##  [1] "ATOX1"    "NAMPT"    "KRT6A"    "FCGRT"    "SERTAD4"  "ZNF792"
##  [7] "KRT6C"    "BIRC3"    "PKIB"     "SSBP3"    "PPFIBP2"  "FBLIM1"
## [13] "ZSCAN29"  "KRT15"    "UBE2C"    "C16orf74" "BLNK"     "MARK3"
```

## 3.2 Querying Genesets for Enriched Pathways

To perform pathway analysis, which is done internally using the
`piano::runGSAhyper` function we first to pathway data to query against.
We recommend using the `msigdbr` R package to fetch pathways of interest.

Because of the small number of genes included in the sample patient cohorts,
this section will not find any enriched pathways and therefore this code is
not run.

```
allHumanGeneSets <- msigdbr()
allGeneSets <- as.data.table(allHumanGeneSets)
geneSets <- allGeneSets[grepl('^GO.*|.*CANONICAL.*|^HALLMARK.*', gs_name),
    .(gene_symbol, gs_name)]
```

```
GSEAresultDT <- runGSEA(validatedPCOSPmodel, geneSets)
```

# 4 Clinical Model Comparison

Equipped with a risk prediction model performing better than random chance,
the next pertinent question is: does it out perform simpler models? To answer
this question we have included the `ClinicalModel` class, which leverages the
`glm` function from the `stats` package to fit a generalized linear model based
on a set of clinical variables in the patient metadata. To do this, we need to
specify a model formula based on the column names available in the `colData`
slot of our training data `SurvivalExpeiment` objects. All formula parameters
must be valid column names in the `colData` of the training cohorts. The same
patient metadata must be present in any validation cohorts used to make risk
predictions.

## 4.1 Build the Model

We can see there are a number of clinical variables related to patient
survived in the patient metadata. For our model, we will be using patient sex,
age and tumour grade along with the TNM staging of the tumour.

```
knitr::kable(head(colData(ICGCtrainCohorts)))
```

|  | unique\_patient\_ID | grade | sex | age | T | N | M | sample\_type | sample\_name | survival\_time | event\_occurred | prognosis |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ICGC\_0006 | ICGC\_0006 | G2 | F | 49 | T1 | N1b | MX | tumour | ICGC\_0006 | 1715 | 0 | good |
| ICGC\_0007 | ICGC\_0007 | G2 | F | 74 | T3 | N1b | MX | tumour | ICGC\_0007 | 56 | 1 | bad |
| ICGC\_0009 | ICGC\_0009 | G4 | M | 34 | T3 | N0 | MX | tumour | ICGC\_0009 | 399 | 1 | good |
| ICGC\_0020 | ICGC\_0020 | G2 | M | 57 | T3 | N1b | MX | tumour | ICGC\_0020 | 1259 | 1 | good |
| ICGC\_0021 | ICGC\_0021 | G3 | M | 60 | T3 | N1b | MX | tumour | ICGC\_0021 | 715 | 1 | good |
| ICGC\_0025 | ICGC\_0025 | G3 | M | 69 | T3 | N1b | MX | tumour | ICGC\_0025 | 348 | 1 | bad |

```
clinicalModel <- ClinicalModel(ICGCtrainCohorts,
    formula='prognosis ~ sex + age + T + N + M + grade',
    randomSeed=1987)
```

## 4.2 Train the Model

```
trainedClinicalModel <- trainModel(clinicalModel)
```

## 4.3 Predict the Classes

Clinical annotations are only available for a subset of our patient cohorts,
thus we subset our cohort list to ensure the model works as expected. Variable
columns with levels of a model parameter which are not present in the original
model will be dropped automatically. To prevent this behavior, it is necessary
to add any missing levels to the `colData` of the training data before training
the model. The easiest way to achieve this is by converting the columns in
question into factors and ensuring all levels in the training and validation
data are set for those columns.

```
hasModelParamsCohortList <-
    PCOSPpredValCohorts[c('ICGCMICRO', 'TCGA', 'PCSI', 'OUH')]

clinicalPredCohortList <- predictClasses(hasModelParamsCohortList,
    model=trainedClinicalModel)
```

```
## Warning in .local(object, model, ...):
## [PDATK::NULL] Rows 120, 155 have levels that are not in the model, skipping these rows...
```

## 4.4 Validate the Model

```
validatedClinicalModel <- validateModel(trainedClinicalModel,
    clinicalPredCohortList)
```

## 4.5 Visualize Comparison with PCOSP Model

To get a general idea of how the `ClinicalModel` performed relative to the
`PCOSP` model, the `barPlotModelComaprison` can be used to show the . For
this example, we will compare the AUC of the models in each of the validation
cohorts. Other statistics in the `validationStats` slot can be used by changing
the `stat` argument to the plotting function.

```
clinicalVsPCOSPbarPlot <- barPlotModelComparison(validatedClinicalModel,
    validatedPCOSPmodel, stat='AUC')
clinicalVsPCOSPbarPlot
```

![](data:image/png;base64...)

To reduce the number of plotting functions and simplify meta-analysis of many
models of different types, we have included the `ModelComparison` object. This
object aggregates the validation statistics from two models. Plotting methods
can then be dispatched on this class, greatly simplifying the process of
comparing several `SurivalModel` sub-classes. You can also compare a model to
an existing model comparison, and in this way built up a collection of model
performance statistics which can be visualized in a forest plot to enable
complex comparisons between many models.

Below, we use this feature to compare the PCOSP and `ClinicalModels` based on
D index and concordance index, as calculated using the `survcomp` R package.

```
clinicalVsPCOSP <- compareModels(validatedClinicalModel, validatedPCOSPmodel)
```

```
clinVsPCOSPdIndexForestPlot <- forestPlot(clinicalVsPCOSP, stat='log_D_index')
clinVsPCOSPdIndexForestPlot
```

![](data:image/png;base64...)

```
clinVsPCOSPconcIndexForestPlot <- forestPlot(clinicalVsPCOSP,
    stat='concordance_index')
clinVsPCOSPconcIndexForestPlot
```

![](data:image/png;base64...)

# 5 Comparing PCOSP Models to Existing Published Classifiers

To get and idea of how our PCOSP model stacks up against other classifiers
from the literature, we have included the `GeneFuModel` class. This
`SurvivalModel` performs risk prediction using a set of genes and corresponding
coefficients using the `genefu::sig.score` function. We have included data
for three published classifiers from Chen *et al.* (2015), Birnbaum *et al.*
(2017) and Haider *et al.* (2014).

## 5.1 Make the Models

Since there is no training data for the published classifiers, we create
empty `GeneFuModel` objects, then assign the model predictors to the `models`
slot of each respective object.

```
chenGeneFuModel <- GeneFuModel(randomSeed=1987)
birnbaumGeneFuModel <- GeneFuModel(randomSeed=1987)
haiderGeneFuModel <- GeneFuModel(randomSeed=1987)
```

For the Haider model, we were unable to get the genes and coefficients. However,
the author provided the risk scores. As a result we need to do a bit of work
to get the Haider GeneFuModel to work with the package function.

```
data(existingClassifierData)

models(chenGeneFuModel) <- SimpleList(list(chen=chen))
models(birnbaumGeneFuModel) <- SimpleList(list(birnbuam=birnbaum))
models(haiderGeneFuModel) <- SimpleList(list(haider=NA))
```

## 5.2 Predict the Classes

```
chenClassPredictions <- predictClasses(PCOSPpredValCohorts[names(haiderSigScores)],
    model=chenGeneFuModel)
birnClassPredictions <- predictClasses(PCOSPpredValCohorts[names(haiderSigScores)],
    model=birnbaumGeneFuModel)
```

```
haiderClassPredictions <- PCOSPpredValCohorts[names(haiderSigScores)]
# Manually assign the scores to the prediction cohorts
for (i in seq_along(haiderClassPredictions)) {
  colMData <- colData(haiderClassPredictions[[i]])
  colMData$genefu_score <- NA_real_
  colMData[rownames(colMData) %in% names(haiderSigScores[[i]]), ]$genefu_score <-
      haiderSigScores[[i]][names(haiderSigScores[[i]]) %in% rownames(colMData)]
  colData(haiderClassPredictions[[i]]) <- colMData
}
# Setup the correct model metadata
mcols(haiderClassPredictions)$hasPredictions <- TRUE
metadata(haiderClassPredictions)$predictionModel <- haiderGeneFuModel
```

## 5.3 Validate the Models

```
validatedChenModel <- validateModel(chenGeneFuModel, valData=chenClassPredictions)
validatedBirnbaumModel <- validateModel(birnbaumGeneFuModel,
    valData=birnClassPredictions)
validatedHaiderModel <- validateModel(haiderGeneFuModel, valData=haiderClassPredictions)
```

## 5.4 Model Performance Meta-Analysis

```
genefuModelComparisons <- compareModels(validatedChenModel,
    validatedBirnbaumModel, modelNames=c('Chen', 'Birnbaum'))
genefuModelComparisons <- compareModels(genefuModelComparisons,
    validatedHaiderModel, model2Name='Haider')
```

```
allModelComparisons <- compareModels(genefuModelComparisons, validatedPCOSPmodel,
  model2Name='PCOSP')
# We are only interested in comparing the summaries, so we subset our model comparison
allModelComparisons <- subset(allModelComparisons, isSummary == TRUE)
```

```
allDindexComparisonForestPlot <- forestPlot(allModelComparisons,
    stat='log_D_index', colourBy='model', groupBy='mDataType')
allDindexComparisonForestPlot
```

![](data:image/png;base64...)

```
allConcIndexComparisonForestPlot <- forestPlot(allModelComparisons,
    stat='concordance_index', colourBy='model', groupBy='mDataType')
allConcIndexComparisonForestPlot
```

![](data:image/png;base64...)

From the two forest plots, we can see that the `PCOSP` model matched our
outperformed all of the public classifiers, even when only trained with 100
models. It is likely that using 1000 models, we would see even better separation
of the `PCOSP` model. Indeed, this is was the result in Sandhu *et al.* (2019).

# 6 Comparing PCOSP Models By Patient Subtype

```
data(cohortSubtypeDFs)

# Add the subtypes to the prediction cohort
subtypedPCOSPValCohorts <- assignSubtypes(PCOSPpredValCohorts, cohortSubtypeDFs)
```

```
subtypeValidatedPCOSPmodel <- validateModel(trainedPCOSPmodel, valData=subtypedPCOSPValCohorts)
```

```
## <simpleError in doTryCatch(return(expr), name, parentenv, handler): report ROC failed>
## <simpleError in wilcox.test.default(pred[obs == 1], pred[obs == 0], alternative = "great"): not enough (non-missing) 'x' observations>
## <simpleError in if (AUC.low > 0.5 & P >= 0.05) {    wilc.t = wilcox.test(predictor[table.gold == 1], predictor[table.gold ==         0], alternative = "less", exact = exact)    P = wilc.t$p.value}: missing value where TRUE/FALSE needed>
```

```
forestPlot(subtypeValidatedPCOSPmodel, stat='log_D_index', groupBy='cohort',
    colourBy='subtype')
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_pointrange()`).
```

![](data:image/png;base64...)

```
forestPlot(subtypeValidatedPCOSPmodel, stat='concordance_index', groupBy='cohort',
    colourBy='subtype')
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_pointrange()`).
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_segment()`).
```

![](data:image/png;base64...)

# 7 References

# Appendix

1. Sandhu V, Labori KJ, Borgida A, et al. Meta-Analysis of 1,200 Transcriptomic
   Profiles Identifies a Prognostic Model for Pancreatic Ductal Adenocarcinoma.
   JCO Clin Cancer Inform. 2019;3:1-16. doi:10.1200/CCI.18.00102
2. Chen DT, Davis-Yadley AH, Huang PY, et al. Prognostic Fifteen-Gene Signature
   for Early Stage Pancreatic Ductal Adenocarcinoma. PLoS One. 2015;10(8):e0133562.
   Published 2015 Aug 6. doi:10.1371/journal.pone.0133562
3. Birnbaum DJ, Finetti P, Lopresti A, et al. A 25-gene classifier predicts
   overall survival in resectable pancreatic cancer. BMC Med. 2017;15(1):170.
   Published 2017 Sep 20. doi:10.1186/s12916-017-0936-z
4. Haider S, Wang J, Nagano A, et al. A multi-gene signature predicts outcome
   in patients with pancreatic ductal adenocarcinoma. Genome Med. 2014;6(12):105.
   Published 2014 Dec 3. doi:10.1186/s13073-014-0105-3