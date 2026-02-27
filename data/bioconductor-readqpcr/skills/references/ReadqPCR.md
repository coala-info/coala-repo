ReadqPCR: Functions to load RT-qPCR data into R

James Perkins
University of Malaga

Matthias Kohl
Furtwangen University

October 30, 2025

Contents

1 Introduction

2 read.LC480

3 read.qPCR

4 read.taqman

5 qPCRBatch

1

Introduction

1

2

7

8

9

The package "ReadqPCR" contains different functions for reading qPCR data into R.

As well as the functions to read in the data, "ReadqPCR" contains the qPCRBatch and
CyclesSet class definition. The data output by these RT-qPCR systems is in the form
of fluorescence values or quantification cycle (Cq values), which represents the number of
cycles of amplification needed in order to detect the expression of a given gene from a
sample.

"ReadqPCR" is designed to be complementary to another R package, "NormqPCR", which
It must be installed before the other

is intended for the normalisation of qPCR data.
module.

We load the "ReadqPCR" package.

> library(ReadqPCR)

1

2

read.LC480

With function read.LC480 raw fluoresence data of Roche LightCycler 480 may be read in.
The result is saved in an object of class CyclesSet. At the moment the function works only
with the data exported to a txt-file, but we plan to add support also for the xml-export.

> path <- system.file("exData", package = "ReadqPCR")
> LC480.example <- file.path(path, "LC480_Example.txt")
> cycData <- read.LC480(file = LC480.example)
> ## Fluorescence data
> head(exprs(cycData))

A4

A1

A3

A2

A9

A8

A6

A5

A7

A11

A10

A12
1 15.58 16.93 27.32 16.60 16.88 27.93 15.37 17.27 27.26 15.91 41594.00 25.74
16.17 25.76
2 15.53 16.96 27.69 16.68 16.91 28.23 15.47 17.35 27.59 15.87
16.23 25.77
3 15.49 16.93 27.56 16.67 16.95 28.27 15.41 17.32 27.60 15.83
16.17 25.70
4 15.47 16.97 27.62 16.63 16.87 28.22 15.42 17.28 27.62 15.83
16.18 25.64
5 15.47 16.88 27.56 16.65 16.92 28.22 15.38 17.31 27.52 15.74
16.23 25.70
6 15.41 16.90 27.55 16.65 16.87 28.20 15.41 17.27 27.57 15.76
B5

B9
1 16.61 17.74 27.15 17.57 17.67 29.30 41322 41625.00 26.84
2 16.67 17.80 27.42 17.61 17.71 29.76 41322
3 16.57 17.78 27.47 17.64 17.73 29.74 41322
4 16.56 17.72 27.49 17.57 17.64 29.87 41442
5 16.52 17.68 27.44 17.59 17.62 29.78
6 16.59 17.69 27.50 17.54 17.62 29.90 41564

B11
16.93 16.64
17.19 27.58 41625.00 16.68
17.16 27.58 41350.00 16.64
17.14 16.57
17.22 27.61
17 41625.00 27.56 41472.00 16.57
17.14 16.56

17.22 27.61

B10

B7

B6

B3

B2

B1

B4

B8

C2

C1

C6

C4

C3

B12

C8
C7
26.88 17.43
16.96
27.19 17.50 41442.00
16.99

C5
1 41512.00 41322.00 16.60 27.13 41292.00 16.77
16.89 16.55 27.43
2
18.14 16.77
16.86 16.54 27.46 41473.00 16.81 41574.00 17.50
3
16.81 16.51 27.38 41504.00 16.83
4
16.79 16.43 27.48 41443.00 16.87
5
16.84 16.44 27.47 41626.00 16.86
6
D3

C9
27.86
28.19
28.22
27.17 17.43 41564.00 41606.00
28.15
27.16 17.47 41322.00
28.17
27.14 17.51 41291.00
D8
D7
D4
C12
17.22 16.80 27.25 17.66 17.18 27.41 17.42 17.22
25.92
26.22
17.28 16.76 27.62 17.69 17.26 27.59 17.49 17.14
26.30 41564.00 16.72 27.51 17.71 17.26 27.55 17.40 17.26
26.24 41595.00 16.76 27.61 17.62 17.30 27.72 17.50 17.27
18.00 16.54 41390.00 41534.00 16.72 27.45 17.73 17.27 27.66 17.49 17.27
17.98 16.49 41451.00 41291.00 16.71 27.47 17.64 17.29 27.69 17.45 17.20
D9

