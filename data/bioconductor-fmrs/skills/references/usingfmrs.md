# Using fmrs package

#### Farhad Shokoohi

#### 2025-10-30

# fmrs package in action

## Data generation

The function `fmrs.gendata` generates a data set from an FMRs model. It has the form

```
fmrs.gendata(nObs, nComp, nCov, coeff, dispersion, mixProp, rho, umax, ...)
```

where `n` is the sample size, `nComp` is the order of FMRs model, `nCov` is the number of regression covariates, `coeff`, `dispersion` and `mixProp` are the parameters of regression models, i.e. regression coefficients, dispersion (standard deviation) of the errors (sub-distributions) and mixing proportions, respectively, and `rho` is the used in the variance-covariance matrix for simulating the design matrix `x`, and `umax` is the upper bound for Uniform distribution for generating censoring times.

Depending on the choice of `disFamily`, the function `fmrs.gendata` generates a simulated data from FMRs models. For instance, if we choose `disFamily = "norm"`, the function ignores the censoring parameter `umax` and generates a data set from an FMR model with Normal sub-distributions. However, if we choose `disFamily = "lnorm"` or `disFamily = "weibull"`, the function generates data under a finite mixture of AFT regression model with Log-Normal or Weibull sub-distributions.

The `fmrs.gendata` function returns a list which includes a vector of responses `$y`, a matrix of covariates `$x` and a vector of censoring indicators `$delta` as well as the name of sub-distribution of the mixture model.

## MLE of FMRs models

The function `fmrs.mle` in fmrs package provides maximum likelihood estimation for the parameters of an FMRs model. The function has the following form,

```
fmrs.mle(y, x, delta, nComp, ...)
```

where `y`, `x` and `delta` are observations, covariates and censoring indicators respectively, and `nComp` is the order of FMRs, `initCoeff`, `initDispersion` and `initmixProp` are initial values for EM and NR algorithms, and the rest of arguments of the function are controlling parameres. The function returns a fitted FMRs model with estimates of regression parameters, standard deviations and mixing proportions of the mixture model. It also returns the log-likelihood and BIC under the estimated model, the maximum number of iterations used in EM algorithm and the type of the fitted model.

Note that one can do ridge regression by setting a value for tuning parameter of the ridge penalty other than zero in the argument `lambRidge`.

## Variable selection in FMRs models

To do the variable selection we provided the function `fmrs.varsel` with the form

```
fmrs.varsel(y, x, delta, nComp, ...)
```

where `penFamily` is the penalty including `"adplasso"`, `"lasso"`, `"mcp"`, `"scad"`, `"sica"` and `"hard"`, and `lambPen` is the set of tuning parameters for components of penalty. We can run the function `fmrslme` first and use the parameter estimates as initial values for the function `fmrs.varsel`.

### Choice of tuning parameter

There are two approaches for specifying tuning parameters: Common and Component-wise tuning parameters. If we consider choosing common tuning parameter, we can use the BIC criteria to search through the a set of candidate values in the interval \((0,\lambda\_M)\), where \(\lambda\_M\) is a prespecified number. The BIC is provided by the function `fmrs.varsel` for each candidate point and we choose the optimal \(\hat\lambda\), the one that maximizes BIC. This approach will be good for the situations with enough samples sizes. It also reduces the computational burden.

On the other hand, if we consider choosing component-wise tuning parameters we use the following function to search for optimal \((\lambda\_1, \ldots, \lambda\_K)\) from the set of candidate values in \((0, \lambda\_M)\). The function is

```
fmrs.tunsel(y, x, delta, nComp, ...)
```

It is a good practice run the function `fmrs.mle` first and use the parameter estimates as initial values in the function `fmrs.tunsel`. The function `fmrs.mle` then returns a set optimal tuning parameters of size `nComp` to be used in variable selection function. Note that this approach still is under theoretical study and is not proved to give optimal values in general.

## Example: finite mixture of AFT regression model (Log-Normal)

We use a simulated data set to illustrate using `fmrs` package. We generate the covariates (design matrix) from a multivariate normal distribution of dimension `nCov=10` and sample size 200 with mean vector \(\bf 0\) and variance-covariance matrix \(\Sigma=(0.5^{|i-j|})\). We then generate time-to-event data from a finite mixture of two components AFT regression models with Log-Normal sub-distributions. The mixing proportions are set to \(\pi=(0.3, 0.7)\). We choose \(\boldsymbol\beta\_0=(2,-1)\) as the intercepts, \(\boldsymbol\beta\_1=(-1, -2, 1, 2, 0 , 0, 0, 0, 0, 0)\) and \(\boldsymbol\beta\_2=(1, 2, 0, 0, 0 , 0, -1, 2, -2, 3)\) as the regression coefficients in first and second component, respectively.

We start by loading necessary libraries and assigning the parameters of model as follows.

```
library(fmrs)
```

```
## BugReports: https://github.com/shokoohi/fmrs/issues
```

```
set.seed(1980)
nComp = 2
nCov = 10
nObs = 500
dispersion = c(1, 1)
mixProp = c(0.4, 0.6)
rho = 0.5
coeff1 = c( 2,  2, -1, -2, 1, 2, 0, 0,  0, 0,  0)
coeff2 = c(-1, -1,  1,  2, 0, 0, 0, 0, -1, 2, -2)
umax = 40
```

Using the function `fmrs.gendata`, we generate a data set from a finite mixture of accelerated failure time regression models with above settings as follow.

```
dat <- fmrs.gendata(nObs = nObs, nComp = nComp, nCov = nCov,
                     coeff = c(coeff1, coeff2), dispersion = dispersion,
                     mixProp = mixProp, rho = rho, umax = umax,
                     disFamily = "lnorm")
```

