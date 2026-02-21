Imputed SNP analyses and meta-analysis with snpStats

David Clayton

October 30, 2025

Getting started

The need for imputation in SNP analysis studies occurs when we have a smaller set of samples
in which a large number of SNPs have been typed, and a larger set of samples typed in only a
subset of the SNPs. We use the smaller, complete dataset (which will be termed the training
dataset) to impute the missing SNPs in the larger, incomplete dataset (the target dataset).
Examples of such applications include:

• use of HapMap data to impute association tests for a large number of SNPs, given

data from genome-wide studies using, for example, a 500K SNP array, and

• meta-analyses which seek to combine results from two platforms such as the Affymetrix

500K and Illumina 550K platforms.

Here we will not use a real example such as the above to explore the use of snpStats for
imputation, but generate a fictitious example using the data analysed in earlier exercises.
This is particularly artificial in that we have seen that these data suffer from extreme het-
erogeneity of population structure.

We start by attaching the required libraries and accessing the data used in the exercises:

> library(snpStats)
> library(hexbin)
> data(for.exercise)

We shall sample 200 subjects in our fictitious study as the training data set, select every
second SNP to be missing in the target dataset, and split the training set into two parts
accordingly:

> training <- sample(1000, 200)
> select <- seq(1, ncol(snps.10),2)
> missing <- snps.10[training, select]
> present <- snps.10[training, -select]
> missing

1

A SnpMatrix with
Row names:
Col names:

ceu.500 ... jpt.583
rs7909677 ... rs12218790

200 rows and

14251 columns

> present

A SnpMatrix with
Row names:
Col names:

ceu.500 ... jpt.583
rs7093061 ... rs7899159

200 rows and

14250 columns

Thus the training dataset consists of the objects missing and present. The target dataset
holds a subset of the SNPs for the remaining 800 subjects.

> target <- snps.10[-training, -select]
> target

A SnpMatrix with
Row names:
Col names:

jpt.869 ... jpt.347
rs7093061 ... rs7899159

800 rows and

14250 columns

But, in order to see how successful we have been with imputation, we will also save the SNPs
we have removed from the target dataset

> lost <- snps.10[-training, select]
> lost

A SnpMatrix with
Row names:
Col names:

jpt.869 ... jpt.347
rs7909677 ... rs12218790

800 rows and

14251 columns

We also need to know where the SNPs are on the chromosome in order to avoid having to
search the entire chromosome for suitable predictors of a missing SNP:

> pos.miss <- snp.support$position[select]
> pos.pres <- snp.support$position[-select]

Calculating the imputation rules

The next step is to calculate a set of rules which for imputing the missing SNPs from the
present SNPs. This is carried out by the function snp.imputation1:

> rules <- snp.imputation(present, missing, pos.pres, pos.miss)

1Sometimes this command generates a warning message concerning the maximum number of EM itera-

tions. If this only concerns a small proportion of the SNPs to be imputed it can be ignored.

2

SNPs tagged by a single SNP: 4966
SNPs tagged by multiple tag haplotypes (saturated model): 9115

This step executes remarkably quickly when we consider what the function has done. For
each of the 14251 SNPs in the “missing” set, the function has performed a forward step-wise
regression on the 50 nearest SNPs in the “present” set, stopping each search either when the
R2 for prediction exceeds 0.95, or after including 4 SNPs in the regression, or until R2 is
not improved by at least 0.05. The figure 50 is the default value of the try argument of
the function, while the values 0.95, 4 and 0.05 together make up the default value of the
stopping argument. After the predictor, or “tag” SNPs have been chosen, the haplotypes
of the target SNP plus tags was phased and haplotype frequencies calculated using the EM
algorithm. These frequencies were then stored in the rules object. 2

A short listing of the first 10 rules follows:

> rules[1:10]

rs7909677
rs12773042 ~
rs11253563 ~
rs4881552
rs10904596 ~
rs4880781
rs7910845
rs6560730
rs9329280
rs4880517

~ rs2496276+rs2288680+rs4881551 (MAF = 0.06313131, R-squared = 0.5846981)

rs2496276+rs2288680+rs3132006+rs1672534 (MAF = 0.05102041, R-squared = 0.8876737)
rs7093061+rs9419496 (MAF = 0.2889447, R-squared = 0.9539558)

~ rs7475011+rs4881551+rs7093061+rs9419496 (MAF = 0.3316583, R-squared = 0.981732)

rs7093061+rs9419496+rs2288680 (MAF = 0.2839196, R-squared = 0.9750503)

