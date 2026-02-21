# The quantro user’s guide

Stephanie C. Hicks1 and Rafael Irizarry2

1Johns Hopkins Bloomberg School of Public Health
2Dana-Farber Cancer Institute

#### 30 October 2025

#### Abstract

A test for when to use global normalization methods, such as quantile normalization.

#### Package

quantro 1.44.0

# 1 Introduction

Multi-sample normalization techniques such as quantile normalization
Bolstad et al. ([2003](#ref-Bolstad2003)), Irizarry et al. ([2003](#ref-Irizarry2003)) have become a standard and essential part of
analysis pipelines for high-throughput data. Although it was originally
developed for gene expression microarrays, it is now used across many
different high-throughput applications including genotyping arrays, DNA
Methylation, RNA Sequencing (RNA-Seq) and Chromatin Immunoprecipitation
Sequencing (ChIP-Seq). These techniques transform the original raw data to
remove unwanted technical variation. However, quantile normalization and other
global normalization methods rely on assumptions about the data generation
process that are not appropriate in some context. Until now, it has been left
to the researcher to check for the appropriateness of these assumptions.

Quantile normalization assumes that the statistical distribution of each
sample is the same. Normalization is achieved by forcing the observed
distributions to be the same and the average distribution, obtained by taking
the average of each quantile across samples, is used as the reference. This
method has worked very well in practice but note that when the assumptions are
not met, global changes in distribution, that may be of biological interest,
will be wiped out and features that are not different across samples can be
artificially induced. These types of assumptions are justified in many
biomedical applications, for example in gene expression studies in which only
a minority of genes are expected to be differentially expressed. However, if,
for example, a substantially higher percentage of genes are expected to be
expressed in only one group of samples, it may not be appropriate to use
global adjustment methods.

The `quantro` R-package can be used to test for global differences
between groups of distributions which asses whether global normalization
methods such as quantile normalization should be applied. Our method uses
the raw unprocessed high-throughput data to test for global differences in
the distributions across a set of groups. The main function `quantro()`
will perform two tests:

1. An ANOVA to test if the medians of the distributions are different
   across groups. Differences across groups could be attributed to unwanted
   technical variation (such as batch effects) or real global biological
   variation. This is a helpful step for the user to verify if there is any
   technical variation unaccounted for.
2. A test for global differences between the distributions across groups
   which returns a test statistic called `quantroStat`. This test
   statistic is a ratio of two variances and is similar to the idea of ANOVA.
   The main idea is to compare the variability of distributions within groups
   relative to between groups. If the variability between groups is sufficiently
   larger than the variability within groups, then this suggests global
   adjustment methods may not be appropriate. As a default, we perform this test
   on the median normalized data, but the user may change this option.

# 2 Getting Started

## 2.1 Installation

The R-package **quantro** can be [installed from the Bioconductor](http://www.bioconductor.org/packages/release/bioc/html/quantro.html)

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("quantro")
```

## 2.2 Load the package in R

After installation, the package can be loaded into R.

```
library(quantro)
```

# 3 Data

## 3.1 `flowSorted` Data Example

To explore how to use `quantro()`, we use the
`FlowSorted.DLPFC.450k` data package in Bioconductor
Jaffe and Kaminsky ([2021](#ref-JaffeFlowSorted)).
The data in this package originally came from Guintivano, Aryee, and Kaminsky ([2013](#ref-Guintivano2013)).
This data set in `FlowSorted.DLPFC.450k` contains raw data objects of 58
Illumina 450K DNA methylation microarrays, formatted as `RGset`
objects. The samples represent two different cellular populations of brain
tissues on the same 29 individuals extracted using flow sorting. For more
information on this data set, please see the `FlowSorted.DLPFC.450k` User’s
Guide.For the purposes of this vignette, a MethylSet object from the
`minfi` Bioconductor package Aryee et al. ([2014](#ref-Aryee2014)) was created which is
a subset of the rows from the original `FlowSorted.DLPFC.450k` data
set. This `MethylSet` object is found in the /data folder and the script to
create the object is found in /inst.

Here we will explore the distributions of these two cellular populations of
brain tissue (`NeuN_pos` and `NeuN_neg`) and then test if there
are global differences in the distributions across groups. First, load the
MethylSet object (`flowSorted`) and compute the Beta values using
the function `getBeta()` in the `minfi` Bioconductor package.
We use an offset of 100 as this is the default used by Illumina.

```
library(minfi)
data(flowSorted)
p <- getBeta(flowSorted, offset = 100)
pd <- pData(flowSorted)
dim(p)
```

```
## [1] 10000    58
```

```
head(pd)
```

```
## DataFrame with 6 rows and 11 columns
##        Sample_Name    SampleID    CellType Sentrix.Barcode Sample.Section
##        <character> <character> <character>       <numeric>    <character>
## 813_N        813_N         813    NeuN_pos      7766130090         R02C01
## 1740_N      1740_N        1740    NeuN_pos      7766130090         R02C02
## 1740_G      1740_G        1740    NeuN_neg      7766130090         R04C01
## 1228_G      1228_G        1228    NeuN_neg      7766130090         R04C02
## 813_G        813_G         813    NeuN_neg      7766130090         R06C01
## 1228_N      1228_N        1228    NeuN_pos      7766130090         R06C02
##               diag         sex   ethnicity       age       PMI
##        <character> <character> <character> <integer> <integer>
## 813_N      Control      Female   Caucasian        30        14
## 1740_N     Control      Female     African        13        17
## 1740_G     Control      Female     African        13        17
## 1228_G     Control        Male   Caucasian        47        13
## 813_G      Control      Female   Caucasian        30        14
## 1228_N     Control        Male   Caucasian        47        13
##                      BasePath
##                   <character>
## 813_N  /dcs01/lieber/ajaffe..
## 1740_N /dcs01/lieber/ajaffe..
## 1740_G /dcs01/lieber/ajaffe..
## 1228_G /dcs01/lieber/ajaffe..
## 813_G  /dcs01/lieber/ajaffe..
## 1228_N /dcs01/lieber/ajaffe..
```

## 3.2 Plot distributions

`quantro` contains two functions to view the distributions of the
samples of interest: `matdensity()` and `matboxplot()`. The function
`matdensity()` computes the density for each sample (columns) and
uses the `matplot()` function to plot all the densities.
`matboxplot()` orders and colors the samples by a group level variable.
These two functions use the `RColorBrewer` package and the brewer
palettes can be changed using the arguments `brewer.n` and
`brewer.name`.

The distributions of the two groups of cellular populations are shown here.
The `NeuN_neg` samples are colored in green and the `NeuN_pos` are
colored in red.

```
matdensity(p, groupFactor = pd$CellType, xlab = " ", ylab = "density",
           main = "Beta Values", brewer.n = 8, brewer.name = "Dark2")
legend('top', c("NeuN_neg", "NeuN_pos"), col = c(1, 2), lty = 1, lwd = 3)
```

![](data:image/png;base64...)

```
matboxplot(p, groupFactor = pd$CellType, xaxt = "n", main = "Beta Values")
```

![](data:image/png;base64...)

# 4 Using the `quantro()` function

## 4.1 Input for `quantro()`

The `quantro()` function must have two objects as input:

1. An `object` which is a data frame or matrix with observations
   (e.g. probes or genes) on the rows and samples as the columns.
2. A `groupFactor` which represents the group level information
   about each sample. For example if the samples represent tumor and normal
   samples, provide `quantro()` with a factor representing which columns
   in the `object` are normal and tumor samples.

## 4.2 Running `quantro()`

In this example, the groups we are interested in comparing are contained in
the `CellType` column in the `pd` dataset. To run the
`quantro()` function, input the data object and the object containing
the phenotypic data. Here we use the `flowSorted` data set as an
example.

```
qtest <- quantro(object = p, groupFactor = pd$CellType)
qtest
```

```
## quantro: Test for global differences in distributions
##    nGroups:  2
##    nTotSamples:  58
##    nSamplesinGroups:  29 29
##    anovaPval:  0.01206
##    quantroStat:  8.80735
##    quantroPvalPerm:  Use B > 0 for permutation testing.
```

The details related to the experiment can be extracted using the
`summary` accessor function:

```
summary(qtest)
```

```
## $nGroups
## [1] 2
##
## $nTotSamples
## [1] 58
##
## $nSamplesinGroups
## NeuN_neg NeuN_pos
##       29       29
```

To asssess if the medians of the distributions different across groups,
we perform an ANOVA on the medians from the samples. Those results can be
found using `anova`:

```
anova(qtest)
```

```
## Analysis of Variance Table
##
## Response: objectMedians
##             Df   Sum Sq   Mean Sq F value  Pr(>F)
## groupFactor  1 0.006919 0.0069194  6.7327 0.01206 *
## Residuals   56 0.057553 0.0010277
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

The full output can be seen The test statistic produced from
`quantro()` testing for global differences between distributions
is given by `quantroStat`:

```
quantroStat(qtest)
```

```
## [1] 8.807348
```

## 4.3 eSets

`quantro()` also can accept objects that inherit `eSets`
such as an `ExpressionSet` or `MethylSet`. The
`groupFactor` must still be provided.

```
is(flowSorted, "MethylSet")
```

```
## [1] TRUE
```

```
qtest <- quantro(flowSorted, groupFactor = pData(flowSorted)$CellType)
qtest
```

```
## quantro: Test for global differences in distributions
##    nGroups:  2
##    nTotSamples:  58
##    nSamplesinGroups:  29 29
##    anovaPval:  0.01206
##    quantroStat:  8.80735
##    quantroPvalPerm:  Use B > 0 for permutation testing.
```

## 4.4 Output from `quantro()`

Elements in the S4 object from `quantro()` include:

| Element | Description |
| --- | --- |
| `summary` | A list that contains (1) number of groups (`nGroups`), (2) total number of samples (`nTotSamples`) (3) number of samples in each group (`nSamplesinGroups`) |
| `anova` | ANOVA to test if the average medians of the distributions are different across groups |
| `MSbetween` | mean squared error between groups |
| `MSwithin` | mean squared error within groups |
| `quantroStat` | test statistic which is a ratio of the mean squared error between groups of distributions to the mean squared error within groups of distributions |
| `quantroStatPerm` | If `B` is not equal to 0, then a permutation test was performed to assess the statistical significance of `quantroStat`. These are the test statistics resulting from the permuted samples |
| `quantroPvalPerm` | If `B` is not equal to 0, then this is the \(p\)-value associated with the proportion of times the test statistics (`quantroStatPerm`) resulting from the permuted samples were larger than `quantroStat` |

# 5 Assessing the statistical significance

To assess statistical significance of the test statistic, we use
permutation testing. We use the `foreach` package which distribute
the computations across multiple cross in a single machine or across
multiple machines in a cluster. The user must pick how many permutations
to perform where `B` is the number of permutations. At each
permutation of the samples, a test statistic is calculated. The proportion
of test statistics (`quantroStatPerm`) that are larger than the
`quantroStat` is reported as the `quantroPvalPerm`. To use
the `foreach` package, we first register a backend, in this case a
machine with 1 cores.

```
library(doParallel)
registerDoParallel(cores=1)
qtestPerm <- quantro(p, groupFactor = pd$CellType, B = 1000)
qtestPerm
```

```
## quantro: Test for global differences in distributions
##    nGroups:  2
##    nTotSamples:  58
##    nSamplesinGroups:  29 29
##    anovaPval:  0.01206
##    quantroStat:  8.80735
##    quantroPvalPerm:  0.002
```

# 6 Visualizing the statistical significance from permutation tests

If permutation testing was used (i.e. specifying `B` \(>\) 0), then
there is a second function in the package called `quantroPlot()`
which will plot the test statistics of the permuted samples. The plot is
a histogram of the null test statistics `quantroStatPerm` from
`quantro()` and the red line is the observed test statistic
`quantroStat` from `quantro()`.

```
quantroPlot(qtestPerm)
```

![](data:image/png;base64...)

Additional options in the `quantroPlot()` function include:

| Element | Description |
| --- | --- |
| xLab | the x-axis label |
| yLab | the y-axis label |
| mainLab | title of the histogram |
| binWidth | change the binwidth |

# 7 SessionInfo

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
##  [1] doParallel_1.0.17           minfi_1.56.0
##  [3] bumphunter_1.52.0           locfit_1.5-9.12
##  [5] iterators_1.0.14            foreach_1.5.2
##  [7] Biostrings_2.78.0           XVector_0.50.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] quantro_1.44.0              knitr_1.50
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9              beanplot_1.3.1
##   [3] DBI_1.2.3                 rlang_1.1.6
##   [5] magrittr_2.0.4            scrime_1.3.5
##   [7] compiler_4.5.1            RSQLite_2.4.3
##   [9] GenomicFeatures_1.62.0    DelayedMatrixStats_1.32.0
##  [11] png_0.1-8                 vctrs_0.6.5
##  [13] quadprog_1.5-8            pkgconfig_2.0.3
##  [15] crayon_1.5.3              fastmap_1.2.0
##  [17] magick_2.9.0              labeling_0.4.3
##  [19] Rsamtools_2.26.0          rmarkdown_2.30
##  [21] tzdb_0.5.0                preprocessCore_1.72.0
##  [23] tinytex_0.57              purrr_1.1.0
##  [25] bit_4.6.0                 xfun_0.53
##  [27] cachem_1.1.0              cigarillo_1.0.0
##  [29] jsonlite_2.0.0            blob_1.2.4
##  [31] rhdf5filters_1.22.0       DelayedArray_0.36.0
##  [33] reshape_0.8.10            Rhdf5lib_1.32.0
##  [35] BiocParallel_1.44.0       R6_2.6.1
##  [37] bslib_0.9.0               RColorBrewer_1.1-3
##  [39] rtracklayer_1.70.0        limma_3.66.0
##  [41] genefilter_1.92.0         jquerylib_0.1.4
##  [43] Rcpp_1.1.0                bookdown_0.45
##  [45] readr_2.1.5               rentrez_1.2.4
##  [47] illuminaio_0.52.0         Matrix_1.7-4
##  [49] splines_4.5.1             tidyselect_1.2.1
##  [51] dichromat_2.0-0.1         abind_1.4-8
##  [53] yaml_2.3.10               siggenes_1.84.0
##  [55] codetools_0.2-20          curl_7.0.0
##  [57] doRNG_1.8.6.2             lattice_0.22-7
##  [59] tibble_3.3.0              plyr_1.8.9
##  [61] withr_3.0.2               KEGGREST_1.50.0
##  [63] S7_0.2.0                  askpass_1.2.1
##  [65] evaluate_1.0.5            survival_3.8-3
##  [67] xml2_1.4.1                mclust_6.1.1
##  [69] pillar_1.11.1             BiocManager_1.30.26
##  [71] rngtools_1.5.2            RCurl_1.98-1.17
##  [73] hms_1.1.4                 ggplot2_4.0.0
##  [75] sparseMatrixStats_1.22.0  scales_1.4.0
##  [77] xtable_1.8-4              glue_1.8.0
##  [79] tools_4.5.1               BiocIO_1.20.0
##  [81] data.table_1.17.8         GenomicAlignments_1.46.0
##  [83] annotate_1.88.0           GEOquery_2.78.0
##  [85] XML_3.99-0.19             rhdf5_2.54.0
##  [87] grid_4.5.1                tidyr_1.3.1
##  [89] AnnotationDbi_1.72.0      base64_2.0.2
##  [91] nlme_3.1-168              nor1mix_1.3-3
##  [93] HDF5Array_1.38.0          restfulr_0.0.16
##  [95] cli_3.6.5                 S4Arrays_1.10.0
##  [97] dplyr_1.1.4               gtable_0.3.6
##  [99] sass_0.4.10               digest_0.6.37
## [101] SparseArray_1.10.0        rjson_0.2.23
## [103] farver_2.1.2              memoise_2.0.1
## [105] htmltools_0.5.8.1         multtest_2.66.0
## [107] lifecycle_1.0.4           h5mread_1.2.0
## [109] httr_1.4.7                statmod_1.5.1
## [111] openssl_2.3.4             bit64_4.6.0-1
## [113] MASS_7.3-65
```

Aryee, Martin J, Andrew E Jaffe, Hector Corrada-Bravo, Christine Ladd-Acosta, Andrew P Feinberg, Kasper D Hansen, and Rafael A Irizarry. 2014. “Minfi: A Flexible and Comprehensive Bioconductor Package for the Analysis of Infinium Dna Methylation Microarrays.” *Bioinformatics* 30 (10): 1363–9. <https://doi.org/10.1093/bioinformatics/btu049>.

Bolstad, B M, R A Irizarry, M Astrand, and T P Speed. 2003. “A Comparison of Normalization Methods for High Density Oligonucleotide Array Data Based on Variance and Bias.” *Bioinformatics* 19 (2): 185–93.

Guintivano, Jerry, Martin J Aryee, and Zachary A Kaminsky. 2013. “A cell epigenotype specific model for the correction of brain cellular heterogeneity bias and its application to age, brain region and major depression.” *Epigenetics* 8 (3): 290–302. <https://doi.org/10.4161/epi.23924>.

Irizarry, Rafael A, Bridget Hobbs, Francois Collin, Yasmin D Beazer-Barclay, Kristen J Antonellis, Uwe Scherf, and Terence P Speed. 2003. “Exploration, Normalization, and Summaries of High Density Oligonucleotide Array Probe Level Data.” *Biostatistics* 4 (2): 249–64. <https://doi.org/10.1093/biostatistics/4.2.249>.

Jaffe, A J, and Z A Kaminsky. 2021. *FlowSorted.DLPFC.450k: Illumina Humanmethylation Data on Sorted Frontal Cortex Cell Populations*. R package version 1.29.0.