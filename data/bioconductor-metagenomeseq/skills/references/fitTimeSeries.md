fitTimeSeries: Longitudinal differential abundance
analysis for marker-gene surveys

Hisham Talukder, Joseph N. Paulson, Hector Corrada Bravo

Applied Mathematics & Statistics, and Scientific Computation
Center for Bioinformatics and Computational Biology
University of Maryland, College Park

jpaulson@umiacs.umd.edu

Modified: February 18, 2015. Compiled: October 30, 2025

Contents

1 Introduction

1.1 Problem Formulation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Data preparation

2.1 Example datasets . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Creating a MRexperiment object with other measurements
. . . . . . . . . . .

3 Time series analysis

3.1 Paramaters . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Visualization of features

5 Summary

5.1 Citing fitTimeSeries
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 Session Info . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2

3
3
4

6
8

9

10
10
11

1

1 Introduction

This is a vignette specifically for the fitTimeSeries function. For a full list of func-
tions available in the package: help(package=metagenomeSeq). For more informa-
tion about a particular function call: ?function.

Smoothing spline regression models [1] are commonly used to model longitudinal data and
form the basis for methods used in a large number of applications [2,3]. Specifically, an extension
of the methodology called Smoothing-Spline ANOVA [4] is capable of directly estimating a
smooth function of interest while incorporating other covariates in the model.

A common approach to detect regions/times of interest in a genome or for differential abun-
dance is to model differences between two groups with respect to the quantitative measurements
as smooth functions and perform statistical inference on these models. In particular, widely used
methods for region finding using DNA methylation data use local regression methods to estimate
these smooth functions. An important aspect of these tools is their ability to incorporate sample
characteristics as covariates in these models, e.g., sex and age in population studies, or tech-
nical factors like processing batches. Incorporating these sources of variability, both biological
and technical is essential in high-throughput studies. Therefore, these methods require that the
models used are capable of estimating both smooth functions and sample-specfic characteristics.
We present fitTimeSeries - a method for estimating and detecting regions/times of interest due
to differential abundance of a quantitative measurement (for example, normalized abundance).

1.1 Problem Formulation

We model data in the following form:

Yitk = fi(t, xk) + etk

where i represents group factor (diet, health status, etc.), t represents series factor (for example,
time or location), k represents replicate observations, xk are covariates for sample k (including an
indicator for group membership I{k ∈ i}) and etk are independent N (0, σ2) errors. We assume
fi to be a smooth function, defined in an interval [a, b], that can be parametric, non-parametric
or a mixture of both.

Our goal is to identify intervals where the absolute difference between two groups ηd(t) =
f1(t, ·)−f2(t, ·) is large, that is, regions, Rt1,t2, where: Rt1,t2 = {t1, t2 ∈ x such that |ηd(x)| ≥ C}
and C is a predefined constant threshold.

To identify these areas we use hypothesis testing using the area At1,t2 = (cid:82)
Rt1,t2
the estimated function of ηd(t) as a statistic with null and alternative hypotheses

ηd(t)dt under

H0 : At1,t2 ≤ K

H1 : At1,t2 > K

with K some fixed threshold.

We employ a permutation-based method to calculate a null distribution of the area statistics
A(t1, t2)’s. To do this, the group-membership indicator variables (0-1 binary variable) are
randomly permuted B times, e.g., B = 1000 and the method above is used to estimate the
d (in this case simulating the null hypothesis) and an area statistics A(t1, t2)b
difference function ηb
for each random permutation. Estimates A(t1, t2)b are then used to construct an empirical
estimate of A(t1, t2) under the null hypothesis. The observed area, A(t1, t2)∗, is compared to the
empirical null distribution to calculate a p-value. Figure 1 illustrates the relationship between
R(t1, t2) and A(t1, t2). The key is to estimate regions R(t1, t2) where point-wise confidence
intervals would be appropriate.

2

2 Data preparation

