SEPA: Single-Cell Gene Expression Pattern
Analysis

Zhicheng Ji

Hongkai Ji

Johns Hopkins University,
Baltimore, Maryland, USA
zji4@jhu.edu

Johns Hopkins University,
Baltimore, Maryland, USA
hji@jhsph.edu

April 24, 2017

Contents

1 Introductions

1

2 Identify and Visualize Pattern for True Experiment Time Points

2

3 Identify and Visualize Pattern for Pseudo Temporal Cell Or-

dering

4 GO analysis

5 SEPA GUI

6 Reference

1

Introductions

6

8

11

12

Single-cell high-throughput transcriptomics is a powerful approach to study the
heterogeneity of gene expression activities on single-cell level. Compared to
traditional bulk transcriptomics experiments, single-cell RNA-seq signiﬁcantly
increase the resolution of gene expression and thus can lead to many new bio-
logical discoveries. Many of the single-cell transcriptomics researches focus on
the diﬀerentiation of various cell types and hope to ﬁnd how the expression of
genes and key regulatory factors changes over the diﬀerentiation process [1,2].
These single-cell RNA-seq data often contain the gene expression proﬁles of
cells extracted from multiple experimental time points. There is also existing
computatioin tool such as Monocle [3] that uses unsupervised machine learning
methods to order whole-transcriptome proﬁles of single cells along ’pseudotime’,

1

a hypothesized time course which can quantitatively measure the real biological
process of diﬀerentiation. This pseudotime course is then used to study how
gene expressions change over the diﬀerentiation process. Such pseudo time cell
ordering concept provides a novel method of exploring single-cell RNA-seq data.
If one has available true experimental time or pseudo temporal cell ordering
information, a natural question to ask is what expression patterns do these
genes have along the true or pseudo time axis. The expression patterns could
be constant, monotonic change, or some transition patterns like ﬁrst increasing
followed by decreasing in gene expressions. It would be even more interesting
to investigate what kind of biological functions do genes with similar expression
patterns share. These results may provide deeper insights into the biological
process and guidelines for researchers to study the function of individual genes.
Such kind of analysis is unique for single-cell RNA-seq data, since the bulk
RNA-seq experiments usually do not have enough sample size to obtain a robust
estimate of the patterns while single-cell RNA-seq data often contain hundreds
of cells for each experiment time point. Pseudo time cell ordering is also a
unique feature of single-cell RNA-seq.
However, currently there is no available computational tool for such kind of
down stream analysis. In Monocle [3], gene expression patterns are clustered
and identiﬁed manually, which is somehow arbitrary. Thus we propose SEPA:
a systematic and comprehensive tool to study the gene expression patterns for
single-cell RNA-seq. SEPA is designed for general single-cell RNA-seq data.
SEPA takes input true experiement time or pseudo temporal cell ordering infor-
mation. SEPA ﬁrst computationally identify the gene expression patterns using
a set of t-tests (for true experiment time) or segmented linear regression (for
pseudo temporal cell ordering). SEPA then performs GO analysis on genes with
similar expression patterns. A special kind of GO analysis with moving windows
is also available for pseudo temporal cell ordering information. Finally, users
also have the option to identify genes with diﬀerent gene expression patterns in
true experiment time or pseudo-time axis. This function is important if users
want to ﬁnd genes with so-called ”Simpsons Paradox”.
SEPA comes with a powerful Graphical User Interface written in R shiny pack-
age. It allows users without prior programming knowledge to conveniently iden-
tify and explore the gene expression patterns. SEPA has an online user interface
which is freely available at https://zhiji.shinyapps.io/SEPA/. However, the on-
line user interface only allows one concurrent user so it is recommended that
users launch SEPA on their own computers.

2

Identify and Visualize Pattern for True Ex-
periment Time Points

The function truetimepattern can be used to identify gene expression patterns
given true experiment time points. The output of the function will be a named
vector of patterns. Note that appropriate transformations on gene expression

2

