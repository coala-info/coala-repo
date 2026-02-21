mdgsa Library
David Montaner

(2014-11-24)

Contents

1 Introduction

1.1 Citation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Functional Proﬁling of Gene Expression Data

2.1 Univariate Gene Set Analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Multivariate Gene Set Analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Appendix

3.1

1.- Multidimensional Functional Classiﬁcation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Session Info

1

Introduction

1
1

1
3
7

13
13

14

The mdgsa library implements the gene set analysis methodology developed in Montaner and Dopazo (2010). It presents
a ﬂexible framework for analyzing the enrichment of gene sets along a given ranking of genes. The novelty is that, not
just one ranking index but two, may be analyzed and jointly explored in a multidimensional gene set analysis.

As classical GSEA, our approach allows for the functional proﬁling of isolated genomic characteristics; diﬀerential gene
expression, copy number analyses, or variant to disease associations may be interpreted in terms of gene sets using the
mdgsa package. But more interestingly, our multivariate approach may be used to ﬁnd out gene set enrichments due to
the combined eﬀect of two of such genomic dimensions. We could for instance detect gene sets aﬀected by the interaction
of gene expression changes and copy number alterations.

1.1 Citation

Further description of the mdgsa methods may be found at:

Multidimensional gene set analysis of genomic data.
David Montaner and Joaquin Dopazo.
PLoS One. 2010 Apr 27;5(4):e10348. doi: 10.1371/journal.pone.0010348.

2 Functional Proﬁling of Gene Expression Data

In this tutorial we use the data in the Acute Lymphocytic Leukemia expression dataset package of Bioconductor. First we
will use the limma library to compute a diﬀerential gene expression analysis. Then we will use the functions uvGsa and
mdGsa in the mdgsa package to perform uni-dimensional and bi-dimensional gene set analyses respectively. The functional
interpretation will be done in terms of KEGG Pathways. The annotation will be taken from the hgu95av2.db library in
Bioconductor.

First we load the data and describe the design matrix of the experiment

1

mdgsa Library

library (ALL)
data (ALL)

2

des.mat <- model.matrix (~ 0 + mol.biol, data = ALL)
colnames (des.mat) <- c("ALL", "BCR", "E2A", "NEG", "NUP", "p15")
head (des.mat)
##
## 01005
## 01010
## 03002
## 04006
## 04007
## 04008

ALL BCR E2A NEG NUP p15
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

1
0
1
0
0
0

0
1
0
0
1
1

0
0
0
0
0
0

0
0
0
1
0
0

Contrasts

Then we can use limma to carry out some gene expression comparisons. We can for instance compare ALL samples to
NEG control samples or explore gene diﬀerential expression between BCR and NEG.
library (limma)
cont.mat <- makeContrasts (ALL-NEG, BCR-NEG, levels = des.mat)
cont.mat
##
## Levels ALL - NEG BCR - NEG
0
##
1
##
##
0
-1
##
0
##
0
##

ALL
BCR
E2A
NEG
NUP
p15

1
0
0
-1
0
0

fit <- lmFit (ALL, design = des.mat)
fit <- contrasts.fit (fit, cont.mat)
fit <- eBayes (fit)

Contrasts

1000_at
1001_at
1002_f_at

ALL - NEG BCR - NEG
-2.2610931 -0.7684296
-1.0962463 0.2064388
0.7978798 -1.7527367

From this analysis we get test statistics and p-values for each of the two contrasts
fit$t[1:3,]
##
##
##
##
##
fit$p.value[1:3,]
##
##
##
##
##

ALL - NEG BCR - NEG
0.02548234 0.44368153
1000_at
1001_at
0.27507879 0.83678412
1002_f_at 0.42645360 0.08209929

Contrasts

These gene level information may be now interpreted in terms of gene sets. For this example we will carry out a gene set
analysis using the functional blocks described in KEGG, but any other functional data base such as the Gene Ontology or
even a customized one may be analyzed using mdgsa. We can get the KEGG annotation from the hgu95av2.db library as
follows.
library (hgu95av2.db)
anmat <- toTable (hgu95av2PATH)
anmat[1:3,]

