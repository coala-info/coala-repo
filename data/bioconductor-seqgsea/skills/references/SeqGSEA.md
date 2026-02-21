Gene set enrichment analysis of RNA-Seq data with
the SeqGSEA package

Xi Wang1,2 and Murray Cairns1,2,3

October 30, 2025

1School of Biomedical Sciences and Pharmacy, The University of Newcastle, Callaghan, New South
Wales, Australia
2Hunter Medical Research Institute, New Lambton, New South Wales, Australia
3Schizophrenia Research Institute, Sydney, New South Wales, Australia

xi.wang@mdc-berlin.de

1 Introduction
1.1 Background . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2 Getting started . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.3 Package citation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Differential splicing analysis and DS scores
2.1 The ReadCountSet class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 DS analysis and DS scores . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 DS permutation p-values . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Differential expression analysis and DE scores
3.1 Gene read count data from ReadCountSet class . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 DE analysis and DE scores
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 DE permutation p-values

4 Integrative GSEA runs
4.1 DE/DS score integration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2
4.3
. . . . . . . . . . . . . . . . . . . . . . . . .
4.4 SeqGSEA result displays . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Initialization of SeqGeneSet objects
running GSEA with integrated gene scores

5 Running SeqGSEA with multiple cores
5.1 R-parallel packages . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . .
5.2 Parallelizing analysis on permutation data sets

6 Analysis examples
6.1 Starting from your own RNA-Seq data . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Exemplified pipeline for integrating DE and DS . . . . . . . . . . . . . . . . . . . . . . .
6.3 Exemplified pipeline for DE-only analysis . . . . . . . . . . . . . . . . . . . . . . . . . .
6.4 One-step SeqGSEA analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7 Session information

2
2
2
2

2
2
3
5

6
6
6
7

8
8
10
11
11

13
13
14

14
14
15
17
18

19

1

1

Introduction

1.1 Background

Transcriptome sequencing (RNA-Seq) has become a key technology in transcriptome studies because
it can quantify overall expression levels and the degree of alternative splicing for each gene simul-
taneously. Many methods and tools, including quite a few R/Bioconductor packages, have been
developed to deal with RNA-Seq data for differential expression analysis and thereafter functional
analysis aiming at novel biological and biomedical discoveries. However, those tools mainly focus on
each gene’s overall expression and may miss the opportunities for discoveries regarding alternative
splicing or the combination of the two.

SeqGSEA is novel R/Bioconductor package to derive biological insight by integrating differential
expression (DE) and differential splicing (DS) from RNA-Seq data with functional gene set analysis.
Due to the digital feature of RNA-Seq count data, the package utilizes negative binomial distributions
for statistical modeling to first score differential expression and splicing in each gene, respectively.
Then, integration strategies are applied to combine the two scores for integrated gene set enrichment
analysis. See the publications Wang and Cairns (2013) and Wang and Cairns (2014) for more
details. The SeqGSEA package can also give detection results of differentially expressed genes and
differentially spliced genes based on sample label permutation.

1.2 Getting started

The SeqGSEA depends on Biobase for definitions of class ReadCountSet and class SeqGeneSet,
DESeq2 for differential expression analysis, biomaRt for gene IDs/names conversion, and doParallel
for parallelizing jobs to reduce running time. Make sure you have these dependent packages installed
before you install SeqGSEA.

To load the SeqGSEA package, type library(SeqGSEA). To get an overview of this package, type

?SeqGSEA.
> library(SeqGSEA)

> ? SeqGSEA

In this Users’ Guide of the SeqGSEA package, an analysis example is given in Section 6, and
detailed guides for DE, DS, and integrative GSEA analysis are given in Sections 3, 2, and 4, respec-
tively. A guide to parallelize those analyses is given in Section 5.

1.3 Package citation

To cite this package, please cite the article below:
Wang X and Cairns MJ (2014). SeqGSEA: a Bioconductor package for gene set enrichment
analysis of RNA-Seq data integrating differential expression and splicing. Bioinformatics,
30(12):1777-9.

To cite/discuss the method used in this package, please cite the article below:

Wang X and Cairns MJ (2013). Gene set enrichment analysis of RNA-Seq data: integrating
differential expression and splicing. BMC Bioinformatics, 14(Suppl 5):S16.

2 Differential splicing analysis and DS scores

2.1 The ReadCountSet class

To facilitate differential splicing (DS) analysis, SeqGSEA saves exon read count data using Read-
CountSet class, which is derived from eSet. While below is an example showing the steps to create a
new ReadCountSet object, creating a ReadCountSet object from your own data should refer to Section
6.

2

> rcounts <- cbind(t(sapply(1:10, function(x) {rnbinom(5, size=10, prob=runif(1))} )),
+
t(sapply(1:10, function(x) {rnbinom(5, size=10, prob=runif(1))} )))
> colnames(rcounts) <- c(paste("S", 1:5, sep=""), paste("C", 1:5, sep=""))
> geneIDs <- c(rep("G1", 4), rep("G2", 6))
> exonIDs <- c(paste("E", 1:4, sep=""), paste("E", 1:6, sep=""))
> RCS <- newReadCountSet(rcounts, exonIDs, geneIDs)
> RCS

ReadCountSet (storageMode: environment)
assayData: 10 features, 10 samples

element names: counts

protocolData: none
phenoData

sampleNames: S1 S2 ... C5 (10 total)
varLabels: label
varMetadata: labelDescription

featureData

featureNames: 1 2 ... 10 (10 total)
fvarLabels: exonIDs geneIDs ... padjust (10 total)
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

2.2 DS analysis and DS scores

To better illustrate DS analysis functions, we load an example ReadCountSet object from a real
RNA-Seq data set as follows.

> data(RCS_example, package="SeqGSEA")
> RCS_example

ReadCountSet (storageMode: environment)
assayData: 5000 features, 20 samples

element names: counts

protocolData: none
phenoData

sampleNames: S1 S2 ... C10 (20 total)
varLabels: label
varMetadata: labelDescription

featureData

featureNames: ENSG00000000003:001 ENSG00000000003:002 ...

