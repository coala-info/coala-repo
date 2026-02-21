GeneSelector package vignette

Martin Slawski1,2 *

Anne-Laure Boulesteix1,2,3 (cid:132)

1 Sylvia Lawry Centre, Munich, Germany
2 Institute for Medical Informatics, Biometry and Epidemiology,
Ludwig-Maximilians-University Munich, Germany
3 Department of Statistics, Ludwig-Maximilians-University Munich, Germany

Abstract

This is the vignette of the Bioconductor add-on package GeneSelector which con-
tains methods to assess quantitatively the variability among multiple gene rankings,
obtained by using altered datasets or several ranking procedures. The resulting multi-
plicity problem is addressed by functionality for rank aggregation.

1 Introduction

An important aspect of microarray data analysis is the detection of genes that are diﬀer-
entially expressed, e.g. in diﬀerent experimental conditions or in individuals with diﬀerent
phenotypes. The results of microarray studies are usually the starting point for further more
expensive and time-consuming experiments, which involve only a small number of candidate
genes Aerts et al. [2006]. The set of candidate genes is typically determined by computing a
two-sided test statistic for each gene j = 1, . . . , p, and ordering them decreasingly according
to the size of the absolute of the statistic. This yields an ordered list l = (lm, m = 1, . . . , p)
and ranks r = (rj, j = 1, . . . , p) deﬁned by rj = m ⇔ lm = j, j, m = 1, . . . , p. The genes
at the top of the list are displayed in almost all microarray-related biomedical publications,
often considered as an unequivocal and deﬁnitive result. Critical voices have pointed out
that this procedure might yield false research ﬁndings Ioannidis [2005], since it ignores the
variability of the obtained ordered lists Ein-Dor et al. [2006], Qiu et al. [2007]. The Gene-
Selector package tries to quantify this variability by mimicking changed data situations
via resampling- and related strategies, and then comparing the results to those obtained
with the reference datasets. For this purpose, GeneSelector assembles several stability
measures for rank data.
A second source of variability, which, to our knowledge, has not been addressed in the
literature, is the multiplicity of test statistics (= ranking criteria) proposed for gene ex-
pression data with the aim to cope with the ’small n, large p’ situation, with n denoting the
number of replicates. GeneSelector implements a collection of fourteen such ranking cri-
teria, displayed in Table 1, and hence enables the user to explore this source of variability.
Using several ranking criteria instead of only one may additionally be seen as sensitivity

*ms@cs.uni-sb.de
(cid:132)boulesteix@ibe.med.uni-muenchen.de

1

Method
Foldchange
t-statistic
Welch’s t statistic
Bayesian t-statistic (1)
Bayesian t-statistic (2)
Shrinkage t-statistic
Soft-thresholded t-statistic
Parametric empirical Bayes
B-statistic
Nonparametric empirical Bayes
SAM
Wilcoxon statistic
Wilcoxon statistic, empirical Bayes
Permutation test

Function name
RankingFC
RankingTstat
RankingWelchT
RankingBaldiLong
RankingFoxDimmic
RankingShrinkageT
RankingSoftthresholdT
RankingLimma
RankingBstat
RankingEbam
RankingSam
RankingWilcoxon
RankingWilcEbam
RankingPermutation

Package Reference

Baldi and Long [2001]
Fox and Dimmic [2006]
Opgen-Rhein and Strimmer [2007]
Wu [2005]
Smyth [2004]
L¨onnstedt and Speed [2002]

limma
sma
siggenes Efron et al. [2001]
samr

Tusher et al. [2001]

siggenes Efron and Tibshirani [2002]
multtest

Table 1: Overview of the ranking procedures in GeneSelector.
given, then the respecive procedure is not imported from a foreign package.

If the ’package’ is not

analysis, since most criteria rely on idealized, hard-to-check assumptions. Each ranking
criteria produces its own result, whereas the user may be confronted with the dilemma
of ﬁnding exactly one result, which should unify all results as good as possible, hopefully
giving rise to an improved and more stable ranking and in turn to a set of candidate genes
with as least as possible false positives. In this spirit, our package oﬀers a GeneSelector
function as well as several methods for rank aggregation.

