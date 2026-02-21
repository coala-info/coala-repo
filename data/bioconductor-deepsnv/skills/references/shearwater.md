Subclonal variant calling with multiple samples and prior
knowledge using shearwater

Moritz Gerstung

October 29, 2025

Contents

1 Introduction

2 The statistical model

2.1 Definition . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Testing for variants . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.1 The OR model
2.2.2 The AND model . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Estimating ρ . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Using a prior

3 Using shearwater

3.1 Minimal example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 More realistic example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

1
1
2
2
3
4
5

6
6
8

1 Introduction

The shearwater algorithm was designed for calling subclonal variants in large (N = 10 . . . 1, 000) cohorts
of deeply (∼100x) sequenced unmatched samples. The large cohort allows for estimating a base-specific
error profile on each position, which is modelled by a beta-binomial. A prior can be useded to selec-
tively increase the power of calling variants on known mutational hotspots. The algorithm is similar to
deepSNV, but uses a slightly different parametrization and a Bayes factors instead of a likelihood ratio
test.
If you are using shearwater, please cite

• Gerstung M, Papaemmanuil E, Campbell PJ (2014). “Subclonal variant calling with multiple sam-

ples and prior knowledge.” Bioinformatics, 30, 1198-1204.

2 The statistical model

2.1 Definition

Suppose you have an experimental setup with multiple unrelated samples. Let the index i denote the
sample, j the genomic position and k a particular nucleotide. Let Xijk and X ′
ijk denote the counts of
nucleotide k in sample i on position j in forward and reverse read orientation, respectively. We assume
that

X ∼ BetaBin(n, µ, ρ)
X ′ ∼ BetaBin(n′, µ′, ρ).

(1)

are beta-binomially distributed. To test if there is a variant k in sample i, we compare the counts to a
compound reference Xijk = (cid:80)
ijk = (cid:80)
hjk. The subset of indeces H is usually
chosen such that H = {h : h ̸= j}, that is the row sums Xijk and X ′
ijk. To reduce the effect of true

h∈H Xhjk and X ′

h∈H X ′

1

variants in other samples entering the compound reference, one may also choose H such that it only
includes sample h with variant allele frequencies below a user defined threshold, typically 10%.
We model the compound reference again as a beta-binomial,

X ∼ BetaBin(n, ν, ρ)
X′ ∼ BetaBin(n′, ν′, ρ).

2.2 Testing for variants

(2)

Testing for the presence of a variant can now be formulated as a model selection problem in which we
specify a null model and an alternative. Here we consider two options, "OR" and "AND".

2.2.1 The OR model

The OR model is defined in the following way:

M0 :
M1 :

µ = ν ∨ µ′ = ν′
µ = µ′ > ν, ν′.

(3)

Under the null model M0, the mean rates of the beta-binomials are identical in sample i and the com-
pound reference on at least one strand. Under the alternative model M1, the mean rates µ, µ′ are identical
on both strands and greater than the mean in the compound reference on both strands.
Here we use the following point estimates for the parameters:

ˆµ = (X + X ′)/(n + n′)
ˆν = X/n
ˆν′ = X′/n′
ˆν0 = (X + X)/(n + n)
ˆν′
0 = (X ′ + X′)/(n′ + n′)
ˆµ0 = X/n
0 = X ′/n′.
ˆµ′

Using these values, the Bayes factor is approximated by

Pr(D | M0)
Pr(D | M1)

=

