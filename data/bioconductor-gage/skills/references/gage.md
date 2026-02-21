Generally Applicable Gene-set/Pathway Analysis

Weijun Luo (luo_weijun AT yahoo.com)

October 30, 2025

Abstract

In this vignette, we demonstrate the gage package for gene set (enrichment or GSEA) or pathway analysis. The
gage package implement the GAGE method. GAGE is generally applicable independent of microarray and RNA-
Seq data attributes including sample sizes, experimental designs, assay platforms, and other types of heterogeneity,
and consistently achieves superior performance over other frequently used methods. We introduce functions and data
for routine and advanced gene set (enrichment) analysis, as well as results presentation and interpretation. We also
cover package installation, data preparation and common application errors. Two secondary vignettes, "Gene set and
data preparation" and "RNA-Seq Data Pathway and Gene-set Analysis Workflows", demonstrate more applications and
usages of GAGE.

1 Cite our work

Weijun Luo, Michael Friedman, Kerby Shedden, Kurt Hankenson, and Peter Woolf. GAGE: generally applicable gene
set enrichment for pathway analysis. BMC Bioinformatics, 2009. doi:10.1186/1471-2105-10-161.

2 Quick start with demo data

This is the most basic use of gage, please check the full description below for more information. If you have difficulties
in using R in general, you may use the Pathview Web server: pathview.uncc.edu and its comprehensive pathway analysis
workflow.

Note we use the demo gene set data, i.e. kegg.gs and go.sets.hs. You can generate up-to-date gene set data using
kegg.gsets and go.gsets. Please check the Section Basic Analysis and the help info on the function for details.
Also here we focuse on KEGG pathways, which is good for most regular analyses. If you are interested in working
with other major pathway databases, including Reactome, MetaCyc, SMPDB, PANTHER, METACROP etc, you can use
SBGNview. Please check SBGNview + GAGE based pathway analysis workflow.

> library(gage)
> data(gse16873)
> hn=(1:6)*2-1
> dcis=(1:6)*2

KEGG pathway analysis. Here you need to make sure species and gene ID type are the same in gene sets (kegg.gs)

and expression data (gse16873). You can check by: head(kegg.gs[[1]]); head(rownames(gse16873))

> data(kegg.gs)
> gse16873.kegg.p <- gage(gse16873, gsets = kegg.gs, ref = hn, samp = dcis)

GO analysis, separate BP, MF and CC categories

1

> library(gageData)
> data(go.sets.hs)
> data(go.subs.hs)
> gse16873.bp.p <- gage(gse16873, gsets = go.sets.hs[go.subs.hs$BP], ref = hn, samp = dcis)
> gse16873.mf.p <- gage(gse16873, gsets = go.sets.hs[go.subs.hs$MF], ref = hn, samp = dcis)
> gse16873.cc.p <- gage(gse16873, gsets = go.sets.hs[go.subs.hs$CC], ref = hn, samp = dcis)

3 New features

gage (≥ 2.11.3): A new secondary vignette, "RNA-Seq Data Pathway and Gene-set Analysis Workflows", demonstrates
applications of GAGE/Pathview workflows in RNA-Seq data analysis.

gage (≥ 2.11.3): A new function, kegg.gsets, has been introduced in the package. You may use it to compile
pathway gene set data any time needed for one of the 3000 KEGG species and KEGG Orthology (with species="ko").
In addition, you get the most updated pathway gene set data as it is retrieved from KEGG in real time. Please check the
Section Basic Analysis and the help info on the function for details.

gage (≥ 2.13.5): Another new function, go.gsets, has been introduced in the package. You may use it to com-
pile GO (Gene Ontology) gene set data any time needed for 19 common species annotated in Bioconductor and more
others by the users. Please check the Section Basic Analysis and the help info on the function for details.

4

Introduction

Gene set analysis (GSA) is a powerful strategy to infer functional and mechanistic changes from high through microarray
or sequencing data. GSA focuses on sets of related genes and has established major advantages over per-gene based
different expression analyses, including greater robustness, sensitivity and biological relevance. However, classical GSA
methods only have limited usage to a small number of microarray or RNA-Seq studies as they cannot handle datasets
of different sample sizes, experimental designs and other types of heterogeneity (Luo et al., 2009). To address these
limitations, we present a new GSA method called Generally Applicable Gene-set Enrichment (GAGE) (Luo et al., 2009).
We have validated GAGE method extensively against the most widely used GSA methods in both applicability and
performance (Luo et al., 2009). In this manual, we focus on the implementation and usage of the R package, gage.

In gage package, we provide a series of functions for basic GAGE analysis, result processing and presentation. We
have also built pipeline routines for of multiple GAGE analysis on different comparisons or samples, the comparison of
parallel analysis results, and even the combined analysis of heterogeneous data from different sources/studies.

This package also supplies an example microarray dataset. In GAGE paper (Luo et al., 2009) and the old versions
of gage package, we used a BMP6 microarray experiment as the demo data. Here we choose to use another published
microarray dataset from GEO, GSE16873 (Emery et al., 2009), as our primary demo data, as to show more and advanced
functionality and applications of GAGE with this update package. GSE16873 is a breast cancer study (Emery et al.,
2009), which covers twelve patient cases, each with HN (histologically normal), ADH (ductal hyperplasia), and DCIS
(ductal carcinoma in situ) RMA samples. Hence, there are 12*3=36 microarray hybridizations or samples interesting to
us plus 4 others less interesting in this full dataset. Due to the size limit of this package, we split this GSE16873 into two
halves, each including 6 patients with their HN and DCIS but not ADH tissue types. Raw data for these two halves were
processed using two different methods, FARMS (Hochreiter et al., 2006) and RMA (Irizarry et al., 2003), respectively to
generate the non-biological data heterogeneity. This gage package, we only include the first half dataset for 6 patients
(processed using FARMS). The second half dataset plus the full dataset (including all HN, ADH and DCIS samples of all
12 patients, processed together using FARMS) and the original BMP6 dataset is supplied with a data package, gageData.
Most of our demo analyses will be done on the first half dataset, except for the advanced analysis where we use both halves
datasets with all 12 patients. While the gage package provides kegg.gsets and go.gsets to generate updated KEGG
pathway and GO (Gene Ontology) gene set in real time, it also includes useful human gene set data derived from KEGG

2

pathway and GO databases. We also supply extra gene set data for other species including mouse, rat and yeast in the
data package, gageData, available from the bioconductor website. In addition, the users may derive other own gene sets
using the kegg.gsets and go.gsets functions.

