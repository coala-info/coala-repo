Introduction to iBBiG

Aedin Culhane, Daniel Gusenleitner

October 30, 2025

1 iBBiG

Iterative Binary Bi-clustering of Gene sets (iBBiG) is a bi-clustering algorithm optimized for discovery of over-
lapping biclusters in spare binary matrices of data (Gusenleitner et al. in review).

We have optimized this method for the discovery of modules in matrices of discretized p-values from gene
set enrichment analysis (GSA) of hundreds of datasets. However, it could be applied to any binary (1,0) matrix,
such as discretized p-values from any sources of binary data. We apply iBBiG to meta-GSA to enable integrated
analysis over hundreds of gene expression datasets. By integrating data at the levels of GSA results, we avoid
the need to match probes/genes across multiple datasets, making large scale data integration a tractable problem.
iBBiG scales well with the dimensions of meta-datasets and is tolerant to noise characteristic of genomic
data. It outperformed other traditional clustering approaches (Hierarchical clustering, k-means) or biclustering
methods (bimax, fabia, coalesce) when applied to simulated data.

2 Application to simulated dataset

To demonstrate iBBiG, we will use a simulated binary dataset of 400 rows x 400 columns (as described by
Gusenleitner et al.), in which a 1 indicates a positive association (or p < 0.05) between a gene set (row) and the
results of a pairwise test between clinical covariates (column), and a 0 represents a lack of association.

To simulate random noise characteristically observed in genomic data, 10% random background noise (value

of 1) was introduced into the matrix.

The matrix was seeded with seven artificial modules or bi-clusters (M1-M7; Figure 1) by assigning associa-
tions (value of 1) to its column and row pairs. To replicate the expected properties of real data, seeded modules
partially overlapped in columns, in rows and in both rows and columns simultaneously. M1 gene sets overlap
with most other modules with the exception of M3. M2 has overlapping pairwise tests with modules M4-7.

Artificial modules also have highly varying sizes and aspect ratios, including "wide" modules driven by a
large number of pairwise tests and only a few gene sets and "tall" modules like M1 which consist of 25 pairwise
tests and a large number of gene sets (n = 250). This latter type of module might represent a complex, well-
characterized biological process such as proliferation.

In a real data set the signal strength will vary both between and within modules. Variance between modules
was simulated by imposing random noise (1 -> 0 replacement) with different signal strengths on the modules
(Figure 1). Within a module, we expect to see a few strong signals (gene sets associated with all pairwise tests)
and many weaker signals. Therefore within each module, a noise gradient was also applied so that the first gene
sets had the greatest number of associations (Figure 1). This overlaid noise gradient ranged from 10 to 60% and
varied between modules (Table 1).

To create this simulated data as described in Gusenleitner, et al. use the function makeArtifical which

creates an object of class iBBiG, an extension of biclust.

> library(iBBiG)
> binMat<-makeArtificial()

1

[1] "***** Summary of Design Matrix ******"

250

Rows Cols DensityLow DenistyHigh
0.9
0.8
0.8
0.9
0.8
0.9
0.6

25
75 175
50
50
40
40
30
30
20
20
40
40

0.4
0.4
0.5
0.4
0.4
0.6
0.5

M1
M2
M3
M4
M5
M6
M7

Cluster sizes in new iBBiG (Biclust) data object
Number of Modules: 7
Rows
Columns

250

175

40

75

40

25

50

50

30

30

20

20

40

40

> binMat

An object of class iBBiG

Number of Clusters found: 7

First

5 Cluster scores and sizes:

Cluster Score
Number of Rows:
Number of Columns:

> plot(binMat)

[,1] [,2] [,3] [,4] [,5]
NA
30
30

NA
75
25 175

NA
50
50

NA
40
40

NA
250

2

The class BiClust contains the number of clusters and two logical matrices which indicate whether a row or

column are present in the cluster.

> str(binMat)

Formal class 'iBBiG' [package "iBBiG"] with 8 slots

: num [1:400, 1:400] 1 1 1 1 1 1 0 0 1 1 ...

