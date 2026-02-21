# Vignette illustrating the use of MOFA on the CLL data

Britta Velten and Ricard Argelaguet

#### 2 May 2019

#### Package

MOFA 1.0.0

# Contents

* [1 Step 1: Load data and create MOFA object](#step-1-load-data-and-create-mofa-object)
  + [1.1 Option 1: base R approach](#option-1-base-r-approach)
  + [1.2 Option 2: Bioconductor approach](#option-2-bioconductor-approach)
  + [1.3 Overview of training data](#overview-of-training-data)
* [2 Step 2: Fit the MOFA model](#step-2-fit-the-mofa-model)
  + [2.1 Define options](#define-options)
    - [2.1.1 Define data options](#define-data-options)
    - [2.1.2 Define model options](#define-model-options)
    - [2.1.3 Define training options](#define-training-options)
  + [2.2 Prepare MOFA](#prepare-mofa)
  + [2.3 Run MOFA](#run-mofa)
* [3 Step 3: Analyse a trained MOFA model](#step-3-analyse-a-trained-mofa-model)
  + [3.1 Part 1: Disentangling the heterogeneity: calculation of variance explained by each factor in each view](#part-1-disentangling-the-heterogeneity-calculation-of-variance-explained-by-each-factor-in-each-view)
  + [3.2 Part 2: Characterisation of individual factors](#part-2-characterisation-of-individual-factors)
    - [3.2.1 Inspection of top weighted features in the active views](#inspection-of-top-weighted-features-in-the-active-views)
    - [3.2.2 Feature set enrichment analysis in the active views](#feature-set-enrichment-analysis-in-the-active-views)
  + [3.3 Ordination of samples by factors to reveal clusters and gradients in the sample space](#ordination-of-samples-by-factors-to-reveal-clusters-and-gradients-in-the-sample-space)
  + [3.4 Customized analysis](#customized-analysis)
* [4 Further functionalities](#further-functionalities)
  + [4.1 Prediction of views](#prediction-of-views)
  + [4.2 Imputation of missing observations](#imputation-of-missing-observations)
  + [4.3 Clustering of samples based on latent factors](#clustering-of-samples-based-on-latent-factors)
* [5 SessionInfo](#sessioninfo)

This vignette show how to use MOFA including initialization, training and down-stream analyses.
For illustration we use the CLL data which is used in the MOFA publication.

```
library(MultiAssayExperiment)
library(MOFA)
library(MOFAdata)
```

# 1 Step 1: Load data and create MOFA object

There are two options to input data to MOFA:

* Option 1: base R approach using a list of matrices
* Option 2: Bioconductor approach using the MultiAssayExperiment framework

## 1.1 Option 1: base R approach

If using the base R approach, you simply need to provide a list of matrices where features are rows and samples are columns. Importantly, the samples need to be aligned. Missing values/assays should be filled with NAs.

```
data("CLL_data")
MOFAobject <- createMOFAobject(CLL_data)
```

```
## Creating MOFA object from list of matrices,
##  please make sure that samples are columns and features are rows...
```

```
MOFAobject
```

```
## Untrained MOFA model with the following characteristics:
##   Number of views: 4
##   View names: Drugs Methylation mRNA Mutations
##   Number of features per view: 310 4248 5000 69
##   Number of samples: 200
```

## 1.2 Option 2: Bioconductor approach

If using the Bioconductor approach, you need to provide or create a [MultiAssayExperiment](https://bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html) object and then use it to build the MOFA object. For example, starting from a list of matrices where features are rows and samples are columns, this can be easily constructed as follows:

```
# Load data
# import list with mRNA, Methylation, Drug Response and Mutation data.
data("CLL_data")

# check dimensionalities, samples are columns, features are rows
lapply(CLL_data, dim)
```

```
## $Drugs
## [1] 310 200
##
## $Methylation
## [1] 4248  200
##
## $mRNA
## [1] 5000  200
##
## $Mutations
## [1]  69 200
```

```
# Load sample metadata: Sex and Diagnosis
data("CLL_covariates")
head(CLL_covariates)
```

```
##      Gender Diagnosis
## H045      m       CLL
## H109      m       CLL
## H024      m       CLL
## H056      m       CLL
## H079      m       CLL
## H164      f       CLL
```

```
# Create MultiAssayExperiment object
mae_CLL <- MultiAssayExperiment(
  experiments = CLL_data,
  colData = CLL_covariates
)

# Build the MOFA object
MOFAobject <- createMOFAobject(mae_CLL)
MOFAobject
```

```
## Untrained MOFA model with the following characteristics:
##   Number of views: 4
##   View names: Drugs Methylation mRNA Mutations
##   Number of features per view: 310 4248 5000 69
##   Number of samples: 200
```

## 1.3 Overview of training data

The function `plotDataOverview` can be used to obtain an overview of the data stored in the object for training. For each sample it shows in which views data are available. The rows are the different views and columns are samples. Missing values are indicated by a grey bar.

```
plotDataOverview(MOFAobject)
```

![](data:image/png;base64...)

# 2 Step 2: Fit the MOFA model

The next step is to fit the model.
This part of the pipeline is implemented in Python, so first of all make sure you have the corresponding package installed (see installation instructions and read the FAQ if you have problems).

## 2.1 Define options

### 2.1.1 Define data options

The most important options the user needs to define are:

* **scaleViews**: logical indicating whether to scale views to have unit variance. As long as the scale of the different data sets is not too high, this is not required. Default is `FALSE`.
* **removeIncompleteSamples**: logical indicating whether to remove samples that are not profiled in all omics. The model can cope with missing assays, so this option is not required. Default is `FALSE`.

```
DataOptions <- getDefaultDataOptions()
DataOptions
```

```
## $scaleViews
## [1] FALSE
##
## $removeIncompleteSamples
## [1] FALSE
```

### 2.1.2 Define model options

Next, we define model options. The most important are:

* **numFactors**: number of factors (default is 0.5 times the number of samples). By default, the model will only remove a factor if it explains exactly zero variance in the data. You can increase this threshold on minimum variance explained by setting `TrainOptions$dropFactorThreshold` to a value higher than zero.
* **likelihoods**: likelihood for each view. Usually we recommend gaussian for continuous data, bernoulli for binary data and poisson for count data. By default, the model tries to guess it from the data.
* **sparsity**: do you want to use sparsity? This makes the interpretation easier so it is recommended (Default is `TRUE`).

```
ModelOptions <- getDefaultModelOptions(MOFAobject)
ModelOptions$numFactors <- 25
ModelOptions
```

```
## $likelihood
##       Drugs Methylation        mRNA   Mutations
##  "gaussian"  "gaussian"  "gaussian" "bernoulli"
##
## $numFactors
## [1] 25
##
## $sparsity
## [1] TRUE
```

### 2.1.3 Define training options

Next, we define training options. The most important are:

* **maxiter**: maximum number of iterations. Ideally set it large enough and use the convergence criterion `TrainOptions$tolerance`.
* **tolerance**: convergence threshold based on change in the evidence lower bound. For an exploratory run you can use a value between 1.0 and 0.1, but for a “final” model we recommend a value of 0.01.
* **DropFactorThreshold**: hyperparameter to automatically learn the number of factors based on a minimum variance explained criteria. Factors explaining less than `DropFactorThreshold` fraction of variation in all views will be removed. For example, a value of 0.01 means that factors that explain less than 1% of variance in all views will be discarded. By default this it zero, meaning that all factors are kept unless they explain no variance at all.

```
TrainOptions <- getDefaultTrainOptions()

# Automatically drop factors that explain less than 2% of variance in all omics
TrainOptions$DropFactorThreshold <- 0.02

TrainOptions$seed <- 2017

TrainOptions
```

```
## $maxiter
## [1] 5000
##
## $tolerance
## [1] 0.1
##
## $DropFactorThreshold
## [1] 0.02
##
## $verbose
## [1] FALSE
##
## $seed
## [1] 2017
```

## 2.2 Prepare MOFA

`prepareMOFA` internally performs a set of sanity checks and fills the `DataOptions`, `TrainOptions` and `ModelOptions` slots of the `MOFAobject`

```
MOFAobject <- prepareMOFA(
  MOFAobject,
  DataOptions = DataOptions,
  ModelOptions = ModelOptions,
  TrainOptions = TrainOptions
)
```

```
## Checking data options...
```

```
## Checking training options...
```

```
## Checking model options...
```

Optionally, we can choose to regress out some (technical) covariates before training, using a simple linear model. For example, here we can choose to remove the effect of sex. Ideally, all undesired sources of variation should be removed a priori from the model. The reason ebing that, if strong technical factors exist, the model will “focus” on capturing the variability driven by the technical factors, and small sources of biological variability could be missed.
(Note: uncomment and running the function below will lead to a slight modification of the results)

```
# MOFAobject <- regressCovariates(
#   object = MOFAobject,
#   views = c("Drugs","Methylation","mRNA"),
#   covariates = MOFAobject@InputData$Gender
# )
```

## 2.3 Run MOFA

Now we are ready to train the `MOFAobject`, which is done with the function `runMOFA`. This step can take some time (around 15 min with default parameters). For illustration we provide an existing trained `MOFAobject`.
IMPORTANT NOTE: The software has evolved since the original publication and the results are not 100% reproducible with the last versions. Yet, the output should be very similar (if not improved) to the pre-existent model.

```
MOFAobject <- runMOFA(MOFAobject)
```

```
# Loading an existing trained model
filepath <- system.file("extdata", "CLL_model.hdf5", package = "MOFAdata")

MOFAobject <- loadModel(filepath, MOFAobject)
```

```
## [1] "Could not load the feature intercepts. Your features will be centered to zero mean"
```

```
MOFAobject
```

```
## Trained MOFA model with the following characteristics:
##   Number of views: 4
##  View names: Drugs Methylation Mutations mRNA
##   Number of features per view: 310 4248 69 5000
##   Number of samples: 200
##   Number of factors: 10
```

# 3 Step 3: Analyse a trained MOFA model

After training, we can explore the results from MOFA. Here we provide a semi-automated pipeline to disentangle and characterize all the identified sources of variation (the factors).

**Part 1: Disentangling the heterogeneity**

Calculation of variance explained by each factor in each view. This is probably the most important plot that MOFA generates, as it summarises the entire heterogeneity of the dataset in a single figure. Here we can see in which view a factor explains variation which can guide further characterisation of the factors by investigating the weights in those views.

**Part 2: Characterization of individual factors**

* Inspection of top features with highest loadings: the loading is a measure of feature importance, so features with high loading are the ones driving the heterogeneity captured by the factor.
* Feature set enrichment analysis (where set annotations are present, e.g. gene sets for mRNA views).
* Ordination of samples by factors to reveal clusters and/or gradients: this is similar to what is traditionally done with Principal Component Analysis or t-SNE.

Other analyses, including imputation of missing values and clustering of samples are also available. See below for a short illustration of these functionalities. In addition, the factors can be used in further analyses, for example as predictors, e.g. for predicting clinical outcome or classifying patients, or to control for unwanted sources of variation. Vignettes illustrating this are coming soon.

## 3.1 Part 1: Disentangling the heterogeneity: calculation of variance explained by each factor in each view

This is done by `calculateVarianceExplained` (to get the numerical values) and `plotVarianceExplained` (to get the plot). The resulting figure gives an overview of which factors are active in which view(s). If a factor is active in more than one view, this means that is capturing shared signal (co-variation) between features of different data modalities.
Here, for example Factor 1 is active in all data modalities, while Factor 4 is specific to mRNA.

```
# Calculate the variance explained (R2) per factor in each view
r2 <- calculateVarianceExplained(MOFAobject)
r2$R2Total
```

```
##       Drugs Methylation   Mutations        mRNA
##   0.4090497   0.2341916   0.2415335   0.3822602
```

```
# Variance explained by each factor in each view
head(r2$R2PerFactor)
```

```
##            Drugs  Methylation    Mutations       mRNA
## LF1 0.1507029688 1.732398e-01 1.537989e-01 0.07519230
## LF2 0.0350660758 5.844575e-03 8.195112e-02 0.04699171
## LF3 0.1123216630 3.789900e-05 2.242679e-05 0.01488067
## LF4 0.0001812843 1.925074e-04 1.934564e-07 0.09061719
## LF5 0.0605883335 1.837185e-05 3.587202e-06 0.02860510
## LF6 0.0340251701 1.181410e-05 3.004497e-06 0.04850234
```

```
# Plot it
plotVarianceExplained(MOFAobject)
```

![](data:image/png;base64...)

## 3.2 Part 2: Characterisation of individual factors

### 3.2.1 Inspection of top weighted features in the active views

To get an overview of the weights across all factors in a given view you can use the `plotWeightsHeatmap` function.
For example, here we plot all weights from all factors in the Mutations data:

```
plotWeightsHeatmap(
  MOFAobject,
  view = "Mutations",
  factors = 1:5,
  show_colnames = FALSE
)
```

![](data:image/png;base64...)
We observe that Factors 1 and 2 have large non-zero weights. To explore a given factor in more detail we can plot all weights for a single factor using the `plotWeights` function.
For example, here we plot all weights from Factor 1 in the Mutation data. With `nfeatures` we can set how many features should be labelled (`manual` let’s you specify feautres manually to be labelled in the plot.)

```
plotWeights(
  MOFAobject,
  view = "Mutations",
  factor = 1,
  nfeatures = 5
)
```

![](data:image/png;base64...)

```
plotWeights(
  MOFAobject,
  view = "Mutations",
  factor = 1,
  nfeatures = 5,
  manual = list(c("BRAF"),c("MED12")),
  color_manual = c("red","blue")

)
```

![](data:image/png;base64...)
Features with large (absolute) weight on a given factor follow the pattern of covariation associated with the factor. In our case, this reveals a strong link to the IGHV status, hence recovering an important clinical marker in CLL (see our paper for details on the biological interpretation.) Note that the sign of the weight can only be interpreted relative to the signs of other weights and the factor values.

If you are only interested in looking at only the top features you can use the `plotTopWeights` function.
For example, here we plot the mutations with largest loadings on Factor 1. The sign on the right indicates the direction of the loading (positive/negative).

```
plotTopWeights(
  MOFAobject,
  view="Mutations",
  factor=1
)
```

![](data:image/png;base64...)
Again, features with large weight in a given factor means that they follow the pattern of covariation associated with the factor. For example, here the factor is associated with the B-cell of tumour’s origin, consistent with a large weight on the IGHV status (see our manuscript for more details).

From the previous plots, we can clearly see that Factor 1 is associated to IGHV status. As the variance decomposition above told us that this factor is also relevant on all the other data modalities we can investigate its weights on other modalities, e.g. mRNA, to make connections of the IGHV-linked axes of variation to other molecular layers.

```
plotTopWeights(
  MOFAobject,
  view = "mRNA",
  factor = 1
)
```

![](data:image/png;base64...)

Finally, instead of looking at an “abstract” weight, it is useful to observe the coordinated heterogeneity of the top features in the original data. This can be done using the `plotDataHeatmap` function. In this plot samples (in rows) are ordered according to their value on the factor (here Factor 1). Here, this shows clear patterns of the samples’ gene expression in the 20 top weighted genes along the factor.

```
plotDataHeatmap(
  MOFAobject,
  view = "mRNA",
  factor = 1,
  features = 20,
  show_rownames = FALSE
)
```

![](data:image/png;base64...)

### 3.2.2 Feature set enrichment analysis in the active views

Sometimes looking at the loadings of single features can be challenging, and often the combination of signal from functionally related sets of features (i.e. gene ontologies) is required.

Here we implemented a function for feature set enrichment analysis method (`runEnrichmentAnalysis`) derived from the [PCGSE package](https://cran.r-project.org/web/packages/PCGSE/index.html).

The input of this function is a MOFA trained model (MOFAmodel), the factors for which to perform feature set enrichment (a character vector), the feature sets (a binary matrix) and a set of options regarding how the analysis should be performed, see also documentation of `runEnrichmentAnalysis`

We illustrate the use of this function using the [reactome](http://reactome.org) annotations, which are contained in the package. Depending on your data other gene or feature sets might be useful and you can prepare your customized feature sets and specify it using the `feature.sets` argument of the function.

```
# Load reactome annotations
data("reactomeGS") # binary matrix with feature sets in rows and features in columns

# perform enrichment analysis
gsea <- runEnrichmentAnalysis(
  MOFAobject,
  view = "mRNA",
  feature.sets = reactomeGS,
  alpha = 0.01
)
```

```
## Doing Feature Set Enrichment Analysis with the following options...
```

```
## View: mRNA
```

```
## Factors: LF1 LF2 LF3 LF4 LF5 LF6 LF7 LF8 LF9 LF10
```

```
## Number of feature sets: 501
```

```
## Local statistic: loading
```

```
## Transformation: abs.value
```

```
## Global statistic: mean.diff
```

```
## Statistical test: parametric
```

The next step is to visualise the results of the Gene Set Enrichment Analysis. There are several ways:

1. Plot the number of enriched gene sets per factor

```
plotEnrichmentBars(gsea, alpha=0.01)
```

![](data:image/png;base64...)
From this we find enriched at a FDR of 1% gene sets on Factors 3-6 and 8. To look into which gene sets these are we can choose a factor of interest and visualize the most enriched gene sets as follows:

2. Plot the top enriched pathways for every factor

```
interestingFactors <- 4:5

fseaplots <- lapply(interestingFactors, function(factor) {
  plotEnrichment(
    MOFAobject,
    gsea,
    factor = factor,
    alpha = 0.01,
    max.pathways = 10 # The top number of pathways to display
  )
})

cowplot::plot_grid(fseaplots[[1]], fseaplots[[2]],
                   ncol = 1, labels = paste("Factor", interestingFactors))
```

![](data:image/png;base64...)
This shows us that Factor 4 is capturing variation related to immune response (possibly due to T-cell contamination of the samples) and Factor 5 is related to differences in stress response, as discussed in our paper.

## 3.3 Ordination of samples by factors to reveal clusters and gradients in the sample space

Samples can be visualized along factors of interest using the `plotFactorScatter` function. We can use features included in the model (such as IGHV or trisomy12) to color or shape the samples by. Alternatively, external covariates can also be used for this purpose.

```
plotFactorScatter(
  MOFAobject,
  factors = 1:2,
  color_by = "IGHV",      # color by the IGHV values that are part of the training data
  shape_by = "trisomy12"  # shape by the trisomy12 values that are part of the training data
)
```

![](data:image/png;base64...)
Here we find again a clear separation of samples based on their IGHV status (color) along Factor 1 and by the absence or prescence of trisomy 12 (shape) along Factor 2 as indicated by the corresponding factor weights in the Mutations view.

An overview of pair-wise sctterplots for all or a subset of factors is produced by the `plotFactorScatters` function

```
plotFactorScatters(
  MOFAobject,
  factors = 1:3,
  color_by = "IGHV"
)
```

```
## Registered S3 method overwritten by 'GGally':
##   method from
##   +.gg   ggplot2
```

![](data:image/png;base64...)

A single factor can be visualised using the `plotFactorBeeswarm` function

```
plotFactorBeeswarm(
  MOFAobject,
  factors = 1,
  color_by = "IGHV"
)
```

![](data:image/png;base64...)

## 3.4 Customized analysis

For customized exploration of weights and factors, you can directly fetch the variables from the model using ‘get’ functions: `getWeights`, `getFactors` and `getTrainData`:

```
MOFAweights <- getWeights(
  MOFAobject,
  views = "all",
  factors = "all",
  as.data.frame = TRUE    # if TRUE, it outputs a long dataframe format. If FALSE, it outputs a wide matrix format
)
head(MOFAweights)
```

```
##   feature factor         value  view
## 1 D_001_1    LF1  0.0002667769 Drugs
## 2 D_001_2    LF1  0.0019258319 Drugs
## 3 D_001_3    LF1  0.0356598749 Drugs
## 4 D_001_4    LF1  0.0292638984 Drugs
## 5 D_001_5    LF1  0.0158091594 Drugs
## 6 D_002_1    LF1 -0.0161823261 Drugs
```

```
MOFAfactors <- getFactors(
  MOFAobject,
  factors = c(1,2),
  as.data.frame = FALSE   # if TRUE, it outputs a long dataframe format. If FALSE, it outputs a wide matrix format
)
head(MOFAfactors)
```

```
##            LF1         LF2
## H045  1.277135  0.07556906
## H109  1.292226 -1.93887825
## H024 -1.438207  0.72267340
## H056 -1.102120  0.65452538
## H079  1.037262  0.51368436
## H164  1.563211  0.92332140
```

```
MOFAtrainData <- getTrainData(
  MOFAobject,
  as.data.frame = TRUE,
  views = "Mutations"
)
head(MOFAtrainData)
```

```
##        view    feature sample value
## 1 Mutations gain2p25.3   H045     0
## 2 Mutations   gain3q26   H045     0
## 3 Mutations  del6p21.2   H045     0
## 4 Mutations    del6q21   H045     0
## 5 Mutations    del8p12   H045     0
## 6 Mutations   gain8q24   H045     1
```

# 4 Further functionalities

## 4.1 Prediction of views

With the `predict` function, full views can be predicted based on the MOFA model with all or a subset of factors.

```
predictedDrugs <- predict(
  MOFAobject,
  view = "Drugs",
  factors = "all"
)[[1]]

# training data (incl. missing values)
drugData4Training <- getTrainData(MOFAobject, view="Drugs")[[1]]
pheatmap::pheatmap(drugData4Training[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)

```
# predicted data
pheatmap::pheatmap(predictedDrugs[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)

## 4.2 Imputation of missing observations

With the `impute` function all missing values are imputed based on the MOFA model. The imputed data is then stored in the `ImputedData slot` of the MOFAobject and can be accessed via the `getImputedData` function.

```
MOFAobject <- impute(MOFAobject)
imputedDrugs <- getImputedData(MOFAobject, view="Drugs")[[1]]

# training data (incl. missing values)
pheatmap::pheatmap(drugData4Training[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)

```
# imputed data
pheatmap::pheatmap(imputedDrugs[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)

## 4.3 Clustering of samples based on latent factors

Samples can be clustered according to their values on some or all latent factors using the `clusterSamples` function. Clusters can for example be visualised using the `plotFactorScatters` function

```
set.seed(1234)
clusters <- clusterSamples(
  MOFAobject,
  k = 2,        # Number of clusters for the k-means function
  factors = 1   # factors to use for the clustering
)

plotFactorScatter(
  MOFAobject,
  factors = 1:2,
  color_by = clusters
)
```

![](data:image/png;base64...)

# 5 SessionInfo

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] MOFAdata_0.99.6             MOFA_1.0.0
##  [3] MultiAssayExperiment_1.10.0 SummarizedExperiment_1.14.0
##  [5] DelayedArray_0.10.0         BiocParallel_1.18.0
##  [7] matrixStats_0.54.0          Biobase_2.44.0
##  [9] GenomicRanges_1.36.0        GenomeInfoDb_1.20.0
## [11] IRanges_2.18.0              S4Vectors_0.22.0
## [13] BiocGenerics_0.30.0         BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##  [1] ggrepel_0.8.0          Rcpp_1.0.1             lattice_0.20-38
##  [4] assertthat_0.2.1       digest_0.6.18          foreach_1.4.4
##  [7] R6_2.4.0               plyr_1.8.4             evaluate_0.13
## [10] ggplot2_3.1.1          pillar_1.3.1           zlibbioc_1.30.0
## [13] rlang_0.3.4            lazyeval_0.2.2         Matrix_1.2-17
## [16] reticulate_1.12        rmarkdown_1.12         labeling_0.3
## [19] stringr_1.4.0          pheatmap_1.0.12        RCurl_1.95-4.12
## [22] munsell_0.5.0          compiler_3.6.0         vipor_0.4.5
## [25] xfun_0.6               pkgconfig_2.0.2        ggbeeswarm_0.6.0
## [28] htmltools_0.3.6        tidyselect_0.2.5       tibble_2.1.1
## [31] GenomeInfoDbData_1.2.1 bookdown_0.9           codetools_0.2-16
## [34] reshape_0.8.8          crayon_1.3.4           dplyr_0.8.0.1
## [37] bitops_1.0-6           grid_3.6.0             GGally_1.4.0
## [40] jsonlite_1.6           gtable_0.3.0           magrittr_1.5
## [43] scales_1.0.0           stringi_1.4.3          XVector_0.24.0
## [46] reshape2_1.4.3         doParallel_1.0.14      cowplot_0.9.4
## [49] Rhdf5lib_1.6.0         RColorBrewer_1.1-2     iterators_1.0.10
## [52] tools_3.6.0            glue_1.3.1             beeswarm_0.2.3
## [55] purrr_0.3.2            yaml_2.2.0             rhdf5_2.28.0
## [58] colorspace_1.4-1       BiocManager_1.30.4     corrplot_0.84
## [61] knitr_1.22
```