mdgsa Library

##
## 1 1000_at
## 2 1000_at
## 3 1000_at

probe_id path_id
04010
04012
04062

3

2.1 Univariate Gene Set Analysis

We can now carry out the functional interpretation of the contrast “BCR - NEG” for instance.

The data needed for the gene set analysis are the p-values and test statistics returned by limma at gene level.

1000_at

1001_at

fit$t[1:3, "BCR - NEG"]
##
1002_f_at
## -0.7684296 0.2064388 -1.7527367
fit$p.value[1:3, "BCR - NEG"]
##
1002_f_at
## 0.44368153 0.83678412 0.08209929

1001_at

1000_at

We load the mdgsa library.
library (mdgsa)

The ﬁrst step in the procedure is to combine p-values and test statistics in a single ranking value.
rindex <- pval2index (pval = fit$p.value[,"BCR - NEG"], sign = fit$t[,"BCR - NEG"])
rindex <- indexTransform (rindex)
rindex[1:3]
1000_at
##
## -0.4038315

1002_f_at
0.4309088 -1.2145063

1001_at

This ranking index keeps the sign of the test statistic; that is, the information of whether the gene is over or underexpressed.
plot (fit$t[,"BCR - NEG"], rindex)

mdgsa Library

4

but the evidence of the diﬀerential expression is taken directly from the p-value
plot (fit$p.value[,"BCR - NEG"], rindex)

−50510−4−2024fit$t[, "BCR − NEG"]rindexmdgsa Library

5

Next we will need to format the annotation. The function annotMat2list in the mdgsa library converts the annotation
matrix into a list.

probe_id path_id
04010
04012
04062

anmat[1:3,]
##
## 1 1000_at
## 2 1000_at
## 3 1000_at
annot <- annotMat2list (anmat)
length (annot)
## [1] 228

Each element of the list contains the gene names of a gene set.
lapply (annot[1:3], head, n= 3)
## $`00010`
## [1] "2035_s_at" "31488_s_at" "32210_at"
##
## $`00020`
## [1] "160044_g_at" "32332_at"
##
## $`00030`
## [1] "31485_at" "32210_at" "32336_at"

"32546_at"

It is also important to make sure that the gene universe described by the ranking index and the annotation are concordant.
The function annotFilter encompasses the annotation list to the names in the ranking index; it is also used to exclude
functional blocks too small to be considered gene sets, or too big to be speciﬁc of any biological process of interest.

0.00.20.40.60.81.0−4−2024fit$p.value[, "BCR − NEG"]rindexmdgsa Library

6

annot <- annotFilter (annot, rindex)

Now everything is ready to carry out the univariate gene set analysis.
res.uv <- uvGsa (rindex, annot)
user system elapsed
##
0.012 10.078
##

9.976

The output of the uvGsa function is a data frame which rows correspond to functional blocks analyzed.

N

res.uv[1:3,]
##
padj
lor
## 00010 65 -0.08900436 0.47430323 1.0000000
## 00020 33 -0.26525586 0.12586858 1.0000000
## 00030 21 -0.54531247 0.01420588 0.2497736

pval

The uvGsa function ﬁts a logistic regression model relating, the probability of genes belonging to the gene set, with the
value of the ranking statistic.

Signiﬁcant and positive log odds ratio (lor) indicate that the gene set is enriched in those genes with high values of
the ranking statistic. In our example this means that genes up regulated in BCR compared to NEG are more likely to
belong to the functional block. We could also say that the block of genes shows a signiﬁcant degree of over expression
BCR compared to NEG.

On the other hand, when a gene set has a negative log odds ratio we can say that the genes in the set are more likely to
be associated to low values, negative in our case, of the ranking statistics. In our case this means that the gene set is
down regulated in BCR compared to NEG.

The function uvPat helps you classifying the analyzed gene sets
res.uv[,"pat"] <- uvPat (res.uv, cutoff = 0.05)
table (res.uv[,"pat"])
##
## -1
1
## 10 156 42

0

Positive values (1) correspond to signiﬁcant and positive log odds ratios. Negative values (-1) correspond to signiﬁcant
and negative log odds ratios. Zeros correspond to non enriched blocks.

