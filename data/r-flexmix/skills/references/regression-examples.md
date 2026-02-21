Applications of ﬁnite mixtures of regression models

Bettina Grün
Wirtschaftsuniversität Wien

Friedrich Leisch
Universität für Bodenkultur Wien

Abstract

Package ﬂexmix provides functionality for ﬁtting ﬁnite mixtures of regression models.
The available model class includes generalized linear models with varying and ﬁxed eﬀects
for the component speciﬁc models and multinomial logit models for the concomitant
variable models. This model class includes random intercept models where the random
part is modelled by a ﬁnite mixture instead of a-priori selecting a suitable distribution.

The application of the package is illustrated on various datasets which have been
previously used in the literature to ﬁt ﬁnite mixtures of Gaussian, binomial or Poisson
regression models. The R commands are given to ﬁt the proposed models and additional
insights are gained by visualizing the data and the ﬁtted models as well as by ﬁtting
slightly modiﬁed models.

Keywords: R, ﬁnite mixture models, generalized linear models, concomitant variables.

1. Introduction

Package ﬂexmix provides infrastructure for ﬂexible ﬁtting of ﬁnite mixtures models. The
design principles of the package allow easy extensibility and rapid prototyping. In addition,
the main focus of the available functionality is on ﬁtting ﬁnite mixtures of regression models,
as other packages in R exist which have specialized functionality for model-based clustering,
such as e.g. mclust (Fraley and Raftery 2002) for ﬁnite mixtures of Gaussian distributions.

Leisch (2004) gives a general introduction into the package outlining the main implemen-
tational principles and illustrating the use of the package. The paper is also contained as
a vignette in the package. An example for ﬁtting mixtures of Gaussian regression models
is given in Grün and Leisch (2006). This paper focuses on examples of ﬁnite mixtures of
binomial logit and Poisson regression models. Several datasets which have been previously
used in the literature to demonstrate the use of ﬁnite mixtures of regression models have been
selected to illustrate the application of the package.

The model class covered are ﬁnite mixtures of generalized linear model with focus on binomial
logit and Poisson regressions. The regression coeﬃcients as well as the dispersion parameters
of the component speciﬁc models are assumed to vary for all components, vary between
groups of components, i.e. to have a nesting, or to be ﬁxed over all components. In addition
it is possible to specify concomitant variable models in order to be able to characterize the
components. Random intercept models are a special case of ﬁnite mixtures with varying and
ﬁxed eﬀects as ﬁxed eﬀects are assumed for the coeﬃcients of all covariates and varying eﬀects
for the intercept. These models are often used to capture overdispersion in the data which can
occur for example if important covariates are omitted in the regression. It is then assumed

2

Applications of ﬁnite mixtures of regression models

that the inﬂuence of these covariates can be captured by allowing a random distribution for
the intercept.
This illustration does not only show how the package ﬂexmix can be used for ﬁtting ﬁnite
mixtures of regression models but also indicates the advantages of using an extension package
of an environment for statistical computing and graphics instead of a stand-alone package as
available visualization techniques can be used for inspecting the data and the ﬁtted models.
In addition users already familiar with R and its formula interface should ﬁnd the model
speciﬁcation and a lot of commands for exploring the ﬁtted model intuitive.

2. Model speciﬁcation

Finite mixtures of Gaussian regressions with concomitant variable models are given by:

H(y | x, w, Θ) =

S

X
s=1

πs(w, α)N(y | µs(x), σ2

s ),

