tweeDEseq: analysis of RNA-seq data using the
Poisson-Tweedie family of distributions

Mikel Esnaola1
mesnaola@creal.cat

Robert Castelo2,3
robert.castelo@upf.edu

Juan Ramón González1,2,3
juanr.gonzalez@isglobal.org

October 30, 2025

1Centre for Research in Environmental Epidemiology (CREAL), Barcelona, Spain

http://www.creal.cat/jrgonzalez/software.htm

2Dept. of Experimental and Health Sciences, Research Program on Biomedical Informatics (GRIB),

Universitat Pompeu Fabra, Barcelona, Spain

3Hospital del Mar Research Institute (IMIM), Barcelona, Spain

1 Getting started

This document gives an overview of the R package tweeDEseq, which provides statistical procedures
for testing differential expression in RNA-seq count data. In fact, these procedures could be applied, in
principle, to any kind of count data, other than RNA-seq. The tweeDEseq package offers a function for
normalizing count data which actually calls other functions for that purpose from the edgeR package.
For this reason, it is necessary to have installed the edgeR package as well, although it is not necessary to
explicitly load it onto the session. Another package necessary for running this vignette is the tweeDEse-
qCountData package which contains data to illustrate the analyses and which is employed in the article
introducing tweeDEseq by Esnaola et al. (2013). Therefore, we should start the R session with loading
these libraries as follows:

> library(tweeDEseq)
> library(tweeDEseqCountData)

We will start loading into the workspace the data corresponding to the initial table of raw counts of the
RNA-seq experiment from Pickrell et al. (2010) on lymphoblastoid cell lines derived from 69 unrelated
nigerian individuals as well as a vector of gender labels for each sample matching the sample order in the
table of counts:

> data(pickrell)
> countsNigerian <- exprs(pickrell.eset)
> dim(countsNigerian)

[1] 52580

69

> countsNigerian[1:5, 1:5]

1

ENSG00000000003
ENSG00000000005
ENSG00000000419
ENSG00000000457
ENSG00000000460

NA18486 NA18498 NA18499 NA18501 NA18502
0
0
67
72
15

0
0
40
107
10

0
0
105
100
23

0
0
22
22
5

0
0
55
53
18

> genderNigerian <- pData(pickrell.eset)[,"gender"]
> head(genderNigerian)

[1] male
Levels: female male

male

female male

female male

> table(genderNigerian)

genderNigerian
female
40

male
29

2 Normalization and filtering

We proceed to normalize this initial table of raw counts in order to try to remove any technical biases
that might be affecting the data. The tweeDEseq package relies for this purpose on part of the func-
tionality provided by the edgeR package (comprising RNA composition adjustment by TMM (Robinson
and Oshlack, 2010) and quantile-to-quantile count adjustment (Robinson et al., 2007) produced by the
equalizeLibSizes() from edgeR) and offers one function (normalizeCounts()) that makes the
appropriate calls to edgeR to normalize these data.

> countsNigerianNorm <- normalizeCounts(countsNigerian, genderNigerian)

> dim(countsNigerianNorm)

[1] 10231

69

If more control is needed in this step, the user should directly employ the corresponding edgeR functions.
Next, we can filter out genes with very low expression using the function filterCounts() whose
default parameters remove those genes with less than 5 counts per million in all samples but one.

> countsNigerianNorm <- filterCounts(countsNigerianNorm)
> dim(countsNigerianNorm)

[1] 10231

69

3 The Poisson-Tweedie family of distributions to model RNA-seq

count data

The package tweeDEseq uses the Poisson-Tweedie (PT) family of distributions as the statistical model
for count data. PT distributions have been studied by several authors(Hougaard et al., 1997; Gupta and
Ong, 2004; Puig and Valero, 2006; El-Shaarawi et al., 2011) and unify several count data distributions
(see Fig. 1 in El-Shaarawi et al., 2011) such as Poisson, negative binomial, Poisson-Inverse Gaussian,

2

Pólya-Aeppli or Neyman type A. These distributions can model different scenarios as, for instance, a
RNA-seq expression profile with a wide dynamic range leading to a heavy tail in the distribution.

