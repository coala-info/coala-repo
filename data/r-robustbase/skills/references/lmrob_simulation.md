Simulations for Sharpening Wald-type Inference in Robust
Regression for Small Samples

Manuel Koller

February 4, 2026

Contents

1 Introduction

2 Setting

2.1 Methods . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Psi-Functions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Designs
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Error Distributions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.5 Covariance Matrix Estimators . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Simulation

4 Simulation Results

4.1 Criteria . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Results . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Maximum Asymptotic Bias

6 Session Information

1

Introduction

1

1
1
2
2
3
4

5

7
7
8

20

20

In this vignette, we recreate the simulation study of Koller and Stahel (2011). This vignette is
supposed to complement the results presented in the above cited reference and render its results
reproducible. Another goal is to provide simulation functions, that, with small changes, could
also be used for other simulation studies.

Additionally, in Section 5, we calculate the maximum asymptotic bias curves of the ψ-

functions used in the simulation.

2 Setting

The simulation setting used here is similar to the one in Maronna and Yohai (2010). We simulate
N = 1000 repetitions. To repeat the simulation, we recommend using a small value of N here,
since for large n and p, computing all the replicates will take days.

2.1 Methods

We compare the methods

1

• MM, SMD, SMDM as described in Koller and Stahel (2011). These methods are available

in the package robustbase (lmrob).

• MM as implemented in the package robust (lmRob). This method will be denoted as

MMrobust later on.

• MM using S-scale correction by qT and qE as proposed by Maronna and Yohai (2010).

qT and qE are deﬁned as follows.

qE =

1
1 − (1.29 − 6.02/n)p/n

,

ˆqT = 1 +

p
2n

ˆa
ˆbˆc

,

where

ˆa =

1
n

n

Xi=1

2

ψ

ri
ˆσS (cid:19)

(cid:18)

, ˆb =

1
n

n

Xi=1

′

ψ

ri
ˆσS (cid:19)

(cid:18)

, ˆc =

1
n

n

Xi=1

ψ

ri
ˆσS (cid:19)

ri
ˆσS

,

(cid:18)

with ψ = ρ′,n the number of observations, p the number of predictor variables, ˆσS is the
S-scale estimate and ri is the residual of the i-th observation.

When using qE it is necessary to adjust the tuning constants of χ to account for the
dependence of κ on p. For qT no change is required.

This method is implemented as lmrob.mar() in the source ﬁle estimating.functions.R.

2.2 ψ-Functions

We compare bisquare, optimal, lqq and Hampel ψ-functions. They are illustrated in Fig. 1.
The tuning constants used in the simulation are compiled in Table 1. Note that the Hampel
ψ-function is tuned to have a downward slope of −1/3 instead of the originally proposed −1/2.
This was set to allow for a comparison to an even slower descending ψ-function.

psi
optimal
bisquare
lqq
hampel

tuning.chi
0.405
1.548

tuning.psi
1.06
4.685
−0.5, 1.5, NA, 0.5 −0.5, 1.5, 0.95, NA
1.352, 3.156, 7.213

0.318, 0.742, 1.695

Table 1: Tuning constants of ψ-functions used in the simulation.

2.3 Designs

Two types of designs are used in the simulation: ﬁxed and random designs. One design with
n = 20 observations, p = 1+3 predictors and strong leverage points. This design also includes an
intercept column. It is shown in Fig. 21. The other designs are random, i.e., regenerated for every
repetition, and the models are ﬁtted without an intercept. We use the same distribution to gen-
erate the designs as for the errors. The number of observations simulated are n = 25, 50, 100, 400
and the ratio to the number of parameters are p/n = 1/20, 1/10, 1/5, 1/3, 1/2. We round p to
the nearest smaller integer if necessary.

The random datasets are generated using the following code.

