Bioconductor mAPKL Package

Argiris Sakellariou1,2

[1cm] 1 Biomedical Informatics Unit, Biomedical Research Foundation of the Academy
of Athens, Athens, Greece
[0cm] 2 Department of Informatics and Telecommunications, National and Kapodis-
trian Univ. of Athens, Athens, Greece
[0cm] argisake@gmail.com

October 30, 2018

Contents

1

2

Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Identiﬁcation of deferentially expressed genes . . . . .

2.1

2.2

Breast cancer data . . . . . . . . . . . . . . . . . . . . . .

Data normalization and transformation. . . . . . . . . . .

2.3 mAPKL gene selection . . . . . . . . . . . . . . . . . . . .

2.4

Building and evaluating classiﬁcation models . . . . . . .

3

Advanced usage of the package . . . . . . . . . . . . . .

3.1

3.2

Annotation analysis . . . . . . . . . . . . . . . . . . . . . .

Network characteristics . . . . . . . . . . . . . . . . . . .

2

2

2

4

4

6

8

8

9

4 Reporting . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12

5

Session info . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12

6 Reference . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14

Bioconductor mAPKL Package

1

Introduction

The mAPKL bioconductor R package implements a hybrid gene selection method,
which is based on the hypothesis that among the statistically signiﬁcant genes
in a ranked list, there should be clusters of genes that share similar biological
functions related to the investigated disease.Thus, instead of keeping a number
of N top ranked genes, it would be more appropriate to deﬁne and keep a
number of gene cluster exemplars.

The proposed methodology combines ﬁltering and cluster analysis to select
a small yet highly discriminatory set of non-redundant genes. Regarding the
ﬁltering step, a multiple hypothesis testing approach from multtest r-package
(maxT) is employed to rank the genes of the training set according to their
diﬀerential expression.Then the top N genes (e.g. N = 200) are reserved for
cluster analysis. First the index of Krzanowski and Lai as included in the
ClusterSim r-package is applied on the disease samples of the training set to
determine the number of clusters. The Krzanowski and Lai index is deﬁned
p Wk when choosing the number of clusters
by DIF F (k) = (k − 1)
(cid:12)
(cid:12)
(k) to maximize the quantity KL(k) =
(cid:12). The Wk denotes the
within-cluster sum of squared errors.

DIF F (k)
DIF F(k+1)

p Wk−1 − k

(cid:12)
(cid:12)
(cid:12)

2

2

Finally, cluster analysis is performed with the aid of Aﬃnity Propagation (AP)
clustering algorithm, which detects n(n = k the Krzanowski and Lai index)
clusters among the top N genes, the so called exemplars.Those n exemplars
are expected to form a classiﬁer that shall discriminate between normal and
disease samples (Sakellariou et al. 2012, BMC Bioinformatics 13:270). This
package implements the pre-mentioned methodology through a core function, the
mAPKL. In the upcoming sections follows a guidance of the included functions
and its functionality through diﬀerential expression analysis scenarios on a breast
cancer dataset (GSE5764) which is part of the mAPKLData package.

2

Identiﬁcation of deferentially expressed genes

2.1 Breast cancer data

Throught this tutorial we utilized a publicly available breast cancer dataset
comprised of 30 samples, where 20 of them represent normal cases and the
remaining 10 samples stand for tumor cases. We ﬁrst load the package and then

2

Bioconductor mAPKL Package

the breast cancer data. Then with the aid of the sampling function we create a
separate training and validation sets where 60% of the samples will be used for
training and the rest 40% of the samples will be used for evaluation purposes.

library(mAPKL)

library(mAPKLData)

data(mAPKLData)

varLabels(mAPKLData)

breast <- sampling(Data=mAPKLData, valPercent=40, classLabels="type", seed=135)

The sampling function returns an S3 class (breast) with two eSet class objects
that nest the relevant training and validation sampes. Those two objects are
used throughout the rest of the analysis.

breast

## $trainData

## ExpressionSet (storageMode: lockedEnvironment)

## assayData: 54675 features, 18 samples

##

element names: exprs

## protocolData: none

## phenoData

##

##

##