matrix (e.g. log2 transformation) should be done before calling this function.

library(SEPA)

##
##
##

library(topGO)

IQR, mad, sd, var, xtabs

BiocGenerics
parallel

## Loading required package:
## Loading required package:
##
’BiocGenerics’
## Attaching package:
## The following objects are masked from ’package:parallel’:
##
clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##
clusterExport, clusterMap, parApply, parCapply, parLapply,
##
##
parLapplyLB, parRapply, parSapply, parSapplyLB
## The following objects are masked from ’package:stats’:
##
##
## The following objects are masked from ’package:base’:
##
##
##
##
##
##
##
##
## Loading required package:
## Loading required package:
## Welcome to Bioconductor
##
##
##
##
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:

Filter, Find, Map, Position, Reduce, anyDuplicated, append,
as.data.frame, cbind, colMeans, colSums, colnames, do.call,
duplicated, eval, evalq, get, grep, grepl, intersect,
is.unsorted, lapply, lengths, mapply, match, mget, order,
paste, pmax, pmax.int, pmin, pmin.int, rank, rbind, rowMeans,
rowSums, rownames, sapply, setdiff, sort, table, tapply,
union, unique, unsplit, which, which.max, which.min

Vignettes contain introductory material; view with
’browseVignettes()’.
’citation("Biobase")’, and for packages ’citation("pkgname")’.

GO.db
AnnotationDbi
stats4
IRanges
S4Vectors

To cite Bioconductor, see

graph
Biobase

’S4Vectors’

3

SparseM

expand.grid

## The following object is masked from ’package:base’:
##
##
## Loading required package:
##
## Attaching package:
’SparseM’
## The following object is masked from ’package:base’:
##
##
##
## groupGOTerms:
##
## Attaching package:
## The following object is masked from ’package:IRanges’:
##
##

backsolve

’topGO’

members

GOBPTerm, GOMFTerm, GOCCTerm environments built.

library(ggplot2)
library(org.Hs.eg.db)
data(HSMMdata)
truepattern <- truetimepattern(HSMMdata,truetime)
head(truepattern)

## ENSG00000000460.12 ENSG00000001630.11 ENSG00000003989.12
"down_constant"
##
"down_constant"
ENSG00000011426.6
## ENSG00000005448.12
"down_constant"
"down_constant"
##

"up_constant"
ENSG00000010292.8
"down_constant"

Use patternsummary function to check the number of genes for each pattern.

patternsummary(truepattern)

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
## 11
## 12
## 13

constant
constant_down
constant_down_constant
constant_up
constant_up_constant
down_constant
down_constant_down
down_constant_up
down_up
down_up_constant
up_constant
up_constant_down
up_constant_up

Pattern Number
129
1
6
2
17
196
1
4
1
3
146
1
1

4

## 14
## 15

up_down_constant
up_down_up

9
1

Visualize the mean gene expression using the pseudotimevisualize function.

truetimevisualize(HSMMdata,truetime,"ENSG00000122180.4")

## Warning in if (mode == "mean") {:
and only the first element will be used
## Warning in if (mode == "mean") {:
and only the first element will be used
## Warning in if (mode == "mean") {:
and only the first element will be used
## Warning in if (mode == "mean") {:
and only the first element will be used

the condition has length > 1

the condition has length > 1

the condition has length > 1

the condition has length > 1

5

llll0.51.01.52.0T0T24T48T72Experiment TimeMean Expression ValuesGenelENSG00000122180.43

Identify and Visualize Pattern for Pseudo Tem-
poral Cell Ordering

The function pseudotimepattern can be used to identify gene expression patterns
given pseudo-time. The pseudo-time can be obtained by the Monocle package.
Note that if there are multiple cell paths, users should perform the analysis one
path at a time. The output of the function will be a list. Note that appropriate
transformations on gene expression matrix (e.g. log2 transformation) should be
done before calling this function.

data(HSMMdata)
pseudopattern <- pseudotimepattern(HSMMdata,pseudotime)

