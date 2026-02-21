An Introduction to CCPROMISE

Xueyuan Cao, Stanley Pounds

October 10, 2016

1

Introduction

CCPROMISE, Canonical correlation with PROjection onto the Most Interesting Sta-
tistical Evidence, is a general procedure to integrate two forms of genomic features
that exhibit a specific biologically interesting pattern of association with multiple phe-
notypic endpoint variables. In biology, one type of genomic feature tends to regulate
the other types. For example, DNA methylation regulates gene expression. Biological
knowledge of the endpoint variables is used to define a vector that represents the bio-
logically most interesting values for a set of association statistics. The CCPROMISE
performs one hypothesis test for each gene, and is flexible to accommodate two type of
genomic features with various types of endpoints.

In this document, we describe how to perform CCPROMISE procedure using hy-

pothetical example data sets provided with the package.

2 Requirements

The CCPROMISE package extends our former PROMISE package to integrate two
forms of molecular data with multiple biologically related endpoints in gene level or
probe set level. The understanding of ExpressionSet is a prerequiste to perform the
CCPROMISE procedure. Due to the internal handling of multiple endpoints, the con-
sistency of ExpressionSet is assumed. The detailed requirements are illustrated below.
Load the CCPROMISE package and the example data sets: exmplESet, exmplM-

Set, exmplGeneSet, and exmplPat into R.

> library(CCPROMISE)
> data(exmplESet)
> data(exmplMSet)
> data(exmplGeneSet)
> data(exmplPat)

The ExpressionSet should contain at least two components: exprs (array data) and
phenoData (endpoint data). The subject id and order of ESet and MSet should be same.
exprs is a data frame with column names representing the array identifiers (IDs) and

1

row names representing the probe (genomic feature) IDs. phenoData is an Annotated-
DataFrame with column names representing the endpoint variables and row names
representing array. The array IDs of phenoData and exprs should be matched.

The association pattern definition is critical. The prior biological knowledge is re-
quired to define the vector that represents the biologically most interesting values for
statistics. In this hypothetical example, we are interested in identifying genomic fea-
tures that are negatively associated with drug level to kill 50% cells, negatively asso-
ciated with disease, and negatively associated with rate of events. The three endpoints
are represented in three rows as shown below:

> exmplPat

stat.coef

stat.func
-0.33 spearman.rstat
-0.33 spearman.rstat
-0.33

endpt.vars
LC50
MRD22
jung.rstat EFSTIME,EFSCENSOR

1
2
3

3 CCPROMISE Analysis

As mentioned in section 2, the ExpressionSet of two forms of genomic data and pat-
tern definition are required by CCPROMISE procedure. The code below performs a
CCPROMISE analysis at gene level with fast permutation based on negative binomial.

> test1 <- CCPROMISE(geneSet=exmplGeneSet,
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

ESet=exmplESet,
MSet=exmplMSet,
promise.pattern=exmplPat,
strat.var=NULL,
prlbl=c('LC50', 'MRD22', 'EFS', 'PR3'),
EMlbl=c("Expr", "Methyl"),
nbperm=TRUE,
max.ntail=10,
nperms=100,
seed=13)

Gene level result:

> head(test1$PRres)

Gene Expr_LC50.Stat Expr_MRD22.Stat Expr_EFS.Stat
0.096304751
DDR1
1
0.194535613
RFC2
2
-0.014700892
3
PAX8
0.002563084
4 GUCA1A
-0.041141660
5 UBE1L
-0.071381381
THRA
6

0.06515531
0.11057641
-0.05050530
0.03538941
-0.05714667
-0.05223717

0.02537225
-0.19860902
-0.17035650
-0.11857641
0.06880280
-0.05640794

Expr_PR3.Stat Methyl_LC50.Stat Methyl_MRD22.Stat

2

1 -0.062277435
2 -0.035501001
0.078520899
3
0.026874639
4
0.009828512
5
0.060008831
6

-0.006796137
0.049870701
-0.187767560
0.034627937
NaN
0.011165082

0.02987477
0.07273351
-0.06772779
0.15896498
NaN
-0.04654276

0.120588984

Methyl_EFS.Stat Methyl_PR3.Stat

0.01013990
0.05561824
-0.10627160
0.09232005
NaN
0.01189162

PR3.Stat
-0.011072845 -0.036675140
-0.059407483 -0.047454242
0.099554942
-0.095304321 -0.034214841
0.009828512
0.033918758
Expr_LC50.Pval Expr_MRD22.Pval Expr_EFS.Pval
0.2222222
0.0000000
0.9047619
0.9411765
0.5000000
0.1923077

0.3888889
0.0800000
0.4761905
0.9411765
0.7500000
0.5769231

0.7222222
0.1600000
0.1904762
0.7058824
0.6666667
0.6923077

NaN
0.007828685

Expr_PR3.Pval Methyl_LC50.Pval Methyl_MRD22.Pval
0.7222222
0.2400000
0.3571429
0.0000000
NA
0.4230769

