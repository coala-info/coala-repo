Engineering Evaluation by Gene Cat-
egorization of Microarray and RNA-
seq Data with eegc package

Xiaoyuan Zhou1, Guofeng Meng2, Christine Nardini1,3
and Hongkang Mei2

[1em] 1 CAS-MPG Partner Institute for Computational Biology, Shanghai Institutes
for Biological
Sciences, Chinese Acadomy of Sciences; University of Chinese Academy of Sciences;
2 Computational and Modeling Science, PTS China, GSK R&D China, Shanghai;
3 Personalgenomics, Strada Le Grazie 15 - 37134 Verona, Italy
∗Correspondence to zhouxiaoyuan (at) picb.ac.cn

December 21, 2018

Abstract

This package has been developed to evaluate cellular engineering processes
for direct diﬀerentiation of stem cells or conversion (transdiﬀerentiation) of
somatic cells to primary cells based on high throughput gene expression data
screened either by DNA microarray or RNA sequencing. The package takes
gene expression proﬁles as inputs from three types of samples: (i) somatic
or stem cells to be (trans)diﬀerentiated (input of the engineering process), (ii)
induced cells to be evaluated (output of the engineering process) and (iii) target
primary cells (reference for the output). The package performs diﬀerential gene
expression analysis for each pair-wise sample comparison to identify and evaluate
the transcriptional diﬀerences among the 3 types of samples (input, output,
reference). The ideal goal is to have induced and primary reference cell showing
overlapping proﬁles, both very diﬀerent from the original cells.

Using the gene expression proﬁle of original cells versus primary cells, a gene in
the induced cells can either be successfully induced to the expression level of
primary cells, remain inactive as in the somatic cells, or be insuﬃciently induced.
Based on such diﬀerences, we can categorizes diﬀerential genes into three in-
tuitive categories: Inactive, Insuﬃcient, Successful and two additional extreme
states: Over and Reversed representing genes being over (way above/below the
expected level of in/activation) or reversely regulated. By further functional and

Microarray and RNA-seq Data with eegc

gene regulatory network analyses for each of the ﬁve gene categories, the pack-
age evaluates the quality of engineered cells and highlights key molecules that
represent transcription factors (TFs) whose (in)activation needs to be taken
into account for improvement of the cellular engineering protocol, thus oﬀering
not only a quantiﬁcation of the eﬃcacy of the engineering process, but also
workable information for its improvement.

eegc version: 1.8.1 1

1This document
used the vignette
from Bioconductor
package DESeq2 as
knitr template

2

Microarray and RNA-seq Data with eegc

Contents

1

2

3

Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Installing the eegc package. . . . . . . . . . . . . . . . . .

Preparing Input Data . . . . . . . . . . . . . . . . . . . . . .

4 Gene Differential Analysis . . . . . . . . . . . . . . . . . . .

5 Gene Categorization . . . . . . . . . . . . . . . . . . . . . .

6 Gene Expression Pattern Visualization . . . . . . . . . .

3

5

5

6

7

9

7 Quantifying Gene Categories . . . . . . . . . . . . . . . . 10

8

Functional Enrichment Analysis and Visualization . . 11

9 Cell/Tissue-speciﬁc Enrichment Analysis . . . . . . . . 14

10 Evaluation Based on Gene Regulatory Network (GRN)

Analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16

10.1 CellNet-based Cell/Tissue-speciﬁc analysis . . . . . . . . 16

10.2 Cell/Tissue-speciﬁc Transcription Factor Analysis . . . . 17

10.3 Network Topological Analysis and Visualization . . . . . 18

11 Session Info . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20

1

Introduction

Cellular engineering is among the most promising and yet questioned cellular
biology related approaches, and consists of the man-made diﬀerentiation of
pluripotent undiﬀerentiated stem cells into tissue-speciﬁc (primary) cells, mim-
icking the processes naturally occurring during human embryonic development,
and of the direct conversion from somatic to primary cells, which is relatively
eﬃcient and rapid than diﬀerentiation but is limited by incomplete conversion.
One of the earliest issues to be properly addressed in this area is the possibility

3

Microarray and RNA-seq Data with eegc

to quantify and assess the quality of the induced cells, i.e. to measure if/how
the diﬀerentiation process has been successful and the obtained cells are suﬃ-
ciently similar to the target primary cells, for further applications in regenerative
therapy, disease modeling and drug discovery.

The natural approach consists of comparing the transcriptional similarity of
engineered cells to the target primary cells, with a focus on the marker genes
that are speciﬁcally expressed in somatic and primary cells [1]. Indeed, not all
marker genes are successfully induced to the expression level typical of primary
cells, implying imperfections of the reprogrammed cells to an extent that needs
to be quantiﬁed and evaluated.

Indeed, the focus on a selected number of transcription fators (TFs) may be
limiting, and unable to oﬀer alternative solutions to improve an engineering
process. As cells represent a complex and tightly interconnected system, the
failure to activate one or more target genes impacts on a variable number of
interconnected and downstream genes, aﬀecting in turn a number of biological
functions. For this reason the approach we propose is not target-speciﬁc but
systemic and beyond oﬀering a list of TF whose (in)activation needs attention,
can also qualify and quantify the detrimental eﬀects of an imperfect reprogram-
ming on the topology of the gene network and the biological functions aﬀected,
thus oﬀering information on the usability of the obtained cells and suggesting
a potentially broader number of targets to be aﬀected to improve the process.

