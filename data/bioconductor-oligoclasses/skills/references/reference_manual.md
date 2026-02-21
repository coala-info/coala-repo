Package ‘oligoClasses’

February 13, 2026

Version 1.72.0

Title Classes for high-throughput arrays supported by oligo and crlmm

Author Benilton Carvalho and Robert Scharpf

Maintainer Benilton Car-

valho <beniltoncarvalho@gmail.com> and Robert Scharpf <rscharpf@jhsph.edu>

Depends R (>= 2.14)

Imports BiocGenerics (>= 0.27.1), Biobase (>= 2.17.8), methods,
graphics, IRanges (>= 2.5.17), GenomicRanges (>= 1.23.7),
SummarizedExperiment, Biostrings (>= 2.23.6), affyio (>=
1.23.2), foreach, BiocManager, utils, S4Vectors (>= 0.9.25),
RSQLite, DBI, ff

Enhances doMC, doMPI, doSNOW, doParallel, doRedis

Suggests hapmapsnp5, hapmapsnp6, pd.genomewidesnp.6,
pd.genomewidesnp.5, pd.mapping50k.hind240,
pd.mapping50k.xba240, pd.mapping250k.sty, pd.mapping250k.nsp,
genomewidesnp6Crlmm (>= 1.0.7), genomewidesnp5Crlmm (>= 1.0.6),
RUnit, human370v1cCrlmm, VanillaICE, crlmm

Description This package contains class definitions, validity checks, and initialization meth-

ods for classes used by the oligo and crlmm packages.

License GPL (>= 2)

LazyLoad yes

Collate AllClasses.R AllGenerics.R utils-general.R utils-lds.R
utils-parallel.R methods-gSet.R initialize-methods.R
methods-AlleleSet.R methods-AnnotatedDataFrame.R
methods-FeatureSet.R methods-AssayData.R
methods-SnpFeatureSet.R methods-oligoSnpSet.R
methods-CopyNumberSet.R methods-CNSet.R methods-PDInfo.R
methods-RangedDataCNV.R methods-SnpSet.R
methods-GenomeAnnotatedDataFrame.R methods-BeadStudioSet.R
methods-BeadStudioSetList.R methods-gSetList.R
methods-GRanges.R methods-SummarizedExperiment.R show-methods.R
functions.R zzz.R

biocViews Infrastructure
## time-stamp-pattern ``8/Date: %3a %3b %2d %02H:%02M:%02S %Z %:y\n''
RoxygenNote 6.1.1

git_url https://git.bioconductor.org/packages/oligoClasses

1

2

Contents

git_branch RELEASE_3_22

git_last_commit d8ec574

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

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
.
.
.

.
.
.
.
.

.
.
.
.
.
.
.
.

3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
affyPlatforms .
.
4
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
AlleleSet-class
.
.
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
annotationPackages .
.
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
AssayData-methods .
.
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
AssayDataList .
.
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
assayDataList-methods .
.
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
.
batch .
.
.
.
.
.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
batchStatistics .
.
.
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
BeadStudioSet-class
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
BeadStudioSetList-class
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. .
.
celfileDate .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. .
.
celfileName .
.
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
checkExists .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
.
checkOrder
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
chromosome-methods .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
. .
.
chromosome2integer
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
CNSet-class .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
. .
.
CopyNumberSet-class
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
. .
CopyNumberSet-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
. .
.
.
.
createFF .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
db .
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
DBPDInfo-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
. .
.
.
.
Deprecated .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
. .
.
.
efsExample .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
. .
exprs-methods .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
. .
featureDataList-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
.
.
FeatureSet-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
.
.
.
.
ffdf-class
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
. .
.
ff_matrix-class
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
. .
.
ff_or_matrix-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
. .
.
.
fileConnections .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
. .
.
.
.
flags .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
. .
generics .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
GenomeAnnotatedDataFrame-class
GenomeAnnotatedDataFrameFrom-methods . . . . . . . . . . . . . . . . . . . . . . . . 28
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
genomeBuild .
. .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
.
geometry .
. .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
.
.
.
getA .
. .
. .
getBar .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
getSequenceLengths
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
. .
GRanges-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
.
gSet-class .

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

affyPlatforms

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
.
.
.
gSetList-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
.
i2p .
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
.
initializeBigMatrix .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
.
.
.
.
integerMatrix .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
.
.
.
is.ffmatrix .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
.
.
.
isPackageLoaded .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
.
.
.
.
isSnp-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
.
.
.
.
.
kind .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
.
.
.
ldSetOptions
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
.
.
.
length-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
.
.
.
.
.
library2 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
.
.
.
list.celfiles .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
.
.
ListClasses
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
locusLevelData .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
makeFeatureGRanges .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
. .
manufacturer-methods
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
.
.
.
ocLapply .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
.
.
.
ocSamples .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
.
.
.
.
oligoSet
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
oligoSnpSet-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
.
.
parStatus
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
.
.
pdPkgFromBioC .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
.
.
platform-methods .
pmFragmentLength-methods . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
.
position-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
.
requireAnnotation .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
.
requireClusterPkgSet
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
sampleNames-methods .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
.
scqsExample
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
.
.
setCluster
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
.
.
sfsExample .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
.
.
SnpSet-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
.
.
SnpSet2-class .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
.
SnpSuperSet-class .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
.
splitIndicesByLength .
sqsExample .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
.
.
SummarizedExperiment-methods . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59

.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.

.
.
.

.
.
.

.
.
.

.
.
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

61

affyPlatforms

Available Affymetrix platforms for SNP arrays

Description

Provides a listing of available Affymetrix platforms currently supported by the R package oligo

Usage

affyPlatforms()

AlleleSet-class

4

Value

A vector of class character.

Author(s)

R. Scharpf

Examples

affyPlatforms()

AlleleSet-class

Class "AlleleSet"

Description

A class for storing the locus-level summaries of the normalized intensities

Objects from the Class

Objects can be created by calls of the form new("AlleleSet", assayData, phenoData, featureData,
experimentData, annotation, protocolData, ...).

Slots

assayData: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
featureData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAME" ~~
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "eSet", directly. Class "VersionedBiobase", by class "eSet", distance 2. Class "Versioned",
by class "eSet", distance 3.

Methods

