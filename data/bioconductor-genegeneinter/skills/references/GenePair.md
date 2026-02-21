GeneGeneInteR vignette
Statistical analysis of the interaction between a pair of genes.

Mathieu Emily and Magalie Hou´ee-Bigot

October 30, 2018

This vignette presents the technical details of the statistical procedure implemented in the package. Readers
that would like to have a global overview of the main functions and tools proposed in the package are encouraged
to read the vignette VignetteGeneGeneInteR Introduction.

1 Introduction

In this vignette we consider statistical procedures to test for the interaction between two genes in susceptibility
with a binary phenotype, typically a case/control disease status. Let Y ∈ {0, 1} be the phenotype, where Y = 0
stands for a control and Y = 1 a case, and X1 and X2 be the two genes for which the interaction is tested.

Let consider a sample of n individuals with nc controls and nd cases (nc+nd = n) and Y = [y1, . . . , yn](cid:48) the vector
of the observed binary phenotypes. Each gene is a collection of respectively m1 and m2 SNPs. The observed
genotypes for gene X1 can be represented by a n × m1 matrix: X1 = [x1
ij ∈ {0; 1; 2} is
the number of copies of the minor allele for SNP j carried by individual i. A similar representation is used for
gene X2 where X2 is a n × m2 matrix. Let us further introduce Xc
2 the matrices of observed genotypes
among controls for gene 1 and 2 and Xd
1 is a nc × m1 matrix,
Xd
1 a nd × m1 matrix, Xc
2 a nd × m2 matrix. A general setup of the observed values
can be presented as follows:

2 among cases for both genes. Thus Xc

2 a nc × m2 matrix and Xd

ij]i∈1...n;j∈1...m1 where x1

1 and Xd

1 and Xc

Y =













X1 =













y1
...
ync
ync+1
...
ync+nd











Xc
1

Xd
1











=













x1
11
...
x1

nc1

...

x1

(nc+1)1

. . .
. . .
. . .
. . .
. . .
. . .

1m1

x1
...

x1

ncm1

x1

(nc+1)m1

...













X2 =











Xc
2

Xd
2











=













x2
11
...
x2

nc1

...

x2

(nc+1)1

1m2

x2
...

x2

ncm1

x2

(nc+1)m1

...













. . .
. . .
. . .
. . .
. . .
. . .

x1

(nc+nd)1

x1

(nc+nd)m1

x2

(nc+nd)1

x2

(nc+nd)m1

In our package we proposed 10 methods for testing interaction at the gene level. These 10 methods are all
based on three main parameters: Y, a numeric or factor vector with exactly two distinct values, G1 and G2 two
SnpMatrix objects as proposed by the R Bioconductor package snpStats. Our implementation is illustrated by
the dataset gene.pair provided with the GeneGeneInteR package and summarized in the following command
lines:

> library("GeneGeneInteR")
> data("gene.pair")
> head(gene.pair$Y)

[1] HealthControl HealthControl HealthControl HealthControl HealthControl
Levels: HealthControl RheumatoidArthritis

> gene.pair$G1

1

A SnpMatrix with 453 rows and 8 columns
Row names: Id1 ... Id453
Col names: rs1491710 ... rs2298849

> gene.pair$G2

A SnpMatrix with 453 rows and 4 columns
Row names: Id1 ... Id453
Col names: rs2057094 ... rs1005753

The 10 methods implemented in our package can be divided into two main families: 6 methods based on a
multidimensional modeling of the interaction at the gene level and 4 methods that combine interaction tests at
the SNP level into a single test at the gene level.

2 Multidimensional methods at the gene level

In the GeneGeneInteR package, 6 multidimensional methods have been implemented that are based on:

(cid:136) Principal Components Analysis - PCA.test function,

(cid:136) Canonical Correlation Analysis - CCA.test function,

(cid:136) Kernel Canonical Correlation Analysis - KCCA.test function,

(cid:136) Composite Linkage Disequilibrium - CLD.test function,

(cid:136) Partial Least Square Path Modeling - PLSPM.test function,

(cid:136) Gene-Based Information Gain Method - GBIGM.test function.

In the remainder of this section, technical and practical details are given regarding these 6 methods.