## [1] "Running davies test"
## [1] "Determining potential transition point positions"
## [1] "Fitting segmented regression models"

Use patternsummary function to check the number of genes for each pattern.

patternsummary(pseudopattern)

##
## 1 constant_down
## 2
constant_up
## 3 down_constant
down_up
## 4
up_constant
## 5
up_down
## 6
up
## 7
down
## 8
constant
## 9

Pattern Number
9
27
131
28
49
64
132
72
6

Check the transition points for transition patterns.

head(pseudopattern$pattern$constant_up)

##
## ENSG00000219481.6
## ENSG00000130741.5
## ENSG00000079482.11
## ENSG00000197746.9
## ENSG00000119669.3
## ENSG00000185585.15

transpoint

LCI

UCI
8.495 4.416 12.58
9.727 2.571 16.88
10.850 4.110 17.59
11.500 4.512 18.48
12.230 5.900 18.55
14.090 8.143 20.03

Visualize the gene expression using the pseudotimevisualize function. For vi-
sualizing the expression of a single gene, a scatter plot will be displayed. The

6

black color of the line stands for constant pattern, green stands for increasing
pattern and red stands for decreasing pattern. The blue line on the top of the
plot shows the estimated mean and 95% conﬁdence interval of the transition
points.

pseudotimevisualize(pseudopattern,"ENSG00000122180.4")

For visualizing the expression of multiple genes, a heatmap will be displayed.
The black dots and line segments show the estimated mean and 95% conﬁdence
interval of the transition points.

pseudotimevisualize(pseudopattern,c("ENSG00000122180.4","ENSG00000108821.9"))

7

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0.02.55.07.510.0020406080Pseudo−timeGene ExpressionENSG00000122180.44 GO analysis

The function patternGOanalysis will perform GO analysis for genes with the
same expression patterns. The background gene list is all genes in the expression
proﬁle (518 genes in this example)
GO analysis for the true experiment time points. The result is a list. Each
element is a data.frame of GO analysis results.

patternGOanalysis(truepattern,type=c("constant_up","constant_down"),termnum = 5)

## $constant_up
GO.ID
##
## 1 GO:0034097
## 2 GO:0010288
## 3 GO:0033591

response to cytokine
response to lead ion
response to L-ascorbic acid

Term Annotated
30
1
1

8

llENSG00000108821.9ENSG00000122180.4050100150200CellPredicted Expression−2−1012value2
2

2
1
1
1
1

0.13
0.00
0.00
0.01
0.01

Significant Expected classicFisher
0.0041
0.0043
0.0043
0.0086
0.0086

## 4 GO:0002480 antigen processing and presentation of e...
## 5 GO:0043583
ear development
##
## 1
## 2
## 3
## 4
## 5
##
## $constant_down
##
GO.ID
methylation
## 1 GO:0032259
metabolic process
## 2 GO:0008152
## 3 GO:0008150
biological_process
## 4 GO:0000002 mitochondrial genome maintenance
## 5 GO:0000003
reproduction
##
## 1
## 2
## 3
## 4
## 5

Expected classicFisher
0.03
0.69
1.00
1.00
1.00

0.03
0.69
1.00
0.00
0.13

Term Annotated Significant
1
14
1
320
1
462
0
1
0
62

GO analysis for the pseudo time.

patternGOanalysis(pseudopattern,type=c("constant_up","constant_down"),termnum = 5)

## $constant_up
##
GO.ID
muscle system process
## 1 GO:0003012
muscle contraction
## 2 GO:0006936
## 3 GO:0042692
muscle cell differentiation
## 4 GO:0043403 skeletal muscle tissue regeneration
## 5 GO:0061061
muscle structure development
##
## 1
## 2
## 3
## 4
## 5
##
## $constant_down
GO.ID
##
## 1 GO:0007267
## 2 GO:0007268
## 3 GO:0051216

Expected classicFisher
4.7e-05
0.00011
0.00011
0.00014
0.00015

