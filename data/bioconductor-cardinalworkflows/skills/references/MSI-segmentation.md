# Segmentation of MS imaging experiments with Cardinal

Kylie Ariel Bemis

#### Revised: September 12, 2024

# Contents

* [1 Introduction](#introduction)
* [2 Segmentation of a pig fetus wholy body cross section](#segmentation-of-a-pig-fetus-wholy-body-cross-section)
  + [2.1 Pre-processing](#pre-processing)
  + [2.2 Visualization](#visualization)
    - [2.2.1 Ion images](#ion-images)
    - [2.2.2 Principal components analysis (PCA)](#principal-components-analysis-pca)
    - [2.2.3 Non-negative matrix factorization (NMF)](#non-negative-matrix-factorization-nmf)
  + [2.3 Segmentation with spatial shrunken centroids (SSC)](#segmentation-with-spatial-shrunken-centroids-ssc)
    - [2.3.1 Plotting the segmentation](#plotting-the-segmentation)
    - [2.3.2 Plotting the (shrunken) mean spectra](#plotting-the-shrunken-mean-spectra)
    - [2.3.3 Plotting and interpretting t-statistics of the *m/z* values](#plotting-and-interpretting-t-statistics-of-the-mz-values)
    - [2.3.4 Retrieving the top *m/z* values](#retrieving-the-top-mz-values)
* [3 Segmentation of a cardinal painting](#segmentation-of-a-cardinal-painting)
  + [3.1 Pre-processing](#pre-processing-1)
  + [3.2 Segmentation with SSC](#segmentation-with-ssc)
* [4 Session information](#session-information)

# 1 Introduction

The goal of unsupervised analysis of mass spectrometry (MS) imaging experiments is to discover regions in the data with distinct chemical profiles, and to select the *m/z* values that uniquely distinguish these different regions from each other.

Algorithmically, this means clustering the data. In imaging experiments, the resulting cluster configurations are called spatial segmentations, and the clusters are called segments.

In this vignette, we present an example segmentation workflow using *Cardinal*.

We begin by loading the package:

```
library(Cardinal)
```

# 2 Segmentation of a pig fetus wholy body cross section

This example uses the PIGII\_206 dataset: a cross section of a pig fetus captured using a Thermo LTQ instrument using desorption electrospray ionization (DESI).

First, we load the dataset from the *CardinalWorkflows* package using `exampleMSIData()`.

```
pig206 <- CardinalWorkflows::exampleMSIData("pig206")
```

The dataset contains 4,959 spectra with 10,200 *m/z* values.

```
pig206
```

```
## MSImagingExperiment with 10200 features and 4959 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(3): x, y, run
## coord(2): x = 10...120, y = 1...66
## runNames(1): PIGII_206
## mass range:  150.0833 to 1000.0000
## centroided: FALSE
```

![](data:image/png;base64...)

Optical image of the pig fetus section

In the optical image shown above, the brain (left), heart (center), and liver (large dark region) are clearly visible.

```
image(pig206, mz=885.5, tolerance=0.5, units="mz")
```

![](data:image/png;base64...)

The dataset has been cropped to remove the background slide pixels, leaving only the tissue section itself for analysis.

## 2.1 Pre-processing

For statistical analysis, it is useful to reduce the dataset to include only the peaks.

We calculate the mean spectrum using `summarizeFeatures()`.

```
pig206 <- summarizeFeatures(pig206, c(Mean="mean"))
```

```
plot(pig206, "Mean", xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

In order to make the mass spectra comparable between different pixels, it is necessary to normalize the data. We will use TIC normalization.

Let’s calculate the TIC to see how it currently varies across the dataset in the raw, unprocessed specra.

```
pig206 <- summarizePixels(pig206, c(TIC="sum"))
```

```
image(pig206, "TIC")
```

![](data:image/png;base64...)

To process the dataset, we will use `peakProcess()` to perform peak picking on a subset of the mass spectra, and then use these as a reference to summarize the peaks in every mass spectrum in the dataset.

We use `sampleSize=0.1` to indicate we want to perform peak picking on 10% of spectra to create the reference peaks. `SNR=3` indicates the signal-to-noise ratio threshold to peak detection. And `tolerance=0.5` indicates the minimum distance between peaks. (Peaks closer together than this are merged.)

```
pig206_peaks <- pig206 |>
    normalize(method="tic") |>
    peakProcess(SNR=3, sampleSize=0.1,
        tolerance=0.5, units="mz")

pig206_peaks
```

```
## MSImagingExperiment with 687 features and 4959 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(4): x, y, run, TIC
## coord(2): x = 10...120, y = 1...66
## runNames(1): PIGII_206
## metadata(1): processing_20251104111729
## mass range: 150.2917 to 999.8333
## centroided: TRUE
```

This produces a centroided dataset with 687 peaks.

## 2.2 Visualization

Before proceeding with the statistical analysis, we’ll first perform some and exploratory visual analysis of the dataset.

### 2.2.1 Ion images

Below, we plot several hand-selected peaks corresponding to major organs.

*m/z* 187 appears highly abundant in the heart.

```
image(pig206_peaks, mz=187.36)
```

![](data:image/png;base64...)

*m/z* 840 appears highly abundant in the brain and spinal cord.

```
image(pig206_peaks, mz=840.43)
```

![](data:image/png;base64...)

*m/z* 537 appears highly abundant in the liver.

```
image(pig206_peaks, mz=537.08)
```

![](data:image/png;base64...)

Rather than manually going the full dataset and hand-selecting peaks, the goal of our statistical analysis will be to automatically select the peaks that distinguish such regions (e.g., the major organs).

### 2.2.2 Principal components analysis (PCA)

Principal component analysis (PCA) is a popular method for exploring a dataset. PCA is available in *Cardinal* through the `PCA()` method.

Below, we calculate the first 3 principal components.

```
pig206_pca <- PCA(pig206_peaks, ncomp=3)

pig206_pca
```

```
## SpatialPCA on 687 variables and 4959 observations
## names(5): sdev, rotation, center, scale, x
## coord(2): x = 10...120, y = 1...66
## runNames(1): PIGII_206
## modelData(): Principal components (k=3)
##
## Standard deviations (1, .., k=3):
##       PC1      PC2      PC3
##  56.48327 32.37418 21.94714
##
## Rotation (n x k) = (687 x 3):
##                PC1           PC2           PC3
## [1,]  0.0065471300  0.0070376319  0.0006104194
## [2,]  0.0500922072 -0.0080335867  0.0202450548
## [3,]  0.0509196160 -0.0320650258  0.0269319585
## [4,]  0.0198012214 -0.0135729648  0.0088659578
## [5,]  0.0349473853  0.0050267457 -0.0106713575
## [6,]  0.0636922031  0.0229462193  0.0373597331
## ...            ...           ...           ...
```

Next, we overlay the first 3 principal components.

```
image(pig206_pca, smooth="adaptive", enhance="histogram")
```

![](data:image/png;base64...)

We can plot the loadings for the principal components as well.

```
plot(pig206_pca, linewidth=2)
```

![](data:image/png;base64...)

PCA can sometimes be useful for exploring a dataset. For example, here, we can see that PC3 appears to distinguish the liver, but also includes other structures. This makes it difficult to fully utilize PCA for analysis.

### 2.2.3 Non-negative matrix factorization (NMF)

Non-negative matrix factorization (NMF) is a popular alternative to PCA. It is similar to PCA, but produces non-negative loadings, which can make it easier to interpret and more suited to spectral data. NMF is available in *Cardinal* through the `NMF()` method.

Below, we calculate the first 3 NMF components.

```
pig206_nmf <- NMF(pig206_peaks, ncomp=3, niter=30)

pig206_nmf
```

```
## SpatialNMF on 687 variables and 4959 observations
## names(4): activation, x, iter, transpose
## coord(2): x = 10...120, y = 1...66
## runNames(1): PIGII_206
## modelData(): Non-negative matrix factorization (k=3)
##
## Activation (n x k) = (687 x 3):
##             C1        C2        C3
## [1,] 0.6071011 0.2020845 0.0000000
## [2,] 1.8608954 2.6511342 0.0000000
## [3,] 0.5065333 2.9905795 0.0000000
## [4,] 0.1363037 1.1769158 0.0000000
## [5,] 2.4890613 1.8862063 0.1213924
## [6,] 4.1351156 2.8922698 0.0000000
## ...        ...       ...       ...
```

Next, we overlay the first 3 NMF components.

```
image(pig206_nmf, smooth="adaptive", enhance="histogram")
```

![](data:image/png;base64...)

We can plot the loadings for the NMF components as well.

```
plot(pig206_nmf, linewidth=2)
```

![](data:image/png;base64...)

NMF seems to distinguish the morphology better than PCA in this case.

## 2.3 Segmentation with spatial shrunken centroids (SSC)

To segment the dataset and automatically select peaks that distinguish each region, we will use the `spatialShrunkenCentroids()` method provided by *Cardinal*.

Important parameters to this method include:

* `weights` The type of spatial weights to use:

  + *“gaussian”* weights use a simple Gaussian smoothing kernel
  + *“adaptive”* weights use an adaptive kernel that sometimes preserve edges better
* `r` The neighborhood smoothing radius; this should be selected based on the size and granularity of the spatial regions in your dataset
* `k` The maximum number of segments to try; empty segments are dropped, so the resulting segmentation may use fewer than this number.
* `s` The shrinkage or sparsity parameter; the higher this number, the fewer peaks will be used to determine the final segmentation.

It can be usefel to set `k` relatively high and let the algorithm drop empty segments. You typically want to try a wide range of sparsity with the `s` parameter.

```
set.seed(1)
pig206_ssc <- spatialShrunkenCentroids(pig206_peaks,
    weights="adaptive", r=2, k=8, s=2^(1:6))

pig206_ssc
```

```
## ResultsList of length 6
## names(6): r=2,k=8,s=2 r=2,k=8,s=4 r=2,k=8,s=8 r=2,k=8,s=16 r=2,k=8,s=32 r=2,k=8,s=64
## model: SpatialShrunkenCentroids
## DataFrame with 6 rows and 8 columns
##                      r         k         s     weights  clusters  sparsity
##              <numeric> <numeric> <numeric> <character> <numeric> <numeric>
## r=2,k=8,s=2          2         8         2    adaptive         8      0.24
## r=2,k=8,s=4          2         8         4    adaptive         8      0.43
## r=2,k=8,s=8          2         8         8    adaptive         8      0.68
## r=2,k=8,s=16         2         8        16    adaptive         8      0.88
## r=2,k=8,s=32         2         8        32    adaptive         6      0.97
## r=2,k=8,s=64         2         8        64    adaptive         3      0.99
##                    AIC       BIC
##              <numeric> <numeric>
## r=2,k=8,s=2    9829.30  41319.65
## r=2,k=8,s=4    7767.17  32514.23
## r=2,k=8,s=8    5119.65  20962.45
## r=2,k=8,s=16   3212.69  11804.52
## r=2,k=8,s=32   2371.06   7773.49
## r=2,k=8,s=64   3586.16   8220.54
```

This produces a `ResultsList` of the 6 fitted models.

As shown in the metadata columns, the number of resulting segments (`clusters`) is fewer for higher values of `s`. This is because fewer peaks are used to determine the segmentation.

Larger values of `s` will remove non-informative peaks, but very large values of `s` may remove meaningful peaks too. For very large values of `s`, morphological structures will begin to disappear from the segmentation. The most interesting and useful segmentations tend to be the ones with the highest value of `s` that still show meaningful morphology.

We can also look at the `AIC` and `BIC` values to help guide our choice of what segmentation to explore further. Smaller values are better, but small differences become less meaningful.

In this case, the last 2 models (`s=32` and `s=64`) seem to be much better from the previous models. However, the model for `s=32` supports 6 segments, while the model for `s=64` only supports 3 segments.

### 2.3.1 Plotting the segmentation

Let’s plot the 4 most sparse segmentations.

```
image(pig206_ssc, i=3:6)
```

![](data:image/png;base64...)

It is useful to see how the segmentation changes as fewer peaks are used and the number of segments decreases. Noisy, less-meaningful segments tend to be removed first, so we want to explore the segmentation with the highest value of `s` that still captures the morphology we would expect to see. At `s=64`, the heart segment is lost. We will choose the most sparse segmentation that still includes the heart.

```
pig206_ssc1 <- pig206_ssc[[5]]

image(pig206_ssc1)
```

![](data:image/png;base64...)

Note that the translucent colors that don’t appear to belong to any segment indicate areas of low probability (i.e., high uncertainty in the segmentation).

We can plot the segment assignments instead of the probabilities to see the exact segmentation.

```
image(pig206_ssc1, type="class")
```

![](data:image/png;base64...)

Here, we can see the liver, heart, and brain distinguished as segments 4, 5, and 6.

### 2.3.2 Plotting the (shrunken) mean spectra

Plotting the shrunken centroids is analogous to plotting the mean spectrum of each segment.

```
plot(pig206_ssc1, type="centers", linewidth=2)
```

![](data:image/png;base64...)

Let’s break out the centroids for the liver, heart, and brain segments (4, 5, and 6).

```
plot(pig206_ssc1, type="centers", linewidth=2,
    select=c(4,5,6), superpose=FALSE, layout=c(1,3))
```

![](data:image/png;base64...)

Some differences are visible, but it can be difficult to tell exactly which peaks are changing between different segments based on the (shrunken) mean spectra alone.

### 2.3.3 Plotting and interpretting t-statistics of the *m/z* values

Plotting the t-statistics tells us exactly the relationship between each segment’s centroid and the global mean spectrum. The t-statistics are the difference between a segment’s centroid and the global mean, divided by a standard error.

Positive t-statistics indicate that peak is systematically higher intensity in that segment relative to the (global) mean spectrum.

Negative t-statistics indicate that peak is systematically lower intensity in that segment relative to the (global) mean spectrum.

Spatial shrunken centroids works by shrinking these t-statistics toward 0 by `s`, and using the new t-statistics to recompute the segment centroids. The effect is that peaks that are not very different between a specific segment and the global mean are effectively eliminated from the segmentation.

```
plot(pig206_ssc1, type="statistic", linewidth=2)
```

![](data:image/png;base64...)

If we break out the t-statistics for the heart, liver, and brain segments we can learn something interesting.

```
plot(pig206_ssc1, type="statistic", linewidth=2,
    select=c(4,5,6), superpose=FALSE, layout=c(1,3))
```

![](data:image/png;base64...)

Very few peaks distinguish the heart (segment 5), while many more distinguish the liver and brain (segments 4 and 6).

### 2.3.4 Retrieving the top *m/z* values

Use the `topFeatures()` method to extract the *m/z* values of the peaks that most distinguish each segment, ranked by t-statistic.

```
pig206_ssc_top <- topFeatures(pig206_ssc1)
```

Peaks associated with the liver:

```
subset(pig206_ssc_top, class==4 & statistic > 0)
```

```
## DataFrame with 32 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1         289   537.106           4  118.1747   25.7564   2.96740
## 2         287   535.136           4  108.0515   18.2497   2.20841
## 3         306   563.077           4  107.4249   22.9829   3.00747
## 4         269   509.032           4   64.6042   11.2577   1.62113
## 5          83   253.573           4   44.8462   15.4211   2.81615
## ...       ...       ...         ...       ...       ...       ...
## 28        470   773.540           4  11.09341   2.89115   1.09850
## 29        579   889.566           4   8.08681   4.53182   1.75686
## 30        297   549.093           4   7.22217   3.92227   1.26671
## 31        270   510.239           4   5.56819   2.58318   1.13918
## 32        291   539.149           4   3.83563   4.79113   1.46118
```

Peaks associated with the heart:

```
subset(pig206_ssc_top, class==5 & statistic > 0)
```

```
## DataFrame with 2 rows and 6 columns
##           i        mz       class statistic   centers        sd
##   <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1        30   187.360           5   45.2865  48.04289   9.07711
## 2        29   186.358           5   22.0932   8.36483   2.39535
```

Peaks associated with the brain:

```
subset(pig206_ssc_top, class==6 & statistic > 0)
```

```
## DataFrame with 20 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1         533   840.431           6   36.8424   11.5145   3.07742
## 2         531   838.411           6   31.4069    7.7430   2.25276
## 3         575   885.568           6   31.3095   20.9094   6.25210
## 4         527   834.425           6   30.5606   10.0616   3.82043
## 5         128   305.472           6   30.1676   11.9883   3.24396
## ...       ...       ...         ...       ...       ...       ...
## 16        463   766.396           6  4.784931   6.33422   1.93903
## 17        150   333.582           6  4.548003   3.35320   1.92260
## 18        505   811.448           6  3.872509   4.05674   2.23656
## 19        529   836.311           6  1.302794   7.31574   2.51954
## 20        532   839.461           6  0.409365   3.02466   1.77519
```

The top *m/z* values for each segment match up well with the hand-selected peaks.

# 3 Segmentation of a cardinal painting

It can be difficult to evaluate unsupervised methods (like segmentation) on data where we do not know the ground truth.

In this section, we use an MS image of a painting, where we know the ground truth.

```
cardinal <- CardinalWorkflows::exampleMSIData("cardinal")
```

![](data:image/png;base64...)

Oil painting of a cardinal

In this experiment, DESI spectra were collected from an oil painting of a cardinal.

```
cardinal
```

```
## MSImagingExperiment with 10800 features and 12600 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(3): x, y, run
## coord(2): x = 1...120, y = 1...105
## runNames(1): Bierbaum_demo_
## mass range:  100.0833 to 1000.0000
## centroided: FALSE
```

The dataset includes 12,600 spectra with 10,800 *m/z* values.

## 3.1 Pre-processing

We will begin by visualizing the mean spectrum as before.

```
cardinal <- summarizeFeatures(cardinal, c(Mean="mean"))
```

```
plot(cardinal, "Mean", xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

And the total ion current.

```
cardinal <- summarizePixels(cardinal, c(TIC="sum"))
```

```
image(cardinal, "TIC")
```

![](data:image/png;base64...)

We will pre-process the dataset as before, by applying peak picking to 10% of the spectra and then summarizing these peaks for every spectrum.

```
cardinal_peaks <- cardinal |>
    normalize(method="tic") |>
    peakProcess(SNR=3, sampleSize=0.1,
        tolerance=0.5, units="mz")

cardinal_peaks
```

```
## MSImagingExperiment with 929 features and 12600 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(4): x, y, run, TIC
## coord(2): x = 1...120, y = 1...105
## runNames(1): Bierbaum_demo_
## metadata(1): processing_20251104111853
## mass range: 100.9923 to 999.5854
## centroided: TRUE
```

This results in a centroided dataset with 929 peaks.

## 3.2 Segmentation with SSC

Now we use spatial shrunken centroids to segment the dataset.

```
set.seed(1)
cardinal_ssc <- spatialShrunkenCentroids(cardinal_peaks,
    weights="adaptive", r=2, k=8, s=2^(1:6))
```

```
## Warning: Quick-TRANSfer stage steps exceeded maximum (= 630000)
```

```
cardinal_ssc
```

```
## ResultsList of length 6
## names(6): r=2,k=8,s=2 r=2,k=8,s=4 r=2,k=8,s=8 r=2,k=8,s=16 r=2,k=8,s=32 r=2,k=8,s=64
## model: SpatialShrunkenCentroids
## DataFrame with 6 rows and 8 columns
##                      r         k         s     weights  clusters  sparsity
##              <numeric> <numeric> <numeric> <character> <numeric> <numeric>
## r=2,k=8,s=2          2         8         2    adaptive         8      0.59
## r=2,k=8,s=4          2         8         4    adaptive         8      0.81
## r=2,k=8,s=8          2         8         8    adaptive         8      0.92
## r=2,k=8,s=16         2         8        16    adaptive         8      0.97
## r=2,k=8,s=32         2         8        32    adaptive         7      0.98
## r=2,k=8,s=64         2         8        64    adaptive         5      0.99
##                    AIC       BIC
##              <numeric> <numeric>
## r=2,k=8,s=2    9517.27   38881.2
## r=2,k=8,s=4    6498.76   23696.0
## r=2,k=8,s=8    5621.88   16687.3
## r=2,k=8,s=16   6448.39   15162.3
## r=2,k=8,s=32   7817.99   15482.7
## r=2,k=8,s=64   6952.33   14133.3
```

```
image(cardinal_ssc, i=3:6)
```

![](data:image/png;base64...)

We can see increasing higher sparsities result in lose the “wing” segment, so we will choose the most sparse segmentation that retains the cardinal’s wings.

Now we can use the segmentation to re-construct the original painting.

```
cardinal_ssc1 <- cardinal_ssc[[3]]

pal <- c("1"=NA, "2"="firebrick", "3"=NA, "4"="black",
    "5"="red", "6"="gray", "7"=NA, "8"="darkred")

image(cardinal_ssc1, col=pal)
```

![](data:image/png;base64...)

Let’s find the *m/z* values associated with the cardinal’s body.

```
cardinal_ssc_top <- topFeatures(cardinal_ssc1)

subset(cardinal_ssc_top, class==5)
```

```
## DataFrame with 929 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1         100   207.051           5   254.262  233.1202   22.4128
## 2         169   277.033           5   211.766  139.1255   15.0486
## 3         182   290.988           5   175.537  105.2283   12.7141
## 4         297   418.874           5   154.018   98.9911   14.8391
## 5         216   327.133           5   117.054   66.5980   10.4429
## ...       ...       ...         ...       ...       ...       ...
## 925        50   157.098           5  -80.4969   31.1409   19.2454
## 926       175   283.239           5  -81.6780   18.3817   18.5401
## 927       134   241.153           5  -84.1666   15.4854   15.6296
## 928       120   227.182           5  -97.8311   18.7459   18.5312
## 929       148   255.229           5 -124.9192   34.8702   31.3986
```

```
image(cardinal_peaks, mz=207.05, smooth="guided", enhance="histogram")
```

![](data:image/png;base64...)

And let’s find the *m/z* values associated with the “DESI-MS” text.

```
subset(cardinal_ssc_top, class==2)
```

```
## DataFrame with 929 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1         487   648.999           2  161.4926  269.9236  36.57814
## 2         488   650.155           2  124.4383  101.7906  14.95678
## 3         489   651.132           2   40.3626   20.6268   6.10854
## 4         336   473.026           2   29.2708   19.5684   8.13424
## 5         503   664.751           2   26.4676   13.8407   5.81793
## ...       ...       ...         ...       ...       ...       ...
## 925       175   283.239           2  -26.1172   50.5043   18.5401
## 926       162   269.155           2  -26.9751   23.5159   12.3435
## 927       134   241.153           2  -40.2095   34.7970   15.6296
## 928       120   227.182           2  -46.9775   44.0954   18.5312
## 929       148   255.229           2  -51.1971   95.9676   31.3986
```

```
image(cardinal_peaks, mz=648.99, smooth="guided", enhance="histogram")
```

![](data:image/png;base64...)

# 4 Session information

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
## [1] Cardinal_3.12.0     S4Vectors_0.48.0    ProtGenerics_1.42.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      BiocParallel_1.44.0
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4             EBImage_4.52.0           jsonlite_2.0.0
##  [4] matter_2.12.0            compiler_4.5.1           BiocManager_1.30.26
##  [7] Rcpp_1.1.0               tinytex_0.57             Biobase_2.70.0
## [10] magick_2.9.0             bitops_1.0-9             parallel_4.5.1
## [13] jquerylib_0.1.4          CardinalIO_1.8.0         png_0.1-8
## [16] yaml_2.3.10              fastmap_1.2.0            lattice_0.22-7
## [19] R6_2.6.1                 CardinalWorkflows_1.42.0 knitr_1.50
## [22] htmlwidgets_1.6.4        ontologyIndex_2.12       bookdown_0.45
## [25] fftwtools_0.9-11         bslib_0.9.0              tiff_0.1-12
## [28] rlang_1.1.6              cachem_1.1.0             xfun_0.54
## [31] sass_0.4.10              cli_3.6.5                magrittr_2.0.4
## [34] digest_0.6.37            grid_4.5.1               locfit_1.5-9.12
## [37] irlba_2.3.5.1            nlme_3.1-168             lifecycle_1.0.4
## [40] evaluate_1.0.5           codetools_0.2-20         abind_1.4-8
## [43] RCurl_1.98-1.17          rmarkdown_2.30           tools_4.5.1
## [46] jpeg_0.1-11              htmltools_0.5.8.1
```