Package ‘aroma.affymetrix’

August 19, 2025

Version 3.2.3

Depends R (>= 3.2.0), R.utils (>= 2.9.0), aroma.core (>= 3.2.0)

Imports methods, R.methodsS3 (>= 1.7.1), R.oo (>= 1.23.0), R.cache (>=

0.14.0), R.devices (>= 2.16.1), R.filesets (>= 2.13.0),
aroma.apd (>= 0.6.0), MASS, splines, matrixStats (>= 0.55.0),
listenv, future

Suggests DBI (>= 1.0.0), RColorBrewer (>= 1.1-2), Biobase (>= 2.28.0),

BiocGenerics (>= 0.14.0), affxparser (>= 1.40.0), affy (>=
1.46.0), affyPLM (>= 1.44.0), aroma.light (>= 2.4.0), gcrma (>=
2.40.0), limma (>= 3.24.1), oligo (>= 1.32.0), oligoClasses (>=
1.30.0), pdInfoBuilder (>= 1.32.0), preprocessCore (>= 1.28.0),
AffymetrixDataTestFiles, dChipIO (>= 0.1.1)

SuggestsNote BioC (>= 3.0), Recommended: preprocessCore, affyPLM,

aroma.light, affxparser, DNAcopy

Title Analysis of Large Affymetrix Microarray Data Sets

Description A cross-platform R framework that facilitates processing of any num-

ber of Affymetrix microarray samples regardless of computer system. The only parame-
ter that limits the number of chips that can be processed is the amount of avail-
able disk space. The Aroma Framework has successfully been used in studies to pro-
cess tens of thousands of arrays. This package has actively been used since 2006.

License LGPL (>= 2.1)

URL https://www.aroma-project.org/,

https://github.com/HenrikBengtsson/aroma.affymetrix

BugReports https://github.com/HenrikBengtsson/aroma.affymetrix/issues

LazyLoad TRUE

biocViews Infrastructure, ProprietaryPlatforms, ExonArray, Microarray,
OneChannel, GUI, DataImport, DataRepresentation, Preprocessing,
QualityControl, Visualization, ReportWriting, aCGH,
CopyNumberVariants, DifferentialExpression, GeneExpression,
SNP, Transcription

NeedsCompilation no

1

2

Contents

Author Henrik Bengtsson [aut, cre, cph],

James Bullard [ctb],
Kasper Hansen [ctb],
Pierre Neuvial [ctb],
Elizabeth Purdom [ctb],
Mark Robinson [ctb],
Ken Simpson [ctb]

Maintainer Henrik Bengtsson <henrikb@braju.com>
Repository CRAN

Date/Publication 2025-08-19 07:00:02 UTC

Contents

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
.
.
.
.
.

4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
aroma.affymetrix-package
6
AbstractProbeSequenceNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
AdditiveCovariatesNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
AffineCnPlm .
9
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
AffinePlm .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
AffineSnpPlm .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
AffymetrixCdfFile
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
AffymetrixCelFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
AffymetrixCelSet
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
AffymetrixCelSetReporter
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
AffymetrixCelSetTuple .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
AffymetrixCnChpSet
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
.
AffymetrixFile
AffymetrixFileSet .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
.
AffymetrixFileSetReporter . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
AffymetrixPgfFile .
AlleleSummation .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
AllelicCrosstalkCalibration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
AromaChipTypeAnnotationFile
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
ArrayExplorer .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
AvgCnPlm .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
.
.
AvgPlm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
.
AvgSnpPlm .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
BackgroundCorrection .
.
BaseCountNormalization .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
BasePositionNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
.
ChipEffectFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
ChipEffectSet
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
ChipEffectTransform .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
.
CnagCfhFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
.
CnagCfhSet
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
.
CnChipEffectFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
.
.
CnChipEffectSet
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
.
.
.
CnPlm .

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
.

.
.

.
.

.

.

.

.

Contents

3

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
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
CnProbeAffinityFile .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
.
CrlmmParametersFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
.
.
CrlmmParametersSet
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
.
.
.
DChipCdfBinFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
.
.
.
.
DChipDcpFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
DChipDcpSet
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82
DChipGenomeInformation .
DChipQuantileNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 84
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
DChipSnpInformation .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 88
.
doCRMAv1 .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 89
.
doCRMAv2 .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 91
.
doFIRMA .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 92
.
.
doGCRMA .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 93
.
doRMA .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 94
.
ExonChipEffectFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 96
ExonChipEffectSet
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 99
ExonProbeAffinityFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 101
.
ExonRmaPlm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 103
.
.
FirmaFile .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 105
.
.
FirmaModel .
FirmaSet .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 106
.
.
.
FragmentEquivalentClassNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . 109
FragmentLengthNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 111
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 113
.
GcContentNormalization .
GcContentNormalization2 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 114
GcRmaBackgroundCorrection . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 116
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118
GenericReporter .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 119
GenomeInformation .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 121
HetLogAddCnPlm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 123
HetLogAddPlm .
.
HetLogAddSnpPlm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 124
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 126
.
justRMA .
LimmaBackgroundCorrection . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 127
LinearModelProbeSequenceNormalization . . . . . . . . . . . . . . . . . . . . . . . . . 129
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 131
MatNormalization .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 133
.
MatSmoothing .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 134
.
.
.
MbeiCnPlm .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 136
.
.
MbeiPlm .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 138
.
.
.
MbeiSnpPlm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 140
.
.
.
.
.
.
Model
MultiArrayUnitModel .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 141
NormExpBackgroundCorrection . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 143
OpticalBackgroundCorrection . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 144
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 146
ParameterCelFile .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 148
ParameterCelSet
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 150
.
ProbeAffinityFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 153
ProbeLevelModel .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 155
ProbeLevelTransform .

.
.
. .
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

4

aroma.affymetrix-package

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

. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 156
.
ProbeLevelTransform3 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 158
QualityAssessmentFile .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 160
.
QualityAssessmentModel .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 161
.
QualityAssessmentSet
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 163
QuantileNormalization .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 165
ReseqCrosstalkCalibration .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 167
.
ResidualFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 169
ResidualSet
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 171
RmaBackgroundCorrection .
.
.
.
.
.
.
RmaCnPlm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 173
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 175
.
.
.
RmaPlm .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 177
.
RmaSnpPlm .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 179
.
ScaleNormalization .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 181
.
ScaleNormalization3 .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 182
. .
SingleArrayUnitModel
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 184
.
SmoothMultiarrayModel
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 185
.
.
SmoothRmaModel
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 186
.
.
SnpChipEffectFile
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 189
.
.
SnpChipEffectSet .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 191
.
.
.
.
SnpInformation .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 193
.
.
SnpPlm .
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 196
.
.
SnpProbeAffinityFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 198
.
.
.
.
SpatialReporter
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 199
.
TransformReport
.
.
.
.
UgpGenomeInformation .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 201
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 203
.
.
.
UnitModel .
UnitTypeScaleNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 204
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 206
WeightsFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 208
.
WeightsSet

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

.

.

.

.

.

.

.

Index

211

aroma.affymetrix-package

Package aroma.affymetrix

Description

A cross-platform R framework that facilitates processing of any number of Affymetrix microarray
samples regardless of computer system. The only parameter that limits the number of chips that can
be processed is the amount of available disk space. The Aroma Framework has successfully been
used in studies to process tens of thousands of arrays. This package has actively been used since
2006.

aroma.affymetrix-package

Installation and updates

The preferred way to install this package is:

source("https://callr.org/install#aroma.affymetrix")

5

To get started

To get started, see the online user guides and the vignettes https://www.aroma-project.org/.

How to cite this package

In order to keep improving and providing support for this project, please cite references [1], [2],
or any applicable publication listed on https://aroma-project.org/publications/, whenever
you publish work that have been used any of the Aroma Framework.

License

The releases of this package is licensed under LGPL version 2.1 or newer.

The development code of the packages is under a private license (where applicable) and patches sent
to the author fall under the latter license, but will be, if incorporated, released under the "release"
license above.

Author(s)

Henrik Bengtsson, James Bullard, Kasper Hansen, Pierre Neuvial, Elizabeth Purdom, Mark Robin-
son, Ken Simpson

References

[1] H. Bengtsson, K. Simpson, J. Bullard, and K. Hansen, aroma.affymetrix: A generic framework
in R for analyzing small to very large Affymetrix data sets in bounded memory, Tech Report #745,
Department of Statistics, University of California, Berkeley, February 2008.
[2] H. Bengtsson, R. Irizarry, B. Carvalho, and T. Speed, Estimation and assessment of raw copy
numbers at the single locus level, Bioinformatics, 2008.
[3] H. Bengtsson, The R.oo package - Object-Oriented Programming with References Using Stan-
dard R Code, In Kurt Hornik, Friedrich Leisch and Achim Zeileis, editors, Proceedings of the 3rd
International Workshop on Distributed Statistical Computing (DSC 2003), March 20-22, Vienna,
Austria. https://www.r-project.org/conferences/DSC-2003/Proceedings/

For a complete list, see https://aroma-project.org/publications/.

6

AbstractProbeSequenceNormalization

AbstractProbeSequenceNormalization

The AbstractProbeSequenceNormalization class

Description

Package: aroma.affymetrix
Class AbstractProbeSequenceNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AbstractProbeSequenceNormalization

Directly known subclasses:
BaseCountNormalization, BasePositionNormalization, LinearModelProbeSequenceNormalization,
MatNormalization

public abstract static class AbstractProbeSequenceNormalization
extends ProbeLevelTransform3

This abstract class represents a normalization method that corrects for systematic effects in the
probe intensities due to differences in probe sequences.

Usage

AbstractProbeSequenceNormalization(..., target=NULL)

Arguments

...

target

Arguments passed to the constructor of ProbeLevelTransform3.
A character string specifying type of "target" used. If "zero", all arrays are
normalized to have no effects. If NULL, all arrays a normalized to have the same
effect as the average array has.

AdditiveCovariatesNormalization

7

Fields and Methods

Methods:

getTargetFile
process

-
Normalizes the data set.

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires that an AromaCellSequenceFile is available for the chip type.

Author(s)

Henrik Bengtsson

AdditiveCovariatesNormalization

The AdditiveCovariatesNormalization class

Description

Package: aroma.affymetrix
Class AdditiveCovariatesNormalization

Object
~~|

8

AdditiveCovariatesNormalization

~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ChipEffectTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AdditiveCovariatesNormalization

Directly known subclasses:
GcContentNormalization2

public abstract static class AdditiveCovariatesNormalization
extends ChipEffectTransform

This class represents a normalization method that corrects for GC-content effects on copy-number
chip-effect estimates.

Usage

AdditiveCovariatesNormalization(dataSet=NULL, ..., target=NULL, subsetToFit="-XY",

shift=0, onMissing=c("median", "ignore"))

Arguments

dataSet

...

target

A SnpChipEffectSet.

Additional arguments passed to the constructor of ChipEffectTransform.

(Optional) A character string or a function specifying what to normalize
toward.

subsetToFit

The units from which the normalization curve should be estimated. If NULL, all
are considered.

onMissing

shift

Details

Specifies how to normalize units for which the GC contents are unknown.

An optional amount the data points should be shifted (translated).

For SNPs, the normalization function is estimated based on the total chip effects, i.e. the sum of the
allele signals. The normalizing is done by rescale the chip effects on the intensity scale such that
the mean of the total chip effects are the same across samples for any given GC content. For allele-
specific estimates, both alleles are always rescaled by the same amount. Thus, when normalizing
allele-specific chip effects, the total chip effects is change, but not the relative allele signal, e.g. the
allele B frequency.

AffineCnPlm

Fields and Methods

Methods:

9

getCdf
process Normalizes the data set.

-

Methods inherited from ChipEffectTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffineCnPlm

The AffineCnPlm class

Description

Package: aroma.affymetrix
Class AffineCnPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel

10

AffineCnPlm

~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffinePlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffineSnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffineCnPlm

Directly known subclasses:

public abstract static class AffineCnPlm
extends CnPlm

Usage

AffineCnPlm(..., combineAlleles=FALSE)

Arguments

...

Arguments passed to AffineSnpPlm.

combineAlleles If FALSE, allele A and allele B are treated separately, otherwise together.

Fields and Methods

Methods:
No methods defined.

Methods inherited from CnPlm:
getCellIndices, getChipEffectSet, getCombineAlleles, getParameters, getProbeAffinityFile, setCom-
bineAlleles

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from AffineSnpPlm:
getAsteriskTags

Methods inherited from AffinePlm:
getAsteriskTags, getFitUnitGroupFunction, getProbeAffinityFile

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

AffinePlm

11

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffinePlm

The AffinePlm class

Description

Package: aroma.affymetrix
Class AffinePlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffinePlm

Directly known subclasses:
AffineCnPlm, AffineSnpPlm

12

AffinePlm

public abstract static class AffinePlm
extends ProbeLevelModel

This class represents affine model in Bengtsson & Hossjer (2006).

Usage

AffinePlm(..., background=TRUE)

Arguments

...

background

Fields and Methods

Methods:

Arguments passed to ProbeLevelModel.
If TRUE, background is estimate for each unit group, otherwise not. That is, if
FALSE, a linear (proportional) model without offset is fitted, resulting in very
similar results as obtained by the MbeiPlm.

getProbeAffinityFile

-

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Model

For a single unit group, the affine model is:

yik = a + θiϕk + εik

AffineSnpPlm

13

where a is an offset common to all probe signals, θi are the chip effects for arrays i = 1, ..., I,
and ϕk are the probe affinities for probes k = 1, ..., K. The εik are zero-mean noise with equal
variance. The model is constrained such that (cid:81)
Note that with the additional constraint a = 0 (see arguments above), the above model is very
similar to MbeiPlm. The differences in parameter estimates is due to difference is assumptions
about the error structure, which in turn affects how the model is estimated.

k ϕk = 1.

Author(s)

Henrik Bengtsson

References

Bengtsson & Hossjer (2006).

AffineSnpPlm

The AffineSnpPlm class

Description

Package: aroma.affymetrix
Class AffineSnpPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffinePlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffineSnpPlm

Directly known subclasses:
AffineCnPlm

14

AffineSnpPlm

public abstract static class AffineSnpPlm
extends SnpPlm

Usage

AffineSnpPlm(..., mergeStrands=FALSE)

Arguments

...

mergeStrands

Arguments passed to AffinePlm.
If TRUE, the sense and the anti-sense strands are fitted together, otherwise sepa-
rately.

Fields and Methods

Methods:
No methods defined.

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from AffinePlm:
getAsteriskTags, getFitUnitGroupFunction, getProbeAffinityFile

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffymetrixCdfFile

15

AffymetrixCdfFile

The AffymetrixCdfFile class

Description

Package: aroma.affymetrix
Class AffymetrixCdfFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaChipTypeAnnotationFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitAnnotationDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitTypesFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitNamesFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCdfFile

Directly known subclasses:

public abstract static class AffymetrixCdfFile
extends UnitNamesFile

An AffymetrixCdfFile object represents a generic Affymetrix CDF file.

Usage

AffymetrixCdfFile(...)

AffymetrixCdfFile

Arguments passed to AromaChipTypeAnnotationFile.

16

Arguments

...

Fields and Methods

Methods:

Converts a CDF into the same CDF but with another format.

convert
createExonByTranscriptCdf Creates an exon-by-transcript CDF.
getACSFile
-
getAromaCellSequenceFile
-
getCellIndices
Gets the cell indices unit by unit.
getChipType
-
getDimension
-
getFileFormat
-
getGenomeInformation
Gets genome information for this chip type.
getImage
-
getPlatform
-
getUnitNames
Gets the names of each unit.
getUnitTypes
Gets the types of a set of units.
hasUnitTypes
-
isMonocellCdf
-
isPm
Checks which cells (probes) are PMs and not.
isUniqueCdf
-
nbrOfCells
-
nbrOfColumns
-
nbrOfQcUnits
-
nbrOfRows
-
nbrOfUnits
-
readDataFrame
-
readUnits
Reads CDF data unit by unit.

Methods inherited from UnitNamesFile:
getUnitNames, indexOf, nbrOfUnits

Methods inherited from UnitTypesFile:
getUnitTypes, nbrOfUnits

Methods inherited from UnitAnnotationDataFile:
byChipType, getAromaUflFile, getAromaUgpFile, getChipType, getDefaultExtension, getPlatform,
nbrOfUnits

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaChipTypeAnnotationFile:
as.character, byChipType, byName, findByChipType, fromFile, getChipType, getDefaultExtension,
getHeader, getPlatform

AffymetrixCelFile

17

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson, Ken Simpson

AffymetrixCelFile

The AffymetrixCelFile class

Description

Package: aroma.affymetrix
Class AffymetrixCelFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile

18

AffymetrixCelFile

~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile

Directly known subclasses:
ChipEffectFile, CnChipEffectFile, CnProbeAffinityFile, ExonChipEffectFile, ExonProbeAffinityFile,
FirmaFile, ParameterCelFile, ProbeAffinityFile, QualityAssessmentFile, ResidualFile, SnpChipEf-
fectFile, SnpProbeAffinityFile, WeightsFile

public abstract static class AffymetrixCelFile
extends AffymetrixFile

An AffymetrixCelFile object represents a single Affymetrix CEL file.

Usage

AffymetrixCelFile(..., cdf=NULL)

Arguments

...

cdf

Fields and Methods

Methods:

Arguments passed to AromaMicroarrayDataFile.
An optional AffymetrixCdfFile making it possible to override the default CDF
file as specified by the CEL file header. The requirement is that its number of
cells must match that of the CEL file. If NULL, the CDF structure is inferred from
the the chip type as specified in the CEL file header.

extractMatrix
getAm
getCdf
getFileFormat
getImage
getUnitNamesFile
getUnitTypesFile
image270

-
-
Gets the CDF structure for this CEL file.
-
Creates an RGB Image object from a CEL file.
-
-
Displays all or a subset of the data spatially.

AffymetrixCelFile

19

nbrOfCells
plotDensity
plotImage
plotMvsA
plotMvsX
setCdf
smoothScatterMvsA
writeImage

-
Plots the density of the probe signals on the array.
Displays a spatial plot of a CEL file.
Plots log-ratio versus log-intensity in a scatter plot.
Plots log-ratio versus another variable in a scatter plot.
Sets the CDF structure for this CEL file.
Plots log-ratio versus log-intensity in a smooth scatter plot.
Writes a spatial image of the signals in the CEL file.

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

For developers

If you subclass this class, please make sure to query the AffymetrixCdfFile object (see *getCdf())
whenever querying CDF information. Do not use the CDF file inferred from the chip type in CEL
header, unless you really want it to be hardwired that way, otherwise you will break to possibility
to override the CDF structure.

AffymetrixCelSet

20

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically part of an AffymetrixCelSet.

AffymetrixCelSet

The AffymetrixCelSet class

Description

Package: aroma.affymetrix
Class AffymetrixCelSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet

Directly known subclasses:
ChipEffectSet, CnChipEffectSet, ExonChipEffectSet, FirmaSet, ParameterCelSet, QualityAssess-
mentSet, ResidualSet, SnpChipEffectSet, WeightsSet

public static class AffymetrixCelSet
extends AffymetrixFileSet

An AffymetrixCelSet object represents a set of Affymetrix CEL files with identical chip types.

Usage

AffymetrixCelSet(files=NULL, ...)

Arguments

files

...

A list of AffymetrixCelFile:s.
Not used.

AffymetrixCelSet

Fields and Methods

Methods:

21

-

as
as.AffymetrixCelSet Coerce an object to an AffymetrixCelSet object.
byName
doCRMAv1
doCRMAv2
doFIRMA
doGCRMA
doRMA
extractAffyBatch
extractFeatureSet
extractMatrix
getAverage
getAverageAsinh
getAverageFile
getAverageLog
getCdf
getChipType
getData
getIntensities
getPlatform
getTimestamps
getUnitGroupCellMap
getUnitIntensities
getUnitNamesFile
getUnitTypesFile
justSNPRMA
plotDensity
readUnits
setCdf
writeSgr

-
-
-
-
-
-
Extracts an in-memory AffyBatch object from the CEL set.
Extracts CEL signals an in-memory FeatureSet object.
Extract data as a matrix for a set of arrays.
-
-
Calculates the mean and the standard deviation of the cell signal (intensity, standard deviation etc.) across the CEL set.
-
Gets the CDF structure for this CEL set.
Gets the chip type for this CEL set.
-
Gets cell intensities from a set of cells and a set of arrays.
-
-
-
Gets cell signals for a subset of units and a subset of arrays.
-
-
-
Plots the densities of all samples.
-
Sets the CDF structure for this CEL set.
-

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-

22

AffymetrixCelSet

TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

AffymetrixCelFile.

Examples

## Not run:

for (zzz in 0) {

# Find any dataset
path <- NULL
if (is.null(path))

break

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define a dataset object based on all CEL files in a directory
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ds <- AffymetrixCelSet$fromFiles(path)
print(ds)

# Keep at most three arrays for this example
ds <- ds[1:min(3,nbrOfArrays(ds))]
print(ds)

AffymetrixCelSetReporter

23

} # for (zzz in 0)
rm(zzz)

