# Pirat

Lucas Etourneau and Samuel Wieczorek

#### 2025-11-27

#### Package

Pirat 1.4.4

# 1 Installation

*[Pirat](https://bioconductor.org/packages/3.22/Pirat)* is an `R` package available via the
[Bioconductor](http://bioconductor.org) repository for packages.

You can install the latest version by executing the following code:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Pirat")
```

When calling one of the imputation methods for the first time after package
installation, the underlying python module and conda environment will be
automatically downloaded and installed without the need for user intervention.
This may take several minutes, but this is a one-time installation.

# 2 Standard imputation with Pirat

Pirat is a single imputation pipeline including a novel statistical approach
dedicated to bottom-up proteomics data. All the technical details and the
validation procedure of this method are available on the corresponding
preprint Etourneau et al. ([2023](#ref-Etourneau2023)) .
To demonstrate its usage, we first load Pirat package and a subset of
Bouyssie2020 dataset in the environment.

```
library(Pirat)
library(utils)
data(subbouyssie)
```

Note that `subbouyssie` is a list that contains two elements:

1. `peptides_ab`, the matrix of peptide log-2-abundances, with samples in rows
   and peptides in columns.
2. `adj`, the adjacency matrix between peptides and proteins, containing either
   booleans or 0s and 1s (no preprocessing or simplification is needed for this
   matrix, Pirat will automatically build the PGs from it).

Slight imputation variations may occur for peptides belonging to very large
PGs, because the latter are randomly split into several smaller PGs with fixed
size to reduce computational costs. Although this variability is too small to
affect imputation quality, we fix the seed in this tutorial such that the user
can retrieve exactly the same imputed values when running the notebook again.

```
set.seed(12345)
```

One can then impute this dataset with the following line

```
imp.res <- my_pipeline_llkimpute(subbouyssie)
#> Using Python: /home/biocbuild/.pyenv/versions/3.10.19/bin/python3.10
#> Creating virtual environment '/var/cache/basilisk/1.22.0/Pirat/1.4.4/envPirat' ...
#> Done!
#> Installing packages: pip, wheel, setuptools
#> Installing packages: 'torch==2.0.0', 'numpy==1.24'
#> Virtual environment '/var/cache/basilisk/1.22.0/Pirat/1.4.4/envPirat' successfully created.
#>
#> Call:
#> stats::lm(formula = log(probs) ~ m_ab_sorted[seq(length(probs))])
#>
#> Residuals:
#>      Min       1Q   Median       3Q      Max
#> -0.64780 -0.25838  0.06931  0.35373  0.76279
#>
#> Coefficients:
#>                                 Estimate Std. Error t value Pr(>|t|)
#> (Intercept)                      13.1950     1.5687   8.411 1.19e-07 ***
#> m_ab_sorted[seq(length(probs))]  -0.7937     0.0758 -10.471 4.38e-09 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> Residual standard error: 0.42 on 18 degrees of freedom
#> Multiple R-squared:  0.859,  Adjusted R-squared:  0.8511
#> F-statistic: 109.6 on 1 and 18 DF,  p-value: 4.378e-09
```

The result `imp.res` is a list that contains:

1. `data.imputed`, the imputed log-2 abundance matrix.
2. `params`, a list containing parameters \(\Gamma\) and hyperparameters
   \(\alpha\) and \(\beta\).

You can check the imputed values here…

```
head(imp.res$data.imputed[ ,seq(5)])
#>                        ELISMAK  EDLLVTK  VVIEPHR  HAGVYIAR
#> raw_abundance_10amol_1 24.07467 25.08683 24.79494  25.90383
#> raw_abundance_10amol_2 24.05896 25.11780 25.04157  26.20225
#> raw_abundance_10amol_3 23.94210 24.97989 24.67742  25.97934
#> raw_abundance_10amol_4 24.00094 24.93289 24.31135  25.80639
#> raw_abundance_50amol_1 24.05962 25.03968 24.66224  25.86291
#> raw_abundance_50amol_2 24.02732 25.02199 24.65812  25.84511
#>                        DHCIVVGR Carbamidomethyl (C3)
#> raw_abundance_10amol_1                      24.77011
#> raw_abundance_10amol_2                      24.98623
#> raw_abundance_10amol_3                      24.69103
#> raw_abundance_10amol_4                      24.50651
#> raw_abundance_50amol_1                      24.68406
#> raw_abundance_50amol_2                      24.66596
```

…and the computed parameters here.

```
imp.res$params
#> $alpha
#>        a
#> 5.147391
#>
#> $beta
#>         b
#> 0.2335301
#>
#> $gamma0
#> (Intercept)
#>   -13.19496
#>
#> $gamma1
#> m_ab_sorted[seq(length(probs))]
#>                       0.7937527
```

These parameters were originally proposed in Chen, Prentice, and Wang ([2014](#ref-Chen2014)),
however no methods were proposed to find then
automatically and without heuristics.
Note that a positive value for \(\gamma\_1\) indicates that a random
left-truncation mechanism is present in the dataset.

# 3 Intra-PG correlation analysis

Pirat has a diagnosis tool that compares distributions of correlations at
random and those from same peptide groups (PGs).
We use it here on the complete Ropers2021 dataset.

```
data(ropers)
plot_pep_correlations(ropers, titlename = "Ropers2021")
```

![](data:image/png;base64...)

We see here that the blue distribution has much more weights on high
correlations than the red one,
indicating that PGs should clearly help for imputation.

# 4 Pirat extensions

To handle singleton PGs, Pirat proposes three extensions, on top of the
classical Pirat approach.
Note that the -T extension can be applied to up to an arbitrary PG size.
To illustrate our examples, we use a subset of Ropers2021 dataset.

# 5 -2, the 2-peptide rule

The -2 extension simply consists in not imputing singleton PGs. It can be used as following.

```
data(subropers)
imp.res = pipeline_llkimpute(subropers, extension = "2")
#>
#> Call:
#> stats::lm(formula = log(probs) ~ m_ab_sorted[seq(length(probs))])
#>
#> Residuals:
#>      Min       1Q   Median       3Q      Max
#> -1.40672 -0.15008  0.08833  0.28986  0.84125
#>
#> Coefficients:
#>                                 Estimate Std. Error t value Pr(>|t|)
#> (Intercept)                     14.40677    1.19049   12.10 2.48e-16 ***
#> m_ab_sorted[seq(length(probs))] -0.91419    0.06469  -14.13  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> Residual standard error: 0.4549 on 49 degrees of freedom
#> Multiple R-squared:  0.803,  Adjusted R-squared:  0.799
#> F-statistic: 199.7 on 1 and 49 DF,  p-value: < 2.2e-16
```

We can then check that singleton peptides are not imputed (yet some may be
already fully observed).

```
mask.sing.pg = colSums(subropers$adj) == 1
mask.sing.pep = rowSums(subropers$adj[, mask.sing.pg]) >= 1
imp.res$data.imputed[, mask.sing.pep]
#>         NALPEGYAPAK__2 AIGIISNNPEFADVR__2 DLNIDPATLR__2
#> W1_1_MS       20.17349                 NA      19.18247
#> W1_2_MS       19.79753           17.22690      18.50307
#> W1_3_MS       20.07592           17.55627      18.83505
#> W2_1_MS       19.82019           17.42375      18.47821
#> W2_2_MS       20.17537           17.13305      17.89070
#> W2_3_MS       20.36344           17.50759      18.18041
#> R1_1_MS       20.69017                 NA      18.12682
#> R1_2_MS       20.70866                 NA      18.03316
#> R1_3_MS       21.04542                 NA      18.52355
#> R2_1_MS       20.95692                 NA      18.49510
#> R2_2_MS       20.90775           15.87217      17.92845
#> R2_3_MS       21.20864                 NA      18.24418
#> R3_1_MS       21.02669                 NA            NA
#> R3_2_MS       21.10948                 NA      17.34890
#> R3_3_MS       21.23109                 NA            NA
#> R4_1_MS       20.83249                 NA      17.28032
#> R4_2_MS       21.00524                 NA      17.67013
#> R4_3_MS       20.57447                 NA      17.33383
```

# 6 -S, samples-wise correlations

Pirat can leverage sample-wise correlations to impute the singleton peptides
as following:

```
imp.res = my_pipeline_llkimpute(subropers, extension = "S")
#>
#> Call:
#> stats::lm(formula = log(probs) ~ m_ab_sorted[seq(length(probs))])
#>
#> Residuals:
#>      Min       1Q   Median       3Q      Max
#> -1.40672 -0.15008  0.08833  0.28986  0.84125
#>
#> Coefficients:
#>                                 Estimate Std. Error t value Pr(>|t|)
#> (Intercept)                     14.40677    1.19049   12.10 2.48e-16 ***
#> m_ab_sorted[seq(length(probs))] -0.91419    0.06469  -14.13  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> Residual standard error: 0.4549 on 49 degrees of freedom
#> Multiple R-squared:  0.803,  Adjusted R-squared:  0.799
#> F-statistic: 199.7 on 1 and 49 DF,  p-value: < 2.2e-16
```

Here the singleton peptides are imputed after the rest of the dataset, using
the sample-wise covariance matrix obtained.

```
mask.sing.pg = colSums(subropers$adj) == 1
mask.sing.pep = rowSums(subropers$adj[, mask.sing.pg]) >= 1
imp.res$data.imputed[, mask.sing.pep]
#>         NALPEGYAPAK__2 AIGIISNNPEFADVR__2 DLNIDPATLR__2
#> W1_1_MS       20.17349           17.77470      19.18247
#> W1_2_MS       19.79753           17.22690      18.50307
#> W1_3_MS       20.07592           17.55627      18.83505
#> W2_1_MS       19.82019           17.42375      18.47821
#> W2_2_MS       20.17537           17.13305      17.89070
#> W2_3_MS       20.36344           17.50759      18.18041
#> R1_1_MS       20.69017           16.01817      18.12682
#> R1_2_MS       20.70866           16.28721      18.03316
#> R1_3_MS       21.04542           16.34728      18.52355
#> R2_1_MS       20.95692           16.10788      18.49510
#> R2_2_MS       20.90775           15.87217      17.92845
#> R2_3_MS       21.20864           16.43661      18.24418
#> R3_1_MS       21.02669           15.87984      17.69220
#> R3_2_MS       21.10948           16.04063      17.34890
#> R3_3_MS       21.23109           16.01668      18.00217
#> R4_1_MS       20.83249           16.22822      17.28032
#> R4_2_MS       21.00524           16.03711      17.67013
#> R4_3_MS       20.57447           15.87568      17.33383
```

# 7 -T, transcriptomic integration

The last extension consists in using correlations between peptides and
gene/transcript expression obtained from a related transcriptomic analysis.
To use this extension, the list of the dataset must contain:

* `rnas_ab`, an log2-normalized-count table of gene or transcript expression,
  for which samples are either paired or related (*i.e.*, from the same
  experimental/biological conditions).
* `adj_rna_pg`, a adjacency matrix between transcripts or genes and PGs,
  containing either booleans or 0s and 1s.

`ropers` proteomic and transcriptomic samples are paired (*i.e.* the same
biological samples were used for each type of analysis). Thus Pirat-T can be
used as following:

```
imp.res = my_pipeline_llkimpute(subropers,
    extension = "T",
    rna.cond.mask = seq(nrow(subropers$peptides_ab)),
    pep.cond.mask = seq(nrow(subropers$peptides_ab)),
    max.pg.size.pirat.t = 1)
#>
#> Call:
#> stats::lm(formula = log(probs) ~ m_ab_sorted[seq(length(probs))])
#>
#> Residuals:
#>      Min       1Q   Median       3Q      Max
#> -1.40672 -0.15008  0.08833  0.28986  0.84125
#>
#> Coefficients:
#>                                 Estimate Std. Error t value Pr(>|t|)
#> (Intercept)                     14.40677    1.19049   12.10 2.48e-16 ***
#> m_ab_sorted[seq(length(probs))] -0.91419    0.06469  -14.13  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> Residual standard error: 0.4549 on 49 degrees of freedom
#> Multiple R-squared:  0.803,  Adjusted R-squared:  0.799
#> F-statistic: 199.7 on 1 and 49 DF,  p-value: < 2.2e-16
```

Only a few peptides have been used to fit the prior variance distribution in
\(\Sigma\), as we use a small subset from the original Ropers2021 dataset for
demonstration purpose. However, it is preferable
in general to use the full dataset for both hyperparameter and \(\Gamma\) estimation.

It gives the following imputed singletons:

```
mask.sing.pg = colSums(subropers$adj) == 1
mask.sing.pep = rowSums(subropers$adj[, mask.sing.pg]) >= 1
imp.res$data.imputed[, mask.sing.pep]
#>         NALPEGYAPAK__2 AIGIISNNPEFADVR__2 DLNIDPATLR__2
#> W1_1_MS       20.17349           17.16824      19.18247
#> W1_2_MS       19.79753           17.22690      18.50307
#> W1_3_MS       20.07592           17.55627      18.83505
#> W2_1_MS       19.82019           17.42375      18.47821
#> W2_2_MS       20.17537           17.13305      17.89070
#> W2_3_MS       20.36344           17.50759      18.18041
#> R1_1_MS       20.69017           16.07113      18.12682
#> R1_2_MS       20.70866           15.69265      18.03316
#> R1_3_MS       21.04542           15.95386      18.52355
#> R2_1_MS       20.95692           15.74802      18.49510
#> R2_2_MS       20.90775           15.87217      17.92845
#> R2_3_MS       21.20864           15.54108      18.24418
#> R3_1_MS       21.02669           15.70037      17.84178
#> R3_2_MS       21.10948           15.83535      17.34890
#> R3_3_MS       21.23109           15.81328      17.82134
#> R4_1_MS       20.83249           15.99160      17.28032
#> R4_2_MS       21.00524           16.14089      17.67013
#> R4_3_MS       20.57447           17.69123      17.33383
```

On the other hand, if proteomic and transcriptomic samples are not paired but
are derived from a same biological/experimental condition. Pirat-T can be used
by adapting the mask related to samples in each type of analysis (here, both
proteomic and transcriptomic datasets have 6 different conditions in the same
order with 3 replicates each):

```
imp.res = my_pipeline_llkimpute(subropers,
                             extension = "T",
                             rna.cond.mask = rep(seq(6), each = 3),
                             pep.cond.mask = rep(seq(6), each = 3),
                             max.pg.size.pirat.t = 1)
#>
#> Call:
#> stats::lm(formula = log(probs) ~ m_ab_sorted[seq(length(probs))])
#>
#> Residuals:
#>      Min       1Q   Median       3Q      Max
#> -1.40672 -0.15008  0.08833  0.28986  0.84125
#>
#> Coefficients:
#>                                 Estimate Std. Error t value Pr(>|t|)
#> (Intercept)                     14.40677    1.19049   12.10 2.48e-16 ***
#> m_ab_sorted[seq(length(probs))] -0.91419    0.06469  -14.13  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> Residual standard error: 0.4549 on 49 degrees of freedom
#> Multiple R-squared:  0.803,  Adjusted R-squared:  0.799
#> F-statistic: 199.7 on 1 and 49 DF,  p-value: < 2.2e-16
```

Also, it is possible to apply transcriptomic integration up to an arbitrary
size of PG, simply by
changing parameter `max.pg.size.pirat.t` in `my_pipeline_llkimpute()` to the
desired limit PG size (*e.g.* `+Inf` for whole dataset).

# 8 5. Session info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] Pirat_1.4.4      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [3] dir.expiry_1.18.0           xfun_0.54
#>  [5] bslib_0.9.0                 ggplot2_4.0.1
#>  [7] Biobase_2.70.0              lattice_0.22-7
#>  [9] vctrs_0.6.5                 tools_4.5.2
#> [11] generics_0.1.4              stats4_4.5.2
#> [13] parallel_4.5.2              tibble_3.3.0
#> [15] pkgconfig_2.0.3             Matrix_1.7-4
#> [17] RColorBrewer_1.1-3          S7_0.2.1
#> [19] S4Vectors_0.48.0            lifecycle_1.0.4
#> [21] compiler_4.5.2              farver_2.1.2
#> [23] progress_1.2.3              tinytex_0.58
#> [25] Seqinfo_1.0.0               htmltools_0.5.8.1
#> [27] sass_0.4.10                 yaml_2.3.10
#> [29] pillar_1.11.1               crayon_1.5.3
#> [31] jquerylib_0.1.4             MASS_7.3-65
#> [33] DelayedArray_0.36.0         cachem_1.1.0
#> [35] magick_2.9.0                abind_1.4-8
#> [37] basilisk_1.22.0             tidyselect_1.2.1
#> [39] digest_0.6.39               dplyr_1.1.4
#> [41] bookdown_0.45               labeling_0.4.3
#> [43] fastmap_1.2.0               grid_4.5.2
#> [45] cli_3.6.5                   invgamma_1.2
#> [47] SparseArray_1.10.3          magrittr_2.0.4
#> [49] S4Arrays_1.10.0             dichromat_2.0-0.1
#> [51] withr_3.0.2                 prettyunits_1.2.0
#> [53] filelock_1.0.3              scales_1.4.0
#> [55] rappdirs_0.3.3              rmarkdown_2.30
#> [57] XVector_0.50.0              matrixStats_1.5.0
#> [59] reticulate_1.44.1           png_0.1-8
#> [61] hms_1.1.4                   evaluate_1.0.5
#> [63] knitr_1.50                  GenomicRanges_1.62.0
#> [65] IRanges_2.44.0              rlang_1.1.6
#> [67] Rcpp_1.1.0                  glue_1.8.0
#> [69] BiocManager_1.30.27         BiocGenerics_0.56.0
#> [71] jsonlite_2.0.0              R6_2.6.1
#> [73] MatrixGenerics_1.22.0
```

# References

Chen, Lin S., Ross L. Prentice, and Pei Wang. 2014. “A penalized EM algorithm incorporating missing data mechanism for Gaussian parameter estimation.” *Biometrics* 70 (2): 312–22. <https://doi.org/10.1111/BIOM.12149>.

Etourneau, Lucas, Laura Fancello, Samuel Wieczorek, Nelle Varoquaux, and Thomas Burger. 2023. “A new take on missing value imputation for bottom-up label-free LC-MS/MS proteomics.” *bioRxiv*, January, 2023.11.09.566355. <https://doi.org/10.1101/2023.11.09.566355>.