Pr(X|ˆν0) Pr(X ′|ˆµ′
0) Pr(X|ˆν0)
Pr(X|ˆµ) Pr(X ′|ˆµ) Pr(X|ˆν)
Pr(X|ˆµ0) Pr(X ′|ˆν′
0) Pr(X′|ˆν′
0)
Pr(X|ˆµ) Pr(X ′|ˆµ) Pr(X′|ˆν′)
0) Pr(X′|ˆν′
Pr(X|ˆν0) Pr(X|ˆν0) Pr(X ′|ˆν′
0)
Pr(X|ˆµ) Pr(X|ˆν) Pr(X ′|ˆµ) Pr(X′|ˆν′)

−

+

(4)

(5)

Example The Bayes factors can be computed using the bbb command:

library(deepSNV)
library(RColorBrewer)
100 ## Coverage
n <-
n_samples <- 1000 ## Assume 1000 samples
x <-
X <-
par(bty="n", mgp = c(2,.5,0), mar=c(3,3,2,2)+.1, las=1, tcl=-.33, mfrow=c(2,2))
for(nu in 10^c(-4,-2)){ ## Loop over error rates
## Create counts array with errors
counts = aperm(array(c(rep(round(n_samples*n* c(nu,1-nu,nu,1-nu)), each=nrow(X)), cbind(n - X, X)[,c(3,1,4,2)]),

0:20 ## Nucleotide counts
cbind(rep(x, each = length(x)), rep(x, length(x))) ## All combinations forward and reverse

for(rho in c(1e-4, 1e-2)){ ## Loop over dispersion factors

## Compute Bayes factors
BF = bbb(counts, rho=rho, model="OR", return="BF")

dim=c(nrow(X) ,4,2)), c(3,1,2))

2

## Plot
image(z=log10(matrix(BF[2,,1], nrow=length(x))),

x=x,
y=x,
breaks=c(-100,-8:0),
col=rev(brewer.pal(9,"Reds")),
xlab = "Forward allele count",
ylab="Backward allele count",
main = paste("rho =", format(rho, digits=2), "nu = ", format(nu, digits=2)),
font.main=1)

text(X[,1],X[,2],ceiling(log10(matrix(BF[2,,1], nrow=length(x)))), cex=0.5)

}

}

Here we have used a coverage of n = 100 on both strands and computed the Bayes factors assuming 1,000
samples to estimate the error rate ν = ν′ from. Shown are results for fixed values of rho = {10−4, 10−2}.

2.2.2 The AND model

The AND model is defined in the following way:

M0 :
M1 :

µ = ν ∧ µ′ = ν′
µ = µ′ > ν, ν′.

(6)

Here the null model states that the error rates ν = µ and ν′ = µ′ are identical on both strands, which is
more restrictive and hence in favour of the alternative.
In this case the Bayes factor is approximately

Pr(D | M0)
Pr(D | M1)

=

0) Pr(X′|ˆν′
Pr(X|ˆν0) Pr(X|ˆν0) Pr(X ′|ˆν′
0)
Pr(X|ˆµ) Pr(X|ˆν) Pr(X ′|ˆµ) Pr(X′|ˆν′)

(7)

Example The behaviour of the AND model can be inspected by the following commands

par(bty="n", mgp = c(2,.5,0), mar=c(3,3,2,2)+.1, las=1, tcl=-.33, mfrow=c(2,2))
for(nu in 10^c(-4,-2)){ ## Loop over error rates
## Create counts array with errors

3

0510152005101520rho = 1e−04 nu =  1e−04Forward allele countBackward allele count0111222333444555666771−1−1−1−100001111222333441−1−2−3−3−3−2−2−2−2−1−1−1−100001111−1−3−4−5−5−4−4−4−4−4−4−3−3−3−3−2−2−2−2−12−1−3−5−6−6−6−6−6−6−6−6−6−5−5−5−5−4−4−4−420−3−5−6−8−8−8−8−8−8−8−8−7−7−7−7−7−6−6−620−2−4−6−8−10−10−10−10−10−10−10−10−9−9−9−9−9−8−830−2−4−6−8−10−12−12−12−12−12−12−12−12−11−11−11−11−11−1030−2−4−6−8−10−12−14−14−14−14−14−14−14−13−13−13−13−13−1331−2−4−6−8−10−12−14−16−16−16−16−16−16−16−15−15−15−15−1541−1−4−6−8−10−12−14−16−18−18−18−18−18−18−17−17−17−17−1741−1−4−6−8−10−12−14−16−18−19−20−20−20−20−20−19−19−19−1941−1−3−6−8−10−12−14−16−18−20−21−22−22−22−22−21−21−21−2152−1−3−5−7−10−12−14−16−18−20−22−23−24−24−24−23−23−23−23520−3−5−7−9−12−14−16−18−20−22−24−25−26−26−25−25−25−25520−3−5−7−9−11−13−16−18−20−22−24−26−27−27−27−27−27−27630−2−5−7−9−11−13−15−17−20−22−24−26−27−29−29−29−29−29630−2−4−7−9−11−13−15−17−19−21−23−25−27−29−31−31−31−31631−2−4−6−9−11−13−15−17−19−21−23−25−27−29−31−33−33−33741−2−4−6−8−11−13−15−17−19−21−23−25−27−29−31−33−35−35741−1−4−6−8−10−13−15−17−19−21−23−25−27−29−31−33−35−370510152005101520rho = 0.01 nu =  1e−04Forward allele countBackward allele count0111122222333334444451−1−1−1−1−1−1−100000011111121−1−1−1−1−1−1−1−1−1−1−1−1000000111−1−1−2−2−2−2−2−2−1−1−1−1−1−1−1−1−10001−1−1−2−2−2−2−2−2−2−2−2−2−2−1−1−1−1−1−1−12−1−1−2−2−2−2−2−2−2−2−2−2−2−2−2−2−2−1−1−12−1−1−2−2−2−2−3−3−3−3−3−3−2−2−2−2−2−2−2−22−1−1−2−2−2−3−3−3−3−3−3−3−3−3−3−3−3−2−2−220−1−2−2−2−3−3−3−3−3−3−3−3−3−3−3−3−3−3−320−1−1−2−2−3−3−3−3−3−4−4−4−3−3−3−3−3−3−330−1−1−2−2−3−3−3−3−4−4−4−4−4−4−4−4−4−4−430−1−1−2−2−3−3−3−4−4−4−4−4−4−4−4−4−4−4−430−1−1−2−2−3−3−3−4−4−4−4−4−4−4−4−4−4−4−4300−1−2−2−2−3−3−4−4−4−4−5−5−5−5−5−5−5−5310−1−1−2−2−3−3−3−4−4−4−5−5−5−5−5−5−5−5410−1−1−2−2−3−3−3−4−4−4−5−5−5−5−5−5−5−5410−1−1−2−2−3−3−3−4−4−4−5−5−5−5−6−6−6−6410−1−1−2−2−3−3−3−4−4−4−5−5−5−6−6−6−6−64100−1−1−2−2−3−3−4−4−4−5−5−5−6−6−6−6−64110−1−1−2−2−3−3−4−4−4−5−5−5−6−6−6−6−75210−1−1−2−2−3−3−4−4−4−5−5−5−6−6−6−7−70510152005101520rho = 1e−04 nu =  0.01Forward allele countBackward allele count01111222333344455566710111112222333444555511000111112222333444411000000011112222233311000−1−1000000111112222110−1−1−1−1−1−1−1−1−1000001112110−1−1−2−2−2−2−2−2−2−1−1−1−1−100022100−1−2−3−3−3−3−3−2−2−2−2−2−2−2−1−132100−1−2−3−3−4−4−4−3−3−3−3−3−3−3−3−232110−1−2−3−4−4−5−5−5−4−4−4−4−4−4−4−432210−1−2−3−4−5−5−6−6−5−5−5−5−5−5−5−533210−1−2−3−4−5−6−6−7−7−7−6−6−6−6−6−643210−1−2−2−3−5−6−7−7−8−8−8−8−7−7−7−7432210−1−2−3−4−5−7−8−8−9−9−9−9−9−8−8443210−1−2−3−4−5−7−8−9−10−10−10−10−10−10−10543210−1−2−3−4−5−6−8−9−10−11−11−11−11−11−11543210−1−2−3−4−5−6−8−9−10−11−12−12−12−12−12554210−1−2−3−4−5−6−7−9−10−11−12−13−13−13−136543210−2−3−4−5−6−7−9−10−11−12−13−14−15−156543210−1−3−4−5−6−7−8−10−11−12−13−15−16−167543210−1−2−4−5−6−7−8−10−11−12−13−15−16−170510152005101520rho = 0.01 nu =  0.01Forward allele countBackward allele count01111112222233333444410111111112222223333311000011111111222222311000000001111111122211000000000000111111111000000000000000011111100000−1−1−100000000002110000−1−1−1−1−1−1−1−1−1−10000211000−1−1−1−1−1−1−1−1−1−1−1−1−1−1−1211000−1−1−1−1−1−1−1−1−1−1−1−1−1−1−1221100−1−1−1−1−2−2−2−2−2−2−2−2−2−1−12211000−1−1−1−2−2−2−2−2−2−2−2−2−2−23211000−1−1−1−2−2−2−2−2−2−2−2−2−2−23211000−1−1−1−2−2−2−2−3−3−3−3−3−3−33221100−1−1−1−2−2−2−3−3−3−3−3−3−3−33221100−1−1−1−2−2−2−3−3−3−3−3−3−3−33321100−1−1−1−2−2−2−3−3−3−3−3−4−4−443211000−1−1−2−2−2−3−3−3−3−4−4−4−443221100−1−1−2−2−2−3−3−3−4−4−4−4−443221100−1−1−1−2−2−3−3−3−4−4−4−4−443321100−1−1−1−2−2−3−3−3−4−4−4−4−5counts = aperm(array(c(rep(round(n_samples*n* c(nu,1-nu,nu,1-nu)), each=nrow(X)), cbind(n - X, X)[,c(3,1,4,2)]),

dim=c(nrow(X) ,4,2)), c(3,1,2))

for(rho in c(1e-4, 1e-2)){ ## Loop over dispersion factors

## Compute Bayes factors, mode = "AND"
BF = bbb(counts, rho=rho, model="AND", return="BF")
## Plot
image(z=log10(matrix(BF[2,,1], nrow=length(x))),

x=x,
y=x,
breaks=c(-100,-8:0),
col=rev(brewer.pal(9,"Reds")),
xlab = "Forward allele count",
ylab="Backward allele count",
main = paste("rho =", format(rho, digits=2), "nu = ", format(nu, digits=2)),
font.main=1)

text(X[,1],X[,2],ceiling(log10(matrix(BF[2,,1], nrow=length(x)))), cex=0.5)

}

}

One realises that for small dispersion the Bayes factor depends mostly on the sum of the forward and
reverse strands in the AND model.

2.3 Estimating ρ

If the dispersion parameter ρ is not specified, it is estiated at each locus using the following method-of-
moment estimator:

ˆρ =

s2 =

i=1 1/ni

N s2/(1 − ˆν)/ˆν − (cid:80)N
N − (cid:80)N
i=1 1/ni
i=1 ni(ˆν − ˆµi)2

N (cid:80)N

(N − 1) (cid:80)N

i=1 ni

.

This yields consistent estimates over a range of true values:

4

(8)

0510152005101520rho = 1e−04 nu =  1e−04Forward allele countBackward allele count0−1−2−4−5−7−8−10−12−13−15−16−18−20−21−23−24−26−28−29−31−1−3−4−6−8−9−11−12−14−16−17−19−21−22−24−26−27−29−31−32−34−2−4−6−8−10−11−13−15−16−18−20−21−23−25−27−28−30−32−33−35−37−4−6−8−10−12−13−15−17−19−20−22−24−25−27−29−31−32−34−36−37−39−5−8−10−12−13−15−17−19−21−22−24−26−28−29−31−33−35−36−38−40−42−7−9−11−13−15−17−19−21−23−24−26−28−30−32−33−35−37−39−40−42−44−8−11−13−15−17−19−21−23−25−26−28−30−32−34−35−37−39−41−43−44−46−10−12−15−17−19−21−23−25−27−28−30−32−34−36−38−39−41−43−45−47−48−12−14−16−19−21−23−25−27−29−30−32−34−36−38−40−41−43−45−47−49−51−13−16−18−20−22−24−26−28−30−32−34−36−38−40−42−44−45−47−49−51−53−15−17−20−22−24−26−28−30−32−34−36−38−40−42−44−46−47−49−51−53−55−16−19−21−24−26−28−30−32−34−36−38−40−42−44−46−48−49−51−53−55−57−18−21−23−25−28−30−32−34−36−38−40−42−44−46−48−50−52−53−55−57−59−20−22−25−27−29−32−34−36−38−40−42−44−46−48−50−52−54−55−57−59−61−21−24−27−29−31−33−35−38−40−42−44−46−48−50−52−54−55−57−59−61−63−23−26−28−31−33−35−37−39−41−44−46−48−50−52−54−56−57−59−61−63−65−24−27−30−32−35−37−39−41−43−45−47−49−52−54−55−57−59−61−63−65−67−26−29−32−34−36−39−41−43−45−47−49−51−53−55−57−59−61−63−65−67−69−28−31−33−36−38−40−43−45−47−49−51−53−55−57−59−61−63−65−67−69−71−29−32−35−37−40−42−44−47−49−51−53−55−57−59−61−63−65−67−69−71−73−31−34−37−39−42−44−46−48−51−53−55−57−59−61−63−65−67−69−71−73−750510152005101520rho = 0.01 nu =  1e−04Forward allele countBackward allele count0−1−1−1−1−1−2−2−2−2−2−2−2−2−2−2−3−3−3−3−3−1−3−3−3−4−4−4−4−4−4−5−5−5−5−5−5−5−6−6−6−6−1−3−4−4−4−4−5−5−5−5−5−5−6−6−6−6−6−6−7−7−7−1−3−4−4−4−5−5−5−5−6−6−6−6−6−7−7−7−7−7−7−8−1−4−4−4−5−5−5−6−6−6−6−7−7−7−7−7−8−8−8−8−8−1−4−4−5−5−5−6−6−6−6−7−7−7−7−8−8−8−8−8−9−9−2−4−5−5−5−6−6−6−7−7−7−7−8−8−8−8−8−9−9−9−9−2−4−5−5−6−6−6−7−7−7−7−8−8−8−8−9−9−9−9−10−10−2−4−5−5−6−6−7−7−7−7−8−8−8−9−9−9−9−10−10−10−10−2−4−5−6−6−6−7−7−7−8−8−8−9−9−9−9−10−10−10−10−11−2−5−5−6−6−7−7−7−8−8−8−9−9−9−10−10−10−10−11−11−11−2−5−5−6−7−7−7−8−8−8−9−9−9−10−10−10−10−11−11−11−11−2−5−6−6−7−7−8−8−8−9−9−9−10−10−10−10−11−11−11−12−12−2−5−6−6−7−7−8−8−9−9−9−10−10−10−11−11−11−11−12−12−12−2−5−6−7−7−8−8−8−9−9−10−10−10−11−11−11−11−12−12−12−13−2−5−6−7−7−8−8−9−9−9−10−10−10−11−11−11−12−12−12−13−13−3−5−6−7−8−8−8−9−9−10−10−10−11−11−11−12−12−12−13−13−13−3−6−6−7−8−8−9−9−10−10−10−11−11−11−12−12−12−13−13−13−14−3−6−7−7−8−8−9−9−10−10−11−11−11−12−12−12−13−13−13−14−14−3−6−7−7−8−9−9−10−10−10−11−11−12−12−12−13−13−13−14−14−14−3−6−7−8−8−9−9−10−10−11−11−11−12−12−13−13−13−14−14−14−150510152005101520rho = 1e−04 nu =  0.01Forward allele countBackward allele count011000−1−1−2−2−3−4−4−5−6−7−8−8−9−10−1110000−1−1−2−2−3−4−4−5−6−7−8−9−9−10−11−121000−1−1−2−2−3−4−4−5−6−7−8−9−10−10−11−12−13000−1−1−2−2−3−4−4−5−6−7−8−9−10−11−11−12−13−1400−1−1−2−2−3−4−4−5−6−7−8−9−10−11−12−13−14−15−160−1−1−2−2−3−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−1−1−2−2−3−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−1−2−2−3−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−2−2−3−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−2−3−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−3−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−4−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−24−4−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−24−25−5−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−24−25−26−6−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−24−25−26−27−7−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−24−25−26−27−29−8−9−10−11−12−13−14−15−16−17−18−19−20−21−23−24−25−26−27−29−30−8−9−10−11−13−14−15−16−17−18−19−20−21−23−24−25−26−27−29−30−31−9−10−11−12−14−15−16−17−18−19−20−21−23−24−25−26−27−29−30−31−32−10−11−12−13−15−16−17−18−19−20−21−23−24−25−26−27−29−30−31−32−34−11−12−13−14−16−17−18−19−20−21−23−24−25−26−27−29−30−31−32−34−350510152005101520rho = 0.01 nu =  0.01Forward allele countBackward allele count01100000000000−1−1−1−1−1−1−110000000−1−1−1−1−1−1−1−1−2−2−2−2−2100000−1−1−1−1−1−1−2−2−2−2−2−2−3−3−30000−1−1−1−1−1−2−2−2−2−2−3−3−3−3−3−3−4000−1−1−1−1−2−2−2−2−2−3−3−3−3−3−4−4−4−4000−1−1−1−2−2−2−2−3−3−3−3−3−4−4−4−4−4−500−1−1−1−2−2−2−2−3−3−3−3−4−4−4−4−4−5−5−500−1−1−2−2−2−2−3−3−3−3−4−4−4−4−5−5−5−5−60−1−1−1−2−2−2−3−3−3−4−4−4−4−5−5−5−5−6−6−60−1−1−2−2−2−3−3−3−4−4−4−4−5−5−5−5−6−6−6−60−1−1−2−2−3−3−3−4−4−4−4−5−5−5−6−6−6−6−7−70−1−1−2−2−3−3−3−4−4−4−5−5−5−6−6−6−6−7−7−70−1−2−2−3−3−3−4−4−4−5−5−5−6−6−6−7−7−7−7−80−1−2−2−3−3−4−4−4−5−5−5−6−6−6−7−7−7−7−8−8−1−1−2−3−3−3−4−4−5−5−5−6−6−6−7−7−7−7−8−8−8−1−1−2−3−3−4−4−4−5−5−6−6−6−7−7−7−8−8−8−8−9−1−2−2−3−3−4−4−5−5−5−6−6−7−7−7−8−8−8−8−9−9−1−2−2−3−4−4−4−5−5−6−6−6−7−7−7−8−8−8−9−9−9−1−2−3−3−4−4−5−5−6−6−6−7−7−7−8−8−8−9−9−9−10−1−2−3−3−4−4−5−5−6−6−7−7−7−8−8−8−9−9−9−10−10−1−2−3−4−4−5−5−6−6−6−7−7−8−8−8−9−9−9−10−10−10rho = 10^seq(-6,-1)
rhoHat <- sapply(rho, function(r){

sapply(1:100, function(i){

n = 100
X = rbetabinom(1000, n, 0.01, rho=r)
X = cbind(X, n-X)
Y = array(X, dim=c(1000,1,2))
deepSNV:::estimateRho(Y, Y/n, Y < 1000)[1,1]})

})

par(bty="n", mgp = c(2,.5,0), mar=c(3,4,1,1)+.1,
plot(rho, type="l", log="y", xaxt="n", xlab="rho", ylab="rhoHat", xlim=c(0.5,6.5), lty=3)
boxplot(t(rhoHat+ 1e-7) ~ rho, add=TRUE, col="#FFFFFFAA", pch=16, cex=.5, lty=1, staplewex=0)
points(colMeans(rhoHat), pch="*", col="red", cex=2)

tcl=-.33)

2.4 Using a prior
shearwater calls variants if the posterior probability that the null model M0 is true falls below a certain
threshold. Generally, the posterior odds is given by

Pr(M0 | D)
Pr(M1 | D)

=

1 − π(M1))
π(M1)

