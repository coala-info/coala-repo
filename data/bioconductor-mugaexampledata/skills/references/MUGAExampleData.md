MUGA Example Data

Daniel M. Gatti

11 October 2013

1

Introduction

The data in this package contains phenotype and genotype data from Diversity Outbred (DO) mice. The
Mouse Universal Genotyping Array (MUGA) that was developed by the University of North Carolina at
Chapel Hill [1]. The array contains 7,864 markers and was developed to genotype Collaborative Cross
and Diversity Outbred mice. It may also be used to genotype other multi-founder mouse crosses.

The data in this package is from Svenson et.al, Genetics, 2012 [2]. Briefly, 150 mice (75 F and 75
M) were placed on either a chow or high fat diet at wean. They were phenotyped at early and late time
points and sacrificed by 30 weeks of age. Tail tips were taken, DNA was extracted and the mice were
genotypes on the MUGA.

2 Data Description

There are 10 data files available in this package. Any of them may be accessed using data(<name>).

> library(MUGAExampleData)

FinalReport1 Raw genotype file for the samples in this study.

FinalReport2 Raw genotype file for the samples in this study.

Samples1 Sample IDs for the samples in FinalReport1.

Samples2 Sample IDs for the samples in FinalReport2.

call.rate.batch The allele call rates and batch IDs for each sample.

x The X allele intensities extracted from FinalReport1 and FinalReport2.

y The Y allele intensities extracted from FinalReport1 and FinalReport2.

geno The allele calls extracted from FinalReport1 and FinalReport2.

model.probs The DO founder haplotype probabilities for each sample at each marker.

pheno The phenotype data for this study.

1

2.1 FinalReport1 and 2

These are raw text files containing the MUGA genotyping output as it is received from GeneSeek. There
are nine rows of header information. Each line is tab delimited and contains the following columns.

SNP Name MUGA SNP ID.

Sample ID Sample name. Will match the sample name in Samples1 or 2.

Allele1 - Forward Allele call for probe 1.

Allele2 - Forward Allele call for probe 2.

X Normalized X allele intensity

Y Normalized Y allele intensity

GC Score GC Score

Theta X and Y intensites converted to θ coordinate.

X Raw Untransformed X allele intensity.

Y Raw Untransformed Y allele intensity.

R X and Y intensites converted to ρ coordinate.

2.2 Samples1 and 2

These are raw text files containing the sample names from the MUGA genotyping from GeneSeek. Each
line is tab delimited and contains the following columns.

Index Sample index

Name Sample Name

ID Sample ID (may be the same as the name).

Gender Sample sex.

Plate Plate ID on which sample was run.

Well Well in which sample was run.

Group Sample group.

Parent1 Parent1.

Parent2 Parent2.

Replicate Replicate ID

SentrixPosition Sample position code.

2

2.3

call.rate.batch

Data.frame containing allele call rate and batch information for each sample.

sample Sample ID.

call.rate The proportion of successful allele calls.

batch A batch identifier to distinguish batch 1 and 2.

2.4 x and y

These are numeric matrices that contain the X and Y allele intensity data extracted from the FinalReport1
and FinalReport2 files. The dimensions are 141 samples by 7,854 markers. Although there were 150
samples in the study, only 141 were genotyped for technical reasons.

The rows are names by sample ID and the columns are named by the SNP ID.

2.5

geno

This is a character matrix that contains the allele calls extracted from the FinalReport1 and FinalReport2
files. The dimensions are 141 samples by 7,854 markers. Each cell contains either ’A’, ’C’, ’G’,’ H’, ’T’
or ’-’. Although there were 150 samples in the study, only 141 were genotyped for technical reasons.

The rows are names by sample ID and the columns are named by the SNP ID.

2.6 model.probs

A/J
C57BL/6J

This is a numeric three dimensional array containing the founder haplotype contributions for each sample
at each marker. The dimensions are 141 samples by 8 founders by 7,854 markers. Cell (i, j, k) contains
the proportion of j at locus k for sample i. The founders are labeled A through H and are explained
below.
A
B
C 129S1/SvImJ
D NOD/ShiLtJ
E NZO/H1LtJ
F
CAST/EiJ
PWK/PhJ
G
H WSB/EiJ

> data(model.probs)
> model.probs[1,,1:5]

