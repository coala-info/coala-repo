An Introduction to PROMISE

Stan Pounds, Xueyuan Cao

June 24, 2014

1 Introduction

PROMISE, PROjection onto the Most Interesting Statistical Evidence, is a general pro-
cedure to identify genomic features that exhibit a specific biologically interesting pat-
tern of association with multiple phenotypic endpoint variables. Biological knowledge
of the endpoint variables is used to define a vector that represents the biologically most
interesting values for a set of association statistics. If prior biological knowledge of the
endpoint variables is not available, a projection to point 0 is performed. The PROMISE
performs one hypothesis test for each genomic feature, and is flexible to accommodate
various types of endpoints. In this update, we also incorporte a fast permutation based
on negative binomial sampling strategy, in which further permuation for a gene will
not be performed for a gene with fixed number of success achieved.

In this document, we describe how to perform PROMISE procedure using hypo-

thetical example data sets provided with the package.

2 Requirements

The PROMISE package depends on Biobase and GSEABase. The understanding of
ExpressionSet and GeneSetCollection is a prerequiste to perform the PROMISE pro-
cedure. Due to the internal handling of multiple endpoints, the consistency of Expres-
sionSet and GeneSetCollection is assumed. The detailed requirements are illustrated
below.

Load the PROMISE package and the example data sets: sampExprSet, sampGene-

Set, and phPatt into R.

> library(PROMISE)
> data(sampExprSet)
> data(sampGeneSet)
> data(phPatt)

The ExpressionSet should contain at least two components: exprs (array data) and
phenoData (endpoint data). exprs is a data frame with column names representing the
array identifiers (IDs) and row names representing the probe (genomic feature) IDs.
phenoData is an AnnotatedDataFrame with column names representing the endpoint

1

variables and row names representing array. The array IDs of phenoData and exprs
should be matched.

> arrayData<-exprs(sampExprSet)
> ptData<- pData(phenoData(sampExprSet))
> head(arrayData[, 1:4])

array_3

array_1 array_2

array_4
probe_1 7.594327 6.710827 8.151585 5.885169
probe_2 4.719728 5.611497 5.819049 3.896193
probe_3 8.815163 5.451243 6.670862 7.295233
probe_4 5.187320 5.142358 6.105922 5.333343
probe_5 4.102526 2.655307 4.139362 1.801595
probe_6 5.415526 4.498429 4.393805 5.219712

> head(ptData)

drugLevel residualDisease

array_1 2.486889
array_2 2.931522
array_3 2.569262
array_4 2.157207
array_5 1.649005
array_6 2.795997

obsTime obsCensor strat
2
2
2
1
2
1

3 0.6117827
3 1.2657796
3 1.6318570
2 0.3879765
3 0.5763599
3 0.5474852

1
1
0
0
1
0

> all(colnames(arrayData)==rownames(ptData))

[1] TRUE

The GeneSetCollection should be extractable in the following way. The probe IDs

should be a subset of probe IDs of exprs.

> GS.data<-NULL
> for (i in 1:length(sampGeneSet)){
tt<-sampGeneSet[i][[1]]
+
this.name<-unlist(geneIds(tt))
+
this.set<-setName(tt)
+
+
this.data<- cbind.data.frame(featureID=as.character(this.name),
+
+
+ }
> sum(!is.element(GS.data[,1], rownames(arrayData)))==0

setID=rep(as.character(this.set), length(this.name)))

GS.data<-rbind.data.frame(GS.data, this.data)

[1] TRUE

The association pattern definition is critical. The prior biological knowledge is re-
quired to define the vector that represents the biologically most interesting values for
statistics. If prior biological knowledge of the endpoint variables cannot be assumed,

2

an arbitrary stat.coef can be used as it will be ignored with proj0=TRUE. In this hypo-
thetical example, we are interested in identifying genomic features that are positively
associated with active drug level, negatively associated with minimum disease, and
positively associated with survival. The three endpoints are represented in three rows
as shown below:

> phPatt

Association 1
Association 2
Association 3

stat.coef

