# Power analysis for DNAm arrays

#### Sean K. Maden

#### 30 October, 2025

* [Source the revised function, `pwrEWAS_itable()`](#source-the-revised-function-pwrewas_itable)
* [Generate DNAm summary statistics](#generate-dnam-summary-statistics)
* [Run `pwrEWAS_itable()`](#run-pwrewas_itable)
* [Run power simulations with 2 cores](#run-power-simulations-with-2-cores)
* [Access the power analysis results](#access-the-power-analysis-results)
* [Plot smooths with errors using `ggplot2`](#plot-smooths-with-errors-using-ggplot2)
* [Next steps and further reading](#next-steps-and-further-reading)
* [Session Info](#session-info)
* [Works Cited](#works-cited)

This notebook describes how to run power analyses for DNAm arrays on user-defined datasets with the `pwrEWAS` method. The original `pwrEWAS` method is available as a Bioconductor [package](https://www.bioconductor.org/packages/release/bioc/html/pwrEWAS.html). There was need to make the original method extensible to new user-provided datasets, and this vignette describes how to do this with a lightly modified power analysis function, `pwrEWAS_itable()`.

# Source the revised function, `pwrEWAS_itable()`

Source the revised function from GitHub with `source_url()`. This runs the script `pwrEWAS_revised.R`, producing a series of callable functions in the active R session.

```
revised_function_url <- paste0("https://github.com/metamaden/pwrEWAS/", "blob/master/inst/revised_functions/pwrEWAS_revised.R?raw=TRUE")
devtools::source_url(revised_function_url)
```

# Generate DNAm summary statistics

`pwrEWAS` requires a set of DNAm summary statistics, specifically a table with DNAm means (e.g. a column named “mu”) and variances (e.g. a column named “var”) to inform power analysis simulations. For this example, get DNAm summary statistics from `minfiData`’s example array data, stored as a `MethylSet`, then use `rowMeans()` and `rowVars()` to compute summaries from Beta-values.

```
library(minfiData)
data("MsetEx") # load MethylSet
ms <- MsetEx
bval <- getBeta(ms) # get DNAm fractions
# get the summary data frame
dfpwr <- data.frame(mu = rowMeans(bval, na.rm = T),
                    var = rowVars(bval, na.rm = T))
```

```
head(dfpwr)
```

The particular samples used to generate the CpG probe summary statistics above can be important. Samples from a specific tissue and/or demographic may yield more relevant information from power analysis for a given experiment design task.

# Run `pwrEWAS_itable()`

There are numerous parameters for fine-tuning power analyses. For the demonstration runs below, set the following parameter values.

```
ttype <- dfpwr               # tissueType
mintss <- 10                 # minTotSampleSize
maxtss <- 1000               # maxTotSampleSize
sstep <- 100                 # SampleSizeSteps
tdeltav <- c(0.05, 0.1, 0.2) # targetDelta
dmethod <- "limma"           # DMmethod
fdr <- 0.05                  # FDRcritVal
nsim <- 20                   # sims
j <- 1000                    # J
ndmp <- 50                   # targetDmCpGs
detlim <- 0.01               # detectionLimit
maxctau <- 100               # maxCnt.tau
ncntper <- 0.5               # NcntPer
```

These effectively define the power analysis as a series of tests varying samples from a minimum of 10, to a maximum of 230, at intervals of 20 samples, for a total of 12 total max sample sizes tested with evenly distributed experiment groups. For instance, at 10 total samples each experiment group has 5 samples, etc.

Further, simulations use the `limma()` function for differential methylation test, with 50 significant probes expected at an FDR significance of 0.05 from among 5000 total simulated probes. Mean DNAm differences between experiment groups are varied across 3 possible values, either 0.05, 0.1, or 0.2. Finally, each set of test parameters will be simulated 20 times.

# Run power simulations with 2 cores

Setting the method parameters as above, run `pwrEWAS` on multiple cores by setting the argument `core` to some value >1. But first set the seed to ensure run reproducibility.

```
set.seed(0)
lpwr.c2 <- pwrEWAS_itable(core = 2,
                          tissueType = ttype, minTotSampleSize = mintss,
                          maxTotSampleSize = maxtss, SampleSizeSteps = sstep,
                          NcntPer = ncntper, targetDelta = tdeltav, J = j,
                          targetDmCpGs = ndmp, detectionLimit = detlim,
                          DMmethod = dmethod, FDRcritVal = fdr,
                          sims = nsim, maxCnt.tau = maxctau)
# [2022-02-17 13:44:51] Finding tau...done [2022-02-17 13:45:06]
# [1] "The following taus were chosen: 0.013671875, 0.02734375, 0.0546875"
# [2022-02-17 13:45:06] Running simulation
# [2022-02-17 13:45:06] Running simulation ... done [2022-02-17 13:48:23]
```

The commented status messages show the example run time was about 3:30.

# Access the power analysis results

Power analysis results are returned in a list of four objects called `"meanPower"` (a matrix), `"powerArray"` (an array), `"deltaArray"` (a list), and `"metric"`, (also a list).

The first object, `meanPower`, shows the mean power (cell values) by total sample size (y-axis, rows, from 10 to 230) and delta DNAm difference (x-axis, columns) across simulations. The dimensions and first rows of this table are shown below.

```
lpwr <- lpwr.c1           # get results from an above example
mp <- lpwr[["meanPower"]] # get the mean power table
```

```
dim(mp) # get the dimensions of mean power table
```

```
head(mp) # get first rows of mean power table
```

The second object is `powerArray`, an array of matrices containing 720 data points. This data is used to calculate the `meanPower` summaries, which can be seen by comparing mean of the first 20 `powerArray` values (e.g. the 20 simulations where total samples is 10 and delta is 0.05) to the `meanPower` cell [1,1] corresponding to delta = 0.1, total samples = 10.

```
pa <- lpwr$powerArray # get power array
```

```
length(pa) # get length of power array
```

```
## [1] 600
```

```
mean(pa[1:20]) == mp[1,1] # compare means, power array vs. mean power table
```

```
## [1] TRUE
```

The final objects show various observed values for the delta DNAm (in the `deltaArray` object), and the marginal type I error, classical power, FDR, FDC, and true positive probability (in the `metric` object).

# Plot smooths with errors using `ggplot2`

This section shows how to use the `ggplot2` package to generate publication-ready plot summaries of `pwrEWAS` power analysis results.

To plot the full simulation results with smooths and standard errors, reformat the array of matrices in the `powerArray` object. Extract the power values according to the dimensions of our simulations (e.g. 10 sample sizes times 10 simulations times 2 deltas = 200 total simulations). Finally, coerce and harmonize power values across deltas to form a tall data frame for plotting.

```
# extract power values from the array of matrices
parr <- pa
m1 <- data.frame(power = parr[1:200])   # first delta power values
m2 <- data.frame(power = parr[201:400]) # second delta power values
m3 <- data.frame(power = parr[401:600]) # third delta power values
# assign total samples to power values
m1$total.samples <- m2$total.samples <-
  m3$total.samples <- rep(seq(10, 910, 100), each = 20)
# add delta labels
m1$`Delta\nDNAm` <- rep("0.05", 200)
m2$`Delta\nDNAm` <- rep("0.1", 200)
m3$`Delta\nDNAm` <- rep("0.2", 200)
# make the tall data frame for plotting
dfp <- rbind(m1, rbind(m2, m3))
```

Make the final plot using `goem_smooth()`, which uses `method=loess` here by default. You can specify other methods with the `method` argument (see `?geom_smooth` for details). Again, the horizontal line at 80% power is included for reference.

```
ggplot(dfp, aes(x = total.samples, y = power, color = `Delta\nDNAm`)) +
  geom_smooth(se = T, method = "loess") + theme_bw() + xlab("Total samples") +
  ylab("Power") + geom_hline(yintercept = 0.8, color = "black", linetype = "dotted")
```

![](data:image/png;base64...)

Including the standard errors lends some confidence to our findings. First, we can tell there is a great deal of separation between each of the delta models throughout all simulations except at the very lowest total sample sizes. Further, at the highest total sample size the power exceeds 80% with high confidence at delta = 0.2 (e.g. lowest standard error well above reference line), with less confidence where delta = 0.1 (e.g. lowest standard error touches reference line), and not at all where delta = 0.05 (e.g. highest standard error is well below reference line).

# Next steps and further reading

This vignette showed how to used a lightly modified implementation of `pwrEWAS` on a custom user-provided DNAm dataset. It showed how to generate DNAm summary statistics, use these in the `pwrEWAS_itable()` function, identify simulation and summary outcomes in returned results data, and plot simulation results with errors using `ggplot2`.

Note the values of arguments like `J`, `nsim`, and `maxtss` can be increased in practice to yield a more robust power model. The values of arguments including `FDRcritVal` and `tdeltav` can further be set according to the empirical results of perliminary analyses or literature review to yield more informative results.

More details about the `pwrEWAS` method, including more fuction parameter details, can be found in the function docstrings (e.g. check `?pwrEWAS`), descriptions in the Bioconductor package [documentation](https://www.bioconductor.org/packages/release/bioc/html/pwrEWAS.html) and in the main study, (Graw et al. 2019)(<https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-019-2804-7>).

# Session Info

```
utils::sessionInfo()
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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] limma_3.66.0
##  [2] gridExtra_2.3
##  [3] knitr_1.50
##  [4] recountmethylation_1.20.0
##  [5] HDF5Array_1.38.0
##  [6] h5mread_1.2.0
##  [7] rhdf5_2.54.0
##  [8] DelayedArray_0.36.0
##  [9] SparseArray_1.10.0
## [10] S4Arrays_1.10.0
## [11] abind_1.4-8
## [12] Matrix_1.7-4
## [13] ggplot2_4.0.0
## [14] minfiDataEPIC_1.35.0
## [15] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
## [16] IlluminaHumanMethylationEPICmanifest_0.3.0
## [17] minfiData_0.55.0
## [18] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [19] IlluminaHumanMethylation450kmanifest_0.4.0
## [20] minfi_1.56.0
## [21] bumphunter_1.52.0
## [22] locfit_1.5-9.12
## [23] iterators_1.0.14
## [24] foreach_1.5.2
## [25] Biostrings_2.78.0
## [26] XVector_0.50.0
## [27] SummarizedExperiment_1.40.0
## [28] Biobase_2.70.0
## [29] MatrixGenerics_1.22.0
## [30] matrixStats_1.5.0
## [31] GenomicRanges_1.62.0
## [32] Seqinfo_1.0.0
## [33] IRanges_2.44.0
## [34] S4Vectors_0.48.0
## [35] BiocGenerics_0.56.0
## [36] generics_0.1.4
## [37] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] GenomicFeatures_1.62.0    farver_2.1.2
##   [7] rmarkdown_2.30            BiocIO_1.20.0
##   [9] vctrs_0.6.5               multtest_2.66.0
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [15] askpass_1.2.1             tinytex_0.57
##  [17] htmltools_0.5.8.1         curl_7.0.0
##  [19] Rhdf5lib_1.32.0           sass_0.4.10
##  [21] nor1mix_1.3-3             bslib_0.9.0
##  [23] plyr_1.8.9                cachem_1.1.0
##  [25] GenomicAlignments_1.46.0  lifecycle_1.0.4
##  [27] pkgconfig_2.0.3           R6_2.6.1
##  [29] fastmap_1.2.0             digest_0.6.37
##  [31] siggenes_1.84.0           reshape_0.8.10
##  [33] AnnotationDbi_1.72.0      RSQLite_2.4.3
##  [35] base64_2.0.2              labeling_0.4.3
##  [37] mgcv_1.9-3                httr_1.4.7
##  [39] compiler_4.5.1            beanplot_1.3.1
##  [41] rngtools_1.5.2            withr_3.0.2
##  [43] bit64_4.6.0-1             S7_0.2.0
##  [45] BiocParallel_1.44.0       DBI_1.2.3
##  [47] MASS_7.3-65               openssl_2.3.4
##  [49] rjson_0.2.23              tools_4.5.1
##  [51] rentrez_1.2.4             glue_1.8.0
##  [53] quadprog_1.5-8            restfulr_0.0.16
##  [55] nlme_3.1-168              rhdf5filters_1.22.0
##  [57] grid_4.5.1                gtable_0.3.6
##  [59] tzdb_0.5.0                preprocessCore_1.72.0
##  [61] tidyr_1.3.1               data.table_1.17.8
##  [63] hms_1.1.4                 xml2_1.4.1
##  [65] pillar_1.11.1             genefilter_1.92.0
##  [67] splines_4.5.1             dplyr_1.1.4
##  [69] lattice_0.22-7            survival_3.8-3
##  [71] rtracklayer_1.70.0        bit_4.6.0
##  [73] GEOquery_2.78.0           annotate_1.88.0
##  [75] tidyselect_1.2.1          bookdown_0.45
##  [77] xfun_0.53                 scrime_1.3.5
##  [79] statmod_1.5.1             yaml_2.3.10
##  [81] evaluate_1.0.5            codetools_0.2-20
##  [83] cigarillo_1.0.0           tibble_3.3.0
##  [85] BiocManager_1.30.26       cli_3.6.5
##  [87] xtable_1.8-4              jquerylib_0.1.4
##  [89] dichromat_2.0-0.1         Rcpp_1.1.0
##  [91] png_0.1-8                 XML_3.99-0.19
##  [93] readr_2.1.5               blob_1.2.4
##  [95] mclust_6.1.1              doRNG_1.8.6.2
##  [97] sparseMatrixStats_1.22.0  bitops_1.0-9
##  [99] scales_1.4.0              illuminaio_0.52.0
## [101] purrr_1.1.0               crayon_1.5.3
## [103] rlang_1.1.6               KEGGREST_1.50.0
```

# Works Cited

Graw, Stefan, Rosalyn Henn, Jeffrey A. Thompson, and Devin C. Koestler. 2019. “pwrEWAS: A User-Friendly Tool for Comprehensive Power Estimation for Epigenome Wide Association Studies (EWAS).” *BMC Bioinformatics* 20 (1): 218. <https://doi.org/10.1186/s12859-019-2804-7>.