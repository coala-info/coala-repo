NormqPCR: Functions for normalisation of RT-qPCR data

James Perkins and Matthias Kohl
University of Malaga (Spain) / Furtwangen University (Germany)

October 30, 2025

Contents

1 Introduction

2 Combining technical replicates

3 Dealing with undetermined values

4 Selection of most stable reference/housekeeping genes

geNorm . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.1
4.2 NormFinder . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Normalization by means of reference/housekeeping genes

5.1 ∆Cq method using a single housekeeper . . . . . . . . . . . . . . . . . . . .
5.2 ∆Cq method using a combination of housekeeping genes . . . . . . . . . . .
2−∆∆Cq method using a single housekeeper
5.3
. . . . . . . . . . . . . . . . . .
2∆∆Cq method using a combination of housekeeping genes . . . . . . . . . .
5.4
5.5 Compute NRQs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

2

3

5
5
11

14
14
15
16
19
21

1

Introduction

The package "NormqPCR" provides methods for the normalization of real-time quantitative
RT-PCR data. In this vignette we describe and demonstrate the available functions. Firstly
we show how the user may combine technical replicates, deal with undetermined values and
deal with values above a user-chosen threshold. The rest of the vignette is split into two
distinct sections, the first giving details of different methods to select the best houskeeping
gene/genes for normalisation, and the second showing how to use the selected housekeeping
gene(s) to produce 2−∆Cq normalised estimators and 2−∆∆Cq estimators of differential
expression.

1

2 Combining technical replicates

When a raw data file read in using read.qPCR contains technical replicates, they are dealt
with by concatenating the suffix _TechRep.n to the detector name, where n in 1, 2...N
is the number of the replication in the total number of replicates, N, based on order of
appearence in the qPCR data file.

So if we read in a file with technical replicates, we can see that the detector/feature

names are thus suffixed:

> library(ReadqPCR) # load the ReadqPCR library
> library(NormqPCR)
> path <- system.file("exData", package = "NormqPCR")
> qPCR.example.techReps <- file.path(path, "qPCR.techReps.txt")
> qPCRBatch.qPCR.techReps <- read.qPCR(qPCR.example.techReps)
> rownames(exprs(qPCRBatch.qPCR.techReps))[1:8]

[1] "gene_aj_TechReps.1" "gene_aj_TechReps.2" "gene_al_TechReps.1"
[4] "gene_al_TechReps.2" "gene_ax_TechReps.1" "gene_ax_TechReps.2"
[7] "gene_bo_TechReps.1" "gene_bo_TechReps.2"

It is likely that before continuing with the analysis, the user would wish to average the
technical replicates by using the arithmetic mean of the raw Cq values. This can be achieved
using the combineTechReps function, which will produce a new qPCRBatch object, with
all tech reps reduced to one reading:

> combinedTechReps <- combineTechReps(qPCRBatch.qPCR.techReps)
> combinedTechReps

qPCRBatch (storageMode: lockedEnvironment)
assayData: 8 features, 3 samples

element names: exprs

protocolData: none
phenoData

sampleNames: one three two
varLabels: sample
varMetadata: labelDescription

featureData: none
experimentData: use 'experimentData(object)'
Annotation:

2

3 Dealing with undetermined values

When an RT-qPCR experiment does not produce a reading after a certain number of
cycles (the cycle threshold), the reading is given as undetermined. These are represented in
qPCRBatch objects as NA. Different users may have different ideas about how many cycles
they wish to allow before declaring a detector as not present in the sample. There are two
methods for the user to decide what to do with numbers above a given cycle threshold:

First the user might decide that anything above 38 cycles means there is nothing present
in their sample, instead of the standard 40 used by the taqman software. They can replace
the value of all readings above 38 as NA using the following:

Firstly read in the taqman example file which has 96 detectors, with 4 replicates for

mia (case) and 4 non-mia (control):

> path <- system.file("exData", package = "NormqPCR")
> taqman.example <- file.path(path, "/example.txt")
> qPCRBatch.taqman <- read.taqman(taqman.example)

We can see that for the detector: Ccl20.Rn00570287_m1 we have these readings for the

different samples:

> exprs(qPCRBatch.taqman)["Ccl20.Rn00570287_m1",]

fp1.day3.v
NA

fp5.day3.mia
35.74190
fp.4.day.3.v fp.7.day.3.mia fp.8.day.3.mia
36.57921

fp2.day3.v
NA

35.93689

NA

fp6.day3.mia
34.05922

fp.3.day.3.v
35.02052

We can now use the replaceAboveCutOff method in order to replace anything above

35 with NA:

> qPCRBatch.taqman.replaced <- replaceAboveCutOff(qPCRBatch.taqman,
+
> exprs(qPCRBatch.taqman.replaced)["Ccl20.Rn00570287_m1",]

newVal = NA, cutOff = 35)

fp1.day3.v
NA

fp5.day3.mia
NA
fp.4.day.3.v fp.7.day.3.mia fp.8.day.3.mia
NA

fp2.day3.v
NA

NA

NA

fp6.day3.mia
34.05922

fp.3.day.3.v
NA

It may also be the case that the user wants to get rid of all NA values, and replace them
with an arbitrary number. This can be done using the replaceNAs method. So if the user
wanted to replace all NAs with 40, it can be done as follows:

3

> qPCRBatch.taqman.replaced <- replaceNAs(qPCRBatch.taqman, newNA = 40)
> exprs(qPCRBatch.taqman.replaced)["Ccl20.Rn00570287_m1",]

fp1.day3.v
40.00000

