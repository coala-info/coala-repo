Package ‘Icens’

February 13, 2026

Title NPMLE for Censored and Truncated Data

Description Many functions for computing the NPMLE for censored and

truncated data.

Version 1.82.0

Author R. Gentleman and Alain Vandal

Maintainer Bioconductor Package Maintainer
<maintainer@bioconductor.org>

Depends survival

Imports graphics

License Artistic-2.0

biocViews Infrastructure

RoxygenNote 7.2.3

git_url https://git.bioconductor.org/packages/Icens

git_branch RELEASE_3_22

git_last_commit 5f951fe

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.

.

.

.
.
Bisect
.
BVcliques .
.
BVclmat .
.
.
BVsupport .
.
.
.
cmv .
.
.
cosmesis .
.
.
EM .
.
.
.
EMICM .
.
.
.
.
hiv .
Icens-internal
.
icsurv .
.
ISDM .
.
Maclist

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

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12

1

2

Bisect

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.

22

An implementation of the bisection algorithm for root finding.

.

.

.
Macmat
.
MLEintvl
.
.
PGM .
plot.icsurv .
Plotboxes .
.
PMGA .
.
.
pruitt .
.
VEM .

.
.
.

Index

Bisect

Description

Most of the optimizations in Icens have a one dimensional root-finding component. Since the
quantities involved are generally restricted to a subset of [0,1] we use bisection to find the roots.

Usage

Bisect(tA, pvec, ndir, Meps, tolbis=1e-07)

Arguments

tA

pvec

ndir

Meps

tolbis

Details

The transpose of the clique matrix.

The current estimate of the probability vector.

The direction to explore.
Machine epsilon, elements of pvec that are less than this are assumed to be zero.

The tolerance used to determine if the algorithm has converged.

We search from pvec in the direction ndir to obtain the new value of pvec that maximizes the
likelihood.

Value

The new estimate of pvec.

Author(s)

Alain Vandal and Robert Gentleman.

References

Any book on optimization.

BVcliques

3

BVcliques

Find the bivariate cliques from the marginal data.

Description

The maximal cliques of the intersection graph are obtained by first finding the cliques for the
marginal data and then combining them using the algorithm in Gentleman and Vandal (1999).

Usage

BVcliques(intvlx, intvly, Lxopen=TRUE, Rxopen=FALSE,

Lyopen=TRUE, Ryopen=FALSE )

Arguments

intvlx

intvly

Lxopen

Rxopen

Lyopen

Ryopen

Value

The cliques for one marginal component, alternatively the marginal intervals can
be supplied.

The cliques for the other marginal component, alternatively the marginal inter-
vals can be supplied.

Boolean indicating whether the left end point in the x coordinate is open.

Boolean indicating whether the right end point in the x coordinate is open.

Boolean indicating whether the left end point in the y coordinate is open.

Boolean indicating whether the right end point in the y coordinate is open.

A list of the maximal cliques of the intersection graph of the data.

Author(s)

A. Vandal and R. Gentleman

References

Graph–Theoretical Aspects of Bivariate Censored Data, R. Gentleman and A. Vandal, 1999, sub-
mitted.

See Also

BVclmat, BVsupport

Examples

data(cmv)
cmv.cl <- BVcliques(cmv[,1:2], cmv[,3:4], Lxopen=FALSE, Lyopen=FALSE )

4

BVsupport

BVclmat

Compute the clique matrix from the clique list.

Description

Given the clique list, obtained from BVcliques, the clique matrix is obtained. This is the m (number
of cliques) by n (number of observations) matrix. A[i,j] is one if individual j is in maximal clique i.

Usage

BVclmat(cliques)

Arguments

cliques

Value

The clique list.

The m by n clique matrix.

Author(s)

A. Vandal and R. Gentleman

References

Graph–Theoretical Aspects of Bivariate Censored Data, R. Gentleman and A. Vandal, 1999, sub-
mitted.

See Also

BVcliques, BVsupport

Examples

data(cmv)
bcl <- BVcliques(cmv[,1:2], cmv[,3:4])
A <- BVclmat(bcl)

BVsupport

Compute the support for the cliques of a bivariate intersection graph.

Description

Given the regions where the events occurred and the cliques of the intersection graph the support
of the cliques is computed. For each clique it is the intersection of the event time regions for all
observations in that clique.