allele signature(object = "AlleleSet"): extract allele specific summaries. For 50K (XBA and
Hind) and 250K (Sty and Nsp) arrays, an additional argument (strand) must be used (allowed
values: ’sense’, ’antisense’.

bothStrands signature(object = "AlleleSet"): tests if data contains allele summaries on both

strands for a given SNP.

bothStrands signature(object = "SnpFeatureSet"): tests if data contains allele summaries on

both strands for a given SnpFeatureSet.

db signature(object = "AlleleSet"): link to database connection.
getA signature(object = "AlleleSet"): average intensities (across alleles)
getM signature(object = "AlleleSet"): log-ratio (Allele A vs. Allele B)

5

annotationPackages

Author(s)

R. Scharpf

See Also

SnpSuperSet, CNSet

Examples

showClass("AlleleSet")
## an empty AlleleSet
x <- new("matrix")
new("AlleleSet", senseAlleleA=x, senseAlleleB=x,
antisenseAlleleA=x, antisenseAlleleB=x)

##or
new("AlleleSet", alleleA=x, alleleB=x)

annotationPackages

Annotation Packages

Description

annotationPackages will return a character vector of the names of annotation packages.

Usage

annotationPackages()

Value

a character vector of the names of annotation packages

AssayData-methods

Methods for class AssayData in the oligoClasses package

Description

Batch statistics used for estimating copy number are stored as AssayData in the ’batchStatistics’
slot of the CNSet class. Each element in the AssayData must have the same number of rows and
columns. Rows correspond to features and columns correspond to batch.

Objects from the Class

A virtual Class: No objects may be created from it.

Methods

batchNames signature(object = "AssayData"): ...
batchNames<- signature(object = "AssayData"): ...
corr signature(object = "AssayData", allele = "character"): ...
nu signature(object = "AssayData", allele = "character"): ...
phi signature(object = "AssayData", allele = "character"): ...

6

Details

AssayDataList

lM: Extracts entire list of linear model parameters.
corr: The within-genotype correlation of log2(A) and log2(B) intensities.
nu: The intercept for the linear model. The linear model is fit to the A and B alleles independently.
phi: The slope for the linear model. The linear model is fit independently to the A and B alleles.

See Also

CNSet-class

Examples

library(crlmm)
library(Biobase)
data(cnSetExample, package="crlmm")
cnSet <- cnSetExample
isCurrent(cnSet)
assayDataElementNames(batchStatistics(cnSet))
## Accessors for linear model parameters
## -- Included here primarily as a check that accessors are working
## -- Values are all NA until CN estimation is performed using the crlmm package
##
## subsetting
cnSet[1:10, ]
## names of elements in the object
## accessors for parameters
nu(cnSet, "A")[1:10, ]
nu(cnSet, "B")[1:10, ]
phi(cnSet, "A")[1:10, ]
phi(cnSet, "B")[1:10, ]

AssayDataList

Create a list of assay data elements

Description

The eSetList-derived classes have an assayDataList slot instead of an assayData slot.

Usage

AssayDataList(storage.mode = c("lockedEnvironment", "environment", "list"), ...)

Arguments

storage.mode

See assayDataNew.

Named lists of matrices

...

Value

environment

assayDataList-methods

7

Author(s)

R.Scharpf

See Also

assayDataNew

Examples

r <- replicate(5, matrix(rnorm(25),5,5), simplify=FALSE)
r <- lapply(r, function(x,dns) {dimnames(x) <- dns; return(x)}, dns=list(letters[1:5], LETTERS[1:5]))
ad <- AssayDataList(r=r)
ls(ad)

assayDataList-methods Accessor for slot assayDataList in Package oligoClasses

Description

Accessor for slot assayDataList in Package oligoClasses

Methods

signature(object = "gSetList") An object inheriting from class gSetList.
signature(object = "oligoSetList") An object inheriting from class gSetList.

batch

The batch variable for the samples.

Description

Copy number estimates are susceptible to systematic differences between groups of samples that
were processed at different times or by different labs. While ’batch’ is often unknown, a useful
surrogates is often the scan date of the arrays (e.g., the month of the calendar year) or the 96 well
chemistry plate on which the samples were arrayed during lab processing.

Usage

batch(object)
batchNames(object)
batchNames(object) <- value

Arguments

object

value

An object of class CNSet.

For ’batchNames’, the value must be a character string corresponding of the
unique batch names.

8

Value

batchStatistics

The method ’batch’ returns a character vector that has the same length as the number of samples
in the CNSet object.

Author(s)

R. Scharpf

See Also

CNSet-class

Examples

a <- matrix(1:25, 5, 5)
colnames(a) <- letters[1:5]
object <- new("CNSet", alleleA=a, batch=rep("batch1", 5))
batch(object)
batchNames(object)

batchStatistics

Accessor for batch statistics uses for copy number estimation and stor-
age of model parameters

Description

The batchStatistics slot contains statistics estimated from each batch that are used to derive
copy number estimates.

Usage

batchStatistics(object)
batchStatistics(object) <- value

Arguments

object

value

Details

An object of class CNSet
An object of class AssayData

An object of class AssayData for slot batchStatistics is initialized automatically when creating
a new CNSet instance. Required in the call to new is a factor called batch whose unique values
determine the number of columns for each assay data element.

Value

batchStatics is an accessor for the slot batchStatistics that returns an object of class AssayData.

See Also

CNSet-class, batchNames, batch

BeadStudioSet-class

9

BeadStudioSet-class

Class "BeadStudioSet"

Description

A container for log R ratios and B allele frequencies from SNP arrays.

Objects from the Class

Objects can be created by calls of the form new("BeadStudioSet", assayData, phenoData,
featureData, experimentData, annotation, protocolData, baf, lrr, ...).

Slots

featureData: Object of class "GenomeAnnotatedDataFrame" ~~
assayData: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAxE" ~~
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
genome: Object of class "character" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "gSet", directly. Class "eSet", by class "gSet", distance 2. Class "VersionedBiobase", by
class "gSet", distance 3. Class "Versioned", by class "gSet", distance 4.

Methods

In the methods below, object has class BeadStudioSet.

baf(object): accessor for the matrix of B allele frequencies.
baf(object) <- value replacement method for B allele frequencies: value must be a matrix of

integers.

as(object, "data.frame"): coerce to data.frame with column headers ’lrr’, ’baf’, ’x’ (physical

position with unit Mb), ’id’, and ’is.snp’. Used for plotting with lattice.

copyNumber(object): accessor for log R ratios.
copyNumber(object) <- value: replacement method for the log R ratios
initialize signature(.Object = "BeadStudioSet"): constructs an instance of the class
lrr(object): accessor for matrix of log R ratios
lrr(object) <- value replacement method for log R ratios: value should be a matrix or a

ff_matrix.

show(object): print a short summary of the BeadStudioSet object.
updateObject(object): update a BeadStudioSet object.

BeadStudioSetList-class

10

Author(s)

R. Scharpf

Examples

new("BeadStudioSet")

BeadStudioSetList-class

List classes with assay data listed by chromosome

Description

Container for log R ratios and B allele frequencies stored by chromosome.

Slots

assayDataList: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
featureDataList: Object of class "list" ~~
chromosome: Object of class "integer" ~~
annotation: Object of class "character" ~~
genome: Object of class "character" indicating the genome build. Valid entries are "hg18" and

"hg19".

Methods defined for the class

clone2(object, id, prefix="",...)

Performs a deep copy of the ff objects in the assay data elements of object. A new object of
the same class will be instantiated. The ff objects in the instantiated object will point to ff files
on disk with prefix given by the argument prefix.
A use-case for such a function is that one may want to perform wave correction on the log
R ratios in object, but keep a copy of the original unadjusted log R ratios. If object is not
copied using clone2 prior to wave correction, the log R ratios will be updated on disk and the
original, unadjusted log R ratios will no longer be available.

Accessors

baf(object)An accessor for the B allele frequencies (BAFs). The accessor returns a list where
each element of the list is a matrix of the BAFs for the corresponding element in the SetList
object. While the BAFs have a range [0, 1], they are often saved internally as integers by
multiplying the original BAFs by 1000. Users can restore the original scale by dividing by
1000.

lrr(object) An accessor for the log R ratios, an estimate of the copy number (presumably rela-
tive to diploid copy number) at each marker on a SNP array. The accessor returns a list where
each element of the list is a matrix of the log R ratios for the corresponding element in the
SetList object. The log R ratios are often saved internally as integers by multiplying the orig-
inal LRRs by 100 in order to reduce the memory footprint of large studies. Users can restore
the original scale by dividing by 100.

11

celfileDate

Author(s)

R. Scharpf

See Also

See supporting packages for methods defined for the class.

celfileDate

Cel file dates

Description

Parses cel file dates from the header of .CEL files for the Affymetrix platform

Usage

celfileDate(filename)

Name of cel file

Arguments

filename

Value

character string

Author(s)

H. Jaffee

Examples

require(hapmapsnp6)
path <- system.file("celFiles", package="hapmapsnp6")
celfiles <- list.celfiles(path, full.names=TRUE)
dts <- sapply(celfiles, celfileDate)

celfileName

Extracts complete cel file name from a CNSet object

Description

Returns the complete cel file (including path) for a CNSet object

Usage

celfileName(object)

Arguments

object

An object of class CNSet

12

Value

Character string vector.

Note

checkExists

If the CEL files for an experiment are relocated, the datadir should be updated accordingly. See
examples.

Author(s)

R. Scharpf

Examples

## Not run:

if(require(crlmm)){

data(cnSetExample, package="crlmm")

celfileName(cnSetExample)

}

## End(Not run)

checkExists

Checks to see whether an object exists and, if not, executes the appro-
priate function.

Description

Only loads an object if the object name is not in the global environment.
environment and the file exists, the object is loaded (by default).
function FUN is run.

If not in the global
If the file does not exist, the

Usage

checkExists(.name, .path = ".", .FUN, .FUN2, .save.it=TRUE, .load.it, ...)

Arguments

.name

.path

.FUN

.FUN2

.save.it

.load.it

Character string giving name of object in global environment

Path to where the object is saved.

Function to be executed if <name> is not in the global environment and the file
does not exist.

Not currently used.
Logical. Whether to save the object to the directory indicaged by path. This
argument is ignored if the object was loaded from file or already exists in the
.GlobalEnv.
Logical. If load.it is TRUE, we try to load the object from the indicated path.
The returned object will replace the object in the .GlobalEnv unless the object is
bound to a different name (symbol) when the function is executed.

...

Additional arguments passed to FUN.

checkOrder

Value

13

Could be anything – depends on what FUN, FUN2 perform.

Future versions could return a 0 or 1 indicating whether the function performed as expected.

Author(s)

R. Scharpf

Examples

path <- tempdir()
dir.create(path)
x <- 3+6
x <- checkExists("x", .path=path, .FUN=function(y, z) y+z, y=3, z=6)
rm(x)
x <- checkExists("x", .path=path, .FUN=function(y, z) y+z, y=3, z=6)
rm(x)
x <- checkExists("x", .path=path, .FUN=function(y, z) y+z, y=3, z=6)
rm(x)
##now there is a file called x.rda in tempdir(). The file will be loaded
x <- checkExists("x", .path=path, .FUN=function(y, z) y+z, y=3, z=6)
rm(x)
unlink(path, recursive=TRUE)

checkOrder

Checks whether a eSet-derived class is ordered by chromosome and
physical position

Description

Checks whether a eSet-derived class (e.g., a SnpSet or CNSet object) is ordered by chromosome
and physical position

Usage

checkOrder(object, verbose = FALSE)
chromosomePositionOrder(object, ...)

Arguments

object

verbose

...

Details

A SnpSet or CopyNumberSet.

Logical.
additional arguments to order

Checks whether the object is ordered by chromosome and physical position.

Value

Logical

chromosome-methods

14

Author(s)

R. Scharpf

See Also

order

Examples

data(oligoSetExample)
if(!checkOrder(oligoSet)){

oligoSet <- chromosomePositionOrder(oligoSet)

}
checkOrder(oligoSet)

chromosome-methods

Methods for function chromosome in package oligoClasses

Description

Methods for function chromosome in package oligoClasses ~~

Methods

The methods for chromosome extracts the chromosome (represented as an integer) for each marker
in a eSet-derived class or a AnnotatedDataFrame-derived class.

signature(object = "AnnotatedDataFrame") Accessor for chromosome.
signature(object = "eSet") If ’chromosome’ is included in fvarLabels(object), the integer

representation of the chromosome will be returned. Otherwise, an error is thrown.

signature(object = "GenomeAnnotatedDataFrame") Accessor for chromosome. If annotation
was not available due to a missing or non-existent annotation package, the value returned by
the accessor will be a vector of zero’s.

(chromosome(object) <- value): Assign chromosome to the AnnotatedDataFrame slot of an

eSet-derived object.

signature(object = "RangedDataCNV") Accessor for chromosome.

Note

Integer representation: chr X = 23, chr Y = 24, chr XY = 25. Symbols M, Mt, and MT are coded as
26.

See Also

chromosome2integer

Examples

chromosome2integer(c(1:22, "X", "Y", "XY", "M"))

chromosome2integer

15

chromosome2integer

Converts chromosome to integer

Description

Coerces character string for chromosome in the pd. annotation packages to integers

Usage

chromosome2integer(chrom)

integer2chromosome(intChrom)

Arguments

chrom

intChrom

Details

A one or 2 letter character string (e.g, "1", "X", "Y", "MT", "XY")

An integer vector with values 1-25 possible

This is useful when sorting SNPs in an object by chromosome and physical position – ensures that
the sorting is done in the same way for different objects.

Value

integer2chromosome returns a vector of character string indicating the chromosome the same
length as intChrom. chromosome2integer returns a vector of integers the same length as the
number of elements in the chrom vector.

Author(s)

R. Scharpf

Examples

chromosome2integer(c(1:22, "X", "Y", "XY", "M"))
integer2chromosome(chromosome2integer(c(1:22, "X", "Y", "XY", "M")))

CNSet-class

Class "CNSet"

Description

CNSet is a container for intermediate data and parameters pertaining to allele-specific copy number
estimation. Methods for CNSet objects, including accessors for linear model parameters and allele-
specific copy number are included here.

16

Objects from the Class

CNSet-class

An object from the class is not generally intended to be initialized by the user, but returned by the
genotype function in the crlmm package.
The following creates a very basic CNSet with assayData containing the required elements.
new(CNSet, alleleA=new("matrix"), alleleB=new("matrix"), call=new("matrix"), callProbability=new("matrix"),
batch=new("factor"))

Slots

batch: Object of class "factor" ~~
batchStatistics: Object of class "AssayData" ~~
assayData: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
featureData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAME" ~~
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
datadir: Object of class "list"~~
mixtureParams: Object of class "matrix"~~
.__classVersion__: Object of class "Versions" ~~

Methods

The argument object for the following methods is a CNSet.

object[i, j]: subset the CNSet object by markers (i) and/or samples (j).
A(objet): accessor for the normalized intensities of allele A
A(object) <- value: replace intensities for the A allele intensities by value. The object value

must be a matrix, ff_matrix, or ffdf.

allele(object, allele): accessor for the normalized intensities for the A or B allele. The

argument for allele must be either ’A’ or ’B’

B(objet): accessor for the normalized intensities of allele B
B(object) <- value: replace intensities for the B allele intensities by value. The object value

must be a matrix, ff_matrix, or ffdf.

batch(object): vector of batch labels for each sample.
batchNames(object): the unique batch names
batchNames(object) <- value: relabel the batches
calls(object): accessor for genotype calls coded as 1 (AA), 2 (AB), or 3 (BB). Nonpolymorphic

markers are NA.

confs(object): accessor for the genotype confidence scores.
close(object): close any open file connections to ff objects stored in the CNSet object.
as(object, "oligoSnpSet"): coerce a CNSet object to an object of class oligoSnpSet – a con-

tainer for the total copy number and genotype calls.

corr(object): the correlation of the A and B intensities within each genotype.

CopyNumberSet-class

17

flags(object): flags to indicate possible problems with the copy number estimation. Not fully

implemented at this point.

new("CNSet"): instantiating a CNSet object.
nu(object, allele): accessor for the intercept (background) for the A and B alleles. The value

of allele must be ’A’ or ’B’.

open(object) open file connections for all ff objects stored in the CNSet object.
nu(object, allele): accessor for the slope for the A and B alleles. The value of allele must

be ’A’ or ’B’.

sigma2(object, allele): accessor for the within genotype variance
tau2(object, allele): accessor for background variance

Author(s)

R. Scharpf

Examples

new("CNSet")

CopyNumberSet-class

Class "CopyNumberSet"

Description

Container for storing total copy number estimates and confidence scores of the copy number esti-
mates.

Objects from the Class

Objects can be created by calls of the form new("CopyNumberSet", assayData, phenoData,
featureData, experimentData, annotation, protocolData, copyNumber, cnConfidence, ...).

Slots

assayData: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
featureData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAxE" ~~
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "eSet", directly. Class "VersionedBiobase", by class "eSet", distance 2. Class "Versioned",
by class "eSet", distance 3.

18

Methods

CopyNumberSet-methods

cnConfidence signature(object = "CopyNumberSet"): ...
cnConfidence<- signature(object = "CopyNumberSet", value = "matrix"): ...
coerce signature(from = "CNSet", to = "CopyNumberSet"): ...
copyNumber signature(object = "CopyNumberSet"): ...
copyNumber<- signature(object = "CopyNumberSet", value = "matrix"): ...
initialize signature(.Object = "CopyNumberSet"): ...

Note

This container is primarily for platforms for which genotypes are unavailable. As oligoSnpSet
extends this class, methods related to total copy number that do not depend on genotypes can be
defined at this level.

Author(s)

R. Scharpf

See Also

For genotyping platforms, total copy number estimates and genotype calls can be stored in the
oligoSnpSet class.

Examples

showClass("CopyNumberSet")
cnset <- new("CopyNumberSet")
ls(Biobase::assayData(cnset))

CopyNumberSet-methods Methods for class CopyNumberSet.

Description

Accessors and CopyNumberSet

Usage

copyNumber(object, ...)
cnConfidence(object)
copyNumber(object) <- value
cnConfidence(object) <- value

Arguments

object

...

value

CopyNumberSet object or derived class
Ignored for CopyNumberSet and oligoSnpSet.

matrix

CopyNumberSet-methods

Value

19

copyNumber returns a matrix of copy number estimates or relative copy number estimates. Since
the copy number estimates are stored as integers (copy number * 100), the matrix returned by the
copyNumber accessor will need to be divided by a factor of 100 to transform the measurements back
to the original copy number scale.

cnConfidence returns a matrix of confidence scores for the copy number estimates. These are also
represented as integers and will require a back-transformation to the original scale.

Examples

library(Biobase)
data(locusLevelData)
path <- system.file("extdata", package="oligoClasses")
fd <- readRDS(file.path(path, "genomeAnnotatedDataFrameExample.rds"))
## the following command creates an 'oligoSnpSet' object, storing
## an integer representation of the log2 copy number in the 'copyNumber' element
## of the assayData. Genotype calls and genotype confidence scores are also stored
## in the assayData.
oligoSet <- new("oligoSnpSet",

copyNumber=integerMatrix(log2(locusLevelData[["copynumber"]]/100), 100),
call=locusLevelData[["genotypes"]],
callProbability=integerMatrix(locusLevelData[["crlmmConfidence"]], 1),
annotation=locusLevelData[["platform"]],
featureData=fd,
genome="hg19")

## There are several accessors for the oligoSnpSet class.
icn <- copyNumber(oligoSet)
range(icn) ## integer scale
lcn <- icn/100
range(lcn) ## log2 copy number

## confidence scores for the genotypes are also represented on an integer scale
ipr <- snpCallProbability(oligoSet)
range(ipr) ## integer scale

## for genotype confidence scores, the helper function i2p
## converts back to a probability scale
pr <- i2p(ipr)
range(pr)

## The helper function confs is a shortcut, extracting the
## integer-based confidence scores and transforming to the
## probability scale
pr2 <- confs(oligoSet)
all.equal(pr, pr2)

## To extract information on the annotation of the SNPs, one can use
position(oligoSet)
chromosome(oligoSet)
## the position and chromosome coordinates were extracted from build hg19
genomeBuild(oligoSet)

20

db

createFF

Create ff objects.

Description

Creates ff objects (array-like) using settings (path) defined by oligoClasses.

Usage

createFF(name, dim, vmode = "double", initdata = NULL)

Prefix for filename.

Dimensions.

Mode.

NULL.

Arguments

name

dim

vmode

initdata

Value

ff object.

Note

This function is meant to be used by developers.

See Also

ff

db

Get the connection to the SQLite Database

Description

This function will return the SQLite connection to the database associated to objects used in oligo.

Usage

db(object)

Arguments

object

Value

Object of valid class. See methods.

SQLite connection.

21

DBPDInfo-class

Methods

object = "FeatureSet" object of class FeatureSet

object = "SnpCallSet" object of class SnpCallSet

object = "DBPDInfo" object of class DBPDInfo

object = "SnpLevelSet" object of class SnpLevelSet

Author(s)

Benilton Carvalho

Examples

## db(object)

DBPDInfo-class

Class "DBPDInfo"

Description

A class for Platform Design Information objects, stored using a database approach

Objects from the Class

Objects can be created by calls of the form new("DBPDInfo", ...).

Slots

getdb: Object of class "function"
tableInfo: Object of class "data.frame"
manufacturer: Object of class "character"
genomebuild: Object of class "character"
geometry: Object of class "integer" with length 2 (rows x columns)

Methods

annotation string describing annotation package associated to object

Deprecated

oligoClasses Deprecated

Description

The function, class, or data object you asked for has been deprecated.

22

featureDataList-methods

efsExample

ExpressionFeatureSet Object

Description

Example of ExpressionFeatureSet Object.

Usage

data(efsExample)

Format

Object belongs to ExpressionFeatureSet class.

Examples

data(efsExample)
class(efsExample)

exprs-methods

Accessor for the ’exprs’ slot

Description

Accessor for the ’exprs’/’se.exprs’ slot of FeatureSet-like objects

Methods

object = "ExpressionSet" Expression matrix for objects of this class. Usually results of prepro-

cessing algorithms, like RMA.

object = "FeatureSet" General container ’exprs’ inherited from eSet

object = "SnpSet" General container ’exprs’ inherited from eSet, not yet used.

featureDataList-methods

Accessor for slot featureDataList in Package oligoClasses ~~

Description

Accessor for slot featureDataList in Package oligoClasses ~~

Methods

signature(object = "gSetList") An object inheriting from class gSetList.

FeatureSet-class

23

FeatureSet-class

"FeatureSet" and "FeatureSet" Extensions

Description

Classes to store data from Expression/Exon/SNP/Tiling arrays at the feature level.

Objects from the Class

The FeatureSet class is VIRTUAL. Therefore users are not able to create instances of such class.
Objects for FeatureSet-like classes can be created by calls of the form: new(CLASSNAME, assayData,
manufacturer, platform, exprs, phenoData, featureData, experimentData, annotation, ...).
But the preferred way is using parsers like read.celfiles and read.xysfiles.

Slots

manufacturer: Object of class "character"
assayData: Object of class "AssayData"
phenoData: Object of class "AnnotatedDataFrame"
featureData: Object of class "AnnotatedDataFrame"
experimentData: Object of class "MIAME"
annotation: Object of class "character"
.__classVersion__: Object of class "Versions"

Methods

show signature(.Object = "FeatureSet"): show object contents
bothStrands signature(.Object = "SnpFeatureSet"): checks if object contains data for both
strands simultaneously (50K/250K Affymetrix SNP chips - in this case it returns TRUE); if
object contains data for one strand at a time (SNP 5.0 and SNP 6.0 - in this case it returns
FALSE)

Author(s)

Benilton Carvalho

See Also

eSet, VersionedBiobase, Versioned

Examples

set.seed(1)
tmp <- 2^matrix(rnorm(100), ncol=4)
rownames(tmp) <- 1:25
colnames(tmp) <- paste("sample", 1:4, sep="")
efs <- new("ExpressionFeatureSet", exprs=tmp)

24

ff_matrix-class

ffdf-class

Class "ffdf"

Description

Extended package ff’s class definitions for ff to S4.

Objects from the Class

A virtual Class: No objects may be created from it.

Slots

.S3Class: Object of class ffdf ~~

Extends

Class "oldClass", directly. Class "list_or_ffdf", directly.

Methods

No methods defined with class "ffdf" in the signature.

ff_matrix-class

Class "ff_matrix"

Description

~~ A concise (1-5 lines) description of what the class is. ~~

Objects from the Class

A virtual Class: No objects may be created from it.

Slots

.S3Class: Object of class "character" ~~

Extends

Class "oldClass", directly.

Methods

annotatedDataFrameFrom signature(object = "ff_matrix"): ...

Examples

showClass("ff_matrix")

ff_or_matrix-class

25

ff_or_matrix-class

Class "ff_or_matrix"

Description

A class union of ’ffdf’, ’ff_matrix’, and ’matrix’

Objects from the Class

A virtual Class: No objects may be created from it.

Methods

GenomeAnnotatedDataFrameFrom signature(object = "ff_or_matrix"): ...

Author(s)

R. Scharpf

See Also

ff, ffdf

Examples

showClass("ff_or_matrix")

fileConnections

Open and close methods for matrices and numeric vectors

Description

CNSet objects can contain ff-derived objects that contain pointers to files on disk, or ordinary
matrices. Here we define open and close methods for ordinary matrices and vectors that that simply
pass back the original matrix/vector.

Usage

open(con, ...)
openff(object)
closeff(object)

Arguments

con

object

...

Value

not applicable

matrix or vector
A CNSet object.
Ignored

26

Author(s)

R. Scharpf

Examples

open(rnorm(15))
open(matrix(rnorm(15), 5,3))

flags

flags

Batch-level summary of SNP flags.

Description

Used to flag SNPs with low minor allele frequencies, or for possible problems during the CN esti-
mation step. Currently, this is primarily more for internal use.

Usage

flags(object)

Arguments

object

An object of class CNSet

Value

A matrix or ff_matrix object with rows corresponding to markers and columns corresponding to
batch.

See Also

batchStatistics

Examples

x <- matrix(runif(250*96*2, 0, 2), 250, 96*2)
test1 <- new("CNSet", alleleA=x, alleleB=x, call=x, callProbability=x,

batch=as.character(rep(letters[1:2], each=96)))

dim(flags(test1))

generics

generics

Description

27

Miscellaneous generics. Methods defined in packages that depend on
oligoClasses

Miscellaneous generics. Methods defined in packages that depend on oligoClasses

Usage

baf(object)
lrr(object)

Arguments

object

Author(s)

R. Scharpf

A eSet-derived class.

GenomeAnnotatedDataFrame-class

Class "GenomeAnnotatedDataFrame"

Description

AnnotatedDataFrame with genomic coordinates (chromosome, position)

Slots

varMetadata: Object of class "data.frame" ~~
data: Object of class "data.frame" ~~
dimLabels: Object of class "character" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "AnnotatedDataFrame", directly. Class "Versioned", by class "AnnotatedDataFrame", dis-
tance 2.

Coercion to or from other classes

as(from, "GenomeAnnotatedDataFrame"):

Coerce an object of class AnnotatedDataFrame to a GenomeAnnotatedDataFrame.

makeFeatureGRanges(object, genome, ...):

Construct a GRanges instance from a GenomeAnnotatedDataFrame object. genome is a char-
acter string indicating the UCSC build. Supported builds are "hg18" and "hg19", but are
platform specific. In particular, some platforms only support build hg19 at this time.

updateObject(object):

For updating a GenomeAnnotatedDataFrame

28

Accessors

GenomeAnnotatedDataFrameFrom-methods

chromosome(object), chromosome(object) <- value

Get or set chromosome.

isSnp(object):

Many platforms include polymorphic and nonpolymorphic markers. isSnp evalutes to TRUE if
the marker is polymorphic.

position(ojbect):

Physical position in the genome

getArm(object, genome):

Retrieve character vector indicating the chromosome arm of each marker in object. genome
should indicate which genome build was used to define the chromosomal locations (currently,
only UCSC genome builds ’hg18’ and ’hg19’ supported for this function).

Author(s)

R. Scharpf

GenomeAnnotatedDataFrameFrom-methods

Methods for Function GenomeAnnotatedDataFrameFrom in Package
oligoClasses

Description

GenomeAnnotatedDataFrameFrom is a convenience for creating GenomeAnnotatedDataFrame ob-
jects.

Methods

Use the method with GenomeAnnotatedDataFrameFrom(object, annotationPkg, genome, ...);
the argument annotationPkg must be specified for matrix and AssayData classes.

signature(object="assayData") This method creates an GenomeAnnotatedDataFrame using

feature names and dimensions of an AssayData object as a template.

signature(object="matrix") This method creates an GenomeAnnotatedDataFrame using row

names and dimensions of a matrix object as a template.

signature(object="NULL") This method (called with ’NULL’ as the object) creates an empty

GenomeAnnotatedDataFrame.

signature(object="array") This method (called with ’array’ as the object) creates a GenomeAn-
notatedDataFrame using the first dimension of the array (rows are the number of features).

Author(s)

R Scharpf

genomeBuild

Examples

29

require(Biobase)
minReqVersion <- "1.0.2"
require(human370v1cCrlmm)
if (packageDescription("human370v1cCrlmm", fields='Version') >= minReqVersion){
x <- matrix(1:25, 5, 5,

dimnames=list(c("rs10000092","rs1000055", "rs100016", "rs10003241", "rs10004197"), NULL))

gd <- GenomeAnnotatedDataFrameFrom(x, annotationPkg="human370v1cCrlmm",

genome="hg18")

pData(gd)
chromosome(gd)
position(gd)
}

genomeBuild

Genome Build Information

Description

Returns the genome build. This information comes from the annotation package and is given as an
argument during the package creation process.

Usage

genomeBuild(object)

Supported objects include PDInfo, FeatureSet, and any gSet-derived or eSetList-
derived object.

Arguments

object

Value

character string

Note

Supported builds are UCSC genome builds are ’hg18’ and ’hg19’.

Examples

showMethods("genomeBuild", where="package:oligoClasses")

30

getA

geometry

Array Geometry Information

Description

For a given array, geometry returns the physical geometry of it.

Usage

geometry(object)

Arguments

object

Examples

PDInfo or FeatureSet object

if (require(pd.mapping50k.xba240))
geometry(pd.mapping50k.xba240)

getA

Compute average log-intensities / log-ratios

Description

Methods to compute average log-intensities and log-ratios across alleles, within strand.

Usage

getA(object)
getM(object)
A(object, ...)
B(object, ...)

Arguments

object

...

Details

SnpQSet, SnpCnvQSet or TilingFeatureSet2 object.
arguments to be passed to allele - ’sense’ and ’antisense’ are valid values if
the array is pre-SNP_5.0

For SNP data, SNPRMA summarizes the SNP information into 4 quantities (log2-scale):

• antisenseThetaAantisense allele A. (Not applicable for Affymetrix 5.0 and 6.0 platforms.)

• antisenseThetaBantisense allele B. (Not applicable for Affymetrix 5.0 and 6.0 platforms.)

• senseThetaAsense allele A. (Not applicable for Affymetrix 5.0 and 6.0 platforms.)

• senseThataBsense allele B. (Not applicable for Affymetrix 5.0 and 6.0 platforms.)

• alleleAAffymetrix 5.0 and 6.0 platforms

getBar

31

• alleleBAffymetrix 5.0 and 6.0 platforms

The average log-intensities are given by: (antisenseThetaA+antisenseThetaB)/2 and (senseThetaA+senseThetaB)/2.
The average log-ratios are given by: antisenseThetaA-antisenseThetaB and senseThetaA-senseThetaB.
For Tiling data, getM and getA return the log-ratio and average log-intensities computed across
channels: M = log2(channel1)-log2(channel2) A = (log2(channel1)+log2(channel2))/2
When large data support is enabled with the ff package, the AssayData elements of an AlleleSet
object can be ff_matrix or ffdf, in which case pointers to the ff object are stored in the assay data.
The functions open and close can be used to open or close the connection, respectively.

Value

A 3-dimensional array (SNP’s x Samples x Strand) with the requested measure, when the input SNP
data (50K, 250K).

A 2-dimensional array (SNP’s x Samples), when the input is from SNP 5.0 and SNP 6.0 arrays.

A 2-dimensional array if the input is from Tiling arrays.

See Also

snprma

getBar

Gets a bar of a given length.

Description

Gets a bar of a given length.

Usage

getBar(width = getOption("width"))

Arguments

width

Value

desired length of the bar.

character string.

Author(s)

Benilton S Carvalho

Examples

message(getBar())

32

getSequenceLengths

getSequenceLengths

Load chromosome sequence lengths for UCSC genome build hg18 or
hg19

Description

Load chromosome sequence lengths for UCSC genome build hg18 or hg19

Usage

getSequenceLengths(build)

Arguments

build

Details

character string: "hg18" or "hg19"

The chromosome sequence lengths for UCSC builds hg18 and hg19 were extracted from the pack-
ages BSgenome.Hsapiens.UCSC.hg18 and BSgenome.Hsapiens.UCSC.hg19, respectively.

Value

Names integer vector of chromosome lengths.

Author(s)

R. Scharpf

Examples

getSequenceLengths("hg18")
getSequenceLengths("hg19")

if(require("GenomicRanges")){
## from GenomicRanges

sl <- getSequenceLengths("hg18")[c("chr1", "chr2", "chr3")]
gr <-
GRanges(seqnames =
Rle(c("chr1", "chr2", "chr1", "chr3"), c(1, 3, 2, 4)),
ranges =
IRanges(1:10, width = 10:1, names = head(letters,10)),
strand =
Rle(strand(c("-", "+", "*", "+", "-")),

c(1, 2, 2, 3, 2)),

score = 1:10,
GC = seq(1, 0, length=10),
seqlengths=sl)

metadata(gr) <- list(genome="hg18")
gr
metadata(gr)

}

GRanges-methods

33

GRanges-methods

Methods for GRanges objects

Description

Methods for GRanges objects

findOverlaps methods

findOverlaps(query, subject, ...):

Find the feature indices in subject that overlap the genomic intervals in query, where query
is a GRanges object and subject is a gSet-derived object. Additional arguments to the findOverlaps
method in the package IRanges can be passed through the ... operator.

Accessors

object is an instance of the GRanges class.

coverage2(object):

For the GRanges and GRangesList objects returned by the hidden Markov model implemented
in the "VanillaICE" package and the segmentation algorithm in the "MinimumDistance" pack-
age, the intervals are annotated by the number of probes (markers) for SNPs and nonpolymor-
phic regions. coverage2 and numberProbes are convenient accessors for these annotations.

genomeBuild(object):

Accessor for the UCSC genome build.

numberProbes(object):

Integer vector indicating the number of probes (markers) for each range in object. Equivalent
to coverage2.

state(object):

Accessor for the elementMetadata column ’state’, when applicable. State is used to contain
the index of the inferred copy number state for various hmm methods defined in the VanillaICE.

See Also

GRanges

Examples

library(IRanges)
library(GenomicRanges)
gr1 <- GRanges(seqnames = "chr2", ranges = IRanges(3, 6),
state=3L, numberProbes=100L)
## convenience functions
state(gr1)
numberProbes(gr1)

gr2 <- GRanges(seqnames = c("chr1", "chr1"),
ranges = IRanges(c(7,13), width = 3),
state=c(2L, 2L), numberProbes=c(200L, 250L))
gr3 <- GRanges(seqnames = c("chr1", "chr2"),
ranges = IRanges(c(1, 4), c(3, 9)),

34

gSet-class

state=c(1L, 4L), numberProbes=c(300L, 350L))
## Ranges organized by sample
grl <- GRangesList("sample1" = gr1, "sample2" = gr2, "sample3" = gr3)
sampleNames(grl) ## same as names(grl)
numberProbes(grl)
chromosome(grl)
state(grl)
gr <- stack(grl)
sampleNames(gr)
chromosome(gr)
state(gr)

gSet-class

Container for objects with genomic annotation on SNPs

Description

Container for objects with genomic annotation on SNPs

Objects from the Class

A virtual Class: No objects may be created from it.

Slots

featureData: Object of class "GenomeAnnotatedDataFrame" ~~
assayData: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAxE" ~~
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
genome: Object of class "character" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "eSet", directly. Class "VersionedBiobase", by class "eSet", distance 2. Class "Versioned",
by class "eSet", distance 3.

Methods

The object for the below methods is a class that extends the virtual class gSet.

checkOrder(object): checks that the object is ordered by chromosome and physical position.

Returns logical.

chromosome(object): accessor for chromosome in the GenomeAnnotatedDataFrame slot.
chromosome(object) <- value: replacement method for chromosome in the GenomeAnnotatedDataFrame

slot. value must be an integer vector.

db(object): database connection

gSetList-class

35

genomeBuild(object), genomeBuild(object) <- value:

Get or set the UCSC genome build. Supported builds are hg18 and hg19.

getArm(object): Character vector indicating the chromosomal arm for each marker in object.
isSnp(object): whether the marker is polymorphic. Returns a logical vector.
makeFeatureGRanges(object): Construct an instance of the GRanges class from a GenomeAnnotatedDataFrame.
position(object): integer vector of the genomic position
show(object):

Print a concise summary of object.

Author(s)

R. Scharpf

See Also

chromosome, position, isSnp

Examples

showClass("gSet")

gSetList-class

Virtual Class for Lists of eSets

Description

Virtual Class for Lists of eSets.

Objects from the Class

A virtual Class: No objects may be created from it.

Slots

assayDataList: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAME" ~~
featureDataList: Object of class "list" ~~
chromosome: Object of class "vector" ~~
annotation: Object of class "character" ~~
genome: Object of class "character" ~~

36

Accessors

i2p

object is an instance of a gSetList-derived class.

annotation(object):

character string indicating the package used to provide annotation for the features on the array.

chromosome(object):

Returns the chromosome corresponding to each element in the gSetList object

elementNROWS(object): Returns the number of rows for each list of assays. In most gSetList-
derived classes, the assays are organized by chromosome and elementNROWS returns the num-
ber of markers for each chromosome.

genomeBuild(object), genomeBuild(object) <- value:

Get or set the UCSC genome build. Supported builds are hg18 and hg19.

Coercion

object is an instance of a gSetList-derived class.

makeFeatureGRanges(object, ...):

Create a GRanges object for the featureData. The featureData is stored as a list. This method
stacks the featureData from each list element. Metadata columns in the GRanges object in-
clude physical position (’position’), a SNP indicator (’isSnp’), and the chromosome. The
genome build is extracted from object using the method genomeBuild.

Author(s)

R. Scharpf

See Also

oligoSetList, BeadStudioSetList

Examples

showClass("gSetList")

i2p

Description

Functions to convert probabilities to integers, or integers to probabil-
ities.

Probabilities estimated in the crlmm package are often stored as integers to save memory. We pro-
vide a few utility functions to go back and forth between the probability and integer representations.

Usage

i2p(i)
p2i(p)

initializeBigMatrix

Arguments

i

p

Value

A matrix or vector of integers.

A matrix or vector of probabilities.

37

The value returned by i2p is

1 - exp(-i/1000)
The value returned by 2pi is

as.integer(-1000*log(1-p))

See Also

confs

Examples

i2p(693)
p2i(0.5)
i2p(p2i(0.5))

initializeBigMatrix

Initialize big matrices/vectors.

Description

Initialize big matrices or vectors appropriately (conditioned on the status of support for large datasets
- see Details).

Usage

initializeBigMatrix(name=basename(tempfile()), nr=0L, nc=0L, vmode = "integer", initdata = NA)
initializeBigVector(name=basename(tempfile()), n=0L, vmode = "integer",

initdata = NA)

initializeBigArray(name=basename(tempfile()), dim=c(0L,0L,0L),

vmode="integer", initdata=NA)

Arguments

name

nr

nc

n

vmode

initdata

dim

prefix to be used for file stored on disk

number of rows

number of columns

length of the vector

mode - "integer", "double"

Default is NA

Integer vector indicating the dimensions of the array to initialize

38

Details

integerMatrix

These functions are meant to be used by developers. They provide means to appropriately create
big vectors or matrices for packages like oligo and crlmm (and friends). These objects are created
conditioned on the status of support for large datasets.

Value

If the ’ff’ package is loaded (in the search path), then an ’ff’ object is returned. A regular R vector
or array is returned otherwise.

Examples

x <- initializeBigVector("test", 10)
class(x)
x
if (isPackageLoaded("ff"))
finalizer(x) <- "delete"

rm(x)
initializeBigMatrix(nr=5L, nc=5L)
initializeBigArray(dim=c(10, 5, 3))

integerMatrix

Coerce numeric matrix (or array) to a matrix (array) of integers, re-
taining dimnames.

Description

Coerce numeric matrix to matrix of integers, retaining dimnames.

Usage

integerMatrix(x, scale = 100)
integerArray(x, scale=100)

Arguments

x
scale

Value

a matrix or array
scalar (numeric). If not 1, x is multiplied by scale prior to coercing to a matrix
of integers.

A matrix or array of integers.

Author(s)

R. Scharpf

Examples

x <- matrix(rnorm(10), 5, 2)
rownames(x) = letters[1:5]
i <- integerMatrix(x, scale=100)

is.ffmatrix

39

is.ffmatrix

Check if object is an ff-matrix object.

Description

Check if object is an ff-matrix object.

Usage

is.ffmatrix(object)

object to be checked

Arguments

object

Value

Logical.

Note

This function is meant to be used by developers.

Examples

if (isPackageLoaded("ff")){

x1 <- ff(vmode="double", dim=c(10, 2))
is.ffmatrix(x1)

}
x1 <- matrix(0, nr=10, nc=2)
is.ffmatrix(x1)

isPackageLoaded

Check if package is loaded.

Description

Checks if package is loaded.

Usage

isPackageLoaded(pkg)

Arguments

pkg

Details

Package to be checked.

Checks if package name is in the search path.

kind

40

Value

Logical.

See Also

search

Examples

isPackageLoaded("oligoClasses")
isPackageLoaded("ff")
isPackageLoaded("snow")

isSnp-methods

Methods for Function isSnp in package oligoClasses~~

Description

~~ Methods for function isSnp in package oligoClasses ~~

Methods

Return an indicator for whether the marker is polymorphic (value 1) or nonpolymorphic (value
0).
Return an indicator for whether the vector of marker identifiers in object is polymorphic.
pkgname must be one of the supported annotation packages specific to the platform.

signature(object = "character", pkgname = "character")signature(object = "eSet", pkgname = "ANY")

If ’isSnp’ is included in fvarLabels(object), an indicator for polymorphic markers is re-
turned. Otherwise, an error is thrown.

signature(object = "GenomeAnnotatedDataFrame", pkgname = "ANY") Accessor for indicator
of whether the marker is polymorphic. If annotation was not available due to a missing or non-
existent annotation package, the value returned by the accessor will be a vector of zero’s.

kind

Array type

Description

Retrieves the array type.

Usage

kind(object)

Arguments

object

FeatureSet or DBPDInfo object

41

ldSetOptions

Value

String: "Expression", "Exon", "SNP" or "Tiling"

Examples

if (require(pd.mapping50k.xba240)){

data(sfsExample)
Biobase::annotation(sfsExample) <- "pd.mapping50k.xba240"
kind(sfsExample)

}

ldSetOptions

Set/check large dataset options.

Description

Set/check large dataset options.

Usage

ldSetOptions(nsamples=100, nprobesets=20000, path=getwd(), verbose=FALSE)
ldStatus(verbose=FALSE)
ldPath(path)

Arguments

nsamples

nprobesets

path

verbose

Details

number of samples to be processed at once.

number of probesets to be processed at once.

path where to store large dataset objects.

verbosity (logical).

Some functions in oligo/crlmm can process data in batches to minimize memory footprint. When
using this feature, the ’ff’ package resources are used (and possibly combined with cluster resources
set in options() via ’snow’ package).

Methods that are executed on a sample-by-sample manner can use ocSamples() to automatically
define how many samples are processed at once (on a compute node). Similarly, methods applied
to probesets can use ocProbesets(). Users should set these options appropriately.
ldStatus checks the support for large datasets.
ldPath checks where ff files are stored.

Author(s)

Benilton S Carvalho

See Also

ocSamples, ocProbesets

42

Examples

ldStatus(TRUE)

library2

length-methods

Number of samples for FeatureSet-like objects.

Description

Number of samples for FeatureSet-like objects.

Methods

x = "FeatureSet" Number of samples

library2

Supress package startup messages when loading a library

Description

Supress package startup messages when loading a library

arguments to library

Usage

library2(...)

Arguments

...

Author(s)

R. Scharpf

See Also

library

Examples

library2("Biobase")

list.celfiles

43

list.celfiles

List CEL files.

Description

Function used to get a list of CEL files.

Usage

list.celfiles(..., listGzipped=FALSE)

Arguments

...
listGzipped

Passed to list.files
Logical. List .CEL.gz files?

Value

Character vector with filenames.

Note

Quite often users want to use this function to pass filenames to other methods. In this situations, it
is safer to use the argument ’full.names=TRUE’.

See Also

list.files

Examples

if (require(hapmapsnp5)){

path <- system.file("celFiles", package="hapmapsnp5")

## only the filenames
list.celfiles(path)

## the filenames with full path...
## very useful when genotyping samples not in the working directory
list.celfiles(path, full.names=TRUE)

}else{

## this won't return anything
## if in the working directory there isn't any CEL
list.celfiles(getwd())

}

ListClasses

eSetList class

Description

Initialization method for eSetList virtual class.

44

makeFeatureGRanges

locusLevelData

Basic data elements required for the HMM

Description

This object is a list containing the basic data elements required for the HMM

Usage

data(locusLevelData)

Format

A list

Details

The basic assay data elements that can be used for fitting the HMM are:

1. a mapping of platform identifiers to chromosome and physical position

2. (optional) a matrix of copy number estimates

3. (optional) a matrix of confidence scores for the copy number estimates (e.g., inverse standard
deviations)

4. (optional) a matrix of genotype calls

5. (optional) CRLMM confidence scores for the genotype calls

At least (2) or (4) is required. The locusLevelData is a list that contains (1), (2), (4), and (5).

Source

A HapMap sample on the Affymetrix 50k platform. Chromosomal alterations were simulated. The
last 100 SNPs on chromosome 2 are, in fact, a repeat of the first 100 SNPs on chromosome 1 – this
was added for internal use.

Examples

data(locusLevelData)
str(locusLevelData)

makeFeatureGRanges

Construct a GRanges object from several possible feature-level classes

Description

Construct a GRanges object from several possible feature-level classes. The conversion is useful
for subsequent ranged-data queries, such as findOverlaps, countOverlaps, etc.

Usage

makeFeatureGRanges(object, ...)

manufacturer-methods

Arguments

object

45

A gSet-derived object containing chromosome and physical position for the
markers on the array.

...

See the makeFeatureGRanges method for GenomeAnnotatedDataFrame.

Value

A GRanges object.

Author(s)

R. Scharpf

See Also

findOverlaps, GRanges, GenomeAnnotatedDataFrame

Examples

library(oligoClasses)
library(GenomicRanges)
library(Biobase)
library(foreach)
registerDoSEQ()
data(oligoSetExample, package="oligoClasses")
oligoSet <- oligoSet[chromosome(oligoSet) == 1, ]
makeFeatureGRanges(oligoSet)

manufacturer-methods Manufacturer ID for FeatureSet-like objects.

Description

Manufacturer ID for FeatureSet-like and DBPDInfo-like objects.

Methods

object = "FeatureSet" Manufacturer ID

object = "PDInfo" Manufacturer ID

46

ocSamples

ocLapply

lapply-like function that parallelizes code when possible.

Description

ocLapply is an lapply-like function that checks if ff/snow are loaded and if the cluster variable is
set to execute FUN on a cluster. If these requirements are not available, then lapply is used.

Usage

ocLapply(X, FUN, ..., neededPkgs)

Arguments

X

FUN

...

first argument to FUN.

function to be executed.

additional arguments to FUN.

neededPkgs

packages needed to execute FUN on the compute nodes.

Details

neededPkgs is needed when parallel computing is expected to be used. These packages are loaded
on the compute nodes before the execution of FUN.

Value

A list of length length(X).

Author(s)

Benilton S Carvalho

See Also

lapply, parStatus

ocSamples

Cluster and large dataset management utilities.

Description

Tools to simplify management of clusters via ’snow’ package and large dataset handling through
the ’bigmemory’ package.

Usage

ocSamples(n)
ocProbesets(n)

oligoSet

Arguments

n

Details

47

integer representing the maximum number of samples/probesets to be processed
simultaneously on a compute node.

Some methods in the oligo/crlmm packages, like backgroundCorrect, normalize, summarize and
rma can use a cluster (set through the ’foreach’ package). The use of cluster features is conditioned
on the availability of the ’ff’ (used to provide shared objects across compute nodes) and ’foreach’
packages.

To use a cluster, ’oligo/crlmm’ checks for three requirements: 1) ’ff’ is loaded; 2) an adaptor for
the parallel backend (like ’doMPI’, ’doSNOW’, ’doMC’) is loaded and registered.

