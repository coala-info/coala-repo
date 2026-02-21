Applying Metab

Raphael Aggio

October 30, 2017

Introduction

This document describes how to use the function included in the R package Metab.

1 Requirements

Metab requires 3 packages: xcms, svDialogs and pander. You can install these packages
straight from www.bioconductor.org.

2 Why should I use Metab?

Metab is an R package for processing metabolomics data previously analysed by the
Automated Mass Spectral Deconvolution and Identiﬁcation System (AMDIS). AMDIS
can be found at: http://chemdata.nist.gov/mass-spc/amdis/downloads/. AMDIS is one
of the most used software for deconvoluting and identifying metabolites analysed by
Gas Chromatography - Mass Spectrometry (GC-MS). It is excellent in deconvoluting
chromatograms and identifying metabolites based on a spectral library, which is a list
of metabolites with their respective mass spectrum and their associated retention times.
Although AMDIS is widely and successfully applied to chemistry and many other ﬁelds,
it shows some limitations when applied to biological studies. First, it generates results
in a single spreadsheet per sample, which means that one must manually merge the
results provided by AMDIS in a unique spreadsheet for performing further comparisons
and statistical analysis, for example, comparing the abundances of metabolites across
experimental conditions. AMDIS also allows users to generate a single report containing
the results for a batch of samples. However, this report contains the results of samples
placed on top of each other, which also requires extensive manual process before statisti-
cal analysis. In addition, AMDIS shows some limitations when quantifying metabolites.
It quantiﬁes metabolites by calculating the area (Area) under their respective peaks or
by calculating the abundance of the ion mass fragment (Base.Peak) used as model to
deconvolute the peak associated with each speciﬁc metabolite. As the area of a peak may

1

be inﬂuenced by coelution of diﬀerent metabolites, the abundance of the most abundant
ion mass fragment is commonly used for quantifying metabolites in biological samples.
However, AMDIS may use diﬀerent ion mass fragments for quantifying the same metabo-
lite across samples, which indicates that using AMDIS results one is not comparing the
same variable across experimental conditions. Finally, according to the conﬁgurations
used when applying AMDIS, it may report more than one metabolite identiﬁed for the
same retention time. Therefore, AMDIS data requires manual inspection to deﬁne the
correct metabolite to be assigned to each retention time.

Metab solves AMDIS limitations by selecting the most probable metabolite associ-
ated to each retention time, by correcting the Base.Peak values calculated by AMDIS
and by combining results in a single spreadsheet and in a format that suits further data
processing. In order to select the most probable metabolite associated to each retention
time, Metab considers the number of question marks reported by AMDIS, which indi-
cates its certainty in identiﬁcation, and the diﬀerence between expected and observed
retention times associated with each metabolite. For correcting abundances calculated
by AMDIS, Metab makes use of an ion library containing the ion mass fragment to be
used as reference when quantifying each metabolite present in the mass spectral library
applied. For this, Metab collects from the AMDIS report the scan used to identify each
metabolite and collects from the raw data (CDF ﬁles) the intensities of their reference ion
mass fragments deﬁned in the ion library. In addition, Metab contains functions to sim-
ply reformat AMDIS reports into a single spreadsheet containing identiﬁed metabolites
and their Areas or Base.Peaks calculated by AMDIS in each analysed sample. There-
fore, Metab can be used to quickly process AMDIS reports correcting or not metabolite
abundances previously calculated by AMDIS. Below we demonstrate how to use each
function in Metab.

2

3 How to process AMDIS results using MetReport

MetReport automatically process ADMIS results keeping only one compound for each
retention time. In addition, MetReport can be used to recalculate peak intensities by
assigning a ﬁxed mass fragment for each compound across samples, or to return the Area
or Base.Peaks previously calculated by AMDIS. MetReport may be applied to a single
GC-MS ﬁle or a batch of GC-MS ﬁles.

When applied to a single ﬁle and recalculating metabolite abundances, MetReport

requires:

1. the GC-MS sample ﬁle in CDF format. The software used by most GC-MSs
include an application to convert GC-MS ﬁles to CDF format (also known as
AIA format). If not available in the GC-MS software used, there are commercial
software available at the market.

2. Amdis report in batch mode. It is a text ﬁle containing the results for a batch of
samples and can be obtained in AMDIS through: File > Batch Job > Create
and Run Job.... Select the Analysis Type to be used, generally Simple, click on
Generate Report and Report all hits. Click on Add.., select the ﬁles to be
analysed, click on Save As..., select the folder where the report will be generated
and a name for this report (any name you desire). Finally, click on Run. A new
.TXT ﬁle with the name speciﬁed will be generated in the folder speciﬁed.

Below you can see examples of an AMDIS report:

> library(Metab)
> data(exampleAMDISReport)
> print(head(exampleAMDISReport, 25))

FileName
1 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
2 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
3 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
4 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
5 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
6 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
7 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
8 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
9 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
10 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
11 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
12 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
13 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
14 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
15 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
16 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_1.FIN
17 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
18 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN

3

19 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
20 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
21 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
22 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
23 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
24 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN
25 M:\\Metab\\StandardSolutions_FinalSmallLib\\uL50\\130513_REF_SOL2_2_50_50_2.FIN

Name

RT RI