fp5.day3.mia
35.74190
fp.4.day.3.v fp.7.day.3.mia fp.8.day.3.mia
36.57921

fp2.day3.v
40.00000

35.93689

40.00000

fp6.day3.mia
34.05922

fp.3.day.3.v
35.02052

In addition, the situation sometimes arises where some readings for a given detector are
above a given cycle threshold, but some others are not. The user may decide for example
that if a given number of readings are NAs, then all of the readings for this detector should
be NAs. This is important because otherwise an unusual reading for one detector might
lead to an inaccurate estimate for the expression of a given gene.

This process will necessarily be separate for the different sample types, since you might
expect a given gene to show expression in one sample type compared to another. Therefore
it is necessary to designate the replicates per sample type using a contrast matrix. It is also
necessary to make a sampleMaxMatrix which gives a maximum number of NAs allowed for
each sample type.

So in the example file above we two sample types, with 4 biological replicates for each,

the contrastMatrix and sampleMaxMatrix might be contructed like this:

> sampleNames(qPCRBatch.taqman)

[1] "fp1.day3.v"
[5] "fp.3.day.3.v"

"fp2.day3.v"
"fp.4.day.3.v"

"fp5.day3.mia"
"fp.7.day.3.mia" "fp.8.day.3.mia"

"fp6.day3.mia"

> a <- c(0,0,1,1,0,0,1,1) # one for each sample type, with 1 representing
> b <- c(1,1,0,0,1,1,0,0) # position of sample type in samplenames vector
> contM <- cbind(a,b)
> colnames(contM) <- c("case","control") # set the names of each sample type
> rownames(contM) <- sampleNames(qPCRBatch.taqman) # set row names
> contM

fp1.day3.v
fp2.day3.v
fp5.day3.mia
fp6.day3.mia
fp.3.day.3.v
fp.4.day.3.v
fp.7.day.3.mia
fp.8.day.3.mia

case control
1
1
0
0
1
1
0
0

0
0
1
1
0
0
1
1

4

> sMaxM <- t(as.matrix(c(3,3))) # now make the contrast matrix
> colnames(sMaxM) <- c("case","control") # make sure these line up with samples
> sMaxM

case control
3

3

[1,]

More details on contrast matrices can be found in the limma manual, which requires a

similar matrix when testing for differential expression between samples.

For example, if the user decides that if at least 3 out of 4 readings are NAs for a given de-
tector, then all readings should be NA, they can do the following, using the makeAllNewVal
method:

> qPCRBatch.taqman.replaced <- makeAllNewVal(qPCRBatch.taqman, contM,
+

sMaxM, newVal=NA)

Here you can see for the Ccl20.Rn00570287_m1 detector, the control values have been
made all NA, wheras before 3 were NA and one was 35. However the case values have been
kept, since they were all below the NA threshold. It is important to filter the data in this
way to ensure the correct calculations are made downstream when calculating variation and
other parameters.

> exprs(qPCRBatch.taqman.replaced)["Ccl20.Rn00570287_m1",]

fp1.day3.v
NA

fp5.day3.mia
35.74190
fp.4.day.3.v fp.7.day.3.mia fp.8.day.3.mia
36.57921

fp2.day3.v
NA

35.93689

NA

fp6.day3.mia
34.05922

fp.3.day.3.v
NA

4 Selection of most stable reference/housekeeping genes

This section contains two subsections containing different methods for the selection of ap-
propriate housekeeping genes.

4.1

geNorm

We describe the selection of the best (most stable) reference/housekeeping genes using the
method of Vandesompele et al (2002) [3] (in the sequel: Vand02) which is called geNorm.
We first load the package and the data

> options(width = 68)
> data(geNorm)
> str(exprs(geNorm.qPCRBatch))

5

num [1:10, 1:85] 0.0425 0.0576 0.1547 0.1096 0.118 ...
- attr(*, "dimnames")=List of 2

..$ : chr [1:10] "ACTB" "B2M" "GAPD" "HMBS" ...
..$ : chr [1:85] "BM1" "BM2" "BM3" "BM4" ...

We start by ranking the selected reference/housekeeping genes. The geNorm algorithm im-
plemented in function selectHKs proceeds stepwise; confer Section “Materials and methods”
in Vand02. That is, the gene stability measure M of all candidate genes is computed and
the gene with the highest M value is excluded. Then, the gene stability measure M for the
remaining gene is calculated and so on. This procedure is repeated until two respectively,
minNrHK genes remain.

> tissue <- as.factor(c(rep("BM", 9),
+
rep("NB", 34), rep("POOL", 9)))
> res.BM <- selectHKs(geNorm.qPCRBatch[,tissue == "BM"], method = "geNorm",
+
+

Symbols = featureNames(geNorm.qPCRBatch),
minNrHK = 2, log = FALSE)

rep("FIB", 20), rep("LEU", 13),

HPRT1

SDHA
0.5160313 0.5314564 0.5335963 0.5700961 0.6064919 0.6201470

RPL13A

YWHAZ

GAPD

UBC

TBP

ACTB
0.6397969 0.7206013 0.7747634 0.8498739
UBC

HMBS

B2M

HPRT1

SDHA
0.4705664 0.5141375 0.5271169 0.5554718 0.5575295 0.5738460

RPL13A

YWHAZ

GAPD

TBP

B2M
0.6042110 0.6759176 0.7671985
SDHA

HMBS

HPRT1

GAPD
0.4391222 0.4733732 0.5243665 0.5253471 0.5403137 0.5560120

RPL13A

YWHAZ

UBC

TBP

HMBS
0.5622094 0.6210820
RPL13A

