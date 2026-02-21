Description of rHVDM: an R/Bioconductor package
implementing Hidden Variable Dynamic Modelling

Martino Barenco

October 30, 2018

Contents

1 HVDM uncovered

1.1 The model . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2 More details about the ﬁtting . . . . . . . . . . . . . . . . . . . . . . . .

2 A sample session

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1 Data requirements
2.2 The training step . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . .
2.3 Fitting individual genes and screening in batches

3 Accessing information in rHVDM objects

3.1 List created by the training() function. . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . .
3.2 List created by the fitgene() function.
. . . . . . . . . . . . . . . . .
3.3 List created by the screening() function.

4 Technical issues

4.1 How conﬁdence intervals are evaluated . . . . . . . . . . . . . . . . . . .

5 Implementation notes and other practicalities

5.1 MacOSX 10.4 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 Windows . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 What’s new in version...

Background

3
3
4

5
6
8
11

13
14
17
18

19
19

20
20
20

21

The rHVDM package is an improved version of Hidden Variable Dynamic Modelling
(HVDM) [1]1 implemented in R for speed and convenience. HVDM is a mathematical

1http://genomebiology.com/2006/7/3/R25

1

technique which predicts a given transcription factor activity and then uses this infor-
mation to predict its targets. To achieve that, HVDM uses time course expression data
inconjunction with a dynamic model. HVDM takes advantage of prior biological knowl-
edge to create a training set of genes, the behaviour of which can be used to derive
the activity proﬁle of the controlling transcription factor. This activity parameter -the
hidden variable- can then be used to identify other targets of the same factor ranked in
order of likelihood.

The new R implementation incorporates two signiﬁcant improvements over the origi-
nal C version. First, we have introduced a more eﬃcient optimisation technique (Levenberg-
Marquardt) which signiﬁcantly improves on the Nelder-Mead method applied before.
Second, the Hessian matrix created as a by-product of the new method can be used to
assess the robustness of the outcome. This results in a faster performance compared to
the original implementation where conﬁdence intervals were estimated via a compara-
tively slow Markov Chain Monte Carlo approach. rHVDM can now analyse microarray
time series data from a thousand genes in under 5 minutes to accurately predict targets
of a transcription factor.

The most important section of the present document is section 2, which contains
a step-by-step sample session; the data for this session are supplied with the package.
Going through this session should take about an hour and we strongly recommend doing
this before trying rHVDM with your own data. That section is preceded by the data
requirements description and a short introduction on the mathematical principles behind
the package. It is followed by more technical aspects of rHVDM (Accessing information
in rHVDM objects, conﬁdence intervals computation, implementation changes).

Type of data required

rHVDM requires the following input information:

(cid:136) Expression time course microarray data, consisting of at least ﬁve time points.

Note that the technique can cope with irregular sampling.

(cid:136) Some prior biological knowledge about the transcription factor under review: at
least three genes should be known to be targets of that transcription factor and
presumed to be targets of that transcription factor only. These genes constitute
the training set.

(cid:136) The transcript degradation rate of one the known targets (measured in an inde-

pendent experiment (for example by Q-RTPCR).

(cid:136) The measurement error for each expression value should be known. Note that this
is the technical error, not the biological error. See below and section 2.1 for more
details about this.

2

These requirements are the bare minimum for rHVDM to produce meaningful results.
More time points and replication improve results but are not essential. Little advantage
is gained by increasing the number of training set genes beyond ﬁve. No advantage
is gained by measuring more than one degradation rate. The data with which this
technique was originally developed (and used in the example given below) consists of
a time course run in triplicates comprising each seven time points, sampled regularly
every two hours. We used more than three known targets (ﬁve). Surprisingly, biological
replicates are not required but do help achieving more robust results.

The experimental design should be such that the activity of the transcription factor
under review changes in time. A ﬂat activity (following a knock down of that transcrip-
tion factor for example) would not carry much information. The time range covered by
the time course should be loosely commensurate with the half lives of the transcripts of
the target genes. In our example, the experiment covers twelve hours and the half life of
a typical transcript is in the range of hours. Conversely, an experiment covering a week
with a snapshot every twenty-four hours is unlikely to be informative.

Crucially, something should be known about the measurement errors (ie technical
rather than biological error), in particular their variance. The idea behind this is that
the ﬁtting should be more lenient with those expression values that are more noisy and,
more generally, that the uncertainty attached to the data should somehow “trickle down”
to the parameter estimation. Broadly speaking, the lower the expression level, the higher
the associated error is. This is important in HVDM as the robustness of one of those
parameters is critical in indicating whether a particular transcript is a putative target
of the transcription factor under examination. Starting from version 1.5 of the package,
this measurement error can be estimated from the data (see subsection 2.1 for more
details).

1 HVDM uncovered

Before giving a sample session (in the next section), we brieﬂy present in the present
section the mathematical basis for the algorithm.

1.1 The model

The technique supposes that the expression of a given gene j is governed by the following
ordinary diﬀerential expression:

dXj(t)
dt

= Bj + Sjf (t) − DjXj(t)

(1)

where Xj(t) denotes the concentration of gene j at time t. The left-hand side of this
equation denotes the rate of change of that concentration while the right-hand side gath-
ers all the terms having an inﬂuence on the rate of change. The ﬁrst term, Bj is a basal
rate of change. The second term Sjf (t) is the rate of change that is dependent on the

3

transcription factor. The constant is Sj the sensitivity of gene j to the transcription
factor activity (and hence is speciﬁc to that gene), while f (t) is the transcription factor
activity at time t and may apply to other genes, provided they are targets of the tran-
scription factor. The last term is the degradation term, we suppose it is proportional
to the transcript concentration. Hence, like Bj and Sj, the degradation rate Dj is a
constant parameter. In a microarray time course experiment, we have measurements
for Xj(t), or rather we have approximate values ˆXj(t) because expression values are
hampered by measurement errors:

ˆXj(ti) = Xj(ti) + (cid:15)j,i

(2)

where (cid:15)j,i is a random variable denoting the measurement error. We suppose (cid:15)j,i to be
Gaussian with expectancy zero and variance σ2
j,i. All the other quantities in equation
(1) remain unknown. We are in particular interested in f (t), the transcription factor
activity which is the “hidden variable”. To ﬁnd the transcription factor activity, previous
knowledge about the biological system under review is used, ie known targets of the
transcription factor and the degradation rate of the mRNA of one of those targets (the
latter should be measured independently, using for example Q-RTPCR). Hence in an
initial training step, optimal values for the kinetic parameters Bj, Sj, Dj for the training
genes and the activity proﬁle f (t) are found. In the second (screening) step, the model
is ﬁtted to other transcripts’ expression data, with f (t) known. Those genes transcripts
for which the model ﬁts the data well and whose sensitivity Sj is signiﬁcantly larger than
zero are considered putative targets of the transcription factor under review.

1.2 More details about the ﬁtting

The transcription factor activity variable f (t) is in reality a continuous function. How-
ever, any time course experiment consists only of a limited amount of measurements at
discrete time points, which we will denote henceforth as ˆXj, where ˆXj ≡ { ˆXj(t0), ˆXj(t1), . . . , ˆXj(tn))}.
Hence, we aim to estimate f (t) at the same time points: f ≡ {f (t0), f (t1), . . . , f (tn))}.
Similarly to estimate the left-hand side of (1), the rate of change of the transcript
concentration, we use a diﬀerential operator A, which is a square matrix with the same
dimensions as there are time points in the time course. The entries of this matrix are
calculated using polynomial interpolation. These entries depend only on the timing
of the measurement, not on the expression value. More details can be found in the
supplementary material of [1]. Hence we have an approximate (and discrete) version of
(1):