If only the ’ff’ package is available and loaded (in addition to the caller package - ’oligo’ or
’crlmm’), these methods will allow the user to analyze datasets that would not fit in RAM at the
expense of performance.
In the situations above (large datasets and cluster), oligo/crlmm uses the options ocSamples and
ocProbesets to limit the amount of RAM used by the machine(s). For example, if ocSamples
is set to 100, steps like background correction and normalization process (in RAM) 100 samples
simultaneously on each compute node. If ocProbesets is set to 10K, then summarization processes
10K probesets at a time on each machine.

Warning

In both scenarios (large dataset and/or cluster use), there is a penalty in performance because data
are written to disk (to either minimize memory footprint or share data across compute nodes).

Author(s)

Benilton Carvalho

Examples

if(require(doMC)) {
registerDoMC()
## tasks like summarize()

}

oligoSet

An example instance of oligoSnpSet class

Description

An example instance of the oligoSnpSet class

Usage

data(oligoSetExample)

Source

Created from the simulated locusLevelData provided in this package.

48

See Also

locusLevelData

Examples

oligoSnpSet-methods

## Not run:
## 'oligoSetExample' created by the following
data(locusLevelData)
oligoSet <- new("oligoSnpSet",

copyNumber=integerMatrix(log2(locusLevelData[["copynumber"]]/100), 100),
call=locusLevelData[["genotypes"]],
callProbability=locusLevelData[["crlmmConfidence"]],
annotation=locusLevelData[["platform"]],
genome="hg19")

