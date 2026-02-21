# HarmonizR\_Vignette

#### Simon Schlumbohm

#### 2025-10-30

## Introduction

HarmonizR is a framework around the popular batch effect reduction algorithms `ComBat` and `limma`, who, on their own, are unable to deal with missing data points within the data. Missing values are not uncommon in biological data, especially in the field of proteomics, for which the tool has originally been developed. HarmonizR uses a matrix dissection approach to circumvent the problematic existence of missing values and still apply established batch effect reduction strategies. Recent updates to the HarmonizR algorithm include but are not limited to increased computational efficiency and more reliable rescue of features (e.g. proteins/genes). For a full overview we would like to direct the reader to our paper published in 2022 in Nature Communications: <https://doi.org/10.1038/s41467-022-31007-x>

All information regarding the upcoming sections can also be found within our SOP on Github, which is found under the following link: <https://www.github.com/HSU-HPC/HarmonizR/tree/HarmonizR-1.1/HarmonizR_SOP.pdf>.

Please have a look over there as well.

## Installation

The HarmonizR implementation is 100 % written in the programming language `R`. The easiest way to install it is using the package `devtools` that can be installed from CRAN via `install.packages("devtools")` while in the `R` environment. For further information, please refer to the `devtools` documentation.

Installation from Github Repository:

The HarmonizR package (<https://github.com/HSU-HPC/HarmonizR/tree/HarmonizR-1.1> leads to the package as well as example data) can be installed directly from GitHub via the command `devtools::install_github("HSU-HPC/HarmonizR/HarmonizR@HarmonizR-1.1")`, while in the `R` software environment.

Installation from HarmonizR.zip file:

Please make sure to have `devtools` installed. Download the code via the green Code button (<https://github.com/HSU-HPC/HarmonizR/tree/HarmonizR-1.1>). Unzip the downloaded .zip file. The HarmonizR package is the folder called HarmonizR, which was within the .zip file. While in the `R` environment and while in the parent directory of said HarmonizR, enter in the command line: `devtools::install("HarmonizR")` to install the package. Alternatively, while inside the HarmonizR folder, enter `devtools::install()`.

Once installed, the HarmonizR package can be used via:

```
library(HarmonizR)
```

## Example Usage

For this example, we create a simple dataframe containing 3 features and 6 samples:

```
# create a dataframe with 3 rows and 6 columns filled with random numbers
df <- data.frame(matrix(rnorm(n = 3*6), ncol = 6))
# set the column names
colnames(df) <- c("A", "B", "C", "D", "E", "F")
# create a vector of row names
row_names <- c("F1", "F2", "F3")
# set the row names
rownames(df) <- row_names
# this is what it looks like:
df
#>             A            B          C          D          E          F
#> F1 -0.1222622 -1.531912949  0.9290892  2.1493121 -0.6478853 -1.4299514
#> F2  0.7586505  0.402682840 -0.6928646  1.6945955 -0.8050903  1.9472850
#> F3 -1.2893609 -0.003587504  0.2589552 -0.4833355 -0.1982495 -0.4480424
```

Now we create a fitting description, which assigns 2 samples to a batch (3 batches total):

```
# create a vector of batch numbers
batch <- rep(1:3, each = 2)
# create a dataframe with 6 rows and 3 columns
des <- data.frame(ID = colnames(df), sample = 1:6, batch = batch)
# this is what it looks like:
des
#>   ID sample batch
#> 1  A      1     1
#> 2  B      2     1
#> 3  C      3     2
#> 4  D      4     2
#> 5  E      5     3
#> 6  F      6     3
```

HarmonizR usage requires a single function call of the `harmonizR()` function. Here, we pass the created dataframes directly for a sequential run of HarmonizR. Alternatively, a path to the respective input files can be passed.

```
# use the harmonizR() function; turning off creation of an output .tsv file
result <- harmonizR(df, des, output_file = FALSE, cores = 1)
#> Initializing HarmonizR...
#> Reading the files...
#> Preparing...
#> Splitting the data using ComBat adjustment...
#> Found3batches
#> Adjusting for0covariate(s) or covariate level(s)
#> Standardizing Data across genes
#> Fitting L/S model and finding priors
#> Finding parametric adjustments
#> Adjusting the Data
#> Rebuilding...
#> Termination.
```

The result mirrors the input `data.frame` closely, yet the batch-effect has been reduced by either `ComBat` or `limma`:

```
result
#>             A           B          C          D           E          F
#> F1  0.1892067 -0.75982152 -0.3229906  0.5353342  0.01850314 -0.7018856
#> F2  1.0404622  0.77251157 -0.5537184  1.1247074 -0.34138102  1.8470555
#> F3 -0.7862358  0.04906221 -0.1478693 -0.6750835 -0.14532146 -0.3958546
```

Alternatively, S4 data may be used as input. In this case, no description file is needed as long as a batch description is included within the `SummarizedExperiment`. An example input may look like this:

```
nrows <- 20
ncols <- 8
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
colData <- data.frame(Batch=c(1,1,1,1,2,2,2,2))
SummExp = SummarizedExperiment::SummarizedExperiment(
    assays=list(counts=counts),
    colData=colData)
```

It may be passed instead of `data_as_input` (following parameter explanation).

### Parameters

HarmonizR expects 2 mandatory and a total of nine optional arguments. First, the mandatory ones:

* `data_as_input`
* `description_as_input`

The first argument `data_as_input`, is the path to the raw data, the second argument, `description_as_input`, is the path to the description file. Both input files can be given via their file path and do not have to be read in separately by hand. This method is recommended, as it ensures correct operation if the notes regarding Input above are followed. Alternatively, both parameters can be passed as dataframes or matrices as long as they are fitting the expected input layout.

Next will be four optional arguments found also within the already published HarmonizR:

* `algorithm`
* `ComBat_mode`
* `plot`
* `output_file`

The first optional argument is the algorithm of choice. `ComBat` will be used by default, but using the parameter `algorithm`, either `"ComBat"` or `"limma"` can be chosen for data adjustment. `"ComBat"` serves as the default. The second optional argument is `ComBat_mode`. This parameter is only valid once `ComBat` is chosen for the adjustment.

The `ComBat` mode is abbreviated for simplicity by using integers:

```
ComBat_mode     Corresponding ComBat Arguments

1 (default)     par.prior = TRUE, mean.only = FALSE

2               par.prior = TRUE, mean.only = TRUE

3               par.prior = FALSE, mean.only = FALSE

4               par.prior = FALSE, mean.only = TRUE
```

Please refer to the `ComBat` documentation for further details.

The third optional parameter is `plot`. `plot` can be set to either `"samplemeans"`, `"featuremeans"` or `"CV"` and will show a boxplot with a box for each batch depicting the chosen method. This plot will also be saved to a .pdf. This will be either the mean for all samples, the mean for all features or the coefficient of variation. There will be a separate plot for the original, unaltered input dataset and for the `ComBat`/`limma` adjusted dataset. By default, this parameter is turned off. Since a log transformation is assumed, this will also be accounted for before plotting. Trying to plot data that has not been log transformed prior may lead to an unplottable result.

The fourth optional parameter is `output_file`. Setting this parameter will grant the user the ability to choose the name of their output .tsv file. Also, a path can be set. A string is expected as input. This parameter will default to `"cured_data"`, yielding a file called `cured_data.tsv`.

Further, the five new parameters will be explained one-by-one:

* `sort`

`sort` takes one of three available sorting algorithms as input. Either `"sparcity_sort"`, for a sparcity-based sorting, `"seriation_sort"`, using the `seriation` package and `"jaccard_sort"`, using a Jaccard-index-based sorting approach. Sorting happens prior to the adjustment and may change the way blocking is executed on the data. Sorting does not yield any benefit when the `block` parameter is unused.

* `block`

`block` takes an integer as input which dictates, how many batches should be packed together during matrix dissection. This parameter may greatly reduce the amount of sub-dataframes produced and therefore decrease the algorithm’s runtime.

* `verbosity`

`verbosity` takes an integer with the lowest accepted integer being `0`. The higher the number, the more feedback will the HarmonizR provide in the command line. A verbosity of `1` is the default and should be sufficient. `0` or `"mute"` will prevent HarmonizR from showing anything in the command line.

* `cores`

`cores` gives the user the ability to control the number of cores used by their machine during HarmonizR execution. By default, all available cores will be used.

* `ur`

`ur`, short for unique removal, can be set to either `TRUE` or `FALSE` to toggle the newly implemented removal of unique combinations for increased feature rescue. By default, this feature is applied, and it is strongly suggested to not turn it off. The parameter is available for result reproducibility.

## Session Information

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] HarmonizR_1.8.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
#>  [3] xfun_0.53                   bslib_0.9.0
#>  [5] Biobase_2.70.0              lattice_0.22-7
#>  [7] vctrs_0.6.5                 tools_4.5.1
#>  [9] generics_0.1.4              stats4_4.5.1
#> [11] parallel_4.5.1              AnnotationDbi_1.72.0
#> [13] RSQLite_2.4.3               blob_1.2.4
#> [15] Matrix_1.7-4                S4Vectors_0.48.0
#> [17] lifecycle_1.0.4             compiler_4.5.1
#> [19] Biostrings_2.78.0           statmod_1.5.1
#> [21] Seqinfo_1.0.0               codetools_0.2-20
#> [23] htmltools_0.5.8.1           sass_0.4.10
#> [25] yaml_2.3.10                 crayon_1.5.3
#> [27] jquerylib_0.1.4             BiocParallel_1.44.0
#> [29] DelayedArray_0.36.0         cachem_1.1.0
#> [31] limma_3.66.0                iterators_1.0.14
#> [33] abind_1.4-8                 foreach_1.5.2
#> [35] nlme_3.1-168                sva_3.58.0
#> [37] genefilter_1.92.0           locfit_1.5-9.12
#> [39] digest_0.6.37               splines_4.5.1
#> [41] fastmap_1.2.0               grid_4.5.1
#> [43] SparseArray_1.10.0          cli_3.6.5
#> [45] S4Arrays_1.10.0             XML_3.99-0.19
#> [47] survival_3.8-3              edgeR_4.8.0
#> [49] bit64_4.6.0-1               rmarkdown_2.30
#> [51] XVector_0.50.0              httr_1.4.7
#> [53] matrixStats_1.5.0           bit_4.6.0
#> [55] png_0.1-8                   memoise_2.0.1
#> [57] evaluate_1.0.5              knitr_1.50
#> [59] GenomicRanges_1.62.0        IRanges_2.44.0
#> [61] doParallel_1.0.17           mgcv_1.9-3
#> [63] rlang_1.1.6                 Rcpp_1.1.0
#> [65] xtable_1.8-4                DBI_1.2.3
#> [67] BiocGenerics_0.56.0         annotate_1.88.0
#> [69] jsonlite_2.0.0              R6_2.6.1
#> [71] plyr_1.8.9                  MatrixGenerics_1.22.0
```