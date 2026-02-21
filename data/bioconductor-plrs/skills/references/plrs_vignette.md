PLRS
Piecewise Linear Regression Splines for
the association between DNA copy number and
gene expression

Gwena¨el G.R. Leday

g.g.r.leday@vu.nl

Department of Mathematics, VU University
De Boelelaan 1081a, 1081 HV Amsterdam, The Netherlands

1 Introduction

The PLRS package implements the methodology described by [2] for the joint analysis of DNA copy
number and mRNA expression. The framework employs piecewise linear regression splines (PLRS),
a broad class of interpretable models, to model cis-relationships between the two molecular levels.
In the present vignette, we provide guidance for:

1. The analysis of a single DNA-mRNA relationship

(cid:136) model speciﬁcation and ﬁtting,
(cid:136) selection of an appropriate model,
(cid:136) testing the strength of the association and
(cid:136) obtaining uniform conﬁdence bands.

2. The analysis of multiple DNA-mRNA relationships

We ﬁrst provide an short explanation on data preparation and introduce the breast cancer data
used to illustrate this vignette.

1

2 Data preparation

Data preparation consists in (1) preprocessing gene expression and aCGH data, and (2) matching
their features. In the following, we give a brief overview on how to proceed with R.

2.1 Creating an “ExpressionSet” object

We assume that the user is familiar with microarray gene expression data and knows how to nor-
malize these with appropriate R/Bioconductor packages. Consider the matrix (features × samples)
of normalized gene expression exprMat and associated data.frame exprAnn containing annotations
of features (such as chromosome number, start bp, end bp, symbol, ...). One can create an “Expres-
sionSet” object as follows:

GE <- new("ExpressionSet", exprs=exprMat)
fData(GE) <- data.frame(Chr=exprAnn$Chr, Start=exprAnn$Start,
End=exprAnn$End, Symbol=exprAnn$Symbol)
rownames(fData(verhaakGEraw)) <- exprAnn$ProbeID

We refer the user to the package Biobase for a more detail and complete description of this class
of objects.

2.2 Preprocessing aCGH data

Here, we shortly illustrate steps for preprocessing aCGH data. Of course, this is only one way to
proceed and diﬀerent algorithms can be employed for diﬀerent steps. In what follows, the user can
ﬁnd supplementary information within documentation of packages CGHcall and sigaR.

2.2.1 Create an “cghRaw” object

Consider a data.frame cgh where the ﬁrst three columns contains the chromosome number, start
and end position in bp (respectively), and where the following columns are the log2-ratios for each
sample. Then, the raw aCGH data can be organized into an “cghRaw” object as follows:

# Raw object
cghraw <- make_cghRaw(cgh)
cghraw

# Some available methods
copynumber(cghraw) chromosomes(cghraw)
bpstart(cghraw)
bpend(cghraw)

Now, it is possible to use the R functions from package CGHcall.

2

2.2.2 Multi-step preprocessing of aCGH data

The preprocessing of copy number data usually consists in three steps: normalization, segmentation
and calling (see [2]). The normalization aims to remove technical variability and make samples
comparable. This step outputs normalized log2-values.

# Imputation of missing values
cghprepro <- preprocess(cghraw, maxmiss = 30, nchrom = 22)

# Mode normalization
cghnorm <- normalize(cghprepro, method = "median")

The segmentation consists in partitioning the genome of each sample into segments of constant
log2-values. A common method to do so is the algorithm of [4].

# Segmentation using the CBS method of Olshen
cghseg <- segmentData(cghnorm, method = "DNAcopy")

Finally, calling attributes an aberration state to each segment. CGHcall is based on mixture models
and classiﬁes each segment into 3 (loss, normal and gain), 4 (loss, normal, gain and ampliﬁcation)
or 5 (double losses, single loss, normal, gain and ampliﬁcation) types of genomic aberrations. The
number of aberration states is speciﬁed via argument nclass.

# Calling using CGHcall
res <- CGHcall(cghseg, nclass = 4, ncpus=8)
cghcall <- ExpandCGHcall(res, cghseg)
save(cghcall, file="cghcall.RData")

The ﬁnal object cghcall contains all data from previous steps. Here are some methods to ac-
cess them:

# Some methods
norm <- copynumber(cghcall)
seg <- segmented(cghcall)
cal <- calls(cghcall)

