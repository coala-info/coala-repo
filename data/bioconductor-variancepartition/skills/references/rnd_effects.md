# Theory and practice of random effects

#### Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-12-11 21:45:29

Abstract

The distinction between modeling a variable as a fixed versus a random effect depends on the goal of the statistical analysis. While some theory and software make a strong distinction, `variancePartition` and `dream` take different approaches based on the goal of each type of analysis. Here we consider the distinction between fixed and random effects, and the usage of REML in `variancePartition` and `dream`.

## `variancePartition`

### Estimating contributions to expression variation

In traditional statistics and biostatistics, there is a strong distinction between modeling categorical variants as fixed and random effects. Random effects correspond to a sample of units from a larger population, while fixed effects correspond to properties of specific individuals. Random effects are typically treated as nuisance variables and integrated out, and hypothesis testing is performed on the fixed effect.

The `r2glmm` package fits into this traditional framework, by computing the variance fractions for a given fixed effect as: \[\begin{eqnarray}
\sigma^2\_{fixed}/ \left(\sigma^2\_{fixed} + \sigma^2\_{error}\right)
\end{eqnarray}\]

Importantly, the random effects are not in the denominator. The fraction is only determined by fixed effects and residuals.

In my experience in bioinformatics, this was a problem. Making such distinctions between fixed and random effects seemed arbitrary. Variance in a phenotype could be due to age (fixed) or to variation across subject (random). Including all of the variables in the denominator produced more intuitive results so that 1) the variance fractions sum to one across all components and 2) fixed and random effects could be interpreted on the same scale 3) fractions could be compared across studies with different designs, 4) estimates of variance fractions were most accurate. So in variancePartition the fractions are defined as: \[\begin{eqnarray}
\sigma^2\_{X}/ \left(\sigma^2\_{fixed} + \sigma^2\_{random} + \sigma^2\_{error}\right)
\end{eqnarray}\]

just plugging the each variable in the numerator.

Thus the faction evaluated by variancePartition is different than `r2glmm` by definition.

Here is some code explicitly demonstrating this difference:

```
library("variancePartition")
library("lme4")
library("r2glmm")

set.seed(1)

N <- 1000
beta <- 3
alpha <- c(1, 5, 7)

# generate 1 fixed variable and 1 random variable with 3 levels
data <- data.frame(X = rnorm(N), Subject = sample(c("A", "B", "C"), 100, replace = TRUE))

# simulate variable
# y = X\beta + Subject\alpha + \sigma^2
data$y <- data$X * beta + model.matrix(~ data$Subject) %*% alpha + rnorm(N, 0, 1)

# fit model
fit <- lmer(y ~ X + (1 | Subject), data, REML = FALSE)

# calculate variance fraction using variancePartition
# include the total sum in the denominator
frac <- calcVarPart(fit)
frac
```

```
  Subject         X Residuals
   0.4505    0.4952    0.0543
```

```
# the variance fraction excluding the random effect from the denominator
# is the same as from r2glmm
frac[["X"]] / (frac[["X"]] + frac[["Residuals"]])
```

```
[1] 0.901
```

```
# using r2glmm
r2beta(fit)
```

```
  Effect   Rsq upper.CL lower.CL
1  Model 0.896    0.904    0.886
2      X 0.896    0.904    0.886
```

So the formulas are different. But why require categorical variables as random effects?

At practical level, categorical variables with too many levels are problematic. Using a categorical variable with 200 categories as a fixed effect is statistically unstable. There are so many degrees of freedom that that variable will absorb a lot of variance even under the null. Statistically, estimating the variance fraction for a variable with many categories can be biased if that variable is a fixed effect. Therefore, `variancePartition` requires all categorical variables to be random effects. Modeling this variable as a random effect produces unbiased estimates of variance fractions in practice. See simulations in the Supplement (section 1.5) of [Hoffman and Schadt (2016)](https://doi.org/10.1186/s12859-016-1323-z).

The distinction between fixed and random effects is important in the formulation because it affects which variables are put in the denominator. So choosing to model a variable as a fixed versus random effect will definitely change the estimated fraction.

Yet for the `variancePartition` formulation, all variables are in the denominator and it isn`t affected by the fixed/random decision. Moreover, using a random effect empirically reduces the bias of the estimated fraction.

Finally, why use maximum likelihood to estimate the paramters instead of the default REML ()? Maximum likelihood fits all parameters jointly so that it estimates the fixed and random effects together. This is essential if we want to compare fixed and random effects later. Conversely, REML estimates the random effects by removing the fixed effects from the response before estimation. This implicitly removes the fixed effects from the denominator when evaluating the variance fraction. REML treats fixed effects as nuisance variables, while `variancePartition` considers fixed effects to be a core part of the analysis.

While REML produced unbiased estimates of the variance components, the goal of `variancePartition` is to estimate the variance fractions for fixed and random effects jointly. In simulations from the Supplement (section 1.5) of [Hoffman and Schadt (2016)](https://doi.org/10.1186/s12859-016-1323-z), REML produced biased estimates of the variance fractions while maximum likelihood estimates are unbiased.

## `dream`

### Hypothesis testing

While `dream` is also based on a linear mixed model, the goal of this analysis is to perform hypothesis testing on fixed effects. Random effects are treated as nuisance variables to be integrated out, and the approximate null distribution of a t- or F-statistic is constructed from the model fit.

Since the goal of the analysis is different, the consideration of using REML versus ML is different than above. While is required by called by when , can be used with as either or . Since the Kenward-Roger method gave the best power with an accurate control of false positive rate in our simulations, and since the Satterthwaite method with gives p-values that are slightly closer to the Kenward-Roger p-values, is set as the default.

# Session Info

```
R version 4.5.2 (2025-10-31)
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
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] r2glmm_0.1.3             lme4_1.1-38              Matrix_1.7-4
 [4] GSEABase_1.72.0          graph_1.88.1             annotate_1.88.0
 [7] XML_3.99-0.20            AnnotationDbi_1.72.0     IRanges_2.44.0