Data should be preprocessed and prepared in tab-delimited files. Measurements are stored in
a matrix with samples along the columns and features along the rows. For example, given m
features and n samples, the entries in a marker-gene or metagenomic count matrix C (m, n), cij,
are the number of reads annotated for a particular feature i (whether it be OTU, species, genus,
etc.) in sample j. Alternatively, the measurements could be some quantitative measurement
such as methylation percentages or CD4 levels.

f eature1
f eature2
...
f eaturem









sample1
c11
c21
...
cm1

sample2
c12
c22
...
cm2

. . .
. . .
. . .
. . .
. . .

samplen
c1n
c2n
...
cmn









Data should be stored in a file (tab-delimited by default) with sample names along the
first row, feature names in the first column and should be loaded into R and formatted into a
MRexperiment object. To prepare the data please read the section on data preparation in the
full metagenomeSeq vignette - vignette("metagenomeSeq").

2.1 Example datasets

There is a time-series dataset included as an examples in the metagenomeSeq package. Data
needs to be in a MRexperiment object format to normalize, run the statistical tests, and visu-
alize. As an example, throughout the vignette we’ll use the following datasets. To understand
a fitTimeSeries’s usage or included data simply enter ?fitTimeSeries.

library(metagenomeSeq)
library(gss)

2. Humanized gnotobiotic mouse gut [5]: Twelve germ-free adult male C57BL/6J mice were
fed a low-fat, plant polysaccharide-rich diet. Each mouse was gavaged with healthy adult
human fecal material. Following the fecal transplant, mice remained on the low-fat, plant
polysacchaaride-rich diet for four weeks, following which a subset of 6 were switched to a
high-fat and high-sugar diet for eight weeks. Fecal samples for each mouse went through
PCR amplification of the bacterial 16S rRNA gene V2 region weekly. Details of exper-
imental protocols and further details of the data can be found in Turnbaugh et. al.
Sequences and further information can be found at: http://gordonlab.wustl.edu/
TurnbaughSE_10_09/STM_2009.html

data(mouseData)
mouseData

element names: counts

## MRexperiment (storageMode: environment)
## assayData: 10172 features, 139 samples
##
## protocolData: none
## phenoData
##
##

(139 total)

sampleNames: PM1:20080107 PM1:20080108 ... PM9:20080303

3

featureNames: Prevotellaceae:1 Lachnospiraceae:1 ...

varLabels: mouseID date ... status (5 total)
varMetadata: labelDescription

##
##
## featureData
##
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

fvarLabels: superkingdom phylum ... OTU (7 total)
fvarMetadata: labelDescription

Parabacteroides:956 (10172 total)

2.2 Creating a MRexperiment object with other measurements

For a fitTimeSeries analysis a minimal MRexperiment-object is required and can be created using
the function newMRexperiment which takes a count matrix described above and phenoData
(annotated data frame). Biobase provides functions to create annotated data frames.

# Creating mock sample replicates
sampleID = rep(paste("sample", 1:10, sep = ":"), times = 20)
# Creating mock class membership
class = rep(c(rep(0, 5), rep(1, 5)), times = 20)
# Creating mock time
time = rep(1:20, each = 10)

phenotypeData = AnnotatedDataFrame(data.frame(sampleID, class, time))
# Creating mock abundances
set.seed(1)
# No difference
measurement1 = rnorm(200, mean = 100, sd = 1)
# Some difference
measurement2 = rnorm(200, mean = 100, sd = 1)
measurement2[1:5] = measurement2[1:5] + 100
measurement2[11:15] = measurement2[11:15] + 100
measurement2[21:25] = measurement2[21:25] + 50
mat = rbind(measurement1, measurement2)
colnames(mat) = 1:200
mat[1:2, 1:10]

1

2
99.37355 100.1836

5
##
## measurement1
99.16437 101.5953 100.3295
## measurement2 200.40940 201.6889 201.58659 199.6691 197.7148
10
##
## measurement1
99.69461
## measurement2 102.49766 100.6671 100.5413 99.9866 100.51011

9
99.17953 100.4874 100.7383 100.5758

3

4

8

7

6

If phylogenetic information exists for the features and there is a desire to aggregate measure-
ments based on similar annotations choosing the featureData column name in lvl will aggregate
measurements using the default parameters in the aggregateByTaxonomy function.