Pr(D | M0)
Pr(D | M1)

(9)

where π = π(M1) is the prior probability of that a variant exists. These probabilities are not uniform and
may be calculated from the distribution of observed somatic mutations. Such data can be found in the
COSMIC data base http://www.sanger.ac.uk/cosmic.
As of now, the amount of systematic, genome-wide screening data is still sparse, which makes it difficult
to get good estimates of the mutation frequencies in each cancer type. However, a wealth of data exists
for somatic mutations within a given gene. Assume we know how likely it is that a gene is mutated. We
then model

π =

(cid:40)

πgene × # Mutations at given position
πbackground

# Mutations in gene

if variant in COSMIC
else.

(10)

Suppose you have downloaded the COSMIC vcf "CosmicCodingMuts_v63_300113.vcf.gz" from ftp:
//ngs.sanger.ac.uk/production/cosmic.

## Not run..
## Load TxDb
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
seqlevels(txdb) <- sub("chr","",seqlevels(txdb))

## Make prior

5

1e−061e−041e−02rhorhoHat1e−061e−040.010.11e−061e−041e−02******regions <- reduce(exons(txdb, filter=list(gene_id='7157'))) ## TP53 exons
cosmic <- readVcf("CosmicCodingMuts_v63_300113.vcf.gz", "hg19", param=ScanVcfParam(which=regions))
pi <- makePrior(cosmic, regions, pi.gene = 1)