HPRT1

GAPD
0.4389069 0.4696398 0.4879728 0.5043292 0.5178634 0.5245346

YWHAZ

SDHA

UBC

TBP
0.5563591
HPRT1

SDHA
0.4292808 0.4447874 0.4594181 0.4728920 0.5012107 0.5566762

RPL13A

YWHAZ

GAPD

UBC

UBC

GAPD
0.4195958 0.4204997 0.4219179 0.4424631 0.4841646

RPL13A

YWHAZ

HPRT1

RPL13A

HPRT1
0.3699163 0.3978736 0.4173706 0.4419220

YWHAZ

UBC

UBC

YWHAZ
0.3559286 0.3761358 0.3827933

RPL13A

6

RPL13A

UBC
0.3492712 0.3492712

method = "geNorm",
Symbols = featureNames(geNorm.qPCRBatch),
minNrHK = 2, trace = FALSE, log = FALSE)

> res.POOL <- selectHKs(geNorm.qPCRBatch[,tissue == "POOL"],
+
+
+
> res.FIB <- selectHKs(geNorm.qPCRBatch[,tissue == "FIB"],
+
+
+
> res.LEU <- selectHKs(geNorm.qPCRBatch[,tissue == "LEU"],
+
+
+
> res.NB <- selectHKs(geNorm.qPCRBatch[,tissue == "NB"],
+
+
+

method = "geNorm",
Symbols = featureNames(geNorm.qPCRBatch),
minNrHK = 2, trace = FALSE, log = FALSE)

method = "geNorm",
Symbols = featureNames(geNorm.qPCRBatch),
minNrHK = 2, trace = FALSE, log = FALSE)

method = "geNorm",
Symbols = featureNames(geNorm.qPCRBatch),
minNrHK = 2, trace = FALSE, log = FALSE)

We obtain the following ranking of genes (see Table 3 in Vand02)

> ranks <- data.frame(c(1, 1:9), res.BM$ranking, res.POOL$ranking,
+
+
> names(ranks) <- c("rank", "BM", "POOL", "FIB", "LEU", "NB")
> ranks

res.FIB$ranking, res.LEU$ranking,
res.NB$ranking)

rank

BM
1 RPL13A
UBC
1
2 YWHAZ
3 HPRT1
GAPD
4
5
SDHA
6
7
8
9

HMBS
B2M
ACTB

POOL
FIB
GAPD
GAPD
HPRT1
SDHA
HMBS YWHAZ
UBC

B2M
GAPD
ACTB RPL13A

TBP
SDHA
SDHA
YWHAZ RPL13A HPRT1

ACTB
B2M

B2M
HMBS

LEU
UBC

NB
GAPD
YWHAZ HPRT1
SDHA
UBC
HMBS
TBP YWHAZ
TBP
ACTB
HMBS RPL13A
B2M
ACTB

HPRT1
TBP
UBC
TBP RPL13A

1
2
3
4
5
6
7
8
9
10

Remark 1:
Since the computation is based on gene ratios, the two most stable control genes in each
cell type cannot be ranked.

7

We plot the average expression stability M for each cell type (see Figure 2 in Vand02).

res.LEU$meanM, res.NB$meanM), type = "b",

ylab = "Average expression stability M",
xlab = "Number of remaining control genes",
axes = FALSE, pch = 19, col = mypalette,
ylim = c(0.2, 1.22), lty = 1, lwd = 2,
main = "Figure 2 in Vandesompele et al. (2002)")