Now we assume that the generated data are actually real data. We find MLE of the parameters of the assumed model using following code. Note that almost all mixture of regression models depends on initial values. Here we generate the initial values form a Normal distribution with

```
res.mle <- fmrs.mle(y = dat$y, x = dat$x, delta = dat$delta,
                   nComp = nComp, disFamily = "lnorm",
                   initCoeff = rnorm(nComp*nCov+nComp),
                   initDispersion = rep(1, nComp),
                   initmixProp = rep(1/nComp, nComp))
summary(res.mle)
```

```
## -------------------------------------------
## Fitted Model:
## -------------------------------------------
##   Finite Mixture of Accelerated Failure Time
##                   Regression Models
##             Log-Normal Sub-Distributions
##   2 Components; 10 Covariates; 500 samples.
##
## Coefficients:
##                Comp.1       Comp.2
## Intercept -0.98813518  1.993430383
## X.1       -1.04289531  2.132445019
## X.2        1.08397203 -1.076622120
## X.3        1.99159549 -2.180934660
## X.4        0.01722128  1.056957193
## X.5       -0.07980287  1.919587713
## X.6       -0.01501062  0.109143832
## X.7        0.08672761  0.115042361
## X.8       -1.15880098  0.127165742
## X.9        2.10200793 -0.006910483
## X.10      -2.12473990 -0.032354752
##
## Dispersion:
##     Comp.1   Comp.2
##  0.9544685 0.838036
##
## Mixing Proportions:
##     Comp.1    Comp.2
##  0.5861984 0.4138016
##
## LogLik: -759.5507; BIC: 1674.467
```

As we see the ML estimates of regression coefficients are not zero. Therefore MLE cannot provide a sparse solution. In order to provide a sparse solution, we use the variable selection methods developed by Shokoohi et. al. (2016). First we need to find a good set of tuning parameters. It can be done by using component-wise tuning parameter selection function implemented in `fmrs` as follows. In some settings, however, it is better to investigate if common tuning parameter performs better.

```
res.lam <- fmrs.tunsel(y = dat$y, x = dat$x, delta = dat$delta,
                      nComp = nComp, disFamily = "lnorm",
                      initCoeff = c(coefficients(res.mle)),
                      initDispersion = dispersion(res.mle),
                      initmixProp = mixProp(res.mle),
                      penFamily = "adplasso")
summary(res.lam)
```

```
## -------------------------------------------
## Selected Tuning Parameters:
## -------------------------------------------
##   Finite Mixture of Accelerated Failure Time
##          Regression Models
##     Log-Normal Sub-Distributions
##   2 Components; adplasso Penalty;
##
## Component-wise lambda:
##  Comp.1 Comp.2
##    0.01 0.0199
```

We have used MLE estimates as initial values for estimating the tuning parameters. Now we used the same set of values to do variable selection with adaptive lasso penalty as follows.

```
res.var <- fmrs.varsel(y = dat$y, x = dat$x, delta = dat$delta,
                      nComp = ncomp(res.mle), disFamily = "lnorm",
                      initCoeff=c(coefficients(res.mle)),
                      initDispersion = dispersion(res.mle),
                      initmixProp = mixProp(res.mle),
                      penFamily = "adplasso",
                      lambPen = slot(res.lam, "lambPen"))
summary(res.var)
```

```
## -------------------------------------------
## Fitted Model:
## -------------------------------------------
##   Finite Mixture of Accelerated Failure Time
##                   Regression Models
##             Log-Normal Sub-Distributions
##   2 Components; 10 Covariates; 500 samples.
##
## Coefficients:
##              Comp.1     Comp.2
## Intercept -1.008742  1.9457714
## X.1       -1.026428  1.9985027
## X.2        1.061368 -0.9324296
## X.3        1.973257 -2.1430407
## X.4        0.000000  0.9920236
## X.5        0.000000  1.9644591
## X.6        0.000000  0.0000000
## X.7        0.000000  0.0000000
## X.8       -1.113816  0.0000000
## X.9        2.087108  0.0000000
## X.10      -2.104553  0.0000000
##
## Selected Set:
##      Comp.1 Comp.2
## X.1       1      1
## X.2       1      1
## X.3       1      1
## X.4       0      1
## X.5       0      1
## X.6       0      0
## X.7       0      0
## X.8       1      0
## X.9       1      0
## X.10      1      0
##
## Dispersion:
##     Comp.1    Comp.2
##  0.9481664 0.9016874
##
## Mixing Proportions:
##     Comp.1    Comp.2
##  0.5807324 0.4192676
##
## LogLik: -764.3914; BIC: 1628.217
```

The final variables that are selected using this procedure are those with non-zero coefficients. Note that a switching between components of mixture has happened here.

```
slot(res.var, "selectedset")
```

```
##      Comp.1 Comp.2
## X.1       1      1
## X.2       1      1
## X.3       1      1
## X.4       0      1
## X.5       0      1
## X.6       0      0
## X.7       0      0
## X.8       1      0
## X.9       1      0
## X.10      1      0
```

Therefore, the variable selection and parameter estimation is done simultaneously using the fmrs package.

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] fmrs_1.20.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     Matrix_1.7-4
##  [5] xfun_0.53         lattice_0.22-7    splines_4.5.1     cachem_1.1.0
##  [9] knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30    lifecycle_1.0.4
## [13] cli_3.6.5         grid_4.5.1        sass_0.4.10       jquerylib_0.1.4
## [17] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
## [21] survival_3.8-3    yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```