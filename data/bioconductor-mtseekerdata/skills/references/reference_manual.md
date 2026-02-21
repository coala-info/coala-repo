Package ‘MTseekerData’

April 11, 2019

Type Package

Title Supporting Data for the MTseeker Package

Description Provides examples for the MTseeker package vignette.

Version 1.0.0

Author Tim Triche, Jr; Noor Sohail; Ben Johnson

Maintainer Tim Triche, Jr. <tim.triche@gmail.com>

License Artistic-2.0

Depends R (>= 3.5)

Imports utils, IRanges, GenomeInfoDb, GenomicRanges, GenomicFeatures,

VariantAnnotation, Homo.sapiens, MTseeker

Suggests gmapR, xml2, rtracklayer

biocViews ExperimentData, Genome

NeedsCompilation no

RoxygenNote 6.1.0

Encoding UTF-8

git_url https://git.bioconductor.org/packages/MTseekerData

git_branch RELEASE_3_8

git_last_commit a1eba5b

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

.

.

.
.onAttach .
.
mitocarta2.hg19 .
.
mitocarta2.mm10 .
.
.
RONKSreads .
.
RONKSvariants .

Index

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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3
4
4

6

1

2

mitocarta2.hg19

.onAttach

Data for the MTseeker package examples.

Description

Data for the MTseeker package examples.

Usage

.onAttach(lib, pkgname = "MTseekerData")

Arguments

lib

pkgname

Value

the library

the package name

nothing, it’s a package

mitocarta2.hg19

MitoCarta 2.0: an atlas of mitochondrial genes and proteins

Description

This is the hg19 (human) version of MitoCarta 2.0, downloaded from https://www.broadinstitute.org/scientiﬁc-
community/science/programs/metabolic-disease-program/publications/mitocarta/mitocarta-in-0

Usage

mitocarta2.hg19

Format

A GRanges object.

Details

The associated publication is Calvo, S.E., Klauser, C.R., Mootha, V.K. MitoCarta2.0: an updated
inventory of mammalian mitochondrial proteins (2015). Nucleic Acids Research.

The publication is available from http://nar.oxfordjournals.org/content/early/2015/10/
07/nar.gkv1003.full

Please cite the publication if you use the MitoCarta database.

Source

http://www.broadinstitute.org/ftp/distribution/metabolic/papers/Pagliarini/MitoCarta2.
0/Human.MitoCarta2.0.bed

mitocarta2.mm10

Examples

data(mitocarta2.hg19)
show(mitocarta2.hg19)

3

mitocarta2.mm10

MitoCarta 2.0: an atlas of mitochondrial genes and proteins

Description

This is the mm10 (mouse) version of MitoCarta 2.0, downloaded from https://www.broadinstitute.org/scientiﬁc-
community/science/programs/metabolic-disease-program/publications/mitocarta/mitocarta-in-0

Usage

mitocarta2.mm10

Format

A GRanges object.

Details

The associated publication is Calvo, S.E., Klauser, C.R., Mootha, V.K. MitoCarta2.0: an updated
inventory of mammalian mitochondrial proteins (2015). Nucleic Acids Research.

The publication is available from http://nar.oxfordjournals.org/content/early/2015/10/
07/nar.gkv1003.full

Please cite the publication if you use the MitoCarta database.

Source

http://www.broadinstitute.org/ftp/distribution/metabolic/papers/Pagliarini/MitoCarta2.
0/Mouse.MitoCarta2.0.bed

Examples

data(mitocarta2.mm10)
show(mitocarta2.mm10)

4

RONKSvariants

RONKSreads

RONKSreads: chrM reads from Renal Oncocytomas and Normal Kid-
ney Samples

Description

RONKS == "Renal Oncocytoma, Normal Kidney Sample" matched by patient This object was pro-
duced by applying MTseeker::getMT(BAMs) to the full exome BAMs, aligned against hg19_rCRSchrM
(i.e. GRCh37 with UCSC contigs).

Usage

RONKSreads

Format

An MAlignmentsList object, which subclasses GAlignmentsList

Source

https://www.ncbi.nlm.nih.gov/bioproject/PRJNA271036/

Examples

library(MTseeker)
data(RONKSreads)
show(RONKSreads)

RONKSvariants

RONKSvariants: mitochondrial variant calls from RONKSreads

Description

RONKS == "Renal Oncocytoma, Normal Kidney Sample" matched by patient This object was
produced by applying MTseeker::callMT(RONKSreads).

Usage

RONKSvariants

Format

An MVRangesList object, which subclasses VRangesList

Source

https://www.ncbi.nlm.nih.gov/bioproject/PRJNA271036/

RONKSvariants

Examples

library(MTseeker)
data(RONKSvariants)
show(RONKSvariants)
endoapply(RONKSvariants, subset, PASS == TRUE)

5

Index

∗Topic datasets

mitocarta2.hg19, 2
mitocarta2.mm10, 3
RONKSreads, 4
RONKSvariants, 4

.onAttach, 2

mitocarta2.hg19, 2
mitocarta2.mm10, 3

RONKSreads, 4
RONKSvariants, 4

6