> library(RColorBrewer)
> mypalette <- brewer.pal(5, "Set1")
> matplot(cbind(res.BM$meanM, res.POOL$meanM, res.FIB$meanM,
+
+
+
+
+
+
> axis(1, at = 1:9, labels = as.character(10:2))
> axis(2, at = seq(0.2, 1.2, by = 0.2), labels = seq(0.2, 1.2, by = 0.2))
> box()
> abline(h = seq(0.2, 1.2, by = 0.2), lty = 2, lwd = 1, col = "grey")
> legend("topright", legend = c("BM", "POOL", "FIB", "LEU", "NB"),
+

fill = mypalette)

8

Second, we plot the pairwise variation for each cell type (see Figure 3 (a) in Vand02)

> mypalette <- brewer.pal(8, "YlGnBu")
> barplot(cbind(res.POOL$variation, res.LEU$variation, res.NB$variation,
+
+
+
+
+

col = mypalette, space = c(0, 2),
names.arg = c("POOL", "LEU", "NB", "FIB", "BM"),
ylab = "Pairwise variation V",
main = "Figure 3(a) in Vandesompele et al. (2002)")

res.FIB$variation, res.BM$variation), beside = TRUE,

9

Figure 2 in Vandesompele et al. (2002)Number of remaining control genesAverage expression stability M10987654320.20.40.60.811.2BMPOOLFIBLEUNB> legend("topright", legend = c("V9/10", "V8/9", "V7/8", "V6/7",
+
"V5/6", "V4/5", "V3/4", "V2/3"),
+
> abline(h = seq(0.05, 0.25, by = 0.05), lty = 2, col = "grey")
> abline(h = 0.15, lty = 1, col = "black")

fill = mypalette, ncol = 2)

Remark 2:
Vand02 recommend a cut-off value of 0.15 for the pairwise variation. Below this bound the
inclusion of an additional housekeeping gene is not required.

10

POOLLEUNBFIBBMFigure 3(a) in Vandesompele et al. (2002)Pairwise variation V0.000.050.100.150.200.25V9/10V8/9V7/8V6/7V5/6V4/5V3/4V2/34.2 NormFinder

The second method for selection reference/housekeeping genes implemented in package is
the method derived by [1] (in the sequel: And04) called NormFinder.
The ranking contained in Table 3 of And04 can be obtained via

> data(Colon)
> Colon

qPCRBatch (storageMode: lockedEnvironment)
assayData: 13 features, 40 samples

element names: exprs

protocolData: none
phenoData

sampleNames: I459N 90 ... I-C1056T (40 total)
varLabels: Sample.no. Classification
varMetadata: labelDescription

featureData

featureNames: UBC UBB ... TUBA6 (13 total)
fvarLabels: Symbol Gene.name
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation: Table 1 in Andersen et al. (2004)

> Class <- pData(Colon)[,"Classification"]
> res.Colon <- stabMeasureRho(Colon, group = Class, log = FALSE)
> sort(res.Colon) # see Table 3 in Andersen et al (2004)

UBC

GAPD

RPS13
0.1821707 0.2146061 0.2202956 0.2471573 0.2700641 0.2813039
RPS23
0.2862397 0.2870467 0.3139404 0.3235918 0.3692880 0.3784909

TUBA6

CLTC

SUI1

CFL1

ACTB

NACA

TPT1

UBB

FLJ20030
0.3935173

> data(Bladder)
> Bladder

qPCRBatch (storageMode: lockedEnvironment)
assayData: 14 features, 28 samples

element names: exprs

protocolData: none
phenoData

11

sampleNames: 335-6 1131-1 ... 1356-1 (28 total)
varLabels: Sample.no. Grade
varMetadata: labelDescription

featureData

featureNames: ATP5B HSPCB ... FLJ20030 (14 total)
fvarLabels: Symbol Gene.name
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation: Table 1 in Andersen et al. (2004)

> grade <- pData(Bladder)[,"Grade"]
> res.Bladder <- stabMeasureRho(Bladder, group = grade,
+
> sort(res.Bladder)

log = FALSE)

TEGT

HSPCB

RPS13
0.1539598 0.1966556 0.1987227 0.2033477 0.2139626 0.2147852
GAPD
0.2666129 0.2672918 0.2691553 0.2826051 0.2960429 0.3408742

FLJ20030

FLOT2

ATP5B

RPS23

CFL1

TPT1

UBC

UBB

S100A6

ACTB
0.3453435 0.3497295

Of course, we can also reproduce the geNorm ranking also included in Table 3 of And04.

> selectHKs(Colon, log = FALSE, trace = FALSE,
+

Symbols = featureNames(Colon))$ranking

1
"RPS23"
7
"TUBA6"
13
"FLJ20030"

1
"TPT1"
8
"UBB"

3
"RPS13"
9
"NACA"

4
"SUI1"
10
"CFL1"

5
"UBC"
11
"CLTC"

6
"GAPD"
12
"ACTB"

> selectHKs(Bladder, log = FALSE, trace = FALSE,
+

Symbols = featureNames(Bladder))$ranking

1
"CFL1"
7
"RPS23"
13
"ACTB"

1
"UBC"
8
"RPS13"
14
"S100A6"

3
"ATP5B"
9

4
"HSPCB"
10
"TPT1" "FLJ20030"

5
"GAPD"
11
"FLOT2"

6
"TEGT"
12
"UBB"

12

As we are often interested in more than one reference/housekeeping gene we also imple-
mented a step-wise procedure of the NormFinder algorithm explained in Section “Average
control gene” in the supplementary information of And04. This procedure is available via
function selectHKs.

> Class <- pData(Colon)[,"Classification"]
> selectHKs(Colon, group = Class, log = FALSE, trace = TRUE,
+
+

Symbols = featureNames(Colon), minNrHKs = 12,
method = "NormFinder")$ranking

UBC

GAPD

RPS13
0.1821707 0.2146061 0.2202956 0.2471573 0.2700641 0.2813039
RPS23
0.2862397 0.2870467 0.3139404 0.3235918 0.3692880 0.3784909

TUBA6

CLTC

TPT1

NACA

SUI1

CFL1

ACTB

UBB

FLJ20030
0.3935173
GAPD

UBB

TPT1

NACA

TUBA6

RPS13
0.1375298 0.1424519 0.1578360 0.1657364 0.1729069 0.1837057
CLTC
0.1849021 0.2065531 0.2131651 0.2188277 0.2359623 0.2447588
TUBA6
0.1108474 0.1299802 0.1356690 0.1411173 0.1474242 0.1532953

FLJ20030

RPS23

RPS13

CFL1

CFL1

ACTB

SUI1

TPT1

NACA

UBB

FLJ20030

CLTC
0.1583031 0.1586250 0.1682972 0.1686139 0.1926907

RPS23

ACTB

SUI1

UBB

SUI1
0.09656546 0.09674897 0.10753445 0.10830099 0.11801680 0.12612399

TUBA6

RPS13

CFL1

ACTB

CLTC

RPS23
0.12773131 0.13422958 0.14609897 0.16530522
NACA

FLJ20030

RPS13

NACA

CFL1
0.09085973 0.09647829 0.09943424 0.10288912 0.11097074 0.11428399

FLJ20030

TUBA6

SUI1

ACTB

CLTC
0.11495336 0.12635109 0.13286210
CFL1

TUBA6

RPS23

ACTB

CLTC
0.09215478 0.09499893 0.09674032 0.10528784 0.10718604 0.10879846

FLJ20030

NACA

SUI1

RPS23
0.11368091 0.13134766
NACA

SUI1

CFL1
0.08281504 0.08444905 0.08922236 0.09072667 0.10559279 0.10993755

FLJ20030

TUBA6

RPS23

CLTC
0.13142181
NACA

RPS23
0.08336046 0.08410148 0.09315528 0.09775742 0.10499056 0.10554332

FLJ20030

TUBA6

CFL1

CLTC

13

CFL1

RPS23
0.07222968 0.07722737 0.08440691 0.09831958 0.12735605

FLJ20030

TUBA6

CLTC

FLJ20030

RPS23
0.08162006 0.08189011 0.10705192 0.11430674

TUBA6

CLTC

CLTC

CLTC

TUBA6

RPS23
0.06978897 0.08069582 0.13702726
RPS23
0.1199009 0.1245241
1
"UBC"
7
"SUI1"

2
"GAPD"
8
"NACA"

3
"TPT1"
9

4
"UBB"
10
"CFL1" "FLJ20030"

5
"RPS13"
11
"TUBA6"

6
"ACTB"
12
"CLTC"

In case of the Bladder dataset the two top ranked genes are HSPCB and RPS13; see Figure
1 in And04.

> grade <- pData(Bladder)[,"Grade"]
> selectHKs(Bladder, group = grade, log = FALSE, trace = FALSE,
+
+

Symbols = featureNames(Bladder), minNrHKs = 13,
method = "NormFinder")$ranking

1
"HSPCB"
7

2
"RPS13"
8
"UBB" "FLJ20030"

3
"UBC"
9
"CFL1"

4
"RPS23"
10
"S100A6"

5
"ATP5B"
11
"FLOT2"

6
"TEGT"
12
"ACTB"

13
"TPT1"

5 Normalization by means of reference/housekeeping genes

5.1 ∆Cq method using a single housekeeper

The ∆Cq method normalises detectors within a sample by subtracting the cycle time value
of the housekeeper gene from the other genes. This can be done in NormqPCR as follows:

for the example dataset from "ReadqPCR" we must first read in the data:

> path <- system.file("exData", package = "NormqPCR")
> taqman.example <- file.path(path, "example.txt")
> qPCR.example <- file.path(path, "qPCR.example.txt")
> qPCRBatch.taqman <- read.taqman(taqman.example)

We then need to supply a housekeeper gene to be subtracted:

14

> hkgs<-"Actb-Rn00667869_m1"
> qPCRBatch.norm <- deltaCq(qPCRBatch = qPCRBatch.taqman, hkgs = hkgs, calc="arith")
> head(exprs(qPCRBatch.norm))

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1
Adrbk1.Rn00562822_m1
Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1
Adrbk1.Rn00562822_m1
Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1
Adrbk1.Rn00562822_m1
Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

fp1.day3.v fp2.day3.v fp5.day3.mia
0.000000
0.000000
2.933523
-0.116520
6.566628
NA
6.397364
5.035841
13.035166
11.808657
2.040470
0.890717

0.000000
0.016052
NA
4.899380
12.531942
0.741558

fp6.day3.mia fp.3.day.3.v fp.4.day.3.v
0.000000
-0.563263
NA
4.425364
11.772896
0.877598

0.000000
2.540987
6.642561
5.680837
12.239549
2.234605

0.000000
-0.178971
NA
5.220796
12.394802
0.505516

fp.7.day.3.mia fp.8.day.3.mia
0.000000
2.736475
6.873568
5.345202
12.255186
1.903269

0.000000
2.458509
3.737100
4.794776
12.110000
1.927563

This returns a new qPCRBatch, with new values in the exprs slot. This will be compatible

with many other bioconductor and R packages, such as heatmap.

Note these numbers might be negative. For further analysis requiring postive values

only, 2^ can be used to transform the data into 2∆CT values.

5.2 ∆Cq method using a combination of housekeeping genes

If the user wishes to normalise by more than one housekeeping gene, for example if they
have found a more than one housekeeping gene using the NormFinder/geNorm algorithms
described above, they can. This is implemented by calculating the average of these values to
form a "pseudo-housekeeper" which is subtracted from the other values. So using the same
dataset as above, using housekeeping genes GAPDH, Beta-2-microglobulin and Beta-actin,
the following steps would be taken:

> hkgs<-c("Actb-Rn00667869_m1", "B2m-Rn00560865_m1", "Gapdh-Rn99999916_s1")
> qPCRBatch.norm <- deltaCq(qPCRBatch = qPCRBatch.taqman, hkgs = hkgs, calc="arith")
> head(exprs(qPCRBatch.norm))

15

NA

fp1.day3.v fp2.day3.v fp5.day3.mia
-1.380296
Actb.Rn00667869_m1
-1.2998917 -1.2816963
1.553227
Adipoq.Rn00595250_m1 -1.2838397 -1.3982163
5.186332
Adrbk1.Rn00562822_m1
NA
5.017068
Agtrl1.Rn00580252_s1 3.5994883 3.7541447
11.654870
11.2320503 10.5269607
Alpl.Rn00564931_m1
0.660174
-0.5583337 -0.3909793
B2m.Rn00560865_m1
fp6.day3.mia fp.3.day.3.v fp.4.day.3.v
-1.1714227
-1.7346857
NA
3.2539413
10.6014733
-0.2938247

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1
Adrbk1.Rn00562822_m1
Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

-1.1644617
-1.3434327
NA
4.0563343
11.2303403
-0.6589457

-1.5106197
1.0303673
5.1319413
4.1702173
10.7289293
0.7239853

Actb.Rn00667869_m1
Adipoq.Rn00595250_m1
Adrbk1.Rn00562822_m1
Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
B2m.Rn00560865_m1

fp.7.day.3.mia fp.8.day.3.mia
-1.286277
1.450198
5.587291
4.058925
10.968909
0.616992

-1.323712
1.134797
2.413388
3.471064
10.786288
0.603851

5.3 2−∆∆Cq method using a single housekeeper

It is possible to use the 2−∆∆Cq method for calculating relative gene expression between
two sample types. Both the same well and the separate well methods as detailed in [2] can
be used for this purpose, and will produce the same answers, but with different levels of
variation. By default detectors in the same sample will be paired with the housekeeper,
and the standard deviation used will be that of the differences between detectors and
the housekeepers. However, if the argument paired=FALSE is added, standard deviation
between case and control will be calculated as s =
2, where s1 is the standard
deviation for the detector readings and s2 is the standard deviation the housekeeper gene
readings. The latter approach is not recommended when the housekeeper and genes to be
compared are from the same sample, as is the case when using the taqman cards, but is
included for completeness and for situations where readings for the housekeeper might be
taken from a separate biological replicate (for example in a post hoc manner due to the
originally designated housekeeping genes not performing well), or for when NormqPCR is
used for more traditional qPCR where the products undergo amplifications from separate
wells.

1 + s2
s2

(cid:113)

for the example dataset from "ReadqPCR" we must first read in the data:

> path <- system.file("exData", package = "NormqPCR")

16

> taqman.example <- file.path(path, "example.txt")
> qPCR.example <- file.path(path, "qPCR.example.txt")
> qPCRBatch.taqman <- read.taqman(taqman.example)

deltaDeltaCq also requires a contrast matrix. This is to contain columns which will be
used to specify the samples representing case and control which are to be compared, in a
similar way to the "limma" package. these columns should contain 1s or 0s which refer to
the samples in either category:

> contM <- cbind(c(0,0,1,1,0,0,1,1),c(1,1,0,0,1,1,0,0))
> colnames(contM) <- c("interestingPhenotype","wildTypePhenotype")
> rownames(contM) <- sampleNames(qPCRBatch.taqman)
> contM

fp1.day3.v
fp2.day3.v
fp5.day3.mia
fp6.day3.mia
fp.3.day.3.v
fp.4.day.3.v
fp.7.day.3.mia
fp.8.day.3.mia

interestingPhenotype wildTypePhenotype
1
0
1
0
0
1
0
1
1
0
1
0
0
1
0
1

We can now normalise each sample by a given housekeeping gene and then look at the
ratio of expression between the case and control samples. Results show (by column): 1)
Name of gene represented by detector. 2) Case ∆Cq for the detector: the average cycle
time for this detector in the samples denoted as "case" - the housekeeper cycle time. 3) the
standard deviation for the cycle times used to calculate the value in column 2). 4) Control
∆Cq for the detector: the average cycle time for this detector in the samples denoted as
"controller", or the "callibrator" samples - the housekeeper cycle time. 5) The standard
deviation for the cycle times used to calculate the value in column 4). 6) 2−∆∆Cq - The
difference between the ∆Cq values for case and control. We then find 2− of this value. 7)
and 8) correspond to 1 s.d. either side of the mean value, as detailed in [2].