oligoSet <- oligoSet[!is.na(chromosome(oligoSet)), ]
oligoSet <- oligoSet[chromosome(oligoSet) < 3, ]

## End(Not run)

data(oligoSetExample)
oligoSet

oligoSnpSet-methods

Methods for oligoSnpSet class

Description

Methods for oligoSnpSet class

Methods

In the following code, object is an instance of the oligoSnpSet class.

new("oligoSnpSet", ...): Instantiates an object of class oligoSnpSet. The assayData ele-
ments of the oligoSnpSet class can include matrices of genotype calls, confidence scores
for the genotype calls, B allele frequencies, absolute or relative copy number, and confidence
scores for the copy number estimates. Each matrix should be coerced to an integer scale prior
to assignment to the oligoSnpSet object. Validity methods defined for the class will fail if
the matrices are not integers. See examples for additional details.

baf(object): Accessor for integer representation of the B allele frequencies. The value returned
by this method can be divided by 1000 to obtain B allele frequencies on the original [0,1]
scale.

baf(object) <- value: Assign an integer representation of the B allele frequencies to the ’baf’
element of the assayData slot. value must be a matrix of integers. See the examples for help
converting BAFs to a matrix of integers.

parStatus

49

parStatus

Checks if oligo/crlmm can use parallel resources.