Following El-Shaarawi et al. (2011), let Y ∼ PT(a, b, c) be a PT random variable with vector of

parameters θ = (a, b, c)T defined in the domain

Θ = (−∞, 1] × (0, +∞) × [0, 1) .

(1)

For the sake of interpretability, we reparametrize θ = (a, b, c) to θ = (µ, φ , a), where µ denotes the
mean, φ = σ 2/µ is the dispersion index (σ 2 is the variance), and a the shape parameter that is employed to
define some count data distributions that are particular cases of PT such as Poisson or Negative Binomial.
The relationship between both parameterizations is the following:

c =

φ − 1
φ − a

,

b =

µ(1 − a)(1−a)
(φ − 1)(d − a)−a .

(2)

Under this parametrization, the shape parameter determines the specific count data distribution being
employed. For instance a = 1 corresponds to Poisson and a = 0 corresponds to negative binomial. We can
estimate the parameter vector θ by maximum likelihood through the function mlePoissonTweedie()
as follows:

> set.seed(123)
> y <- rnbinom(1000, mu=8, size=1/0.2)
> thetahat <- mlePoissonTweedie(y)
> getParam(thetahat)

a
8.0680000 2.6620193 0.0405573

mu

D

where here we have simulated 1000 random observations from a negative binomial distribution and the
last call to getParam() allows us to extract the ˆθ vector from the object return by mlePoissonTweedie().

4 Goodness of fit to a count data distribution

The PT distribution allows one to test for the goodness of fit to a particular count data distribution defined
by a specific value of the PT shape parameter a. For this purpose, the function testShapePT() allows us
to test the goodness of fit to, for instance, the widely used negative binomial distribution (i.e., H0 : a = 0)
as illustrated here with the previously estimated vector ˆθ :

> testShapePT(thetahat, a=0)

$statistic
[1] 0.01471032

$pvalue
[1] 0.9034644

These functions are called from another one called gofTest() which can perform for us a goodness-of-
fit for every gene in the rows of a given matrix of counts, and will return the corresponding χ 2
1 statistics.
Since calculating this for the entire gene set would take too long for building quickly this vignette we are
going to work on a subset of genes formed by human genes with documented sex-specific expression,
a sampled subset of 25 human housekeeping genes and the secretin (SCT) gene which encodes for an

3

endocrine hormone peptide in chromosome 11 that controls secretions in the duodenum. The gender-
related and housekeeping gene lists form part from the previously loaded experimental data package
tweeDEseqCountData and can be loaded as follows:

> data(genderGenes)
> data(hkGenes)
> length(XiEgenes)

[1] 63

> length(msYgenes)

[1] 32

> length(hkGenes)

[1] 669

The list of genes with documented sex-specific expression was built by first selecting genes in chromo-
some X that escape X-inactivation (Carrel and Willard, 2005) and genes in the male-specific region of
the Y chrosomome (Skaletsky et al., 2003), and then filtering out those that do not occur in the initial
table of counts with 52580 Ensembl genes. The list of housekeeping genes was retrieved from the liter-
ature(Eisenberg and Levanon, 2003) and then also filtered to keep only those genes that form part of the
initial table of counts. The selection is finally done as follows:

> set.seed(123)
> someHKgenes <- sample(hkGenes, size=25)
> geneSubset <- unique(c("ENSG00000070031",
+
+
> length(geneSubset)

intersect(rownames(countsNigerianNorm),

c(someHKgenes, msYgenes, XiEgenes))))

[1] 41

Now, we calculate the goodness of fit to a negative binomial distribution for each of these 41 genes using
the function gofTest():

> chi2gof <- gofTest(countsNigerianNorm[geneSubset, ], a=0)

and we can examine the result by means of the quantile-quantile plots produced with the function qqchisq()
and shown in Figure 1, which indicates that more than a 50% of the genes show a substantial discrepancy
with the respect to the negative binomial distribution.

