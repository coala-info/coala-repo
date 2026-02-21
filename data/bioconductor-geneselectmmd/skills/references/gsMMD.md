Gene Selection Using GeneSelectMMD

Jarrett Morrow
remdj@channing.harvard.edu,
Weilianq Qiu
Weiliang.Qiu@gmail.com,
Wenqing He
whe@stats.uwo.ca,
Xiaogang Wang
stevenw@mathstat.yorku.ca,
Ross Lazarus
ross.lazarus@gmail.com,

October 30, 2025

1

Introduction

This document demonstrates how to use the GeneSelectMMD package to detect significant genes and to
estimate false discovery rate (FDR), false non-discovery rate (FNDR), false positive rate (FPR), and false
negative rate (FNR), for a real microarray data set based on the method proposed by Qiu et al. (2008). It
also illustrates how to visualize the fit of the model proposed in Qiu et al. (2008) to the real microarray data
set when the marginal correlations among subjects are zero or close to zero.

The GeneSelectMMD package is suitable for the case where there are only two tissue types and for the
case where tissue samples within a tissue type are conditionally independent given the gene (c.f. Qiu et al.,
2008).

Note that starting from version 1.7.1, we reparameterize the model parameters. The input and output
are the same as the previous versions. To improve speed, we use numerical optimization, instead of iteration
based on explicit formula, to obtain parameter estimates. Since verions 2.0.7, the speed has also been
improved by using Fortran 77 code for some of the less efficient operations. Lastly, in version 2.0.8 onward,
the likelihood values provided to the user are based on the observed data, while in previous versions the
likelihood was an expected value.

2 Methods

MMD assumes that the marginal distribution of a gene profile is a mixture of 3-component multivariate
normal distributions with special structure for mean vectors and covariance matrices. The 3 component
distributions correspond to 3 gene clusters: (1) cluster of genes over-expressed in the case group; (2) cluster
of genes non-differentially expressed; and (3) cluster of genes under-expressed in the case group. Specifically,
the marginal density of a gene profile is assumed to be

f (x|θ1, θ2, θ3) = π1f1(x|θ1) + π2f2(x|θ2) + π3f3(x|θ3),
π1 + π2 + π3 = 1, πi > 0, i = 1, 2, 3,

(1)

where π1, π2, π3 are mixture proportions. The m × 1 vector x is a realization of the random vector X that
represents the transformed gene profile for a randomly selected gene over m tissue samples (m = mc + mn,

1

where mc is the number of case tissue samples and mn control tissue samples); θk, is the parameter set for
the k-th component distribution fk, k = 1, 2, 3; and f1, f2, and f3 are the density functions for multivariate
Normal distributions with the mean vectors

µ1 =

(cid:19)

(cid:18) µc11mc
µn11mn

, µ2 = µ21m, µ3 =

(cid:18) µc31mc
µn31mn

(cid:19)

.

and covariance matrices

Σ1 =

(cid:18) σ2
c1

Rc1
0

(cid:19)

0
Rn1

σ2
n1

, Σ2 = σ2

2R2, Σ3 =

(cid:18) σ2
c3

Rc3
0

0
Rn3

σ2
n3

(cid:19)

,

respectively, where correlation matrix

Rt = (1 − ρt)

(cid:20)
I nt +

ρt
(1 − ρt)

(cid:21)

,

1nt1T
nt

(2)

(3)

(4)

t = c1, n1, 2, c3, or n3. nt = mc if t = c1 or c3; nt = m if t = 2; nt = mn if t = n1, or n3. Here we assume,
without loss of generality, that the first mc elements of the random vector X are for the case tissue samples
and the remaining mn elements are for the control tissue samples. Let θ1 = (µc1, σ2
, ρn1)T ,
c1
for component 1 in which genes
θ2 = (µ2, σ2
are over-expressed in case tissue samples, and µc3 < µn3
for component 3 where genes are under-expressed
in case samples. Our prior belief is that the majority of genes are usually non-differentially expressed, so we
assume π2 > π1 and π2 > π3.

, ρn3)T . Note that µc1 > µn1

