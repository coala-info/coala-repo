isobar for developers

Florian P. Breitwieser, Jacques Colinge

October 30, 2025

Contents

1

Introduction

2 Classes
2.1
.
IBSpectra .
2.2 ProteinGroup .
.
2.3 NoiseModel .

.

3 Session Information

1 Introduction

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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

1
1
2
3

4

This documents highlights the structure of the S4 classes and methods in the isobar pacakge.

>

library(isobar)

2 Classes

2.1

IBSpectra

>

getClass("IBSpectra")

Virtual Class "IBSpectra" [package "isobar"]

Slots:

Name:
Class:

proteinGroup
ProteinGroup

reporterTagNames
character

reporterTagMasses
numeric

Name:
Class:

isotopeImpurities
matrix

log
matrix

assayData
AssayData

Name:
featureData
Class: AnnotatedDataFrame AnnotatedDataFrame

phenoData

experimentData
MIAxE

1

Name:
Class:

annotation

protocolData
character AnnotatedDataFrame

.__classVersion__
Versions

Extends:
Class "eSet", directly
Class "VersionedBiobase", by class "eSet", distance 2
Class "Versioned", by class "eSet", distance 3

Known Subclasses:
Class "iTRAQSpectra", directly
Class "TMTSpectra", directly
Class "iTRAQ4plexSpectra", by class "iTRAQSpectra", distance 2
Class "iTRAQ8plexSpectra", by class "iTRAQSpectra", distance 2
Class "TMT2plexSpectra", by class "TMTSpectra", distance 2
Class "TMT6plexSpectra", by class "TMTSpectra", distance 2
Class "TMT6plexSpectra2", by class "TMTSpectra", distance 2
Class "TMT10plexSpectra", by class "TMTSpectra", distance 2

identifications and quantitative values. Spectrums are identified as stemming from distinct peptides,
and quantitative information of each spectrum are extracted from a certain m/z region.

IBSpectra class holds this qualitative and quantitative information. It is a virtual class. It extends
eSet from Biobase to store meta-information of spectrum identifications and quantitative information
(m/z and intensity) of reporter tags. eSet is extended by slots for protein grouping, tag names,
tag masses and isotope impurity correction matrix.

ProteinGroup objects store the mapping and grouping of peptide level identifications to protein

identifications.

IBSpectra is a virtual class. Currently used isobaric tagging kits iTRAQ 4plex and 8plex, and
TMT 2plex and 6plex are implemented in the iTRAQ4plexSpectra, iTRAQ8plexSpectra,
TMT2plexSpectra, TMT6plexSpectr and TMT10plexSpectr, respectively. These are sub-
classes of iTRAQSpectra and TMTSpectra, resp. which in turn are virtual subclasses of IBSpectra.

2.2 ProteinGroup

>

getClass("ProteinGroup")

Class "ProteinGroup" [package "isobar"]

Slots:

Name:
Class:

Name:
Class:

spectrumToPeptide
character

spectrumId
data.frame

peptideSpecificity
data.frame

peptideNProtein
matrix

2

Name: indistinguishableProteins
character
Class:

proteinGroupTable
data.frame

Name:
Class:

Name:
Class:

Name:
Class:

overlappingProteins
matrix

isoformToGeneProduct
data.frame

proteinInfo
data.frame

peptideInfo
data.frame

.__classVersion__
Versions

Extends:
Class "VersionedBiobase", directly
Class "Versioned", by class "VersionedBiobase", distance 2

mapped back to proteins. This mapping leads to protein groups, which explain the observed peptides
according to the parsimony law.

A ProteinGroup object is generated when a IBSpectra object is created by readIBSpectra.

Protein to peptide to spectrum mapping is extracted from a suitable identication format1

2.3 NoiseModel

>

getClass("NoiseModel")

Virtual Class "NoiseModel" [package "isobar"]

Slots:

Name:
Class:

na.region
numeric

low.intensity
numeric

f
function

parameter
numeric

Name: .__classVersion__
Versions
Class:

Extends:
Class "VersionedBiobase", directly
Class "Versioned", by class "VersionedBiobase", distance 2

Known Subclasses: "ExponentialNoANoiseModel", "ExponentialNoiseModel", "InverseNoiseModel",
"InverseNoANoiseModel", "GeneralNoiseModel"

in the spectrum-level ratios of a certain experimental setup.

1IBSpectra CSV, and MzIdentML format. Mascot DAT and Phenyx pidres.xml format converters to IBSpectra format are

provided.

3

3 Session Information

The version number of R and packages loaded for generating the vignette were:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, generics 0.1.4, isobar 1.56.0

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, BiocFileCache 3.0.0,

Biostrings 2.78.0, DBI 1.2.3, IRanges 2.44.0, KEGGREST 1.50.0, MASS 7.3-65, R6 2.6.1,
RColorBrewer 1.1-3, RSQLite 2.4.3, Rcpp 1.1.0, S4Vectors 0.48.0, S7 0.2.0, Seqinfo 1.0.0,
XVector 0.50.0, biomaRt 2.66.0, bit 4.6.0, bit64 4.6.0-1, blob 1.2.4, cachem 1.1.0, cli 3.6.5,
compiler 4.5.1, crayon 1.5.3, curl 7.0.0, dbplyr 2.5.1, dichromat 2.0-0.1, distr 2.9.7, dplyr 1.1.4,
farver 2.1.2, fastmap 1.2.0, filelock 1.0.3, ggplot2 4.0.0, glue 1.8.0, grid 4.5.1, gtable 0.3.6,
hms 1.1.4, httr 1.4.7, httr2 1.2.1, lifecycle 1.0.4, magrittr 2.0.4, memoise 2.0.1, pillar 1.11.1,
pkgconfig 2.0.3, plyr 1.8.9, png 0.1-8, prettyunits 1.2.0, progress 1.2.3, rappdirs 0.3.3,
rlang 1.1.6, scales 1.4.0, sfsmisc 1.1-22, startupmsg 1.0.0, stats4 4.5.1, stringi 1.8.7,
stringr 1.5.2, tibble 3.3.0, tidyselect 1.2.1, tools 4.5.1, vctrs 0.6.5

4

