# Vignette illustrating the use of graper in linear regression

Britta Velten

#### 2025-10-30

# Contents

* [1 Make example data with four groups](#make-example-data-with-four-groups)
* [2 Fit the model](#fit-the-model)
* [3 Training diagnostics](#training-diagnostics)
* [4 Posterior distribtions](#posterior-distribtions)
* [5 Model coefficients and intercept](#model-coefficients-and-intercept)
* [6 Posterior inclusion probabilities per feature](#posterior-inclusion-probabilities-per-feature)
* [7 Group-wise penalites](#group-wise-penalites)
* [8 Make predictions](#make-predictions)

```
library(graper)
library(ggplot2)
```

# 1 Make example data with four groups

Create an example data set with 4 groups,
400 train + 100 test samples and 800 features.

```
set.seed(123)
data <- makeExampleData(n = 500, p=800, g=4,
                        pis=c(0.05, 0.1, 0.05, 0.1),
                        gammas=c(0.1, 0.1, 10, 10))
# training data set
Xtrain <- data$X[1:400, ]
ytrain <- data$y[1:400]

# annotations of features to groups
annot <- data$annot

# test data set
Xtest <- data$X[401:500, ]
ytest <- data$y[401:500]
```

# 2 Fit the model

`graper` is the main function of this package,
which allows to fit the proposed Bayesian models with
different settings on the prior (by setting `spikeslab` to FALSE or TRUE) and
the variational approximation (by setting `factoriseQ` to FALSE or TRUE).
By default, the model is fit with a sparsity promoting spike-and-slab prior
and a fully-factorised mean-field assumption. The parameter `n_rep` can be used
to train multiple models with different random initializations.
The best model is then chosen in terms of ELBO and returned by the function.
`th` defines the threshold on the ELBO for convergence
in the variational Bayes (VB) algorithm used for optimization.

```
fit <- graper(Xtrain, ytrain, annot,
            n_rep=3, verbose=FALSE, th=0.001)
```

```
## Fitting a model with 4 groups, 400 samples and 800 features.
```

```
## Fitting with random init 1
```

```
## ELB converged
```

```
## Fitting with random init 2
```

```
## ELB converged
```

```
## Fitting with random init 3
```

```
## ELB converged
```

```
fit
```

```
## Sparse graper object for a linear regression model with 800 predictors in 4 groups.
##  Group-wise shrinkage:
##  1   2   3   4
##  0.22    0.07    8.25    7.13
## Group-wise sparsity (1 = dense, 0 = sparse):
## 1    2   3   4
## 0.06 0.14    0.04    0.1
```

# 3 Training diagnostics

The ELBO monitors the convergence during training.

```
plotELBO(fit)
```

![](data:image/png;base64...)

# 4 Posterior distribtions

The variational Bayes (VB) approach directly yields posterior
distributions for each parameter.
Note, however, that using VB these are often too concentrated
and cannot be directly used for construction of confidence intervals etc.
However, they can provide good point estimates.

```
plotPosterior(fit, "gamma", gamma0=data$gammas, range=c(0, 20))
```

![](data:image/png;base64...)

```
plotPosterior(fit, "pi", pi0=data$pis)
```

![](data:image/png;base64...)

# 5 Model coefficients and intercept

The estimated coefficients and the intercept are contained
in the result list.

```
# get coefficients (without the intercept)
beta <- coef(fit, include_intercept=FALSE)
# beta <- fit$EW_beta

# plot estimated versus true beta
qplot(beta, data$beta) +
    coord_fixed() + theme_bw()
```

```
## Warning: `qplot()` was deprecated in ggplot2 3.4.0.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
# get intercept
intercept <- fit$intercept
```

# 6 Posterior inclusion probabilities per feature

The estimated posterior inclusion probabilities per feature
are contained in the result list and can also be accessed
using `getPIPs`

```
# get estimated posterior inclusion probabilities per feature
pips <- getPIPs(fit)

# plot pips for zero versus non-zero features
df <- data.frame(pips = pips,
                nonzero = data$beta != 0)
ggplot(df, aes(x=nonzero, y=pips, col=nonzero)) +
    geom_jitter(height=0, width=0.2) +
    theme_bw() + ylab("Posterior inclusion probability")
```

![](data:image/png;base64...)

# 7 Group-wise penalites

The function `plotGroupPenalties` can be used to plot the
penalty factors and sparsity levels inferred for each
feature group.

```
plotGroupPenalties(fit)
```

![](data:image/png;base64...)

# 8 Make predictions

The function `predict` can be used to make prediction on new data.
Here, we illustrate its use by predicting the response on
the test data defined above.

```
preds <- predict(fit, Xtest)
qplot(preds, ytest) +
    coord_fixed() + theme_bw()
```

![](data:image/png;base64...)

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