> par(mfrow=c(1,2), mar=c(4, 5, 3, 4))
> qq <- qqchisq(chi2gof, main="Chi2 Q-Q Plot", ylim = c(0, 60))
> qq <- qqchisq(chi2gof, normal=TRUE, ylim = c(-5, 7))

This indicates that different genes may require different count data distributions but, in fact, this can
be also observed for different sample groups within the same gene. Figure 2 illustrates such a case with
the secretin (SCT) gene (Ensembl ID ENSG00000070031) when looking separately to male and female
samples. This figure is produced with the following code that calls the function compareCountDist()
which helps in comparing an empirical distribution of counts against the Poisson, the negative binomial
and the corresponding estimated PT distribution.

4

Figure 1. Goodness of fit to a binomial distribution. On the left a quantile-quantile plot of the
χ 2 statistic employed to assess the goodness-of-fit of the RNA-seq data to a negative bino-
mial distribution is shown. More than a 50% of the genes have expression profiles that depart
substantially from the negative binomial distribution. On the right we have the same data but
χ 2 statistics are transformed into standard normal z-scores to improve visibility of the lower
quantiles.

> par(mfrow=c(1,2), mar=c(4, 5, 3, 2))
> xf <- unlist(countsNigerianNorm["ENSG00000070031", genderNigerian=="female"])
> compareCountDist(xf, main="Female samples")
> xm <- unlist(countsNigerianNorm["ENSG00000070031", genderNigerian=="male"])
> compareCountDist(xm, main="Male samples")

What Figure 2 reflects can be also easily seen by just looking to the actual counts and identifying the

female sample that produces the heavy tail on the distribution

> sort(xf)

2

2

2

1

3

NA19137 NA18855 NA19127 NA19159 NA19225 NA19257 NA18508 NA18511 NA18858 NA18912
3
NA19102 NA19114 NA19116 NA18505 NA18909 NA19099 NA19140 NA19222 NA18517 NA18520
5
NA19131 NA19143 NA18523 NA18861 NA18870 NA19108 NA19152 NA19201 NA18499 NA19093
9
NA19147 NA18852 NA19209 NA18502 NA19238 NA19190 NA19204 NA18916 NA19172 NA19193
196

37

11

12

17

21

11

12

16

3

5

8

6

3

3

5

5

9

4

4

4

4

3

2

3

4

2

6

6

6

6

6

> sort(xm)

5

01234560102030405060Chi2 Q−Q PlotExpected c2Observed c250%75%95%−2−1012−4−20246Normal Q−Q PlotExpected ZObserved Z50%75%95%Figure 2. Empirical cumulative distribution function (CDF) of counts (black dots), calculated
separately from male and female samples, for the secretin gene (SCT) and estimated CDF
(solid lines) of Poisson-Tweedie distributions with shape parameter fixed to a = 1 corresponding
to a Poisson (green), a = 0 corresponding to a negative binomial (blue) and with the value of
a estimated from data too (red). The legend shows the values of the a parameter and the P
value of the likelihood ratio test on whether the expression profile follows a negative binomial
distribution (H0 : a = 0). We can observe that for both, male and female samples, the Poisson
distribution is not adequate and that the negative binomial distribution is not adequate for female
samples.

1

1

NA18507 NA19128 NA19138 NA19160 NA19210 NA18510 NA19192 NA18498 NA18519 NA18522
3
NA18856 NA18862 NA18871 NA19239 NA18486 NA18853 NA18913 NA19153 NA19171 NA19098
6

4
NA18516 NA19101 NA18501 NA19130 NA18504 NA19200 NA19203 NA19119 NA19144
30

11

18

15

3

7

3

8

1

3

3

7

4

4

2

9

1

8

4

4

2

3

1

3

and realize that by just removing that sample, the large overexpression in females just vanishes:

> xf[which.max(xf)]

NA19193
196

> 2^{log2(mean(xf))-log2(mean(xm))}

[1] 2.003402

6

