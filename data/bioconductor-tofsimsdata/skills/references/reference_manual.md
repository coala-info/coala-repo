Package ‘tofsimsData’

February 26, 2026

Type Package

Title Import, process and analysis of ToF-SIMS imaging data

Version 1.38.0

Date 2014-10-23

Author Lorenz Gerber, Viet Mai Hoang
Maintainer Lorenz Gerber <genfys@gmail.com>

Depends R (>= 3.2.0)

Description This packages contains data to be used with the 'tofsims' package.

License GPL-3

Suggests knitr, rmarkdown, tools

VignetteBuilder knitr

biocViews ExperimentData, MassSpectrometry, ImagingMassSpectrometry,

DataImport

NeedsCompilation no

git_url https://git.bioconductor.org/packages/tofsimsData

git_branch RELEASE_3_22

git_last_commit 0519797

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

tofsimsData-package .
.
testImage .
.
testSpectra .

.
.

.
.

.
.

.
.

.
.

Index

.
.
.

.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3

4

1

2

testImage

tofsimsData-package

tofsimsData

Description

ToF-SIMS Toolbox

Details

Package:
Type:
Version:
Date:
License:
LazyLoad:

tofsimsData
Package
0.99
23-10-2014
GPL (>=2)
yes

Toolbox for Time-of-Flight Secondary Ion Mass-Spectrometry (ToF-SIMS) data processing and
analysis. The package facilitates importing of raw data files, loading preprocessed data and a range
of multivariate analysis methods that are most commonly applied in imaging (ToF-SIMS) mass
spectrometry.

Author(s)

Lorenz Gerber <lorenz.gerber@slu.se>

testImage

Example ToF-SIMS data

Description

A dataset containing a MassImage recorded on a Ulvac-Phi TRIFT-II ToF-SIMS. The .RAW data
file was imported using tofsimsImage<-MassImage('ulvacrawpeaks','filename', PeakList=tofsimsSpectra).
The sample is a freeze-dried transversal poplar wood section of 100 micrometer thickness.

Usage

data(tofsimsData)

Format

A MassImage object

Value

MassImage object

testSpectra

3

testSpectra

Example ToF-SIMS data

Description

A dataset containing a MassSpectra recorded on a Ulvac-Phi TRIFT-II ToF-SIMS. The .RAW data
file was imported using tofsimsSpectra<-MassSpectra('ulvacraw','filename'). The sample
is a freeze-dried transversal poplar wood section of 100 micrometer thickness.

Usage

data(tofsimsData)

Format

A MassSpectra object

Value

MassSpectra object

Index

∗ dataset

testImage, 2
testSpectra, 3

∗ package

tofsimsData-package, 2

testImage, 2
testSpectra, 3
tofsimsData-package, 2

4

