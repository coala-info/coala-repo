Dip Test Distributions, P-values, and other
Explorations

Martin Mächler
ETH Zurich

Abstract

...
...

Keywords: MPFR, Abitrary Precision, Multiple Precision Floating-Point, R.

1. Introduction

FIXME: Need notation
Dn :=dip( runif(n) );
but more generally,

Dn(F ) := D(X1, X2, . . . , Xn),

where Xi i.i.d. , Xi

F.

∼

(1)

Hartigan and Hartigan (1985) in their “seminal” paper on the dip statistic Dn already proved
that √n Dn converges in distribution, i.e.,

lim
n→∞

√n Dn

D
= D∞.

(2)

A considerable part of this paper is devoted to explore the distribution of D∞.

2. History of the diptest R package

Hartigan (1985) published an implementation in Fortran of a concrete algorithm, where the
code was also made available on Statlib1
On July 28, 1994, Dario Ringach, then at NY University, asked on Snews (the mailing list
for S and S-plus users) about distributions and was helped by me and then about dyn.load
problems, again helped by me. Subsequently he provided me with S-plus code which interfaced
to (a f2ced version of) Hartigan’s Fortran code, for computing the dip statistic. and ended
the (then private) e-mail with

1

Statlib is now a website, of course, http://lib.stat.cmu.edu/, but then was the preferred way for dis-
tributing algorithms for statistical computing, available years before the existence of the WWW, and entailing
e-mail and (anonymous) FTP

2

Dip Test Distributions, P-values, and other Explorations

I am not going to have time to set this up for submission to StatLib. If you

want to do it, please go ahead.

Regards, Dario

- several important bug ﬁxes; last one Oct./Nov. 2003

However, the Fortran code ﬁle http://lib.stat.cmu.edu/apstat/217, was last changed
Thu 04 Aug 2005 03:43:28 PM CEST.

We have some results of the dip.dist of before the bug ﬁx; notably the “dip of the dip”
probabilities have changed considerably!!

- see rcs log of ../../src/dip.c

3. 21st Century Improvement of Hartigan2’s Table