0501001502000.00.20.40.60.81.0Female samplesCountsFn(x)P= 3e−10 (H0: a=0)PT(D, m, 0.84)PT(D, m, 0) − NBPT(D, m, 1) − Poisson0510152025300.00.20.40.60.81.0Male samplesCountsFn(x)P= 0.02 (H0: a=0)PT(D, m, 0.76)PT(D, m, 0) − NBPT(D, m, 1) − Poisson> 2^{log2(mean(xf[-which.max(xf)])) - log2(mean(xm))}

[1] 1.192384

This illustrates a case in which Poisson and negative binomial distributions may be too restrictive to
account for the biological variability that extensively-replicated RNA-seq experiments can reveal in count
data.

5 Testing for differential expression

In order to illustrate the accuracy of tweeDEseq for detecting DE genes in a extensively-replicated
RNA-seq experiment we have compared the expression profiles between males and females from the
population of 69 unrelated Nigerian individuals(Pickrell et al., 2010).

The tweeDEseq package contains a function to test for differential expression between two different
conditions using a score based test: the tweeDE() function. This function takes as input a matrix of
counts with genes on the rows and samples on the columns.

An important feature of the tweeDE() function is that it allows to use multiple processors in the
computing process. This is done by loading first the multicore package and specifying the number of
cores to be used with the mc.cores argument in the call to tweeDE().

> resPT <- tweeDE(countsNigerianNorm[geneSubset, ], group = genderNigerian)

The function tweeDE() returns a data.frame object of class tweeDE which can be examined with the
print():

> print(resPT)

Comparison of groups: male - female
Showing top 6 genes ranked by P-value
Minimum absolute log2 fold-change of 0
Maximum adjusted P-value of 1

ENSG00000129824
ENSG00000154620
ENSG00000099749
ENSG00000198692
ENSG00000157828
ENSG00000006757

overallMean female

log2fc

male
pval
stat
3.275 440.276
7.070769 16.028735 8.050548e-58
34.172
2.900
3.558707 11.319513 1.050535e-29
69.966
3.550
4.300753 10.664342 1.494538e-26
9.717809 2.531693e-22
38.931
3.775
3.366372
7.968633 1.604387e-15
3.026291
15.276
1.875
6.820705 9.059494e-12
91.310 -1.103291
152.101 196.175

186.942
16.043
31.464
18.551
7.507

pval.adjust
ENSG00000129824 3.300724e-56
ENSG00000154620 2.153598e-28
ENSG00000099749 2.042535e-25
ENSG00000198692 2.594986e-21
ENSG00000157828 1.315597e-14
ENSG00000006757 6.190654e-11

which will show us by default the top 6 genes ranked by P-value including information on the magnitude
of the fold-change in log2 scale (log2fc), overall mean expression in counts (overallMean), mean
expression in counts for each sample group, raw P-value (pval) and the Benjamini-Hochberg (FDR)
adjusted P-value (pval.adjust).

7

The same print() function allows us to call differentially expressed a subset of gene meeting cutoffs
on the minimum magnitude of the fold-change and maximum FDR and store that subset in a data.frame
object by using the appropriate arguments as follows:

> deGenes <- print(resPT, n=Inf, log2fc=log2(1.5), pval.adjust=0.05, print=FALSE)
> dim(deGenes)

[1] 9 7

We can further enrich the output with information like the symbol and description of the gene by using the
annotation information stored as a data.frame in the experimental data package tweeDEseqCountData
as follows:

> data(annotEnsembl63)
> head(annotEnsembl63)

ENSG00000252775
ENSG00000207459
ENSG00000252899
ENSG00000201298
ENSG00000222266
ENSG00000222924

Start

Symbol Chr
U7
U6
U7
U6
U6
U6

5 133913821 133913880
5 133970529 133970635
5 133997420 133997479
5 134036862 134036968
5 134051173 134051272
5 137405044 137405147

End EntrezID
<NA>
<NA>
<NA>
<NA>
<NA>
<NA>

ENSG00000252775 U7 small nuclear RNA
ENSG00000207459 U6 spliceosomal RNA
ENSG00000252899 U7 small nuclear RNA
ENSG00000201298 U6 spliceosomal RNA
ENSG00000222266 U6 spliceosomal RNA
ENSG00000222924 U6 spliceosomal RNA

