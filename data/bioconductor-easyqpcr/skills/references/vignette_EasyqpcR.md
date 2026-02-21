EasyqpcR: low-throughput real-time quantitative PCR data
analysis

Sylvain Le Pape
IRTOMIT-INSERM U1082 (Poitiers, France)

May 2, 2019

Contents

1 Introduction

2 Ampli(cid:28)cation e(cid:30)ciency calculation

3 Calculation of the expression values from one or multiple qPCR run(s)

4 Calculation of the calibration factors

5 Attenuation of inter-run variations

6 Aggregation of multiple independent biological replicates from the same

experiment

7 RStudio and gWidgets: tools to facilitate your qPCR data analysis

8 How to analyse qPCR data with EasyqpcR when samples and genes are

spread across runs ?

2

3

4

6

7

8

11

15

1

1

Introduction

The package "EasyqpcR" has been created to facilitate the analysis of real-time quantitative
RT-PCR data. This package contains (cid:28)ve functions (badCt, nrmData, calData, totData,
slope). In this manuscript, we describe and demonstrate how we can use this package. The
last section presents how we can use the free R GUI RStudio and the gWidgets package
created by John Verzani in order to facilitate the qPCR data analysis by a graphical user
interface.

2

2 Ampli(cid:28)cation e(cid:30)ciency calculation

In this section, we describe how we can use the slope function of this package. As an
example, we have 2 genes (gene 1 and gene 2) and 5 samples in triplicates (control group
1 and control group 2, treatment group 1 and treatment group 2, calibrator). We want to
calculate the ampli(cid:28)cation e(cid:30)ciency of these two genes:

library(EasyqpcR)

data(Efficiency_calculation)

slope(data=Efficiency_calculation, q=c(1000, 100 ,10, 1, 0.1),

r=3, na.rm=TRUE)

$Efficiency

E
Gene.1 1.989779
Gene.2 1.869559

You can put the returned values into a vector to use it (without the need to type every

ampli(cid:28)cation e(cid:30)ciency) in the next functions.

efficiency <- slope(data=Efficiency_calculation, q=c(1000, 100 ,10, 1, 0.1),

r=3, na.rm=TRUE)

3

3 Calculation of the expression values from one or multiple

qPCR run(s)

We describe the calculation of the normalization factors, the relative quantities, the normal-
ized relative quantities, and the normalized relative quantities scaled to the control group
of your choice using the method of Hellemans et al (2007) [2]. We have a set of three
qPCR runs, each run representing an independent biological replicate. The raw data of
these runs can be found in the data folder of this package. The no template control and
no ampli(cid:28)cation control have been discarded in order to facilitate the understanding of the
work(cid:29)ow. The limiting step is that you need to put the control samples on the top of the
data frame otherwise, the algorithm will not work correctly. Firstly, we load the datasets:

data(qPCR_run1,qPCR_run2,qPCR_run3)

str(c(qPCR_run1,qPCR_run2,qPCR_run3))

: num [1:15] 19.6 19.3 19.5 19.6 19.4 ...
: num [1:15] 18.5 18.4 18.5 18.6 18.7 ...
: num [1:15] 26.3 26.1 26.2 26.1 26.1 ...
: num [1:15] 16.3 16.5 16.7 16.8 17 ...

List of 15
$ Samples: Factor w/ 5 levels "Calibrator","Control 1",..: 2 2 2 3 3 3 4 4 4 5 ...
$ RG1
$ RG2
$ TG
$ TGb
$ Samples: Factor w/ 5 levels "Calibrator","Control 1",..: 2 2 2 3 3 3 4 4 4 5 ...
$ RG1
$ RG2
$ TG
$ TGb
$ Samples: Factor w/ 5 levels "Calibrator","Control 1",..: 2 2 2 3 3 3 4 4 4 5 ...
$ RG1
$ RG2
$ TG
$ TGb

: num [1:15] 20.7 20.7 20.5 20.8 21 ...
: num [1:15] 19.7 19.6 19.5 20.2 20.2 ...
: num [1:15] 27.5 27.3 27.3 27.5 27.7 ...
: num [1:15] 17.5 17.7 17.7 18.2 18.6 ...

: num [1:15] 20.7 20.7 20.5 20.5 20.6 ...
: num [1:15] 19.7 19.6 19.5 19.8 19.8 ...
: num [1:15] 27.5 27.3 27.3 27.2 27.3 ...
: num [1:15] 17.5 17.7 17.7 17.8 18.1 ...