cell-cell signaling
chemical synaptic transmission
cartilage development

1.57
1.30
1.30
0.16
2.33

9

Term Annotated Significant
8
29
7
24
7
24
3
3
9
43

Term Annotated Significant
3
29
2
10
2
10

## 4 GO:0098916 anterograde trans-synaptic signaling
## 5 GO:0099536
synaptic signaling
##
## 1
## 2
## 3
## 4
## 5

Expected classicFisher
0.010
0.011
0.011
0.011
0.011

0.50
0.17
0.17
0.17
0.17

10
10

2
2

In additional to tranditional GO analysis, SEPA also provides a speciﬁc kind of
GO analysis for genes with transition patterns. For example for all genes with
pattern of constant then up, SEPA ﬁrst orders all genes according to the tran-
sition points. Then SEPA performs GO analysis interatively on the ﬁrst-20th
genes, then 11th-30th genes, then 18th-37th genes (See example below). In this
way users can explore the continuous change of biological functions associated
with genes with similar expression patterns.

(GOresults <- windowGOanalysis(pseudopattern,type="constant_up",windowsize = 20, termnum=5))

Term Annotated
3
11
4
4
4

2
3
2
2
2

0.12
0.43
0.16
0.16
0.16

Significant Expected classicFisher
0.0042
0.0068
0.0082
0.0082
0.0082

## $`1-20`
##
GO.ID
skeletal muscle tissue regeneration
## 1 GO:0043403
## 2 GO:0006937
regulation of muscle contraction
## 3 GO:0030511 positive regulation of transforming grow...
## 4 GO:0042246
tissue regeneration
## 5 GO:1903846 positive regulation of cellular response...
##
## 1
## 2
## 3
## 4
## 5
##
## $`8-27`
GO.ID
##
## 1 GO:0003012
muscle system process
## 2 GO:0061061
muscle structure development
## 3 GO:0006936
muscle contraction
muscle cell differentiation
## 4 GO:0042692
## 5 GO:0051146 striated muscle cell differentiation
##
## 1
## 2
## 3
## 4
## 5

Expected classicFisher
4.2e-06
1.1e-05
1.4e-05
1.4e-05
2.9e-05

1.19
1.77
0.99
0.99
0.74

10

Term Annotated Significant
8
29
9
43
7
24
7
24
6
18

windowGOvisualize function can be used to visualize the GO analysis results
from windowGOanalysis function.

windowGOvisualize(GOresults)

5 SEPA GUI

In addition to the basic command lines tools discussed above, SEPA provides a
powerful which provides more comprehensive and convenient functions for gene
expression pattern analysis. For example, users can easily transform raw gene
expression data and convert gene identiﬁers before the analysis; save the result
tables and plots of publication quality; identify genes with diﬀerent expression
patterns on true time and pseudo-time axis. Users are encouraged to use SEPA
GUI.

11

GO:0003012muscle system processGO:0006937regulation of muscle contractionGO:0043403skeletal muscle tissue regenerationGO:0061061muscle structure development1−208−27IntervalRank123456value6 Reference

[1] Bendall, S. C., Simonds, E. F., Qiu, P., El-ad, D. A., Krutzik, P. O., Finck,
R., ... & Nolan, G. P. (2011). Single-cell mass cytometry of diﬀerential im-
mune and drug responses across a human hematopoietic continuum. Science,
332(6030), 687-696.
[2] Tang, F., Barbacioru, C., Bao, S., Lee, C., Nordman, E., Wang, X., ... &
Surani, M. A. (2010). Tracing the derivation of embryonic stem cells from the
inner cell mass by single-cell RNA-Seq analysis. Cell stem cell, 6(5), 468-478.
[3] Trapnell, C., Cacchiarelli, D., Grimsby, J., Pokharel, P., Li, S., Morse, M.,
... & Rinn, J. L. (2014). The dynamics and regulators of cell fate decisions are
revealed by pseudotemporal ordering of single cells. Nature biotechnology.

12