[Source:RFAM;Acc:RF00066]
[Source:RFAM;Acc:RF00026]
[Source:RFAM;Acc:RF00066]
[Source:RFAM;Acc:RF00026]
[Source:RFAM;Acc:RF00026]
[Source:RFAM;Acc:RF00026]

Description Length
NA
NA
NA
NA
NA
NA

ENSG00000252775
ENSG00000207459
ENSG00000252899
ENSG00000201298
ENSG00000222266
ENSG00000222924

GCcontent
NA
NA
NA
NA
NA
NA

> deGenes <- merge(deGenes, annotEnsembl63, by="row.names", sort=FALSE)

and select certain columns to build Table 1 using the xtable package (code not shown but available in the
source of the vignette).

6 Visualizing the results

An informative way to visualize the results of a differential expression analysis is by means of MA and
Volcano plots, which we can easily obtain through the tweeDEseq package functions MAPlot() and
Vplot(), respectively as follows. Their result is shown in Figure 3.

> deGenes <- rownames(print(resPT, n=Inf, log2fc=log2(1.5), pval.adjust=0.05, print=FALSE))
> length(deGenes)

8

Table 1. Differentially expressed genes between female and male Nigerian individuals found by
tweeDEseq.

Symbol
RPS4Y1
TMSB4Y
CYorf15A
EIF1AY

Chr
Y
Y
Y
Y

log2fc
7.07
3.56
4.30
3.37

pval.adjust Description
3.30E-56
2.15E-28
2.04E-25
2.59E-21

RPS4Y2
PNPLA4
STS
HDHD1

UTY

Y
X
X
X

Y

3.03
-1.10
-0.99
-0.77

1.32E-14
6.19E-11
1.15E-04
4.35E-04

0.63

4.60E-02

[1] 9

ribosomal protein S4, Y-linked 1
thymosin beta 4, Y-linked
chromosome Y open reading frame 15A
eukaryotic translation initiation factor 1A, Y-
linked
ribosomal protein S4, Y-linked 2
patatin-like phospholipase domain containing 4
steroid sulfatase (microsomal), isozyme S
haloacid dehalogenase-like hydrolase domain
containing 1
ubiquitously transcribed tetratricopeptide repeat
gene, Y-linked

list(genes=XiEgenes, pch=21, col="skyblue", bg="skyblue", cex=0.7),
list(genes=deGenes, pch=1, col="red", lwd=2, cex=1.5)

> hl <- list(list(genes=msYgenes, pch=21, col="blue", bg="blue", cex=0.7),
+
+
+
> par(mfrow=c(1,2), mar=c(4, 5, 3, 2))
> MAplot(resPT, cex=0.7, log2fc.cutoff=log2(1.5), highlight=hl, main="MA-plot")
> Vplot(resPT, cex=0.7, highlight=hl, log2fc.cutoff=log2(1.5),
pval.adjust.cutoff=0.05, main="Volcano plot")
+

)

7 Assessing differential expression calling accuracy

Finally, the accuracy of the differential expression analysis illustrated here can be assessed by comparing
our list of differentially expressed genes with the list of genes with documented sex-specific expression
by means of a Fisher’s exact test.

> genderGenes <- c(msYgenes[msYgenes %in% rownames(resPT)],
+
XiEgenes[XiEgenes %in% rownames(resPT)])
> N <- nrow(resPT)
> m <- length(genderGenes)
> n <- length(deGenes)
> k <- length(intersect(deGenes, genderGenes))
> t <- array(c(k,n-k,m-k,N+k-n-m), dim=c(2,2), dimnames=list(SEX=c("in","out"),DE=c("yes","no")))
> t

DE

SEX

in
out

yes no
9 18
0 14

> fisher.test(t, alternative="greater")

9

