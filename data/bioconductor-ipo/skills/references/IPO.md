# XCMS Parameter Optimization with IPO

#### Gunnar Libiseller, Thomas Riebenbauer JOANNEUM RESEARCH Forschungsgesellschaft m.b.H., Graz, Austria

#### 2025-10-30

## Introduction

This document describes how to use the R-package `IPO` to optimize `xcms` parameters. Code examples on how to use `IPO` are provided. Additional to `IPO` the R-packages `xcms` and `rsm` are required. The R-package `msdata` and`mtbls2` are recommended. The optimization process looks as following:

 **IPO optimization process**

![](data:image/jpeg;base64...)

## Installation

```
# try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("IPO")
```

**Installing main suggested packages**

```
# for examples of peak picking parameter optimization:
BiocManager::install("msdata")
# for examples of optimization of retention time correction and grouping
# parameters:
BiocManager::install("faahKO")
```

## Raw data

`xcms` handles the file processing hence all files can be used that can be processed by `xcms`.

```
datapath <- system.file("cdf", package = "faahKO")
datafiles <- list.files(datapath, recursive = TRUE, full.names = TRUE)
```

## Optimize peak picking parameters

To optimize parameters different values (levels) have to tested for these parameters. To efficiently test many different levels design of experiment (DoE) is used. Box-Behnken and central composite designs set three evenly spaced levels for each parameter. The method `getDefaultXcmsSetStartingParams` provides default values for the lower and upper levels defining a range. Since the levels are evenly spaced the middle level or center point is calculated automatically. To edit the starting levels of a parameter set the lower and upper level as desired. If a parameter should not be optimized, set a single default value for `xcms` processing, do not set this parameter to NULL.

The method `getDefaultXcmsSetStartingParams` creates a list with default values for the optimization of the peak picking methods `centWave` or `matchedFilter`. To choose between these two method set the parameter accordingly.

The method `optimizeXcmsSet` has the following parameters:

* files: the raw data which is the basis for optimization. This does not necessarly need to be the whole dataset, only quality controls should suffice.
* params: a list consisting of items named according to `xcms` peak picking methods parameters. A default list is created by `getDefaultXcmsSetStartingParams()`.
* BPPARAM: a `BiocParallelParam`-object (see `?BiocParallel::BiocParallelParam`) to controll the use of parallelisation of `xcms`. Defaults to `bpparam()`.
* nSlaves: the number of experiments of an DoE processed in parallel
* subdir: a directory where the response surface models are stored. Can also be `NULL` if no rsm’s should be saved.

The optimization process starts at the specified levels. After the calculation of the DoE is finished the result is evaluated and the levels automatically set accordingly. Then a new DoE is generated and processed. This continues until an optimum is found.

The result of peak picking optimization is a list consisting of all calculated DoEs including the used levels, design, response, rsm and best setting. Additionally the last list item is a list (`\$best_settings`) providing the optimized parameters (`\$parameters`), an xcmsSet object (`\$xset`) calculated with these parameters and the response this `xcms`-object gives.

```
library(IPO)
```

```
peakpickingParameters <- getDefaultXcmsSetStartingParams('matchedFilter')
#setting levels for step to 0.2 and 0.3 (hence 0.25 is the center point)
peakpickingParameters$step <- c(0.2, 0.3)
peakpickingParameters$fwhm <- c(40, 50)
#setting only one value for steps therefore this parameter is not optimized
peakpickingParameters$steps <- 2

time.xcmsSet <- system.time({ # measuring time
resultPeakpicking <-
  optimizeXcmsSet(files = datafiles[1:2],
                  params = peakpickingParameters,
                  nSlaves = 1,
                  subdir = NULL,
                  plot = TRUE)
})
#>
#> starting new DoE with:
#> fwhm: c(40, 50)
#> snthresh: c(3, 17)
#> step: c(0.2, 0.3)
#> steps: 2
#> sigma: 0
#> max: 5
#> mzdiff: 0
#> index: FALSE
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#> 9
#> 10
#> 11
#> 12
#> 13
#> 14
#> 15
#> 16
```

