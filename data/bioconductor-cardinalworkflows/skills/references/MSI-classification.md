# Classification of MS imaging experiments with Cardinal

Kylie Ariel Bemis

#### Revised: September 12, 2024

# Contents

* [1 Introduction](#introduction)
* [2 Classification of a renal cell carcinoma (RCC) cancer dataset](#classification-of-a-renal-cell-carcinoma-rcc-cancer-dataset)
  + [2.1 Pre-processing](#pre-processing)
  + [2.2 Visualization](#visualization)
    - [2.2.1 Ion images](#ion-images)
    - [2.2.2 Principal components analysis (PCA)](#principal-components-analysis-pca)
    - [2.2.3 Non-negative matrix factorization (NMF)](#non-negative-matrix-factorization-nmf)
  + [2.3 Classification with spatial shrunken centroids (SSC)](#classification-with-spatial-shrunken-centroids-ssc)
    - [2.3.1 Cross-validation with SSC](#cross-validation-with-ssc)
    - [2.3.2 Plotting the classified images](#plotting-the-classified-images)
    - [2.3.3 Plotting the (shrunken) mean spectra](#plotting-the-shrunken-mean-spectra)
    - [2.3.4 Plotting and interpretting t-statistics of the *m/z* values](#plotting-and-interpretting-t-statistics-of-the-mz-values)
    - [2.3.5 Retrieving the top *m/z*-values](#retrieving-the-top-mz-values)
* [3 Multiple instance learning (MIL)](#multiple-instance-learning-mil)
  + [3.1 Preparing the samples (bags)](#preparing-the-samples-bags)
  + [3.2 Cross-validation with MIL](#cross-validation-with-mil)
* [4 Additional notes on cross-validation](#additional-notes-on-cross-validation)
* [5 Session information](#session-information)

# 1 Introduction

For experiments in which analyzed samples come from different classes or conditions, a common goal of supervised analysis is classification: given a labeled training set for which classes are already known, we want to predict the class of a new sample.

Unlike unsupervised analysis such as segmentation, classification requires biological replicates for testing and validation, to avoid biased reporting of accuracy. *Cardinal* provides cross-validation for this purpose.

In this vignette, we present an example classification workflow using *Cardinal*.

We begin by loading the package:

```
library(Cardinal)
```

# 2 Classification of a renal cell carcinoma (RCC) cancer dataset

This example uses DESI spectra collected from a renal cell carcinoma (RCC) cancer dataset consisting of 8 matched pairs of human kidney tissue. Each tissue pair consists of a normal tissue sample and a cancerous tissue sample. The goal of the workflow is to develop classifiers for predicting whether a new tissue sample is normal or cancer.

| MH0204\_33 | UH0505\_12 | UH0710\_33 | UH9610\_15 |
| --- | --- | --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) | ![](data:image/png;base64...) | ![](data:image/png;base64...) |

| UH9812\_03 | UH9905\_18 | UH9911\_05 | UH9912\_01 |
| --- | --- | --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) | ![](data:image/png;base64...) | ![](data:image/png;base64...) |

In this RCC dataset, we expect that normal tissue and cancerous tissue will have unique chemical profiles, which we can use to classify new tissue based on the mass spectra.

First, we load the dataset from the *CardinalWorkflows* package using `exampleMSIData()`.

```
rcc <- CardinalWorkflows::exampleMSIData("rcc")
```

The dataset contains 16,000 spectra with 10,200 *m/z*-values.

```
rcc
```

```
## MSImagingExperiment with 10200 features and 16000 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(4): x, y, run, diagnosis
## coord(2): x = 1...99, y = 1...38
## runNames(8): MH0204_33, UH0505_12, UH0710_33, ..., UH9905_18, UH9911_05, UH9912_01
## mass range:  150.08 to 1000.00
## centroided: FALSE
```

We can visualize the diagnoses:

```
image(rcc, "diagnosis", layout=c(2,4), free="xy", col=dpal("Set1"))
```

![](data:image/png;base64...)

As can be seen above, each matched pair of tissues belonging to the same subject are on the same slide (i.e., the same run). Note also the the cancer tissue is on the left and the normal tissue is on the right on each slide.

## 2.1 Pre-processing

First, let’s visualize the total ion current.

```
rcc <- summarizePixels(rcc, stat=c(TIC="sum"))
```

```
image(rcc, "TIC", layout=c(2,4), free="xy")
```

![](data:image/png;base64...)

Clearly there is pixel-to-pixel variation in in the total ion current.

We will normalize the TIC and perform peak picking on all spectra.

```
rcc_peaks <- rcc |>
    normalize(method="tic") |>
    peakProcess(SNR=3, filterFreq=FALSE,
        tolerance=0.5, units="mz")

rcc_peaks
```

```
## MSImagingExperiment with 753 features and 16000 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(5): x, y, run, diagnosis, TIC
## coord(2): x = 1...99, y = 1...38
## runNames(8): MH0204_33, UH0505_12, UH0710_33, ..., UH9905_18, UH9911_05, UH9912_01
## metadata(2): processing_20251104111012, processing_20251104111015
## mass range: 151.2376 to 999.4412
## centroided: TRUE
```

This produces a centroided dataset with 753 peaks.

Note that we have performed peak picking on all spectra, rather than peak picking on a subset and then summarizing (as we did in the “Segmentation” workflow). This is so we have independent peaks for every spectrum that were not selected based on information from any other spectra. Therefore, we can use these peaks in cross-validation (after re-aligning them independently within each training set).

We will also create a subset of the dataset that excludes the background pixels.

```
rcc_nobg <- subsetPixels(rcc_peaks, !is.na(diagnosis))
rcc_nobg
```

```
## MSImagingExperiment with 753 features and 6077 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(5): x, y, run, diagnosis, TIC
## coord(2): x = 2...91, y = 2...37
## runNames(8): MH0204_33, UH0505_12, UH0710_33, ..., UH9905_18, UH9911_05, UH9912_01
## metadata(2): processing_20251104111012, processing_20251104111015
## mass range: 151.2376 to 999.4412
## centroided: TRUE
```

## 2.2 Visualization

Before proceeding with the statistical analysis, we’ll first perform some exploratory visual analysis of the dataset.

### 2.2.1 Ion images

Let’s plot the images for *m/z* 810, which appears abundant in both normal and tumor tissue, and doesn’t seem to be very predictive.

```
image(rcc_peaks, mz=810.36, layout=c(2,4), free="xy",
    smooth="bilateral", enhance="histogram", scale=TRUE)
```

![](data:image/png;base64...)

We will also visualize *m/z* 855, which appears slightly more abundant in the tumor tissue (left).

```
image(rcc_peaks, mz=886.43, layout=c(2,4), free="xy",
    smooth="bilateral", enhance="histogram", scale=TRUE)
```

![](data:image/png;base64...)

Lastly, we will also visualize *m/z* 215, which appears more abundant in the normal tissue (right).

```
image(rcc_peaks, mz=215.24, layout=c(2,4), free="xy",
    smooth="bilateral", enhance="histogram", scale=TRUE)
```

![](data:image/png;base64...)

We can also note that runs “UH0505\_12” and “UH9905\_18” have very heterogenous tumor tissues, with what appear to be large sections of normal tissue.

### 2.2.2 Principal components analysis (PCA)

Principal component analysis (PCA) is an unsupervised method for exploring a dataset. PCA is available in *Cardinal* through the `PCA()` method.

Below, we calculate the first 2 principal components. Note that PCA does not use any information about the diagnosis.

```
rcc_pca <- PCA(rcc_nobg, ncomp=2)
```

We can overlay the PC scores of the first 2 principal components. It doesn’t appear that either component distinguishes the diagnoses.

```
image(rcc_pca, type="x", layout=c(2,4), free="xy", scale=TRUE)
```

![](data:image/png;base64...)

We can plot the scores of the first 2 components against each other to see how they separate the diagnoses (or don’t, in this case).

```
plot(rcc_pca, type="x", groups=rcc_nobg$diagnosis, shape=20)
```

![](data:image/png;base64...)

It doesn’t appear that PCA separates cancer versus normal tissue. At least, not the first 2 components.

PCA is also a useful way to visualize how much each run clusters together. A large amount of variation in the data tends to be variation between experimental runs. This is why it’s useful to have matched pairs on the same slide.

```
plot(rcc_pca, type="x", groups=run(rcc_nobg), shape=20)
```

![](data:image/png;base64...)

### 2.2.3 Non-negative matrix factorization (NMF)

Non-negative matrix factorization (NMF) is a popular alternative to PCA. It is similar to PCA, but produces non-negative loadings, which can make it easier to interpret and more suited to spectral data. NMF is available in *Cardinal* through the `NMF()` method.

Below, we calculate the first 2 NMF components. Like PCA, NMF does not use any information about the diagnosis.

```
rcc_nmf <- NMF(rcc_nobg, ncomp=2, niter=5)
```

We can overlay the scores of the first 2 NMF components. It looks like the 1st component correlates to tumor and the 2nd component correlates to normal.

```
image(rcc_nmf, type="x", layout=c(2,4), free="xy", scale=TRUE)
```

![](data:image/png;base64...)

We can plot the scores of the first 2 components against each other to see how they separate the diagnoses (or don’t, in this case).

```
plot(rcc_nmf, type="x", groups=rcc_nobg$diagnosis, shape=20)
```

![](data:image/png;base64...)

It looks like there is still quite a lot of overlap between tumor and normal in NMF components.

Lastly, we’ll also visualize how the NMF components relate to the runs.

```
plot(rcc_nmf, type="x", groups=run(rcc_nobg), shape=20)
```

![](data:image/png;base64...)

## 2.3 Classification with spatial shrunken centroids (SSC)

To classify the dataset and automatically select peaks that distinguish each class, we will use the `spatialShrunkenCentroids()` method provided by *Cardinal*.

Important parameters to this method include:

* `weights` The type of spatial weights to use:

  + *“gaussian”* weights use a simple Gaussian smoothing kernel
  + *“adaptive”* weights use an adaptive kernel that sometimes preserve edges better
* `r` The neighborhood smoothing radius; this should be selected based on the size and granularity of the spatial regions in your dataset
* `s` The shrinkage or sparsity parameter; the higher this number, the fewer peaks will be used to determine the classification.

### 2.3.1 Cross-validation with SSC

In order to avoid over-fitting due to the pre-processing, spectra from each CV fold must be processed independently. We have already performed peak picking independently on every spectrum.

Therefore, for each CV fold, we will re-align the peaks in the pooled training set (so the alignment does not use any peaks from the test set), and then re-align the peaks in the test set to the aligned peaks in the training set.

We use the `crossValidate()` method to perform the processing and cross-validation, treating each run as a separate fold. The `trainProcess()` and `testProcess()` arguments can be used to control the pre-processing for each fold. The default processing (`peakpProcess`) will work for our situation.

```
rcc_ssc_cv <- crossValidate(spatialShrunkenCentroids,
    x=rcc_nobg, y=rcc_nobg$diagnosis, r=1, s=2^(1:5),
    folds=run(rcc_nobg))

rcc_ssc_cv
```

```
## SpatialCV on 753 variables and 6077 observations
## names(4): average, scores, folds, fitted.values
## coord(2): x = 2...91, y = 2...37
## runNames(8): MH0204_33, UH0505_12, UH0710_33, ..., UH9905_18, UH9911_05, UH9912_01
## modelData(): Cross validation with 8 folds
##
## Average accuracy:
##          MacroRecall MacroPrecision
## r=1,s=2    0.9429099      0.9446250
## r=1,s=4    0.9534110      0.9533927
## r=1,s=8    0.9582844      0.9570880
## r=1,s=16   0.9485961      0.9493648
## r=1,s=32   0.8754607      0.8921888
```

It appears `s=16` produces the best balanced accuracy of ~93% (reported above as the macro-averaged recall).

### 2.3.2 Plotting the classified images

Now we plot the classified images from each of the cross-validation folds. We plot the fold predictions for the “best” model `s=16` (`i=4`).

```
image(rcc_ssc_cv, i=4, layout=c(2,4), free="xy", col=dpal("Set1"))
```

![](data:image/png;base64...)

Opacity is used to reflect the probability of class membership. The classifier appears to do a good job distinguishing between tumor and normal tissue.

### 2.3.3 Plotting the (shrunken) mean spectra

To interpret the model’s parameters, we can re-fit the best model to the whole dataset.

```
rcc_ssc1 <- spatialShrunkenCentroids(rcc_nobg,
    y=rcc_nobg$diagnosis, r=1, s=16)

rcc_ssc1
```

```
## SpatialShrunkenCentroids on 753 variables and 6077 observations
## names(12): class, probability, scores, ..., transpose, weights, r
## coord(2): x = 2...91, y = 2...37
## runNames(8): MH0204_33, UH0505_12, UH0710_33, ..., UH9905_18, UH9911_05, UH9912_01
## modelData(): Nearest shrunken centroids (s=16.00) with 2 classes
##
## Priors (1, .., k=2):
##     cancer    normal
##  0.4566398 0.5433602
##
## Statistics:
##      cancer normal
## [1,]      .      .
## [2,]      .      .
## [3,]      .      .
## [4,]      .      .
## [5,]      .      .
## [6,]      .      .
## ...     ...    ...
```

Now, we plot the centroids for each class separately.

```
plot(rcc_ssc1, type="centers", linewidth=2)
```

![](data:image/png;base64...)

It is difficult to tell just from the mean spectra what peaks distinguish each diagnosis.

### 2.3.4 Plotting and interpretting t-statistics of the *m/z* values

Plotting the t-statistics tells us exactly the relationship between each class’s centroid and the global mean spectrum. The t-statistics are the difference between a class’s centroid and the global mean, divided by a standard error.

Positive t-statistics indicate that peak is systematically higher intensity in that class relative to the (global) mean spectrum.

Negative t-statistics indicate that peak is systematically lower intensity in that class relative to the (global) mean spectrum.

Due to the sparsity parameter `s`, unimportant peaks will have a t-statistic of 0 and will effectively have no effect on the classification.

```
plot(rcc_ssc1, type="statistic", linewidth=2)
```

![](data:image/png;base64...)

This lets us clearly see which peaks are distinguishing tumor versus normal tissue.

### 2.3.5 Retrieving the top *m/z*-values

We can use the `topFeatures()` method to retrive the *m/z* values associated with each class.

```
rcc_ssc_top <- topFeatures(rcc_ssc1)
```

Let’s find the *m/z* values associated with tumor tissue.

```
subset(rcc_ssc_top, class=="cancer")
```

```
## DataFrame with 753 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1         629   886.429      cancer   27.7888  41.73648  17.28002
## 2         628   885.442      cancer   25.7694  76.17562  34.36209
## 3         516   773.430      cancer   19.0231  10.99684   8.77048
## 4         493   750.431      cancer   17.9557  11.75728   6.73469
## 5         517   774.421      cancer   14.7562   6.35286   4.55539
## ...       ...       ...         ...       ...       ...       ...
## 749        36   187.238      cancer  -16.9648   3.51884   4.92567
## 750       525   782.300      cancer  -17.2719   1.86480   3.47772
## 751       481   738.384      cancer  -18.4934   4.94531   3.68501
## 752       186   353.240      cancer  -27.7371   1.90645   4.07322
## 753        61   215.245      cancer  -34.9353   5.31705   6.39987
```

```
image(rcc_peaks, mz=886.4, layout=c(2,4), free="xy",
    smooth="bilateral", enhance="histogram", scale=TRUE)
```

![](data:image/png;base64...)

And let’s find the *m/z* values associated with normal tissue.

```
subset(rcc_ssc_top, class=="normal")
```

```
## DataFrame with 753 rows and 6 columns
##             i        mz       class statistic   centers        sd
##     <integer> <numeric> <character> <numeric> <numeric> <numeric>
## 1          61   215.245      normal   34.9353  13.01490   6.39987
## 2         186   353.240      normal   27.7371   6.35625   4.07322
## 3         481   738.384      normal   18.4934   7.72727   3.68501
## 4         525   782.300      normal   17.2719   4.37081   3.47772
## 5          36   187.238      normal   16.9648   6.61290   4.92567
## ...       ...       ...         ...       ...       ...       ...
## 749       517   774.421      normal  -14.7562   3.80231   4.55539
## 750       493   750.431      normal  -17.9557   7.64600   6.73469
## 751       516   773.430      normal  -19.0231   5.64383   8.77048
## 752       628   885.442      normal  -25.7694  51.94079  34.36209
## 753       629   886.429      normal  -27.7888  27.82706  17.28002
```

```
image(rcc_peaks, mz=215.24, layout=c(2,4), free="xy",
    smooth="bilateral", enhance="histogram", scale=TRUE)
```

![](data:image/png;base64...)

# 3 Multiple instance learning (MIL)

In practice, tumor tissue is often heterogenous. Rather than being entirely cancerous, what we label as “tumor” tissue will typically include some regions of healthy “normal” tissue as well.

However, due to time constraints, pathologists will often label entire tissue sections as “tumor” or “normal” rather than annotating region-by-region within a tissue. Therefore, we do not typically have access to sub-tissue labels for training.

Instead, we usually only have whole-tissue labels, so mass spectra that may (correctly) indicate “normal” tissue may be mislabeled as “tumor” in our training (and testing!) data.

Multiple instance learning (MIL) is a technique that can iteratively re-fit classification models to try to account for this uncertainty in the class labels. MIL assumes that the data consists of multiple instances (pixels/spectra in our case) that belong to “bags” (e.g., tissue samples), and the class labels are only observed at the “bag”-level.

We now perform classification with multiple instance learning.

## 3.1 Preparing the samples (bags)

We need to create a factor specifying the 16 tissue samples.

Rather than rely on the manual region-of-interest selection, we will rely on the fact that cancer tissue is on the left and the normal tissue is on the right on each slide.

```
x_threshold <- c(35, 23, 28, 39, 29, 28, 47, 32)

rcc_peaks$rough_diagnosis <- factor("normal", levels=c("cancer", "normal"))

for ( i in seq_len(nrun(rcc_peaks)) ) {
    irun <- run(rcc_peaks) == runNames(rcc_peaks)[i]
    j <- irun & coord(rcc_peaks)$x < x_threshold[i]
    pData(rcc_peaks)$rough_diagnosis[j] <- "cancer"
}

rcc_peaks$samples <- interaction(run(rcc_peaks), rcc_peaks$rough_diagnosis)
```

We want to check the samples to make sure the diagnosis labels are homogenous within each sample.

```
tapply(rcc_peaks$diagnosis, rcc_peaks$samples,
    function(cond) unique(as.character(cond)[!is.na(cond)]))
```

```
## MH0204_33.cancer UH0505_12.cancer UH0710_33.cancer UH9610_15.cancer
##         "cancer"         "cancer"         "cancer"         "cancer"
## UH9812_03.cancer UH9905_18.cancer UH9911_05.cancer UH9912_01.cancer
##         "cancer"         "cancer"         "cancer"         "cancer"
## MH0204_33.normal UH0505_12.normal UH0710_33.normal UH9610_15.normal
##         "normal"         "normal"         "normal"         "normal"
## UH9812_03.normal UH9905_18.normal UH9911_05.normal UH9912_01.normal
##         "normal"         "normal"         "normal"         "normal"
```

Since MIL requires re-training the model multiple times, it can be time-consuming, so we will reduce the number of folds (so fewer models need to be trained).

We will create 2 custom folds for the cross-validation. The 1st fold will consist of runs 1-4 and the 2nd fold will consist of runs 5-8.

```
fold1 <- run(rcc_peaks) %in% runNames(rcc_peaks)[1:4]

rcc_peaks$folds <- factor(ifelse(fold1, "fold1", "fold2"))
```

## 3.2 Cross-validation with MIL

Finally, we will perform cross-validation with multiple instance learning by passing the tissue samples as the `bags`.

```
rcc_ssc_cvmi <- crossValidate(spatialShrunkenCentroids,
    x=rcc_peaks, y=rcc_peaks$diagnosis, r=1, s=2^(1:4),
    folds=rcc_peaks$folds, bags=rcc_peaks$samples)

rcc_ssc_cvmi
```

```
## SpatialCV on 753 variables and 16000 observations
## names(4): average, scores, folds, fitted.values
## coord(2): x = 1...99, y = 1...38
## runNames(8): MH0204_33, UH0505_12, UH0710_33, ..., UH9905_18, UH9911_05, UH9912_01
## modelData(): Cross validation with 2 folds
##
## Average accuracy:
##          MacroRecall MacroPrecision
## r=1,s=2    0.9015355      0.9139754
## r=1,s=4    0.9057991      0.9176433
## r=1,s=8    0.9042354      0.9052899
## r=1,s=16   0.8185473      0.8227548
```

In this case, the accuracy is not quite as high as before, but the diagnosis labels we are using have already been selected to include only the cancerous regions instead of the whole tissues.

If we did *not* have the sub-tissue labels, then this approach would likely improve real-world performance.

```
image(rcc_ssc_cvmi, i=3, layout=c(2,4), free="xy", col=dpal("Set1"),
    subset=!is.na(rcc_peaks$diagnosis))
```

![](data:image/png;base64...)

# 4 Additional notes on cross-validation

Because we used a matched pairs experiment, with one subject per run, it was straightforward to treat the experimental runs as our CV folds. However, it does not always work out this way. When using multiple instance learning, we set up custom CV folds to reduce the total number of models we needed to train.

In general, a CV fold needs to include examples of both positive and negative classes. In addition, spectra from the same sample should not be split across multiple CV folds. In MS imaging, it is important to remember that the sample size *does NOT* equal the number of spectra or the number of pixels, but the number of independent tissue samples.

# 5 Session information

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