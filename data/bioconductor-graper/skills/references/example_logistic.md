# Vignette illustrating the use of graper in logistic regression

Britta Velten

#### 2025-10-30

# Contents

* [1 Make example data with four groups](#make-example-data-with-four-groups)
* [2 Fit the model](#fit-the-model)
* [3 Posterior distribtions](#posterior-distribtions)
* [4 Model coefficients and intercept](#model-coefficients-and-intercept)
* [5 Make predictions](#make-predictions)

```
library(graper)
library(ggplot2)
```

Note that the implementation of logistic regression
is still experimental. In particular, it has not yet been optimized in terms of computational speed and can be slow for large data sets. Furthermore, calculations of the evidence lower bound are currently not implemented to monitor convergence of the variational inference and the algorithm will stop only when the maximum number of iterations has been reached. This needs to be set to a sufficiently large number.

# 1 Make example data with four groups

Create an example data set with 4 groups,
100 train + 100 test samples and 320 features.

```
set.seed(123)
data <- makeExampleData(n=200, p=320, g=4,
                        pis=c(0.05, 0.1, 0.05, 0.1),
                        gammas=c(0.1, 0.1, 10, 10),
                        response="bernoulli")
# training data set
Xtrain <- data$X[1:100, ]
ytrain <- data$y[1:100]

# annotations of features to groups
annot <- data$annot

# test data set
Xtest <- data$X[101:200, ]
ytest <- data$y[101:200]
```

# 2 Fit the model

`graper` is the main function of this package,
which allows to fit the proposed Bayesian models
with different settings on the prior (by setting `spikeslab` to FALSE or TRUE)
and the variational approximation (by setting `factoriseQ` to FALSE or TRUE).
By default, the model is fit with a sparsity promoting spike-and-slab prior
and a fully-factorised mean-field assumption.
The ELBO is currently not calculated in the logisitc regession framework.

```
fit <- graper(Xtrain, ytrain, annot, verbose=FALSE,
            family="binomial", calcELB=FALSE)
```

```
## Fitting a model with 4 groups, 100 samples and 320 features.
```

```
## Fitting with random init 1
```

```
## Maximum numbers of iterations reached - no convergence or ELB not calculated
```

```
fit
```

```
## Sparse graper object for a logistic regression model with 320 predictors in 4 groups.
##  Group-wise shrinkage:
##  1   2   3   4
##  170.93  4.17    297.4   329.72
## Group-wise sparsity (1 = dense, 0 = sparse):
## 1    2   3   4
## 0.35 0.1 0.29    0.25
```

# 3 Posterior distribtions

The variational Bayes (VB) approach directly yields posterior
distributions for each parameter.
Note, however, that using VB these are often too
concentrated and cannot be directly
used for construction of confidence intervals etc.
However, they can provide good point estimates.

```
plotPosterior(fit, "gamma", gamma0=data$gammas)
```

![](data:image/png;base64...)

```
plotPosterior(fit, "pi", pi0=data$pis)
```

![](data:image/png;base64...)

# 4 Model coefficients and intercept

The estimated coefficients, their posterior inclusion probabilities and
the intercept are contained in the result list.

```
# get coefficients (without the intercept)
beta <- coef(fit, include_intercept=FALSE)
# beta <- fit$EW_beta

# plot estimated versus true beta
qplot(beta, data$beta)
```

![](data:image/png;base64...)

```
# get intercept
intercept <- fit$intercept
```

```
# get estimated posterior inclusion probabilities per feature
pips <- getPIPs(fit)
```

# 5 Make predictions

The function `predict` can be used to make prediction on new data.
Here, we illustrate its use by predicting the response
on the test data defined above.

```
preds <- predict(fit, Xtest)
```

#SessionInfo

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
## [1] ggplot2_4.0.0    graper_1.26.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        gtable_0.3.6        jsonlite_2.0.0
##  [4] crayon_1.5.3        dplyr_1.1.4         compiler_4.5.1
##  [7] BiocManager_1.30.26 tinytex_0.57        tidyselect_1.2.1
## [10] Rcpp_1.1.0          magick_2.9.0        dichromat_2.0-0.1
## [13] jquerylib_0.1.4     scales_1.4.0        yaml_2.3.10
## [16] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
## [19] labeling_0.4.3      generics_0.1.4      knitr_1.50
## [22] tibble_3.3.0        bookdown_0.45       bslib_0.9.0
## [25] pillar_1.11.1       RColorBrewer_1.1-3  rlang_1.1.6
## [28] cachem_1.1.0        xfun_0.53           sass_0.4.10
## [31] S7_0.2.0            cli_3.6.5           withr_3.0.2
## [34] magrittr_2.0.4      digest_0.6.37       grid_4.5.1
## [37] cowplot_1.2.0       lifecycle_1.0.4     vctrs_0.6.5
## [40] evaluate_1.0.5      glue_1.8.0          farver_2.1.2
## [43] rmarkdown_2.30      matrixStats_1.5.0   tools_4.5.1
## [46] pkgconfig_2.0.3     htmltools_0.5.8.1
```