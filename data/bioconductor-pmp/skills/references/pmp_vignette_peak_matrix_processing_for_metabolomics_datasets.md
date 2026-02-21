# Peak Matrix Processing for metabolomics datasets

Andris Jankevics1\* and Ralf Johannes Maria Weber1\*\*

1Phenome Centre Birmingham, University of Birmingham, UK

\*a.jankevics@bham.ac.uk
\*\*r.j.weber@bham.ac.uk

#### 2025-11-11

#### Package

pmp 1.22.1

# 1 Introduction

Metabolomics data (pre-)processing workflows consist of multiple steps
including peak picking, quality assessment, missing value imputation,
normalisation and scaling. Several software solutions (commercial and
open-source) are available for raw data processing, including r-package XCMS,
to generate processed outputs in the form of a two dimensional data matrix.

These outputs contain hundreds or thousands of so called “uninformative” or
“irreproducible” features. Such features could strongly hinder outputs of
subsequent statistical analysis, biomarker discovery or metabolic pathway
inference. Common practice is to apply peak matrix validation and filtering
procedures as described in Di Guida et al. ([2016](#ref-guida2016)), Broadhurst et al. ([2018](#ref-broadhurst2018)) and Schiffman et al. ([2019](#ref-schiffman2019)).

Functions within the `pmp` (Peak Matrix Processing) package are designed to
help users to prepare data for further statistical data analysis in a fast,
easy to use and reproducible manner.

This vignette showcases a range of commonly applied Peak Matrix Processing
steps for metabolomics datasets.

# 2 Installation

You should have R version 4.0.0 or above and Rstudio installed to be able to
run this notebook.

Execute following commands from the R terminal.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pmp")
```

```
library(pmp)
library(SummarizedExperiment)
library(S4Vectors)
```

# 3 Data formats

Recently a review by Stanstrup et al. ([2019](#ref-stanstrup2019)) reported and discussed a broad range of
heterogeneous R tools and packages that are available via `Bioconductor`,
`CRAN`, `Github` and similar public repositories.

`pmp` package utilises *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* class from
Bioconductor for data input and output.

For example, outputs from widely used *[xcms](https://bioconductor.org/packages/3.22/xcms)* package can be
converted to a `SummarizedExperiment` object using functions
`featureDefinitions`, `featureValues` and `pData` on the `xcms` output object.

Additionally `pmp` also supports any matrix-like `R` data
structure (e.g. an ordinary matrix, a data frame) as an input. If the input is
a matrix-like structure `pmp` will perform several checks for data integrity.
Please see section [10](#endomorphisms) for more details.

# 4 Example dataset, MTBLS79

In this tutorial we will be using a direct infusion mass spectrometry (DIMS)
dataset consisting of 172 samples measured across 8 batches and is included in
`pmp` package as `SummarizedExperiemnt` class object `MTBLS79`.
More detailed description of the dataset is available from Kirwan et al. ([2014](#ref-kirwan2014)),
[MTBLS79](https://www.ebi.ac.uk/metabolights/MTBLS79) and R man page.

```
help ("MTBLS79")
```

```
data(MTBLS79)
MTBLS79
#> class: SummarizedExperiment
#> dim: 2488 172
#> metadata(0):
#> assays(1): ''
#> rownames(2488): 70.03364 70.03375 ... 569.36369 572.36537
#> rowData names(0):
#> colnames(172): batch01_QC01 batch01_QC02 ... Batch08_C09 Batch08_QC39
#> colData names(4): Batch Sample_Rep Class Class2
```

This dataset before peak matrix filtering contains 172 samples, 2488 features
and 18222 missing values across all samples what is roughly around 4.2%.

```
sum(is.na(assay(MTBLS79)))
#> [1] 18222
sum(is.na(assay(MTBLS79))) / length(assay(MTBLS79)) * 100
#> [1] 4.258113
```

# 5 Filtering a dataset

Missing values in the dataset can be filtered across samples or features. The
command below will remove all samples with more than 10 % missing values.

```
MTBLS79_filtered <- filter_samples_by_mv(df=MTBLS79, max_perc_mv=0.1)

MTBLS79_filtered
#> class: SummarizedExperiment
#> dim: 2488 170
#> metadata(2): original_data_structure processing_history
#> assays(1): ''
#> rownames(2488): 70.03364 70.03375 ... 569.36369 572.36537
#> rowData names(0):
#> colnames(170): batch01_QC01 batch01_QC02 ... Batch08_C09 Batch08_QC39
#> colData names(6): Batch Sample_Rep ... filter_samples_by_mv_perc
#>   filter_samples_by_mv_flags

sum(is.na(assay(MTBLS79_filtered)))
#> [1] 17588
```

Missing values sample filter has removed two samples from the dataset.
Outputs from any `pmp` function can be used as inputs for another `pmp`
function. For example we can apply missing value filter across features on the
output of the previous call. The function call below will filter features based
on the quality control (QC) sample group only.

```
MTBLS79_filtered <- filter_peaks_by_fraction(df=MTBLS79_filtered, min_frac=0.9,
    classes=MTBLS79_filtered$Class, method="QC", qc_label="QC")

MTBLS79_filtered
#> class: SummarizedExperiment
#> dim: 2228 170
#> metadata(2): original_data_structure processing_history
#> assays(1): ''
#> rownames(2228): 70.03364 70.03375 ... 559.15128 569.36369
#> rowData names(2): fraction_QC fraction_flag_QC
#> colnames(170): batch01_QC01 batch01_QC02 ... Batch08_C09 Batch08_QC39
#> colData names(6): Batch Sample_Rep ... filter_samples_by_mv_perc
#>   filter_samples_by_mv_flags

sum(is.na(assay(MTBLS79_filtered)))
#> [1] 11518
```

We can add another filter on top of the previous result. For this additional
filter we will use the same function call, but this time missing values will
be calculated across all samples and not only within the “QC” group.

```
MTBLS79_filtered <- filter_peaks_by_fraction(df=MTBLS79_filtered, min_frac=0.9,
    classes=MTBLS79_filtered$Class, method="across")

MTBLS79_filtered
#> class: SummarizedExperiment
#> dim: 1957 170
#> metadata(2): original_data_structure processing_history
#> assays(1): ''
#> rownames(1957): 70.03364 70.03375 ... 559.15128 569.36369
#> rowData names(4): fraction_QC fraction_flag_QC fraction fraction_flags
#> colnames(170): batch01_QC01 batch01_QC02 ... Batch08_C09 Batch08_QC39
#> colData names(6): Batch Sample_Rep ... filter_samples_by_mv_perc
#>   filter_samples_by_mv_flags

sum(is.na(assay(MTBLS79_filtered)))
#> [1] 4779
```

Applying these 3 filters has reduced the number of missing values from 18222 to
4779.

Another common filter approach is to filter features by the coefficient of
variation (CV) or RSD% of QC samples. The example shown below will use a 30%
threshold.

```
MTBLS79_filtered <- filter_peaks_by_rsd(df=MTBLS79_filtered, max_rsd=30,
    classes=MTBLS79_filtered$Class, qc_label="QC")

MTBLS79_filtered
#> class: SummarizedExperiment
#> dim: 1386 170
#> metadata(2): original_data_structure processing_history
#> assays(1): ''
#> rownames(1386): 70.03375 70.03413 ... 527.18345 559.15128
#> rowData names(6): fraction_QC fraction_flag_QC ... rsd_QC rsd_flags
#> colnames(170): batch01_QC01 batch01_QC02 ... Batch08_C09 Batch08_QC39
#> colData names(6): Batch Sample_Rep ... filter_samples_by_mv_perc
#>   filter_samples_by_mv_flags

sum(is.na(assay(MTBLS79_filtered)))
#> [1] 3040
```

# 6 Processing history

Every function in `pmp` provides a history of parameter values that have been
applied. If a user has saved outputs from an R session, it’s also easy to check
what function calls were executed.

```
processing_history(MTBLS79_filtered)
#> $filter_samples_by_mv
#> $filter_samples_by_mv$max_perc_mv
#> [1] 0.1
#>
#> $filter_samples_by_mv$remove_samples
#> [1] TRUE
#>
#>
#> $filter_peaks_by_fraction_QC
#> $filter_peaks_by_fraction_QC$min_frac
#> [1] 0.9
#>
#> $filter_peaks_by_fraction_QC$method
#> [1] "QC"
#>
#> $filter_peaks_by_fraction_QC$qc_label
#> [1] "QC"
#>
#> $filter_peaks_by_fraction_QC$remove_peaks
#> [1] TRUE
#>
#>
#> $filter_peaks_by_fraction_across
#> $filter_peaks_by_fraction_across$min_frac
#> [1] 0.9
#>
#> $filter_peaks_by_fraction_across$method
#> [1] "across"
#>
#> $filter_peaks_by_fraction_across$qc_label
#> [1] "QC"
#>
#> $filter_peaks_by_fraction_across$remove_peaks
#> [1] TRUE
#>
#>
#> $filter_peaks_by_rsd
#> $filter_peaks_by_rsd$max_rsd
#> [1] 30
#>
#> $filter_peaks_by_rsd$qc_label
#> [1] "QC"
#>
#> $filter_peaks_by_rsd$remove_peaks
#> [1] TRUE
```

# 7 Data normalisation

Next, we will apply probabilistic quotient normalisation (PQN).

```
MTBLS79_pqn_normalised <- pqn_normalisation(df=MTBLS79_filtered,
    classes=MTBLS79_filtered$Class, qc_label="QC")
```

# 8 Missing value imputation

A unified function call for several commonly used missing value imputation
algorithms is also included in pmp. Supported methods are: k-nearest neighbours
(knn), random forests (rf), Bayesian PCA missing value estimator (bpca), mean
or median value of the given feature and a constant small value. In the example
below we will apply knn imputation.

Within `mv_imputaion` interface user can easily apply different
mehtod without worrying about input data type or tranposing dataset.

```
MTBLS79_mv_imputed <- mv_imputation(df=MTBLS79_pqn_normalised,
    method="knn")
```

# 9 Data scaling

The generalised logarithm (glog) transformation algorithm is available to
stabilise the variance across low and high intensity mass spectral features.

```
MTBLS79_glog <- glog_transformation(df=MTBLS79_mv_imputed,
    classes=MTBLS79_filtered$Class, qc_label="QC")
```

`glog_transformation` function uses QC samples to optimse scaling factor
`lambda`. Using the function `glog_plot_plot_optimised_lambda` it’s possible to
visualise if the optimsation of the given parameter has converged at the
minima.

```
opt_lambda <-
    processing_history(MTBLS79_glog)$glog_transformation$lambda_opt
glog_plot_optimised_lambda(df=MTBLS79_mv_imputed,
    optimised_lambda=opt_lambda,
    classes=MTBLS79_filtered$Class, qc_label="QC")
```

![](data:image/png;base64...)

# 10 Data integrity check and endomorphisms

Functions in the `pmp` package are designed to validate input data if the user
chooses not to use the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* class object.

For example, if the input `matrix` consists of features stored in columns and
samples in rows or *vice versa*, any function within the `pmp` package will be
able to handle this in the correct manner.

```
peak_matrix <- t(assay(MTBLS79))
sample_classes <- MTBLS79$Class

class(peak_matrix)
#> [1] "matrix" "array"
dim(peak_matrix)
#> [1]  172 2488
class(sample_classes)
#> [1] "character"
```

Let’s try to use these objects as input for `mv_imputation` and
`filter_peaks_by_rsd`.

```
mv_imputed <- mv_imputation(df=peak_matrix, method="mn")
#> Warning in check_peak_matrix(df = df, classes = classes): Peak table was transposed to have features as rows and samples
#>     in columns.
#>
#>     There were no class labels available please check that peak table is
#>
#>     still properly rotated.
#>
#>     Use 'check_df=FALSE' to keep original peak matrix orientation.
rsd_filtered <- filter_peaks_by_rsd(df=mv_imputed, max_rsd=30,
    classes=sample_classes, qc_label="QC")

class (mv_imputed)
#> [1] "matrix" "array"
dim (mv_imputed)
#> [1] 2488  172

class (rsd_filtered)
#> [1] "matrix" "array"
dim (rsd_filtered)
#> [1] 1630  172
```

Note that `pmp` has automatically transposed the input object to use the
largest dimension as features, while the original R data type `matrix` has been
retained also for the function output.

# 11 Session information

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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] pmp_1.22.1                  BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6         impute_1.84.0        xfun_0.54
#>  [4] bslib_0.9.0          ggplot2_4.0.0        lattice_0.22-7
#>  [7] vctrs_0.6.5          tools_4.5.1          Rdpack_2.6.4
#> [10] parallel_4.5.1       missForest_1.6.1     tibble_3.3.0
#> [13] pkgconfig_2.0.3      Matrix_1.7-4         RColorBrewer_1.1-3
#> [16] S7_0.2.0             rngtools_1.5.2       lifecycle_1.0.4
#> [19] stringr_1.6.0        compiler_4.5.1       farver_2.1.2
#> [22] tinytex_0.57         codetools_0.2-20     htmltools_0.5.8.1
#> [25] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
#> [28] jquerylib_0.1.4      DelayedArray_0.36.0  cachem_1.1.0
#> [31] magick_2.9.0         doRNG_1.8.6.2        iterators_1.0.14
#> [34] abind_1.4-8          foreach_1.5.2        pcaMethods_2.2.0
#> [37] tidyselect_1.2.1     digest_0.6.37        stringi_1.8.7
#> [40] dplyr_1.1.4          reshape2_1.4.4       bookdown_0.45
#> [43] labeling_0.4.3       fastmap_1.2.0        grid_4.5.1
#> [46] cli_3.6.5            SparseArray_1.10.1   magrittr_2.0.4
#> [49] S4Arrays_1.10.0      dichromat_2.0-0.1    randomForest_4.7-1.2
#> [52] withr_3.0.2          scales_1.4.0         rmarkdown_2.30
#> [55] XVector_0.50.0       ranger_0.17.0        evaluate_1.0.5
#> [58] knitr_1.50           rbibutils_2.4        rlang_1.1.6
#> [61] itertools_0.1-3      Rcpp_1.1.0           glue_1.8.0
#> [64] BiocManager_1.30.26  jsonlite_2.0.0       plyr_1.8.9
#> [67] R6_2.6.1
```

# References

Broadhurst, D., Goodacre, R., Reinke, S.N., et al. (2018) Guidelines and considerations for the use of system suitability and quality control samples in mass spectrometry assays applied in untargeted clinical metabolomic studies. *Metabolomics*, 14 (6): 72. doi:[10.1007/s11306-018-1367-3](https://doi.org/10.1007/s11306-018-1367-3).

Di Guida, R., Engel, J., Allwood, J.W., et al. (2016) Non-targeted uhplc-ms metabolomic data processing methods: A comparative investigation of normalisation, missing value imputation, transformation and scaling. *Metabolomics*, 12 (5): 93. doi:[10.1007/s11306-016-1030-9](https://doi.org/10.1007/s11306-016-1030-9).

Kirwan, J.A., Weber, R.J., Broadhurst, D.I., et al. (2014) Direct infusion mass spectrometry metabolomics dataset: A benchmark for data processing and quality control. *Scientific data*, 1: 140012. doi:[10.1038/sdata.2014.12](https://doi.org/10.1038/sdata.2014.12).

Schiffman, C., Petrick, L., Perttula, K., et al. (2019) Filtering procedures for untargeted LC-MS metabolomics data. *BMC Bioinformatics*, 20 (1): 334. doi:[10.1186/s12859-019-2871-9](https://doi.org/10.1186/s12859-019-2871-9).

Stanstrup, J., Broeckling, C.D., Helmus, R., et al. (2019) The metaRbolomics Toolbox in Bioconductor and beyond. *Metabolites*, 9 (10). doi:[10.3390/metabo9100200](https://doi.org/10.3390/metabo9100200).