The resulting prior can be visualised:

## Load pi
data(pi, package="deepSNV")

## Plot
par(bty="n", mgp = c(2,.5,0), mar=c(3,3,2,2)+.1, tcl=-.33)
plot(pi[,1], type="h", xlab="Position", ylab="Prior", col=brewer.pal(5,"Set1")[1], ylim=c(0,0.075))
for(j in 2:5)

lines(pi[,j], type="h", col=brewer.pal(5,"Set1")[j])

legend("topleft", col=brewer.pal(5,"Set1"), lty=1, bty="n", c("A","T","C","G","del"))

The data shows that the distribution of somatic variants is highly non-uniform, with multiple mutation
hotspots.

3 Using shearwater

To run shearwater you need a collection of .bam files and the set of regions you want to analyse as a
GRanges() object. Additionally, you may calculate a prior from a VCF file that you can download from
ftp://ngs.sanger.ac.uk/production/cosmic.

3.1 Minimal example

Here is a minimal example that uses two .bam files from the deepSNV package. The data is loaded into
a large array using the loadAllData() function:

## Load data from deepSNV example
regions <- GRanges("B.FR.83.HXB2_LAI_IIIB_BRU_K034", IRanges(start = 3120, end=3140))
files <- c(system.file("extdata", "test.bam", package="deepSNV"), system.file("extdata", "control.bam", package="deepSNV"))
counts <- loadAllData(files, regions, q=10)
dim(counts)

