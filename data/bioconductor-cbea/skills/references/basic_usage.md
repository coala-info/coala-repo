Code

* Show All Code
* Hide All Code

# CBEA: Competitive Balances for Taxonomic Enrichment Analysis

Quang P.Nguyen1,2\*, Anne G. Hoen1,2,3\*\* and H. Robert Frost2\*\*\*

1Department of Epidemiology at Dartmouth College
2Department of Biomedical Data Science at Dartmouth College
3Department of Microbiology and Immunology at Dartmouth College

\*quangpmnguyen@gmail.com
\*\*Anne.G.Hoen@Dartmouth.edu
\*\*\*Hildreth.R.Frost@Dartmouth.edu

#### 1 November 2022

#### Package

CBEA 1.2.0

# 1 Introduction

This package implements the CBEA approach for performing set-based enrichment analysis for microbiome relative abundance data. A preprint of the package can be found [on bioXriv](https://www.biorxiv.org/content/10.1101/2021.09.07.459294v1.full). In summary, CBEA (Competitive Balances for taxonomic Enrichment Analysis) provides an estimate of the activity of a set by transforming an input taxa-by-sample data matrix into a corresponding set-by-sample data matrix. The resulting output can be used for additional downstream analyses such as differential abundance, classification, clustering, etc. using set-based features instead of the original units.

The transformation that CBEA applies is based on the isometric log ratio transformation:

The inference procedure is performed through estimating the null distribution of the test statistic. This can be done either via permutations or a parametric fit of a distributional form on the permuted scores. Users can also adjust for variance inflation due to inter-taxa correlation. Please refer to the main manuscript for any additional details.

# 2 Usage guide

## 2.1 Install `CBEA`

*[CBEA](https://bioconductor.org/packages/3.16/CBEA)* is an `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. It requires installing the `R` open source statistical programming language, which can be accessed on any operating system from [CRAN](https://cran.r-project.org/). After which you can install *[CBEA](https://bioconductor.org/packages/3.16/CBEA)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("CBEA")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

If there are any issues with the installation procedure or package features, the best place would be to file an issue at the GitHub [repository](https://github.com/qpmnguyen/CBEA). For any additional support you can use the [Bioconductor support site](https://support.bioconductor.org/) and use the `CBEA` tag and check [the older posts](https://support.bioconductor.org/t/CBEA/). Please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

```
library("CBEA")
library(BiocSet)
library(tidyverse)
set.seed(1020)
```

## 2.2 Loading sample data

First, we can load some pre-packaged data sets contained in *[CBEA](https://bioconductor.org/packages/3.16/CBEA)*. Here we’re loading the data from the Human Microbiome Project (HMP) in `TreeSummarizedExperiment` data container from the *[TreeSummarizedExperiment](https://bioconductor.org/packages/3.16/TreeSummarizedExperiment)*. This package does not support `phyloseq` from the *[phyloseq](https://bioconductor.org/packages/3.16/phyloseq)* package but users can leverage the *[mia](https://bioconductor.org/packages/3.16/mia)* package to convert between the data types.

In addition, users can also input raw matrices or data frames, however those require additional arguments. The `taxa_are_rows` argument requires users specify whether the data frame/matrix has taxa abundances as rows (or as columns). The `id_col` argument requires users to specify (for data frames only) a vector of names of row metadata that will be excluded from the analysis.

```
data("hmp_gingival")
abun <- hmp_gingival$data
metab_sets <- hmp_gingival$set
abun # this is a TreeSummarizedExperiment object
#> class: TreeSummarizedExperiment
#> dim: 5378 369
#> metadata(4): experimentData phylogeneticTree experimentData
#>   phylogeneticTree
#> assays(1): 16SrRNA
#> rownames(5378): OTU_97.10005 OTU_97.10006 ... OTU_97.9991 OTU_97.9995
#> rowData names(7): CONSENSUS_LINEAGE SUPERKINGDOM ... FAMILY GENUS
#> colnames(369): 700014427 700014521 ... 700111587 700111758
#> colData names(7): RSID VISITNO ... HMP_BODY_SUBSITE SRS_SAMPLE_ID
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> rowLinks: NULL
#> rowTree: NULL
#> colLinks: NULL
#> colTree: NULL
```

## 2.3 Input sets

CBEA accepts any type of sets, as long as it is in the `BiocSet` format where the elements in the sets can be matched to taxa names in the data set. The main function will check if these names match.

```
metab_sets
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 4,828 × 1
#>   element
#>   <chr>
#> 1 OTU_97.10005
#> 2 OTU_97.10053
#> 3 OTU_97.10090
#> # … with 4,825 more rows
#>
#> es_set():
#> # A tibble: 3 × 1
#>   set
#>   <chr>
#> 1 F Anaerobic
#> 2 Aerobic
#> 3 Anaerobic
#>
#> es_elementset() <active>:
#> # A tibble: 4,828 × 2
#>   element      set
#>   <chr>        <chr>
#> 1 OTU_97.10005 F Anaerobic
#> 2 OTU_97.10053 F Anaerobic
#> 3 OTU_97.10090 F Anaerobic
#> # … with 4,825 more rows
```

For more information on `BiocSet`, please refer to the documentation from *[BiocSet](https://bioconductor.org/packages/3.16/BiocSet)*. However, simply speaking, `BiocSet` acts similar to a list of three data frames and can be used in conjunction with *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*/*[tidyr](https://CRAN.R-project.org/package%3Dtidyr)*.

## 2.4 Applying CBEA

After specifying the inputs, `cbea` is the main function to apply the method. If there are zeros in the abundance data, the `cbea` will add a pseudocount to avoid issues with the log-ratio transformation (but will throw a warning). If a different zero-handling approach is desired, users should pre-process the abundance data with the appropriate method. For parametric fits, `cbea` relies on the *[fitdistrplus](https://CRAN.R-project.org/package%3Dfitdistrplus)* and *[mixtools](https://CRAN.R-project.org/package%3Dmixtools)* packages to estimate the parameters of the null. Specific arguments to control this fitting procedure can be provided as a named list in the `control` argument.

```
results <- cbea(abun, set = metab_sets, abund_values = "16SrRNA",
              output = "cdf", distr = "mnorm", adj = TRUE, thresh = 0.05, n_perm = 10)
#> Warning in .local(obj, set, output, distr, adj, n_perm, parametric, thresh, : Taxonomic count table contains zeros,
#>             which would invalidate the log-ratio transform.
#>             Adding a pseudocount of 1e-5...
#> number of iterations= 644
#> number of iterations= 1253
#> number of iterations= 468
#> number of iterations= 847
#> number of iterations= 612
#> number of iterations= 105
results
#> CBEA output of class 'CBEAout' with 369 samples and 3 sets
#>  Fit type: Parametric with 2-component Gaussian Mixture Distribution
#>  Number of permutations: 10
#>  Output type: CDF values (cdf)
```

Some important arguments to control the behaviour of CBEA.

* `output`: This controls what type of output is being returned. CBEA usually estimates a parametric null and users can specify what they want in return. If users want to perform downstream analysis with set-level features, they can return CDF values or z-scores of each raw score computed against that distribution (options `cdf` or `zscore`). Alternatively, users can just return the raw scores themselves (no distribution fitting will be performed) using `raw` as the option. Users can also use this distribution to estimate unadjusted p-values (option `pval`) to see whether a set is enriched at each sample. These unadjusted p-values can be converted based on a threshold (based on `thresh` which is default to be set at 0.05) into a dummy variable indicating enrichment (option `sig`). **Note**: CDF values and Z-scores are not available for non-parametric null estimations.
* `parametric`: This is a logical argument to specify whether a the null distribution will be specified via parametric fit or via non-parametric permutation testing. If `parametric` is `TRUE`, users need to specify `distr` and `adj`. If `parametric` is `FALSE`, users need to increase `n_perm`.
* `distr`: The form of the distribution if parametric fit is desired. As of now only supports `norm`, `mnorm`.
* `adj`: Whether the distribution should be adjusted for variance inflation. This procedure is done by combining the mean estimate from scores computed from permuted data set and the variance estimate from raw scores (computed on the unpermuted data set).

## 2.5 Model output

The output object is of class `CBEAout`, which is an S3 object. The underlying data structure is a list of lists, where the outer lists represent different aspects of the output. For example `R` represent the final scores while `diagnostic` represent certain goodness-of-fit statistics.

```
names(results)
#> [1] "R"              "parameters"     "diagnostic"     "fit_comparison"
#> [5] "call_param"
```

Within each aspect, there is a list of size equivalent to the total number of sets evaluated. For example, the `results` object is of size 3 representing the evaluated sets.

```
str(results$R)
#> List of 3
#>  $ Aerobic    : num [1:369] 0.9694 0.0286 0.9953 0.8842 0.5617 ...
#>  $ Anaerobic  : num [1:369] 0.000461 0.58112 0.203075 0.034167 0.088761 ...
#>  $ F Anaerobic: num [1:369] 0.997 0.89 0.303 0.96 0.863 ...
```

Users can use `tidy` and `glance` following the *[broom](https://CRAN.R-project.org/package%3Dbroom)* to process `CBEAout` into nice objects. The `tidy` function returns a `tibble` of scores (samples by set). The `glance` function returns some diagnostics. There are two options for the `glance` function: `fit_comparison` allows users to compare the l-moments of the data, the permuted data, and the final fitted distribution; `fit_diagnostic` shows goodness-of-fit statistics of the distribution fitting procedure itself, with log-likelihoods and Anderson-Darling (column “ad”) statistics.

```
tidy(results)
#> # A tibble: 369 × 4
#>    sample_ids Aerobic Anaerobic F_Anaerobic
#>    <chr>        <dbl>     <dbl>       <dbl>
#>  1 700014427   0.969   0.000461      0.997
#>  2 700014521   0.0286  0.581         0.890
#>  3 700014603   0.995   0.203         0.303
#>  4 700014749   0.884   0.0342        0.960
#>  5 700014791   0.562   0.0888        0.863
#>  6 700014917   0.720   0.134         0.898
#>  7 700014989   0.0249  0.992         0.0462
#>  8 700015076   0.685   0.0698        0.911
#>  9 700015149   0.402   0.000344      1.00
#> 10 700015215   0.0976  0.729         0.605
#> # … with 359 more rows
glance(results, "fit_comparison")
#> # A tibble: 9 × 7
#>   set_ids     final_param  distr l_location l_scale l_skewness l_kurtosis
#>   <chr>       <named list> <chr>      <dbl>   <dbl>      <dbl>      <dbl>
#> 1 Aerobic     <dbl [6]>    data      6.98     15.2   0.0300        0.114
#> 2 Aerobic     <dbl [6]>    perm     -0.0557    2.58 -0.0000123     0.131
#> 3 Aerobic     <dbl [6]>    fit       0.0768   13.0  -0.00401       0.127
#> 4 Anaerobic   <dbl [6]>    data     -6.42     20.0   0.0360        0.0917
#> 5 Anaerobic   <dbl [6]>    perm      0.758     2.54  0.0146        0.122
#> 6 Anaerobic   <dbl [6]>    fit       0.986    15.0   0.0104        0.132
#> 7 F_Anaerobic <dbl [6]>    data      5.88     16.5   0.0481        0.0952
#> 8 F_Anaerobic <dbl [6]>    perm     -0.465     2.71  0.000482      0.125
#> 9 F_Anaerobic <dbl [6]>    fit      -0.591    15.1   0.000309      0.123
glance(results, "fit_diagnostic")
#> # A tibble: 6 × 5
#>   set_ids     final_param   loglik    ad type
#>   <chr>       <named list>   <dbl> <dbl> <chr>
#> 1 Aerobic     <dbl [6]>    -10853. 0.229 permuted_distr
#> 2 Aerobic     <dbl [6]>     -1735. 0.141 unperm_distr
#> 3 Anaerobic   <dbl [6]>    -10791. 0.327 permuted_distr
#> 4 Anaerobic   <dbl [6]>     -1832. 0.185 unperm_distr
#> 5 F_Anaerobic <dbl [6]>    -11036. 0.321 permuted_distr
#> 6 F_Anaerobic <dbl [6]>     -1762. 0.277 unperm_distr
```

## 2.6 Parallel computing

`CBEA` has in-built capacity to perform calculations paralelled across the total number of sets. The engine for parallelization is *[BiocParallel](https://bioconductor.org/packages/3.16/BiocParallel)*. If `NULL`, `SerialParam` backend will be used.

```
BiocParallel::registered()
#> $MulticoreParam
#> class: MulticoreParam
#>   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
#>   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
#>   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
#>   bpexportglobals: TRUE; bpexportvariables: FALSE; bpforceGC: TRUE; bpfallback: TRUE
#>   bplogdir: NA
#>   bpresultdir: NA
#>   cluster type: FORK
#>
#> $SnowParam
#> class: SnowParam
#>   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
#>   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
#>   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
#>   bpexportglobals: TRUE; bpexportvariables: TRUE; bpforceGC: FALSE; bpfallback: TRUE
#>   bplogdir: NA
#>   bpresultdir: NA
#>   cluster type: SOCK
#>
#> $SerialParam
#> class: SerialParam
#>   bpisup: FALSE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB
#>   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
#>   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
#>   bpexportglobals: FALSE; bpexportvariables: FALSE; bpforceGC: FALSE; bpfallback: FALSE
#>   bplogdir: NA
#>   bpresultdir: NA
```

```
cbea(abun, set = metab_sets, abund_values = "16SrRNA",
     output = "cdf", distr = "mnorm", adj = TRUE, thresh = 0.05, n_perm = 10,
     parallel_backend = MulticoreParam(workers = 2))
```

# 3 Citing `CBEA`

We hope that *[CBEA](https://bioconductor.org/packages/3.16/CBEA)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("CBEA")
#>
#> To cite package 'CBEA' in publications use:
#>
#>   Nguyen Q (2022). _CBEA: R package for performing CBEA approach_.
#>   doi:10.18129/B9.bioc.CBEA <https://doi.org/10.18129/B9.bioc.CBEA>,
#>   https://github.com/qpmnguyen/CBEA - R package version 1.2.0,
#>   <http://www.bioconductor.org/packages/CBEA>.
#>
#>   Nguyen Q (2022). "CBEA: Competitive balances for taxonomic enrichment
#>   analysis." _bioRxiv_. doi:10.1101/TODO
#>   <https://doi.org/10.1101/TODO>,
#>   <https://www.biorxiv.org/content/10.1101/TODO>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 4 Reproducibility

The *[CBEA](https://bioconductor.org/packages/3.16/CBEA)* package (Nguyen, 2022) was made possible thanks to:

* R (R Core Team, 2022)
* *[BiocStyle](https://bioconductor.org/packages/3.16/BiocStyle)* (Oleś, 2022)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2022)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2022)
* *[broom](https://CRAN.R-project.org/package%3Dbroom)* (Robinson, Hayes, and Couch, 2022)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2021)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[mixtools](https://CRAN.R-project.org/package%3Dmixtools)* (Benaglia, Chauveau, Hunter, and Young, 2009)
* *[fitdistrplus](https://CRAN.R-project.org/package%3Dfitdistrplus)* (Delignette-Muller and Dutang, 2015)
* *[tidyverse](https://CRAN.R-project.org/package%3Dtidyverse)* (Wickham, Averick, Bryan, Chang, McGowan, François, Grolemund, Hayes, Henry, Hester, Kuhn, Pedersen, Miller, Bache, Müller, Ooms, Robinson, Seidel, Spinu, Takahashi, Vaughan, Wilke, Woo, and Yutani, 2019)
* *[BiocSet](https://bioconductor.org/packages/3.16/BiocSet)*
* *[phyloseq](https://bioconductor.org/packages/3.16/phyloseq)* (McMurdie and Holmes, 2013)
* *[BiocParallel](https://bioconductor.org/packages/3.16/BiocParallel)* (Morgan, Wang, Obenchain, Lang, Thompson, and Turaga, 2022)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.16/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("basic_usage.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("basic_usage.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2022-11-01 17:03:41 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 17.956 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.2.1 (2022-06-23)
#>  os       Ubuntu 20.04.5 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2022-11-01
#>  pandoc   2.5 @ /usr/bin/ (via rmarkdown)
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package                  * version  date (UTC) lib source
#>  AnnotationDbi              1.60.0   2022-11-01 [2] Bioconductor
#>  ape                        5.6-2    2022-03-02 [2] CRAN (R 4.2.1)
#>  assertthat                 0.2.1    2019-03-21 [2] CRAN (R 4.2.1)
#>  backports                  1.4.1    2021-12-13 [2] CRAN (R 4.2.1)
#>  bibtex                     0.5.0    2022-09-25 [2] CRAN (R 4.2.1)
#>  Biobase                    2.58.0   2022-11-01 [2] Bioconductor
#>  BiocGenerics               0.44.0   2022-11-01 [2] Bioconductor
#>  BiocIO                     1.8.0    2022-11-01 [2] Bioconductor
#>  BiocManager                1.30.19  2022-10-25 [2] CRAN (R 4.2.1)
#>  BiocParallel               1.32.0   2022-11-01 [2] Bioconductor
#>  BiocSet                  * 1.12.0   2022-11-01 [2] Bioconductor
#>  BiocStyle                * 2.26.0   2022-11-01 [2] Bioconductor
#>  Biostrings                 2.66.0   2022-11-01 [2] Bioconductor
#>  bit                        4.0.4    2020-08-04 [2] CRAN (R 4.2.1)
#>  bit64                      4.0.5    2020-08-30 [2] CRAN (R 4.2.1)
#>  bitops                     1.0-7    2021-04-24 [2] CRAN (R 4.2.1)
#>  blob                       1.2.3    2022-04-10 [2] CRAN (R 4.2.1)
#>  bookdown                   0.29     2022-09-12 [2] CRAN (R 4.2.1)
#>  broom                      1.0.1    2022-08-29 [2] CRAN (R 4.2.1)
#>  bslib                      0.4.0    2022-07-16 [2] CRAN (R 4.2.1)
#>  cachem                     1.0.6    2021-08-19 [2] CRAN (R 4.2.1)
#>  CBEA                     * 1.2.0    2022-11-01 [1] Bioconductor
#>  cellranger                 1.1.0    2016-07-27 [2] CRAN (R 4.2.1)
#>  cli                        3.4.1    2022-09-23 [2] CRAN (R 4.2.1)
#>  codetools                  0.2-18   2020-11-04 [2] CRAN (R 4.2.1)
#>  colorspace                 2.0-3    2022-02-21 [2] CRAN (R 4.2.1)
#>  crayon                     1.5.2    2022-09-29 [2] CRAN (R 4.2.1)
#>  DBI                        1.1.3    2022-06-18 [2] CRAN (R 4.2.1)
#>  dbplyr                     2.2.1    2022-06-27 [2] CRAN (R 4.2.1)
#>  DelayedArray               0.24.0   2022-11-01 [2] Bioconductor
#>  digest                     0.6.30   2022-10-18 [2] CRAN (R 4.2.1)
#>  dplyr                    * 1.0.10   2022-09-01 [2] CRAN (R 4.2.1)
#>  ellipsis                   0.3.2    2021-04-29 [2] CRAN (R 4.2.1)
#>  evaluate                   0.17     2022-10-07 [2] CRAN (R 4.2.1)
#>  fansi                      1.0.3    2022-03-24 [2] CRAN (R 4.2.1)
#>  fastmap                    1.1.0    2021-01-25 [2] CRAN (R 4.2.1)
#>  fitdistrplus               1.1-8    2022-03-10 [2] CRAN (R 4.2.1)
#>  forcats                  * 0.5.2    2022-08-19 [2] CRAN (R 4.2.1)
#>  fs                         1.5.2    2021-12-08 [2] CRAN (R 4.2.1)
#>  gargle                     1.2.1    2022-09-08 [2] CRAN (R 4.2.1)
#>  generics                   0.1.3    2022-07-05 [2] CRAN (R 4.2.1)
#>  GenomeInfoDb               1.34.0   2022-11-01 [2] Bioconductor
#>  GenomeInfoDbData           1.2.9    2022-09-28 [2] Bioconductor
#>  GenomicRanges              1.50.0   2022-11-01 [2] Bioconductor
#>  ggplot2                  * 3.3.6    2022-05-03 [2] CRAN (R 4.2.1)
#>  glue                       1.6.2    2022-02-24 [2] CRAN (R 4.2.1)
#>  goftest                    1.2-3    2021-10-07 [2] CRAN (R 4.2.1)
#>  googledrive                2.0.0    2021-07-08 [2] CRAN (R 4.2.1)
#>  googlesheets4              1.0.1    2022-08-13 [2] CRAN (R 4.2.1)
#>  gtable                     0.3.1    2022-09-01 [2] CRAN (R 4.2.1)
#>  haven                      2.5.1    2022-08-22 [2] CRAN (R 4.2.1)
#>  hms                        1.1.2    2022-08-19 [2] CRAN (R 4.2.1)
#>  htmltools                  0.5.3    2022-07-18 [2] CRAN (R 4.2.1)
#>  httr                       1.4.4    2022-08-17 [2] CRAN (R 4.2.1)
#>  IRanges                    2.32.0   2022-11-01 [2] Bioconductor
#>  jquerylib                  0.1.4    2021-04-26 [2] CRAN (R 4.2.1)
#>  jsonlite                   1.8.3    2022-10-21 [2] CRAN (R 4.2.1)
#>  KEGGREST                   1.38.0   2022-11-01 [2] Bioconductor
#>  kernlab                    0.9-31   2022-06-09 [2] CRAN (R 4.2.1)
#>  knitr                      1.40     2022-08-24 [2] CRAN (R 4.2.1)
#>  lattice                    0.20-45  2021-09-22 [2] CRAN (R 4.2.1)
#>  lazyeval                   0.2.2    2019-03-15 [2] CRAN (R 4.2.1)
#>  lifecycle                  1.0.3    2022-10-07 [2] CRAN (R 4.2.1)
#>  lmom                       2.9      2022-05-29 [2] CRAN (R 4.2.1)
#>  lubridate                  1.8.0    2021-10-07 [2] CRAN (R 4.2.1)
#>  magrittr                   2.0.3    2022-03-30 [2] CRAN (R 4.2.1)
#>  MASS                       7.3-58.1 2022-08-03 [2] CRAN (R 4.2.1)
#>  Matrix                     1.5-1    2022-09-13 [2] CRAN (R 4.2.1)
#>  MatrixGenerics             1.10.0   2022-11-01 [2] Bioconductor
#>  matrixStats                0.62.0   2022-04-19 [2] CRAN (R 4.2.1)
#>  memoise                    2.0.1    2021-11-26 [2] CRAN (R 4.2.1)
#>  mixtools                   1.2.0    2020-02-07 [2] CRAN (R 4.2.1)
#>  modelr                     0.1.9    2022-08-19 [2] CRAN (R 4.2.1)
#>  munsell                    0.5.0    2018-06-12 [2] CRAN (R 4.2.1)
#>  nlme                       3.1-160  2022-10-10 [2] CRAN (R 4.2.1)
#>  ontologyIndex              2.10     2022-08-24 [2] CRAN (R 4.2.1)
#>  pillar                     1.8.1    2022-08-19 [2] CRAN (R 4.2.1)
#>  pkgconfig                  2.0.3    2019-09-22 [2] CRAN (R 4.2.1)
#>  plyr                       1.8.7    2022-03-24 [2] CRAN (R 4.2.1)
#>  png                        0.1-7    2013-12-03 [2] CRAN (R 4.2.1)
#>  purrr                    * 0.3.5    2022-10-06 [2] CRAN (R 4.2.1)
#>  R6                         2.5.1    2021-08-19 [2] CRAN (R 4.2.1)
#>  Rcpp                       1.0.9    2022-07-08 [2] CRAN (R 4.2.1)
#>  RCurl                      1.98-1.9 2022-10-03 [2] CRAN (R 4.2.1)
#>  readr                    * 2.1.3    2022-10-01 [2] CRAN (R 4.2.1)
#>  readxl                     1.4.1    2022-08-17 [2] CRAN (R 4.2.1)
#>  RefManageR               * 1.4.0    2022-09-30 [2] CRAN (R 4.2.1)
#>  reprex                     2.0.2    2022-08-17 [2] CRAN (R 4.2.1)
#>  rlang                      1.0.6    2022-09-24 [2] CRAN (R 4.2.1)
#>  rmarkdown                  2.17     2022-10-07 [2] CRAN (R 4.2.1)
#>  RSQLite                    2.2.18   2022-10-04 [2] CRAN (R 4.2.1)
#>  rvest                      1.0.3    2022-08-19 [2] CRAN (R 4.2.1)
#>  S4Vectors                  0.36.0   2022-11-01 [2] Bioconductor
#>  sass                       0.4.2    2022-07-16 [2] CRAN (R 4.2.1)
#>  scales                     1.2.1    2022-08-20 [2] CRAN (R 4.2.1)
#>  segmented                  1.6-0    2022-05-31 [2] CRAN (R 4.2.1)
#>  sessioninfo              * 1.2.2    2021-12-06 [2] CRAN (R 4.2.1)
#>  SingleCellExperiment       1.20.0   2022-11-01 [2] Bioconductor
#>  stringi                    1.7.8    2022-07-11 [2] CRAN (R 4.2.1)
#>  stringr                  * 1.4.1    2022-08-20 [2] CRAN (R 4.2.1)
#>  SummarizedExperiment       1.28.0   2022-11-01 [2] Bioconductor
#>  survival                   3.4-0    2022-08-09 [2] CRAN (R 4.2.1)
#>  tibble                   * 3.1.8    2022-07-22 [2] CRAN (R 4.2.1)
#>  tidyr                    * 1.2.1    2022-09-08 [2] CRAN (R 4.2.1)
#>  tidyselect                 1.2.0    2022-10-10 [2] CRAN (R 4.2.1)
#>  tidytree                   0.4.1    2022-09-26 [2] CRAN (R 4.2.1)
#>  tidyverse                * 1.3.2    2022-07-18 [2] CRAN (R 4.2.1)
#>  treeio                     1.22.0   2022-11-01 [2] Bioconductor
#>  TreeSummarizedExperiment   2.6.0    2022-11-01 [2] Bioconductor
#>  tzdb                       0.3.0    2022-03-28 [2] CRAN (R 4.2.1)
#>  utf8                       1.2.2    2021-07-24 [2] CRAN (R 4.2.1)
#>  vctrs                      0.5.0    2022-10-22 [2] CRAN (R 4.2.1)
#>  withr                      2.5.0    2022-03-03 [2] CRAN (R 4.2.1)
#>  xfun                       0.34     2022-10-18 [2] CRAN (R 4.2.1)
#>  xml2                       1.3.3    2021-11-30 [2] CRAN (R 4.2.1)
#>  XVector                    0.38.0   2022-11-01 [2] Bioconductor
#>  yaml                       2.3.6    2022-10-18 [2] CRAN (R 4.2.1)
#>  yulab.utils                0.0.5    2022-06-30 [2] CRAN (R 4.2.1)
#>  zlibbioc                   1.44.0   2022-11-01 [2] Bioconductor
#>
#>  [1] /tmp/RtmpFk8vuH/Rinst1569ab346501a5
#>  [2] /home/biocbuild/bbs-3.16-bioc/R/library
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.16/BiocStyle)* (Oleś, 2022)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2022) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, McPherson et al., 2022) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2022rmarkdown)
J. Allaire, Y. Xie, J. McPherson, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.17.
2022.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-benaglia2009mixtools)
T. Benaglia, D. Chauveau, D. R. Hunter, et al.
“mixtools: An R Package for Analyzing Finite Mixture Models”.
In: *Journal of Statistical Software* 32.6 (2009), pp. 1–29.
URL: <http://www.jstatsoft.org/v32/i06/>.

[[3]](#cite-delignettemuller2015fitdistrplus)
M. L. Delignette-Muller and C. Dutang.
“fitdistrplus: An R Package for Fitting Distributions”.
In: *Journal of Statistical Software* 64.4 (2015), pp. 1–34.
DOI: [10.18637/jss.v064.i04](https://doi.org/10.18637/jss.v064.i04).

[[4]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[5]](#cite-mcmurdie2013phyloseq)
P. J. McMurdie and S. Holmes.
“phyloseq: An R package for reproducible interactive analysis and graphics of microbiome census data”.
In: *PLoS ONE* 8.4 (2013), p. e61217.
URL: <http://dx.plos.org/10.1371/journal.pone.0061217>.

[[6]](#cite-morgan2022biocparallel)
M. Morgan, J. Wang, V. Obenchain, et al.
*BiocParallel: Bioconductor facilities for parallel evaluation*.
R package version 1.32.0.
2022.
URL: <https://github.com/Bioconductor/BiocParallel>.

[[7]](#cite-nguyen2022cbea)
Q. Nguyen.
*CBEA: R package for performing CBEA approach*.
<https://github.com/qpmnguyen/CBEA> - R package version 1.2.0.
2022.
DOI: [10.18129/B9.bioc.CBEA](https://doi.org/10.18129/B9.bioc.CBEA).
URL: <http://www.bioconductor.org/packages/CBEA>.

[[8]](#cite-ole2022biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.26.0.
2022.
URL: <https://github.com/Bioconductor/BiocStyle>.

[[9]](#cite-2022language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2022.
URL: <https://www.R-project.org/>.

[[10]](#cite-robinson2022broom)
D. Robinson, A. Hayes, and S. Couch.
*broom: Convert Statistical Objects into Tidy Tibbles*.
R package version 1.0.1.
2022.
URL: [https://CRAN.R-project.org/package=broom](https://CRAN.R-project.org/package%3Dbroom).

[[11]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[12]](#cite-wickham2019welcome)
H. Wickham, M. Averick, J. Bryan, et al.
“Welcome to the tidyverse”.
In: *Journal of Open Source Software* 4.43 (2019), p. 1686.
DOI: [10.21105/joss.01686](https://doi.org/10.21105/joss.01686).

[[13]](#cite-wickham2021sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.2.
2021.
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[14]](#cite-xie2022knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.40.
2022.
URL: <https://yihui.org/knitr/>.