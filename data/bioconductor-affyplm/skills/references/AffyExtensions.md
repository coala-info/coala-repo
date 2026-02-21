affyPLM: Fitting Probe Level Models

Ben Bolstad
bmb@bmbolstad.com
http://bmbolstad.com

October 29, 2025

Contents

1 Introduction

2 Fitting Probe Level Models

2.1 What is a Probe Level Model and What is a PLMset? . . . . . . . . . . .
. . . . . . . . . . . . . . . . . .
2.2 Getting Started with the Default Model
. . . . . . . . . . . . . . . . . . . . . .
2.3 Getting Full Control over fitPLM
2.3.1 Pre-processing . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.2 Controlling what is Returned in the PLMset . . . . . . . . . . . .
2.3.3 Controlling how the model is fit . . . . . . . . . . . . . . . . . . .
2.4 Specifying models in fitPLM . . . . . . . . . . . . . . . . . . . . . . . . .
2.4.1 Notation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4.2 RMA style PLM . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4.3 PLM with chip-level factor and covariate variables . . . . . . . . .
2.4.4 Probe intensity covariate PLM . . . . . . . . . . . . . . . . . . . .
2.4.5 PLM with both probe types as response variables . . . . . . . . .
2.4.6 PLM with probe-effects estimated within levels of a chip-level fac-
tor variable . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4.7 PLM with probe-effect estimated within probe.type . . . . . . . .
2.4.8 PLM without chip level effects . . . . . . . . . . . . . . . . . . . .
2.4.9 PLM with only probe-effects . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4.10 Constraints

3 How long will it take to run the model fitting procedures?

4 Dealing with the PLMset object

A M-estimation: How fitPLM fits models

1

2

2
2
2
4
4
4
5
6
7
8
8
9
11

12
13
13
14
14

15

16

16

B Variance Matrix and Standard error estimates for fitPLM

17

1

Introduction

This majority of this document describes the fitPLM function. Other vignettes for affy-
PLM describe quality assessment tools and the threestep function for computing ex-
pression measures. After starting R, the package should be loaded using:

> library(affyPLM)
> require(affydata)
> data(Dilution)
> ##FIXME: drop this after Dilution is updated
> Dilution = updateObject(Dilution)
> options(width=36)

# an example dataset provided by the affydata package

this will load affyPLM as well as the affy package and its dependencies. The Dilution
dataset will serve as an example dataset for this document.

2 Fitting Probe Level Models

2.1 What is a Probe Level Model and What is a PLMset?

A probe level model (PLM) is a model that is fit to probe-intensity data. More specifi-
cally, it is where we fit a model with probe level and chip level parameters on a probeset
by probeset basis. It is easy to arrange the probe-intensity data for a probeset so that
the rows are probes and the columns are chips. In this case, our probe level parameters
could be factor variable for each probe. The chip level parameters might be a factor
variable with a level for each array, factor variables grouping the chips into treatment
groups or perhaps some sort of covariate variable (pH, temperature, etc).

A PLMset is an R object that holds the results of a fitted probe level model. Among
the items stored are parameter estimates and corresponding standard errors, weights
and residuals.

2.2 Getting Started with the Default Model

The main function for fitting PLM is the function fitPLM. The easiest way to call the
function is to call it by passing an AffyBatch object without any other arguments, this
will fit a linear model with an effect estimated for each chip and an effect for each probe.
This can be accomplished using:

> Pset <- fitPLM(Dilution)

2

Once you have a fitted model stored in a PLMset object the chip level parameter esti-
mates and the corresponding standard errors can be examined using the accessor func-
tions coefs and se respectively. For example, to examine the parameter estimates for
the first 5 probesets and their corresponding standard error estimates use:

> coefs(Pset)[1:5,]

20A

20B
7.712294 7.589361
1000_at
5.403364 5.246518
1001_at
1002_f_at 6.001354 5.842818
1003_s_at 6.682994 6.369082
6.265231 5.923743
1004_at
10B
7.604202 7.553845
1000_at
1001_at
5.273806 5.361613
1002_f_at 5.875315 5.901890
1003_s_at 6.497949 6.402645
6.150849 6.088775
1004_at