Each dataset contains 15 observations: 5 samples (2 control groups, 2 treatment groups,
1 calibrator) in triplicates. There are 4 genes: 2 reference genes (RG1 and RG2) and 2 target
genes (TG and Tgb). In order to facilitate the understanding of the nrmData function, I
suggest you to read its man page by typing ?nrmData in your R session.

Concerning the reference genes, I suggest you to use the selectHKgenes function of the

SLqPCR package from Matthias Kohl [1].

In order to avoid the inter-run variations, we have used a calibrator (one is the minimum
recommended, more is better). Thus, we have to calculate the calibration factor for each

4

gene. We have to include the normalized relative quantities of our calibrator in an object:

## Isolate the calibrator NRQ values of the first biological replicate

aa <- nrmData(data=qPCR_run1 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=c(1, 1, 1, 1), CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)[[3]]

## Isolate the calibrator NRQ values of the first biological replicate

bb <- nrmData(data=qPCR_run2 , r=3, E=c(2, 2, 2, 2),
Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=c(1, 1, 1, 1), CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)[[3]]

## Isolate the calibrator NRQ values of the first biological replicate

cc <- nrmData(data=qPCR_run3 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=c(1, 1, 1, 1), CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)[[3]]

Now, we have to run the calData function.

5

4 Calculation of the calibration factors

Here, we describe how to use the calData function. In the continuation of what has been
done before, we have three objects containing the NRQ values of the calibrator(s) and we
now have to calculate the calibration factors for each gene:

## Calibration factor calculation

e <- calData(aa)

f <- calData(bb)

g <- calData(cc)

6

5 Attenuation of inter-run variations

Now, we have the calibration factors, we can calculate the expression value without the
obsession of the inter-run variability:

nrmData(data=qPCR_run1 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=e, CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)

nrmData(data=qPCR_run2 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=f, CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)

nrmData(data=qPCR_run3 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=g, CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)

Remark: The validity of IRCs must be interpreted with care: two or more IRCs must
be used to control if the IRCs measure the technical variation between the runs with the
same extent the calData value divided by each calibrator NRQ value must be sensitively
equal). If this ratio is really di(cid:27)erent, you must exclude the highly variable IRC in all the
qPCR runs.

7

6 Aggregation of multiple independent biological replicates

from the same experiment

In this section, we will discuss about the (cid:28)nal function of this package totData. In some
research (cid:28)elds, the reproducibility of an observation can be tough (notably in the stem cells
(cid:28)eld). An algorithm published by Willems et al. (2008) [3] attenuates the high variations
between independent biological replicates which have the same tendency in order to draw
relevant statistical conclusions. This algorithm has been inputed in this function for the
scientists experiencing this kind of issue.

## Isolate the NRQs scaled to control of the first biological replicate

a1 <- nrmData(data=qPCR_run1 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=e, CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)[1]

## Isolate the NRQs scaled to control of the second biological replicate

b1 <- nrmData(data=qPCR_run2 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=f, CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)[1]

## Isolate the NRQs scaled to control of the third biological replicate

c1 <- nrmData(data=qPCR_run3 , r=3, E=c(2, 2, 2, 2),

Eerror=c(0.02, 0.02, 0.02, 0.02), nSpl=5,
nbRef=2, Refposcol=1:2, nCTL=2,
CF=g, CalPos=5, trace=FALSE, geo=TRUE, na.rm=TRUE)[1]

## Data frame transformation

a2 <- as.data.frame(a1)
b2 <- as.data.frame(b1)
c2 <- as.data.frame(c1)

## Aggregation of the three biological replicates

d2 <- rbind(a2, b2, c2)

8

Finally, we use the (cid:28)nal function totData and indicate that we want to use the trans-
formation algorithm published by Willems et al. (2008) [3] followed by the linearization
process:

totData(data=d2, r=3, geo=TRUE, logarithm=TRUE, base=2,
transformation=TRUE, nSpl=5, linear=TRUE,
na.rm=TRUE)

$`Mean of your qPCR runs`

RG2

RG1

TG
Calibrator -0.08222222 0.08222222 -0.06722222
Control 1
-0.06888889 0.06888889 -0.06611111
Control 2
0.06888889 -0.06888889
Treatment 1 0.08222222 -0.08222222
Treatment 2 0.02611111 -0.02611111

TGb
0.1877778
0.1744444
0.06611111 -0.1744444
5.80500000 -0.6711111
0.2761111
8.67444444

$`Standard deviations of \n

your qPCR runs`
TG

