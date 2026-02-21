Introduction to the TPP package for analyz-
ing Thermal Proteome Profiling data: 2D-
TPP experiments

Dorothee Childs, Nils Kurzawa

European Molecular Biology Laboratory (EMBL),
Heidelberg, Germany

dorothee.childs@embl.de

TPP version 3.38.0

Abstract

Thermal Proteome Profiling (TPP) combines the cellular thermal shift assay concept [1]
with mass spectrometry based proteome-wide protein quantitation [2]. Thereby, drug-target
interactions can be inferred from changes in the thermal stability of a protein upon drug
binding, or upon downstream cellular regulatory events, in an unbiased manner.

The package TPP facilitates this process by providing exectuable workflows that conduct all
necessary data analysis steps. Recent advances in the field have lead to the development
of so called 2D Thermal Proteome Profiling (2D-TPP) experiments [3]. Recent advances
in the field have lead to the development of so called 2D Thermal Proteome Profiling (2D-
TPP) experiments [3]. Similar as for the TPP-TR and the TPP-CCR analysis, the function
analyze2DTPP executes the whole workflow from data import through normalization and
curve fitting to statistical analysis. Nevertheless, all of these steps can also be invoked
separately by the user. The corresponding functions can be recognized by their suffix tpp2d.

Here, we first show how to start the whole analysis using analyze2DTPP. Afterwards, we
demonstrate how to carry out single steps individually.

For details about the analysis of 1D TR- or CCR experiments [2, 4], please refer to the
vignette TPP_introduction_1D.

Note: There is a new package TPP2D available focused on FDR- controlled analysis of
2D-TPP datasets. This workflow is maintained for backwards compatibility, but TPP2D is
now recommended for analysis. You can find it here

Contents

1

2

Installation .

.

.

.

.

.

.

.

.

.

.

.

.

.

1.1

Special note for Windows users .

Analyzing 2D-TPP experiments.

2.1

2.2

Overview .

.

.

.

.

.

.

.

Performing the analysis .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

3

3

3

2.3

Quality control analyses .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

12

1

Installation

To install the package, type the following commands into the R console

if (!requireNamespace("BiocManager", quietly=TRUE)){

install.packages("BiocManager")

}

BiocManager::install("TPP")

The installed package can be loaded by

library("TPP")

1.1

Special note for Windows users

The TPP package uses the openxlsx package to produce Excel output [5]. openxlsx requires
a zip application to be installed on your system and to be included in the path. On Windows,
such a zip application ist not installed by default, but is available, for example, via Rtools.
Without the zip application, you can still use the ’TPP’ package and access its results via
the dataframes produced by the main functions.

2

TPP

2

2.1

Analyzing 2D-TPP experiments

Overview
Before you can start your analysis, you need to specify information about your experiments:

The mandatory information comprises a unique experiment name, as well as the isobaric
labels and corresponding temperature values for each experiment. The package retrieves this
information from a configuration table that you need to specify before starting the analysis.
This table can either be a data frame that you define in your R session, or a spreadsheet in
.xlsx or .csv format. In a similar manner, the measurements themselves can either be provided
as a list of data frames, or imported directlyfrom files during runtime.

We demonstrate the functionality of the package using the dataset Panobinostat_2DTPP_smallExampleData.
It contains an illustrative subset of a larger dataset which was obtained by 2D-TPP exper-
iments on HepG2 cells treated with the histone deacetylase (HDAC) inhibitor panobinostat
in the treatment groups and with vehicle in the control groups. The experiments were per-
formed for different temperatures. The raw MS data were processed with the Python package
isobarQuant, which provides protein fold changes relative to the protein abundance at the
lowest temperature as input for the TPP package [3].

2.2

Performing the analysis
Fist of all, we load an example data set:

data(panobinostat_2DTPP_smallExample, package = "TPP")

Using this command we load two objects:

1. Panobinostat_2DTPP_smallExampleData: a list of data frames that contain the mea-

surements to be analyzed,

2. hdac2D_config: a configuration table with details about each experiment.

config_tpp2d <- panobinostat_2DTPP_config
data_tpp2d <- panobinostat_2DTPP_data

config_tpp2d

##

Compound Experiment Temperature 126 127L

127H 128L 128H 129L 129H

## 1

Panobinostat

## 2

Panobinostat

## 3

