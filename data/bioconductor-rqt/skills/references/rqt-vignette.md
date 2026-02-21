# Using RQT, an R package for gene-level meta-analysis

Ilya Y. Zhbannikov

#### 30 October 2025

# Contents

* [0.1 Overview](#overview)
  + [0.1.1 Methods in brief](#methods-in-brief)
* [0.2 Installation of package](#installation-of-package)
* [0.3 Data description](#data-description)
  + [0.3.1 Single dataset](#single-dataset)
  + [0.3.2 Meta-analysis](#meta-analysis)
* [0.4 Examples](#examples)
  + [0.4.1 Gene-level analysis on a single dataset](#gene-level-analysis-on-a-single-dataset)
  + [0.4.2 Meta-analysis](#meta-analysis-1)
* [0.5 Session information](#session-information)

## 0.1 Overview

Despite the recent advances of modern GWAS methods,
it is still remains an important problem of addressing
calculation an effect size and corresponding p-value
for the whole gene rather than for single variant.
We developed an R-package rqt, which offers gene-level GWAS meta-analysis.
The package can be easily included into bioinformatics pipeline
or used as stand-alone.
Contact: ilya.zhbannikov@duke.edu for questions of
usage the or any other issues.

Below we provide several examples that show GWAS
meta-analysis on gene-level layer.

### 0.1.1 Methods in brief

The workflow of gene-level meta analysis consists of the following steps:
(i) reducing the number of predictors, thereby alleviating
correlation problem in variants (accounting for LD);
(ii) then the regression mod-el is fitted on the reduced dataset
to obtain corresponding regression coefficient (“effect sizes”);
(iii) these coefficients are then to be pooled into a total index
representing a total gene-level effect size and corresponding
statistics is calculated. P- and q- values are then calculated
using this statistics from asymptotic approximation or permutation
procedure; (iv) the final step is combining gene-level p-values
calculated from each study with Fisher’s combined probability method.

## 0.2 Installation of package

In order to install the package, the user must first install R (). After that, can be installed with:

```
devtools::install_github("izhbannikov/rqt", buildVignette=TRUE)
```

## 0.3 Data description

### 0.3.1 Single dataset

In requires the following datasets:
(i) (a by 1) matrix (i.e. a vector);
and (ii) - an object of class
containing one assay:
(a by ) matrix, where
- is the total
number of individuals in the study and is the total number
of genetic variants. Optionally, can accept covariates,
in form of by matrix, where
is the total number of
covariates used in the study. Phenotype can be dichotomous
(0/1, where 1 indicates control and 0 case).

### 0.3.2 Meta-analysis

In meta-analysis, requires a list of
( - number
of datasets used in meta-analysis) and optionally it accepts
covariates in form described above.

## 0.4 Examples

### 0.4.1 Gene-level analysis on a single dataset

#### 0.4.1.1 Dichotomous phenotype

```
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.bin1.dat",
                                           package="rqt"), header=TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
res <- geneTest(obj, method="pca", out.type = "D")
print(res)
```

```
## Phenotype:
## [1] 1 1 1 1 1 1
## ...
##
## Genotype:
##      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
## [1,] 0 0 0 1 0 2 1 0 0  0  2  1  2  0  0  2  1  1  0  0  1  0  0  0  0  2  1  0
## [2,] 1 0 1 0 0 1 0 0 0  0  0  0  1  0  0  0  2  1  2  1  0  1  0  0  0  2  1  1
## [3,] 0 0 0 0 1 0 0 1 0  1  1  1  0  0  0  1  1  0  0  1  1  1  0  0  0  1  0  0
## [4,] 0 0 1 0 1 0 0 1 1  0  0  0  1  0  0  0  1  0  0  2  0  1  0  0  0  1  0  2
## [5,] 0 0 1 1 1 1 1 1 0  1  0  1  0  0  0  0  0  0  0  0  1  0  0  1  0  1  2  0
## [6,] 0 0 1 1 1 0 0 1 0  1  1  0  1  0  0  2  0  0  1  0  1  1  0  0  0  2  0  0
##      29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
## [1,]  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  0  0  0  0  1  1  0  0  0  1
## [2,]  2  0  0  0  1  2  1  2  0  1  1  0  1  0  0  1  0  0  0  2  0  1  0  1  0
## [3,]  0  0  0  0  0  1  1  1  2  2  0  0  0  1  0  1  0  2  1  1  1  0  0  0  1
## [4,]  0  0  0  1  2  2  0  1  1  1  1  0  0  0  1  1  0  0  1  1  2  0  1  0  2
## [5,]  0  0  0  0  1  1  0  0  1  1  0  0  2  2  0  0  0  1  2  1  0  0  0  0  1
## [6,]  0  0  0  0  1  0  1  1  0  0  2  0  1  1  2  0  0  0  1  1  1  0  0  1  1
##      54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78
## [1,]  1  1  1  1  0  0  0  0  1  1  0  1  1  1  0  1  1  2  1  1  1  0  0  2  1
## [2,]  2  1  0  1  0  0  0  1  0  1  2  2  1  1  0  1  0  1  0  0  0  0  1  1  2
## [3,]  2  1  0  0  0  0  0  0  0  1  0  0  1  1  0  1  2  1  0  1  1  0  0  0  0
## [4,]  1  1  0  0  0  0  2  1  0  1  0  0  2  1  0  0  1  1  1  0  0  0  0  0  1
## [5,]  1  1  1  0  0  0  2  1  1  0  0  1  1  0  0  1  1  0  0  1  0  1  0  0  1
## [6,]  0  1  1  0  0  0  0  0  0  0  1  2  1  1  0  0  0  0  0  1  1  1  1  1  1
##      79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
## [1,]  1  1  0  1  1  0  1  1  0  0  0  1  0  1  1  0  0  0  1  0  1   1
## [2,]  1  1  2  0  0  0  1  2  0  2  1  0  0  2  1  0  0  0  0  1  1   2
## [3,]  1  1  0  0  0  0  2  0  0  2  0  0  0  0  1  1  0  0  1  2  0   0
## [4,]  0  1  2  0  1  0  1  2  0  0  0  0  0  0  1  0  0  0  1  0  0   0
## [5,]  0  2  0  1  0  0  2  0  0  0  0  1  0  0  1  0  0  1  1  2  1   1
## [6,]  2  1  0  0  1  0  0  0  0  2  0  1  0  0  0  0  0  1  1  0  1   1
## ...
##
## Covariates:
## data frame with 0 columns and 0 rows
##
##
## Results:
##
## $Qstatistic
##          Q1       Q2        Q3
## 1 0.3798991 13.83897 0.3798991
##
## $pValue
##       pVal1     pVal2     pVal3
## 1 0.5376573 0.5862745 0.7862228
##
## $beta
## [1] -0.005612555
##
## $var.pooled
## [1] 8.291881e-05
##
## $mean.vif
## [1] 1
##
## $model
## [1] "PCA"
```

#### 0.4.1.2 Continuous phenotype

```
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.cont1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
res <- geneTest(obj, method="pca", out.type = "C")
print(res)
```

```
## Phenotype:
## [1] 3.422452 2.457394 2.708564 4.589394 5.461723 4.438707
## ...
##
## Genotype:
##      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
## [1,] 0 0 0 1 0 2 1 0 0  0  2  1  2  0  0  2  1  1  0  0  1  0  0  0  0  2  1  0
## [2,] 1 0 1 0 0 1 0 0 0  0  0  0  1  0  0  0  2  1  2  1  0  1  0  0  0  2  1  1
## [3,] 0 0 0 0 1 0 0 1 0  1  1  1  0  0  0  1  1  0  0  1  1  1  0  0  0  1  0  0
## [4,] 0 0 1 0 1 0 0 1 1  0  0  0  1  0  0  0  1  0  0  2  0  1  0  0  0  1  0  2
## [5,] 0 0 1 1 1 1 1 1 0  1  0  1  0  0  0  0  0  0  0  0  1  0  0  1  0  1  2  0
## [6,] 0 0 1 1 1 0 0 1 0  1  1  0  1  0  0  2  0  0  1  0  1  1  0  0  0  2  0  0
##      29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
## [1,]  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  0  0  0  0  1  1  0  0  0  1
## [2,]  2  0  0  0  1  2  1  2  0  1  1  0  1  0  0  1  0  0  0  2  0  1  0  1  0
## [3,]  0  0  0  0  0  1  1  1  2  2  0  0  0  1  0  1  0  2  1  1  1  0  0  0  1
## [4,]  0  0  0  1  2  2  0  1  1  1  1  0  0  0  1  1  0  0  1  1  2  0  1  0  2
## [5,]  0  0  0  0  1  1  0  0  1  1  0  0  2  2  0  0  0  1  2  1  0  0  0  0  1
## [6,]  0  0  0  0  1  0  1  1  0  0  2  0  1  1  2  0  0  0  1  1  1  0  0  1  1
##      54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78
## [1,]  1  1  1  1  0  0  0  0  1  1  0  1  1  1  0  1  1  2  1  1  1  0  0  2  1
## [2,]  2  1  0  1  0  0  0  1  0  1  2  2  1  1  0  1  0  1  0  0  0  0  1  1  2
## [3,]  2  1  0  0  0  0  0  0  0  1  0  0  1  1  0  1  2  1  0  1  1  0  0  0  0
## [4,]  1  1  0  0  0  0  2  1  0  1  0  0  2  1  0  0  1  1  1  0  0  0  0  0  1
## [5,]  1  1  1  0  0  0  2  1  1  0  0  1  1  0  0  1  1  0  0  1  0  1  0  0  1
## [6,]  0  1  1  0  0  0  0  0  0  0  1  2  1  1  0  0  0  0  0  1  1  1  1  1  1
##      79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
## [1,]  1  1  0  1  1  0  1  1  0  0  0  1  0  1  1  0  0  0  1  0  1   1
## [2,]  1  1  2  0  0  0  1  2  0  2  1  0  0  2  1  0  0  0  0  1  1   2
## [3,]  1  1  0  0  0  0  2  0  0  2  0  0  0  0  1  1  0  0  1  2  0   0
## [4,]  0  1  2  0  1  0  1  2  0  0  0  0  0  0  1  0  0  0  1  0  0   0
## [5,]  0  2  0  1  0  0  2  0  0  0  0  1  0  0  1  0  0  1  1  2  1   1
## [6,]  2  1  0  0  1  0  0  0  0  2  0  1  0  0  0  0  0  1  1  0  1   1
## ...
##
## Covariates:
## data frame with 0 columns and 0 rows
##
##
## Results:
##
## $Qstatistic
##          Q1       Q2       Q3
## 1 0.7901911 46.38915 12.15855
##
## $pValue
##       pVal1        pVal2       pVal3
## 1 0.3740423 6.908983e-05 0.001169993
##
## $beta
## [1] -0.0164608
##
## $var.pooled
## [1] 0.0003429017
##
## $mean.vif
## [1] 1
##
## $model
## [1] "PCA"
```

#### 0.4.1.3 Preprocessing with Partial Least Square regression (PLS)

This method is used for continous outcome, i.e. out.type = “C”.

```
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.cont1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
res <- geneTest(obj, method="pls", out.type = "C")
print(res)
```

```
## Phenotype:
## [1] 3.422452 2.457394 2.708564 4.589394 5.461723 4.438707
## ...
##
## Genotype:
##      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
## [1,] 0 0 0 1 0 2 1 0 0  0  2  1  2  0  0  2  1  1  0  0  1  0  0  0  0  2  1  0
## [2,] 1 0 1 0 0 1 0 0 0  0  0  0  1  0  0  0  2  1  2  1  0  1  0  0  0  2  1  1
## [3,] 0 0 0 0 1 0 0 1 0  1  1  1  0  0  0  1  1  0  0  1  1  1  0  0  0  1  0  0
## [4,] 0 0 1 0 1 0 0 1 1  0  0  0  1  0  0  0  1  0  0  2  0  1  0  0  0  1  0  2
## [5,] 0 0 1 1 1 1 1 1 0  1  0  1  0  0  0  0  0  0  0  0  1  0  0  1  0  1  2  0
## [6,] 0 0 1 1 1 0 0 1 0  1  1  0  1  0  0  2  0  0  1  0  1  1  0  0  0  2  0  0
##      29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
## [1,]  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  0  0  0  0  1  1  0  0  0  1
## [2,]  2  0  0  0  1  2  1  2  0  1  1  0  1  0  0  1  0  0  0  2  0  1  0  1  0
## [3,]  0  0  0  0  0  1  1  1  2  2  0  0  0  1  0  1  0  2  1  1  1  0  0  0  1
## [4,]  0  0  0  1  2  2  0  1  1  1  1  0  0  0  1  1  0  0  1  1  2  0  1  0  2
## [5,]  0  0  0  0  1  1  0  0  1  1  0  0  2  2  0  0  0  1  2  1  0  0  0  0  1
## [6,]  0  0  0  0  1  0  1  1  0  0  2  0  1  1  2  0  0  0  1  1  1  0  0  1  1
##      54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78
## [1,]  1  1  1  1  0  0  0  0  1  1  0  1  1  1  0  1  1  2  1  1  1  0  0  2  1
## [2,]  2  1  0  1  0  0  0  1  0  1  2  2  1  1  0  1  0  1  0  0  0  0  1  1  2
## [3,]  2  1  0  0  0  0  0  0  0  1  0  0  1  1  0  1  2  1  0  1  1  0  0  0  0
## [4,]  1  1  0  0  0  0  2  1  0  1  0  0  2  1  0  0  1  1  1  0  0  0  0  0  1
## [5,]  1  1  1  0  0  0  2  1  1  0  0  1  1  0  0  1  1  0  0  1  0  1  0  0  1
## [6,]  0  1  1  0  0  0  0  0  0  0  1  2  1  1  0  0  0  0  0  1  1  1  1  1  1
##      79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
## [1,]  1  1  0  1  1  0  1  1  0  0  0  1  0  1  1  0  0  0  1  0  1   1
## [2,]  1  1  2  0  0  0  1  2  0  2  1  0  0  2  1  0  0  0  0  1  1   2
## [3,]  1  1  0  0  0  0  2  0  0  2  0  0  0  0  1  1  0  0  1  2  0   0
## [4,]  0  1  2  0  1  0  1  2  0  0  0  0  0  0  1  0  0  0  1  0  0   0
## [5,]  0  2  0  1  0  0  2  0  0  0  0  1  0  0  1  0  0  1  1  2  1   1
## [6,]  2  1  0  0  1  0  0  0  0  2  0  1  0  0  0  0  0  1  1  0  1   1
## ...
##
## Covariates:
## data frame with 0 columns and 0 rows
##
##
## Results:
##
## $Qstatistic
##          Q1           Q2        Q3
## 1 0.1590242 0.0001860569 0.1590242
##
## $pValue
##       pVal1 pVal2     pVal3
## 1 0.6900565     1 0.9035676
##
## $beta
## [1] 0.4623658
##
## $var.pooled
## [1] 1.344337
##
## $mean.vif
## [1] 1
##
## $model
## Partial least squares regression, fitted with the kernel algorithm.
## Call:
## plsr(formula = pheno ~ ., ncomp = numcomp, data = dd, validation = "none")
```

#### 0.4.1.4 Preprocessing with Partial Least Square Discriminant Analysis (PLS-DA)

This method of data preprocessing is used for dichotomous outcome.

```
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.bin1.dat",
                                           package="rqt"), header=TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
# Not yet supported, sorry!
#res <- geneTest(obj, method="pls", out.type = "D", scale = TRUE)
print(res)
```

```
## Phenotype:
## [1] 3.422452 2.457394 2.708564 4.589394 5.461723 4.438707
## ...
##
## Genotype:
##      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
## [1,] 0 0 0 1 0 2 1 0 0  0  2  1  2  0  0  2  1  1  0  0  1  0  0  0  0  2  1  0
## [2,] 1 0 1 0 0 1 0 0 0  0  0  0  1  0  0  0  2  1  2  1  0  1  0  0  0  2  1  1
## [3,] 0 0 0 0 1 0 0 1 0  1  1  1  0  0  0  1  1  0  0  1  1  1  0  0  0  1  0  0
## [4,] 0 0 1 0 1 0 0 1 1  0  0  0  1  0  0  0  1  0  0  2  0  1  0  0  0  1  0  2
## [5,] 0 0 1 1 1 1 1 1 0  1  0  1  0  0  0  0  0  0  0  0  1  0  0  1  0  1  2  0
## [6,] 0 0 1 1 1 0 0 1 0  1  1  0  1  0  0  2  0  0  1  0  1  1  0  0  0  2  0  0
##      29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
## [1,]  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  0  0  0  0  1  1  0  0  0  1
## [2,]  2  0  0  0  1  2  1  2  0  1  1  0  1  0  0  1  0  0  0  2  0  1  0  1  0
## [3,]  0  0  0  0  0  1  1  1  2  2  0  0  0  1  0  1  0  2  1  1  1  0  0  0  1
## [4,]  0  0  0  1  2  2  0  1  1  1  1  0  0  0  1  1  0  0  1  1  2  0  1  0  2
## [5,]  0  0  0  0  1  1  0  0  1  1  0  0  2  2  0  0  0  1  2  1  0  0  0  0  1
## [6,]  0  0  0  0  1  0  1  1  0  0  2  0  1  1  2  0  0  0  1  1  1  0  0  1  1
##      54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78
## [1,]  1  1  1  1  0  0  0  0  1  1  0  1  1  1  0  1  1  2  1  1  1  0  0  2  1
## [2,]  2  1  0  1  0  0  0  1  0  1  2  2  1  1  0  1  0  1  0  0  0  0  1  1  2
## [3,]  2  1  0  0  0  0  0  0  0  1  0  0  1  1  0  1  2  1  0  1  1  0  0  0  0
## [4,]  1  1  0  0  0  0  2  1  0  1  0  0  2  1  0  0  1  1  1  0  0  0  0  0  1
## [5,]  1  1  1  0  0  0  2  1  1  0  0  1  1  0  0  1  1  0  0  1  0  1  0  0  1
## [6,]  0  1  1  0  0  0  0  0  0  0  1  2  1  1  0  0  0  0  0  1  1  1  1  1  1
##      79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
## [1,]  1  1  0  1  1  0  1  1  0  0  0  1  0  1  1  0  0  0  1  0  1   1
## [2,]  1  1  2  0  0  0  1  2  0  2  1  0  0  2  1  0  0  0  0  1  1   2
## [3,]  1  1  0  0  0  0  2  0  0  2  0  0  0  0  1  1  0  0  1  2  0   0
## [4,]  0  1  2  0  1  0  1  2  0  0  0  0  0  0  1  0  0  0  1  0  0   0
## [5,]  0  2  0  1  0  0  2  0  0  0  0  1  0  0  1  0  0  1  1  2  1   1
## [6,]  2  1  0  0  1  0  0  0  0  2  0  1  0  0  0  0  0  1  1  0  1   1
## ...
##
## Covariates:
## data frame with 0 columns and 0 rows
##
##
## Results:
##
## $Qstatistic
##          Q1           Q2        Q3
## 1 0.1590242 0.0001860569 0.1590242
##
## $pValue
##       pVal1 pVal2     pVal3
## 1 0.6900565     1 0.9035676
##
## $beta
## [1] 0.4623658
##
## $var.pooled
## [1] 1.344337
##
## $mean.vif
## [1] 1
##
## $model
## Partial least squares regression, fitted with the kernel algorithm.
## Call:
## plsr(formula = pheno ~ ., ncomp = numcomp, data = dd, validation = "none")
```

#### 0.4.1.5 Using additional covariates

Quite often, researchers want to supply not only genetic
data but also specific covariates,
representic some physiological parameters or environment
(for example, to evaluate
hyphoteses of gene-environment interactions).
In such cases, the package
can accept additional covariates, in form of
by matrix, as provided below:

```
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.bin1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
covars <- read.table(system.file("extdata/test.cova1.dat",package="rqt"),
    header=TRUE)
obj <- rqt(phenotype=pheno, genotype=geno.obj, covariates = covars)
res <- geneTest(obj, method="pca", out.type = "D")
print(res)
```

```
## Phenotype:
## [1] 1 1 1 1 1 1
## ...
##
## Genotype:
##      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
## [1,] 0 0 0 1 0 2 1 0 0  0  2  1  2  0  0  2  1  1  0  0  1  0  0  0  0  2  1  0
## [2,] 1 0 1 0 0 1 0 0 0  0  0  0  1  0  0  0  2  1  2  1  0  1  0  0  0  2  1  1
## [3,] 0 0 0 0 1 0 0 1 0  1  1  1  0  0  0  1  1  0  0  1  1  1  0  0  0  1  0  0
## [4,] 0 0 1 0 1 0 0 1 1  0  0  0  1  0  0  0  1  0  0  2  0  1  0  0  0  1  0  2
## [5,] 0 0 1 1 1 1 1 1 0  1  0  1  0  0  0  0  0  0  0  0  1  0  0  1  0  1  2  0
## [6,] 0 0 1 1 1 0 0 1 0  1  1  0  1  0  0  2  0  0  1  0  1  1  0  0  0  2  0  0
##      29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
## [1,]  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  0  0  0  0  1  1  0  0  0  1
## [2,]  2  0  0  0  1  2  1  2  0  1  1  0  1  0  0  1  0  0  0  2  0  1  0  1  0
## [3,]  0  0  0  0  0  1  1  1  2  2  0  0  0  1  0  1  0  2  1  1  1  0  0  0  1
## [4,]  0  0  0  1  2  2  0  1  1  1  1  0  0  0  1  1  0  0  1  1  2  0  1  0  2
## [5,]  0  0  0  0  1  1  0  0  1  1  0  0  2  2  0  0  0  1  2  1  0  0  0  0  1
## [6,]  0  0  0  0  1  0  1  1  0  0  2  0  1  1  2  0  0  0  1  1  1  0  0  1  1
##      54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78
## [1,]  1  1  1  1  0  0  0  0  1  1  0  1  1  1  0  1  1  2  1  1  1  0  0  2  1
## [2,]  2  1  0  1  0  0  0  1  0  1  2  2  1  1  0  1  0  1  0  0  0  0  1  1  2
## [3,]  2  1  0  0  0  0  0  0  0  1  0  0  1  1  0  1  2  1  0  1  1  0  0  0  0
## [4,]  1  1  0  0  0  0  2  1  0  1  0  0  2  1  0  0  1  1  1  0  0  0  0  0  1
## [5,]  1  1  1  0  0  0  2  1  1  0  0  1  1  0  0  1  1  0  0  1  0  1  0  0  1
## [6,]  0  1  1  0  0  0  0  0  0  0  1  2  1  1  0  0  0  0  0  1  1  1  1  1  1
##      79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
## [1,]  1  1  0  1  1  0  1  1  0  0  0  1  0  1  1  0  0  0  1  0  1   1
## [2,]  1  1  2  0  0  0  1  2  0  2  1  0  0  2  1  0  0  0  0  1  1   2
## [3,]  1  1  0  0  0  0  2  0  0  2  0  0  0  0  1  1  0  0  1  2  0   0
## [4,]  0  1  2  0  1  0  1  2  0  0  0  0  0  0  1  0  0  0  1  0  0   0
## [5,]  0  2  0  1  0  0  2  0  0  0  0  1  0  0  1  0  0  1  1  2  1   1
## [6,]  2  1  0  0  1  0  0  0  0  2  0  1  0  0  0  0  0  1  1  0  1   1
## ...
##
## Covariates:
##           COV1
## 1 -0.612463927
## 2 -0.464158885
## 3  0.006153597
## 4 -0.732109468
## 5 -0.223530136
## 6 -0.744903822
##
##
## Results:
##
## $Qstatistic
##          Q1       Q2        Q3
## 1 0.3732768 13.07139 0.3732768
##
## $pValue
##       pVal1     pVal2     pVal3
## 1 0.5412235 0.6440566 0.7896537
##
## $beta
## [1] -0.005553824
##
## $var.pooled
## [1] 8.263294e-05
##
## $mean.vif
## [1] 1
##
## $model
## [1] "PCA"
```

For continous phenotype:

```
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.cont1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
covars <- read.table(system.file("extdata/test.cova1.dat",package="rqt"),
    header=TRUE)
obj <- rqt(phenotype=pheno, genotype=geno.obj, covariates = covars)
res <- geneTest(obj, method="pca", out.type = "C")
print(res)
```

```
## Phenotype:
## [1] 3.422452 2.457394 2.708564 4.589394 5.461723 4.438707
## ...
##
## Genotype:
##      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
## [1,] 0 0 0 1 0 2 1 0 0  0  2  1  2  0  0  2  1  1  0  0  1  0  0  0  0  2  1  0
## [2,] 1 0 1 0 0 1 0 0 0  0  0  0  1  0  0  0  2  1  2  1  0  1  0  0  0  2  1  1
## [3,] 0 0 0 0 1 0 0 1 0  1  1  1  0  0  0  1  1  0  0  1  1  1  0  0  0  1  0  0
## [4,] 0 0 1 0 1 0 0 1 1  0  0  0  1  0  0  0  1  0  0  2  0  1  0  0  0  1  0  2
## [5,] 0 0 1 1 1 1 1 1 0  1  0  1  0  0  0  0  0  0  0  0  1  0  0  1  0  1  2  0
## [6,] 0 0 1 1 1 0 0 1 0  1  1  0  1  0  0  2  0  0  1  0  1  1  0  0  0  2  0  0
##      29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
## [1,]  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  0  0  0  0  1  1  0  0  0  1
## [2,]  2  0  0  0  1  2  1  2  0  1  1  0  1  0  0  1  0  0  0  2  0  1  0  1  0
## [3,]  0  0  0  0  0  1  1  1  2  2  0  0  0  1  0  1  0  2  1  1  1  0  0  0  1
## [4,]  0  0  0  1  2  2  0  1  1  1  1  0  0  0  1  1  0  0  1  1  2  0  1  0  2
## [5,]  0  0  0  0  1  1  0  0  1  1  0  0  2  2  0  0  0  1  2  1  0  0  0  0  1
## [6,]  0  0  0  0  1  0  1  1  0  0  2  0  1  1  2  0  0  0  1  1  1  0  0  1  1
##      54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78
## [1,]  1  1  1  1  0  0  0  0  1  1  0  1  1  1  0  1  1  2  1  1  1  0  0  2  1
## [2,]  2  1  0  1  0  0  0  1  0  1  2  2  1  1  0  1  0  1  0  0  0  0  1  1  2
## [3,]  2  1  0  0  0  0  0  0  0  1  0  0  1  1  0  1  2  1  0  1  1  0  0  0  0
## [4,]  1  1  0  0  0  0  2  1  0  1  0  0  2  1  0  0  1  1  1  0  0  0  0  0  1
## [5,]  1  1  1  0  0  0  2  1  1  0  0  1  1  0  0  1  1  0  0  1  0  1  0  0  1
## [6,]  0  1  1  0  0  0  0  0  0  0  1  2  1  1  0  0  0  0  0  1  1  1  1  1  1
##      79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
## [1,]  1  1  0  1  1  0  1  1  0  0  0  1  0  1  1  0  0  0  1  0  1   1
## [2,]  1  1  2  0  0  0  1  2  0  2  1  0  0  2  1  0  0  0  0  1  1   2
## [3,]  1  1  0  0  0  0  2  0  0  2  0  0  0  0  1  1  0  0  1  2  0   0
## [4,]  0  1  2  0  1  0  1  2  0  0  0  0  0  0  1  0  0  0  1  0  0   0
## [5,]  0  2  0  1  0  0  2  0  0  0  0  1  0  0  1  0  0  1  1  2  1   1
## [6,]  2  1  0  0  1  0  0  0  0  2  0  1  0  0  0  0  0  1  1  0  1   1
## ...
##
## Covariates:
##           COV1
## 1 -0.612463927
## 2 -0.464158885
## 3  0.006153597
## 4 -0.732109468
## 5 -0.223530136
## 6 -0.744903822
##
##
## Results:
##
## $Qstatistic
##          Q1       Q2       Q3
## 1 0.7761103 44.94641 11.63278
##
## $pValue
##       pVal1       pVal2       pVal3
## 1 0.3783334 0.000115889 0.001549197
##
## $beta
## [1] -0.01629069
##
## $var.pooled
## [1] 0.0003419444
##
## $mean.vif
## [1] 1
##
## $model
## [1] "PCA"
```

### 0.4.2 Meta-analysis

```
library(rqt)

data1 <- data.matrix(read.table(system.file("extdata/phengen2.dat",
                                            package="rqt"), skip=1))
pheno <- data1[,1]
geno <- data1[, 2:dim(data1)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj1 <- rqt(phenotype=pheno, genotype=geno.obj)

data2 <- data.matrix(read.table(system.file("extdata/phengen3.dat",
                                            package="rqt"), skip=1))
pheno <- data2[,1]
geno <- data2[, 2:dim(data2)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj2 <- rqt(phenotype=pheno, genotype=geno.obj)

data3 <- data.matrix(read.table(system.file("extdata/phengen.dat",
                                            package="rqt"), skip=1))
pheno <- data3[,1]
geno <- data3[, 2:dim(data3)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj3 <- rqt(phenotype=pheno, genotype=geno.obj)

res.meta <- geneTestMeta(list(obj1, obj2, obj3))
print(res.meta)
```

```
## $final.pvalue
## [1] 0.005502565
##
## $pvalueList
## [1] 0.001837563 0.229382293 0.179679688
```

## 0.5 Session information

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
##  [1] rqt_1.36.0                  SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] MultiDataSet_1.38.0         shape_1.4.6.1
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] CompQuadForm_1.4.4          lattice_0.22-7
##  [7] mathjaxr_1.8-0              numDeriv_2016.8-1.1
##  [9] mutoss_0.1-13               tools_4.5.1
## [11] Rdpack_2.6.4                RUnit_0.4.33.1
## [13] sandwich_3.1-1              BiocBaseUtils_1.12.0
## [15] Matrix_1.7-4                lifecycle_1.0.4
## [17] compiler_4.5.1              statmod_1.5.1
## [19] mnormt_2.1.1                codetools_0.2-20
## [21] carData_3.0-5               htmltools_0.5.8.1
## [23] sass_0.4.10                 yaml_2.3.10
## [25] glmnet_4.1-10               Formula_1.2-5
## [27] car_3.1-3                   jquerylib_0.1.4
## [29] MASS_7.3-65                 metap_1.12
## [31] limma_3.66.0                DelayedArray_0.36.0
## [33] cachem_1.1.0                iterators_1.0.14
## [35] abind_1.4-8                 multcomp_1.4-29
## [37] foreach_1.5.2               pls_2.8-5
## [39] digest_0.6.37               mvtnorm_1.3-3
## [41] TFisher_0.2.0               bookdown_0.45
## [43] splines_4.5.1               fastmap_1.2.0
## [45] grid_4.5.1                  cli_3.6.5
## [47] SparseArray_1.10.0          qqconf_1.3.2
## [49] S4Arrays_1.10.0             survival_3.8-3
## [51] TH.data_1.1-4               sn_2.1.1
## [53] plotrix_3.8-4               calibrate_1.7.7
## [55] rmarkdown_2.30              XVector_0.50.0
## [57] multtest_2.66.0             zoo_1.8-14
## [59] evaluate_1.0.5              qqman_0.1.9
## [61] knitr_1.50                  ropls_1.42.0
## [63] rbibutils_2.3               MultiAssayExperiment_1.36.0
## [65] rlang_1.1.6                 Rcpp_1.1.0
## [67] BiocManager_1.30.26         jsonlite_2.0.0
## [69] R6_2.6.1
```