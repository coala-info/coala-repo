Describing PPS designs to R

Thomas Lumley

August 28, 2025

The survey package has always supported PPS (ie, arbitrary unequal probability) sampling
with replacement, or using the with-replacement single-stage approximation to a multistage
design. No special notation is required: just specify the correct sampling weights.

Version 3.11 added an another approximation for PPS sampling without replacement, and
version 3.16 added more support. There are two broad classes of estimators for PPS sampling
without replacement: approximations to the Horvitz–Thompson and Yates–Grundy estimators
based on approximating the pairwise sampling probabilities, and estimators of Hájek type that
attempt to recover the extra precision of a without-replacement design by conditioning on the
estimated population size.

Direct approximations

Using the standard recursive algorithm for stratified multistage sampling when one or more
stages are actually PPS gives an approximation due to Brewer. This is simple to compute,
always non-negative, and appears to be fairly efficient.

Approximating πij

Given the pairwise sampling probabilities πij we can define the weighted covariance of sampling
indicators

ˇ∆ij = 1 −

πiπj
πij

and the weighted observations

1
πi
Two unbiased estimators of the variance of the total of x are the Horvitz–Thompson estimator

ˇxi =

xi.

ˆVHT =

n
(cid:88)

i,j=1

ˇ∆ˇxi ˇxj

and the Yates–Grundy(–Sen) estimator

ˆVY G =

1
2

n
(cid:88)

i,j=1

ˇ∆(ˇxi − ˇxj)2

The Yates–Grundy estimator appears to be preferred in most comparisons. It is always non-
negative (up to rounding error, at least).

1

In principle, πij might not be available and various approximations have been proposed. The

(truncated) Hartley–Rao approximation is

ˇ∆ij = 1 −

n − πi − πj + (cid:80)N

k=1 π2

k/n

n − 1

which requires knowing πi for all units in the population. The population sum can be estimated
from the sample, giving a further approximation

ˇ∆ij = 1 −

n − πi − πj + (cid:80)n

k=1 πk/n

n − 1

.

that requires only the sample πi. Overton’s approximation is

ˇ∆ij = 1 −

n − (πi + πj)/2
n − 1

which also requires only the sample πi.

In practice, given modern computing power, πij should be available either explicitly or by

simulation, so the Hartley–Rao and Overton approximations are not particularly useful.

0.1 Using the PPS estimators

At the moment, only Brewer’s approximation can be used as a component of multistage sampling,
though for any sampling design it is possible to work out the joint sampling probabilities and
use the other approaches. The other approaches can be used for cluster sampling or for sampling
of individual units. This is likely to change in the future.

To specify a PPS design, the sampling probabilities must be given in the prob argument
of svydesign, or in the fpc argument, with prob and weight unspecified. In addition, it is
necessary to specify which PPS computation should be used, with the pps argument. The op-
tional variance argument specifies the Horvitz–Thompson (variance="HT") or Yates–Grundy
(variance="YG") estimator, with the default being "HT".

Some estimators require information in addition to the sampling probabilities for units in the
sample. This information is supplied to the pps= argument of svydesign using wrapper functions
that create objects with appropriate classes. To specify the population sum (cid:80) pi2
i /n needed
for the Hartley–Rao approximation, use HR(), and to specify a matrix of pairwise sampling
probabilities use ppsmat(). The function HR() without an argument will use the Hartley–Rao
approximation and estimate the population sum from the sample.

The data set election contains county-level voting data from the 2004 US presidential
elections, with a PPS sample of size 40 taken using Tillé’s splitting method, from the sampling
package. The sampling probabilities vary widely, with Los Angeles County having a probability
of 0.9 and many small counties having probabilities less than 0.0005.

> library(survey)
> data(election)
> summary(election$p)

Min.

Max.
0.0000014 0.0007260 0.0022498 0.0086957 0.0057289 0.9036576

1st Qu.

3rd Qu.

Median

Mean

> summary(election_pps$p)

Min.

Max.
0.0001429 0.0153794 0.0398065 0.1106639 0.1103490 0.9036576

1st Qu.

3rd Qu.

Median

Mean

2

Some possible survey design specifications for these data are:

fpc=~p, data=election_pps, pps="brewer")

> ## Hajek type
> dpps_br<- svydesign(id=~1,
> ## Horvitz-Thompson type
> dpps_ov<- svydesign(id=~1,
> dpps_hr<- svydesign(id=~1,
> dpps_hr1<- svydesign(id=~1, fpc=~p, data=election_pps, pps=HR())
> dpps_ht<- svydesign(id=~1,
> ## Yates-Grundy type
> dpps_yg<- svydesign(id=~1,
> dpps_hryg<- svydesign(id=~1,
> ## The with-replacement approximation
> dppswr <-svydesign(id=~1, probs=~p, data=election_pps)

fpc=~p, data=election_pps, pps="overton")
fpc=~p, data=election_pps, pps=HR(sum(election$p^2)/40))

fpc=~p, data=election_pps, pps=ppsmat(election_jointprob))

fpc=~p, data=election_pps, pps=ppsmat(election_jointprob),variance="YG")
fpc=~p, data=election_pps, pps=HR(sum(election$p^2)/40),variance="YG")

All the without-replacement design objects except for Brewer’s method include a matrix ˇ∆.
These can be visualized with the image() method. These plots use the lattice package and so
need show() to display them inside a program:

> show(image(dpps_ht))

> show(image(dpps_ov))

3

Dimensions: 40 x 40ColumnRow1020301020300.00.20.40.60.81.0are more negative entries in ˇ∆ with the approximate methods than when the full pairwise sam-
pling matrix is supplied.

In this example there

The estimated totals are the same with all the methods, but the standard errors are not.

> svytotal(~Bush+Kerry+Nader, dpps_ht)

total

SE
Bush
64518472 2604404
Kerry 51202102 2523712
102326
478530
Nader

> svytotal(~Bush+Kerry+Nader, dpps_yg)

total

SE
64518472 2406526
Bush
Kerry 51202102 2408091
101664
478530
Nader

> svytotal(~Bush+Kerry+Nader, dpps_hr)

total

SE
Bush
64518472 2624662
Kerry 51202102 2525222
102793
478530
Nader

4

Dimensions: 40 x 40ColumnRow1020301020300.00.20.40.60.81.0> svytotal(~Bush+Kerry+Nader, dpps_hryg)

total

SE
64518472 2436738
Bush
Kerry 51202102 2439845
102016
478530
Nader

> svytotal(~Bush+Kerry+Nader, dpps_hr1)

total

SE
Bush
64518472 2472753
Kerry 51202102 2426842
102595
478530
Nader

> svytotal(~Bush+Kerry+Nader, dpps_br)

total

SE
Bush
64518472 2447629
Kerry 51202102 2450787
102420
478530
Nader

> svytotal(~Bush+Kerry+Nader, dpps_ov)

total

SE
Bush
64518472 2939608
Kerry 51202102 1964632
104373
478530
Nader

> svytotal(~Bush+Kerry+Nader, dppswr)

total

SE
Bush
64518472 2671455
Kerry 51202102 2679433
105303
478530
Nader

5

