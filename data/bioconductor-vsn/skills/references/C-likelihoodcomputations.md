Likelihood calculations for vsn

Wolfgang Huber

January 15, 2026

Contents

1

2

3

4

5

Introduction .

.

.

.

.

Setup and Notation .

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

Likelihood for Incremental Normalization .

Profile Likelihood .

Summary .

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

1

1

2

3

5

1

Introduction

This vignette contains the computations that underlie the numerical code of vsn. If you are
a new user and looking for an introduction on how to use vsn, please refer to the vignette
Robust calibration and variance stabilization with vsn, which is provided separately.

2

Setup and Notation

Consider the model

arsinh (f (bi) · yki + ai) = µk + εki

1

where µk, for k = 1, . . . , n, and ai, bi, for i = 1, . . . , d are real-valued parameters, f is a
function R → R (see below), and εki are i.i.d. Normal with mean 0 and variance σ2. yki
are the data. In applications to µarray data, k indexes the features and i the arrays and/or
colour channels.

Examples for f are f (b) = b and f (b) = eb. The former is the most obvious choice; in that
case we will usually need to require bi > 0. The choice f (b) = eb assures that the factor in
front of yki is positive for all b ∈ R, and as it turns out, simplifies some of the computations.

In the following calculations, I will also use the notation

Y ≡ Y (y, a, b) = f (b) · y + a

h ≡ h(y, a, b) = arsinh (f (b) · y + a) .

2

3

Likelihood calculations for vsn

The probability of the data (yki)k=1...n, i=1...d lying in a certain volume element of y-space
(hyperrectangle with sides [yα

ki, yβ
ki]) is
yβ
ki(cid:90)

d
(cid:89)

n
(cid:89)

P =

k=1

i=1

yα
ki

dyki pNormal(h(yki), µk, σ2)

dh
dy

(yki),

where µk is the expectation value for feature k and σ2 the variance.

With

the likelihood is

pNormal(x, µ, σ2) =

√

1
2πσ2

(cid:18)

exp

−

(cid:19)

(x − µ)2
2σ2

L =

(cid:18) 1
√

2πσ2

(cid:19)nd n
(cid:89)

d
(cid:89)

k=1

i=1

(cid:18)

exp

−

(h(yki) − µk)2
2σ2

(cid:19)

·

dh
dy

(yki) .

For the following, I will need the derivatives

∂Y
∂a
∂Y
∂b
dh
dy

∂h
∂a
∂h
∂b

= 1

= y · f ′(b)

=

f (b)
(cid:112)1 + (f (b)y + a)2

=

√

f (b)
1 + Y 2

,

=

√

=

√

1
1 + Y 2
y
1 + Y 2

,

· f ′(b).

4

5

6

7

8

9

10

11

Note that for f (b) = b, we have f ′(b) = 1, and for f (b) = eb, f ′(b) = f (b) = eb.

3

Likelihood for Incremental Normalization

Here, incremental normalization means that the model parameters µ1, . . . , µn and σ2 are
already known from a fit to a previous set of µarrays, i. e. a set of reference arrays. See Sec-
tion 4 for the profile likelihood approach that is used if µ1, . . . , µn and σ2 are not known and
need to be estimated from the same data. Versions ≥ 2.0 of the vsn package implement both
of these approaches; in versions 1.X only the profile likelihood approach was implemented,
and it was described in the initial publication [1].

First, let us note that the likelihood 6 is simply a product of independent terms for different i.
We can optimize the parameters (ai, bi) separately for each i = 1, . . . , d. From the likelihood
6 we get the i-th negative log-likelihood

− log(L) =

d
(cid:88)

i=1

−LLi

−LLi =

=

n
2

n
2

log (cid:0)2πσ2(cid:1) +

(cid:32)

n
(cid:88)

k=1

(h(yki) − µk)2
2σ2

log (cid:0)2πσ2(cid:1) − n log f (bi) +

n
(cid:88)

k=1

ki

+ log

(cid:112)1 + Y 2
f (bi)
(cid:18) (h(yki) − µk)2
2σ2

+

(cid:33)

log (cid:0)1 + Y 2

ki

(cid:1)

(cid:19)

1
2

12

13

14

2

Likelihood calculations for vsn

This is what we want to optimize as a function of ai and bi. The optimizer benefits from
the derivatives. The derivative with respect to ai is

(cid:32)

n
(cid:88)

(−LLi) =

∂
∂ai

h(yki) − µk
σ2

+

Yki
(cid:112)1 + Y 2

ki

(cid:33)

·

1
(cid:112)1 + Y 2

ki

k=1
n
(cid:88)

k=1

=

(cid:16) rki
σ2 + AkiYki

(cid:17)

Aki

and with respect to bi

∂
∂bi

(−LLi) = −n

= −n

(cid:32)

n
(cid:88)

+

k=1

+ f ′(bi)

f ′(bi)
f (bi)

f ′(bi)
f (bi)

h(yki) − µk
σ2

+

Yki
(cid:112)1 + Y 2

ki

(cid:33)

·

yki
(cid:112)1 + Y 2