10A

> se(Pset)[1:5,]

20A

20B
1000_at
0.03798884 0.03674159
0.05850398 0.05889818
1001_at
1002_f_at 0.06684381 0.06552410
1003_s_at 0.06114870 0.05960099
0.05008044 0.04901129
1004_at
10B
0.03947771 0.03526104
1000_at
0.05917896 0.05606087
1001_at
1002_f_at 0.06373685 0.06468718
1003_s_at 0.06161744 0.06088377
0.04981253 0.04707150
1004_at

10A

Note that the default model is the RMA expression measure model. Specifically, the
default model is

log2 PMkij = βkj + αki + ϵkij

gene expression value on array j for probeset k and αki are probe
where βkj is the log2
effects. Note that to make the model identifiable the constraint (cid:80)I
i=1 αki = 0 is used.
Thus, for this default model, the parameter estimates given are gene expression values.

3

2.3 Getting Full Control over fitPLM

While the default model is very useful and simple to use, the fitPLM function also
provides the user with a great deal of control. Specifically, the user has the ability to
change the preprocessing, how the model is fitted and what output is returned.

2.3.1 Pre-processing

By default, the fitPLM function will preprocess the data using the RMA preprocessing
steps. In particular, it uses the same background and normalization as the rma function
of the affy package. It is possible to turn off either of these preprocessing steps by spec-
ifying that background and/or normalize are FALSE in the call to fitPLM. The arguments
background.method and normalize.method can be used to control which pre-processing
methods are used. The same preprocessing methods, as described in the threestep
vignette, may be used with the fitPLM function.

2.3.2 Controlling what is Returned in the PLMset

The PLMset that the fitPLM function returns contains a number of different quantities,
some of which are always returned such as parameter estimates and standard error
estimates and others which are more optional. The user can control whether weights,
residuals, variance-covariance matrices and residual standard deviations are returned.
By default, all of these items are returned, but in certain situations a user might find
it useful to exclude certain items to save memory. Control is via the output.param
argument which should be provided as a list. The default settings can be seen by typing

> verify.output.param()

$weights
[1] TRUE

$residuals
[1] TRUE

$varcov
[1] "none"

$resid.SE
[1] TRUE

Control of whether weights, residuals and residual standard deviations are returned is via
logical variables. There are three options varcov = "none", varcov = "chiplevel" and
varcov = "all" for variance covariance matrices. These correspond to, not returning
any variance estimates, only the portion of the variance covariance matrix related to

4

the chiplevel parameters or the entire variance covariance matrix respectively. When
each probeset has a large number of probes (or there are large numbers of parameters
in the model) the last option will return many large variance covariance matrices. The
following code returns a PLMset with no weights or residuals stored:

> Pset <- fitPLM(Dilution,output.param=list(residuals=FALSE,weights=FALSE))

2.3.3 Controlling how the model is fit

fitPLM implements iteratively re-weighted least squares M-estimation regression. Control
over how fitPLM carries out the model fitting procedure is given by the model.param
argument. This value of this parameter should be a list of settings. In particular, these
settings are the following:

• trans.fn which controls how the response variable is transformed. This value
should be a string. By default trans.fn="log2", but other possible options include:
"loge" or "ln" to use the natural logarithm, "log10" for logarithm base 10, "sqrt"
for square root and "cuberoot" to use a cubic root transformation.

• se.type which controls how the variance-covariance matrix is estimated in the M-
estimation procedure. Possible values are 1, 2, 3 or 4. See the Appendix for more
details.

• psi.type is a string which selects how the weights are computed in the robust
regression. By default psi.type="Huber". Other possible options include "fair",
"Cauchy", "Geman-McClure", "Welsch", "Tukey", and "Andrews". More details can
be found in the Appendix.

• psi.k is a numerical tuning constant used by psi.type. The default values are
dependent on the option chosen by psi.type. More details can be found in the
Appendix.

• max.its controls the maximum number of iterations of IRLS that will be used
in the model fitting procedure. By default max.its=20. Note, that this many
iterations may not be needed if convergence occurs.

• init.method controls how the initial parameter estimates are derived. By default
init.method="ls" ordinary least squares is used although "Huber" is also a possi-
bility.