2.1 PCA-based

In the PCA-based method, a likelihood ratio test is performed to compare the model MInter to the model
MN o, where MInter is deﬁned by:

logit (cid:0)P (cid:2)Y = 1|P C 1
X1

. . . P C n1
X1

, P C 1
X2

. . . P C n2
X2

(cid:3)(cid:1) = β0 +

n1(cid:88)

i=1

P C i

X1

+

n2(cid:88)

j=1

P C j
X2

+

n1(cid:88)

n2(cid:88)

i=1

i=2

P C i

X1

P C j
X2

and MN o by:

logit (cid:0)P (cid:2)Y = 1|P C 1
X1

. . . P C n1
X1

, P C 1
X2

. . . P C n2
X2

(cid:3)(cid:1) = β0 +

n1(cid:88)

i=1

P C i

X1

+

n2(cid:88)

j=1

P C j
X2

In models MInter and MN o, P C i
are the ith principal component of X1 and the jth principal
component of X2. The number of principal components, n1 and n2, kept in the interaction test is determined
by the percentage of inertia retrieved by the PCA. Such a percentage is deﬁned by the user and corresponds to
the threshold parameter.

and P C j
X2

X1

In our package, two distinct Principal Component decomposition are provided by the functions PCA.test via
the argument method. With method="Std", dataset is standardized using variables’ standard deviation while
with method="GenFreq", dataset is standardized using standard deviation under Hardy-Weinberg equilibrium,
as proposed in the snpStats package.

When the percentage of inertia asked by the user is high, the number of PCs can be important and ﬁtting
logistic models MInter and MN o is likely to fail. In that case, the number of PCs in each gene is iteratively
reduced until convergence of the glm function for ﬁtting models MInter and MN o.

2

The following lines provide an example of the PCA.test function:

> PCA.test(Y=gene.pair$Y, G1=gene.pair$G1, G2=gene.pair$G2,threshold=0.7,
+ method="GenFreq")

Gene-based interaction based on Principal Component Analysis - GenFreq

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
Deviance = 8.2157, df = 6.0, threshold = 0.7, p-value = 0.2227
alternative hypothesis: true deviance is greater than 0
sample estimates:
Deviance without interaction
615.2977

Deviance with interaction
607.0821

> PCA.test(Y=gene.pair$Y, G1=gene.pair$G1, G2=gene.pair$G2,threshold=0.7,
+ method="Std")

Gene-based interaction based on Principal Component Analysis - Std

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
Deviance = 8.5074, df = 6.0, threshold = 0.7, p-value = 0.2032
alternative hypothesis: true deviance is greater than 0
sample estimates:
Deviance without interaction
615.0911

Deviance with interaction
606.5837

2.2 Canonical Correlation Analysis (CCA)

The CCA test is based on a Wald-type statistic deﬁned as follows (see [Peng et al., 2010] for details):

UCCA =

2 (log(1 + rd) − log(1 − rd)) and zc = 1

zd − zc
(cid:112)V(zd) + V(zc)
where zd = 1
2 (log(1 + rc) − log(1 − rc)) with rd the maximum canonical
correlation coeﬃcient between Xd
2 and rc the maximum canonical correlation coeﬃcient between Xc
1
2 computed for controls (Y = 0). As suggested by [Peng et al., 2010], the sampled variances V(zd) and
and Xc
V(zc) were evaluated by applying a bootstrapping method. The number of bootstrap sample used to estimate
V(zd) and V(zc) is determined by the n.boot argument. P-value is then obtained by noting that under the null
hypothesis UCCA ∼ N (0, 1).

1 and Xd

CCA based gene-gene interaction is implemented in the CCA.test function and mainly depends on the cancor
function from the Stats package [R Core Team, 2016].

R> set.seed(1234)

> CCA.test(Y=gene.pair$Y, G1=gene.pair$G1, G2=gene.pair$G2,n.boot=500)

Gene-based interaction based on Canonical Correspondance Analysis

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
CCU = 0.60304, n.boot = 500, p-value = 0.5465
alternative hypothesis: true CCU is not equal to 0
sample estimates:
z0

z1
0.2940799 0.2414700

3

