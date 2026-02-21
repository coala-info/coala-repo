General Sample Size and Power Analysis for high-dimensional genomic
data

Maarten van Iterson and Ren´ee de Menezes
Center for Human and Clinical Genetics,
Leiden University Medical Center, The Netherlands
Package SSPA, version 2.16.0

Modiﬁed: 22 October, 2013. Compiled: April 24, 2017

Contents

1 Introduction

2 Simulated data

2.1 Deconvolution . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Conjugate Gradient
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Tikhonov regularization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Case Study: Nutrigenomics microarray data

4 Case Study: deepSAGE of wild-type vs Dclk1 transgenic mice

5 Session info

1

Introduction

1

2
2
5
5

6

7

11

Power and sample size analysis or sample size determination is concerned with the question of determining the minimum
number of samples necessary to demonstrate the existence (or absence) of a diﬀerence between two or more populations
of interest. The number of samples should be suﬃcient in that the statistical test will reject the null hypothesis, when
there really exists a diﬀerence, with high probability or power.

Sample size determination for experiments involving high-dimensional data has several challenges as a multiple testing
problem is involved, furthermore the occurrence of diﬀerentially and nondiﬀerentialy expressed genes and that each gene
individually has an eﬀect size and a standard deviation leading to a distribution of eﬀect sizes and standard deviations
complicates the problem even further.

Power and sample size analysis for high-dimensional data was initiated by [1]. The multiple testing problem was controlled
using the easy to apply family-wise error rate. Since controlling the family-wise error rate is too conservative for microarray
data, methods were proposed that control the multiple testing problem using the false discovery rate [2, 3, 4]. Recently,
those methods were adapted for using pilot-data in order to obtain more realistic estimates of the power [5, 6, 7].

This vignette describes SSPA, a package implementing a general pilot data-based method for power and sample size
determination for high-dimensional genomic data, such as those obtained from microarray or next-generation sequencing
experiments. The method is based on the work of Ferreira and Zwinderman [5] and generalized as described by van
Iterson et al. [8, 9].

1

General Sample Size and Power Analysis for high-dimensional genomic data

2

By means of two simple commands (pilotData(), sampleSize()), a researcher can read in their data –a vector of
test statistics– and compute the desired estimates. Other functions are provided that facilitate interpretation of results.
Simulation data is used to show the general functionality and ﬂexibility of the package and two interesting biological case
study are shown.

2 Simulated data

This simulation study represents a two group microarray experiment with m = 5000 features and N = 10 samples per
group. Let Rij and Sij, i = 1, . . . , m, j = 1, . . . , N be random variables where Sij ∼ N (−µi/2, 1) and Rij ∼ N (µi/2, 1)
with the ﬁrst µi = 0 for i = 1, . . . , m0 and the remaining µi for i = m0 + 1, . . . , m were drawn from a symmetric bi-
triangular distribution as described by [10]. A total of 25 data sets were simulated with the proportion of non-diﬀerentially
expressed features ﬁxed at π0 = 0.8. Additional technical noise is added to the model using X ∼ log(eR + e(cid:15)) and
Y ∼ log(eS + e(cid:15)) with (cid:15) ∼ N (0, 0.12), so that the noise is positive and additive.

> library(SSPA)
> library(genefilter)
> set.seed(12345)
> m <- 5000
> J <- 10
> pi0 <- 0.8
> m0 <- as.integer(m*pi0)
> mu <- rbitri(m - m0, a = log2(1.2), b = log2(4), m = log2(2))
> data <- simdat(mu, m=m, pi0=pi0, J=J, noise=0.01)
> statistics <- rowttests(data, factor(rep(c(0, 1), each=J)))$statistic

2.1 Deconvolution

The ﬁrst step in doing the sample size and power analysis is creating a object of class PilotData which will contain all the
necessary information needed for the following power and sample size analysis; a vector of test-statistics and the sample
sizes used to compute them. A user-friendly interface for creating an object of PilotData is available as pilotData().

Several ways of viewing the content of the PilotData object are possible either graphically or using a show-method by
just typing the name of the created object of PilotData:

> pdD <- pilotData(statistics = statistics,
+
+
> pdD

samplesize = sqrt(1/(1/J +1/J)),
distribution="norm")

Formal class

’

PilotData

’

[package "SSPA"] with 5 slots

..@ statistics : num [1:5000] -1.98854 -0.00589 -1.26628 0.74421 -0.76088 ...
..@ samplesize : num 2.24
..@ pvalues
..@ distribution: chr "norm"
..@ args

