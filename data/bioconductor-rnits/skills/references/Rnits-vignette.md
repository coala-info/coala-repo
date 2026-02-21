The Rnits package for normalization and in-
ference of differential expression in time se-
ries microarray data.

Dipen P. Sangurdekar 1

October 30, 2025

Contents

1

2

3

Introduction .

Method .

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

2.1

2.2

2.3

2.4

2.5

Data preprocessing and normalization.

B-spline basis model based hypothesis testing.

Clustering .

.

.

.

.

.

.

.

.

Candidate model evaluation.

Model Selection .

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

Expression profiling in Yeast in a chemostat perturbation ex-
periment .
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

3.1

3.2

Data preparation .

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

Running Rnits .
3.2.1
3.2.2
3.2.3

.
.
Build Rnits object from ExpressionSet or data matrix .
.
Fitting the model .
.
.
.
.
Get top genes and other fit summary statistics .

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

4

Summary .

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

1

Introduction

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

1

2

2

2

3

3

4

4

5

7
7
9
10

13

Gene expression studies interrogating various specific aspects of cellular physiology – cell
cycle regulation, dynamic response to perturbations or natural circadian rhythms – involve
samples being collected over a time series. A number of methods have been developed to
infer differentially expressed genes from temporal transcriptional data. One class of methods
involves extending static differential expression methods like ANOVA ([1]) and empirical
Bayes ([2, 3]) to temporal data sets. Another approach is to use functional data analysis
methods to model the time series data as linear combinations of basis functions (splines)

1dipen.sangurdekar@gmail.com

The Rnits package for normalization and inference of differential expression in time series microarray data.

([4, 5, 6, 7, 8, 9]). Differential expression is then inferred by hypothesis testing on the basis
coefficients, empirical Bayes analysis ([10, 11]) or by hypothesis testing between two groups
([5, 9, 12, 8, 13])

The method proposed by [8] and [9] utilizes a model driven approach to infer differential
expression. The null hypothesis is that for a given gene, the difference in profiles between
two treatments (or their deviation from the population average for the gene) is random. They
model this scenario by fitting a single average curve, constructed from natural cubic spline
basis curves, onto the two profiles. Under the alternative hypothesis, the two profiles arise
from distinct underlying biological processes and this is modeled by using different models
for each profile. If the gene is significantly DE, the quality of fit (as measured by the sum of
squares of the regression residuals) under the alternative model is better than under the null
model. To get the significance of the fit statistic, the method instead uses a bootstrapping
based approach to simulate expression profiles under the null model and empirically estimates
the frequency of the simulated fit statistic being higher than the observed one. A critical
parameter in this modeling approach is the dimensionality of the spline basis p. [8] propose
a method to pick an optimal model that minimizes the generalized cross-validation error on
the top eigenvectors inferred from the data. In the current work, we extend the previous work
by proposing an alternative approach to model selection for inference in complex temporal
data. We identify distinct optimal models for clustered subsets of genes sharing complex
patterns based on the statistical power to detect genes with differential trajectories. We
implement this approach in a statistical package written in R, Rnits, to assist the research
community in the end-to-end genomic analysis of time course experiments, from raw data
import normalization, inference of DE and visualization of results.

Method

Data preprocessing and normalization
Raw or pre-processed expression data can be imported into Rnits either as a data matrix,
an RGList object created by the package limma, an AffyBatch object (package affy ) or an
eSet object downloaded from NCBI’s Gene Expression Omnibus by package GEOquery. For
all data formats, Rnits offers probe filtering and normalization options that are native to the
respective packages. Processed data, along with probe and sample phenotype data, is stored
as an Rnits class object, which inherits all methods from the ExpressionSet object in R that is
commonly used for storing expression data and metadata.This allows expression and metadata
In
retrieval from the object using the standard methods defined for ExpressionSet objects.
addition to the standard metadata requirements for the ExpressionSet object, building Rnits
objects requires columns labeled "Sample" and "Time" in the phenotype data matrix, and a
column labeled "GeneName" for the probe data matrix (for gene level summarization). One
of the time series experiments may be labeled as ’control’ for the purpose of clustering data.
Inference can be done at the probe level or at the gene level if multiple probes represent a
single gene. For gene level analysis, probe data is collapsed into a gene level summary using
the robust Tukey Biweight estimator, which penalizes outlier values. For analysis, the distinct
time series experiments must have been sampled at the same points.

2