![](data:image/png;base64...)

```
#>
#> starting new DoE with:
#> fwhm: c(45, 55)
#> snthresh: c(1, 15)
#> step: c(0.22, 0.3)
#> steps: 2
#> sigma: 0
#> max: 5
#> mzdiff: 0
#> index: FALSE
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#> 9
#> 10
#> 11
#> 12
#> 13
#> 14
#> 15
#> 16
```

![](data:image/png;base64...)

```
#>
#> starting new DoE with:
#> fwhm: c(50, 60)
#> snthresh: c(1, 15)
#> step: c(0.26, 0.34)
#> steps: 2
#> sigma: 0
#> max: 5
#> mzdiff: 0
#> index: FALSE
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#> 9
#> 10
#> 11
#> 12
#> 13
#> 14
#> 15
#> 16
```

![](data:image/png;base64...)

```
#> no increase, stopping
#> best parameter settings:
#> fwhm: 50
#> snthresh: 3
#> step: 0.26
#> steps: 2
#> sigma: 21.2332257516562
#> max: 5
#> mzdiff: 0.28
#> index: FALSE
```

```
resultPeakpicking$best_settings$result
#>    ExpId   #peaks   #NonRP      #RP      PPS
#>    0.000 3228.000 2264.000  569.000  143.004
optimizedXcmsSetObject <- resultPeakpicking$best_settings$xset
```

The response surface models of all optimization steps for the parameter optimization of peak picking are shown above.

Currently the `xcms` peak picking methods `centWave` and `matchedFilter` are supported. The parameter `peakwidth` of the peak picking method `centWave` needs two values defining a minimum and maximum peakwidth. These two values need separate optimization and are therefore split into `min_peakwidth` and `max_peakwidth` in `getDefaultXcmsSetStartingParams`. Also for the `centWave` parameter prefilter two values have to be set. To optimize these use set `prefilter` to optimize the first value and `prefilter_value` to optimize the second value respectively.

## Optimize retention time correction and grouping parameters

Optimization of retention time correction and grouping parameters is done simultaneously. The method `getDefaultRetGroupStartingParams` provides default optimization levels for the `xcms` retention time correction method `obiwarp` and the grouping method `density`. Modifying these levels should be done the same way done for the peak picking parameter optimization.

The method `getDefaultRetGroupStartingParams` only supports one retention time correction method (`obiwarp`) and one grouping method (`density`) at the moment.

The method `optimizeRetGroup` provides the following parameter: - xset: an `xcmsSet`-object used as basis for retention time correction and grouping. - params: a list consisting of items named according to `xcms` retention time correction and grouping methods parameters. A default list is created by `getDefaultRetGroupStartingParams`. - nSlaves: the number of experiments of an DoE processed in parallel - subdir: a directory where the response surface models are stored. Can also be NULL if no rsm’s should be saved.

A list is returned similar to the one returned from peak picking optimization. The last list item consists of the optimized retention time correction and grouping parameters (`\$best_settings`).

```
retcorGroupParameters <- getDefaultRetGroupStartingParams()
retcorGroupParameters$profStep <- 1
retcorGroupParameters$gapExtend <- 2.7
time.RetGroup <- system.time({ # measuring time
resultRetcorGroup <-
  optimizeRetGroup(xset = optimizedXcmsSetObject,
                   params = retcorGroupParameters,
                   nSlaves = 1,
                   subdir = NULL,
                   plot = TRUE)
})
#>
#> starting new DoE with:
#> distFunc: cor_opt
#> gapInit: c(0, 0.4)
#> gapExtend: 2.7
#> profStep: 1
#> plottype: none
#> response: 1
#> factorDiag: 2
#> factorGap: 1
#> localAlignment: 0
#> retcorMethod: obiwarp
#> bw: c(22, 38)
#> minfrac: c(0.3, 0.7)
#> mzwid: c(0.015, 0.035)
#> minsamp: 1
#> max: 50
#> center: 2
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ...
#> OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
```