## End(Not run)

AffymetrixCelSetReporter

The AffymetrixCelSetReporter class

Description

Package: aroma.affymetrix
Class AffymetrixCelSetReporter

Object
~~|
~~+--GenericReporter
~~~~~~~|
~~~~~~~+--AffymetrixFileSetReporter
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AffymetrixCelSetReporter

Directly known subclasses:
SpatialReporter

public abstract static class AffymetrixCelSetReporter
extends AffymetrixFileSetReporter

Usage

AffymetrixCelSetReporter(..., .setClass="AffymetrixCelSet")

Arguments

...

.setClass

Fields and Methods

Methods:

Arguments passed to AffymetrixFileSetReporter.

The name of the class of the input set.

getDataSet Gets the data set.

24

AffymetrixCelSetTuple

Methods inherited from AffymetrixFileSetReporter:
getFileSet, getInputName, getInputTags

Methods inherited from GenericReporter:
as.character, getAlias, getAsteriskTags, getFullName, getInputName, getInputTags, getMainPath,
getName, getPath, getReportSet, getRootPath, getTags, process, setAlias, setup

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffymetrixCelSetTuple The AffymetrixCelSetTuple class

Description

Package: aroma.affymetrix
Class AffymetrixCelSetTuple

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSetList
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSetTuple
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AffymetrixCelSetTuple

Directly known subclasses:
ChipEffectSetTuple, CnChipEffectSetTuple

public static class AffymetrixCelSetTuple
extends AromaMicroarrayDataSetTuple

Usage

AffymetrixCelSetTuple(..., .setClass="AffymetrixCelSet")

Arguments

...
.setClass

Arguments passed to the constructor of AromaMicroarrayDataSetTuple.
The name of the class of the input set.

AffymetrixCnChpSet

Fields and Methods

Methods:

byPath

-

25

Methods inherited from AromaMicroarrayDataSetTuple:
as, as.AromaMicroarrayDataSetTuple, byPath, getAsteriskTags, getChipTypes, getFullNames, get-
Sets, getTags, indexOf, nbrOfChipTypes

Methods inherited from GenericDataFileSetList:
as, as.GenericDataFileSetList, as.character, as.data.frame, as.list, assertDuplicates, clone, extract,
getAsteriskTags, getDefaultFullName, getFileList, getFileListClass, getFullNames, getNames, get-
Set, getSets, getTags, indexOf, length, nbrOfFiles, nbrOfSets, setTags

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffymetrixCnChpSet

The AffymetrixCnChpSet class

Description

Package: aroma.affymetrix
Class AffymetrixCnChpSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|

26

AffymetrixCnChpSet

~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCnChpSet

Directly known subclasses:

public abstract static class AffymetrixCnChpSet
extends AffymetrixFileSet

A AffymetrixCnChpSet object represents a set of AffymetrixCnChpFile:s with identical chip types.

Usage

AffymetrixCnChpSet(files=NULL, ...)

Arguments

files
...

Fields and Methods

Methods:

A list of AffymetrixCnChpFile:s.
Not used.

-

as
as.AffymetrixCnChpSet Coerce an object to an AffymetrixCnChpSet object.
exportTotalCnRatioSet
extractLogRatios
findByName
getCdf
setCdf

-
-
-
-
-

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

AffymetrixFile

27

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

AffymetrixCnChpFile.

AffymetrixFile

The abstract AffymetrixFile class

Description

Package: aroma.affymetrix
Class AffymetrixFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|

28

AffymetrixFile

~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile

Directly known subclasses:
AffymetrixCdfFile, AffymetrixCelFile, AffymetrixCnChpFile, AffymetrixPgfFile, AffymetrixTsvFile,
AromaChipTypeAnnotationFile, ChipEffectFile, CnChipEffectFile, CnProbeAffinityFile, CnagCfh-
File, DChipCdfBinFile, DChipDcpFile, ExonChipEffectFile, ExonProbeAffinityFile, FirmaFile, Pa-
rameterCelFile, ProbeAffinityFile, QualityAssessmentFile, ResidualFile, SnpChipEffectFile, SnpProbeAffin-
ityFile, WeightsFile

public abstract static class AffymetrixFile
extends AromaPlatformInterface

An AffymetrixFile object represents a single Affymetrix file, e.g. an Affymetrix CEL file or an
Affymetrix CDF file. Note that this class is abstract and can not be instanciated, but instead you
have to use one of the subclasses or the generic fromFile() method.

Usage

AffymetrixFile(...)

Arguments

...

Arguments passed to GenericDataFile.

Fields and Methods

Methods:
No methods defined.

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

AffymetrixFileSet

29

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically part of an AffymetrixFileSet.

AffymetrixFileSet

The AffymetrixFileSet class

Description

Package: aroma.affymetrix
Class AffymetrixFileSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface

30

AffymetrixFileSet

~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet

Directly known subclasses:
AffymetrixCelSet, AffymetrixCnChpSet, ChipEffectSet, CnChipEffectSet, DChipDcpSet, ExonChip-
EffectSet, FirmaSet, ParameterCelSet, QualityAssessmentSet, ResidualSet, SnpChipEffectSet, Weights-
Set

public abstract static class AffymetrixFileSet
extends AromaPlatformInterface

An AffymetrixFileSet object represents a set of AffymetrixFiles with identical chip types.

Usage

AffymetrixFileSet(files=NULL, ...)

Arguments

files

...

Fields and Methods

Methods:

A list of AffymetrixFile:s.
Arguments passed to GenericDataFileSet.

as
as.AffymetrixFileSet Coerce an object to an AffymetrixFileSet object.
byPath

-

Defines an AffymetrixFileSet object by searching for Affymetrix files.

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,

AffymetrixFileSetReporter

31

getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffymetrixFileSetReporter

The AffymetrixFileSetReporter class

Description

Package: aroma.affymetrix
Class AffymetrixFileSetReporter

Object
~~|
~~+--GenericReporter
~~~~~~~|
~~~~~~~+--AffymetrixFileSetReporter

Directly known subclasses:
AffymetrixCelSetReporter, SpatialReporter

public abstract static class AffymetrixFileSetReporter
extends GenericReporter

Usage

AffymetrixFileSetReporter(set=NULL, ..., .setClass="AffymetrixFileSet")

AffymetrixPgfFile

32

Arguments

set

...

.setClass

An AffymetrixFileSet object.
Arguments passed to GenericReporter.
The name of the class of the input set.

Fields and Methods

Methods:

getInputName
getInputTags

-
-

Methods inherited from GenericReporter:
as.character, getAlias, getAsteriskTags, getFullName, getInputName, getInputTags, getMainPath,
getName, getPath, getReportSet, getRootPath, getTags, process, setAlias, setup

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AffymetrixPgfFile

The AffymetrixPgfFile class

Description

Package: aroma.affymetrix
Class AffymetrixPgfFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile

AffymetrixPgfFile

33

~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaChipTypeAnnotationFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitAnnotationDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitTypesFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitNamesFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixPgfFile

Directly known subclasses:

public abstract static class AffymetrixPgfFile
extends UnitNamesFile

An AffymetrixPgfFile object represents a generic Affymetrix Probe Group File (PGF). A PGF file
"provides information about what probes are contained within a probeset and information about the
nature of the probes necessary for analysis. The current PGF file format (version 1) is only specified
for expression style probesets." [1]

Usage