2.1

2.2

B-spline basis model based hypothesis testing
The analysis approach is to model the time course data under the null hypothesis that
individual gene expression trajectories from distinct sets is a realization of the same underlying
basis trajectory modeled as a B-spline curve. Under the alternative hypothesis, each series is

2

The Rnits package for normalization and inference of differential expression in time series microarray data.

modeled as a distinct underlying basis. [8] et al describe a method of selecting the optimal
B-spline basis model L. For each data set, the top eigenvectors are computed and the set of
models L are used to compute the generalized cross-validation error using the eigenvectors
as predicted variables. For each data set, the model that minimizes the cross-validated error
across all top components is chosen as optimal and the largest optimal model among all data
sets is chosen (Rnits.gcv ). We extend this work to develop a parallel approach for selecting
the optimal model based on the power of inferring differentially expressed genes. Rnits.power.
A series of candidate models L are evaluated on the entire data set and optimal models are
selected based on the distribution of the p-values of fit.

2.3

Clustering

In the first step of this approach, the genes (or probes) may be clustered. Clustering al-
lows models of varying complexity to be selected to represent the diverse expression patterns
observed within the data. Each gene/probe is assigned to one of K distinct clusters using
k-means clustering on gene centered data (either all the series or based on a single "control"
series). The total number of clusters may be provided by the user as an argument or is deter-
mined empirically as twice the number of eigenvectors required to explain 70% of variation in
the time series labeled as control or the entire data set. If any of the resulting clusters have
less than 500 genes, clustering is iteratively repeated with one less initial cluster centroid.

2.4

Candidate model evaluation
The size r of the individual time series experiment determines the set of candidate B-spline
models that can be investigated. Each model L(c, p, r) is defined by its degree of curvature
c and the degrees of freedom p i.e. the number of basis splines used. The rank constrains
the curvature and the number of basis splines as follows. For a given matrix with rank r, the
set of candidate models L were:

L(c, p, r)

(cid:26)3 ≤ p ≤ min(8, r − 2)
2 ≤ c ≤ min(5, p − 1)

1

where each model was constrained to have a maximum degree of curvature of 5 and maximum
number of basis splines at 8. Whenever sufficient degrees of freedom were available to allow
manual placement of knots (p − c − 1 > 0), knots were chosen based on which time points
had the maximum inflection. For each cluster k (or for the entire data), each model L ∈ L
or the optimal model obtained by generalized cross-validation was evaluated as follows:

• The gene expression data matrix for series s can be represented as Ymkn where m
represents the number of probes (or genes) in cluster k, and n equals size of the data
. For models
series. The candidate model L is represented by its B-spline basis XL
pn
with larger basis splines, knot placement is guided by regions of higher curvature.

• Under the null model of no differential expression between the different time series, the
distinct profiles are assumed to be generated from the same underlying curve, and the
expression matrix for all series Ymn is fit as follows:

Ymn = (cid:100)βmnXL

pn + Emn = (cid:98)Ynull + Enull

2

• Under the alternate hypothesis, for each individual series s ∈ (1, S) , we fit a distinct

curve and the individual data matrix is fit as follows

Ymr = (cid:100)βmrXL

pr + Emr = (cid:98)Yalt + Ealt

3

3

The Rnits package for normalization and inference of differential expression in time series microarray data.

• The two models are evaluated using a ratio statistic F L
k

F L

k =

(cid:80)r E2

null − (cid:80)s (cid:80)r E2

alt

(cid:80)s (cid:80)r E2

alt + s0

4

null

where (cid:80)r E2
is the vector of sum of square of residuals under the null hypothesis
for all genes in cluster k and (cid:80)s (cid:80)r E2
is the sum of squared residuals for each
alt
gene in cluster k added over all series s. We add a variance stabilizing factor to the
denominator s0 computed as described by [14].

To compute p-values for the ratio statistic, we use the bootstrap approach as described
by [8]. First the residuals under the alternate model Ealt are standardized to correct for
heteroskedasticity for each series. This penalizes the models with larger basis splines by
increasing the effective size of their residuals.

′
E

alt =

Ealt
(cid:112)1 − X(X T X)−1X T

5

For each bootstrap iteration b, a synthetic null data set is constructed by adding the boot-
strapped studentized residuals to the null fit.

Y∗

null = (cid:98)Ynull + E

′∗
alt

6

