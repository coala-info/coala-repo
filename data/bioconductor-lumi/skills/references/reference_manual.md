Package ‘lumi’

February 13, 2026

Type Package

Title BeadArray Specific Methods for Illumina Methylation and

Expression Microarrays

Version 2.62.0

Date 2020-10-02

Depends R (>= 2.10), Biobase (>= 2.5.5)

Imports affy (>= 1.23.4), methylumi (>= 2.3.2), GenomicFeatures,

GenomicRanges, annotate, lattice, mgcv (>= 1.4-0), nleqslv,
KernSmooth, preprocessCore, RSQLite, DBI, AnnotationDbi, MASS,
graphics, stats, stats4, methods

Suggests beadarray, limma, vsn, lumiBarnes, lumiHumanAll.db,

lumiHumanIDMapping, genefilter, RColorBrewer

Author Pan Du, Richard Bourgon, Gang Feng, Simon Lin
Maintainer Lei Huang <lhuang1998@gmail.com>

Description The lumi package provides an integrated solution for the
Illumina microarray data analysis. It includes functions of
Illumina BeadStudio (GenomeStudio) data input, quality control,
BeadArray-specific variance stabilization, normalization and gene
annotation at the probe level. It also includes the functions of
processing Illumina methylation microarrays, especially Illumina
Infinium methylation microarrays.

License LGPL (>= 2)

LazyLoad yes

biocViews Microarray, OneChannel, Preprocessing, DNAMethylation,

QualityControl, TwoChannel

NeedsCompilation no

git_url https://git.bioconductor.org/packages/lumi

git_branch RELEASE_3_22

git_last_commit 1123e59

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

1

2

Contents

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
.

.
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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
lumi-package .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
addAnnotationInfo .
.
5
addControlData2lumi .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
addControlData2methyLumiM . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
addNuID2lumi
.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
adjColorBias.quantile .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
adjColorBias.ssn .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
asBigMatrix-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
.
.
.
beta2m .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
bgAdjust .
.
.
bgAdjustMethylation .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
boxplot,MethyLumiM-method . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
boxplot-methods
.
.
.
boxplotColorBias .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
colorBiasSummary .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
density-methods .
.
.
.
.
.
detectionCall
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
.
.
detectOutlier
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
estimateBeta .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
estimateIntensity .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
.
estimateLumiCV .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
.
.
.
estimateM .
.
estimateMethylationBG .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
.
example.lumi
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
example.lumiMethy .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
example.methyTitration .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
.
gammaFitEM .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
.
.
getChipInfo .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
.
.
getChrInfo .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
.
getControlData .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
.
.
.
getControlProbe .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
getControlType .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
getNuIDMappingInfo .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
.
.
.
hist-methods .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
.
.
.
.
id2seq .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
.
.
IlluminaID2nuID .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
.
.
.
importMethyIDAT .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
.
.
.
inverseVST .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
.
.
.
.
.
is.nuID .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
.
.
.
.
lumiB .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
.
.
.
.
LumiBatch-class
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
.
.
.
lumiExpresso .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
.
.
.
.
lumiMethyB .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
.
.
.
.
lumiMethyC .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
.
.
.
.
lumiMethyN .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
.
.
.
.
.
lumiMethyR .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
.
.
.
.
lumiMethyStatus
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
.
.
.
.
.
lumiN .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
.
.
.
.
.
lumiQ .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
.
.
.
.
.
lumiR .

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

.
.

.

lumi-package

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
.
lumiR.batch .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
.
.
lumiT .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
.
.
m2beta .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
MAplot-methods
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
methylationCall .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
.
monoSmu .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
.
monoSpline .
normalizeMethylation.quantile . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
normalizeMethylation.ssn .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
.
nuID2EntrezID .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
.
nuID2IlluminaID .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
.
.
nuID2probeID .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
.
.
nuID2RefSeqID .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
.
.
.
nuID2targetID .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
.
.
.
pairs-methods .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
.
.
.
.
plot-methods
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
.
plotCDF .
.
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
.
plotColorBias1D .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
.
plotColorBias2D .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
.
.
plotControlData .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
.
.
.
.
plotDensity .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
.
plotGammaFit .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
.
plotHousekeepingGene .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
.
.
plotSampleRelation .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
.
.
plotStringencyGene .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
.
.
plotVST .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77
.
.
.
.
probeID2nuID .
produceGEOPlatformFile .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
produceGEOSampleInfoTemplate . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 79
produceGEOSubmissionFile . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
produceMethylationGEOSubmissionFile . . . . . . . . . . . . . . . . . . . . . . . . . . 81
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82
rankinvariant
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 83
.
rsn .
.
.
seq2id .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 84
.
smoothQuantileNormalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 85
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
ssn .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87
targetID2nuID .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 88
.
.
vst .

.
.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

.
.

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

90

lumi-package

A package for preprocessing Illumina microarray data

Description

lumi R package is designed to preprocess the Illumina microarray (BeadArray) data. It includes
functions of Illumina data input, quality control, variance stabilization, normalization and gene
annotation.

4

Details

addAnnotationInfo

lumi
Package:
Package
Type:
1.1.0
Version:
Date:
2007-03-23
License: LGPL version 2 or newer

Author(s)

Pan Du, Simon Lin Maintainer: Pan Du <dupan@northwestern.edu>

References

1. Du, P., Kibbe, W.A. and Lin, S.M., (2008) ’lumi: a pipeline for processing Illumina microarray’,
Bioinformatics 24(13):1547-1548

2. Lin, S.M., Du, P., Kibbe, W.A., (2008) ’Model-based Variance-stabilizing Transformation for
Illumina Microarray Data’, Nucleic Acids Res. 36, e11

3. Du, P., Kibbe, W.A. and Lin, S.M., (2007) ’nuID: A universal naming schema of oligonucleotides
for Illumina, Affymetrix, and other microarrays’, Biology Direct, 2, 16

addAnnotationInfo

Add probe color channel and basic annotation information based on
the annotation library of Illumina methylation microarray

Description

Add probe color channel and basic annotation information based on the annotation library of Illu-
mina methylation microarray

Usage

addAnnotationInfo(methyLumiM, lib = 'FDb.InfiniumMethylation.hg19', annotationColumn=c('COLOR_CHANNEL', 'CHROMOSOME', 'POSITION'))

Arguments

methyLumiM

a MethyLumiM object includes Illumina Infinium methylation data

lib
annotationColumn

Annotation library of Illumina methylation microarray.

only include ’COLOR_CHANNEL’, ’CHROMOSOME’ and ’POSITION’ in-
formation

Details

The "lib" parameter supports both FeatureDb based annotation libraries and old array-based anno-
tation libraries. ’FDb.InfiniumMethylation.hg19’ is the FeatureDb based annotation library, which
includes both 450k and 27k data. "IlluminaHumanMethylation27k.db" (for 27k array) and "Illumi-
naHumanMethylation450k.db" (450k infinium array) are old types of annotation libraries.

addControlData2lumi

Value

5

return the MethyLumiM object with COLOR_CHANNEL, CHROMOSOME and chromome PO-
SITION information added to the featureData.

Author(s)

Pan DU

See Also

lumiMethyR

Examples

data(example.lumiMethy)
head(pData(featureData(example.lumiMethy)))
## removing color channel information
# testData = example.lumiMethy
# pData(featureData(testData))$COLOR_CHANNEL = NULL
# testData = addAnnotationInfo(testData, lib="IlluminaHumanMethylation27k.db")
## check whether the color channel information is added
# head(pData(featureData(testData)))

addControlData2lumi

Add the control probe data into the controlData slot of LumiBatch
object

Description

Add the control probe profile data, outputted by BeadStudio, into the controlData slot of LumiBatch
object.

Usage

addControlData2lumi(controlData, x.lumi)

Arguments

controlData

the control data can be a data.frame or the control probe filename outputted by
BeadStudio

x.lumi

a LumiBatch object, to which controlData will be added.

Details

The controlData slot in LumiBatch object is a data.frame with first two columns as "controlType"
and "ProbeID". The rest columns are the expression amplitudes for individual samples.

Value

Return the LumiBatch object with controlData slot filled.

addControlData2methyLumiM

6

Author(s)

Pan Du

See Also

getControlData, plotControlData

Examples

## Not runnable
# controlFile <- 'Control_Probe_Profile.txt'
# x.lumi <- addControlData2lumi(controlFile, x.lumi)

addControlData2methyLumiM

Add methylation control data to a MethyLumiM object

Description

Add methylation control data to a MethyLumiM object

Usage

addControlData2methyLumiM(controlData, methyLumiM, checkConsistency = TRUE, ...)

Arguments

controlData

methyLumiM
checkConsistency

a methylation control data file (output by GenomeStudio), or a MethyLumiQC
object
a MethyLumiM object to add control data

whether to check the sample names consistency between methyLumiM and con-
trolData
other parameters for reading controlData

...

Details

This function aims to add the controlData (MethyLumiQC object) to the controlData slot of a
methyLumiM object For control data, methylated data matrix in assayData slot corresponds to
green channel, and unmethylated data matrix in assayData slot corresponds to red channel.

Value

Return the methyLumiM object with the controlData added

Author(s)

Pan DU

See Also

lumiMethyR

addNuID2lumi

7

addNuID2lumi

Add the nuID information to the LumiBatch object

Description

Replace the Illumina Id (Target ID or Probe Id) as nuID (nucleotide universal identifier) for indexing
genes in the LumiBatch object

Usage

addNuID2lumi(x.lumi, annotationFile=NULL, sep = NULL, lib.mapping = NULL, annotationColName = c(sequence = "Probe_Sequence", target = "ILMN_Gene", probe='Probe_Id'), verbose = TRUE)

Arguments

x.lumi
annotationFile a annotation file, which includes the Illumina ID (target or probe ids) and probe

a LumiBatch object

sequence information

sep

the separation used in the annotation file. Automatically detect the separator if
it is "," or "\t".

lib.mapping
annotationColName

a Illumina ID mapping package, e.g, lumiHumanIDMapping

the annotation column name in the annotation file used for the probe sequence
and TargetID and ProbeID

verbose

a boolean to decide whether to print out some messages

Details

Since the default Illumina IDs (TargetID (ILMN\_Gene ID) and ProbeId (Probe\_Id)) are not con-
sistent between different arrays and batches, we invented a nuID, which is one-to-one matching
with the probe sequence. This function is to replace the Illumina ID with the nuID. If the anno-
tation library (the unzipped manifest file (.bgx)) is provided, the function will automatically check
whether the Illumina ID is provided for the microarray data. We recommend output the data using
ProbeID when using Illumina BeadStudio software, because the TargetID (ILMN\_Gene ID) are
not unique.

Value

a LumiBatch object with Illumina ID replaced by nuID.

Author(s)

Pan Du

References

Du, P., Kibbe, W.A., Lin, S.M., "nuID: A universal naming schema of oligonucleotides for Illumina,
Affymetrix, and other microarrays", submitted.

See Also

IlluminaID2nuID, lumiR

8

Examples

## load example data
# data(example.lumi)

adjColorBias.quantile

## specify the annotation file for the Illumina chip
# annotationFile <- 'Human_RefSeq-8.csv'
## Replace the Target ID with nuID
# lumi.nuID <- addNuID2lumi(example.lumi, annotationFile)

## An alternative way is to load the Annotation library and match the targetID (or Probe Id) with nuID
# lumi.nuId <- addNuID2lumi(example.lumi, lib.mapping='lumiHumanIDMapping')

adjColorBias.quantile Color bias adjustment of Illumina Infinium methylaton microarrays

using smooth quantile normalization

Description

Color bias adjustment of Illumina Infinium methylaton microarrays using smooth quantile normal-
ization smoothQuantileNormalization

Usage

adjColorBias.quantile(methyLumiM, refChannel = c("green", "red"), logMode = TRUE, verbose = TRUE,...)

Arguments

methyLumiM

a MethyLumiM object or any eSet object with "methylated" and "unmethylated"
data matrix element in the assayData slot

refChannel

the reference color channel for color bias adjustment

logMode

verbose

...

Details

whether perform the adjustment in log scale or not

whether print extra information during processing
other parameters used by smoothQuantileNormalization

Perform color bias adjustment of Illumina Infinium methylaton microarrays.
It requires the in-
put methyLumiM object includes the color channel information in the featureData. Basically, there
should be a "COLOR_CHANNEL" column in the data.frame returned by pData(featureData(methyLumiM)).

The basic idea of color bias adjustment is to treat it as the normalization between two color chan-
It uses smooth quantile normalization smoothQuantileNormalization to normalize two
nels.
color channels.

Value

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after color bias adjustment.

9

adjColorBias.ssn

Author(s)

Pan DU

See Also

See Also lumiMethyC, smoothQuantileNormalization and adjColorBias.ssn

Examples

data(example.lumiMethy)
# before adjustment
plotColorBias1D(example.lumiMethy)
lumiMethy.adj = adjColorBias.quantile(example.lumiMethy)
# after adjustment
plotColorBias1D(lumiMethy.adj)

adjColorBias.ssn

Color bias adjustment of Illumina Infinium methylaton microarrays
using simple shift and scaling normalization

Description

Color bias adjustment of Illumina Infinium methylaton microarrays using simple shift and scaling
normalization

Usage

adjColorBias.ssn(methyLumiM, refChannel = c("green", "red", "mean"))

Arguments

methyLumiM

a MethyLumiM object or any eSet object with "methylated" and "unmethylated"
data matrix element in the assayData slot

refChannel

the reference color channel for color bias adjustment

Details

Perform color bias adjustment of Illumina Infinium methylaton microarrays.
It requires the in-
put methyLumiM object includes the color channel information in the featureData. Basically, there
should be a "COLOR_CHANNEL" column in the data.frame returned by pData(featureData(methyLumiM)).

The basic idea of color bias adjustment is to treat it as the normalization between two color channels.
It uses simple scaling normalization to normalize two color channels. The background levels are
estimated using function estimateMethylationBG.

Value

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after color bias adjustment.

Author(s)

Pan DU

10

See Also

asBigMatrix-methods

See Also lumiMethyC, estimateMethylationBG and adjColorBias.quantile

Examples

data(example.lumiMethy)
# before adjustment
plotColorBias1D(example.lumiMethy)
lumiMethy.adj = adjColorBias.ssn(example.lumiMethy)
# after adjustment
plotColorBias1D(lumiMethy.adj)

asBigMatrix-methods

convert the data matrix in the assayData of a ExpressionSet as Big-
Matrix

Description

convert the data matrix in the assayData of a ExpressionSet as BigMatrix

Usage

## S4 method for signature 'ExpressionSet'
asBigMatrix(object, rowInd=NULL, colInd=NULL, nCol=NULL, dimNames=NULL, saveDir='.', savePrefix=NULL, ...)

Arguments

object
rowInd
colInd
nCol

dimNames

saveDir
savePrefix

...

Details

an object of ExpressionSet or its inherited class
the subset of row index
the subset of column index
the number of columns of the data, which can be larger than the real data dimen-
sion. It is designed for adding future data.
the dimension names, which is a list of two character vectors (rownames and
colnames)
the parent directory to save the BigMatrix data files
the folder name prefix of the directory to save the BigMatrix data files. The fold
name will be like this: paste(savePrefix, ’_bigmat’, sep=”)
optional arguments to BigMatrix

This function does not work in Windows because the dependent package bigmemoryExtras does
not support it.
In order to make lumi package still compilation under Windows, I deliberately
remove the dependency of bigmemoryExtras package. As a result, users need to manually load the
bigmemoryExtras function before using this function.

The BigMatrix data files will be save in the directory file.path(saveDir, paste(savePrefix, ’_bigmat’,
sep=”))

See Also

BigMatrix

beta2m

11

beta2m

Convert methylation Beta-value to M-value

Description

Convert methylation Beta-value to M-value through a logistic transformation

Usage

beta2m(beta)

Arguments

beta

Details

a matrix or vector of methylation Beta-value

Convert methylation Beta-value to M-value through a logistic transformation

Value

return methylation M-value with the same size of input Beta-value

Author(s)

Pan Du

References

Du, P., Zhang, X, Huang, C.C., Jafari, N., Kibbe, W.A., Hou, L., and Lin, S.M., (2010) ’Comparison
of Beta-value and M-value methods for quantifying methylation levels by microarray analysis’,
(under review)

See Also

See Also as m2beta

bgAdjust

Background adjustment for Illumina data

Description

The method adjusts the data by subtracting an offset, which is estimated based on the quantile of
the control probes