> f.gen <- function(n, p, rep, err) {
+
+

## get function name and parameters
lerrfun <- f.errname(err$err)

2

2.0

1.5

)
x
(
ψ

1.0

0.5

0.0

ψ −function

bisquare

hampel

lqq

optimal

0.0

2.5

5.0
x

7.5

10.0

Figure 1: ψ-functions used in the simulation.

lerrpar <- err$args
## generate random predictors
ret <- replicate(rep, matrix(do.call(lerrfun, c(n = n*p, lerrpar)),

n, p), simplify=FALSE)

attr(ret[[1]], 'gen') <- f.gen
ret

+
+
+
+
+
+
+ }
> ratios <- c(1/20, 1/10, 1/5, 1/3, 1/2)## p/n
> lsit <- expand.grid(n = c(25, 50, 100, 400), p = ratios)
> lsit <- within(lsit, p <- as.integer(n*p))
> .errs.normal.1 <- list(err = 'normal',
+
> for (i in 1:NROW(lsit))
+
+

assign(paste('rand',lsit[i,1],lsit[i,2],sep='_'),

args = list(mean = 0, sd = 1))

f.gen(lsit[i,1], lsit[i,2], rep = 1, err = .errs.normal.1)[[1]])

An example design is shown in Fig. 2.

2.4 Error Distributions

We simulate the following error distributions

• standard normal distribution,

• t5, t3, t1,

• centered skewed t with df = ∞, 5 and γ = 2 (denoted by cskt(∞, 2) and cskt(5, 2), respec-

tively); as introduced by Fern´andez and Steel (1998) using the R package skewt,

3

rand_25_5: n=25, p=5

X1

X2

Corr:
−0.520**

0.4
0.3
0.2
0.1
0.0
2
1
0
−1
−2

1

0

−1

2
1
0
−1
−2

1
0
−1
−2
−3

X3

Corr:
0.219

Corr:
−0.062

X4

Corr:
0.190

Corr:
−0.311

Corr:
−0.026

X5

Corr:
−0.083

Corr:
0.171

Corr:
−0.134

Corr:
−0.169

X
1

X
2

X
3

X
4

X
5

−2 −1

0

1

−2 −1

0

1

2

−1

0

1

−2 −1 0

1

2

−3 −2 −1

0

1

Figure 2: Example random design.

• contaminated normal, N (0, 1) contaminated with 10% N (0, 10) (symmetric, cnorm(0.1, 0, 3.16))

or N (4, 1) (asymmetric, cnorm(0.1, 4, 1)).

2.5 Covariance Matrix Estimators

For the standard MM estimator, we compare Avar1 of Croux et al. (2003) and the empirical
weighted covariance matrix estimate corrected by Huber’s small sample correction as described
in Huber and Ronchetti (2009) (denoted by Wssc). The latter is also used for the variation of
the MM estimate proposed by Maronna and Yohai (2010). For the SMD and SMDM variants
we use the covariance matrix estimate as described in Koller and Stahel (2011) (Wτ ).

The covariance matrix estimate consists of three parts:

The SMD and SMDM methods of lmrob use the following defaults.

cov( ˆβ) = σ

2

γV −1
X .

ˆγ =

1
n

P
1
n

n

i=1 τ 2
i ψ
i=1 ψ′

n

ri
τi ˆσ

ri
τi ˆσ

(cid:16)

(cid:16)

(cid:17)

2

(cid:17)

(1)

P
where τi is the rescaling factor used for the D-scale estimate (see Koller and Stahel (2011)).
Remark: Equation (1) is a corrected version of γ. It was changed in robustbase version 0.91
(April 2014) to ensure that the equation reduces to 1 in the classical case (ψ(x) = x). If the
former (incorrect) version is needed for compatibility reasons, it can be obtained by adding the
argument cov.corrfact = "tauold".

1
n
i=1 wii

X T W X

V X =

b

1
n

P

4

where W = diag
weights.

w

r1
ˆσ

(cid:0)

(cid:0)

(cid:1)

, . . . , w

rn
ˆσ

(cid:0)