ki

· f ′(bi)

n
(cid:88)

k=1

(cid:16) rki
σ2 + AkiYki

(cid:17)

Akiyki

15

16

Here, I have introduced the following shorthand notation for the “intermediate results” terms

rki = h(yki) − µk

Aki =

1
(cid:112)1 + Y 2

ki

.

17

18

Variables for these intermediate values are also used in the C code to organise the computa-
tions of the gradient.

4

Profile Likelihood

If µ1, . . . , µn and σ2 are not already known, we can plug in their maximum likelihood esti-
mates, obtained from optimizing LL for µ1, . . . , µn and σ2:

ˆµk =

1
d

d
(cid:88)

j=1

h(ykj)

ˆσ2 =

1
nd

n
(cid:88)

d
(cid:88)

(h(ykj) − ˆµk)2

k=1

j=1

19

20

into the negative log-likelihood. The result is called the negative profile log-likelihood

−P LL =

nd
2

log (cid:0)2πˆσ2(cid:1) +

nd
2

− n

d
(cid:88)

j=1

log f (bj) +

1
2

n
(cid:88)

d
(cid:88)

(cid:113)

log

k=1

j=1

1 + Y 2
kj.

21

Note that this no longer decomposes into a sum of terms for each j that are independent of
each other – the terms for different j are coupled through Equations 19 and 20 . We need
the following derivatives.

∂ ˆσ2
∂ai

∂ ˆσ2
∂bi

=

=

=

2
nd

2
nd

2
nd

rki

∂h(yki)
∂ai

rkiAki

n
(cid:88)

k=1
n
(cid:88)

k=1

· f ′(bi)

n
(cid:88)

k=1

rkiAkiyki

22

23

3

Likelihood calculations for vsn

So, finally

∂
∂ai

∂
∂bi

(−P LL) =

nd
2ˆσ2 ·

∂ ˆσ2
∂ai

+

n
(cid:88)

k=1

A2

kiYki

=

n
(cid:88)

k=1

(cid:16) rki
ˆσ2 + AkiYki

(cid:17)

Aki

(−P LL) = −n

f ′(bi)
f (bi)

+ f ′(bi)

n
(cid:88)

k=1

(cid:16) rki
ˆσ2 + AkiYki

(cid:17)

Akiyki

24

25

4

Likelihood calculations for vsn

5

Summary

Likelihoods, from Equations 12 and 21 :

−LLi =

n
2
(cid:124)

+

log (cid:0)2πσ2(cid:1)
(cid:123)(cid:122)
(cid:125)
scale

n
(cid:88)

k=1
(cid:124)

(h(yki) − µk)2
2σ2
(cid:123)(cid:122)
residuals

(cid:125)

(cid:124)

(cid:32)

−P LL =

nd
2
(cid:124)

+

log (cid:0)2πˆσ2(cid:1)
(cid:125)

(cid:123)(cid:122)
scale

nd
2
(cid:124)(cid:123)(cid:122)(cid:125)
residuals

+

d
(cid:88)

i=1
(cid:124)

−n log f (bi) +

log(1 + Y 2
ki)

26

n
(cid:88)

1
2
(cid:123)(cid:122)
jacobian

k=1

n
(cid:88)

k=1

1
2
(cid:123)(cid:122)
jacobian

(cid:125)

(cid:33)

(cid:125)

27

−n log f (bi) +

log(1 + Y 2
ki)

The computations in the C code are organised into steps for computing the terms “scale”,
“residuals” and “jacobian”.

Partial derivatives with respect to ai, from Equations 15 and 24 :

∂
∂ai

(−LLi) =

∂
∂ai

(−P LL) =

n
(cid:88)

k=1
n
(cid:88)

k=1

(cid:16) rki
σ2 + AkiYki

(cid:17)

Aki

(cid:16) rki
ˆσ2 + AkiYki

(cid:17)

Aki

Partial derivatives with respect to bi, from Equations 16 and 25 :

∂
∂bi

(−LLi) = −n

∂
∂bi

(−P LL) = −n

f ′(bi)
f (bi)

f ′(bi)
f (bi)

+ f ′(bi)

+ f ′(bi)

n
(cid:88)

k=1
n
(cid:88)

k=1

(cid:16) rki
σ2 + AkiYki

(cid:17)

Akiyki

(cid:16) rki
ˆσ2 + AkiYki

(cid:17)

Akiyki.

28

29

30

31

Note that the terms have many similarities – this is used in the implementation in the C
code.

References

[1] W. Huber, A. von Heydebreck, H. Sültmann, A. Poustka, and M. Vingron. Variance
stablization applied to microarray data calibration and to quantification of differential
expression. Bioinformatics, 18:S96–S104, 2002.

[2] W. Huber, A. von Heydebreck, H. Sültmann, A. Poustka, and M. Vingron. Parameter
estimation for the calibration and variance stabilization of microarray data. Statistical
Applications in Genetics and Molecular Biology, Vol. 2: No. 1, Article 3, 2003.
http://www.bepress.com/sagmb/vol2/iss1/art3

5

