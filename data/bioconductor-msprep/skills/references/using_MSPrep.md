Code

* Show All Code
* Hide All Code

# Using MSPrep

Max McGrath1\*, Matt Mulvahill2\*\*, Grant Hughes\*\*\*, Sean Jacobson3\*\*\*\*, Harrison Pielke-Lombardo1\*\*\*\*\* and Katerina Kechris1\*\*\*\*\*\*

1University of Colorado Anschutz Medical Campus
2Charter Communications
3National Jewish Hospital

\*max.mcgrath@ucdenver.edu
\*\*matt.mulvahill@gmail.com
\*\*\*dydxhughes@gmail.com
\*\*\*\*jacobsons@njhealth.org
\*\*\*\*\*harrison.pielke-lombardo@cuanschutz.edu
\*\*\*\*\*\*katerina.kechris@cuanschutz.edu

#### 19 January 2026

#### Package

MSPrep 1.20.1

# 1 Introduction

`MSPrep` provides a convenient set of functionalities used in the pre-analytic
processing pipeline for mass spectrometry based metabolomics data. Functions are
included for the following processes commonly performed prior to analysis of
such data:

1. Summarization of technical replicates (if available)
2. Filtering of metabolites
3. Imputation of missing values
4. Transformation, normalization, and batch correction

The sections which follow provide an explanation of each function contained in
`MSPrep`, those functions’ respective options, and examples of the pre-analysis
pipeline using two data sets provided in the `MSPrep` package, `MSQuant` and
`COPD_131`.

For further information, please see *MSPrep—Summarization, normalization and
diagnostics for processing of mass spectrometry–based metabolomic data*
(Hughes et al., 2014) and *Pre-analytic Considerations for Mass Spectrometry-Bas
ed Untargeted Metabolomics Data* (Reinhold et al., 2019).

# 2 Expected Data Format

Data my be input as a Data Frame or `SummarizedExperiment`.

## 2.1 Data Frame

When using the functions provided by `MSPrep` on a data frame, the following
format is expected throughout the pipeline.

Most often, two or more columns of the data frame will identify unique
compounds. This may include columns which specify the mass-to-charge ratio, the
retention time, or the name of each compound. Using the parameter `compVars`,
the names of these columns should be provided to each function as a vector of
character strings.

The remainder of the columns in the data frame should specify the respective
abundances of each compound for each sample. It is expected that one or more
identifying variables for each sample will be specified by the column name (e.g.
Sample ID, batch number, or replicate). Each piece of information contained in
the column names must be separated by a consistent character not present
anywhere else in the column name. Using the parameter `sampleVars`, the sample
variables present in the column names should be provided to each function as a
vector of character strings specifying the order the variables appear, and the
parameter `separator` should identify the character which separates each sample
variable. Each column name may also include consistent non-identifying text at
the beginning of each column name. This text should be provided to each function
using the `colExtraText` parameter.

As an example see the provided data set `msquant` and its use in the pipeline
below.

## 2.2 SummarizedExperiment

When using the functions provided by `MSPrep` on a `SummarizedExperiment`, it is
expected that the data will include a single `assay` of abundances, `rowData`
identifying characteristics of each metabolite, and `colData` specifying
characteristics of each sample. The parameters discussed in the previous section
may be ignored.

# 3 Example One - Technical Data Set

```
data(msquant)
colnames(msquant)[3]
```

```
## [1] "Neutral_Operator_Dif_Pos_1x_O1_A_01"
```

Above is the third column name in `msquant`. The first part
“Neutral\_Operator\_Dif\_Pos\_” will not be used in this analysis, so we will assign
it to `colExtraText` parameter. The next value, “1x”, is the spike-in value.
The following value, “O1”, specifies the sample’s batch. The remaining values,
“A” and “01”, specify the replicate and subject IDs. We will pass these
sample variables to each function with the `sampleVars` parameter. Finally, note
that `msquant` contains two columns, `mz` and `rt` which identify each
compounds’ mass-to-charge ratio and retention time, respectively. We will pass
these column names to each function using the `compVars` parameter.

With our data in this format, we can start the pipeline.

## 3.1 Summarizing

This step summarizes the technical replicates using the following procedure for
each compound in each batch.

1. If there are less than a minimum proportion of the values found among the
   replicates (usually one or zero), leave the value empty. Otherwise proceed.
2. Calculate the coefficient of variation between the replicates using
   \(c\_v = \frac{\sigma}{\mu}\), where \(\mu\) is the mean and \(\sigma\) is the
   standard deviation.
