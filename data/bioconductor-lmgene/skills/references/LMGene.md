LMGene User’s Guide

Geun-Cheol Lee, John Tillinghast, and David M. Rocke

October 30, 2017

Contents

1 Introduction

2 Data preparation

3 G-log transformation

4 Finding diﬀerentially expressed genes

1 Introduction

1

1

3

5

This article introduces usage of the LMGene package. LMGene has been developed for analysis of
microarray data using a linear model and glog data transformation in the R statistical package.

2 Data preparation

LMGene takes objects of class ExpressionSet, which is the standard data structure of the Biobase
package. Therefore, the user who already has data that is of class ExpressionSet can jump to
further steps, such as g-log transformation or looking for diﬀerentially expressed genes. Otherwise,
the user needs to generate new objects of class ExpressionSet. For more detail, please see the
vignette, ‘An Introduction to Biobase and ExpressionSets’ in the Biobase package.
Note: ExpressionSet. In this package, an object of class ExpressionSet must produce proper
data using the commands exprs(object) and phenoData(object).
Example. LMGene includes sample array data which is of class ExpressionSet. Let’s take a look
this sample data.

1. First, load the necessary packages in your R session.

> library(LMGene)
> library(Biobase)
> library(tools)

2. Load the sample ExpressionSet class data in the package LMGene.

> data(sample.eS)

1

3. View the data structure of the sample data and the details of exprs and phenoData slots in

the data.

> slotNames(sample.eS)

[1] "experimentData"
[4] "featureData"
[7] ".__classVersion__"

> dim(exprs(sample.eS))

[1] 613 32

"assayData"
"annotation"

"phenoData"
"protocolData"

> exprs(sample.eS)[1:3,]

p1d0 p1d1 p1d2 p1d3 p2d0 p2d1 p2d2 p2d3 p3d0 p3d1 p3d2 p3d3 p4d0 p4d1 p4d2
g1 216 149 169 113 193 172 167 168 151 179 142 156 160 214 157
g2 334 311 187 135 514 471 219 394 367 390 365 387 318 378 329
g3 398 367 351 239 712 523 356 629 474 438 532 427 429 574 419
p4d3 p5d0 p5d1 p5d2 p5d3 p6d0 p6d1 p6d2 p6d3 p7d0 p7d1 p7d2 p7d3 p8d0 p8d1
g1 195 165 144 185 162 246 227 173 151 796 378 177 278 183 285
g2 450 293 285 390 428 645 631 324 343 852 451 259 379 259 386
g3 564 438 321 519 488 824 579 416 489 1046 501 375 388 373 509

p8d2 p8d3
g1 275 202
g2 361 333
g3 468 436

> phenoData(sample.eS)

An object of class

’

AnnotatedDataFrame

’

sampleNames: p1d0 p1d1 ... p8d3 (32 total)
varLabels: patient dose
varMetadata: labelDescription

> slotNames(phenoData(sample.eS))

[1] "varMetadata"
[4] ".__classVersion__"

"data"

"dimLabels"

Data generation. If you don’t have ExpressionSet class data, you need to make some. LMGene
provides a function that can generate an object of class ExpressionSet, assuming that there are
array data of matrix class and experimental data of list class.

1. The package includes sample array and experimental/phenotype data, sample.mat and vlist.

> data(sample.mat)
> dim(sample.mat)

2

[1] 613 32

> data(vlist)
> vlist

$patient

[1] 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8

Levels: 1 2 3 4 5 6 7 8

$dose

[1] 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3

2. Generate ExpressionSet class data using neweS function.

> test.eS<-neweS(sample.mat, vlist)
> class(test.eS)

[1] "ExpressionSet"
attr(,"package")
[1] "Biobase"

3 G-log transformation

1. Estimating parameters for g-log transformation. In LMGene, the linear model is not
intended to be applied to the raw data, but to transformed and normalized data. Many people
use a log transform. LMGene uses a log-like transform involving two parameters. We estimate
the parameters λ and α of the generalized log transform log (y − α + (cid:112)(y − α)2 + λ) = sinh−1( y−α
log(λ) using the function tranest as follows:

λ )+