> hkg <- "Actb-Rn00667869_m1"
> ddCq.taqman <- deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1,
+
+
> head(ddCq.taqman)

hkg=hkg, contrastM=contM, case="interestingPhenotype",
control="wildTypePhenotype", statCalc="geom", hkgCalc="arith")

Actb.Rn00667869_m1

ID 2^-dCt.interestingPhenotype
1.000e+00

1

17

2 Adipoq.Rn00595250_m1
3 Adrbk1.Rn00562822_m1
4 Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
5
B2m.Rn00560865_m1
6

1.587e-01
2.602e-02
2.300e-02
1.892e-04
2.464e-01
interestingPhenotype.sd 2^-dCt.wildTypePhenotype
1.000e+00
1.171e+00
NA
3.434e-02
2.298e-04
5.965e-01

0.000e+00
2.280e-02
3.266e-02
1.014e-02
4.770e-05
2.498e-02

wildTypePhenotype.sd

0.000e+00 1
2.131e-01 0.135541545192243

NA +

8.584e-03 0.669721905042939
6.107e-05 0.823327272466571
7.668e-02 0.413128242070071

2^-ddCt 2^-ddCt.min 2^-ddCt.max
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA

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

We can also average the taqman data using the separate samples/wells method . Here
standard deviation is calculated separately and then combined, as described above. There-
fore the pairing of housekeeper with the detector value within the same sample is lost. This
can potentially increase variance.