Description

Checks if oligo/crlmm can use parallel resources (needs ff and snow package, in addition to op-
tions(cluster=makeCluster(...)).

Usage

parStatus()

Value

logical

Author(s)

Benilton S Carvalho

pdPkgFromBioC

Get packages from BioConductor.

Description

This function checks if a given package is available on BioConductor and installs it, in case it is.

Usage

pdPkgFromBioC(pkgname, lib = .libPaths()[1], verbose = TRUE)

Arguments

pkgname

lib

verbose

Details

character. Name of the package to be installed.

character. Path where to install the package at.

logical. Verbosity flag.

Internet connection required.

Value

Logical: TRUE if package was found, downloaded and installed; FALSE otherwise.

Author(s)

Benilton Carvalho

pmFragmentLength-methods

50

See Also

download.packages

Examples

## Not run:
pdPkgFromBioC("pd.mapping50k.xba240")

## End(Not run)

platform-methods

Platform Information

Description

Platform Information

Methods

object = "FeatureSet" platform information

pmFragmentLength-methods

Information on Fragment Length

Description

This method will return the fragment length for PM probes.

Methods

object = "AffySNPPDInfo" On AffySNPPDInfo objects, it will return the fragment length that

contains the SNP in question.

position-methods

51

position-methods

Methods for function position in Package oligoClasses

Description

Methods for function position in package oligoClasses

Methods

The methods for position extracts the physical position stored as an integer for each marker in a
eSet-derived class or a AnnotatedDataFrame-derived class.

signature(object = "AnnotatedDataFrame") Accessor for physical position.
signature(object = "eSet") If ’position’ is included in fvarLabels(object), the physical po-

sition will be returned. Otherwise, an error is thrown.

signature(object = "GenomeAnnotatedDataFrame") Accessor for physical position. If annota-
tion was not available due to a missing or non-existent annotation package, the value returned
by the accessor will be a vector of zero’s.

requireAnnotation

Helper function to load packages.

Description

This function checkes the existence of a given package and loads it if available. If the package is
not available, the function checks its availability on BioConductor, downloads it and installs it.

Usage

requireAnnotation(pkgname, lib=.libPaths()[1], verbose = TRUE)

Arguments

pkgname

lib

verbose

Value

character. Package name (usually an annotation package).

character. Path where to install packages at.

logical. Verbosity flag.

Logical: TRUE if package is available or FALSE if package unavailable for download.

Author(s)

Benilton Carvalho

See Also

install.packages

52

Examples

## Not run:
requirePackage("pd.mapping50k.xba240")

## End(Not run)

requireClusterPkgSet

requireClusterPkgSet DEPRECATED FUNCTIONS. Package loaders for clusters.

Description

Package loaders for clusters.

Usage

requireClusterPkgSet(packages)
requireClusterPkg(pkg, character.only)

Arguments

packages

character vector with the names of the packages to be loaded on the compute
nodes.

pkg

name of a package given as a name or literal character string

character.only a logical indicating whether ‘pkg’ can be assumed to be a character string

Details

requireClusterPkgSet applies require for a set of packages on the cluster nodes.
requireClusterPkg applies require for *ONE* package on the cluster nodes and accepts every
argument taken by require.

Value

Logical.

Author(s)

Benilton S Carvalho

See Also

require

sampleNames-methods

53

sampleNames-methods

Sample names for FeatureSet-like objects

Description

Returns sample names for FeatureSet-like objects.

Methods

object = "FeatureSet" Sample names

scqsExample

SnpCnvQSet Example

Description

Example of SnpCnvQSet object.

Usage

data(scqsExample)

Format

Object belongs to SnpCnvQSet class.

Examples

data(scqsExample)
class(scqsExample)

setCluster

DEPRECATED FUNCTIONS. Cluster and large dataset management
utilities.

Description

Tools to simplify management of clusters via ’snow’ package and large dataset handling through
the ’bigmemory’ package.

Usage

setCluster(...)
getCluster()
delCluster()

Arguments

...

arguments to be passed to makeCluster in the ’snow’ package.

54

Details

sfsExample

Some methods in the oligo/crlmm packages, like backgroundCorrect, normalize, summarize and
rma can use a cluster (set through ’snow’ package). The use of cluster features is conditioned on the
availability of the ’bigmemory’ (used to provide shared objects across compute nodes) and ’snow’
packages.

To use a cluster, ’oligo/crlmm’ checks for three requirements: 1) ’ff’ is loaded; 2) ’snow’ is loaded;
and 3) the ’cluster’ option is set (e.g., via options(cluster=makeCluster(...)) or setCluster(...)).