s ) is the Gaussian distribution with mean µs(x) = x′βs and variance σ2
where N(· | µs(x), σ2
s .
Θ denotes the vector of all parameters of the mixture distribution and the dependent variables
are y, the independent x and the concomitant w.

Finite mixtures of binomial regressions with concomitant variable models are given by:

H(y | T, x, w, Θ) =

S

X
s=1

πs(w, α)Bi(y | T, θs(x)),

where Bi(· | T, θs(x)) is the binomial distribution with number of trials equal to T and success
probability θs(x) ∈ (0, 1) given by logit(θs(x)) = x′βs.
Finite mixtures of Poisson regressions are given by:

H(y | x, w, Θ) =

S

X
s=1

πs(w, α)Poi(y | λs(x)),

where Poi(· | λs(x)) denotes the Poisson distribution and log(λs(x)) = x′βs.
For all these mixture distributions the coeﬃcients are split into three diﬀerent groups depend-
ing on if ﬁxed, nested or varying eﬀects are speciﬁed:

βs = (β1, βc(s)

2

, βs
3)

where the ﬁrst group represents the ﬁxed, the second the nested and the third the varying
eﬀects. For the nested eﬀects a partition C = {cs | s = 1, . . . S} of the S components is
determined where cs = {s∗ = 1, . . . , S | c(s∗) = c(s)}. A similar splitting is possible for the
variance of mixtures of Gaussian regression models.

The function for maximum likelihood (ML) estimation with the Expectation-Maximization
(EM) algorithm is flexmix() which is described in detail in Leisch (2004).
It takes as
arguments a speciﬁcation of the component speciﬁc model and of the concomitant variable
model. The component speciﬁc model with varying, nested and ﬁxed eﬀects can be speciﬁed
with the M-step driver FLXMRglmfix() which has arguments formula for the varying, nested

Bettina Grün, Friedrich Leisch

3

for the nested and fixed for the ﬁxed eﬀects. formula and fixed take an argument of class
"formula", whereas nested expects an object of class "FLXnested" or a named list specifying
the nested structure with a component k which is a vector of the number of components in
each group of the partition and a component formula which is a vector of formulas for each
In addition there is an argument family which has to be one of
group of the partition.
gaussian, binomial, poisson or Gamma and determines the component speciﬁc distribution
function as well as an offset argument. The argument varFix can be used to determine the
structure of the dispersion parameters.

If only varying eﬀects are speciﬁed the M-step driver FLXMRglm() can be used which only has
an argument formula for the varying eﬀects and also a family and an offset argument. This
driver has the advantage that in the M-step the weighted ML estimation is made separately
for each component which signiﬁes that smaller model matrices are used. If a mixture model
with a lot of components S is ﬁtted to a large data set with N observations and the model
matrix used in the M-step of FLXMRglm() has N rows and K columns, the model matrix used
in the M-step of FLXMRglmfix() has SN rows and up to SK columns.

In general the concomitant variable model is assumed to be a multinomial logit model, i.e. :

πs(w, α) =

ew′αs
u=1 ew′αu
S

P

∀s,

with α = (α′
s)s=1,...,S and α1 ≡ 0. This model can be ﬁtted in ﬂexmix with FLXPmultinom()
which takes as argument formula the formula speciﬁcation of the multinomial logit part. For
ﬁtting the function nnet() is used from package MASS (Venables and Ripley 2002) with
the independent variables speciﬁed by the formula argument and the dependent variables are
given by the a-posteriori probability estimates.

3. Using package ﬂexmix

In the following datasets from diﬀerent areas such as medicine, biology and economics are
used. There are three subsections:
for ﬁnite mixtures of Gaussian regressions, for ﬁnite
mixtures of binomial regression models and for ﬁnite mixtures of Poisson regression models.

3.1. Finite mixtures of Gaussian regressions

This artiﬁcial dataset with 200 observations is given in Grün and Leisch (2006). The data is
generated from a mixture of Gaussian regression models with three components. There is an
intercept with varying eﬀects, an independent variable x1, which is a numeric variable, with
ﬁxed eﬀects and another independent variable x2, which is a categorical variable with two
levels, with nested eﬀects. The prior probabilities depend on a concomitant variable w, which
is also a categorical variable with two levels. Fixed eﬀects are also assumed for the variance.
The data is illustrated in Figure 1 and the true underlying model is given by:

H(y | (x1, x2), w, Θ) =

S

X
s=1

πs(w, α)N(y | µs, σ2),

with βs = (βs

Intercept, βc(s)

x1 , βx2). The nesting signiﬁes that c(1) = c(2) and βc(3)

x1 = 0.

4

Applications of ﬁnite mixtures of regression models

The mixture model is ﬁtted by ﬁrst loading the package and the dataset and then speci-
fying the component speciﬁc model. In a ﬁrst step a component speciﬁc model with only
varying eﬀects is speciﬁed. Then the ﬁtting function flexmix() is called repeatedly using
stepFlexmix(). Finally, we order the components such that they are in ascending order with
respect to the coeﬃcients of the variable x1.

R> set.seed(2807)
R> library("flexmix")
R> data("NregFix", package = "flexmix")
R> Model <- FLXMRglm(~ x2 + x1)
R> fittedModel <- stepFlexmix(y ~ 1, model = Model, nrep = 3, k = 3,
+

data = NregFix, concomitant = FLXPmultinom(~ w))

3 : * * *

R> fittedModel <- relabel(fittedModel, "model", "x1")
R> summary(refit(fittedModel))

$Comp.1

Estimate Std. Error z value Pr(>|z|)

0.13515 21.2394
0.20849 24.4716
0.10633 1.2553

<2e-16 ***
<2e-16 ***
0.2094

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

2.87046
5.10209
0.13348

(Intercept)
x21
x1
---
Signif. codes:

0.99358
5.28836
9.89243

(Intercept)
x21
x1
---
Signif. codes:

(Intercept) -7.64055
4.65090
x21
9.93667
x1
---
Signif. codes:

$Comp.2

Estimate Std. Error z value

Pr(>|z|)

0.18130 5.4803 4.245e-08 ***
0.25232 20.9590 < 2.2e-16 ***
0.11778 83.9892 < 2.2e-16 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.3

Estimate Std. Error z value

Pr(>|z|)

0.25163 -30.365 < 2.2e-16 ***
0.38102 12.207 < 2.2e-16 ***
0.16444 60.429 < 2.2e-16 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The estimated coeﬃcients indicate that the components diﬀer for the intercept, but that they
are not signiﬁcantly diﬀerent for the coeﬃcients of x2. For x1 the coeﬃcient of the ﬁrst
component is not signiﬁcantly diﬀerent from zero and the conﬁdence intervals for the other
two components overlap. Therefore we ﬁt a modiﬁed model, which is equivalent to the true
underlying model. The previously ﬁtted model is used for initializing the EM algorithm:

Bettina Grün, Friedrich Leisch

5

w = 1
x2 = 0

w = 0
x2 = 0

−2

−1

0

1

2

w = 1
x2 = 1

w = 0
x2 = 1

20

10

0

−10

−20

−30

Class 1
Class 2
Class 3

y

20

10

0

−10

−20

−30

−2

−1

0

1

2

x1

Figure 1: Sample with 200 observations from the artiﬁcial example.

R> Model2 <- FLXMRglmfix(fixed = ~ x2, nested = list(k = c(1, 2),
+
formula = c(~ 0, ~ x1)), varFix = TRUE)
R> fittedModel2 <- flexmix(y ~ 1, model = Model2,
+
+
R> BIC(fittedModel)

cluster = posterior(fittedModel), data = NregFix,
concomitant = FLXPmultinom(~ w))

[1] 883.5921

R> BIC(fittedModel2)

[1] 856.9122

The BIC suggests that the restricted model should be preferred.

R> summary(refit(fittedModel2))

$Comp.1

Estimate Std. Error z value

Pr(>|z|)

x21
(Intercept)
---
Signif. codes:

5.11133
2.85755

0.14801 34.533 < 2.2e-16 ***
0.12650 22.590 < 2.2e-16 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

6

Applications of ﬁnite mixtures of regression models

$Comp.2

Estimate Std. Error
5.111327
x21
x1
9.902341
(Intercept) 1.072193
---
Signif. codes:

z value

Pr(>|z|)

0.148011 34.5334 < 2.2e-16 ***
0.091179 108.6027 < 2.2e-16 ***
7.5572 4.119e-14 ***
0.141877

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.3

Estimate Std. Error z value
5.111327
x21
x1
9.902341
(Intercept) -7.848359
---
Signif. codes:

0.148011 34.533 < 2.2e-16 ***
0.091179 108.603 < 2.2e-16 ***
0.197759 -39.687 < 2.2e-16 ***

Pr(>|z|)

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The coeﬃcients are ordered such that the ﬁxed coeﬃcients are ﬁrst, the nested varying coef-
ﬁcients second and the varying coeﬃcients last.

3.2. Finite mixtures of binomial logit regressions

Beta blockers

The dataset is analyzed in Aitkin (1999a,b) using a ﬁnite mixture of binomial regression
models. Furthermore, it is described in McLachlan and Peel (2000) on page 165. The dataset
is from a 22-center clinical trial of beta-blockers for reducing mortality after myocardial
infarction. A two-level model is assumed to represent the data, where centers are at the
upper level and patients at the lower level. The data is illustrated in Figure 2 and the model
is given by:

H(Deaths | Total, Treatment, Center, Θ) =

S

X
s=1

πsBi(Deaths | Total, θs).

First, the center classiﬁcation is ignored and a binomial logit regression model with treatment
as covariate is ﬁtted using glm, i.e. S = 1:

R> data("betablocker", package = "flexmix")
R> betaGlm <- glm(cbind(Deaths, Total - Deaths) ~ Treatment,
+
R> betaGlm

family = "binomial", data = betablocker)

Call:

glm(formula = cbind(Deaths, Total - Deaths) ~ Treatment, family = "binomial",

data = betablocker)

Coefficients:

(Intercept)
-2.1971

TreatmentTreated
-0.2574

Bettina Grün, Friedrich Leisch

7

Degrees of Freedom: 43 Total (i.e. Null);
Null Deviance:
Residual Deviance: 305.8

AIC: 527.2

333

42 Residual

In the next step the center classiﬁcation is included by allowing a random eﬀect for the
intercept given the centers, i.e. the coeﬃcients βs are given by (βs
Intercept|Center, βTreatment).
This signiﬁes that the component membership is ﬁxed for each center. In order to determine
the suitable number of components, the mixture is ﬁtted with diﬀerent numbers of components
and the BIC information criterion is used to select an appropriate model. In this case a model
with three components is selected. The ﬁtted values for the model with three components
are given in Figure 2.

R> betaMixFix <- stepFlexmix(cbind(Deaths, Total - Deaths) ~ 1 | Center,
model = FLXMRglmfix(family = "binomial", fixed = ~ Treatment),
+
k = 2:4, nrep = 3, data = betablocker)
+

2 : * * *
3 : * * *
4 : * * *

R> betaMixFix

Call:
stepFlexmix(cbind(Deaths, Total - Deaths) ~ 1 | Center,

model = FLXMRglmfix(family = "binomial", fixed = ~Treatment),
data = betablocker, k = 2:4, nrep = 3)

iter converged k k0

logLik

ICL
TRUE 2 2 -181.3308 370.6617 377.7984 380.2114
TRUE 3 3 -159.3605 330.7210 341.4262 343.3249
TRUE 4 4 -155.7540 327.5080 341.7815 345.7338

BIC

AIC

2
3
4

12
9
15

In addition the treatment eﬀect can also be included in the random part of the model. As
then all coeﬃcients for the covariates and the intercept follow a mixture distribution the
component speciﬁc model can be speciﬁed using FLXMRglm(). The coeﬃcients are βs =
(βs
Treatment|Center), i.e. it is assumed that the heterogeneity is only between
centers and therefore the aggregated data for each center can be used.

Intercept|Center, βs

R> betaMix <- stepFlexmix(cbind(Deaths, Total - Deaths) ~ Treatment | Center,
+
+

model = FLXMRglm(family = "binomial"), k = 3, nrep = 3,
data = betablocker)

3 : * * *

R> summary(betaMix)

8

Applications of ﬁnite mixtures of regression models

Cluster 1

Cluster 2

Cluster 3

0.20

0.15

0.10

0.05

l

a
t
o
T
/
s
h
t
a
e
D

Center

Control
Treated

Figure 2: Relative number of deaths for the treatment and the control group for each center
in the beta blocker dataset. The centers are sorted by the relative number of deaths in the
control group. The lines indicate the ﬁtted values for each component of the 3-component
mixture model with random intercept and ﬁxed eﬀect for treatment.

Call:
stepFlexmix(cbind(Deaths, Total - Deaths) ~ Treatment |

Center, model = FLXMRglm(family = "binomial"), data = betablocker,
k = 3, nrep = 3)

prior size post>0 ratio
20 0.500
22 0.455
32 0.750

Comp.1 0.240
Comp.2 0.249
Comp.3 0.511

10
10
24

'log Lik.' -158.3095 (df=8)
BIC: 346.8925
AIC: 332.619

The full model with a random eﬀect for treatment has a higher BIC and therefore the smaller
would be preferred.

The default plot of the returned flexmix object is a rootogramm of the a-posteriori proba-
bilities where observations with a-posteriori probabilities smaller than eps are omitted. With
argument mark the component is speciﬁed to have those observations marked which are as-
signed to this component based on the maximum a-posteriori probabilities. This indicates
which components overlap.

R> print(plot(betaMixFix_3, mark = 1, col = "grey", markcol = 1))

Bettina Grün, Friedrich Leisch

9

Rootogram of posterior probabilities > 1e−04

0.0

0.2

0.4

0.6

0.8

1.0

Comp. 1

Comp. 2

Comp. 3

9.0

7.5

6.0

4.5

3.0

1.5

0.0

0.0

0.2

0.4

0.6

0.8

1.0

0.0

0.2

0.4

0.6

0.8

1.0

The default plot of the ﬁtted model indicates that the components are well separated. In
addition component 1 has a slight overlap with component 2 but none with component 3.

The ﬁtted parameters of the component speciﬁc models can be accessed with:

R> parameters(betaMix)

Comp.3
coef.(Intercept)
-2.91633602 -1.5800104 -2.2476996
coef.TreatmentTreated -0.08047852 -0.3248495 -0.2630025

Comp.1

Comp.2

The cluster assignments using the maximum a-posteriori probabilities are obtained with:

R> table(clusters(betaMix))

1 2 3
10 10 24

The estimated probabilities for each component for the treated patients and those in the
control group can be obtained with:

R> predict(betaMix,
+

newdata = data.frame(Treatment = c("Control", "Treated")))

$Comp.1

[,1]
1 0.05135190
2 0.04756999

$Comp.2

[,1]

10

Applications of ﬁnite mixtures of regression models

1 0.1707940
2 0.1295594

$Comp.3

[,1]
1 0.09554808
2 0.07511132

or

R> fitted(betaMix)[c(1, 23), ]

Comp.1

Comp.3
[1,] 0.05135190 0.1707940 0.09554808
[2,] 0.04756999 0.1295594 0.07511132

Comp.2

A further analysis of the model is possible with function refit() which returns the estimated
coeﬃcients together with the standard deviations, z-values and corresponding p-values:

R> summary(refit(getModel(betaMixFix, "3")))

$Comp.1

Estimate Std. Error

z value

Pr(>|z|)

TreatmentTreated -0.258163
-2.250160
(Intercept)
---
Signif. codes:

0.049901 -5.1735 2.297e-07 ***
0.040529 -55.5204 < 2.2e-16 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error

z value

Pr(>|z|)

0.049901 -5.1735 2.297e-07 ***
0.075079 -37.7428 < 2.2e-16 ***

TreatmentTreated -0.258163
(Intercept)
-2.833679
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.3

Estimate Std. Error

z value

Pr(>|z|)

0.049901 -5.1735 2.297e-07 ***
0.055735 -28.8819 < 2.2e-16 ***

TreatmentTreated -0.258163
(Intercept)
-1.609726
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The printed coeﬃcients are ordered to have the ﬁxed eﬀects before the varying eﬀects.

Mehta et al. trial

This dataset is similar to the beta blocker dataset and is also analyzed in Aitkin (1999b).
The dataset is visualized in Figure 3. The observation for the control group in center 15 is
slightly conspicuous and might classify as an outlier.

Bettina Grün, Friedrich Leisch

11

The model is given by:

H(Response | Total, Θ) =

S

X
s=1

πsBi(Response | Total, θs),

with βs = (βs

Intercept|Site, βDrug). This model is ﬁtted with:

R> data("Mehta", package = "flexmix")
R> mehtaMix <- stepFlexmix(cbind(Response, Total - Response)~ 1 | Site,
+
+

model = FLXMRglmfix(family = "binomial", fixed = ~ Drug),
control = list(minprior = 0.04), nrep = 3, k = 3, data = Mehta)

3 : * * *

R> summary(mehtaMix)

Call:
stepFlexmix(cbind(Response, Total - Response) ~ 1 | Site,

model = FLXMRglmfix(family = "binomial", fixed = ~Drug),
control = list(minprior = 0.04), data = Mehta, k = 3,
nrep = 3)

Comp.1 0.0456
Comp.2 0.5012
Comp.3 0.4532

prior size post>0 ratio
4 0.500
44 0.500
42 0.476

2
22
20

'log Lik.' -66.8056 (df=6)
AIC: 145.6112

BIC: 156.3163

One component only contains the observations for center 15 and in order to be able to
ﬁt a mixture with such a small component it is necessary to modify the default argument
for minprior which is 0.05. The ﬁtted values for this model are given separately for each
component in Figure 3.
If also a random eﬀect for the coeﬃcient of Drug is ﬁtted, i.e. βs = (βs
this is estimated by:

Intercept|Site, βs

Drug|Site),

R> mehtaMix <- stepFlexmix(cbind(Response, Total - Response) ~ Drug | Site,
+
+

model = FLXMRglm(family = "binomial"), k = 3, data = Mehta, nrep = 3,
control = list(minprior = 0.04))

3 : * * *

R> summary(mehtaMix)

12

Applications of ﬁnite mixtures of regression models

Cluster 1

Cluster 2

Cluster 3

l

a
t
o
T
/
e
s
n
o
p
s
e
R

0.8

0.6

0.4

0.2

0.0

Site

New
Control

Figure 3: Relative number of responses for the treatment and the control group for each site
in the Mehta et al. trial dataset together with the ﬁtted values. The sites are sorted by the
relative number of responses in the control group.

Call:
stepFlexmix(cbind(Response, Total - Response) ~ Drug |

Site, model = FLXMRglm(family = "binomial"), data = Mehta,
control = list(minprior = 0.04), k = 3, nrep = 3)

Comp.1 0.5084
Comp.2 0.0455
Comp.3 0.4462

prior size post>0 ratio
42 0.524
2 1.000
42 0.476

22
2
20

'log Lik.' -62.02723 (df=8)
BIC: 154.328
AIC: 140.0545

The BIC is smaller for the larger model and this indicates that the assumption of an equal
drug eﬀect for all centers is not conﬁrmed by the data.

Given Figure 3 a two-component model with ﬁxed treatment is also ﬁtted to the data where
site 15 is omitted:

R> Mehta.sub <- subset(Mehta, Site != 15)
R> mehtaMix <- stepFlexmix(cbind(Response, Total - Response) ~ 1 | Site,
+
+

model = FLXMRglmfix(family = "binomial", fixed = ~ Drug),
data = Mehta.sub, k = 2, nrep = 3)

2 : * * *

R> summary(mehtaMix)

Bettina Grün, Friedrich Leisch

13

Call:
stepFlexmix(cbind(Response, Total - Response) ~ 1 | Site,

model = FLXMRglmfix(family = "binomial", fixed = ~Drug),
data = Mehta.sub, k = 2, nrep = 3)

prior size post>0 ratio
42 0.476
42 0.524

20
22

Comp.1 0.472
Comp.2 0.528

'log Lik.' -56.5844 (df=4)
AIC: 121.1688

BIC: 128.1195

Tribolium

A ﬁnite mixture of binomial regressions is ﬁtted to the Tribolium dataset given in Wang and
Puterman (1998). The data was collected to investigate whether the adult Tribolium species
Castaneum has developed an evolutionary advantage to recognize and avoid eggs of its own
species while foraging, as beetles of the genus Tribolium are cannibalistic in the sense that
adults eat the eggs of their own species as well as those of closely related species.

The experiment isolated a number of adult beetles of the same species and presented them
with a vial of 150 eggs (50 of each type), the eggs being thoroughly mixed to ensure uniformity
throughout the vial. The data gives the consumption data for adult Castaneum species. It
reports the number of Castaneum, Confusum and Madens eggs, respectively, that remain
uneaten after two day exposure to the adult beetles. Replicates 1, 2, and 3 correspond to
diﬀerent occasions on which the experiment was conducted. The data is visualized in Figure 4
and the model is given by:

H(Remaining | Total, Θ) =

S

X
s=1

πs(Replicate, α)Bi(Remaining | Total, θs),

with βs = (βs

Intercept, βSpecies). This model is ﬁtted with:

R> data("tribolium", package = "flexmix")
R> TribMix <- stepFlexmix(cbind(Remaining, Total - Remaining) ~ 1,
+
+

k = 2:3, model = FLXMRglmfix(fixed = ~ Species, family = "binomial"),
concomitant = FLXPmultinom(~ Replicate), data = tribolium)

2 : * * *
3 : * * *

The model which is selected as the best in Wang and Puterman (1998) can be estimated with:

family = "binomial")