RG2

RG1

TGb
Calibrator 0.03221017 0.03653234 0.01568145 0.03713230
0.01654347 0.01818031 0.01045649 0.01697575
Control 1
Control 2
0.01818031 0.01654347 0.01140229 0.01331382
Treatment 1 0.03187193 0.02837298 2.77616565 0.03137341
Treatment 2 0.04769007 0.04633732 9.20332760 0.03650180

$`Standard errors of your qPCR runs`

RG2

RG1

TGb
Calibrator 0.01859655 0.02109196 0.009053690 0.021438344
0.00955138 0.01049641 0.006037056 0.009800953
Control 1
0.01049641 0.00955138 0.006583116 0.007686735
Control 2
Treatment 1 0.01840127 0.01638115 1.602819985 0.018113445
Treatment 2 0.02753388 0.02675287 5.313543668 0.021074325

TG

$`Transformed data`

TG

RG1

RG2
TGb
0.9669039 1.0342289
Control 1
0.1284450 1.1445478
Control 2
1.0267686 0.9739293
0.1431787 0.9253757
7.5994178 0.6438416
Treatment 1 1.0878235 0.9192668
Treatment 2 1.0605244 0.9429298 55.4284806 1.2758374
0.1275577 1.1419064
Calibrator
0.1311439 1.1794474
Control 11
0.1402321 0.8979940
Control 21

0.9691405 1.0318421
0.9339676 1.0707009
1.0629775 0.9407537

9

Treatment 11 1.0243990 0.9761821
7.2061177 0.6161888
Treatment 21 0.9657876 1.0354244 56.6585675 1.2597270
0.1317513 1.2154112
Calibrator1 0.9063317 1.1033488
0.1290399 1.1605251
0.9491959 1.0535233
Control 12
0.1425186 0.9126358
Control 22
1.0459238 0.9560926
Treatment 12 1.0531988 0.9494884
7.9588256 0.6805522
Treatment 22 1.0196762 0.9807035 54.1624923 1.2042301
0.1290399 1.1605251
Calibrator2 0.9491959 1.0535233

$`Reordered transformed data`

TG

RG1

TGb
RG2
0.1275577 1.1419064
Calibrator
0.9691405 1.0318421
0.1317513 1.2154112
Calibrator1 0.9063317 1.1033488
0.1290399 1.1605251
Calibrator2 0.9491959 1.0535233
0.1284450 1.1445478
0.9669039 1.0342289
Control 1
0.1311439 1.1794474
0.9339676 1.0707009
Control 11
0.1290399 1.1605251
0.9491959 1.0535233
Control 12
0.1431787 0.9253757
1.0267686 0.9739293
Control 2
0.1402321 0.8979940
1.0629775 0.9407537
Control 21
0.1425186 0.9126358
Control 22
1.0459238 0.9560926
7.5994178 0.6438416
Treatment 1 1.0878235 0.9192668
7.2061177 0.6161888
Treatment 11 1.0243990 0.9761821
Treatment 12 1.0531988 0.9494884
7.9588256 0.6805522
Treatment 2 1.0605244 0.9429298 55.4284806 1.2758374
Treatment 21 0.9657876 1.0354244 56.6585675 1.2597270
Treatment 22 1.0196762 0.9807035 54.1624923 1.2042301

10

7 RStudio and gWidgets: tools to facilitate your qPCR data

analysis