Eqn (2)-(4) are repeated for each iteration and ratio statistics F L∗
under the null hypothesis
of no differential expression are computed. Empirical p-values are computed for the observed
ratio statistic based on the distribution of the simulated ones under the null hypothesis.

k

P L

k =

k > F L
k )

#(F L∗
B

7

where B are the number of bootstrap iterations.

2.5 Model Selection

For each cluster k, p-values are similarly calculated for each model L ∈ L. The significance
of each model fit is a function of the size of the studentized residuals under the null and alter-
native hypotheses. While more complex models (larger number of basis functions) may yield
smaller residuals during the alternative fit, these may get heavily penalized during correction
for heteroskedasticity, leading to low statistical power. At the other extreme, an insufficiently
complex model may not effectively capture the complexity of the expression trajectories that
may lead to larger residuals and lack of power. To alleviate this effect, we select the model
L which results in the maximum power, as determined by the number of genes inferred at an
estimated False Discovery Rate < 5%

3

Expression profiling in Yeast in a chemostat pertur-
bation experiment

We applied the Bspline methods to time course expression data tracking the glucose per-
turbation responses of a wild type yeast strain grown at steady state in a chemostat with
galactose as the carbon source ([15]). Two glucose concentrations (effective concentration of

4

The Rnits package for normalization and inference of differential expression in time series microarray data.

0.2 g/l and 2 g/l) were used as pulses and responses were tracked at 10, 15, 20, 30, 45, 90,
120 and 150 minutes post each treatment. We obtained the published microarray data from
NCBI Gene Expression Omnibus (GEO accession GSE4158) and analyzed it using Rnits.

3.1

Data preparation
First, we download the data from GEO and format it.

# Download NCBI GEO data with GEOquery

library(knitr)

rm(list = ls())

library(GEOquery)

## Loading required package: Biobase

## Loading required package: BiocGenerics

## Loading required package: generics

##

## Attaching package: ’generics’

## The following objects are masked from ’package:base’:

##

##

##

##

as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,

setequal, union

## Attaching package: ’BiocGenerics’

## The following objects are masked from ’package:stats’:

##

##

IQR, mad, sd, var, xtabs

## The following objects are masked from ’package:base’:

##

##

##

##

##

##

##

Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,

as.data.frame, basename, cbind, colnames, dirname, do.call,

duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,

mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,

rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,

unsplit, which.max, which.min

## Welcome to Bioconductor

##

##

##

##

Vignettes contain introductory material; view with

’browseVignettes()’. To cite Bioconductor, see

’citation("Biobase")’, and for packages ’citation("pkgname")’.

## Setting options(’download.file.method.GEOquery’=’auto’)

## Setting options(’GEOquery.inmemory.gpl’=FALSE)

library(stringr)

library(Rnits)

## Loading required package: ggplot2

5

The Rnits package for normalization and inference of differential expression in time series microarray data.

## Loading required package: limma

##

## Attaching package: ’limma’

## The following object is masked from ’package:BiocGenerics’:

##

##

##

plotMA

## Attaching package: ’Rnits’

## The following object is masked from ’package:generics’:

##

##

fit

gds <- getGEO("GSE4158", AnnotGPL = FALSE)[[1]]

## Found 1 file(s)

## GSE4158_series_matrix.txt.gz

class(gds)

## [1] "ExpressionSet"

## attr(,"package")

## [1] "Biobase"

gds

## ExpressionSet (storageMode: lockedEnvironment)

## assayData: 10752 features, 26 samples

##

element names: exprs

## protocolData: none

## phenoData

##

##

##

sampleNames: GSM94988 GSM94989 ... GSM95013 (26 total)
varLabels: title geo_accession ... data_row_count (36 total)
varMetadata: labelDescription

## featureData

##

##

##

featureNames: 1 2 ... 10752 (10752 total)

fvarLabels: ID METACOLUMN ... TYPE (10 total)

fvarMetadata: Column Description labelDescription

## experimentData: use 'experimentData(object)'

##

pubMedIds: 16381818

## Annotation: GPL3415

# Extract non-replicate samples

pdata <- pData(gds)
filt <- pdata$characteristics_ch2 %in% names(which(table(pdata$characteristics_ch2) ==

2))

gds <- gds[, filt]

pdata <- pData(gds)
time <- as.numeric(str_extract(pdata$characteristics_ch2, "\\d+"))
sample <- rep("2g/l", length(time))

sample[grep("0.2g/l", gds[["title"]])] <- "0.2g/l"