# Membership probabilities associated with calls
ploss <- probloss(cghcall)
pnorm <- probnorm(cghcall)
pgain <- probgain(cghcall)
pamp <- probamp(cghcall)

3

2.3 Matching features of gene expression and copy number data

Matching of features is accomplished with package sigaR. There exists various methods of matching
and we refer the interested reader to [6] for their introduction. Below we provide R code for the
DistanceAny method with a window of 10,000 bp:

# distanceAny matching:
matchedIDs <- matchAnn2Ann(fData(cghcall)[,1], fData(cghcall)[,2],
fData(cghcall)[,3], fData(GE)[,1], fData(GE)[,2], fData(GE)[,3],
method = "distance", ncpus = 8, maxDist = 10000)

# add offset to distances (avoids infinitely large weights)
matchedIDs <- lapply(matchedIDs, function(Z, offset) Z[,3] <- Z[,3] + offset; return(Z)
, offset=1)

# extract ids for object subsetting
matchedIDsGE <- lapply(matchedIDs, function(Z) return(Z[, -2, drop=FALSE]) )
matchedIDsCN <- lapply(matchedIDs, function(Z) return(Z[, -1, drop=FALSE]) )

# generate matched objects
GEdata <- ExpressionSet2weightedSubset(GE, matchedIDsGE, 1, 2, 3, ncpus = 8)
CNdata <- cghCall2weightedSubset(cghcall, matchedIDsCN, 1, 2, 3, ncpus = 8)

# save matched data
save(GEdata, CNdata, file="GECNmatched_distanceAny10000.RData")

R code for other methods can be found in documentation of package sigaR.

3 Breast cancer data

We use the breast cancer data of [3] that are available from the Bioconductor package “Neve2006”.
aCGH and gene expression for 50 samples (cell lines) were proﬁled with an OncoBAC and Aﬀymetrix
HG-U133A arrays. We preprocessed and matched data as follows. Data were segmented with the
CBS algorithm of [4] and discretized with CGHcall [5] (also available from Bioconductor). Matching
of features was done using the Bioconductor package sigaR [6] and the distanceAny method with
a window of 10,000 bp. The present package includes preprocessed data for chromosome 17 only.

Data are loaded in the following way:

> library(plrs)
> data(neveCN17)
> data(neveGE17)

4

This loads to the current environment an “ExpressionSet” object neveGE17 and a “cghCall”
object neveCN17, which contain preprocessed expression and copy number data with matched
features:

> neveGE17

ExpressionSet (storageMode: lockedEnvironment)
assayData: 1185 features, 50 samples

element names: exprs

protocolData: none
phenoData: none
featureData

featureNames: 207311_at 221614_s_at ... 215055_at (1185 total)
fvarLabels: Chr Start End Symbol
fvarMetadata: labelDescription

’

experimentData(object)

’

experimentData: use
Annotation:

> neveCN17

cghCall (storageMode: lockedEnvironment)
assayData: 1185 features, 50 samples

element names: calls, copynumber, probamp, probgain, probloss, probnorm, segmented

protocolData: none
phenoData: none
featureData

featureNames: GS1-68F18_207311_at GS1-68F18_221614_s_at ...

RP11-165M24_215055_at (1185 total)

fvarLabels: Chromosome Start End
fvarMetadata: labelDescription

’

experimentData(object)

’

experimentData: use
Annotation:

4 Analysis of a single DNA-mRNA relationship

In this section, we focus on a single cis-eﬀect and show how to specify and ﬁt a model. Procedures
for selecting an appropriate model, testing the association and obtaining conﬁdence intervals for
the mean response are presented.

4.1 Obtain data for a single gene

We choose gene PITPNA for illustration:

> # Index of gene PITPNA
> idx <- which(fData(neveGE17)$Symbol=="PITPNA")[1]

5

> # Obtain vectors of gene expression (normalized) and
> # copy number (segmented and called) data
> rna <- exprs(neveGE17)[idx,]
> cghseg <- segmented(neveCN17)[idx,]
> cghcall <- calls(neveCN17)[idx,]

> # Obtain vectors of posterior membership probabilities
> probloss <- probloss(neveCN17)[idx,]
> probnorm <- probnorm(neveCN17)[idx,]
> probgain <- probgain(neveCN17)[idx,]
> probamp <- probamp(neveCN17)[idx,]

Posterior probabilities are used for determining knots (or change points) of the model. Their cal-
culation is explained in [2].

