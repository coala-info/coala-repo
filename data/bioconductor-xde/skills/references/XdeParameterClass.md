The XdeParameter Class

Håkon Tjelmeland and Robert B. Scharpf

October 30, 2025

1

Introduction

The goal of this vignette is to briefly describe the Bayesian hierarchical model to estimate differential
expression across multiple studies. This vignette necessarily assumes familiarity with hierarchical models
and Bayesian methods of computation, such as MCMC. After reading this vignette, one should be able
to:

• create an instance of the XdeParameter class that will provide all the necessary parameters for

fitting the Bayesian model, including starting values of all the MCMC chains

• change values from their default setting to custom setting. This includes

– changing the values of any of the hyperparameters
– changing the starting values of the MCMC chains
– change the number of updates per MCMC iteration for any of the parameters
– store all, some, or none of the MCMC chains

Apart from these pragmatic goals, the vignette provides a means to look-up the role of any parameters
in our formulation of the Bayesian model. A more detailed discussion of the Bayesian model is provided
elsewhere [? ]. If you are content with the default settings provided when creating an instance of the
XdeParameter class, fitting the model, assessing convergence, and generating alternative measures of
differential expression are discussed in the XDE vignette.

2 The Stochastic Model

Let xgsp denote observed expression value for gene g ∈ {1, . . . , G} and sample (array) s ∈ {1, . . . , Sq} in
study p ∈ {1, . . . , P }, where P ≥ 2. We assume that some clinical variable (with two possible values) is
available for each of the arrays in all studies. We denote this by ψsp ∈ {0, 1} for sample (array) number
s in study number p. We will assume that the studies have been somehow standardized so that the
values in each study is centered around zero and are approximately Gaussian distributed.

Our model defined below is based on the following assumptions, (i) for some of the genes, the expression
values xgsp are differentially expressed (have different mean values) for arrays where ψsp = 0 and arrays
where ψsp = 1, and (ii) any gene is either differentially expresses in all studies or in no studies (the

1

“δg” model). Assumption (ii) can be relaxed by fitting the “δgp” model that allows for a given gene to
be differentially expressed in some studies but not in others. The following description of the Bayesian
model is for the δg" model. The δgp model is very similar, substituting δgp for δg and independent beta
priors with parameter ξp instead of ξ.

We assume the following hierarchical Bayesian model for the expression data. Conditionally on underly-
ing unobserved parameters we assume the expression values to be independently Gaussian distributed,

xgsp| . . . ∼ N(νgp + δg(2ψsp − 1)∆gp, σ2

gψspp),

(1)

where δg ∈ {0, 1} indicates whether gene g is differentially expressed (δg = 1) or not (δg = 0). Thus,
if δg = 0, the mean of xgsp is νgp, whereas if δg = 1, the mean is νgp − ∆gp and νgp + ∆gp for samples
with ψsp = 0 and ψsp = 1, respectively.

Given hyper-parameters, we assume νg = (νg1, . . . , νgP )T and ∆g = (∆g1, . . . , ∆gP )T to be multi-
Gaussian distributed,

where Σ = [Σpq] ∈ ℜP ×P and R = [Rpq] ∈ ℜP ×P with

νg| . . . ∼ N(0, Σ)

and ∆g| . . . ∼ N(0, R),

Σpq = γ2ρpq

(cid:113)

p τ 2
τ 2

q σ2ap

gp σ2aq
gq

(2)

(3)

and

τ 2
p τ 2
The ap and bp, p = 1, . . . P are assumed apriori independent with discrete probabilities in 0 and 1 and
a continuous density on (0, 1). More precisely, we let

Rpq = c2rpq

q σ2bp

gp σ2bq
gq .

(4)

(cid:113)

P(ap = 0) = p0
a

, P(ap = 1) = p1
a

, ap|ap ∈ (0, 1) ∼ Beta(αa, βa),

(5)

and

,