3. For three replicates, if the coefficient of variation is above a specified
   level, use the median value for the compound, to correct for the large
   dispersion.
4. Otherwise, use the mean value of the replicates for the compound.

If the name of variable specifying replicate in `sampleVars` for a data frame
or the column data of a `SummarizedExperiment`, specify the name of the variable
using the `replicate` parameter.

The technical replicates in `MSQuant` are summarized below using a CV maximum of
.50 and a minimum proportion present of 1 out of 3 replicates. Note that in the
`MSQuant` dataset, missing values are represented as ‘1’, which is specified in
the `missingValue` argument below. `msSummarize()` will replace these missing
values with ‘0’ in all instances where the summarization algorithm determines
the values to be truly missing.

```
summarizedDF <- msSummarize(msquant,
                            cvMax = 0.50,
                            minPropPresent = 1/3,
                            compVars = c("mz", "rt"),
                            sampleVars = c("spike", "batch", "replicate",
                                           "subject_id"),
                            colExtraText = "Neutral_Operator_Dif_Pos_",
                            separator = "_",
                            missingValue = 1)
```

```
## # A tibble: 10 × 6
##       mz rt        `1x_O1_01` `1x_O1_02` `1x_O2_01` `1x_O2_02`
##    <dbl> <chr>          <dbl>      <dbl>      <dbl>      <dbl>
##  1  78.0 21.362432    120937.    121018.    118425.    118527.
##  2  80.0 9.772964      63334.     63415.     69530      69631.
##  3  80.1 0.6517916     78601      78668.    154636     154737.
##  4  83.1 1.3226668     58473.     58554.    298703.    298804.
##  5  84.1 7.864             0          0          0          0
##  6  85.1 22.307388    348686     348753.    342413     342420.
##  7  85.1 0.7104762         0          0          0          0
##  8  85.1 1.3228333    335092.    335172.   1753681    1753782.
##  9  86.0 22.587963    226792.    226872.    240137     240238.
## 10  87.0 1.702             0          0     674771.    674872.
```

## 3.2 Filtering

Following the summarization of technical replicates, the data can be filtered to
only contain compounds present in a specified proportion of samples. To do so,
the `msFilter()` function is provided. By default, `msFilter()` uses the 80%
rule and filters the compounds in the data set leaving only those which are
present in 80% of the samples.

```
filteredDF <- msFilter(summarizedDF,
                       filterPercent = 0.8,
                       compVars = c("mz", "rt"),
                       sampleVars = c("spike", "batch", "subject_id"),
                       separator = "_")
```

```
## # A tibble: 10 × 6
##       mz rt        `1x_O1_01` `1x_O1_02` `1x_O2_01` `1x_O2_02`
##    <dbl> <chr>          <dbl>      <dbl>      <dbl>      <dbl>
##  1  78.0 21.362432    120937.    121018.    118425.    118527.
##  2  80.0 9.772964      63334.     63415.     69530      69631.
##  3  80.1 0.6517916     78601      78668.    154636     154737.
##  4  86.0 22.587963    226792.    226872.    240137     240238.
##  5  90.0 3.0758798         0          0     148358.    148460.
##  6  99.1 22.379221   6216101    6216182.   6137392    6137493.
##  7  99.9 21.431955    117396     117477.    110735     110836.
##  8 102.  3.076125      92308      92389.         0          0
##  9 104.  9.770778      78100      78181.     61308      61409.
## 10 107.  22.5569      134960     135039.     83090.     83281.
```

## 3.3 Imputation

Next, depending on the downstream analysis, you may need to impute missing data.
Three imputation methods are provided:

1. half-min (half the minimum value)
2. bpca (Bayesian PCA),
3. knn (k-nearest neighbors)

Half-min imputes each missing value as one half of the minimum observed value
for that compound. Half-min imputation performs faster than other methods,
but may introduce bias. The BPCA algorithm, provided by the `pcaMethods`
package, estimates the missing value by a linear combination
of principle axis vectors, with the number of principle components specified by
the user with the `nPcs` argument. KNN uses a K-Nearest Neighbors algorithm
provided by the `VIM` package. Users may provide
their preferred value of k using the `kKnn` argument. By default, KNN
uses samples as neighbors, but by specifying `compoundsAsNeighbors = TRUE`,
compounds will be used as neighbors instead. Note that this is significantly
slower than using samples as neighbors and may take several minutes or more to
run depending on the size of your data set.

```
imputedDF <- msImpute(filteredDF,
                      imputeMethod = "knn",
                      compVars = c("mz", "rt"),
                      sampleVars = c("spike", "batch", "subject_id"),
                      separator = "_",
                      returnToSE = FALSE,
                      missingValue = 0)
```