Panobinostat

## 4

Panobinostat

## 5

Panobinostat

## 6

Panobinostat

## 7

Panobinostat

## 8

Panobinostat

## 9

Panobinostat

## 10 Panobinostat

## 11 Panobinostat

## 12 Panobinostat

X020466

X020466

X020467

X020467

X020468

X020468

X020469

X020469

X020470

X020470

X020471

X020471

##

## 1

130L 130H 131L RefCol Path

-

-

-

128H

42.0

44.1

46.2

48.1

50.4

51.9

54.0

56.1

58.2

60.1

62.4

63.9

5

-

5

-

5

-

5

-

5

-

5

-

1 0.143 0.02

-

-

-

1 0.143 0.02

-

-

-

1 0.143 0.02

-

-

-

1 0.143 0.02

-

-

-

1 0.143 0.02

-

-

-

1 0.143 0.02

-

-

-

0

-

0

-

0

-

0

-

0

-

0

-

-

5

-

5

-

5

-

5

-

5

-

5

-

1

-

1

-

1

-

1

-

1

-

1

3

## 2 0.143 0.02

## 3

-

-

## 4 0.143 0.02

## 5

-

-

## 6 0.143 0.02

## 7

-

-

## 8 0.143 0.02

## 9

-

-

## 10 0.143 0.02

## 11

-

-

## 12 0.143 0.02

0

-

0

-

0

-

0

-

0

-

0

131L

128H

131L

128H

131L

128H

131L

128H

131L

128H

131L

data_tpp2d %>% str(1)

## List of 6

## $ X020466:'data.frame': 484 obs. of

15 variables:

## $ X020467:'data.frame': 478 obs. of

15 variables:

## $ X020468:'data.frame': 448 obs. of

15 variables:

## $ X020469:'data.frame': 372 obs. of

15 variables:

## $ X020470:'data.frame': 306 obs. of

15 variables:

## $ X020471:'data.frame': 261 obs. of

15 variables:

The data object Panobinostat_2DTPP_smallExampleData is organized as a list of data frames
which contain the experimental raw data of an 2D-TPP experiment. The names of the list
elements correspond to the different multiplexed experiments. Each experimental dataset
constains the following columns:

data_tpp2d$X020466 %>% colnames

"representative"

## [1] "clustername"
## [3] "msexperiment_id"
"qupm"
"sumionarea_protein_126"
## [5] "qusm"
## [7] "sumionarea_protein_127L" "sumionarea_protein_127H"
## [9] "sumionarea_protein_128L" "sumionarea_protein_128H"
## [11] "sumionarea_protein_129L" "sumionarea_protein_129H"
## [13] "sumionarea_protein_130L" "sumionarea_protein_130H"
## [15] "sumionarea_protein_131L"

In order to perform the complete workflow we can now simply use:

tpp2dResults <- analyze2DTPP(configTable = config_tpp2d,

data = data_tpp2d,
compFc = TRUE,

idVar = "representative",
intensityStr = "sumionarea_protein_",
nonZeroCols = "qusm",

addCol = "clustername",

methods = "doseResponse",

createReport = "none")

tpp2dResults %>% mutate_if(is.character, factor) %>% summary

##

Protein_ID

norm_rel_fc_protein_0_unmodified

4

TPP

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

1

1

1

:1

Min.

1st Qu.:1

X020466_42_IPI00000001.2:
X020466_42_IPI00000005.1:
X020466_42_IPI00000690.1:
X020466_42_IPI00000811.2:
X020466_42_IPI00000875.7:
X020466_42_IPI00001466.2:
(Other)
norm_rel_fc_protein_0.02_unmodified norm_rel_fc_protein_0.143_unmodified
Min.

3rd Qu.:1

Median :1

:0.2612

:0.1767

:4650

Min.

Mean

Max.

:1

:1

1

1

1

1st Qu.:0.9192

Median :1.0000

Mean

:1.0035

3rd Qu.:1.0727

Max.

:4.6565

1st Qu.:0.9364

Median :1.0000

Mean

:1.0105

3rd Qu.:1.0632

Max.

:5.8855

norm_rel_fc_protein_1_unmodified norm_rel_fc_protein_5_unmodified
Min.

: 0.2512

: 0.2422

Min.

1st Qu.: 0.9344

Median : 1.0000

Mean