Usage

BVsupport(intvlx, intvly, cliques=BVcliques(intvlx, intvly))

cmv

Arguments

intvlx

intvly

cliques

Value

5

The event time intervals for one dimension.

The event time intervals for the other dimension.

The list of maximal cliques of the intersection graph, optionally.

An m by 4 matrix containing the corners of the intervals of support for the maximal cliques of the
intersection graph corresponding to the first two arguments to the function.

Author(s)

A. Vandal and R. Gentleman

References

Graph–Theoretical Aspects of Bivariate Censored Data, R. Gentleman and A. Vandal, 1999, sub-
mitted.

See Also

BVcliques, BVclmat

Examples

data(cmv)
cmv.cl <- BVcliques(cmv[,1:2], cmv[,3:4])
boxes <- BVsupport(cmv[,1:2], cmv[,3:4], cmv.cl)

Data on times to shedding of cytomegalovirus and to colonization of
mycobacterium avium complex.

cmv

Description

The cmv data frame has 204 rows and 4 columns. The intervals should be treated as closed at both
ends to replicate the analysis in Betensky and Finkelstein.

Format

This data frame contains the following columns:

cmvL The left end of the CMV shedding interval.

cmvR The right end of the CMV shedding interval.

macL The left end of the MAC colonization interval.

macR The right end of the MAC colonization interval.

6

Details

cosmesis

Betensky and Finkelstein, 1999 present data from the AIDS Clinical Trials Group protocol ACTG
181. This was a natural history substudy of a comparative trial. Patients were scheduled for
clinic visits during follow–up and data was collected on the time until two events; shedding of
cytomegalovirus (CMV) in the urine and blood and for colonization of mycobacterium avium com-
plex (MAC) in the sputum or stool.

Source

Betensky, R. A. and Finkelstein, D. M., 1999, A nonparametric maximum likelihood estimator for
bivariate interval censored data, Statistics in Medicine,

Examples

data(cmv)

cosmesis

The time taken until cosmetic deterioration of breast cosmesis.

Description

The cosmesis data frame has 95 rows and 3 columns.

Format

This data frame contains the following columns:

L The left end point of the cosmetic deterioration interval.

R The right end point of the cosmetic deterioration interval.

Trt The treatment indicator. It is zero for those that received radiotherapy.

Source

A semiparametric model for regression analysis of interval-censored failure time data, D. M. Finkel-
stein and R. A. Wolfe, 1985, Biometrics.

Examples

data(cosmesis)

7

A function to compute the NPMLE of p based on the incidence matrix
A.

EM

EM

Description

The incidence matrix, A is the m by n matrix that represents the data. There are m probabilities that
must be estimated. The EM, or expectation maximization, method is applied to these data.

Usage

EM(A, pvec, maxiter=500, tol=1e-12)

The incidence matrix.

The probability vector.

The maximum number of iterations.

The tolerance used to judge convergence.

Arguments

A

pvec

maxiter

tol

Details

Lots.

Value

An object of class icsurv containing the following components:

pf

numiter

converge

intmap

Author(s)

The NPMLE of the probability vector.

The number of iterations used.

A boolean indicating whether the algorithm converged.
If present indicates the real representation of the support for the values in pf.

Alain Vandal and Robert Gentleman.

References

The EM algorithm applied to the maximal cliques of the intersection graph of the censored data.
The empirical distribution function with arbitrarily grouped, censored and truncated data, B. W.
Turnbull, 1976, JRSS;B.

See Also

VEM, ISDM, EMICM, PGM

8

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset= Trt==0, select=c(L,R))
EM(csub1)
data(pruitt)
EM(pruitt)

EMICM

EMICM

Compute the NPMLE for censored data using the EMICM.

Description

An implementation of the hybrid EM ICM (Iterative convex minorant) estimator of the distribution
function proposed by Wellner and Zahn (1997).

Usage

EMICM(A, EMstep=TRUE, ICMstep=TRUE, keepiter=FALSE, tol=1e-07,
maxiter=1000)

Arguments

A

EMstep

ICMstep

keepiter

tol

maxiter

Either the m by n clique matrix or the n by 2 matrix containing the event time
intervals.

Boolean, indicating whether to take an EM step in the iteration.

Boolean, indicating whether to take an ICM step.