2, ρ2)T , θ3 = (µc3 , σ2
c3

, ρc3, µn3, σ2
n3

, ρc1, µn1, σ2
n1

The model parameters can be estimated using the EM algorithm (Dempster et al., 1977).
The cluster membership of a gene is determined by the posterior probability that the gene belongs to a
cluster given its gene profile. The posterior probability is a function of the 3 component marginal density
functions and the mixing proportions:

P r(gene i ∈ cluster k|xi) =

πkfk(xi|θk)
π1f1(xi|θ1) + π2f2(xi|θ2) + π3f3(xi|θ3)

,

(5)

k =1, 2, 3,

Specifically, a gene is assigned to the a gene cluster if the posterior probability that the gene belongs to that
gene cluster given its gene profile is larger than the posterior probability that the gene belongs to other gene
clusters given its gene profile:

k0 = arg max
k=1,2,3

P r(gene i ∈ cluster k|xi).

(6)

An important task is to assess the performance of a gene selection method so that different methods
can be objectively compared. To evaluate the performance of a gene selection method, investigators usually
compare the error rates, such as FDR, FNDR, FPR, and FNR, via simulation studies. However, when
analyzing a real microarray data set, investigators are more interested in what the values of FDR, FNDR,
FPR, and FNR are for this specific real microarray set. It is challenging to estimate FDR, FNDR, FPR,
and FNR for real microarray data sets since the true gene cluster membership is unknown for real data sets.
However, model-based gene clustering methods, such as Bayesian hierarchical models and MMD, can provide
such estimates since these error rates can be expressed as functions of marginal density functions and mixing
proportions, where the model parameters and mixing proportions can be estimated from the real microarray
data. It is easy to use MMD to estimate the four error rates since MMD describes the distributions of gene
expression levels directly via the marginal distributions, while it is usually difficult to derive the marginal
density functions for Bayesian hierarchical models.

It is of practical importance to evaluate if a model fits a real microarray data set well. If a model does
not fit well for the real microarray data set, then it makes no sense to estimate the error rates based on
the model. Although it is quite challenging to asses the goodness of fit for multivariate data, especially

2

for non-normal multivariate data, it is possible to do so for some special cases. For example, when tissue
samples are marginally independent, we could pool the gene expression levels across tissue samples for each
type of tissue samples since they are all independent. We then could impose the theoretical density curve
on the histogram of the pooled expression levels for each type of tissue samples. The parameters ρc1, ρn1,
ρ2, ρc3, and ρn3 indicates the marginal correlations among tissue samples. Assuming that the marginal
correlations are ignorable, we then could produce such a plot to evaluate the goodness of fit of MMD to the
real microarray data set.

3 Reparametrization

To guarantee the constraints µc1 > µn1
parameterize the model parameters:

and µc3 < µn3

in the iteration of the EM algorithm, we re-

To make sure the marginal covariance matrices are positive definite, we set the constraints:

µn1 =µc1 − exp(△n1),
µn3 =µc3 + exp(△n3).

−

−

−

1
nc − 1
1
nn − 1
1
n − 1
1
nc − 1
1
nn − 1

−

−

<ρc1 < 1

<ρn1 < 1

<ρ2 < 1

<ρc3 < 1

<ρn3 < 1

To make sure the above inequalities hold, we reparametrize ρs as follows:

ρc1 =

ρn1 =

ρ2 =

ρc3 =

ρn3 =

exp(rc1) − 1/(nc − 1)
1 + exp(rc1)
exp(rn1) − 1/(nn − 1)
1 + exp(rn1 )
exp(r2) − 1/(n − 1)
1 + exp(r2)
exp(rc3) − 1/(nc − 3)
1 + exp(rc3)
exp(rn3) − 1/(nn − 3)
1 + exp(rn3 )

.

0 <πk < 1,
π3 =1 − π1 − π2.

k = 1, 2, 3,

Another set of constraints are:

Then the reparametrized MMD model is

f (x) = π1f1(x|θ1) + π2f2(x|θ2) + (1 − π1 − π2)f3(x|θ3),

where

, rc1 , △n1, σ2
n1

θ1 =(µc1, σ2
c1
2, r2)T ,
θ2 =(µ2, σ2
θ3 =(µc3 , σ2
c3

, rc3 , △n3, σ2
n3

, rn1)T ,

, rn3)T ,

3

(7)

(8)

and f1, f2, and f3 are the density functions for multivariate normal distributions with mean vectors

(cid:18)

µ1 =

µc11nc
[µc1 − exp(△n1)] 1nn

(cid:19)

, µ2 = µ21n, µ3 =

(cid:18)

µc31nc
[µc3 + exp(△n3 )] 1nn

(cid:19)

and covariance matrices

(cid:32) σ2
c1

Σ1 =

nc

(nc−1)(1+exp(rc1 )) R0,c1
0

Σ2 =σ2
2

n
(n − 1)(1 + exp(r2))

R0,2,

(cid:32) σ2
c3

Σ3 =

nc

(nc−1)(1+exp(rc3 )) R0,c3
0

σ2
n1

σ2
n3

0
nn

(nn−1)(1+exp(rn1 )) R0,n1

0
nn

(nn−1)(1+exp(rn3 )) R0,n3

(cid:33)

(cid:33)

,

.

The matrices R0,c1

, R0,n1

, R0,2, R0,c3

, and R0,n3

are defined as below:

R0,c1 =I nc +

R0,n1 =I nn +

(nc − 1) exp(rc1) − 1
nc1
(nn − 1) exp(rn1) − 1
nn1

1nc1T
nc

,

1nn 1T
nn

,

R0,2 =I n +

(n − 1) exp(r2) − 1
n2

1n1T
n ,

(9)

(10)

(11)

R0,c3 =I nc +

R0,n3 =I nn +

(nc − 1) exp(rc3 ) − 1
nc3
(nn − 1) exp(rn3) − 1
nn3

1nc1T
nc

,

1nn 1T
nn

.

4 Gene selection via GeneSelectMMD

The GeneSelectMMD includes four functions for gene selection: gsMMD, gsMMD.default, gsMMD2, and gsMMD2.default.

The functions gsMMD and gsMMD2 accept the object derived from the class of Bioconductor ’s ExpressionSet

as data input, while the functions gsMMD.default and gsMMD2.default accept data matrix as data input.
The functions gsMMD and gsMMD.default will provide initial 3-cluster gene partitions (cluster of genes
over-expressed in case group, cluster of genes non-differentially expressed, and cluster of genes under-
expressed in case group) based on the gene-wise two-sample t-test or two-sample Wilcoxon rank-sum test.
In situations where the user would like to provide the initial 3-cluster partition other than that pro-
vided by the gene-wise two-sample t-test or two sample Wilcoxon rank-sum test, the functions gsMMD2
and gsMMD2.default could be used.

The rows of the input data matrix (or the data matrix derived from the object derived from the class
ExpressionSet) are genes, while the columns are tissue samples. The tissue type of a tissue sample is
indicated by the argument memSubjects, which is a m × 1 vector, m = mc + mn, mc is the number of tissue
samples in the case group, and mn is the number of tissue samples in the control group. memSubjects[j]=1
indicates the j-th tissue sample is from the case group. memSubjects[j]=0 indicates the j-th tissue sample
is from the control group.

The output of gene selection functions include dat, memGenes, memGenes2, and para.

• dat is a data matrix with the same dimensions as the input data matrix. If no data transformation is
performed, dat is the same as the input data matrix. Otherwise, it will be the transformed input data
matrix.

4

• memGenes is a G × 1 vector indicating the gene cluster membership, where G is the number of genes
(i.e., the number of rows of the input data matrix). memGenes[g]=1 indicates the g-th gene is assigned
to the cluster of genes over-expressed in case group; memGenes[g]=2 indicates the g-th gene is assigned
to the cluster of genes non-differentially-expressed; memGenes[g]=3 indicates the g-th gene is assigned
to the cluster of genes under-expressed in case group.

• memGenes2 is a variant of memGenes. memGenes2[g]=1 means the g-th gene is differentially expressed,

while memGenes2[g]=0 means the g-th gene is non-differentially expressed, g = 1, . . . , G.

, ρn1, µ2, σ2
2

, ρ2, µc3, σ2
c3

, ρc1, µn1, σ2
n1

, ρc3, µn3,
• para is a 18×1 vector of parameters (π1, π2, π3, µc1, σ2
c1
, ρn3, ) for the model described in Equations (1)- (4), which can be estimated by the EM algorithm.
σ2
n3
para[1], para[2], and para[3] are the cluster proportions for the 3 gene clusters (over-expressed, non-
differentially expressed, and under-expressed). para[4], para[5], and para[6] are the marginal mean,
variance, and correlation of gene expression levels of cluster 1 (over-expressed genes) for case subjects;
para[7], para[8], and para[9] are the marginal mean, variance, and correlation of gene expression
levels of cluster 1 (over-expressed genes) for control subjects; para[10], para[11], and para[12] are
the marginal mean, variance, and correlation of gene expression levels of cluster 2 (non-differentially
expressed genes); para[13], para[14], and para[15] are the marginal mean, variance, and correlation
of gene expression levels of cluster 3 (under-expressed genes) for case subjects; para[16], para[17],
and para[18] are the marginal mean, variance, and correlation of gene expression levels of cluster 3
(under-expressed genes) for control subjects.

Note that genes in cluster 2 are non-differentially expressed across case and control tissue samples.
Hence there are only 3 parameters for cluster 2.

For example, to obtain differentially expressed genes for the ALL data (Chiaretti et al., 2004), we can

run either

>
>
>
>
>
>
>
>
>
>
+

library(GeneSelectMMD)
library(ALL)
data(ALL)
eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
mem.str <- as.character(eSet1$BT)
nSubjects <- length(mem.str)
memSubjects <- rep(0,nSubjects)
# B3 coded as 0, T2 coded as 1
memSubjects[mem.str == "T2"] <- 1
obj.gsMMD <- gsMMD(eSet1, memSubjects, transformFlag = TRUE,

transformMethod = "boxcox", scaleFlag = TRUE, quiet = TRUE)

Programming is running. Please be patient...
Programming is running. Please be patient...

>
>

para <- obj.gsMMD$para
print(round(para, 3))

pi.3
0.048
sigma2.2
0.981

rho.c1
mu.c1 sigma2.c1
0.559
0.557
-0.069
mu.c3 sigma2.c3
rho.2
0.282
-0.027

-0.841

mu.n1 sigma2.n1
0.903
mu.n3
0.569

-0.390
rho.c3
0.036

pi.1
0.056
rho.n1
-0.047
sigma2.n3
0.616

>

pi.2
0.896
mu.2
-0.002
rho.n3
-0.039

5

or

>
>
>
>
>
>
>
>
>
>
>
+
+
>
>
>

library(GeneSelectMMD)
library(ALL)
data(ALL)
eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
mat <- exprs(eSet1)
mem.str <- as.character(eSet1$BT)
nSubjects <- length(mem.str)
memSubjects <- rep(0,nSubjects)
# B3 coded as 0, T2 coded as 1
memSubjects[mem.str == "T2"] <- 1
obj.gsMMD <- gsMMD.default(mat, memSubjects, iniGeneMethod = "Ttest",

transformFlag = TRUE, transformMethod = "boxcox", scaleFlag = TRUE,
quiet=TRUE)

para <- obj.gsMMD$para
print(round(para, 3))

If we would like to provide the initial 3-cluster partition via the two sample Wilcoxon rank-sum test,

then we can run either

>
>
>
>
>
>
>
>
>
>
+
+
+
+
+
+
+
+
+
+
+
+
>
>
>
>
>
>
>
>
+

library(GeneSelectMMD)
library(ALL)
data(ALL)
eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
mem.str <- as.character(eSet1$BT)
nSubjects <- length(mem.str)
memSubjects <- rep(0,nSubjects)
# B3 coded as 0, T2 coded as 1
memSubjects[mem.str == "T2"] <- 1
myWilcox <-
function(x, memSubjects, alpha = 0.05)
{

xc <- x[memSubjects == 1]
xn <- x[memSubjects == 0]

m <- sum(memSubjects == 1)
res <- wilcox.test(x = xc, y = xn, conf.level = 1 - alpha)
res2 <- c(res$p.value, res$statistic - m * (m + 1) / 2)
names(res2) <- c("p.value", "statistic")

return(res2)

}
mat <- exprs(eSet1)
tmp <- t(apply(mat, 1, myWilcox, memSubjects = memSubjects))
colnames(tmp) <- c("p.value", "statistic")
memIni <- rep(2, nrow(mat))
memIni[tmp[, 1] < 0.05 & tmp[, 2] > 0] <- 1
memIni[tmp[, 1] < 0.05 & tmp[, 2] < 0] <- 3
print(table(memIni))
obj.gsMMD <- gsMMD2(eSet1, memSubjects, memIni, transformFlag = TRUE,
transformMethod = "boxcox", scaleFlag = TRUE, quiet = TRUE)

6

para <- obj.gsMMD$para
print(round(para, 3))

library(GeneSelectMMD)
library(ALL)
data(ALL)
eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
mat <- exprs(eSet1)
mem.str <- as.character(eSet1$BT)
nSubjects <- length(mem.str)
memSubjects <- rep(0,nSubjects)
# B3 coded as 0, T2 coded as 1
memSubjects[mem.str == "T2"] <- 1
myWilcox <-
function(x, memSubjects, alpha = 0.05)
{

xc <- x[memSubjects == 1]
xn <- x[memSubjects == 0]

m <- sum(memSubjects == 1)
res <- wilcox.test(x = xc, y = xn, conf.level = 1 - alpha)
res2 <- c(res$p.value, res$statistic - m * (m + 1) / 2)
names(res2) <- c("p.value", "statistic")

return(res2)

}
tmp <- t(apply(mat, 1, myWilcox, memSubjects = memSubjects))
colnames(tmp) <- c("p.value", "statistic")
memIni <- rep(2, nrow(mat))
memIni[tmp[, 1] < 0.05 & tmp[, 2] > 0] <- 1
memIni[tmp[, 1] < 0.05 & tmp[, 2] < 0] <- 3
print(table(memIni))
obj.gsMMD <- gsMMD2.default(mat, memSubjects, memIni = memIni,

transformFlag = TRUE, transformMethod = "boxcox", scaleFlag = TRUE,
quiet=TRUE)

para <- obj.gsMMD$para
print(round(para, 3))

>
>
>

or

>
>
>
>
>
>
>
>
>
>
>
+
+
+
+
+
+
+
+
+
+
+
+
>
>
>
>
>
>
>
+
+
>
>
>
>

Actually, the two sample Wilcoxon rank-sum test is implemented in the GeneSelectMMD. The above

code is used as an illustration on how to use the functions gsMMD2 and gsMMD2.default.

Note that the speed of the four functions can be slow for large data sets, however it has been improved

since version 2.0.7 by using Fotran code.

5 Error rates estimated for real microarray data sets

For real microarray data sets, the classical gene selection methods, such as two-sample t-test, two-sample
Wilcoxon rank-sum test, do not directly provide the estimates of error rates such as false discovery rate

7

(denoted as FDR; it is the percentage of nondifferentially expressed genes among selected genes), false non-
discovery rate (denoted as FNDR; it is the percentage of differentially expressed genes among unselected
genes), false positive rate (denoted as FPR; it is the percentage of selected genes among nondifferentially
expressed genes), and false negative rate (denoted as FNR; it is the percentage of un-selected genes among
differentially expressed genes), since the true gene cluster membership is unknown.

However, model-based gene selection methods (e.g., eLNN and eGG proposed by Lo and Gottardo (2007),
and the method proposed by Qiu et al.’s (2008)) could easily estimate these error rates, since these error
rates are functions of some probabilities which are in turn the functions of model parameters.

The function errRates is used to estimate FDR, FNDR, FPR, and FNR based on the objects returned
by the four gene selection functions mentioned in the previous section. This function returns a 4 × 1 vector
with elements FDR, FNDR, FPR, and FNR.

For example,

>

print(round(errRates(obj.gsMMD), 3))

FDR

FNR
0.027 0.000 0.003 0.000

FNDR

FPR

>

6 Visualizing the fit of the model to a real microarray data set

In general, it is difficult to visualize the fit of the model to a real microarray data set since the data are
in high-dimensional space. However, it is possible to do so for the special case where the tissue samples
within a tissue type are marginally independent. In this case, we can pool all gene expression levels together
since they are all independent, and regard them as one-dimensional data. Next, we can impose the density
estimate onto the histogram of this pooled data.

The function plotHistDensity is used for such purpose. The following R code illustrates the usage of

plotHistDensity:

plotHistDensity(obj.gsMMD, plotFlag = "case",

mytitle = "Histogram of gene expression levels for T2\nimposed with estimated density (case)",
plotComponent = TRUE,
x.legend = c(0.8, 3),
y.legend = c(0.3, 0.4),
numPoints = 500,
cex.main = 1,
cex = 1)

>
+
+
+
+
+
+
+
>

8

Figure 1: Plot produced using plotHistDensity

7 Efficiency improvements

Version 2.0.7 includes efficiency improvements to the EM optimization process. Specifically, Fortran 77 code
for version 3.0 of the L-BFGS-B optimization algorithm from Morales and Nocedal (2011) has been included.
The objective functions for the EM optimization have been translated to Fortran 77 in order to facilitate
the use of this optimization code. Additional operations within the EM optimization iterative loop have also
been written in Fortran 77 to improve the speed, where the calculation of the weigths has been addressed.
Lastly, although the t-test is an optional operation, and therefore, improvements in its speed may not always
be of consequence, the two-sample t-test calculations have increased efficiency in version 2.0.7.

Analysis involving simulated microarray data for 32,000 genes and a total of 2,000 samples is accomplished
in under a minute on a notebook computer (Figure 2), and therefore, the enhanced performance provided
by GeneSelectMMD can be attained on larger datasets using typical hardware.

9

Histogram of gene expression levels for T2imposed with estimated density (case)expression leveldensity−4−2020.00.10.20.30.4overallcomponent1component2component3Figure 2: Plot of running time vs number of genes using an Asus notebook with Intel® Core™ i5-2450M
CPU and 8GB memory

8 Discussion

The speeds of the four gene selection functions described in Section 4 can be slow, however the speed has
been improved by embedding Fortran code in the R code for version 2.0.7 of the GeneSelectMMD.

References

[1] Chiaretti, S., Li, X., Gentleman, R., Vitale, A., Vignetti, M., Mandelli, F., Ritz, J., and Foa, R. Gene
expression profile of adult t-cell acute lymphocytic leukemia identifies distinct subsets of patients with
different response to therapy and survival. Blood, 103:2771–2778, 2004.

[2] Dempster, A., Laird, N., and Rubin, D. Likelihood from incomplete data via the em algorithm. Journal

of the Royal Statistical Society, Series B, 39(1):1–38, 1977.

[3] Lo, K. and Gottardo, R. Flexible empirical bayes models for differential gene expression. Bioinformatics,

23:328–335, 2007.

[4] Morales, J.L. and Nocedal, J. Remark on ”algorithm 778: L-bfgs-b: Fortran subroutines for large-scale
bound constrained optimization”. ACM Transactions on Mathematical Software, 38(1):Article 7, 2011.

[5] Qiu, W.-L., He, W., Wang, X.-G., and Lazarus, R. A marginal mixture model for selecting differentially
expressed genes across two types of tissue samples. The International Journal of Biostatistics, 4(1):Article
20, 2008.

10

0102030405060unix.time() values for v2.0.7 nCases= 1000  nControls= 1000  50  simulations per data pointnumber of genes in simulated data (x1000)number of secondsllll0102030405060l0102030405060l0102030405060ll0102030405060l01020304050600102030405060llll01020304050600.250.512481632