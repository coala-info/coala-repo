Measurement error model for correlation
coefficient estimation

Beiying Ding
Robert Gentleman

October 30, 2025

Introduction

The MeasurementError.cor package fits a two-stage measurement error
model for estimating correlation between two random variables under bi-
variate normality.
It’s application is perhaps most relevant for the gene
expression data where both point and standard estimates are available. We
have shown that the proposed measurement error corrected correlation es-
timate has lower bias compared with the usual sample pearson correlation.
For details, refer to Ding and Gentleman (2003) as well as R help pages
associated with each function.

The cor.me.vector and cor.me.matrix functions

The cor.me.vector calculates the measurement error model estimate of cor-
relation between two observed vectors whereas cor.me.matrix calculates all
pairwise measurement error model estimate of correlation in the matrix.

> library(MeasurementError.cor)
> exp <- matrix(abs(rnorm(100,1000,20)),ncol=10)
> se <- matrix(abs(rnorm(100,50,5)),ncol=10)
> cor.me.vector(exp[1,],se[1,],exp[2,],se[2,])

$estimate

corr.me
0.8850795

corr.true
mu2
0.7858412 989.1089232 996.1652921

mu1

s1
0.3168045

s2
0.1654095

1

$counts
function gradient
16

19

$convergence
[1] 0

> cor.me.matrix(exp,se)

$corr.true

[,5]

[,4]

[,3]

[,2]
[,1]
0.7858412
1.0000000
[1,]
1.0000000
0.7858412
[2,]
0.5182590
0.7842548
[3,]
0.7700246 -0.7340717
[4,]
0.6595202
[5,]
0.4346654
0.7428716
[6,] -0.7222119
0.7536520
0.8507424
[7,]
0.8034329
0.7339783
[8,]
0.8419556 -0.8114023 -0.8507634
0.7626182
[9,]

[,6]
0.5182590 0.7700246 0.4346654 -0.7222119
0.7842548 -0.7340717
0.7428716
1.0000000 0.8958673 0.7852270 0.3792243
0.8552221 -0.6074903
0.8958673
0.7852270 0.8552221 1.0000000 0.4619557
1.0000000
0.3792243 -0.6074903
0.7461718
0.8745920 -0.7276571
0.8012259 0.6802361 0.6854379 0.5450671
0.6292933 -0.8612659
[10,] -0.8399550 -0.9460624 -0.7108637 -0.8328296 -0.8237575 -0.6729643
[,9]

0.4619557
0.7237678

0.6595202

1.0000000

[,7]
0.8507424
[1,]
0.7536520
[2,]
[3,]
0.8745920
[4,] -0.7276571
0.7237678
[5,]
0.7461718
[6,]
1.0000000
[7,]
[8,]
0.7093601
[9,] -0.6542309

[,10]
[,8]
0.7626182 -0.8399550
0.7339783
0.8034329
0.8419556 -0.9460624
0.8012259 -0.8114023 -0.7108637
0.6802361 -0.8507634 -0.8328296
0.6854379
0.6292933 -0.8237575
0.5450671 -0.8612659 -0.6729643
0.6239833
0.7093601 -0.6542309
0.8089159 -0.5794399
1.0000000
1.0000000 -0.6620705
0.8089159
0.6239833 -0.5794399 -0.6620705 1.0000000

[10,]

>

the quantity of interest, i.e. the model estimate of the correlation between
the true value of two random variables whereas cor.me is the model es-
timate of correlation between the measurement errors of the two random
variables. The second quantity may not be of interest. mu1,mu2 and s1, s2
are the estimated mean and standard deviation of the two random variables.

2

cor.me.matrix only returns the estimated correlation matrix.

References

Beiying Ding and Robert Gentleman. Measurement error model for cor-
relation coefficient estimation and its application in microarray analysis.
2003.

3