# This is an example of potential lvl's to aggregate by.
data(mouseData)
colnames(fData(mouseData))

4

## [1] "superkingdom" "phylum"
## [5] "family"

"genus"

"class"
"OTU"

"order"

Here we create the actual MRexperiment to run through fitTimeSeries.

obj = newMRexperiment(counts=mat,phenoData=phenotypeData)
obj

element names: counts

## MRexperiment (storageMode: environment)
## assayData: 2 features, 200 samples
##
## protocolData: none
## phenoData
##
##
##
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation:

sampleNames: 1 2 ... 200 (200 total)
varLabels: sampleID class time
varMetadata: labelDescription

res1 = fitTimeSeries(obj,feature=1,

class='class',time='time',id='sampleID',
B=10,norm=FALSE,log=FALSE)

res2 = fitTimeSeries(obj,feature=2,

class='class',time='time',id='sampleID',
B=10,norm=FALSE,log=FALSE)

classInfo = factor(res1$data$class)

par(mfrow=c(3,1))
plotClassTimeSeries(res1,pch=21,bg=classInfo)
plotTimeSeries(res2)
plotClassTimeSeries(res2,pch=21,bg=classInfo)

5

3 Time series analysis

Implemented in the fitTimeSeries function is a method for calculating time intervals for
which bacteria are differentially abundant. Fitting is performed using Smoothing Splines ANOVA
(SS-ANOVA), as implemented in the gss package. Given observations at multiple time points
for two groups the method calculates a function modeling the difference in abundance across all
time. Using group membership permutations we estimate a null distribution of areas under the
difference curve for the time intervals of interest and report significant intervals of time. Here
we provide a real example from the microbiome of two groups of mice on different diets.

The gnotobiotic mice come from a longitudinal study ideal for this type of analysis. We
choose to perform our analysis at the class level and look for differentially abundant time intervals
for ”Actinobacteria”. For demonstrations sake we perform only 10 permutations.

If you find the method useful, please cite: ”Longitudinal differential abundance analysis for

marker-gene surveys” Talukder H*, Paulson JN*, Bravo HC. (Submitted)

6

51015209899101TimeAbundance5101520−100−60−20SS difference function predictionTimeDifference in abundance5101520100140180TimeAbundanceres = fitTimeSeries(obj = mouseData, lvl = "class", feature = "Actinobacteria",

class = "status", id = "mouseID", time = "relativeTime", B = 10)

# We observe a time period of differential abundance for
# 'Actinobacteria'
res$timeIntervals

Interval start Interval end
9

p.value
50 92.32485 0.09090909

Area

##
## [1,]

str(res)

9 variables:

:'data.frame': 139 obs. of

..- attr(*, "dimnames")=List of 2
.. ..$ : NULL
.. ..$ : chr [1:4] "Interval start" "Interval end" "Area" "p.value"

## List of 5
## $ timeIntervals: num [1, 1:4] 9 50 92.3249 0.0909
##
##
##
## $ data
##
##
##
##
##
##
##
##
##
## $ fit
##
##
##
## $ perm
## $ call

..$ abundance
..$ class
..$ time
..$ id
..$ mouseID
..$ date
..$ diet
..$ relativeTime: num [1:139] 21 22 28 0 35 6 42 49 56 63 ...
..$ status

..$ fit
..$ se
..$ timePoints: num [1:78] 0 1 2 3 4 5 6 7 8 9 ...

:'data.frame': 78 obs. of
: num [1:78] 0.351 0.487 0.619 0.75 0.878 ...
: num [1:78] 1.091 1.024 0.966 0.916 0.875 ...

: num [1:139] 0 3.82 3.13 7.4 0 ...
: Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...
: num [1:139] 21 22 28 0 35 6 42 49 56 63 ...
: Factor w/ 12 levels "PM1","PM10","PM11",..: 1 1 1 1 1 1 1 1 1 1 ...
: Factor w/ 12 levels "PM1","PM10","PM11",..: 1 1 1 1 1 1 1 1 1 1 ...
: Date[1:139], format: "2008-01-07" ...
: chr [1:139] "BK" "BK" "BK" "BK" ...