![](data:image/png;base64...)

```
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#>
#>
#> starting new DoE with:
#>
#> gapInit: c(0.16, 0.64)
#> bw: c(12.4, 31.6)
#> minfrac: c(0.46, 0.94)
#> mzwid: c(0.023, 0.047)
#> distFunc: cor_opt
#> gapExtend: 2.7
#> profStep: 1
#> plottype: none
#> response: 1
#> factorDiag: 2
#> factorGap: 1
#> localAlignment: 0
#> retcorMethod: obiwarp
#> minsamp: 1
#> max: 50
#> center: 2
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
```

![](data:image/png;base64...)

```
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#> profStep or minfrac greater 1, decreasing to 0.54 and 1
#>
#>
#>
#> starting new DoE with:
#>
#> gapInit: c(0.352, 0.928)
#> bw: c(0.879999999999999, 23.92)
#> minfrac: c(0.54, 1)
#> mzwid: c(0.0326, 0.0614)
#> distFunc: cor_opt
#> gapExtend: 2.7
#> profStep: 1
#> plottype: none
#> response: 1
#> factorDiag: 2
#> factorGap: 1
#> localAlignment: 0
#> retcorMethod: obiwarp
#> minsamp: 1
#> max: 50
#> center: 2
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#>
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
```

![](data:image/png;base64...)

```
#> center sample:  ko16
#> Processing: ko15
#> Create profile matrix with method 'bin' and step 1 ... OK
#> Create profile matrix with method 'bin' and step 1 ... OK
#> no increase stopping
```

The response surface models of all optimization steps for the retention time correction and grouping parameters are shown above.

Currently the `xcms` retention time correction method `obiwarp` and grouping method `density` are supported.

## Display optimized settings

A script which you can use to process your raw data can be generated by using the function `writeRScript`.

```
writeRScript(resultPeakpicking$best_settings$parameters,
             resultRetcorGroup$best_settings)
#> library(xcms)
#> library(Rmpi)
#> xset <- xcmsSet(
#>   method   = "matchedFilter",
#>   fwhm     = 50,
#>   snthresh = 3,
#>   step     = 0.26,
#>   steps    = 2,
#>   sigma    = 21.2332257516562,
#>   max      = 5,
#>   mzdiff   = 0.28,
#>   index    = FALSE)
#> xset <- retcor(
#>   xset,
#>   method         = "obiwarp",
#>   plottype       = "none",
#>   distFunc       = "cor_opt",
#>   profStep       = 1,
#>   center         = 2,
#>   response       = 1,
#>   gapInit        = 0.64,
#>   gapExtend      = 2.7,
#>   factorDiag     = 2,
#>   factorGap      = 1,
#>   localAlignment = 0)
#> xset <- group(
#>   xset,
#>   method  = "density",
#>   bw      = 12.4,
#>   mzwid   = 0.047,
#>   minfrac = 0.94,
#>   minsamp = 1,
#>   max     = 50)
#> xset <- fillPeaks(xset)
```

## Running times and session info

Above calculations proceeded with following running times.