As in this example we are analyzing KEGG pathways we can use the function getKEGGnames to ﬁnd out the “name” of
the pathways1.
res.uv[,"KEGG"] <- getKEGGnames (res.uv)

Finally, the function uvSignif may help us displaying just the enriched blocks.
res <- uvSignif (res.uv)
res[,c("pat", "KEGG")]
pat
##
1
## 05416
1
## 05332
1
## 04612
1
## 05330
1
## 04145
1
## 04940
1
## 05323
1
## 05145
1
## 05131

KEGG
Viral myocarditis
Graft-versus-host disease
Antigen processing and presentation
Allograft rejection
Phagosome
Type I diabetes mellitus
Rheumatoid arthritis
Toxoplasmosis
Shigellosis

1Similar function getGOnames is available to be used with Gene Ontology terms.

mdgsa Library

7

Lysosome
1
## 04142
Leishmaniasis
1
## 05140
Leukocyte transendothelial migration
1
## 04670
Bacterial invasion of epithelial cells
1
## 05100
Staphylococcus aureus infection
1
## 05150
Asthma
1
## 05310
Intestinal immune network for IgA production
1
## 04672
Adherens junction
1
## 04520
Systemic lupus erythematosus
1
## 05322
Osteoclast differentiation
1
## 04380
MAPK signaling pathway
1
## 04010
NOD-like receptor signaling pathway
1
## 04621
Focal adhesion
1
## 04510
Autoimmune thyroid disease
1
## 05320
Cytokine-cytokine receptor interaction
1
## 04060
Cell adhesion molecules (CAMs)
1
## 04514
Chronic myeloid leukemia
1
## 05220
Amoebiasis
1
## 05146
TGF-beta signaling pathway
1
## 04350
Endocytosis
1
## 04144
Neurotrophin signaling pathway
1
## 04722
Regulation of actin cytoskeleton
1
## 04810
Pathogenic Escherichia coli infection
1
## 05130
Chemokine signaling pathway
1
## 04062
Chagas disease (American trypanosomiasis)
1
## 05142
Malaria
1
## 05144
1
Apoptosis
## 04210
1 Epithelial cell signaling in Helicobacter pylori infection
## 05120
1
Tight junction
## 04530
B cell receptor signaling pathway
1
## 04662
Arrhythmogenic right ventricular cardiomyopathy (ARVC)
1
## 05412
Fc gamma R-mediated phagocytosis
1
## 04666
## 04360
Axon guidance
1
Terpenoid backbone biosynthesis
## 00900 -1
Selenocompound metabolism
## 00450 -1
Ribosome biogenesis in eukaryotes
## 03008 -1
Nucleotide excision repair
## 03420 -1
## 03450 -1
Non-homologous end-joining
Valine, leucine and isoleucine degradation
## 00280 -1
Homologous recombination
## 03440 -1
Steroid biosynthesis
## 00100 -1
Mismatch repair
## 03430 -1
DNA replication
## 03030 -1

2.2 Multivariate Gene Set Analysis

But with the mdgsa library we can analyze not just one but two ranking statistics at a time.

In our example we were interested not in just one diﬀerential expression contrast but in two: ALL vs. NEG and BCR
vs. NEG. We used limma to ﬁt this two contrasts (see previous sections) and computed gene statistics and p-values for
for each of them.

mdgsa Library

8

Contrasts

ALL - NEG BCR - NEG
-2.2610931 -0.7684296
-1.0962463 0.2064388
0.7978798 -1.7527367

1000_at
1001_at
1002_f_at

fit$t[1:3,]
##
##
##
##
##
fit$p.value[1:3,]
##
##
##
##
##

Contrasts

ALL - NEG BCR - NEG
0.02548234 0.44368153
1000_at
1001_at
0.27507879 0.83678412
1002_f_at 0.42645360 0.08209929

We can combine this two matrices in a single one containing a ranking statistic for each contrast, just as we did in the
univariate example.
rindex <- pval2index (pval = fit$p.value, sign = fit$t)
rindex <- indexTransform (rindex)
rindex[1:3,]
##
##
##
##
##