2.3 Kernel Canonical Correlation Analysis (KCCA)

The KCCA based test provides a generalization of CCA test to detect non-linear co-association between X1
and X2 [Yuan et al., 2012, Larson and Schaid, 2013] and is based on the following Wald-type statistic:

UKCCA =

kzd − kzc
(cid:112)V(kzd) + V(kzc)

2 (log(1 + krd) − log(1 − krd)) and kzc = 1

where kzd = 1
kernel canonical correlation coeﬃcient between Xd
1 and Xc
coeﬃcient between Xc
2.

1 and Xd

2 (log(1 + krc) − log(1 − krc)) with krd the maximum
2 and krc the maximum kernel canonical correlation

Similar to the CCA test, V(kzd) and V(kzc) are estimated using bootstrap techniques [Yuan et al., 2012,
Larson and Schaid, 2013] and the p-value is obtained using the standard gaussian distribution of UKCCA under
the null hypothesis. Since the performance of kernel methods strongly relates to the choice of kernel functions,
the default is the Radial Basis kernel Function (RBF) owing to its ﬂexibility in parameter speciﬁcation. How-
ever, other kernel functions, such as linear, polynomial or spline kernels, can be used. Thus, in addition to
the three arguments Y, G1 and G2, our implementation of the KCCA test proposes two optional arguments:
n.boot that determines the number of bootstrap samples and kernel that provides the kernel function to be
used. This kernel parameter is character string matching one of the kernel name provided by the kernlab
package [Karatzoglou et al., 2004] such as ”rbfdot”, ”polydot”, ”tanhdot”, ”vanilladot”, ”laplacedot”, ”besseldot”,
”anovadot”, ”splinedot”. Speciﬁc arguments, sigma, degree, scale, offsetand order, can also be passed to
the kcca.test function in order to parameterized the kernel used in the analysis.

KCCA based gene-gene interaction test is implemented in the KCCA.test function and mainly depends on the
kcca function from the kernlab package [Karatzoglou et al., 2004].

> set.seed(1234)
> KCCA.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,
+ kernel="rbfdot",sigma = 0.05,n.boot=500)

Gene-based interaction based on Kernel Canonical Correspondance
Analysis

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
KCCU = 1.4055, n.boot = 500, p-value = 0.1599
alternative hypothesis: true KCCU is not equal to 0
sample estimates:
z0

z1
3.717346 -3.759154

> set.seed(1234)
> KCCA.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,
+ kernel="polydot",degree = 1, scale = 1, offset = 1)

Gene-based interaction based on Kernel Canonical Correspondance
Analysis

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
KCCU = 1.4106, n.boot = 100, p-value = 0.1584
alternative hypothesis: true KCCU is not equal to 0
sample estimates:
z0

z1
4.161048 -4.251702

4

2.4 Partial Least Square Path Modeling (PLSPM)

The PLSPM testing has been introduced by [Zhang et al., 2013] and is based on the Wald-like statistic:

UP LSP M =

βd − βc
(cid:112)V(βd − βc)

where βd (resp. βc) is the path coeﬃcient between Xd
the distribution of UP LSP M is unknown and signiﬁcance can be tested with bootstrapping method.

2 (resp. Xc

1 and Xd

1 and Xc

2). As quoted by [Zhang et al., 2013],

PLSPM based gene-gene interaction test is implemented in the PLSPM.test function and mainly depends on
the plspm function from the plspm package [Sanchez et al., 2015].

> set.seed(1234)
> PLSPM.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,n.perm=1000)

Gene-based interaction based on Partial Least Squares Path Modeling

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
U = 4.0938, n.perm = 1000, p-value = 0.18
alternative hypothesis: true U is not equal to 0
sample estimates:

beta0

beta1
-0.2125869 0.2434624

2.5 Composite Linkage Disequilibrium (CLD)

The CLD method, proposed in [Rajapakse et al., 2012] is based on the normalized quadratic distance (NQD)
and is deﬁned as

δ2 = tr.

(cid:16)

( ˜D − ˜C)W −1( ˜D − ˜C)W −1(cid:17)

