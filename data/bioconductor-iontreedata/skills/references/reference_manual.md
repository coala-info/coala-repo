Package ‘iontreeData’
April 11, 2019

Type Package
Title Data provided to show the usage of functions in iontree package
Version 1.18.0
Author Mingshu Cao
Maintainer Mingshu Cao <mingshu.cao@agresearch.co.nz>
Description Raw MS2, MS3 scans from direct infusion mass spectrome-

try (DIMS) and a demo ion tree database 'mzDB' derived from the DIMS data are in-
cluded. The demo database is used to show the functionalities provided by the 'iontree' pack-
age, not for the purpose of compound identiﬁcation by any means.

License GPL-2
biocViews ExperimentData, MassSpectrometryData
LazyLoad yes
PackageStatus Deprecated
git_url https://git.bioconductor.org/packages/iontreeData
git_branch RELEASE_3_8
git_last_commit 677fbef
git_last_commit_date 2018-10-30
Date/Publication 2019-04-11

R topics documented:

iontreeData-package
.
MS2RAW .
.
MS3RAW .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

.
.

Index

iontreeData-package

Data for iontree package

1
2
3

4

Description

There are 3 data sets including raw MS2, MS3 scans ’MS2RAW’, ’MS3RAW’ and a SQLite-based
ion tree database named ’mzDB’.

Details

1

2

MS2RAW

Package:
Type:
Version:
License:
LazyLoad:

iontreeData
Package
0.99.0
GPL-2
yes

Author(s)

Mingshu Cao <mingshu.cao@agresearch.co.nz>

References

Cao M, Koulman A, Johnson LJ, Lane GA and Rasmussen S. 2008. Plant Physiology 146:4

MS2RAW

All the MS2 scans from 4 samples

Description

MS2RAW data from direct infusion mass spectrometry.

Usage

data(MS2RAW)

Format

see examples

Source

Cao M, Koulman A, Johnson LJ, Lane GA and Rasmussen S. 2008. Plant Physiology 146:4

Examples

data(MS2RAW)
length(MS2RAW)
attributes(MS2RAW[[1]])

MS3RAW

3

MS3RAW

All the MS3 scans from 4 samples

Description

MS3RAW data from direct infusion mass spectrometry.

Usage

data(MS3RAW)

Format

see examples

Source

Cao M, Koulman A, Johnson LJ, Lane GA and Rasmussen S. 2008. Plant Physiology 146:4

Examples

data(MS3RAW)

Index

∗Topic datasets
MS2RAW, 2
MS3RAW, 3
∗Topic package

iontreeData-package, 1

iontreeData (iontreeData-package), 1
iontreeData-package, 1

MS2RAW, 2
MS3RAW, 3

4