• weights.chip are input weights for each chip in the dataset. This parameter should
be a vector of length number of arrays in the dataset. By default, every chip is
given equal weight.

5

• weights.probe are input weights for each probe in the dataset. This parameter
should be a vector of length number of probes in dataset (this length depends on
the response variable in the model). By default, every probe has equal weight.

As an example, we use model.param to control the fitting procedure so that it is fit
as a standard linear regression model (ie without robustness). This is accomplished by:

> Pset <- fitPLM(Dilution,model.param=list(max.its=0))

2.4 Specifying models in fitPLM

Although the default model is very useful, it is by no means the only model that can be
fitted using fitPLM. In this section we describe many, but certainly not all the different
types of models which may be fitted. In the example code presented here we will use
the subset argument to restrict model fitting to the first 100 probesets for speed. In any
real analysis model fitting would be carried out to all probesets on a particular array
type.

6

2.4.1 Notation

i
j
k
l
m
αki

αkim

αkil

Index for probes i = 1, . . . , Ik
Index for arrays j = 1, . . . , J
Index for probeset k = 1, . . . , K
Index for probe type l = 1, 2 where 1 is PM and 2 is MM.
Index for level of primary treatment factor variable m = 1, . . . , M
probe effect parameter for probe i
Included in the model by using probes
probe effect parameter for probe i estimated only for arrays where
primary treatment factor variable is level m
Included in the model by using treatment:probes
probe effect parameter for probe i estimated only for probes of
type l
Included in the model by using probe.type:probes

ϕkl

βkj

ϕklm

αkilm probe effect parameter for probe i estimated only for probes of
type l where primary treatment factor variable is level m
Included in the model by using treatment:probe.type:probes
array (chip) effect.
Included in the model by using samples
probe-type effect
Included in the model by using probe.types
probe-type effect for probe type l estimated only for arrays where
primary treatment factor variable is level m
Included in the model by using treatment:probe.types
probe-type effect for probe type l estimated only for array j
Included in the model by using samples:probe.types
a vector of chip-level parameters
an intercept parameter
a slope parameter
a processed probe-intensity. Typically on log2
an error term
measurements of chip-level factor and covariate variables for chip j
In the model descriptions below we will use treatment, trt.cov for these terms.
In practice these would be replaced with names of variables in the current
R environment or the phenoData of the supplied AffyBatch.

θ
µk
γk
ykijl
ϵkijl
xj

scale.

ϕklj

Since we are focusing on models that are fitted in a probeset by probeset manner for
brevity the subscript k will be omitted from further discussion. Note the terms probes,
samples and probe.types are considered reserved words when specifying a model to
fitPLM.

7

2.4.2 RMA style PLM

These are variations of the RMA model each consisting of models with chip and probe-
effects . The first, PM ∼ -1 + samples + probes, is the default model used when no
model is specified in the fitPLM call.

Model
yij1 = βj + αi + ϵij
yij1 = µ + βj + αi + ϵij
yij1 = βj + ϵij
yij1 = µ + βj + ϵij
yij2 = βj + αi + ϵij
yij2 = µ + βj + αi + ϵij
yij2 = βj + ϵij
yij2 = µ + βj + ϵij

fitPLM syntax
PM ∼ -1 + samples + probes
PM ∼ samples + probes
PM ∼ -1 + samples
PM ∼ samples
MM ∼ -1 + samples + probes
MM ∼ samples + probes
MM ∼ -1 + samples
MM ∼ samples

2.4.3 PLM with chip-level factor and covariate variables

These models use treatment variables as an alternative to sample effects for the chip
level factors.

j θ + αi + ϵij
j θ + ϵij
j θ + αi + ϵij
j θ + ϵij

fitPLM syntax
PM ∼ -1 + treatment + trt.cov + probes
PM ∼ -1 + treatment + trt.cov
MM ∼ -1 + treatment + trt.cov + probes
MM ∼ -1 + treatment + trt.cov

Model
yij1 = xT
yij1 = xT
yij2 = xT
yij2 = xT
For example to fit, a model with effects for both liver tissue concentration and scan-
ner along with probe effects with MM as the response variable to the first 100 probesets
of the Dilution dataset the following code would be used:

