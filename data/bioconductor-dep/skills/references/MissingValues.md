# Missing value handling

Arne Smits

#### 29 October 2025

#### Package

DEP 1.32.0

# Contents

* [1 Goal of this vignette](#goal-of-this-vignette)
* [2 Simulate data](#simulate-data)
  + [2.1 Generate intensity values](#generate-intensity-values)
  + [2.2 Introduce missing values](#introduce-missing-values)
  + [2.3 Generate a SummarizedExperiment](#generate-a-summarizedexperiment)
* [3 Filter proteins based on missing values](#filter-proteins-based-on-missing-values)
  + [3.1 Visualize the extend of missing values](#visualize-the-extend-of-missing-values)
  + [3.2 Filter options](#filter-options)
  + [3.3 Scaling and variance stabilization](#scaling-and-variance-stabilization)
* [4 Data imputation of missing data](#data-imputation-of-missing-data)
  + [4.1 Explore the pattern of missing values](#explore-the-pattern-of-missing-values)
  + [4.2 Imputation options](#imputation-options)
  + [4.3 Advanced imputation methods](#advanced-imputation-methods)
    - [4.3.1 Mixed imputation on proteins (rows)](#mixed-imputation-on-proteins-rows)
    - [4.3.2 Mixed imputation on samples (columns)](#mixed-imputation-on-samples-columns)
* [5 Test for differential expression](#test-for-differential-expression)
  + [5.1 Number of identified differentially expressed proteins](#number-of-identified-differentially-expressed-proteins)
  + [5.2 ROC curves](#roc-curves)
  + [5.3 Differences in response](#differences-in-response)
* [6 Session information](#session-information)

# 1 Goal of this vignette

Proteomics data suffer from a high rate of missing values, which need to be accounted for.
Different methods have been applied to deal with this issue, including multiple imputation methods
(see for example [Lazar et al](http://pubs.acs.org/doi/10.1021/acs.jproteome.5b00981)).
The different options to deal with missing values in **DEP** are described in this vignette.

# 2 Simulate data

To exemplify the missing value handling, we work with a simulated dataset.
This is very useful, because we know the ground truth of our dataset,
meaning we know which proteins are belonging to the background (null distribution)
and which proteins are differentially expressed between the control and sample conditions.

## 2.1 Generate intensity values

We generate a dataset with 3300 proteins,
of which 300 proteins are differentially expressed.
The variables used to generate the data are depicted below.

```
# Variables
replicates = 3
bg_proteins = 3000
DE_proteins = 300
log2_mean_bg = 27
log2_sd_bg = 2
log2_mean_DE_control = 25
log2_mean_DE_treatment = 30
log2_sd_DE = 2
```

```
# Loading DEP and packages required for data handling
library("DEP")
library("dplyr")
library("tidyr")
library("purrr")
library("ggplot2")
library("SummarizedExperiment")

# Background data (sampled from null distribution)
sim_null <- data_frame(
  name = paste0("bg_", rep(1:bg_proteins, rep((2*replicates), bg_proteins))),
  ID = rep(1:bg_proteins, rep((2*replicates), bg_proteins)),
  var = rep(c("control_1", "control_2", "control_3",
    "treatment_1", "treatment_2", "treatment_3"), bg_proteins),
  val = 2^rnorm(2*replicates*bg_proteins, mean = log2_mean_bg, sd = log2_sd_bg))
```

```
## Warning: `data_frame()` was deprecated in tibble 1.1.0.
## ℹ Please use `tibble()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
# Data for DE proteins (sampled from alternative distribution)
sim_diff <- rbind(
  data_frame(
    name = paste0("DE_", rep(1:DE_proteins, rep(replicates, DE_proteins))),
    ID = rep((bg_proteins+1):(bg_proteins+DE_proteins),
      rep(replicates, DE_proteins)),
    var = rep(c("control_1", "control_2", "control_3"), DE_proteins),
    val = 2^rnorm(replicates*DE_proteins,
      mean = log2_mean_DE_control, sd = log2_sd_DE)),
  data_frame(
    name = paste0("DE_", rep(1:DE_proteins, rep(replicates, DE_proteins))),
    ID = rep((bg_proteins+1):(bg_proteins+DE_proteins),
      rep(replicates, DE_proteins)),
    var = rep(c("treatment_1", "treatment_2", "treatment_3"), DE_proteins),
    val = 2^rnorm(replicates*DE_proteins,
      mean = log2_mean_DE_treatment, sd = log2_sd_DE)))

# Combine null and DE data
sim <- rbind(sim_null, sim_diff) %>%
  spread(var, val) %>%
  arrange(ID)

# Generate experimental design
experimental_design <- data_frame(
  label = colnames(sim)[!colnames(sim) %in% c("name", "ID")],
  condition = c(rep("control", replicates),
    rep("treatment", replicates)),
  replicate = rep(1:replicates, 2))
```

## 2.2 Introduce missing values

Data can be missing at random (MAR) or missing not at random (MNAR).
MAR means that values are randomly missing from all samples.
In the case of MNAR, values are missing in specific samples and/or for specific proteins.
For example, certain proteins might not be quantified in specific conditions,
because they are below the detection limit in these specific samples.

To mimick these two types of missing values,
we introduce missing values randomly over all data points (MAR)
and we introduce missing values in the control samples of
100 differentially expressed proteins (MNAR).
The variables used to introduce missing values are depicted below.

```
# Variables
MAR_fraction = 0.05
MNAR_proteins = 100
```

```
# Generate a MAR matrix
MAR_matrix <- matrix(
  data = sample(c(TRUE, FALSE),
    size = 2*replicates*(bg_proteins+DE_proteins),
    replace = TRUE,
    prob = c(MAR_fraction, 1-MAR_fraction)),
  nrow = bg_proteins+DE_proteins,
  ncol = 2*replicates)

# Introduce missing values at random (MAR)
controls <- grep("control", colnames(sim))
treatments <- grep("treatment", colnames(sim))
sim[, c(controls, treatments)][MAR_matrix] <- 0
sim$MAR <- apply(MAR_matrix, 1, any)

# Introduce missing values not at random (MNAR)
DE_protein_IDs <- grep("DE", sim$name)
sim[DE_protein_IDs[1:MNAR_proteins], controls] <- 0
sim$MNAR <- FALSE
sim$MNAR[DE_protein_IDs[1:MNAR_proteins]] <- TRUE
```

## 2.3 Generate a SummarizedExperiment

The data is stored in a SummarizedExperiment,
as described in the ‘Introduction to DEP’ vignette.

```
# Generate a SummarizedExperiment object
sim_unique_names <- make_unique(sim, "name", "ID", delim = ";")
se <- make_se(sim_unique_names, c(controls, treatments), experimental_design)
```

# 3 Filter proteins based on missing values

A first consideration with missing values is whether or not to filter out
proteins with too many missing values.

## 3.1 Visualize the extend of missing values

The number of proteins quantified over the samples can be visualized
to investigate the extend of missing values.

```
# Plot a barplot of the protein quantification overlap between samples
plot_frequency(se)
```

![](data:image/png;base64...)

Many proteins are quantified in all six samples and
only a small subset of proteins were detected in less than half of the samples.

## 3.2 Filter options

We can choose to not filter out any proteins at all,
filter for only the proteins without missing values,
filter for proteins with a certain fraction of quantified samples, and
for proteins that are quantified in all replicates of at least one condition.

```
# No filtering
no_filter <- se

# Filter for proteins that are quantified in all replicates of at least one condition
condition_filter <- filter_proteins(se, "condition", thr = 0)

# Filter for proteins that have no missing values
complete_cases <- filter_proteins(se, "complete")

# Filter for proteins that are quantified in at least 2/3 of the samples.
frac_filtered <- filter_proteins(se, "fraction", min = 0.66)
```

To check the consequences of filtering, we calculate the number of background
and DE proteins left in the dataset.

```
# Function to extract number of proteins
number_prots <- function(se) {
  names <- rownames(get(se))
  data_frame(Dataset = se,
    bg_proteins = sum(grepl("bg", names)),
    DE_proteins = sum(grepl("DE", names)))
}

# Number of bg and DE proteins still included
objects <- c("no_filter",
  "condition_filter",
  "complete_cases",
  "frac_filtered")

map_df(objects, number_prots)
```

```
## # A tibble: 4 × 3
##   Dataset          bg_proteins DE_proteins
##   <chr>                  <int>       <int>
## 1 no_filter               3000         300
## 2 condition_filter        2937         267
## 3 complete_cases          2147         141
## 4 frac_filtered           2997         200
```

For our simulated dataset, filtering for complete cases drastically reduces
the number of proteins, only keeping half of the DE proteins. Filtering protein
to be quantified in at least 2/3 of the samples, keeps many more DE proteins and
filters out all proteins with values MNAR. Filtering for proteins quantified in
all replicates of at least one condition only filters out a minimal amount of
DE proteins.

## 3.3 Scaling and variance stabilization

The data is scaled and variance stabilized using *[vsn](https://bioconductor.org/packages/3.22/vsn)*.

```
# Scale and variance stabilize
no_filter <- normalize_vsn(se)
condition_filter <- normalize_vsn(condition_filter)
complete_cases <- normalize_vsn(complete_cases)
frac_filtered <- normalize_vsn(frac_filtered)
```

```
# Mean versus Sd plot
meanSdPlot(no_filter)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the vsn package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

# 4 Data imputation of missing data

A second important consideration with missing values is
whether or not to impute the missing values.

MAR and MNAR (see [Introduce missing values](#introduce-missing-values))
require different imputation methods.
See the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* vignette and more specifically
the *impute* function descriptions for detailed information.

## 4.1 Explore the pattern of missing values

To explore the pattern of missing values in the data,
a heatmap can be plotted indicating whether values are missing (0) or not (1).
Only proteins with at least one missing value are visualized.

```
# Plot a heatmap of proteins with missing values
plot_missval(no_filter)
```

![](data:image/png;base64...)

The missing values seem to be randomly distributed across the samples (MAR).
However, we do note a block of values that are missing in all control samples
(bottom left side of the heatmap).
These proteins might have missing values not at random (MNAR).

To check whether missing values are biased to lower intense proteins,
the densities and cumulative fractions are plotted for proteins with
and without missing values.

```
# Plot intensity distributions and cumulative fraction of proteins
# with and without missing values
plot_detect(no_filter)
```

![](data:image/png;base64...)

In our example data, there is no clear difference between the two distributions.

## 4.2 Imputation options

DEP borrows the imputation functions from *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)*.
See the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* vignette and more specifically the *impute*
function description for more information on the imputation methods.

```
# All possible imputation methods are printed in an error, if an invalid function name is given.
impute(no_filter, fun = "")
```

```
## Error in match.arg(fun): 'arg' should be one of "bpca", "knn", "QRILC", "MLE", "MinDet", "MinProb", "man", "min", "zero", "mixed", "nbavg"
```

Some examples of imputation methods.

```
# No imputation
no_imputation <- no_filter

# Impute missing data using random draws from a
# Gaussian distribution centered around a minimal value (for MNAR)
MinProb_imputation <- impute(no_filter, fun = "MinProb", q = 0.01)

# Impute missing data using random draws from a
# manually defined left-shifted Gaussian distribution (for MNAR)
manual_imputation <- impute(no_filter, fun = "man", shift = 1.8, scale = 0.3)

# Impute missing data using the k-nearest neighbour approach (for MAR)
knn_imputation <- impute(no_filter, fun = "knn", rowmax = 0.9)
```

The effect of data imputation on the distributions can be visualized.

```
# Plot intensity distributions before and after imputation
plot_imputation(no_filter, MinProb_imputation,
  manual_imputation, knn_imputation)
```

![](data:image/png;base64...)

## 4.3 Advanced imputation methods

### 4.3.1 Mixed imputation on proteins (rows)

One can also perform a mixed imputation on the proteins,
which uses a MAR and MNAR imputation method on different subsets of proteins.
First, we have to define a logical vector defining the rows
that are to be imputed with the MAR method.
Here, we consider a protein to have missing values not at random (MNAR)
if it has missing values in all replicates of at least one condition.

```
# Extract protein names with missing values
# in all replicates of at least one condition
proteins_MNAR <- get_df_long(no_filter) %>%
  group_by(name, condition) %>%
  summarize(NAs = all(is.na(intensity))) %>%
  filter(NAs) %>%
  pull(name) %>%
  unique()

# Get a logical vector
MNAR <- names(no_filter) %in% proteins_MNAR

# Perform a mixed imputation
mixed_imputation <- impute(
  no_filter,
  fun = "mixed",
  randna = !MNAR, # we have to define MAR which is the opposite of MNAR
  mar = "knn", # imputation function for MAR
  mnar = "zero") # imputation function for MNAR
```

### 4.3.2 Mixed imputation on samples (columns)

Additionally, the imputation can also be performed on a subset of samples.
To peform a sample specific imputation, we first need to transform our
SummarizedExperiment into a MSnSet object.
Subsequently, we imputed the controls using the “MinProb” method and
the samples using the “knn” method.

```
# SummarizedExperiment to MSnSet object conversion
sample_specific_imputation <- no_filter
MSnSet <- as(sample_specific_imputation, "MSnSet")

# Impute differently for two sets of samples
MSnSet_imputed1 <- MSnbase::impute(MSnSet[, 1:3], method = "MinProb")
MSnSet_imputed2 <- MSnbase::impute(MSnSet[, 4:6], method = "knn")

# Combine into the SummarizedExperiment object
assay(sample_specific_imputation) <- cbind(
  MSnbase::exprs(MSnSet_imputed1),
  MSnbase::exprs(MSnSet_imputed2))
```

The effect of data imputation on the distributions can be visualized.

```
# Plot intensity distributions before and after imputation
plot_imputation(no_filter, mixed_imputation, sample_specific_imputation)
```

![](data:image/png;base64...)

# 5 Test for differential expression

We perform differential analysis on the different imputated data sets.
The following datasets are compared:

* No imputation
* knn imputation
* MinProb imputation
* Mixed imputation

```
# Function that wraps around test_diff, add_rejections and get_results functions
DE_analysis <- function(se) {
  se %>%
    test_diff(., type = "control", control = "control") %>%
    add_rejections(., alpha = 0.1, lfc = 0) %>%
    get_results()
}

# DE analysis on no, knn, MinProb and mixed imputation
no_imputation_results <- DE_analysis(no_imputation)
knn_imputation_results <- DE_analysis(knn_imputation)
MinProb_imputation_results <- DE_analysis(MinProb_imputation)
mixed_imputation_results <- DE_analysis(mixed_imputation)
```

## 5.1 Number of identified differentially expressed proteins

As an initial parameter we look at the number of
differentially expressed proteins identified (adjusted P ≤ 0.05).

```
# Function to extract number of DE proteins
DE_prots <- function(results) {
  data_frame(Dataset = gsub("_results", "", results),
    significant_proteins = get(results) %>%
      filter(significant) %>%
      nrow())
}

# Number of significant proteins
objects <- c("no_imputation_results",
  "knn_imputation_results",
  "MinProb_imputation_results",
  "mixed_imputation_results")

map_df(objects, DE_prots)
```

```
## # A tibble: 4 × 2
##   Dataset            significant_proteins
##   <chr>                             <int>
## 1 no_imputation                        97
## 2 knn_imputation                      123
## 3 MinProb_imputation                  147
## 4 mixed_imputation                    204
```

For our simulated dataset, no and knn imputation result in
less identified differentially expressed proteins
compared to the MinProb and mixed imputation.
Mixed imputation results in the identification of
the most differentially expressed proteins in our simulated dataset
with many proteins missing values not at random.

> Note that the performance of the different imputation methods is dataset-depedent.
> It is recommended to always carefully check the effect of filtering
> and data imputation on your results.

## 5.2 ROC curves

To further compare the results of the different imputation methods,
ROC curves are plotted.

```
# Function to obtain ROC data
get_ROC_df <- function(results) {
  get(results) %>%
    select(name, treatment_vs_control_p.val, significant) %>%
    mutate(
      DE = grepl("DE", name),
      BG = grepl("bg", name)) %>%
    arrange(treatment_vs_control_p.val) %>%
    mutate(
      TPR = cumsum(as.numeric(DE)) / 300,
      FPR = cumsum(as.numeric(BG)) / 3000,
      method = results)
}

# Get ROC data for no, knn, MinProb and mixed imputation
ROC_df <- map_df(objects, get_ROC_df)

# Plot ROC curves
ggplot(ROC_df, aes(FPR, TPR, col = method)) +
  geom_line() +
  theme_DEP1() +
  ggtitle("ROC-curve")
```

![](data:image/png;base64...)

```
# Plot ROC curves zoom
ggplot(ROC_df, aes(FPR, TPR, col = method)) +
  geom_line() +
  theme_DEP1() +
  xlim(0, 0.1) +
  ggtitle("ROC-curve zoom")
```

```
## Warning: Removed 11022 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![](data:image/png;base64...)

The ROC curves also show that mixed imputation has the best performance
for our simulated dataset.
Because the performance of the different imputation methods is
dataset-depedent, it is again recommended to carefully check the effect
of filtering and imputation on your dataset.

## 5.3 Differences in response

To start the investigation of imputation method performance on the dataset,
we ask ourselves the following questions:
Which proteins are not identified as differentially expressed proteins in
the datasets with no or knn imputation?
And which proteins are specifically for mixed imputation?
We look at both true and false positive hits as well as the missing values.

```
# Function to obtain summary data
get_rejected_proteins <- function(results) {
  get(results) %>%
    filter(significant) %>%
    left_join(., select(sim, name, MAR, MNAR), by = "name") %>%
    mutate(
      DE = grepl("DE", name),
      BG = grepl("bg", name),
      method = results)
}

# Get summary data for no, knn, MinProb and mixed imputation
objects <- c("no_imputation_results",
  "knn_imputation_results",
  "MinProb_imputation_results",
  "mixed_imputation_results")

summary_df <- map_df(objects, get_rejected_proteins)

# Plot number of DE proteins (True and False)
summary_df %>%
  group_by(method) %>%
  summarize(TP = sum(DE), FP = sum(BG)) %>%
  gather(category, number, -method) %>%
  mutate(method = gsub("_results", "", method)) %>%
  ggplot(aes(method, number, fill = category)) +
  geom_col(position = position_dodge()) +
  theme_DEP2() +
  labs(title = "True and False Hits",
    x = "",
    y = "Number of DE proteins",
    fill = "False or True")
```

![](data:image/png;base64...)

MinProb and mixed imputation identify many more truely differentially
expressed proteins (TP) and only minimally increase the number of
false positivies (FP) in our simulated dataset.

```
# Plot number of DE proteins with missing values
summary_df %>%
  group_by(method) %>%
  summarize(MNAR = sum(MNAR), MAR = sum(MAR)) %>%
  gather(category, number, -method) %>%
  mutate(method = gsub("_results", "", method)) %>%
  ggplot(aes(method, number, fill = category)) +
  geom_col(position = position_dodge()) +
  theme_DEP2() +
  labs(title = "Category of Missing Values",
    x = "",
    y = "Number of DE proteins",
    fill = "")
```

![](data:image/png;base64...)

The gain of identification of truely differentially expressed proteins in
MinProb and mixed imputation clearly comes from increased sensitivity for
data MNAR. This is also expected as these imputation methods perform
left-censored imputation, which is specific for data MNAR.

# 6 Session information

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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] ggplot2_4.0.0               purrr_1.1.0
## [13] tidyr_1.3.1                 dplyr_1.1.4
## [15] DEP_1.32.0                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] shape_1.4.6.1               MultiAssayExperiment_1.36.0
##   [5] magrittr_2.0.4              magick_2.9.0
##   [7] farver_2.1.2                MALDIquant_1.22.3
##   [9] rmarkdown_2.30              GlobalOptions_0.1.2
##  [11] fs_1.6.6                    vctrs_0.6.5
##  [13] Cairo_1.7-0                 tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] BiocBaseUtils_1.12.0        SparseArray_1.10.0
##  [19] mzID_1.48.0                 sass_0.4.10
##  [21] bslib_0.9.0                 htmlwidgets_1.6.4
##  [23] plyr_1.8.9                  sandwich_3.1-1
##  [25] impute_1.84.0               zoo_1.8-14
##  [27] cachem_1.1.0                igraph_2.2.1
##  [29] mime_0.13                   lifecycle_1.0.4
##  [31] iterators_1.0.14            pkgconfig_2.0.3
##  [33] Matrix_1.7-4                R6_2.6.1
##  [35] fastmap_1.2.0               shiny_1.11.1
##  [37] clue_0.3-66                 fdrtool_1.2.18
##  [39] digest_0.6.37               pcaMethods_2.2.0
##  [41] colorspace_2.1-2            Spectra_1.20.0
##  [43] labeling_0.4.3              abind_1.4-8
##  [45] compiler_4.5.1              withr_3.0.2
##  [47] doParallel_1.0.17           S7_0.2.0
##  [49] BiocParallel_1.44.0         hexbin_1.28.5
##  [51] MASS_7.3-65                 DelayedArray_0.36.0
##  [53] rjson_0.2.23                mzR_2.44.0
##  [55] tools_4.5.1                 PSMatch_1.14.0
##  [57] otel_0.2.0                  httpuv_1.6.16
##  [59] glue_1.8.0                  QFeatures_1.20.0
##  [61] promises_1.4.0              grid_4.5.1
##  [63] cluster_2.1.8.1             reshape2_1.4.4
##  [65] gtable_0.3.6                tzdb_0.5.0
##  [67] preprocessCore_1.72.0       hms_1.1.4
##  [69] MetaboCoreUtils_1.18.0      utf8_1.2.6
##  [71] XVector_0.50.0              ggrepel_0.9.6
##  [73] foreach_1.5.2               pillar_1.11.1
##  [75] stringr_1.5.2               limma_3.66.0
##  [77] later_1.4.4                 circlize_0.4.16
##  [79] gmm_1.9-1                   lattice_0.22-7
##  [81] tidyselect_1.2.1            ComplexHeatmap_2.26.0
##  [83] knitr_1.50                  gridExtra_2.3
##  [85] bookdown_0.45               ProtGenerics_1.42.0
##  [87] imputeLCMD_2.1              xfun_0.53
##  [89] shinydashboard_0.7.3        statmod_1.5.1
##  [91] MSnbase_2.36.0              DT_0.34.0
##  [93] stringi_1.8.7               lazyeval_0.2.2
##  [95] yaml_2.3.10                 evaluate_1.0.5
##  [97] codetools_0.2-20            MsCoreUtils_1.22.0
##  [99] tibble_3.3.0                BiocManager_1.30.26
## [101] cli_3.6.5                   affyio_1.80.0
## [103] xtable_1.8-4                jquerylib_0.1.4
## [105] dichromat_2.0-0.1           Rcpp_1.1.0
## [107] norm_1.0-11.1               png_0.1-8
## [109] XML_3.99-0.19               parallel_4.5.1
## [111] readr_2.1.5                 assertthat_0.2.1
## [113] AnnotationFilter_1.34.0     mvtnorm_1.3-3
## [115] scales_1.4.0                tmvtnorm_1.7
## [117] affy_1.88.0                 ncdf4_1.24
## [119] crayon_1.5.3                GetoptLong_1.0.5
## [121] rlang_1.1.6                 vsn_3.78.0
```