..@ Seeddata
.. ..- attr(*, "dimnames")=List of 2
.. .. ..$ : chr [1:400] "sig_1" "sig_2" "sig_3" "sig_4" ...
.. .. ..$ : chr [1:400] "cov_1" "cov_2" "cov_3" "cov_4" ...
..@ RowScorexNumber: num[0 , 0 ]
..@ Clusterscores : num(0)
..@ Parameters
.. ..$ designMatrix: num [1:7, 1:6] 251 51 1 46 81 106 151 51 251 1 ...
.. .. ..- attr(*, "dimnames")=List of 2
.. .. .. ..$ : chr [1:7] "M1" "M2" "M3" "M4" ...
.. .. .. ..$ : chr [1:6] "startC" "startR" "endC" "endR" ...
.. ..$ nRow
.. ..$ nCol
..@ RowxNumber
..@ NumberxCol

: num 400
: num 400
: logi [1:400, 1:7] FALSE FALSE FALSE FALSE FALSE FALSE ...
: logi [1:7, 1:400] FALSE FALSE TRUE FALSE FALSE FALSE ...

:List of 3

3

PhenotypesGene SignaturesM1M2M3M4M5M6M7Module SizeNumber (Phenotypes)050100150..@ Number
..@ info

: int 7
: list()

> Number(binMat)

[1] 7

> RowxNumber(binMat)[1:2,]

[,1] [,2] [,3] [,4] [,5]

[,7]
[1,] FALSE FALSE TRUE FALSE FALSE FALSE FALSE
[2,] FALSE FALSE TRUE FALSE FALSE FALSE FALSE

[,6]

> NumberxCol(binMat)[,1:2]

[,1] [,2]
[1,] FALSE FALSE
[2,] FALSE FALSE
[3,]
TRUE TRUE
[4,] FALSE FALSE
[5,] FALSE FALSE
[6,] FALSE FALSE
[7,] FALSE FALSE

The matrix RowxNumber is a logical matrix having a number of rows equal to that of binMat and a number
of columns equal to the number of detected clusters. NumberxCol is reversed; this class has a row count equal to
the number of clusters and a column count of the number of columns of binMat.

To run iBBiG on this artificial binary matrix, simply call the function iBBiG. The function plot and

statClust will provide a visual representation and statistical summary of the results of the cluster analysis.

> res<- iBBiG(binMat@Seeddata, nModules=10)

Module: 1 ... done
Module: 2 ... done
Module: 3 ... done
Module: 4 ... done
Module: 5 ... done
Module: 6 ... done
Module: 7 ... done
Module: 8 ... done
Module: 9 ... done
Module: 10 ... done

> plot(res)

4

If you wish to compare two iBBiG or Biclust results, for example a prediction and a gold standard (GS),
the function JIdist will calculate the Jaccard Index distance between two Biclust or iBBiG result objects. By
default, it calculates the distances between each column. Setting margin = row or margin = both will cause
the function to calculate instead the JI distance between the rows, or an average of rows/columns.

By default, RfunctionJIdist returns a data.frame with 2 columns, the column n indicating which cluster was
the best match (maximum JI) to each cluster of the second iBBiG object (GS). The column JI contains the
Jaccard Index distance between the columns of these two clusters. If best = F ALSE, the function will return
the distance matrix instead of the best match.

> JIdist(res,binMat)

JI
n
GS_1 1 1.000
GS_2 2 0.989
GS_3 4 1.000
GS_4 3 1.000
GS_5 5 0.900
GS_6 9 1.000
GS_7 6 0.700

> JIdist(res,binMat, margin="col", best=FALSE)

5

PhenotypesGene SignaturesM1M2M3M4M5M6M7M8M9M10M 1M 2M 3M 4M 5M 6M 7M 8M 9M 10Module SizeNumber (Phenotypes)050100150M 1M 2M 3M 4M 5M 6M 7M 8M 9M 10Module ScorePairwise Test Score05001000150020002500M 1M 2M 3M 4M 5M 6M 7M 8M 9M 10Weighted ScoreWeighted Score0246GS_2