[10] S4Vectors_0.48.0         Biobase_2.70.0           BiocGenerics_0.56.0
[13] generics_0.1.4           zenith_1.12.0            tximportData_1.38.0
[16] tximport_1.38.1          readr_2.1.6              edgeR_4.8.1
[19] pander_0.6.6             variancePartition_1.40.1 BiocParallel_1.44.0
[22] limma_3.66.0             ggplot2_4.0.1            knitr_1.50

loaded via a namespace (and not attached):
  [1] RColorBrewer_1.1-3          jsonlite_2.0.0
  [3] magrittr_2.0.4              farver_2.1.2
  [5] nloptr_2.2.1                rmarkdown_2.30
  [7] vctrs_0.6.5                 memoise_2.0.1
  [9] minqa_1.2.8                 RCurl_1.98-1.17
 [11] progress_1.2.3              htmltools_0.5.9
 [13] S4Arrays_1.10.1             curl_7.0.0
 [15] broom_1.0.11                SparseArray_1.10.7
 [17] sass_0.4.10                 KernSmooth_2.23-26
 [19] bslib_0.9.0                 pbkrtest_0.5.5
 [21] plyr_1.8.9                  cachem_1.1.0
 [23] lifecycle_1.0.4             iterators_1.0.14
 [25] pkgconfig_2.0.3             R6_2.6.1
 [27] fastmap_1.2.0               rbibutils_2.4
 [29] MatrixGenerics_1.22.0       digest_0.6.39
 [31] numDeriv_2016.8-1.1         GenomicRanges_1.62.1
 [33] RSQLite_2.4.5               labeling_0.4.3
 [35] httr_1.4.7                  abind_1.4-8
 [37] compiler_4.5.2              bit64_4.6.0-1
 [39] aod_1.3.3                   withr_3.0.2
 [41] S7_0.2.1                    backports_1.5.0
 [43] DBI_1.2.3                   gplots_3.3.0
 [45] MASS_7.3-65                 DelayedArray_0.36.0
 [47] corpcor_1.6.10              gtools_3.9.5
 [49] caTools_1.18.3              tools_4.5.2
 [51] msigdbr_25.1.1              remaCor_0.0.20
 [53] glue_1.8.0                  nlme_3.1-168
 [55] grid_4.5.2                  reshape2_1.4.5
 [57] snow_0.4-4                  gtable_0.3.6
 [59] tzdb_0.5.0                  tidyr_1.3.1
 [61] hms_1.1.4                   XVector_0.50.0
 [63] pillar_1.11.1               stringr_1.6.0
 [65] babelgene_22.9              vroom_1.6.7
 [67] splines_4.5.2               dplyr_1.1.4
 [69] lattice_0.22-7              bit_4.6.0
 [71] tidyselect_1.2.1            locfit_1.5-9.12
 [73] Biostrings_2.78.0           reformulas_0.4.2
 [75] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
 [77] RhpcBLASctl_0.23-42         xfun_0.54
 [79] statmod_1.5.1               matrixStats_1.5.0
 [81] KEGGgraph_1.70.0            stringi_1.8.7
 [83] yaml_2.3.12                 boot_1.3-32
 [85] evaluate_1.0.5              codetools_0.2-20
 [87] archive_1.1.12              tibble_3.3.0
 [89] Rgraphviz_2.54.0            cli_3.6.5
 [91] RcppParallel_5.1.11-1       xtable_1.8-4
 [93] Rdpack_2.6.4                jquerylib_0.1.4
 [95] dichromat_2.0-0.1           Rcpp_1.1.0
 [97] zigg_0.0.2                  EnvStats_3.1.0
 [99] png_0.1-8                   Rfast_2.1.5.2
[101] parallel_4.5.2              assertthat_0.2.1
[103] blob_1.2.4                  prettyunits_1.2.0
[105] bitops_1.0-9                mvtnorm_1.3-3
[107] lmerTest_3.1-3              scales_1.4.0
[109] purrr_1.2.0                 crayon_1.5.3
[111] fANCOVA_0.6-1               rlang_1.1.6
[113] EnrichmentBrowser_2.40.0    KEGGREST_1.50.0
```