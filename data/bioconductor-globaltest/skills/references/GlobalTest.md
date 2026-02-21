The Global Test
and the globaltest R package

Jelle Goeman

Jan Oosting

Livio Finos

Aldo Solari

Dominic Edelmann

October 30, 2025

Contents

1

Introduction
1.1 Citing globaltest
. . . . . . . . . .
1.2 Package overview . . .
. . . . . . . . . . . . . . . . . . . . . . . . .
1.3 Comparison with the likelihood ratio test . . . . . . . . . . . . . . . .

. . . . .

. . . . .

. . . . .

. . .

2 The global test

.

.

.
.

.
.

. . . .

2.1 Global test basics . .

. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
2.1.1 Example data . . . .
. . . . . . . . . . . . . . . . . . . . . .
. . . .
2.1.2 Options .
. . . . . . . . . . . . . . . . . . . . . .
. . . .
.
2.1.3 The test
2.1.4 Nuisance covariates . . . . . . . . . . . . . . . . . . . . . . .
2.1.5 The gt.object object: extracting information . . . . . . . . . .
2.1.6 Alternative function calls . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
2.1.7 Models .
2.1.8
Stratified Cox model and competing risks survival analysis . .
2.1.9 Null distribution: asymptotic or permutations . . . . . . . . .
2.1.10 Intercept terms . . . . . . . . . . . . . . . . . . . . . . . . .
2.1.11 Covariates of class factor . . . . .
. .
2.1.12 Directing the test: weights . . . . . . . . . . . . . . . . . . .
2.1.13 Directing the test: directional
. . . . . . . . . . . . . . . . .
2.1.14 Offset terms and testing values other than zero . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . .
. . . . . . . . .
2.3 Doing many tests: multiple testing . . . . . . . . . . . . . . . . . . .
2.3.1 Many subsets or many weights . . . . . . . . . . . . . . . . .
. . . . . . . . . . .
2.3.2 Unstructured multiple testing procedures
2.3.3 Graph-structured hypotheses 1: the focus level method . . . .
2.3.4 Graph-structured hypotheses 2: the inheritance method . . . .

2.2.1 The covariates plot
2.2.2 The subjects plot

2.2 Diagnostic plots .

. . . . . . .

. . . . . .

. . . . .

. . . . .

. . . .

. . .

. . .

. . .

. .

3 Gene Set Testing

3.1
3.2 Data format

Introduction .
.

.
.
3.2.1 Using ExpressionSet data . . .

. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . .

. . . . . .

. . .

.
.

.
.

.
.

1

3
3
4
4

6
6
6
6
7
7
7
8
9
10
11
12
14
16
16
17
17
17
21
25
25
27
28
30

34
34
35
35

37
37
37
38
39
41
43
44
44
52
53
53

55
55
56
57
57
59
61
61
63
64
66

66

.

.

. . .

. . . .

. . . . . . .

3.2.2 Other input formats . .
3.2.3 The trim option .
3.3 Testing gene set databases

. . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . .
3.3.1 KEGG .
. . . . . . . . . . . . . . . . . . . . . .
3.3.2 Gene Ontology . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
3.3.3 The Broad gene sets
. . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . .
3.5.1 Visualizing features . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
3.5.2 Visualizing subjects
3.6 Survival data
. . . . . . . . . . . . . . . . . . . . . . . . .
3.7 Comparative proportions . . . . . . . . . . . . . . . . . . . . . . . .

3.4 Concept profiles .
. . .
3.5 Gene and sample plots

. . .

.

.

4 Goodness-of-Fit Testing

.
.
.

P-Splines . .

Introduction .

. . .
. .
. . .

4.1
.
4.2 Heterogeneity .
4.3 Non-linearity .

. . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
4.3.1
4.3.2 Generalized additive models . . . . . . . . . . . . . . . . . .
4.4 Non-linear and missed interactions . . . . . . . . . . . . . . . . . . .
4.4.1 Kernel smoothers . . . . . . . . . . . . . . . . . . . . . . . .
4.4.2 Varying-coefficients models . . . . . . . . . . . . . . . . . .
4.4.3 Missed interactions . . . . . . . . . . . . . . . . . . . . . . .
4.5 Non-proportional hazards . . . . . . . . . . . . . . . . . . . . . . . .

References

2

Chapter 1

Introduction

This vignette explains the use of the globaltest package. Chapter 2 describes the use of
the test and the package from a general statistical perspective. Later chapters explain
how to use the globaltest package for specific applications.

1.1 Citing globaltest

When using the globaltest package, please cite one or more of the following papers, as
appropriate.

• Goeman et al. (2004) is the original paper describing the global test for linear

and logistic regression, and its application to gene set testing.

• Goeman et al. (2005) extends the global test to survival data and explains how to

deal with nuisance (null) covariates.

• Goeman et al. (2006) proves the local optimality of the global test and explores
its general theoretical properties. This is the core paper of the global test method-
ology

• Goeman and Mansmann (2008) develops the Focus Level method for multiple

testing correction in the Gene Ontology graph.

• Goeman et al. (2011) derives the asymptotic distribution of the global test for

generalized linear models.

• Jelier et al. (2011) describes the weighted test based on concept profiles (Section

3.4).

• Goeman and Finos (2012) describes the inheritance multiple testing procedure

that is used in the covariates plot.

3

1.2 Package overview

The global test is meant for data sets in which many covariates (or features) have been
measured for the same subjects, together with a response variable, e.g. a class label, a
survival time or a continuous measurement. The global test can be used on a group (or
subset) of the covariates, testing whether that group of covariates is associated with the
response variable.

The null hypothesis of the global test is that none of the covariates in the tested
group is associated with the response. The alternative is that at least one of the covari-
ates has such an association. However, the global test is designed in such a way that it
is especially directed against the alternative that most of the covariates are associated
with the response in a small way. In fact, against such an alternative the global test is
the optimal test to use (Goeman et al., 2006).

The global test is based on regression models in which the distribution of the re-
sponse variable is modeled as a function of the covariates. The type of regression model
depends on the response. Currently implemented models are

• linear regression (continuous response),

• logistic regression (binary response),

• multinomial logistic regression (multi-class response),

• Poisson regression (count response),

• the Cox proportional hazards model (survival response).

Modeling in terms of a regression model makes it easy to adjust the test for the con-
founding effect of nuisance covariates: covariates that are known to have an effect on
the response and which are correlated with (some of) the covariates of interest, and
which may, if not adjusted for, lead to spurious associations.

The globaltest package implements the global test along with additional function-
ality. Several diagnostic plots can be used to visualize the test result and to decompose
it to see the influence of individual covariates and subjects. Multiple testing procedures
are offered for the situation in which a user wants to perform many global tests on the
same data, e.g. when testing many alternative subsets. In that case, possible relation-
ships between the test results arise due to subset relationships among tested sets which
may be exploited.

The package also offers some functions that are tailored to specific applications of
the global test. In the current version, the only application supported in this way is
gene set testing (see Chapter 3). Tailored functions for other applications (goodness-
of-fit testing, prediction/classification pre-testing, testing for the presence of a random
effect) are under development.

1.3 Comparison with the likelihood ratio test

In its most general form, the global test is a score test for nested parametric models, and
as such it is a competitor of the likelihood ratio test. It can be used in every situation

4

in which a likelihood ratio test may also be used, but the global test’s properties are
different from those of the likelihood ratio test. We summarize the differences briefly
from a theoretical statistical perspective. For more details, see Goeman et al. (2006).

It is well known that the likelihood ratio test is invariant to the parametrization
of the alternative model. The global test does not have this property: it depends on
the model’s precise parametrization. Therefore, there is not a single global test for a
given pair of null and alternative hypothesis, but a multitude of tests: one for each
possible parametrization of the alternative hypothesis.
In return for giving up this
parametrization-invariance, the global test gains an optimality-property that depends
on the parametrization of the model. As detailed in Goeman et al. (2006), the global
test is optimal (among all possible tests) on average in a neighborhood of the null hy-
pothesis. The shape of this neighborhood is determined by the parametrization of the
alternative hypothesis. In practice, this means that in situations in which a “natural”
parametrization of the alternative model exists, the global test for that parametrization
is often more powerful than the likelihood ratio test (examples in Goeman et al., 2006).
A second important property of the global test is that it may still be used in situa-
tions in which the alternative model cannot be fitted to the data, which may happen, for
example, if the alternative model is overparameterized, or in high dimensional situa-
tions in which there are more parameters than observations. In such cases the likelihood
ratio test usually breaks down, but the global test still functions, often with good power.
Being a score test, the global test is most focused on alternatives close to the null
hypothesis. This means that the global test is good at detecting alternatives that have
many small effects (in terms of the chosen parametrization), but that it may not be the
optimal test to use if the effects are very large.

5

Chapter 2

The global test

2.1 Global test basics

We illustrate most of the features of the globaltest package and its functions with a very
simple application on simulated data using a linear regression model. More extensive
real examples relating to specific areas of application can be found in later chapters of
this vignette.

2.1.1 Example data

We simulate some data

> set.seed(1)
> Y <- rnorm(20)
> X <- matrix(rnorm(200), 20, 10)
> X[,1:3] <- X[,1:3] + Y
> colnames(X) <- LETTERS[1:10]

This generates a data matrix X with 10 covariates called A, B, . . . , J, and a response

Y. In truth, the covariates A, B, and C are associated with Y, and the rest are not.

We start the globaltest package

> library(globaltest)

2.1.2 Options

The globaltest package has a gt.options function, which can be used to set some
global options of the package. We use this in this vignette to switch off the progress in-
formation, which is useful if the functions are used interactively, but does not combine
well with Sweave, which was used to make this vignette. We also set the max.print
option in globaltest, which abbreviates long Gene Ontology terms in Chapter 3.

> gt.options(trace=FALSE, max.print=45)

6

2.1.3 The test

The main workhorse function of the globaltest package is the gt function, which per-
forms the actual test. There are several alternative ways to call this function, depending
on the user’s preference to work with formula objects or matrices. We start with the
formula-based way, because this is closest to the statistical theory. Matrix-based calls
are detailed in Section 2.1.6.

In the data set of Section 2.1.1, if we are interested in testing for association be-
tween the group of variables A, B and C with the response Y, we can test the null
hypothesis Y ~ 1 that the response depends on none of the variables in the group,
against the alternative hypothesis Y ~ A + B + C that A, B and C may have an in-
fluence on the response. We test this with

> gt(Y~1, Y~A+B+C, data = X)

p-value Statistic Expected Std.dev #Cov
3

5.12

50.3

5.26

1 2.29e-06

Unlike in anova, the order of the models matters in this call: the second argument
must always be the alternative hypothesis.

The output lists the p-value of the test, the test statistic with its expected value and
standard deviation under the null hypothesis. The #Cov column give the number of
covariates in the alternative model that are not in the null model. In the linear model
the test statistic is scaled in such a way that it takes values between 0 and 100. The
test statistic can be interpreted as 100 times a weighted average (partial) correlation
between the covariates of the alternative and the residuals of the response. In other
models, the test statistic has a roughly similar scaling and interpretation.

2.1.4 Nuisance covariates

A similar syntax can be used to correct the test for nuisance covariates. To correct the
test of the previous section for the possible confounding influence of the covariate D,
we specify the null hypothesis Y ~ D versus the alternative Y ~ A + B + C + D.
Note that the nuisance covariate occurs both in the null and alternative models.

> gt(Y~D, Y~A+B+C+D, data = X)

p-value Statistic Expected Std.dev #Cov
4

5.56

48.1

5.32

1 8.47e-06

2.1.5 The gt.object object: extracting information

The gt function returns a gt.object object, which stores some useful information, for
example the information to make diagnostic plots. Many methods have been defined
for this object. One useful function is the summary method

> summary(gt(Y~A, Y~A+B+C, data = X))

7

"gt.object" object from package globaltest

Call:
gt(response = Y ~ A, alternative = Y ~ A + B + C, data = X)

Model: linear regression.
Degrees of freedom: 20 total; 2 null; 2 + 3 alternative.
Null distibution: asymptotic.

p-value Statistic Expected Std.dev #Cov
3

42.9

5.56

5.98

1 0.000252

Other functions to extract useful information from a gt.object. For example,

> res <- gt(Y~A, Y~A+B+C, data = X)
> p.value(res)

[1] 0.0002522156

> z.score(res)

[1] 6.249677

> result(res)

p-value Statistic Expected

1 0.0002522156 42.94048 5.555556 5.981898

Std.dev #Cov
3

> size(res)

#Cov
3

The z.score function returns the test statistic standardized by its expectation and
standard deviation under the null hypothesis; result returns a data.frame with the
test result; size returns the number of alternative covariates.

2.1.6 Alternative function calls

The call to gt is quite flexible, and the null and alternative hypotheses can be speci-
fied using either formula objects or design matrices. We illustrate both types of calls,
starting with the formula-based ones.

As the global test always tests nested models, there is no need to repeat the response
and the null covariates when specifying the alternative model, so we may abbreviate
the call of the previous section by specifying only those alternative covariates that do
not already appear in the null model. Therefore,

> gt(Y~A, ~B+C, data = X)

8

also tests the null hypothesis Y ~ A versus the alternative Y ~ A + B + C.

If only a single model is specified, gt will test a null model with only an inter-
cept against the specified model. So, to test the null hypothesis Y ~ 1 against the
alternative Y ~ A + B + C, we may write

> gt(Y~A+B+C, data = X)

p-value Statistic Expected Std.dev #Cov
3

5.26

50.3

5.12

1 2.29e-06

The dot (.) argument for formula objects can often be useful. To test Y ~ A

against the global alternative that all covariates are associated with Y, we can test

> gt(Y~A, ~., data = X)

p-value Statistic Expected Std.dev #Cov
10

1 0.00454

2.97

5.56

16

Using the information from the column names in the data argument, the ~. argument is
automatically expanded to ~ A + B + C + D + E + F + G + H + I + J.
In some applications it is more natural to work with design matrices directly, rather
than to specify them through a formula. To perform the test of Y ~ 1 against Y ~ .,
we may write

> gt(Y, X)

p-value Statistic Expected Std.dev #Cov
10

2.79

24.3

5.26

1 7.34e-06

Similarly, the null hypothesis may be specified as a design matrix. The call

> designA <- cbind(1, X[,"A"])
> gt(Y, X, designA)

p-value Statistic Expected Std.dev #Cov
10

1 0.00454

2.97

5.56

16

gives the same result as gt(Y~A, ~., data = X), except for the #Cov output:
the function cannot detect that some of the null covariates are also present in the al-
ternative design matrix, only that the latter contains exactly correlated ones. Note that
when specified in this way the null design matrix must be a complete design matrix,
i.e. with any intercept term included in the matrix.

2.1.7 Models

The gt function can work with the following models: linear regression, logistic regres-
sion and multinomial logistic regression, poisson regression and the Cox proportional
hazards model. The model to be used can be specified by the model argument.

9

> P <- rpois(20, lambda=2)
> gt(P~A, ~., data=X, model = "Poisson")

p-value Statistic Expected Std.dev #Cov
10

6.07

0.72

4.23

2.99

1

> gt(P~A, ~., data=X, model = "linear")

p-value Statistic Expected Std.dev #Cov
10

0.814

5.56

3.09

2.97

1

If the null model has no covariates (i.e. ~0 or ~1), the logistic and Poisson model

results are identical to the linear model results.

If missing, the function will try to determine the model from the input.

If the
response is a factor with two levels or a logical, it uses a logistic model; if a factor with
more than two levels, a multinomial logistic model; if the response is a Surv object, it
uses a Cox model (for examples, see Section 3.6). In all other cases the default is linear
regression.

Use summary to check which model was used.

2.1.8 Stratified Cox model and competing risks survival analysis

When applying the gt for the Cox proportional hazards model, the user may also
specify strata. For this purpose, the null hypothesis should be given as a formula object.
The strata can then be specified as in the package survival. We first simulate some
survival data via

> time <- rexp(20,1/100)
> status <- rbinom(20,1,0.5)
> str <- rbinom(20,1,0.5)