((

Use listing package (or so to more or less “cut & paste” the nice code in ../../stuff/new-simul.Rout-1e6

))

4. The Dip in the Dip’s Distribution

We have found empirically that the dip distribution itself starts with a “dip”. Speciﬁcally,
the minimal possible value of Dn is 1

2n and the probability of reaching that value,

P

Dn =
(cid:20)

1
2n (cid:21)

,

(3)

is large for small n.

E.g., consider an approximation of the dip distribution for n = 5,

R> require("diptest") # after installing it ..
R> D5 <- replicate(10000, dip(runif(5)))
R> hist(D5, breaks=128, main = "Histogram of

replicate(10'000, dip(runif(5))))")

Martin Mächler

3

Histogram of  replicate(10'000, dip(runif(5))))

0
0
5
3

0
0
5
2

0
0
5
1

0
0
5

0

y
c
n
e
u
q
e
r
F

0.10

0.12

0.14

0.16

0.18

0.20

D5

which looks as if there was a bug in the software — but that look is misleading! Note how
the phenomenon is still visible for n = 8,

R> D8 <- replicate(10000, dip(runif(8)))
R> hist(D8, breaks=128, main = "Histogram of

replicate(10'000, dip(runif(8))))")

Histogram of  replicate(10'000, dip(runif(8))))

0
5
2

0
0
2

0
5
1

0
0
1

0
5

0

y
c
n
e
u
q
e
r
F

0.10

0.15

0.20

D8

Note that there is another phenomenon, in addition to the point mass at 1/(2n), particularly
visible, if we use many replicates,

R> set.seed(11)
R> n <- 11

4

Dip Test Distributions, P-values, and other Explorations

R> B.s11 <- 500000
R> D11 <- replicate(B.s11, dip(runif(n)))

y
c
n
e
u
q
e
r
F

0
0
0
0
1

0
0
0
6

0
0
0
2

0

1 22

0.05

2 22

0.10

3 22

0.15

0.20

Dip  D11(U([0, 1]))

B = 500'000 replicates

FIXME:
use ‘../../stuff/sim-minProb.R’
and ‘../../stuff/minProb-anal.R’
Further, it can be seen that the maximal dip statistic is 1
4 = 0.25 and this upper bound can
be reached simply (for even n) using the the data (0, 0, . . . , 0, 1, 1, . . . , 1), a bi-point mass
with equal mass at both points.

5. P-values for the Dip Test

Note that it is not obvious how to compute p-values for “the dip test”, as that means deter-
mining the distribution of the test statistic, i.e., Dn under the null hypothesis, but a natural
is too large. Hartigans’(1985) argued for us-
dx F isunimodal
null, Ho : F
ing the uniform U [0, 1] i.e., F ′(x) = f (x) = 1
1] (Iverson bracket) instead,
even though they showed that it is not quite the “least favorable” one. Following Hartigans’,
we will deﬁne the p-value of an observed dn as

}
[0,1](x) = [0

f := d

F cadlag

∈ {

≤

≤

x

|

Pdn := P [Dn

≥

dn] := P [dip(U1, . . . , Un)

dn] , where Ui

≥

∼

U [0, 1],

i.i.d.

(4)

5.1. Interpolating the Dip Table

Because of the asymptotic distribution, limn→∞ √n Dn
the “√nDn”–scale, even for ﬁnite n values:
R> data(qDiptab)
R> dnqd <- dimnames(qDiptab)
R> (nn. <- as.integer(dnqd[["n"]]))

D
= D∞, it is makes sense to consider

Martin Mächler

5

[1]
[12]

4
100

5
200

6
500

7

30
1000 2000 5000 10000 20000 40000 72000

15

20

10

8

9

50

R> matplot(nn., qDiptab*sqrt(nn.), type ="o", pch=1, cex = 0.4,

log="x", xlab="n
ylab = expression(sqrt(n) %*% q[D[n]]))

[log scaled]",

R> ## Note that 1/2n is the first possible value (with finite mass),,
R> ## clearly visible for (very) small n:
R> lines(nn., sqrt(nn.)/(2*nn.), col=adjustcolor("yellow2",0.5), lwd=3)
R> P.p <- as.numeric(print(noquote(dnqd[["Pr"]])))

[1] 0
[9] 0.5
[17] 0.995
[25] 0.99999 1

0.01
0.6
0.998

0.02
0.7
0.999

0.05
0.8
0.9995

0.1
0.9
0.9998

0.2
0.95
0.9999

0.3
0.98
0.99995 0.99998

0.4
0.99

R> ## Now look at one well known data set:
R> D <- dip(x <- faithful$waiting)
R> n <- length(x)
R> points(n, sqrt(n)*D, pch=13, cex=2, col= adjustcolor("blue2",.5), lwd=2)
R> ## a simulated (approximate) $p$-value for D is
R> mean(D <= replicate(10000, dip(runif(n)))) ## ~ 0.002

[1] 0.0021

n
D
q
×

n

0

.

1

8
0

.

6
0

.

4

.

0

2
0

.

1e+01

1e+02

1e+03

1e+04

1e+05

n   [log scaled]

but we can use our table to compute a deterministic (but still approximate, as the table is
from simulation too) p-value:
R> ## We are in this interval:
R> n0 <- nn.[i.n <- findInterval(n, nn.)]
R> n1 <- nn.[i.n +1] ; c(n0, n1)

[1] 200 500

R> f.n <- (n - n0)/(n1 - n0)# in [0, 1]
R> ## Now "find" y-interval:

6

Dip Test Distributions, P-values, and other Explorations

R> y.0 <- sqrt(n0)* qDiptab[i.n
,]
R> y.1 <- sqrt(n1)* qDiptab[i.n+1,]
R> (Pval <- 1 - approx(y.0 + f.n*(y.1 - y.0),
P.p,
xout = sqrt(n) * D)[["y"]])

[1] 0.001809527

R> ## 0.018095

Finally, in May 2011, after several years of people asking for it, I have implemented a dip.test
function which makes use of a — somewhat more sophisticated — interpolation scheme like the
one above, to compute a p-value. As qDiptab has been based on 106 samples, the interpolation
yields accurate p-values, unless in very extreme cases. Here is the small (n = 63) example
from Hartigan2,
R> data(statfaculty)
R> dip.test(statfaculty)

Hartigans' dip test for unimodality / multimodality

data: statfaculty
D = 0.059524, p-value = 0.08672
alternative hypothesis: non-unimodal, i.e., at least bimodal

where, from a p-value of 8.7%, we’d conclude that there is not enough evidence against
unimodality.

5.2. Asymptotic Dip Distribution

We have conducted extensive simulations in order to explore the limit distribution of D∞,
i.e., the limit of √n Dn, (2).
Our current R code is in ‘ ../../stuff/asymp-distrib.R ’ but the simulation results (7
Megabytes for each n) cannot be assumed to be part of the package, nor maybe even to be
simply accessible via the internet.

6. Less Conservative Dip Testing

R> toLatex(sessionInfo())

7. Session Info

• R version 4.5.1 Patched (2025-08-11 r88580), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=de_CH.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB.UTF-8,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=C, LC_PAPER=de_CH.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=de_CH.UTF-8,
LC_IDENTIFICATION=C

• Time zone: Europe/Zurich

Martin Mächler

7

• TZcode source: system (glibc)

• Running under: Fedora Linux 40 (Forty)

• Matrix products: default

• BLAS: /sfs/u/maechler/R/D/r-patched/F40-64-inst/lib/libRblas.so

• LAPACK: /usr/lib64/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: diptest 0.77-2

• Loaded via a namespace (and not attached): compiler 4.5.1, tools 4.5.1

References

Hartigan JA, Hartigan PM (1985). “The Dip Test of Unimodality.” Annals of Statistics, 13,

70–84.

Hartigan PM (1985). “Computation of the Dip Statistic to Test for Unimodality.” Applied

Statistics, 34, 320–325.

Aﬃliation:

Martin Mächler
Seminar für Statistik, HG G 14.2
ETH Zurich
8092 Zurich, Switzerland
E-mail: maechler@stat.math.ethz.ch
URL: https://people.math.ethz.ch/~maechler/

