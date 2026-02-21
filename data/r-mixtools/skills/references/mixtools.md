mixtools: An R Package for Analyzing Finite
Mixture Models

Tatiana Benaglia
Pennsylvania State University

Didier Chauveau
Université d’Orléans

David R. Hunter
Pennsylvania State University

Derek S. Young
Pennsylvania State University

Abstract

The mixtools package for R provides a set of functions for analyzing a variety of ﬁnite
mixture models. These functions include both traditional methods, such as EM algo-
rithms for univariate and multivariate normal mixtures, and newer methods that reﬂect
some recent research in ﬁnite mixture models. In the latter category, mixtools provides
algorithms for estimating parameters in a wide range of diﬀerent mixture-of-regression
contexts, in multinomial mixtures such as those arising from discretizing continuous mul-
tivariate data, in nonparametric situations where the multivariate component densities
are completely unspeciﬁed, and in semiparametric situations such as a univariate location
mixture of symmetric but otherwise unspeciﬁed densities. Many of the algorithms of the
mixtools package are EM algorithms or are based on EM-like ideas, so this article includes
an overview of EM algorithms for ﬁnite mixture models.

Keywords: cutpoint, EM algorithm, mixture of regressions, model-based clustering, nonpara-
metric mixture, semiparametric mixture, unsupervised clustering.

1. Introduction to ﬁnite mixtures and mixtools

Authors’ note: The original version of this vignette was produced using an article that appears
in the Journal of Statistical Software (URL: http://www.jstatsoft.org/); see Benaglia,
Chauveau, Hunter, and Young (2009c).

Populations of individuals may often be divided into subgroups. Yet even when we observe
characteristics of these individuals that provide information about their subgroup member-
ships, we may not actually observe these memberships per se. The basic goal of the tools in
the mixtools package (version 0.4.3, as of this writing) for R (R Development Core Team 2009)
is to examine a sample of measurements to discern and describe subgroups of individuals, even
when there is no observable variable that readily indexes into which subgroup an individual
properly belongs. This task is sometimes referred to as “unsupervised clustering” in the lit-
erature, and in fact mixture models may be generally thought of as comprising the subset of
clustering methods known as “model-based clustering”. The mixtools package is available from
the Comprehensive R Archive Network at http://CRAN.R-project.org/package=mixtools.
Finite mixture models may also be used in situations beyond those for which clustering of

2

mixtools for Mixture Models

individuals is of interest. For one thing, ﬁnite mixture models give descriptions of entire
subgroups, rather than assignments of individuals to those subgroups (though the latter may
be accomplished using mixture models). Indeed, even the subgroups may not necessarily be of
interest; sometimes ﬁnite mixture models merely provide a means for adequately describing a
particular distribution, such as the distribution of residuals in a linear regression model where
outliers are present.

Whatever the goal of the modeler when employing mixture models, much of the theory of
these models involves the assumption that the subgroups are distributed according to a par-
ticular parametric form — and quite often this form is univariate or multivariate normal.
While mixtools does provide tools for traditional ﬁtting of ﬁnite mixtures of univariate and
multivariate normal distributions, it goes well beyond this well-studied realm. Arising from
recent research whose goal is to relax or modify the assumption of multivariate normality,
mixtools provides computational techniques for ﬁnite mixture model analysis in which com-
ponents are regressions, multinomial vectors arising from discretization of multivariate data,
or even distributions that are almost completely unspeciﬁed. This is the main feature that
distinguishes mixtools from other mixture-related R packages, also available from the Com-
prehensive R Archive Network at http://CRAN.R-project.org/, such as mclust (Fraley and
Raftery 2009) and ﬂexmix (Leisch 2004; Grün and Leisch 2008). We brieﬂy mention these
two packages in Sections 2.3 and 5.3, respectively.

To make the mixture model framework more concrete, suppose the possibly vector-valued
random variables X1, . . . , Xn are a simple random sample from a ﬁnite mixture of m > 1
arbitrary distributions, which we will call components throughout this article. The density of
each Xi may be written

m

gθ(xi) =

Xj=1

λjϕj(xi), xi ∈ Rr,

(1)

