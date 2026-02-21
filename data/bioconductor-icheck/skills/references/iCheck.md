iCheck: A package checking data quality of
Illumina expression data

Weiliang Qiu‡∗, Brandon Guo‡†, Christopher Anderson‡‡, Barbara Klanderman‡§,
Vincent Carey‡¶, Benjamin Raby‡‖

October 30, 2025

‡Channing Division of Network Medicine
Brigham and Women’s Hospital / Harvard Medical School
181 Longwood Avenue, Boston, MA, 02115, USA

Contents

1 Overview of iCheck

2 Exclude failed arrays

3 Check QC probes

4 Check squared correlations among genetic control (GC) arrays

5 Exclude GC arrays

6 Check squared correlations among replicated arrays

7 Obtain plot of estimated density for each array

8 Obtain plot of quantiles across arrays

9 Exclude gene probes with outlying expression levels

10 Obtain plot of the ratio (p95/p05) of 95-th percentile to 5-th

percentile across arrays

11 Exclude arrays with p95/p05 ≤ 6

12 Obtain Plot of principal components

∗stwxq (at) channing.harvard.edu
†brandowonder (at) gmail.com
‡christopheranderson84 (a) gmail.com
§BKLANDERMAN (at) partners.org
¶stvjc (at) channing.harvard.edu
‖rebar (at) channing.harvard.edu

1

2

4

5

6

8

9

10

11

12

13

14

15

13 Perform background correction, data transformation and nor-

malization

14 Obtain Plot of principal components for pre-processed data

15 Incorporate phenotype data

16 Data analysis

16.1 lmFitWrapper and lmFitPaired . . . . . . . . . . . . . . . . . . .
16.2 glmWrapper . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
16.3 lkhrWrapper

17 Result Visualization

18 Session Info

1 Overview of iCheck

16

16

18

18
18
20
21

22

24

The iCheck package provides QC pipeline and data analysis tools for high-
dimensional Illumina mRNA expression data. It provides several visualization
tools to help identify gene probes with outlying expression levels, arrays with low
quality, batches caused technical factors, batches caused by biological factors,
and gender mis-match checking, etc.

We first generate a simulated data set to illustrate the usage of iCheck func-

tions.

>
>
+
+
+
>
>
>
+
+
+
+
+
>

library(iCheck)
if (!interactive())
{

options(rgl.useNULL = TRUE)

}
# generate sample probe data
set.seed(1234567)
es.sim = genSimData.BayesNormal(nCpGs = 110,

nCases = 20, nControls = 20,
mu.n = -2, mu.c = 2,
d0 = 20, s02 = 0.64, s02.c = 1.5, testPara = "var",
outlierFlag = FALSE,
eps = 1.0e-3, applier = lapply)

print(es.sim)

ExpressionSet (storageMode: lockedEnvironment)
assayData: 110 features, 40 samples

element names: exprs

protocolData: none
phenoData

sampleNames: subj1 subj2 ... subj40 (40 total)
varLabels: arrayID memSubj
varMetadata: labelDescription

featureData

featureNames: probe1 probe2 ... probe110 (110 total)

2

fvarLabels: probe gene chr memGenes
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>

# create replicates
dat=exprs(es.sim)
dat[,1]=dat[,2]
dat[,3]=dat[,4]
exprs(es.sim)=dat
es.sim$arrayID=as.character(es.sim$arrayID)
es.sim$arrayID[1]=es.sim$arrayID[2]
es.sim$arrayID[3]=es.sim$arrayID[4]
es.sim$arrayID[5:8]="Hela"
# since simulated data set does not have 'Pass_Fail',
# 'Tissue_Descr', 'Batch_Run_Date', 'Chip_Barcode',
# 'Chip_Address', 'Hybridization_Name', 'Subject_ID', 'gender'
# we generate them now to illustrate the R functions in the package