26.35
26.21
26.27
26.22
26.15
C11
C10
1 41443.00 16.49
2 41535.00 16.53
18.00 16.57
3
4 41443.00 16.55
5
6

E3
1 27.28 17.47 16.63 41332.00 27.52 17.80 26.51

E5
28.69 17.62

E6
27.48

E7
27.64

D10

D12

D11

E1

D5

D2

D1

D6

E2

E4

2

2 27.74 17.46 16.70
3 27.74 17.40 16.66
4 27.91 17.51 16.76
5 27.82 17.43 16.69
6 27.87 17.46 16.69
E9
E8

29.00 17.67
27.38 27.78 17.79 26.84
27.38 27.69 17.75 26.88
28.99 17.71
27.42 27.61 17.71 26.90 41423.00 17.72
27.33 27.63 17.79 26.82 41393.00 17.74
27.41 27.59 17.76 26.84 41362.00 17.77 41302.00

28.00
27.79
27.89
27.99
27.93 41361.00
27.95 41483.00
28.14
F5
16.97 41361.00 27.17 16.69 26.82 41605.00 41473.00 28.28 28.24 41442.00
27.25
18.15 28.65 28.65 41472.00
26.99 41535.00 28.61 28.64 41381.00
17.16
18.19 28.61 28.60
17.18
26.99 41412.00 28.53 28.61
17.18
27.00 41412.00 28.48 28.66

1
2 41442.00
3 41442.00
4 41534.00
5 41411.00
6 41350.00

E11

E10

E12

F3

F4

F2

F1

F7

F6

28.53 27.41 16.88 27.20
28.51 27.33 16.83 27.19
28.54 27.37 16.85 27.19 41544.00
28.52 27.33 16.81 27.19
28.58 27.41 16.80 27.18
F12
F10
F8
27.65 41422.00 16.68 26.61
1 27.99 27.50 16.67
27.95
2 28.29 27.79 16.74
3 28.25 27.84 16.74
27.98
4 28.30 27.88 16.84 41333.00
5 28.33 27.94 16.92 41392.00
6 28.28 27.95 16.82 41361.00
G8

F11

G11

G10

F9

G7

G2

G1

G3
27.91 44743 15189

G4
27.7
28.39 16.83 26.97 41453.00 45108 17380 41392.0
27.99 46204 16285
28.35 16.78 26.95
28.0
27.89 44743 15554 41453.0
28.38 16.82 26.99
27.84 44743 15554 41422.0
28.31 16.86 26.96
27.74 41456 12997 41514.0
28.39 16.86 26.97
H2
G9

G12

H3

G6
G5
1 31929 22433
2 33756 23894 41361.00 35582 31929 28.58 24685 35582 15.85
3 33025 22433 41422.00 34851 30834 28.46 23590 33756 15.76
4 32660 24259 41514.00 35217 31199 28.42 22859 34121 15.72
5 33025 21702 41392.00 33756 28642 28.38 20302 33025 15.75
27.97 32295 29738 28.41 21398 33756 15.75
6 32660 20972
H6

H4
27.79 34121 29738 28.32 20668 32295 15.97 41410.00 45108 15158
15.97 46204 17715
15.88 46569 16984
15.88 45474 15523
15.84 44378 16619
15.82 42552 13697

H1

H7

H5

H9

H10

H12
H8
26.70 41391.00 14427 21002 24624 24624 41371 17746
27.28 18810 24289 28277 26816 41554 21763
27.17 17349 22098 25720 24259 41312 19572
27.21 15158 21732 26816 25355 41432 19572
27.21 14427 21002 26451 23894 41312 17746
27.26 14793 22098 25720 23163 36312 15554

1
2 41391.00
26.90
3
26.85
4
26.82
5
26.80
6

H11

> ## Pheno data
> head(pData(cycData))

Sample position Sample name Program number Segment number
3
3
3

Sample_1
Sample_2
Sample_2