> Pset <- fitPLM(Dilution,

MM ~ -1 + liver + scanner + probes,subset = geneNames(Dilution)[1:100])

Examining the fitted chip-level parameter estimates for the first probeset via:

> coefs(Pset)[1,]

liver_10

scanner_2
6.26484583 6.41754460 -0.07134098

liver_20

shows that the treatment effect for scanner was constrained to make the model identifi-
able. fitPLM always leaves the first factor variable unconstrained if there is no intercept
term. All other chip level factor variables are constrained. The parameter estimates for
the probe effects can be examined as follows:

> coefs.probe(Pset)[1]

8

$`1000_at`

Overall
3.0216710
probe_1
probe_2
0.2126189
probe_3 -2.0222307
probe_4 -0.3203435
probe_5 -2.0974766
probe_6
3.3955995
probe_7 -2.7692459
probe_8 -3.5822543
probe_9 -1.2662559
probe_10 -1.3146932
probe_11 -0.8544930
probe_12 -2.0119851
3.0164205
probe_13
4.5947743
probe_14
1.8807170
probe_15

To make a treat a variable as a covariate rather than a factor variable the variable.type

argument may be used. For example, to fit a model with the logarithm of liver concen-
tration treated as a covariate we could do the following:

> logliver <- log2(c(20,20,10,10))
> Pset <- fitPLM(Dilution,model=PM~-1+probes+logliver+scanner, variable.type=c(logliver="covariate"),subset = geneNames(Dilution)[1:100])

Warning: No default variable type so assuming 'factor'

> coefs(Pset)[1,]

logliver

scanner_2
scanner_1
0.04494461 7.47722447 7.44720674

2.4.4 Probe intensity covariate PLM

This class of models allows the inclusion of PM or MM probe intensities as covariate
variables in the model. Note that the fitting methods currently used by fitPLM are ro-
bust, but not resistant (ie outliers in the response variable are dealt with, but outliers
in explanatory variables are not).

9

Model
yij1 = γyij2 + βj + αi + ϵij
yij1 = γyij2 + µ + βj + αi + ϵij
yij1 = γyij2 + βj + ϵij
yij1 = γyij2 + µ + βj + ϵij
yij2 = γyij1 + βj + αi + ϵij
yij2 = γyij1 + µ + βj + αi + ϵij
yij2 = γyij1 + βj + ϵij
yij2 = γyij1 + µ + βj + ϵij
yij1 = xT
yij1 = xT
yij2 = xT
yij2 = xT
To fit a model with an intercept term, MM covariate variable, sample and probe ef-
fects use the following code:

fitPLM syntax
PM ∼ -1 + MM + samples + probes
PM ∼ MM + samples + probes
PM ∼ -1 + MM +samples
PM ∼ MM + samples
MM ∼ -1 + PM + samples + probes
MM ∼ PM + samples + probes
MM ∼ -1 + PM +samples
MM ∼ PM + samples
PM ∼ MM + treatment + trt.cov + probes
PM ∼ MM + treatment + trt.cov
MM ∼ PM + treatment + trt.cov + probes
MM ∼ PM + treatment + trt.cov

j θ + γyij2 + αi + ϵij
j θ + γyij2 + ϵij
j θ + γyij1 + αi + ϵij
j θ + γyij1 + ϵij

> Pset <- fitPLM(Dilution,

PM ~ MM + samples + probes,subset = geneNames(Dilution)[1:100])

We can examine the various parameter estimates for the model fit to the first probeset

using:

> coefs(Pset)[1,]

10B
-0.01390033 -0.02593732 -0.05154342

20B

10A

> coefs.const(Pset)[1,]

MM
Intercept
6.9439916 0.1131364

> coefs.probe(Pset)[1]

$`1000_at`

Overall
probe_1
-0.09248614
probe_2
0.05086713
probe_3
-2.05564830
probe_4
1.55090007
probe_5
-1.63841905
probe_6
1.05603587
probe_7
-3.40366080
probe_8
-1.07325873
0.18670389
probe_9
probe_10 -0.52200547