The manual is written by assuming the user has minimal R/Bioconductor knowledge. Some descriptions and code

chunks cover very basic usage of R. The more experienced users may simply omit these parts.

5

Installation

Assume R has been correctly installed and accessible under current directory. Otherwise, please contact your system
admin or follow the instructions on R website.

Start R: from Linux/Unix command line, type R (Enter); for Mac or Windows GUI, double click the R application

icon to enter R console.

End R: type in q() when you are finished with the analysis using R, but not now.
Two options:
Either install with BiocManager from Bioconductor:

> if (!requireNamespace("BiocManager", quietly=TRUE))
install.packages("BiocManager")
+
> BiocManager::install(c("gage","gageData"))

Or install without using Bioconductor: Download gage and gageData packages (make sure with proper version

number and zip format) and save to /your/local/directory/.

> install.packages(c("/your/local/directory/gage_2.9.1.tar.gz",
+
+

"/your/local/directory/gageData_1.0.0.tar.gz"),
repos = NULL, type = "source")

6 Get Started

Under R, first we load the gage package:

> library(gage)

To see a brief overview of the package:

> library(help=gage)

To get help on any function (say the main function, gage), use the help command in either one of the following two

forms:

> help(gage)
> ?gage

7 Basic Analysis

GAGE (Luo et al., 2009) is a widely applicable method for gene set or pathway analysis. In such analysis, we check for
coordinated differential expression over gene sets instead of changes of individual genes. Gene sets are pre-defined groups
of genes, which are functionally related. Commonly used gene sets include those derived from KEGG pathways, Gene
Ontology terms, gene groups that share some other functional annotations, including common transcriptional regulators
(like transcription factors, small interfering RNA’s or siRNA etc), genomic locations etc. Consistent perturbations over
such gene sets frequently suggest mechanistic changes. GSA is much more robust and sensitive than individual gene

3

analysis (Luo et al., 2009), especially considering the functional redundancy of individual genes and the noise level of
high throughput assay data. GAGE method implemented in this package makes GSA feasible to all microarray and RNA-
Seq studies, irrespecitve of the sample size, experiment design, array platform etc. Let’s start with the most basic gene set
analysis. Note that both the demo expression data and gene set data are ready here, if not, please check vignette, "Gene
set and data preparation", for data preparation.

We load and look at the demo microarray data first. Note that although we use microarray data as example, GAGE is
equally applicable to RNA-Seq data and other types of gene/protein centered high throughput data. The other vignette,
"RNA-Seq Data Pathway and Gene-set Analysis Workflows", demonstrates such applications of GAGE.

> data(gse16873)
> cn=colnames(gse16873)
> hn=grep('HN',cn, ignore.case =T)
> adh=grep('ADH',cn, ignore.case =T)
> dcis=grep('DCIS',cn, ignore.case =T)
> print(hn)

[1] 1 3 5 7

9 11

> print(dcis)

[1] 2 4 6 8 10 12

Check to make sure your gene sets and your expression data are using the same ID system (Entrez Gene ID, Gene
symbol, or probe set ID etc). Entrez Gene IDs are integer numbers, Gene symbols are characters, and probe set IDs
(Affymetrix GeneChip) are characters with _at suffix. When gene sets and expression data do use different types of ID,
please check vignette, "Gene set and data preparation", for ID conversion solutions.

> data(kegg.gs)
> data(go.gs)
> lapply(kegg.gs[1:3],head)

$`hsa00010 Glycolysis / Gluconeogenesis`
[1] "10327" "124"

"125"

"126"

"127"

"128"

$`hsa00020 Citrate cycle (TCA cycle)`
[1] "1431" "1737" "1738" "1743" "2271" "3417"

$`hsa00030 Pentose phosphate pathway`
"229"
[1] "2203"

"221823" "226"

"22934"

"230"

> head(rownames(gse16873))

[1] "10000"

"10001"

"10002"

"10003"

"100048912" "10004"

We normally do GAGE analysis using gene sets derived from on KEGG pathways or GO term groups. Here we use
the human gene set data coming with this package with the human microarray dataset GSE16873. Note that kegg.gs
has been updated since gage version 2.9.1. From then, kegg.gs only include the subset of canonical signaling and
metabolic pathways from KEGG pathway database, and kegg.gs.dise is the subset of disease pathways. And it is
recommended to do KEGG pathway analysis with either kegg.gs or kegg.gs.dise seperately (rather than combined
altogether) for better defined results. go.gs derived from human GO database only includes 1000 gene sets due to size
limit. For full go.gs or gene sets data for other species, we may always use the gageData package. If you don’t find
the gene set data for your target species, you may use kegg.gsets or go.gsets to compile pathway gene set data
any time needed as long as it is one of the 3000 KEGG species or a species with gene annotation package supplied in
Bioconductor or the user. You may want to save the new gene set data for later use. An another advantage of using
kegg.gsets is that you get the most updated pathway gene set data as it is retrieved from KEGG in real time.

4

> kg.hsa=kegg.gsets("hsa")
> kegg.gs=kg.hsa$kg.sets[kg.hsa$sigmet.idx]
> #save(kegg.gs, file="kegg.hsa.sigmet.gsets.RData")

> #kegg.gsets works with 3000 KEGG species,for examples:
> data(korg)
> head(korg[,1:3])

ktax.id tax.id kegg.code

[1,] "T01001" "9606" "hsa"
[2,] "T01005" "9598" "ptr"
[3,] "T02283" "9597" "pps"
[4,] "T02442" "9593" "ggo"
[5,] "T01416" "9601" "pon"
[6,] "T10128" "9600" "ppyg"

> go.hs=go.gsets(species="human")
> go.bp=go.hs$go.sets[go.hs$go.subs$BP]
> go.mf=go.hs$go.sets[go.hs$go.subs$MF]
> go.cc=go.hs$go.sets[go.hs$go.subs$CC]
> #save(go.bp, go.mf, go.cc, file="go.hs.gsets.RData")

> #for Bioconductor species supported by go.gsets function:
> data(bods)
> print(bods)

package

species
"Anopheles"
"Arabidopsis"
"Bovine"
"Worm"
"Canine"
"Fly"
"Zebrafish"
"E coli strain K12"

kegg code id.type
"aga"
[1,] "org.Ag.eg.db"
"ath"
[2,] "org.At.tair.db"
"bta"
[3,] "org.Bt.eg.db"
"cel"
[4,] "org.Ce.eg.db"
"cfa"
[5,] "org.Cf.eg.db"
"dme"
[6,] "org.Dm.eg.db"
"dre"
[7,] "org.Dr.eg.db"
[8,] "org.EcK12.eg.db"
"eco"
[9,] "org.EcSakai.eg.db" "E coli strain Sakai" "ecs"
"gga"
"hsa"
"mmu"
"mcc"
"pfa"
"ptr"
"rno"
"sce"
"ssc"
"xla"