# Format phenotype data with time and sample information

6

The Rnits package for normalization and inference of differential expression in time series microarray data.

gds[["Time"]] <- time

gds[["Sample"]] <- sample

dat <- gds

fData(dat)["Gene Symbol"] <- fData(dat)$ORF

3.2

Running Rnits

3.2.1 Build Rnits object from ExpressionSet or data matrix

Next we build the Rnits object

# Build rnits data object from formatted data (samples can be in any order) and

# between-array normalization.

rnitsobj = build.Rnits(dat[, sample(ncol(dat))], logscale = TRUE, normmethod = "Between")

## Between Array normalization

## Data set with 2 time series

## Dataset with 10752 features and

2

samples in

1 replicates

rnitsobj

## Rnits (storageMode: lockedEnvironment)

## assayData: 10752 features, 16 samples

##

element names: exprs

## protocolData: none

## phenoData

##

##

##

sampleNames: GSM95010 GSM95011 ... GSM94998 (16 total)
varLabels: title geo_accession ... Sample (38 total)
varMetadata: labelDescription

## featureData

##

##

##

featureNames: 1 2 ... 10752 (10752 total)

fvarLabels: ID METACOLUMN ... GeneName (12 total)

fvarMetadata: labelDescription

## experimentData: use 'experimentData(object)'

## Annotation:

# Alternatively, we can also build the object from just a data matrix, by

# supplying the 'probedata' and 'phenodata' tables

datdf <- exprs(dat)

rownames(datdf) <- fData(dat)$ID

probedata <- data.frame(ProbeID = fData(dat)$ID, GeneName = fData(dat)$ORF)

phenodata <- pData(dat)

rnitsobj0 = build.Rnits(datdf, probedata = probedata, phenodata = phenodata, logscale = TRUE,

normmethod = "Between")

## Log scale is TRUE

## Between Array normalization

## Data set with 2 time series

## Dataset with 10752 features and

2

samples in

1 replicates

# Extract normalized expression values

lr <- getLR(rnitsobj)

head(lr)

7

The Rnits package for normalization and inference of differential expression in time series microarray data.

##

GSM95010

GSM95011

GSM95012

GSM95013

GSM95002

GSM95004

## 1 -0.99269970 -0.84741081 -0.22867060 0.5941574 -1.18590131 0.5137818

## 2

0.12448779 0.76758977 1.43044492 0.9482546 -0.04944478 0.4212989

## 3

0.05362765 -0.69975822 -0.70887206 0.2560923

0.62460336 0.3294558

## 4 -0.59017581 -0.47129159 -0.08102022 0.7885572 -1.03973077 0.8060511

## 5 -1.05032467 0.04912668 0.09804767 0.4690431 -1.59731454 0.4243162

## 6

0.84482623 1.10519264 1.25240820 1.6704265 -0.22307705 0.3077783

##

GSM95006

GSM95008

GSM94988

GSM94989

GSM94991

GSM94992

## 1 -0.31852729 -0.19303436 -0.20592568 -0.0797288 -0.05466009

0.005671936

## 2

0.31219698 0.13219700 0.62636186

0.6992206

0.78594481

0.684897162

## 3 -0.09733628 -0.39948994 -0.26945402 -0.7516256 -1.01418075 -1.066315054

## 4

0.57356735 0.43055165 -0.07012699 -0.3610244 -0.97771053 -0.841308620

## 5

0.38912313 0.09812534 0.25315615

0.0561665

0.17523029

0.273787476

## 6

0.24570856 -0.19826540 0.85110526

0.7232386

1.04992619

1.053762306

##

GSM94993 GSM94994

GSM94996

GSM94998

## 1

0.3418725 -2.487601 0.1680312 0.2977183

## 2

0.8925079

## 3 -1.0909498

## 4 -0.1664416

## 5

0.1791928

NA 1.1047615 0.7014654

NA 0.1363547 0.7593684

NA -0.2371354

NA

NA 0.3288013 0.5037860

## 6

1.0160011 -1.292664 0.8986091 0.7248260

# Impute missing values using K-nn imputation

lr <- getLR(rnitsobj, impute = TRUE)

## Warning in knnimp(x, k, maxmiss = rowmax, maxp = maxp):

1635 rows with more

than 50 % entries missing;

##

mean imputation used for these rows

## Cluster size 9117 broken into 2854 6263

