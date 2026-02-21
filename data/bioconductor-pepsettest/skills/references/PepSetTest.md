# A Tutorial for PepSetTest

Junmin Wang

#### 30 October 2025

# Contents

* [0.1 Abstract](#abstract)
* [0.2 Package Content](#package-content)
* [0.3 Introduction](#introduction)
* [0.4 Using PepSetTest](#using-pepsettest)
* [0.5 Example 1](#example-1)
* [0.6 Example 2](#example-2)
* [0.7 Example 3](#example-3)
* [0.8 Example 4](#example-4)
* [References](#references)

## 0.1 Abstract

The PepSetTest (i.e., Peptide Set Test) R package provides functions to perform peptide-centric differential expression analysis. It deals with common data formats in Bioconductor such as SummarizedExperiment or even simple matrices. Please cite Wang and Novick ([2024](#ref-PepSetTest)) if you find peptide set tests useful.

## 0.2 Package Content

The `PepSetTest` packages provides a peptide-centric strategy to infer differentially expressed proteins. It contains:

* an implementation of the competitive peptide set test workflow. This test detects coordinated changes in the expression of peptides originating from the same protein and compares these changes against the rest of the peptidome.
* an implementation of the self-contained peptide set test workflow. This test determines whether peptides belonging to a protein are differentially expressed without reference to other peptides.
* an implementation of the aggregation-based workflow starting with peptide-level abundance data.
* scripts used for generating the simulated data and analysing the data from the spike-in experiment and breast cancer study as shown in Wang and Novick ([2024](#ref-PepSetTest)). These scripts are stored in the “inst” folder.

## 0.3 Introduction

In LC-MS/MS proteomics, peptide abundance is traditionally collapsed into protein abundance, and statistical analysis is then performed on the aggregated protein abundance to infer differentially expressed proteins. The empirical Bayes approach implemented in `limma` is among the most commonly used techniques for this purpose.

Unlike `limma`, no aggregation is performed in the peptide set test. Our peptide-centric approach fits a linear model to the peptide data followed by detection of coordinated changes in the expression of peptides originating from the same proteins. Compared to `limma`, the peptide set test demonstrates improved statistical power, yet controlling the Type I error rate correctly in most cases. Details of our method can be found in Wang and Novick ([2024](#ref-PepSetTest)).

## 0.4 Using PepSetTest

The peptide set test takes a peptide abundance table and a peptide-protein mapping table as input. Both tables can be easily extracted from the output of protein search softwares, including MaxQuant, ProteomeDiscoverer, Spectronaut, and DIA-NN. Once the computation is completed, the peptide set test returns the fold change, p-value, and adjusted p-value of each protein.

Peptide abundance tables can contain a fair number of missing values. It is recommended that one
impose a threshold on the missing value percentage and filter the peptide abundance data using that threshold. For example, it is common to only keep peptides with missing values fewer than 30% for subsequent analysis. Alternatively, imputation or a combination of filtering and imputation should be applied prior to running the peptide set test.

Below I will provide a few examples using simulated data.

## 0.5 Example 1

In this example, I will show how a workflow based on the peptide set test can be directly applied to the peptide-level abundance data.

First, let’s simulate some peptide abundance data. Suppose that in a hypothetical proteomics study of cancer, 500 peptides in total are detected. The diseased group (i.e., D) and healthy group (i.e., H) have three replicates each. Thirty out of 500 peptides are more abundant in the diseased group than in the healthy group by an order of 2 on the log2 scale.

```
# Load library
library(PepSetTest)

# Generate random peptide data
dat <- matrix(rnorm(3000), ncol = 6)
dat[1:30, 4:6] <- dat[1:30, 4:6] + 2
dat <- 2^dat
colnames(dat) <- paste0("Sample", 1:6)
rownames(dat) <- paste0("Peptide", 1:500)
```

Next, let’s generate the group labels and contrasts. Note that the contrast should always be expressed as “X-Y”, where X and Y are the labels of the two groups to be compared.

```
# Generate group labels and contrasts
group <- c(rep("H", 3), rep("D", 3))
contrasts.par <- "D-H"
```

Afterwards, let’s simulate a peptide-protein mapping table. Suppose the 500 detected peptides are mapped to 100 proteins. Each protein has 5 peptides.

```
# Generate a mapping table
pep_mapping_tbl <- data.frame(
  peptide = paste0("Peptide", 1:500),
  protein = paste0("Protein", rep(1:100, each = 5))
  )
```

Now that all the data are ready, we can run the peptide set test workflow as follows:

```
# Run the workflow
result <- CompPepSetTestWorkflow(dat,
                                 contrasts.par = contrasts.par,
                                 group = group,
                                 pep_mapping_tbl = pep_mapping_tbl,
                                 stat = "t",
                                 correlated = TRUE,
                                 equal.correlation = TRUE,
                                 pepC.estim = "mad",
                                 logged = FALSE)
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
```

The above workflow assumes that the peptides are correlated and adopts a mixed-model approach to estimate inter-peptide correlations. Furthermore, it adopts the sample median absolute deviation (MAD) as the estimator for the standard deviation of peptides not belonging to the protein of interest.

The parameters (e.g., “correlated”, “equal.correlation”, “pepC.estim”) can be adjusted to your preference. However, note that without good reason, we should almost always let PepSetTest estimate inter-peptide correlations on its own by setting `correlated = TRUE`. Please check the documentation if you want to learn more about each parameter.

## 0.6 Example 2

The peptide set test can also take a SummarizedExperiment object as input. To see how it works, let’s first store the data simulated in Example 1 as a SummarizedExperiment object.

```
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union
library(tibble)
library(SummarizedExperiment)
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'matrixStats'
#> The following object is masked from 'package:dplyr':
#>
#>     count
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following object is masked from 'package:dplyr':
#>
#>     explain
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following object is masked from 'package:dplyr':
#>
#>     combine
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following objects are masked from 'package:dplyr':
#>
#>     first, rename
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#>
#> Attaching package: 'IRanges'
#> The following objects are masked from 'package:dplyr':
#>
#>     collapse, desc, slice
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians

colData <- data.frame(sample = LETTERS[seq_along(group)],
                      group = group) %>%
  column_to_rownames(var = "sample")
rowData <- pep_mapping_tbl %>% column_to_rownames(var = "peptide")
dat.nn <- dat
rownames(dat.nn) <- NULL
colnames(dat.nn) <- NULL
dat.se <- SummarizedExperiment(assays = list(int = dat.nn),
                               colData = colData,
                               rowData = rowData)
```

Afterwards, let’s run the peptide set test workflow as follows:

```
result2 <- CompPepSetTestWorkflow(dat.se,
                                  contrasts.par = contrasts.par,
                                  group = "group",
                                  pep_mapping_tbl = "protein",
                                  stat = "t",
                                  correlated = TRUE,
                                  equal.correlation = TRUE,
                                  pepC.estim = "mad",
                                  logged = FALSE)
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
```

This should produce the same results as in Example 1.

## 0.7 Example 3

The peptide set test is also compatible with covariates. To see how it works, let’s add covariates to the data from Example 2.

```
library(dplyr)
library(tibble)
library(SummarizedExperiment)

colData <- data.frame(sample = LETTERS[seq_along(group)],
                      group = group,
                      sex = c("M", "F", "M", "F", "F", "M"),
                      age = 1:6) %>%
  column_to_rownames(var = "sample")
rowData <- pep_mapping_tbl %>% column_to_rownames(var = "peptide")
dat.nn <- dat
rownames(dat.nn) <- NULL
colnames(dat.nn) <- NULL
dat.se <- SummarizedExperiment(assays = list(int = dat.nn),
                               colData = colData,
                               rowData = rowData)
```

Afterwards, let’s run the peptide set test workflow as follows:

```
result3 <- CompPepSetTestWorkflow(dat.se,
                                  contrasts.par = contrasts.par,
                                  group = "group",
                                  pep_mapping_tbl = "protein",
                                  covar = c("sex", "age"),
                                  stat = "t",
                                  correlated = TRUE,
                                  equal.correlation = TRUE,
                                  pepC.estim = "mad",
                                  logged = FALSE)
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
#> boundary (singular) fit: see help('isSingular')
```

## 0.8 Example 4

Besides the competitive peptide set test, this R package also provides options to conduct the traditional LIMMA workflow and the self-contained peptide set test. To see how it works, let’s use the same data from Example 3.

```
result4 <- AggLimmaWorkflow(dat.se,
                            contrasts.par = contrasts.par,
                            group = "group",
                            pep_mapping_tbl = "protein",
                            covar = c("sex", "age"),
                            method = "robreg",
                            logged = FALSE)
#> Warning in rlm.default(x, y, weights, method = method, wt.method = wt.method, :
#> 'rlm' failed to converge in 20 steps
#> Warning in rlm.default(x, y, weights, method = method, wt.method = wt.method, :
#> 'rlm' failed to converge in 20 steps
#> Warning in rlm.default(x, y, weights, method = method, wt.method = wt.method, :
#> 'rlm' failed to converge in 20 steps
#> Warning in rlm.default(x, y, weights, method = method, wt.method = wt.method, :
#> 'rlm' failed to converge in 20 steps
#> Warning in rlm.default(x, y, weights, method = method, wt.method = wt.method, :
#> 'rlm' failed to converge in 20 steps
#> Warning in rlm.default(x, y, weights, method = method, wt.method = wt.method, :
#> 'rlm' failed to converge in 20 steps
```

```
result4_2 <- SelfContPepSetTestWorkflow(dat.se,
                                        contrasts.par = contrasts.par,
                                        group = "group",
                                        pep_mapping_tbl = "protein",
                                        covar = c("sex", "age"),
                                        logged = FALSE)
```

## References

Wang, Junmin, and Steven Novick. 2024. “Peptide set test: a peptide-centric strategy to infer differentially expressed proteins.” *Bioinformatics* 40 (5): btae270. <https://doi.org/10.1093/bioinformatics/btae270>.