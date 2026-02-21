How To Use CORREP to Estimate Multivariate
Correlation and Statistical Inference Procedures

Dongxiao Zhu

October 30, 2017

1 Introduction

OMICS data are increasingly available to biomedical researchers, and (biologi-
cal) replications are more and more aﬀordable for gene microarray experiments
or proteomics experiments. The functional relationship between a pair of genes
or proteins are often inferred by calculating correlation coeﬃcient between their
expression proﬁles. Classical correlation estimation techniques, such as Pearson
correlation coeﬃcient, do not explicitly take replicated data into account. As a
result, biological replicates are often averaged before correlations are calculated.
The averaging is not justiﬁed if there is poor concordance between samples and
the variance in each sample is not similar. Based on our recently proposed
multivariate correlation estimator, CORREP implements functions for estimat-
ing multivariate correlation for replicated OMICS data and statistical inference
procedures. In this vignette I demo an non-trivial task accomplished using COR-
REP. First let’s look at examples of replicated OMICS data and non-replicated
OMICS data.

x11, x12, . . . , x1n

x21, x22, . . . , x2n

. . .

xm11, xm12, . . . , xm1n

y11, y12, . . . , y1n

y21, y22, . . . , y2n

. . .

ym21, ym22, . . . , ym2n

x1, x2, . . . , xn

y1, y2, . . . , yn

versus

In this toy example, X and Y are a pair of genes or proteins of interest.
Using microarray or mass spectrum we were able to proﬁle their expression over
n biological conditions such as knockouts, overexpression or SiRNA treatments
either with replication (upper example) or without replication (lower example).
There are m1 and m2 replicates for X and Y respectively. It is often biological

1

interest how strong is the correlation between X and Y over n conditions and
how signiﬁcant the correlation is. Signiﬁcant correlation between X and Y often
indicates potential functional relevancy. In addition, 1-correlation are usually
used to calculate distance matrix of a number of genes or proteins to perform hi-
erarchical clustering. Therefore, correlation estimation is an important problem
in functional genomics research.

For non-replicated OMICS data, estimating correlation is relatively trivial
since there are plenty of established methods such as Pearson correlation coeﬃ-
cient and its non-parametric alternatives: Spearman’s ρ and Kendall’s τ . How-
ever it is not straightforward to estimate correlation from replicated OMICS
data. A naive approach may be to average over replicates to transform the
replicated data into non-replicated data. This approach might work for relative
“clean” data in which the within-replicate correlation is relatively high. Unfor-
tunately most OMICS data are noisy reﬂected partially by poor within-replicate
correlation. The averaging for those “noisy” data is not justiﬁed. In order to
properly estimate correlation of X and Y from replicated data, we must explic-
itly model the within-replicate correlation together with the between-replicate
correlation. The next section brieﬂy describes the models and methods for
deriving the multivariate correlation estimator. For interested reader, please re-
fer to our manuscript for more technical details [Zhu and Li, 2007]. Interested
reader also refer to [Medvedovic et al., 2004] for related Bayesian mixture model
methods.

2 Methods

2.1 Pearson correlation estimator

Instead of averaging, we exploit all the replicated observations by assuming the
data are i.i.d. samples from a multivariate normal distribution with a speciﬁed
correlation matrix and a mean vector, i.e., Zj = (xj1, . . . , xjp, yj1, . . . , yjq)T ,
j = 1, 2, . . . , n, follows a p + q-variate normal distribution N (µ, Σ), where

(cid:21)
, em = (1, . . . , 1)T is a m × 1 vector, the correlation matrix

µ =

(cid:20) µxem
µyem

Σ is a (p + q) × (p + q) matrix with structure:

Σ =













1
...
ρx
ρ
...
ρ

. . . ρx
...
. . .
1
. . .
. . . ρ
...
. . .
. . . ρ

ρ
...
ρ
1
...
ρy













. . . ρ
...
. . .
. . . ρ
. . . ρy
...
. . .
1
. . .

=

(cid:20) Σx
ΣT

Σxy
xy Σy

(cid:21)

,

(1)

where the inter-molecule correlation ρ is the parameter of interest, and the intra-
molecule correlation ρx or ρy are nuisance parameters. The ρx and ρy indicate
the quality of replicates that high quality replicates tend to have high value, and
vice versa. We employ three parameters: ρ, ρx and ρy to model the correlation
structure of replicated omics data.