A1
A2
A3

2
2
2

A1
A2
A3

3

A4
A5
A6

A4
A5
A6

Sample_3
Sample_4
Sample_4

2
2
2

3
3
3

> ## Feature data
> head(fData(cycData))

Cycle number Acquisition time Acquisition temperature
71.79
691600
71.64
770133
71.64
848716
71.67
927233
71.67
1005816
71.67
1084316

1
2
3
4
5
6

1
2
3
4
5
6

The class CyclesSet is an extension of class eSet.

> cycData

CyclesSet (storageMode: lockedEnvironment)
assayData: 45 features, 96 samples

element names: exprs

protocolData: none
phenoData

sampleNames: A1 A2 ... H12 (96 total)
varLabels: Sample position Sample name Program number Segment number
varMetadata: labelDescription

featureData

featureNames: 1 2 ... 45 (45 total)
fvarLabels: Cycle number Acquisition time Acquisition temperature
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

> ## Information about class CyclesSet
> getClass("CyclesSet")

Class "CyclesSet" [package "ReadqPCR"]

Slots:

Name:

assayData

phenoData

featureData

4

Class:

Name:
Class:

AssayData AnnotatedDataFrame AnnotatedDataFrame

experimentData
MIAxE

annotation

protocolData
character AnnotatedDataFrame

Name:
Class:

.__classVersion__
Versions

Extends:
Class "eSet", directly
Class "VersionedBiobase", by class "eSet", distance 2
Class "Versioned", by class "eSet", distance 3

The additional sample information file can be read in with function read.LC480SampleInfo
and is saved in an object of class AnnotatedDataFrame.

> LC480.SamInfo <- file.path(path, "LC480_Example_SampleInfo.txt")
> samInfo <- read.LC480SampleInfo(file = LC480.SamInfo)
> ## Additional sample information
> head(pData(samInfo))

Sample position Sample name Replicate of Filter combination

A1
A2
A3
A4
A5
A6

Sample_1
Sample_2
Sample_2
Sample_3
Sample_4
Sample_4

Target name
465-510 negativ Kontrolle
goi
465-510
465-510
hk
465-510 negativ Kontrolle
goi
465-510
hk
465-510

Sample Pref color Efficiency Combined sample and target type
Target Negative
Target Unknown
Ref Unknown
Target Negative
Target Unknown
Ref Unknown

$00FF8000
clRed
$0030D700
clFuchsia
clGray
$0012D7FA

2
2
2
2
2
2

1
2
3
4
5
6

1
2
3
4
5
6

For adding this additional information to the CyclesSet we provide a method for function
merge.

> cycData1 <- merge(cycData, samInfo)
> ## Extended pheno data
> phenoData(cycData1)

5

An object of class 'AnnotatedDataFrame'
sampleNames: 1 2 ... 96 (96 total)
varLabels: Sample position Sample name ... Combined sample and target

type (10 total)

varMetadata: labelDescription

> head(pData(cycData1))

Sample position Sample name Program number Segment number Replicate of

1
2
3
4
5
6

1
2
3
4
5
6

1
2
3
4
5
6

A1
A2
A3
A4
A5
A6

Sample_1
Sample_2
Sample_2
Sample_3
Sample_4
Sample_4

2
2
2
2
2
2

3
3
3
3
3
3

Filter combination

465-510 negativ Kontrolle
465-510
goi
hk
465-510
465-510 negativ Kontrolle
goi
465-510
hk
465-510

Target name Sample Pref color Efficiency
2
2
2
2
2
2

$00FF8000
clRed
$0030D700
clFuchsia
clGray
$0012D7FA

Combined sample and target type
Target Negative
Target Unknown
Ref Unknown
Target Negative
Target Unknown
Ref Unknown

> varMetadata(phenoData(cycData1))

labelDescription
Sample position
Sample position
Sample name
Sample name
Program number
Program number
Segment number
Segment number
Replicate of
Replicate of
Filter combination
Filter combination
Target name
Target name
Sample Pref color
Sample Pref color
Efficiency
Efficiency
Combined sample and target type Combined sample and target type

6

3

read.qPCR