> hkg <- "Actb-Rn00667869_m1"
> ddCqAvg.taqman <- deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1,
+
+
+
> head(ddCqAvg.taqman)

hkg=hkg, contrastM=contM, case="interestingPhenotype",
control="wildTypePhenotype", paired=FALSE, statCalc="geom",
hkgCalc="arith")

Actb.Rn00667869_m1
1
2 Adipoq.Rn00595250_m1
3 Adrbk1.Rn00562822_m1
4 Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
5
B2m.Rn00560865_m1
6

ID 2^-dCt.interestingPhenotype
1.000e+00
1.587e-01
2.602e-02
2.300e-02
1.892e-04
2.464e-01
interestingPhenotype.sd 2^-dCt.wildTypePhenotype
1.000e+00
1.171e+00

0.000e+00
2.280e-02

1
2

18

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

3.266e-02
1.014e-02
4.770e-05
2.498e-02

wildTypePhenotype.sd

NA
3.434e-02
2.298e-04
5.965e-01

0.000e+00 1
2.131e-01 0.135541545192243

NA +

8.584e-03 0.669721905042939
6.107e-05 0.823327272466571
7.668e-02 0.413128242070071

2^-ddCt 2^-ddCt.min 2^-ddCt.max
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA

5.4 2∆∆Cq method using a combination of housekeeping genes