ENSG00000007402:038 (5000 total)

fvarLabels: exonIDs geneIDs ... padjust (10 total)
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

This example ReadCountSet object is comprised of 20 samples and 5,000 exons, part of the prostate
cancer RNA-Seq data set (Kannan et al., 2011). With the function geneID and the script below, we
can easily check the number of genes involved in this data set.

> length(unique(geneID(RCS_example)))

[1] 182

3

Noticed that some exons are too short or not expressed, we should first filter out these exons
from following analysis to secure the robustness of our analysis. By default, function exonTestablity
marks exons with the sum of read counts across all samples less than cutoff (default: 5) to be
excluded in downstream analysis. Users can also exclude genes with no or low expression from
downstream analysis by checking geneTestability.

> RCS_example <- exonTestability(RCS_example, cutoff = 5)

Then, the main DS analysis is executed using function estiExonNBstat for exon DS NB-statistics
and function estiGeneNBstat for gene DS NB-statistics by averaging exon NB-statistics. Please refer
to Wang et al. (2013) for detailed statistic analysis regarding differential splicing from exon count
data.

> RCS_example <- estiExonNBstat(RCS_example)
> RCS_example <- estiGeneNBstat(RCS_example)
> head(fData(RCS_example)[, c("exonIDs", "geneIDs", "testable", "NBstat")])

exonIDs

geneIDs testable

ENSG00000000003:001
ENSG00000000003:002
ENSG00000000003:003
ENSG00000000003:004
ENSG00000000003:005
ENSG00000000003:006

E001 ENSG00000000003
E002 ENSG00000000003
E003 ENSG00000000003
E004 ENSG00000000003
E005 ENSG00000000003
E006 ENSG00000000003

NBstat
TRUE 2.0219857
TRUE 0.2486443
TRUE 0.1238136
TRUE 1.2058520
TRUE 2.0668287
TRUE 0.2678247

We run DS analysis on the permutation data sets as well. Here we set to run permutation 20
times for demonstration; however, in practice at least 1,000 permutations are recommended. To do
so, we first generate a permutation matrix, each column corresponding to each permutation; then
run DS analysis on the permutation data sets, and updated permute_NBstat_gene slot for results.

> permuteMat <- genpermuteMat(RCS_example, times=20)
> RCS_example <- DSpermute4GSEA(RCS_example, permuteMat)
> head(RCS_example@permute_NBstat_gene)

result.2

result.1

result.3 result.4 result.5

result.6
ENSG00000000003 0.9088383 0.3270393 4.4749991 2.043075 0.6692977 0.3791328
ENSG00000000005 0.2235024 0.8683922 0.3928971 0.519017 0.2421182 0.5219960
ENSG00000000419 0.2417217 0.3671991 3.2551246 1.480494 0.6717145 1.0517086
ENSG00000000457 1.0940273 0.4919225 1.4068377 1.507591 0.5473056 0.9305822
ENSG00000000460 0.6773329 0.7441965 0.8431269 1.048523 0.7003146 0.2267285
ENSG00000000938 1.6176195 1.2111947 1.9997236 1.649965 1.2266551 0.8006476

result.8

result.7

result.9 result.10 result.11 result.12
ENSG00000000003 1.1979670 0.5541813 0.6260105 0.8993498 0.6459810 2.1802211
ENSG00000000005 0.6131330 1.2205165 0.7329634 0.1141962 0.5056750 0.4729924
ENSG00000000419 2.8618086 0.4460506 1.3301634 0.6563594 0.4700923 1.8559456
ENSG00000000457 0.6727303 0.8664805 1.4944965 0.5354708 0.5963168 2.0110645
ENSG00000000460 0.7803585 1.0226817 1.0455554 0.5689321 0.6502268 0.7259405
ENSG00000000938 0.9193889 0.8208677 1.6657126 1.2742865 1.1803647 1.4620364
result.13 result.14 result.15 result.16 result.17 result.18
ENSG00000000003 0.6817595 0.6083795 0.4685096 0.5417357 0.7698947 0.5731943
ENSG00000000005 0.2274879 0.4810599 0.5988559 0.3029846 0.2167540 0.2383166
ENSG00000000419 1.0082769 0.8034847 0.3985097 0.6252743 0.6208564 0.5597595
ENSG00000000457 1.4494655 0.5237331 1.0145053 0.5349726 1.0059844 1.9778239
ENSG00000000460 0.6622904 0.6477971 0.7058555 0.3250431 0.8936534 0.8040492
ENSG00000000938 1.3055561 1.4506627 0.8871722 0.7961976 1.4507470 1.0637337

4

result.19 result.20
ENSG00000000003 0.3837683 0.4533491
ENSG00000000005 0.5205095 0.6391922
ENSG00000000419 1.1410121 1.1423297
ENSG00000000457 1.1027261 0.8410818
ENSG00000000460 1.0215145 0.6600586
ENSG00000000938 1.2926512 1.0212004

The DS NB-statistics from the permutation data sets offer an empirical background of NB-
statistics on the real data set. By normalizing NB-statistics against this background, we get the DS
scores, which will be used in integrated GSEA runs (Section 4).

> DSscore.normFac <- normFactor(RCS_example@permute_NBstat_gene)
> DSscore <- scoreNormalization(RCS_example@featureData_gene$NBstat,
+
> DSscore.perm <- scoreNormalization(RCS_example@permute_NBstat_gene,
+
> DSscore[1:5]

DSscore.normFac)

DSscore.normFac)

ENSG00000000003 ENSG00000000005 ENSG00000000419 ENSG00000000457 ENSG00000000460
1.0181062

1.6046771

0.9457756

1.4872108

2.8239610

> DSscore.perm[1:5,1:10]

result.2

result.1

result.6
ENSG00000000003 0.9375903 0.3373855 4.6165700 2.107710 0.6904716 0.3911270
ENSG00000000005 0.4630945 1.7992992 0.8140785 1.075398 0.5016663 1.0815702
ENSG00000000419 0.2303440 0.3499153 3.1019081 1.410808 0.6400974 1.0022054
ENSG00000000457 1.0618985 0.4774760 1.3655226 1.463317 0.5312327 0.9032534
ENSG00000000460 0.9181573 1.0087941 1.1428990 1.421324 0.9493102 0.3073414