[10,] "org.Gg.eg.db"
[11,] "org.Hs.eg.db"
[12,] "org.Mm.eg.db"
[13,] "org.Mmu.eg.db"
[14,] "org.Pf.plasmo.db"
[15,] "org.Pt.eg.db"
[16,] "org.Rn.eg.db"
[17,] "org.Sc.sgd.db"
[18,] "org.Ss.eg.db"
[19,] "org.Xl.eg.db"

"eg"
"tair"
"eg"
"eg"
"eg"
"eg"
"eg"
"eg"
"eg"
"eg"
"eg"
"eg"
"eg"
"orf"
"eg"
"eg"
"orf"
"eg"
"eg"

"Chicken"
"Human"
"Mouse"
"Rhesus"
"Malaria"
"Chimp"
"Rat"
"Yeast"
"Pig"
"Xenopus"

Here we look at the expression changes towards one direction (either up- or down- regulation) in the gene sets.
The results of such 1-directional analysis is a list of two matrices, corresponding to the two directions. Each result matrix
contains multiple columns of test statistics and p-/q-values for all tested gene sets. Among them, p.val is the global p-value
and q.val is the corresponding FDR q-value. Gene sets are ranked by significance. Type ?gage for more information.

5

ref = hn, samp = dcis)

ref = hn, samp = dcis)

> gse16873.kegg.p <- gage(gse16873, gsets = kegg.gs,
+
> #go.gs here only the first 1000 entries as a fast example.
> gse16873.go.p <- gage(gse16873, gsets = go.gs,
+
> #or we can do analysis on BP, MF, or CC subcategories if we've
> #generated the data as above.
> #gse16873.bp.p <- gage(gse16873, gsets = go.bp,
> #
ref = hn, samp = dcis)
> str(gse16873.kegg.p, strict.width='wrap')

List of 3
$ greater: num [1:252, 1:11] 0.000218 0.001176 0.005397 0.003999 0.013543 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:252] "hsa04141 Protein processing in endoplasmic reticulum"
"hsa00190 Oxidative phosphorylation" "hsa03050 Proteasome" "hsa04142
Lysosome" ...

.. ..$ : chr [1:11] "p.geomean" "stat.mean" "p.val" "q.val" ...
$ less : num [1:252, 1:11] 0.00421 0.02107 0.02362 0.01665 0.04628 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:252] "hsa04510 Focal adhesion" "hsa04020 Calcium signaling

pathway" "hsa04270 Vascular smooth muscle contraction" "hsa04151 PI3K-Akt
signaling pathway" ...

.. ..$ : chr [1:11] "p.geomean" "stat.mean" "p.val" "q.val" ...
$ stats : num [1:252, 1:7] 3.52 2.92 2.58 2.51 2.02 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:252] "hsa04141 Protein processing in endoplasmic reticulum"
"hsa00190 Oxidative phosphorylation" "hsa03050 Proteasome" "hsa04142
Lysosome" ...

.. ..$ : chr [1:7] "stat.mean" "DCIS_1" "DCIS_2" "DCIS_3" ...

> head(gse16873.kegg.p$greater[, 1:5], 4)

p.geomean stat.mean
3.517259
2.919164
2.581308
2.506945

hsa04141 Protein processing in endoplasmic reticulum 0.0002183881
0.0011762119
hsa00190 Oxidative phosphorylation
0.0053965899
hsa03050 Proteasome
0.0039992378
hsa04142 Lysosome
p.val

q.val
hsa04141 Protein processing in endoplasmic reticulum 9.281928e-18 2.227663e-15
1.013058e-12 1.215670e-10
hsa00190 Oxidative phosphorylation
4.069529e-10 3.255623e-08
hsa03050 Proteasome
6.461562e-10 3.876937e-08
hsa04142 Lysosome
set.size
145
98
41
118

hsa04141 Protein processing in endoplasmic reticulum
hsa00190 Oxidative phosphorylation
hsa03050 Proteasome
hsa04142 Lysosome

> head(gse16873.kegg.p$less[, 1:5], 4)

6

p.val
0.004214592 -2.334533 7.223259e-09
hsa04510 Focal adhesion
0.021067941 -1.981641 6.602569e-07
hsa04020 Calcium signaling pathway
hsa04270 Vascular smooth muscle contraction 0.023622820 -1.886632 2.262098e-06
0.016651509 -1.834151 3.794385e-06
hsa04151 PI3K-Akt signaling pathway

p.geomean stat.mean

1.733582e-06
hsa04510 Focal adhesion
hsa04020 Calcium signaling pathway
7.923083e-05
hsa04270 Vascular smooth muscle contraction 1.809678e-04
2.276631e-04
hsa04151 PI3K-Akt signaling pathway

q.val set.size
188
216
117
316

> head(gse16873.kegg.p$stats[, 1:5], 4)

stat.mean

hsa04141 Protein processing in endoplasmic reticulum
hsa00190 Oxidative phosphorylation
hsa03050 Proteasome
hsa04142 Lysosome

DCIS_1
3.517259 4.065531
2.919164 4.162785
2.581308 3.034497
2.506945 2.363079
DCIS_3
hsa04141 Protein processing in endoplasmic reticulum 4.587925 2.7700612
3.678001 0.6250561
hsa00190 Oxidative phosphorylation
2.714454 2.0172428
hsa03050 Proteasome
1.467972 4.4048014
hsa04142 Lysosome

DCIS_2

DCIS_4
hsa04141 Protein processing in endoplasmic reticulum 3.263052
2.626501
hsa00190 Oxidative phosphorylation
2.357073
hsa03050 Proteasome
1.282848
hsa04142 Lysosome

As described in GAGE paper (Luo et al., 2009), it is worthy to run gage with same.dir=F option on KEGG
pathways too to capture pathways perturbed towards both directions simultaneously. Note we normally do not use
same.dir=F option on GO groups, which are mostly gene sets coregulated towards the same direction.

> gse16873.kegg.2d.p <- gage(gse16873, gsets = kegg.gs,
+
> head(gse16873.kegg.2d.p$greater[,1:5], 4)

ref = hn, samp = dcis, same.dir = F)