Based on these observations, we propose -as brieﬂy introduced above- to classify
the genes into ﬁve diﬀerent categories which describe the states of the genes
upon (trans)diﬀerentiation. The Successful category is represented by the genes
whose expression in the engineered cells is successfully induced to a level similar
to the target primary cells; conversely the Inactive category is represented by
the genes whose expression are unchanged from the level of initiating cells but
should be induced to the expression level of primary cells. Between Success-
ful and Inactive, genes can be deﬁned Insuﬃcient when their expression were
modiﬁed from the input cells but not enough to reach the level of the target
cells. Additionally, because of the induction of transcription factors, some genes
can be over expressed in the engineered cells in comparison to the target pri-
mary cells, here deﬁned as Over ; ﬁnally, some genes appear to be diﬀerentially
expressed in a direction opposite to the expected one, these are deﬁned as Re-
served. By these deﬁnitions, a successful engineering cell process is expected
to oﬀer a signiﬁcant number of Successful genes, including the marker genes,
and a minority of Inactive genes. All other three categories contribute to the
understanding of the deviations that gave rise to the unexpected outcome of
the engineering process. This is namely obtained with 3 outputs oﬀered to
the package users, in addition to the identiﬁcation of ineﬃcient TFs induction:
(i) functional enrichment, (ii) tissue speciﬁc and (iii) gene regulatory network

4

Microarray and RNA-seq Data with eegc

analyses. Each of those contribute to a better understanding of the role that
each gene category plays in the engineering process and clarify the deﬁciencies
of the engineered cells for potential improvements.

2

Installing the eegc package

eegc requires the following CRAN-R packages: R.utils, sna, wordcloud, igraph
and pheatmap, and the Bioconductor packages:limma, edgeR, DESeq2 , clus-
terProﬁler , org.Hs.eg.db, org.Mm.eg.db.

When eegc is installed from Bioconductor , all dependencies are installed.

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("eegc")

Then package is loaded by:

library(eegc)

3

Preparing Input Data

eegc takes an input of gene expression data (with genes in rows and samples
in columns) screened by microarray or RNA-seq (in FPKM -Fragments Per
Kilobase of transcript per Million mapped reads- or counts). Samples belong to
three types of samples: original cells (input), induced cells (ouput), and primary
cells (output target).
In this vignette, we used human RNA-seq expression
FPKMs data published by Sandler et Al. as example data. Here, human Dermal
Microvascular Endothelial Cells (DMEC) were transduced with transcription
factors and cultured in vascular niche to induce the growth of haematopoietic
stem and multipotent progenitor cells (rEChMPP) compared with the target
primary Cord Blood cells (CB).

# load Sandler's data set:

data(SandlerFPKM)

#the column names of the data, representing the samples CB, DMEC, and rEChMPP

colnames(SandlerFPKM)

## [1] "CB1"

"CB2"

"CB3"

"DMEC1"

"DMEC2"

"rEChMPP1" "rEChMPP2"

5

Microarray and RNA-seq Data with eegc

4 Gene Differential Analysis

The diﬀerential analysis is achieved by the diffGene function, and two packages
limma [2] and DESeq2 [3] are selectively applied to microarray/FPKM data and
counts data, respectively. Before the gene diﬀerential analysis, the removal of
low expressed genes is selectively performed (specifying TRUE or FALSE in the
filter parameter) by removal of the genes absent above a given percentage of
samples and a log transformation is done on the (ﬁltered) data. The signiﬁcantly
diﬀerential genes are identiﬁed for each pair-wise sample comparison (DMEC vs
rEChMPP, DEMC vs CB, rEChMPP vs CB) and with a given corrected p-value
cutoﬀ.

# differential expression analysis:

diffgene = diffGene(expr = SandlerFPKM, array=FALSE,

fpkm=TRUE,

counts=FALSE,

from.sample="DMEC", to.sample="rEChMPP", target.sample="CB",

filter=TRUE, filter.perc =0.4, pvalue = 0.05 )

The function gives a list of outputs further used in the following analyses,
including the diﬀerential result detailed below in diffgene.result, the sole
diﬀerential gene names in diffgene.genes and the ﬁltered gene expression
values as in expr.filter.

# differential analysis results

diffgene.result = diffgene[[1]]

# differential genes

diffgene.genes = diffgene[[2]]

#filtered expression data

expr.filter = diffgene[[3]]

dim(expr.filter)

## [1] 14391

dim(SandlerFPKM)

## [1] 16692

7

7

6

Microarray and RNA-seq Data with eegc

5 Gene Categorization

Gene (g) categorization is achieved through the pair-wise comparisons (Expres-
sion Diﬀerence, ED) as deﬁned in eq. 1, a diﬀerence of g average expression in
A and B samples among the three types of samples as shown in Table 1, and
the ratio of such diﬀerences (EDg ratio, eq. 2) .

EDg(A, B) = Eg in A − Eg in B

EDg ratio =

EDg(rEChM P P, DM EC)
EDg(CB, DM EC)

1

2

The ﬁve gene categories are ﬁrst deﬁned by the ED patterns observed among
three pair-wise comparisons as shown in the ED columns of Table 1. Based on
these deﬁnitions, categories Reserved and Over are undistinguishable, but be-
come clearly distinct by evaluation of the ED ratios (eq. 2) in the corresponding
column of Table 1.