Figure 3. Differential expression analysis for a subset of genes between male and female
lymphoblastoid cell lines. On the left a MA-plot shows the magnitude of the fold-change of every
gene as function of its average normalized expression level. No expression-level dependent
biases can be observed in the data. On the right a volcano plot shows the raw P value of every
gene for the null hypothesis of no differential expression, calculated by tweeDEseq, as function
of its fold-change. In both plots, red circles indicate differentially expressed genes defined by
the cutoffs depicted with horizontal and vertical dashed lines. Light blue dots denote genes from
the male-specific region (Skaletsky et al., 2003) of chromosome Y (MSY) and dark blue dots
denote genes from Xi that escape chromosome inactivation (XiE) in female samples (Carrel and
Willard, 2005).

Fisher's Exact Test for Count Data

data: t
p-value = 0.01338
alternative hypothesis: true odds ratio is greater than 1
95 percent confidence interval:

1.632421

Inf

sample estimates:
odds ratio
Inf

10

246810120246MA−plotAM024601020304050Volcano plotM-log10 Raw P−value5% FDR8 Fitting generalized linear models (GLM)

The tweeDEseq package also allows to fit generalized linear models for a response variable following
the Poisson-Tweedie family of distributions and several covariates. This can be done using the glmPT()
function. For instance, we can fit a model taking the secretin (SCT) gene as response and gender as
covariate:

> mod <- glmPT(countsNigerianNorm["ENSG00000070031",] ~ genderNigerian)
> mod

Call: glmPT(formula = countsNigerianNorm["ENSG00000070031", ] ~ genderNigerian)

Coefficients:

(Intercept) genderNigerianmale
-0.2412

2.2544

Poisson-Tweedie parameters:

c

0.997

a
0.8253

> summary(mod)

Call:
glmPT(formula = countsNigerianNorm["ENSG00000070031", ] ~ genderNigerian)

Coefficients:

Estimate Std.Error t value Pr(>|t|)

(Intercept)
2.2544
genderNigerianmale -0.2412
---
Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

0.1918 11.7553
0.1622 -1.4874

< 2e-16 ***
0.93154

Poisson-Tweedie parameters

Estimate Std.Error
0.0019
0.0427

0.997
0.8253

c
a

The resulting model can also be used to test differential expression. This can be done using the

anova() method, which tests whether the model is significantly better than the null one.

> anova(mod)

[1] 0.1435284

The tweeDEglm() allows testing several genes at the same time. This function also allows using
multiple processors in the computing process. Following with the example in section 5, we apply it to the
same subset of genes and use the gender as covariate:

> resPTglm <- tweeDEglm( ~ genderNigerian, counts = countsNigerianNorm[geneSubset,])

tweeDEglm() returns a data.frame with the AIC (Akaike Information Criterion) for the fitted
and null models as well as the original and adjusted p-values resulting from the test between both models.
In order to visualize the top significant genes we run the following command.

11

> head(resPTglm[sort(resPTglm$pval.adjust, index.return = TRUE)$ix,])

AICfull AICnull

pval.adjust
ENSG00000129824 553.0737 759.2850 3.373765e-47 1.383244e-45
ENSG00000198692 412.7887 537.5054 2.142771e-29 4.392681e-28
ENSG00000154620 402.8749 518.1261 2.529103e-27 3.456440e-26
ENSG00000099749 481.4012 591.2299 3.895576e-26 3.992965e-25
ENSG00000157828 358.1338 421.8267 5.269581e-16 4.321056e-15
ENSG00000006757 764.8961 801.0417 6.565935e-10 4.486722e-09

pval

If we compare these results with those obtained by the tweeDE() function we observe that both
methods place the same genes at the top of the most significant list. This is not surprising as, though
the statistical tests are not identical, the underlying distributional assumptions are the same.
In fact,
tweeDEglm() detects all the genes captured by tweeDE().

8.1

Incorporating CQN offsets

Package cqn (Hansen et al. (2012), available at Bioconductor) performs conditional quantile normaliza-
tion in order to remove possibly existing bias arising from differences in GC content or gene lengths.
The method returns a series of offsets which can be incorporated into tweeDEseq via the tweeDEglm or
glmPT function.

For instance, suppose the result of the cqn normalization is stored in an object called cqn.subset1.
The normalizing offsets are stored as a matrix at cqn.subset$offset. They can be incorporated into
the model using the ’offset’ argument.

