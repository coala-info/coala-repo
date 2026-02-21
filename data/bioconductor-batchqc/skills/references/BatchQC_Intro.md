# Introduction to BatchQC

W. Evan Johnson1,2\* and Jessica McClintock1\*\*

1Division of Infectious Disease, Department of Medicine, Rutgers University
2Director, Center for Data Science, Rutgers University

\*wj183@njms.rutgers.edu
\*\*jessica.mcclintock@rutgers.edu

#### February 12, 2026

#### Package

BatchQC 2.6.1

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 Bioconductor Version](#bioconductor-version)
  + [2.2 Github Version](#github-version)
  + [2.3 Load BatchQC and Launch Shiny App](#load-batchqc-and-launch-shiny-app)
* [3 Example Usage](#example-usage)
  + [3.1 1. Upload data set](#upload-data-set)
  + [3.2 2. Normalization/Batch Correction/Data Distribution Check](#normalizationbatch-correctiondata-distribution-check)
    - [3.2.1 Data Distribution Check (only available for whole number data, like counts)](#data-distribution-check-only-available-for-whole-number-data-like-counts)
    - [3.2.2 Apply Normalization methods](#apply-normalization-methods)
    - [3.2.3 Apply Batch Effect Correction](#apply-batch-effect-correction)
  + [3.3 3. Experimental Design](#experimental-design)
    - [3.3.1 Batch Design](#batch-design)
    - [3.3.2 Confounding Statistics](#confounding-statistics)
  + [3.4 4. Variation Analysis](#variation-analysis)
  + [3.5 5. kBET](#kbet)
  + [3.6 6. Visualizations](#visualizations)
    - [3.6.1 Heatmaps](#heatmaps)
    - [3.6.2 Dendrograms](#dendrograms)
    - [3.6.3 PCA Analysis](#pca-analysis)
    - [3.6.4 UMAP Analysis](#umap-analysis)
  + [3.7 7. Differential Expression Analysis](#differential-expression-analysis)
    - [3.7.1 Volcano Plot](#volcano-plot)
  + [3.8 8. Data Download](#data-download)
* [4 Conclusion](#conclusion)
* [Session info](#session-info)

# 1 Introduction

Sequencing and microarray samples are often collected or processed in multiple
batches or at different times. This often produces technical biases that can
lead to incorrect results in the downstream analysis. BatchQC is a software tool
that streamlines batch preprocessing and evaluation by providing shiny app
interactive diagnostics, visualizations, and statistical analyses to explore
the extent to which batch variation impacts the data. This is contained in a
full R package which allows reproducibility of all shiny evaluations and
analyses. BatchQC diagnostics help determine whether batch adjustment needs to
be done, and how correction should be applied before proceeding with a
downstream analysis. Moreover, BatchQC interactively applies multiple common
batch effect approaches to the data, and the user can quickly see the benefits
of each method. BatchQC is developed as a Shiny App, but is reproducible at the
command line through the functions contained in the R package. The output of the
shiny app is organized into multiple tabs, and each tab features an important
part of the batch effect analysis and visualization of the data. The BatchQC
interface has the following features:

1. Upload Data
2. Batch Correction/Normalization (can also check data distribution)
3. Experimental Design to view summary of data
4. Variation Analysis (including lambda statistic)
5. kBET
6. Numerous Visualization methods including:
   * Heatmap plot of gene expressions/Median Correlation Plot
   * Dendrograms
   * Principal Component Analysis (PCA)
   * Uniform Manifold Approximation and Projection (UMAP)
7. Differential Expression Analysis and Volcano Plot
8. Data Download to export any corrections or normalizations as an SE object

`BatchQC()` is the function that launches the Shiny App in interactive mode.

# 2 Installation

## 2.1 Bioconductor Version

To begin, install [Bioconductor](http://www.bioconductor.org/) and then install
BatchQC:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BatchQC")
```

## 2.2 Github Version

To install the most up-to-date version of BatchQC, please install directly from
GitHub. You will need the devtools package. You can install both of these with
the following commands:

```
if (!require("devtools", quietly = TRUE)) {
    install.packages("devtools")
}

library(devtools)
install_github("wejlab/BatchQC")
```

## 2.3 Load BatchQC and Launch Shiny App

You should now be able to load BatchQC and launch the shiny app.

```
library(BatchQC)
```

```
BatchQC()
```

# 3 Example Usage

Below is an example of how you may use the shiny app to analyze your data:

## 3.1 1. Upload data set

Upon launching the shiny app, you will be on the “Upload Data” screen. From
here, you may upload the following data:

1. **Your own data w/Count and Metadata file.** Count file should have sample
   ID as column and item of interest as row. Metadata should have sample ID as row
   and all meta data labeled in the column. Both files should be uploaded as .csv
   by selecting “Browse” and selecting the appropriate files from your computer.
2. **Your own data as a Summarized Experiment object.** Upload should be a .RDS
   file type and can be uploaded by selecting “Browse” and then the appropriate
   file from your computer
3. **An example data set.** See the examples vignette for additional
   information on each example data set

A preview of the selected data will show up under the “Input Summary” and “Full
Metadata” tab. Input summary shows the counts file/assay on the Input summary
tab and the metadata on the “Full Metadata” tab. If a preview does not load
as expected, please ensure your dataset is structured properly and a valid file
type.

**You MUST hit “Upload” for your data to be available to interact with the shiny
app.**

All shiny app functions can also be run from the command line; all command line
execution require that your data is in a Summarized Experiment object. You
can create a summarized experiment object from a features and metadata matrix.
This would be done as follows:

```
# Load package data examples
data(signature_data)
data(batch_indicator)

# Create SE Object
features <- signature_data
metadata <- batch_indicator
se_object <- BatchQC::summarized_experiment(features, metadata)

# Name your assay
SummarizedExperiment::assayNames(se_object) <- "log_intensity"

# Ensure all relevat metadata varaibles are factors
se_object$batch <- as.factor(se_object$batch)
se_object$condition <- as.factor(se_object$condition)
```

Likewise, you can upload your own data into a summarized experiment object for
use with command line functions by providing a data matrix and sample info
matrix to the summarized\_experiment function.

The remainder of this documentation will utilize the TB example data
set included in the package. This can be loaded from the command line as a
summarized experiment object with the following:

```
se_object <- tb_data_upload()
```

```
## Loading required namespace: curatedTBData
```

```
## Downloading: GSE152218
```

```
##
  |
  |                                                                      |   0%
  |
  |==============                                                        |  20%
  |
  |============================                                          |  40%
  |
  |==========================================                            |  60%
  |
  |========================================================              |  80%
  |
  |======================================================================| 100%
```

```
## Downloading: GSE101705
```

```
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
```

```
## Finished!
```

For ease of reference, we will also create variables to store the assay we are
interested in, the batch variable, and the covariable we are interested in.

```
assay_of_interest <- "features"
batch <- "Experiment"
covar <- "TBStatus"
```

## 3.2 2. Normalization/Batch Correction/Data Distribution Check

You may choose to use these tools in a different order, although we recommend
checking the distribution of your data before deciding the best batch
correction method. you may also choose to explore your raw data with the
various tools within BatchQC to confirm the presence of a batch effect prior
to applying a batch correction method. In this example, we have applied a batch
correction method based on the results of the distribution check, but you may
choose to do further analysis before selecting (a) (or even comparing) batch
correction method(s).

### 3.2.1 Data Distribution Check (only available for whole number data, like counts)

If you have raw count data, other data that is positive whole numbers, or can
provide a backwards compatible positive whole number dataset, you may use the
Negative Binomial Check and/or the AIC model to check the distribution of your
data to aid in making informed downstream analysis choices that are appropriate
for the distribution of your data.

These tools are found on the Batch Correction/Normalization tab as we recommend
utilizing these tools to inform your choice of batch correction method.

```
TB_AIC <- compute_aic(se = se_object,
    assay_of_interest = assay_of_interest,
    batchind = batch,
    groupind = covar,
    maxit = 1000,
    zero_filt_percent = 15
    )
```

```
## Warning in sqrt(1/i): NaNs produced
## Warning in sqrt(1/i): NaNs produced
```

```
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: algorithm did not converge
```

```
TB_AIC["total_AIC"]
```

```
## $total_AIC
##        NB_AIC Lognormal_AIC      Voom_AIC
##      18608300       4683916       3174420
```

```
TB_AIC["min_AIC"]
```

```
## $min_AIC
##        NB Lognormal      Voom
##         1     14109      3247
```

The lowest AIC score represented by “total\_AIC” indicates the model that is
likely the best fit. However, the voom/limma model often overfits the data, so
we also look at the “min\_AIC” parameter. The “min\_AIC” parameter is a count of
which distribution each individual gene fits best. Therefore, the model that
has the highest number is the model that we would recommend utilizing.

In this dataset the lowest “total\_AIC” is voom, followed by log
normal. Since limma often over corrects data, we can then look at “min\_AIC”
and it seems most genes fit a log normal distribution, so we should consider
using ComBat as our correction method.

We can further confirm that a negative binomial distribution is not a good fit
by running the DESeq2 negative binomial check.

```
# Set a seed if you would like reproducible results
set.seed(1)

TB_fit <- goodness_of_fit_DESeq2(se = se_object,
    count_matrix = assay_of_interest,
    condition = covar,
    other_variables = batch,
    num_genes = 3000)
```

```
## converting counts to integer mode
```

```
## estimating size factors
```

```
## estimating dispersions
```

```
## gene-wise dispersion estimates
```

```
## mean-dispersion relationship
```

```
## final dispersion estimates
```

```
## fitting model and testing
```

```
## -- replacing outliers and refitting for 447 genes
## -- DESeq argument 'minReplicatesForReplace' = 7
## -- original counts are preserved in counts(dds)
```

```
## estimating dispersions
```

```
## fitting model and testing
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the BatchQC package.
##   Please report the issue at <https://github.com/wejlab/BatchQC/issues>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
TB_fit$res_histogram
```

```
## `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
```

![](data:image/png;base64...)

```
TB_fit$recommendation
```

```
## [1] "With an adjusted FDR cut off of 0.05, 3 of your condition variable features are below the cutoff. If DESeq's assumptions are met, we would not expect to find any significant features. Since 3 features have a significant FDR, and 3 features have a significant pvalue (<0.05), therefore, we do not recommend that you should use DESeq2 for your analysis."
```

The recommendation states that DESeq is not a good option, therefore a negative
binomial distribution is not a good fit.

### 3.2.2 Apply Normalization methods

After you have successfully uploaded your data set of interest, you can apply
one of the following Normalization methods if appropriate:

1. **CPM or counts per million.** CPM calculates the counts mapped to a feature
   relative to the total counts mapped to a sample times one million. CPM may be
   used to adjust expression count biases introduced by sequencing depth. CPM
   adjusted values are not recommended for differential expression analysis or
   within sample comparison.
2. **DESeq.** DESeq calculates the counts mapped to a feature divided by sample-
   specific size factors. Size factors are determined by the median ratio of gene
   counts relative to the geometric mean per feature. DESeq may be used to adjust
   expression count biases introduced by sequencing depth and RNA composition.
   DESeq adjusted values are not recommended for within sample comparison.
3. **edgeR.** edgeR calculates scale factors using a trimmed mean of M-values
   between each pair of samples and multiplies the scale factors with the original
   library size to get the normalized library size. This normalization method
   should be selected when you plan to use edgeR for differential expression
   analysis. The original read (raw) counts should be the provided input for this
   normalization method.
4. **voom.** Voom calculates logCPM, estimates mean-variance relationship and
   uses this to compute observation-level weights. It is appropriate for count
   data that is to be used with limma batch correction.

To use one of these two methods, select it from the normalization method drop
down, select an assay to perform the normalization on from the drop down, and
name the new assay (the prepopulated name can be changed to your preference).
You may also choose to log-transform the results of either of these
normalization methods or your raw data by selecting the “Log transform” box. Hit
“Normalize” to complete the analysis. Your new assay will now be available for
further analysis.

Alternatively, this can be called directly from the command line on an SE
object and will return the same SE object with an additional assay with the name
that you provide as the output\_assay\_name.

Our TB data set is raw count data and to utilize ComBat we will need
normalized data. We will utilize log\_CPM normalized data for ComBat. However,
examples are provided below on how you would complete many different
normalization methods if needed via the command line:

```
# CPM Normalization
se_object <- BatchQC::normalize_SE(se = se_object, method = "CPM",
    log_bool = FALSE, assay_to_normalize = assay_of_interest,
    output_assay_name = "CPM_normalized_counts")

# CPM Normalization w/log
se_object <- BatchQC::normalize_SE(se = se_object, method = "CPM",
    log_bool = TRUE, assay_to_normalize = assay_of_interest,
    output_assay_name = "CPM_log_normalized_counts")

# DESeq Normalization
se_object <- BatchQC::normalize_SE(se = se_object, method = "DESeq",
    log_bool = FALSE, assay_to_normalize = assay_of_interest,
    output_assay_name = "DESeq_normalized_counts")

# DESeq Normalization w/log
se_object <- BatchQC::normalize_SE(se = se_object, method = "DESeq",
    log_bool = TRUE, assay_to_normalize = assay_of_interest,
    output_assay_name = "DESeq_log_normalized_counts")

# log adjust
se_object <- BatchQC::normalize_SE(se = se_object, method = "none",
    log_bool = TRUE, assay_to_normalize = assay_of_interest,
    output_assay_name = "log_normalized_counts")
```

### 3.2.3 Apply Batch Effect Correction

Select the appropriate Batch Effect correction model to create a batch-corrected
assay for your data. You may select one of the following:

1. **ComBat-Seq.** ComBat-Seq uses a negative binomial regression to model batch
   effects. It requires untransformed, raw count data to adjust for batch effect.
   Only use this model on an untransformed raw counts assay (not normalized
   assays).
2. **ComBat.** ComBat corrects for Batch effect using a parametric empirical
   Bayes framework and data should be cleaned and normalized. Select a normalized
   assay to run this on.
3. **limma.** limma fits a linear model to the data and then removes components
   due to batch effect. It should be used on log transformed data.
4. **sva** sva identifies and estimates surrogate variables for unknown sources
   of variation. It is appropriate when you know your experimental variable of
   interest (like the disease state of samples), but unknown sources of variation.
   It should be run on cleaned and log transformed data. This can be run with or
   without additional adjustment variables.
5. **svaseq** svaseq is a variant of sva specifically for sequencing data. Data
   should still be normalized.

To apply your desired batch effect correction model, select the method from the
drop down menu, then select the appropriate assay in the second drop down menu,
select your batch variable (typically labeled batch in built-in examples), and
the covariates that you would like to preserve (not including the batch
variable). If desired, revise the name for the corrected assay and then hit
“Correct.”

A progress bar will pop up in the bottom right hand corner and a message will
state “Correction Complete” in the bottom right hand corner when complete.

You are now ready to analyze your raw and batch effect corrected data sets!

The distribution analysis indicated that our TB data follows a log normal
distribution, so ComBat is likely an appropriate batch correction tool. We will
use the log-CPM assay since ComBat requires normalized data. Therefore, to run
from the command line use the following:

```
# ComBat correction
se_object <- BatchQC::batch_correct(se = se_object, method = "ComBat",
    assay_to_normalize = "CPM_log_normalized_counts", batch = batch,
    covar = c(covar), output_assay_name = "ComBat_corrected")
```

```
## Found 4182 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
```

```
## Found2batches
```

```
## Adjusting for1covariate(s) or covariate level(s)
```

```
## Standardizing Data across genes
```

```
## Fitting L/S model and finding priors
```

```
## Finding parametric adjustments
```

```
## Adjusting the Data
```

ComBat-Seq (or limma or sva or svaseq) can be applied to a data set by providing
“ComBat-Seq” (or “limma” or “sva” or “svaseq”) to the method parameter in the
function call.

## 3.3 3. Experimental Design

### 3.3.1 Batch Design

This tab allows you to view the batch status of each condition. Select the
variable that represents your batch variable and then select the variable that
represents the condition. A table will then appear listing each condition in the
row and how many samples in each condition are in each batch (displayed in the
columns).

To recreate this table, run the following code, which will produce a tibble
as output:

```
batch_design_tibble <- BatchQC::batch_design(se = se_object, batch = batch,
    covariate = covar)
batch_design_tibble
```

```
## # A tibble: 2 × 3
## # Groups:   TBStatus [2]
##   TBStatus GSE101705 GSE152218
##   <fct>        <int>     <int>
## 1 LTBI            15        32
## 2 PTB             28        16
```

### 3.3.2 Confounding Statistics

This tab displays the Pearson correlation coefficient and Cramer’s V estimation
based on the selected batch and condition.

This table can be recreated with the following code:

```
confound_table <- BatchQC::confound_metrics(se = se_object, batch = batch)
confound_table
```

```
##           Pearson Correlation Coefficient Cramer's V
## TBStatus                        0.4279870  0.3175219
## HIVStatus                             NaN        NaN
## BMI                             1.0000000  1.0000000
## BMIcat                          0.5898655  0.4589234
```

#### 3.3.2.1 Pearson Correlation Coefficient

Pearson correlation coefficient indicates the strength of the linear
relationship between your batch and condition variables. It can range from -1 to
1. The closer the value is to 0, the less likely there is a batch effect. The
closer the value is to -1 or 1, the more likely there is a batch effect.

To calculate only the pearson correlation coefficient, run the following:

```
pearson_cor_result <- BatchQC::std_pearson_corr_coef(batch_design_tibble)
pearson_cor_result
```

```
## [1] 0.427987
```

#### 3.3.2.2 Cramer’s V

This is an additional metric for batch effect and will be between 0 and 1. The
closer the value is to 0, the lower the batch effect. The closer the value is to
1, the greater the batch effect

To calculate only Cramer’s V, run the following:

```
cramers_v_result <- BatchQC::cramers_v(batch_design_tibble)
cramers_v_result
```

```
## [1] 0.3175219
```

If both the Pearson Correlation Coefficient and the Cramer’s V test indicate low
batch effect, you likely do not need to adjust your results for batch. However,
if one or both metrics indicate some or high batch effect, you should use
additional analysis tools (listed below) to explore the need for a batch
correction for your results.

## 3.4 4. Variation Analysis

First, select your unadjusted assay, your batch variable and any covariates of
interest. Click “Here we go!” to see the variation analysis results. The
“Individual Variable” tab shows the individual, or raw variation, explained
by each variable. The “Residual” tab displays the type 2, or residual, variation
for each variable. A box plot is displayed along with a table with the variation
specific to each gene listed. This table is searchable and can be displayed in
ascending or descending order. Notice the amount of variation attributed to
batch. In our signature data set, most of the variation is attributed to batch
rather than the condition. This indicates a need for a batch correction.

The “Individual Variation Variable/Batch Ratio” tab displays the individual, or
raw variation, divided by the batch. A ratio greater that 1 indicates that batch
has a stronger affect than the variable of interest. And the “Residual Variation
Variable/Batch Ratio” displays the residual, or type 2 variation, divided by the
batch. A ratio greater that 1 indicates that batch has a stronger affect than
the variable of interest.

Next, select the batch corrected assay, with the same batch and condition
variable and observe the changes in variation. When batch effect is being
properly corrected, you should notice that the variation explained by the batch
variable has decreased in the batch corrected assay, indicating that the
variation in the data is now more likely to be associated with your condition of
interest rather than the batch. The ratio statistics should also be less than 1.
This is visible in our example data set and confirms the need for batch
adjustment.

To recreate the variation analysis plot for the TB counts assay, use the
following code:

```
ex_variation <- batchqc_explained_variation(se = se_object,
    batch = batch, condition = covar, assay_name = assay_of_interest)
EV_boxplot <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[1]])
EV_boxplot
```

![](data:image/png;base64...)

```
EV_boxplot_type_2 <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[2]])
EV_boxplot_type_2
```

![](data:image/png;base64...)

To recreate the variation analysis table for the TB counts assay, use the
following code:

```
ex_variation <- batchqc_explained_variation(se = se_object,
    batch = batch, condition = covar, assay_name = assay_of_interest)
EV_table <- BatchQC::EV_table(batchqc_ev = ex_variation[[1]])
EV_table
```

```
##        Gene Name Explained Experiment TBStatus Unexplained
##           <char>     <num>      <num>    <num>       <num>
##     1:      A1BG     14.77       6.44     3.73       85.23
##     2:  A1BG-AS1     15.53       0.63    11.62       84.47
##     3:      A1CF      1.39       0.76     1.06       98.61
##     4:       A2M      1.15       1.12     0.26       98.85
##     5:   A2M-AS1     45.15      36.99     0.60       54.85
##    ---
## 33582:    ZYG11A      1.61       0.37     1.56       98.39
## 33583:  ZYG11AP1      3.35       2.25     2.16       96.65
## 33584:    ZYG11B     76.32      72.48     0.72       23.68
## 33585:       ZYX      3.67       0.04     3.50       96.33
## 33586:     ZZEF1     48.26      25.08     8.85       51.74
```

```
EV_table_type_2 <- BatchQC::EV_table(batchqc_ev = ex_variation[[2]])
EV_table_type_2
```

```
##        Gene Name Explained Experiment TBStatus Unexplained
##           <char>     <num>      <num>    <num>       <num>
##     1:      A1BG     14.77      11.04     8.33       85.23
##     2:  A1BG-AS1     15.53       3.91    14.90       84.47
##     3:      A1CF      1.39       0.33     0.63       98.61
##     4:       A2M      1.15       0.89     0.03       98.85
##     5:   A2M-AS1     45.15      44.54     8.16       54.85
##    ---
## 33582:    ZYG11A      1.61       0.05     1.24       98.39
## 33583:  ZYG11AP1      3.35       1.19     1.09       96.65
## 33584:    ZYG11B     76.32      75.60     3.83       23.68
## 33585:       ZYX      3.67       0.17     3.63       96.33
## 33586:     ZZEF1     48.26      39.41    23.18       51.74
```

We can then compare our batch corrected assay, using the following code:

```
ex_variation <- batchqc_explained_variation(se = se_object,
    batch = batch, condition = covar, assay_name = "ComBat_corrected")
EV_boxplot <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[1]])
EV_boxplot
```

![](data:image/png;base64...)

```
EV_boxplot_type_2 <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[2]])
EV_boxplot_type_2
```

![](data:image/png;base64...)

```
EV_table <- BatchQC::EV_table(batchqc_ev = ex_variation[[1]])
EV_table
```

```
##        Gene Name Explained Experiment TBStatus Unexplained
##           <char>     <num>      <num>    <num>       <num>
##     1:      A1BG     10.74       1.14    10.74       89.26
##     2:  A1BG-AS1     11.89       1.47    11.87       88.11
##     3:      A1CF      0.86       0.37     0.73       99.14
##     4:       A2M      1.13       0.13     1.13       98.87
##     5:   A2M-AS1     15.47       0.95    15.39       84.53
##    ---
## 33582:    ZYG11A      1.88       0.62     1.73       98.12
## 33583:  ZYG11AP1      3.14       2.11     2.02       96.86
## 33584:    ZYG11B      9.90       0.03     9.21       90.10
## 33585:       ZYX      2.36       0.07     2.31       97.64
## 33586:     ZZEF1     27.60       2.27    27.57       72.40
```

```
EV_table_type_2 <- BatchQC::EV_table(batchqc_ev = ex_variation[[2]])
EV_table_type_2
```

```
##        Gene Name Explained Experiment TBStatus Unexplained
##           <char>     <num>      <num>    <num>       <num>
##     1:      A1BG     10.74       0.00     9.60       89.26
##     2:  A1BG-AS1     11.89       0.02    10.42       88.11
##     3:      A1CF      0.86       0.13     0.49       99.14
##     4:       A2M      1.13       0.00     1.00       98.87
##     5:   A2M-AS1     15.47       0.08    14.52       84.53
##    ---
## 33582:    ZYG11A      1.88       0.15     1.26       98.12
## 33583:  ZYG11AP1      3.14       1.12     1.02       96.86
## 33584:    ZYG11B      9.90       0.69     9.87       90.10
## 33585:       ZYX      2.36       0.06     2.30       97.64
## 33586:     ZZEF1     27.60       0.03    25.33       72.40
```

## 3.5 5. kBET

To confirm the presence of batch effects in the simulated dataset, we use kBET,
a method that quantifies batch effects through a chi-square test. kBET works by
comparing the batch label distribution in each sample’s local neighborhood to
the global batch label distribution across the entire dataset. If these
distributions differ significantly, it indicates the presence of batch effects.

Below is how we would run the kBET analysis on the TB data set.

```
TB_kBET <- BatchQC::run_kBET(se = se_object,
    assay_to_normalize = assay_of_interest,
    batch = batch)

BatchQC::plot_kBET(TB_kBET)
```

![](data:image/png;base64...)

The boxplot shows that the observed rejection rate is significantly higher than
the expected rejection rate, indicating a strong batch effect in the TB dataset.

## 3.6 6. Visualizations

BatchQC contains a number of visualization methods that may help you identify a
batch effect (or to confirm that a batch effect has been removed).

### 3.6.1 Heatmaps

The heatmap tab contains options for a sample correlation heatmap or for a more
traditional heatmap comparing samples and genes. Select your assay of interest
and the batch and condition(s) of interest. We recommend viewing no more than
500 elements at a time (or the max number in your data set).

#### 3.6.1.1 Sample Correlations

This heat map shows how similar each sample is to each other sample in your
data (samples are plotted on both the x and y axis, so are identical to
their self). The samples are clustered together based on similarity. Ideally,
you would expect your samples to cluster and be more similar to samples from
the same condition rather than from the sample batch. If there is clear visual
clustering of the batch in your raw data, you should apply a batch correction
method. Your batch corrected assay should have stronger clustering by condition.

Using the TB dataset, we initially see clustering based on batch, but
after apply ComBat, our adjusted data set clusters more based on condition.

Use the following code to recreate the sample correlation heatmap:

```
heatmaps <- BatchQC::heatmap_plotter(se = se_object, assay = assay_of_interest,
    nfeature = 38, annotation_column = c(batch, covar),
    log_option = "FALSE")
correlation_heatmap <- heatmaps$correlation_heatmap
correlation_heatmap
```

![](data:image/png;base64...)

#### 3.6.1.2 Heatmap

The heatmap shoes the sample clustering on the x axis and the y axis is each
gene. The values on the heatmap represent gene expression. The dendrogram on the
x axis is the same clustering arrangement as was seen in the sample
correlations. This heatmap allows the viewer to see patterns of gene expression
across the samples based on the selected variables. Remember that if batch is
clustering together on your raw data, you should perform a batch effect
correction to adjust your data.

Use the following code to recreate the heatmap:

```
heatmaps <- BatchQC::heatmap_plotter(se = se_object, assay = assay_of_interest,
    nfeature = 38, annotation_column = c(batch, covar),
    log_option = FALSE)
heatmap <- heatmaps$topn_heatmap
heatmap
```

![](data:image/png;base64...)

### 3.6.2 Dendrograms

Within the dendrogram tab you can view either a traditional dendrogram or a
circular dendrogram.

#### 3.6.2.1 Dendrogram

This tab shows a more detailed dendrogram than seen in the heatmap. When samples
cluster together by batch, you are likely to have a strong batch effect in your
data and you should consider a batch correction method for your data. Samples
are clustered based on similarity of gene expression and other metadata using an
Euclidian distance metric. Labels will include the batch variable and one
covariate of interest.

Use the following code to recreate the dendrogram for the TB data set:

```
dendrogram_plot <- BatchQC::dendrogram_plotter(se = se_object,
    assay = assay_of_interest,
    batch_var = batch,
    category_var = covar)
```

```
## Coordinate system already present.
## ℹ Adding new coordinate system, which will replace the existing one.
```

```
dendrogram_plot$dendrogram
```

![](data:image/png;base64...)

#### 3.6.2.2 Circular Dendrogram

This circularizes the previous dendrogram to better show relatedness of all
branches on the dendrogram without the appearance of great distance of the
samples at the top and the bottom of the chart.

Use the following code to recreate the circular dendrogram:

```
circular_dendrogram_plot <- BatchQC::dendrogram_plotter(
    se = se_object, assay = assay_of_interest, batch_var = batch,
    category_var = covar)
```

```
## Coordinate system already present.
## ℹ Adding new coordinate system, which will replace the existing one.
```

```
circular_dendrogram_plot$circular_dendrogram
```

![](data:image/png;base64...)

### 3.6.3 PCA Analysis

You may select multiple assays to plot PCA analysis side by side. Therefore,
select your raw data assay and batch corrected assay, the batch variable as
shape, condition as color, and the number of top variable features you are
interested in. Review the clustering pattern. In data sets where a strong batch
effect is seen, similar shapes (batch) will all cluster together. Whereas if a
batch effect is not seen, shapes (batch) should be dispersed throughout and you
should see clustering by condition (color).

Use the following code to recreate the PCA plot and associated table that lists
the explained variation of each PC for our TB data set:

```
pca_plot <- BatchQC::PCA_plotter(se = se_object, nfeature = 20, color = batch,
    shape = covar, batch = batch,
    assays = c(assay_of_interest, "ComBat_corrected"),
    xaxisPC = 1, yaxisPC = 2, log_option = FALSE)
pca_plot$plot
```

```
## Warning: The following aesthetics were dropped during statistical transformation: shape.
## ℹ This can happen when ggplot fails to infer the correct grouping structure in
##   the data.
## ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
##   variable into a factor?
## The following aesthetics were dropped during statistical transformation: shape.
## ℹ This can happen when ggplot fails to infer the correct grouping structure in
##   the data.
## ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
##   variable into a factor?
```

![](data:image/png;base64...)

```
pca_plot$var_explained
```

```
##     features ComBat_corrected
## PC1  0.98677          0.55537
## PC2  0.00800          0.17098
```

### 3.6.4 UMAP Analysis

You may plot your data on a UMAP by selecting the assay, the batch variable, and
selecting a value for nearest neighbors and minimum distance for the points to
plot. The default for neighbors is 15 and minimum distance default is 0.1. We
expect each batch to cluster together when there is a batch effect present.
Otherwise, having dispersed points in each batch indicates there is not a strong
batch effect. You can adjust the nearest neighbor parameter, a lower value will
prioritize local structure and a higher value will represent bigger picture, but
lose finer details. A higher minimum distance value will also put less emphasis
on the global structure.

Use the following code to recreate the UMAP for the TB data set:

```
umap_plot <- BatchQC::umap(se = se_object,
    assay_of_interest = assay_of_interest, batch = batch, covar = covar,
    neighbors = 15, min_distance = 0.1, spread = 1)

umap_plot
```

![](data:image/png;base64...)

This code creates a UMAP for the batch corrected assay:

```
umap_plot_batch_corrected <- BatchQC::umap(se = se_object,
    assay_of_interest = "ComBat_corrected", batch = batch, covar = covar,
    neighbors = 15, min_distance = 0.1, spread = 1)

umap_plot_batch_corrected
```

![](data:image/png;base64...)

## 3.7 7. Differential Expression Analysis

To explore which features are differentially expressed between conditions, use
the differential expression tab. DE\_Seq2 should be used for count data
(non-negative, integer values) with a negative binomial distribution, edgeR can
be used for edgeR-normalized data, ANOVA can be used for normal-distributed
data, Kruskal-Wallis test can be used as a nonparametric equivalent of one-way
ANOVA, and limma can be used for all other data. edgeR implemented in BatchQC
uses glm quasi-likelihood F-tests to test for differential expression.

Our TB data is count data with a log normal distribution, so we will use limma.
We will select the assay we are interested in, select the batch variable and all
covariates that we would like to include in the analysis, and select a method to
adjust p-values. The “Results Table” return a table for each condition within
each variable. The results table displays the log2 fold change, p-value and
adjusted p-value for each feature. The “P-Value Analysis” tab displays a box
plot of p-values for each analysis. In both the “Results Table” and “P-Value
Analysis” tabs, the tables can be sorted by ascending or descending order of a
column of your choice. They are also searchable with the “Search” bar (which can
be helpful if you are interested in a specific feature or p-value threshold).

To run the limma differential expression analysis from the command line, run the
following code (which can be modified to run DESeq2 when appropriate by changing
the method argument to “DESeq2”):

```
differential_expression <- BatchQC::DE_analyze(se = se_object,
    method = "limma", batch = batch, conditions = c(covar),
    assay_to_analyze = assay_of_interest, padj_method = "BH")
```

After running the differential expression analysis, you can see all the
completed analysis by running this code:

```
names(differential_expression)
```

```
## [1] "(Intercept)"         "TBStatusPTB"         "ExperimentGSE152218"
```

You can then view the log2 fold change, p-value and adjusted p-value table for a
specific analysis of interest, by running the following:

```
head(differential_expression[["TBStatusPTB"]])
```

```
##         log2FoldChange       pvalue         padj
## GGA2       -1924.29097 5.592932e-17 1.270415e-12
## HIP1R      -1266.45296 7.565144e-17 1.270415e-12
## TTC9        -656.55235 3.717015e-16 4.161322e-12
## CARNS1      -278.81677 5.372133e-16 4.510712e-12
## LRIG1       -364.31449 1.518643e-15 9.872038e-12
## TRBJ1-4      -58.61267 1.773130e-15 9.872038e-12
```

After running a differential expression analysis, you may replicate the p-value
box plot and table from the command line by running the following code:

```
pval_plotter(differential_expression)
```

```
## Warning: `position_dodge()` requires non-overlapping x intervals.
```

![](data:image/png;base64...)

```
head(pval_summary(differential_expression))
```

```
##         (Intercept)  TBStatusPTB ExperimentGSE152218
## EIF1P7 1.820311e-54 5.592932e-17        2.022356e-52
## YIPF4  4.501172e-54 7.565144e-17        5.544681e-46
## RAB4B  1.071535e-52 3.717015e-16        2.052650e-41
## COX15  3.493950e-52 5.372133e-16        1.517725e-40
## LMO4   6.885670e-51 1.518643e-15        2.254907e-40
## LRRC57 1.306966e-50 1.773130e-15        1.006524e-39
```

### 3.7.1 Volcano Plot

The “Volcano Plot” is based on the limma or DESeq2 analysis results and must be
run after completing the differential expression analysis. You should select the
analysis result that you are interested in, specify the threshold for p-value
cut off (the default is 0.05), and the magnitude of expression change (the
shiny default is the average of the absolute value of the minimum and maximum
value in the data set). After clinking “Run,” a volcano plot will appear. All
values that are below the p-value threshold and exceed the set expression
change threshold will appear in red, indicating that these may be potential
features that differ between the conditions in that variable.

In a data set with a batch effect, you will likely see many significant values
in both your p-value analysis and in the volcano plot. When you apply a batch
correction analysis, you should see more significant values in your covariate
conditions than in your batch conditions and fewer significant values that meet
the volcano plot thresholds.

The volcano plot is interactive and you can select specific points to view the
feature information, log2fold change, and -log10(p-value).

To recreate the volcano plot for the “TBStatusPTB” assay (which you may change
by using any of the named results assays) differential expression result from
our uncorrected TB data , run the following code:

```
value <- round((max(abs(
    differential_expression[[length(differential_expression)]][, 1]))
    + min(
        abs(differential_expression[[length(differential_expression)]][, 1])))
    / 2)
volcano_plot(DE_results = differential_expression[["TBStatusPTB"]],
    pslider = 0.05,
    fcslider = value)
```

## 3.8 8. Data Download

You may download the data set that you have been working with int he shiny app,
including the assays you added in the “Normalization” or “Batch Effect
Correction” steps when you uploaded your data. A preview is provided that shows
the Summarized Experiment (SE) object, including the dimensions, metadata table,
assays, rownames and colNames.

Click the “Download” button and you can save this SE object to your computer for
additional analysis outside of the BatchQC shiny app. The object is saved as a
.RDS Summarized Experiment object in the folder of your choice. You should give
it a descriptive name (default is “se.RDS”).

If you run code from the command line according to the above instructions, all
assays will be saved to your original SE object and available for your use in
other applications. You may save it as an SE object by running the following:

```
file_location <- "location/to/save/object"

saveRDS(object = se_object, file = file_location)
```

# 4 Conclusion

Many of these analyses can be run again on the batch corrected assay to see
improvements in groupings based on your biological variable rather than the
batch effect.

# Session info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] Biobase_2.70.0      S4Vectors_0.48.0    BiocGenerics_0.56.0
## [4] generics_0.1.4      curatedTBData_2.6.0 BatchQC_2.6.1
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] shinythemes_1.2.0           splines_4.5.2
##   [3] later_1.4.5                 bitops_1.0-9
##   [5] filelock_1.0.3              tibble_3.3.1
##   [7] XML_3.99-0.22               lifecycle_1.0.5
##   [9] httr2_1.2.2                 edgeR_4.8.2
##  [11] lattice_0.22-9              MASS_7.3-65
##  [13] crosstalk_1.2.2             MultiAssayExperiment_1.36.1
##  [15] magrittr_2.0.4              limma_3.66.0
##  [17] plotly_4.12.0               sass_0.4.10
##  [19] rmarkdown_2.30              jquerylib_0.1.4
##  [21] yaml_2.3.12                 metapod_1.18.0
##  [23] httpuv_1.6.16               otel_0.2.0
##  [25] askpass_1.2.1               reticulate_1.44.1
##  [27] reader_1.0.6                DBI_1.2.3
##  [29] RColorBrewer_1.1-3          abind_1.4-8
##  [31] GenomicRanges_1.62.1        purrr_1.2.1
##  [33] rappdirs_0.3.4              sva_3.58.0
##  [35] IRanges_2.44.0              irlba_2.3.7
##  [37] genefilter_1.92.0           testthat_3.3.2
##  [39] pheatmap_1.0.13             umap_0.2.10.0
##  [41] RSpectra_0.16-2             annotate_1.88.0
##  [43] dqrng_0.4.1                 codetools_0.2-20
##  [45] DelayedArray_0.36.0         scuttle_1.20.0
##  [47] tidyselect_1.2.1            farver_2.1.2
##  [49] ScaledMatrix_1.18.0         matrixStats_1.5.0
##  [51] BiocFileCache_3.0.0         Seqinfo_1.0.0
##  [53] jsonlite_2.0.0              BiocNeighbors_2.4.0
##  [55] survival_3.8-6              tools_4.5.2
##  [57] ggnewscale_0.5.2            Rcpp_1.1.1
##  [59] glue_1.8.0                  SparseArray_1.10.8
##  [61] BiocBaseUtils_1.12.0        xfun_0.56
##  [63] mgcv_1.9-4                  DESeq2_1.50.2
##  [65] MatrixGenerics_1.22.0       dplyr_1.2.0
##  [67] withr_3.0.2                 BiocManager_1.30.27
##  [69] fastmap_1.2.0               bluster_1.20.0
##  [71] shinyjs_2.1.1               openssl_2.3.4
##  [73] caTools_1.18.3              digest_0.6.39
##  [75] rsvd_1.0.5                  R6_2.6.1
##  [77] mime_0.13                   gtools_3.9.5
##  [79] dichromat_2.0-0.1           RSQLite_2.4.6
##  [81] utf8_1.2.6                  tidyr_1.3.2
##  [83] data.table_1.18.2.1         FNN_1.1.4.1
##  [85] httr_1.4.7                  htmlwidgets_1.6.4
##  [87] S4Arrays_1.10.1             pkgconfig_2.0.3
##  [89] gtable_0.3.6                NCmisc_1.2.0
##  [91] blob_1.3.0                  S7_0.2.1
##  [93] SingleCellExperiment_1.32.0 XVector_0.50.0
##  [95] brio_1.1.5                  htmltools_0.5.9
##  [97] bookdown_0.46               scales_1.4.0
##  [99] tidyverse_2.0.0             blockmodeling_1.1.8
## [101] png_0.1-8                   scran_1.38.0
## [103] EBSeq_2.8.0                 ggdendro_0.2.0
## [105] knitr_1.51                  reshape2_1.4.5
## [107] nlme_3.1-168                curl_7.0.0
## [109] cachem_1.1.0                stringr_1.6.0
## [111] BiocVersion_3.22.0          KernSmooth_2.23-26
## [113] parallel_4.5.2              AnnotationDbi_1.72.0
## [115] pillar_1.11.1               grid_4.5.2
## [117] vctrs_0.7.1                 gplots_3.3.0
## [119] promises_1.5.0              BiocSingular_1.26.1
## [121] dbplyr_2.5.1                beachmat_2.26.0
## [123] xtable_1.8-4                cluster_2.1.8.2
## [125] evaluate_1.0.5              tinytex_0.58
## [127] magick_2.9.0                cli_3.6.5
## [129] locfit_1.5-9.12             compiler_4.5.2
## [131] rlang_1.1.7                 crayon_1.5.3
## [133] labeling_0.4.3              plyr_1.8.9
## [135] stringi_1.8.7               viridisLite_0.4.3
## [137] BiocParallel_1.44.0         Biostrings_2.78.0
## [139] lazyeval_0.2.2              Matrix_1.7-4
## [141] ExperimentHub_3.0.0         RcppEigen_0.3.4.0.2
## [143] bit64_4.6.0-1               ggplot2_4.0.2
## [145] KEGGREST_1.50.0             statmod_1.5.1
## [147] shiny_1.12.1                SummarizedExperiment_1.40.0
## [149] AnnotationHub_4.0.0         igraph_2.2.2
## [151] memoise_2.0.1               bslib_0.10.0
## [153] bit_4.6.0
```