~ rs4880983+rs3740304+rs4881308+rs3125027 (MAF = 0.2085427, R-squared = 0.9305308)
~ rs3123252 (MAF = 0.05808081, R-squared = 0.9535208)
~ rs9419496 (MAF = 0.315, R-squared = 0.988364)
~ rs3123252 (MAF = 0.05837563, R-squared = 0.9532819)
~ rs9419498+rs3123252 (MAF = 0.03787879, R-squared = 1)

The rules are also selectable by SNP name for detailed examination:

> rules[c('rs11253563', 'rs2379080')]

rs11253563 ~
rs2379080

rs7093061+rs9419496 (MAF = 0.2889447, R-squared = 0.9539558)

~ rs4880983+rs4880750+rs2379078+rs9419496 (MAF = 0.2373737, R-squared = 0.9248099)

Rules are shown with a + symbol separating predictor SNPs. (It is important to know which
SNPs were used for each imputation when checking imputed test results for artifacts.)

A summary table of all the 14,251 rules is generated by

> summary(rules)

2For imputation from small samples, some smoothing of these haplotype frequencies would be advanta-
geous and some ability to do this has been included. The use.haps argument to snp.imputation controls
this. But invoking this option slows down the algorithm and it is not advised other than for very small
sample sizes.

3

SNPs used

R-squared
[0,0.1)
[0.1,0.2)
[0.2,0.3)
[0.3,0.4)
[0.4,0.5)
[0.5,0.6)
[0.6,0.7)
[0.7,0.8)
[0.8,0.9)
[0.9,0.95)
[0.95,0.99)
[0.99,1]
<NA>

1 tags 2 tags 3 tags 4 tags <NA>
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
170

93
0
0
0
0
0
0
0
0
334
2199
2340
0

1
9
38
147
214
346
468
816
1341
1195
997
401
0

1
27
75
66
68
90
86
131
267
321
380
156
0

37
91
41
30
25
31
59
94
234
348
355
129
0

Columns represent the number of tag SNPs while rows represent grouping on R2. The last
column (headed <NA>) represents SNPs for which an imputation rule could not be computed,
either because they were monomorphic or because there was insufficient data (as determined
by the minA optional argument in the call to snp.imputation). The same information may
be displayed graphically by

> plot(rules)

4

Carrying out the association tests

The association tests for imputed SNPs can be carried out using the function single.snp.tests.

> imp <- single.snp.tests(cc, stratum, data=subject.support,
+

snp.data=target, rules=rules)

Using the observed data in the matrix target and the set of imputation rules stored
in rules, the above command imputes each of the imputed SNPs, carries out 1- and 2-df

5

4 tags3 tags2 tags1 tagsr2Number of imputed SNPs0100020003000[0.99,1][0.95,0.99)[0.9,0.95)[0.8,0.9)[0.7,0.8)[0.6,0.7)[0.5,0.6)[0.4,0.5)[0.3,0.4)[0.2,0.3)[0.1,0.2)[0,0.1)single locus tests for association, returns the results in the object imp. To see how successful
imputation has been, we can carry out the same tests using the true data in missing:

> obs <- single.snp.tests(cc, stratum, data=subject.support, snp.data=lost)

The next commands extract the p-values for the 1-df tests, using both the imputed and
the true “missing” data, and plot one against the other (using the hexbin plotting package
for clarity):

> logP.imp <- -log10(p.value(imp, df=1))
> logP.obs <- -log10(p.value(obs, df=1))
> hb <- hexbin(logP.obs, logP.imp, xbin=50)
> sp <- plot(hb)
> hexVP.abline(sp$plot.vp, 0, 1, col="black")

6

As might be expected, the agreement is rather better if we only compare the results for
SNPs that can be computed with high R2. The R2 value is extracted from the rules object,
using the function imputation.r2 and used to select a subset of rules:

> use <- imputation.r2(rules)>0.9
> hb <- hexbin(logP.obs[use], logP.imp[use], xbin=50)
> sp <- plot(hb)
> hexVP.abline(sp$plot.vp, 0, 1, col="black")

7

12312345logP.obslogP.imp154108162215268322376429482536590643696750804857CountsSimilarly, the function imputation.maf can be used to extract the minor allele frequen-
cies of the imputed SNP from the rules object. Note that there is a tendency for SNPs
with a high minor allele frequency to be imputed rather more successfully:

> hb <- hexbin(imputation.maf(rules), imputation.r2(rules), xbin=50)
> sp <- plot(hb)

8

1231234logP.obs[use]logP.imp[use]13976114151189226264302339377414452489527564602CountsThe function snp.rhs.glm also allows testing imputed SNPs. In its simplest form, it can
be used to calculate essentially the same tests as carried out with single.snp.tests3 (al-
though, being a more flexible function, this will run somewhat slower). The next commands
recalculate the 1 df tests for the imputed SNPs using snp.rhs.tests, and plot the results
against those obtained when values are observed.