## [1]

2 21 10

The dimension of counts for N samples, a total of L positions is N × L × 2|B|, where |B| = 5 is the size
of the alphabet B = {A, T, C, G, −} and the factor of 2 for the two strand orientations.
The Bayes factors can be computed with the bbb function:

6

010002000300040000.000.020.040.06PositionPriorATCGdel## Run (bbb) computes the Bayes factor
bf <- bbb(counts, model = "OR", rho=1e-4)
dim(bf)

## [1]

2 21

5

vcf <- bf2Vcf(bf, counts, regions, cutoff = 0.5, samples = files, prior = 0.5, mvcf = TRUE)
show(vcf)

## class: CollapsedVCF
## dim: 8 2
## rowRanges(vcf):
##
## info(vcf):
##
## info(header(vcf)):
##
##
##
##
##
## geno(vcf):
##
## geno(header(vcf)):
##
##
##
##
##
##
##
##
##

GT 1
GQ 1
BF 1
VF 1
FW 1
BW 1
FD 1
BD 1

Number Type

GRanges with 4 metadata columns: REF, ALT, QUAL, FILTER

DataFrame with 4 columns: ER, PI, AF, LEN

Number Type Description
1
ER
1
PI
AF
1
LEN 1

Float Error rate
Float Prior
Float Allele frequency in cohort
Float Length of the alt allele