4.2 Number of observations per state

For a given gene, PLRS accommodates diﬀerential DNA-mRNA relationships across the diﬀerent
types of genomic aberrations or states. Presently, we (only) distinguish four of them: loss (coded
as -1), normal (0), gain (1) and ampliﬁcation (2). To ensure that the model is identiﬁable,
the sample size for each state needs not to be too small. A minimum number of three samples is
required for estimation, however any higher number may be chosen/preferred.

> # Check: how many observations per state?
> table(cghcall)

cghcall
-1 0 1
19 28 3

Here, it is possible to ﬁt a 3-state model. If the minimum number of observations is not fulﬁlled for
a given state, there are two possibilities: discard data corresponding to the given state or merging
it to an adjacent one. The function modify.conf() accommodates these two options (see below).
With this function one can actually control the minimum number of samples per state.

> # Set the minimum to 4 observations per state
> cghcall2 <- modify.conf(cghcall, min.obs=4, discard=FALSE)
> table(cghcall2)

cghcall2
-1 0
19 31

> # Set the minimum to 4 observations per state
> cghcall2 <- modify.conf(cghcall, min.obs=4, discard=TRUE)
> table(cghcall2)

6

cghcall2
-1 0
19 28

In practice, the user does not have to call directly modify.conf() as it is implemented internally in
function plrs(), which is used to ﬁt a model. However, one needs to be aware that the minimum
number of observations per state (speciﬁed via arguments min.obs and discard.obs in plrs())
has a strong inﬂuence on the resulting model.

4.3 Model ﬁtting

Function plrs() allows the ﬁtting of a PLRS model. Diﬀerent types of models may be speciﬁed
conveniently. For instance, one may choose to ﬁt a continuous PLRS (i.e. with no state-speciﬁc
intercepts or discontinuities) or to change the type of restrictions on parameters or simply leave
them out. Although we recommend users to use default argument values, we below describe how
to specify alternative types of models.

The followings arguments of function plrs() oﬀer ﬂexibility for modeling:

(cid:136) continuous = TRUE or FALSE (default)

Specify whether state-speciﬁc intercepts should be included.

(cid:136) constr = TRUE (default) or FALSE

Specify whether inequality constraints on parameter should be applied or not.

(cid:136) constr.slopes = 1 or 2 (default)

Specify the type of constraints on slopes; options are:

1. constr.slopes = 1 forces all slopes to be non-negative.

2. constr.slopes = 2 forces the slope of the ”normal” state (coded 0) to be non-negative

while all others are forced to be at least equal to the latter.

(cid:136) constr.intercepts = TRUE (default) or FALSE

Specify whether state-speciﬁc intercepts are to be non-negative.

Note that when constr = FALSE, constr.slopes and constr.intercepts have no eﬀect.

With default settings (recommended):

> # Fit a model
> model <- plrs(rna, cghseg, cghcall, probloss, probnorm, probgain, probamp)
> model

Object of class "plrs"

Spline coefficients:
theta0.0 theta0.1 theta1.0 theta1.1 theta2.0 theta2.1

7

8.14440 1.99381 0.01071 -1.99381 0.36509 0.44272

Model is constrained:
constr.slopes = 2
constr.intercepts = TRUE

> plot(model)

The plrs() function returns an S4 object of class “plrs”. Various generic functions have been deﬁned
on this class:

(cid:136) Functions print() and summary() display information about the model (e.g. estimated coef-

ﬁcients, type of constraints, etc...).

(cid:136) Function plot() displays the ﬁt of the PLRS model along with data. Segmented copy number
is on x-axis while (normalized) gene expression is on y-axis; colors indicate the diﬀerent
aberration states, namely “loss” (red), “normal” (blue) and “gain” (green); the black line gives
the ﬁt of the PLRS model. Colors and symbols may be changed via the appropriate arguments
of function plrs(). Note that the argument lin, if set to TRUE, will additionally display a
dashed (default) line giving the ﬁt of the simple linear model.

(cid:136) Other useful functions include coef(), fitted(), residuals(), model.matrix(), predict()
and knots(). These are standard functions. Information about these can be found in associ-
ated help ﬁles.

4.4 Select an appropriate model

8

