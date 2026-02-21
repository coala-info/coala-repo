# Introduction to TPP2D for 2D-TPP analysis

Nils Kurzawa

#### 30 October, 2025

#### Package

TPP2D 1.26.0

# Contents

* [1 Abstract](#abstract)
* [2 General information](#general-information)
* [3 Installation](#installation)
* [4 Introduction](#introduction)
* [5 Step-by-step workflow](#step-by-step-workflow)
* [6 Acknowledgements](#acknowledgements)
* [References](#references)

# 1 Abstract

Thermal proteome profiling (TPP) (Mateus et al., [2020](#ref-Mateus2020); Savitski et al., [2014](#ref-Savitski2014)) is an unbiased
mass spectrometry-based method to assess protein-ligand interactions. It works
by employing the cellular thermal shift assay (CETSA) (Molina et al., [2013](#ref-Molina2013)) on a
proteome-wide scale which monitors the profiles of proteins in cells
over a temperature gradient and aims to detect shifts induced by ligand-protein
interactions. 2D-TPP represents a refined version of the assay (Becher et al., [2016](#ref-Becher2016))
which uses a concentration gradient of the ligand of interest over a temperature
gradient. This package aims to analyze data retrieved from 2D-TPP experiments by
a functional analysis approach.

# 2 General information

This package implements a method to detect ligand-protein interactions from
datasets obtained with the 2D-TPP assay. Please note that methods for analyzing
convential TPP datasets (e.g. single dose, melting curve approach) can be found
at: [`TPP`](https://bioconductor.org/packages/release/bioc/html/TPP.html) and
[`NPARC`](https://bioconductor.org/packages/release/bioc/html/NPARC.html) .

This vignette is not aiming to give an in-depth introduction to thermal
proteome profiling, please refer to other sources for this purpose:

* [Original TPP publication](http://science.sciencemag.org/content/346/6205/1255784)
* [2D-TPP publication](https://www.nature.com/articles/nchembio.2185)
* [review article](https://www.embopress.org/doi/10.15252/msb.20199232)

**Note:** if you use `TPP2D` in published research, please cite:

> Kurzawa, N.\*, Becher, I.\* *et al.* (2020)
> A computational method for detection of ligand-binding proteins from dose range thermal proteome profiles.
> *Nat. Commun.*, [10.1038/s41467-020-19529-8](https://doi.org/10.1038/s41467-020-19529-8)

# 3 Installation

1. Download the package from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("TPP2D")
```

Or install the development version of the package from Github.

```
BiocManager::install("nkurzaw/TPP2D")
```

2. Load the package into R session.

```
library(TPP2D)
```

# 4 Introduction

The 2D-TPP assay is usually set up in a way that for each temperature different
ligand concentrations (including a vehicle condition) are used and two adjacent
temperatures each are multiplexed in a single mass spectrometry (MS) run.
Typically up to 10 or 12 temperatures are used in total that add up to 5
or 6 MS runs respectively (Figure 1).

![Experimental 2D-TPP workflow.](data:image/jpeg;base64...)

Figure 1: Experimental 2D-TPP workflow

This package aims to provide a tool for finding ligand-protein interactions, i.e. proteins affected in their thermal stability by the treatment used in the
experiment) at a given false disscovery rate (FDR). Please note that a change in
thermal stability of a protein is not a guarantee for it interacting with the molecule used as treatment. However, we try to give the user additional
information by specifying whether an observed effect is likely due to
stabilization or a change in expression or solubility of a given protein to make the interpretation of detected hits as easy as possible.

# 5 Step-by-step workflow

```
library(dplyr)
library(TPP2D)
```

After having loaded `dplyr` and the `TPP2D` package itself we start by loading
an example dataset which is supplied with the package. Therefore, we use
the `import2dDataset` function.

```
data("config_tab")
data("raw_dat_list")

config_tab
```

```
##     Compound Experiment Temperature 126 127L 127H 128L 128H 129L 129H 130L 130H
## 1  Compound1       exp1        37.0   0  0.5    2   10   40    -    -    -    -
## 2  Compound1       exp1        37.8   -    -    -    -    -    0  0.5    2   10
## 3  Compound1       exp2        40.4   0  0.5    2   10   40    -    -    -    -
## 4  Compound1       exp2        44.0   -    -    -    -    -    0  0.5    2   10
## 5  Compound1       exp3        46.9   0  0.5    2   10   40    -    -    -    -
## 6  Compound1       exp3        49.8   -    -    -    -    -    0  0.5    2   10
## 7  Compound1       exp4        52.9   0  0.5    2   10   40    -    -    -    -
## 8  Compound1       exp4        55.5   -    -    -    -    -    0  0.5    2   10
## 9  Compound1       exp5        58.6   0  0.5    2   10   40    -    -    -    -
## 10 Compound1       exp5        62.0   -    -    -    -    -    0  0.5    2   10
## 11 Compound1       exp6        65.4   0  0.5    2   10   40    -    -    -    -
## 12 Compound1       exp6        66.3   -    -    -    -    -    0  0.5    2   10
##    131L RefCol
## 1     -    126
## 2    40   129L
## 3     -    126
## 4    40   129L
## 5     -    126
## 6    40   129L
## 7     -    126
## 8    40   129L
## 9     -    126
## 10   40   129L
## 11    -    126
## 12   40   129L
```

We then call the import function (note: we here supply a list of data frames
for the “data” argument, replacing the raw data files that would be normally
specified in the above mentioned column of the config table. If this is
supplied the argument “data” can simply be ignored):

```
import_df <- import2dDataset(
    configTable = config_tab,
    data = raw_dat_list,
    idVar = "protein_id",
    intensityStr = "signal_sum_",
    fcStr = "rel_fc_",
    nonZeroCols = "qusm",
    geneNameVar = "gene_name",
    addCol = NULL,
    qualColName = "qupm",
    naStrs = c("NA", "n/d", "NaN"),
    concFactor = 1e6,
    medianNormalizeFC = TRUE,
    filterContaminants = TRUE)
```

```
## The following valid label columns were detected:
## 126, 127L, 127H, 128L, 128H, 129L, 129H, 130L, 130H, 131L.
```

```
## Importing 2D-TPP dataset: exp1
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 20 out of 20 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp1
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 20 out of 20 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp2
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 20 out of 20 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp2
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 20 out of 20 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp3
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 15 out of 15 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp3
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 15 out of 15 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp4
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 14 out of 14 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp4
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 14 out of 14 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp5
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 9 out of 9 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp5
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 9 out of 9 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp6
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 4 out of 4 rows kept for further analysis.
```

```
## Importing 2D-TPP dataset: exp6
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 4 out of 4 rows kept for further analysis.
```

```
## Ratios were correctly computed!
```

```
## Median normalizing fold changes...
```

```
recomp_sig_df <- recomputeSignalFromRatios(import_df)

# resolve ambiguous protein names
preproc_df <- resolveAmbiguousProteinNames(recomp_sig_df)
# alternatively one could choose to run
# preproc_df <- resolveAmbiguousProteinNames(
#     recomp_sig_df, includeIsoforms = TRUE)
```

Please refer to the help page of the function to retrieve in-depth description
of the different arguments. Essentially the function needs to know the names
or prefixes of the columns in the raw data files, that contain different
informations like protein id or the raw or relative signal intensities
measured for the different TMT labels.
The imported synthetic dataset consists of 17 simulated protein 2D thermal
profiles (protein1-17) and 3 spiked-in true positives (tp1-3). It represents
a data frame with the columns:

| column | description | required |
| --- | --- | --- |
| representative | protein identifier | Yes |
| qupm | number of unique quantified peptides | No |
| qusm | number of unique spectra | No |
| clustername | gene name | Yes |
| temperature | temperature incubated at | Yes |
| experiment | experiment identifier | No |
| label | TMT label | No |
| RefCol | RefCol | No |
| conc | treatment concentration | No |
| raw\_value | raw reporter ion intensity sum | No |
| raw\_rel\_value | raw relative fold change compared to vehicle condition at the same temperature | No |
| log\_conc | log10 treatment concentration | Yes |
| rel\_value | median normalized fold change | No |
| value | recomputed reporter ion intensity | No |
| log2\_value | recomputed log2 reporter ion intensity | Yes |

Here the column “required” indicates which of these columns is
neccessary for usage of the downstream functions.

We then begin our actual data analysis by fitting two nested models to
each protein profile: A null model that is expected when a protein profile
remains unaffected by a given treatment and an alternative model which is
a constrained sigmoidal dose-response model across all temperatures.

```
model_params_df <- getModelParamsDf(
    df = preproc_df)
```

The goodness of fit of both models for each protein is then compared and
a \(F\)-statistic is computed.

```
fstat_df <- computeFStatFromParams(model_params_df)
```

Then we create a null model using our dataset to be able to estimate the
FDR for a given \(F\)-statistic in the next step.

```
set.seed(12, kind = "L'Ecuyer-CMRG")
null_model <- bootstrapNullAlternativeModel(
    df = preproc_df,
    params_df = model_params_df,
    B = 2)
```

```
## [1] "Warning: You have specificed B < 20, it is recommended to use at least B = 20 in order to obtain reliable results."
##
  |
  |                                                                      |   0%
  |
  |====                                                                  |   5%
  |
  |=======                                                               |  10%
  |
  |==========                                                            |  15%
  |
  |==============                                                        |  20%
  |
  |==================                                                    |  25%
  |
  |=====================                                                 |  30%
  |
  |========================                                              |  35%
  |
  |============================                                          |  40%
  |
  |================================                                      |  45%
  |
  |===================================                                   |  50%
  |
  |======================================                                |  55%
  |
  |==========================================                            |  60%
  |
  |==============================================                        |  65%
  |
  |=================================================                     |  70%
  |
  |====================================================                  |  75%
  |
  |========================================================              |  80%
  |
  |============================================================          |  85%
  |
  |===============================================================       |  90%
  |
  |==================================================================    |  95%
  |
  |======================================================================| 100%
```

Please note that setting \(B = 2\) (corresponsing to \(2\)
permutations) is not enough to guarantee faithful FDR estimation, this
has simply been set for fast demonstration purposes. We recommend to
use at least \(B = 20\) for applications in praxis.

To estimate the FDR for all given \(F\)-statistics and retrieve all
significant hits at a set FDR \(\alpha\) we use the following functions:

```
fdr_tab <- getFDR(
    df_out = fstat_df,
    df_null = null_model)

hits <- findHits(
    fdr_df = fdr_tab,
    alpha = 0.1)

hits %>%
    dplyr::select(clustername, nObs, F_statistic, FDR)
```

```
## # A tibble: 6 × 4
##   clustername  nObs F_statistic   FDR
##   <chr>       <int>       <dbl> <dbl>
## 1 tp2            30       53.9      0
## 2 tp1            20       47.7      0
## 3 tp3            50       31.4      0
## 4 protein10      50        2.41     0
## 5 protein15      50        1.79     0
## 6 protein16      40        1.49     0
```

We can now plot our obtained result as a (one-sided) volcano plot:

```
plot2dTppVolcano(fdr_df = fdr_tab, hits_df = hits)
```

![](data:image/png;base64...)

Finally, we can fit and plot proteins that have come up as
significant in our analysis by using:

```
plot2dTppFit(recomp_sig_df, "tp1",
             model_type = "H0",
             dot_size = 1,
             fit_color = "darkorange")
```

![](data:image/png;base64...)
or respectively for the H1 model:

```
plot2dTppFit(recomp_sig_df, "tp1",
             model_type = "H1",
             dot_size = 1,
             fit_color = "darkgreen")
```

![](data:image/png;base64...)

An alternative option to visualize thermal profiles of proteins of interest is to use `plot2dTppFcHeatmap`:

```
plot2dTppFcHeatmap(recomp_sig_df, "tp1",
                   drug_name = "drug X")
```

![](data:image/png;base64...)

```
plot2dTppFcHeatmap(recomp_sig_df, "tp3",
                   drug_name = "drug X")
```

![](data:image/png;base64...)

# 6 Acknowledgements

We thank the following people for valuable feedback and help with the `TPP2D` package:

* André Mateus
* Constantin Ahlmann-Eltze
* Alexander Helmboldt
* Stefan Gade
* Dorothee Childs
* Nikos Ignatiadis
* Britta Velten

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## Random number generation:
##  RNG:     L'Ecuyer-CMRG
##  Normal:  Inversion
##  Sample:  Rejection
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
## [1] TPP2D_1.26.0     dplyr_1.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] utf8_1.2.6          tidyr_1.3.1         sass_0.4.10
##  [4] generics_0.1.4      bitops_1.0-9        stringi_1.8.7
##  [7] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
## [10] grid_4.5.1          RColorBrewer_1.1-3  bookdown_0.45
## [13] iterators_1.0.14    fastmap_1.2.0       foreach_1.5.2
## [16] doParallel_1.0.17   jsonlite_2.0.0      zip_2.3.3
## [19] limma_3.66.0        tinytex_0.57        BiocManager_1.30.26
## [22] purrr_1.1.0         scales_1.4.0        codetools_0.2-20
## [25] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [28] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
## [31] tools_4.5.1         parallel_4.5.1      BiocParallel_1.44.0
## [34] ggplot2_4.0.0       vctrs_0.6.5         R6_2.6.1
## [37] magick_2.9.0        lifecycle_1.0.4     stringr_1.5.2
## [40] MASS_7.3-65         pkgconfig_2.0.3     pillar_1.11.1
## [43] bslib_0.9.0         openxlsx_4.2.8      gtable_0.3.6
## [46] glue_1.8.0          Rcpp_1.1.0          statmod_1.5.1
## [49] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
## [52] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
## [55] htmltools_0.5.8.1   labeling_0.4.3      rmarkdown_2.30
## [58] compiler_4.5.1      S7_0.2.0            RCurl_1.98-1.17
```

# References

Becher, I., Werner, T., Doce, C., Zaal, E.A., Tögel, I., Khan, C.A., Rueger, A., Muelbaier, M., Salzer, E., Berkers, C.R., et al. (2016). Thermal profiling reveals phenylalanine hydroxylase as an off-target of panobinostat. Nature Chemical Biology *12*, 908–910.

Mateus, A., Kurzawa, N., Becher, I., Sridharan, S., Helm, D., Stein, F., Typas, A., and Savitski, M.M. (2020). Thermal proteome profiling for interrogating protein interactions. Molecular Systems Biology *16*, e9232.

Molina, D.M., Jafari, R., Ignatushchenko, M., Seki, T., Larsson, E.A., Dan, C., Sreekumar, L., Cao, Y., and Nordlund, P. (2013). Monitoring Drug Target Engagement in Cells and Tissues Using the Cellular Thermal Shift Assay. Science *341*, 84–88.

Savitski, M.M., Reinhard, F.B.M., Franken, H., Werner, T., Savitski, M.F., Eberhard, D., Martinez Molina, D., Jafari, R., Dovega, R.B., Klaeger, S., et al. (2014). Tracking cancer drugs in living cells by thermal profiling of the proteome. Science *346*, 1255784.