List of length 8: GT, GQ, BF, VF, FW, BW, FD, BD

Description
String
Genotype
Integer Genotype Quality
Float
Float
Integer Forward variant read count
Integer Backward variant read count
Integer Read Depth forward
Integer Read Depth backward

Bayes factor
Variant frequency in sample

The resulting Bayes factors were thresholded by a posterior cutoff for variant calling and converted into
a VCF object by bf2Vcf.
For two samples the Bayes factors are very similar to the p-values obtained by deepSNV:

## Shearwater Bayes factor under AND model
bf <- bbb(counts, model = "AND", rho=1e-4)
## deepSNV P-value with combine.method="fisher" (product)
dpSNV <- deepSNV(test = files[1], control = files[2], regions=regions, q=10, combine.method="fisher")
## Plot
par(bty="n", mgp = c(2,.5,0), mar=c(3,3,2,2)+.1, tcl=-.33)
plot(p.val(dpSNV), bf[1,,]/(1+bf[1,,]), log="xy",

xlab = "P-value deepSNV",
ylab = "Posterior odds shearwater"
)

7

3.2 More realistic example

Suppose the bam files are in folder ./bam and the regions of interest are stored in a GRanges() object with
metadata column Gene, indicating which region (typically exons for a pulldown experiment) belongs to
which gene. Also assume that we have a tabix indexed vcf file CosmicCodingMuts_v63_300113.vcf.gz.
The analysis can be parallelized by separately analysing each gene, which is the unit needed to compute
the prior using makePrior.

