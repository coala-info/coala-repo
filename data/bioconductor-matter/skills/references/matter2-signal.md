# *Matter 2*: Signal and image processing

Kylie Ariel Bemis

#### Revised: July 17, 2024

# Contents

* [1 Introduction](#introduction)
* [2 Vocabulary](#vocabulary)
  + [2.1 Dimensionality and domain](#dimensionality-and-domain)
  + [2.2 Index and domain](#index-and-domain)
* [3 Filtering and smoothing](#filtering-and-smoothing)
  + [3.1 Smoothing in 1D](#smoothing-in-1d)
  + [3.2 Smoothing in 2D](#smoothing-in-2d)
  + [3.3 Smoothing using KNN](#smoothing-using-knn)
* [4 Contrast enhancement](#contrast-enhancement)
* [5 Rescaling (normalization)](#rescaling-normalization)
* [6 Continuum estimation](#continuum-estimation)
* [7 Warping and alignment](#warping-and-alignment)
  + [7.1 Warping in 1D](#warping-in-1d)
  + [7.2 Warping in 2D](#warping-in-2d)
* [8 Peak processing](#peak-processing)
  + [8.1 Local maxima](#local-maxima)
    - [8.1.1 Local maxima in 1D](#local-maxima-in-1d)
    - [8.1.2 Local maxima using KNN](#local-maxima-using-knn)
  + [8.2 Noise estimation](#noise-estimation)
  + [8.3 Peak detection](#peak-detection)
  + [8.4 Peak binning](#peak-binning)
  + [8.5 Peak merging](#peak-merging)
* [9 Session information](#session-information)

# 1 Introduction

*Matter 2* provides a variety of signal processing tools for both uniformly-sampled and nonuniformly-sampled signals in both 1D and 2D, as well as a limited selection of processing tools for signals of arbitrary dimension.

While the primary motivation for implementing these signal processing tools is for use with mass spectrometry imaging experiments, most of the provided functions are broadly applicable to any signal processing domain.

# 2 Vocabulary

*Matter* uses a few consistent terms across its available functions when referring to certain aspects of signal processing. These terms will frequently appear as parameters to signal processing functions.

## 2.1 Dimensionality and domain

Signals may have multiple *dimensions*. Each dimension corresponds to a *domain*.

Here is a simple 1-dimensional signal that resembles a mass spectrum:

```
set.seed(1)
s <- simspec(1)

plot_signal(s, xlab="Index", ylab="Intensity")
```

![](data:image/png;base64...)

A 1-dimensional signal has a single domain.

For a mass spectrum, the domain values are the mass-to-charge ratios, (or *m/z*-values).

```
plot_signal(domain(s), s, xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

A 2-dimensional signal has two domains.

For example, for an image (which is a 2D signal), the domain values are the *x* and *y* locations of the pixels.

```
plot_image(volcano)
```

![](data:image/png;base64...)

The dimensionality of a signal is the number of domains.

For example, a mass spectrum collected in tandem with liquid chromatography and ion mobility spectrometry (i.e., LC-IMS-MS) is a 3-dimensional signal. The domains for LC-IMS-MS spectra would include (1) retension times, (2) drift times, and (3) *m/z*-values.

Note that the values of a signal (e.g., intensities) are not considered as a separate dimension or domain.

## 2.2 Index and domain

In some cases, it is necessary for *Matter* to distinguish between the *observed* domain values for a signal and the *effective* domain values for a signal.

This is most obvious when we need to represent multiple nonuniformly-sampled signals (that may have been observed at different domain values) with a single set of domain values.

```
set.seed(1)
s1 <- simspec(1)
s2 <- simspec(1)

# spectra with different m/z-values
head(domain(s1))
```

```
## [1] 507.8720 508.0159 508.1598 508.3037 508.4476 508.5915
```

```
head(domain(s2))
```

```
## [1] 562.5085 562.6585 562.8085 562.9585 563.1085 563.2585
```

```
# create a shared vector of m/z-values
mzr <- range(domain(s1), domain(s2))
mz <- seq(from=mzr[1], to=mzr[2], by=0.2)

# create representations with the same m/z-values
s1 <- sparse_vec(s1, index=domain(s1), domain=mz)
s2 <- sparse_vec(s2, index=domain(s2), domain=mz)
```

In cases like this, *Matter* refers to the observed domain values as the signal `index`, and the effective domain values as the signal `domain`.

# 3 Filtering and smoothing

## 3.1 Smoothing in 1D

*Matter* provides a family of 1D smoothing methods that follow the naming scheme `filt1_*`:

* `filt1_ma` performs moving average filtering
* `filt1_conv` performs convolutional filtering with custom weights
* `filt1_gauss` performs Gaussian filtering
* `filt1_bi` performs bilateral filtering
* `filt1_adapt` performs adaptive bilateral filtering
* `filt1_diff` performs nonlinear diffusion filtering
* `filt1_guide` performs guided filtering
* `filt1_pag` performs peak-aware guided filtering
* `filt1_sg` performs Savitzky-Golay filtering

We demonstrate the smoothing results on a simulate signal below:

```
set.seed(1)
s <- simspec(1, sdnoise=0.25, resolution=500)
```

```
p1 <- plot_signal(s)
p2 <- plot_signal(filt1_ma(s))
p3 <- plot_signal(filt1_gauss(s))
p4 <- plot_signal(filt1_bi(s))
p5 <- plot_signal(filt1_diff(s))
p6 <- plot_signal(filt1_guide(s))
p7 <- plot_signal(filt1_pag(s))
p8 <- plot_signal(filt1_sg(s))

plt <- as_facets(list(
    "Original"=p1,
    "Moving average"=p2,
    "Gaussian"=p3,
    "Bilateral"=p4,
    "Diffusion"=p5,
    "Guided"=p6,
    "Peak-aware"=p7,
    "Savitsky-Golay"=p8), nrow=4, ncol=2)

plot(plt)
```

![](data:image/png;base64...)

Now we zoom in on the x-axis to better see the differences in the smoothing.

```
plot(plt, xlim=c(5800, 6100))
```

![](data:image/png;base64...)

## 3.2 Smoothing in 2D

*Matter* also provides a family of 2D image smoothing methods that follow the naming scheme `filt2_*`:

* `filt2_ma` performs moving average filtering
* `filt2_conv` performs convolutional filtering with custom weights
* `filt2_gauss` performs Gaussian filtering
* `filt2_bi` performs bilateral filtering
* `filt2_adapt` performs adaptive bilateral filtering
* `filt2_diff` performs nonlinear diffusion filtering
* `filt2_guide` performs guided filtering

If a multichannel image is provided (e.g., a 3D array), then these functions will smooth each channel independently.

We demonstrate the smoothing results on the `volcano` dataset with added noise:

```
set.seed(1)
img <- volcano + rnorm(length(volcano), sd=2.5)
```

```
p1 <- plot_image(img)
p2 <- plot_image(filt2_ma(img))
p3 <- plot_image(filt2_gauss(img))
p4 <- plot_image(filt2_bi(img))
p5 <- plot_image(filt2_diff(img))
p6 <- plot_image(filt2_guide(img))

plt <- as_facets(list(
    "Original"=p1,
    "Moving average"=p2,
    "Gaussian"=p3,
    "Bilateral"=p4,
    "Diffusion"=p5,
    "Guided"=p6), nrow=3, ncol=2)

plot(plt)
```

![](data:image/png;base64...)

One of the major differences between the various smoothing methods is how well they preserve sharp edges.

We use some simple simulated data to demonstrate this:

```
set.seed(1)
dm <- c(64, 64)
img <- array(rnorm(prod(dm)), dim=dm)
i <- (dm[1] %/% 3):(2 * dm[1] %/% 3)
j <- (dm[2] %/% 3):(2 * dm[2] %/% 3)
img[i,] <- img[i,] + 2
img[,j] <- img[,j] + 2

p1 <- plot_image(img)
p2 <- plot_image(filt2_ma(img))
p3 <- plot_image(filt2_gauss(img))
p4 <- plot_image(filt2_bi(img))
p5 <- plot_image(filt2_diff(img))
p6 <- plot_image(filt2_guide(img))

plt <- as_facets(list(
    "Original"=p1,
    "Moving average"=p2,
    "Gaussian"=p3,
    "Bilateral"=p4,
    "Diffusion"=p5,
    "Guided"=p6), nrow=3, ncol=2)

plot(plt)
```

![](data:image/png;base64...)

## 3.3 Smoothing using KNN

A limited set of smoothing filters are also available for N-dimensional signals that have been nonuniformly sampled. For example, this could include spatial signals at arbitrary (non-gridded) locations or mass spectra with an ion mobility dimension.

These follow the naming scheme `filtn_*` and include:

* `filtn_ma` performs moving average filtering
* `filtn_conv` performs convolutional filtering with custom weights
* `filtn_gauss` performs Gaussian filtering
* `filtn_bi` performs bilateral filtering
* `filtn_adapt` performs adaptive bilateral filtering

Because these smoothing functions rely on k-nearest-neighbor search to determine the smoothing windows, they are more computationally intensive than the standard 1D and 2D filters.

# 4 Contrast enhancement

Contrast enhancement improves the contrast of an image. This can correct for hotspots caused by multiplicative variance.

To demonstrate this, we will add multiplicative noise to the volcano dataset:

```
set.seed(1)
img <- volcano + rlnorm(length(volcano), sd=1.5)
```

Contrast enhancement functions follow the naming scheme `enhance_*` and includes:

* `enhance_adj` adjusts contrast by clamping extreme values
* `enhance_hist` performs histogram equalization
* `enhance_adapt` performs contrast-limited adaptive histogram equalization (CLAHE)

```
p1 <- plot_image(img)
p2 <- plot_image(enhance_adj(img))
p3 <- plot_image(enhance_hist(img))
p4 <- plot_image(enhance_adapt(img))

plt <- as_facets(list(
    "Original"=p1,
    "Adjust"=p2,
    "Histogram"=p3,
    "CLAHE"=p4), nrow=2, ncol=2)

plot(plt, scale=TRUE)
```

![](data:image/png;base64...)

Using contrast enhancement can dramatically improve the visual interpretation of the image.

Note that the contrast-limited adaptive histogram equalization (CLAHE) method is most useful when the required contrast correction is very different across different regions of the image, which is *not* the case here.

# 5 Rescaling (normalization)

Rescaling the signal is often necessary for various normalization methods.

Rescaling functions follow the naming scheme `rescale_*` and include:

* `rescale_rms` rescales based on the root-mean-square of the signal
* `rescale_sum` rescales based on the sum of (the absolute values of) the signal
* `rescale_ref` rescales according to a specific sample (i.e., a reference value at a specific index)
* `rescale_range` rescales the lower and upper limits of the signal values
* `rescale_iqr` rescales the lower and upper limits of the signal values

As they only rescale the signal we won’t visualize these methods here.

# 6 Continuum estimation

Continuum estimation is most commonly used to estimate a signal’s baseline.

```
set.seed(1)
s <- simspec(1, baseline=5, resolution=500)
```

Baseline estimation functions follow the naming scheme `estbase_*` and include:

* `estbase_loc` interpolates the continuum from local extrema
* `estbase_hull` estimates an upper or lower convex hull
* `estbase_snip` performs sensitive nonlinear iterative peak clipping (SNIP)
* `estbase_med` estimates the continuum form running medians

We demonstrate baseline removal below:

```
p1 <- plot_signal(s)
p2 <- plot_signal(s - estbase_loc(s))
p3 <- plot_signal(s - estbase_hull(s))
p4 <- plot_signal(s - estbase_snip(s))

plt <- as_facets(list(
    "Original"=p1,
    "Local minima"=p2,
    "Convex hull"=p3,
    "SNIP"=p4), nrow=2, ncol=2)

plot(plt)
```

![](data:image/png;base64...)

# 7 Warping and alignment

It is often necessary to warp signals to align their features (e.g., peaks) in the presence of variance in their observed domain values.

This is necessary, for example, to recalibrate mass spectra with a large amount of mass error, or to co-register images across different image modalities.

## 7.1 Warping in 1D

*Matter* provides a few signal warping functions that follow the naming scheme `warp1_*`:

* `warp1_loc` performs warping based on local extrema
* `warp1_dtw` performs dynamic time warping
* `warp1_cow` performs correlation optimized warping

These functions can be align two signals as shown below.

First, we need to simulate some signals in need of alignment:

```
set.seed(1)
s <- simspec(8, sdx=5e-4)

plot_signal(domain(s), s, by=NULL, group=1:8,
    xlim=c(1250, 1450))
```

![](data:image/png;base64...)

Next, we need to generate a reference signal to use when aligning all of the signals. We do this by calculating the mean signal and using it as the reference:

```
ref <- rowMeans(s)
s2 <- apply(s, 2L, warp1_loc,
    y=ref, events="max", tol=2e-3, tol.ref="y")

plot_signal(domain(s), s2, by=NULL, group=1:8,
    xlim=c(1250, 1450))
```

![](data:image/png;base64...)

Note that signal warping can be quite sensitive to the tolerance (i.e., how much the signal is allowed to shift in either direction).

## 7.2 Warping in 2D

A warping function for 2D images is also available.

First, we need to generate images in need of co-registration:

```
img1 <- trans2d(volcano, rotate=15, translate=c(-5, 5))

plot_image(list(volcano, img1))
```

![](data:image/png;base64...)

Now, we can warp the transformed image to align it with the original image:

```
img2 <- warp2_trans(img1, volcano)

plot_image(list(volcano, img2))
```

![](data:image/png;base64...)

Note that this is method is currently limited to affine transformations.

# 8 Peak processing

*Matter* provides a family of functions for detecting peaks in a signal and processing peak lists from multiple signals.

To demonstrate peak processing, we begin by simulating a signal.

```
set.seed(1)
s <- simspec(1)
```

## 8.1 Local maxima

A typical first step in peak processing is detection of local maxima to select peak candidates.

### 8.1.1 Local maxima in 1D

The `locmax` and `locmin` functions perform detection of local extreme based on a sliding window approach.

A sample is considered a local maximum if it is *greater* than all elements to its left within the window **and** *greater than or equal to* all elements in the window to its right within the window.

The default window has `width=5`:

```
i <- locmax(s)

plot_signal(domain(s), s, xlim=c(900, 1100))
lines(domain(s)[i], s[i], type="h", col="red")
```

![](data:image/png;base64...)

Below we use a wider window with `width=15`.

```
i <- locmax(s, width=15)

plot_signal(domain(s), s, xlim=c(900, 1100))
lines(domain(s)[i], s[i], type="h", col="red")
```

![](data:image/png;base64...)

In a noisy signal, there will be many more local maxima than true peaks.

### 8.1.2 Local maxima using KNN

For signals with multiple dimensions, the `knnmax` and `knnmin` functions perform detection of local extrema using k-nearest-neighbors.

Below, we detect the local maxima in a simulated dataset:

```
set.seed(1)
dm <- c(64, 64)
img <- array(rnorm(prod(dm)), dim=dm)
w <- 100 * dnorm(seq(-3, 3)) %o% dnorm(seq(-3, 3))
img[1:7,1:7] <- img[1:7,1:7] + w
img[11:17,11:17] <- img[11:17,11:17] + w
img[21:27,21:27] <- img[21:27,21:27] + w
img[21:27,41:47] <- img[21:27,41:47] + w
img[51:57,31:37] <- img[51:57,31:37] + w
img[41:47,51:57] <- img[41:47,51:57] + w

plot_image(img)
```

![](data:image/png;base64...)

```
coord <- expand.grid(lapply(dim(img), seq_len))

i <- knnmax(img, index=coord, k=49)
i <- which(i, arr.ind=TRUE)

plot_image(img)
points(i[,1], i[,2], pch=4, lwd=2, cex=2, col="red")
```

![](data:image/png;base64...)

As in 1-dimension, there are many more local maxima than true peaks, but the true peaks (i.e., the bright spots) are detected.

## 8.2 Noise estimation

To distinguish true peaks from false peaks, we need to estimate the noise level in the signal.

*Matter* provides a variety of noise estimation functions that follow the naming scheme `estnoise_*`:

* `estnoise_diff` estimates noise from the differences between the signal and its derivative
* `estnoise_filt` uses dynamic filtering-based to distinguish between noise peaks and true peaks
* `estnoise_sd` estimates noise from the standard deviation of the difference between a smoothed signal and the original signal
* `estnoise_mad` estimates noise from the mean absolute deviation of the difference between a smoothed signal and the original signal
* `estnoise_quant` estimates noise from a quantile of the difference between a smoothed signal and the original signal

```
p1 <- plot_signal(domain(s), s,
    xlim=c(900, 1100), ylim=c(0, 15))

p2 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_diff(s),
    params=list(color="blue", linewidth=2))

p3 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_filt(s),
    params=list(color="blue", linewidth=2))

p4 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_quant(s),
    params=list(color="blue", linewidth=2))

p5 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_sd(s),
    params=list(color="blue", linewidth=2))

p6 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_mad(s),
    params=list(color="blue", linewidth=2))

as_facets(list(
    "Original"=p1,
    "Difference"=p2,
    "Filtering"=p3,
    "Quantile"=p4,
    "SD"=p5,
    "MAD"=p6), nrow=3, ncol=2)
```

![](data:image/png;base64...)

By default, a constant noise level is estimated for the entire signal domain. A variable noise level can be estimated for different regions of the signal by specifying the `nbins` argument.

```
p1 <- plot_signal(domain(s), s,
    xlim=c(900, 1100), ylim=c(0, 15))

p2 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_diff(s, nbins=20),
    params=list(color="blue", linewidth=2))

p3 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_filt(s, nbins=20),
    params=list(color="blue", linewidth=2))

p4 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_quant(s, nbins=20),
    params=list(color="blue", linewidth=2))

p5 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_sd(s, nbins=20),
    params=list(color="blue", linewidth=2))

p6 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_mad(s, nbins=20),
    params=list(color="blue", linewidth=2))

as_facets(list(
    "Original"=p1,
    "Difference"=p2,
    "Filtering"=p3,
    "Quantile"=p4,
    "SD"=p5,
    "MAD"=p6), nrow=3, ncol=2)
```

![](data:image/png;base64...)

## 8.3 Peak detection

The `findpeaks` function streamlines the process of peak detection. It detects local maxima using `locmax`, optionally estimates noise using a specified `estnoise_*` function, and optionally filters the peaks based on a signal-to-noise ratio threshold set via `snr`.

```
i1 <- findpeaks(s, snr=3, noise="diff")

p1a <- plot_signal(domain(s), s, group="Signal")
p1b <- plot_signal(domain(s)[i1], s[i1], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p1 <- as_layers(p1a, p1b)
```

```
i2 <- findpeaks(s, snr=3, noise="filt")

p2a <- plot_signal(domain(s), s, group="Signal")
p2b <- plot_signal(domain(s)[i2], s[i2], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p2 <- as_layers(p2a, p2b)
```

```
i3 <- findpeaks(s, snr=3, noise="sd")

p3a <- plot_signal(domain(s), s, group="Signal")
p3b <- plot_signal(domain(s)[i3], s[i3], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p3 <- as_layers(p3a, p3b)
```

```
i4 <- findpeaks(s, snr=3, noise="mad")

p4a <- plot_signal(domain(s), s, group="Signal")
p4b <- plot_signal(domain(s)[i4], s[i4], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p4 <- as_layers(p4a, p4b)
```

```
plt <- as_facets(list(
    "Difference"=p1,
    "Filtering"=p2,
    "SD"=p3,
    "MAD"=p4))

plot(plt, xlim=c(1200, 1600))
```

![](data:image/png;base64...)

Different noise estimation methods may have different sensitivity and specificity when detecting peaks in different kinds of signals.

## 8.4 Peak binning

After detecting peaks from multiple signals, it is often necessary to determine whether two (or more) peaks correspond to the same feature or not. This is typically done by binning the peaks.

For example, in the context of mass spectrometry, there is typically some small amount of error in the observed *m/z*-values of the peaks. Peak binning is necessary to know which peaks from different spectra refer to the same molecules.

```
set.seed(1)
s <- simspec(4)

peaklist <- apply(s, 2, findpeaks, snr=3)

peaks <- binpeaks(peaklist)
as.vector(peaks)
```

```
##   [1] 1000.000 1001.000 1263.000 1264.000 1937.000 2070.000 2071.000 2920.000
##   [9] 2921.000 2946.000 3142.000 3143.000 3175.000 3289.000 3294.000 3295.000
##  [17] 3296.000 3561.000 3562.000 3681.000 3682.000 3721.000 3722.000 3895.000
##  [25] 3896.500 3898.000 3906.000 4001.000 4183.000 4184.000 4200.000 4201.000
##  [33] 4202.000 4289.000 4292.500 4294.000 4295.000 4300.000 4302.000 4310.000
##  [41] 4313.000 4315.000 4409.500 4436.500 4493.500 4497.000 4498.000 4499.500
##  [49] 4502.500 4697.500 4945.000 4946.000 4955.000 5289.000 5290.000 5370.000
##  [57] 5371.000 5375.250 5378.000 5382.000 5432.250 5503.000 5505.000 5507.000
##  [65] 5677.000 5678.500 5680.000 5681.000 5857.000 5905.000 5906.000 5952.000
##  [73] 5953.000 6014.000 6017.000 6019.000 6020.500 6022.000 6025.000 6026.000
##  [81] 6029.000 6225.000 6226.000 6227.500 6327.000 6334.000 6337.000 6338.000
##  [89] 6341.500 6344.000 6406.000 6407.500 6413.000 6420.000 6451.000 6454.000
##  [97] 6455.000 6457.000 6458.500 6460.000 6461.000 6565.000 6566.333 6568.000
## [105] 6733.000 6735.000 6736.000 6738.000 6829.000 6842.667 6844.000 6845.000
## [113] 6915.000 6916.000 7378.000 7379.000 7393.000 7444.000 7449.000 7453.000
## [121] 7454.500 7456.000 7458.000 7459.000 8184.000 8187.000 8194.000 8196.000
## [129] 8197.000 8199.000 8709.000 8710.000 8990.500 8993.000 8995.000 8996.000
## [137] 8998.000 8999.000 9001.000 9005.500 9008.000
```

The peaks are binned to a `domain` that is automatically generated based on the range of the detected peaks (if `domain` is not explicitly specified).

The bins of the `domain` are spaced according to a tolerance `tol`. If `tol` is not specified, then it is estimated as half of the median of the minimum gap between same-signal peaks.

The value returned by `binpeaks` above are the binned peaks, as determined by the `domain` bins where at least one peak was observed. The per-signal peak locations are averaged within each bin to determine the final peak locations.

## 8.5 Peak merging

After peak binning, there may still be some peaks that need to be merged.

Whether this is necessary depends on the resolution of the bins that were used when binning the peaks. Higher resolution bins (preferred for the sake of accuracy) may require merging bins that are likely the same peak.

```
peaks <- mergepeaks(peaks, tol=1)
as.vector(peaks)
```

```
##   [1] 1000.750 1263.250 1937.000 2070.250 2920.250 2946.000 3142.250 3175.000
##   [9] 3289.000 3294.750 3561.250 3681.750 3721.250 3895.000 3896.500 3898.000
##  [17] 3906.000 4001.000 4183.500 4201.000 4289.000 4292.500 4294.667 4300.000
##  [25] 4302.000 4310.000 4313.000 4315.000 4409.500 4436.500 4493.500 4497.500
##  [33] 4499.500 4502.500 4697.500 4945.500 4955.000 5289.500 5370.500 5375.250
##  [41] 5378.000 5382.000 5432.250 5503.000 5505.000 5507.000 5677.000 5678.500
##  [49] 5680.500 5857.000 5905.750 5952.750 6014.000 6017.000 6019.000 6020.500
##  [57] 6022.000 6025.333 6029.000 6225.333 6227.500 6327.000 6334.000 6337.750
##  [65] 6341.500 6344.000 6406.000 6407.500 6413.000 6420.000 6451.000 6454.500
##  [73] 6457.000 6458.500 6460.500 6565.000 6566.333 6568.000 6733.000 6735.667
##  [81] 6738.000 6829.000 6842.667 6844.500 6915.250 7378.250 7393.000 7444.000
##  [89] 7449.000 7453.000 7454.500 7456.000 7458.500 8184.000 8187.000 8194.000
##  [97] 8196.667 8199.000 8709.750 8990.500 8993.000 8995.500 8998.333 9001.000
## [105] 9005.500 9008.000
```

As can be seen above, the peaks that were binned at 1000 and 1001 previously have been merged into a single peak at 1000.75.

Note that the number of observed peaks at each bin are preserved and used to calculate the new peak location, which is why the resulting peak is located at 1000.75 instead of 1000.5.

# 9 Session information

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
## [1] matter_2.12.0       Matrix_1.7-4        BiocParallel_1.44.0
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          magick_2.9.0
##  [4] rlang_1.1.6         xfun_0.53           ProtGenerics_1.42.0
##  [7] generics_0.1.4      jsonlite_2.0.0      htmltools_0.5.8.1
## [10] tinytex_0.57        sass_0.4.10         stats4_4.5.1
## [13] rmarkdown_2.30      grid_4.5.1          evaluate_1.0.5
## [16] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [19] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [22] compiler_4.5.1      codetools_0.2-20    irlba_2.3.5.1
## [25] Rcpp_1.1.0          lattice_0.22-7      digest_0.6.37
## [28] R6_2.6.1            parallel_4.5.1      magrittr_2.0.4
## [31] bslib_0.9.0         tools_4.5.1         BiocGenerics_0.56.0
## [34] cachem_1.1.0
```