```
## # A tibble: 10 × 6
##       mz rt        `1x_O1_01` `1x_O1_02` `1x_O2_01` `1x_O2_02`
##    <dbl> <chr>          <dbl>      <dbl>      <dbl>      <dbl>
##  1  78.0 21.362432    120937.    121018.    118425.    118527.
##  2  80.0 9.772964      63334.     63415.     69530      69631.
##  3  80.1 0.6517916     78601      78668.    154636     154737.
##  4  86.0 22.587963    226792.    226872.    240137     240238.
##  5  90.0 3.0758798    121246     116549.    148358.    148460.
##  6  99.1 22.379221   6216101    6216182.   6137392    6137493.
##  7  99.9 21.431955    117396     117477.    110735     110836.
##  8 102.  3.076125      92308      92389.   1215434.    908742.
##  9 104.  9.770778      78100      78181.     61308      61409.
## 10 107.  22.5569      134960     135039.     83090.     83281.
```

## 3.4 Normalization

In order to make comparisons between samples, the data may need to be
transformed and normalized This step transforms the data and performs one of
eight normalization strategies:

1. Median
2. ComBat
3. Quantile
4. Quantile + ComBat
5. Median + ComBat
6. CRMN
7. RUV
8. SVA

`msNormalize()` also provides options to transform the data using a log base 10
(default), log base 2, or natural log transformation. To select either option,
or to forego transformation, use the `transform` argument to specify `"log10"`,
`"log2"`, `"ln"`, or `"none"` respectively.

Quantile normalization, provided by the `preprocessCore` package, ensures that
the provided samples have the same quantiles. Median normalization subtracts
the median abundance of each sample from every compound in that sample, thereby
aligning the median abundance of each sample at 0.

ComBat, provided by the `sva` package, is an empirical Bayes batch effect
correction algorithm to remove unwanted batch effects and may be used separately
or in conjunction with quantile or median normalization. When using ComBat, a
`sampleVar` called “batch” must be present for data frames, or for
`SummarizedExperiment` “batch” must be present in the columns names of
`colData`. Or, if the sample variable corresponding to batch differs from
“batch”, you may specify the batch variables name using the `batch` parameter.

RUV and SVA normalization each estimate a matrix of unobserved factors of
importance using different methods of supervised factor analysis. For both
methods, known covariates (e.g. sex, age) should be provided using the
`covariatesOfInterest` parameter, and must correspond to the sample variables
specified by `sampleVars` in the case of a data frame or `colData` in the case
of a `SummarizedExperiment`. For RUV normalization, the `kRUV` argument
specifies the number of factors on which the data is normalized.

Cross-Contribution Compensating Multiple Standard Normalization (CRMN), provided
by the `crmn` package, normalizes based on internal standards. The sample
variable identifying internal standards must be provided using the
`covariatesOfInterest` parameter. For experiments which have control compounds,
a vector of the row numbers containing them should be provided in the
controls variable. If a vector of control compounds is not provided, data driven
controls will be generated.

Below, we apply a log base 10 transformation, quantile normalization, and ComBat
batch correction.

```
normalizedDF <- msNormalize(imputedDF,
                            normalizeMethod = "quantile + ComBat",
                            transform = "log10",
                            compVars = c("mz", "rt"),
                            sampleVars = c("spike", "batch", "subject_id"),
                            covariatesOfInterest = c("spike"),
                            separator = "_")
```

```
## # A tibble: 10 × 6
##       mz rt        `1x_O1_01` `1x_O1_02` `1x_O2_01` `1x_O2_02`
##    <dbl> <chr>          <dbl>      <dbl>      <dbl>      <dbl>
##  1  78.0 21.362432       5.07       5.08       5.03       5.04
##  2  80.0 9.772964        4.80       4.80       4.82       4.83
##  3  80.1 0.6517916       4.97       4.97       5.08       5.09
##  4  86.0 22.587963       5.39       5.39       5.29       5.31
##  5  90.0 3.0758798       5.12       5.10       5.11       5.12
##  6  99.1 22.379221       6.82       6.82       6.82       6.82
##  7  99.9 21.431955       5.06       5.06       5.01       5.03
##  8 102.  3.076125        5.05       5.05       5.68       5.63
##  9 104.  9.770778        4.90       4.90       4.82       4.83
## 10 107.  22.5569         5.09       5.09       4.95       4.96
```

## 3.5 Pipeline

Often, all the above steps will need to be conducted. This can be done in a
single statement using the `msPrepare()` function. Simply provide the
function the same arguments that you would provide to the individual functions.

