# Introduction to the scFeatureFilter package

Angeles Arzalluz-Luque, Guillaume Devailly, Anagha Joshi

#### 2025-10-30

# Contents

* [1 Preamble](#preamble)
  + [1.1 Package aim](#package-aim)
  + [1.2 Method summary](#method-summary)
  + [1.3 Installation](#installation)
* [2 Integrated usage](#integrated-usage)
* [3 Detailed usage](#detailed-usage)
  + [3.1 Loading data](#loading-data)
  + [3.2 Binning data](#binning-data)
  + [3.3 Correlation of the bins](#correlation-of-the-bins)
  + [3.4 Choosing a threshold](#choosing-a-threshold)
  + [3.5 Working with SingleCellExperiment objects](#working-with-singlecellexperiment-objects)
* [4 Parameter values](#parameter-values)
  + [4.1 `max_zeros`](#max_zeros)
  + [4.2 `top_window_size`](#top_window_size)
  + [4.3 `other_window_size`](#other_window_size)
  + [4.4 `n_random`](#n_random)
  + [4.5 `threshold`](#threshold)

# 1 Preamble

## 1.1 Package aim

One of the steps in single cell RNA-seq analysis is the filtering of features (i.e. genes or transcripts)
to retain only the most expressed ones. This allows to focus on features less affected by technical
variations (relatively), and often increases the statistical power of the subsequent analyses.

This step is usually done by applying one or more arbitrary thresholds
(i.e. mean TPM > 1, retention of features
frequently detected across cells, etc.), or by using the data from spike-in RNA.
This package aims to help the threshold decision, especially
when spike-in controls are not available.

## 1.2 Method summary

Highly expressed features are less affected by technical variability than lowly expressed ones,
and thus capture biological information more successfully.
We propose to use highly expressed features as a reference to
to estimate the drowning of biological variation in bins
of features of decreasing expression.
In this scenario, it is expected that features from major transcription programs
will be correlated with each other across bins, unless the technical variation
component dominates the expression results.

One of the package’s first steps is to select this reference bin of features
(or ‘top window’ of features).
We propose to use the 100 features with the highest mean expression
across cells, and a reasonably low
fraction of drop-outs (zero-expression values) as reference.
Using more features will increase the noise in the biological variation
reflected in this reference bin (as well as increase computation time),
while using less features might
result in insufficient capture of the biological complexity of the samples.
Subsequent bins of features of decreasing mean expression across cells are
then defined (by default, 1000 features
per bin). Note that the size of the subsequent feature bins matters less
than the size of the reference bin.

For comparison, several negative control bins are defined by randomly shuffling values of the top bin expression matrix,
building a window that is expected to be completely uncorrelated. Then, every feature in each bin is correlated
to every feature in the reference bin and the control bins to obtain correlation coefficient distributions.
Ultimately, the variation of the distributions of correlation coefficients can be used to inform the threshold decision.

## 1.3 Installation

The stable version of `scFeatureFilter` can be installed from Bioconductor:

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("scFeatureFilter")
```

Once installed, the package is ready to be loaded:

```
library(scFeatureFilter)

library(ggplot2)
library(cowplot) # multipanel figures + nice theme
```

# 2 Integrated usage

A single-function call option is available to the user, in which the entire package functionality is
executed. This will filter the expression matrix and keep only the most informative highly expressed features,
using default options:

```
# example dataset included with the package:
scData_hESC
## # A tibble: 60,468 × 33
##    tracking_id        GSM922224_hESCpassage0_Cell4_0 GSM922225_hESCpassage0_Ce…¹
##    <chr>                                       <dbl>                       <dbl>
##  1 ENSG00000000003.13                         55.3                        36.0
##  2 ENSG00000000005.5                           0                           0
##  3 ENSG00000000419.11                         54.0                        55.5
##  4 ENSG00000000457.12                          0.924                       0.222
##  5 ENSG00000000460.15                          7.08                        1.35
##  6 ENSG00000000938.11                          0                           0
##  7 ENSG00000000971.14                          0                           0
##  8 ENSG00000001036.12                          7.88                       29.2
##  9 ENSG00000001084.9                          21.2                         6.64
## 10 ENSG00000001167.13                          3.59                        3.47
## # ℹ 60,458 more rows
## # ℹ abbreviated name: ¹​GSM922225_hESCpassage0_Cell5_0
## # ℹ 30 more variables: GSM922226_hESCpassage0_Cell6_0 <dbl>,
## #   GSM922227_hESCpassage0_Cell7_0 <dbl>, GSM922228_hESCpassage0_Cell8_0 <dbl>,
## #   GSM922230_hESCpassage0_Cell10_0 <dbl>,
## #   GSM922250_hESCpassage10_Cell1_0 <dbl>,
## #   GSM922251_hESCpassage10_Cell2_0 <dbl>, …

# filtering of the dataset with a single function call:
sc_feature_filter(scData_hESC)
## Mean expression of last top gene: 2114.40221875
## Number of windows: 18
## # A tibble: 7,443 × 33
##    geneName GSM922224_hESCpassag…¹ GSM922225_hESCpassag…² GSM922226_hESCpassag…³
##    <chr>                     <dbl>                  <dbl>                  <dbl>
##  1 ENSG000…                 40272.                 68182                  54616.
##  2 ENSG000…                 30747.                 32311.                 38113.
##  3 ENSG000…                 11057.                 13508.                 19671
##  4 ENSG000…                 17100.                 10635.                 12243.
##  5 ENSG000…                 19985.                 41373.                 23986.
##  6 ENSG000…                 11290.                 18370.                 17370.
##  7 ENSG000…                  7005.                 12713.                 10136.
##  8 ENSG000…                 17239.                 23962.                 28032.
##  9 ENSG000…                 14995.                 30880.                 17723.
## 10 ENSG000…                  9676.                  9654.                 10235.
## # ℹ 7,433 more rows
## # ℹ abbreviated names: ¹​GSM922224_hESCpassage0_Cell4_0,
## #   ²​GSM922225_hESCpassage0_Cell5_0, ³​GSM922226_hESCpassage0_Cell6_0
## # ℹ 29 more variables: GSM922227_hESCpassage0_Cell7_0 <dbl>,
## #   GSM922228_hESCpassage0_Cell8_0 <dbl>,
## #   GSM922230_hESCpassage0_Cell10_0 <dbl>,
## #   GSM922250_hESCpassage10_Cell1_0 <dbl>, …
```

# 3 Detailed usage

## 3.1 Loading data

*scFeatureFilter* uses an expression matrix (either as a `matrix`, a `data.frame`, a `tibble` or a
`SingleCellExperiment` R object) as input. Support of Bioconductor’s expression set objects will arrive shortly.
Note that features should be in rows, while cells should be in columns.

We recommend providing normalized expression values where at least library size is accounted for,
such as TPM or FPKM, rather than raw counts.

An example dataset is supplied with the package:

```
scData_hESC
## # A tibble: 60,468 × 33
##    tracking_id        GSM922224_hESCpassage0_Cell4_0 GSM922225_hESCpassage0_Ce…¹
##    <chr>                                       <dbl>                       <dbl>
##  1 ENSG00000000003.13                         55.3                        36.0
##  2 ENSG00000000005.5                           0                           0
##  3 ENSG00000000419.11                         54.0                        55.5
##  4 ENSG00000000457.12                          0.924                       0.222
##  5 ENSG00000000460.15                          7.08                        1.35
##  6 ENSG00000000938.11                          0                           0
##  7 ENSG00000000971.14                          0                           0
##  8 ENSG00000001036.12                          7.88                       29.2
##  9 ENSG00000001084.9                          21.2                         6.64
## 10 ENSG00000001167.13                          3.59                        3.47
## # ℹ 60,458 more rows
## # ℹ abbreviated name: ¹​GSM922225_hESCpassage0_Cell5_0
## # ℹ 30 more variables: GSM922226_hESCpassage0_Cell6_0 <dbl>,
## #   GSM922227_hESCpassage0_Cell7_0 <dbl>, GSM922228_hESCpassage0_Cell8_0 <dbl>,
## #   GSM922230_hESCpassage0_Cell10_0 <dbl>,
## #   GSM922250_hESCpassage10_Cell1_0 <dbl>,
## #   GSM922251_hESCpassage10_Cell2_0 <dbl>, …
```

*The example dataset was processed by [Mantsoki et al. (2016)](https://www.ncbi.nlm.nih.gov/pubmed/26951854), data from human Embryonic Stem cells was generated by [Yan et al. (2013)](https://www.ncbi.nlm.nih.gov/pubmed/23934149).*

## 3.2 Binning data

Firstly, a mean expression and a coefficient of variation column is added to the expression matrix provided
using the `calculate_cvs` function:

```
calculate_cvs(scData_hESC)
## # A tibble: 17,929 × 36
##    geneName       mean    sd    cv GSM922224_hESCpassag…¹ GSM922225_hESCpassag…²
##    <chr>         <dbl> <dbl> <dbl>                  <dbl>                  <dbl>
##  1 ENSG00000000… 70.0  73.3  1.05                  55.3                   36.0
##  2 ENSG00000000…  1.00  2.53 2.53                   0                      0
##  3 ENSG00000000… 81.0  71.5  0.883                 54.0                   55.5
##  4 ENSG00000000…  1.59  1.80 1.13                   0.924                  0.222
##  5 ENSG00000000…  9.53  8.44 0.886                  7.08                   1.35
##  6 ENSG00000001… 21.7  17.0  0.781                  7.88                  29.2
##  7 ENSG00000001… 18.0  15.6  0.868                 21.2                    6.64
##  8 ENSG00000001…  4.11  6.64 1.62                   3.59                   3.47
##  9 ENSG00000001…  7.22 17.2  2.38                   0                      0
## 10 ENSG00000001…  4.94  7.40 1.50                   1.36                   3.34
## # ℹ 17,919 more rows
## # ℹ abbreviated names: ¹​GSM922224_hESCpassage0_Cell4_0,
## #   ²​GSM922225_hESCpassage0_Cell5_0
## # ℹ 30 more variables: GSM922226_hESCpassage0_Cell6_0 <dbl>,
## #   GSM922227_hESCpassage0_Cell7_0 <dbl>, GSM922228_hESCpassage0_Cell8_0 <dbl>,
## #   GSM922230_hESCpassage0_Cell10_0 <dbl>,
## #   GSM922250_hESCpassage10_Cell1_0 <dbl>, …
```

We can explore the mean - variance relationship of the dataset with the `plot_mean_variance` function:

```
library(magrittr) # to use the pipe %>%

calculate_cvs(scData_hESC) %>%
    plot_mean_variance(colourByBin = FALSE)
```

![](data:image/png;base64...)

The top window (or reference bin) is then defined with the `define_top_genes` function, while the rest of bins
are created with the `bin_scdata` function:

```
scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000)
## Mean expression of last top gene: 2114.40221875
## Number of windows: 18
## # A tibble: 17,929 × 37
##    geneName            mean     sd    cv   bin GSM922224_hESCpassage0_Cell4_0
##    <chr>              <dbl>  <dbl> <dbl> <dbl>                          <dbl>
##  1 ENSG00000228253.1 58450. 43460. 0.744     1                         40272.
##  2 ENSG00000198888.2 30454. 32771. 1.08      1                         30747.
##  3 ENSG00000198712.1 23484. 26032. 1.11      1                         11057.
##  4 ENSG00000211459.2 21989. 33334. 1.52      1                         17100.
##  5 ENSG00000212907.2 18749. 18501. 0.987     1                         19985.
##  6 ENSG00000198899.2 17557. 12660. 0.721     1                         11290.
##  7 ENSG00000198727.2 16748. 16228. 0.969     1                          7005.
##  8 ENSG00000210082.2 16013. 20765. 1.30      1                         17239.
##  9 ENSG00000198886.2 13890. 13973. 1.01      1                         14995.
## 10 ENSG00000198938.2 11299.  7602. 0.673     1                          9676.
## # ℹ 17,919 more rows
## # ℹ 31 more variables: GSM922225_hESCpassage0_Cell5_0 <dbl>,
## #   GSM922226_hESCpassage0_Cell6_0 <dbl>, GSM922227_hESCpassage0_Cell7_0 <dbl>,
## #   GSM922228_hESCpassage0_Cell8_0 <dbl>,
## #   GSM922230_hESCpassage0_Cell10_0 <dbl>,
## #   GSM922250_hESCpassage10_Cell1_0 <dbl>,
## #   GSM922251_hESCpassage10_Cell2_0 <dbl>, …
```

Then, we can plot the resulting bin definition using the same `plot_mean_variance` function, setting the
`colourByBin` argument to `TRUE`:

```
myPlot <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000) %>%
    plot_mean_variance(colourByBin = TRUE, density_color = "blue")
## Mean expression of last top gene: 2114.40221875
## Number of windows: 18

myPlot
```

![](data:image/png;base64...)

Note that the plotting function outputs are `ggplot2` objects that can be
further customized. See an example here:

```
myPlot + annotation_logticks(sides = "l")
```

![](data:image/png;base64...)

## 3.3 Correlation of the bins

After binning the data, correlations (by default, Pearson’s) can be calculated. Every feature in each window is correlated
to every other feature in the reference bin (as well as in the randomized control bins) using the
function `correlate_windows`:

```
corDistrib <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000) %>%
    correlate_windows(n_random = 3)
## Mean expression of last top gene: 2114.40221875
## Number of windows: 18
```

For visualization of the correlation values, probability distributions can be computed using
and plotted using the `correlations_to_densities` and `plot_correlations_distributions` functions:

```
corDens <- correlations_to_densities(corDistrib, absolute_cc = TRUE)
plot_correlations_distributions(corDens, facet_ncol = 5) +
    scale_x_continuous(breaks = c(0, 0.5, 1), labels = c("0", "0.5", "1"))
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the scFeatureFilter package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

The coloured lines indicate the correlation coefficient distributions for each bin compared to
the reference bin (bin 1 shows the autocorrelation of the reference bin). The thicker blue
lines with grey area (barely visible) represents the correlation coefficient distributions for
each bin compared to the randomized control bins.

Notice that the correlation distributions shift from high to low values as
the bin number increases,
i.e. as the mean expression level of the features decreases,
indicating a higher influence of
technical variability in the expression results.

*Note: the `absolute_cc = TRUE` option, which is the default, instructs the package to work
with the absolute value of the correlation coefficient. Therefore, highly negatively correlated features
will count as highly correlated. Setting this option as `TRUE` also produces clearer plots, and reduces
the emphasis on non-symmetrical, near 0, shifts of correlation values that are not interpretable.*

We can quantify the steady decrease of correlation values as feature expression goes down using the
`get_mean_median` function, improving interpretability of the extent of technical variability in the data:

```
metrics <- get_mean_median(corDistrib)
metrics
## # A tibble: 72 × 4
##      bin window                 mean median
##    <dbl> <chr>                 <dbl>  <dbl>
##  1     1 shuffled_top_window_1 0.147  0.130
##  2     1 shuffled_top_window_2 0.145  0.119
##  3     1 shuffled_top_window_3 0.149  0.128
##  4     1 top_window            0.718  0.844
##  5     2 shuffled_top_window_1 0.141  0.117
##  6     2 shuffled_top_window_2 0.140  0.111
##  7     2 shuffled_top_window_3 0.145  0.117
##  8     2 top_window            0.514  0.528
##  9     3 shuffled_top_window_1 0.138  0.109
## 10     3 shuffled_top_window_2 0.137  0.106
## # ℹ 62 more rows
plot_correlations_distributions(corDens, metrics = metrics, facet_ncol = 5) +
    scale_x_continuous(breaks = c(0, 0.5, 1), labels = c("0", "0.5", "1"))
## Warning: `select_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `select()` instead.
## ℹ The deprecated feature was likely used in the scFeatureFilter package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

The added dashed lines are the mean values of the distributions. The `plot_metric` function focalized on these means of distributions:

```
plot_metric(metrics, show_ctrl = FALSE, show_threshold = FALSE)
```

![](data:image/png;base64...)

The bar represents the mean value of the correlation coefficient distribution of each bin
against the reference bin, while the dot and whiskers are against the randomized control windows.
In our example dataset, the mean of the correlation distributions decreases steadily,
and reaches a plateau after bin 11.

## 3.4 Choosing a threshold

On the previous plot, a background reference can be added as a dashed line, by taking the mean value of the
correlations of every bin to the randomized control bins:

```
plot_metric(metrics, show_ctrl = TRUE, show_threshold = FALSE)
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the scFeatureFilter package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Then, the user can decide to plot only bins for which the mean correlation value against the reference window
is higher than, for example, twice the background:

```
plot_metric(metrics, show_ctrl = TRUE, show_threshold = TRUE, threshold = 2)
```

![](data:image/png;base64...)

To further assist thresholding, the function `determine_bin_cutoff` will return the number of the first bin
of features that falls below the set threshold:

```
determine_bin_cutoff(metrics, threshold = 2)
## [1] 9
```

Finally, using this information, the function `filter_expression_table` can be used to obtain a filtered
expression matrix from the original data:

```
binned_data <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000)
## Mean expression of last top gene: 2114.40221875
## Number of windows: 18
metrics <- correlate_windows(binned_data, n_random = 3) %>%
    get_mean_median

filtered_data <- filter_expression_table(
    binned_data,
    bin_cutoff = determine_bin_cutoff(metrics)
)

dim(scData_hESC)
## [1] 60468    33
dim(filtered_data)
## [1] 7443   33
filtered_data
## # A tibble: 7,443 × 33
##    geneName GSM922224_hESCpassag…¹ GSM922225_hESCpassag…² GSM922226_hESCpassag…³
##    <chr>                     <dbl>                  <dbl>                  <dbl>
##  1 ENSG000…                 40272.                 68182                  54616.
##  2 ENSG000…                 30747.                 32311.                 38113.
##  3 ENSG000…                 11057.                 13508.                 19671
##  4 ENSG000…                 17100.                 10635.                 12243.
##  5 ENSG000…                 19985.                 41373.                 23986.
##  6 ENSG000…                 11290.                 18370.                 17370.
##  7 ENSG000…                  7005.                 12713.                 10136.
##  8 ENSG000…                 17239.                 23962.                 28032.
##  9 ENSG000…                 14995.                 30880.                 17723.
## 10 ENSG000…                  9676.                  9654.                 10235.
## # ℹ 7,433 more rows
## # ℹ abbreviated names: ¹​GSM922224_hESCpassage0_Cell4_0,
## #   ²​GSM922225_hESCpassage0_Cell5_0, ³​GSM922226_hESCpassage0_Cell6_0
## # ℹ 29 more variables: GSM922227_hESCpassage0_Cell7_0 <dbl>,
## #   GSM922228_hESCpassage0_Cell8_0 <dbl>,
## #   GSM922230_hESCpassage0_Cell10_0 <dbl>,
## #   GSM922250_hESCpassage10_Cell1_0 <dbl>, …
```

*Note: most of the features are filtered at the `calculate_cvs` step because
hey have a too high fraction of drop-outs or zero-expression.
The maximum fraction of 0 expression tolerated by scFeatureFilter is 75%,
by default.*

## 3.5 Working with SingleCellExperiment objects

This package accpets `SingleCellExperiment` as inputs for `sc_feature_filter`
and `calculate_cvs` functions. However, it does not retun such objects at the moment.
One can retrieve a filtered `SingleCellExperiment` objects like this:

```
library(SingleCellExperiment)
library(scRNAseq) # example datasets

sce_allen <- ReprocessedAllenData()

# sce_allen is an SingleCellExperiment object
sce_allen
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(4): tophat_counts cufflinks_fpkm rsem_counts rsem_tpm
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(0):
## mainExpName: endogenous
## altExpNames(1): ERCC

filtered_allen <- sc_feature_filter(sce_allen, sce_assay = "rsem_tpm")
is.matrix(filtered_allen) # filtered_allen is a tibble
## [1] TRUE

sce_filtered_allen <- sce_allen[rownames(filtered_allen), ]
sce_filtered_allen
## class: SingleCellExperiment
## dim: 2145 379
## metadata(2): SuppInfo which_qc
## assays(4): tophat_counts cufflinks_fpkm rsem_counts rsem_tpm
## rownames(2145): Ubb Snap25 ... Synpr Fmnl1
## rowData names(0):
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(0):
## mainExpName: endogenous
## altExpNames(1): ERCC
```

# 4 Parameter values

Several parameters are used in `sc_feature_filter` or in step-by-step functions.
Their default values are set using mouse an human data and
should work for eukaryote species with multi-exonic
genes (metazoans & plants).

## 4.1 `max_zeros`

The `max_zeros` parameter (default value `0.75`) is used as a first filtering
step.
Features that present zero-expression in a proportion of cells higher than the
set threshold will be
removed. Zero expression can reflect both an absence of expression in the cell
of origin, or a drop-out event occuring during library preparation.
Ocurrence of these technical
drop-outs can be quite high in scRNAseq protocols. More stringent values for
this parameter could be `0.5` or `0.25`. This parameter will mostly impact the
total number of features, and therefore the number of bins that the data
is divided into. This filtering step will remove low-expression,
highly affected by noise features before the method is applied.

## 4.2 `top_window_size`

The `top_window_size` parameter (default to `100`) can have a significant impact
on the rest of the pipeline. It sets the number of features with the highest mean
expression that will be used as a reference bin. If the reference window is too
small (i.e. `10`), it will not capture enough of the biological variation.
On the contrary, a too large top window (i.e. `2000`) might include features
mildly affected by technical variation, diluting the biological component
of the variation too much to be of any use.
We therefore suggest keeping it at `100` or near that value.

The function `plot_top_window_autocor` can be used to visually explore the mean
auto-correlation value of features in the top bin with themselves depending on
the number of features in the top bin:

```
plot_top_window_autocor(calculate_cvs(scData_hESC))
```

![](data:image/png;base64...)

## 4.3 `other_window_size`

The `other_window_size` parameter (default to `1000`) is the number of
features included in the bins of features (outside the top window).
It is a more flexible parameter, and can safely be decreased to
`500` or `250`, (which will result in more bins) without significantly
altering the proposed filtering threshold:

```
metrics_bigBins <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000) %>%
    correlate_windows(n_random = 3) %>%
    get_mean_median
## Mean expression of last top gene: 2114.40221875
## Number of windows: 18

metrics_smallBins <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 500) %>%
    correlate_windows(n_random = 3) %>%
    get_mean_median
## Mean expression of last top gene: 2114.40221875
## Number of windows: 36

plot_grid(
    plot_metric(metrics_bigBins) +
        labs(title = "1000 genes per bin"),
    plot_metric(metrics_smallBins) +
        labs(title = "500 genes per bin")
)
```

![](data:image/png;base64...)

## 4.4 `n_random`

The background correlation values used to determine a threshold are
calculated by
randomly shuffling the expression values of features in the top window.
`n_random` (default to 3) sets the number of control bins that will
be generated.
Note that increasing this value will also increase the computation time.
and given that results differ only marginally among the randomised windows,
there is not much need to increase that value.
Results differ only marginally between the different random windows, therefore
there is not much need to generate more than 3 control windows.

## 4.5 `threshold`

One can decide which bins of features to keep by looking at the
`plot_metric` or `plot_correlations_distributions` plots,
by visually exploring their correlation to the top bin of features.
We also provide an automatic threshold decision method, which keeps only windows
of features whose mean correlation value to the top window is higher than
`threshold` (default to 2) times the background level.
The background level of correlation is estimated using the randomised control
bins. Depending on the intended downstream analyses, one
can increase the `threshold` value to be more stringent in the feature
selection, keeping less features, but ensuring that they will contain
a sufficiently high amount of biological information.