# Contents

* [1 Brief Introduction](#brief-introduction)
* [2 Packages installation and loading](#packages-installation-and-loading)
* [3 Case study description](#case-study-description)
* [4 Data pre-processing](#data-pre-processing)
  + [4.1 Pre-filtering](#pre-filtering)
  + [4.2 Transformation](#transformation)
* [5 Batch effect detection](#batch-effect-detection)
  + [5.1 PCA](#pca)
  + [5.2 Boxplots and density plots](#boxplots-and-density-plots)
  + [5.3 Heatmap](#heatmap)
  + [5.4 pRDA](#prda)
* [6 Batch effect correction](#batch-effect-correction)
  + [6.1 PLSDA-batch](#plsda-batch)
  + [6.2 sPLSDA-batch](#splsda-batch)
* [7 Assessing batch effect correction](#assessing-batch-effect-correction)
  + [7.1 Methods that detect batch effects](#methods-that-detect-batch-effects)
  + [7.2 Other methods](#other-methods)
* [8 Variable selection](#variable-selection)
* [9 Session Information](#session-information)
* [10 References](#references)

# 1 Brief Introduction

**PLSDA-batch** is a new batch effect correction method based on Projection
to Latent Structures Discriminant Analysis to correct data prior to any
downstream analysis. It estimates latent components related to treatment and
batch effects to remove batch variation. PLSDA-batch is highly suitable for
microbiome data as it is non-parametric, multivariate and allows for ordination
and data visualisation. Combined with centered log ratio transformation for
addressing uneven library sizes and compositional structure, PLSDA-batch
addresses all characteristics of microbiome data that existing correction
methods have ignored so far.

Apart from the main method, the R package also includes two variants called
1/ *weighted PLSDA-batch* for unbalanced batch x treatment designs that are
commonly encountered in studies with small sample size, and
2/ *sparse PLSDA-batch* for selection of discriminative variables to avoid
overfitting in classification problems. These two variants have widened the
scope of applicability of PLSDA-batch to different data
settings (**???**).

This vignette includes microbiome data pre-processing, batch effect detection
and visualisation, the usage of PLSDA-batch series methods, assessment of
batch effect removal and variable selection after batch effect correction. See
“[Batch Effects Management in Case Studies](https://evayiwenwang.github.io/PLSDAbatch_workflow/articles/case_studies.html)”
for different choices of methods for batch effect management according to
experimental purposes and designs.

# 2 Packages installation and loading

First, we load the packages necessary for analysis, and check the version of
each package.

```
# CRAN
library(pheatmap)
library(vegan)
library(gridExtra)

# Bioconductor
library(mixOmics)
library(Biobase)
library(TreeSummarizedExperiment)
library(PLSDAbatch)

# print package versions
package.version('pheatmap')
```

```
## [1] "1.0.13"
```

```
package.version('vegan')
```

```
## [1] "2.7-2"
```

```
package.version('gridExtra')
```

```
## [1] "2.3"
```

```
package.version('mixOmics')
```

```
## [1] "6.34.0"
```

```
package.version('Biobase')
```

```
## [1] "2.70.0"
```

```
package.version('PLSDAbatch')
```

```
## [1] "1.6.0"
```

# 3 Case study description

We considered a case study to illustrate the application of PLSDA-batch. This
study is described as follows:

\(\color{blue}{\bf{\text{Anaerobic digestion.}}}\) This study explored the
microbial indicators that could improve the efficacy of anaerobic digestion
(AD) bioprocess and prevent its failure (**???**). This data
include 75 samples and 567 microbial variables. The samples were treated with
two different ranges of phenol concentration (effect of interest) and
processed at five different dates (batch effect). This study includes a clear
and strong batch effect with an approx. balanced batch x treatment design.

# 4 Data pre-processing

## 4.1 Pre-filtering

We load the \(\color{blue}{\text{AD data}}\) stored internally with function
`data()`, and then extract the batch and treatment information out.

```
# AD data
data('AD_data')
ad.count <- assays(AD_data$FullData)$Count
dim(ad.count)
```

```
## [1]  75 567
```

```
ad.metadata <- rowData(AD_data$FullData)
ad.batch = factor(ad.metadata$sequencing_run_date,
                levels = unique(ad.metadata$sequencing_run_date))
ad.trt = as.factor(ad.metadata$initial_phenol_concentration.regroup)
names(ad.batch) <- names(ad.trt) <- rownames(ad.metadata)
```

The raw \(\color{blue}{\text{AD data}}\) include 567 OTUs and 75 samples.
We then use the function `PreFL()` from our \(\color{orange}{\text{PLSDAbatch}}\)
R package to filter the data.

```
ad.filter.res <- PreFL(data = ad.count)
ad.filter <- ad.filter.res$data.filter
dim(ad.filter)
```

```
## [1]  75 231
```

```
# zero proportion before filtering
ad.filter.res$zero.prob
```

```
## [1] 0.6328042
```

```
# zero proportion after filtering
sum(ad.filter == 0)/(nrow(ad.filter) * ncol(ad.filter))
```

```
## [1] 0.3806638
```

After filtering, 231 OTUs remained, and the proportion of zeroes decreased
from 63% to 38%.

Note: The `PreFL()` function is only dedicated to raw counts, rather than
relative abundance data. We also recommend to start the pre-filtering on raw
counts, rather than relative abundance data to mitigate the compositionality
issue.

## 4.2 Transformation

Prior to CLR transformation, we recommend adding 1 as the offset for the data
(e.g., \(\color{blue}{\text{AD data}}\)) that are raw count data, and 0.01 as
the offset for the data that are relative abundance data. We use
`logratio.transfo()` function in \(\color{orange}{\text{mixOmics}}\) package to
CLR transform the data.

```
ad.clr <- logratio.transfo(X = ad.filter, logratio = 'CLR', offset = 1)
class(ad.clr) = 'matrix'
```

# 5 Batch effect detection

## 5.1 PCA

We apply `pca()` function from \(\color{orange}{\text{mixOmics}}\) package to
the \(\color{blue}{\text{AD data}}\) and `Scatter_Density()` function from
\(\color{orange}{\text{PLSDAbatch}}\) to represent the PCA sample plot with
densities.

```
# AD data
ad.pca.before <- pca(ad.clr, ncomp = 3, scale = TRUE)

Scatter_Density(object = ad.pca.before, batch = ad.batch, trt = ad.trt,
                title = 'AD data', trt.legend.title = 'Phenol conc.')
```

![The PCA sample plot with densities in the AD data.](data:image/png;base64...)

Figure 1: The PCA sample plot with densities in the AD data

In the above figure, we observed 1) the distinction between samples treated
with different phenol concentrations and 2) the differences between samples
sequenced at “14/04/2016”, “21/09/2017” and the other dates. Therefore, the
batch effect related to dates needs to be removed.

## 5.2 Boxplots and density plots

We first identify the top OTU driving the major variance in PCA using
`selectVar()` in \(\color{orange}{\text{mixOmics}}\) package. Each identified
OTU can then be plotted as boxplots and density plots using `box_plot()` and
`density_plot()` in \(\color{orange}{\text{PLSDAbatch}}\).

```
ad.OTU.name <- selectVar(ad.pca.before, comp = 1)$name[1]
ad.OTU_batch <- data.frame(value = ad.clr[,ad.OTU.name], batch = ad.batch)
box_plot(df = ad.OTU_batch, title = paste(ad.OTU.name, '(AD data)'),
        x.angle = 30)
```

<img src=“/tmp/RtmpbN3iGx/Rbuild236a5128125368/PLSDAbatch/vignettes/brief\_vignette\_files/figure-html/ADboxBefore-1.png” alt=“Boxplots of sample values in”OTU28" before batch effect correction in the AD data." width=“80%” />

Figure 2: Boxplots of sample values in “OTU28” before batch effect correction in the AD data

```
density_plot(df = ad.OTU_batch, title = paste(ad.OTU.name, '(AD data)'))
```

<img src=“/tmp/RtmpbN3iGx/Rbuild236a5128125368/PLSDAbatch/vignettes/brief\_vignette\_files/figure-html/ADdensityBefore-1.png” alt=“Density plots of sample values in”OTU28" before batch effect correction in the AD data." width=“80%” />

Figure 3: Density plots of sample values in “OTU28” before batch effect correction in the AD data

The boxplot and density plot indicated a strong date batch effect because of
the differences between “14/04/2016”, “21/09/2017” and the other dates in the
“OTU28”.

We also apply a linear regression model to the “OTU28” using `linear_regres()`
from \(\color{orange}{\text{PLSDAbatch}}\) with batch and treatment effects as
covariates. We set “14/04/2016” and “21/09/2017” as the reference batch
respectively with `relevel()` from \(\color{orange}{\text{stats}}\).

```
# reference batch: 14/04/2016
ad.batch <- relevel(x = ad.batch, ref = '14/04/2016')

ad.OTU.lm <- linear_regres(data = ad.clr[,ad.OTU.name],
                            trt = ad.trt, batch.fix = ad.batch,
                            type = 'linear model')
summary(ad.OTU.lm$model$data)
```

```
##
## Call:
## lm(formula = data[, i] ~ trt + batch.fix)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -1.9384 -0.3279  0.1635  0.3849  0.9887
##
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)
## (Intercept)           0.8501     0.2196   3.871 0.000243 ***
## trt1-2               -1.6871     0.1754  -9.617 2.27e-14 ***
## batch.fix09/04/2015   1.5963     0.2950   5.410 8.55e-07 ***
## batch.fix01/07/2016   2.0839     0.2345   8.886 4.82e-13 ***
## batch.fix14/11/2016   1.7405     0.2480   7.018 1.24e-09 ***
## batch.fix21/09/2017   1.2646     0.2690   4.701 1.28e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 0.7033 on 69 degrees of freedom
## Multiple R-squared:  0.7546, Adjusted R-squared:  0.7368
## F-statistic: 42.44 on 5 and 69 DF,  p-value: < 2.2e-16
```

```
# reference batch: 21/09/2017
ad.batch <- relevel(x = ad.batch, ref = '21/09/2017')

ad.OTU.lm <- linear_regres(data = ad.clr[,ad.OTU.name],
                            trt = ad.trt, batch.fix = ad.batch,
                            type = 'linear model')
summary(ad.OTU.lm$model$data)
```

```
##
## Call:
## lm(formula = data[, i] ~ trt + batch.fix)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -1.9384 -0.3279  0.1635  0.3849  0.9887
##
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)
## (Intercept)           2.1147     0.2502   8.453 2.97e-12 ***
## trt1-2               -1.6871     0.1754  -9.617 2.27e-14 ***
## batch.fix14/04/2016  -1.2646     0.2690  -4.701 1.28e-05 ***
## batch.fix09/04/2015   0.3317     0.3139   1.056  0.29446
## batch.fix01/07/2016   0.8193     0.2573   3.185  0.00218 **
## batch.fix14/11/2016   0.4759     0.2705   1.760  0.08292 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 0.7033 on 69 degrees of freedom
## Multiple R-squared:  0.7546, Adjusted R-squared:  0.7368
## F-statistic: 42.44 on 5 and 69 DF,  p-value: < 2.2e-16
```

From the results of linear regression, we observed P < 0.001 for the regression
coefficients associated with all the other batches when the reference batch
was “14/04/2016”, which confirmed the difference between the samples from batch
“14/04/2016” and the other samples as observed from previous plots. When the
reference batch was “21/09/2017”, we also observed significant differences
between batch “21/09/2017” and “14/04/2016”, between “21/09/2017” and
“01/07/2016”. Therefore, the batch effect because of “21/09/2017” also exists.

## 5.3 Heatmap

We produce a heatmap using \(\color{orange}{\text{pheatmap}}\) package. The data
first need to be scaled on both OTUs and samples.

```
# scale the clr data on both OTUs and samples
ad.clr.s <- scale(ad.clr, center = TRUE, scale = TRUE)
ad.clr.ss <- scale(t(ad.clr.s), center = TRUE, scale = TRUE)

ad.anno_col <- data.frame(Batch = ad.batch, Treatment = ad.trt)
ad.anno_colors <- list(Batch = color.mixo(seq_len(5)),
                        Treatment = pb_color(seq_len(2)))
names(ad.anno_colors$Batch) = levels(ad.batch)
names(ad.anno_colors$Treatment) = levels(ad.trt)

pheatmap(ad.clr.ss,
        cluster_rows = FALSE,
        fontsize_row = 4,
        fontsize_col = 6,
        fontsize = 8,
        clustering_distance_rows = 'euclidean',
        clustering_method = 'ward.D',
        treeheight_row = 30,
        annotation_col = ad.anno_col,
        annotation_colors = ad.anno_colors,
        border_color = 'NA',
        main = 'AD data - Scaled')
```

![Hierarchical clustering for samples in the AD data.](data:image/png;base64...)

Figure 4: Hierarchical clustering for samples in the AD data

In the heatmap, samples in the \(\color{blue}{\text{AD data}}\) from batch dated
“14/04/2016” were clustered and distinct from other samples, indicating a batch
effect.

## 5.4 pRDA

We apply pRDA with `varpart()` function from \(\color{orange}{\text{vegan}}\)
R package.

```
# AD data
ad.factors.df <- data.frame(trt = ad.trt, batch = ad.batch)
class(ad.clr) <- 'matrix'
ad.rda.before <- varpart(ad.clr, ~ trt, ~ batch,
                        data = ad.factors.df, scale = TRUE)
ad.rda.before$part$indfract
```

```
##                 Df R.squared Adj.R.squared Testable
## [a] = X1|X2      1        NA    0.08943682     TRUE
## [b] = X2|X1      4        NA    0.26604420     TRUE
## [c]              0        NA    0.01296248    FALSE
## [d] = Residuals NA        NA    0.63155651    FALSE
```

In the result, `X1` and `X2` represent the first and second covariates fitted
in the model. `[a]`, `[b]` represent the independent proportion of variance
explained by `X1` and `X2` respectively, and `[c]` represents the intersection
variance shared between `X1` and `X2`. In the \(\color{blue}{\text{AD data}}\),
batch variance (`X2`) was larger than treatment variance (`X1`) with some
interaction proportion (indicated in line `[c]`, Adj.R.squared = 0.013). The
greater the intersection variance, the more unbalanced batch x treatment design
is. In this study, we considered the design as approx. balanced.

# 6 Batch effect correction

## 6.1 PLSDA-batch

The `PLSDA_batch()` function is implemented in
\(\color{orange}{\text{PLSDAbatch}}\) package. To use this function, we need to
specify the optimal number of components related to treatment (`ncomp.trt`) or
batch effects (`ncomp.bat`).

Here in the \(\color{blue}{\text{AD data}}\), we use `plsda()` from
\(\color{orange}{\text{mixOmics}}\) with only treatment grouping information to
estimate the optimal number of treatment components to preserve.

```
# estimate the number of treatment components
ad.trt.tune <- plsda(X = ad.clr, Y = ad.trt, ncomp = 5)
ad.trt.tune$prop_expl_var #1
```

```
## $X
##      comp1      comp2      comp3      comp4      comp5
## 0.18619506 0.07873817 0.08257396 0.09263497 0.06594757
##
## $Y
##      comp1      comp2      comp3      comp4      comp5
## 1.00000000 0.33857374 0.17315267 0.10551296 0.08185822
```

We choose the number that explains 100% variance in the outcome matrix `Y`,
thus from the result, 1 component was enough to preserve the treatment
information.

We then use `PLSDA_batch()` function with both treatment and batch grouping
information to estimate the optimal number of batch components to remove.

```
# estimate the number of batch components
ad.batch.tune <- PLSDA_batch(X = ad.clr,
                            Y.trt = ad.trt, Y.bat = ad.batch,
                            ncomp.trt = 1, ncomp.bat = 10)
ad.batch.tune$explained_variance.bat #4
```

```
## $X
##      comp1      comp2      comp3      comp4      comp5      comp6      comp7
## 0.17470922 0.11481264 0.10122717 0.07507395 0.03955458 0.03549997 0.03009383
##      comp8      comp9     comp10
## 0.03411377 0.01873017 0.01151062
##
## $Y
##     comp1     comp2     comp3     comp4     comp5     comp6     comp7     comp8
## 0.2474654 0.2615741 0.2301382 0.2608223 0.2300984 0.2524412 0.2438371 0.1098029
##     comp9    comp10
## 0.1638204 0.2300389
```

```
sum(ad.batch.tune$explained_variance.bat$Y[seq_len(4)])
```

```
## [1] 1
```

Using the same criterion as choosing treatment components, we choose the number
of batch components that explains 100% variance in the outcome matrix of batch.
According to the result, 4 components were required to remove batch effects.

We then can correct for batch effects applying `PLSDA_batch()` with treatment,
batch grouping information and corresponding optimal number of related
components.

```
ad.PLSDA_batch.res <- PLSDA_batch(X = ad.clr,
                                Y.trt = ad.trt, Y.bat = ad.batch,
                                ncomp.trt = 1, ncomp.bat = 4)
ad.PLSDA_batch <- ad.PLSDA_batch.res$X.nobatch
```

## 6.2 sPLSDA-batch

We apply sPLSDA-batch using the same function `PLSDA_batch()`, but we specify
the number of variables to select on each component (usually only
treatment-related components `keepX.trt`). To determine the optimal number of
variables to select, we use `tune.splsda()` function from
\(\color{orange}{\text{mixOmics}}\) package (**???**) with all
possible numbers of variables to select for each component (`test.keepX`).

```
# estimate the number of variables to select per treatment component
set.seed(777)
ad.test.keepX = c(seq(1, 10, 1), seq(20, 100, 10),
                seq(150, 231, 50), 231)
ad.trt.tune.v <- tune.splsda(X = ad.clr, Y = ad.trt,
                            ncomp = 1, test.keepX = ad.test.keepX,
                            validation = 'Mfold', folds = 4,
                            nrepeat = 50)
ad.trt.tune.v$choice.keepX #100
```

Here the optimal number of variables to select for the treatment component was
100. Since we have adjusted the amount of treatment variation to preserve, we
need to re-choose the optimal number of components related to batch effects
using the same criterion mentioned in section *PLSDA-batch*.

```
# estimate the number of batch components
ad.batch.tune <- PLSDA_batch(X = ad.clr,
                            Y.trt = ad.trt, Y.bat = ad.batch,
                            ncomp.trt = 1, keepX.trt = 100,
                            ncomp.bat = 10)
ad.batch.tune$explained_variance.bat #4
```

```
## $X
##      comp1      comp2      comp3      comp4      comp5      comp6      comp7
## 0.17420018 0.11477097 0.09813477 0.07894965 0.03278495 0.03540224 0.04168413
##      comp8      comp9     comp10
## 0.02200350 0.02524104 0.01347680
##
## $Y
##       comp1       comp2       comp3       comp4       comp5       comp6
## 0.247477492 0.260671553 0.230108093 0.261742862 0.248318269 0.252676585
##       comp7       comp8       comp9      comp10
## 0.253146090 0.240732821 0.005126235 0.259210314
```

```
sum(ad.batch.tune$explained_variance.bat$Y[seq_len(4)])
```

```
## [1] 1
```

According to the result, we needed 4 batch related components to remove batch
variance from the data with function `PLSDA_batch()`.

```
ad.sPLSDA_batch.res <- PLSDA_batch(X = ad.clr,
                                Y.trt = ad.trt, Y.bat = ad.batch,
                                ncomp.trt = 1, keepX.trt = 100,
                                ncomp.bat = 4)
ad.sPLSDA_batch <- ad.sPLSDA_batch.res$X.nobatch
```

Note: for unbalanced batch x treatment design (with the exception of the
nested design), we can specify `balance = FALSE` in `PLSDA_batch()` function
to apply weighted PLSDA-batch.

# 7 Assessing batch effect correction

We apply different visualisation and quantitative methods to assessing batch
effect correction.

## 7.1 Methods that detect batch effects

**PCA**

In the \(\color{blue}{\text{AD data}}\), we compared the PCA sample plots
before and after batch effect correction.

```
ad.pca.before <- pca(ad.clr, ncomp = 3, scale = TRUE)
ad.pca.PLSDA_batch <- pca(ad.PLSDA_batch, ncomp = 3, scale = TRUE)
ad.pca.sPLSDA_batch <- pca(ad.sPLSDA_batch, ncomp = 3, scale = TRUE)
```

```
# order batches
ad.batch = factor(ad.metadata$sequencing_run_date,
                levels = unique(ad.metadata$sequencing_run_date))

ad.pca.before.plot <- Scatter_Density(object = ad.pca.before,
                                    batch = ad.batch,
                                    trt = ad.trt,
                                    title = 'Before correction')
```

```
ad.pca.PLSDA_batch.plot <- Scatter_Density(object = ad.pca.PLSDA_batch,
                                        batch = ad.batch,
                                        trt = ad.trt,
                                        title = 'PLSDA-batch')
```

```
ad.pca.sPLSDA_batch.plot <- Scatter_Density(object = ad.pca.sPLSDA_batch,
                                            batch = ad.batch,
                                            trt = ad.trt,
                                            title = 'sPLSDA-batch')
```

![The PCA sample plots with densities before and after batch effect correction in the AD data.](data:image/png;base64...)

Figure 5: The PCA sample plots with densities before and after batch effect correction in the AD data

As shown in the PCA sample plots, the differences between the samples
sequenced at “14/04/2016”, “21/09/2017” and the other dates were removed after
batch effect correction. The data corrected with PLSDA-batch included slightly
more treatment variation mostly on the first PC than sPLSDA-batch, as indicated
on the x-axis label (26%). We can also compare the boxplots and density plots
for key variables identified in PCA driving the major variance or heatmaps
showing obvious patterns before and after batch effect correction
(results not shown).

**pRDA**

We calculate the global explained variance across all microbial variables
using pRDA. To achieve this, we create a loop for each variable from the
original (uncorrected) and batch effect-corrected data. The final results are
then displayed with `partVar_plot()` from
\(\color{orange}{\text{PLSDAbatch}}\) package.

```
# AD data
ad.corrected.list <- list(`Before correction` = ad.clr,
                        `PLSDA-batch` = ad.PLSDA_batch,
                        `sPLSDA-batch` = ad.sPLSDA_batch)

ad.prop.df <- data.frame(Treatment = NA, Batch = NA,
                        Intersection = NA,
                        Residuals = NA)
for(i in seq_len(length(ad.corrected.list))){
    rda.res = varpart(ad.corrected.list[[i]], ~ trt, ~ batch,
                    data = ad.factors.df, scale = TRUE)
    ad.prop.df[i, ] <- rda.res$part$indfract$Adj.R.squared}

rownames(ad.prop.df) = names(ad.corrected.list)

ad.prop.df <- ad.prop.df[, c(1,3,2,4)]

ad.prop.df[ad.prop.df < 0] = 0
ad.prop.df <- as.data.frame(t(apply(ad.prop.df, 1,
                                    function(x){x/sum(x)})))

partVar_plot(prop.df = ad.prop.df)
```

![Global explained variance before and after batch effect correction for the AD data.](data:image/png;base64...)

Figure 6: Global explained variance before and after batch effect correction for the AD data

As shown in the above figure, the intersection between batch and treatment
variance was small (1.3%) for the \(\color{blue}{\text{AD data}}\), which implies
that the batch x treatment design is not highly unbalanced. Thus the unweighted
PLSDA-batch and sPLSDA-batch were still applicable, and thus the weighted
versions were not used. sPLSDA-batch corrected data led to a better performance
with undetectable batch and intersection variance compared to PLSDA-batch.

## 7.2 Other methods

\(\mathbf{R^2}\)

The \(R^2\) values for each variable are calculated with `lm()` from
\(\color{orange}{\text{stats}}\) package. To compare the \(R^2\) values among
variables, we scale the corrected data before \(R^2\) calculation. The results
are displayed with `ggplot()` from \(\color{orange}{\text{ggplot2}}\) R package.

```
# AD data
# scale
ad.corr_scale.list <- lapply(ad.corrected.list,
                            function(x){apply(x, 2, scale)})

ad.r_values.list <- list()
for(i in seq_len(length(ad.corr_scale.list))){
    ad.r_values <- data.frame(trt = NA, batch = NA)
    for(c in seq_len(ncol(ad.corr_scale.list[[i]]))){
        ad.fit.res.trt <- lm(ad.corr_scale.list[[i]][,c] ~ ad.trt)
        ad.r_values[c,1] <- summary(ad.fit.res.trt)$r.squared
        ad.fit.res.batch <- lm(ad.corr_scale.list[[i]][,c] ~ ad.batch)
        ad.r_values[c,2] <- summary(ad.fit.res.batch)$r.squared
    }
    ad.r_values.list[[i]] <- ad.r_values
}
names(ad.r_values.list) <- names(ad.corr_scale.list)

ad.boxp.list <- list()
for(i in seq_len(length(ad.r_values.list))){
    ad.boxp.list[[i]] <-
        data.frame(r2 = c(ad.r_values.list[[i]][ ,'trt'],
                        ad.r_values.list[[i]][ ,'batch']),
                    Effects = as.factor(rep(c('Treatment','Batch'),
                                        each = 231)))
}
names(ad.boxp.list) <- names(ad.r_values.list)

ad.r2.boxp <- rbind(ad.boxp.list$`Before correction`,
                    ad.boxp.list$removeBatchEffect,
                    ad.boxp.list$ComBat,
                    ad.boxp.list$`PLSDA-batch`,
                    ad.boxp.list$`sPLSDA-batch`,
                    ad.boxp.list$`Percentile Normalisation`,
                    ad.boxp.list$RUVIII)

ad.r2.boxp$methods <- rep(c('Before correction', 'PLSDA-batch', 'sPLSDA-batch'),
                        each = 462)

ad.r2.boxp$methods <- factor(ad.r2.boxp$methods,
                            levels = unique(ad.r2.boxp$methods))

ggplot(ad.r2.boxp, aes(x = Effects, y = r2, fill = Effects)) +
    geom_boxplot(alpha = 0.80) +
    theme_bw() +
    theme(text = element_text(size = 18),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_text(angle = 60, hjust = 1, size = 18),
            axis.text.y = element_text(size = 18),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.x = element_blank(),
            legend.position = "right") + facet_grid( ~ methods) +
    scale_fill_manual(values=pb_color(c(12,14)))
```

![AD study: $R^2$ values for each microbial variable before and after batch effect correction.](data:image/png;base64...)

Figure 7: AD study: \(R^2\) values for each microbial variable before and after batch effect correction

The batch effects related variance was reduced after both PLSDA-batch and
sPLSDA-batch correction, but the former maintained a bit more treatment
related variance.

```
##################################
ad.barp.list <- list()
for(i in seq_len(length(ad.r_values.list))){
    ad.barp.list[[i]] <- data.frame(r2 = c(sum(ad.r_values.list[[i]][ ,'trt']),
                                        sum(ad.r_values.list[[i]][ ,'batch'])),
                                    Effects = c('Treatment','Batch'))
}
names(ad.barp.list) <- names(ad.r_values.list)

ad.r2.barp <- rbind(ad.barp.list$`Before correction`,
                    ad.barp.list$removeBatchEffect,
                    ad.barp.list$ComBat,
                    ad.barp.list$`PLSDA-batch`,
                    ad.barp.list$`sPLSDA-batch`,
                    ad.barp.list$`Percentile Normalisation`,
                    ad.barp.list$RUVIII)

ad.r2.barp$methods <- rep(c('Before correction', 'PLSDA-batch', 'sPLSDA-batch'),
                        each = 2)

ad.r2.barp$methods <- factor(ad.r2.barp$methods,
                            levels = unique(ad.r2.barp$methods))

ggplot(ad.r2.barp, aes(x = Effects, y = r2, fill = Effects)) +
    geom_bar(stat="identity") +
    theme_bw() +
    theme(text = element_text(size = 18),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_text(angle = 60, hjust = 1, size = 18),
            axis.text.y = element_text(size = 18),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.x = element_blank(),
            legend.position = "right") + facet_grid( ~ methods) +
    scale_fill_manual(values=pb_color(c(12,14)))
```

![AD study: the sum of $R^2$ values for each microbial variable before and after batch effect correction.](data:image/png;base64...)

Figure 8: AD study: the sum of \(R^2\) values for each microbial variable before and after batch effect correction

The overall sum of \(R^2\) values indicated that sPLSDA-batch removed slightly
more batch variance (PLSDA-batch: 12.40, sPLSDA-batch: 9.25) but preserved less
treatment variance (PLSDA-batch: 40.00, sPLSDA-batch: 36.22) than PLSDA-batch.

**Alignment scores**

To use the `alignment_score()` function from
\(\color{orange}{\text{PLSDAbatch}}\), we need to specify the proportion of data
variance to explain (`var`), the number of nearest neighbours (`k`) and the
number of principal components to estimate (`ncomp`). We then use `ggplot()`
function from \(\color{orange}{\text{ggplot2}}\) to visualise the results.

```
# AD data
ad.scores <- c()
names(ad.batch) <- rownames(ad.clr)
for(i in seq_len(length(ad.corrected.list))){
    res <- alignment_score(data = ad.corrected.list[[i]],
                            batch = ad.batch,
                            var = 0.95,
                            k = 8,
                            ncomp = 50)
    ad.scores <- c(ad.scores, res)
}

ad.scores.df <- data.frame(scores = ad.scores,
                            methods = names(ad.corrected.list))

ad.scores.df$methods <- factor(ad.scores.df$methods,
                                levels = rev(names(ad.corrected.list)))

ggplot() + geom_col(aes(x = ad.scores.df$methods,
                        y = ad.scores.df$scores)) +
    geom_text(aes(x = ad.scores.df$methods,
                    y = ad.scores.df$scores/2,
                    label = round(ad.scores.df$scores, 3)),
                size = 3, col = 'white') +
    coord_flip() + theme_bw() + ylab('Alignment Scores') +
    xlab('') + ylim(0,0.85)
```

![Comparison of alignment scores before and after batch effect correction using different methods for the AD data.](data:image/png;base64...)

Figure 9: Comparison of alignment scores before and after batch effect correction using different methods for the AD data

The alignment scores complement the PCA results, especially when batch effect
removal is difficult to assess on PCA sample plots. For example in Figure 5, we
observed that the samples across different batches were better mixed after
batch effect correction with different methods than before, whereas the
performance of difference methods was difficult to compare. Since a higher
alignment score indicates that samples are better mixed, as shown in the above
bar plot, sPLSDA-batch gave a superior performance compared to PLSDA-batch.

# 8 Variable selection

After batch effect correction, we can select discriminative variables against
different treatments.

Here, we use `splsda()` from \(\color{orange}{\text{mixOmics}}\) to select the
top 50 microbial variables that, in combination, discriminate the different
treatment
groups in the \(\color{blue}{\text{AD data}}\).

For the details to apply sPLS-DA, see
[mixOmics](http://mixomics.org/methods/spls-da/).

```
splsda.plsda_batch <- splsda(X = ad.PLSDA_batch, Y = ad.trt,
                            ncomp = 3, keepX = rep(50,3))
select.plsda_batch <- selectVar(splsda.plsda_batch, comp = 1)
head(select.plsda_batch$value)
```

```
##        value.var
## OTU46  0.3084712
## OTU24  0.2833650
## OTU28  0.2807199
## OTU35 -0.2669300
## OTU68  0.2610368
## OTU61  0.2558267
```

```
splsda.splsda_batch <- splsda(X = ad.sPLSDA_batch, Y = ad.trt,
                            ncomp = 3, keepX = rep(50,3))
select.splsda_batch <- selectVar(splsda.splsda_batch, comp = 1)
head(select.splsda_batch$value)
```

```
##        value.var
## OTU46  0.3016966
## OTU24  0.2783030
## OTU28  0.2727259
## OTU35 -0.2650401
## OTU61  0.2566640
## OTU68  0.2554550
```

```
length(intersect(select.plsda_batch$name, select.splsda_batch$name))
```

```
## [1] 43
```

The discriminative variables were selected and listed according to their
contributions against sample groups treated with different ranges of phenol
concentration (0-0.5 vs. 1-2 g/L).

The overlap between selections from the data corrected with PLSDA-batch and
sPLSDA-batch is high (43 out of 50), but there still exist different variables
between different selections.

# 9 Session Information

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
##  [1] PLSDAbatch_1.6.0                TreeSummarizedExperiment_2.18.0
##  [3] Biostrings_2.78.0               XVector_0.50.0
##  [5] SingleCellExperiment_1.32.0     SummarizedExperiment_1.40.0
##  [7] GenomicRanges_1.62.0            Seqinfo_1.0.0
##  [9] IRanges_2.44.0                  S4Vectors_0.48.0
## [11] MatrixGenerics_1.22.0           matrixStats_1.5.0
## [13] Biobase_2.70.0                  BiocGenerics_0.56.0
## [15] generics_0.1.4                  mixOmics_6.34.0
## [17] ggplot2_4.0.0                   lattice_0.22-7
## [19] MASS_7.3-65                     gridExtra_2.3
## [21] vegan_2.7-2                     permute_0.9-8
## [23] pheatmap_1.0.13                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Rdpack_2.6.4        rlang_1.1.6         magrittr_2.0.4
##  [4] compiler_4.5.1      mgcv_1.9-3          vctrs_0.6.5
##  [7] reshape2_1.4.4      stringr_1.5.2       pkgconfig_2.0.3
## [10] crayon_1.5.3        fastmap_1.2.0       magick_2.9.0
## [13] backports_1.5.0     labeling_0.4.3      rmarkdown_2.30
## [16] nloptr_2.2.1        tinytex_0.57        purrr_1.1.0
## [19] xfun_0.53           cachem_1.1.0        jsonlite_2.0.0
## [22] DelayedArray_0.36.0 BiocParallel_1.44.0 broom_1.0.10
## [25] parallel_4.5.1      cluster_2.1.8.1     R6_2.6.1
## [28] bslib_0.9.0         stringi_1.8.7       RColorBrewer_1.1-3
## [31] car_3.1-3           boot_1.3-32         numDeriv_2016.8-1.1
## [34] jquerylib_0.1.4     Rcpp_1.1.0          bookdown_0.45
## [37] knitr_1.50          Matrix_1.7-4        splines_4.5.1
## [40] igraph_2.2.1        tidyselect_1.2.1    dichromat_2.0-0.1
## [43] abind_1.4-8         yaml_2.3.10         codetools_0.2-20
## [46] tibble_3.3.0        lmerTest_3.1-3      plyr_1.8.9
## [49] treeio_1.34.0       withr_3.0.2         rARPACK_0.11-0
## [52] S7_0.2.0            evaluate_1.0.5      pillar_1.11.1
## [55] BiocManager_1.30.26 ggpubr_0.6.2        carData_3.0-5
## [58] insight_1.4.2       reformulas_0.4.2    ellipse_0.5.0
## [61] scales_1.4.0        tidytree_0.4.6      minqa_1.2.8
## [64] glue_1.8.0          lazyeval_0.2.2      tools_4.5.1
## [67] lme4_1.1-37         RSpectra_0.16-2     ggsignif_0.6.4
## [70] fs_1.6.6            grid_4.5.1          tidyr_1.3.1
## [73] ape_5.8-1           rbibutils_2.3       nlme_3.1-168
## [76] performance_0.15.2  Formula_1.2-5       cli_3.6.5
## [79] rappdirs_0.3.3      S4Arrays_1.10.0     dplyr_1.1.4
## [82] corpcor_1.6.10      gtable_0.3.6        rstatix_0.7.3
## [85] yulab.utils_0.2.1   sass_0.4.10         digest_0.6.37
## [88] SparseArray_1.10.0  ggrepel_0.9.6       farver_2.1.2
## [91] htmltools_0.5.8.1   lifecycle_1.0.4
```

# 10 References