At this stage, Inactive and Successful ED ratios are, conveniently, around 0 and
1, however, they cover a relatively wide range of values, with queues overlapping
with the Over and Insuﬃcient categories for Successful genes, and with Reverse
and Insuﬃcient for Inactive genes. To gain an accurate and practical catego-
rization (operational in term of indications as to which genes need attention
in the engineering process), Inactive and Successful genes boundaries were set
more stringently around the intuitive peaks of 0 and 1, by shrinking the ED ratio
boundaries to what we name operational ranges in Table 1, which correspond
to the 5th and 95th quantile of the ED-ranked Successful and Inactive genes.

7

Microarray and RNA-seq Data with eegc

Table 1: Gene categorization base on differential analysis and ED ratio

Category

CB,
DMEC

ED Patterns
rEChMPP,
DMEC

rEChMPP,
CB

ED Ratio

Operational Ranges

(cid:55)

(cid:51)

(cid:51)/(cid:55)

Reversed
Over
Inactive
Insuﬃcient
Successful
(cid:51) diﬀerential, (cid:55) nondiﬀerential; Qxth ED ratio: xth quantile of the ranked
ED ratios

<0
>1
∼0
0∼1
∼1

(cid:55)
(cid:51)
(cid:51)

(cid:51)
(cid:51)
(cid:55)

(cid:51)
(cid:51)
(cid:51)

(Q5th ED ratio, Q95th ED ratio)

(Q5th ED ratio, Q95th ED ratio)

Function categorizeGene performs the categorization and gives a list of outputs
with ﬁve categories Reversed, Inactive, Insuﬃcient, Successful and Over with:
1) the gene symbols in each category, 2) corresponding ED ratios.

# categorizate differential genes from differential analysis

category = categorizeGene(expr = expr.filter,diffGene = diffgene.genes,

from.sample="DMEC",

to.sample="rEChMPP",

target.sample="CB")

cate.gene = category[[1]]

cate.ratio = category[[2]]

# the information of cate.gene

class(cate.gene)

## [1] "list"

length(cate.gene)

## [1] 5

names(cate.gene)

## [1] "Reverse"

"Inactive"

"Insufficient" "Successful"

"Over"

head(cate.gene[[1]])

## [1] "ABCC4"

"ADAM12" "ADCY6"

"AGPAT2"

"ANKRD37" "ANO9"

head(cate.ratio[[1]])

##

## ABCC4

ED_ratio
-282.44

## ADAM12

-11.57

## ADCY6

-4.79

8

Microarray and RNA-seq Data with eegc

## AGPAT2

-23.32

## ANKRD37

## ANO9

-9.24

-0.18

6 Gene Expression Pattern Visualization

Expression proﬁle of genes in each category can be visualized as diﬀerent ex-
pression patterns with the markerScatter function that generates a scatter plot
of gene expression for the ﬁve categories in paired arms and highlight the marker
genes in the output (Figure 1). We also apply a linear model to ﬁt the expres-
sion proﬁles of samples on the x- and y-axes, with the possibility to selectively
add the regression lines on the ﬁgure to show the sample correlation. To avoid
confusion and allow a distinct visualization of all expression proﬁles, Inactive,
Insuﬃcient and Successful genes are plotted separately (Figure 1 above) from
the Reserved and Over genes (Figure 1 below), with each of the 5 categories
being plotted from left to right to highlight the expression trend change from
DMEC to rEChMPP.

#load the marker genes of somatic and primary cells

data(markers)

#scatterplot

col = c("#abd9e9", "#2c7bb6", "#fee090", "#d7191c", "#fdae61")

markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "DMEC"),

cate.gene = cate.gene[2:4], markers = markers, col = col[2:4],
xlab = expression('log'[2]*' expression in CB (target)'),
ylab = expression('log'[2]*' expression in DMEC (input)'),
main = "")

markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "rEChMPP"),

cate.gene = cate.gene[2:4], markers = markers, col = col[2:4],
xlab = expression('log'[2]*' expression in CB (target)'),
ylab = expression('log'[2]*' expression in rEC-hMPP (output)'),
main = "")

markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "DMEC"),

cate.gene = cate.gene[c(1,5)], markers = markers, col = col[c(1,5)],
xlab = expression('log'[2]*' expression in CB (target)'),
ylab = expression('log'[2]*' expression in DMEC (input)'),

9

Microarray and RNA-seq Data with eegc

main = "")

markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "rEChMPP"),

cate.gene = cate.gene[c(1,5)], markers = markers, col = col[c(1,5)],
xlab = expression('log'[2]*' expression in CB (target)'),
ylab = expression('log'[2]*' expression in rEC-hMPP (output)'),
main = "")

Figure 1: Expression proﬁle (FPKM in log scale) of the ﬁve gene categories in
CB primary cells against the endothelial cells (left) and rEChMPPs (right), re-
spectively

7 Quantifying Gene Categories