R> modelWang <- FLXMRglmfix(fixed = ~ I(Species == "Confusum"),
+
R> concomitantWang <- FLXPmultinom(~ I(Replicate == 3))
R> TribMixWang <- stepFlexmix(cbind(Remaining, Total - Remaining) ~ 1,
+
+

data = tribolium, model = modelWang, concomitant = concomitantWang,
k = 2)

14

Applications of ﬁnite mixtures of regression models

Cluster 1

Cluster 2

l

i

a
t
o
T
/
g
n
n
a
m
e
R

i

0.6

0.5

0.4

0.3

0.2

1

2

3

1

2

Replicate

Castaneum
Confusum
Madens
3

Figure 4: Relative number of remaining beetles for the number of replicate. The diﬀerent
panels are according to the cluster assignemnts based on the a-posteriori probabilities of the
model suggested in Wang and Puterman (1998).

2 : * * *

R> summary(refit(TribMixWang))

$Comp.1

I(Species == "Confusum")TRUE -0.56046
-0.64544
(Intercept)

Pr(>|z|)
Estimate Std. Error z value
0.22985 -2.4384
0.01475
0.13260 -4.8674 1.131e-06

I(Species == "Confusum")TRUE *
(Intercept)
---
Signif. codes:

***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error z value Pr(>|z|)

I(Species == "Confusum")TRUE -0.56046
(Intercept)
0.19447
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

0.22985 -2.4384 0.01475 *
0.05459 .
0.10117 1.9222

Wang and Puterman (1998) also considered a model where they omit one conspicuous obser-
vation. This model can be estimated with:

R> TribMixWangSub <- stepFlexmix(cbind(Remaining, Total - Remaining) ~ 1,
+
+

k = 2, data = tribolium[-7,], model = modelWang,
concomitant = concomitantWang)

2 : * * *

Bettina Grün, Friedrich Leisch

15

Trypanosome

The data is used in Follmann and Lambert (1989).
It is from a dosage-response analysis
where the proportion of organisms belonging to diﬀerent populations shall be assessed. It is
assumed that organisms belonging to diﬀerent populations are indistinguishable other than
in terms of their reaction to the stimulus. The experimental technique involved inspection
under the microscope of a representative aliquot of a suspension, all organisms appearing
within two ﬁelds of view being classiﬁed either alive or dead. Hence the total numbers of
organisms present at each dose and the number showing the quantal response were both
random variables. The data is illustrated in Figure 5.

The model which is proposed in Follmann and Lambert (1989) is given by:

H(Dead | Θ) =

S

X
s=1

πsBi(Dead | θs),

where Dead ∈ {0, 1} and with βs = (βs

Intercept, βlog(Dose)). This model is ﬁtted with:

R> data("trypanosome", package = "flexmix")
R> TrypMix <- stepFlexmix(cbind(Dead, 1-Dead) ~ 1, k = 2, nrep = 3,
+
+

data = trypanosome,
fixed = ~ log(Dose)))