CAS
??? Ethanol 6.6513 NA 18.7 scans
1 130513~1-N1002
??? Acetone 7.3732 NA 15.6 scans
2 130513~1-N1004
>6 scans
3 130513~1-N1006 Isopropyl alcohol 7.5762 NA
Acetonitril 7.9100 NA 11.3 scans
4 130513~1-N1008
Ethyl acetate 10.6013 NA 24.1 scans
5 130513~1-N1010
1-butanol 13.3941 NA 23.1 scans
6 130513~1-N1012
2-pentanone 13.9695 NA 17.6 scans
7 130513~1-N1014
Pyridine 16.4221 NA 15.2 scans
8 130513~1-N1016
?? Zylene1 20.3983 NA 17.3 scans
9 130513~1-N1018
Zylene3 20.3983 NA 17.3 scans
10 130513~1-N1022
Zylene2 20.3983 NA 17.3 scans
11 130513~1-N1020
??? Zylene2 20.6942 NA 15.1 scans
12 130513~1-N1020
Zylene3 20.6942 NA 15.1 scans
13 130513~1-N1022
Zylene1 20.6942 NA 15.1 scans
14 130513~1-N1018
Benzaldehyde 25.6968 NA 12.5 scans
15 130513~1-N1024
Indole 38.6367 NA 9.5 scans
16 130513~1-N1026
Ethanol 6.6479 NA 17.4 scans
17 130513~1-N1002
18 130513~1-N1004
?? Acetone 7.3709 NA 15.5 scans
19 130513~1-N1006 Isopropyl alcohol 7.5868 NA 15.2 scans
Acetonitril 7.9065 NA 11.0 scans
20 130513~1-N1008
Ethyl acetate 10.6024 NA 21.9 scans
21 130513~1-N1010
1-butanol 13.3812 NA 16.8 scans
22 130513~1-N1012
2-pentanone 13.9654 NA 17.6 scans
23 130513~1-N1014
Pyridine 16.4203 NA 14.7 scans
24 130513~1-N1016
Zylene1 20.3959 NA 15.3 scans
25 130513~1-N1018

Width Purity Model
85% 31 m/z
98% 58 m/z
37% 38 m/z
74% 39 m/z
97% 43 m/z
94% 31 m/z
93% 86 m/z
90% 51 m/z
89% 91 m/z
89% 91 m/z
89% 91 m/z
96% 92 m/z
96% 92 m/z
96% 92 m/z
95% 51 m/z
97% 63 m/z
86% 31 m/z
94% 42 m/z
46% 45 m/z
74% 41 m/z
99% 45 m/z
95% 41 m/z
92% 86 m/z
99% 79 m/z
88% 91 m/z

0.46%

Min..Abund. Amount Scan Peak.Tailing S.N..total. Base.Peak Max..Amount
3.2
2.8
0.0
2.2
3.2
2.7
2.1
4.8
2.1
2.1
2.1
2.3
2.3
2.3
0.9
1.4
3.7

0.02% 0.56% 112
0.00% 3.76% 236
0.01% 0.14% 270
0.00% 0.95% 328
0.00% 7.36% 789
0.01% 2.23% 1267
0.00% 5.08% 1366
0.00% 14.30% 1786
0.01% 0.74% 2468
0.01% 0.74% 2468
0.01% 0.74% 2468
0.00% 2.56% 2518
0.00% 2.56% 2518
0.00% 2.56% 2518
0.00% 6.24% 3376
0.00% 1.41% 5593
0.02% 0.59% 111

127 11607327
346 141000704
159 31689264
210 43608332
442 197190784
269 34300908
437 192980720
671 330948544
163 24909594
163 24909594
163 24909594
312 72615568
312 72615568
312 72615568
552 139180208
292 70967296
140 13701553

6.69%

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
11
12
13
14
15
16
17

4

18
19
20
21
22
23
24
25

0.00% 3.72% 235
0.00% 0.98% 272
0.00% 1.20% 327
0.00% 7.69% 789
0.00% 2.92% 1265
0.00% 6.46% 1365
0.00% 15.00% 1786
0.01% 0.70% 2467

3.4
3.0
2.7
3.0
3.6
3.3
4.2
2.1

377 177081840
196 50478668
235 57517692
482 247269568
324 50734364
459 223163936
738 410904384
168 26507924

658392192
4236371216

701423866
4725912300
174139435
1186617973
9249749212
2801759237
6387468112

1
2
3
4
5
6
7
8 18048017764 16633872102
932247262
883317974
9
883317974
932247262
10
883317974
932247262
11
3013541655
12 3222637797
3013541655
13 3222637797
3013541655
14 3222637797
7109285309
15 7845543202
1681827509
16 1780437467
17
778144626
825758659
4672767401
18 5232415261
19 1381316279
1244850204
1535513148
20 1690150477
21 10809291126 10093653761
3716517247
22 4106993156
23 9091606473
8424578101
24 21110512762 19030252325
916710545
25

Area Intgr.Signal Max..Area Extra.Width
01-Apr
01-May
1-0
01-Aug
02-Feb
02-Jan
2-0
01-Feb
02-Mar
02-Mar
02-Mar
02-Mar
02-Mar
02-Mar
03-Nov
03-Mar
01-Mar
02-Feb
02-Mar
02-Mar
02-Feb
02-Feb
02-Feb
01-May
03-Apr

NA
NA
164413150 571334359
NA
1091085434
NA
8620421245
2572895876
NA
6107379641 8400498601
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
NA
NA
NA
NA
NA
NA

988934674

4: 31 45 29 27
1
4: 58 39 38 57
2
5: 38 44 46 39 37
3
4: 39 38 25 12
4
5: 43 29 44 30 37
5
7: 31 43 45 44 53 51 13
6
7 13: 86 71 58 39 44 26 59 62 51 57 49 30 60
7: 51 38 48 64 36 25 83
8
2: 91 51
9
2: 91 51
10
11
2: 91 51
5: 92 79 53 38 27
12
5: 92 79 53 38 27
13
5: 92 79 53 38 27
14
10: 51 76 62 39 29 38 26 61 90 101
15
7: 63 39 87 78 56 77 55
16