read.qPCR allows the user to read in qPCR data and populate a qPCRBatch R object (see
section qPCRBatch) using their own data matrix. The format of the data file should be
tab delimited and have the following columns, the first two of which are optional (although
they should either be provided together, or not at all):

Well Optional, this represents the position of the detector on a plate. This information,
if given, will be used to check the plates are of the same size and will also be used in
order to plot a representation of the card to look for spatial effects and other potential
problems. Both Well number and Plate ID must be present to enable a plate to be
plotted.

Plate Optional, this is an identifier for the plate on which an experiment was performed.
It is not possible to have duplicate plate IDs with the same Well number. Neither is
it possible to have Plate Ids without Well numbers. Both Well number and Plate ID
must be present to enable a plate to be plotted.

Sample The sample being analysed. Each sample must contain the same detectors in
order to combine and compare samples effectively and to form a valid expression set
matrix.

Detector This is the identifier for the gene being investigated. The Detectors must be

identical for each sample.

Cq This is the quantification cycle value for a given detector in the corresponding sample.

The generic function read.qPCR is called to read in the qPCR file. It is similar to the
read.affybatch function of the "affy" package, in that it reads a file and automatically
populates an R object, qPCRBatch described below. However it is different in that the file
is user formatted. In addition, unlike read.affybatch, and also unlike the read.taqman
function detailed below, only one file may be read in at a time.

If Well and Plate ID information are given, then these are used to populate the
exprs.well.order, a new assayData slot introduced in the qPCRBatch object, as detailed
below in section qPCRBatch.

So for the qPCR.example.txt file, in directory exData of this library, which contains
Well and Plate ID information, as well as the mandatory Sample, Detector and Cq infor-
mation, we can read in the data as follows.

> path <- system.file("exData", package = "ReadqPCR")
> qPCR.example <- file.path(path, "qPCR.example.txt")
> qPCRBatch.qPCR <- read.qPCR(qPCR.example)

7

qPCRBatch.qPCR will be a qPCRBatch object with an exprs and exprs.well.order, as well
as a phenoData slot which gets automatically populated in the same way as when using
read.affybatch. More detail is given in the qPCRBatch section below.

read.qPCR can deal with technical replicates. If the same detector and sample identifier
occurs more than once, the suffix _TechReps.n is concatenated to the detector name, where
n in {1, 2...N } is the number of the replication in the total number of replicates, N , based
on order of appearence in the qPCR data file. So for a qPCR file with 2 technical replicates
and 8 detectors per replicate, with one replicate per plate, the detector names would be
amended as follows:

> qPCR.example.techReps <- file.path(path, "qPCR.techReps.txt")
> qPCRBatch.qPCR.techReps <- read.qPCR(qPCR.example.techReps)
> rownames(exprs(qPCRBatch.qPCR.techReps))[1:8]

[1] "gene_aj_TechReps.1" "gene_aj_TechReps.2" "gene_al_TechReps.1"
[4] "gene_al_TechReps.2" "gene_ax_TechReps.1" "gene_ax_TechReps.2"
[7] "gene_bo_TechReps.1" "gene_bo_TechReps.2"

The reason for appending the suffix when technical replicates are encountered is in or-
der to populate the exprs and exprs.well.order slots correctly and keep them to the
assayData format. It also allows the decisions on how to deal with the analysis and com-
bination of technical replicates to be controlled by the user, either using the "NormqPCR"
package, or potentially some other function that takes assayData format R objects as input.

4

read.taqman

read.taqman allows the user to read in the data output by the Sequence Detection Systems
(SDS) software which is the software used to analyse the Taqman Low Density Arrays.
This data consists of the header section, which gives some general information about the
experiment, run date etc., followed by the raw Cq values detected by the software, followed
by summary data about the experiment. read.taqman is a generic function, and is called
in a way similar to the read.affybatch function of the "affy" package.

> taqman.example <- file.path(path, "example.txt")
> qPCRBatch.taq <- read.taqman(taqman.example)

Currently the SDS software only allows up to 10 plates to be output onto one file.
read.taqman allows any number of SDS output files to be combined to make a single
qPCRBatch, as long as they have matching detector identifiers.

> path <- system.file("exData", package = "ReadqPCR")
> taqman.example <- file.path(path, "example.txt")

8

