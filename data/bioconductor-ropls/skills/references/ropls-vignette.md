# *ropls*: PCA, PLS(-DA) and OPLS(-DA) for multivariate analysis and feature selection of omics data

Etienne A. Thevenot

#### 30 October 2025

#### Package

ropls 1.42.0

# 1 The *ropls* package

The
[`ropls`](http://bioconductor.org/packages/release/bioc/html/ropls.html)
R package implements the **PCA**, **PLS(-DA)** and **OPLS(-DA)**
approaches with the original, **NIPALS**-based, versions of the
algorithms (Wold, Sjostrom, and Eriksson [2001](#ref-Wold2001); Trygg and Wold [2002](#ref-Trygg2002)). It includes the **R2** and **Q2**
quality metrics (Eriksson et al. [2001](#ref-Eriksson2001); Tenenhaus [1998](#ref-Tenenhaus1998)), the permutation
**diagnostics** (Szymanska et al. [2012](#ref-Szymanska2012)), the computation of the **VIP** values
(Wold, Sjostrom, and Eriksson [2001](#ref-Wold2001)), the score and orthogonal distances to detect **outliers**
(Hubert, Rousseeuw, and Vanden Branden [2005](#ref-Hubert2005)), as well as many **graphics** (scores, loadings,
predictions, diagnostics, outliers, etc).

# 2 Context

## 2.1 Orthogonal Partial Least-Squares

**Partial Least-Squares (PLS)**, which is a latent variable regression
method based on covariance between the predictors and the response, has
been shown to efficiently handle datasets with multi-collinear
predictors, as in the case of spectrometry measurements (Wold, Sjostrom, and Eriksson [2001](#ref-Wold2001)).
More recently, Trygg and Wold ([2002](#ref-Trygg2002)) introduced the **Orthogonal Partial
Least-Squares (OPLS)** algorithm to model separately the variations of
the predictors correlated and orthogonal to the response.

OPLS has a similar predictive capacity compared to PLS and improves the
**interpretation** of the predictive components and of the systematic
variation (Pinto, Trygg, and Gottfries [2012](#ref-Pinto2012a)). In particular, OPLS modeling of single
responses only requires one predictive component.

**Diagnostics** such as the **Q2Y** metrics and permutation testing are
of high importance to **avoid overfitting** and assess the statistical
significance of the model. The **Variable Importance in Projection
(VIP)**, which reflects both the loading weights for each component and
the variability of the response explained by this component
(Pinto, Trygg, and Gottfries [2012](#ref-Pinto2012a); Mehmood et al. [2012](#ref-Mehmood2012)), can be used for feature selection
(Trygg and Wold [2002](#ref-Trygg2002); Pinto, Trygg, and Gottfries [2012](#ref-Pinto2012a)).

## 2.2 OPLS software

OPLS is available in the **SIMCA-P** commercial software (Umetrics,
Umea, Sweden; Eriksson et al. ([2001](#ref-Eriksson2001))). In addition, the kernel-based version of
OPLS (Bylesjo et al. [2008](#ref-Bylesjo2008a)) is available in the open-source R statistical
environment (R Development Core Team [2008](#ref-RCoreTeam2016)), and a single implementation of the linear
algorithm in R has been described (Gaude et al. [2013](#ref-Gaude2013)).

# 3 The *sacurine* metabolomics dataset

The *sacurine* metabolomics dataset will be used as a case study to
describe the features from the **ropls** pacakge.

## 3.1 Study objective

The objective was to study the influence of **age**, **body mass index
(bmi)**, and **gender** on metabolite concentrations in **urine**, by
analysing 183 samples from a **cohort** of adults with liquid
chromatography coupled to high-resolution mass spectrometry
(**LC-HRMS**; Thevenot et al. ([2015](#ref-Thevenot2015))).

## 3.2 Pre-processing and annotation

Urine samples were analyzed by using an LTQ Orbitrap in the negative
ionization mode. A total of **109 metabolites** were identified or
annotated at the MSI level 1 or 2. After retention time alignment with
XCMS, peaks were integrated with Quan Browser. Signal drift and batch
effect were corrected, and each urine profile was normalized to the
osmolality of the sample. Finally, the data were log10 transformed
(Thevenot et al. [2015](#ref-Thevenot2015)).

## 3.3 Covariates

The volunteers’ **`age`**, **body mass index (`bmi`)**, and **`gender`**
were recorded.

# 4 Hands-on

## 4.1 Loading

We first load the
[`ropls`](http://bioconductor.org/packages/release/bioc/html/ropls.html)
package:

```
library(ropls)
```

We then load the **`sacurine`** dataset which contains:

1. The **`dataMatrix`** matrix of numeric type containing the intensity
   profiles (log10 transformed),
2. The **`sampleMetadata`** data frame containg sample metadata,
3. The **`variableMetadata`** data frame containg variable metadata

```
data(sacurine)
names(sacurine)
```

```
## [1] "dataMatrix"       "sampleMetadata"   "variableMetadata" "se"
## [5] "eset"
```

We display a summary of the
content of the **dataMatrix**, **sampleMetadata** and
**variableMetadata** with the `view` method from the
[ropls](http://bioconductor.org/packages/release/bioc/html/ropls.html)
package:

```
view(sacurine$dataMatrix)
```

```
##        dim  class    mode typeof   size NAs  min mean median max
##  183 x 109 matrix numeric double 0.2 Mb   0 -0.3  4.2    4.3   6
##        (2-methoxyethoxy)propanoic acid isomer (gamma)Glu-Leu/Ile ...
## HU_011                            3.019766011        3.888479324 ...
## HU_014                             3.81433889        4.277148905 ...
## ...                                       ...                ... ...
## HU_208                            3.748127215        4.523763202 ...
## HU_209                            4.208859398        4.675880567 ...
##        Valerylglycine isomer 2  Xanthosine
## HU_011             3.889078716 4.075879575
## HU_014             4.181765852 4.195761901
## ...                        ...         ...
## HU_208             4.634338821 4.487781609
## HU_209              4.47194762 4.222953354
```

![](data:image/png;base64...)

```
view(sacurine$sampleMetadata)
```

```
##      age     bmi gender
##  numeric numeric factor
##  nRow nCol size NAs
##   183    3 0 Mb   0
##         age   bmi gender
## HU_011   29 19.75      M
## HU_014   59 22.64      F
## ...     ...   ...    ...
## HU_208   27 18.61      F
## HU_209 17.5 21.48      F
```

```
## 1 data.frame 'factor' column(s) converted to 'numeric' for plotting.
```

![](data:image/png;base64...)

```
view(sacurine$variableMetadata)
```

```
##  msiLevel      hmdb chemicalClass
##   numeric character     character
##  nRow nCol size NAs
##   109    3 0 Mb   0
##                                        msiLevel      hmdb chemicalClass
## (2-methoxyethoxy)propanoic acid isomer        2                  Organi
## (gamma)Glu-Leu/Ile                            2                  AA-pep
## ...                                         ...       ...           ...
## Valerylglycine isomer 2                       2           AA-pep:AcyGly
## Xanthosine                                    1 HMDB00299        Nucleo
```

```
## 2 data.frame 'character' column(s) converted to 'numeric' for plotting.
```

![](data:image/png;base64...)

Note:

1. the `view` method applied to a numeric matrix also generates a
   graphical display
2. the `view` method can also be applied to an ExpressionSet object
   (see below)

## 4.2 Principal Component Analysis (PCA)

We perform a **PCA** on the **dataMatrix** matrix (samples as rows,
variables as columns), with the `opls` method:

```
sacurine.pca <- opls(sacurine$dataMatrix)
```

A **summary** of the model (8 components were selected) is printed:

```
## PCA
## 183 samples x 109 variables
## standard scaling of predictors
##       R2X(cum) pre ort
## Total    0.501   8   0
```

In addition the default **summary** figure is displayed:

![](data:image/png;base64...)

**Figure 1: PCA summary plot.** **Top left** `overview`: the **scree**
plot (i.e., inertia barplot) suggests that 3 components may be
sufficient to capture most of the inertia; **Top right** `outlier`: this
graphics shows the distances within and orthogonal to the projection
plane (Hubert, Rousseeuw, and Vanden Branden [2005](#ref-Hubert2005)): the name of the samples with a high value for at
least one of the distances are indicated (see the Comments section for the code used to compute these metrics and the thresholds); **Bottom left** `x-score`: the
variance along each axis equals the variance captured by each component:
it therefore depends on the total variance of the dataMatrix *X* and of
the percentage of this variance captured by the component (indicated in
the labels); it decreases when going from one component to a component
with higher indice; **Bottom right** `x-loading`: the 3 variables with
most extreme values (positive and negative) for each loading are black
colored and labeled.

Note:

1. Since **dataMatrix** does not contain missing value, the singular
   value decomposition was used by default; NIPALS can be selected with
   the `algoC` argument specifying the *algo*rithm (*C*haracter),
2. The `predI = NA` default number of *pred*ictive components
   (*I*nteger) for PCA means that components (up to 10) will be
   computed until the cumulative variance exceeds 50%. If the 50% have
   not been reached at the 10th component, a warning message will be
   issued (you can still compute the following components by specifying
   the `predI` value).

Let us see if we notice any partition according to gender, by
labeling/coloring the samples according to *gender* (`parAsColFcVn`) and
drawing the Mahalanobis ellipses for the male and female subgroups
(`parEllipseL`).

```
genderFc <- sacurine$sampleMetadata[, "gender"]
plot(sacurine.pca,
     typeVc = "x-score",
     parAsColFcVn = genderFc)
```

![](data:image/png;base64...)

**Figure 2: PCA score plot colored according to gender.**

Note:

1. The plotting *par*ameter to be used *As* *Col*ors (*F*actor of
   *c*haracter type or *V*ector of *n*umeric type) has a length equal
   to the number of rows of the **dataMatrix** (ie of samples) and that
   this qualitative or quantitative variable is converted into colors
   (by using an internal palette or color scale, respectively). We
   could have visualized the *age* of the individuals by specifying
   `parAsColFcVn = sampleMetadata[, "age"]`.
2. The displayed components can be specified with `parCompVi` (plotting
   *par*ameter specifying the *Comp*onents: *V*ector of 2 *i*ntegers)
3. The labels and the color palette can be personalized with the
   `parLabVc` and `parPaletteVc` parameters, respectively:

```
plot(sacurine.pca,
     typeVc = "x-score",
     parAsColFcVn = genderFc,
     parLabVc = as.character(sacurine$sampleMetadata[, "age"]),
     parPaletteVc = c("green4", "magenta"))
```

![](data:image/png;base64...)

## 4.3 Partial least-squares: PLS and PLS-DA

For **PLS (and OPLS)**, the **Y** response(s) must be provided to the
`opls` method. **Y** can be either a numeric vector (respectively
matrix) for single (respectively multiple) **(O)PLS regression**, or a
character factor for **(O)PLS-DA classification** as in the following
example with the *gender* qualitative response:

```
sacurine.plsda <- opls(sacurine$dataMatrix, genderFc)
```

```
## PLS-DA
## 183 samples x 109 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.275     0.73   0.584 0.262   3   0 0.05 0.05
```

![](data:image/png;base64...)

**Figure 3: PLS-DA model of the gender response.** **Top left**:
`inertia` barplot: the graphic here suggests that 3 orthogonal
components may be sufficient to capture most of the inertia; **Top
right**: `significance` diagnostic: the **R2Y** and **Q2Y** of the model
are compared with the corresponding values obtained after random
permutation of the *y* response; **Bottom left**: `outlier` diagnostics;
**Bottom right**: `x-score` plot: the number of components and the
cumulative **R2X**, **R2Y** and **Q2Y** are indicated below the plot.

Note:

1. When set to NA (as in the default), **the number of components**
   `predI` is determined automatically as follows (Eriksson et al. [2001](#ref-Eriksson2001)): A
   new component *h* is added to the model if:

* \(R2Y\_h \geq 0.01\), i.e., the percentage of **Y** dispersion (i.e.,
  sum of squares) explained by component *h* is more than 1 percent,
  and
* \(Q2Y\_h=1-PRESS\_h/RSS\_{h-1} \geq 0\) for PLS (or 5% when the number of
  samples is less than 100) or 1% for OPLS: \(Q2Y\_h \geq 0\) means that
  the predicted residual sum of squares (\(PRESS\_h\)) of the model
  including the new component *h* estimated by 7-fold cross-validation
  is less than the residual sum of squares (\(RSS\_{h-1}\)) of the model
  with the previous components only (with \(RSS\_0\) being the sum of
  squared **Y** values).

2. The **predictive performance** of the full model is assessed by the
   cumulative **Q2Y** metric: \(Q2Y=1-\prod\limits\_{h=1}^r (1-Q2Y\_h)\).
   We have \(Q2Y \in [0,1]\), and the higher the **Q2Y**, the better the
   performance. Models trained on datasets with a larger number of
   features compared with the number of samples can be prone to
   **overfitting**: in that case, high **Q2Y** values are obtained by
   chance only. To estimate the significance of **Q2Y** (and **R2Y**)
   for single response models, permutation testing (Szymanska et al. [2012](#ref-Szymanska2012)) can
   be used: models are built after random permutation of the **Y**
   values, and \(Q2Y\_{perm}\) are computed. The *p*-value is equal to the
   proportion of \(Q2Y\_{perm}\) above \(Q2Y\) (the **default number of
   permutations is 20** as a compromise between quality control and
   computation speed; it can be increased with the `permI` parameter,
   e.g. to 1,000, to assess if the model is significant at the 0.05
   level),
3. The **NIPALS** algorithm is used for PLS (and OPLS); *dataMatrix*
   matrices with (a moderate amount of) missing values can thus be
   analysed.

We see that our model with 3 predictive (*pre*) components has
significant and quite high R2Y and Q2Y values.

## 4.4 Orthogonal partial least squares: OPLS and OPLS-DA

To perform **OPLS(-DA)**, we set `orthoI` (number of components which
are *ortho*gonal; *I*nteger) to either a specific number of orthogonal
components, or to NA. Let us build an OPLS-DA model of the *gender*
response.

```
sacurine.oplsda <- opls(sacurine$dataMatrix, genderFc,
                        predI = 1, orthoI = NA)
```

```
## OPLS-DA
## 183 samples x 109 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.275     0.73   0.602 0.262   1   2 0.05 0.05
```

![](data:image/png;base64...)

**Figure 4: OPLS-DA model of the gender response.**

Note:

1. For OPLS modeling of a single response, the number of predictive
   component is 1,
2. In the (`x-score` plot), the predictive component is displayed as
   abscissa and the (selected; default = 1) orthogonal component as
   ordinate.

Let us assess the **predictive performance** of our model. We first
train the model on a subset of the samples (here we use the `odd` subset
value which splits the data set into two halves with similar proportions
of samples for each class; alternatively, we could have used a specific
subset of indices for training):

```
sacurine.oplsda <- opls(sacurine$dataMatrix, genderFc,
                        predI = 1, orthoI = NA,
                        subset = "odd")
```

```
## OPLS-DA
## 92 samples x 109 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE RMSEP pre ort
## Total     0.26    0.825   0.608 0.213 0.341   1   2
```

![](data:image/png;base64...)

We first check the predictions on the **training** subset:

```
trainVi <- getSubsetVi(sacurine.oplsda)
confusion_train.tb <- table(genderFc[trainVi], fitted(sacurine.oplsda))
confusion_train.tb
```

```
##
##      M  F
##   M 50  0
##   F  0 42
```

We then compute the performances on the **test** subset:

```
confusion_test.tb <- table(genderFc[-trainVi],
                           predict(sacurine.oplsda,
                                   sacurine$dataMatrix[-trainVi, ]))
confusion_test.tb
```

```
##
##      M  F
##   M 43  7
##   F  7 34
```

As expected, the predictions on the test subset are (slightly) lower.
The classifier however still achieves
85%
of correct predictions.

## 4.5 Working on `SummarizedExperiment` objects

The **`SummarizedExperiment`** class from the
[SummarizedExperiment](https://www.bioconductor.org/packages/SummarizedExperiment/)
bioconductor package has been developed to conveniently handle
preprocessed omics objects, including the *variable x sample* matrix of
intensities, and two DataFrames containing the sample and variable
metadata, which can be accessed by the `assay`, `colData` and `rowData`
methods respectively (remember that the data matrix is stored with
samples in columns).

The `opls` method can be applied to a **`SummarizedExperiment`** object,
by using the object as the `x` argument, and, for (O)PLS(-DA), by
indicating as the `y` argument the name of the sample metadata to be
used as the response (i.e. the name of the column in the `colData`). It
returns the updated **`SummarizedExperiment`** object with the loading,
score, VIP, etc. data as new columns in the `colData` and `rowData`, and
with the PCA/(O)PLS(-DA) models in the `metadata` slot.

Getting the sacurine dataset as a `SummarizedExperiment` (see the
Appendix to see how such an `SummarizedExperiment` was built):

```
data(sacurine)
sac.se <- sacurine$se
```

We then build the PLS-DA model of the gender response

```
sac.se <- opls(sac.se, "gender")
```

![](data:image/png;base64...)

Note that the `opls` method returns an updated `SummarizedExperiment`
with the metadata about scores, loadings, VIPs, etc. stored in the
`colData` and `rowData` DataFrames:

```
suppressPackageStartupMessages(library(SummarizedExperiment))
message("colData:\n")
head(SummarizedExperiment::colData(sac.se))
```

```
## DataFrame with 6 rows and 6 columns
##              age       bmi   gender gender_PLSDA_xscor-p1 gender_PLSDA_xscor-p2
##        <numeric> <numeric> <factor>             <numeric>             <numeric>
## HU_011        29     19.75        M              -2.69395              3.396080
## HU_014        59     22.64        F               0.75108              2.186106
## HU_015        42     22.72        M              -4.39096              0.854612
## HU_017        41     23.03        M              -3.19297             -0.898535
## HU_018        34     20.96        M              -2.39676             -1.725307
## HU_019        35     23.41        M              -1.56225             -1.575008
##        gender_PLSDA_fitted
##                <character>
## HU_011                   M
## HU_014                   F
## HU_015                   M
## HU_017                   M
## HU_018                   M
## HU_019                   M
```

```
message("\nrowData:\n")
head(SummarizedExperiment::rowData(sac.se))
```

```
## DataFrame with 6 rows and 7 columns
##                                         msiLevel        hmdb chemicalClass
##                                        <integer> <character>   <character>
## (2-methoxyethoxy)propanoic acid isomer         2                    Organi
## (gamma)Glu-Leu/Ile                             2                    AA-pep
## 1-Methyluric acid                              1   HMDB03099 AroHeP:Xenobi
## 1-Methylxanthine                               1   HMDB10738        AroHeP
## 1,3-Dimethyluric acid                          1   HMDB01857        AroHeP
## 1,7-Dimethyluric acid                          1   HMDB11103        AroHeP
##                                        gender_PLSDA_xload-p1
##                                                    <numeric>
## (2-methoxyethoxy)propanoic acid isomer             0.0398502
## (gamma)Glu-Leu/Ile                                -0.0455062
## 1-Methyluric acid                                  0.0892685
## 1-Methylxanthine                                   0.0925960
## 1,3-Dimethyluric acid                              0.0533869
## 1,7-Dimethyluric acid                              0.1055559
##                                        gender_PLSDA_xload-p2 gender_PLSDA_VIP
##                                                    <numeric>        <numeric>
## (2-methoxyethoxy)propanoic acid isomer             0.0118907         0.413403
## (gamma)Glu-Leu/Ile                                -0.1898538         1.486543
## 1-Methyluric acid                                 -0.2004731         0.994359
## 1-Methylxanthine                                  -0.1662373         0.909199
## 1,3-Dimethyluric acid                             -0.1667939         0.703483
## 1,7-Dimethyluric acid                             -0.1296543         0.680326
##                                        gender_PLSDA_coef
##                                                <numeric>
## (2-methoxyethoxy)propanoic acid isomer        0.02131414
## (gamma)Glu-Leu/Ile                           -0.08446224
## 1-Methyluric acid                            -0.04460135
## 1-Methylxanthine                             -0.04074580
## 1,3-Dimethyluric acid                        -0.02617327
## 1,7-Dimethyluric acid                         0.00229719
```

The opls model(s) are stored in the metadata of the sac.se
`SummarizedExperiment` object, and can be accessed with the `getOpls`
method:

```
sac_opls.ls <- getOpls(sac.se)
names(sac_opls.ls)
```

```
## [1] "gender_PLSDA"
```

```
plot(sac_opls.ls[["gender_PLSDA"]], typeVc = "x-score")
```

![](data:image/png;base64...)

Note that the scores can be conveniently plotted by a direct call to the `SummarizedExperiment` object once the `opls` models have been computed. The `plot_score` method, by specifying the model of interest, outputs the score plot either as a `ggplot` or a `plotly` object. In the example below, we select a `plotly` output which displays all information available in the sample metadata as interactive labels:

```
plot_score(sac.se, model.c = "gender_PLSDA", plotly.l = TRUE, info.vc = "all")
```

### 4.5.1 `ExpressionSet` format

The `ExpressionSet` format is currently supported as a legacy
representation from the previous versions of the `ropls` package (<
1.28.0) but will now be supplanted by `SummarizedExperiment` in future
versions. Note that the `as(x, "SummarizedExperiment")` method from the
`SummarizedExperiment` package enables to convert an `ExpressionSet`
into the `SummarizedExperiment` format.

`exprs`, `pData`, and `fData` for `ExpressionSet` are similar to
`assay`, `colData` and `rowData` for `SummarizedExperiment` except that
`assay` is a list which can potentially include several matrices, and
that `colData` and `rowData` are of the `DataFrame` format.
`SummarizedExperiment` format further enables to store additional
metadata (such as models or ggplots) in a dedicated `metadata` slot.

In the example below, we will first build a minimal **`ExpressionSet`**
object from the *sacurine* data set and view the data, and we
subsequently perform an OPLS-DA.

Getting the sacurine dataset as an `ExpressionSet` (see the Appendix to
see how such an `ExpressionSet` was built)

```
data("sacurine")
sac.set <- sacurine$eset
# viewing the ExpressionSet
# ropls::view(sac.set)
```

We then build the PLS-DA model of the gender response

```
# performing the PLS-DA
sac.plsda <- opls(sac.set, "gender")
```

![](data:image/png;base64...)

Note that this time `opls` returns the model as an object of the `opls`
class. The updated `ExpressionSet` object can be accessed with the
`getEset` method:

```
sac.set <- getEset(sac.plsda)
library(Biobase)
head(Biobase::pData(sac.set))
```

```
##        age   bmi gender gender_PLSDA_xscor-p1 gender_PLSDA_xscor-p2
## HU_011  29 19.75      M            -2.6939546             3.3960801
## HU_014  59 22.64      F             0.7510799             2.1861065
## HU_015  42 22.72      M            -4.3909624             0.8546116
## HU_017  41 23.03      M            -3.1929659            -0.8985349
## HU_018  34 20.96      M            -2.3967633            -1.7253069
## HU_019  35 23.41      M            -1.5622495            -1.5750081
##        gender_PLSDA_fitted
## HU_011                   M
## HU_014                   F
## HU_015                   M
## HU_017                   M
## HU_018                   M
## HU_019                   M
```

## 4.6 Working on `MultiAssayExperiment` objects

The `MultiAssayExperiment` format is useful to handle **multi-omics**
datasets (Ramos et al. [2017](#ref-Ramos_SoftwareIntegrationMultiomics_2017)). (O)PLS(-DA) models
can be built in parallel for each dataset by applying `opls` to such
formats. We provide an example based on the `NCI60_4arrays` cancer
dataset from the `omicade4` package (which has been made available in
this `ropls` package in the `MultiAssayExperiment` format).

Getting the `NCI60` dataset as a `MultiAssayExperiment` (see the
Appendix to see how such a `MultiAssayExperiment` can be built):

```
data("NCI60")
nci.mae <- NCI60[["mae"]]
```

Building the PLS-DA model of the `cancer` response for each dataset:

```
nci.mae <- opls(nci.mae, "cancer",
                predI = 2, fig.pdfC = "none")
```

```
##
##
## Building the model for the 'agilent' dataset:
## PLS-DA
## 60 samples x 300 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.262    0.231   0.182 0.275   2   0 0.05 0.05
##
##
## Building the model for the 'hgu133' dataset:
## PLS-DA
## 60 samples x 298 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.318    0.234   0.218 0.273   2   0 0.05 0.05
##
##
## Building the model for the 'hgu133p2' dataset:
## PLS-DA
## 60 samples x 268 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.312    0.234   0.214 0.273   2   0 0.05 0.05
##
##
## Building the model for the 'hgu95' dataset:
## PLS-DA
## 60 samples x 288 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.329    0.232   0.214 0.273   2   0 0.05 0.05
```

The `opls` method returns an updated `MultiAssayExperiment` with the
metadata about scores, loadings, VIPs, etc. stored in the `colData` and
`rowData` of the individual `SummarizedExperiment`:

```
SummarizedExperiment::colData(nci.mae[["agilent"]])
```

```
## DataFrame with 60 rows and 4 columns
##                         .id cancer_PLSDA_xscor-p1 cancer_PLSDA_xscor-p2
##                 <character>             <numeric>             <numeric>
## BR.MCF7             BR.MCF7              -4.05869               3.60974
## BR.MDA_MB_231 BR.MDA_MB_231               2.85600               3.25368
## BR.HS578T         BR.HS578T               7.16701               1.23469
## BR.BT_549         BR.BT_549               5.27739               3.56892
## BR.T47D             BR.T47D               1.21882               3.88150
## ...                     ...                   ...                   ...
## RE.CAKI_1         RE.CAKI_1               4.01588               5.10785
## RE.RXF_393       RE.RXF_393               7.30202               5.28137
## RE.SN12C           RE.SN12C               3.43798               4.65690
## RE.TK_10           RE.TK_10               1.65842               5.41697
## RE.UO_31           RE.UO_31               5.65133               4.90524
##               cancer_PLSDA_fitted
##                       <character>
## BR.MCF7                        CO
## BR.MDA_MB_231                  RE
## BR.HS578T                      RE
## BR.BT_549                      RE
## BR.T47D                        RE
## ...                           ...
## RE.CAKI_1                      RE
## RE.RXF_393                     RE
## RE.SN12C                       RE
## RE.TK_10                       RE
## RE.UO_31                       RE
```

The opls model(s) are stored in the metadata of the individual
`SummarizedExperiment` objects included in the `MultiAssayExperiment`,
and can be accessed with the `getOpls` method:

```
mae_opls.ls <- getOpls(nci.mae)
names(mae_opls.ls)
```

```
## [1] "agilent"  "hgu133"   "hgu133p2" "hgu95"
```

```
plot(mae_opls.ls[["agilent"]][["cancer_PLSDA"]], typeVc = "x-score")
```

![](data:image/png;base64...)

### 4.6.1 `MultiDataSet` objects

The `MultiDataSet` format (Ramos et al. [2017](#ref-Ramos_SoftwareIntegrationMultiomics_2017)) is
currently supported as a legacy representation from the previous
versions of the `ropls` package (<1.28.0) but will now be supplanted by
`MultiAssayExperiment` in future versions. Note that the `mds2mae`
method from the `MultiDataSet` package enables to convert a
`MultiDataSet` into the `MultiAssayExperiment` format.

Getting the `NCI60` dataset as a `MultiDataSet` (see the Appendix to see
how such a `MultiDataSet` can be built):

```
data("NCI60")
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
# Building PLS-DA models for the cancer type
nci.plsda <- ropls::opls(nci.mds, "cancer", predI = 2)
```

![](data:image/png;base64...)![](data:image/png;base64...)

Getting back the updated `MultiDataSet`:

```
nci.mds <- ropls::getMset(nci.plsda)
```

## 4.7 Importing/exporting data

The datasets from the `SummarizedExperiment` and `MultiAssayExperiment`
(as well as `ExpressionSet` and `MultiDataSet`) can be imported/exported
to text files with the `reading` and `writing` functions from the
[`phenomis`](https://bioconductor.org/packages/phenomis/) package also available on Bioconductor.

Each dataset is imported/exported to 3 text files (tsv tabular format):

* dataMatrix.tsv: data matrix with features as rows and samples as
  columns
* sampleMetadata.tsv: sample metadata
* variableMetadata.tsv: feature metadata

```
library(phenomis)
sacurine.se <- sacurine$se
phenomis::writing(sacurine.se, dir.c = getwd())
```

## 4.8 Graphical User Interface

The features from the `ropls` package can also be accessed via a
graphical user interface in the **Multivariate** module from the
[Workflow4Metabolomics.org](https://workflow4metabolomics.usegalaxy.fr/)
online resource for computational metabolomics, based on the Galaxy
environment.

# 5 Comments

## 5.1 Overfitting

**Overfitting** (i.e., building a model with good performances on the
training set but poor performances on a new test set) is a major caveat
of machine learning techniques applied to data sets with more variables
than samples. A simple simulation of a random **X** data set and a **y**
response shows that perfect PLS-DA classification can be achieved as
soon as the number of variables exceeds the number of samples, as
detailed in the example below, adapted from Wehrens ([2011](#ref-Wehrens2011)):

![](data:image/png;base64...)

**Figure 5: Risk of PLS overfitting.** In the simulation above, a
**random matrix X** of 20 observations x 200 features was generated by
sampling from the uniform distribution \(U(0, 1)\). A **random y**
response was obtained by sampling (without replacement) from a vector of
10 zeros and 10 ones. **Top left**, **top right**, and **bottom left**:
the X-**score plots** of the PLS modeling of **y** by the (sub)matrix of
**X** restricted to the first 2, 20, or 200 features, are displayed
(i.e., the observation/feature ratios are 0.1, 1, and 10, respectively).
Despite the good separation obtained on the bottom left score plot, we
see that the **Q2Y** estimation of predictive performance is low
(negative); **Bottom right**: a significant proportion of the models
trained after random permutations of the labels have a higher **Q2Y**
value than the model trained with the true labels, confirming that PLS
cannot specifically model the **y** response with the **X** predictors,
as expected.

This simple simulation illustrates that PLS overfit can occur, in
particular when the number of features exceeds the number of
observations. **It is therefore essential to check that the** \(Q2Y\)
value of the model is significant by random permutation of the labels.

## 5.2 VIP from OPLS models

The classical **VIP** metric is not useful for OPLS modeling of a single
response since (Galindo-Prieto, Eriksson, and Trygg [2014](#ref-Galindo-Prieto2014); Thevenot et al. [2015](#ref-Thevenot2015)): 1. **VIP** values
remain identical whatever the number of orthogonal components selected,
2. **VIP** values are univariate (i.e., they do not provide information
about interactions between variables). In fact, when features are
standardized, we can demonstrate a mathematical relationship between VIP
and *p*-values from a Pearson correlation test (Thevenot et al. [2015](#ref-Thevenot2015)), as
illustrated by the figure below:

```
ageVn <- sacurine$sampleMetadata[, "age"]

pvaVn <- apply(sacurine$dataMatrix, 2,
               function(feaVn) cor.test(ageVn, feaVn)[["p.value"]])

vipVn <- getVipVn(opls(sacurine$dataMatrix, ageVn,
                       predI = 1, orthoI = NA,
                       fig.pdfC = "none"))
```

```
## OPLS
## 183 samples x 109 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum) RMSEE pre ort pR2Y  pQ2
## Total    0.212    0.476    0.31  7.53   1   1 0.05 0.05
```

```
quantVn <- qnorm(1 - pvaVn / 2)
rmsQuantN <- sqrt(mean(quantVn^2))

opar <- par(font = 2, font.axis = 2, font.lab = 2,
            las = 1,
            mar = c(5.1, 4.6, 4.1, 2.1),
            lwd = 2, pch = 16)

plot(pvaVn, vipVn,
     col = "red",
     pch = 16,
     xlab = "p-value", ylab = "VIP", xaxs = "i", yaxs = "i")

box(lwd = 2)

curve(qnorm(1 - x / 2) / rmsQuantN, 0, 1, add = TRUE, col = "red", lwd = 3)

abline(h = 1, col = "blue")
abline(v = 0.05, col = "blue")
```

![](data:image/png;base64...)

```
par(opar)
```

**Figure 6: Relationship between VIP from one-predictive PLS or OPLS
models with standardized variables, and p-values from Pearson
correlation test.** The \((p\_j, VIP\_j)\) pairs corresponding respectively
to the VIP values from OPLS modelling of the *age* response with the
*sacurine* dataset, and the *p*-values from the Pearson correlation test
are shown as red dots. The \(y = \Phi^{-1}(1 - x/2) / z\_{rms}\) curve is
shown in red (where \(\Phi^{-1}\) is the inverse of the probability
density function of the standard normal distribution, and \(z\_{rms}\) is
the quadratic mean of the \(z\_j\) quantiles from the standard normal
distribution; \(z\_{rms} = 2.6\) for the *sacurine* dataset and the *age*
response). The vertical (resp. horizontal) blue line corresponds to
univariate (resp. multivariate) thresholds of \(p=0.05\) and \(VIP=1\),
respectively (Thevenot et al. [2015](#ref-Thevenot2015)).

The **VIP** properties above result from:

1. OPLS models of a single response have a single predictive component,
2. in the case of one-predictive component (O)PLS models, the general
   formula for VIPs can be simplified to
   \(VIP\_j = \sqrt{m} \times |w\_j|\) for each feature \(j\), were \(m\) is
   the total number of features and **w** is the vector of loading
   weights,
3. in OPLS, **w** remains identical whatever the number of extracted
   orthogonal components,
4. for a single-response model, **w** is proportional to **X’y** (where
   **’** denotes the matrix transposition),
5. if **X** and **y** are standardized, **X’y** is the vector of the
   correlations between the features and the response.

Galindo-Prieto, Eriksson, and Trygg ([2014](#ref-Galindo-Prieto2014)) have recently suggested new VIP metrics for OPLS,
**VIP\_pred** and **VIP\_ortho**, to separately measure the influence of
the features in the modeling of the dispersion correlated to, and
orthogonal to the response, respectively (Galindo-Prieto, Eriksson, and Trygg [2014](#ref-Galindo-Prieto2014)).

For OPLS(-DA) models, you can therefore get from the model generated
with `opls`:

1. the **predictive VIP vector** (which corresponds to the
   \(VIP\_{4,pred}\) metric measuring the variable importance in
   prediction) with `getVipVn(model)`,
2. the orthogonal VIP vector which is the \(VIP\_{4,ortho}\) metric
   measuring the variable importance in orthogonal modeling with
   `getVipVn(model, orthoL = TRUE)`. As for the classical **VIP**, we
   still have the mean of \(VIP\_{pred}^2\) (and of \(VIP\_{ortho}^2\))
   which, each, equals 1.

## 5.3 (Orthogonal) Partial Least Squares Discriminant Analysis: (O)PLS-DA

### 5.3.1 Two classes

When the **y** response is a factor of 2 levels (character vectors are
also allowed), it is internally transformed into a vector of values
\(\in \{0,1\}\) encoding the classes. The vector is centered and
unit-variance scaled, and the (O)PLS analysis is performed.

Brereton and Lloyd ([2014](#ref-Brereton2014)) have demonstrated that when the sizes of the 2 classes are
**unbalanced**, a **bias** is introduced in the computation of the
decision rule, which penalizes the class with the highest size
(Brereton and Lloyd [2014](#ref-Brereton2014)). In this case, an external procedure using
**resampling** (to balance the classes) and taking into account the
class sizes should be used for optimal results.

### 5.3.2 Multiclass

In the case of **more than 2 levels**, the **y** response is internally
transformed into a matrix (each class is encoded by one column of values
\(\in \{0,1\}\)). The matrix is centered and unit-variance scaled, and the
PLS analysis is performed.

In this so-called **PLS2** implementation, the proportions of 0 and 1 in
the columns is usually unbalanced (even in the case of balanced size of
the classes) and the bias described previously occurs (Brereton and Lloyd [2014](#ref-Brereton2014)).
The multiclass PLS-DA results from
[ropls](http://bioconductor.org/packages/release/bioc/html/ropls.html)
are therefore indicative only, and we recommend to set an external
procedure where each column of the matrix is modeled separately (as
described above) and the resulting probabilities are aggregated (see for
instance Bylesjo et al. ([2006](#ref-Bylesjo2006))).

# 6 Appendix

## 6.1 Additional datasets

In addition to the *sacurine* dataset presented above, the package
contains the following datasets to illustrate the functionalities of
PCA, PLS and OPLS (see the examples in the documentation of the opls
function):

* **aminoacids** Amino-Acids Dataset. Quantitative structure property
  relationship (QSPR) (Wold, Sjostrom, and Eriksson [2001](#ref-Wold2001)).
* **cellulose** NIR-Viscosity example data set to illustrate
  multivariate calibration using PLS, spectral filtering and OPLS
  (Multivariate calibration using spectral data. Simca tutorial.
  Umetrics, Sweden).
* **cornell** Octane of various blends of gasoline: Twelve mixture
  component proportions of the blend are analysed (Tenenhaus [1998](#ref-Tenenhaus1998)).
* **foods** Food consumption patterns accross European countries
  (FOODS). The relative consumption of 20 food items was compiled for
  16 countries. The values range between 0 and 100 percent and a high
  value corresponds to a high consumption. The dataset contains 3
  missing data (Eriksson et al. [2001](#ref-Eriksson2001)).
* **linnerud** Three physiological and three exercise variables are
  measured on twenty middle-aged men in a fitness club
  (Tenenhaus [1998](#ref-Tenenhaus1998)).
* **lowarp** A multi response optimization data set (LOWARP)
  (Eriksson et al. [2001](#ref-Eriksson2001)).
* **mark** Marks obtained by french students in mathematics, physics,
  french and english. Toy example to illustrate the potentialities of
  PCA (Baccini [2010](#ref-Baccini2010)).

## 6.2 Cheat sheets for Bioconductor (multi)omics containers

### 6.2.1 `SummarizedExperiment`

The `SummarizedExperiment` format has been designed by the Bioconductor
team to handle (single) omics datasets (Morgan et al. [2022](#ref-Morgan2022)).

An example of `SummarizedExperiment` creation and a summary of useful
methods are provided below.

Please refer to [package
vignettes](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html)
for a full description of `SummarizedExperiment` objects .

```
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(sacurine, package = "ropls")
data.mn <- sacurine$dataMatrix # matrix: samples x variables
samp.df <- sacurine$sampleMetadata # data frame: samples x sample metadata
feat.df <- sacurine$variableMetadata # data frame: features x feature metadata

# Creating the SummarizedExperiment (package SummarizedExperiment)
library(SummarizedExperiment)
sac.se <- SummarizedExperiment(assays = list(sacurine = t(data.mn)),
                               colData = samp.df,
                               rowData = feat.df)
# note that colData and rowData main format is DataFrame, but data frames are accepted when building the object
stopifnot(validObject(sac.se))

# Viewing the SummarizedExperiment
# ropls::view(sac.se)
```

| Methods | Description | Returned class |
| --- | --- | --- |
| **Constructors** |  |  |
| **`SummarizedExperiment`** | Create a SummarizedExperiment object | `SummarizedExperiment` |
| **`makeSummarizedExperimentFromExpressionSet`** |  | `SummarizedExperiment` |
| **Accessors** |  |  |
| **`assayNames`** | Get or set the names of assay() elements | `character` |
| **`assay`** | Get or set the ith (default first) assay element | `matrix` |
| **`assays`** | Get the list of experimental data numeric matrices | `SimpleList` |
| **`rowData`** | Get or set the row data (features) | `DataFrame` |
| **`colData`** | Get or set the column data (samples) | `DataFrame` |
| **`metadata`** | Get or set the experiment data | `list` |
| **`dim`** | Get the dimensions (features of interest x samples) | `integer` |
| **`dimnames`** | Get or set the dimension names | `list` of length 2 character/NULL |
| **`rownames`** | Get the feature names | `character` |
| **`colnames`** | Get the sample names | `character` |
| **Conversion** |  |  |
| **`as(, "SummarizedExperiment")`** | Convert an ExpressionSet to a SummarizedExperiment | `SummarizedExperiment` |

### 6.2.2 `MultiAssayExperiment`

The `MultiAssayExperiment` format has been designed by the Bioconductor
team to handle multiomics datasets
(Ramos et al. [2017](#ref-Ramos_SoftwareIntegrationMultiomics_2017)).

An example of `MultiAssayExperiment` creation and a summary of useful
methods are provided below. Please refer to [package
vignettes](https://bioconductor.org/packages/MultiAssayExperiment/) or
to the original publication for a full description of
`MultiAssayExperiment` objects
(Ramos et al. [2017](#ref-Ramos_SoftwareIntegrationMultiomics_2017)).

Loading the `NCI60_4arrays` from the `omicade4` package:

```
data("NCI60_4arrays", package = "omicade4")
```

Creating the `MultiAssayExperiment`:

```
library(MultiAssayExperiment)
# Building the individual SummarizedExperiment instances
experiment.ls <- list()
sampleMap.ls <- list()
for (set.c in names(NCI60_4arrays)) {
  # Getting the data and metadata
  assay.mn <- as.matrix(NCI60_4arrays[[set.c]])
  coldata.df <- data.frame(row.names = colnames(assay.mn),
                           .id = colnames(assay.mn),
                           stringsAsFactors = FALSE) # the 'cancer' information will be stored in the main colData of the mae, not the individual SummarizedExperiments
  rowdata.df <- data.frame(row.names = rownames(assay.mn),
                           name = rownames(assay.mn),
                           stringsAsFactors = FALSE)
  # Building the SummarizedExperiment
  assay.ls <- list(se = assay.mn)
  names(assay.ls) <- set.c
  se <- SummarizedExperiment(assays = assay.ls,
                             colData = coldata.df,
                             rowData = rowdata.df)
  experiment.ls[[set.c]] <- se
  sampleMap.ls[[set.c]] <- data.frame(primary = colnames(se),
                                      colname = colnames(se)) # both datasets use identical sample names
}
sampleMap <- listToMap(sampleMap.ls)

# The sample metadata are stored in the colData data frame (both datasets have the same samples)
stopifnot(identical(colnames(NCI60_4arrays[[1]]),
                    colnames(NCI60_4arrays[[2]])))
sample_names.vc <- colnames(NCI60_4arrays[[1]])
colData.df <- data.frame(row.names = sample_names.vc,
                         cancer = substr(sample_names.vc, 1, 2))

nci.mae <- MultiAssayExperiment(experiments = experiment.ls,
                                colData = colData.df,
                                sampleMap = sampleMap)

stopifnot(validObject(nci.mae))
```

| Methods | Description | Returned class |
| --- | --- | --- |
| **Constructors** |  |  |
| **`MultiAssayExperiment`** | Create a MultiAssayExperiment object | `MultiAssayExperiment` |
| **`ExperimentList`** | Create an ExperimentList from a List or list | `ExperimentList` |
| **Accessors** |  |  |
| **`colData`** | Get or set data that describe the patients/biological units | `DataFrame` |
| **`experiments`** | Get or set the list of experimental data objects as original classes | `experimentList` |
| **`assays`** | Get the list of experimental data numeric matrices | `SimpleList` |
| **`assay`** | Get the first experimental data numeric matrix | `matrix`, matrix-like |
| **`sampleMap`** | Get or set the map relating observations to subjects | `DataFrame` |
| **`metadata`** | Get or set additional data descriptions | `list` |
| **`rownames`** | Get row names for all experiments | `CharacterList` |
| **`colnames`** | Get column names for all experiments | `CharacterList` |
| **Subsetting** |  |  |
| **`mae[i, j, k]`** | Get rows, columns, and/or experiments | `MultiAssayExperiment` |
| **`mae[i, ,]`** | i: GRanges, character, integer, logical, List, list | `MultiAssayExperiment` |
| **`mae[,j,]`** | j: character, integer, logical, List, list | `MultiAssayExperiment` |
| **`mae[,,k]`** | k: character, integer, logical | `MultiAssayExperiment` |
| **`mae[[i]]`** | Get or set object of arbitrary class from experiments | (Varies) |
| **`mae[[i]]`** | Character, integer, logical |  |
| **`mae$column`** | Get or set colData column | `vector` (varies) |
| **Management** |  |  |
| **`complete.cases`** | Identify subjects with complete data in all experiments | `vector` (logical) |
| **`duplicated`** | Identify subjects with replicate observations per experiment | `list` of `LogicalLists` |
| **`mergeReplicates`** | Merge replicate observations within each experiment | `MultiAssayExperiment` |
| **`intersectRows`** | Return features that are present for all experiments | `MultiAssayExperiment` |
| **`intersectColumns`** | Return subjects with data available for all experiments | `MultiAssayExperiment` |
| **`prepMultiAssay`** | Troubleshoot common problems when constructing main class | `list` |
| **Reshaping** |  |  |
| **`longFormat`** | Return a long and tidy DataFrame with optional colData columns | `DataFrame` |
| **`wideFormat`** | Create a wide DataFrame, one row per subject | `DataFrame` |
| **Combining** |  |  |
| **`c`** | Concatenate an experiment | `MultiAssayExperiment` |
| **Viewing** |  |  |
| **`upsetSamples`** | Generalized Venn Diagram analog for sample membership | `upset` |
| **Exporting** |  |  |
| **`exportClass`** | Exporting to flat files | `csv` or `tsv` files |

### 6.2.3 `ExpressionSet`

The `ExpressionSet` format (`Biobase` package) was designed by the
Bioconductor team as the first format to handle (single) omics data. It
has now been supplanted by the `SummarizedExperiment` format.

An example of `ExpressionSet` creation and a summary of useful methods
are provided below. Please refer to [‘An introduction to Biobase and
ExpressionSets’](https://bioconductor.org/packages/release/bioc/vignettes/Biobase/inst/doc/ExpressionSetIntroduction.pdf)
from the documentation from the
[`Biobase`](https://doi.org/doi%3A10.18129/B9.bioc.Biobase) package for a
full description of `ExpressionSet` objects.

```
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(sacurine)
data.mn <- sacurine$dataMatrix # matrix: samples x variables
samp.df <- sacurine$sampleMetadata # data frame: samples x sample metadata
feat.df <- sacurine$variableMetadata # data frame: features x feature metadata
# Creating the ExpressionSet (package Biobase)
sac.set <- Biobase::ExpressionSet(assayData = t(data.mn))
Biobase::pData(sac.set) <- samp.df
Biobase::fData(sac.set) <- feat.df
stopifnot(validObject(sac.set))
# Viewing the ExpressionSet
# ropls::view(sac.set)
```

| Methods | Description | Returned class |
| --- | --- | --- |
| **`exprs`** | ‘variable times samples’ numeric matrix | `matrix` |
| **`pData`** | sample metadata | `data.frame` |
| **`fData`** | variable metadata | `data.frame` |
| **`sampleNames`** | sample names | `character` |
| **`featureNames`** | variable names | `character` |
| **`dims`** | 2x1 matrix of ‘Features’ and ‘Samples’ dimensions | `matrix` |
| **`varLabels`** | Column names of the sample metadata data frame | `character` |
| **`fvarLabels`** | Column names of the variable metadata data frame | `character` |

### 6.2.4 `MultiDataSet`

Loading the `NCI60_4arrays` from the `omicade4` package:

```
data("NCI60_4arrays", package = "omicade4")
```

Creating the `MultiDataSet`:

```
library(MultiDataSet)
# Creating the MultiDataSet instance
nci.mds <- MultiDataSet::createMultiDataSet()
# Adding the two datasets as ExpressionSet instances
for (set.c in names(NCI60_4arrays)) {
  # Getting the data
  expr.mn <- as.matrix(NCI60_4arrays[[set.c]])
  pdata.df <- data.frame(row.names = colnames(expr.mn),
                        cancer = substr(colnames(expr.mn), 1, 2),
                        stringsAsFactors = FALSE)
  fdata.df <- data.frame(row.names = rownames(expr.mn),
                        name = rownames(expr.mn),
                        stringsAsFactors = FALSE)
  # Building the ExpressionSet
  eset <- Biobase::ExpressionSet(assayData = expr.mn,
                                 phenoData = new("AnnotatedDataFrame",
                                                 data = pdata.df),
                                 featureData = new("AnnotatedDataFrame",
                                                   data = fdata.df),
                                 experimentData = new("MIAME",
                                                      title = set.c))
  # Adding to the MultiDataSet
  nci.mds <- MultiDataSet::add_eset(nci.mds, eset, dataset.type = set.c,
                                     GRanges = NA, warnings = FALSE)
}
stopifnot(validObject(nci.mds))
```

| Methods | Description | Returned class |
| --- | --- | --- |
| **Constructors** |  |  |
| **`createMultiDataSet`** | Create a MultiDataSet object | `MultiDataSet` |
| **`add_eset`** | Create a MultiAssayExperiment object | `MultiDataSet` |
| **Subsetting** |  |  |
| **`mset[i, ]`** | i: character,logical (samples to select) | `MultiDataSet` |
| **`mset[, k]`** | k: character (names of datasets to select) | `MultiDataSet` |
| **`mset[[k]]`** | k: character (name of the datast to select) | `ExpressionSet` |
| **Accessors** |  |  |
| **`as.list`** | Get the list of data matrices | `list` |
| **`pData`** | Get the list of sample metadata | `list` |
| **`fData`** | Get the list of variable metadata | `list` |
| **`sampleNames`** | Get the list of sample names | `list` |
| **Management** |  |  |
| **`commonSamples`** | Select samples that are present in all datasets | `MultiDataSet` |
| **Conversion** |  |  |
| **`mds2mae`** | Convert a MultiDataSet to a MultiAssayExperiment | `MultiAssayExperiment` |

# 7 Session info

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
##  [1] MultiDataSet_1.38.0         MultiAssayExperiment_1.36.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] ropls_1.42.0                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         xfun_0.53            bslib_0.9.0
##  [4] ggplot2_4.0.0        htmlwidgets_1.6.4    lattice_0.22-7
##  [7] crosstalk_1.2.2      vctrs_0.6.5          tools_4.5.1
## [10] tibble_3.3.0         pkgconfig_2.0.3      BiocBaseUtils_1.12.0
## [13] Matrix_1.7-4         data.table_1.17.8    RColorBrewer_1.1-3
## [16] S7_0.2.0             lifecycle_1.0.4      compiler_4.5.1
## [19] farver_2.1.2         statmod_1.5.1        tinytex_0.57
## [22] htmltools_0.5.8.1    sass_0.4.10          lazyeval_0.2.2
## [25] yaml_2.3.10          plotly_4.11.0        tidyr_1.3.1
## [28] pillar_1.11.1        jquerylib_0.1.4      MASS_7.3-65
## [31] DelayedArray_0.36.0  cachem_1.1.0         limma_3.66.0
## [34] magick_2.9.0         abind_1.4-8          tidyselect_1.2.1
## [37] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
## [40] bookdown_0.45        labeling_0.4.3       fastmap_1.2.0
## [43] grid_4.5.1           cli_3.6.5            SparseArray_1.10.0
## [46] magrittr_2.0.4       S4Arrays_1.10.0      dichromat_2.0-0.1
## [49] withr_3.0.2          scales_1.4.0         calibrate_1.7.7
## [52] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [55] evaluate_1.0.5       knitr_1.50           qqman_0.1.9
## [58] viridisLite_0.4.2    rlang_1.1.6          Rcpp_1.1.0
## [61] glue_1.8.0           BiocManager_1.30.26  jsonlite_2.0.0
## [64] R6_2.6.1
```

# References

Baccini, A. 2010. “Statistique Descriptive Multidimensionnelle (Pour Les Nuls).”

Brereton, Richard G., and Gavin R. Lloyd. 2014. “Partial Least Squares Discriminant Analysis: Taking the Magic Away.” *Journal of Chemometrics* 28 (4): 213–25. <http://dx.doi.org/10.1002/cem.2609>.

Bylesjo, M, M Rantalainen, O Cloarec, J Nicholson, E Holmes, and J Trygg. 2006. “OPLS Discriminant Analysis: Combining the Strengths of PLS-DA and SIMCA Classification.” *Journal of Chemometrics* 20: 341–51. <http://dx.doi.org/10.1002/cem.1006>.

Bylesjo, M., M. Rantalainen, J. Nicholson, E. Holmes, and J. Trygg. 2008. “K-OPLS Package: Kernel-Based Orthogonal Projections to Latent Structures for Prediction and Interpretation in Feature Space.” *BMC Bioinformatics* 9 (1): 106. <http://dx.doi.org/10.1186/1471-2105-9-106>.

Eriksson, L., E. Johansson, N. Kettaneh-Wold, and S. Wold. 2001. *Multi- and Megavariate Data Analysis. Principles and Applications*. Umetrics Academy.

Galindo-Prieto, B., L. Eriksson, and J. Trygg. 2014. “Variable Influence on Projection (VIP) for Orthogonal Projections to Latent Structures (OPLS).” *Journal of Chemometrics* 28 (8): 623–32. <http://dx.doi.org/10.1002/cem.2627>.

Gaude, R., F. Chignola, D. Spiliotopoulos, A. Spitaleri, M. Ghitti, JM. Garcia-Manteiga, S. Mari, and G. Musco. 2013. “Muma, an R Package for Metabolomics Univariate and Multivariate Statistical Analysis.” *Current Metabolomics* 1: 180–89. <http://dx.doi.org/10.2174/2213235X11301020005>.

Hubert, M., PJ. Rousseeuw, and K. Vanden Branden. 2005. “ROBPCA: A New Approach to Robust Principal Component Analysis.” *Technometrics* 47: 64–79. <http://dx.doi.org/10.1198/004017004000000563>.

Mehmood, T., KH. Liland, L. Snipen, and S. Saebo. 2012. “A Review of Variable Selection Methods in Partial Least Squares Regression.” *Chemometrics and Intelligent Laboratory Systems* 118 (0): 62–69. <http://dx.doi.org/10.1016/j.chemolab.2012.07.010>.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2022. *SummarizedExperiment: SummarizedExperiment Container*. <https://bioconductor.org/packages/SummarizedExperiment>.

Pinto, RC., J. Trygg, and J. Gottfries. 2012. “Advantages of Orthogonal Inspection in Chemometrics.” *Journal of Chemometrics* 26 (6): 231–35. <http://dx.doi.org/10.1002/cem.2441>.

Ramos, Marcel, Lucas Schiffer, Angela Re, Rimsha Azhar, Azfar Basunia, Carmen Rodriguez, Tiffany Chan, et al. 2017. “Software for the Integration of Multiomics Experiments in Bioconductor.” *Cancer Research* 77 (21): e39–e42. <https://doi.org/10.1158/0008-5472.CAN-17-0344>.

R Development Core Team. 2008. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <http://www.R-project.org>.

Szymanska, E., E. Saccenti, AK. Smilde, and JA. Westerhuis. 2012. “Double-Check: Validation of Diagnostic Statistics for PLS-DA Models in Metabolomics Studies.” *Metabolomics* 8 (1, 1): 3–16. <http://dx.doi.org/10.1007/s11306-011-0330-3>.

Tenenhaus, M. 1998. *La Regression PLS : Theorie et Pratique*. Editions Technip.

Thevenot, EA., A. Roux, X. Ying, E. Ezan, and C. Junot. 2015. “Analysis of the Human Adult Urinary Metabolome Variations with Age, Body Mass Index and Gender by Implementing a Comprehensive Workflow for Univariate and OPLS Statistical Analyses.” *Journal of Proteome Research* 14 (8): 3322–35. <http://dx.doi.org/10.1021/acs.jproteome.5b00354>.

Trygg, J., and S. Wold. 2002. “Orthogonal Projection to Latent Structures (O-PLS).” *Journal of Chemometrics* 16: 119–28. <http://dx.doi.org/10.1002/cem.695>.

Wehrens, R. 2011. *Chemometrics with R: Multivariate Data Analysis in the Natural Sciences and Life Sciences*. Springer.

Wold, S., M. Sjostrom, and L. Eriksson. 2001. “PLS-Regression: A Basic Tool of Chemometrics.” *Chemometrics and Intelligent Laboratory Systems* 58: 109–30. [http://dx.doi.org/10.1016/S0169-7439(01)00155-1](http://dx.doi.org/10.1016/S0169-7439%2801%2900155-1).