One simple metric to quantify the success of the cellular engineering process is
the proportion of genes in each category among all the categorized genes. A
high proportion of Successful genes reﬂects a good (trans)diﬀerentiation. Thus
we produce a density plot to quantify the ED ratios of each gene category. As
proposed in Table 1, the ED ratios of Successful genes are around 1, Inactive
genes around 0 and Insuﬃcient genes are between 0 and 1. Extreme higher or
lower ratios are given by the Reserved or Over genes, respectively, to make the
ratios on x axis readable, we suggest to narrow the ratios of Reserved and Over
genes to a maximum of their median values (Figure 2).

10

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll02468101214051015log2 expression in CB (target)log2 expression in DMEC (input)llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllECE1ENGKLF2SCARF1SOX17CD74CDH5DLL4ECSCREDN1ESM1FLT1FLT4GPR4HLA−DRAIKZF1IL1BJUNBKDRKLF4LAMA4MMP1MMRN2PECAM1POU2F2PTPRBRASIP1SOX7SPI1TEKTIE1VAV1ZFP36BMP4CCL5FOSBLCP2MYBNFE2NOTCH1RUNX1S1PR1lllInactiveInsufficientSuccessfullllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0246810121402468101214log2 expression in CB (target)log2 expression in rEC−hMPP (output)llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllECE1ENGKLF2SCARF1SOX17CD74CDH5DLL4ECSCREDN1ESM1FLT1FLT4GPR4HLA−DRAIKZF1IL1BJUNBKDRKLF4LAMA4MMP1MMRN2PECAM1POU2F2PTPRBRASIP1SOX7SPI1TEKTIE1VAV1ZFP36BMP4CCL5FOSBLCP2MYBNFE2NOTCH1RUNX1S1PR1lllInactiveInsufficientSuccessfulllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll02468100246810log2 expression in CB (target)log2 expression in DMEC (input)lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllETS1F13A1PBX1llReverseOverllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0246810051015log2 expression in CB (target)log2 expression in rEC−hMPP (output)lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllETS1F13A1PBX1llReverseOverMicroarray and RNA-seq Data with eegc

# make the extreme ED ratios in Reversed and Over categories to the median values

reverse = cate.ratio[[1]]

over = cate.ratio[[5]]

reverse[reverse[,1] <= median(reverse[,1]), 1]

= median(reverse[,1])

over[over[,1] >= median(over[,1]),1] = median(over[,1])

cate.ratio[[1]] = reverse

cate.ratio[[5]] = over

# density plot with quantified proportions

densityPlot(cate.ratio, xlab = "ED ratio", ylab = "Density", proportion = TRUE)

Figure 2: The proportion of genes in each category

8

Functional Enrichment Analysis and Visu-
alization

The functional annotation for each gene category is performed by applying the
R package clusterProﬁler [4]. Given an input genelist with ﬁve gene categories
and having set the organism parameter (optionally, human or mouse), functio
nEnrich performs the functional enrichment analysis for Gene Ontology (GO)
[5] and Kyoto Encyclopedia of genes and Genomes (KEGG) pathway [6] with
either hypergeometric test or Gene Set Enrichment Analysis (GSEA).

#

result in "enrichResult" class by specifying TRUE to enrichResult parameter

goenrichraw = functionEnrich(cate.gene, organism = "human", pAdjustMethod = "fdr",

GO = TRUE, KEGG = FALSE, enrichResult = TRUE)

class(goenrichraw[[1]])

## [1] "enrichResult"

11

0.00.51.01.52.02.53.03.5ED ratioDensity−6−5−4−3−2−101234567891011ReverseInactiveInsufficientSuccessfulOver8.42%41.37%20.15%22.8%7.26%Microarray and RNA-seq Data with eegc

## attr(,"package")

## [1] "DOSE"

# result of the summary of "enrichResult" by specifying FALSE to enrichResult parameter

# GO enrichment

goenrich = functionEnrich(cate.gene, organism = "human", pAdjustMethod = "fdr",

GO = TRUE, KEGG = FALSE, enrichResult = FALSE)

# KEGG enrichment

keggenrich = functionEnrich(cate.gene, organism = "human", pAdjustMethod = "fdr",

GO = FALSE, KEGG = TRUE, enrichResult = FALSE)

To describe the signiﬁcantly enriched functional terms in each category (Fig-
ure 3) and for further comparison within the ﬁve gene categories (Figure 4),
a bar plot function barplotEnrich (modiﬁed from the barplot.enrichResult
function in DOSE [7] package) and heatmap plot function heatmapPlot are
added in the package, outputting the most enriched terms selected by parame-
ter top.

# plot only the "enrichResult" of Inactive category

inactive = goenrichraw[[2]]

barplotEnrich(inactive, top =5, color ="#2c7bb6", title = "Inactive")

Figure 3: Example of top 5 signiﬁcantly enriched Gene Ontology terms in the
Inactive category
The shade of colors represents enrichment p-values and bar length represents the count of
genes involved in each GO term.

# plot the enrichment results by the five gene categories

data(goenrich)

heatmaptable = heatmapPlot(goenrich, GO = TRUE, top = 5, filter = FALSE,

main = "Gene ontology enrichment",
display_numbers =

FALSE)

12

lymphocyte differentiationregulation of leukocyte mediated cytotoxicitypositive regulation of cell killingpositive regulation of leukocyte mediated cytotoxicityT cell activation0204060805.0e−081.0e−071.5e−072.0e−07p.adjustInactiveMicroarray and RNA-seq Data with eegc