GS_3

GS_1

GS_4
1.00000000 0.000000000 0.00000000 0.00000000
M 1
0.00000000 0.988571429 0.00000000 0.18994413
M 2
0.00000000 0.194444444 0.05882353 1.00000000
M 3
0.00000000 0.000000000 1.00000000 0.05882353
M 4
0.00000000 0.154285714 0.00000000 0.04687500
M 5
0.00000000 0.160000000 0.00000000 0.00000000
M 6
0.01190476 0.335227273 0.00000000 0.14942529
M 7
0.00000000 0.017142857 0.00000000 0.00000000
M 8
M 9
0.00000000 0.114285714 0.00000000 0.00000000
M 10 0.15384615 0.005586592 0.00000000 0.00000000

GS_5

GS_6

GS_7
0.00000000 0.0000000 0.0000000
M 1
0.16666667 0.1156069 0.2312139
M 2
0.07692308 0.0000000 0.0000000
M 3
0.00000000 0.0000000 0.0000000
M 4
0.90000000 0.1190476 0.0000000
M 5
0.00000000 0.0000000 0.7000000
M 6
0.08433735 0.1111111 0.1235955
M 7
0.00000000 0.0000000 0.0750000
M 8
M 9
0.11111111 1.0000000 0.0000000
M 10 0.00000000 0.0000000 0.0000000

> JIdist(res,binMat, margin="col")

JI
n
GS_1 1 1.000
GS_2 2 0.989
GS_3 4 1.000
GS_4 3 1.000
GS_5 5 0.900
GS_6 9 1.000
GS_7 6 0.700

> JIdist(res,binMat, margin="row")

JI
n
GS_1 1 0.764
GS_2 2 0.800
GS_3 4 0.860
GS_4 3 0.767
GS_5 5 0.619
GS_6 9 0.760
GS_7 6 0.558

> JIdist(res,binMat, margin="both")

JI
n
GS_1 1 1.764
GS_2 2 1.789
GS_3 4 1.860
GS_4 3 1.767

6

GS_5 5 1.519
GS_6 9 1.760
GS_7 6 1.258

To view the code of the function JIdist

> showMethods(JIdist)
> getMethod(iBBiG:::JIdist, signature(clustObj = "iBBiG", GS = "iBBiG"))
> getMethod("JIdist", signature(clustObj="iBBiG", GS="iBBiG"))

To extract performance statistics between two iBBiG results, use analyzeClust, which will take a single
iBBiG result object or a list of objects and compare these to a gold standard (another iBBiG or biclust object).
Again results can be based on matches to the best row, column or both.

> analyzeClust(res,binMat)

GS_1
GS_2
GS_3
GS_4
GS_5
GS_6
GS_7

GS_1
GS_2
GS_3
GS_4
GS_5
GS_6
GS_7

GS_1
GS_2
GS_3
GS_4
GS_5
GS_6
GS_7

GS_1
GS_2
GS_3
GS_4
GS_5
GS_6
GS_7

[1] "list"
Run n

1 1 1.000 191
1 2 0.989
1 4 1.000
1 3 1.000
1 5 0.900
1 9 1.000
1 6 0.700

JI nRow nCol col-accuracy col-sensitivity
1.000
0.989
1.000
1.000
0.900
1.000
0.700

25
60 173
50
43
40
36
27
38
20
24
28
41

1.000
0.995
1.000
1.000
0.993
1.000
0.970

col-specificity col-PPV col-NPV row-accuracy
0.853
1
0.963
1
0.983
1
0.975
1
0.960
1
0.985
1
0.943
1

1.000
0.991
1.000
1.000
0.992
1.000
0.968

1
1
1
1
1
1
1

row-sensitivity row-specificity row-PPV row-NPV
0.718
0.956
0.980
0.981
0.989
0.997
0.969

1.000
1.000
1.000
0.917
0.684
0.792
0.707

1.000
1.000
1.000
0.992
0.968
0.987
0.967

