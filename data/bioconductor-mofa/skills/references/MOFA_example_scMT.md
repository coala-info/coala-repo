# Vignette illustrating the use of MOFA on single-cell multi-omics data

Ricard Argelaguet and Britta Velten

#### 2 May 2019

#### Package

MOFA 1.0.0

# Contents

* [1 Load data and create MOFA object](#load-data-and-create-mofa-object)
* [2 Fit the MOFA model](#fit-the-mofa-model)
  + [2.1 Define options](#define-options)
    - [2.1.1 Define data options](#define-data-options)
    - [2.1.2 Define model options](#define-model-options)
    - [2.1.3 Define training options](#define-training-options)
  + [2.2 Prepare MOFA](#prepare-mofa)
  + [2.3 Run MOFA](#run-mofa)
* [3 Analyse a trained MOFA model](#analyse-a-trained-mofa-model)
  + [3.1 Disentangling the heterogeneity, calculation of variance explained by each factor in each view](#disentangling-the-heterogeneity-calculation-of-variance-explained-by-each-factor-in-each-view)
  + [3.2 Characterisation of individual factors](#characterisation-of-individual-factors)
    - [3.2.1 Inspection of loadings for Factor 1](#inspection-of-loadings-for-factor-1)
    - [3.2.2 Inspection of loadings for Factor 2](#inspection-of-loadings-for-factor-2)
  + [3.3 Ordination of samples by factors](#ordination-of-samples-by-factors)
  + [3.4 Customized analysis](#customized-analysis)
* [4 Further functionalities](#further-functionalities)
  + [4.1 Imputation of missing observations](#imputation-of-missing-observations)
  + [4.2 Clustering of samples based on latent factors](#clustering-of-samples-based-on-latent-factors)
* [5 SessionInfo](#sessioninfo)

This vignette shows how MOFA can be used to disentangle the heterogeneity in single-cell DNA methylation and RNA expression (scMT) data.

Briefly, the data set consists of 87 mouse embryonic stem cells (mESCs), comprising of 16 cells cultured in ‘2i’ media, which induces a naive pluripotency state, and 71 serum-grown cells, which commits cells to a primed pluripotency state poised for cellular differentiation (Angermueller, 2016).

# 1 Load data and create MOFA object

The data is stored as a `MultiAssayExperiment` object.
Notice that there are 4 views, one with normalized RNA expression assay and 3 views with DNA methylation information. Each DNA methylation view is a different genomic context (i.e. Enhancers, Promoters and CpG Islands) and each feature is an individual CpG site.

```
library(MultiAssayExperiment)
library(MOFA)
library(MOFAdata)
library(ggplot2)
```

```
data("scMT_data")
scMT_data
```

```
## A MultiAssayExperiment object of 4 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 4:
##  [1] RNA expression: ExpressionSet with 5000 rows and 81 columns
##  [2] Met Enhancers: ExpressionSet with 5000 rows and 83 columns
##  [3] Met CpG Islands: ExpressionSet with 5000 rows and 83 columns
##  [4] Met Promoters: ExpressionSet with 5000 rows and 83 columns
## Features:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample availability DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
```

First, we create the MOFA object:

```
MOFAobject <- createMOFAobject(scMT_data)
```

```
## Creating MOFA object from a MultiAssayExperiment object...
```

```
MOFAobject
```

```
## Untrained MOFA model with the following characteristics:
##   Number of views: 4
##   View names: RNA expression Met Enhancers Met CpG Islands Met Promoters
##   Number of features per view: 5000 5000 5000 5000
##   Number of samples: 87
```

The function `plotDataOverview` can be used to obtain an overview of the structure of the data:

```
plotDataOverview(MOFAobject, colors=c("#31A354","#377EB8","#377EB8","#377EB8"))
```

![](data:image/png;base64...)

# 2 Fit the MOFA model

The next step is to train the model. Internally, this is done via Python, so make sure you have the corresponding package installed (see installation instructions and read the FAQ if you have problems).

## 2.1 Define options

### 2.1.1 Define data options

Next, we define data options. The most important are:

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
ModelOptions
```

```
## $likelihood
##  RNA expression   Met Enhancers Met CpG Islands   Met Promoters
##      "gaussian"     "bernoulli"     "bernoulli"     "bernoulli"
##
## $numFactors
## [1] 44
##
## $sparsity
## [1] TRUE
```

### 2.1.3 Define training options

Next, we define training options. The most important are:

* **maxiter**: maximum number of iterations. Ideally set it large enough and use the convergence criteria `TrainOptions$tolerance`.
* **tolerance**: convergence threshold based on change in the evidence lower bound. For an exploratory run you can use a value between 1.0 and 0.1, but for a “final” model we recommend a value of 0.01.
* **DropFactorThreshold**: hyperparameter to automatically learn the number of factors based on a minimum variance explained criteria. Factors explaining less than ‘DropFactorThreshold’ fraction of variation in all views will be removed. For example, a value of 0.01 means that factors that explain less than 1% of variance in all views will be discarded. By default this it zero, meaning that all factors are kept unless they explain no variance at all. Here we use a threshold of 1%.

```
TrainOptions <- getDefaultTrainOptions()
TrainOptions$seed <- 2018

# Automatically drop factors that explain less than 1% of variance in all omics
TrainOptions$DropFactorThreshold <- 0.01

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
## [1] 0.01
##
## $verbose
## [1] FALSE
##
## $seed
## [1] 2018
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

## 2.3 Run MOFA

Now we are ready to train the `MOFAobject`, which is done with the function `runMOFA`. This step can take some time (around 5 min with default parameters for a single trial). For illustration we provide an existing trained `MOFAobject`

```
MOFAobject <- runMOFA(MOFAobject)
```

```
filepath <- system.file("extdata", "scMT_model.hdf5", package = "MOFAdata")
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
##  View names: Met CpG Islands Met Enhancers Met Promoters RNA expression
##   Number of features per view: 5000 5000 5000 5000
##   Number of samples: 87
##   Number of factors: 3
```

# 3 Analyse a trained MOFA model

After training, we can explore the results from MOFA. Here we provide a semi-automated pipeline to disentangle and characterize all the identified sources of variation (the factors).

**Part 1: Disentangling the heterogeneity**

Calculation of variance explained by each factor in each view. This is probably the most important plot that MOFA generates, as it summarises the entire heterogeneity of the dataset in a single figure.

**Part 2: Characterization of individual factors**

* Inspection of top features with highest loadings: the loading is a measure of feature importance, so features with high loading are the ones driving the heterogeneity captured by the factor.
* Feature set enrichment analysis (where set annotations are present, e.g. gene sets for mRNA views).
* Ordination of samples by factors to reveal clusters and/or gradients: this is similar to what is traditionally done with Principal Component Analysis or t-SNE.

Other analyses, including imputation of missing values and prediction of clinical data are also available. See below for a short guide on how to impute data. Detailed vignettes will follow soon.

## 3.1 Disentangling the heterogeneity, calculation of variance explained by each factor in each view

This is done by `calculateVarianceExplained` (to get the numerical values) and `plotVarianceExplained` (to get the plot).
The resulting figure gives an overview of which factors are active in which view(s). If a factor is active in more than one view, this means that is capturing shared signal (co-variation) between features of different data modalities.

In this data set MOFA identified 3 Factors with a minimum variance of 1%. While *Factor 1* is shared across all data modalities (12% variance explained in the RNA data and between 53% and 72% in the methylation data sets), Factors 2 and 3 are active primarily in the RNA data

```
# Calculate the variance explained (R2) per factor in each view
r2 <- calculateVarianceExplained(MOFAobject)
r2$R2Total
```

```
## Met CpG Islands   Met Enhancers   Met Promoters  RNA expression
##       0.5685838       0.7284391       0.5277814       0.1231761
```

```
# Variance explained by each factor in each view
head(r2$R2PerFactor)
```

```
##     Met CpG Islands Met Enhancers Met Promoters RNA expression
## LF1    5.683954e-01  7.282991e-01  0.5272673784     0.06255281
## LF2    1.178354e-04  8.761564e-05  0.0003002201     0.03548858
## LF3    9.120354e-05  9.245025e-05  0.0002861076     0.03239565
```

```
# Plot it
plotVarianceExplained(MOFAobject)
```

![](data:image/png;base64...)

## 3.2 Characterisation of individual factors

### 3.2.1 Inspection of loadings for Factor 1

Plotting the RNA expression gene loadings for *Factor 1*, we can see that it is enriched for naive pluripotency marker genes such as Rex1/Zpf42, Tbx3, Fbxo15 and Essrb. Hence, based on previous studies (Mohammed et al, 2016) we can hypothesise that *Factor 1* captures a transition from a naive pluripotent state to a primed pluripotent states.

```
# Plot all weights and highlight specific gene markers
plotWeights(
  object = MOFAobject,
  view = "RNA expression",
  factor = 1,
  nfeatures = 0,
  abs = FALSE,
  manual = list(c("Zfp42","Esrrb","Morc1","Fbxo15",
                  "Jam2","Klf4","Tcl1","Tbx3","Tex19.1"))
)
```

![](data:image/png;base64...)

```
# Plot top 10 genes
plotTopWeights(
  object = MOFAobject,
  view = "RNA expression",
  factor = 1,
  nfeatures = 10
)
```

![](data:image/png;base64...)

Also, instead of looking at the “abstract” weights, it is useful to observe, in the original data, the heterogeneity captured by a Factor. This can be done using the `plotDataHeatmap` function.

```
# Add metadata to the plot
factor1 <- sort(getFactors(MOFAobject,"LF1")[,1])
order_samples <- names(factor1)
df <- data.frame(
  row.names = order_samples,
  culture = getCovariates(MOFAobject, "culture")[order_samples],
  factor = factor1
)

plotDataHeatmap(
  object = MOFAobject,
  view = "RNA expression",
  factor = "LF1",
  features = 20,
  transpose = TRUE,
  show_colnames=FALSE, show_rownames=TRUE, # pheatmap options
  cluster_cols = FALSE, annotation_col=df # pheatmap options
)
```

![](data:image/png;base64...)

We can now connect these transcriptomic changes to coordinated changes on the DNA methylation. As *Factor 1* is active in all genomic contexts, it suggests that there is a massive genome-wide DNA methylation remodelling. This can confirmed by inspecting the weights in the DNA methylation views, as we do here for the CpG sites in enhancers: Notice that most features (CpG sites) have a negative weight, which suggests that their DNA methylation decrease in a manner that is inversely proportional to the direction of *Factor 1*.

```
plotWeights(
  object = MOFAobject,
  view = "Met Enhancers",
  factor = 1,
  nfeatures = 0,
  abs = FALSE,
  scale = FALSE
)
```

![](data:image/png;base64...)
Similar observations can be made for the CpG sites in other genomic contexts, here CpG Islands or Promotors, by plotting the weights of the respective views (i.e. “Met CpG Islands” or “Met Promoters”).

As done before, let’s observe the heterogeneity captured by *Factor 1* in the original data space. This clearly confirms that most of the CpG sites are getting methylated as cells progress in *Factor 1* from naive to primed pluripotent stem cells

```
plotDataHeatmap(
  object = MOFAobject,
  view = "Met Enhancers",
  factor = 1,
  features = 500,
  transpose = TRUE,
  cluster_rows=FALSE, cluster_cols=FALSE, # pheatmap options
  show_rownames=FALSE, show_colnames=FALSE, # pheatmap options
  annotation_col=df  # pheatmap options
)
```

![](data:image/png;base64...)

### 3.2.2 Inspection of loadings for Factor 2

A similar analysis for *Factor 2* reveals that it captures a second axis of differentiation from the primed pluripotency state to a differentiated state, with highest RNA loadings for known differentiation markers such as keratins and annexins.

```
# Plot all weights and highlight specific gene markers
plotWeights(
  object = MOFAobject,
  view="RNA expression",
  factor = 2,
  nfeatures = 0,
  manual = list(c("Krt8","Cald1","Anxa5","Tagln",
                  "Ahnak","Dsp","Anxa3","Krt19")),
  scale = FALSE,
  abs = FALSE
)
```

![](data:image/png;base64...)

```
# Plot top 10 genes
plotTopWeights(
  object = MOFAobject,
  view="RNA expression",
  factor = 2,
  nfeatures = 10
)
```

![](data:image/png;base64...)

Interestingly, the \(R^2\) plot suggests that this second axis of variability is not associated with DNA methylation. We can confirm this by plotting the weights (they are all zero) and the heatmaps (no coherent pattern) as we have done before:

```
plotWeights(
  object = MOFAobject,
  view = "Met Enhancers",
  factor = 2,
  nfeatures = 0,
  abs = FALSE,
  scale = FALSE
)
```

![](data:image/png;base64...)

```
factor2 <- sort(getFactors(MOFAobject,"LF2")[,1])
order_samples <- names(factor2)
df <- data.frame(
  row.names = order_samples,
  culture =  getCovariates(MOFAobject, "culture")[order_samples],
  factor = factor2
)
plotDataHeatmap(
  object = MOFAobject,
  view = "Met Enhancers",
  factor = 2,
  features = 500,
  transpose = TRUE,
  cluster_rows=FALSE, cluster_cols=FALSE,  # pheatmap options
  show_rownames=FALSE, show_colnames=FALSE,  # pheatmap options
  annotation_col=df  # pheatmap options
)
```

![](data:image/png;base64...)

## 3.3 Ordination of samples by factors

Samples can be visualized along factors of interest using the `plotFactorScatter` and `plotFactorBeeswarm` functions.

In this data set, the **combination of Factor 1 and Factor 2 captured the entire differentiation trajectory from naive pluripotent cells via primed pluripotent cells to differentiated cells**. This illustrates the importance of learning continuous latent factors rather than discrete sample assignments.

```
p <- plotFactorScatter(
  object = MOFAobject,
  factors=1:2,
  color_by = "culture")

p + scale_color_manual(values=c("lightsalmon","orangered3"))
```

![](data:image/png;base64...)

Finally, *Factor 3* captured the cellular detection rate, a known technical covariate that represents the number of expressed genes.

```
plotFactorBeeswarm(
  object = MOFAobject,
  factors = 3,
  color_by = "cellular_detection_rate"
)
```

```
## Warning in is.na(color_by) | is.nan(color_by) | color_by == "NaN" |
## is.na(shape_by): longer object length is not a multiple of shorter object
## length
```

```
## Warning: Removed 6 rows containing missing values (position_quasirandom).
```

![](data:image/png;base64...)

## 3.4 Customized analysis

For customized exploration of weights and factors, you can directly fetch the variables from the `MOFAobject` using ‘get’ functions: `getWeights`, `getFactors` and `getTrainData`. As an example, here we do a scatterplot between Factor 3 and the true Cellular Detection Rate values

```
cdr <- colMeans(getTrainData(MOFAobject)$`RNA expression`>0,na.rm=TRUE)
factor3 <- getFactors(MOFAobject,
                      factors=3)

foo <- data.frame(factor = as.numeric(factor3), cdr = cdr)
ggplot(foo, aes_string(x = "factor", y = "cdr")) +
  geom_point() + xlab("Factor 3") +
  ylab("Cellular Detection Rate") +
  stat_smooth(method="lm") +
  theme_bw()
```

```
## Warning: Removed 6 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 6 rows containing missing values (geom_point).
```

![](data:image/png;base64...)

# 4 Further functionalities

## 4.1 Imputation of missing observations

The factors can be used to impute missing data (see Methods of the publication). This is done using the `impute` function, which stores the imputed data in the `ImputedData` slot of the `MOFAobject`. It can be accessed via the `getImputedData` function:

```
MOFAobject <- impute(MOFAobject)
nonImputedMethylation <- getTrainData(MOFAobject,
                                      view="Met CpG Islands")[[1]]
imputedMethylation <- getImputedData(MOFAobject,
                                     view="Met CpG Islands")[[1]]
```

```
# non-imputed data
pheatmap::pheatmap(nonImputedMethylation[1:100,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)

```
# imputed data
pheatmap::pheatmap(imputedMethylation[1:100,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)
```

![](data:image/png;base64...)

## 4.2 Clustering of samples based on latent factors

Samples can be clustered according to their values on the latent factors using the `clusterSamples` function.

```
# kmeans clustering with K=3 using Factor 1
set.seed(1234)
clusters <- clusterSamples(MOFAobject, k=3, factors=1)

# Scatterplot colored by the predicted cluster labels,
# and shaped by the true culture conditions
plotFactorScatter(
  object = MOFAobject,
  factors = 1:2,
  color_by = clusters,
  shape_by = "culture"
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
##  [1] ggplot2_3.1.1               MOFAdata_0.99.6
##  [3] MOFA_1.0.0                  MultiAssayExperiment_1.10.0
##  [5] SummarizedExperiment_1.14.0 DelayedArray_0.10.0
##  [7] BiocParallel_1.18.0         matrixStats_0.54.0
##  [9] Biobase_2.44.0              GenomicRanges_1.36.0
## [11] GenomeInfoDb_1.20.0         IRanges_2.18.0
## [13] S4Vectors_0.22.0            BiocGenerics_0.30.0
## [15] BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##  [1] ggrepel_0.8.0          Rcpp_1.0.1             lattice_0.20-38
##  [4] assertthat_0.2.1       digest_0.6.18          foreach_1.4.4
##  [7] R6_2.4.0               plyr_1.8.4             evaluate_0.13
## [10] pillar_1.3.1           zlibbioc_1.30.0        rlang_0.3.4
## [13] lazyeval_0.2.2         Matrix_1.2-17          reticulate_1.12
## [16] rmarkdown_1.12         labeling_0.3           stringr_1.4.0
## [19] pheatmap_1.0.12        RCurl_1.95-4.12        munsell_0.5.0
## [22] compiler_3.6.0         vipor_0.4.5            xfun_0.6
## [25] pkgconfig_2.0.2        ggbeeswarm_0.6.0       htmltools_0.3.6
## [28] tidyselect_0.2.5       tibble_2.1.1           GenomeInfoDbData_1.2.1
## [31] bookdown_0.9           codetools_0.2-16       reshape_0.8.8
## [34] withr_2.1.2            crayon_1.3.4           dplyr_0.8.0.1
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