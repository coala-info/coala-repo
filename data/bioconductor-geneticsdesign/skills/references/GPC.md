Power Calculation for Testing If Disease is Associated
with Marker in a Case-Control Study Using the
GeneticsDesign Package

Weiliang Qiu
email: weiliang.qiu@gmail.com
Ross Lazarus
email: ross.lazarus@channing.harvard.edu

October 30, 2017

1

Introduction

In genetics association studies, investigators are interested in testing the association
between disease and DSL (disease susceptibility locus) in a case-control study. However,
DSL is usually unknown. Hence what one can do is to test the association between
disease and DSL indirectly by testing the association between disease and a marker.
The power of the association between disease and DSL depends on the power of the
association between disease and the marker, and on the LD (linkage disequilibrium)
between disease and the marker.

Assume that both DSL and the marker are biallelic and assume additive model.
Given the MAFs (minor allele frequencies) for both DSL and the marker, relative risks,
r2 or D(cid:48) between DSL and marker, the numbers of cases and controls, and the signiﬁcant
level for hypothesis testing, the tools in the GeneticsDesign package can calculate the
power for the association test that disease is associated with DSL in a case-control
study. This information can help investigator to determine appropriate sample sizes in
experiment design stage.

2 Examples

To call the functions in the R package GeneticsDesign, we ﬁrst need to load it into R:

> library(GeneticsDesign)

The following is a sample code to get a table of power for diﬀerent combinations of

high risk allele frequency P r(A) and genotype relative risk RR(Aa|aa).

1

> set1<-seq(from=0.1, to=0.5, by=0.1)
> set2<-c(1.25, 1.5, 1.75, 2.0)
> len1<-length(set1)
> len2<-length(set2)
> mat<-matrix(0, nrow=len1, ncol=len2)
> rownames(mat)<-paste("MAF=", set1, sep="")
> colnames(mat)<-paste("RRAA=", set2, sep="")
> for(i in 1:len1)
+ { a<-set1[i]
+
+
+
+
+
+ }
> print(round(mat,3))

for(j in 1:len2)
{ b<-set2[j]

}

res<-GPC.default(pA=a,pD=0.1,RRAa=(1+b)/2, RRAA=b, Dprime=1,pB=a, quiet=T)
mat[i,j]<-res$power

MAF=0.1
MAF=0.2
MAF=0.3
MAF=0.4
MAF=0.5

RRAA=1.25 RRAA=1.5 RRAA=1.75 RRAA=2
0.690 0.884
0.877 0.977
0.926 0.989
0.936 0.990
0.925 0.986

0.400
0.594
0.682
0.711
0.702

0.145
0.214
0.259
0.280
0.282

A Technical Details

Suppose that A is the minor allele for the disease locus; a is the common allele for the
disease locus; B is the minor allele for the marker locus; and b is the common allele for
the marker locus. We use D to denote the disease status “diseased” and use ¯D to denote
the disease status “not diseased”.

Given the minor allele frequencies P r(A) and P r(B) and Linkage disequilibrium (LD)

measure D(cid:48), we can get haplotype frequencies P r(AB), P r(Ab), P r(aB), and P r(ab):

where

P r(AB) = P r(A)P r(B) + D
P r(aB) = P r(a)P r(B) − D
P r(Ab) = P r(A)P r(b) − D
P r(ab) = P r(a)P r(b) + D,

D = D(cid:48)dmax

2

and

That is,

dmax =

(cid:26) min [P r(A)P r(b), P r(a)P r(B)] ,

max [−P r(A)P r(B), −P r(a)P r(b)] ,

if D > 0,
if D < 0.

D = P r(AB) − P r(A)P r(B).

Note that D > 0 means P r(AB) > P r(A)P r(B), i.e., the probability of occuring the
haplotype AB is higher than the probability that the haplotype AB occurs merely by
chance. D < 0 means P r(AB) < P r(A)P r(B), i.e., the probability of occuring the
haplotype AB is smaller than the probability that the haplotype AB occurs merely by
chance. In other words, given the same sample size, we can observe haplotype AB more
often when D > 0 than when D < 0. Hence the power of association test that marker
is associated with disease is larger when D > 0 than when D < 0. Hence, we assume
that D > 0.

D can also be rewritten as

D = P r(B|A)P r(A) − P r(A)P r(B) = [P r(B|A) − P r(B)] P r(A).

Hence D > 0 is equivalent to P r(B|A) > P r(A) which indicates positive association
between minor allele A in disease locus and minor allele B in marker locus.

The relative risks are

RR(AA|aa) =

RR(Aa|aa) =

P r(D|AA)
P r(D|aa)
P r(D|Aa)
P r(D|aa)

The disease prevalence P r(D) can be rewritten as

P r(D) = P r(D|AA)P r(AA) + P r(D|Aa)P r(Aa) + P r(D|aa)P r(aa).