> taqman.example.second.file <- file.path(path, "example2.txt")
> qPCRBatch.taq.two.files <- read.taqman(taqman.example,
+

taqman.example.second.file)

SDS output will not necessarily contain plate identifiers, in which case a numeric iden-
tifier will be generated, which will increment for each plate, depending on the order of the
plates within the SDS files. This is important for filling the exprs.well.order slot of the
qPCRBatch.

read.taqman can also deal with technical replicates. If the same detector and sample
identifier occurs more than once, the suffix _TechRep.n will be concatenated to the detector
name, where n in {1, 2...N } is the number of the replication in the total number of replicates
N , based on the order of occurence in the taqman data file. So for a taqman file with 4
technical replicates of 96 detectors per sample, with one sample per plate, the detector
names would be amended as follows:

> taqman.example.tech.reps <- file.path(path, "exampleTechReps.txt")
> qPCRBatch.taq.tech.reps <- read.taqman(taqman.example.tech.reps)
> rownames(exprs(qPCRBatch.taq.tech.reps))[1:8]

[1] "ACE.Hs00174179_m1_TechReps.1"
[2] "ACE.Hs00174179_m1_TechReps.2"
[3] "ACE.Hs00174179_m1_TechReps.3"
[4] "ACE.Hs00174179_m1_TechReps.4"
[5] "AT1R.AGTR1..Hs00241341_m1_TechReps.1"
[6] "AT1R.AGTR1..Hs00241341_m1_TechReps.2"
[7] "AT1R.AGTR1..Hs00241341_m1_TechReps.3"
[8] "AT1R.AGTR1..Hs00241341_m1_TechReps.4"

As with read.qPCR, the motivation for appending the suffix when technical replicates
are encountered is in order to populate the exprs and exprs.well.order slots correctly
and keep them to the assayData format. Again it allows the decisions on how to deal with
the analysis of technical replicates to be controlled by the user, either using the "NormqPCR"
package, or otherwise.

5 qPCRBatch

qPCRBatch is an S4 class, designed to store information on the raw Cq values which rep-
resents the relative gene expression for a given sample, phenotypic information on the
different samples which enable the user to compare expression accross different conditions
or cell lines, and information on the spatial location of the different detectors used to mea-
sure Cq. This is achieved by making qPCRBatch an an extension of eSet, which means we

9

can recycle slots such as exprs and pData, and by introducing a new assyData slot. Here
is an example of what a qPCRBatch looks like. note the similarity to eSet:

> qPCRBatch.taq

qPCRBatch (storageMode: lockedEnvironment)
assayData: 96 features, 8 samples

element names: exprs, exprs.well.order

protocolData: none
phenoData

sampleNames: fp1.day3.v fp2.day3.v ... fp.8.day.3.mia (8 total)
varLabels: sample
varMetadata: labelDescription

featureData: none
experimentData: use 'experimentData(object)'
Annotation:

pData will be filled automatically if no data is given, in a way analagous to read.affybatch:

> pData(qPCRBatch.taq)

fp1.day3.v
fp2.day3.v
fp5.day3.mia
fp6.day3.mia
fp.3.day.3.v
fp.4.day.3.v
fp.7.day.3.mia
fp.8.day.3.mia

sample
1
2
3
4
5
6
7
8

In addition there is a new slot, exprs.well.order which extends the assayData slot
used for exprs(). It has the same dimensions as exprs (as every instance of assayData
must). The cells contain further details on the position on the arrays where the different
meaurements were taken.

The data provided by this slot can be used in order to identify certain problems with
arrays, perhaps due to spatial effects and other problems with the microfluidics technology
that is used by many of these systems.

This is conceptually similar to the cdf file information being stored in the AffyBatch
class, which contains information on the spatial layout of features on an affy chip. However it
differs since it allows for different arrays within the same affyBatch object to have different

10

layouts to each other. This information can be viewed using the exprs.well.order()
function.

When using read.taqman, if the input file includes identifiers for the different arrays
in the experiment, the identifiers will be of the format <plate.id>-<plate.position>.
However if no names are given for the different plates, "ReadqPCR" will assign them a
numeric identifier, which increments depending on the order of plates in the original file.
When several input files are given, as in the case of SDS files, the order in which they are
supplied as arguments to the read.taqman function will be mirrored in the order of the
numeric identifiers for the different plates. However, to minimise confusion, we recommend
the useR giving the plates their own unique identifiers where possible.

