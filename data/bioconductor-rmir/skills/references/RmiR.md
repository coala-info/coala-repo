RmiR package vignette

Francesco Favero*

October 30, 2017

Contents

1 Introduction

2 Coupling miRNA and gene expression data

2.1 Default parameters . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Change the at.least parameter . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . .
2.3 Diﬀerent genes identiﬁcation.
2.4 Results by platform probe ID . . . . . . . . . . . . . . . . . . . . . . . .

3 Correlation between series

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1 Expected results
3.2 The function RmiRtc . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Plot and visualization of the results

4.1 SVG output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Plot of single experiment . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.3 Plot a time course experiment . . . . . . . . . . . . . . . . . . . . . . . .

1

2
3
3
4
5

6
6
6

7
7
7
9

1 Introduction

RmiR is an R package for the analysis of microRNA and gene expression microarrays.
The goal of this package is to couple microRNA and gene expression data (coming from
the same RNA). We match miRNAs to corresponding gene targets using the criteria
applied by diﬀerent databases. The package uses various databases of microRNA targets
from the RmiR.Hs.miRNA package:

(cid:136) mirBase http://microrna.sanger.ac.uk/targets/v5/

*favero.francesco@gmail.com

1

(cid:136) targetScan http://www.targetscan.org/

(cid:136) miRanda from microrna.org http://www.microrna.org/microrna/

(cid:136) tarBase http://diana.cslab.ece.ntua.gr/tarbase/

(cid:136) mirTarget2 from mirDB http://mirdb.org/miRDB/download.html

(cid:136) PicTar http://pictar.mdc-berlin.de/

To use the package a list of miRNA and a list of genes are required, both with the
respective expression values. It is more interesting to have two series, one for microRNA
expression and another for gene expression, relative to diﬀerent times or diﬀerent treat-
ments. In this case RmiR is useful to investigate the correlation between miRNA/Target
couples.

It is also possible to use the databases to simply retrieve the targets or the miRNAs,

given a list of miRNAs or a list of genes respectively.

The package also includes some tools to visualise the results for coupled data and
for time series experiments. The RSVGTipsDevice[1] package is required which creates
plots in SVG format, that one can visualize with a SVG viewer or in a browser like
Mozilla Firefox, Safari and others.

For more details about using the databases have a look at RmiR.Hs.miRNA package

vignette.

> vignette("RmiR.Hs.miRNA")

2 Coupling miRNA and gene expression data

An analysis with RmiR starts giving to the read.mir function the list of miRNAs and
the list of genes with the right annotation.

Leaving the default values the function searches in targetscan and pictar and prints

only the couples present in both databases.

>
+
+
>
>
+
+
>

genes <- data.frame(genes=c("A_23_P171258","A_23_P150053", "A_23_P150053",
"A_23_P150053", "A_23_P202435", "A_24_P90097",
"A_23_P127948"))

genes$expr <- c(1.21, -1.50, -1.34, -1.45, -2.41, -2.32, -3.03)
mirna <- data.frame(mirna=c("hsa-miR-148b", "hsa-miR-27b", "hsa-miR-25",

mirna$expr <- c(1.23, 3.52, -2.42, 5.2, 2.2, -1.42, -1.23, -1.20, -1.37)

"hsa-miR-181a", "hsa-miR-27a", "hsa-miR-7",
"hsa-miR-32", "hsa-miR-32", "hsa-miR-7"))

2

> genes

genes expr
1 A_23_P171258 1.21
2 A_23_P150053 -1.50
3 A_23_P150053 -1.34
4 A_23_P150053 -1.45
5 A_23_P202435 -2.41
6 A_24_P90097 -2.32
7 A_23_P127948 -3.03

> mirna

mirna expr
1 hsa-miR-148b 1.23
2 hsa-miR-27b 3.52
3
hsa-miR-25 -2.42
4 hsa-miR-181a 5.20
5 hsa-miR-27a 2.20
hsa-miR-7 -1.42
6
hsa-miR-32 -1.23
7
hsa-miR-32 -1.20
8
hsa-miR-7 -1.37
9

2.1 Default parameters

The default parameters are set to search the items present in both TargetScan and
in PicTar databases, and the genes object is identiﬁed by probe name.
If it is not
speciﬁed, the function makes the average of the diﬀerent probes identifying the same
gene, computing also the coeﬃcient of variation (CV). If there is just one result, no
average can be done, so the CV will be NA.

> library(RmiR)
> read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db")

gene_id mature_miRNA mirExpr
NA ABCB7
1.230
ADM
NA
5.200
ADM
hsa-miR-25 -2.420
NA
ADM
hsa-miR-32 -1.215 0.01745943

22 hsa-miR-148b
133 hsa-miR-181a
133
133