AXj = Bj1 + Sjf − DjXj

(3)

whose formal solution2 for Xj is given by

2In practice, this system of linear equations is solved using LU substitution.

Xj = (A + DjI)−1(Bj1 + Sjf )

4

where I is the identity matrix and 1 a vector whose every single entry is 1.

Fitting the model amounts to ﬁnding the parameter values for which Xj (modelled
expression values) are closest to ˆXj (observed expression values). As a measure of “close-
ness” we use the following expression, which we will call the model score:

M (p) =

(cid:88)

genes,timepoints,replicates

(cid:32) ˆXj(ti) − Xj(ti)
σj,i

(cid:33)2

(4)

In the equation above, σj,i is the standard deviation of the measurement error in (2)
and p is the set of parameters to be ﬁtted. The contents of this set depends on the
context. In the training step, p comprises the kinetic parameters of the training genes
as well as the transcription activity proﬁle, while in the screening step, only the kinetic
parameters of the gene under review are ﬁtted. Fitting the model amounts to ﬁnding
the values of p that minimize M (p) above. It is worth noting, that in the case where
there are several replicates in the experiment, a diﬀerent transcription activity proﬁle is
used for each replicate, whilst the kinetic parameters for individual genes are supposed
to be the same across replicates.

The ﬁtting algorithm used in the R implementation of HVDM is Levenberg-Marquardt
(LM), which is gradient-based and applied using the excellent minpack.lm package. A
useful by-product of LM is the hessian matrix H. H is an approximation of the partial
second derivatives of the model score function (4) with respect to individual elements
of p, the vector of parameters. This matrix is instrumental in leading the optimisation
but also has interesting properties when it comes to evaluating the robustness of the ﬁt.
Inverting H 3 gives an approximation of the covariance matrix of the ﬁtted parameters,
which we use as a measure of robustness. For example, the diagonal of H −1 contains
the variance of the individual parameters. It is also possible to derive, from the Hessian
matrix, useful information about the quality of the ﬁt (see next section).

2 A sample session

The rHVDM package comprises ﬁve functions, HVDMcheck, HVDMreport, training, fit-
gene and screening. The ﬁrst two are diagnostic commands and the last three perform
various types of ﬁtting. In this section we demonstrate these commands using the exam-
ple presented in [1]. The relevant data for this sample session is attached with the pack-
age. rHVDM requires three other packages: aﬀy 4 [2] (for data handling), R2HTML [3]
(for report generation) and minpack.lm (for the optimisation step). Once these packages
and rHVDM have been installed, rHVDM can be launched in the R session using:

> library(rHVDM) ##the three other packages also get loaded

3If H is non-singular, which is not guaranteed.
4Normally, Biobase should be enough but we specify aﬀy to ensure Windows compatibility.

5

To load the data that will be used in this sample session5:

> data(HVDMexample)

This loads the three R objects: fiveGyMAS5, p53traingenes and genestoscreen. fiv-
eGyMAS5 contains the data set to be used, p53traingenes and genestoscreen are
vectors containing gene identiﬁers. The data is of human T-cells (MOLT4 line) that
were subjected to a 5 Gy dose of γ-irradiation. This causes DNA double-strand breaks
which elicits a complex transcriptional response in the cell. Messenger RNA was col-
lected every two hours and up to twelve hours after irradiation, as well as just before
irradiation (which is the zero hours, or control, time point) and aﬀymetrix HGU133A
arrays were hybridized using standard procedures. Thus there are seven time points
{0, 2, 4, 6, 8, 10, 12} and the experiment was run in triplicates. Probe level data were
summarized using MAS5.0 and rescaled [4]6. It is these data that are contained in the
fiveGyMAS5 object. In this sample session, we will apply rHVDM to identify targets of
the p53 tumor suppressor.

