# Introduction to PhenoPath

Kieran R Campbell

#### January 2019

# Contents

* [1 Overview of PhenoPath](#overview-of-phenopath)
  + [1.1 The PhenoPath model](#the-phenopath-model)
  + [1.2 Mean-field variational inference](#mean-field-variational-inference)
* [2 Example on simulated data](#example-on-simulated-data)
  + [2.1 Simulating data](#simulating-data)
  + [2.2 Fit PhenoPath model](#fit-phenopath-model)
  + [2.3 Examining results](#examining-results)
* [3 Advanced](#advanced)
  + [3.1 Using an `SummarizedExperiment` as input](#using-an-summarizedexperiment-as-input)
  + [3.2 Initialisation of latent space](#initialisation-of-latent-space)
  + [3.3 Controlling variational inference](#varcontrol)
* [4 Technical](#technical)
* [References](#references)

# 1 Overview of PhenoPath

## 1.1 The PhenoPath model

PhenoPath models gene expression expression \(y\) in terms of a latent pathway score (pseudotime) \(z\). Uniquely, the evolution of genes along the trajectory isn’t common to each gene but can be perturbed by an additional sample-specific covariate \(\beta\). For example, this could be the mutational status of each sample or a drug that each sample was exposed to.

![](data:image/png;base64...)

This software infers both the latent pathway scores \(z\_n\) and interaction coefficients \(\beta\_{pg}\) for samples \(n = 1, \ldots, N\), covariates \(p = 1, \ldots, P\) and genes \(G = 1, \ldots, G\).

## 1.2 Mean-field variational inference

Inference is performed using co-ordinate ascent mean field variational inference. This attempts to find a set of approximating distributions \(q(\mathbf{\theta}) = \prod\_i q\_i(\theta\_i)\) for each variable \(i\) by minimising the KL divergence between the KL divergence between the variational distribution and the true posterior. For a good overview of variational inference see Blei, Kucukelbir, and McAuliffe ([2016](#ref-blei2016variational)).

# 2 Example on simulated data

## 2.1 Simulating data

We can simulate data according to the PhenoPath model via a call to `simulate_phenopath()`:

```
set.seed(123L)
sim <- simulate_phenopath()
```

```
## Warning: `as_data_frame()` was deprecated in tibble 2.0.0.
## ℹ Please use `as_tibble()` (with slightly different semantics) to convert to a
##   tibble, or `as.data.frame()` to convert to a data frame.
## ℹ The deprecated feature was likely used in the phenopath package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `x` argument of `as_tibble.matrix()` must have unique column names if
## `.name_repair` is omitted as of tibble 2.0.0.
## ℹ Using compatibility `.name_repair`.
## ℹ The deprecated feature was likely used in the tibble package.
##   Please report the issue at <https://github.com/tidyverse/tibble/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

This returns a list with four entries:

```
print(str(sim))
```

```
## List of 4
##  $ parameters: tibble [40 × 4] (S3: tbl_df/tbl/data.frame)
##   ..$ alpha : num [1:40] 1 1 1 -1 1 1 1 -1 1 1 ...
##   ..$ lambda: num [1:40] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ beta  : num [1:40] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ regime: chr [1:40] "de" "de" "de" "de" ...
##  $ y         : num [1:100, 1:40] 1.001 0.999 1.001 1.002 0.999 ...
##  $ x         : num [1:100] 1 1 1 1 1 1 1 1 1 1 ...
##  $ z         : num [1:100] -0.713 -0.3512 1.6085 -0.0218 0.0426 ...
## NULL
```

* `parameters` is a data frame with the simulated parameters, with a column for each of the parameters \(\alpha\), \(\beta\) and \(\lambda\), and a row for each gene. There is an additional column specifying from which regime that gene has been simulated (see `?simulate_phenopath` for details).
* `y` is the \(N \times G\) matrix of gene expression
* `x` is the \(N\)-length vector of covariates
* `z` is the true latent pseudotimes

By default this simulates the model for \(N= 100\) cells and \(G=40\) genes.

For 8 representative genes we can visualise what the expression looks like over pseudotime:

```
genes_to_extract <- c(1,3,11,13,21,23,31,33)
expression_df <- as.data.frame(sim$y[,genes_to_extract])
names(expression_df) <- paste0("gene_", genes_to_extract)

df_gex <- as_tibble(expression_df) %>%
  mutate(x = factor(sim[['x']]), z = sim[['z']]) %>%
  gather(gene, expression, -x, -z)

ggplot(df_gex, aes(x = z, y = expression, color = x)) +
  geom_point() +
  facet_wrap(~ gene, nrow = 2) +
  scale_color_brewer(palette = "Set1")
```

![](data:image/png;base64...)

We see for the first two genes there is differential expression only, genes 3 and 4 show a pseudotime dependence, genes 5 and 6 show pseudotime-covariate interactions (but marginally no differential expression), while genes 7 and 8 show differential expression, pseudotime dependence and pseudotime-covariate interactions.

We can further plot this in PCA space, coloured by both covariate and pseudotime to get an idea of how these look in the reduced dimension:

```
pca_df <- as_tibble(as.data.frame(prcomp(sim$y)$x[,1:2])) %>%
  mutate(x = factor(sim[['x']]), z = sim[['z']])

ggplot(pca_df, aes(x = PC1, y = PC2, color = x)) +
  geom_point() + scale_colour_brewer(palette = "Set1")

ggplot(pca_df, aes(x = PC1, y = PC2, color = z)) +
  geom_point()
```

![](data:image/png;base64...)![](data:image/png;base64...)

## 2.2 Fit PhenoPath model

PhenoPath fits models with a call to the `phenopath` function, which requires at least an expression matrix `y` and a covariate vector `x`. The expression data should represent something comparable to logged counts, such as \(log\_2(\text{TPM}+1)\). Note that buy default PhenoPath centre-scales the input expression.

For use with `SummarizedExperiment`s see the [section on input formats](#inputdata). For this example we choose an ELBO tolerance of `1e-6` and ELBO calculations thinned by `40`. A discussion of how to control variational inference can be found [below](#varcontrol).

```
fit <- phenopath(sim$y, sim$x, elbo_tol = 1e-6, thin = 40)
```

```
## Iteration    ELBO    Change (%)
## [ 40 ]    -371.028993280216   Inf
## [ 80 ]    -370.889836821025   0.000937990512114315
## [ 120 ]   -370.810424921066   0.000535394197558752
## [ 160 ]   -370.76402387467    0.000312874519967849
## [ 200 ]   -370.736371282354   0.000186470727302097
## [ 240 ]   -370.719625484181   0.000112927648156567
## [ 280 ]   -370.709354564873   6.92653097439919e-05
## [ 320 ]   -370.702991977764   4.29089274084775e-05
## [ 360 ]   -370.699020180317   2.67858642156873e-05
## [ 400 ]   -370.696526275701   1.68190449487295e-05
## [ 440 ]   -370.694953393121   1.06076611366389e-05
## [ 480 ]   -370.69395807155    6.71255593237956e-06
## [ 520 ]   -370.69332664696    4.25840273591429e-06
## [ 560 ]   -370.69292531937    2.70660405237961e-06
## [ 600 ]   -370.692669877552   1.72273313657613e-06
## [ 640 ]   -370.692507117573   1.0976751337654e-06
## [ 680 ]   -370.692403328499   6.99967637195469e-07
```

```
print(fit)
```

```
## PhenoPath fit with 100 cells and 40 genes
```

The `phenopath` function will print progress on iterations, ELBO, and % change in ELBO that may be turned off by setting `verbose = FALSE` in the call.

Once the model has been fit it is important to check convergence with a call to `plot_elbo(fit)` to ensure the ELBO is approximately flat:

```
plot_elbo(fit)
```

```
## Warning: `qplot()` was deprecated in ggplot2 3.4.0.
## ℹ The deprecated feature was likely used in the phenopath package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 2.3 Examining results

The posterior mean estimates of the pseudotimes \(z\) sit in `fit$m_z` that can be extracted using the `trajectory` function. We can visualise these compared to both the true pseudotimes and the first principal component of the data:

```
qplot(sim$z, trajectory(fit)) +
  xlab("True z") + ylab("Phenopath z")
qplot(sim$z, pca_df$PC1) +
  xlab("True z") + ylab("PC1")
```

![](data:image/png;base64...)![](data:image/png;base64...)

We see that this has high correlation with the true pseudotimes:

```
cor(sim$z, trajectory(fit))
```

```
## [1] -0.9976558
```

Next, we’re interested in the interactions between the latent space and the covariates. There are three functions to help us here:

* `interaction_effects` retrieves the posterior interaction effect sizes
* `interaction_sds` retrieves the posterior interaction standard deviations
* `significant_interactions` applies a Bayesian significant test to the interaction parameters

Note that if \(P=1\) (ie there is only one covariate) each of these will return a vector, while if \(P>1\) then a matrix is returned.

Alternatively, one can call the `interactions` function that returns a data frame with the following entries:

* `feature` The feature (usually gene)
* `covariate` The covariate, specified from the order originally supplied to the call to `phenopath`
* `interaction_effect_size` The effect size of the interaction (\(\beta\) from the statistical model)
* `significant` Boolean for whether the interaction effect is significantly different from 0
* `chi` The precision of the ARD prior on \(\beta\)
* `pathway_loading` The pathway loading \(\lambda\), showing the overall effect for each gene marginalised over the covariate

In our simulated data above, the first 20 genes were simulated with no interaction effect while the latter 20 were simulated with interaction effects. We can pull out the interaction effect sizes, standard deviations, and significance test results into a data frame and plot:

```
gene_names <- paste0("gene", seq_len(ncol(fit$m_beta)))
df_beta <- data_frame(beta = interaction_effects(fit),
                      beta_sd = interaction_sds(fit),
                      is_sig = significant_interactions(fit),
                      gene = gene_names)
```

```
## Warning: `data_frame()` was deprecated in tibble 1.1.0.
## ℹ Please use `tibble()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
df_beta$gene <- fct_relevel(df_beta$gene, gene_names)

ggplot(df_beta, aes(x = gene, y = beta, color = is_sig)) +
  geom_point() +
  geom_errorbar(aes(ymin = beta - 2 * beta_sd, ymax = beta + 2 * beta_sd)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x = element_blank()) +
  ylab(expression(beta)) +
  scale_color_brewer(palette = "Set2", name = "Significant")
```

![](data:image/png;base64...)

A typical analysis might follow by graphing the largest effect size; we can do this as follows:

```
which_largest <- which.max(df_beta$beta)

df_large <- data_frame(
  y = sim[['y']][, which_largest],
  x = factor(sim[['x']]),
  z = sim[['z']]
)

ggplot(df_large, aes(x = z, y = y, color = x)) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  stat_smooth()
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

# 3 Advanced

## 3.1 Using an `SummarizedExperiment` as input

Alternatively you might have expression values in an `SummarizedExperiment`. For single-cell data it is highly recommended to use the [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/summarizedexperiment.html) in which case data is stored in a class derived from `SummarizedExperiment`.

We’ll first construct an example `SummarizedExperiment` using our previous simulation data:

```
suppressPackageStartupMessages(library(SummarizedExperiment))
exprs_mat <- t(sim$y)
pdata <- data.frame(x = sim$x)
sce <- SummarizedExperiment(assays = list(exprs = exprs_mat),
                            colData = pdata)
sce
```

```
## class: SummarizedExperiment
## dim: 40 100
## metadata(0):
## assays(1): exprs
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): x
```

Note that PhenoPath will use by default is in the `exprs` assay of a `SummarizedExperiment` (ie `assay(sce, "exprs")`) as gene expression values, which can be changed using the `sce_assay` string in the column to `phenopath`.

We can then pass the \(x\) covariates to PhenoPath in three ways:

1. As a vector or matrix as before
2. As a character that names a column of `colData(sce)` to use
3. A formula to build a model matrix from `colData(sce)`

For our example, these three look like

```
fit <- phenopath(sce, sim$x) # 1
fit <- phenopath(sce, "x") # 2
fit <- phenopath(sce, ~ x) # 3
```

Note that if the column of the SCESet is a factor it is coerced into a one-hot encoding. The intercept term is then removed as this is taken care of by the \(\lambda\) coefficient automatically, and the columns centre-scaled.

## 3.2 Initialisation of latent space

The posterior distribution is naturally multi-modal and the use of variational inference means we essentially dive straight into the nearest local maximum. Therefore, correct initialisation of the latent space is important. This is controlled through the `z_init` argument.

PhenoPath allows for three different initialisations:

1. An integer specifying a principal component of the data to initialise to
2. A vector specifying the initial values
3. Random initialisation from standard normal distribution

For our example these three look like

```
fit <- phenopath(sim$y, sim$x, z_init = 1) # 1, initialise to first principal component
fit <- phenopath(sim$y, sim$x, z_init = sim$z) # 2, initialise to true values
fit <- phenopath(sim$y, sim$x, z_init = "random") # 3, random initialisation
```

## 3.3 Controlling variational inference

There are several parameters that tune the coordinate ascent variational inference (CAVI):

1. `maxiter` maximum number of iterations to run CAVI for
2. `elbo_tol` the *percentage* change in the ELBO below which the
   model is considered converged
3. `thin` Computing the ELBO is expensive, so only compute the ELBO every
   `thin` iterations

For example:

```
fit <- phenopath(sim$y, sim$x,
                 maxiter = 1000, # 1000 iterations max
                 elbo_tol = 1e-2, # consider model converged when change in ELBO < 0.02%
                 thin = 20 # calculate ELBO every 20 iterations
                 )
```

# 4 Technical

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] phenopath_1.34.0            forcats_1.0.1
## [13] tidyr_1.3.1                 ggplot2_4.0.0
## [15] dplyr_1.1.4                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
##  [4] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
##  [7] grid_4.5.1          RColorBrewer_1.1-3  bookdown_0.45
## [10] fastmap_1.2.0       Matrix_1.7-4        jsonlite_2.0.0
## [13] tinytex_0.57        BiocManager_1.30.26 mgcv_1.9-3
## [16] purrr_1.1.0         scales_1.4.0        codetools_0.2-20
## [19] jquerylib_0.1.4     abind_1.4-8         cli_3.6.5
## [22] crayon_1.5.3        rlang_1.1.6         XVector_0.50.0
## [25] splines_4.5.1       DelayedArray_0.36.0 withr_3.0.2
## [28] cachem_1.1.0        yaml_2.3.10         S4Arrays_1.10.0
## [31] tools_4.5.1         vctrs_0.6.5         R6_2.6.1
## [34] magick_2.9.0        lifecycle_1.0.4     pkgconfig_2.0.3
## [37] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [40] glue_1.8.0          Rcpp_1.1.0          xfun_0.53
## [43] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
## [46] dichromat_2.0-0.1   farver_2.1.2        nlme_3.1-168
## [49] htmltools_0.5.8.1   labeling_0.4.3      rmarkdown_2.30
## [52] compiler_4.5.1      S7_0.2.0
```

# References

Blei, David M, Alp Kucukelbir, and Jon D McAuliffe. 2016. “Variational Inference: A Review for Statisticians.” *arXiv Preprint arXiv:1601.00670*.