2

2.2 Multivariate correlation estimator

Assuming a multivariate normal model, the Maximum Likelihood Estimate
(MLE) of ρ can be derived as follows (see Manuscript for more details):

Similarly,

therefore, ˆµ =

(cid:21)

(cid:20) ˆµxem
ˆµyem

The MLE of Σ is

ˆµx =

1
n

1
m

n
(cid:88)

m
(cid:88)

j=1

i=1

xij

ˆµy =

1
n

1
m

n
(cid:88)

m
(cid:88)

j=1

i=1

yij

ˆΣ =

1
n

n
(cid:88)

j=1

(Zj − ˆµ)(Zj − ˆµ)T

(2)

(3)

(4)

To derive the MLE of ρ, the ideal method would be obtaining the likelihood
explicitly as a function of ρ. However, this proved to be intractable in practice
(see manscript for detailed discussion). Our approach is to use the average of
the elements of ˆΣxy estimated via Eq. 4:

The sample Pearson correlation coeﬃcient can be also written into the fol-

ˆρ = Avg( ˆΣxy)

(5)

lowing form:

cor(X, Y ) =

(cid:80)n

j=1(¯xj − ¯x)(¯yj − ¯y)

(n − 1)SX SY

,

(6)

where SX and SY are standard deviations of X and Y respectively. When there
is no replicate (m1 = m2 = 1), the correlation matrix Σ is reduced to a 2 by 2
matrix with diagonal elements equal to 1 and oﬀ-diagonal elements equal to ρ.
It is easy to show from Eq. 4 that

ˆρ =

(cid:80)n

j=1(¯xj − ¯x)(¯yj − ¯y)

nSX SY

(7)

Hence we derive the connection between the two estimators when there is no
replicate as follows:

ˆρ =

cor.

(8)

n − 1
n

2.3 Statistical inference procedures

For very small sample data, eg, n < 4, we recommend using all permutations
to approximate the null distribution (see Manuscript for detail). For larger
sample data, we provide a Likelihood Ratio (LR) test. For moderate to large
sample data, we provide a LRT procedure for testing the hypothesis that the

3

multivariate correlation ρ vanishes. Under the multivariate normal distribution
assumption, Zj ∼ N (µ, Σ), and we test the following hypothesis:

H0 : Z ∈ N (µ, Σ0) versus Hα : Z ∈ N (µ, Σ1).

(9)

Here, both Σ0 and Σ1 are (m1 + m2) × (m1 + m2) matrices, where m1 and m2
(cid:19)

are number of replicates for biomolecule X and Y and Σ0 =

(cid:18) Σx
0T
m2

0m1
Σy

,

Σ1 =

(cid:18) Σx Σxy
xy Σy

ΣT

(cid:19)

, where Σx and Σy, with diagonal elements identity and

all the other entries being ρx and ρy respectively. 0m1 is a m1 × m1 zero
matrix and 0m2 is a m2 × m2 zero matrix, that is, under the null hypothesis,
the intermolecule correlation ρ vanishes. Σxy is a m1 × m1 matrix with all
entries equal to ρ. Likewise ΣT
xy is a m2 × m2 matrix with all entries equal to
ρ . The Likelihood Ratio (LR) statistic for testing the two diﬀerent correlation
structures can be derived as follows:

∧ =

2

| ˆΣ0|−n/2e− 1
| ˆΣ1|−n/2e− 1

2

(cid:80)n

j=1

(cid:80)n

j=1

(cid:48)
(Zj −ˆµ)

( ˆΣ0)−1(Zj −ˆµ)

(Zj −ˆµ)(cid:48) ( ˆΣ1)−1(Zj −ˆµ)

.

(10)

Note that for the test to be a true LRT, all the estimated quantities ˆ(·) in the
above formula should be MLE’s. In Section 2.2, Eqs. 2, 3 and 4 give the formula
of MLE’s of the mean vector and the correlation matrix under Hα. The MLE
(cid:19)
of the correlation matrix under H0 can be determined as ˆΣ0 =

,

(cid:18) ˆΣx O
O ˆΣy

where

ˆΣx =

