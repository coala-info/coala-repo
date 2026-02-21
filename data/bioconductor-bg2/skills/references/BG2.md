# BG2

Shuangshuang Xu, Jacob Williams, and Marco A.R. Ferreira

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Functions](#functions)
* [3 Model/Model Assumptions](#modelmodel-assumptions)
* [4 Examples](#examples)
  + [4.1 Simulated Data](#simulated-data)
    - [4.1.1 BG2 Poisson Example](#bg2-poisson-example)
    - [4.1.2 BG2 Binary Example](#bg2-binary-example)
* [References](#references)

```
library(BG2)
```

# 1 Introduction

The `BG2` package provides statistical tools for the analysis of Poisson and Binary GWAS data. Currently, `BG2` contains functions to perform BG2 which is a novel two step Bayesian procedure that, when compared to single marker association testing (SMA), drastically reduces the rate of false discoveries while maintaining the same level of recall of true causal SNPs. Full details on the BG2 procedure can be found in the manuscript (Xu, Williams, and Ferreira, [n.d.](#ref-BG2)). The two packages in Bioconductor are GWASTools (Gogarten et al. [2012](#ref-gogarten2012gwastools)) and GWAS.BAYES (Williams, Ferreira, and Ji [2022](#ref-BICOSS)). While GWASTools provides frequentist methods, BG2 provides Bayesian methods. While GWAS.Bayes provides methods for analysis of Gaussian data, BG2 provides methods for the analysis of non-Gaussian data.

This vignette explores two toy examples as well as a case study presented in the BG2 manuscript (Xu, Williams, and Ferreira, [n.d.](#ref-BG2)) to illustrate how the functions provided in `BG2` perform the BG2 procedure. Data has been simulated under a generalized linear mixed model from 9,000 SNPs of 328 *A. Thaliana* ecotypes. The `BG2` package includes as `R` objects the simulated data; 9,000 SNPs, the simulated phenotypes (both binary and Poisson), and the kinship matrix used to simulate the data. Further, the Github repo that contains the `BG2` package also contains contains the data for the *A. Thaliana* case study.

# 2 Functions

The function implemented in `BG2` is described below:

* `BG2` Performs BG2, as described in the BG2 manuscript (Xu, Williams, and Ferreira, [n.d.](#ref-BG2)), using generalized linear mixed models for a given numeric phenotype vector either binary or assumed Poisson distributed `Y`, a SNP matrix encoded numerically `SNPs`, fixed covariates `Fixed`, and random effects and their projection matrices (`covariance` and `Z` respectively). The `BG2` function returns the indices of the SNP matrix that were identified in the best model found by the BG2 procedure.

# 3 Model/Model Assumptions

The model for GWAS analysis used in the `BG2` package is

\[\begin{equation\*}
g(\textbf{y}) = X \boldsymbol{\beta} + X\_f \boldsymbol{\beta}\_f + Z\_1 \boldsymbol{\alpha}\_1 + \ldots + Z\_l \boldsymbol{\alpha}\_l
\end{equation\*}\]

where

* \(g()\) is the link function.
* \(\textbf{y}\) is the vector of phenotype responses. Either binary or Poisson.
* \(X\) is the matrix of SNPs (single nucleotide polymorphisms).
* \(\boldsymbol{\beta}\) is the vector of regression coefficients that contains the effects of the SNPs.
* \(X\_f\) is a matrix of fixed covariates.
* \(\boldsymbol{\beta}\_f\) is the vector of regression coefficients that contains the effects of the fixed covariates.
* \(Z\_i\) is an incidence matrix relating the random effects \(\boldsymbol{\alpha}\_i\) to the phenotype response.
* \(\boldsymbol{\alpha}\_i\) is a vector of random effects with covariance matrix \(\Sigma\_i\). Common covariance structures include the identity matrix and kinship matrix.

Currently, `BG2` can analyze binary responses (`family = "bernoulli"`) and Poisson responses (`family = "poisson"`). The BG2 manuscript (Xu, Williams, and Ferreira, [n.d.](#ref-BG2)) provides full details on the priors for \(\boldsymbol{\beta}\). `BG2` utilizes spectral decomposition techniques similar to that of Kang et al. ([2008](#ref-Kang1709)) as well as population parameters previously determined (Zhang et al. [2010](#ref-P3D)) to speed up computation.

# 4 Examples

The `BG2` function requires a vector of observed phenotypes (either binary or assumed Poisson distributed), a matrix of SNPs, and the specification of the random effects. First, the vector of observed phenotypes must be a numeric vector or a numeric \(n \times 1\) matrix. `BG2` does not allow the analysis of multiple phenotypes simultaneously. In the `BG2` package, there are two simulated phenotype vectors. The first simulated phenotype vector comes from a Poisson generalized linear mixed model with both a kinship random effect and an overdispersion random effect. The data is assumed to have four replicates for each *A. Thaliana* ecotype. Here are the first five elements of the Poisson simulated vector of phenotypes:

```
data("Y_poisson")
Y_poisson[1:5]
#> [1]  74  10 215   1   0
```

The second simulated phenotype vector comes from a binary generalized linear mixed model with only a kinship random effect. The first five elements of the binary simulated vector of phenotypes are

```
data("Y_binary")
Y_binary[1:5]
#> [1] 0 0 1 1 0
```

Second, the SNP matrix has to contain numeric values where each column corresponds to a SNP of interest and the \(i\)th row corresponds to the \(i\)th observed phenotype. In this example, the SNPs are a subset of the *A. Thaliana* TAIR9 genotype dataset and all SNPs have minor allele frequency greater than 0.01. Each simulated phenotype vector is simulated using this SNP matrix. Here are the first five rows and five columns of the SNP matrix:

```
data("SNPs")
SNPs[1:5,1:5]
#>      SNP2555 SNP2556 SNP2557 SNP2558 SNP2559
#> [1,]       1       1       1       0       0
#> [2,]       0       1       1       1       1
#> [3,]       0       0       1       1       1
#> [4,]       1       1       0       0       1
#> [5,]       1       1       1       1       1
```

Third, the kinship matrix is an \(n \times n\) positive semi-definite matrix containing only numeric values. The \(i\)th row or \(i\)th column quantifies how observation \(i\) is related to other observations. Since, both simulated phenotypes are simulated from the same SNP matrix they also are simulated from the same kinship structure. The first five rows and five columns of the kinship matrix are

```
data("kinship")
kinship[1:5,1:5]
#>              V1         V2         V3         V4         V5
#> [1,] 0.78515873 0.15800700 0.04264546 0.02057071 0.05643574
#> [2,] 0.15800700 0.78146476 0.05135891 0.01476357 0.05482448
#> [3,] 0.04264546 0.05135891 0.80199976 0.10558970 0.04888596
#> [4,] 0.02057071 0.01476357 0.10558970 0.80030413 0.02935703
#> [5,] 0.05643574 0.05482448 0.04888596 0.02935703 0.78401489
```

## 4.1 Simulated Data

The function `BG2` implements the BG2 method for generalized linear mixed models with either Poisson or Bernoulli distributed responses. This function takes inputs of the observed phenotypes, the SNPs coded numerically, the distributional family the response follows, fixed covariates treated as a matrix, the covariance matrices of the random effects, the design matrices of the random effects, the number of replicates of individuals or ecotypes you may have, and the choice of a fixed value or a prior for the dispersion parameter of the nonlocal prior. Further, the other inputs of `BG2` are the FDR nominal level, the maximum number of iterations of the genetic algorithm in the model selection step, and the number of consecutive iterations of the genetic algorithm with the same best model for convergence. The full details of BG2 are available in the BG2 manuscript (Xu, Williams, and Ferreira, [n.d.](#ref-BG2)). The default values of maximum iterations and the number of iterations are the values used in the simulation study in the BG paper, that is, 4000 and 400 respectively.

### 4.1.1 BG2 Poisson Example

Here we illustrate the use of BG2 with a nominal FDR of 0.05 with Poisson count data. First we specify the covariance matrices for the random effects. The first random effect is assumed to be \(\boldsymbol{\alpha}\_1 \sim N(0,\kappa\_1 K)\), where \(K\) is the realized relationship matrix or kinship matrix. The second random effect is assumed to be \(\boldsymbol{\alpha}\_1 \sim N(0,\kappa\_2 I)\), where the covariance matrix is an identity matrix times a scalar. This second random effect is to account for overdispersion in the Poisson model. The `Covariance` argument takes a list of random effect covariance matrices. For this example, the list of covariance matrices is set as:

```
n <- length(Y_poisson)
covariance <- list()
covariance[[1]] <- kinship
covariance[[2]] <- diag(1, nrow = n, ncol = n)
```

The design matrices \(Z\_i\) do not need to be specified in `Z` as the observations have no other structure such as a grouping structure. `Z` is set to be NULL implying that \(Z\_i = I\_{n \times n}\). Further, the number of ecotype replications is 4. Finally, we let the dispersion parameter of the nonlocal prior have a uniform prior.

```
set.seed(1330)
output_poisson <- BG2(Y=Y_poisson, SNPs=SNPs, Fixed = NULL,
                      Covariance=covariance, Z=NULL, family="poisson",
                      replicates=4, Tau="uniform",FDR_Nominal = 0.05,
                      maxiterations = 4000, runs_til_stop = 400)
output_poisson
#>  [1]  385  450  462  463 1261 1350 1410 2250 3150 4050 7630
```

`BG2` outputs the column indices of the `SNPs` matrix that are in best model or column indices of SNPs perfectly correlated to SNPs in the best model. The data was generated with causal SNPs at positions 450, 1,350, 2,250, 3,150, 4,050, 4,950, 5,850, 6,750, 7,650,and 8,550. BG2 identifies 5 causal SNPs.

### 4.1.2 BG2 Binary Example

Here we illustrate the use of BG2 with a nominal FDR of 0.05 with Poisson count data. First we specify the covariance matrices for the random effects. The only random effect is assumed to be \(\boldsymbol{\alpha} \sim N(0,\kappa\_1 K)\), where \(K\) is the realized relationship matrix or kinship matrix. For this example, the list of covariance matrices is set as:

```
covariance <- list()
covariance[[1]] <- kinship
```

In this example, the design matrices \(Z\_i\) do not need to be specified in `Z` as the observations have no other structure such as a grouping structure. `Z` is set to be NULL implying that \(Z\_i = I\_{n \times n}\). With binary data, setting the number of replicates provides no computation gain and is not required. Finally, we let the dispersion parameter of the nonlocal prior have a Inverse Gamma distribution. Details on the Inverse Gamma Distribution are provide in the BG2 manuscript (Xu, Williams, and Ferreira, [n.d.](#ref-BG2)).

```
set.seed(1330)
output_binary <- BG2(Y=Y_binary, SNPs=SNPs, Fixed = NULL,
                     Covariance=covariance, Z=NULL, family="bernoulli",
                     replicates=NULL, Tau="IG",FDR_Nominal = 0.05,
                     maxiterations = 4000, runs_til_stop = 400)
output_binary
#> [1]  512 2250 7650 8550
```

Similarly to the Poisson example in Section 4.1.1, the data was generated with causal SNPs at positions 450, 1,350, 2,250, 3,150, 4,050, 4,950, 5,850, 6,750, 7,650,and 8,550. BG2 identifies 4 causal SNPs and no false SNPs.

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
#> [1] BG2_1.10.0       BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6         xfun_0.53            bslib_0.9.0
#>  [4] ggplot2_4.0.0        recipes_1.3.1        lattice_0.22-7
#>  [7] vctrs_0.6.5          tools_4.5.1          generics_0.1.4
#> [10] stats4_4.5.1         parallel_4.5.1       tibble_3.3.0
#> [13] pkgconfig_2.0.3      ModelMetrics_1.2.2.2 Matrix_1.7-4
#> [16] data.table_1.17.8    RColorBrewer_1.1-3   S7_0.2.0
#> [19] lifecycle_1.0.4      compiler_4.5.1       farver_2.1.2
#> [22] stringr_1.5.2        codetools_0.2-20     htmltools_0.5.8.1
#> [25] class_7.3-23         sass_0.4.10          yaml_2.3.10
#> [28] prodlim_2025.04.28   crayon_1.5.3         pillar_1.11.1
#> [31] jquerylib_0.1.4      MASS_7.3-65          cachem_1.1.0
#> [34] gower_1.0.2          iterators_1.0.14     rpart_4.1.24
#> [37] foreach_1.5.2        nlme_3.1-168         parallelly_1.45.1
#> [40] lava_1.8.1           tidyselect_1.2.1     digest_0.6.37
#> [43] stringi_1.8.7        future_1.67.0        dplyr_1.1.4
#> [46] reshape2_1.4.4       purrr_1.1.0          bookdown_0.45
#> [49] listenv_0.9.1        splines_4.5.1        fastmap_1.2.0
#> [52] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
#> [55] dichromat_2.0-0.1    survival_3.8-3       future.apply_1.20.0
#> [58] withr_3.0.2          scales_1.4.0         lubridate_1.9.4
#> [61] timechange_0.3.0     rmarkdown_2.30       globals_0.18.0
#> [64] nnet_7.3-20          timeDate_4051.111    GA_3.2.4
#> [67] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
#> [70] hardhat_1.4.2        caret_7.0-1          rlang_1.1.6
#> [73] Rcpp_1.1.0           glue_1.8.0           BiocManager_1.30.26
#> [76] pROC_1.19.0.1        ipred_0.9-15         jsonlite_2.0.0
#> [79] R6_2.6.1             plyr_1.8.9
```

# References

Gogarten, Stephanie M, Tushar Bhangale, Matthew P Conomos, Cecelia A Laurie, Caitlin P McHugh, Ian Painter, Xiuwen Zheng, et al. 2012. “GWASTools: An R/Bioconductor Package for Quality Control and Analysis of Genome-Wide Association Studies.” *Bioinformatics* 28 (24): 3329–31.

Kang, Hyun Min, Noah A. Zaitlen, Claire M. Wade, Andrew Kirby, David Heckerman, Mark J. Daly, and Eleazar Eskin. 2008. “Efficient Control of Population Structure in Model Organism Association Mapping.” *Genetics* 178 (3): 1709–23. <https://doi.org/10.1534/genetics.107.080101>.

Williams, Jacob, Marco A. R. Ferreira, and Tieming Ji. 2022. “BICOSS: Bayesian iterative conditional stochastic search for GWAS.” *BMC Bioinformatics* 23 (475). <https://doi.org/10.1186/s12859-022-05030-0>.

Xu, Shuangshuang, Jacob Williams, and Marco A. R. Ferreira. n.d. “BG2: Bayesian Variable Selection in Generalized Linear Mixed Models with Non-Local Priors for Non-Gaussian Gwas Data.” *Bioinformatics* Submitted.

Zhang, Zhiwu, Elhan Ersoz, Chao-Qiang Lai, Rory J Todhunter, Hemant K Tiwari, Michael A Gore, Peter J Bradbury, et al. 2010. “Mixed Linear Model Approach Adapted for Genome-Wide Association Studies.” *Nature Genetics* 42 (4): 355–60.