To facilitate the use of R, a free software named RStudio has been created [4]. This interface
allows (among other things) easy data importation/exportation. In the same spirit of having
an interface for using R, John Verzani has published a package gWidgets which has the great
advantage to easily create a graphical user interface [5] for the function you want. In this
last section, we will present how we can use these tools to facilitate the qPCR data analysis.
To begin, we must choose our workspace directory by typing this in your R session:
’
) ). You will see the opening of a window and you will just
setwd(g(cid:28)le(type=
need to de(cid:28)ne your workspace directory. Then, we have to import some datasets in our R
session. RStudio allows an easy data importation (see 1).

’
selectdir

This can be done by following these steps:

1. uncompress the csv (cid:28)le (qPCR_run1.csv) in the data folder

2. move it to inst/extdata

Then, you just need to type this in your R session:

file <- system.file("extdata", "qPCR_run1.csv", package="EasyqpcR")

qPCR_run1 <- read.table(file, header=TRUE, sep="", dec=".")

qPCR_run1

TG

RG2

RG1

Samples

TGb
Control 1 19.62 18.54 26.32 16.32
1
Control 1 19.32 18.35 26.12 16.48
2
Control 1 19.48 18.49 26.24 16.68
3
Control 2 19.63 18.63 26.08 16.75
4
Control 2 19.40 18.72 26.12 16.98
5
Control 2 19.35 18.51 26.23 16.89
6
Treatment 1 19.21 18.45 20.32 17.12
7
Treatment 1 19.32 18.49 20.15 17.23
8
9
Treatment 1 19.09 18.66 20.26 17.33
10 Treatment 2 19.63 18.75 17.65 16.65
11 Treatment 2 19.46 18.69 17.75 16.54
12 Treatment 2 19.51 18.92 17.60 16.40
Calibrator 19.88 18.91 26.69 16.69
13
Calibrator 19.78 18.72 26.49 16.85
14
Calibrator 19.85 18.86 26.63 17.05
15

11

Figure 1: Data importation in RStudio

After data importation, you must control if your qPCR technical replicates satisfy your

12

threshold variation value (0.5 classically):

badCt(data=qPCR_run1, r=3, threshold=0.5, na.rm=TRUE)

$`Bad replicates localization`

row col

$`Mean of the Cq`

TG

RG2

RG1

TGb
Control 1
19.47333 18.46000 26.22667 16.49333
19.46000 18.62000 26.14333 16.87333
Control 2
Treatment 1 19.20667 18.53333 20.24333 17.22667
Treatment 2 19.53333 18.78667 17.66667 16.53000
Calibrator 19.83667 18.83000 26.60333 16.86333

$`Standard error of the Cq`

RG1

RG2

TGb
0.08666667 0.05686241 0.05811865 0.10413666
Control 1
Control 2
0.08621678 0.06082763 0.04484541 0.06691620
Treatment 1 0.06641620 0.06437736 0.04977728 0.06064468
Treatment 2 0.05044249 0.06887993 0.04409586 0.07234178
Calibrator 0.02962731 0.05686241 0.05925463 0.10413666

TG

Here, there is no bad replicates, but as an example, we will set the threshold value to

0.2 and see what it returns:

badCt(data=qPCR_run1, r=3, threshold=0.2, na.rm=TRUE)

$`Bad replicates localization`
row col
2
1
2
2
2
3
3
2
3
3
3
4
4
5
5
1
5
2
5
3
5
4

Control 1
Control 2
Treatment 1
Control 2
Treatment 1
Treatment 2
Calibrator
Control 1
Control 2
Treatment 1
Treatment 2

13

Calibrator

5

5

$`Mean of the Cq`

TG

RG2

RG1

TGb
19.47333 18.46000 26.22667 16.49333
Control 1
Control 2
19.46000 18.62000 26.14333 16.87333
Treatment 1 19.20667 18.53333 20.24333 17.22667
Treatment 2 19.53333 18.78667 17.66667 16.53000
Calibrator 19.83667 18.83000 26.60333 16.86333

$`Standard error of the Cq`

RG1

RG2

TGb
0.08666667 0.05686241 0.05811865 0.10413666
Control 1
0.08621678 0.06082763 0.04484541 0.06691620
Control 2
Treatment 1 0.06641620 0.06437736 0.04977728 0.06064468
Treatment 2 0.05044249 0.06887993 0.04409586 0.07234178
Calibrator 0.02962731 0.05686241 0.05925463 0.10413666

TG

There are some bad replicates (according to the example threshold value). Now, we
want to easily remove technical error (no more than one in qPCR technical triplicates), we
just need to use the gdfnotebook function of the gWidgets package by typing this in the
R session: gdfnotebook(cont=TRUE), and then choose which dataset you want to edit
(qPCR_run1, here). After saving it (on an other name in order to easily reproduce your
analysis with the same raw data, by example: qPCR_run1 is the raw dataset, and after
removing technical replicates you can save it under the name qPCR_run1_cor). Or, you
can edit your dataset directly in your spreadsheet and save it under an other name.

Finally, to easily analyze your qPCR data, you just will need to type this in your R
session for each function of the package: ggenericwidget(function,cont=TRUE), where
function has to be replaced by nrmData, calData, totData, or badCt. This can also be done
with the command lines described above.

14

8 How to analyse qPCR data with EasyqpcR when samples

and genes are spread across runs ?

All the previous examples showed how to perform qPCR data analysis when all the samples
were present for each gene in each run. Here we present the procedure to follow when we
have too much samples to be contained in each run, thus when samples and genes are spread
across di(cid:27)erent runs.

Here are some examples of plate designs:

Figure 2: Sample maximisation strategy

15

Figure 3: Gene maximisation strategy 1/3

16

Figure 4: Gene maximisation strategy 2/3

17

Figure 5: Gene maximisation strategy 3/3

As described in the work of Hellemans et al (2007) [2], the sample maximisation strategy
does not need inter-run calibration factor because there is no samples spread over runs (all
the samples for each gene are contained in one plate). Unless you have to many samples to
be contained in one run even with sample maximisation strategy, you will have to perform
the inter-run variation correction presented below.

In gene maximisation strategy the samples and genes are spread across runs. Thus, it
is necessary to calibrate the NRQs with a run-speci(cid:28)c and gene-speci(cid:28)c calibration factor.

We will now describe how to handle this issue. Follow these steps:

1. uncompress the csv (cid:28)le (Gene_maximisation.csv) in the data folder

2. move it to inst/extdata

Then, you just have to do this:

filebis <- system.file("extdata", "Gene_maximisation.csv", package="EasyqpcR")

Gene_maximisation <- read.table(filebis, header=TRUE, sep=";", dec=",")

First, you have to analyze if there are some bad replicates:

badCt(data=Gene_maximisation, r=3, threshold=0.5, na.rm=FALSE)[1]

$`Bad replicates localization`

Sample 15 15

row col
2

18

36
NTC 1
40
NTC 2
44
NTC 3
52
NTC 5
60
NTC 7
NTC 8
64
Sample 18 18
36
NTC 1
40
NTC 2
44
NTC 3
48
NTC 4
60
NTC 7
64
NTC 8
36
NTC 1
40
NTC 2
44
NTC 3
48
NTC 4
60
NTC 7
64
NTC 8

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
3
4
4
4
4
4
4

Do not worry about the NTC (no template control), they are not needed in qPCR data
analysis (but they have to present at least a Ct di(cid:27)erence > 5 Ct compared to the samples).
Here, you can use the gdfnotebook function of the gWidgets package.

After having removed the two aberrant values (RG2, Sample 15, Ct = 22.0691567571 ;
and RG3, Sample 18, Ct = 19.0232804823), rename the data frame as Gene_maximisation_cor.

Now, we remove the NTC values:

fileter <- system.file("extdata", "Gene_maximisation_cor.csv",

package="EasyqpcR")

Gene_maximisation_cor <- read.table(fileter, header=TRUE, sep=";", dec=",")

Gene_maximisation_cor1 <- Gene_maximisation_cor[-c(106:108, 118:120, 130:132,
142:144, 154:156, 166:168, 178:180, 190:192),]

rownames(Gene_maximisation_cor1) <- c(1:168)

Now, we will calculate run-speci(cid:28)c calibration factors:

19

calr1 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),
Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2,
nCTL=16, CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][1:3,]