0.001477932
hsa04510 Focal adhesion
hsa04512 ECM-receptor interaction
0.003531330
hsa04974 Protein digestion and absorption 0.016156871
0.023605598
hsa04151 PI3K-Akt signaling pathway

p.geomean stat.mean

p.val
2.954186 3.533578e-13
2.710532 3.343583e-11
2.102764 1.870542e-07
1.936340 1.112214e-06

8.480586e-11
hsa04510 Focal adhesion
4.012300e-09
hsa04512 ECM-receptor interaction
hsa04974 Protein digestion and absorption 1.496434e-05
6.673283e-05
hsa04151 PI3K-Akt signaling pathway

q.val set.size
188
77
78
316

> head(gse16873.kegg.2d.p$stats[,1:5], 4)

hsa04510 Focal adhesion

7

stat.mean

DCIS_3
2.954186 2.334494 3.574872 3.125784

DCIS_1

DCIS_2

hsa04512 ECM-receptor interaction
hsa04974 Protein digestion and absorption
hsa04151 PI3K-Akt signaling pathway

2.710532 2.402898 3.186582 3.196093
2.102764 2.364505 2.005663 2.688220
1.936340 1.542317 2.803329 2.416527

DCIS_4
2.2650245
hsa04510 Focal adhesion
hsa04512 ECM-receptor interaction
2.0846082
hsa04974 Protein digestion and absorption 0.8322712
1.3399535
hsa04151 PI3K-Akt signaling pathway

We may also do PAGE analysis (Kim and Volsky, 2005) with or without different combinations of GAGE style
options. The key difference is 1) to use z-test instead of two-sample t-test and 2) a group-on-group comparison scheme
(by setting arguement compare="as.group") instead of default one-on-one scheme (compare="paired") as in
GAGE. Here we only used z-test option to compare the net effect of using differet gene set tests, as detailed in Luo et al.
(2009).

> gse16873.kegg.page.p <- gage(gse16873, gsets = kegg.gs,
+
> head(gse16873.kegg.page.p$greater[, 1:5], 4)

ref = hn, samp = dcis, saaTest = gs.zTest)

p.geomean stat.mean
4.635115
3.876999
3.423481
3.315757

hsa04141 Protein processing in endoplasmic reticulum 1.140362e-06
1.703111e-05
hsa00190 Oxidative phosphorylation
7.933256e-05
hsa04142 Lysosome
3.310852e-04
hsa03050 Proteasome
p.val

q.val
hsa04141 Protein processing in endoplasmic reticulum 3.555788e-30 8.533891e-28
1.083546e-21 1.300255e-19
hsa00190 Oxidative phosphorylation
2.519511e-17 2.015609e-15
hsa04142 Lysosome
2.294459e-16 1.376676e-14
hsa03050 Proteasome
set.size
145
98
118
41

hsa04141 Protein processing in endoplasmic reticulum
hsa00190 Oxidative phosphorylation
hsa04142 Lysosome
hsa03050 Proteasome

We get much smaller p-/q-values with PAGE than with GAGE. As described in GAGE paper (Luo et al., 2009), many

significant calls made by PAGE are likely false positives.

With gage, we have much more options to tweak than those related to PAGE for more customized GAGE analysis.
Here we show a few other alternative ways of doing GAGE analysis by setting other arguements. Use t-test statistics
instead of fold change as per gene score:

> gse16873.kegg.t.p <- gage(gse16873, gsets = kegg.gs,
+

ref = hn, samp = dcis, use.fold = F)

If you are very concerned about the normality of expression level changes or the gene set sizes are mostly smaller
than 10, we may do the non-parametric Mann Whitney U tests (rank test without distribution assumption) instead of the
parametric two-sample t-tests on gene sets:

> gse16873.kegg.rk.p <- gage(gse16873, gsets = kegg.gs,
+

ref = hn, samp = dcis, rank.test = T)

Do the non-parametric Kolmogorov-Smirnov tests (like rank test, used in GSEA) instead of the parametric two-sample

t-tests on gene sets:

8

> gse16873.kegg.ks.p <- gage(gse16873, gsets = kegg.gs,
ref = hn, samp = dcis, saaTest = gs.KSTest)
+

Frequently, the samples are not one-on-one paired in the experiment design. In such cases, we take the samples as

unpaired:

> gse16873.kegg.unpaired.p <- gage(gse16873, gsets = kegg.gs,
+

ref = hn, samp = dcis, compare = "unpaired")

Since version 2.2.0, gage package does more robust p-value summarization using Stouffer’s method through argument
use.stouffer=TRUE. The original p-value summarization, i.e. negative log sum following a Gamma distribution
In other words,
as the Null hypothesis, may produce less stable global p-values for large or heterogenous datasets.
the global p-value could be heavily affected by a small subset of extremely small individual p-values from pair-wise
comparisons. Such sensitive global p-value leads to the "dual signficance" phenomenon. Dual-signficant means a gene set
is called significant simultaneously in both 1-direction tests (up- and down-regulated). While not desirable in other cases,
"dual signficance" could be informative in revealing the sub-types or sub-classes in big clinical or disease studies. If we
preferred the original Gamma distribution based p-value summarization, we only need to set use.stouffer=FALSE:

> gse16873.kegg.gamma.p <- gage(gse16873, gsets = kegg.gs,
+

ref = hn, samp = dcis, use.stouffer=FALSE)

Sometimes we have expression data where genes are labelled by symbols (or other IDs). Let’s make such a dataset

gse16873.sym from gse16873, which is originally lable by Entrez Gene IDs.

> head(rownames(gse16873))

[1] "10000"

"10001"

"10002"

"10003"

"100048912" "10004"

> gse16873.sym<-gse16873
> data(egSymb)
> rownames(gse16873.sym)<-eg2sym(rownames(gse16873.sym))
> head(rownames(gse16873.sym))

[1] "AKT3"

"MED6"

"NR2E3"

"NAALAD2"

"CDKN2BAS" "NAALADL1"

If we want to do GAGE analysis, we can convert rownames of gse16873.sym back to Entrez Gene IDs or convert

gene set definitions to gene symbols.

> kegg.gs.sym<-lapply(kegg.gs, eg2sym)
> lapply(kegg.gs.sym[1:3],head)

$`hsa00970 Aminoacyl-tRNA biosynthesis`
[1] "FARSB" "WARS2"

"FARS2"

"PSTK"

"MTFMT"

"TARSL2"

$`hsa02010 ABC transporters`
[1] "ABCC5" "ABCB6"

"ABCC9"

"ABCC4"

"ABCA7"

"ABCA10"