> tranpar <- tranest(sample.eS)
> tranpar

$lambda
[1] 726.6187

$alpha
[1] 56.02754

The optional parameter ngenes controls how many genes are used in the estimation. The
default is all of them (up to 100,000), but this option allows the use of less. A typical call
using this parameter would be

> tranpar <- tranest(sample.eS, 100)
> tranpar

3

$lambda
[1] 810.6031

$alpha
[1] 65.39051

In this case, 100 genes are chosen at random and used to estimate the transformation param-
eter. The function returns a list containing values for lambda and alpha.

2. G-log transformation. Using the obtained two parameters, the g-log transformed expres-

sion set can be calculated as follows.

> trsample.eS <- transeS(sample.eS, tranpar$lambda, tranpar$alpha)
> exprs(sample.eS)[1:3,1:8]

p1d0 p1d1 p1d2 p1d3 p2d0 p2d1 p2d2 p2d3
g1 216 149 169 113 193 172 167 168
g2 334 311 187 135 514 471 219 394
g3 398 367 351 239 712 523 356 629

> exprs(trsample.eS)[1:3,1:8]

p1d0

p1d1

p2d3
g1 5.716654 5.147108 5.352141 4.635531 5.554341 5.379691 5.333358 5.342792
g2 6.289203 6.200233 5.507392 4.975467 6.800305 6.699768 5.736041 6.489889
g3 6.501943 6.404501 6.350248 5.856612 7.165374 6.820130 6.367519 7.028146

p2d2

p1d3

p2d0

p2d1

p1d2

3. Tranest options: multiple alpha, lowessnorm, model

Rather than using a single alpha for all samples, we can estimate a separate alpha for each
sample. This allows for diﬀerences in chips, in sample concentration, or exposure conditions.

> tranparmult <- tranest(sample.eS, mult=TRUE)
> tranparmult

$lambda
[1] 689.2819

$alpha

[1] 69.67146 37.02711 54.13904 69.35728 60.33270 60.75301 71.72965
[8] 64.55506 58.63427 65.73625 48.40173 59.43778 76.34568 78.81046
[15] 82.20326 96.19938 77.60070 79.48089 73.63257 73.41650 33.86029
[22] 69.26448 55.75460 54.29840 139.89493 91.36521 46.46158 59.02056
[29] 73.60255 89.48728 57.13887 64.98866

For vector alphas, transeS uses exactly the same syntax:

> trsample.eS <- transeS (sample.eS, tranparmult$lambda, tranparmult$alpha)
> exprs(trsample.eS)[1:3,1:8]

4

p1d0

p1d1

p2d3
g1 5.686954 5.424873 5.449682 4.549380 5.590642 5.418542 5.268332 5.347915
g2 6.272797 6.308464 5.592073 4.915159 6.811348 6.710929 5.693269 6.492140
g3 6.488757 6.493737 6.388361 5.832776 7.173087 6.830052 6.345199 7.029530

p2d2

p1d3

p2d0

p2d1

p1d2

It’s also possible to estimate the parameters using the more accurate lowess normalization (as
opposed to uniform normalization):

> tranparmult <- tranest(sample.eS, ngenes=100, mult=TRUE, lowessnorm=TRUE)
> tranparmult

$lambda
[1] 877.2374

$alpha

[1] 73.17224 53.20403 62.86795 67.79175 69.47318 70.26318 78.24274
[8] 67.20772 59.13130 72.01339 72.46492 60.99220 66.20442 65.11474
[15] 60.10359 88.47935 55.17695 59.17230 62.21021 69.29876 56.22825
[22] 85.04349 62.98882 68.22584 210.18464 120.54227 60.17115 80.66031
[29] 64.27210 91.39231 60.09844 58.28234

One may also specify a model other than the default no-interaction model. For example, if
we think that the interaction of variables in vlist is important, we can add interaction to
the model:

> tranpar <- tranest(sample.eS, model=
> tranpar

’

patient + dose + patient:dose

)

’

$lambda
[1] 860.0836

