Tools for Spike-in Data Analysis and Visualization
(spkTools)

Matthew N. McCall

October 30, 2025

Contents

1 Introduction

2 SpikeInExpressionSet

3 spkTools Methods

3.1 Relating nominal concentrations across data sets . . . . . . . . . . . . . .

3.2 Accuracy assessment

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3 ALE strata . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.4 Precision assessments . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.5 Performance assessments . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.6

Imbalance measure . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Example

1

Introduction

1

2

2

2

3

3

3

4

5

5

As the number of users of microarray technology continues to grow, so does the im-
portance of platform assessments and comparisons. Spike-in experiments have been
successfully used for internal technology assessments by microarray manufacturers and

1

for comparisons of competing data analysis approaches. The microarray literature is sat-
urated with statistical assessments based on spike-in experiment data. Unfortunately,
the statistical assessments vary widely and are applicable only in specific cases. This has
introduced confusion into the debate over best practices with regards to which platform,
protocols, and data analysis tools are best. Furthermore, cross-platform comparisons
have proven difficult because reported concentrations are not comparable. We present a
novel statistical solution that enables cross-platform comparisons, and propose a com-
prehensive procedure for assessments based on spike-in experiments. The ideas are
implemented in a user friendly Bioconductor package: spkTools.

This document describes spkTools, which implements the methods suggested in the
Nucleic Acids Research paper, Consolidated strategy for the analysis of microarray spike-
in data (McCall & Irizarry 2008). While ideally someone interested in using this package
would use that paper as a guide, sections relating specifically to the spkTools package
are included here.

2 SpikeInExpressionSet

This package defines a new S4 class that extends the ExpressionSet class to include
a matrix of nominal concentrations; this new class is called a SpikeInExpressionSet.
The functions implemented in this package take an object of this type as their input
and produce the tables and plots presented in this paper. Of particular interest is the
function spkAll, which is a wrapper function for all the functions contained in this
package. When run on a SpikeInExpressionSet object, it produces the full complement
of tables and plots shown in this paper and saves them with easily recognizable file-
names. Although this package was designed with the intent of producing the full array
of results for each experiment, the functions can also be applied separately with a few
exceptions where the output of one function is required as the input of another.

3

spkTools Methods

3.1 Relating nominal concentrations across data sets

Our solution to the problem of mapping was to replace each nominal concentration with
the average log expression across arrays (ALE) for genes spiked in at that concentration.
This approach assures that performance assessments based on spike-in data are related
to expression measurements that are defined consistently across platforms: low, medium,
and high ALE values correspond to low, medium, and high observed expression values
respectively.

2

3.2 Accuracy assessment

With the ALE values in place, we were ready to adapt some of the existing statistical
assessments to cross-platform comparisons. We started with a basic assessment of accu-
racy: the signal detection slope. Microarrays are designed to measure the abundance of
sample RNA. In principle, we expect a doubling of nominal concentration to result in
a doubling of observed intensity. In other words, on the log2 scale, the slope from the
regression of expression on nominal concentration can be interpreted as the expected
observed difference when the true difference is a fold change of 2. Thus, an optimal
result is a slope of one, and values higher and lower than one are associated with over
and under estimation respectively.

3.3 ALE strata

It has been noted that at very high and very low concentrations one typically observes
lower slopes compared to those seen at medium concentrations. To address this, we
consider the signal detection slopes for genes spiked-in at low, medium, and high ALE
values. We implemented a data-driven approach to selecting these two cut-offs.

We defined f to be the function that maps nominal log concentration x to expected
observed concentration f (x). Using a cubic spline, fitted to the observed data, we ob-
tained a parametric representation of f . We then looked for concentrations for which
clear changes in sensitivity occurred, i.e. values of x with large slope changes. Note
that large changes in slope result in local maxima in the absolute value of the second
derivative of f . For each platform, the absolute value of the second derivative f ′′ showed
two clear local maxima. For each platform we mapped each concentration x to its cor-
responding empirical percentile Φ(x) and plotted |f ′′(x)| against Φ(x). The percentiles
that maximized the slope change were similar across platforms. The modes for the av-
erage curve were 0.615 and 0.993. Therefore, for the purpose of this comparison, we
assigned as low, ALE values less than the 60th percentile of the distribution of back-
ground RNA. Similarly we defined as high ALE values above the 99th percentile. The
remaining ALE values, between the 60th and 99th percentile, were denoted as medium.
Our choice of cut-points was further motivated by observing that for the Affymetrix
data the 60th percentile provided a good cut-off for distinguishing genes called present
from genes called absent.

3.4 Precision assessments

To complete our comparison we needed to assess specificity. Because the majority of
microarray studies rely on relative measures (e.g. fold change) as opposed to absolute