: num [1:5000] 0.0468 0.9953 0.2054 0.4567 0.4467 ...

: list()

> plot(pdD)

Now we can create an object of class SampleSize which will perform the estimation of the proportion of non-diﬀerentially
expressed genes and the density of eﬀect sizes. Several options are available see ?sampleSize.

The density of eﬀect size can be shown by a call to plot(). When there are both up- and down-regulated genes a
bimodal density is observed.

General Sample Size and Power Analysis for high-dimensional genomic data

3

Figure 1: Exploratory plots of the pilot-data: Upper left panel shows a histogram of the test statistics, upper right
panel a histogram of the p-values. Lower left panel shows a qq-plot for the test statistics using the user-deﬁned null
distributions. Lower right panel shows the sorted p-values against their ranks.

> ssD <- sampleSize(pdD, control=list(from=-6, to=6))
> ssD

’

’

SampleSize

: chr "deconv"

[package "SSPA"] with 10 slots

: num [1:90] 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 ...
: logi TRUE
: num 0.5

: num 0.781
: num [1:512] 0 0 0 0 0 0 0 0 0 0 ...
: num [1:512] -6 -5.98 -5.95 -5.93 -5.91 ...
:List of 11

Formal class
..@ pi0
..@ lambda
..@ theta
..@ control
.. ..$ method
.. ..$ pi0Method : chr "Langaas"
.. ..$ pi0
.. ..$ adjust
.. ..$ a
.. ..$ bandwith : NULL
.. ..$ kernel
.. ..$ from
.. ..$ to
.. ..$ resolution: num 512
.. ..$ verbose
..@ info
.. ..$ pi0: num 0.767
..@ statistics : num [1:5000] -1.98854 -0.00589 -1.26628 0.74421 -0.76088 ...
..@ samplesize : num 2.24
..@ pvalues

: num [1:5000] 0.0468 0.9953 0.2054 0.4567 0.4467 ...

: chr "fan"
: num -6
: num 6

: logi FALSE

:List of 1

test statistic0.000.050.100.150.200.250.30−505qnormtest statistic−505−4−2024llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllp−value01230.00.20.40.60.81.0p−value (sorted)0.00.20.40.60.81.00.00.20.40.60.81.0General Sample Size and Power Analysis for high-dimensional genomic data

4

Figure 2: Estimated density of eﬀect sizes: True density of eﬀect sizes, the bitriangular distribution, and estimated
density of eﬀect sizes in blue.

..@ distribution: chr "norm"
..@ args

: list()

{

> plot(ssD, panel = function(x, y, ...)
+
+
+
+

panel.xyplot(x, y)
panel.curve(dbitri(x), lwd=2, lty=2, n=500)

}, ylim=c(0, 0.6))

Estimating the average power for other sample sizes then that of the pilot-data can be performed with the predict-
power()-function. The user can also give the desired false discovery rate level.

> Jpred <- seq(10, 20, by=2)
> N <- sqrt(Jpred/2)
> pwrD <- predictpower(ssD, samplesizes=N, alpha=0.05)
> matplot(Jpred, pwrD, type="b", pch=16, ylim=c(0, 1),
+
> grid()

ylab="predicted power", xlab="sample size (per group)")

The deconvolution estimator of the density of eﬀect sizes is only applicable for two-group comparisons when the test
statistics is (approximate) normally distributed. Note that in this situation we use the eﬀective sample size. In all other
cases e.g. two group comparison using the t statistics with the Conjugate Gradient estimator for the density of eﬀect
sizes the total sample size is used.

density of effect sizeseffect size0.10.20.30.40.5−6−4−20246llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllGeneral Sample Size and Power Analysis for high-dimensional genomic data

5

Figure 3: Predicted power curve: For sample sizes from 10 to 20 the power is predicted based on the information
obtained from the pilot-data.

2.2 Conjugate Gradient

samplesize = sqrt(2*J),
distribution="t",
df=2*J-2)