```
preparedDF <- msPrepare(msquant,
                        minPropPresent = 1/3,
                        missingValue = 1,
                        filterPercent = 0.8,
                        imputeMethod = "knn",
                        normalizeMethod = "quantile + ComBat",
                        transform = "log10",
                        covariatesOfInterest = c("spike"),
                        compVars = c("mz", "rt"),
                        sampleVars = c("spike", "batch", "replicate",
                                       "subject_id"),
                        colExtraText = "Neutral_Operator_Dif_Pos_",
                        separator = "_")
```

```
## # A tibble: 10 × 6
##       mz rt        `1x_O1_01` `1x_O1_02` `1x_O2_01` `1x_O2_02`
##    <dbl> <chr>          <dbl>      <dbl>      <dbl>      <dbl>
##  1  78.0 21.362432       5.07       5.08       5.03       5.04
##  2  80.0 9.772964        4.80       4.80       4.82       4.83
##  3  80.1 0.6517916       4.97       4.97       5.08       5.09
##  4  86.0 22.587963       5.39       5.39       5.29       5.31
##  5  90.0 3.0758798       5.12       5.10       5.11       5.12
##  6  99.1 22.379221       6.82       6.82       6.82       6.82
##  7  99.9 21.431955       5.06       5.06       5.01       5.03
##  8 102.  3.076125        5.05       5.05       5.68       5.63
##  9 104.  9.770778        4.90       4.90       4.82       4.83
## 10 107.  22.5569         5.09       5.09       4.95       4.96
```

# 4 Example Two - Biological Data Set