10

probe_11 -0.85784749
0.73605865
probe_12
2.18822218
probe_13
2.96008104
probe_14
1.31332885
probe_15

As can be seen by this example code intercept and covariate parameters are accessed
using coefs.const.

2.4.5 PLM with both probe types as response variables

It is possible to fit a model that uses both PM and MM intensities as the response
variable. This is done by specifying PMMM as the response term in the model. When
both PM and MM intensities are used as the response, there is a special reserved term
probe.type which may (optionally) be used as part of the model specification. This term
designates that a probe type effect (ie whether PM or MM) should be included in the
model.

Model
yijl = βj + ϕj + αi + ϵijl
yijl = µ + βj + ϕj + αi + ϵijl
yijl = βj + ϕj + ϵijl
yijl = µ + βj + ϕj + ϵijl
yijl = xT
yijl = xT
yijl = xT
yijl = xT
For example to fit such a model with factor variables for liver RNA concentration,
probe type and probe effects use:

fitPLM syntax
PMMM ∼ -1 + samples + probe.type + probes
PMMM ∼ samples + probe.type + probes
PMMM ∼ -1 + samples+ probe.type
PMMM ∼ samples+ probe.type
PMMM ∼ treatment + trt.cov + probe.type + probes
PMMM ∼ treatment + trt.cov + probe.types
PMMM ∼ treatment + trt.cov + probe.type + probes
PMMM ∼ treatment + trt.cov + probe.type

j θ + ϕj + αi + ϵijl
j θ + ϕj + ϵijl
j θ + ϕj + αi + ϵijl
j θ + ϕj + ϵijl

> Pset <- fitPLM(Dilution,

PMMM ~ liver + probe.type + probes,subset = geneNames(Dilution)[1:100])

Examining the parameter estimates:

> coefs(Pset)[1,]

[1] 0.06796632

> coefs.const(Pset)[1,]

Intercept probe.type_MM
-1.317395

7.597301

> coefs.probe(Pset)[1]

11

$`1000_at`

Overall
1.6712982
probe_1
probe_2
0.1412111
probe_3 -2.1775557
probe_4
0.6740782
probe_5 -2.0523876
probe_6
2.3925977
probe_7 -3.2392634
probe_8 -2.6055623
probe_9 -0.5632586
probe_10 -0.9691117
probe_11 -0.9129540
probe_12 -0.7431879
2.7703955
probe_13
4.0347865
probe_14
1.7050728
probe_15

shows that probe type estimates are also accessed by using coefs.const.

2.4.6 PLM with probe-effects estimated within levels of a chip-level factor

variable

It is also possible to estimate separate probe-effects for each level of a chip-level factor
variable.

j θ + αim + ϵij1

Model
yij1 = xT
yij1 = yij2γ + xT
yijl = xT
Fitting such a model with probe effects estimated within the levels of the liver vari-
able is done with:

fitPLM syntax
PM ∼ treatment:probes + treatment + trt.cov
PM ∼ MM + treatment + treatment:probes + trt.cov
PMMM ∼ treatment + trt.cov + treatment:probes

j θ + ϕj + αim + ϵijl

j θ + αim + ϵij1

> Pset <- fitPLM(Dilution,

PM ~ -1 + liver + liver:probes,subset = geneNames(Dilution)[1:100])

Examining the estimated probe-effects for the first probeset can be done via:

> coefs.probe(Pset)[1]

$`1000_at`

probe_1
probe_2
probe_3

liver_10:
0.45658552
0.09857862

liver_20:
0.18539206
0.03521846
-2.32629757 -2.26742904

12

1.56680474

1.41541418

probe_4
1.44646328
probe_5 -1.79470843 -2.21774179
1.46642950
probe_6
probe_7 -3.73516433 -3.50762769
probe_8 -1.66741086 -1.29889473
probe_9 -0.02414340
0.07770227
probe_10 -0.77865227 -0.47421776
probe_11 -0.95612811 -0.97135598
0.60090422
probe_12
2.57311873
probe_13
3.39711587
probe_14
1.42011704
probe_15

0.37531107
2.46981266
3.54667188
1.63293065