where θ = (λ, ϕ) = (λ1, . . . , λm, ϕ1, . . . , ϕm) denotes the parameter and the λm are positive
and sum to unity. We assume that the ϕj are drawn from some family F of multivariate
density functions absolutely continuous with respect to, say, Lebesgue measure. The repre-
sentation (1) is not identiﬁable if no restrictions are placed on F, where by “identiﬁable”
we mean that gθ has a unique representation of the form (1) and we do not consider that
“label-switching” — i.e., reordering the m pairs (λ1, ϕ1), . . . , (λm, ϕm) — produces a distinct
representation.
In the next sections we will sometimes have to distinguish between parametric and more
general nonparametric situations. This distinction is related to the structure of the family
F of distributions to which the component densities ϕj in model (1) belong. We say that
the mixture is parametric if F is a parametric family, F = {ϕ(·|ξ), ξ ∈ Rd}, indexed by
a (d-dimensional) Euclidean parameter ξ. A parametric family often used is the univari-
ate Gaussian family F = {ϕ(·|µ, σ2) = density of N (µ, σ2), (µ, σ2) ∈ R × R+
∗ }, in which
case the model parameter reduces to θ = (λ, (µ1, σ2
m)). For the multivari-
ate case, a possible parametric model is the conditionally i.i.d. normal model, for which
k=1 f (xik), f (t) density of N (µ, σ2)} (this model is included in mixtools;
r
F = {ϕ(xi) =
see Section 6.1). An example of a (multivariate) nonparametric situation is F = {ϕ(xi) =
k=1 f (xik), f (t) a univariate density on R}, in which case θ consists in a Euclidean part (λ)
r

1), . . . , (µm, σ2

Q

and a nonparametric part (f1, . . . , fm).
Q
As a simple example of a dataset to which mixture models may be applied, consider the

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

3

sample depicted in Figure 1. In the Old Faithful dataset, measurements give time in minutes
between eruptions of the Old Faithful geyser in Yellowstone National Park, USA. These data
are included as part of the datasets package in R (R Development Core Team 2009); type
help("faithful") in R for more details.

> library(mixtools)
> data(faithful)
> attach(faithful)

> hist(waiting, main="Time between Old Faithful eruptions",
+

xlab="Minutes", ylab="", cex.main=1.5, cex.lab=1.5, cex.axis=1.4)

Time between Old Faithful eruptions

0
5

0
4

0
3

0
2

0
1

0

40

50

60

70

80

90

100

Minutes

Figure 1: The Old Faithful dataset is clearly suggestive of a two-component mixture of
symmetric components.

For the Old Faithful eruption data, a two-component mixture model is clearly a reasonable
model based on the bimodality evident in the histogram. This example is analyzed by Hunter,
Wang, and Hettmansperger (2007), who compare a standard normal-mixture method for
ﬁtting it with a novel semiparametric approach. Both approaches are included in mixtools;
see Sections 2.3 and 4.2 of this article.

In Section 2 of the current article we review the well-known class of EM algorithms for ﬁ-
nite mixture models, a common thread that runs throughout much of the rest of the article.
The remaining sections discuss various categories of functions found in the mixtools pack-
age, from cutpoint methods that relax distributional assumptions for multivariate data by
discretizing the data (Section 3), to semi- and non-parametric methods that eliminate dis-
tributional assumptions almost entirely depending on what the identiﬁability of the model

4

mixtools for Mixture Models

allows (Section 4), to methods that handle various mixtures of regressions (Section 5). Finally,
Section 6 describes several miscellaneous features of the mixtools package.

2. EM algorithms for ﬁnite mixtures

2.1. Missing data setup

Much of the general methodology used in mixtools involves the representation of the mixture
problem as a particular case of maximum likelihood estimation (MLE) when the observations
can be viewed as incomplete data. This setup implies consideration of two sample spaces,
the sample space of the (incomplete) observations, and a sample space of some “complete”
observations, the characterization of which being that the estimation can be performed ex-
plicitly at this level. For instance, in parametric situations, the MLE based on the complete
data may exist in closed form. Among the numerous reference papers and monographs on
this subject are, e.g., the original EM algorithm paper by Dempster, Laird, and Rubin (1977)
and the ﬁnite mixture model book by McLachlan and Peel (2000) and references therein. We
now give a brief description of this setup as it applies to ﬁnite mixture models in general.
The (observed) data consist of n i.i.d. observations x = (x1, . . . , xn) from a density gθ given
by (1). It is common to denote the density of the sample by gθ, the n-fold product of gθ,
so that we write simply x ∼ gθ. In the missing data setup, gθ is called the incomplete-data
n
i=1 log gθ(xi). The (parametric) ML
density, and the associated log-likelihood is Lx(θ) =
estimation problem consists in ﬁnding ˆθx = argmaxθ∈Φ Lx(θ), or at least ﬁnding a local
maximum — there are certain well-known cases in which a ﬁnite mixture model likelihood
is unbounded (McLachlan and Peel 2000), but we ignore these technical details for now.
Calculating ˆθx even for a parametric ﬁnite mixture model is known to be a diﬃcult problem,
and considering x as incomplete data resulting from non-observed complete data helps.
n
The associated complete data is denoted by c = (c1, . . . , cn), with density hθ(c) =
i=1 hθ(ci)
(there exists a many-to-one mapping from c to x, representing the loss of information). In
the model for complete data associated with model (1), each random vector Ci = (Xi, Zi),
where Zi = (Zij, j = 1, . . . m), and Zij ∈ {0, 1} is a Bernoulli random variable indicating
that individual i comes from component j. Since each individual comes from exactly one
component, this implies

m
j=1 Zij = 1, and

P

Q

P

P(Zij = 1) = λj,

(Xi|Zij = 1) ∼ ϕj,

j = 1, . . . , m.

The complete-data density for one observation is thus

hθ(ci) = hθ(xi, zi) =

Izij λjϕj(xi),

m

Xj=1

In the parametric situation, i.e. when F is a parametric family, it is easy to check that the
complete-data MLE ˆθc based on maximizing log hθ(c) is easy to ﬁnd, provided that this is
the case for the family F.

2.2. EM algorithms

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

5

An EM algorithm iteratively maximizes, instead of the observed log-likelihood Lx(θ), the
operator

Q(θ|θ(t)) = E

log hθ(C)|x, θ(t)

,

where θ(t) is the current value at iteration t, and the expectation is with respect to the
distribution kθ(c|x) of c given x, for the value θ(t) of the parameter. The iteration θ(t) →
θ(t+1) is deﬁned in the above general setup by

h

i

1. E-step: compute Q(θ|θ(t))

2. M-step: set θ(t+1) = argmaxθ∈Φ Q(θ|θ(t))

For ﬁnite mixture models, the E-step does not depend on the structure of F, since the missing
data part is only related to the z’s:

n

kθ(c|x) =

kθ(zi|xi).

Yi=1
The z are discrete, and their distribution is given via Bayes’ theorem. The M-step itself can
be split in two parts, the maximization related to λ, which does not depend on F, and the
maximization related to ϕ, which has to be handled speciﬁcally (say, parametrically, semi-
or non-parametrically) for each model. Hence the EM algorithms for the models handled by
the mixtools package share the following common features:

1. E-step: Calculate the “posterior” probabilities (conditional on the data and θ(t)) of

component inclusion,

p(t)
ij

def= P

θ(t)(Zij = 1|xi) =

j ϕ(t)
λ(t)
j′=1 λ(t)
m

j (xi)
j′ ϕ(t)

j′ (xi)

(2)

for all i = 1, . . . , n and j = 1, . . . , m. Numerically, it can be dangerous to implement
equation (2) exactly as written due to the possibility of the indeterminant form 0/0 in
cases where xi is so far from any of the components that all ϕ(t)
j′ (xi) values result in a
numerical underﬂow to zero. Thus, many of the routines in mixtools actually use the
equivalent expression

P

p(t)
ij =

1 +





Xj′̸=j

or some variant thereof.

2. M-step for λ: Set

−1

λ(t)
j′ ϕ(t)
j ϕ(t)
λ(t)

j′ (xi)
j (xi) 


λ(t+1)
j

=

1
n

n

Xi=1

p(t)
ij ,

for j = 1, . . . , m.

2.3. An EM algorithm example

(3)

(4)

6

mixtools for Mixture Models

As an example, we consider the univariate normal mixture analysis of the Old Faithful waiting
data depicted in Figure 1. This fully parametric situation corresponds to a mixture from the
univariate Gaussian family described in Section 1, where the jth component density ϕj(x) in
(1) is normal with mean µj and variance σ2
j . This is a special case of the general mixture-of-
normal model that is well-studied in the literature and for which other software, such as the
mclust (Fraley and Raftery 2009) package for R, may also be used for parameter estimation.
The M-step for the parameters (µj, σ2
j ), j = 1, . . . , m of this EM algorithm for such mixtures
of univariate normals is straightforward, and can be found, e.g., in McLachlan and Peel
(2000). The function normalmixEM implements the algorithm in mixtools. Code for the Old
Faithful example, using most of the default values (e.g., stopping criterion, maximum number
of iterations), is simply

> wait1 <- normalmixEM(waiting, lambda = .5, mu = c(55, 80), sigma = 5)

number of iterations= 9

The code above will ﬁt a 2-component mixture (because mu is a vector of length two) in which
the standard deviations are assumed equal (because sigma is a scalar instead of a vector).
See help("normalmixEM") for details about specifying starting values for this EM algorithm.

> plot(wait1, density=TRUE, cex.axis=1.4, cex.lab=1.4, cex.main=1.8,
main2="Time between Old Faithful eruptions", xlab2="Minutes")
+

Observed Data Log−Likelihood

Time between Old Faithful eruptions

d
o
o
h

i
l

i

e
k
L
−
g
o
L

5
3
0
1
−

0
4
0
1
−

5
4
0
1
−

0
5
0
1
−

y
t
i
s
n
e
D

4
0
.
0

3
0
.
0

2
0
.
0

1
0
.
0

0
0
.

0

2

4

6

8

10

40

50

60

70

80

90

100

Iteration

Minutes

Figure 2: The Old Faithful waiting data ﬁtted with a parametric EM algorithm in mixtools.
Left: the sequence of log-likelihood values; Right: the ﬁtted Gaussian components.

The normalmixEM function returns an object of class "mixEM", and the plot method for
these objects delivers the two plots given in Figure 2: the sequence t 7→ Lx(θ(t)) of observed
log-likelihood values and the histogram of the data with the m (m = 2 here) ﬁtted Gaus-
j ), j = 1, . . . , m, each scaled by the corresponding ˆλj,
sian component densities of N (ˆµj, ˆσ2
superimposed. The estimator ˆθ can be displayed by typing, e.g.,

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

7

> wait1[c("lambda", "mu", "sigma")]

$lambda
[1] 0.3608498 0.6391502

$mu
[1] 54.61364 80.09031

$sigma
[1] 5.869089 5.869089

Alternatively, the same output may be obtained using the summary method:

> summary(wait1)

summary of normalmixEM object:

comp 1

comp 2
0.36085 0.63915
54.61364 80.09031
5.86909 5.86909

lambda
mu
sigma
loglik at estimate: -1034.002

3. Cutpoint methods

Traditionally, most literature on ﬁnite mixture models has assumed that the density functions
ϕj(x) of equation (1) come from a known parametric family. However, some authors have
recently considered the problem in which ϕj(x) is unspeciﬁed except for some conditions nec-
essary to ensure the identiﬁability of the parameters in the model. One such set of conditions
is as follows:

Hettmansperger and Thomas (2000); Cruz-Medina, Hettmansperger, and Thomas (2004); and
Elmore, Hettmansperger, and Thomas (2004) treat the case in which ϕj(x) equals the product
fj(xi) · · · fj(xr) for some univariate density function fj. Thus, conditional on knowing that X
comes from the jth mixture component, the coordinates of X are independent and identically
distributed. For this reason, this case is called the conditionally i.i.d. model.

The authors named above have developed an estimation method for the conditionally i.i.d.
model. This method, the cutpoint approach, discretizes the continuous measurements by re-
placing each r-dimensional observation, say Xi = (xi1, . . . , xir), by the p-dimensional multi-
nomial vector (n1, . . . , np), where p ≥ 2 is chosen by the experimenter along with a set of
cutpoints −∞ = c0 < c1 < · · · < cp = ∞, so that for a = 1, . . . , p,

r

na =

I{ca−1 < xik ≤ ca}.

Xk=1

Note that the multinomial distribution is guaranteed by the conditional i.i.d. assumption, and
the multinomial probability of the ath category is equal to θa ≡ P(ca−1 < Xik ≤ ca).

8

mixtools for Mixture Models

The cutpoint approach is completely general in the sense that it can be applied to any number
of components m and any number of repeated measures r, just as long as r ≥ 2m − 1, a con-
dition that guarantees identiﬁability (Elmore and Wang 2003). However, some information
is lost in the discretization step, and for this reason it becomes diﬃcult to obtain density
estimates of the component densities. Furthermore, even if the assumption of conditional in-
dependence is warranted, the extra assumption of identically distributed coordinates may not
be; and the cutpoint method collapses when the coordinates are not identically distributed.

As an illustration of the cutpoint approach applied to a dataset, we show here how to use
mixtools to reconstruct—almost—an example from Elmore et al. (2004). The dataset is
Waterdata, a description of which is available by typing help("Waterdata"). This dataset
contains 8 observations on each of 405 subjects, where the observations are angle degree
measurements ranging from −90 to 90 that describe the subjects’ answers to a series of 8
questions related to a conceptual task about how the surface of a liquid would be oriented
if the vessel containing it were tipped to a particular angle. The correct answer is 0 degree
in all cases, yet the subjects showed a remarkable variety of patterns of answers. Elmore
et al. (2004) assumed the conditionally i.i.d. model (see Benaglia, Chauveau, and Hunter
(2009a) for an in-depth discussion of this assumption and this dataset) with both m = 3 and
m = 4 mixture components. Elmore et al. (2004) summarized their results by providing plots
of estimated empirical distribution functions for the component distributions, where these
functions are given by

˜Fj(x) =

1
mnλj

n

r

pijI{xiℓ ≤ x}.

(5)

Xℓ=1

Xi=1
In equation (5), the values of λj and pij are the ﬁnal maximum likelihood estimates of the
mixing proportions and posterior component membership probabilities that result from ﬁt-
ting a mixture of m multinomials (note in particular that the estimates of the multinomial
parameters θa for each component are not used in this equation).
We cannot obtain the exact results of Elmore et al. (2004) because those authors do not state
speciﬁcally which cutpoints ca they use; they merely state that they use thirteen cutpoints.
It appears from their Figures 1 and 2 that these cutpoints occur approximately at intervals
of 10.5 degrees, starting at −63 and going through 63; these are the cutpoints that we adopt
here. The function makemultdata will create a multinomial dataset from the original data,
as follows:

> data("Waterdata")
> cutpts <- 10.5*(-6:6)
> watermult <- makemultdata(Waterdata, cuts = cutpts)

Once the multinomial data have been created, we may apply the multmixEM function to
estimate the multinomial parameters via an EM algorithm.

> set.seed(15)
> theta4 <- matrix(runif(56), ncol = 14)
> theta3 <- theta4[1:3,]
> mult3 <- multmixEM(watermult, lambda = rep(1, 3)/3, theta = theta3)

number of iterations= 79

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

9

> mult4 <- multmixEM (watermult, lambda = rep (1, 4) / 4, theta = theta4)

number of iterations= 105

Finally, compCDF calculates and plots the estimated distribution functions of equation (5).
Figure 3 gives plots for both a 3-component and a 4-component solution; these plots are very
similar to the corresponding plots in Figures 1 and 2 of Elmore et al. (2004).

> cdf3 <- compCDF(Waterdata, mult3$posterior, lwd=2, lab=c(7, 5, 7),
xlab="Angle in degrees", ylab="Component CDFs",
+
+
main="Three-Component Solution")
> cdf4 <- compCDF(Waterdata, mult4$posterior, lwd=2, lab=c(7, 5, 7),
+
+

xlab="Angle in degrees", ylab="Component CDFs",
main="Four-Component Solution")

Three−Component Solution

Four−Component Solution

s
F
D
C

t
n
e
n
o
p
m
o
C

0
.
1

8
.
0

6
.
0

4
.
0

2
.
0

0
.
0

s
F
D
C

t
n
e
n
o
p
m
o
C

0
.
1

8
.
0

6
.
0

4
.
0

2
.
0

0
.
0

44.3%
38.2%
17.5%

44.4%
38.2%
14.9%
2.5%

−80

−60

−40

−20

0

20

40

60

80

−80

−60

−40

−20

0

20

40

60

80

Angle in degrees

Angle in degrees

Figure 3: Empirical cumulative distribution function (CDF) estimates for the three- and four-
component multinomial cutpoint models for the water-level data; compare Figures 1 and 2 of
Elmore et al. (2004). The 13 cutpoints used are indicated by the points in the plots, and the
estimated mixing proportions for the various components are given by the legend.

As with the output of normalmixEM in Section 2, it is possible to summarize the output of
the multmixEM function using the summary method for mixEM objects:

> summary(mult4)

summary of multmixEM object:

lambda
theta1
theta2

comp 2

comp 1

comp 4
4.44218e-01 0.38163821 0.1486697 2.54743e-02
1.00000e-100 0.00124664 0.0870049 5.51164e-02
1.00000e-100 0.00549989 0.0453289 1.37695e-01

comp 3

10

mixtools for Mixture Models

1.00000e-100 0.00870889 0.0374336 2.89421e-76
theta3
1.00000e-100 0.01201987 0.0409923 3.62476e-02
theta4
3.09495e-13 0.06709924 0.0457400 1.62337e-01
theta5
1.71175e-02 0.13605867 0.0712612 1.00000e-100
theta6
5.42656e-01 0.25723071 0.1459176 7.04952e-02
theta7
3.23932e-01 0.21853005 0.1128998 4.33644e-02
theta8
theta9
1.15712e-01 0.21095289 0.1626131 1.05242e-01
theta10 5.82600e-04 0.05923139 0.0617645 1.76528e-01
theta11 1.00000e-100 0.01470228 0.0284662 3.03943e-02
theta12 4.76749e-73 0.00087848 0.0309613 1.06723e-09
theta13 9.10041e-92 0.00454296 0.0384335 1.82580e-01
theta14 0.00000e+00 0.00329804 0.0911831 1.11022e-16
loglik at estimate: -3094.588

4. Nonparametric and semiparametric methods

In this section, we consider nonparametric multivariate ﬁnite mixture models. The ﬁrst
algorithm presented here was introduced by Benaglia et al. (2009a) as a generalization of the
stochastic semiparametric EM algorithm of Bordes, Chauveau, and Vandekerkhove (2007).
Both algorithms are implemented in mixtools.

4.1. EM-like algorithms for mixtures of unspeciﬁed densities

Consider the mixture model described by equation (1). If we assume that the coordinates
of the Xi vector are conditionally independent, i.e. they are independent conditional on the
subpopulation or component (ϕ1 through ϕm) from which Xi is drawn, the density in (1) can
be rewritten as:

m

r

gθ(xi) =

λj

fjk(xik),

Xj=1

Yk=1

(6)

where the function f (·), with or without subscripts, will always denote a univariate density
function. Here we do not assume that fjk(·) comes from a family of densities that may be
indexed by a ﬁnite-dimensional parameter vector, and we estimate these densities using non-
parametric density techniques. That is why we say that this algorithm is a fully nonparametric
approach.

The density in equation (6) allows for a diﬀerent distribution for each component and each
coordinate of Xi. Notice that if the density fjk(·) does not depend on k, we have the case
in which the Xi are not only conditionally independent but identically distributed as well.
These are the two extreme cases. In order to encompass both the conditionally i.i.d. case and
the more general case (6) simultaneously in one model, we allow that the coordinates of Xi
are conditionally independent and there exist blocks of coordinates that are also identically
distributed. If we let bk denote the block to which the kth coordinate belongs, where 1 ≤
bk ≤ B and B is the total number of such blocks, then equation (6) is replaced by

m

r

gθ(xi) =

λj

fjbk (xik).

Xj=1

Yk=1

(7)

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

11

The indices i, j, k, and ℓ will always denote a generic individual, component (subpopulation),
coordinate (repeated measurement), and block, respectively. Therefore, we will always have
1 ≤ i ≤ n, 1 ≤ j ≤ m, 1 ≤ k ≤ r, and 1 ≤ ℓ ≤ B.

The EM algorithm to estimate model (7) has the E-step and M-step described in Section 2.2.
In equation (2), we have ϕ(t)
jℓ (·) is obtained by a weighted
nonparametric (kernel) density estimate, given by:

(xik), where f (t)

k=1 f (t)
jbk

j (xi) =

r

Q

3. Nonparametric (Kernel) density estimation step: For any real u, deﬁne for each

component j ∈ {1, . . . , m} and each block ℓ ∈ {1, . . . , B}

f t+1
jℓ (u) =

1
nhjℓCℓλt+1

j

r

n

p(t)
ij I{bk = ℓ}K

u − xik

hjℓ !

,

(8)

Xi=1
where K(·) is a kernel density function, hjℓ is the bandwidth for the jth component and
ℓth block density estimate, and Cℓ is the number of coordinates in the ℓth block.

Xk=1

The function npEM implements this algorithm in mixtools. This function has an argument
samebw which, when set to TRUE (the default), takes hjℓ = h, for all 1 ≤ j ≤ m and 1 ≤ ℓ ≤ B,
that is, the same bandwidth for all components and blocks, while samebw = FALSE allows a
diﬀerent bandwidth for each component and each block, as detailed in Benaglia, Chauveau,
and Hunter (2009b). This function will, if called using stochastic = TRUE, replace the
deterministic density estimation step (8) by a stochastic density estimation step of the type
proposed by Bordes et al. (2007): First, generate Z(t)
im) as a multivariate
random vector with a single trial and success probability vector p(t)
1m), then
in the M-step for λt+1