2 Illustration

2.1 Description of the data set

We demonstrate the functionalities of GeneSelector in the classical setting of two inde-
pendent samples, each of size 10. We simulate a gene expression matrix x containing 2, 000
genes in the following manner.

(cid:136) Gene expression intensities are drawn from a multivariate normal distribution with
zero mean vector and covariance which itself has been drawn randomly from an
inverse Wishart distribution.

(cid:136) The ﬁrst 40 genes are diﬀerentially expressed. The diﬀerences in the means between
the two classes are simulated independently according to a normal distribution with
variance 0.9.

We access the data using the lines:

> data(toydata)
> y <- as.numeric(toydata[1,])

2

> x <- as.matrix(toydata[-1,])
> dim(x)

[1] 2000

20

> table(y)

y

1 2
10 10

Knowing that the ﬁrst genes are diﬀerentially expressed, we make boxplots of the gene
expression intensities of the ﬁrst four genes:

> par(mfrow=c(2,2))
> for(i in 1:4) boxplot(x[i,]~y, main=paste("Gene", i))

2.2 Rankings

We now perform a ranking using the ordinary t-statistic.

3

ll12−0.50.00.51.0Gene 112−0.50.51.52.5Gene 212−1.00.01.0Gene 312−0.50.51.52.5Gene 4> ordT <- RankingTstat(x, y, type="unpaired")

The resulting objects are all instances of the class GeneRanking.
To get basic information, we use the commands:

> getSlots("GeneRanking")

y
"factor"

statistic
"numeric"

ranking
"numeric"

pval

type
"vector" "character"

x
"matrix"
method
"character"

> str(ordT)

Formal class

’

GeneRanking

’

[package "GeneSelector"] with 7 slots

: num [1:2000, 1:20] 1 2.78 -1.18 2.79 -2.95 ...

: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...

..@ x
.. ..- attr(*, "dimnames")=List of 2
.. .. ..$ : chr [1:2000] "1" "2" "3" "4" ...
.. .. ..$ : chr [1:20] "arr1" "arr2" "arr3" "arr4" ...
..@ y
..@ statistic: Named num [1:2000] 6.32 9.53 -2.29 13.09 -7.93 ...
.. ..- attr(*, "names")= chr [1:2000] "1" "2" "3" "4" ...
..@ ranking : Named int [1:2000] 11 3 185 1 5 17 13 451 6 375 ...
.. ..- attr(*, "names")= chr [1:2000] "1" "2" "3" "4" ...
..@ pval
.. ..- attr(*, "names")= chr [1:2000] "1" "2" "3" "4" ...
..@ type
..@ method

: chr "unpaired"
: chr "ordinaryT"

: Named num [1:2000] 5.83e-06 1.85e-08 3.44e-02 1.23e-10 2.79e-07 ...

> show(ordT)

Ranking by ordinaryT,
number of genes: 2000.

> toplist(ordT)

index statistic

pval
4 13.087900 1.232978e-10
11 10.404717 4.833338e-09
2 9.533551 1.853162e-08
26 -8.378361 1.261238e-07
5 -7.927116 2.791221e-07
9 -7.744184 3.880996e-07
23 7.392767 7.402187e-07
38 -6.986973 1.592778e-06
28 -6.786421 2.345378e-06
40 6.421584 4.808461e-06

1
2
3
4
5
6
7
8
9
10

4

>

The last command yields the top-ranking genes according to the respective procedure.

2.3 Altered data sets

In order to inspect stability of the obtained ranking with respect to changes in the data,
we use resampling techniques implemented in GeneSelector. The following command
produces jackknif-ed data sets, i.e. datasets resulting from successively removing exactly
one sample from the complete sample:

> loo <- GenerateFoldMatrix(y = y, k=1)
> show(loo)