ALL - NEG BCR - NEG
-1.6649597 -0.4038315
-0.9075447 0.4309088
0.6548653 -1.2145063

1000_at
1001_at
1002_f_at

Contrasts

Now we can explore the bi-dimensional distribution of this ranking indexes
plot (rindex, pch = ".")

mdgsa Library

9

and search for gene sets enrichment patterns in both dimensions

The same annotation list we ﬁltered in the previous section may be used in this second example. Thus everything is
ready to carry out our multidimensional analysis.
res.md <- mdGsa (rindex, annot)
user system elapsed
##
0.000 11.875
## 11.744

N lor.ALL - NEG lor.BCR - NEG
-0.1309072
0.01695617
-0.2965314 -0.07414872
-0.5947390 -0.02481283

As in the univariate analysis, the output of the mdGsa function is a data frame with a row per analyzed gene set.
res.md[1:3,]
##
## 00010 65
## 00020 33
## 00030 21
##
## 00010
## 00020
## 00030

pval.I padj.ALL - NEG padj.BCR - NEG padj.I
1
1
1

lor.I pval.ALL - NEG
0.1227818
0.7399391
0.5747527

0.31386075 0.8729905
0.09865711 0.6210410
0.01107020 0.8963435

1.0000000
1.0000000
0.2162675

0.1975707
0.0604673
0.1474753

pval.BCR - NEG

1
1
1

The column of the row contain log odds ratios and p-values for each of the analyzed dimensions and also for their
interaction eﬀect. The function mdPat helps clarifying the bi-dimensional pattern of enrichment.
res.md[,"pat"] <- mdPat (res.md)
table (res.md[,"pat"])
##
## NS b13 q2f q3f
1
## 154

yh yl
9

1 42

1

−4−2024−4−2024ALL − NEGBCR − NEGmdgsa Library

10

And as before we can incorporate the KEGG names to our results.
res.md[,"KEGG"] <- getKEGGnames (res.md)
res.md[1:3,]

Thus we could for instance explore the KEGG classiﬁed as having a with a q3f pattern. The q3f classiﬁcation means that
the genes of this gene set are located in the third quadrant of the bivariate ranking index representation.

The plotMdGsa function help us understanding such pattern.
Q3 <- rownames (res.md)[res.md$pat == "q3f"]
Q3
## [1] "03030"
plotMdGsa (rindex, block = annot[[Q3]], main = res.md[Q3, "KEGG"])

Red dots in the ﬁgure represent the genes within the gene set. They show, in both dimensions of our ranking, values
signiﬁcantly more negatives that the remaining genes in the study. This same pattern may be appreciated in the ellipses
drawn in the ﬁgure. The blue one represents a conﬁdence region for all the genes in the study. The red one shows the
same conﬁdence region but just for those genes within the gene set. We can see how the distribution of the genes in
KEGG 03030 is displaced towards the third quadrant of the plot. This indicates us that “DNA replication” is a pathway
jointly down regulated in both ALL and BCR when compared to the controls in the NEG group.

Similarly we can explore a bimodal (b13) KEGG. This pattern classiﬁcation indicates us that the functional block has two
sub-modules of genes with opposite patterns of expression. One subset of the KEGG is up-regulated in both conditions
while the other subset is down-regulated also in both dimensions analyzed.

It may be worth pointing here that, this bimodal pattern will be missed by standard univariate gene set methods, and
that it may be just detected in the multidimensional analysis.

−4−2024−4−2024DNA replicationALL − NEGBCR − NEGmdgsa Library

11

BI <- rownames (res.md)[res.md$pat == "b13"]
plotMdGsa (rindex, block = annot[[BI]], main = res.md[BI, "KEGG"])

As third example we could display some KEGG enriched in one dimension but not in the other. The yh pattern indicates
gene set over-representation just in the Y axis but not in the horizontal axis. In our case, KEGG pathways with at yh
pattern are those over expressed in BRC compared to NEG but not enriched in the comparison between ALL and NEG.

Similarly an yl pattern indicates a down-regulation of the block in the BRC vs. NEG comparison but not in the ALL
vs. NEG one.