If the user wishes to normalise by more than one housekeeping gene, for example if they
have found a more than one housekeeping gene using the NormFinder/geNorm algorithms
described above, they can. This is implemented by calculating the average of these values us-
ing the geometric mean to form a "pseudo-housekeeper" which is subtracted from the other
values. For the dataset above, using housekeeping genes GAPDH, Beta-2-microglobulin
and Beta-actin:

> qPCRBatch.taqman <- read.taqman(taqman.example)
> contM <- cbind(c(0,0,1,1,0,0,1,1),c(1,1,0,0,1,1,0,0))
> colnames(contM) <- c("interestingPhenotype","wildTypePhenotype")
> rownames(contM) <- sampleNames(qPCRBatch.taqman)
> hkgs<-c("Actb-Rn00667869_m1", "B2m-Rn00560865_m1", "Gapdh-Rn99999916_s1")
> ddCq.gM.taqman <- deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1,
+
+
> head(ddCq.gM.taqman)

hkgs=hkgs, contrastM=contM, case="interestingPhenotype",
control="wildTypePhenotype", statCalc="arith", hkgCalc="arith")

1
Actb.Rn00667869_m1
2 Adipoq.Rn00595250_m1
3 Adrbk1.Rn00562822_m1
4 Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
5
B2m.Rn00560865_m1
6

ID 2^-dCt.interestingPhenotype
2.594e+00
4.083e-01
4.182e-02
5.520e-02
4.767e-04
6.367e-01
interestingPhenotype.sd 2^-dCt.wildTypePhenotype
2.345e+00
2.713e+00
NA

0.09819
0.24929
1.45844

1
2
3

19

4
5
6

1
2
3
4
5
6

0.63719
0.42589
0.05413

7.878e-02
5.242e-04
1.390e+00

wildTypePhenotype.sd

0.071373 1.10638851325547
0.201905 0.150497255530234

NA +

0.333840 0.700597907024805
0.386280 0.909381199520663
0.163975 0.457939394245865

2^-ddCt 2^-ddCt.min 2^-ddCt.max
1.184310
0.178884
NA
1.089636
1.221662
0.475448

1.034e+00
1.266e-01
NA
4.505e-01
6.769e-01
4.411e-01

There is also the option of using the mean housekeeper method using shared variance
between the samples being compared, similar to the second deltaDeltaCq method shown
above.

> qPCRBatch.taqman <- read.taqman(taqman.example)
> contM <- cbind(c(0,0,1,1,0,0,1,1),c(1,1,0,0,1,1,0,0))
> colnames(contM) <- c("interestingPhenotype","wildTypePhenotype")
> rownames(contM) <- sampleNames(qPCRBatch.taqman)
> hkgs<-c("Actb-Rn00667869_m1", "B2m-Rn00560865_m1", "Gapdh-Rn99999916_s1")
> ddAvgCq.gM.taqman <-deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1,
+
+
+
> head(ddAvgCq.gM.taqman)

hkgs=hkgs, contrastM=contM, case="interestingPhenotype",
control="wildTypePhenotype", paired=FALSE, statCalc="arith",
hkgCalc="arith")

1
Actb.Rn00667869_m1
2 Adipoq.Rn00595250_m1
3 Adrbk1.Rn00562822_m1
4 Agtrl1.Rn00580252_s1
Alpl.Rn00564931_m1
5
B2m.Rn00560865_m1
6

ID 2^-dCt.interestingPhenotype
2.594e+00
4.083e-01
4.182e-02
5.520e-02
4.767e-04
6.367e-01
interestingPhenotype.sd 2^-dCt.wildTypePhenotype
2.345e+00
2.713e+00
NA
7.878e-02
5.242e-04
1.390e+00

0.3849
0.4822
1.4545
0.6905
0.5846
0.2777

1
2
3
4
5
6

1

wildTypePhenotype.sd

0.3574 1.10638851325547

2^-ddCt 2^-ddCt.min 2^-ddCt.max
1.444684

8.473e-01

20

2
3
4
5
6

0.2495 0.150497255530234

NA +

0.2813 0.700597907024805
0.3689 0.909381199520663
0.4576 0.457939394245865

1.077e-01
NA
4.341e-01
6.064e-01
3.778e-01

0.210221
NA
1.130625
1.363762
0.555126

TO SHOW EXAMPLE USING GENORM/NORMFINDER DATA

5.5 Compute NRQs

THIS FUNCTION IS STILL EXPERIMENTAL!

We load a dataset including technical replicates.

> path <- system.file("exData", package = "ReadqPCR")
> qPCR.example <- file.path(path, "qPCR.example.txt")
> Cq.data <- read.qPCR(qPCR.example)

We combine the technical replicates and in addition compute standard deviations.

> Cq.data1 <- combineTechRepsWithSD(Cq.data)

We load efficiencies for the dataset and add them to the dataset.

> Effs <- file.path(path, "Efficiencies.txt")
> Cq.effs <- read.table(file = Effs, row.names = 1, header = TRUE)
> rownames(Cq.effs) <- featureNames(Cq.data1)
> effs(Cq.data1) <- as.matrix(Cq.effs[,"efficiency",drop = FALSE])
> se.effs(Cq.data1) <- as.matrix(Cq.effs[,"SD.efficiency",drop = FALSE])