2.1 Data requirements

The time course data used should:

(cid:136) be contained in an ExpressionSet object (Biobase package). From version 1.1
onwards, rHVDM won’t accept exprSet objects. To convert the old structure
into the new use the as command:

><ExpressionSet-object> <- as(<exprSet-object>,"ExpressionSet")

(cid:136) The expression values should be summarized (ie, probe level data will not work).

(cid:136) The expression values should be in “raw” form (ie not log-transformed).

In addition to expression values, estimates for the standard deviation of the measurement
error have to be supplied (in the se.exprs slot of the expression set). A “quick and
dirty” way to create some of those would be the following command (It creates a new
ExpressionSet ”on the ﬂy”):

> anothereset<-assayDataElementReplace(fiveGyMAS5,

se.exprs

,5 + exprs(fiveGyMAS5)*0.1)

’

’

This supposes the noise to be 10 percent of the signal intensity, plus an additive com-
ponent. Recall that this is a “quick and dirty” method.

From version 1.5 onwards, rHVDM implements, with some minor modiﬁcations, the

method described in the Genome Biology paper [1, 5, 6, 7].

5Under Linux, before launching the data command one needs to load the datasets library using

library(datasets).

6http://www.biomedcentral.com/1471-2105/7/251

6

> anothereset<-estimerrors(eset=fiveGyMAS5,plattid="affy_HGU133A")

The plattid parameter gives the plattform. To check what plattforms are available,
type the estimerrors command with no arguments.

Before carrying on with this session, we remove the spurious expression set:

> rm(anothereset)

as fiveGyMAS5 contains everything we need already. The pheno data of the expression
set should contain speciﬁc ﬁelds. To access this phenodata, use the Biobase command:

> pData(fiveGyMAS5)

cARP3-6hrs.CEL
cARP3-2hrs.CEL
cARP3-0hrs.CEL
cARP2-0hrs.CEL
cARP2-12hrs.CEL
cARP1-6hrs.CEL
cARP1-12hrs.CEL
cARP1-2hrs.CEL
cARP3-8hrs.CEL
cARP2-8hrs.CEL
cARP3-12hrs.CEL
cARP1-0hrs.CEL
cARP2-4hrs.CEL
cARP1-8hrs.CEL
cARP2-10hrs.CEL
cARP2-2hrs.CEL
cARP1-4hrs.CEL
cARP2-6hrs.CEL
cARP3-4hrs.CEL
cARP1-10hrs.CEL
cARP3-10hrs.CEL

replicate time experiment
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy
5Gy

6
2
0
0
12
6
12
2
8
8
12
0
4
8
10
2
4
6
4
10
10

3
3
3
2
2
1
1
1
3
2
3
1
2
1
2
2
1
2
3
1
3

The pheno data should contain at least three ﬁelds: replicate (even if there is only
one replicate), time and experiment. Of those three, only the time ﬁeld has to contain
numerical values (in the two other ﬁelds, entries can have a numeric or character format).
In addition, there should be a zero time point per (experiment/replicate), there should
be no duplicate time values per (experiment/replicate) and no negative time. The row
names in the pheno data should be consistent with the column names of the expression
matrix contained in the expression set. All these checks can be performed using the
rHVDM command:

7

> HVDMcheck(fiveGyMAS5)

This command returns only warnings and does not modify the object(s) under review.
If changes are necessary this is the responsibility of the user.

The pheno data will determine what part of the data set will be used to perform the
various HVDM steps. For example, one might want to exclude one of the replicates from
the analysis, while keeping intact the pheno data that sits inside the Biobase expression
set. The relevant rHVDM commands will thus accept “external” pheno data. Checking
this “external” pheno data is recommended and can also be done using HVDMcheck. For
example, we can exclude the third replicate from the pheno data

> norepl3<-pData(fiveGyMAS5)
> norepl3<-norepl3[norepl3$replicate!=3,]

and then check the pheno data is correct:

> HVDMcheck(fiveGyMAS5,pdata=norepl3)

Note than an eset has to be supplied to HVDMcheck in any case. As usual, command
vignettes are accessible using the question mark:

> ?HVDMcheck

Before carrying on, let us get rid of what will not be needed:

> rm(norepl3)

2.2 The training step

In the example data set, we are interested in the transcription factor p53. Before screen-
ing genes for p53 dependency, we need to uncover the “hidden” activity proﬁle of p53.
This is performed through the rHVDM training function. A list of known transcription
factor targets has to be supplied to the function. In the p53 example, known targets are
given in the p53traingenes vector, where individual entries are the corresponding gene
identiﬁers.

> tHVDMp53<-training(eset=fiveGyMAS5,genes=p53traingenes,
+

degrate=0.8,actname="p53")

It is very strongly recommended to supply, via the degrate argument, an independently
measured degradation rate (the importance of this will be illustrated below). Note that
this degradation rate must apply to the ﬁrst gene in the training set. So if the degradation
rate applies to another gene in the training set, the vector supplied to the genes argument
should be re-ordered accordingly. The actname argument is not compulsory but will help
make the reports clearer to read. It is also possible to ﬁt the model using only a subset
of the replicates and/or time points. This should be done by supplying an appropriately
formatted data frame to the training command via the pdata argument.

To examine the tHVDMp53 object that has been generated by the training function

use:

8

> HVDMreport(tHVDMp53)

This command creates an HTML-formatted report and places it in the working directory
so if one wants the report to be placed in a speciﬁc directory, this needs to be changed in
the R environment before running the HVDMreport command. By default, HVDMreport
generates a default name for the report, a user-speciﬁed name can be assigned using the
name argument, for example

> HVDMreport(tHVDMp53, name="myreport")