es.sim$Hybridization_Name = paste(es.sim$arrayID, 1:ncol(es.sim), sep="_")
# assume the first 4 arrays are genetic control samples
es.sim$Subject_ID = es.sim$arrayID
es.sim$Pass_Fail = rep("pass", ncol(es.sim))
# produce genetic control GC samples
es.sim$Tissue_Descr=rep("CD4", ncol(es.sim))
# assume the first 4 arrays are genetic control samples
es.sim$Tissue_Descr[5:8]="Human Hela Cell"
es.sim$Batch_Run_Date = 1:ncol(es.sim)
es.sim$Chip_Barcode = 1:ncol(es.sim)
es.sim$Chip_Address = 1:ncol(es.sim)
es.sim$gender=rep(1, ncol(es.sim))
set.seed(12345)
pos=sample(x=1:ncol(es.sim), size=ceiling(ncol(es.sim)/2), replace=FALSE)
es.sim$gender[pos]=0
# generate sample probe data
es.raw = es.sim[-c(1:10),]
print(es.raw)

ExpressionSet (storageMode: lockedEnvironment)
assayData: 100 features, 40 samples

element names: exprs

protocolData: none
phenoData

sampleNames: subj1 subj2 ... subj40 (40 total)
varLabels: arrayID memSubj ... gender (10 total)
varMetadata: labelDescription

featureData

featureNames: probe11 probe12 ... probe110 (100 total)
fvarLabels: probe gene chr memGenes
fvarMetadata: labelDescription

3

experimentData: use 'experimentData(object)'
Annotation:

>
>
>
>
>
>
>
>
>
>
>

# generate QC probe data
es.QC = es.sim[c(1:10),]
# since simulated data set does not have 'Reporter_Group_Name'
# we created it now to illustrate the usage of 'plotQCCurves'.
fDat=fData(es.QC)
fDat$Reporter_Group_Name=rep("biotin", 10)
fDat$Reporter_Group_Name[3:4]="cy3_hyb"
fDat$Reporter_Group_Name[5:6]="housekeeping"
fDat$Reporter_Group_Name[7:8]="low_stringency_hyb"
fData(es.QC)=fDat
print(es.QC)

ExpressionSet (storageMode: lockedEnvironment)
assayData: 10 features, 40 samples

element names: exprs

protocolData: none
phenoData

sampleNames: subj1 subj2 ... subj40 (40 total)
varLabels: arrayID memSubj ... gender (10 total)
varMetadata: labelDescription

featureData

featureNames: probe1 probe2 ... probe10 (10 total)
fvarLabels: probe gene ... Reporter_Group_Name (5 total)
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

>

2 Exclude failed arrays

The meta data variable Pass_Fail indicates if an array is technically failed. We
first should exclude these arrays.

We first check the values of the variable Pass_Fail:

> print(table(es.raw$Pass_Fail, useNA="ifany"))

pass
40

If there exist failed arrays, then we exclude them:

> pos<-which(es.raw$Pass_Fail != "pass")
> if(length(pos))
+ {
+
+
+ }

es.raw<-es.raw[, -pos]
es.QC<-es.QC[, -pos]

4

3 Check QC probes

The function plotQCCurves shows plot of quantiles across arrays for each type of
QC probes. We expect the trajectories of quantiles across arrays are horizontal
lines.

To get a better view, the arrays will be sorted based on variables specified

in the function argument varSort.

>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