: 1.0163

3rd Qu.: 1.0654

Max.

:10.0240

1st Qu.: 0.9337

Median : 1.0000

Mean

: 1.0259

3rd Qu.: 1.0589

Max.

:17.0405

norm_rel_fc_protein_0_normalized_to_lowest_conc
Min.

:1

1st Qu.:1

Median :1

Mean

:1

3rd Qu.:1

Max.

:1

norm_rel_fc_protein_0.02_normalized_to_lowest_conc
Min.

:0.1767

1st Qu.:0.9192

Median :1.0000

Mean

:1.0035

3rd Qu.:1.0727

Max.

:4.6565

norm_rel_fc_protein_0.143_normalized_to_lowest_conc
Min.

:0.2612

1st Qu.:0.9364

Median :1.0000

Mean

:1.0105

3rd Qu.:1.0632

Max.

:5.8855

norm_rel_fc_protein_1_normalized_to_lowest_conc
Min.

: 0.2422

1st Qu.: 0.9344

Median : 1.0000

5

## Mean

: 1.0163

## 3rd Qu.: 1.0654

## Max.

:10.0240

##
## norm_rel_fc_protein_5_normalized_to_lowest_conc
## Min.

: 0.2512

## 1st Qu.: 0.9337

## Median : 1.0000

## Mean

: 1.0259

## 3rd Qu.: 1.0589

## Max.

:17.0405

##
## norm_rel_fc_protein_0_transformed norm_rel_fc_protein_0.02_transformed
## Min.

:-0.8841

:0.0000

Min.

## 1st Qu.:0.0000

## Median :1.0000

## Mean

:0.6213

## 3rd Qu.:1.0000

## Max.

:1.0000

1st Qu.:-0.1541

Median : 0.2968

Mean

: 0.3015

3rd Qu.: 0.6140

Max.

: 2.5422

:4421

## NA's
## norm_rel_fc_protein_0.143_transformed norm_rel_fc_protein_1_transformed
## Min.

:-1.2012

:-0.9612

:4421

Min.

NA's

## 1st Qu.: 0.0860

## Median : 0.3763

## Mean

: 0.3998

## 3rd Qu.: 0.6618

## Max.

: 3.2943

:4421

## NA's
## norm_rel_fc_protein_5_transformed
## Min.

:0.0000

## 1st Qu.:0.0000

## Median :0.0000

## Mean

:0.3787

## 3rd Qu.:1.0000

## Max.

:1.0000

## NA's

:4421

##

R_sq

plot

1st Qu.: 0.0951

Median : 0.3129

Mean

: 0.4004

3rd Qu.: 0.6516

: 2.9250

:4421

Max.

NA's

pEC50

slope

Min.

:5.728

Min.

:-50.000

1st Qu.:6.696

1st Qu.:-12.934

Median :7.769

Median : -1.000

Mean

:7.344

Mean

: -8.342

3rd Qu.:8.126

3rd Qu.:

1.159

Max.

:8.126

Max.

: 50.000

:4421

NA's
NA's
compound_effect meets_FC_requirement

:4421

## Min.

:-0.0685

NA's:4656

destabilized: 146

Mode :logical

## 1st Qu.: 0.5448

## Median : 0.7230

## Mean

: 0.6752

## 3rd Qu.: 0.8807

## Max.

: 0.9999

## NA's
:4421
## passed_filter
## Mode :logical

## FALSE:4601

## TRUE :55

##

##

##

stabilized

:

89

FALSE:4537

NA's

:4421

TRUE :119

pEC50_outside_conc_range model_converged
Mode :logical

Mode:logical

FALSE:112

TRUE :123

NA's :4421

TRUE:235

NA's:4421

6

TPP

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

pEC50_quality_check sufficient_data_for_fit protein_identified_in

5.72818301656452: 14

Mode:logical

TRUE:235

NA's:4421

6.07074587494624:

7.44099730847312:

5.86139125662412:

5.86343472719295:

6

5

1

1

(Other)

NA's

: 85

:4544

Mode:logical

TRUE:4656

representative

qupm

qusm

clustername

IPI00000001.2: 12

Min.

: 1.000

Min.

:

1.00

A2M

:

IPI00000005.1: 12

1st Qu.: 3.000

1st Qu.:

5.00

ABHD10 :

IPI00000690.1: 12