result.3 result.4 result.5

result.8

result.7

result.9 result.10
ENSG00000000003 1.235866 0.5717134 0.6458149 0.9278016
ENSG00000000005 1.270405 2.5288970 1.5186923 0.2366132
ENSG00000000419 2.727105 0.4250553 1.2675535 0.6254650
ENSG00000000457 0.652974 0.8410342 1.4506070 0.5197454
ENSG00000000460 1.057814 1.3862943 1.4173007 0.7712149

2.3 DS permutation p-values

Besides calculating DS scores, based on the NB statistics on the real data set and the permutation
data sets, we can also calculate a permutation p-value for each gene’s DS significance in the studied
data set.

> RCS_example <- DSpermutePval(RCS_example, permuteMat)
> head(DSresultGeneTable(RCS_example))

NBstat pvalue

geneID
1 ENSG00000000003 1.4416043
2 ENSG00000000005 0.4564578
3 ENSG00000000419 1.6839390
4 ENSG00000000457 2.9094026
5 ENSG00000000460 0.7510661
6 ENSG00000000938 1.7949049

padjust
0.15 0.2400000
0.60 0.6400000
0.15 0.2400000
0.00 0.0000000
0.40 0.4888889
0.05 0.1396825

The adjusted p-values accounting for multiple testings were given by the BH method (Benjamini
and Hochberg, 1995). Users can also apply function topDSGenes and function topDSExons to quickly
get the most significant DS genes and exons, respectively.

5

3 Differential expression analysis and DE scores

3.1 Gene read count data from ReadCountSet class

For gene DE analysis, read counts on each gene should be first calculated. With SeqGSEA, users
usually analyze DE and DS simultaneously, so the package includes the function getGeneCount to
facilitate gene read count calculation from a ReadCountSet object.

> geneCounts <- getGeneCount(RCS_example)
> dim(geneCounts) # 182

20

[1] 182 20

> head(geneCounts)

3

4

4

1

7

2

1

0

C1

C4

S4

S7

S1

S5 S6

S2 S3

C2 C3

S8 S9 S10

C5
ENSG00000000003 495 235 386 272 255 815 1065 803 839 885 278 270 238 175 292
1
2 12
ENSG00000000005 19
343 307 342 280 179 156 100 120 126
ENSG00000000419 196 134 165 184 132 344
43
62
344 277 337 249
72 102 219
ENSG00000000457 97
52
34 19
48 36
47 105
ENSG00000000460 52
124 80 156 145
79 20
59
71
14
ENSG00000000938 27
C9 C10
C6
519 621 475 560
ENSG00000000003 432
46
ENSG00000000005
9
255 171 164 201
ENSG00000000419 169
165 131 183 185
ENSG00000000457 170
38
ENSG00000000460 68
48 72
90
ENSG00000000938 103 1285 137 156

78 141
35
44

48 40
21
32

74 146 148 165 48

48 25
57 43

C7 C8

14

90

1

3

2

0

4

This function results in a matrix of 182 rows and 20 columns, corresponding to 182 genes and 20
samples.

3.2 DE analysis and DE scores

DE analysis has been implemented in several R/Bioconductor packages, of which DESeq2 (Anders
and Huber, 2010) is mainly utilized in SeqGSEA for DE analysis. With DESeq2 , we can model
count data with negative binomial distributions for accounting biological variations and various
biases introduced in RNA-Seq. Given the read count data on individual genes and sample grouping
information, basic DE analysis based on DESeq2 including size factor estimation and dispersion
estimation, is encapsulated in the function runDESeq.

> label <- label(RCS_example)
> dds <- runDESeq(geneCounts, label)

The function runDESeq returns a DESeqDataSet object, which is defined in the DESeq2 package. The
DE analysis in the DESeq2 package continues with the output DESeqDataSet object and conducts
negative-binomial-based statistical tests for DE genes (using nbinomTest or nbinomGLMTest). However,
in this SeqGSEA package, we define NB statistics to quantify each gene’s expression difference
between sample groups.

The NB statistics for DE can be achieved by the following scripts.

> DEGres <- DENBStat4GSEA(dds)
> DEGres[1:5, "NBstat"]

[1]

0.51449518

0.32697507

0.02205611 13.22540371

1.24725584

6

Similarly, we run DE analysis on the permutation data sets as well. The permuteMat should be the
same as used in DS analysis on the permutation data sets.

> DEpermNBstat <- DENBStatPermut4GSEA(dds, permuteMat)
> DEpermNBstat[1:5, 1:10]

result.2

result.1

result.3

result.6
[1,] 0.3479544 1.076864999 5.4009198 0.03278313 0.636602299 0.79511468
[2,] 1.9158458 0.292005889 0.1832072 0.64373840 0.005961067 0.87306641
[3,] 0.2212346 0.099021443 6.5860494 0.25677612 0.026310463 1.08355515
[4,] 0.7306069 1.708170948 2.3295114 0.11077916 3.588610113 0.31226060
[5,] 0.2678153 0.004676131 2.3478227 0.38171430 0.039700553 0.03609905

result.4

result.5

result.7

result.9 result.10
result.8
[1,] 1.20784532 0.0115928380 0.1991948 1.6169834
[2,] 0.07588003 0.0008287551 3.3204730 4.1740690
[3,] 4.69137976 0.0114930574 0.8687596 0.1596217
[4,] 0.56097510 2.8180730369 1.5800179 0.2213153
[5,] 1.06488744 4.8661019317 0.8375062 0.0332133

Once again, the DE NB-statistics from the permutation data sets offer an empirical background,
so we can normalize NB-statistics against this background. By doing so, we get the DE scores, which
will also be used in integrated GSEA runs (Section 4).

> DEscore.normFac <- normFactor(DEpermNBstat)
> DEscore <- scoreNormalization(DEGres$NBstat, DEscore.normFac)
> DEscore.perm <- scoreNormalization(DEpermNBstat, DEscore.normFac)
> DEscore[1:5]