will generate a document named myreport.HTML in the current working directory. Doc-
uments generated by HVDMreport can be opened and read using standard web browsers.
The report for the training step comprises four sections

1. Training parameters.

This part of the report lists all the parameters that were supplied to the training
function (list of training genes, expression set used, etc.).

2. Model score.

The ﬁrst graph in the panel compares the model score to the chi-squared distri-
bution with an appropriate number of degrees of freedom (degrees of freedom =
data count - parameter count). The model score is signalled with red crosses. If
they are too much to the right of the distribution, the model score is too high
which means that the data is not well ﬁtted: one or more of the genes is probably
not a target, or is coregulated by another transcription factor; it is also possible
that the standard deviation for the measurement errors have been underestimated.
Alternatively, the crosses can be too much to the left which signify overﬁtting, in
which case, the standard deviations supplied are probably too high. The case un-
der review shows a desirable outcome. Below, we will give an example where the
outcome is not so good.

The right panel shows a quantile-quantile plot of the standardised deviations be-
tween the model and the data with respect to a standard Gaussian distribution.
Points should be aligned with the diagonal (as they are in the demonstrating anal-
ysis).

The series of three plots below show the contributions of individual genes and
individual time course (normalised by the number of time points in the third plot).
This is to help identify where problems may have occurred, for example if a gene
contributes disproportionately to the total model score the corresponding vertical
bar will be higher than the others. The last series of plots shows the contribution
of individual time points within time courses.

3. Parameter ﬁt.

9

The ﬁrst three ﬁgures in this section show a graph of the ﬁtted kinetic parameters,
along with a 95% conﬁdence interval. Note that if the hessian matrix is singular,
then these conﬁdence intervals cannot be determined, and it is better to assume
the worst case scenario, ie that they are very large. The second series of graphs
shows the transcription factor activity. Note that the ﬁrst time point (at zero
hours) is not ﬁtted and set by default to zero. This means that we are in fact
measuring the deviation from equilibrium of the transcription factor activity.

The Hessian matrix is both instrumental in the optimising procedure and useful in
computing conﬁdence intervals. The next ﬁgure in the ﬁt shows the distribution
of the eigenvalues of the Hessian matrix. This is useful in evaluating the quality
of the ﬁt. If there is a dominant eigenvalue (which is not the case here), then this
tells us something about the quality of the ﬁt. Below we will show an example of
such an instance.

Finally, The inverse of the Hessian matrix is an approximation of the covariance
matrix of the parameters (which is why one can estimate individual conﬁdence
intervals) and from the covariance matrix, the correlation matrix can be computed.
The correlation matrix is in the last part of the section. In some situations it might
be useful to know whether the parameters that are being ﬁtted are dependent
upon one another. For example a high basal rate of one particular gene might be
compensated by a higher sensitivity rate without aﬀecting the quality of the ﬁt (ie
the model score). Such an instance can be seen in the last section of the table, for
the gene 209295_at.

4. Comparison of model and data.

The last part of the report provides a visual comparison between the model (in
red) and the data (black). This further allows assessment of the quality of the ﬁt
and single out rogue genes and/or replicates. The errors bars indicate the 95%
conﬁdence interval for the measurement error, as provided by the user.

The report document contains hyperlinks to facilitate navigation. Note that it is possible
to extract more information from the object that has been generated by the training
function, this is explained in the third section of the present document. We will now
present two diﬀerent training steps where things go slightly wrong to learn how to read
these reports. First, we will try to run the training step without anchoring the model.
This is done simply by leaving the optional degrate argument empty:

> tHVDMp53na<-training(eset=fiveGyMAS5,genes=p53traingenes,actname="p53")

> HVDMreport(tHVDMp53na)

Contrasting this report with the previously generated one shows that anchoring the
ﬁtting can be quite beneﬁcial to the quality of the ﬁt. There is not much diﬀerence in
terms of model score (second section of the report), the non-anchored version is even

10

slightly better, the model score is lower. Equally, the fourth section shows that the data
is well ﬁtted by the model. The real diﬀerence can be seen in the third section (parameter
ﬁt). One can readily see that the conﬁdence intervals are really large both for the kinetic
parameters and, especially, the activity proﬁles. One can also notice that there is a single
dominant eigenvalue which indicates that the Hessian is badly conditioned and hence,
close to singularity. In this particular case the non-anchored solution is not too far oﬀ
the anchored one but this is purely coincidental. In any case, conﬁdence intervals that
are too large should be avoided.

We now try a ﬁnal training step, where things go decidedly wrong. Here, we introduce
a rogue gene in the training set that is not a p53 target. The aﬀy identiﬁer 202688_at
corresponds to the tumor necrosis factor member 10 (TNF10), but it is a ligand. The
real p53 target is the TNF10 receptor (and is already part of the training set)7.

> tHVDMp53b<-training(eset=fiveGyMAS5,genes=c(p53traingenes,"202688_at"),
+

degrate=0.8,actname="p53")

> HVDMreport(tHVDMp53b)

Problems can can be spotted in many places in this instance. Firstly, the model score is
way too high (section 2). Secondly, the parameter values of the newly introduced gene
are absurd (section 3). The hessian is singular (section 3). The model visibly struggles
to ﬁt the data for this particular gene (last panel of section 4). The fact that it is this
particular gene that causes problems can also be seen in the second panel of section 2 of
the report: this gene contributes to the total model score in a disproportionate manner.
Before moving on the the next section we can delete unwanted results of some training

steps we performed above (ie we keep only the tHVDMp53 object).

> rm(tHVDMp53na,tHVDMp53b)

2.3 Fitting individual genes and screening in batches