llllllllllllllllllllllllllllllllllllllllllllllllll−1.0−0.50.00.51.06.06.57.07.58.08.59.0llllllllllllllllllllllllllllllllllllllllllllllllllModel selection is carried out by plrs.select(), which takes has input an object of class “plrs”.
Possible model selection criteria are OSAIC, AIC, AICC and BIC. When the model is constrained
OSAIC is the only appropriate one. If the model has no restrictions on parameters, OSAIC and AIC
are equivalent. See help ﬁle and associated references for more information.

> # Model selection
> modelSelection <- plrs.select(model)
> summary(modelSelection)

Object of class "plrs.select"

OSAIC model selection procedure

Coefficients of selected spline:
theta0.0 theta0.1 theta1.1 theta2.0
8.15917 2.02349 -2.02349 0.42046

Model is constrained:
constr.slopes = 2
constr.intercepts = TRUE

Model selection table:

osaic
model1 -93.81986
model2 -115.34894
model3 -112.01954
model4 -99.78747
model5 -97.89852
model6 -116.63119
...

> # Plot selected model
> plot(modelSelection)

9

The function plrs.select() returns an S4 object of class “plrs.select” (here modelSelection),
which contains information on model selection. Slot model contains the selected model as a “plrs”
object:

> selectedModel <- modelSelection@model
> selectedModel

Object of class "plrs"

Selected spline coefficients:
theta0.0 theta0.1 theta1.1 theta2.0
8.15917 2.02349 -2.02349 0.42046

Model is constrained:
constr.slopes = 2
constr.intercepts = TRUE

Although model and selectedModel are both objects of class “plrs”, generic functions deﬁned
on this class make implicitly the distinction between objects resulting from functions plrs() and
plrs.select() (see above; “Selected spline coefficients”).

⇒ It is important to note that, for correct inference, subsequent test and conﬁdence intervals
must be computed on the full model rather than the selected one. Therefore, we forced functions
plrs.test() and plrs.cb() (used hereafter) to operate on the full model, regardless of the input
model. This implies that inference results are the same with either objects (see below).
If one
wishes to obtain results for the selected model, set selectedModel@selected to FALSE and then
apply the aforementioned functions.

10

llllllllllllllllllllllllllllllllllllllllllllllllll−1.0−0.50.00.51.06.06.57.07.58.08.59.0llllllllllllllllllllllllllllllllllllllllllllllllll4.5 Testing the strength of the association

The function plrs.test() implements a likelihood ratio test to evaluate the eﬀect of DNA copy
number on expression. It tests the hypothesis that all parameters (except the overall intercept) of
the PLRS model equal 0. See [1, 2] and associated references for more details on the test. The
function plrs.test() takes as input an object class “plrs” and outputs an object from the same
class. Testing results are contained in slot test.

> # Testing the full model with
> model <- plrs.test(model, alpha=0.05)
> model

Object of class "plrs"

Spline coefficients:
theta0.0 theta0.1 theta1.0 theta1.1 theta2.0 theta2.1
8.14440 1.99381 0.01071 -1.99381 0.36509 0.44272

Model is constrained:
constr.slopes = 2
constr.intercepts = TRUE

Testing:
stat = 0.6028283
quantile = 0.1125137 (alpha = 0.05)
p-value = 1.5204e-09

> # or with
> selectedModel <- plrs.test(selectedModel, alpha=0.05)
> selectedModel

Object of class "plrs"

Selected spline coefficients:
theta0.0 theta0.1 theta1.1 theta2.0
8.15917 2.02349 -2.02349 0.42046

Model is constrained:
constr.slopes = 2
constr.intercepts = TRUE

Testing:
stat = 0.6028283
quantile = 0.1125155 (alpha = 0.05)
p-value = 1.5202e-09

> # Testing the selected model
> selectedModel2 <- selectedModel
> selectedModel2@selected <- FALSE
> plrs.test(selectedModel2, alpha=0.05)

11

Object of class "plrs"

Spline coefficients:
theta0.0 theta0.1 theta1.1 theta2.0
8.15917 2.02349 -2.02349 0.42046

Model is constrained:
constr.slopes = 2
constr.intercepts = TRUE

Testing:
stat = 0.5938289
quantile = 0.09207085 (alpha = 0.05)
p-value = 4.4335e-10

The object selectedModel now contains information on testing, which are consequently dis-

played when printing.

4.6 Uniform conﬁdence bands

