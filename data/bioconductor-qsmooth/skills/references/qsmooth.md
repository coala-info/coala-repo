# The qsmooth user’s guide

Stephanie C. Hicks1, Kwame Okrah2, Joseph Paulson2, John Quackenbush3, Rafael A. Irizarry4 and Hector Corrada-Bravo5

1Johns Hopkins Bloomberg School of Public Health
2Genentech
3Harvard T.H. Chan School of Public Health
4Dana-Farber Cancer Institute
5University of Maryland

#### 30 October 2025

#### Abstract

Smooth quantile normalization
is a generalization of quantile normalization,
which is average of the two types of assumptions
about the data generation process: quantile normalization
and quantile normalization between groups.

#### Package

qsmooth 1.26.0

## 0.1 Introduction

Global normalization methods such as quantile normalization
[@Bolstad2003], [@Irizarry2003] have become a standard part of the
analysis pipeline for high-throughput data to remove unwanted
technical variation. These methods and others that rely solely
on observed data without external information (e.g. spike-ins)
are based on the assumption that only a minority of genes are
expected to be differentially expressed (or that an equivalent
number of genes increase and decrease across biological conditions
[@aanes2014normalization]). This assumption can be interpreted
in different ways leading to different global normalization
procedures. For example, in one normalization procedure, the method assumes
the mean expression level across genes should be the same across samples
[@Robinson2010]. In contrast, quantile normalization assumes the
only difference between the statistical distribution of each sample
is technical variation. Normalization is achieved by forcing the
observed distributions to be the same and the average distribution,
obtained by taking the average of each quantile across samples,
is used as the reference [@Bolstad2003].

While these assumptions may be reasonable in certain experiments,
they may not always be appropriate [@Loven2012], [@Hicks2015].
For example, mRNA content has been shown to fluctuate significantly
during zebrafish early developmental stages [@aanes2014normalization].
Similarly, cells expressing high levels of c-Myc undergo
transcriptional amplification causing a 2 to 3 fold change in global
gene expression compared to cells expressing low c-Myc
[@Loven2012].

Recently, an R/Bioconductor package (`quantro`) [@Hicks2015]
has been developed to test for global differences between groups of
distributions to evaluate whether global normalization methods such
as quantile normalization should be applied. If global differences
are found between groups of distributions, these changes may be of technical
or biological of interest. If these changes are of technical interest
(e.g. batch effects), then global normalization methods should be applied.
If these changes are related to a biological covariate (e.g. normal/tumor or
two tissues), then global normalization methods should not be applied
because the methods will remove the interesting biological variation
(i.e. differentially expressed genes) and artifically induce differences
between genes that were not differentially expressed. In the cases
with global differences between groups of distributions
between biological conditions, quantile normalization is
not an appropriate normalization method. In
these cases, we can consider a more relaxed assumption about the data,
namely that the statistical distribution of each sample should be the
same within biological conditions or groups (compared to the more
stringent assumption of quantile normalization, which states the
statistical distribution is the same across all samples).

In this vignette we introduce a generalization of quantile
normalization, referred to as **smooth quantile normalization**
(**qsmooth**), which is a weighted average of the two
types of assumptions about the data. The `qsmooth` R-package
contains the `qsmooth()` function, which computes a weight at
every quantile that compares the variability between groups relative
to within groups. In one extreme, quantile normalization is applied
and in the other extreme quantile normalization within each
biological condition is applied. The weight shrinks the group-level
quantile normalized data towards the overall reference quantiles
if variability between groups is sufficiently smaller than the
variability within groups. The algorithm is described in
Figure 1 below.

Let `gene(g)` denote the \({g}^{th}\) row after sorting
each column in the data. For each row, `gene(g)`, we
compute the weight \(w\_{(g)} \in [0, 1]\), where a weight of 0 implies
quantile normalization within groups is applied and
a weight of 1 indicates quantile normalization is applied.
The weight at each row depends on the between group sum of squares
\(\hbox{SSB}\_{(g)}\) and total sum of squares \(\hbox{SST}\_{(g)}\),
as follows:

\[
w\_{(g)} = \hbox{median} \{1 - \hbox{SSB}\_{(i)} / \hbox{SST}\_{(i)}
| ~i = g-k, \dots, g, \dots, g+k \}
\]
where \(k=\) floor(Total number of genes \* 0.05). The number
0.05 is a flexible parameter that can be altered to change the
window of the number of genes considered. In this way, we
can use a rolling median to borrow information from
neighboring genes in the weight.