## Cluster size 2854 broken into 2008 846

## Cluster size 2008 broken into 1305 703

## Done cluster 1305

## Done cluster 703

## Done cluster 2008

## Done cluster 846

## Done cluster 2854

## Cluster size 6263 broken into 3939 2324

## Cluster size 3939 broken into 2055 1884

## Cluster size 2055 broken into 1059 996

## Done cluster 1059

## Done cluster 996

## Done cluster 2055

## Cluster size 1884 broken into 798 1086

## Done cluster 798

## Done cluster 1086

## Done cluster 1884

## Done cluster 3939

## Cluster size 2324 broken into 855 1469

## Done cluster 855

## Done cluster 1469

## Done cluster 2324

8

The Rnits package for normalization and inference of differential expression in time series microarray data.

## Done cluster 6263

head(lr)

##

GSM95010

GSM95011

GSM95012

GSM95013

GSM95002

GSM95004

## 1 -0.99269970 -0.84741081 -0.22867060 0.5941574 -1.18590131 0.5137818

## 2

0.12448779 0.76758977 1.43044492 0.9482546 -0.04944478 0.4212989

## 3

0.05362765 -0.69975822 -0.70887206 0.2560923

0.62460336 0.3294558

## 4 -0.59017581 -0.47129159 -0.08102022 0.7885572 -1.03973077 0.8060511

## 5 -1.05032467 0.04912668 0.09804767 0.4690431 -1.59731454 0.4243162

## 6

0.84482623 1.10519264 1.25240820 1.6704265 -0.22307705 0.3077783

##

GSM95006

GSM95008

GSM94988

GSM94989

GSM94991

GSM94992

## 1 -0.31852729 -0.19303436 -0.20592568 -0.0797288 -0.05466009

0.005671936

## 2

0.31219698 0.13219700 0.62636186

0.6992206

0.78594481

0.684897162

## 3 -0.09733628 -0.39948994 -0.26945402 -0.7516256 -1.01418075 -1.066315054

## 4

0.57356735 0.43055165 -0.07012699 -0.3610244 -0.97771053 -0.841308620

## 5

0.38912313 0.09812534 0.25315615

0.0561665

0.17523029

0.273787476

## 6

0.24570856 -0.19826540 0.85110526

0.7232386

1.04992619

1.053762306

##

GSM94993

GSM94994

GSM94996

GSM94998

## 1

0.3418725 -2.4876007 0.1680312 0.29771835

## 2

0.8925079 0.8512363 1.1047615 0.70146541

## 3 -1.0909498 -0.2737668 0.1363547 0.75936838

## 4 -0.1664416 -0.1141164 -0.2371354 0.08949525

## 5

0.1791928 0.1737391 0.3288013 0.50378605

## 6

1.0160011 -1.2926636 0.8986091 0.72482603

3.2.2

Fitting the model

Next fit the model using gene-level summarization and by clustering all genes.

# Fit model using gene-level summarization

rnitsobj <- fit(rnitsobj0, gene.level = TRUE, clusterallsamples = TRUE)

## Collapsing probes into gene level log-ratios

## 3066 probes had no gene names. Removing them from further processing.

## Found 6342 unique genes.

## ############################

## Analyzing Models

## Computed number of clusters is 12

## Warning: did not converge in 10 iterations

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Repeating clustering to eliminate small clusters

## Number of clusters is: 4

## ############################

## Cluster 1 of size 1964

9

The Rnits package for normalization and inference of differential expression in time series microarray data.

## Cluster 2 of size 3120

## Cluster 3 of size 415

## Cluster 4 of size 843

## Estimated proportion of null genes is 100 %

The model may be fit using no clustering of samples, or by precomputing the optimal model
using the method of [8].

rnitsobj_nocl <- fit(rnitsobj0, gene.level = TRUE, clusterallsamples = FALSE)

opt_model <- calculateGCV(rnitsobj0)
rnitsobj_optmodel <- fit(rnitsobj0, gene.level = TRUE, model = opt_model)

3.2.3 Get top genes and other fit summary statistics

# Get pvalues from fitted model

pval <- getPval(rnitsobj)

head(pval)

##

YAL001C

YAL003W

YAL005C

YAL008W

YAL010C

YAL012W

## 0.343467949 0.015498982 0.004038462 0.517227564 0.555160256 0.046776986

# Get ratio statistics from fitted model

stat <- getStat(rnitsobj)

head(stat)