Now that the training step has been performed, we have all the ingredients to start
screening the rest of the transcripts. The activity proﬁles we have computed in the
previous section are contained in the tHVDMp53. To try individual genes, the fitgene
function can be used.

> gHVDMCD38<-fitgene(eset=fiveGyMAS5,gene="205692_s_at",tHVDM=tHVDMp53)

The minimal input to the fitgene function are, as above, the expression set(eset), the
gene name (gene) and the output of the training function (tHVDM). Other possible
inputs to the function are a ﬁrst guess for the parameters. This firstguess argument

7Note that because in this case things are problematic, the algorithm takes a long time to ﬁnd an

optimum.

11

should be either a vector with values for the basal rate, the sensitivity and the degrada-
tion rate (in that order), alternatively one can give as input to that argument the output
to a previous fitgene step (it does not even to be the same gene):

> gHVDMCD38<-fitgene(eset=fiveGyMAS5,gene="205692_s_at",tHVDM=tHVDMp53,
+

firstguess=gHVDMCD38)

However, the default setting consists of leaving the firstguess argument empty. In that
case a ﬁrst guess is generated internally and, in our experience, this seems to work ﬁne.
For example, the second fitgene step above is superﬂuous. To examine the outcome of
this individual gene ﬁtting step, the HVDMreport can again be used.

> HVDMreport(gHVDMCD38)

The sections of the HTML report are essentially the same as for the training step. Where
possible, comparisons with genes part of the training step are included. The gene under
review (CD38/205692 s at) is very likely to be a p53 target because the model score is
fairly low and the sensitivity Z-score is high. It is worth noting that this is a previously
unknown p53 target and its dependency status was conﬁrmed using an independent
experiment [1]). We can try to ﬁt another (non-p53 target) gene, we pick TNF10l,
which we encountered previously:

> gHVDMtnf10l<-fitgene(eset=fiveGyMAS5,gene="202688_at",tHVDM=tHVDMp53)

> HVDMreport(gHVDMtnf10l)

We already know that this particular gene is not a p53 target and this shows in the
report: the model score is very high, the sensitivity Z-score cannot even be computed
because the Hessian is singular (in this case, a default value of -1 is given) and ﬁnally,
absurd values for the kinetic parameters are returned.

It is also possible to screen in the same fashion a batch of genes using the screening

function (to screen all the genes in the list remove the square brackets).

> sHVDMp53<-screening(eset=fiveGyMAS5,genes=genestoscreen[1:5],HVDM=tHVDMp53)

The inputs for this function are more or less the same as for the individual gene ﬁtting
command, except that a ﬁrst guess option is not available. The genes argument accepts
vectors of gene identiﬁers. The genestoscreen instance is a list of ≈ 750 genes we
pre-selected that are signiﬁcantly upregulated and/or present at at least one point in
time in the context of this experiment. It is worth to avoid scanning the whole genome.
Although ﬁtting an individual gene can be done in a few seconds, those seconds add up
if 20k genes are screened! The above example should take approximately ﬁve minutes
on a standard personal computer (as of December, 2006).

Other arguments to the screening function are the various thresholds beyond which
individual genes will be considered to be targets of the transcription factor under review.

12

The cl1zscorelow argument is the bound above which a given sensitivity Z-score will
classify a gene as a putative transcription factor target. Likewise, the cl1modelscorehigh
is the bound for the model score. To be considered a target, the transcript must have a
model score below that bound. Finally, the cl1degraterange is the range (given as two
entries vector) within which the ﬁtted degradation rate must ﬁnd itself. To be considered
a target, a given gene must satisfy all three conditions. Default values are respectively
(2.5,100.0,c(0.05,5.0)). A list of putative p53 targets (collated in a data frame) can, in
our example, be obtained via the command

> p53targets<-sHVDMp53$results[sHVDMp53$results$class1,]

The ﬁeld class1 in the data frame ﬂags (TRUE/FALSE) the dependency status of
each individual gene. The thresholds values can be changed by running the screening
command again with revised bounds. Imagine for example that we want to be more
restrictive both on the model score and sensitivity Z-score criteria. This can be done by
plugging in the new bounds and in place of the training object, supplying the previously
obtained screening object:

> sHVDMp53<-screening(HVDM=sHVDMp53,cl1modelscorehigh=80.0,
+

cl1zscorelow=3.5)

The new list can be obtained as above. Note that in this new ”run” the eset and genes
arguments can be omitted as the original screening object contains all the necessary
information. In other words, actual ﬁtting of each gene is not performed once again.
The list of genes that are obtained after any screening step are, by default, ordered by
descending sensitivity Z-score. We found that, using an independent experiment [1], the
sensitivity Z-score is a better predictor of transcription factor dependency, genes at the
top the list are the most likely to be actual targets. Finally, the infamous HVDMreport
function can also be applied to the output of the screening function.

> HVDMreport(sHVDMp53)

The HTML ﬁle the function produces provides a wealth of information about the pa-
rameters of the original training (section 1) and screening (section 2) steps. In addition,
a count of the genes passing the various thresholds is produced (in section 3). A list of
putative targets is given in the ﬁnal, and fourth, section of the HTML document.

3 Accessing information in rHVDM objects

Objects generated by the training, screening and fitgene functions are not objects
in the strict R sense but mere lists which themselves contain other lists, vectors,
In this section we describe in some detail the
data.frames and character classes.
content of these objects in order for the end user to be able to access it and for example
to create their own charts etc.. When creating numeric R objects it is always possible

13

to label individual entries (in the case of a matrix, individual entries can be accessed by
their row and column labels). This possibility is fully exploited in rHVDM and the labels
are designed to be as explicit as possible, which should hopefully make data retrieving
relatively transparent.

3.1 List created by the training() function.