UNC010515443 UNC010001943 UNC010515539 UNC010515556 UNC010002207
A 9.598007e-51 3.220165e-16 1.380275e-17 1.458903e-17 1.640058e-16
B 8.411587e-09 8.419524e-46 1.083905e-19 8.248867e-39 4.575537e-17
C 1.877777e-08 9.333647e-09 5.353990e-12 1.109631e-22 4.553043e-17
D 5.000000e-01 5.000000e-01 5.000000e-01 5.000000e-01 5.000000e-01
E 5.000000e-01 5.000000e-01 5.000000e-01 5.000000e-01 5.000000e-01
F 7.889177e-40 7.543572e-22 1.074099e-17 1.087953e-17 9.531830e-17
G 4.537672e-39 6.875965e-21 1.950897e-16 1.948297e-16 2.054865e-16
H 1.054247e-08 3.493217e-12 1.563549e-15 9.469679e-17 1.257905e-17

3

2.7 pheno

This is the phenotype data for the samples in this study. There are 149 samples in rows and 142
columns. The first six columns contain sample information and the remaining columns contain phenotype
measurements.

> data(pheno)
> pheno[1:5,1:6]

Sample Sex Gen Diet Coat.Color WBC1
agouti 4.95
black 5.59
white 6.54
agouti 6.02
agouti 5.64

F G4L2
F G4L2
F G4L2
F G4L2
F G4L2

F01
F02
F03
F04
F05

hf
hf
hf
hf
hf

F01
F02
F03
F04
F05

4

Column Name
Sample
Sex
Gen
Diet
Coat.Color
WBC1
RBC1
mHGB1
HCT1
MCV1
MCH1
MCHC1
CHCM1
RDW1
HDW1
PLT1
MPV1
perc.NEUT1
perc.LYM1
perc.MONO1
perc.EOS1
Retic1
cHGB1
ct.NEUT1
ct.LYM1
ct.MONO1
ct.EOS1
WBC2
RBC2
mHGB2
HCT2
MCV2
MCH2
MCHC2
CHCM2
RDW2
HDW2
PLT2
MPV2
perc.NEUT2
perc.LYM2
perc.MONO2
perc.EOS2
Retic2
cHGB2
ct.NEUT2
ct.LYM2
ct.MONO2
ct.EOS2
HR
HRV
PQ
PR
QRS
QTC
RR
ST

Description
Sample ID
Sample Sex
DO outbreeding generation and litter
Diet, either chow or hf
Coat color coded as agouti, black or white
White Blood Cell counts (1000 cells / µl)
Red Blood Cell counts (1000 cells / µl)
Measured Hemoglobin
Hematocrit
Mean Corpuscular Volume
Mean Corpuscular Hemoglobin
Mean Corpuscular Hemoglobin Concentration
Corpuscular Hemoglobin Concentration Mean
Red blood cell distribution width
Hemoglobin distribution width
Platelet counts
Mean platelet volume
Percent neutrophils
Percent lymphocutes
Percent monocytes
Percetn Eosinophils
Reticulocyte counts
Calulcated hemoglobin
Neutrophil counts
Lymphocyte counts
Monocyte counts
Eosinophil counts
White Blood Cell counts (1000 cells / µl)
Red Blood Cell counts (1000 cells / µl)
Measured Hemoglobin
Hematocrit
Mean Corpuscular Volume
Mean Corpuscular Hemoglobin
Mean Corpuscular Hemoglobin Concentration
Corpuscular Hemoglobin Concentration Mean
Red blood cell distribution width
Hemoglobin distribution width
Platelet counts
Mean platelet volume
Percent neutrophils
Percent lymphocutes
Percent monocytes
Percetn Eosinophils
Reticulocyte counts
Calulcated hemoglobin
Neutrophil counts
Lymphocyte counts
Monocyte counts
Eosinophil counts
Heart rate (beats/min)
Heart rate variability
P to Q wave time
P to R wave time
Q, R S wave time
Q to T wave time, corrected
RR wave
S to T wave time

5

Timepoint (weeks)
NA
NA
NA
NA
NA
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
10
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
22
13
13
13
13
13
13
13
13

Column Name
QTc.dispersion
pNN50...6ms.
rMSSD
CHOL1
TG1
HDLD1
NEFA1
Lipase1
Glucose1
Phosphorus1
Calcium1
GLDH1
BUN1
FRUC1
CHOL2
TG2
HDLD2
NEFA2
Lipase2
Glucose2
Phosphorus2
Calcium2
GLDH2
BUN2
FRUC2
non.fast.Phosphorous
non.fast.Calcium
non.fast.ALB2
non.fast.CREX
Subject.Length1
Weight1
BMD1
BMC1
B.Area1
T.Area1
X..Fat1
TTM1
LTM1
Subject.Length2
Weight2
BMD2
BMC2
B.Area2
T.Area2
X..Fat2
TTM2
LTM2
urine.microalbumin1
urine.Glucose1
urine.creatinine1
urine.microalbumin2
urine.Glucose2
urine.creatinine2

