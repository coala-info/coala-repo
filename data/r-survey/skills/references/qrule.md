Estimating quantiles

Thomas Lumley

August 28, 2025

The pth quantile is defined as the value where the estimated cumulative
distribution function is equal to p. As with quantiles in unweighted data, this
definition only pins down the quantile to an interval between two observations,
and a rule is needed to interpolate. As the help for the base R function quantile
explains, even before considering sampling weights there are many possible rules.
Rules in the svyquantile() function can be divided into three classes

• Discrete rules, following types 1 to 3 in quantile

• Continuous rules, following types 4 to 9 in quantile

• A rule proposed by Shah & Vaish (2006) and used in some versions of

SUDAAN

Discrete rules

These are based on the discrete empirical CDF that puts weight proportional
to the weight wk on values xk.

ˆF (x) =

(cid:80)

i{xi ≤ x}wi
i wi

(cid:80)

The mathematical inverse The mathematical inverse ˆF −1(p) of the CDF
is the smallest x such that F (x) ≥ p. This is rule hf1 and math and in equally-
weighted data gives the same answer as type=1 in quantile

The primary-school median The school definition of the median for an
even number of observations is the average of the middle two observations. We
extend this to say that the pth quantile is qlow = ˆF −1(p) if ˆF (qlow) = p and
otherwise is the the average of ˆF −1(p) and the next higher observation. This is
school and hf2 and is the same as type=2 in quantile.

Nearest even order statistic The pth quantile is whichever of ˆF −1(p) and
the next higher observation is at an even-numbered position when the distinct
data values are sorted. This is hf3 and is the same as type=3 in quantile.

1

Continuous rules

These construct the empirical CDF as a piecewise-linear function and read off
the quantile. They differ in the choice of points to interpolate. Hyndman &
Fan describe these as interpolating the points (pk, xk) where pk is defined in
terms of k and n. For weighted use they have been redefined in terms of the
cumulative weights Ck = (cid:80)
i≤k wi, the total weight Cn = (cid:80) wi, and the weight
wk on the kth observation.

qrule Hyndman & Fan
pk = k/n
hf4
pk = (k − 0.5)/n
hf5
pk = k/(n + 1)
hf6
pk = (k − 1)/(n − 1)
hf7
pk = (k − 1/3)/(n + 2/3)
hf8
pk = (k − 3/8)/(n + 1/4)
hf9

Weighted
pk = Ck/Cn
pk = (Ck − wk)/Cn
pk = Ck/(Cn + wn)
pk = Ck−1/Cn−1
pk = (Ck − wk/3)/(Cn + wn/3)
pk = (Ck − 3wk./8)/(Cn + wn/4)

Shah & Vaish

This rule is related to hf6, but it is discrete and more complicated. First, define
sum to the sample size rather than the population
w∗
. Now define the estimated CDF by
size, and C ∗k as partial sums of w∗
k

i = win/Cn, so that w∗
i

ˆF (xk) =

1
n + 1

(C ∗

k + 1/2 − wk/2)

and take ˆF −1(p) as the pth quantile.

Other options

It would be possible to redefine all the continuous estimators in terms of w∗, so
that type 8, for example, would use

pk = (C ∗

k − 1/3)/(C ∗

n + 2/3)

Or a compromise, eg using w∗
k
tor, such as

in the numerator and numbers in the denomina-

k/3)/(C ∗
Comparing these would be a worthwhile. . . an interesting... a research ques-

pk = (C ∗

n + 2/3).

k − w∗

tion for simulation.

2

