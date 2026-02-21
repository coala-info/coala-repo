Fst
The algorithm used in snpStats

David Clayton

October 30, 2025

F statistics for diversity of groups

There is a very large literature on this topic and the author does not claim any great expertise.
The purpose of this vignette is simply to document the method of calculation implemented
in snpStats.

We shall start by introducing some notation. Let:

Ng Number of chromosomes in group g
Nsg Number of chromsomes in group g observed for SNP s
Ns Number of chromosomes observed for SNP s, all groups
psg Allele (relative) frequency for SNP s in group g
ps

Overall allele frequency for SNP s

and let:

Ys =

Xsg =

Ns
Ns − 1
Nsg
Nsg − 1

ps(1 − ps)

psg(1 − psg)

Xs = (cid:88)

WgXsg

g

where Wg are group-specific weights (see below).

The value returned for the F statistic for SNP s is

Fs = 1 −

Xs
Ys

=

Ys − Xs
Ys

.

A natural combined value over all SNPs is obtained by summing numerators and denom-

inators of the SNP-specific values Denoting summation by a + subsscript,

F =

Y+ − X+
Y+

,

1

which can also be written as a weighted mean of the SNP-specific values, with Ys as weights:

F =

1
s Ys

(cid:80)

(cid:88)

s

YsFs.

There appear to be two ways of looking at this index, leading to different weights when

group sizes are unequal.

Pairwise differences

One rationale suggests that the index can be written

DT − DW
DT

where DT is the probability that two chromosomes, sampled at random from the total
population, differ and DW is the probability that two chromosomes, sampled at random
from the same subpopulation, differ. For a single SNP, s, Ys is an unbiased estimator for DT
and Xsg is an unbiased estimator for DW within subgroup g. With this rationale, the weights,
{Wg} should reflect the numbers of distinct pairwise comparisons within each group:

Wg =

Ng(Ng − 1)
g Ng(Ng − 1)

(cid:80)

The analysis of variance

Another rationale would seem to be in terms of partition of the total variance, specifically
the ratio of the between-group variance to the total variance (this seems to be the thrust of
a series of papers by Cockerham). Ys is then an unbiased estimate of the total variance of
SNP s and Xsg is an unbiased estimator of its variance in group g. But the natural weights
are then

Wg =

Ng
g Ng

.

(cid:80)

(Cockerham also seems to have considered an unweighted analysis but that could be ineffi-
cient if group sizes differ substantially).

An example

Here we show the results of these calculations using the HapMap data discussed in other vi-
gnettes. These data were constructed by re-sampling individuals from two groups of HapMap
subjects, the CEU sample (of European origin) and the JPT+CHB sample (of Asian origin),
these groups being identified by the variable stratum in the subject support data frame.

We first use the pair-wise difference weights, first calculating the SNP-specific values,

followed by the weighted average across all SNPs:

2

> data(for.exercise)
> f1 <- Fst(snps.10, subject.support$stratum, pairwise=TRUE)
> weighted.mean(f1$Fst, f1$weight)

[1] 0.06795229

We now compare this result with that obtained with the alternative (AOV) weights:

> f2 <- Fst(snps.10, subject.support$stratum, pairwise=FALSE)
> weighted.mean(f2$Fst, f2$weight)

[1] 0.06767651

Here there is little difference between the two values, since the group sizes are nearly the
same:

> table(subject.support$stratum)

CEU JPT+CHB
506
494

In other cases the two weighting schemes could lead to different answers. In such situations,
the preference of this author is for the analysis of variance weights and, accordingly, this has
been set as the default action.

3