Dividing both sides by P r(D|aa), we get

P r(D)
P r(D|aa)

=

P r(D|AA)
P r(D|aa)

P r(AA) +

P r(D|Aa)
P r(D|aa)

P r(Aa) +

P r(D|aa)
P r(D|aa)

P r(aa)

= RR(AA|aa) [P r(A)]2 + RR(Aa|aa)2P r(A)P r(a) + [P r(a)]2 .

Hence

P r(D|aa) =

P r(D)
RR(AA|aa) [P r(A)]2 + RR(Aa|aa)2P r(A)P r(a) + [P r(a)]2

P r(D|Aa) = RR(Aa|aa)P r(D|aa)
P r(D|AA) = RR(AA|aa)P r(D|aa)

3

Once we obtain the penetrances of disease locus (P r(D|aa), P r(D|Aa), and P r(D|AA)),

we can get the sampling probabilities:

P r(BB|D) =

P r(D, BB)
P r(D)

=

=

P r(D, BB, AA) + P r(D, BB, Aa) + P r(D, BB, aa)
P r(D)

P r(D|BB, AA)P r(BB, AA) + P r(D|BB, Aa)P r(BB, Aa) + P r(D|BB, aa)P r(BB, aa)
P r(D)

P r(Bb|D) =

P r(D, Bb)
P r(D)

=

=

P r(D, Bb, AA) + P r(D, Bb, Aa) + P r(D, Bb, aa)
P r(D)

P r(D|Bb, AA)P r(Bb, AA) + P r(D|Bb, Aa)P r(Bb, Aa) + P r(D|Bb, aa)P r(Bb, aa)
P r(D)

P r(bb|D) =

P r(D, bb)
P r(D)

=

=

P r(D, bb, AA) + P r(D, bb, Aa) + P r(D, bb, aa)
P r(D)

P r(D|bb, AA)P r(bb, AA) + P r(D|bb, Aa)P r(bb, Aa) + P r(D|bb, aa)P r(bb, aa)
P r(D)

We assume that

P r(D|BB, AA) = P r(D|AA), P r(D|BB, Aa) = P r(D|Aa), P r(D|BB, aa) = P r(D|aa).

We also have

P r(BB, AA) = [P r(AB)]2
P r(BB, Aa) = 2P r(AB)P r(aB)
P r(BB, aa) = [P r(aB)]2

P r(Bb, AA) = 2P r(AB)P r(Ab)
P r(Bb, Aa) = 2 [P r(AB) ∗ P r(ab) + P r(Ab)P r(aB)]
P r(Bb, aa) = 2P r(aB)P r(ab)

P r(bb, AA) = [P r(Ab)]2
P r(bb, Aa) = 2P r(Ab)P r(ab)
P r(bb, aa) = [P r(ab)]2

4

Hence

P r(BB|D) =

P r(D|BB, AA)P r(BB, AA) + P r(D|BB, Aa)P r(BB, Aa) + P r(D|BB, aa)P r(BB, aa)
P r(D)

=

P r(D|AA) [P r(AB)]2 + P r(D|Aa) [2P r(AB)P r(aB)] + P r(D|aa) [P r(aB)]2
P r(D)

P r(Bb|D) =

=

+

P r(D|Bb, AA)P r(Bb, AA) + P r(D|Bb, Aa)P r(Bb, Aa) + P r(D|Bb, aa)P r(Bb, aa)
P r(D)
P r(D|AA) [2P r(AB)P r(Ab)] + P r(D|Aa) {2 [P r(AB)P r(ab) + P r(Ab)P r(aB)]}
P r(D)

P r(D|aa) [2P r(aB)P r(ab)]
P r(D)

P r(bb|D) =

P r(D|bb, AA)P r(bb, AA) + P r(D|bb, Aa)P r(bb, Aa) + P r(D|bb, aa)P r(bb, aa)
P r(D)

=

P r(D|AA) [P r(Ab)]2 + P r(D|Aa) [2P r(Ab)P r(ab)] + P r(D|aa) [P r(ab)]2
P r(D)

To calculate the sampling probabilities P r(BB| ¯D), P r(Bb| ¯D), and P r(bb| ¯D), we can

apply Bayesian rules again:

P r(BB| ¯D) =

P r(Bb| ¯D) =

P r(bb| ¯D) =

and

P r( ¯D|BB)P r(BB)
P r( ¯D)
P r( ¯D|Bb)P r(Bb)
P r( ¯D)
P r( ¯D|bb)P r(bb)
P r( ¯D)

=

=

=

[1 − P r(D|BB)][P r(B)]2
1 − P r(D)
[1 − P r(D|Bb)]2P r(B)P r(b)
1 − P r(D)
[1 − P r(D|bb)][P r(b)]2
1 − P r(D)