Models Frac..Good Expec..RT RI.RI.lib.
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
NA
NA
NA
NA

0.988
1.000
0.997
0.999
1.000
0.999
1.000
1.000
0.998
0.998
0.998
0.999
0.999
0.999
1.000
0.999

6.64
7.37
7.58
7.91
10.59
13.38
13.96
16.43
20.40
21.80
20.70
20.70
21.80
20.40
25.71
38.63

5

17
18
19
20
21
22
23
24
25

2: 31 43
9: 42 27 15 44 26 29 25 55 30
3: 45 39 31
2: 41 13
7: 45 70 29 26 31 87 72
4: 41 39 27 33
7: 86 37 50 51 67 59 25
2: 79 80
5: 91 79 107 64 50

0.994
1.000
0.914
0.998
1.000
1.000
1.000
1.000
0.997

6.64
7.37
7.58
7.91
10.59
13.38
13.96
16.43
20.40

NA
NA
NA
NA
NA
NA
NA
NA
NA

Net Weighted Simple Reverse Corrections X.m.z. S.N..m.z. Area....m.z. Conc.
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
NA
NA

35.318
58.121
NA
48.929
49.857
23.488
50.029
36.287
46.246
46.246
46.246
36.853
36.853
36.853
22.606
41.027
33.838
60.317
NA
50.556
51.653
23.468
51.327
36.614
45.551

75.7
263.9
NA
146.7
312.1
130.1
308.7
404.3
110.9
110.9
110.9
189.4
189.4
189.4
262.2
187.2
81.5
293.0
NA
167.0
346.2
156.8
328.9
446.3
113.3

100
100
99
100
99
100
100
100
100
97
96
100
100
96
100
100
100
100
99
100
99
100
100
100
100

100
100
97
100
99
100
99
100
100
97
96
100
100
96
100
100
100
100
98
100
99
100
100
100
100

99
100
94
100
99
100
98
98
100
97
96
100
100
96
100
100
99
100
96
100
99
100
98
98
100

31
43
NA
41
43
56
43
79
91
91
91
91
91
91
106
117
31
43
NA
41
43
56
43
79
91

1 100
2 100
3
97
4 100
5 100
6 100
7 100
8 100
9 100
10 98
11 97
12 100
13 100
14 97
15 100
16 100
17 100
18 100
19 98
20 100
21 100
22 100
23 100
24 100
25 100

RT.RT.lib.
0.007
0.000
-0.006
0.005
0.008
0.013
0.010
-0.004
0.003
-1.405
-0.299
-0.003
-1.109
0.299
-0.015

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
11
12
13
14
15

6

16
17
18
19
20
21
22
23
24
25

0.003
0.004
-0.002
0.005
0.002
0.009
0.000
0.006
-0.006
0.001

3. ion library in the speciﬁc format required by Metab. The ion library is a data
frame containing the name and the reference ion mass fragment to quantify each
metabolite present in the mass spectral library used by AMDIS when generating
the batch report. To facilitate the process, MetReport accepts the .msl ﬁle used
by AMDIS. An AMDIS library is stored in two ﬁles, a ﬁle with extension .CID and
a ﬁle with extension .msl. Metab requires only the .msl ﬁle.

Below you can see examples of an ion library converted from an AMDIS library:

> data(exampleMSLfile)
> print(head(exampleMSLfile, 29))

( 13
( 25
( 30
( 41

V1
NAME:Ethanol
1
CASNO:130513~1-N1002
2
RI:
3
RW:
4
RT:6.644
5
RSN:31
6
7
COMMENT: 6.6438 min 130513_REF_SOL2_2_100_1
8 SOURCE:C:\\Program Files (x86)\\NISTMS\\AMDIS32\\LIB\\ref_sol2.msl
9
10
11
12
13
14
NAME:Acetone
15
CASNO:130513~1-N1004
16
RI:
17
RW:
18
RT:7.373
19
RSN:43
20
21
COMMENT: 7.3726 min 130513_REF_SOL2_2_100_1
22 SOURCE:C:\\Program Files (x86)\\NISTMS\\AMDIS32\\LIB\\ref_sol2.msl
23
24
25
26

NUM PEAKS: 22
3)
54) ( 29 249)
6)
36) ( 45 777)
11)