Figure 4: Top 5 signiﬁcantly enriched Gene Ontology terms in each gene cate-
gory based on the log transformed corrected p-values
The counts of genes involved in each functional term are displayed on the heatmap by
specifying TRUE to the display_numbers parameter in heatmapPlot function.

This analysis helps to evaluate the engineered cells at the functional level by
identifying the non-activated functions that play important roles in primary cells
but, being enriched in the Inactive genes categories, lack in the engineered cells.

13

Gene ontology enrichmentReverseInactiveInsufficientSuccessfulOverGO:0007155~cell adhesionGO:0022610~biological adhesionGO:0009987~cellular processGO:0050896~response to stimulusGO:0044763~single−organism cellular processGO:0008150~biological_processGO:0044699~single−organism processGO:0007165~signal transductionGO:0044700~single organism signalingGO:0030168~platelet activationGO:0050878~regulation of body fluid levelsGO:0050817~coagulationGO:0007596~blood coagulationGO:0007599~hemostasisGO:0016043~cellular component organizationGO:0071840~cellular component organization or biogenesisGO:0002376~immune system processGO:0006955~immune responseGroup0.511.522.533.54Microarray and RNA-seq Data with eegc

9

Cell/Tissue-speciﬁc Enrichment Analysis

The ﬁve gene categories represent diﬀerent reprogramming progresses or di-
rections of the original cells towards primary cells. These progresses or di-
rections can also be explored, in addition to the functional role investigated
above, by cell/tissue (C/T)-speciﬁc analysis. Downstream of a successful cel-
lular engineering process, the expression of somatic cell-speciﬁc genes will be
down-regulated while the expression of primary cell-speciﬁc genes will be up-
regulated. So ideally each of the ﬁve gene categories is mainly composed by two
gene types: somatic or primary genes. By the C/T-speciﬁc analysis, assuming
the most extreme values of expression represent eﬀective up or down regulation
and compute based on this, we can explore which C/T-speciﬁc genes results
the success or failure of the engineering process.

The database Gene Enrichment Proﬁler, containing the expression proﬁles of
12,000 genes with NCBI GeneID entries across 126 primary human cells/tissues
in 30 C/T groups, is used for this C/T-speciﬁc analysis [8].

In Gene Enrichment Proﬁler, genes speciﬁcity to a given cell/tissue is ranked
using a custom deﬁned enrichment score. For our usage in this package ranking
is not suﬃcient as cell/tissue-genes sets are needed and therefore we applied
SpeCond [9], a method to detect condition-speciﬁc gene, to identify the C/T-
speciﬁc gene sets . Then we apply the hypergeometric test to assess the speci-
ﬁcity signiﬁcance of gene categories in each tissue with the enrichment function
and visualize the enrichment results by the heatmapPlot function (Figure 5).

#load the cell/tissue-specific genes

data(tissueGenes)

length(tissueGenes)

## [1] 126

head(names(tissueGenes))

## [1] "ESCells"

"HSCFetalBloodCD34CD38"

## [3] "HSCCordBloodCD34CD38"

"HSCCordBloodCD34CD38CD33"

## [5] "HSCBoneMarrowCD34CD38CD33" "HSCFetalBloodCD34CD381"

#load the mapping file of cells/tissues to grouped cells/tissues

data(tissueGroup)

head(tissueGroup)

##

## 1

## 2

Tissue

ES cells

Tissue_abbr
ESCells

Group

ES cells

HSC fetal blood CD34+ CD38-

HSCFetalBloodCD34CD38 stem cells

14

Microarray and RNA-seq Data with eegc

## 3

HSC cord blood CD34+ CD38-

HSCCordBloodCD34CD38 stem cells

## 4 HSC cord blood CD34+ CD38- CD33-

HSCCordBloodCD34CD38CD33 stem cells

## 5 HSC bone marrow CD34+ CD38- CD33- HSCBoneMarrowCD34CD38CD33 stem cells

## 6

HSC fetal blood CD34+ CD38+

HSCFetalBloodCD34CD381 stem cells

#get the background genes

genes = rownames(expr.filter)

#enrichment analysis for the five gene categories

tissueenrich = enrichment(cate.gene = cate.gene, annotated.gene = tissueGenes,

background.gene = genes, padjust.method = "fdr")

#select a group of cells/tissues

tissueGroup.selec = c("stem cells","B cells","T cells","Myeloid","Endothelial CD105+")

tissues.selec = tissueGroup[tissueGroup[,"Group"] %in% tissueGroup.selec,c(2,3)]

tissuetable = heatmapPlot(tissueenrich, terms = tissues.selec, GO=FALSE,
annotated_row = TRUE,annotation_legend = TRUE,
main = "Tissue-specific enrichment")

Figure 5: Cells/tissues-speciﬁc enrichment among ﬁve gene categories in se-
lected cells/tissues

It is expected that the Successful genes are enriched in both somatic and primary
cells/tissues but not the Inactive or Insuﬃcient genes.

15

