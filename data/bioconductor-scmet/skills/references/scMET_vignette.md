# scMET Bayesian modelling of DNA methylation heterogeneity at single-cell resolution

Andreas C. Kapourani1,2,3\*, Ricard Argelaguet4\*\*, Guido Sanguinetti3,5\*\*\* and Catalina Vallejos1,2\*\*\*\*

1Human Genetic Unit (HGU), University of Edinburgh, UK
2Institute of Genetics and Cancer (IGC), University of Edinburgh, UK
3School of Informatics, University of Edinburgh, UK
4European Bioinformatics Institute (EMBL-EBI), Hinxton, UK
5SISSA, International School of Advanced Studies, Trieste, Italy

\*c.a.kapourani@ed.ac.uk or kapouranis.andreas@gmail.com
\*\*ricard@ebi.ac.uk
\*\*\*gsanguin@sissa.it
\*\*\*\*catalina.vallejos@ed.ac.uk

#### 2025-10-30

#### Package

scMET 1.12.0

# 1 Introduction

High throughput measurements of DNA methylomes at single-cell resolution are a promising resource to quantify the heterogeneity of DNA methylation and uncover its role in gene regulation. However, limitations of the technology result in sparse CpG coverage, effectively posing challenges to robustly quantify genuine DNA methylation heterogeneity. Here we introduce **scMET**, a Bayesian framework for the analysis of single-cell DNA methylation data. This modelling approach combines a hierarchical beta-binomial specification with a generalised linear model framework with the aim of capturing biological overdispersion and overcome data sparsity by sharing information across cells and genomic features.

