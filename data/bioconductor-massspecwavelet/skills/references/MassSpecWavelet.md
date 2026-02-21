# Using the MassSpecWavelet package

Pan Du1, Warren A. Kibbe1 and Simon Lin1

1Robert H. Lurie Comprehensive Cancer Center. Northwestern University, Chicago, IL, 60611, USA

#### 30 October 2025

#### Package

MassSpecWavelet 1.76.0

# Contents

* [1 Version Info](#version-info)
* [2 Overview of MassSpecWavelet](#overview-of-massspecwavelet)
* [3 Peak detection by using CWT-based pattern matching](#peak-detection-by-using-cwt-based-pattern-matching)
  + [3.1 Continuous wavelet transform with Mexican Hat wavelet](#continuous-wavelet-transform-with-mexican-hat-wavelet)
  + [3.2 Peak identification process](#peak-identification-process)
  + [3.3 Refine the peak parameter estimation](#refine-the-peak-parameter-estimation)
* [4 Future Extension](#future-extension)
* [5 Acknowledgments](#acknowledgments)
* [6 Session Information](#session-information)

# 1 Version Info

**R version**: R version 4.5.1 Patched (2025-08-23 r88802)

**Bioconductor version**: 3.22

**Package version**: 1.76.0

# 2 Overview of MassSpecWavelet

MassSpecWavelet R package is aimed to process Mass Spectrometry (MS) data mainly based on Wavelet Transforms. The current version supports the peak detection based on Continuous Wavelet Transform (CWT). The algorithms have been evaluated with low resolution mass spectra (SELDI and MALDI data), we believe some of the algorithms can also be applied to other kind of spectra.

If you use MassSpecWavelet, please consider citing our work:

Du P, Kibbe W, Lin S (2006).
“Improved peak detection in mass spectrum by incorporating continuous wavelet transform-based pattern matching.”
*Bioinformatics*, **22**(17), 2059-2065.
ISSN 1367-4803, [doi:10.1093/bioinformatics/btl355](https://doi.org/10.1093/bioinformatics/btl355), <https://academic.oup.com/bioinformatics/article-pdf/22/17/2059/767773/btl355.pdf>, <https://doi.org/10.1093/bioinformatics/btl355>.

# 3 Peak detection by using CWT-based pattern matching

Motivation: A major problem for current peak detection algorithms is that noise in Mass Spectrometry (MS) spectrum gives rise to a high rate of false positives. The false positive rate is especially problematic in detecting peaks with low amplitudes. Usually, various baseline correction algorithms and smoothing methods are applied before attempting peak detection. This approach is very sensitive to the amount of smoothing and aggressiveness of the baseline correction, which contribute to making peak detection results inconsistent between runs, instrumentation and analysis methods.

Results: Most peak detection algorithms simply identify peaks based on amplitude, ignoring the additional information present in the shape of the peaks in a spectrum. In our experience, ‘true’ peaks have characteristic shapes, and providing a shape-matching function that provides a ‘goodness of fit’ coefficient should provide a more robust peak identification method. Based on these observations, a Continuous Wavelet Transform (CWT)-based peak detection algorithm has been devised that identifies peaks with different scales and amplitudes. By transforming the spectrum into wavelet space, the pattern-matching problem is simplified and additionally provides a powerful technique for identifying and separating signal from spike noise and colored noise. This transformation, with the additional information provided by the 2-D CWT coefficients can greatly enhance the effective Signal-to-Noise Ratio (SNR). Furthermore, with this technique no baseline removal or peak smoothing preprocessing steps are required before peak detection, and this improves the robustness of peak detection under a variety of conditions. The algorithm was evaluated with real MS spectra with known polypeptide positions. Comparisons with two other popular algorithms were performed. The results show the CWT-based algorithm can identify both strong and weak peaks while keeping false positive rate low.

## 3.1 Continuous wavelet transform with Mexican Hat wavelet

Load the example data

```
data(exampleMS)
```

```
plotRange <- c(5000, 11000)
plot(exampleMS, xlim = plotRange, type = "l")
```

![](data:image/png;base64...)

Continuous wavelet transform with Mexican Hat wavelet. The 2-D CWT coefficients image of MS spectrum in [5000, 11000] is shown in Figure [1](#fig:cwt)

```
scales <- seq(1, 64, 2)
 wCoefs <- cwt(exampleMS, scales = scales, wavelet = "mexh")
```

```
## Plot the 2-D CWT coefficients as image (It may take a while!)
xTickInterval <- 1000
plotRange <- c(5000, 11000)
image(
  plotRange[1]:plotRange[2],
  scales,
  wCoefs[plotRange[1]:plotRange[2],],
  col=terrain.colors(256),
  axes=FALSE,
  xlab='m/z index',
  ylab='CWT coefficient scale',
  main='CWT coefficients'
)
axis(1, at=seq(plotRange[1], plotRange[2], by=xTickInterval))
axis(2, at=c(1, seq(10, 64, by=10)))
box()
```

![2-D CWT coefficient image](data:image/png;base64...)

Figure 1: 2-D CWT coefficient image

The smallest scales can be used for noise estimation, smaller scales are then
useful for peaks with smaller width. Larger scales can detect wider peaks, at the
expense of merging narrower peaks together.

```
plot(exampleMS, xlim = c(8000, 9000), type = "l")
```

![](data:image/png;base64...)

```
matplot(
    wCoefs[,ncol(wCoefs):1],
    type = "l",
    col = rev(rainbow(max(scales), start = 0.7, end = 0.1, alpha = 0.5)[scales]),
    lty = 1,
    xlim = c(8000, 9000),
    xlab = "m/z index",
    ylab = "CWT coefficients"
)
legend(
    x = "topright",
    legend = sprintf("scales = %d", scales[seq(1, length(scales), length.out = 4)]),
    lty = 1,
    col = rainbow(max(scales), start = 0.7, end = 0.1)[scales[seq(1, length(scales), length.out = 4)]]
)
```

![](data:image/png;base64...)

## 3.2 Peak identification process

Identify the ridges by linking the local maxima. The identified local maxima is shown in Figure [2](#fig:localMax)

```
## Attach the raw spectrum as the first column
wCoefs <- cbind(as.vector(exampleMS), wCoefs)
colnames(wCoefs) <- c(0, scales)
localMax <- getLocalMaximumCWT(wCoefs)
```

```
plotLocalMax(localMax, wCoefs, range=plotRange)
```

![Identified local maxima of CWT coefficients at each scale](data:image/png;base64...)

Figure 2: Identified local maxima of CWT coefficients at each scale

Identify the ridge lines by connecting local maxima of CWT coefficient at adjacent scales

```
ridgeList <- getRidge(localMax)
```

```
plotRidgeList(ridgeList,  wCoefs, range=plotRange)
```

![Identified ridge lines based on 2-D CWT coefficients](data:image/png;base64...)

Figure 3: Identified ridge lines based on 2-D CWT coefficients

Identify the identified ridges lines and SNR using `identifyMajorPeaks()`. The returns of `identifyMajorPeaks()` include the `peakIndex`, `peakSNR`, etc. All these elements carry peak names, which are the same as the corresponding peak ridges. See function `getRidge()` for details.

```
SNR.Th <- 3
nearbyPeak <- TRUE
majorPeakInfo <- identifyMajorPeaks(
  exampleMS,
  ridgeList,
  wCoefs,
  SNR.Th = SNR.Th,
  nearbyPeak=nearbyPeak
)
## Plot the identified peaks
peakIndex <- majorPeakInfo$peakIndex
```

Plot the spectra with identified peaks marked with red circles.

```
plotPeak(
  exampleMS,
  peakIndex,
  range=plotRange,
  main=paste('Identified peaks with SNR >', SNR.Th)
)
```

![Identified peaks](data:image/png;base64...)

Figure 4: Identified peaks

All of the above steps are encapsulated as a main function of peak detection main:

```
data(exampleMS)
SNR.Th <- 3
nearbyPeak <- TRUE
peakInfo <- peakDetectionCWT(exampleMS, SNR.Th=SNR.Th, nearbyPeak=nearbyPeak)
majorPeakInfo = peakInfo$majorPeakInfo
peakIndex <- majorPeakInfo$peakIndex
plotRange <- c(5000, length(exampleMS))
```

```
plotPeak(
  exampleMS,
  peakIndex,
  range=plotRange,
  log='x',
  main=paste('Identified peaks with SNR >', SNR.Th)
)
```

![Identified peaks](data:image/png;base64...)

Figure 5: Identified peaks

Plot Signal to Noise Ration (SNR) of the peaks

```
peakSNR <- majorPeakInfo$peakSNR
allPeakIndex <- majorPeakInfo$allPeakIndex
```

```
plotRange <- c(5000, 36000)
selInd <- which(allPeakIndex >= plotRange[1] & allPeakIndex < plotRange[2])
plot(
  allPeakIndex[selInd],
  peakSNR[selInd],
  type='h',
  xlab='m/z Index',
  ylab='Signal to Noise Ratio (SNR)',
  log='x'
)
points(peakIndex, peakSNR[names(peakIndex)], type='h', col='red')
title('Signal to Noise Ratio (SNR) of the peaks (CWT method)')
```

![Estimated Signal to Noise Ration (SNR) of the peaks](data:image/png;base64...)

Figure 6: Estimated Signal to Noise Ration (SNR) of the peaks

## 3.3 Refine the peak parameter estimation

The above peak detection process can identify the peaks, however, it can only approximately estimate the peak parameters, like peak strength (proportional to Area Under Curve), peak center position and peak width. In order to get better estimation of these parameter, an estimation refine step can be added.

```
betterPeakInfo <- tuneInPeakInfo(exampleMS, majorPeakInfo)
```

```
plotRange <- c(5000, 11000)
plot(
  plotRange[1]:plotRange[2],
  exampleMS[plotRange[1]:plotRange[2]],
  type='l',
  log='x',
  xlab='m/z Index',
  ylab='Intensity'
)
abline(v=betterPeakInfo$peakCenterIndex, col='red')
```

![Identified peaks with refined peak center position](data:image/png;base64...)

Figure 7: Identified peaks with refined peak center position

# 4 Future Extension

More MS data analysis and wavelet related functions will be implemented in MassSpecWavelet package.

# 5 Acknowledgments

We would like to thanks the users and researchers around the world contribute to the MassSpecWavelet package, provide great comments and suggestions and report bugs. Especially, we would like to thanks Steffen Neumann and Ralf Tautenhahn fixing some bugs for the package.

# 6 Session Information

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
## [1] MassSpecWavelet_1.76.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         cli_3.6.5           knitr_1.50
##  [4] rlang_1.1.6         magick_2.9.0        xfun_0.53
##  [7] bench_1.1.4         jsonlite_2.0.0      glue_1.8.0
## [10] htmltools_0.5.8.1   tinytex_0.57        sass_0.4.10
## [13] rmarkdown_2.30      tibble_3.3.0        evaluate_1.0.5
## [16] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [19] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [22] compiler_4.5.1      pkgconfig_2.0.3     Rcpp_1.1.0
## [25] digest_0.6.37       R6_2.6.1            pillar_1.11.1
## [28] magrittr_2.0.4      bslib_0.9.0         tools_4.5.1
## [31] cachem_1.1.0
```