Median : 7.000

Median : 11.00

ACAA1

IPI00000811.2: 12

Mean

: 9.149

Mean

: 19.57

IPI00000875.7: 12

3rd Qu.:12.000

3rd Qu.: 23.00

ACO1

ACO2

IPI00001914.1: 12

Max.

:87.000

Max.

:263.00

ACTC1

:

:

:

:

12

12

12

12

12

12

:4584

(Other)
(Other):4584
sumionarea_protein_5 sumionarea_protein_1 sumionarea_protein_0.143
:3.819e+05
Min.

:2.063e+05

:3.579e+05

Min.

Min.

1st Qu.:7.696e+07

1st Qu.:7.604e+07

1st Qu.:8.079e+07

Median :2.511e+08

Median :2.512e+08

Median :2.591e+08

Mean

:7.182e+08

Mean

:7.542e+08

Mean

:7.554e+08

3rd Qu.:7.382e+08

3rd Qu.:7.682e+08

3rd Qu.:7.857e+08

Max.

:2.125e+10

Max.

:2.138e+10

Max.

:1.924e+10

sumionarea_protein_0.02 sumionarea_protein_0
Min.

:2.925e+05

:4.335e+05

Min.

temperature

experiment

Min.

:42.0

X020466:968

1st Qu.:8.401e+07

1st Qu.:7.345e+07

1st Qu.:46.2

X020467:950

Median :2.739e+08

Median :2.574e+08

Median :50.4

X020468:894

Mean

:8.100e+08

Mean

:8.599e+08

Mean

:51.6

X020469:738

3rd Qu.:8.331e+08

3rd Qu.:8.554e+08

3rd Qu.:56.1

X020470:600

Max.

:2.249e+10

Max.

:2.644e+10

Max.

:63.9

X020471:506

rel_fc_protein_5 rel_fc_protein_1 rel_fc_protein_0.143 rel_fc_protein_0.02
Min.
Min.

: 0.3487

: 0.1882

:0.2985

:0.3887

Min.

Min.

1st Qu.: 0.7894

1st Qu.:0.8231

1st Qu.:0.8156

1st Qu.: 0.8413

Median : 0.8964

Median :0.9197

Median :0.9415

Median : 0.9601

Mean

: 0.9935

Mean

:0.9753

Mean

:1.0187

Mean

: 1.0974

3rd Qu.: 1.0878

3rd Qu.:1.0588

3rd Qu.:1.1447

3rd Qu.: 1.2027

Max.

:17.1835

Max.

:8.6463

Max.

:6.2354

Max.

:10.0917

rel_fc_protein_0
:1
Min.

1st Qu.:1

Median :1

Mean

:1

3rd Qu.:1

Max.

:1

7

Moreover, we can also invoke the single functions of the workflow manually. Therefore, we
start with importing the data. Using the import function the data is subsequently imported
and stored in a single dataframe containing all the required data columns and those that the
user likes to take along through the analysis to be displayed together with the results of this
workflow.

8

TPP

data2d <- tpp2dImport(configTable = config_tpp2d,

data = data_tpp2d,
idVar = "representative",
intensityStr = "sumionarea_protein_",
nonZeroCols = "qusm",

addCol = "clustername")

head(data2d)

##

## 1

representative qupm qusm clustername sumionarea_protein_5
1193994914
IPI00000001.2

STAU1

25

15

## 2

IPI00000001.2

## 3

IPI00000001.2

## 4

IPI00000001.2

## 5

IPI00000001.2

15

13

13

15

25

22

22

24

STAU1

STAU1

STAU1

STAU1

1272771185

1482437522

1157290962

396823892

## 6

##

## 1

## 2

## 3

## 4

## 5

## 6

##

## 1

## 2

## 3

## 4

## 5

## 6

IPI00000001.2
STAU1
sumionarea_protein_1 sumionarea_protein_0.143 sumionarea_protein_0.02
1956350223

1375948494

1337957734

345169960

24

15

1473572092

1513181000

1050288621

458022616

1273285951

1284434575

1110810226

453860821

1669312103

1487032006

1128507681

412257039

350182409

352193788

1801848318