number of removed samples per replicate: 1
number of replicates: 20
constraints: minimum classize for each class: 9

We plug this into the method RepeatRanking, which determines the ranking 20 times, i.e.
for each removed observation, anew:

> loor_ordT <- RepeatRanking(ordT, loo)
>

The object loo may additionally be used in the following manner:

> ex1r_ordT <- RepeatRanking(ordT, loo, scheme = "labelexchange")
>

The argument scheme = "labelexchange" speciﬁes that instead of leaving one observa-
tion out, it is assigned the opposite class label.
We may also use the bootstrap, e.g.

> boot <- GenerateBootMatrix(y = y, maxties=3, minclassize=5, repl=30)
> show(boot)

number of bootstrap replicates: 30
constraints: minimum classize for each class: 5

maximum number of ties per observation: 3

> boot_ordT <- RepeatRanking(ordT, boot)
>

. . . or add a small amount of noise to the observed expression intensities:

> noise_ordT <- RepeatRanking(ordT, varlist=list(genewise=TRUE, factor=1/10))

5

To get a toplist that tabulates how top list positions are distributed over all repeated
rankings, we use:

> toplist(loor_ordT, show=FALSE)

original dataset:

index statistic

pvals
4 13.087900 1.232978e-10
11 10.404717 4.833338e-09
2 9.533551 1.853162e-08
26 -8.378361 1.261238e-07
5 -7.927116 2.791221e-07
9 -7.744184 3.880996e-07
23 7.392767 7.402187e-07
38 -6.986973 1.592778e-06
28 -6.786421 2.345378e-06
40 6.421584 4.808461e-06

4
11
2
26
5
9
23
38
28
40

In the following table, rownames correspond to gene indices.
The columns contain the absolute frequencies for the corresponding ranks
over all replications.
Genes are ordered according to the first column, then to the second, and so on.

Rank 1 Rank 2 Rank 3 Rank 4 Rank 5 Rank 6 Rank 7 Rank 8 Rank 9 Rank 10
0
0
0
0
0
0
0
1
4
3
5
4
1
1
1

0
0
0
0
2
5
11
0
0
0
1
1
0
0
0

0
0
0
0
0
0
4
11
2
0
1
1
1
0
0

0
0
2
13
3
1
0
0
0
0
1
0
0
0
0

0
18
1
0
1
0
0
0
0
0
0
0
0
0
0

0
2
17
1
0
0
0
0
0
0
0
0
0
0
0

20
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
1
7
10
2
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
7
3
0
9
1
0
0
0

0
0
0
5
7
4
3
1
0
0
0
0
0
0
0

4
11
2
26
5
9
23
38
40
12
28
1
7
14
29

As an exploratory tool to examine the diﬀerence in rankings between original and perturbed
data sets, a plot command is available.

From Figure 1, it is obvious that variability increases for a higher list position. Moreover,
the ﬁgure shows that variability depends on the method used to generate altered data sets.
In this example, the bootstraped rankings are more scattered around the angle bisector
than the jackknif-ed rankings.

6

> par(mfrow=c(2,2))
> plot(loor_ordT, col="blue", pch=".", cex=2.5, main = "jackknife")
> plot(ex1r_ordT, col="blue", pch=".", cex=2.5, main = "label exchange")
> plot(boot_ordT, col="blue", pch=".", cex=2.5, main = "bootstrap")
> plot(noise_ordT, frac=1/10, col="blue", pch=".", cex=2.5, main = "noise")

Figure 1: Scatterplots of rankings from altered datasets vs. rankings from the original
dataset.

2.4 Stability measures

Alternative to visual methods, one can compute of the stability measures tabulated in
Table 2. Let σ, σ(cid:48) be either two rankings r, r(cid:48) or two lists l, l(cid:48). A function s is called
pairwise stability measure if

(i) s(σ, σ(cid:48)) = s(σ(cid:48), σ),

(ii) s(σ, σ(cid:48)) ≤ s(σ, σ) = s(σ(cid:48), σ(cid:48)) = 1.