where ˜D, ˜C and W are three (m1 + m2) × (m1 + m2) matrices of the covariance between the whole set of SNPs
that combines SNPs from both genes. More precisely, ˜D and ˜C are deﬁned as follows:

˜D =

(cid:20)W11 D12
D21 W22

(cid:21)

˜C =

(cid:20)W11 C12
C21 W22

(cid:21)

21) are the sample covariance matrix between the two genes estimated from (cid:0)Xd

where W11 (resp. W22) is the pooled estimate of the covariance matrix for X1 (resp. X2, D12(= D(cid:48)
21) and
(cid:1) and (Xc
C12(= C (cid:48)
1, Xc
2)
respectively. In more details, the sample covariance matrices in cases, denoted by D, and in controls, denoted
by C, can be partitioned in 4 blocks as follows:

1, Xd
2

D = Cov (cid:0)Xd

1, Xd
2

(cid:1) =

(cid:21)

(cid:20)D11 D12
D21 D22

C = Cov (Xc

1, Xc

2) =

(cid:21)

(cid:20)C11 C12
C21 C22

The pooled estimate of the covariance matrix, W , can thus been obtained by:

W =

ncC + ndD
nc + nd

=

(cid:20)W11 W12
W21 W22

(cid:21)

Since the distribution of δ2 is not known under the null hypothesis, signiﬁcance testing is performed using
permutation tests, as proposed by [Rajapakse et al., 2012]. Such a test has been implemented in our package
in the CLD.test function where the number of permutations is determined by the argument n.perm.

> set.seed(1234)
> CLD.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,n.perm=2000)

5

Gene-based interaction based on Composite Linkage Disequilibrium

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
CLD = 0.49257, n.perm = 2000, p-value = 0.8865
alternative hypothesis: true CLD is not equal to 0
sample estimates:

CLD
0.4925654

2.6 Gene-Based Information Gain Method (GBIGM)

Introduced by [Li et al., 2015], the GBIGM method is based on the information gain rate ∆R1,2. ∆R1,2 is
deﬁned as follows:

∆R1,2 =

min(H1, H2) − H1,2
min(H1, H2)

where H1, H2, H1,2 are the conditional entropies, given the Y, of X1, X2 and the pooled SNP set (X1, X2)
respectively. Assuming that H(.) is the classical entropy function, we have:

H1 = H(Y, X1) − H(X1)
H2 = H(Y, X2) − H(X2)

H1,2 = H(Y, X1, X2) − H(X1, X2)

Since the distribution of ∆R1,2 is unknown, the signiﬁcance testing is performed by permutations as suggested
by [Li et al., 2015]. The GBIGM method has been implemented in the GBIGM.test function and the number of
permutations is deﬁned by the argument n.perm.

> set.seed(1234)
> GBIGM.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,n.perm=2000)

Gene-based interaction based on Gene-based Information Gain Method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
DeltaR1,2 = 0.46441, n.perm = 2000, p-value = 0.441
alternative hypothesis: two.sided
sample estimates:
DeltaR1,2
0.4644093

3 From SNP-SNP interaction to Gene-Gene interaction testing

This section provides details of the four statistical methods that proposes a gene-based test from SNP-based
tests [Emily, 2016]. Rather than considering multiple SNPs in both gene as part of a joint model, these methods
aim at aggregating p-values obtained at the SNP level into a single p-value at a gene level.

Interaction testing at the SNP level
Let consider a pair of SNPs, (X1,j, X2,k) where X1,j is the jth SNP of gene X1 and X2,k the kth SNP of gene X2
(1 ≤ j ≤ m1 and 1 ≤ k ≤ m2). To test for interaction at the SNP level, we used the following Wald statistic:

Wjk =

(cid:100)βj,k
3
(cid:92)
(cid:18)
(cid:100)βj,k
3

(cid:19)

σ

6

where (cid:100)βj,k

3

is an estimate of the interaction coeﬃcient βj,k

3

of the following logistic model:

log

(cid:18) P[Y = 1|X1,j = x1, X2,k = x2]

(cid:19)

1 − P[Y = 1|X1,j = x1, X2,k = x2]

= βj,k

0 + βj,k

1 x1 + βj,k

2 x2 + βj,k

3 x1x2