Now we can compute normalized relative quantities for the dataset where we consider two
of the included features as reference/housekeeping genes.

> res <- ComputeNRQs(Cq.data1, hkgs = c("gene_az", "gene_gx"))
> ## NRQs
> exprs(res)

caseB

caseA

controlA

controlB
gene_ai 1.9253072 1.3586729 0.6479659 0.8749479
gene_az 1.0567118 1.1438982 1.0331980 0.9134997
gene_bc 1.1024935 0.7193500 0.7030487 1.2140836
gene_by 1.5102316 0.9573047 0.7527082 1.6008850
gene_dh 1.2982037 1.0722522 0.9623335 0.9392871
gene_dm 0.6590246 1.1690720 1.2475372 0.9366210
gene_dq 0.7541955 0.7036408 0.8327917 1.6165326

21

gene_dr 2.2192305 1.0581211 0.7026411 0.6900584
gene_eg 0.9366671 0.5800339 0.8313720 1.1848856
gene_er 0.5269062 0.9375427 0.6953326 2.3195978
gene_ev 1.4622280 2.3457021 0.9038912 1.1454535
gene_fr 1.4954763 1.6200792 0.9641192 0.7295680
gene_fw 0.6944248 0.8051075 1.5698382 0.7978611
gene_gx 0.9463318 0.8742037 0.9678687 1.0946911
gene_hl 1.0009372 1.4015267 0.7683665 0.7713712
gene_il 1.4632019 1.2595559 0.7216891 0.9318860
gene_iv 1.7263335 1.2275001 1.5464212 0.8881605
gene_jr 0.8984351 0.9834026 0.8754813 0.6637941
gene_jw 1.4655948 0.9340184 1.0505200 1.5504136
gene_qs 0.6730225 0.7610418 1.0665938 3.5329891
gene_qy 0.5287127 1.5722670 1.0615326 3.3252907
gene_rz 0.8690600 1.5588299 0.7287288 1.4812753
gene_sw 0.5975288 1.2406438 0.6982954 1.6007333
gene_vx 0.6942254 0.7168408 2.0253177 1.3190943
gene_xz 0.7668030 1.0218209 0.6136038 1.6729352

> ## SD of NRQs
> se.exprs(res)

caseA

caseB

controlA

controlB
gene_ai 1.3996554 0.8787290 0.4855882 1.0034912
gene_az 0.6832730 0.7601966 0.8971054 0.6031927
gene_bc 0.7225348 0.4746146 0.9626570 1.0478385
gene_by 1.1522746 0.6116269 0.6088836 2.0409211
gene_dh 1.2483072 0.7889984 0.6165041 0.9767947
gene_dm 0.4711409 0.7780238 0.8476053 0.7294405
gene_dq 0.7023561 0.4849899 0.5813310 1.4067670
gene_dr 1.4407662 1.0804211 0.4543153 0.5149367
gene_eg 0.7355269 0.5497433 0.5588801 1.0938601
gene_er 0.4301195 0.6119514 0.4471454 1.5115897
gene_ev 1.0094209 2.4267114 0.6337126 0.7782519
gene_fr 1.6760391 1.1119157 0.6226081 0.5040967
gene_fw 0.5041070 0.9131565 1.1153268 0.7234551
gene_gx 0.6046042 0.9027816 0.6713914 1.7394961
gene_hl 0.7633174 0.9123997 1.0000329 0.5005813
gene_il 1.4621406 0.9540445 0.5678634 0.6067147
gene_iv 1.2668346 0.8039841 0.9995225 0.8171996
gene_jr 0.5749672 0.6786989 0.5595295 0.4405919

22

gene_jw 0.9626606 0.7890401 0.7194378 1.1512512
gene_qs 0.5830335 0.5309990 0.6828952 2.8253799
gene_qy 0.5947918 1.1294199 0.6794829 2.1713340
gene_rz 0.5846751 1.7926435 0.4911506 2.1424580
gene_sw 0.6284440 0.8062083 0.9638307 1.8398593
gene_vx 0.5285361 1.0126959 1.3861226 0.8683886
gene_xz 0.5231477 0.9270275 0.3972901 1.3643840

References

[1] Claus Lindbjerg Andersen, Jens Ledet Jensen and Torben Falck Orntoft (2004). Nor-
malization of Real-Time Quantitative Reverse Transcription-PCR Data: A Model-Based
Variance Estimation Approach to Identify Genes Suited for Normalization, Applied to
Bladder and Colon Cancer Data Sets CANCER RESEARCH 64, 52455250, August 1,
2004 http://cancerres.aacrjournals.org/cgi/content/full/64/15/5245 11

[2] Kenneth Livak, Thomase Schmittgen (2001). Analysis of Relative Gene Expression Data
Using Real-Time Quantitative PCR and the 2∆∆Ct Method. Methods 25, 402-408, 2001
http://www.ncbi.nlm.nih.gov/pubmed/11846609 16, 17

[3] Jo Vandesompele, Katleen De Preter, Filip Pattyn, Bruce Poppe, Nadine Van Roy, Anne
De Paepe and Frank Speleman (2002). Accurate normalization of real-time quantitative
RT-PCR data by geometric averiging of multiple internal control genes. Genome Biology
2002, 3(7):research0034.1-0034.11 http://genomebiology.com/2002/3/7/research/
0034/ 5

[4] Jan Hellemans, Geert Mortier, Anne De Paepe, Frank Speleman and Jo Vandesom-
pele (2007). qBase relative quantification framework and software for management and
automated analysis of real-time quantitative PCR data. Genome Biology 2007, 8:R19

23