In the current version of GeneSelector, there are two groups of pairwise stability mea-
sures: the ﬁrst group is set-based, counting/summing up overlaps of lists, while the second
one computes distances. Pairwise stability measures are particularly appropriate in the
presence of a reference list/ranking. In the example given in the previous subsection, the
7

5101520010203040jackknifeRank in the original datasetRanks in perturbed datasets5101520010203040label exchangeRank in the original datasetRanks in perturbed datasets5101520010203040bootstrapRank in the original datasetRanks in perturbed datasets0501001502000100300noiseRank in the original datasetRanks in perturbed datasetsName

Deﬁnition

Reference

Intersection count †

s∩(l, l(cid:48)) = s∩(l[k], l(cid:48)

[k]) =

(cid:80)

1≤m,m(cid:48)≤k I(lm=l(cid:48)
k

m(cid:48) )

, k = 1, . . . , p. Qiu et al. [2007]

Overlap score †

sO∩(l, l(cid:48)) =

(cid:80)p

k=1 wks∩(l[k],l(cid:48)
k=1 wk

(cid:80)p

[k])

(cid:96)1 ‡

(cid:96)2 ‡

Spearman’s ρ ‡

s(cid:96)1(r, r(cid:48)) = 1 −

s(cid:96)2(r, r(cid:48)) = 1 −

(cid:80)p

j=1 wj |rj −r(cid:48)
j |
j=1 w(j)|j−(p−j+1)|

(cid:80)p

(cid:80)p

j=1 wj (rj −r(cid:48)
j=1 w(j)|j−(p−j+1)|

j )2

(cid:80)p

(cid:80)p

j=1 wj (rj −(p+1)/2)(r(cid:48)
((cid:80)p

j )1/2((cid:80)p

j=1 r2

j=1 r(cid:48)2

j −(p+1)/2)
j )1/2

Kendall’s τ ‡

sτ (r, r(cid:48)) = 1 −

(cid:80)

1≤j<m≤p wj wm I([(rj −rm)(r(cid:48)

j −r(cid:48)

m)]<0)

(cid:80)

1≤j<m≤p wj wm

Union count ∆

s∪(l1 [k], . . . , lB [k]) = 1 −

|U[k]|−k
min{Bk,p}−k

Union score ∆

sO∪(l1, . . . , lB) =

(cid:80)p

k=1 wks∪(l1 [k],...,lB [k])
k=1 wk

(cid:80)p

Yang et al. [2006]

Jurman et al. [2008]

Jurman et al. [2008]

Jurman et al. [2008]

DeConde et al. [2006]

Jurman et al. [2008]

Table 2: Overview of the stability measures in GeneSelector. Notations: l[k] = (lm, 1 ≤
m ≤ k) denotes the top-k list of l; the wj’s are (ﬁxed) weights - the subscript in the brackets
indicate ordering, i.e. w(1) ≤ . . . ≤ w(p); |U[k]| denotes the size of the union of all top k-lists
to be compared. Legend: † - implemented in GetStabilityOverlap; ‡ - implemented in
GetStabilityDistance; ∆ - implemented in GetStabilityUnion.

natural choice for the reference is the ranking obtained with the original dataset. If one
wants to compute a stability indicator for several lists without a reference, e.g. when
comparing the output of diﬀerent ranking criteria, we introduce the following notion. Let
σb,
b = 1, . . . , B be a sequence of rankings or lists. A function s is called multi-input
stability measure if

(i) s(σ1, . . . , σB) = s(σπ1, . . . , σπB ) for any permutation π of {1, . . . , B},

(ii) s(σ1, . . . , σB) ≤ s(σ1, . . . , σ1) = . . . = s(σB, . . . , σB) = 1.

As shown in Table 2, an additional component of stability measures is a weighting scheme
which penalizes variability at the top of list more severely than at the bottom, since only
the top is of practical relevance.