To test the alternative Surv(time,status) ~ A + B + strata(str)
against the null hypothesis Surv(time,status) ~ strata(str), one can use
the call

> gt(Surv(time,status), ~A+B+strata(str), ~strata(str), data=X)

p-value Statistic Expected Std.dev #Cov
2

0.57

4.21

4.49

5

1

As already described above, one could also use the shorter call:

> gt(Surv(time,status), ~A+B, ~strata(str), data=X)

p-value Statistic Expected Std.dev #Cov
2

0.57

4.21

4.49

5

1

10

we do not support

All strata terms must be both part of alternative and the null hypothesis,
the possibility of testing the alternative alternative
the null hypothesis

e.g.
Surv(time,status) ~ A + B + strata(C) against
Surv(time,status) ~ A + B.

In case that a strata term is only specified in the alternative, a warning is printed

and the corresponding strata term is ignored.

The gt function for the stratified Cox model can also be used to apply the global
test for the cause-specific hazards model. Let us assume, that there are two different
event types indicated by the values 1 and 2 in the status variable:

> status <- status * (rbinom(20,1,0.5) + 1)

Using the mstate package, we first transform the variables into long format with

event type-specific covariates:

> library(mstate)
> survdat <- data.frame(X, "time.01" = time, "time.02" = time,
+
+
> survdat <- msprep(time = c(NA, "time.01","time.02"),
+
+
+
> survdat <- expand.covs(survdat, c("A","B"))

status = c(NA, 'status.01','status.02'),
data = survdat, trans = trans.comprisk(2),
keep=c("A","B"))

"status.01" = ifelse(status == 1, 1, 0),
"status.02" = ifelse(status == 2, 1, 0))

Now testing the alternative Surv(time,status) ~ A + B against the null
hypothesis Surv(time,status) ~ 1 in the cause-specific hazards model with
event types 1 and 2 can e.g. be performed using

> gt(Surv(time,status), ~A.1+B.1+A.2+B.2, ~strata(trans), data=survdat)

p-value Statistic Expected Std.dev #Cov
4

0.761

1.74

1.07

2.5

1

2.1.9 Null distribution: asymptotic or permutations

By default the global test uses an analytic null distribution to calculate the p-values of
the test. This analytic distribution is exact in case of the linear model with normally
distributed errors, and asymptotic in all other models. The distribution that is used
is described in Goeman et al. (2011) for linear and generalized linear models, and
in Goeman et al. (2005) for the Cox proportional hazards model. The assumption
underlying the asymptotic distribution is that the sample size is (much) larger than the
number of covariates of the null hypothesis; the dimensionality of the alternative is not
an issue.

For the linear, logistic and poisson models, the reported p-values are numerically
reliable up to at least two decimal places down to values of around 10−12. Reported
lower p-values are less reliable (although they can be trusted to be below 10−12).

11

In situations in which the assumptions underlying the asymptotics are questionable,
or in which an exact alpha level of the test is necessary, it is possible to calculate the p-
value using permutations instead. Because permutations require an exchangeable null
hypothesis, such a permutation p-value is only available for the linear model and for
the exchangeable null hypotheses ~1 and ~0 in other models.

To calculate permutation p-values, specify the number of permutations with the
permutations argument. The default, permutations = 0, selects the asymptotic
distribution. If the number of permutations specified in permutations is larger than the
total number of possible permutations, all possible permutations are used; otherwise
the function draws permutations at random. Use summary to see which variant was
actually used.
Compare

> gt(Y,X)

p-value Statistic Expected Std.dev #Cov
10

2.79

5.26

24.3

1 7.34e-06

> gt(Y,X, permutations=1e4)

p-value Statistic Expected Std.dev #Cov
10

1e-04

2.73

24.3

5.25

1

The distribution of the permuted test statistic can be visualized using the hist

function.

2.1.10

Intercept terms

If null is given as a formula object, intercept terms are automatically included in the
model unless this term is explicitly removed with ~0+... or ~...-1, as is usual
in formula objects. This automatic addition of an intercept does not happen if null is
specified as a design matrix. Therefore, the calls

> A <- X[,"A"]
> gt(Y,X,A)

p-value Statistic Expected Std.dev #Cov
10

1 0.00531

2.87

5.26

15.2

> gt(Y,X,~A)

p-value Statistic Expected Std.dev #Cov
10

1 0.00454

2.97

5.56

16

test different null hypotheses: Y ~ 1 + A and Y ~ 0 + A, respectively.

In contrast, in the alternative model the intercept term is always suppressed, even if
alternative is a formula and an intercept is not present in the null model. If a user wants
to include an intercept term in the alternative model but not in the null model, he must

12

> hist(gt(Y,X, permutations=1e4))

explicitly construct an intercept variable. The reason for this is that the test result is not
invariant to the scaling of variables in the alternative, and therefore also not invariant to
relative scaling of the intercept to the other variables. The user must therefore choose
and construct an appropriately scaled intercept. The call

> gt(Y~0+A, ~ B+C, data = X)

p-value Statistic Expected Std.dev #Cov
2

1 0.00014

5.26

43.8

5.72

suppresses the intercept both in null and alternative hypotheses. To include an intercept
in the alternative, we must say something like

> IC <- rep(1, 20)
> gt(Y~0+A, ~ IC+B+C, data = X)

p-value Statistic Expected Std.dev #Cov
3

32.9

4.59

5.26

1 0.000228

Note that setting IC <- rep(2, 20) gives a different result.

13

Permutation test statisticsFrequency0510152025050010001500Observedteststatistic2.1.11 Covariates of class factor

Another consequence of the fact that the global test is not invariant to the parametriza-
tion of the alternative model is that one must carefully consider the choice of contrasts
for factor covariates. We distinguish nominal (unordered) factors and ordinal (ordered)
factors.

The usual coding of nominal factors with a reference category and dummy vari-
ables that describe the difference between each category and the reference is usually
not appropriate for global test, as this parametrization (and therefore the test result)
depends on the choice of the reference category, which is often arbitrary. More ap-
propriate is to do a symmetric parametrization with a dummy for each category. This
works even if multiple factors are considered, because the global test is not adversely
affected by overparametrization. If gt was called with the argument x set to TRUE, we
can use model.matrix on the gt.object to check the design matrix.

> set.seed(1234)
> YY <- rnorm(6)
> FF <- factor(rep(letters[1:2], 3))
> GG <- factor(rep(letters[3:5], 2))
> model.matrix(gt(YY ~ FF + GG, x = TRUE))$alternative

FFa FFb GGc GGd GGe
0
0
1
0
0
1

0
1
0
0
1
0

1
0
1
0
1
0

0
1
0
1
0
1

1
0
0
1
0
0

1
2
3
4
5
6

This choice of contrasts guarantees that the test result does not depend on the order of
the levels of any factors.

For ordered factors it is often reasonable to make contrasts between adjacent cate-
gories. In a model without an intercept term the frequently used split coding scheme
allows the parameters βi to be interpreted as the increases in the transition from cate-
gory i−1 to category i, which is intuitively appropriate for ordinal data. In our example
this yields

> GG <- ordered(GG)
> model.matrix(gt(YY ~ GG, x = TRUE))$alternative

GGc GGd GGe
0
0
1
0
0
1

1
1
1
1
1
1

0
1
1
0
1
1

1
2
3
4
5
6

14

If now an intercept term is included in null (i.e.

if it is not explicitly removed),
this choice of contrasts is equivalent to taking an arbitrary category to be the reference
category and, starting from that, assuming that the effects of categories further apart
are more diverse than the effects of categories close-by. More explicitly, choosing the
first, second, and third category as reference theoretically would result in the design
matrices

> R1 <- matrix(c(0,1,1,0,1,1,0,0,1,0,0,1),6,2,dimnames=list(1:6,c("GGd","GGe")))
> R2 <- matrix(c(-1,0,0,-1,0,0,0,0,1,0,0,1),6,2,dimnames=list(1:6,c("GGc","GGe")))
> R3 <- matrix(c(-1,0,0,-1,0,0,-1,-1,0,-1,-1,0),6,2,dimnames=list(1:6,c("GGc","GGd")))

It can be shown that the global test statistic — and hence the test result — is invari-
ant to the choice of the reference category. In the gt function we can check this easily
with

> gt(YY ~ GG)

p-value Statistic Expected Std.dev #Cov
3

1 0.0149

18.4

61.9

20

> gt(YY, alternative=R1)

p-value Statistic Expected Std.dev #Cov
2

1 0.0149

18.4

61.9

20

The same results are obtained for R2 and R3, respectively. The choice of contrasts
therefore guarantees that, in a model with an intercept term, the test result does not
depend on the choice of the reference category. The difference in the number of co-
variates included in the alternative (3 vs. 2 in the above outputs) is due to the additional
vector of ones in the split coding which, however, does not have any effect on the test
result. (Strictly speaking, the effective number of covariates included in the alterna-
tive is the number given by the output minus the number of ordinal factors.) Note that
otherwise, if the intercept term is removed from null, the test result will depend on the
choice of the reference category, which may not be desirable. The used implementation
protects us from such situations and, most notably, leads to more interpretable results
if an intercept is excluded from the null model. If a user nevertheless wants to test such
alternatives that do depend on the choice of the reference category, he must explicitly
specify a corresponding design matrix in alternative (such as R1, R2, and R3 from
above). This, for example, gives

> gt(YY, alternative=R1, null=~0)

p-value Statistic Expected Std.dev #Cov
2

0.401

16.7

18.4

15

1

In contrast, the variant that gt is based on leads to

> gt(YY ~ GG, null=~0)

p-value Statistic Expected Std.dev #Cov
3

0.575

16.7

9.04

17.6

1

15

2.1.12 Directing the test: weights

The global test assigns relative weights to each covariate in the alternative which deter-
mine the contribution of each covariate to the test result. The default weighting, which
follows from the theory of the test (Goeman et al., 2006), is proportional to the residual
variance of each of the covariates, after orthogonalizing them with respect to the null
covariates. The weights that gt uses internally can be retrieved with the weights
function.

> res <- gt(Y, X)
> weights(res)

H
0.6462082 1.0000000 0.8522877 0.4298123 0.3435935 0.2312562 0.7261093 0.4916427

B

G

A

C

E

D

F

J
0.4260604 0.6629415

I

Only the ratios between weights are relevant. The weights that are returned are scaled
so that the maximum weight is 1.

In some applications the default weighting is not appropriate, for example if the
covariates are all measured in different units and the relative scaling of the units is
arbitrary. In that case it is better to standardize all covariates to unit standard deviation
before performing the test. This can be done using the standardize argument.

> res <- gt(Y,X, standardize=TRUE)
> weights(res)

A B C D E F G H I J
1 1 1 1 1 1 1 1 1 1

Alternatively, the function can work with user-specified weights, given in the
weights argument. These weights are multiplied with the default weights, unless the
standardize argument is set to TRUE. The following two calls give the same test result.

> gt(Y, X[,c("A","A","B")], weights=c(.5,.5,1))
> gt(Y, X[,c("A","B")])

2.1.13 Directing the test: directional

The power of the global test does not depend on the sign of the true regression coeffi-
cients. However, in some applications the regression coefficients of different covariates
are a priori expected to have the same sign. Using the directional argument The test can
be directed to be more powerful against the alternative that the regression coefficients
under the alternative all have the same sign.

> gt(Y, X, directional = TRUE)

p-value Statistic Expected Std.dev #Cov
10

1 0.00156

5.26

31.3

5

16

In the hierarchical model formulation of the test,

this is achieved by mak-
ing the random regression coefficients a priori positively correlated. The default,
directional = TRUE, corresponds to an a priori correlation between regression
coefficients of (cid:112)1/2. If desired, the directional argument can be set to a value other
than TRUE. Setting directional to a value of d corresponds to an a priori correlation of
(cid:112)d/(1 + d).

If some covariates are a priori expected to have regression coefficients with opposite

signs, the corresponding covariates can be given negative weights.

2.1.14 Offset terms and testing values other than zero

By default, the global test tests the null hypothesis that all regression coefficients of the
covariates of the alternative hypothesis are all zero. It is also possible to test the null
hypothesis that these covariates have a different value than zero, specified by the user.
This can be done using the test.value argument.

> gt(Y~A+B+C,data=X, test.value=c(.2,.2,.2))

p-value Statistic Expected Std.dev #Cov
3

0.156

5.12

9.33

5.26

1

The test.value argument is always applied to the original alternative design matrix, i.e.
before any standardization or weighting.

Specifying test.value in this way is equivalent to adding an offset term to the
null hypothesis of Xv, where X is the design matrix of the alternative hypothesis and
v is the specified test.value.

> os <- X[,1:3]%*%c(.2,.2,.2)
> gt(Y~offset(os), ~A+B+C, data=X)

p-value Statistic Expected Std.dev #Cov
3

0.156

5.26

9.33

5.12

1

Offset terms are not implemented for the multinomial logistic model.

2.2 Diagnostic plots

Aside from the permutations histogram already mentioned in Section 2.1.9, there are
two main diagnostic plots that can help users to interpret a test result. Both plots are
based on a decomposition of the test result into component test statistics that only use
part of the information that the full test uses.

2.2.1 The covariates plot

As shown in Goeman et al. (2004), the global test statistic on a collection of alterna-
tive covariates can be seen as a weighted average of the global test statistics for each
individual alternative covariate.

17

> gt(Y~A+B, data=X)

p-value Statistic Expected Std.dev #Cov
2

58.4

5.26

5.58

1 2.05e-07

> gt(Y~A, data=X)

p-value Statistic Expected Std.dev #Cov
1

0.002

5.26

7.24

42

1

> gt(Y~B, data=X)

p-value Statistic Expected Std.dev #Cov
1

5.26

7.24

1 5.72e-06

69

The test statistic of the test against ~A+B is between the test statistics against the alter-
natives ~A and ~B, even though the cumulative evidence of A and B may make the p-
value of the combined test smaller than that of each individual one. This is because the
global test statistic for an alternative hypothesis is always a weighted average of the test
statistics for tests of the component single covariate alternatives. The covariates
plot is based on this decomposition of the test statistic into the contributions made by
each of the covariates in the alternative hypothesis.

The contribution of each such covariate is itself a test. It can be useful to make a
plot of these test results to find those covariates or groups of covariates that contribute
most to a significant test result.

The covariates plot by default plots the p-values of the tests of individual com-
ponent covariates of the alternative. Other characteristic values of the component tests
may be plotted using the what argument: specifying what = "z" plots standard-
ized test statistics (compare the z.score method for gt.object objects); specifying
what = "s" gives the unstandardized test statistics and what = "w" give the un-
standardized test statistics weighted for the relative weights of the covariates in the test
(compare the weights method for gt.object objects). If (weighted or unweighted) test
statistics are plotted, bars and stripes appear to signify mean and standard deviation of
the bars under the null hypothesis.

The plotted covariates are ordered in a hierarchical clustering graph. The distance
measure used for the graph is absolute correlation distance if the directional argument
of gt was FALSE (the default), or correlation distance otherwise. (Absolute) corre-
lation distance is appropriate here because the test results for the individual covariates
can be expected to be similar if the covariates are strongly correlated, and because the
sign of the correlation matters only if a directional test was used. The default clustering
method is average linkage. This can be changed if desired, using the cluster argument.
Clustering can also be turned off by setting cluster = FALSE.

The hierarchical clustering graph induces a collection of subsets of the tested co-
variates between the full set that is the top of the clustering graph and the single covari-
ates that are the leaves. There are 2k − 1 such sets for a graph with k leave nodes, in-
cluding top and leaves. It is possible to do a multiple testing procedure on all 2k−1 sets,
controlling the family-wise error rate while taking the structure of the graph into ac-
count. The covariates function performs such a procedure, called the inheritance

18

> covariates(gt(Y,X))