sampleNames: GSM134584 GSM134690 ... GSM134695 (18 total)

varLabels: title type

varMetadata: labelDescription

## featureData: none

## experimentData: use 'experimentData(object)'

##

pubMedIds: 17389037

## Annotation: hgu133plus2

##

## $testData

## ExpressionSet (storageMode: lockedEnvironment)

## assayData: 54675 features, 12 samples

##

element names: exprs

## protocolData: none

## phenoData

##

##

sampleNames: GSM134691 GSM134588 ... GSM134692 (12 total)

varLabels: title type

3

Bioconductor mAPKL Package

##

varMetadata: labelDescription

## featureData: none

## experimentData: use 'experimentData(object)'

##

pubMedIds: 17389037

## Annotation: hgu133plus2

2.2 Data normalization and transformation

We perform normalization to the expression values through the preprocess
function.

normTrainData <- preprocess(breast$trainData)

normTestData <- preprocess(breast$testData)

The preprocess function produces a list of several available normalization and
transformation options. Besides density plots per method are produced and
saved to current working directory to assist the user to decide upon which
method to select before proceeding to mAPKL analysis.

attributes(normTrainData)

## $names

## [1] "rawdata"

"mc.normdata"

"z.normdata"

"q.normdata"

## [5] "cl.normdata"

"mcL2.normdata" "zL2.normdata"

"qL2.normdata"

## [9] "clL2.normdata"

The following graph presents the density plots of 8 possible normalization process
with or without log2 transformation. The preprocess function applies all of them
and it is up to the user, which one will engage for the rest of the analysis. In
brief, the available approaches are mean-centering, z-score, quantile, and cyclic
loess. During this case study we will proceed with the expression values folowing
log2 transformation and cyclic loess normalization.

2.3 mAPKL gene selection

In this example we employ the expresion values of log2 transformation and cyclic
loess normalization to proceed with the mAPKL analysis.

4

Bioconductor mAPKL Package

Figure 1: Density plots of normalized intensity values

exprs(breast$trainData) <- normTrainData$clL2.normdata

exprs(breast$testData) <- normTestData$clL2.normdata

out.clL2 <- mAPKL(trObj = breast$trainData, classLabels = "type",

valObj = breast$testData, dataType = 7)

## b=10 b=20 b=30 b=40 b=50 b=60 b=70 b=80 b=90 b=100

## b=110 b=120 b=130 b=140 b=150 b=160 b=170 b=180 b=190 b=200

## b=210 b=220 b=230 b=240 b=250 b=260 b=270 b=280 b=290 b=300

5

Bioconductor mAPKL Package

## b=310 b=320 b=330 b=340 b=350 b=360 b=370 b=380 b=390 b=400

## b=410 b=420 b=430 b=440 b=450 b=460 b=470 b=480 b=490 b=500

## b=510 b=520 b=530 b=540 b=550 b=560 b=570 b=580 b=590 b=600

## b=610 b=620 b=630 b=640 b=650 b=660 b=670 b=680 b=690 b=700

## b=710 b=720 b=730 b=740 b=750 b=760 b=770 b=780 b=790 b=800

## b=810 b=820 b=830 b=840 b=850 b=860 b=870 b=880 b=890 b=900

## b=910 b=920 b=930 b=940 b=950 b=960 b=970 b=980 b=990 b=1000

## Please wait! The (KL) cluster indexing may take several minutes...

## Asking for 15 number of clusters

## fc according to limma

2.4 Building and evaluating classiﬁcation models

After having get the exemplars from mAPKL analysis we build an SVM classiﬁer
to test their discriminatory performance. Regarding the SVM setup, we utilize
a linear kernel for which the cost attribute is infered by the tune.svm function.
however, the user may freely use another kernel and a diﬀerent Cross Validation
approach than 5-folds.

clasPred <- classification(out.clL2@exemplTrain, "type", out.clL2@exemplTest)

## The training set has 12 Negative and 6 Positive samples.

Using

##

k-fold=5 C-V

## ############ THE BEST PARAMETERS TUNING STAGE ##################

## ############# THE TRAINING STAGE ########################

##

## Call:

## svm.default(x = train.mtx, y = lbls, scale = FALSE, type = "C-classification",

kernel = "linear", gamma = best_gamma, cost = best_cost, cross = k_fold)

##

##

##

## Parameters:

##

##

SVM-Type: C-classification

SVM-Kernel: linear

6

Bioconductor mAPKL Package

cost: 2

gamma: 0.125

##

##

##

## Number of Support Vectors:

5

## ############# THE PREDICTION STAGE ######################

##

Test Labels Prediction Labels

0

0

0

1

0

0

0

0

1

1

1

1

## GSM134691

## GSM134588

## GSM134688

## GSM134694

## GSM134697

## GSM134700

## GSM134687

## GSM134709

## GSM134710

## GSM134698

## GSM134689

## GSM134692

0

0

0

0

0

0

0

0

1

1

1

1

## Negative samples: 8

## Positive samples: 4

## TN=7

## FP=1

## TP=4

## FN=0

## AUC=0.94

## Accuracy=92.00

## MCC=0.84

## Specificity=0.88

## Sensitivity=1.00

7

Bioconductor mAPKL Package

The output of the classiﬁcation inform us about the SVM set up, the number of
Support Vectors and ﬁnally show the the predicted labels along with the initial. In
this example there is a validation set diﬀerent from the training set and therefore
we may use the respective labels to obtain the performance characteristcs. The
relevant function metrics called inside the classiﬁcation function, calculates ﬁve
key meassures: the Area Under the ROC curve AUC, the classiﬁcation accuracy,
the Matthews correlation coeﬃcient MCC classiﬁcation meassure, the degree of
true negative’s identiﬁcation Speciﬁcity, and ﬁnally the degree of true positive’s
identiﬁcation Sensitivity.

3

Advanced usage of the package

3.1 Annotation analysis

For each contemporary chip technology, there is a relevant annotation ﬁle, in
which the the user may drag several genome oriented information. Regarding
the breast cancer microarray data, the gene expression values were stored on
Aﬀumetrix gene chips. Using the annotate function, the user may obtain several
info related to probe id, gene symbol, Entrez id, ensembl id, and chromosomal
location.

gene.info <- annotate(out.clL2@exemplars, "hgu133plus2.db")

gene.info@results

##

## 1

## 2

## 3

## 4

## 5

## 6

## 7

## 8

## 9

## 10

PROBEID
215717_s_at
1561358_at
222752_s_at
233922_at
218871_x_at
33323_r_at
244311_at
220932_at
205508_at
209596_at
215180_at

SYMBOL

ENTREZID

ENSEMBL

FBN2

2201 ENSG00000138829

TXLNA

200081 ENSG00000084652

TMEM206

55248 ENSG00000065600

<NA>

<NA>

<NA>

MAP

5q23.3

1p35.2

1q32.3

<NA>

CSGALNACT2

55454 ENSG00000169826

10q11.21

SFN

<NA>

<NA>

SCN1B

MXRA5

2810 ENSG00000175793

1p36.11

<NA>

<NA>

<NA>

<NA>

<NA>

<NA>

6324 ENSG00000105711

19q13.11

25878 ENSG00000101825

Xp22.33

## 11
<NA>
<NA>
## 12 1560638_a_at LOC105375839 105375839 ENSG00000260955

<NA>

<NA>

8q11.23

8

Bioconductor mAPKL Package

## 13 201852_x_at
229947_at
## 14
## 15 221731_x_at

COL3A1

1281 ENSG00000168542

2q32.2

PI15

VCAN

51050 ENSG00000137558

8q21.13

1462 ENSG00000038427 5q14.2-q14.3

We may exploit the output of the annotate function to extent our analysis. For
instance, we may perform pathway analysis on the exemplars. For this purpose
we will utilize the probes2pathways function that utilizes the reactome.db
package.This function employs the probe ids to identify the relevant pathways.

probes2pathways(gene.info)

##

##

##

##

##

##

##

##

##

##

##

R-HSA-1474228

"Homo sapiens: Degradation of the extracellular matrix"

R-HSA-1474244

"Homo sapiens: Extracellular matrix organization"