(cid:100)βj,k
3

is obtained by maximizing the likelihood function on the observed data Y, X1 and X2 while

σ

(cid:19)

(cid:92)
(cid:18)
(cid:100)βj,k
3

is

calculating by inverting the Hessian of the likelihood. Since the solution of the maximization of the likelihood
function does not have a closed form, we compute Wjk according to the iteratively reweighted least squares
algorithm proposed in the glm function of the stats package [R Core Team, 2016] .

To combine the statistics Wjk into a single test, [Ma et al., 2013] proposed four methods that all account
, a (m1 × m2) × (m1 × m2) symmetric matrix where
for covariance matrix Σ = [σ(j,k),(j(cid:48),k(cid:48))] j=1...m1;k=1...m2
j(cid:48)=1...m1;k(cid:48)=1...m2

σ(j,k),(j(cid:48),k(cid:48)) = Cov(Wjk, Wj(cid:48),k(cid:48)). As proposed by [Emily, 2016], the covariance between Wjk and Wj(cid:48),k(cid:48)
estimated by:

is

where rj,j(cid:48) =

√

pjj(cid:48) −pj pj(cid:48)

pj (1−pj )pj(cid:48) (1−pj(cid:48) )

is the widely used correlation measure between SNP j and SNP j(cid:48), given that

pj and pj(cid:48) are the respective allelic frequencies and pjj(cid:48) is the joint allelic frequency [Hill and Robertson, 1968].

(cid:92)σ(j,k),(j(cid:48),k(cid:48)) = rj,j(cid:48)rk,k(cid:48)

In the remainder of this section, the four methods: minP (function minP.test, GATES (function gates.test),
tTS (function tTS.test) and tProd (function tProd.test) are detailed.

3.1 minP

The minP test is based on the minimum p-value that is often used to combine p-values of association (see
[Conneely and Boehnke, 2007]). Let Wmax = max |W11|, . . . , |Wm1,m2 | be the maximum of the absolute observed
statistics. The minP is then deﬁned by:

(cid:104)
minP = 1 − P

max(|Z1|, |Z2|, . . . , |Zm1m2|) < Wmax

(cid:105)
.

(1)

where Z = (Z1, Z2, . . . , Zm1m2) is a random vector that follows a multivariate normal distribution Z ∼ N (0, Σ).

The computation of Equation (1) requires the calculation of the probability distribution of a multivariate
normal random variable. For that purpose, we used the pmvnorm function from the R package mvtnorm
[Genz and Bretz, 2009].

> set.seed(1234)
> minP.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2)

Gene-based interaction based on minP method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
Wmax = 0.0099241, p-value = 0.1796
alternative hypothesis: true Wmax is greater than 0
sample estimates:
Wmax
0.009924148

3.2 GATES

7

The GATES procedure, proposed by [Li et al., 2011], is an extension of the Simes procedure used to assess
the gene level association signiﬁcance. Let p(1), . . . , p(m1m2) be the ascending SNP-SNP interaction m1 × m2
p-values, GATES p-value is then deﬁned by

pGAT ES = min

(cid:18) mep(1)
me(1)

,

mep(2)
me(2)

, . . . ,

(cid:19)

mep(m1m2)
me(m1m2)

where me is the number of eﬀective tests among the m1 × m2 tests and me(i) the number of eﬀective tests
among the i most signiﬁcative tests associated with the lowest order p-values p(1), . . . , p(i). The number of
eﬀective tests ought to characterize the number of independent tests equivalent to the correlated tests that are
really performed and is often used to account for dependence in a multiple testing correction.

Although no formal deﬁnition of the number of eﬀective tests has been formulated in the literature, several
procedures have been proposed to estimate such number. All methods are based on a transformation of the set of
eigenvalues of the SNP covariance matrix assuming that (1) if the SNPs are independent, the number of eﬀective
tests is the number of performed, (2) if the absolute value of the correlation between any pair of SNPs is equal to
1, the number of eﬀective tests is 1. In the GeneGeneInteR package, four main methods have been implemented
and can be chosen by the user with the argument merest: Cheverud-Nyholt method - me.est="ChevNy"
[Cheverud, 2001, Nyholt, 2004], Keﬀ method -me.est="Keff" [Moskvina and Schmidt, 2008], Li and Ji method
- me.est="LiJi" [Li and Ji, 2005] and Galwey - me.est="Galwey" [Galwey, 2009].