stat.func
1 spearman.rstat
-1 spearman.rstat

endpt.vars
drugLevel
residualDisease
jung.rstat obsTime,obsCensor

1

3 PROMISE Analysis

As mentioned in section 2, the ExpressionSet and pattern definition are required by
PROMISE procedure. GeneSetCollection is required if a gene set enrichment analysis
(GSEA) is to be performed within the PROMISE analysis.

The code below performs a PROMISE analysis without GSEA. As mentioned

above, GeneSetCollection is not needed. The gene set result is NULL.

> test1 <- PROMISE(exprSet=sampExprSet,
+
+
+
+
+
+
+
+

geneSet=NULL,
promise.pattern=phPatt,
strat.var=NULL,
proj0=FALSE,
nbperm=FALSE,
max.ntail=10,
seed=13,
nperms=100)

Gene level (genomic feature) result:

> gene.res<-test1$generes
> head(gene.res)

probeid drugLevel.stat residualDisease.stat
-0.4410378
0.1083797
-0.3069893
0.1812378
0.3725875
-0.1796821

0.50745310
-0.05129198
0.34392723
-0.21510307
-0.43215514
0.06213032

1 probe_1
2 probe_2
3 probe_3
4 probe_4
5 probe_5
6 probe_6

obsTime.obsCensor.stat PROMISE.stat drugLevel.perm.p
0.00
0.72
0.00

-0.328713893
0.050025633
-0.277173083

0.20659234
-0.03654867
0.12458114

1
2
3

3

4
5
6

1
2
3
4
5
6

1
2
3
4
5
6

0.003140076
0.346205081
-0.201508221

-0.13106692
-0.15284585
0.01343473

0.19
0.01
0.63

residualDisease.perm.p obsTime.obsCensor.perm.p
0.00
0.64
0.07
0.99
0.00
0.18

0.00
0.42
0.02
0.21
0.03
0.14

PROMISE.perm.p
0.00
0.65
0.08
0.05
0.03
0.86

Gene set level result:

> set.res<-test1$setres
> head(set.res)

NULL

The code below performs a PROMISE analysis with GSEA and using fast permu-
tation. As mentioned above, GeneSetCollection is required. sampGeneSet, a GeneSet-
Collection, is passed as an argument to PROMISE.

> test2 <- PROMISE(exprSet=sampExprSet,
geneSet=sampGeneSet,
+
promise.pattern=phPatt,
+
strat.var=NULL,
+
proj0=FALSE,
+
nbperm=TRUE,
+
max.ntail=10,
+
seed=13,
+
nperms=100)
+

Gene level (genomic feature) result:

> gene.res2<-test2$generes
> head(gene.res2)

probeid drugLevel.stat residualDisease.stat
-0.4410378
0.1083797
-0.3069893

0.50745310
-0.05129198
0.34392723

1 probe_1
2 probe_2
3 probe_3

4

4 probe_4
5 probe_5
6 probe_6

-0.21510307
-0.43215514
0.06213032

0.1812378
0.3725875
-0.1796821

obsTime.obsCensor.stat PROMISE.stat drugLevel.perm.p
0.00
0.72
0.00
0.19
0.01
0.63

-0.328713893
0.050025633
-0.277173083
0.003140076
0.346205081
-0.201508221

0.20659234
-0.03654867
0.12458114
-0.13106692
-0.15284585
0.01343473

residualDisease.perm.p obsTime.obsCensor.perm.p
0.00
0.64
0.07
0.99
0.00
0.18

0.00
0.42
0.02
0.21
0.03
0.14

PROMISE.perm.p nperms
100
100
100
100
100
100

0.00
0.65
0.08
0.05
0.03
0.86

1
2
3
4
5
6

1
2
3
4
5
6

1
2
3
4
5
6

Gene set level result:

> set.res2<-test2$setres
> head(set.res2)

1 GeneSet 1
2 GeneSet 2
3 GeneSet 3
4 GeneSet 4
5 GeneSet 5
6 GeneSet 6

setid drugLevel.stat residualDisease.stat
0.28204640
0.15382306
0.18092662
0.13631292
0.06539079
0.08478505

