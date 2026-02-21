# Introduction of mlm4omics

Irene SL Zeng

#### 2 May 2019

#### Package

mlm4omics 1.2.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Summary](#summary)
  + [1.2 The proposed model](#the-proposed-model)
  + [1.3 The computing algorithm](#the-computing-algorithm)
* [2 The mlm4omics R package](#the-mlm4omics-r-package)
* [3 Installation](#installation)
  + [3.1 Use bioconductor as installation source](#use-bioconductor-as-installation-source)
  + [3.2 Use github as installation source](#use-github-as-installation-source)
* [4 Instructions and Examples of using main functions for regressions](#instructions-and-examples-of-using-main-functions-for-regressions)
  + [4.1 Read data and check data](#read-data-and-check-data)
    - [4.1.1 Check for missing and censor indictors](#check-for-missing-and-censor-indictors)
    - [4.1.2 Set the formula for response, missingness and subject](#set-the-formula-for-response-missingness-and-subject)
  + [4.2 Set the formula and fit the regression model](#set-the-formula-and-fit-the-regression-model)
    - [4.2.1 R examples for mlmc()](#r-examples-for-mlmc)
    - [4.2.2 R examples for mlmm()](#r-examples-for-mlmm)
  + [4.3 How to make plots of the parameters and to diagnose convergence](#how-to-make-plots-of-the-parameters-and-to-diagnose-convergence)
    - [4.3.1 plot posterior parameters](#plot-posterior-parameters)
    - [4.3.2 plot trajectory of the posterior samples](#plot-trajectory-of-the-posterior-samples)
* [5 sessionInfo](#sessioninfo)
* [6 References](#references)

```
library(knitr)
library(rmarkdown)
```

```
##
## Attaching package: 'rmarkdown'
```

```
## The following objects are masked from 'package:BiocStyle':
##
##     html_document, md_document, pdf_document
```

```
knitr::opts_chunk$set(echo = TRUE)
```

# 1 Introduction

## 1.1 Summary

High throughput mass-spectrometry clinical proteomics studies curate
abundance data with hierarchical structure. The non-random missingness
of the measurements from a vast amount of information also adds
complexity in data analysis. We propose a multivariate 2 level model
to analyze protein abundances and to handle abundance-dependent
Missingness within a Bayesian framework. The proposed model enables
the variance decomposition at different levels of the data hierarchy
and provides central shrinkage of protein-level estimates for proteins
with small numbers of observations. A logistic regression model with
informative prior of the regression coefficient is used to model the
missing probability. The non-random missing and censored values are
treated as unknown parameters in a Bayesian model. Hamiltonian
MC/No-U-Turn Sampling algorithm is created to derive the posterior
distribution of the unknown parameters. Hamiltonian MC is
demonstrated to gain more efficiency for these high-dimensional
correlated data.

## 1.2 The proposed model

We use an inference model within a multivariate-multilevel framework
to analyze the protein abundance data that are curated in clinical
proteomics studies. These models decompose variations from different
sources, such as experimental factors, proteins’ biological features
and biological samples’ physiological properties. It is also known
that in the ion intensities data which is used to construct protein’s
relative abundance, its missing values depend on the unobserved
abundance values and the probability of missing associated with some
observable experiment factors. In addition to this, due to the detection
limit of a device, we also observe left-censoring
values in the output from many studies. We model
non-random missingness as either left-censored or completely missing
using one of the proposed likelihood-based method of Little and Rubin.
Little (1993), Little and Rubin (1987) proposed three likelihood-based methods
(selection model, pattern-mixture model and shared-parameter model) for
Missing Not At Random (MNAR). Selection model, in which the missing data
mechanism and parameters of the inferential model are conditionally
estimated given the hypothetical completed data, is an appropriate
approach given the abundance-dependent missingness. The hypothetical
completed data comprises the missing and observed values. The known
physical properties of peptides and mass-spectrometers provide the
auxiliary information for the missing probability and missing
values. We use the selection model factorization and include
the left-censored missingness under a Bayesian framework. In two case
studies, we estimate the likelihood of missingness using auxiliary variable
mass-to-charge ratio (m/z) and the intensity values.

## 1.3 The computing algorithm

Our proposed method utilizes Hamiltonian MC/Non-U-Turn Sampling
for the posterior distribution. Compared to the Gibb sampling,
Hamiltonian MC (HMC) avoids the random walk by introducing the
leapfrog function. It provides an alternative to approximating the
solution on the continuous time scale from the solutions on the
discrete time scale, with a specified step-size. The logarithmic
posterior probability function was simulated by one of the paired
partial differentiated equations, namely the Hamiltonian. Larger
moving steps are generated from the leap frog scheme, and this helps
to improve the convergence compared to the random walk. It has been
shown to have higher efficiency in sampling high-dimensional
correlated multivariate distributions. RStan is a new tool recently
developed to implement HMC modeling for Bayesian data analysis, of
which the posterior distribution can be sampled using the No-U-Turn
Sampling method -an extension of HMC. No-U-Turn sampling implements a
recursive algorithm that will enable auto-tuning of the couple
parameters in HMC: numbers of leap-frog steps and the discrete step.
We based on Rstan library function stan() to set up the program for our
proposed model. The R library “mlm4omics” is written to implement posterior
samplings using HMC.

# 2 The mlm4omics R package

The functions included in the pacakge “mlm4omics” are:

1. setinitialvalue(): this function generates initiating values for
   the parameters in the computing.
2. mlmc(): this function provides Rstan program to estimate the
   posterior distribution of parameters in a linear regression model with
   multivariate normal distributed respondents , for example the log
   (peptide ion intensity) from mass-spec, and explanatory variables such
   as a protein identification. Other explanatory variables can be
   experimental variables and clinical design variables. The protein
   identification is an ID to link the peptides to its parent protein.
   The probability of missing, missing and censored values of the
   respondent variable are estimated in the algorithm through a logistic
   regression and a truncated normal distribution for the censored
   values. The probability of missing can be fitted via explanatory
   variables such as the abundance and mass-to-charge ratio of the
   observed ion intensity. The censored values are modelled through
   defining a truncated normal as its prior distribution. mlmc()
   function also provides option (respond\_dep\_missing=TRUE/FALSE) to
   choose if the missing probability is depending on the magnitude of
   missing value.
3. mlmm(): this function is similar to mlmc(), but it is written for
   data without any censored respondent values in the regression
   model. The input variables in this function are similar to those in
   mlmm() but without terms for censored missing.

# 3 Installation

There are two ways to install the package.
Before install the package, please use the instructions from
<https://github.com/stan-dev/rstan/wiki> to install the rstan package firstly.

## 3.1 Use bioconductor as installation source

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("mlm4omics")
library(mlm4omics)
```

## 3.2 Use github as installation source

```
devtools::install_github("superOmics/mlm4omics")
library(mlm4omics)
```

# 4 Instructions and Examples of using main functions for regressions

The following section provides examples using a simulated dataset: pdata.
The examples include:

1. Examples with no informative prior to call the compiled model;
   and the default priors are used.
2. Example with informative priors.

When set up the formulas and parameters for using the mlmm()
and mlmc() functions, some instructions are as follows:

1.The formula\_subject will need to have at least one variable. For
example, to include subject-id for subject and this will provide the
mean value for each subject.

2.The missing and censor values in the response variable require
Different indicators, the missing and censor indictors are
mutually exclusive.

3.The number of iterations are better to set to be >1000.
The default burn-in is half of the set iterations.

## 4.1 Read data and check data

```
library(mlm4omics)
```

```
## Loading required package: Rcpp
```

```
## Registered S3 methods overwritten by 'ggplot2':
##   method         from
##   [.quosures     rlang
##   c.quosures     rlang
##   print.quosures rlang
```

```
data(pdata,package="mlm4omics")
pdata[1:2,]
```

```
##    var1       var2 treatment miss censor geneid sid
## 1    NA 1.63230970         0    1      0      1   1
## 2 0.002 0.06299626         0    0      1      2   2
```

### 4.1.1 Check for missing and censor indictors

Check if there is overlapped definition for missing and censor.
The definition for missing and censored are differently defined.
The following code is to check if the indicators for missing and
censored are mutually exclusive.

```
table(pdata$miss, pdata$censor)
```

```
##
##      0  1
##   0 48 17
##   1 27  8
```

If the indictors coded for missing and censored are overlapped,
the following codes convert missing indictor from 1 to 0
where censor =1.

```
n=dim(pdata)[1]
for (i in seq_len(n))
if (pdata$miss[i]==1 && pdata$censor[i]==1) pdata$miss[i]=0
```

After that, we can set the formula for response, probability of missing
and subject as the followings:

### 4.1.2 Set the formula for response, missingness and subject

```
formula_completed=var1~var2+treatment;
formula_missing=miss~var2;
formula_censor=censor~1;
formula_subject=~treatment;
response_censorlim=0.002
```

Where var1 is the response variable, miss and censor are the indicator
variables for missing and censoring respectively.

## 4.2 Set the formula and fit the regression model

The formula for subject requires at least one variable. For
example, to include subject-id for subject and this will provide the
mean value for each subject.

### 4.2.1 R examples for mlmc()

#### 4.2.1.1 Example 1a. Use default prior and call complied codes

When no priors information available, we can have posterior samples
based on the compiled codes, given the default flat prior
of precision matrix of the protein level covariates (a second
level unit in the multilevel model), and prior for regression
coefficients of the logistic regression predicting the missing
probability.

```
model1 <- mlmc(formula_completed = var1~var2+treatment,
formula_missing = miss~var2,
formula_censor = censor~1, formula_subject = ~sid,
pdata = pdata, response_censorlim = 0.002, respond_dep_missing = TRUE,
pidname = "geneid", sidname = "sid",
iterno = 100, chains = 2, savefile = TRUE)
```

```
##
## SAMPLING FOR MODEL 'mlmc_code' NOW (CHAIN 1).
## Chain 1:
## Chain 1: Gradient evaluation took 0.000141 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.41 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1:
## Chain 1:
## Chain 1: WARNING: There aren't enough warmup iterations to fit the
## Chain 1:          three stages of adaptation as currently configured.
## Chain 1:          Reducing each adaptation stage to 15%/75%/10% of
## Chain 1:          the given number of warmup iterations:
## Chain 1:            init_buffer = 7
## Chain 1:            adapt_window = 38
## Chain 1:            term_buffer = 5
## Chain 1:
## Chain 1: Iteration:  1 / 100 [  1%]  (Warmup)
## Chain 1: Iteration: 10 / 100 [ 10%]  (Warmup)
## Chain 1: Iteration: 20 / 100 [ 20%]  (Warmup)
## Chain 1: Iteration: 30 / 100 [ 30%]  (Warmup)
## Chain 1: Iteration: 40 / 100 [ 40%]  (Warmup)
## Chain 1: Iteration: 50 / 100 [ 50%]  (Warmup)
## Chain 1: Iteration: 51 / 100 [ 51%]  (Sampling)
## Chain 1: Iteration: 60 / 100 [ 60%]  (Sampling)
## Chain 1: Iteration: 70 / 100 [ 70%]  (Sampling)
## Chain 1: Iteration: 80 / 100 [ 80%]  (Sampling)
## Chain 1: Iteration: 90 / 100 [ 90%]  (Sampling)
## Chain 1: Iteration: 100 / 100 [100%]  (Sampling)
## Chain 1:
## Chain 1:  Elapsed Time: 3.12778 seconds (Warm-up)
## Chain 1:                5.35004 seconds (Sampling)
## Chain 1:                8.47782 seconds (Total)
## Chain 1:
##
## SAMPLING FOR MODEL 'mlmc_code' NOW (CHAIN 2).
## Chain 2:
## Chain 2: Gradient evaluation took 0.000218 seconds
## Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 2.18 seconds.
## Chain 2: Adjust your expectations accordingly!
## Chain 2:
## Chain 2:
## Chain 2: WARNING: There aren't enough warmup iterations to fit the
## Chain 2:          three stages of adaptation as currently configured.
## Chain 2:          Reducing each adaptation stage to 15%/75%/10% of
## Chain 2:          the given number of warmup iterations:
## Chain 2:            init_buffer = 7
## Chain 2:            adapt_window = 38
## Chain 2:            term_buffer = 5
## Chain 2:
## Chain 2: Iteration:  1 / 100 [  1%]  (Warmup)
## Chain 2: Iteration: 10 / 100 [ 10%]  (Warmup)
## Chain 2: Iteration: 20 / 100 [ 20%]  (Warmup)
## Chain 2: Iteration: 30 / 100 [ 30%]  (Warmup)
## Chain 2: Iteration: 40 / 100 [ 40%]  (Warmup)
## Chain 2: Iteration: 50 / 100 [ 50%]  (Warmup)
## Chain 2: Iteration: 51 / 100 [ 51%]  (Sampling)
## Chain 2: Iteration: 60 / 100 [ 60%]  (Sampling)
## Chain 2: Iteration: 70 / 100 [ 70%]  (Sampling)
## Chain 2: Iteration: 80 / 100 [ 80%]  (Sampling)
## Chain 2: Iteration: 90 / 100 [ 90%]  (Sampling)
## Chain 2: Iteration: 100 / 100 [100%]  (Sampling)
## Chain 2:
## Chain 2:  Elapsed Time: 0.333055 seconds (Warm-up)
## Chain 2:                0.256586 seconds (Sampling)
## Chain 2:                0.589641 seconds (Total)
## Chain 2:
```

```
## Warning: There were 79 divergent transitions after warmup. Increasing adapt_delta above 0.9 may help. See
## http://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
```

```
## Warning: There were 21 transitions after warmup that exceeded the maximum treedepth. Increase max_treedepth above 10. See
## http://mc-stan.org/misc/warnings.html#maximum-treedepth-exceeded
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Inference for Stan model: mlmc_code.
## 2 chains, each with iter=100; warmup=50; thin=1;
## post-warmup draws per chain=50, total post-warmup draws=100.
##
##                  mean se_mean    sd   2.5%    25%    50%    75% 97.5% n_eff
## U[1,1]           2.89    1.08  1.46   1.44   1.74   2.14   3.54  6.02     2
## U[1,2]           1.44    0.23  0.40   0.74   1.20   1.31   1.71  2.25     3
## U[1,3]          -2.91    0.20  0.84  -4.91  -3.33  -2.72  -2.47 -1.66    17
## U[2,1]          -1.23    2.07  2.40  -3.76  -3.06  -2.48   0.44  3.41     1
## U[2,2]           0.05    1.09  1.12  -1.36  -1.03  -0.06   1.15  1.67     1
## U[2,3]          -1.83    1.15  1.28  -4.00  -3.15  -1.45  -0.83 -0.45     1
## U[3,1]           1.19    0.27  1.03  -1.14   1.02   1.37   1.59  3.00    15
## U[3,2]           1.15    0.05  0.14   0.84   1.10   1.20   1.23  1.30     6
## U[3,3]          -4.53    1.10  1.22  -7.10  -5.44  -4.78  -3.49 -2.46     1
## U[4,1]          -1.19    0.31  1.29  -4.06  -1.72  -1.30  -0.68  1.46    18
## U[4,2]           1.19    0.29  0.37   0.38   0.99   1.22   1.47  1.66     2
## U[4,3]          -2.80    0.21  0.71  -4.15  -3.14  -2.85  -2.57 -1.02    11
## U[5,1]           0.29    2.17  2.41  -2.47  -1.92  -0.86   2.79  4.36     1
## U[5,2]           1.15    0.06  0.14   0.69   1.17   1.20   1.22  1.25     5
## U[5,3]          -2.96    0.42  0.67  -3.84  -3.54  -3.15  -2.46 -1.79     3
## U[6,1]          -1.22    0.47  1.50  -4.69  -1.96  -1.24  -0.60  2.12    10
## U[6,2]           0.65    0.61  0.68  -0.38   0.13   0.64   1.23  1.82     1
## U[6,3]          -3.34    0.25  0.88  -5.58  -3.59  -3.21  -2.88 -2.00    12
## U[7,1]          -1.41    3.71  3.79  -5.73  -5.05  -1.99   1.97  3.99     1
## U[7,2]           1.02    0.16  0.22   0.57   0.85   1.09   1.20  1.30     2
## U[7,3]          -1.67    1.58  1.75  -4.67  -3.38  -0.87  -0.31  0.37     1
## U[8,1]           3.15    0.24  1.03   0.96   3.00   3.15   3.60  5.10    19
## U[8,2]           1.13    0.05  0.15   0.77   1.09   1.14   1.18  1.37     9
## U[8,3]          -4.34    1.01  1.22  -7.11  -5.10  -4.55  -3.44 -2.36     1
## U[9,1]           3.30    0.45  1.42   0.19   2.61   3.46   4.15  5.71    10
## U[9,2]           1.20    0.05  0.16   0.94   1.13   1.15   1.22  1.51    10
## U[9,3]          -3.19    0.92  1.15  -5.07  -4.04  -3.31  -2.52 -0.89     2
## U[10,1]          0.90    2.26  2.49  -1.88  -1.28  -0.44   3.44  4.97     1
## U[10,2]          1.34    0.13  0.20   1.17   1.21   1.25   1.43  1.79     2
## U[10,3]         -3.20    0.78  0.90  -4.45  -3.86  -3.57  -2.43 -1.71     1
## beta2[1,1]      -0.50    0.69  1.05  -2.85  -0.94  -0.04   0.27  0.55     2
## beta2[1,2]      -0.04    0.20  0.46  -1.26  -0.15  -0.02   0.19  0.64     5
## beta2[2,1]      -0.52    0.38  0.62  -2.00  -0.75  -0.24  -0.16  0.27     3
## beta2[2,2]      -0.80    1.88  1.95  -3.81  -2.73  -0.21   0.99  1.57     1
## beta2[3,1]       0.16    0.32  0.74  -0.66  -0.36  -0.19   0.37  1.87     5
## beta2[3,2]       0.17    0.12  0.35  -0.46  -0.01   0.24   0.32  1.05     8
## beta2[4,1]      -0.43    0.11  0.35  -1.33  -0.56  -0.39  -0.22  0.13    10
## beta2[4,2]       0.11    0.12  0.37  -0.45  -0.12   0.02   0.22  1.03     9
## beta2[5,1]       1.41    1.18  1.30  -0.74   0.01   2.21   2.56  2.70     1
## beta2[5,2]      -0.10    0.19  0.29  -0.69  -0.28   0.04   0.10  0.29     2
## beta2[6,1]      -0.53    0.86  0.99  -1.53  -1.40  -0.86   0.01  1.51     1
## beta2[6,2]       0.83    0.32  0.36   0.08   0.62   0.98   1.12  1.24     1
## beta2[7,1]      -0.23    0.19  0.38  -0.93  -0.49  -0.30   0.12  0.31     4
## beta2[7,2]       0.48    0.32  0.36  -0.26   0.15   0.58   0.79  0.86     1
## beta2[8,1]       0.75    0.95  1.20  -2.12   0.06   1.31   1.67  1.85     2
## beta2[8,2]       0.79    0.02  0.12   0.54   0.74   0.78   0.85  0.99    33
## beta2[9,1]       0.38    0.52  0.84  -0.55  -0.26  -0.11   1.34  1.90     3
## beta2[9,2]       0.50    0.06  0.19   0.08   0.43   0.55   0.60  0.82     9
## beta2[10,1]     -0.36    0.18  0.53  -1.15  -0.70  -0.49  -0.24  1.04     8
## beta2[10,2]      0.64    0.29  0.33   0.05   0.36   0.84   0.93  0.96     1
## alpha[1]         0.09    0.18  0.59  -1.07  -0.21   0.07   0.50  1.17    10
## alpha[2]        -0.99    0.06  0.34  -1.62  -1.11  -1.02  -0.93 -0.21    28
## alpha_response   0.01    0.03  0.13  -0.25  -0.09   0.01   0.11  0.27    15
## lp__           -46.81   35.79 36.75 -98.96 -79.35 -49.96 -10.14 -0.52     1
##                Rhat
## U[1,1]         1.98
## U[1,2]         1.51
## U[1,3]         1.28
## U[2,1]         2.00
## U[2,2]         4.58
## U[2,3]         2.43
## U[3,1]         1.23
## U[3,2]         1.28
## U[3,3]         2.84
## U[4,1]         1.01
## U[4,2]         1.60
## U[4,3]         1.12
## U[5,1]         3.26
## U[5,2]         1.47
## U[5,3]         1.39
## U[6,1]         1.40
## U[6,2]         2.56
## U[6,3]         1.17
## U[7,1]         5.79
## U[7,2]         1.81
## U[7,3]         2.42
## U[8,1]         1.21
## U[8,2]         1.41
## U[8,3]         2.38
## U[9,1]         1.09
## U[9,2]         1.14
## U[9,3]         1.78
## U[10,1]        3.34
## U[10,2]        2.17
## U[10,3]        2.34
## beta2[1,1]     1.69
## beta2[1,2]     1.35
## beta2[2,1]     1.32
## beta2[2,2]     4.25
## beta2[3,1]     1.26
## beta2[3,2]     1.35
## beta2[4,1]     1.34
## beta2[4,2]     1.10
## beta2[5,1]     2.46
## beta2[5,2]     1.81
## beta2[6,1]     3.07
## beta2[6,2]     2.53
## beta2[7,1]     1.31
## beta2[7,2]     2.12
## beta2[8,1]     2.40
## beta2[8,2]     1.08
## beta2[9,1]     1.41
## beta2[9,2]     1.11
## beta2[10,1]    1.39
## beta2[10,2]    3.31
## alpha[1]       1.16
## alpha[2]       1.00
## alpha_response 1.19
## lp__           5.15
##
## Samples were drawn using NUTS(diag_e) at Thu May  2 23:10:18 2019.
## For each parameter, n_eff is a crude measure of effective sample size,
## and Rhat is the potential scale reduction factor on split chains (at
## convergence, Rhat=1).
```

#### 4.2.1.2 Example 1b-1c. Use a provided informative priors

Example 1b is to set priors for regression coefficients in the logistic
regression model for missingness.
alpha\_prior is a prior for coefficients (including intercept) in the
logistic regression to predict missing probability; it is a vector with
a length of (1+number of predictors).

Example 1c is to Use an informative prior for precision matrix in the
regression for completed data.
prec\_prior is the precision matrix prior of regression coefficients
-intercept and predictor (var2) in the completed data formula.

```
#Example 1b
model1 <- mlmc(formula_completed=var1~var2+treatment,
formula_missing=miss~var2,
formula_censor=censor~1, formula_subject=~sid,
pdata=pdata, response_censorlim=0.002,
respond_dep_missing=TRUE, pidname="geneid", sidname="sid",
alpha_prior <- c(0,0.001), iterno=100, chains=2,
savefile=TRUE)

#Example 1c
prec_example <- matrix(c(0.01,0.001,0.001,0.01),nrow=2,ncol=2)

model3 <- mlmc(formula_completed=var1~var2,
formula_missing=miss~var2,
formula_censor=censor~1, formula_subject=~sid+treatment,
pdata=pdata, response_censorlim=0.002, respond_dep_missing=TRUE,
pidname="geneid", sidname="sid", prec_prior=prec_example,
iterno=1000, chains=2, savefile=TRUE)
```

### 4.2.2 R examples for mlmm()

Formulas for completed data, subject and missingness all require at
least one variable.

#### 4.2.2.1 Example 2a. Use default prior

```
model5 <- mlmm(formula_completed=var1~var2+treatment,
formula_missing=miss~var2,
formula_subject=~sid, pdata=pdata,
respond_dep_missing=FALSE, pidname="geneid", sidname="sid",
iterno=1000, chains=2, savefile=FALSE)
```

#### 4.2.2.2 Example 2b-2c. Provide informative priors

The user define priors include:

1. prec\_prior : the precision matrix of the first-level parameters (var2
   and treatment);
2. alpha\_prior: coefficients for intercept and var2 to predict
   probability of having missing value in logistic regression.

```
prec_example <- matrix(c(0.01,0.001,0.001,0.001,0.01,0.001,0.001,0.001,0.01),
nrow=3, ncol=3)
```

```
#Example 2b use both priors
model4 <- mlmm(formula_completed=var1~var2+treatment,
formula_missing=miss~var2,
formula_subject=~sid, pdata=pdata,
respond_dep_missing=FALSE, pidname="geneid", sidname="sid",
alpha_prior <- c(0,0.001), prec_prior=prec_example,
iterno=100, chains=2, savefile=TRUE)

#Example 2c. Use alpha prior
model5 <- mlmm(formula_completed=var1~var2+treatment,
formula_missing=miss~var2,
formula_subject=~sid+treatment, pdata=pdata,
respond_dep_missing=FALSE, pidname="geneid",alpha_prior <- c(0,0.001),
sidname="sid", iterno=100, chains=2, savefile=TRUE)
```

## 4.3 How to make plots of the parameters and to diagnose convergence

If the estimate converges, it will have high number of efficient samples
and the rhat value will close to 1.

The following codes are to:

1. plot posterior parameter using the outsummary results from multiple chains.
2. plot the trajectory of posterior sampling including those values generated
   from burn-in iterations.

### 4.3.1 plot posterior parameters

```
summaryreader <- read.csv(file = file.path(getwd(),"outsummary.csv"),
header=TRUE, sep=",", skip=0)

iterno <- dim(summaryreader)[1]; burnin <- iterno/2

U.1.1 <- rowMeans(matrix(c(summaryreader$chain.1.U.1.1,
summaryreader$chain.2.U.1.1), nrow=iterno, ncol=2))[burnin:iterno]

meanU <- mean(U.1.1)
qU <- quantile(U.1.1,p <- seq(0, 1, by=0.025))
scale <- seq(0, 1, by=0.025)

plot(scale, qU, pch=19, ylab="quantiles of estimate", xlab="quantiles")

segments(0,qU[names(qU)=="50%"],1,qU[names(qU)=="50%"],lwd=2,col="red")
segments(0,qU[names(qU)=="2.5%"],1,qU[names(qU)=="2.5%"],lty=2,lwd=2,col="red")
segments(0,qU[names(qU)=="97.5%"],1,qU[names(qU)=="97.5%"],lty=2,lwd=2,
col="red")

legend(0.5,qU[names(qU)=="50%"],"median",cex=0.8,bty="n")
legend(0.03,qU[names(qU)=="2.5%"],"2.5%",cex=0.8,bty="n")
legend(0.90,qU[names(qU)=="97.5%"],"97.5%",cex=0.8,bty="n")
```

![](data:image/png;base64...)

```
qU
```

```
##       0%     2.5%       5%     7.5%      10%    12.5%      15%    17.5%
## 1.683888 1.712642 1.745480 1.784446 1.831081 1.870002 1.870394 1.886988
##      20%    22.5%      25%    27.5%      30%    32.5%      35%    37.5%
## 1.914384 2.196132 2.394665 2.468376 2.485031 2.493693 2.527436 2.555494
##      40%    42.5%      45%    47.5%      50%    52.5%      55%    57.5%
## 2.579763 2.607359 2.628604 2.640323 2.646044 2.650927 2.658452 2.667668
##      60%    62.5%      65%    67.5%      70%    72.5%      75%    77.5%
## 2.678011 2.706313 2.723722 2.724793 2.744484 2.772908 2.817638 2.873451
##      80%    82.5%      85%    87.5%      90%    92.5%      95%    97.5%
## 2.936652 2.941479 2.947989 2.957022 3.042635 3.144672 3.235821 3.522865
##     100%
## 3.940505
```

### 4.3.2 plot trajectory of the posterior samples

```
sample1reader <- read.csv(file <- file.path(getwd(),"samples_1.csv"),
header=TRUE, sep=",", skip=25)

sample2reader <- read.csv(file <- file.path(getwd(),"samples_2.csv"),
header=TRUE, sep=",", skip=25)

#plot variable U.1.1 - the intercept of first unit
trajectory_length <- dim(sample1reader)[1]

plot(seq(1, trajectory_length, by=1), sample1reader$U.1.1, xlab="trajectory
number", ylab="U.1.1", type="n",
ylim = c(min(sample1reader$U.1.1, sample2reader$U.1.1, na.rm=TRUE),
max(sample1reader$U.1.1, sample2reader$U.1.1, na.rm=TRUE)))

trajectory <- seq(1, trajectory_length, by=1)

lines(trajectory, sample1reader$U.1.1)
lines(trajectory, sample2reader$U.1.1, col="red")
```

![](data:image/png;base64...)

# 5 sessionInfo

All of the outputs in this vignette are produced under the following conditions:

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] mlm4omics_1.2.0  Rcpp_1.0.1       rmarkdown_1.12   knitr_1.22
## [5] BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##  [1] compiler_3.6.0     pillar_1.3.1       BiocManager_1.30.4
##  [4] plyr_1.8.4         prettyunits_1.0.2  tools_3.6.0
##  [7] pkgbuild_1.0.3     digest_0.6.18      evaluate_0.13
## [10] tibble_2.1.1       gtable_0.3.0       lattice_0.20-38
## [13] pkgconfig_2.0.2    rlang_0.3.4        Matrix_1.2-17
## [16] cli_1.1.0          parallel_3.6.0     yaml_2.2.0
## [19] xfun_0.6           loo_2.1.0          gridExtra_2.3
## [22] stringr_1.4.0      dplyr_0.8.0.1      stats4_3.6.0
## [25] grid_3.6.0         tidyselect_0.2.5   inline_0.3.15
## [28] glue_1.3.1         R6_2.4.0           processx_3.3.0
## [31] bookdown_0.9       rstan_2.18.2       callr_3.2.0
## [34] ggplot2_3.1.1      purrr_0.3.2        magrittr_1.5
## [37] codetools_0.2-16   rstantools_1.5.1   matrixStats_0.54.0
## [40] StanHeaders_2.18.1 ps_1.3.0           scales_1.0.0
## [43] htmltools_0.3.6    MASS_7.3-51.4      assertthat_0.2.1
## [46] colorspace_1.4-1   stringi_1.4.3      lazyeval_0.2.2
## [49] munsell_0.5.0      crayon_1.3.4
```

# 6 References

1. Hoffman, M.D. and Gelman, A. The No-U-Turn Sampler: Adaptively
   Setting Path Lengths in Hamiltonian Monte Carlo. Journal of machine
   learning research 2011;12.
2. Little, R.J.A. Pattern-mixture models
   for multivariate incomplete
   data. J. Am. Statist. Assoc. 1993;88:125-134.
3. Little, R.J.A. and
   Rubin, D.B. Statistical Analysis with Missing Data. 1987. Neal,
   R.M. MCMC using Hamiltonian dynamics. In: S. Brooks, e.a., editor,
   Handbook of Markov Chain Monte Carlo. 2011.
4. Zeng,I.S. PhD thesis. Statistical methods in clinical proteomic studies
   2007-2014 -A protein concerto-. Research Space: The University of Auckland.
5. Zeng, I.S. Topics in Study Design and Analysis
   for Multistage Clinical Proteomics In: Jung, K., editor, Statistical
   Analysis in Proteomics New York: Humana Press: Springer; 2015.
6. Hrydziuszko, O., and Viant, M. R.. Missing values in mass spectrometry
   based metabolomics: an undervalued step in the data processing pipeline.
   Metabolomics 2012;8,S161S174.
7. Zeng, I.S., Lumley, T., Ruggiero, K. and Middleditch, M. A Bayesian
   approach to multivariate and multilevel modelling with non-random
   missingness for hierarchical clinical proteomics data. In:
   <https://www.biorxiv.org/content/early/2017/06/21/153049>; 2017.