covMcd() – Considerations about Generalizing the FastMCD

Martin M¨achler

February 4, 2026

1

Introduction

The context is robust multivariate “location and scatter” estimation, which corresponds to
estimating the ﬁrst two moments in cases they exist. We assume data and a model

xi ∈ Rp,
xi ∼ F(µ, Σ),

i = 1, 2, . . . , n

i.i.d.; µ ∈ Rp, Σ ∈ Rp×p, positive deﬁnite,

(1)

(2)

where a conceptual null model is the p-dimensional normal distribution. One typical assumption
is that F is a mixture with the majority component (“good data”) being Np(µ, Σ) and other
components modeling “the outliers”.

which should be close to the true “good data”

In other words, we want estimates

(µ, Σ) — and do not say more here.

ˆµ, ˆΣ

(cid:0)

(cid:1)

2 MCD and “the Fast” MCD (= fastmcd) Algorithm

The robustbase R package has featured a function covMcd() since early on (Feb. 2006) and
that has been an interface to the Fortran routine provided by the original authors and (partly)
described in Rousseeuw and van Driessen (1999). We describe shortly how the algorithm works,
partly building on the documentation provided in the source (R, S, and Fortran) codes:

The minimum covariance determinant estimator of location and scatter (MCD) implemented
in covMcd() is similar to R function cov.mcd() in MASS. The (“theoretical”) MCD looks for the
h = hα(> 1/2) out of n observations whose classical covariance matrix has the lowest possible
determinant. In more detail, we will use h = hα = h(α, n, p) ≈ α·(n+p+1), where as Rousseeuw
and van Driessen (1999) mainly use (the default) α = 1
. For
2 , the R implementation (derived from their original S code) uses h = h(α, n, p) =
general α ≥ 1
h.alpha.n(alpha,n,p) (function in robustbase), which is

2 , where h = h(1/2, n, p) =

n+p+1
2

k

j

n + p + 1
2

j

k

h = hα = h(α, n, p) := ⌊2n2 − n + 2α(n − n2)⌋, where n2 :=

.

(3)

The fraction α ≥ 1
n+p+1
h1/2 = n2 =
2
the subsample size h in the full sample (size n):

2 can be chosen by the user, where α = 1

2 is the most robust, and indeed,
. Even in general, as long as n ≫ p, α is approximately the proportion of

j

k

h ≈ α · n ⇐⇒ α ≈

h
n

,

(4)

> require(robustbase)
> n <- c(5, 10, 20, 30, 50, 100, 200, 500)
> hmat <- function(alpha, p) cbind(n, h.alpha = h.alpha.n (alpha, n,p),
+
> hmat(alpha = 1/2, p = 3)

h. = floor(alpha * (n + p + 1)), alpha.n = round(alpha * n))

1

4
7

n h.alpha h. alpha.n
2
5
[1,]
5
10
[2,]
10
20
[3,]
15
30
[4,]
25
50
[5,]
50
[6,] 100
100
[7,] 200
250
[8,] 500

4
7
12 12
17 17
27 27
52 52
102 102
252 252

> hmat(alpha = 3/4, p = 4)

n h.alpha h. alpha.n
4
5
[1,]
8
10
[2,]
15
20
[3,]
22
30
[4,]
38
[5,]
50
75
[6,] 100
150
[7,] 200
375
[8,] 500

7
5
8 11
16 18
23 26
38 41
76 78
151 153
376 378

The breakdown point (for h > n

2 ) then is

ϵ∗ =

n − h + 1
n

,

(5)

which is less than but close to 1
approximately,

2 for α = 1

2 , and in general, h/n ≈ α, the breakdown point is

ϵ∗ =

n − h + 1
n

≈

n − h
n

= 1 −

h
n

≈ 1 − α.

(6)

The raw MCD estimate of location, say ˆµ0, is then the average of these h points, whereas
the raw MCD estimate of scatter, ˆΣ0, is their covariance matrix, multiplied by a consistency
factor .MCDcons(p, h/n)) and (by default) a ﬁnite sample correction factor .MCDcnp2(p, n,
alpha), to make it consistent at the normal model and unbiased at small samples.

n
h

In practice, for reasonably sized n, p and hence h, it is not feasible to search the full space
h-subsets of n observations. Rather, the implementation of covMcd uses the Fast
of all
MCD algorithm of Rousseeuw and van Driessen (1999) to approximate the minimum covariance
determinant estimator, see Section 3.

(cid:0)

(cid:1)

Based on these raw MCD estimates,

, a reweighting step is performed, i.e., V <-
cov.wt(x,w), where w are weights determined by “outlyingness” with respect to the scaled raw
, see (7). Again, a consistency
MCD, using the “Mahalanobis”-like, robust distances di
factor and a ﬁnite sample correction factor are applied. The reweighted covariance is typically
considerably more eﬃcient than the raw one, see Pison et al. (2002).

ˆµ0, ˆΣ0

(cid:0)

(cid:1)

(cid:0)

(cid:1)