As illustration, we apply GetStabilityOverlap to the rankings obtained after swapping
class labels, which seems to perturb considerably the original ranking, as indicated by
Figure 1. Concerning the sequence of weights, we choose wm = 1/m, m = 1, . . . , p, which
is realized by using the option decay = "linear".

> stab_ex1r_ordT <- GetStabilityOverlap(ex1r_ordT, scheme = "original",

8

+ decay="linear")
> show(stab_ex1r_ordT)

Stability measure: intersection count and overlap score,
scheme: original,
weighting: linear weight decay.

>

GetStabilityOverlap computes both normalized intersection counts and overlap scores
when truncating at list position k,
k = 1, . . . , p. Evaluating these scores for position
k = 10, we use the lines:

> summary(stab_ex1r_ordT, measure = "intersection", display = "all", position = 10)

intersection fractions (with respect to reference data set):

0.8

iter.1 iter.2 iter.3 iter.4 iter.5 iter.6 iter.7 iter.8 iter.9 iter.10
0.8
iter.11 iter.12 iter.13 iter.14 iter.15 iter.16 iter.17 iter.18 iter.19 iter.20
0.8

0.8

0.9

0.7

0.9

0.8

0.7

0.9

0.7

0.8

0.7

0.8

0.9

0.9

0.8

0.6

0.6

0.9

expected score in the case of no-information: 0.005

> summary(stab_ex1r_ordT, measure = "overlapscore", display = "all", position = 10)

overlap scores (with respect to reference data set):

0.537

0.874

iter.1 iter.2 iter.3 iter.4 iter.5 iter.6 iter.7 iter.8 iter.9 iter.10
0.851
iter.11 iter.12 iter.13 iter.14 iter.15 iter.16 iter.17 iter.18 iter.19 iter.20
0.672

0.597
expected score in the case of no-information: 0.001707086

0.494

0.647

0.695

0.776

0.608

0.528

0.490

0.703

0.763

0.430

0.481

0.606

0.769

0.716

0.660

>

The output shows that the overlap between reference- and alternative top-ten lists ranges
from 60 to 90 percent. Overlap score and intersection count disagree visibly, which is due
to the fact that the overlap score is computed with weights. Though 1 suggests some
discrepancy between reference- and alternative lists, the output shows that the fraction of
accordance is much larger than the expectation in the no-information case, i.e. in the case
of mutually unrelated lists. To have a look at how the two scores vary with increasing list
position (on average), we invoke the predeﬁned plot(...) routine:

Next, let us investigate which sample is most inﬂuential in the sense that its removal
perturbs the reference ranking most. For this purpose, we apply GetStabilityDistance
with the option measure = "spearman" to the jackknif-ed rankings.

> stab_loo_ordT <- GetStabilityDistance(ex1r_ordT, scheme = "original", measure
+ = "spearman", decay="linear")
> show(stab_loo_ordT)

9

> plot(stab_ex1r_ordT, frac = 1, mode = "mean")

Figure 2: Visualization of intersection count and overlap score.

Stability measure: spearman
scheme: original,
weighting: linear weight decay.

’

s rank correlation,

> summary(stab_loo_ordT, display = "all")

stability scores (with respect to reference data set):

0.351

iter.1 iter.2 iter.3 iter.4 iter.5 iter.6 iter.7 iter.8 iter.9 iter.10
0.683
iter.11 iter.12 iter.13 iter.14 iter.15 iter.16 iter.17 iter.18 iter.19 iter.20
0.564

0.674

0.509

0.585

0.230

0.698

0.720

0.489

0.157

0.420

0.393

0.568

0.446

0.402

0.460

0.749

0.654

0.745

expected score in the case of no-information: 0

>

From the output we conclude that the ﬁfth sample is by far the most inﬂuential one.

10

05001000150020000.00.40.8percentage of  overlaplist positionoverlap05001000150020000.00.40.8average overlap scorelist positionscore2.5 Aggregating multiple ranking criteria

In addition to the ordinary t-statistic, we compute ﬁve additional rankings (cf. Table 1):

