How to use the OutlierD Package

HyungJun Cho

April 24, 2017

Contents

1 Introduction

2 Software Description

3 Example: LCMS Data

4 Conclusion

1

Introduction

1

1

2

4

It is important to preprocess high-throughput data generated from microarray or mass
spectrometry experiments in order to obtain a successful analysis. Outlier detection is an
important preprocessing step. For outlier detection, upper and lower fences (Q3+1.5IQR
and Q1 − 1.5IQR) of the diﬀerences are often used in statistics, where Q1=lower 25%
quantile, Q3=upper 25% quantile, and IQR = Q3 − Q1. However, heterogenous vari-
ability is often observed in high-throughput data. By ignoring heterogenous variability
and using the fences that are constant over all values, we may often miss true outliers
and detect false outliers. Therefore, the OutlierD package provides various quantile re-
gression techniques (constant, linear, nonlinear, and nonparametric quantile estimators)
on the M-A scatterplots, accounting for heterogenous variability to detect outliers with
low false positive and negative rates in high-throughput data. The OutlierD package
employs libraries quantreg and Biobase, which must be installed in advance.

2 Software Description

We use the duplicates (denoted by X1i and X2i) from the experiments replicated under
the same biological and experimental condition, where i = 1, 2, . . . , n and n is the number
of peptides. X1i and X2i are theoretically identical, but in practice have variability, which

1

is particularly heterogeneous. The heterogeneity of variability can be seen in a MA plot
(Figure 1). In the MA plot, M is the diﬀerence between duplicates and A is the average
of them, i.e., Mi = log(X1i/X2i) = log(X1i) − log(X2i) and Ai = (1/2) log(X1iX2i) =
(log(X1i) + log(X2i))/2. As shown in the ﬁrst panel of Figure 1, the constant fences
are not enough to detect outliers correctly. Using the constant fences Q3 + 1.5IQR and
Q1 − 1.5IQR for the diﬀerences, we can miss many true outliers in high levels and select
many false outliers in low levels.

To account for the heterogeneity of variability, we utilize quantile regression on a
M-A scatterplot. The q-quantile linear regression with {(Ai, Mi), i = 1, . . . , n} is to ﬁnd
the parameters minimizing

(cid:88)

q|Mi − θi| +

(cid:88)

(1 − q)|Mi − θi|,

{i:Mi≥θi}

{i:Mi<θi}

where 0 < q < 1 and θi = β0 + β1Ai. By applying the regression, we compute the
0.25 and 0.75 quantile estimates, Q1(A) and Q3(A), of the diﬀerences, M, depending
on the levels, A. Then we construct the lower and upper fences: Q1(A) − 1.5IQR(A)
and Q3(A) + 1.5IQR(A), where IQR(A) = Q3(A) − Q1(A). To obtain the quantile
estimates depending on the levels more ﬂexibly, we can also utilize nonlinear and non-
parametric quantile regression approaches. Thus, our developed software OutlierD
provides intensity-level adaptive fences, which are built from four quantile regression
approaches, including constant quantile regression.

3 Example: LCMS Data

We demonstrate the use of the package with a LC/MS data set. This real data set
consists of intensity values for 922 peptides and 2 samples. To run OutlierD, the data
can be prepared as follows.

> library(OutlierD)
> data(lcms)
> x <- log2(lcms)
> dim(x)

[1] 922

2

We here took log2-transformation without any other normalizations. An appropriate
If the data is ready, OutlierD can be run as

normalization can be taken if needed.
follows.

> fit1 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="constant")

Please wait... Done.

2

> fit2 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="linear")

Please wait... Done.

> fit3 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="nonlin")

Please wait... Done.

> fit4 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="nonpar")

Please wait... Done.

The arguments x1 and x2 are two data vectors for samples, consisting of many
elements for peptides or proteins. The argument k(> 0) is a constant in Q1 − k ∗ IQR
and Q3 + k ∗ IQR. To be stringent, give a bigger value for k. A user can choose one of
four diﬀerent quantile regression estimators: constant, linear, nonlin, and nonpar. Using
the options show the following plots.

3

15202530−50510AMConstant15202530−50510AMLinear15202530−50510AMNonlinear15202530−50510AMNonparametricConstant quantile regression is the simplest, whereas nonparametric quantile regres-
sion is the most complex. The above objects (ﬁt1, ﬁt2, ﬁt3, and ﬁt4) contain the outputs.
To see outliers detected, for example, type:

> fit3$n.outliers

[1] 52

> dim(fit3$x)

[1] 922

9

> head(fit3$x)

Outlier

A

X2

X1

LB
FALSE 21.58628 21.67638 21.63133 -0.09025246 -0.5919934 0.5919934 -2.367974
FALSE 17.30741 14.24971 15.77856 2.95421055 -1.1206127 1.1206127 -4.482451
FALSE 22.55693 22.72186 22.63940 -0.16497390 -0.5292300 0.5292300 -2.116920
FALSE 25.70870 26.51004 26.10937 -0.80134111 -0.3586338 0.3586338 -1.434535
TRUE 22.26959 18.44030 20.35495 3.82855048 -0.6817269 0.6817269 -2.726908
FALSE 25.09663 25.63526 25.36594 -0.53862554 -0.3899622 0.3899622 -1.559849

Q3

Q1

M

1
2
3
4
5
6

UB
1 2.367974
2 4.482451
3 2.116920
4 1.434535
5 2.726908
6 1.559849

The outliers detected by nonlinear quantile regression are indicated in the ﬁrst col-

umn. Using nonlinear quantile regression, 14 outliers were detected.

4 Conclusion

This package is designed to detect outliers using quantile regression on the M-A scatter-
plots of high-throughput data. According to the degree of heterogeneous variability, one
of constant, linear, nonlinear, and nonparametric quantile estimators can be chosen.

4

