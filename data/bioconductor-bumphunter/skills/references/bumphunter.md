The bumphunter user’s guide

Kasper Daniel Hansen khansen@jhsph.edu
Martin Aryee aryee.martin@mgh.harvard.edu
Rafael A. Irizarry rafa@jhu.edu

Modified: November 23, 2012. Compiled: October 29, 2025

Introduction

This package implements the statistical procedure described in [2] (with some small modifica-
tions). Notably, batch effect removal and the application of the bootstrap to linear models of Efron
and Tibshirani [1] need additional code.

For any given type of data, it is usually necessary to make a number of choices and/or transforma-
tions before the bump hunting methodology is ready to be applied. Typically, these modifications
resides in other packages. Examples are charm (for CHARM-like methylation microarrays),
bsseq (for whole-genome bisulfite sequencing data) and minfi (for Illumina 450k methylation
arrays). In some cases (specifically bsseq) only parts of the methodology as implemented in
the bumphunter package is applied, although the conceptual approach is still build on bump
hunting.

In other words, this package is mostly intended for developers wishing to adapt the general method-
ology to their specific applications.

The core of the package is encapsulated in the bumphunter method which uses the underlying
bumphunterEngine to do the heavy lifting. However, bumphunterEngine consists of a
number of useful functions that does much of the specific tasks involved in bump hunting. This
document attempts to describe the overall workflow as well as the specific functions. The relevant
functions are clusterMaker, getSegments, findRegions.

> library(bumphunter)

1

Note that this package is written with genomic data as an illustrative example but most of it is
easily generalizable to other data types.

Other functions

Most of the bumphunter package is code for bump hunting. But we also include a number of
convenience functions we have found useful, which are not necessarily part of the bump hunting
exercise. At the time of writing, this include annotateNearest.

The Statistical Model

The bump hunter methodology is meant to work on data with several biological replicates, similar
to the lmFit function in limma. While the package is written using genomic data as an illustra-
tive example, most of it is generalizable to other data types (with some one-dimensional location
information).

We assume we have data Yij where i represents (biological) replicate and lj represents genomic lo-
cation. The use of j and lj is a convenience notation, allowing us to discuss the “next” observation
j + 1 which may be some distance lj + 1 − lj away. Note that we assume in this notation that all
replicates have been observed at the same set of genomic locations.

The basic statistical model is the following:

Yij = β0(lj) + β1(lj)Xj + εij

with i representing subject, lj representing the jth location, Xj is the covariate of interest (for
example Xj = 1 for cases and Xj = 0 otherwise), εij is measurement error, β0(l) is a baseline
function, and β1(l) is the parameter of interest, which is a function of location. We assume that
β1(l) will be equal to zero over most of the genome, and we want to identify stretched where
β1(l) ̸= 0, which we call bumps.

We want to share information between nearby locations, typically through some form of smooth-
ing.

2

Creating clusters

For many genomic applications the locations are clustered. Each cluster is a distinct unit where
the model fitting will be done separately, and each cluster does not depend on the data, only on
the locations lj. Typically there is some maximal distance, and we do not want to smooth between
observations separated by more than this distance. The choice of distance is very application
dependent.

“Clusters” are simply groups of locations such that two consecutive locations in the cluster are
separated by less than some distance maxGap. For genomic applications, the biggest possible
clusters are chromosomes.

The function clusterMaker defines such grouping locations.

Example: We first generate an example of typical genomic locations

> pos <- list(pos1=seq(1,1000,35),
+
+
> chr <- rep(paste0("chr",c(1,1,2)), times = sapply(pos,length))
> pos <- unlist(pos, use.names=FALSE)

pos2=seq(2001,3000,35),
pos3=seq(1,1000,50))

Now we run the function to obtain the three clusters from the positions. We use the default gap of
300 base pairs (bps), i.e. any two points more than 300 bps away are put in a new cluster. Also,
locations from different chromosomes are separated.

> cl <- clusterMaker(chr, pos, maxGap = 300)
> table(cl)

cl
1

3
2
29 29 20

The output is an indexing variable telling us which cluster each location belongs to. Locations on
different chromosomes are always on different clusters.

Note that data from the first chromosome has been split into two clusters:

3

> ind <- which(chr=="chr1")
> plot(pos[ind], rep(1,length(ind)), col=cl[ind],
+

xlab="locations", ylab="")

Breaking into segments