If only the ’ff’ package is available and loaded (in addition to the caller package - ’oligo’ or
’crlmm’), these methods will allow the user to analyze datasets that would not fit in RAM at the
expense of performance.
In the situations above (large datasets and cluster), oligo/crlmm uses the options ocSamples and
ocProbesets to limit the amount of RAM used by the machine(s). For example, if ocSamples
is set to 100, steps like background correction and normalization process (in RAM) 100 samples
simultaneously on each compute node. If ocProbesets is set to 10K, then summarization processes
10K probesets at a time on each machine.

Warning

In both scenarios (large dataset and/or cluster use), there is a penalty in performance because data
are written to disk (to either minimize memory footprint or share data across compute nodes).

Author(s)

Benilton Carvalho

sfsExample

SnpFeatureSet Example

Description

Example of SnpFeatureSet object.

Usage

data(sfsExample)

Format

Object belongs to SnpFeatureSet class

Examples

data(sfsExample)
class(sfsExample)

SnpSet-methods

55

SnpSet-methods

Accessors and methods for SnpSet objects

Description

Utility functions for accessing data in SnpSet objects.

Usage

calls(object)
calls(object) <- value
confs(object, transform=TRUE)
confs(object) <- value

Arguments

object

transform

A SnpSet object.

Logical. Whether to transform the integer representation of the confidence score
(for memory efficiency) to a probability. See details.

value

A matrix.

Details

calls returns the genotype calls. CRLMM stores genotype calls as integers (1 - AA; 2 - AB; 3 -
BB).
confs returns the confidences associated with the genotype calls. The current implementation of
CRLMM stores the confidences as integers to save memory on disk by using the transformation:

round(-1000*log2(1-p)),
where ’p’ is the posterior probability of the call. confs is a convenience function that transforms
the integer representation back to a probability. Note that if the assayData elements of the SnpSet
objects are ff_matrix or ffdf, the confs function will return a warning. For such objects, one
should first subset the ff object and coerce to a matrix, then apply the above conversion. The
function snpCallProbability for the callProbability slot of SnpSet objects. See the examples
below.
checkOrder checks whether the object is ordered by chromosome and physical position, evaluating
to TRUE or FALSE.

Note

Note that the replacement method for confs<- expects a matrix of probabilities and will automati-
cally convert the probabilities to an integer representation. See details for the conversion.
The accessor snpCallProbability is an accessor for the ’callProbability’ element of the assayData.
The name can be misleading, however, as the accessor will not return a probability if the call prob-
abilities are represented as integers.

See Also

The helper functions p2i converts probabilities to integers and i2p converts integers to probabilities.
See order and checkOrder.

56

Examples

SnpSet2-class

theCalls <- matrix(sample(1:3, 20, rep=TRUE), nc=2)
p <- matrix(runif(20), nc=2)
integerRepresentation <- matrix(as.integer(round(-1000*log(1-p))), 10, 2)
obj <- new("SnpSet2", call=theCalls, callProbability=integerRepresentation)
calls(obj)

confs(obj) ## coerces to probability scale
int <- Biobase::snpCallProbability(obj) ## not necessarily a probability
p3 <- i2p(int) ## to convert back to a probability

SnpSet2-class

Class "SnpSet2"

Description

A container for genotype calls and confidence scores. Similar to the SnpSet class in Biobase, but
SnpSet2 extends gSet directly whereas SnpSet extends eSet. Useful properties of gSet include
the genome slot and the GenomeAnnotatedDataFrame.

Objects from the Class

Objects can be created by calls of the form new("SnpSet2", assayData, phenoData, featureData,
experimentData, annotation, protocolData, call, callProbability, genome, ...).

Slots

genome: Object of class "character" indicating the UCSC genome build. Supported builds are

’hg18’ and ’hg19’.

assayData: Object of class "AssayData".
phenoData: Object of class "AnnotatedDataFrame".
featureData: Object of class "AnnotatedDataFrame".
experimentData: Object of class "MIAxE".
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "gSet", directly. Class "eSet", by class "gSet", distance 2. Class "VersionedBiobase", by
class "gSet", distance 3. Class "Versioned", by class "gSet", distance 4.

Accessors

The argument object for the following methods is an instance of the SnpSet2 class.

calls(object): calls(object) <- value:

Gets or sets the genotype calls. value can be a matrix or a ff_matrix.

confs(object): confs(object) <- value:

Gets or sets the genotype confidence scores. value can be a matrix or a ff_matrix.

snpCall(object): snpCallProbability(object) <- value:

Gets or sets the genotype confidence scores.

57

SnpSuperSet-class

Author(s)

R. Scharpf

See Also

SnpSet

Examples

showClass("SnpSet2")
new("SnpSet2")

SnpSuperSet-class

Class "SnpSuperSet"

Description

A class to store locus-level summaries of the quantile normalized intensities, genotype calls, and
genotype confidence scores

Objects from the Class

new("SnpSuperSet", allelea=alleleA, alleleB=alleleB, call=call, callProbability, ...).

Slots

assayData: Object of class "AssayData" ~~
phenoData: Object of class "AnnotatedDataFrame" ~~
featureData: Object of class "AnnotatedDataFrame" ~~
experimentData: Object of class "MIAME" ~~
annotation: Object of class "character" ~~
protocolData: Object of class "AnnotatedDataFrame" ~~
.__classVersion__: Object of class "Versions" ~~

Extends

Class "AlleleSet", directly. Class "SnpSet", directly. Class "eSet", by class "AlleleSet", dis-
tance 2. Class "VersionedBiobase", by class "AlleleSet", distance 3. Class "Versioned", by
class "AlleleSet", distance 4.

Methods

No methods defined with class "SnpSuperSet" in the signature.

Author(s)

R. Scharpf

See Also

AlleleSet

58

Examples

splitIndicesByLength

showClass("SnpSuperSet")
## empty object from the class
x <- new("matrix")
new("SnpSuperSet", alleleA=x, alleleB=x, call=x, callProbability=x)

splitIndicesByLength

Tools to distribute objects across nodes or by length.

Description

Tools to distribute objects across nodes or by length.

Usage

splitIndicesByLength(x, lg, balance=FALSE)
splitIndicesByNode(x)

Arguments

x

lg

object to be split

length

balance

logical. Currently ignored

Details

splitIndicesByLength splits x in groups of length lg.
splitIndicesByNode splits x in N groups (where N is the number of compute nodes available).

Value

List.

Author(s)

Benilton S Carvalho

See Also

split

Examples

x <- 1:100
splitIndicesByLength(x, 8)
splitIndicesByLength(x, 8, balance=TRUE)
splitIndicesByNode(x)

sqsExample

59

sqsExample

SnpQSet Example

Description

Example of SnpQSet instance.

Usage

data(sqsExample)

Format

Belongs to SnpQSet class.

Examples

data(sqsExample)
class(sqsExample)

SummarizedExperiment-methods

Methods for RangedSummarizedExperiment objects

Description

Methods for RangedSummarizedExperiment.

Usage

## S4 method for signature 'RangedSummarizedExperiment'
baf(object)
## S4 method for signature 'RangedSummarizedExperiment'
chromosome(object,...)
## S4 method for signature 'RangedSummarizedExperiment'
isSnp(object, ...)
## S4 method for signature 'RangedSummarizedExperiment'
lrr(object)

Arguments

object

...

A RangedSummarizedExperiment object.

ignored

60

Details

SummarizedExperiment-methods

baf and lrr are accessors for the B allele frequencies and log R ratio assays (matrices or arrays),
respectively,
chromosome returns the seqnames of the rowRanges.
isSnp returns a logical vector for each marker in rowRanges indicating whether the marker targets
a SNP (nonpolymorphic regions are FALSE).

See Also

RangedSummarizedExperiment

Index

∗ IO

list.celfiles, 43

∗ attribute

getSequenceLengths, 32

∗ classes

AlleleSet-class, 4
AssayData-methods, 5
BeadStudioSet-class, 9
BeadStudioSetList-class, 10
CNSet-class, 15
CopyNumberSet-class, 17
DBPDInfo-class, 21
FeatureSet-class, 23
ff_matrix-class, 24
ff_or_matrix-class, 25
ffdf-class, 24
gSet-class, 34
gSetList-class, 35
ListClasses, 43
SnpSet2-class, 56
SnpSuperSet-class, 57

∗ datasets

efsExample, 22
locusLevelData, 44
oligoSet, 47
scqsExample, 53
sfsExample, 54
sqsExample, 59

∗ data

pdPkgFromBioC, 49
requireAnnotation, 51

∗ internal

Deprecated, 21

∗ list

affyPlatforms, 3

∗ manip

AssayDataList, 6
assayDataList-methods, 7
batchStatistics, 8
celfileDate, 11
celfileName, 11
checkExists, 12
checkOrder, 13

chromosome2integer, 15
CopyNumberSet-methods, 18
createFF, 20
featureDataList-methods, 22
fileConnections, 25
flags, 26
genomeBuild, 29
geometry, 30
getA, 30
getBar, 31
i2p, 36
initializeBigMatrix, 37
integerMatrix, 38
is.ffmatrix, 39
isPackageLoaded, 39
kind, 40
ldSetOptions, 41
library2, 42
makeFeatureGRanges, 44
ocLapply, 46
ocSamples, 46
parStatus, 49
requireClusterPkgSet, 52
setCluster, 53
SnpSet-methods, 55
splitIndicesByLength, 58

∗ methods

assayDataList-methods, 7
batch, 7
batchStatistics, 8
chromosome-methods, 14
CopyNumberSet-methods, 18
db, 20
exprs-methods, 22
featureDataList-methods, 22
flags, 26
GenomeAnnotatedDataFrameFrom-methods,

28

GRanges-methods, 33
isSnp-methods, 40
length-methods, 42
manufacturer-methods, 45
oligoSnpSet-methods, 48

61

62

INDEX

platform-methods, 50
pmFragmentLength-methods, 50
position-methods, 51
sampleNames-methods, 53
SummarizedExperiment-methods, 59

∗ misc

affyPlatforms, 3
generics, 27

∗ utilities

list.celfiles, 43