[1]

0.51957811

0.25424362

0.02112765 14.13156418

1.32344478

> DEscore.perm[1:5, 1:10]

result.2

result.1

result.3

result.6
[1,] 0.3513920 1.087503833 5.4542779 0.03310701 0.642891579 0.80296998
[2,] 1.4896902 0.227052887 0.1424551 0.50054697 0.004635103 0.67886387
[3,] 0.2119216 0.094853088 6.3088065 0.24596700 0.025202912 1.03794238
[4,] 0.7806656 1.825209113 2.4891218 0.11836938 3.834489685 0.33365566
[5,] 0.2841748 0.004961773 2.4912400 0.40503141 0.042125671 0.03830417

result.5

result.4

result.9

result.7

result.10
result.8
[1,] 1.21977816 0.0117073689 0.2011627 1.63295828
[2,] 0.05900148 0.0006444091 2.5818759 3.24560039
[3,] 4.49389390 0.0110092517 0.8321887 0.15290238
[4,] 0.59941124 3.0111579833 1.6882754 0.23647910
[5,] 1.12993636 5.1633489915 0.8886655 0.03524215

3.3 DE permutation p-values

Similar to DS analysis, comparing NB-statistics on the real data set and those on the permutation
data sets, we can get permutation p-values for each gene’s DE significance.

> DEGres <- DEpermutePval(DEGres, DEpermNBstat)
> DEGres[1:6, c("NBstat", "perm.pval", "perm.padj")]

ENSG00000000003 0.51449518

NBstat perm.pval perm.padj
1

0.55

7

ENSG00000000005 0.32697507
ENSG00000000419 0.02205611
ENSG00000000457 13.22540371
ENSG00000000460 1.24725584
ENSG00000000938 7.73813817

0.60
0.95
0.00
0.25
0.00

1
1
0
1
0

For a comparison to the nominal p-values from exact testing and forming comprehensive results,
users can run DENBTest first and then DEpermutePval, which generates results as follows.

> DEGres <- DENBTest(dds)
> DEGres <- DEpermutePval(DEGres, DEpermNBstat)
> DEGres[1:6, c("NBstat", "pval", "padj", "perm.pval", "perm.padj")]

NBstat

pval

ENSG00000000003 0.51449518 0.1112841241 0.24121931
ENSG00000000005 0.32697507 0.2310245778 0.38574746
ENSG00000000419 0.02205611 0.3643336232 0.52272077
ENSG00000000457 13.22540371 0.0008268416 0.01588092
ENSG00000000460 1.24725584 0.0816750168 0.21235504
ENSG00000000938 7.73813817 0.0006694334 0.01588092

padj perm.pval perm.padj
1
0.55
1
0.60
1
0.95
0
0.00
1
0.25
0
0.00

4

Integrative GSEA runs

4.1 DE/DS score integration

We have proposed two strategies for integrating normalized DE and DS scores (Wang and Cairns,
2013), one of which is the weighted summation of the two scores and the other is a rank-based
strategy. The functions geneScore and genePermuteScore implement two methods for the weighted
summation strategy: weighted linear combination and weighted quadratic combination. Scripts
below show a linear combination of DE and DS scores with weight for DE equal to 0.3. Users should
keep the weight for DE in geneScore and genePermuteScore the same, and the weight rangs from
0 (i.e., DS only) to 1 (i.e., DE only). Visualization of gene scores can be made by applying the
plotGeneScore function.

> gene.score <- geneScore(DEscore, DSscore, method="linear", DEweight = 0.3)
> gene.score.perm <- genePermuteScore(DEscore.perm, DSscore.perm,
+
> plotGeneScore(gene.score, gene.score.perm)

method="linear",

DEweight=0.3)

The plot generated by the plotGeneScore function (Fig. 1) can also be saved as a PDF file easily

with the pdf argument of plotGeneScore.

The functions geneScore and genePermuteScore also implement one method for the rank-based
integration strategy: using data-set-specific ranks. The plot for integrated gene scores is shown in
Fig. 2.

> gene.score <- geneScore(DEscore, DSscore, method="rank", DEweight = 0.3)
> gene.score.perm <- genePermuteScore(DEscore.perm, DSscore.perm,
+
> plotGeneScore(gene.score, gene.score.perm)

method="rank",

DEweight=0.3)

Rather than the above method to integrate scores with data-set-specific ranks, an alternative
method is implemented with the rankCombine function, which takes only the ranks from the real
data set for integrating DE and DS scores on both real and permutation data sets. This provides a
method in a global manner. The plot of gene scores is shown in Fig. 3.

8

Figure 1: Gene scores resulted from linear combination. Scores are sorted from the largest to the
smallest. Red, green, orange, blue dotted horizontal lines represent the maximum score, average
score on the real data set, and the maximum score, average score on the permutation data sets.

Figure 2: Gene scores resulted from rank-based combination with data-set-specific ranks. Scores are
sorted from the largest to the smallest. Red, green, orange, blue dotted horizontal lines represent
the maximum score, average score on the real data set, and the maximum score, average score on
the permutation data sets.

9

Figure 3: Gene scores resulted from rank-based combination with the same rank got from the
real data set. Scores are sorted from the largest to the smallest. Red, green, orange, blue dotted
horizontal lines represent the maximum score, average score on the real data set, and the maximum
score, average score on the permutation data sets.

> combine <- rankCombine(DEscore, DSscore, DEscore.perm, DSscore.perm, DEweight=0.3)
> gene.score <- combine$geneScore
> gene.score.perm <- combine$genePermuteScore
> plotGeneScore(gene.score, gene.score.perm)

Basically the integrated gene scores are distributed similarly with the three integration methods
at DE weight 0.3 (Figs. 1, 2, and 3); however, according to the analysis in Wang and Cairns (2013),
SeqGSEA can detect slightly more significant gene sets with rank-based integration strategy than
with linear combination.

4.2

Initialization of SeqGeneSet objects