0.764
0.800
0.860
0.825
0.867
0.950
0.725

> analyzeClust(res,binMat, margin="col")

[1] "list"
Run n

1 1 1.000 191
1 2 0.989
1 4 1.000
1 3 1.000
1 5 0.900
1 9 1.000
1 6 0.700

JI nRow nCol col-accuracy col-sensitivity
1.000
0.989
1.000
1.000
0.900
1.000
0.700

25
60 173
50
43
40
36
27
38
20
24
28
41

1.000
0.995
1.000
1.000
0.993
1.000
0.970

7

col-specificity col-PPV col-NPV row-accuracy
0.853
1
0.963
1
0.983
1
0.975
1
0.960
1
0.985
1
0.943
1

1.000
0.991
1.000
1.000
0.992
1.000
0.968

1
1
1
1
1
1
1

row-sensitivity row-specificity row-PPV row-NPV
0.718
0.956
0.980
0.981
0.989
0.997
0.969

1.000
1.000
1.000
0.992
0.968
0.987
0.967

1.000
1.000
1.000
0.917
0.684
0.792
0.707

0.764
0.800
0.860
0.825
0.867
0.950
0.725

GS_1
GS_2
GS_3
GS_4
GS_5
GS_6
GS_7

GS_1
GS_2
GS_3
GS_4
GS_5
GS_6
GS_7

Again to view the code of the function, you could:

> showMethods(analyzeClust)
> getMethod("analyzeClust", signature(clustObj="iBBiG", GS="iBBiG"))

The structure of iBBiG differs from BiClust in that it contains ClusterScores. ClusterScores are the scores for

each module. RowScoreNumber are the scores for each row in the cluster. Seeddata is a copy of binMat.

> str(binMat)

Formal class 'iBBiG' [package "iBBiG"] with 8 slots

:List of 3

: num [1:400, 1:400] 1 1 1 1 1 1 0 0 1 1 ...

..@ Seeddata
.. ..- attr(*, "dimnames")=List of 2
.. .. ..$ : chr [1:400] "sig_1" "sig_2" "sig_3" "sig_4" ...
.. .. ..$ : chr [1:400] "cov_1" "cov_2" "cov_3" "cov_4" ...
..@ RowScorexNumber: num[0 , 0 ]
..@ Clusterscores : num(0)
..@ Parameters
.. ..$ designMatrix: num [1:7, 1:6] 251 51 1 46 81 106 151 51 251 1 ...
.. .. ..- attr(*, "dimnames")=List of 2
.. .. .. ..$ : chr [1:7] "M1" "M2" "M3" "M4" ...
.. .. .. ..$ : chr [1:6] "startC" "startR" "endC" "endR" ...
.. ..$ nRow
.. ..$ nCol
..@ RowxNumber
..@ NumberxCol
..@ Number
..@ info

: num 400
: num 400
: logi [1:400, 1:7] FALSE FALSE FALSE FALSE FALSE FALSE ...
: logi [1:7, 1:400] FALSE FALSE TRUE FALSE FALSE FALSE ...
: int 7
: list()

> RowScorexNumber(res)[1:2,]

M 1 M 2 M 3

sig_1
sig_2

0
0

0
0

0 29.12712
0 33.04621

M 4 M 5 M 6 M 7 M 8 M 9 M 10
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

> Clusterscores(res)

8

M 1

M 3
1909.84107 2853.19547 578.37157
M 8
54.21241

M 7
235.28734 192.23491

M 6

M 2

M 4
736.70702
M 9
199.87072

M 5
280.04831
M 10
66.69940

> Seeddata(res)[1:2,1:2]

sig_1
sig_2

cov_1 cov_2
1
0

1
1

There are also the slots for info and Parameters which can contain additional user-entered information about

the analysis. We can subset or reorder the results like so:

> res[1:3]

An object of class iBBiG

Number of Clusters found: 3

First

3 Cluster scores and sizes:

Cluster Score
Number of Rows:
Number of Columns:

> res[c(4,2,1)]

M 2

M 1