calr2 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][4:6,]

calr3 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][7:9,]

calr4 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),
Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2,
nCTL=16, CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][10:12,]

calr5 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][13:15,]

calr6 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][16:18,]

calr7 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),
Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2,
nCTL=16, CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][19:21,]

calr8 <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=c(1, 1, 1), CalPos=c(33:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[3]][22:24,]

20

e <- calData(calr1)

f <- calData(calr2)

g <- calData(calr3)

h <- calData(calr4)

i <- calData(calr5)

j <- calData(calr6)

k <- calData(calr7)

l <- calData(calr8)

To respect the calculation of the NRQs which need the whole samples to take into
account the whole variability, we have to apply the nrmData function on the whole samples.
But we will do it for each run with the correction by the run-speci(cid:28)c calibration factor
and after each inter-run variation correction we isolate the corresponding CNRQs (i.e. the
NRQs corrected by the speci(cid:28)c CF), for example:

We perform inter-run variation correction on the whole samples by the CF of the (cid:28)rst
run, which corresponds to the samples 1 to 4 and IRC 1.1, 2.1, 3.1. But, the CF of the
(cid:28)rst is not the correct CF for the second run and for any other run. Thus, we isolate (after
inter-run variation correction on the whole samples by the CF of the (cid:28)rst run) the samples
concerned by this speci(cid:28)c CF which are the samples 1 to 4 and IRC 1.1, 2.1, 3.1. And we
do it for each run-speci(cid:28)c CF. Then we isolate the NRQs of the samples 5 to 8 and IRC
1.2, 2.2, 3.2 corrected by the CF of the second run, etc...

m <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=e, CalPos=c(33:35), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(1:4,33:35),]

