# The yamss User’s Guide

Leslie Myint and Kasper Daniel Hansen

#### 30 October 2025

#### Abstract

A comprehensive guide to using the yamss package for analyzing high-throughput metabolomics data

#### Package

yamss 1.36.0

# 1 Introduction

The *[yamss](https://bioconductor.org/packages/3.22/yamss)* (yet another mass spectrometry software) package provides tools to preprocess raw mass spectral data files arising from metabolomics experiments with the primary goal of providing high-quality differential analysis. Currently, *[yamss](https://bioconductor.org/packages/3.22/yamss)* implements a preprocessing method “bakedpi”, which stands for bivariate approximate kernel density estimation for peak identification.

Alternatives to this package include *[xcms](https://bioconductor.org/packages/3.22/xcms)* (Smith et al. [2006](#ref-xcms)) (available on Bioconductor) and MZMine 2 (Pluskal et al. [2010](#ref-mzmine)). These packages also provide preprocessing functionality but focus more on feature detection and alignment in individual samples. The input data to *[yamss](https://bioconductor.org/packages/3.22/yamss)* are standard metabolomics mass spectral files which can be read by *[mzR](https://bioconductor.org/packages/3.22/mzR)*.

## 1.1 bakedpi

The “bakedpi” algorithm is a new preprocessing algorithm for untargeted metabolomics data (Myint et al. [2017](#ref-bakedpi)). The output of “bakedpi” is essentially a table with dimension peaks (adducts) by samples, containing quantified intensity measurements representing the abundance of metabolites. This table, which is very similar to output in gene expression analysis, can directly be used in standard statistical packages, such as *[limma](https://bioconductor.org/packages/3.22/limma)*, to identify differentially abundant metabolites between conditions. It is critical that all samples which are to be analyzed together are processed together through bakedpi.

## 1.2 Citing yamss

Please cite our paper when using yamss (Myint et al. [2017](#ref-bakedpi)).

## 1.3 Dependencies

This document has the following dependencies

```
library(yamss)
library(mtbls2)
```

# 2 Processing a metabolomics dataset

We will be looking at data provided in the `mtbls2` data package. In this experiment, investigators exposed wild-type and mutant *Arabidopsis thaliana* leaves to silver nitrate and performed global LC/MS profiling. The experiment was repeated twice, but we will only be looking at the first replicate. There are 4 wild-type and 4 mutant plants in this experiment.

```
filepath <- file.path(find.package("mtbls2"), "mzML")
files <- list.files(filepath, pattern = "MSpos-Ex1", recursive = TRUE, full.names = TRUE)
classes <- rep(c("wild-type", "mutant"), each = 4)
```

The first step is to read the raw mass spec data into an R representation using `readMSdata()`:

```
colData <- DataFrame(sampClasses = classes, ionmode = "pos")
cmsRaw <- readMSdata(files = files, colData = colData, mzsubset = c(500,520), verbose = TRUE)
```

```
## [readRaw]: Reading 8 files
```

```
cmsRaw
```

```
## class: CMSraw
## Representing 8 data files
## Number of scans: 3389
## M/Z: 500.000120 - 519.998100
```

The output of `readMSdata()` is an object of class `CMSraw` representating raw (unprocessed) data. We use the `colData` argument to store phenotype information about the different samples.

The next step is to use `bakedpi()` to preprocess these samples. This function takes a while to run, so we only run it on a small slice of M/Z values, using the `mzsubset` argument. This is only done for speed.

```
cmsProc <- bakedpi(cmsRaw, dbandwidth = c(0.01, 10), dgridstep = c(0.01, 1),
                   outfileDens = NULL, dortalign = TRUE, mzsubset = c(500, 520), verbose = TRUE)
```

```
## [bakedpi] Background correction
```

```
## [bakedpi] Retention time alignment
```

```
## [bakedpi] Density estimation
```

```
cmsProc
```

```
## class: CMSproc
## Representing 8 data files
## Number of scans: 3389
## M/Z: 500.000120 - 519.998100
```

The `dbandwidth` and `dgridstep` arguments influence the bivariate kernel density estimation which forms the core of bakedpi. `dgridstep` is a vector of length 2 that specifies the spacing of the grid upon which the density is estimated. The first component specifies the spacing in the M/Z direction, and the second component specifies the spacing in the scan (retention time) direction. To showcase a fast example, we have specified the M/Z and scan spacings to be `0.01` and `1` respectively, but we recommend keeping the defaults of `0.005` and `1` because this will more accurately define the M/Z and scan bounds of the detected peaks. `dbandwidth` is a vector of length 2 that specifies the kernel density bandwidth in the M/Z and scan directions in the first and second components respectively. Note that `dbandwidth[1]` should be greater than or equal to `dgridstep[1]` and `dbandwidth[2]` should be greater than or equal to `dgridstep[2]`. Because a binning strategy is used to speed up computation of the density estimate, this is to ensure that data points falling into the same grid location all have the same distances associated with them.

For experiments with a wide range of M/Z values or several thousands of scans, the computation of the density estimate can be time-intensive. For this reason, it can be useful to save the density estimate in an external file specified by the `outfileDens` argument. If `outfileDens` is set to `NULL`, then the density estimate is not saved and must be recomputed if we wish to process the data again. Specifying the filename of the saved density estimate in `outfileDens` when rerunning `bakedpi()` skips the density estimation phase which can save a lot of time.

The resulting object is an instance of class `CMSproc` which contains the bivariate kernel density estimate as well as some useful preprocessing metadata. In order to obtain peak bounds and quantifications, the last step is to run `slicepi()`, which computes a global threshold for the density, uses this threshold to call peak bounds, and quantifies the peaks. If the `cutoff` argument is supplied as a number, then `slicepi()` will use this as the density threshold. Otherwise if `cutoff` is left as the default `NULL`, a data-driven threshold will be identified.

```
cmsSlice <- slicepi(cmsProc, cutoff = NULL, verbose = TRUE)
```

```
## [slicepi] Computing cutoff
```

```
## [slicepi] Computing peak bounds
```

```
## [slicepi] Quantifying peaks
```

```
cmsSlice
```

```
## An object of class 'CMSslice'
## Representing 8 data files
## Number of scans: 3389
## M/Z: 500.000120 - 519.998100
## Number of peaks: 72
```

The output of `slicepi()` is an instance of class `CMSslice` and contains the peak bounds and quantifications as well as sample and preprocessing metadata.

# 3 Differential Analysis

We can access the differential analysis report with `diffrep()`. This is a convenience function, similar to `diffreport()` from the *[xcms](https://bioconductor.org/packages/3.22/xcms)* package. In our case it uses *[limma](https://bioconductor.org/packages/3.22/limma)* to do differential analysis; the output of `diffrep()` is basically `topTable()` from *[limma](https://bioconductor.org/packages/3.22/limma)*.

```
dr <- diffrep(cmsSlice, classes = classes)
head(dr)
```

```
##        logFC  AveExpr         t      P.Value    adj.P.Val        B
## 25  3.474403 15.32845  70.51488 9.110811e-12 3.650248e-10 17.95487
## 54 -2.156827 17.52813 -69.50470 1.013958e-11 3.650248e-10 17.84146
## 21  1.209102 17.87641  44.72779 2.655826e-10 4.527970e-09 14.29968
## 55 -2.004350 15.66532 -43.91037 3.044188e-10 4.527970e-09 14.14912
## 4  -1.137775 16.23114 -43.71853 3.144424e-10 4.527970e-09 14.11336
## 47  1.252761 17.88478  35.34145 1.515174e-09 1.818209e-08 12.36901
```

Let’s look at the peak bound information for the peaks with the strongest differential signal. We can store the IDs for the top 10 peaks with

```
topPeaks <- as.numeric(rownames(dr)[1:10])
topPeaks
```

```
##  [1] 25 54 21 55  4 47 46 16 59 17
```

We can access the peak bound information with `peakBounds()` and select the rows corresponding to `topPeaks`.

```
bounds <- peakBounds(cmsSlice)
idx <- match(topPeaks, bounds[,"peaknum"])
bounds[idx,]
```

```
## DataFrame with 10 rows and 5 columns
##        mzmin     mzmax   scanmin   scanmax   peaknum
##    <numeric> <numeric> <numeric> <numeric> <numeric>
## 1     501.04    501.07       795       822        25
## 2     501.25    501.29      2095      2138        54
## 3     516.08    516.12       703       748        21
## 4     502.26    502.29      2104      2126        55
## 5     508.19    508.21       207       233         4
## 6     516.05    516.09      1586      1636        47
## 7     500.09    500.12      1583      1628        46
## 8     501.60    501.63       666       710        16
## 9     513.30    513.31      2813      2831        59
## 10    515.61    515.63       668       686        17
```

# 4 Information contained in a CMSproc object

`CMSproc` objects contain information useful in exploring your data.

## 4.1 Density estimate

The bivariate kernel density estimate matrix can be accessed with `densityEstimate()`.

```
dmat <- densityEstimate(cmsProc)
```

We can make a plot of the density estimate in a particular M/Z and scan region with `plotDensityRegion()`.

```
mzrange <- c(bounds[idx[1], "mzmin"], bounds[idx[1], "mzmax"])
scanrange <- c(bounds[idx[1], "scanmin"], bounds[idx[1], "scanmax"])
plotDensityRegion(cmsProc, mzrange = mzrange + c(-0.5,0.5), scanrange = scanrange + c(-30,30))
```

![](data:image/png;base64...)

Peaks are called by thresholding the density estimate. If we wish to investigate the impact of varying this cutoff, we can use `densityCutoff` to obtain the original cutoff and `updatePeaks()` to re-call peaks and quantify them. Quantiles of the non-zero density values are also available via `densityQuantiles()`.

```
cmsSlice2 <- slicepi(cmsProc, densityCutoff(cmsSlice)*0.99)
```

```
## [slicepi] Computing peak bounds
```

```
## [slicepi] Quantifying peaks
```

```
dqs <- densityQuantiles(cmsProc)
head(dqs)
```

```
##         0.0%         0.1%         0.2%         0.3%         0.4%         0.5%
## 2.269571e-22 8.181801e-20 1.631771e-19 2.494108e-19 3.400638e-19 4.422775e-19
```

```
cmsSlice3 <- slicepi(cmsProc, dqs["98.5%"])
```

```
## [slicepi] Computing peak bounds
## [slicepi] Quantifying peaks
```

```
nrow(peakBounds(cmsSlice)) # Number of peaks detected - original
```

```
## [1] 72
```

```
nrow(peakBounds(cmsSlice2)) # Number of peaks detected - updated
```

```
## [1] 72
```

```
nrow(peakBounds(cmsSlice3)) # Number of peaks detected - updated
```

```
## [1] 206
```

# 5 Sessioninfo

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86\_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C
[3] LC\_TIME=en\_GB LC\_COLLATE=C
[5] LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C
[9] LC\_ADDRESS=C LC\_TELEPHONE=C
[11] LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York
tzcode source: system (glibc)

attached base packages:
[1] stats4 stats graphics grDevices utils datasets methods
[8] base

other attached packages:
[1] mtbls2\_1.39.1 yamss\_1.36.0
[3] SummarizedExperiment\_1.40.0 Biobase\_2.70.0
[5] GenomicRanges\_1.62.0 Seqinfo\_1.0.0
[7] IRanges\_2.44.0 S4Vectors\_0.48.0
[9] MatrixGenerics\_1.22.0 matrixStats\_1.5.0
[11] BiocGenerics\_0.56.0 generics\_0.1.4
[13] BiocStyle\_2.38.0

loaded via a namespace (and not attached):
[1] DBI\_1.2.3 bitops\_1.0-9
[3] rlang\_1.1.6 magrittr\_2.0.4
[5] clue\_0.3-66 MassSpecWavelet\_1.76.0
[7] compiler\_4.5.1 png\_0.1-8
[9] fftwtools\_0.9-11 vctrs\_0.6.5
[11] reshape2\_1.4.4 stringr\_1.5.2
[13] ProtGenerics\_1.42.0 crayon\_1.5.3
[15] pkgconfig\_2.0.3 MetaboCoreUtils\_1.18.0
[17] fastmap\_1.2.0 magick\_2.9.0
[19] XVector\_0.50.0 rmarkdown\_2.30
[21] preprocessCore\_1.72.0 xcms\_4.8.0
[23] tinytex\_0.57 purrr\_1.1.0
[25] xfun\_0.53 MultiAssayExperiment\_1.36.0
[27] cachem\_1.1.0 jsonlite\_2.0.0
[29] progress\_1.2.3 DelayedArray\_0.36.0
[31] BiocParallel\_1.44.0 jpeg\_0.1-11
[33] tiff\_0.1-12 prettyunits\_1.2.0
[35] parallel\_4.5.1 cluster\_2.1.8.1
[37] R6\_2.6.1 bslib\_0.9.0
[39] stringi\_1.8.7 RColorBrewer\_1.1-3
[41] limma\_3.66.0 jquerylib\_0.1.4
[43] iterators\_1.0.14 Rcpp\_1.1.0
[45] bookdown\_0.45 knitr\_1.50
[47] BiocBaseUtils\_1.12.0 Matrix\_1.7-4
[49] igraph\_2.2.1 tidyselect\_1.2.1
[51] dichromat\_2.0-0.1 abind\_1.4-8
[53] yaml\_2.3.10 EBImage\_4.52.0
[55] doParallel\_1.0.17 codetools\_0.2-20
[57] affy\_1.88.0 lattice\_0.22-7
[59] tibble\_3.3.0 plyr\_1.8.9
[61] S7\_0.2.0 evaluate\_1.0.5
[63] Spectra\_1.20.0 affyio\_1.80.0
[65] pillar\_1.11.1 BiocManager\_1.30.26
[67] foreach\_1.5.2 MSnbase\_2.36.0
[69] MALDIquant\_1.22.3 ncdf4\_1.24
[71] RCurl\_1.98-1.17 hms\_1.1.4
[73] ggplot2\_4.0.0 scales\_1.4.0
[75] MsExperiment\_1.12.0 glue\_1.8.0
[77] MsFeatures\_1.18.0 lazyeval\_0.2.2
[79] tools\_4.5.1 mzID\_1.48.0
[81] data.table\_1.17.8 QFeatures\_1.20.0
[83] vsn\_3.78.0 mzR\_2.44.0
[85] locfit\_1.5-9.12 XML\_3.99-0.19
[87] fs\_1.6.6 grid\_4.5.1
[89] impute\_1.84.0 tidyr\_1.3.1
[91] MsCoreUtils\_1.22.0 PSMatch\_1.14.0
[93] cli\_3.6.5 S4Arrays\_1.10.0
[95] dplyr\_1.1.4 AnnotationFilter\_1.34.0
[97] pcaMethods\_2.2.0 gtable\_0.3.6
[99] sass\_0.4.10 digest\_0.6.37
[101] SparseArray\_1.10.0 htmlwidgets\_1.6.4
[103] farver\_2.1.2 htmltools\_0.5.8.1
[105] lifecycle\_1.0.4 statmod\_1.5.1
[107] MASS\_7.3-65

# References

Myint, Leslie, Andre Kleensang, Liang Zhao, Thomas Hartung, and Kasper D Hansen. 2017. “Joint Bounding of Peaks Across Samples Improves Differential Analysis in Mass Spectrometry-Based Metabolomics.” *Analytical Chemistry* 89 (6): 3517–23. <https://doi.org/10.1021/acs.analchem.6b04719>.

Pluskal, Tomás, Sandra Castillo, Alejandro Villar-Briones, and Matej Oresic. 2010. “MZmine 2: Modular Framework for Processing, Visualizing, and Analyzing Mass Spectrometry-Based Molecular Profile Data.” *BMC Bioinformatics* 11: 395. <https://doi.org/10.1186/1471-2105-11-395>.

Smith, Colin A, Elizabeth J Want, Grace O’Maille, Ruben Abagyan, and Gary Siuzdak. 2006. “XCMS: Processing Mass Spectrometry Data for Metabolite Profiling Using Nonlinear Peak Alignment, Matching, and Identification.” *Analytical Chemistry* 78: 779–87. <https://doi.org/10.1021/ac051437y>.