(cid:1)(cid:1)

. The function w(r) = ψ(r)/r produces the robustness

3 Simulation

The main loop of the simulation is fairly simple. (This code is only run if there are no aggregate
results available.)

> aggrResultsFile <- file.path(robustDta, "aggr_results.Rdata")

## load packages required only for simulation
stopifnot(require(robust),

registerDoSEQ() ## no not use parallel processing

stopifnot(require(doParallel))
if (.Platform$OS.type == "windows") {

cl <- makeCluster(getOption("cores"))
clusterExport(cl, c("N", "robustDoc"))
clusterEvalQ(cl, slave <- TRUE)
clusterEvalQ(cl, source(file.path(robustDoc, 'simulation.init.R')))
registerDoParallel(cl)

}

else {

} else registerDoParallel()

if (!is.null(getOption("cores"))) {
if (getOption("cores") == 1)

require(skewt),
require(foreach))

> if (!file.exists(aggrResultsFile)) {
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

filename <- file.path(robustDta,

if (!file.exists(filename)) {

}

5

} else registerDoSEQ() ## no not use parallel processing
for (design in c("dd", ls(pattern = 'rand_\\d+_\\d+'))) {

print(design)
## set design
estlist$design <- get(design)
estlist$use.intercept <- !grepl('^rand', design)
## add design.predict: pc
estlist$design.predict <-

if (is.null(attr(estlist$design, 'gen')))
f.prediction.points(estlist$design) else

f.prediction.points(estlist$design, max.pc = 2)

sprintf('r.test.final.%s.Rdata',design))

## run
print(system.time(r.test <- f.sim(estlist, silent = TRUE)))
## save
save(r.test, file=filename)
## delete output
rm(r.test)
## run garbage collection
gc()

}

+
+ }

The variable estlist is a list containing all the necessary settings required to run the

simulation as outlined above. Most of its elements are self-explanatory.

> str(estlist, 1)

List of 8
$ design
$ nrep
$ errs
$ seed
$ procedures
$ design.predict:'data.frame':
..- attr(*, "npcs")= int 3

:'data.frame':
: num 1000
:List of 8
: num 13082010
:List of 21

$ output
$ use.intercept : logi TRUE

:List of 6

20 obs. of 3 variables:

10 obs. of 3 variables:

errs is a list containing all the error distributions to be simulated. The entry for the standard

normal looks as follows.

> estlist$errs[[1]]

$err
[1] "normal"

$args
$args$mean
[1] 0

$args$sd
[1] 1

err is translated internally to the corresponding random generation or quantile function, e.g.,
in this case rnorm or qnorm. args is a list containing all the required arguments to call the
function. The errors are then generated internally with the following call.

> set.seed(estlist$seed)
> errs <- c(sapply(1:nrep, function(x) do.call(fun, c(n = nobs, args))))

All required random numbers are generated at once instead of during the simulation. Like this,
it is certain, that all the compared methods run on exactly the same data.

The entry procedures follows a similar convention. design.predict contains the de-
sign used for the prediction of observations and calculation of conﬁdence or prediction inter-
vals. The objects returned by the procedures are processed by the functions contained in the
estlist$output list.

> str(estlist$output[1:3], 2)

List of 3

$ sigma:List of 2

..$ names: chr "sigma"
..$ fun : language sigma(lrr)

$ beta :List of 2

6

..$ names: language paste("beta", 1:npar, sep = "_")
..$ fun : language coef(lrr)

$ se

:List of 2

..$ names: language paste("se", 1:npar, sep = "_")
..$ fun : language sqrt(diag(covariance.matrix(lrr)))

The results are stored in a 4-dimensional array. The dimensions are: repetition number, type
of value, procedure id, error id. Using apply it is very easy and fast to generate summary
statistics. The raw results are stored on the hard disk, because typically it takes much longer to
execute all the procedures than to calculate the summary statistics. The variables saved take
up a lot of space quite quickly, so only the necessary data is stored. These are σ, β as well as
the corresponding standard errors.

