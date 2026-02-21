# BICOSS in the GWAS.BAYES Package

Jacob Williams and Marco A.R. Ferreira

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Functions](#functions)
* [3 Model/Model Assumptions](#modelmodel-assumptions)
* [4 Example](#example)
  + [4.1 BICOSS](#bicoss)
* [References](#references)

```
library(GWAS.BAYES)
```

# 1 Introduction

The `GWAS.BAYES` package provides statistical tools for the analysis of Gaussian GWAS data. Currently, `GWAS.BAYES` contains functions to perform BICOSS which is a novel iterative two step Bayesian procedure (Williams, Ferreira, and Ji [2022](#ref-BICOSS)) that, when compared to single marker analysis (SMA), increases the recall of true causal SNPs and drastically reduces the rate of false discoveries. Full details on the BICOSS procedure can be found in Williams, Ferreira, and Ji ([2022](#ref-BICOSS)).

This vignette shows an example of how to use the BICOSS function provided in `GWAS.BAYES` to analyze GWAS data. Data has been simulated under a linear mixed model from 9,000 SNPs for 328 *A. Thaliana* ecotypes. The `GWAS.BAYES` package includes as `R` objects the 9,000 SNPs, the simulated phenotypes, and the kinship matrix used to simulate the data.

# 2 Functions

The function implemented in `GWAS.BAYES` is described below:

* `BICOSS` Performs BICOSS, as proposed by Williams, Ferreira, and Ji ([2022](#ref-BICOSS)), using linear mixed models for a given numeric phenotype vector `Y`, a SNP matrix encoded numerically `SNPs`, and a realized relationship matrix or kinship matrix `kinship`. The `BICOSS` function returns the indices of the SNP matrix that were identified in the best model found by the BICOSS algorithm.

# 3 Model/Model Assumptions

The model for GWAS analysis used in the `GWAS.BAYES` package is

\[\begin{equation\*}
\textbf{Y} = X \boldsymbol{\beta} + Z \textbf{u} + \boldsymbol{\epsilon} \ \text{where} \ \boldsymbol{\epsilon} \sim N(\textbf{0},\sigma^2 I) \ \text{and} \ \textbf{u} \sim N(\textbf{0},\sigma^2 \tau K),
\end{equation\*}\]

where

* \(\textbf{Y}\) is the vector of phenotype responses.
* \(X\) is the matrix of SNPs (single nucleotide polymorphisms).
* \(\boldsymbol{\beta}\) is the vector of regression coefficients that contains the effects of the SNPs.
* \(Z\) is an incidence matrix relating the random effects associated with the kinship structure.
* \(\textbf{u}\) is a vector of random effects associated with the kinship structure to the phenotype responses.
* \(\boldsymbol{\epsilon}\) is the error vector.
* \(\sigma^2\) is the variance of the errors.
* \(\tau\) is a parameter related to the variance of the random effects.
* \(K\) is the kinship matrix.

Currently, all functions in `GWAS.BAYES` assume the errors of the fitted model are Gaussian. To speed up computations, `GWAS.BAYES` utilizes spectral decomposition techniques similar to that of Kang et al. ([2008](#ref-Kang1709)) as well as population parameters previously determined (`P3D`,Zhang et al. ([2010](#ref-P3D))).

# 4 Example

The `BICOSS` function requires a vector of observed phenotypes, a matrix of SNPs, and a kinship matrix First, the vector of observed phenotypes must be a numeric vector or a numeric \(n \times 1\) matrix. `GWAS.BAYES` does not allow the analysis of multiple phenotypes at the same time. In this example, the vector of observed phenotypes was simulated from a linear mixed model. Here are the first five elements of the simulated vector of phenotypes:

```
Y[1:5]
#> [1] 3.330224 2.733632 4.167975 3.705713 4.015575
```

Second, the SNP matrix has to contain numeric values where each column corresponds to a SNP of interest and the \(i\)th row corresponds to the \(i\)th observed phenotype. In this example, the SNPs are a subset of the TAIR9 genotype dataset and all SNPs have minor allele frequency greater than 0.01. Here are the first five rows and five columns of the SNP matrix:

```
SNPs[1:5,1:5]
#>      SNP2555 SNP2556 SNP2557 SNP2558 SNP2559
#> [1,]       1       1       1       0       0
#> [2,]       0       1       1       1       1
#> [3,]       0       0       1       1       1
#> [4,]       1       1       0       0       1
#> [5,]       1       1       1       1       1
```

Third, the kinship matrix is an \(n \times n\) positive semi-definite matrix containing only numeric values. The \(i\)th row or \(i\)th column quantifies how observation \(i\) is related to other observations. Here are the first five rows and five columns of the kinship matrix:

```
kinship[1:5,1:5]
#>              V1         V2         V3         V4         V5
#> [1,] 0.78515873 0.15800700 0.04264546 0.02057071 0.05643574
#> [2,] 0.15800700 0.78146476 0.05135891 0.01476357 0.05482448
#> [3,] 0.04264546 0.05135891 0.80199976 0.10558970 0.04888596
#> [4,] 0.02057071 0.01476357 0.10558970 0.80030413 0.02935703
#> [5,] 0.05643574 0.05482448 0.04888596 0.02935703 0.78401489
```

## 4.1 BICOSS

The function `BICOSS` implements the BICOSS method for linear mixed models with Gaussian errors. This function takes as inputs the observed phenotypes, the SNPs coded numerically, the kinship matrix, and whether or not to use the P3D approach. Further, the other inputs of `BICOSS` are the FDR nominal level, the maximum number of iterations of the genetic algorithm in the model selection step, and the number of consecutive iterations of the genetic algorithm with the same best model for convergence. The full details of BICOSS are available in Williams, Ferreira, and Ji ([2022](#ref-BICOSS)). The default values of maximum iterations and the number of iterations are the values used in the simulation study in Williams, Ferreira, and Ji ([2022](#ref-BICOSS)), that is, 400 and 40 respectively.

Here we illustrate the use of BICOSS with a nominal FDR of 0.05 and with the P3D approach in both the screening and the model selection steps.

```
BICOSS_P3D <- BICOSS(Y = Y, SNPs = SNPs,
                     kinship = kinship,FDR_Nominal = 0.05,P3D = TRUE,
                     maxiterations = 400,runs_til_stop = 40)
BICOSS_P3D$best_model
#> [1] 1268 1350 2250 3148 4950 5276 5850 8550
```

`BICOSS` outputs the best model in a named list. The best model values correspond to the indices of the SNP matrix. Further, estimating the variance components for each model in the screening and model selection steps is possible by setting `P3D = FALSE`. This is a much slower option.

```
BICOSS_Exact <- BICOSS(Y = Y, SNPs = SNPs,
                       kinship = kinship,FDR_Nominal = 0.05,P3D = FALSE,
                       maxiterations = 400,runs_til_stop = 40)
BICOSS_Exact$best_model
#> [1] 1268 1350 2250 3148 4950 5276 5850 8550
```

As expected, using P3D or not using P3D leads to slightly different sets of identified SNPs. Because this is simulated data, we can compute the number of true positives and the number of false positives.

```
## The true causal SNPs in this example are
True_Causal_SNPs <- c(450,1350,2250,3150,4050,4950,5850,6750,7650,8550)
## Thus, the number of true positives is
sum(BICOSS_P3D$best_model %in% True_Causal_SNPs)
#> [1] 5
## The number of false positives is
sum(!(BICOSS_P3D$best_model %in% True_Causal_SNPs))
#> [1] 3
```

As shown in Williams, Ferreira, and Ji ([2022](#ref-BICOSS)), when compared to SMA, BICOSS better controls false discoveries and improves on the number of true positives.

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
#> [1] GWAS.BAYES_1.20.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] crayon_1.5.3        cli_3.6.5           knitr_1.50
#>  [4] rlang_1.1.6         xfun_0.53           jsonlite_2.0.0
#>  [7] statmod_1.5.1       htmltools_0.5.8.1   sass_0.4.10
#> [10] rmarkdown_2.30      grid_4.5.1          evaluate_1.0.5
#> [13] jquerylib_0.1.4     fastmap_1.2.0       foreach_1.5.2
#> [16] yaml_2.3.10         lifecycle_1.0.4     memoise_2.0.1
#> [19] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
#> [22] codetools_0.2-20    Rcpp_1.1.0          limma_3.66.0
#> [25] lattice_0.22-7      digest_0.6.37       R6_2.6.1
#> [28] bslib_0.9.0         Matrix_1.7-4        tools_4.5.1
#> [31] iterators_1.0.14    GA_3.2.4            cachem_1.1.0
```

# References

Kang, Hyun Min, Noah A. Zaitlen, Claire M. Wade, Andrew Kirby, David Heckerman, Mark J. Daly, and Eleazar Eskin. 2008. “Efficient Control of Population Structure in Model Organism Association Mapping.” *Genetics* 178 (3): 1709–23. <https://doi.org/10.1534/genetics.107.080101>.

Williams, Jacob, Marco A. R. Ferreira, and Tieming Ji. 2022. “BICOSS: Bayesian iterative conditional stochastic search for GWAS.” *BMC Bioinformatics* 23 (475). <https://doi.org/10.1186/s12859-022-05030-0>.

Zhang, Zhiwu, Elhan Ersoz, Chao-Qiang Lai, Rory J Todhunter, Hemant K Tiwari, Michael A Gore, Peter J Bradbury, et al. 2010. “Mixed Linear Model Approach Adapted for Genome-Wide Association Studies.” *Nature Genetics* 42 (4): 355–60.