##

##

YAL001C

YAL003W

YAL005C

YAL008W

YAL010C

YAL012W

0.019622677 1.197300806 0.598136354 -0.007683565 -0.012834775

0.638745445

# If clustering was used, check the cluster gene distribution

table(getCID(rnitsobj))

##

##

1

2

3

4

## 1964 3120 415 843

# P-values, ratio statistics and cluster ID's can be retrieved for all genes

# together

fitdata <- getFitModel(rnitsobj)

head(fitdata)

##

Ratio.statistic

p.value clusterID

## YAL001C

0.019622677 0.343467949

## YAL003W

1.197300806 0.015498982

## YAL005C

0.598136354 0.004038462

## YAL008W

-0.007683565 0.517227564

## YAL010C

-0.012834775 0.555160256

## YAL012W

0.638745445 0.046776986

# View summary of top genes

summary(rnitsobj, top = 10)

2

1

2

2

2

1

##

Rank

Name Statistic p.value FDR.percent ClusterID Model.degree

## YFR053C

1 YFR053C

15.835 0.0e+00

## YDL163W

2 YDL163W

6.288 0.0e+00

0.000

0.000

3

4

4

2

10

The Rnits package for normalization and inference of differential expression in time series microarray data.

## YDR423C

3 YDR423C

2.743 3.0e-06

## YDR419W

4 YDR419W

2.066 1.0e-05

## YPL250C

5 YPL250C

1.988 1.3e-05

## YLR108C

6 YLR108C

11.325 2.0e-05

## YNR019W

7 YNR019W

1.845 2.2e-05

## YMR081C

8 YMR081C

14.090 2.4e-05

## YCLX02C

9 YCLX02C

1.785 2.9e-05

## YDL181W

10 YDL181W

1.705 3.5e-05

##

Model.df

0.353

0.792

0.792

0.792

0.792

0.792

0.792

0.792

2

2

2

1

2

3

2

2

2

2

2

5

2

4

2

2

## YFR053C

## YDL163W

## YDR423C

## YDR419W

## YPL250C

## YLR108C

## YNR019W

## YMR081C

## YCLX02C

## YDL181W

6

5

3

3

3

6

3

6

3

3

# Extract data of top genes (5% FDR)

td <- topData(rnitsobj, fdr = 5)

## 1039

head(td)

##

0.2g/l_15 0.2g/l_20
## YFR053C -2.9237332 -1.17590933 0.6091109

0.2g/l_10

0.2g/l_30
2.73172725

0.2g/l_45
3.40919390

0.2g/l_90
0.77117494

## YDL163W -0.9243805 -2.43239351 -1.7448963 -0.87669277 -1.29343745 -2.17031889

## YDR423C -0.0174820 -0.80075684 -0.9942190 -0.71869747 -0.54344754

0.94911040

## YDR419W -0.2046478 -0.09408354 0.1999304 -0.08199723 -0.29901144

0.07077963

## YPL250C -1.3931411 -0.63307891 -0.1730618 -0.56061472 -0.08929123

0.48297463

## YLR108C 0.5685404 -1.10385596 -0.9205930 -0.50890787

0.03927246 -2.25151963
2g/l_30
## YFR053C -0.009692989 0.26532124 -1.87441034 -2.2218713 -2.5078707 -2.3278171

0.2g/l_120 0.2g/l_150

2g/l_15

2g/l_20

2g/l_10

##

## YDL163W -5.523916689 -9.11199324 -1.66350915 -0.9688887 -0.4722037 -0.9177256

## YDR423C 1.313307227 2.37037067 -0.99643967 -0.5109414 -0.6357871 -0.8643160

## YDR419W 0.137079198 1.26142508

0.23694914

0.3507209

0.4883211

0.2138258

## YPL250C 0.429392521 0.60480510

0.04940828

0.6270811

0.1708989 -0.1504075

## YLR108C -0.154056158 0.07452528
2g/l_90
2g/l_45
## YFR053C -1.67649576 0.32539539

##

0.82726286
2g/l_120
2.5267731

0.9679145
2g/l_150
4.3264832

## YDL163W -0.98907345 -0.52131607 -0.7203552 -1.3021307

## YDR423C -0.87955496 -0.89268766 -0.9903288 -0.6873137

## YDR419W 0.33370546 0.07141897 -0.9464912 -1.5263603

## YPL250C -0.07005299 -0.48678884 -1.0584139 -1.7323014

