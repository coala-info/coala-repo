# CytoGLMM Workflow

Christof Seiler

Department of Statistics, Stanford University & Department of Data Science and Knowledge Engineering, Maastricht University

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Prepare Simulated Data](#prepare-simulated-data)
* [3 GLM](#glm)
* [4 GLMM](#glmm)
* [Session Info](#session-info)
* [References](#references)

# 1 Introduction

Flow and mass cytometry are important modern immunology tools for measuring expression levels of multiple proteins on single cells. The goal is to better understand the mechanisms of responses on a single cell basis by studying differential expression of proteins. Most current data analysis tools compare expressions across many computationally discovered cell types. Our goal is to focus on just one cell type. Differential analysis of marker expressions can be difficult due to marker correlations and inter-subject heterogeneity, particularly for studies of human immunology. We address these challenges with two multiple regression strategies: A bootstrapped generalized linear model (GLM) and a generalized linear mixed model (GLMM). Here, we illustrate the `CytoGLMM` *R* package and workflow for simulated mass cytometry data.

# 2 Prepare Simulated Data

We construct our simulated datasets by sampling from a Poisson GLM. We confirmed—with predictive posterior checks—that Poisson GLMs with mixed effects provide a good fit to mass cytometry data (Seiler et al. [2019](#ref-seiler2019uncertainty)). We consider one underlying data generating mechanisms described by a hierarchical model for the \(i\)th cell and \(j\)th donor:

\[
\begin{aligned}
\boldsymbol{X}\_{ij} & \sim \text{Poisson}(\boldsymbol{\lambda}\_{ij}) \\
\log(\boldsymbol{\lambda}\_{ij}) & = \boldsymbol{B}\_{ij} + \boldsymbol{U}\_j \\
\boldsymbol{B}\_{ij} & \sim
\begin{cases}
\text{Normal}(\boldsymbol{\delta}^{(0)}, \boldsymbol{\Sigma}\_B) & \text{if } Y\_{ij} = 0, \text{ cell unstimulated} \\
\text{Normal}(\boldsymbol{\delta}^{(1)}, \boldsymbol{\Sigma}\_B) & \text{if } Y\_{ij} = 1, \text{ cell stimulated}
\end{cases} \\
\boldsymbol{U}\_j & \sim \text{Normal}(\boldsymbol{0}, \boldsymbol{\Sigma}\_U).
\end{aligned}
\]

The following graphic shows a representation of the hierarchical model.

![](data:image/svg+xml;base64...)

The stimulus activates proteins and induces a difference in marker expression. We define the effect size to be the difference between expected expression levels of stimulated versus unstimulated cells on the \(\log\)-scale. All markers that belong to the active set , have a non-zero effect size, whereas, all markers that are not, have a zero effect size:

\[
\begin{cases}
\delta^{(1)}\_p - \delta^{(0)}\_p > 0 & \text{if protein } p \text{ is in activation set } p \in C \\
\delta^{(1)}\_{p'} - \delta^{(0)}\_{p'} = 0 & \text{if protein } p' \text{ is not in activation set } p' \notin C.
\end{cases}
\]

Both covariance matrices have an autoregressive structure,

\[
\begin{aligned}
\Omega\_{rs} & = \rho^{|r-s|} \\
\boldsymbol{\Sigma} & = \operatorname{diag}(\boldsymbol{\sigma}) \, \boldsymbol{\Omega} \, \operatorname{diag}(\boldsymbol{\sigma}),
\end{aligned}
\]

where \(\Omega\_{rs}\) is the \(r\)th row and \(s\)th column of the correlation matrix \(\boldsymbol{\Omega}\). We regulate two separate correlation parameters: a cell-level \(\rho\_B\) and a donor-level \(\rho\_U\) coefficient. Non-zero \(\rho\_B\) or \(\rho\_U\) induce a correlation between condition and marker expression even for markers with a zero effect size.

```
library("CytoGLMM")
set.seed(23)
df <- generate_data()
df[1:5,1:5]
```

```
## # A tibble: 5 × 5
##   donor condition   m01   m02   m03
##   <int> <fct>     <int> <int> <int>
## 1     1 treatment     2   127   116
## 2     1 treatment     0    96    54
## 3     1 treatment     1    14    52
## 4     1 treatment     6    20    34
## 5     1 treatment    18    30    15
```

We define the marker names that we will focus on in our analysis by extracting them from the simulated data frame.

```
protein_names <- names(df)[3:12]
```

We recommend that marker expressions be corrected for batch effects (Nowicka et al. [2017](#ref-nowicka2017cytof); Chevrier et al. [2018](#ref-chevrier2018compensation); Schuyler et al. [2019](#ref-schuyler2019minimizing); Van Gassen et al. [2020](#ref-van2020cytonorm); Trussart et al. [2020](#ref-trussart2020removing)) and transformed using variance stabilizing transformations to account for heteroskedasticity, for instance with an inverse hyperbolic sine transformation with the cofactor set to 150 for flow cytometry, and 5 for mass cytometry (Bendall et al. [2011](#ref-bendall2011single)). This transformation assumes a two-component model for the measurement error (Rocke and Lorenzato [1995](#ref-rocke1995two); Huber et al. [2003](#ref-huber2003parameter)) where small counts are less noisy than large counts. Intuitively, this corresponds to a noise model with additive and multiplicative noise depending on the magnitude of the marker expression; see (Holmes and Huber [2019](#ref-holmes2019modern)) for details.

```
df <- dplyr::mutate_at(df, protein_names, function(x) asinh(x/5))
```

# 3 GLM

The goal of the `CytoGLMM::cytoglm` function is to find protein expression patterns that are associated with the condition of interest, such as a response to a stimulus. We set up the GLM to predict the experimental condition (`condition`) from protein marker expressions (`protein_names`), thus our experimental conditions are response variables and marker expressions are explanatory variables.

```
glm_fit <- CytoGLMM::cytoglm(df,
                             protein_names = protein_names,
                             condition = "condition",
                             group = "donor",
                             num_cores = 1,
                             num_boot = 1000)
glm_fit
```

```
##
## #######################
## ## paired analysis ####
## #######################
##
## number of bootstrap samples: 1000
##
## number of cells per group and condition:
##     control treatment
##   1    1000      1000
##   2    1000      1000
##   3    1000      1000
##   4    1000      1000
##   5    1000      1000
##   6    1000      1000
##   7    1000      1000
##   8    1000      1000
##
## proteins included in the analysis:
##  m01 m02 m03 m04 m05 m06 m07 m08 m09 m10
##
## condition compared: condition
## grouping variable: donor
```

We plot the maximum likelihood estimates with 95% confidence intervals for the fixed effects \(\boldsymbol{\beta}\). The estimates are on the \(\log\)-odds scale. We see that markers m1, m2, and m3 are strong predictors of the treatment. This means that one unit increase in the transformed marker expression makes it more likely to be a cell from the treatment group, while holding the other markers constant.

```
plot(glm_fit)
```

![](data:image/png;base64...)

The `summary` function returns a table about the model fit with unadjusted and Benjamini-Hochberg (BH) adjusted \(p\)-values.

```
summary(glm_fit)
```

```
## # A tibble: 10 × 3
##    protein_name pvalues_unadj pvalues_adj
##    <chr>                <dbl>       <dbl>
##  1 m02                  0.002      0.02
##  2 m03                  0.004      0.02
##  3 m01                  0.028      0.0933
##  4 m06                  0.354      0.852
##  5 m04                  0.466      0.852
##  6 m08                  0.566      0.852
##  7 m09                  0.658      0.852
##  8 m05                  0.682      0.852
##  9 m10                  0.842      0.924
## 10 m07                  0.924      0.924
```

We can extract the proteins below an False Discovery Rate (FDR) of 0.1 from the \(p\)-value table by filtering the table.

```
summary(glm_fit) |> dplyr::filter(pvalues_adj < 0.1)
```

```
## # A tibble: 3 × 3
##   protein_name pvalues_unadj pvalues_adj
##   <chr>                <dbl>       <dbl>
## 1 m02                  0.002      0.02
## 2 m03                  0.004      0.02
## 3 m01                  0.028      0.0933
```

# 4 GLMM

In the `CytoGLMM::cytoglmm` function, we make additional modeling assumptions by adding a random effect term in the standard logistic regression model to account for the subject effect (`group`). In paired experimental design—when the same donor provides two samples, one for each condition—`CytoGLMM::cytoglmm` is statistically more powerful.

```
glmm_fit <- CytoGLMM::cytoglmm(df,
                               protein_names = protein_names,
                               condition = "condition",
                               group = "donor",
                               num_cores = 1)
glmm_fit
```

```
## number of cells per group and condition:
##     control treatment
##   1    1000      1000
##   2    1000      1000
##   3    1000      1000
##   4    1000      1000
##   5    1000      1000
##   6    1000      1000
##   7    1000      1000
##   8    1000      1000
##
## proteins included in the analysis:
##  m01 m02 m03 m04 m05 m06 m07 m08 m09 m10
##
## condition compared: condition
## grouping variable: donor
```

We plot the method of moments estimates with 95% confidence intervals for the fixed effects \(\boldsymbol{\beta}\).

```
plot(glmm_fit)
```

![](data:image/png;base64...)

The `summary` function returns a table about the model fit with unadjusted and BH adjusted \(p\)-values.

```
summary(glmm_fit)
```

```
## # A tibble: 10 × 3
##    protein_name pvalues_unadj pvalues_adj
##    <chr>                <dbl>       <dbl>
##  1 m03              0.0000682    0.000682
##  2 m02              0.000163     0.000813
##  3 m01              0.000681     0.00227
##  4 m06              0.155        0.388
##  5 m05              0.371        0.646
##  6 m08              0.388        0.646
##  7 m04              0.512        0.731
##  8 m09              0.859        0.954
##  9 m10              0.874        0.954
## 10 m07              0.954        0.954
```

We can extract the proteins below an FDR of 0.1 from the \(p\)-value table by filtering the table.

```
summary(glmm_fit) |> dplyr::filter(pvalues_adj < 0.1)
```

```
## # A tibble: 3 × 3
##   protein_name pvalues_unadj pvalues_adj
##   <chr>                <dbl>       <dbl>
## 1 m03              0.0000682    0.000682
## 2 m02              0.000163     0.000813
## 3 m01              0.000681     0.00227
```

We performed extensive power simulations and comparisons to other methods in Seiler et al. ([2021](#ref-seiler2021cytoglmm)).

# Session Info

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
## [1] CytoGLMM_1.18.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] Rdpack_2.6.4         pROC_1.19.0.1        mbest_0.6.1
##   [4] sandwich_3.1-1       rlang_1.1.6          magrittr_2.0.4
##   [7] compiler_4.5.1       flexmix_2.3-20       vctrs_0.6.5
##  [10] reshape2_1.4.4       stringr_1.5.2        pkgconfig_2.0.3
##  [13] fastmap_1.2.0        magick_2.9.0         labeling_0.4.3
##  [16] utf8_1.2.6           rmarkdown_2.30       prodlim_2025.04.28
##  [19] tinytex_0.57         purrr_1.1.0          xfun_0.53
##  [22] modeltools_0.2-24    cachem_1.1.0         jsonlite_2.0.0
##  [25] recipes_1.3.1        uuid_1.2-1           BiocParallel_1.44.0
##  [28] parallel_4.5.1       R6_2.6.1             bslib_0.9.0
##  [31] stringi_1.8.7        RColorBrewer_1.1-3   parallelly_1.45.1
##  [34] rpart_4.1.24         lubridate_1.9.4      jquerylib_0.1.4
##  [37] Rcpp_1.1.0           bookdown_0.45        iterators_1.0.14
##  [40] knitr_1.50           future.apply_1.20.0  zoo_1.8-14
##  [43] Matrix_1.7-4         splines_4.5.1        nnet_7.3-20
##  [46] timechange_0.3.0     tidyselect_1.2.1     dichromat_2.0-0.1
##  [49] abind_1.4-8          yaml_2.3.10          timeDate_4051.111
##  [52] doParallel_1.0.17    codetools_0.2-20     listenv_0.9.1
##  [55] lattice_0.22-7       tibble_3.3.0         plyr_1.8.9
##  [58] withr_3.0.2          S7_0.2.0             evaluate_1.0.5
##  [61] future_1.67.0        survival_3.8-3       pillar_1.11.1
##  [64] BiocManager_1.30.26  foreach_1.5.2        stats4_4.5.1
##  [67] reformulas_0.4.2     generics_0.1.4       ggplot2_4.0.0
##  [70] scales_1.4.0         globals_0.18.0       class_7.3-23
##  [73] glue_1.8.0           pheatmap_1.0.13      tools_4.5.1
##  [76] data.table_1.17.8    ModelMetrics_1.2.2.2 gower_1.0.2
##  [79] cowplot_1.2.0        grid_4.5.1           bigmemory_4.6.4
##  [82] tidyr_1.3.1          rbibutils_2.3        ipred_0.9-15
##  [85] nlme_3.1-168         cli_3.6.5            bigmemory.sri_0.1.8
##  [88] lava_1.8.1           dplyr_1.1.4          strucchange_1.5-4
##  [91] gtable_0.3.6         logging_0.10-108     sass_0.4.10
##  [94] digest_0.6.37        caret_7.0-1          ggrepel_0.9.6
##  [97] farver_2.1.2         htmltools_0.5.8.1    lifecycle_1.0.4
## [100] factoextra_1.0.7     hardhat_1.4.2        MASS_7.3-65
```

# References

Bendall, Sean C, Erin F Simonds, Peng Qiu, D Amir El-ad, Peter O Krutzik, Rachel Finck, Robert V Bruggner, et al. 2011. “Single-Cell Mass Cytometry of Differential Immune and Drug Responses Across a Human Hematopoietic Continuum.” *Science* 332 (6030): 687–96.

Chevrier, Stéphane, Helena L Crowell, Vito RT Zanotelli, Stefanie Engler, Mark D Robinson, and Bernd Bodenmiller. 2018. “Compensation of Signal Spillover in Suspension and Imaging Mass Cytometry.” *Cell Systems* 6 (5): 612–20.

Holmes, Susan, and Wolfgang Huber. 2019. *Modern Statistics for Modern Biology*. Cambridge University Press.

Huber, Wolfgang, Anja von Heydebreck, Holger Sültmann, Annemarie Poustka, and Martin Vingron. 2003. “Parameter Estimation for the Calibration and Variance Stabilization of Microarray Data.” *Statistical Applications in Genetics and Molecular Biology* 2 (1).

Nowicka, M, C Krieg, LM Weber, FJ Hartmann, S Guglietta, B Becher, MP Levesque, and MD Robinson. 2017. “CyTOF Workflow: Differential Discovery in High-Throughput High-Dimensional Cytometry Datasets [Version 2; Referees: 2 Approved].” *F1000Research* 6 (748).

Rocke, David M, and Stefan Lorenzato. 1995. “A Two-Component Model for Measurement Error in Analytical Chemistry.” *Technometrics* 37 (2): 176–84.

Schuyler, Ronald P., Conner Jackson, Josselyn E. Garcia-Perez, Ryan M. Baxter, Sidney Ogolla, Rosemary Rochford, Debashis Ghosh, Pratyaydipta Rudra, and Elena W. Y. Hsieh. 2019. “Minimizing Batch Effects in Mass Cytometry Data.” *Frontiers in Immunology* 10: 2367.

Seiler, Christof, Anne-Maud Ferreira, Lisa M Kronstad, Laura J Simpson, Mathieu Le Gars, Elena Vendrame, Catherine A Blish, and Susan Holmes. 2021. “CytoGLMM: Conditional Differential Analysis for Flow and Mass Cytometry Experiments.” *BMC Bioinformatics* 22 (137): 1–14.

Seiler, Christof, Lisa M Kronstad, Laura J Simpson, Mathieu Le Gars, Elena Vendrame, Catherine A Blish, and Susan Holmes. 2019. “Uncertainty Quantification in Multivariate Mixed Models for Mass Cytometry Data.” *arXiv:1903.07976*.

Trussart, Marie, Charis E Teh, Tania Tan, Lawrence Leong, Daniel HD Gray, and Terence P Speed. 2020. “Removing Unwanted Variation with CytofRUV to Integrate Multiple CyTOF Datasets.” *eLife* 9 (September): e59630.

Van Gassen, Sofie, Brice Gaudilliere, Martin S Angst, Yvan Saeys, and Nima Aghaeepour. 2020. “CytoNorm: A Normalization Algorithm for Cytometry Data.” *Cytometry Part A* 97 (3): 268–78.