The plot below displays one of such yl classiﬁed KEGGs.
rownames (res.md)[res.md$pat == "yl"]
## [1] "00100" "00280" "00900" "03008" "03013" "03430" "03440" "03450" "04146"
YL <- "00280"
plotMdGsa (rindex, block = annot[[YL]], main = res.md[YL, "KEGG"])

−4−2024−4−2024Primary immunodeficiencyALL − NEGBCR − NEGmdgsa Library

12

All possible multidimensional enrichment patterns are listed in the Appendix.
rownames (res.md)[res.md$pat == "yh"]
## [1] "04010" "04012" "04060" "04062" "04142" "04144" "04145" "04210"
## [9] "04350" "04380" "04510" "04514" "04520" "04530" "04612" "04621"
## [17] "04630" "04662" "04666" "04670" "04672" "04722" "04810" "04940"
## [25] "05100" "05120" "05130" "05131" "05142" "05144" "05145" "05146"
## [33] "05150" "05220" "05310" "05320" "05322" "05323" "05330" "05332"
## [41] "05412" "05416"
YH <- "05332"
plotMdGsa (rindex, block = annot[[YH]], main = res.md[YH, "KEGG"])

−4−2024−4−2024Valine, leucine and isoleucine degradationALL − NEGBCR − NEGmdgsa Library

13

3 Appendix

–>

3.1 1.- Multidimensional Functional Classiﬁcation

All possible functional block classiﬁcations in the bi-dimensional gene set analysis are:

• q1i: block displaced toward quadrant 1 (0 < X & 0 < Y) with interaction.
• q2i: block displaced toward quadrant 2 (0 > X & 0 < Y) with interaction.
• q3i: block displaced toward quadrant 3 (0 > X & 0 > Y) with interaction.
• q4i: block displaced toward quadrant 4 (0 < X & 0 > Y) with interaction.
• q1f: block displaced toward quadrant 1, no interaction.
• q2f: block displaced toward quadrant 2, no interaction.
• q3f: block displaced toward quadrant 3, no interaction.
• q4f: block displaced toward quadrant 4, no interaction.
• xh: block shifted to positive X values.
• xl: block shifted to negative X values.
• yh: block shifted to positive Y values.
• yl: block shifted to negative Y values.
• b13: bimodal block. Half of the genes displaced towards quadrant 1 and the other half towards quadrant 3.
• b24: bimodal block. Half of the genes displaced towards quadrant 2 and the other half towards quadrant 4.
• NS: non signiﬁcant block.

A detailed description of each of the patterns can be found in Montaner and Dopazo (2010).

The function mdPat in the mdgsa package is devised to help the user classifying bi-dimensional GSA results in such

−4−2024−4−2024Graft−versus−host diseaseALL − NEGBCR − NEGmdgsa Library

patterns.

4 Session Info

14

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

sessionInfo()
## R version 3.4.0 (2017-04-21)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.2 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_US.UTF-8
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4
## [8] methods
##
## other attached packages:
## [1] mdgsa_1.8.0
## [4] AnnotationDbi_1.38.0 IRanges_2.10.0
## [7] limma_3.32.0
## [10] BiocGenerics_0.22.0
##
## loaded via a namespace (and not attached):
## [1] Rcpp_0.12.10
## [5] KEGG.db_3.2.3
## [9] DBI_0.6-1
## [13] digest_0.6.12
## [17] RSQLite_1.1-2
## [21] compiler_3.4.0 backports_1.0.5

magrittr_1.5
cluster_2.0.6
stringr_1.2.0
tools_3.4.0
htmltools_0.3.5 yaml_2.1.14
Matrix_1.2-9
rmarkdown_1.4

memoise_1.1.0
stringi_1.1.5

ALL_1.17.0
knitr_1.15.1

parallel
base

hgu95av2.db_3.2.3

graphics

stats

grDevices utils

datasets

org.Hs.eg.db_3.4.1
S4Vectors_0.14.0
Biobase_2.36.0
BiocStyle_2.4.0

lattice_0.20-35
grid_3.4.0
rprojroot_1.2
evaluate_0.10
GO.db_3.4.1

