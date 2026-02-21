# **MSstats+: Peak quality-weighted differential analysis**

Author: Devon Kohler

`MSstats+` is an extension to the `MSstats` R package in Bioconductor. It is
designed to incorporate the underlying spectral peak quality into differential
analysis, going beyond peak intensity alone. It integrates the underlying
spectral peaks using an isolation forest (iForest) for anomaly detection, which
integrates all the peak quality metrics into a single score. This score is then
used a weight in protein-level summarization. After
protein-level summarization, the estimates of underlying protein abundance and
their associated variance are used as weights in a second weighted
linear model which is used to perform differential analysis. The models can be
applied to experiments with simple group comparison designs, or more complex designs
(e.g. comparing more than two experimental conditions, or a repeated measure
design, such as a time course).

The algorithm is designed to be used with data acquired using data independent
acquisition (DIA). Other acquisitions are possible but have yet to be tested.
For guidance on how to use `MSstats+` with other acquisitions, please reach out
on the `MSstats` Google Group: \url{[https://groups.google.com/g/msstats}](https://groups.google.com/g/msstats%7D).

Below we outline the workflow for using `MSstats+`, highlighting key options
and decisions.

## Load packages

```
library(MSstats)
library(MSstatsConvert)
library(data.table)
library(ggplot2)
```

## Converter

The main iForest algorithm for `MSstats+` is implemented in the `MSstatsConvert`
package (a dependency of `MSstats`). The `MSstatsConvert` package contains
individual converters for each spectral processing tool. Currently, `MSstats+`
only has a dedicated converter for `Spectronaut`, however more converters are
in development and can be implemented manually (see below), For integration with
other tools, please reach out on the `MSstats` Google Group: \url{[https://groups.google.com/g/msstats}](https://groups.google.com/g/msstats%7D).

### Load data

First we will load the Spectronaut report of identified and quantified peaks. It
is necessary that users output the spectral peak quality data along with
these peaks. These spectral peak quality metrics must be at least at the
precursor-level (i.e., the column headers must not start with `F.`). There are
multiple options for columns that can be extracted, some
examples include: `FG.ShapeQualityScore (MS1)`, `FG.ShapeQualityScore (MS2)`,
and `EG.DeltaRT`. Users can include as many quality metrics as they want,
however we recommend using only quality metrics that are key indicators of the
quality of a spectral peak. Including too many quality metrics may lead to
the iForest model fitting noise. We include additional functionality to assess the
performance of the model (discussed below).

An example output from Spectronaut is included in the
`MSstatsConvert` package to provide an idea of what the input should look like.

In addition to the Spectronaut output, `MSstats+` also requires an annotation
file which maps the MS run names to the corresponding experimental design. For
more details on creating an annotation file, please see the documentation in
standard `MSstats` and the associated publications.

Finally, `MSstats+` also requires the temporal order of MS run acquisition to
identify time-based drops in quality. This can be extracted from the Spectronaut
output as shown below.

```
# Spectronaut quant file
spectronaut_raw = system.file(
    "tinytest/raw_data/Spectronaut/spectronaut_quality_input.csv",
    package = "MSstatsConvert")
spectronaut_raw = data.table::fread(spectronaut_raw)

# Annotation file
annotation = system.file(
    "tinytest/raw_data/Spectronaut/annotation.csv",
    package = "MSstatsConvert")
annotation = data.table::fread(annotation)

# Create temporal run ordering data.table
spectronaut_raw[, `R.Run Date (Formatted)` := as.POSIXct(
    `R.Run Date (Formatted)`, format = "%m/%d/%Y %I:%M:%S %p")]
run_order = unique(spectronaut_raw[, c("R.Run Date (Formatted)",
                                       "R.FileName")])
run_order = run_order[order(`R.Run Date (Formatted)`)]
run_order$Order = 1:nrow(run_order)
setnames(run_order, c("R.FileName"), c("Run"))
```

### Run converter

`MSstats+` uses the same converter as base `MSstats`. New parameters have been
added to indicate if a user wants to leverage the functionalities in `MSstats+`.
Specifically, to use `MSstats+`, users must indicate that the anomaly detection
algorithm should used by setting `calculateAnomalyScores=TRUE`.

An example specification of the converter can be seen below, with key parameter
options highlighted below the code.

```
msstats_input = MSstatsConvert::SpectronauttoMSstatsFormat(
    spectronaut_raw, annotation, intensity = 'PeakArea',
    excludedFromQuantificationFilter = TRUE, # Pre-filtering
    calculateAnomalyScores=TRUE, # Key parameter to use MSstats+
    anomalyModelFeatures=c("FGShapeQualityScore(MS2)",
                           "FGShapeQualityScore(MS1)",
                           "EGDeltaRT"), # Quality metrics
    anomalyModelFeatureTemporal=c(
        "mean_decrease", "mean_decrease",
        "dispersion_increase"), # Temporal direction of quality metrics
    runOrder=run_order, # Temporal order of MS runs
    n_trees=100,
    max_depth="auto", # iForest parameter (depth of trees)
    numberOfCores=1) # Cores to use for parallel processing (Mac or Linux only)
```

```
## INFO  [2026-01-22 19:03:53] ** Raw data from Spectronaut imported successfully.
## INFO  [2026-01-22 19:03:53] ** Raw data from Spectronaut cleaned successfully.
## INFO  [2026-01-22 19:03:53] ** Using provided annotation.
## INFO  [2026-01-22 19:03:53] ** Run labels were standardized to remove symbols such as '.' or '%'.
## INFO  [2026-01-22 19:03:53] ** The following options are used:
##   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
##   - Shared peptides will be removed.
##   - Proteins with single feature will not be removed.
##   - Features with less than 3 measurements across runs will be removed.
## INFO  [2026-01-22 19:03:53] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
## INFO  [2026-01-22 19:03:53] ** Features with all missing measurements across runs are removed.
## INFO  [2026-01-22 19:03:53] ** Shared peptides are removed.
## INFO  [2026-01-22 19:03:53] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
## INFO  [2026-01-22 19:03:53] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:53] ** Run annotation merged with quantification data.
## INFO  [2026-01-22 19:03:53] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:53] ** Fractionation handled.
## INFO  [2026-01-22 19:03:53] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2026-01-22 19:03:54] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
```

```
head(msstats_input)
```

```
##                             Run ProteinName PeptideSequence PrecursorCharge FragmentIon ProductCharge
##                          <char>      <char>          <char>           <int>      <char>         <int>
## 1: 20250102_Tulum_NeatK562_Seq1      Q9UFW8       AEFEEQNVR               2          y5             1
## 2: 20250102_Tulum_NeatK562_Seq1      Q9UFW8       AEFEEQNVR               2          y6             1
## 3: 20250102_Tulum_NeatK562_Seq1      Q9UFW8       AEFEEQNVR               2          y7             1
## 4: 20250102_Tulum_NeatK562_Seq2      Q9UFW8       AEFEEQNVR               2          y5             1
## 5: 20250102_Tulum_NeatK562_Seq2      Q9UFW8       AEFEEQNVR               2          y6             1
## 6: 20250102_Tulum_NeatK562_Seq2      Q9UFW8       AEFEEQNVR               2          y7             1
##    IsotopeLabelType  Condition BioReplicate Fraction Intensity AnomalyScores FGShapeQualityScore(MS2)
##              <char>     <char>        <int>    <int>     <num>         <num>                    <num>
## 1:                L Condition1           31        1  79.12771    0.02482253                0.5149927
## 2:                L Condition1           31        1  24.03648    0.02482253                0.5149927
## 3:                L Condition1           31        1 128.56342    0.02482253                0.5149927
## 4:                L Condition1           37        1  76.65041    0.01170805                0.5705628
## 5:                L Condition1           37        1  80.78468    0.01170805                0.5705628
## 6:                L Condition1           37        1 143.93866    0.01170805                0.5705628
##    FGShapeQualityScore(MS1)   EGDeltaRT FGShapeQualityScore(MS2).mean_decrease
##                       <num>       <num>                                  <num>
## 1:                0.5787569 -0.02157192                                      0
## 2:                0.5787569 -0.02157192                                      0
## 3:                0.5787569 -0.02157192                                      0
## 4:                0.3547189 -0.01764335                                      0
## 5:                0.3547189 -0.01764335                                      0
## 6:                0.3547189 -0.01764335                                      0
##    FGShapeQualityScore(MS1).mean_decrease EGDeltaRT.dispersion_increase
##                                     <num>                         <num>
## 1:                                      0                             0
## 2:                                      0                             0
## 3:                                      0                             0
## 4:                                      0                             0
## 5:                                      0                             0
## 6:                                      0                             0
```

Key parameters for `MSstats+`:

* `calculateAnomalyScores`: Set to `TRUE` to use the iForest algorithm to
  calculate anomaly scores for each spectral peak.
* `anomalyModelFeatures`: A character vector of the column names of the quality
  metrics to be used in the iForest model. These must be at the precursor-level
  or higher (i.e., the column headers must not start with `F.`).
* `anomalyModelFeatureTemporal`: A character vector of the same length as
  `anomalyModelFeatures` indicating the temporal direction of each quality
  metric.9 Possible values are `mean_decrease`, `mean_increase`, and
  `dispersion_increase`. These indicate the direction a metric is changes which
  indicates a drop in quality (i.e., decrease, increase, or can go in either
  direction). For example, `EG.DeltaRT` uses `dispersion_increase` because a
  deviation in expected retention can be either higher or lower.
* `runOrder`: A data.table with two columns: `R.FileName` and `Order`. The
  `R.FileName` column should contain the MS run names as they appear in the
  annotation file, and the `Order` column should contain the temporal order of
  acquisition (1 being the first run acquired, 2 being the second, etc.). This
  is used to identify time-based drops in quality.
* `n_trees`: The number of trees to use in the iForest. Default is 100. Too few
  trees will make the algorithm unstable, while too many trees will increase
  computation time without performance improvement.
* `max_depth`: The maximum depth of each tree in the iForest. Default is
  `"auto"`, which sets the depth to `ceiling(log2(number of samples))`.
* `numberOfCores`: The number of cores to use for parallel processing. This is
  recommended since the algorithm is fit on the precursor-level and can take
  significant time to process if using a single core. Only available on Mac and
  Linux.

### Check model fit

After running the converter, it is important to check the fit of the iForest.
The iForest is an unsupervised algorithm, so there is no ground truth to compare
to. However, we can check the distribution of the anomaly scores to ensure that
the model is performing as expected. The anomaly scores should be right-skewed,
with most of the scores being low (indicating normal peaks) and a small number
of scores being high (indicating anomalous peaks). If the distribution is not
right-skewed, it may indicate that the quality metrics used are not appropriate,
or that there are not many poor quality peaks (generally found in smaller
studies using less complex biological material). In these cases, it may make
sense to use base `MSstats` instead of `MSstats+`.

The fit of the model can be evaluated using the `CheckDataHealth` function in `MSstatsConvert`. This function will calculate Pearson’s moment coefficient of
skewness for each iForest model fit (each precursor). We recommend plotting
these coefficients using a histogram and confirming the distribution is positive
and shifted away from zero (with a median around 1).

An example of how to use the function is shown below.

```
health_info = CheckDataHealth(msstats_input)
```

```
## INFO  [2026-01-22 19:03:54] 16.88% of the values are missing across all intensities
## INFO  [2026-01-22 19:03:54] Intensity distribution standard truncated data.
## INFO  [2026-01-22 19:03:54] 100% of features have a ratio of standard deviation to mean > 0.5. A high value here could indicate problematic measurements.
## INFO  [2026-01-22 19:03:54] 5.48% of all measured intensities fall within the outlier range
## INFO  [2026-01-22 19:03:54] 0% of features are missing in more than half the runs. These features may need to be removed.
```

```
skew_score = health_info[[2]]

ggplot(skew_score, aes(x = skew)) +
  geom_histogram(fill = "#E69F00", color = "black", bins=12) +
  geom_vline(xintercept = 0, linetype = "dashed",
             color = "black", linewidth = 1.5) +
  theme_minimal(base_size = 16) +
  labs(
    title="Distribution of skewness of anomaly scores",
    x = "Pearson's moment coefficient of skewness",
    y = "Count"
  ) +
  theme(
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 16),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  )
```

![plot of chunk unnamed-chunk-4](data:image/png;base64...)

We can see in the example data that the distribution is shifted right away from
zero. This indicates that the anomaly model was able to detect poor quality
measurements and the user can proceed with the next step.

## Manual formatting and data conversion

The `MSstatsConvert` package includes an automatic `MSstats+` converter for
Spectronaut, however other tools require manual formatting. This can be done by
leveraging the existing `MSstats` converters, joining the quality metrics, and
running the anomaly model separately. An example workflow is included below.

```
# Extract quality metrics from PSM output
quality_join_cols = c("R.FileName", "PG.ProteinGroups", "EG.ModifiedSequence",
                      "FG.Charge", "FG.ShapeQualityScore (MS1)",
                      "FG.ShapeQualityScore (MS2)", "EG.DeltaRT")
quality_join_df = spectronaut_raw[, ..quality_join_cols]
quality_join_df$EG.ModifiedSequence = stringr::str_replace_all(
    quality_join_df$EG.ModifiedSequence, "\\_", "")
quality_join_df = unique(quality_join_df)

# In case there are duplicates (not common)
quality_join_df = quality_join_df[
  , lapply(.SD, mean, na.rm = TRUE),
  by = .(R.FileName, PG.ProteinGroups, EG.ModifiedSequence, FG.Charge),
  .SDcols = c("FG.ShapeQualityScore (MS1)",
              "FG.ShapeQualityScore (MS2)",
              "EG.DeltaRT")
]

# Extract run order
spectronaut_raw[, `R.Run Date (Formatted)` := as.POSIXct(
    `R.Run Date (Formatted)`, format = "%m/%d/%Y %I:%M:%S %p")]
run_order = unique(spectronaut_raw[, c("R.Run Date (Formatted)",
                                       "R.FileName")])
run_order = run_order[order(`R.Run Date (Formatted)`)]
run_order$Order = 1:nrow(run_order)
setnames(run_order, c("R.FileName"), c("Run"))

# Run standard MSstats converter without anomaly detection
msstats_input = MSstatsConvert::SpectronauttoMSstatsFormat(
    spectronaut_raw, annotation, intensity = 'PeakArea',
    excludedFromQuantificationFilter = TRUE, # Pre-filtering
    calculateAnomalyScores=FALSE) # Turn anomaly detection off
```

```
## INFO  [2026-01-22 19:03:55] ** Raw data from Spectronaut imported successfully.
## INFO  [2026-01-22 19:03:55] ** Raw data from Spectronaut cleaned successfully.
## INFO  [2026-01-22 19:03:55] ** Using provided annotation.
## INFO  [2026-01-22 19:03:55] ** Run labels were standardized to remove symbols such as '.' or '%'.
## INFO  [2026-01-22 19:03:55] ** The following options are used:
##   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
##   - Shared peptides will be removed.
##   - Proteins with single feature will not be removed.
##   - Features with less than 3 measurements across runs will be removed.
## INFO  [2026-01-22 19:03:55] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
## INFO  [2026-01-22 19:03:55] ** Features with all missing measurements across runs are removed.
## INFO  [2026-01-22 19:03:55] ** Shared peptides are removed.
## INFO  [2026-01-22 19:03:55] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
## INFO  [2026-01-22 19:03:55] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:55] ** Run annotation merged with quantification data.
## INFO  [2026-01-22 19:03:55] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:55] ** Fractionation handled.
## INFO  [2026-01-22 19:03:55] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2026-01-22 19:03:55] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
```

```
# Join in quality metrics
msstats_input = merge(as.data.table(msstats_input),
                      as.data.table(quality_join_df),
                      all.x=TRUE, all.y=FALSE,
                      by.x=c("Run", "ProteinName", "PeptideSequence",
                             "PrecursorCharge"),
                      by.y=c("R.FileName", "PG.ProteinGroups",
                             "EG.ModifiedSequence", "FG.Charge"))

# Run Anomaly Model separately
input = MSstatsConvert::MSstatsAnomalyScores(
    msstats_input,
    c("FG.ShapeQualityScore (MS1)", "FG.ShapeQualityScore (MS2)", "EG.DeltaRT"),
    c("mean_decrease", "mean_decrease", "dispersion_increase"),
    .5, 100, run_order, 100, "auto", 1)
```

The resulting data can now be passed into the remaining `MSstats+` workflow as
listed below.

## Data processing and summarization

After running the converter with `MSstats+` options enabled, the next step is to
run the standard `MSstats` `dataProcess` function. This function will
automatically leverage the information from the `MSstats+` option, as long as
the linear summarization option is turned on. The code to do this is highlighted
below.

```
summarized = dataProcess(msstats_input,
                         normalization=FALSE, # no normalization
                         MBimpute=TRUE, # Use imputation
                         summaryMethod="linear" # Key MSstats+ parameter
                         )
```

```
## INFO  [2026-01-22 19:03:56] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:56] ** Fractionation handled.
## INFO  [2026-01-22 19:03:56] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2026-01-22 19:03:56] ** Log2 intensities under cutoff = 1.6097  were considered as censored missing values.
## INFO  [2026-01-22 19:03:56] ** Log2 intensities = NA were considered as censored missing values.
## INFO  [2026-01-22 19:03:56] ** Use top100 features that have highest average of log2(intensity) across runs.
## INFO  [2026-01-22 19:03:56]
##  # proteins: 3
##  # peptides per protein: 1-5
##  # features per peptide: 3-3
## INFO  [2026-01-22 19:03:56]
##                     Condition1 Condition2
##              # runs         20         20
##     # bioreplicates         20         20
##  # tech. replicates          1          1
## INFO  [2026-01-22 19:03:56] The following runs have more than 75% missing values: 3,
##  39
## INFO  [2026-01-22 19:03:56]  == Start the summarization per subplot...
##
  |
  |                                                                                                    |   0%
  |
  |=================================                                                                   |  33%
  |
  |===================================================================                                 |  67%
  |
  |====================================================================================================| 100%
## INFO  [2026-01-22 19:03:57]  == Summarization is done.
```

```
head(summarized$ProteinLevelData)
```

```
##   RUN Protein LogIntensities  Variance                   originalRUN      GROUP SUBJECT
## 1   2  Q96DR4       3.362811 0.1989436 20250102_Tulum_1to2K562_Seq32 Condition1      15
## 2   4  Q96DR4       3.409740 0.1989436 20250102_Tulum_1to4K562_Seq34 Condition1      22
## 3   5  Q96DR4       1.630112 0.1989436 20250102_Tulum_1to8K562_Seq36 Condition1      25
## 4   6  Q96DR4       4.306031 0.1989436  20250102_Tulum_NeatK562_Seq1 Condition1      31
## 5   7  Q96DR4       2.084798 0.1989436 20250102_Tulum_NeatK562_Seq10 Condition1      32
## 6   8  Q96DR4       4.026494 0.1989436 20250102_Tulum_NeatK562_Seq11 Condition1      33
##   TotalGroupMeasurements NumMeasuredFeature MissingPercentage more50missing NumImputedFeature
## 1                     60                  3         0.0000000         FALSE                 0
## 2                     60                  2         0.3333333         FALSE                 1
## 3                     60                  1         0.6666667          TRUE                 2
## 4                     60                  3         0.0000000         FALSE                 0
## 5                     60                  3         0.0000000         FALSE                 0
## 6                     60                  3         0.0000000         FALSE                 0
```

Key parameters for `MSstats+`:

* `summaryMethod`: Set to `linear` to use the peak quality-weighted linear
  regression summarization. This is a key parameter for `MSstats+`. Other
  summarization methods (e.g., Tukey’s median polish) will not leverage the
  peak quality information.

When the `dataProcess` function is run with `summaryMethod=linear` a new column
will be included called `Variance` indicating the variance of the underlying
protein abundance estimate. This variance is used in the next step of the
workflow.

Meanwhile, one can generate a profile plot to visualize the variance of the underlying protein abundance estimates in the form of 95% confidence intervals. For example, with Q9UFW8, one may observe that confidence intervals are wider for runs with more imputed values.

```
dataProcessPlots(summarized, "ProfilePlot", which.Protein = "Q9UFW8", address = FALSE)
```

```
##
  |
  |                                                                                                    |   0%
  |
  |====================================================================================================| 100%
```

![plot of chunk unnamed-chunk-7](data:image/png;base64...)

```
##
##
  |
  |                                                                                                    |   0%
```

![plot of chunk unnamed-chunk-7](data:image/png;base64...)

```
##
  |
  |====================================================================================================| 100%
```

## Differential analysis

The final step of the `MSstats+` workflow is to perform differential analysis.
This is done using the standard `groupComparison` function in `MSstats`. Similar
to the `dataProcess` function, the `groupComparison` function will automatically
leverage the information from the `MSstats+` option. The code to do this is highlighted below.

```
comparison = matrix(c(-1,1),nrow=1)
row.names(comparison) = "Condition2-Condition1"
colnames(comparison) = c("Condition1", "Condition2")

comparison_result = groupComparison(
    contrast.matrix = comparison,
    data=summarized)
```

```
## INFO  [2026-01-22 19:03:59]  == Start to test and get inference in whole plot ...
##
  |
  |                                                                                                    |   0%
  |
  |=================================                                                                   |  33%
  |
  |===================================================================                                 |  67%
  |
  |====================================================================================================| 100%
## INFO  [2026-01-22 19:03:59]  == Comparisons for all proteins are done.
```

```
head(comparison_result$ComparisonResult)
```

```
##   Protein                 Label     log2FC        SE    Tvalue DF      pvalue  adj.pvalue issue
## 1  Q96DR4 Condition2-Condition1 -0.7772097 0.2420924 -3.210385 33 0.002951009 0.008853028    NA
## 2  Q96S19 Condition2-Condition1 -0.8206449 0.4087581 -2.007654 37 0.052024697 0.054104875    NA
## 3  Q9UFW8 Condition2-Condition1 -1.0176838 0.5120332 -1.987535 38 0.054104875 0.054104875    NA
##   MissingPercentage ImputationPercentage
## 1         0.3583333            0.2333333
## 2         0.3854167            0.3604167
## 3         0.1100000            0.1100000
```

The `groupComparison` function is run the exact same in `MSstats+` as `MSstats`,
but under the hood the variation from the previous step is used in a second
weighted linear regression (in comparison to the unweighted version in
`MSstats`).

## Compare results to base `MSstats`

```
base_msstats_input = MSstatsConvert::SpectronauttoMSstatsFormat(
    spectronaut_raw, annotation, intensity = 'PeakArea',
    excludedFromQuantificationFilter = TRUE, # Pre-filtering
    calculateAnomalyScores=FALSE) # No anomaly model
```

```
## INFO  [2026-01-22 19:03:59] ** Raw data from Spectronaut imported successfully.
## INFO  [2026-01-22 19:03:59] ** Raw data from Spectronaut cleaned successfully.
## INFO  [2026-01-22 19:03:59] ** Using provided annotation.
## INFO  [2026-01-22 19:03:59] ** Run labels were standardized to remove symbols such as '.' or '%'.
## INFO  [2026-01-22 19:03:59] ** The following options are used:
##   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
##   - Shared peptides will be removed.
##   - Proteins with single feature will not be removed.
##   - Features with less than 3 measurements across runs will be removed.
## INFO  [2026-01-22 19:03:59] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
## INFO  [2026-01-22 19:03:59] ** Features with all missing measurements across runs are removed.
## INFO  [2026-01-22 19:03:59] ** Shared peptides are removed.
## INFO  [2026-01-22 19:03:59] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
## INFO  [2026-01-22 19:03:59] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:59] ** Run annotation merged with quantification data.
## INFO  [2026-01-22 19:03:59] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:03:59] ** Fractionation handled.
## INFO  [2026-01-22 19:03:59] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2026-01-22 19:03:59] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
```

```
base_summarized = dataProcess(base_msstats_input,
                         normalization=FALSE, # no normalization
                         MBimpute=TRUE, # Use imputation
                         summaryMethod="TMP" # Tukey median polish summarization
                         )
```

```
## INFO  [2026-01-22 19:03:59] ** Log2 intensities under cutoff = 1.6097  were considered as censored missing values.
## INFO  [2026-01-22 19:03:59] ** Log2 intensities = NA were considered as censored missing values.
## INFO  [2026-01-22 19:03:59] ** Use top100 features that have highest average of log2(intensity) across runs.
## INFO  [2026-01-22 19:03:59]
##  # proteins: 3
##  # peptides per protein: 1-5
##  # features per peptide: 3-3
## INFO  [2026-01-22 19:03:59]
##                     Condition1 Condition2
##              # runs         20         20
##     # bioreplicates         20         20
##  # tech. replicates          1          1
## INFO  [2026-01-22 19:03:59] The following runs have more than 75% missing values: 3,
##  39
## INFO  [2026-01-22 19:03:59]  == Start the summarization per subplot...
##
  |
  |                                                                                                    |   0%
  |
  |=================================                                                                   |  33%
  |
  |===================================================================                                 |  67%
  |
  |====================================================================================================| 100%
## INFO  [2026-01-22 19:03:59]  == Summarization is done.
```

```
base_comparison_result = groupComparison(
    contrast.matrix = comparison,
    data=base_summarized)
```

```
## INFO  [2026-01-22 19:03:59]  == Start to test and get inference in whole plot ...
##
  |
  |                                                                                                    |   0%
  |
  |=================================                                                                   |  33%
  |
  |===================================================================                                 |  67%
  |
  |====================================================================================================| 100%
## INFO  [2026-01-22 19:03:59]  == Comparisons for all proteins are done.
```

```
head(base_comparison_result$ComparisonResult)
```

```
##   Protein                 Label     log2FC        SE    Tvalue DF      pvalue adj.pvalue issue
## 1  Q96DR4 Condition2-Condition1 -0.9356333 0.2912517 -3.212457 33 0.002934893 0.00880468    NA
## 2  Q96S19 Condition2-Condition1 -0.8648916 0.4144781 -2.086701 37 0.043862456 0.06579368    NA
## 3  Q9UFW8 Condition2-Condition1 -0.9715015 0.5381389 -1.805299 38 0.078955739 0.07895574    NA
##   MissingPercentage ImputationPercentage
## 1         0.3583333            0.2333333
## 2         0.3854167            0.3604167
## 3         0.1100000            0.1100000
```

We can see that `MSstats` does not identify all the proteins as differentially abundant, even though there was a true log$\_2$ fold change of -1. We can compare the fold change and standard error estimates between `MSstats+` and base `MSstats` to see why the p-values are different.

```
comparison_result$ComparisonResult$Model = "MSstats+"
base_comparison_result$ComparisonResult$Model = "MSstats"

merged_results = rbindlist(list(
    comparison_result$ComparisonResult,
    base_comparison_result$ComparisonResult
))

ggplot(data=merged_results) +
    geom_col(aes(x=Protein, y=abs(log2FC), fill=Model), position="dodge") +
    geom_hline(yintercept=1, linetype="dashed", color="black", linewidth=1) +
    theme_bw(base_size =16) +
    labs(title="Log fold change comparison",
         x="MSstats+",
         y="Base MSstats")
```

![plot of chunk unnamed-chunk-10](data:image/png;base64...)

The fold changes are both near the ground truth and `MSstats+` does not clearly outperform base `MSstats`.

```
ggplot(data=merged_results) +
    geom_col(aes(x=Protein, y=SE, fill=Model), position="dodge") +
    theme_bw(base_size =16) +
    labs(title="Standard error comparison",
         x="MSstats+",
         y="Base MSstats")
```

![plot of chunk unnamed-chunk-11](data:image/png;base64...)

We can see the advantage of `MSstats+` in the standard error estimates. `MSstats+` downweights poorly quantified measurements and runs, which can lead to much better estimates of the true standard error. In this example `MSstats+` downweighted the runs which added a large amount of uncertainty, leading to it identifying all proteins as differentially abundant.

## MSstatsBig

MSstats+ can also be used in conjunction with MSstatsBig to analyze large DIA
datasets. The workflow leverages the MSstatsBig converter and an external
execution of the MSstats+ isolation forest. An example of how to do this is
shown below.

This section of the vignette does not run automatically and must be executed
manually.

```
library(MSstatsBig)

# Define file path to data
spectronaut_raw = system.file(
    "tinytest/raw_data/Spectronaut/spectronaut_quality_input.csv",
    package = "MSstatsConvert")

# Run MSstatsBig converter
converted_data = bigSpectronauttoMSstatsFormat(
  input_file=spectronaut_raw,
  output_file_name="output_file.csv",
  intensity = "F.PeakHeight",
  filter_by_excluded = TRUE,
  filter_by_identified = FALSE,
  filter_by_qvalue = TRUE,
  qvalue_cutoff = 0.01,
  filter_unique_peptides = TRUE,
  aggregate_psms = TRUE,
  filter_few_obs = FALSE,
  remove_annotation = FALSE,
  calculateAnomalyScores=TRUE,
  anomalyModelFeatures=c("FG.ShapeQualityScore (MS1)",
                         "FG.ShapeQualityScore (MS2)",
                         "EG.ApexRT"),
  backend="arrow")
converted_data = dplyr::collect(converted_data)

# Prepare info for anomaly model
# Get temporal ordering from input file (can also be done externally)
temporal = fread(spectronaut_raw)[
    , .SD[1], by = .(`R.Run Date (Formatted)`, R.FileName)]

temporal = temporal[, Run.TimeParsed := as.POSIXct(
    `R.Run Date (Formatted)`, format = "%m/%d/%Y %I:%M:%S %p")][
  order(Run.TimeParsed)][
  , !"Run.TimeParsed"]

temporal$Order = 1:nrow(temporal)
temporal$Run = temporal$R.FileName
temporal = temporal[, c("Run", "Order")]

# Specify anomaly model parameters
anomalyModelFeatures=c("FG.ShapeQualityScore (MS2)",
                       "FG.ShapeQualityScore (MS1)",
                       "EG.ApexRT")
anomalyModelFeatures = MSstatsConvert:::.standardizeColnames(anomalyModelFeatures)

anomalyModelFeatureTemporal=c("mean_decrease",
                              "mean_decrease",
                              "dispersion_increase")

n_trees=100
max_depth="auto"
numberOfCores=1

# Run anomaly detection model
msstats_input = MSstatsConvert::MSstatsAnomalyScores(
  as.data.table(converted_data), anomalyModelFeatures,
  anomalyModelFeatureTemporal, .5, 100, temporal, n_trees,
  max_depth, numberOfCores)
head(msstats_input)
```

This code will run the MSstatsBig converter and then run the anomaly model. This
workflow leads to a much faster processing speed compared to using the standard
converter, and allows users to work with Spectronaut files which may be too
large to fit into memory. After running the anomaly model, the resulting data
can be input into the MSstats+ workflow reviewed previously.

One note here is the temporal ordering. In this example, we extracted the
temporal run order directly from the Spectronaut file. However, in practice this
may not be appropriate for big data files. In cases where the data is large,
this ordering should be extracted externally and provided by the user, or the
user should sample the Spectronaut file rather than load it all into memory.