Usage

bgAdjust(lumiBatch, probs = 0.5, ...)

12

Arguments

lumiBatch

probs

...

Details

bgAdjustMethylation

A LumiBatch object with controlData slot include control probe information

The quantile used to estimate the background
other parameters used by quantile method

The method adjusts the data by subtracting an offset, which is estimated based on the quantile of
the control probes. The control probe information is kept in the controlData slot of the LumiBatch
object. If no control data information, the method will do nothing.

Value

It returns a LumiBatch object with background adjusted.

Author(s)

Pan Du

See Also

lumiB

Examples

data(example.lumi)
## Here will assume the minimum of the control probe as the background,
##
example.lumi.b <- bgAdjust(example.lumi, probs=0)

because there is no negative control (blank beads) information for the Barnes data.

bgAdjustMethylation

Estimate and adjust the background levels of Illumina Infinium methy-
laton microarrays

Description

Estimate and adjust the background levels of Illumina Infinium methylaton microarrays

Usage

bgAdjustMethylation(methyLumiM, separateColor = FALSE, targetBGLevel = 300, negPercTh = 0.25)

Arguments

methyLumiM

separateColor

targetBGLevel

negPercTh

a MethyLumiM object or any eSet object with "methylated" and "unmethylated"
data matrix element in the assayData slot

determine whether separately process two color channels

adjust background level to a non-zero target background level

the threshold of the percentage of negative values after subtract estimated back-
ground levels. A warning will be given if too many probes having intensities
lower than background levels.

boxplot,MethyLumiM-method

13

Details

The estimation of background level of Infinium methylaton microarray is based on the assump-
tion that the lots of CpG sites are unmethylated, which results in a density mode of the intensities
measured by methylated probes. The position of this mode represents the background level.

Value

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after background level adjustment. The estimated background level was kept in the
attribute, "EstimatedBG", of the returned methyLumiM object.

Author(s)

Pan DU

See Also

See Also lumiMethyB and estimateMethylationBG

Examples

data(example.lumiMethy)
lumiMethy.bgAdj = bgAdjustMethylation(example.lumiMethy)
attr(lumiMethy.bgAdj, "EstimatedBG")

boxplot,MethyLumiM-method

boxplot of a MethyLumiM object

Description

Creating a hdr.boxplot of the M-value in a MethyLumiM object

Usage

## S4 method for signature 'MethyLumiM'
boxplot(x, main, logMode = TRUE, ...)

Arguments

x

main

logMode

...

Details

a MethyLumiM-class object

title of the boxplot

only works when the dataType of x is "Intensity"
optional arguments to bwplot.

Because the density plot of M-values usually includes two modes, using the traditional boxplot
cannot accurately represent the distribution of the data. Here we use violin plot to show the density
of M-values by samples

14

See Also

MethyLumiM-class, panel.violin and boxplot,ExpressionSet-method

boxplot-methods

Examples

## load example data
data(example.lumiMethy)
boxplot(example.lumiMethy)

boxplot-methods

boxplot of a ExpressionSet object

Description

Creating boxplot of sample intensities in a ExpressionSet object

Usage

## S4 method for signature 'ExpressionSet'
boxplot(x, range = 0, main, logMode = TRUE, subset = NULL, xlab = "", ylab = "Amplitude", ...)

Arguments

x

range

main

logMode

subset

xlab

ylab

...

Details

a ExpressionSet object
parameter of boxplot
title of the boxplot

whether plot the data in log2 scale or not

subset of rows used to plot. It can be an index vector, or the length of a random
subset

xlab of the plot

ylab of the plot
optional arguments to boxplot.

The boxplot function has a "subset" parameter. By default, it is set as 5000, i.e., randomly selected
5000 probes to plot the boxplot. The purpose of this is to plot the picture faster, but it will also make
the boxplot has slightly different each time. If the user wants to make sure the boxplot is the same
each time, you can set the "subset" parameter as NULL.

See Also

LumiBatch-class, boxplot and boxplot,MethyLumiM-method

Examples

## load example data
data(example.lumi)

boxplot(example.lumi)

boxplotColorBias

15

boxplotColorBias

Plot the Illumina Infinium methylation color bias in terms of boxplot

Description

Plot the Illumina Infinium methylation color bias in terms of boxplot. boxplot of red and green
color channel will be plotted side by side

Usage

boxplotColorBias(methyLumiM, logMode = TRUE, channel = c("both", "unmethy", "methy", "sum"), grid = TRUE, main = NULL, mar = NULL, verbose = F, subset = NULL, ...)

Arguments

methyLumiM

logMode

channel

grid

main

mar

verbose

subset

...

Details

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

whether plot the intensities in log-scale

estimate the intensity in different methods

whether to add grid on the plot

title of the plot

margin of the plot

whether print verbose information during plot

plot subset of randomly selected rows. All data will be plotted if it is NULL.
other parameters of boxplot

Plot the Illumina Infinium methylation color bias in terms of boxplot. boxplot of red and green
color channel will be plotted side by side

Value

Invisibly return TRUE if plot successfully.

Author(s)

Pan DU

See Also

See Also as boxplot and plotColorBias1D

Examples

data(example.lumiMethy)
boxplotColorBias(example.lumiMethy)

16

density-methods

colorBiasSummary

A summary of colorBias information

Description

A summary of colorBias information, which is a data.frame summarizing the intensities of individ-
ual samples

Usage

colorBiasSummary(methyLumiM, logMode = TRUE, channel = c("both", "unmethy", "methy", "sum"))

Arguments

methyLumiM

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

logMode

channel

Whether plot the intensities in log-scale

estimate the intensity in different methods

Details

A summary of colorBias information. There are four options using "channel" parameter to plot the
density plot. "both": estimate the density by pooling together methylated and unmethylated probe
intensities. "unmethy" and "methy": plot either unmethylated or methylated probe density. "sum"
plot the density of the sum of methylatled and unmethylated probe intensitys.

Value

A data.frame summarizing the intensities of individual samples

Author(s)

Pan DU

density-methods

Density plot of a ExpressionSet object

Description

Creating density plot of sample intensities in a ExpressionSet object.
methods.

It is equivalent to hist-

Usage

## S4 method for signature 'ExpressionSet'
density(x, logMode=TRUE, xlab = NULL, ylab = "density", type = "l",
col=1:dim(x)[2], lty=1:dim(x)[2], lwd=1, xlim = NULL, index.highlight = NULL, color.highlight = 2,
symmetry = NULL, addLegend = TRUE, legendPos="topright", subset = NULL, main="", ...)

detectionCall

Arguments

x

logMode

xlab

ylab

type

col

lty

lwd

xlim
index.highlight

color.highlight

symmetry

addLegend

legendPos

subset

main

...

17

a ExpressionSet object

determine whether the density plot is based on a log2 scale

xlab of the density plot

ylab of the density plot

parameter of plot function

line colors of the density plot

line types of the density plot

line width of plot function

parameter of the plot function

the column index of the highlighted density curve

color of highlighted density curve

the boundary position suppose to be symmetric distributed

whether add legend to the plot or not

the legend position. It can be a string specifying the position, or a length two
vector specifying the x and y position. Please check legend for more details.

subset of rows used to plot. It can be an index vector, or the length of a random
subset

title for the plot
additional parameters for density function

See Also

LumiBatch-class, hist-methods, density

Examples

## load example data
data(example.lumi)

density(example.lumi)

detectionCall

Estimate the detectable probe ratio

Description

Estimate the detectable probe ratio of each probe, sample or just return an AP matrix

Usage

detectionCall(x.lumi, Th = 0.01, type = c('probe', 'sample', 'matrix'))

18

Arguments

x.lumi

Th

type

Value

detectOutlier

a LumiBatch or MethyLumiM object

the threshold. By default, when the detection p-value is less than 0.01, we sup-
pose it is detectable. For the old version of BeadStudio output (version 2 or
earlier), the threshold will automatically transferred as 1 - Th, because in the old
format, value close to 1 is suppose to be detectable.

determine to calculate the detection count by probe or by sample

If the type is ’probe’, then returns the presentCount of each probe. If the type is ’sample’, then
return the detectable probe ratio of each sample. If the type is ’matrix’, then return the AP matrix,
in which ’A’ represents absent (the detect p-value less than threshold) and ’P’ represents present.

Author(s)

Pan Du

See Also

lumiQ

Examples

## load example data
data(example.lumi)
## load example data
data(example.lumi)

## estimate the detect call (percentage of expressed genes) of each sample
temp <- detectionCall(example.lumi, type='sample')
print(temp)

## estimate the present count of each gene (probe)
temp <- detectionCall(example.lumi, type='probe')
hist(temp)

detectOutlier

Detect the outlier sample (or gene)

Description

Detect the outlier sample (or gene) based on distance to the cluster center

Usage

detectOutlier(x, metric = "euclidean", standardize = TRUE, Th = 2, ifPlot = FALSE)

estimateBeta

Arguments

x

metric

standardize

Th

ifPlot

Details

19

a LumiBatch object, ExpressionSet object or a matrix with each column corre-
sponding to a sample or other profile

the distance matric

standardize the profile or not

the threshold of outlier,

to plot the result (as a hierarchical tree) or not

The current outlier detection is based on the distance from the sample to the center (average of all
samples after removing 10 percent samples farthest away from the center). The assumption of the
outlier detection is that there is only one single cluster and the distance from the sample to the center
is Gaussian distributed.

The outlier is detected when its distance to the center is larger than a certain threshold. The threshold
is calculated as Th * median distances to the center.

The profile relations can be visualized as a hierarchical tree.

Value

Plot the results or return the outlier (a logic vector) with the distance matrix and threshold as at-
tributes.

Author(s)

Pan Du

See Also

lumiQ

Examples

## load example data
data(example.lumi)

## detect the outlier (Further improvement needed.)
temp <- detectOutlier(example.lumi, ifPlot=TRUE)

estimateBeta

Estimate methylation Beta-value matrix

Description

Estimate methylation Beta-value matrix from MethyLumiM-class object or eSet-class object, which
include methylated and unmethylated probe intensities

Usage

estimateBeta(methyLumiM, returnType=c("ExpressionSet", "matrix"), offset = 100)

20

Arguments

methyLumiM

returnType

offset

Details

estimateIntensity

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

determine whether return an ExpressionSet or matrix object

An offset value added to the denominator to avoid close to zero intensities

Beta-value is ratio between Illumina methylated probe intensity and total probe intensities (sum of
methylated and unmethylated probe intensities, see estimateIntensity). An offset value added to
the denominator to avoid close to zero intensities in the denominator. Beta-value is in the range of
0 and 1. If we assume the probe intensity follows Gamma distribution, then the Beta-value follows
a Beta distribution.

Value

An ExpressionSet or matrix object of methylation Beta-value

Author(s)

Pan DU

See Also

See Also as estimateIntensity and estimateM

Examples

data(example.lumiMethy)
methyLumiBeta = estimateBeta(example.lumiMethy)
density(methyLumiBeta)

estimateIntensity

Estimate intensity of Illumina methylation data

Description

Estimate intensity of Illumina methylation data, which is the sum of Illumina methylated and un-
methylated probe intensities

Usage

estimateIntensity(methyLumiM, returnType=c("ExpressionSet", "matrix"))

Arguments

methyLumiM

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

returnType

determine whether return an ExpressionSet or matrix object

estimateLumiCV

Details

21

The Intensity basically is the sum of Illumina methylated and unmethylated probe intensities.

Value

An ExpressionSet or matrix object of methylation Intensity-value

Author(s)

Pan DU

See Also

See Also as estimateBeta and estimateM

Examples

data(example.lumiMethy)
methyLumiIntensity = estimateIntensity(example.lumiMethy)
boxplot(methyLumiIntensity)

estimateLumiCV

Estimate the coefficient of variance matrix of LumiBatch object

Description

Estimate the coefficient of variance matrix of LumiBatch object for each measurement or probe.

Usage

estimateLumiCV(x.lumi, type = c("measurement", "probe"), ifPlot = FALSE, ...)

Arguments

x.lumi

type

ifPlot

...

Details

a LumiBatch object

estimate the coefficient of variance of each measurement or each probe

determince whether to plot the density plot or not
optional arguments to plot.

By default, the coefficient of variance is the ratio of the mean and variance of the bead expression
values. Basically, it is the ration of exprs and se.exprs element of LumiBatch object. If the type
is "probe", it is the ratio of the mean and variance of probe expression profile.

Value

A matrix of coefficient of variance

Author(s)

Pan Du

22

See Also

lumiQ

Examples

## load example data
data(example.lumi)

estimateM

## estimate the coefficient of variance and plot the density plot of it
cv <- estimateLumiCV(example.lumi, ifPlot = TRUE)

estimateM

Estimate methylation M-value matrix

Description

Estimate methylation M-value matrix from MethyLumiM-class object or eSet-class object, which
include methylated and unmethylated probe intensities

Usage

estimateM(methyLumiM, returnType=c("ExpressionSet", "matrix"), offset=100)

Arguments

methyLumiM

returnType

offset

Details

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

determine whether return an ExpressionSet (MethyLumiM in this case) or ma-
trix object

offset added to the methylated and unmethylated probe intensities when estimat-
ing the M-value

M-value is the log2 ratio between Illumina methylated and unmethylated probe intensities. As
variations of small intensities can cause big changes in the ratio estimation, so an offset is added to
methylated and unmethylated probe intensities when estimating the M-value.

Value

A MethyLumiM or matrix object of methylation M-value

Author(s)

Pan DU

References

Du, P., Zhang, X, Huang, C.C., Jafari, N., Kibbe, W.A., Hou, L., and Lin, S.M., (2010) ’Comparison
of Beta-value and M-value methods for quantifying methylation levels by microarray analysis’,
(under review)

estimateMethylationBG

See Also

See Also as estimateBeta, estimateIntensity

Examples

data(example.lumiMethy)
methyLumiM = estimateM(example.lumiMethy)
boxplot(methyLumiM)

23

estimateMethylationBG Estimate the background levels of Illumina Infinium methylaton mi-

croarrays

Description

Estimate the background levels of Illumina Infinium methylaton microarrays. It is called by function
bgAdjustMethylation

Usage

estimateMethylationBG(methyLumiM, separateColor = FALSE, nbin = 1000)

Arguments

methyLumiM

separateColor

nbin

Details

a MethyLumiM object or any eSet object with "methylated" and "unmethylated"
data matrix element in the assayData slot

determine whether to separately process two color channels

the number of bins in the histogram used to estimate the mode position of the
density

When the controlData includes the negative control probe information, the background estimation
will be the median of the negative control probes. Red and Green color channels will be estimated
separately.

In the case the negative control data is not available, the background will be estimated based on
the mode positions of unmethylated or methylated distribution (the smaller one). The assumption
is that the lots of CpG sites are unmethylated, which results in a density mode of the intensities
measured by methylated probes. The position of this mode represents the background level.

Value

a vector of estimated background levels for individual samples.

Author(s)

Pan DU

See Also

See Also lumiMethyB and bgAdjustMethylation

24

Examples

data(example.lumiMethy)
estimatedBG = estimateMethylationBG(example.lumiMethy)
estimatedBG

example.lumi

example.lumi

Example Illumina Expression data in LumiBatch class

Description

Example data as a LumiBatch object which is a subset of Barnes data (Barnes, 2005)

Usage

data(example.lumi)

Format

A ’LumiBatch’ object

Details

The data is from (Barnes, 2005). It used Sentrix HumanRef-8 Expression BeadChip. Two samples
"100US" and "95US:5P" (each has two technique replicates) were selected. In order to save space,
8000 genes were randomly selected. As a result, the example data includes 8000 genes, each has
4 measurements. The full data set was included in the Bioconductor Experiment data package
lumiBarnes.

The entire data set has been built as a lumiBarnes data object and can be downloaded from Biocon-
ductor Experiment Data.

References

Barnes, M., Freudenberg, J., Thompson, S., Aronow, B. and Pavlidis, P. (2005) Ex-perimental
comparison and cross-validation of the Affymetrix and Illumina gene expression analysis platforms,
Nucleic Acids Res, 33, 5914-5923.

The detailed data information can be found at: http://www.bioinformatics.ubc.ca/pavlidis/lab/platformCompare/

Examples

## load the data
data(example.lumi)

## summary of the data
example.lumi

example.lumiMethy

25

example.lumiMethy

Example Illumina Infinium Methylation data in MethyLumiM class

Description

An example Illumina Infinium Methylation27k dataset, which includes a control and treatment
dataset with both technique and biological replicates

