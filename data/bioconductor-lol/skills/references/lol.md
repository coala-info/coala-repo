R package lol

Lots Of Lasso: Stable network inference for integrative genomic analysis

Yinyin Yuan *
http://www.markowetzlab.org/software/lol
yy341@cam.ac.uk

24th Feb 2011

1

Introduction

lol is a package providing various optimization methods for Lasso inference. As popular tools in genomics, Lasso
has been used in eQTL, GWAS, and studies of similar kind. It provides a prominent basis in high-dimensional
studies, because of its eﬃciency in performing statistical inference on thousands of variables.

Yet despite its popularity, Lasso inference can be problematic if not optimized properly. Solving the optimi-
sation problem for L1 regression often involves cross-validation. With noisy predictors, cross-validation tends to
overﬁt and produce unstable result. Hence, in the context of genomic marker selection using microarray data,
we implemented diﬀerent optimization methods, i.e, simultanous lasso, stability selection, multisplit lasso, and
cross-validation, for increased robustness and stable outcome.

We exemplify the use of this package using a breast cancer dataset comprising CNA and mRNA [1]. The

data set includes (i) genome-wide DNA variation, (ii) expression as an intermediate trait.

Load the package ‘lol’ and import the breast cancer data set.

> library(lol)
> data(chin07)
> dim(chin07$cn)

[1] 339 106

> dim(chin07$ge)

[1]

7 106

We can visualize in an approximate manner what is the copy number alterations across the genome in this

data set, using the plotGW function.

> gain <- rowSums(chin07$cn >= .2)
> loss <- -rowSums(chin07$cn <= -.2)
> plotGW(data=cbind(gain, loss), pos=attr(chin07$cn,
+ fileType=

, legend=c(

), col=c(

gain

loss

pdf

,

’

’

’

’

’

’

’

’

’

chrome
,

’

darkred

), file=
’

darkblue

plotGWCN
’

))

’

’

,

null device
1

2 Genomic marker selection for individual response/gene expres-

sion

For a genes’s expression proﬁle probed by microarray, we search for the genomic markers whose copy number
alterations inﬂuences this gene. The ‘lasso’ function incorporates four diﬀerent optimizers, each can be accessed
by specifying the class of input object as one of the optimizers. If cross-validation is prefered, we can use the
‘lasso’ function with a data object of class ‘cv’, Because we will be using a lot of resampling, here we set the
seed ﬁrst.

*Cambridge Research Institute - CRUK, Li Ka Shing Centre, Robinson Way Cambridge, CB2 0RE, UK.

1

’

’

> Data <- list(y=chin07$ge[1,], x=t(chin07$cn))
> class(Data) <-
> set.seed(10)
> res.cv <- lasso(Data)
> res.cv

cv

Non-zero coefficients: 0
from a total of 339 predictors

This function optimizes lasso solution for correlated regulators by ﬁrst choosing the minimum lambda, since
the penalized package by default use 0 for the minimum which sometimes take a long time to compute due to
co-linearity.

Alternatively, we can use the stability lasso [2] that achieves stable output by sub-sampling. The function
0.8 × p predictors, while p is the number of total
ﬁrst selects lambda that approximately give maximum
predictors. Then it runs lasso a number of times keeping lambda ﬁxed. These runs are randomised with
scaled predictors and subsamples. At the end, the non-zero coeﬃcients are determined by their frequencies of
selections.

√

’

’

> class(Data) <-
> res.stability <- lasso(Data)
> res.stability

stability

Non-zero coefficients: 0
from a total of 339 predictors

Another optimzer performs the multi-split lasso as proposed in [3]. The samples are ﬁrst randomly split into
two disjoint sets, one of which is used to ﬁnd non-zero coeﬃcients with a regular lasso regression, then these
non-zero coeﬃcients are ﬁtted to another sample set with OLS. The resulting p-values after multiple runs can
then be aggregated using quantiles.

’

’

