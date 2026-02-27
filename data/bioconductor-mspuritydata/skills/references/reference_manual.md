Package ‘msPurityData’

February 26, 2026

Type Package

Title Fragmentation spectral libraries and data to test the msPurity

package

Version 1.38.0

Date 12-12-2018

Author Thomas N. Lawson

Maintainer Thomas N. Lawson <thomas.nigel.lawson@gmail.com>

Description Fragmentation spectral libraries and data to test the msPurity package

License GPL (>= 2)

LazyData TRUE

VignetteBuilder knitr

RoxygenNote 5.0.1

Suggests knitr

biocViews ExperimentData, MassSpectrometryData

NeedsCompilation no

git_url https://git.bioconductor.org/packages/msPurityData

git_branch RELEASE_3_22

git_last_commit 6d21374

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

msPurityData-package .

.

. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

msPurityData-package

msPurityData-package

Test data for the msPurity package

Description

This data package contains test data to be used with package msPurity, see folders lcms and dims.
This contains LC-MS, LC-MS/MS and DI-MS datasets in mzML format. There are also various
.csv files and .rds files representing model outputs from the msPurity package. The LC-MS, LC-
MS/MS and DI-MS datasets have been reduced in size by reducing the number of scans and m/z
range.

The data package also contains a fragmentation spectral library created by msp2db (https://msp2db.readthedocs.io/en/latest/)
with data from MassBank, GNPS, LipidBlast and HMDB. This is the default spectral library that is
used with the spectral_matching with msPurity. The library data is from MoNA (http://mona.fiehnlab.ucdavis.edu/downloads)
downloaded on 5th November 2018.

The dataset also contains data relating to the msPurity publication.

Index

msPurityData (msPurityData-package), 2
msPurityData-package, 2

3