Boolean determining whether to keep the iteration states.

The maximal L1 distance between successive estimates before stopping itera-
tion.

The maximal number of iterations to perform before stopping.

Details

Lots, and they’re complicated too!

Value

An object of class icsurv containing the following components:

pf

sigma

weights

lastchange

numiter

iter

intmap

The estimated probabilities.

The NPMLE of the survival function on the maximal antichains.

The diagonal of the likelihood function’s second derivative.

A vector of differences between the last two iterations.

The total number of iterations performed.
Is only present if keepiter is true; states of sigma during the iteration.
The real representation associated with the probabilities reported in pf.

hiv

Author(s)

Alain Vandal and Robert Gentleman

References

9

A hybrid algorithm for computation of the nonparametric maximum likelihood estimator from cen-
sored data, J. A. Wellner and Y. Zhan, 1997, JASA.

See Also

EM,VEM, PGM

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
EMICM(csub1)
data(pruitt)
EMICM(pruitt)

hiv

Description

Intervals for infection time and disease onset for 257 hemophiliac
patients.

The hiv data frame has 257 rows and 4 columns.

Format

This data frame contains the following columns:

yL The left end point of the infection time interval.

yR The right end point of the infection time interval.

zL The left end point of the disease onset interval.

zR The right end point of the disease onset interval.

Age Coded as 1 if the estimated age at infection was less than 20 and 2 if the estimated age at

infection was greater than 20.

Trt Treatment, Light or Heavy

Details

The setting is as follows. Individuals were infected with the HIV virus at some unknown time they
subsequently develop AIDS at a second unknown time. The data consist of two intervals, (yL, yR)
and (zL, zR), such that the infection time was in the first interval and the time of disease onset
was in the second interval. A quantity of interest is the incubation time of the disease which is
T = Z − Y . The authors argue persuasively that this should be considered as bivariate interval
censored data. They note that simply forming the differences (zL − yR, zR − yL) and analysing
the resultant data assumes an incorrect likelihood. DeGruttola and Lagakos transform the problem
slightly to study the joint distribution of Y and T = Z − Y . This is equivalent to estimating the

10

icsurv

joint distribution of Z and Y then transforming. The data, as reported, have been discretized into
six month intervals.

We use the data as reported in Table 1 of DeGruttola and Lagakos, 1989. The patients were 257
persons with Type A or B hemophilia treated at two hospitals in France. They were then examined
intermittently (as they came in for treatment?) and their HIV and AIDS status was determined.
Kim, De Gruttola and Lagakos report some covariate information and their paper is concerned with
the modeling of that information. In this paper we concentrate only on the event times and ignore
the covariate information; that topic being worthy of separate investigation.

Source

DeGruttola, V. and Lagakos, S.W., 1989, Analysis of doubly-censored survival data, with applica-
tion to AIDS, Biometrics.
Kim, Mimi Y. and De Gruttola, Victor G. and Lagakos, Stephen W., 1993, Analyzing Doubly Cen-
sored Data With Covariates, With Application to AIDS, Biometrics.

Examples

data(hiv)

Icens-internal

Internal Icens functions

Description

Internal Icens functions

Details

These are not to be called by the user.

icsurv

Description

The class of objects returned by the estimation routines in the Icens
library.

An object of class icsurv must contain the following components:

converge A boolean indicating whether the iteration producing pf converged.
pf The probability vector.

It can optionally contain any of the following components:

clmat The clique matrix used to obtain pf.
intmap The real representations of the support for the components of pf.
iter A matrix containing every iterative estimate of pf, useful for debugging.
lval The value of the log likelihood at pf.
numiter The number of iterations taken.
sigma The cumulative sum of pf.
weights Weights used in the EMICM algorithm.

ISDM

Author(s)

Alain Vandal and Robert Gentleman.

See Also

VEM, ISDM, EMICM, PGM, EM

11