n <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=f, CalPos=c(36:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(5:8,36:38),]

21

o <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=g, CalPos=c(36:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(9:12,39:41),]

p <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=h, CalPos=c(33:35), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(13:16,42:44),]

q <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=i, CalPos=c(36:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(17:20,45:47),]

r <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=j, CalPos=c(36:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(21:24,48:50),]

s <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=k, CalPos=c(33:35), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(25:28,51:53),]

t <- nrmData(data = Gene_maximisation_cor1, r=3, E=c(2, 2, 2),

Eerror=c(0.02, 0.02, 0.02), nSpl=56, nbRef=2, Refposcol=1:2, nCTL=16,
CF=l, CalPos=c(36:56), trace = FALSE, geo = TRUE,
na.rm = TRUE)[[2]][c(29:32,54:56),]

## Aggregation of all the CNRQs

u <- rbind(m, n, o, p, q, r, s, t)

Explanation of what we have done before: we have isolated the corresponding NRQs
corrected by the speci(cid:28)c CF (remember that after correction by the speci(cid:28)c CF , we talk
in terms of CNRQs and not anymore of NRQs):

(cid:136) Samples 1 to 4 and IRC 1.1, 2.1, 3.1 are corrected by e

22

(cid:136) Samples 5 to 8 and IRC 1.2, 2.2, 3.2 are corrected by f

(cid:136) Samples 9 to 12 and IRC 1.3, 2.3, 3.3 are corrected by g

(cid:136) Samples 13 to 16 and IRC 1.4, 2.4, 3.4 are corrected by h

(cid:136) Samples 17 to 20 and IRC 1.5, 2.5, 3.5 are corrected by i

(cid:136) Samples 21 to 24 and IRC 1.6, 2.6, 3.6 are corrected by j

(cid:136) Samples 25 to 28 and IRC 1.7, 2.7, 3.7 are corrected by k

(cid:136) Samples 29 to 32 and IRC 1.8, 2.8, 3.8 are corrected by l

Do not worry about the nCTL parameter, because in gene maximisation (or sample
maximisation if there are too many samples), the CTL samples are not present in all the
runs, so you will have to perform the scaling to control after.

Note that in this case where the control samples are not present in all the runs, the
nCTL parameter is not relevant and we only take into account the NRQs corrected by the
calibration factor (CNRQs). Thus, to have nicer graphs, you will need to perform a scaling
to your control group by doing a geometric mean of the CNRQs of your control samples
and divide all the CNRQs by this geometric mean. Here the control group is composed by
the samples 1 to 16, thus:

ctlgroup <- u[c(1:4,8:11,15:18,22:25),]

ctlgeom <- colProds(ctlgroup)^(1/dim(ctlgroup)[1])
ctlgeom1 <- (as.data.frame(ctlgeom)[rep(1:(ncol(u)), each = nrow(u)), ])
ctlgeom2 <- as.data.frame(matrix(ctlgeom1, ncol = ncol(u), byrow = FALSE))

CNRQs_scaled_to_group <- u/ctlgeom2

23

References

[1] Kohl, M. SLqPCR: Functions for analysis of real-time quantitative PCR data at SIRS-

Lab GmbH R package (2007) SIRS-Lab GmbH, Jena 4

[2] Jan Hellemans, Geert Mortier, Anne De Paepe, Frank Speleman and Jo Vandesom-
pele. (2007). qBase relative quanti(cid:28)cation framework and software for management and
automated analysis of real-time quantitative PCR data. Genome Biology 2007, 8:R19
(doi:10.1186/gb-2007-8-2-r19) http://genomebiology.com/2007/8/2/R19 4, 18

[3] Erik Willems Luc Leyns,

Jo Vandesompele.

PCR gene
alytical
(2008)
http://www.sciencedirect.com/science/article/pii/S0003269708002649 8, 9

from independent biological
127-129

expression data
379

Biochemistry

Standardization of

real-time
An-
replicates.
(doi:10.1016/j.ab.2008.04.036).

[4] RStudio:

Integrated development environment for R (Version 0.96.330) [Computer

software]. Boston, MA. Retrieved August 6, 2012. http://www.rstudio.org/ 11

[5] John Verzani. Based on the iwidgets code of Simon Urbanek and suggestions by Si-
mon Urbanek and Philippe Grosjean and Michael Lawrence. gWidgets: gWidgets API
for building toolkit-independent, interactive GUIs R package version 0.0-50 (2012)
http://CRAN.R-project.org/package=gWidgets 11

24