> BaldiLongT <- RankingBaldiLong(x, y, type="unpaired")
> FoxDimmicT <- RankingFoxDimmic(x, y, type="unpaired")
> sam <- RankingSam(x, y, type="unpaired")
> wilcox <- RankingWilcoxon(x, y, type="unpaired")
> wilcoxeb <- RankingWilcEbam(x, y, type="unpaired")

Again, we ﬁrst assess variability visually. The method HeatmapRankings produces a
heatmap from all obtained rankings, clustering genes and criteria simultaneously. We
restrict to our attention to the ﬁrst forty, diﬀerentially expressed genes (ind = 1:40).

> Merged <- MergeMethods(list(ordT, BaldiLongT, FoxDimmicT, sam, wilcox, wilcoxeb))
> HeatmapRankings(Merged, ind=1:40)
>

To cope with the multiplicity problem, we exploit the functionalities for rank aggregation in
the GeneSelector package. A simple approach would just take the average of all observed
ranks, which is, among other things, implemented in the method AggregateSimple. As a
more sophisticated approach, we use the Markov chain model propagated in DeConde et al.
11

WilcEbamBaldiLongTFoxDimmicTWilcoxonordinaryTSam1 − 2020 − 100100 − 200200 − 500500 − 2000[2006] and implemented in the method AggregateMC. Lastly, we use the GeneSelector
function, which aims at ﬁnding genes falling consistently, i.e. for all ranking criteria, below
a pre-speciﬁed threshold, here chosen as 50.

> AggMean <- AggregateSimple(Merged, measure = "mean")
> AggMC <- AggregateMC(Merged, type = "MCT", maxrank = 100)
> GeneSel <- GeneSelector(list(ordT, BaldiLongT, FoxDimmicT, sam, wilcox,
+ wilcoxeb), threshold="user", maxrank=50)
> show(GeneSel)

GeneSelector run with gene rankings from the following statistics:
ordinaryT
BaldiLongT
FoxDimmicT
Sam
Wilcoxon
WilcEbam
Number of genes below threshold rank 50 in all statistics:29

> sel <- sum(slot(GeneSel, "selected"))
> cbind(mean = toplist(AggMean, top = sel, show = F), MC = toplist(AggMC, top
+ = sel, show = F), GeneSelector = toplist(GeneSel, top = sel, show = F)[,1])

index index GeneSelector
4
11
2
26
5
9
38
28
40
12
7
29
30
14
33
1799
820
1146
1633
1551
724
1258
1199
100

5
5
1
4
4
2
11
11
3
2
2
4
9
9
5
28
26
6
26
28
7
38
38
8
7
7
9
29
29
10
14
14
11
30
30
12
40
820
13
820
40
14
12
12
15
16
33
33
17 1799 1799
18 1146
23
19 1633 1146
20 1677 1633
21 1258 1258
1
22 1551
23
937
937
24 1715 1677

12

724 1551
25
26 1370 1715
724
27
100
28 1641
6
29 1199 1370

>

1370
937
1715
1267
476

Here, we have ﬁrst determined the number of genes passing the GeneSelector ﬁlter. In
total, 29 genes manage to fall below rank 50 in all six rankings. Although the GeneSelector
attempts to minimize the number of false positives, one still ends up with 14 false positive
genes among the 29 selected ones. In this regard, the Markov chain approach is superior,
because it selects only 11 false positive ones. Simple averaging seems to perform slightly
worse, putting the false positive gene 820 at position 13. In contrast, the ﬁrst false positive
gene of the GeneSelector occurs at position 16. A nice feature we want to present at
the end is the plot routine for the class GeneSelector. It allows one to obtain a detailed
gene-speciﬁc overview:

> plot(GeneSel, which = 1)
>

13

