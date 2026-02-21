Bioconductor’s aCGH package

Jane Fridlyand1 and Peter Dimitrov2

October 29, 2025

1. Department of Epidemiology and Biostatistics, and Comprehensive Cancer Center,
University of California, San Francisco, jfridlyand@cc.ucsf.edu
2. Division of Biostatistics, University of California, Berkeley, dimitrov@stat.berkeley.edu

Contents

1 Overview

2 Data

1

2

3 Examples

2
2
3.1 Creating aCGH object from log2.ratios and clone info files . . . . . . . . . . . .
2
3.2 Filtering and imputation for objects of class aCGH . . . . . . . . . . . . . . . .
3
3.3 Printing, summary and basic plotting (fig. 1) for objects of class aCGH . . . .
5
3.4 Reading Sproc files . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
3.5 Basic plot for batch of aCGH Sproc files. (fig. 2) . . . . . . . . . . . . . . . . .
7
3.6 Subsetting example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
3.7 Basic plot for the ordered log2 ratios along the genome . . . . . . . . . . . . . .
3.8 Computing and plotting hmm states . . . . . . . . . . . . . . . . . . . . . . . .
9
3.9 Plotting summary of the tumor profiles . . . . . . . . . . . . . . . . . . . . . . . 11
3.10 Overall frequency plot (fig. 5) . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
3.11 Testing association of clones with categorical, censored or continuous outcomes. 14
3.12 Clustering samples . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24

4 Acknowledgements

1 Overview

25

This document presents an overview of the aCGH package, which provides wide basic functions
for reading, analyzing and plotting array Comparative Genomic Hybridization data (Snijders
et al. (2001)). Specific example for reading data in is using output of the custom freely
available programs, SPOT and SPROC (Jain et al. (2002)). These programs provide image
quantification and pre-processing. Outputs of all the other image processing software need to
be combined into a single file containing observed values for each clone and samples and then
read in as a matrix.

1

2 Data

The data used in the example was generated in in lab of Dr. Fred Waldman at UCSF Com-
prehensive Cancer Center (Nakao et al. (2004)).Array CGH has been done on 125 colorectal
fresh-frozen primary tumors and the associations with various phenotypes were analyzed. To
reduce running time, only 40 samples are used in the examples.

3 Examples

3.1 Creating aCGH object from log2.ratios and clone info files

Each array CGH object has to contain the log2ratios representing relative copy number along
with the mapping information including but not limited to clone name, chromosome and kb
relative to the chromosome. Optionally there may be phenotypes associated with each sample.

read.table(file = file.path(datadir, "clones.info.ex.txt"),

> library(aCGH)
> datadir <- system.file(package = "aCGH")
> datadir <- paste(datadir, "/examples", sep="")
> clones.info <-
+
+
> log2.ratios <-
+
+
> pheno.type <-
+
+
> ex.acgh <- create.aCGH(log2.ratios, clones.info, pheno.type)

read.table(file = file.path(datadir, "pheno.type.ex.txt"),

read.table(file = file.path(datadir, "log2.ratios.ex.txt"),

header = T, sep = "\t", quote="", comment.char="")

header = T, sep = "\t", quote="", comment.char="")

header = T, sep = "\t", quote="", comment.char="")

Note that when working with your own data, you will need to specify absolute path to those
files ot the path relative to your working folder. For instance, if you are working in the folder
Project1 your data files are placed in the subfolder Project1/Data, then datadir = "Data" if
you are using relative path.

3.2 Filtering and imputation for objects of class aCGH

Here we remove unmapped clones and clones mapping to Y chromosome, screen out clones
missing in more than 25

> ex.acgh <-
+

aCGH.process(ex.acgh, chrom.remove.threshold = 23, prop.missing = .25, sample.quality.threshold = .4, unmapScreen=TRUE, dupRemove = FALSE)

Here we impute missing observations using lowess approach. Note that occasionally, major-
ity of the observations on chromosome Y may be missing causing imputing function to fail.
Therefore, by default, the largest chromosome to be imputed is indexed as maxChrom=23
(X). Here we specify imputation for all chromosomes ; however, in this example there are no
data on chromosome Y.

> log2.ratios.imputed(ex.acgh) <- impute.lowess(ex.acgh, maxChrom=24)

2