ˆµ0, ˆΣ0

The two rescaling factors for the reweighted estimates are returned in cnp2. Details for the

computation of the ﬁnite sample correction factors can be found in Pison et al. (2002).

3 Fast MCD Algorithm – General notation

Note:
e.g., kmini, used in the Fortran and sometimes R function code, in R package robustbase.

In the following, apart from the mathematical notation, we also use variable names,

2

Instead of directly searching for h-subsets (among

) the basic idea is to start with
small subsets of size p + 1, their center µ and covariance matrix Σ, and a corresponding h-subset
of the h observations with smallest (squared) (“Mahalanobis”-like) distances

≈

(cid:0)

(cid:1)

(cid:0)

(cid:1)

n
h

n
n/2

di = di(µ, Σ) := (xi − µ)

′

−1(xi − µ),

Σ

i = 1, 2, . . . , n,

(7)

and then use concentration steps (“C steps”) to (locally) improve the chosen set by iteratively
computing µ, Σ, new distances di and a new set of size h with smallest distances di(µ, Σ). Each
C step is proven to decrease the determinant det(Σ) if µ and Σ did change at all. Consequently,
convergence to a local minimum is sure, as the number of h-subsets is ﬁnite.

To make the algorithm fast for non small sample size n the data set is split into “groups”

or “sub-datasets” as soon as

n ≥ 2n0, where n0 := nmini (= 300, by default).

(8)

i.e., the default cutoﬀ for “non small” is at n = 600. The number of such subsets in the original
algorithm is maximally 5, and we now use

kM = kmini (= 5, by default),

as upper limit. As above, we assume from now on that n ≥ 2n0, and let

and now distinguish the two cases,

k :=

≥ 2

n
n0

j

k

A.
k < kM ⇐⇒ n < kM · n0
B. k ≥ kM ⇐⇒ n ≥ kM · n0

(

(9)

(10)

(11)

In case A k (= ngroup) subsets aka “groups” or “sub datasets” are used, k ∈ {2, 3, . . . , kM −1},
of group sizes nj, j = 1, . . . , k (see below). Note that case A may be empty because of
2 ≤ k < kM , namely if kM = 2. Hence, in case A, we have kM ≥ 3.

in case B kM (= ngroup) groups each of size n0 are built and in the ﬁrst stage, only a subset

of kM · n0 ≤ n observations is used.

In both cases, the disjoint groups (“sub datasets”) are chosen at random from the n observations.
For the group sizes for case A, nj, j = 1, . . . , k, we have

n
k

=

(cid:22)

n1 =

j

k

nj = n1,
nj = n1 + 1,

( ≥ n0)

n
n
n0
j = 2, . . . , j∗
(cid:4)
j = j∗ + 1, . . . , k,

(cid:23)

(cid:5)

where j∗ := k − r ∈ {1, . . . , k},

and r := n − kn1 = n − k

n
k

∈ {0, 1, . . . , k − 1},

(12)

(13)

(14)

(15)

(16)

where the range of j∗, 1, . . . , k in (15) is a consequence of the range of the integer division
remainder r ∈ {0, 1, . . . , k − 1} in (16). Consequently, (14) maybe empty, namely iﬀ r = 0
( ⇐⇒ n = k · n1 is a multiple of k): j∗ = k, and all nj ≡ n1.

(cid:4)

(cid:5)

Considering the range of nj in case A, the minimum n1 ≥ n0 in (12) is easy to verify. What
is the maximal value of nj , i.e., an upper bound for nmax := n1 + 1 ≥ maxj nj? Consider
n1,max(k) = maxn,given k n1 = maxn,given k⌊ n
= k is
n0−1
n = (k + 1)n0 − 1 where
k

k ⌋. Given k, the maximal n still fulﬁlling
= k. Hence, n1,max(k) =

n
n0
= n0 +
(cid:4)

(k+1)n0−1
k

1 − 1
n0

= k +

n
n0

(cid:5)

,

(cid:4)

(cid:5)

(cid:4)

(cid:5)

3

(cid:4)

(cid:5)

(cid:4)

(cid:5)

and as k ≥ 2, the maximum is at k = 2, max n1 = maxk n1,max(k) = n0 +
Taken together, as nj = n1 + 1 is possible, we have

n0−1
2

=

3n0−1
2

.

(cid:4)

(cid:5)

(cid:4)

(cid:5)

n0 ≤n1 ≤

n0 ≤nj ≤

3n0 − 1
2
3n0 + 1
2

j

j

k
,

k

j ≥ 2.

(17)

is the length of the auxiliary vector subndex in the Fortran code.

Note that indeed,

References

3n0+1
2

(cid:4)

(cid:5)

Pison, G., S. Van Aelst, and G. Willems (2002). Small sample corrections for lts and mcd.

Metrika 55 (1-2), 111–123.

Rousseeuw, P. J. and K. van Driessen (1999, August). A fast algorithm for the minimum

covariance determinant estimator. Technometrics 41 (3), 212–223.

4