```
knitr::include_graphics("qsmooth_algo.jpg")
```

![Figure 1](data:image/jpeg;base64...)

Figure 1: Figure 1

# 1 Getting Started

Load the package in R

```
library(qsmooth)
```

# 2 Data

The **bodymapRat** package contains an
`SummarizedExperiment` of 652 RNA-Seq samples
from a comprehensive rat transcriptomic BodyMap study.
This data was derived from the raw FASTQ files obtained
from Yu et al. (2014) . It contains expression
levels from 11 organs in male and female rats at 4
developmental stages. We will use a subset of this data in
this vignette.

## 2.1 bodymapRat example - Comparing two tissues

This example is based a dataset which contains
brain and liver tissue samples from 21 week old male
and female rats. eight samples are from males and
eight samples are from females.

```
library(SummarizedExperiment)
library(bodymapRat)
bm_dat <- bodymapRat()

# select brain and liver samples, stage 21 weeks, and only bio reps
keepColumns = (colData(bm_dat)$organ %in% c("Brain", "Liver")) &
         (colData(bm_dat)$stage == 21) & (colData(bm_dat)$techRep == 1)
keepRows = rowMeans(assay(bm_dat)) > 10 # Filter out low counts
bm_dat_e1 <- bm_dat[keepRows,keepColumns]
bm_dat_e1
```

```
## class: SummarizedExperiment
## dim: 18629 16
## metadata(0):
## assays(1): counts
## rownames(18629): ENSRNOG00000000007 ENSRNOG00000000010 ... ERCC-00170
##   ERCC-00171
## rowData names(0):
## colnames(16): SRR1169975 SRR1169977 ... SRR1170275 SRR1170277
## colData names(22): sraExperiment sraRun ... xtile ytile
```

# 3 Using the `qsmooth()` function

## 3.1 Input for `qsmooth()`

The `qsmooth()` function must have two objects as input:

1. `object`: a data frame or matrix with observations
   (e.g. probes or genes) on the rows and samples as the
   columns. `qsmooth()` accepts objects which are a data
   frame or matrix with observations (e.g. probes or genes)
   on the rows and samples as the columns.
2. `group_factor`: a continuous or categorial covariate
   that represents the group level biological variation
   about each sample. For example if the samples
   represent two different tissues, provide `qsmooth()`
   with a covariate representing which columns in the
   `object` are different tissue samples.
3. `batch`: **optional** batch covariate (multiple
   batches are not allowed). If batch covariate is provided,
   `ComBat()` from `sva` is used prior to
   qsmooth normalization to remove batch effects.
   See `ComBat()` for more details.
4. `norm_factors`: **optional** scaling normalization factors.
   Default is `NULL`. If `norm_factors` is not equal to
   `NULL`, the user can provide a vector of scaling factors
   that will be used to modify the expression data set prior to
   applying the `qsmooth` algorithm.