To facilitate running gene set enrichment analysis, SeqGSEA implements a SeqGeneSet class. The Se-
qGeneSet class has several slots for accommodating a category of gene sets derived from any biological
knowledge-based databases such as Kyoto Encyclopedia of Genes and Genomes (KEGG). However,
we recommend to start with the formatted gene-set files from the well-maintained resource Molec-
ular Signatures Database (MSigDB, http://www.broadinstitute.org/gsea/msigdb/index.jsp)
(Subramanian et al., 2005). After downloading a gmt file from the above URL, users can use
loadGenesets to initialize a SeqGeneSet object easily. Please note that with the current version of
SeqGSEA, only gene sets with gene symbols are supported, though read count data’s gene IDs can
be either gene symbols or Ensembl Gene IDs.

Below is shown an example of the SeqGeneSet object, which contains information such as how

many gene sets in this object and the names/sizes/descriptions of each gene set.

> data(GS_example, package="SeqGSEA")
> GS_example

10

SeqGeneSet object: gs_symb.txt
GeneSetSourceFile: /Library/Frameworks/R.framework/Versions/2.15/Resources/library/SeqGSEA/extdata/gs_symb.txt
GeneSets: ERB2_UP.V1_DN

AKT_UP_MTOR_DN.V1_UP
...
KRAS.600.LUNG.BREAST_UP.V1_DN

with the number of genes in respective sets: 6, 6, ..., 5
brief descriptions:

http://www.broadinstitute.org/gsea/msigdb/cards/ERB2_UP.V1_DN
http://www.broadinstitute.org/gsea/msigdb/cards/AKT_UP_MTOR_DN.V1_UP
...
http://www.broadinstitute.org/gsea/msigdb/cards/KRAS.600.LUNG.BREAST_UP.V1_DN

# gene sets passed filter: 11
# gene sets excluded: 178

(#genes >= 5 AND <= 1000)

(#genes < 5 OR > 1000)

ES scores: not computed
ES postions: not computed
Permutated ES scores: not performed
ES scores normalized: No
ES p-value: not computed
ES FWER: not computed
ES FDR: not computed

4.3

running GSEA with integrated gene scores

With the initialized SeqGeneSet object and integrated gene scores as well as gene scores on the
permutation data sets, the main GSEnrichAnlyze can be executed; and the topGeneSets allows users
promptly access to the top significant gene sets.

> GS_example <- GSEnrichAnalyze(GS_example, gene.score, gene.score.perm)
> topGeneSets(GS_example, 5)

GSName GSSize

ES ES.pos pval

HOXA9_DN.V1_UP
8
TBK1.DF_UP
9
PKCA_DN.V1_DN
5
7
BMI1_DN.V1_DN
11 KRAS.600.LUNG.BREAST_UP.V1_DN

5 1.651142
5 1.834492
5 1.328147
6 1.149694
5 1.221814

FDR FWER
41 0.15 0.00000 0.45
25 0.00 0.00000 0.05
69 0.30 0.66667 0.90
23 0.20 0.70000 1.00
61 0.30 0.75000 1.00

The main GSEA includes several steps detailed in Wang and Cairns (2013) and its original
paper Subramanian et al. (2005). In SeqGSEA, functions calES, calES.perm, normES and signifES
are implemented to complete the analysis. Advanced users may set up customized pipelines with
the functions above themselves.

4.4 SeqGSEA result displays

Several functions in SeqGSEA can be employed for visualization of gene set enrichment analysis
running results. The plotES function is to plot the distribution of normalized enrichment scores
(NES) of all gene sets in a SeqGeneSet object on the observed data set versus its empirical background
provided by the NES on the permutation data sets (Fig. 4).

> plotES(GS_example)

The plotSig function plots the distributions of permutation p-value, false discovery rate (FDR)
and family-wise error rate (FWER) versus NES. The example plot is not shown in this vignette as
the distributions can be far from the real ones due to the limited permutation times.

11

Figure 4: Distribution of normalized enrichment scores (NES) on the observed and permutation
(null) data sets. Blue: observed NES density; Orange: each for NES density on one permutation
data set; Red: the average density on all permutation data sets; Black: observed NES values.

> plotSig(GS_example)

The plotSigGS function is to plot detailed results of a particular gene set that has been analyzed.
Information in the plot includes running enrichment scores, null NES on the permutation data sets.
See Fig. 5 for an example.

> plotSigGeneSet(GS_example, 9, gene.score) # 9th gene set is the most significant one.

Besides the functions to generate plots, the writeSigGeneSet function can write the detailed
information of any analyzed gene sets, including NES, p-values, FDR, and the leading set (see the
definition in Wang and Cairns (2013)). An example is shown below.

> writeSigGeneSet(GS_example, 9, gene.score) # 9th gene set is the most significant one.

gs_symb.txt:TBK1.DF_UP
5
http://www.broadinstitute.org/gsea/msigdb/cards/TBK1.DF_UP

GSEA result for gene set No. 9:
genesetName
genesetSize
genesetDesc
NES
Pos
pvalue
FDR
FWER

1.8344924967103
25

0.05

0

0

Leading set:
ENSG00000005194
ENSG00000001167
ENSG00000002919

5.87093027676571
5.18032164509648
4.19509699650485

12

Figure 5: Left: gene locations of a particular gene set according to the gene score rank and running
enrichment scores; Right: null NES distribution and the relative position of the observed NES.

Whole gene set:
ENSG00000005194
ENSG00000001167
ENSG00000002919
ENSG00000006576
ENSG00000005059

5.87093027676571
5.18032164509648
4.19509699650485
1.18546617372767
1.08902655220139

The GSEAresultTable generates a summary table of the GSEA analysis, which can also be output

with customized scripts. An example can be found in Section 6.

5 Running SeqGSEA with multiple cores

5.1 R-parallel packages

There are many R packages for facilitating users in running R scripts in parallel, including parallel ,
snowfall , multicore, and many others. While experienced users may parallelize SeqGSEA runnings
with the above packages themselves to reduce the running time, we provide with in the SeqGSEA
package vignette an general way for users to parallelize their runnings utilizing the doParallel package
(which depends on parallel ).

First, we show a toy example for a basic idea how doParallel works. Basically, doParallel is
a parallel backend for the foreach package using parallel , which provides a mechanism to execute
foreach loops in parallel. With the foreach function in the foreach package, we can specify which
foreach loops need to be parallelized using the %dopar% operator. However, without a registered
parallel backend, the foreach loops will be executed sequentially even if the %dopar% operator is
used. In those cases, the foreach package will issue a warning that it is running sequentially. Below
are two running examples showing how the task is running sequentially and in parallel, respectively.

Run sequentially without parallel backend registered

> library(doParallel)
> a <- matrix(1:16, 4, 4)

13

> b <- t(a)
> foreach(b=iter(b, by='col'), .combine=cbind) %dopar%
+

(a %*% b)

[,1] [,2] [,3] [,4]
360
400
440
480

276 304
304 336
332 368
360 400

332
368
404
440

[1,]
[2,]
[3,]
[4,]

Although the warning message didn’t appear here, you would definitely see a warning message when
you run the scripts above, like:
Warning message:
executing %dopar% sequentially: no parallel backend registered

Run in parallel with two cores

> library(doParallel)
> cl <- makeCluster(2) # specify 2 cores to be used in this computing
> registerDoParallel(cl)
> getDoParWorkers() # 2

[1] 2

> a <- matrix(1:16, 4, 4)
> b <- t(a)
> foreach(b=iter(b, by='col'), .combine=cbind) %dopar%
+

(a %*% b)

[,1] [,2] [,3] [,4]
360
400
440
480

276 304
304 336
332 368
360 400

332
368
404
440

[1,]
[2,]
[3,]
[4,]

The parallel backend registration was done with registerdoParallel. For more details please refer
to doParallel ’s vignette (http://cran.r-project.org/web/packages/doParallel/index.html).

5.2 Parallelizing analysis on permutation data sets

In SeqGSEA, the loops for analyzing permutation data sets are implemented by foreach with %dopar%
operator used. Those loops include DS, DE, and GSEA analyses, which are the most time consuming
parts. Although there are three parts can take the advantage of parallel running, users only need to
register parallel backend once at the beginning of all analyses. See an analysis example in the next
section (Section 6).

6 Analysis examples

6.1 Starting from your own RNA-Seq data

With this SeqGSEA package, we provide complementary Python scripts for counting reads on ex-
ons of each genes from SAM/BAM files: two scripts prepare_exon_annotation_refseq.py and
prepare_exon_annotation_ensembl.py for preparing (sub-)exon annotation, and count_in_exons.py
for counting reads. The scripts are based on the HTSeq Python package (http://www-huber.embl.
de/users/anders/HTSeq/). Please install it before using the Python scripts provided. The scripts
can be found in the directory given by the following command.

14

> system.file("extscripts", package="SeqGSEA", mustWork=TRUE)

[1] "/tmp/Rtmp8uXopZ/Rinst2f8d21420a9a3b/SeqGSEA/extscripts"

Simply by typing “python” + the file name of echo script in your shell console, the help docu-

mentation will be on your screen.

Other than the Python scripts provided, users who prefer playing with R/Bioconductor packages
can also use easyRNASeq in easyRNASeq, summarizeOverlaps in GenomicRanges, and featureCounts
in Rsubread to count reads that mapped to each exon. Please refer to respective packages for detailed
usage.

For users who are not familiar with RNA-Seq data processing, the upstream steps of counting
reads are (1) data preprocessing, including adapter removal, low-quality read filtering, data quality-
control analysis, and (2) read mapping. R/Bioconductor users can apply Rsubread to map reads
based on a seed-and-vote approach, as well as a few QC analysis. Users familiar with command-
line can choose from a wide range of tools, such as already widely used ones including TopHat
(http://tophat.cbcb.umd.edu), START (http://code.google.com/p/rna-star), and etc..

6.2 Exemplified pipeline for integrating DE and DS

Below is shown a typical SeqGSEA running example with the data enclosed with the SeqGSEA
package, which are a part of the prostate cancer data set (Kannan et al., 2011). We divide the
process into five steps for a complete SeqGSEA run.

Step 0: Initialization. (Users should change values in this part accordingly.)

# file name starting with "SC"
# file name starting with "SN"

> rm(list=ls())
> # input count data files
> data.dir <- system.file("extdata", package="SeqGSEA", mustWork=TRUE)
> case.pattern <- "^SC"
> ctrl.pattern <- "^SN"
> case.files <- dir(data.dir, pattern=case.pattern, full.names = TRUE)
> control.files <- dir(data.dir, pattern=ctrl.pattern, full.names = TRUE)
> # gene set file
> geneset.file <- system.file("extdata", "gs_symb.txt",
+
> # output file prefix
> output.prefix <- "SeqGSEA.test"
> # setup parallel backend
> library(doParallel)
> cl <- makeCluster(2) # specify 2 cores to be used in computing
> registerDoParallel(cl) # parallel backend registration
> # setup permutation times
> perm.times <- 20 # change the number to >= 1000 in your analysis

package="SeqGSEA", mustWork=TRUE)

Step 1: DS analysis

> # load exon read count data
> RCS <- loadExonCountData(case.files, control.files)
> # remove genes with low expression
> RCS <- exonTestability(RCS, cutoff=5)
> geneTestable <- geneTestability(RCS)
> RCS <- subsetByGenes(RCS, unique(geneID(RCS))[ geneTestable ])
> # get gene IDs, which will be used in initialization of gene set
> geneIDs <- unique(geneID(RCS))
> # calculate DS NB statistics

15

> RCS <- estiExonNBstat(RCS)
> RCS <- estiGeneNBstat(RCS)
> # calculate DS NB statistics on the permutation data sets
> permuteMat <- genpermuteMat(RCS, times=perm.times)
> RCS <- DSpermute4GSEA(RCS, permuteMat)

Step 2: DE analysis

> # get gene read counts
> geneCounts <- getGeneCount(RCS)
> # calculate DE NB statistics
> label <- label(RCS)
> dds <-runDESeq(geneCounts, label)
> DEGres <- DENBStat4GSEA(dds)
> # calculate DE NB statistics on the permutation data sets
> DEpermNBstat <- DENBStatPermut4GSEA(dds, permuteMat) # permutation

Step 3: score integration

> # DE score normalization
> DEscore.normFac <- normFactor(DEpermNBstat)
> DEscore <- scoreNormalization(DEGres$NBstat, DEscore.normFac)
> DEscore.perm <- scoreNormalization(DEpermNBstat, DEscore.normFac)
> # DS score normalization
> DSscore.normFac <- normFactor(RCS@permute_NBstat_gene)
> DSscore <- scoreNormalization(RCS@featureData_gene$NBstat, DSscore.normFac)
> DSscore.perm <- scoreNormalization(RCS@permute_NBstat_gene, DSscore.normFac)
> # score integration
> gene.score <- geneScore(DEscore, DSscore, DEweight=0.5)
> gene.score.perm <- genePermuteScore(DEscore.perm, DSscore.perm, DEweight=0.5)
> # visilization of scores
> # NOT run in the example; users to uncomment the following 6 lines to run
> #plotGeneScore(DEscore, DEscore.perm, pdf=paste(output.prefix,".DEScore.pdf",sep=""),
> #
> #plotGeneScore(DSscore, DSscore.perm, pdf=paste(output.prefix,".DSScore.pdf",sep=""),
> #
> #plotGeneScore(gene.score, gene.score.perm,
> #

pdf=paste(output.prefix,".GeneScore.pdf",sep=""))

main="Expression")

main="Splicing")

Step 4: main GSEA

genesetsize.min = 5, genesetsize.max = 1000)

> # load gene set data
> gene.set <- loadGenesets(geneset.file, geneIDs, geneID.type="ensembl",
+
> # enrichment analysis
> gene.set <- GSEnrichAnalyze(gene.set, gene.score, gene.score.perm, weighted.type=1)
> # format enrichment analysis results
> GSEAres <- GSEAresultTable(gene.set, TRUE)
> # output results
> # NOT run in the example; users to uncomment the following 4 lines to run
> #write.table(GSEAres, paste(output.prefix,".GSEA.result.txt",sep=""),
> #
> #plotES(gene.set, pdf=paste(output.prefix,".GSEA.ES.pdf",sep=""))
> #plotSig(gene.set, pdf=paste(output.prefix,".GSEA.FDR.pdf",sep=""))

quote=FALSE, sep="\t", row.names=FALSE)

16

For gene sets used in Step 4, while we recommend users directly download and use those already
well-formatted gene sets from MSigDB (http://www.broadinstitute.org/gsea/msigdb/index.
jsp), users can also feed whatever gene sets to SeqGSEA as long as they are in the GMT for-
mat. Please refer to the following URL for details: http://www.broadinstitute.org/cancer/
software/gsea/wiki/index.php/Data_formats.

6.3 Exemplified pipeline for DE-only analysis

For the demanding of DE-only analysis, such as for organisms without much alternative splicing
annotated, here we show an exemplified pipeline for such analysis. It includes 4 steps as follows.

Step 0: Initialization. (Users should change values in this part accordingly.)

> rm(list=ls())
> # input count data files
> data.dir <- system.file("extdata", package="SeqGSEA", mustWork=TRUE)
> count.file <- paste(data.dir,"geneCounts.txt",sep="/")
> # gene set file
> geneset.file <- system.file("extdata", "gs_symb.txt",
+
> # output file prefix
> output.prefix <- "SeqGSEA.test"
> # setup parallel backend
> library(doParallel)
> cl <- makeCluster(2) # specify 2 cores to be used in computing
> registerDoParallel(cl) # parallel backend registration
> # setup permutation times
> perm.times <- 20 # change the number to >= 1000 in your analysis

package="SeqGSEA", mustWork=TRUE)

Step 1: DE analysis

> # load gene read count data
> geneCounts <- read.table(count.file)
> # speficify the labels of each sample
> label <- as.factor(c(rep(1,10), rep(0,10)))
> # calculate DE NB statistics
> dds <-runDESeq(geneCounts, label)
> DEGres <- DENBStat4GSEA(dds)
> # calculate DE NB statistics on the permutation data sets
> permuteMat <- genpermuteMat(label, times=perm.times)
> DEpermNBstat <- DENBStatPermut4GSEA(dds, permuteMat) # permutation

Step 2: score normalization

> # DE score normalization
> DEscore.normFac <- normFactor(DEpermNBstat)
> DEscore <- scoreNormalization(DEGres$NBstat, DEscore.normFac)
> DEscore.perm <- scoreNormalization(DEpermNBstat, DEscore.normFac)
> # score integration - DSscore can be null
> gene.score <- geneScore(DEscore, DEweight=1)
> gene.score.perm <- genePermuteScore(DEscore.perm, DEweight=1)
> # NOT run in the example; users to uncomment the following 6 lines to run
> #plotGeneScore(DEscore, DEscore.perm, pdf=paste(output.prefix,".DEScore.pdf",sep=""),
> #
> #plotGeneScore(gene.score, gene.score.perm,
> #

pdf=paste(output.prefix,".GeneScore.pdf",sep=""))

