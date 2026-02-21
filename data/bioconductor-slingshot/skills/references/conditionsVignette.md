# Differential Topology: Comparing Conditions along a Trajectory

Kelly Street and Koen Van den Berge

#### 2025-10-30

# Contents

* [1 Deprecation Notice](#deprecation-notice)
* [2 Problem Statement](#problem-statement)
* [3 Methods](#methods)
  + [3.1 Trajectory Inference](#trajectory-inference)
  + [3.2 Approach 1: Distributional Differences](#approach-1-distributional-differences)
    - [3.2.1 Permutation Test](#permutation-test)
    - [3.2.2 Kolmogorov-Smirnov Test](#kolmogorov-smirnov-test)
  + [3.3 Approach 2: Condition Imbalance](#approach-2-condition-imbalance)
    - [3.3.1 Logistic Regression](#logistic-regression)
    - [3.3.2 Additive Logistic Regression](#additive-logistic-regression)
    - [3.3.3 `tradeSeq`-like](#tradeseq-like)
  + [3.4 Other Approaches](#other-approaches)
* [4 Parting Words](#parting-words)
* [5 Session Info](#session-info)

# 1 Deprecation Notice

This vignette represents some of our very early thinking on these topics, which
has since developed significantly. For more up-to-date recommendations, we
strongly encourage you to check out our workflow
[here](https://kstreet13.github.io/bioc2020trajectories/articles/workshopTrajectories.html),
or either of our presentations from [BioC
2020](https://www.youtube.com/watch?v=Fbd08bIv4yk) and
[EuroBioc2020](https://www.youtube.com/watch?v=4NwIbsJ9lMI). We also recommend
checking out our upcoming package, `condiments`, which implements these concepts
and more!

# 2 Problem Statement

This vignette is designed to help you think about the problem of trajectory inference in the presence of two or more conditions. These conditions may be thought of as an organism-level status with potential effects on the lineage topology, ie. “case vs. control” or “mutant vs. wild-type.” While some such conditions may induce global changes in cell composition or cell state, we will assume that at least some cell types along the trajectory of interest remain comparable between conditions.

# 3 Methods

While it may seem reasonable to perform trajectory inference separately on cells from our different conditions, this is problematic for two reasons: 1) inferred trajectories will be less stable, as they would use only a subset of the available data, and 2) there would be no straightforward method for combining these results (eg. how would we map a branching trajectory onto a non-branching trajectory?).

Therefore, we propose the following workflow: first, use all available cells to construct the most stable trajectory possible. Second, use this common trajectory framework to compare distributions of cells from different conditions. We will demonstrate this process on an example dataset.

```
data('slingshotExample')
rd <- slingshotExample$rd
cl <- slingshotExample$cl
condition <- factor(rep(c('A','B'), length.out = nrow(rd)))
condition[110:140] <- 'A'
ls()
```

```
## [1] "cl"               "condition"        "rd"               "slingshotExample"
```

![](data:image/png;base64...)

This dataset consists of a branching trajectory with two conditions (`A` and `B`). Under condition `A`, we find cells from all possible states along the trajectory, but under condition `B`, one of the branches is blocked and only one terminal state can be reached.

## 3.1 Trajectory Inference

We will start by performing trajectory inference on the full dataset. In principle, any method could be used here, but we will use `slingshot` (cf. [PopGenGoogling](https://twitter.com/popgengoogling/status/1065022894659592192)).

```
pto <- slingshot(rd, cl)
```

![](data:image/png;base64...)

Each cell has now been assigned to one or two lineages (with an associated weight indicating the certainty of each assignment) and pseudotime values have been calculated.

![](data:image/png;base64...)

## 3.2 Approach 1: Distributional Differences

![](data:image/png;base64...)

Now that we have the trajectory, we are interested in testing for differences between the conditions. Any difference in the distributions of cells along a lineage may be meaningful, as it may indicate an overabundance of a particular cell type(s) in one condition. Thus, for this paradigm, we ultimately recommend a Kolmogorov-Smirnov test for detecting differences in the distributions of cells along a lineage. However, we will begin with an illustrative example of testing for a location shift.

### 3.2.1 Permutation Test

A T-test would work for this, but we’ll use a slightly more robust permutation test. Specifically, we will look for a difference in the weighted means of the pseudotime values between the two conditions.

```
# Permutation test
t1 <- slingPseudotime(pto, na=FALSE)[,1]
w1 <- slingCurveWeights(pto)[,1]
d1 <- weighted.mean(t1[condition=='A'], w1[condition=='A']) -
    weighted.mean(t1[condition=='B'], w1[condition=='B'])
dist1 <- replicate(1e4, {
    condition.i <- sample(condition)
    weighted.mean(t1[condition.i=='A'], w1[condition.i=='A']) -
        weighted.mean(t1[condition.i=='B'], w1[condition.i=='B'])
})
```

![](data:image/png;base64...)

```
paste0('Lineage 1 p-value: ', mean(abs(dist1) > abs(d1)))
```

```
## [1] "Lineage 1 p-value: 0.9357"
```

```
paste0('Lineage 2 p-value: ', mean(abs(dist2) > abs(d2)))
```

```
## [1] "Lineage 2 p-value: 0"
```

As we would expect, we see a significant difference in the second lineage (where condition `B` is impeded), but not in the first. However, because the two conditions have different distributions along the second lineage, the exchangeability assumption is violated and the resulting p-value is not valid.

### 3.2.2 Kolmogorov-Smirnov Test

Another, more general approach we could take to test for a difference in distributions would be the Kolmogorov-Smirnov test (or a similar permutation test using that test’s statistic). This test would, in theory, allow us to pick up subtler differences between the conditions, such as an overabundance of a cell type in one condition.

```
# Kolmogorov-Smirnov test
ks.test(slingPseudotime(pto)[condition=='A',1], slingPseudotime(pto)[condition=='B',1])
```

```
##
##  Exact two-sample Kolmogorov-Smirnov test
##
## data:  slingPseudotime(pto)[condition == "A", 1] and slingPseudotime(pto)[condition == "B", 1]
## D = 0.081119, p-value = 0.9852
## alternative hypothesis: two-sided
```

```
ks.test(slingPseudotime(pto)[condition=='A',2], slingPseudotime(pto)[condition=='B',2])
```

```
##
##  Exact two-sample Kolmogorov-Smirnov test
##
## data:  slingPseudotime(pto)[condition == "A", 2] and slingPseudotime(pto)[condition == "B", 2]
## D = 0.42254, p-value = 0.0001851
## alternative hypothesis: two-sided
```

Again, we see a significant difference in the second lineage, but not in the first. Note that unlike the difference of weighted means we used above, this test largely ignores the weights which assign cells to lineages, using any cell with a lineage weight greater than 0 (those with weights of zero are assigned pseudotime values of `NA`). Theoretically, one could use weights with the Kolmogorov-Smirnov test, as the test statistic is based on the maximum difference between cumulative distribution functions, but we were unable to find an implementation of this in base `R` or the `stats` package. For more stringent cutoffs, the user could specify a minimum lineage weight, say of 0.5. Due to this test’s ability to detect a wide variety of differences, we would recommend it over the previous procedure for general purpose use.

## 3.3 Approach 2: Condition Imbalance

Below, the problem is somewhat rephrased as compared to the approaches used above. Whereas the permutation and KS tests were testing within-lineage differences in **pseudotime values** between conditions, the approaches suggested below rather test for within-lineage **condition imbalance** along the progression of pseudotime.

The advantages of this approach would be:

* more straightforward comparison between lineages.
* identification of pseudotime regions where the distribution of conditions is skewed.
* automatic adjustment for baseline condition probabilities as determined by the inception of the trajectory (for example, if one condition naturally has 80% of cells and the other has 20%, which could then evolve to a different proportion as pseudotime progresses). Note that the approaches above could also handle this, but they do not directly estimate a change in contribution for the conditions (e.g. you won’t be able to say that you went from 75% condition A to 50% condition A, only that something’s happened).

Its disadvantages, however, are:

* requiring explicit distributional assumptions.
* possibly more difficult to extend to assessing shifts in other moments than the mean (e.g. variance).

### 3.3.1 Logistic Regression

As a first approach, one might check whether the probability of having a cell from a particular condition changes across pseudotime in any lineage. For two conditions, this may proceed using binomial logistic regression, which might be extended to multinomial logistic regression for multiple conditions. To loosen the restrictive binomial assumption, we allow for a more flexible variance structure by using a quasibinomial model.

```
pt <- slingPseudotime(pto, na=FALSE)
cw <- slingCurveWeights(pto)
assignment <- apply(cw, 1, which.max)
ptAs <- c() #assigned pseudotime
for(ii in 1:nrow(pt)) ptAs[ii] <- pt[ii,assignment[ii]]
```

![](data:image/png;base64...)

```
# model for lineage 1: not significant
cond1 <- factor(condition[assignment == 1])
t1 <- ptAs[assignment == 1]
m1 <- glm(cond1 ~ t1, family = quasibinomial(link = "logit"))
summary(m1)
```

```
##
## Call:
## glm(formula = cond1 ~ t1, family = quasibinomial(link = "logit"))
##
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept) -0.017048   0.389350  -0.044    0.965
## t1           0.002756   0.051836   0.053    0.958
##
## (Dispersion parameter for quasibinomial family taken to be 1.02439)
##
##     Null deviance: 116.45  on 83  degrees of freedom
## Residual deviance: 116.45  on 82  degrees of freedom
## AIC: NA
##
## Number of Fisher Scoring iterations: 3
```

```
# model for lineage 2: significant
cond2 <- factor(condition[assignment == 2])
t2 <- ptAs[assignment == 2]
m2 <- glm(cond2 ~ t2, family = quasibinomial(link = "logit"))
summary(m2)
```

```
##
## Call:
## glm(formula = cond2 ~ t2, family = quasibinomial(link = "logit"))
##
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   1.0700     0.6403   1.671 0.100476
## t2           -0.3666     0.1021  -3.591 0.000712 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## (Dispersion parameter for quasibinomial family taken to be 0.7448419)
##
##     Null deviance: 58.193  on 55  degrees of freedom
## Residual deviance: 44.309  on 54  degrees of freedom
## AIC: NA
##
## Number of Fisher Scoring iterations: 5
```

### 3.3.2 Additive Logistic Regression

Advantages:

* By extending the linearity assumption, this approach can detect more subtle patterns, e.g. intermediate regions of a lineage that lack cells from a particular condition. This would be reflected by a bimodal distribution of pseudotimes for that condition.
* Also easily extends to multiple conditions using multinomial additive models.

```
### note that logistic regression is monotone hence only allows for increasing or decreasing proportion of cells for a particular condition.
### hence, for complex trajectories, you could consider smoothing the pseudotime, i.e.
require(mgcv, quietly = TRUE)
```

```
##
## Attaching package: 'nlme'
```

```
## The following object is masked from 'package:IRanges':
##
##     collapse
```

```
## This is mgcv 1.9-3. For overview type 'help("mgcv-package")'.
```

```
m1s <- mgcv::gam(cond1 ~ s(t1), family="quasibinomial")
summary(m1s)
```

```
##
## Family: quasibinomial
## Link function: logit
##
## Formula:
## cond1 ~ s(t1)
##
## Parametric coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept) 6.526e-08  2.209e-01       0        1
##
## Approximate significance of smooth terms:
##       edf Ref.df     F p-value
## s(t1)   1      1 0.003   0.958
##
## R-sq.(adj) =  -0.0122   Deviance explained = 0.00249%
## GCV = 1.4547  Scale est. = 1.0244    n = 84
```

```
m2s <- mgcv::gam(cond2 ~ s(t2), family="quasibinomial")
summary(m2s)
```

```
##
## Family: quasibinomial
## Link function: logit
##
## Formula:
## cond2 ~ s(t2)
##
## Parametric coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -3.349      1.897  -1.765   0.0834 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Approximate significance of smooth terms:
##         edf Ref.df     F p-value
## s(t2) 2.751  3.456 1.337   0.325
##
## R-sq.(adj) =  0.244   Deviance explained = 33.2%
## GCV = 0.79718  Scale est. = 1.0718    n = 56
```

![](data:image/png;base64...)

### 3.3.3 `tradeSeq`-like

[With apologies](https://en.wiktionary.org/wiki/if_all_you_have_is_a_hammer%2C_everything_looks_like_a_nail), suppose that the probability of a particular condition decreases in both lineages, but moreso in one than the other. This can be obscured with the above approaches, especially if the lineages have different lengths. In that case, it would be informative to compare the lineages directly. We can accomplish this goal with an additive model.

The code below fits an additive model with smoothing terms for the pseudotimes along each lineage. The smoothers may be directly compared since we require the same penalization and basis functions (by setting `id = 1`). Based on the fitted model, inference would be exactly like we do in `tradeSeq`.

```
t1 <- pt[,1]
t2 <- pt[,2]
l1 <- as.numeric(assignment == 1)
l2 <- as.numeric(assignment == 2)
m <- gam(condition ~ s(t1, by=l1, id=1) + s(t2, by=l2, id=1),
         family = quasibinomial(link = "logit"))
summary(m)
```

```
##
## Family: quasibinomial
## Link function: logit
##
## Formula:
## condition ~ s(t1, by = l1, id = 1) + s(t2, by = l2, id = 1)
##
## Parametric coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept) -3.347e-05  2.215e-01       0        1
##
## Approximate significance of smooth terms:
##          edf Ref.df     F p-value
## s(t1):l1   1      1 0.003 0.95821
## s(t2):l2   2      2 6.787 0.00155 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Rank: 20/21
## R-sq.(adj) =   0.12   Deviance explained = 13.9%
## GCV = 1.2168  Scale est. = 1.0294    n = 140
```

```
### and then we're back to tradeSeq-like inference ...
```

![](data:image/png;base64...)

## 3.4 Other Approaches

The frameworks suggested here are only a few of the many possible approaches to a highly complex problem.

We can envision another potential approach, similar to the `Condition Imbalance` framework, but requiring fewer parametric assumptions, inspired by the batch effect metric of [Büttner, et al. (2019)](https://www.nature.com/articles/s41592-018-0254-1) (see Figure 1). Essentially, we may be able to march along the trajectory and check for condition imbalance in a series of local neighborhoods, defined by the k nearest neighbors of particular cells.

# 4 Parting Words

For both of the above procedures, it is important to note that we are making multiple comparisons (in this case, 2). The p-values we obtain from these tests should be corrected for multiple testing, especially for trajectories with a large number of lineages.

That said, trajectory inference is often one of the last computational methods in a very long analysis pipeline (generally including gene-level quantification, gene filtering / feature selection, and dimensionality reduction). Hence, we strongly discourage the reader from putting too much faith in any p-value that comes out of this analysis. Such values may be useful suggestions, indicating particular features or cells for follow-up study, but should not be treated as meaningful statistical quantities.

Finally, we would like to emphasize that these procedures are merely suggestions which have not (yet) been subjected to extensive testing and revision. If you have any ideas, questions, or results that you are willing to share, we would love to hear them! Feel free to email Kelly Street or open an issue on either the [`slingshot` repo](https://github.com/kstreet13/slingshot) or [`tradeSeq` repo](https://github.com/statOmics/tradeSeq) on GitHub.

# 5 Session Info

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
##  [1] mgcv_1.9-3                  nlme_3.1-168
##  [3] RColorBrewer_1.1-3          slingshot_2.18.0
##  [5] TrajectoryUtils_1.18.0      princurve_2.1.6
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10               SparseArray_1.10.0
##  [3] lattice_0.22-7            digest_0.6.37
##  [5] magrittr_2.0.4            evaluate_1.0.5
##  [7] sparseMatrixStats_1.22.0  grid_4.5.1
##  [9] bookdown_0.45             fastmap_1.2.0
## [11] jsonlite_2.0.0            Matrix_1.7-4
## [13] tinytex_0.57              BiocManager_1.30.26
## [15] jquerylib_0.1.4           abind_1.4-8
## [17] cli_3.6.5                 rlang_1.1.6
## [19] XVector_0.50.0            splines_4.5.1
## [21] cachem_1.1.0              DelayedArray_0.36.0
## [23] yaml_2.3.10               S4Arrays_1.10.0
## [25] tools_4.5.1               R6_2.6.1
## [27] lifecycle_1.0.4           magick_2.9.0
## [29] pkgconfig_2.0.3           bslib_0.9.0
## [31] glue_1.8.0                Rcpp_1.1.0
## [33] xfun_0.53                 knitr_1.50
## [35] htmltools_0.5.8.1         igraph_2.2.1
## [37] rmarkdown_2.30            DelayedMatrixStats_1.32.0
## [39] compiler_4.5.1
```