5. `window`: window size for running median (defined as a
   fraction of the number of rows of the data object.
   Default is 0.05.

## 3.2 Running `qsmooth()`

### 3.2.1 bodymapRat example - Comparing two tissues

Here, the groups we are interested in comparing
are the two types of tissues in the 21 week old
male and female rats. The groups we are interested
in comparing is contained in the `organ`
column in the `colData(bm_dat_e1)` dataset. To run the
`qsmooth()` function, input the data object and the
object containing the phenotypic data.

The first row shows the boxplots and density plot
of the raw data that has been transformed on the
`log2()` scale and added a pseudo-count of 1 (i.e.
`log2(counts+1)`).

The second row shows the boxplots and density plot
of the qsmooth normalized data.

```
library(quantro)

par(mfrow=c(2,2))
pd1 <- colData(bm_dat_e1)
counts1 <- assay(bm_dat_e1)[!grepl("^ERCC",
                      rownames( assay(bm_dat_e1))), ]
pd1$group <- paste(pd1$organ, pd1$sex, sep="_")

matboxplot(log2(counts1+1), groupFactor = factor(pd1$organ),
           main = "Raw data", xaxt="n",
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(as.character(pd1$organ))),
     labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2,
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(counts1+1), groupFactor = pd1$organ,
           main = "Raw data", ylab= "density",
           xlab = "Expression (log2 scale)")
legend('topright', levels(factor(pd1$organ)),
       col = 1:2, lty = 1)

qs_norm_e1 <- qsmooth(object = counts1, group_factor = pd1$organ)
qs_norm_e1
```

```
## qsmooth: Smooth quantile normalization
##    qsmoothWeights (length = 18581 ):
## 0.933 0.933 0.933 ... 0.887 0.887 0.887
##    qsmoothData (nrows = 18581 , ncols = 16 ):
##                     SRR1169975  SRR1169977  SRR1169979  SRR1169981  SRR1170009
## ENSRNOG00000000007 2174.512012 1801.779468 1713.209769 1947.183795 2009.479744
## ENSRNOG00000000010  408.563196  340.283829  438.121141  495.806792  488.897971
## ENSRNOG00000000012    2.280523    2.118090    1.471557    3.036711    1.431085
## ENSRNOG00000000017    5.506024    6.860026    5.087043    1.605515    6.692905
## ENSRNOG00000000021   93.035004  109.028768   98.549182  113.522437   89.975354
## ENSRNOG00000000024   20.060899   30.947871   35.232957   37.354217   28.396052
##                     SRR1170011   SRR1170013  SRR1170015  SRR1170239  SRR1170241
## ENSRNOG00000000007 1753.942781 1830.5599808 1836.751451   3.5632320   3.9628398
## ENSRNOG00000000010  533.290776  479.6564095  500.205500   0.6699115   1.5252205
## ENSRNOG00000000012    1.821102    0.7560356    2.969323   0.6699115   2.7658111
## ENSRNOG00000000017    1.193240    5.8792008    6.034787   2.5774451   0.2429941
## ENSRNOG00000000021  100.365576   92.8453323   88.179494  27.8363393  37.4890104
## ENSRNOG00000000024   19.681690   25.2376300   35.361946 178.5266277 197.0539613
##                     SRR1170243  SRR1170245 SRR1170271 SRR1170273  SRR1170275
## ENSRNOG00000000007   4.5519846   3.7718210   6.134075   3.780457   6.2792639
## ENSRNOG00000000010   0.2404039   0.2911755   1.949617   2.618445   0.1800509
## ENSRNOG00000000012   2.5981055   1.5737439   1.949617   0.236370   0.1800509
## ENSRNOG00000000017   2.5981055   1.5737439   1.949617   2.618445   0.1800509
## ENSRNOG00000000021  32.4504495  44.2178479  32.026870  40.259346  32.0963011
## ENSRNOG00000000024 192.9318750 206.2424800 199.157984 179.002150 135.9229221
##                     SRR1170277
## ENSRNOG00000000007   0.1944369
## ENSRNOG00000000010   1.3573017
## ENSRNOG00000000012   0.1944369
## ENSRNOG00000000017   4.8631190
## ENSRNOG00000000021  48.9281491
## ENSRNOG00000000024 171.2001833
##  .......
```

```
matboxplot(log2(qsmoothData(qs_norm_e1)+1),
           groupFactor = pd1$organ, xaxt="n",
           main = "qsmooth normalized data",
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(pd1$organ)), labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2,
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(qsmoothData(qs_norm_e1)+1), groupFactor = pd1$organ,
           main = "qsmooth normalized data",
           xlab = "Expression (log2 scale)", ylab = "density")
legend('topright', levels(factor(pd1$organ)), col = 1:2, lty = 1)
```

![](data:image/png;base64...)

The smoothed quantile normalized data can be
extracted using the`qsmoothData()` function
(see above) and the smoothed quantile weights
can plotted using the `qsmoothPlotWeights()`
function (see below).

```
qsmoothPlotWeights(qs_norm_e1)
```

![](data:image/png;base64...)

The weights are calculated for each quantile
in the data set. A weight of 1 indicates
quantile normalization is applied, where as a
weight of 0 indicates quantile normalization
within the groups is applied. See the Figure 1
for more details on the weights.

In this example, the weights range from 0.2
to 0.8 across the quantiles, where the weights
are close to 0.2 for the quantiles close to 0
and the weights are close to 0.8 for the quantiles
close to 1. This plot suggests the distributions
contain more variablity between the groups compared
to within groups for the small quantiles (and the
conventional quantile normalization is not
necessarily appropriate). As the quantiles get
bigger, there is less variability between groups
which increases the weight closer to 0.8 as the
quantiles get bigger.

However, if the weights are close to 1
across all the quantiles, this indicates that there
is no major difference between the group-level
quantiles in the two groups

## 3.3 Running `qsmoothGC`

In many high-throughput experiments, a sample-specific GC-content effect
can be observed. Due to this technical variability that differs between samples,
it can obscure comparisons across (sets of) samples.
[@VandenBerge2021] propose a method based on smooth quantile normalization,
where the `qsmooth` procedure is adopted separately across bins of features that
have been grouped according to their GC-content values.
This procedure has been implemented in `qsmoothGC`, which can be used in
similar vein as the `qsmooth` function. It has three additional arguments:
- `gc` to define the GC-content values of each feature.
- `nGroups` to define the number of groups within which `qsmooth` normalization
is adopted.
- `round` to define whether the normalized data should be rounded.

```
par(mfrow=c(2,2))
pd1 <- colData(bm_dat_e1)
counts1 <- assay(bm_dat_e1)[!grepl("^ERCC",
                      rownames( assay(bm_dat_e1))), ]
pd1$group <- paste(pd1$organ, pd1$sex, sep="_")

matboxplot(log2(counts1+1), groupFactor = factor(pd1$organ),
           main = "Raw data", xaxt="n",
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(as.character(pd1$organ))),
     labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2,
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(counts1+1), groupFactor = pd1$organ,
           main = "Raw data", ylab= "density",
           xlab = "Expression (log2 scale)")
legend('topright', levels(factor(pd1$organ)),
       col = 1:2, lty = 1)

# retrieved GC-content using EDASeq:
# gc <- EDASeq::getGeneLengthAndGCContent(id = rownames(bm_dat_e1),
#                                   org = "rno")
data(gc, package="qsmooth")

gcContent <- gc[rownames(counts1),2]
keep <- names(gcContent)[!is.na(gcContent)]
qs_norm_gc <- qsmoothGC(object = counts1[keep,], gc=gcContent[keep],
                        group_factor = pd1$organ)
qs_norm_gc
```

```
## qsmooth: Smooth quantile normalization
##    qsmoothWeights (length = 0 ):
## ...
##    qsmoothData (nrows = 18568 , ncols = 16 ):
##                    SRR1169975 SRR1169977 SRR1169979 SRR1169981 SRR1170009
## ENSRNOG00000000007       2228       1612       1889       1889       2228
## ENSRNOG00000000010        407        345        415        533        488
## ENSRNOG00000000012          2          2          1          3          2
## ENSRNOG00000000017          5          7          5          1          7
## ENSRNOG00000000021         88        115         99        119         93
## ENSRNOG00000000024         21         29         35         39         27
##                    SRR1170011 SRR1170013 SRR1170015 SRR1170239 SRR1170241
## ENSRNOG00000000007       1746       1889       1889          3          4
## ENSRNOG00000000010        559        470        516          0          2
## ENSRNOG00000000012          2          1          3          1          2
## ENSRNOG00000000017          1          7          6          3          0
## ENSRNOG00000000021         96         98         86         30         38
## ENSRNOG00000000024         17         25         35        173        180
##                    SRR1170243 SRR1170245 SRR1170271 SRR1170273 SRR1170275
## ENSRNOG00000000007          4          4          6          4          6
## ENSRNOG00000000010          0          0          3          3          0
## ENSRNOG00000000012          2          2          2          0          0
## ENSRNOG00000000017          3          1          2          3          0
## ENSRNOG00000000021         32         47         31         35         35
## ENSRNOG00000000024        195        192        199        171        142
##                    SRR1170277
## ENSRNOG00000000007          0
## ENSRNOG00000000010          1
## ENSRNOG00000000012          0
## ENSRNOG00000000017          5
## ENSRNOG00000000021         46
## ENSRNOG00000000024        165
##  .......
```

```
matboxplot(log2(qsmoothData(qs_norm_gc)+1),
           groupFactor = pd1$organ, xaxt="n",
           main = "qsmoothGC normalized data",
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(pd1$organ)), labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2,
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(qsmoothData(qs_norm_gc)+1), groupFactor = pd1$organ,
           main = "qsmoothGC normalized data",
           xlab = "Expression (log2 scale)", ylab = "density")
legend('topright', levels(factor(pd1$organ)), col = 1:2, lty = 1)
```

![](data:image/png;base64...)

# 4 References

# Appendix

# A Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] quantro_1.44.0              bodymapRat_1.25.0
##  [3] ExperimentHub_3.0.0         AnnotationHub_4.0.0
##  [5] BiocFileCache_3.0.0         dbplyr_2.5.1
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] qsmooth_1.26.0              knitr_1.50
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1             BiocIO_1.20.0
##   [3] bitops_1.0-9              filelock_1.0.3
##   [5] tibble_3.3.0              preprocessCore_1.72.0
##   [7] XML_3.99-0.19             rpart_4.1.24
##   [9] lifecycle_1.0.4           httr2_1.2.1
##  [11] edgeR_4.8.0               doParallel_1.0.17
##  [13] lattice_0.22-7            MASS_7.3-65
##  [15] base64_2.0.2              scrime_1.3.5
##  [17] backports_1.5.0           magrittr_2.0.4
##  [19] minfi_1.56.0              limma_3.66.0
##  [21] Hmisc_5.2-4               sass_0.4.10
##  [23] rmarkdown_2.30            jquerylib_0.1.4
##  [25] yaml_2.3.10               doRNG_1.8.6.2
##  [27] askpass_1.2.1             DBI_1.2.3
##  [29] RColorBrewer_1.1-3        abind_1.4-8
##  [31] quadprog_1.5-8            purrr_1.1.0
##  [33] RCurl_1.98-1.17           nnet_7.3-20
##  [35] rappdirs_0.3.3            sva_3.58.0
##  [37] rentrez_1.2.4             genefilter_1.92.0
##  [39] annotate_1.88.0           DelayedMatrixStats_1.32.0
##  [41] codetools_0.2-20          DelayedArray_0.36.0
##  [43] xml2_1.4.1                tidyselect_1.2.1
##  [45] farver_2.1.2              beanplot_1.3.1
##  [47] base64enc_0.1-3           illuminaio_0.52.0
##  [49] GenomicAlignments_1.46.0  jsonlite_2.0.0
##  [51] multtest_2.66.0           Formula_1.2-5
##  [53] survival_3.8-3            iterators_1.0.14
##  [55] foreach_1.5.2             tools_4.5.1
##  [57] Rcpp_1.1.0                glue_1.8.0
##  [59] gridExtra_2.3             SparseArray_1.10.0
##  [61] xfun_0.53                 mgcv_1.9-3
##  [63] dplyr_1.1.4               HDF5Array_1.38.0
##  [65] withr_3.0.2               BiocManager_1.30.26
##  [67] fastmap_1.2.0             rhdf5filters_1.22.0
##  [69] openssl_2.3.4             digest_0.6.37
##  [71] R6_2.6.1                  colorspace_2.1-2
##  [73] dichromat_2.0-0.1         RSQLite_2.4.3
##  [75] cigarillo_1.0.0           h5mread_1.2.0
##  [77] tidyr_1.3.1               data.table_1.17.8
##  [79] rtracklayer_1.70.0        httr_1.4.7
##  [81] htmlwidgets_1.6.4         S4Arrays_1.10.0
##  [83] pkgconfig_2.0.3           gtable_0.3.6
##  [85] blob_1.2.4                S7_0.2.0
##  [87] siggenes_1.84.0           XVector_0.50.0
##  [89] htmltools_0.5.8.1         bookdown_0.45
##  [91] scales_1.4.0              png_0.1-8
##  [93] rstudioapi_0.17.1         tzdb_0.5.0
##  [95] rjson_0.2.23              checkmate_2.3.3
##  [97] nlme_3.1-168              curl_7.0.0
##  [99] bumphunter_1.52.0         cachem_1.1.0
## [101] rhdf5_2.54.0              stringr_1.5.2
## [103] BiocVersion_3.22.0        parallel_4.5.1
## [105] foreign_0.8-90            AnnotationDbi_1.72.0
## [107] restfulr_0.0.16           GEOquery_2.78.0
## [109] pillar_1.11.1             grid_4.5.1
## [111] reshape_0.8.10            vctrs_0.6.5
## [113] xtable_1.8-4              cluster_2.1.8.1
## [115] htmlTable_2.4.3           evaluate_1.0.5
## [117] magick_2.9.0              tinytex_0.57
## [119] readr_2.1.5               GenomicFeatures_1.62.0
## [121] cli_3.6.5                 locfit_1.5-9.12
## [123] compiler_4.5.1            Rsamtools_2.26.0
## [125] rlang_1.1.6               crayon_1.5.3
## [127] rngtools_1.5.2            nor1mix_1.3-3
## [129] mclust_6.1.1              plyr_1.8.9
## [131] stringi_1.8.7             BiocParallel_1.44.0
## [133] Biostrings_2.78.0         Matrix_1.7-4
## [135] hms_1.1.4                 sparseMatrixStats_1.22.0
## [137] bit64_4.6.0-1             ggplot2_4.0.0
## [139] Rhdf5lib_1.32.0           KEGGREST_1.50.0
## [141] statmod_1.5.1             memoise_2.0.1
## [143] bslib_0.9.0               bit_4.6.0
```