"Homo sapiens: Extracellular matrix organization"

R-HSA-1474244

R-HSA-1566948

"Homo sapiens: Elastic fibre formation"

R-HSA-1566948

"Homo sapiens: Elastic fibre formation"

R-HSA-2129379

## "Homo sapiens: Molecules associated with elastic fibres"

##

R-HSA-2129379

## "Homo sapiens: Molecules associated with elastic fibres"

3.2 Network characteristics

Regarding the network charcteristics, we compute through the netwAttr function
three diﬀerent types of centralities (degree, closeness, betweenness) and a
meassure for clustering coeﬃcient called transitivity. The degree centrality of a
node refer to the number of connections or edges of that node to other nodes.The
closeness centrality describes the reciprocal accumulated shortest length distance
from a node to all other connected nodes.The betweeness centrality depicts
the number of times a node intervenes along the shortest path of two other
nodes. Transitivity meassures the degree of nodes to create clusters within a
network.For all four network meassures we provide both global and local values.

9

Bioconductor mAPKL Package

Furthermore, we compose an edge list (Node1-Node2-weight) based on the
N top ranked genes. We may exploit that meassures to depict the exemplars’
network characteristics

net.attr <- netwAttr(out.clL2)

wDegreeL <- net.attr@degree$WdegreeL[out.clL2@exemplars]

wClosenessL <- net.attr@closeness$WclosenessL[out.clL2@exemplars]

wBetweenessL <- net.attr@betweenness$WbetweennessL[out.clL2@exemplars]

wTransitivityL <- net.attr@transitivity$WtransitivityL[out.clL2@exemplars]

Global.val <- c(net.attr@degree$WdegreeG, net.attr@closeness$WclosenessG,

net.attr@betweenness$WbetweennessG, net.attr@transitivity$WtransitivityG)

Global.val <- round(Global.val, 2)

exempl.netattr <- rbind(wDegreeL, wClosenessL, wBetweenessL, wTransitivityL)

netAttr <- cbind(Global.val, exempl.netattr)

netAttr <- t(netAttr)

netAttr

##

wDegreeL wClosenessL wBetweenessL wTransitivityL

## Global.val
## 215717_s_at
## 1561358_at
## 222752_s_at
## 233922_at
## 218871_x_at
## 33323_r_at
## 244311_at
## 220932_at
## 205508_at
## 209596_at
## 215180_at
## 1560638_a_at
## 201852_x_at
## 229947_at
## 221731_x_at

330.18

308.35

346.92

327.89

317.58

293.73

338.19

294.80

359.10

309.07

345.13

333.37

368.23

353.34

317.11

331.01

0.02

0.02

0.02

0.02

0.02

0.02

0.02

0.02

0.02

0.02

0.02

0.03

0.02

0.02

0.03

0.02

741.81

886.00

1156.50

0.00

2.00

768.00

0.00

0.00

0.00

4.00

278.00

1440.00

4541.00

15.23

496.00

14.00

0.57

0.14

0.14

0.14

0.15

0.14

0.13

0.15

0.14

0.14

0.14

0.14

0.14

0.15

0.15

0.15

10

Bioconductor mAPKL Package

and identify potential hubs.The calculations of this example are based on the
"clr" network reconstruction method. However, there are for the time being two
more options, including the "aracne.a" and "aracne.m".

# For local degree > global + standard deviation

sdev <- sd(net.attr@degree$WdegreeL)

msd <- net.attr@degree$WdegreeG + sdev

hubs <- wDegreeL[which(wDegreeL > msd)]

hubs

##

##

220932_at 1560638_a_at

359.10

368.23

Finally, we may plot the network for those nodes that their local weighted degree
is greater than Global weithed degree plus 2 times the standard deviation. We
set this rule for both signiﬁcance and illustartion purposes (that edge list has
dimension 604 x 3).

Figure 2: Degree centrality network

sdev <- sd(net.attr@degree$WdegreeL)

ms2d <- net.attr@degree$WdegreeG + 2 * sdev

net <- net.attr@degree$WdegreeL[which(net.attr@degree$WdegreeL >

ms2d)]