Without plate names:

> head(exprs.well.order(qPCRBatch.taq))

"1-134"
"1-157"
"1-162"
"1-187"
"1-106"
"1-133"

"1-230"
"1-253"
"1-258"
"1-283"
"1-202"
"1-229"

fp1.day3.v fp2.day3.v fp5.day3.mia fp6.day3.mia
Actb.Rn00667869_m1
"1-38"
Adipoq.Rn00595250_m1 "1-61"
Adrbk1.Rn00562822_m1 "1-66"
Agtrl1.Rn00580252_s1 "1-91"
"1-10"
Alpl.Rn00564931_m1
"1-37"
B2m.Rn00560865_m1
fp.3.day.3.v fp.4.day.3.v fp.7.day.3.mia fp.8.day.3.mia
Actb.Rn00667869_m1
"2-38"
Adipoq.Rn00595250_m1 "2-61"
Adrbk1.Rn00562822_m1 "2-66"
Agtrl1.Rn00580252_s1 "2-91"
"2-10"
Alpl.Rn00564931_m1
"2-37"
B2m.Rn00560865_m1

"2-326"
"2-349"
"2-354"
"2-379"
"2-298"
"2-325"

"2-230"
"2-253"
"2-258"
"2-283"
"2-202"
"2-229"

"2-134"
"2-157"
"2-162"
"2-187"
"2-106"
"2-133"

"1-326"
"1-349"
"1-354"
"1-379"
"1-298"
"1-325"

With plate names:

> taqman.example.plateNames <- file.path(path, "exampleWithPlateNames.txt")
> qPCRBatch.taq.plateNames <- read.taqman(taqman.example.plateNames)
> head(exprs.well.order(qPCRBatch.taq.plateNames))

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1 "PlateA-61"
Adrbk1.Rn00562822_m1 "PlateA-66"
Agtrl1.Rn00580252_s1 "PlateA-91"
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

gp.1.day.3.v gp.2.day.3.v gp.5.day.3.mia gp.6.day.3.mia
"PlateA-38" "PlateA-134" "PlateA-230"
"PlateA-157" "PlateA-253"
"PlateA-162" "PlateA-258"
"PlateA-187" "PlateA-283"
"PlateA-10" "PlateA-106" "PlateA-202"
"PlateA-133" "PlateA-229"
"PlateA-37"

"PlateA-326"
"PlateA-349"
"PlateA-354"
"PlateA-379"
"PlateA-298"
"PlateA-325"

11

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1 "PlateB-61"
Adrbk1.Rn00562822_m1 "PlateB-66"
Agtrl1.Rn00580252_s1 "PlateB-91"
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

gp.3.day.3.v gp.4.day.3.v gp.7.day.3.mia gp.8.day.3.mia
"PlateB-38" "PlateB-134" "PlateB-230"
"PlateB-157" "PlateB-253"
"PlateB-162" "PlateB-258"
"PlateB-187" "PlateB-283"
"PlateB-10" "PlateB-106" "PlateB-202"
"PlateB-133" "PlateB-229"
"PlateB-37"

"PlateB-326"
"PlateB-349"
"PlateB-354"
"PlateB-379"
"PlateB-298"
"PlateB-325"

In addition, a mixture of files with and without plate identifiers is possible.

> taqman.example <- file.path(path, "example.txt")
> taqman.example.plateNames <- file.path(path, "exampleWithPlateNames.txt")
> qPCRBatch.taq.mixedPlateNames <- read.taqman(taqman.example,
+
> head(exprs.well.order(qPCRBatch.taq.mixedPlateNames))

taqman.example.plateNames)

"1-134"
"1-157"
"1-162"
"1-187"
"1-106"
"1-133"

"1-326"
"1-349"
"1-354"
"1-379"
"1-298"
"1-325"

"1-230"
"1-253"
"1-258"
"1-283"
"1-202"
"1-229"