> class(Data) <-
> res.multiSplit <- lasso(Data)
> res.multiSplit

multiSplit

Non-zero coefficients: 1
from a total of 339 predictors

The fourth optimizer, simultanous lasso, performs multiple runs of lasso, each time splitting samples ran-
domly to two equal sets, run lasso on both sets, then select those coeﬃcients that are simultaneously non-zero
across two sets.

’

’

> class(Data) <-
> res.simultaneous <- lasso(Data)
> res.simultaneous

simultaneous

Non-zero coefficients: 2
from a total of 339 predictors

Using ‘plotGW’, we can also visualize results from diﬀerent optimizers. While any non-zero coeﬃcients
from cross-validation can be deemed signiﬁcant, results from subsampling-based optimizers such as stability
lasso and simultaneous lasso have to pass a signiﬁcance level such as 60% selection frequency in order to be
considered signiﬁcant. For more details see [2].

> plotGW(data=cbind(res.cv$beta, res.stability$beta, res.multiSplit$beta, res.simultaneous$beta),
+ pos=attr(chin07$cn,
+ height=5, legend=c(

pdf
), legend.pos=

plotGWLassoOptimizers

, width=8,
’

), file=
’

chrome
,

simultaneous

, fileType=

multiSplit

stability

topleft

cv

)

,

,

’

’

’

’

’

’

’

’

’

’

’

’

’

’

null device
1

2

3 Genomic marker selection for multiple responses/gene expression

Now if the goal is to infer a network of copy number driving expression, with multiple expression proﬁles,
we can use the function matrixLasso. This wrapper function can use diﬀerent types of lasso optimizers and
perform multiple, independent lasso inference on matrix responses. If the dimensionality of the input is small,
the function converts the matrix of input response into a vector and solves the problem with one lasso inference.
Otherwise, lasso regression is performed independently for each variables in the response matrix.

> Data <- list(y=t(chin07$ge), x=t(chin07$cn))
> res1 <- matrixLasso(Data, method=
> res1

cv

)

’

’

Non-zero coefficients in total: 46
from a total of 339 predictors
and 7 responses

> res2 <- matrixLasso(Data, method=
> res2

’

stability

’

)

Non-zero coefficients in total: 2
from a total of 339 predictors
and 7 responses

At the end, we recommend reﬁtting regression models with the selected predictors using lm() so that the

coeﬃcients are not shrinked.

> res.lm <- lmMatrixFit(y=Data, mat=abs(res2$coefMat), th=0.01)
> res.lm

Non-zero coefficients in total: 2
from a total of 339 predictors
and 7 responses

4 Session Information

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats

graphics grDevices utils

datasets methods

base

other attached packages:
[1] lol_1.26.0

Matrix_1.2-11

penalized_0.9-50 survival_2.41-3

loaded via a namespace (and not attached):
[1] compiler_3.4.2 tools_3.4.2
[5] grid_3.4.2

lattice_0.20-35

Rcpp_0.12.13

splines_3.4.2

3

References

[1] Suet Chin, Andrew Teschendorﬀ, John Marioni, Yanzhong Wang, Nuno Barbosa-Morais, Natalie Thorne,
Jose Costa, Sarah Pinder, Mark van de Wiel, Andrew Green, Ian Ellis, Peggy Porter, Simon Tavare, James
Brenton, Bauke Ylstra, and Carlos Caldas. High-resolution acgh and expression proﬁling identiﬁes a novel
genomic subtype of er negative breast cancer. Genome Biology, 8(10):R215, 2007.

[2] Nicolai Meinshausen and Peter Buehlmann. Stability selection. Journal of the Royal Statistical Society

Series B-Statistical Methodology, 72:417–473, 2010.

[3] Nicolai Meinshausen, Lukas Meier, and Peter Buehlmann. p-values for high-dimensional regression. Journal

of the American Statistical Association, 104(488):1671–1681, December 2009.

4