[,CNSet,ANY-method (CNSet-class), 15
[,CNSet-method (CNSet-class), 15
[,gSetList,ANY-method (gSetList-class),

35

[,gSetList-method (gSetList-class), 35
[[,BafLrrSetList,ANY,ANY-method

(BeadStudioSetList-class), 10
[[,BeadStudioSetList,ANY,ANY-method
(BeadStudioSetList-class), 10
[[<-,BafLrrSetList,ANY,ANY,BafLrrSet-method
(BeadStudioSetList-class), 10

[[<-,gSetList,ANY,ANY,BafLrrSet-method

(gSetList-class), 35
$,gSetList-method (gSetList-class), 35
$<-,gSetList-method (gSetList-class), 35

A (getA), 30
A,AlleleSet-method (getA), 30
A,CNSet-method (CNSet-class), 15
A<- (getA), 30
A<-,AlleleSet,matrix-method (getA), 30
A<-,AlleleSet-method (getA), 30
A<-,CNSet-method (CNSet-class), 15
AffyExonPDInfo (DBPDInfo-class), 21
AffyExonPDInfo-class (DBPDInfo-class),

21

AffyExpressionPDInfo (DBPDInfo-class),

21

AffyExpressionPDInfo-class
(DBPDInfo-class), 21
AffyGenePDInfo (DBPDInfo-class), 21
AffyGenePDInfo-class (DBPDInfo-class),

21

affyPlatforms, 3
AffySNPCNVPDInfo (DBPDInfo-class), 21
AffySNPCNVPDInfo-class

(DBPDInfo-class), 21

AffySNPPDInfo (DBPDInfo-class), 21
AffySNPPDInfo-class (DBPDInfo-class), 21
AffySTPDInfo (DBPDInfo-class), 21
AffySTPDInfo-class (DBPDInfo-class), 21
AffyTilingPDInfo (DBPDInfo-class), 21

AffyTilingPDInfo-class

(DBPDInfo-class), 21

allele (AlleleSet-class), 4
allele,AlleleSet-method

(AlleleSet-class), 4
allele,CNSet-method (CNSet-class), 15
allele,SnpFeatureSet-method
(AlleleSet-class), 4

AlleleSet, 57
AlleleSet (AlleleSet-class), 4
AlleleSet-class, 4
AnnotatedDataFrame, 27
annotatedDataFrameFrom,ff_matrix-method

(ff_matrix-class), 24

annotation,DBPDInfo-method
(DBPDInfo-class), 21
annotation,gSetList-method
(gSetList-class), 35

annotationPackages, 5
AssayData, 28
AssayData-methods, 5
AssayDataList, 6
assayDataList (assayDataList-methods), 7
assayDataList,gSetList-method

(gSetList-class), 35
assayDataList,oligoSetList-method
(assayDataList-methods), 7

assayDataList-methods, 7
assayDataNew, 7

B (getA), 30
B,AlleleSet-method (getA), 30
B,CNSet-method (CNSet-class), 15
B<- (getA), 30
B<-,AlleleSet,matrix-method (getA), 30
B<-,AlleleSet-method (getA), 30
B<-,CNSet-method (CNSet-class), 15
baf (generics), 27
baf,BafLrrSetList-method

(BeadStudioSetList-class), 10

baf,BeadStudioSet-method

(BeadStudioSet-class), 9

baf,BeadStudioSetList-method

(BeadStudioSetList-class), 10

baf,oligoSetList-method

(BeadStudioSetList-class), 10

baf,oligoSnpSet-method

(oligoSnpSet-methods), 48
baf,RangedSummarizedExperiment-method
(SummarizedExperiment-methods),
59

baf,SummarizedExperiment-method

(SummarizedExperiment-methods),

INDEX

63

59

baf<- (BeadStudioSet-class), 9
baf<-,BeadStudioSet-method

(BeadStudioSet-class), 9

baf<-,oligoSnpSet-method

(oligoSnpSet-methods), 48
BafLrrSet-class (BeadStudioSet-class), 9
BafLrrSetList-class

(BeadStudioSetList-class), 10

batch, 7, 8
batch,CNSet-method (CNSet-class), 15
batchNames, 8
batchNames (batch), 7
batchNames,AssayData-method

(AssayData-methods), 5
batchNames,CNSet-method (CNSet-class),

15

batchNames<- (batch), 7
batchNames<-,AssayData-method
(AssayData-methods), 5

batchNames<-,CNSet-method

(CNSet-class), 15

batchStatistics, 8, 26
batchStatistics,CNSet-method

(CNSet-class), 15

batchStatistics<- (batchStatistics), 8
batchStatistics<-,CNSet,AssayData-method

(CNSet-class), 15

BeadStudioSet (BeadStudioSet-class), 9
BeadStudioSet-class, 9
BeadStudioSetList, 36
BeadStudioSetList-class, 10
bothStrands (AlleleSet-class), 4
bothStrands,AlleleSet-method

(AlleleSet-class), 4
bothStrands,SnpFeatureSet-method
(AlleleSet-class), 4

calls (SnpSet-methods), 55
calls,CNSet-method (CNSet-class), 15
calls,oligoSetList-method

(BeadStudioSetList-class), 10

calls,oligoSnpSet-method

(oligoSnpSet-methods), 48
calls,SnpSet-method (SnpSet-methods), 55
calls,SnpSet2-method (SnpSet2-class), 56
calls<- (SnpSet-methods), 55
calls<-,CNSet,matrix-method

(CNSet-class), 15
calls<-,oligoSnpSet,matrix-method

(oligoSnpSet-methods), 48

calls<-,SnpSet,matrix-method

(SnpSet-methods), 55

calls<-,SnpSet2,matrix-method

(SnpSet2-class), 56
callsConfidence,oligoSnpSet-method

(oligoSnpSet-methods), 48

callsConfidence<-,oligoSnpSet,matrix-method

(oligoSnpSet-methods), 48

celfileDate, 11
celfileName, 11
checkExists, 12
checkOrder, 13, 55
checkOrder,CopyNumberSet-method
(CopyNumberSet-class), 17

checkOrder,gSet-method (gSet-class), 34
checkOrder,SnpSet-method

(SnpSet-methods), 55

chromosome, 35
chromosome (chromosome-methods), 14
chromosome,AnnotatedDataFrame-method
(chromosome-methods), 14

chromosome,GenomeAnnotatedDataFrame-method

(chromosome-methods), 14

chromosome,GRanges-method

(chromosome-methods), 14

chromosome,GRangesList-method

(chromosome-methods), 14

chromosome,gSet-method

(chromosome-methods), 14

chromosome,gSetList-method
(gSetList-class), 35

chromosome,RangedDataCNV-method
(Deprecated), 21

chromosome,RangedSummarizedExperiment-method
(SummarizedExperiment-methods),
59

chromosome,SnpSet-method

(chromosome-methods), 14
chromosome,SummarizedExperiment-method
(SummarizedExperiment-methods),
59

chromosome-methods, 14
chromosome2integer, 14, 15
chromosome<- (chromosome-methods), 14
chromosome<-,GenomeAnnotatedDataFrame,integer-method

(chromosome-methods), 14

chromosome<-,gSet,integer-method

(chromosome-methods), 14

chromosome<-,SnpSet,integer-method

(chromosome-methods), 14
chromosomePositionOrder (checkOrder), 13
clone2 (BeadStudioSetList-class), 10
clone2,BafLrrSetList-method

(BeadStudioSetList-class), 10

64

INDEX

close (fileConnections), 25
close,AlleleSet-method (getA), 30
close,array-method (fileConnections), 25
close,CNSet-method (CNSet-class), 15
close,matrix-method (fileConnections),

25

close,numeric-method (fileConnections),

25

closeff (fileConnections), 25
closeff,CNSet-method (fileConnections),

25

cnConfidence (CopyNumberSet-methods), 18
cnConfidence,CopyNumberSet-method

(CopyNumberSet-class), 17
cnConfidence,oligoSnpSet-method
(oligoSnpSet-methods), 48
cnConfidence<- (CopyNumberSet-methods),

18

cnConfidence<-,CopyNumberSet,matrix-method

(CopyNumberSet-class), 17
cnConfidence<-,oligoSnpSet,matrix-method
(oligoSnpSet-methods), 48

confs<-,SnpSet2,matrix-method

(SnpSet2-class), 56

copyNumber (CopyNumberSet-methods), 18
copyNumber,BeadStudioSet-method
(BeadStudioSet-class), 9
copyNumber,CopyNumberSet-method
(CopyNumberSet-class), 17

copyNumber,oligoSetList-method

(BeadStudioSetList-class), 10

copyNumber,oligoSnpSet-method

(oligoSnpSet-methods), 48
copyNumber<- (CopyNumberSet-methods), 18
copyNumber<-,BeadStudioSet,ANY-method
(BeadStudioSet-class), 9
copyNumber<-,CopyNumberSet,matrix-method
(CopyNumberSet-class), 17
copyNumber<-,oligoSnpSet,matrix-method
(oligoSnpSet-methods), 48

CopyNumberSet (CopyNumberSet-class), 17
CopyNumberSet-class, 17
CopyNumberSet-methods, 18
corr (AssayData-methods), 5
corr,CNSet,character-method

CNSet, 5
CNSet (CNSet-class), 15
CNSet-class, 15
coerce,AnnotatedDataFrame,GenomeAnnotatedDataFrame-method

(GenomeAnnotatedDataFrame-class),
27

coerce,BeadStudioSet,data.frame-method
(BeadStudioSet-class), 9

coerce,CNSet,CopyNumberSet-method
(CNSet-class), 15

coerce,CNSet,oligoSnpSet (CNSet-class),

15

coerce,CNSet,oligoSnpSet-method
(CNSet-class), 15

coerce,CNSetLM,CNSet-method

(CNSet-class), 15

coerce,gSetList,list-method
(gSetList-class), 35
coerce,oligoSnpSet,data.frame-method

(oligoSnpSet-methods), 48

confs, 37
confs (SnpSet-methods), 55
confs,CNSet-method (CNSet-class), 15
confs,SnpSet-method (SnpSet-methods), 55
confs,SnpSet2-method (SnpSet2-class), 56
confs<- (SnpSet-methods), 55
confs<-,CNSet,matrix-method

(CNSet-class), 15

confs<-,SnpSet,matrix-method

(SnpSet-methods), 55

(CNSet-class), 15

coverage2 (GRanges-methods), 33
coverage2,GRanges-method

(GRanges-methods), 33
coverage2,GRangesList-method
(GRanges-methods), 33

coverage2,RangedDataCNV-method
(Deprecated), 21

createFF, 20

db, 20
db,AlleleSet-method (AlleleSet-class), 4
db,DBPDInfo-method (db), 20
db,FeatureSet-method (db), 20
db,gSet-method (gSet-class), 34
db,SnpCnvQSet-method (db), 20
db,SnpQSet-method (db), 20
db,SnpSet-method (db), 20
db-methods (db), 20
DBPDInfo (DBPDInfo-class), 21
DBPDInfo-class, 21
delCluster (setCluster), 53
delCluster-deprecated (setCluster), 53
Deprecated, 21
dims,gSetList-method (gSetList-class),

35

efsExample, 22
elementNROWS,gSetList-method

(gSetList-class), 35

INDEX

65

eSet, 4, 9, 17, 23, 34, 56, 57
ExonFeatureSet (FeatureSet-class), 23
ExonFeatureSet-class

(FeatureSet-class), 23

ExpressionFeatureSet

(FeatureSet-class), 23

ExpressionFeatureSet-class

(FeatureSet-class), 23
ExpressionPDInfo (DBPDInfo-class), 21
ExpressionPDInfo-class

(DBPDInfo-class), 21

exprs,FeatureSet-method

(exprs-methods), 22

exprs,SnpSet2-method (SnpSet2-class), 56
exprs-methods, 22

GeneFeatureSet (FeatureSet-class), 23
GeneFeatureSet-class

(FeatureSet-class), 23
GenericFeatureSet (FeatureSet-class), 23
GenericFeatureSet-class

(FeatureSet-class), 23

GenericPDInfo (DBPDInfo-class), 21
GenericPDInfo-class (DBPDInfo-class), 21
generics, 27
GenomeAnnotatedDataFrame, 28, 45
GenomeAnnotatedDataFrame

(GenomeAnnotatedDataFrame-class),
27

GenomeAnnotatedDataFrame-class, 27
GenomeAnnotatedDataFrameFrom

featureDataList

(featureDataList-methods), 22

featureDataList,gSetList-method

(gSetList-class), 35
featureDataList-methods, 22
FeatureSet (FeatureSet-class), 23
FeatureSet-class, 23
featuresInRange (Deprecated), 21
featuresInRange,SnpSet2,RangedDataCNV-method

(Deprecated), 21

ff, 25
ff_matrix-class, 24
ff_or_matrix-class, 25
ffdf, 25
ffdf-class, 24
fileConnections, 25
findOverlaps, 45
findOverlaps,AnnotatedDataFrame,RangedDataCNV-method

(GenomeAnnotatedDataFrameFrom-methods),
28

GenomeAnnotatedDataFrameFrom,array-method

(GenomeAnnotatedDataFrameFrom-methods),
28

GenomeAnnotatedDataFrameFrom,AssayData-method
(GenomeAnnotatedDataFrameFrom-methods),
28

GenomeAnnotatedDataFrameFrom,ff_or_matrix-method

(GenomeAnnotatedDataFrameFrom-methods),
28

GenomeAnnotatedDataFrameFrom,list-method

(GenomeAnnotatedDataFrameFrom-methods),
28

GenomeAnnotatedDataFrameFrom,NULL-method

(GenomeAnnotatedDataFrameFrom-methods),
28

GenomeAnnotatedDataFrameFrom-methods,

(Deprecated), 21
findOverlaps,GRanges,gSet-method

(GRanges-methods), 33
findOverlaps,GRangesList,gSet-method
(GRanges-methods), 33

28

genomeBuild, 29
genomeBuild,DBPDInfo-method

(genomeBuild), 29
genomeBuild,FeatureSet-method
(genomeBuild), 29

genomeBuild,GRanges-method

(GRanges-methods), 33

findOverlaps,RangedDataCNV,AnnotatedDataFrame-method

(Deprecated), 21

findOverlaps,RangedDataCNV,CNSet-method

(Deprecated), 21

findOverlaps,RangedDataCNV,RangedDataCNV-method

(Deprecated), 21

findOverlaps,RangedDataCNV,SnpSet-method

(Deprecated), 21

genomeBuild,gSet-method (gSet-class), 34
genomeBuild,gSetList-method
(gSetList-class), 35

genomeBuild<- (genomeBuild), 29
genomeBuild<-,gSet,character-method

findOverlaps,RangedDataHMM,RangedDataHMM-method

(gSet-class), 34

(Deprecated), 21

flags, 26
flags,AssayData-method

(AssayData-methods), 5

flags,CNSet-method (CNSet-class), 15

genomeBuild<-,gSetList,character-method

(gSetList-class), 35

geometry, 30
geometry,DBPDInfo-method (geometry), 30
geometry,FeatureSet-method (geometry),

66

30

getA, 30
getA,AlleleSet-method

(AlleleSet-class), 4

getA,SnpCnvQSet-method (getA), 30
getA,SnpQSet-method (getA), 30
getA,TilingFeatureSet2-method (getA), 30
getArm (gSet-class), 34
getArm,GenomeAnnotatedDataFrame-method

(GenomeAnnotatedDataFrame-class),
27

getArm,gSet-method (gSet-class), 34
getBar, 31
getCluster (setCluster), 53
getCluster-deprecated (setCluster), 53
getM (getA), 30
getM,AlleleSet-method

(AlleleSet-class), 4

getM,SnpCnvQSet-method (getA), 30
getM,SnpQSet-method (getA), 30
getM,TilingFeatureSet2-method (getA), 30
getSequenceLengths, 32
GRanges, 33, 45
GRanges-methods, 33
gSet, 9, 56
gSet (gSet-class), 34
gSet-class, 34
gSetList-class, 35

i2p, 36, 55
initialize,BeadStudioSet-method
(BeadStudioSet-class), 9

initialize,BeadStudioSetList-method
(BeadStudioSetList-class), 10
initialize,CNSet-method (CNSet-class),

15

initialize,CNSetLM-method

(CNSet-class), 15
initialize,CopyNumberSet-method
(CopyNumberSet-class), 17

initialize,DBPDInfo-method
(DBPDInfo-class), 21
initialize,eSetList-method

(ListClasses), 43

initialize,FeatureSet-method
(FeatureSet-class), 23

initialize,GenomeAnnotatedDataFrame-method

(GenomeAnnotatedDataFrame-class),
27

initialize,gSet-method (gSet-class), 34
initialize,gSetList-method
(gSetList-class), 35

initialize,oligoSnpSet-method

INDEX

(oligoSnpSet-methods), 48

initialize,SnpSet2-method
(SnpSet2-class), 56

initialize,SnpSuperSet-method
(SnpSuperSet-class), 57

initializeBigArray

(initializeBigMatrix), 37

initializeBigMatrix, 37
initializeBigVector

(initializeBigMatrix), 37

integer2chromosome

(chromosome2integer), 15
integerArray (integerMatrix), 38
integerMatrix, 38
is.ffmatrix, 39
isPackageLoaded, 39
isSnp, 35
isSnp (isSnp-methods), 40
isSnp,character-method (isSnp-methods),

40

isSnp,GenomeAnnotatedDataFrame-method

(isSnp-methods), 40
isSnp,gSet-method (isSnp-methods), 40
isSnp,RangedSummarizedExperiment-method
(SummarizedExperiment-methods),
59

isSnp,SnpSet-method (isSnp-methods), 40
isSnp,SummarizedExperiment-method

(SummarizedExperiment-methods),
59
isSnp-methods, 40

kind, 40
kind,AffyExonPDInfo-method (kind), 40
kind,AffyExpressionPDInfo-method

(kind), 40

kind,AffyGenePDInfo-method (kind), 40
kind,AffyHTAPDInfo-method (kind), 40
kind,AffySNPCNVPDInfo-method (kind), 40
kind,AffySNPPDInfo-method (kind), 40
kind,ExpressionPDInfo-method (kind), 40
kind,FeatureSet-method (kind), 40
kind,GenericPDInfo-method (kind), 40
kind,TilingPDInfo-method (kind), 40

ldPath (ldSetOptions), 41
ldSetOptions, 41
ldStatus (ldSetOptions), 41
length,FeatureSet-method

(length-methods), 42

length,gSetList-method

(gSetList-class), 35

INDEX

67

length-methods, 42
library, 42
library2, 42
list.celfiles, 43
list.files, 43
list_or_ffdf, 24
list_or_ffdf-class (ffdf-class), 24
ListClasses, 43
locusLevelData, 44, 48
lrr (generics), 27
lrr,BafLrrSetList-method

(BeadStudioSetList-class), 10

lrr,BeadStudioSet-method

(BeadStudioSet-class), 9

lrr,BeadStudioSetList-method

(BeadStudioSetList-class), 10

lrr,RangedSummarizedExperiment-method
(SummarizedExperiment-methods),
59

lrr,SummarizedExperiment-method

(SummarizedExperiment-methods),
59

lrr<- (BeadStudioSet-class), 9
lrr<-,BafLrrSet,ANY-method

(BeadStudioSet-class), 9

lrr<-,BafLrrSet-method

(BeadStudioSet-class), 9

lrr<-,BafLrrSetList,matrix-method

(BeadStudioSetList-class), 10

lrr<-,BeadStudioSet,ANY-method
(BeadStudioSet-class), 9

lrr<-,BeadStudioSet-method

(BeadStudioSet-class), 9

NgsExpressionPDInfo-class

(DBPDInfo-class), 21
NgsTilingPDInfo (DBPDInfo-class), 21
NgsTilingPDInfo-class (DBPDInfo-class),

21

nu (AssayData-methods), 5
nu,AssayData,character-method
(AssayData-methods), 5

nu,CNSet,character-method

(CNSet-class), 15
numberProbes (GRanges-methods), 33
numberProbes,GRanges-method
(GRanges-methods), 33

numberProbes,GRangesList-method

(GRanges-methods), 33

ocLapply, 46
ocProbesets (ocSamples), 46
ocSamples, 46
oldClass, 24
oligoSet, 47
oligoSetList, 36
oligoSetList-class

(BeadStudioSetList-class), 10

oligoSnpSet, 18
oligoSnpSet-class

(oligoSnpSet-methods), 48

oligoSnpSet-methods, 48
open (fileConnections), 25
open,AlleleSet-method (getA), 30
open,array-method (fileConnections), 25
open,CNSet-method (CNSet-class), 15
open,matrix-method (fileConnections), 25
open,numeric-method (fileConnections),

makeFeatureGRanges, 44
makeFeatureGRanges,GenomeAnnotatedDataFrame-method
(GenomeAnnotatedDataFrame-class),
27

25

openff (fileConnections), 25
openff,CNSet-method (fileConnections),

makeFeatureGRanges,gSet-method
(gSet-class), 34

makeFeatureGRanges,gSetList-method
(gSetList-class), 35

manufacturer (manufacturer-methods), 45
manufacturer,DBPDInfo-method

(manufacturer-methods), 45

manufacturer,FeatureSet-method

(manufacturer-methods), 45

manufacturer-methods, 45
matrix, 28
mean,RangedDataCBS-method (Deprecated),

21

NgsExpressionPDInfo (DBPDInfo-class), 21

25
order, 14, 55

p2i, 55
p2i (i2p), 36
parStatus, 49
pdPkgFromBioC, 49
phi (AssayData-methods), 5
phi,AssayData,character-method

(AssayData-methods), 5

phi,CNSet,character-method

(CNSet-class), 15

platform (platform-methods), 50
platform,FeatureSet-method

(platform-methods), 50

platform-methods, 50

68

pmFragmentLength

(pmFragmentLength-methods), 50
pmFragmentLength,AffySNPPDInfo-method
(pmFragmentLength-methods), 50

pmFragmentLength-methods, 50
position, 35
position (position-methods), 51
position,AnnotatedDataFrame-method
(position-methods), 51

position,GenomeAnnotatedDataFrame-method

(position-methods), 51

position,gSet-method

(position-methods), 51

position,gSetList-method

(gSetList-class), 35

position,SnpSet-method

(position-methods), 51

position-methods, 51
position<-

(GenomeAnnotatedDataFrame-class),
27

INDEX

sampleNames,gSetList-method
(gSetList-class), 35
sampleNames,RangedDataCNV-method
(Deprecated), 21
sampleNames-methods, 53
sampleNames<-,gSetList,character-method

(gSetList-class), 35

sampleNames<-,RangedDataCNV,character-method

(Deprecated), 21

scqsExample, 53
se.exprs,FeatureSet-method
(exprs-methods), 22

setCluster, 53
setCluster-deprecated (setCluster), 53
sfsExample, 54
show,BeadStudioSet-method

(BeadStudioSet-class), 9

show,CNSet-method (CNSet-class), 15
show,DBPDInfo-method (DBPDInfo-class),

21

show,FeatureSet-method

position<-,GenomeAnnotatedDataFrame,integer-method
(GenomeAnnotatedDataFrame-class),
27

position<-,oligoSnpSet,integer-method
(oligoSnpSet-methods), 48

RangedDataCBS (Deprecated), 21
RangedDataCBS-class (Deprecated), 21
RangedDataCNV (Deprecated), 21
RangedDataCNV-class (Deprecated), 21
RangedDataCopyNumber-class

(Deprecated), 21

RangedDataHMM (Deprecated), 21
RangedDataHMM-class (Deprecated), 21
RangedSummarizedExperiment, 59, 60
read.celfiles, 23
read.xysfiles, 23
requireAnnotation, 51
requireClusterPkg

(requireClusterPkgSet), 52

requireClusterPkg-deprecated

(requireClusterPkgSet), 52

requireClusterPkgSet, 52
requireClusterPkgSet-deprecated

(requireClusterPkgSet), 52

sampleNames,FeatureSet-method

(sampleNames-methods), 53

sampleNames,GRanges-method

(GRanges-methods), 33

sampleNames,GRangesList-method

(GRanges-methods), 33

(FeatureSet-class), 23

show,gSet-method (gSet-class), 34
show,gSetList-method (gSetList-class),

35

sigma2,CNSet,character-method
(CNSet-class), 15

snpCallProbability, 55
snpCallProbability,CNSet-method
(CNSet-class), 15

SnpCnvFeatureSet (FeatureSet-class), 23
SnpCnvFeatureSet-class

(FeatureSet-class), 23

SNPCNVPDInfo (DBPDInfo-class), 21
SNPCNVPDInfo-class (DBPDInfo-class), 21
SnpFeatureSet (FeatureSet-class), 23
SnpFeatureSet-class (FeatureSet-class),

23

SNPPDInfo (DBPDInfo-class), 21
SNPPDInfo-class (DBPDInfo-class), 21
snprma, 31
SnpSet, 55, 57
SnpSet-methods, 55
SnpSet2-class, 56
SnpSuperSet, 5
SnpSuperSet (SnpSuperSet-class), 57
SnpSuperSet-class, 57
splitIndicesByLength, 58
splitIndicesByNode

(splitIndicesByLength), 58

sqsExample, 59
state (GRanges-methods), 33

INDEX

69

state,GRanges-method (GRanges-methods),

33

state,GRangesList-method

(GRanges-methods), 33

state,RangedDataCNV-method

(Deprecated), 21
SummarizedExperiment-methods, 59

tau2,CNSet,character-method

(CNSet-class), 15

TilingFeatureSet (FeatureSet-class), 23
TilingFeatureSet-class

(FeatureSet-class), 23
TilingFeatureSet2 (FeatureSet-class), 23
TilingFeatureSet2-class

(FeatureSet-class), 23

TilingPDInfo (DBPDInfo-class), 21
TilingPDInfo-class (DBPDInfo-class), 21

updateObject,BeadStudioSet-method

(BeadStudioSet-class), 9
updateObject,BeadStudioSetList-method

(BeadStudioSetList-class), 10

updateObject,CNSet-method

(CNSet-class), 15

updateObject,GenomeAnnotatedDataFrame-method

(GenomeAnnotatedDataFrame-class),
27

updateObject,oligoSnpSet-method
(oligoSnpSet-methods), 48

Versioned, 4, 9, 17, 23, 27, 34, 56, 57
VersionedBiobase, 4, 9, 17, 23, 34, 56, 57

