# Identifying Biomarkers from an Exposure Variable with `biotmle`

Nima Hejazi

#### 2025-10-29

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Biomarker Identification](#biomarker-identification)
* [0.3 Visualization of Results](#visualization-of-results)
* [0.4 Session Information](#session-information)

## 0.1 Introduction

The `biotmle` R package can be used to isolate biomarkers in two ways: based
on the associations of genomic objects with an exposure variable of interest.
In this vignette, we illustrate how to use `biotmle` to isolate and visualize
genes associated with an **exposure**, using a data set containing microarray
expression measures from an Illumina platform. In the analysis described below,
targeted maximum likelihood estimation (TMLE) is used to transform the
microarray expression values based on the influence curve representation of the
Average Treatment Effect (ATE). Following this transformation, the moderated
t-statistic of Smyth (Smyth [2004](#ref-smyth2004linear)) is used to test for a binary group-wise
difference (based on the exposure variable), using the tools provided by the R
package [`limma`](https://bioconductor.org/packages/limma)).

For a general discussion of the framework of targeted maximum likelihood
estimation and the role this approach plays in statistical causal inference, the
interested reader is invited to consult van der Laan and Rose ([2011](#ref-vdl2011targeted)) and van der Laan and Rose ([2018](#ref-vdl2018targeted)).
For a more general introduction to the principles of statistical causal
inference, Pearl ([2000](#ref-pearl2000causality)) serves well.

---

## 0.2 Biomarker Identification

First, we load the `biotmle` package and the (included) `illuminaData` data set:

```
library(dplyr)
library(biotmle)
library(biotmleData)
library(BiocParallel)
library(SuperLearner)
library(SummarizedExperiment, quietly=TRUE)
data(illuminaData)
set.seed(13847)
```

In order to perform Targeted Minimum Loss-Based Estimation, we need three
separate data structures: (1) *W*, baseline covariates that could potentially
confound the association of biomarkers with the exposure of interest; (2) *A*,
the exposure of interest; and (3) *Y*, the biomarkers of interest. All values in
*W* and *A* ought to be discretized, in order to avoid practical violations of
the assumption of positivity. With the `illuminaData` data set below, we
discretize the age variable in the phenotype-level data below (this can be
accessed via the `colData` of the `SummarizedExperiment` object). To invoke the
biomarker assessment function (`biomarkertmle`), we also need to specify a
variable of interest (or the position of said variable in the design matrix). We
do both in just a few lines below:

```
# discretize "age" in the phenotype-level data
colData(illuminaData) <- colData(illuminaData) %>%
  data.frame %>%
  mutate(age = as.numeric(age > median(age))) %>%
  DataFrame
benz_idx <- which(names(colData(illuminaData)) %in% "benzene")
```

The TMLE-based biomarker discovery process can be invoked using the
`biomarkertmle` function. The procedure is quite resource-intensive because it
evaluates the association of each individual potential biomarker (of which there
are over 20,000 in the included data set) with an exposure of interest, while
accounting for potential confounding based on all other covariates included in
the design matrix. We demonstrate the necessary syntax for calling the
`biomarkertmle` function below, on a small number of the probes:

```
# compute TML estimates to evaluate differentially expressed biomarkers
biotmle_out <- biomarkertmle(se = illuminaData[1:20, ],
                             varInt = benz_idx,
                             g_lib = c("SL.mean", "SL.glm"),
                             Q_lib = c("SL.bayesglm", "SL.ranger"),
                             cv_folds = 2,
                             bppar_type = SerialParam()
                            )
```

```
##
  |
  |                                                                      |   0%
```

```
##
  |
  |======================================================================| 100%
```

Note that parallelization is controlled entirely through the [`BiocParallel`
package](https://bioconductor.org/packages/release/bioc/html/BiocParallel.html),
and we set `SerialParam()` here for *sequential* evaluation.

The output of `biomarkertmle` is an object of class `bioTMLE`, containing four
new slots: (1) `call`, the call to `biomarkertmle`; (2) `topTable`, an empty
slot meant to hold the output of `limma::topTable`, after a later call to
`modtest_ic`; and (3) `tmleOut`, a `data.frame` containing the point estimates
of the associations of each biomarker with the exposure of interest based on the
influence curve representation of the Average Treatment Effect.

The output of `biomarkertmle` can be directly fed to `modtest_ic`, a wrapper
around `limma::lmFit` and `limma::topTable` that outputs a `biotmle` object
with the slots described above completely filled in. The `modtest_ic` function
requires as input a `biotmle` object containing a data frame in the `tmleOut`
field as well as a design matrix indicating the groupwise difference to be
tested. The design matrix should contain an intercept term and a term for the
exposure of interest (with discretized exposure levels). *Based on the relevant
statistical theory, it is not appropriate to include any further terms in the
design matrix (n.b., this differs from standard calls to `limma::lmFit`)*.

```
modtmle_out <- modtest_ic(biotmle = biotmle_out)
```

After invoking `modtest_ic`, the resultant `bioTMLE` object will contain all
information relevant to the analytic procedure for identifying biomarkers: that
is, it will contain the original call to `biomarkertmle`, the result of running
`limma::topTable`, and the result of running `biomarkertmle`. The statistical
results of this procedure can be extracted from the `topTable` object in the
`bioTMLE` object produced by `modtest_ic`.

---

## 0.3 Visualization of Results

This package provides several plotting methods that can be used to visualize
the results of the TMLE-based biomarker discovery process. We demonstrate the
syntax for calling the generic plotting methods below but refrain from showing
the plots themselves since they are not particularly informative.

The `plot` method for a `bioTMLE` object will produce a histogram of the
adjusted p-values of each biomarker (based on the Benjamini-Hochberg procedure
for controlling the False Discovery Rate) as generated by `limma::topTable`:

```
plot(x = modtmle_out, type = "pvals_adj")
```

Setting the argument `type = "pvals_raw"` will instead produce a histogram of
the raw p-values *(these are less informative and should, in general, not be
used for inferential purposes, as the computation producing these p-values
ignores the multiple testing nature of the biomarker discovery problem)*:

```
plot(x = modtmle_out, type = "pvals_raw")
```

Heatmaps are useful graphics for visualizing the relationship between measures
on genomic objects and covariates of interest. The `heatmap_ic` function
provides this graphic for `bioTMLE` objects, allowing for the relationship
between the exposure variable and some number of “top” biomarkers (as
determined by the call to `modtest_ic`) to be visualized. In general, the
heatmap for `bioTMLE` objects expresses how the contributions of each biomarker
to the Average Treatment Effect (ATE) vary across differences in the exposure
variable (that is, there is a causal interpretation to the findings). The plot
produced is a `ggplot2` object and can be modified in place if stored properly.
For our analysis:

```
benz_idx <- which(names(colData(illuminaData)) %in% "benzene")
designVar <- as.data.frame(colData(illuminaData))[, benz_idx]
designVar <- as.numeric(designVar == max(designVar))

# build heatmap
heatmap_ic(x = modtmle_out, left.label = "none", scale = TRUE,
           clustering.method = "hierarchical", row.dendrogram = TRUE,
           design = designVar, FDRcutoff = 1, top = 10)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the superheat package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

The heatmap produced in this way is actually a form of *supervised clustering*,
as described more generally (as *supervised distance matrices*) by
Pollard and van der Laan ([2008](#ref-pollard2008supervised)), wherein the notion of deriving clustering procedures
from the results of supervised learning methods is formulated. Since the heatmap
is based on the contributions of observations to the efficient influence
function (EIF) of the target parameter, it directly visualizes the degree to
which each biomarker informs the difference (due to the treatment effect)
represented by the average treatment effect.

The volcano plot is standard graphical tools for examining how changes in
expression relate to the raw p-value. The utility of such plots lies in their
providing a convenient way to identify and systematically ignore those genomic
objects that have extremely low p-values due to extremely low variance between
observations. The `volcano_ic` function provides much of the same
interpretation, except that the fold change values displayed in the x-axis refer
to changes in the *contributions of each biomarker to the Average Treatment
Effect* (in standard practice, for microarray technology, these would be fold
changes in gene expression). The plot produced is a `ggplot2` object and, as
such, can be modified in place. For our analysis:

```
volcano_ic(biotmle = modtmle_out)
```

![](data:image/png;base64...)

---

## 0.4 Session Information

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
## [1] stats4    splines   stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] nloptr_2.2.1                quadprog_1.5-8
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] SuperLearner_2.0-29         gam_1.22-6
## [15] foreach_1.5.2               nnls_1.6
## [17] BiocParallel_1.44.0         biotmleData_1.33.0
## [19] biotmle_1.34.0              dplyr_1.1.4
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    farver_2.1.2        S7_0.2.0
##  [4] fastmap_1.2.0       superheat_0.1.0     digest_0.6.37
##  [7] lifecycle_1.0.4     survival_3.8-3      statmod_1.5.1
## [10] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
## [13] sass_0.4.10         tools_4.5.1         yaml_2.3.10
## [16] knitr_1.50          labeling_0.4.3      S4Arrays_1.10.0
## [19] DelayedArray_0.36.0 RColorBrewer_1.1-3  abind_1.4-8
## [22] withr_3.0.2         grid_4.5.1          np_0.60-18
## [25] future_1.67.0       ggplot2_4.0.0       globals_0.18.0
## [28] scales_1.4.0        iterators_1.0.14    MASS_7.3-65
## [31] tinytex_0.57        dichromat_2.0-0.1   cli_3.6.5
## [34] crayon_1.5.3        rmarkdown_2.30      reformulas_0.4.2
## [37] future.apply_1.20.0 minqa_1.2.8         cachem_1.1.0
## [40] assertthat_0.2.1    parallel_4.5.1      BiocManager_1.30.26
## [43] XVector_0.50.0      vctrs_0.6.5         boot_1.3-32
## [46] Matrix_1.7-4        jsonlite_2.0.0      SparseM_1.84-2
## [49] bookdown_0.45       listenv_0.9.1       magick_2.9.0
## [52] limma_3.66.0        jquerylib_0.1.4     ggdendro_0.2.0
## [55] glue_1.8.0          parallelly_1.45.1   codetools_0.2-20
## [58] cubature_2.1.4      gtable_0.3.6        lme4_1.1-37
## [61] tibble_3.3.0        pillar_1.11.1       htmltools_0.5.8.1
## [64] quantreg_6.1        R6_2.6.1            Rdpack_2.6.4
## [67] evaluate_1.0.5      drtmle_1.1.2        lattice_0.22-7
## [70] rbibutils_2.3       arm_1.14-4          ggsci_4.1.0
## [73] bslib_0.9.0         MatrixModels_0.5-4  Rcpp_1.1.0
## [76] nlme_3.1-168        coda_0.19-4.1       SparseArray_1.10.0
## [79] ranger_0.17.0       xfun_0.53           pkgconfig_2.0.3
```

Pearl, Judea. 2000. *Causality: Models, Reasoning, and Inference*. Cambridge University Press.

Pollard, Katherine S, and Mark J van der Laan. 2008. “Supervised Distance Matrices.” *Statistical Applications in Genetics and Molecular Biology* 7 (1).

Smyth, Gordon K. 2004. “Linear Models and Empirical Bayes Methods for Assessing Differential Expression in Microarray Experiments.” *Statistical Applications in Genetics and Molecular Biology* 3 (1): 1–25. <https://doi.org/10.2202/1544-6115.1027>.

van der Laan, Mark J., and Sherri Rose. 2011. *Targeted Learning: Causal Inference for Observational and Experimental Data*. Springer Science & Business Media.

van der Laan, Mark J, and Sherri Rose. 2018. *Targeted Learning in Data Science: Causal Inference for Complex Longitudinal Studies*. Springer Science & Business Media.