> set.seed(1234)
> gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,me.est="ChevNy")

Gene-based interaction based on GATES method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
GATES = 0.0099241, p-value = 0.2939
alternative hypothesis: less
sample estimates:
GATES
0.009924148

> set.seed(1234)
> gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,alpha=0.05,me.est="Keff")

Gene-based interaction based on GATES method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
GATES = 0.013945, p-value = 0.1899
alternative hypothesis: less
sample estimates:

GATES
0.01394543

> set.seed(1234)
> gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,me.est="LiJi")

Gene-based interaction based on GATES method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
GATES = 0.013945, p-value = 0.1255
alternative hypothesis: less
sample estimates:

GATES
0.01394543

8

> set.seed(1234)
> gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,me.est="Galwey")

Gene-based interaction based on GATES method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
GATES = 0.013945, p-value = 0.1596
alternative hypothesis: less
sample estimates:

GATES
0.01394543

9

3.3 tTS and tProd

tTS and tProd procedures are two truncated tail strength methods that aim at combining signals from all
single-SNP p-values less than a predeﬁned cutoﬀ value [Jiang et al., 2011]. Denoting by τ the cutoﬀ value, the
two truncated p-values are deﬁned as follows [Zaykin et al., 2002]:

tT S =

tP rod =

1
m1m2
m1m2(cid:89)

p

i=1

m1m2(cid:88)

i=1

I(p(i) < τ )

(cid:18)

1 − p(i)

(cid:19)

m1m2 + 1
i

I(pi<τ )
i

where I is the indicator function.

When p-values are correlated, the null distribution of tT S and tP rod are unknown. Following the approach
proposed by [Zaykin et al., 2002], a p-value is obtained in the GeneGeneInteR package by computing an em-
pirical null distribution using Monte-Carlo (MC) simulations. For each MC iteration, an empirical value for
tT S (or tP rod) is obtained by simulating a vector of Wjk with respect to a multivariate normal distribution
with a vector of 0 means and (cid:98)Σ as covariance matrix. The empirical p-value is calculated as the proportion of
simulated statistics larger than the observed statistic on the “true” set of Wjk.

tTS and tProd methods have been implemented in the functions tTS.test and tProd.test of the GeneGeneIn-
teR package. Additional to the mandatory Y, G1 and G2 arguments, these two functions have two optional
arguments: tau and n.sim that control the cutoﬀ value and the number of simulations used to estimate the
empirical value respectively. The following coding lines give an example of the tTS.test and tProd.test:

> set.seed(1234)
> tTS.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,tau=0.5,n.sim=10000)

Gene-based interaction based on the Truncated Tail Strength method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
tTS = -0.0099127, tau = 0.5, p-value = 0.5104
alternative hypothesis: less
sample estimates:

tTS
-0.009912706

> set.seed(1234)
> tProd.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,tau=0.05,n.sim=1000)

Gene-based interaction based on the Truncated Product method

data: gene.pair$Y and (gene.pair$G1 , gene.pair$G2)
tProd = 0.0001384, tau = 0.05, p-value = 0.265
alternative hypothesis: less
sample estimates:

tProd
0.0001383965

References

[Cheverud, 2001] Cheverud, J. M. (2001). A simple correction for multiple comparisons in interval mapping

genome scans. Heredity, 87(1):52–58.

10

[Conneely and Boehnke, 2007] Conneely, K. N. and Boehnke, M. (2007). So many correlated tests, so little
time! rapid adjustment of p values for multiple correlated tests. The American Journal of Human Genetics,
81(6):1158–1168.

[Emily, 2016] Emily, M. (2016). Aggregator: A gene-based gene-gene interacttion test for case-control associa-

tion studies. Statistical Applications in Genetics and Molecular Biology, 15(2):151–171.

[Galwey, 2009] Galwey, N. W. (2009). A new measure of the eﬀective number of tests, a practical tool for

comparing families of non-independent signiﬁcance tests. Genetic Epidemiology, 33(7):559–568.

