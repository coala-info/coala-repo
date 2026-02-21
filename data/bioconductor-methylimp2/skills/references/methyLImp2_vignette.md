# methyLImp2 vignette

Anna Plaksienko

#### 30 October 2025

#### Package

methyLImp2 1.6.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
* [2 Using *methyLImp2*](#using-methylimp2)
  + [2.1 About the data](#about-the-data)
  + [2.2 Missing values generation](#missing-values-generation)
  + [2.3 Using methyLImp2](#using-methylimp2-1)
  + [2.4 Performance evaluation](#performance-evaluation)
* [3 Session info](#session-info)

```
library(methyLImp2)
library(SummarizedExperiment)
library(BiocParallel)
```

# 1 Introduction

DNA methylation profiles often contain multiple missing values due to some technological problems. Meanwhile, methods for downstream analysis of such data require you to perform imputation of those missing values first. Although several imputation methods exist, most are inefficient with large dimensions and are not specific to methylation datasets. Previously, we have introduced *methyLImp* - imputation method that exploits inter-sample correlation in the methylation data in its model and also does imputation simultaneously for all CpGs with the same missingness pattern (i.e. NAs in the same samples). Although it demonstrated great performance in comparison with other methods (see [here](https://pubmed.ncbi.nlm.nih.gov/30796811/)), there was still a room for improvement in terms of the running time. Therefore, we upgraded it to *methyLImp2*!

This version is parallelized over chromosomes and, optionally, in case of large sample size, can use mini-batch approach. In our simulation study these two improvements allowed to reduce the running time from more than a day to just half an hour for the EPIC dataset of 456 samples!

In this vignette we will demonstrate the usage of the *methyLImp2* package for the imputation of the missing values in the methylation dataset. More details about the method itself can be found in [the manuscript](https://academic.oup.com/bioinformatics/article/40/1/btae001/7517106). If you use our package in your research and wish to support us, kindly cite the paper (see `citation(package = "methyLImp2")`).

## 1.1 Installation

To install *methyLImp2* from Bioconductor, run

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("methyLImp2")
```

# 2 Using *methyLImp2*

In this section we demonstrate the usage of the *methyLImp2* method. This section consists of four parts: data description, generation of the artificial missing values into example dataset (since we need to know the true values for the performance evaluation), application of *methyLImp2* method and then performance evaluation (we compare imputed values with the true ones).

## 2.1 About the data

Typically, imputation of the missing values is done before any other steps, like normalization, data exploration, analysis etc. Note that some packages do imputation while loading .idat files into R, so then you should set that step accordingly, to be able to use *methyLImp* after loading the data.

Here we use a subset of GSE199057 Gene Expression Omnibus dataset with mucosa samples from non-colon-cancer patients. Methylation data were measured on EPIC arrays. For the sake of vignette and due to package size restrictions, we reduce the number of samples from 68 to randomly sampled 24. We also restricted the dataset to the two shortest chromosomes, 18 and 21, using only a quarter of probes from each, and filtered out SNPs, so the total number of probes is 6064. We refer the reader to our [simulation studies](https://github.com/annaplaksienko/methyLImp2_simulation_studies) for full size dataset performance and running time results.

This dataset is a numeric matrix. You can use it as an input for *methyLImp2*. Data should be in a “tidy” format, i.e. with samples in rows and variables (probes, CpGs) in columns. However, if you use another possible input format, SummarizedExperiment, dimensions should be reversed (see later).

```
data(beta, package = "methyLImp2")
print(dim(beta))
#> [1]   24 6064
```

## 2.2 Missing values generation

Here we add artificial NAs into the dataset and memorize their positions so that we can later evaluate the performance of the method. We first randomly chose 3% of probes to have artificial NAs. Then, for each probe, we randomly defined the number of NAs from a Poisson distribution with \(\lambda\) appropriate to the sample size of the dataset (here for 24 samples we use \(\lambda = 3.5\)). Finally, these NAs are randomly placed among the samples.

`generateMissingData` function returns a list of two objects: matrix of beta values with artificial NAs and a list of positions of those NAs (columns and then rows for each column). We’ll need that second object to be able to evaluate performance later (since the dataset already has some ‘’natural’’ and, therefore, “unevaluatable” NAs, we can’t just directly compare two matrices, we need to know which entries to compare.)

```
with_missing_data <- generateMissingData(beta, lambda = 3.5)
#> The input dataset has 3 missing entries.
#> After NA generation, the dataset has 687 missing entries.
beta_with_nas <- with_missing_data$beta_with_nas
na_positions <- with_missing_data$na_positions
```

As already mentioned, you can provide a numeric matrix as an argument for *methyLImp2*. However, as many users work with SummarizedExperiment objects in the Bioconductor workflow, we will construct such object here for the sake of demonstration. Note how we transpose the matrix since typical assay format is variables in rows and samples in columns.

```
data(beta_meta)
beta_SE <- SummarizedExperiment(assays = SimpleList(beta = t(beta_with_nas)),
                                colData = beta_meta)
```

## 2.3 Using methyLImp2

Now, let’s run *methyLImp2*! You start by providing either a numeric data matrix with missing values, with samples in rows and variables (probes) in columns, or a SummarizedExperiment object, from which the first assays slot will be imputed. You also need to provide the type of your data - 450k or EPIC. These are the only two arguments you have to provide. However, there are a few other things you can tune so that the method suits your needs best:

* Specify what groups you have in your data. *methyLImp2* works best when imputation is done on each group of samples independently. Therefore, you should specify the correspondence of samples to groups. *methyLImp2* will split the data by groups, perform imputation and put the data back together. Here we’ve already pre-filtered the data to only one group, so we do not use this argument;
* Specify the type of data as “user-provided”. Type of data (450k or EPIC) is used to split CpGs across chromosomes. Match of CpGs to chromosomes is taken from ChAMPdata package (there, in turn, it comes from Illumina website). Therefore, if you wish to provide your own match, specify “user” in the type argument and then provide an annotation data frame with in the annotation argument (see example below);

|  | cpg | chr |
| --- | --- | --- |
| 1 | cg13869341 | chr1 |
| 2 | cg14008030 | chr1 |
| 67325 | cg03327570 | chr2 |
| 67326 | cg04948016 | chr2 |
| 300000 | cg15188574 | chr11 |

* Set up mini-batch computation. If your dataset is quite big sample-wise, you can opt to use only a fraction of samples for the imputation to decrease the running time, say 10, 20, 50% (depending on the original number of samples). Subsample will be chosen randomly for each calculation. The bigger the subsample - the better is the performance, hence by default it is 1. An option to improve the performance but still keep the running time low is to repeat computation for a (randomly chosen) fraction of samples several times, maybe 2, 3, 5. In the manuscript we explore how these two tuning parameters influence the running time and the performance.
* Choose the number of cores/workers. *methyLImp2* first splits the data by chromosomes and then does imputation for each subset in parallel. The default of the `BiocParallel` package is two less than total number of your cores. You can change it to your chosen N by setting `BPPARAM = SnowParam(workers = N)`. Since here we have only two chromosomes, *methyLImp2* will give a warning that it overwrote default settings. Note that we also encourage you to set `exportglobals = FALSE` since it allows to slightly speed up the computation;
* Choose not to overwrite your data with the imputed one. Here we opt to use the default setting and overwrite the existing assay of the SummarizedExperiment object to save memory. However, you can set `overwrite_res = FALSE` and then another slot will be added.

```
time <- system.time(beta_SE_imputed <- methyLImp2(input = beta_SE,
                                               type = "EPIC",
                                               BPPARAM = SnowParam(exportglobals = FALSE),
                                               minibatch_frac = 0.5))
#> Warning in methyLImp2(input = beta_SE, type = "EPIC", BPPARAM =
#> SnowParam(exportglobals = FALSE), : Number of chromosomes is less than
#> specified BPPARAM$workers. Your input was overwritten since more cores than
#> number of chromosomes is not necessary.
print(paste0("Runtime was ", round(time[3], digits = 2), " seconds."))
#> [1] "Runtime was 20.81 seconds."
```

## 2.4 Performance evaluation

Now we evaluate the performance of the algorithm with root mean square error (RMSE), mean absolute error (MAE), mean absolute percentage error (MAPE) - the lower the values are, the better - and Pearson correlation coefficient (PCC) - closer to 1, the better.

```
performance <- evaluatePerformance(beta, t(assays(beta_SE_imputed)[[1]]),
                                   na_positions)
print(performance)
#>       RMSE        MAE        PCC       MAPE
#> 0.05518981 0.03064595 0.98121679 0.13515994
```

# 3 Session info

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
#>  [1] BiocParallel_1.44.0         SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
#>  [5] matrixStats_1.5.0           methyLImp2_1.6.0
#>  [7] ChAMPdata_2.41.0            GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0               IRanges_2.44.0
#> [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [13] generics_0.1.4              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
#>  [4] BiocManager_1.30.26 parallel_4.5.1      jquerylib_0.1.4
#>  [7] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
#> [10] XVector_0.50.0      R6_2.6.1            S4Arrays_1.10.0
#> [13] knitr_1.50          DelayedArray_0.36.0 bookdown_0.45
#> [16] snow_0.4-4          bslib_0.9.0         rlang_1.1.6
#> [19] cachem_1.1.0        xfun_0.53           sass_0.4.10
#> [22] SparseArray_1.10.0  cli_3.6.5           digest_0.6.37
#> [25] grid_4.5.1          lifecycle_1.0.4     evaluate_1.0.5
#> [28] corpcor_1.6.10      codetools_0.2-20    abind_1.4-8
#> [31] rmarkdown_2.30      tools_4.5.1         htmltools_0.5.8.1
```