> imp2 <- snp.rhs.tests(cc~strata(stratum), family="binomial",
+
> logP.imp2 <- -log10(p.value(imp2))

data=subject.support, snp.data=target, rules=rules)

3There is a small discrepancy, of the order of (N − 1) : N .

9

0.10.20.30.40.50.20.40.60.81imputation.maf(rules)imputation.r2(rules)171420263339455258647077838996102Counts> hb <- hexbin(logP.obs, logP.imp2, xbin=50)
> sp <- plot(hb)
> hexVP.abline(sp$plot.vp, 0, 1, col="black")

Storing imputed genotypes

In the previous two sections we have seen how to (a) generate imputation rules and, (b)
carry out tests on SNPs imputed according to these rules, but without storing the imputed
genotypes. It is also possible to store imputed SNPs in an object of class SnpMatrix (or

10

12312345logP.obslogP.imp2155108162216269323377430484538592645699753806860CountsXSnpMatrix). The posterior probabilities of assignment of each individual to the three
possible genotypes are stored within a one byte variable, although obviously not to full
accuracy.

The following command imputes the “missing” SNPs using the “target” dataset and stores

the imputed values in an object of class SnpMatrix:

> imputed <- impute.snps(rules, target, as.numeric=FALSE)

(If as.numeric were set to TRUE, the default, the resulting object would be a simple numeric
matrix containing posterior expectations of the 0, 1, 2 genotype.) A nice graphical description
of how snpStats stores uncertain genotypes is provided by the function plotUncertainty.
This plots the frequency of the stored posterior probabilities on an equilateral triangle. The
posterior probabilities are represented by the perpendicular distances from each side, the
vertices of the triangle corresponding to certain assignments. Thus, the SNP rs4880568 is
accurately imputed (R2 = 0.94)

> plotUncertainty(imputed[, "rs4880568"])

11