fp1.day3.v fp2.day3.v fp5.day3.mia fp6.day3.mia
Actb.Rn00667869_m1
"1-38"
Adipoq.Rn00595250_m1 "1-61"
Adrbk1.Rn00562822_m1 "1-66"
Agtrl1.Rn00580252_s1 "1-91"
"1-10"
Alpl.Rn00564931_m1
"1-37"
B2m.Rn00560865_m1
fp.3.day.3.v fp.4.day.3.v fp.7.day.3.mia fp.8.day.3.mia
Actb.Rn00667869_m1
"2-38"
Adipoq.Rn00595250_m1 "2-61"
Adrbk1.Rn00562822_m1 "2-66"
Agtrl1.Rn00580252_s1 "2-91"
"2-10"
Alpl.Rn00564931_m1
"2-37"
B2m.Rn00560865_m1
gp.1.day.3.v gp.2.day.3.v gp.5.day.3.mia gp.6.day.3.mia
"PlateA-38" "PlateA-134" "PlateA-230"
"PlateA-157" "PlateA-253"
"PlateA-162" "PlateA-258"
"PlateA-187" "PlateA-283"
"PlateA-10" "PlateA-106" "PlateA-202"
"PlateA-133" "PlateA-229"
"PlateA-37"
gp.3.day.3.v gp.4.day.3.v gp.7.day.3.mia gp.8.day.3.mia
"PlateB-38" "PlateB-134" "PlateB-230"
"PlateB-157" "PlateB-253"
"PlateB-162" "PlateB-258"
"PlateB-187" "PlateB-283"

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1 "PlateA-61"
Adrbk1.Rn00562822_m1 "PlateA-66"
Agtrl1.Rn00580252_s1 "PlateA-91"
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1 "PlateB-61"
Adrbk1.Rn00562822_m1 "PlateB-66"
Agtrl1.Rn00580252_s1 "PlateB-91"

"PlateA-326"
"PlateA-349"
"PlateA-354"
"PlateA-379"
"PlateA-298"
"PlateA-325"

"PlateB-326"
"PlateB-349"
"PlateB-354"
"PlateB-379"

"2-326"
"2-349"
"2-354"
"2-379"
"2-298"
"2-325"

"2-230"
"2-253"
"2-258"
"2-283"
"2-202"
"2-229"

"2-134"
"2-157"
"2-162"
"2-187"
"2-106"
"2-133"

12

Alpl.Rn00564931_m1
B2m.Rn00560865_m1

"PlateB-10" "PlateB-106" "PlateB-202"
"PlateB-133" "PlateB-229"
"PlateB-37"

"PlateB-298"
"PlateB-325"

If the files to be combined do not have matching detector names, or if duplicate sample

or plate names are given, read.taqman will stop and give an error message.
When reading in qPCR files with read.qPCR, exprs.well.order will be populated as long
as Well and Plate ID columns are given in the input file, otherwise the exprs.well.order
slot will be NULL.

So when plate ID and Well data are given:

> head(exprs.well.order(qPCRBatch.qPCR))

gene_ai_TechReps.1 A-18
gene_ai_TechReps.2 C-18
gene_az_TechReps.1 A-23
gene_az_TechReps.2 C-23
A-6
gene_bc_TechReps.1
C-6
gene_bc_TechReps.2

caseA caseB controlA controlB
B-43
D-43
B-48
D-48
B-31
D-31

A-43
C-43
A-48
C-48
A-31
C-31

B-18
D-18
B-23
D-23
B-6
D-6

And when they are not:

> qPCR.example.noPlateOrWell <- file.path(path, "qPCR.noPlateOrWell.txt")
> qPCRBatch.qPCR.noPlateOrWell <- read.qPCR(qPCR.example.noPlateOrWell)
> exprs.well.order(qPCRBatch.qPCR.noPlateOrWell)

NULL

Once a qPCRBatch has been populated it is theoretically possible to use any tool which
takes as it’s input an exprs set matrix. However it is important to bear in mind the
values are not raw expression values but Cq values, and a lower Cq will indicate a higher
expression level for a given transcript in the sample. Also it is important to note that when
normalising, the amount is relative and is intended to be compared to another condition or
tissue type in order to look for differential expression between condition; the technology is
not designed to give absolute quantification.

13