3

ones, we focused on the precision of the basic unit of relative expression:
log-ratios.
We adapted the precision assessment of Cope et al. that focused on the variability of
log-ratios generated by comparisons expected to produce log-ratios of 0. Our set of com-
parisons was created by making all possible comparisons between spiked-in transcripts
across arrays in which they had the same nominal concentration and from all possible
comparisons within the background RNA. We referred to this group of comparisons as
the Null set. The standard deviation (SD) of these log-ratios served as a basic assess-
ment of precision and has a useful interpretation: it is the expected range of observed
log-ratios for genes that are not differentially expressed.

Because specificity varies with nominal concentration, we stratified these comparisons
into low, medium, and high ALE values. Many outliers were observed on each platform.
This was expected given the documented problem of cross-hybridization. Because a
platform with larger SD and small outliers might be preferable to one with a smaller SD
but large outliers we included the 99.5th percentile of the null distribution as a second
summary assessment of specificity. Note that in a typical experiment close to 0.5%
of null genes are expected to exceed this value, which translates to approximately 100
genes on whole genome arrays. We also included comparisons of spike-ins expected to
yield a certain fold change. These serve to further demonstrate the variability of relative
expression across ALE strata. They also serve as a rough illustration of the accuracy of
log-ratios for each ALE strata.

3.5 Performance assessments

Precision and accuracy assessments on their own may not be of much practical use.
However, the summary statistics described above can be easily combined to answer any
practical question, as long as it can be posed in a statistical context. We focus on two
summaries related to the common problem of detecting differentially expressed genes.
Note that we purposely developed summaries that do not directly penalize for a lack of
accuracy and precision as long as the real differences are detected. However, as expected,
detection ability was highly dependent on accuracy and precision.

For the first example, we computed the chance that, when comparing two samples,
a gene with true log fold change ∆ = 1 will appear in a list of the top 100 genes
(highest log-ratios). We refer to this quantity as the probability of being at the top
(POT) and recommend computing it separately in each ALE strata. Specifically, we
assume that the log-ratios in each ALE strata follow a normal distribution with mean
and variance estimated from the data (accuracy slope and standard deviation) and
compute the probability that a random variable from that distribution exceeds the 99.5th
percentile of the null distribution.

As a second example, we computed the expected size of a gene list one would have to

4

consider to find n genes that have a true log fold change ∆. To perform this calculation
we assumed m1 genes were differentially expressed and m0 were not. Note that m1 + m0
is the number of genes on the array. Furthermore, we assumed that the true log-ratios
in each ALE strata followed a normal distribution with mean and variance estimated
from the data (accuracy slope and standard deviation). The empirical distribution was
used for the null genes. With these assumptions in place we computed the gene list size
for n = 10, m1 = 100, and m0 = 10000, we calculate the gene list size, N , required to
obtain n = 10 true fold changes. We refer to this quantity as the gene-list needed to
detect n true-positives (GNN). Again, we recommend computing it separately in each
ALE strata.

3.6

Imbalance measure

Those interested in taking advantage of our methodology should know that an important
requirement is a spike-in experimental design that does not confound nominal concen-
trations and genes. A large source of variability in microarray data is the probe-effect
and these vary across platforms. We fitted an ANOVA model to describe the probe
effect for each platform. Note that if nominal concentrations are confounded with genes,
it becomes impossible to separate differences due to signal detection from differences
in probe affinities. Many of the previously published spike-in experiments suffer from
this confounding effect. To quantify design imbalance we used the following measure of
imbalance developed by Wu (1981):

IB =

p
(cid:88)

i=1

λi

ri(cid:88)

(cid:16) T
(cid:88)

ui

t=1

n2
t (ui) −

(cid:17)
n2(ui)

1
T

(1)

where i denotes each covariate, λi an optional weight associated with each covariate,
ui are the possible levels for covariate i, t represents the treatment levels, nt(ui) is the
number of units with its ith covariate at level ui receiving treatment t, and n(ui) is the
total number of units with its ith covariate at level ui. In our case, the two covariates
are probe and array, and the treatment is nominal concentration. Since imbalance is
defined as a weighted sum of the imbalance due to each covariate, we chose to report
the probe and array imbalance separately to give a better understanding of the source
of the imbalance in each design. In order to not penalize large designs, we divided the
probe imbalance by the number of probes and the array imbalance by the number of
arrays.

4 Example

> library(spkTools)

5

Load a SpikeInExpressionSet object :

> data(affy)
> object <- affy

Set a few parameters:

> fc=2
> label="Affymetrix"
> par(mar=c(3,2.5,2,0.5), cex=1.8)

6

> spkSlopeOut <- spkSlope(object, label, pch="+")