Tissue−specific enrichmentReverseInactiveInsufficientSuccessfulOverThymicCD34CD38CD1A1ThymicCD4CD8CD3ThymicCD4CD8CD31ThymicCD34CD38CD1ABCellsProThymicCD34EndothelialCD105BCellsPreIRBCBCellsImmatureBCellsPreIIPeripheralCD8TCellsThymicCD4CD8CD32Th1Th2PeripheralNaiveCD4TCellsTregThymicSPCD8TCellsTCellsCentralMemoryTCellsEffectorMemoryTCellsCD57ThymicSPCD4TCellsBoneMarrowCD34DerivedMacrophage16hDCLPS48hMyeloidCD33MonocyteCD14DCImmatureMastCellIgEMacrophageMastCellDCDCBAFFDCLPS6hMacrophageLPS4hBCellsCordBloodCD34TCellsCordBloodCD34HSCCordBloodCD34CD38CD331HSCPeriphBloodCD34CD38HSCCordBloodCD34CD381HSCFetalBloodCD34CD381HSCCordBloodCD34CD38HSCCordBloodCD34CD38CD33HSCFetalBloodCD34CD38HSCBoneMarrowCD34CD38HSCBoneMarrowCD34CD38CD33HSCBoneMarrowCD34CD38CD331BCellsCD19NeutrophilsThymusTonsilsNKCD56TCellsGammadeltaLymphNodeSpleenTonsilsCD4TCellsBloodTCellsBAFFGroupTissueGroupReverseInactiveInsufficientSuccessfulOverTissueB cellsEndothelial CD105+MyeloidT cellsstem cells1234Microarray and RNA-seq Data with eegc

10 Evaluation Based on Gene Regulatory Net-

work (GRN) Analysis

The package also build the gene-gene regulation network for each category
based on cell/tissue-speciﬁc gene regulatory networks (GRNs) constructed by
the CellNet [10] team through the analysis of 3419 published gene expression
proﬁles in 16 human and mouse cells/tissues. The complete table of regulatory
relationships for all genes (not limited to C/T-speciﬁc ones) and for C/T-speciﬁc
ones are downloaded from the CellNet website.

10.1 CellNet-based Cell/Tissue-speciﬁc analysis

Construction is done by checking the percentage of overlapping genes in each
category with the genes involved in each C/T-speciﬁc GRN by the dotPercent-
age function (Figure 6) and then performing a C/T-speciﬁc enrichment analysis,
as in the Cell/Tissue-speciﬁc Enrichment Analysis section, based on these gene
sets.

#load the C/T-specific genes in 16 cells/tissues

data(human.gene)

# the 16 cells/tissues

head(names(human.gene))

## [1] "Esc"

"Ovary"

"Neuron"

"Skin"

"Hspc"

## [6] "Macrophage"

perc = dotPercentage(cate.gene = cate.gene, annotated.gene = human.gene,

order.by = "Successful")

Figure 6: Percentage of genes in each category overlapping in each cell- and
tissue-speciﬁc gene set

16

Gene percentage(%)llllllllllllllllllllllllllllllllMacrophageEndothelialTcellBcellLungFibroblastHspcColonKidneyNeuronHeartLiverSkinMuscleSkelOvaryEsc0246811141720llReverseInactiveInsufficientSuccessfulOverMicroarray and RNA-seq Data with eegc

# CellNet C/T-specific enrichment analysis

cellnetenrich = enrichment(cate.gene = cate.gene, annotated.gene = human.gene,

background.gene = genes, padjust.method ="fdr")

cellnetheatmap = heatmapPlot(cellnetenrich,

main = "CellNet tissue specific enrichment")

10.2 Cell/Tissue-speciﬁc Transcription Factor Analysis

In our speciﬁc example, the observation that some Inactive genes are enriched
in the primary cells, represents an important information regarding the tran-
scription factors regulating these genes, TFs that are potentially necessary for a
successful cellular engineering. Therefore in a second step, we extract the cell-
and tissue-speciﬁc transcription factors and their down-stream regulated genes
into gene sets, and apply the gene set enrichment analysis on the ﬁve gene cat-
egories. A heatmap can be plotted to compare the C/T-speciﬁc transcription
factors enriched by diﬀerent categories just as shown in Figure 7.

# load transcription factor regulated gene sets from on CellNet data

data(human.tf)

tfenrich = enrichment(cate.gene = cate.gene,

annotated.gene = human.tf,

background.gene = genes, padjust.method ="fdr")

tfheatmap = heatmapPlot(tfenrich, top = 5,

main = "CellNet transcription factor enrichment")

Figure 7: Top 5 signiﬁcantly enriched cell/tissue-speciﬁc transcription factors
by each gene category based on the log transformed corrected p-values

17

CellNet transcription factor enrichmentReverseInactiveInsufficientSuccessfulOverNeuron.OLIG1Esc.MYBL2Hspc.MYBL2Esc.ZBTB20Esc.CDT1Hspc.CDT1Hspc.LMO2Endothelial.SOX7Macrophage.MNDAMacrophage.SPI1Macrophage.SOD2Macrophage.CEBPAMacrophage.ZNF827Bcell.RUNX3Tcell.RUNX3Tcell.TBX21Tcell.SCML4Tcell.LEF1Bcell.LEF1Bcell.SCML4Macrophage.MAFBBcell.SMARCA1Bcell.IRF8Tcell.IRF8Group01234Microarray and RNA-seq Data with eegc

10.3 Network Topological Analysis and Visualization

Finally, we introduce the topological analysis for the C/T-speciﬁc gene regu-
latory networks including genes in each of ﬁve categories, by calculating the
degree, closeness, betweenness and stress centrality with the igraph package
[11] and sna [12]. Given an input of genes and their centrality, grnPlot func-
tion plots the regulatory network with these genes as nodes and centrality as
node size to represent their importance in the network (Figure 8).