The function getSegments is used to find segments that are positive, near zero, and negative.
Specifically we have a vector of numbers θj with each number associated with a genomic location
lj (thinks either test statistics or estimates of βi(l)). A segment is a list of consecutive locations
such that all θl in the segment are either “positive”, “near zero” or “negative”. In order to define
“positive” etc we need a cutoff which is one number L (in which case “near zero” is [−L, L])
or two numbers L, U (in which case “near zero” is [L; U ]).

Example: we are going to create a simulated β1(l) with a couple of real bumps.

> Indexes <- split(seq_along(cl), cl)
> beta1 <- rep(0, length(pos))
> for(i in seq(along=Indexes)){
ind <- Indexes[[i]]
+
x <- pos[ind]
+
z <- scale(x, median(x), max(x)/12)
+
+
beta1[ind] <- i*(-1)^(i+1)*pmax(1-abs(z)^3,0)^3 ##multiply by i to vary size
+ }

We now find bumps of this functions by

4

0500100015002000250030000.61.01.4locations> segs <- getSegments(beta1, cl, cutoff=0.05)

Now we can make, for example, a plot of all the positive bumps

index <- which(cl==cl[ind[1]])
plot(pos[index], beta1[index],

> par(mfrow=c(1,2))
> for(ind in segs$upIndex){
+
+
+
+
+
+
+ }

xlab=paste("position on", chr[ind[1]]),
ylab="beta1")

points(pos[ind], beta1[ind], pch=16, col=2)
abline(h = 0.05, col = "blue")

This function is used by regionFinder which is described next.

regionFinder

This function packages up the results of getSegments into a table of regions with the location
and characteristics of bumps.

5

02004006008000.00.20.40.60.81.0position on chr1beta102004006008000.01.02.0position on chr2beta1> tab <- regionFinder(beta1, chr, pos, cl, cutoff=0.05)
> tab

chr start end

value

3 chr1 2281 2701 -1.2636037 16.426848
5.452493
451 501 2.7262463
2 chr2
2.668237
421 561 0.5336474
1 chr1

area cluster indexStart indexEnd L
50 13
69 2
17 5

38
68
13

2
3
1

clusterL
29
20
29

3
2
1

In the plot in the preceding section we show two of these regions in red.

Note that regionFinder and getSegments do not really contain any statistical model. All it
does is finding regions based on segmenting a vector θj associated with genomic locations lj.

Bumphunting

Bumphunter is a more complicated function. In addition to regionFinder and clusterMaker
it also implements a statistical model as well as permutation testing to assess uncertainty.

We start by creating a simulated data set of 10 cases and 10 controls (recall that beta1 was defined
above).

> beta0 <- 3*sin(2*pi*pos/720)
> X <- cbind(rep(1,20), rep(c(0,1), each=10))
> error <- matrix(rnorm(20*length(beta1), 0, 1), ncol=20)
> y <- t(X[,1])%x%beta0 + t(X[,2])%x%beta1 + error

Now we can run bumphunter

> tab <- bumphunter(y, X, chr, pos, cl, cutoff=.5)
> tab

6

$table

chr start end

value

10 chr1 2316 2631 -1.6461580 16.4615803
6.5665199
401 551 1.6416300
chr2
6
1.9034124
601 701 -0.6344708
12 chr2
1.6270008
751 801 0.8135004
chr2
7
1.4385665
176 211 -0.7192832
8
chr1
1.2568758
631 631 1.2568758
chr1
4
0.9925211
951 951 -0.9925211
13 chr2
0.9263241
456 456 0.9263241
chr1
2
0.8673227
701 701 0.8673227
chr1
5
0.7875542
11 chr2
101 101 -0.7875542
0.6462323
chr1 2106 2106 -0.6462323
9
0.6025189
526 526 0.6025189
chr1
3
0.5040430
351 351 0.5040430
chr1
1

area cluster indexStart indexEnd
48
70
73
75
7
19
78
14
21
61
33
16
11

39
67
71
74
6
19
78
14
21
61
33
16
11

2
3
3
3
1
1
3
1
1
3
2
1
1

L clusterL
29
20
20
20
29
29
20
29
29
20
29
29
29

10 10
4
6
3
12
2
7
2
8
1
4
1
13
1
2
1
5
1
11
1
9
1
3
1
1

$coef

[,1]
[1,] -0.22642682
[2,] -0.36434711
[3,] -0.14823469
0.41957906
[4,]
[5,]
0.11642360
[6,] -0.75645087
[7,] -0.68211560
0.01151778
[8,]
0.28162911
[9,]
[10,] 0.39113823

7