while rs2050968 is rather less so (R2 = 0.77

> plotUncertainty(imputed[, "rs2050968"])

12

AABBAB183178113451311115655288Tests can be carried out on these uncertainly assigned genotypes. For example

> imp3 <- single.snp.tests(cc, stratum, data=subject.support,
+
The uncertain=TRUE argument ensures that uncertaing genotypes are used in the compu-
tations. This should yield nearly the same result as before. For the first five SNPs we
have

snp.data=imputed, uncertain=TRUE)

> imp3[1:5]

rs7909677 800

9.471958e-05

N Chi.squared.1.df Chi.squared.2.df

P.2df
0.03034485 0.9922348 0.9849421

P.1df

13

AABBAB2011525699123211191141931159754.482735e-01
2.576718e-01
5.538651e-01
2.903316e-01

0.82152053 0.5031560 0.6631459
2.14963685 0.6117242 0.3413597
1.10745096 0.4567427 0.5748044
2.06593940 0.5900081 0.3559483

rs12773042 800
rs11253563 800
rs4881552
800
rs10904596 800

> imp[1:5]

N

N.r2 Chi.squared.1.df Chi.squared.2.df

rs7909677 800 467.7585
rs12773042 800 710.1390
rs11253563 800 763.1646
rs4881552 800 785.3856
rs10904596 800 780.0403

0.005853005
0.454221545
0.259047514
0.532619053
0.289076361

P.1df

P.2df
1.0622156 0.9390174 0.5879533
0.8011637 0.5003370 0.6699301
2.1320067 0.6107753 0.3443822
1.0595218 0.4655078 0.5887457
2.0606177 0.5908130 0.3568967

There are small discrepancies due to the genotype assignment probabilities not being stored
to full accuracy. However these should have little effect on power of the tests and no effect
on the type 1 error rate.

Note that the ability of snpStats to store imputed genotypes in this way allows al-
ternative programs to be used to generate the imputed genotypes. For example, the file
“mach1.out.mlprob.gz” (which is stored in the extdata sub-directory of the snpStats pack-
age) contains imputed SNPs generated by the MACH program, using the –mle and –mldetails
options. In the following commands, we find the full path to this file, read it, and inspect
one the imputed SNP in column 50:

> path <- system.file("extdata/mach1.out.mlprob.gz", package="snpStats")
> mach <- read.mach(path)

Reading MACH data from file /tmp/RtmpskZHlx/Rinst3357e07877db29/snpStats/extdata/mach1.out.mlprob.gz
Reading SnpMatrix with 500 rows and 178 columns

> plotUncertainty(mach[,50])

14

Meta-analysis

As stated at the beginning of this document, one of the main reasons that we need imputation
is to perform meta-analyses which bring together data from genome-wide studies which use
different platforms. The snpStats package includes a number of tools to facilitate this. All
the tests implemented in snpStats are “score” tests. In the 1 df case we calculate a score
defined by the first derivative of the log likelihood function with respect to the association
parameter of interest at the parameter value corresponding to the null hypothesis of no

15

AABBAB2670148671171211461273112111622310425102443101811362173association. Denote this by U . We also calculate an estimate of its variance, also under the
null hypothesis — V say. Then U 2/V provides the chi-squared test on 1 df. This procedure
extends easily to meta-analysis; given two independent studies of the same hypothesis, we
simply add together the two values of U and the two values of V , and then calculate U 2/V
as before. These ideas also extend naturally to tests of several parameters (2 or more df
tests).

In snpStats, the statistical testing functions can be called with the option score=TRUE,
causing an extended object to be saved. The extended object contains the U and V values,
thus allowing later combination of the evidence from different studies. We shall first see
what sort of object we have calculated previously using single.snp.tests without the
score=TRUE argument.
> class(imp)

[1] "SingleSnpTests"
attr(,"package")
[1] "snpStats"

This object contains the imputed SNP tests in our target set. However, these SNPs were
observed in our training set, so we can test them. We will also recalculate the imputed tests.
In both cases we will save the score information:

> obs <- single.snp.tests(cc, stratum, data=subject.support, snp.data=missing,
+
> imp <- single.snp.tests(cc, stratum, data=subject.support,
+

snp.data=target, rules=rules, score=TRUE)

score=TRUE)

The extended objects have been returned:

> class(obs)

[1] "SingleSnpTestsScore"
attr(,"package")
[1] "snpStats"

> class(imp)

[1] "SingleSnpTestsScore"
attr(,"package")
[1] "snpStats"

These extended objects behave in the same way as the original objects, so that the same
functions can be used to extract chi-squared values, p-values etc., but several additional
functions, or methods, are now available. Chief amongst these is pool, which combines
evidence across independent studies as described at the beginning of this section. Although
obs and imp are not from independent studies, so that the resulting test would not be valid,
we can use them to demonstrate this:

16

> both <- pool(obs, imp)
> class(both)

[1] "SingleSnpTests"
attr(,"package")
[1] "snpStats"

> both[1:5]

N

N.r2 Chi.squared.1.df Chi.squared.2.df

rs7909677 998 665.7585
rs12773042 996 906.1390
rs11253563 999 962.1646
rs4881552 999 984.3856
rs10904596 999 979.0403

0.47625614
0.04701095
1.59988114
0.29511622
1.68397258

P.1df

P.2df
2.7410000 0.4901230 0.2539799
0.0728592 0.8283486 0.9642260
1.9661983 0.2059201 0.3741497
0.3975982 0.5869604 0.8197146
2.0628564 0.1943974 0.3564974

Note that if we wished at some later stage to combine the results in both with a further
study, we would also need to specify score=TRUE in the call to pool:

> both <- pool(obs, imp, score=TRUE)
> class(both)

[1] "SingleSnpTestsScore"
attr(,"package")
[1] "snpStats"

Another reason to save the score statistics is that this allows us to investigate the di-
rection of findings. These can be extracted from the extended objects using the function
effect.sign. For example, this command tabulates the signs of the associations in obs:

> table(effect.sign(obs))

-1
7130

0

1
19 7102

In this table, -1 corresponds to tests in which effect sizes were negative (corresponding to
an odds ratio less than one), while +1 indicates positive effect sizes (odds ratio greater
than one). Zero sign indicates that the effect was NA (for example because the SNP was
monomorphic). Reversal of sign can be the explanation of a puzzling phenomenon when
two studies give significant results individually, but no significant association when pooled.
Although it is not impossible that such results are genuine, a more usual explanation is that
the two alleles have been coded differently in the two studies: allele 1 in the first study
is allele 2 in the second study and vice versa. To allow for this, snpStats provides the
switch.alleles function, which reverses the coding of specified SNPs. It can be applied
to SnpMatrix objects but, because allele switches are often discovered quite late on in the

17

analysis and recoding the original data matrices could have unforeseen consequences, the
switch.alleles function can also be applied to the extended test output objects. This
modifies the saved scores as if the allele coding had been switched in the original data. The
use of this is demonstrated below.

> effect.sign(obs)[1:6]

rs7909677 rs12773042 rs11253563
1

-1

1

rs4881552 rs10904596
-1

1

rs4880781
1

> sw.obs <- switch.alleles(obs, 1:3)
> class(sw.obs)

[1] "SingleSnpTestsScore"
attr(,"package")
[1] "snpStats"

> effect.sign(sw.obs)[1:6]

rs7909677 rs12773042 rs11253563
-1

-1

1

rs4881552 rs10904596
-1

1

rs4880781
1

18

