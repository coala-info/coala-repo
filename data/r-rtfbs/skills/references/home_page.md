# RTFBS: Transcription Factor Binding Sites... *in R*

## Introduction

RTFBS is an [R](http://www.r-project.org) software package
used to identify transcription factor binding sites.
It contains functions for data pre-processing, site identification & scoring,
FDR calculation, and score/FDR thresholding. RTFBS provides a variety of
options, allowing users flexibility, all within a highly-developed statistical programming
environment.

## Download

|  |  |
| --- | --- |
| Package source: | [rtfbs\_0.3.5.tar.gz](downloads/rtfbs_0.3.5.tar.gz) |
| Windows binary: | [rtfbs\_0.3.5.zip](downloads/win32/rtfbs_0.3.5.zip) |
| Development version: | [rtfbs\_0.3.5.tar.gz](downloads/rtfbs_0.3.5.tar.gz) |
| Latest Windows build (devel): | [rtfbs\_0.3.5.zip](downloads/rtfbs_0.3.5.zip) |

## Install

RTFBS should install like any R package. It can be obtained and installed via CRAN from within R using the command:
> install.packages("rtfbs")

Note that if you are running Windows or Mac OS X, you will need an up-to-date version of R for this command to work. On Mac OS X with xcode, you can install onto an older R version with the command:
> install.packages("rtfbs", type="source")

Or to use the package files provided on this page, use one of these (depending on your platform):
> install.packages("rtfbs\_0.3.5.tar.gz", repos=NULL) #(to install from source code)
> install.packages("rtfbs\_0.3.5.zip", repos=NULL) #(to install windows binary)

The package source can also be installed from the command line on non-Windows platforms using the command:
R CMD INSTALL rtfbs\_0.3.5.tar.gz

NOTE: If you do not have administrator privileges, you may need to specify a directory where the package will be stored. This can be done with the "library" argument to install.packages, or by using R CMD INSTALL --library=/path/to/library on the command line.

## Documentation

| PDF | Sweave source | description |
| --- | --- | --- |
| <vignette.pdf> | <vignette.Rnw> | Read in sequence data & PWM, data pre-processing, site identification & scoring, FDR thresholding of identified sites |
| <rtfbs-manual.pdf> |  | Reference manual ||

## Plans

Our next step for RTFBS is to add user supported scoring functions.

## Contact

Problems, questions, feature requests should be directed to rtfbshelp@cshl.edu.