> pdC <- pilotData(statistics = statistics,
+
+
+
> ssC <- sampleSize(pdC,
+
+
> plot(ssC, panel = function(x, y, ...)
+
+
+
+

}, xlim=c(-2,2), ylim=c(0, 1.2))

{

panel.xyplot(x, y)
panel.curve(2*dbitri(2*x), lwd=2, lty=2, n=500)

method="congrad",
control=list(from=-6, to=6, resolution=250))

2.3 Tikhonov regularization

> ssT <- sampleSize(pdC,
+
+
+
+
+

method="tikhonov",
control=list(resolution=250,

scale="pdfstat",
lambda = 10^seq(-10, 10, length=50),
verbose=FALSE,

llllll1012141618200.00.20.40.60.81.0sample size (per group)predicted powerGeneral Sample Size and Power Analysis for high-dimensional genomic data

6

Figure 4: Conjugate gradient method: Estimated density of eﬀect sizes using the conjugate gradient method.

Figure 5: Tikohonov regularization: Estimated density of eﬀect sizes using the Tikohonov regularization.

modelselection="lcurve"))

+
> plot(ssT, panel = function(x, y, ...)
+
+
+
+

}, xlim=c(-2,2), ylim=c(0, 1.2))

{

panel.xyplot(x, y, type="b")
panel.curve(2*dbitri(2*x), lwd=2, lty=2, n=500)

3 Case Study: Nutrigenomics microarray data

In this ﬁrst example a set consisted of Aﬀymetrix array data derived from a nutrigenomics experiment in which weak,
intermediate and strong PPARα agonists were administered to wild-type and PPARα-null mice is used. The power and
sample size analysis conﬁrms the hierarchy of PPARα-activating compounds previously reported and the general idea
that larger eﬀect sizes positively contribute to the average power of the experiment.

PPARα is a transcription factor that is activated upon binding by a variety of agonists, both of synthetic and natural origin.
In this experiment the outcome of speciﬁc PPARα activation on murine small intestinal gene expression was examined
using Aﬀymetrix GeneChip Mouse 430 2.0 arrays. PPARα was activated by several PPARα-agonists that diﬀered in
activating potency. Data of three agonists were used, namely Wy14,643, fenoﬁbrate and trilinolenin (C18:3). The ﬁrst
two compounds belong to the ﬁbrate class of drugs that are widely prescribed to treat dyslipidemia, whereas trilinolenin
is an agonist frequently found in the human diet. For intestinal PPARα, Wy14,643 is the most potent agonist followed

density of effect sizeseffect size0.20.40.60.81.0−101llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllldensity of effect sizeseffect size0.20.40.60.81.0−101lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllGeneral Sample Size and Power Analysis for high-dimensional genomic data

7

by C18:3 and fenoﬁbrate. Since time of exposure also aﬀects the eﬀect size, intestines were collected 6 hrs (all three
agonists) or 5 days (Wy14,643 and fenoﬁbrate only) after exposure. Expression estimates of probesets were obtained by
GC-robust multi-array (GCRMA) analysis, employing the empirical Bayes approach for background adjustment, followed
by quantile normalization and summarization. For each compound and exposure time, lists of moderated t-test statistics
were computed, using the empirical Bayes linear regression model as implemented in limma, for each contrast representing
the eﬀect of compound in PPARα-null mice compared to wild-type mice. For more details see [8].

> library(lattice)
> data(Nutrigenomics)
> str(Nutrigenomics)
’

’

:

16540 obs. of 5 variables:

data.frame
$ wy5d : num 2 1.22 1.19 -1.14 1 0.86 4 -1.83 -2.64 3.04 ...
$ feno5d: num 2 -1.03 -1.11 0.33 0.22 0.22 0.24 0.36 1.73 0.54 ...
$ X1836h: num 2.5 -2.3 -0.56 0.06 -0.89 -0.09 2 -2.12 -1.47 -1.69 ...
$ wy6h : num 2 1.12 0.21 -0.68 -1.06 -0.4 1.82 -1.71 1.2 1.03 ...
$ feno6h: num 2.22 0.76 -0.37 -0.07 -1.9 ...

function(x) pilotData(statistics=x[-1],

samplesize=sqrt(x[1]),
distribution="norm"))

control=list(pi0Method="Storey", a=0, resolution=2^10, verbose=FALSE))

method = "congrad",
control=list(verbose=FALSE, resolution=2^10, from=-10, to=10))

