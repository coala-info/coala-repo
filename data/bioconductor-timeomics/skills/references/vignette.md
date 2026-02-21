# timeOmics

Antoine Bodein1\*, Olivier Chapleur2, Kim-Anh Lê Cao3 and Arnaud Droit1

1CHU de Québec Research Center, Université Laval, Molecular Medicine department, Québec, QC, Canada
2Hydrosystems and Biopresses Research Unit, Irstea, Antony, France
3Melbourne Integrative Genomics, School of Mathematics and Statistics, University of Melbourne, Melbourne, VIC, Australia

\*antoine.bodein.1@ulaval.ca

#### 30 October 2025

#### Package

timeOmics 1.22.0

# Contents

* [1 Introduction](#introduction)
* [2 Start](#start)
  + [2.1 Installation](#installation)
    - [2.1.1 Lastest Bioconductor Release](#lastest-bioconductor-release)
    - [2.1.2 Lastest `Github` version](#lastest-github-version)
  + [2.2 Load the package](#load-the-package)
  + [2.3 Useful package to run this vignette](#useful-package-to-run-this-vignette)
* [3 Required data](#required-data)
* [4 Data preprocessing](#data-preprocessing)
  + [4.1 Platform-specific](#platform-specific)
  + [4.2 Time-specific](#time-specific)
* [5 Time Modelling](#time-modelling)
  + [5.1 `lmms` example](#lmms-example)
  + [5.2 Profile filtering](#profile-filtering)
* [6 Single-Omic longitudinal clustering](#single-omic-longitudinal-clustering)
  + [6.1 Principal Component Analysis](#principal-component-analysis)
    - [6.1.1 Longitudinal clustering](#longitudinal-clustering)
    - [6.1.2 A word about the multivariate models](#a-word-about-the-multivariate-models)
    - [6.1.3 Plot PCA longitudinal clusters](#plot-pca-longitudinal-clusters)
  + [6.2 *sparse* PCA](#sparse-pca)
    - [6.2.1 `keepX` optimization](#keepx-optimization)
* [7 multi-Omics longitudinal clustering](#multi-omics-longitudinal-clustering)
  + [7.1 Projection on Latent Structures (PLS)](#projection-on-latent-structures-pls)
    - [7.1.1 Ncomp and Clustering](#ncomp-and-clustering)
    - [7.1.2 Signature with *sparse* PLS](#signature-with-sparse-pls)
  + [7.2 Multi-block (s)PLS longitudinal clustering](#multi-block-spls-longitudinal-clustering)
    - [7.2.1 Ncomp and Clustering](#ncomp-and-clustering-1)
    - [7.2.2 Signature with multi-block *sparse* PLS](#signature-with-multi-block-sparse-pls)
* [8 Post-hoc evaluation](#post-hoc-evaluation)
* [References](#references)

# 1 Introduction

***timeOmics*** is a generic data-driven framework to integrate multi-Omics longitudinal data (**A.**) measured on the same biological samples and select key temporal features with strong associations within the same sample group.

The main steps of ***timeOmics*** are:

* a pre-processing step (**B.**) Normalize and filter low-expressed features, except those not varying over time,
* a modelling step (**C.**) Capture inter-individual variability in biological/technical replicates and accommodate heterogeneous experimental designs,
* a clustering step (**D.**) Group features with the same expression profile over time. Feature selection step can also be used to identify a signature per cluster,
* a post-hoc validation step (**E.**) Ensure clustering quality.

This framework is presented on both single-Omic and multi-Omics situations.

![](data:image/png;base64...)

Framework Overview

For more details please check:

# 2 Start

## 2.1 Installation

### 2.1.1 Lastest Bioconductor Release

```
## install BiocManager if not installed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
## install timeOmics
BiocManager::install('timeOmics')
```

### 2.1.2 Lastest `Github` version

```
install.packages("devtools")
# then load
library(devtools)
install_github("abodein/timeOmics")
```

## 2.2 Load the package

```
library(timeOmics)
```

## 2.3 Useful package to run this vignette

```
library(tidyverse)
```

# 3 Required data

Each omics technology produces count or abundance tables with samples in rows and features in columns (genes, proteins, species, …).
In multi-Omics, each *block* has the same rows and a variable number of columns depending on the technology and number of identified features.

We assume each *block* *(omics)* is a matrix/data.frame with samples in **rows** (similar in each *block*) and features in **columns** (variable number of column). Normalization steps applied to each block will be covered in the next section.

For this example, we will use a part of simulated data based on the above-mentioned article and generated as follow:

Twenty reference time profiles, were generated on 9 *equally spaced*\* time points and assigned to 4 clusters (5 profiles each). These ground truth profiles were then used to simulate new profiles.
The profiles from the 5 individuals were then modelled with `lmms` (Straube et al. [2015](#ref-straube2015linear)).
Please check (Bodein et al. [2019](#ref-bodein2019generic)) for more details about the simulated data.

To illustrate the filtering step implemented later, we add an extra noisy profile resulting in a matrix of (9x5) x (20+1).

\* *It is not mandatory to have equally spaced time points in your data.*

```
data("timeOmics.simdata")
sim.data <- timeOmics.simdata$sim

dim(sim.data)
```

```
## [1] 45 21
```

```
head(sim.data[,1:6])
```

```
##            c0       c1.0       c1.1        c1.2      c1.3        c1.4
## A_1 0.6810022 -0.1681427 -0.1336986  0.12040677 0.4460119 -0.93382470
## A_2 1.4789556  0.4309468  1.1172245 -0.08183742 0.4585589 -0.56857351
## A_3 0.9451049  1.4676125  1.6079441 -0.11034711 1.5761445 -0.09178880
## A_4 0.7403461  1.1211525  1.7702314  0.17460753 1.4079393 -0.00414130
## A_5 0.9291161  1.2387863  1.8332048 -0.03780133 1.2714786  0.01158791
## A_6 1.0408472  2.3145195  2.5332477  0.23133263 2.1085377  0.81762482
```

# 4 Data preprocessing

Every analysis starts with a pre-processing step that includes normalization and data cleaning.
In longitudinal multi-omics analysis we have a 2-step pre-processing procedure.

## 4.1 Platform-specific

Platform-specific pre-processing is the type of normalization normally used without time component.
It may differ depending on the type of technology.

The user can apply normalization steps *(log, scale, rle, …)* and filtering steps *(low count removal, …)*.

It is also possible to handle microbiome data with Centered Log Ratio transformation as described [here](http://mixomics.org/mixmc/pre-processing/).

That is why we let the user apply their favorite method of normalization.

## 4.2 Time-specific

In a longitudinal context, one can be interested only in features that vary over time and filter out molecules with a low variation coefficient.

To do so, we can first naively set a threshold on the variation coefficient and keep those features that exceed the threshold.

```
remove.low.cv <- function(X, cutoff = 0.5){
  # var.coef
  cv <- unlist(lapply(as.data.frame(X),
                      function(x) abs(sd(x)/mean(x))))
  return(X[,cv > cutoff])
}

data.filtered <- remove.low.cv(sim.data, 0.5)
```

# 5 Time Modelling

The next step is the modelling of each feature (molecule) as a function of time.

We rely on a *Linear Mixed Model Splines* framework (package `lmms`) to model the features expression as a function of time by taking into account inter-individual variability.

`lmms` fits 4 different types of models described and indexed as below and assigns the best fit for each of the feature.

* 0 = linear model,
* 1 = linear mixed effect model spline (LMMS) with defined basis,
* 2 = LMMS taking subject-specific random intercepts,
* 3 = LMMS with subject-specific intercept and slope.

The package also has an interesting feature for filtering profiles which are not differentially expressed over time, with statistical testing (see `lmms::lmmsDE`).

Once run, `lmms` summarizes each feature into a unique time profile.

## 5.1 `lmms` example

`lmms` requires a data.frame with features in columns and samples in rows.

For more information about `lmms` modelling parameters, please check `?lmms::lmmSpline`

\*\*\* Package `lmms` was removed from the CRAN repository (Archived on 2020-09-11).
<https://cran.r-project.org/web/packages/lmms/index.html> \*\*\*

`lmms` package is still available and can be installed as follow:

```
devtools::install_github("cran/lmms")
library(lmms)
```

```
# numeric vector containing the sample time point information
time <- timeOmics.simdata$time
head(time)
```

```
## [1] 1 2 3 4 5 6
```

```
# example of lmms
lmms.output <- lmms::lmmSpline(data = data.filtered, time = time,
                         sampleID = rownames(data.filtered), deri = FALSE,
                         basis = "p-spline", numCores = 4, timePredict = 1:9,
                         keepModels = TRUE)
modelled.data <- t(slot(lmms.output, 'predSpline'))
```

```
lmms.output <- timeOmics.simdata$lmms.output
modelled.data <- timeOmics.simdata$modelled
```

The `lmms` object provides a list of models for each feature.
It also includes the new predicted splines *(modelled data)* in the `predSpline` slot.
The produced table contains features in columns and now, **times in rows**.

Let’s plot the modeled profiles.

```
# gather data
data.gathered <- modelled.data %>% as.data.frame() %>%
  rownames_to_column("time") %>%
  mutate(time = as.numeric(time)) %>%
  pivot_longer(names_to="feature", values_to = 'value', -time)

# plot profiles
ggplot(data.gathered, aes(x = time, y = value, color = feature)) + geom_line() +
  theme_bw() + ggtitle("`lmms` profiles") + ylab("Feature expression") +
  xlab("Time")
```

![](data:image/png;base64...)

## 5.2 Profile filtering

Straight line modelling can occur when the inter-individual variation is too high.
To remove the noisy profiles, we have implemented a 2-phase test procedure.

* *Breusch-Pagan test*, which tests the homoscedasticity of the residuals.
* *Cutoff on MSE* (mean squared error), to remove feature for which the residuals are too dispersed arround the fitted line.
  This threshold is determined automatically. The MSE for a linear model must not exceed the MSE of more complex models.

```
filter.res <- lmms.filter.lines(data = data.filtered,
                                lmms.obj = lmms.output, time = time)
profile.filtered <- filter.res$filtered
```

# 6 Single-Omic longitudinal clustering

To achieve clustering with multivariate ordination methods, we rely on the `mixOmics` package (Rohart et al. [2017](#ref-rohart2017mixomics)).

## 6.1 Principal Component Analysis

From the modelled data, we use a PCA to cluster features with similar expression profiles over time.

PCA is an unsupervised reduction dimension technique which uses uncorrelated
intrumental variable (i.e. principal components) to summarize as much information
(*variance*) as possible from the data.

In PCA, each component is associated to a loading vector of length P (number of features/profiles).
For a given set of component, we can extract a set of strongly correlated profiles by
considering features with the top absolute coefficients in the loading vectors.

Those profiles are linearly combined to define each component, and thus, explain similar information on a given component.
Different clusters are therefore obtained on each component of the PCA.
Each cluster is then further separated into two sets of profiles which we denote as “positive” or “negative” based on the sign of the coefficients in the loading vectors
Sign indicates how the features can be assign into 2 clusters.

At the end of this procedure, each component create 2 clusters and each feature is assigned to a cluster according to the maximum contribution on a component and the sign of that contribution.

*(see also `?mixOmics::pca` for more details about PCA and available options)*

### 6.1.1 Longitudinal clustering

To optimize the number of clusters, the number of PCA components needs to be optimized (`getNcomp`).
The quality of clustering is assessed using the silhouette coefficient.
The number of components that maximizes the silhouette coefficient will provide the best clustering.

```
# run pca
pca.res <- pca(X = profile.filtered, ncomp = 5, scale=FALSE, center=FALSE)

# tuning ncomp
pca.ncomp <- getNcomp(pca.res, max.ncomp = 5, X = profile.filtered,
                      scale = FALSE, center=FALSE)

pca.ncomp$choice.ncomp
```

```
## [1] 1
```

```
plot(pca.ncomp)
```

![](data:image/png;base64...)

In this plot, we can observe that the highest silhouette coefficient is achieved when `ncomp = 2` (4 clusters).

```
# final model
pca.res <- pca(X = profile.filtered, ncomp = 2, scale = FALSE, center=FALSE)
```

All information about the cluster is displayed below (`getCluster`).
Once run, the procedure will indicate the assignement of each molecule to either the `positive` or `negative` cluster of a given component based on the sign of loading vector (contribution).

```
# extract cluster
pca.cluster <- getCluster(pca.res)
head(pca.cluster)
```

```
##   molecule comp contrib.max cluster block contribution
## 1     c1.0  PC2 -0.27083871      -2     X     negative
## 2     c1.1  PC2 -0.39713004      -2     X     negative
## 3     c1.2  PC2 -0.08531134      -2     X     negative
## 4     c1.3  PC2 -0.22257819      -2     X     negative
## 5     c1.4  PC2 -0.28971360      -2     X     negative
## 6     c2.0  PC2  0.26686087       2     X     positive
```

### 6.1.2 A word about the multivariate models

Multivariate models provide a set of graphical methods to extract useful information about samples or variables (R functions from mixOmics).

The sample plot, or more accurately here, the timepoint plot projects the samples/timpoints into the reduced space represented by the principal components (or latent structures).
It displays the similarity (points are closed to each other) or dissimilarities between samples/timepoints.

```
plotIndiv(pca.res)
```

![](data:image/png;base64...)

Associations between variables can be displayed on a circle correlation.
The variables are projected on the plane defined two principal components.
Their projections are inside a circle of radius 1 centered and of unit variance.
Strongly associated (or correlated) variables are projected in the same direction from the origin. The greater the distance from the origin the stronger the association.

```
plotVar(pca.res)
```

![](data:image/png;base64...)

Lastly, the strenght of the variables on a component can be displayed by an horizontal barplot.

```
plotLoadings(pca.res)
```

![](data:image/png;base64...)

### 6.1.3 Plot PCA longitudinal clusters

Clustered profiles can be displayed with `plotLong`.

The user can set the parameters `scale` and `center` to scale/center all time profiles.

(*See also `mixOmics::plotVar(pca.res)` for variable representation*)

```
plotLong(pca.res, scale = FALSE, center = FALSE,
         title = "PCA longitudinal clustering")
```

![](data:image/png;base64...)

## 6.2 *sparse* PCA

The previous clustering used all features.
*sparse* PCA is an optional step to define a cluster signature per cluster.
It selects the features with the highest loading scores for each component in order to determine a signature.

*(see also `?mixOmics::spca` for more details about sPCA and available options)*

### 6.2.1 `keepX` optimization

To find the right number of features to keep per component (`keepX`) and thus per cluster, the silhouette coefficient is assessed for a list of selected features (`test.keepX`) on each component.

We plot below the silhouette coefficient corresponding to each sub-cluster (positive or negative contibution) with respect to the number of features selected. A large decrease indicates that the clusters are not homogeneous and therefore the new added features should not be included in the final model.

This method tends to select the smallest possible signature, so if the user wishes to set a minimum number of features per component, this parameter will have to be adjusted accordingly.

```
tune.spca.res <- tuneCluster.spca(X = profile.filtered, ncomp = 2,
                                  test.keepX = c(2:10))
# selected features in each component
tune.spca.res$choice.keepX
```

```
## 1 2
## 6 4
```

```
plot(tune.spca.res)
```

![](data:image/png;base64...)

In the above graph, evolution of silhouette coefficient per component and per contribution is plotted as a function of `keepX`.

```
# final model
spca.res <- spca(X = profile.filtered, ncomp = 2,
                 keepX = tune.spca.res$choice.keepX, scale = FALSE)
plotLong(spca.res)
```

![](data:image/png;base64...)

# 7 multi-Omics longitudinal clustering

In this type of scenario, the user has 2 or more blocks of omics data from the same experiment
(i. e. gene expression and metabolite concentration) and he is interested in discovering
which genes and metabolites have a common expression profile.
This may reveal dynamic biological mechanisms.

The clustering strategy with more than one block of data is the same as longitudinal clustering with PCA and is based on integrative methods using Projection on Latent Structures (PLS).

With 2 blocks, it is then necessary to use PLS.
With more than 2 blocks, the user has to use a multi-block PLS.

## 7.1 Projection on Latent Structures (PLS)

In the following section, *PLS* is used to cluster time profiles coming from **2 blocks** of data.
*PLS* accepts 2 data.frames with the same number of rows (corresponding samples).

*(see also `?mixOmics::pls` for more details about PLS and available options)*

### 7.1.1 Ncomp and Clustering

Like *PCA*, number of components of PLS model and thus number of clusters needs to be optimized (`getNcomp`).

```
X <- profile.filtered
Y <- timeOmics.simdata$Y

pls.res <- pls(X,Y, ncomp = 5, scale = FALSE)
pls.ncomp <- getNcomp(pls.res, max.ncomp = 5, X=X, Y=Y, scale = FALSE)
pls.ncomp$choice.ncomp
```

```
## [1] 1
```

```
plot(pls.ncomp)
```

![](data:image/png;base64...)

In this plot, we can observe that the highest silhouette coefficient is achieved when `ncomp = 2` (4 clusters).

```
# final model
pls.res <- pls(X,Y, ncomp = 2, scale = FALSE)

# info cluster
head(getCluster(pls.res))
```

```
##   molecule  comp contrib.max cluster block contribution
## 1     c1.0 comp2 -0.22976900      -2     X     negative
## 2     c1.1 comp2 -0.34285036      -2     X     negative
## 3     c1.2 comp2 -0.06914741      -2     X     negative
## 4     c1.3 comp2 -0.19170186      -2     X     negative
## 5     c1.4 comp2 -0.25602966      -2     X     negative
## 6     c2.0 comp2  0.22688620       2     X     positive
```

```
# plot clusters
plotLong(pls.res, title = "PLS longitudinal clustering", legend = TRUE)
```

![](data:image/png;base64...)

### 7.1.2 Signature with *sparse* PLS

As with *PCA*, it is possible to use the *sparse* PLS to get a signature of the clusters.

`tuneCluster.spls` choose the correct number of feature to keep on block X `test.keepX` as well as
the correct number of feature to keep on block Y `test.keepY` among a list provided by the user and are tested for each of the components.

*(see also `?mixOmics::spls` for more details about `spls` and available options)*

```
tune.spls <- tuneCluster.spls(X, Y, ncomp = 2, test.keepX = c(4:10), test.keepY <- c(2,4,6))

# selected features in each component on block X
tune.spls$choice.keepX
```

```
## 1 2
## 5 5
```

```
# selected features in each component on block Y
tune.spls$choice.keepY
```

```
## 1 2
## 2 2
```

```
# final model
spls.res <- spls(X,Y, ncomp = 2, scale = FALSE,
                 keepX = tune.spls$choice.keepX, keepY = tune.spls$choice.keepY)

# spls cluster
spls.cluster <- getCluster(spls.res)

# longitudinal cluster plot
plotLong(spls.res, title = "sPLS clustering")
```

![](data:image/png;base64...)

## 7.2 Multi-block (s)PLS longitudinal clustering

With more than **2 blocks** of data, it is necessary to use *multi-block PLS* to identify cluster of similar profile from **3 and more blocks** of data.

This methods accepts a list of data.frame as `X` (same corresponding rows) and a Y data.frame.

*(see also `?mixOmics::block.pls` for more details about block PLS and available options)*

### 7.2.1 Ncomp and Clustering

```
X <- list("X" = profile.filtered, "Z" = timeOmics.simdata$Z)
Y <- as.matrix(timeOmics.simdata$Y)

block.pls.res <- block.pls(X=X, Y=Y, ncomp = 5,
                           scale = FALSE, mode = "canonical")
block.ncomp <- getNcomp(block.pls.res,X=X, Y=Y,
                        scale = FALSE, mode = "canonical")
block.ncomp$choice.ncomp
```

```
## [1] 1
```

```
plot(block.ncomp)
```

![](data:image/png;base64...)

In this plot, we can observe that the highest silhouette coefficient is achieved when `ncomp = 1` (2 clusters).

```
# final model
block.pls.res <- block.pls(X=X, Y=Y, ncomp = 1, scale = FALSE, mode = "canonical")
# block.pls cluster
block.pls.cluster <- getCluster(block.pls.res)

# longitudinal cluster plot
plotLong(block.pls.res)
```

![](data:image/png;base64...)

### 7.2.2 Signature with multi-block *sparse* PLS

As with *PCA* and *PLS*, it is possible to use the *sparse* multi-block PLS to get a signature of the clusters.

`tuneCluster.block.spls` choose the correct number of feature to keep on each block of X `test.keepX` as well as
the correct number of feature to keep on block Y `test.keepY` among a list provided by the user.

*(see also `?mixOmics::block.spls` for more details about block sPLS and available options)*

```
test.list.keepX <- list("X" = 4:10, "Z" = c(2,4,6,8))
test.keepY <- c(2,4,6)

tune.block.res <- tuneCluster.block.spls(X= X, Y= Y,
                                         test.list.keepX=test.list.keepX,
                                         test.keepY= test.keepY,
                                         scale=FALSE,
                                         mode = "canonical", ncomp = 1)
# ncomp = 1 given by the getNcomp() function

# selected features in each component on block X
tune.block.res$choice.keepX
```

```
## $X
## [1] 10
##
## $Z
## [1] 6
```

```
# selected features in each component on block Y
tune.block.res$choice.keepY
```

```
## [1] 2
```

```
# final model
block.pls.res <- block.spls(X=X, Y=Y,
                            ncomp = 1,
                            scale = FALSE,
                            mode = "canonical",
                            keepX = tune.block.res$choice.keepX,
                            keepY = tune.block.res$choice.keepY)

head(getCluster(block.pls.res))
```

```
##   molecule  comp contrib.max cluster block contribution
## 1     c1.0 comp1   0.2898800       1     X     positive
## 2     c1.1 comp1   0.5086840       1     X     positive
## 3     c1.3 comp1   0.2050143       1     X     positive
## 4     c1.4 comp1   0.3407299       1     X     positive
## 5     c2.0 comp1  -0.2827500      -1     X     negative
## 6     c2.1 comp1  -0.5195458      -1     X     negative
```

```
plotLong(block.pls.res)
```

![](data:image/png;base64...)

# 8 Post-hoc evaluation

Interpretation based on correlations between profiles must be made with caution as it is highly likely to be
spurious. Proportional distances has been proposed as an alternative to measure association a posteriori on the identified signature.

In the following graphs, we represent all the proportionality distance within clusters and the distance of features inside the clusters with entire background set.

We also use a Wilcoxon U-test to compare the within cluster median compared to the entire background set.

```
# example fro multiblock analysis
res <- proportionality(block.pls.res)
# distance between pairs of features
head(res$propr.distance)[1:6]
```

```
##              c1.0         c1.1       c1.2        c1.3         c1.4     c2.0
## c1.0  0.000000000  0.013738872 0.10309931 0.004672097  0.003695577 11.35090
## c1.1  0.013738872  0.000000000 0.17839169 0.032880866  0.003382442 19.54609
## c1.2  0.103099307  0.178391691 0.00000000 0.068939973  0.140352889  3.13746
## c1.3  0.004672097  0.032880866 0.06893997 0.000000000  0.015823119  7.99465
## c1.4  0.003695577  0.003382442 0.14035289 0.015823119  0.000000000 15.36399
## c2.0 11.350898590 19.546092484 3.13746002 7.994649950 15.363992809  0.00000
```

```
# u-test pvalue by clusters
pval.propr <- res$pvalue
knitr::kable(pval.propr)
```

| cluster | median\_inside | median\_outside | Pvalue |
| --- | --- | --- | --- |
| 1 | 0.01 | 4.42 | 1.80727888911364e-26 |
| -1 | 0.14 | 4.42 | 4.24791542683991e-27 |

```
plot(res)
```

![](data:image/png;base64...)

In addition to the Wilcoxon test, proportionality distance dispersion within and with entire background set is represented by cluster in the above graph.

Here, for cluster `1`, the proportionality distance is calculated between pairs of feature from the same cluster `1` (inside).
Then the distance is calculated between each feature of cluster `1` and every feature of cluster `-1` (outside).

The same is applied on features from cluster `-1`.

So we see that the intra-cluster distance is lower than the distances with the entire background set.
Which is confirmed by the Wilcoxon test and this ensures a good clustering.

# References

Bodein, Antoine, Olivier Chapleur, Arnaud Droit, and Kim-Anh Lê Cao. 2019. “A Generic Multivariate Framework for the Integration of Microbiome Longitudinal Studies with Other Data Types.” *Frontiers in Genetics* 10.

Rohart, Florian, Benoit Gautier, Amrit Singh, and Kim-Anh Lê Cao. 2017. “MixOmics: An R Package for ‘Omics Feature Selection and Multiple Data Integration.” *PLoS Computational Biology* 13 (11): e1005752.

Straube, Jasmin, Alain-Dominique Gorse, Bevan Emma Huang, Kim-Anh Lê Cao, and others. 2015. “A Linear Mixed Model Spline Framework for Analysing Time Course ‘Omics’ Data.” *PloS One* 10 (8): e0134540.