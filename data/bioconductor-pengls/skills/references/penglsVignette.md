# Vignette of the pengls package

#### Stijn Hawinkel

* [1 Introduction](#introduction)
* [2 Installation instuctions](#installation-instuctions)
* [3 Illustration](#illustration)
  + [3.1 Spatial autocorrelation](#spatial-autocorrelation)
  + [3.2 Temporal autocorrelation](#temporal-autocorrelation)
  + [3.3 Penalty parameter and cross-validation](#penalty-parameter-and-cross-validation)
* [4 Session info](#session-info)

# 1 Introduction

This vignette demonstrates the use of the *pengls* package for high-dimensional data with spatial or temporal autocorrelation. It consists of an iterative loop around the *nlme* and *glmnet* packages. Currently, only continuous outcomes and \(R^2\) and *MSE* as performance measure are implemented.

# 2 Installation instuctions

The *pengls* package is available from BioConductor, and can be installed as follows:

```
library(BiocManager)
install("pengls")
```

Once installed, it can be loaded and version info printed.

```
suppressPackageStartupMessages(library(pengls))
cat("pengls package version", as.character(packageVersion("pengls")), "\n")
```

```
## pengls package version 1.16.0
```

# 3 Illustration

## 3.1 Spatial autocorrelation

We first create a toy dataset with spatial coordinates.

```
library(nlme)
n <- 25 #Sample size
p <- 50 #Number of features
g <- 15 #Size of the grid
#Generate grid
Grid <- expand.grid("x" = seq_len(g), "y" = seq_len(g))
# Sample points from grid without replacement
GridSample <- Grid[sample(nrow(Grid), n, replace = FALSE),]
#Generate outcome and regressors
b <- matrix(rnorm(p*n), n , p)
a <- rnorm(n, mean = b %*% rbinom(p, size = 1, p = 0.25), sd = 0.1) #25% signal
#Compile to a matrix
df <- data.frame("a" = a, "b" = b, GridSample)
```

The *pengls* method requires prespecification of a functional form for the autocorrelation. This is done through the *corStruct* objects defined by the *nlme* package. We specify a correlation decaying as a Gaussian curve with distance, and with a nugget parameter. The nugget parameter is a proportion that indicates how much of the correlation structure explained by independent errors; the rest is attributed to spatial autocorrelation. The starting values are chosen as reasonable guesses; they will be overwritten in the fitting process.

```
# Define the correlation structure (see ?nlme::gls), with initial nugget 0.5 and range 5
corStruct <- corGaus(form = ~ x + y, nugget = TRUE, value = c("range" = 5, "nugget" = 0.5))
```

Finally the model is fitted with a single outcome variable and large number of regressors, with the chosen covariance structure and for a prespecified penalty parameter \(\lambda=0.2\).

```
#Fit the pengls model, for simplicity for a simple lambda
penglsFit <- pengls(data = df, outVar = "a", xNames = grep(names(df), pattern = "b", value =TRUE), glsSt = corStruct, lambda = 0.2, verbose = TRUE)
```

```
## Starting iterations...
## Iteration 1
## Iteration 2
## Iteration 3
```

Standard extraction functions like print(), coef() and predict() are defined for the new “pengls” object.

```
penglsFit
```

```
## pengls model with correlation structure: corGaus
##  and 19 non-zero coefficients
```

```
penglsCoef <- coef(penglsFit)
penglsPred <- predict(penglsFit)
```

## 3.2 Temporal autocorrelation

The method can also account for temporal autocorrelation by defining another correlation structure from the *nlme* package, e.g. autocorrelation structure of order 1:

```
set.seed(354509)
n <- 100 #Sample size
p <- 10 #Number of features
#Generate outcome and regressors
b <- matrix(rnorm(p*n), n , p)
a <- rnorm(n, mean = b %*% rbinom(p, size = 1, p = 0.25), sd = 0.1) #25% signal
#Compile to a matrix
dfTime <- data.frame("a" = a, "b" = b, "t" = seq_len(n))
corStructTime <- corAR1(form = ~ t, value = 0.5)
```

The fitting command is similar, this time the \(\lambda\) parameter is found through cross-validation of the naive glmnet (for full cross-validation , see below). We choose \(\alpha=0.5\) this time, fitting an elastic net model.

```
penglsFitTime <- pengls(data = dfTime, outVar = "a", verbose = TRUE,
xNames = grep(names(dfTime), pattern = "b", value =TRUE),
glsSt = corStructTime, nfolds = 5, alpha = 0.5)
```

```
## Fitting naive model...
## Starting iterations...
## Iteration 1
## Iteration 2
```

Show the output

```
penglsFitTime
```

```
## pengls model with correlation structure: corAR1
##  and 2 non-zero coefficients
```

## 3.3 Penalty parameter and cross-validation

The *pengls* package also provides cross-validation for finding the optimal \(\lambda\) value. If the tuning parameter \(\lambda\) is not supplied, the optimal \(\lambda\) according to cross-validation with the naive *glmnet* function (the one that ignores dependence) is used. Hence we recommend to use the following function to use cross-validation. Multithreading is supported through the *BiocParallel* package :

```
library(BiocParallel)
register(MulticoreParam(2)) #Prepare multithereading
```

```
nfolds <- 3 #Number of cross-validation folds
```

The function is called similarly to *cv.glmnet*:

```
penglsFitCV <- cv.pengls(data = df, outVar = "a", xNames = grep(names(df), pattern = "b", value =TRUE), glsSt = corStruct, nfolds = nfolds)
```

Check the result:

```
penglsFitCV
```

```
## Cross-validated pengls model with correlation structure: corGaus
##  and 13 non-zero coefficients.
##  3 fold cross-validation yielded an estimated R2 of -1.986061 .
```

By default, the 1 standard error is used to determine the optimal value of \(\lambda\) :

```
penglsFitCV$lambda.1se #Lambda for 1 standard error rule
```

```
## [1] 1.015137
```

```
penglsFitCV$cvOpt #Corresponding R2
```

```
## [1] -1.986061
```

Extract coefficients and fold IDs.

```
head(coef(penglsFitCV))
```

```
## Intercept      <NA>      <NA>      <NA>      <NA>      <NA>
## 0.9955466 0.2342011 0.0000000 0.0000000 0.0000000 0.0000000
```

```
penglsFitCV$foldid #The folds used
```

```
##  69  72 207  35 125  42 147 211  65 153 102 217  70  27 219  96  90 133  20  87
##   1   3   3   2   2   1   1   2   2   2   1   3   3   1   3   2   1   1   1   3
##  91  92  75  32 193
##   2   2   1   2   3
```

By default, blocked cross-validation is used, but random cross-validation is also available (but not recommended for timecourse or spatial data). First we illustrate the different ways graphically, again using the timecourse example:

```
set.seed(5657)
randomFolds <- makeFolds(nfolds = nfolds, dfTime, "random", "t")
blockedFolds <- makeFolds(nfolds = nfolds, dfTime, "blocked", "t")
plot(dfTime$t, randomFolds, xlab ="Time", ylab ="Fold")
points(dfTime$t, blockedFolds, col = "red")
legend("topleft", legend = c("random", "blocked"), pch = 1, col = c("black", "red"))
```

![](data:image/png;base64...)

To perform random cross-validation

```
penglsFitCVtime <- cv.pengls(data = dfTime, outVar = "a", xNames = grep(names(dfTime), pattern = "b", value =TRUE), glsSt = corStructTime, nfolds = nfolds, cvType = "random")
```

To negate baseline differences at different timepoints, it may be useful to center or scale the outcomes in the cross validation. For instance for centering only:

```
penglsFitCVtimeCenter <- cv.pengls(data = dfTime, outVar = "a", xNames = grep(names(dfTime), pattern = "b", value =TRUE), glsSt = corStructTime, nfolds = nfolds, cvType = "blocked", transFun = function(x) x-mean(x))
penglsFitCVtimeCenter$cvOpt #Better performance
```

```
## [1] 0.9949127
```

Alternatively, the mean squared error (MSE) can be used as loss function, rather than the default \(R^2\):

```
penglsFitCVtime <- cv.pengls(data = dfTime, outVar = "a", xNames = grep(names(dfTime), pattern = "b", value =TRUE), glsSt = corStructTime, nfolds = nfolds, loss =  "MSE")
```

# 4 Session info

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
## [1] BiocParallel_1.44.0 nlme_3.1-168        pengls_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5         knitr_1.50        rlang_1.1.6       xfun_0.53
##  [5] jsonlite_2.0.0    htmltools_0.5.8.1 sass_0.4.10       glmnet_4.1-10
##  [9] rmarkdown_2.30    grid_4.5.1        evaluate_1.0.5    jquerylib_0.1.4
## [13] fastmap_1.2.0     yaml_2.3.10       foreach_1.5.2     lifecycle_1.0.4
## [17] compiler_4.5.1    codetools_0.2-20  Rcpp_1.1.0        lattice_0.22-7
## [21] digest_0.6.37     R6_2.6.1          parallel_4.5.1    splines_4.5.1
## [25] shape_1.4.6.1     bslib_0.9.0       Matrix_1.7-4      tools_4.5.1
## [29] iterators_1.0.14  survival_3.8-3    cachem_1.1.0
```