model = FLXMRglmfix(family = "binomial",

2 : * * *

R> summary(refit(TrypMix))

$Comp.1

Estimate Std. Error z value

Pr(>|z|)

124.89
-196.32

log(Dose)
(Intercept)
---
Signif. codes:

25.26
4.9443 7.643e-07 ***
39.59 -4.9589 7.089e-07 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error z value

Pr(>|z|)

25.260
4.9443 7.643e-07 ***
41.801 -4.9248 8.443e-07 ***

log(Dose)
124.895
(Intercept) -205.864
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The ﬁtted values are given in Figure 5 together with the ﬁtted values of a generalized linear
model in order to facilitate comparison of the two models.

3.3. Finite mixtures of Poisson regressions

Fabric faults

The dataset is analyzed using a ﬁnite mixture of Poisson regression models in Aitkin (1996).
Furthermore, it is described in McLachlan and Peel (2000) on page 155.
It contains 32

16

Applications of ﬁnite mixtures of regression models

GLM
Mixture model

)
e
v

i
l

A
+
d
a
e
D

(
/
d
a
e
D

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

4.7

4.8

4.9

5.0

5.1

5.2

5.3

5.4

Dose

Figure 5: Relative number of deaths for each dose level together with the ﬁtted values for the
generalized linear model (“GLM”) and the random intercept model (“Mixture model”).

observations on the number of faults in rolls of a textile fabric. A random intercept model is
used where a ﬁxed eﬀect is assumed for the logarithm of length:

R> data("fabricfault", package = "flexmix")
R> fabricMix <- stepFlexmix(Faults ~ 1, model = FLXMRglmfix(family="poisson",
+

fixed = ~ log(Length)), data = fabricfault, k = 2, nrep = 3)

2 : * * *

R> summary(fabricMix)

Call:
stepFlexmix(Faults ~ 1, model = FLXMRglmfix(family = "poisson",

fixed = ~log(Length)), data = fabricfault, k = 2,
nrep = 3)

prior size post>0 ratio
32 0.844
32 0.156

27
5

Comp.1 0.796
Comp.2 0.204

'log Lik.' -86.33119 (df=4)
AIC: 180.6624

BIC: 186.5253

R> summary(refit(fabricMix))

$Comp.1

Estimate Std. Error z value

Pr(>|z|)

Bettina Grün, Friedrich Leisch

17

0.23491 3.4019 0.0006692 ***
1.51934 -2.0588 0.0395167 *

log(Length)
0.79913
(Intercept) -3.12797
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error z value

Pr(>|z|)

0.23491 3.4019 0.0006692 ***
1.59146 -1.4842 0.1377594

log(Length)
0.79913
(Intercept) -2.36202
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

R> Lnew <- seq(0, 1000, by = 50)
R> fabricMix.pred <- predict(fabricMix, newdata = data.frame(Length = Lnew))

The intercept of the ﬁrst component is not signiﬁcantly diﬀerent from zero for a signﬁcance
level of 0.05. We therefore also ﬁt a modiﬁed model where the intercept is a-priori set to zero
for the ﬁrst component. This nested structure is given as part of the model speciﬁcation with
argument nested.

R> fabricMix2 <- flexmix(Faults ~ 0, data = fabricfault,
+
+
+
R> summary(refit(fabricMix2))

cluster = posterior(fabricMix),
model = FLXMRglmfix(family = "poisson", fixed = ~ log(Length),
nested = list(k=c(1,1), formula=list(~0,~1))))

$Comp.1

Estimate Std. Error z value

Pr(>|z|)

0.013437 22.922 < 2.2e-16 ***

log(Length) 0.308000
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error z value

Pr(>|z|)

0.013437 22.9215 < 2.2e-16 ***
0.132720 6.9415 3.878e-12 ***

log(Length) 0.308000
(Intercept) 0.921282
---
Signif. codes:

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

R> fabricMix2.pred <- predict(fabricMix2,
newdata = data.frame(Length = Lnew))
+

The data and the ﬁtted values for each of the components for both models are given in
Figure 6.

Patent

The patent data given in Wang, Cockburn, and Puterman (1998) consist of 70 observations
on patent applications, R&D spending and sales in millions of dollar from pharmaceutical

18

Applications of ﬁnite mixtures of regression models

Model 1
Model 2

s
t
l
u
a
F

5
2

0
2

5
1

0
1

5

0

200

400

600

800

Length

Figure 6: Observed values of the fabric faults dataset together with the ﬁtted values for the
components of each of the two ﬁtted models.

and biomedical companies in 1976 taken from the National Bureau of Economic Research
R&D Masterﬁle. The observations are displayed in Figure 7. The model which is chosen as
the best in Wang et al. (1998) is given by:

H(Patents | lgRD, RDS, Θ) =

S

X
s=1

πs(RDS, α)Poi(Patents | λs),

and βs = (βs
The model is ﬁtted with:

Intercept, βs

lgRD).

R> data("patent", package = "flexmix")
R> ModelPat <- FLXMRglm(family = "poisson")
R> FittedPat <- stepFlexmix(Patents ~ lgRD, k = 3, nrep = 3,
+

model = ModelPat, data = patent, concomitant = FLXPmultinom(~ RDS))

3 : * * *

R> summary(FittedPat)

Call:
stepFlexmix(Patents ~ lgRD, model = ModelPat, data = patent,

concomitant = FLXPmultinom(~RDS), k = 3, nrep = 3)

prior size post>0 ratio
63 0.714
47 0.277

45
13

Comp.1 0.615
Comp.2 0.184

Bettina Grün, Friedrich Leisch

19

Comp.3 0.201

12

48 0.250

'log Lik.' -197.6753 (df=10)
BIC: 437.8355
AIC: 415.3505

The ﬁtted values for the component speciﬁc models and the concomitant variable model
are given in Figure 7. The plotting symbol of the observations corresponds to the induced
clustering given by clusters(FittedPat).
This model is modiﬁed to have ﬁxed eﬀects for the logarithmized R&D spendings, i.e. (β)s =
(βs
Intercept, βlgRD). The already ﬁtted model is used for initialization, i.e. the EM algorithm is
started with an M-step given the a-posteriori probabilities.

R> ModelFixed <- FLXMRglmfix(family = "poisson", fixed = ~ lgRD)
R> FittedPatFixed <- flexmix(Patents ~ 1, model = ModelFixed,
+
+
R> summary(FittedPatFixed)

cluster = posterior(FittedPat), concomitant = FLXPmultinom(~ RDS),
data = patent)

Call:
flexmix(formula = Patents ~ 1, data = patent, cluster = posterior(FittedPat),

model = ModelFixed, concomitant = FLXPmultinom(~RDS))

prior size post>0 ratio
63 0.397
52 0.269
54 0.574

Comp.1 0.361
Comp.2 0.203
Comp.3 0.436

25
14
31

'log Lik.' -216.824 (df=8)
AIC: 449.6479

BIC: 467.6359

The ﬁtted values for the component speciﬁc models and the concomitant variable model of
this model are also given in Figure 7.

With respect to the BIC the full model is better than the model with the ﬁxed eﬀects.
However, ﬁxed eﬀects have the advantage that the diﬀerent components diﬀer only in their
baseline and the relation between the components in return of investment for each additional
unit of R&D spending is constant. Due to a-priori domain knowledge this model might seem
more plausible. The ﬁtted values for the constrained model are also given in Figure 7.

Seizure

The data is used in Wang, Puterman, Cockburn, and Le (1996) and is from a clinical trial
where the eﬀect of intravenous gamma-globulin on suppression of epileptic seizures is studied.
There are daily observations for a period of 140 days on one patient, where the ﬁrst 27 days
are a baseline period without treatment, the remaining 113 days are the treatment period.
The model proposed in Wang et al. (1996) is given by:

H(Seizures | (Treatment, log(Day), log(Hours)), Θ) =

S

X
s=1

πsPoi(Seizures | λs),

20

Applications of ﬁnite mixtures of regression models

Fixed effects

Fixed effects

200

150

100

50

s 0
t
n
e
t
a
P

200

150

100

50

0

Wang et al.

y
t
i
l
i

b
a
b
o
r
P

0.8

0.6

0.4

0.2

0.0

0.8

0.6

0.4

0.2

0.0

Wang et al.

−2

0

2

4

log(R&D)

0.0 0.5 1.0 1.5 2.0 2.5 3.0

RDS

Figure 7: Patent data with the ﬁtted values of the component speciﬁc models (left) and the
concomitant variable model (right) for the model in Wang et al. and with ﬁxed eﬀects for
log(R&D). The plotting symbol for each observation is determined by the component with
the maximum a-posteriori probability.

Bettina Grün, Friedrich Leisch

21

where (β)s = (βs
set. This model is ﬁtted with:

Intercept, βs

Treatment, βs

log(Day), βs

Treatment:log(Day)) and log(Hours) is used as oﬀ-

R> data("seizure", package = "flexmix")
R> seizMix <- stepFlexmix(Seizures ~ Treatment * log(Day), data = seizure,
+
+

k = 2, nrep = 3, model = FLXMRglm(family = "poisson",
offset = log(seizure$Hours)))

2 : * * *

R> summary(seizMix)

Call:
stepFlexmix(Seizures ~ Treatment * log(Day), data = seizure,

model = FLXMRglm(family = "poisson", offset = log(seizure$Hours)),
k = 2, nrep = 3)

prior size post>0 ratio
115 0.896
101 0.366

103
37

Comp.1 0.724
Comp.2 0.276

'log Lik.' -376.1762 (df=9)
AIC: 770.3525

BIC: 796.8272

R> summary(refit(seizMix))

$Comp.1

Estimate Std. Error z value
(Intercept)
2.070226
TreatmentYes
7.432200
-0.270550
log(Day)
TreatmentYes:log(Day) -2.276359
---
Signif. codes:

0.092252 22.441 < 2.2e-16 ***
0.548865 13.541 < 2.2e-16 ***
0.042320 -6.393 1.626e-10 ***
0.147857 -15.396 < 2.2e-16 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Pr(>|z|)

$Comp.2

Estimate Std. Error z value

Pr(>|z|)

2.84422
(Intercept)
1.30319
TreatmentYes
log(Day)
-0.40593
TreatmentYes:log(Day) -0.43139
---
Signif. codes:

0.25898 10.9825 < 2.2e-16 ***
0.54448 2.3935
0.10014 -4.0537 5.04e-05 ***
0.15265 -2.8261 0.004712 **

0.016690 *

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

A diﬀerent model with diﬀerent contrasts to directly estimate the coeﬃcients for the jump
when changing between base and treatment period is given by:

22

Applications of ﬁnite mixtures of regression models

R> seizMix2 <- flexmix(Seizures ~ Treatment * log(Day/27),
+
+
R> summary(seizMix2)

data = seizure, cluster = posterior(seizMix),
model = FLXMRglm(family = "poisson", offset = log(seizure$Hours)))

Call:
flexmix(formula = Seizures ~ Treatment * log(Day/27),

data = seizure, cluster = posterior(seizMix), model = FLXMRglm(family = "poisson",

offset = log(seizure$Hours)))

prior size post>0 ratio
115 0.896
101 0.366

103
37

Comp.1 0.724
Comp.2 0.276

'log Lik.' -376.1762 (df=9)
AIC: 770.3524

BIC: 796.8272

R> summary(refit(seizMix2))

$Comp.1

Estimate Std. Error
1.178452
(Intercept)
-0.070116
TreatmentYes
-0.270600
log(Day/27)
TreatmentYes:log(Day/27) -2.276249
---
Signif. codes:

z value

Pr(>|z|)

0.072453 16.2650 < 2.2e-16 ***
0.116887 -0.5999
0.042324 -6.3935 1.621e-10 ***
0.147854 -15.3953 < 2.2e-16 ***

0.5486

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error z value
1.506044
(Intercept)
-0.118471
TreatmentYes
log(Day/27)
-0.406176
TreatmentYes:log(Day/27) -0.431134
---
Signif. codes:

0.091612 16.4394 < 2.2e-16 ***
0.140926 -0.8407
0.100100 -4.0577 4.956e-05 ***
0.152620 -2.8249

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

0.00473 **

Pr(>|z|)

0.40054

A diﬀerent model which allows no jump at the change between base and treatment period is
ﬁtted with:

R> seizMix3 <- flexmix(Seizures ~ log(Day/27)/Treatment, data = seizure,
+
+
R> summary(seizMix3)

cluster = posterior(seizMix), model = FLXMRglm(family = "poisson",
offset = log(seizure$Hours)))

Call:
flexmix(formula = Seizures ~ log(Day/27)/Treatment, data = seizure,

Bettina Grün, Friedrich Leisch

23

cluster = posterior(seizMix), model = FLXMRglm(family = "poisson",

offset = log(seizure$Hours)))

prior size post>0 ratio
115 0.887
101 0.376

102
38

Comp.1 0.722
Comp.2 0.278

'log Lik.' -376.6495 (df=7)
AIC: 767.2991

BIC: 787.8906

R> summary(refit(seizMix3))

$Comp.1

Estimate Std. Error
1.150003
(Intercept)
log(Day/27)
-0.283878
log(Day/27):TreatmentYes -2.311510
---
Signif. codes:

z value

Pr(>|z|)

0.058217 19.7537 < 2.2e-16 ***
0.036969 -7.6788 1.606e-14 ***
0.134828 -17.1441 < 2.2e-16 ***

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

$Comp.2

Estimate Std. Error z value
1.458918
(Intercept)
-0.447634
log(Day/27)
log(Day/27):TreatmentYes -0.458721
---
Signif. codes:

0.067241 21.6968 < 2.2e-16 ***
0.081633 -5.4835 4.17e-08 ***
0.145578 -3.1510 0.001627 **

0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Pr(>|z|)

With respect to the BIC criterion the smaller model with no jump is preferred. This is also the
more intuitive model from a practitioner’s point of view, as it does not seem to be plausible
that starting the treatment already gives a signiﬁcant improvement, but improvement develops
over time. The data points together with the ﬁtted values for each component of the two
models are given in Figure 8. It can clearly be seen that the ﬁtted values are nearly equal
which also supports the smaller model.

Ames salmonella assay data

The ames salomnella assay dataset was used in Wang et al. (1996). They propose a model
given by:

H(y | x, Θ) =

S

X
s=1

πsPoi(y | λs),

where βs = (βs

Intercept, βx, βlog(x+10)). The model is ﬁtted with:

R> data("salmonellaTA98", package = "flexmix")
R> salmonMix <- stepFlexmix(y ~ 1, data = salmonellaTA98, k = 2, nrep = 3,
+

model = FLXMRglmfix(family = "poisson", fixed = ~ x + log(x + 10)))

24

Applications of ﬁnite mixtures of regression models

s
r
u
o
H
/
s
e
r
u
z
e
S

i

8

6

4

2

0

Baseline
Treatment

Model 1
Model 3

0

20

40

60

80

100

120

140

Day

Figure 8: Observed values for the seizure dataset together with the ﬁtted values for the
components of the two diﬀerent models.

2 : * * *

4. Conclusions and future work

Package ﬂexmix can be used to ﬁt ﬁnite mixtures of regressions to datasets used in the
literature to illustrate these models. The results can be reproduced and additional insights
can be gained using visualization methods available in R. The ﬁtted model is an object in R
which can be explored using show(), summary() or plot(), as suitable methods have been
implemented for objects of class "flexmix" which are returned by flexmix().

In the future it would be desirable to have more diagnostic tools available to analyze the model
ﬁt and compare diﬀerent models. The use of resampling methods would be convenient as they
can be applied to all kinds of mixtures models and would therefore suit well the purpose of
the package which is ﬂexible modelling of various ﬁnite mixture models. Furthermore, an
additional visualization method for the ﬁtted coeﬃcients of the mixture would facilitate the
comparison of the components.

Computational details

All computations and graphics in this paper have been done using R version 4.4.2 with the
packages mvtnorm 1.3-3, ellipse 0.5.0, diptest 0.77-1, ﬂexmix 2.3-20, lattice 0.22-6, compiler
4.4.2, modeltools 0.2-23, tools 4.4.2, nnet 7.3-20, stats4 4.4.2.

Bettina Grün, Friedrich Leisch

25

0
6

0
5

0
4

0
3

0
2

1

2

2

2

2

2

1

2
2
2
2
2

0

2
2

2

1

2

2

200

400

600

800

1000

Dose of quinoline

a

l
l

e
n
o
m
a
s

l

f
o

i

s
e
n
o
o
c

l

t
n
a
t
r
e
v
e
r

f
o

r
e
b
m
u
N

Figure 9: Means and classiﬁcation for assay data according to the estimated posterior prob-
abilities based on the ﬁtted model.

Acknowledgments

This research was supported by the the Austrian Science Foundation (FWF) under grant
P17382 and the Austrian Academy of Sciences (ÖAW) through a DOC-FFORTE scholarship
for Bettina Grün.

References

Aitkin M (1996). “A General Maximum Likelihood Analysis of Overdispersion in Generalized

Linear Models.” Statistics and Computing, 6, 251–262.

Aitkin M (1999a). “A General Maximum Likelihood Analysis of Variance Components in

Generalized Linear Models.” Biometrics, 55, 117–128.

Aitkin M (1999b). “Meta-Analysis by Random Eﬀect Modelling in Generalized Linear Mod-

els.” Statistics in Medicine, 18(17–18), 2343–2351.

Follmann DA, Lambert D (1989). “Generalizing Logistic Regression by Non-Parametric Mix-

ing.” Journal of the American Statistical Association, 84(405), 295–300.

Fraley C, Raftery AE (2002). “MCLUST: Software for Model-Based Clustering, Discriminant
Analysis and Density Estimation.” Technical Report 415, Department of Statistics, Univer-
sity of Washington, Seattle, WA, USA. URL http://www.stat.washington.edu/raftery.

Grün B, Leisch F (2006). “Fitting Finite Mixtures of Linear Regression Models with Varying
& Fixed Eﬀects in R.” In A Rizzi, M Vichi (eds.), Compstat 2006—Proceedings in Compu-
tational Statistics, pp. 853–860. Physica Verlag, Heidelberg, Germany. ISBN 3-7908-1708-2.

26

Applications of ﬁnite mixtures of regression models

Leisch F (2004). “FlexMix: A General Framework for Finite Mixture Models and Latent Class
Regression in R.” Journal of Statistical Software, 11(8). doi:10.18637/jss.v011.i08.

McLachlan G, Peel D (2000). Finite Mixture Models. John Wiley and Sons Inc.

Venables WN, Ripley BD (2002). Modern Applied Statistics with S. Fourth edition. Springer

Verlag, New York. ISBN 0-387-95457-0.

Wang P, Cockburn IM, Puterman ML (1998). “Analysis of Patent Data—A Mixed-Poisson-
Regression-Model Approach.” Journal of Business & Economic Statistics, 16(1), 27–41.

Wang P, Puterman ML (1998). “Mixed Logistic Regression Models.” Journal of Agricultural,

Biological, and Environmental Statistics, 3(2), 175–200.

Wang P, Puterman ML, Cockburn IM, Le ND (1996). “Mixed Poisson Regression Models

with Covariate Dependent Rates.” Biometrics, 52, 381–400.

Aﬃliation:

Bettina Grün
Institute for Statistics and Mathematics
Wirtschaftsuniversität Wien
Welthandelsplatz 1
1020 Wien, Austria
E-mail: Bettina.Gruen@R-project.org

Friedrich Leisch
Institut für Angewandte Statistik und EDV
Universität für Bodenkultur Wien
Peter Jordan Straße 82
1190 Wien, Austria
E-mail: Friedrich.Leisch@boku.ac.at