Observed versus nominal values: This plot depicts expression values plotted against
the log (base 2) of the reported nominal concentration. The regression slope obtained
utilizing all the data and the regression slopes obtained within each ALE value strata
are shown. The slope of each line is reported in the legend. The vertical lines divide the
ALE strata.

7

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++−2024684681012AffymetrixNominal ConcentrationObserved Expression MeasureTotal: 0.68Low: 0.2Med: 0.79High: 0.57> spkDensity(object, spkSlopeOut, cuts=TRUE, label)

Empirical densities: This plot depicts the empirical density of the average (across
arrays) expression values for the background RNA. The tick marks on the x-axis show
the average expression at each nominal concentration. The dotted lines represent the
cut points for low, medium, and high ALE values.

8

0510150.000.050.100.15AffymetrixObserved Expression MeasureDensity> spkBoxOut <- spkBox(object, spkSlopeOut, fc)
> plotSpkBox(spkBoxOut, fc, ylim=c(-1.5,2.5))
> sbox <- summarySpkBox(spkBoxOut)

Log-ratio distributions: This plot depicts the distribution of observed log ratios for
a given nominal fold change. The log ratios are stratified by the ALE strata into which
the two nominal concentrations fall. The null distributions’ log-ratios are divided into
background RNA (Bg-Null) and spike-ins at the same nominal concentration (S-Null),
for each bin. The dotted horizontal lines represent the expected or nominal log-ratios:
zero for the null distribution and one for the other comparisons.

9

−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−Bg−Null LLBg−Null MMBg−Null HHS−Null LLS−Null MMS−Null HHLLMLMMHMHH−1012Observed Log−Ratio> spkMA(object, spkSlopeOut, fc, label=label, ylim=c(-2.5,2.5))

MA plots: For each platform, we performed all pair-wise comparisons of the arrays.
From each comparison we computed the log-ratio (M) and average expression value (A)
for each gene. These plots show M plotted against A. To avoid drawing hundreds of
points on top of each other we use a smooth scatter plot which shows the distribution of
these points: dark and light shades of blue show high and low concentrations of points
respectively. Points not associated with the spike-in transcripts (expected M=0) that
achieved fold changes above 2 are shown as large blue dots. The points associated with
spike-in transcripts with nominal fold changes of 2 are shown as triangles. The different
colors denote the ALE groups.

10

4681012−2−1012AffymetrixAMBg−Null LLBg−Null MMBg−Null HHLLMLMMHMHH> vtmp <- spkVar(object)
> sv <- as.numeric(vtmp[,2][-nrow(vtmp)])
> bin <- c("Low", "Med", "High")
> bins <- bin[spkSlopeOut$breaks[2,]]
> tab1 <- data.frame(NominalConc=2^spkSlopeOut$breaks[1,],
+
+
+
+
> colnames(tab1) <- c("Nominal Conc",
+
+
+
+

AvgExp=round(spkSlopeOut$avgExp,1),
PropGenesBelow=round(spkSlopeOut$prop,2),
ALEStrata=bins,
SD=round(sv,2))

"Avg Expression",
"Prop of Genes Below",
"ALE Strata",
"Std Dev")

Nominal Conc Avg Expression Prop of Genes Below ALE Strata Std Dev
0.87
0.90
0.74
0.72
0.82
0.79
0.68
0.67
0.79
0.72
0.54
0.49
0.51

0.37 Low
0.40 Low
0.42 Low
0.50 Low
0.62 Med
0.73 Med
0.83 Med
0.88 Med
0.94 Med
0.97 Med
0.98 Med
1.00 High
1.00 High

0.12
0.25
0.50
1.00
2.00
4.00
8.00
16.00
32.00
64.00
128.00
256.00
512.00

5.10
5.20
5.30
5.70
6.40
7.10
7.80
8.40
9.30
10.20
11.20
12.00
12.60

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

Nominal concentration to ALE mapping: This table contains summary mea-
sures specific to each nominal spike-in level. The first column shows the nominal con-
centrations as originally reported. The second column shows the average of all observed
expression values associated with the row’s nominal concentration. The third column
shows the proportion of background RNA with expression values less than the average
expression value. The fourth column shows the ALE strata associated with the row’s
nominal concentration. Finally, the fifth column shows the standard deviation of all
observed expression values associated with the row’s nominal concentration.

11

precisionQuantile=.995)

