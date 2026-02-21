# *Cardinal 3*: Statistical methods for mass spectrometry imaging

Kylie Ariel Bemis

#### Revised: 1 September 2024

# Contents

* [1 Introduction](#introduction)
* [2 Exploratory analysis](#exploratory-analysis)
  + [2.1 Principal components analysis (PCA)](#principal-components-analysis-pca)
  + [2.2 Non-negative matrix factorization (NMF)](#non-negative-matrix-factorization-nmf)
  + [2.3 Feature colocalization](#feature-colocalization)
* [3 Image segmentation](#image-segmentation)
  + [3.1 Spatial shrunken centroids clustering](#spatial-shrunken-centroids-clustering)
  + [3.2 Spatial Dirichlet Gaussian mixture modeling](#spatial-dirichlet-gaussian-mixture-modeling)
* [4 Classification and cross-validation](#classification-and-cross-validation)
  + [4.1 Projection to latent structures (PLS)](#projection-to-latent-structures-pls)
  + [4.2 Spatial shrunken centroids classification](#spatial-shrunken-centroids-classification)
* [5 Class comparison](#class-comparison)
  + [5.1 Sample-based means testing](#sample-based-means-testing)
  + [5.2 Segment-based means testing](#segment-based-means-testing)
* [6 Session information](#session-information)

# 1 Introduction

*Cardinal 3* provides statistical methods for both supervised and unsupervised analysis of mass spectrometry (MS) imaging experiments. Class comparison can also be performed, provided an appropriate experimental design and sample size.

Before statistical analysis, it is important to identify the statistical goal of the experiment:

* **Unsupervised analysis**. The data has no class labels or conditions, and we are interested in exploratory analysis to *discover* regions of interest in the data.
* **Supervised analysis**. The data has class labels and we want to train a statistical or machine learning model to *predict* the class labels of new data.
* **Class comparison**. The data has class labels or conditions, and we want to *test* whether the abundance of the mass features is different between conditions.

*CardinalWorkflows* provides real experimental data and more detailed discussion of the statistical methods than will be covered in this brief overview.

# 2 Exploratory analysis

Suppose we are exploring an unlabeled dataset, and wish to understand the structure of the data.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
mse <- simulateImage(preset=2, dim=c(32,32), sdnoise=0.5,
    peakheight=c(2,4), centroided=TRUE)

mse$design <- makeFactor(circle=mse$circle,
    square=mse$square, bg=!(mse$circle | mse$square))

image(mse, "design")
```

![](data:image/png;base64...)

```
image(mse, i=c(5, 13, 21), layout=c(1,3))
```

![](data:image/png;base64...)

## 2.1 Principal components analysis (PCA)

Principal components analysis is an unsupervised dimension reduction technique. It reduces the data to some number of “principal components” that are a linear combination of the original mass features, where each component is orthogonal to the last, and explains as much of the variance in the data as possible.

Use `PCA()` to perform PCA on a `MSImagingExperiment`.

```
pca <- PCA(mse, ncomp=3)
pca
```

```
## SpatialPCA on 30 variables and 1024 observations
## names(5): sdev, rotation, center, scale, x
## coord(2): x = 1...32, y = 1...32
## runNames(1): run0
## modelData(): Principal components (k=3)
##
## Standard deviations (1, .., k=3):
##       PC1      PC2      PC3
##  6.636906 3.436595 1.046463
##
## Rotation (n x k) = (30 x 3):
##              PC1         PC2         PC3
## [1,] -0.03402269  0.21483865  0.04784900
## [2,] -0.02817299  0.18845959  0.16568654
## [3,] -0.02989212  0.19056694  0.15361428
## [4,] -0.05446889  0.32630730 -0.05332356
## [5,] -0.05922941  0.33706101 -0.21719160
## [6,] -0.06619176  0.39891098 -0.22349677
## ...          ...         ...         ...
```

We can see that the first 2 principal components explain most of the variation in the data.

```
image(pca, type="x", superpose=FALSE, layout=c(1,3), scale=TRUE)
```

![](data:image/png;base64...)

The loadings of the components show how each feature contributes to each component.

```
plot(pca, type="rotation", superpose=FALSE, layout=c(1,3), linewidth=2)
```

![](data:image/png;base64...)

Plotting the principal component scores against each other is a useful way of visualization the separation between data classes.

```
plot(pca, type="x", groups=mse$design, linewidth=2)
```

![](data:image/png;base64...)

## 2.2 Non-negative matrix factorization (NMF)

Non-negative matrix factorization is a popular alternative to PCA when the data is naturally non-negative. The main difference between PCA and NMF is that, for NMF, all of the loadings are required to be non-negative.

Use `NMF()` to perform NMF on a `MSImagingExperiment`.

```
nmf <- NMF(mse, ncomp=3)
nmf
```

```
## SpatialNMF on 30 variables and 1024 observations
## names(4): activation, x, iter, transpose
## coord(2): x = 1...32, y = 1...32
## runNames(1): run0
## modelData(): Non-negative matrix factorization (k=3)
##
## Activation (n x k) = (30 x 3):
##              C1         C2         C3
## [1,] 0.21338134 2.62754500 0.56069166
## [2,] 0.31418203 2.44048129 0.32407636
## [3,] 0.32028017 2.45586013 0.36841506
## [4,] 0.22196108 3.83050497 0.74385792
## [5,] 0.04236733 3.92938519 2.56207820
## [6,] 0.13729507 4.55135247 0.96935625
## ...         ...        ...        ...
```

We can see that NMF can pick up the variation somewhat better when the data is non-negative, as is the case for mass spectra. As before, we still only need 2 components.

```
image(nmf, type="x", superpose=FALSE, layout=c(1,3), scale=TRUE)
```

![](data:image/png;base64...)

As with PCA, the loadings of the NMF components show how each feature contributes to each component. The NMF components can be easier to interpret as they must be non-negative.

```
plot(nmf, type="activation", superpose=FALSE, layout=c(1,3), linewidth=2)
```

![](data:image/png;base64...)

Plotting the principal component scores against each other is a useful way of visualization the separation between data classes.

```
plot(nmf, type="x", groups=mse$design, linewidth=2)
```

![](data:image/png;base64...)

## 2.3 Feature colocalization

Finding other mass features colocalized with a particular image is a common task in analysis of MS imaging experiments.

Use `colocalize()` to find mass features that are colocalized with another image.

```
coloc <- colocalized(mse, mz=1003.3)
coloc
```

```
## DataFrame with 30 rows and 7 columns
##             i        mz       cor       MOC        M1        M2      Dice
##     <integer> <numeric> <numeric> <numeric> <numeric> <numeric> <numeric>
## 1          11   1003.36  1.000000  1.000000  1.000000  1.000000  1.000000
## 2          17   1162.23  0.874814  0.938284  0.940310  0.937382  0.906250
## 3          16   1160.55  0.860895  0.925035  0.917932  0.911279  0.869141
## 4          14   1063.12  0.859409  0.923858  0.917603  0.917799  0.878906
## 5          12   1011.54  0.833750  0.914091  0.910218  0.909627  0.867188
## ...       ...       ...       ...       ...       ...       ...       ...
## 26          7   796.933  0.284653  0.570582  0.672447  0.559862  0.562500
## 27          9   860.483  0.282950  0.592743  0.670401  0.601311  0.593750
## 28          1   513.751  0.272135  0.574656  0.675525  0.575830  0.582031
## 29          3   707.896  0.233648  0.554803  0.656335  0.561944  0.570312
## 30          2   610.262  0.231395  0.551446  0.639217  0.560083  0.558594
```

By default, Pearson correlation is used to rank the colocalized features. Manders overlap coefficient (MOC), colocalization coefficients (M1 and M2), and Dice scores are also provided.

```
image(mse, mz=coloc$mz[1:3], layout=c(1,3))
```

![](data:image/png;base64...)

# 3 Image segmentation

Segmentation (clustering) a dataset is a useful way to summarize an MS imaging experiment and discover regions of interest within the sample.

## 3.1 Spatial shrunken centroids clustering

Spatially-aware nearest shrunken centroids clustering allows simultaneous image segmentation and feature selection.

A smoothing radius `r`, initial number of clusters `k`, and sparsity parameters `s` must be provided.

The larger the sparsity parameter `s`, the fewer mass features will contribute to the segmentation.

Spatial shrunken centroids may result in fewer clusters than the initial number of clusters `k`, so it is recommended to use a value for `k` that is larger than the expected number of clusters, and allow the method to automatically choose the number of clusters.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
ssc <- spatialShrunkenCentroids(mse, r=1, k=3, s=c(0,6,12,18))
ssc
```

```
## ResultsList of length 4
## names(4): r=1,k=3,s=0 r=1,k=3,s=6 r=1,k=3,s=12 r=1,k=3,s=18
## model: SpatialShrunkenCentroids
## DataFrame with 4 rows and 8 columns
##                      r         k         s     weights  clusters  sparsity
##              <numeric> <numeric> <numeric> <character> <numeric> <numeric>
## r=1,k=3,s=0          1         3         0    gaussian         3      0.00
## r=1,k=3,s=6          1         3         6    gaussian         3      0.27
## r=1,k=3,s=12         1         3        12    gaussian         3      0.56
## r=1,k=3,s=18         1         3        18    gaussian         3      0.62
##                    AIC       BIC
##              <numeric> <numeric>
## r=1,k=3,s=0    268.136   859.912
## r=1,k=3,s=6    242.546   715.967
## r=1,k=3,s=12   428.944   774.147
## r=1,k=3,s=18   782.553  1098.167
```

Plotting the predicted cluster probabilities shows a clear segmentation into the ground truth image.

```
image(ssc, i=1:3, type="probability", layout=c(1,3))
```

![](data:image/png;base64...)

Spatial shrunken centroids calculates t-statistics for each segment and each mass feature. These t-statistics a measure of the difference between the cluster center and the global mean.

```
plot(ssc, i=1:3, type="statistic", layout=c(1,3),
    linewidth=2, annPeaks="circle")
```

![](data:image/png;base64...)

Mass features with t-statistics of zero do not contribute to the segmentation. The sign of the t-statistic indicates whether the mass feature is over- or under-expressed in the given cluster relative to the global mean.

Use `topFeatures()` to rank mass features by t-statistic.

```
ssc_top <- topFeatures(ssc[[2L]])
ssc_top
```

```
## DataFrame with 90 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1          30   1983.41           1   23.2059   4.81977  0.958125
## 2          22   1340.73           1   20.7688   4.79185  1.004950
## 3          21   1286.70           1   17.9398   4.37746  0.990831
## 4          25   1524.34           1   17.9343   4.73777  1.054879
## 5          28   1721.92           1   17.5223   3.52447  0.901676
## ...       ...       ...         ...       ...       ...       ...
## 86         30   1983.41           3  -19.9765   1.72160  0.958125
## 87         11   1003.36           3  -19.9778   1.57904  0.979531
## 88         16   1160.55           3  -20.5388   1.31939  0.962451
## 89         14   1063.12           3  -21.2236   1.97803  0.995305
## 90         17   1162.23           3  -21.7653   1.48680  1.028952
```

```
ssc_top_cl3 <- subset(ssc_top, class==1)
image(mse, mz=ssc_top_cl3$mz[1:3], layout=c(1,3))
```

![](data:image/png;base64...)

## 3.2 Spatial Dirichlet Gaussian mixture modeling

Spatially-aware Dirichlet Gaussian mixture models (spatial-DGMM) is a method of image segmentation applied to each mass feature individually, rather than the dataset as a whole.

This is useful for summarizing molecular ion images, and for discovering structures that clustering using all mass features together may miss.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
dgmm <- spatialDGMM(mse, r=1, k=3, weights="gaussian")
dgmm
```

```
## SpatialDGMM on 30 variables and 1024 observations
## names(10): class, mu, sigma, ..., weights, r, k
## coord(2): x = 1...32, y = 1...32
## runNames(1): run0
## modelData(): Spatial Gaussian mixture model (k=3, channels=30)
##
## Groups: run0
##
## Parameter estimates:
## $mu
## , , 1
##              1         2         3
## run0 3.6261500 1.6161422 0.8802321
## , , ...
##
## $sigma
## , , 1
##              1         2         3
## run0 0.9015294 0.4295690 0.4101959
## , , ...
```

A different segmentation is fit for each mass feature.

```
image(dgmm, i=c(5, 13, 21), layout=c(1,3))
```

![](data:image/png;base64...)

Each image is modeled as a mixture of Gaussian distributions.

```
plot(dgmm, i=c(5, 13, 21), layout=c(1,3), linewidth=2)
```

![](data:image/png;base64...)

Spatial-DGMM segmentations can be especially useful for finding mass features colocalized with a region-of-interest.

When applied to a `SpatialDGMM` object, `colocalize()` is able to use match scores that can have a higher specificity than using Pearson correlation on the raw ion images.

```
coloc2 <- colocalized(dgmm, mse$square)
coloc2
```

```
## DataFrame with 30 rows and 6 columns
##             i        mz       MOC        M1        M2      Dice
##     <integer> <numeric> <numeric> <numeric> <numeric> <numeric>
## 1          22   1340.73  0.910580  0.906149  0.915033  0.910569
## 2          25   1524.34  0.886188  0.843195  0.931373  0.885093
## 3          21   1286.70  0.862251  0.924812  0.803922  0.860140
## 4          29   1797.43  0.860635  0.921348  0.803922  0.858639
## 5          30   1983.41  0.857501  0.995595  0.738562  0.848030
## ...       ...       ...       ...       ...       ...       ...
## 26          4   735.257  0.522340  0.377778  0.722222  0.496072
## 27          8   843.577  0.506555  0.377495  0.679739  0.485414
## 28          9   860.483  0.494632  0.351485  0.696078  0.467105
## 29          5   769.648  0.493097  0.402174  0.604575  0.483029
## 30         15  1128.353  0.462169  0.680851  0.313725  0.429530
```

```
image(mse, mz=coloc2$mz[1:3], layout=c(1,3))
```

![](data:image/png;base64...)

# 4 Classification and cross-validation

Classification of pixels into different known classes (e.g., cancer vs normal) based on the mass spectra is a common application for MS imaging.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
mse2 <- simulateImage(preset=7, dim=c(32,32), sdnoise=0.3,
    nrun=3, peakdiff=2, centroided=TRUE)

mse2$class <- makeFactor(A=mse2$circleA, B=mse2$circleB)

image(mse2, "class", layout=c(1,3))
```

![](data:image/png;base64...)

```
image(mse2, i=1, layout=c(1,3))
```

![](data:image/png;base64...)

When performing classification, it is important to use cross-validation so that reported accuracies are not overly optimistic.

We strongly recomend making sure that all spectra from the same experiment run belong to the same fold, to reduce predictive bias due to run effects.

## 4.1 Projection to latent structures (PLS)

Projection to latent structures (PLS), also called partial least squares, is a supervised dimension reduction technique. It can be thought of as being similar to PCA, but for classification or regression.

```
cv_pls <- crossValidate(PLS, x=mse2, y=mse2$class, ncomp=1:5, folds=run(mse2))
cv_pls
```

```
## SpatialCV on 30 variables and 3072 observations
## names(4): average, scores, folds, fitted.values
## coord(2): x = 1...32, y = 1...32
## runNames(3): run0, run1, run2
## modelData(): Cross validation with 3 folds
##
## Average accuracy:
##         MacroRecall MacroPrecision
## ncomp=1   0.6298995      0.7621948
## ncomp=2   0.6489648      0.7505800
## ncomp=3   0.8905553      0.9405018
## ncomp=4   0.9443562      0.9635675
## ncomp=5   0.9000440      0.9327320
```

We can see that 4 components gives the best accuracy.

```
pls <- PLS(mse2, y=mse2$class, ncomp=4)
pls
```

```
## SpatialPLS on 30 variables and 3072 observations
## names(16): coefficients, projection, residuals, ..., y.center, y.scale, algorithm
## coord(2): x = 1...32, y = 1...32
## runNames(3): run0, run1, run2
## modelData(): Partial least squares (k=4)
##
## Covariances (1, .., k=4):
##          C1         C2         C3         C4
##  128803.687  21559.656   5671.603  17340.727
##
## Coefficients:
##          [,1]        [,2]        [,3]        [,4]        [,5]        [,6] ...
## A -0.04217073 -0.04367902 -0.02538701 -0.02839424 -0.05470121 -0.03897474 ...
## B  0.04911078  0.04080329  0.03473352  0.03534424  0.05303916  0.04852552 ...
```

We can plot the fitted response values to visualize the prediction.

```
image(pls, type="response", layout=c(1,3), scale=TRUE)
```

![](data:image/png;base64...)

The PLS regression coefficients can be used to find influential features.

```
plot(pls, type="coefficients", linewidth=2, annPeaks="circle")
```

![](data:image/png;base64...)

Like PCA or NMF, it can be useful to plot the PLS scores against each other to visualize the separation between classes.

```
plot(pls, type="scores", groups=mse2$class, linewidth=2)
```

![](data:image/png;base64...)

Note that orthgonal PLS (O-PLS) is also available via `method="opls"` or by using the separate `OPLS()` method. Typically, both methods perform similarly, although O-PLS can sometimes produce more easily interpretable regression coefficients.

## 4.2 Spatial shrunken centroids classification

Spatially-aware nearest shrunken centroids classification is an extension of nearest shrunken centroids that incorporates spatial information into the model.

Like in the clustering case of spatial shrunken centroids, a smoothing radius `r` must be provided along with sparsity parameters `s`.

```
cv_ssc <- crossValidate(spatialShrunkenCentroids, x=mse2, y=mse2$class,
    r=2, s=c(0,3,6,9,12,15,18), folds=run(mse2))
cv_ssc
```

```
## SpatialCV on 30 variables and 3072 observations
## names(4): average, scores, folds, fitted.values
## coord(2): x = 1...32, y = 1...32
## runNames(3): run0, run1, run2
## modelData(): Cross validation with 3 folds
##
## Average accuracy:
##          MacroRecall MacroPrecision
## r=2,s=0    0.7585407      0.8187899
## r=2,s=3    0.7779484      0.8273597
## r=2,s=6    0.7917592      0.8342095
## r=2,s=9    0.7934147      0.8331224
## r=2,s=12   0.7934188      0.8269159
## r=2,s=15   0.7865585      0.8123568
## r=2,s=18   0.7826594      0.8023697
```

We can see that the model with `s=9` has the best cross-validated accuracy for the data. However, it does not perform as well as the PLS model.

```
ssc2 <- spatialShrunkenCentroids(mse2, y=mse2$class, r=2, s=9)
ssc2
```

```
## SpatialShrunkenCentroids on 30 variables and 3072 observations
## names(12): class, probability, scores, ..., transpose, weights, r
## coord(2): x = 1...32, y = 1...32
## runNames(3): run0, run1, run2
## modelData(): Nearest shrunken centroids (s=9.00) with 2 classes
##
## Priors (1, .., k=2):
##          A         B
##  0.5118644 0.4881356
##
## Statistics:
##               A          B
## [1,]  2.5272228 33.2508362
## [2,]  .         32.0924783
## [3,]  3.9335033 37.2254149
## [4,]  1.7678840 37.9907897
## [5,]  0.5325838 33.3179476
## [6,]  6.0201243 51.8815543
## ...         ...        ...
```

Again, we can plot the predicted class probabilities to visualize the prediction.

```
image(ssc2, type="probability", layout=c(1,3),
    subset=mse2$circleA | mse2$circleB)
```

![](data:image/png;base64...)

Plotting t-statistics shows most relevant peaks have a higher abundance in class “B”.

```
plot(ssc2, type="statistic", linewidth=2, annPeaks="circle")
```

![](data:image/png;base64...)

```
ssc2_top <- topFeatures(ssc2)

subset(ssc2_top, class == "B")
```

```
## DataFrame with 30 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1           6   795.911           B   51.8816   5.46947  0.824042
## 2           7   796.933           B   51.2422   5.40777  0.842293
## 3           9   860.483           B   47.1777   4.86009  0.670828
## 4          10   934.117           B   39.6140   3.88333  0.718556
## 5           4   735.257           B   37.9908   4.20438  0.878579
## ...       ...       ...         ...       ...       ...       ...
## 26         26   1629.57           B         0   2.93571  0.747214
## 27         27   1663.66           B         0   2.49509  0.718575
## 28         28   1721.92           B         0   3.64686  0.784547
## 29         29   1797.43           B         0   3.07770  0.785953
## 30         30   1983.41           B         0   3.07946  0.893279
```

# 5 Class comparison

Statistical hypothesis testing is used to determine whether the abundance of a feature is different between two or more conditions.

In order to account for additional factors like the effect of experimental runs, subject-to-subject variability, etc., this is often done most appropriately using linear models.

This example uses a simple experiment with two conditions “A” and “B”, with three replicates in each condition.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
mse3 <- simulateImage(preset=4, npeaks=10, dim=c(32,32), sdnoise=0.3,
    nrun=4, peakdiff=2, centroided=TRUE)

mse3$trt <- makeFactor(A=mse3$circleA, B=mse3$circleB)

image(mse3, "trt", layout=c(2,4))
```

![](data:image/png;base64...)

```
image(mse3, i=1, layout=c(2,4))
```

![](data:image/png;base64...)

We know from the design of the simulation that the first 5 (of 10) *m/z* values differ between the conditions.

```
featureData(mse3)
```

```
## MassDataFrame with 10 rows and 4 columns
##           mz   circleA   circleB      diff
##    <numeric> <numeric> <numeric> <logical>
## 1    707.896   2.78062   4.78062      TRUE
## 2    796.933   2.94643   4.94643      TRUE
## 3    860.483   2.69110   4.69110      TRUE
## 4   1011.540   2.89764   4.89764      TRUE
## 5   1063.117   2.80560   4.80560      TRUE
## 6   1173.871   2.93415   2.93415     FALSE
## 7   1340.725   2.57144   2.57144     FALSE
## 8   1497.288   2.63123   2.63123     FALSE
## 9   1524.336   2.92315   2.92315     FALSE
## 10  1983.406   2.62873   2.62873     FALSE
## mz(1): mz
```

## 5.1 Sample-based means testing

Use `meansTest()` to fit linear models with the most basic summarization. The samples must be specified with `samples`. Each sample is summarized by its mean, and then a linear model is fit to the summaries. In this case, each sample is a separate run.

Here, we specify `condition` as the sole fixed effect. Internally, the model will call either `lm()` or `lme()` depending on whether any random effects are provided.

```
mtest <- meansTest(mse3, ~ condition, samples=run(mse3))
mtest
```

```
## MeansTest of length 10
## model: lm
## DataFrame with 10 rows and 5 columns
##            i        mz                 fixed statistic     pvalue
##    <integer> <numeric>           <character> <numeric>  <numeric>
## 1          1   707.896 intensity ~ condition 7.3768722 0.00660680
## 2          2   796.933 intensity ~ condition 7.6179750 0.00577893
## 3          3   860.483 intensity ~ condition 7.8507953 0.00507984
## 4          4  1011.540 intensity ~ condition 2.8799166 0.08969067
## 5          5  1063.117 intensity ~ condition 0.4903302 0.48378003
## 6          6  1173.871 intensity ~ condition 1.9578100 0.16174773
## 7          7  1340.725 intensity ~ condition 0.0237729 0.87746420
## 8          8  1497.288 intensity ~ condition 0.0772954 0.78099666
## 9          9  1524.336 intensity ~ condition 9.7829948 0.00176133
## 10        10  1983.406 intensity ~ condition 0.0152349 0.90176691
```

By default, the models are summarized by performing likelihood ratio tests against the null model (with no fixed effects, retaining any random effects).

Box-and-whisker plots can be used to visualize the differences (if any) between the conditions.

```
plot(mtest, i=1:10, layout=c(2,5), ylab="Intensity", fill=TRUE)
```

![](data:image/png;base64...)

Use `topFeatures()` to rank the results.

```
mtest_top <- topFeatures(mtest)

subset(mtest_top, fdr < 0.05)
```

```
## DataFrame with 4 rows and 5 columns
##           i        mz statistic     pvalue       fdr
##   <integer> <numeric> <numeric>  <numeric> <numeric>
## 1         9  1524.336   9.78299 0.00176133  0.016517
## 2         3   860.483   7.85080 0.00507984  0.016517
## 3         2   796.933   7.61798 0.00577893  0.016517
## 4         1   707.896   7.37687 0.00660680  0.016517
```

We find 3 of the 5 differentially abundant features (and 1 false discovery).

## 5.2 Segment-based means testing

Testing of `SpatialDGMM` objects is also supported by `meansTest()`. The key idea here is that spatial-DGMM segmentation captures within-sample heterogeneity, so testing between spatial-DGMM segments is more sensitive that simply summarizing a whole sample by its mean.

First, we must segment the data with `spatialDGMM()`, while making sure that each sample is segmented independently (by specifying the samples as `groups`).

```
set.seed(2020, kind="L'Ecuyer-CMRG")
dgmm2 <- spatialDGMM(mse3, r=2, k=2, groups=run(mse3))
```

Now use `segmentationTest()` to fit the models.

```
stest <- meansTest(dgmm2, ~ condition)

stest
```

```
## MeansTest of length 10
## model: lm
## DataFrame with 10 rows and 5 columns
##            i        mz                 fixed   statistic      pvalue
##    <integer> <numeric>           <character>   <numeric>   <numeric>
## 1          1   707.896 intensity ~ condition  7.22776825 0.007178439
## 2          2   796.933 intensity ~ condition  5.46948407 0.019351337
## 3          3   860.483 intensity ~ condition  9.99367596 0.001570787
## 4          4  1011.540 intensity ~ condition  4.77919705 0.028805549
## 5          5  1063.117 intensity ~ condition  4.29576550 0.038207392
## 6          6  1173.871 intensity ~ condition  2.41003165 0.120559929
## 7          7  1340.725 intensity ~ condition  1.38439604 0.239353759
## 8          8  1497.288 intensity ~ condition  0.00955486 0.922131639
## 9          9  1524.336 intensity ~ condition 11.38720105 0.000739519
## 10        10  1983.406 intensity ~ condition  0.81771965 0.365847730
```

As with `meansTest()`, the models are summarized by performing likelihood ratio tests against the null model (with no fixed effects, retaining any random effects).

Box-and-whisker plots can be used to visually compare the conditions.

```
plot(stest, i=1:10, layout=c(2,5), ylab="Intensity", fill=TRUE)
```

![](data:image/png;base64...)

Use `topFeatures()` to rank the results.

```
stest_top <- topFeatures(stest)

subset(stest_top, fdr < 0.05)
```

```
## DataFrame with 4 rows and 5 columns
##           i        mz statistic      pvalue        fdr
##   <integer> <numeric> <numeric>   <numeric>  <numeric>
## 1         9  1524.336  11.38720 0.000739519 0.00739519
## 2         3   860.483   9.99368 0.001570787 0.00785394
## 3         1   707.896   7.22777 0.007178439 0.02392813
## 4         2   796.933   5.46948 0.019351337 0.04837834
```

We find 3 of the 5 differentially abundant features (and 1 false discovery).

# 6 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## Random number generation:
##  RNG:     L'Ecuyer-CMRG
##  Normal:  Inversion
##  Sample:  Rejection
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
## [1] Cardinal_3.12.1     S4Vectors_0.48.0    ProtGenerics_1.42.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      BiocParallel_1.44.0
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        EBImage_4.52.0      jsonlite_2.0.0
##  [4] matter_2.12.0       compiler_4.5.2      BiocManager_1.30.27
##  [7] Rcpp_1.1.1          tinytex_0.58        Biobase_2.70.0
## [10] magick_2.9.0        bitops_1.0-9        parallel_4.5.2
## [13] jquerylib_0.1.4     CardinalIO_1.8.0    png_0.1-8
## [16] yaml_2.3.12         fastmap_1.2.0       lattice_0.22-9
## [19] R6_2.6.1            knitr_1.51          htmlwidgets_1.6.4
## [22] ontologyIndex_2.12  bookdown_0.46       fftwtools_0.9-11
## [25] bslib_0.10.0        tiff_0.1-12         rlang_1.1.7
## [28] cachem_1.1.0        xfun_0.56           sass_0.4.10
## [31] otel_0.2.0          cli_3.6.5           magrittr_2.0.4
## [34] digest_0.6.39       grid_4.5.2          locfit_1.5-9.12
## [37] irlba_2.3.7         nlme_3.1-168        lifecycle_1.0.5
## [40] evaluate_1.0.5      codetools_0.2-20    abind_1.4-8
## [43] RCurl_1.98-1.17     rmarkdown_2.30      tools_4.5.2
## [46] jpeg_0.1-11         htmltools_0.5.9
```