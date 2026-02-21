# Vignette illustrating the usage of gscreend on simulated data

Katharina Imkeller

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 gscreend workflow](#gscreend-workflow)
* [3 Installation](#installation)
* [4 Analysis of simulated data with gscreend](#analysis-of-simulated-data-with-gscreend)
  + [4.1 Input data: gRNA counts](#input-data-grna-counts)
  + [4.2 Run gscreend](#run-gscreend)
  + [4.3 Quality control](#quality-control)
* [5 Results](#results)
* [6 Session Info](#session-info)

# 1 Introduction

Pooled CRISPR perturbations screens employ a library of guide RNAs (gRNAs) that
is transduced into a pool of cells with the aim to induce a single genetic
perturbation in each cell. The perturbation effect is assessed by
measuring the abundance of each gRNA after the screen selection
phase and comparing it to its abundance in the plasmid library.
The main goal of the following analysis is the detection of
essential genes, i.e. genes whose knockout reduces the cell fitness.
The package gscreend provides a method to rank genes based on count tables.

# 2 gscreend workflow

In order to identify essential genes starting from raw gRNA count data,
gscreend performs the following analysis steps:

1. Input of raw gRNA counts at T0 (sequencing of library)
   and T1 (at the end of the screen). Normalization and
   calculation of log fold changes.
2. Split log fold changes into intervals dependent on the
   initial count at T0.
3. For every interval fit a skew-normal distribution to the
   data to model the null hypothesis (via least quantile regression).
4. Based on the null model calculate p-values for every gRNA.
5. Rank gRNAs according to p-value and perform robust ranking
   aggregation to calculate p-values on gene level.
6. Perform quality control of data and statistical model.

# 3 Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("gscreend")
```

```
library(gscreend)
library(SummarizedExperiment)
```

# 4 Analysis of simulated data with gscreend

## 4.1 Input data: gRNA counts

The simulated data used in this example has been generated
using the simulation method available at
<https://github.com/imkeller/simulate_pooled_screen>

Raw count data consists of gRNA counts in the library sequencing
and different replicates after the screen proliferation phase.
In order to estimate the effect of a specific gRNA
on cell fitness, the relative abundances of the gRNA
before and after the proliferation phase will be compares

```
raw_counts <- read.table(
    system.file("extdata", "simulated_counts.txt", package = "gscreend"),
    header=TRUE)
```

Generate a summarized experiment from the count data.
gscreend currently uses SummarizedExperiment objects as
an input format.

The count matrix contains raw gRNA counts.
Each row represents one gRNA, each column
represents one sample (T0, T1, replicates, …).

```
counts_matrix <- cbind(raw_counts$library0,
                        raw_counts$R0_0,
                        raw_counts$R1_0)

rowData <- data.frame(sgRNA_id = raw_counts$sgrna_id,
                    gene = raw_counts$Gene)

colData <- data.frame(samplename = c("library", "R1", "R2"),
                    # timepoint naming convention:
                    # T0 -> reference,
                    # T1 -> after proliferation
                    timepoint = c("T0", "T1", "T1"))

se <- SummarizedExperiment(assays=list(counts=counts_matrix),
                    rowData=rowData, colData=colData)
```

## 4.2 Run gscreend

In this step a gscreend experiment object is generated that
will after the analysis contain all data related to gRNAs,
genes and model parameters.

```
pse <- createPoolScreenExp(se)
```

```
## Creating PoolScreenExp object from a SummarizedExperiment object.
```

```
## References and samples are named correctly.
```

```
## Data concerning sgRNA and genes is provided.
```

Run gscreend with default parameters.

```
pse_an <- RunGscreend(pse)
```

```
## Size normalized count data.
```

```
## Calculated LFC.
```

```
## Fitted null distribution.
```

```
## Calculated p-values at gRNA level.
```

```
## Ranking genes...
```

```
## ... for positive fold changes
```

```
## ... for negative fold changes
```

```
## gscreend analysis has been completed.
```

## 4.3 Quality control

gscreend provides basic quality control functions for inspection
of replicate correlation for example.

```
plotReplicateCorrelation(pse_an)
```

![](data:image/png;base64...)

The `plotModelParameters()` function can be used to inspect
the values of the parameters estimated for the
skew normal distribution of the logarithmic fold change data.

```
plotModelParameters(pse_an)
```

![](data:image/png;base64...)

# 5 Results

The ResultsTable function can be used to extract a table listing
for each gene the p-value and fdr. These values correspond to
the results from the statistical test indicting whether
upon perturbation a specific gene reduces (direction = “negative”), or
increasing (direction = “positive”) cell viability.

```
res <- ResultsTable(pse_an, direction = "negative")
head(res)
```

```
##                          Name         fdr    pval       lfc
## essential_0       essential_0 0.000456760 0.00003 -1.421372
## essential_1       essential_1 0.000000000 0.00000 -1.984253
## essential_10     essential_10 0.000310559 0.00002 -1.605037
## essential_100   essential_100 0.000000000 0.00000 -3.075151
## essential_1000 essential_1000 0.000000000 0.00000 -2.023614
## essential_1001 essential_1001 0.056165919 0.00501 -1.032688
```

# 6 Session Info

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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] gscreend_1.24.0             BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  fGarch_4033.92
##  [4] lattice_0.22-7      magrittr_2.0.4      digest_0.6.37
##  [7] evaluate_1.0.5      grid_4.5.1          bookdown_0.45
## [10] fastmap_1.2.0       jsonlite_2.0.0      Matrix_1.7-4
## [13] tinytex_0.57        BiocManager_1.30.26 gbutils_0.5
## [16] codetools_0.2-20    jquerylib_0.1.4     abind_1.4-8
## [19] Rdpack_2.6.4        cli_3.6.5           timeSeries_4041.111
## [22] rlang_1.1.6         rbibutils_2.3       XVector_0.50.0
## [25] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
## [28] S4Arrays_1.10.0     cvar_0.5            tools_4.5.1
## [31] parallel_4.5.1      BiocParallel_1.44.0 nloptr_2.2.1
## [34] R6_2.6.1            magick_2.9.0        lifecycle_1.0.4
## [37] bslib_0.9.0         Rcpp_1.1.0          xfun_0.53
## [40] knitr_1.50          spatial_7.3-18      htmltools_0.5.8.1
## [43] fBasics_4041.97     rmarkdown_2.30      timeDate_4051.111
## [46] compiler_4.5.1
```