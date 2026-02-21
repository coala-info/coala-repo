semisup: detecting SNPs with interactive effects
on a quantitative trait

A Rauschenberger, RX Menezes, MA van de Wiel,
NM van Schoor, and MA Jonker

October 30, 2025

This vignette explains how to use the R package semisup. Use the function
mixtura for model fitting, and the function scrutor for hypothesis testing.

1

Initialisation

Start with installing semisup from Bioconductor1:

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("semisup")

Then load and attach the package:

library(semisup)

If you want to reproduce the examples, you should attach the toy database:

attach(toydata)

The following commands access the reference manual:

help(semisup)
?semisup

1devtools and GitHub: devtools::install github("rauschenberger/semisup")

1

2 Scope

Data is available for n samples. Let y = (y1, . . . , yn)T represent the observa-
tions, x = (x1, . . . , xn)T the groups, and z = (z1, . . . , zn)T the classes. We
assume all observations from the labelled group are in class A, and those from
the unlabelled group are in class A or in class B.

1
y1
0

s
. . .
y
ys
. . .
. . .
0
x
z A . . . A A/B . . .

s + 1
ys+1
1

. . .
. . .
. . .

n = s + u
ys+u
1
A/B

Table 1: Observations y, groups x, and classes z. Here, the first s observations
are labelled (class A), and the last u observations are unlabelled (class A or B).

We assume all observations come from the same probability distribution, but
with different parameters for the two classes:

Yi|(Zi = A) ∼ F (·, θa),
Yi|(Zi = B) ∼ F (·, θb).

The mixing proportion τ is the probability that a random unlabelled observa-
tions is in class B. It is of interest to test whether τ is significantly larger than
zero.

τ = P[Zi = B|Xi = 1],
H0 : τ = 0,
H1 : τ > 0.

The function mixtura estimates the unknown parameters (θa, θb, τ ) and pre-
dicts the missing class labels in z = (z1, . . . , zn)T . The function scrutor tests
homogeneity (τ = 0) against heterogeneity (τ > 0).

2

3 Model fitting

Observing two groups of observations, we assume the labelled observations are
in class A, and the unlabelled observations are in class A or in class B.

The function mixtura estimates the unknown parameters and predicts the miss-
ing class labels:

fit <- mixtura(y,z)

Here, 21% of the unlabelled observations are assigned to class B, and all other
observations are assigned to class A:

class <- round(fit$posterior)

These are the parameter estimates:

fit$estim1

3

−20246ylabelledunlabelled−20246ylabelledunlabelledN(0,1)t=0.21N(5,1)4 Hypothesis testing

Under the null hypothesis, all observations are in class A. Under the alternative
hypothesis, some unlabelled observations are in class B.

The function mixtura not only fits the model under the alternative hypothesis
(see above), but also under the null hypothesis:

fit$estim0

Because the null distribution of the likelihood-ratio test statistic is unknown, we
compare the hypotheses by resampling. The function scrutor uses parametric
bootstrapping or permutation:

scrutor(y,z)

If the p-value is less than or equal to the significance level, we reject the null
hypothesis in favour of the alternative hypothesis.

Options

The functions mixtura and scrutor have similar arguments. Set dist equal to
"norm" or "nbinom" to choose between the Gaussian and the negative binomial
distributions. In the latter case, optionally provide a dispersion estimate phi or
an offset gamma. All other arguments are technical.

4

−20246ylabelledunlabelledN(1,2)t=0N(−,−)5 Application

5.1 Data preparation

Let n be the sample size, q the number of quantitative traits, and p the number
of single nucleotide polymorphisms (snps).

• Transform the quantitative trait to a vector of length n, or transform
the quantitative traits to a matrix with n rows (samples) and q columns
(variables).

• Transform the snp to a vector of length n, or transform the snps to a

matrix with n rows (samples) and p columns (variables).

• Binarise the snp(s), indicating the labelled group by zero, and the unla-

belled group by a missing value.

For example, assign observations with zero minor alleles to the labelled group,
and those with one or two minor alleles to the unlabelled group:

n <- length(snp)

n <- nrow(SNPs)
p <- ncol(SNPs)

z <- rep(NA,times=n)
z[snp==0] <- 0

Z <- matrix(NA,nrow=n,ncol=p)
Z[SNPs==0] <- 0

5.2 Test of association

Use scrutor to test for association between a quantitative trait (vector) and a
snp (vector). The function returns a test statistic and a p-value.

y =






















z =








z1
z2
...
zn,

y

z

y1
y2
...
yn

scrutor(y,z)

5

5.3 Genome-wide association study

Use scrutor to test for association between a quantitative trait (vector) and
several snps (matrix). For each snp, the function returns a test statistic and a
p-value.

y =








y1
y2
...
yn








y

Z
n×p

=








z1,1
z2,1
...
zn,1

z1,2
z2,2
...
zn,2

· · ·
· · ·
. . .
· · ·








z1,p
z2,p
...
zn,p

scrutor(y,Z)

z1

z2

z3

· · ·

zp

5.4 Differential expression analysis

Use scrutor to test for association between several quantitative traits (matrix)
and a snp (vector). For each quantitative trait, the function returns a test
statistic and a p-value.

Y
n×q

=








y1,1
y2,1
...
yn,1

y1,2
y2,2
...
yn,2

· · ·
· · ·
. . .
· · ·








y1,q
y2,q
...
yn,q

y1

y2

y3

· · ·

yq








z








z1
z2
...
zn

z =

scrutor(Y,z)

5.5 Expression quantitative trait loci analysis

Use scrutor to test for association between several quantitative traits (matrix)
and several snps (matrix). If their numbers are different, all pairwise combina-
tions are considered. If their numbers are equal, a one-to-one correspondence

6

is assumed. For each combination, the function returns a test statistic and a
p-value.

y1

y2

y3

· · ·

yq

z1

z2

z3

· · ·

zp

Y
n×q

=

Z
n×p

=








y1,1
y2,1
...
yn,1








z1,1
z2,1
...
zn,1

y1,2
y2,2
...
yn,2

z1,2
z2,2
...
zn,2

· · ·
· · ·
. . .
· · ·

· · ·
· · ·
. . .
· · ·








y1,q
y2,q
...
yn,q








z1,p
z2,p
...
zn,p

scrutor(Y,Z)

References

The R package semisup is based on Rauschenberger et al. [1], where detailed
references to previous work are given.
If you use semisup for publications,
please cite Rauschenberger et al. [1].

Consider shrinkage estimation (Robinson et al. [3]) and scale normalisation
(Robinson et al. [2]) to improve the negative binomial mixture model (R pack-
age edgeR). Use the non-parametric mixture test (van Wieringen et al. [4]) to
increase robustness against outliers (R package PDGEtest).

[1] Armin Rauschenberger, Ren´ee X Menezes, Mark A van de Wiel, Natasja M
van Schoor, and Marianne A Jonker. Detecting SNPs with interactive effects
on a quantitative trait. Manuscript in preparation, 0:0, 2018.

[2] Mark D Robinson and Alicia Oshlack. A scaling normalization method
for differential expression analysis of RNA-Seq data. Genome Biology,
11(3):R25, 2010. link.

[3] Mark D Robinson and Gordon K Smyth. Small-sample estimation of neg-
ative binomial dispersion, with applications to SAGE data. Biostatistics,
9(2):321–332, 2008. link.

[4] Wessel N Van Wieringen, Mark A van de Wiel, and Aad W van der Vaart.
A test for partial differential expression. Journal of the American Statistical
Association, 103(483):1039–1049, 2008. link.

7

