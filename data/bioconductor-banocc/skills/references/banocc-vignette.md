# Introduction to BAnOCC (Bayesian Analaysis Of Compositional Covariance)

Emma Schwager

#### 2025-10-29

# Contents

* [0.1 Introduction](#introduction)
* [0.2 How To Install](#how-to-install)
  + [0.2.1 From Within R](#from-within-r)
  + [0.2.2 From Bitbucket (Compressed File)](#from-bitbucket-compressed-file)
  + [0.2.3 From Bitbucket (Directly)](#from-bitbucket-directly)
* [0.3 How To Run](#how-to-run)
  + [0.3.1 Loading](#loading)
  + [0.3.2 Package Features](#package-features)
  + [0.3.3 Data and Prior Input](#data-and-prior-input)
  + [0.3.4 Sampling Control](#sampling-control)
  + [0.3.5 Output Control](#output-control)
* [0.4 Assessing Convergence](#assessing-convergence)
  + [0.4.1 Traceplots](#traceplots)
  + [0.4.2 Rhat Statistics](#rhat-statistics)
* [0.5 Choosing Priors](#choosing-priors)
  + [0.5.1 Log-Basis Precision Matrix](#log-basis-precision-matrix)
  + [0.5.2 Log-Basis Mean](#log-basis-mean)
  + [0.5.3 GLASSO Shrinkage Parameter](#glasso-shrinkage-parameter)
* [0.6 The Model](#the-model)
* [References](#references)

## 0.1 Introduction

Compositional data occur in many disciplines: geology, nutrition,
economics, and ecology, to name a few. Data are compositional when
each sample is sum-constrained. For example, mineral compositions
describe a mineral in terms of the weight percentage coming from
various elements; or taxonomic compositions break down a community by
the fraction of community memebers that come from a particular
species. In ecology in particular, the covariance between features is
often of interest to determine which species possibly interact with
each other. However, the sum constraint of compositional data makes
naive measures inappropriate.

BAnOCC is a package for analyzing compositional covariance while
accounting for the compositional structure. Briefly, the model assumes
that the unobserved counts are log-normally distributed and then
infers the correlation matrix of the log-basis (see the [The Model](#the-model)
section for a more detailed explanation). The inference is made using
No U-Turn Sampling for Hamiltonian Monte Carlo (Hoffman and Gelman [2014](#ref-HoffmanAndGelman2014))
as implemented in the `rstan` R package (Stan Development Team [2015](#ref-StanSoftware2015)[a](#ref-StanSoftware2015)).

## 0.2 How To Install

There are three options for installing BAnOCC:

* Within R
* Using compressed file from bitbucket
* Directly from bitbucket

### 0.2.1 From Within R

**This is not yet available**

### 0.2.2 From Bitbucket (Compressed File)

**This is not yet available**

### 0.2.3 From Bitbucket (Directly)

Clone the repository using `git clone`, which downloads the package as
its own directory called `banocc`.

```
git clone https://<your-user-name>@bitbucket.org/biobakery/banocc.git
```

Then, install BAnOCC’s dependencies. If these are already installed on
your machine, this step can be skipped.

```
Rscript -e "install.packages(c('rstan', 'mvtnorm', 'coda', 'stringr'))"
```

Lastly, install BAnOCC using `R CMD INSTALL`. Note that this *will
not* automatically install the dependencies, so they must be installed
first.

```
R CMD INSTALL banocc
```

## 0.3 How To Run

### 0.3.1 Loading

We first need to load the package:

```
library(banocc)
```

```
## Loading required package: rstan
```

```
## Loading required package: StanHeaders
```

```
##
## rstan version 2.32.7 (Stan version 2.32.2)
```

```
## For execution on a local, multicore CPU with excess RAM we recommend calling
## options(mc.cores = parallel::detectCores()).
## To avoid recompilation of unchanged Stan programs, we recommend calling
## rstan_options(auto_write = TRUE)
## For within-chain threading using `reduce_sum()` or `map_rect()` Stan functions,
## change `threads_per_chain` option:
## rstan_options(threads_per_chain = 1)
```

### 0.3.2 Package Features

The BAnOCC package contains four things:

* `banocc_model`, which is the BAnOCC model in the `rstan` format
* `run_banocc`, a wrapper function for `rstan::sampling` that samples
  from the model and returns a list with various useful elements
* `get_banocc_output`, which takes as input a `stanfit` object outputted by
  `run_banocc`, and outputs various statistics from the chains.
* Several test datasets which are included both as counts and as the
  corresponding compositions:

  | Dataset Description | Counts | Composition |
  | --- | --- | --- |
  | No correlations in the counts | `counts_null` | `compositions_null` |
  | No correlations in the counts | `counts_hard_null` | `compositions_hard_null` |
  | Positive corr. in the counts | `counts_pos_spike` | `compositions_pos_spike` |
  | Negative corr. in the counts | `counts_neg_spike` | `compositions_neg_spike` |

### 0.3.3 Data and Prior Input

For a full and complete description of the possible parameters for
`run_banocc` and `get_banocc_output`, their default values, and the
output, see

```
?run_banocc
?get_banocc_output
```

#### 0.3.3.1 Required Input

There are only two required inputs to `run_banocc`:

1. The dataset `C`. This is assumed to be \(N \times P\), with \(N\)
   samples and \(P\) features. The row sums are therefore required to be
   less than one for all samples.
2. The compiled stan model `compiled_banocc_model`. The compiled model is
   required so that `run_banocc` doesn’t need to waste time compiling the
   model every time it is called. To compile, use
   `rstan::stan_model(model_code=banocc::banocc_model)`.

The simplest way to run the model is to load a test dataset, compile
the model, sample from it (this gives a warning because the
default number of iterations is low), and get the output:

```
data(compositions_null)
compiled_banocc_model <- rstan::stan_model(model_code = banocc::banocc_model)
b_fit     <- banocc::run_banocc(C = compositions_null, compiled_banocc_model=compiled_banocc_model)
```

```
## Warning: There were 8 divergent transitions after warmup. See
## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
## to find out why this is a problem and how to eliminate them.
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#bulk-ess
```

```
## Warning: The largest R-hat is 1.99, indicating chains have not mixed.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#r-hat
```

```
## Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#bulk-ess
```

```
## Warning: Tail Effective Samples Size (ESS) is too low, indicating posterior variances and tail quantiles may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#tail-ess
```

```
## Warning in evaluate_convergence(b_stanfit = Fit, verbose = verbose, num_level =
## num_level + : Fit has not converged as evaluated by the Rhat statistic. You
## might try a larger number of warmup iterations, different priors, or different
## initial values. See vignette for more on evaluating convergence.
```

```
b_output <- banocc::get_banocc_output(banoccfit=b_fit)
```

```
## Warning in evaluate_convergence(b_stanfit = b_stanfit, verbose = verbose, : Fit
## has not converged as evaluated by the Rhat statistic. You might try a larger
## number of warmup iterations, different priors, or different initial values. See
## vignette for more on evaluating convergence.
```

#### 0.3.3.2 Hyperparameters

The hyperparameter values can be specified as input to
`run_banocc`. Their names correspond to the parameters in the plate
diagram figure (see section [The Model](#the-model)). For example,

```
p <- ncol(compositions_null)
b_fit_hp <- banocc::run_banocc(C = compositions_null,
                               compiled_banocc_model = compiled_banocc_model,
                               n = rep(0, p),
                               L = 10 * diag(p),
                               a = 0.5,
                               b = 0.01)
```

```
## Warning: There were 8 divergent transitions after warmup. See
## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
## to find out why this is a problem and how to eliminate them.
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#bulk-ess
```

```
## Warning: There were 2 chains where the estimated Bayesian Fraction of Missing Information was low. See
## https://mc-stan.org/misc/warnings.html#bfmi-low
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Warning: The largest R-hat is 1.83, indicating chains have not mixed.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#r-hat
```

```
## Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#bulk-ess
```

```
## Warning: Tail Effective Samples Size (ESS) is too low, indicating posterior variances and tail quantiles may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#tail-ess
```

```
## Warning in evaluate_convergence(b_stanfit = Fit, verbose = verbose, num_level =
## num_level + : Fit has not converged as evaluated by the Rhat statistic. You
## might try a larger number of warmup iterations, different priors, or different
## initial values. See vignette for more on evaluating convergence.
```

### 0.3.4 Sampling Control

There are several options to control the behavior of the HMC sampler
within `run_banocc`. This is simply a call to `rstan::sampling`, and
so many of the parameters are the same.

#### 0.3.4.1 General Sampling Control

The number of chains, iterations, and warmup iterations as well as the
rate of thinning for `run_banocc` can be specified using the same
parameters as for `rstan::sampling` and `rstan::stan`. For example,
the following code gives a total of three iterations from each of two
chains. These parameters are used only for brevity and are NOT
recommended in practice.

```
b_fit_sampling <- banocc::run_banocc(C = compositions_null,
                                     compiled_banocc_model = compiled_banocc_model,
                                     chains = 2,
                                     iter = 11,
                                     warmup = 5,
                                     thin = 2)
```

```
## Warning: There were 4 divergent transitions after warmup. See
## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
## to find out why this is a problem and how to eliminate them.
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Warning: There were 6 divergent transitions after warmup. See
## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
## to find out why this is a problem and how to eliminate them.
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Warning in evaluate_convergence(b_stanfit = Fit, verbose = verbose, num_level =
## num_level + : Fit has not converged as evaluated by the Rhat statistic. You
## might try a larger number of warmup iterations, different priors, or different
## initial values. See vignette for more on evaluating convergence.
```

#### 0.3.4.2 Number of Cores

The number of cores used for sampling on a multi-processor machine can
also be specified, which allows chains to run in parallel and
therefore decreases computation time. Since its purpose is running
chains in parallel, computation time will decrease as cores are added
up to when the number of cores and the number of chains are equal.

```
# This code is not run
b_fit_cores <- banocc::run_banocc(C = compositions_null,
                                  compiled_banocc_model = compiled_banocc_model,
                                  chains = 2,
                                  cores = 2)
```

#### 0.3.4.3 Initial Values

By default, the initial values for **\(m\)** and \(\lambda\) are sampled
from the priors and the initial values for **\(O\)** are set to the
identity matrix of dimension \(P\). Setting the initial values for
**\(O\)** to the identity helps ensure a parsimonious model fit. The
initial values can also be set to a particular value by using a list
whose length is the number of chains and whose elements are lists of
initial values for each parameter:

```
init <- list(list(m = rep(0, p),
                  O = diag(p),
                  lambda = 0.02),
             list(m = runif(p),
                  O = 10 * diag(p),
                  lambda = runif(1, 0.1, 2)))
b_fit_init <- banocc::run_banocc(C = compositions_null,
                                 compiled_banocc_model = compiled_banocc_model,
                                 chains = 2,
                                 init = init)
```

```
## Warning: There were 1 chains where the estimated Bayesian Fraction of Missing Information was low. See
## https://mc-stan.org/misc/warnings.html#bfmi-low
```

```
## Warning: Examine the pairs() plot to diagnose sampling problems
```

```
## Warning: The largest R-hat is 1.53, indicating chains have not mixed.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#r-hat
```

```
## Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#bulk-ess
```

```
## Warning: Tail Effective Samples Size (ESS) is too low, indicating posterior variances and tail quantiles may be unreliable.
## Running the chains for more iterations may help. See
## https://mc-stan.org/misc/warnings.html#tail-ess
```

```
## Warning in evaluate_convergence(b_stanfit = Fit, verbose = verbose, num_level =
## num_level + : Fit has not converged as evaluated by the Rhat statistic. You
## might try a larger number of warmup iterations, different priors, or different
## initial values. See vignette for more on evaluating convergence.
```

More specific control of the sampler’s behavior comes from the
`control` argument to `rstan::sampling`. Details about this argument
can be found in the help for the `rstan::stan` function:

```
?stan
```

### 0.3.5 Output Control

There are several parameters that control the type of output which is
returned by `get_banocc_output`.

#### 0.3.5.1 Credible Interval Width

The width of the returned credible intervals is controlled by
`conf_alpha`. A \(100\% \* (1-\alpha\_\text{conf})\) credible interval is
returned:

```
# Get 90% credible intervals
b_out_90 <- banocc::get_banocc_output(banoccfit=b_fit,
                                      conf_alpha = 0.1)
```

```
## Warning in evaluate_convergence(b_stanfit = b_stanfit, verbose = verbose, : Fit
## has not converged as evaluated by the Rhat statistic. You might try a larger
## number of warmup iterations, different priors, or different initial values. See
## vignette for more on evaluating convergence.
```

```
# Get 99% credible intervals
b_out_99 <- banocc::get_banocc_output(banoccfit=b_fit,
                                      conf_alpha = 0.01)
```

```
## Warning in evaluate_convergence(b_stanfit = b_stanfit, verbose = verbose, : Fit
## has not converged as evaluated by the Rhat statistic. You might try a larger
## number of warmup iterations, different priors, or different initial values. See
## vignette for more on evaluating convergence.
```

#### 0.3.5.2 Checking Convergence

Convergence is evaluated automatically, and in this case the credible
intervals, estimates, and any additional output in section [Additional
Output](#additional-output) is missing. This behavior can be turned off using the
`eval_convergence` option. But be careful!

```
# Default is to evaluate convergence
b_out_ec <- banocc::get_banocc_output(banoccfit=b_fit)
```

```
## Warning in evaluate_convergence(b_stanfit = b_stanfit, verbose = verbose, : Fit
## has not converged as evaluated by the Rhat statistic. You might try a larger
## number of warmup iterations, different priors, or different initial values. See
## vignette for more on evaluating convergence.
```

```
# This can be turned off using `eval_convergence`
b_out_nec <- banocc::get_banocc_output(banoccfit=b_fit,
                                       eval_convergence = FALSE)
```

```
# Iterations are too few, so estimates are missing
b_out_ec$Estimates.median
```

```
##       f_n_1 f_n_2 f_n_3 f_n_4 f_n_5 f_n_6 f_n_7 f_n_8 f_n_9
## f_n_1    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_2    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_3    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_4    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_5    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_6    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_7    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_8    NA    NA    NA    NA    NA    NA    NA    NA    NA
## f_n_9    NA    NA    NA    NA    NA    NA    NA    NA    NA
```

```
# Convergence was not evaluated, so estimates are not missing
b_out_nec$Estimates.median
```

```
##               f_n_1         f_n_2        f_n_3        f_n_4        f_n_5
## f_n_1  1.0000000000 -0.0082871337  0.013772332  0.043336695 -0.011568493
## f_n_2 -0.0082871337  1.0000000000  0.007867136  0.017513363 -0.007587673
## f_n_3  0.0137723317  0.0078671356  1.000000000 -0.009817529  0.055469692
## f_n_4  0.0433366951  0.0175133632 -0.009817529  1.000000000 -0.010910615
## f_n_5 -0.0115684933 -0.0075876734  0.055469692 -0.010910615  1.000000000
## f_n_6  0.0136750702 -0.0001835662  0.007212641 -0.020751530 -0.013805103
## f_n_7  0.0112368340  0.0574192592  0.011999832 -0.012184843  0.012482492
## f_n_8  0.0004113341 -0.0081485193 -0.017843098 -0.005232320  0.016199155
## f_n_9 -0.0045998588  0.0035521902  0.020684210  0.043794943 -0.017508955
##               f_n_6        f_n_7         f_n_8        f_n_9
## f_n_1  0.0136750702  0.011236834  0.0004113341 -0.004599859
## f_n_2 -0.0001835662  0.057419259 -0.0081485193  0.003552190
## f_n_3  0.0072126407  0.011999832 -0.0178430977  0.020684210
## f_n_4 -0.0207515297 -0.012184843 -0.0052323199  0.043794943
## f_n_5 -0.0138051027  0.012482492  0.0161991549 -0.017508955
## f_n_6  1.0000000000  0.006365137  0.0079006808 -0.010840372
## f_n_7  0.0063651369  1.000000000 -0.0562813985 -0.006340487
## f_n_8  0.0079006808 -0.056281398  1.0000000000  0.004674130
## f_n_9 -0.0108403720 -0.006340487  0.0046741297  1.000000000
```

#### 0.3.5.3 Additional Output

Two types of output can be requested for each correlation that are not
included by default:

1. The smallest credible interval width that includes zero
2. The scaled neighborhood criterion, or SNC (Li and Lin [2010](#ref-LiAndLin2010))

```
# Get the smallest credible interval width that includes zero
b_out_min_width <- banocc::get_banocc_output(banoccfit=b_fit,
                                             get_min_width = TRUE)
```

```
## Warning in evaluate_convergence(b_stanfit = b_stanfit, verbose = verbose, : Fit
## has not converged as evaluated by the Rhat statistic. You might try a larger
## number of warmup iterations, different priors, or different initial values. See
## vignette for more on evaluating convergence.
```

```
# Get the scaled neighborhood criterion
b_out_snc <- banocc::get_banocc_output(banoccfit=b_fit,
                                       calc_snc = TRUE)
```

```
## Warning in evaluate_convergence(b_stanfit = b_stanfit, verbose = verbose, : Fit
## has not converged as evaluated by the Rhat statistic. You might try a larger
## number of warmup iterations, different priors, or different initial values. See
## vignette for more on evaluating convergence.
```

Detailed statements about the function’s execution can also be printed
using the `verbose` argument. The relative indentation of the verbose
output indicates the nesting level of the function. The starting
indentation can be set with `num_level`.

## 0.4 Assessing Convergence

There are many ways of assessing convergence, but the two most easily
implemented using BAnOCC are:

1. Traceplots of parameters, which show visually what values of a
   parameter have been sampled across all iterations. At convergence, the
   sampler should be moving rapidly across the space, and the chains
   should overlap well. In other words, it should look like grass.
2. The Rhat statistic (Gelman and Rubin [1992](#ref-GelmanAndRubin1992)), which measures agreement
   between all the chains. It should be close to one at convergence.

### 0.4.1 Traceplots

Traceplots can be directly accessed using the `traceplot` function in
the `rstan` package, which creates a `ggplot2` object that can be
further maniuplated to ‘prettify’ the plot. The traceplots so
generated are for the samples drawn *after* the warmup period. For
example, we could plot the traceplots for the inverse covariances of
feature 1 with all other features. There is overlap between some of
the chains, but not all and so we conclude that we need more samples
from the posterior to be confident of convergence.

```
# The inverse covariances of feature 1 with all other features
rstan::traceplot(b_fit$Fit, pars=paste0("O[1,", 2:9, "]"))
```

![](data:image/png;base64...)

We could also see the warmup period samples by using
`inc_warmup=TRUE`. This shows that some of the chains have moved from
very different starting points to a similar distribution, which is a
good sign of convergence.

```
# The inverse covariances of feature 1 with all other features, including warmup
rstan::traceplot(b_fit$Fit, pars=paste0("O[1,", 2:9, "]"),
                 inc_warmup=TRUE)
```

![](data:image/png;base64...)

### 0.4.2 Rhat Statistics

The Rhat values can also be directly accessed using the `summary`
function in the `rstan` package. It measures the degree of agreement
between all the chains. At convergence, the Rhat statistics should be
approximately one for all parameters. For example, the Rhat values for
the correlation between feature 1 and all other features (the same as
those plotted above), agree with the traceplots that convergence has
not yet been reached.

```
# This returns a named vector with the Rhat values for all parameters
rhat_all <- rstan::summary(b_fit$Fit)$summary[, "Rhat"]

# To see the Rhat values for the inverse covariances of feature 1
rhat_all[paste0("O[1,", 2:9, "]")]
```

```
##    O[1,2]    O[1,3]    O[1,4]    O[1,5]    O[1,6]    O[1,7]    O[1,8]    O[1,9]
## 1.0434690 1.0403352 0.9919290 0.9982499 1.0189030 1.0206470 1.0366288 0.9853598
```

## 0.5 Choosing Priors

The hyperparameters for the model (see section [The Model](#the-model)) need to be
chosen appropriately.

### 0.5.1 Log-Basis Precision Matrix

The prior on the precision matrix **\(O\)** is a GLASSO prior from
(Wang [2012](#ref-Wang2012)) with parameter \(\lambda\) [see also section [The
Model](#the-model)]. As \(\lambda\) decreases, the degree of shrinkage
correspondingly increases.

![](data:image/png;base64...)

lambda behavior

### 0.5.2 Log-Basis Mean

We recommend using an uninformative prior for the log-basis mean:
centered at zero and with large variance.

### 0.5.3 GLASSO Shrinkage Parameter

We recommend using a prior with large probability mass close to zero;
because \(\lambda\) has a gamma prior, this means that the shape
parameter \(a\) should be less than one. The rate parameter \(b\)
determines the variability; in cases with either small (order of 10)
or very large (\(p > n\)) numbers of features \(b\) should be large so
that the variance of the gamma distribution, \(a / b^2\), is
small. Otherwise, a small value of \(b\) will make the prior more
uninformative.

## 0.6 The Model

A pictoral representation of the model is shown below. Briefly, the
basis (or unobserved, unrestricted counts) for each sample is assumed
to be a lognormal distribution with parameters **\(m\)** and
**\(S\)**. The prior on **\(m\)** is a normal distribution parametrized by
mean **\(n\)** and variance-covariance matrix **\(L\)**. Since we are
using a graphical LASSO prior, we parametrize the model with precision
matrix **\(O\)**. The prior on **\(O\)** is a graphical LASSO prior
(Wang [2012](#ref-Wang2012)) with shrinkage parameter \(\lambda\). To circumvent the
necessity of choosing \(\lambda\), a gamma hyperprior is placed on
\(\lambda\), with parameters \(a\) and \(b\).

![](data:image/png;base64...)

plate-diagram

If we print the model, we can actually see the code. It is written in
the format required by the `rstan` package, since `banocc` uses this
package to sample from the model. See (Stan Development Team [2015](#ref-StanManual2015)[b](#ref-StanManual2015)) for more
detailed information on this format.

```
# This code is not run
cat(banocc::banocc_model)
```

## References

Gelman, Andrew, and Donald B. Rubin. 1992. “Inference from Iterative Simulation Using Multiple Sequences.” *Statistical Science* 7 (4): 457–72. <http://dx.doi.org/10.2307/2246093>.

Hoffman, Matthew D., and Andrew Gelman. 2014. “The No-U-Turn Sampler: Adaptively Setting Path Lengths in Hamiltonian Monte Carlo.” *J. Mach. Learn. Res.* 15 (1): 1593–1623. <http://dl.acm.org/citation.cfm?id=2627435.2638586>.

Li, Qing, and Nan Lin. 2010. “The Bayesian Elastic Net.” *Bayesian Anal.* 5 (1): 151–70. <http://dx.doi.org/10.1214/10-BA506>.

Stan Development Team. 2015a. “Stan: A C++ Library for Probability and Sampling, Version 2.10.0.” <http://mc-stan.org/>.

———. 2015b. *Stan Modeling Language Users Guide and Reference Manual, Version 2.10.0*. <http://mc-stan.org/>.

Wang, Hao. 2012. “Bayesian Graphical Lasso Models and Efficient Posterior Computation.” *Bayesian Anal.* 7 (4): 867–86. <https://doi.org/10.1214/12-BA729>.