## YLR108C 1.78043928 1.66918466

2.3220387

2.2632476

1.4876804

1.6543992

Next we plot the results for the top 16 differentially expressed genes by FDR

# Plot top genes trajectories

plotResults(rnitsobj, top = 16)

11

The Rnits package for normalization and inference of differential expression in time series microarray data.

## ‘geom_smooth()‘ using formula = ’y ~ x’

## Next: 1 of 1

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

##

## attached base packages:

## [1] stats

graphics grDevices utils

datasets

methods

base

##

## other attached packages:
limma_3.66.0
## [1] Rnits_1.44.0
## [4] stringr_1.5.2
GEOquery_2.78.0
## [7] BiocGenerics_0.56.0 generics_0.1.4
##

ggplot2_4.0.0
Biobase_2.70.0
knitr_1.50

12

YDR277C (R13:C1)YLR044C (R14:C1)YDR497C (R15:C2)YGR011W (R16:C2)YCLX02C (R9:C2)YDL181W (R10:C2)YLR400W (R11:C1)YGL157W (R12:C1)YPL250C (R5:C2)YLR108C (R6:C1)YNR019W (R7:C2)YMR081C (R8:C3)YFR053C (R1:C3)YDL163W (R2:C4)YDR423C (R3:C2)YDR419W (R4:C2)4080120408012040801204080120−10−505−10−505−10−505−10−505TimeExpression (log2)Sample0.2g/l2g/lThe Rnits package for normalization and inference of differential expression in time series microarray data.

## loaded via a namespace (and not attached):

##

##

##

##

[1] tidyselect_1.2.1
[3] farver_2.1.2
[5] S7_0.2.0
[7] XML_3.99-0.19
[9] lifecycle_1.0.4
##
## [11] magrittr_2.0.4
## [13] rlang_1.1.6
## [15] yaml_2.3.10
## [17] S4Arrays_1.10.0
## [19] curl_7.0.0
## [21] plyr_1.8.9
## [23] RColorBrewer_1.1-3
## [25] withr_3.0.2
## [27] R.oo_1.27.1
## [29] stats4_4.5.1
## [31] scales_1.4.0
## [33] dichromat_2.0-0.1
## [35] cli_3.6.5
## [37] reshape2_1.4.4
## [39] qvalue_2.42.0
## [41] splines_4.5.1
## [43] formatR_1.14
## [45] XVector_0.50.0
## [47] vctrs_0.6.5
## [49] Matrix_1.7-4
## [51] IRanges_2.44.0
## [53] S4Vectors_0.48.0
## [55] affyio_1.80.0
## [57] codetools_0.2-20
## [59] gtable_0.3.6
## [61] tibble_3.3.0
## [63] rappdirs_0.3.3
## [65] Seqinfo_1.0.0
## [67] httr2_1.2.1
## [69] lattice_0.22-7
## [71] rentrez_1.2.4
## [73] R.methodsS3_1.8.2
## [75] Rcpp_1.1.0
## [77] nlme_3.1-168
## [79] xfun_0.53
## [81] pkgconfig_2.0.3

dplyr_1.1.4
R.utils_2.13.0
fastmap_1.2.0
digest_0.6.37
statmod_1.5.1
compiler_4.5.1
tools_4.5.1
data.table_1.17.8
labeling_0.4.3
DelayedArray_0.36.0
xml2_1.4.1
abind_1.4-8
purrr_1.1.0
grid_4.5.1
preprocessCore_1.72.0
tinytex_0.57
SummarizedExperiment_1.40.0
rmarkdown_2.30
tzdb_0.5.0
affy_1.88.0
impute_1.84.0
BiocManager_1.30.26
matrixStats_1.5.0
boot_1.3-32
jsonlite_2.0.0
hms_1.1.4
tidyr_1.3.1
glue_1.8.0
stringi_1.8.7
GenomicRanges_1.62.0
pillar_1.11.1
htmltools_0.5.8.1
R6_2.6.1
evaluate_1.0.5
readr_2.1.5
highr_0.11
BiocStyle_2.38.0
SparseArray_1.10.0
mgcv_1.9-3
MatrixGenerics_1.22.0

4

Summary

Dynamic changes in transcriptional programs to changing stimulus or cell cycle stages neces-
sitate an experimental design that tracks expression changes over a period of time. There
are often constrains on the replication levels in such designs, posing a challenging inference
problem. A number of methods have been developed to infer differential expression between
conditions. We extend a previously developed method by [8] of using B-splines to perform

