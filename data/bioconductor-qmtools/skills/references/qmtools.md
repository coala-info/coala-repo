# Processing quantitative metabolomics data with the qmtools package

Jaehyun Joo1\*

1University of Pennsylvania

\*jaehyunjoo@outlook.com

#### 30 October 2025

# 1 Introduction

The `qmtools` package provides basic tools for imputation, normalization, and
dimension-reduction of metabolomics data with the standard
`SummarizedExperiment` class. It also offers several helper functions to assist
visualization of data. This vignette gives brief descriptions of
these tools with toy examples.

# 2 Installation

The package can be installed using *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)*. In R session,
please type `BiocManager::install("qmtools")`.

# 3 Data preparation

To demonstrate the use of the `qmtools` functions, we will use the
[FAAH knockout LC/MS](https://pubs.acs.org/doi/10.1021/bi0480335) data,
containing quantified LC/MS peaks from the spinal cords of 6 wild-type and
6 FAAH (fatty acid amide hydrolase) knockout mice.

```
library(qmtools)
library(SummarizedExperiment)
library(vsn)
library(pls)
library(ggplot2)
library(patchwork)
set.seed(1e8)

data(faahko_se)

## Only keep the first assay for the vignette
assays(faahko_se)[2:4] <- NULL
faahko_se
#> class: SummarizedExperiment
#> dim: 206 12
#> metadata(0):
#> assays(1): raw
#> rownames(206): FT001 FT002 ... FT205 FT206
#> rowData names(10): mzmed mzmin ... WT peakidx
#> colnames(12): ko15.CDF ko16.CDF ... wt21.CDF wt22.CDF
#> colData names(2): sample_name sample_group
```

# 4 Feature filtering

Metabolomics data often contains a large number of uninformative features that
can hinder downstream analysis. The `removeFeatures` function attempts to
identify such features and remove them from the data based on missing values,
quality control (QC) replicates, and blank samples with the following methods:

* Proportions of missing values: retain features if there is at least one group
  with a proportion of non-missing values above a cut-off.
* Relative standard deviation: remove features if QC replicates show low
  reproducibility.
* Intraclass correlation coefficient (ICC): retain features if a feature has
  relatively high variability across biological samples compared to QC
  replicates.
* QC/blank ratio: remove features with low abundance that may have
  non-biological origin.

The FAAH knockout data does not include QC and blank samples. Here, we just
illustrate missing value-based filtering.

```
dim(faahko_se) # 206 features
#> [1] 206  12
table(colData(faahko_se)$sample_group)
#>
#> KO WT
#>  6  6

## Missing value filter based on 2 groups.
dim(removeFeatures(faahko_se, i = "raw",
                   group = colData(faahko_se)$sample_group,
                   cut = 0.80)) # nothing removed
#> [1] 206  12

dim(removeFeatures(faahko_se, i = "raw",
                   group = colData(faahko_se)$sample_group,
                   cut = 0.85)) # removed 65 features
#> [1] 141  12

## based on "WT" only
dim(removeFeatures(faahko_se, i = "raw",
                   group = colData(faahko_se)$sample_group,
                   levels = "WT", cut = 0.85))
#> [1] 104  12
```

In this vignette, we kept all features based on the cut-off: at least one group
contains >= 80% of non-missing values.

# 5 Imputation

Missing values are common in metabolomics data. For example, ions may have
a low abundance that does not reach the limit of detection of the instrument.
Unexpected stochastic fluctuations and technical error may also cause
missing values even though ions present at detectable levels.
We could use the `plotMiss` function to explore the mechanisms generating
the missing values. The bar plot on the left panel shows the amount of missing
values in each samples and the right panel helps to identify the structure of
missing values with a hierarchically-clustered heatmap.

```
## Sample group information
g <- factor(colData(faahko_se)$sample_group, levels = c("WT", "KO"))

## Visualization of missing values
plotMiss(faahko_se, i = "raw", group = g)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the dendextend package.
#>   Please report the issue at <https://github.com/talgalili/dendextend/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)
Overall, the knockout mice have a higher percentage of missing values.
The features on top of the heatmap in general only present at the knockout mice,
suggesting that some of missing values are at least not random
(perhaps due to altered metabolisms by the experimental condition).
In almost all cases, visualization and inspection of missing values are
a time-intensive step, but greatly improve the ability to uncover the nature of
missing values in data and help to choose an appropriate imputation method.

The imputation of missing values can be done with the `imputeIntensity`
function. Several imputation methods are available such as k-Nearest Neighbor
(kNN), Random Forest (RF), Bayesian PCA, and other methods available in
*[MsCoreUtils](https://bioconductor.org/packages/3.22/MsCoreUtils)*. By default, the kNN is used to impute missing values
using the Gower distance. The kNN is a distance-based
algorithm that typically requires to scale the data to avoid variance-based
weighing. Since the Gower distance used, the imputation can be performed
with the original scales, which may be helpful to non-technical users.

```
se <- imputeIntensity(faahko_se, i = "raw", name = "knn", method = "knn")
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#>    63468.57    38481.41    46165.94    26091.68    42868.48    41247.14
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko16.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 46048727.19
#>    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF    wt16.CDF
#> 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#>    65831.73    38481.41    46165.94    26091.68    42868.48    41247.14
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF    wt16.CDF
#> 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#>    65831.73    63468.57    46165.94    26091.68    42868.48    41247.14
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF    wt16.CDF
#> 46048727.19 32492480.95 32302319.81 25442440.48 52245997.84 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#>    65831.73    63468.57    38481.41    26091.68    42868.48    41247.14
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko21.CDF    ko22.CDF    wt15.CDF    wt16.CDF
#> 46048727.19 39440413.49 32302319.81 25442440.48 52245997.84 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko22.CDF    wt15.CDF
#>    65831.73    63468.57    38481.41    46165.94    42868.48    41247.14
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko22.CDF    wt15.CDF    wt16.CDF
#> 46048727.19 39440413.49 32492480.95 25442440.48 52245997.84 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    wt15.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    41247.14
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    wt15.CDF    wt16.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 52245997.84 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    42868.48
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    88334.42    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt16.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 25442440.48 54626653.48
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    42868.48
#>    wt15.CDF    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    41247.14    54566.86    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84
#>    wt18.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 41646091.12 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    42868.48
#>    wt15.CDF    wt16.CDF    wt19.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    41247.14    88334.42    56239.84    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84
#>    wt16.CDF    wt19.CDF    wt21.CDF    wt22.CDF
#> 54626653.48 32175052.66 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    42868.48
#>    wt15.CDF    wt16.CDF    wt18.CDF    wt21.CDF    wt22.CDF    ko15.CDF
#>    41247.14    88334.42    54566.86    50560.45    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84
#>    wt16.CDF    wt18.CDF    wt21.CDF    wt22.CDF
#> 54626653.48 41646091.12 31441536.77 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    42868.48
#>    wt15.CDF    wt16.CDF    wt18.CDF    wt19.CDF    wt22.CDF    ko15.CDF
#>    41247.14    88334.42    54566.86    56239.84    37486.44 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt22.CDF
#> 54626653.48 41646091.12 32175052.66 28487418.52
#>    ko15.CDF    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF
#>    65831.73    63468.57    38481.41    46165.94    26091.68    42868.48
#>    wt15.CDF    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF    ko15.CDF
#>    41247.14    88334.42    54566.86    56239.84    50560.45 49661401.43
#>    ko16.CDF    ko18.CDF    ko19.CDF    ko21.CDF    ko22.CDF    wt15.CDF
#> 46048727.19 39440413.49 32492480.95 32302319.81 25442440.48 52245997.84
#>    wt16.CDF    wt18.CDF    wt19.CDF    wt21.CDF
#> 54626653.48 41646091.12 32175052.66 31441536.77
se # The result was stored in assays slot: "knn"
#> class: SummarizedExperiment
#> dim: 206 12
#> metadata(0):
#> assays(2): raw knn
#> rownames(206): FT001 FT002 ... FT205 FT206
#> rowData names(10): mzmed mzmin ... WT peakidx
#> colnames(12): ko15.CDF ko16.CDF ... wt21.CDF wt22.CDF
#> colData names(2): sample_name sample_group

## Standardization of input does not influence the result
m <- assay(faahko_se, "raw")
knn_scaled <- as.data.frame(
    imputeIntensity(scale(m), method = "knn") # Can accept matrix as an input
)
#>   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF
#> -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko16.CDF   ko18.CDF   ko19.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.4857321  6.3551075  6.7812280
#>   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF
#> -0.4699491 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko18.CDF   ko19.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.3551075  6.7812280
#>   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF
#> -0.4699491 -0.5265097 -0.4910549 -0.4887510 -0.4815194 -0.4783075 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko19.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.7812280
#>   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4887510 -0.4815194 -0.4783075 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko22.CDF   wt15.CDF   wt16.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4815194 -0.4783075 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.7812280  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   wt15.CDF   wt16.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4783075 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.7812280  6.6230444  7.2022231  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt16.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4802244
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   ko22.CDF   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.7812280  6.6230444  5.7185691  7.1932037  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075
#>   wt18.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4496531 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt18.CDF   wt19.CDF   wt21.CDF
#>  6.7812280  6.6230444  5.7185691  7.2022231  6.8426948  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075
#>   wt16.CDF   wt19.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4802244 -0.4847633 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt19.CDF   wt21.CDF
#>  6.7812280  6.6230444  5.7185691  7.2022231  7.1932037  6.5186989  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075
#>   wt16.CDF   wt18.CDF   wt21.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4802244 -0.4496531 -0.4791052 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt21.CDF
#>  6.7812280  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  5.7697257
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075
#>   wt16.CDF   wt18.CDF   wt19.CDF   wt22.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4802244 -0.4496531 -0.4847633 -0.5007302  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF
#>  6.7812280  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989
#>   wt22.CDF
#>  6.6710053
#>   ko15.CDF   ko16.CDF   ko18.CDF   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF
#> -0.4699491 -0.5265097 -0.5022030 -0.4910549 -0.4887510 -0.4815194 -0.4783075
#>   wt16.CDF   wt18.CDF   wt19.CDF   wt21.CDF   ko15.CDF   ko16.CDF   ko18.CDF
#> -0.4802244 -0.4496531 -0.4847633 -0.4791052  6.9238672  6.4857321  6.3551075
#>   ko19.CDF   ko21.CDF   ko22.CDF   wt15.CDF   wt16.CDF   wt18.CDF   wt19.CDF
#>  6.7812280  6.6230444  5.7185691  7.2022231  7.1932037  6.8426948  6.5186989
#>   wt21.CDF
#>  5.7697257

knn_unscaled <- as.data.frame(assay(se, "knn"))

idx <- which(is.na(m[, 1]) | is.na(m[, 2])) # indices for missing values
p1 <- ggplot(knn_unscaled[idx, ], aes(x = ko15.CDF, y = ko16.CDF)) +
    geom_point() + theme_bw()
p2 <- ggplot(knn_scaled[idx, ], aes(x = ko15.CDF, y = ko16.CDF)) +
    geom_point() + theme_bw()
p1 + p2 + plot_annotation(title = "Imputed values: unscaled vs scaled")
```

![](data:image/png;base64...)

# 6 Normalization

In metabolomics, normalization is an important part of data processing to reduce
unwanted non-biological variations
(e.g., variation due to sample preparation and handling).
The `normalizeIntensity` function provides several data-driven normalization
methods such as Probabilistic Quotient Normalization (PQN),
Variance-Stabilizing Normalization (VSN), Cyclic LOESS normalization, and other
methods available in *[MsCoreUtils](https://bioconductor.org/packages/3.22/MsCoreUtils)*.
Here, we will apply the VSN to the imputed intensities. Note that the VSN
produces glog-transformed (generalized log transform) feature intensities.
The consequence of normalization can be visualized with the `plotBox` function.

```
se <- normalizeIntensity(se, i = "knn", name = "knn_vsn", method = "vsn")
se # The result was stored in assays slot: "knn_vsn"
#> class: SummarizedExperiment
#> dim: 206 12
#> metadata(0):
#> assays(3): raw knn knn_vsn
#> rownames(206): FT001 FT002 ... FT205 FT206
#> rowData names(10): mzmed mzmin ... WT peakidx
#> colnames(12): ko15.CDF ko16.CDF ... wt21.CDF wt22.CDF
#> colData names(2): sample_name sample_group

p1 <- plotBox(se, i = "knn", group = g, log2 = TRUE) # before normalization
p2 <- plotBox(se, i = "knn_vsn", group = g) # after normalization
p1 + p2 + plot_annotation(title = "Before vs After normalization")
```

![](data:image/png;base64...)

# 7 Dimension-reduction

The metabolomics data generally consist of a large number of features, and
dimension-reduction techniques are often used for modeling and visualization to
uncover latent structure underlying many features. The `reduceFeatures` can be
used to perform dimension-reduction of the data. Currently, Principal Component
Analysis (PCA), Partial Least Square-Discriminant Analysis (PLS-DA) and
t-distributed stochastic neighbor (t-SNE) are supported. The function returns
a matrix containing dimension-reduced data with several attributes that can be
summarized with the `summary` function.

```
## PCA
m_pca <- reduceFeatures(se, i = "knn_vsn", method = "pca", ncomp = 2)
summary(m_pca)
#> Reduction method: PCA (SVD)
#> Input centered before PCA: TRUE
#> Input scaled before PCA: FALSE
#> Number of PCs calculated: 2
#> Importance of PC(s):
#>                           PC1    PC2
#> Proportion of Variance 0.2265 0.1599
#> Cumulative Proportion  0.2265 0.3865
```

```
## PLS-DA (requires information about each sample's group)
m_plsda <- reduceFeatures(se, i = "knn_vsn", method = "plsda", ncomp = 2, y = g)
summary(m_plsda)
#> Reduction method: PLS-DA (kernelpls)
#> Y responses: WT KO
#> Input centered before PLS-DA: TRUE
#> Input scaled before PLS-DA: FALSE
#> Number of components considered: 2
#> Amount of X variance explained by each component:
#>              Comp 1 Comp 2
#> Explained %   21.64  14.02
#> Cumulative %  21.64  35.65
```

The dimension-reduction results can be plotted with the `plotReduced` function.
Each point (label) represents a sample. Data ellipses can be visualized.

```
p_pca <- plotReduced(m_pca, group = g)
p_plsda <- plotReduced(m_plsda, label = TRUE, ellipse = TRUE)
p_pca + p_plsda + plot_annotation(title = "PCA and PLS-DA")
```

![](data:image/png;base64...)

# 8 Feature clustering

For soft ionization methods such as LC/ESI-MS, a bulk of ions can be generated
from an individual compound upon ionization. Because we typically interested in
compounds rather than different ion species, identifying features from the same
compound is necessary. The `clusterFeatures` function attempts to cluster
metabolic features with the following steps:

1. Clusters features according to their retention times
2. Based on the initial grouping, clusters features according to the
   intensity correlations

After the clustering procedures, the function adds the `rtime_group` and
`feature_group` columns to the rowData of `SummarizedExperiment` input.

```
se <- clusterFeatures(se, i = "knn_vsn", rtime_var = "rtmed",
                      rt_cut = 10, cor_cut = 0.7)
rowData(se)[, c("rtmed", "rtime_group", "feature_group")]
#> DataFrame with 206 rows and 3 columns
#>           rtmed rtime_group feature_group
#>       <numeric>    <factor>   <character>
#> FT001   2789.04       FG.01      FG.01.01
#> FT002   2788.31       FG.01      FG.01.02
#> FT003   2718.79       FG.02      FG.02.01
#> FT004   3024.33       FG.03      FG.03.01
#> FT005   3684.80       FG.04      FG.04.01
#> ...         ...         ...           ...
#> FT202   3001.79       FG.14      FG.14.03
#> FT203   3714.93       FG.24      FG.24.07
#> FT204   3403.03       FG.50      FG.50.04
#> FT205   3614.09       FG.49      FG.49.05
#> FT206   3817.51       FG.41      FG.41.02
```

By default, the retention time-based grouping is performed with a hierarchical
clustering based on the Manhattan distance (i.e., differences in retention
times). The equivalent steps are

```
rts <- rowData(se)$rtmed
rt_cut <- 10
fit <- hclust(dist(rts, "manhattan"))
plot(as.dendrogram(fit), leaflab = "none")
rect.hclust(fit, h = rt_cut)
```

![](data:image/png;base64...)
The retention-time based grouping can also be conducted with the algorithms
(`groupClosest` and `groupConsecutive`) available in the
*[MsFeatures](https://bioconductor.org/packages/3.22/MsFeatures)* package.

Upon the initial grouping, each retention-based time group is further clustered
according to the intensity correlations since features may be originated from
different co-eluting compounds, not from a single entity. By default, the
function creates a graph where correlations serve as edge weights
while low correlations defined by a user-specified cut-off ignored.
`cor_grouping = "connected"` simply assigns connected features into the same
feature group whereas `cor_grouping = louvain` further applies the Louvain
algorithm to the graph to identify densely connected features.
The `groupSimiarityMatrix` approach from the *[MsFeatures](https://bioconductor.org/packages/3.22/MsFeatures)*
package is also supported.

The feature clustering results can be visualized with the `plotRTgroup`
function. A group of features in the same feature group will be displayed with
the same color. Each vertex represents a feature and each weight represent a
correlation between features.

```
se_connected <- clusterFeatures(se, i = "knn_vsn", rtime_var = "rtmed",
                                rt_cut = 10, cor_cut = 0.7,
                                cor_grouping = "connected")
plotRTgroup(se_connected, i = "knn_vsn", group = "FG.22")
```

![](data:image/png;base64...)

```
se_louvain <- clusterFeatures(se, i = "knn_vsn", rtime_var = "rtmed",
                              rt_cut = 10, cor_cut = 0.7,
                              cor_grouping = "louvain")
plotRTgroup(se_louvain, i = "knn_vsn", group = "FG.22")
```

![](data:image/png;base64...)

More details could be plotted by specifying `type = "pairs"`.

```
plotRTgroup(se_louvain, i = "knn_vsn", group = "FG.22", type = "pairs")
```

![](data:image/png;base64...)

The clustering results can be used to deal with the redundancy of the data with
other packages such as *[QFeatures](https://bioconductor.org/packages/3.22/QFeatures)* (aggregation of intensities) and
*[InterpretMSSpectrum](https://CRAN.R-project.org/package%3DInterpretMSSpectrum)* (adduct annotation).

# 9 Sample comparison

To test which metabolic features are different between two sets of samples, the
`compareSamples` function provides a convenient way to compute empirical Bayes
statistics using the *[limma](https://bioconductor.org/packages/3.22/limma)* package interface. Note that this
function expects log-transformed feature intensities.

```
## Compute statisticis for the contrast: KO - WT
fit <- compareSamples(se, i = "knn_vsn", group = "sample_group",
                      class1 = "WT", class2 = "KO")

## List top 5 features
head(fit, 5)
#>          logFC     CI.L     CI.R  AveExpr         t      P.Value    adj.P.Val
#> FT042 3.153118 2.770529 3.535707 20.43317 17.814931 1.771892e-10 3.650097e-08
#> FT039 3.980802 3.403927 4.557677 19.87720 14.916453 1.592198e-09 1.639964e-07
#> FT063 2.217181 1.736336 2.698026 19.20748  9.967198 1.962654e-07 1.347689e-05
#> FT044 1.945845 1.269865 2.621825 18.89815  6.222304 3.185040e-05 1.640296e-03
#> FT098 2.575125 1.559026 3.591224 18.83681  5.478216 1.081528e-04 4.455894e-03
#>               B
#> FT042 14.468908
#> FT039 12.375890
#> FT063  7.579018
#> FT044  2.355507
#> FT098  1.096718
```

Multiple covariates can be included to incorporate important sample and experiment
information.

```
## Include covariates
colData(se)$covar <- c(rep(c("A", "B"), 6))
compareSamples(se, i = "knn_vsn", group = "sample_group",
               covariates = "covar", class1 = "WT", class2 = "KO",
               number = 5)
#>          logFC     CI.L     CI.R  AveExpr         t      P.Value    adj.P.Val
#> FT042 3.153118 2.757256 3.548980 20.43317 17.376617 8.402759e-10 1.730968e-07
#> FT039 3.980802 3.396157 4.565447 19.87720 14.854108 5.006787e-09 5.156991e-07
#> FT063 2.217181 1.749823 2.684540 19.20748 10.349506 2.725672e-07 1.871628e-05
#> FT044 1.945845 1.236408 2.655281 18.89815  5.983604 6.682044e-05 3.441253e-03
#> FT098 2.575125 1.576222 3.574028 18.83681  5.623974 1.166301e-04 4.805159e-03
#>               B
#> FT042 13.015891
#> FT039 11.311369
#> FT063  7.328577
#> FT044  1.659229
#> FT098  1.082477
```

For more flexible model specifications (e.g., interaction model, multi-level
model), please use a standard workflow outlined in the *[limma](https://bioconductor.org/packages/3.22/limma)*
package user’s guide.

# 10 References

# Appendix

Colin A. Smith (2021). faahKO: Saghatelian et al. (2004) FAAH knockout
LC/MS data. <http://dx.doi.org/10.1021/bi0480335>

Laurent Gatto, Johannes Rainer and Sebastian Gibb (2021). MsCoreUtils: Core
Utils for Mass Spectrometry Data.
<https://github.com/RforMassSpectrometry/MsCoreUtils>

Johannes Rainer (2022). MsFeatures: Functionality for Mass Spectrometry
Features.
<https://github.com/RforMassSpectrometry/MsFeatures>

Laurent Gatto and Christophe Vanderaa (2021). QFeatures: Quantitative features
for mass spectrometry data.
<https://github.com/RforMassSpectrometry/QFeatures>

Jan Lisec (2018). InterpretMSSpectrum: Interpreting High Resolution Mass
Spectra.
[https://CRAN.R-project.org/package=InterpretMSSpectrum](https://CRAN.R-project.org/package%3DInterpretMSSpectrum)

Ritchie, M.E., Phipson, B., Wu, D., Hu, Y., Law, C.W., Shi, W., and Smyth, G.K.
(2015). limma powers differential expression analyses for RNA-sequencing and
microarray studies. Nucleic Acids Research 43(7), e47.
<https://bioconductor.org/packages/limma>

# Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] patchwork_1.3.2             ggplot2_4.0.0
#>  [3] pls_2.8-5                   vsn_3.78.0
#>  [5] qmtools_1.14.0              SummarizedExperiment_1.40.0
#>  [7] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0               IRanges_2.44.0
#> [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [13] generics_0.1.4              MatrixGenerics_1.22.0
#> [15] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] gridExtra_2.3         rlang_1.1.6           magrittr_2.0.4
#>   [4] clue_0.3-66           e1071_1.7-16          compiler_4.5.1
#>   [7] vctrs_0.6.5           reshape2_1.4.4        stringr_1.5.2
#>  [10] pkgconfig_2.0.3       crayon_1.5.3          fastmap_1.2.0
#>  [13] magick_2.9.0          XVector_0.50.0        labeling_0.4.3
#>  [16] ca_0.71.1             rmarkdown_2.30        preprocessCore_1.72.0
#>  [19] tinytex_0.57          purrr_1.1.0           xfun_0.53
#>  [22] cachem_1.1.0          jsonlite_2.0.0        DelayedArray_0.36.0
#>  [25] cluster_2.1.8.1       R6_2.6.1              vcd_1.4-13
#>  [28] bslib_0.9.0           stringi_1.8.7         RColorBrewer_1.1-3
#>  [31] ranger_0.17.0         limma_3.66.0          boot_1.3-32
#>  [34] car_3.1-3             lmtest_0.9-40         jquerylib_0.1.4
#>  [37] Rcpp_1.1.0            bookdown_0.45         assertthat_0.2.1
#>  [40] iterators_1.0.14      knitr_1.50            zoo_1.8-14
#>  [43] igraph_2.2.1          Matrix_1.7-4          nnet_7.3-20
#>  [46] tidyselect_1.2.1      dichromat_2.0-0.1     abind_1.4-8
#>  [49] yaml_2.3.10           viridis_0.6.5         TSP_1.2-5
#>  [52] codetools_0.2-20      affy_1.88.0           lattice_0.22-7
#>  [55] tibble_3.3.0          plyr_1.8.9            withr_3.0.2
#>  [58] S7_0.2.0              evaluate_1.0.5        proxy_0.4-27
#>  [61] heatmaply_1.6.0       pillar_1.11.1         affyio_1.80.0
#>  [64] BiocManager_1.30.26   carData_3.0-5         VIM_6.2.6
#>  [67] foreach_1.5.2         plotly_4.11.0         sp_2.2-0
#>  [70] scales_1.4.0          laeken_0.5.3          class_7.3-23
#>  [73] glue_1.8.0            lazyeval_0.2.2        tools_4.5.1
#>  [76] dendextend_1.19.1     robustbase_0.99-6     data.table_1.17.8
#>  [79] webshot_0.5.5         registry_0.5-1        grid_4.5.1
#>  [82] tidyr_1.3.1           seriation_1.5.8       MsCoreUtils_1.22.0
#>  [85] colorspace_2.1-2      Formula_1.2-5         cli_3.6.5
#>  [88] S4Arrays_1.10.0       viridisLite_0.4.2     dplyr_1.1.4
#>  [91] gtable_0.3.6          DEoptimR_1.1-4        sass_0.4.10
#>  [94] digest_0.6.37         SparseArray_1.10.0    htmlwidgets_1.6.4
#>  [97] farver_2.1.2          htmltools_0.5.8.1     lifecycle_1.0.4
#> [100] httr_1.4.7            statmod_1.5.1         MASS_7.3-65
```