mirCV symbol geneExpr geneCV
NA
NA
NA
NA

1.21
-3.03
-3.03
-3.03

1
4
5
6

2.2 Change the at.least parameter

We can select the result present in at least one database:

> read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db", at.least=1)

mirCV symbol geneExpr
1.210

gene_id mature_miRNA mirExpr
NA ABCB7
1.230
ADD3
NA
2.200
ADD3
NA
3.520
ADM
NA
5.200
ADM
hsa-miR-25 -2.420
NA
ADM
hsa-miR-32 -1.215 0.01745943
NA ACTA2
NA ACTA2

22 hsa-miR-148b
59 hsa-miR-27a
59 hsa-miR-27b
133 hsa-miR-181a
133
133
120 hsa-miR-27a
120 hsa-miR-27b

2.200
3.520

1
2
3
4
5
6
23
61

geneCV
NA
-1.450 0.05724023
-1.450 0.05724023
NA
-3.030
NA
-3.030
-3.030
NA
-2.365 0.02690893
-2.365 0.02690893

3

Searching with at.least equal to 1 basically gives the union of the results from the
selected databases.

2.3 Diﬀerent genes identiﬁcation.

If the result is annotated by another identiﬁcation than the platform probe ID, we can
specify the annotation identiﬁers with the parameter id.

The possible values are ”probes”, ”genes”, ”alias”, ”ensembl” and ”unigene”. An ex-

ample with entrez gene id identiﬁers:

> genes.e <- genes
> genes.e$gene_id <- c(22, 59, 59, 59, 120, 120, 133)
> genes.e <- genes.e[, c("gene_id", "expr")]
> genes.e

gene_id expr
22 1.21
59 -1.50
59 -1.34
59 -1.45
120 -2.41
120 -2.32
133 -3.03

1
2
3
4
5
6
7

> read.mir(genes = genes.e, mirna = mirna, annotation = "hgug4112a.db",
+

id="genes")

gene_id mature_miRNA mirExpr
NA ABCB7
1.230
ADM
NA
5.200
ADM
hsa-miR-25 -2.420
NA
ADM
hsa-miR-32 -1.215 0.01745943

22 hsa-miR-148b
133 hsa-miR-181a
133
133

mirCV symbol geneExpr geneCV
NA
NA
NA
NA

1.21
-3.03
-3.03
-3.03

1
4
5
6

Another example mixing oﬃcial HGNC symbols and others aliases:

> genes.a <- genes
> genes.a$alias <- c("ABCB7", "ADD3", "ADDL", "ADD3", "AAT6", "ACTA2", "ADM")
> genes.a <- genes.a[, c("alias", "expr")]
> genes.a

alias expr
1 ABCB7 1.21
2 ADD3 -1.50
3 ADDL -1.34

4

4 ADD3 -1.45
5 AAT6 -2.41
6 ACTA2 -2.32
ADM -3.03
7

> read.mir(genes = genes.a, mirna = mirna, annotation = "hgug4112a.db",
+

id="alias")

gene_id mature_miRNA mirExpr
NA ABCB7
1.230
ADM
NA
5.200
ADM
hsa-miR-25 -2.420
NA
ADM
hsa-miR-32 -1.215 0.01745943

22 hsa-miR-148b
133 hsa-miR-181a
133
133

mirCV symbol geneExpr geneCV
NA
NA
NA
NA

1.21
-3.03
-3.03
-3.03

1
4
5
6

2.4 Results by platform probe ID

If we are using the object genes annotated by microarray probes, sometimes we do
not need the average of the results, for example when we would like to test each probe
separately. In this case, it is preferable to have just the result as it is, annotated by
probe. This will obviously cause much redundancy:

> read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db", at.least=1,
+

id.out="probes")

mirCV

gene_id mature_miRNA mirExpr
NA A_23_P171258
1.230
NA A_23_P150053
2.200
NA A_23_P150053
2.200
NA A_23_P150053
2.200
NA A_23_P150053
3.520
NA A_23_P150053
3.520
NA A_23_P150053
3.520
NA A_23_P127948
5.200
hsa-miR-25 -2.420
NA A_23_P127948
hsa-miR-32 -1.215 0.01745943 A_23_P127948
NA A_23_P202435
NA A_24_P90097
NA A_23_P202435
NA A_24_P90097

22 hsa-miR-148b
59 hsa-miR-27a
59 hsa-miR-27a
59 hsa-miR-27a
59 hsa-miR-27b
59 hsa-miR-27b
59 hsa-miR-27b
133 hsa-miR-181a
133
133
120 hsa-miR-27a
120 hsa-miR-27a
120 hsa-miR-27b
120 hsa-miR-27b

probe_id geneExpr geneCV
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