13

The Rnits package for normalization and inference of differential expression in time series microarray data.

hypothesis testing. We extended the method to include a model selection step that opti-
mizes for distinct subsets within the expression data, corresponding to diverse transcriptional
regulatory patterns in cells. We present this method as an comprehensive analysis R package
Rnits to enable the data import, pre-processing, normalization, analysis and visualization of
gene expression data from a variety of sources (GEO, raw or normalized data tables).

References

[1] Ping Ma, Wenxuan Zhong, and Jun S. Liu. Identifying differentially expressed genes in

time course microarray data. Statistics in Biosciences, 1(2):144–159, 2009.

[2] Martin Aryee, Jose Gutierrez-Pabello, Igor Kramnik, Tapabrata Maiti, and John

Quackenbush. An improved empirical bayes approach to estimating differential gene
expression in microarray time-course data: Betr (bayesian estimation of temporal
regulation). BMC bioinformatics, 10(1):409, 2009.

[3] Yu Chuan Tai and Terence P. Speed. A multivariate empirical bayes statistic for

replicated microarray time course data. The Annals of Statistics, 34(5):2387–2412,
2006.

[4] Ziv Bar-Joseph, Georg Gerber, David K. Gifford, Tommi S. Jaakkola, and Itamar

Simon. A new approach to analyzing gene expression time series data. In Proceedings
of the sixth annual international conference on Computational biology, pages 39–48.
ACM, 2002.

[5] Ziv Bar-Joseph, Georg Gerber, Itamar Simon, David K. Gifford, and Tommi S.

Jaakkola. Comparing the continuous representation of time-series expression profiles to
identify differentially expressed genes. Proceedings of the National Academy of
Sciences, 100(18):10146–10151, 2003.

[6] Norma Coffey and John Hinde. Analyzing time-course microarray data using functional
data analysis-a review. Statistical Applications in Genetics and Molecular Biology,
10(1), 2011.

[7] Xueli Liu and Mark C. K. Yang. Identifying temporally differentially expressed genes
through functional principal components analysis. Biostatistics, 10(4):667–679, 2009.
URL: http://biostatistics.oxfordjournals.org/content/10/4/667.abstract,
doi:10.1093/biostatistics/kxp022.

[8]

John D. Storey, Wenzhong Xiao, Jeffrey T. Leek, Ronald G. Tompkins, and Ronald W.
Davis. Significance analysis of time course microarray experiments. Proceedings of the
National Academy of Sciences of the United States of America, 102(36):12837–12842,
2005.

[9]

Jeffrey T. Leek, Eva Monsen, Alan R. Dabney, and John D. Storey. Edge: extraction
and analysis of differential gene expression. Bioinformatics, 22(4):507–508, 2006.

[10] Claudia Angelini, Daniela De Canditiis, Margherita Mutarelli, and Marianna Pensky. A
bayesian approach to estimation and testing in time-course microarray experiments.
Statistical Applications in Genetics and Molecular Biology, 6(1), 2007.

[11] F. Hong and H. Li. Functional hierarchical models for identifying genes with different

time-course expression profiles. Biometrics, 62(2):534–544, 6 2006.
doi:10.1111/j.1541-0420.2005.00505.x.

14

The Rnits package for normalization and inference of differential expression in time series microarray data.

[12] Christopher Minas, Simon J. Waddell, and Giovanni Montana. Distance-based

differential analysis of gene curves. Bioinformatics, 27(22):3135–3141, 2011. URL:
http://bioinformatics.oxfordjournals.org/content/27/22/3135.abstract,
doi:10.1093/bioinformatics/btr528.

[13] Chongqi Zhang, Heng Peng, and Jin-Ting . T. Zhang. Two samples tests for

functional data. Communications in StatisticsTheory and Methods, 39(4):559???578,
2 2010. doi:10.1080/03610920902755839.

[14] Virginia Goss Tusher, Robert Tibshirani, and Gilbert Chu. Significance analysis of
microarrays applied to the ionizing radiation response. Proceedings of the National
Academy of Sciences, 98(9):5116–5121, 2001.

[15] Michal Ronen and David Botstein. Transcriptional response of steady-state yeast
cultures to transient perturbations in carbon source. Proceedings of the National
Academy of Sciences of the United States of America, 103(2):389–394, 2006.

15

