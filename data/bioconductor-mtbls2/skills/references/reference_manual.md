Package ‘mtbls2’
February 17, 2026

Version 1.40.0

Date 2025-05-09

Encoding UTF-8

Title MetaboLights MTBLS2: Comparative LC/MS-based profiling of silver

nitrate-treated Arabidopsis thaliana leaves of wild-type and
cyp79B2 cyp79B3 double knockout plants. Böttcher et al. (2004)

Author Steffen Neumann <sneumann@ipb-halle.de>
Maintainer Steffen Neumann <sneumann@ipb-halle.de>
Depends R (>= 2.10)

Suggests MSnbase, xcms (>= 3.13.8), CAMERA, knitr, Heatplus,

pcaMethods, sp, rmarkdown, Biobase

VignetteBuilder knitr

ZipData no

Description Indole-3-acetaldoxime (IAOx) represents an early

intermediate of the biosynthesis of a variety of indolic
secondary metabolites including the phytoanticipin
indol-3-ylmethyl glucosinolate and the phytoalexin camalexin
(3-thiazol-2'-yl-indole). Arabidopsis thaliana cyp79B2 cyp79B3
double knockout plants are completely impaired in the
conversion of tryptophan to indole-3-acetaldoxime and do not
accumulate IAOx-derived metabolites any longer. Consequently,
comparative analysis of wild-type and cyp79B2 cyp79B3 plant
lines has the potential to explore the complete range of
IAOx-derived indolic secondary metabolites.

biocViews MassSpectrometryData, RepositoryData

License CC0

URL http://www.ebi.ac.uk/metabolights/MTBLS2,
https://github.com/sneumann/mtbls2

NeedsCompilation no

git_url https://git.bioconductor.org/packages/mtbls2

git_branch RELEASE_3_22

git_last_commit 78b9c59

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

1

2

Contents

mtbls2

mtbls2 .

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

Index

mtbls2

Description

Comparative LC/MS-based profiling of silver nitrate-treated Ara-
bidopsis thaliana leaves of wild-type and cyp79B2 cyp79B3 double
knockout plants

2

5

xcmsSet object from the data in the paper on "Indole-3-acetaldoxime (IAOx) represents an early
intermediate of the biosynthesis of a variety of indolic secondary metabolites including the phy-
toanticipin indol-3-ylmethyl glucosinolate and the phytoalexin camalexin (3-thiazol-2’-yl-indole).
Arabidopsis thaliana cyp79B2 cyp79B3 double knockout plants are completely impaired in the con-
version of tryptophan to indole-3-acetaldoxime and do not accumulate IAOx-derived metabolites
any longer. Consequently, comparative analysis of wild-type and cyp79B2 cyp79B3 plant lines has
the potential to explore the complete range of IAOx-derived indolic secondary metabolites." It was
collected in positive ionization mode.

Usage

data(mtbls2)

Format

The format is:

Formal class 'xcmsSet' [package "xcms"] with 12 slots

: num [1:83861, 1:23] 361 369 447 277 372 ...

..@ peaks
.. ..- attr(*, "dimnames")=List of 2
.. .. ..$ : NULL
.. .. ..$ : chr [1:23] "mz" "mzmin" "mzmax" "rt" ...
: logi[0 , 0 ]
..@ groups
: list()
..@ groupidx
: int(0)
..@ filled
..@ phenoData
:'data.frame': 16 obs. of
.. ..$ Factor.Value.genotype. : Factor w/ 2 levels "Col-0","cyp79": 1 1 1 1 2 2 2 2 1 1 ...
.. ..$ Factor.Value.replicate.: Factor w/ 2 levels "Exp1","Exp2": 1 1 1 1 1 1 1 1 2 2 ...
..@ rt
.. ..$ raw
.. .. ..$ : num [1:3562] 0.562 0.898 1.235 1.572 1.908 ...
.. .. ..$ : num [1:3570] 0.57 0.907 1.244 1.58 1.917 ...
.. .. ..$ : num [1:3564] 0.823 1.159 1.496 1.833 2.236 ...
.. .. ..$ : num [1:3566] 0.501 0.838 1.175 1.511 1.848 ...
.. .. ..$ : num [1:3565] 0.514 0.851 1.187 1.524 1.861 ...
.. .. ..$ : num [1:3566] 0.73 1.07 1.4 1.74 2.08 ...
.. .. ..$ : num [1:3567] 0.513 0.85 1.187 1.523 1.86 ...
.. .. ..$ : num [1:3568] 0.499 0.836 1.173 1.509 1.846 ...
.. .. ..$ : num [1:3567] 0.53 0.866 1.203 1.54 1.876 ...

2 variables:

:List of 16

:List of 2

mtbls2

3

.. .. ..$ : num [1:3567] 0.672 1.008 1.345 1.682 2.019 ...
.. .. ..$ : num [1:3568] 0.604 0.94 1.277 1.614 1.95 ...
.. .. ..$ : num [1:3566] 0.514 0.85 1.187 1.524 1.86 ...
.. .. ..$ : num [1:3568] 0.511 0.848 1.184 1.521 1.858 ...
.. .. ..$ : num [1:3567] 0.483 0.82 1.156 1.493 1.83 ...
.. .. ..$ : num [1:3567] 0.508 0.844 1.181 1.518 1.855 ...
.. .. ..$ : num [1:3568] 0.48 0.817 1.154 1.491 1.827 ...
.. ..$ corrected:List of 16
.. .. ..$ : num [1:3562] 0.562 0.898 1.235 1.572 1.908 ...
.. .. ..$ : num [1:3570] 0.57 0.907 1.244 1.58 1.917 ...
.. .. ..$ : num [1:3564] 0.823 1.159 1.496 1.833 2.236 ...
.. .. ..$ : num [1:3566] 0.501 0.838 1.175 1.511 1.848 ...
.. .. ..$ : num [1:3565] 0.514 0.851 1.187 1.524 1.861 ...
.. .. ..$ : num [1:3566] 0.73 1.07 1.4 1.74 2.08 ...
.. .. ..$ : num [1:3567] 0.513 0.85 1.187 1.523 1.86 ...
.. .. ..$ : num [1:3568] 0.499 0.836 1.173 1.509 1.846 ...
.. .. ..$ : num [1:3567] 0.53 0.866 1.203 1.54 1.876 ...
.. .. ..$ : num [1:3567] 0.672 1.008 1.345 1.682 2.019 ...
.. .. ..$ : num [1:3568] 0.604 0.94 1.277 1.614 1.95 ...
.. .. ..$ : num [1:3566] 0.514 0.85 1.187 1.524 1.86 ...
.. .. ..$ : num [1:3568] 0.511 0.848 1.184 1.521 1.858 ...
.. .. ..$ : num [1:3567] 0.483 0.82 1.156 1.493 1.83 ...
.. .. ..$ : num [1:3567] 0.508 0.844 1.181 1.518 1.855 ...
.. .. ..$ : num [1:3568] 0.48 0.817 1.154 1.491 1.827 ...
..@ filepaths
..@ profinfo
.. ..$ method: chr "bin"
.. ..$ step : num 0.1
..@ dataCorrection
..@ polarity
..@ progressInfo
: num 0
.. ..$ group.density
: num 0
.. ..$ group.mzClust
: num 0
.. ..$ group.nearest
: num 0
.. ..$ findPeaks.centWave
.. ..$ findPeaks.massifquant
: num 0
.. ..$ findPeaks.matchedFilter: num 0
: num 0
.. ..$ findPeaks.MS1
: num 0
.. ..$ findPeaks.MSW
: num 0
.. ..$ retcor.obiwarp
: num 0
.. ..$ retcor.peakgroups
: num 0
.. ..$ fillPeaks.chrom
.. ..$ fillPeaks.MSW
: num 0
..@ progressCallback:function (progress)

: int(0)
: chr(0)
:List of 12

:List of 2

: chr [1:16] "/usr/local/lib/R/site-library/mtbls2//vol/R/BioC/devel/mtbls2/MSpos-Ex1-Col0-48h-Ag-1_1-A,1_01_9818.mzData" "/usr/local/lib/R/site-library/mtbls2//vol/R/BioC/devel/mtbls2/MSpos-Ex1-Col0-48h-Ag-2_1-A,1_01_9820.mzData" "/usr/local/lib/R/site-library/mtbls2//vol/R/BioC/devel/mtbls2/MSpos-Ex1-Col0-48h-Ag-3_1-A,1_01_9822.mzData" "/usr/local/lib/R/site-library/mtbls2//vol/R/BioC/devel/mtbls2/MSpos-Ex1-Col0-48h-Ag-4_1-A,1_01_9824.mzData" ...

Details

The corresponding raw mzData files are located in the mzData subdirectory of this package.

Source

http://www.ebi.ac.uk/metabolights/MTBLS2 https://github.com/sneumann/mtbls2

4

References

mtbls2

Neumann, S., Thum, A. & Böttcher, C. Nearline acquisition and processing of liquid chromatography-
tandem mass spectrometry data Metabolomics (2012) DOI: 10.1007/s11306-012-0401-0

See Also

xcmsSet, xcmsRaw

Examples

data(mtbls2)

## The directory with the mzData LC/MS files
filepath <- file.path(find.package("mtbls2"), "mzData")
filepath
list.files(filepath, recursive = TRUE)

if (require(xcms)) {

## xcmsSet Summary
show(mtbls2Set)

filepaths(mtbls2Set)[1]

## Access raw data file

## Not run:
xr <- xcmsRaw(filepaths(mtbls2Set)[1], profmethod = "bin", profstep = 0.1)
xr

## End(Not run)
}

Index

∗ datasets

mtbls2, 2

mtbls2, 2
mtbls2Set (mtbls2), 2

xcmsRaw, 4
xcmsSet, 4

5