ˆΣy =

1
n

1
n

n
(cid:88)

j=1
n
(cid:88)

j=1

(Xj − ˆµx)(Xj − ˆµx)(cid:48),

(Yj − ˆµy)(Yj − ˆµy)(cid:48).

(11)

(12)

The LR statistic, denoted by G2, is therefore:

G2 = −2log∧ = n[trM − log|M | − (m1 + m2)],

(13)

where M = ( ˆΣ0)−1 ˆΣ1. The LR statistic is asymptotically chi-square distributed
with 2(m1 ∗ m2) degrees of freedom under H0.

3 Data Analysis Examples

In this example, we will analyze a subset of 205 genes whose expression were pro-
ﬁled using 4 replicates under 20 physiological/genetic conditions [Medvedovic et al., 2004].
The whole data was initially reported in [Ideker et al., 2000] We ﬁrst estimate
all pairwise correlation and then we use 1-correlation as distance measure to
cluster these genes. Medvedovic et al, 2004 [Medvedovic et al., 2004] has al-
ready classiﬁed the 205 genes into 4 functional groups according to their GO
annotations. The four classes are:

4

(cid:136) Biosynthesis; protein metabolism and modiﬁcation

(cid:136) Energy pathways; carbohydrate metabolism; catabolism

(cid:136) Nucleobase, nucleoside, nucleotide and nucleic acid metabolism

(cid:136) Transport

The membership of 205 genes were stored in the internal data “true.member”.
We were able to compare the performance of our multivariate correlation esti-
mator versus Pearson correlation estimator through hierarchical clustering by
comparing clustering results to the “external knowledge” above.

> library(CORREP)
> data(gal_all)
> ##Take average
> gal_avg <- apply(gal_all, 1, function(x) c(mean(x[1:4]), mean(x[5:8]), mean(x[9:12]), mean(x[13:16]), mean(x[17:20]), mean(x[21:24]), mean(x[25:28]), mean(x[29:32]), mean(x[33:36]), mean(x[37:40]), mean(x[41:44]), mean(x[45:48]),
+ mean(x[49:52]), mean(x[53:56]), mean(x[57:60]), mean(x[61:64]), mean(x[65:68]), mean(x[69:72]), mean(x[73:76]), mean(x[77:80])))
> ##Estimate routine correlation based on average profile
> M1 <- cor(gal_avg)

The above code is to calculate a 205 by 205 correlation matrix using Pearson
correlation coeﬃcient implemented in R function cor. Note that we have to
average over replicates before the straight-forward application of Pearson corre-
lation coeﬃcient can be done. As we mentioned in the paper, the data used in
this example is relatively “clean” data (see the boxplot below for distribution of
within-replicate correlation), which is not favorable condition to apply our es-
timator, however, the following clustering results show that it still signiﬁcantly
outperforms Pearson correlation coeﬃcient.

> ##Take the first row and format
> x <- gal_all[1,]
> x <- cbind(t(x[1:4]),t(x[5:8]),t(x[9:12]),t(x[13:16]),t(x[17:20]),t(x[21:24]),t(x[25:28]),t(x[29:32]),t(x[33:36]),t(x[37:40]),t(x[41:44]),t(x[45:48]),t(x[49:52]),t(x[53:56]),t(x[57:60]),t(x[61:64]),t(x[65:68]),t(x[69:72]),t(x[73:76]),t(x[77:80]))
> ##Loop through to format each row
> for(j in 2:205)
+ {
+ y <- gal_all[j,]
+ y <- cbind(t(y[1:4]),t(y[5:8]),t(y[9:12]),t(y[13:16]),t(y[17:20]),t(y[21:24]),t(y[25:28]),t(y[29:32]),t(y[33:36]),t(y[37:40]),t(y[41:44]),t(y[45:48]),t(y[49:52]),t(y[53:56]),t(y[57:60]),t(y[61:64]),t(y[65:68]),t(y[69:72]),t(y[73:76]),t(y[77:80]))
+ x <- rbind(x,y)
+ }
> boxplot(cor(x))
> rawdata <- x
> stddata <- apply(rawdata, 1, function(x) x/sd(x))
> stddata <- t(stddata)

