An R package to process LC/MS metabolomic data:
MAIT (Metabolite Automatic Identification Toolkit)

Francesc Fernández-Albert, Rafael Llorach,
Cristina Andrés-Lacueva, Alexandre Perera

October 30, 2025

1 Abstract

Processing metabolomic liquid chromatography and mass spectrometry (LC/MS) data files is
time consuming. Currently available R tools allow for only a limited number of processing
steps and online tools are hard to use in a programmable fashion. This paper introduces the
metabolite automatic identification toolkit MAIT package, which allows users to perform end-
to-end LC/MS metabolomic data analysis. The package is especially focused on improving
the peak annotation stage and provides tools to validate the statistical results of the analysis.
This validation stage consists of a repeated random sub-sampling cross-validation procedure
evaluated through the classification ratio of the sample files. MAIT also includes functions that
create a set of tables and plots, such as principal component analysis (PCA) score plots, cluster
heat maps or boxplots. To identify which metabolites are related to statistically significant
features, MAIT includes a metabolite database for a metabolite identification stage.

2

Introduction

Liquid Chromatography and Mass Spectrometry (LC/MS) is an analytical instrument widely
used in metabolomics to detect molecules in biological samples. It breaks the molecules down
into pieces, some of which are detected as peaks in the mass spectrometer. Metabolic profiling
of LC/MS samples basically consists of a peak detection and signal normalisation step, followed
by multivariate statistical analysis such as principal components analysis (PCA) and univariate
statistical tests such as ANOVA .
As analysing metabolomic data is time consuming, a wide array of software tools are available,
including commercial tools such as Analyst® software. There are programmatic R packages,
such as XCMS to detect peaks or CAMERA package and AStream , which cover only peak an-
notation. Another category of free tools available consists of those having online access through
a graphical user interface (GUI), such as XCMS Online (http://xcmsonline.scripps.edu) or
MetaboAnalyst, both extensively used.
These online tools are difficult to use in a programmable fashion. They are also designed
and programmed to be used step by step with user intervention, making it difficult to set

1

up metabolomic data analysis workflow. These R packages involve only a part of the entire
metabolomic analysis process. Although there are specific R packages whose objective is peak
annotation, this is still an issue in analysing LC/MS metabolomic data.

We introduce a new R package called metabolite automatic identification toolkit (MAIT)
for automatic LC/MS analysis. The goal of the MAIT package is to provide an array of tools
for programmable metabolomic end-to-end analysis. It consequently has special functions to
improve peak annotation through the processes called biotransformations. Specifically, MAIT
is designed to look for statistically significant metabolites that separate the classes in the data.

3 Methodology

The main processing steps for metabolomic LC/MS data include the following stages: peak
detection, peak annotation and statistical analysis. In the peak detection stage, the objective
is to detect the peaks in the LC/MS sample files. The peak annotation stage identifies the
metabolites in the metabolomic samples better by increasing the chemical and biological in-
formation in the data set. A statistical analysis step is essential to obtain significant sample
features. All these 3 steps are covered in the MAIT workflow.

3.1 Peak Detection
Peak detection in metabolomic LC/MS data sets is a complex issue for which several approaches
have been developed. Two of the most well established techniques are matched filter and the
centWave algorithm . MAIT can use both algorithms through the XCMS package.

3.2 Peak Annotation
The MAIT package uses 3 complementary steps in the peak annotation stage.

• The first annotation step uses a peak correlation distance approach and a retention
time window to ascertain which peaks come from the same source metabolite, following
the procedure defined in CAMERA package. The peaks within each peak group are
annotated following a reference adduct/fragment table and a mass tolerance window.

• The second step uses a mass tolerance window inside the peak groups detected in the first
step to look for more specific mass losses called biotransformations. To do this, MAIT
uses a predefined biotransformation table where the biotransformations we want to find
are saved. A user-defined biotransformation table can be set as an input following the
procedure defined in Section (4.6).

• The third annotation step is the metabolite identification stage, in which a predefined
metabolite database is mined to search for the significant masses, also using a tolerance
window. This database is the Human Metabolome Database (HMDB), 2009/07 version.

2

3.3 Statistical Analysis
The objective of analysing metabolomic profiling data is to obtain the statistically significant
features that contain the highest amount of class-related information. To gather these features,
MAIT applies standard univariate statistical tests (ANOVA or Student’s t-test) to every fea-
ture and selects the significant set of features by setting up a user-defined threshold P-value.
Bonferroni multiple test correction can be applied to the resulting P-values. We propose a val-
idation test to quantify how well the data classes are separated by the statistically significant
features. The separation is validated through a repeated random sub-sampling cross-validation
using partial least squares and discriminant analysis (PLS-DA), support vector machine (SVM)
with a radial Kernel and K-nearest neighbours (KNN). Overall and class-related classification
ratios are obtained to evaluate the class-related information of the significant features.

4 Using MAIT

The data files for this example are a subset of the data used in reference , which are freely
distributed through the XCMS package. In these data there are 2 classes of mice: a group
where the fatty acid amide hydrolase gene has been suppressed (class knockout or KO) and a
group of wild type mice (class wild type or WT). There are 6 spinal cord samples in each class.
In the following, the MAIT package will be used to read and analyse these samples using the
main functions discussed in Section ??. The significant features related to each class will be
found using statistical tests and analysed through the different plots that MAIT produces.

4.1 Data Import
Each sample class file should be placed in a directory with the class name. All the class folders
should be placed under a directory containing only the folders with the files to be analysed. In
this case, 2 classes are present in the data. An example of correct file distribution using the
example data files is shown in Figure 1.

4.2 Peak Detection
Once the data is placed in 2 subdirectories of a single folder, the function sampleProcessing() is
run to detect the peaks, group the peaks across samples, perform the retention time correction
and carry out the peak filling process. As function sampleProcessing() uses the XCMS package
to perform these 4 processing steps, this function exposes XCMS parameters that might be
modified to improve the peak detection step. A project name should be defined because all
the tables and plots will be saved in a folder using that name. For example, typing project =
"project_Test", the output result folder will be "Results_project_Test".

By choosing "MAIT_Demo" as the project name, the peak detection stage can be launched

by typing:

> library(MAIT)

3

Figure 1: Example of the correct sample distribution for MAIT package use. Each
sample file has to be saved under a folder with its class name.

> library(faahKO)
> cdfFiles<-system.file("cdf", package="faahKO", mustWork=TRUE)
> MAIT <- sampleProcessing(dataDir = cdfFiles, project = "MAIT_Demo",
+ snThres=2,rtStep=0.03)

Peak detection done
Retention time correction done
Peak grouping after samples done
Missing Peak integration done

After having launched the sampleProcessing function, peaks are detected, they are grouped
across samples and their retention time values are corrected. A short summary in the R session
can be retrieved by typing the name of the MAIT-class object.

> MAIT

A MAIT object built of 12 samples
The object contains 6 samples of class KO
The object contains 6 samples of class WT

The result is a MAIT-class object that contains information about the peaks detected,
their class names and how many files each class contains. A longer summary of the data is
retrieved by performing a summary of a MAIT-class object. In this longer summary version,
further information related to the input parameters of the whole analysis is displayed. This
functionality is especially useful in terms of traceability of the analysis.

> summary(MAIT)

A MAIT object built of 12 samples
The object contains 6 samples of class KO
The object contains 6 samples of class WT

4

Parameters of the analysis:

Value
"/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf"
"2"
"2.12332257516562"
"0.3"
"loess"
"density"
"3"
"0.25"
"centWave"
"0.03"
"0"
"MAIT_Demo"
"10"
"0.5"
"30"
"gaussian"
"symmetric"
"0.2"

dataDir
snThres
Sigma
mzSlices
retcorrMethod
groupMethod
bwGroup
mzWidGroup
filterMethod
rtStep
nSlaves
project
ppm
minfrac
fwhm
family1
family2
span
centWave peakwidth1 "5"
centWave peakwidth2 "20"

4.3 Peak Annotation
The next step in the data processing is the first peak annotation step, which is performed
through the peakAnnotation(). If the input parameter adductTable is not set, then the default
MAIT table for positive polarisation will be selected. However, if the adductTable parameter
is set to "negAdducts", the default MAIT table for negative fragments will be chosen instead.
peakAnnotation function also creates an output table (see Table ??) containing the peak mass
(in charge/mass units), the retention time (in minutes) and the spectral ID number for all the
peaks detected. A call of the function peakAnnotation may be:

> MAIT <- peakAnnotation(MAIT.object = MAIT,corrWithSamp = 0.7,
+ corrBetSamp = 0.75,perfwhm = 0.6)

WARNING: No input adduct/fragment table was given. Selecting default MAIT table for positive polarity...
Set adductTable equal to negAdducts to use the default MAIT table for negative polarity
Start grouping after retention time.
Created 332 pseudospectra.
Spectrum build after retention time done
Generating peak matrix!

5

Run isotope peak annotation

% finished: 10 20 30

40 50

60 70

80

90 100

Found isotopes: 104
Isotope annotation done
Start grouping after correlation.
Generating EIC's ..

Calculating peak correlations in 332 Groups...

% finished: 10 20 30

40 50

60 70

80

90 100

Calculating peak correlations across samples.

% finished: 10 20 30

40 50

60 70

80

90 100

Calculating isotope assignments in 332 Groups...

% finished: 10 20 30

40 50

60 70

80

90 100

Calculating graph cross linking in 332 Groups...

80

60 70

40 50
735

% finished: 10 20 30
New number of ps-groups:
xsAnnotate has now 735 groups, instead of 332
Spectrum number increased after correlation done
Generating peak matrix for peak annotation!
Found and use user-defined ruleset!
Calculating possible adducts in 735 Groups...

90 100

% finished: 10 20 30

40 50
Adduct/fragment annotation done

60 70

80

90 100

Because the parameter adductTable was not set in the peakAnnotation call, a warning
was shown informing that the default MAIT table for positive polarisation mode was selected.
The xsAnnotated object that contains all the information related to peaks, spectra and their
annotation is stored in the MAIT object. It can be retrieved by typing:

> rawData(MAIT)

$xsaFA
An "xsAnnotate" object!
With 735 groups (pseudospectra)
With 12 samples and 1261 peaks
Polarity mode is set to: positive
Using automatic sample selection
Annotated isotopes: 104
Annotated adducts & fragments: 72
Memory usage: 4.43 MB

4.4 Statistical Analysis
Following the first peak annotation stage, we want to know which features are different between
classes. Consequently, we run the function spectralSigFeatures().

6

> MAIT<- spectralSigFeatures(MAIT.object = MAIT,pvalue=0.05,
+

p.adj="none",scale=FALSE)

Skipping peak aggregation step...

> summary(MAIT)

A MAIT object built of 12 samples and 1261 peaks. No peak aggregation technique has been applied
56 of these peaks are statistically significant
The object contains 6 samples of class KO
The object contains 6 samples of class WT

Parameters of the analysis:

dataDir
snThres
Sigma
mzSlices
retcorrMethod
groupMethod
bwGroup
mzWidGroup
filterMethod
rtStep
nSlaves
project
ppm
minfrac
fwhm
family1
family2
span
centWave peakwidth1
centWave peakwidth2
corrWithSamp
corrBetSamp
perfwhm
sigma
peakAnnotation pvalue
calcIso
calcCiS
calcCaS
graphMethod
annotateAdducts
peakAggregation method

Value
"/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf"
"2"
"2.12332257516562"
"0.3"
"loess"
"density"
"3"
"0.25"
"centWave"
"0.03"
"0"
"MAIT_Demo"
"10"
"0.5"
"30"
"gaussian"
"symmetric"
"0.2"
"5"
"20"
"0.7"
"0.75"
"0.6"
"6"
"0.05"
"TRUE"
"TRUE"
"TRUE"
"hcs"
"TRUE"
"None"

7

"FALSE"
peakAggregation PCAscale
"FALSE"
peakAggregation PCAcenter
"FALSE"
peakAggregation scale
peakAggregation RemoveOnePeakSpectra "FALSE"
Welch pvalue
Welch p.adj

"0.05"
"none"

It is worth mentioning that by setting the scale parameter to TRUE, the data will be
scaled to have unit variance. A summary of the statistically significant features is created and
saved in a table called significantFeatures.csv (see Table ??).
It is placed inside the Tables
subfolder located in the project folder. This table shows characteristics of the statistically
significant features, such as their P-value, the peak annotation or the expression of the peaks
across samples. This table can be retrieved at any time from the MAIT-class objects by typing
the instruction:

> signTable <- sigPeaksTable(MAIT.object = MAIT, printCSVfile = FALSE)

head(signTable)

The number of significant features can be retrieved from the MAIT-class object as follows:

> MAIT

A MAIT object built of 12 samples and 1261 peaks. No peak aggregation technique has been applied
56 of these peaks are statistically significant
The object contains 6 samples of class KO
The object contains 6 samples of class WT

4.5 Statistical Plots
Out of 2,402 features, 106 were found to be statistically significant. At this point, several
MAIT functions can be used to extract and visualise the results of the analysis. Functions
plotBoxplot, plotHeatmap, plotPCA and plotPLS automatically generate boxplots, heat maps
and PCA/PLS score plot files in the project folder when they are applied to a MAIT object
(see Table ??).

> plotBoxplot(MAIT)
> plotHeatmap(MAIT)

> MAIT<-plotPCA(MAIT,plot3d=FALSE)
> MAIT<-plotPLS(MAIT,plot3d=FALSE)
> PLSmodel <- model(MAIT, type = "PLS")
> PCAmodel <- model(MAIT, type = "PCA")

> PLSmodel

8

Partial Least Squares

12 samples
56 predictors

2 classes: 'KO', 'WT'

No pre-processing
Resampling: Bootstrapped (25 reps)
Summary of sample sizes: 12, 12, 12, 12, 12, 12, ...
Resampling results across tuning parameters:

ncomp
1
2
3

Accuracy
1
1
1

Kappa
1
1
1

Accuracy was used to select the optimal model using the largest value.
The final value used for the model was ncomp = 1.

> pcaScores(MAIT)

PC5

PC4

0.01698315

1.2817414 -2.5893508

PC3
0.4560729

PC2
5.51253909

PC6
PC1
2.6304313 -0.001166111 -0.14024723
[1,] -8.103931
0.65548080
[2,] -9.018332 -0.22222743 -3.7010516 -2.2074370 -1.944051226
[3,] -5.511187
3.427569605 -1.98128060
[4,] -2.804242 -1.27431307 2.6576958 -0.8357823 0.453653596 3.36170251
2.3295230 -0.351542125 -1.13274686
[5,] -2.964179 -4.19515061 0.7141187
[6,] -3.879094 -2.88873255 0.1555561
1.3969922 -0.732631538 -0.30855890
5.064055 1.00278256 0.6686535 0.3382944 0.542810579 1.22282372
[7,]
4.665604 0.94689331 1.7533831 -1.3360892 -2.774729880 -1.59218199
[8,]
5.978577 0.83212328 -0.4127802 -0.9160021 -0.177627419 0.26137007
[9,]
0.9711509 -0.5728575 -1.200077540 -0.47892310
5.042800
[10,]
0.960806146 -0.08086651
5.587120 -0.03508374 -1.5934350 1.3148452
[11,]
5.942808 -0.28936346 -2.9511057 0.4474328
0.21342810
1.796985912
[12,]
PC8

0.59354948

PC10

PC7

PC9

0.23286357

PC12
PC11
9.540979e-16
[1,] -0.18634269 -0.38998060 -0.2168213 -0.06935821 -0.10492904
4.969983e-16
0.2571789
0.44230455
0.22619221
[2,] -0.42507303
0.22085542
0.1370778 0.07101086 0.01383750 -3.205769e-15
[3,]
0.16476943
0.03301313 -0.9984575 -0.09242844 -0.21597347 -1.425943e-15
[4,] -0.29989390
1.089406e-15
[5,] -2.29389799 -0.25563439 0.2625380 0.19442059
0.4009623 -0.43706048 -0.29884966 1.269818e-15
3.02775049 -0.34453075
[6,]
0.92107983
[7,]
1.06501598 -2.185752e-16
1.9245152 -0.34297762
0.01389960
[8,] -0.27625241
0.78002973 -0.7304979 -1.19197489 0.04518825 4.943962e-16
[9,] -0.61402817 -1.31497376 1.1199112 0.04205945 -1.54954265 2.567391e-16
0.70310509 -1.12306466 -0.4338590 1.78998490 0.72362460 5.846018e-16

0.14482426

[10,]

9

0.25951393

[11,]
[12,] -0.07355034 -1.38999168 -1.0397381 -0.92983818

0.73329844 -0.65932865 3.469447e-16
0.60994068 -3.053113e-16

2.42089320 -0.6828096

The plotPCA and plotPLS functions produce MAIT objects with the corresponding PCA
and PLS models saved inside. The models, loadings and scores can be retrieved from the MAIT
objects by using the functions model, loadings and scores:

All the output figures are saved in their corresponding subfolders contained in the project
folder. The names of the folders for the boxplots, heat maps and score plots are Boxplots,
Heatmaps, PCA_Scoreplots and PLS_Scoreplots respectively. Inside the R session, the project
folder is recovered by typing:

> resultsPath(MAIT)

[1] "/tmp/RtmphTslp5/Rbuild15c0837b38009d/MAIT/vignettes/Results_MAIT_Demo"

4.6 Biotransformations
Before identifying the metabolites, peak annotation can be improved using the function Bio-
transformations to make interpreting the results easier. The MAIT package uses a default
biotransformations table, but another table can be defined by the user and introduced by using
the bioTable function input variable. The biotransformations table that MAIT uses is saved
inside the file MAITtables.RData, under the name biotransformationsTable.

> Biotransformations(MAIT.object = MAIT, peakPrecision = 0.005)

% Annotation in progress: 10

20 30

40 50

60

70 80

90 100

A MAIT object built of 12 samples and 1261 peaks. No peak aggregation technique has been applied

56 of these peaks are statistically significant
The object contains 6 samples of class KO
The object contains 6 samples of class WT

Building a user-defined biotransformations table from the MAIT default table or adding a
new biotransformation is straightforward. For example, let’s say we want to add a new adduct
called "custom_biotrans" whose mass loss is 105.

> data(MAITtables)
> myBiotransformation<-c("custom_biotrans",105.0)
> myBiotable<-biotransformationsTable
> myBiotable[,1]<-as.character(myBiotable[,1])
> myBiotable<-rbind(myBiotable,myBiotransformation)
> myBiotable[,1]<-as.factor(myBiotable[,1])
> tail(myBiotable)

NAME MASSDIFF
glucuronide conjugation 176.0321
192.027
GSH conjugation 305.0682
2x glucuronide conjugation 352.0642
1.0034
105

45
46 hydroxylation + glucuronide
47
48
49
50

[C13]
custom_biotrans

10

To build an entire new biotransformations table, you only need to follow the format of the
biotransformationsTable, which means writing the name of the biotransformations as factors
in the NAME field of the data frame and their corresponding mass losses in the MASSDIFF
field.

4.7 Metabolite Identification
Once the biotransformations annotation step is finished, the significant features have been en-
riched with a more specific annotation. The annotation procedure performed by the Biotrans-
formations() function never replaces the peak annotations already done by other functions.
MAIT considers the peak annotations to be complementary; therefore, when new annotations
are detected, they are added to the current peak annotation and the identification function may
be launched to identify the metabolites corresponding to the statistically significant features in
the data.

> MAIT <- identifyMetabolites(MAIT.object = MAIT, peakTolerance = 0.005)

WARNING: No input database table was given. Selecting default MAIT database...
Metabolite identification initiated

% Metabolite identification in progress: 10
Metabolite identification finished

20

30 40

50 60

70

80 90

100

By default, the function identifyMetabolites() looks for the peaks of the significant features
in the MAIT default metabolite database. The input parameter peakTolerance defines the tol-
erance between the peak and a database compound to be considered a possible match. It is set
to 0.005 mass/charge units by default. To check the results easily, function identifyMetabolites
creates a table containing the significant feature characteristics and the possible metabolite
identifications. Such a table is recovered from the MAIT-class object using the instruction:

> metTable<-metaboliteTable(MAIT)
> head(metTable)

Query Mass Database Mass (neutral mass)

rt Isotope

328.20
544.20
481.10
570.15
396.20
449.10

spectra Biofluid

ENTRY

Unknown 56.32
Unknown 56.62
Unknown 61.42
Unknown 53.81
Unknown 64.39
Unknown 54.87
p.adj

Adduct

Name
Unknown
[M+Na]+ 521.202 Unknown
Unknown
Unknown
Unknown
Unknown

4

unknown unknown 0.0020024932 0.0020024932
12 unknown unknown 0.6602191037 0.6602191037
429 unknown unknown 0.0228596524 0.0228596524
461 unknown unknown 0.0219567137 0.0219567137
469 unknown unknown 0.0178739635 0.0178739635

p Fisher.Test Mean Class KO
49713.15
150448.04
32493.60
71808.43
35365.04

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

11

487 unknown unknown 0.0006846827 0.0006846827

NA

55495.48

6

1
2
3
4
5
6

Mean Class WT Median Class KO Median Class WT KO WT
42096.59
104227.29
36248.51
78043.42
30177.49
50442.30

ko16
0 42881.87 88615.33
3 2 87514.52 15031.62
0 15343.26 28757.71
0.00 68659.67
0 68932.53 49774.82
0 57917.52 50601.15

6912.297 3
3153.240 6

4838.527 4

119004.818

13135.833

0.000 3

ko15

4 1

5636.569
117663.114
7120.502
14649.083
6391.812
3209.048
ko18

ko21

ko19
41311.31 38368.46

ko22
40095.58 47006.340

wt18
1
0.000 11778.497
2 120940.07 70558.05 162788.17 445855.802 196595.300 6122.398 38846.610
3
0.000
0.000 12884.211 13387.454
4
5780.494
5
0.000
6

24105.695 18617.318

wt15
2120.425

8914.240
2721.630

4434.805
1360.024

43739.32

wt16

51219.32 50357.21
5544.795
48512.19 87427.16 120206.09 106045.448
19454.51 30492.806
29862.17 13673.40
89198.74 50283.450
38995.65 45976.37
wt22
wt19
1 10243.441
6788.542
2 96823.161 141186.475 226404.742
0.000
3
0.000
0.000
0.000 39990.445
4 21632.388
8044.100
8155.215
5
3584.850
7280.855
6

wt21
2888.511

3022.015
4306.930

This table provides useful results about the analysis of the samples, such as the P-value of
the statistical test, its adduct or isotope annotation and the name of any possible hit in the
database. Note that if no metabolite has been found in the database for a certain feature, it is
labelled as "unknown" in the table.

4.8 Validation
Finally, we will use the function Validation() to check the predictive value of the significant
features. All the information related to the output of the Validation() function is saved in the
project directory in a folder called "Validation". Two boxplots showing the overall and per
class classification ratios are created, along with every confusion matrix corresponding to each
iteration (see Table ??).

MAIT <- Validation(Iterations = 20, trainSamples= 3,

>
+ MAIT.object = MAIT)

Iteration 1 done
Iteration 2 done
Iteration 3 done
Iteration 4 done
Iteration 5 done
Iteration 6 done
Iteration 7 done

12

Iteration 8 done
Iteration 9 done
Iteration 10 done
Iteration 11 done
Iteration 12 done
Iteration 13 done
Iteration 14 done
Iteration 15 done
Iteration 16 done
Iteration 17 done
Iteration 18 done
Iteration 19 done
Iteration 20 done

A summary of a MAIT object, which includes the overall classification values, can be

accessed:

> summary(MAIT)

A MAIT object built of 12 samples and 1261 peaks. No peak aggregation technique has been applied
56 of these peaks are statistically significant
The object contains 6 samples of class KO
The object contains 6 samples of class WT
The Classification using 3 training samples and 20 Iterations gave the results:

mean
standard error

KNN PLSDA SVM
1
0

1
0

1
0

Parameters of the analysis:

dataDir
snThres
Sigma
mzSlices
retcorrMethod
groupMethod
bwGroup
mzWidGroup
filterMethod
rtStep
nSlaves
project
ppm
minfrac

Value
"/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf"
"2"
"2.12332257516562"
"0.3"
"loess"
"density"
"3"
"0.25"
"centWave"
"0.03"
"0"
"MAIT_Demo"
"10"
"0.5"

13

"30"
fwhm
"gaussian"
family1
"symmetric"
family2
"0.2"
span
"5"
centWave peakwidth1
"20"
centWave peakwidth2
"0.7"
corrWithSamp
"0.75"
corrBetSamp
"0.6"
perfwhm
"6"
sigma
"0.05"
peakAnnotation pvalue
"TRUE"
calcIso
"TRUE"
calcCiS
"TRUE"
calcCaS
"hcs"
graphMethod
"TRUE"
annotateAdducts
"None"
peakAggregation method
"FALSE"
peakAggregation PCAscale
"FALSE"
peakAggregation PCAcenter
peakAggregation scale
"FALSE"
peakAggregation RemoveOnePeakSpectra "FALSE"
Welch pvalue
Welch p.adj
peakTolerance
polarity
Validation Iterations
Validation trainSamples
Validation PCAscale
Validation PCAcenter
Validation RemoveOnePeakSpectra
Validation tuneSVM
Validation scale
PCA data logarithm
PCA data centered
PCA data scaled

"0.05"
"none"
"0.005"
"positive"
"20"
"3"
"0"
"1"
"0"
"0"
"1"
"FALSE"
"TRUE"
"TRUE"

It is also possible to gather the classification ratios per class, classifier used and iteration

number by using the function classifRatioClasses():

> classifRatioClasses(MAIT)

KNN_Class_KO PLSDA_Class_KO SVM_Class_KO KNN_Class_WT PLSDA_Class_WT
1
1
1
1

1
1
1
1

1
1
1
1

1
1
1
1

1
1
1
1

[1,]
[2,]
[3,]
[4,]

14

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

[5,]
[6,]
[7,]
[8,]
[9,]
[10,]
[11,]
[12,]
[13,]
[14,]
[15,]
[16,]
[17,]
[18,]
[19,]
[20,]

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]
[7,]
[8,]
[9,]
[10,]
[11,]
[12,]
[13,]
[14,]
[15,]
[16,]
[17,]
[18,]
[19,]
[20,]

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
SVM_Class_WT
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