Processing chromosome 1
Processing chromosome 2
Processing chromosome 3
Processing chromosome 4
Processing chromosome 5
Processing chromosome 6
Processing chromosome 7
Processing chromosome 8
Processing chromosome 9
Processing chromosome 10
Processing chromosome 11
Processing chromosome 12
Processing chromosome 13
Processing chromosome 14
Processing chromosome 15
Processing chromosome 16
Processing chromosome 17
Processing chromosome 18
Processing chromosome 19
Processing chromosome 20
Processing chromosome 21
Processing chromosome 22
Processing chromosome 23

3.3 Printing, summary and basic plotting (fig. 1) for objects of class aCGH

> data(colorectal)
> colorectal

aCGH object
Call: aCGH.read.Sprocs(sproclist[1:40], "human.clones.info.Jul03.csv",

chrom.remove.threshold = 23)

Number of Arrays 40
Number of Clones 2031

> summary(colorectal)

aCGH object
Call: aCGH.read.Sprocs(sproclist[1:40], "human.clones.info.Jul03.csv",

chrom.remove.threshold = 23)

Number of Arrays 40
Number of Clones 2031
Imputed data exist
HMM states assigned
samples standard deviations are computed

3

genomic events are assigned
phenotype exists

> plot(colorectal)

Figure 1: Basic Frequency Plot

4

−1.0−0.6−0.20.20.40.60.81.0All Sampleschromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21X> sample.names(colorectal)

[1] "sprocCR31.txt" "sprocCR40.txt" "sprocCR43.txt" "sprocCR59.txt"
[5] "sprocCR63.txt" "sprocCR73.txt" "sprocCR75.txt" "sprocCR77.txt"
[9] "sprocCR96.txt" "sprocCR98.txt" "sprocCR100.txt" "sprocCR106.txt"
[13] "sprocCR112.txt" "sprocCR122.txt" "sprocCR124.txt" "sprocCR131.txt"
[17] "sprocCR135.txt" "sprocCR137.txt" "sprocCR146.txt" "sprocCR148.txt"
[21] "sprocCR150.txt" "sprocCR154.txt" "sprocCR159.txt" "sprocCR163.txt"
[25] "sprocCR169.txt" "sprocCR178.txt" "sprocCR180.txt" "sprocCR186.txt"
[29] "sprocCR193.txt" "sprocCR200.txt" "sprocCR204.txt" "sprocCR210.txt"
[33] "sprocCR212.txt" "sprocCR217.txt" "sprocCR219.txt" "sprocCR227.txt"
[37] "sprocCR232.txt" "sprocCR244.txt" "sprocCR246.txt" "sprocCR248.txt"

> phenotype(colorectal)[1:4,]

id age sex stage loc
0
0
1
0

1 31 70
2 40 71
3 43 59
4 59 72

1
1
1
2

0 Adenocarcinoma
1 Adenocarcinoma
0 Adenocarcinoma
1 Adenocarcinoma

hist diff gstm1 gstt1 nqo K12 K13 MTHFR ERCC1
1
2
1
NA

1
1
NA
1

2
2
2
1

1
1
1
1

1
1
1
1

2
2
2
2

0
1
1
1

1
2
3
4

0
0
0
0

0
0
0
0

0
1
0
0

bat26 bat25 D5S346 D17S250 D2S123
0
0/1 unstable loci negative
1 >2 loci unstable, (NCI def) negative
0/1 unstable loci negative
0
0/1 unstable loci negative
0

0
1
0
0
K12AA k13 K13AA M677 M1298 p16 p14 mlh1 BAT26 mlh1c
0
0
0
1

0 0/1 unstable loci
0 >2 loci unstable
0 0/1 unstable loci
0 0/1 unstable loci

1
1
1
0

.
.
.
.

1
0
0
0

0
0
0
0

0
0
0
0

1
0
2
0

0
0
0
1

LOH k12
1
0
0
0

mi misum
0
3
0
0

1
2
2
2
mi2

1
2
3
4

GTT
.
.
.
CGHSTAT
1 Complete
2 Complete
3 Complete
4 Not Done

3.4 Reading Sproc files

Here we demonstrate reading of the sproc files and combining them into one array CGH object.
Sproc file format is specific to the custom SPROC processing software at UCSF Cancer Center.

file.path(datadir, "human.clones.info.Jul03.txt")

> datadir <- system.file("examples", package = "aCGH")
> latest.mapping.file <-
+
> ex.acgh <-
+
+
+

full.names = TRUE), latest.mapping.file,
chrom.remove.threshold = 23)