> tweeDEglm(~ genderNigerian, counts = countsNigerianNorm[geneSubset,],
+

offset = cqn.subset$offset)

9 Session info

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

1For more information about how to normalize RNA-seq count data using the cqn package, please refer to the package vignette

available at http://www.bioconductor.org/packages/release/bioc/html/cqn.html

12

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] xtable_1.8-4
[3] Biobase_2.70.0
[5] generics_0.1.4

tweeDEseqCountData_1.47.0
BiocGenerics_0.56.0
tweeDEseq_1.56.0

loaded via a namespace (and not attached):

[1] Matrix_1.7-4
[5] limma_3.66.0
[9] statmod_1.5.1
[13] SparseM_1.84-2
[17] cqn_1.56.0

lattice_0.22-7
mclust_6.1.1
compiler_4.5.1
survival_3.8-3
edgeR_4.8.0

nor1mix_1.3-3
parallel_4.5.1
quantreg_6.1
Rcpp_1.1.0
MASS_7.3-65

splines_4.5.1
grid_4.5.1
tools_4.5.1
locfit_1.5-9.12
MatrixModels_0.5-4

References

Carrel, L. and Willard, H. (2005). X-inactivation profile reveals extensive variability in X-linked gene

expression in females. Nature, 434:400–404.

Eisenberg, E. and Levanon, E. Y. (2003). Human housekeeping genes are compact. Trends Genet,

19(7):362–5.

El-Shaarawi, A., Zhu, R., and Joe, H. (2011). Modelling species abundance using the Poisson-Tweedie

family. Environmetrics, 22:152–164.

Esnaola, M., Puig, P., Gonzalez, D., Castelo, R., and Gonzalez, J. R. (2013). A flexible count data model
to fit the wide diversity of expression profiles arising from extensively replicated rna-seq experiments.
BMC Bioinformatics, 14:254.

Gupta, R. and Ong, S. (2004). A new generalization of the negative binomial distribution. Compu Stat

Data An, 45:287–300.

Hansen, K. D., Irizarry, R. A., and Wu, Z. (2012). Removing technical variability in rna-seq data using

conditional quantile normalization. Biostatistics.

Hougaard, P., Lee, M.-L., and Whitmore, G. (1997). Analysis of overdispersed count data by mixtures of

Poisson variables and Poisson processes. Biometrics, 53:1225–1238.

Pickrell, J., Marioni, J., Pai, A., Degner, J., Engelhardt, B., Nkadori, E., Veyrieras, J., Stephens, M., Gilad,
Y., and Pritchard, J. (2010). Understanding mechanisms underlying human gene expression variation
with RNA sequencing. Nature, 464:768–772.

Puig, P. and Valero, J. (2006). Count data distributions: Some characterizations with applications. J Am

Stat Assoc, 101:332–340.

Robinson, M. and Oshlack, A. (2010). A scaling normalization method for differential expression analysis

of RNA-seq data. Genome Biol, page 11:R25.

13

Robinson, M. D., Smyth, G. K., and Rocke, P. D. (2007). Moderated statistical tests for assessing differ-

ences in tag abundance.

Skaletsky, H., Kuroda-Kawaguchi, T., Minx, P., Cordum, H., Hillier, L., Brown, L., Repping, S., Pyn-
tikova, T., Ali, J., Bieri, T., Chinwalla, A., Delehaunty, A., Delehaunty, K., Du, H., Fewell, G., Fulton,
L., Fulton, R., Graves, T., Hou, S.-F., Latrielle, P., Leonard, S., Mardis, E., Maupin, R., McPherson,
J., Miner, T., Nash, W., Nguyen, C., Ozersky, P., Pepin, K., Rock, S., Rohlfing, T., Scott, K., Schultz,
B., Strong, C., Tin-Wollam, A., Yang, S.-P., Waterston, R., Wilson, R., Rozen, S., and Page, D. (2003).
The male-specific region of the human y chromosome is a mosic of discrete sequence classes. Nature,
423:825–837.

14