[11,] 0.50404303
[12,] 0.28321830
[13,] -0.20850718
[14,] 0.92632412
[15,] 0.21170339
[16,] 0.60251890
[17,] -0.09957509
[18,] 0.25915352
[19,] 1.25687578
[20,] 0.02202985
[21,] 0.86732275
[22,] -0.33632418
[23,] 0.13879033
[24,] -0.11897976
[25,] -0.01996105
[26,] 0.21008863
[27,] -0.35742465
[28,] 0.24026389
[29,] 0.18455909
[30,] 0.15674034
[31,] 0.11123068
[32,] 0.18736219
[33,] -0.64623232
[34,] 0.41527705
[35,] -0.07766524
[36,] 0.20431685
[37,] -0.37912840
[38,] -0.01351543
[39,] -1.11305474
[40,] -1.25525434
[41,] -1.39198135
[42,] -2.94462492
[43,] -2.44359359
[44,] -2.07377900
[45,] -1.80056423
[46,] -1.15953476
[47,] -1.07293148
[48,] -1.20626188
[49,] -0.42622649
[50,] 0.22029799
[51,] -0.47578003
[52,] -0.07955316

8

[53,] -0.12025822
[54,] 0.01127880
[55,] 0.36978062
[56,] -0.17285158
[57,] -0.23101532
[58,] -0.31599925
[59,] -0.20907730
[60,] -0.48567732
[61,] -0.78755415
[62,] -0.49863664
[63,] 0.34088195
[64,] 0.47991228
[65,] 0.28480346
[66,] 0.04924092
[67,] 0.86414289
[68,] 2.46077234
[69,] 2.33127430
[70,] 0.91033041
[71,] -0.54133656
[72,] -0.65861722
[73,] -0.70345863
[74,] 0.92904922
[75,] 0.69795158
[76,] 0.49136983
[77,] 0.45325978
[78,] -0.99252108

$fitted

[,1]
[1,] -0.22642682
[2,] -0.36434711
[3,] -0.14823469
0.41957906
[4,]
[5,]
0.11642360
[6,] -0.75645087
[7,] -0.68211560
0.01151778
[8,]
0.28162911
[9,]
[10,] 0.39113823
[11,] 0.50404303
[12,] 0.28321830
[13,] -0.20850718

9

[14,] 0.92632412
[15,] 0.21170339
[16,] 0.60251890
[17,] -0.09957509
[18,] 0.25915352
[19,] 1.25687578
[20,] 0.02202985
[21,] 0.86732275
[22,] -0.33632418
[23,] 0.13879033
[24,] -0.11897976
[25,] -0.01996105
[26,] 0.21008863
[27,] -0.35742465
[28,] 0.24026389
[29,] 0.18455909
[30,] 0.15674034
[31,] 0.11123068
[32,] 0.18736219
[33,] -0.64623232
[34,] 0.41527705
[35,] -0.07766524
[36,] 0.20431685
[37,] -0.37912840
[38,] -0.01351543
[39,] -1.11305474
[40,] -1.25525434
[41,] -1.39198135
[42,] -2.94462492
[43,] -2.44359359
[44,] -2.07377900
[45,] -1.80056423
[46,] -1.15953476
[47,] -1.07293148
[48,] -1.20626188
[49,] -0.42622649
[50,] 0.22029799
[51,] -0.47578003
[52,] -0.07955316
[53,] -0.12025822
[54,] 0.01127880
[55,] 0.36978062

10

[56,] -0.17285158
[57,] -0.23101532
[58,] -0.31599925
[59,] -0.20907730
[60,] -0.48567732
[61,] -0.78755415
[62,] -0.49863664
[63,] 0.34088195
[64,] 0.47991228
[65,] 0.28480346
[66,] 0.04924092
[67,] 0.86414289
[68,] 2.46077234
[69,] 2.33127430
[70,] 0.91033041
[71,] -0.54133656
[72,] -0.65861722
[73,] -0.70345863
[74,] 0.92904922
[75,] 0.69795158
[76,] 0.49136983
[77,] 0.45325978
[78,] -0.99252108

$pvaluesMarginal
[1] NA

> names(tab)

[1] "table"
[4] "pvaluesMarginal"

"coef"

"fitted"

> tab$table

chr start end

value

10 chr1 2316 2631 -1.6461580 16.4615803
6.5665199
401 551 1.6416300
6
chr2
1.9034124
601 701 -0.6344708
12 chr2
1.6270008
751 801 0.8135004
chr2
7

area cluster indexStart indexEnd
48
70
73
75

39
67
71
74

2
3
3
3

11

chr1
8
4
chr1
13 chr2
chr1
2
5
chr1
11 chr2
9
3
1

