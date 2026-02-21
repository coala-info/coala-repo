Package ‘faahKO’

February 12, 2026

Version 1.50.0

Date 2025-04-23

Title Saghatelian et al. (2004) FAAH knockout LC/MS data
Author Colin A. Smith <csmith@scripps.edu>
Maintainer Steffen Neumann <sneumann@ipb-halle.de>

Depends R (>= 3.5)

Imports xcms (>= 4.5.4)

Suggests MSnbase (>= 2.33.3)

ZipData no

Description Positive ionization mode data in NetCDF file format.

Centroided subset from 200-600 m/z and 2500-4500 seconds. Data
originally reported in ``Assignment of Endogenous Substrates to Enzymes
by Global Metabolite Profiling'' Biochemistry; 2004; 43(45). Also
includes detected peaks in an xcmsSet.

biocViews ExperimentData, MassSpectrometryData

License LGPL

URL http://dx.doi.org/10.1021/bi0480335

git_url https://git.bioconductor.org/packages/faahKO

git_branch RELEASE_3_22

git_last_commit e20d46a

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.
faahko .
faahko3 .

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

.
.

.
.

.
.

.
.

. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3

5

Index

1

2

faahko

faahko

FAAH knockout LC/MS data xcmsSet

Description

xcmsSet object containing quantitated LC/MS peaks from the spinal cords of 6 wild-type and 6
FAAH knockout mice. The data is a subset of the original data from 200-600 m/z and 2500-4500
seconds. It was collected in positive ionization mode.

Usage

data(faahko)

Format

The format is:

Formal class 'xcmsSet' [package "xcms"] with 8 slots

: num [1:4776, 1:11] 200 201 205 206 207 ...
: logi[0 , 0 ]

..@ peaks
..@ groups
..@ groupidx : list()
..@ sampnames: chr [1:12] "ko15" "ko16" "ko18" "ko19" ...
..@ sampclass: Factor w/ 2 levels "KO","WT": 1 1 1 1 1 1 2 2 2 2 ...
..@ rt
:List of 12
.. ..$ raw
.. ..$ corrected:List of 12
..@ filepaths : chr [1:12] ...
..@ profinfo :List of 2
.. ..$ method: chr "bin"
.. ..$ step

:List of 2

: num 0.1

Details

The corresponding raw NetCDF files are located in the cdf subdirectory of this package.

Source

http://dx.doi.org/10.1021/bi0480335

References

Saghatelian A, Trauger SA, Want EJ, Hawkins EG, Siuzdak G, Cravatt BF. Assignment of endoge-
nous substrates to enzymes by global metabolite profiling. Biochemistry. 2004 Nov 16;43(45):14332-
9.

See Also

xcmsSet, xcmsRaw

3

faahko3

Examples

## The directory with the NetCDF LC/MS files
cdfpath <- file.path(find.package("faahKO"), "cdf")
cdfpath
list.files(cdfpath, recursive = TRUE)

if (require(xcms)) {

## xcmsSet Summary
show(faahko)

## Access raw data file
ko15 <- xcmsRaw(filepaths(faahko)[1], profmethod = "bin", profstep = 0.1)
ko15

}

faahko3

FAAH knockout LC/MS data XCMSnExp

Description

XCMSnExp object containing quantitated LC/MS peaks from the spinal cords of 6 wild-type and 6
FAAH knockout mice. The data is a subset of the original data from 200-600 m/z and 2500-4500
seconds. It was collected in positive ionization mode.

Usage

data(faahko3)

Format

The format is:

MSn experiment data ("XCMSnExp")
Object size in memory: 4.59 Mb
- - - Spectra data - - -

MS level(s): 1
Number of spectra: 15336
MSn retention times: 41:32 - 75:14 minutes

- - - Processing information - - -
Data loaded [Tue Mar 24 13:28:38 2020]

MSnbase version: 2.13.2

- - - Meta data - - -
phenoData

rowNames: 1 2 ... 12 (12 total)
varLabels: sample_name sample_group
varMetadata: labelDescription

Loaded from:

[1] ko15.CDF... [12] wt22.CDF
Use 'fileNames(.)' to see all files.

protocolData: none

4

featureData

faahko3

featureNames: F01.S0001 F01.S0002 ... F12.S1278 (15336 total)
fvarLabels: fileIdx spIdx ... spectrum (33 total)
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
- - - xcms preprocessing - - -
Chromatographic peak detection:

method: centWave
5627 peaks identified in 12 samples.
On average 469 chromatographic peaks per sample.

Alignment/retention time adjustment:

method: peak groups

Correspondence:

method: chromatographic peak density
206 features identified.
Median mz range of features: 0.10001
Median rt range of features: 28.965
325 filled peaks (on average 27.08333 per sample).

Details

The corresponding raw NetCDF files are located in the cdf subdirectory of this package.

Source

http://dx.doi.org/10.1021/bi0480335

References

Saghatelian A, Trauger SA, Want EJ, Hawkins EG, Siuzdak G, Cravatt BF. Assignment of endoge-
nous substrates to enzymes by global metabolite profiling. Biochemistry. 2004 Nov 16;43(45):14332-
9.

See Also

OnDiskMSnExp, XCMSnExp

Examples

## The directory with the NetCDF LC/MS files
cdfpath <- file.path(find.package("faahKO"), "cdf")
cdfpath
list.files(cdfpath, recursive = TRUE)

data(faahko3)

## XCMSnExp Summary
show(faahko3)

Index

∗ datasets

faahko, 2
faahko3, 3

faahKO (faahko), 2
faahko, 2
faahKO3 (faahko3), 3
faahko3, 3

OnDiskMSnExp, 4

XCMSnExp, 4
xcmsRaw, 2
xcmsSet, 2

5