procedure, which is an adaptation of the method of Meinshausen (2008): see Section
2.3.4. By coloring the part of the clustering graph that has a significant multiplicity-
corrected p-value in black, the user can get an impression what covariates and clusters
of covariates are most clearly associated with the response variable. The significance
threshold at which a multiplicity-corrected p-value is called significant can be adjusted
with the alpha argument (default 0.05). In some situations the significant branches do
not reach all the way to the leaf nodes. The interpretation of this is that the multiple
testing procedure can infer with confidence that at least one of the covariates below
the last significant branch is associated with the response, but it cannot pinpoint with
enough confidence which one(s).

The result of the covariates function can be stored to access the information in the
graph. The covariates function returns a gt.object containing all tests on all subsets
induced by the clustering graph, with their familywise error adjusted p-values.

> res <- covariates(gt(Y,X))
> res[1:10]

alias inheritance

O
O[1

7.34e-06 7.34e-06
7.34e-06 4.94e-06

p-value Statistic Expected Std.dev #Cov
10
7

24.33
30.56

2.79
3.44

5.26
5.26

19

abs. correlation10.80.60.40.2BCIGADHFEJp−value10.10.010.0011e−041e−05pos. assoc. with Yneg. assoc. with Y> covariates(gt(Y,X), what="w")

O[1[1
O[1[1[1
O[1[1[1[1:B
O[1[1[1[2
O[1[1[1[2[1:C
O[1[1[1[2[2:I
O[1[1[2:G
O[1[2

9.29e-05 5.19e-05
1.34e-04 6.02e-05
1.34e-04 5.72e-06
4.41e-02 1.36e-02
4.41e-02 6.47e-03
1.00e+00 2.62e-01
1.00e+00 2.70e-01
2.34e-02 7.62e-03

B

C
I
G

35.37
44.50
69.04
25.31
34.49
6.93
6.70
21.36

5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26

4.46
5.37
7.24
6.11
7.24
7.24
7.24
4.56

4
3
1
2
1
1
1
3

The names of the subsets should be read as follows. “O” refers to the origin or root,
and each “[1” refers to a first (or left) branch, whereas each “[2” refers to a second
(or right) branch. Leaf nodes are also referred to by name. To get the leaf nodes of
the subgraph that is significant after multiple testing correction, use the leafNodes
function

> leafNodes(res, alpha=0.10)

alias inheritance

O[1[1[1[1:B
O[1[1[1[2[1:C
O[1[2[1:A

B
C
A

0.000134 5.72e-06
0.044144 6.47e-03
0.023377 2.00e-03

p-value Statistic Expected Std.dev #Cov
1
1
1

7.24
7.24
7.24

69.0
34.5
42.0

5.26
5.26
5.26

20

abs. correlation10.80.60.40.2BCIGADHFEJweighted test statistic0102030405060pos. assoc. with Yneg. assoc. with YTo get a nice table of only the information of the single covariates, including their
direction of association, use the extract function.

> extract(res)

alias inheritance

direction

B
C
I
G
A
D
H
F
E
J

B
C
I
G
A
D
H
F
E
J

0.000134 pos. assoc. with Y 5.72e-06
0.044144 pos. assoc. with Y 6.47e-03
1.000000 neg. assoc. with Y 2.62e-01
1.000000 pos. assoc. with Y 2.70e-01
0.023377 pos. assoc. with Y 2.00e-03
0.982986 neg. assoc. with Y 1.07e-01
1.000000 pos. assoc. with Y 6.92e-01
1.000000 pos. assoc. with Y 3.51e-01
1.000000 neg. assoc. with Y 8.30e-01
1.000000 neg. assoc. with Y 7.51e-01

p-value Statistic Expected Std.dev #Cov
1
1
1
1
1
1
1
1
1
1

69.036
34.494
6.931
6.704
41.998
13.754
0.895
4.856
0.263
0.573

5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26

7.24
7.24
7.24
7.24
7.24
7.24
7.24
7.24
7.24
7.24

The function covariates tries to sort the bars in such a way that the most sig-
nificant covariates appear on the left. This sorting is, of course, constrained by the
dendrogram if present. Setting the sort argument to FALSE to keep the bars in the
original order as much as possible under the same constraints.

An additional option zoom is available that “zooms in” on the significant branches
by discarding the non-significant ones. If the whole graph is non-significant zoom has
no effect.

The default colors, legend and labels in the plot can be adjusted with the colors,

legend and alias arguments.

The covariates returns the test results for all tests it performs, invisibly, as a
gt.object. The leafNodes function can be used to extract useful information from
this object. Using leafNodes with the same value of alpha that was used in the
covariates function, extracts the test results for the leaves of the significant subgraph.
Using alpha = 1 extracts the test results for leaves of the full graph, i.e. for the
individual covariates.

By default, the covariates function can only make a plot for a single test result,
even if the gt.object contains multiple test results (see Section 2.3.1). However, by
providing a filename in the pdf argument of the covariates function it is possible
to make multiple plots, writing them to a pdf file as separate pages.

Those who like a more machine-learning oriented terminology can use the

features function, which is identical to covariates in all respects.

2.2.2 The subjects plot

Alternatively, it is possible to visualize the influence of the subjects, rather than of the
covariates, on the test result. This can be useful in order to look for subjects that have
an overly large influence on the test result, of to find subjects that deviate from the main
pattern.

Visualizing the test result in terms of the contributions of the subjects can be done
using a different decomposition of the test result. In the linear model the test statistic

21

> covariates(gt(Y,X), zoom=TRUE)

Q can be viewed as a weighted sum of the quantities

Qi = sign(Yi − µi)

n
(cid:88)

p
(cid:88)

j=1

k=1

XikXjk(Yj − µj),

(cid:80)p

where Yi is the response variable of subject i, µi that person’s expected response under
the null hypothesis, and X the design matrix of the alternative. We subtract ˆE(Qi) =
sign(Yi − µi) (cid:80)p
k=1 XikXik(Yi − µi) as a crude estimate of the expectation of Qi.
An estimate of the variance of Qi is Var{Qi − ˆE(Qi)} = σ2 (cid:80)n
ikX 2
jk.
The quantities are asymptotically normally distributed. A similar decomposition can
be made for the test statistic in other models than the linear one.

k=1 X 2

The resulting quantity Qi − ˆE(Qi) can be interpreted as the contribution of the i-th
subject to the test statistic in the sense that it is proportional to the difference between
the test statistic for the full sample and the test statistic of a reduced sample in which
subject i has been removed. It can also be interpreted as an alternative test statistic
for the same null hypothesis as the global test, but one which uses only part of the
information that the full global test uses.

The contribution Qi− ˆE(Qi) of individual i takes a large value if other subjects who
are similar to subject i in terms of their covariates X (measured in correlation distance)
also tend to be similar in terms of their residual Yj − µj (i.e. has the same sign). This

j=1

22

abs. correlation10.80.60.40.2BCAp−value10.10.010.0011e−041e−051e−06pos. assoc. with Yneg. assoc. with Ycontribution Qi − ˆE(Qi) can, therefore, be viewed as a partial global test statistic
that rejects if individuals that are similar to individual i in terms of their alternative
covariates tend to deviate from the null model in the same direction as individual i with
their response variable.

The subjects function plots the p-values of these partial test statistics. As in
the covariates function, other values may be plotted using the what argument.
Specifying what = "z" plots test statistics standardized by their expectation and
standard deviation; specifying what = "s" gives the unstandardized test statistics
Qi and what = "w" give the unstandardized test statistics weighted for the relative
weights of the subjects in the test (proportional to |Yi|). If weighted or unweighted
standardized test statistics are plotted, bars and stripes appear to signify mean and
standard deviation of the bars under the null hypothesis.

> subjects(gt(Y,X))

j=1

(cid:80)p

An additional argument mirror (default: TRUE) can be used to plot the unsigned
version ¯Qi = (cid:80)n
k=1 XikXjk(Yj − µj) (no effect if what = "p"). Combined
with what = "s", this gives the first partial least squares component of the data,
which can be interpreted as a first order approximation of the estimated linear predictor
under the alternative. In the resulting plot, large positive values correspond to subjects
that have a much higher predicted value under the alternative hypotheses than under the
null, whereas large negative values correspond to subjects with a much lower expected

23

correlation10.80.60.40.20−0.21119184891011516631412513201727p−value10.30.10.030.010.0030.0013e−04pos. residual Yneg. residual Yvalue under the alternative than under the null.

> subjects(gt(Y,X), what="s", mirror=FALSE)

As in the covariates plot, the subjects in the subjects plot are ordered in
a hierarchical clustering graph. The distance measure used for the clustering graph
is correlation distance. Correlation distance is appropriate because the test results for
subjects can be expected to be similar if their measurements are close in terms of corre-
lation distance. The default clustering method is average linkage. This can be changed
if desired, using the cluster argument. Clustering can also be turned off by setting
cluster = FALSE. Unlike in the covariates plot, no multiple testing is done
on the clustering graph.

The function tries to sort the bars in such a way that the most significant partial
tests appear on the left. This sorting is, of course, constrained by the dendrogram if
present. Setting the sort argument to FALSE to keep the bars in the original order as
much as possible under the same constraints.

The default colors, legend and labels in the plot can be adjusted with the colors,

legend and alias arguments.

By default, the subjects function can only make a plot for a single test result,
even if the gt.object contains multiple test results (see Section 2.3.1). However, by
providing a filename in the pdf argument of the subjects function it is possible to
make multiple plots, writing them to a pdf file as separate pages.

24

correlation10.80.60.40.20−0.21119184810911516201727512141336posterior effect−15−10−505pos. residual Yneg. residual Y2.3 Doing many tests: multiple testing

In high-dimensional data, when the dimensionality of the design matrix of the alterna-
tive is very high, it is often interesting to study subsets of the covariates, or to compare
alternative weighting options. The globaltest package facilitates this by making it pos-
sible to perform tests for many alternatives at once, and to perform various algorithms
for multiple testing correction.

2.3.1 Many subsets or many weights

To test one or many subsets covariates of the alternative design matrix, use the subsets
argument. If a single subset is to be tested, the subsets argument can be presented as a
vector of covariate names or of covariate indices in the alternative design matrix.

> set <- LETTERS[1:3]
> gt(Y,X, subsets = set)

p-value Statistic Expected Std.dev #Cov
3

5.12

5.26

50.3

1 2.29e-06

To test many subsets, subsets can be a (named) list of such vectors.

> sets <- list(one=LETTERS[1:3], two=LETTERS[4:6])
> gt(Y,X, subsets = sets)

p-value Statistic Expected Std.dev #Cov
3
3

50.26
7.09

one 2.29e-06
two 2.63e-01

5.26
5.26

5.12
4.23

Duplicate identifiers in the subset vectors are not removed, but lead to increased weight
for the duplicated covariates in the resulting test, except if the trim option was set to
TRUE (see Section 3.2.3).

To retrieve the subsets from a gt.object, use the subsets method.

> res <- gt(Y,X, subsets = sets)
> subsets(res)

$one
[1] "A" "B" "C"

$two
[1] "D" "E" "F"

Weighting was already discussed in Section 2.1.12. To test many different weights
simultaneously, the weights argument can also be given as a (named) list, similar to the
subsets argument.

> wts <- list(up = 1:10, down = 10:1)
> gt(Y,X,weights=wts)

25

up
1.83e-02
down 1.51e-06

p-value Statistic Expected Std.dev #Cov
10
10

2.73
3.50

11.9
35.0

5.26
5.26

Weights can also be used as an alternative way of specifying subsets, by giving weight
1 to included covariates and 0 to others.

Weights and subsets can also be combined. Either specify a single weights vector

for many subsets

> gt(Y,X, subsets=sets, weights=1:10)

p-value Statistic Expected Std.dev #Cov
3
3

48.70
6.39

one 2.02e-05
two 3.12e-01

5.47
4.17

5.26
5.26

or specify a separate weights vector for each subset. In the latter case case each weights
vector may be either a vector of the same length as the number of covariates in the
alternative design matrix, or, alternatively, be equal in length to corresponding subset.

> gt(Y,X, subsets=sets, weights=wts)

alias p-value Statistic Expected Std.dev #Cov
3
3

up 2.02e-05
one
two down 2.30e-01

48.70
7.63

5.47
4.36

5.26
5.26

> gt(Y,X, subsets=sets, weights=list(1:3,7:5))

p-value Statistic Expected Std.dev #Cov
3
3

48.70
7.63

one 2.02e-05
two 2.30e-01

5.47
4.36

5.26
5.26

Note that in case of a name conflict between the subsets and weights arguments,
the names of the weights argument are returned under “alias”. In general, the alias is
meant to store additional information on each test performed. Unlike the name, the
alias does not have to be unique. An alias for the test result may be provided with the
alias argument, or added or changed later using the alias method.

> res <- gt(Y,X, weights=wts, alias = c("one", "two"))
> alias(res)

[1] "one" "two"

> alias(res) <- c("ONE", "TWO")

To take a subset of the test results, a gt.object can be subsetted using [ or [[
as with other R objects. There is no distinction between [ or [[. A gt.object
can be sorted to increasing p-values with the sort command.
In case of equal p-
values, which may happen e.g. when doing permutation testing, the tests with the same
p-values are sorted to decreasing z-scores.

26

> res[1]

alias p-value Statistic Expected Std.dev #Cov
10

ONE 0.0183

11.9

5.26

2.73

1

> sort(res)

alias p-value Statistic Expected Std.dev #Cov
10
10

TWO 1.51e-06
ONE 1.83e-02

5.26
5.26

3.50
2.73

35.0
11.9

2
1

2.3.2 Unstructured multiple testing procedures

When doing many tests, it is important to correct for multiple testing. The globaltest
package offers different methods for correcting for multiple testing. For unstructured
tests in which the tests are simply considered as an exchangeable list with no inherent
structure. These methods are described in the help file of the p.adjust function
(stats package). The three most important ones are

Holm The procedure of Holm (1979) for control of the family-wise error rate

BH The procedure of Benjamini and Hochberg (1995) for control of the false dis-

covery rate

BY The procedure of Benjamini and Yekutieli (2001) for control of the false discov-

ery rate

The procedures of Holm and Benjamini and Yekutieli (2001) are valid for any de-
pendency structure between the null hypotheses, but the procedure of Benjamini and
Hochberg (1995) is only valid for independent or positively correlated test statistics
(see Benjamini and Yekutieli, 2001, for details).

Multiplicity-corrected p-values can be calculated with the p.adjust function.

The default procedure is Holm’s procedure.

> p.adjust(res)

alias

up
down

ONE 1.83e-02 1.83e-02
TWO 3.03e-06 1.51e-06

holm p-value Statistic Expected Std.dev #Cov
10
10

11.9
35.0

2.73
3.50

5.26
5.26

> p.adjust(res, "BH")

alias

ONE 1.83e-02 1.83e-02
TWO 3.03e-06 1.51e-06

BH p-value Statistic Expected Std.dev #Cov
10
10

11.9
35.0

2.73
3.50

5.26
5.26

up
down

> p.adjust(res, "BY")

alias

ONE 2.74e-02 1.83e-02
TWO 4.54e-06 1.51e-06

BY p-value Statistic Expected Std.dev #Cov
10
10

11.9
35.0

2.73
3.50

5.26
5.26

up
down

27

2.3.3 Graph-structured hypotheses 1: the focus level method

Sometimes the sets of covariates that are to be tested are structured in such a way that
some sets are subsets of other sets. Such a structure can be exploited to gain improved
power in a multiple testing procedure. The globaltest package offers two procedures
that make use of the structure of the sets when controlling the familywise error rate.
These procedures are the focus level procedure of Goeman and Mansmann (2008), and
the inheritance procedure, a variant of the procedure of Meinshausen (2008). We treat
both of these methods in turn.

Sets of covariates can be viewed as nodes in a graph, with subset relationships form
the directed edges. Viewed in this way, any collection of covariates forms a directed
acyclic graph. The inheritance procedure is restricted to tree-structured graphs. The
focus level is not so restricted, and can work with any directed acyclic graph.

To illustrate the focus level method, let’s make some covariate sets of interest.

> level1 <- as.list(LETTERS[1:10])
> names(level1) <- letters[1:10]
> level2 <- list(abc = LETTERS[1:3], cde
+
> level3 <- list(all = LETTERS[1:10])
> dag <- c(level1, level2, level3)

fgh = LETTERS[6:8], hij = LETTERS[8:10])

= LETTERS[3:5],

This gives one top node, 10 leaf nodes and 4 intermediate nodes. The structure is
a directed acyclic graph because leaf nodes “C” and “H” both have more than one
parent.

The focus level method requires the choice of a focus level. This is the level in the
graph at which the procedure starts testing. If significant nodes are found at this level,
the procedure will fan out to find significant ancestors and offspring of that significant
node. A focus level can be specified as a character vector of node identifiers, or it can
be generated in an automated way using the findFocus function.

> fl <- names(level2)
> fl <- findFocus(dag, maxsize=8)

The findFocus function chooses the focus level in such a way that each focus level
node has at most maxsize non-redundant offspring nodes, where a redundant node is a
node that can be constructed as a union of other nodes. An optional argument atoms
(default: TRUE) first decomposes all nodes into atoms: small sets from which all off-
spring sets can be reconstructed as unions of atoms. Making use of these atoms often
reduces computation time considerably, although it may, in theory, result in some loss
of power.

To apply the focus level method, first create a gt.object that contains all the covari-
ates under the alternative, e.g. the gt.object that uses the full alternative design matrix.

> res <- gt(Y,X)
> res <- focusLevel(res, sets = dag, focus=fl)
> sort(res)

28

focuslevel p-value Statistic Expected Std.dev #Cov
3
50.260
10
24.327
1
69.036
1
41.998
1
34.494
3
21.776
1
13.754
1
6.931
1
6.704
1
4.856
3
4.438
1
0.895
3
2.387
1
0.573
1
0.263

9.17e-06 2.29e-06
9.17e-06 7.34e-06
6.69e-05 5.72e-06
8.01e-03 2.00e-03
2.59e-02 6.47e-03
2.59e-02 9.15e-03
7.13e-01 1.07e-01
1.00e+00 2.62e-01
1.00e+00 2.70e-01
1.00e+00 3.51e-01
1.00e+00 4.70e-01
1.00e+00 6.92e-01
1.00e+00 7.41e-01
1.00e+00 7.51e-01
1.00e+00 8.30e-01

5.12
2.79
7.24
7.24
7.24
4.77
7.24
7.24
7.24
7.24
4.47
7.24
4.05
7.24
7.24

5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26

abc
all
b
a
c
cde
d
i
g
f
fgh
h
hij
j
e

As the p.adjust function, the focusLevel function reports familywise error rate
adjusted p-values.

It is a property of both the inheritance and the focus level method, that the adjusted
p-value of a node can never be smaller than a p-value of an ancestor node. The signif-
icant graph at a certain significance level is therefore always a coherent graph, which
always contains all ancestor nodes of any rejected node. Such a graph can be succinctly
summarized by reporting only its leaf nodes. This can be done using the leafNodes
function.

> leafNodes(res)

focuslevel p-value Statistic Expected Std.dev #Cov
1
1
1

8.01e-03 2.00e-03
6.69e-05 5.72e-06
2.59e-02 6.47e-03

42.0
69.0
34.5

5.26
5.26
5.26

7.24
7.24
7.24

a
b
c

The alpha argument of the leafNodes function can be used to specify the rejection
threshold for the familywise error of the significant graph.

To visualize the test result as a graph, use the draw. By default, this function draws
the graph with the significant nodes in black and the non-significant ones in gray. The
alpha argument can be used to change the significance threshold. Alternatively, it is
possible to draw only the significant subgraph, setting the sign.only argument to TRUE.
The names argument (default FALSE) forces the use of names in the nodes. This can
quickly become unreadable even for small graphs if the names for the nodes are long.
By default, therefore, draw numbers the nodes, returning a legend to interpret the
numbers.

> legend <- draw(res)

The interactive argument can be used to make the plot interactive. In an interactive
plot, click on a node to see the node label. Exit the interactive plot by pressing escape.

29

> draw(res, names=TRUE)

2.3.4 Graph-structured hypotheses 2: the inheritance method

An alternative method for multiple testing in graph-structured hypotheses is the in-
heritance method. This procedure is based on the work of Meinshausen (2008).
inheritance reports familywise error rate adjusted p-values, as p.adjust and
focusLevel functions do. Compared with the focus level method, the inheritance
procedure is less computationally intensive, and does not require the definition of any
(focus) level. However, it requires that the graph has a tree structure, rather than the
more general directed acyclic graph structure that the focus level works with.

To illustrate the inheritance method, we make use of the example data. However,
we can not make uso of the dag object created in Section 2.3.3 since it does not have
a tree structure. For example, c in dag is a descendant of both abc and cde. We
modify the commands of the previous section to make sure that each element of dag
has (at maximum) one parent; this guarantees that it is a tree-structured graph.

> level1 <- as.list(LETTERS[1:10])
> names(level1) <- letters[1:10]
> level2 <- list(ab = LETTERS[1:2], cde = LETTERS[3:5], fg = LETTERS[6:7], hij = LETTERS[8:10])
> level3 <- list(all = LETTERS[1:10])
> tree <- c(level1, level2, level3)

30

abcdefghijabccdefghhijallNow we can apply the inheritance method. The syntax of the function is very

similar to the focusLevel function.

> res <- gt(Y,X)
> resI <- inheritance(res, tree)
> resI

inheritance p-value Statistic Expected Std.dev #Cov
1
1
1
1
1
1
1
1
1
1
2
3
2
3
10

1.49e-02 2.00e-03
2.95e-05 5.72e-06
2.90e-02 6.47e-03
8.28e-01 1.07e-01
1.00e+00 8.30e-01
1.00e+00 3.51e-01
9.87e-01 2.70e-01
1.00e+00 6.92e-01
1.00e+00 2.62e-01
1.00e+00 7.51e-01
7.34e-06 2.05e-07
2.34e-02 9.15e-03
8.83e-01 2.93e-01
1.00e+00 7.41e-01
7.34e-06 7.34e-06

41.998
69.036
34.494
13.754
0.263
4.856
6.704
0.895
6.931
0.573
58.422
21.776
6.258
2.387
24.327

5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26

7.24
7.24
7.24
7.24
7.24
7.24
7.24
7.24
7.24
7.24
5.58
4.77
5.90
4.05
2.79

a
b
c
d
e
f
g
h
i
j
ab
cde
fg
hij
all

The inheritance procedure has two variants: one with and one without the Shaf-
fer variant (Meinshausen, 2008). Setting the argument Shaffer = TRUE allows
uniform improvement of the power of the procedure, but it the familywise error
rate control is guaranteed only if the hypotheses tested in each node of the graph
with only leaf nodes as offspring is precisely the intersection hypothesis of its child
nodes. When doing the inheritance procedure in combination with the global test,
this condition is fulfilled if the set of covariates at each node with only leaf nodes
as offspring is precisely the union of the sets of covariates of its offspring leaf
nodes. This condition is fulfilled for the tree graph above, but if we had set
level1 <- as.list(LETTERS[19]):, the node hij contains a covariate (J)
that is not present in any of its child nodes, so that the condition for the Shaffer im-
provement is not fulfilled, and setting Shaffer = TRUE does not control the fam-
ilywise error rate. If test is a gt.object the procedure check if structure of sets allows
for a Shaffer improvement, and sets Shaffer to the correct default.
In other cases,
checking the validity of the Shaffer improvement is left to the user. Note that setting
Shaffer = TRUE always gives a correct procedure.

The tree structure of the hypotheses may be fixed a priori, based on the prior knowl-
edge rather than on the data. However, in some situations a data-driven definition of
the structure is allowed. Meinshausen (2008) suggests to use a hierarchical clustering
method using as distance matrix based on the (correlation) distance between explana-
tory covariates. This is valid for the global test, and may in some cases also be valid if
other tests are performed.

31

In inheritance, the tree-structured graph sets can be an object of class hclust
or dendrogram. If sets is missing and test is a gt.object the structure is derived from
the structure of test.

> hc <- hclust(dist(t(X)))
> resHC <- inheritance(res, hc)
> resHC

O[2[2[2[2[2[2:F
O[2[2[1
O
O[2[2[1[1:A
O[1
O[2[2[1[2:H
O[1[1:B
O[2[2[2
O[1[2:C
O[2[2[2[1:J
O[2
O[2[2[2[2
O[2[1
O[2[2[2[2[1:D
O[2[1[1:G
O[2[2[2[2[2
O[2[1[2:I
O[2[2[2[2[2[1:E
O[2[2

inheritance

1.00e+00 3.51e-01
3.65e-02 8.21e-03
7.34e-06 7.34e-06
3.65e-02 2.00e-03
5.03e-05 1.67e-05
1.00e+00 6.92e-01
5.03e-05 5.72e-06
8.46e-01 4.89e-01
3.65e-02 6.47e-03
1.00e+00 7.51e-01
3.65e-02 3.19e-02
8.46e-01 2.63e-01
7.74e-01 2.69e-01
8.46e-01 1.07e-01
9.14e-01 2.70e-01
1.00e+00 6.72e-01
1.00e+00 2.62e-01
1.00e+00 8.30e-01
3.65e-02 2.62e-02

p-value Statistic Expected Std.dev #Cov
1
2
10
1
2
1
1
4
1
1
8
3
2
1
1
2
1
1
6

4.856
24.238
24.327
41.998
53.142
0.895
69.036
4.500
34.494
0.573
10.841
7.092
6.788
13.754
6.704
2.110
6.931
0.263
12.506

5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26
5.26

7.24
5.36
2.79
7.24
5.94
7.24
7.24
3.91
7.24
7.24
2.67
4.23
5.76
7.24
7.24
5.45
7.24
7.24
3.15

It is a property of both the inheritance and the focus level method, that the adjusted
p-value of a node can never be smaller than a p-value of an ancestor node. The signif-
icant graph at a certain significance level is therefore always a coherent graph, which
always contains all ancestor nodes of any rejected node. Such a graph can be succinctly
summarized by reporting only its leaf nodes. This can be done using the leafNodes
function.

> leafNodes(resI)

inheritance p-value Statistic Expected Std.dev #Cov
1
1
1

1.49e-02 2.00e-03
2.95e-05 5.72e-06
2.90e-02 6.47e-03

5.26
5.26
5.26

42.0
69.0
34.5

7.24
7.24
7.24

a
b
c

> leafNodes(resHC)

inheritance

O[2[2[1[1:A
O[1[1:B
O[1[2:C

3.65e-02 2.00e-03
5.03e-05 5.72e-06
3.65e-02 6.47e-03

p-value Statistic Expected Std.dev #Cov
1
1
1

42.0
69.0
34.5

5.26
5.26
5.26

7.24
7.24
7.24

32

The alpha argument of the leafNodes function can be used to specify the rejection
threshold for the familywise error of the significant graph.

Like for focusLevel, the draw can be used to visualize the test result as a
graph: However, in most cases the covariates function does a better graphical

> draw(resHC, names=TRUE)

job. covariates performs hclust on the covariates and calls the inheritance
function using this data-driven structure.

> covariates(res)

33

O[2[2[2[2[2[2:FO[2[2[1OO[2[2[1[1:AO[1O[2[2[1[2:HO[1[1:BO[2[2[2O[1[2:CO[2[2[2[1:JO[2O[2[2[2[2O[2[1O[2[2[2[2[1:DO[2[1[1:GO[2[2[2[2[2O[2[1[2:IO[2[2[2[2[2[1:EO[2[2Chapter 3

Gene Set Testing

3.1 Introduction

One important application of the global test is in gene set testing in gene expression
microarray data (Goeman et al., 2004, 2005). Such data consist of simultaneous gene
expression measurements of many thousands of probes across the genome, performed
for a number of biological samples. The typical goal of a microarray experiment is to
find associations between the expression of genes and a phenotype variable.

Gene set testing is a common denominator for a type of analysis for microarray data
that takes together groups of genes that have a common annotation, e.g. which are all
annotated to the same Gene Ontology term, which are all members of the same KEGG
pathway, or which have a similar chromosomal location. Gene set testing methods test
such gene sets together to investigate whether the genes in the gene set have a higher
association with the response than expected by chance. These methods provide a single
p-value for the gene set, rather than a p-value for each gene.

The global test is well suited for gene set testing; in fact, the global test was initially
designed specifically with this application in mind (Goeman et al., 2004). The model
that the global test uses for gene set testing is a regression model, such as might also
be used to predict the response based on the gene expression measurements: in this
model the gene expression measurements correspond to the covariates and the pheno-
type corresponds to the response. The null hypothesis that the global test tests is the
null hypotheses that all regression coefficients of all the genes in the gene set are zero,
i.e. the genes in the gene set have no predictive ability for predicting the response. The
global test can therefore be seen as a method that looks for differentially expressed
gene sets.

The global test tests gene sets in a single step, based on the full data, without an
intermediate step of finding individual differentially expressed genes. In the classifica-
tion scheme for gene set testing methods of Goeman and Bühlmann (2007), the global
test is a self-contained method rather than a competitive one: it tests the null hypoth-
esis that no gene in the gene set is associated with the phenotype rather than the null
hypothesis that the genes in the gene set are not more associated with the phenotype

34

than random genes on the microarray. The latter approach is followed by enrichment
methods such as GSEA and methods based on Fisher’s exact test. The global test is
also a subject-sampling rather than a gene-sampling method. This means that when
determining whether the genes in the gene set have a higher association with the phe-
notype than expected by chance, the method looks at the random biological variation
between subjects, rather than comparing the gene set with random sets of genes. The
latter approach is used by gene set testing methods based on Fisher’s exact test. Un-
like the validity of gene-sampling methods, the validity of subject-sampling methods
does not depend on the unrealistic assumption that gene expression measurements are
independent.

As shown by Goeman et al. (2006), the global test is designed to have optimal
power in the situation in which the gene set has many small non-zero regression coeffi-
cients. This means that the test is especially directed to find gene sets for which many
genes are associated with the phenotype in a small way. This behavior is appropriate
for gene set testing, because the situation that many genes are associated with the phe-
notype is usually the most interesting from a gene set perspective. Still, it is true that
the null hypotheses that the global test tests is false even if only a single gene in the
gene set is associated with the phenotype; especially smaller gene sets may therefore
become significant as a result of only a single significant gene. However, because the
test is directed especially against the alternative that there are many associated genes,
such examples are rare among larger gene sets.

3.2 Data format

The globaltest package uses the usual statistical orientation of data matrices in which
the columns of the data matrix correspond to covariates, and the rows of the data matrix
correspond to subjects. In gene set testing and in other genomics applications it is more
common to use the reverse orientation, in which the columns of the data matrix corre-
spond to the subjects and the rows to the covariates. The gt.options function can
be used to change the default orientation expected by gt for the alternative argument.

> gt.options(transpose=TRUE)

Note that this option is only relevant if alternative is given as a matrix. A formula
or ExpressionSet input (Section 3.2.1) input for alternative is automatically interpreted
correctly.

3.2.1 Using ExpressionSet data

We illustrate gene set testing using the Golub et al. (1999) data set, a famous data set
which was one of the first to use microarray data in a classification context. This dataset
is available from bioconductor as the golubEsets package. We load the Golub_Train
data set, consisting of 38 Leukemia patients for which 7129 gene expression measure-
ments were taken.

> library(golubEsets)
> data(Golub_Train)

35

The Golub_Train data are in ExpressionSet format, which is the standard format in
bioconductor for storing gene expression data. The ExpressionSet objects contain the
gene expression data, phenotypic data, and annotation information about the genes and
the experiment, all in the same R object. The data have to be properly normalized and
log- or otherwise transformed, as usual in microarray data. We keep the normalization
simple and use only vsn.

> library(vsn)
> exprs(Golub_Train) <- exprs(vsn2(Golub_Train))

The phenotype of interest is the leukemia subtype, coded as the variable ALL.AML,
with values "ALL" and "AML", in pData(Golub_Train). It is generally a good
idea to start by testing the overall expression profile to see whether that is notably dif-
ferent between AML and ALL patients. We supply the ExpressionSet Golub_Train
in the alternative argument of gt. Because the alternative argument is of class Ex-
pressionSet, the function now uses t(exprs(Golub_Train)) as the alternative
argument and pData(Golub_Train) as the data argument.

> gt(ALL.AML, Golub_Train)

p-value Statistic Expected Std.dev #Cov
0.581 7129

10.1

1 1.77e-11

2.7

From the test result we conclude that the overall expression profile of ALL patients and
AML patients differs markedly in this experiment. This is not very surprising, as this
data set has been used in many papers as an example of a data set that can be classified
very easily. From this result we may expect to find many genes and gene sets to be
differentially expressed.

If the overall test is not significant or only marginally significant, it can be difficult
to find many genes or pathways that are differentially expressed.
In this case it is
usually not a good idea to perform a broad untargeted data mining type analysis of the
data, e.g. by testing complete pathway databases, because it is likely that in this case
the signal of the genes and gene sets that are differentially expressed is drowned in
the noise of the genes that are not differentially expressed. A more targeted approach
focussed on a limited number of candidate gene sets may be more opportune in such a
situation.

Adjustment of the test result for confounders such as batch effects, clinical or phe-
notype covariates can be specified by specifying these variables as covariates under
the null hypothesis, as described in Section 2.1.3. When using ExpressionSet data, the
easiest way to do this is with a formula. The terms of such a formula are automat-
ically interpreted in terms of the pData slot of the ExpressionSet. Missing data ar
not allowed in phenotype variables, so we illustrate the adjustment for confounders by
correcting for the data source in the Golub data (the DFCI and CALGB centers)

> gt(ALL.AML ~ Source, Golub_Train)

p-value Statistic Expected Std.dev #Cov
0.517 7129

1 -2.85e-15

2.78

1

36

In this specific case we see that the association between gene expression and disease
subtype is completely confounded by the source variable. In fact, all ALL patients
came from DFCI, and all AML patients from CALGB. In this case we cannot distin-
guish between the effects of disease subtype from the center effects: the design of this
study is, unfortunately, broken.

3.2.2 Other input formats

Alternatively, the formula or matrix-based input described in Section 2.1 may also be
used instead of the ExpressionSet-based one. For matrix-based input, gt expects the
usual statistical data-format in which the subjects correspond to the rows of the data
matrix and the covariates (probes or genes) are the columns. The option transpose in
gt.options can be used to change this. Setting

> gt.options(transpose=TRUE)

changes the default behavior of gt to expect the transposed format that is usual in
genomics, with the rows of the data matrix corresponding to the genes and the columns
to the subjects.

The gtKEGG, gtGO and gtBroad functions (Section 3.3) always expect the ge-

nomics data format rather than the usual statistical format.

3.2.3 The trim option

A second useful option to set when doing gene set testing is the trim option. This option
governs the way gt handles covariate names that appear in the subsets argument, but
are not present in the expression data matrix. The default behavior of gt is to return an
error when this happens. However, in gene set testing covariates may easily be missing
from the expression data, for example because the subsets are based on the annotation
of the complete microarray, while some genes have been removed from the expression
data matrix, perhaps due to poor measurement quality. Setting

> gt.options(trim=TRUE)

makes gt silently remove such missing covariates from the subsets argument.

Additionally, if trim = TRUE, duplicate covariate names in subsets are automat-

ically removed.

3.3 Testing gene set databases

The most common approach to gene set testing is to test gene sets from public
databases. The globaltest package provides utility functions for three such databases:
Gene Ontology, KEGG and the pathway databases maintained by the Broad Institute.
In all cases, these functions make heavy use of the annotation packages available in
Bioconductor. If the microarray that was used does not have an annotation package,
the Entrez-based organism annotation packages (e.g. org.Hs.eg.db for human) can be
used instead.

37

3.3.1 KEGG

The functions gtKEGG can be used to test KEGG terms. To test a single KEGG id,
e.g. cell cycle (KEGG id 04110), use

> gtKEGG(ALL.AML, Golub_Train, id = "04110")

04110 Cell cycle 4.59e-08

alias p-value Statistic Expected Std.dev #Cov
111

0.874

12.1

2.7

The function automatically finds the right KEGG information from the KEGGREST
package, and the right set of genes belonging to the KEGG id from the annotation
package of the hu6800 Affymetrix chip; the reference to this annotation package is
contained in the Golub_Train ExpressionSet object. If ExpressionSet objects are not
used, the name of the annotation package can be supplied in the annotation argument
of gtKEGG.

Annotation packages are not always available for all microarray types. There-
fore, a general Entrez-based annotation package is available for many organisms, e.g.
org.Hs.eg.db for human. See www.bioconductor.org for the names of the or-
ganism specific packages. This general entrez-based annotation package may be sub-
stituted for a specific probe annotation package if a mapping from probe(set) ids to
Entrez is given (as a list or as a vector) in the probe2entrez argument. For the Golub
data we find such a mapping in the hu6800.db package.

> eg <- as.list(hu6800ENTREZID)
> gtKEGG(ALL.AML, Golub_Train, id="04110", probe2entrez = eg, annotation="org.Hs.eg.db")

04110 Cell cycle 4.59e-08

alias p-value Statistic Expected Std.dev #Cov
111

0.874

12.1

2.7

If more than one KEGG id is tested, multiple testing corrected p-values are au-
tomatically provided. The default multiple testing method is Holm’s, but others are
available through the multtest argument. See also the p.adjust function, described
in Section 2.3.2. The results are sorted to increasing p-values (using the sort method),
unless the sort argument of gtKEGG is set to FALSE.

> gtKEGG(ALL.AML, Golub_Train, id=c("04110","04210"), multtest="BH")

04110 9.19e-08 Cell cycle 4.59e-08
04210 5.74e-05 Apoptosis 5.74e-05

p-value Statistic Expected Std.dev #Cov
0.874 111
80
0.985

12.1
9.6

2.7
2.7

BH

alias

If the id argument is not specified, the function gtKEGG will test all KEGG pathways.

> gtKEGG(ALL.AML, Golub_Train)

38

3.3.2 Gene Ontology

To test Gene Ontology terms the special function gtGO is available. This function
accepts the same arguments as gt, except the subsets argument, which is replaced by
a collection of options to create gene sets from Gene Ontology. To test a single gene
ontology term, e.g. cell cycle (GO:0007049), we say

> gtGO(ALL.AML, Golub_Train, id="GO:0007049")

GO:0007049 cell cycle 1.49e-08

alias

p-value Statistic Expected Std.dev #Cov
765

9.81

0.64

2.7

The function automatically finds the right Gene Ontology information from the GO.db
package, and the right set of genes belonging to the gene ontology term from the anno-
tation package of the hu6800 Affymetrix chip; the reference to this annotation package
is contained in the Golub_Train ExpressionSet object. If ExpressionSet objects are
not used, the name of the annotation package can be supplied in the annotation argu-
ment of gtGO.

Annotation packages are not always available for all microarray types. There-
fore, a general Entrez-based annotation package is available for many organisms, e.g.
org.Hs.eg.db for human. See www.bioconductor.org for the names of the or-
ganism specific packages. This general entrez-based annotation package may be sub-
stituted for a specific probe annotation package if a mapping from probe(set) ids to
Entrez is given (as a list or as a vector) in the probe2entrez argument. For the Golub
data we find such a mapping in the hu6800.db package.

> eg <- as.list(hu6800ENTREZID)
> gtGO(ALL.AML, Golub_Train, id="GO:0007049", probe2entrez = eg, annotation="org.Hs.eg")

GO:0007049 cell cycle 1.49e-08

alias

p-value Statistic Expected Std.dev #Cov
765

9.81

0.64

2.7

It is also possible to test all terms in one or more of the three ontologies: Biological
Process (BP), Molecular Function (MF) and Cellular component (CC). A minimum
and/or a maximum number of genes may be specified for each term.

> gtGO(ALL.AML, Golub_Train, ontology="BP", minsize = 10, maxsize = 500)

If more than one gene ontology term is tested, multiple testing corrected p-values
are automatically provided. The default multiple testing method is Holm’s, but others
are available through the multtest argument. See also the p.adjust function, de-
scribed in Section 2.3.2. The results are sorted to increasing p-values (using the sort
method), unless the sort argument of gtGO is set to FALSE.

> gtGO(ALL.AML, Golub_Train, id=c("GO:0007049","GO:0006915"), multtest="BH")

GO:0006915 1.40e-12 apoptotic process 6.99e-13
cell cycle 1.49e-08
GO:0007049 1.49e-08

p-value Statistic Expected Std.dev #Cov
0.628 1221
0.640 765

10.92
9.81

2.7
2.7

BH

alias

39

A multiple testing method that is very suitable for Gene Ontology is the focus
level method, described in more detail in Section 2.3.3. This multiple testing method
presents a coherent significant subgraph of the Gene Ontology graph. This is a rel-
atively computationally intensive method. To keep this vignette light, we shall only
demonstrate the focus level method on the subgraph of “cell cycle” GO term and all its
descendants.

> descendants <- get("GO:0007049", GOBPOFFSPRING)
> res <- gtGO(ALL.AML, Golub_Train, id = c("GO:0007049", descendants), multtest = "focus")
> leafNodes(res)

GO:2000134
GO:0008608
GO:0090399
GO:0010971
GO:1904908
GO:1900087
GO:0007080
GO:0030953
GO:0070192
GO:1990683
GO:0045736
GO:1902975
GO:1902426
GO:0010972
GO:0007079
GO:0070314
GO:0090267
GO:0110032
GO:0045737
GO:0010571
GO:1903479
GO:0044773
GO:0000712
GO:0070601

GO:2000134
GO:0008608
GO:0090399
GO:0010971
GO:1904908
GO:1900087
GO:0007080
GO:0030953
GO:0070192
GO:1990683

focuslevel

alias

p-value
0.000565 negative regulation of G1/S transition of ... 3.44e-06
0.000820 attachment of spindle microtubules to kine... 8.04e-06
replicative senescence 1.73e-05
0.001763
0.001763 positive regulation of G2/M transition of ... 1.74e-05
0.003003 negative regulation of maintenance of mito... 2.97e-05
0.003138 positive regulation of G1/S transition of ... 1.64e-05
mitotic metaphase chromosome alignment 5.48e-05
0.005536
0.005737
astral microtubule organization 5.68e-05
0.009332 chromosome organization involved in meioti... 9.33e-05
0.010223 DNA double-strand break attachment to nucl... 1.02e-04
0.012660 negative regulation of cyclin-dependent pr... 1.28e-04
0.017865
mitotic DNA replication initiation 1.82e-04
0.018930 deactivation of mitotic spindle assembly c... 1.95e-04
0.021257 negative regulation of G2/M transition of ... 2.21e-04
0.022009 mitotic chromosome movement towards spindl... 2.29e-04
0.027105
G1 to G0 transition 2.85e-04
0.033523 positive regulation of mitotic cell cycle ... 3.53e-04
0.036113 positive regulation of G2/MI transition of... 3.97e-04
0.039137 positive regulation of cyclin-dependent pr... 4.35e-04
0.039952 positive regulation of nuclear cell cycle ... 4.49e-04
0.040727 mitotic actomyosin contractile ring assemb... 4.58e-04
0.041943
mitotic DNA damage checkpoint signaling 3.21e-04
0.042848 resolution of meiotic recombination interm... 4.87e-04
centromeric sister chromatid cohesion 5.62e-04
0.048908

Statistic Expected Std.dev #Cov
44
23
15
17
4
29
23
6
32
1

12.45
14.38
12.30
12.88
30.23
14.32
12.80
19.44
8.73
34.62

1.20
1.40
1.34
1.30
2.93
1.38
1.39
2.19
1.08
3.77

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

40

GO:0045736
GO:1902975
GO:1902426
GO:0010972
GO:0007079
GO:0070314
GO:0090267
GO:0110032
GO:0045737
GO:0010571
GO:1903479
GO:0044773
GO:0000712
GO:0070601

18.40
21.46
28.37
9.32
25.23
13.34
20.02
15.76
27.65
21.32
21.71
8.91
12.81
14.69

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

2.22
2.50
3.30
1.22
2.98
1.88
2.60
2.13
3.53
2.74
2.81
1.14
1.79
2.02

5
5
2
28
3
6
4
4
2
6
3
33
8
5

The leaf nodes can be seen as a summary of the significant GO terms: they present the
most specific terms that have been declared significant at a specified significance level
alpha (default 0.05). The graph can be drawn using the draw function. In the interac-
tive mode of this function, click on the nodes to see the GO id and term. The default
of this function is to draw the full graph, with the non-significant nodes greyed out. It
is also possible to only draw the significant graph by setting the sign.only argument to
TRUE. The draw function returns a legend to the graph, relating the numbers appearing
in the plot to the GO terms. This is useful when using draw in non-interactive mode

3.3.3 The Broad gene sets

A third frequently used database is the collection of curated gene sets main-
tained by the Broad institute. The sets are only available after registration at
http://www.broad.mit.edu/gsea/downloads.jsp#msigdb.
To use
the Broad gene sets, download the file msigdb_v.2.5.xml, which contains all sets.
A convenient function to read the xml file into R is provided in the getBroadSets
function from the GSEABase package. Once downloaded and read, the gtBroad
function can be used to analyze these gene sets using the global test.

> broad <- getBroadSets("your/path/to/msigdb_v.2.5.xml")

The examples in this vignette are displayed without results, because we cannot include
the msigdb_v.2.5.xml file in the globaltest package.

To test a single Broad set, e.g. the chromosomal location chr5q33, use

> gtBroad(ALL.AML, Golub_Train, id = "chr5q33", collection=broad)

The function automatically maps the gene set to the probe identifiers from the annota-
tion package of the hu6800 Affymetrix chip; the reference to this annotation package
is contained in the Golub_Train ExpressionSet object. If ExpressionSet objects are
not used, the name of the annotation package can be supplied in the annotation argu-
ment of gtBroad.

41

> draw(res, interactive=TRUE)
> legend <- draw(res)

Annotation packages are not always available for all microarray types. Therefore, a
general Entrez-based annotation package is available for many organisms. This general
annotation package may be substituted for a specific annotation package if a mapping
from probe(set) ids to Entrez is given (as a list or as a vector). For the Golub data we
use the mapping from the hu6800.db package to obtain this mapping.

> eg <- as.list(hu6800ENTREZID)
> gtBroad(ALL.AML, Golub_Train, id = "chr5q33", collection=broad, probe2entrez = eg, annotation="org.Hs.eg.db")

See www.bioconductor.org for the names of the organism specific packages.

If more than one Broad set is tested, multiple testing corrected p-values are au-
tomatically provided. The default multiple testing method is Holm’s, but others are
available through the multtest argument. See also the p.adjust function, described
in Section 2.3.2. The results are sorted to increasing p-values (using the sort method),
unless the sort argument of gtBroad is set to FALSE.

> gtBroad(ALL.AML, Golub_Train, id=c("chr5q33","chr5q34"), multtest="BH", collection=broad)

The broad collection contains four categories

c1 positional gene sets

42

188034341483919932029025401727131148737861661784228441592814695109182114973150753215865301831341618122724625114821922227370143139214289239238174105171893818731629329572361678822315127430417023517824531410128724229216220122632728531331221513164202261061524196823332822862126521171855731032533333431133032625823016521168278853614572223093243324715222576276234169419192168351032242753053072497411214445267102122681416967129591739477319277280269581212081331282154432963127155781549730627918111511453189188113992102411751774261002543211362973202562161201971351931382132642211492723032311631181191423088366153203107240266294147220157123146218237184248247110255132192511372122171061081803313282711329031524429113098176233286296200198261124260206298257243288229284111317207204195557915322329323205252318300601941641903011161915623225025396262502719912525928317991222092632703028218610415616140160265299c2 curated gene sets

c3 motif gene sets

c4 computational gene sets

c5 GO gene sets

To test all gene sets from a certain category, use

> gtBroad(ALL.AML, Golub_Train, category="c1", collection=broad)

3.4 Concept profiles

A drawback of the three gene set databases above is that they have hard criterion
for membership: each gene either belongs to the set or it does not. In reality, how-
ever, association of genes with biological concepts is gradual. Some genes are more
central to a certain biological process than others, and for some genes the associa-
tion with a process is more certain or well-documented than for others. To take this
into account, databases can be used that contain associations between genes and con-
cepts, rather than simply gene sets. One of these is the Anni tool, available from
http://www.biosemantics.org/anni. A function to test concepts from
Anni is given in the function gtConcept.

the

Like

function

gtBroad,
that

gtConcept
available within R, but

to
found on
download files
are not
www.biosemantics.org/weightedglobaltest.
for
gtConcept in this vignette are displayed without results, because we the concept
files are too large to be included in the globaltest package. To test a certain collection,
for example Body System.txt, we say

the
can be
The

examples

requires

user

> gtConcept(ALL.AML, Golub_Train, conceptmatrix="Body System.txt")

This automatically tests all concepts included in the file. Note that the files
conceptID2name.txt and entrezGeneToConceptID.txt must also be
downloaded from the same website or the function to work.

The function automatically maps the gene set to the probe identifiers from the anno-
tation package of the hu6800 Affymetrix chip; the reference to this annotation package
is contained in the Golub_Train ExpressionSet object. If ExpressionSet objects are
not used, the name of the annotation package can be supplied in the annotation argu-
ment of gtConcept.

Annotation packages are not always available for all microarray types. Therefore, a
general Entrez-based annotation package is available for many organisms. This general
annotation package may be substituted for a specific annotation package if a mapping
from probe(set) ids to Entrez is given (as a list or as a vector). For the Golub data we
use the mapping from the hu6800.db package to obtain this mapping.

> eg <- as.list(hu6800ENTREZID)
> gtConcept(ALL.AML, Golub_Train, conceptmatrix="Body System.txt", probe2entrez = eg, annotation="org.Hs.eg.db")

43

The gtConcept function uses the weighted version of the global test (see also
Section 2.1.12), with weights given by each gene’s association with a concept. An
argument threshold sets weights below the given threshold to zero, which limits com-
putation time. The #Cov column in the results output gives the number of probes with
non-zero weight. A further argument share, determines what to do with genes that have
multiple probes. If share is set to TRUE, the weight for each probe is set to the weight
of the gene divided by the number of probes of that gene, making the probes share the
total weight allocated to the gene. If share is set to FALSE, each probe gets the full
weight allocated to the gene.

Multiple testing corrected p-values are automatically provided by gtConcept.
The default multiple testing method is Holm’s, but others are available through the
multtest argument. See also the p.adjust function, described in Section 2.3.2. The
results are sorted to increasing p-values (using the sort method), unless the sort ar-
gument of gtConcept is set to FALSE.

> gtConcept(ALL.AML, Golub_Train, conceptmatrix="Body System.txt", multtest="BH")

3.5 Gene and sample plots

3.5.1 Visualizing features

The covariate (or “features”) plot may be used to great effect for investigating to which
individual probes or genes or to which subsets of the gene set a significant result for a
gene set may be attributed. The details of the features plot are described in Section
2.2.1. The alias argument is useful to replace the probe identifiers with more familiar
gene symbols.

The black line in the features plot represents the significant subgraph of the
clustering tree. To find the leaf nodes that characterize the graph, use the function
leafNodes.

> ft <- features(res, alias=hu6800SYMBOL)
> leafNodes(ft)

O[1[1[1[1[1[1[1[1[1[1[1[1[1[1[1[1:M92287_at
O[1[1[1[1[1[1[1[1[1[1[1[1[2[1:U33822_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[1[1[1[1[1[1:D38073_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[1[1[1[1[1[2:M15796_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[1[1[1:U31814_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[1[1:L41870_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[1[2:U49844_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[2:L49229_f_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[2[1[1:M22898_at
O[1[2[1[1[1:M81933_at

O[1[1[1[1[1[1[1[1[1[1[1[1[1[1[1[1:M92287_at

alias inheritance
0.000116
CCND3
0.009012
MAD1L1
0.000673
MCM3
0.009082
PCNA
0.004943
HDAC2
0.003211
RB1
0.035255
ATR
0.042920
RB1
0.032618
TP53
0.004715
CDC25A
p-value Statistic
53.2

2.06e-07

44

> res <- gtKEGG(ALL.AML, Golub_Train, id = "04110")
> features(res, alias=hu6800SYMBOL)

4.07e-04
O[1[1[1[1[1[1[1[1[1[1[1[1[2[1:U33822_at
2.48e-06
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[1[1[1[1[1[1:D38073_at
1.86e-04
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[1[1[1[1[1[2:M15796_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[1[1[1:U31814_at
3.58e-05
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[1[1:L41870_at 3.82e-05
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[1[2:U49844_at 2.45e-04
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[2:L49229_f_at 4.82e-04
3.16e-04
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[2[1[1:M22898_at
2.18e-05
O[1[2[1[1[1:M81933_at
Expected Std.dev #Cov
1
1
1
1
1
1
1
1

O[1[1[1[1[1[1[1[1[1[1[1[1[1[1[1[1:M92287_at
O[1[1[1[1[1[1[1[1[1[1[1[1[2[1:U33822_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[1[1[1[1[1[1:D38073_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[1[1[1[1[1[2:M15796_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[1[1[1:U31814_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[1[1:L41870_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[1[2:U49844_at
O[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[1[1[2:L49229_f_at

29.7
46.4
32.5
38.2
38.0
31.5
29.0
30.6
39.8

3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

45

abs. correlation10.80.60.40.2CCND3ESPL1YWHAZMCM6YWHAQMAD2L1YWHAEATRTP53PRKDCMYCHDAC1MCM7MCM5CDC6TGFB3CDKN1ARBL1CCNB1RB1GADD45AATMSTAG1ATMCDC27CDKN2BCCND1CDC25CABL1CCNA2TFDP2CUL1EP300CDC25ACCNA1CCNHTGFB3p−value10.10.010.0011e−041e−051e−06assoc. with response = AMLassoc. with response = ALLO[1[1[1[1[1[1[1[1[1[1[2[1[1[1[2[1[1[2[2[1[1:M22898_at
O[1[2[1[1[1:M81933_at

2.7
2.7

3.77
3.77

1
1

It may happen that the leaf nodes of the significant graph are not individual features,
but sets of features higher up in the clustering graph. Use the subsets method to find
which features belong to such a node.

> subsets(leafNodes(ft))

It is possible to only plot the significant subtree with the zoom argument. This is espe-
cially useful if the set of features is large.

> res <- gtKEGG(ALL.AML, Golub_Train, id = "04110")
> features(res, alias=hu6800SYMBOL, zoom=TRUE)

The extract function can be useful to get information on the individual features,

and the plot argument can be used to suppress plotting.

> ft <- features(res, alias=hu6800SYMBOL, plot=FALSE)
> extract(ft)

M92287_at
D38073_at

alias
CCND3 assoc. with response = ALL 2.06e-07
MCM3 assoc. with response = ALL 2.48e-06

p-value Statistic Expected
2.7
53.19830
2.7
46.43408

direction

46

abs. correlation10.80.60.40.2CCND3MAD1L1MCM3PCNAHDAC2RB1ATRRB1TP53CDC25Ap−value10.10.010.0011e−041e−051e−06assoc. with response = AMLassoc. with response = ALLM81933_at
U31814_at
L41870_at
M15796_at
U49844_at
M22898_at
U33822_at
X56468_at
L49229_f_at
X76061_at
X62153_s_at
D50405_at
U47077_at
U31556_at
D21063_at
L49219_f_at
D84557_at
AB003698_at
U58087_at
L14812_at
U54778_at
M86400_at
D80000_at
U50950_at
L00058_at
U44378_at
D38551_at
U33841_at
M38449_s_at
U65410_at
D78577_s_at
U18291_at
S78187_at
U66838_at
X74794_at
U35835_s_at
M13929_s_at
X62048_at
U68018_at
U33761_at
M68520_at
U05340_at
U37022_rna1_at
Z47087_at
U27459_at
L20320_at

CDC25A assoc. with response = AML 2.18e-05
HDAC2 assoc. with response = ALL 3.58e-05
RB1 assoc. with response = ALL 3.82e-05
PCNA assoc. with response = ALL 1.86e-04
ATR assoc. with response = ALL 2.45e-04
TP53 assoc. with response = ALL 3.16e-04
MAD1L1 assoc. with response = ALL 4.07e-04
YWHAQ assoc. with response = ALL 4.16e-04
RB1 assoc. with response = ALL 4.82e-04
RBL2 assoc. with response = ALL 5.13e-04
MCM3 assoc. with response = ALL 5.36e-04
HDAC1 assoc. with response = ALL 9.16e-04
PRKDC assoc. with response = ALL 1.06e-03
E2F5 assoc. with response = ALL 1.26e-03
MCM2 assoc. with response = ALL 1.72e-03
RB1 assoc. with response = ALL 1.78e-03
MCM6 assoc. with response = ALL 2.47e-03
CDC7 assoc. with response = ALL 3.47e-03
CUL1 assoc. with response = ALL 4.06e-03
RBL1 assoc. with response = AML 4.54e-03
YWHAE assoc. with response = ALL 5.16e-03
YWHAZ assoc. with response = ALL 5.63e-03
SMC1A assoc. with response = ALL 6.23e-03
ORC3 assoc. with response = ALL 7.24e-03
MYC assoc. with response = ALL 8.04e-03
SMAD4 assoc. with response = ALL 8.71e-03
RAD21 assoc. with response = ALL 1.12e-02
ATM assoc. with response = ALL 1.42e-02
TGFB1 assoc. with response = AML 1.46e-02
MAD2L1 assoc. with response = ALL 1.52e-02
YWHAH assoc. with response = ALL 1.66e-02
CDC16 assoc. with response = ALL 1.75e-02
CDC25B assoc. with response = ALL 1.80e-02
CCNA1 assoc. with response = AML 1.92e-02
MCM4 assoc. with response = ALL 3.69e-02
PRKDC assoc. with response = ALL 4.66e-02
MYC assoc. with response = ALL 4.77e-02
WEE1 assoc. with response = ALL 4.81e-02
SMAD2 assoc. with response = ALL 4.87e-02
SKP2 assoc. with response = ALL 5.17e-02
CDK2 assoc. with response = ALL 5.18e-02
CDC20 assoc. with response = ALL 5.56e-02
CDK4 assoc. with response = ALL 5.79e-02
SKP1 assoc. with response = AML 6.65e-02
ORC2 assoc. with response = ALL 6.67e-02
CDK7 assoc. with response = AML 8.13e-02

39.79937
38.17296
37.95700
32.52170
31.52687
30.60253
29.66253
29.58431
29.03598
28.80792
28.64125
26.61297
26.05144
25.37200
24.16943
24.04374
22.74248
21.38337
20.74833
20.29337
19.77169
19.41090
18.99897
18.38269
17.94718
17.61524
16.58758
15.57765
15.44794
15.29905
14.92642
14.69037
14.57597
14.30382
11.54666
10.54979
10.45628
10.41850
10.36841
10.10829
10.10423
9.80474
9.63048
9.04819
9.03776
8.20021

47

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

L49209_s_at
M60974_s_at
U67092_s_at
U15642_s_at
X14885_rna1_s_at
S75174_at
S78271_s_at
U79277_at
U26727_at
U20647_at
U15641_s_at
D55716_at
S49592_s_at
U50079_s_at
U47677_at
M86699_at
U89355_at
U40343_at
U01038_at
L23959_at
U01877_at
M60556_rna2_at
S78234_at
J05614_at
U77949_at
U68019_at
L33801_at
X74795_at
X66365_at
D79987_at
X57348_s_at
X91196_s_at
X57346_at
X95406_at
Z75330_at
L36844_at
U00001_s_at
M19154_at
M25753_at
U18422_at
U33202_s_at
U56816_at
X05839_rna1_s_at
U11791_at
L40386_s_at
L41913_at

RB1 assoc. with response = ALL 8.67e-02
GADD45A assoc. with response = AML 8.77e-02
ATM assoc. with response = AML 9.48e-02
E2F5 assoc. with response = ALL 9.79e-02
TGFB3 assoc. with response = AML 1.02e-01
E2F4 assoc. with response = ALL 1.07e-01
SMC1A assoc. with response = ALL 1.08e-01
YWHAZ assoc. with response = ALL 1.14e-01
CDKN2A assoc. with response = ALL 1.16e-01
ZBTB17 assoc. with response = AML 1.19e-01
E2F4 assoc. with response = AML 1.20e-01
MCM7 assoc. with response = ALL 1.36e-01
E2F1 assoc. with response = ALL 1.37e-01
HDAC1 assoc. with response = ALL 1.38e-01
E2F1 assoc. with response = ALL 1.46e-01
TTK assoc. with response = ALL 1.58e-01
CREBBP assoc. with response = ALL 1.61e-01
CDKN2D assoc. with response = ALL 1.66e-01
PLK1 assoc. with response = AML 1.76e-01
TFDP1 assoc. with response = AML 1.77e-01
EP300 assoc. with response = AML 1.86e-01
TGFB3 assoc. with response = AML 1.98e-01
CDC27 assoc. with response = ALL 2.27e-01
PCNA assoc. with response = ALL 2.29e-01
CDC6 assoc. with response = ALL 2.63e-01
SMAD3 assoc. with response = AML 2.65e-01
GSK3B assoc. with response = ALL 3.10e-01
MCM5 assoc. with response = ALL 3.15e-01
CDK6 assoc. with response = ALL 3.20e-01
ESPL1 assoc. with response = ALL 3.24e-01
SFN assoc. with response = AML 3.34e-01
ATM assoc. with response = ALL 3.36e-01
YWHAB assoc. with response = ALL 3.37e-01
CCNE1 assoc. with response = AML 3.41e-01
STAG1 assoc. with response = ALL 3.80e-01
CDKN2B assoc. with response = AML 4.11e-01
CDC27 assoc. with response = AML 4.20e-01
TGFB2 assoc. with response = AML 4.41e-01
CCNB1 assoc. with response = ALL 4.78e-01
TFDP2 assoc. with response = ALL 5.04e-01
MDM2 assoc. with response = ALL 5.12e-01
PKMYT1 assoc. with response = AML 5.16e-01
TGFB1 assoc. with response = AML 5.25e-01
CCNH assoc. with response = AML 5.64e-01
TFDP2 assoc. with response = AML 5.75e-01
RB1 assoc. with response = ALL 6.02e-01

7.93045
7.88684
7.56137
7.42583
7.24222
7.06631
6.99970
6.79674
6.73857
6.60584
6.57267
6.06622
6.03986
6.00452
5.78369
5.45127
5.37907
5.26203
5.02308
4.99322
4.81477
4.56280
4.02468
3.99464
3.47141
3.43277
2.86266
2.80732
2.74443
2.70236
2.59415
2.57146
2.55872
2.51750
2.15057
1.88249
1.81674
1.65874
1.40488
1.25147
1.20094
1.17905
1.13161
0.93076
0.88070
0.76495

48

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

X51688_at
D38550_at
U33203_s_at
X05360_at
D13639_at
M92424_at
M34065_at
U22398_at
J03241_s_at
L49218_f_at
U09579_at
Y00083_s_at
Z29077_xpt1_at
U40152_s_at
X16416_at
X59798_at
M74093_at

CCNA2 assoc. with response = ALL 6.13e-01
E2F3 assoc. with response = ALL 6.24e-01
MDM2 assoc. with response = ALL 6.91e-01
CDK1 assoc. with response = ALL 7.10e-01
CCND2 assoc. with response = AML 7.20e-01
MDM2 assoc. with response = AML 7.22e-01
CDC25C assoc. with response = ALL 7.25e-01
CDKN1C assoc. with response = ALL 7.41e-01
TGFB3 assoc. with response = ALL 7.44e-01
RB1 assoc. with response = ALL 7.52e-01
CDKN1A assoc. with response = AML 8.17e-01
TGFB2 assoc. with response = AML 8.57e-01
CDC25C assoc. with response = AML 8.97e-01
ORC1 assoc. with response = AML 9.13e-01
ABL1 assoc. with response = ALL 9.20e-01
CCND1 assoc. with response = AML 9.23e-01
CCNE1 assoc. with response = AML 9.56e-01

0.71768
0.67570
0.44323
0.38834
0.36155
0.35471
0.34826
0.30808
0.29931
0.28147
0.15003
0.09154
0.04704
0.03339
0.02864
0.02633
0.00851

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

M92287_at
D38073_at
M81933_at
U31814_at
L41870_at
M15796_at
U49844_at
M22898_at
U33822_at
X56468_at
L49229_f_at
X76061_at
X62153_s_at
D50405_at
U47077_at
U31556_at
D21063_at
L49219_f_at
D84557_at
AB003698_at
U58087_at
L14812_at
U54778_at
M86400_at
D80000_at
U50950_at
L00058_at
U44378_at

Std.dev #Cov
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77

49

D38551_at
U33841_at
M38449_s_at
U65410_at
D78577_s_at
U18291_at
S78187_at
U66838_at
X74794_at
U35835_s_at
M13929_s_at
X62048_at
U68018_at
U33761_at
M68520_at
U05340_at
U37022_rna1_at
Z47087_at
U27459_at
L20320_at
L49209_s_at
M60974_s_at
U67092_s_at
U15642_s_at
X14885_rna1_s_at
S75174_at
S78271_s_at
U79277_at
U26727_at
U20647_at
U15641_s_at
D55716_at
S49592_s_at
U50079_s_at
U47677_at
M86699_at
U89355_at
U40343_at
U01038_at
L23959_at
U01877_at
M60556_rna2_at
S78234_at
J05614_at
U77949_at
U68019_at

3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

50

L33801_at
X74795_at
X66365_at
D79987_at
X57348_s_at
X91196_s_at
X57346_at
X95406_at
Z75330_at
L36844_at
U00001_s_at
M19154_at
M25753_at
U18422_at
U33202_s_at
U56816_at
X05839_rna1_s_at
U11791_at
L40386_s_at
L41913_at
X51688_at
D38550_at
U33203_s_at
X05360_at
D13639_at
M92424_at
M34065_at
U22398_at
J03241_s_at
L49218_f_at
U09579_at
Y00083_s_at
Z29077_xpt1_at
U40152_s_at
X16416_at
X59798_at
M74093_at

3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77
3.77

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

When testing many GO or KEGG terms it can be convenient to make features plots

for all tested gene sets at once, writing all plots to a pdf.

> res_all <- gtKEGG(ALL.AML, Golub_Train)
> features(res_all[1:5], pdf="KEGGcov.pdf", alias=hu6800SYMBOL)

51

3.5.2 Visualizing subjects

Similarly, the subjects plot, described in Section 2.2.2, can be used to investigate which
subjects are similar in terms of their expression signature to other subjects with the
same response variable, and which deviate from that pattern. In the subjects di-
agnostic plot, the subjects associated with strong evidence for the association between
the response and the gene expression profile of the pathway have low p-values (tall
bars), whereas the subjects with high p-values have weak or even contrary evidence.
The most interesting subjects plot to look at is usually the subjects plot for the global
test on all genes. From the figure, in this case, we note that the expression profile of
the AML subjects seems more homogeneous than that of the ALL subjects: the latter
group tends to be less coherent overall, and to contain more outlying subjects. Just

> res <- gt(ALL.AML, Golub_Train)
> subjects(res)

as with the covariates plot, subjects plots can be called on many gene sets at
once, e.g. the top 25 pathways, and the results written to a pdf file.

> res_all <- gtKEGG(ALL.AML, Golub_Train)
> subjects(res_all[1:25], pdf="KEGGsubj.pdf")

52

correlation10.80.60.40.203733382829363034353231251214727822162619241551320211817142119323610p−value10.10.010.0011e−041e−051e−06ALL.AML = AMLALL.AML = ALL3.6 Survival data

The examples in this chapter so far were all in a classification context, in which the
response category had two possible values, and the logistic regression model was used.
The globaltest package is not limited to this response type, but can also handle multi-
category response (using a multinomial logistic regression model), continuous response
(using a linear regresseion model), count data (using a Poisson regression model), and
survival data (using the Cox proportional hazards model). See section 2.1.8 for more
details.

The multi-category, linear and count data versions are called in exactly the same
way as the two-category one. The gt function will try to determine the model from the
input, but the user can override any automatic choice by specifying the model argument.
For survival data, the input format is similar to the one used by the survival package.
In the michigan data set (Beer et al., 2002) from the lungExpression package, for
example, the survival time is coded in a time variable TIME..months., and a status
variable death, for which 1 indicates that the patient passed away at the recorded time
point, and 0 that the patient was withdrawn alive. To test for an overall association
between the gene expression profile and survival, we test

> library(lungExpression)
> data(michigan)
> gt(Surv(TIME..months., death==1), michigan)

p-value Statistic Expected Std.dev #Cov
0.417 3171

0.188

1.16

1.53

1

3.7 Comparative proportions

In some cases it can be of interest not only to know whether a certain gene set is signifi-
cantly associated with a phenotype, but also whether it is exceptionally associated with
the phenotype for a gene set of its size in the data set under study. This is a so-called
competitive view on gene set testing. See Goeman and Bühlmann (2007) for issues
involved with this competitive view.

It is possible to use globaltest for such competitive gene set exploration using the
function comparative. For each gene set tested, this function calculates the pro-
portion of randomly sampled gene sets of the same size as the tested gene set that has
an equal or larger global test p-value. This comparative proportion can be used as a
diagnostic for the test results. Gene sets with small comparative proportions are excep-
tionally significant in comparison to a random gene set of its size in the data set. The
comparative proportion is a diagnostic that conveys additional information. It should
not be interpreted as a p-value in the usual sense.

> res <- gtKEGG(ALL.AML, Golub_Train, id = "04110")
> comparative(res)

04110 Cell cycle

alias comparative

0.212 4.59e-08

p-value Statistic Expected Std.dev #Cov
0.874 111

12.1

2.7

53

The number of random gene sets of each size that are sampled can be controlled
with the argument N (default 1000). The argument zscores (default: TRUE) controls
whether the comparison between the test results of the gene set and its random com-
petitors is based on the p-values or on the z-scores of the test.

54

Chapter 4

Goodness-of-Fit Testing

4.1 Introduction

Another application of the global test is in goodness-of-fit testing for regression mod-
els. Generalized linear models, while flexible in terms of the supported response dis-
tributions, obey rather strong assumptions like linearity of the effect of the covariates
on the predictor and the independence of the observations. The Cox regression model,
even though leaves the baseline hazard unspecified, relies on the quite restrictive pro-
portional hazards assumption. Therefore, in practical regression problems, lack of fit
comes in all shapes and sizes:

• Unit- or cluster-specific heterogeneity may exist;

• The effect of continuous covariates on the predictor may be of non-linear form;

• Interactions between covariates may be missed or be more complex;

• The proportional hazards assumption may not hold.

Distinguishing the different types of lack of fit is of practical importance: if we find
evidence against the model, we generally also want to know why the model does not
fit.

In this Chapter we introduce a goodness-of-fit testing approach based on the global
test. It requires the specification of an alternative model, which identifies the type of
lack of fit the test is directed against. Various types of lack of fit are treated within the
same framework and many existing tests can be considered as special cases.

Suppose that we are concerned with the adequacy of some regression model
Y ~ X, where X represents the null design matrix. The alternative model can be cast
into the generic form Y ~ X + Z, where the choice of Z depends on the type of lack
of fit under investigation. Once Z has been chosen, the global test is applied for testing
Y ~ X against Y ~ X + Z.

Sometimes a reparameterization of the alternative model is necessary. The required
parameterization is either a penalized regression model with a ridge penalty on the

55

coefficients associated with Z or a mixed effect model where the coefficients associated
with Z are i.i.d. random effects.

The examples listed below illustrate testing against several types of lack of fit. We
have not attempted to write an exhaustive list, but rather to show how different choices
of Z accomodate to various types of lack of fit.

4.2 Heterogeneity

The data faults gives the number of faults in rolls of textile fabric with varying
length (?). We consider a Poisson log-linear model with logarithm of the roll length
as covariate. However, we may allow for the possibility of extra-Poisson variation by
using a mixed model with i.i.d. random effects, one for each observation. Here Z is
specified as the identity matrix with ones on the main diagonal and zeros elsewhere.
For testing against overdispersion, use

> require("boot")
> data(cloth)
> Z <- matrix(diag(nrow(cloth)), ncol = nrow(cloth), dimnames = list(NULL, 1:nrow(cloth)))
> gt(y ~ log(x), alternative = Z, data = cloth, model = "poisson")

p-value Statistic Expected Std.dev #Cov
32

0.0393

1 0.0102

3.54

3.65

The null hypothesis of no overdispersion can be rejected at the significance level of
5%.

The data rats comes from a carcinogen experiment using 150 female rats, 3 each
from 50 litters Mantel et al. (1977). One rat from each litter was injected with a power-
ful carcinogen, and the time to tumor development, measured in weeks, was recorded.
It is conceivable that the risk of tumor formation may depend on the genetic background
or the early environmental conditions shared by siblings within litters, but differing be-
tween litters. Thus, intra-litter correlation in time to tumor appearance may exists. An
alternative model allowing intra-litter correlations is a mixed model with i.i.d. random
intercepts representing the litter effect. Here the matrix Z is specified as a block matrix
where each row is a vector of zeros except for a 1 in one position that indicates which
litter the rat is from. For testing the hypothesis of no intra-litter correlation, use

> library("survival")
> data(rats)
> nlitters<-length(unique(rats$litter))
> Z<-matrix(NA,dim(rats)[1],nlitters, dimnames=list(NULL,1:nlitters))
> for (i in 1:nlitters) Z[,i]<-(rats[,1]==i)*1
> gt(Surv(time,status)~rx,alternative=Z,data=rats,model="cox")

p-value Statistic Expected Std.dev #Cov
100

0.0404

0.334

0.48

1 0.000162

The null hypothesis of no intra-litter correlation can not be rejected at the significance
level of 5%.

56

4.3 Non-linearity

In many applications, the assumption of a linear dependence of the response on covari-
ates is inappropriate. Semiparametric models provide a flexible alternative for detect-
ing non-linear covariate effects. For a single continuous covariate X, the model Y~X is
extended to Y~X+s(X), where s(X) is an unspecified smooth function.

4.3.1 P-Splines

One increasingly popular idea to represent s(X) is the P-splines approach, introduced
by Eilers and Marx (1996). In this approach s(X) is replaced by a B-spline basis
Z, giving the alternative model Y~X+Z, where the coefficients associated with Z are
penalized to guarantee sufficient smoothness.

The function gtPS can be used to define P-splines. We need to specify the follow-
ing arguments: i) bdeg, the degree of B-spline basis, ii) nint, the number of intervals
determined by equally-spaced knots placed on the X-axis, and iii) pord, the order of the
differences indicating the type of the penalty imposed to the coefficients.

The bdeg and nint arguments are used to construct a B-spline basis Z (default values
are bdeg=3 and nint=10). The order of differences pord deserves more attention
(default value is pord=2). Remember that we should obtain a ridge penalty on the
coefficients associated with Z. This is true with pord=0, but in the world of P-splines
it is common to use a roughness penalty based on differences of adjacent B-Spline
coefficients, for instance, second order differences pord=2.

In this case we have to reparameterize the alternative model by decomposing Z into
U and P. This gives the alternative model Y~X+U+P where the coefficients associated
with U are unpenalized whereas the coefficients associated with P are penalized by a
ridge penalty. However, the global test is not meant for testing the unpenalized coef-
ficient, but it is concerned with the penalized coefficients. To get around this and test
only for the penalized coefficients to be zero, we have to make sure that the columns of
U spans a subspace of the columns of X, so that U can be absorbed into X. Otherwise,
we are inadvertently changing the null hypothesis, or equivalently, we are considering
the null model Y~X+U.

We can best illustrate this with a simple example: we add some Gaussian noise to
the second data set reported in ?, where Y has a quadratic relation with X. To test Y~X
against Y~X+s(X) with default values, use:

> data(anscombe)
> set.seed(0)
> X<-anscombe$x2
> Y<-anscombe$y2 + rnorm(length(X),0,3)
> gtPS(Y~X)

p-value Statistic Expected Std.dev #Cov
11

1 0.0328

11.1

12.5

39.8

The same result can be obtained by using bbase to construct the B-spline basis Z and
reparamZ to get the penalized part P to be plugged into gt:

57

> Z<-bbase(X,bdeg=3,nint=10)
> P<-reparamZ(Z,pord=2)
> gt(Y~X,alternative=P)

p-value Statistic Expected Std.dev #Cov
11

1 0.0328

11.1

39.8

12.5

A quick way to check whether U is absorbed into the null design matrix or not is to
fit the augmented null model and see if all the coefficients associated with U are not
defined because of singularities:

> U<-reparamZ(Z,pord=2, returnU=TRUE)$U
> lm(Y~X+U)$coefficients

(Intercept)
5.0676959

X
0.4022611

U1
NA

U2
NA

The function gtPS allows the specification of multiple arguments:

> gtPS(Y~X, pord=list(Z=0,P=2))

p-value Statistic Expected Std.dev #Cov
13
11

Z 0.4674
P 0.0328

3.16
12.50

11.1
11.1

11.2
39.8

However, the result is not conclusive because pord=2 detects the deviation from lin-
earity at the significance level of 5%, whereas pord=0 does not. To assess the global
significance, set robust=TRUE:

> rob<-gtPS(Y~X, pord=list(Z=0,P=2), robust=TRUE)
> rob@result

p-value Statistic Expected
[1,] 0.04566734 25.49666 11.11111 7.282723

Std.dev #Cov
24

Another way to obtain a global result is to combine the matrices Z (corresponding

to pord=0) and P (corresponding to pord=2) into one overall matrix:

> comb<-gt(Y~X, alternative=cbind(Z,P))
> comb@result

p-value Statistic Expected
[1,] 0.03421195 36.89726 11.11111 11.41456

Std.dev #Cov
24

However, it may not be satisfactory because the component matrices Z and P do not
contribute equally in the test statistic. In constrast, the robust argument assigns equal
weight to each component:

> colrange<-list(Z=1:ncol(Z), P=(ncol(Z)+1):(ncol(Z)+ncol(P)))
> sapply(list(combined=comb,robust=rob), function(x){sapply(colrange,
+ function(y){sum(weights(x)[y])/sum(weights(x))})})

combined robust
0.5
0.5

Z 0.1020246
P 0.8979754

58

4.3.2 Generalized additive models

With multiple covariates, generalized addittive models (GAMs) augment the linear pre-
dictor ~X1+X2+... by a sum of smooth terms s(X1)+s(X2)+....

A classic example dataset for GAMs is kyphosis, representing observations
on 81 children undergoing corrective surgery of the spine. For testing against non-
linearity, the logististic model Kyphosis~Age+Number+Start is compared to the
GAM Kyphosis~...+s(Age)+s(Number)+s(Start)

> require("rpart")
> data("kyphosis")
> fit0<-glm(Kyphosis~., data = kyphosis, family="binomial")
> res<-gtPS(fit0)
> res@result

p-value Statistic Expected

[1,] 0.01452938 4.018158 1.401601 0.9090422

Std.dev #Cov
33

From the test result we can suspect that there is a non-linear effect in at least one
covariate. To list the smooth terms specified in the alternative model, use:

> sterms(res)

s.term bdeg nint pord
2
3
1
s(Age)
2
3
2 s(Number)
2
3
3 s(Start)

10
10
10

A follow-up question concerns which covariates exhibit non-linearity. To address
this question, we can fit the the same alternative model used for the test to decide
what modifications to the model may be appropriate to consider. An advantage of
having a specified alternative is that the same alternative model that was used in the
test can be fitted. We use the package penalized to perform ridge regression estimation
with the amount of shrinkage determined by the tuning parameter lambda2. We set
lambda2 equal to 0.086, the value maximizing the cross-validated likelihood. To get
the alternative design matrix used in the test, set the argument returnZ to TRUE:

> require("penalized")
> Z<-gtPS(fit0, returnZ=TRUE)$Z
> fit1<-penalized(Kyphosis, penalized=~ Z, unpenalized=~Age+Number+Start, data = kyphosis, model="logistic", lambda2 = 0.086, trace=FALSE)

Figure 4.1 shows the component smooth terms of the fitted GAM. From the plots it
seems that all the covariates have a quadratic pattern, though Number it is much less
pronounced than for the other two variables.

The argument covs can be used to select a subset of the covariates, and testing for

non-linearity is done for that subset only:

> gtPS(fit0, covs=c("Age","Start"))

59

Figure 4.1: Kyphosis data: component smooth terms.

p-value Statistic Expected Std.dev #Cov
22

1 0.00327

1.39

6.11

1.12

Because Number and Start are heavily tied, one can modify the number of in-

tervals for those covariates:

> gtPS(fit0,covs=c("Age","Number","Start"), nint=list(a=5, b=c(5,1,1)), pord=0)

p-value Statistic Expected Std.dev #Cov
24
16

a 0.1208
b 0.0373

0.680
0.845

2.19
3.19

1.4
1.4

With pord=0, the choice of nint is crucial: too small may not be flexible enough to
capture the variability of the data, too large tends to overfit the data.
In constrast,
higher-order penalties guarantee sufficient smoothness and are less affected by the
choice of nint.

An alternative GAM construction is to build and concatenate each model compo-

nent like building blocks:

> covs=c("Age","Number","Start")
> bd=c(3,3,3);ni=c(10,10,10);po=c(2,2,2);cs<-c(0,cumsum(bd+ni-po))

60

050100150200−1.5−0.50.5Ages(Age)246810−1.5−0.50.5Numbers(Number)51015−1.5−0.50.5Starts(Start)> X0<-model.matrix(fit0)[,]
> combZ<-do.call(cbind,lapply(1:length(covs),function(x){reparamZ(bbase(kyphosis[,covs[x]], nint=ni[x], bdeg=bd[x]), pord=po[x])}))
> comb<-gt(Kyphosis~., alternative=combZ, data = kyphosis, model="logistic")
> comb@result

p-value Statistic Expected

[1,] 0.01168322 4.257804 1.400199 0.9260297

Std.dev #Cov
33

However, the model components may not contribute equally in the test statistic:

> range<-lapply(1:length(covs),function(x){(cs[x]+1):(cs[x+1])})
> names(range)<-covs
> sapply(range,function(x){sum(weights(comb)[x])/sum(weights(comb))})

Start
0.3360275 0.2833923 0.3805803

Number

Age

To assign equal weight to each component, as gtPS does, use the function reweighZ:

> rwgtZ<-do.call(cbind,lapply(1:length(covs),function(x){reweighZ(reparamZ(bbase(kyphosis[,covs[x]], nint=ni[x], bdeg=bd[x]), pord=po[x]),fit0)}))
> rwgt<-gt(Kyphosis~., alternative=rwgtZ, data = kyphosis, model="logistic")
> sapply(range,function(x){sum(weights(rwgt)[x])/sum(weights(rwgt))})

Age

Start
0.3333333 0.3333333 0.3333333

Number

4.4 Non-linear and missed interactions

Suppose we are modelling the dependence of the response on several covariates,
expressed as Y~X1+X2+....
For testing against the alternative that any non-
linearities or interaction effects have been missed, one can consider the model
Y~X1+X2+...+s(X1,X2,...), where s() is an unspecified multi-dimensional
smooth function.

4.4.1 Kernel smoothers

Kernel smoothers have advantages over P-splines for constructing multi-dimensional
smooth terms, even though tensor products of B-splines can still be used for low di-
mensions.

The data LakeAcidity concerns 112 lakes in the Blue Ridge mountains
area. Of interest is the dependence of the water acidity on the geographic loca-
tions (latitude and longitude) and the calcium concentration (in the log10 scale). To
testph~log10(cal)+lat+lon against ph~...+s(cal,lat,lon), use:

> library(gss)
> data(LakeAcidity)
> fit0<-lm(ph~log10(cal)+lat+lon, data=LakeAcidity)
> res<-gtKS(fit0)
> res@result

61

p-value Statistic

Expected
1.693737 0.9259259 0.3365286

Std.dev #Cov
112

quant 0.25 0.02508802

> sterms(res)

kernel
1 s(cal,lat,lon) 0.25 euclidean uniform

smooths quant

metric

The smoothing matrix Z is defined by a distance measure metric, a kernel shape kernel
and a bandwidth quant, expressed as the percentile of the distribution of distance be-
tween observations, which controls the amount of smoothing. If the argument termla-
bels is set to TRUE, the smoothing term s(log10(cal),lat,lon) is obtained.

> gtKS(fit0, quant=seq(.01,.99,.02), data=LakeAcidity, termlabels=TRUE, robust=T)

p-value Statistic Expected Std.dev #Cov
0.37 5600

0.926

1 0.0075

2.26

Figure 4.2: Lake Acidity data: significance trace.

The choice of the bandwidth may be crucial: the plot of Figure 4.2 illustrates the
influence of quant (from .01 to .99 with increment of .02) on the significance of the

62

0.00.20.40.60.81.00.00.10.20.30.40.5quantp−valuetest. The result seems conclusive since it stays mostly under the conventional 5% level.
? considered the same plot, which they refer to as the ‘significance trace’. The global
significance (dotted line) is obtained by setting robust=TRUE:

Latitude and longitude are included in the model to allow for geographical effects
in the pattern of water acidity. However, it is less natural to include these terms sepa-
rately since they define a two-dimensional co-ordinate system. For testing whether the
interaction between latitude and longitude is linear or is of a more complex non-linear
form, a two-dimensional interaction surface s(lat,lon) can be constructed by a
tensor product of univariate P-splines penalized by a Kroneker sum of penalties. To
test ph~lat+lon+lat:lon against ph~...+s(lat,lon), use:

> fit0<-lm(ph~lat*lon, data=LakeAcidity)
> res<-gtPS(fit0, covs=c("lat","lon"), interact=TRUE, data=LakeAcidity)
> res@result

p-value Statistic

Expected

[1,] 0.01604265 2.768752 0.9259259 0.6119016

Std.dev #Cov
165

> sterms(res)

1 s(lat,lon) lat
2 s(lat,lon) lon

s.term bdeg nint pord
2
3
2
3

10
10

Figure 4.3 displays the fitted alternative model, which suggests a non-linear inter-

action between latitude and longitude.

To test against non-linear main effects or non-linear interactions, we can consider
the alternative ph~...+s(lat)+s(lon)+s(lat,lon). Each model component
can be constructed and combined like building blocks. The function bbase in combi-
nation with reparamZ can be used for constructing s(lat) and s(lon), whereas
btensor for constructing s(lat,lon) as tensor product of P-splines (reparame-
terized according to Kroneker sum of penalties). Finally, reweighZ can be used to
give to each component the same contribution in the test statistic:

> Z1<-reweighZ(reparamZ(bbase(LakeAcidity$lat, bdeg=3, nint=10), pord=2), fit0)
> Z2<-reweighZ(reparamZ(bbase(LakeAcidity$lon, bdeg=3, nint=10), pord=2), fit0)
> Z12<-reweighZ(btensor(cbind(LakeAcidity$lat, LakeAcidity$lon),bdeg=c(3,3),nint=c(10,10),pord=c(2,2)), fit0)
> gt(ph~lat*lon, alternative=cbind(Z1,Z2,Z12), data=LakeAcidity)

p-value Statistic Expected Std.dev #Cov
187

0.926

0.619

1 0.00523

3.4

4.4.2 Varying-coefficients models

Sometimes the linear interaction X:F between a continuous covariate X and a factor F
is not appropriate, and a non-linear interaction s(X):F may be preferred to let F to
vary smoothly over the range of "X".

63

Figure 4.3: Lake Acidity data: fitted alternative model.

For various settings of

Let’s look at nox data as an example. Ethanol fuel was burned in a sin-
the engine compression comp
gle cylinder engine.
the emissions of nitrogen oxides nox were
and the equivalence ratio equi,
recorded. To test if the model nox~equi+comp+equi:comp requires a non-
linear form equi, that is, to test against the varying-coefficients alternative model
nox~...+s(equi)+s(equi):comp, use:

> data(nox)
> sE<-bbase(nox$equi, bdeg=3, nint=10)
> sEbyC<-model.matrix(~0+sE:factor(comp), data=nox)[,]
> gt(nox~equi*factor(comp), alternative=cbind(sE,sEbyC), data=nox)

p-value Statistic Expected Std.dev #Cov
78

0.465

1.28

1 2.14e-25

13

4.4.3 Missed interactions

Consider the boston data for 506 census tracts of Boston from the 1970 census. Sup-
pose we want to predict the price of a house based on various attributes like number of

64

lonlatfittedrooms, distance to employment, and neighborhood type. These covariates may inter-
act, e.g. the number of rooms might not be as important if the neighborhood has lots
of crime. For checking whether any two-way linear interaction effect has been missed,
use:

> library(MASS)
> data(Boston)
> res<-gtLI(medv~., data=Boston)
> res@result

p-value Statistic Expected

[1,] 0.5643558 0.09486494 0.203252 0.2410747

Std.dev #Cov
78

> round(weights(res)/sum(weights(res)),4)

crim:zn
0.0000
crim:age
0.0000
crim:black
0.0166
zn:rm
0.0000
zn:ptratio
0.0000
indus:rm
0.0000
indus:ptratio
0.0000
chas:age
0.0000
chas:black
0.0000
nox:rad
0.0000
rm:age
0.0000
rm:black
0.0000
age:ptratio
0.0000
dis:ptratio
0.0000
rad:black
0.0037

crim:indus
0.0000
crim:dis
0.0000
crim:lstat
0.0000
zn:age
0.0012
zn:black
0.0010
indus:age
0.0001
indus:black
0.0005
chas:dis
0.0000
chas:lstat
0.0000
nox:tax
0.0000
rm:dis
0.0000
rm:lstat
0.0000
age:black
0.0120
dis:black
0.0000
rad:lstat
0.0000
ptratio:black ptratio:lstat
0.0000

0.0002

crim:nox
0.0000
crim:tax
0.0001
zn:chas
0.0000
zn:rad
0.0000
indus:chas
0.0000
indus:rad
0.0000
chas:nox
0.0000
chas:tax
0.0000
nox:age
0.0000
nox:black
0.0000
rm:tax
0.0001
age:rad
0.0002
dis:rad
0.0000
rad:tax
0.0029
tax:black
0.8267

crim:rm
0.0000
crim:ptratio
0.0000
zn:nox
0.0000
zn:tax
0.0252
indus:nox
0.0000
indus:tax
0.0056
chas:rm
0.0000
chas:ptratio
0.0000
nox:dis
0.0000
nox:lstat
0.0000
rm:ptratio
0.0000
age:tax
0.0879
dis:tax
0.0003
rad:ptratio
0.0000
tax:lstat
0.0112

crim:chas
0.0000
crim:rad
0.0000
zn:indus
0.0000
zn:dis
0.0000
zn:lstat
0.0001
indus:dis
0.0000
indus:lstat
0.0000
chas:rad
0.0000
nox:rm
0.0000
nox:ptratio
0.0000
rm:rad
0.0000
age:dis
0.0000
age:lstat
0.0002
dis:lstat
0.0000
tax:ptratio
0.0002
black:lstat
0.0035

65

To prevent very unbalanced interaction terms contributions in the test statistic, we rec-
ommend to rescale the covariates to unit standard deviation by standardize=TRUE
or to center and scale the data:

> gtLI(medv~., data=Boston, standardize=T)

p-value Statistic Expected Std.dev #Cov
78

0.0985

0.203

1.52

1 2.95e-07

> gtLI(medv~., data=scale(Boston))

p-value Statistic Expected Std.dev #Cov
78

0.0763

0.203

1 3.8e-41

4.06

4.5 Non-proportional hazards

Different extensions of the Cox model have been proposed to deal with non-
proportional hazards. One possibility is the addition of an interaction term of the co-
variates with a time function, leading to time-varying effects of the covariates. This
allows the effect of the covariates to change over time, such as the effect of a treatment
that might wash away. However, time-varying covariates are not yet implemented in
the function gt (but are likely to be in the future).

66

Bibliography

Beer, D. G., Kardia, S. L. R., Huang, C. C., Giordano, T. J., Levin, A. M., Misek,
D. E., Lin, L., Chen, G. A., Gharib, T. G., Thomas, D. G., Lizyness, M. L., Kuick,
R., Hayasaka, S., Taylor, J. M. G., Iannettoni, M. D., Orringer, M. B., and Hanash,
S. (2002). Gene-expression profiles predict survival of patients with lung adenocar-
cinoma. Nature Medicine, 8(8):816–824.

Benjamini, Y. and Hochberg, Y. (1995). Controlling the false discovery rate: a practical
and powerful approach to multiple testing. Journal of the Royal Statistical Society
Series B-Methodological, 57(1):289–300.

Benjamini, Y. and Yekutieli, D. (2001). The control of the false discovery rate in

multiple testing under dependency. Annals of Statistics, 29(4):1165–1188.

Eilers, P. H. C. and Marx, B. D. (1996). Flexible smoothing with b-splines and penal-

ties. Statistical Science, 11(2):89–102.

Goeman, J. and Bühlmann, P. (2007). Alalyzing gene expression data in terms of gene

sets: methodological issues. Bioinformatics, 23(8):980–987.

Goeman, J. and Finos, L. (2012). The inheritance procedure: multiple testing of tree-
structured hypotheses. Statistical Applications in Genetics and Molecular Biology,
11(1):1–18.

Goeman, J., van Houwelingen, H., and Finos, L. (2011). Testing against a high-
dimensional alternative in the generalized linear model: asymptotic type i error con-
trol. Biometrika, 98(2):381–390.

Goeman, J. J. and Mansmann, U. (2008). Multiple testing on the directed acyclic graph

of gene ontology. Bioinformatics, 24(4):537–544.

Goeman, J. J., Oosting, J., Cleton-Jansen, A. M., Anninga, J. K., and van Houwelingen,
J. C. (2005). Testing association of a pathway with survival using gene expression
data. Bioinformatics, 21(9):1950–1957.

Goeman, J. J., van de Geer, S. A., de Kort, F., and van Houwelingen, J. C. (2004). A
global test for groups of genes: testing association with a clinical outcome. Bioin-
formatics, 20(1):93–99.

67

Goeman, J. J., van de Geer, S. A., and van Houwelingen, J. C. (2006). Testing against
a high-dimensional alternative. Journal of the Royal Statistical Society Series B-
Statistical Methodology, 68(3):477–493.

Golub, T. R., Slonim, D. K., Tamayo, P., Huard, C., Gaasenbeek, M., Mesirov, J. P.,
Coller, H., Loh, M. L., Downing, J. R., Caligiuri, M. A., Bloomfield, C. D., and
Lander, E. S. (1999). Molecular classification of cancer: Class discovery and class
prediction by gene expression monitoring. Science, 286(5439):531–537.

Holm, S. (1979). A simple sequentially rejective multiple test procedure. Scandinavian

Journal of Statistics, 6:65–70.

Jelier, R., Goeman, J., Hettne, K., Schuemie, M., den Dunnen, J., and AC’t Hoen, P.
(2011). Literature-aided interpretation of gene expression data with the weighted
global test. Briefings in bioinformatics, 12(5):518–529.

Mantel, N., Bohidar, N. R., and Ciminera, J. L. (1977). Mantel-haenszel analyses of
litter-matched time-to-response data, with modifications for recovery of interlitter
information. Cancer Research, 37(11):3863–3868.

Meinshausen, N. (2008). Hierarchical testing of variable importance. Biometrika,

95(2):265–278.

68