main="Expression")

# visilization of scores

17

Step 3: main GSEA

genesetsize.min = 5, genesetsize.max = 1000)

> # load gene set data
> geneIDs <- rownames(geneCounts)
> gene.set <- loadGenesets(geneset.file, geneIDs, geneID.type="ensembl",
+
> # enrichment analysis
> gene.set <- GSEnrichAnalyze(gene.set, gene.score, gene.score.perm, weighted.type=1)
> # format enrichment analysis results
> GSEAres <- GSEAresultTable(gene.set, TRUE)
> # output results
> # NOT run in the example; users to uncomment the following 4 lines to run
> #write.table(GSEAres, paste(output.prefix,".GSEA.result.txt",sep=""),
> #
> #plotES(gene.set, pdf=paste(output.prefix,".GSEA.ES.pdf",sep=""))
> #plotSig(gene.set, pdf=paste(output.prefix,".GSEA.FDR.pdf",sep=""))

quote=FALSE, sep="\t", row.names=FALSE)

6.4 One-step SeqGSEA analysis

While users can choose to run SeqGSEA step by step in a well-controlled manner (see above), the
one-step SeqGSEA analysis with an all-in runSeqGSEA function enables users to run SeqGSEA in
the easiest way. With the runSeqGSEA function, users can also test multiple weights for integrating
DE and DS scores. DE-only analysis starting with exon read counts is also supported in the all-in
function.