Conﬁdence intervals for the spline are computed with function plrs.cb. Again, the function requires
an object of class “plrs”. However, the input object must result from function plrs.test()). This
is because information from the test is required (mixture’s weights). plrs.cb outputs an object of
class “plrs” and computed lower and upper bounds for the mean response are stored in slot cb.

> # Compute and plot CBs
> selectedModel <- plrs.cb(selectedModel, alpha=0.05)
> str(selectedModel@cb)

List of 3

$ inf: num [1:102] 4.17 4.26 4.35 4.43 4.52 ...
$ sup: num [1:102] 6.44 6.46 6.49 6.51 6.54 ...
$ x : num [1:102] -1.5 -1.47 -1.44 -1.41 -1.38 ...

> plot(selectedModel)

12

Conﬁdence bands are automatically plotted. Color may be change with input arguments col.cb.
For example:

> plot(selectedModel, col.pts="black", col.cb="pink")

13

llllllllllllllllllllllllllllllllllllllllllllllllll−1.0−0.50.00.51.06.06.57.07.58.08.59.0llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−1.0−0.50.00.51.06.06.57.07.58.08.59.0llllllllllllllllllllllllllllllllllllllllllllllllll5 Analysis of multiple DNA-mRNA relationships

Function plrs.series() allows to apply the diﬀerent aforementioned procedures to multiple rela-
tionships. Input data can be given as matrix objects or ExpressionSet and cghCall objects. We
now show how to: 1) implement the PLRS screening test and 2) implement the model selection
procedure. For the purpose of speed, we work on a subset of chromosome 17 (ﬁrst 200 features).

> # Testing the full model, no model selection (fast)
> neveSeries <- plrs.series(neveGE17[1:200,], neveCN17[1:200,], control.select=NULL)

In progress...

10% done (21 genes),
20% done (41 genes),
30% done (61 genes),
40% done (81 genes),
50% done (100 genes),
60% done (120 genes),
70% done (140 genes),
80% done (160 genes),
90% done (180 genes),
100% done (200 genes),

time elapsed = 0:00:01
time elapsed = 0:00:01
time elapsed = 0:00:02
time elapsed = 0:00:03

time elapsed = 0:00:03
time elapsed = 0:00:04
time elapsed = 0:00:05
time elapsed = 0:00:05
time elapsed = 0:00:06

time elapsed = 0:00:07

> # Testing the full model and applying model selection
> neveSeries2 <- plrs.series(neveGE17[1:200,], neveCN17[1:200,])

In progress...

10% done (21 genes),
20% done (41 genes),
30% done (61 genes),
40% done (81 genes),
50% done (100 genes),
60% done (120 genes),
70% done (140 genes),
80% done (160 genes),
90% done (180 genes),
100% done (200 genes),

time elapsed = 0:00:04
time elapsed = 0:00:07
time elapsed = 0:00:11
time elapsed = 0:00:14

time elapsed = 0:00:18
time elapsed = 0:00:21
time elapsed = 0:00:26
time elapsed = 0:00:31
time elapsed = 0:00:35

time elapsed = 0:00:39

Function plrs.series() has arguments control.model, control.select and control.test,
which allows to specify the type of model, model selection and whether the test and conﬁdence
bands should be computed. Argument control.output allows the user to save each “plrs” objects
and/or associated plot in the working directory.
plrs.series() outputs an object of class “plrs.series”. Generic functions print() and summary()
display information on ﬁtted models, selected models and/or the testing procedure.

14

> # Summary of screening test
> neveSeries

Object of class "plrs.series"

200 genes

Type of fitted model:
continuous = FALSE
constr.slopes = 2
constr.intercepts = TRUE

> summary(neveSeries)

Object of class "plrs.series"

200 genes

Type of fitted model:
continuous = FALSE
constr.slopes = 2
constr.intercepts = TRUE

Configuration:

0

-1

Nb genes
19.000 25.000
Min. obs
Median. obs 20.000 26.000
19.625 26.285
Mean. obs
20.000 28.000
Max. obs

1 2
200.000 200.000 200.00 0
3.00 NA
4.00 NA
4.09 NA
5.00 NA

Nb of models regarding their types:
Intercept
Simple linear
Piecewise level
Piecewise linear 200

0
0
0

Testing:
Number of rejected null hypothesis: 99 genes
(at 0.1 significance level based on

Benjamini-Hochberg corrected p-values)

> # Summary of screening test and model selection
> neveSeries2

Object of class "plrs.series"

200 genes
Models selected with OSAIC