344410388
unique_ID
sumionarea_protein_0 temperature experiment
X020466_42_IPI00000001.2
X020466
X020466 X020466_44.1_IPI00000001.2
X020467 X020467_46.2_IPI00000001.2
X020467 X020467_48.1_IPI00000001.2
X020468 X020468_50.4_IPI00000001.2
X020468 X020468_51.9_IPI00000001.2

1404292404

1422365645

439399665

999666282

309019704

51.9

48.1

42.0

44.1

50.4

46.2

attr(data2d, "importSettings")

## $proteinIdCol

## [1] "representative"

##

## $uniqueIdCol
## [1] "unique_ID"
##

## $addCol

## [1] "clustername"

##

## $intensityStr
## [1] "sumionarea_protein_"
##

## $qualColName

## [1] "qupm"

##

## $nonZeroCols

## [1] "qusm"

##

## $fcStr

## NULL

9

If we haven’t computed fold changes from the raw "sumionarea" data, as it is the case in this
example, we can invoke the function tpp2dComputeFoldChanges in order to do so:

fcData2d <- tpp2dComputeFoldChanges(data = data2d)

Thereon the function adds additional columns to our dataframe containing corresponding
fold changes:

head(fcData2d)

##

representative qupm qusm clustername sumionarea_protein_5
1193994914

## 1 IPI00000001.2

STAU1

15

25

## 2 IPI00000001.2

## 3 IPI00000001.2

## 4 IPI00000001.2

## 5 IPI00000001.2

15

13

13

15

25

22

22

24

STAU1

STAU1

STAU1

STAU1

1272771185

1482437522

1157290962

396823892

## 6 IPI00000001.2

STAU1
sumionarea_protein_1 sumionarea_protein_0.143 sumionarea_protein_0.02
1956350223

1375948494

1337957734

345169960

15

24

##

## 1

## 2

## 3

## 4

## 5

## 6

##

## 1

## 2

## 3

## 4

## 5

## 6

##

1473572092

1513181000

1050288621

458022616

1273285951

1284434575

1110810226

453860821

1669312103

1487032006

1128507681

412257039

350182409

352193788

1801848318

344410388
unique_ID
sumionarea_protein_0 temperature experiment
X020466_42_IPI00000001.2
X020466
X020466 X020466_44.1_IPI00000001.2
X020467 X020467_46.2_IPI00000001.2
X020467 X020467_48.1_IPI00000001.2
X020468 X020468_50.4_IPI00000001.2
X020468 X020468_51.9_IPI00000001.2

1404292404

1422365645

309019704

999666282

439399665

42.0

50.4

51.9

48.1

46.2

44.1

rel_fc_5 rel_fc_1 rel_fc_0.143 rel_fc_0.02 rel_fc_0
1
0.7636317

1.0857463

## 1 0.6626501 0.7425474

## 2 0.9063434 1.0493342

0.9067100

1.1887212

## 3 1.0422338 1.0638481

0.9030270

1.0454640

## 4 1.1576773 1.0506392

1.1111810

1.1288844

## 5 0.9031047 1.0423827

1.0329112

0.9382279

## 6 1.1169837 1.1332041

1.1397130

1.1145257

1

1

1

1

1

We can then normalize the data by performing a median normalization on the fold changes,
in order to account for experiment specific noise.

normData2d <- tpp2dNormalize(data = fcData2d)

head(normData2d)

##

representative qupm qusm clustername sumionarea_protein_5
1193994914

## 1 IPI00000001.2

STAU1

15

25

## 2 IPI00000001.2

## 3 IPI00000001.2

## 4 IPI00000001.2

## 5 IPI00000001.2

15

13

13

15

25

22

22

24

STAU1

STAU1

STAU1

STAU1

1272771185

1482437522

1157290962

396823892

## 6 IPI00000001.2

STAU1
sumionarea_protein_1 sumionarea_protein_0.143 sumionarea_protein_0.02
1956350223

1375948494

1337957734

345169960

15

24

##

## 1

10

TPP

## 2

## 3

## 4

## 5

## 6

##

## 1

## 2

## 3

## 4

## 5

## 6

##

1473572092

1513181000

1050288621

458022616

1273285951

1284434575

1110810226

453860821

1669312103

1487032006

1128507681

412257039

350182409

352193788

1801848318