# load the CellNet GRN

data(human.grn)

# specify a tissue-specifc network

tissue = "Hspc"

degree = networkAnalyze(human.grn[[tissue]], cate.gene = cate.gene,

centrality = "degree", mode ="all")

head(degree)

##

Gene centrality.score

Type Category

## 977

ORC1

## 1042 POLA1

## 103 BRCA1

## 235

CDT1

## 1456 UHRF1

## 595 HELLS

0.215 TF;TG

0.214 TF;TG

0.210 TF;TG

0.203 TF;TG

0.201 TF;TG

0.199 TF;TG

<NA>

<NA>

<NA>

<NA>

<NA>

<NA>

# select genes to shown their regulation with others

node.genes = c("ZNF641", "BCL6")

# enlarge the centrality
centrality.score = degree$centrality*100
names(centrality.score) = degree$Gene

par(mar = c(2,2,3,2))

grnPlot(grn.data = human.grn[[tissue]], cate.gene = cate.gene, filter = TRUE,

nodes = node.genes, centrality.score = centrality.score,

main = "Gene regulatory network")

The analysis clariﬁes the importance of genes, especially the transcription fac-
tors, in terms of their ability to connect other genes in a network. Hence, this
provides a way to predict the relevance of molecules in terms of their topological
centrality, and oﬀer information regarding potential transcription factors to be
used for an improvement of cellular engineering.

18

Microarray and RNA-seq Data with eegc

Figure 8: The hematopoietic stem/progenitor cell (Hspc)-specifc gene regulatory
network regulated by "ZNF641" and "BCL6" genes
Node size is represented by the degree centrality of node in a general Hspc-speciﬁc net-
work.

References

[1] Sandler, V.M., et al., Reprogramming human endothelial cells to

haematopoietic cells requires vascular induction. Nature, 2014. 511(7509):
p. 312-8.

[2] Smyth, G.K., Linear models and empirical bayes methods for assessing
diﬀerential expression in microarray experiments. Appl Genet Mol Biol,
2004. 3: p. Article3.

[3] Love, M.I., W. Huber, and S. Anders, Moderated estimation of fold

change and dispersion for RNA-seq data with DESeq2. Genome Biol,
2014. 15(12): p. 550.

[4] Yu, G., et al., clusterProﬁler: an R package for comparing biological

themes among gene clusters. OMICS, 2012. 16(5): p. 284-7.

[5] Ashburner, M., et al., Gene ontology: tool for the uniﬁcation of biology.
The Gene Ontology Consortium. Nat Genet, 2000. 25(1): p. 25-9.

[6] Kanehisa, M., et al., KEGG for integration and interpretation of
large-scale molecular data sets. Nucleic Acids Research, 2012.
40(Database issue): p. D109-14.

19

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllZNF641BCL6KLF9RFC2C18orf54CCDC34TK1SUV39H2TYMSMAD2L1CDKN3WDR67NT5DC2MPHOSPH9C20orf112KIAA1211SRSF9NPM1SLC25A5HMGN1HDAC1TOP2ARRM2CKS1BSMSBIRC5PLK1DHFRFOXM1NUDT21CDC20UBE2CSPAG5RFC5CDK1LMNB1PSMG1CCNA2ALG8SKP2BUB1BDLGAP5VRK1CDC6RFC4ZWINTTRIP13AURKARAD51AP1NDC80CKS2SMC2ELOVL6PROM1KIF11CSTF2NEK2KIF23WDHD1TTKMELKPLK4CENPARAD51CENPEORC1CDC25CITGB3BPSTILCHEK1PDE4DIPPOLE2GINS1ANXA11KIF14SUPT3HHMMRCENPFDUTPOLR2HCASP6UCK2SPC25TPX2RPL39LCHEK2CDK7MCM4ASCC3CBX7PFASOIP5RPSACCNB1SKA1ALDH18A1PRC1TMEM48GALNT7MRPL22GMNNKIF4ACEP55DTLNCAPGFANCFHJURPKIF20AMLF1IPMIS18APBKVANGL1NUDT15KDELC1SHCBP1CENPNECT2PARPBPHELLSDEPDC1MCM10C1orf112DIAPH3KIF18ADONSONBRIP1KIF18BCENPKABRACLDNAJC30NUF2MND1UHRF1SKA2FAM83DRMI2CENPWDEPDC1BSKA3C1orf132SPIN4TICRRSGOL2CENPHC4orf46Gene regulatory networklllllReversedInactiveInsufficientSuccessfulOverMicroarray and RNA-seq Data with eegc

[7] He, G.Y.a.L.-G.W.a.G.-R.Y.a.Q.-Y., DOSE: an R/Bioconductor package
for Disease Ontology Semantic and Enrichment analysis. Bioinformatics,
2015. 31(4): p. 608-609.

[8] Benita, Y., et al., Gene enrichment proﬁles reveal T-cell development,

diﬀerentiation, and lineage-speciﬁc transcription factors including ZBTB25
as a novel NF-AT repressor. Blood, 2010. 115(26): p. 5376-84.

[9] Cavalli, F., 2009. SpeCond: Condition speciﬁc detection from expression

data. 2009.