To speed up the simulation routine f.sim, the simulations are carried out in parallel, as long
as this is possible. This is accomplished with the help of the R-package foreach. This is most
easily done on a machine with multiple processors or cores. The multicore package provides
the methods to do so easily. The worker processes are just forked from the main R process.

After all the methods have been simulated, the simulation output is processed. The code is
quite lengthy and thus not displayed here (check the Sweave source ﬁle lmrob simulation.Rnw).
The residuals, robustness weights, leverages and τ values have to be recalculated. Using vec-
torized operations and some specialized C code, this is quite cheap. The summary statistics
generated are discussed in the next section.

4 Simulation Results

4.1 Criteria

The simulated methods are compared using the following criteria.

Scale estimates. The criteria for scale estimates are all calculated on the log-scale. The
bias of the estimators is measured by the 10% trimmed mean. To recover a meaningful scale, the
results are exponentiated before plotting. It is easy to see that this is equivalent to calculating
geometric means. Since the methods are all tuned at the central model, N (0, 1), a meaningful
comparison of biases can only be made for N (0, 1) distributed errors.

The variability of the estimators, on the other hand, can be compared over all simulated
It is measured by the 10% trimmed standard deviation, rescaled by the

error distributions.
square root of the number of observations.

For completeness, the statistics used to compare scale estimates in Maronna and Yohai (2010)

are also calculated. They are deﬁned as

q = median

S(e)
ˆσS (cid:19)

(cid:18)

, M = mad

S(e)
ˆσS (cid:19)

,

(cid:18)

(2)

where S(e) stands for the S-scale estimate evaluated for the actual errors e. For the D-scale
estimate, the deﬁnition is analogue. Since there is no design to correct for, we set τi = 1 ∀i.

Coeﬃcients. The eﬃciency of estimated regression coeﬃcients ˆβ is characterized by their
mean squared error (MSE ). Since we simulate under H0 : β = 0, this is determined by the
p
covariance matrix of ˆβ. We use E
j=1 var( ˆβj) as a summary. When comparing to
P
the MSE of the ordinary least squares estimate (OLS ), this gives the eﬃciency, which, by the
choice of tuning constants of ψ, should yield

∥ ˆβ∥2
2

=

h

i

MSE( ˆβOLS)
MSE( ˆβ)

≈ 0.95

j=1 var( ˆβj) is calculated
for standard normally distributed errors. The simulation mean of
with 10% trimming. For other error distributions, this ratio should be larger than 1, since by

p

P

7

using robust procedures we expect to gain eﬃciency at other error distributions (relative to the
least squares estimate).

γ. We compare the behavior of the various estimators of γ by calculating the trimmed mean

and the trimmed standard deviation for standard normal distributed errors.

Covariance matrix estimate. The covariance matrix estimates are compared indirectly
over the performance of the resulting test statistics. We compare the empirical level of the
hypothesis tests H0 : βj = 0 for some j ∈ {1, . . . , p}. The power of the tests is compared by
testing for H0 : βj = b for several values of b > 0. The formal power of a more liberal test is
generally higher. Therefore, in order for this comparison to be meaningful, the critical value for
each test statistic was corrected such that all tests have the same simulated level of 5%.

The simple hypothesis tests give only limited insights. To investigate the eﬀects of other
error distributions, e.g., asymmetric error distributions, we compare the conﬁdence intervals for
the prediction of some ﬁxed points. Since it was not clear how to assess the quality prediction
intervals, either at the central or the simulated model, we do not calculate them here.

A small number of prediction points is already enough, if they are chosen properly. We chose
to use seven points lying on the ﬁrst two principal components, spaced evenly from the center of
the design used to the extended range of the design. The principal components were calculated
robustly (using covMcd of the robustbase package) and the range was extended by a fraction
of 0.5. An example is shown in Figure 21.