2.4.7 PLM with probe-effect estimated within probe.type

Probe effects can also be estimated within probe type or within probe type for each level
of the primary treatment factor variable.

Model
yijl = xT
yijl = xT

j θ + αil + ϵij1
j θ + αilm + ϵij1

fitPLM syntax
PMMM ∼ treatment + trt.cov + probe.type:probes
PMMM ∼ treatment + trt.cov + treatment:probe.type:probes

As an example, use the following code to fit such models and then examine the pos-
sible

> Pset <- fitPLM(Dilution,
> coefs.probe(Pset)[1]

> Pset <- fitPLM(Dilution,
> coefs.probe(Pset)[1]

PMMM ~ -1 + liver + probe.type:probes,subset = geneNames(Dilution)[1:100])

PMMM ~ -1 + liver + liver:probe.type:probes,subset = geneNames(Dilution)[1:100])

2.4.8 PLM without chip level effects

It is possible to fit models which do not have any chip-level variables at all. If this is the
case, then the probe type effect takes precedence over any probe effects in the model.
That is it will be unconstrained.

Model
yijl = αi + ϕjl + ϵijl
yijl = µ + ϕjl + αi + ϵijl
yijl = ϕl + αim + ϵijl
yijl = µ + ϕl + αim + ϵijl
yijl = µ + ϕlj + αim + ϵijl
yijl = µ + ϕlm + αim + ϵijl

fitPLM syntax
PMMM ∼ -1 + probe.type + probes
PMMM ∼ probe.type + probes
PMMM ∼ -1 + probe.type + treatment:probes
PMMM ∼ probe.type + treatment:probes
PMMM ∼ samples:probe.type + treatment:probes
PMMM ∼ treatment:probe.type + treatment:probes

13

2.4.9 PLM with only probe-effects

It is also possible to fit models where only probe effects alone are estimated.

+ ϵij1

Model
yij1 = αi + ϵij1
yij1 = µ + αi + ϵij1
yij1 = alphaim + ϵij1
yij1 = µ + (θα)imj
yij2 = αi + ϵij2
yij2 = µ + αi + ϵij2
yij2 = αim + ϵij2
yij2 = µ + αim + ϵij2
yijl = αi + ϵijl
yijl = µ + αi + ϵijl
yijl = αim + ϵijl
yijl = µ + αim + ϵijl

fitPLM syntax
PM ∼ -1 + probes
PM ∼ probes
PM ∼ -1 + treatment:probes
PM ∼ treatment:probes
MM ∼ -1 + probes
MM ∼ probes
MM ∼ -1 + treatment:probes
MM ∼ treatment:probes
PMMM ∼ -1 + probes
PMMM ∼ probes
PMMM ∼ -1 + treatment:probes
PMMM ∼ treatment:probes

2.4.10 Constraints

These are the constraints that will be imposed to make the models identifiable (when
needed):

Parameter Constraints
βi
ϕl
ϕlj
ϕlm
αi
αim
αil
αilm

Default
j=0 βi = 0 or β1 = 0
β1 = 0
l=1 ϕl = 0 or ϕ1 = 0
ϕ1 = 0
l=1 ϕlj = 0 or ϕ1j = 0
ϕ1j = 0
l=1 ϕlm = 0 or ϕ1m = 0
ϕ1m = 0
(cid:80)I
i=0 αi = 0 or α1 = 0
i=0 αim = 0 or α1m = 0 (cid:80)I
(cid:80)I
i=0 αil = 0 or α1l = 0
i=0 αilm = 0 or α1lm = 0 (cid:80)I

(cid:80)J
(cid:80)2
(cid:80)2
(cid:80)2
(cid:80)I
(cid:80)I
(cid:80)I
(cid:80)I

i=0 αi = 0
i=0 αim = 0
i=0 αil = 0
i=0 αilm = 0

In general, there is a general hierarchy by which items are left unconstrained:

intercept > treatment > sample > probe.type > probes

the highest term in this hierarchy that is in a particular model is always left un-
constrained, everything else will be constrained. So for example a model containing
probe.type and probe effects will have the probe.type effects unconstrained and the
probe effects constrained.

