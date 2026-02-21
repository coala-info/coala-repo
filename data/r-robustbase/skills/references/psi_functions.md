Deﬁnitions of ψ-Functions Available in Robustbase

Manuel Koller and Martin Mächler

February 4, 2026

Contents

1 Monotone ψ-Functions

1.1 Huber . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Redescenders

2.1 Bisquare . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Hampel
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 GGW . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 LQQ . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.5 Optimal
2.6 Welsh . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Preamble

2
3

3
4
5
6
7
8
9

Unless otherwise stated, the following deﬁnitions of functions are given by Maronna et al. (2006,
p. 31), however our deﬁnitions diﬀer sometimes slightly from theirs, as we prefer a diﬀerent way
of standardizing the functions. To avoid confusion, we ﬁrst deﬁne ψ- and ρ-functions.

Deﬁnition 1 A ψ-function is a piecewise continuous function ψ : R → R such that

1. ψ is odd, i.e., ψ(−x) = −ψ(x) ∀x,

2. ψ(x) ≥ 0 for x ≥ 0, and ψ(x) > 0 for 0 < x < xr := sup{˜x : ψ(˜x) > 0}

(xr > 0, possibly

xr = ∞).

3* Its slope is 1 at 0, i.e., ψ′(0) = 1.

Note that ‘3*’ is not strictly required mathematically, but we use it for standardization in those
cases where ψ is continuous at 0. Then, it also follows (from 1.) that ψ(0) = 0, and we require
ψ(0) = 0 also for the case where ψ is discontinuous in 0, as it is, e.g., for the M-estimator
deﬁning the median.

Deﬁnition 2 A ρ-function can be represented by the following integral of a ψ-function,

x

ρ(x) =

ψ(u)du ,

0

Z

(1)

which entails that ρ(0) = 0 and ρ is an even function.

A ψ-function is called redescending if ψ(x) = 0 for all x ≥ xr for xr < ∞, and xr is often
called rejection point. Corresponding to a redescending ψ-function, we deﬁne the function ˜ρ, a
version of ρ standardized such as to attain maximum value one. Formally,

˜ρ(x) = ρ(x)/ρ(∞).

(2)

1

Note that ρ(∞) = ρ(xr) ≡ ρ(x) ∀ |x| >= xr. ˜ρ is a ρ-function as deﬁned in Maronna et al.
(2006) and has been called χ function in other contexts. For example, in package robustbase,
Mchi(x, *) computes ˜ρ(x), whereas Mpsi(x, *, deriv=-1) (“(-1)-st derivative” is the primitive
or antiderivative) computes ρ(x), both according to the above deﬁnitions.

Note: An alternative slightly more general deﬁnition of redescending would only require
ρ(∞) := limx→∞ ρ(x) to be ﬁnite. E.g., "Welsh" does not have a ﬁnite rejection point, but does
have bounded ρ, and hence well deﬁned ρ(∞), and we can use it in lmrob().1

Weakly redescending ψ functions. Note that the above deﬁnition does require a ﬁnite
rejection point xr. Consequently, e.g., the score function s(x) = −f ′(x)/f (x) for the Cauchy
(= t1) distribution, which is s(x) = 2x/(1 + x2) and hence non-monotone and “re descends” to
′(0) = 1, but it has xr = ∞ and hence ψC()
0 for x → ±∞, and ψC(x) := s(x)/2 also fulﬁlls ψC
in the MLE for tν, we call
is not a redescending ψ-function in our sense. As they appear e.g.
ψ-functions fulfulling limx→∞ ψ(x) = 0 weakly redescending. Note that they’d naturally fall into
two sub categories, namely the one with a ﬁnite ρ-limit, i.e. ρ(∞) := limx→∞ ρ(x), and those,
as e.g., the tν score functions above, for which ρ(x) is unbounded even though ρ′ = ψ tends to
zero.

1 Monotone ψ-Functions

