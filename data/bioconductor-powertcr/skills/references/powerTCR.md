# powerTCR

Hillary Koch

#### 30 October 2025

#### Abstract

This vignette walks through the functionality of the powerTCR package for analyzing the T cell receptor repertoire. The package’s main goals are to fit models to the clone size distribution of the TCR repertoire, and to perform model-based comparative analysis of samples, following the work of Koch et al. (2018). For user simplicity, powerTCR can handle data in the formats MiTCR, MiTCR with UMIs, MiGEC, VDJtools, ImmunoSEQ (both old and new), MiXCR, and IMSEQ. If not using one of these formats, powerTCR only requires that the user be able to turn a sample TCR repertoire into a vector of clone sizes.

#### Package

powerTCR 1.30.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Summary of features](#summary-of-features)
* [2 Fitting a model](#fitting-a-model)
  + [2.1 The discrete gamma-GPD spliced threshold model](#the-discrete-gamma-gpd-spliced-threshold-model)
  + [2.2 The Type-I Pareto model](#the-type-i-pareto-model)
* [3 Density, distribution, and quantile functions, plus simulating data](#density-distribution-and-quantile-functions-plus-simulating-data)
* [4 Doing comparative analysis](#doing-comparative-analysis)
* [5 Extracting diversity estimators](#extracting-diversity-estimators)
* [6 Bootstrapping model fits](#bootstrapping-model-fits)
* [7 References](#references)
* **Appendix**

# 1 Introduction

The powerTCR package allows users to implement the model-based methods discussed in our Koch et al. (2018) paper in PLoS Computational Biology. Specifically, the clone size distribution of the T cell receptor (TCR) repertoire exhibits imperfect power law behavior; powerTCR supports a model that keeps this fact in mind. Additionally, powerTCR contains tools to fit another power law model for the TCR repertoire detailed in Desponds et al. (2016). Given a collection of sampled TCR repertoires, powerTCR equips the user with tools for comparative analysis of the samples, using one of two model-based approaches. This leads to hierarchical clustering of the samples to determine their relatedness based on the clone size distribution alone.

## 1.1 Summary of features

* Read in and parse TCR sequencing files stored in various formats into the necessary format for powerTCR
* Fit two power law-based models to the clone size distribution of the TCR repertoire
  1. The discrete gamma-GPD spliced threshold model of Koch et al. (2018)
  2. The type-I Pareto model of Desponds et al. (2016)
* Compare sample TCR repertoire samples based on model fit with hierarchical clustering
* Simulate data according from the gamma-GPD spliced threshold distribution

# 2 Fitting a model

In order to fit a model with powerTCR, you only need to be able to supply a **vector of counts** (that is, a vector of clone sizes). If your data are in a format supported by `parseFile` or `parseFolder`, you can simply read in your file using one of those functions, specify whether or not you want to use only in-frame sequences, and powerTCR will automatically give you a sorted vector of clone sizes for each sample. This functionality is a wrapper for parsing functions found in the `tcR` package.

powerTCR contains a toy data set, called `repertoires`, with two TCR repertoire samples, which we will use throughout this vignette. (In practice, you may have any number of samples.) You can load powerTCR and this data set by typing:

```
# BiocManager::install("powerTCR")
library(powerTCR)
```

`repertoires` is a list with 2 elements in it, each corresponding to a sample repertoire. Have a look:

```
str(repertoires)
```

```
## List of 2
##  $ samp1: num [1:1000] 1445 451 309 269 250 ...
##  $ samp2: num [1:800] 2781 450 447 206 157 ...
```

These samples are smaller than one might expect a TCR repertoire to be in practice, but for the sake of exploring powerTCR, they permit much faster computation.

## 2.1 The discrete gamma-GPD spliced threshold model

The main model that powerTCR focuses on is the discrete gamma-GPD spliced threshold model. This distribution has probability mass function

\[
f(x) =
\begin{cases}
(1-\phi)\frac{h(x|\boldsymbol{\theta}\_b)} {H(u-1|\boldsymbol{\theta}\_b)} & \text{for $x \leq u-1$} \\
\phi g(x|\boldsymbol{\theta}\_t, u) & \text{for $x \geq u$}
\end{cases},
\]

where \(h\) and \(H\) are the density and distribution function of a gamma distribution, and \(g\) is the density of a generalized Pareto distribution, or GPD. The gamma distribution has density

\[
h(x) = \frac{\beta^\alpha}{\Gamma(\alpha)}x^{\alpha-1}e^{-\beta x}
\]

and the GPD has density

\[
g(x) = \frac{1}{\sigma}\big(1+\xi \frac{x-u}{\sigma}\big)^{-(1/\xi +1)}.
\]

We can fit the model to each of the samples in `repertoires` using the function `fdiscgammagpd`. This function takes a few arguments. The most important are as follows:

First, `fdiscgammagpd` needs to be passed a sample TCR repertoire as a vector of counts. Second, you need to specify a grid of possible thresholds (that is, the parameter \(u\)) that you are interested in considering. One easy way to do this might be to specify a series of quantiles of the vector of counts. Finally, you also need to specify the shift, which for each sample is ideally the smallest count (at least for TCR repertoire samples). The shift is the minimum value in the support of the distribution, and for clone sizes, should never be smaller than 1.

Let’s try fitting the model to the data in `repertoires`.

```
# This will loop through our list of sample repertoires,
# and store a fit in each
fits <- list()
for(i in seq_along(repertoires)){
    # Choose a sequence of possible u for your model fit
    # Ideally, you want to search a lot of thresholds, but for quick
    # computation, we are only going to test 4
    thresholds <- unique(round(quantile(repertoires[[i]], c(.75,.8,.85,.9))))

    fits[[i]] <- fdiscgammagpd(repertoires[[i]], useq = thresholds,
                               shift = min(repertoires[[i]]))
}
names(fits) <- names(repertoires)
```

The output for a fit looks like this:

```
# You could also look at the first sample by typing fits[[1]]
fits$samp1
```

```
## $x
##    [1] 1445  451  309  269  250  220  207  194  181  181  177  150  148  142
##   [15]  141  138  116  115  110  102   99   97   91   89   87   87   86   84
##   [29]   82   80   79   74   73   71   71   69   68   68   68   67   66   64
##   [43]   64   63   62   62   62   61   61   61   61   60   59   58   58   57
##   [57]   57   56   56   55   54   54   54   54   54   53   53   53   52   52
##   [71]   52   52   51   51   50   49   49   49   48   47   46   46   46   46
##   [85]   46   46   46   46   45   45   45   44   44   44   44   44   44   44
##   [99]   44   44   43   43   42   42   42   42   42   42   42   42   41   41
##  [113]   41   41   40   40   40   40   40   39   39   38   38   38   38   38
##  [127]   37   37   37   37   37   36   36   36   36   35   35   35   35   35
##  [141]   35   35   35   35   35   35   35   35   34   34   34   34   34   34
##  [155]   34   34   34   34   34   33   33   33   33   33   33   33   33   33
##  [169]   33   33   33   33   32   32   32   32   32   32   32   32   32   32
##  [183]   32   32   32   32   32   32   32   31   31   31   31   31   31   31
##  [197]   31   31   31   31   31   31   31   31   31   31   31   31   31   31
##  [211]   30   30   30   30   30   30   30   30   30   30   30   30   30   30
##  [225]   30   29   29   29   29   29   29   29   29   29   29   29   29   28
##  [239]   28   28   28   28   28   28   28   28   28   28   28   28   28   28
##  [253]   28   28   28   28   27   27   27   27   27   27   27   27   27   27
##  [267]   27   27   27   26   26   26   26   26   26   26   26   26   26   26
##  [281]   26   26   26   26   26   26   26   26   26   25   25   25   25   25
##  [295]   25   25   25   25   25   25   25   25   25   25   25   25   25   25
##  [309]   25   25   25   25   25   25   25   25   24   24   24   24   24   24
##  [323]   24   24   24   24   24   24   24   24   24   24   24   24   24   24
##  [337]   24   24   24   24   24   24   24   24   24   24   24   24   24   24
##  [351]   23   23   23   23   23   23   23   23   23   23   23   23   23   23
##  [365]   22   22   22   22   22   22   22   22   22   22   22   22   22   22
##  [379]   22   22   22   22   22   22   22   22   22   22   22   22   22   22
##  [393]   22   22   22   22   22   22   22   22   22   22   22   21   21   21
##  [407]   21   21   21   21   21   21   21   21   21   21   21   21   21   21
##  [421]   21   21   21   21   21   21   21   21   21   21   21   21   21   21
##  [435]   21   21   21   21   21   21   21   20   20   20   20   20   20   20
##  [449]   20   20   20   20   20   20   20   20   20   20   20   20   20   20
##  [463]   20   20   20   20   20   20   20   20   20   20   20   19   19   19
##  [477]   19   19   19   19   19   19   19   19   19   19   19   19   19   19
##  [491]   19   19   19   19   19   19   19   19   19   19   19   19   19   19
##  [505]   19   19   18   18   18   18   18   18   18   18   18   18   18   18
##  [519]   18   18   18   18   18   18   18   18   18   18   18   18   18   18
##  [533]   18   18   18   18   18   18   18   18   18   18   18   18   17   17
##  [547]   17   17   17   17   17   17   17   17   17   17   17   17   17   17
##  [561]   17   17   17   17   17   17   17   17   17   17   17   17   16   16
##  [575]   16   16   16   16   16   16   16   16   16   16   16   16   16   16
##  [589]   16   16   16   16   16   16   16   16   16   16   16   16   16   16
##  [603]   16   16   16   16   16   16   16   16   16   16   16   16   16   16
##  [617]   16   16   15   15   15   15   15   15   15   15   15   15   15   15
##  [631]   15   15   15   15   15   15   15   15   15   15   15   15   15   15
##  [645]   15   15   15   15   15   15   15   15   15   15   14   14   14   14
##  [659]   14   14   14   14   14   14   14   14   14   14   14   14   14   14
##  [673]   14   14   14   14   14   14   14   14   14   14   14   14   14   14
##  [687]   14   14   14   14   14   13   13   13   13   13   13   13   13   13
##  [701]   13   13   13   13   13   13   13   13   13   13   13   13   13   13
##  [715]   13   13   13   13   13   13   13   13   13   13   13   13   13   13
##  [729]   13   12   12   12   12   12   12   12   12   12   12   12   12   12
##  [743]   12   12   12   12   12   12   12   12   12   12   12   12   12   12
##  [757]   12   12   12   12   12   12   12   12   12   11   11   11   11   11
##  [771]   11   11   11   11   11   11   11   11   11   11   11   11   11   11
##  [785]   11   11   11   11   11   11   11   11   11   11   11   11   11   11
##  [799]   11   11   11   11   11   10   10   10   10   10   10   10   10   10
##  [813]   10   10   10   10   10   10   10   10   10   10   10   10   10   10
##  [827]   10   10   10   10   10   10   10   10   10   10    9    9    9    9
##  [841]    9    9    9    9    9    9    9    9    9    9    9    9    9    9
##  [855]    9    9    9    9    9    9    9    9    9    9    9    9    9    9
##  [869]    9    9    9    9    9    9    9    9    9    9    9    9    9    9
##  [883]    8    8    8    8    8    8    8    8    8    8    8    8    8    8
##  [897]    8    8    8    8    8    8    8    8    8    8    8    8    8    7
##  [911]    7    7    7    7    7    7    7    7    7    7    7    7    7    7
##  [925]    7    7    7    7    7    7    7    6    6    6    6    6    6    6
##  [939]    6    6    6    6    6    6    6    6    6    6    6    6    6    6
##  [953]    6    6    6    6    6    6    6    5    5    5    5    5    5    5
##  [967]    5    5    5    5    5    5    5    5    4    4    4    4    4    4
##  [981]    4    4    4    4    4    4    4    4    4    4    3    3    3    3
##  [995]    3    3    3    3    2    1
##
## $shift
## [1] 1
##
## $init
## [1]  1.64606214  0.06261648 43.10000000 16.22720566  0.82244628
##
## $useq
## [1] 28 31 34 43
##
## $nllhuseq
## [1] 3987.444 3985.850 3986.335 3987.031
##
## $optim
## $optim$bulk
## $optim$bulk$par
## [1]  1.119930 -1.818451
##
## $optim$bulk$value
## [1] 2782.958
##
## $optim$bulk$counts
## function gradient
##       71       NA
##
## $optim$bulk$convergence
## [1] 0
##
## $optim$bulk$message
## NULL
##
## $optim$bulk$hessian
##           [,1]       [,2]
## [1,]  2184.494 -1396.5212
## [2,] -1396.521   992.1183
##
##
## $optim$tail
## $optim$tail$par
## [1] 2.4244657 0.7427503
##
## $optim$tail$value
## [1] 1202.892
##
## $optim$tail$counts
## function gradient
##       47       NA
##
## $optim$tail$convergence
## [1] 0
##
## $optim$tail$message
## NULL
##
## $optim$tail$hessian
##          [,1]     [,2]
## [1,] 82.54533 50.97956
## [2,] 50.97956 93.60818
##
##
##
## $nllh
## [1] 3985.85
##
## $mle
##        phi      shape       rate     thresh      sigma         xi
##  0.2100000  3.0646385  0.1622769 31.0000000 11.2961918  0.7427503
##
## $fisherInformation
##             [,1]        [,2]         [,3]         [,4]
## [1,] 0.004571856 0.006435416  0.000000000  0.000000000
## [2,] 0.006435416 0.010066536  0.000000000  0.000000000
## [3,] 0.000000000 0.000000000  0.018254313 -0.009941404
## [4,] 0.000000000 0.000000000 -0.009941404  0.016096973
```

Each value of the output is described in the `fdiscgammagpd` help file, but the most important are

* nllh: the negative log likelihood of the most likely fit, given the thresholds you’ve checked
* mle: the maximum likelihood estimates for:

\[\phi, \alpha, \beta, u, \sigma,\text{ and } \xi\text{ respectively}\]

These two important items can be grabbed using convenient accessors contained in powerTCR, called `get_mle` and `get_nllh`.

```
# Grab mles of fits:
get_mle(fits)
```

```
## $samp1
##        phi      shape       rate     thresh      sigma         xi
##  0.2100000  3.0646385  0.1622769 31.0000000 11.2961918  0.7427503
##
## $samp2
##         phi       shape        rate      thresh       sigma          xi
##  0.26750000  2.72806240  0.08797711 30.00000000  5.56272962  0.84360364
```

```
# Grab negative log likelihoods of fits
get_nllh(fits)
```

```
## $samp1
## [1] 3985.85
##
## $samp2
## [1] 3052.027
```

You can also view the likelihoods for every other threshold you checked (in nllhuseq) as well as the output from `optim` for the “bulk” (truncated gamma) and “tail” (GPD) parts of the distribution.

## 2.2 The Type-I Pareto model

For reproducibility purposes, powerTCR also provides a means to fit the model of Desponds et al. (2016). This model is investigated and discussed in Koch et al. (2018). The model follows a type-I Pareto distribution, with density:

\[
f(x) = \frac{\alpha u^\alpha}{x^{\alpha+1}}.
\]

For a given threshold \(u\), the estimate for parameter \(\alpha\) is computed directly as

\[
\alpha=n\bigg[\sum\_{i=1}^n\text{log}\frac{x\_i}{u}\bigg]^{-1}+1
\]

where \(n\) is the number of clones with size larger than \(u\). This value is computed for every possible threshold \(u\), and then the parameters that minimize the KS-statistic between empirical and theoretical distributions are chosen.

Let’s fit this model to the `repertoires` data, and have a look at the output for the first sample.

```
desponds_fits <- list()
for(i in seq_along(repertoires)){
    desponds_fits[[i]] <- fdesponds(repertoires[[i]])
}
names(desponds_fits) <- names(repertoires)
desponds_fits$samp1
```

```
##            min.KS              Cmin powerlaw.exponent      pareto.alpha
##        0.04428183       18.00000000        2.75600901        1.75600901
```

Here, min.KS is the minimum KS-statistic of all possible fits. Cmin is the threshold \(u\) that corresponds to the best fit. powerlaw.exponent and pareto.alpha are effectively the same – pareto.alpha = powerlaw.exponent-1. This is just user preference; for the Pareto density given above, pareto.alpha corresponds to the \(\alpha\) shown there. However, if the user is more familiar with a “power law” distribution, then powerlaw.exponent is the parameter they should look at.

# 3 Density, distribution, and quantile functions, plus simulating data

powerTCR provides standard functions to compute the density, distribution, and quantile functions of the discrete gamma-GPD threshold model, as well a function to simulate data. These can be very useful for tasks such as visualizing model fit and conducting a simulation study. The functions behave exactly like popularly used functions such as, say, `dnorm, pnorm, qnorm`, and `rnorm`. In order to use these functions, you need to specify all of the model parameters. The one exception is \(\phi\), which can go unspecified – details about how \(\phi\) defaults are in the help file for `ddiscgammagpd`.

Here, we will use `qdiscgammagpd` to compute quantiles from the two theoretical distributions we fit above. Note that we pass `qdiscgammagpd` the quantiles and the fits we obtained. This is just something convenient powerTCR can do if you don’t want to manually specify shift, shape, rate, u, sigma, xi, and phi. You don’t have to pass a fit, however, as you will see when we simulate data.

```
# The number of clones in each sample
n1 <- length(repertoires[[1]])
n2 <- length(repertoires[[2]])

# Grids of quantiles to check
# (you want the same number of points as were observed in the sample)
q1 <- seq(n1/(n1+1), 1/(n1+1), length.out = n1)
q2 <- seq(n2/(n2+1), 1/(n2+1), length.out = n2)

# Compute the value of fitted distributions at grid of quantiles
theor1 <- qdiscgammagpd(q1, fits[[1]])
theor2 <- qdiscgammagpd(q2, fits[[2]])
```

Now, let’s visualize the fitted and empirical distributions by plotting them together. Here, the black represents the original data, with the quantiles of the theoretical distributions plotted on top in color.

```
plot(log(repertoires[[1]]), log(seq_len(n1)), pch = 16, cex = 2,
     xlab = "log clone size", ylab = "log rank", main = "samp1")
points(log(theor1), log(seq_len(n1)), pch = 'x', col = "darkcyan")

plot(log(repertoires[[2]]), log(seq_len(n2)), pch = 16, cex = 2,
     xlab = "log clone size", ylab = "log rank", main = "samp2")
points(log(theor2), log(seq_len(n2)), pch = 'x', col = "chocolate")
```

![](data:image/png;base64...)

The fits look pretty good!

Let’s also try simulating data.

```
# Simulate 3 sampled repertoires
set.seed(123)
s1 <- rdiscgammagpd(1000, shape = 3, rate = .15, u = 25, sigma = 15,
                    xi = .5, shift = 1)
s2 <- rdiscgammagpd(1000, shape = 3.1, rate = .14, u = 26, sigma = 15,
                    xi = .6, shift = 1)
s3 <- rdiscgammagpd(1000, shape = 10, rate = .3, u = 45, sigma = 20,
                    xi = .7, shift = 1)
```

**NB:** it is possible to simulate data according to a distribution that is totally unrealistic. For example, what if you chose a very light-tailed gamma distribution and a comparatively very high threshold, but insisted (using \(\phi\)) that data be observed above the threshold? Here is what happens:

```
bad <- rdiscgammagpd(1000, shape = 1, rate = 2, u = 25, sigma = 10,
                     xi = .5, shift = 1, phi = .2)
plot(log(sort(bad, decreasing = TRUE)), log(seq_len(1000)), pch = 16,
     xlab = "log clone size", ylab = "log rank", main = "bad simulation")
```

![](data:image/png;base64...)

Fun, but not too realistic for a clone size distribution. There are several ways to go about finding reasonable parameters to simulate. One intuitive and easy technique is to let real data speak for itself – use parameters similar to those obtained by fitting a distribution to true TCR repertoire data sets.

# 4 Doing comparative analysis

Following the work in Koch et al. (2018), powerTCR provides the tools needed to perform hierarchical clustering of TCR repertoire samples according to their Jensen-Shannon distance. We can test this out on the 3 TCR repertoires we just simulated. First, we need to fit a model to them. For computational efficiency, let’s just supply the true thresholds. Then, we can use `JS_dist` to compute the Jensen-Shannon divergence between each pair of theoretical distributions corresponding to each of the TCR samples.

`JS_dist` needs to be supplied two model fits from `fdiscgammagpd` as well as a grid. The grid is important: it is the range over which each distribution gets evaluated. If you are comparing a group of TCR repertoires, the minimum value of your grid should be the smallest clone size across all samples. The upper bound of the grid should be something very large, say 100,000 or more. If you don’t select a value large enough, you will not be examining the tail of your fitted distributions sufficiently, and the tail is important! The grid should also contain every integer between its minimum and maximum. For computational efficiency, here the upper bound on our grid is only 10,000.

We’ve wrapped `JS_dist` up into a convenient function `get_distances`, which will create a symmetric matrix of distances (with 0 on the diagonal) for your use.

```
# Fit model to the data at the true thresholds
sim_fits <- list("s1" = fdiscgammagpd(s1, useq = 25),
                 "s2" = fdiscgammagpd(s2, useq = 26),
                 "s3" = fdiscgammagpd(s3, useq = 45))

# Compute the pairwise JS distance between 3 fitted models
grid <- min(c(s1,s2,s3)):10000
distances <- get_distances(sim_fits, grid, modelType="Spliced")
```

Let’s have a look at the distance matrix we just computed:

```
distances
```

```
##            s1         s2        s3
## s1 0.00000000 0.06839429 0.4488141
## s2 0.06839429 0.00000000 0.4101173
## s3 0.44881406 0.41011734 0.0000000
```

Note that `get_distances` is just calling `JS_dist` for every pair, and `JS_dist` is simply a wrapper for two functions called `JS_spliced` and `JS_desponds`. If you want to do comparative analysis for data fit using `fdesponds`, then the argument “modelType” must be changed to “Desponds”.

We can use this distance matrix to perform hierarchical clustering. This is done easily with the `clusterPlot` function. `clusterPlot` is just a wrapper for `hclust` in R’s `stats` package, and takes a matrix of Jensen-Shannon distances like the one we just made, plus a type of linkage. All possible types of linkage are listed in the help file, but we recommend using Ward’s method or complete linkage.

```
clusterPlot(distances, method = "ward.D")
```

![](data:image/png;base64...)

The clustering result is exactly what we might expect. Indeed, we simulated s1 and s2 using very similar parameter settings, so we should expect them to be more closely related to each other than to s3. That is exactly what the dendrogram displays.

# 5 Extracting diversity estimators

In Koch et al. (2018), we introduced new measures of diversity, alongise comparisons to often-used estimators of sample diversity borrowed from ecology literature. Providing a list of model fits, powerTCR can easily compute for you sample richness, Shannon entropy, clonality, and our introduced measure – the proportion of highly stimulated clones. This is done with the function `get_diversity`. Let’s demonstrate this on our fits from simulated data:

```
get_diversity(sim_fits)
```

```
##    richness  shannon  clonality prop_stim
## s1     1000 6.522356 0.05579228 0.6044665
## s2     1000 6.346489 0.08125162 0.6600013
## s3     1000 6.500144 0.05900772 0.3920100
```

# 6 Bootstrapping model fits

Finally, powerTCR allows you to run a parametric bootstrapping procedure on the discrete Gamma-GPD spliced threshold model, and can be executed in parallel if the processors are available to you. Just supply the fits you’d like to bootstrap and the number of resamples you’d like to do (and the number of cores you want to use, if running in parallel). If you want to speed up the bootstrapping by choosing a reduced number of thresholds, you can do so by changing `gridStyle`. Setting `gridStyle` to the default “copy” will just copy the original `useq` parameter in the fit. More details are in the package documentation. For each fit being bootstrapped, this returns a list of fits of length `resamples`. So, for example, if you are bootstrapping 5 fits with 1,000 resamples each, the function will return a list of length 5. Each of those lists will be length 1,000.

Here, we set the number of resamples to something very small to save computational time, but we recommend 1,000 resamples to get reasonable confidence bands.

```
boot <- get_bootstraps(fits, resamples = 5, cores = 1, gridStyle = "copy")
```

Finally, you can get confidence intervals based on your resampling. For example, this is how you can get the 95% confidence interval around the estimate for \(\xi\) from the first fit.

```
mles <- get_mle(boot[[1]])
xi_CI <- map(mles, 'xi') %>%
    unlist %>%
    quantile(c(.025,.5,.975))
xi_CI
```

```
##      2.5%       50%     97.5%
## 0.7056353 0.9194535 1.1049098
```

# 7 References

# Appendix

Desponds, J., Mora, T., & Walczak, A. M. (2016). Fluctuating fitness shapes the clone-size distribution of immune repertoires. Proceedings of the National Academy of Sciences, 113(2), 274-279.
Chicago