Estimate the NPMLE of censored data using the ISDM method pro-
posed in Lesperance and Kalbfleisch (19

ISDM

Description

ISDM is a method for estimating the NPMLE of censored data.

Usage

ISDM(A, pvec, maxiter=500, tol=1e-07, tolbis=1e-08, verbose=FALSE)

Arguments

A

pvec

maxiter

tol

tolbis

verbose

Details

The m by n incidence, or clique, matrix. Or the n by 2 matrix containing the
event intervals.

An initial estimate of the probability vector; not required.

Maximum number of iterations to be made.

The tolerance used to determine convergence.

A second tolerance used for the steps.

Boolean, should verbose output be printed.

Lots of complicated stuff should go here.

Value

A list containing:

pf

numiter

Author(s)

The estimated NPMLE of the probability vector.

The number of iterations performed.

Alain Vandal and Robert Gentleman

References

An Algorithm for Computing the Nonparametric MLE of a Mixing Distribution, Lesperance, Mary
L. and Kalbfleisch, John D., JASA, 1992

Maclist

12

See Also

VEM, EMICM, PGM

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
ISDM(csub1)
data(pruitt)
ISDM(pruitt)

#
#

Maclist

A function to

Description

Returns a list of maximal cliques of the intersection graph of the real valued intervals supplied in m.
These are one dimensional intervals with one interval for each individual. The algorithm is coded in
interpreted code and should be moved to compiled code for speed. How do we handle exact failure
times? Which algorithm is used?

Usage

Maclist(intvls, Lopen=TRUE, Ropen=FALSE)

Arguments

intvls

Lopen

Ropen

Value

A n by 2 matrix, the first column is the left endpoints and the second column
contains the right endpoints of the failure time intervals.

A boolean indicating whether the intervals are open on the left.

A boolean indicating whether the intervals are open on the right.

A list of length m. Each element of the list corresponds to one maximal antichain. The row numbers
(from m) identify the individuals and all row numbers for the individuals in the maximal clique.
Maximal cliques occur in their natural (left to right) order.

Author(s)

Alain Vandal and Robert Gentleman

References

Computational Methods for Censored Data using Intersection Graphs, R. Gentleman and A. Vandal,
JCGS, 2000.

See Also

Macmat

Macmat

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
ml1 <- Maclist(csub1)

13

Macmat

A function to compute the incidence matrix for an intersection graph.

Description

Returns the Petrie matrix and Petrie pairs of an interval order given its list of maximal antichains.
These can be obtained from Maclist.

Usage

Macmat(ml)

Arguments

ml

Details

A list containing the maximal cliques of the intersection graph of the data.

Not worth mentioning?

Value

A list containing two components.

pmat

ppairs

Author(s)

The Petrie or clique matrix of the underlying interval order.

The Petrie pairs for each observation. These indicate the first and last maximal
clique occupied by the observation.

Alain Vandal and Robert Gentleman

References

Computational Methods for Censored Data using Intersection Graphs, R. Gentleman and A. Vandal,
JCGS, 2000.

See Also

Maclist

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
ml1 <- Maclist(csub1)
mm1 <- Macmat(ml1)

14

MLEintvl

MLEintvl

Compute the real representation for the maximal cliques.

Description

The intervals on the real line that corresponds to the intersections of the maximal cliques are com-
puted and returned.

Usage

MLEintvl(intvls, ml=Maclist(intvls))

Arguments

intvls

The n by 2 matrix containing the event time intervals for the individuals under
study.

ml

The Maclist computed for the intvls.

Value

An m by 2 matrix, where m is the number of maximal cliques. The first column contains the left end
point of the real representation for the appropriate maximal clique and the second column contains
the right end point.

Author(s)

Alain Vandal and Robert Gentleman

References

Computational Methods for Censored Data using Intersection Graphs, R. Gentleman and A. Vandal,
JCGS, 2000.

See Also

Maclist

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
MLEintvl(csub1)

15

An implementation of the projected gradient methods for finding the
NPMLE.

PGM

PGM

Description

An estimate of the NPMLE is obtained by using projected gradient methods. This method is a
special case of the methods described in Wu (1978).

Usage

PGM(A, pvec, maxiter = 500, tol=1e-07, told=2e-05, tolbis=1e-08,

keepiter=FALSE)

Arguments

A

pvec

maxiter

tol

told

tolbis

keepiter

Details

A is either the m by n clique matrix or the n by 2 matrix containing the left and
right end points for each event time.

An initial estimate of the probability vector.

The maximum number of iterations to take.

The tolerance for decreases in likelihood.
told does not seem to be used.

The tolerance used in the bisection code.

A boolean indicating whether to return the number of iterations.

New directions are selected by the projected gradient method. The new optimal pvec is obtained
using the bisection algorithm, moving in the selected direction. Convergence requires both the L1
distance for the improved pvec and the change in likelihood to be below tol.

Value

An object of class icsurv containing the following components:

pf

sigma

lval

clmat

method

lastchange

numiter

eps

converge

iter

The NPMLE of pvec.
The cumulative sum of pvec.
The value of the log likelihood at pvec.

The clique matrix.

The method used, currently only "MPGM" is possible.
The difference between pf and the previous iterate.

The number of iterations carried out.

The tolerances used.
A boolean indicating whether convergence occurred within maxiter iterations.
If keepiter is true then this is a matrix containing all iterations - useful for
debugging.

16

Author(s)

Alain Vandal and Robert Gentleman.

References

plot.icsurv

Some Algorithmic Aspects of the Theory of Optimal Designs, C.–F. Wu, 1978, Annals.

See Also

VEM, ISDM, EMICM, PGM, EM

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
PGM(csub1)
data(pruitt)
PGM(pruitt)

plot.icsurv

A plot method for the estimates produced by the estimation methods
in Icens.

Description

Produces nice plots of the estimated NPMLE.

Usage

## S3 method for class 'icsurv'
plot(x, type="eq", surv=FALSE, bounds=FALSE, shade=3, density=30,
angle=45, lty=1, new=TRUE, xlab="Time", ylab="Probability", main="GMLE",
ltybnds=2, ...)

Arguments

x
type

surv
bounds
shade
density
angle
lty
new
xlab
ylab
main
ltybnds
...

The estimate of the NPMLE.
Three options, "eq" for equivalence call, "gw" for the Groeneboom-Wellner es-
timate, and "lc" for the left-continuous estimate.
Logical indicating whether or not to plot the survival curve.
Logical indicating whether or not to include bounds around the estimate.
An integer in 1, 2, or 3 denoting what component of the plot to shade.
The density of shading lines, in lines per inch.
The slope of shading lines, given as an angle in degrees (counter-clockwise).
The line type for the estimates.
Logical indicating whether or not to create a new plot.
The x-axis label.
The y-axis label.
The main title for the plot.
The line type for the bounds on the estimates.
Additional arguments passed to the plot function.

Plotboxes

Value

17

No value is returned. A plot of the NPMLE is made on the active graphics device.

Author(s)

Alain Vandal and Robert Gentleman.

See Also

VEM, ISDM, EMICM, PGM

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
e1 <- VEM(csub1)
par(mfrow=c(2,2))
plot(e1)
data(pruitt)
e2 <- EM(csub1)
plot(e2)
e3 <- PGM(csub1)
plot(e3)
e4 <- EMICM(csub1)
plot(e4)

Plotboxes

Plot the event time regions for bivariate data.

Description

Plot rectangles described by the interval given in the first two arguments.

Usage

Plotboxes(int1, int2, textp=FALSE, showmac=FALSE, showsupp=FALSE, showmp=FALSE,
cliques=NULL, macprod=NULL, density=c(2, 8, 20), col=c(2, 3, 4),
offsetx=0.02, offsety=0.03)

Arguments

int1

int2

textp

showmac

showsupp

showmp

cliques

macprod

density

The intervals for the x dimension.

The intervals for the y dimension.

Boolen, if true add text.

Boolean, if true then the maximal cliques are shown in a different color?

Boolean, if true show support boxes.

Boolean

Maximal cliques.

macprod

The density of the polygon shading lines, in lines per inch.

18

col

offsetx

offsety

Value

Color for plotting features.

Offset for x-axis.

Offset for y-axis.

No value is returned. The event rectangles are plotted on the active graphics device.

PMGA

Author(s)

A. Vandal and R. Gentleman

References

Graph–Theoretical Aspects of Bivariate Censored Data, R. Gentleman and A. Vandal, 1999, sub-
mitted.

See Also

BVclmat, BVsupport, BVcliques

Examples

data(cmv)
Plotboxes(cmv[,1:2], cmv[,3:4], showmac=TRUE)

PMGA

Implement the pool monotone groups algorithm.

Description

For isotonization problems some increase in speed and decrease in complexity can be achieved
through the use of the pool monotone groups algorithm of Y.L. Zhang and M.A. Newton (1997). It
isotonizes a weighted and ordered set of values.

Usage

PMGA(est, ww=rep(1, length(est)))

Arguments

est

ww

Details

The vector of values, in the appropriate order.

The weight vector.

To be supplied at some later date.

pruitt

Value

An object containing the following components:

19

est

ww

poolnum

passes

Author(s)

The isotonized estimates.

The weights associated with the isotonized estimates.

The number of values pooled in the current estimate.

The number of passes which were required to isotonize the list.

Alain Vandal and Robert Gentleman.

References

Y.L. Zhang and M.A. Newton (1997), http://www.stat.wisc.edu/~newton/newton.html)

See Also

EMICM

pruitt

A small artificial, bivariate right-censored data set.

Description

The pruitt data was given in Pruitt (1993) as an example for testing different methods of estimat-
ing the bivariate NPMLE for right censored data. This matrix represents the clique matrix of the
intersection graph of the data set given by Pruitt.

Format

This data frame contains 8 columns, labeled A through H that represent the observations. There are
seven rows corresponding to the seven maximal cliques in the intersection graph.

Source

Small Sample Comparison of Six Bivariate Survival Curve Estimators, Journal of Statistical Com-
putation and Simulation, R. Pruitt, 1993.

Examples

data(pruitt)

VEM

Compute the NPMLE of p via the Vertex Exchange Method.

20

VEM

Description

The Vertex Exchange Method is used to obtain the NPMLE of p.

Usage

VEM(A, pvec, maxiter=500, tol=1e-07, tolbis=1e-07, keepiter=FALSE)

The m by n incidence matrix or the n by 2 matrix of intervals.

The initial estimate for the probability vector.

The maximum number of iterations allowed.

The tolerance used to determine convergence.

The tolerance used in the bisection stage of the algorithm.

Should iteration information be retained and returned.

Arguments

A

pvec

maxiter

tol

tolbis

keepiter

Details

Lots.

Value

An object of class icsurv with the following components.

pf

numiter

lval

converge

intmap

The NPMLE of the probability vector.

The number of iterations used.

The value of the logarithm of the likelihood at the NPMLE.

Boolean stating whether the iteration converged.

If present it contains the real representations for the maximal cliques. These are
the intervals (on the real line) where the mass in pf is placed.

Author(s)

Robert Gentleman and Alain Vandal

References

A Vertex-exchange-method in $D$-optimal Design Theory , D. Bohning, Metrika, 1986.

See Also

EM, ISDM, EMICM, PGM

VEM

Examples

data(cosmesis)
csub1 <- subset(cosmesis, subset=Trt==0, select=c(L,R))
VEM(csub1)
data(pruitt)
VEM(pruitt)

21

Icens-internal, 10
icsurv, 7, 8, 10, 15, 20
Intersection (Icens-internal), 10
ISDM, 7, 11, 11, 16, 17, 20

Maclist, 12, 13, 14
Macmat, 12, 13
MLEintvl, 14

PGM, 7, 9, 11, 12, 15, 16, 17, 20
plot.icsurv, 16
Plotboxes, 17
PMGA, 18
pruitt, 19

rescaleP (Icens-internal), 10

Subset (Icens-internal), 10

VEM, 7, 9, 11, 12, 16, 17, 20
VEMICMmac (Icens-internal), 10

Index

∗ aplot

Plotboxes, 17

∗ datasets
cmv, 5
cosmesis, 6
hiv, 9
pruitt, 19

∗ hplot

plot.icsurv, 16

∗ manip

BVcliques, 3
BVclmat, 4
BVsupport, 4
Maclist, 12
Macmat, 13
MLEintvl, 14

∗ methods

icsurv, 10

∗ nonparametric
EM, 7
∗ optimize

Bisect, 2
EMICM, 8
ISDM, 11
PGM, 15
PMGA, 18
VEM, 20

∗ ts

Icens-internal, 10

Bisect, 2
BVcliques, 3, 4, 5, 18
BVclmat, 3, 4, 5, 18
BVmacprod (Icens-internal), 10
BVsupport, 3, 4, 4, 18

cmv, 5
cosmesis, 6

EM, 7, 9, 11, 16, 20
EMICM, 7, 8, 11, 12, 16, 17, 19, 20
EMICMmac (Icens-internal), 10

hiv, 9

22