15

> summary(neveSeries2)

Object of class "plrs.series"

200 genes
Models selected with OSAIC

Configuration:

0

-1

Nb genes
Min. obs
19.000 25.000
Median. obs 20.000 26.000
19.625 26.285
Mean. obs
20.000 28.000
Max. obs

1 2
200.000 200.000 200.00 0
3.00 NA
4.00 NA
4.09 NA
5.00 NA

Nb of models regarding their types:
61
Intercept
46
Simple linear
Piecewise level
18
Piecewise linear 75

Testing:
Number of rejected null hypothesis: 99 genes
(at 0.1 significance level based on

Benjamini-Hochberg corrected p-values)

Results of testing and model selection procedures are obtained as follows:

> # Testing results
> head(neveSeries@test)

stat

raw.pval BH.adj.pval
gene1 1.071594e-02 5.445523e-01 0.6936971802
gene2 5.027115e-18 8.214771e-01 0.8233222536
gene3 1.497315e-03 7.298044e-01 0.8200049384
gene4 4.041468e-02 2.660398e-01 0.4124648605
gene5 3.451090e-01 7.457354e-05 0.0002711765
gene6 3.030552e-01 2.839139e-04 0.0008872310

> head(neveSeries2@test)

stat

raw.pval BH.adj.pval
gene1 1.071594e-02 5.445509e-01 0.6936954395
gene2 5.027115e-18 8.214931e-01 0.8233254905
gene3 1.497315e-03 7.298531e-01 0.8200596439
gene4 4.041468e-02 2.660667e-01 0.4125064509
gene5 3.451090e-01 7.458741e-05 0.0002712269
gene6 3.030552e-01 2.838570e-04 0.0008870530

16

> # Coefficients of selected models
> head(neveSeries2@coefficients)

theta0.0 theta0.1 theta1.0 theta1.1 theta2.0 theta2.1 theta3.0 theta3.1
NA
NA
NA
NA
NA
NA

NA
gene1 5.816194
NA
gene2 4.058224
gene3 3.726981
NA
gene4 4.700387 0.1453787
gene5 6.805236 1.0396287
gene6 6.514909 1.0953053

NA
NA
NA
NA
NA
NA
NA
NA
NA 3.192212
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

>

17

References

[1] Ulrike Gr¨omping. Inference with linear equality and inequality constraints using R: The package

ic.infer. J Stat Softw, 33(i10), 2010.

[2] Gwena¨el G. R. Leday, Aad W. van der Vaart, Wessel N. van Wieringen, and Mark A. van de
Wiel. Modeling association between DNA copy number and gene expression with constrained
piecewise linear regression splines. Ann Appl Stat, 2012. Accepted for publication.

[3] Richard M. Neve, Koei Chin, Jane Fridlyand, Jennifer Yeh, Frederick L. Baehner, Tea Fevr,
Laura Clark, Nora Bayani, Jean-Philippe P. Coppe, Frances Tong, Terry Speed, Paul T. Spell-
man, Sandy DeVries, Anna Lapuk, Nick J. Wang, Wen-Lin L. Kuo, Jackie L. Stilwell, Daniel
Pinkel, Donna G. Albertson, Frederic M. Waldman, Frank McCormick, Robert B. Dickson,
Michael D. Johnson, Marc Lippman, Stephen Ethier, Adi Gazdar, and Joe W. Gray. A collec-
tion of breast cancer cell lines for the study of functionally distinct cancer subtypes. Cancer
cell, 10(6):515–527, December 2006.

[4] A. B. Olshen, E. S. Venkatraman, R. Lucito, and M. Wigler. Circular binary segmentation for
the analysis of array-based DNA copy number data. Biostatistics, 5(4):557–572, October 2004.

[5] Mark A. van de Wiel, Kyung I. Kim, Sjoerd J. Vosse, Wessel N. van Wieringen, Saskia M.
Wilting, and Bauke Ylstra. CGHcall: calling aberrations for array CGH tumor proﬁles. Bioin-
formatics, 23(7):892–894, April 2007.

[6] Wessel N. van Wieringen, Kristian Unger, Gwenael Leday, Oscar Krijgsman, Renee de Menezes,
Bauke Ylstra, and Mark van de Wiel. Matching of array CGH and gene expression microarray
features for the purpose of integrative genomic analyses. BMC Bioinformatics, 13(1):80, 2012.

18