344410388
unique_ID
sumionarea_protein_0 temperature experiment
X020466_42_IPI00000001.2
X020466
X020466 X020466_44.1_IPI00000001.2
X020467 X020467_46.2_IPI00000001.2
X020467 X020467_48.1_IPI00000001.2
X020468 X020468_50.4_IPI00000001.2
X020468 X020468_51.9_IPI00000001.2

1404292404

1422365645

309019704

999666282

439399665

42.0

44.1

48.1

51.9

46.2

50.4

rel_fc_5 rel_fc_1 rel_fc_0.143 rel_fc_0.02 rel_fc_0 norm_rel_fc_5
1.107187

0.7636317

1.0857463

## 1 0.6626501 0.7425474

1

## 2 0.9063434 1.0493342

0.9067100

1.1887212

## 3 1.0422338 1.0638481

0.9030270

1.0454640

## 4 1.1576773 1.0506392

1.1111810

1.1288844

## 5 0.9031047 1.0423827

1.0329112

0.9382279

## 6 1.1169837 1.1332041

1.1397130

1.1145257

1

1

1

1

1

1.114453

1.187727

1.249516

1.123552

1.171933

##

## 1

## 2

## 3

## 4

## 5

## 6

norm_rel_fc_1 norm_rel_fc_0.143 norm_rel_fc_0.02 norm_rel_fc_0
1

1.244416

1.105019

1.059331

1.164559

1.229422

1.147406

1.268366

1.176446

1.022695

1.078735

1.108487

1.267164

1.158041

1.195813

1.211522

1.329434

1.256324

1.163566

1

1

1

1

1

To run the TPP-CCR main function on our 2D-TPP data we now invoke:

ccr2dResults <- tpp2dCurveFit(data = normData2d)

Now we can plot the curves for any of the proteins for which at least one CCR curve could
be fitted. In this case we choose HDAC2:

drPlots <- tpp2dCreateDRplots(data = ccr2dResults, type = "good")

# Find IPI id for HDAC2 (in column representative):
IPI_id_HDAC2 <- unique(filter(ccr2dResults, clustername == "HDAC2")$representative)

# Show corresponding plot:
drPlots[[IPI_id_HDAC2]]

11

And we can also plot the single curves for each of the proteins with:

drPlotsByTemperature <- tpp2dCreateDRplots(data = ccr2dResults, type = "single")
drPlotsByTemperature[[IPI_id_HDAC2]][["54"]]

2.3

Quality control analyses
In order to access the quality of the experimental 2D-TPP data set acquired in a specific
cell line, we recommend to compare the data with vehicle TR experiments (at least two
replicates) of the same cell line. For the analysis of this data we supply a QC-workflow that
enables comparison of treatment and non-treatment samples with reference data.

In order to start this workflow the first thing we need to do, is to generate a cell line specific
TR reference object. We also need to specify the result path where this object should be
stored:

resultPath = file.path(getwd(), 'Panobinostat_Vignette_Example_2D')
if (!file.exists(resultPath)) dir.create(resultPath, recursive = TRUE)

We then load the TPP TR example data and modify it to use only replicate 1 of the vehicle
condition as our reference experiment:

data("hdacTR_smallExample")
trConfig <- hdacTR_config[1:2,] %>%

dplyr::select(-dplyr::matches("Comparison"))

trConfig

tpp2dCreateTPPTRreference(trConfigTable = trConfig,
trDat = hdacTR_data[1:2],
resultPath = resultPath,
outputName = "desired_file_name",
createFCboxplots = FALSE)

For the purpose of explaining this worflow, we will use a reference data set of a HepG2 cell line
supplied with this package. Originating from this object we can now perform various quality
control steps. First of all by setting the createFCboxplots flag to true, we can generate box
plot melting curves of the reference data which are first of all informative of the quality of
the reference data and illustrate melting behavior of all proteins without any treatment.

Calling the function will generate a couple of output files in the indicated output directory.

12

0.000.250.500.751.00−10−9−8−7−6Panobinostat conc. (log M)Normalized apparent stabilityTemperature50.4 C,  pEC50=7.78,  Hill=22,  R2= 0.9651.9 C,  pEC50=7.78,  Hill=15,  R2= 0.9654 C,  pEC50=7.15,  Hill=1,  R2= 0.9456.1 C,  pEC50=7.34,  Hill=1.36,  R2= 0.9958.2 C,  pEC50=6.34,  Hill=2.16,  R2= 0.9760.1 C,  pEC50=5.92,  Hill=6.56,  R2= 0.9862.4 C,  pEC50=5.89,  Hill=17.33,  R2= 163.9 C,  pEC50=5.86,  Hill=26.28,  R2= 1IPI00289601.10TPP