, P(bp = 1) = p1
P(bp = 0) = p0
b
b
is a parameter specified by the user,
To c2 we assign a uniform prior distribution on [0, c2
Max], where c2
p > 0, p = 1, . . . , P and
and for γ2 we use an improper uniform distributions on (0, ∞). We restrict τ 2
P ) under this restriction.
P = 1 and assume an (improper) uniform distribution for (τ 2
1 , . . . , τ 2
τ 2
1 · . . . · τ 2
The [ρpq] ∈ ℜP ×P and [rpq] ∈ ℜP ×P are restricted to be correlation matrices and we assign apriori
independent Barnard et al (2000) distributions for them, with νρ and νr degrees of freedom for [ρpq]
and [rpq], respectively.

bp|bp ∈ (0, 1) ∼ Beta(αb, βb).

(6)

Max

We assume the indicators δ1, . . . , δG to be apriori independent, given a hyper-parameter ξ, with

P(δg = 1|ξ) = ξ,

where

ξ ∼ Beta(αξ, βξ).

We assume σ2
gp

in (3) to be given from σ2

gψp

in (1) via the following relations

g0p = σ2
σ2

gpφgp

and

σ2
g1p =

σ2
gp
φgp

.

For σ2
gp

we assume independent prior distributions, given hyper-parameters,

gp| . . . ∼ Gamma
σ2

(cid:32)

(cid:33)

,

l2
p
tp

,

lp
tp

2

(7)

(8)

(9)

where the mean lp and variance tp for p = 1, . . . , P are assigned independent (improper) uniform
distributions on (0, ∞). The φgp are assigned independent gamma priors, given hyper-parameters,

φgp| . . . ∼ Gamma

(cid:32)

(cid:33)

,

λ2
p
θp

,

λp
θp

(10)

where the mean λp and the variance θp for p = 1, . . . , P are assigned independent (improper) uniform
distributions on (0, ∞).

3 Metropolis-Hastings algorithm

To simulate from the posterior distribution resulting from the above specified Bayesian model, we use
a Metropolis–Hastings algorithm. Default values for the tuning parameters in this algorithm and how
these tuning parameters may be modified are discussed in Section 4. The Metropolis–Hastings algorithm
uses the following moves:

1. The νpg’s are updated in a Gibbs step.

2. The ∆pg’s are updated in a Gibbs step.

3. Each ap, p = 1, . . . , P is updated in turn, where a potential new value for ap,

follows. If ap = 0,

(cid:101)ap ∼ Uniform(0, ε), if ap = 1,

(cid:101)ap, is generated as
(cid:101)ap ∼ Uniform(1 − ε, 1), and if ap ∈ (0, 1) we use
(11)

P((cid:101)ap = 0) = max{−(ap − ε), 0} · I(p0
P((cid:101)ap = 1) = max{ap + ε − 1, 0} · I(p1

a ̸= 0),

a ̸= 0)

(12)

and

(cid:101)ap|(cid:101)ap ∈ (0, 1) ∼ Uniform(max{ap − ε, 0}, min{ap + ε, 1}).
4. Each bp, p = 1, . . . , P is updated in turn, where the proposal distribution is of the same type as

(13)

in 3.

5. A block Gibbs update for c2 and ∆g for g’s where δg = 0.

6. The γ2 is updated in a Gibbs step.

7. A block update for the correlation matrix [rpq] and the variance c2. First, potential new values

for [rpq], [(cid:101)rpq], is set by

(cid:101)rpq = (1 − ε)rpq + εTpq,
where [Tpq] is a correlation matrix which with probability a half is generated from the prior for
[rpq], or with probability a half set equal to unity on the diagonal and with all off diagonal elements
set equal to the same value b. In the latter case, the value b is sampled from a uniform distribution
on (−1/(P − 1), 1). Second, the potential new value for c2 is sampled from the corresponding full
conditional (given the potential new values [(cid:101)rpq]). The ε is a tuning parameter.

(14)

8. A block update for the correlation matrix [ρpq] and the variance γ2. The potential new values are

generated similar to what is done in 7.

9. For each g = 1, . . . , G in turn, a block update for δg and ∆g. First, the potential new value for
δg is set equal to (cid:101)δg = 1 − δg. Second, the potential new value for ∆g is sampled from the full
conditional (given the potential new value (cid:101)δg). No tuning parameter for this update.

3

10. The ξ is updated in a Gibbs step.

11. Each σ2
gp

is updated in turn, where the potential new value is given as

u ∼ Uniform(1/(1 + ε), 1 + ε). The ε is a tuning parameter.

gp = σ2
(cid:101)σ2

gp · u, where

12. Each tp, p = 1, . . . , P is updated in turn. The potential new value is given as (cid:101)tp = tp · u, where

u ∼ Uniform(1/(1 + ε), 1 + ε). The ε is a tuning parameter.

13. Each lp, p = 1, . . . , P is updated in turn. The potential new value is given as (cid:101)lp = lp · u, where

u ∼ Uniform(1/(1 + ε), 1 + ε). The ε is a tuning parameter.

14. Each φgp is updated in turn, where the proposal distribution is of the same type as in 11.

15. Each θp, p = 1, . . . , P is updated in turn, where the proposal distribution is of the same type as

in 12.

16. Each λp, p = 1, . . . , P is updated in turn, where the proposal distribution is of the same type as

in 13.

17. The (τ 2

1 , . . . , τ 2

p ̸= q. Potential new values for τ 2
p

and τ 2
q

P ) is updated by first uniformly at random drawing a pair p, q ∈ {1, . . . , P } so that
are generated by setting

where u ∼ Uniform(1/(1 + ε), 1 + ε). The ε is again a tuning parameter.

p = τ 2
(cid:101)τ 2

p · u

and

q = τ 2
(cid:101)τ 2

q /u,

(15)

4 The XdeParameter class

The Bayesian hierarchical model can be tuned and output modified in a number of ways. The XdeParameter
class is an effort to organize these options and to facilitate tweaking. In our experience, it is easier to
change and keep track of the parameters in the class than to provide a function for fitting the model
with numerous arguments. The XdeParameter class is not a container for the gene expression data (see
ExpressionSetList in the XDE vignette).

4.1

Initializing the XdeParameter class

There are numerous options for customizing the fit of the Bayesian model as well as the output. Default
values are defined in the initialization method for the XdeParameter class. Initialization requires an
object of class ExpressionSetList and the name of the classification variable used to define differential
expression.
(The initialization method will produce an error if the supplied phenotypeLabel is not
present in the varLabels of each element of the ExpressionSetList). Using the example dataset
discussed in the XDE vignette, we have defined the covariate “adenoVsquamous” that takes the value
0 for adenocarcinomas and 1 for squamous carcinomas. The show method only lists the first few
parameters in each slot of the XdeParameter object.

> library(XDE)
> data(expressionSetList)
> xlist <- expressionSetList
> params <- new("XdeParameter", esetList=xlist, phenotypeLabel="adenoVsquamous")
> params

4

Instance of XdeParameter

hyperparameters:
alpha.a
1.0
p1.b
0.1

beta.a
1.0

...

p0.a
0.1

p1.a alpha.b
1.0

0.1

beta.b
1.0

p0.b
0.1

updates (frequency of updates per MCMC iteration):

nu Delta
1

1

a
3

b
3

c2
1

...

tuning (the epsilon for Metropolis-Hastings proposals):
c2
0.01

a
0.01 0.04

b
0.04

nu Delta

0.01

...

output (parameters to save (0 = not saved, 1 = saved to log file):

potential acceptance
1

1

nu
1

DDelta
1

a
1

...

1000

1
413515

iterations:
thin:
seed:
notes:
firstMcmc:
List of 5

$ Nu
: num [1:1500] -0.697 0.813 0.208 0.352 0.65 ...
$ DDelta: num [1:1500] -0.0645 1.0315 -0.3625 -0.7834 -0.3799 ...
$ A
$ B
$ C2

: num [1:3] 0.482 0.611 0.451
: num [1:3] 0.16 0.6 0.441
: num 0.544

...

showIterations: TRUE
specifiedInitialValues:
directory (where to save the MCMC chains):
phenotypeLabel: adenoVsquamous
studyNames:
one.delta:

study1 study2 study3

TRUE

TRUE

./

4.2 Starting values for MCMC chains

A complete listing of initial values for the MCMC can be obtained by

> initialValues <- firstMcmc(params)
> str(initialValues)

5

List of 18

: num [1:3] 0.482 0.611 0.451
: num [1:3] 0.16 0.6 0.441
: num 0.544

$ Nu
: num [1:1500] -0.697 0.813 0.208 0.352 0.65 ...
$ DDelta : num [1:1500] -0.0645 1.0315 -0.3625 -0.7834 -0.3799 ...
$ A
$ B
$ C2
$ Gamma2 : num 1.93
: num [1:3] 0.2885 0.2723 0.0835
$ R
$ Rho
: num [1:3] 0.352 0.322 0.384
$ Delta : int [1:1500] 1 1 1 1 1 1 1 1 1 0 ...
$ Xi
: num [1:3] 0.816 0.816 0.816
$ Sigma2 : num [1:1500] 0.603 2.287 0.321 1.319 1.008 ...
$ T
$ L
$ Phi
$ Theta : num [1:3] 1 1 1.04
$ Lambda : num [1:3] 1 1.02 1
$ Tau2R : num [1:3] 1.002 0.964 1.036
$ Tau2Rho: num [1:3] 1 0.999 1.001

: num [1:3] 1.07 1 1.01
: num [1:3] 1 1 0.979
: num [1:1500] 1.12876 0.12827 0.00932 1.34414 0.39348 ...

The initial values of the MCMC chains stored in firstMcmc are generated by random sampling from
the prior distributions for these parameters. One may replace any one of the named elements in this list
with different starting values. At this time, we do not provide checks that the replacement vectors are of
the appropriate length. WARNING: providing a replacement vector of the incorrect length may cause
the MCMC algorithm to crash without warning. Note that specifiedInitialValues in the XdeParameter
object is always TRUE as the values created here are the initial values used to run the MCMC, regardless
of the starting values were explicitly defined or simulated from the priors.

> params@specifiedInitialValues

[1] TRUE

If one were to change specifiedInitialValues to FALSE, the MCMC would begin at a different set of
initial values drawn from the prior and not the values provided in the XdeParameter class.

4.3 Hyper-parameters

When initializing XdeParameterfor three studies as we are here, the default values for the hyper-
parameters are as follows:

> hyperparameters(params)

beta.a
1.0
p1.b
0.1

p0.a
0.1
nu.r
4.0

alpha.a
1.0
p0.b
0.1
c2max
50.0

p1.a
0.1

alpha.b
1.0

beta.b
1.0
nu.rho alpha.xi beta.xi
1.0

4.0

1.0

6

The names used in the software implementation that correspond to the notation used in Section 2 are
as follows:

hyperparameter XDE name
alpha.a
αa
βa beta.a
p0.a
p0
a
p1.a
p1
a
alpha.b
αb
βb beta.b
p0.b
p0
b
p1.b
p1
b
νr nu.r
νρ nu.rho
alpha.xi
αξ
βξ beta.xi
c2max c2max

In situations in which there is no signal (all noise), the c2max is provided as a precaution to avoid sampling
from infinity. However, in simulations of complete noise, the c2max parameter was not generally needed
and remains in the present model primarily for debugging purposes. Modification of any of the above
hyperparameters can be performed in the usual way:

> hyperparameters(params)["alpha.a"] <- 1

4.4 Tuning parameters for Metropolis-Hastings proposals

A default ϵ for each of the Metropolis-Hastings proposals discussed in Section 3 is created when initial-
izing the XdeParameter class. See

> tuning(params)

nu
0.01
c2
0.01
delta
0.01
l
0.04
tau2R
0.04

Delta
0.01
gamma2
0.01
xi
0.01

a
0.04
rAndC2
0.01
sigma2
0.50
phi thetaAndLambda
0.10

0.40
tau2Rho
0.04

b
0.04
rhoAndGamma2
0.01
tAndL
0.10
lambda
0.02

for a named vector of the default values. A replacement method has been defined to facilitate the tuning
of the proposals. To illustrate, the ϵ used in the proposal for the parameter a (the power conjugate
parameter for ν) could be adjusted by the following command:

> tuning(params)["a"] <- tuning(params)["a"]*0.5

7

4.5

Frequency of updates for each MCMC iteration

One may control the frequency at which any of the parameters described in Section 3 are updated at
each iteration of the MCMC through the method updates. See

> updates(params)

nu
1
c2
1
delta
1
l
1
tau2R
1

Delta
1
gamma2
1
xi
1

a
3
rAndC2
3
sigma2
1
phi thetaAndLambda
1

1
tau2Rho
1

b
3
rhoAndGamma2
3
tAndL
1
lambda
1

Specifying zero updates forces a parameter to remain at its initial value. For instance, one may impose
conjugacy between location and scale by initializing the power conjugate parameter, b, to 1 and changing
the number of updates per MCMC iteration to zero:

> firstMcmc(params)$B <- rep(1,3)
> updates(params)["b"] <- 0

Alternatively, one could force independence of location and scale by setting b to zero:

> firstMcmc(params)$B <- rep(0, 3)
> updates(params)["b"] <- 0

By default, b is allowed to vary between zero and 1. Block updates are denoted by ’And’. For instance,
r and c2 are updated as a block (as described above). Therefore, to update the r parameter 3 times
per MCMC iteration, one would use the command

> updates(params)["rAndC2"] <- 3

4.6 MCMC output

XDE provides options to save all, some, or none of the chains produced by MCMC. Options for writing
MCMC chains to file are provided in the output slot of the XdeParameterclass.

> output(params)

thin
1

potential
1

acceptance
1

nu
1

8

DDelta
1
gamma2
1
xi
1
phi
1
tau2Rho
1

a
1
r
1
sigma2
1
theta
1

b
1
rho
1
t
1
lambda
1
probDelta diffExpressed
1

1

c2
1
delta
1
l
1
tau2R
1

The first value, thin, tells the MCMC algorithm how often to write the chain to file. For instance, if
thin is two every other iteration is written to file. The remaining numbers in the output vector are
either zero (nothing is written to file) or one. If the output is one, the simulated value from the current
iteration is added to the log file. The log files are plain text files and are by default stored in the current
working directory. One may change the location of where to store the log files by providing a different
path

> directory(params) <- "logFiles"

If the directory “logFiles” does not exist, the above replacement method for directory will automatically
create the directory.
In general, directory should provide the path relative to the current working
directory or the complete path to the desired directory.

An additional slot in the XdeParameterclass that may be useful is burnin. By default, burnin is TRUE
and no chains are written to file. One reason for this setting as a default is to easily check whether
the XDE model will run with the default values without producing voluminous output in the MCMC
chains. For instance, we often set

> burnin(params) <- TRUE
> iterations(params) <- 5

Note the following behavior of the replacement method for burnin:

> output(params)[2:22] <- rep(1, 21)
> output(params)

thin
1
DDelta
1
gamma2
1
xi
1
phi
1
tau2Rho
1

potential
1
a
1
r
1
sigma2
1
theta
1

acceptance
1
b
1
rho
1
t
1
lambda
1
probDelta diffExpressed
0

1

nu
1
c2
1
delta
1
l
1
tau2R
1

9

> burnin(params) <- TRUE
> output(params)

thin
1
DDelta
0
gamma2
0
xi
0
phi
0
tau2Rho
0

potential
0
a
0
r
0
sigma2
0
theta
0

acceptance
0
b
0
rho
0
t
0
lambda
0
probDelta diffExpressed
0

0

nu
0
c2
0
delta
0
l
0
tau2R
0

Hence, when setting burnin to TRUE we assume that none of the iterations are to be saved. Similarly,
when setting burnin to FALSE, we assume that one wishes to save all of the parameters:

> ##Specify a thin of 1 and save none of the parameters
> output(params)[2:22] <- rep(0, 21)
> output(params)

thin
1
DDelta
0
gamma2
0
xi
0
phi
0
tau2Rho
0

potential
0
a
0
r
0
sigma2
0
theta
0

acceptance
0
b
0
rho
0
t
0
lambda
0
probDelta diffExpressed
0

0

> burnin(params) <- FALSE
> output(params)

thin
1
DDelta
1
gamma2
1
xi
1
phi

potential
1
a
1
r
1
sigma2
1
theta

acceptance
1
b
1
rho
1
t
1
lambda

10

nu
0
c2
0
delta
0
l
0
tau2R
0

nu
1
c2
1
delta
1
l
1
tau2R

1
tau2Rho
1

1

1
probDelta diffExpressed
1

1

1

To save a subset of the parameters, we recommend setting the burnin argument to FALSE and turning off
the parameters that one does not wish to save. Warning: the parameters ∆gp, δg, probDelta
gp, νgp, ϕgp
are all indexed by genes and/or study and may therefore require a large amount of memory to save.
Use the following commands to avoid writing these chains to file:

g, σ2

> burnin(params) <- FALSE
> output(params)[c("nu", "DDelta", "delta", "probDelta", "sigma2", "phi")] <- 0
> output(params)

thin
1
DDelta
0
gamma2
1
xi
1
phi
0
tau2Rho
1

potential
1
a
1
r
1
sigma2
0
theta
1

acceptance
1
b
1
rho
1
t
1
lambda
1
probDelta diffExpressed
1

0

nu
0
c2
1
delta
0
l
1
tau2R
1

5 Session Information

The version number of R and packages loaded for generating the vignette were:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

11

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, XDE 2.56.0, generics 0.1.4

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, Biostrings 2.78.0, DBI 1.2.3,

GeneMeta 1.82.0, IRanges 2.44.0, KEGGREST 1.50.0, MASS 7.3-65, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3, RSQLite 2.4.3, S4Vectors 0.48.0,
Seqinfo 1.0.0, XML 3.99-0.19, XVector 0.50.0, annotate 1.88.0, bit 4.6.0, bit64 4.6.0-1,
blob 1.2.4, cachem 1.1.0, cli 3.6.5, compiler 4.5.1, crayon 1.5.3, fastmap 1.2.0, genefilter 1.92.0,
grid 4.5.1, gtools 3.9.5, httr 1.4.7, lattice 0.22-7, matrixStats 1.5.0, memoise 2.0.1,
multtest 2.66.0, mvtnorm 1.3-3, png 0.1-8, rlang 1.1.6, scrime 1.3.5, siggenes 1.84.0, splines 4.5.1,
stats4 4.5.1, survival 3.8-3, tools 4.5.1, vctrs 0.6.5, xtable 1.8-4

References

12