[Genz and Bretz, 2009] Genz, A. and Bretz, F. (2009). Computation of Multivariate Normal and T Probabilities.

Springer Publishing Company, Incorporated, 1st edition.

[Hill and Robertson, 1968] Hill, W. G. and Robertson, A. (1968). Linkage diseqilibrium in ﬁnite populations.

Theoretical and Applied Genetics, 38:226–231.

[Jiang et al., 2011] Jiang, B., Zhang, X., Zuo, Y., and Kang, G. (2011). A powerful truncated tail strength
method for testing multiple null hypotheses in one dataset. Journal of Theoretical Biology, 277(1):67 – 73.

[Karatzoglou et al., 2004] Karatzoglou, A., Smola, A., Hornik, K., and Zeileis, A. (2004). kernlab – an S4

package for kernel methods in R. Journal of Statistical Software, 11(9):1–20.

[Larson and Schaid, 2013] Larson, N. B. and Schaid, D. J. (2013). A kernel regression approach to gene-gene

interaction detection for case-control studies. Genetic Epidemiology, 37(7):695–703.

[Li et al., 2015] Li, J., Huang, D., Guo, M., Liu, X., Wang, C., Teng, Z., Zhang, R., Jiang, Y., Lv, H., and
Wang, L. (2015). A gene-based information gain method for detecting gene-gene interactions in case-control
studies. European Journal of Human Genetics, Online:Online.

[Li and Ji, 2005] Li, J. and Ji, L. (2005). Adjusting multiple testing in multilocus analyses using the eigenvalues

of a correlation matrix. Heredity, 95:221–227.

[Li et al., 2011] Li, M.-X., Gui, H.-S., Kwan, J., and Sham, P. (2011). Gates: A rapid and powerful gene-based
association test using extended simes procedure. The American Journal of Human Genetics, 88(3):283–293.

[Ma et al., 2013] Ma, L., Clark, A. G., and Keinan, A. (2013). Gene-based testing of interactions in association

studies of quantitative traits. PLoS Genet, 9(2):e1003321.

[Moskvina and Schmidt, 2008] Moskvina, V. and Schmidt, K. M. (2008). On multiple-testing correction in

genome-wide association studies. Genetic Epidemiology, 32(6):567–573.

[Nyholt, 2004] Nyholt, D. R. (2004). A simple correction for multiple testing for single-nucleotide polymorphisms

in linkage disequilibrium with each other. The American Journal of Human Genetics, 74(4):765 – 769.

[Peng et al., 2010] Peng, Q., Zhao, J., and Xue, F. (2010). A gene-based method for detecting gene-gene co-

association in a case-control association study. European Journal of Human Genetics, 18(5):582–587.

[R Core Team, 2016] R Core Team (2016). R: A Language and Environment for Statistical Computing. R

Foundation for Statistical Computing, Vienna, Austria.

[Rajapakse et al., 2012] Rajapakse, I., Perlman, M. D., Martin, P. J., Hansen, J. A., and Kooperberg, C. (2012).

Multivariate detection of gene-gene interactions. Genetic Epidemiology, 36(6):622–630.

[Sanchez et al., 2015] Sanchez, G., Trinchera, L., and Russolillo, G. (2015). plspm: Tools for Partial Least

Squares Path Modeling (PLS-PM). R package version 0.4.7.

[Yuan et al., 2012] Yuan, Z., Gao, Q., He, Y., Zhang, X., Li, F., Zhao, J., and Xue, F. (2012). Detection for

gene-gene co-association via kernel canonical correlation analysis. BMC Genetics, 13(1):83.

[Zaykin et al., 2002] Zaykin, D., Zhivotovsky, L. A., Westfall, P., and Weir, B. (2002). Truncated product

method for combining p-values. Genetic Epidemiology, 22(2):170–185.

[Zhang et al., 2013] Zhang, X., Yang, X., Yuan, Z., Liu, Y., Li, F., Peng, B., Zhu, D., Zhao, J., and Xue, F.
(2013). A plspm-based test statistic for detecting gene-gene co-association in genome-wide association study
with case-control design. PLoS ONE, 8(4):e62129.

11