To disentangle technical from biological variability and overcome data sparsity, scMET couples a hierarchical BB model with a GLM framework (Fig.[1](#fig:scmet)a-b). For each cell \(i\) and region \(j\), the input for scMET is the number of CpG sites that are observed to be methylated (\(Y\_{ij}\)) and the total number of sites for which methylation status was recorded (\(n\_{ij}\)). The BB model uses feature-specific mean parameters \(\mu\_j\) to quantify overall DNAm across all cells and biological *overdispersion* parameters \(\gamma\_j\) as a proxy for cell-to-cell DNAm heterogeneity. These parameters capture the amount of variability that is not explained by binomial sampling noise, which would only account for technical variation.

The GLM framework is incorporated at two levels. Firstly, to introduce feature-specific covariates \(\mathbf{x}\_{j}\) (e.g. CpG density) that may explain differences in mean methylation \(\mu\_j\) across features. Secondly, similar to [Eling2018](https://pubmed.ncbi.nlm.nih.gov/30172840/), we use a non-linear regression framework to capture the mean-overdispersion trend that is typically observed in high throughput sequencing data, such as scBS-seq (Fig.[1](#fig:scmet)c). This trend is used to derive *residual overdispersion* parameters \(\epsilon\_j\) — a measure of cell-to-cell variability that is not confounded by mean methylation. Feature-specific parameters are subsequently used for: (i) feature selection, to identify highly variable features (HVFs) that drive cell-to-cell epigenetic heterogeneity (Fig.[1](#fig:scmet)d) and (ii) differential methylation testing, to highlight features that show differences in DNAm mean or variability between specified groups of cells (Fig.[1](#fig:scmet)e).

![`scMET` model overview.](data:image/png;base64...)

Figure 1: `scMET` model overview.

# 2 Installation

```
# Install stable version from Bioconductor
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("scMET")

## Or development version from Github
# install.packages("remotes")
remotes::install_github("andreaskapou/scMET")
```

# 3 scMET analysis on synthetic data

To highlight the main functionality of `scMET` we first apply it on synthetic data, where we can assess the accuracy of the inferred parameters (\(\mu\) and \(\gamma\)) as well as compare it with the maximum likelihood estimation of simple beta-binomial (BB-MLE) model.

```
# Load package
suppressPackageStartupMessages(library(scMET))
suppressPackageStartupMessages(library(data.table))
set.seed(123)
```

## 3.1 Loading synthetic data

scMET comes with simulated scBS-seq data from a single population. The users can generate their own synthetic data using the `scmet_simulate` function. **NOTE** For interoperability of scMET and `SingleCellExperiment` objects see last section of this vignette.

```
# Synthetic data: list with following elements
names(scmet_dt)
```

```
## [1] "Y"                 "X"                 "theta_true"
## [4] "theta_priors_true" "opts"
```

Here, `Y` is a `data.table` containing the scBS-seq data in long format, where `total_reads` corresponds to the total number of covered CpGs \(n\_{ij}\) and `met_reads` to number of methylated CpGs \(Y\_{ij}\) in cell \(i\) and feature \(j\) (see Fig.[1](#fig:scmet)). This is the data **format** that scMET requires as input.

```
head(scmet_dt$Y)
```

```
##      Feature    Cell total_reads met_reads
##       <char>  <char>       <int>     <num>
## 1: Feature_1 Cell_13          14         9
## 2: Feature_1 Cell_21           9         9
## 3: Feature_1 Cell_11          10         8
## 4: Feature_1 Cell_50          10         1
## 5: Feature_1 Cell_44          11         6
## 6: Feature_1 Cell_14          12         8
```

Next, `X` is a matrix containing the feature-specific covariates that might explain differences in mean methylation. The first column of X is the bias term and contains a vector of 1s. This is an **optional** input when performing inference using scMET.

```
head(scmet_dt$X)
```

```
##             intercept cpg_density
## Feature_1           1 -0.77132814
## Feature_10          1  0.30623073
## Feature_100         1 -1.46447533
## Feature_101         1 -1.05901022
## Feature_102         1  0.96694264
## Feature_103         1  0.06700105
```

The `theta_true` element just contains the true \(\mu\) and \(\gamma\) parameters used to generate the scBS-seq data `Y`. We will use these to assess our prediction performance later. Finally the `theta_priors_true` contains the prior hyper-parameters which we defined to generate the synthetic data (top level parameters in Fig.[1](#fig:scmet)).

```
# Parameters \mu and \gamma
head(scmet_dt$theta_true)
```

```
##                    mu     gamma
## Feature_1   0.6201633 0.2953617
## Feature_10  0.3066003 0.3630327
## Feature_100 0.8417903 0.1483870
## Feature_101 0.9307007 0.1619025
## Feature_102 0.1089840 0.2645526
## Feature_103 0.4856963 0.3154443
```

```
# Hyper-paramter values
scmet_dt$theta_priors_true
```

```
## $w_mu
## [1] -0.5 -1.5
##
## $w_gamma
## [1] -1.2 -0.3  1.1 -0.9
##
## $s_mu
## [1] 1
##
## $s_gamma
## [1] 0.2
```

Now let’s visualise how the mean-overdispersion trend looks like in our synthetic data and also the association between mean methylation and covariates `X`, which here we will assume is CpG density.

```
par(mfrow = c(1,2))
plot(scmet_dt$theta_true$mu, scmet_dt$theta_true$gamma, pch = 20,
     xlab = expression(paste("Mean methylation ",  mu)),
     ylab = expression(paste("Overdsispersion ",  gamma)))
plot(scmet_dt$X[,2], scmet_dt$theta_true$mu, pch = 20,
     xlab = "X: CpG density",
     ylab = expression(paste("Mean methylation ",  mu)))
```

![](data:image/png;base64...)

## 3.2 scMET inference

Now we can perform inference on the simulated data using the `scmet` function. In addition to providing the input data `Y` and covariates `X`, we set `L = 4` radial basis functions to model the mean-overdispersion relationship. Also, we set the total number of VB iterations to `iter = 500` for efficiency purposes (hence the model will most probably not converge and which can be seen by the fitted lines being further away than expected). We let all the other parameters as default.

**NOTE 1** The user should set this to a much higher value, e.g. around 20,000 when running VB so the model converges.

**NOTE 2** For relatively small datasets we recommend using the MCMC implementation of scMET, i.e. setting `use_mcmc = TRUE`, since it is more stable than the VB approximation and gives more accurate results.

```
# Run with seed for reproducibility
fit_obj <- scmet(Y = scmet_dt$Y, X = scmet_dt$X, L = 4,
                 iter = 1000, seed = 12)
```

```
## Chain 1: ------------------------------------------------------------
## Chain 1: EXPERIMENTAL ALGORITHM:
## Chain 1:   This procedure has not been thoroughly tested and may be unstable
## Chain 1:   or buggy. The interface is subject to change.
## Chain 1: ------------------------------------------------------------
## Chain 1:
## Chain 1:
## Chain 1:
## Chain 1: Gradient evaluation took 0.001348 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 13.48 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1:
## Chain 1:
## Chain 1: Begin eta adaptation.
## Chain 1: Iteration:   1 / 250 [  0%]  (Adaptation)
## Chain 1: Iteration:  50 / 250 [ 20%]  (Adaptation)
## Chain 1: Iteration: 100 / 250 [ 40%]  (Adaptation)
## Chain 1: Iteration: 150 / 250 [ 60%]  (Adaptation)
## Chain 1: Iteration: 200 / 250 [ 80%]  (Adaptation)
## Chain 1: Success! Found best value [eta = 1] earlier than expected.
## Chain 1:
## Chain 1: Begin stochastic gradient ascent.
## Chain 1:   iter             ELBO   delta_ELBO_mean   delta_ELBO_med   notes
## Chain 1:    100        -8816.448             1.000            1.000
## Chain 1:    200        -8185.937             0.539            1.000
## Chain 1:    300        -8119.809             0.043            0.077
## Chain 1:    400        -8024.891             0.010            0.012
## Chain 1:    500        -8012.193             0.007            0.012
## Chain 1:    600        -7966.628             0.004            0.006
## Chain 1:    700        -7987.345             0.004            0.006
## Chain 1:    800        -7972.263             0.002            0.003
## Chain 1:    900        -7952.611             0.002            0.002
## Chain 1:   1000        -7997.019             0.004            0.006
## Chain 1: Informational Message: The maximum number of iterations is reached! The algorithm may not have converged.
## Chain 1: This variational approximation is not guaranteed to be meaningful.
## Chain 1:
## Chain 1: Drawing a sample of size 2000 from the approximate posterior...
## Chain 1: COMPLETED.
```

### 3.2.1 Output summary

The `scmet` returns a `scmet_<mode>` object (mode either `vb` or `mcmc`) with the following structure:

```
class(fit_obj)
```

```
## [1] "scmet_vb"
```

```
names(fit_obj)
```

```
## [1] "posterior"     "Y"             "X"             "feature_names"
## [5] "theta_priors"  "opts"
```

Here the most important entry is the `posterior` entry, which is a list containing the posterior draws for each of the model parameters. All other elements contain the input data and initialised hyper-parameter values for reproducibility purposes.

```
# Elements of the posterior list
names(fit_obj$posterior)
```

```
## [1] "mu"      "gamma"   "epsilon" "w_mu"    "w_gamma" "s_gamma" "lp__"
```

```
# Rows correspond to draws and columns to parameter dimensions
# here number of features.
dim(fit_obj$posterior$mu)
```

```
## [1] 2000  150
```

```
# First 5 draws across 3 features for \mu parameter
fit_obj$posterior$mu[1:5, 1:3]
```

```
##
## iterations Feature_1 Feature_10 Feature_100
##       [1,]     0.580      0.289       0.686
##       [2,]     0.514      0.347       0.767
##       [3,]     0.615      0.302       0.749
##       [4,]     0.514      0.409       0.834
##       [5,]     0.501      0.265       0.749
```

```
# First 5 draws across 3 features for \gamma parameter
fit_obj$posterior$gamma[1:5, 1:3]
```

```
##
## iterations Feature_1 Feature_10 Feature_100
##       [1,]     0.315      0.372       0.359
##       [2,]     0.288      0.410       0.201
##       [3,]     0.110      0.130       0.141
##       [4,]     0.114      0.408       0.247
##       [5,]     0.216      0.179       0.208
```

```
# First 5 draws for covariate coefficients
# number of columns equal to ncol(X) = 2
fit_obj$posterior$w_mu[1:5, ]
```

```
##
## iterations intercept cpg_density
##       [1,]    -0.482      -1.536
##       [2,]    -0.419      -1.836
##       [3,]    -0.303      -1.739
##       [4,]    -0.702      -1.745
##       [5,]    -0.359      -1.790
```

```
# First 5 draws for RBF coefficients
# number of columns equal to L = 4
fit_obj$posterior$w_gamma[1:5, ]
```

```
##
## iterations   rbf1  rbf2  rbf3   rbf4
##       [1,] -1.728 0.734 0.858  0.132
##       [2,] -1.824 0.770 0.995  0.103
##       [3,] -1.841 0.884 0.966  0.031
##       [4,] -1.805 0.812 1.028  0.348
##       [5,] -1.857 0.714 0.930 -0.009
```

## 3.3 Plotting mean-overdispersion relationship

Next we plot the posterior median parameter estimates of \(\mu\) and \(\gamma\) together with the fitted non-linear trend. The color code is used to represent areas with high (green and yellow) and low (blue) concentration of features via kernel density estimation. Mostly useful when visualising datasets with large number of features.

```
gg1 <- scmet_plot_mean_var(obj = fit_obj, y = "gamma",
                           task = NULL, show_fit = TRUE)
gg2 <- scmet_plot_mean_var(obj = fit_obj, y = "epsilon",
                           task = NULL, show_fit = TRUE)
cowplot::plot_grid(gg1, gg2, ncol = 2)
```

![](data:image/png;base64...)

As expected we observe no association between the mean - residual overdisperion relatioship.

## 3.4 Comparing true versus estimated parameters

Next we assess the predictive performance of scMET by comparing the posterior estimates with the true parameter values used to generate the synthetic data.

```
# Mean methylation estimates
gg1 <- scmet_plot_estimated_vs_true(obj = fit_obj, sim_dt = scmet_dt,
                                    param = "mu")
# Overdispersion estimates
gg2 <- scmet_plot_estimated_vs_true(obj = fit_obj, sim_dt = scmet_dt,
                                    param = "gamma")
cowplot::plot_grid(gg1, gg2, ncol = 2)
```

![](data:image/png;base64...)

### 3.4.1 scMET versus beta-binomial MLE (shrinkage)

Below we assess the predictive performance of scMET compared to the maximum likelihood estimates from a beta-binomial model. First we obtain MLE estimates:

```
# Obtain MLE estimates by calling the bb_mle function
bbmle_fit <- scmet_dt$Y[, bb_mle(cbind(total_reads, met_reads)),
                        by = c("Feature")]
bbmle_fit <- bbmle_fit[, c("Feature", "mu", "gamma")]
head(bbmle_fit)
```

```
##        Feature         mu        gamma
##         <char>      <num>        <num>
## 1:   Feature_1 0.62682041 1.800892e-01
## 2:  Feature_10 0.25923353 2.530192e-01
## 3: Feature_100 0.83186860 2.486058e-01
## 4: Feature_101 0.95475110 1.043350e-06
## 5: Feature_102 0.08642232 1.352157e-01
## 6: Feature_103 0.47120018 2.669786e-01
```

As we can see, scMET can more accurately estimate the overdispersion parameter \(\gamma\) by shrinking the MLE estimates towards to population average, resulting in more robust estimates.

```
# Overdispersion estimates MLE vs scMET
# subset of features to avoid over-plotting
scmet_plot_estimated_vs_true(obj = fit_obj, sim_dt = scmet_dt,
                             param = "gamma", mle_fit = bbmle_fit)
```

![](data:image/png;base64...)

The above sections mostly focused on assessing the prediction performance of scMET. Below we show how the user can use scMET for downstream analyses, such as feature selection and differential methylation testing.

## 3.5 Identifying highly variable features

After fitting the scMET model, we now show how to perform feature selection; that is to identify highly variable features (HVF) which potentially drive cell-to-cell DNA methylation heterogeneity. We will identify HVFs based on the residual overdispersion estimates \(\epsilon\) (This is the default and recommended approach of scMET. The user can also perform HVF analysis based on the overdispersion parameter \(\gamma\), which however will be confounded by the mean methylation levels).

We can perform HVF analysis simply by calling the `scmet_hvf` function. This will create a new list named `hvf` within the `fit_obj` object.

```
# Run HVF analysis
fit_obj <- scmet_hvf(scmet_obj = fit_obj, delta_e = 0.75,
                     evidence_thresh = 0.8, efdr = 0.1)
```

```
## 6 Features classified as highly variable using:
## - The  75 percentile of variable genes
## - Evidence threshold = 0.80275
## - EFDR = 10.3%
## - EFNR = 25.8%
```

```
# Summary of HVF analysis
head(fit_obj$hvf$summary)
```

```
##             feature_name    mu  gamma epsilon tail_prob is_variable
## Feature_8      Feature_8 0.075 0.3800   0.543    0.9760        TRUE
## Feature_112  Feature_112 0.149 0.5340   0.924    0.9740        TRUE
## Feature_146  Feature_146 0.028 0.3235   0.460    0.9470        TRUE
## Feature_128  Feature_128 0.091 0.3460   0.339    0.8565        TRUE
## Feature_49    Feature_49 0.385 0.4855   0.224    0.8200        TRUE
## Feature_136  Feature_136 0.162 0.3745   0.238    0.8085        TRUE
```

Here the `tail_prob` column denotes the evidence our model provides of a feature being called as HVF (the higher the larger the evidence), and the `is_variable` column denotes the output whether the feature was called as HVF or not.

Below we show the grid search to obtain the optimal posterior evidence threshold to achieve EFDR = 10%.

```
scmet_plot_efdr_efnr_grid(obj = fit_obj, task = "hvf")
```

![](data:image/png;base64...)

Next we can also plot the corresponding **tail posterior probabilities** as a function of \(\mu\) and plot the mean - overdispersion relationship coloured by the HVF analysis.

```
gg1 <- scmet_plot_vf_tail_prob(obj = fit_obj, x = "mu", task = "hvf")
gg2 <- scmet_plot_mean_var(obj = fit_obj, y = "gamma", task = "hvf")
cowplot::plot_grid(gg1, gg2, ncol = 2)
```

![](data:image/png;base64...)

**NOTE** One could perform the exact analysis for identifying lowly variable features (LVFs), although in general these are less useful for downstream analysis, such as clustering, since they denote regulatory regions that have stable DNAm patterns across cells.

## 3.6 Differential analysis with scMET

scMET has additional functionality for calling differentially methylated (**DM**) and differentially variable (**DV**) features when analysing cells from two conditions/populations.

To perform differential testing, scMET contains simulated data from two conditions/groups of cells, where a subset of features are DM and some others are DV between groups **A** and **B**. The user can generate their own synthetic data using the `scmet_simulate_diff` function. Below we show the structure of the `scmet_diff_dt` object.

```
# Structure of simulated data from two populations
names(scmet_diff_dt)
```

```
## [1] "scmet_dt_A"              "scmet_dt_B"
## [3] "opts"                    "diff_var_features"
## [5] "diff_var_features_up"    "diff_var_features_down"
## [7] "diff_mean_features"      "diff_mean_features_up"
## [9] "diff_mean_features_down"
```

Below we plot the mean-overdispersion relationship of the *true* parameters for each group, and highlight with red colour the features that are truly **differentially variable** in group B compared to group A.

```
# Extract DV features
dv <- scmet_diff_dt$diff_var_features$feature_idx
# Parameters for each group
theta_A <- scmet_diff_dt$scmet_dt_A$theta_true
theta_B <- scmet_diff_dt$scmet_dt_B$theta_true

par(mfrow = c(1,2))
# Group A mean - overdispersion relationship
plot(theta_A$mu, theta_A$gamma, pch = 20, main = "Group A",
     xlab = expression(paste("Mean methylation ",  mu)),
     ylab = expression(paste("Overdsispersion ",  gamma)))
points(theta_A$mu[dv], theta_A$gamma[dv], col = "red", pch = 20)

# Group B mean - overdispersion relationship
plot(theta_B$mu, theta_B$gamma, pch = 20, main = "Group B",
     xlab = expression(paste("Mean methylation ",  mu)),
     ylab = expression(paste("Overdsispersion ",  gamma)))
points(theta_B$mu[dv], theta_B$gamma[dv], col = "red", pch = 20)
```

![](data:image/png;base64...)

The `scmet_dt_A` and `scmet_dt_B` are the two simulated datasets, having the same structure as the `scmet_dt` object in the above sections. The additional elements contain information about which features are DM or DV across populations.

### 3.6.1 Fitting scMET for each group

To perform differential analysis, we first need to run the `scmet` function on each dataset/group independently.

**NOTE 1** The user should set this to a much higher value, e.g. around 20,000 when running VB.

**NOTE 2** For relatively small datasets we recommend using the MCMC implementation of scMET, i.e. setting `use_mcmc = TRUE`, since it is more stable than the VB approximation and generally gives more accurate results.

```
# Run scMET for group A
fit_A <- scmet(Y = scmet_diff_dt$scmet_dt_A$Y,
               X = scmet_diff_dt$scmet_dt_A$X, L = 4,
               iter = 300, seed = 12)
```

```
## Chain 1: ------------------------------------------------------------
## Chain 1: EXPERIMENTAL ALGORITHM:
## Chain 1:   This procedure has not been thoroughly tested and may be unstable
## Chain 1:   or buggy. The interface is subject to change.
## Chain 1: ------------------------------------------------------------
## Chain 1:
## Chain 1:
## Chain 1:
## Chain 1: Gradient evaluation took 0.002622 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 26.22 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1:
## Chain 1:
## Chain 1: Begin eta adaptation.
## Chain 1: Iteration:   1 / 250 [  0%]  (Adaptation)
## Chain 1: Iteration:  50 / 250 [ 20%]  (Adaptation)
## Chain 1: Iteration: 100 / 250 [ 40%]  (Adaptation)
## Chain 1: Iteration: 150 / 250 [ 60%]  (Adaptation)
## Chain 1: Iteration: 200 / 250 [ 80%]  (Adaptation)
## Chain 1: Success! Found best value [eta = 1] earlier than expected.
## Chain 1:
## Chain 1: Begin stochastic gradient ascent.
## Chain 1:   iter             ELBO   delta_ELBO_mean   delta_ELBO_med   notes
## Chain 1:    100       -25145.284             1.000            1.000
## Chain 1:    200       -22617.737             0.556            1.000
## Chain 1:    300       -22382.208             0.061            0.112
## Chain 1: Informational Message: The maximum number of iterations is reached! The algorithm may not have converged.
## Chain 1: This variational approximation is not guaranteed to be meaningful.
## Chain 1:
## Chain 1: Drawing a sample of size 2000 from the approximate posterior...
## Chain 1: COMPLETED.
```

```
# Run scMET for group B
fit_B <- scmet(Y = scmet_diff_dt$scmet_dt_B$Y,
               X = scmet_diff_dt$scmet_dt_B$X, L = 4,
               iter = 300, seed = 12)
```

```
## Chain 1: ------------------------------------------------------------
## Chain 1: EXPERIMENTAL ALGORITHM:
## Chain 1:   This procedure has not been thoroughly tested and may be unstable
## Chain 1:   or buggy. The interface is subject to change.
## Chain 1: ------------------------------------------------------------
## Chain 1:
## Chain 1:
## Chain 1:
## Chain 1: Gradient evaluation took 0.002663 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 26.63 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1:
## Chain 1:
## Chain 1: Begin eta adaptation.
## Chain 1: Iteration:   1 / 250 [  0%]  (Adaptation)
## Chain 1: Iteration:  50 / 250 [ 20%]  (Adaptation)
## Chain 1: Iteration: 100 / 250 [ 40%]  (Adaptation)
## Chain 1: Iteration: 150 / 250 [ 60%]  (Adaptation)
## Chain 1: Iteration: 200 / 250 [ 80%]  (Adaptation)
## Chain 1: Success! Found best value [eta = 1] earlier than expected.
## Chain 1:
## Chain 1: Begin stochastic gradient ascent.
## Chain 1:   iter             ELBO   delta_ELBO_mean   delta_ELBO_med   notes
## Chain 1:    100       -24710.881             1.000            1.000
## Chain 1:    200       -22169.801             0.557            1.000
## Chain 1:    300       -21916.277             0.063            0.115
## Chain 1: Informational Message: The maximum number of iterations is reached! The algorithm may not have converged.
## Chain 1: This variational approximation is not guaranteed to be meaningful.
## Chain 1:
## Chain 1: Drawing a sample of size 2000 from the approximate posterior...
## Chain 1: COMPLETED.
```

Showing mean - overdispersion plots for each group

```
gg1 <- scmet_plot_mean_var(obj = fit_A, y = "gamma", task = NULL,
                           title = "Group A")
gg2 <- scmet_plot_mean_var(obj = fit_B, y = "gamma", task = NULL,
                           title = "Group B")
cowplot::plot_grid(gg1, gg2, ncol = 2)
```

![](data:image/png;base64...)

### 3.6.2 Running differential analysis

Now we can perform the DM and DV analysis by calling the `scmet_differential` function. **NOTE** that only those features that are common across the two groups will be kept for this analysis.

```
# Run differential analysis with small evidence_thresh
# tp obtain more hits.
diff_obj <- scmet_differential(obj_A = fit_A, obj_B = fit_B,
                               evidence_thresh_m = 0.65,
                               evidence_thresh_e = 0.65,
                               group_label_A = "A",
                               group_label_B = "B")
```

```
## For Differential mean task:
## Not possible to find evidence probability threshold (>0.6)
##  that achieves desired EFDR level (tolerance +- 0.025)
## Output based on the closest possible value.
```

```
## For Differential overdispersion task:
## Evidence probability threshold chosen via EFDR valibration is too low.
## Probability threshold set automatically equal to 'evidence_thresh_g'.
```

```
## ---------------------------------------
## The user excluded 0 features.
## These features are marked as 'ExcludedByUser'
## and are excluded from EFDR calibration.
```

```
## -------------------------------------------------------------
## 41 features with a change in mean methylation:
## - Higher methylation in A samples: 15
## - Higher methylation in B samples: 26
## - Odds ratio tolerance = 1.5
## - Probability evidence threshold=0.72225
## - EFDR = 1.25%
## - EFNR = 2.1%.
## -------------------------------------------------------------
##
## -------------------------------------------------------------
## 56 features with a change in over-dispersion:
## - Higher dispersion in A samples: 27
## - Higher dispersion in B samples: 29
## - Odds ratio tolerance = 1.5
## - Probability evidence threshold=0.8
## - EFDR = 1.77%
## - EFNR = 7.81%
## NOTE: differential dispersion assessment only applied to the
## 159 features for which the mean did not change
## and that were included for testing.
## --------------------------------------------------------------
## -------------------------------------------------------------
## 99 features with a change in residual over dispersion:
## - Higher residual dispersion in A samples: 75
## - Higher residual dispersion in B samples: 24
## - Odds ratio tolerance = 1.5
## - Probability evidence threshold=0.662
## - EFDR = 5%
## - EFNR = 14.09%.
## --------------------------------------------------------------
```

**NOTE** sometimes the method returns a message that it could not obtain an acceptable evidence threshold to achieve EFDR = 5%. Then by by default the evidence threshold is set to the initial value. This does **not** mean though that the test failed.

The `diff_obj` stores all the differential analysis information in the following structure:

```
# Structure of diff_obj
class(diff_obj)
```

```
## [1] "scmet_differential"
```

```
names(diff_obj)
```

```
## [1] "diff_mu_summary"      "diff_epsilon_summary" "diff_gamma_summary"
## [4] "diff_mu_thresh"       "diff_epsilon_thresh"  "diff_gamma_thresh"
## [7] "opts"
```

The `diff_<mode>_summary` entries contain the summary of the differential analysis, whereas the `diff_<mode>_thresh` slots contain information about the optimal posterior evidence threshold search to achieve the required EFDR.

```
# DM results
head(diff_obj$diff_mu_summary)
```

```
##             feature_name mu_overall   mu_A  mu_B     mu_LOR     mu_OR
## Feature_1      Feature_1    0.12300 0.1830 0.063  1.1946932 3.3025444
## Feature_116  Feature_116    0.30650 0.2020 0.411 -1.0119451 0.3635112
## Feature_12    Feature_12    0.78300 0.7260 0.840 -0.6862328 0.5034692
## Feature_125  Feature_125    0.20200 0.2480 0.156  0.5798989 1.7858579
## Feature_128  Feature_128    0.32275 0.3765 0.269  0.4960116 1.6421586
## Feature_134  Feature_134    0.12850 0.0930 0.164 -0.6442583 0.5250518
##             mu_tail_prob mu_diff_test
## Feature_1              1           A+
## Feature_116            1           B+
## Feature_12             1           B+
## Feature_125            1           A+
## Feature_128            1           A+
## Feature_134            1           B+
```

```
# Summary of DMs
diff_obj$diff_mu_summary |>
        dplyr::count(mu_diff_test)
```

```
##   mu_diff_test   n
## 1           A+  15
## 2           B+  26
## 3       NoDiff 159
```

```
# DV (based on epsilon) results
head(diff_obj$diff_epsilon_summary)
```

```
##             feature_name epsilon_overall epsilon_A epsilon_B epsilon_change
## Feature_1      Feature_1         0.41025    0.7045    0.1160          0.585
## Feature_115  Feature_115         1.00700    0.5495    1.4645         -0.919
## Feature_12    Feature_12        -0.11650    0.5205   -0.7535          1.276
## Feature_122  Feature_122         0.41250    0.8870   -0.0620          0.952
## Feature_124  Feature_124        -0.13400    0.3200   -0.5880          0.913
## Feature_125  Feature_125        -0.58450   -0.0700   -1.0990          1.026
##             epsilon_tail_prob epsilon_diff_test mu_overall  mu_A  mu_B
## Feature_1                   1                A+     0.1230 0.183 0.063
## Feature_115                 1                B+     0.3745 0.350 0.399
## Feature_12                  1                A+     0.7830 0.726 0.840
## Feature_122                 1                A+     0.4875 0.522 0.453
## Feature_124                 1                A+     0.7765 0.751 0.802
## Feature_125                 1                A+     0.2020 0.248 0.156
```

```
# Summary of DVs
diff_obj$diff_epsilon_summary |>
  dplyr::count(epsilon_diff_test)
```

```
##   epsilon_diff_test   n
## 1                A+  75
## 2                B+  24
## 3            NoDiff 101
```

Let us plot first the grid search for optimal evidence threshold.

```
gg1 <- scmet_plot_efdr_efnr_grid(obj = diff_obj, task = "diff_mu")
gg2 <- scmet_plot_efdr_efnr_grid(obj = diff_obj, task = "diff_epsilon")
cowplot::plot_grid(gg1, gg2, ncol = 2)
```

![](data:image/png;base64...)

### 3.6.3 Plotting differential hits

Below we show volcano plots for DM and DV analysis. Red and green colours correspond to features that are more methylated or variable in group A and group B, respectively.

```
# DM volcano plot
scmet_plot_volcano(diff_obj, task = "diff_mu")
```

![](data:image/png;base64...)

```
# DV based on epsilon volcano plot
scmet_plot_volcano(diff_obj, task = "diff_epsilon")
```

![](data:image/png;base64...)

Below we show MA plots for DM and DV analysis.

```
# MA plot for DM analysis and x axis overall mean methylation
gg1 <- scmet_plot_ma(diff_obj, task = "diff_mu", x = "mu")
# MA plot for DV analysis and x axis overall mean methylation
gg2 <- scmet_plot_ma(diff_obj, task = "diff_epsilon", x = "mu")
cowplot::plot_grid(gg1, gg2, ncol = 2)
```

![](data:image/png;base64...)

# 4 Interoperability between scMET and the SingleCellExperiment class

In this section we show the ability to convert between scMET objects and `SingleCellExperiment` (SCE) objects.

`SingleCellExperiment` is a class for storing single-cell experiment data used by many Bioconductor analysis packages. To the best of our knowledge there is no standard format for storing scBS-seq data. However, to ease analysis pipeline with scMET for users with experience in Bioconductor we provide helper functions for converting between those formats.

The structure of the SCE object to store scBS-seq data is as follows. We create two assays, `met` storing methylated CpGs and `total` storing total number of CpGs. Rows correspond to features and columns to cells, similar to scRNA-seq convention. To distinguish between a feature (in a cell) having zero methylated CpGs vs not having CpG coverage at all (missing value), we check if the corresponding entry in `total` is zero as well. Next `rownames` and `colnames` should store the feature and cell names, respectively. Covariates `X` that might explain variability in mean (methylation) should be stored in `metadata(rowData(sce))$X`.

Below we show an example of converting between these formats.

```
Y_scmet <- scmet_dt$Y # Methylation data
X <- scmet_dt$X # Covariates
head(Y_scmet)
```

```
##      Feature    Cell total_reads met_reads
##       <char>  <char>       <int>     <num>
## 1: Feature_1 Cell_13          14         9
## 2: Feature_1 Cell_21           9         9
## 3: Feature_1 Cell_11          10         8
## 4: Feature_1 Cell_50          10         1
## 5: Feature_1 Cell_44          11         6
## 6: Feature_1 Cell_14          12         8
```

Convert from scMET to SCE object:

```
# We could set X = NULL if we do not have covariates
Y_sce <- scmet_to_sce(Y = Y_scmet, X = X)
Y_sce
```

```
## class: SingleCellExperiment
## dim: 150 50
## metadata(0):
## assays(2): met total
## rownames(150): Feature_1 Feature_10 ... Feature_98 Feature_99
## rowData names(1): feature_names
## colnames(50): Cell_13 Cell_21 ... Cell_5 Cell_36
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Next, we convert back to scMET object:

```
scmet_obj <- sce_to_scmet(sce = Y_sce)
head(scmet_obj$Y)
```

```
##      Feature    Cell total_reads met_reads
##       <fctr>  <fctr>       <num>     <num>
## 1: Feature_1 Cell_13          14         9
## 2: Feature_1 Cell_21           9         9
## 3: Feature_1 Cell_11          10         8
## 4: Feature_1 Cell_50          10         1
## 5: Feature_1 Cell_44          11         6
## 6: Feature_1 Cell_14          12         8
```

Finally we can check that the final object is the same as our initial one:

```
all(Y_scmet == scmet_obj$Y)
```

```
## [1] TRUE
```

# 5 Session Info

This vignette was compiled using:

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
## [1] data.table_1.17.8 scMET_1.12.0      knitr_1.50        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] ggplot2_4.0.0               QuickJSR_1.8.1
##  [7] Biobase_2.70.0              inline_0.3.21
##  [9] lattice_0.22-7              vctrs_0.6.5
## [11] tools_4.5.1                 generics_0.1.4
## [13] stats4_4.5.1                curl_7.0.0
## [15] parallel_4.5.1              tibble_3.3.0
## [17] pkgconfig_2.0.3             Matrix_1.7-4
## [19] RColorBrewer_1.1-3          S7_0.2.0
## [21] S4Vectors_0.48.0            RcppParallel_5.1.11-1
## [23] assertthat_0.2.1            lifecycle_1.0.4
## [25] compiler_4.5.1              farver_2.1.2
## [27] tinytex_0.57                Seqinfo_1.0.0
## [29] codetools_0.2-20            htmltools_0.5.8.1
## [31] sass_0.4.10                 yaml_2.3.10
## [33] pillar_1.11.1               jquerylib_0.1.4
## [35] MASS_7.3-65                 SingleCellExperiment_1.32.0
## [37] DelayedArray_0.36.0         cachem_1.1.0
## [39] magick_2.9.0                StanHeaders_2.32.10
## [41] viridis_0.6.5               abind_1.4-8
## [43] rstan_2.32.7                tidyselect_1.2.1
## [45] digest_0.6.37               dplyr_1.1.4
## [47] bookdown_0.45               labeling_0.4.3
## [49] splines_4.5.1               cowplot_1.2.0
## [51] fastmap_1.2.0               grid_4.5.1
## [53] SparseArray_1.10.0          logitnorm_0.8.39
## [55] cli_3.6.5                   magrittr_2.0.4
## [57] S4Arrays_1.10.0             loo_2.8.0
## [59] dichromat_2.0-0.1           pkgbuild_1.4.8
## [61] withr_3.0.2                 scales_1.4.0
## [63] XVector_0.50.0              rmarkdown_2.30
## [65] matrixStats_1.5.0           gridExtra_2.3
## [67] VGAM_1.1-13                 coda_0.19-4.1
## [69] evaluate_1.0.5              GenomicRanges_1.62.0
## [71] IRanges_2.44.0              V8_8.0.1
## [73] viridisLite_0.4.2           rstantools_2.5.0
## [75] rlang_1.1.6                 Rcpp_1.1.0
## [77] glue_1.8.0                  BiocManager_1.30.26
## [79] BiocGenerics_0.56.0         jsonlite_2.0.0
## [81] R6_2.6.1                    MatrixGenerics_1.22.0
```

# 6 Acknowledgements

This study was supported by funding from the University of Edinburgh and Medical Research Council (core grant to the MRC Institute of Genetics and Cancer). Many thanks to *John Riddell* for the conversion functions.