> AccuracySlope <- round(spkSlopeOut$slopes[-1], digits=2)
> AccuracySD <- round(spkAccSD(object, spkSlopeOut), digits=2)
> pot <- spkPot(object, spkSlopeOut, AccuracySlope, AccuracySD,
+
> PrecisionSD <- round(sbox$madFC[1:3], digits=2)
> PrecisionQuantile <- round(pot$quantiles, digits=2)
> SNR <- round(AccuracySlope/PrecisionSD, digits=2)
> POT <- round(pot$POTs, digits=2)
> tab2 <- data.frame(AccuracySlope=AccuracySlope,
+
+
+
+
+

AccuracySD=AccuracySD,
PrecisionSD=PrecisionSD,
PrecisionQuantile=PrecisionQuantile,
SNR=SNR,
POT=POT)

AccuracySlope AccuracySD PrecisionSD PrecisionQuantile SNR POT
0.31
0.89
0.99

0.20
0.79
0.57

0.35
0.37
0.19

0.10
0.09
0.06

2.00
8.78
9.50

0.31
0.35
0.15

Low
Med
High

Assessment results: For each of the ALE strata we report summary assessments
for accuracy, precision, and overall performance. The first column shows the signal
detection slope which can be interpreted as the expected observed difference when the
true difference is a fold change of 2.
In parenthesis is the standard deviation of the
log-ratios associated with non-zero nominal log-ratios. The second column shows the
standard deviation of null log-ratios. The SD can be interpreted as the expected range
of observed log-ratios for genes that are not differentially expressed. The third column
shows the 99.5th percentile of the null distribution. It can be interpreted as the expected
minimum value that the top 100 non-differentially expressed genes will reach. The fourth
column shows the ratio of the values in column 1 and column 2. It is a rough measure
of signal to noise ratio. The fifth column shows the probability that, when comparing
two samples, a gene with a true log fold change of 2 will appear in a list of the 100 genes
with the highest log-ratios.

12

> bals <- round(spkBal(object))
> anv <- round(spkAnova(object), digits=2)
> tab3 <- t(c(anv,bals))

spike probe
0.54
2.48

1

array error Probe Imbalance Array Imbalance
0.00
0.17

0.47

0.00

ANOVA results: To understand the variability contributed by differences in nominal
concentrations, probe effect, and array, we fitted a 3-way ANOVA model containing
only main effects to the expression values from the spike-in transcripts. The estimated
standard deviation of each effect is shown in the first three columns. The forth column
shows the standard deviation of the error term. Finally, a measure of the amount of
confounding between nominal concentration and the other two effects is included in
columns five and six. We use the measure presented by Wu in Technometrics (1981),
Volume 23, Number 1. An optimal design, such as a Latin Square, will have a measure of
0 for each imbalance. The more confounding the larger these values. Because Affymetrix
using a latin square design, there is no imbalance.

References

L.M. Cope, R.A. Irizarry, H.A. Jaffee, Z. Wu, and T.P. Speed. A benchmark for

Affymetrix GeneChip expression measures. Bioinformatics, 20:323–331, 2004.

Robert C Gentleman, Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Det-
tling, Sandrine Dudoit, Byron Ellis, Laurent Gautier, Yongchao Ge, Jeff Gentry, Kurt
Hornik, Torsten Hothorn, Wolfgang Huber, Stefano Iacus, Rafael Irizarry, Friedrich
Leisch, Cheng Li, Martin Maechler, Anthony J. Rossini, Gunther Sawitzki, Colin
Smith, Gordon Smyth, Luke Tierney, Jean Y. H. Yang, and Jianhua Zhang. Bio-
conductor: Open software development for computational biology and bioinformatics.
Genome Biology, 5:R80, 2004. URL http://genomebiology.com/2004/5/10/R80.

R.A. Irizarry, B.M. Bolstad, F. Collin, L.M. Cope, B. Hobbs, and T.P. Speed. Summaries
of Affymetrix GeneChip probe level data. Nucleic Acids Research, 31(4):e15, 2003.

R.A. Irizarry, D. Warren, F. Spencer, I.F. Kim, S. Biswal, B.C. Frank, E. Gabrielson,
J.G.N. Garcia, J. Geoghegan, G. Germino, et al. Multiple-laboratory comparison of
microarray platforms. Nature Methods, 2(5):345–350, 2005.

R.A. Irizarry, L.M. Cope, and Z. Wu. Feature-level exploration of a published Affymetrix

GeneChip control dataset. Genome Biology, 7(8):404, 2006a.

R.A. Irizarry, Z. Wu, and H.A. Jaffee. Comparison of Affymetrix GeneChip expression

measures. Bioinformatics, 22(7):789, 2006b.

13

M.N. McCall and R.A. Irizarry. Consolidated strategy for the analysis of microarray

spike-in data. Nucleic Acids Research, 36(17):e108, 2008.

C.F. Wu. Iterative Construction of Nearly Balanced Assignments I: Categorical Covari-

ates. Technometrics, 23(1):37–44, 1981.

14

