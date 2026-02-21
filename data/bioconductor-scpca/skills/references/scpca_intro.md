# `scPCA`: Sparse contrastive principal component analysis

Philippe Boileau and Nima Hejazi

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Comparing PCA, SPCA, cPCA and scPCA](#comparing-pca-spca-cpca-and-scpca)
  + [3.1 PCA](#pca)
  + [3.2 Sparse PCA](#sparse-pca)
  + [3.3 Contrastive PCA (cPCA)](#contrastive-pca-cpca)
  + [3.4 Sparse Contrastive PCA (scPCA)](#sparse-contrastive-pca-scpca)
  + [3.5 Cross-Validation for Hyperparameter Tuning of cPCA and scPCA](#cross-validation-for-hyperparameter-tuning-of-cpca-and-scpca)
* [4 SPCA Optimization Frameworks](#spca-optimization-frameworks)
* [5 Bioconductor Integration via `SingleCellExperiment`](#bioconductor-integration-via-singlecellexperiment)
* [6 `scPCA` for Cell Cycle Effect Removal](#scpca-for-cell-cycle-effect-removal)
* [7 Parallelization](#parallelization)
* [8 Session Information](#session-information)
* [References](#references)

# 1 Introduction

Data pre-processing and exploratory data analysis and are two important steps in
the data science life-cycle. As datasets become larger and the signal weaker,
their importance increases. Methods capable of extracting the
signal from such datasets is badly needed. Often, these steps rely on
dimensionality reduction techniques to isolate pertinent information in data.
However, many of the most commonly-used methods fail to reduce the dimensions of
these large and noisy datasets successfully.

Principal component analysis (PCA) is one such method. Although popular for its
interpretable results and ease of implementation, PCA’s performance on
high-dimensional data often leaves much to be desired. Its results on these large
datasets have been found to be unstable, and it is often unable to identify
variation that is contextually meaningful.

Modifications of PCA have been developed to remedy these issues.
Namely, sparse PCA (sPCA) was created to increase the stability of the principal
component loadings and variable scores in high dimensions, and contrastive PCA
(cPCA) was proposed as a method for capturing relevant information in the
high-dimensional data by harnessing variation in control data
(Abid et al. [2018](#ref-abid2018exploring)).

Although sPCA and cPCA have proven useful in resolving individual shortcomings
of PCA, neither is capable of tackling the issues of stability and relevance
simultaneously. The `scPCA` package implements a combination of these methods,
dubbed sparse contrastive PCA (scPCA) (Boileau, Hejazi, and Dudoit [2020](#ref-boileau2020)), which draws on cPCA to
remove technical effects and on SPCA for sparsification of the loadings, thereby
extracting stable, interpretable, and relevant signal from
high-dimensional biological data. cPCA, previously unavailable to `R` users, is
also implemented.

---

# 2 Installation

To install the latest stable release of the `scPCA` package from Bioconductor,
use [`BiocManager`](https://CRAN.R-project.org/package%3DBiocManager):

```
BiocManager::install("scPCA")
```

Note that development of the `scPCA` package is done via its GitHub repository.
If you wish to contribute to the development of the package or use features that
have not yet been introduced into a stable release, `scPCA` may be installed
from GitHub using [`remotes`](https://CRAN.R-project.org/package%3Dremotes):

```
remotes::install_github("PhilBoileau/scPCA")
```

---

# 3 Comparing PCA, SPCA, cPCA and scPCA

```
library(dplyr)
library(ggplot2)
library(ggpubr)
library(elasticnet)
library(scPCA)
library(microbenchmark)
```

A brief comparison of PCA, SPCA, cPCA and scPCA is provided below. All four
methods are applied to a simulated target dataset consisting of 400
observations and 30 continuous variables. Additionally, each
observation is classified as belonging to one of four classes. This label is
known a priori. A background dataset is comprised of the same number of
variables as the target dataset, representing control data.

The target data was simulated as follows:

* Each of the first 10 variables was drawn from \(N(0, 10)\)
* For group 1 and 2, variables 11 through 20 were drawn from \(N(0, 1)\)
* For group 3 and 4, variables 11 through 20 were drawn from \(N(3, 1)\)
* For group 1 and 3, variables 21 though 30 were drawn from \(N(-3, 1)\)
* For group 2 and 4, variables 21 though 30 were drawn from \(N(0, 1)\)

The background data was simulated as follows:

* The first 10 variables were drawn from \(N(0, 10)\)
* Variables 11 through 20 were drawn from \(N(0, 3)\)
* Variables 21 through 30 were drawn from \(N(0, 1)\)

A similar simulation scheme is provided in Abid et al. ([2018](#ref-abid2018exploring)).

## 3.1 PCA

First, PCA is applied to the target data. As we can see from the figure, PCA is
incapable of creating a lower dimensional representation of the target data
that captures the variation of interest (i.e. the four groups). In fact, no
pair of principal components among the first twelve were able to.

```
# set seed for reproducibility
set.seed(1742)

# load data
data(toy_df)

# perform PCA
pca_sim <- prcomp(toy_df[, 1:30])

# plot the 2D rep using first 2 components
df <- as_tibble(list("PC1" = pca_sim$x[, 1],
                     "PC2" = pca_sim$x[, 2],
                     "label" = as.character(toy_df[, 31])))
p_pca <- ggplot(df, aes(x = PC1, y = PC2, colour = label)) +
  ggtitle("PCA on Simulated Data") +
  geom_point(alpha = 0.5) +
  theme_minimal()
p_pca
```

![](data:image/png;base64...)

## 3.2 Sparse PCA

Much like PCA, the leading components of SPCA – for varying amounts of
sparsity – are incapable of splitting the observations into four distinct
groups.

```
# perform sPCA on toy_df for a range of L1 penalty terms
penalties <- exp(seq(log(10), log(1000), length.out = 6))
df_ls <- lapply(penalties, function(penalty) {
  spca_sim_p <- elasticnet::spca(toy_df[, 1:30], K = 2, para = rep(penalty, 2),
                     type = "predictor", sparse = "penalty")$loadings
  spca_sim_p <- as.matrix(toy_df[, 1:30]) %*% spca_sim_p
  spca_out <- list("SPC1" = spca_sim_p[, 1],
                   "SPC2" = spca_sim_p[, 2],
                   "penalty" = round(rep(penalty, nrow(toy_df))),
                   "label"  = as.character(toy_df[, 31])) %>%
    as_tibble()
  return(spca_out)
})
df <- dplyr::bind_rows(df_ls)

# plot the results of sPCA
p_spca <- ggplot(df, aes(x = SPC1, y = SPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("SPCA on Simulated Data for Varying L1 Penalty Terms") +
  facet_wrap(~ penalty, nrow = 2) +
  theme_minimal()
p_spca
```

![](data:image/png;base64...)

## 3.3 Contrastive PCA (cPCA)

The first two contrastive principal components of cPCA successfully captured
the variation of interest in the data with the help of the background dataset.
To fit contrastive PCA with the `scPCA` function of this package, simply select
no penalization (by setting argument `penalties = 0`), and specify the expected
number of clusters in the data. Here, we set the number of clusters to 4
(`n_centers = 4`). Generally, this hyperparameter can be inferred *a priori*
from sample annotation variables (e.g. treatment groups, biological groups,
etc.), and empirical evidence suggests that the algorithm’s results are
robust to reasonable values of `n_centers` (Boileau, Hejazi, and Dudoit [2020](#ref-boileau2020)).

```
cpca_sim <- scPCA(target = toy_df[, 1:30],
                  background = background_df,
                  penalties = 0,
                  n_centers = 4)

# create a dataframe to be plotted
cpca_df <- cpca_sim$x %>%
  as_tibble() %>%
  mutate(label = toy_df[, 31] %>% as.character)
colnames(cpca_df) <- c("cPC1", "cPC2", "label")

# plot the results
p_cpca <- ggplot(cpca_df, aes(x = cPC1, y = cPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("cPCA of Simulated Data") +
  theme_minimal()
p_cpca
```

![](data:image/png;base64...)

## 3.4 Sparse Contrastive PCA (scPCA)

The leading sparse contrastive components were also able to capture the
variation of interest, though the clusters corresponding to the class labels
are more loose than those of cPCA. Importantly, the first and second loadings
vectors possess only eight and six non-zero loadings, respectively – a
significant improvement over cPCA, whose first and second cPCs each possess 30
non-zero loadings, in terms of interpretability. As with cPCA, the scPCA
algorithm has demonstrated its insensitivity to reasonable choices of
`n_centers` (Boileau, Hejazi, and Dudoit [2020](#ref-boileau2020)).

```
# run scPCA for using 40 logarithmically seperated contrastive parameter values
# and possible 20 L1 penalty terms
scpca_sim <- scPCA(target = toy_df[, 1:30],
                   background = background_df,
                   n_centers = 4,
                   penalties = exp(seq(log(0.01), log(0.5), length.out = 10)),
                   alg = "var_proj")
```

```
## Registered S3 method overwritten by 'sparsepca':
##   method     from
##   print.spca elasticnet
```

```
# create a dataframe to be plotted
scpca_df <- scpca_sim$x %>%
  as_tibble() %>%
  mutate(label = toy_df[, 31] %>% as.character)
colnames(scpca_df) <- c("scPC1", "scPC2", "label")

# plot the results
p_scpca <- ggplot(scpca_df, aes(x = scPC1, y = scPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("scPCA of Simulated Data") +
  theme_minimal()
p_scpca
```

![](data:image/png;base64...)

```
# create the loadings comparison plot
scpca_sim$rotation[, 1] <- -scpca_sim$rotation[, 1]
load_diff_df <- bind_rows(
  cpca_sim$rotation %>% as.data.frame,
  scpca_sim$rotation %>% as.data.frame
  ) %>%
  mutate(
    sparse = c(rep("0", 30), rep("1", 30)),
    coef = rep(1:30, 2)
  )
colnames(load_diff_df) <- c("comp1", "comp2", "sparse", "coef")

p1 <- load_diff_df %>%
  ggplot(aes(y = comp1, x = coef, fill = sparse)) +
  geom_bar(stat = "identity") +
  xlab("") +
  ylab("") +
  ylim(-1.4, 1.4) +
  ggtitle("First Component") +
  scale_fill_discrete(name = "Method", labels = c("cPCA", "scPCA")) +
  theme_minimal()

p2 <- load_diff_df %>%
  ggplot(aes(y = comp2, x = coef, fill = sparse)) +
  geom_bar(stat = "identity") +
  xlab("") +
  ylab("") +
  ylim(-1.4, 1.4) +
  ggtitle("Second Component") +
  scale_fill_discrete(name = "Method", labels = c("cPCA", "scPCA")) +
  theme_minimal()

# build full plot via ggpubr
annotate_figure(
  ggarrange(p1, p2, nrow = 1, ncol = 2,
            common.legend = TRUE, legend = "right"),
  top = "Leading Loadings Vectors Comparison",
  left = "Loading Weights",
  bottom = "Variable Index"
)
```

![](data:image/png;base64...)

## 3.5 Cross-Validation for Hyperparameter Tuning of cPCA and scPCA

The hyperparameters responsible for contrastiveness and sparsity of the cPCA and
scPCA embeddings provided in this package are selected through a
clustering-based hyperparameter tuning framework (detailed in (Boileau, Hejazi, and Dudoit [2020](#ref-boileau2020))).
If the discovery of non-generalizable patterns in the data becomes a concern, a
cross-validated approach to this tuning framework is made available. Below, we
provide the results of the cPCA and scPCA algorithms whose hyperparemeters were
selected using 3-fold cross-validation. We recommend using more folds for
larger datasets when using this heuristic.

```
cpca_cv_sim <- scPCA(target = toy_df[, 1:30],
                     background = background_df,
                     penalties = 0,
                     n_centers = 4,
                     cv = 3)

# create a dataframe to be plotted
cpca_cv_df <- cpca_cv_sim$x %>%
  as_tibble() %>%
  dplyr::mutate(label = toy_df[, 31] %>% as.character)
```

```
## Warning: The `x` argument of `as_tibble.matrix()` must have unique column names if
## `.name_repair` is omitted as of tibble 2.0.0.
## ℹ Using compatibility `.name_repair`.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
colnames(cpca_cv_df) <- c("cPC1", "cPC2", "label")

# plot the results
p_cpca_cv <- ggplot(cpca_cv_df, aes(x = cPC1, y = cPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("cPCA of Simulated Data") +
  theme_minimal()
```

```
scpca_cv_sim <- scPCA(target = toy_df[, 1:30],
                      background = background_df,
                      n_centers = 4,
                      cv = 3,
                      penalties = exp(seq(log(0.01), log(0.5), length.out = 10)),
                      alg = "var_proj")

# create a dataframe to be plotted
scpca_cv_df <- scpca_cv_sim$x %>%
  as_tibble() %>%
  mutate(label = toy_df[, 31] %>% as.character)
colnames(scpca_cv_df) <- c("scPC1", "scPC2", "label")

# plot the results
p_scpca_cv <- ggplot(scpca_cv_df, aes(x = -scPC1, y = -scPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("scPCA of Simulated Data") +
  theme_minimal()
```

![](data:image/png;base64...)

---

# 4 SPCA Optimization Frameworks

The `scPCA` package provides three options with which to sparsify the loadings
produced by cPCA:
1. The traditional iterative SPCA algorithm by Zou, Hastie, and Tibshirani ([2006](#ref-zou2006sparse)), implemented in the `elasticnet` package.
2. The SPCA algorithm relying on variable projection by Erichson et al. ([2018](#ref-erichson2018sparse)), implemented in the `sparsepca` package.
3. The randomized SPCA algorithm, which uses variable projection and random numerical linear algebra methods, by Erichson et al. ([2018](#ref-erichson2018sparse)), implemented in the `sparsepca` package.

For historical reasons, the default SPCA algorithm used is that of
Zou, Hastie, and Tibshirani ([2006](#ref-zou2006sparse)). However, Erichson et al. ([2018](#ref-erichson2018sparse))’s methods are noticeably faster.
We provide a comparison using the simulated data from Section 3 below:

```
timing_scPCA <- microbenchmark(
  "Zou et al." = scPCA(target = toy_df[, 1:30],
                       background = background_df,
                       n_centers = 4,
                       alg = "iterative"),
  "Erichson et al. SPCA" = scPCA(target = toy_df[, 1:30],
                                 background = background_df,
                                 n_centers = 4,
                                 alg = "var_proj"),
  "Erichson et al. RSPCA" = scPCA(target = toy_df[, 1:30],
                                  background = background_df,
                                  n_centers = 4,
                                  alg = "rand_var_proj"),
  times = 3
)

autoplot(timing_scPCA, log = TRUE) +
  ggtitle("Running Time Comparison") +
  theme_minimal()
```

![](data:image/png;base64...)

The computational advantage of Erichson et al. ([2018](#ref-erichson2018sparse))’s methods is clear. On larger
datasets, the scPCA method relying on the randomized version of SPCA is
demonstrably more efficient than its non-randomized counterparts (Boileau, Hejazi, and Dudoit [2020](#ref-boileau2020)),
as well as other commonly-used dimensionality reduction techniques like
t-Distributed Stochastic Neighbor Embedding (Maaten and Hinton [2008](#ref-vanDerMaaten2008)).

---

# 5 Bioconductor Integration via `SingleCellExperiment`

We now turn to discussing how the tools in the `scPCA` package can be used more
readily with data structures common in computational biology by examining their
integration with the `SingleCellExperiment` container class. For our example, we
will use `splatter` to simulate a scRNA-seq dataset using the Splatter
framework (Zappia, Phipson, and Oshlack [2017](#ref-zappia2017splatter)). This method simulates a scRNA-seq count matrix
by way of a gamma-Poisson hierarchical model, where the mean expression level of
gene \(g\_i,\; i = 1, \ldots, p\) is sampled from a gamma distribution, and the
count \(x\_{i, j}, \; j = 1, \ldots, n\) of cell \(c\_j\) is sampled from a Poisson
distribution with mean equal to the mean expression level of \(g\_i\).

To start, let’s load the required packages and create a simple dataset of 300
cells and 500 genes. The cells are evenly split among three biological groups.
The samples in two of these groups possess genes that are highly differentially
expressed when compared to those in other groups; they comprise the target data.
The genes of the third group of cells are less differentially expressed to the
genes in the target data, and so this group is considered the background
dataset. A large batch effect is simulated to confound the biological signal.
In practice, cells that make up the background dataset are pre-defined based on
experimental design, e.g. cells assumed to not contain the biological signal of
interest. For an example, see Boileau, Hejazi, and Dudoit ([2020](#ref-boileau2020)).

```
library(splatter)
library(SingleCellExperiment)

# Simulate the three groups of cells. Mask cell heterogeneity with batch effect
params <- newSplatParams(
  seed = 6757293,
  nGenes = 500,
  batchCells = c(150, 150),
  batch.facLoc = c(0.05, 0.05),
  batch.facScale = c(0.05, 0.05),
  group.prob = c(0.333, 0.333, 0.334),
  de.prob = c(0.1, 0.05, 0.1),
  de.downProb = c(0.1, 0.05, 0.1),
  de.facLoc = rep(0.2, 3),
  de.facScale = rep(0.2, 3)
)
sim_sce <- splatSimulate(params, method = "groups")
```

To proceed, we log-transform the raw counts and retain only the 250 most
variable genes. We then split the simulated data into target and background data
sets. Our goal here is to demonstrate a typical assessment of scRNA-seq data
(and data from similar assays) using the tools made available in the `scPCA`
package. A standard analysis would follow a workflow largely similar to the one
below, though without such a computationally convenient dataset.

```
# rank genes by variance
n_genes <- 250
vars <- assay(sim_sce) %>%
  log1p %>%
  rowVars
names(vars) <- rownames(sim_sce)
vars <- sort(vars, decreasing = TRUE)

# subset SCE to n_genes with highest variance
sce_sub <- sim_sce[names(vars[seq_len(n_genes)]),]
sce_sub
```

```
## class: SingleCellExperiment
## dim: 250 300
## metadata(1): Params
## assays(6): BatchCellMeans BaseCellMeans ... TrueCounts counts
## rownames(250): Gene336 Gene362 ... Gene409 Gene444
## rowData names(9): Gene BaseGeneMean ... DEFacGroup2 DEFacGroup3
## colnames(300): Cell1 Cell2 ... Cell299 Cell300
## colData names(4): Cell Batch Group ExpLibSize
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
# split the subsetted SCE into target and background SCEs
tg_sce <- sce_sub[, sce_sub$Group %in% c("Group1", "Group3")]
bg_sce <- sce_sub[, sce_sub$Group %in% c("Group2")]
```

Note that we limit our analysis to just 250 genes in the interest of
time, a typical analysis would generally include a much larger proportion (if
not all) of the genes assayed.

Owing to the flexibility of the `SingleCellExperiment` class, we are able to
generate PCA, cPCA, and scPCA representations of the target data, storing these
in `SingleCellExperiment` object using the `reducedDims` method.

Below, we perform standard PCA on the log-transformed target data, which has
been centered and scaled, and perform both cPCA and cPCA using the `scPCA`
function, storing each in a separate object. After applying each of these
dimension reduction techniques, we store the resultant objects in a `SimpleList`
that is then appended to the `SingleCellExperiment` object using the
`reducedDims` accessor. The results are presented in the following figure. cPCA
and scPCA successfully remove the batch effect, though PCA is incapable of doing
so in two dimensions.

```
# for both cPCA and scPCA, we'll set the penalties and contrasts arguments
contrasts <- exp(seq(log(0.1), log(100), length.out = 5))
penalties <- exp(seq(log(0.001), log(0.1), length.out = 3))

# first, PCA
pca_out <- prcomp(t(log1p(counts(tg_sce))), center = TRUE, scale. = TRUE)

# next, cPCA
cpca_out <- scPCA(t(log1p(counts(tg_sce))),
                  t(log1p(counts(bg_sce))),
                  n_centers = 2,
                  n_eigen = 2,
                  contrasts = contrasts,
                  penalties = 0,
                  center = TRUE,
                  scale = TRUE)

# finally, scPCA
scpca_out <- scPCA(t(log1p(counts(tg_sce))),
                   t(log1p(counts(bg_sce))),
                   n_centers = 2,
                   n_eigen = 2,
                   contrasts = contrasts,
                   penalties = penalties,
                   center = TRUE,
                   scale = TRUE,
                   alg = "var_proj")

# store new representations in the SingleCellExperiment object
reducedDims(tg_sce) <- SimpleList(PCA = pca_out$x[, 1:2],
                                  cPCA = cpca_out$x,
                                  scPCA = scpca_out$x)
tg_sce
```

```
## class: SingleCellExperiment
## dim: 250 213
## metadata(1): Params
## assays(6): BatchCellMeans BaseCellMeans ... TrueCounts counts
## rownames(250): Gene336 Gene362 ... Gene409 Gene444
## rowData names(9): Gene BaseGeneMean ... DEFacGroup2 DEFacGroup3
## colnames(213): Cell1 Cell2 ... Cell297 Cell299
## colData names(4): Cell Batch Group ExpLibSize
## reducedDimNames(3): PCA cPCA scPCA
## mainExpName: NULL
## altExpNames(0):
```

![](data:image/png;base64...)

In the above, we set `n_eigen = 2` in the calls to the `scPCA` function that
generate the cPCA and scPCA output, recovering the rotated gene-level data for
just the first two components of the dimension reduction. For congruence with
cPCA and scPCA, we retain only the first two dimensions generated by PCA in the
information stored in the `SingleCellExperiment` object.

While this is done to be explicit (as `n_eigen = 2` by default), we wish to
emphasize that it will often be appropriate to set this to a higher value in
order to recover further dimensions generated by these techniques, as such
additional information may be useful in exploring further signal in the data at
hand. Of course, as the number of components increases, `scPCA`’s computation
time increases. To offset this, consider reducing the size of the
hyperparameter grid.

The same strategy might be used when applying `scPCA` large datasets.
Additionally, consider setting the `scaled_matrix` argument to `TRUE`. This
takes advantage of the [`ScaledMatrix`](https://github.com/LTLA/ScaledMatrix)
packages framework to efficiently compute large contrastive covariance
matrices, at the expense of numerical precision.

# 6 `scPCA` for Cell Cycle Effect Removal

Contrastive methods have shown some success in removing cell cycle effects from
scRNA-seq data. See Chapters
[17](http://bioconductor.org/books/release/OSCA/cell-cycle-assignment.html#removing-cell-cycle-effects)
and [41](http://bioconductor.org/books/release/OSCA/messmer-hesc.html) of
[Orchestrating Single-Cell Analysis with
Bioconductor](http://bioconductor.org/books/release/OSCA) (Amezquita et al. [2020](#ref-osca)) for
discussions and examples.

# 7 Parallelization

Finally, note that the `scPCA` function has an argument `parallel` (set to
`FALSE` by default), which facilitates parallelized computation of the various
subroutines required in constructing the output of the `scPCA` function. In a
standard analysis of genomic data, use of this parallelization will be crucial,
thus, each of the core subroutines of `scPCA` has an equivalent parallelized
variant that makes use of the infrastructure provided by the [`BiocParallel`
package](https://bioconductor.org/packages/BiocParallel). In order to make
effective use of this parallelization, one need only set `parallel = TRUE` in a
call to `scPCA` after having registered a particular parallelization back-end
for parallel evaluation as described in the `BiocParallel` documentation. An
example of this form of parallelization follows:

```
# perform the same operations in parallel using BiocParallel
library(BiocParallel)
param <- MulticoreParam()
register(param)

# perfom cPCA
cpca_bp <- scPCA(
  target = toy_df[, 1:30],
  background = background_df,
  contrasts = exp(seq(log(0.1), log(100), length.out = 10)),
  penalties = 0,
  n_centers = 4,
  parallel = TRUE
)

# perform scPCA
scpca_bp <- scPCA(
  target = toy_df[, 1:30],
  background = background_df,
  contrasts = exp(seq(log(0.1), log(100), length.out = 10)),
  penalties = seq(0.1, 1, length.out = 9),
  n_centers = 4,
  parallel = TRUE
)
```

---

# 8 Session Information

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
##  [1] splatter_1.34.0             SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] microbenchmark_1.5.0        scPCA_1.24.0
## [15] elasticnet_1.3              lars_1.3
## [17] ggpubr_0.6.2                ggplot2_4.0.0
## [19] dplyr_1.1.4                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Rdpack_2.6.4        gridExtra_2.3       rlang_1.1.6
##  [4] magrittr_2.0.4      compiler_4.5.1      vctrs_0.6.5
##  [7] stringr_1.5.2       pkgconfig_2.0.3     crayon_1.5.3
## [10] fastmap_1.2.0       backports_1.5.0     magick_2.9.0
## [13] XVector_0.50.0      labeling_0.4.3      rmarkdown_2.30
## [16] tinytex_0.57        purrr_1.1.0         coop_0.6-3
## [19] xfun_0.53           cachem_1.1.0        jsonlite_2.0.0
## [22] DelayedArray_0.36.0 BiocParallel_1.44.0 broom_1.0.10
## [25] parallel_4.5.1      cluster_2.1.8.1     R6_2.6.1
## [28] bslib_0.9.0         stringi_1.8.7       RColorBrewer_1.1-3
## [31] parallelly_1.45.1   car_3.1-3           jquerylib_0.1.4
## [34] Rcpp_1.1.0          bookdown_0.45       assertthat_0.2.1
## [37] knitr_1.50          future.apply_1.20.0 Matrix_1.7-4
## [40] tidyselect_1.2.1    dichromat_2.0-0.1   abind_1.4-8
## [43] yaml_2.3.10         codetools_0.2-20    listenv_0.9.1
## [46] lattice_0.22-7      tibble_3.3.0        withr_3.0.2
## [49] S7_0.2.0            evaluate_1.0.5      future_1.67.0
## [52] kernlab_0.9-33      pillar_1.11.1       BiocManager_1.30.26
## [55] carData_3.0-5       checkmate_2.3.3     scales_1.4.0
## [58] origami_1.0.7       globals_0.18.0      glue_1.8.0
## [61] tools_4.5.1         data.table_1.17.8   ScaledMatrix_1.18.0
## [64] RSpectra_0.16-2     locfit_1.5-9.12     ggsignif_0.6.4
## [67] cowplot_1.2.0       grid_4.5.1          tidyr_1.3.1
## [70] rbibutils_2.3       Formula_1.2-5       cli_3.6.5
## [73] rsvd_1.0.5          viridisLite_0.4.2   sparsepca_0.1.2
## [76] S4Arrays_1.10.0     gtable_0.3.6        rstatix_0.7.3
## [79] sass_0.4.10         digest_0.6.37       SparseArray_1.10.0
## [82] farver_2.1.2        htmltools_0.5.8.1   lifecycle_1.0.4
```

---

# References

Abid, Abubakar, Martin J Zhang, Vivek K Bagaria, and James Zou. 2018. “Exploring Patterns Enriched in a Dataset with Contrastive Principal Component Analysis.” *Nature Communications* 9 (1): 2134.

Amezquita, Robert A., Aaron T. L. Lun, Etienne Becht, Vince J. Carey, Lindsay N. Carpp, Ludwig Geistlinger, Federico Marini, et al. 2020. “Orchestrating Single-Cell Analysis with Bioconductor.” *Nature Methods* 17 (2): 137–45.

Boileau, Philippe, Nima S Hejazi, and Sandrine Dudoit. 2020. “Exploring High-Dimensional Biological Data with Sparse Contrastive Principal Component Analysis.” *Bioinformatics*, March. <https://doi.org/10.1093/bioinformatics/btaa176>.

Erichson, N. Benjamin, Peng Zeng, Krithika Manohar, Steven L. Brunton, J. Nathan Kutz, and Aleksandr Y. Aravkin. 2018. “Sparse Principal Component Analysis via Variable Projection.” *ArXiv* abs/1804.00341.

Maaten, Laurens van der, and Geoffrey Hinton. 2008. “Visualizing Data Using t-SNE.” *Journal of Machine Learning Research* 9: 2579–2605. <http://www.jmlr.org/papers/v9/vandermaaten08a.html>.

Zappia, Luke, Belinda Phipson, and Alicia Oshlack. 2017. “Splatter: Simulation of Single-Cell Rna Sequencing Data.” *Genome Biology* 18 (1): 174.

Zou, Hui, Trevor Hastie, and Robert Tibshirani. 2006. “Sparse Principal Component Analysis.” *Journal of Computational and Graphical Statistics* 15 (2): 265–86.