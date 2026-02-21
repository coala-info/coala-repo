# netprioR Vignette

Fabian Schmich

#### 30 October, 2025

#### Abstract

*netprioR* is a probabilistic graphical model for gene prioritisation. The model integrates network data, such as protein–protein interaction networks or co-expression networks, gene phenotypes, e.g. from perturbation experiments, as well as prior knowledge about a priori known true positives and true negatives for a prioritisation task. The goal of the model is to provide a robust prioritisation (i.e. ranked list) of genes accounting for all dependencies in the input data. Parameter inference and imputation of hidden data is performed in an Expectation Maximisation (EM) framework. Here, we showcase the functionality of the netprioR package on simulated data.

#### Package

netprioR 1.36.0

# Contents

* [1 Data Simulation](#data-simulation)
  + [1.1 Prior knowledge labels](#prior-knowledge-labels)
  + [1.2 Network data](#network-data)
  + [1.3 Phenotypes](#phenotypes)
* [2 Gene Prioritisation](#gene-prioritisation)
* [3 Performance evaluation](#performance-evaluation)
* [4 Session Information](#session-information)

# 1 Data Simulation

*netprioR* requires the following data as input

* A priori known labels for true positive (TP) and true negative (TN) genes \(Y\)
* Network data describing gene–gene similarities \(G\)
* Gene phenotypes (and other covariates) \(X\)

In the following steps we simulate data for a set of N = 1000 genes
and a two class prioritisation task (positive vs. negative) and benchmark the performance
of our model against the case where we prioritise soleley based on phenotypes.

## 1.1 Prior knowledge labels

We simulate the case where we know 100 labels a priori, which corresponds
to 10% labelled data. We simulate equal numberos of 50 positives and
50 negatives, setting

```
members_per_class <- c(N/2, N/2) %>%
    floor
```

Then we simulate the labels, randomly choosing equal numbers of a priori known
labels for each class.

```
class.labels <- simulate_labels(values = c("Positive", "Negative"), sizes = members_per_class,
    nobs = c(nlabel/2, nlabel/2))
```

The list of simulated labels contains the complete vector of 1000 labels `labels.true`
and the vector of observed labels `labels.obs`. Unknown labels are set to `NA`.

```
names(class.labels)
```

```
[1] "labels.true" "labels.obs"  "labelled"    "unlabelled"
```

## 1.2 Network data

Next, we simulate high noise and low noise network data in the form of 1000 x 1000
adjacency matrices. The low noise networks obey the class structure defined above, whereas
the high noise networks do not.

```
networks <- list(LOW_NOISE1 = simulate_network_scalefree(nmemb = members_per_class,
    pclus = 0.8), LOW_NOISE2 = simulate_network_scalefree(nmemb = members_per_class,
    pclus = 0.8), HIGH_NOISE = simulate_network_random(nmemb = members_per_class,
    nnei = 1))
```

The networks are sparse binary adjacency matrices, which we can visualise as images.
This allows to see the structure within the low noise networks, where we observe 80%
of all edges in the 2nd and 4th quadrant, i.e. within each class, as defined above.

```
image(networks$LOW_NOISE1)
```

![](data:image/png;base64...)

## 1.3 Phenotypes

We simulate phenotype matching our simulated labels from two normal distributions
with a difference in means that reflects our phenotype effect size. We set the
effect size to

```
effect_size <- 0.25
```

and simulate the phenotypes

```
phenotypes <- simulate_phenotype(labels.true = class.labels$labels.true, meandiff = effect_size,
    sd = 1)
```

The higher the phenotype effect size is, the easier it is to separate the two classes
soleley based on the phenotype. We visualise the phenotypes for the two classes
as follows

```
data.frame(Phenotype = phenotypes[, 1], Class = rep(c("Positive", "Negative"), each = N/2)) %>%
    ggplot() + geom_density(aes(Phenotype, fill = Class), alpha = 0.25, adjust = 2) +
    theme_bw()
```

![](data:image/png;base64...)

# 2 Gene Prioritisation

Based on the simulated data above, we now fit the netprioR model for gene prioritisation.
In this example, we will use hyperparameters `a = b = 0.01` for the Gamma prior of the network
weights in order to yield a sparsifying prior We will fit only one model, setting `nrestarts` to 1,
whereas in practise multiple restarts are used in order to avoid cases where the EM gets stuck
in local minima. The convergence threshold for the relative change in the log likelihood is set to
1e-6.

```
np <- netprioR(networks = networks, phenotypes = phenotypes, labels = class.labels$labels.obs,
    nrestarts = 1, thresh = 1e-06, a = 0.1, b = 0.1, fit.model = TRUE, use.cg = FALSE,
    verbose = FALSE)
```

We can investigate the `netprioR` object using the `summary()` function.

```
summary(np)
```

```
#Genes: 1000
#Networks:  3
#Phenotypes: 1
#Labels: 100
Classes: Negative Positive
Model:
Likelihood[log]: -2962.902
Fixed effects: 0.004311014
Network weights:
    Network   Weight
 LOW_NOISE1 355.6724
 LOW_NOISE2 479.8619
 HIGH_NOISE  51.0374
```

It is also possible to plot the `netprioR` object to get an overview of the model
fit.

```
plot(np, which = "all")
```

![](data:image/png;base64...)
We can also plot individual plots by setting `which = "weights|ranks|lik"`.

# 3 Performance evaluation

We can see that the relative weight of the low noise networks is much higher than
for the high noise networks indicating that, as expected, the low noise networks
are more informative for the learning task.

Second, we evaluate the performance of the prioritised list of genes by comparing
the imputed, missing labels `Yimp[u]` against the true underlying labels `Y` and
computing receiver operator characteristic (ROC)

```
roc.np <- ROC(np, true.labels = class.labels$labels.true, plot = TRUE, main = "Prioritisation: netprioR")
```

![](data:image/png;base64...)

In addition, we compute the ROC curve for the case where we prioritise soleley
based on the phenotype

```
unlabelled <- which(is.na(class.labels$labels.obs))
roc.x <- roc(cases = phenotypes[intersect(unlabelled, which(class.labels$labels.true ==
    levels(class.labels$labels.true)[1])), 1], controls = phenotypes[intersect(unlabelled,
    which(class.labels$labels.true == levels(class.labels$labels.true)[2])), 1],
    direction = ">")
plot.roc(roc.x, main = "Prioritisation: Phenotype-only", print.auc = TRUE, print.auc.x = 0.2,
    print.auc.y = 0.1)
```

![](data:image/png;base64...)

Comparing the area under the receiver operator characteristic curve (AUC) values for both
cases, we can see that by integrating network data and a priori known labels for TPs
and TNs, we gain about 0.19 in AUC.

# 4 Session Information

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] Matrix_1.7-4     pROC_1.19.0.1    netprioR_1.36.0  ggplot2_4.0.0
[5] pander_0.6.6     dplyr_1.1.4      knitr_1.50       BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] sparseMVN_0.2.2     sass_0.4.10         generics_0.1.4
 [4] lattice_0.22-7      digest_0.6.37       magrittr_2.0.4
 [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
[10] bookdown_0.45       iterators_1.0.14    fastmap_1.2.0
[13] foreach_1.5.2       doParallel_1.0.17   jsonlite_2.0.0
[16] tinytex_0.57        formatR_1.14        gridExtra_2.3
[19] BiocManager_1.30.26 scales_1.4.0        codetools_0.2-20
[22] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
[25] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
[28] tools_4.5.1         parallel_4.5.1      vctrs_0.6.5
[31] R6_2.6.1            lifecycle_1.0.4     magick_2.9.0
[34] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
[37] gtable_0.3.6        glue_1.8.0          Rcpp_1.1.0
[40] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
[43] dichromat_2.0-0.1   farver_2.1.2        htmltools_0.5.8.1
[46] labeling_0.4.3      rmarkdown_2.30      compiler_4.5.1
[49] S7_0.2.0
```