## Not run
files <- dir("bam", pattern="*.bam$", full.names=TRUE)
MC_CORES <- getOption("mc.cores", 2L)
vcfList <- list()
for(gene in levels(mcols(regions)$Gene)){

rgn <- regions[mcols(regions)$Gene==gene]
counts <- loadAllData(files, rgn, mc.cores=MC_CORES)
## Split into
BF <-
COSMIC <- readVcf("CosmicCodingMuts_v63_300113.vcf.gz", "GRCh37", param=ScanVcfParam(which=rgn) )
prior <- makePrior(COSMIC, rgn, pi.mut = 0.5)
vcfList[[gene]] <- bf2Vcf(BF = BF, counts=counts, regions=rgn, samples = files, cutoff = 0.5, prior = prior)

mcChunk("bbb", split = 200, counts, mc.cores=MC_CORES)

}
## Collapse vcfList
vcf <- do.call(rbind, vcfList)

The mcChunk function splits the counts objects into chunks of size split and processes these in parallel
using mclapply.
Instead of using a for loop one can also use a different mechanism, e.g.
computing cluster, etc.

submitting this code to a

sessionInfo()

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

8

1e−461e−281e−101e−411e−251e−09P−value deepSNVPosterior odds shearwater• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, parallel, splines, stats, stats4, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, Biostrings 2.78.0, GenomicRanges 1.62.0,
IRanges 2.44.0, MatrixGenerics 1.22.0, RColorBrewer 1.1-3, Rsamtools 2.26.0, S4Vectors 0.48.0,
Seqinfo 1.0.0, SummarizedExperiment 1.40.0, VGAM 1.1-13, VariantAnnotation 1.56.0,
XVector 0.50.0, deepSNV 1.56.0, generics 0.1.4, knitr 1.50, matrixStats 1.5.0

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, BSgenome 1.78.0,

BiocIO 1.20.0, BiocParallel 1.44.0, DBI 1.2.3, DelayedArray 0.36.0, GenomicAlignments 1.46.0,
GenomicFeatures 1.62.0, KEGGREST 1.50.0, Matrix 1.7-4, R6 2.6.1, RCurl 1.98-1.17,
RSQLite 2.4.3, Rhtslib 3.6.0, S4Arrays 1.10.0, SparseArray 1.10.0, XML 3.99-0.19, abind 1.4-8,
bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, bslib 0.9.0, cachem 1.1.0, cigarillo 1.0.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0, digest 0.6.37, evaluate 1.0.5,
fastmap 1.2.0, grid 4.5.1, highr 0.11, htmltools 0.5.8.1, httr 1.4.7, jquerylib 0.1.4, jsonlite 2.0.0,
lattice 0.22-7, lifecycle 1.0.4, memoise 2.0.1, png 0.1-8, restfulr 0.0.16, rjson 0.2.23, rlang 1.1.6,
rmarkdown 2.30, rtracklayer 1.70.0, sass 0.4.10, tools 4.5.1, vctrs 0.6.5, xfun 0.53, yaml 2.3.10

9