AffymetrixPgfFile(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to AromaChipTypeAnnotationFile.

-
-
-

getChipType
getDimension
getPlatform
getUnitNames Gets the names of each unit.
nbrOfCells
nbrOfColumns
nbrOfRows
nbrOfUnits

-
-
-
-

34

AffymetrixPgfFile

Methods inherited from UnitNamesFile:
getUnitNames, indexOf, nbrOfUnits

Methods inherited from UnitTypesFile:
getUnitTypes, nbrOfUnits

Methods inherited from UnitAnnotationDataFile:
byChipType, getAromaUflFile, getAromaUgpFile, getChipType, getDefaultExtension, getPlatform,
nbrOfUnits

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaChipTypeAnnotationFile:
as.character, byChipType, byName, findByChipType, fromFile, getChipType, getDefaultExtension,
getHeader, getPlatform

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AlleleSummation

References

[1] ...

35

AlleleSummation

The AlleleSummation class

Description

Package: aroma.affymetrix
Class AlleleSummation

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AlleleSummation

Directly known subclasses:

public abstract static class AlleleSummation
extends UnitModel

This class takes allele-specific chip effect estimates of a SnpChipEffectSet and returns a CnChipEf-
fectSet holding the summed allele estimates.

Usage

AlleleSummation(dataSet=NULL, ignoreNAs=TRUE, ...)

Arguments

dataSet

ignoreNAs

...

A SnpChipEffectSet.
If TRUE, missing values are excluded when summing the signals from the two
alleles.
Arguments passed to UnitModel.

36

Fields and Methods

Methods:

AllelicCrosstalkCalibration

findUnitsTodo
getChipEffectSet Gets the set of chip effects for this model.
process

-

-

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AllelicCrosstalkCalibration

The AllelicCrosstalkCalibration class

Description

Package: aroma.affymetrix
Class AllelicCrosstalkCalibration

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|

AllelicCrosstalkCalibration

37

~~~~~~~~~~~~~~~~~~~~~~+--AllelicCrosstalkCalibration

Directly known subclasses:

public static class AllelicCrosstalkCalibration
extends ProbeLevelTransform

This class represents a calibration function that transforms the probe-level signals such that the
signals from the two alleles are orthogonal. The method fits and calibrates PM signals only. MM
signals will not affect the model fitting and are unaffected.

Usage

AllelicCrosstalkCalibration(dataSet=NULL, ..., model=c("asis", "auto", "CRMA", "CRMAv2"),

rescaleBy=c("auto", "groups", "all", "none"), targetAvg=c(2200, 2200),
subsetToAvg="-XY", mergeShifts=TRUE, B=1, flavor=c("sfit", "expectile"),
alpha=c(0.1, 0.075, 0.05, 0.03, 0.01), q=2, Q=98, lambda=2,
pairBy=c("CDF", "sequence"))

Arguments

dataSet

...

model

rescaleBy

targetAvg

subsetToAvg

mergeShifts

B

flavor

An AffymetrixCelSet.
Arguments passed to the constructor of ProbeLevelTransform.
A character string for quickly specifying default parameter settings.
A character string specifying what sets of cells should be rescaled towards
a target average, if any. Default is to rescale all cells together. If "none", no
rescaling is done.

The signal(s) that either the average of the sum (if one target value) or the av-
erage of each of the alleles (if two target values) should have after calibration.
Only used if rescaleBy != "none".

The indices of the cells (taken as the intersect of existing indices) used to cal-
culate average in order to rescale to the target average. If NULL, all probes are
considered.
If TRUE, the shift of the probe sequence relative to the SNP position is ignored,
otherwise not.
An integer specifying by how many nucleotides the allelic groups should be
stratified by. If zero, all SNPs are put in one group.
A character string specifying what algorithm is used to fit the crosstalk cali-
bration.

alpha, q, Q, lambda

pairBy

Model fitting parameters.
A character string specifying how allele probe pairs are identified.

38

AllelicCrosstalkCalibration

What probe signals are updated?

Calibration for crosstalk between allele signals applies by definition only SNP units. Furthermore,
it is only SNP units with two or four unit groups that are calibrated. For instance, in at least
on custom SNP CDFs we know of, there is a small number of SNP units that have six groups.
Currently these units are not calibrated (at all). It is only PM probes that will be calibrated. Note
that, non-calibrated signals will be saved in the output files.

What probe signals are used to fit model?

All PM probe pairs are used to fit the crosstalk model. In the second step where signals are rescaled
to a target average, it is possible to specify the set of cells that should be included when estimating
the target average.

Important about rescaling towards target average

Rescaling each allele-pair group (e.g. AC, AG, AT, CG, CT, GC) towards a target average (rescaleBy="groups")
must not be used for multi-enzyme chip types, e.g. GenomeWideSNP_6. If still done, due to con-
founded effects of non-perfect enzyme mixtures etc, there will be a significant bias between raw
CNs for SNPs and CN probes. Instead, for such chip types all probe signals should be rescale
together towards the target average (rescaleBy="all").

Fields and Methods

Methods:

process Calibrates the data set.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AromaChipTypeAnnotationFile

39

AromaChipTypeAnnotationFile

The AromaChipTypeAnnotationFile class

Description

Package: aroma.affymetrix
Class AromaChipTypeAnnotationFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaChipTypeAnnotationFile

Directly known subclasses:
AffymetrixCdfFile, AffymetrixPgfFile

public abstract static class AromaChipTypeAnnotationFile
extends AffymetrixFile

An AromaChipTypeAnnotationFile object represents an annotation file for a specific chip type.

Usage

AromaChipTypeAnnotationFile(...)

Arguments

...

Arguments passed to AffymetrixFile.

40

Fields and Methods

Methods:

AromaChipTypeAnnotationFile

byChipType
getChipType
getHeader
getPlatform

Defines an AromaChipTypeAnnotationFile object by chip type.
-
Gets the header of the annotation file.
-

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

ArrayExplorer

41

ArrayExplorer

The ArrayExplorer class

Description

Package: aroma.affymetrix
Class ArrayExplorer

Object
~~|
~~+--Explorer
~~~~~~~|
~~~~~~~+--ArrayExplorer

Directly known subclasses:

public abstract static class ArrayExplorer
extends Explorer

Usage

ArrayExplorer(csTuple=NULL, ...)

An AffymetrixCelSet object.

Not used.

Arguments

csTuple

...

Fields and Methods

Methods:

addColorMap
getColorMaps
getDataSet
getSetTuple
nbrOfChipTypes
process
setArrays
setColorMaps

-
-
Gets the data set.
-
-
Generates image files, scripts and dynamic pages for the explorer.
Sets the arrays.
-

42

AvgCnPlm

Methods inherited from Explorer:
addIncludes, addIndexFile, as.character, display, getAlias, getArraysOfInput, getAsteriskTags, get-
FullName, getIncludePath, getMainPath, getName, getNameOfInput, getNames, getPath, getRe-
portPathPattern, getRootPath, getSampleLayerPrefix, getSubname, getTags, getTagsOfInput, get-
TemplatePath, getVersion, nbrOfArrays, process, setAlias, setArrays, setReportPathPattern, set-
Subname, setup, splitByReportPathPattern, updateSetupExplorerFile

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

AvgCnPlm

The AvgCnPlm class

Description

Package: aroma.affymetrix
Class AvgCnPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AvgPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AvgSnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AvgCnPlm

43

AvgCnPlm

Directly known subclasses:

public abstract static class AvgCnPlm
extends CnPlm

Usage

AvgCnPlm(..., combineAlleles=FALSE)

Arguments

...
combineAlleles If FALSE, allele A and allele B are treated separately, otherwise together.

Arguments passed to AvgSnpPlm.

Fields and Methods

Methods:
No methods defined.

Methods inherited from CnPlm:
getCellIndices, getChipEffectSet, getCombineAlleles, getParameters, getProbeAffinityFile, setCom-
bineAlleles

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from AvgSnpPlm:
getAsteriskTags

Methods inherited from AvgPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, validate

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

AvgPlm

44

Author(s)

Henrik Bengtsson

AvgPlm

The AvgPlm class

Description

Package: aroma.affymetrix
Class AvgPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AvgPlm

Directly known subclasses:
AvgCnPlm, AvgSnpPlm

public abstract static class AvgPlm
extends ProbeLevelModel

This class represents a PLM where the probe intensities are averaged assuming identical probe
affinities. For instance, one may assume that replicated probes with identical sequences have the
same probe affinities, cf. the GenomeWideSNP_6 chip type.

Usage

AvgPlm(..., flavor=c("median", "mean"))

Arguments

...

flavor

Arguments passed to ProbeLevelModel.
A character string specifying what model fitting algorithm to be used. This
makes it possible to get identical estimates as other packages.

AvgPlm

Fields and Methods

Methods:
No methods defined.

45

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Model

For a single unit group, the averaging PLM of K probes is:

yik = θi + εik

where θi are the chip effects for arrays i = 1, ..., I. The εik are zero-mean noise with equal variance.

Different flavors of model fitting

The above model can be fitted in two ways, either robustly or non-robustly. Use argument flavor="mean"
to fit the model non-robustly, i.e.

ˆθi = 1/K

(cid:88)

yik

.
Use argument flavor="median" to fit the model robustly, i.e.

k

ˆθi = mediankyik

.

Missing values are always excluded.

Author(s)

Henrik Bengtsson

46

AvgSnpPlm

AvgSnpPlm

The AvgSnpPlm class

Description

Package: aroma.affymetrix
Class AvgSnpPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AvgPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AvgSnpPlm

Directly known subclasses:
AvgCnPlm

public abstract static class AvgSnpPlm
extends SnpPlm

Usage

AvgSnpPlm(..., mergeStrands=FALSE)

Arguments

...

Arguments passed to AvgPlm.

mergeStrands

If TRUE, the sense and the anti-sense strands are fitted together, otherwise sepa-
rately.

BackgroundCorrection

Fields and Methods

Methods:
No methods defined.

47

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from AvgPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, validate

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

BackgroundCorrection

The BackgroundCorrection class

Description

Package: aroma.affymetrix
Class BackgroundCorrection

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|

48

BackgroundCorrection

~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--BackgroundCorrection

Directly known subclasses:
GcRmaBackgroundCorrection, LimmaBackgroundCorrection, NormExpBackgroundCorrection, Op-
ticalBackgroundCorrection, RmaBackgroundCorrection

public abstract static class BackgroundCorrection
extends ProbeLevelTransform

This class represents a background adjustment function.

Usage

BackgroundCorrection(..., subsetToUpdate=NULL, typesToUpdate=NULL)

Arguments

Arguments passed to the constructor of ProbeLevelTransform.

...
subsetToUpdate The probes to be updated. If NULL, all probes are updated.
typesToUpdate

Types of probes to be updated.

Fields and Methods

Methods:

process

Processes the data set.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

49

BaseCountNormalization

Author(s)

Ken Simpson, Henrik Bengtsson

BaseCountNormalization

The BaseCountNormalization class

Description

Package: aroma.affymetrix
Class BaseCountNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AbstractProbeSequenceNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--BaseCountNormalization

Directly known subclasses:

public static class BaseCountNormalization
extends AbstractProbeSequenceNormalization

This class represents a normalization method that corrects for systematic effects in the probe inten-
sities due to differences in the number of A, C, G, and T:s in the probe sequences.

Usage

BaseCountNormalization(..., model=c("robustSmoothSpline", "lm"), bootstrap=FALSE)

Arguments

...
model
bootstrap

Arguments passed to the constructor of AbstractProbeSequenceNormalization.
A character string specifying the model used to fit the base-count effects.
If TRUE, the model fitting is done by bootstrap in order to save memory.

50

Fields and Methods

Methods:
No methods defined.

BasePositionNormalization

Methods inherited from AbstractProbeSequenceNormalization:
fitOne, getAromaCellSequenceFile, getParameters, getTargetFile, indexOfMissingSequences, pre-
dictOne, process

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires that an aroma probe sequence file is available for the chip type.

Author(s)

Henrik Bengtsson

BasePositionNormalization

The BasePositionNormalization class

Description

Package: aroma.affymetrix
Class BasePositionNormalization

Object
~~|
~~+--ParametersInterface

BasePositionNormalization

51

~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AbstractProbeSequenceNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--LinearModelProbeSequenceNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--BasePositionNormalization

Directly known subclasses:

public abstract static class BasePositionNormalization
extends LinearModelProbeSequenceNormalization

This class represents a normalization method that corrects for systematic effects in the probe inten-
sities due to differences in positioning of A, C, G, and T:s in the probe sequences.

Usage

BasePositionNormalization(..., model=c("smooth.spline"), df=5)

Arguments

...

model

df

Arguments passed to the constructor of LinearModelProbeSequenceNormalization.
A character string specifying the model used to fit the base-count effects.

The degrees of freedom of the model.

Fields and Methods

Methods:
No methods defined.

Methods inherited from LinearModelProbeSequenceNormalization:
fitOne, getDesignMatrix, getNormalEquations, getSignalTransform, predictOne

Methods inherited from AbstractProbeSequenceNormalization:
fitOne, getAromaCellSequenceFile, getParameters, getTargetFile, indexOfMissingSequences, pre-
dictOne, process

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

52

ChipEffectFile

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson, Mark Robinson

ChipEffectFile

The ChipEffectFile class

Description

Package: aroma.affymetrix
Class ChipEffectFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|

ChipEffectFile

53

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectFile

Directly known subclasses:
CnChipEffectFile, ExonChipEffectFile, SnpChipEffectFile

public abstract static class ChipEffectFile
extends ParameterCelFile

This class represents estimates of chip effects in the probe-level models.

Usage

ChipEffectFile(..., probeModel=c("pm"))

Arguments

...

probeModel

Arguments passed to ParameterCelFile.
The specific type of model, e.g. "pm".

Fields and Methods

Methods:

extractMatrix
extractTheta
findUnitsTodo
getAM
readUnits

-
-
-
Gets the log-intensities and log-ratios of chip effects for two arrays.
-

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

54

ChipEffectSet

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically obtained through the getChipEffectSet() method for the
ProbeLevelModel class. An object of this class is typically part of a ChipEffectSet.

ChipEffectSet

The ChipEffectSet class

Description

Package: aroma.affymetrix
Class ChipEffectSet

ChipEffectSet

55

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectSet

Directly known subclasses:
CnChipEffectSet, ExonChipEffectSet, SnpChipEffectSet

public static class ChipEffectSet
extends ParameterCelSet

This class represents estimates of chip effects in the probe-level models.

Usage

ChipEffectSet(..., probeModel=c("pm"))

Arguments

...

probeModel

Fields and Methods

Methods:

Arguments passed to AffymetrixCelSet.
The specific type of model, e.g. "pm".

-

boxplotStats
extractExpressionSet Extracts an in-memory ExpressionSet object.
extractMatrix
extractTheta
findUnitsTodo
getAM

-
-
-
Gets the log-intensities and log-ratios of chip effects of the set relative to a reference chip effect file.

56

ChipEffectSet

getAverageFile
getCellIndices
plotBoxplot
readUnits

-
-
-
-

Methods inherited from ParameterCelSet:
extractDataFrame, extractMatrix

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

ChipEffectTransform

57

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically obtained through the getChipEffectSet() method for the
ProbeLevelModel class.

ChipEffectTransform

The ChipEffectTransform class

Description

Package: aroma.affymetrix
Class ChipEffectTransform

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ChipEffectTransform

Directly known subclasses:
AdditiveCovariatesNormalization, ChipEffectGroupMerge, FragmentEquivalentClassNormalization,
FragmentLengthNormalization, GcContentNormalization, GcContentNormalization2, SnpChipEf-
fectGroupMerge

public abstract static class ChipEffectTransform
extends Transform

This abstract class represents a transform that transforms chip-effect estimates obtained from probe-
level modeling.

Usage

ChipEffectTransform(dataSet=NULL, ...)

58

Arguments

dataSet

...

Details

CnagCfhFile

The input data set as an ChipEffectSet.
Arguments passed to the constructor of Transform.

Subclasses must implement the process() method.

Fields and Methods

Methods:
No methods defined.

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

CnagCfhFile

The CnagCfhFile class

Description

Package: aroma.affymetrix
Class CnagCfhFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|

CnagCfhFile

59

~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnagCfhFile

Directly known subclasses:

public abstract static class CnagCfhFile
extends AffymetrixFile

A CnagCfhFile object represents a single CNAG CFH file.

Usage

CnagCfhFile(..., cdf=NULL)

Arguments

...

cdf

Fields and Methods

Methods:

Arguments passed to AromaMicroarrayDataFile.
An optional AffymetrixCdfFile

getCdf
nbrOfCells
nbrOfSnps
setCdf

Gets the CDF structure for this CEL file.
-
-
Sets the CDF structure for this CEL file.

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

60

CnagCfhSet

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically part of an CnagCfhSet.

CnagCfhSet

The CnagCfhSet class

Description

Package: aroma.affymetrix
Class CnagCfhSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|

CnagCfhSet

61

~~~~~~~~~~~~+--CnagCfhSet

Directly known subclasses:

public static class CnagCfhSet
extends GenericDataFileSet

An CnagCfhSet object represents a set of CNAG CFH files with identical chip types.

Usage

CnagCfhSet(files=NULL, ...)

Arguments

files
...

Fields and Methods

Methods:

A list of CnagCfhFile:s.
Not used.

as
as.CnagCfhSet
byName
getAverage
getAverageAsinh
getAverageFile
getAverageLog
getCdf
getData
getTimestamps
readUnits
setCdf

-
Coerce an object to an CnagCfhSet object.
-
-
-
Calculates the mean and the standard deviation of the cell signal (intensity, standard deviation etc.) across the CFH set.
-
Gets the CDF structure for this CFH set.
-
-
-
Sets the CDF structure for this CFH set.

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

62

CnChipEffectFile

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

CnagCfhFile.

CnChipEffectFile

The CnChipEffectFile class

Description

Package: aroma.affymetrix
Class CnChipEffectFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile

CnChipEffectFile

63

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpChipEffectFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CopyNumberDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnChipEffectFile

Directly known subclasses:

public abstract static class CnChipEffectFile
extends CopyNumberDataFile

This class represents estimates of chip effects in a copy-number probe-level models.

Usage

CnChipEffectFile(..., combineAlleles=FALSE)

Arguments

...

Arguments passed to SnpChipEffectFile.

combineAlleles A logical indicating if the signals from allele A and allele B are combined or

not.

Fields and Methods

Methods:

exportTotalAndFracB
extractTheta
extractTotalAndFreqB
hasAlleleBFractions
hasStrandiness
mergeStrands
readUnits

-
-
-
-
-
-
-

Methods inherited from CopyNumberDataFile:
as, as.CopyNumberDataFile, getNumberOfFilesAveraged, hasAlleleBFractions, hasStrandiness

64

CnChipEffectFile

Methods inherited from SnpChipEffectFile:
exportTotalAndFracB, extractCNT, extractTheta, extractTotalAndFracB, getCellIndices, getExpand-
edCellMap, getParameters, mergeStrands, readUnits, writeCNT

Methods inherited from ChipEffectFile:
as.character, extractChromosomalDataFrame, extractMatrix, extractTheta, findUnitsTodo, getAM,
getAsFullCelFile, getCellIndices, getCellMapForMainCdf, getExpandedCellMap, getParameters,
getUnitGroupCellArrayMap, getUnitGroupCellMatrixMap, getXAM, mergeGroups, readUnits, writeAs-
FullCelFile

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,

CnChipEffectSet

65

equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically part of a CnChipEffectSet.

CnChipEffectSet

The CnChipEffectSet class

Description

Package: aroma.affymetrix
Class CnChipEffectSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpChipEffectSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CopyNumberDataSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnChipEffectSet

66

CnChipEffectSet

Directly known subclasses:

public static class CnChipEffectSet
extends CopyNumberDataSet

This class represents estimates of chip effects in the probe-level models.

Usage

CnChipEffectSet(..., combineAlleles="byFirstFile")

Arguments

...

Arguments passed to SnpChipEffectSet.

combineAlleles A logical indicating if the signals from allele A and allele B are combined or

not.

Fields and Methods

Methods:

as.CopyNumberDataSetTuple
exportTotalAndFracB
extractTheta
extractTotalAndFreqB
getAverageFile
getCombineAlleles
hasAlleleBFractions
hasStrandiness
setCombineAlleles
writeWig

-
-
-
-
-
-
-
-
-
-

Methods inherited from CopyNumberDataSet:
as, as.CopyNumberDataSet, doCBS, hasAlleleBFractions, hasStrandiness

Methods inherited from SnpChipEffectSet:
byPath, exportTotalAndFracB, extractAlleleSet, extractCNT, extractSnpCnvQSet, extractSnpQSet,
extractTheta, extractTotalAndFreqB, getAverageFile, getBaseline, getMergeStrands, setMergeS-
trands, writeCNT

Methods inherited from ChipEffectSet:
as.character, boxplotStats, byPath, calculateBaseline, calculateFieldBoxplotStats, calculateNuse-
BoxplotStats, calculateRleBoxplotStats, extractAffyBatch, extractChromosomalDataFrame, extract-
ExpressionSet, extractMatrix, extractTheta, findByName, findUnitsTodo, fromDataSet, getAM,
getAsFullCelSet, getAverageFile, getBaseline, getCellIndices, getXAM, plotBoxplot, readUnits,
updateUnits

CnChipEffectSet

67

Methods inherited from ParameterCelSet:
extractDataFrame, extractMatrix

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

CnPlm

68

Author(s)

Henrik Bengtsson

CnPlm

The CnPlm class

Description

Package: aroma.affymetrix
Class CnPlm

Interface
~~|
~~+--SnpPlm
~~~~~~~|
~~~~~~~+--CnPlm

Directly known subclasses:
AffineCnPlm, AvgCnPlm, HetLogAddCnPlm, MbeiCnPlm, RmaCnPlm

public class CnPlm
extends SnpPlm

This support class represents a SnpPlm specially designed for copy-number analysis.

Usage

CnPlm(...)

Arguments

...

Details

Arguments passed to SnpPlm.

Models implementing this copy-number PLM, provides either allele-specific or total copy-number
estimates. For allele-specific CNs the underlying SnpPlm model is fitted as is, i.e. for each allele
separately with or without the strands first being merged.

For total CNs the probe signals for the two alleles are combined (=summed; not averaged) on the
intensity scale before fitting underlying SnpPlm model, again with or without the strands first being
merged.

CnProbeAffinityFile

Methods

Methods:

69

getCellIndices
getChipEffectSet
getCombineAlleles
getProbeAffinityFile
setCombineAlleles

-
-
-
-
-

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from Interface:
extend, print, uses

Requirements

Classes inheriting from this Interface must provide the following fields, in addition to the ones
according to SnpPlm:

combineAlleles A logical indicating if total or allele-specific copy numbers should be estimated

according to the above averaging.

Author(s)

Henrik Bengtsson

CnProbeAffinityFile

The CnProbeAffinityFile class

Description

Package: aroma.affymetrix
Class CnProbeAffinityFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface

70

CnProbeAffinityFile

~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ProbeAffinityFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpProbeAffinityFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnProbeAffinityFile

Directly known subclasses:

public abstract static class CnProbeAffinityFile
extends SnpProbeAffinityFile

This class represents estimates of probe affinities in SNP probe-level models.

Usage

CnProbeAffinityFile(..., combineAlleles=FALSE)

Arguments

...

Arguments passed to SnpProbeAffinityFile.

combineAlleles If FALSE, allele A and allele B are treated separately, otherwise together.

Fields and Methods

Methods:
No methods defined.

Methods inherited from SnpProbeAffinityFile:
getCellIndices, setMergeStrands

Methods inherited from ProbeAffinityFile:
as.character, getCellIndices, getParameters, readUnits

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

CnProbeAffinityFile

71

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

72

CrlmmParametersFile

CrlmmParametersFile

The CrlmmParametersFile class

Description

Package: aroma.affymetrix
Class CrlmmParametersFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--ColumnNamesInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--GenericTabularFile
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaTabularBinaryFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaUnitSignalBinaryFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CrlmmParametersFile

Directly known subclasses:

public static class CrlmmParametersFile
extends AromaUnitSignalBinaryFile

An CrlmmParametersFile is a AromaUnitSignalBinaryFile.

Usage

CrlmmParametersFile(...)

Arguments

...

Arguments passed to AromaUnitSignalBinaryFile.

CrlmmParametersFile

Fields and Methods

Methods:

73

allocate
findUnitsTodo
readParameter
updateParameter

-
-
-
-

Methods inherited from AromaUnitSignalBinaryFile:
allocate, allocateFromUnitAnnotationDataFile, allocateFromUnitNamesFile, as.character, extract-
Matrix, extractRawGenomicSignals, fromFile, getChipType, getExtensionPattern, getFilenameEx-
tension, getNumberOfFilesAveraged, getPlatform, isAverageFile, nbrOfUnits, readDataFrame, write-
DataFrame

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaTabularBinaryFile:
[, [<-, [[, allocate, as.character, colApply, colMeans, colStats, colSums, dimnames<-, getBytes-
PerColumn, getColClasses, getDefaultColumnNames, getRootName, importFrom, nbrOfColumns,
nbrOfRows, readColumns, readDataFrame, readFooter, readHeader, readRawFooter, setAttributes-
ByTags, subset, summary, updateData, updateDataColumn, writeFooter, writeRawFooter

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericTabularFile:
[, as.character, dim, extractMatrix, head, nbrOfColumns, nbrOfRows, readColumns, readDataFrame,
tail, writeColumnsToFiles

Methods inherited from ColumnNamesInterface:
appendColumnNamesTranslator, appendColumnNamesTranslatorByNULL, appendColumnNames-
TranslatorBycharacter, appendColumnNamesTranslatorByfunction, appendColumnNamesTransla-
torBylist, clearColumnNamesTranslator, clearListOfColumnNamesTranslators, getColumnNames,
getColumnNamesTranslator, getDefaultColumnNames, getListOfColumnNamesTranslators, nbrOf-
Columns, setColumnNames, setColumnNamesTranslator, setListOfColumnNamesTranslators, up-
dateColumnNames

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

74

CrlmmParametersSet

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

CrlmmParametersSet

The CrlmmParametersSet class

Description

Package: aroma.affymetrix
Class CrlmmParametersSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--GenericTabularFileSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaTabularBinarySet
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaUnitSignalBinarySet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CrlmmParametersSet

Directly known subclasses:

public static class CrlmmParametersSet
extends AromaUnitSignalBinarySet

An CrlmmParametersSet object represents a set of CrlmmParametersFiles with identical chip
types.

75

CrlmmParametersSet

Usage

CrlmmParametersSet(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to AromaUnitSignalBinarySet.

byName
byPath
findUnitsTodo

-
-
-

Methods inherited from AromaUnitSignalBinarySet:
byName, findByName, getAromaFullNameTranslatorSet, getAromaUgpFile, getChipType, getPlat-
form, validate, writeDataFrame
Methods inherited from AromaTabularBinarySet:
getDefaultFullName, getRootName, setAttributesBy, setAttributesBySampleAnnotationFile, setAt-
tributesBySampleAnnotationSet, setAttributesByTags
Methods inherited from GenericTabularFileSet:
extractMatrix, calculateAverageColumnAcrossFiles
Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName
Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName
Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

DChipCdfBinFile

76

Author(s)

Henrik Bengtsson

DChipCdfBinFile

The DChipCdfBinFile class

Description

Package: aroma.affymetrix
Class DChipCdfBinFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitAnnotationDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitNamesFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--DChipCdfBinFile

Directly known subclasses:

public abstract static class DChipCdfBinFile
extends UnitNamesFile

A DChipCdfBinFile object represents a DChip CDF.bin file.

Usage

DChipCdfBinFile(...)

DChipCdfBinFile

Arguments

...

Fields and Methods

Methods:

Arguments passed to AffymetrixFile.

77

byChipType
getChipType
getFileFormat
getHeader
getPlatform
getUnitNames
getUnitSizes
nbrOfCells
nbrOfUnits
readDataFrame

-
-
-
-
-
-
-
-
-
-

Methods inherited from UnitNamesFile:
getUnitNames, indexOf, nbrOfUnits

Methods inherited from UnitAnnotationDataFile:
byChipType, getAromaUflFile, getAromaUgpFile, getChipType, getDefaultExtension, getPlatform,
nbrOfUnits

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-

78

DChipDcpFile

acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

DChipDcpFile

The DChipDcpFile class

Description

Package: aroma.affymetrix
Class DChipDcpFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--DChipDcpFile

Directly known subclasses:

public abstract static class DChipDcpFile
extends AffymetrixFile

A DChipDcpFile object represents a DChip DCP file.

79

DChipDcpFile

Usage

DChipDcpFile(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to AffymetrixFile.

dim
extractTheta
getCalls
getExcludes
getFileFormat
getHeader
getNormalizedIntensities
getRawIntensities
getThetaStds
getThetas
getThetasAB
hasMbeiData
hasNormalizedData
nbrOfCells
nbrOfUnits

-
-
-
-
-
-
-
-
-
-
-
-
-
-
-

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

80

DChipDcpSet

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

DChipDcpSet.

DChipDcpSet

The DChipDcpSet class

Description

Package: aroma.affymetrix
Class DChipDcpSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--DChipDcpSet

Directly known subclasses:

DChipDcpSet

81

public abstract static class DChipDcpSet
extends AffymetrixFileSet

A DChipDcpSet object represents a set of DChip DCP files for identical chip types.

Usage

DChipDcpSet(files=NULL, ...)

Arguments

files

...

Fields and Methods

Methods:

A list of DChipDcpFile:s.
Not used.

as
as.DChipDcpSet
byName
exportTotalAndFracB
extractTheta
getCdfBin
getChipType

-
Coerce an object to an DChipDcpSet object.
-
-
-
-
-

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

82

DChipGenomeInformation

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

DChipDcpFile.

DChipGenomeInformation

The DChipGenomeInformation class

Description

Package: aroma.affymetrix
Class DChipGenomeInformation

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--GenomeInformation
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--DChipGenomeInformation

Directly known subclasses:

DChipGenomeInformation

83

public abstract static class DChipGenomeInformation
extends GenomeInformation

This class represents dChip genome information files, which typically contains information about
chromosomal locations of the units.

Usage

DChipGenomeInformation(...)

Arguments

...

Details

Arguments passed to GenomeInformation.

The dChip genome information files for various chip types can be downloaded from https://
sites.google.com/site/dchipsoft/. Put each file in a directory named identically as the corre-
sponding chip type under the annotations/ directory, e.g. annotations/Mapping50K_Hind240/50k
hind genome info AfAm june 05 hg17.xls. Note that dChip changes the filename and file format
slightly between chip types, but currently the *byChipType() basically searches for files with
names consisting of "genome info" or "genome_info". At least for the most common chip types,
there is no need to rename the files in order for this class to recognize them.

Fields and Methods

Methods:

byChipType
readDataFrame

Defines a DChipGenomeInformation object by chip type.
-

Methods inherited from GenomeInformation:
as.character, byChipType, fromCdf, fromDataSet, getChipType, getChromosomeStats, getChromo-
somes, getData, getPositions, getUnitIndices, getUnitsOnChromosome, getUnitsOnChromosomes,
isCompatibleWithCdf, nbrOfUnits, plotDensity, readDataFrame, verify

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,

84

DChipQuantileNormalization

setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

DChipQuantileNormalization

The DChipQuantileNormalization class

Description

Package: aroma.affymetrix
Class DChipQuantileNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--QuantileNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--DChipQuantileNormalization

Directly known subclasses:

DChipQuantileNormalization

85

public static class DChipQuantileNormalization
extends QuantileNormalization

This class represents a special QuantileNormalization using smooth-splines.

Usage

DChipQuantileNormalization(..., robust=FALSE)

Arguments

...

robust

Details

Arguments passed to the constructor of QuantileNormalization.
If TRUE, the normalization function is estimated robustly, otherwise not.

This normalization method implements the two-pass algorithm described in Bengtsson et al. (2008).

Fields and Methods

Methods:

process Normalizes the data set.

Methods inherited from QuantileNormalization:
findTargetDistributionFile, getParameters, process

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

86

References

DChipSnpInformation

[1] H. Bengtsson, R. Irizarry, B. Carvalho, & T.P. Speed. Estimation and assessment of raw copy
numbers at the single locus level, Bioinformatics, 2008.

DChipSnpInformation

The DChipSnpInformation class

Description

Package: aroma.affymetrix
Class DChipSnpInformation

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--SnpInformation
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--DChipSnpInformation

Directly known subclasses:

public abstract static class DChipSnpInformation
extends SnpInformation

This class represents dChip genome information files, which typically contains information on nu-
cleotide sequences and fragment lengths of the units.

Usage

DChipSnpInformation(...)

Arguments

...

Arguments passed to SnpInformation.

DChipSnpInformation

Details

87

The dChip SNP information files for various chip types can be downloaded from https://sites.
google.com/site/dchipsoft/. Put each file in a directory named identically as the corresponding
chip type under the annotations/ directory, e.g. annotations/Mapping50K_Hind240/50k hind snp
info AfAm june 05 hg17.xls. Note that dChip changes the filename and file format slightly between
chip types, but currently the *byChipType() basically searches for files with names consisting of
"snp info" or "snp_info". At least for the most common chip types, there is no need to rename
the files in order for this class to recognize them.

Fields and Methods

Methods:

byChipType
readDataFrame

Defines a DChipSnpInformation object by chip type.
-

Methods inherited from SnpInformation:
as.character, byChipType, fromCdf, fromDataSet, getChipType, getData, getFields, getFragmentLengths,
getFragmentStarts, getFragmentStops, isCompatibleWithCdf, nbrOfEnzymes, nbrOfUnits, read-
DataFrame, verify

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

doCRMAv1

Estimation and assessment of raw copy numbers at the single locus
level (CRMA v1)

88

Author(s)

Henrik Bengtsson

doCRMAv1

Description

Estimation and assessment of raw copy numbers at the single locus level (CRMA v1) based on [1].
The algorithm is processed in bounded memory, meaning virtually any number of arrays can be
analyzed on also very limited computer systems.

Usage

## S3 method for class 'AffymetrixCelSet'

doCRMAv1(csR, shift=+300, combineAlleles=TRUE, lengthRange=NULL, arrays=NULL, drop=TRUE,

verbose=FALSE, ...)
## Default S3 method:

doCRMAv1(dataSet, ..., verbose=FALSE)

## Default S3 method:

doASCRMAv1(...)

Arguments

csR, dataSet
shift

An AffymetrixCelSet (or the name of an AffymetrixCelSet).

An tuning parameter specifying how much to shift the probe signals before
probe summarization.

combineAlleles A logical specifying whether allele probe pairs should be summed before mod-

lengthRange

arrays

drop

verbose

...

eling or not.
An optional numeric vector of length two passed to FragmentLengthNormalization.
A integer vector specifying the subset of arrays to process. If NULL, all arrays
are considered.
If TRUE, the summaries are returned, otherwise a named list of all intermediate
and final results.
See Verbose.
Additional arguments used to set up AffymetrixCelSet (when argument dataSet
is specified).

Value

Returns a named list, iff drop == FALSE, otherwise only ChipEffectSet object.

doCRMAv2

89

Allele-specific or only total-SNP signals

If you wish to obtain allele-specific estimates for SNPs, which are needed to call genotypes or
infer parent-specific copy numbers, then use argument combineAlleles=FALSE. Total copy number
signals are still available. If you know for certain that you will not use allele-specific estimates, you
will get slightly less noisy signals (very small difference) if you use combineAlleles=TRUE.
doASCRMAv1(...) is a wrapper for doCRMAv1(..., combineAlleles=FALSE).

Author(s)

Henrik Bengtsson

References

[1] H. Bengtsson, R. Irizarry, B. Carvalho & T.P. Speed. Estimation and assessment of raw copy
numbers at the single locus level, Bioinformatics, 2008.

See Also

For CRMA v2 (recommended by authors), which is a single-array improvement over CRMA v1,
see doCRMAv2().

A single-array preprocessing method for estimating full-resolution
raw copy numbers from all Affymetrix genotyping arrays (CRMA v2)

doCRMAv2

Description

A single-array preprocessing method for estimating full-resolution raw copy numbers from all
Affymetrix genotyping arrays (CRMA v2) based on [1]. The algorithm is processed in bounded
memory, meaning virtually any number of arrays can be analyzed on also very limited computer
systems.

We recommend CRMA v2 for estimating allele-specific as well total SNP signals from Affymetrix
SNP chips.

Usage

## S3 method for class 'AffymetrixCelSet'

doCRMAv2(csR, combineAlleles=TRUE, lengthRange=NULL, arrays=NULL,
plm=c("AvgCnPlm", "RmaCnPlm"), drop=TRUE, verbose=FALSE, ...)
## Default S3 method:

doCRMAv2(dataSet, ..., verbose=FALSE)

## Default S3 method:

doASCRMAv2(...)

90

Arguments

doCRMAv2

csR, dataSet
combineAlleles A logical specifying whether allele probe pairs should be summed before mod-

An AffymetrixCelSet (or the name of an AffymetrixCelSet).

lengthRange

arrays

plm

drop

verbose

...

eling or not.
An optional numeric vector of length two passed to FragmentLengthNormalization.
A integer vector specifying the subset of arrays to process. If NULL, all arrays
are considered.
A character string specifying which type of probe-summarization model to
used.
If TRUE, the summaries are returned, otherwise a named list of all intermediate
and final results.
See Verbose.
Additional arguments used to set up AffymetrixCelSet (when argument dataSet
is specified).

Value

Returns a named list, iff drop == FALSE, otherwise only ChipEffectSet object.

Allele-specific or only total-SNP signals

If you wish to obtain allele-specific estimates for SNPs, which are needed to call genotypes or
infer parent-specific copy numbers, then use argument combineAlleles=FALSE. Total copy number
signals are still available. If you know for certain that you will not use allele-specific estimates, you
will get slightly less noisy signals (very small difference) if you use combineAlleles=TRUE.
doASCRMAv2(...) is a wrapper for doCRMAv2(..., combineAlleles=FALSE).

Author(s)

Henrik Bengtsson

References

[1] H. Bengtsson, P. Wirapati & T.P. Speed. A single-array preprocessing method for estimating
full-resolution raw copy numbers from all Affymetrix genotyping arrays including GenomeWideSNP
5 & 6, Bioinformatics, 2009.

See Also

For CRMA v1, which is a multi-array methods that precedes CRMA v2, see doCRMAv1().

doFIRMA

91

doFIRMA

Finding Isoforms using Robust Multichip Analysis (FIRMA)

Description

Finding Isoforms using Robust Multichip Analysis (FIRMA) based on [1].

Usage

## S3 method for class 'AffymetrixCelSet'

doFIRMA(csR, ..., flavor=c("v1b", "v1a"), drop=TRUE, verbose=FALSE)

## Default S3 method:

doFIRMA(dataSet, ..., verbose=FALSE)

Arguments

csR, dataSet
...

flavor

drop

verbose

Value

An AffymetrixCelSet (or the name of an AffymetrixCelSet).
Additional arguments passed to FirmaModel, and to set up AffymetrixCelSet
(when argument dataSet is specified).
A character string specifying the flavor of FIRMA to use.
If TRUE, the FIRMA scores are returned, otherwise a named list of all interme-
diate and final results.
See Verbose.

Returns a named list, iff drop == FALSE, otherwise only FirmaSet object (containing the FIRMA
scores).

Using a custom exon-by-transcript CDF

It is strongly recommended to use a custom CDF, e.g. "core", "extended" or "full" [1]. To use a
custom CDF, set it before calling this method, i.e. setCdf(csR, cdf). Do not set the standard
"non-supported" Affymetrix CDF (see also Section ’Flavors’).

Flavors

If flavor == "v1b" (default), then the standard "non-supported" Affymetrix CDF is used for back-
ground correction and the quantile normalization steps, and the custom CDF is used for the probe
summarization and everything that follows. The advantage of this flavor is that those two first
preprocessing steps will remain the same if one later changes to a different custom CDF.
If flavor == "v1a", then the custom CDF is used throughout all steps of FIRMA, which means
that if one changes the custom CDF all steps will be redone.

Author(s)

Henrik Bengtsson

92

References

doGCRMA

[1] E. Purdom, K. Simpson, M. Robinson, J. Conboy, A. Lapuk & T.P. Speed, FIRMA: a method
for detection of alternative splicing from exon array data, Bioinformatics, 2008.

doGCRMA

Robust Multichip Analysis (GCRMA)

Description

Robust Multichip Analysis (GCRMA) based on [1]. The algorithm is processed in bounded mem-
ory, meaning virtually any number of arrays can be analyzed on also very limited computer systems.
The method replicates the results of gcrma (package gcrma) with great precision.

Usage

## S3 method for class 'AffymetrixCelSet'

doGCRMA(csR, arrays=NULL, type=c("fullmodel", "affinities"), uniquePlm=FALSE, drop=TRUE,

verbose=FALSE, ...)
## Default S3 method:

doGCRMA(dataSet, ..., verbose=FALSE)

Arguments

csR, dataSet
arrays

type

uniquePlm

drop

verbose

...

Value

An AffymetrixCelSet (or the name of an AffymetrixCelSet).
A integer vector specifying the subset of arrays to process. If NULL, all arrays
are considered.
A character string specifying what type of model to use for the GCRMA back-
ground correction. For more details, see GcRmaBackgroundCorrection.
If TRUE, the log-additive probe-summarization model is done on probeset with
unique sets of probes. If FALSE, the summarization is done on "as-is" probesets
as specified by the CDF.
If TRUE, the summaries are returned, otherwise a named list of all intermediate
and final results.
See Verbose.
Additional arguments used to set up AffymetrixCelSet (when argument dataSet
is specified).

Returns a named list, iff drop == FALSE, otherwise only ChipEffectSet object.

Author(s)

Henrik Bengtsson

doRMA

References

93

[1] Z. Wu, R. Irizarry, R. Gentleman, F.M. Murillo & F. Spencer. A Model Based Background Ad-
justment for Oligonucleotide Expression Arrays, JASA, 2004.

doRMA

Robust Multichip Analysis (RMA)

Description

Robust Multichip Analysis (RMA) based on [1]. The algorithm is processed in bounded memory,
meaning virtually any number of arrays can be analyzed on also very limited computer systems.
The method replicates the results of fitPLM (package affyPLM) with great precision.

Usage

## S3 method for class 'AffymetrixCelSet'

doRMA(csR, arrays=NULL, flavor=c("affyPLM", "oligo"), uniquePlm=FALSE, drop=TRUE,

verbose=FALSE, ...)
## Default S3 method:

doRMA(dataSet, ..., verbose=FALSE)

Arguments

csR, dataSet
arrays

flavor

uniquePlm

drop

verbose

...

Value

An AffymetrixCelSet (or the name of an AffymetrixCelSet).
A integer vector specifying the subset of arrays to process. If NULL, all arrays
are considered.
A character string specifying what model fitting algorithm to be used, cf. RmaPlm.
If TRUE, the log-additive probe-summarization model is done on probeset with
unique sets of probes. If FALSE, the summarization is done on "as-is" probesets
as specified by the CDF.
If TRUE, the summaries are returned, otherwise a named list of all intermediate
and final results.
See Verbose.
Additional arguments used to set up AffymetrixCelSet (when argument dataSet
is specified).

Returns a named list, iff drop == FALSE, otherwise only ChipEffectSet object.

Author(s)

Henrik Bengtsson

94

References

ExonChipEffectFile

[1] Irizarry et al. Summaries of Affymetrix GeneChip probe level data. NAR, 2003, 31, e15.

ExonChipEffectFile

The ExonChipEffectFile class

Description

Package: aroma.affymetrix
Class ExonChipEffectFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ExonChipEffectFile

Directly known subclasses:

public abstract static class ExonChipEffectFile
extends ChipEffectFile

This class represents estimates of chip effects in the probe-level models.

ExonChipEffectFile

Usage

ExonChipEffectFile(..., mergeGroups=FALSE)

95

Arguments

...

Arguments passed to ChipEffectFile.

mergeGroups

Specifies if the groups are merged or not for these estimates.

Fields and Methods

Methods:

readUnits

-

Methods inherited from ChipEffectFile:
as.character, extractChromosomalDataFrame, extractMatrix, extractTheta, findUnitsTodo, getAM,
getAsFullCelFile, getCellIndices, getCellMapForMainCdf, getExpandedCellMap, getParameters,
getUnitGroupCellArrayMap, getUnitGroupCellMatrixMap, getXAM, mergeGroups, readUnits, writeAs-
FullCelFile

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,

96

ExonChipEffectSet

isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

See Also

An object of this class is typically part of a ExonChipEffectSet.

ExonChipEffectSet

The ExonChipEffectSet class

Description

Package: aroma.affymetrix
Class ExonChipEffectSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|

ExonChipEffectSet

97

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ExonChipEffectSet

Directly known subclasses:

public static class ExonChipEffectSet
extends ChipEffectSet

This class represents estimates of chip effects in the probe-level models.

Usage

ExonChipEffectSet(..., mergeGroups=TRUE)

Arguments

...

mergeGroups

Fields and Methods

Methods:

Arguments passed to ChipEffectSet.

Specifies if groups (individual exons in a CDF file) are merged or not for these
estimates, i.e. whether transcript-level expression is to be estimated.

findUnitsTodo
getAverageFile
getMergeGroups
setMergeGroups

-
-
-
-

Methods inherited from ChipEffectSet:
as.character, boxplotStats, byPath, calculateBaseline, calculateFieldBoxplotStats, calculateNuse-
BoxplotStats, calculateRleBoxplotStats, extractAffyBatch, extractChromosomalDataFrame, extract-
ExpressionSet, extractMatrix, extractTheta, findByName, findUnitsTodo, fromDataSet, getAM,
getAsFullCelSet, getAverageFile, getBaseline, getCellIndices, getXAM, plotBoxplot, readUnits,
updateUnits

Methods inherited from ParameterCelSet:
extractDataFrame, extractMatrix

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

98

ExonChipEffectSet

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

ExonProbeAffinityFile

99

ExonProbeAffinityFile The ExonProbeAffinityFile class

Description

Package: aroma.affymetrix
Class ExonProbeAffinityFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ProbeAffinityFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ExonProbeAffinityFile

Directly known subclasses:

public abstract static class ExonProbeAffinityFile
extends ProbeAffinityFile

This class represents estimates of probe affinities in exon array probe-level models.

Usage

ExonProbeAffinityFile(..., mergeGroups=FALSE)

100

Arguments

...

mergeGroups

ExonProbeAffinityFile

Arguments passed to ProbeAffinityFile.
Specifies if the groups (exons) are merged or not for these estimates.

Fields and Methods

Methods:
No methods defined.

Methods inherited from ProbeAffinityFile:
as.character, getCellIndices, getParameters, readUnits

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

ExonRmaPlm

101

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

ExonRmaPlm

The ExonRmaPlm class

Description

Package: aroma.affymetrix
Class ExonRmaPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ExonRmaPlm

Directly known subclasses:

public abstract static class ExonRmaPlm
extends RmaPlm

This class represents the log-additive model part of the Robust Multichip Analysis (RMA) method
described in Irizarry et al (2003), as implemented for exon arrays. The model may be fitted with
exons merged into transcripts (all probes fitted together) or on an individual exon basis (probes
within an exon treated as a group, but exons fitted separately).

Usage

ExonRmaPlm(..., mergeGroups=TRUE)

ExonRmaPlm

Arguments passed to RmaPlm.
A logical flag specifying whether to merge exons into transcripts.

102

Arguments

...

mergeGroups

Fields and Methods

Methods:

getCellIndices
getChipEffectSet
getProbeAffinityFile
setMergeGroups

-
-
-
-

Methods inherited from RmaPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, getRlmFitFunctions

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Model

RmaPlm.

Author(s)

Ken Simpson, Henrik Bengtsson, Elizabeth Purdom

References

Irizarry et al. Summaries of Affymetrix GeneChip probe level data. NAR, 2003, 31, e15.

FirmaFile

103

FirmaFile

The FirmaFile class

Description

Package: aroma.affymetrix
Class FirmaFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--FirmaFile

Directly known subclasses:

public abstract static class FirmaFile
extends ParameterCelFile

This class represents scores calculated by the FIRMA algorithm.

Usage

FirmaFile(...)

Arguments

...

Arguments passed to AffymetrixCelFile.

104

Fields and Methods

Methods:

FirmaFile

extractMatrix
findUnitsTodo
readUnits

-
-
-

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

FirmaModel

105

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

See Also

An object of this class is typically part of a FirmaSet.

FirmaModel

The FirmaModel class

Description

Package: aroma.affymetrix
Class FirmaModel

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FirmaModel

Directly known subclasses:

public abstract static class FirmaModel
extends UnitModel

This class represents the FIRMA (Finding Isoforms using RMA) alternative splicing model.

Usage

FirmaModel(rmaPlm=NULL, summaryMethod=c("median", "upperQuartile", "max"),

operateOn=c("residuals", "weights"), ...)

106

Arguments

rmaPlm

An @RmaPlm object.

FirmaSet

summaryMethod A character specifying what summarization method should be used.

operateOn

A character specifying what statistic to operate on.

...

Arguments passed to constructor of UnitModel.

Fields and Methods

Methods:

Estimates the model parameters.
-
-

fit
getCdf
getDataSet
getFirmaSet Gets the set of FIRMA results for this model.
getName
getPlm
getTags

-
-
-

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

FirmaSet

The FirmaSet class

FirmaSet

Description

Package: aroma.affymetrix
Class FirmaSet

107

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--FirmaSet

Directly known subclasses:

public static class FirmaSet
extends ParameterCelSet

Usage

FirmaSet(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to constructor of AffymetrixCelSet.

extractMatrix
findUnitsTodo
getCellIndices
readUnits

-
-
-
-

108

FirmaSet

Methods inherited from ParameterCelSet:
extractDataFrame, extractMatrix

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

FragmentEquivalentClassNormalization

109

Author(s)

Ken Simpson, Henrik Bengtsson

FragmentEquivalentClassNormalization

The FragmentEquivalentClassNormalization class

Description

Package: aroma.affymetrix
Class FragmentEquivalentClassNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ChipEffectTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--FragmentEquivalentClassNormalization

Directly known subclasses:

public static class FragmentEquivalentClassNormalization
extends ChipEffectTransform

This class represents a normalization method that corrects for systematic effects between loci of
different equivalent classes of pairs of sequences that are recognized by the restriction enzymes that
cut the DNA studies.

Usage

FragmentEquivalentClassNormalization(dataSet=NULL, ..., targetAvgs=NULL,

subsetToFit="-XY")

Arguments

dataSet

...

targetAvgs

A CnChipEffectSet.
Additional arguments passed to the constructor of ChipEffectTransform.
An optional list of functions. For each enzyme there is one target averages to
which all arrays should be normalized to.

110

FragmentEquivalentClassNormalization

subsetToFit

The units from which the normalization curve should be estimated. If NULL, all
are considered.

Fields and Methods

Methods:

getAromaUfcFile
getCdf
process

-
-
Normalizes the data set.

Methods inherited from ChipEffectTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires an UFC (Unit Fragment Class) annotation file.

Acknowledgments

The idea of normalization signals stratified on enzyme recognition sequences is credited to Jim
Veitch and Ben Bolstad at Affymetrix Inc. (2008) who have designed a similar method for copy
number estimation in the Affymetrix’ Genotype Console v2.

Author(s)

Henrik Bengtsson

FragmentLengthNormalization

111

FragmentLengthNormalization

The FragmentLengthNormalization class

Description

Package: aroma.affymetrix
Class FragmentLengthNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ChipEffectTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--FragmentLengthNormalization

Directly known subclasses:

public static class FragmentLengthNormalization
extends ChipEffectTransform

This class represents a normalization method that corrects for PCR fragment length effects on copy-
number chip-effect estimates.

Usage

FragmentLengthNormalization(dataSet=NULL, ..., target=targetFunctions, subsetToFit="-XY",

lengthRange=NULL, onMissing=c("median", "ignore"), shift=0, targetFunctions=NULL)

Arguments

dataSet

...

target

subsetToFit

A SnpChipEffectSet.
Additional arguments passed to the constructor of ChipEffectTransform.
(Optional) A character string or a list of functions specifying what to nor-
malize toward. For each enzyme there is one target function to which all arrays
should be normalized to.
The units from which the normalization curve should be estimated. If NULL, all
are considered.

112

lengthRange

onMissing
shift
targetFunctions

Details

FragmentLengthNormalization

If given, a numeric vector of length 2 specifying the range of fragment lengths
considered. All fragments with lengths outside this range are treated as if they
were missing.
Specifies how to normalize units for which the fragment lengths are unknown.
An optional amount the data points should be shifted (translated).

Deprecated.

For SNPs, the normalization function is estimated based on the total chip effects, i.e. the sum of the
allele signals. The normalizing is done by rescale the chip effects on the intensity scale such that the
mean of the total chip effects are the same across samples for any given fragment length. For allele-
specific estimates, both alleles are always rescaled by the same amount. Thus, when normalizing
allele-specific chip effects, the total chip effects is change, but not the relative allele signal, e.g. the
allele B frequency.

Fields and Methods

Methods:

getCdf
process Normalizes the data set.

-

Methods inherited from ChipEffectTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires a SNP information annotation file for the chip type to be normalized.

Author(s)

Henrik Bengtsson

GcContentNormalization

113

GcContentNormalization

The GcContentNormalization class

Description

Package: aroma.affymetrix
Class GcContentNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ChipEffectTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--GcContentNormalization

Directly known subclasses:

public static class GcContentNormalization
extends ChipEffectTransform

Usage

GcContentNormalization(dataSet=NULL, ..., targetFunction=NULL, subsetToFit=NULL)

Arguments

dataSet

A CnChipEffectSet.
Additional arguments passed to the constructor of ChipEffectTransform.

...
targetFunction A function. The target function to which all arrays should be normalized to.
subsetToFit

The units from which the normalization curve should be estimated. If NULL, all
are considered.

Fields and Methods

Methods:

114

GcContentNormalization2

getCdf
process Normalizes the data set.

-

Methods inherited from ChipEffectTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires an Aroma unit GC-content (UGC) file.

Author(s)

Henrik Bengtsson

GcContentNormalization2

The GcContentNormalization2 class

Description

Package: aroma.affymetrix
Class GcContentNormalization2

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ChipEffectTransform

GcContentNormalization2

115

~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AdditiveCovariatesNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--GcContentNormalization2

Directly known subclasses:

public static class GcContentNormalization2
extends AdditiveCovariatesNormalization

This class represents a normalization method that corrects for annotation-data covariate effects on
copy-number chip-effect estimates.

Usage

GcContentNormalization2(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to the constructor of AdditiveCovariatesNormalization.

plotCovariateEffects

-

Methods inherited from AdditiveCovariatesNormalization:
getAsteriskTags, getCdf, getCovariates, getOutputDataSet00, getParameters, process

Methods inherited from ChipEffectTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

116

Author(s)

Henrik Bengtsson

GcRmaBackgroundCorrection

GcRmaBackgroundCorrection

The GcRmaBackgroundCorrection class

Description

Package: aroma.affymetrix
Class GcRmaBackgroundCorrection

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--BackgroundCorrection
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--GcRmaBackgroundCorrection

Directly known subclasses:

public static class GcRmaBackgroundCorrection
extends BackgroundCorrection

This class represents the GCRMA background adjustment function.

Usage

GcRmaBackgroundCorrection(..., indicesNegativeControl=NULL, affinities=NULL,
type=c("fullmodel", "affinities"), opticalAdjust=TRUE, gsbAdjust=TRUE,
gsbParameters=NULL, seed=NULL)

Arguments

...

Arguments passed to the constructor of ProbeLevelTransform.

GcRmaBackgroundCorrection

indicesNegativeControl

117

Locations of any negative control probes (e.g., the anti-genomic controls on
the human exon array). If NULL and type == "affinities", then all non-PM
probes are used as the negative controls.
A numeric vector of probe affinities, usually as calculated by computeAffinities()
of the AffymetrixCdfFile class.
Type (flavor) of background correction, which can be either "fullmodel" (uses
MMs; requires that the chip type has PM/MM pairs) or "affinities" (uses
probe sequence only).
If TRUE, adjustment for specific binding is done, otherwise not.
If TRUE, correction for optical effect is done first, utilizing OpticalBackgroundCorrection.

affinities

type

gsbAdjust

opticalAdjust

gsbParameters Additional argument passed to the internal bgAdjustGcrma() method.
seed

An (optional) integer specifying a temporary random seed to be used during
processing. The random seed is set to its original state when done. If NULL, it is
not set.

Fields and Methods

Methods:

process

Performs background correction.

Methods inherited from BackgroundCorrection:
getParameters, process

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

118

References

GenericReporter

[1] Z. Wu, R. Irizarry, R. Gentleman, F.M. Murillo & F. Spencer. A Model Based Background Ad-
justment for Oligonucleotide Expression Arrays, JASA, 2004.

GenericReporter

The GenericReporter class

Description

Package: aroma.affymetrix
Class GenericReporter

Object
~~|
~~+--GenericReporter

Directly known subclasses:
AffymetrixCelSetReporter, AffymetrixFileSetReporter, SpatialReporter

public abstract static class GenericReporter
extends Object

Usage

GenericReporter(tags="*", ...)

Arguments

tags

...

Fields and Methods

Methods:

A character vector of tags to be added to the output path.

Not used.

getFullName
getName
getPath
getTags
process
setup

-
Gets the name of the explorer.
-
Gets the tags of the reporter.
Generates report.
-

GenomeInformation

119

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

GenomeInformation

The GenomeInformation class

Description

Package: aroma.affymetrix
Class GenomeInformation

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--GenomeInformation

Directly known subclasses:
AffymetrixCsvGenomeInformation, DChipGenomeInformation, UgpGenomeInformation

public abstract static class GenomeInformation
extends FileCacheKeyInterface

Usage

GenomeInformation(..., .verify=TRUE)

Arguments

...

.verify

Arguments passed to GenericDataFile.

For internal use only.

120

Fields and Methods

Methods:

GenomeInformation

byChipType
getChipType
getChromosomeStats
getChromosomes
getData
getPositions
getUnitsOnChromosome
getUnitsOnChromosomes
nbrOfUnits
plotDensity

Static method to define a genome information set by chip type.
Gets the chip type of this genome information set.
-
-
Gets all or a subset of the genome information data.
Gets the physical positions for a set of units.
-
-
-
Plots the density of SNPs for a given chromosome.

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

HetLogAddCnPlm

121

HetLogAddCnPlm

The HetLogAddCnPlm class

Description

Package: aroma.affymetrix
Class HetLogAddCnPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--HetLogAddPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--HetLogAddSnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--HetLogAddCnPlm

Directly known subclasses:

public abstract static class HetLogAddCnPlm
extends CnPlm

Usage

HetLogAddCnPlm(..., combineAlleles=FALSE)

Arguments

...
combineAlleles If FALSE, allele A and allele B are treated separately, otherwise together.

Arguments passed to HetLogAddCnPlm.

122

Fields and Methods

Methods:
No methods defined.

HetLogAddCnPlm

Methods inherited from CnPlm:
getCellIndices, getChipEffectSet, getCombineAlleles, getParameters, getProbeAffinityFile, setCom-
bineAlleles

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from HetLogAddSnpPlm:
getAsteriskTags

Methods inherited from HetLogAddPlm:
getAsteriskTags, getFitUnitGroupFunction

Methods inherited from RmaPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, getRlmFitFunctions

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Model

TO DO.

Author(s)

Henrik Bengtsson

HetLogAddPlm

123

HetLogAddPlm

The HetLogAddPlm class

Description

Package: aroma.affymetrix
Class HetLogAddPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--HetLogAddPlm

Directly known subclasses:
HetLogAddCnPlm, HetLogAddSnpPlm

public abstract static class HetLogAddPlm
extends RmaPlm

This class represents a log-additive model similar to the one described in Irizarry et al (2003), except
that the errors may have different variances for different probes.

Usage

HetLogAddPlm(...)

Arguments

...

Arguments passed to RmaPlm.

Fields and Methods

Methods:
No methods defined.

124

HetLogAddSnpPlm

Methods inherited from RmaPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, getRlmFitFunctions

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

RmaPlm.

HetLogAddSnpPlm

The HetLogAddSnpPlm class

Description

Package: aroma.affymetrix
Class HetLogAddSnpPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|

HetLogAddSnpPlm

125

~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--HetLogAddPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--HetLogAddSnpPlm

Directly known subclasses:
HetLogAddCnPlm

public abstract static class HetLogAddSnpPlm
extends SnpPlm

Usage

HetLogAddSnpPlm(..., mergeStrands=FALSE)

Arguments

...

mergeStrands

Arguments passed to HetLogAddPlm.
If TRUE, the sense and the anti-sense strands are fitted together, otherwise sepa-
rately.

Fields and Methods

Methods:
No methods defined.

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from HetLogAddPlm:
getAsteriskTags, getFitUnitGroupFunction

Methods inherited from RmaPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, getRlmFitFunctions

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

126

justRMA

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

justRMA

Robust Multichip Analysis (RMA) reproducing the affy package

Description

Robust Multichip Analysis (RMA) reproducing the affy package as far as possible. The RMA
method is described in [1].

The algorithm is processed in bounded memory, meaning a very large number of arrays can be
analyzed on also very limited computer systems. The only limitation is the amount of memory
required to load the final chip-effect estimates into memory (as a ExpressionSet).

Usage

## S3 method for class 'AffymetrixCelSet'

justRMA(csR, flavor=c("oligo", "affyPLM"), ..., verbose=FALSE)

## Default S3 method:

justRMA(...)

Arguments

csR

flavor

...

verbose

Value

An AffymetrixCelSet.
A character string specifying the estimators used in the RMA summarization
step.
Additional arguments passed to doRMA() used internally.
See Verbose.

Returns an annotated ExpressionSet.

LimmaBackgroundCorrection

Reproducibility of affy

127

This implementation of the RMA method reproduces justRMA in affy package quite well. It does
so by still using a constant memory profile, i.e. it is possible to use this implementation to run RMA
on a much large data set than what is possible with affy. At least 20-50 times more samples should
be doable, if not more.

Author(s)

Henrik Bengtsson

References

[1] Irizarry et al. Summaries of Affymetrix GeneChip probe level data. NAR, 2003, 31, e15.

See Also

doRMA().

LimmaBackgroundCorrection

The LimmaBackgroundCorrection class

Description

Package: aroma.affymetrix
Class LimmaBackgroundCorrection

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--BackgroundCorrection
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--LimmaBackgroundCorrection

Directly known subclasses:
NormExpBackgroundCorrection

128

LimmaBackgroundCorrection

public static class LimmaBackgroundCorrection
extends BackgroundCorrection

This class represents the various "background" correction methods implemented in the limma pack-
age.

Usage

LimmaBackgroundCorrection(..., args=NULL, addJitter=FALSE, jitterSd=0.2, seed=6022007)

Arguments

...

args

addJitter

jitterSd

seed

Details

Arguments passed to the constructor of BackgroundCorrection.
A list of additional arguments passed to the correction algorithm.
If TRUE, Zero-mean gaussian noise is added to the signals before being back-
ground corrected.

Standard deviation of the jitter noise added.
An (optional) integer specifying a temporary random seed to be used for gen-
erating the (optional) jitter. The random seed is set to its original state when
done. If NULL, it is not set.

By default, only PM signals are background corrected and MMs are left unchanged.

Fields and Methods

Methods:

process

Performs background correction.

Methods inherited from BackgroundCorrection:
getParameters, process

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

LinearModelProbeSequenceNormalization

129

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Jitter noise

The fitting algorithm of the normal+exponential background correction model may not converge
if there too many small and discrete signals. To overcome this problem, a small amount of noise
may be added to the signals before fitting the model. This is an ad hoc solution that seems to work.
However, adding Gaussian noise may generate non-positive signals.

Author(s)

Henrik Bengtsson. Adopted from RmaBackgroundCorrection by Ken Simpson.

See Also

Internally, backgroundCorrect is used.

LinearModelProbeSequenceNormalization

The LinearModelProbeSequenceNormalization class

Description

Package: aroma.affymetrix
Class LinearModelProbeSequenceNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AbstractProbeSequenceNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--LinearModelProbeSequenceNormalization

130

LinearModelProbeSequenceNormalization

Directly known subclasses:
BasePositionNormalization

public abstract static class LinearModelProbeSequenceNormalization
extends AbstractProbeSequenceNormalization

This abstract class represents a normalization method that corrects for systematic effects in the probe
intensities due to probe-sequence dependent effects that can be modeled using a linear model.

Usage

LinearModelProbeSequenceNormalization(...)

Arguments

...

Arguments passed to the constructor of AbstractProbeSequenceNormalization.

Fields and Methods

Methods:
No methods defined.

Methods inherited from AbstractProbeSequenceNormalization:
fitOne, getAromaCellSequenceFile, getParameters, getTargetFile, indexOfMissingSequences, pre-
dictOne, process

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires that an aroma probe sequence file is available for the chip type.

MatNormalization

Memory usage

131

The model fitting methods of this class are bounded in memory. This is done by first building up the
normal equations incrementally in chunks of cells. The generation of normal equations is otherwise
the step that consumes the most memory. When the normal equations are available, the solve()
method is used to solve the equations. Note that this algorithm is still exact.

Author(s)

Henrik Bengtsson

MatNormalization

The MatNormalization class

Description

Package: aroma.affymetrix
Class MatNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AbstractProbeSequenceNormalization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MatNormalization

Directly known subclasses:

public static class MatNormalization
extends AbstractProbeSequenceNormalization

This class represents a normalization method that corrects for systematic effects in the probe inten-
sities due to differences in the number of A, C, G, and T:s and the match scores according to MAT
[1].

132

Usage

MatNormalization

MatNormalization(..., unitsToFit=NULL, model=c("lm"), nbrOfBins=200)

Arguments

...

unitsToFit

model

nbrOfBins

Fields and Methods

Methods:

Arguments passed to the constructor of AbstractProbeSequenceNormalization.
The units from which the normalization curve should be estimated. If NULL, all
are considered.
A character string specifying the model used to fit the base-count effects.

The number of bins to use for the variance smoothing step.

process Normalizes the data set.

Methods inherited from AbstractProbeSequenceNormalization:
fitOne, getAromaCellSequenceFile, getParameters, getTargetFile, indexOfMissingSequences, pre-
dictOne, process

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Requirements

This class requires that an aroma probe sequence file and aroma match scores file is available for
the chip type.

MatSmoothing

Author(s)

Mark Robinson

References

133

[1] Johnson WE, Li W, Meyer CA, Gottardo R, Carroll JS, Brown M, Liu XS. Model-based analysis
of tiling-arrays for ChIP-chip, PNAS, 2006.

MatSmoothing

The MatSmoothing class

Description

Package: aroma.affymetrix
Class MatSmoothing

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--MatSmoothing

Directly known subclasses:

public static class MatSmoothing
extends ProbeLevelTransform

This class represents a function for smoothing data with a trimmed mean.

Usage

MatSmoothing(..., design=NULL, probeWindow=300, nProbes=10, meanTrim=0.1)

Arguments

...

design

Arguments passed to ProbeLevelTransform.
A design matrix.

MbeiCnPlm

Bandwidth to use. Effectively the width is 2*probeWindow since it looks probe-
Window bases in either direction.

The minimum number of probes to calculate a MAT score for.

The amount of trimming of the mean in [0,0.5].

134

probeWindow

nProbes

meanTrim

Details

This class requires the gsmoothr package, which was archived on CRAN in May 2025.

Fields and Methods

Methods:

process

Processes the data set.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Mark Robinson, Henrik Bengtsson

MbeiCnPlm

The MbeiCnPlm class

MbeiCnPlm

Description

Package: aroma.affymetrix
Class MbeiCnPlm

135

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MbeiPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MbeiSnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MbeiCnPlm

Directly known subclasses:

public abstract static class MbeiCnPlm
extends CnPlm

Usage

MbeiCnPlm(..., combineAlleles=FALSE)

Arguments

...

Arguments passed to MbeiSnpPlm.

combineAlleles If FALSE, allele A and allele B are treated separately, otherwise together.

Fields and Methods

Methods:
No methods defined.

136

MbeiPlm

Methods inherited from CnPlm:
getCellIndices, getChipEffectSet, getCombineAlleles, getParameters, getProbeAffinityFile, setCom-
bineAlleles

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from MbeiSnpPlm:
getAsteriskTags

Methods inherited from MbeiPlm:
getAsteriskTags, getFitUnitGroupFunction

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

MbeiPlm

The MbeiPlm class

Description

Package: aroma.affymetrix
Class MbeiPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model

MbeiPlm

137

~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MbeiPlm

Directly known subclasses:
MbeiCnPlm, MbeiSnpPlm

public abstract static class MbeiPlm
extends ProbeLevelModel

This class represents the model-based expression indexes (MBEI) multiplicative model in Li &
Wong (2001).

Usage

MbeiPlm(...)

Arguments

...

Arguments passed to ProbeLevelModel.

Fields and Methods

Methods:
No methods defined.

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

138

Model

MbeiSnpPlm

For a single unit group, the multiplicative model is:

yik = θiϕk + εik

where θi are the chip effects for arrays i = 1, ..., I, and ϕk are the probe affinities for probes
k = 1, ..., K. The εik are zero-mean noise with equal variance. To make to parameters identifiable,
the constraint (cid:81)

k ϕk = 1 is added.

Author(s)

Henrik Bengtsson

References

Li, C. and Wong, W.H. (2001), Genome Biology 2, 1-11.
Li, C. and Wong, W.H. (2001), Proc. Natl. Acad. Sci USA 98, 31-36.

See Also

Internally fit.li.wong is used.

MbeiSnpPlm

The MbeiSnpPlm class

Description

Package: aroma.affymetrix
Class MbeiSnpPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MbeiPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm

MbeiSnpPlm

139

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--MbeiSnpPlm

Directly known subclasses:
MbeiCnPlm

public abstract static class MbeiSnpPlm
extends SnpPlm

Usage

MbeiSnpPlm(..., mergeStrands=FALSE)

Arguments

...

mergeStrands

Arguments passed to MbeiPlm.
If TRUE, the sense and the anti-sense strands are fitted together, otherwise sepa-
rately.

Fields and Methods

Methods:
No methods defined.

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from MbeiPlm:
getAsteriskTags, getFitUnitGroupFunction

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Model

140

Author(s)

Henrik Bengtsson

Model

The Model class

Description

Package: aroma.affymetrix
Class Model

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model

Directly known subclasses:
AffineCnPlm, AffinePlm, AffineSnpPlm, AlleleSummation, AvgCnPlm, AvgPlm, AvgSnpPlm, Crlm-
mModel, ExonRmaPlm, FirmaModel, HetLogAddCnPlm, HetLogAddPlm, HetLogAddSnpPlm, Mbe-
iCnPlm, MbeiPlm, MbeiSnpPlm, MultiArrayUnitModel, ProbeLevelModel, RmaCnPlm, RmaPlm,
RmaSnpPlm, SingleArrayUnitModel, UnitModel

public abstract static class Model
extends ParametersInterface

This class is abstract and represents a generic model that applies to a data set.

Usage

Model(dataSet=NULL, tags="*", ..., .onUnknownArgs=c("error", "warning", "ignore"))

Arguments

dataSet

tags

...

The data set to which this model should be fitted.

A character vector of tags to be appended to the tags of the input data set.

Not used.

.onUnknownArgs A character string specifying what should occur if there are unknown argu-

ments in ....

MultiArrayUnitModel

Fields and Methods

Methods:

141

fit
getAsteriskTags
getDataSet
getFullName
getName
getPath
getTags
setTags

Estimates the model parameters.
-
Gets the input data set for this model.
Gets the full name of the output set.
Gets the name of the output data set.
Gets the path of this model.
Gets the tags of the output data set.
Sets the tags to be appended.

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

MultiArrayUnitModel

The MultiArrayUnitModel class

Description

Package: aroma.affymetrix
Class MultiArrayUnitModel

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel

Directly known subclasses:
AffineCnPlm, AffinePlm, AffineSnpPlm, AvgCnPlm, AvgPlm, AvgSnpPlm, ExonRmaPlm, HetLo-
gAddCnPlm, HetLogAddPlm, HetLogAddSnpPlm, MbeiCnPlm, MbeiPlm, MbeiSnpPlm, ProbeLevelModel,

142

MultiArrayUnitModel

RmaCnPlm, RmaPlm, RmaSnpPlm

public abstract static class MultiArrayUnitModel
extends UnitModel

This abstract class represents a unit model that fits one model per unit based on signals for all arrays
in the data set. The nature of a multi-array unit model is that all arrays must be available at the time
of the fit and the estimated parameters will depend on the data from all arrays. Thus, if the signals
in one array changes the model has to be refitted.

Usage

MultiArrayUnitModel(..., listOfPriors=NULL)

Arguments

...

listOfPriors

Fields and Methods

Methods:

Arguments passed to UnitModel.
A list of priors to be used when fitting the model.

getListOfPriors
setListOfPriors

-
-

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

NormExpBackgroundCorrection

143

NormExpBackgroundCorrection

The NormExpBackgroundCorrection class

Description

Package: aroma.affymetrix
Class NormExpBackgroundCorrection

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--BackgroundCorrection
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--LimmaBackgroundCorrection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--NormExpBackgroundCorrection

Directly known subclasses:

public static class NormExpBackgroundCorrection
extends LimmaBackgroundCorrection

This class represents the normal exponential background correction model. Estimators of the limma
package is used.

Usage

NormExpBackgroundCorrection(..., method=c("rma", "saddle", "mle"))

Arguments

...

method

Arguments passed to the constructor of LimmaBackgroundCorrection.
The estimator used, cf. argument normexp.method of backgroundCorrect in
limma for more details.

OpticalBackgroundCorrection

144

Fields and Methods

Methods:
No methods defined.

Methods inherited from LimmaBackgroundCorrection:
getAsteriskTags, getParameters, process

Methods inherited from BackgroundCorrection:
getParameters, process

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

Internally, backgroundCorrect is used.

OpticalBackgroundCorrection

The OpticalBackgroundCorrection class

Description

Package: aroma.affymetrix
Class OpticalBackgroundCorrection

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform

OpticalBackgroundCorrection

145

~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--BackgroundCorrection
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--OpticalBackgroundCorrection

Directly known subclasses:

public static class OpticalBackgroundCorrection
extends BackgroundCorrection

This class represents "optical" background adjustment.

Usage

OpticalBackgroundCorrection(..., minimum=1)

Arguments

...

minimum

Fields and Methods

Methods:

Arguments passed to the constructor of ProbeLevelTransform.

The minimum signal allowed after adjustment.

process

Performs background correction.

Methods inherited from BackgroundCorrection:
getParameters, process

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

146

ParameterCelFile

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson

ParameterCelFile

The ParameterCelFile class

Description

Package: aroma.affymetrix
Class ParameterCelFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile

Directly known subclasses:
ChipEffectFile, CnChipEffectFile, CnProbeAffinityFile, ExonChipEffectFile, ExonProbeAffinityFile,
FirmaFile, ProbeAffinityFile, ResidualFile, SnpChipEffectFile, SnpProbeAffinityFile, WeightsFile

public abstract static class ParameterCelFile
extends ParametersInterface

A ParameterCelFile object represents parameter estimates.

ParameterCelFile

Usage

ParameterCelFile(..., encodeFunction=NULL, decodeFunction=NULL)

Arguments

...

Arguments passed to AffymetrixCelFile.

encodeFunction A function taking a single list structure as its argument.
decodeFunction A function taking a single list structure as its argument.

147

Fields and Methods

Methods:

extractDataFrame
extractMatrix
readUnits

-
-
-

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

148

ParameterCelSet

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

File format

The idea behind this class is store data fields which by nature have one value per probe (per field)
in CEL files. A perfect example is to store probe-affinity estimates and their standard deviations.
There is one probe affinity per probe so the structure of a CEL file (and its coupled CDF file) is well
suited to read/write such information.
Consider a unit group with L probes. A CEL file stores intensities (L floats), stdvs (L floats),
and pixels (L integers). Thus, for each probe l=1,...,L, a (float, float, integer) tuple is stored.
We can use this for any information we want. If we want a slightly different structure, we can
choose to encode/decode our structure/information to fit the structure of the CEL file. This abstract
class provides transparent methods for encoding and decoding such information through methods
encodeUnitGroup() and decodeUnitGroup(). By subclassing you can implement different types
of data structures.

Author(s)

Henrik Bengtsson

ParameterCelSet

The ParameterCelSet class

Description

Package: aroma.affymetrix
Class ParameterCelSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet

ParameterCelSet

149

~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelSet

Directly known subclasses:
ChipEffectSet, CnChipEffectSet, ExonChipEffectSet, FirmaSet, SnpChipEffectSet

public static class ParameterCelSet
extends ParametersInterface

A ParameterCelSet object represents a set of ParameterCelFile:s.

Usage

ParameterCelSet(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to AffymetrixCelSet.

extractDataFrame Extract data as a data.frame for a set of arrays.
extractMatrix

Extract data as a matrix for a set of arrays.

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

150

ProbeAffinityFile

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

ProbeAffinityFile

The ProbeAffinityFile class

Description

Package: aroma.affymetrix
Class ProbeAffinityFile

Object
~~|

ProbeAffinityFile

151

~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ProbeAffinityFile

Directly known subclasses:
CnProbeAffinityFile, ExonProbeAffinityFile, SnpProbeAffinityFile

public abstract static class ProbeAffinityFile
extends ParameterCelFile

This class represents estimates of probe affinities in probe-level models.

Usage

ProbeAffinityFile(..., probeModel=c("pm", "mm", "pm-mm", "min1(pm-mm)", "pm+mm"))

Arguments

...
probeModel

Arguments passed to ParameterCelFile.
The specific type of probe model.

Fields and Methods

Methods:

readUnits

-

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

152

ProbeAffinityFile

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically obtained through the getProbeAffinityFile() method for the
ProbeLevelModel class.

ProbeLevelModel

153

ProbeLevelModel

The ProbeLevelModel class

Description

Package: aroma.affymetrix
Class ProbeLevelModel

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel

Directly known subclasses:
AffineCnPlm, AffinePlm, AffineSnpPlm, AvgCnPlm, AvgPlm, AvgSnpPlm, ExonRmaPlm, HetLo-
gAddCnPlm, HetLogAddPlm, HetLogAddSnpPlm, MbeiCnPlm, MbeiPlm, MbeiSnpPlm, RmaCn-
Plm, RmaPlm, RmaSnpPlm

public abstract static class ProbeLevelModel
extends MultiArrayUnitModel

This abstract class represents a probe-level model (PLM) as defined by the affyPLM package: "A
[...] PLM is a model that is fit to probe-intensity data. More specifically, it is where we fit a model
with probe level and chip level parameters on a probeset by probeset basis", where the more general
case for a probeset is a unit group in Affymetrix CDF terms.

Usage

ProbeLevelModel(..., standardize=TRUE)

Arguments

...

Arguments passed to MultiArrayUnitModel.

standardize

If TRUE, chip-effect and probe-affinity estimates are rescaled such that the prod-
uct of the probe affinities is one.

154

Details

ProbeLevelModel

In order to minimize the risk for mistakes, but also to be able compare results from different PLMs,
all PLM subclasses must meet the following criteria:

1. All parameter estimates must be (stored and returned) on the intensity scale, e.g. log-additive
models such as RmaPlm have to transform the parameters on the log-scale to the intensity scale.

2. The probe-affinity estimates ϕk for a unit group must be constrained such that (cid:81)

k ϕk = 1, or

equivalently if ϕk > 0,(cid:80)

k log(ϕk) = 0.

Note that the above probe-affinity constraint guarantees that the estimated chip effects across models
are on the same scale.

Fields and Methods

Methods:

fit
getChipEffectSet
getProbeAffinityFile Gets the probe affinities for this model.
getResidualSet
getWeightsSet

Estimates the model parameters.
Gets the set of chip effects for this model.

-
-

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

For more details on probe-level models, please see the preprocessCore package.

ProbeLevelTransform

155

ProbeLevelTransform

The ProbeLevelTransform class

Description

Package: aroma.affymetrix
Class ProbeLevelTransform

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform

Directly known subclasses:
AbstractProbeSequenceNormalization, AllelicCrosstalkCalibration, BackgroundCorrection, BaseC-
ountNormalization, BasePositionNormalization, DChipQuantileNormalization, GcRmaBackground-
Correction, LimmaBackgroundCorrection, LinearModelProbeSequenceNormalization, MatNormal-
ization, MatSmoothing, NormExpBackgroundCorrection, OpticalBackgroundCorrection, ProbeLevel-
Transform3, QuantileNormalization, ReseqCrosstalkCalibration, RmaBackgroundCorrection, ScaleNor-
malization, ScaleNormalization3, SpatialRowColumnNormalization, UnitTypeScaleNormalization

public abstract static class ProbeLevelTransform
extends Transform

This abstract class represents a transformation methods that transforms probe-level signals, typi-
cally intensities.

Usage

ProbeLevelTransform(...)

Arguments

...

Details

Arguments passed to the constructor of Transform.

Subclasses must implement the process() method.

156

Fields and Methods

Methods:
No methods defined.

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

ProbeLevelTransform3

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

ProbeLevelTransform3

The ProbeLevelTransform3 class

Description

Package: aroma.affymetrix
Class ProbeLevelTransform3

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3

Directly known subclasses:
AbstractProbeSequenceNormalization, BaseCountNormalization, BasePositionNormalization, Lin-
earModelProbeSequenceNormalization, MatNormalization, ScaleNormalization3, UnitTypeScaleNor-
malization

ProbeLevelTransform3

157

public abstract static class ProbeLevelTransform3
extends ProbeLevelTransform

This abstract class is specialized from ProbeLevelTransform and provides methods to identify
subsets and types of probes that are used for fitting and/or updating the signals.

Usage

ProbeLevelTransform3(dataSet=NULL, ..., unitsToFit="-XY", typesToFit=typesToUpdate,

unitsToUpdate=NULL, typesToUpdate="pm", shift=0)

Arguments

dataSet

...

unitsToFit

A AffymetrixCelSet.
Arguments passed to the constructor of ProbeLevelTransform.
The units from which the normalization curve should be estimated. If NULL, all
are considered.

typesToFit

unitsToUpdate

typesToUpdate

shift

Types of probes to be used when fitting the model.
The units to be updated. If NULL, all are considered.

Types of probes to be updated.

An optional amount to shift data before fitting and updating.

Fields and Methods

Methods:
No methods defined.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

158

QualityAssessmentFile

QualityAssessmentFile The QualityAssessmentFile class

Description

Package: aroma.affymetrix
Class QualityAssessmentFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--QualityAssessmentFile

Directly known subclasses:

public abstract static class QualityAssessmentFile
extends AffymetrixCelFile

This class represents probe-level QC information (residuals, weights, etc.)

Usage

QualityAssessmentFile(...)

Arguments

...

Arguments passed to AffymetrixCelFile.

QualityAssessmentFile

Fields and Methods

Methods:

findUnitsTodo

-

159

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson

QualityAssessmentModel

160

See Also

An object of this class is typically part of a QualityAssessmentSet.

QualityAssessmentModel

The QualityAssessmentModel class

Description

Package: aroma.affymetrix
Class QualityAssessmentModel

Object
~~|
~~+--QualityAssessmentModel

Directly known subclasses:

public static class QualityAssessmentModel
extends Object

Usage

QualityAssessmentModel(plm=NULL, tags="*", ...)

Arguments

plm

tags

...

Fields and Methods

Methods:

A ProbeLevelModel.
A character vector of tags.
Not used.

getChipEffectSet
getDataSet
getFullName
getName
getPath
getPlm
getResiduals

-
-
-
-
-
-
Calculates the residuals from a probe-level model.

QualityAssessmentSet

161

getTags
getWeights
nbrOfArrays
plotNuse
plotRle

-
Calculates the weights from the robust fit to a probe-level model.
-
-
-

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

QualityAssessmentSet

The QualityAssessmentSet class

Description

Package: aroma.affymetrix
Class QualityAssessmentSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--QualityAssessmentSet

Directly known subclasses:

public static class QualityAssessmentSet
extends AffymetrixCelSet

162

Usage

QualityAssessmentSet(...)

QualityAssessmentSet

Arguments

...

Arguments passed to constructor of AffymetrixCelSet.

Fields and Methods

Methods:
No methods defined.

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

QuantileNormalization

163

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson

QuantileNormalization The QuantileNormalization class

Description

Package: aroma.affymetrix
Class QuantileNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--QuantileNormalization

Directly known subclasses:
DChipQuantileNormalization

public static class QuantileNormalization
extends ProbeLevelTransform

This class represents a normalization function that transforms the probe-level signals towards the
same empirical distribution.

Usage

QuantileNormalization(..., subsetToUpdate=NULL, typesToUpdate=NULL,

targetDistribution=NULL, subsetToAvg=subsetToUpdate, typesToAvg=typesToUpdate)

164

Arguments

QuantileNormalization

Arguments passed to the constructor of ProbeLevelTransform.

...
subsetToUpdate The probes to be updated. If NULL, all probes are updated.
typesToUpdate
targetDistribution

Types of probes to be updated.

A numeric vector. The empirical distribution to which all arrays should be
normalized to.
The probes to calculate average empirical distribution over. If a single numeric
in (0,1), then this fraction of all probes will be used. If NULL, all probes are
considered.

Types of probes to be used when calculating the average empirical distribution.
If "pm" and "mm" only perfect-match and mismatch probes are used, respec-
tively. If "pmmm" both types are used.

subsetToAvg

typesToAvg

Fields and Methods

Methods:

process Normalizes the data set.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

Examples

## Not run:

for (zzz in 0) {

ReseqCrosstalkCalibration

165

# Setup verbose output
verbose <- Arguments$getVerbose(-2)
timestampOn(verbose)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define an example dataset
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Find any dataset
path <- NULL
if (is.null(path))

break

ds <- AffymetrixCelSet$fromFiles(path)
print(ds)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Normalization
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
norm <- QuantileNormalization(ds, subsetToAvg=1/3)
dsQN <- process(norm, verbose=verbose)
print(dsQN)

} # for (zzz in 0)
rm(zzz)

## End(Not run)

ReseqCrosstalkCalibration

The ReseqCrosstalkCalibration class

Description

Package: aroma.affymetrix
Class ReseqCrosstalkCalibration

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ReseqCrosstalkCalibration

166

ReseqCrosstalkCalibration

Directly known subclasses:

public static class ReseqCrosstalkCalibration
extends ProbeLevelTransform

This class represents a calibration function that transforms the probe-level signals such that the
signals from the four nucleotides (A, C, G, T) are orthogonal.

Usage

ReseqCrosstalkCalibration(dataSet=NULL, ..., targetAvg=2200, subsetToAvg=NULL,

mergeGroups=FALSE, flavor=c("sfit", "expectile"), alpha=c(0.1, 0.075, 0.05, 0.03,
0.01), q=2, Q=98)

Arguments

dataSet

...

targetAvg

subsetToAvg

mergeGroups

flavor

alpha, q, Q

Fields and Methods

Methods:

An AffymetrixCelSet.
Arguments passed to the constructor of ProbeLevelTransform.

The signal(s) that the average of the sum of the probe quartets should have after
calibration.

The indices of the cells (taken as the intersect of existing indices) used to cal-
culate average in order to rescale to the target average. If NULL, all probes are
considered.
A logical ...
A character string specifying what algorithm is used to fit the crosstalk cali-
bration.
Additional arguments passed to fitMultiDimensionalCone().

process Calibrates the data set.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

ResidualFile

167

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

ResidualFile

The ResidualFile class

Description

Package: aroma.affymetrix
Class ResidualFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ResidualFile

Directly known subclasses:

168

ResidualFile

public abstract static class ResidualFile
extends ParameterCelFile

This class represents estimates of residuals in the probe-level models.

Usage

ResidualFile(..., probeModel=c("pm"))

Arguments

...

probeModel

Arguments passed to ParameterCelFile.
The specific type of model, e.g. "pm".

Fields and Methods

Methods:

findUnitsTodo
getImage
readUnits
writeImage

-
-
-
-

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,

ResidualSet

169

getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

See Also

An object of this class is typically obtained through the getResidualSet() method for the ProbeLevelModel
class. An object of this class is typically part of a ResidualSet.

ResidualSet

The ResidualSet class

Description

Package: aroma.affymetrix
Class ResidualSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet

170

ResidualSet

~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ResidualSet

Directly known subclasses:

public static class ResidualSet
extends ParametersInterface

This class represents probe-level residuals from probe-level models.

Usage

ResidualSet(..., probeModel=c("pm"))

Arguments

...

probeModel

Fields and Methods

Methods:

Arguments passed to AffymetrixCelSet.
The specific type of model, e.g. "pm".

findUnitsTodo
getAverageFile
getCellIndices
readUnits

-
-
-
-

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

RmaBackgroundCorrection

171

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Ken Simpson, Henrik Bengtsson

See Also

An object of this class is typically obtained through the getResidualSet() method for the ProbeLevelModel
class.

RmaBackgroundCorrection

The RmaBackgroundCorrection class

172

Description

Package: aroma.affymetrix
Class RmaBackgroundCorrection

RmaBackgroundCorrection

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--BackgroundCorrection
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaBackgroundCorrection

Directly known subclasses:

public static class RmaBackgroundCorrection
extends BackgroundCorrection

This class represents the RMA background adjustment function.

Usage

RmaBackgroundCorrection(..., addJitter=FALSE, jitterSd=0.2, seed=6022007)

Arguments

...

addJitter

jitterSd

seed

Details

Arguments passed to the constructor of BackgroundCorrection.
If TRUE, Zero-mean gaussian noise is added to the signals before being back-
ground corrected.

Standard deviation of the jitter noise added.
An (optional) integer specifying a temporary random seed to be used for gen-
erating the (optional) jitter. The random seed is set to its original state when
done. If NULL, it is not set.

Internally bg.adjust is used to background correct the probe signals. The default is to background
correct PM signals only.

RmaCnPlm

Fields and Methods

Methods:

173

process

Performs background correction.

Methods inherited from BackgroundCorrection:
getParameters, process

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Jitter noise

The fitting algorithm of the RMA background correction model may not converge if there too many
small and discrete signals. To overcome this problem, a small amount of noise may be added to
the signals before fitting the model. This is an ad hoc solution that seems to work. However, add
Gaussian noise may generate non-positive signals.

Author(s)

Ken Simpson, Henrik Bengtsson

RmaCnPlm

The RmaCnPlm class

Description

Package: aroma.affymetrix
Class RmaCnPlm

Object
~~|

174

RmaCnPlm

~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaSnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--CnPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaCnPlm

Directly known subclasses:

public abstract static class RmaCnPlm
extends CnPlm

Usage

RmaCnPlm(..., combineAlleles=FALSE)

Arguments

...
combineAlleles If FALSE, allele A and allele B are treated separately, otherwise together.

Arguments passed to RmaSnpPlm.

Fields and Methods

Methods:
No methods defined.

Methods inherited from CnPlm:
getCellIndices, getChipEffectSet, getCombineAlleles, getParameters, getProbeAffinityFile, setCom-
bineAlleles

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from RmaSnpPlm:
getAsteriskTags

RmaPlm

175

Methods inherited from RmaPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, getRlmFitFunctions

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Model

TO DO.

Author(s)

Henrik Bengtsson

RmaPlm

The RmaPlm class

Description

Package: aroma.affymetrix
Class RmaPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|

176

RmaPlm

~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm

Directly known subclasses:
ExonRmaPlm, HetLogAddCnPlm, HetLogAddPlm, HetLogAddSnpPlm, RmaCnPlm, RmaSnpPlm

public abstract static class RmaPlm
extends ProbeLevelModel

This class represents the log-additive model part of the Robust Multichip Analysis (RMA) method
described in Irizarry et al (2003).

Usage

RmaPlm(..., flavor=c("affyPLM", "oligo"))

Arguments

...

flavor

Arguments passed to ProbeLevelModel.
A character string specifying what model fitting algorithm to be used. This
makes it possible to get identical estimates as other packages.

Fields and Methods

Methods:
No methods defined.

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

RmaSnpPlm

Model

177

For a single unit group, the log-additive model of RMA is:

log2(yik) = βi + αk + εik

where βi are the chip effects for arrays i = 1, ..., I, and αk are the probe affinities for probes
k = 1, ..., K. The εik are zero-mean noise with equal variance. The model is constrained such that
(cid:80)

k αk = 0.

Note that all PLM classes must return parameters on the intensity scale. For this class that means
that θi = 2β

i and ϕk = 2α

k are returned.

Different flavors of model fitting

There are a few differ algorithms available for fitting the same probe-level model. The default
and recommended method (flavor="affyPLM") uses the implementation in the preprocessCore
package which fits the model parameters robustly using an M-estimator (the method used to be in
affyPLM).
Alternatively, other model-fitting algorithms are available. The algorithm (flavor="oligo") used
by the oligo package, which originates from the affy packages, fits the model using median polish,
which is a non-robust estimator. Note that this algorithm does not constraint the probe-effect pa-
rameters to multiply to one on the intensity scale. Since the internal function does not return these
estimates, we can neither rescale them.

Author(s)

Henrik Bengtsson, Ken Simpson

References

Irizarry et al. Summaries of Affymetrix GeneChip probe level data. NAR, 2003, 31, e15.

RmaSnpPlm

The RmaSnpPlm class

Description

Package: aroma.affymetrix
Class RmaSnpPlm

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|

178

RmaSnpPlm

~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--MultiArrayUnitModel
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelModel
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpPlm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--RmaSnpPlm

Directly known subclasses:
RmaCnPlm

public abstract static class RmaSnpPlm
extends SnpPlm

Usage

RmaSnpPlm(..., mergeStrands=FALSE)

Arguments

...

mergeStrands

Arguments passed to RmaPlm.
If TRUE, the sense and the anti-sense strands are fitted together, otherwise sepa-
rately.

Fields and Methods

Methods:
No methods defined.

Methods inherited from SnpPlm:
getCellIndices, getChipEffectSet, getMergeStrands, getParameters, getProbeAffinityFile, setMergeS-
trands

Methods inherited from RmaPlm:
getAsteriskTags, getCalculateResidualsFunction, getParameters, getRlmFitFunctions

Methods inherited from ProbeLevelModel:
calculateResidualSet, calculateWeights, fit, getAsteriskTags, getCalculateResidualsFunction, getChip-
EffectSet, getProbeAffinityFile, getResidualSet, getRootPath, getWeightsSet

Methods inherited from MultiArrayUnitModel:
getListOfPriors, setListOfPriors, validate

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

ScaleNormalization

179

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

ScaleNormalization

The ScaleNormalization class

Description

Package: aroma.affymetrix
Class ScaleNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ScaleNormalization

Directly known subclasses:

public static class ScaleNormalization
extends ProbeLevelTransform

This class represents a normalization function that transforms the probe-level signals towards the
same scale.

Usage

ScaleNormalization(dataSet=NULL, ..., targetAvg=4400, subsetToUpdate=NULL,

typesToUpdate=NULL, subsetToAvg="-XY", typesToAvg=typesToUpdate, shift=0)

180

Arguments

ScaleNormalization

dataSet

...

targetAvg

AffymetrixCelSet to be normalized.
Arguments passed to the constructor of ProbeLevelTransform.
A numeric value.

subsetToUpdate The probes to be updated. If NULL, all probes are updated.
typesToUpdate

subsetToAvg

typesToAvg

Types of probes to be updated.
The probes to calculate average signal over. If a single numeric in (0,1), then
this fraction of all probes will be used. If NULL, all probes are considered.
Types of probes to be used when calculating the average signal. If "pm" and
"mm" only perfect-match and mismatch probes are used, respectively. If "pmmm"
both types are used.

shift

Optional amount of shift if data before fitting/normalizing.

Fields and Methods

Methods:

process Normalizes the data set.

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

ScaleNormalization3

181

ScaleNormalization3

The ScaleNormalization3 class

Description

Package: aroma.affymetrix
Class ScaleNormalization3

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ScaleNormalization3

Directly known subclasses:

public static class ScaleNormalization3
extends ProbeLevelTransform3

This class represents a normalization function that transforms the probe-level signals towards the
same scale.

Usage

ScaleNormalization3(..., targetAvg=4400)

Arguments

...

targetAvg

Arguments passed to the constructor of ProbeLevelTransform3.
A numeric value.

Fields and Methods

Methods:

182

SingleArrayUnitModel

process Normalizes the data set.

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

SingleArrayUnitModel

The SingleArrayUnitModel class

Description

Package: aroma.affymetrix
Class SingleArrayUnitModel

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--SingleArrayUnitModel

SingleArrayUnitModel

Directly known subclasses:

183

public abstract static class SingleArrayUnitModel
extends UnitModel

This abstract class represents a unit model that fits one model per unit based on signals from a single
arrays. The nature of a single-array unit model is that each array can be fitted independently of the
others.

Usage

SingleArrayUnitModel(...)

Arguments passed to UnitModel.

Arguments

...

Fields and Methods

Methods:

fit Estimates the model parameters.

Methods inherited from UnitModel:
findUnitsTodo, getAsteriskTags, getFitSingleCellUnitFunction, getParameters

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

184

SmoothMultiarrayModel

SmoothMultiarrayModel The SmoothMultiarrayModel class

Description

Package: aroma.affymetrix
Class SmoothMultiarrayModel

Object
~~|
~~+--ChromosomalModel
~~~~~~~|
~~~~~~~+--SmoothMultiarrayModel

Directly known subclasses:
SmoothRmaModel, SmoothSaModel

public abstract static class SmoothMultiarrayModel
extends ChromosomalModel

This abstract class represents a chromosomal smoothing method done chromosome by chromo-
some.

Usage

SmoothMultiarrayModel(..., typoOfWeights=c("none", "1/s2"), bandwidth=10000, tags="*")

Arguments

Arguments passed to the constructor of ChromosomalModel.

...
typoOfWeights A character string.
bandwidth
tags

A single numeric specifying the smoothing bandwidth in units of nucleotides.
A character vector of tags to be added.

Fields and Methods

Methods:

getBandwidth
getOutputTuple
setBandwidth

-
-
-

Methods inherited from ChromosomalModel:
as.character, fit, getAlias, getAromaGenomeTextFile, getAsteriskTags, getChipType, getChipTypes,

SmoothRmaModel

185

getChromosomes, getFullName, getFullNames, getGenome, getGenomeData, getGenomeFile, getListO-
fAromaUgpFiles, getName, getNames, getParentPath, getPath, getReportPath, getRootPath, get-
SetTuple, getSets, getTags, indexOf, nbrOfArrays, nbrOfChipTypes, setChromosomes, setGenome,
getListOfGenomeInformations, getPcuTheta, getPositionChipTypeUnit

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

CopyNumberSegmentationModel.

SmoothRmaModel

The SmoothRmaModel class

Description

Package: aroma.affymetrix
Class SmoothRmaModel

Object
~~|
~~+--ChromosomalModel
~~~~~~~|
~~~~~~~+--SmoothMultiarrayModel
~~~~~~~~~~~~|
~~~~~~~~~~~~+--SmoothRmaModel

Directly known subclasses:

public abstract static class SmoothRmaModel
extends SmoothMultiarrayModel

This class represents the Chromosomal Smoothing Robust Multichip Analysis method.

Usage

SmoothRmaModel(...)

186

Arguments

...

SnpChipEffectFile

Arguments passed to the constructor of SmoothMultiarrayModel.

Fields and Methods

Methods:
No methods defined.

Methods inherited from SmoothMultiarrayModel:
as.character, createOutputTuple, fitOneChromosome, getAsteriskTags, getBandwidth, getFitUnit-
GroupFunction, getOutputTuple, getRootPath, setBandwidth

Methods inherited from ChromosomalModel:
as.character, fit, getAlias, getAromaGenomeTextFile, getAsteriskTags, getChipType, getChipTypes,
getChromosomes, getFullName, getFullNames, getGenome, getGenomeData, getGenomeFile, getListO-
fAromaUgpFiles, getName, getNames, getParentPath, getPath, getReportPath, getRootPath, get-
SetTuple, getSets, getTags, indexOf, nbrOfArrays, nbrOfChipTypes, setChromosomes, setGenome,
getListOfGenomeInformations, getPcuTheta, getPositionChipTypeUnit

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

SnpChipEffectFile

The SnpChipEffectFile class

Description

Package: aroma.affymetrix
Class SnpChipEffectFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|

SnpChipEffectFile

187

~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpChipEffectFile

Directly known subclasses:
CnChipEffectFile

public abstract static class SnpChipEffectFile
extends ChipEffectFile

This class represents estimates of chip effects in the probe-level models.

Usage

SnpChipEffectFile(..., mergeStrands=FALSE)

Arguments

...

mergeStrands

Fields and Methods

Methods:

Arguments passed to ChipEffectFile.
Specifies if the strands are merged or not for these estimates.

extractTheta
extractTotalAndFracB
readUnits

-
-
-

Methods inherited from ChipEffectFile:
as.character, extractChromosomalDataFrame, extractMatrix, extractTheta, findUnitsTodo, getAM,
getAsFullCelFile, getCellIndices, getCellMapForMainCdf, getExpandedCellMap, getParameters,
getUnitGroupCellArrayMap, getUnitGroupCellMatrixMap, getXAM, mergeGroups, readUnits, writeAs-
FullCelFile

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

188

SnpChipEffectFile

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

See Also

An object of this class is typically part of a SnpChipEffectSet.

SnpChipEffectSet

189

SnpChipEffectSet

The SnpChipEffectSet class

Description

Package: aroma.affymetrix
Class SnpChipEffectSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ChipEffectSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpChipEffectSet

Directly known subclasses:
CnChipEffectSet

public static class SnpChipEffectSet
extends ChipEffectSet

This class represents estimates of chip effects in the probe-level models.

Usage

SnpChipEffectSet(..., mergeStrands="byFirstFile")

Arguments

...

mergeStrands

Arguments passed to ChipEffectSet.
Specifies if the strands are merged or not for these estimates.

190

Fields and Methods

Methods:

SnpChipEffectSet

extractAlleleSet
extractSnpCnvQSet
extractSnpQSet
extractTheta
extractTotalAndFreqB
getAverageFile
getMergeStrands
setMergeStrands

-
-
-
-
-
-
-
-

Methods inherited from ChipEffectSet:
as.character, boxplotStats, byPath, calculateBaseline, calculateFieldBoxplotStats, calculateNuse-
BoxplotStats, calculateRleBoxplotStats, extractAffyBatch, extractChromosomalDataFrame, extract-
ExpressionSet, extractMatrix, extractTheta, findByName, findUnitsTodo, fromDataSet, getAM,
getAsFullCelSet, getAverageFile, getBaseline, getCellIndices, getXAM, plotBoxplot, readUnits,
updateUnits

Methods inherited from ParameterCelSet:
extractDataFrame, extractMatrix

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,

SnpInformation

191

clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

SnpInformation

The SnpInformation class

Description

Package: aroma.affymetrix
Class SnpInformation

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--SnpInformation

Directly known subclasses:
DChipSnpInformation, UflSnpInformation

192

SnpInformation

public abstract static class SnpInformation
extends FileCacheKeyInterface

Usage

SnpInformation(...)

Arguments

...

Fields and Methods

Methods:

Arguments passed to GenericDataFile.

byChipType
getChipType
getData
getFragmentLengths
getFragmentStarts
getFragmentStops
nbrOfEnzymes
nbrOfUnits
readDataFrame

Static method to define a genome information set by chip type.
Gets the chip type of this genome information set.
Gets all or a subset of the genome information data.
-
-
-
-
-
-

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

SnpPlm

193

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

SnpPlm

The SnpPlm interface class

Description

Package: aroma.affymetrix
Class SnpPlm

Interface
~~|
~~+--SnpPlm

Directly known subclasses:
AffineCnPlm, AffineSnpPlm, AvgCnPlm, AvgSnpPlm, CnPlm, HetLogAddCnPlm, HetLogAddSnpPlm,
MbeiCnPlm, MbeiSnpPlm, RmaCnPlm, RmaSnpPlm

public class SnpPlm
extends Interface

An Interface implementing methods special for ProbeLevelModels specific to SNP arrays.

Usage

SnpPlm(...)

Arguments

...

Methods

Methods:

Not used.

getCellIndices
getChipEffectSet
getMergeStrands

-
-
-

194

SnpPlm

getProbeAffinityFile
setMergeStrands

-
-

Methods inherited from Interface:
extend, print, uses

Requirements

Classes inheriting from this Interface must provide the following fields:

mergeStrands A logical value indicating if strands should be merged or not.

Author(s)

Henrik Bengtsson

Examples

for (zzz in 0) {

# Setup verbose output
verbose <- Arguments$getVerbose(-2)
timestampOn(verbose)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define an example dataset using this path
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Find any SNP dataset
path <- NULL
if (is.null(path))

break

if (!exists("ds")) {

ds <- AffymetrixCelSet$fromFiles(path)

}
print(ds)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create a set of various PLMs for this dataset
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if (!exists("models", mode="list")) {

mergeStrands <- TRUE
models <- list(

rma = RmaSnpPlm(ds, mergeStrands=mergeStrands),
mbei = MbeiSnpPlm(ds, mergeStrands=mergeStrands)
affine = AffineSnpPlm(ds, background=FALSE, mergeStrands=mergeStrands)

#

)

}
print(models)

SnpPlm

195

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# For each model, fit a few units
#
# Note, by fitting the same set of units across models, the internal
# caching mechanisms of aroma.affymetrix makes sure that the data is
# only read into memory once. See log for reading speed.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
units <- 55+1:100

for (model in models) {

ruler(verbose)
fit(model, units=units, force=TRUE, verbose=verbose)

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# For each unit, plot the estimated (thetaB,thetaA) for all models
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Should we plot the on the log scale?
log <- TRUE

# Do only user to press ENTER if more than one unit is plotted
opar <- par(ask=(length(units) > 1))

Alab <- expression(theta[A])
Blab <- expression(theta[B])
if (log) {

lim <- c(6, 16)

} else {

lim <- c(0, 2^15)

}

# For each unit...
for (unit in units) {
# For all models...
for (kk in seq_along(models)) {

ces <- getChipEffects(models[[kk]])
ceUnit <- ces[unit]
snpName <- names(ceUnit)[1]
theta <- ceUnit[[1]]
thetaA <- theta[[1]]$theta
thetaB <- theta[[2]]$theta
if (log) {

thetaA <- log(thetaA, base=2)
thetaB <- log(thetaB, base=2)

}

# Create the plot?
if (kk == 1) {

plot(NA, xlim=lim, ylim=lim, xlab=Blab, ylab=Alab, main=snpName)
abline(a=0, b=1, lty=2)

}

# Plot the estimated parameters

196

SnpProbeAffinityFile

points(thetaB, thetaA, col=kk, pch=19)

}

} # for (unit ...)

# Reset graphical parameter settings
par(opar)

} # for (zzz in 0)
rm(zzz)

SnpProbeAffinityFile

The SnpProbeAffinityFile class

Description

Package: aroma.affymetrix
Class SnpProbeAffinityFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ProbeAffinityFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--SnpProbeAffinityFile

Directly known subclasses:
CnProbeAffinityFile

SnpProbeAffinityFile

197

public abstract static class SnpProbeAffinityFile
extends ProbeAffinityFile

This class represents estimates of probe affinities in SNP probe-level models.

Usage

SnpProbeAffinityFile(..., mergeStrands=FALSE)

Arguments

...

Arguments passed to ProbeAffinityFile.

mergeStrands

Specifies if the strands are merged or not for these estimates.

Fields and Methods

Methods:
No methods defined.

Methods inherited from ProbeAffinityFile:
as.character, getCellIndices, getParameters, readUnits

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,

198

SpatialReporter

setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

SpatialReporter

The SpatialReporter class

Description

Package: aroma.affymetrix
Class SpatialReporter

Object
~~|
~~+--GenericReporter
~~~~~~~|
~~~~~~~+--AffymetrixFileSetReporter
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AffymetrixCelSetReporter
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--SpatialReporter

Directly known subclasses:

public abstract static class SpatialReporter
extends AffymetrixCelSetReporter

A SpatialReporter generates image files of spatial representations of cell signals for each of the
arrays in the input set.

TransformReport

Usage

SpatialReporter(..., reference=NULL)

199

Arguments

...

Arguments passed to AffymetrixCelSetReporter.

reference

An optional reference AffymetrixCelFile.

Fields and Methods

Methods:

addColorMap
getColorMaps
plotMargins
process
setColorMaps

-
-
-
Generates image files, scripts and dynamic pages for the explorer.
-

Methods inherited from AffymetrixCelSetReporter:
as.character, getChipType, getDataSet, getPath, nbrOfArrays

Methods inherited from AffymetrixFileSetReporter:
getFileSet, getInputName, getInputTags

Methods inherited from GenericReporter:
as.character, getAlias, getAsteriskTags, getFullName, getInputName, getInputTags, getMainPath,
getName, getPath, getReportSet, getRootPath, getTags, process, setAlias, setup

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

TransformReport

The TransformReport class

TransformReport

200

Description

Package: aroma.affymetrix
Class TransformReport

Object
~~|
~~+--TransformReport

Directly known subclasses:

public static class TransformReport
extends Object

Usage

TransformReport(inSet=NULL, outSet=NULL, ...)

Arguments

inSet

outSet

...

Fields and Methods

Methods:

The input data set as an AffymetrixCelSet.
The output data set as an AffymetrixCelSet.

Not used.

getCdf
getFullName
getInputDataSet
getName
getOutputDataSet
getPath
getTags
getUnitNamesFile
getUnitTypesFile
getYY
nbrOfArrays
plotXYCurve
plotXYCurveLog2
seq
writeImageCombined
writeImages

-
Gets the full name of the output data set.
Gets the source data set.
Gets the name of the output data set.
Gets the transformed data set.
Gets the path of the output data set.
Gets the tags of the output data set.
-
-
-
-
-
-
-
-
-

UgpGenomeInformation

201

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

UgpGenomeInformation

The UgpGenomeInformation class

Description

Package: aroma.affymetrix
Class UgpGenomeInformation

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--GenomeInformation
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UgpGenomeInformation

Directly known subclasses:

public abstract static class UgpGenomeInformation
extends GenomeInformation

This class represents Aroma UGP genome information files.

Usage

UgpGenomeInformation(..., .ugp=NULL, .verify=TRUE)

UgpGenomeInformation

202

Arguments

...

.ugp

.verify

Fields and Methods

Methods:

Arguments passed to GenomeInformation.
For internal use only.

For internal use only.

byChipType
getChipType
getChromosomes
getData
getUnitsOnChromosome
isCompatibleWithCdf
nbrOfUnits
readDataFrame

Defines a UgpGenomeInformation object by chip type.
-
-
-
-
-
-
-

Methods inherited from GenomeInformation:
as.character, byChipType, fromCdf, fromDataSet, getChipType, getChromosomeStats, getChromo-
somes, getData, getPositions, getUnitIndices, getUnitsOnChromosome, getUnitsOnChromosomes,
isCompatibleWithCdf, nbrOfUnits, plotDensity, readDataFrame, verify

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,

UnitModel

203

equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

UnitModel

The UnitModel class

Description

Package: aroma.affymetrix
Class UnitModel

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--Model
~~~~~~~~~~~~|
~~~~~~~~~~~~+--UnitModel

Directly known subclasses:
AffineCnPlm, AffinePlm, AffineSnpPlm, AlleleSummation, AvgCnPlm, AvgPlm, AvgSnpPlm, Ex-
onRmaPlm, FirmaModel, HetLogAddCnPlm, HetLogAddPlm, HetLogAddSnpPlm, MbeiCnPlm,
MbeiPlm, MbeiSnpPlm, MultiArrayUnitModel, ProbeLevelModel, RmaCnPlm, RmaPlm, RmaS-
npPlm, SingleArrayUnitModel

public abstract static class UnitModel
extends Model

This class is abstract and represents a generic unit model, i.e. a model that is applied to each unit
separately.

Usage

UnitModel(dataSet=NULL, probeModel=c("pm", "mm", "pm-mm", "min1(pm-mm)", "pm+mm"),

shift=0, ...)

Arguments

dataSet

probeModel

An AffymetrixCelSet to which this model should be fitted.
A character string specifying how PM and MM values should be modeled. By
default only PM signals are used.

UnitTypeScaleNormalization

An optional amount the signals should be shifted (translated) before fitting the
model.
Arguments passed to the constructor of Model.

204

shift

...

Fields and Methods

Methods:

findUnitsTodo

Identifies non-fitted units.

Methods inherited from Model:
as.character, fit, getAlias, getAsteriskTags, getDataSet, getFullName, getName, getPath, getRoot-
Path, getTags, setAlias, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson

UnitTypeScaleNormalization

The UnitTypeScaleNormalization class

Description

Package: aroma.affymetrix
Class UnitTypeScaleNormalization

Object
~~|
~~+--ParametersInterface
~~~~~~~|
~~~~~~~+--AromaTransform
~~~~~~~~~~~~|
~~~~~~~~~~~~+--Transform
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--ProbeLevelTransform
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--ProbeLevelTransform3

UnitTypeScaleNormalization

205

~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--UnitTypeScaleNormalization

Directly known subclasses:

public static class UnitTypeScaleNormalization
extends ProbeLevelTransform3

This class represents a normalization function that transforms the probe signals such that each unit
type gets the same average.

Usage

UnitTypeScaleNormalization(..., targetAvg=4400)

Arguments

...

targetAvg

Arguments passed to the constructor of ProbeLevelTransform3.
A numeric value.

Fields and Methods

Methods:

process Normalizes the data set.

Methods inherited from ProbeLevelTransform3:
getAsteriskTags, getCellsTo, getCellsToFit, getCellsToUpdate, getParameters, getUnitsTo, getU-
nitsToFit, getUnitsToUpdate, writeSignals

Methods inherited from ProbeLevelTransform:
getRootPath

Methods inherited from Transform:
getOutputDataSet, getOutputFiles

Methods inherited from AromaTransform:
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames,
getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles,
getPath, getRootPath, getTags, isDone, process, setTags

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

WeightsFile

206

Author(s)

Henrik Bengtsson

WeightsFile

The WeightsFile class

Description

Package: aroma.affymetrix
Class WeightsFile

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFile
~~~~~~~~~~~~|
~~~~~~~~~~~~+--CacheKeyInterface
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--FileCacheKeyInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AromaMicroarrayDataFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParameterCelFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--WeightsFile

Directly known subclasses:

public abstract static class WeightsFile
extends ParameterCelFile

This class represents weights calculated from residuals of probe-level models.

Usage

WeightsFile(..., probeModel=c("pm"))

207

WeightsFile

Arguments

...

probeModel

Fields and Methods

Methods:

Arguments passed to ParameterCelFile.
The specific type of model, e.g. "pm".

findUnitsTodo
getImage
readUnits
writeImage

-
-
-
-

Methods inherited from ParameterCelFile:
extractDataFrame, extractMatrix, readUnits

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelFile:
allocateFromCdf, as.character, clone, createFrom, extractMatrix, fromFile, getAm, getCdf, ge-
tExtensionPattern, getFileFormat, getImage, getUnitNamesFile, getUnitTypesFile, highlight, im-
age270, nbrOfCells, plotDensity, plotImage, plotMvsA, plotMvsX, range, setCdf, smoothScatter-
MvsA, writeImage

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataFile:
getAttributeXY, getChipType, getPlatform, getPloidy, getXAM, hasAttributeXY, isAverageFile, se-
tAttributeXY, setAttributesByTags

Methods inherited from FileCacheKeyInterface:
getCacheKey

Methods inherited from CacheKeyInterface:
getCacheKey

Methods inherited from GenericDataFile:
as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getCheck-
sum, getChecksumFile, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern,
getFileSize, getFileType, getFilename, getFilenameExtension, getLastAccessedOn, getLastModi-
fiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, is.na, isFile,
isGzipped, linkTo, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes,
setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateCheck-
sum, writeChecksum, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-

208

WeightsSet

acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson, Ken Simpson

See Also

An object of this class is typically obtained through the getWeightsSet() method for the ProbeLevelModel
class. An object of this class is typically part of a WeightsSet.

WeightsSet

The WeightsSet class

Description

Package: aroma.affymetrix
Class WeightsSet

Object
~~|
~~+--FullNameInterface
~~~~~~~|
~~~~~~~+--GenericDataFileSet
~~~~~~~~~~~~|
~~~~~~~~~~~~+--AromaMicroarrayDataSet
~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~+--AromaPlatformInterface
~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixFileSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~+--AffymetrixCelSet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--ParametersInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--WeightsSet

209

WeightsSet

Directly known subclasses:

public static class WeightsSet
extends ParametersInterface

This class represents probe-level weights.

Usage

WeightsSet(..., probeModel=c("pm"))

Arguments

...

probeModel

Arguments passed to AffymetrixCelSet.
The specific type of model, e.g. "pm".

Fields and Methods

Methods:

findUnitsTodo
getAverageFile
getCellIndices
readUnits

-
-
-
-

Methods inherited from ParametersInterface:
getParameterSets, getParameters, getParametersAsString

Methods inherited from AffymetrixCelSet:
append, as, as.AffymetrixCelSet, as.character, averageQuantile, byName, byPath, clone, convert-
ToUnique, doCRMAv1, doCRMAv2, doFIRMA, doGCRMA, doRMA, extractAffyBatch, extract-
FeatureSet, extractMatrix, extractSnpFeatureSet, findByName, getAverage, getAverageAsinh, getAver-
ageFile, getAverageLog, getCdf, getChipType, getData, getIntensities, getPlatform, getTimestamps,
getUnitGroupCellMap, getUnitIntensities, getUnitNamesFile, getUnitTypesFile, isDuplicated, jus-
tRMA, justSNPRMA, nbrOfArrays, normalizeQuantile, plotDensity, range, readUnits, setCdf, up-
date2, writeSgr

Methods inherited from AffymetrixFileSet:
as, as.AffymetrixFileSet, byPath, getDefaultFullName

Methods inherited from AromaPlatformInterface:
getAromaPlatform, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, getUnitAnno-
tationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

Methods inherited from AromaMicroarrayDataSet:
as.AromaMicroarrayDataSetList, as.AromaMicroarrayDataSetTuple, getAromaFullNameTransla-
torSet, getAverageFile, getChipType, getDefaultFullName, getPlatform, setAttributesBy, setAt-
tributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, validate

210

WeightsSet

Methods inherited from GenericDataFileSet:
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNames-
TranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslator-
ByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorBy-
function, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache,
clearFullNamesTranslator, clone, copyTo, dsApplyInPairs, duplicated, equals, extract, findByName,
findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName,
getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, get-
Pathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, names, nbrOfFiles, rep, resetFull-
Names, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, val-
idate, getFullNameTranslatorSet, getParentName

Methods inherited from FullNameInterface:
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTab-
ularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBychar-
acter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFull-
NameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFull-
Name, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags,
hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTrans-
lators, setName, setTags, updateFullName

Methods inherited from Object:
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach,
equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstan-
tiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis

Author(s)

Henrik Bengtsson, Ken Simpson

See Also

An object of this class is typically obtained through the getWeightsSet() method for the ProbeLevelModel
class.

Index

∗ IO

ParameterCelFile, 146
ParameterCelSet, 148

∗ classes

AbstractProbeSequenceNormalization,

6

AdditiveCovariatesNormalization, 7
AffineCnPlm, 9
AffinePlm, 11
AffineSnpPlm, 13
AffymetrixCdfFile, 15
AffymetrixCelFile, 17
AffymetrixCelSet, 20
AffymetrixCelSetReporter, 23
AffymetrixCelSetTuple, 24
AffymetrixCnChpSet, 25
AffymetrixFile, 27
AffymetrixFileSet, 29
AffymetrixFileSetReporter, 31
AffymetrixPgfFile, 32
AlleleSummation, 35
AllelicCrosstalkCalibration, 36
AromaChipTypeAnnotationFile, 39
ArrayExplorer, 41
AvgCnPlm, 42
AvgPlm, 44
AvgSnpPlm, 46
BackgroundCorrection, 47
BaseCountNormalization, 49
BasePositionNormalization, 50
ChipEffectFile, 52
ChipEffectSet, 54
ChipEffectTransform, 57
CnagCfhFile, 58
CnagCfhSet, 60
CnChipEffectFile, 62
CnChipEffectSet, 65
CnPlm, 68
CnProbeAffinityFile, 69

211

CrlmmParametersFile, 72
CrlmmParametersSet, 74
DChipCdfBinFile, 76
DChipDcpFile, 78
DChipDcpSet, 80
DChipGenomeInformation, 82
DChipQuantileNormalization, 84
DChipSnpInformation, 86
ExonChipEffectFile, 94
ExonChipEffectSet, 96
ExonProbeAffinityFile, 99
ExonRmaPlm, 101
FirmaFile, 103
FirmaModel, 105
FirmaSet, 106
FragmentEquivalentClassNormalization,

109

FragmentLengthNormalization, 111
GcContentNormalization, 113
GcContentNormalization2, 114
GcRmaBackgroundCorrection, 116
GenericReporter, 118
GenomeInformation, 119
HetLogAddCnPlm, 121
HetLogAddPlm, 123
HetLogAddSnpPlm, 124
LimmaBackgroundCorrection, 127
LinearModelProbeSequenceNormalization,

129

MatNormalization, 131
MatSmoothing, 133
MbeiCnPlm, 134
MbeiPlm, 136
MbeiSnpPlm, 138
Model, 140
MultiArrayUnitModel, 141
NormExpBackgroundCorrection, 143
OpticalBackgroundCorrection, 144
ParameterCelFile, 146

212

INDEX

ParameterCelSet, 148
ProbeAffinityFile, 150
ProbeLevelModel, 153
ProbeLevelTransform, 155
ProbeLevelTransform3, 156
QualityAssessmentFile, 158
QualityAssessmentModel, 160
QualityAssessmentSet, 161
QuantileNormalization, 163
ReseqCrosstalkCalibration, 165
ResidualFile, 167
ResidualSet, 169
RmaBackgroundCorrection, 171
RmaCnPlm, 173
RmaPlm, 175
RmaSnpPlm, 177
ScaleNormalization, 179
ScaleNormalization3, 181
SingleArrayUnitModel, 182
SmoothMultiarrayModel, 184
SmoothRmaModel, 185
SnpChipEffectFile, 186
SnpChipEffectSet, 189
SnpInformation, 191
SnpPlm, 193
SnpProbeAffinityFile, 196
SpatialReporter, 198
TransformReport, 199
UgpGenomeInformation, 201
UnitModel, 203
UnitTypeScaleNormalization, 204
WeightsFile, 206
WeightsSet, 208

∗ methods

justRMA, 126

∗ package

aroma.affymetrix-package, 4

*byChipType, 83, 87
*getCdf, 19

AbstractProbeSequenceNormalization, 6,
49, 51, 129–132, 155, 156
AdditiveCovariatesNormalization, 7, 57,

115

AffineCnPlm, 9, 11, 13, 68, 140, 141, 153,

193, 203

AffinePlm, 10, 11, 13, 14, 140, 141, 153, 203
AffineSnpPlm, 10, 11, 13, 140, 141, 153, 193,

203

AffymetrixCdfFile, 15, 18, 19, 28, 39, 59,

117

AffymetrixCelFile, 17, 20, 22, 28, 52, 62,
70, 94, 99, 103, 146, 147, 151, 158,
167, 187, 196, 199, 206

AffymetrixCelSet, 20, 20, 30, 37, 41, 55, 65,

88, 90–93, 96, 107, 126, 149, 157,
161, 162, 166, 170, 180, 189, 200,
203, 208, 209

AffymetrixCelSetReporter, 23, 31, 118,

198, 199
AffymetrixCelSetTuple, 24
AffymetrixCnChpFile, 26–28
AffymetrixCnChpSet, 25, 30
AffymetrixCsvGenomeInformation, 119
AffymetrixFile, 15, 18, 27, 30, 33, 39, 52,
59, 62, 70, 76–79, 94, 99, 103, 146,
151, 158, 167, 187, 196, 206

AffymetrixFileSet, 20, 26, 29, 29, 32, 55,
65, 80, 81, 96, 107, 149, 161, 169,
189, 208

AffymetrixFileSetReporter, 23, 31, 118,

198

AffymetrixPgfFile, 28, 32, 39
AffymetrixTsvFile, 28
AlleleSummation, 35, 140, 203
AllelicCrosstalkCalibration, 36, 155
aroma.affymetrix

(aroma.affymetrix-package), 4

aroma.affymetrix-package, 4
AromaCellSequenceFile, 7
AromaChipTypeAnnotationFile, 15, 16, 28,

33, 39

AromaMicroarrayDataFile, 15, 18, 28, 32,
39, 52, 59, 62, 70, 76, 78, 94, 99,
103, 146, 151, 158, 167, 186, 196,
206

AromaMicroarrayDataSet, 20, 26, 29, 55, 65,
80, 96, 107, 148, 161, 169, 189, 208

AromaMicroarrayDataSetTuple, 24
AromaPlatformInterface, 15, 18, 20, 26,

28–30, 33, 39, 52, 55, 59, 62, 65, 70,
72, 76, 78, 80, 94, 96, 99, 103, 107,
146, 149, 151, 158, 161, 167, 169,
187, 189, 196, 206, 208

AromaTabularBinaryFile, 72
AromaTabularBinarySet, 74
AromaTransform, 6, 8, 36, 47, 49, 51, 57, 84,

INDEX

213

109, 111, 113, 114, 116, 127, 129,
131, 133, 143, 144, 155, 156, 163,
165, 172, 179, 181, 204
AromaUnitSignalBinaryFile, 72
AromaUnitSignalBinarySet, 74, 75
ArrayExplorer, 41
as.AffymetrixCelSet, 21
as.AffymetrixCnChpSet, 26
as.AffymetrixFileSet, 30
as.CnagCfhSet, 61
as.DChipDcpSet, 81
AvgCnPlm, 42, 44, 46, 68, 140, 141, 153, 193,

203

AvgPlm, 42, 44, 46, 140, 141, 153, 203
AvgSnpPlm, 42–44, 46, 140, 141, 153, 193, 203

backgroundCorrect, 129, 143, 144
BackgroundCorrection, 47, 116, 127, 128,

143, 145, 155, 172

BaseCountNormalization, 6, 49, 155, 156
BasePositionNormalization, 6, 50, 130,

155, 156

bg.adjust, 172
byChipType, 40, 83, 87, 120, 192, 202
byPath, 30

CacheKeyInterface, 15, 18, 28, 32, 39, 52,

58, 62, 69, 72, 76, 78, 82, 86, 94, 99,
103, 119, 146, 151, 158, 167, 186,
191, 196, 201, 206

character, 6, 8, 37, 44, 49, 51, 90–92, 106,
111, 118, 126, 132, 140, 160, 166,
176, 184, 203

ChipEffectFile, 18, 28, 52, 63, 94, 95, 146,

187

ChipEffectGroupMerge, 57
ChipEffectSet, 20, 30, 54, 54, 58, 65, 88, 90,

92, 93, 97, 149, 189

ChipEffectSetTuple, 24
ChipEffectTransform, 8, 57, 109, 111, 113,

114

ChromosomalModel, 184, 185
CnagCfhFile, 28, 58, 61, 62
CnagCfhSet, 60, 60
CnChipEffectFile, 18, 28, 53, 62, 146, 187
CnChipEffectSet, 20, 30, 55, 65, 65, 109,

113, 149, 189

CnChipEffectSetTuple, 24
CnPlm, 10, 42, 43, 68, 121, 135, 174, 193

CnProbeAffinityFile, 18, 28, 69, 146, 151,

196

ColumnNamesInterface, 72
convert, 16
CopyNumberDataFile, 63
CopyNumberDataSet, 65, 66
CopyNumberSegmentationModel, 185
createExonByTranscriptCdf, 16
CrlmmModel, 140
CrlmmParametersFile, 72, 74
CrlmmParametersSet, 74

DChipCdfBinFile, 28, 76
DChipDcpFile, 28, 78, 81, 82
DChipDcpSet, 30, 80, 80
DChipGenomeInformation, 82, 119
DChipQuantileNormalization, 84, 155, 163
DChipSnpInformation, 86, 191
doASCRMAv1 (doCRMAv1), 88
doASCRMAv2 (doCRMAv2), 89
doCRMAv1, 88, 90
doCRMAv2, 89, 89
doFIRMA, 91
doGCRMA, 92
doRMA, 93, 126, 127

ExonChipEffectFile, 18, 28, 53, 94, 146
ExonChipEffectSet, 20, 30, 55, 96, 96, 149
ExonProbeAffinityFile, 18, 28, 99, 146,

151

ExonRmaPlm, 101, 140, 141, 153, 176, 203
Explorer, 41
ExpressionSet, 126
extractAffyBatch, 21
extractDataFrame, 149
extractExpressionSet, 55
extractFeatureSet, 21
extractMatrix, 21, 149

FALSE, 10, 12, 43, 70, 92, 93, 121, 135, 174
FileCacheKeyInterface, 15, 18, 28, 32, 39,
52, 59, 62, 69, 72, 76, 78, 82, 86, 94,
99, 103, 119, 146, 151, 158, 167,
186, 191, 192, 196, 201, 206

findUnitsTodo, 204
FirmaFile, 18, 28, 103, 146
FirmaModel, 91, 105, 140, 203
FirmaSet, 20, 30, 91, 105, 106, 149
fit, 106, 141, 154, 183

214

INDEX

fit.li.wong, 138
fitPLM, 93
FragmentEquivalentClassNormalization,

57, 109

FragmentLengthNormalization, 57, 88, 90,

111

FullNameInterface, 15, 17, 20, 24, 25, 27,

29, 32, 39, 52, 55, 58, 60, 62, 65, 69,
72, 74, 76, 78, 80, 82, 86, 94, 96, 99,
103, 107, 119, 146, 148, 151, 158,
161, 167, 169, 186, 189, 191, 196,
201, 206, 208
function, 8, 109, 111, 113, 147

GcContentNormalization, 57, 113
GcContentNormalization2, 8, 57, 114
gcrma, 92
GcRmaBackgroundCorrection, 48, 92, 116,

155

GenericDataFile, 15, 17, 27, 28, 32, 39, 52,
58, 62, 69, 72, 76, 78, 82, 86, 94, 99,
103, 119, 146, 151, 158, 167, 186,
191, 192, 196, 201, 206
GenericDataFileSet, 20, 25, 29, 30, 55, 60,

61, 65, 74, 80, 96, 107, 148, 161,
169, 189, 208
GenericDataFileSetList, 24
GenericReporter, 23, 31, 32, 118, 198
GenericTabularFile, 72
GenericTabularFileSet, 74
GenomeInformation, 82, 83, 119, 201, 202
getAM, 53, 55
getAverageFile, 21, 61
getCdf, 18, 21, 59, 61
getCellIndices, 16
getChipEffectSet, 36, 154
getChipType, 21, 120, 192
getData, 120, 192
getDataSet, 23, 41, 141
getFirmaSet, 106
getFullName, 141, 200
getGenomeInformation, 16
getHeader, 40
getImage, 18
getInputDataSet, 200
getIntensities, 21
getName, 118, 141, 200
getOutputDataSet, 200
getPath, 141, 200

getPositions, 120
getProbeAffinityFile, 154
getResiduals, 160
getTags, 118, 141, 200
getUnitIntensities, 21
getUnitNames, 16, 33
getUnitTypes, 16
getWeights, 161

HetLogAddCnPlm, 68, 121, 121, 123, 125, 140,

141, 153, 176, 193, 203
HetLogAddPlm, 121, 123, 125, 140, 141, 153,

176, 203

HetLogAddSnpPlm, 121, 123, 124, 140, 141,

153, 176, 193, 203

image270, 18
integer, 37, 88, 90, 92, 93, 117, 128, 172
Interface, 68, 69, 193, 194
isPm, 16

justRMA, 126, 127

LimmaBackgroundCorrection, 48, 127, 143,

155

LinearModelProbeSequenceNormalization,

6, 51, 129, 155, 156

list, 20, 26, 30, 61, 81, 88, 90–93, 128, 142,

147

logical, 63, 66, 69, 88, 90, 102, 166, 194

MatNormalization, 6, 131, 155, 156
matrix, 133
MatSmoothing, 133, 155
MbeiCnPlm, 68, 134, 137, 139–141, 153, 193,

203

MbeiPlm, 12, 13, 135, 136, 138–141, 153, 203
MbeiSnpPlm, 135, 137, 138, 140, 141, 153,

193, 203

Model, 9, 11, 13, 35, 42, 44, 46, 101, 105, 121,

123, 124, 135, 136, 138, 140, 141,
153, 174, 175, 177, 182, 203, 204

MultiArrayUnitModel, 9, 11, 13, 42, 44, 46,
101, 121, 123, 124, 135, 137, 138,
140, 141, 153, 174, 175, 178, 203

nbrOfArrays.AffymetrixCelSet
(AffymetrixCelSet), 20
NormExpBackgroundCorrection, 48, 127,

143, 155

INDEX

215

NULL, 6, 8, 18, 37, 48, 88, 90, 92, 93, 110, 111,

113, 117, 128, 132, 157, 164, 166,
172, 180

numeric, 88, 90, 112, 117, 164, 180, 181, 184,

205

Object, 6, 7, 9, 11, 13, 15, 17, 20, 23–25, 27,
29, 31, 32, 35, 36, 39, 41, 42, 44, 46,
47, 49, 50, 52, 55, 57, 58, 60, 62, 65,
69, 72, 74, 76, 78, 80, 82, 84, 86, 94,
96, 99, 101, 103, 105, 107, 109, 111,
113, 114, 116, 118, 119, 121, 123,
124, 127, 129, 131, 133, 135, 136,
138, 140, 141, 143, 144, 146, 148,
150, 153, 155, 156, 158, 160, 161,
163, 165, 167, 169, 172, 173, 175,
177, 179, 181, 182, 184–186, 189,
191, 196, 198, 200, 201, 203, 204,
206, 208

OpticalBackgroundCorrection, 48, 117,

144, 155

ParameterCelFile, 18, 28, 53, 63, 70, 94, 99,

103, 146, 149, 151, 167, 168, 187,
196, 206, 207

ParameterCelSet, 20, 30, 55, 65, 97, 107,

148, 189

ParametersInterface, 6, 8, 9, 11, 13, 35, 36,
42, 44, 46, 47, 49, 50, 53, 55, 57, 63,
65, 70, 84, 94, 97, 99, 101, 103, 105,
107, 109, 111, 113, 114, 116, 121,
123, 124, 127, 129, 131, 133, 135,
136, 138, 140, 141, 143, 144, 146,
149, 151, 153, 155, 156, 163, 165,
167, 170, 172, 174, 175, 177, 179,
181, 182, 187, 189, 196, 203, 204,
206, 208, 209

plotDensity, 19, 21, 120
plotImage, 19
plotMvsA, 19
plotMvsX, 19
ProbeAffinityFile, 18, 28, 70, 99, 100, 146,

150, 196, 197

ProbeLevelModel, 10–13, 42, 44, 46, 54, 57,
101, 121, 123, 125, 135, 137, 138,
140, 141, 152, 153, 160, 169, 171,
174, 176, 178, 193, 203, 208, 210

ProbeLevelTransform, 6, 36, 37, 48, 49, 51,

84, 116, 127, 129, 131, 133, 143,

145, 155, 156, 157, 163–166, 172,
179–181, 204

ProbeLevelTransform3, 6, 49, 51, 129, 131,
155, 156, 181, 204, 205
process, 7, 9, 38, 41, 48, 85, 110, 112, 114,
117, 118, 128, 132, 134, 145, 164,
166, 173, 180, 182, 199, 205

QualityAssessmentFile, 18, 28, 158
QualityAssessmentModel, 160
QualityAssessmentSet, 20, 30, 160, 161
QuantileNormalization, 84, 85, 155, 163

readUnits, 16
ReseqCrosstalkCalibration, 155, 165
ResidualFile, 18, 28, 146, 167
ResidualSet, 20, 30, 169, 169
RmaBackgroundCorrection, 48, 155, 171
RmaCnPlm, 68, 140, 142, 153, 173, 176, 178,

193, 203

RmaPlm, 93, 101, 102, 121, 123–125, 140, 142,
153, 154, 174, 175, 178, 203
RmaSnpPlm, 140, 142, 153, 174, 176, 177, 193,

203

ScaleNormalization, 155, 179
ScaleNormalization3, 155, 156, 181
setArrays, 41
setCdf, 19, 21, 59, 61
setTags, 141
SingleArrayUnitModel, 140, 182, 203
SmoothMultiarrayModel, 184, 185, 186
SmoothRmaModel, 184, 185
SmoothSaModel, 184
smoothScatterMvsA, 19
SnpChipEffectFile, 18, 28, 53, 63, 146, 186
SnpChipEffectGroupMerge, 57
SnpChipEffectSet, 8, 20, 30, 35, 55, 65, 66,

111, 149, 188, 189

SnpInformation, 86, 191
SnpPlm, 10, 13, 14, 42, 46, 68, 69, 121, 125,

135, 138, 139, 174, 178, 193
SnpProbeAffinityFile, 18, 28, 70, 146, 151,

196

solve, 131
SpatialReporter, 23, 31, 118, 198
SpatialRowColumnNormalization, 155

Transform, 6, 8, 36, 48, 49, 51, 57, 58, 84,
109, 111, 113, 114, 116, 127, 129,

216

INDEX

131, 133, 143, 145, 155, 156, 163,
165, 172, 179, 181, 204

TransformReport, 199
TRUE, 12, 14, 35, 37, 46, 49, 85, 88, 90–93,
117, 125, 128, 139, 153, 172, 178

UflSnpInformation, 191
UgpGenomeInformation, 119, 201
UnitAnnotationDataFile, 15, 33, 76
UnitModel, 9, 11, 13, 35, 42, 44, 46, 101, 105,

106, 121, 123, 124, 135, 137, 138,
140–142, 153, 174, 175, 178, 182,
183, 203
UnitNamesFile, 15, 33, 76
UnitTypeScaleNormalization, 155, 156,

204
UnitTypesFile, 15, 33

vector, 88, 90, 92, 93, 112, 117, 118, 140,

160, 164, 184
Verbose, 88, 90–93, 126

WeightsFile, 18, 28, 146, 206
WeightsSet, 20, 30, 208, 208
writeImage, 19