• The tppRefData.RData is a dataset that can be used to assess temperature-range melt-
ing behavior of proteins captured with 2D-TPP e.g. for checking whether stabilization
effects happen at temperatures close to the melting point of individual proteins. When
loaded in R the object tppRefData represents a list with the following elements:

• tppCfgTable: the TPP-TR configtable which was used for generating this object

• sumResTable a list of two elements:

• detail: the exact result data from the TR analysis and

• summary: a summary of the analyzed TR data comprising the median and
standard deviation values of the measurements at the different temperatures (encoded
by the isobaric labels)

• temperatures: a table listing the temperatures which were used in the TR

experiment in the different replicates

• lblsByTemp: a table matching each temperature to an isobaric label

• An excel file which summarizes the data present in tppRefData on different sheets

• Textfiles representing the sheets of the excel file as plain text

• normalizedData.RData containing the TPP-TR data after normalization

• resultTable.RData containing the TPP-TR analysis result table

Secondly, we can generate plots which visualize the melting point temperatures of the 2D-
TPP data in comparison to the TR reference data. Here we demonstrate this function on a
subset of the proteins:

# set the system path for the HepG2 TR reference data set:

trRef <- file.path(system.file("data", package="TPP"),

"TPPTR_reference_results_HepG2.RData")

plotData <- ccr2dResults %>% filter(clustername == "HDAC2")

pEC50QC_HDAC1 <- tpp2dPlotQCpEC50(resultTable = plotData,

resultPath = NULL,

trRef = trRef,

idVar = "representative")

pEC50QC_HDAC1[[1]]

We have therefore used the ccr2dResults data frame which we previously generated by in-
voking the TPP-CCR routine and the the respective configTable.

13

pEC50s from TPP−CCR scanningmelting points from TPP−TR reference0.02.55.07.548.150.451.954.056.158.260.162.463.9temperature [°C]pEC50IPI00289601.10Moreover, we can generate plots that visualize the distributions of fold changes over the
different treatment concentrations and temperatures and how the normalization affected them
(of course only if we previously performed a normalization). The function automatically also
visualizes various other characteristics of the data, such as how proteins behave in neighboring
temperatures which are multiplexed. It can be invoked as follows:

tpp2dPlotQChist(configFile = config_tpp2d,
resultTable = ccr2dResults,

resultPath = resultPath,

trRef = trRef,

idVar = "representative")

References

[1] Daniel Martinez Molina, Rozbeh Jafari, Marina Ignatushchenko, Takahiro Seki,

E Andreas Larsson, Chen Dan, Lekshmy Sreekumar, Yihai Cao, and Paer Nordlund.
Monitoring drug target engagement in cells and tissues using the cellular thermal shift
assay. Science, 341(6141):84–7, 2013.

[2] Mikhail M Savitski, Friedrich BM Reinhard, Holger Franken, Thilo Werner, Maria Fälth

Savitski, Dirk Eberhard, Daniel Martinez Molina, Rozbeh Jafari, Rebecca Bakszt
Dovega, Susan Klaeger, et al. Tracking cancer drugs in living cells by thermal profiling
of the proteome. Science, 346(6205):1255784, 2014.

[3] Isabelle Becher, Thilo Werner, Carola Doce, Esther A Zaal, Cecilia R Berkers, Ina

Tögel, Elsa Salzer, Marcus Bantscheff, and Mikhail M Savitski. Comprehensive thermal
and chemoproteomics profiling identifies phenylalanine hydroxylase as a potent
off-target of the histone deacetylase inhibitor panobinostat. in submission, 2016.

[4] Holger Franken, Toby Mathieson, Dorothee Childs, Gavain Sweetman, Thilo Werner,
Wolfgang Huber, and Mikhail M Savitski. Thermal proteome profiling for unbiased
identification of drug targets and detection of downstream effectors. Nature protocols,
10(10):1567 – 1593, 2015.

[5] Alexander Walker. openxlsx: Read, Write and Edit XLSX Files, 2015. R package

version 2.4.0. URL: http://CRAN.R-project.org/package=openxlsx.

14