plotQCCurves(

esQC=es.QC,
probes = c("biotin"), #"cy3_hyb", "housekeeping"),

#"low_stringency_hyb"),
labelVariable = "subjID",
hybName = "Hybridization_Name",
reporterGroupName = "Reporter_Group_Name",
requireLog2 = FALSE,
projectName = "test",
plotOutPutFlag = FALSE,
cex = 1,
ylim = NULL,
xlab = "",
ylab = "log2(intensity)",
lwd = 3,
mar = c(10, 4, 4, 2) + 0.1,
las = 2,
cex.axis = 1,
sortFlag = TRUE,
varSort = c("Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
timeFormat = c("%m/%d/%Y", NA, NA)

)

probes>>
[1] "biotin"

********** k= 1
QC probe= biotin

*******

5

4 Check squared correlations among genetic con-

trol (GC) arrays

Next, we draw heatmap of the squared correlations among GC arrays. We
expect the squared correlations among GC arrays are high (> 0.90).

The function argument labelVariable indicates which meta variable will

be used to label the arrays in the heatmap.

If we draw heatmap for replicated arrays, we can set the function arguments

sortFlag=TRUE,

varSort=c("Subject_ID", "Hybridization_Name",

"Batch_Run_Date", "Chip_Barcode", "Chip_Address")

and

timeFormat=c(NA, NA, "%m/%d/%Y", NA, NA)

so that arrays from the same subjects will be grouped together in the

heatmap.

Note that although the meta variable Batch_Run_Date records time, it is
vector of string character in R. The function R2PlotFunc will automatically

6

biotinlog2(intensity)−4−20246subj2_1subj4_3Hela_5Hela_7subj9_9subj11_11subj13_13subj15_15subj17_17subj19_19subj21_21subj23_23subj25_25subj27_27subj29_29subj31_31subj33_33subj35_35subj37_37subj39_39biotin 1biotin 2biotin 3biotin 4convert it to time variable if we set the value of the argument timeFormat cor-
responding to the variable Batch_Run_Date as a time format like "%m/%d/%Y".
Details about the time format, please see the R function strptime.

The followings show example R code to draw heatmap of GC arrays.

>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

R2PlotFunc(

es=es.raw,
hybName = "Hybridization_Name",
arrayType = "GC",
GCid = c("128115", "Hela", "Brain"),
probs = seq(0, 1, 0.25),
col = gplots::greenred(75),
labelVariable = "subjID",
outFileName = "test_R2_raw.pdf",
title = "Raw Data R^2 Plot",
requireLog2 = FALSE,
plotOutPutFlag = FALSE,
las = 2,
keysize = 1,
margins = c(10, 10),
sortFlag = TRUE,
varSort=c("Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
timeFormat=c("%m/%d/%Y", NA, NA)

)

quantile of R^2>>

100%
4.807015e-06 1.015917e-03 1.675295e-03 4.155686e-03 6.798879e-03

50%

75%

25%

0%

7

5 Exclude GC arrays

We next exclude GC arrays and will focus on sample arrays to check data quality.

> print(table(es.raw$Tissue_Descr, useNA="ifany"))

CD4 Human Hela Cell
4

36

> # for different data sets, the label for GC arrays might
> # be different.
> pos.del<-which(es.raw$Tissue_Descr == "Human Hela Cell")
> cat("No. of GC arrays=", length(pos.del), "\n")

No. of GC arrays= 4

> if(length(pos.del))
+ {
+
+

es.raw<-es.raw[,-pos.del]
es.QC<-es.QC[,-pos.del]

8

Hela_5Hela_6Hela_7Hela_8Hela_8Hela_7Hela_6Hela_5Raw Data R^2 Plot0.21ValueColor Keyprint(dims(es.raw))
print(dims(es.QC))

+
+
+ }

Features
Samples

Features
Samples

exprs
100
36
exprs
10
36

6 Check squared correlations among replicated

arrays

Check squared correlations among replicated arrays (excluding GC arrays). We
expect within subject correlations will be high.

>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

R2PlotFunc(

es=es.raw,
arrayType = c("replicates"),
GCid = c("128115", "Hela", "Brain"),
probs = seq(0, 1, 0.25),
col = gplots::greenred(75),
labelVariable = "subjID",
outFileName = "test_R2_raw.pdf",
title = "Raw Data R^2 Plot",
requireLog2 = FALSE,
plotOutPutFlag = FALSE,
las = 2,
keysize = 1,
margins = c(10, 10),
sortFlag = TRUE,
varSort=c("Subject_ID", "Hybridization_Name", "Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
timeFormat=c(NA, NA, "%m/%d/%Y", NA, NA)

)

quantile of R^2>>

100%
0.007151179 0.007151179 0.007151179 0.751787795 1.000000000

25%

50%

75%

0%

quantile of within-replicate R^2>>

0%
1

25% 50%
1

1

75% 100%
1

1

>

9

7 Obtain plot of estimated density for each array

We next draw plot of estimated density for each array. We expect the estimated
densities of all arrays to be similar. However, for real data, some patterns of the
estimated densities might appear indicating the existence of some batch effects.
Note that by default, the function argument requireLog2 = TRUE. Since
the distributions of simulated data are from normal distribution, we don’t need
to do log2 transformation here.

densityPlots(

es = es.raw,
requireLog2 = FALSE,
myxlab = "expression level",
datExtrFunc = exprs,
fileFlag = FALSE,
fileFormat = "ps",
fileName = "densityPlots_sim.ps")

>
+
+
+
+
+
+
+
>

10

subj2_1subj2_2subj4_3subj4_4subj4_4subj4_3subj2_2subj2_1Raw Data R^2 Plot0.21ValueColor Key8 Obtain plot of quantiles across arrays

We next draw plot of quantiles across sample arrays. We expect the trajecto-
ries of quantiles be horizontal. However, for real data, some patterns of the
trajectories might appear indicating the existence of some batch effects.

Some times, the quantile plots can show that some probes have some outlying

expression levels. In this case, we can delete those gene probes.

Note that by default, the function argument requireLog2 = TRUE. Hence,
we need to take log2 transformation to identify which gene probes containing
outlying expression levels.

By default, we will sort the arrays by the ascending order of the median
absolute deviation (MAD) to have a better view of the trajectories of quantiles.

>
+
+
+
+
+

quantilePlot(

dat=exprs(es.raw),
fileName,
probs = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1),
plotOutPutFlag = FALSE,
requireLog2 = FALSE,

11

−505100.00.10.20.30.40.50.6density plotsexpression levelDensity+
+
+
+
+
+
+
+
+
+
+

sortFlag = TRUE,
cex = 1,
ylim = NULL,
xlab = "",
ylab = "log2(intensity)",
lwd = 3,
main = "Trajectory plot of quantiles\n(sample arrays)",
mar = c(15, 4, 4, 2) + 0.1,
las = 2,
cex.axis = 1
)

***** Arrays were sorted by MAD (median absolute deviation)!

9 Exclude gene probes with outlying expression

levels

if quantile plots show some outlying expression levels, we can use the following
R code to identify the gene probes with outlying expression levels.

12

Trajectory plot of quantiles(sample arrays)log2(intensity)−402468subj28subj27subj29subj30subj21subj23subj24subj39subj38subj35subj40subj15subj9subj14subj13subj2subj10subj40%5%25%50%75%95%100%minVec<-apply(log2(exprs(es.raw)), 1, min, na.rm=TRUE)
# suppose the cutoff is 0.5
print(sum(minVec< 0.5))
pos.del<-which(minVec<0.5)

> # note we need to take log2 transformation
> # if requireLog2 = TRUE.
> requireLog2 = FALSE
> if(requireLog2)
+ {
+
+
+
+
+
+
+
+
+
+
+
+ }
>

es.raw<-es.raw[-pos.del,]

}

cat("Number of gene probes with outlying expression levels>>",
length(pos.del), "\n")
if(length(pos.del))
{

10 Obtain plot of the ratio (p95/p05) of 95-th per-

centile to 5-th percentile across arrays

We next draw the plot of the ratio of p95 over p05 across arrays, where p95
(p05) is the 95-th (5-th) percentile of a array. If an array with the ratio p95/p05
is less than 6, then we regard this array as a bad array and should delete it
before further analysis.

Note that we should set requireLog2 = FALSE.

>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

plotSamplep95p05(
es=es.raw,
labelVariable = "memSubj",
requireLog2 = FALSE,
projectName = "test",
plotOutPutFlag = FALSE,
cex = 1,
ylim = NULL,
xlab = "",
ylab = "",
lwd = 1.5,
mar = c(10, 4, 4, 2) + 0.1,
las = 2,
cex.axis=1.5,
title = "Trajectory of p95/p05",
cex.legend = 1.5,
cex.lab = 1.5,
legendPosition = "topright",
cut1 = 10,
cut2 = 6,
sortFlag = TRUE,

13

+
+
+

varSort = c("Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
timeFormat = c("%m/%d/%Y", NA, NA),
verbose = FALSE)

11 Exclude arrays with p95/p05 ≤ 6
If there exist arrays with p95/p05 < 6, we then need to exclude these arrays
from further data analysis. The followings are example R code:

> p95<-quantile(exprs(es.raw), prob=0.95)
> p05<-quantile(exprs(es.raw), prob=0.05)
> r<-p95/p05
> pos.del<-which(r<6)
> print(pos.del)

95%
1

> if(length(pos.del))
+ {

14

Trajectory of p95/p05p95/p05−600−400−200011111111000000000010es.raw<-es.raw[,-pos.del]
es.QC<-es.QC[,-pos.del]

+
+
+ }
>

12 Obtain Plot of principal components

We next draw pca plots to double check batch effects or treatment effects indi-
cated by dendrogram.

The first step is to obtain principal components using the function getPCAFunc.

For large data set, this function might be very slow.

>
+
+
+
+
+
+
>

pcaObj<-getPCAFunc(es=es.raw,

labelVariable = "subjID",
requireLog2 = FALSE,
corFlag = FALSE

)

We then plot the first 2 or 3 principal components and label the data points
by meta variables of interests, such as tissue type, study center, batch id, etc..

>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

pca2DPlot(pcaObj=pcaObj,

plot.dim = c(1,2),
labelVariable = "memSubj",
outFileName = "test_pca_raw.pdf",
title = "Scatter plot of pcas (memSubj)",
plotOutPutFlag = FALSE,
mar = c(5, 4, 4, 2) + 0.1,
lwd = 1.5,
equalRange = TRUE,
xlab = NULL,
ylab = NULL,
xlim = NULL,
ylim = NULL,
cex.legend = 1.5,
cex = 1.5,
cex.lab = 1.5,
cex.axis = 1.5,
legendPosition = "topright"

)

15

13 Perform background correction, data trans-

formation and normalization

> tt <- es.raw
> es.q<-lumiN(tt, method="quantile")

Perform quantile normalization ...

14 Obtain Plot of principal components for pre-

processed data

After pre-processing data, we do principal component analysis again.

Note that we should set requireLog2 = FALSE.

>
+
+
+

pcaObj<-getPCAFunc(es=es.q,

labelVariable = "subjID",
requireLog2 = FALSE,
corFlag = FALSE

16

−20−1001020−20−1001020pc1 (R2=0.79)pc2 (R2=0.03)Scatter plot of pcas (memSubj)10+
+
>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
>

)
pca2DPlot(pcaObj=pcaObj,

plot.dim = c(1,2),
labelVariable = "memSubj",
outFileName = "test_pca_raw.pdf",
title = "Scatter plot of pcas (memSubj)\n(log2 transformed and quantile normalized)",
plotOutPutFlag = FALSE,
mar = c(5, 4, 4, 2) + 0.1,
lwd = 1.5,
equalRange = TRUE,
xlab = NULL,
ylab = NULL,
xlim = NULL,
ylim = NULL,
cex.legend = 1.5,
cex = 1.5,
cex.lab = 1.5,
cex.axis = 1.5,
legendPosition = "topright"
)

17

15

Incorporate phenotype data

In addition meta data, we usually have phenotype data to describe subjects.
We can now add them in.

16 Data analysis

16.1

lmFitWrapper and lmFitPaired

iCheck provide 2 limma wrapper functions lmFitPaired (for paired data) and
lmFitWrapper (for unpaired data).

Note that the function argument pos.var.interest = 1 requests the re-

sults (test statistic and p-value) for the first covariate will be print out.

If pos.var.interest = 0, then the results (test statistic and p-value) for

the intercept will be print out.

The outcome variable must be gene probes. Can not be phenotype variables.

> res.limma=lmFitWrapper(
+

es=es.q,

18

−505−505pc1 (R2=0.09)pc2 (R2=0.07)Scatter plot of pcas (memSubj)(log2 transformed and quantile normalized)10+
+
+
+
+
+
+
+

formula=~as.factor(memSubj),
pos.var.interest = 1,
pvalAdjMethod="fdr",
alpha=0.05,
probeID.var="probe",
gene.var="gene",
chr.var="chr",
verbose=TRUE)

dim(dat)>>
[1] 100 35

Running lmFit...
Running eBayes...
Preparing output...

probeIDs geneSymbols chr

stats

pval

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
18
19
20

probe29
probe16
probe92
probe59
probe32
probe17
probe103
probe35
probe54
probe74
probe40
probe61
probe12
probe56
probe90
probe79
probe89
probe38
probe96
probe23

gene29
gene16
gene92
gene59
gene32
gene17
gene103
gene35
gene54
gene74
gene40
gene61
gene12
gene56
gene90
gene79
gene89
gene38
gene96
gene23

1 -3.376879 0.001401733 0.1005857
3.254099 0.002011714 0.1005857
1
1
2.688895 0.009634725 0.3211575
1 -2.210193 0.031558408 0.4968483
1
2.181275 0.033750422 0.4968483
1 -2.143605 0.036806038 0.4968483
1 -2.117636 0.039051322 0.4968483
1 -2.109845 0.039747866 0.4968483
1
1.712229 0.092867773 0.8375408
1 -1.703176 0.094560774 0.8375408
1
1.638282 0.107456092 0.8375408
1 -1.604613 0.114691882 0.8375408
1
1.527377 0.132783363 0.8375408
1 -1.521438 0.134263881 0.8375408
1 -1.445861 0.154271925 0.8375408
1 -1.406303 0.165637004 0.8375408
1 -1.367624 0.177366059 0.8375408
1
1.360555 0.179576911 0.8375408
1 -1.351534 0.182428796 0.8375408
1.347172 0.183820114 0.8375408
1

p.adj pos
19
6
82
49
22
7
93
25
44
64
30
51
2
46
80
69
79
28
86
13

pvalue quantiles for intercept and covariates>>
(Intercept) as.factor(memSubj)1
0.001401733
0.242102862
0.455084256
0.780677827
0.998200667

0.0002637651
min
25%
0.0356690890
median 0.1922335675
0.4874162700
75%
0.9978539142
max

formula>>
~as.factor(memSubj)

covariate of interest is
Number of tests= 100

as.factor(memSubj)

19

Number of arrays= 35
Number of significant tests (raw p-value <
Number of significant tests after p-value adjustments= 0

0.05 )= 8

**********************************************
No genes are differentially expressed!

>

16.2

glmWrapper

outcome variable can be phenotype variables. The function argument family
indicates if logistic regression (family=binomial) used or general linear regres-
sion (family=gaussian) used.

> res.glm=glmWrapper(
+
+
+
+
+
+
+
+
+
+
+
+
+

es=es.q,
formula = xi~as.factor(memSubj),
pos.var.interest = 1,
family=gaussian,
logit=FALSE,
pvalAdjMethod="fdr",
alpha = 0.05,
probeID.var = "probe",
gene.var = "gene",
chr.var = "chr",
applier=lapply,
verbose=TRUE
)

coef

pval

stats

p.adj pos
probeIDs geneSymbols chr
1
6
3.305320 1.0593407 0.002293003 0.1763387
1 -3.142649 -1.3263843 0.003526774 0.1763387 19
82
2.508446 1.0489929 0.017219384 0.5739795
1
1 -2.238212 -0.7231024 0.032072229 0.6917895 49
1 -2.173225 -0.6718451 0.037042472 0.6917895 25
93
1 -2.121164 -0.7059218 0.041507370 0.6917895
1 -2.029732 -0.8040525 0.050510402 0.7215772
7
22
1.915186 1.0631079 0.064169227 0.8021153
1
1 -1.786253 -0.5282879 0.083249917 0.8072836 64
1 -1.725751 -0.4815208 0.093746106 0.8072836 51
1
1.633937 0.6301915 0.111777893 0.8072836 44
1.609611 0.5661679 0.117008899 0.8072836 30
1
1 -1.605115 -0.4182303 0.117997257 0.8072836 80
1
1.542007 0.3851935 0.132607854 0.8072836 28
1 -1.464652 -0.5487800 0.152478453 0.8072836 46
1.405098 0.3951053 0.169336626 0.8072836 89
1
1 -1.380558 -0.3907145 0.176695014 0.8072836
98
1 -1.339224 -0.5201586 0.189649429 0.8072836 69
2
1.333659 0.7656150 0.191448222 0.8072836
1

probe16
1
probe29
2
probe92
3
probe59
4
probe35
5
probe103
6
probe17
7
probe32
8
probe74
9
probe61
10
probe54
11
probe40
12
probe90
13
probe38
14
probe56
15
probe99
16
17 probe108
probe79
18
probe12
19

gene16
gene29
gene92
gene59
gene35
gene103
gene17
gene32
gene74
gene61
gene54
gene40
gene90
gene38
gene56
gene99
gene108
gene79
gene12

20

20

probe44

gene44

1

1.304127 0.3796869 0.201213900 0.8072836 34

pvalue quantiles for intercept and covariates>>

min
25%
median
75%
max

pval.(Intercept) pval.as.factor(memSubj)1
0.002293003
0.237742030
0.444338213
0.784209263
0.998167350

0.0006238292
0.0245832240
0.1952130722
0.5048805444
0.9980082033

formula>>
xi ~ as.factor(memSubj)

as.factor(memSubj)

covariate of interest is
Number of tests= 100
Number of arrays= 35
Number of significant tests (raw p-value <
Number of significant tests after p-value adjustments= 0

0.05 )= 6

**********************************************
No genes are differentially expressed!

>

16.3

lkhrWrapper

Likelihood ratio test wrapper. Compare 2 glm models. One is reduced model.
The other is full model.

> res.lkh=lkhrWrapper(
+
+
+
+
+
+
+
+
+
+
+
+
+

es=es.q,
formulaReduced = xi~as.factor(memSubj),
formulaFull = xi~as.factor(memSubj)+gender,
family=gaussian,
logit=FALSE,
pvalAdjMethod="fdr",
alpha = 0.05,
probeID.var = "probe",
gene.var = "gene",
chr.var = "chr",
applier=lapply,
verbose=TRUE
)

*********************************

Top

20 tests>>>

probeIDs geneSymbols chr

20
34

probe30
probe44

gene30
gene44

1 7.665514
1 6.674654

21

Chisq Df

pval
1 0.005628622 0.4115445
1 0.009779351 0.4115445

p.adj pos
20
34

probe80
70
probe46
36
probe15
5
probe88
78
probe52
42
probe83
73
probe43
33
probe96
86
probe48
38
probe32
22
29
probe39
94 probe104
4
probe14
probe36
26
98 probe108
probe62
52
probe18
8
probe85
75

gene80
gene46
gene15
gene88
gene52
gene83
gene43
gene96
gene48
gene32
gene39
gene104
gene14
gene36
gene108
gene62
gene18
gene85

1 5.787806
1 5.697967
1 5.362249
1 4.471478
1 4.087700
1 3.553840
1 3.402508
1 3.352279
1 3.179674
1 3.061740
1 2.909647
1 2.901516
1 2.851523
1 2.846647
1 2.738579
1 2.504063
1 2.171881
1 2.156022

1 0.016137715 0.4115445
1 0.016984571 0.4115445
1 0.020577223 0.4115445
1 0.034465173 0.5722795
1 0.043196384 0.5722795
1 0.059407808 0.5722795
1 0.065097366 0.5722795
1 0.067112049 0.5722795
1 0.074559584 0.5722795
1 0.080155786 0.5722795
1 0.088051166 0.5722795
1 0.088496307 0.5722795
1 0.091287395 0.5722795
1 0.091564723 0.5722795
1 0.097951851 0.5761874
1 0.113553018 0.6308501
1 0.140554180 0.6973549
1 0.142011926 0.6973549

70
36
5
78
42
73
33
86
38
22
29
94
4
26
98
52
8
75

formulaReduced>>
xi ~ as.factor(memSubj)

formulaFull>>
xi ~ as.factor(memSubj) + gender

Number of tests>>> 100

Number of arrays>>> 35

Number of tests with pvalue<0.05>>> 7

Number of tests with FDR adjusted pvalue<0.05>>> 0

>

17 Result Visualization

Once we get analysis results, we need to check if the results are reasonable or
not (e.g,were results affected by outliers?).

If the phenotype variable of interest is a binary type variable, then we can
draw parallel boxplots of expression level versus the phenotype for each of top
results. iCheck provides function boxPlots to do such a task.

>
+
+
+
+

boxPlots(

resFrame = res.limma$frame,
es = es.sim,
col.resFrame = c("probeIDs", "stats", "pval", "p.adj"),
var.pheno = "memSubj",

22

+
+
+
+
+
+
+
+
+
>

var.probe = "probe",
var.gene = "gene",
var.chr = "chr",
nTop = 20,
myylab = "expression level",
datExtrFunc = exprs,
fileFlag = FALSE,
fileFormat = "ps",
fileName = "boxPlots_sim.ps")

If the phenotype variable of interest is a continous type variable, then we
can draw scatter plot of expression level versus the phenotype for each of top
results. iCheck provides function scatterPlots to do such a task.

>
>
+
+
+
+
+

# regard memSubj as continuos for illustration purpose
scatterPlots(

resFrame = res.limma$frame,
es = es.sim,
col.resFrame = c("probeIDs", "stats", "pval", "p.adj"),
var.pheno = "memSubj",
var.probe = "probe",

23

01−2024boxplot of memSubjprobe29(gene29, chr=1)stat=−3.38, pval=1.4e−03, p.adj=1.0e−01expression level+
+
+
+
+
+
+
+
>

var.gene = "gene",
var.chr = "chr",
nTop = 20,
myylab = "expression level",
datExtrFunc = exprs,
fileFlag = FALSE,
fileFormat = "ps",
fileName = "scatterPlots_sim.ps")

18 Session Info

Finally, we need to print out the session info so that later we can know which
versions the packages are from.

> toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,

24

0.00.20.40.60.81.0−2024scatterplot of memSubjprobe29(gene29, chr=1)stat=−3.38, pval=1.4e−03, p.adj=1.0e−01memSubjexpression levelLC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK:

/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, generics 0.1.4,

gplots 3.2.0, iCheck 1.40.0, lumi 2.62.0

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0,

BiocIO 1.20.0, BiocManager 1.30.26, BiocParallel 1.44.0,
Biostrings 2.78.0, DBI 1.2.3, DelayedArray 0.36.0,
DelayedMatrixStats 1.32.0, GEOquery 2.78.0, GeneSelectMMD 2.54.0,
GenomeInfoDb 1.46.0, GenomicAlignments 1.46.0,
GenomicFeatures 1.62.0, GenomicRanges 1.62.0, HDF5Array 1.38.0,
IRanges 2.44.0, KEGGREST 1.50.0, KernSmooth 2.23-26, MASS 7.3-65,
Matrix 1.7-4, MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3,
RCurl 1.98-1.17, RSQLite 2.4.3, Rcpp 1.1.0, Rhdf5lib 1.32.0,
Rsamtools 2.26.0, Rttf2pt1 1.3.14, S4Arrays 1.10.0, S4Vectors 0.48.0,
Seqinfo 1.0.0, SparseArray 1.10.0, SummarizedExperiment 1.40.0,
UCSC.utils 1.6.0, XML 3.99-0.19, XVector 0.50.0, abind 1.4-8,
affy 1.88.0, affyio 1.80.0, annotate 1.88.0, askpass 1.2.1, base64 2.0.2,
base64enc 0.1-3, beanplot 1.3.1, bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9,
blob 1.2.4, bumphunter 1.52.0, caTools 1.18.3, cachem 1.1.0,
cigarillo 1.0.0, cli 3.6.5, codetools 0.2-20, compiler 4.5.1, crayon 1.5.3,
curl 7.0.0, data.table 1.17.8, digest 0.6.37, doRNG 1.8.6.2, dplyr 1.1.4,
evaluate 1.0.5, extrafont 0.20, extrafontdb 1.1, fastmap 1.2.0,
foreach 1.5.2, genefilter 1.92.0, glue 1.8.0, grid 4.5.1, gtools 3.9.5,
h5mread 1.2.0, hms 1.1.4, htmltools 0.5.8.1, htmlwidgets 1.6.4, httr 1.4.7,
illuminaio 0.52.0, iterators 1.0.14, jsonlite 2.0.0, knitr 1.50, lattice 0.22-7,
lifecycle 1.0.4, limma 3.66.0, lmtest 0.9-40, locfit 1.5-9.12, magrittr 2.0.4,
matrixStats 1.5.0, mclust 6.1.1, memoise 2.0.1, methylumi 2.56.0,
mgcv 1.9-3, minfi 1.56.0, multtest 2.66.0, nleqslv 3.3.5, nlme 3.1-168,
nor1mix 1.3-3, openssl 2.3.4, parallel 4.5.1, pillar 1.11.1, pkgconfig 2.0.3,
plyr 1.8.9, png 0.1-8, preprocessCore 1.72.0, purrr 1.1.0, quadprog 1.5-8,
randomForest 4.7-1.2, readr 2.1.5, rentrez 1.2.4, reshape 0.8.10,
restfulr 0.0.16, rgl 1.3.24, rhdf5 2.54.0, rhdf5filters 1.22.0, rjson 0.2.23,
rlang 1.1.6, rngtools 1.5.2, rtracklayer 1.70.0, scatterplot3d 0.3-44,
scrime 1.3.5, siggenes 1.84.0, sparseMatrixStats 1.22.0, splines 4.5.1,
statmod 1.5.1, stats4 4.5.1, survival 3.8-3, tibble 3.3.0, tidyr 1.3.1,
tidyselect 1.2.1, tools 4.5.1, tzdb 0.5.0, vctrs 0.6.5, xfun 0.53, xml2 1.4.1,
xtable 1.8-4, yaml 2.3.10, zoo 1.8-14

25