Next, the functionality of `MSPrep` will be demonstrated using the included data
`COPD_131`. The raw data set can be found [here, at Metabolomics Workbench.](https://www.metabolomicsworkbench.org/data/DRCCMetadata.php?Mode=Project&ProjectID=PR000438)
Note that only a portion of the compounds in the original `COPD_131` data set
are included in this package in order to limit file size and example run time.
Generally, the number of compounds in a data set will greatly
exceed the number of samples, and the functions included in this package will
take more time to process the data.

This data set differs from `msquant` in several ways. First, it has a column
`Compound.Name` which specifies compound names, and the mass-to-charge ratio and
retention-time columns are named `Mass` and `Retention.Time` respectively.
Second, this data set does not have spike-ins or batches (but it does have
technical replicates). Finally, the data has already been transformed, so that
step of the pipeline will be excluded.

## 4.1 Summarizing

Next, the technical replicates in `COPD_131` need to be summarized. This process
is largely the same as before, but with different column names passed to
`compVars`, so `msSummarize()` is called as follows:

```
data(COPD_131)

summarizedSE131 <- msSummarize(COPD_131,
                               cvMax = 0.5,
                               minPropPresent = 1/3,
                               replicate = "replicate",
                               compVars = c("Mass", "Retention.Time",
                                            "Compound.Name"),
                               sampleVars = c("subject_id", "replicate"),
                               colExtraText = "X",
                               separator = "_",
                               returnToSE = TRUE)
```

## 4.2 Filtering

Again, this process is largely the same as before, choosing a filter percentage
of 0.8. So, we call `msFilter()` as follows:

```
filteredSE131 <- msFilter(summarizedSE131,
                          filterPercent = 0.8)
```

## 4.3 Imputing

For this example, `msImpute()` will be called using Bayesian PCA using three
principle components to impute the missing values for the data.

```
imputedSE131 <- msImpute(filteredSE131,
                         imputeMethod = "bpca",
                         nPcs = 3,
                         missingValue = 0)
```

## 4.4 Normalizing

For this example, `msNormalize()` will be called using median normalization with
no transformation applied.

```
normalizedSe131 <- msNormalize(imputedSE131,
                               normalizeMethod = "median",
                               transform = "none")
```

## 4.5 Pipeline

As with the previous example, the above steps can be performed in a pipeline
using the `msPrepare()` function. To skip the transformation step of the
pipeline, set the `transform` parameter to “none” (note that the same can
be done for `imputationMethod` and `normalizationMethod`).

```
preparedSE <- msPrepare(COPD_131,
                        cvMax = 0.5,
                        minPropPresent = 1/3,
                        compVars = c("Mass", "Retention.Time",
                                     "Compound.Name"),
                        sampleVars = c("subject_id", "replicate"),
                        colExtraText = "X",
                        separator = "_",
                        filterPercent = 0.8,
                        imputeMethod = "bpca",
                        normalizeMethod = "median",
                        transform = "none",
                        nPcs = 3,
                        missingValue = 0,
                        returnToSE = TRUE)
```

```
## Summarizing
## Filtering
## Imputing
## Normalizing
```

# 5 Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] MSPrep_1.20.1    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] vcd_1.4-13                  jsonlite_2.0.0
##   [3] magrittr_2.0.4              rmarkdown_2.30
##   [5] vctrs_0.7.0                 memoise_2.0.1
##   [7] htmltools_0.5.9             S4Arrays_1.10.1
##   [9] itertools_0.1-3             missForest_1.6.1
##  [11] SparseArray_1.10.8          Formula_1.2-5
##  [13] sass_0.4.10                 parallelly_1.46.1
##  [15] bslib_0.9.0                 mlr3_1.3.0
##  [17] palmerpenguins_0.1.1        mlr3tuning_1.5.1
##  [19] zoo_1.8-15                  cachem_1.1.0
##  [21] uuid_1.2-1                  lifecycle_1.0.5
##  [23] iterators_1.0.14            pkgconfig_2.0.3
##  [25] Matrix_1.7-4                R6_2.6.1
##  [27] fastmap_1.2.0               rbibutils_2.4
##  [29] MatrixGenerics_1.22.0       future_1.69.0
##  [31] digest_0.6.39               pcaMethods_2.2.0
##  [33] colorspace_2.1-2            AnnotationDbi_1.72.0
##  [35] S4Vectors_0.48.0            mlr3misc_0.19.0
##  [37] GenomicRanges_1.62.1        RSQLite_2.4.5
##  [39] randomForest_4.7-1.2        httr_1.4.7
##  [41] abind_1.4-8                 mgcv_1.9-4
##  [43] compiler_4.5.2              rngtools_1.5.2
##  [45] proxy_0.4-29                bit64_4.6.0-1
##  [47] withr_3.0.2                 backports_1.5.0
##  [49] BiocParallel_1.44.0         carData_3.0-5
##  [51] DBI_1.2.3                   MASS_7.3-65
##  [53] DelayedArray_0.36.0         tools_4.5.2
##  [55] lmtest_0.9-40               ranger_0.18.0
##  [57] otel_0.2.0                  nnet_7.3-20
##  [59] glue_1.8.0                  lgr_0.5.0
##  [61] nlme_3.1-168                grid_4.5.2
##  [63] checkmate_2.3.3             generics_0.1.4
##  [65] sva_3.58.0                  class_7.3-23
##  [67] preprocessCore_1.72.0       tidyr_1.3.2
##  [69] data.table_1.18.0           utf8_1.2.6
##  [71] sp_2.2-0                    car_3.1-3
##  [73] XVector_0.50.0              BiocGenerics_0.56.0
##  [75] foreach_1.5.2               pillar_1.11.1
##  [77] stringr_1.6.0               VIM_7.0.0
##  [79] limma_3.66.0                genefilter_1.92.0
##  [81] robustbase_0.99-6           bbotk_1.8.1
##  [83] splines_4.5.2               dplyr_1.1.4
##  [85] lattice_0.22-7              survival_3.8-6
##  [87] bit_4.6.0                   annotate_1.88.0
##  [89] tidyselect_1.2.1            locfit_1.5-9.12
##  [91] Biostrings_2.78.0           knitr_1.51
##  [93] bookdown_0.46               IRanges_2.44.0
##  [95] Seqinfo_1.0.0               edgeR_4.8.2
##  [97] SummarizedExperiment_1.40.0 stats4_4.5.2
##  [99] xfun_0.56                   Biobase_2.70.0
## [101] statmod_1.5.1               matrixStats_1.5.0
## [103] DEoptimR_1.1-4              stringi_1.8.7
## [105] yaml_2.3.12                 boot_1.3-32
## [107] evaluate_1.0.5              codetools_0.2-20
## [109] crmn_0.0.21                 laeken_0.5.3
## [111] tibble_3.3.1                BiocManager_1.30.27
## [113] cli_3.6.5                   xtable_1.8-4
## [115] Rdpack_2.6.4                jquerylib_0.1.4
## [117] mlr3learners_0.14.0         Rcpp_1.1.1
## [119] globals_0.18.0              png_0.1-8
## [121] XML_3.99-0.20               parallel_4.5.2
## [123] blob_1.3.0                  doRNG_1.8.6.2
## [125] paradox_1.0.1               listenv_0.10.0
## [127] mlr3pipelines_0.10.0        e1071_1.7-17
## [129] purrr_1.2.1                 crayon_1.5.3
## [131] rlang_1.1.7                 KEGGREST_1.50.0
```