P r(D|BB) =

P r(D|Bb) =

P r(D|bb) =

=

P r(BB|D)P r(D)
P r(BB)
P r(Bb|D)P r(D)
P r(Bb)
P r(bb|D)P r(D)
P r(bb)

=

=

P r(BB|D)P r(D)
[P r(B)]2
P r(Bb|D)P r(D)
[2P r(B)P r(b)]
P r(bb|D)P r(D)
[P r(b)]2

.

5

The expected allele frequencies are

P r(B|D) =

2ncaseP r(BB|D) + ncaseP r(Bb|D)
2ncase

= P r(BB|D) + P r(Bb|D)/2

P r(b|D) =

2ncaseP r(bb|D) + ncaseP r(Bb|D)
2ncase

= P r(bb|D) + P r(Bb|D)/2

P r(B| ¯D) = P r(BB| ¯D) + P r(Bb| ¯D)/2
P r(b| ¯D) = P r(bb| ¯D) + P r(Bb| ¯D)/2.

The counts for cases

n2c = ncasesP r(BB|D), n1c = ncasesP r(Bb|D), n0c = ncasesP r(bb|D).

The counts for controls

n2n = ncontrolsP r(BB| ¯D), n1n = ncontrolsP r(Bb| ¯D), n0n = ncontrolsP r(bb| ¯D).

Table 1: Counts for cases and controls

marker
genotype
BB
Bb
bb
total

cases
n2c
n1c
n0c
ncases

controls
n2n
n1n
n0n
ncontrols

Odds ratios are

Deﬁne

OR(BB|bb) =

=

OR(Bb|bb) =

=

n2cn0n
n2nn0c
P r(BB|D)P r(bb| ¯D)
P r(BB| ¯D)P r(bb|D)
n1cn0n
n1nn0c
P r(Bb|D)P r(bb| ¯D)
P r(Bb| ¯D)P r(bb|D)

U =

3
(cid:88)

i=1

(cid:18) S
N

xi

ri −

(cid:19)

si

,

R
N

6

where

We have

R =n0c + n1c + n2c, S = n0n + n1n + n2n, N = R + S
.x1 =2, x2 = 1, x3 = 0,
r1 =n0c, r2 = n1c, r3 = n2c,
s1 =n0n, s2 = n1n, s3 = n2n.

V = (cid:100)V ar(U ) =



N

RS
N 3

3
(cid:88)

i=1

x2
i ni −

(cid:33)2
 .

xini

(cid:32) 3

(cid:88)

i=1

The Linear Trend Test Statistic1

Z 2

T =

(cid:19)2

(cid:18) U
√
V

asymptotically follows a χ2
hypothesis, Z 2
non-centrality parameter

T asymptotically follows a non-central chi-square distribution χ2

1 distribution under the null hypothesis. Under alternative
with

1,λT

λT = RS

i=1 xi(p1i − p0i)(cid:3)2

(cid:2)(cid:80)3
i (Rp0i + Sp1i) − (cid:2)(cid:80)3

i=1 xi(Rp0i + Sp1i

(cid:80)3

i=1 x2

,

(cid:3)2

/N

where

x1 =2, x2 = 1, x3 = 0,
n1 =n2c + n2n, n2 = n1c + n1n, n3 = n0c + n0n,
p01 =P r(BB|D), p02 = P r(Bb|D), p03 = P r(bb|D),
p11 =P r(BB| ¯D), p12 = P r(Bb| ¯D), p13 = P r(bb| ¯D).

Given signiﬁcant level α, the power 1 − β satisﬁes:

P r(Z 2
P r(Z 2

T > c|H0) =α
T > c|Ha) =1 − β.

References

[1] Armitage, P. Tests for linear trends in proportions and frequencies. Biometrics, 11,

375-386, 1955.

[2] Cochran, W. G. Some methods for strengthening the common chi-squared tests.

Biometrics, 10, 417-451, 1954.

1http://linkage.rockefeller.edu/pawe3d/help/Linear-trend-test-ncp.html

7

[3] Gordon D. and Finch S. J. and Nothnagel M. and Ott J. Power and sample size cal-
culations for case-control genetic association tests when errors are present: application
to single nucleotide polymorphisms. Hum. Hered., 54:22-33, 2002.

[4] Gordon D. and Haynes C. and Blumenfeld J. and Finch S. J. PAWE-3D: visualizing
Power for Association With Error in case/control genetic studies of complex traits.
Bioinformatics, 21:3935-3937, 2005.

[5] Purcell S. and Cherny S. S. and Sham P. C. Genetic Power Calculator: design
of linkage and association genetic mapping studies of complex trait Bioinformatics,
19(1):149-150, 2003.

[6] Sham P. Statistics in Human Genetics. Arnold Applications of Statistics, 1998.

8