4) ( 14
14) ( 26
60) ( 31 1000) ( 32
23) ( 42

13) ( 15
29) ( 19
71) ( 27 176) ( 28
12) ( 33
79) ( 43 198) ( 44

NUM PEAKS: 30
1)
28) ( 16
32) ( 28
7)
19)
5) ( 37

1) ( 13
1) ( 25
16) ( 30

8) ( 15
22) ( 27
2) ( 36

1) ( 14
5) ( 26
1) ( 31

( 46 343) ( 47

( 12
( 24
( 29

9) ( 24

2) ( 40

7

27
28
29

( 38
24) ( 39
( 43 1000) ( 44
3) ( 57
( 55

44) ( 40
26) ( 45

10) ( 41
3) ( 52
7) ( 58 262) ( 59

23) ( 42
1) ( 53
10) ( 60

76)
4)
1)

> testLib <- buildLib(exampleMSLfile, save = FALSE, verbose = FALSE)

------------------------
Names
--------- ------- ------
20.39
Zylene1

*91*

Ion

RT

20.7
Zylene2
------------------------

*91*

> print(testLib)

Name

Ethanol 6.644
1
2
Acetone 7.373
3 Isopropyl alcohol 7.582
4
Acetonitril 7.905
Ethyl acetate 10.593
5
1-butanol 13.381
6
2-pentanone 13.959
7
Pyridine 16.426
8
Zylene1 20.395
9
Zylene2 20.697
10
Zylene3 21.803
11
Benzaldehyde 25.712
12
Indole 38.634
13

RT ref_ion1 ref_ion2 ref_ion3 ref_ion4 ion2to1 ion3to1
0.343
0.076
0.090
0.223
0.116
0.543
0.127
0.275
0.080
0.223
0.189
0.935
0.313

0.777
0.262
0.107
0.546
0.137
0.720
0.249
0.564
0.327
0.533
0.488
0.990
0.414

31
43
45
41
43
56
43
79
91
91
91
106
117

46
42
27
39
70
43
41
51
77
105
105
77
89

45
58
41
40
45
41
86
52
106
106
106
105
90

29
39
39
38
61
31
71
50
51
77
77
51
63

ion4to1
0.249
0.044
0.072
0.137
0.105
0.346
0.109
0.205
0.077
0.115
0.109
0.404
0.103

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
11
12
13

When all the requirements described above are ready and available, MetReport can
be applied. If an essential argument is missing, a dialog box will pop up allowing the
user to point and click on the missing ﬁle. Here is an example of MetReport applied to
a single ﬁle and recalculating metabolite abundances. We use a test ﬁle distributed with

8

the package, unzip it and store the ﬁle name in the testfile variable. This ﬁle will also
be used in the subsequent examples.

> ###### Load exampleAMDISReport ######
> data(exampleAMDISReport)
> ###### Load exampleIonLib ###########
> data(exampleIonLib)
> ###### Analyse a single file ########
> testfile <- unzip(system.file("extdata/130513_REF_SOL2_2_50_50_1.CDF.zip", package = "Metab"))
> test <- MetReport(inputData = testfile,
+
+
+
> ###### Show results #################
> print(test)

singleFile = TRUE, AmdisReport = exampleAMDISReport,
ionLib = exampleIonLib, abundance = "recalculate",
TimeWindow = 0.5, save = FALSE)

Replicates
1
1-butanol
2
2-pentanone
3
Acetone
4
Acetonitril
5
Benzaldehyde
6
Ethanol
7
Ethyl acetate
8
9
Indole
10 Isopropyl alcohol
Pyridine
11
Zylene1
12
Zylene2
13

Name 130513_REF_SOL2_2_50_50_1
A
34874681
195503137
140289057
44105593
143276433
11756469
201696289
70889473
38373933
369485217
73424897
25606145

Note that the ﬁrst line of the resulting data.frame is used to represent sample meta-

data (for example replicates).

The argument ”abundance” deﬁnes the way metabolite abundances will be reported.
If abundance = ”recalculated”, the abundances of metabolites will be corrected by ﬁxing
a single mass fragment as reference. If abundance = ”Area”, the area associated with each
compound will be extracted from the AMDIS report indicated by ”AmdisReport”. And
ﬁnally, if abundance = ”Base.Peak”, the Base.Peak associated with each compound will
be extracted from the AMDIS report. Below you can ﬁnd an example when extracting
the area:

> ###### Load exampleAMDISReport ######
> data(exampleAMDISReport)
> ###### Analyse a single file ########
> test <- MetReport(inputData = testfile,
+
+
> ###### Show results #################
> print(test)

singleFile = TRUE, AmdisReport = exampleAMDISReport,
abundance = "Area", TimeWindow = 0.5, save = FALSE)

9

Replicates
1
1-butanol
2
2-pentanone
3
Acetone
4
Acetonitril
5
Benzaldehyde
6
Ethanol
7
Ethyl acetate
8
9
Indole
10 Isopropyl alcohol
Pyridine
11
Zylene1
12
Zylene2
13

Name 130513_REF_SOL2_2_50_50_1
A
2801759237
6387468112
4725912300
1186617973
7845543202
701423866
9249749212
1780437467
174139435
18048017764
3222637797
932247262

Note that in this case the ion library is not required, as the abundances of metabolites

will be extracted directly from the AMDIS report.

When applied to a batch of GC-MS ﬁles, MetReport can be used to automatically
detect the name of experimental conditions under study. For this, GC-MS ﬁles in CDF
format must be organised in subfolders according to their experimental condition, as
follows:

————————

Experiment1
——Condition1
———–Sample1.cdf
———–Sample2.cdf
———–Sample3.cdf
——Condition2
———–Sample1.cdf
———–Sample2.cdf
———–Sample3.cdf
——Condition3
———–Sample1.cdf
———–Sample2.cdf
———–Sample3.cdf
————————–

The folder Experiment1 is the main folder containing one subfolder for each exper-
imental condition. Each subfolder contains the CDF ﬁles associated with this speciﬁc
experimental condition. Alternatively, all the CDF ﬁles can be placed in a single folder
and MetReport will analyse every sample as belonging to the same experimental condi-
tion.

Below you can see an example of MetReport applied to a batch of samples:

> MetReport(
+
+

dataFolder = "/Users/ThePathToTheMainFolder/",
AmdisReport = "/Users/MyAMDISreport.TXT",

10

+
+
+
+
+

ionLib = "/Users/MyIonLibrary.csv",
save = TRUE,
output = "metabData",
TimeWindow = 2.5,
Remove = c("Ethanol", "Pyridine"))

As a result, MetReport generates a data frame containing the metabolites identiﬁed
in the ﬁrst column and their abundances in the diﬀerent samples analysed in the following
columns. See below an example:

> data(exampleMetReport)
> print(exampleMetReport)

Replicates
1
1-butanol
2
2-pentanone
3
Acetone
4
Acetonitril
5
Benzaldehyde
6
Ethanol
7
Ethyl acetate
8
9
Indole
10 Isopropyl alcohol
Pyridine
11
Zylene1
12
Zylene2
13
Zylene3
14

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
100ul
100ul
176668672
169279488
412483584
358105088
285147136
247545856
96366592
89587712
580452352
534659072
24012800
23259136
422952960
342671360
163397632
157777920
77467648
82120704
861339648
731381760
53530624
29983744
138510336
86278144
<NA>
<NA>

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
11
12
13
14

1
2
3
4
5
6
7

130513_REF_SOL2_2_100_3 130513_REF_SOL2_2_100_4 130513_REF_SOL2_2_100_5
100ul
208617472
456081408
308297728
107765760
649789440
26106880
494567424
186777600
95952896
889716736
55349248
146456576
49307648

100ul
192888832
363429888
307740672
108470272
654049280
25887744
501448704
167837696
93126656
916586496
57958400
152977408
<NA>

100ul
181108736
388415488
271532032
92360704
589234176
22847488
427343872
163446784
80994304
843120640
41664512
118910976
20529152

130513_REF_SOL2_2_50_50_1 130513_REF_SOL2_2_50_50_2
50ul
51818496
231931904
183975936
60628992
160907264
13939712

50ul
34881536
195510272
140296192
44122112
143278080
11761664

11

8
9
10
11
12
13
14

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
11
12
13
14

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
11
12
13
14

201703424
70889472
38379520
369508352
73424896
25606144
<NA>

242745344
80273408
53235712
415711232
27378688
79704064
<NA>
130513_REF_SOL2_2_50_50_3 130513_REF_SOL2_2_50_50_4
50ul
66592768
227393536
194805760
65810432
162250752
15524864
252280832
84062208
65531904
438960128
20614144
57167872
<NA>

50ul
76873728
291504128
211861504
65150976
207470592
15432704
316309504
86499328
61800448
457539584
35684352
100077568
<NA>
130513_REF_SOL2_2_50_50_5
50ul
69951488
258048000
207060992
64122880
165134336
14892032
272318464
83632128
60612608
427327488
25833472
76689408
45645824

12

4 What if I have the AMDIS report but not the

CDF ﬁles?

The function MetReportNames is used to process an AMDIS report by choosing a single
compound per RT and extracting the AREA or the BASE.PEAK reported by AMDIS
for each compound. MetReportNames only requires the names of the ﬁles or samples
to be extracted from the AMDIS report and the AMDIS report in batch mode. It is
applied as follows:

> ### Load the example of AMDIS report #####
> data(exampleAMDISReport)
> ### Extract the Area of compounds in samples
> # 130513_REF_SOL2_2_100_1 and 130513_REF_SOL2_2_100_2 ##
> test <- MetReportNames(
+
+
+
+
+
> print(test)

c("130513_REF_SOL2_2_100_1", "130513_REF_SOL2_2_100_2"),
exampleAMDISReport,
save = FALSE,
TimeWindow = 0.5,
base.peak = FALSE)

1-butanol
1
2-pentanone
2
Acetone
3
Acetonitril
4
Benzaldehyde
5
Ethanol
6
Ethyl acetate
7
8
Indole
9 Isopropyl alcohol
Pyridine
10
Zylene1
11
Zylene2
12

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
13106120736
14219281161
7664120070
2619137294
27158354783
1310635238
18031280625
3048110943
509048091
54766105482
1873141055
4098512121

12764249729
11073801529
7450198663
2415421513
24017979717
1298487467
14504720058
4150927824
1863002758
13248571706
977285068
3484655661

13

5 Normalisations and further analysis: removeFalse-

Positives, normalizeByInternalStandard, normalize-
ByBiomass, Htest

Normalisations and statistical analysis are commonly applied to metabolomics data.
Therefore, Metab contains few functions to facilitate these processes. Every function
described in this section uses an input data in the same format as the results generated
by the previously described functions.
In the ﬁrst row, it contains the names of the
experimental conditions associated with each sample. Removing metabolites considered

false positives: In some metabolomics experiments it is ideal to consider only those

metabolites detected in a minimum proportion of the samples analysed for a speciﬁc
experimental condition. For example, if an experimental condition contains 6 sample,
or replicates, one may consider that metabolites present in only 2 samples are poten-
tial miss identiﬁcations or contaminations. Thus, they must be removed before further
analysis. The function removeFalsePositives uses a data set generated by MetReport,
MetReportArea or MetReportBasePeak to automatically remove these compounds. re-
moveFalsePositives only requires the data frame to be processed, which can be a
vector in R or a CSV ﬁle, and the percentage of samples to be used as cut oﬀ. For
example:

> ### Load the inputData ###
> data(exampleMetReport)
> ### Normalize ####
> normalizedData <- removeFalsePositives(exampleMetReport, truePercentage = 40, save = FALSE)
> ##################
> # The abundances of compound Zylene3 will be replaced by NA in samples from experimental
> #condition 50ul, as it is present in less than 40 per cent of the samples from this
> #experimental condition.
> ### Show results ####
> print(normalizedData)

1
Replicates
2 Isopropyl alcohol
Pyridine
3
Zylene1
4
Zylene2
5
Zylene3
6
1-butanol
7
2-pentanone
8
Acetone
9
Acetonitril
10
Benzaldehyde
11
Ethanol
12
Ethyl acetate
13
Indole
14

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
100ul
100ul
77467648
82120704
861339648
731381760
53530624
29983744
138510336
86278144
<NA>
<NA>
176668672
169279488
412483584
358105088
285147136
247545856
96366592
89587712
580452352
534659072
24012800
23259136
422952960
342671360
163397632
157777920

14

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
11
12
13
14

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
11
12
13
14

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
11
12
13
14

1
2
3
4
5

130513_REF_SOL2_2_100_3 130513_REF_SOL2_2_100_4 130513_REF_SOL2_2_100_5
100ul
95952896
889716736
55349248
146456576
49307648
208617472
456081408
308297728
107765760
649789440
26106880
494567424
186777600

100ul
80994304
843120640
41664512
118910976
20529152
181108736
388415488
271532032
92360704
589234176
22847488
427343872
163446784

100ul
93126656
916586496
57958400
152977408
<NA>
192888832
363429888
307740672
108470272
654049280
25887744
501448704
167837696

50ul
38379520
369508352
73424896
25606144
<NA>
34881536
195510272
140296192
44122112
143278080
11761664
201703424
70889472

130513_REF_SOL2_2_50_50_1 130513_REF_SOL2_2_50_50_2
50ul
53235712
415711232
27378688
79704064
<NA>
51818496
231931904
183975936
60628992
160907264
13939712
242745344
80273408
130513_REF_SOL2_2_50_50_3 130513_REF_SOL2_2_50_50_4
50ul
65531904
438960128
20614144
57167872
<NA>
66592768
227393536
194805760
65810432
162250752
15524864
252280832
84062208

50ul
61800448
457539584
35684352
100077568
<NA>
76873728
291504128
211861504
65150976
207470592
15432704
316309504
86499328
130513_REF_SOL2_2_50_50_5
50ul
60612608
427327488
25833472
76689408

15

6
7
8
9
10
11
12
13
14

<NA>
69951488
258048000
207060992
64122880
165134336
14892032
272318464
83632128

Normalising by internal standard: The use of internal standards is a common practice

in metabolomics. In order to normalise a data set by a speciﬁc internal standard, the
abundance or intensity of each metabolite must be divided by the abundance of the
internal standard at the sample where each metabolite was detected. The function
normalizeByInternalStandard normalises a data set generated by Metab functions
according to an internal standard deﬁned by the user. For example:

> ### Load the inputData ###
> data(exampleMetReport)
> ### Normalize ####
> normalizedData <- normalizeByInternalStandard(
exampleMetReport,
+
internalStandard = "Acetone",
+
+
save = FALSE)
> ### Show results ####
> print(normalizedData)

Replicates
1
1-butanol
2
2-pentanone
3
Acetone
4
Acetonitril
5
Benzaldehyde
6
Ethanol
7
Ethyl acetate
8
9
Indole
10 Isopropyl alcohol
Pyridine
11
Zylene1
12
Zylene2
13
Zylene3
14

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
100ul
100ul
0.619570213743967
0.683830829307036
1.44656400827396
1.44662121914091
1
1
0.337953918639393
0.361903501224436
2.03562399448403
2.15983850685022
0.08421196276718
0.0939588986696671
1.48327970581476
1.38427427361175
0.573029188692255
0.63736845588722
0.271676051482418
0.331739360645973
2.95453041233702
3.02068490002298
0.187729832222478
0.121123998941029
0.485750402206389
0.348533986365742
<NA>
<NA>

130513_REF_SOL2_2_100_3 130513_REF_SOL2_2_100_4 130513_REF_SOL2_2_100_5
100ul
0.676675346760908
1.47935377584099
1
0.349550937981612
2.10766859754477
0.0846807408194718

100ul
0.666988475230797
1.43045918059494
1
0.340146624027032
2.17003560007241
0.0841428830024739

100ul
0.626790182611936
1.18096150774637
1
0.352472980886972
2.12532609274344
0.084121945376138

1
2
3
4
5
6
7

16

8
9
10
11
12
13
14

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
11
12
13
14

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
11
12
13
14

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
11
12
13

1.57382489591504
0.601942919205937
0.298286369396006
3.10505038315332
0.153442345984433
0.437926144934532
0.0756048995353889

1.62945216419102
0.545386785923441
0.302614065910664
2.97843794920939
0.188335196720439
0.497098440078795
<NA>

1.60418770260934
0.605835149067333
0.31123452197481
2.88590104692565
0.179531806345326
0.475049157676569
0.159935165010363

50ul
0.248627817353731
1.39355366110008
1
0.314492584374635
1.02125423332944
0.0838345206119351
1.4376970687843
0.505284362956908
0.27356066799019
2.63377321032348
0.523356300362023
0.182514889641481
<NA>

130513_REF_SOL2_2_50_50_1 130513_REF_SOL2_2_50_50_2
50ul
0.281659096981031
1.26066435123341
1
0.329548490515629
0.874610383827589
0.0757692136432452
1.31944073381423
0.436325585537448
0.289362365304123
2.25959568973194
0.148816680024935
0.433230919939443
<NA>
130513_REF_SOL2_2_50_50_3 130513_REF_SOL2_2_50_50_4
50ul
0.341841883936081
1.167283431455
1
0.33782590412111
0.832884777123633
0.079694070647603
1.29503784693019
0.431518082422204
0.336396131202691
2.25332211942809
0.105818965517241
0.293460891505467
<NA>

50ul
0.362848967597247
1.37591833578223
1
0.307516820044853
0.979274611398964
0.0728433609156291
1.49300131467017
0.408282422086459
0.29170211120563
2.1596164256438
0.168432449153198
0.472372592993581
<NA>
130513_REF_SOL2_2_50_50_5
50ul
0.33783035290394
1.24624149390726
1
0.309681120430448
0.797515429656591
0.0719209922456085
1.31516062668144
0.40390093369204
0.292728279791106
2.06377591391043
0.124762620667827
0.37037110302263

17

14

0.220446273144485

Normalising by biomass: Normalisation by biomass (e.g. number of cells or O.D.)

is also a common practice in metabolomics.
In order to normalise a data set by the
biomass associated with each sample, the abundance or intensity of each metabolite
must be divided by the biomass associated with the sample where each metabolite was
detected. The function normalizeByBiomass normalises a data set generated by Metab
functions according to a list of biomasses deﬁned by the user. For this, the user must
provide a data frame or a CSV ﬁle containing the name of each sample in the ﬁrst column
and their respective biomass in the second column. See below an example of the data
frame specifying biomasses:

> data(exampleBiomass)
> print(exampleBiomass)

130513_REF_SOL2_2_100_1
1
130513_REF_SOL2_2_100_2
2
130513_REF_SOL2_2_100_3
3
130513_REF_SOL2_2_100_4
4
5
130513_REF_SOL2_2_100_5
6 130513_REF_SOL2_2_50_50_1
7 130513_REF_SOL2_2_50_50_2
8 130513_REF_SOL2_2_50_50_3
9 130513_REF_SOL2_2_50_50_4
10 130513_REF_SOL2_2_50_50_5

Sample Biomass
0.5
0.5
0.5
0.5
0.5
0.5
0.5
0.5
0.5
0.5

For example:

> ### Load the inputData ###
> data(exampleMetReport)
> ### Load the list of biomasses ###
> data(exampleBiomass)
> ### Normalize ####
> normalizedData <- normalizeByBiomass(
+
+
+
> ### Show results ###
> print(normalizedData)

exampleMetReport,
biomass = exampleBiomass,
save = FALSE)

1
2
3
4
5
6

Replicates
1-butanol
2-pentanone
Acetone
Acetonitril
Benzaldehyde

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
100ul
100ul
353337344
338558976
824967168
716210176
570294272
495091712
192733184
179175424
1160904704
1069318144

18

Ethanol
7
Ethyl acetate
8
Indole
9
10 Isopropyl alcohol
Pyridine
11
Zylene1
12
Zylene2
13
Zylene3
14

46518272
685342720
315555840
164241408
1462763520
59967488
172556288
<NA>

48025600
845905920
326795264
154935296
1722679296
107061248
277020672
<NA>

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
11
12
13
14

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
11
12
13
14

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
11
12

130513_REF_SOL2_2_100_3 130513_REF_SOL2_2_100_4 130513_REF_SOL2_2_100_5
100ul
417234944
912162816
616595456
215531520
1299578880
52213760
989134848
373555200
191905792
1779433472
110698496
292913152
98615296

100ul
385777664
726859776
615481344
216940544
1308098560
51775488
1002897408
335675392
186253312
1833172992
115916800
305954816
<NA>

100ul
362217472
776830976
543064064
184721408
1178468352
45694976
854687744
326893568
161988608
1686241280
83329024
237821952
41058304

50ul
69763072
391020544
280592384
88244224
286556160
23523328
403406848
141778944
76759040
739016704
146849792
51212288
<NA>

130513_REF_SOL2_2_50_50_1 130513_REF_SOL2_2_50_50_2
50ul
103636992
463863808
367951872
121257984
321814528
27879424
485490688
160546816
106471424
831422464
54757376
159408128
<NA>
130513_REF_SOL2_2_50_50_3 130513_REF_SOL2_2_50_50_4
50ul
133185536
454787072
389611520
131620864
324501504
31049728
504561664
168124416
131063808
877920256
41228288

50ul
153747456
583008256
423723008
130301952
414941184
30865408
632619008
172998656
123600896
915079168
71368704

19

114335744
<NA>

13
14

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
11
12
13
14

200155136
<NA>
130513_REF_SOL2_2_50_50_5
50ul
139902976
516096000
414121984
128245760
330268672
29784064
544636928
167264256
121225216
854654976
51666944
153378816
91291648

Performing ANOVA or t-Test: The statistical tests ANOVA and t-Test are widely

applied in metabolomics studies. The function Htest can be used to quickly calculate
the p-values associated with each metabolite when performing ANOVA or t-Test. For
example:

data(exampleMetReport)

tTestResults <- htest(

> ### Load the inputData ###
>
> ### Perform t-test ####
>
+
+
+
+
+
)
> ### Show results ###
>

print(tTestResults)

exampleMetReport,
signif.level = 0.05,
StatTest = "T",
save = FALSE

Replicates
1
Pyridine
2
Zylene3
5
1-butanol
6
2-pentanone
7
Acetone
8
Acetonitril
9
10 Benzaldehyde
11
Ethanol
12 Ethyl acetate
Indole
13

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
100ul
100ul
861339648
731381760
<NA>
<NA>
176668672
169279488
412483584
358105088
285147136
247545856
96366592
89587712
580452352
534659072
24012800
23259136
422952960
342671360
163397632
157777920

130513_REF_SOL2_2_100_3 130513_REF_SOL2_2_100_4 130513_REF_SOL2_2_100_5
100ul

100ul

100ul

1

20

2
5
6
7
8
9
10
11
12
13

1
2
5
6
7
8
9
10
11
12
13

1
2
5
6
7
8
9
10
11
12
13

1
2
5
6
7
8
9
10
11
12
13

843120640
20529152
181108736
388415488
271532032
92360704
589234176
22847488
427343872
163446784

916586496
<NA>
192888832
363429888
307740672
108470272
654049280
25887744
501448704
167837696

889716736
49307648
208617472
456081408
308297728
107765760
649789440
26106880
494567424
186777600

50ul
369508352
<NA>
34881536
195510272
140296192
44122112
143278080
11761664
201703424
70889472

130513_REF_SOL2_2_50_50_1 130513_REF_SOL2_2_50_50_2
50ul
415711232
<NA>
51818496
231931904
183975936
60628992
160907264
13939712
242745344
80273408
130513_REF_SOL2_2_50_50_3 130513_REF_SOL2_2_50_50_4
50ul
438960128
<NA>
66592768
227393536
194805760
65810432
162250752
15524864
252280832
84062208

50ul
457539584
<NA>
76873728
291504128
211861504
65150976
207470592
15432704
316309504
86499328
130513_REF_SOL2_2_50_50_5
50ul

45645824
69951488

pvalues
bonferroni
427327488 1.47656740131692e-05
0
0.0105238574050483
258048000 0.00561227821822632
0.0292210552812355
207060992
0.0126346999945732
64122880
165134336 8.08163917729345e-06
14892032 0.00108300952415062
272318464 0.00959117744442205
83632128 4.33100560374815e-06

> ### Perform ANOVA ####
>
+
+

AnovaResults <- htest(

exampleMetReport,
signif.level = 0.05,

21

StatTest = "Anova",
save = FALSE

+
+
)
+
> ### Show results ###
>

print(AnovaResults)

Replicates
1
14 Isopropyl alcohol
Pyridine
2
Zylene3
5
1-butanol
6
2-pentanone
7
Acetone
8
Acetonitril
9
Benzaldehyde
10
Ethanol
11
Ethyl acetate
12
Indole
13

Name 130513_REF_SOL2_2_100_1 130513_REF_SOL2_2_100_2
100ul
100ul
77467648
82120704
861339648
731381760
<NA>
<NA>
176668672
169279488
412483584
358105088
285147136
247545856
96366592
89587712
580452352
534659072
24012800
23259136
422952960
342671360
163397632
157777920

1
14
2
5
6
7
8
9
10
11
12
13

1
14
2
5
6
7
8
9
10
11
12
13

1
14
2
5
6

130513_REF_SOL2_2_100_3 130513_REF_SOL2_2_100_4 130513_REF_SOL2_2_100_5
100ul
95952896
889716736
49307648
208617472
456081408
308297728
107765760
649789440
26106880
494567424
186777600

100ul
80994304
843120640
20529152
181108736
388415488
271532032
92360704
589234176
22847488
427343872
163446784

100ul
93126656
916586496
<NA>
192888832
363429888
307740672
108470272
654049280
25887744
501448704
167837696

50ul
38379520
369508352
<NA>
34881536
195510272
140296192
44122112
143278080
11761664
201703424
70889472

130513_REF_SOL2_2_50_50_1 130513_REF_SOL2_2_50_50_2
50ul
53235712
415711232
<NA>
51818496
231931904
183975936
60628992
160907264
13939712
242745344
80273408
130513_REF_SOL2_2_50_50_3 130513_REF_SOL2_2_50_50_4
50ul
65531904
438960128
<NA>
66592768

50ul
61800448
457539584
<NA>
76873728

22

7
8
9
10
11
12
13

1
14
2
5
6
7
8
9
10
11
12
13

291504128
211861504
65150976
207470592
15432704
316309504
86499328
130513_REF_SOL2_2_50_50_5
50ul
60612608

227393536
194805760
65810432
162250752
15524864
252280832
84062208

pvalues
bonferroni
0.0370846207340466
427327488 1.39730951692414e-05
0
45645824
69951488 0.000607777243341278
258048000 0.00317220837654868
0.0142506251529318
207060992
64122880 0.00434232050046251
165134336 1.21019617394432e-06
14892032 0.000199044492203383
0.0094521795358472
83632128 2.96896525929947e-06

272318464

23

Session information

> print(sessionInfo(), locale = FALSE)

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

attached base packages:
[1] parallel stats
[8] base

graphics grDevices utils

datasets methods

other attached packages:

[1] Metab_1.12.0
[4] xcms_3.0.0
[7] mzR_2.12.0

[10] Biobase_2.38.0

svDialogs_0.9-57
MSnbase_2.4.0
Rcpp_0.12.13
BiocGenerics_0.24.0

svGUI_0.9-55
ProtGenerics_1.10.0
BiocParallel_1.12.0

loaded via a namespace (and not attached):

[1] compiler_3.4.2
[4] plyr_1.8.4
[7] zlibbioc_1.24.0

BiocInstaller_1.28.0
iterators_1.0.8
MALDIquant_1.16.4

[10] preprocessCore_1.40.0 tibble_1.3.4
[13] lattice_0.20-35
[16] foreach_1.4.3
[19] stats4_3.4.2
[22] impute_1.52.0
[25] RANN_2.5.1
[28] ggplot2_2.2.1
[31] scales_0.5.0
[34] MassSpecWavelet_1.44.0 mzID_1.16.0
[37] affy_1.56.0
[40] doParallel_1.0.11

rlang_0.1.2
S4Vectors_0.16.0
multtest_2.34.0
survival_2.41-3
limma_3.34.0
MASS_7.3-47
pcaMethods_1.70.0

lazyeval_0.2.1
vsn_3.46.0

RColorBrewer_1.1-2
tools_3.4.2
digest_0.6.12
gtable_0.2.0
Matrix_1.2-11
IRanges_2.12.0
grid_3.4.2
XML_3.98-1.9
pander_0.6.1
splines_3.4.2
codetools_0.2-15
colorspace_1.3-2
munsell_0.4.3
affyio_1.48.0

24