$`hsa03008 Ribosome biogenesis in eukaryotes`
[1] "LOC100008587" "LOC100008588" "LOC100008589" "RN5S1"
[6] "RN5S3"

"RN5S2"

> gse16873.kegg.p2 <- gage(gse16873.sym, gsets = kegg.gs.sym,
+

ref = hn, samp = dcis)

9

8 Result Presentation and Intepretation

We may output full result tables from the analysis.

sep = "\t")

> write.table(gse16873.kegg.2d.p$greater, file = "gse16873.kegg.2d.p.txt",
+
> write.table(rbind(gse16873.kegg.p$greater, gse16873.kegg.p$less),
+

file = "gse16873.kegg.p.txt", sep = "\t")

Sort and count signficant gene sets based on q- or p-value cutoffs:

> gse16873.kegg.sig<-sigGeneSet(gse16873.kegg.p, outname="gse16873.kegg")

[1] "there are 39 signficantly up-regulated gene sets"
[1] "there are 31 signficantly down-regulated gene sets"

> str(gse16873.kegg.sig, strict.width='wrap')

List of 3
$ greater: num [1:39, 1:11] 0.000218 0.001176 0.005397 0.003999 0.013543 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:39] "hsa04141 Protein processing in endoplasmic reticulum"
"hsa00190 Oxidative phosphorylation" "hsa03050 Proteasome" "hsa04142
Lysosome" ...

.. ..$ : chr [1:11] "p.geomean" "stat.mean" "p.val" "q.val" ...
$ less : num [1:31, 1:11] 0.00421 0.02107 0.02362 0.01665 0.04628 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:31] "hsa04510 Focal adhesion" "hsa04020 Calcium signaling

pathway" "hsa04270 Vascular smooth muscle contraction" "hsa04151 PI3K-Akt
signaling pathway" ...

.. ..$ : chr [1:11] "p.geomean" "stat.mean" "p.val" "q.val" ...
$ stats : num [1:70, 1:7] 3.52 2.92 2.58 2.51 2.02 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:70] "hsa04141 Protein processing in endoplasmic reticulum"
"hsa00190 Oxidative phosphorylation" "hsa03050 Proteasome" "hsa04142
Lysosome" ...

.. ..$ : chr [1:7] "stat.mean" "DCIS_1" "DCIS_2" "DCIS_3" ...

> gse16873.kegg.2d.sig<-sigGeneSet(gse16873.kegg.2d.p, outname="gse16873.kegg")

[1] "there are 37 signficantly two-direction perturbed gene sets"

> str(gse16873.kegg.2d.sig, strict.width='wrap')

List of 2
$ greater: num [1:37, 1:11] 0.00148 0.00353 0.01616 0.02361 0.03784 ...
..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:37] "hsa04510 Focal adhesion" "hsa04512 ECM-receptor

interaction" "hsa04974 Protein digestion and absorption" "hsa04151 PI3K-Akt
signaling pathway" ...

.. ..$ : chr [1:11] "p.geomean" "stat.mean" "p.val" "q.val" ...
$ stats : num [1:37, 1:7] 2.95 2.71 2.1 1.94 1.73 ...

10

..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:37] "hsa04510 Focal adhesion" "hsa04512 ECM-receptor

interaction" "hsa04974 Protein digestion and absorption" "hsa04151 PI3K-Akt
signaling pathway" ...

.. ..$ : chr [1:7] "stat.mean" "DCIS_1" "DCIS_2" "DCIS_3" ...

sep = "\t")