M 3
1909.841 2853.195 578.3716
36.0000
40.0000

60.000
25.000 173.000

191.000

An object of class iBBiG

Number of Clusters found: 3

First

3 Cluster scores and sizes:
M 2

M 1
736.707 2853.195 1909.841
Cluster Score
191.000
Number of Rows:
60.000
25.000
Number of Columns: 50.000 173.000

43.000

M 4

> res[1, drop=FALSE]

An object of class iBBiG

There was one cluster found with Score 1909.841 and

191 Rows and 25 columns

3 Using biclust functions

An object from iBBiG extends the class biclust and can therefore use methods available to a biclust object. For
example, there are several plot functions in BiClust

> class(res)
> par(mfrow=c(2,1))
> drawHeatmap2(res@Seeddata, res, number=4)

9

> biclustmember(res,res@Seeddata)
> biclustbarchart(res@Seeddata, Bicres=res)
> plotclust(res, res@Seeddata)

Statistical measures of biclustering performance including the Chia and Karuturi Function, Coherence mea-

sures and F Statistics are available within the biclust R packages.

There are function to process data, binarize or discretize data. For example, given gene expression data we

can binarize or discretize the data matrix as follows and this can be input into iBBiG

> data(BicatYeast)
> BicatYeast[1:5,1:5]
> binarize(BicatYeast[1:5,1:5], threshold=0.2)
> discretize(BicatYeast[1:5,1:5])

The sub-matrices of each cluster can be extracted from the original matrix, using the function bicluster

> Modules<-bicluster(res@Seeddata, res, 1:3)
> str(Modules)

List of 3

$ Bicluster1: num [1:191, 1:25] 1 1 1 1 1 1 1 1 1 1 ...

..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:191] "sig_51" "sig_52" "sig_53" "sig_54" ...
.. ..$ : chr [1:25] "cov_251" "cov_252" "cov_253" "cov_254" ...

$ Bicluster2: num [1:60, 1:173] 0 1 1 1 1 1 0 0 1 1 ...

..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:60] "sig_251" "sig_252" "sig_253" "sig_254" ...
.. ..$ : chr [1:173] "cov_51" "cov_52" "cov_53" "cov_54" ...

$ Bicluster3: num [1:36, 1:40] 1 1 0 1 1 1 1 1 1 1 ...

..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:36] "sig_46" "sig_47" "sig_48" "sig_49" ...
.. ..$ : chr [1:40] "cov_46" "cov_47" "cov_48" "cov_49" ...

> Modules[[1]][1:3,1:4]

sig_51
sig_52
sig_53

cov_251 cov_252 cov_253 cov_254
1
1
1

1
1
1

1
1
1

1
1
1

To write results to a file use the following:

> writeBiclusterResults("Modules.txt", res, bicName="Output from iBBiG with default parameters", geneNames=rownames(res@Seeddata), arrayNames=colnames(res@Seeddata))
>

4 Session Info

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

10

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, grid, methods, stats, utils

• Other packages: MASS 7.3-65, biclust 2.0.3.1, colorspace 2.1-2, iBBiG 1.54.0, lattice 0.22-7

• Loaded via a namespace (and not attached): R6 2.6.1, RColorBrewer 1.1-3, Rcpp 1.1.0, S7 0.2.0,

additivityTests 1.1-4.2, ade4 1.7-23, class 7.3-23, cli 3.6.5, compiler 4.5.1, dichromat 2.0-0.1, dplyr 1.1.4,
farver 2.1.2, flexclust 1.5.0, generics 0.1.4, ggplot2 4.0.0, glue 1.8.0, gtable 0.3.6, lifecycle 1.0.4,
magrittr 2.0.4, modeltools 0.2-24, parallel 4.5.1, pillar 1.11.1, pkgconfig 2.0.3, purrr 1.1.0, rlang 1.1.6,
scales 1.4.0, stats4 4.5.1, tibble 3.3.0, tidyr 1.3.1, tidyselect 1.2.1, tools 4.5.1, vctrs 0.6.5, xtable 1.8-4

References

11