0.9444444
0.5600000
0.1904762
0.8823529
NA
1.0000000

0.3333333
0.6000000
0.2619048
0.9411765
0.8333333
0.2307692

Methyl_EFS.Pval Methyl_PR3.Pval

0.8888889
0.6000000
0.2380952
0.1764706
NA
0.8846154

0.8333333 0.5555556
0.3600000 0.4000000
0.1071429 0.1190476
0.1176471 0.5882353
NA 0.8333333
0.9615385 0.3846154

PR3.Pval nperm
18
25
84
17
12
26

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

1
2
3
4
5
6

The code below performs a prbPROMISE analysis at probe pair level with fast

permutation.

> test2 <- PrbPROMISE(geneSet=exmplGeneSet,
+
+
+
+
+
+
+
+

ESet=exmplESet,
MSet=exmplMSet,
promise.pattern=exmplPat,
strat.var=NULL,
prlbl=c('LC50', 'MRD22', 'EFS', 'PR3'),
EMlbl=c("Expr", "Methyl"),
nbperm=TRUE,
max.ntail=10,

3

+
+

nperms=100,
seed=13)

Probe pair level correlation result at p value cut off 0.05:

> head(test2$CORres)

Gene

Expr

Methyl

1007_s_at*cg00466425 "DDR1" "1007_s_at" "cg00466425"
1007_s_at*cg01386080 "DDR1" "1007_s_at" "cg01386080"
1007_s_at*cg01936707 "DDR1" "1007_s_at" "cg01936707"
1007_s_at*cg02313535 "DDR1" "1007_s_at" "cg02313535"
1007_s_at*cg02376496 "DDR1" "1007_s_at" "cg02376496"
1007_s_at*cg03270204 "DDR1" "1007_s_at" "cg03270204"

Spearman.rstat Spearman.p

1007_s_at*cg00466425 "0.3467"
1007_s_at*cg01386080 "0.2624"
1007_s_at*cg01936707 "0.4245"
1007_s_at*cg02313535 "0.1978"
1007_s_at*cg02376496 "0.3069"
1007_s_at*cg03270204 "-0.2394"

"1.46642e-05"
"0.0011758053"
"7.56e-08"
"0.0150390162"
"0.0001359269"
"0.0031454459"

Probe pair level PROMISE result of probe pair at p value cut off 0.05 as above:

> head(test2$PRres)

1 1007_s_at*cg00466425
2 1007_s_at*cg01386080
3 1007_s_at*cg01936707
4 1007_s_at*cg02313535
5 1007_s_at*cg02376496
6 1007_s_at*cg03270204

Gene Expr_LC50.Stat Expr_MRD22.Stat
-0.1044313
-0.1044313
-0.1044313
-0.1044313
-0.1044313
-0.1044313

-0.02436901
-0.02436901
-0.02436901
-0.02436901
-0.02436901
-0.02436901

Expr_EFS.Stat Expr_PR3.Stat Methyl_LC50.Stat
-0.03802601
0.07732165
-0.12352788
0.07732165
-0.14957974
0.07732165
0.11877059
0.07732165
-0.02394829
0.07732165
0.05799370
0.07732165

-0.1031647
-0.1031647
-0.1031647
-0.1031647
-0.1031647
-0.1031647

Methyl_MRD22.Stat Methyl_EFS.Stat Methyl_PR3.Stat
-0.05730805
0.03403780
0.03440224
-0.11330114
-0.10560041
0.07377326

0.092249971
-0.009996237
0.069168489
0.165563303
0.167249598
-0.133609780

0.11770019
0.03141073
-0.02279546
0.05556954
0.17349992
-0.14570372

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

PR3.Stat Expr_LC50.Pval Expr_MRD22.Pval Expr_EFS.Pval

4

1 0.01000680
2 0.05567973
3 0.05586195
4 -0.01798974
5 -0.01413938
6 0.07554746

1.0000000
0.9032258
0.9473684
1.0000000
1.0000000
0.8620690

0.1666667
0.1935484
0.2631579
0.1818182
0.1666667
0.1896552

0.2500000
0.1935484
0.3157895
0.2727273
0.2500000
0.1724138

Expr_PR3.Pval Methyl_LC50.Pval Methyl_MRD22.Pval
0.1666667
0.8709677
0.4210526
0.0000000
0.0000000
0.1206897

0.7500000
0.2903226
0.3157895
0.5454545
0.7500000
0.6724138

0.1666667
0.2903226
0.3157895
0.1818182
0.1666667
0.2586207

Methyl_EFS.Pval Methyl_PR3.Pval

0.08333333
0.61290323
0.84210526
0.54545455
0.08333333
0.12068966

0.50000000 0.8333333
0.61290323 0.3225806
0.52631579 0.5263158
0.18181818 0.9090909
0.08333333 0.8333333
0.34482759 0.1724138

PR3.Pval nperm
12
31
19
11
12
58

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

5