In R, names of list members can be accessed using the names function. Using this func-
tion with one of the lists created in the previous section with the training function
reveal that this lists comprises ten objects: tc, dm, par, pdata, distribute, re-
sults, scores, itgenes, eset, type. Accessing these members individually can be
done as usual using the R operator $, ie name_of_list$name_of_member.

The dm member.

This member is itself a list and it contains the data, the model ﬁt for the data and
the standard deviation of the measurement error. Each of these three are stored in ﬂat
vectors named respectively signal, estimate and sdev and stored as members or dm.
Each individual entry in these vectors is labelled by a character string comprising the
gene name, the name of the experiment, the name of the replicate and the time point,
in that order and separated by single dots. Going back to the example of the previous
section,

> tHVDMp53$dm$signal[paste("202284_s_at","5Gy","2",6,sep=".")]

202284_s_at.5Gy.2.6
313.5024

will return the measured expression at 6 hours for gene 202284_s_at in replicate 2 of
the 5Gy time course.

The par and distribute members.

The par member is itself a list containing, among others, the values of the parameters
of the model. These comprise the three kinetic parameters for each gene and the values
of the transcription factor activity for each time point in each time course and replicate.
These values are stored in the parameters member of par. The values are labelled using
dot separated labels. For example,

> tHVDMp53$par$parameters[paste("p53","5Gy","2",6,sep=".")]

p53.5Gy.2.6
218.6031

14

accesses the value for the activity of the transcription factor in the 6 hours data point
of replicate 2 of the 5Gy time course. Similarly, individual kinetic parameters can be
accessed by specifying the gene identiﬁer (203409_at), followed by the kinetic parameter
identiﬁer (Dj)

> tHVDMp53$par$parameters[paste("203409_at","Dj",sep=".")]

203409_at.Dj
0.2989867

Basal, sensitivity and degradation parameters are denoted with Bj, Sj, Dj. Some of
these parameters are ﬁxed (initial time points of the transcription factor activity proﬁle
are set to zero, and one or two parameters for the anchoring gene). A vector containing
the values of these ﬁxed parameters can be obtained using

> tHVDMp53$distribute$known

202284_s_at.Sj 202284_s_at.Dj
0.8

1.0
p53.5Gy.3.0
0.0

p53.5Gy.1.0
0.0

p53.5Gy.2.0
0.0

Conversely, the vector of free parameters labels is in the free of the distribute member,
therefore

> tHVDMp53$par$parameters[tHVDMp53$distribute$free]

p53.5Gy.1.2
202.4416486
p53.5Gy.1.10
137.1960408
p53.5Gy.2.6
218.6030859
p53.5Gy.3.2
231.9349796
p53.5Gy.3.10
138.9322073
203409_at.Sj
1.6526153
218346_s_at.Dj
0.4041790
209295_at.Bj
12.3201042

p53.5Gy.1.4
365.7310865
p53.5Gy.1.12
134.7814629
p53.5Gy.2.8
134.4525120
p53.5Gy.3.4
344.0454844

p53.5Gy.1.6
210.1534254
p53.5Gy.2.2
185.0595864
p53.5Gy.2.10
107.2278220
p53.5Gy.3.6
271.8306314
p53.5Gy.3.12 202284_s_at.Bj
6.6992269

p53.5Gy.1.8
141.0537131
p53.5Gy.2.4
306.9992291
p53.5Gy.2.12
152.1188719
p53.5Gy.3.8
153.9791938
203409_at.Bj
57.9463447
203409_at.Dj 218346_s_at.Bj 218346_s_at.Sj
0.4472608
205780_at.Dj
0.5874381

157.5026006

0.2989867
205780_at.Bj
30.3413971
209295_at.Sj
0.3892236

34.1479182
205780_at.Sj
0.6606399
209295_at.Dj
0.4345314

15

returns the (labelled) values of these free parameters. Other components of the par
and distribute members are of less direct interest here. These extra components in
distribute act as an interface between the training list and the Levenberg-Marquardt
optimiser, while the extra parameters in par specify the type of model to be used (we plan
to expand rHVDM for it to accommodate non-linearities in the response and multiple
transcription factor dependencies).

The scores member.