> pd <- apply(Nutrigenomics, 2,
+
+
+
> ss <- lapply(pd, sampleSize,
+
> ##ss <- lapply(pd, sampleSize,
> ##
> ##
>
> compounds <- c("Wy14,643", "fenofibrate", "trilinolenin (C18:3)", "Wy14,643", "fenofibrate")
> exposure <- c("5 Days", "6 Hours")
> effectsize <- data.frame(exposure = factor(rep(rep(exposure, c(2, 3)), each=1024)),
+
+
+
+
+
> print(xyplot(lambda~theta|exposure, group=compound, data=effectsize,
+
+

type=c("g", "l"), layout=c(1,2), lwd=2, xlab="effect size", ylab="",
auto.key=list(columns=3, lines=TRUE, points=FALSE, cex=0.7)))

compound = factor(rep(compounds, each=1024)),
lambda = as.vector(sapply(ss,

theta = as.vector(sapply(ss,

function(x)x@lambda)),

function(x)x@theta)))

> samplesize <- seq(2, 8)
> averagepower <- data.frame(power = as.vector(sapply(ss,
+
+
+
+
> print(xyplot(power~samplesize|exposure, group=compound, data=averagepower, type=c("g", "b"),
+
+

exposure = factor(rep(rep(exposure, c(2, 3)), each=length(samplesize))),
compound = factor(rep(compounds, each=length(samplesize))),
samplesize = rep(2*samplesize, 5))

layout=c(1,2), lwd=2, pch=16, xlab="sample size (per group)", ylab="",
auto.key=list(columns=3, lines=TRUE, points=FALSE, cex=0.7)))

function(x) as.numeric(predictpower(x, samplesize=sqrt(samplesize))))),

4 Case Study: deepSAGE of wild-type vs Dclk1 transgenic mice

In this example we will show how our method can be applied to count data of an RNA-seq experiment. We will use the
data described by [11] comparing gene expression proﬁles in the hippocampi of transgenic δC-doublecortin-like kinase

General Sample Size and Power Analysis for high-dimensional genomic data

8

Figure 6: Nutrigenomic example: Estimated density of eﬀect sizes for the ﬁve treatment exposure conditions.

mice with that of wild-type mice. Data is available from GEO (GSE10782).

and analyzed using the generalized linear model approach implemented in edgeR. A tag-wise dispersion parameter was
estimated using the Cox-Reid adjusted proﬁle likelihood approach for generalized linear models as implemented in edgeR.
Using a treatment contrast, we tested per tag if there was a genotype eﬀect using the likelihood ratio statistic. This test
statistic follow asymptotically a χ2 distribution with one degree of freedom.

group=rep(c("DCLK", "WT"), 4),
description=rep(c("transgenic (Dclk1) mouse hippocampus",

"wild-type mouse hippocampus"), 4))

> ##files contains the full path and file names of each sample
> targets <- data.frame(files=files,
+
+
+
> d <- readDGE(targets) ##reading the data
> ##filter out low read counts
> cpm.d <- cpm(d)
> d <- d[rowSums(cpm.d > 1) >= 4, ]
> design <- model.matrix(~group, data=d$samples)
> ##estimate dispersion
> disp <- estimateGLMCommonDisp(d, design)
> disp <- estimateGLMTagwiseDisp(disp, design)
> ##fit model
> glmfit.hoen <- glmFit(d, design, dispersion = disp$tagwise.dispersion)
> ##perform likelihood ratio test
> lrt.hoen <- glmLRT(glmfit.hoen)
> ##extract results

effect size0.00.10.20.30.40.5−6−4−202465 Days0.00.10.20.30.40.56 HoursWy14,643fenofibratetrilinolenin (C18:3)General Sample Size and Power Analysis for high-dimensional genomic data

9

Figure 7: Nutrigenomic example: Predicted power curves for the ﬁve treatment exposure conditions.

> tbl <- topTags(lrt.hoen, n=nrow(d))[[1]]
> statistics <- tbl$LR

> library(lattice)
> data(deepSAGE)
> str(deepSAGE)

num [1:44882] 133.5 93.8 89.5 88.8 87.4 ...

control=list(trim=c(0, 0.98), symmetric=FALSE, from=0, to=10))

samplesize=8, distribution="chisq", df=1)