Follow the example below to start your first SeqGSEA analysis now!

package="SeqGSEA", mustWork=TRUE)

> ### Initialization ###
> # input file location and pattern
> data.dir <- system.file("extdata", package="SeqGSEA", mustWork=TRUE)
> case.pattern <- "^SC" # file name starting with "SC"
> ctrl.pattern <- "^SN" # file name starting with "SN"
> # gene set file and type
> geneset.file <- system.file("extdata", "gs_symb.txt",
+
> geneID.type <- "ensembl"
> # output file prefix
> output.prefix <- "SeqGSEA.example"
> # analysis parameters
> nCores <- 8
> perm.times <- 1000 # >= 1000 recommended
> DEonly <- FALSE
> DEweight <- c(0.2, 0.5, 0.8) # a vector for different weights
> integrationMethod <- "linear"
>
> ### one step SeqGSEA running ###
> # NOT run in the example; uncomment the following 4 lines to run
> # CAUTION: running the following lines will generate lots of files in your working dir
> #runSeqGSEA(data.dir=data.dir, case.pattern=case.pattern, ctrl.pattern=ctrl.pattern,
> #
> #
> #

geneset.file=geneset.file, geneID.type=geneID.type, output.prefix=output.prefix,
nCores=nCores, perm.times=perm.times, integrationMethod=integrationMethod,
DEonly=DEonly, DEweight=DEweight)