Description
Q to T, corrected dispersion
Mean number of time that teh NN signal exceeds 6 ms
root mean squared standard deviation
Total serum cholesterol
Serum triglycerides
Serum high density lipoprotein
Serum non-esterified fatty acids
Serum lipase
Serum glucose
Serum phosphorus
Serum calcium
Serum glutamate dehydrogenase
Blood urea nitrogen
Serum fructose
Total serum cholesterol
Serum triglycerides
Serum high density lipoprotein
Serum non-esterified fatty acids
Serum lipase
Serum glucose
Serum phosphorus
Serum calcium
Serum glutamate dehydrogenase
Blood urea nitrogen
Serum fructose
Non-fasted serum phosphorus
Non-fasted serum calcium
Non-fasted serum albumin
Non-fasted serum creatinine
Length (cm)
Weight (g)
Bone Mineral Density
Bone Minearal Content
Bone Area
Total Area
Percent fat
Total tissue mass (g)
Lean tissue mass (g)
Length (cm)
Weight (g)
Bone Mineral Density
Bone Minearal Content
Bone Area
Total Area
Percent fat
Total tissue mass (g)
Lean tissue mass (g)
Urine microalbumin
Urine glucose
Urine creatinine
Urine microalbumin
Urine glucose
Urine creatinine

6

Timepoint (weeks)
13
13
13
8
8
8
8
8
8
8
8
8
8
8
19
19
19
19
19
19
19
19
19
19
19

12
12
12
12
12
12
12
12
12
21
21
21
21
21
21
21
21
21

Column Name
heart.wt
spleen.wt
kidney.wt.L
kidney.wt.R
BW.3
BW.4
BW.5
BW.6
BW.7
BW.8
BW.9
BW.10
BW.11
BW.12
BW.13
BW.14
BW.15
BW.16
BW.17
BW.18
BW.19
BW.20
BW.21
BW.22
BW.23
BW.24
BW.25
BW.26
BW.27
BW.28
BW.29
BW.30
INSULIN
LEPTIN

Description
Heart weight (g)
Spleen weight (g)
Left kidney weight (g)
Right kidney weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)
Body weight (g)

Timepoint (weeks)
24 - 30
24 - 30
24 - 30
24 - 30
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
18
19
20
21
22
23
24
25
26
27
28
29
30
17
17

References

[1] F. A. Iraqi, M. Mahajne, Y. Salaymah, H. Sandovski, H. Tayem, K. Vered, L. Balmer, M. Hall,
G. Manship, G. Morahan, K. Pettit, J. Scholten, K. Tweedie, A. Wallace, L. Weerasekera, J. Cleak,
C. Durrant, L. Goodstadt, R. Mott, B. Yalcin, C. Hill, D. L. Aylor, R. S. Baric, T. A. Bell, K. M.
Bendt, J. Brennan, J. D. Brooks, R. J. Buus, J. J. Crowley, J. D. Calaway, M. E. Calaway, A. Cholka,
D. B. Darr, J. P. Didion, A. Dorman, E. T. Everett, M. T. Ferris, W. F. Mathes, C. P. Fu, T. J. Gooch,
S. G. Goodson, L. E. Gralinski, S. D. Hansen, M. T. Heise, J. Hoel, K. Hua, M. C. Kapita, S. Lee,
A. B. Lenarcic, E. Y. Liu, H. Liu, L. McMillan, T. R. Magnuson, K. F. Manly, D. R. Miller, D. A.
O’Brien, F. Odet, I. K. Pakatci, W. Pan, F. P. de Villena, C. M. Perou, D. Pomp, C. R. Quackenbush,
N. N. Robinson, N. E. Sharpless, G. D. Shaw, J. S. Spence, P. F. Sullivan, W. Sun, L. M. Tarantino,
W. Valdar, J. Wang, W. Wang, C. E. Welsh, A. Whitmore, T. Wiltshire, F. A. Wright, Y. Xie, Z. Yun,
V. Zhabotynsky, Z. Zhang, F. Zou, C. Powell, J. Steigerwalt, D. W. Threadgill, E. J. Chesler, and

7

A. Gary. The genome architecture of the Collaborative Cross mouse genetic reference population.
Genetics, 190(2):389–401, Feb 2012.

[2] K. L. Svenson, D. M. Gatti, W. Valdar, C. E. Welsh, R. Cheng, E. J. Chesler, A. A. Palmer, L. McMil-
lan, and G. A. Churchill. High-resolution genetic mapping using the Mouse Diversity outbred popu-
lation. Genetics, 190(2):437–447, Feb 2012.

8