> pd <- pilotData(statistics=deepSAGE,
+
> ss <- sampleSize(pd, method="congrad",
+
> pwr <- predictpower(ss, samplesize=c(8, 16, 32))
> op <- par(mfcol=c(2,1), mar=c(5,4,1,1))
> plot(ss@theta, ss@lambda,
+
> plot(c(8, 16, 32), pwr,
+
> grid(col=1)
> par(op)

xlab="effect size", ylab="", type="l")

xlab="sample size", ylab="power", type="b", ylim=c(0,1))

sample size (per group)0.20.40.60.846810121416llllllllllllll5 Days0.20.40.60.8lllllllllllllllllllll6 HoursWy14,643fenofibratetrilinolenin (C18:3)General Sample Size and Power Analysis for high-dimensional genomic data

10

Figure 8: Deep SAGE example: Estimated density of eﬀect size and predicted power curve.

02468100.00.20.40.6effect sizelll10152025300.00.40.8sample sizepowerGeneral Sample Size and Power Analysis for high-dimensional genomic data

11

5 Session info

The version number of R and packages loaded for generating the vignette were:

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu
(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS
(cid:136) Matrix products: default
(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so
(cid:136) Base packages: base, datasets, grDevices, graphics, methods, stats, utils
(cid:136) Other packages: SSPA 2.16.0, geneﬁlter 1.58.0, lattice 0.20-35, limma 3.32.0, qvalue 2.8.0
(cid:136) Loaded via a namespace (and not attached): AnnotationDbi 1.38.0, Biobase 2.36.0, BiocGenerics 0.22.0,
BiocStyle 2.4.0, DBI 0.6-1, IRanges 2.10.0, Matrix 1.2-9, RCurl 1.95-4.8, RSQLite 1.1-2, Rcpp 0.12.10,
S4Vectors 0.14.0, XML 3.98-1.6, annotate 1.54.0, backports 1.0.5, bitops 1.0-6, colorspace 1.3-2, compiler 3.4.0,
digest 0.6.12, evaluate 0.10, ggplot2 2.2.1, grid 3.4.0, gtable 0.2.0, htmltools 0.3.5, knitr 1.15.1, lazyeval 0.2.0,
magrittr 1.5, memoise 1.1.0, munsell 0.4.3, parallel 3.4.0, plyr 1.8.4, reshape2 1.4.2, rmarkdown 1.4,
rprojroot 1.2, scales 0.4.1, splines 3.4.0, stats4 3.4.0, stringi 1.1.5, stringr 1.2.0, survival 2.41-3, tibble 1.3.0,
tools 3.4.0, xtable 1.8-2, yaml 2.1.14

References

[1] M.L.T. Lee and G.A. Whitmore. Power and sample size for DNA microarray studies. Statistics in Medicine,

21:3543–3570, 2002.

[2] Y. Pawitan, S. Michiels, S. Koscielny, A. Gusnanto, and A. Ploner. False discovery rate, sensitivity and sample size

for microarray studies. Bioinformatics, 21(13):3017–3024, 2005.

[3] P. Liu and J.T.G. Hwang. Quick calculation for sample size while controlling false discovery rate with application

to microarrays. Bioinformatics, 26(6):739–746, 2007.

[4] T. Tong and H. Zhao. Practical guidelines for assessing power and false discovery rate for ﬁxed sample size in

microarray experiments. Statistics in Medicine, 27:1960–1972, 2008.

[5] J.A. Ferreira and A. Zwinderman. Approximate Sample Size Calculations with Microarray Data: An Illustration.

Statistical Applications in Genetics and Molecular Biology, 5(1):1, 2006.

[6] D. Ruppert, D. Nettleton, and J.T.G. Hwang. Exploring the information in p-values for the analysis and planning

of multiple-test experiments. Biometrics, 63(2):483–495, 2007.

[7] T.S. Jørstad, H. Midelfart, and A.M. Bones. A mixture model approach to sample size estimation in two-sample

comparative microarray experiments. BMC Bioinformatics, 9(117):1, 2008.

[8] M. van Iterson, P.A.C. ’t Hoen, P. Pedotti, G.J.E.J. Hooiveld, J.T. den Dunnen, G.J.B. van Ommen, J.M. Boer,
and R.X. de Menezes. Relative power and sample size analysis on gene expression proﬁling data. BMC Genomics,
10(3):439–449, 2009.

[9] M. van Iterson, M.A. van de Wiel, J.M. Boer, and R.X. de Menezes. Power and sample size calculations for
high-dimensional genomic data. Statistical Applications in Genetics and Moleculair Biology, 12(4):449–467, Aug
2013.

[10] M. Langaas, B.H. Lindqvist, and E. Ferkingstad. Estimating the proportion of true null hypotheses, with application

to DNA microarray data. Journal of the Royal Statistical Society Series B, 67(4):555–572, 2005.

General Sample Size and Power Analysis for high-dimensional genomic data

12

[11] P.A.C. ’t Hoen, Y. Ariyurek, H.H. Thygesen, E. Vreugdenhil, R.H.A.M. Vossen, R.X. de Menezes, J.M. Boer,
G.B. van Ommen, and J.T. den Dunnen. Deep Sequencing-based Expression analysis shows Major Advances in
Robustness, Resolution and Inter-lab Portability over Five Microarray Platforms. Nucleic Acids Research, pages
1–11, 2008.