aCGH.read.Sprocs(dir(path = datadir,pattern = "sproc",

5

Trying to read
Trying to read

/tmp/RtmpwrYvsz/Rinst312c411d021176/aCGH/examples/sprocCR40.txt
/tmp/RtmpwrYvsz/Rinst312c411d021176/aCGH/examples/sprocCR43.txt

1662 1663

1640 1641
1633 1634

153 154

815 816

409 410

825 826

1220 1221

662 663
256 257

Averaging duplicated clones
692 693
CTB-102E19
CTB-112F7
1692 1693
CTB-142O24
CTB-339E12
CTB-36F16
DMPC-HFF#1-61H8
GS1-202O8
RP1-97B16
RP11-119J20
RP11-13C20
RP11-149G12
RP11-172D2
RP11-175H20
RP11-176L22
RP11-188C10
RP11-1L22
RP11-204M16
RP11-238H10
RP11-23G2
RP11-247E23
RP11-268N2
RP11-30M1
RP11-39A8
RP11-47E6
RP11-72C6
RP11-83O14
RP11-94M13

166 167
158 159
170 171
1006 1007
819 820
873 874

821 822
183 184
817 818

785 786
850 851

147 148

178 179

176 177

813 814

> ex.acgh

aCGH object
Call: aCGH.read.Sprocs(dir(path = datadir, pattern = "sproc", full.names = TRUE),

latest.mapping.file, chrom.remove.threshold = 23)

Number of Arrays 2
Number of Clones 1952

3.5 Basic plot for batch of aCGH Sproc files. (fig. 2)

6

> plot(ex.acgh)

Figure 2: Basic plot for batch of aCGH Sproc files

3.6 Subsetting example

> cr <- colorectal[ ,1:3]

7

−1.0−0.6−0.20.20.40.60.81.0All Sampleschromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21X3.7 Basic plot for the ordered log2 ratios along the genome

The relative copy number is plotted along the genome with clones placed in the genomic order.
We are plotting sample 2 here. (fig. 3). Chromosome Y is explicitely excluded.

> plotGenome(ex.acgh, samples=2, Y = FALSE)

Figure 3: Basic plot for the ordered log2 ratios along the genome

8

−2.0−1.5−1.0−0.50.00.51.01.52.02   /tmp/RtmpwrYvsz/Rinst312c411d021176/aCGH/examples/sprocCR43.txtLog2Ratio 1 3 5 7 9 11 13 15 17 19 21 2 4 6 8 10 12 14 16 18 20 22X3.8 Computing and plotting hmm states

Unsupervised hidden markov model is repeatedly fitted to each chromosome for varying num-
ber of states (2 , ..., 5). The number of states is determined after all fits are done usingmodel
selection criterion such as AIC, BIC or delta-BIC. The model with minimal penalized nega-
tive log-likelihood is chosen for each selection criterion. Note, that some of the model fits are
going to fail and are not going to be used in the final selection. Meanwhile , error message
warning of the model fit failing will be printed during hmm runs. The user shoulld ignore
those particular messages and related warnings.
For a given sample, each chromosome is plotted on a separate page along with its smoothed
values(fig. 4). The genomic events such as transitions, focal aberrations and amplifications
are indicated. The outliers are also marked.

mergeHmmStates(ex.acgh, model.use = 1, minDiff = .25)

> ## Determining hmm states of the clones. In the interest of time,
> ##we have commented this step out and used pre-computed results.
>
> ##hmm(ex.acgh) <- find.hmm.states(ex.acgh)
> hmm(ex.acgh) <- ex.acgh.hmm
> ## Merging hmm states
>
> hmm.merged(ex.acgh) <-
+
> ## Calculating the standard deviations for each array. Standard error is
> ##calculated for each region and then averaged across regions. The final
> ##SDs for each samples are contained in sd.samples(exa.acgh)$madGenome.
>
> sd.samples(ex.acgh) <- computeSD.Samples(ex.acgh)
> ## Finding the genomic events associated with each sample using
> ##results of the partitioning into the states.
>
> genomic.events(ex.acgh) <- find.genomic.events(ex.acgh)

Finding outliers
Finding focal low level aberrations
Finding transitions
Finding focal amplifications
Processing chromosome 1
Processing chromosome 2
Processing chromosome 3
Processing chromosome 4
Processing chromosome 5
Processing chromosome 6
Processing chromosome 7
Processing chromosome 8
Processing chromosome 9
Processing chromosome 10
Processing chromosome 11
Processing chromosome 12

9

Processing chromosome 13
Processing chromosome 14
Processing chromosome 15
Processing chromosome 16
Processing chromosome 17
Processing chromosome 18
Processing chromosome 19
Processing chromosome 20
Processing chromosome 21
Processing chromosome 22
Processing chromosome 23

>
> ## Plotting and printing the hmm states either to the screen or into the
> ##postscript file. Each chromosome for each sample is plotted on a separate
> ##page
>
> ##postscript("hmm.states.temp.ps");plotHmmStates(ex.acgh, sample.ind=1);dev.off()

10

> plotHmmStates(colorectal, sample.ind = 1, chr = 1)

Figure 4: Plotting the hmm states found for colorectal data set.

3.9 Plotting summary of the tumor profiles

Here the distribution of various genomic events as well as their frequency by location is dis-
played. Run the function plotSummaryProfile(colorectal) which produces multi-page figure.
Necessary to write out as ps or pdf files.

3.10 Overall frequency plot (fig. 5)

11

020406080120160200240−2.00.01.5Sample 1 sprocCR31.txt − Chr 1 Number of states 2kb (in 1000's)data (observed)020406080120160200240−2.00.01.5kb (in 1000's)data (smoothed)> plotFreqStat(colorectal, all = T)

Figure 5: Overall frequency plot of the tumor profiles

summarize.clones() function is the text equivalent of plotFreqStat() - it summarizes the fre-
quencies of changes for each clone across tumors and includes results of statistical comparisons
for each clone when available.

> summarize.clones(colorectal)[1:10 ,]

Clone

Target Chrom

2
3
4
5
6
7
8
9

RP11-82D16 HumArray2H11_C9
RP11-62M23 HumArray2H10_N30
RP11-111O5 HumArray2H10_B18
RP11-51B4 HumArray2H10_Q30
RP11-60J11 HumArray2H10_T30
RP11-813J5 HumArray2H10_B19
RP11-199O1 HumArray2H10_W30
RP11-188F7 HumArray2H9_C14

kb NumPresent.All NumGain.All
4
1
1
0
1
0
1
1

39
35
38
35
36
30
39
36

1 2009
1 3368
1 4262
1 6069
1 6817
1 9498
1 10284
1 12042

12

−1.0−0.6−0.20.20.40.60.81.0All Sampleschromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21X10 RP11-178M15
RP11-219F4
11

HumArray2H9_F14
HumArray2H9_I14

1 13349
1 14391

35
39

1
1

NumLost.All PropPresent.All PropGain.All PropLost.All
0.18
0.20
0.24
0.29
0.19
0.27
0.13
0.11
0.11
0.18

0.10
0.03
0.03
0.00
0.03
0.00
0.03
0.03
0.03
0.03

0.98
0.88
0.95
0.88
0.90
0.75
0.98
0.90
0.88
0.98

7
7
9
10
7
8
5
4
4
7

2
3
4
5
6
7
8
9
10
11

threshold.func() function gives the clone by sample matrix of gains and losses. "1" indicates
gain and "-1" indicates loss.

> factor <- 3
> tbl <- threshold.func(log2.ratios(colorectal),
+
> rownames(tbl) <- clone.names(colorectal)
> colnames(tbl) <- sample.names(colorectal)
> tbl[1:5,1:5]

posThres=factor*(sd.samples(colorectal)$madGenome))

RP11-82D16
RP11-62M23
RP11-111O5
RP11-51B4
RP11-60J11

RP11-82D16
RP11-62M23
RP11-111O5
RP11-51B4
RP11-60J11

sprocCR31.txt sprocCR40.txt sprocCR43.txt sprocCR59.txt
-1
-1
-1
-1
-1

0
0
0
NA
0

0
0
0
0
0

0
0
0
0
0
sprocCR63.txt
1
0
1
0
0

fga.func() function gives the fraction of genome altered for each sample.

> col.fga <- fga.func(colorectal, factor=3,chrominfo=human.chrom.info.Jul03)
> cbind(gainP=col.fga$gainP,lossP=col.fga$lossP)[1:5,]

lossP
gainP
[1,] 0.220098155 0.184029096
[2,] 0.025559893 0.004990002
[3,] 0.006184865 0.002350805
[4,] 0.107402285 0.148058176
[5,] 0.143115647 0.137430523

13

3.11 Testing association of clones with categorical, censored or continuous

outcomes.

Use mt.maxT function from multtest package to test differences in group means for each clone
grouped by sex. Plot the result along the genome displaying the frequencies of gains and losses
as well well as height of the statistic correponsding to each clone(figs. 6 and 7.). The p-value
can be adjusted and the horizontal lines indicate chosen level of significance.

> colnames(phenotype(colorectal))

[1] "id"
[8] "gstm1"
[15] "bat26"
[22] "k12"
[29] "p14"

"age"
"gstt1"
"bat25"
"K12AA"
"mlh1"

"sex"
"nqo"
"D5S346"
"k13"
"BAT26"

"loc"
"K13"

"stage"
"K12"
"D17S250" "D2S123"
"K13AA"
"mlh1c"

"M677"
"mi"

"hist"
"MTHFR"
"mi2"
"M1298"
"misum"

"diff"
"ERCC1"
"LOH"
"p16"
"CGHSTAT"

> sex <- phenotype(colorectal)$sex
> sex.na <- !is.na(sex)
> index.clones.use <- which(clones.info(colorectal)$Chrom < 23)
> colorectal.na <- colorectal[ index.clones.use,sex.na , keep=TRUE]
> dat <- log2.ratios.imputed(colorectal.na)
> resT.sex <- mt.maxT(dat, sex[sex.na], test = "t.equalvar", B = 1000)

b=10
b=110
b=210
b=310
b=410
b=510
b=610
b=710
b=810
b=910

b=20

b=30

b=40

b=50

b=60

b=70

b=80

b=90

b=100

b=120
b=220
b=320
b=420
b=520
b=620
b=720
b=820
b=920

b=130
b=230
b=330
b=430
b=530
b=630
b=730
b=830
b=930

b=140
b=240
b=340
b=440
b=540
b=640
b=740
b=840
b=940

b=150
b=250
b=350
b=450
b=550
b=650
b=750
b=850
b=950

b=160
b=260
b=360
b=460
b=560
b=660
b=760
b=860
b=960

b=170
b=270
b=370
b=470
b=570
b=670
b=770
b=870
b=970

b=180
b=280
b=380
b=480
b=580
b=680
b=780
b=880
b=980

b=190

b=290

b=390

b=490

b=590

b=690

b=790

b=890

b=990

b=200

b=300

b=400

b=500

b=600

b=700

b=800

b=900

b=1000

14

> plotFreqStat(colorectal.na, resT.sex, sex[sex.na], factor=3, titles =
c("Female", "Male"), X = FALSE, Y = FALSE)
+

Figure 6: Frequency plots of the samples with respect to the sex groups

15

−1.00.00.8Femalechromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21−1.00.00.8Malechromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 210.02.04.0Female vs Malechromosome numberclone statistic 1 3 5 7 9 11 13 15 17 19 21 2 4 6 8 10 12 14 16 18 20 22> plotSummaryProfile(colorectal, response = sex,
+
+

titles = c("Female", "Male"),
X = FALSE, Y = FALSE, maxChrom = 22)

Figure 7: Plotting summary of the tumor profiles

16

FemaleMale051525Number of Transitions 0.0950684resp.naeventsFemaleMale0510Number of Chrom containing Transitions 0.174915resp.naeventsFemaleMale050100150Number of Aberrations 0.841381resp.naeventsFemaleMale051015Number of Whole Chrom Changes 0.0174111resp.naeventsTesting association of clones with categorical outcome for autosomal clones that are gained or
lost in at least 10% of the samples. Note that the same dataset should be provided for creat-
ing resT object and for plotting. Pay attention that HMM-related objects including sample
variability do not get subsetted at the moment. Note that currently two-stage subsetting does
not work for HMM slots, i.e. two conditions (change and autosomal) need to be done in one
iteration.

> factor <- 3
> minChanged <- 0.1
> gainloss <- gainLoss(log2.ratios(colorectal)[,sex.na], cols=1:length(which(sex.na)), thres=(factor*(sd.samples(colorectal)$madGenome))[sex.na])
> ind.clones.use <- which(gainloss$gainP >= minChanged | gainloss$lossP>= minChanged & clones.info(colorectal)$Chrom < 23)
> colorectal.na <- colorectal[ind.clones.use,sex.na, keep=TRUE]
> dat <- log2.ratios.imputed(colorectal.na)
> resT.sex <- mt.maxT(dat, sex[sex.na],test = "t.equalvar", B = 1000)

b=20

b=30

b=40

b=50

b=60

b=70

b=80

b=90

b=100

b=120
b=220
b=320
b=420
b=520
b=620
b=720
b=820
b=920

b=130
b=230
b=330
b=430
b=530
b=630
b=730
b=830
b=930

b=140
b=240
b=340
b=440
b=540
b=640
b=740
b=840
b=940

b=150
b=250
b=350
b=450
b=550
b=650
b=750
b=850
b=950

b=160
b=260
b=360
b=460
b=560
b=660
b=760
b=860
b=960

b=170
b=270
b=370
b=470
b=570
b=670
b=770
b=870
b=970

b=180
b=280
b=380
b=480
b=580
b=680
b=780
b=880
b=980

b=190

b=290

b=390

b=490

b=590

b=690

b=790

b=890

b=990

b=200

b=300

b=400

b=500

b=600

b=700

b=800

b=900

b=1000

b=10
b=110
b=210
b=310
b=410
b=510
b=610
b=710
b=810
b=910

>

17

> plotFreqStat(colorectal.na, resT.sex, sex[sex.na],factor=factor,titles = c("Male", "Female"))

Figure 8: Frequency plots of the samples with respect to the sex groups for clones gained or
lost in at least 10% of the samples

18

−1.00.00.8Malechromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21X−1.00.00.8Femalechromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21X0.02.04.0Male vs Femalechromosome numberclone statistic 1 3 5 7 9 11 13 15 17 19 21 2 4 6 8 10 12 14 16 18 20 22XTesting association of clones with censored outcomes.Since there was no survival data avail-
able, we simulate data for a simple example to demonstrate creation and usage of basic survival
object. We create an object equivalent to resT object that was created earlier. In the fig-
ure the samples are seprated into dead and alive/censored groups for ease of visualization.
Nevertheless, statistic is computed and assessed for significance using proper survival object.

> time <- rexp(ncol(colorectal), rate = 1 / 12)
> events <- rbinom(ncol(colorectal), size = 1, prob = .5)
> surv.obj <- Surv(time,
> surv.obj

events)

[1] 12.2199316
[7] 15.6816415

6.3156911+
9.7474033+

[13]
[19]
[25] 40.4286251
[31] 21.7688233+
[37] 18.1524944

1.1121817+
2.6179273+
0.7419027+
3.2039892
34.1561441+
1.9552873
6.9582636+ 15.1728922

7.9278746
3.4434999
5.2937028
1.0786129+ 6.5201416
0.4815179
4.2275987
4.6321393+ 20.6876758 20.7533469
6.0385021+ 24.7136261+ 0.7014309 10.5549369
3.4465836+ 16.0491185+ 7.5285492+ 13.6299255+
4.4667747+ 3.5197164 15.6154851+
2.6460898+

6.0208982+
3.6797693+

13.1505327+

> stat.coxph <-
+
+
> stat.coxph[1:10 ,]

aCGH.test(colorectal, surv.obj, test = "coxph",

p.adjust.method = "fdr")

index

rawp

teststat

adjp
612 -3.208296 0.001335242 0.9966793
610 -3.027101 0.002469114 0.9966793
611 -2.937012 0.003313909 0.9966793
157 -2.734887 0.006240179 0.9966793
613 -2.704373 0.006843334 0.9966793
1284 -2.496399 0.012546131 0.9966793
600 -2.492854 0.012672086 0.9966793
594 -2.477353 0.013236092 0.9966793
1377 -2.459637 0.013907758 0.9966793
615 -2.392452 0.016736216 0.9966793

612
610
611
157
613
1284
600
594
1377
615

19

> plotFreqStat(colorectal, stat.coxph, events, titles =
+

c("Survived/Censored", "Dead"), X = FALSE, Y = FALSE)

Figure 9: Frequency plots of the samples with respect to survival.

Deriving statistics and p-values for testing the linear association of age with the log2 ratios
of each clone along the tumors. Here we repeat above two examples but using significance
of linear regression coeffecient as a mesuare of association between genomic variable and
continious outcome.

> age <- phenotype(colorectal)$age
> age.na <- which(!is.na(age))
> age <- age[age.na]
> colorectal.na <- colorectal[, age.na]
> stat.age <-
+
+
> stat.age[1:10 ,]

p.adjust.method = "fdr")

aCGH.test(colorectal.na, age, test = "linear.regression",

index

teststat

rawp

adjp

20

−1.00.00.8Survived/Censoredchromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21−1.00.00.8Deadchromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 210.01.53.0Survived/Censored vs Deadchromosome numberclone statistic 1 3 5 7 9 11 13 15 17 19 21 2 4 6 8 10 12 14 16 18 20 221735
1739
685
1251
1718
1714
642
639
643
1744

1735 3.259187 0.002399741 0.9952687
1739 3.184326 0.002941084 0.9952687
685 -3.158061 0.003157117 0.9952687
1251 3.144471 0.003274723 0.9952687
1718 3.118281 0.003513183 0.9952687
1714 3.112281 0.003570080 0.9952687
642 -3.082287 0.003867826 0.9952687
639 -3.012157 0.004658116 0.9952687
643 -2.937882 0.005659632 0.9952687
1744 2.881404 0.006552898 0.9952687

> plotFreqStat(colorectal.na, stat.age, ifelse(age < 70, 0, 1), titles =
+

c("Young", "Old"), X = FALSE, Y = FALSE)

Figure 10: Frequency plots of the samples with respect to age.

Here we show example of how to create a table of results which can be later exported into
other programs via write.table. First, Males vs Females:

> sex <- phenotype(colorectal)$sex

21

−1.00.00.8Youngchromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 21−1.00.00.8Oldchromosome numberFraction gained or lost 2 4 6 8 10 12 14 16 18 20 22 1 3 5 7 9 11 13 15 17 19 210.01.53.0Young vs Oldchromosome numberclone statistic 1 3 5 7 9 11 13 15 17 19 21 2 4 6 8 10 12 14 16 18 20 22> sex.na <- !is.na(sex)
> index.clones.use <- which(clones.info(colorectal.na)$Chrom < 23)
> colorectal.na <- colorectal[ index.clones.use,sex.na , keep=TRUE]
> dat <- log2.ratios.imputed(colorectal.na)
> resT.sex <- mt.maxT(dat, sex[sex.na], test = "t.equalvar", B = 1000)

b=10
b=110
b=210
b=310
b=410
b=510
b=610
b=710
b=810
b=910

b=20

b=30

b=40

b=50

b=60

b=70

b=80

b=90

b=100

b=120
b=220
b=320
b=420
b=520
b=620
b=720
b=820
b=920

b=130
b=230
b=330
b=430
b=530
b=630
b=730
b=830
b=930

b=140
b=240
b=340
b=440
b=540
b=640
b=740
b=840
b=940

b=150
b=250
b=350
b=450
b=550
b=650
b=750
b=850
b=950

b=160
b=260
b=360
b=460
b=560
b=660
b=760
b=860
b=960

b=170
b=270
b=370
b=470
b=570
b=670
b=770
b=870
b=970

b=180
b=280
b=380
b=480
b=580
b=680
b=780
b=880
b=980

b=190

b=290

b=390

b=490

b=590

b=690

b=790

b=890

b=990

b=200

b=300

b=400

b=500

b=600

b=700

b=800

b=900

b=1000

> sex.tbl <- summarize.clones(colorectal.na, resT.sex, sex[sex.na], titles = c("Male", "Female"))
> sex.tbl[1:5,]

Target Chrom

Clone
2 RP11-82D16
HumArray2H11_C9
3 RP11-62M23 HumArray2H10_N30
4 RP11-111O5 HumArray2H10_B18
5
RP11-51B4 HumArray2H10_Q30
6 RP11-60J11 HumArray2H10_T30

kb NumPresent.All NumGain.All NumLost.All
7
7
9
10
7

1 2009
1 3368
1 4262
1 6069
1 6817
PropPresent.All PropGain.All PropLost.All NumPresent.Male NumGain.Male
1
1
0
0
0

0.18
0.21
0.24
0.29
0.20

0.97
0.87
0.95
0.87
0.90

0.11
0.03
0.03
0.00
0.03

38
34
37
34
35

23
20
23
19
20

4
1
1
0
1

NumLost.Male PropPresent.Male PropGain.Male PropLost.Male NumPresent.Female
15
14
14
15
15

0.04
0.05
0.00
0.00
0.00

0.22
0.25
0.30
0.37
0.20

1.00
0.87
1.00
0.83
0.87

5
5
7
7
4

NumGain.Female NumLost.Female PropPresent.Female PropGain.Female
0.20
0.00
0.07
0.00
0.07

0.94
0.88
0.88
0.94
0.94

3
0
1
0
1

2
2
2
3
3

PropLost.Female

stat

0.13 1.3456684 0.185
0.14 1.2966513 0.214

rawp adjp
1
1

22

2
3
4
5
6

2
3
4
5
6

2
3
4
5
6

2
3

4
5
6

0.14 0.7545065 0.445
0.20 1.9207531 0.066
0.20 0.5052960 0.640

1
1
1

23

3.12 Clustering samples

Here we cluster samples while displaying phenotypes as well as within phenotypes using chro-
mosomes 4, 8 and 9 and display the phenotype labels, in this case, sex. We also indicate high
level amplifications and 2-copy deletions with yellow and blue colors. (fig. 11).

24

4 Acknowledgements

The authors would like to express their gratitude to Drs. Fred Waldman and Kshama Mehta
for sharing the data and to Dr. Taku Tokuyasu for quantifying the images. This work would
not be possible without generous support and advice of Drs. Donna Albertson, Dan Pinkel
and Ajay Jain. Antoine Snijders has played an integral role in developing ideas leading to the
algorithms implemented in this package.Many thanks to Ritu Roydasgupta for assistance in
debugging.

References

A. N. Jain, T. A. Tokuyasu, A. M. Snijders, R. Segraves, D. G. Albertson, and D. Pinkel.
Fully automatic quantification of microarray image data. Genome Research, 12:325–332,
2002.

K. Nakao, K. E. Mehta, J. Fridlyand, D. H. Moore, A. N. Jain, A. Lafuente, J. W. Wiencke,
J. P. Terdiman, and F. M. Waldman. High-resolution analysis of dna copy number alter-
ations in colorectal cancer by array-based comparative genomic hybridization. Carcinogen-
esis, 2004. Epub in March.

A. M. Snijders, N. Nowak, R. Segraves, S. Blackwood, N. Brown, J. Conroy, G. Hamilton,
A. K. Hindle, B. Huey, K. Kimura, S. Law, K. Myambo, J. Palmer, B. Ylstra, J. P. Yue,
J. W. Gray, A. N. Jain, D. Pinkel, and D. G. Albertson. Assembly of microarrays for
genome-wide measurement of dna copy number. Nature Genetics, 29, November 2001.

25

titles = c("Female", "Male"),
byclass = FALSE, showaber = TRUE, vecchrom = c(4,8,9),
dendPlot = FALSE, imp = FALSE)

> par(mfrow=c(2,1))
> clusterGenome(colorectal.na, response = sex[sex.na],
+
+
+
> clusterGenome(colorectal.na, response = sex[sex.na],
+
+
+
>

titles = c("Female", "Male"),
byclass = TRUE, showaber = TRUE, vecchrom = c(4,8,9),
dendPlot = FALSE, imp = FALSE)

Figure 11: Clustering of the samples by sex

26

1sprocCR232.txt 1sprocCR204.txt 1sprocCR212.txt 1sprocCR246.txt 1sprocCR219.txt 0sprocCR122.txt 1sprocCR124.txt 1sprocCR137.txt 0sprocCR59.txt 0sprocCR148.txt 0sprocCR100.txt 1sprocCR178.txt 0sprocCR186.txt 0sprocCR77.txt 0sprocCR112.txt 0sprocCR227.txt 0sprocCR40.txt 0sprocCR193.txt 1sprocCR98.txt 1sprocCR43.txt 1sprocCR106.txt 0sprocCR75.txt 0sprocCR154.txt 0sprocCR159.txt 1sprocCR200.txt 0sprocCR31.txt 0sprocCR169.txt 1sprocCR63.txt 0sprocCR248.txt 0sprocCR73.txt 1sprocCR135.txt 0sprocCR131.txt 0sprocCR96.txt 0sprocCR244.txt 0sprocCR150.txt 1sprocCR146.txt 0sprocCR163.txt 1sprocCR210.txt 0sprocCR217.txt FemaleMaleclonesample 8 4 90sprocCR77.txt 0sprocCR169.txt 0sprocCR112.txt 0sprocCR163.txt 0sprocCR154.txt 0sprocCR159.txt 0sprocCR186.txt 0sprocCR122.txt 0sprocCR40.txt 0sprocCR59.txt 0sprocCR148.txt 0sprocCR217.txt 0sprocCR100.txt 0sprocCR150.txt 0sprocCR73.txt 0sprocCR131.txt 0sprocCR96.txt 0sprocCR193.txt 0sprocCR227.txt 0sprocCR31.txt 0sprocCR75.txt 0sprocCR244.txt 0sprocCR248.txt 1sprocCR43.txt 1sprocCR146.txt 1sprocCR200.txt 1sprocCR212.txt 1sprocCR137.txt 1sprocCR178.txt 1sprocCR232.txt 1sprocCR135.txt 1sprocCR219.txt 1sprocCR63.txt 1sprocCR246.txt 1sprocCR204.txt 1sprocCR106.txt 1sprocCR98.txt 1sprocCR124.txt 1sprocCR210.txt FemaleMaleclonesample 8 4 9