in equation (4), replace p(t)

i1 , . . . , Z(t)

i = (Z(t)

i1 , . . . , p(t)

i = (p(t)

ij by Z(t)

ij and let

j

f t+1
jℓ (u) =

1
nhjℓCℓλt+1

j

r

n

Z(t)

ij I{bk = ℓ}K

u − xik

.

hjℓ !

Xk=1

Xi=1
In other words, the stochastic versions of these algorithms re-assign each observation randomly
at each iteration, according to the p(t)
ij values at that iteration, to one of the m components,
then the density estimate for each component is based only on those observations that have
been assigned to it. Because the stochastic algorithms do not converge the way a deterministic
algorithm often does, the output of npEM is slightly diﬀerent when stochastic = TRUE than
when stochastic = FALSE, the default. See the corresponding help ﬁle for details.
Benaglia et al. (2009a) also discuss speciﬁc cases of model (7) in which some of the fjbk (·)
densities are assumed to be the same except for a location and scale change. They refer to
such cases as semiparametric since estimating each fjbk (·) involves estimating an unknown
density as well as multiple location and scale parameters. For instance, equation (17) of
Benaglia et al. (2009a) sets

fjℓ(x) =

1
σjℓ

f

x − µjℓ

σjℓ !

,

(9)

where ℓ = bk for a generic k.
The mixtools package implements an algorithm for ﬁtting model (9) in a function called spEM.
Details on the use of this function may be obtained by typing help("spEM"). Implementation

12

mixtools for Mixture Models

of this algorithm and of that of the npEM function requires updating the values of fjbk (xik)
for all i, j, and k for use in the E-step (2). To do this, the spEM algorithm keeps track of an
n × m matrix, called Φ here, where

Φij ≡ ϕj(xi) =

fjbk (xik).

r

Yk=1

The density estimation step of equation (8) updates the Φ matrix for the (t + 1)th iteration
based on the most recent values of all of the parameters. For instance, in the case of model
(9), we obtain

B

Φt+1
ij

=

Yℓ=1 Yk:bk=ℓ

1
σt+1
jℓ

f t+1

x − µt+1
jℓ
σt+1
jℓ

!

B

=

Yℓ=1 Yk:bk=ℓ

1
σt+1
jℓ

n

Xi′=1

pt+1
ij
hrnλt+1

j

r

Xk′=1

K 

(cid:18)





xik−µt+1
jℓ
σt+1
jℓ

− (xi′k′ − µt+1
jℓ )

(cid:19)
hσt+1
jℓ



.





4.2. A univariate symmetric, location-shifted semiparametric example

Both Hunter et al. (2007) and Bordes, Mottelet, and Vandekerkhove (2006) study a particular
case of model (1) in which x is univariate and

m

gθ(x) =

λjϕ(x − µj),

Xj=1

(10)

where ϕ(·) is a density that is assumed to be completely unspeciﬁed except that it is symmetric
about zero. Because each component distribution has both a nonparametric part ϕ(·) and a
parametric part µj, we refer to this model as semiparametric.
Under the additional assumption that ϕ(·) is absolutely continuous with respect to Lebesgue
measure, Bordes et al. (2007) propose a stochastic algorithm for estimating the model param-
eters, namely, (λ, µ, ϕ). This algorithm is implemented by the mixtools function spEMsymloc.
This function also implements a nonstochastic version of the algorithm, which is the default
and which is a special case of the general algorithm described in Section 4.1.

As noted in Figure 1, model (10) appears to be an appropriate model for the Old Faithful
waiting times dataset. Here, we provide code that applies the spEMsymloc function to these
data. First, we display the normal mixture solution of Figure 2 with a semiparametric solution
superimposed, in Figure 4(a):

main2 = "Time between Old Faithful eruptions", xlab2 = "Minutes")

> plot(wait1, which = 2, cex.axis = 1.4, cex.lab = 1.4, cex.main = 1.8,
+
> wait2 <- spEMsymloc(waiting, mu0 = c(55, 80))
> plot(wait2, lty = 2, newplot = FALSE, addlegend = FALSE)

Because the semiparametric version relies on a kernel density estimation step (8), it is nec-
essary to select a bandwidth for this step. By default, spEMsymloc uses a fairly simplistic
approach: It applies “Silverman’s rule of thumb” (Silverman 1986) to the entire dataset us-
ing the bw.nrd0 function in R. For the Old Faithful waiting time dataset, this bandwidth is
about 4:

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

13

Time between Old Faithful eruptions

Time between Old Faithful eruptions

y
t
i
s
n
e
D

4
0
.
0

3
0
.
0

2
0
.
0

1
0
.
0

0
0
.
0

y
t
i
s
n
e
D

4
0
.
0

3
0
.
0

2
0
.
0

1
0
.
0

0
0
.
0

40

50

60

70

80

90

100

40

50

60

70

80

90

100

Minutes

Minutes
Minutes

Figure 4: The Old Faithful dataset, ﬁt using diﬀerent algorithms in mixtools. Left: the ﬁtted
Gaussian components (solid) and a semiparametric ﬁt assuming model (10) with the default
bandwidth of 4.0 (dashed); Right: the same model (10) using bandwidths of 1.0 (solid) and
6.0 (dashed).

> bw.nrd0(waiting)

[1] 3.987559

But the choice of bandwidth can make a big diﬀerence, as seen in Figure 4(b).

> wait2a <- spEMsymloc(waiting, mu0 = c(55, 80), bw = 1)
> wait2b <- spEMsymloc(waiting, mu0 = c(55, 80), bw = 6)
> plot(wait2a, lty = 1, addlegend = FALSE, cex.axis = 1.4,
cex.lab = 1.4, cex.main = 1.8, xlab = "Minutes",
+
+
title = "Time between Old Faithful eruptions")
> plot(wait2b, lty = 2, newplot = FALSE, addlegend = FALSE)

We ﬁnd that with a bandwidth near 2, the semiparametric solution looks quite close to
the normal mixture solution of Figure 2. Reducing the bandwidth further results in the
“bumpiness” exhibited by the solid line in Figure 4(b). On the other hand, with a bandwidth
of 8, the semiparametric solution completely breaks down in the sense that algorithm tries
to make each component look similar to the whole mixture distribution. We encourage the
reader to experiment by changing the bandwidth in the above code.

4.3. A trivariate Gaussian example

As a ﬁrst simple, nonparametric example, we simulate a Gaussian trivariate mixture with
independent repeated measures and a shift of location between the two components in each
coordinate, i.e., m = 2, r = 3, and bk = k, k = 1, 2, 3. The individual densities fjk are the

14

mixtools for Mixture Models

densities of N (µjk, 1), with component means µ1 = (0, 0, 0) and µ2 = (3, 4, 5). This example
was introduced by Hall, Neeman, Pakyari, and Elmore (2005) then later reused by Benaglia
et al. (2009a) for comparison purposes. Note that the parameters in this model are identiﬁable,
since Hall and Zhou (2003) showed that for two components (m = 2), identiﬁability holds in
model (1) is under mild assumptions as long as r ≥ 3, even in the most general case in which
bk = k for all k.
A function ise.npEM has been included in mixtools for numerically computing the integrated
squared error (ISE) relative to a user-speciﬁed true density for a selected estimated density
ˆfjk from npEM output. Each density ˆfjk is computed using equation (8) together with the
posterior probabilities after convergence of the algorithm, i.e., the ﬁnal values of the pt
ij (when
stochastic = FALSE). We illustrate the usage of ise.npEM in this example by running a
Monte Carlo simulation for S replications, then computing the square root of the mean
integrated squared error (MISE) for each density, where

MISE =

1
S

S

Xs=1 Z (cid:16)

2

ˆf (s)
jk (u) − fjk(u)
(cid:17)

du,

j = 1, 2 and k = 1, 2, 3.

For this example, we ﬁrst set up the model true parameters with S = 100 replications of
n = 300 observations each:

> m <- 2; r <- 3; n <- 300; S <- 100
> lambda <- c(0.4, 0.6)
> mu <- matrix(c(0, 0, 0, 3, 4, 5), m, r, byrow = TRUE)
> sigma <- matrix(rep(1, 6), m, r, byrow = TRUE)

Next, we set up “arbitrary” initial centers, a matrix for storing sums of integrated squared
errors, and an integer storing the number of suspected instances of label switching that may
occur during the replications:

> centers <- matrix(c(0, 0, 0, 4, 4, 4), 2, 3, byrow = TRUE)
> ISE <- matrix(0, m, r, dimnames = list(Components = 1:m, Blocks = 1:r))
> nblabsw <- 0

Finally, we run the Monte Carlo simulation, using the samebw = FALSE option since it is more
appropriate for this location-shift model:

> set.seed(1000)
> for (mc in 1:S) {
+
+
+
+
+
+
+
+
+

}

x <- rmvnormmix(n, lambda, mu, sigma)
a <- npEM(x, centers, verb = FALSE, samebw = FALSE)
if (a$lambda[1] > a$lambda[2]) nblabsw <- nblabsw + 1
for (j in 1:m) {

for (k in 1:r) {
ISE[j, k] <- ISE[j, k] + ise.npEM(a, j, k, dnorm,

lower = mu[j, k] - 5, upper = mu[j, k] + 5, plots = FALSE,
mean = mu[j, k], sd = sigma[j, k])$value #$

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

15

}

+
+ }
> MISE <- ISE/S
> print(sqMISE <- sqrt(MISE))

Blocks

Components

1

3
1 0.07724759 0.07699926 0.07745280
2 0.06476345 0.06154020 0.06604921

2

We can examine the npEM output from the last replication above using

> summary(a)

300 observations, 3 coordinates, 2 components, and 3 blocks.

Means (and std. deviations) for each component:

Block #1: Coordinate 1

-0.181 (0.892)

3.03 (0.961)

Block #2: Coordinate 2

0.107 (1)

3.96 (1.04)

Block #3: Coordinate 3

-0.086 (1.1)

5.09 (0.988)

We can also get plots of the estimated component densities for each block (recall that in this
example, block ℓ consists only of coordinate ℓ) using the plot function. The resulting plots
are given in Figure 5.

> plot(a)

4.4. A more general multivariate nonparametric example

In this section, we ﬁt a more diﬃcult example, with non-multimodal mixture densities (in
block #2), heavy-tailed distributions, and diﬀerent scales among the coordinates. The model
is multivariate with r = 5 repeated measures and m = 2 components (hence identiﬁability
holds; cf. Hall and Zhou (2003) as cited in Section 4.3). The 5 repeated measures are grouped
into B = 2 blocks, with b1 = b2 = b3 = 1 and b4 = b5 = 2. Block 1 corresponds to a mixture
of two noncentral Student t distributions, t′(2, 0) and t′(10, 8), where the ﬁrst parameter is
the number of degrees of freedom, and the second is the non-centrality. Block 2 corresponds
to a mixture of Beta distributions, B(1, 1) (which is actually the uniform distribution over
[0, 1]) and B(1, 5). The ﬁrst component weight is λ1 = 0.4. The true mixtures are depicted
in Figure 6.
To ﬁt this model in mixtools, we ﬁrst set up the model parameters:

> m <- 2; r <- 5
> lambda <- c(0.4, 0.6)
> df <- c(2, 10); ncp <- c(0, 8)
> sh1 <- c(1, 1) ; sh2 <- c(1, 5)

16

y
t
i
s
n
e
D

0
2
.
0

5
1
.
0

0
1
.
0

5
0
.
0

0
0
.
0

mixtools for Mixture Models

Coordinate 1

Coordinate 2

Coordinate 3

0.367
0.633

0.367
0.633

y
t
i
s
n
e
D

5
2
.
0

0
2
.
0

5
1
.
0

0
1
.
0

5
0
.
0

0
0
.
0

0.367
0.633

y
t
i
s
n
e
D

5
2
.
0

0
2
.
0

5
1
.
0

0
1
.
0

5
0
.
0

0
0
.
0

−2

0

2

4

6

−4

−2

0

2

4

6

−2

0

2

4

6

8

xx

xx

xx

Figure 5: Output of the npEM algorithm for the trivariate Gaussian model with independent
repeated measures.

Then we generate a pseudo-random sample of size n = 300 from this model:

> n <- 300; z <- sample(m, n, rep = TRUE, prob = lambda)
> r1 <- 3; z2 <- rep(z, r1)
> x1 <- matrix(rt(n * r1, df[z2], ncp[z2]), n, r1)
> r2 <- 2; z2 <- rep(z, r2)
> x2 <- matrix(rbeta(n * r2, sh1[z2], sh2[z2]), n, r2)
> x <- cbind(x1, x2)

For this example in which the coordinate densities are on diﬀerent scales, it is obvious that
the bandwidth in npEM should depend on the blocks and components. We set up the block
structure and some initial centers, then run the algorithm with the option samebw = FALSE:

> id <- c(rep(1, r1), rep(2, r2))
> centers <- matrix(c(0, 0, 0, 1/2, 1/2, 4, 4, 4, 1/2, 1/2), m, r,
+
> b <- npEM(x, centers, id, eps = 1e-8, verb = FALSE, samebw = FALSE)

byrow = TRUE)

Figure 7 shows the resulting density estimates, which may be obtained using the plotting
function included in mixtools:

> plot(b, breaks = 15)

Finally, we can compute the ISE of the estimated density relative to the truth for each block
and component. The corresponding output is depicted in Figure 8.

> par(mfrow=c(2,2))
> for (j in 1:2){

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

17

Block 1

Block 2

y
t
i
s
n
e
D

4
1
0

.

2
1

.

0

0
1
0

.

8
0
0

.

6
0

.

0

4
0

.

0

2
0

.

0

0
0

.

0

5

.

3

0

.

3

5
2

.

0
2

.

5

.

1

0
1

.

5
0

.

0

.

0

y
t
i
s
n
e
D

−10

−5

0

5

10

15

20

25

0.0

0.2

0.4

0.6

0.8

1.0

Figure 6: True densities for the mixture of Section 4.4, with individual component densities
(scaled by λj) in dotted lines and mixture densities in solid lines. The noncentral t mixture
of coordinates 1 through 3 is on the left, the beta mixture of coordinates 4 and 5 on the right.

ise.npEM(b, j, 1, truepdf = dt, lower = ncp[j] - 10,

upper = ncp[j] + 10, df = df[j], ncp = ncp[j])

ise.npEM(b, j, 2, truepdf = dbeta, lower = -0.5,

upper = 1.5, shape1 = sh1[j], shape2 = sh2[j])

+
+
+
+
+ }

5. Mixtures of regressions

5.1. Mixtures of linear regressions

Consider a mixture setting where we now assume Xi is a vector of covariates observed with
a response Yi. The goal of mixtures of regressions is to describe the conditional distribution
of Yi|Xi. Mixtures of regressions have been extensively studied in the econometrics literature
and were ﬁrst introduced by Quandt (1972) as the switching regimes (or switching regres-
sions) problem. A switching regimes system is often compared to structural change in a
system (Quandt and Ramsey 1978). A structural change assumes the system depends de-
terministically on some observable variables, but switching regimes implies one is unaware of
what causes the switch between regimes. In the case where it is assumed there are two het-
erogeneous classes, Quandt (1972) characterized the switching regimes problem “by assuming
that nature chooses between regimes with probabilities λ and 1 − λ”.

Suppose we have n independent univariate observations, y1, . . . , yn, each with a corresponding
vector of predictors, x1, . . . , xn, with xi = (xi,1, . . . , xi,p)⊤ for i = 1, . . . , n. We often set
xi,1 = 1 to allow for an intercept term. Let y = (y1, . . . , yn)⊤ and let X be the n × p matrix
consisting of the predictor vectors.
Suppose further that each observation (yi, xi) belongs to one of m classes. Conditional on
membership in the jth component, the relationship between yi and xi is the normal regression

18

mixtools for Mixture Models

Coordinates 1,2,3

Coordinates 4,5

0.433
0.567

y
t
i
s
n
e
D

2
1
.
0

8
0
.
0

4
0
.
0

0
0
.
0

0.433
0.567

y
t
i
s
n
e
D

0
.
3

5
.
2

0
.
2

5
.
1

0
.
1

5
.
0

0
.
0

−5

0

5

10

15

20

25

0.0

0.2

0.4

0.6

0.8

1.0

xx

xx

Figure 7: Result of plotting npEM output for the example of Section 4.4. Since n = 300, the
histogram on the left includes 900 observations and the one on the right includes 600.

model

yi = x⊤

i βj + ϵi,

(11)

where ϵi ∼ N (0, σ2
the error variance for component j, respectively.
Accounting for the mixture structure, the conditional density of yi|xi is

j ) and βj and σ2

j are the p-dimensional vector of regression coeﬃcients and

gθ(yi|xi) =

m

Xj=1

λjϕ(yi|x⊤

i βj, σ2

j ),

(12)

j ) is the normal density with mean x⊤β and variance σ2. Notice that
where ϕ(·|x⊤βj, σ2
the model parameter for this setting is θ = (λ, (β1, σ2
m)). The mixture of
regressions model (12) diﬀers from the well-known mixture of multivariate normals model
(Yi, X⊤
m
j=1 λjNp+1(µj, Σj) because model (12) makes no assertion about the marginal
distribution of Xi, whereas the mixture of multivariate normals speciﬁes that Xi itself has a
mixture of multivariate normals distribution.

1), . . . , (βm, σ2

i )⊤ ∼

P

As a simple example of a dataset to which a mixture of regressions models may be applied,
consider the sample depicted in Figure 9. In this dataset, the measurements of carbon dioxide
(CO2) emissions are plotted versus the gross national product (GNP) for n = 28 countries.
These data are included mixtools; type help("CO2data") in R for more details. Hurn, Justel,
and Robert (2003) analyzed these data using a mixture of regressions from the Bayesian
perspective, pointing out that “there do seem to be several groups for which a linear model
would be a reasonable approximation.” They further point out that identiﬁcation of such
groups could clarify potential development paths of lower GNP countries.

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

19

Integrated Squared Error for f11 = 0.0019

Integrated Squared Error for f12 = 0.0496

true
fitted

true
fitted

0
.
1

8
.
0

6
.
0

4
.
0

2
.
0

0
.
0

−10

−5

0

u

5

10

−0.5

0.0

1.0

1.5

0.5

u

Integrated Squared Error for f21 = 0.0011

Integrated Squared Error for f22 = 0.2158

true
fitted

true
fitted

5

4

3

2

1

0

0
3
.
0

0
2
.
0

0
1
.
0

0
0
.
0

0
2
.
0

5
1
0

.

0
1
.
0

5
0

.

0

0
0
.
0

0

5

10

15

−0.5

0.0

u

1.0

1.5

0.5

u

Figure 8: ise.npEM output for the 5-repeated measures example; the true densities are f11 ≡
t′(2, 0), f21 ≡ t′(10, 8), f12 ≡ U(0,1), f22 ≡ B(1, 5).

5.2. EM algorithms for mixtures of regressions

A standard EM algorithm, as described in Section 2, may be used to ﬁnd a local maximum of
the likelihood surface. de Veaux (1989) describes EM algorithms for mixtures of regressions
in more detail, including proposing a method for choosing a starting point in the parameter
space. The E-step is the same as for any ﬁnite mixture model EM algorithm; i.e., the p(t)
ij
values are updated according to equation (2)—or, in reality, equation (3)—where each ϕ(t)
j (xi)
is replaced in the regression context by ϕ(yi|x⊤

i βj, σ2

j ):

p(t)
ij =

1 +





Xj′̸=j

−1

λ(t)
j′ ϕ(yi|x⊤
λ(t)
j ϕ(yi|x⊤

i βj′, σ2
j′)
j ) 
i βj, σ2


(13)

The update to the λ parameters in the M-step, equation (4), is also the same. Letting
W(t)
nj ), the additional M-step updates to the β and σ parameters are

j = diag(p(t)

1j , . . . , p(t)

20

mixtools for Mixture Models

0
2

5
1

0
1

5

a
t
i
p
a
C

r
e
p
2
O
C

1996 GNP and Emissions Data

USA

NOR

AUS

CAN

RUS

CZ

POL

KOR

GRC

UK

EIRE

NZ

ITL

HUN

POR

ESP

MEX

TUR

FIN

BEL

DEU

DNK

HOL

OST

FRA
SW

JAP

CH

10

20

30

40

Gross National Product

Figure 9: 1996 data on gross national product (GNP) per capita and estimated carbon dioxide
(CO2) emissions per capita. Note that “CH” stands for Switzerland, not China.

given by

β(t+1)
j

σ2(t+1)
j

= (X⊤W(t)

j X)−1X⊤W(t)

j y and
2

W1/2(t)
j

= (cid:13)
(cid:13)
(cid:13)
(cid:13)

(y − X⊤β(t+1)

j

tr(W(t)
j )

)
(cid:13)
(cid:13)
(cid:13)
(cid:13)

,

(14)

(15)

where ∥A∥2 = A⊤A and tr(A) means the trace of the matrix A. Notice that equation (14)
is a weighted least squares (WLS) estimate of βj and equation (15) resembles the variance
estimate used in WLS.
Allowing each component to have its own error variance σ2
j results in the likelihood surface
having no maximizer, since the likelihood may be driven to inﬁnity if one component gives
a regression surface passing through one or more points exactly and the variance for that
component is allowed to go to zero. A similar phenomenon is well-known in the ﬁnite mixture-
of-normals model where the component variances are allowed to be distinct (McLachlan and
Peel 2000). However, in practice we observe this behavior infrequently, and the mixtools
functions automatically force their EM algorithms to restart at randomly chosen parameter
values when it occurs. A local maximum of the likelihood function, a consistent version of
which is guaranteed to exist by the asymptotic theory as long as the model is correct and all
λj are positive, usually results without any restarts.
The function regmixEM implements the EM algorithm for mixtures of regressions in mix-
tools. This function has arguments that control options such as adding an intercept term,
addintercept = TRUE; forcing all βj estimates to be the same, arbmean = FALSE (for in-
stance, to model outlying observations as having a separate error variance from the non-
outliers); and forcing all σ2
j estimates to be the same, arbvar = FALSE. For additional details,
type help("regmixEM").

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

21

As an example, we ﬁt a 2-component model to the GNP data shown in Figure 9. Hurn et al.
(2003) and Young (2007) selected 2 components for this dataset using model selection criteria,
Bayesian approaches to selecting the number of components, and a bootstrapping approach.
The function regmixEM will be used for ﬁtting a 2-component mixture of regressions by an
EM algorithm:

> data("CO2data")
> attach(CO2data)

> CO2reg <- regmixEM(CO2, GNP, lambda = c(1, 3) / 4,
+

beta = matrix(c(8, -1, 1, 1), 2, 2), sigma = c(2, 1))

number of iterations= 10

We can then pull out the ﬁnal observed log-likelihood as well as estimates for the 2-component
ﬁt, which include ˆλ, ˆβ1, ˆβ2, ˆσ1, and ˆσ2:

> summary(CO2reg)

summary of regmixEM object:
comp 1

comp 2
0.754921 0.245079
2.049315 0.809389
8.678987 1.415150
-0.023344 0.676596

lambda
sigma
beta1
beta2
loglik at estimate: -66.93977

The reader is encouraged to alter the starting values or let the internal algorithm generate
random starting values. However, this ﬁt seems appropriate and the solution is displayed
in Figure 10 along with 99% Working-Hotelling Conﬁdence Bands, which are constructed
automatically by the plot method in this case by assigning each point to its most probable
component and then ﬁtting two separate linear regressions:

> plot(CO2reg, density = TRUE, alpha = 0.01, cex.main = 1.5, cex.lab = 1.5,
+

cex.axis = 1.4)

5.3. Predictor-dependent mixing proportions

Suppose that in model (12), we replace λj by λj(xi) and assume that the mixing proportions
vary as a function of the predictors xi. Allowing this type of ﬂexibility in the model might be
useful for a number of reasons. For instance, sometimes it is the proportions λj that are of
primary scientiﬁc interest, and in a regression setting it may be helpful to know whether these
proportions appear to vary with the predictors. As another example, consider a regmixEM
model using arbmean = FALSE in which the mixture structure only concerns the error vari-
ance: In this case, λj(x) would give some sense of the proportion of outliers in various regions
of the predictor space.

22

mixtools for Mixture Models

Observed Data Log−Likelihood

Most Probable Component Membership

d
o
o
h

i
l

i

e
k
L
−
g
o
L

0
0
5
−

0
0
0
1
−

0
0
5
1
−

0
2

5
1

0
1

5

e
s
n
o
p
s
e
R

2

4

6

8

10

10

20

30

40

Iteration

Predictor

Figure 10: The GNP data ﬁtted with a 2-component parametric EM algorithm in mixtools.
Left: the sequence of log-likelihood values, Lx(θ(t)); Right: the ﬁtted regression lines with
99% Working-Hotelling Conﬁdence Bands.

One may assume that λj(x) has a particular parametric form, such as a logistic function, which
introduces new parameters requiring estimation. This is the idea of the hierarchical mixtures
of experts (HME) procedure (Jacobs, Jordan, Nowlan, and Hinton 1991), which is commonly
used in neural networks and which is implemented, for example, in the ﬂexmix package for
R (Leisch 2004; Grün and Leisch 2008). However, a parametric form of λj(x) may be too
restrictive; in particular, the logistic function is monotone, which may not realistically capture
the pattern of change of λj as a function of x. As an alternative, Young and Hunter (2009)
propose a nonparametric estimate of λj(xi) that uses ideas from kernel density estimation.
The intuition behind the approach of Young and Hunter (2009) is as follows: The M-step
estimate (4) of λj at each iteration of a ﬁnite mixture model EM algorithm is simply an
average of the “posterior” probabilities pij = E(Zij|data). As a substitute, the nonparametric
approach uses local linear regression to approximate the λj(x) function. Considering the case
of univariate x for simplicity, we set λj(x) = ˆα0j(x), where

( ˆα0j(x), ˆα1j(x)) = arg min
(α0,α1)

n

Xi=1

Kh(x − xi) [pij − α0 − α1(x − xi)]2

(16)

and Kh(·) is a kernel density function with scale parameter (i.e., bandwidth) h. It is straight-
forward to generalize equation (16) to the case of vector-valued x by using a multivariate
kernel function.

Young and Hunter (2009) give an iterative algorithm for estimating mixture of regression
parameters that replaces the standard λj updates (4) by the kernel-weighted version (16).
The algorithm is otherwise similar to a standard EM; thus, like the algorithm in Section 4.1
of this article, the resulting algorithm is an EM-like algorithm. Because only the λj parameters
depend on x (and are thus “locally estimated”), whereas the other parameters (the βj and
σj) can be considered to be globally estimated, Young and Hunter (2009) call this algorithm

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

23

an iterative global/local estimation (IGLE) algorithm. Naturally, it replaces the usual E-step
(13) by a modiﬁed version in which each λj is replaced by λj(xi).
The function regmixEM.loc implements the IGLE algorithm in mixtools. Like the regmixEM
function, regmixEM.loc has the ﬂexibility to include an intercept term by using addintercept
= TRUE. Moreover, this function has the argument kern.l to specify the kernel used in the
local estimation of the λj(xi). Kernels the user may specify include "Gaussian", "Beta",
"Triangle", "Cosinus", and "Optcosinus". Further numeric arguments relating to the
chosen kernel include kernl.g to specify the shape parameter for when kern.l = "Beta"
and kernl.h to specify the bandwidth which controls the size of the window used in the local
estimation of the mixing proportions. See the corresponding help ﬁle for additional details.

For the GNP and emissions dataset, Figure 10 indicates that the assumption of constant
weights for the component regressions across all values of the covariate space may not be
appropriate. The countries with higher GNP values appear to have a greater probability of
belonging to the ﬁrst component (i.e., the red line in Figure 10). We will therefore apply the
IGLE algorithm to this dataset.

We will use the triweight kernel in equation (16), which is given by setting γ = 3 in

Kh(x) =

1
hB(1/2, γ + 1)

1 −

γ

x2
h2 !
+

,

(17)

where B(x, y) = Γ(x)Γ(y)/Γ(x+y) is the beta function. For the triweight, B(1/2, 4) is exactly
32/35. This kernel may be speciﬁed in regmixEM.loc with kern.l = "Beta" and kernl.g
= 3. The bandwidth we selected was h = 20, which we specify with kernl.h = 20.

For this implementation of the IGLE algorithm, we set the parameter estimates and posterior
probability estimates obtained from the mixture of regressions EM algorithm as starting
values for ˆβ1, ˆβ2, ˆσ1, ˆσ2, and λ(xi).

> CO2igle <- regmixEM.loc(CO2, GNP, beta = CO2reg$beta, sigma = CO2reg$sigma,
+
+

lambda = CO2reg$posterior, kern.l = "Beta",
kernl.h = 20, kernl.g = 3)

number of overall iterations= 5

We can view the estimates for ˆβ1, ˆβ2, ˆσ1, and ˆσ2. Notice that the estimates are comparable
to those obtained for the mixture of regressions EM output and the log-likelihood value is
slightly higher.

> summary(CO2igle)

summary of regmixEM.loc object:

comp 1

comp 2
sigma
2.0017258 0.794894
8.9374896 1.543852
beta1
beta2 -0.0326483 0.671375
loglik at estimate: -52.73

Next, we can plot the estimates of λ(xi) from the IGLE algorithm.

24

mixtools for Mixture Models

ylab = "Final posterior probabilities")

> plot(GNP, CO2igle$post[,1], xlab = "GNP", cex.axis = 1.4, cex.lab = 1.5,
+
> lines(sort(GNP), CO2igle$lambda[order(GNP), 1], col=2)
> abline(h = CO2igle$lambda[1], lty = 2)

This plot is given in Figure 11. Notice the curvature provided by the estimates from the
IGLE ﬁt. These ﬁts indicate an upward trend in the posteriors. The predictor-dependent
mixing proportions model provides a viable way to reveal this trend since the regular mixture
of regressions ﬁt simply provides the same estimate of λ for all xi.

s
e
i
t
i
l
i

b
a
b
o
r
p

r
o
i
r
e
t
s
o
p

l

a
n
F

i

0
.
1

8
.
0

6
.
0

4
.
0

2
.
0

0
.
0

10

20

30

40

GNP

Figure 11: Posterior membership probabilities pi1 for component one versus the predictor
GNP along with estimates of λ1(x) from the IGLE algorithm (the solid red curve) and λ1
from the mixture of linear regressions EM algorithm (the dashed black line).

5.4. Parametric bootstrapping for standard errors

With likelihood methods for estimation in mixture models, it is possible to obtain standard
error estimates by using the inverse of the observed information matrix when implementing
a Newton-type method. However, this may be computationally burdensome. An alternative
way to report standard errors in the likelihood setting is by implementing a parametric boot-
strap. Efron and Tibshirani (1993) claim that the parametric bootstrap should provide similar
standard error estimates to the traditional method involving the information matrix. In a
mixture-of-regressions context, a parametric bootstrap scheme may be outlined as follows:

1. Use regmixEM to ﬁnd a local maximizer ˆθ of the likelihood.

2. For each xi, simulate a response value y∗

i from the mixture density gˆθ(·|xi).

3. Find a parameter estimate ˜θ for the bootstrap sample using regmixEM.

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

25

4. Use some type of check to determine whether label-switching appears to have occurred,

and if so, correct it.

5. Repeat steps 2 through 4 B times to simulate the bootstrap sampling distribution of ˆθ.

6. Use the sample covariance matrix of the bootstrap sample as an approximation to the

covariance matrix of ˆθ.

Note that step 3, which is not part of a standard parametric bootstrap, can be especially
important in a mixture setting.
The mixtools package implements a parametric bootstrap algorithm in the boot.se function.
We may apply it to the regression example of this section, which assumes the same estimate
of λ for all xi, as follows:

> set.seed(123)
> CO2boot <- boot.se(CO2reg, B = 100)

This output consists of both the standard error estimates and the parameter estimates ob-
tained at each bootstrap replicate. An examination of the slope and intercept parameter
estimates of the 500 bootstrap replicates reveals that no label-switching is likely to have oc-
curred. For instance, the intercept terms of component one range from 4 to 11, whereas the
intercept terms of component two are all tightly clumped around 0:

> rbind(range(CO2boot$beta[1,]), range(CO2boot$beta[2,]))

[,1]

[,2]
[1,]
5.9457352 10.82996406
[2,] -0.1207469 0.08255873

We may examine the bootstrap standard error estimates by themselves as follows:

> CO2boot[c("lambda.se", "beta.se", "sigma.se")]

$lambda.se
[1] 0.08190437 0.08190437

$beta.se

[,2]
[,1]
[1,] 1.00800621 1.09801791
[2,] 0.04126553 0.05144932

$sigma.se
[1] 0.3390159 0.3266480

6. Additional capabilities of mixtools

26

mixtools for Mixture Models

6.1. Selecting the number of components

Determining the number of components k is still a major contemporary issue in mixture
modeling. Two commonly employed techniques are information criterion and parametric
bootstrapping of the likelihood ratio test statistic values for testing

H0
H1

: k = k0
: k = k0 + 1

(18)

for some positive integer k0 (McLachlan 1987).
The mixtools package has functions to employ each of these methods using EM output from
various mixture models. The information criterion functions calculate An Information Cri-
terion (AIC) of Akaike (1973), the Bayesian Information Criterion (BIC) of Schwarz (1978),
the Integrated Completed Likelihood (ICL) of Biernacki, Celeux, and Govaert (2000), and
the consistent AIC (CAIC) of Bozdogan (1987). The functions for performing parametric
bootstrapping of the likelihood ratio test statistics sequentially test k = k0 versus k = k0 + 1
for k0 = 1, 2, . . ., terminating after the bootstrapped p-value for one of these tests exceeds a
speciﬁed signiﬁcance level.
Currently, mixtools has functions for calculating information criteria for mixtures of multi-
nomials (multmixmodel.sel), mixtures of multivariate normals under the conditionally i.i.d.
assumption (repnormmixmodel.sel), and mixtures of regressions (regmixmodel.sel). Out-
put from various mixture model ﬁts available in mixtools can also be passed to the function
boot.comp for the parametric bootstrapping approach. The parameter estimates from these
EM ﬁts are used to simulate data from the null distribution for the test given in (18). For
example, the following application of the multmixmodel.sel function to the water-level multi-
nomial data from Section 3 indicates that either 3 or 4 components seems like the best option
(no more than 4 are allowed here since there are only 8 multinomial trials per observation
and the mixture of multinomials requires 2m ≤ r + 1 for identiﬁability):

> data("Waterdata")
> cutpts <- 10.5*(-6:6)
> watermult <- makemultdata(Waterdata, cuts = cutpts)
> set.seed(10)
> multmixmodel.sel(watermult, comps = 1:4, epsilon = 0.001)

number of iterations= 29
number of iterations= 26
number of iterations= 38

1

2

3

-8097.335 -3279.315 -3164.999 -3149.591
AIC
-8123.360 -3333.368 -3247.079 -3259.698
BIC
-8129.860 -3346.868 -3267.579 -3287.198
CAIC
ICL
-8123.360 -3332.675 -3246.046 -3258.593
Loglik -8084.335 -3252.315 -3123.999 -3094.591

4 Winner
4
3
3
3
4

Young (2007) gives more applications of these functions to real datasets.

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

27

6.2. Bayesian methods

Currently, there are only two mixtools functions relating to Bayesian methodology and they
both pertain to analyzing mixtures of regressions as described in Hurn et al. (2003). The
regmixMH function performs a Metropolis-Hastings algorithm for ﬁtting a mixture of regres-
sions model where a proper prior has been assumed. The sampler output from regmixMH can
then be passed to regcr in order to construct credible regions of the regression lines. Type
help("regmixMH") and help("regcr") for details and an illustrative example.

Acknowledgments

This research is partially supported by NSF Award SES-0518772. DRH received additional
funding from Le Studium, an agency of the Centre National de la Recherche Scientiﬁque of
France.

References

Akaike H (1973). “Information Theory and an Extension of the Maximum Likelihood Prin-
ciple.” In BN Petrov, F Csaki (eds.), Second International Symposium on Information
Theory, pp. 267–281. Akademiai Kiado.

Benaglia T, Chauveau D, Hunter DR (2009a). “An EM-Like Algorithm for Semi- and Non-
Parametric Estimation in Multivariate Mixtures.” Journal of Computational and Graphical
Statistics, 18, 505–526.

Benaglia T, Chauveau D, Hunter DR (2009b). “Bandwidth Selection in an EM-Like Algorithm
for Nonparametric Multivariate Mixtures.” Technical Report hal-00353297, version 1, HAL.
URL http://hal.archives-ouvertes.fr/hal-00353297.

Benaglia T, Chauveau D, Hunter DR, Young D (2009c). “mixtools: An R Package for
Analyzing Finite Mixture Models.” Journal of Statistical Software, 32(6), 1–29. URL
http://www.jstatsoft.org/v32/i06/.

Biernacki C, Celeux G, Govaert G (2000). “Assessing a Mixture Model for Clustering with the
Integrated Completed Likelihood.” IEEE Transactions on Pattern Analysis and Machine
Intelligence, 22(7), 719–725.

Bordes L, Chauveau D, Vandekerkhove P (2007). “A Stochastic EM Algorithm for a Semi-
parametric Mixture Model.” Computational Statistics & Data Analysis, 51(11), 5429–5443.

Bordes L, Mottelet S, Vandekerkhove P (2006).

“Semiparametric Estimation of a Two-

Component Mixture Model.” The Annals of Statistics, 34(3), 1204–1232.

Bozdogan H (1987). “Model Selection and Akaike’s Information Criterion (AIC): The General

Theory and Its Analytical Extensions.” Psychometrika, 52(3), 345–370.

Cruz-Medina IR, Hettmansperger TP, Thomas H (2004). “Semiparametric Mixture Mod-
els and Repeated Measures: The Multinomial Cut Point Model.” Journal of the Royal
Statistical Society C, 53(3), 463–474.

28

mixtools for Mixture Models

de Veaux RD (1989). “Mixtures of Linear Regressions.” Computational Statistics and Data

Analysis, 8, 227–245.

Dempster AP, Laird NM, Rubin DB (1977). “Maximum Likelihood from Incomplete Data

Via the EM Algorithm.” Journal of the Royal Statistical Society B, 39(1), 1–38.

Efron B, Tibshirani R (1993). An Introduction to the Bootstrap. Chapman & Hall, London.

Elmore RT, Hettmansperger TP, Thomas H (2004). “Estimating Component Cumulative
Distribution Functions in Finite Mixture Models.” Communications in Statistics – Theory
and Methods, 33(9), 2075–2086.

Elmore RT, Wang S (2003). “Identiﬁability and Estimation in Finite Mixture Models with

Multinomial Coeﬃcients.” Technical Report 03-04, Penn State University.

Fraley C, Raftery A (2009). mclust: Model-Based Clustering and Normal Mixture Modeling.

R package version 3.3.1, URL http://CRAN.R-project.org/package=mclust.

Grün B, Leisch F (2008). “FlexMix Version 2: Finite Mixtures with Concomitant Variables
and Varying and Constant Parameters.” Journal of Statistical Software, 28(4), 1–35. URL
http://www.jstatsoft.org/v28/i04/.

Hall P, Neeman A, Pakyari R, Elmore RT (2005). “Nonparametric Inference in Multivariate

Mixtures.” Biometrika, 92(3), 667–678.

Hall P, Zhou XH (2003). “Nonparametric Estimation of Component Distributions in a Mul-

tivariate Mixture.” The Annals of Statistics, 31(1), 201–224.

Hettmansperger TP, Thomas H (2000). “Almost Nonparametric Inference for Repeated Mea-

sures in Mixture Models.” Journal of the Royal Statistical Society B, 62(4), 811–825.

Hunter DR, Wang S, Hettmansperger TP (2007). “Inference for Mixtures of Symmetric

Distributions.” The Annals of Statistics, 35, 224–251.

Hurn M, Justel A, Robert CP (2003). “Estimating Mixtures of Regressions.” Journal of

Computational and Graphical Statistics, 12(1), 55–79.

Jacobs RA, Jordan MI, Nowlan SJ, Hinton GE (1991). “Adaptive Mixtures of Local Experts.”

Neural Computation, 3(1), 79–87.

Leisch F (2004). “FlexMix: A General Framework for Finite Mixture.” Journal of Statistical

Software, 11(8), 1–18. URL http://www.jstatsoft.org/v11/i08/.

McLachlan GJ (1987). “On Bootstrapping the Likelihood Ratio Test Statistic for the Number
of Components in a Normal Mixture.” Journal of the Royal Statistical Society C, 36, 318–
324.

McLachlan GJ, Peel D (2000). Finite Mixture Models. John Wiley & Sons, New York.

Quandt RE (1972). “The Estimation of the Parameters of a Linear Regression System Obeying
Two Separate Regimes.” Journal of the American Statistical Association, 67(338), 306–310.

Tatiana Benaglia, Didier Chauveau, David R. Hunter, Derek Young

29

Quandt RE, Ramsey JB (1978). “Estimating Mixtures of Normal Distributions and Switching

Regressions.” Journal of the American Statistical Association, 73(364), 730–738.

R Development Core Team (2009). R: A Language and Environment for Statistical Computing.
R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http:
//www.R-project.org/.

Schwarz G (1978). “Estimating the Dimension of a Model.” The Annals of Statistics, 6(2),

461–464.

Silverman BW (1986). Density Estimation for Statistics and Data Analysis. Chapman &

Hall/CRC.

Young DS (2007). A Study of Mixtures of Regressions. Ph.D. thesis, The Pennsylvania State

University. Unpublished.

Young DS, Hunter DR (2009). “Mixtures of Regressions with Predictor-Dependent Mixing
Proportions.” Technical Report 09-03, Penn State University. URL http://www.stat.psu.
edu/reports/.

Aﬃliation:

Didier Chauveau
Laboratoire MAPMO - UMR 7349 - Fédération Denis Poisson
Université d’Orléans
BP 6759, 45067 Orléans cedex 2, FRANCE.
E-mail: didier.chauveau@univ-orleans.fr
URL: http://www.univ-orleans.fr/mapmo/membres/chauveau/

David R. Hunter
Department of Statistics
326 Thomas Building
Pennsylvania State University
University Park, PA 16802
Telephone: +1/814-863-0979
Fax: +1/814-863-7114
E-mail: dhunter@stat.psu.edu
URL: http://www.stat.psu.edu/~dhunter/

Tatiana Benaglia
Department of Statistics, Penn State (see above)
E-mail: tab321@stat.psu.edu

Derek Young
Department of Statistics, Penn State (see above)
E-mail: dsy109@psu.edu