Constraints are controlled using the constraint.type argument which is a vector
with named items should be either "contr.sum" or "contr.treatment". The names for
this vector should be names of items in the model.

> data(Dilution)

14

> ##FIXME: remove next line
> Dilution = updateObject(Dilution)
> Pset <- fitPLM(Dilution, model = PM ~ probes + samples,constraint.type=c(samples="contr.sum"),subset = geneNames(Dilution)[1:100])

Warning: No default constraint specified. Assuming 'contr.treatment'.

> coefs.const(Pset)[1:2]

[1] 7.633951 5.368074

> coefs(Pset)[1:2,]

20B
0.03532897 0.008747425
1000_at
1001_at -0.02135238 0.033203170

20A

10A
1000_at -0.005110253
1001_at -0.033062279

3 How long will it take to run the model fitting pro-

cedures?

It may take considerable time to run the fitPLM function. The length of time it is going
to take to run the model fitting procedure will depend on a number of factors including:

1. CPU speed

2. Memory size of the machine (RAM and VM)

3. Array type

4. Number of arrays

5. Number of parameters in model

It is recommended that you run the fitPLM function only on machines with large
amounts of RAM. If you have a large number of arrays the number of parameters in
your model will have the greatest effect on runtime.

15

4 Dealing with the PLMset object

As previously mentioned, the results of a call to fitPLM are stored in a PLMset object.
There are a number of accessor functions that can be used to access values stored in a
PLMset including:

• coefs and se: access chip-level factor/covariate parameter and standard error

estimates.

• coefs.probe and se.probe: access probe effect parameter and standard error esti-

mates.

• coefs.const and se.const: access intercept, MM covariate and probe type effect

parameter and standard error estimates.

• weights: access final weights from M-estimation procedure. Note that you may
optionally supply a vector of probeset names as a second parameter to get weights
for only a subset of probes.

• resids: access residuals. Note that you may optionally supply a vector of probeset

names as a second parameter to get residuals for only a subset of probes.

• varcov: access variance matrices.

A M-estimation: How fitPLM fits models

Suppose we wish to fit the following model

yi = f (xi, θ) + ϵi

(1)

where yi is a response variable, xi is a vector of explanatory variables, and θ is a vector
of parameters to be estimated. An estimator of θ is given by

minθ

N
(cid:88)

i=1

(yi − f (xi, θ))2

(2)

which is the known least squares estimator. In some situations, outliers in the response
variable can have significant effect on the estimates of the parameters. To deal with
potential problem we need a robust method of fitting the model. One such method is
known as M -estimation. An M -estimator for this regression, taking into account scale,
is the solution of

minθ

N
(cid:88)

i=1

(cid:18) yi − f (xi, θ)
s

ρ

(cid:19)

16

(3)

where ρ is a suitable function. Reasonable properties for ρ include symmetry ρ(x) =
ρ(−x), a minimum at ρ(0) = 0, positive ρ(x) ≥ 0 ∀x and increasing as the absolute value
of x increases, i.e. ρ(xi) ≥ ρ(xj) if |xi| > |xj|. Furthermore, there the need to estimate
s, where s is a scale estimate. One approach is to estimate both s and θ using a system
of equations. The approach that we use is to estimate s using the median absolute
deviation (MAD) which provides a robust estimate of scale. The above equation leads
to solving

N
(cid:88)

(cid:18) yi − f (xi, θ)
s
where ψ is the derivative of ρ. Note that strictly speaking, for robustness, ψ should
be bounded. Now define ri = yi−f (xi,θ)
. Then the
previous equation can be rewritten as

and a weight function w (ri) = ψ(ri)
ri

= 0.

(4)

i=1

(cid:19)

ψ

s

N
(cid:88)

i=1

w (ri) ri = 0

(5)

which is the same as the set of equations that would be obtained if we were solving the
iteratively re-weighted least squares problem

min

N
(cid:88)

i

(cid:16)

w

r(n−1)
i

(cid:17)

2

r(n)
i

(6)

where the superscript (n) represents the iteration number. More details about M-
estimation can be found in Huber (1981). Tables 1 and 2 describe the various different
weight functions and associated default constants provided by fitPLM.