0.30998611
0.18012248
0.19852231
0.07289261
0.11745341
0.08167737

1
2
3
4
5
6

1
2

obsTime.obsCensor.stat PROMISE.stat drugLevel.perm.p
0.0000000
0.0000000
0.0600000
0.6888889
0.4700000
0.6956522

0.13032699
0.09124962
0.06608593
0.04299261
0.06327372
0.03234743

0.20105155
0.13759326
0.20620859
0.12875576
0.09114311
0.09922607

residualDisease.perm.p obsTime.obsCensor.perm.p
0.0200000
0.1500000

0.0000000
0.0200000

5

0.0600000
0.3111111
0.7100000
0.5217391

3
4
5
6

1
2
3
4
5
6

0.0900000
0.3111111
0.8700000
0.6521739

PROMISE.perm.p nperms
100
100
100
90
100
23

0.0000000
0.0000000
0.3200000
0.7888889
0.2500000
0.9565217

The code below performs a PROMISE analysis with GSEA and using fast per-
mutation without prior knowlege of the three endpoint variables ( proj0=TRUE). As
mentioned above, GeneSetCollection is required. sampGeneSet, a GeneSetCollection,
is passed as an argument to PROMISE.

> test3 <- PROMISE(exprSet=sampExprSet,
geneSet=sampGeneSet,
+
promise.pattern=phPatt,
+
strat.var=NULL,
+
proj0=TRUE,
+
nbperm=TRUE,
+
max.ntail=10,
+
seed=13,
+
nperms=100)
+

Gene level (genomic feature) result:

> gene.res3<-test3$generes
> head(gene.res3)

probeid drugLevel.stat residualDisease.stat
-0.4410378
0.1083797
-0.3069893
0.1812378
0.3725875
-0.1796821

0.50745310
-0.05129198
0.34392723
-0.21510307
-0.43215514
0.06213032

1 probe_1
2 probe_2
3 probe_3
4 probe_4
5 probe_5
6 probe_6

obsTime.obsCensor.stat PROMISE.stat drugLevel.perm.p
0.00
0.72
0.00
0.19
0.01
0.63

-0.328713893
0.050025633
-0.277173083
0.003140076
0.346205081
-0.201508221

0.56007583
0.01687958
0.28935328
0.07912632
0.44543747
0.07675139

1
2
3
4
5
6

residualDisease.perm.p obsTime.obsCensor.perm.p

6

0.00
0.64
0.07
0.99
0.00
0.18

1
2
3
4
5
6

1
2
3
4
5
6

0.00
0.42
0.02
0.21
0.03
0.14

PROMISE.perm.p nperms
100
100
100
100
100
100

0.00
0.74
0.02
0.30
0.00
0.21

Gene set level result:

> set.res3<-test3$setres
> head(set.res3)

1 GeneSet 1
2 GeneSet 2
3 GeneSet 3
4 GeneSet 4
5 GeneSet 5
6 GeneSet 6

setid drugLevel.stat residualDisease.stat
0.28204640
0.15382306
0.18092662
0.13631292
0.06539079
0.08478505

0.30998611
0.18012248
0.19852231
0.07289261
0.11745341
0.08167737

1
2
3
4
5
6

1
2
3
4
5
6

1
2
3
4
5
6

obsTime.obsCensor.stat PROMISE.stat drugLevel.perm.p
0.0000000
0.0000000
0.0000000
0.8400000
0.3400000
0.6229508

0.27817450
0.15129808
0.16602416
0.06543595
0.04097703
0.03950889

0.20105155
0.13759326
0.20620859
0.12875576
0.09114311
0.09922607

residualDisease.perm.p obsTime.obsCensor.perm.p
0.0200000
0.1500000
0.0100000
0.2900000
0.5100000
0.4918033

0.0000000
0.0200000
0.0700000
0.3000000
0.7100000
0.6393443

PROMISE.perm.p nperms
100
100
100
100
100
61

0.0000000
0.0000000
0.0000000
0.3400000
0.8300000
0.8196721

7

