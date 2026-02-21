# An Introduction to PDATK Classes and Methods

Vandana Sandhu, Heewon Seo, Christopher Eeles1\* and Benjamin Haibe-Kains1,2\*\*

1Bioinformatics and Computational Genomics Laboratory, Princess Margaret Cancer Center,University Health Network, Toronto, Ontario, Canada
2Department of Medical Biophysics, University of Toronto, Toronto, Canada

\*christopher.eeles@uhnresearch.ca
\*\*benjamin.haibe.kains@utoronto.ca

#### 2021-02-01

# Contents

* [1 Overview](#overview)
* [2 Installation](#installation)
* [3 Classes](#classes)
  + [3.1 SurvivalExperiment](#survivalexperiment)
    - [3.1.1 Constructor](#constructor)
    - [3.1.2 Accessors](#accessors)
  + [3.2 CohortList](#cohortlist)
    - [3.2.1 Constructor](#constructor-1)
  + [3.3 SurivivalModel](#surivivalmodel)
    - [3.3.1 Constructor](#constructor-2)
    - [3.3.2 Accessors](#accessors-1)
    - [3.3.3 Sub-Classes](#sub-classes)
* [4 References](#references)
* **Appendix**

# 1 Overview

The PDATK R package provides a set of classes and methods for estimating
patient risk using gene level biomarkers from a variety of published risk
quantification models. Functions are included for assessing and visualizing
individual model performance as well as conducting meta-analyses to compare
performance differences between models used on novel patient molecular data.

# 2 Installation

The PDATK package can be installed from Bioconductor using the `BiocManager`
package.

```
if (!require('PDATK')) BiocManager::install('PDATK')
```

# 3 Classes

## 3.1 SurvivalExperiment

A `SurvivalExperiment` is a wrapper around a `SummarizedExperiment` object
which requires two mandatory metadata columns in the `colData` slot. The
`days_survived` column specifies the integer number of days a patient has
survived since treatment. The `is_deceased` column indicates whether the patient
passed away during the study measurement period. Patients with an
`is_deceased` value of zero (FALSE) survived past the date of last measurement
in the study. For users familiar with survival analysis, these two columns
correspond to overall survival (OS) and OS status, respectively.

### 3.1.1 Constructor

Creating a `SurvivalExperiment` is the same as creating a `SummarizedExperiment`
object with two additional parameters. The `days_survived` parameter takes
the name of the `colData` column containing overall survival (OS); it defaults to
‘days\_survived’ but can be changed if the survival information is in another
column of `colData`. The `is_deceased` parameter is the same, except that it
specifies the column containing OS status. If the names of the columns are
different from the names of the parameters, the columns are renamed in `colData`
to ensure compatibility with PDATK function.

```
library(PDATK)
```

```
# -- Create some dummy data

# an assay
assay1 <- matrix(rnorm(100), nrow=10, ncol=10,
    dimnames=list(paste0('gene_', seq_len(10)), paste0('sample_', seq_len(10))))

# column and row metadata
rowMData <- DataFrame(gene_name=rownames(assay1),
    id=seq_len(10), row.names=rownames(assay1))
colMData <- DataFrame(sample_name=colnames(assay1),
    overall_survival=sample.int(1000, 10),
    os_status=sample(c(0L, 1L), 10, replace=TRUE),
    row.names=colnames(assay1))

# -- Use it to build a SurvivalExperiment
survExperiment <- SurvivalExperiment(assays=SimpleList(rna=assay1),
    rowData=rowMData, colData=colMData, metadata=list(a='Some metadata'),
    survival_time='overall_survival', event_occurred ='os_status')
```

A `SurvivalExperiment` can also be created from an existing

```
# -- Build A SummarizedExperiment
sumExperiment <- SummarizedExperiment(assays=SimpleList(rna=assay1),
    rowData=rowMData, colData=colMData, metadata=list(a='Some meta data'))

# -- Convert it to a SurvivalExperiment
# Use the sumExp parameter, which must be named
survExperiment <- SurvivalExperiment(sumExp=sumExperiment,
    survival_time='overall_survival', event_occurred='os_status')
```

### 3.1.2 Accessors

Since a `SurvivalExperiment` contains a `SummarizedExperiment`, all of the
accessor methods are inherited. For more details please see the
`SummarizedExperiment` vignette.

## 3.2 CohortList

A `CohortList` is `SimpleList` containing only `SurvivalExperiment` objects.
It is intended to be a general purpose container for storing patient cohorts
for either training or validating a `SurvivalModel`.

### 3.2.1 Constructor

Creating a `CohortList` is the same as creating a `SimpleList`, with the
addition of the `mDataType` parameter. This parameter takes the molecular data
type of each `SurvivalExperiment` in the cohort list. It is used for making
comparisons between models using different molecular assays,
for example to see if model perforance is concordant between RNA sequencing vs
RNA microarray data. If `mDataType` is not specfied, the constructor will try
to retrieve that information from the `metadata` slot each of the
`SurvivalExperiment`s passed to it. You cannot make a `CohortList` without
specifying the molecular data types, either directly or indirectly.

```
cohortList <- CohortList(list(cohort1=survExperiment, cohort2=survExperiment),
    mDataTypes=c('rna_seq', 'rna_micro'))
```

## 3.3 SurivivalModel

A `SurvivalModel` object inherits from a `SurvivalExperiment`, with the addition
of the `models`, `validationStats` and `validationData` slots. On initial
creation, as `SurvivalModel` is simply a container for your training data and
model parameters. However, using the `trainModel` method on
a `SurvivalModel` object will train your model using the training data in
the `assays` slot of the `SurvivalModel` and assign the trained model to the
`models` slot.

Once trained, a model can be used to make risk predictions for new cohorts of
data, assuming they have the same molecular features. The `predictClasses`
method uses a trained `SurvivalModel` to make predictions for a
`SurvivalExperiment` or `CohortList`, assigning the risk scores to the `colData`
of each `SurvivalExperiment` and adding class predictions, if applicable, to the
`predictions` item in the `SurvivalExperiment` metadata. The method returns
the originial data with addeded metadata.

A `SurvivalModel` can then be validated using external data with the
`validateModel` method. This will compute performance statistics for the model
on a set of validation data, assigning those statistics to the `validationStats`
slot as a `data.table`. The validation data will be attached to the model in the
`validationData` slot, to make it clear that what data the validation statistics
apply to.

Additional methods are included in this package to conduct model comparison
meta-analyses. These will be discussed in the detail in the `PCOSP` vignette.

### 3.3.1 Constructor

The `SurvivalModel` constructor takes as its first argument a `SurvivalExperiment`
or `CohortList`. In the case of a `CohortList`, each `SurvivalExperiment` is
subset to include only common samples and genes before being converted to
a `SurvivalModel`. The molecular data for the models are stored in the `assays`
slot of the `SurvivalModel`. Additionally, model parmeters must be specified
depending on the model subclass. For pure `SurvivalModel` objects, the only
model parameter is `randomSeed`, which should be the value used in `set.seed`
when a user trained a model.

```
set.seed(1987)
survModel <- SurvivalModel(survExperiment, randomSeed=1987)
```

### 3.3.2 Accessors

In addition to the standard `SurvivalExperiment` accessors, a `SurivalModel`
also uses `models`, `validationStats` and `validationData` to access slots
with the same respective names. Example usage of these accessors can be found
in the `PCOSP` vignette. For more information please see the documentation
with `??<method_name>`, e.g., `??models`. This will return a list of
documentation for that S4 method defined on different classes.

### 3.3.3 Sub-Classes

In order to implement model specific behaviours for training, prediciton and
validation, a number of `SurvivalModel` sub-classes are included in this package.
Each one represents a distinct risk prediction model and has model specific
configuration. See the `PCOSP` vignette for an explanation of each.

# 4 References

# Appendix

1. Sandhu V, Labori KJ, Borgida A, et al. Meta-Analysis of 1,200 Transcriptomic
   Profiles Identifies a Prognostic Model for Pancreatic Ductal Adenocarcinoma.
   JCO Clin Cancer Inform. 2019;3:1-16. doi:10.1200/CCI.18.00102