4.2 Results

The results are given here as plots (Fig. 3 to Fig. 22). For a complete discussion of the results,
we refer to Koller and Stahel (2011).

The diﬀerent ψ-functions are each plotted in a diﬀerent facet, except for Fig. 8, Fig. 9 and
Fig. 15, where the facets show the results for various error distributions. The plots are augmented
with auxiliary lines to ease the comparison of the methods. The lines connect the median values
over the values of n for each simulated ratio p/n. In many plots the y-axis has been truncated.
Points in the grey shaded area represent truncated values using a diﬀerent scale.

8

optimal

bisquare

lqq

Hampel

Scale Est.

σ^
S
σ^
D
qTσ^
S
qEσ^
S
σ^

robust

25

50

100

400

n

)
σ^
(
n
a
e
m

c
i
r
t
e
m
o
e
g

1.0

0.9

0.8

0.7

1.0

0.9

0.8

0.7

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

ratio

Figure 3: Mean of scale estimates for normal errors. The mean is calculated with 10% trimming.
The lines connect the median values for each simulated ratio p/n. Results for random designs
only.

optimal

bisquare

n

)
)
σ^
(
g
o
l
(
d
s

2.5

2.0

1.5

1.0

2.5

2.0

1.5

1.0

lqq

Hampel

n

25

50

100

400

Scale Est.

σ^
D
σ^

OLS

σ^
S
qEσ^
S
qTσ^
σ^

S

robust

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

ratio

Figure 4: Variability of the scale estimates for normal errors. The standard deviation is calcu-
lated with 10% trimming.

9

n

)
)
σ^
(
g
o
l
(
d
s

2.5

2.0

1.5

1.0

2.5

2.0

1.5

1.0

q

1.4

1.2

1.0

1.4

1.2

1.0

optimal

bisquare

Scale Est.

σ^

σ^

D

OLS

S

σ^
S
qEσ^
qTσ^
S
σ^

robust

lqq

Hampel

Error

N(0,1)

t5

t3

t1
cskt(∞, 2)

cskt(5,2)

cnorm(0.1,0,3.16)

cnorm(0.1,4,1)

0.1

0.2

0.3

0.4

0.5
ratio

0.1

0.2

0.3

0.4

0.5

Figure 5: Variability of the scale estimates for all simulated error distributions.

optimal

bisquare

lqq

Hampel

n

25

50

100

400

Scale Est.

σ^
D
qEσ^
S

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

ratio

Figure 6: q statistic for normal errors. q is deﬁned in (2).

10

q

M

0.40

0.20
0.14
0.10
0.07
0.05

0.03
0.02

0.01

0.40

0.20
0.14
0.10
0.07
0.05

0.03
0.02

0.01

1.2

1.0

0.9

0.8

1.2

q

1.0

0.9

0.8

1.2

1.0

0.9

0.8

optimal

bisquare

lqq

Hampel

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

ratio

Figure 7: M/q statistic for normal errors. M and q are deﬁned in (2).

N(0,1)

t5

t3

t1

cskt(Inf,2)

cskt(5,2)

cnorm(0.1,0,3.16)

cnorm(0.1,4,1)

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3
ratio

0.4

0.5

Figure 8: q statistic for bisquare ψ.

11

n

25

50

100

400

Scale Est.

σ^
D
qEσ^
S

Scale Est.

n

25

50

100

400

q

M

0.40
0.20
0.14
0.10
0.07
0.05
0.03
0.02
0.01

0.40
0.20
0.14
0.10
0.07
0.05
0.03
0.02
0.01

0.40
0.20
0.14
0.10
0.07
0.05
0.03
0.02
0.01

N(0,1)

t5

t3

t1

cskt(Inf,2)

cskt(5,2)

cnorm(0.1,0,3.16)

cnorm(0.1,4,1)

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3
ratio

0.4

0.5

Figure 9: M/q statistic for bisquare ψ.

Scale Est.

n

25

50

100

400

12

optimal

bisquare

lqq

Hampel

1.0

0.8

0.6

1.0

0.8

0.6

β^

f
o

y
c
n
e
c
i
f
f
e

i

n

25

50

100

400

Estimator

MM

SMD

SMDM
MM  qT
MM  qE

MMrobust

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

p/n

Figure 10: Eﬃciency for normal errors. The eﬃciency is calculated by comparing to an OLS
estimate and averaging with 10% trimming.

optimal

bisquare

β^

f
o

y
c
n
e
c
i
f
f
e

i

2

1

2

1

lqq

Hampel

Error

N(0,1)

t5

t3
cskt(∞, 2)

cskt(5,2)

cnorm(0.1,0,3.16)

cnorm(0.1,4,1)

Estimator

MM

SMD

SMDM
MM  qT
MM  qE

MMrobust

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

p/n

Figure 11: Eﬃciency for all simulated error distributions except t1.

13

optimal

bisquare

Estimator

SMD

SMDM

lqq

Hampel

n

25

50

100

400

)
γ^
(
n
a
e
m

1.2

1.0

0.9

0.8

1.2

1.0

0.9

0.8

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

p/n

Figure 12: Comparing the estimates of γ. The solid line connects the uncorrected estimate,
dotted the τ corrected estimate and dashed Huber’s small sample correction.

optimal

bisquare

0.20
0.14
0.10
0.07
0.05

0.03
0.02

0.01

0.20
0.14
0.10
0.07
0.05

0.03
0.02

0.01

)
γ^
(
d
s

Estimator

SMD

SMDM

lqq

Hampel

n

25

50

100

400

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

p/n

Figure 13: Comparing the estimates of γ. The solid line connects the uncorrected estimate,
dotted the τ corrected estimate and dashed Huber’s small sample correction.

14

optimal

bisquare

lqq

Hampel

Estimator

MMrobust.Wssc
MM. Avar1

MM.Wssc
SMD.W τ
SMDM.W τ
MM  qT.Wssc
MM  qE.Wssc

n

25

50

100

400

0
=

1

β
:

0
H

l

e
v
e

l

l

a
c
i
r
i
p
m
e

0.14

0.10

0.07

0.05

0.03

0.02

0.14

0.10

0.07

0.05

0.03

0.02

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.3

0.4

0.5

p/n

Figure 14: Empirical levels of test H0 : β1 = 0 for normal errors. The y-values are truncated at
0.02 and 0.14.

N(0,1)

t5

t3

0
=

1

β
:

0
H

l

e
v
e

l

l

a
c
i
r
i
p
m
e

0.14
0.10
0.07
0.05

0.03

0.14
0.10
0.07
0.05

0.03

0.14
0.10
0.07
0.05

0.03

t1

cskt(Inf,2)

cskt(5,2)

cnorm(0.1,0,3.16)

cnorm(0.1,4,1)

0.1

0.2

0.3

0.4

0.5

Estimator

MM. Avar1

MM.Wssc
SMD.W τ
SMDM.W τ

n

25

50

100

400

0.1

0.2

0.3

0.4

0.5

0.1

0.2

0.4

0.5

0.3
p/n

Figure 15: Empirical levels of test H0 : β1 = 0 for lqq ψ-function and diﬀerent error distributions.

15

optimal

bisquare

lqq

Hampel

Estimator (Cov. Est.)

MM. Avar1

MM.Wssc
MM  qE.Wssc
MM  qT.Wssc

MMrobust.Wssc

OLS
SMD.W τ
SMDM.W τ

0.175

0.150

0.125

0.100

0.075

0.175

0.150

0.125

0.100

0.075

2
.
0
=

1

β
:

0
H

r
e
w
o
p

l

a
c
i
r
i
p
m
e

0.1

0.2

0.3

0.4

0.5
p/n

0.1

0.2

0.3

0.4

0.5

Figure 16: Empirical power of test H0 : β1 = 0.2 for diﬀerent ψ-functions. Results for n = 25
and normal errors only.

optimal

bisquare

4
.
0
=

1

β
:

0
H

r
e
w
o
p

l

a
c
i
r
i
p
m
e

0.5

0.4

0.3

0.2

0.1

0.5

0.4

0.3

0.2

0.1

lqq

Hampel

Estimator (Cov. Est.)

MM. Avar1

MM.Wssc
MM  qE.Wssc
MM  qT.Wssc

MMrobust.Wssc

OLS
SMD.W τ
SMDM.W τ

0.1

0.2

0.3

0.4

0.5
p/n

0.1

0.2

0.3

0.4

0.5

Figure 17: Empirical power of test H0 : β1 = 0.4 for diﬀerent ψ-functions. Results for n = 25
and normal errors only.

16

optimal

bisquare

lqq

Hampel

Estimator (Cov. Est.)

MM. Avar1

MM.Wssc
MM  qE.Wssc
MM  qT.Wssc

MMrobust.Wssc

OLS
SMD.W τ
SMDM.W τ

0.8

0.6

0.4

0.2

0.8

0.6

0.4

0.2

6
.
0
=

1

β
:

0
H

r
e
w
o
p

l

a
c
i
r
i
p
m
e

0.1

0.2

0.3

0.4

0.5
p/n

0.1

0.2

0.3

0.4

0.5

Figure 18: Empirical power of test H0 : β1 = 0.6 for diﬀerent ψ-functions. Results for n = 25
and normal errors only.

optimal

bisquare

8
.
0
=

1

β
:

0
H

r
e
w
o
p

l

a
c
i
r
i
p
m
e

0.8

0.6

0.4

0.2

0.8

0.6

0.4

0.2

lqq

Hampel

Estimator (Cov. Est.)

MM. Avar1

MM.Wssc
MM  qE.Wssc
MM  qT.Wssc

MMrobust.Wssc

OLS
SMD.W τ
SMDM.W τ

0.1

0.2

0.3

0.4

0.5
p/n

0.1

0.2

0.3

0.4

0.5

Figure 19: Empirical power of test H0 : β1 = 0.8 for diﬀerent ψ-functions. Results for n = 25
and normal errors only.

17

optimal

bisquare

lqq

Hampel

Estimator (Cov. Est.)

MM. Avar1

MM.Wssc
MM  qE.Wssc
MM  qT.Wssc

MMrobust.Wssc

OLS
SMD.W τ
SMDM.W τ

1.0

0.8

0.6

0.4

1.0

0.8

0.6

0.4

1
=

1

β
:

0
H

r
e
w
o
p

l

a
c
i
r
i
p
m
e

0.1

0.2

0.3

0.4

0.5
p/n

0.1

0.2

0.3

0.4

0.5

Figure 20: Empirical power of test H0 : β1 = 1 for diﬀerent ψ-functions. Results for n = 25 and
normal errors only.

X1

X2

Corr:
0.970***

0.3

0.2

0.1

0.0
10

5

0

−5

10.0

7.5

5.0

2.5

0.0

X3

Corr:
0.160

Corr:
0.187

X
1

X
2

X
3

−2

−1

0

1

2

−5

0

5

10 0.0

2.5

5.0

7.5

10.0

Figure 21: Prediction points for ﬁxed design. The black points are the points of the original
design. The red digits indicate the numbers and locations of the points where predictions are
taken.

18

NA

optimal

bisquare

Estimator (Cov. Est.)

l

s
a
v
r
e
t
n

i

e
c
n
e
d
i
f
n
o
c

f
o

l

e
v
e

l

l

a
c
i
r
i
p
m
e

0.14

0.10

0.07

0.05

0.03

0.14

0.10

0.07

0.05

0.03

lqq

Hampel

2

4

6

2

4

6

2

4
Point

6

OLS

MMrobust.Wssc
MM. Avar1

MM.Wssc
SMD.W τ
SMDM.W τ
MM  qT.Wssc
MM  qE.Wssc

Error

N(0,1)

t5

t3

t1
cskt(∞, 2)

cskt(5,2)

cnorm(0.1,0,3.16)

cnorm(0.1,4,1)

Figure 22: Empirical coverage probabilities. Results for ﬁxed design. The y-values are truncated
at 0.14.

19

5 Maximum Asymptotic Bias

The slower redescending ψ-functions come with higher asymptotic bias as illustrated in Fig. 23.
We calculate the asymptotic bias as in Berrendero et al. (2007).

10

9

8

7

6

5

4

3

2

1

s
d
n
u
o
b

s
a
b

i

c
i
t
o
t
p
m
y
s
a
m
u
m
x
a
m

i

0.0

ψ −function

Hampel

lqq

bisquare

optimal

0.3

0.1

0.2

amount of contamination  ε

Figure 23: Maximum asymptotic bias bound for the ψ-functions used in the simulation. Solid
line: lower bound. Dashed line: upper bound.

6 Session Information

> toLatex(sessionInfo())

• R version 4.5.2 Patched (2026-01-31 r89375), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=de_CH.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=de_CH.UTF-8, LC_PAPER=de_CH.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=de_CH.UTF-8,
LC_IDENTIFICATION=C

• Time zone: Europe/Zurich

• TZcode source: system (glibc)

• Running under: Fedora Linux 42 (Adams)

• Matrix products: default

• BLAS: /sfs/u/maechler/R/D/r-patched/F42-64-inst/lib/libRblas.so

• LAPACK: /usr/lib64/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, grid, methods, stats, utils

20

• Other packages: GGally 2.4.0, ggplot2 4.0.2, reshape2 1.4.5, robustbase 0.99-7,

xtable 1.8-4

• Loaded via a namespace (and not attached): DEoptimR 1.1-4, R6 2.6.1,

RColorBrewer 1.1-3, Rcpp 1.1.1, S7 0.2.1, cli 3.6.5, compiler 4.5.2, dichromat 2.0-0.1,
dplyr 1.2.0, farver 2.1.2, generics 0.1.4, ggstats 0.12.0, glue 1.8.0, gtable 0.3.6,
labeling 0.4.3, lifecycle 1.0.5, magrittr 2.0.4, parallel 4.5.2, pillar 1.11.1, pkgconﬁg 2.0.3,
plyr 1.8.9, purrr 1.2.1, rlang 1.1.7, scales 1.4.0, stringi 1.8.7, stringr 1.6.0, tibble 3.3.1,
tidyr 1.3.2, tidyselect 1.2.1, tools 4.5.2, vctrs 0.7.1, withr 3.0.2

> unlist(packageDescription("robustbase")[c("Package", "Version", "Date")])

Package
"robustbase"

Version

Date
"0.99-7" "2026-02-03"

References

Berrendero, J., B. Mendes, and D. Tyler (2007). On the maximum bias functions of MM-

estimates and constrained M-estimates of regression. Annals of statistics 35 (1), 13.

Croux, C., G. Dhaene, and D. Hoorelbeke (2003). Robust standard errors for robust estimators.

Technical report, Dept. of Applied Economics, K.U. Leuven.

Fern´andez, C. and M. Steel (1998). On bayesian modeling of fat tails and skewness. Journal of

the American Statistical Association 93 (441), 359–371.

Huber, P. J. and E. M. Ronchetti (2009). Robust Statistics, Second Edition. NY: Wiley and

Sons Inc.

Koller, M. and W. A. Stahel (2011). Sharpening wald-type inference in robust regression for

small samples. Computational Statistics & Data Analysis 55 (8), 2504–2515.

Maronna, R. A. and V. J. Yohai (2010). Correcting MM estimates for ”fat” data sets. Compu-

tational Statistics & Data Analysis 54 (12), 3168–3173.

21