: num [1:10, 1] 2.9 12.5 12.1 -30.5 -36.5 ...
: language fitTimeSeries(obj = mouseData, feature = "Actinobacteria",

: Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...

3 variables:

For example, to test every class in the mouse dataset:

set.seed(123)
classes = unique(fData(mouseData)[,"class"])

timeSeriesFits = lapply(classes,function(i){
fitTimeSeries(obj=mouseData,

feature=i,
class="status",
id="mouseID",
time="relativeTime",
lvl='class',
C=.3,# a cutoff for 'interesting'
B=1) # B is the number of permutations and should clearly not be 1

})

names(timeSeriesFits) = classes

# Removing classes of bacteria without a potentially

7

class = "status", time = "relativeTime", id = "mouseID",

...

# interesting time interval difference.
timeSeriesFits = lapply(timeSeriesFits,function(i){i[[1]]})[-grep("No",timeSeriesFits)]

# Naming the various interesting time intervals.
for(i in 1:length(timeSeriesFits)){
rownames(timeSeriesFits[[i]]) =

paste(

paste(names(timeSeriesFits)[i]," interval",sep=""),
1:nrow(timeSeriesFits[[i]]),sep=":"

)

}

# Merging into a table.
timeSeriesFits = do.call(rbind,timeSeriesFits)

# Correcting for multiple testing.
pvalues = timeSeriesFits[,"p.value"]
adjPvalues = p.adjust(pvalues,"bonferroni")
timeSeriesFits = cbind(timeSeriesFits,adjPvalues)

head(timeSeriesFits)

##
## Bacteroidetes interval:1
## Bacteroidetes interval:2
## Bacilli interval:1
## Erysipelotrichi interval:1
## Betaproteobacteria interval:1
## Epsilonproteobacteria interval:1
##
## Bacteroidetes interval:1
## Bacteroidetes interval:2
## Bacilli interval:1
## Erysipelotrichi interval:1
## Betaproteobacteria interval:1
## Epsilonproteobacteria interval:1

Interval start Interval end
20
17
77
22
77
21
77
16
33
24
22
17

10.422590
-117.021102
471.995974
115.957380
-21.148064
-3.261411

Area p.value adjPvalues
1
1
1
1
1
1

0.5
0.5
0.5
0.5
0.5
0.5

Please see the help page for fitTimeSeries for parameters. Note, only two groups can be
compared to each other and the time parameter must be an actual value (currently no support
for posix, etc.).

3.1 Paramaters

There are a number of parameters for the fitTimeSeries function. We list and provide a brief
discussion below. For parameters influencing ssanova, aggregateByTaxonomy, MRcounts
type ?function for more details.

• obj - the metagenomeSeq MRexperiment-class object.

• feature - Name or row of feature of interest.

• class - Name of column in phenoData of MRexperiment-class object for class memberhip.

• time - Name of column in phenoData of MRexperiment-class object for relative time.

8

• id - Name of column in phenoData of MRexperiment-class object for sample id.

• method - Method to estimate time intervals of differentially abundant bacteria (only

ssanova method implemented currently).

• lvl - Vector or name of column in featureData of MRexperiment-class object for aggregating

counts (if not OTU level).

• C - Value for which difference function has to be larger or smaller than (default 0).

• B - Number of permutations to perform (default 1000)

• norm - When aggregating counts to normalize or not. (see MRcounts)

• log - Log2 transform. (see MRcounts)

• sl - Scaling value. (see MRcounts)

• ... - Options for ssanova

4 Visualization of features

To help with visualization and analysis of datasets metagenomeSeq has several plotting func-
tions to gain insight of the model fits and the differentially abundant time intervals using
plotClassTimeSeries and plotTimeSeries on the result. More plots will be updated.

par(mfrow = c(2, 1))
plotClassTimeSeries(res, pch = 21, bg = res$data$class, ylim = c(0,

8))

plotTimeSeries(res)

9

5 Summary

metagenomeSeq’s fitTimeSeries is a novel methodology for differential abundance testing
of longitudinal data. If you make use of the statistical method please cite our paper. If you
made use of the manual/software, please cite the manual/software!

5.1 Citing fitTimeSeries

citation("metagenomeSeq")

## To cite the original statistical method and normalization
## method implemented in metagenomeSeq use
##
##
##

Paulson JN, Stine OC, Bravo HC, Pop M (2013).
"Differential abundance analysis for microbial

10

02040608002468TimeAbundance020406080−2024SS difference function predictionTimeDifference in abundancemarker-gene surveys." _Nat Meth_, *advance online
publication*. doi:10.1038/nmeth.2658
<https://doi.org/10.1038/nmeth.2658>,
<http://www.nature.com/nmeth/journal/vaop/ncurrent/abs/nmeth.2658.html>.

Paulson JN, Olson ND, Braccia DJ, Wagner J, Talukder H,
Pop M, Bravo HC (2013). _metagenomeSeq: Statistical
analysis for sparse high-throughput sequncing._.
Bioconductor package,
<http://www.cbcb.umd.edu/software/metagenomeSeq>.

##
##
##
##
##
## To cite the metagenomeSeq software/vignette guide use
##
##
##
##
##
##
##
## To cite time series analysis/function fitTimeSeries use
##
##
##
##
##
##
##
##
## To see these entries in BibTeX format, use
## 'print(<citation>, bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.

Paulson* JN, Talukder* H, Bravo HC (2017).
"Longitudinal differential abundance analysis of
marker-gene surveys using smoothing splines."
_biorxiv_. doi:10.1101/099457
<https://doi.org/10.1101/099457>,
<https://www.biorxiv.org/content/10.1101/099457v1>.

5.2 Session Info

sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

11

LAPACK version 3.12.0

datasets

methods

graphics

grDevices utils

metagenomeSeq_1.52.0
glmnet_4.1-10
limma_3.66.0
BiocGenerics_0.56.0
knitr_1.50

## [1] stats
## [7] base
##
## other attached packages:
## [1] gss_2.2-9
## [3] RColorBrewer_1.1-3
## [5] Matrix_1.7-4
## [7] Biobase_2.70.0
## [9] generics_0.1.4
##
## loaded via a namespace (and not attached):
## [1] gplots_3.2.0
## [4] KernSmooth_2.23-26 highr_0.11
## [7] statmod_1.5.1
## [10] grid_4.5.1
## [13] bitops_1.0-9
## [16] codetools_0.2-20
## [19] parallel_4.5.1
## [22] tools_4.5.1
## [25] survival_3.8-3

formatR_1.14
caTools_1.18.3
foreach_1.5.2
Rcpp_1.1.0
splines_4.5.1
iterators_1.0.14

xfun_0.53

Wrench_1.28.0
gtools_3.9.5
locfit_1.5-9.12
evaluate_1.0.5
compiler_4.5.1
lattice_0.22-7
shape_1.4.6.1
matrixStats_1.5.0

References

[1] G. Wahba. Spline Models in Statistics. CBMS-NSF Regional Conference Series. SIAM,

Philadelphia, PA, 1990.

[2] H´ector Corrada Bravo. Graph-based data analysis: tree-structured covariance estimation,
prediction by regularized kernel estimation and aggregate database query processing for prob-
abilistic inference. ProQuest, 2008.

[3] H. Jaroslaw, N. Elena, and M.L. Nan. Longcrisp: A test for bumphunting in longitudinal

data. Statistics in Medicine, 26:1383–1397, 2006.

[4] C. Gu. Smoothing Spline Anova Model. Springer Series in Statistics. Springer, 2002.

[5] Peter J Turnbaugh, Vanessa K Ridaura, Jeremiah J Faith, Federico E Rey, Rob Knight, and
Jeffrey I Gordon. The effect of diet on the human gut microbiome: a metagenomic analysis
in humanized gnotobiotic mice. Science translational medicine, 1(6):6ra14, 2009.

12

