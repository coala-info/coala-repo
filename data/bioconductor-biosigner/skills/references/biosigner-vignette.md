# *biosigner*: A new method for signature discovery from omics data

Philippe Rinaudo and Etienne Thevenot

#### 29 October 2025

#### Package

biosigner 1.38.0

# 1 Introduction

High-throughput, non-targeted, technologies such as **transcriptomics**,
**proteomics** and **metabolomics**, are widely used to **discover
molecules** which allow to efficiently discriminate between biological
or clinical conditions of interest (e.g., disease vs control states).
Powerful **machine learning** approaches such as **Partial Least Square
Discriminant Analysis** (PLS-DA), **Random Forest** (RF) and **Support
Vector Machines** (SVM) have been shown to achieve high levels of
prediction accuracy. **Feature selection**, i.e., the selection of the
few features (i.e., the molecular signature) which are of highest
discriminating value, is a critical step in building a robust and
relevant classifier (Guyon and Elisseeff [2003](#ref-Guyon2003)): First, dimension reduction is usefull
to **limit the risk of overfitting** and **increase the prediction
stability** of the model; second, **intrepretation** of the molecular
signature is facilitated; third, in case of the development of
diagnostic product, a restricted list is required for the **subsequent
validation** steps (Rifai, Gillette, and Carr [2006](#ref-Rifai2006)).

Since the comprehensive analysis of all combinations of features is not
computationally tractable, several **selection techniques** have been
described, including *filter* (e.g., *p*-values thresholding), *wrapper*
(e.g., recursive feature elimination), and *embedded* (e.g., sparse PLS)
approaches (Saeys, Inza, and Larranaga [2007](#ref-Saeys2007)). The major challenge for such methods is to be
**fast** and extract **restricted and stable molecular signatures**
which still provide **high performance** of the classifier
(Gromski et al. [2014](#ref-Gromski2014); Determan [2015](#ref-Determan2015)).

# 2 The biosigner package

The
[`biosigner`](http://bioconductor.org/packages/release/bioc/html/biosigner.html)
package implements a new **wrapper** feature selection algorithm:

1. the dataset is split into training and testing subsets (by
   bootstraping, controling class proportion),
2. model is trained on the training set and balanced accuracy is
   evaluated on the test set,
3. the features are ranked according to their importance in the model,
4. the relevant feature subset at level *f* is found by a binary
   search: a feature subset is considered relevant if and only if, when
   randomly permuting the intensities of other features in the test
   subsets, the proportion of increased or equal prediction accuracies
   is lower than a defined threshold *f*,
5. the dataset is restricted to the selected features and steps 1 to 4
   are repeated until the selected list of features is stable.

Three binary classifiers have been included in
[`biosigner`](http://bioconductor.org/packages/release/bioc/html/biosigner.html),
namely **PLS-DA**, **RF** and **SVM**, as the performances of each
machine learning approach may vary depending on the structure of the
dataset (Determan [2015](#ref-Determan2015)). The algorithm returns the **tier** of each
feature for the selected classifer(s): tier **S** corresponds to the
**final signature**, i.e., features which have been found significant in
all the selection steps; features with tier *A* have been found
significant in all but the last selection, and so on for tier *B* to
*D*. Tier *E* regroup all previous round of selection.

As for a classical classification algorithm, the `biosign` method takes
as input the `x` samples times features data frame (or matrix) of
intensities, and the `y` factor (or character vector) of class labels
(note that only binary classification is currently available). It
returns the signature (`signatureLs`: selected feature names) and the
trained model (`modelLs`) for each of the selected classifier. The
`plot` method for `biosign` objects enable to visualize the individual
boxplots of the selected features. Finally, the `predict` method allows
to apply the trained classifier(s) on new datasets.

The algorithm has been successfully applied to **transcriptomics** and
**metabolomics** data [Rinaudo et al. ([2016](#ref-Rinaudo2016)); see also the *Hands-on* section
below).

# 3 Hands-on

## 3.1 Loading

We first load the
[`biosigner`](http://bioconductor.org/packages/release/bioc/html/biosigner.html)
package:

```
library(biosigner)
```

We then use the **`diaplasma`** metabolomics dataset (Rinaudo et al. [2016](#ref-Rinaudo2016))
which results from the analysis of **plasma samples from 69 diabetic
patients** were analyzed by reversed-phase liquid chromatography coupled
to high-resolution mass spectrometry (**LC-HRMS**; Orbitrap Exactive) in
the negative ionization mode. The raw data were pre-processed with XCMS
and CAMERA (5,501 features), corrected for signal drift, log10
transformed, and annotated with an in-house spectral database. The
patient’s **age**, **body mass index**, and **diabetic type** are
recorded (Rinaudo et al. [2016](#ref-Rinaudo2016)).

```
data(diaplasma)
```

We attach *diaplasma* to the search path and display a summary of the
content of the *dataMatrix*, *sampleMetadata* and *variableMetadata*
with the `view` function from the (imported)
[ropls](http://bioconductor.org/packages/release/bioc/html/ropls.html)
package:

```
attach(diaplasma)
library(ropls)
ropls::view(dataMatrix)
```

```
##         dim  class    mode typeof   size NAs min mean median max
##  69 x 5,501 matrix numeric double 3.3 Mb   0   0  4.2    4.4 8.2
##           m096.009t01.6    m096.922t00.8 ...    m995.603t10.2    m995.613t10.2
## DIA001 2.98126177377087 6.08172882312848 ... 3.93442594703862 3.96424920154706
## DIA002                0 6.13671997362279 ... 3.74201112636229 3.78128422428722
## ...                 ...              ... ...              ...              ...
## DIA077                0 6.12515971273103 ... 4.55458598372024 4.57310800324247
## DIA078 4.69123816772499   6.134420482337 ...  4.1816445335704 4.20696191303494
```

![](data:image/png;base64...)

```
ropls::view(sampleMetadata, standardizeL = TRUE)
```

```
##    type     age     bmi
##  factor numeric numeric
##  nRow nCol size NAs
##    69    3 0 Mb   0
##        type age  bmi
## DIA001   T2  70 31.6
## DIA002   T2  67   28
## ...     ... ...  ...
## DIA077   T2  50   27
## DIA078   T2  65   29
```

```
## 1 data.frame 'factor' column(s) converted to 'numeric' for plotting.
```

```
## Standardization of the columns for plotting.
```

![](data:image/png;base64...)

```
ropls::view(variableMetadata, standardizeL = TRUE)
```

```
##    mzmed   rtmed ... pcgroup     spiDb
##  numeric numeric ... numeric character
##   nRow nCol   size NAs
##  5,501    6 0.8 Mb   0
##                     mzmed       rtmed ... pcgroup
## m096.009t01.6 96.00899361 93.92633015 ...    1984
## m096.922t00.8 96.92192011 48.93274877 ...       4
## ...                   ...         ... ...     ...
## m995.603t10.2 995.6030195 613.4388762 ...    7160
## m995.613t10.2 995.6134422 613.4446705 ...    7161
##                                            spiDb
## m096.009t01.6 N-Acetyl-L-aspartic acid_HMDB00812
## m096.922t00.8
## ...                                          ...
## m995.603t10.2
## m995.613t10.2
```

```
## 3 data.frame 'character' column(s) converted to 'numeric' for plotting.
## Standardization of the columns for plotting.
```

![](data:image/png;base64...)

We see that the **diaplasma** list contains three objects:

1. **`dataMatrix`**: 69 samples x 5,501 matrix of numeric type
   containing the intensity profiles (log10 transformed),
2. **`sampleMetadata`**: a 69 x 3 data frame, with the patients’

   * **`type`**: diabetic type, factor
   * **`age`**: numeric
   * **`bmi`**: body mass index, numeric
3. **`variableMetadata`**: a 5,501 x 8 data frame, with the median m/z
   (‘mzmed’, numeric) and the median retention time in seconds
   (‘rtmed’, numeric) from XCMS, the ‘isotopes’ (character), ‘adduct’
   (character) and ‘pcgroups’ (numeric) annotations from CAMERA, the
   names of the m/z and RT matching compounds from an in-house spectra
   of commercial metabolites (‘name\_hmdb’, character), and the
   *p*-values resulting from the non-parametric hypothesis testing of
   difference in medians between types (‘type\_wilcox\_fdr’, numeric),
   and correlation with age (‘age\_spearman\_fdr’, numeric) and body mass
   index (‘bmi\_spearman\_fdr’, numeric), all corrected for multiple
   testing (False Discovery Rate).
4. **`se`**: The previous data and metadata as a `SummarizedExperiment`
   instance
5. **`eset`** The previous data as a `ExpressionSet` instance

We can observe that the 3 clinical covariates (diabetic *type*, *age*,
and *bmi*) are stronlgy associated:

```
with(sampleMetadata,
plot(age, bmi, cex = 1.5, col = ifelse(type == "T1", "blue", "red"), pch = 16))
legend("topleft", cex = 1.5, legend = paste0("T", 1:2),
text.col = c("blue", "red"))
```

![](data:image/png;base64...)

**Figure 1:** `age`, *body mass index (*`bmi`*)*, and diabetic `type` of
the patients from the `diaplasma` cohort.

## 3.2 Molecular signatures

Let us look for signatures of *type* in the `diaplasma` dataset by using
the `biosign` method. To speed up computations in this demo vignette, we
restrict the number of features (from 5,501 to about 500) and the number
of bootstraps (5 instead of 50 [default]); the selection on the whole
dataset, 50 bootstraps, and the 3 classifiers, takes around 10 min.

```
featureSelVl <- variableMetadata[, "mzmed"] >= 450 &
variableMetadata[, "mzmed"] < 500
sum(featureSelVl)
```

```
## [1] 533
```

```
dataMatrix <- dataMatrix[, featureSelVl]
variableMetadata <- variableMetadata[featureSelVl, ]
```

```
diaSign <- biosign(dataMatrix, sampleMetadata[, "type"], bootI = 5)
```

```
## Selecting features for the plsda model
## Selecting features for the randomforest model
## Selecting features for the svm model
## Significant features from 'S' groups:
##               plsda randomforest svm
## m495.261t08.7 "C"   "A"          "S"
## m497.284t08.1 "S"   "S"          "E"
## m497.275t08.1 "A"   "S"          "E"
## m471.241t07.6 "B"   "S"          "E"
## Accuracy:
##      plsda randomforest   svm
## Full 0.797        0.835 0.824
## AS   0.823        0.845 0.708
## S    0.825        0.858 0.708
```

![](data:image/png;base64...)

**Figure 2:** Relevant signatures for the *PLS-DA*, *Random Forest*, and
*SVM* classifiers extracted from the `diaplasma` dataset. The *S* tier
corresponds to the final metabolite signature, i.e., metabolites which
passed through all the selection steps.

The arguments are:

* `x`: the numerical matrix (or data frame) of intensities (samples as
  rows, variables as columns),
* `y`: the factor (or character) specifying the sample labels from the
  2 classes,
* `methodVc`: the classifier(s) to be used; here, the default *all*
  value means that all classifiers available (*plsda*, *randomforest*,
  and *svm*) are selected,
* `bootI`: the number of bootstraps is set to 5 to speed up
  computations when generating this vignette; we however recommend to
  keep the default 50 value for your analyzes (otherwise signatures
  may be less stable).
* The `set.seed` argument ensures that the results from this vignette
  can be reproduced exactly; by choosing alternative seeds (and the
  default `bootI` = 50), similar signatures are obtained, showing the
  stability of the selection.

Note:

* If some features from the `x` matrix/data frame contain missing
  values (NA), these features will be removed prior to modeling with
  Random Forest and SVM (in contrast, the NIPALS algorithm from PLS-DA
  can handle missing values),

The resulting signatures for the 3 selected classifiers are both printed
and plotted as **tiers** from *S*, *A*, up to *E* by decreasing
relevance. The (*S*) tier corresponds to the final signature, i.e.
features which passed through all the backward selection steps. In
contrast, features from the other tiers were discarded during the last
(*A*) or previous (*B* to *E*) selection rounds.

Note that *tierMaxC = ‘A’* argument in the *print* and *plot* methods
can be used to view the features from the larger *S+A* signatures
(especially when no *S* features have been found, or when the
performance of the *S* model is much lower than the *S+A* model).

The **performance** of the model built with the input dataset (*balanced
accuracy*: mean of the *sensitivity* and *specificity*), or the subset
restricted to the *S* or *S+A* signatures are shown. We see that with 1
to 5 *S* feature signatures (i.e., less than 1% of the input), the 3
classifiers achieve good performances (even higher than the full Random
Forest and SVM models). Furthermore, reducing the number of features
decreases the risk of building non-significant models (i.e., models
which do not perform significantly better than those built after
randomly permuting the labels). The signatures from the 3 classifiers
have some distinct features, which highlights the interest of comparing
various machine learning approaches.

The **individual boxplots** of the features from the *complete*
signature can be visualized with:

```
plot(diaSign, typeC = "boxplot")
```

![](data:image/png;base64...)

**Figure 3:** Individual boxplots of the features selected for at least
one of the classification methods. Features selected for a single
classifier are colored (*red* for PLS-DA, *green* for Random Forest and
*blue* for SVM).

Let us see the metadata of the *complete* signature:

```
variableMetadata[getSignatureLs(diaSign)[["complete"]], ]
```

```
##                  mzmed    rtmed isotopes                        adduct pcgroup
## m495.261t08.7 495.2609 524.1249                                           1655
## m497.284t08.1 497.2840 486.5338          [M+Cl]- 462.31 [M-H]- 498.287     220
## m497.275t08.1 497.2755 486.5722          [M+Cl]- 462.31 [M-H]- 498.287     220
## m471.241t07.6 471.2408 455.5541                                          10538
##                                              spiDb
## m495.261t08.7
## m497.284t08.1
## m497.275t08.1 Taurochenodeoxycholic acid_HMDB00951
## m471.241t07.6
```

## 3.3 Predictions

Let us split the dataset into a training (the first 4/5th of the 183
samples) and a testing subsets, and extract the relevant features from
the training subset:

```
trainVi <- 1:floor(0.8 * nrow(dataMatrix))
testVi <- setdiff(1:nrow(dataMatrix), trainVi)
```

```
diaTrain <- biosign(dataMatrix[trainVi, ], sampleMetadata[trainVi, "type"],
bootI = 5)
```

```
## Selecting features for the plsda model
## Selecting features for the randomforest model
## Selecting features for the svm model
## Significant features from 'S' groups:
##               plsda randomforest svm
## m497.284t08.1 "S"   "S"          "E"
## m469.215t07.8 "E"   "E"          "S"
## Accuracy:
##      plsda randomforest   svm
## Full 0.753        0.797 0.728
## AS   0.823        0.855 0.668
## S    0.814        0.782 0.603
```

![](data:image/png;base64...)

**Figure 4:** Signatures from the training data set.

We extract the **fitted** types on the training dataset restricted to
the *S* signatures:

```
diaFitDF <- predict(diaTrain)
```

We then print the confusion tables for each classifier:

```
lapply(diaFitDF, function(predFc) table(actual = sampleMetadata[trainVi,
"type"], predicted = predFc))
```

```
## $plsda
##       predicted
## actual T1 T2
##     T1 16  6
##     T2  4 29
##
## $randomforest
##       predicted
## actual T1 T2
##     T1 14  8
##     T2  7 26
##
## $svm
##       predicted
## actual T1 T2
##     T1  7 15
##     T2  3 30
```

and the corresponding balanced accuracies:

```
sapply(diaFitDF, function(predFc) {
conf <- table(sampleMetadata[trainVi, "type"], predFc)
conf <- sweep(conf, 1, rowSums(conf), "/")
round(mean(diag(conf)), 3)
})
```

```
##        plsda randomforest          svm
##        0.803        0.712        0.614
```

Note that these values are slightly different from the accuracies
returned by *biosign* because the latter are computed by using the
resampling scheme selected by the *bootI* (or *crossvalI*) arguments:

```
round(getAccuracyMN(diaTrain)["S", ], 3)
```

```
##        plsda randomforest          svm
##        0.814        0.782        0.603
```

Finally, we can compute the performances on the test subset:

```
diaTestDF <- predict(diaTrain, newdata = dataMatrix[testVi, ])
sapply(diaTestDF, function(predFc) {
conf <- table(sampleMetadata[testVi, "type"], predFc)
conf <- sweep(conf, 1, rowSums(conf), "/")
round(mean(diag(conf)), 3)
})
```

```
##        plsda randomforest          svm
##        0.750        0.667        0.500
```

## 3.4 Working on `SummarizedExperiment` objects

The **`SummarizedExperiment`** class from the
[SummarizedExperiment](https://www.bioconductor.org/packages/SummarizedExperiment/)
bioconductor package has been developed to conveniently handle
preprocessed omics objects, including the *variable x sample* matrix of
intensities, and two DataFrames containing the sample and variable
metadata, which can be accessed by the `assay`, `colData` and `rowData`
methods respectively (remember that the data matrix is stored with
samples in columns).

Getting the `diaplasma` dataset as a `SummarizedExperiment`:

```
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(diaplasma)
data.mn <- diaplasma[["dataMatrix"]] # matrix: samples x variables
samp.df <- diaplasma[["sampleMetadata"]] # data frame: samples x sample metadata
feat.df <- diaplasma[["variableMetadata"]] # data frame: features x feature metadata

# Creating the SummarizedExperiment (package SummarizedExperiment)
library(SummarizedExperiment)
dia.se <- SummarizedExperiment(assays = list(diaplasma = t(data.mn)),
                               colData = samp.df,
                               rowData = feat.df)
# note that colData and rowData main format is DataFrame, but data frames are accepted when building the object
stopifnot(validObject(dia.se))

# Viewing the SummarizedExperiment
# ropls::view(dia.se)
```

The `biosign` method can be applied to a **`SummarizedExperiment`**
object, by using the object as the `x` argument, and by indicating as
the `y` argument the name of the sample metadata to be used as the
response (i.e. name of the column in the `colData`). Note that in the
example below, we restrict the data set to the first 100 features to
speed up computations:

```
dia.se <- dia.se[1:100, ]
dia.se <- biosign(dia.se, "type", bootI = 5)
```

![](data:image/png;base64...)

The `biosign` method returns the updated **`SummarizedExperiment`**
object with the tiers as new columns in the `rowData`

```
feat.DF <- SummarizedExperiment::rowData(dia.se)
head(feat.DF[, grep("type_", colnames(feat.DF))])
```

```
## DataFrame with 6 rows and 3 columns
##               type_biosign_plsda type_biosign_forest type_biosign_svm
##                      <character>         <character>      <character>
## m096.009t01.6                  E                   E                B
## m096.922t00.8                  E                   E                E
## m098.025t01.3                  E                   E                E
## m099.009t01.3                  E                   B                E
## m099.009t00.9                  E                   E                E
## m099.045t04.0                  E                   A                E
```

and with the `biosign` model in the `metadata` slot, which can be
accessed with the `getBiosign` method:

```
dia_type.biosign <- getBiosign(dia.se)
names(dia_type.biosign)
```

```
## [1] "type_plsda.forest.svm"
```

```
plot(dia_type.biosign[["type_plsda.forest.svm"]], typeC = "tier")
```

![](data:image/png;base64...)

### 3.4.1 `ExpressionSet` format

The `ExpressionSet` format is currently supported as a legacy
representation from the previous versions of the `biosigner` package (<
1.24.2) but will now be supplanted by `SummarizedExperiment` in future
versions.

`exprs`, `pData`, and `fData` for `ExpressionSet` are similar to
`assay`, `colData` and `rowData` for `SummarizedExperiment` except that
`assay` is a list which can potentially include several matrices, and
that `colData` and `rowData` are of the `DataFrame` format.
`SummarizedExperiment` format further enables to store additional
metadata (such as models or ggplots) in a dedicated `metadata` slot.

In the example below, we will first build a minimal **`ExpressionSet`**
object from the `diaplasma` data set and view the data, and we
subsequently perform the feature selection.

Getting the `diaplasma` data set as a `ExpressionSet`:

```
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(diaplasma)
data.mn <- diaplasma[["dataMatrix"]] # matrix: samples x variables
samp.df <- diaplasma[["sampleMetadata"]] # data frame: samples x sample metadata
feat.df <- diaplasma[["variableMetadata"]] # data frame: features x feature metadata

# Creating the SummarizedExperiment (package SummarizedExperiment)
library(Biobase)
dia.eset <- Biobase::ExpressionSet(assayData = t(data.mn))
Biobase::pData(dia.eset) <- samp.df
Biobase::fData(dia.eset) <- feat.df
stopifnot(validObject(dia.eset))
# Viewing the ExpressionSet
# ropls::view(dia.eset)
```

Selecting the features:

```
dia.eset <- dia.eset[1:100, ]
dia_type.biosign <- biosign(dia.eset, "type", bootI = 5)
```

![](data:image/png;base64...)

Note that this time, `biosign` returns the models an en object of the
`biosign` class.

```
plot(dia_type.biosign, typeC = "tier")
```

![](data:image/png;base64...)

The updated `ExpressionSet` object can be accessed with the `getEset`
method:

```
dia.eset <- getEset(dia_type.biosign)
feat.df <- Biobase::fData(dia.eset)
head(feat.df[, grep("type_", colnames(feat.df))])
```

```
##               type_biosign_plsda type_biosign_forest type_biosign_svm
## m096.009t01.6                  E                   E                B
## m096.922t00.8                  E                   E                E
## m098.025t01.3                  E                   E                E
## m099.009t01.3                  E                   B                E
## m099.009t00.9                  E                   E                E
## m099.045t04.0                  E                   A                E
```

Before moving to new data sets, we detach *diaplasma* from the search
path:

```
detach(diaplasma)
```

## 3.5 Working on `MultiAssayExperiment` objects

The `MultiAssayExperiment` format is useful to handle **multi-omics**
data sets (**???**). Feature selection
can be performed in parallel for each data set by applying `opls` to
such formats. We provide an example based on the `NCI60_4arrays` cancer
data set from the `omicade4` package (which has been made available in
this `ropls` package in the `MultiAssayExperiment` format).

Getting the `NCI60` data set as a `MultiAssayExperiment`:

```
data("NCI60", package = "ropls")
nci.mae <- NCI60[["mae"]]
library(MultiAssayExperiment)
# Cancer types
table(nci.mae$cancer)
```

```
##
## BR CN CO LC LE ME OV PR RE
##  5  6  7  9  6 10  7  2  8
```

```
# Restricting to the 'ME' and 'LE' cancer types and to the 'agilent' and 'hgu95' datasets
nci.mae <- nci.mae[, nci.mae$cancer %in% c("ME", "LE"), c("agilent", "hgu95")]
```

```
## Warning: 'experiments' dropped; see 'drops()'
```

Performing the feature selection for each dataset:

```
nci.mae <- biosign(nci.mae, "cancer", bootI = 5)
```

```
##
##
## Selecting the features for the 'agilent' dataset:
## Selecting features for the plsda model
## Selecting features for the randomforest model
## Selecting features for the svm model
## Significant features from 'S' groups:
##          plsda randomforest svm
## VEPH1    "S"   "E"          "B"
## LHFP     "S"   "E"          "B"
## C10orf90 "B"   "E"          "S"
## EZH2     "E"   "S"          "E"
## Accuracy:
##      plsda randomforest   svm
## Full     1        1.000 1.000
## AS       1        0.900 0.983
## S        1        0.917 0.983
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
##
##
## Selecting the features for the 'hgu95' dataset:
## Selecting features for the plsda model
## Selecting features for the randomforest model
## Selecting features for the svm model
## Significant features from 'S' groups:
##         plsda randomforest svm
## TSPAN4  "S"   "S"          "E"
## TBC1D16 "S"   "E"          "B"
## NASP    "S"   "E"          "E"
## Accuracy:
##      plsda randomforest   svm
## Full     1            1 1.000
## AS       1            1 0.917
## S        1            1    NA
```

![](data:image/png;base64...)![](data:image/png;base64...)

The `biosigner` method returns an updated `MultiAssayExperiment` with
the tiers included as additional columns in the `rowData` of the
individual `SummarizedExperiment`:

```
SummarizedExperiment::rowData(nci.mae[["agilent"]])
```

```
## DataFrame with 300 rows and 4 columns
##                  name cancer_biosign_plsda cancer_biosign_forest
##           <character>          <character>           <character>
## ST8SIA1       ST8SIA1                    E                     E
## YWHAQ           YWHAQ                    E                     E
## EPHA4           EPHA4                    E                     E
## GTPBP5         GTPBP5                    E                     E
## PVR               PVR                    E                     E
## ...               ...                  ...                   ...
## HIST1H2AB   HIST1H2AB                    E                     E
## XPO6             XPO6                    E                     E
## KIAA1688     KIAA1688                    E                     E
## TCEAL2         TCEAL2                    B                     E
## GLCCI1         GLCCI1                    E                     E
##           cancer_biosign_svm
##                  <character>
## ST8SIA1                    B
## YWHAQ                      E
## EPHA4                      B
## GTPBP5                     E
## PVR                        E
## ...                      ...
## HIST1H2AB                  E
## XPO6                       E
## KIAA1688                   E
## TCEAL2                     E
## GLCCI1                     E
```

The biosign model(s) are stored in the metadata of the individual
`SummarizedExperiment` objects included in the `MultiAssayExperiment`,
and can be accessed with the `getBiosign` method:

```
mae_biosign.ls <- getBiosign(nci.mae)
for (set.c in names(mae_biosign.ls))
plot(mae_biosign.ls[[set.c]][["cancer_plsda.forest.svm"]],
     typeC = "tier",
     plotSubC = set.c)
```

![](data:image/png;base64...)![](data:image/png;base64...)

### 3.5.1 `MultiDataSet` objects

The `MultiDataSet` format (**???**) is
currently supported as a legacy representation from the previous
versions of the `biosigner` package (<1.24.2) but will now be
supplanted by `MultiAssayExperiment` in future versions. Note that the
`mds2mae` method from the `MultiDataSet` package enables to convert a
`MultiDataSet` into the `MultiAssayExperiment` format.

Getting the `NCI60` data set as a `MultiDataSet`:

```
data("NCI60", package = "ropls")
nci.mds <- NCI60[["mds"]]
```

Building PLS-DA models for the cancer type:

```
# Restricting to the "agilent" and "hgu95" datasets
nci.mds <- nci.mds[, c("agilent", "hgu95")]
# Restricting to the 'ME' and 'LE' cancer types
library(Biobase)
sample_names.vc <- Biobase::sampleNames(nci.mds[["agilent"]])
cancer_type.vc <- Biobase::pData(nci.mds[["agilent"]])[, "cancer"]
nci.mds <- nci.mds[sample_names.vc[cancer_type.vc %in% c("ME", "LE")], ]
# Selecting the features
nci_cancer.biosign <- biosign(nci.mds, "cancer", bootI = 5)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Getting back the updated `MultiDataSet`:

```
nci.mds <- getMset(nci_cancer.biosign)
```

# 4 Extraction of biomarker signatures from other omics datasets

In this section, `biosign` is applied to two metabolomics and one
transcriptomics data sets. Please refer to Rinaudo et al. ([2016](#ref-Rinaudo2016)) for a full
discussion of the methods and results.

## 4.1 Physiological variations of the human urine metabolome (metabolomics)

The **`sacurine`** LC-HRMS dataset from the dependent
[`ropls`](http://bioconductor.org/packages/release/bioc/html/ropls.html)
package can also be used (Thevenot et al. [2015](#ref-Thevenot2015)): Urine samples from a cohort of
183 adults were analyzed by using an LTQ Orbitrap in the negative
ionization mode. A total of 109 metabolites were identified or annotated
at the MSI level 1 or 2. Signal drift and batch effect were corrected,
and each urine profile was normalized to the osmolality of the sample.
Finally, the data were log10 transformed (see the
[`ropls`](http://bioconductor.org/packages/release/bioc/html/ropls.html)
vignette for further details and examples).

We can for instance look for signatures of the *gender*:

```
data(sacurine)
sacSign <- biosign(sacurine[["dataMatrix"]],
sacurine[["sampleMetadata"]][, "gender"],
methodVc = "plsda")
```

```
## Selecting features for the plsda model
## Significant features from 'S' groups:
##                          plsda
## Malic acid               "S"
## p-Anisic acid            "S"
## Testosterone glucuronide "S"
## Accuracy:
##      plsda
## Full 0.876
## AS   0.882
## S    0.889
```

![](data:image/png;base64...)

**Figure 5:** PLS-DA signature from the ‘sacurine’ data set.

## 4.2 Apples spikes with known compounds (metabolomics)

The **spikedApples** dataset was obtained by LC-HRMS analysis (SYNAPT
Q-TOF, Waters) of one control and three spiked groups of 10 apples each.
The spiked mixtures consists in 2 compounds which were not naturally
present in the matrix and 7 compounds aimed at achieving a final
increase of 20%, 40% or 100% of the endogeneous concentrations. The
authors identified 22 features (out of the 1,632 detected in the
positive ionization mode; i.e. 1.3%) which came from the spiked
compounds. The dataset is borrowed from the [BioMark](https://cran.r-project.org/web/packages/BioMark/index.html) R
package (Franceschi et al. [2012](#ref-Franceschi2012)). Let us use the *control* and *group1* samples
(20 in total) in this study.

```
data(SpikePos)
group1Vi <- which(SpikePos[["classes"]] %in% c("control", "group1"))
appleMN <- SpikePos[["data"]][group1Vi, ]
spikeFc <- factor(SpikePos[["classes"]][group1Vi])
annotDF <- SpikePos[["annotation"]]
rownames(annotDF) <- colnames(appleMN)
```

We can check, by using the `opls` method from the
[ropls](http://bioconductor.org/packages/release/bioc/html/ropls.html)
package for multivariate analysis, that:

1. no clear separation can be observed by PCA:

```
apple.pca <- ropls::opls(appleMN, fig.pdfC = "none")
```

```
## PCA
## 20 samples x 1632 variables
## standard scaling of predictors
##       R2X(cum) pre ort
## Total    0.523   7   0
```

```
ropls::plot(apple.pca, parAsColFcVn = spikeFc)
```

![](data:image/png;base64...)

2. PLS-DA modeling with the full dataset is not significant (as seen on
   the top left plot: 7 out of 20 models trained after random
   permutations of the labels have Q2 values higher than the model
   trained with the true labels):

```
apple.pls <- ropls::opls(appleMN, spikeFc)
```

```
## PLS-DA
## 20 samples x 1632 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum)  RMSEE pre ort pR2Y pQ2
## Total    0.145    0.995     0.4 0.0396   2   0 0.05 0.4
```

![](data:image/png;base64...)

Let us now extract the molecular signatures:

```
appleSign <- biosign(appleMN, spikeFc)
```

```
## Selecting features for the plsda model
## Selecting features for the randomforest model
## Selecting features for the svm model
## Significant features from 'S' groups:
##           plsda randomforest svm
## 449.1/327 "S"   "S"          "C"
## Accuracy:
##      plsda randomforest   svm
## Full  0.79        0.921 0.793
## AS    1.00        1.000 0.853
## S     1.00        1.000    NA
```

![](data:image/png;base64...)

The *449.1/327* corresponds to the Cyanidin-3-galactoside (absent in the
control; Franceschi et al. ([2012](#ref-Franceschi2012))).

```
annotDF <- SpikePos[["annotation"]]
rownames(annotDF) <- colnames(appleMN)
annotDF[getSignatureLs(appleSign)[["complete"]], c("adduct", "found.in.standards")]
```

```
##           adduct found.in.standards
## 449.1/327                         1
```

## 4.3 Bone marrow from acute leukemia patients (transcriptomics)

Samples from 47 patients with acute lymphoblastic leukemia (ALL) and 25
patients with acute myeloid leukemia (AML) have been analyzed using
Affymetrix Hgu6800 chips resulting in expression data of 7,129 gene
probes (Golub et al. [1999](#ref-Golub1999)). The **golub** dataset is available in the
[`golubEsets`](https://bioconductor.org/packages/release/data/experiment/html/golubEsets.html)
package from Bioconductor in the `ExpressionSet` format. Let us compute
for example the SVM signature (to speed up this demo example, the number
of features is restricted to 500):

```
library(golubEsets)
data(Golub_Merge)
Golub_Merge
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 7129 features, 72 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: 39 40 ... 33 (72 total)
##   varLabels: Samples ALL.AML ... Source (11 total)
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
##   pubMedIds: 10521349
## Annotation: hu6800
```

```
# restricting to the last 500 features
golub.eset <- Golub_Merge[1501:2000, ]
table(Biobase::pData(golub.eset)[, "ALL.AML"])
```

```
##
## ALL AML
##  47  25
```

```
golubSign <- biosign(golub.eset, "ALL.AML", methodVc = "svm")
```

```
## Selecting features for the svm model
## Significant features from 'S' groups:
##           svm
## M11147_at "S"
## M17733_at "S"
## M19507_at "S"
## M27891_at "S"
## Accuracy:
##        svm
## Full 0.955
## AS   0.967
## S    0.959
```

![](data:image/png;base64...)

**Figure 6:** SVM signature from the *golub* data set.

The computation results in a signature of 4 features only and a sparse
SVM model performing even better (95.9% accuracy) than the model trained
on the dataset of 500 variables (95.5% accuracy).

The
[hu6800.db](https://bioconductor.org/packages/release/data/annotation/html/hu6800.db.html)
bioconductor package can be used to get the annotation of the selected
probes (Carlson [2016](#ref-Carlson2016)):

```
library(hu6800.db)
sapply(getSignatureLs(golubSign)[["complete"]],
       function(probeC)
       get(probeC, env = hu6800GENENAME))
```

```
##                  M11147_at                  M17733_at
##     "ferritin light chain" "thymosin beta 4 X-linked"
##                  M19507_at                  M27891_at
##          "myeloperoxidase"               "cystatin C"
```

Cystatin C is part of the 50 gene signature selected by Golub and
colleagues on the basis of a metric derived from the Student’s statistic
of mean differences between the AML and ALL groups (Golub et al. [1999](#ref-Golub1999)).
Interestingly, the third probe, myeloperoxidase, is a cytochemical
marker for the diagnosis (and also potentially the prognosis) of acute
myeloid leukemia (AML).

# 5 Session info

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] hu6800.db_3.13.0            org.Hs.eg.db_3.22.0
##  [3] AnnotationDbi_1.72.0        golubEsets_1.51.0
##  [5] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           ropls_1.42.0
## [17] biosigner_1.38.0            BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      MultiDataSet_1.38.0  xfun_0.53
##  [4] bslib_0.9.0          lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          proxy_0.4-27         RSQLite_2.4.3
## [10] blob_1.2.4           pkgconfig_2.0.3      BiocBaseUtils_1.12.0
## [13] Matrix_1.7-4         lifecycle_1.0.4      compiler_4.5.1
## [16] Biostrings_2.78.0    statmod_1.5.1        tinytex_0.57
## [19] htmltools_0.5.8.1    class_7.3-23         sass_0.4.10
## [22] yaml_2.3.10          crayon_1.5.3         jquerylib_0.1.4
## [25] MASS_7.3-65          DelayedArray_0.36.0  cachem_1.1.0
## [28] limma_3.66.0         magick_2.9.0         abind_1.4-8
## [31] digest_0.6.37        bookdown_0.45        fastmap_1.2.0
## [34] grid_4.5.1           cli_3.6.5            SparseArray_1.10.0
## [37] magrittr_2.0.4       S4Arrays_1.10.0      randomForest_4.7-1.2
## [40] e1071_1.7-16         bit64_4.6.0-1        calibrate_1.7.7
## [43] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [46] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [49] evaluate_1.0.5       knitr_1.50           qqman_0.1.9
## [52] rlang_1.1.6          Rcpp_1.1.0           DBI_1.2.3
## [55] BiocManager_1.30.26  jsonlite_2.0.0       R6_2.6.1
```

# References

Carlson, M. 2016. *Hu6800.db: Affymetrix Hugenefl Genome Array Annotation Data (Chip Hu6800)*.

Determan, CE. 2015. “Optimal Algorithm for Metabolomics Classification and Feature Selection Varies by Dataset.” *International Journal of Biology* 7 (1): 100–115. <https://doi.org/10.5539/ijb.v7n1p100>.

Franceschi, P., D. Masuero, U. Vrhovsek, F. Mattivi, and R. Wehrens. 2012. “A Benchmark Spike-in Data Set for Biomarker Identification in Metabolomics.” *Journal of Chemometrics* 26 (1-2): 16–24. <https://doi.org/10.1002/cem.1420>.

Golub, TR., DK. Slonim, P. Tamayo, C. Huard, M. Gaasenbeek, JP. Mesirov, H. Coller, et al. 1999. “Molecular Classification of Cancer: Class Discovery and Class Prediction by Gene Expression Monitoring.” *Science* 286 (5439): 531. <https://doi.org/10.1126/science.286.5439.531>.

Gromski, PS., Y. Xu, E. Correa, DI. Ellis, ML. Turner, and R. Goodacre. 2014. “A Comparative Investigation of Modern Feature Selection and Classification Approaches for the Analysis of Mass Spectrometry Data.” *Analytica Chimica Acta* 829 (0): 1–8. <https://doi.org/10.1016/j.aca.2014.03.039>.

Guyon, I., and A. Elisseeff. 2003. “An Introduction to Variable and Feature Selection.” *Journal of Machine Learning Research* 3: 1157–82.

Rifai, N., MA. Gillette, and SA. Carr. 2006. “Protein Biomarker Discovery and Validation: The Long and Uncertain Path to Clinical Utility.” *Nature Biotechnology*. <https://doi.org/10.1038/nbt1235>.

Rinaudo, P., S. Boudah, C. Junot, and EA. Thevenot. 2016. “Biosigner: A New Method for the Discovery of Significant Molecular Signatures from Omics Data.” *Frontiers in Molecular Biosciences* 3. <https://doi.org/10.3389/fmolb.2016.00026>.

Saeys, Y., I. Inza, and P. Larranaga. 2007. “A Review of Feature Selection Techniques in Bioinformatics.” *Bioinformatics* 23 (19): 2507–17. <https://doi.org/10.1093/bioinformatics/btm344>.

Thevenot, EA., A. Roux, Y. Xu, E. Ezan, and C. Junot. 2015. “Analysis of the Human Adult Urinary Metabolome Variations with Age, Body Mass Index, and Gender by Implementing a Comprehensive Workflow for Univariate and OPLS Statistical Analyses.” *Journal of Proteome Research* 14 (8): 3322–35. <https://doi.org/10.1021/acs.jproteome.5b00354>.