1.21
-1.50
-1.34
-1.45
-1.50
-1.34
-1.45
-3.03
-3.03
-3.03
-2.41
-2.32
-2.41
-2.32

2.200
2.200
3.520
3.520

1
2
3
4
5
6
7
8
9
10
21
31
101
11

5

3 Correlation between series

3.1 Expected results

The control of target genes by microRNAs occurs at post-trascriptional
miRNA binds to its target gene and inhibits translation.

level. The

In some cases the mRNA is degraded by the miRNA annealing, but this is not
necessary to stop the translation process. In the ﬁrst case it is possible to see a decrease
of the gene expression, while in the other cases we shouldn’t observe any particular trend
or even an increase of the expression value.

With a time series of microarray data it is possible to see if a target of one or more
miRNAs gradually changes its expression with the equal or opposite change of the rela-
tive miRNA. Looking at the correlation between the trend of the diﬀerent miRNA/target
couples, we can obtain the correlated and the anti-correlated couples. This does not
mean that there is a sure biological relevance, but it could give some hints for further
inverstigation.

3.2 The function RmiRtc

To use the function RmiRtc we need two or more objects created with the function
read.mir.

> data(RmiR)
> res1<- read.mir(gene=gene1, mirna=mir1, annotation="hgug4112a.db",verbose=TRUE)

In targetscan database there are 13 genes and 35 microRNA which are in your files.

--------------------------------------------

In pictar database there are 7 genes and 27 microRNA which are in your files.

--------------------------------------------

> res2<- read.mir(gene=gene2, mirna=mir2, annotation="hgug4112a.db",verbose=TRUE)

In targetscan database there are 12 genes and 23 microRNA which are in your files.

--------------------------------------------

In pictar database there are 6 genes and 24 microRNA which are in your files.

--------------------------------------------

> res3<- read.mir(gene=gene3, mirna=mir3, annotation="hgug4112a.db",verbose=TRUE)

In targetscan database there are 13 genes and 35 microRNA which are in your files.

--------------------------------------------

In pictar database there are 7 genes and 27 microRNA which are in your files.

--------------------------------------------

6

> res_tc <- RmiRtc(timeline=c("res1", "res2", "res3"),
+

timevalue=c(12, 24, 48))

We can decide to ﬁlter the object by a correlation and/or a gene expression threshold:

> res_fil <- readRmiRtc(res_tc, correlation=-0.9, exprLev=1,
+
> res_fil$reps

annotation="hgug4112a.db")

symbol miRNAs gene_id
351
3
3
7436
1 201161

APP
2
3 VLDLR
1 CENPV

The function readRmiRtc ﬁlter the genes by the absolute expression value set in the
arguments, and returns a list with the genes ranked by the number of miRNAs satisfying
the correlation threshold.

To see in details the expression of miRNA and genes it is possible to plot the various

trends, or print the desired results:

> cbind
+

(res_fil$couples, res_fil$geneExpr,

res_fil$mirExpr)[res_fil$couples$gene_id==351 & res_fil$cor<=-0.9, ]

gene_id mature_miRNA

12

48
351 hsa-miR-20a 0.71 -0.95 -1.67 0.32 1.73 2.12
351 hsa-miR-20b 0.71 -0.95 -1.67 0.06 1.10 1.61
hsa-miR-93 0.71 -0.95 -1.67 0.30 1.25 1.19
351

24

24

48

12

22
17
19

4 Plot and visualization of the results

4.1 SVG output

In order to present the results, the pachage uses a tool to visualize the data.

With the package RSVGTipsDevice we can plot the data for a single miRNA and
gene coupled experiment or for a series of experiments. The resulting image is in svg
format with the properties to have dynamic tips and hyperlinks.

4.2 Plot of single experiment

> plotRmiRtc(res1[res1$gene_id==351,],svgname="res1_351.svg",svgTips=T)

7

Figure 1: Visualization in a browser with SVG support of the results of the read.mir
function selecting a single gene target and its miRNA

8

4.3 Plot a time course experiment

> plotRmiRtc(res_fil,gene_id=351)

Setting the coordinate of the legend:

> plotRmiRtc(res_fil, gene_id=351, legend.y=0, legend.x=30)

9

15202530354045−1012APP and its miRNAs expression trendsTimeExpression> plotRmiRtc(res_fil, gene_id=351, legend.y=0, legend.x=30, svgTips=T)

10

15202530354045−1012APP and its miRNAs expression trendsTimeExpressionAPPhsa−miR−20ahsa−miR−20bhsa−miR−93Figure 2: Visualization in a browser with SVG support of a time course experiment of
the selected gene with hyperlinks and tips

11

References

[1] Tony Plate. RSVGTipsDevice: An R SVG graphics device with dynamic tips and

hyperlinks, 2009. R package version 1.0-1.

12