idx <- which(net.attr@edgelist[, 1] %in% names(net))

11

Bioconductor mAPKL Package

new.edgeList <- net.attr@edgelist[idx, ]

dim(new.edgeList)

## [1] 604

3

require(igraph)

g = graph.data.frame(new.edgeList, directed = FALSE)

# tkplot(g,layout=layout.fruchterman.reingold)

4

Reporting

The overall analysis is summarized in an html report produced by the report
function. It covers the dataset repsresentation depicting the samples’ names
and their respective class labels, the exemplars section where statistical results
and network characteristcs are included. The classiﬁcation performance section
illustrates the performance metrics achieved in either cross-validation or hold-out
validation.Finally, several annotation info are presented if an annotation analysis
has occured.

5

Session info

sessionInfo()

## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)

## Running under: Ubuntu 16.04.5 LTS

##

## Matrix products: default

## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

##

## locale:

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8

12

Bioconductor mAPKL Package

##

[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

##

## attached base packages:

## [1] stats4

parallel stats

graphics

grDevices utils

datasets

## [8] methods

base

##

## other attached packages:

##

##

[1] igraph_1.2.2
[4] AnnotationDbi_1.44.0 IRanges_2.16.0
[7] mAPKLData_1.13.0

mAPKL_1.12.0

##
## [10] BiocGenerics_0.28.0 knitr_1.20

hgu133plus2.db_3.2.3 org.Hs.eg.db_3.7.0

S4Vectors_0.20.0
Biobase_2.42.0

##

##

##

## loaded via a namespace (and not attached):
jsonlite_1.5
shiny_1.1.0
blob_1.1.1
backports_1.1.2
rmutil_1.1.1

[1] bit64_0.9-7
[4] modeest_2.3.2
[7] highr_0.7
##
## [10] RSQLite_2.1.1
## [13] limma_3.38.0
## [16] manipulateWidget_0.10.0 promises_1.0.1
## [19] htmltools_0.3.6
## [22] pkgconfig_2.0.2
## [25] genefilter_1.64.0
## [28] webshot_0.5.1
## [31] annotate_1.60.0
## [34] magrittr_1.5
## [37] evaluate_0.12
## [40] class_7.3-14
## [43] formatR_1.5
## [46] cluster_2.0.7-1
## [49] kimisc_0.4
## [52] e1071_1.7-0
## [55] RCurl_1.95-4.11
## [58] miniUI_0.1.1.1

httpuv_1.4.5
timeDate_3043.102
reactome.db_1.64.0
later_0.7.5
spatial_7.3-11
mime_0.6
apcluster_1.4.7
tools_3.5.1
stringr_1.3.1
bazar_1.0.10
ade4_1.7-13
timeSeries_3042.102
htmlwidgets_1.3
bitops_1.0-6

splines_3.5.1
BiocManager_1.30.3
yaml_2.2.0
lattice_0.20-35
digest_0.6.18
R2HTML_2.3.2
Matrix_1.2-14
XML_3.98-1.16
xtable_1.8-3
stable_1.1.3
survival_2.43-1
memoise_1.1.0
MASS_7.3-51
BiocStyle_2.10.0
clusterSim_0.47-2
stabledist_0.7-1
compiler_3.5.1
grid_3.5.1
crosstalk_1.0.0
rmarkdown_1.10

13

Bioconductor mAPKL Package

## [61] multtest_2.38.0
## [64] R6_2.3.0
## [67] clue_0.3-56
## [70] stringi_1.2.4
## [73] rgl_0.99.16

DBI_1.0.0
bit_1.1-14
fBasics_3042.89
Rcpp_0.12.19

statip_0.2.0
parmigene_1.0.2
rprojroot_1.3-2
rpart_4.1-13

6

Reference

Sakellariou, A., D. Sanoudou, and G. Spyrou. "Combining Multiple Hypothesis
Testing and Aﬃnity Propagation Clustering Leads to Accurate, Robust
and Sample Size Independent Classiﬁcation on Gene Expression Data. "
BMC Bioinformatics 13 (2012): 270.

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5764

14

Bioconductor mAPKL Package

Figure 3: mAPKL analysis report

15