$alpha
[1] 55.68625

The model is always speciﬁed in the same way as the right-hand side of an lm model. In the
example above, we set the parameters to minimize the mean squared error for a regression of
transformed gene expression against patient, log dose, and their interaction.

Be very careful of using interactions between factor variables.
replicates, you can easily overﬁt the data and have no degrees of freedom left for error.

If you do not have enough

Naturally, it’s possible to use mult, lowessnorm, and model all together.

4 Finding diﬀerentially expressed genes

1. Transformation and Normalization. Before ﬁnding diﬀerentially expressed genes, the ar-

ray data needs to be transformed and normalized.

5

> trsample.eS <- transeS (sample.eS, tranparmult$lambda, tranparmult$alpha)
> ntrsample.eS <- lnormeS (trsample.eS)

2. Finding differentially expressed genes The LMGene routine computes signiﬁcant probes/genes

by calculating gene-by-gene p-values for each factor in the model and adjusting for the spec-
iﬁed false discovery rate (FDR). A typical call would be

> sigprobes <- LMGene(ntrsample.eS)

There is an optional argument, level, which is the FDR (default 5 percent). A call using
this optional parameter would look like

> sigprobes <- LMGene(ntrsample.eS,level=.01)

The result is a list whose components have the names of the eﬀects in the model. The values
are the signiﬁcant genes for the test of that eﬀect or else the message ”No signiﬁcant genes”.

As with tranest, it’s possible to specify a more complex model to LMGene:

> sigprobes <- LMGene(ntrsample.eS, model=
> sigprobes

’

patient+dose+patient:dose

)

’

$patient

[1] "g2"

"g3"

"g4"

"g9"

"g10" "g15" "g43" "g49" "g54" "g56"

[11] "g84" "g85" "g86" "g88" "g93" "g123" "g139" "g155" "g176" "g178"
[21] "g179" "g183" "g240" "g277" "g304" "g305" "g310" "g336" "g375" "g399"
[31] "g405" "g406" "g407" "g408" "g409" "g411" "g412" "g413" "g414" "g415"
[41] "g417" "g461" "g462" "g463" "g477" "g485" "g503" "g520" "g528" "g544"
[51] "g566" "g607" "g612"

$dose
[1] "No significant genes"

‘

‘

patient:dose

$
[1] "No significant genes"

References

[1] Benjamini, Y. and Hochberg, Y. (1995) “Controlling the false discovery rate: a practical and
powerful approach to multiple testing,” Journal of the Royal Statistical Society, Series B, 57,
289–300.

[2] Durbin, B.P., Hardin, J.S., Hawkins, D.M., and Rocke, D.M. (2002) “A variance-stabilizing

transformation for gene-expression microarray data,” Bioinformatics, 18, S105–S110.

[3] Durbin, B. and Rocke, D. M. (2003a) “Estimation of transformation parameters for microarray

data,” Bioinformatics, 19, 1360–1367.

6

[4] Durbin, B. and Rocke, D. M. (2003b) “Variance-stabilizing transformations for two-color mi-

croarrays,” Bioinformatics, 20, 660–667.

[5] Geller, S.C., Gregg, J.P., Hagerman, P.J., and Rocke, D.M. (2003) “Transformation and nor-

malization of oligonucleotide microarray data,” Bioinformatics, 19, 1817–1823.

[6] Huber W., Von Heydebreck A., S¨ultmann H., Poustka A. and Vingron M. (2002) “Variance
stabilization applied to microarray data calibration and to the quantiﬁcation of diﬀerential
expression,” Bioinformatics, 18, S96–S104.

[7] Rocke, David M. (2004) “Design and Analysis of Experiments with High Throughput Biological

Assay Data,” Seminars in Cell and Developmental Biology , 15, 708–713.

[8] Rocke, D., and Durbin, B. (2001) “A model for measurement error for gene expression arrays,”

Journal of Computational Biology, 8, 557–569.

[9] Rocke, D. and Durbin, B. (2003) “Approximate variance-stabilizing transformations for gene-

expression microarray data,” Bioinformatics, 19, 966–972.

7