The total model score of equation (4) can be broken down by gene, time course etc.
These various score ventilations are collated in the scores member. The vector s2 is
the atomised version (it contains the breakdown for each possible (gene/ time point/
experiment/ replicate). The labelling of this vector is exactly the same as the one used
in the dm member. The scalar total contains the total model score. Between these
two extremes, bygenes is the distribution by gene, bytc by time course (a time course
is an experiment/replicate pair). bytcpertp is also the distribution by time course,
but divided by the number of points in the time course. Within time course score
distributions per time point are also provided. Since the number of time courses is not
predictable, the space to store these results is allocated dynamically in the withintc
list. Each (numbered) member of this list is itself a list that contains the time course
label (in the name slot) and the the score breakdown per time point (in score slot). For
example,

> tHVDMp53$scores$withintc[[1]]$score

0

10
1.326517 12.893795 3.258966 3.242109 4.321411 6.388368

2

4

6

8

12
2.471207

returns one of these within time course breakdowns.

The results member.

This member contains the output of the optimisation step. The hessian slot is the
hessian at the optimum.

Less interesting member (tc).

This list member contains technical information used for solving the model equation,
in particular the diﬀerential operator A mentioned in (3). This information has to be
determined for each time course independently and is dynamically stored in tc, which is
an indexed R list. Each of these slots is itself a list containing the name of the experiment
(experiment), replicate (replicate) the time values (time), the appropriate column

16

labels to access the data (explabel) and the diﬀerential operator (A). To view the latter
for the ﬁrst time course, type

> tHVDMp53$tc[[1]]$A

[,1]

[,3]

[,4]
[,2]
[1,] 0.0000000 0.00000000 0.00000000 0.00000000
[2,] -0.4722222 0.25000000 0.25000000 -0.02777778
[3,] 0.2152778 -0.66666667 0.25000000 0.22222222
[4,] 0.0000000 0.04166667 -0.33333333 0.00000000
[5,] 0.0000000 0.00000000 0.04166667 -0.33333333
[6,] 0.0000000 0.00000000 0.00000000 0.08333333
[7,] 0.0000000 0.00000000 0.00000000 0.00000000
[,6]

[,5]

[,7]
[1,] 0.00000000 0.00000000 0.00000000
[2,] 0.00000000 0.00000000 0.00000000
[3,] -0.02083333 0.00000000 0.00000000
[4,] 0.33333333 -0.04166667 0.00000000
[5,] 0.00000000 0.33333333 -0.04166667
[6,] -0.50000000 0.25000000 0.16666667
[7,] 0.25000000 -1.00000000 0.75000000

Least interesting members (pdata, eset, type, itgenes).

The remaining list members contain bookkeeping information. The pdata member is
simply a data.frame objet that is a copy of the pheno data that being used by the
training function and is either the pheno data of the expression set or, the alternative
pheno data fed to that function by the user. The eset member is the name of the Biobase
expression set and type indicates what kind of object we are dealing with. At the end
of each training set, a ”mini-screening” is performed with each member of the training
set for subsequent comparison purposes. The results of this screening are contained in
the itgenes member (a data.frame), whose formatting is similar to the one produced
by the screening command (see subsection 3.3).

3.2 List created by the fitgene() function.

The object generated by the fitgene function are structured exactly in the same manner
as the ones generated by the training and therefore contains the same members (refer
to the previous section, the member tset is a copy of the tset member of the training
object) plus a few extra ones. These are:

(cid:136) fguess: the ﬁrst guess generated inside the function or, alternatively, the one

supplied by the user.

17

(cid:136) tHVDMname: the name of the object generated by the training used in the fitgene

function.

3.3 List created by the screening() function.

The list created by the screening function comprises ﬁve members: results, tHVDM,
transforms, class1bounds, type. The last four contain essentially parameters that
were input to the function:

(cid:136) tHVDM: is a straight copy of the training object (see subsection 3.1).

(cid:136) transforms: indicates what kind of transformation, if any, was applied to the some
kinetic parameters, it is a vector whose character entries indicate the transformed
kinetic parameter. The function used for the transform is indicated in the labels.

(cid:136) class1bounds is a list collating the bounds governing whether individual genes
are classiﬁed as putative targets of the transcription factor of interest or not. The
member zscore is a lower bound for the sensitivity Z-score. If a gene’s sensitivity
Z-score is below this value, it will not be considered a target. The modelscore is
also a scalar, but it is an upper bound. Genes with a model score above this value
will not be considered targets. Finally, the degrate member of class1bounds is
vector containing the lower and upper bounds for the degradation rate.

The most important member of this list, however is the results member.
It is a
data.frame object in which each record collates the essential results of the screening for
each individual gene. This data frame comprises 14 columns:

(cid:136) model_score: The model score for the gene.

(cid:136) sens_z_score: The Z-score for the sensitivity.

(cid:136) basal: The basal transcription rate for the gene

(cid:136) sensitivity: The sensitivity to the transcription factor activity.

(cid:136) degradation: The degradation rate for the gene.

(cid:136) basal_d, basal_u: Respectively the lower and upper value for the 9% conﬁdence

interval of the basal rate.

(cid:136) sensitivity_d, sensitivity_u: Same as above, for the sensitivity.

(cid:136) degradation_d, degradation_u: Same as above, for the degradation.

(cid:136) class1: A boolean (True/False) specifying wether the gene belongs to the list of

putative targets.

18

(cid:136) hess_rank: The rank of the hessian matrix. If this is lower than 3, then the system
is singular and the corresponding gene is not a putative target (the conﬁdence
intervals and Z-scores cannot be computed in this case).

(cid:136) lm_message: Message returned by the optimising procedure.

4 Technical issues

4.1 How conﬁdence intervals are evaluated

As has been mentioned previously in this document, the Hessian at the optimal point,
as found by the Levenberg-Marquardt procedure(LM), is used to compute conﬁdence
intervals. This sounds straightforward but some peculiarities in our ﬁtting algorithm
make matters slightly more complicated. When ﬁtting the model, we advocate8 forcing
some parameters in the positive domain. This is done by feeding the LM procedure
with parameters that are ”free to roam” everywhere in the parameter space (including
negative portions of it). Before evaluating the model, however the exponential of these
”free” values is taken, forcing them to be positive. Another way of putting this is that the
values used in LM are log-transforms of the actual parameters values. Before looking at
this case, we examine the more straightforward situation where there is no forcing. We
assume that the hessian (H) has full rank and the vector of free parameters is denoted
by v (the way to extract these two objects is explained in section 3.1). The conﬁdence
interval bounds could then be obtained using

> Vcov<-solve(H)

#the variance-covariance matrix is obtained
#by inverting the hessian

> halfint<-1.96*diag(Vcov)^0.5 #Taking the square root of the diagonal

#of that matrix gives the standard
#deviation, multiplying by 1.96 gives
#the 95% half confidence interval.

> upperbound<-v+halfint #upper bound for c.i.
> lowerbound<-v-halfint #lower bound for c.i.

In the case mentioned above, the hessian is valid for (log-)transformed values (for some
parameters) and, consequently the conﬁdence intervals are ﬁrst computed in this domain
and then lifted in the non-transformed domain we are interested in. This is achieved
by running the following set of commands (we take as an example the training outcome
shown in the sample session in section 2):

> vcov<-solve(tHVDMp53$results$hessian)
> sdev<-1.96*diag(vcov)^0.5 #compute half confidence interval in

8It is, however, possible to relax this, see vignettes of the training, screening and fitgene func-

tions.

19

#transformed domain

(.importfree(HVDM=work,x=central[nams]+sdev[nams]))$par$parameters
#.importfree() imports the transformed values for the upper bound
#into the "work" object and performs the inverse transform (here, an
#exponential) upon import, a new HVDM object is returned by this
#command. The $par$parameters suffix extracts the parameter vector.
#Note that the upperbounds vector will contain all parameter values,
#ie not only those fitted in LM.

>
> work<-tHVDMp53 #create a copy of the example to work with
> central<-.exportfree(work) #extract transformed, fitted values
> nams<-names(central) #extract vector of labels
> upperbounds<-
+
>
>
>
>
>
>
>
> lowerbounds<-
+
>
>
> rm(work) #get rid of this no longer needed object

(.importfree(HVDM=work,x=central[nams]-sdev[nams]))$par$parameters
#a similar command is used to extract the lower bounds.

Note that this set of command will also work if no transform was used during the ﬁt.

5

Implementation notes and other practicalities

5.1 MacOSX 10.4

(cid:136) To run properly, the HVDMreport should have an X11 device. To do that in the R

session, select run X11 server from menu Misc.

(cid:136) rHVDM requires minpack.lm which in turn requires a FORTRAN compiler. In-

structions can be found here: http://cran.r-project.org/bin/macosx/RMacOSX-FAQ.
html#Fortran-compiler-_0028g77-3_002e3-or-later_0029. For this particu-
lar context, there does not need to be a match between the C and FORTRAN
compiler, as only the latter is used. Alternatively, binaries for the minpack.lm and
R2HTML packages can be found on the CRAN website http://cran.r-project.
org/. The Bioconductor packages and clear instructions on how to install them
can be found on the Bioconductor website http://www.bioconductor.org/docs/
install-howto.html.

5.2 Windows

(cid:136) To install rHVDM , we recommend using the binaries available on the bioconductor

website.

20

(cid:136) Windows binaries for two of the required packages (minpack.lm and R2HTML) can
be found on the CRAN website http://cran.r-project.org/. The Bioconductor
packages and clear instructions on how to install them can be found on the Bio-
conductor website http://www.bioconductor.org/docs/install-howto.html.

6 What’s new in version...

version 1.1

(cid:136) Updated the package so that it only accepts the new ExpressionSet. The old

exprsSet is deprecated (as in the rest of the Bioconductor project).

(cid:136) Vignettes and the present textual description are modiﬁed accordingly, with some

indications on how to transform the old input objects into new ones.

(cid:136) Corrected some typos in the present document.

version 1.2-1.4

(cid:136) version 1.2 was the release version of 1.1.

(cid:136) vesion 1.3 and 1.4 are identical to 1.2 (the numbers were bumped automatically

because of a Bioconductor update.

version 1.5

(cid:136) Computation of the measurement error for selected plattforms.

(cid:136) Update of the present document and vignettes.

version 1.6

(cid:136) Revert to older version (too many bugs in the error computation feature).

version 1.7.5 (devel) and 1.8.0 (release)

(cid:136) Re-introduction of computation of the measurement error.

version 1.8.1 and 1.9.1

(cid:136) Introduction of more axes labelling in the reports.

versions 1.9.2

(cid:136) Introduction of NAMESPACE feature

21

versions 1.9.3

(cid:136) Introduction of a new plattform for the measurement error estimation (aﬀy HG

ST1.0 array.)

versions 1.9.4

(cid:136) Introduction of new commands and data to accomodate a nonlinear formulation.
Individual vignettes are written. A full documentation will be done in susequent
version.)

versions 1.9.5

(cid:136) Changed the way the plattform-speciﬁc parameters are stored within the package.

Future updates

(cid:136) On-line generation of diagnostic graphs (to complement oﬀ-line HTML report gen-

eration).

(cid:136) Nonlinearities in the production function (mainly saturation but also threshold

eﬀects).

(cid:136) Repression

(cid:136) Multiple transcription factors dependencies.

(cid:136) Extension of the measurement error computation to more plattforms.

References

[1] M. Barenco, D. Tomescu, D. Brewer, R. Callard, J. Stark, and M. Hubank. Ranked
predictions of p53 targets using hidden variable dynamic modelling (hvdm). Genome
Biology, 7(3):R25, 2006.

[2] R. C. Gentleman and et al. Bioconductor: open software development for computa-

tional biology and bioinformatics. Genome Biol, 5(10):R80, 2004.

[3] Eric Lecoutre. The R2HTML package. R News, 3(3):33–36, December 2003.

[4] M. Barenco, J. Stark, D. Brewer, D. Tomescu, R. Callard, and M. Hubank. Correc-
tion of scaling mismatches in oligonucleotide microarray data. BMC Bioinformatics,
7:251, 2006. 1471-2105 (Electronic) Journal Article.

22

[5] J. Comander, S. Natarajan, Jr. Gimbrone, M. A., and G. Garcia-Cardena. Improving
the statistical detection of regulated genes from microarray data using intensity-based
variance estimation. BMC Genomics, 5(1):17, 2004. 1471-2164 Journal Article.

[6] A. Kamb and M. Ramaswami. A simple method for statistical analysis of intensity
diﬀerences in microarray-derived gene expression data. BMC Biotechnol, 1(1):8,
2001. 1472-6750 Journal Article.

[7] D. M. Rocke and B. Durbin. Approximate variance-stabilizing transformations for
gene-expression microarray data. Bioinformatics, 19(8):966–72, 2003. 22645880 1367-
4803 Journal Article.

23