176 211 -0.7192832
631 631 1.2568758
951 951 -0.9925211
456 456 0.9263241
701 701 0.8673227
101 101 -0.7875542
chr1 2106 2106 -0.6462323
526 526 0.6025189
chr1
351 351 0.5040430
chr1

1.4385665
1.2568758
0.9925211
0.9263241
0.8673227
0.7875542
0.6462323
0.6025189
0.5040430

1
1
3
1
1
3
2
1
1

6
19
78
14
21
61
33
16
11

7
19
78
14
21
61
33
16
11

L clusterL
29
20
20
20
29
29
20
29
29
20
29
29
29

10 10
4
6
3
12
2
7
2
8
1
4
1
13
1
2
1
5
1
11
1
9
1
3
1
1

Briefly, the bumphunter function fits a linear model for each location (like lmFit from the
limma package), focusing on one specific column (coefficient) of the design matrix. This coeffi-
cient of interest is optionally smoothed. Subsequently, a permutation can be used to test is formed
for this specific coefficient.

The simplest way to use permutations to create a null distribution is to set B. If the number of
samples is large this can be set to a large number, such as 1000. Note that this will be slow and
we have therefore provided parallelization capabilities. In cases were the user wants to define the
permutations, for example cases in which all possible permutations can be enumerated, these can
be supplied via the permutation argument.

Note that the function permits the matrix X to have more than two columns. This can be useful
for those wanting to fit models that try to adjust for confounders, such as age and sex. However,
when X has columns other than those representing an intercept term and the covariate of interest,
the permutation test approach is not recommended. The function will run but give a warning.
A method based on the bootstrap for linear models of Efron and Tibshirani [1] may be more
appropriate but this is not currently implemented.

12

Faster bumphunting with multiple cores

bumphunter can be speeded up by using multiple cores. We use the foreach package which
allows different parallel "back-ends" that will distribute the computation across multiple cores in
a single machine, or across multiple machines in a cluster. The most straight-forward usage, illus-
trated below, involves multiple cores on a single machine. See the foreach documentation for
more complex use cases, as well as the packages doParallel and doSNOW (among others). Fi-
nally, we use doRNG to ensure reproducibility of setting the seed within the parallel computations.

In order to use the foreach package we need to register a backend, in this case a multicore
machine with 2 cores.

> library(doParallel)
> registerDoParallel(cores = 2)

bumphunter will now automatically use this backend

> tab <- bumphunter(y, X, chr, pos, cl, cutoff=.5, B=250, verbose = TRUE)
> tab

a 'bumps' object with 13 bumps

References

[1] B. Efron and R.J. Tibshirani.

[2] Andrew E Jaffe, Peter Murakami, Hwajin Lee, Jeffrey T Leek, M Daniele Fallin, Andrew P
Feinberg, and Rafael A Irizarry. Bump hunting to identify differentially methylated regions
in epigenetic epidemiology studies. International Journal of Epidemiology, 41(1):200–209,
2012.

Cleanup

This is a cleanup step for the vignette on Windows; typically not needed for users.

> bumphunter:::foreachCleanup()

13

SessionInfo

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, stats4, utils

• Other packages: BiocGenerics 0.56.0, GenomicRanges 1.62.0, IRanges 2.44.0,

S4Vectors 0.48.0, Seqinfo 1.0.0, bumphunter 1.52.0, doParallel 1.0.17, doRNG 1.8.6.2,
foreach 1.5.2, generics 0.1.4, iterators 1.0.14, locfit 1.5-9.12, rngtools 1.5.2

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, Biobase 2.70.0,

BiocIO 1.20.0, BiocParallel 1.44.0, Biostrings 2.78.0, DBI 1.2.3, DelayedArray 0.36.0,
GenomicAlignments 1.46.0, GenomicFeatures 1.62.0, KEGGREST 1.50.0, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RCurl 1.98-1.17, RSQLite 2.4.3, Rsamtools 2.26.0,
S4Arrays 1.10.0, SparseArray 1.10.0, SummarizedExperiment 1.40.0, XML 3.99-0.19,
XVector 0.50.0, abind 1.4-8, bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, cachem 1.1.0,
cigarillo 1.0.0, cli 3.6.5, codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0,
digest 0.6.37, fastmap 1.2.0, grid 4.5.1, httr 1.4.7, lattice 0.22-7, matrixStats 1.5.0,
memoise 2.0.1, png 0.1-8, restfulr 0.0.16, rjson 0.2.23, rlang 1.1.6, rtracklayer 1.70.0,
tools 4.5.1, vctrs 0.6.5, yaml 2.3.10

14