B Variance Matrix and Standard error estimates for

fitPLM

Huber (1981) gives three forms of asymptotic estimators for the variance-covariance
matrix of parameter estimates ˆb.

(X T X)−1

κ2

(cid:80) ψ2/(n − p)
((cid:80) ψ′/n)2
(cid:80) ψ2/(n − p)
(cid:80) ψ′/n

κ

V −1

where

(cid:80) ψ2
n − p

1
κ

V −1 (cid:0)X T X(cid:1) V −1

κ = 1 +

p
n

Var (ψ′)
Eψ′

17

(7)

(8)

(9)

(10)

if |x|≤ k
if |x|> k

Method
(cid:40)

Huber

fair

Cauchy

Geman-McClure

Welsch

(cid:40)

Tukey

Andrews

if |x|≤ c
if |x|> c
(cid:40)

if |x|≤ kπ
if |x|> kπ

ρ(x)

ψ(x)

(cid:40)

x2/2
k (|x|−k/2)
1 + |x|
c − log
c
2 log (cid:0)1 + (x/c)2(cid:1)

(cid:16)

c2

c2 (cid:16) |x|

(cid:17)(cid:17)

x2/2
1+x2
(cid:16)
(cid:16)
(cid:1)2(cid:17)(cid:17)
1 − exp
1 − (cid:0)1 − (x/c)2(cid:1)3(cid:17)

− (cid:0) x
c

(cid:16)

c2
2
(cid:40) c2
6
c2
6
(cid:40)

k2(1 − cos(x/k))
2k2

(cid:40)

x
ksgn(x)
x
1+ |x|
c
x
1+(x/c)2
x
(1+x2)2
x exp (cid:0)−(x/c)2(cid:1)
x (cid:0)1 − (x/c)2(cid:1)2
0
(cid:40)

k sin(x/k)
0

(cid:40)

w(x)
(cid:40)
1
k
|x|
1
1+ |x|
c
1
1+(x/c)2
1
(1+x2)2
exp (cid:0)−(x/c)2(cid:1)
(cid:40)(cid:0)1 − (x/c)2(cid:1)2

0

(cid:40) sin(x/k)
x/k

0

Table 1: ρ, ψ and weight functions for some common M-estimators.

Method Tuning Constant
1.345
Huber
1.3998
fair
2.3849
Cauchy
2.9846
Welsch
4.6851
Tukey
1.339
Andrews

Table 2: Default tuning constants (k or c) for M-estimation ρ, ψ and weight functions.

18

V = X T Ψ′X
and Ψ′ is a diagonal matrix of ψ′ values. When using fitPLM these are selected using
se.type=1, se.type=2, or se.type=3 respectively. Treating the regression as a weighted
least squares problem would give

(11)

(cid:80) w(ri)r2
n − p

i

(cid:0)X T W X(cid:1)−1

(12)

as the estimator for variance covariance matrix, where W is a diagonal matrix of weight
values. This option is selected by using se.type=4.

References

B. M. Bolstad. Low Level Analysis of High-Density Oligonucleotide Data: Background,
Normalization and Summarization. PhD thesis, University of California, Berkeley,
2004.

B. M. Bolstad, R. A. Irizarry, M. Astrand, and T. P. Speed. A comparison of normaliza-
tion methods for high density oligonucleotide array data based on variance and bias.
Bioinformatics, 19(2):185–193, Jan 2003.

P. J. Huber. Robust statistics. John Wiley & Sons, Inc, New York, New York, 1981.

R. A. Irizarry, B. M. Bolstad, F. Collin, L. M. Cope, B. Hobbs, and T. P. Speed.
Summaries of Affymetrix GeneChip probe level data. Nucleic Acids Res, 31(4):e15,
Feb 2003a.

R. A. Irizarry, B. Hobbs, F. Collin, Y. D. Beazer-Barclay, K. J. Antonellis, U. Scherf,
and T. P. Speed. Exploration, normalization, and summaries of high density
oligonucleot ide array probe level data. Biostat, 4(2):249–264, 2003b. URL http:
//biostatistics.oupjournals.org/cgi/content/abstract/4/2/249.

19