GeneInfoScreen for gene  1+selected ?criterionrankWilcEbam141 − 2020 − 100100 − 200200 − 500500 − 2000+selected ?criterionrankWilcoxon111 − 2020 − 100100 − 200200 − 500500 − 2000−selected ?criterionrankSam531 − 2020 − 100100 − 200200 − 500500 − 2000−selected ?criterionrankFoxDimmicT5441 − 2020 − 100100 − 200200 − 500500 − 2000−selected ?criterionrankBaldiLongT3571 − 2020 − 100100 − 200200 − 500500 − 2000+selected ?criterionrankordinaryT111 − 2020 − 100100 − 200200 − 500500 − 2000Interestingly, for the ﬁrst, diﬀerentially expressed gene, simple approaches such as the
ordinary t- and the Wilcoxon statistic perform well, while the more sophisticated statistics,
which depend on hyperparameters, fail to detect diﬀerential expression.

References

S. Aerts, D. Lambrechts, S. Maity, P. Van Loo, B. Coessens, F. DeSmet, L.-C. Tranchevent,
B. DeMoor, P. Marynen, B. Hassan, P. Carmeliet, and Y. Moreau. Gene prioritization
through genomic data fusion. Nature Biotechnology, pages 537–544, 2006.

P. Baldi and A.D. Long. A Bayesian framework for the analysis of microarray expression
data: regularized t-test and statistical inferences of gene changes. Bioinformatics, 17:
509–519, 2001.

R. P. DeConde, S. Hawley, S. Falcon, N. Clegg, B. Knudsen, and r. Etzioni. Combining
results of microarray experiments: a rank aggregation approach. Statistical Applications
in Genetics and Molecular Biology, 5:15, 2006.

B. Efron and R. Tibshirani. Empirical Bayes Methods and False Discovery Rates for

Microarrays. Genetic Epidemiology, 23:70–86, 2002.

B. Efron, R. Tibshirani, J.D. Storey, and V. Tusher. Empirical Bayes Analysis of a Mi-
croarray Experiment. Journal of the American Statistical Association, 96:1151–1160,
2001.

L. Ein-Dor, O. Zuk, and E. Domany. Thousands of samples are needed to generate a
robust gene list for predicting outcome in cancer. Proceedings of the National Academy
of Sciences of the USA, 103:5923–5928, 2006.

R.J. Fox and M.W. Dimmic. A two sample Bayesian t-test for microarray data. BMC

Bioinformatics, 7:126, 2006.

J. P. A. Ioannidis. Microarrays and molecular research: noise discovery? The Lancet, 365:

454–455, 2005.

G. Jurman, S. Merler, A. Barla, S. Paoli, A. Galea, and C. Furlanello. Algebraic stability
indicators for ranked lists in molecular proﬁling. Bioinformatics, 24:258–264, 2008.

I. L¨onnstedt and T. Speed. Replicated Microarray Data. Statistica Sinica, 12:31–46, 2002.

R. Opgen-Rhein and K. Strimmer. Accurate Ranking of Diﬀerentially Expressed Genes
by a Distribution-Free Shrinkage Approach. Statistical Applications in Genetics and
Molecular Biology, 6:Iss.1, Art.9, 2007.

X. Qiu, Y. Xiao, A. Gordon, and A. Yakovlev. Assessing stability of gene selection in

microarray data analysis. BMC Bioinformatics, pages 7–50, 2007.

G.K. Smyth. Linear models and empirical Bayes methods for assessing diﬀerential ex-
pression in microarray experiments. Statistical Applications in Genetics and Molecular
Biology, 3, 2004.

14

V. Tusher, R. Tibshirani, and G. Chu. Signiﬁcance analysis of microarrays applied to
the ionizing radiation response. Proceedings of the National Academy of Sciences of the
USA, 98:5116–5121, 2001.

B. Wu. Diﬀerential gene expression using penalized linear regression models: The improved

SAM statistic. Bioinformatics, 21:1565–1571, 2005.

X. Yang, S. Bentink, S. Scheid, and R. Spang. Similarities of ordered gene lists. Journal

of Bioinformatics and Compuational Biology, 4:693–708, 2006.

15