Usage

data(example.lumiMethy)

Details

The example dataset includes four control and four treatment samples together with their technique
replicates. The original samples and technique replicates were measured in two batches. Here are
the names of sixteen samples: Treat1, Treat2, Treat3, Treat4, Ctrl1, Ctrl2, Ctrl3, Ctrl4, Treat1.rep,
Treat2.rep, Treat3.rep, Treat4.rep, Ctrl1.rep, Ctrl2.rep, Ctrl3.rep, Ctrl4.rep.

To save storage space, we randomly subset 5000 CpG sites among about 27000 measured CpG
sites.

Examples

data(example.lumiMethy)
sampleNames(example.lumiMethy)

example.methyTitration

Example Illumina Infinium Methylation titration data in MethyLumiM
class

Description

An example Illumina Infinium Methylation27k dataset, which includes a titration dataset

Usage

data(example.methyTitration)

Details

The example dataset is a titration dataset. It includes 8 samples: "A1", "A2", "B1", "B2", "C1",
"C2", "D" and "E". They are mixtures of Sample A (a B-lymphocyte sample) and Sample B (is (a
colon cancer sample from a female donor) at five different titration ratios: 100:0 (A), 90:10 (C),
75:25 (D), 50:50 (E) and 0:100 (B).

To save storage space, we randomly subset 10000 CpG sites among about 27000 measured CpG
sites.

Examples

data(example.methyTitration)
sampleNames(example.methyTitration)

26

gammaFitEM

gammaFitEM

Estimate the methylation status by fitting a Gamma mixture model
using EM algorithm

Description

Estimate the methylation status by fitting a two component Gamma mixture model using EM algo-
rithm based on the all M-values of a particular sample

Usage

gammaFitEM(M, initialFit = NULL, fix.k = NULL, weighted = TRUE, maxIteration = 50, tol = 1e-04, plotMode = FALSE, truncate=FALSE, verbose = FALSE)

Arguments

M

initialFit

fix.k

weighted

a vector of M-values covering the whole genome

the initial estimation of the gamma parameters returned by .initialGammaEsti-
mation function

the k parameter of the gamma function which is fixed during estimation

determine whether to down-weight the long tails of two component densities
beyond their modes

maxIteration

maximum iterations allowed before converging

tol

plotMode

truncate

verbose

Details

the difference threshold used to determine convergence

determine whether plot the histogram and density plot estimation

determine whether to truncate the tails beyond the modes during parameter esti-
mation

determine whether plot intermediate messages during iterations

The assumption of this function is that the M-value distribution is composed of the mixture of two
shifted gamma distributions, which are defined as: dgamma(x-s[1], shape=k[1], scale=theta[1]) and
dgamma(s[2]-x, shape=k[2], scale=theta[2]). Here s represents the shift.

NOTE: the methylation status modeling algorithm was developed based on 27K methylation array.
It has not been tested for 450K array. Considering 450K array covers both promoter and gene body,
the two component Gamma mixture model assumption may not be valid any more.

Value

The return is a list with "gammaFit" class attribute, which includes the following items:

logLikelihood

the log-likelihood of the fitting model

k

theta

shift

proportion

mode

probability

parameter k of gamma distribution

parameter theta of gamma distribution

parameter shift of gamma distribution

the proportion of two components (gamma distributions)

the mode positions of the gamma distributions

the estimated methylation status posterior probability of each CpG site

getChipInfo

Author(s)

Pan Du

See Also

methylationCall and plotGammaFit

Examples

27

data(example.lumiMethy)
M <- exprs(example.lumiMethy)
fittedGamma <- gammaFitEM(M[,1], initialFit=NULL, maxIteration=50, tol=0.0001, plotMode=TRUE, verbose=FALSE)

getChipInfo

Get Illumina Chip Information based on probe identifiers

Description

Retrieve the matched Illumina chip information by searching the provided probe identifiers through
the Illumina identifiers in all manifest files.

Usage

getChipInfo(x, lib.mapping = NULL, species = c("Human", "Mouse", "Rat", "Unknown"), chipVersion = NULL, idMapping = FALSE, returnAllMatches = FALSE, verbose = TRUE)

Arguments

x

lib.mapping

species

chipVersion

idMapping

a vector of probe identifiers, ExpressionSet object or a matrix with probe iden-
tifiers as row names

the ID mapping library. If it is provided, the parameter "species" will be ignored.

species of the chip designed for. If users do not know it, it can be set as "Un-
known".
chipVersion information returned by function getChipInfo
determine whether return the idMapping information (between Illumina ID and
nuID)

returnAllMatches

determine whether return all matches or just the best match

verbose

determine whether print some warning information

Details

The function searches the provided probe Identifiers (Illumina IDs or nuIDs) through all the man-
ifest file ID information kept in the IDMapping libraries (lumiHumanIDMapping, lumiMouseI-
DMapping, lumiRatIDMapping). The Illumina IDs kept in the library include "Search\_key" ("Search\_Key"),
"Target" ("ILMN\_Gene"), "Accession", "Symbol", "ProbeId" ("Probe\_Id"). To determine the best
match, the function calculate the number of matched probes. The higher "matchedProbeNumber"
is claimed as better. When the "matchedProbeNumber" is the same, the manifest file with fewer
probes is claimed as better. If x is NULL and chipVersion is provided, it will return the entire
mapping table of the chip.

28

Value

getChrInfo

The function returns a list with following items:

chipVersion

species

IDType
chipProbeNumber

the file name of the manifest file for the corresponding version and release

the species of the chip designed for

the type of probe identifier

matchedProbeNumber

the number of probes in the manifest file

the number of input probes matching the manifest file

idMapping

id mapping information between Illumina ID and nuID

When parameter "returnAllMatches" is TRUE, the items of "chipVersion", "IDType", "chipProbe-
Number", "inputProbeNumber", "matchedProbeNumber" will be a vector corresponding to the
matched manifest files, whose "matchedProbeNumber" is larger than zero, and the "idMapping"
will be a matrix with each column corresponding to one matched manifest file. All of the items are
sorted from the best match to worst (The higher "matchedProbeNumber" is claimed as better. When
the "matchedProbeNumber" is the same, the manifest file with fewer probes is claimed as better.).

Author(s)

Pan Du

See Also

nuID2IlluminaID, IlluminaID2nuID

Examples

## load example data
data(example.lumi)
if (require(lumiHumanIDMapping)) {
chipInfo <- getChipInfo(example.lumi, species='Human')
chipInfo
}

getChrInfo

get the chromosome location information of methylation probes

Description

get the chromosome location information of methylation probes

Usage

getChrInfo(methyData, lib = NULL, ...)

Arguments

methyData

a MethyLumiM object

lib

...

Methylation annotation library
optional arguments to addAnnotationInfo.

getControlData

Value

a data.frame

Author(s)

Pan Du

29

getControlData

Get control probe information

Description

Get control probe information from Bead Studio output or a LumiBatch object.

Usage

getControlData(x, type = c('data.frame', 'LumiBatch'), ...)

Arguments

x

type

...

Value

the control data can be a LumiBatch object or the Control Probe Profile file
outputted by BeadStudio

determine the return data type
other parameters used by lumiR function

By default, it returns a data.frame with first two columns as "controlType" and "ProbeID". The
rest columns are the expression amplitudes for individual samples. When type is ’LumiBatch’, it
returns a LumiBatch object, which basically is the return of lumiR without combining duplicated
TargetIDs. As the return is a LumiBatch object, it includes more information, like probe number,
detection p-value and standard error of the measurement.

Author(s)

Pan Du

See Also

addControlData2lumi

Examples

controlFile <- system.file('doc', 'Control_Probe_Profile.txt', package='lumi')
if (file.exists(controlFile)) {

## return a data.frame
controlData <- getControlData(controlFile)
class(controlData)
names(controlData)

## return a LumiBatch object
controlData <- getControlData(controlFile, type='LumiBatch')

30

}

summary(controlData)

getControlProbe

getControlProbe

Get the control probe Ids

Description

Get the control probe Ids corresponding to the control probe type provided. The control probe ids
are kept in the second column of controlData data.frame.

Usage

getControlProbe(controlData, type = NULL)

Arguments

controlData

type

Value

a LumiBatch object including control data or a control data data.frame

the type of control probe (case insensitive), which can be get by using getControlType
function

returns the corresponding probe Ids for the control type.

Author(s)

Pan Du

See Also

addControlData2lumi

Examples

controlFile <- system.file('doc', 'Control_Probe_Profile.txt', package='lumi')
if (file.exists(controlFile)) {

## return a data.frame
controlData <- getControlData(controlFile)
getControlType(controlData)
getControlProbe(controlData, type='housekeeping')

}

getControlType

31

getControlType

Get the types of the control probes

Description

Get the types of the control probes, which is in the first column of the controlData data.frame for
LumiBatch objects. For methylation data, it is the return of controlTypes function

Usage

getControlType(controlData)

Arguments

controlData

Value

a LumiBatch object including control data, a control data data.frame, or a Methy-
LumiQC object for methylation data

return the unique type of control probe type.

Author(s)

Pan Du

See Also

addControlData2lumi, controlTypes for methylation data

Examples

controlFile <- system.file('doc', 'Control_Probe_Profile.txt', package='lumi')
if (file.exists(controlFile)) {

## return a data.frame
controlData <- getControlData(controlFile)
getControlType(controlData)

}

getNuIDMappingInfo

get the mapping information from nuID to RefSeq ID

Description

Get the mapping information (including mapping quality information) of nuIDs to the most recent
RefSeq release. These information was kept in the IDMapping libraries.

Usage

getNuIDMappingInfo(nuID = NULL, lib.mapping)

32

Arguments

nuID

a vector of nuIDs. If it is NULL, all mappings will be returned.

hist-methods

lib.mapping

the ID mapping library

Details

The function basically return the nuID mapping information kept in the "nuID\_MappingInfo" table
of IDMapping libraries (lumiHumanIDMapping, lumiMouseIDMapping, lumiRatIDMapping). For
more details of nuID mapping, please refer to the help of corresponding IDMapping library.

Value

It returns a data.frame with each row corresponding to an input nuID.

Author(s)

Warren Kibbe, Pan Du, Simon Lin

Examples

## load example data
data(example.lumi)
if (require(lumiHumanIDMapping)) {
nuIDs <- featureNames(example.lumi)
mappingInfo <- getNuIDMappingInfo(nuIDs, lib.mapping='lumiHumanIDMapping')
head(mappingInfo)
}

hist-methods

Density plot of a ExpressionSet object

Description

Creating density plot of sample intensities in a ExpressionSet object. It is equivalent to density-
methods.

Usage

## S4 method for signature 'ExpressionSet'
hist(x, ...)

Arguments

x

...

See Also

a ExpressionSet object

other parameters for density-methods function

LumiBatch-class, density-methods, hist

id2seq

Examples

## load example data
data(example.lumi)

hist(example.lumi)

33

id2seq

Transfer a nuID as a nucleotide sequence

Description

The nuID (nucleotide universal identifier) is uniquely corresponding to probe sequence. The nuID
is also self-identification and error checking

Usage

id2seq(id)

Arguments

id

Details

a nuID (nucleotide universal identifier)

A reverse of seq2id. Please refer to reference for more details.

Value

a string of nucleotide sequence

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

seq2id

Examples

seq <- 'ACGTAAATTTCAGTTTAAAACCCCCCG'
id <- seq2id(seq)
id
id2seq(id)

34

IlluminaID2nuID

IlluminaID2nuID

Matching Illumina IDs to nuID based on Illumina ID mapping library

Description

Matching Illumina IDs to nuID based on Illumina ID mapping libraries.

Usage

IlluminaID2nuID(IlluminaID, lib.mapping=NULL, species = c("Human", "Mouse", "Rat", "Unknown"), chipVersion = NULL, ...)

Arguments

IlluminaID

lib.mapping

species

a vector of Illumina IDs

the ID mapping library. If it is provided, the parameter "species" will be ignored.

the species of the chip designed for. If users do not know it, it can be set as
"Unknown".

chipVersion

chipVersion information returned by function getChipInfo

...

other parameters of getChipInfo

Details

When the parameter "chipVersion" is not provided, this function basically returned the "idMapping"
item returned by function getChipInfo.

Value

The mapping information from Illumina ID to nuID. It will be a matrix with each column corre-
sponding to one matched manifest file when parameter "returnAllMatches" is TRUE. In this case,
the columns are sorted from the best match to worst. If IlluminaID is NULL and chipVersion is
provided, it will return all mapping information of the chip.

Author(s)

Pan Du

See Also

getChipInfo, nuID2IlluminaID

importMethyIDAT

35

importMethyIDAT

Import Illumina methylation .idat files as an MethyLumiM object

Description

Import Illumina methylation .idat files as an MethyLumiM object. An extension of lumIDAT func-
tion

Usage

importMethyIDAT(sampleInfo, dataPath = getwd(), lib = NULL, bigMatrix=FALSE, dir.bigMatrix='.', savePrefix.bigMatrix, ...)

Arguments

sampleInfo

dataPath

lib

bigMatrix

A data.frame of sample information or a character vector of barcodes.

The path of .idat files

Annotation library

whether to save the data as BigMatrix (designed for very large dataset)

dir.bigMatrix

the parent directory to save the BigMatrix data files

savePrefix.bigMatrix

the folder name prefix of the directory to save the BigMatrix data files. The fold
name will be like this: paste(savePrefix.bigMatrix, ’_bigmat’, sep=”)
other parameters used by lumIDAT function

...

Details

This function is an extension of lumIDAT. It adds sample information and probe annotation in-
formation to the data. As Illumina organizes the output .idat files by barcodes, the function will
automatically check the sub-folders in the names of barcodes for .idat files. The "sampleInfo" pa-
rameter can be either a barcode vector, e.g., "7310440039_R04C02" "7310440039_R05C02". Or a
data.frame with required columns of ’Sentrix_Barcode’ and ’Sentrix_Position’. If "sampleInfo" is
a data.frame, it will be added as the pData of the output MethyLumiM object.

Value

A MethyLumiM object

Author(s)

Pan Du, Tim Triche

See Also

lumIDAT, lumiMethyR, addAnnotationInfo

36

inverseVST

inverseVST

Inverse VST transform

Description

Inverse transform of VST (variance stabilizing transform), see vst.

Usage

inverseVST(x, fun = c('asinh', 'log'), parameter)

Arguments

x

fun

a VST transformed LumiBatch object or a numeric matrix or vector

function used in VST transform

parameter

parameter of VST function

Details

Recover the raw data from VST transformed data returned by vst. This function can be directly
applied to the VST transformed or VST + RSN normalized LumiBatch object to reverse transform
the data to the original scale.

Value

Return the raw data before VST transform

Author(s)

Pan Du

References

Lin, S.M., Du, P., Kibbe, W.A., "Model-based Variance-stabilizing Transformation for Illumina
Mi-croarray Data", submitted

See Also

vst

Examples

## load example data
data(example.lumi)

## get the gene expression mean for one chip
u <- exprs(example.lumi)[,1]
## get the gene standard deviation for one chip
std <- se.exprs(example.lumi)[,1]

## do variance stabilizing transform
transformedU <- vst(u, std)

is.nuID

37

## do inverse transform and recover the raw data
parameter <- attr(transformedU, 'parameter')
transformFun <- attr(transformedU, 'transformFun')
recoveredU <- inverseVST(transformedU, fun=transformFun, parameter=parameter)

## compare with the raw data
print(u[1:5])
print(recoveredU[1:5])

## do inverse transform of the VST + RSN processed data
lumi.N <- lumiExpresso(example.lumi[,1:2])
## Inverse transform.
## Note: as the normalization is involved, the processed data will be different from the raw data.
lumi.N.raw <- inverseVST(lumi.N)

is.nuID

nuID self-identification

Description

Self-identify nuID (nucleotide universal identifier) by verify the check code value and the checksum
value

Usage

is.nuID(id)

Arguments

id

Value

nuId or other string

Return TRUE if id is a nuID, or else return FALSE.

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

seq2id, id2seq

38

Examples

## check the function using a random sequence
id <- 'adfasdfafd'
is.nuID(id) # FALSE

## check the function using a read nuID
seq <- 'ACGTAAATTTCAGTTTAAAACCCCCCG'
id <- seq2id(seq)
is.nuID(id) # TRUE

lumiB

lumiB

Background correction of Illumina Expression data

Description

Background correction of Illumina Expression data

Usage

lumiB(x.lumi, method = c('none', 'bgAdjust', 'forcePositive', 'bgAdjust.affy'), verbose = TRUE, ...)

Arguments

x.lumi

method

verbose

...

Details

an ExpressionSet inherited object or a data matrix with columns as samples and
rows as genes. For ’bgAdjust’ method, it should be a LumiBatch Object

the background correction method, it can be any function with a ExpressionSet
Object or matrix as the first argument and return an processed object with the
same class

a boolean to decide whether to print out some messages

other parameters used by the user provided background correction method

We assume the BeadStudio output data is background corrected. So by default, it will do nothing.
The ’bgAdjust’ method will estimate the background based on the control probe information, which
is kept in the controlData slot of LumiBatch object. The ’forcePositive’ method will force all ex-
pression values to be positive by adding an offset (minus minimum value plus one), it does nothing
if all expression values are positive. The purpose of this is to avoid NA when do logarithm transfor-
mation. ’none’ does not but return the LumiBatch object. ’bgAdjust.affy’ will call the bg.adjust
function in affy package. User can also provide their own function with a LumiBatch Object as the
first argument and return a LumiBatch Object with background corrected.

Thanks Kevin Coombes (M.D. Anderson Cancer Center) suggested adding this function.

Value

Return an object with background corrected. The class of the return object is the same as the input
object x.lumi.

39

LumiBatch-class

Author(s)

Pan Du, Kevin Coombes

See Also

bgAdjust, lumiExpresso

Examples

## load example data
data(example.lumi)

## Do the default background correction method
lumi.B <- lumiB(example.lumi, method='bgAdjust', probs=0)

LumiBatch-class

Class LumiBatch: contain and describe Illumina microarray data

Description

This is a class representation for Illumina microarray data. It extends ExpressionSet.

Extends

Directly extends class ExpressionSet.

Creating Objects

new("LumiBatch", exprs = [matrix],se.exprs = [matrix],beadNum = [matrix],detection =
[matrix], phenoData = [AnnotatedDataFrame], history = [data.frame], ...)
LumiBatch instances are usually created through new("LumiBatch", ...). The arguments to new
should include exprs and se.exprs, others can be missing, in which case they are assigned default
values.
Objects can be created using the function lumiR.

Slots

Slot specific to LumiBatch:

history: a data.frame recording the operation history of the LumiBatch object.
controlData: a data.frame with first two columns as "controlType" and "ProbeID". The rest

columns are the control probe expression amplitudes for individual samples.

QC: a the quality control information of the LumiBatch object, returned by lumiQ function.

Slots inherited from ExpressionSet:

assayData contains equal dimensional matrices: exprs (contains gene expression level, which is
the mean of its bead replicates.), se.exprs (contains gene expression standard error, which
is the standard error of its bead replicates.), beadNum (records the number of beads for the
probe.), detection (records the detection p-value of the probe. The number is from [0,1].
By default, < 0.01 indicates good detection.). For more details of assayData, please see
ExpressionSet

40

LumiBatch-class

phenoData: See eSet
experimentData: See eSet
annotation: See eSet

Methods

Class-specific methods:

se.exprs(LumiBatch), se.exprs(LumiBatch,matrix)<-: Access and set elements named se.exprs

in the AssayData-class slot.

beadNum(LumiBatch), beadNum(LumiBatch)<-: Access and set elements named beadNum in the
AssayData-class slot. Use "beadNum(LumiBatch) <- NULL" to remove the beadNum ele-
ment.

detection(LumiBatch), detection(LumiBatch)<-: Access and set elements named detection
in the AssayData-class slot. Use "detection(LumiBatch) <- NULL" to remove the detection
element.

getHistory(LumiBatch): Access the operation history of LumiBatch object.

Derived from ExpressionSet (For the directly inherited methods, please see ExpressionSet and
eSet):

combine(LumiBatch,missing): Combine two LumiBatch objects, including history slot. See

eSet

exprs(LumiBatch), exprs(LumiBatch,matrix)<-: Access and set elements named exprs in the

AssayData-class slot.

object[(i,j): Conduct subsetting of the data in a LumiBatch object

Standard generic methods (For the directly inherited methods, please see ExpressionSet and
eSet):

initialize(LumiBatch): Object instantiation, used by new; not to be called directly by the user.
validObject(LumiBatch): Validity-checking method, ensuring that exprs and se.exprs is a
member of assayData. Other validity check is the same as checkValidity(ExpressionSet).

show(LumiBatch) A summary of the LumiBatch object.

Author(s)

Pan Du, Simon Lin

See Also

lumiR, lumiT, lumiN, boxplot-methods, pairs-methods, MAplot-methods

Examples

## load example data
data(example.lumi)

## show the summary of the data
# summary(example.lumi)
example.lumi

## get expression matrix

41

lumiExpresso

temp <- exprs(example.lumi)

## get a subset
temp <- example.lumi[,1] ## retrieve the first sample

## get the probe id
featureNames(example.lumi)[1:3]

## combine LumiBatch objects
temp <- combine(example.lumi[,1], example.lumi[,3])
temp

lumiExpresso

From raw Illumina probe intensities to expression values

Description

Goes from raw Illumina probe intensities to expression values

Usage

lumiExpresso(lumiBatch, bg.correct = TRUE, bgcorrect.param = list(method='bgAdjust'), variance.stabilize = TRUE,
varianceStabilize.param = list(), normalize = TRUE, normalize.param = list(), QC.evaluation = TRUE,
QC.param = list(), verbose = TRUE)

Arguments

lumiBatch

a LumiBatch object, which can be the return of lumiR

bg.correct
bgcorrect.param

a boolean to decide whether to do background correction or not

a list of parameters of lumiB

variance.stabilize

a boolean to decide whether to do variance stabilization or not

varianceStabilize.param

a list of parameters of lumiT

normalize
normalize.param

QC.evaluation

QC.param

verbose

Details

a boolean to decide whether to do normalization or not

a list of parameters of lumiN

a boolean to decide whether to do quality control estimation before and after
preprocessing
a list of parameters of lumiQ

a boolean to decide whether to print out some messages

The function is to encapsulate the major functions of Illumina preprocessing. It is organized in a
similar way as the expresso function in affy package.

42

Value

lumiMethyB

return a processed LumiBatch object. The operation history can be track in the history slot of the
object.

Author(s)

Pan Du

See Also

lumiB, lumiT, lumiN

Examples

## load example data
data(example.lumi)

## Do all the default preprocessing in one step
lumi.N <- lumiExpresso(example.lumi)

## Do customized preprocessing. No variance stabilizing or log transform, use Quantile normalization.
lumi.N <- lumiExpresso(example.lumi, variance.stabilize=FALSE, normalize.param = list(method='quantile'))

lumiMethyB

Adjust background level of Illumina Infinium methylation data

Description

Adjust background level of Illumina Infinium methylation data, which is an object in MethyLumiM
class.

Usage

lumiMethyB(methyLumiM, method = c("bgAdjust2C", "forcePositive", "none"), separateColor = FALSE, verbose = TRUE, overwriteBigMatrix=FALSE, ...)

Arguments

methyLumiM

method

a MethyLumiM object includes Illumina Infinium methylation data

background adjustment methods or user provided function, whose input and
output should be a intensity matrix (pool of methylated and unmethylated probe
intensities)

separateColor

determine whether to separately process two color channels

verbose
overwriteBigMatrix

a boolean to decide whether to print out some messages

whether to overwrite the result to the BigMatrix data, only valid when the input
data is BigMatrix-based

...

other parameters used by corresponding method

lumiMethyC

Value

43

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after background level adjustment.

Author(s)

Pan DU

See Also

See Also bgAdjustMethylation and estimateMethylationBG

Examples

data(example.lumiMethy)
lumiMethy.bgAdj = lumiB(example.lumiMethy)
attr(lumiMethy.bgAdj, "EstimatedBG")

lumiMethyC

Color bias adjust of Illumina Infinium methylation data

Description

Color bias adjust of Illumina Infinium methylation data, which is an object in MethyLumiM class.

Usage

lumiMethyC(methyLumiM, method = c("quantile", "ssn", "none"), verbose = TRUE, overwriteBigMatrix=FALSE, ...)

Arguments

methyLumiM

method

a MethyLumiM object includes Illumina Infinium methylation data

color bias adjustment methods or user provided function, see "details" for more
information of user defined function.

verbose
overwriteBigMatrix

a boolean to decide whether to print out some messages

whether to overwrite the result to the BigMatrix data, only valid when the input
data is BigMatrix-based

other parameters used by corresponding method

...

Details

The first two arguments of the user defined function should be two intensity matrix (pool of methy-
lated and unmethylated probe intensities) of red and green channel respectively. The return of the
user defined function should be a list including color adjusted matrix of red and green channel.
For example: return(list(red=redData, green=grnData)). "redData" and "grnData" are two color
adjusted matrix.

Value

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after background level adjustment.

lumiMethyN

44

Author(s)

Pan DU

See Also

See Also adjColorBias.quantile and adjColorBias.ssn

Examples

data(example.lumiMethy)
# before adjustment
plotColorBias1D(example.lumiMethy)
# plot in 2D plot of one selected sample
plotColorBias2D(example.lumiMethy, selSample = 1)
lumiMethy.adj = lumiMethyC(example.lumiMethy)
# after adjustment
plotColorBias1D(lumiMethy.adj)
# plot in 2D plot of one selected sample
plotColorBias2D(lumiMethy.adj, selSample = 1)

lumiMethyN

Normalize the Illumina Infinium methylation data

Description

Normalize the Illumina Infinium methylation data, which is an object in MethyLumiM class.

Usage

lumiMethyN(methyLumiM, method = c("quantile", "ssn", "none"), separateColor = FALSE, verbose = TRUE, overwriteBigMatrix = FALSE, ...)

Arguments

methyLumiM

method

a MethyLumiM object includes Illumina Infinium methylation data

supported normalization methods or user provided function, whose input and
output should be a intensity matrix (pool of methylated and unmethylated probe
intensities)

separateColor

determine whether to separately process two color channels

verbose
overwriteBigMatrix

a boolean to decide whether to print out some messages

whether to overwrite the result to the BigMatrix data, only valid when the input
data is BigMatrix-based

other parameters used by corresponding method

...

Value

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after background level adjustment.

Author(s)

Pan DU

lumiMethyR

See Also

See Also normalizeMethylation.ssn and normalizeMethylation.quantile

Examples

data(example.lumiMethy)
lumiMethy.norm = lumiN(example.lumiMethy)

45

lumiMethyR

Reading Illumina methylation microarray data

Description

This function is a wrap of methylumiR function in methylumi package.

Usage

lumiMethyR(filename, lib=NULL, controlData=NULL, qcfile=NULL, sampleDescriptions=NULL, sep = NULL)

Arguments

filename

lib

controlData

qcfile
sampleDescriptions

file name output by GenomeStudio

Annotation library of Illumina methylation microarray

the controlData file name or a MethyLumiQC object to be added to the "con-
trolData" slot of the MethyLumiM object
parameter of methylumiR function

parameter of methylumiR function
parameter of methylumiR function

sep

Details

This function is a wrap of methylumiR function in methylumi package. It will coerce the returned
object as MethyLumiM class. The methylated and unmethylated probe intensity information is
required for color-bias adjustment and normalization. If users have the Illumina IDAT files, we
suggest use importMethyIDAT function to import the data. The importMethyIDAT function will
automatically retrieve the required information and return a MethyLumiM object.

Value

return a MethyLumiM object

Author(s)

Pan Du

See Also

See Also importMethyIDAT, methylumiR and addControlData2methyLumiM

46

lumiMethyStatus

lumiMethyStatus

Estimate the methylation status of individual methylation sites

Description

Estimate the methylation status of individual methylation sites by fitting a two component Gamma
mixture model for each sample

Usage

lumiMethyStatus(methyLumiM, ...)

Arguments

methyLumiM

a MethyLumiM class object

...

Other parameters used by methylationCall

Details

This function calls methylationCall and returns the methylation status of individual methylation
sites. The methylation status includes: "Unmethy" (unmethylation probability > unmethylation
threshold), "Methy" (methylation probability > methylation threshold), or "Margin". The methyla-
tion probability is returned as an attribute of "probability".

Value

return a methylation status matrix with "probability" attribute

Author(s)

Pan Du

See Also

See Also methylationCall and gammaFitEM

Examples

data(example.lumiMethy)
methyCall <- lumiMethyStatus(example.lumiMethy)
head(methyCall)

lumiN

47

lumiN

Between chip normalization of a LumiBatch object

Description

A main function of between chip normalization of a LumiBatch object. Currently, four methods
("rsn", "ssn", "quantile", "loess", "vsn") are supported.

Usage

lumiN(x.lumi, method = c("quantile", "rsn", "ssn", "loess", "vsn", "rankinvariant"), verbose = TRUE, ...)

Arguments

x.lumi

method

verbose
...

Details

an ExpressionSet inherited object or a data matrix with columns as samples and
rows as genes
five different between chips normalization methods ("quantile", "rsn", "ssn",
"loess", "vsn", "rankinvariant") are supported
a boolean to decide whether to print out some messages
other parameters used by corresponding method

lumiN is an interface for different normalization methods. Currently it supports "RSN" (See rsn),
"SSN" (See ssn), "loess" (See normalize.loess), "quantile" (See normalize.quantiles), "VSN"
(See vsn) and "rankinvariant" (See rankinvariant) . See details in individual functions. Note: the
"VSN" normalization should be directly applied to the raw data instead of the lumiT processed data.

Value

Return an object with expression values normalized. The class of the return object is the same as
the input object x.lumi. If it is a LumiBatch object, it also includes the VST transform function and
its parameters as attributes: "transformFun", "parameter". See inverseVST for details.

Author(s)

Pan Du, Simon Lin

See Also

rsn, ssn, rankinvariant

Examples

## load example data
data(example.lumi)

## Do lumi transform
lumi.T <- lumiT(example.lumi)

## Do lumi between chip normaliazation
lumi.N <- lumiN(lumi.T, method='rsn', ifPlot=TRUE)

48

lumiQ

lumiQ

Quality control evaluation of the LumiBatch object

Description

Quality control evaluation of the LumiBatch object and returns a summary of the data

Usage

lumiQ(x.lumi, logMode = TRUE, detectionTh = 0.01, verbose = TRUE)

Arguments

x.lumi

logMode

detectionTh

verbose

Details

a LumiBatch object

transform as log2 or not (the function can check whether it is already log trans-
formed.)
the detection threshold used by detectionCall
a boolean to decide whether to print out some messages

Quality control of a LumiBatch object includes estimating the mean and standard deviation of the
chips, detectable probe ratio of each chip, sample (chip) relations, detecting outliers of samples
(chips). The produced QC information is kept in the QC slot of LumiBatch class. The summary
function will provide a summary of the QC information (See example).

Value

a LumiBatch object with QC slot keeping the QC information

Author(s)

Pan Du

See Also

LumiBatch, plot,ExpressionSet-method

Examples

## load example data
data(example.lumi)

## Do quality control estimation
lumi.Q <- lumiQ(example.lumi)

## A summary of the QC
summary(lumi.Q, 'QC')

## Plot the results
## plot the pairwise sample correlation
plot(lumi.Q, what='pair')

lumiR

49

## see more examples in "plot,ExpressionSet-method" help documents

lumiR

Read in Illumina expression data

Description

Read in Illumina expression data. We assume the data was saved in a comma or tab separated text
file.

Usage

lumiR(fileName, sep = NULL, detectionTh = 0.01, na.rm = TRUE, convertNuID = TRUE, lib.mapping = NULL, dec = '.', parseColumnName = FALSE, checkDupId = TRUE,
QC = TRUE, columnNameGrepPattern = list(exprs='AVG_SIGNAL', se.exprs='BEAD_STD', detection='DETECTION', beadNum='Avg_NBEADS'),
inputAnnotation=TRUE, annotationColumn=c('ACCESSION', 'SYMBOL', 'PROBE_SEQUENCE', 'PROBE_START', 'CHROMOSOME', 'PROBE_CHR_ORIENTATION', 'PROBE_COORDINATES', 'DEFINITION'), verbose = TRUE, ...)

Arguments

fileName

sep

detectionTh

na.rm

convertNuID

lib.mapping

dec

parseColumnName

fileName of the data file

the separation character used in the text file.

the p-value threshold of determining detectability of the expression. See more
details in lumiQ

determine whether to remove NA

determine whether convert the probe identifier as nuID
a Illumina ID mapping package, e.g, lumiHumanIDMapping, used by addNuID2lumi

the character used in the file for decimal points.

checkDupId

QC

determine whether to parse the column names and retrieve the sample informa-
tion (Assume the sample information is separated by "\_".)

determine whether to check duplicated TargetIDs or ProbeIds. The duplicated
ones will be averaged.

determine whether to do quality control assessment after read in the data.

columnNameGrepPattern

the string grep patterns used to determine the slot corresponding columns.

inputAnnotation

determine whether input the annotation information outputted by BeadStudio if
exists.

annotationColumn

the column names of the annotation information outputted by BeadStudio

verbose

...

a boolean to decide whether to print out some messages
other parameters used by read.table function

50

Details

lumiR

The function can automatically determine the separation character if it is Tab or comma. Otherwise,
the user should specify the separator manually. If the annotation library is provided, the Illumina Id
will be replaced with nuID, which is used as the index Id for the lumi annotation packages. If the
annotation library is not provided, it will try to directly convert the probe sequence (if provided in
the BeadStudio output file) as nuIDs.

The parameter "columnNameGrepPattern" is designed for some advanced users. It defines the string
grep patterns used to determine the slot corresponding columns. For example, for the "exprs" slot
in LumiBatch object, it is composed of the columns whose name includes "AVG\_SIGNAL". In
some cases, the user may not want to read the "detection" and "beadNum" related columns to save
memory. The user can set the "detection" and "beadNum" as NA in "columnNameGrepPattern". If
the ’se.exprs’ is set as NA or the corresponding columns are not available, then lumiR will create a
ExpressionSet object instead of LumiBatch object.

The parameter "parseColumnName" is designed to parse the column names and retrieve the sample
information. We assume the sample information is separated by "\_" and the last element after "\_"
is the sample label (sample names of the LumiBatch object). If the parsed sample labels are not
unique, then the entire string will be used as the sample label. For example: "1881436055\_A\_STA
27aR" is included in one of the column names of BeadStudio output file. Here, the program will first
treat "STA 27aR" as the sample label. If it is not unique across the samples, "1881436055\_A\_STA
27aR" will be the sample label.
If it is still not unique, the program will report warning mes-
sages. All the parsed information is kept in the phenoData slot. By default, "parseColumnName" is
FALSE. We suggest the users use it only when they know what they are doing.

Current version of lumiR can adaptively read the output of BeadStudio Verson 1 and 3. The format
Version 3 made quite a few changes comparing with previous versions. One change is the detection
value.
It was called detectable when the detection value is close to one for Version 1 format.
However, the detection value became a p-value in the Version 3. As a result, the detectionTh
is automatically changed based on the version. The detectionTh 0.01 for the Version 3 will be
changed as the detectionTh 0.99 for Version 1. Another big change is that Version 3 separately
output the control probe (gene) information and a "Samples Table". As a result, the controlData slot
in LumiBatch class was added to keep the control probe (gene) information, and a QC slot to keep
the quality control information, including the "Sample Table" output by BeadStudio version 3.

The recent version of BeadStudio can also output the annotation information together with the ex-
pression data. In the users also want to input the annotation information, they can set the parameter
"inputAnnotation" as TRUE. At the same time, they can also specify which columns to be inputted
by setting parameter "annotationColumn". The BeadStudio annotation columns include: SPECIES,
TRANSCRIPT, ILMN\_GENE, UNIGENE\_ID, GI, ACCESSION, SYMBOL, PROBE\_ID, AR-
RAY\_ADDRESS\_ID, PROBE\_TYPE, PROBE\_START, PROBE\_SEQUENCE, CHROMOSOME,
PROBE\_CHR\_ORIENTATION, PROBE\_COORDINATES, DEFINITION, ONTOLOGY\_COMPONENT,
ONTOLOGY\_PROCESS, ONTOLOGY\_FUNCTION, SYNONYMS, OBSOLETE\_PROBE\_ID.
As the annotation data is huge, by default, we only input: ACCESSION, SYMBOL, PROBE\_START,
CHROMOSOME, PROBE\_CHR\_ORIENTATION, PROBE\_COORDINATES, DEFINITION. This
annotation information is kept in the featureData slot of ExpressionSet, which can be retrieved using
pData(featureData(x.lumi)), suppose x.lumi is the LumiBatch object. As some annotation informa-
tion may be outdated. We recommend using Bioconductor annotation packages to retrieve the
annotation information.

The BeadStudio may output either STDEV or STDERR (standard error of the mean) columns.
As the variance stabilization (see vst function) requires the information of the standard deviation
instead of the standard error of the mean, the value correction is required. The lumiR function will
automatically check whether the BeadStudio output file includes STDEV or STDERR columns. If
it is STDERR columns, it will correct STDERR as STDEV. The corrected value will be x * sqrt(N),

lumiR.batch

51

where x is the STDERR value (standard error of the mean), N is the number of beads corresponding
to the probe. (Thanks Sebastian Balbach and Gordon Smyth kindly provided this information.).
This correction was previous implemented in the lumiT function.

Value

return a LumiBatch object

Author(s)

Simon Lin, Pan Du

See Also

LumiBatch, addNuID2lumi

Examples

## specify the file name
# fileName <- 'Barnes_gene_profile.txt' # Not Run
## load the data
# x.lumi <- lumiR(fileName)

## load the data with empty detection and beadNum slots
# x.lumi <- lumiR(fileName, columnNameGrepPattern=list(detection=NA, beadNum=NA))

lumiR.batch

Read BeadStudio output files in batch

Description

Read BeadStudio output files in batch and combine them as a single LumiBatch object

Usage

lumiR.batch(fileList, convertNuID = TRUE, lib.mapping = NULL, detectionTh = 0.01, QC = TRUE, transform = c('none', 'vst', 'log2', 'cubicRoot'), sampleInfoFile = NULL, verbose = TRUE, ...)

Arguments

fileList

convertNuID

lib.mapping

detectionTh

QC

a vector of file names or a directory keeping the data files in the format of .csv

determine whether convert the probe identifier as nuID
same as lumiR parameter lib.mapping (optional)
the p-value threshold of determining detectability of the expression. See more
details in lumiQ
determine whether to do quality control assessment after read in the data.

transform
sampleInfoFile a Tab-separated text file or a data.frame keeping the sample information (op-

determine whether to do transform after input each file

tional)

verbose

...

a boolean to decide whether to print out some messages
other parameters used by lumiR

52

Details

lumiT

The function basically call lumiR for individual files and then combine the returns. The sampleIn-
foFile parameter is optional. It provides the sample information (for phenoData slot in LumiBatch
object), it is a Tab-separated text file. ID column is required. It represents sample ID, which is
defined based on the column names of BeadStudio output file. For example, sample ID of col-
umn "1881436070\_A\_STA.AVG\_Signal" is "1881436070\_A\_STA". The sample ID column
can also be found in the "Samples Table.txt" file output by BeadStudio. Another "Label" column (if
provided) will be used as the sampleNames of LumiBatch object. All information of sampleInfoFile
will be directly added in the phenoData slot in LumiBatch object.

To save memory space in the case of reading large data set, we can do transformation using lumiT
function right after input the data, and the information like se.exprs, beadNum will be removed
from the LumiBatch object after transformation.

Value

A LumiBatch object which combines the individual LumiBatch object corresponding to each file

Author(s)

Pan Du

See Also

lumiR

Examples

## fileList <- c('file1.csv', 'file2.cvs')
## x.lumi <- lumiR.batch(fileList, sampleInfoFile='sampleInfo.txt')

lumiT

Transfer the Illumina data to stabilize the variance

Description

Transfer the Illumina data to stabilize the variance.

Usage

lumiT(x.lumi, method = c("vst", 'log2', 'cubicRoot'), ifPlot = FALSE, simpleOutput = TRUE, verbose = TRUE, ...)

Arguments

x.lumi

method

ifPlot

simpleOutput

verbose

...

LumiBatch object

four methods are supported: "vst", "log2", "cubicRoot"

determine whether to plot the intermediate results

determine whether to simplify the output LumiBatch object, which will set the
se.exprs, detection and beadNum slots as NULL.

a boolean to decide whether to print out some messages
other parameters used by vst

m2beta

Details

53

lumiT is an interface of difference variance stabilizing transformation. See vst for details of VST
(Variance Stabilizing Transform) of Illumina data.

NOTE: This correction of STDERR as STDEV was moved to the lumiR function.

Value

Return a LumiBatch object with transformed expression values. It also includes the VST transform
function and its parameters as attributes: "transformFun", "parameter". See inverseVST for details.

Author(s)

Pan Du, Simon Lin

References

Lin, S.M., Du, P., Kibbe, W.A., (2008) ’Model-based Variance-stabilizing Transformation for Illu-
mina Microarray Data’, Nucleic Acids Res. 36, e11

See Also

vst

Examples

## load example data
data(example.lumi)

## Do default VST variance stabilizing transform
lumi.T <- lumiT(example.lumi, ifPlot=TRUE)

m2beta

Convert methylation M-value to Beta-value

Description

Convert methylation M-value to Beta-value

Usage

m2beta(m)

Arguments

m

Details

a matrix or vector of methylation M-value

Convert methylation M-value to Beta-value

54

Value

return methylation Beta-value with the same size of input M-value

MAplot-methods

Author(s)

Pan Du

References

Du, P., Zhang, X, Huang, C.C., Jafari, N., Kibbe, W.A., Hou, L., and Lin, S.M., (2010) ’Comparison
of Beta-value and M-value methods for quantifying methylation levels by microarray analysis’,
(under review)

See Also

See Also as beta2m

MAplot-methods

MAplot of a ExpressionSet object

Description

Creating pairwise MAplot of sample intensities in a ExpressionSet object

Usage

## S4 method for signature 'ExpressionSet'
MAplot(object, ..., smoothScatter = FALSE, logMode = TRUE, subset = 5000, main = NULL)

Arguments

...

object

an ExpressionSet object
optional arguments to MAplot.
smoothScatter whether use smoothScatter function to plot points
logMode

whether plot the data in log2 scale or not

subset

main

Details

subset of rows used to plot. It can be an index vector, or the length of a random
subset

title of the plot

To increase the plot efficiency, by default, we only plot RANDOMLY selected subset of points
(based on parameter "subset").
If users want to plot all the points, they can set the parameter
"subset = NULL". When smoothScatter is set as TRUE, the subsetting will be suppressed because
smoothScatter function has good plot efficiency for large number of points.

See Also

LumiBatch-class, MAplot

55

methylationCall

Examples

## load example data
data(example.lumi)

MAplot(example.lumi)

MAplot(example.lumi, smoothScatter=TRUE)

methylationCall

Estimated methylation call

Description

Estimated methylation call based on the fitting results of gammaFitEM

Usage

methylationCall(x, threshold = 0.95, ...)

Arguments

x

threshold

...

Details

a vector of M-values covering the whole genome or a "gammaFit" class object
returned by gammaFitEM

the probability threshold to make a methylation call. The threshold can be a
vector of two: unmethylation threshold and methylation threshold
other parameters used by gammaFitEM

Retrieve the probability element returned by gammaFitEM, and convert it as three status calls based
on probability threshold

NOTE: the methylation status modeling algorithm was developed based on 27K methylation array.
It has not been tested for 450K array. Considering 450K array covers both promoter and gene body,
the two component Gamma mixture model assumption may not be valid any more.

Value

A vector of three methylation status: "Unmethy" (unmethylation posterior probability > unmethyla-
tion threshold), "Methy" (methylation posterior probability > methylation threshold), or "Margin".
The sum of unmethylation posterior probability and methylation posterior probability equals one.
The methylation probability is returned as an attribute of "probability".

Author(s)

Pan DU

See Also

gammaFitEM

56

Examples

monoSmu

data(example.lumiMethy)
M <- exprs(example.lumiMethy)
fittedGamma <- gammaFitEM(M[,1], initialFit=NULL, maxIteration=50, tol=0.0001, plotMode=TRUE, verbose=FALSE)
methyCall <- methylationCall(fittedGamma)
table(methyCall)

monoSmu

Monotonic smooth method

Description

Fit the monotonic-constraint spline curve

Usage

monoSmu(x, y, newX = NULL, nSupport = min(200, length(x)), nKnots = 6, rotate = FALSE, ifPlot = FALSE, xlab = 'x', ylab = 'y', ...)

Arguments

x

y

newX

nSupport

nKnots

rotate

ifPlot

xlab

ylab

...

Details

a vector represents x values

a vector represents y values

the new values to be transformed. If not provided, "x" will be used.

downsampled data points
parameter used by monoSpline
determine whether to rotate the axis with 45 degrees in clockwise, i.e., fit the
curve in the MA-plot.

determine whether to plot intermediate results

the xlab of the plot

the ylab of the plot
parameters used by supsmu and plot

function called by lumiN.rsn. The function first fits a monotonic spline between vector x and y,
then transforms the vector newX based on the fitted spline. (After transformation the fitted spline is
supposed to be a diagonal line, i.e., x=y)

Value

Return the transformed "newX" based on the smoothed curve

Author(s)

Simon Lin, Pan Du

References

Lin, S.M., Du, P., Kibbe, W.A., (2008) ’Model-based Variance-stabilizing Transformation for Illu-
mina Microarray Data’, Nucleic Acids Res. 36, e11

monoSpline

See Also

monoSpline

57

monoSpline

Fitting a curve with monotonic spline

Description

Fitting a curve with monotonic spline

Usage

monoSpline(x, y, newX=NULL, nKnots = 6, ifPlot = FALSE)

Arguments

x

y

newX

nKnots

ifPlot

Details

a vector represents x values

a vector represents y values

the new values to be transformed. If not provided, "x" will be used.

parameter used by function smoothCon in package mgcv

determine whether to plot intermediate results

Function internally called by monoSmu

Value

return the transformed "newX" based on the smoothed curve

Author(s)

Simon Lin, Pan Du

See Also

monoSmu

58

normalizeMethylation.quantile

normalizeMethylation.quantile

Quantile normalization of Illumina Infinium methylation data at probe
level

Description

Quantile normalization of Illumina Infinium methylation data at probe level. Input data is a Methy-
LumiM object

Usage

normalizeMethylation.quantile(methyLumiM, separateColor = FALSE, reference = NULL, ...)

Arguments

methyLumiM

separateColor

reference

...

Value

a MethyLumiM object includes Illumina Infinium methylation data

determine whether separately normalize two color channels

the reference vector (same length as the number of matrix rows) for quanitle
normalization

other parameters used by normalize.quantiles.robust method

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after background level adjustment.

Author(s)

Pan DU

See Also

See Also lumiMethyN, and normalizeMethylation.ssn

Examples

data(example.lumiMethy)
lumiMethy.norm = normalizeMethylation.quantile(example.lumiMethy)

normalizeMethylation.ssn

59

normalizeMethylation.ssn

Shift and scaling normalization of Illumina Infinium methylation data
at probe level

Description

Shift and scaling normalization of Illumina Infinium methylation data at probe level

Usage

normalizeMethylation.ssn(methyLumiM, separateColor = FALSE)

Arguments

methyLumiM

separateColor

Value

a MethyLumiM object includes Illumina Infinium methylation data

determine whether separately normalize two color channels

Return an object (same class as input methyLumiM) with updated "methylated" and "unmethylated"
data matrix after background level adjustment.

Author(s)

Pan DU

See Also

See Also lumiMethyN, and normalizeMethylation.quantile

Examples

data(example.lumiMethy)
lumiMethy.norm = normalizeMethylation.ssn(example.lumiMethy)

nuID2EntrezID

Map nuID to Entrez ID

Description

Map nuID to EntrezID through RefSeq ID based on IDMapping libraries.

Usage

nuID2EntrezID(nuID = NULL, lib.mapping, filterTh = c(Strength1 = 95, Uniqueness = 95), returnAllInfo = FALSE)

60

Arguments

nuID

a vector of nuIDs. If it is NULL, all mappings will be returned.

nuID2EntrezID

lib.mapping

the ID mapping library

filterTh

returnAllInfo

the mapping quality filtering threshold used to filter the ID mapping.

determine to return the detailed mapping information or just the matched RefSeq
IDs

Details

This function is based on the return of getNuIDMappingInfo function. The mapping from nuID
to EntrezID was based on the mapping from nuID to RefSeqID and RefSeqID to EntrezID. It uses
mapping quality information to filter out the bad mappings from nuID to RefSeqID. The parameter
"filterTh" is obsolete for lumi ID mapping package > version 1.3, which only keeps the perfect map-
ping. For the old version of ID mapping package (< 1.3), the names of "filterTh" are basically the
field names of "nuID\_MappingInfo" table, which include ’Strength1’, ’Strength2’, ’Uniqueness’
and ’Total hits’. For the definition of these metrics, please refer to the IDMapping library or see the
reference website.

Value

returns the matched Entrez IDs or a data.frame with each row corresponding to an input nuID (when
"returnAllInfo" is TRUE).

Author(s)

Warren Kibbe, Pan Du, Simon Lin

References

https://prod.bioinformatics.northwestern.edu/nuID/

See Also

See Also getNuIDMappingInfo

Examples

## load example data
data(example.lumi)
if (require(lumiHumanIDMapping)) {

nuIDs <- featureNames(example.lumi)
mappingInfo <- nuID2EntrezID(nuIDs, lib.mapping='lumiHumanIDMapping')
head(mappingInfo)
}

nuID2IlluminaID

61

nuID2IlluminaID

Matching nuIDs to Illumina IDs based on Illumina ID mapping library

Description

Matching nuIDs to Illumina IDs based on Illumina ID mapping library

Usage

nuID2IlluminaID(nuID, lib.mapping=NULL, species = c("Human", "Mouse", "Rat", "Unknown"), idType=c('All', 'Probe', 'Gene', 'Accession', 'Search_key', 'Symbol'), chipVersion = NULL, ...)

Arguments

nuID
lib.mapping
species

idType
chipVersion
...

Details

a vector of nuIDs
the ID mapping library. If it is provided, the parameter "species" will be ignored.
the species of the chip designed for. If users do not know it, it can be set as
"Unknown".
the Illumina ID type
chipVersion information returned by function getChipInfo
other parameters of getChipInfo

The parameter "idType" represents different types of Illumina IDs. It returns the entire table when
idType = "All". When idType = ’Probe’, it returns "ProbeId" or "Probe\_Id". When idType =
’Gene’, it returns "Target" or "ILMN\_Gene" IDs.
This function basically returned the "idMapping" item returned by function getChipInfo. If nuID
is NULL and chipVersion is provided, it will return all mapping information of the chip.

Value

The mapping information from nuID to Illumina ID. It will be a matrix with each column corre-
sponding to one matched manifest file when parameter "returnAllMatches" is TRUE. In this case,
the columns are sorted from the best match to worst.

Author(s)

Pan Du

See Also

getChipInfo, IlluminaID2nuID

Examples

## load example data
data(example.lumi)
nuIDs <- featureNames(example.lumi)
if (require(lumiHumanIDMapping)) {
illuminaID <- nuID2IlluminaID(nuIDs[1:5], lib='lumiHumanIDMapping')
illuminaID
}

62

nuID2probeID

nuID2probeID

Mapping nuID into Illumina ProbeID

Description

Mapping nuID into Illumina ProbeID.

Usage

nuID2probeID(nuID, lib.mapping = "lumiHumanIDMapping", ...)

Arguments

nuID

a vector of nuID

lib.mapping

...

an Illumina ID mapping library
other parameters of nuID2IlluminaID

Details

The function will call nuID2IlluminaID when ID mapping library were provided.

Value

see function nuID2IlluminaID

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

probeID2nuID, nuID2IlluminaID

Examples

if (require(lumiHumanIDMapping)) {

nuID2probeID("B2J6WGhV.RevOJYff4", lib.mapping = "lumiHumanIDMapping")

}

nuID2RefSeqID

63

nuID2RefSeqID

Map nuID to RefSeq ID

Description

Map nuID to RefSeq ID based on IDMapping libraries.

Usage

nuID2RefSeqID(nuID = NULL, lib.mapping, filterTh = c(Strength1 = 95, Uniqueness = 95), returnAllInfo = FALSE)

Arguments

nuID

a vector of nuIDs. If it is NULL, all mappings will be returned.

lib.mapping

the ID mapping library

filterTh

returnAllInfo

the mapping quality filtering threshold used to filter the ID mapping. Obsolete
for lumi ID mapping package > version 1.3!

determine to return the detailed mapping information or just the matched RefSeq
IDs

Details

This function is based on the return of getNuIDMappingInfo function. It uses mapping quality
information to filter out the bad mappings. The parameter "filterTh" is obsolete for lumi ID mapping
package > version 1.3, which only keeps the perfect mapping. For the old version of ID mapping
package (< 1.3), the names of "filterTh" are basically the field names of "nuID\_MappingInfo" table,
which include ’Strength1’, ’Strength2’, ’Uniqueness’ and ’Total hits’. For the definition of these
metrics, please refer to the IDMapping library or see the reference website.

Value

returns the matched RefSeq IDs or a data.frame with each row corresponding to an input nuID
(when "returnAllInfo" is TRUE).

Author(s)

Warren Kibbe, Pan Du, Simon Lin

References

https://prod.bioinformatics.northwestern.edu/nuID/

See Also

See Also getNuIDMappingInfo

64

Examples

nuID2targetID

## load example data
data(example.lumi)
if (require(lumiHumanIDMapping)) {
nuIDs <- featureNames(example.lumi)
mappingInfo <- nuID2RefSeqID(nuIDs, lib.mapping='lumiHumanIDMapping')
head(mappingInfo)
}

nuID2targetID

Mapping nuID into Illumina TargetID

Description

Mapping nuID into Illumina TargetID or GeneID.

Usage

nuID2targetID(nuID, lib.mapping = "lumiHumanIDMapping", ...)

Arguments

nuID

a vector of nuID

lib.mapping

...

an Illumina ID mapping library
other parameters of nuID2IlluminaID

Details

The function will call nuID2IlluminaID when ID mapping library were provided.

Value

see function nuID2IlluminaID

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

targetID2nuID, nuID2IlluminaID

Examples

if (require(lumiHumanIDMapping)) {

nuID2targetID("B2J6WGhV.RevOJYff4", lib.mapping = "lumiHumanIDMapping")

}

pairs-methods

65

pairs-methods

Pair plot of an ExpressionSet object

Description

Creating pairs plot of sample intensities in an ExpressionSet object

Usage

## S4 method for signature 'ExpressionSet'
pairs(x, ..., smoothScatter = FALSE, logMode = TRUE, subset = 5000, fold=2, dotColor=1,

highlight = NULL, highlightColor = 2, main = NULL, checkTransform = TRUE)

Arguments

x

a ExpressionSet object
optional arguments to pairs.

...
smoothScatter whether use smoothScatter function to plot points
logMode
whether plot the data in log2 scale

subset

fold

subset of rows used to plot. It can be an index vector, or the length of a random
subset

The fold-change threshold used to estimate the number of probes having high
fold-changes

dotColor

color of points in the scatter plot

the subset dots need to be highlighted

highlight
highlightColor the color for those highlighted dots
main
title of the plot
checkTransform whether to check the data is log2-transformed or not

Details

To increase the plot efficiency, by default, we only plot RANDOMLY selected subset of points
(based on parameter "subset").
If users want to plot all the points, they can set the parameter
"subset = NULL". When smoothScatter is set as TRUE, the subsetting will be suppressed because
smoothScatter function has good plot efficiency for large number of points.

See Also

LumiBatch-class, pairs

Examples

## load example data
data(example.lumi)

pairs(example.lumi)

pairs(example.lumi, smoothScatter=TRUE)

66

plot-methods

plot-methods

Plot of a ExpressionSet object

Description

Creating quality control plots of a ExpressionSet object

Usage

## S4 method for signature 'ExpressionSet,missing'
plot(x, what = c("density", "boxplot", "pair", "MAplot", "sampleRelation", "outlier", "cv"), main, ...)

Arguments

x

what

main

...

Details

a ExpressionSet object returned by lumiQ
one of the six kinds of QC plots

the title of the QC plot

additional parameters for the corresponding QC plots

The parameter "what" of plot function controls the type of QC plots, which includes:

• density: the density plot of the chips, see hist-methods
• boxplot: box plot of the chip intensities, see boxplot-methods
• pair: the correlation among chips, plot as a hierarchical tree, see pairs-methods
• MAplot: the MAplot between chips, see MAplot-methods
• sampleRelation: plot the sample relations. See plotSampleRelation
• outlier: detect the outliers based on the sample distance to the center. See detectOutlier
• cv: the density plot of the coefficients of variance of the chips. See estimateLumiCV

See Also

LumiBatch-class, hist-methods, boxplot-methods, MAplot-methods, pairs-methods, plotSampleRelation,
estimateLumiCV, detectOutlier

Examples

## load example data
data(example.lumi)

## Quality control estimation
lumi.Q <- lumiQ(example.lumi)

## summary
summary(lumi.Q)

## plot the density
plot(lumi.Q, what='density')

plotCDF

67

## plot the pairwise sample correlation
plot(lumi.Q, what='pair')

## plot the pairwise MAplot
plot(lumi.Q, what='MAplot')

## sample relations
plot(lumi.Q, what='sampleRelation', method='mds', color=c('100US', '95US:5P', '100US', '95US:5P'))

## detect outlier based on the distance to the mean profile
plot(lumi.Q, what='outlier')

## Density plot of coefficient of variance
plot(lumi.Q, what='cv')

plotCDF

plot the cumulative distribution function of a ExpressionSet object

Description

plot the cumulative distribution function of a ExpressionSet object from high to low value or in
reverse

Usage

plotCDF(x, reverse=TRUE, logMode=TRUE, xlab = NULL, ylab = "Cumulative density",
col=1:dim(x)[2], lwd=1, xlim = NULL, index.highlight = NULL, color.highlight = 2,
addLegend = TRUE, main="", ...)

Arguments

x

reverse

logMode

xlab

ylab

col

lwd

xlim
index.highlight

color.highlight

a numeric or ExpressionSet object

determine whether plot the CDF from high to low value or not

determine whether the CDF plot is based on a log2 scale

xlab of the plotCDF plot

ylab of the plotCDF plot

line colors of the plotCDF plot

line width of plot function

parameter of the plot function

the column index of the highlighted plotCDF curve

color of highlighted plotCDF curve

addLegend

whether add legend to the plot or not

main

...

title for the plot
additional parameters for plot.ecdf function

plotColorBias1D

68

See Also

LumiBatch-class, ecdf

Examples

## load example data
data(example.lumi)

plotCDF(example.lumi)

plotColorBias1D

Plot the color bias density plot of Illumina Infinium Methylation data

Description

Plot the color bias density plot of Illumina Infinium Methylation data in one dimension (comparing
with 2D scatter plot)

Usage

plotColorBias1D(methyLumiM, channel = c("both", "unmethy", "methy", "sum"), colorMode=TRUE, removeGenderProbes = FALSE, logMode = TRUE, subset = NULL, ...)

Arguments

methyLumiM

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

channel

estimate the intensity in different methods

colorMode
removeGenderProbes

whether separate two color channels or not

determine whether exclude probes on X and Y chromosomes if the chromosome
information is provided in the methyLumiM object.

Whether plot the intensities in log-scale

plot subset of randomly selected rows. All data will be plotted if it is NULL.
other parameters used by density and plot

logMode

subset

...

Details

Plot the color bias density plot of Illumina Infinium Methylation data. There are four options using
"channel" parameter to plot the density plot. "both": estimate the density by pooling together
methylated and unmethylated probe intensities. "unmethy" and "methy": plot either unmethylated
or methylated probe density. "sum" plot the density of the sum of methylatled and unmethylated
probe intensitys.

Value

Invisibly return TRUE if plot successfully.

Author(s)

Pan DU

plotColorBias2D

See Also

See Also as plotColorBias2D and boxplotColorBias

Examples

data(example.lumiMethy)
# before adjustment
plotColorBias1D(example.lumiMethy)

69

plotColorBias2D

Plot the color bias of Illumina Infinium Methylation data in two di-
mensions

Description

Plot the color bias (red and green channel) of Illumina Infinium Methylation data of one selected
sample in two dimensions (methylated and unmethylated probe intensities)

Usage

plotColorBias2D(methyLumiM, selSample = 1, combineMode = F, layoutRatioWidth = c(0.75, 0.25), layoutRatioHeight = c(0.25, 0.75), margins = c(5, 5, 2, 2), cex = 1.25, logMode = TRUE, subset = NULL, ...)

Arguments

methyLumiM

MethyLumiM-class object or eSet-class object, which include methylated and
unmethylated probe intensities

selSample

The index of sample name of the selected sample to plot color bias

combineMode
layoutRatioWidth

Whether combine two color channels together and plot as one color

layoutRatioHeight

the plot figure ratio between scatter plot and density plot

the plot figure ratio between scatter plot and density plot

margin of the plot

A numerical value giving the amount by which plotting text and symbols should
be magnified relative to the default. See par

Whether plot the intensities in log-scale

plot subset of randomly selected rows. All data will be plotted if it is NULL.
other parameters used by plot

margins

cex

logMode

subset

...

Details

The function basically plots the probe intensities in 2-dimension (methylated vs unmethylated), and
colors the dots in Red and Green based on their color channel information. The related density plot
will also be plotted at the right and top of the scatter plot.

Value

Invisibly return TRUE if plot successfully.

plotControlData

70

Author(s)

Pan DU

See Also

See Also as plotColorBias1D

Examples

data(example.lumiMethy)
# plot in 2D plot of one selected sample
plotColorBias2D(example.lumiMethy, selSample = 1)

plotControlData

Plot the mean expression (with standard deviation bar) of different
type of control probes

Description

Plot the mean intensity (with standard deviation bar) of different type of control probes. Multiple
control types can be plotted in a single plot. The available control types can be get by running
getControlType(controlData).

Usage

plotControlData(controlData, type = NULL, slideIndex = NULL, logMode = FALSE, new = TRUE, ...)

Arguments

controlData

type

slideIndex

logMode

new

...

Details

a LumiBatch object including control data, a control data data.frame, a Methy-
LumiQC object or a MethyLumiM object including MethyLumiQC control data

the control probe type (case insensitive), which can be get by running getCon-
trolType(controlData)

the slide index or ID corresponding to each sample

whether show the data in log2 scale

whether refresh the new plot or add it on the old one

other parameters used by default plot function

When multiple control types are selected, they will be plotted in a two-column plot. For methylation
data, the red and green channels will be plotted respectively in red and green colors.

Value

plot the picture and invisibly return TRUE if everything is OK

Author(s)

Pan Du

plotDensity

See Also

71

addControlData2lumi and addControlData2methyLumiM

Examples

controlFile <- system.file('doc', 'Control_Probe_Profile.txt', package='lumi')
if (file.exists(controlFile)) {

controlData <- getControlData(controlFile)
getControlType(controlData)
plotControlData(controlData, type='NEGATIVE')

}

plotDensity

plot the density distribution

Description

plot the density distribution of a dataMatrix or ExpressionSet object

Usage

plotDensity(dataMatrix, logMode=TRUE, addLegend=TRUE, legendPos="topright", subset = NULL, ...)

Arguments

dataMatrix

a data matrix or ExpressionSet object

logMode

addLegend

legendPos

subset

...

determine whether the CDF plot is based on a log2 scale

whether add legend to the plot or not

the position of the legend.
location of legend.

If its length is two, then it specifies the x and y

plot subset of randomly selected rows. All data will be plotted if it is NULL.
additional parameters for matplot function

See Also

LumiBatch-class, density

Examples

## load example data
data(example.lumi)

plotDensity(example.lumi)

72

plotGammaFit

plotGammaFit

plot the fitting results of gammaFitEM

Description

plot the fitting results of gammaFitEM. It basically plot the histogram of M-values plus the estimated
gamma density plots and their mixture.

Usage

plotGammaFit(x, gammaFit = NULL, k = NULL, theta = NULL, shift = NULL, proportion = NULL, plotType = c("histogram", "density"), ...)

Arguments

x

gammaFit

k

theta

shift

proportion

plotType

...

Details

a vector of M-values covering the whole genome
a "gammaFit" class object returned by gammaFitEM

parameter k of gamma distribution

parameter theta of gamma distribution

parameter shift of gamma distribution

the proportion of two components (gamma distributions)

determine the way to show the distribution of the input data, either histogram or
density plot
Other parameters used by hist or plot (for "density" plotType) function.

This function is to visualize the fitting results, which helps us understand how well the fitting is.

Value

Invisibly return TRUE if the plot is successful.

Author(s)

Pan DU

See Also

gammaFitEM

Examples

data(example.lumiMethy)
M <- exprs(example.lumiMethy)
fittedGamma <- gammaFitEM(M[,1], initialFit=NULL, maxIteration=50, tol=0.0001, plotMode=FALSE, verbose=FALSE)
plotGammaFit(M[,1], gammaFit=fittedGamma)

plotHousekeepingGene

73

plotHousekeepingGene

Plot the housekeeping gene expression profile

Description

Plot the housekeeping gene expression profile

Usage

plotHousekeepingGene(controlData, lib = NULL, slideIndex = NULL, addLegend = TRUE, logMode = TRUE, ...)

Arguments

controlData

lib

slideIndex

addLegend

logMode

...

Value

a LumiBatch object including control data or a control data data.frame

the annotation library (for retrieving the gene name)

the slide index or ID corresponding to each sample

whether add legend or not

whether show the data in log2 scale

other parameters used by default matplot function

plot the picture and return TRUE if everything is OK

Author(s)

Pan Du

See Also

addControlData2lumi, plotControlData

Examples

controlFile <- system.file('doc', 'Control_Probe_Profile.txt', package='lumi')
if (file.exists(controlFile)) {

controlData <- getControlData(controlFile)
plotHousekeepingGene(controlData)

}

74

plotSampleRelation

plotSampleRelation

visualize the sample relations

Description

plot the sample relations based on MDS or hierarchical clustering

Usage

plotSampleRelation(x, subset = NULL, cv.Th = 0.1, standardize = TRUE, method = c("cluster", "mds"), dimension = c(1, 2), color = NULL, main = NULL, pch=NULL, addLegend=TRUE, ...)

Arguments

x

subset

cv.Th

standardize

method

dimension

color

main

pch

addLegend

...

Details

a LumiBatch object, ExpressionSet object or a matrix with each column corre-
sponding to a sample

the subset probes used to determine the sample relations. If it is one number,
then randomly selected "number" of probes will be used. If not provide, all the
probes will be used.

the threshold of the coefficient of variance of probes used to select probes to
estimate sample relations

standardize the expression profiles or not

"MDS" or "hierarchical clustering"

the principle components to visualize the MDS plot

the color for each sample during plot. Only support the "mds" method

the title of the plot

use symbols instead of text to label the samples

Whether to add legend to MDS (two-dimensional PCA) plot

Other parameters used by plot function.

Estimate the sample relations based on selected probes (based on large coefficient of variance (mean
/ standard variance)). Two methods can be used: MDS (Multi-Dimensional Scaling) or hierarchical
clustering methods.

Value

Invisibly return the hierarchical clustering results (if ’cluster’ method used) or coordinates of the
mds plot (if ’mds’ method used) .

Author(s)

Pan Du

See Also

lumiQ, LumiBatch, , plot,ExpressionSet-method

plotStringencyGene

Examples

## load example data
data(example.lumi)

75

## plot the sample relations with MDS
## the color of sample is automatically set based on the sample type
plotSampleRelation(example.lumi, col=c('100US', '95US:5P', '100US', '95US:5P'))

## plot the sample relations with hierarchical clustering
plotSampleRelation(example.lumi, method='cluster')

plotStringencyGene

plot the Stringency related control probe profiles

Description

Plot the Stringency related control probe (Low-Stringency, Medium-Stringency and High-Stringency)
profiles. Using getControlType function to view available stringency types.

Usage

plotStringencyGene(controlData, lib = NULL, slideIndex = NULL, addLegend = TRUE, logMode = TRUE, ...)

Arguments

controlData
lib
slideIndex
addLegend
logMode
...

Value

a LumiBatch object including control data or a control data data.frame
the annotation library (for retrieving the gene name)
the slide index or ID corresponding to each sample
whether add legend or not
whether show the data in log2 scale
other parameters used by default matplot function

plot the picture and return TRUE if everything is OK

Author(s)

Pan Du

See Also

addControlData2lumi, plotControlData

Examples

controlFile <- system.file('doc', 'Control_Probe_Profile.txt', package='lumi')
if (file.exists(controlFile)) {

controlData <- getControlData(controlFile)
plotStringencyGene(controlData)

}

76

plotVST

plotVST

plot the VST (Variance Stabilizing Transform) function

Description

plot the VST (Variance Stabilizing Transform) function of VST transformed LumiBatch object or
parameters of VST function.

Usage

plotVST(x, transFun = NULL, plotRange = NULL, addLegend = TRUE, ...)

Arguments

x

transFun

plotRange

addLegend

...

Value

a LumiBatch object after lumiT transform, or a matrix or data.frame with VST
parameter

a character vector of transformation function (asinh or log2)

the plot range of untransformed data

add legend or not
other parameter used by plot function

invisibly return the untransformed and transformed values.

Author(s)

Pan Du

See Also

vst

Examples

## load example data
data(example.lumi)

## Do default VST variance stabilizing transform
lumi.T <- lumiT(example.lumi, ifPlot=TRUE)

## plot the transform function
plotVST(lumi.T)

probeID2nuID

77

probeID2nuID

Mapping Illumina ProbeID as nuID

Description

Mapping Illumina ProbeID as nuID.

Usage

probeID2nuID(probeID, lib.mapping = "lumiHumanIDMapping", ...)

Arguments

probeID

lib.mapping

...

a vector of Illumina ProbeID

an Illumina ID mapping library
other parameters of IlluminaID2nuID

Details

The function will call IlluminaID2nuID when ID mapping library were provided.

Value

see function IlluminaID2nuID

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

nuID2probeID, IlluminaID2nuID

Examples

if (require(lumiHumanIDMapping)) {

probeID2nuID('0001240020', lib='lumiHumanIDMapping')

}

78

produceGEOPlatformFile

produceGEOPlatformFile

Produce GEO Platform Submission File in SOFT format

Description

Produce GEO Sample Submission File in SOFT format based on the provided LumiBatch object
and Illumina ID Mapping library

Usage

produceGEOPlatformFile(x.lumi, lib.mapping = NULL, nuIDMode = TRUE, includeAllChipProbe=FALSE, fileName = "GEOPlatformFile.txt")

Arguments

x.lumi

The LumiBatch object keeping all probes

lib.mapping

The Illumina ID Mapping library, e.g., "lumiHumanIDMapping"

nuIDMode
includeAllChipProbe

Determine whether producing the platform indexed by nuID

Determine whether including all probes in the Manifest file or just the probes
used in the x.lumi object

fileName

Filename of the GEO Platform File name

Details

The function produces the GEO platform submission file based on the chip information kept in the
Illumina ID Mapping library (specified by lib.mapping parameter). The determination of chip type
will be automatically done by selecting the best matching of the probe IDs with individual chips.

Value

Save the result as a text file in SOFT platform submission format.

Author(s)

Pan Du

References

http://www.ncbi.nlm.nih.gov/projects/geo/info/soft2.html

See Also

produceGEOSubmissionFile

Examples

# data(example.lumi)
# produceGEOPlatformFile(example.lumi, lib.mapping='lumiHumanIDMapping')

produceGEOSampleInfoTemplate

79

produceGEOSampleInfoTemplate

Produce the template of GEO sample information

Description

Produce the template of GEO sample information, which is used for function produceGEOSubmissionFile.

Usage

produceGEOSampleInfoTemplate(lumiNormalized, lib.mapping = NULL, fileName = "GEOsampleInfo.txt")

Arguments

lumiNormalized The normalized data (LumiBatch object)

lib.mapping

fileName

The Illumina ID Mapping library, e.g., "lumiHumanIDMapping"

The file name of Tab separated sample information file

Details

This function just produces a template of sample information with some default fillings. Users need
to fill in the detailed sample descriptions, especially the Sample\_title, Sample\_description and
some protocols. No blank fields are allowed. Function produceGEOSubmissionFile will produce
the file GEO submission file based on this sample information. The users should not use "\#" in the
description as it is a reserved character.

Value

Save the result as a Tab separated text file or return a data.frame if the fileName is NULL.

Author(s)

Pan Du

References

http://www.ncbi.nlm.nih.gov/projects/geo/info/soft2.html

See Also

produceGEOSubmissionFile

80

produceGEOSubmissionFile

produceGEOSubmissionFile

Produce GEO Sample Submission File in SOFT format

Description

Produce GEO Sample Submission File in the SOFT format based on the provided LumiBatch object
and sample information

Usage

produceGEOSubmissionFile(lumiNormalized, lumiRaw, lib.mapping = NULL, idType = 'Probe', sampleInfo = NULL, fileName = "GEOSubmissionFile.txt", supplementaryRdata = TRUE, ...)

Arguments

lumiNormalized The normalized data (LumiBatch object)
lumiRaw

lib.mapping

idType

sampleInfo

fileName
supplementaryRdata

The raw data (LumiBatch object), e.g., returned by lumiR
The Illumina ID Mapping library, e.g., "lumiHumanIDMapping"
the idType parameter of function nuID2IlluminaID
The sample information filename or data.frame, which is returned by produceGEOSampleInfoTemplate
The file name of GEO Submission file

determine whether produce the Rdata supplement data, which include both lu-
miNormalized and lumiRaw R objects.
other parameters used by function nuID2IlluminaID

...

Details

The function produces the GEO sample submission file including both normalized and raw data
information in the SOFT format. The sample information should be provided by the user as a
data.frame or Tab separated text file following the format of the template, which can be produced by
function produceGEOSampleInfoTemplate. Users need to fill in the detailed sample descriptions
in the template, especially the Sample\_title, Sample\_description and some protocols. Users are
also required to fill in the "Sample\_platform\_id" by checking information of the GEO Illumina
platform.

When the parameter "supplementaryRdata" is TRUE, the R objects, lumiNormalized, lumiRaw and
sampleInfo, will be saved in a file named ’supplementaryData.Rdata’.

Value

Save the result as a text file in SOFT sample submission format. The supplementary Rdata will be
saved in a file ’supplementaryData.Rdata’.

Author(s)

Pan Du

References

http://www.ncbi.nlm.nih.gov/projects/geo/info/soft2.html

produceMethylationGEOSubmissionFile

81

See Also

produceGEOSampleInfoTemplate, produceGEOPlatformFile

Examples

## Not run
## Produce the sample information template
# produceGEOSampleInfoTemplate(lumiNormalized, lib.mapping = NULL, fileName = "GEOsampleInfo.txt")
## After editing the 'GEOsampleInfo.txt' by filling in sample information
# produceGEOSubmissionFile(lumiNormalized, lumiRaw, lib='lumiHumanIDMapping', sampleInfo='GEOsampleInfo.txt')

produceMethylationGEOSubmissionFile

Produce GEO Sample Submission File of Illumina methylation mi-
croarray data in SOFT format

Description

Produce GEO Sample Submission File in the SOFT format based on the provided MethyLumiM
object and sample information

Usage

produceMethylationGEOSubmissionFile(methyLumiM, methyLumiM.raw = NULL, lib.mapping = NULL, idType = "Probe", sampleInfo = NULL, fileName = "GEOSubmissionFile.txt", supplementaryRdata = FALSE, ...)

Arguments

The normalized data in MethyLumiM class

methyLumiM
methyLumiM.raw The raw data in MethyLumiM class
lib.mapping

Currently not used for Illumina methylation data

idType

sampleInfo

fileName
supplementaryRdata

Currently no other options for Illumina methylation data
The sample information filename or data.frame, which is returned by produceGEOSampleInfoTemplate
The file name of GEO Submission file

determine whether produce the Rdata supplement data, which include both methy-
LumiM and methyLumiM.raw R objects.
other parameters used by function nuID2IlluminaID, but not implemented for
methylation data

...

Details

The function produces the GEO sample submission file including both normalized and raw data
information in the SOFT format. The sample information should be provided by the user as a
data.frame or Tab separated text file following the format of the template, which can be produced by
function produceGEOSampleInfoTemplate. Users need to fill in the detailed sample descriptions
in the template, especially the Sample\_title, Sample\_description and some protocols. Users are
also required to fill in the "Sample\_platform\_id" by checking information of the GEO Illumina
platform.

When the parameter "supplementaryRdata" is TRUE, the R objects, methyLumiM, methyLumiM.raw
and sampleInfo, will be saved in a file named ’supplementaryData.Rdata’.

82

Value

rankinvariant

Save the result as a text file in SOFT sample submission format. The supplementary Rdata will be
saved in a file ’supplementaryData.Rdata’.

Author(s)

Pan Du

References

http://www.ncbi.nlm.nih.gov/projects/geo/info/soft2.html

See Also

produceGEOSampleInfoTemplate, produceGEOPlatformFile

Examples

## Not run
## Produce the sample information template
# produceGEOSampleInfoTemplate(methyLumiM, fileName = "GEOsampleInfo.txt")
## After editing the 'GEOsampleInfo.txt' by filling in sample information
# produceMethylationGEOSubmissionFile(methyLumiM, methyLumiM.raw, sampleInfo='GEOsampleInfo.txt')

rankinvariant

Rank Invariant Normalization

Description

This function basically adjusts the samples to the same background level and then optionally scales
to the same foreground level.

Usage

rankinvariant(x.lumi, targetArray = NULL, rrc = .05, lowRank = seq(.5, .25, -.05), highRank = .9, minSize = .02, maxit=200)

Arguments

x.lumi

an ExpressionSet inherited object or a data matrix with columns as samples and
rows as genes

targetArray

A target chip is the model for other chips to normalize. It can be a column index,
a vector or a LumiBatch object with one sample.

rrc

lowRank

highRank

minSize

maxit

The relative rank change allowed for a gene to be selected as rank invariant

A vector with, in decreasing order, the minimum ranks where candidate genes
can be selected as rank invariant

The maximum rank where candidate genes can be selected as rank invariant

Fraction of genes required to be selected as rank invariant
Maximum number of iterations for rlm to reach convergence

rsn

Details

83

Rank invariant normalization uses a set of genes that are rank invariant between a given sample
and a target sample. The target sample can be predefined by setting the targetArray argument.
If targetArray is NULL the average expression of all samples will be the target. Rank invariant
genes are found for each sample seperately by calculation the relative rank change for each gene.
Furthermore, only genes with ranks between the lowRank and highRank are considered. If the
number of probes is less than minSize multiplies by the number of genes the next lowRank value
tried. If no rank invariant set can be found an error is thrown.

The default settings of this function are the same as used Genomstudio (Illumina). The results
produced by this method are similar, but not identical to Genomestudio.

Value

Return an object with expression values normalized. The class of the return object is the same as
the input object x.lumi.

Author(s)

Arno Velds (contact: a.velds (at) nki.nl)

See Also

lumiN

rsn

Robust Spline Normalization between chips

Description

Robust spline normalization (monotonic curves) between chips

Usage

rsn(x.lumi, targetArray = NULL, excludeFold = 2, span = 0.03, ifPlot = FALSE, ...)

Arguments

x.lumi

targetArray

excludeFold

span

ifPlot

...

an ExpressionSet inherited object or a data matrix with columns as samples and
rows as genes

A target chip is the model for other chips to normalize. It can be a column index,
a vector or a LumiBatch object with one sample.

exclude the genes with fold change larger than "excludeFold" during fitting the
curve in normalization
the span parameter used by monoSmu

determine whether to plot intermediate results
other parameters used by monoSmu

84

Details

seq2id

The robust spline normalization (RSN) algorithm combines the features of quantile and loess nor-
malization. It is designed to normalize the variance-stabilized data. The function will check whether
the data is variance stabilized (vst or log2 transform), if not, it will automatically run lumiT before
run rsn. For details of the algorithm, please see the reference.

The targetArray can be a column index, a vector or a LumiBatch object with one sample, which
corresponds to an external sample to be normalized with. This is very useful for handling large data
set or normalizing the data set with a common reference (targetArray).

Value

Return an object with expression values normalized. The class of the return object is the same as
the input object x.lumi. If it is a LumiBatch object, it also includes the VST transform function and
its parameters as attributes: "transformFun", "parameter". See inverseVST for details.

Author(s)

Pan Du, Simon Lin

See Also

lumiN, monoSmu

seq2id

Transfer a nucleotide sequence as a nuID

Description

The nuID (nucleotide universal identifier) is uniquely corresponding to probe sequence. The nuID
is also self-identification and error checking

Usage

seq2id(seq)

Arguments

seq

Details

a nucleotide sequence composed of A, C, G, T (U).

The nuID is a exact mapping of nucleotide sequence based on Base64 encoding scheme. A character
set A-Z, a-z, 0-9, "\_" and "." is used to represent to the base-64 numbers of 0-63. The first character
of nuID is a checking code, which provide information of both the number of padded "A"s at the
nucleotide sequence and error checking. Please refer to reference for more details.

Value

A string represents nuID

smoothQuantileNormalization

85

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

id2seq

Examples

seq <- 'ACGTAAATTTCAGTTTAAAACCCCCCG'
id <- seq2id(seq)
id
id2seq(id)

smoothQuantileNormalization

Smooth quantile normalization

Description

Smooth quantile normalization with a reference sample

Usage

smoothQuantileNormalization(dataMatrix, ref = NULL, adjData=NULL, logMode = TRUE, bandwidth = NULL, degree = 1, verbose = FALSE, ...)

Arguments

dataMatrix

a matrix of microarray intensity data

ref

adjData

logMode

bandwidth

degree

verbose

...

a vector of reference sample intensity, which matches the dataMatrix

data to be adjusted based on the ref and dataMatrix distribution

whether perform the analysis in log2 scale
a parameter used by locpoly
a parameter used by locpoly

whether print the processing sample names
other parameters used by locpoly

Value

a data matrix with intensity normalized.

Author(s)

Pan DU

86

See Also

See Also adjColorBias.quantile

ssn

Simple Scaling Normalization

ssn

Description

This function basically adjusts the samples to the same background level and then optionally scales
to the same foreground level.

Usage

ssn(x.lumi, targetArray = NULL, scaling = TRUE, bgMethod=c('density', 'mean', 'median', 'none'), fgMethod=c('mean', 'density', 'median'), ...)

Arguments

x.lumi

targetArray

scaling

bgMethod

fgMethod

...

Details

an ExpressionSet inherited object or a data matrix with columns as samples and
rows as genes

A target chip is the model for other chips to normalize. It can be a column index,
a vector or a LumiBatch object with one sample.

determine whether do scaling or just background shift

optional methods of determining the background level

optional methods of determining the foreground level
other parameters used by density function

This function basically adjusts the samples to the same background level and then optionally scales
to the same foreground level. The adjustment is based on the raw scale data (For the transformed
data, it still estimates the parameters in the raw scale by inverse transformation.).

Comparing with other normalization methods, like quantile and curve-fitting methods, SSN is a
more conservative method. The only assumption is that each sample has the same background
levels and the same scale (if do scaling). There are three methods (’density’, ’mean’ and ’median’)
for background estimation. If bgMethod is ’none’, then the background level will be set as 0, i.e.,
no background adjustment. For the ’density’ bgMethod, it estimates the background based on the
mode of probe intensities based on the assumption that the background level intensity is the most
frequent value across all the probes in the chip. For the foreground level estimation, it also provides
three methods (’mean’, ’density’, ’median’). For the ’density’ fgMethod, it assumes the background
probe levels are symmetrically distributed. Then we estimate the foreground levels by taking the
intensity mean of all other probes except from the background probes. For the ’mean’ and ’median’
methods (for both bgMethod and fgMethod), it basically estimates the level based on the mean or
median of all probes of the sample. If the fgMethod is the same as bgMethod (except ’density’
method), no scaling will be performed.

Value

Return an object with expression values normalized. The class of the return object is the same as
the input object x.lumi.

targetID2nuID

Author(s)

Pan Du, Simon Lin

See Also

lumiN

87

targetID2nuID

Mapping Illumina TargetID (GeneID) into nuID

Description

Mapping Illumina TargetID (GeneID) into nuID.

Usage

targetID2nuID(targetID, lib.mapping = "lumiHumanIDMapping", ...)

Arguments

targetID

lib.mapping

...

a vector of Illumina TargetID (GeneID)

an Illumina ID mapping library
other parameters of IlluminaID2nuID

Details

The function will call IlluminaID2nuID when ID mapping library were provided.

Value

see function IlluminaID2nuID

Author(s)

Pan Du

References

Du, P., Kibbe, W.A. and Lin, S.M., "nuID: A universal naming schema of oligonucleotides for
Illumina, Affymetrix, and other microarrays", Biology Direct 2007, 2:16 (31May2007).

See Also

nuID2targetID, IlluminaID2nuID

Examples

if (require(lumiHumanIDMapping)) {

targetID2nuID('GI_21389350-S', lib='lumiHumanIDMapping')

}

vst

Variance Stabilizing Transformation

88

vst

Description

Stabilizing the expression variance based on the bead level expression variance and mean relations

Usage

vst(u, std, nSupport = min(length(u), 500), backgroundStd=NULL, fitMethod = c('linear', 'quadratic'), lowCutoff = 1/3, ifPlot = FALSE)

Arguments

u

std

nSupport

backgroundStd

fitMethod

lowCutoff

mean expression of the beads with same sequence

expression standard deviation of the beads with same sequence

the number of down-sampling to speed processing

pre-estimated background standard deviation level

methods of fitting the relations between expression variance and mean relations

cutoff ratio to determine the low expression range. Do not change this until you
now what you are doing.

ifPlot

plot intermediate results or not

Details

The variance-stabilizing transformation (VST) takes the advantage of larger number of technical
replicates available on the Illumina microarray. It models the mean-variance relationship of the
within-array technical replicates at the bead level of Illumina microarray. An arcsinh transform is
then applied to stabilize the variance. See reference for more details.

For the methods of fitting the relations between expression variance and mean relations, the ’linear’
method is more robust and provides detailed parameters for inverseVST.

Value

Return the transformed (variance stabilized) expression values.

Author(s)

Pan Du, Simon Lin

References

Lin, S.M., Du, P., Kibbe, W.A., "Model-based Variance-stabilizing Transformation for Illumina
Mi-croarray Data", submitted

See Also

lumiT, inverseVST

vst

Examples

## load example data
data(example.lumi)

89

## get the gene expression mean for one chip
u <- exprs(example.lumi)[,1]
## get the gene standard deviation for one chip
std <- se.exprs(example.lumi)[,1]

## do variance stabilizing transform
transformedU <- vst(u, std)

## do variance stabilizing transform with plotting intermediate result
transformedU <- vst(u, std, ifPlot=TRUE)

Index

∗ IO

lumiR, 49

∗ classes

LumiBatch-class, 39

∗ datasets

example.lumi, 24
example.lumiMethy, 25
example.methyTitration, 25

∗ hplot

boxplot,MethyLumiM-method, 13
boxplot-methods, 14
boxplotColorBias, 15
density-methods, 16
hist-methods, 32
MAplot-methods, 54
pairs-methods, 65
plot-methods, 66
plotCDF, 67
plotColorBias1D, 68
plotColorBias2D, 69
plotControlData, 70
plotDensity, 71
plotHousekeepingGene, 73
plotSampleRelation, 74
plotStringencyGene, 75
plotVST, 76

∗ methods

addAnnotationInfo, 4
addControlData2lumi, 5
addControlData2methyLumiM, 6
addNuID2lumi, 7
adjColorBias.quantile, 8
asBigMatrix-methods, 10
beta2m, 11
bgAdjust, 11
bgAdjustMethylation, 12
boxplot,MethyLumiM-method, 13
boxplot-methods, 14
boxplotColorBias, 15
colorBiasSummary, 16
density-methods, 16
detectionCall, 17
detectOutlier, 18

estimateBeta, 19
estimateIntensity, 20
estimateLumiCV, 21
estimateM, 22
estimateMethylationBG, 23
gammaFitEM, 26
getChipInfo, 27
getChrInfo, 28
getControlData, 29
getControlProbe, 30
getControlType, 31
getNuIDMappingInfo, 31
hist-methods, 32
id2seq, 33
IlluminaID2nuID, 34
importMethyIDAT, 35
inverseVST, 36
is.nuID, 37
lumiB, 38
lumiExpresso, 41
lumiMethyB, 42
lumiMethyC, 43
lumiMethyN, 44
lumiMethyR, 45
lumiMethyStatus, 46
lumiN, 47
lumiQ, 48
lumiR.batch, 51
lumiT, 52
m2beta, 53
MAplot-methods, 54
methylationCall, 55
monoSmu, 56
monoSpline, 57
normalizeMethylation.quantile, 58
normalizeMethylation.ssn, 59
nuID2EntrezID, 59
nuID2IlluminaID, 61
nuID2probeID, 62
nuID2RefSeqID, 63
nuID2targetID, 64
pairs-methods, 65
plot-methods, 66

90

INDEX

91

plotCDF, 67
plotColorBias1D, 68
plotColorBias2D, 69
plotControlData, 70
plotDensity, 71
plotGammaFit, 72
plotHousekeepingGene, 73
plotStringencyGene, 75
probeID2nuID, 77
rankinvariant, 82
rsn, 83
seq2id, 84
smoothQuantileNormalization, 85
ssn, 86
targetID2nuID, 87
vst, 88

∗ method

adjColorBias.ssn, 9

∗ package

lumi-package, 3

∗ utilities

getChipInfo, 27
getNuIDMappingInfo, 31
IlluminaID2nuID, 34
nuID2EntrezID, 59
nuID2IlluminaID, 61
nuID2RefSeqID, 63
produceGEOPlatformFile, 78
produceGEOSampleInfoTemplate, 79
produceGEOSubmissionFile, 80
produceMethylationGEOSubmissionFile,

81

[,LumiBatch,ANY,ANY,ANY-method

(LumiBatch-class), 39

[,LumiBatch-method (LumiBatch-class), 39

addAnnotationInfo, 4, 28, 35
addControlData2lumi, 5, 29–31, 71, 73, 75
addControlData2methyLumiM, 6, 45, 71
addNuID2lumi, 7, 49, 51
addNuId2lumi (addNuID2lumi), 7
adjColorBias.quantile, 8, 10, 44, 86
adjColorBias.ssn, 9, 9, 44
asBigMatrix (asBigMatrix-methods), 10
asBigMatrix,ExpressionSet-method
(asBigMatrix-methods), 10

asBigMatrix-methods, 10

beadNum (LumiBatch-class), 39
beadNum,ExpressionSet-method
(LumiBatch-class), 39

beadNum<- (LumiBatch-class), 39

beadNum<-,ExpressionSet,ANY-method
(LumiBatch-class), 39

beadNum<-,ExpressionSet-method

(LumiBatch-class), 39

beta2m, 11, 54
bg.adjust, 38
bgAdjust, 11, 39
bgAdjustMethylation, 12, 23, 43
BigMatrix, 10
boxplot, 14, 15
boxplot,ExpressionSet-method
(boxplot-methods), 14
boxplot,MethyLumiM-method, 13
boxplot-methods, 14
boxplot.ExpressionSet

(boxplot-methods), 14

boxplotColorBias, 15, 69
bwplot, 13

class:LumiBatch (LumiBatch-class), 39
colorBiasSummary, 16
combine,ExpressionSet,LumiBatch-method

(LumiBatch-class), 39

combine,LumiBatch,ExpressionSet-method

(LumiBatch-class), 39
combine,LumiBatch,LumiBatch-method
(LumiBatch-class), 39

controlData (LumiBatch-class), 39
controlData,LumiBatch-method
(LumiBatch-class), 39

controlData<- (LumiBatch-class), 39
controlData<-,LumiBatch,ANY-method
(LumiBatch-class), 39

controlData<-,LumiBatch-method

(LumiBatch-class), 39

controlTypes, 31

density, 17, 68, 71, 86
density,ExpressionSet-method
(density-methods), 16

density-methods, 16, 32
density.ExpressionSet

(density-methods), 16

detection (LumiBatch-class), 39
detection,ExpressionSet-method

(LumiBatch-class), 39

detection<- (LumiBatch-class), 39
detection<-,ExpressionSet,ANY-method
(LumiBatch-class), 39

detection<-,ExpressionSet-method

(LumiBatch-class), 39

detectionCall, 17, 48
detectOutlier, 18, 66

92

INDEX

ecdf, 68
eSet, 40
estimateBeta, 19, 21, 23
estimateIntensity, 20, 20, 23
estimateLumiCV, 21, 66
estimateM, 20, 21, 22
estimateMethylationBG, 9, 10, 13, 23, 43
example.lumi, 24
example.lumiMethy, 25
example.methyTitration, 25
ExpressionSet, 10, 14, 17, 32, 39, 40, 54, 65,

67, 71

expresso, 41

gammaFitEM, 26, 46, 55, 72
getChipInfo, 27, 27, 34, 61
getChrInfo, 28
getControlData, 6, 29
getControlProbe, 30
getControlType, 30, 31
getHistory (LumiBatch-class), 39
getHistory,LumiBatch-method
(LumiBatch-class), 39
getNuIDMappingInfo, 31, 60, 63

hdr.boxplot, 13
hist, 32, 72
hist,ExpressionSet-method
(hist-methods), 32

hist-methods, 16, 17, 32
hist.ExpressionSet (hist-methods), 32

id2seq, 33, 37, 85
IlluminaID2nuID, 7, 28, 34, 61, 77, 87
importMethyIDAT, 35, 45
initialize,LumiBatch-method
(LumiBatch-class), 39

inverseVST, 36, 47, 53, 84, 88
is.nuID, 37

legend, 17
locpoly, 85
lumi (lumi-package), 3
lumi-package, 3
lumiB, 12, 38, 41, 42
LumiBatch, 48, 51, 74
LumiBatch (LumiBatch-class), 39
LumiBatch-class, 39
lumIDAT, 35
lumiExpresso, 39, 41
lumiMethyB, 13, 23, 42
lumiMethyC, 9, 10, 43
lumiMethyN, 44, 58, 59

lumiMethyR, 5, 6, 35, 45
lumiMethyStatus, 46
lumiN, 40–42, 47, 83, 84, 87
lumiQ, 18, 19, 22, 41, 48, 49, 51, 66, 74
lumiR, 7, 29, 39–41, 49, 51, 52, 80
lumiR.batch, 51
lumiT, 40–42, 52, 88

m2beta, 11, 53
MAplot, 54
MAplot (MAplot-methods), 54
MAplot,ExpressionSet-method
(MAplot-methods), 54

MAplot-methods, 54
MAplot.ExpressionSet (MAplot-methods),

54
matplot, 71
methylationCall, 27, 46, 55
methylumiR, 45
monoSmu, 56, 57, 83, 84
monoSpline, 56, 57, 57

normalize.loess, 47
normalize.quantiles, 47
normalizeMethylation.quantile, 45, 58,

59

normalizeMethylation.ssn, 45, 58, 59
nuID2EntrezID, 59
nuID2IlluminaID, 28, 34, 61, 62, 64, 80, 81
nuID2probeID, 62, 77
nuID2RefSeqID, 63
nuID2targetID, 64, 87

pairs, 65
pairs,ExpressionSet-method
(pairs-methods), 65

pairs-methods, 65
pairs.ExpressionSet (pairs-methods), 65
panel.violin, 14
par, 69
plot, 21, 56, 68, 69, 72, 76
plot,ExpressionSet,missing-method
(plot-methods), 66
plot,ExpressionSet-method
(plot-methods), 66

plot-methods, 66
plot.ecdf, 67
plot.ExpressionSet (plot-methods), 66
plotCDF, 67
plotCDF,ExpressionSet-method (plotCDF),

67

plotCDF.ExpressionSet (plotCDF), 67
plotColorBias1D, 15, 68, 70

INDEX

93

plotColorBias2D, 69, 69
plotControlData, 6, 70, 73, 75
plotDensity, 71
plotGammaFit, 27, 72
plotHousekeepingGene, 73
plotSampleRelation, 66, 74
plotStringencyGene, 75
plotVST, 76
probeID2nuID, 62, 77
produceGEOPlatformFile, 78, 81, 82
produceGEOSampleInfoTemplate, 79, 80–82
produceGEOSubmissionFile, 78, 79, 80
produceMethylationGEOSubmissionFile,

81

quantile, 12

rankinvariant, 47, 82
read.table, 49
rlm, 82
rsn, 47, 83

sampleNames<-,LumiBatch,ANY-method
(LumiBatch-class), 39
se.exprs (LumiBatch-class), 39
se.exprs,ExpressionSet-method

(LumiBatch-class), 39

se.exprs<- (LumiBatch-class), 39
se.exprs<-,ExpressionSet,ANY-method
(LumiBatch-class), 39

se.exprs<-,ExpressionSet-method

(LumiBatch-class), 39

seq2id, 33, 37, 84
show,LumiBatch-method

(LumiBatch-class), 39
smoothQuantileNormalization, 8, 9, 85
smoothScatter, 54, 65
ssn, 47, 86
summary,LumiBatch-method

(LumiBatch-class), 39

supsmu, 56

targetID2nuID, 64, 87

vsn, 47
vst, 36, 50, 52, 53, 76, 88