Montone ψ-functions lead to convex ρ-functions such that the corresponding M-estimators are
deﬁned uniquely.

Historically, the “Huber function” has been the ﬁrst ψ-function, proposed by Peter Huber in

Huber (1964).

1E-mail Oct. 18, 2014 to Manuel and Werner, proposing to change the deﬁnition of “redescending”.

2

1.1 Huber

The family of Huber functions is deﬁned as,

ρk(x) =

ψk(x) =

(cid:26)

(cid:26)

1
2 x2
k(|x| − k
2 )
x
k sign(x)

if |x| ≤ k
if |x| > k

if |x| ≤ k
if |x| > k

,

.

The constant k for 95% eﬃciency of the regression estimator is 1.345.

> plot(huberPsi, x., ylim=c(-1.4, 5), leg.loc="topright", main=FALSE)

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x
w′(x)

5

4

3

2

)
x
(
f

1

0

1
−

−5

0

5

10

x

Figure 1: Huber family of functions using tuning parameter k = 1.345.

2 Redescenders

For the MM-estimators and their generalizations available via lmrob() (and for some meth-
ods of nlrob()), the ψ-functions are all redescending, i.e., with ﬁnite “rejection point” xr =
sup{t; ψ(t) > 0} < ∞. From lmrob, the psi functions are available via lmrob.control, or more
directly, .Mpsi.tuning.defaults,

> names(.Mpsi.tuning.defaults)

[1] "huber"
[6] "optimal" "hampel"

"bisquare" "welsh"

"ggw"

"lqq"

and their ψ, ρ, ψ′, and weight function w(x) := ψ(x)/x, are all computed eﬃciently via C code,
and are deﬁned and visualized in the following subsections.

3

2.1 Bisquare

Tukey’s bisquare (aka “biweight”) family of functions is deﬁned as,

˜ρk(x) =

1 −

1 − (x/k)2

1

3

(cid:1)

if |x| ≤ k
if |x| > k

,

with derivative ˜ρ′

(cid:0)
k(x) = 6ψk(x)/k2 where,

(cid:26)

ψk(x) = x

1 −

2

2

· I{|x|≤k} .

x
k

(cid:16)
The constant k for 95% eﬃciency of the regression estimator is 4.685 and the constant for a
breakdown point of 0.5 of the S-estimator is 1.548. Note that the exact default tuning con-
stants for M- and MM- estimation in robustbase are available via .Mpsi.tuning.default()
and .Mchi.tuning.default(), respectively, e.g., here,

(cid:17)

(cid:18)

(cid:19)

> print(c(k.M = .Mpsi.tuning.default("bisquare"),
+

k.S = .Mchi.tuning.default("bisquare")), digits = 10)

k.M

k.S
4.685061 1.547640

and that the p.psiFun(.) utility is available via

> source(system.file("xtraR/plot-psiFun.R", package = "robustbase", mustWork=TRUE))

> p.psiFun(x., "biweight", par = 4.685)

3

2

)
x
(
f

1

0

1
−

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x

−5

0

5

10

x

Figure 2: Bisquare family functions using tuning parameter k = 4.685.

4

2.2 Hampel

The Hampel family of functions (Hampel et al., 1986) is deﬁned as,

1
2 x2/C
1
2 a2 + a(|x| − a)

/C

2b − a + (|x| − b)

(cid:1)

|x| ≤ a
a < |x| ≤ b

1 + r−|x|
r−b

/C b < |x| ≤ r

,

(cid:16)

(cid:16)

(cid:17)(cid:17)

r < |x|

a
(cid:0)
2
1

˜ρa,b,r(x) = 


ψa,b,r(x) = 


where C := ρ(∞) = ρ(r) = a

x
a sign(x)
a sign(x) r−|x|
r−b
0

|x| ≤ a
a < |x| ≤ b
b < |x| ≤ r
r < |x|

,

2 (2b − a + (r − b)) = a

2 (b − a + r).

As per our standardization, ψ has slope 1 in the center. The slope of the redescending part

(x ∈ [b, r]) is −a/(r − b). If it is set to − 1

2 , as recommended sometimes, one has

r = 2a + b .

Here however, we restrict ourselves to a = 1.5k, b = 3.5k, and r = 8k, hence a redescending

slope of − 1

3 , and vary k to get the desired eﬃciency or breakdown point.

The constant k for 95% eﬃciency of the regression estimator is 0.902 (0.9016085, to be exact)

and the one for a breakdown point of 0.5 of the S-estimator is 0.212 (i.e., 0.2119163).

6

4

)
x
(
f

2

0

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x

−5

0

5

10

x

Figure 3: Hampel family of functions using tuning parameters 0.902 · (1.5, 3.5, 8).

5

2.3 GGW

The Generalized Gauss-Weight function, or ggw for short, is a generalization of the Welsh ψ-
function (subsection 2.6). In Koller and Stahel (2011) it is deﬁned as,

ψa,b,c(x) =

x

exp

(

− 1
2

(|x|−c)b
a

|x| ≤ c

x |x| > c

.

Our constants, ﬁxing b = 1.5, and minimial slope at − 1
2 , for 95% eﬃciency of the regression
estimator are a = 1.387, b = 1.5 and c = 1.063, and those for a breakdown point of 0.5 of the
S-estimator are a = 0.204, b = 1.5 and c = 0.296:

(cid:16)

(cid:17)

> cT <- rbind(cc1 = .psi.ggw.findc(ms = -0.5, b = 1.5, eff = 0.95
+

cc2 = .psi.ggw.findc(ms = -0.5, b = 1.5,

bp = 0.50)); cT

),

[,1]

[,2] [,3]

[,5]
0 1.3863620 1.5 1.0628199 4.7773893
0 0.2036739 1.5 0.2959131 0.3703396

[,4]

cc1
cc2

Note that above, cc*[1]= 0, cc*[5]= ρ(∞), and cc*[2:4]= (a, b, c). To get this from (a, b, c),
you could use

> ipsi.ggw <- .psi2ipsi("GGW") # = 5
> ccc <- c(0, cT[1, 2:4], 1)
> integrate(.Mpsi, 0, Inf, ccc=ccc, ipsi=ipsi.ggw)$value # = rho(Inf)

[1] 4.777389

> p.psiFun(x., "GGW", par = c(-.5, 1, .95, NA))

5

4

3

2

)
x
(
f

1

0

1
−

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x

−5

0

5

10

x

Figure 4: GGW family of functions using tuning parameters a = 1.387, b = 1.5 and c = 1.063.

6

2.4 LQQ

The “linear quadratic quadratic” ψ-function, or lqq for short, was proposed by Koller and Stahel
(2011). It is deﬁned as,

x

sign(x)

sign(x)
0

ψb,c,s(x) = 



where

|x| − s
c + b − bs
(cid:16)

2b (|x| − c)2
2 + s−1

a

1
2 ˜x2 − a˜x
(cid:17)

(cid:0)

(cid:0)

(cid:1)(cid:1)

|x| ≤ c

c < |x| ≤ b + c

b + c < |x| ≤ a + b + c
otherwise,

˜x := |x| − b − c and a := (2c + 2b − bs)/(s − 1).

(3)

The parameter c determines the width of the central identity part. The sharpness of the bend
is adjusted by b while the maximal rate of descent is controlled by s (s = 1 − minx ψ′(x) > 1).
From (3), the length a of the ﬁnal descent to 0 is a function of b, c and s.

> cT <- rbind(cc1 = .psi.lqq.findc(ms= -0.5, b.c = 1.5, eff=0.95, bp=NA ),
+
cc2 = .psi.lqq.findc(ms= -0.5, b.c = 1.5, eff=NA , bp=0.50))
> colnames(cT) <- c("b", "c", "s"); cT

b

s
cc1 1.4734061 0.9822707 1.5
cc2 0.4015457 0.2676971 1.5

c

If the minimal slope is set to − 1

2 , i.e., s = 1.5, and b/c = 3/2 = 1.5, the constants for 95%
eﬃciency of the regression estimator are b = 1.473, c = 0.982 and s = 1.5, and those for a
breakdown point of 0.5 of the S-estimator are b = 0.402, c = 0.268 and s = 1.5.

> p.psiFun(x., "LQQ", par = c(-.5,1.5,.95,NA))

5

4

3

2

1

0

1
−

)
x
(
f

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x

−5

0

5

10

x

Figure 5: LQQ family of functions using tuning parameters b = 1.473, c = 0.982 and s = 1.5.

7

2.5 Optimal

The optimal ψ function as given by Maronna et al. (2006, Section 5.9.1),

ψc(x) = sign(x)

−

(cid:18)

φ′(|x|) + c
φ(|x|)

,

(cid:19)+

where φ is the standard normal density, c is a constant and t+ := max(t, 0) denotes the positive
part of t.

Note that the robustbase implementation uses rational approximations originating from the
robust package’s implementation. That approximation also avoids an anomaly for small x and
has a very diﬀerent meaning of c.

The constant for 95% eﬃciency of the regression estimator is 1.060 and the constant for a

breakdown point of 0.5 of the S-estimator is 0.405.

2

)
x
(
f

0

2
−

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x

−5

0

5

10

x

Figure 6: ‘Optimal’ family of functions using tuning parameter c = 1.06.

8

2.6 Welsh

The Welsh ψ function is deﬁned as,

− (x/k)2 /2

˜ρk(x) = 1 − exp
ψk(x) = k2 ˜ρ′
ψ′

k(x) =

1 −

k(x) = x exp

(cid:0)

x/k

2

exp
(cid:0)

(cid:1)

− (x/k)2 /2
− (x/k)2 /2
(cid:1)

The constant k for 95% eﬃciency of the regression estimator is 2.11 and the constant for a
(cid:1)
breakdown point of 0.5 of the S-estimator is 0.577.

(cid:0)

(cid:0)

(cid:1)

(cid:0)

(cid:1)

Note that GGW (subsection 2.3) is a 3-parameter generalization of Welsh, matching for b = 2,

c = 0, and a = k2 (see R code there):

> ccc <- c(0, a = 2.11^2, b = 2, c = 0, 1)
> (ccc[5] <- integrate(.Mpsi, 0, Inf, ccc=ccc, ipsi = 5)$value) # = rho(Inf)

[1] 4.4521

> stopifnot(all.equal(Mpsi(x., ccc, "GGW"),
+

Mpsi(x., 2.11, "Welsh")))## psi[Welsh](x; k)

## psi[ GGW ](x; a=k^2, b=2, c=0) ==

)
x
(
f

4

3

2

1

0

1
−

ρ(x)
ψ(x)
ψ′(x)
w(x) = ψ(x) x

−5

0

5

10

x

Figure 7: Welsh family of functions using tuning parameter k = 2.11.

References

Hampel, F., E. Ronchetti, P. Rousseeuw, and W. Stahel (1986). Robust Statistics: The Approach

Based on Inﬂuence Functions. N.Y.: Wiley.

Huber, P. J. (1964). Robust estimation of a location parameter. Ann. Math. Statist. 35, 73–101.

Koller, M. and W. A. Stahel (2011). Sharpening wald-type inference in robust regression for

small samples. Computational Statistics & Data Analysis 55 (8), 2504–2515.

Maronna, R. A., R. D. Martin, and V. J. Yohai (2006). Robust Statistics, Theory and Methods.

Wiley Series in Probility and Statistics. John Wiley & Sons, Ltd.

9