> write.table(gse16873.kegg.2d.sig$greater, file = "gse16873.kegg.2d.sig.txt",
+
> write.table(rbind(gse16873.kegg.sig$greater, gse16873.kegg.sig$less),
+

file = "gse16873.kegg.sig.txt", sep = "\t")

Heatmaps in Figure 1 visualize whole gene set perturbations, i.e. the gene set test statistics (or p-values) in pseudo-

color.

There are frequently multiple significant gene sets that share multiple member genes or represent the same regulatory
mechanism. Such redundancy in signficant gene set could be misleading too. A pathway or functional group itself is
not relevant, but may be called signficant because it share multiple perturbed genes with one really significant gene set.
We derive the non-redundant signficant gene set lists, with result output as tab-delimited text files automatically below.
Here, function esset.grp calls redundant gene sets to be those overlap heavily in their core genes. Core genes are
those member genes that really contribute to the signficance of the gene set in GAGE analysis. Arguement pc is the
cutoff p-value for the overlap between gene sets, default to 10e-10, may need trial-and-error to find the optimal value in
minor cases. Note that we use small pc because redundant gene sets are not just signficant in overlap, but are HIGHLY
significant so.

> gse16873.kegg.esg.up <- esset.grp(gse16873.kegg.p$greater,
gse16873, gsets = kegg.gs, ref = hn, samp = dcis,
+
test4up = T, output = T, outname = "gse16873.kegg.up", make.plot = F)
+
> gse16873.kegg.esg.dn <- esset.grp(gse16873.kegg.p$less,
+
+
> names(gse16873.kegg.esg.up)

gse16873, gsets = kegg.gs, ref = hn, samp = dcis,
test4up = F, output = T, outname = "gse16873.kegg.dn", make.plot = F)

[1] "essentialSets"
[4] "connectedComponent" "overlapCounts"
[7] "coreGeneSets"

"setGroups"

"allSets"
"overlapPvals"

> head(gse16873.kegg.esg.up$essentialSets, 4)

[1] "hsa04141 Protein processing in endoplasmic reticulum"
[2] "hsa00190 Oxidative phosphorylation"
[3] "hsa03050 Proteasome"
[4] "hsa04142 Lysosome"

> head(gse16873.kegg.esg.up$setGroups, 4)

[[1]]
[1] "hsa04141 Protein processing in endoplasmic reticulum"

[[2]]
[1] "hsa00190 Oxidative phosphorylation" "hsa04714 Thermogenesis"

[[3]]

11

Figure 1: Example heatmaps generated with sigGeneSet function as to show whole gene set perturbations. Upper
panel: signficant KEGG pathways in 1-directional (either up or down) test; lower panel: signficant KEGG pathways in
2-directional test. Only gene set test statistics are shown, heatmaps for -log10(p-value) look similar.

12

DCIS_1DCIS_2DCIS_3DCIS_4DCIS_5DCIS_6hsa04670 Leukocyte transendothelial migrationhsa00410 beta−Alanine metabolismhsa04550 Signaling pathways regulating pluripotency of stem cellshsa04742 Taste transductionhsa04750 Inflammatory mediator regulation of TRP channelshsa04371 Apelin signaling pathwayhsa04014 Ras signaling pathwayhsa04740 Olfactory transductionhsa04072 Phospholipase D signaling pathwayhsa04310 Wnt signaling pathwayhsa04810 Regulation of actin cytoskeletonhsa04015 Rap1 signaling pathwayhsa00430 Taurine and hypotaurine metabolismhsa04360 Axon guidancehsa04270 Vascular smooth muscle contractionhsa04510 Focal adhesionhsa04218 Cellular senescencehsa04215 Apoptosis − multiple specieshsa04114 Oocyte meiosishsa04120 Ubiquitin mediated proteolysishsa04144 Endocytosishsa00511 Other glycan degradationhsa01212 Fatty acid metabolismhsa04146 Peroxisomehsa04620 Toll−like receptor signaling pathwayhsa04721 Synaptic vesicle cyclehsa00500 Starch and sucrose metabolismhsa00520 Amino sugar and nucleotide sugar metabolismhsa01250 Biosynthesis of nucleotide sugarshsa04714 Thermogenesishsa01240 Biosynthesis of cofactorshsa00510 N−Glycan biosynthesishsa04612 Antigen processing and presentationhsa04142 Lysosomehsa00190 Oxidative phosphorylationGAGE test statistics−404ValueColor KeyDCIS_1DCIS_2DCIS_3DCIS_4DCIS_5DCIS_6hsa00982 Drug metabolism − cytochrome P450hsa04216 Ferroptosishsa01232 Nucleotide metabolismhsa00983 Drug metabolism − other enzymeshsa04923 Regulation of lipolysis in adipocyteshsa04022 cGMP−PKG signaling pathwayhsa01212 Fatty acid metabolismhsa04960 Aldosterone−regulated sodium reabsorptionhsa04916 Melanogenesishsa00430 Taurine and hypotaurine metabolismhsa00340 Histidine metabolismhsa04141 Protein processing in endoplasmic reticulumhsa03320 PPAR signaling pathwayhsa04530 Tight junctionhsa00480 Glutathione metabolismhsa04520 Adherens junctionhsa04612 Antigen processing and presentationhsa04310 Wnt signaling pathwayhsa04540 Gap junctionhsa04670 Leukocyte transendothelial migrationhsa04015 Rap1 signaling pathwayhsa00053 Ascorbate and aldarate metabolismhsa04915 Estrogen signaling pathwayhsa04668 TNF signaling pathwayhsa01040 Biosynthesis of unsaturated fatty acidshsa04810 Regulation of actin cytoskeletonhsa04115 p53 signaling pathwayhsa04610 Complement and coagulation cascadeshsa04270 Vascular smooth muscle contractionhsa04978 Mineral absorptionhsa04145 Phagosomehsa04514 Cell adhesion moleculeshsa04926 Relaxin signaling pathwayhsa04151 PI3K−Akt signaling pathwayhsa04974 Protein digestion and absorptionhsa04512 ECM−receptor interactionhsa04510 Focal adhesionGAGE test statistics02ValueColor Key[1] "hsa03050 Proteasome"

[[4]]
[1] "hsa04142 Lysosome"

"hsa00511 Other glycan degradation"

> head(gse16873.kegg.esg.up$coreGeneSets, 4)

[1] "51128" "2923"
"3309"

$`hsa04141 Protein processing in endoplasmic reticulum`
"10130" "3312"
"10970" "3301"
"7323"
"7494"
"6748"
"6185"
"56886" "5887"
"10294" "10483" "7415"
"9978"
"5601"
"10134"

[10] "811"
[19] "6184" "821"
[28] "79139" "3320"
[37] "29927" "9871"
[46] "57134" "6396"

"22872" "6500"

"9451"
"64374" "10525" "7466"
"1603"
"6745"
"5034"
"30001" "64215" "7184"

"23480" "9601"

"10808"
"7095"
"5611"

"23471" "22926" "11231"

$`hsa00190 Oxidative phosphorylation`

[1] "1345" "4720"
[10] "29796" "9377"
[19] "518"
"4696"
[28] "4701" "4702"

"54205" "4710"
"4711"
"1537"
"509"

"528"
"1340"

"51382" "4709"
"514"
"4708"

"51606" "27089" "533"

"10975" "51079" "10312" "8992"
"4694"
"54539" "537"
"521"

$`hsa03050 Proteasome`

[1] "5691" "10213" "5684"
"5720"

[10] "9861" "5705"
[19] "5707"

$`hsa04142 Lysosome`
[1] "3920" "1509"
[10] "55353" "2990"
[19] "5476" "9741"
[28] "8763" "10239" "7805"

"2517"
"1520"
"967"

"5685"
"5687"

"5701"
"7979"

"5688"
"5708"

"51371" "5692"
"5696"
"5690"

"5714"
"5718"

"1213"
"427"
"1514"
"537"

"1508"
"533"

"2720"
"5660"
"10312" "2799"
"3988"

"51606" "1512"
"10577" "27074" "23312"
"3074"
"1075"

"4126"

"54"

We may extract the gene expression data for top gene sets, output and visualize these expression data for further
intepretation. Although we can check expression data in each top gene set one by one, here we work on the top 3 up-
regulated KEGG pathways in a batch. The key functions we use here are, essGene (for extract genes with substiantial
or above-background expression changes in gene sets) and geneData (for output and visualization of expression data in
gene sets).

> rownames(gse16873.kegg.p$greater)[1:3]

[1] "hsa04141 Protein processing in endoplasmic reticulum"
[2] "hsa00190 Oxidative phosphorylation"
[3] "hsa03050 Proteasome"

> gs=unique(unlist(kegg.gs[rownames(gse16873.kegg.p$greater)[1:3]]))
> essData=essGene(gs, gse16873, ref =hn, samp =dcis)
> head(essData, 4)

HN_1

DCIS_1
1345 9.109413 9.373454 10.988181 9.161435 11.032016 11.231293 12.675099
8.840405
5691 8.283191 7.716745

7.553621 8.381538

7.768811

7.635745

HN_5

HN_2

HN_3

HN_6

HN_4

13

51128 7.424312 7.970012
9.362371 9.150221
2923

8.034436 6.806669
8.537944 8.828966

8.508019
9.890736

8.523295
8.636513
9.980784 11.168409

DCIS_2

DCIS_3
11.231271 12.547915

DCIS_4

DCIS_5

DCIS_6
8.979639 13.470266 12.156052
7.713826
7.956182
7.782958 11.910352
8.037517
8.740153
8.845460
9.060658
9.752254 10.529351 10.242883
9.176227

1345
5691
8.125168
51128 8.639654
9.396683
2923

> ref1=1:6
> samp1=7:12
> for (gs in rownames(gse16873.kegg.p$greater)[1:3]) {
+
+
+
+
+ }

outname = gsub(" |:|/", "_", substr(gs, 10, 100))
geneData(genes = kegg.gs[[gs]], exprs = essData, ref = ref1,

samp = samp1, outname = outname, txt = T, heatmap = T,
Colv = F, Rowv = F, dendrogram = "none", limit = 3, scatterplot = T)

Figure 2 shows example heatmap and scatter plots generated by the code chunk above. Notice that this heatmap
Figure 2 is somewhat inconsistent from the scatter plot, because the heatmap compares all samples with each other (hence
unpaired samples assumed), yet the scatter plot Figure 2 incorporate the experiment design information and compare the
match sample pairs only. The same inconsistency is also shown in Figure 3.

Sometimes, we may also want to check the expression data for all genes in a top gene set, rather than just those above-
background genes selected using essGene as above. Notice in this case (Figure 3), the heatmap may less informative
than the one in Figure 2 due to the inclusion of background noise.

outname = gsub(" |:|/", "_", substr(gs, 10, 100))
outname = paste(outname, "all", sep=".")
geneData(genes = kegg.gs[[gs]], exprs = gse16873, ref = hn,

> for (gs in rownames(gse16873.kegg.p$greater)[1:3]) {
+
+
+
+
+
+ }

samp = dcis, outname = outname, txt = T, heatmap = T,
Colv = F, Rowv = F, dendrogram = "none", limit = 3, scatterplot = T)

Starting from BioC 2.12 (R-2.16), we can visualize the KEGG pathway analysis results using a new package called
pathview (Luo and Brouwer, 2013). Of course, you may manually installed the package with earlier BioC or R versions.
Note that pathview can view our expression perturbation patterns on two styles of pathway graphs: KEGG view or
Graphviz view ((Figure 4). All we need is to supply our data (expression changes) and specify the target pathway.
Pathview automatically downloads the pathway graph data, parses the data file, maps user data to the pathway, and
renders pathway graph with the mapped data. For demonstratoin, let’s look at a couple of selected pathways.

> library(pathview)
> gse16873.d <- gse16873[ ,dcis] - gse16873[ ,hn]
> path.ids=c("hsa04110 Cell cycle", "hsa00020 Citrate cycle (TCA cycle)")
> path.ids2 <- substr(path.ids, 1, 8)
> #native KEGG view
> pv.out.list <- sapply(path.ids2, function(pid) pathview(gene.data = gse16873.d[,
+
> #Graphviz view
> pv.out.list <- sapply(path.ids2, function(pid) pathview(gene.data = gse16873.d[,
+
+

1:2], pathway.id = pid, species = "hsa", kegg.native=F,
sign.pos="bottomleft"))

1:2], pathway.id = pid, species = "hsa"))

14

Figure 2: Example heatmap and scatter plot generated with geneData function to show the gene expresion perturbations
in specified gene set(s). Only HN (control) and DCIS (experiment) data from the first two patients are plotted in the scatter
plot.

15

HN_1HN_2HN_3HN_4HN_5HN_6DCIS_1DCIS_2DCIS_3DCIS_4DCIS_5DCIS_613464984698471193775335160647095138247105420547201345−20ValueColor Key789101112789101112ControlExperimentSample 1Sample 2Figure 3: Example heatmap and scatter plot generated with geneData function to show the gene expresion perturbations
in specified gene set(s). Only HN (control) and DCIS (experiment) data from the first two patients are plotted in the scatter
plot. And all genes in a gene set are included here.

16

HN_1HN_2HN_3HN_4HN_5HN_6DCIS_1DCIS_2DCIS_3DCIS_4DCIS_5DCIS_695519377916789927384640776390546454205537534529527525522518516515513510795064984954728472547234720471847144712471047084706470447014698469646942979627068155066135513521350134713451339132710632−202ValueColor Key789101112789101112ControlExperimentSample 1Sample 2(a)

(b)

Figure 4: Visualize GAGE pathway analysis results using pathview (a) KEGG view of hsa00020 Citrate cycle (TCA
cycle) or (b) Graphviz view of hsa04110 Cell cycle.

17

+p+p+p+p−p+p+p+p+p+p+p+p+p−p−p−p−p−p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+u+u+u+u+uSMAD4SMAD2CDK2CCNE1CDK7CCNHCDK2CCNA2CDK1CCNA2CDK1CCNB1CDK4CCND1SKP1SKP2SKP1SKP2CDC20CDC27FZR1CDC27BUB1BMAD2L1BUB3SMC3STAG1RAD21SMC1ATFDP1E2F4TFDP1E2F1RBL1E2F4TFDP1FBXO5CDKN2APCNAPLK1ATMBUB1CDC14BYWHABSFNCHEK1CDKN1APRKDCMDM2CREBBPPKMYT1WEE1PTTG1ESPL1RB1GADD45ARB1TP53CDKN1BCDKN2BTGFB1CDC25BCDC6CDC25AGSK3BMAD1L1TTKCDKN2CCDKN2DCDKN2AMYCZBTB17ABL1HDAC1RB1RBL2CDKN1ATP53−1 0 1−Data with KEGG pathway−−Rendered  by  Pathview−Edge typescompoundhidden compoundactivationinhibitionexpressionrepressionindirect effectstate changebinding/associationdissociationphosphorylation+pdephosphorylation−pglycosylation+gubiquitination+umethylation+mothers/unknown?This pathway graph based data visualization can be simply applied to all selected pathways in a batch. In other words,
in a few lines of code, we may connect gage to pathview for large-scale and fully automated pathway analysis and results
visualization.

> sel <- gse16873.kegg.p$greater[, "q.val"] < 0.1 & !is.na(gse16873.kegg.p$greater[,
+ "q.val"])
> path.ids <- rownames(gse16873.kegg.p$greater)[sel]
> path.ids2 <- substr(path.ids, 1, 8)
> pv.out.list <- sapply(path.ids2, function(pid) pathview(gene.data = gse16873.d[,
+

1:2], pathway.id = pid, species = "hsa"))

Note the Pathview Web server provides a comprehensive workflow for both regular and integrated pathway analysis

of multiple omics data (Luo et al., 2017), as shown in Example 4 online.

9 Advanced Analysis

We frequently need to do GAGE analysis repetitively on mulitple comparisons (with different samples vs references) in
a study, or even with different analysis options (paired or unpaired samples, use or not use rank test etc). We can carry
these different analyses with different sub-datasets all at once using a composite funciton, gagePipe. Different from
gage, gagePipe accepts lists of reference/sample column numbers, with matching lists/vectors of other arguements.
Function gagePipe runs multiple rounds of GAGE in a batch without interference, and outputs signficant gene set lists
in text format and save the results in .RData format.

> #introduce another half dataset
> library(gageData)
> data(gse16873.2)
> cn2=colnames(gse16873.2)
> hn2=grep('HN',cn2, ignore.case =T)
> dcis2=grep('DCIS',cn2, ignore.case =T)
> #batch GAGE analysis on the combined dataset
> gse16873=cbind(gse16873, gse16873.2)
> dataname='gse16873' #output data prefix
> sampnames=c('dcis.1', 'dcis.2')
> refList=list(hn, hn2+12)
> sampList=list(dcis, dcis2+12)
> gagePipe(gse16873, gsname = "kegg.gs", dataname = "gse16873",
+
+

sampnames = sampnames, ref.list = refList, samp.list = sampList,
comp.list = "paired")

We may further loaded the .RData results, and do more analysis. For instance, we may compare the GAGE analysis
results from the differen comparisons or different sub-datasets we have worked on. Here, the main function to use
is gageComp. Comparison rsults between multiple GAGE analyses will be output as text files and optionally, venn
diagram can be plotted in PDF format as shown in Figure 5.

> load('gse16873.gage.RData')
> gageComp(sampnames, dataname, gsname = "kegg.gs",
+

do.plot = TRUE)

GAGE with single array analysis design also provide a framework for combined analysis accross heterogeneous
microarray studies/experiments. The combined dataset of gse16873 and gse16873.2 provids a good example of het-
erogeneous data. As mentioned above, the two half-datasets were processed using FARMS (Hochreiter et al., 2006) and

18

Figure 5: An example venn diagram generated with gageComp function. Compared are KEGG pathway results for the
two half datasets when gagePipe was applied above.

Figure 6: Sample-wise gene expression level distributions for GSE16873 with the two differently processed half datasets.

RMA (Irizarry et al., 2003) methods separately. Therefore, the expression values and distributions are dramatically dif-
ferent between the two halves. Using function heter.gage we can do some combined analysis on such heterogeneous
dataset(s). heter.gage is similar to gagePipe in that ref.list and samp.list arguements need to be lists of
column numbers with matching vector of the compare arguement. Different from gagePipe, heter.gage does one
combined GAGE analysis on all data instead of multiple separate analyses on different sub-datasets/comparisons.

Just to have an idea on how heterogeneous these two half datasets are, we may visualize the expression level distribu-

tions (Figure 6):

19

dcis.1dcis.2189122019up18128526downHN_1HN_3HN_5HN_7HN_9HN_11468101214> boxplot(data.frame(gse16873))
> gse16873.kegg.heter.p <- heter.gage(gse16873, gsets = kegg.gs,
+
> gse16873.kegg.heter.2d.p <- heter.gage(gse16873, gsets = kegg.gs,
ref.list = refList, samp.list = sampList, same.dir = F)
+

ref.list = refList, samp.list = sampList)

We may compare the results from this combined analysis of the combined dataset vs the analysis on the first half
dataset above. As expected the top gene sets from this combined analysis are consistent yet with smaller p-values due to
the use of more data.

10 Common Errors

• Gene sets and expression data use different ID systems (Entrez Gene ID, Gene symbol or probe set ID etc). To cor-
rect, use functions like eg2sym or sym2eg, or check vignette, "Gene set and data preparation", for more solutions. If
you used customized CDF file based on Entrez Gene to processed the raw data, do: rownames(gse16873)=gsub('_at', '', rownames(gse16873)).

• We use gene set data for a different species than the expression data, e.g. use kegg.mm instead of kegg.gs for hu-

man data. When running gage or gagePipe function, we get error message like, Error in if (is.na(spval[i])) tmp[i] <- NA : argument is of length zero.

• Expression data have multiple probesets (as in Affymetrix GeneChip Data) for a single gene, but gene set analysis
requires one entry per gene. You may pick up the most differentially expressed probeset for a gene and discard the
rest, or process the raw intensity data using customized probe set definition (CDF file), where probes are re-mapped
on a gene by gene base. Check the Methods section of GAGE paper (Luo et al., 2009) for details.

• Expression data have genes as columns and samples/chips as rows, i.e.

in a transposed form. To correct, do:

expdata=t(expdata).

References

Lyndsey A. Emery, Anusri Tripathi, Chialin King, Maureen Kavanah, Jane Mendez, Michael D. Stone, Antonio de las
Morenas, Paola Sebastiani, and Carol L. Rosenberg. Early dysregulation of cell adhesion and extracellular matrix
pathways in breast cancer progression. The American journal of pathology, 175:1292–1302, 2009.

Sepp Hochreiter, Djork-Arne Clevert, and Klaus Obermayer. A new summarization method for affymetrix probe level

data. Bioinformatics, 22:943–949, 2006.

Rafael A. Irizarry, Bridget Hobbs, Francois Collin, Yasmin D. Beazer-Barclay, Kristen J. Antonellis, Uwe Scherf, and
Terence P. Speed. Exploration, normalization, and summaries of high density oligonucleotide array probe level data.
Biostatistics, 2003. To appear.

SY Kim and DJ Volsky. PAGE: parametric analysis of gene set enrichment. BMC Bioinformatics, 6:144, 2005.

Weijun Luo and Cory Brouwer.

visualization. Bioinformatics, 29(14):1830–1831, 2013.
bioinformatics.oxfordjournals.org/content/29/14/1830.full.

Pathview: an R/Bioconductor package for pathway-based data integration and
doi: 10.1093/bioinformatics/btt285. URL http://

Weijun Luo, Michael Friedman, Kerby Shedden, Kurt Hankenson, and Peter Woolf. GAGE: generally applicable gene set
enrichment for pathway analysis. BMC Bioinformatics, 10(1):161, 2009. URL http://www.biomedcentral.
com/1471-2105/10/161.

Weijun Luo, Gaurav Pant, Yeshvant K Bhavnasi, Steven G Blanchard, and Cory Brouwer. Pathview Web: user friendly
pathway visualization and data integration. Nucleic Acids Research, Web server issue:gkx372, 2017. doi: 10.1093/nar/
gkx372. URL https://academic.oup.com/nar/article-lookup/doi/10.1093/nar/gkx372.

20