The classification ratios are 100%; the set of significant features separates the samples

belonging to these classes.

4.9 Using External Peak Data
Taking advantage of the modularised design of MAIT, it is possible to use the function MAIT-
builder to import peak data and analyse it using the MAIT statistical functions. As stated in

15

section ??, there are certain arguments that should be provided depending on which function
is wanted to be launched. In this section we will show an example of this data importation
procedure using the same data that we have been using in the tutorial so far. Let’s say we have
a peak table recorded in positive polarisation mode with the peak masses and retention time
values such as:

> peaks <- scores(MAIT)
> masses <- getPeaklist(MAIT)$mz
> rt <- getPeaklist(MAIT)$rt/60

We want to perform an annotation stage and metabolite identification on these data. To
that end, we can launch the function MAITbuilder to build a MAIT-class object with the data
in the table:

> importMAIT <- MAITbuilder(data = peaks, masses = masses,
+
+
+

rt = rt,significantFeatures = TRUE,
spectraEstimation = TRUE,rtRange=0.2,
corThresh=0.7)

We have selected the option spectraEstimation as TRUE because we do not know the
grouping of the peaks into spectra. As we want to annotate and identify all the peaks in the
data frame, we set the flag significantFeatures to TRUE. At this point, we can launch the
Biotransformations function:

> importMAIT <- Biotransformations(MAIT.object = importMAIT,
+
+

adductAnnotation = TRUE,
peakPrecision = 0.005, adductTable = NULL)

Set adductTable equal to negAdducts to use the default MAIT table for negative polarity

% Annotation in progress: 0

10 20

30 40

50 60 70

80 90

100

We set the adductAnnotation flag to TRUE as we want to perform an adduct annotation
step. The parameter adductTable set to NULL implies that a positive polarisation adduct
annotation stage will be performed. To run a negative annotation, the argument should be set
to negAdducts. The metabolite identification stage is launched as in the previous case:

> importMAIT <- identifyMetabolites(MAIT.object = importMAIT,
+

peakTolerance=0.005,polarity="positive")

WARNING: No input database table was given. Selecting default MAIT database...
Metabolite identification initiated

% Metabolite identification in progress: 0
Metabolite identification finished

10

20 30

40 50

60 70 80

90 100

16