```
time.xcmsSet # time for optimizing peak picking parameters
#>    user  system elapsed
#> 296.932  95.430 201.279
time.RetGroup # time for optimizing retention time correction and grouping parameters
#>    user  system elapsed
#> 694.445   5.659 700.656

sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] IPO_1.36.0          CAMERA_1.66.0       Biobase_2.70.0
#> [4] BiocGenerics_0.56.0 generics_0.1.4      rsm_2.10.6
#> [7] xcms_4.8.0          BiocParallel_1.44.0 faahKO_1.49.1
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              MultiAssayExperiment_1.36.0
#>   [5] magrittr_2.0.4              TH.data_1.1-4
#>   [7] estimability_1.5.1          farver_2.1.2
#>   [9] MALDIquant_1.22.3           rmarkdown_2.30
#>  [11] fs_1.6.6                    vctrs_0.6.5
#>  [13] base64enc_0.1-3             htmltools_0.5.8.1
#>  [15] S4Arrays_1.10.0             BiocBaseUtils_1.12.0
#>  [17] progress_1.2.3              SparseArray_1.10.0
#>  [19] Formula_1.2-5               mzID_1.48.0
#>  [21] sass_0.4.10                 bslib_0.9.0
#>  [23] htmlwidgets_1.6.4           plyr_1.8.9
#>  [25] sandwich_3.1-1              impute_1.84.0
#>  [27] emmeans_2.0.0               zoo_1.8-14
#>  [29] cachem_1.1.0                igraph_2.2.1
#>  [31] lifecycle_1.0.4             iterators_1.0.14
#>  [33] pkgconfig_2.0.3             Matrix_1.7-4
#>  [35] R6_2.6.1                    fastmap_1.2.0
#>  [37] MatrixGenerics_1.22.0       clue_0.3-66
#>  [39] digest_0.6.37               colorspace_2.1-2
#>  [41] pcaMethods_2.2.0            S4Vectors_0.48.0
#>  [43] Hmisc_5.2-4                 GenomicRanges_1.62.0
#>  [45] Spectra_1.20.0              abind_1.4-8
#>  [47] compiler_4.5.1              doParallel_1.0.17
#>  [49] backports_1.5.0             htmlTable_2.4.3
#>  [51] S7_0.2.0                    DBI_1.2.3
#>  [53] MASS_7.3-65                 MsExperiment_1.12.0
#>  [55] DelayedArray_0.36.0         mzR_2.44.0
#>  [57] tools_4.5.1                 PSMatch_1.14.0
#>  [59] foreign_0.8-90              nnet_7.3-20
#>  [61] glue_1.8.0                  QFeatures_1.20.0
#>  [63] grid_4.5.1                  checkmate_2.3.3
#>  [65] cluster_2.1.8.1             reshape2_1.4.4
#>  [67] gtable_0.3.6                preprocessCore_1.72.0
#>  [69] tidyr_1.3.1                 data.table_1.17.8
#>  [71] hms_1.1.4                   MetaboCoreUtils_1.18.0
#>  [73] XVector_0.50.0              foreach_1.5.2
#>  [75] pillar_1.11.1               stringr_1.5.2
#>  [77] limma_3.66.0                splines_4.5.1
#>  [79] dplyr_1.1.4                 lattice_0.22-7
#>  [81] survival_3.8-3              tidyselect_1.2.1
#>  [83] RBGL_1.86.0                 knitr_1.50
#>  [85] gridExtra_2.3               IRanges_2.44.0
#>  [87] Seqinfo_1.0.0               ProtGenerics_1.42.0
#>  [89] SummarizedExperiment_1.40.0 stats4_4.5.1
#>  [91] xfun_0.53                   statmod_1.5.1
#>  [93] MSnbase_2.36.0              matrixStats_1.5.0
#>  [95] stringi_1.8.7               lazyeval_0.2.2
#>  [97] yaml_2.3.10                 evaluate_1.0.5
#>  [99] codetools_0.2-20            MsCoreUtils_1.22.0
#> [101] tibble_3.3.0                BiocManager_1.30.26
#> [103] graph_1.88.0                cli_3.6.5
#> [105] affyio_1.80.0               rpart_4.1.24
#> [107] xtable_1.8-4                jquerylib_0.1.4
#> [109] dichromat_2.0-0.1           Rcpp_1.1.0
#> [111] MassSpecWavelet_1.76.0      coda_0.19-4.1
#> [113] XML_3.99-0.19               parallel_4.5.1
#> [115] ggplot2_4.0.0               prettyunits_1.2.0
#> [117] AnnotationFilter_1.34.0     mvtnorm_1.3-3
#> [119] MsFeatures_1.18.0           scales_1.4.0
#> [121] affy_1.88.0                 ncdf4_1.24
#> [123] purrr_1.1.0                 crayon_1.5.3
#> [125] rlang_1.1.6                 vsn_3.78.0
#> [127] multcomp_1.4-29
```