The above code is to reshape the data to be compatible with functions imple-
mented in this package. This step is not absolutely necessary if your data is
already in the right format, for example, columns correspond to conditions and
rows correspond to (replicated) variables. For example, a 820 by 20 matrix for
this data. Moreover, data has to be standardized by making variance of
each row (gene) equals to 1. The standardization is VERY important
and must be followed.

5

> M <- cor.balance(stddata, m = 4, G= 205)

The above code is to calculate 205 by 205 correlation matrix using the new mul-
tivariate correlation estimator implemented in R function cor.balance. Note
that there are equivalent number of replicates for this data (balanced). For
unbalanced data, R function cor.unbalance should be used.

> row.names(M) <- row.names(M1)
> colnames(M) <- colnames(M1)

We next use 1-correlation as distance measure to cluster the genes into 4 groups,
and compare the consistency between these 4 groups and pre-deﬁned 4 groups.

> M.rep <- 1-M
> M.avg <- 1-M1
> d.rep <- as.dist(M.rep)
> d.avg <- as.dist(M.avg)

The above code calculates distance matrix for hierarchical clustering using both
Pearson correlation coeﬃcient and multivariate correlation estimator.

> library(e1071)
> library(cluster)
> data(true.member)
> g.rep <- diana(d.rep)
> g.avg <- diana(d.avg)

The above code does hierarchical clustering in a top-down fashion ie, Diana,
and classiﬁes all 205 genes into a number of clusters. We recommend using
top-down method in this case since we are interested in identifying a few (4)
large clusters. For other data, if you are interested in identifying a lot of small
clusters, we recommend using agglomerative hierarchical clustering methods.
See below for examples.

> h.rep <- hclust(d.rep, method = "complete")
> h.avg <- hclust(d.avg, method = "complete")

The R function hclust can be applied to perform bottom-up hierarchical clus-
tering. In addition to choosing a proper distance measure, we will need to de-
termine a method to measure distance between objects such as are “complete”,
“average”, “single”. Option “average” seems to be robust in most of cases.

> member.rep.k4 <- cutree(g.rep, k = 4)
> member.avg.k4 <- cutree(g.avg, k = 4)
> classAgreement(table(member.avg.k4, as.matrix(true.member)))

$diag
[1] 0

$kappa
[1] -0.3751636

$rand
[1] 0.9437111

6

$crand
[1] 0.8792274

> classAgreement(table(member.rep.k4, as.matrix(true.member)))

$diag
[1] 0.06341463

$kappa
[1] -0.2491669

$rand
[1] 0.9751315

$crand
[1] 0.9473288

The above code retrieves the membership of 205 genes as determined by divisive
clustering, and accesses consistency of the memberships with the “true” cluster
membership (external knowledge) using adjusted RAND index. The function
classAgreement that was used to calculate adjusted RAND index is from “e1071”
package. It is obvious that clustering results based on multivariate correlation
estimator are more consistent to the external knowledge (higher adjusted RAND
index).

We can also examine the “quality” of clusters using, for example, silhouette
plot. Here quality roughly means that ratio between within-cluster deviation
and between-cluster deviation. Although it is statistically true that good quality
clusters indicate better clustering performance, it is not necessarily true biolog-
ically. Good quality clusters are only a suﬃcient condition for good clustering
performance but not a necessary condition.

> sil.rep4 <- silhouette(member.rep.k4, d.rep)
> sil.avg4 <- silhouette(member.avg.k4, d.avg)
> plot(sil.rep4, nmax = 80, cex.names = 0.5)
> plot(sil.avg4, nmax = 80, cex.names = 0.5)

References

[Medvedovic et al., 2004] Medvedovic, M., Yeung, K.Y., Bumgarner, R.E.
(2004) Bayesian mixtures for clustering replicated microarray data. Bioin-
formatics, 20, 1222-1232.

[Ideker et al., 2000] Ideker, T., Thorsson, V., Siegel, A.F. and Hood, L.E. 2000.
Testing for diﬀerentially-expressed genes by maximum-likelihood analysis of
microarray data. J. Comput. Biol., 7, 805-817.

[Zhu and Li, 2007] Zhu, D and Li, Y. 2007. Multivariate Correlation Estima-
tor for Inferring Functional Relationships from Replicated ‘OMICS’ Data.
Submitted.

7