18

7 Session information

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[8] methods

parallel
base

other attached packages:

stats

graphics grDevices utils

datasets

DESeq2_1.50.0

[1] SeqGSEA_1.50.0
[3] SummarizedExperiment_1.40.0 MatrixGenerics_1.22.0
[5] matrixStats_1.5.0
[7] Seqinfo_1.0.0
[9] S4Vectors_0.48.0
[11] iterators_1.0.14
[13] Biobase_2.70.0
[15] generics_0.1.4

GenomicRanges_1.62.0
IRanges_2.44.0
doParallel_1.0.17
foreach_1.5.2
BiocGenerics_0.56.0

loaded via a namespace (and not attached):

[1] KEGGREST_1.50.0
[4] httr2_1.2.1
[7] tools_4.5.1
[10] tibble_3.3.0
[13] pkgconfig_2.0.3
[16] RColorBrewer_1.1-3
[19] compiler_4.5.1
[22] Biostrings_2.78.0
[25] pillar_1.11.1
[28] DelayedArray_0.36.0
[31] tidyselect_1.2.1
[34] purrr_1.1.0
[37] fastmap_1.2.0
[40] SparseArray_1.10.0
[43] dichromat_2.0-0.1

gtable_0.3.6
lattice_0.22-7
curl_7.0.0
RSQLite_2.4.3
Matrix_1.7-4
S7_0.2.0
farver_2.1.2
progress_1.2.3
crayon_1.5.3
cachem_1.1.0
locfit_1.5-9.12
dplyr_1.1.4
grid_4.5.1
magrittr_2.0.4
withr_3.0.2

ggplot2_4.0.0
vctrs_0.6.5
AnnotationDbi_1.72.0
blob_1.2.4
dbplyr_2.5.1
lifecycle_1.0.4
stringr_1.5.2
codetools_0.2-20
BiocParallel_1.44.0
abind_1.4-8
stringi_1.8.7
biomaRt_2.66.0
cli_3.6.5
S4Arrays_1.10.0
prettyunits_1.2.0

19

[46] filelock_1.0.3
[49] bit64_4.6.0-1
[52] bit_4.6.0
[55] memoise_2.0.1
[58] Rcpp_1.1.0
[61] xml2_1.4.1

scales_1.4.0
httr_1.4.7
png_0.1-8
BiocFileCache_3.0.0
glue_1.8.0
R6_2.6.1

rappdirs_0.3.3
XVector_0.50.0
hms_1.1.4
rlang_1.1.6
DBI_1.2.3

Cleanup

This is a cleanup step for the vignette on Windows; typically not needed for users.

> allCon <- showConnections()
> socketCon <- as.integer(rownames(allCon)[allCon[, "class"] == "sockconn"])
> sapply(socketCon, function(ii) close.connection(getConnection(ii)) )

References

Anders, S. and Huber, W. (2010). Differential expression analysis for sequence count data. Genome

Biology, 11:R106.

Benjamini, Y. and Hochberg, Y. (1995). Controlling the false discovery rate: a practical and powerful

approach to multiple testing. J. R. Stat. Soc. Ser. B, 57(1):289–300.

Kannan, K., Wang, L., Wang, J., Ittmann, M. M., Li, W., and Yen, L. (2011). Recurrent chimeric
rnas enriched in human prostate cancer identified by deep sequencing. Proc Natl Acad Sci U S A,
108(22):9172–7.

Subramanian, A., Tamayo, P., Mootha, V. K., Mukherjee, S., Ebert, B. L., Gillette, M. A., Paulovich,
A., Pomeroy, S. L., Golub, T. R., Lander, E. S., and Mesirov, J. P. (2005). Gene set enrichment
analysis: a knowledge-based approach for interpreting genome-wide expression profiles. Proc Natl
Acad Sci U S A, 102(43):15545–50.

Wang, W., Qin, Z., Feng, Z., Wang, X., and Zhang, X. (2013).

Identifying differentially spliced

genes from two groups of rna-seq samples. Gene, 518(1):164–170.

Wang, X. and Cairns, M. (2013). Gene set enrichment analysis of RNA-Seq data:

integrating

differential expression and splicing. BMC Bioinformatics, 14(Suppl 5):S16.

Wang, X. and Cairns, M. (2014). SeqGSEA: a Bioconductor package for gene set enrichment analysis
of RNA-Seq data integrating differential expression and splicing. Bioinformatics, 30(12):1777–9.

20