[10] Morris, S.A., et al., Dissecting engineered cell types and enhancing cell

fate conversion via CellNet. Cell, 2014. 158(4): p. 889-902.

[11] Nepusz, G.C.a.T., The igraph software package for complex network

research. InterJournal, 2006. Complex Systems: p. 1695.

[12] Carter T. Butts, sna: Tools for Social Network Analysis. R package

version 2.3-2, 2014.

11 Session Info

sessionInfo()

## R version 3.5.2 (2018-12-20)
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

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##

## attached base packages:

## [1] parallel stats4

stats

graphics

grDevices utils

datasets

## [8] methods

base

##

20

Microarray and RNA-seq Data with eegc

## other attached packages:
## [1] org.Hs.eg.db_3.7.0
## [4] S4Vectors_0.20.1
## [7] eegc_1.8.1
##

AnnotationDbi_1.44.0 IRanges_2.16.0
Biobase_2.42.0
knitr_1.21

BiocGenerics_0.28.0

## loaded via a namespace (and not attached):

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

##

##

##

[1] backports_1.1.3
[3] fastmatch_1.1-0
[5] igraph_1.2.2
[7] splines_3.5.2
[9] GenomeInfoDb_1.18.1
[11] urltools_1.7.1
[13] htmltools_0.3.6
[15] viridis_0.5.1
[17] gdata_2.18.0
[19] checkmate_1.8.5
[21] cluster_2.0.7-1
[23] sna_2.4
[25] wordcloud_2.6
[27] R.utils_2.7.0
[29] prettyunits_1.0.2
[31] blob_1.1.1
[33] xfun_0.4
[35] crayon_1.3.4
[37] jsonlite_1.6
[39] genefilter_1.64.0
[41] survival_2.43-3
[43] gtable_0.2.0
[45] XVector_0.22.0
[47] DelayedArray_0.8.0
[49] DOSE_3.8.0
[51] DBI_1.0.0
[53] Rcpp_1.0.0
[55] xtable_1.8-3
[57] htmlTable_1.12
[59] gridGraphics_0.3-0
[61] bit_1.1-14
[63] Formula_1.2-3
[65] httr_1.4.0
[67] gplots_3.0.1
[69] acepack_1.4.1
[71] XML_3.98-1.16

Hmisc_4.1-1
plyr_1.8.4
lazyeval_0.2.1
BiocParallel_1.16.2
ggplot2_3.1.0
digest_0.6.18
GOSemSim_2.8.0
GO.db_3.7.0
magrittr_1.5
memoise_1.1.0
limma_3.38.3
annotate_1.60.0
matrixStats_0.54.0
enrichplot_1.2.0
colorspace_1.3-2
ggrepel_0.8.0
dplyr_0.7.8
RCurl_1.95-4.11
org.Mm.eg.db_3.7.0
bindr_0.1.1
glue_1.3.0
zlibbioc_1.28.0
UpSetR_1.3.3
scales_1.0.0
pheatmap_1.0.10
edgeR_3.24.2
viridisLite_0.3.0
progress_1.2.0
units_0.6-2
foreign_0.8-71
europepmc_0.3
htmlwidgets_1.3
fgsea_1.8.0
RColorBrewer_1.1-2
pkgconfig_2.0.2
R.methodsS3_1.7.1

21

Microarray and RNA-seq Data with eegc

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

##

##

[73] farver_1.1.0
[75] locfit_1.5-9.1
[77] ggplotify_0.0.3
[79] rlang_0.3.0.1
[81] munsell_0.5.0
[83] RSQLite_2.1.1
[85] ggridges_0.5.1
[87] stringr_1.3.1
[89] bit64_0.9-7
[91] purrr_0.2.5
[93] bindrcpp_0.2.2
[95] DO.db_2.9
[97] BiocStyle_2.10.0
[99] rstudioapi_0.8

nnet_7.3-12
labeling_0.3
tidyselect_0.2.5
reshape2_1.4.3
tools_3.5.2
statnet.common_4.1.4
evaluate_0.12
yaml_2.2.0
caTools_1.17.1.1
ggraph_1.0.2
R.oo_1.22.0
xml2_1.2.0
compiler_3.5.2
tibble_1.4.2
geneplotter_1.60.0
highr_0.7
Matrix_1.2-15
BiocManager_1.30.4
data.table_1.11.8
bitops_1.0-6
qvalue_2.14.0
latticeExtra_0.6-28
KernSmooth_2.23-15
MASS_7.3-51.1
assertthat_0.2.0

##
## [101] tweenr_1.0.1
## [103] stringi_1.2.4
## [105] lattice_0.20-38
## [107] pillar_1.3.1
## [109] triebeard_0.3.0
## [111] cowplot_0.9.3
## [113] GenomicRanges_1.34.0
## [115] R6_2.3.0
## [117] network_1.13.0.1
## [119] gridExtra_2.3
## [121] gtools_3.8.1
## [123] SummarizedExperiment_1.12.0 DESeq2_1.22.1
## [125] GenomeInfoDbData_1.2.0
## [127] clusterProfiler_3.10.1
## [129] rpart_4.1-13
## [131] coda_0.19-2
## [133] rvcheck_0.1.3
## [135] base64enc_0.1-3

hms_0.4.2
grid_3.5.2
tidyr_0.8.2
rmarkdown_1.11
ggforce_0.1.3

22

