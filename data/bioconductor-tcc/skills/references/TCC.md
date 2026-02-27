TCC: Differential expression analysis for tag count data
with robust normalization strategies

Jianqiang Sun1§, Tomoaki Nishiyama2§, Kentaro Shimizu1, and Koji Kadota1
1 The University of Tokyo, Tokyo, Japan

2 Kanazawa University, Kanazawa, Japan

§ Maintainer: Jianqiang Sun (sun@biunit.dev),

Tomoaki Nishiyama (tomoakin@staff.kanazawa-u.ac.jp)

October 30, 2025

Abstract

The R/Bioconductor package, TCC, provides users with a robust and accurate
framework to perform differential expression (DE) analysis of tag count data. We de-
veloped a multi-step normalization method (TbT; Kadota et al., 2012) for two-group
RNA-seq data. The strategy (called DEGES) is to remove data that are potential differ-
entially expressed genes (DEGs) before performing the data normalization. DEGES in
TCC is essential for accurate normalization of tag count data, especially when the up-
and down-regulated DEGs in one of the groups are extremely biased in their number. A
major characteristic of TCC is to provide the DEGES-based normalization methods for
several kinds of count data (two-group, multi-group, and so on) by virtue of the use of
combinations of functions in other sophisticated packages (especially edgeR). The ap-
propriate combination provided by TCC allows a more robust and accurate estimation
to be performed more easily than directly using original packages and TCC provides a
simple unified interface to perform the robust normalization.

Contents

1 Introduction

Installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.1
1.2 Citations . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.3 Quick start

2 Preparations

2.1 Preparing the count data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Reading the count data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Constructing TCC class object . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Filtering low-count genes (optional) . . . . . . . . . . . . . . . . . . . . . . . .

3
3
4
4

5
5
5
6
7

3 Normalization

3.1 Normalization of two-group count data with replicates

8
9
. . . . . . . . . . . . .
9
3.1.1 DEGES/edgeR . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.2
iDEGES/edgeR . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
3.1.3 DEGES/DESeq2 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
3.2 Normalization of two-group count data without replicates (paired) . . . . . . . 12
3.2.1 DEGES/edgeR . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
3.3 Normalization of multi-group count data with replicates . . . . . . . . . . . . . 13
3.3.1 DEGES/edgeR . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
3.4 Retrieving normalized data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
3.4.1 Retrieving two-group DEGES/edgeR-normalized data with replicates . 17
3.4.2 Retrieving two-group DEGES/edgeR-normalized data without repli-

cates (paired) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
3.4.3 Retrieving multi-group iDEGES/edgeR-normalized data with replicates 19

4 Differential expression (DE)

21
4.1 DE analysis for two-group data with replicates . . . . . . . . . . . . . . . . . . 21
4.1.1
edgeR coupled with iDEGES/edgeR normalization . . . . . . . . . . . 21
4.1.2 DESeq2 coupled with iDEGES/DESeq2 normalization . . . . . . . . . 24
4.2 DE analysis for two-group data without replicates (paired) . . . . . . . . . . . 27
4.3 DE analysis for multi-group data with replicates . . . . . . . . . . . . . . . . . 30
edgeR coupled with DEGES/edgeR normalization . . . . . . . . . . . . 31

4.3.1

5 Generation of simulation data

31
Introduction and basic usage . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
5.1
5.2 Multi-group data with and without replicates
. . . . . . . . . . . . . . . . . . 34
5.3 Multi-factor data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
5.4 Other utilities . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39

6 Session info

7 References

43

44

2

1

Introduction

Differential expression analysis based on tag count data has become a fundamental task for
identifying differentially expressed genes or transcripts (DEGs). The TCC package (Tag
Count Comparison; Sun et al., 2013) provides users with a robust and accurate framework to
perform differential expression analysis of tag count data. TCC provides integrated analysis
pipelines with improved data normalization steps, compared with other packages such as
edgeR by appropriately combining their functionalities. The package incorporates multi-
step normalization methods whose strategy is to remove data that are potential DEGs before
performing the data normalization.

Kadota et al. (2012) recently reported that the normalization methods implemented in R
packages (such as edgeR (Robinson et al., 2010), and DESeq (Anders and Huber, 2010) for
differential expression (DE) analysis between samples are inadequate when the up- and down-
regulated DEGs in one of the samples are extremely biased in their number (i.e., biased DE).
This is because the current methods implicitly assume a balanced DE, wherein the numbers
of highly and lowly expressed DE entities in samples are (nearly) equal. As a result, methods
assuming unbiased DE will not work well on data with biased DE. Although a major purpose
of data normalization is to detect such DE entities, their existence themselves consequently
interferes with their opportunity to be top-ranked. Conventional procedures for identifying
DEGs from tag count data consisting of two steps (i.e., data normalization and identification
of DEGs) cannot in principle eliminate the potential DE entities before data normalization.
To normalize data that potentially has various scenarios (including unbiased and biased
DE), we recently proposed a multi-step normalization strategy (called TbT, an acronym for
the TMM-baySeq-TMM pipeline; Kadota et al., 2012), in which the TMM normalization
method (Robinson and Oshlack, 2010) is used in steps 1 and 3 and an empirical Bayesian
method implemented in the baySeq package (Hardcastle and Kelly, 2010) is used in step 2. Al-
though this multi-step DEG elimination strategy (called "DEGES" for short) can successfully
remove potential DE entities identified in step 2 prior to the estimation of the normalization
factors using the TMM normalization method in step 3, the baySeq package used in step 2
of the TbT method is much more computationally intensive than competing packages like
edgeR and DESeq2. While the three-step TbT normalization method performed best on
simulated and real tag count data, it is practically possible to make different choices for the
methods in each step. A more comprehensive study regarding better choices for DEGES is
needed.

This package provides tools to perform multi-step normalization methods based on DEGES
and enables differential expression analysis of tag count data without having to worry much
about biased distributions of DEGs. The DEGES-based normalization function implemented
in TCC includes the TbT method based on DEGES for two-group data, much faster method,
and methods for multi-group comparison. TCC provides a simple unified interface to per-
form data normalization with combinations of functions provided by DESeq2 and edgeR.
Functions to produce simulation data under various conditions and to plot the data are also
provided.

1.1

Installation

This package is available from the Bioconductor website (http://bioconductor.org/). To
install the package, enter the following command after starting R:

3

> if (!requireNamespace("BiocManager", quietly=TRUE))

> install.packages("BiocManager")

> BiocManager::install("TCC")

1.2 Citations

This package internally uses many of the functions implemented in the other packages. This
is because our normalization procedures consist, in part, of combinations of existing normal-
ization methods and differential expression (DE) methods.

For example, the TbT normalization method (Kadota et al., 2012), which is a particular
functionality of the TCC package (Sun et al., 2013), consists of the TMM normalization
method (Robinson and Oshlack, 2010) implemented in the edgeR package (Robinson et al.,
2010) and the empirical Bayesian method implemented in the baySeq package (Hardcastle
and Kelly, 2010). Therefore, please cite the appropriate references when you publish your
results.

> citation("TCC")

1.3 Quick start

Let us begin by showing a example of identifying DEGs between two groups from tag count
data consisting of 1, 000 genes and a total of six samples (each group has three biological
replicates). The hypothetical count data (termed "hypoData") is stored in this package (for
details, see section 2.1).

DE analysis for two-group count data with replicates by using the F-test (see glmQLFTest
in edgeR package) coupled with iterative DEGES/edgeR normalization (i.e., the iDEGES/edgeR-
edgeR combination). This is an alternative pipeline designed to reduce the runtime (approx.
20 sec.), yet its performance is comparable to the above pipeline. Accordingly, we recommend
using this pipeline as a default when analyzing tag count data with replicates. A notable
advantage of this pipeline is that the multi-step normalization strategy only needs the meth-
ods implemented in the edgeR package. The suggested citations are as follows: TCC (Sun
et al., 2013), TMM (Robinson and Oshlack, 2010), and edgeR (Robinson et al., 2010). For
details, see section 3.1.2 and 4.1.1.

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> result <- getResult(tcc, sort = TRUE)
> head(result)

iteration = 3, FDR = 0.1, floorPDEG = 0.05)

gene_id

a.value

m.value

p.value

1 gene_151 9.736230 -2.749909 6.080655e-06 0.001169953
2 gene_168 8.903595 -1.965453 7.079033e-06 0.001169953
3 gene_144 7.588262 -2.126825 7.651455e-06 0.001169953
4
gene_11 8.772243 -2.101167 9.417202e-06 0.001169953
5 gene_123 8.213530 -2.148411 1.052097e-05 0.001169953
6 gene_143 9.284689 -1.970371 1.053439e-05 0.001169953

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

4

2 Preparations

2.1 Preparing the count data

Similar to the other packages, TCC typically starts the DE analysis with a count table
matrix where each row indicates a gene (or transcript), each column indicates a sample (or
library), and each cell indicates the number of counts for a gene in a sample. There are
many ways to obtain the count data from aligned read files such as BAM (Binary Align-
ment/Map). This includes the islandCounts function in htSeqTools (Planet et al., 2012),
summarizeOverlaps in GenomicRanges (Lawrence et al., 2013), qCount in QuasR, and so
on. For Windows end users, we recommend to use the QuasR package. It provides a compre-
hensive workflow for many kinds of NGS data including ChIP-seq, RNA-seq, smallRNA-seq,
and BS-seq. The main functionalities are: (1) preprocessing raw sequence reads, (2) aligning
reads to the reference genome or transcriptome using Rbowtie, and (3) producing count
matrix from aligned reads. TCC uses the raw count data (a matrix of integer values) as
input. As also clearly mentioned in DESeq2, the raw count data corresponds to a matrix of
integer values. Please DO NOT use any normalized counts such as RPM (reads per million),
CPM (counts per million), and RPKM.

2.2 Reading the count data

Here, we assume a hypothetical count matrix consisting of 1,000 rows (or genes) and a total
of six columns: the first three columns are produced from biological replicates of Group 1
(G1_rep1, G1_rep2, and G1_rep3) and the remaining columns are from Group 2 (G2_rep1,
G2_rep2, and G2_rep3). We start by loading the hypothetical data (hypoData) from TCC
and giving a numeric vector (group) indicating which group each sample belongs to.

> library(TCC)
> data(hypoData)
> head(hypoData)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3
29
68
239
0
5
69

34
358
1144
0
98
296

14
25
480
0
8
62

16
36
374
18
1
86

122
22
990
44
17
216

45
388
919
0
48
282

> dim(hypoData)

[1] 1000

6

> group <- c(1, 1, 1, 2, 2, 2)

If you want to analyze another count matrix consisting of nine columns (e.g., the first
four columns are produced from biological replicates of G1, and the remaining five columns
are from G2), the group vector should be indicated as follows.

> group <- c(1, 1, 1, 1, 2, 2, 2, 2, 2)

5

2.3 Constructing TCC class object

The new function has to be used to perform the main functionalities of TCC. This function
constructs a TCC class object, and subsequent analyses are performed on this class ob-
ject. The object is constructed from i) a count matrix (hypoData) and ii) the corresponding
numeric vector (group) as follows.

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc

Count:

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3
29
68
239
0
5
69

34
358
1144
0
98
296

14
25
480
0
8
62

16
36
374
18
1
86

122
22
990
44
17
216

45
388
919
0
48
282

Sample:

G1_rep1
G1_rep2
G1_rep3
G2_rep1
G2_rep2
G2_rep3

group norm.factors lib.sizes
142177
145289
149886
112100
104107
101975

1
1
1
1
1
1

1
1
1
2
2
2

The count matrix and group vector information can be retrieved from the stored class

object by using tcc$count and tcc$group, respectively.

> head(tcc$count)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3
29
68
239
0
5
69

34
358
1144
0
98
296

14
25
480
0
8
62

16
36
374
18
1
86

122
22
990
44
17
216

45
388
919
0
48
282

> tcc$group

G1_rep1
G1_rep2
G1_rep3
G2_rep1
G2_rep2
G2_rep3

group
1
1
1
2
2
2

6

2.4 Filtering low-count genes (optional)

The way to filter out genes with low-count tags across samples depends on the user’s philoso-
phy. Although we recommend removing tags with zero counts across samples as a minimum
filtering, this effort is optional. The filterLowCountGenes function performs this filtering.

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- filterLowCountGenes(tcc)
> dim(tcc$count)

[1] 996

6

It can be seen that 4(= 1000 − 996) genes were filtered as non-expressed. The same
procedure can be performed without the filterLowCountGenes function, in which case the
filtering is performed before the TCC class object is constructed.

> filter <- as.logical(rowSums(hypoData) > 0)
> dim(hypoData[filter, ])

[1] 996

6

> tcc <- new("TCC", hypoData[filter, ], group)
> dim(tcc$count)

[1] 996

6

7

3 Normalization

This chapter describes the details of our robust normalization strategy (i.e., DEGES) imple-
mented in TCC. Alternative DEGES procedures consisting of functions in other packages
(edgeR and DESeq2) are also provided, enabling advanced users familiar with the exist-
ing packages can easily learn what is done in TCC. Note that end users, who just want to
perform robust differential expression analysis using TCC, can skip this chapter (3 Normal-
ization) and move from here to, for example, the next chapter (4 Differential expression).
Note also that the purpose here is to obtain accurate normalization factors to be used with
statistical models (e.g., the exact test or empirical Bayes) for the DE analysis described in the
next section (4 Differential expression). TCC can manipulate various kinds of experimental
designs. Followings are some examples for individual designs. Appropriate sections should
be referred for your specific experimental designs.

Table 1: 3.1 unpaired samples (two-group)

Label

Example 1

Example 2

Label

Example 3

Example 4

G1_rep1 G1(mouse_A) Tumor(patient_A) G1_rep1 G1(mouse_A) Tumor(patient_A)
G1_rep2 G1(mouse_B) Tumor(patient_B) G1_rep2 G1(mouse_B) Tumor(patient_B)
G1_rep3 G1(mouse_C) Tumor(patient_C) G2_rep1 G2(mouse_D) Normal(patient_G)
G2_rep1 G2(mouse_D) Normal(patient_G) G2_rep2 G2(mouse_E) Normal(patient_H)
G2_rep2 G2(mouse_E) Normal(patient_H)
G2_rep3 G2(mouse_F) Normal(patient_K)

Table 2: 3.2 paired samples (two-group)

Label

Example 1

Example 2

Label

Example 3

Example 4

G1_rep1 G1(mouse_A) Tumor(patient_G) G1_rep1 G1(mouse_B) Tumor(patient_J)
G1_rep2 G1(mouse_B) Tumor(patient_H) G1_rep2 G1(mouse_C) Tumor(patient_K)
G1_rep3 G1(mouse_C) Tumor(patient_K) G2_rep1 G2(mouse_B) Normal(patient_J)
G2_rep1 G2(mouse_A) Normal(patient_G) G2_rep2 G2(mouse_C) Normal(patient_K)
G2_rep2 G2(mouse_B) Normal(patient_H)
G2_rep3 G2(mouse_C) Normal(patient_K)

8

Table 3: 3.3 unpaired samples (multi-group)

Label

Label

Example 1

Example 3

Example 4
Example 2
Liver(sample_G)
G1_rep1 G1(mouse_A) Kidney(sample_A) G1_rep1 G1(mouse_A)
G1_rep2 G1(mouse_B) Kidney(sample_B) G1_rep2 G1(mouse_B)
Liver(sample_H)
G1_rep3 G1(mouse_C) Kidney(sample_C) G2_rep1 G2(mouse_D) Brain(sample_Y)
Brain(sample_Z)
G2_rep1 G2(mouse_D)
Liver(sample_G) G2_rep2 G2(mouse_E)
Liver(sample_H) G3_rep1 G3(mouse_U) Kidney(sample_B)
G2_rep2 G2(mouse_E)
G2_rep3 G2(mouse_F)
Liver(sample_K) G3_rep2 G3(mouse_T) Kidney(sample_C)
G3_rep1 G3(mouse_G) Brain(sample_X)
G3_rep2 G3(mouse_H) Brain(sample_Y)
Brain(sample_Z)
G3_rep3 G3(mouse_I)

3.1 Normalization of two-group count data with replicates

This package provides robust normalization methods based on DEGES proposed by Kadota et
al. (2012). When obtaining normalization factors from two-group data with replicates, users
can select a total of six combinations (two normalization methods × three DEG identification
methods) coupled with an arbitrary number of iterations (n = 0, 1, 2, . . . , 100) in our DEGES-
based normalization pipeline. We show some of the practical combinations below.

Since the three-step TbT normalization method was originally designed for normaliz-
ing tag count data with (biological) replicates, we present three shorter alternatives (3.1.1
DEGES/edgeR, 3.1.2 iDEGES/edgeR, and 3.1.3 DEGES/DESeq2).

3.1.1 DEGES/edgeR

Now let us describe an alternative approach that is roughly 200-400 times faster than
DEGES/TbT, yet has comparable performance. The TMM-edgeR-TMM pipeline (called
DEGES/edgeR) employs the exact test implemented in edgeR in step 2. To use this pipeline,
we have to provide a reasonable threshold for defining potential DEGs in step 2. We will
define the threshold as an arbitrary false discovery rate (FDR) with a floor value of PDEG.
The default FDR is < 0.1, and the default floor PDEG is 5%, but different choices are of course
possible. For example, in case of the default settings, x%(x > 5%) of the top-ranked potential
DEGs are eliminated in step 2 if the percentage (= x%) of genes satisfying FDR < 0.1 is
over 5%. The DEGES/edgeR pipeline has an apparent advantage over TbT in computation
time. It can be performed as follows:

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc$norm.factors

iteration = 1, FDR = 0.1, floorPDEG = 0.05)

G1_rep1

G2_rep3
0.8793169 0.8602944 0.8442739 1.0857614 1.1446566 1.1856967

G1_rep2

G2_rep1

G1_rep3

G2_rep2

9

> tcc$DEGES$execution.time

user
0.248

system elapsed
0.248

0.000

The normalization factors calculated from the DEGES/edgeR are very similar to those of
DEGES/TbT with the default parameter settings (i.e., samplesize = 10000). For edgeR
users, we provide commands, consisting of functions in edgeR, to perform the DEGES/edgeR
pipeline without TCC. The calcNormFactors function together with the above parameter
settings can be regarded as a wrapper function for the following commands.

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> FDR <- 0.1
> floorPDEG <- 0.05
> d <- DGEList(counts = hypoData, group = group)
> ### STEP 1 ###
> d <- calcNormFactors(d)
> ### STEP 2 ###
> design <- model.matrix(~group)
> d <- estimateDisp(d, design)
> fit <- glmQLFit(d, design)
> out <- glmQLFTest(fit, coef = 2)
> pval <- out$table$PValue
> qval <- p.adjust(pval, method = "BH")
> if (sum(qval < FDR) > (floorPDEG * nrow(hypoData))) {
+
+ } else {
+
+
+ }
> ### STEP 3 ###
> d <- DGEList(counts = hypoData[!is.DEG, ], group = group)
> d <- calcNormFactors(d)
> norm.factors <- d$samples$norm.factors * colSums(hypoData[!is.DEG, ]) /
+
> norm.factors <- norm.factors / mean(norm.factors)
> norm.factors

is.DEG <- as.logical(rank(pval, ties.method = "min") <=

is.DEG <- as.logical(qval < FDR)

nrow(hypoData) * floorPDEG)

colSums(hypoData)

G1_rep1

G2_rep3
0.8793169 0.8602944 0.8442739 1.0857614 1.1446566 1.1856967

G2_rep2

G2_rep1

G1_rep3

G1_rep2

3.1.2

iDEGES/edgeR

Our multi-step normalization can be repeated until the calculated normalization factors con-
verge (Kadota et al., 2012). An iterative version of DEGES/TbT (i.e., iDEGES/TbT) can
be described as the TMM-(baySeq-TMM)n pipeline with n ≥ 2. Although the iDEGES/TbT
would not be practical in terms of the computation time, the TMM-(edgeR-TMM)n pipeline
(iDEGES/edgeR) is potentially superior to both the DEGES/edgeR and the DEGES/TbT.
A suggested iDEGES/edgeR implementation (n = 3) consists of seven steps, as follows:

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc$norm.factors

iteration = 3, FDR = 0.1, floorPDEG = 0.05)

10

G1_rep1

G2_rep3
0.8706680 0.8501287 0.8389209 1.0844163 1.1491726 1.2066935

G2_rep2

G2_rep1

G1_rep3

G1_rep2

> tcc$DEGES$execution.time

user
0.719

system elapsed
0.719

0.000

3.1.3 DEGES/DESeq2

The DEGES pipeline can also be performed by using only the functions in the DESeq2 pack-
age. Similar to the DESeq case above, this DESeq2-DESeq2-DESeq2 pipeline (DEGES/DESeq2)
changes the corresponding arguments of the norm.method and test.method as follows:

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "deseq2", test.method = "deseq2",
+
> tcc$norm.factors

iteration = 1, FDR = 0.1, floorPDEG = 0.05)

G1_rep1

G2_rep3
0.8804811 0.8712588 0.8207842 1.0784376 1.1570976 1.1919407

G2_rep2

G2_rep1

G1_rep3

G1_rep2

> tcc$DEGES$execution.time

user
2.834

system elapsed
2.976

0.142

For DESeq2 users, we also provide commands, consisting of functions in DESeq2, to
perform the DEGES/DESeq2 pipeline without TCC. The calcNormFactors function to-
gether with the above arguments can be regarded as a wrapper function for the following
commands.

> library(TCC)
> data(hypoData)
> FDR <- 0.1
> floorPDEG <- 0.05
> group <- factor(c(1, 1, 1, 2, 2, 2))
> cl <- data.frame(group = group)
> design <- formula(~ group)
> dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
+
> ### STEP 1 ###
> dds <- estimateSizeFactors(dds)
> sizeFactors(dds) <- sizeFactors(dds) / mean(sizeFactors(dds))
> ### STEP 2 ###
> dds <- estimateDispersions(dds)
> dds <- nbinomWaldTest(dds)
> result <- results(dds)
> result$pvalue[is.na(result$pvalue)] <- 1
> pval <- result$pvalue
> qval <- p.adjust(pval, method = "BH")
> if (sum(qval < FDR) > (floorPDEG * nrow(hypoData))) {

design = design)

11

nrow(hypoData) * floorPDEG)

is.DEG <- as.logical(qval < FDR)

is.DEG <- as.logical(rank(pval, ties.method = "min") <=

+
+ } else {
+
+
+ }
> ### STEP 3 ###
> dds <- DESeqDataSetFromMatrix(countData = hypoData[!is.DEG, ], colData = cl,
+
> dds <- estimateSizeFactors(dds)
> norm.factors <- sizeFactors(dds) / colSums(hypoData)
> norm.factors <- norm.factors / mean(norm.factors)
> norm.factors

design = design)

G1_rep1

G2_rep3
0.8804811 0.8712588 0.8207842 1.0784376 1.1570976 1.1919407

G2_rep2

G2_rep1

G1_rep3

G1_rep2

3.2 Normalization of two-group count data without replicates (paired)

edgeR and DESeq2 employs generalized linear models (GLMs) which can apply to de-
tect DEGs from paired two-group count data. When obtaining normalization factors from
paired two group samples, users can select a total of four combinations (two normalization
methods × two DEG identification methods) coupled with an arbitrary number of iterations
(n = 0, 1, 2, · · · , 100) in our DEGES-based normalization pipeline. The analysis for paired
samples can be performed by indicating (1) the pair information when constructing the TCC
class object and (2) paired = TRUE when performing the calcNormFactors function. For
analyzing paired data, we here use the hypothetical count data (hypoData; for details see
2.2) by changing the label information, i.e.,

> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> head(hypoData)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

T_dogA T_dogB T_dogC N_dogA N_dogB N_dogC
29
68
239
0
5
69

34
358
1144
0
98
296

122
22
990
44
17
216

14
25
480
0
8
62

45
388
919
0
48
282

16
36
374
18
1
86

This count data consists of three individuals (or sibships), dogA, dogB, and dogC. "T"

and "N" indicate tumor and normal tissues, respectively.

3.2.1 DEGES/edgeR

The DEGES/edgeR pipeline for two-group paired data can be performed as follows:

> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> group <- c(1, 1, 1, 2, 2, 2)
> pair <- c(1, 2, 3, 1, 2, 3)

12

> cl <- data.frame(group = group, pair = pair)
> tcc <- new("TCC", hypoData, cl)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc$norm.factors

iteration = 1, FDR = 0.1, floorPDEG = 0.05, paired = TRUE)

T_dogA

N_dogC
0.8916175 0.8466086 0.8332711 1.0704552 1.1498406 1.2082070

N_dogB

N_dogA

T_dogB

T_dogC

For edgeR users, we provide commands, consisting of functions in edgeR, to perform
the DEGES/edgeR pipeline without TCC. The calcNormFactors function together with the
above parameter settings can be regarded as a wrapper function for the following commands.

> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
"N_dogA", "N_dogB", "N_dogC")
+
> group <- factor(c(1, 1, 1, 2, 2, 2))
> pair <- factor(c(1, 2, 3, 1, 2, 3))
> design <- model.matrix(~ group + pair)
> coef <- 2
> FDR <- 0.1
> floorPDEG <- 0.05
> d <- DGEList(counts = hypoData, group = group)
> ### STEP 1 ###
> d <- calcNormFactors(d)
> ### STEP 2 ###
> d <- estimateDisp(d, design)
> fit <- glmQLFit(d, design)
> out <- glmQLFTest(fit, coef = coef)
> pval <- out$table$PValue
> qval <- p.adjust(pval, method = "BH")
> if (sum(qval < FDR) > (floorPDEG * nrow(hypoData))){
+
+ } else {
+
+
+ }
> ### STEP 3 ###
> d <- DGEList(counts = hypoData[!is.DEG, ], group = group)
> d <- calcNormFactors(d)
> norm.factors <- d$samples$norm.factors * colSums(hypoData[!is.DEG, ]) /
+ colSums(hypoData)
> norm.factors <- norm.factors / mean(norm.factors)
> norm.factors

is.DEG <- as.logical(rank(pval, ties.method = "min") <=

is.DEG <- as.logical(qval < FDR)

nrow(hypoData) * floorPDEG)

T_dogA

N_dogC
0.8916175 0.8466086 0.8332711 1.0704552 1.1498406 1.2082070

N_dogA

N_dogB

T_dogC

T_dogB

3.3 Normalization of multi-group count data with replicates

Many R packages (including edgeR) support DE analysis for multi-group tag count data.
TCC provides some prototypes of DEGES-based pipelines for such data. Here, we analyze
another hypothetical three-group count matrix, the hypoData_mg object, provided in TCC.
It consists of 1, 000 genes and a total of nine columns for testing any difference among three
groups that each have triplicates.

13

> library(TCC)
> data(hypoData_mg)
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> tcc <- new("TCC", hypoData_mg, group)
> tcc

Count:

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3 G3_rep1 G3_rep2 G3_rep3
14
2
3
2
1
21

48
0
66
9
1
100

63
18
106
4
0
57

31
7
25
6
2
83

15
5
11
2
0
7

24
3
11
0
0
26

12
8
14
1
1
16

15
2
9
1
1
20

12
3
14
6
0
5

Sample:

G1_rep1
G1_rep2
G1_rep3
G2_rep1
G2_rep2
G2_rep3
G3_rep1
G3_rep2
G3_rep3

group norm.factors lib.sizes
150490
166665
199283
183116
126651
131377
149828
150288
141702

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
2
2
2
3
3
3

> dim(tcc$count)

[1] 1000

9

Of the 1, 000 genes, the first 200 genes are DEGs and the remaining 800 genes are non-
DEGs. The breakdowns for the 200 DEGs are as follows: 140, 40, and 20 DEGs are up-
regulated in Groups 1, 2, and 3. Below, we show a DEGES-based normalization pipeline for
this multi-group data here.

3.3.1 DEGES/edgeR

edgeR employs generalized linear models (GLMs) to find DEGs between any of the groups.
The DEGES/edgeR normalization pipeline in TCC internally uses functions for the GLM
approach that require two models (a full model and a null model). The full model corresponds
to a design matrix to describe sample groups. The null model corresponds to the model
coefficients. The two models can be defined as follows:

> library(TCC)
> data(hypoData_mg)
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> tcc <- new("TCC", hypoData_mg, group)
> design <- model.matrix(~ as.factor(group))
> coef <- 2:length(unique(group))

The design matrix (design) can be constructed by using the model.matrix function.
For the model coefficients (coef), the user should specify all the coefficients except for the
intercept term. The DEGES/edgeR pipeline with the two models (design and coef) can be
performed as follows.

14

> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc$norm.factors

iteration = 1, design = design, coef = coef)

G1_rep1

G3_rep2
1.0203839 0.9119700 0.7810479 0.8330077 1.1751542 1.2022200 1.0218448 1.0290122

G2_rep1

G2_rep2

G1_rep3

G1_rep2

G2_rep3

G3_rep1

G3_rep3
1.0253592

The two models (design and coef) will automatically be generated when performing the

following calcNormFactors function if those models are not explicitly indicated. That is

> library(TCC)
> data(hypoData_mg)
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> tcc <- new("TCC", hypoData_mg, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc$norm.factors

iteration = 1)

G1_rep1

G3_rep2
1.0203839 0.9119700 0.7810479 0.8330077 1.1751542 1.2022200 1.0218448 1.0290122

G1_rep3

G2_rep2

G2_rep1

G1_rep2

G2_rep3

G3_rep1

G3_rep3
1.0253592

For edgeR users, we provide commands, consisting of functions in edgeR, to perform
the DEGES/edgeR pipeline without TCC. The calcNormFactors function together with the
above parameter settings can be regarded as a wrapper function for the following commands.

> library(TCC)
> data(hypoData_mg)
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> tcc <- new("TCC", hypoData_mg, group)
> FDR <- 0.1
> floorPDEG <- 0.05
> design <- model.matrix(~ as.factor(group))
> coef <- 2:ncol(design)
> d <- DGEList(counts = hypoData_mg, group = group)
> ### STEP 1 ###
> d <- calcNormFactors(d)
> ### STEP 2 ###
> d <- estimateDisp(d, design)
> fit <- glmQLFit(d, design)
> out <- glmQLFTest(fit, coef = coef)
> result <- as.data.frame(topTags(out, n = nrow(hypoData_mg)))
> result <- result$table[rownames(hypoData_mg), ]
> pval <- out$table$PValue
> qval <- p.adjust(pval, method = "BH")
> if (sum(qval < FDR) > (floorPDEG * nrow(hypoData_mg))) {
+
+ } else {
+
+
+ }
> ### STEP 3 ###
> d <- DGEList(counts = hypoData_mg[!is.DEG, ], group = group)
> d <- calcNormFactors(d)
> norm.factors <- d$samples$norm.factors * colSums(hypoData_mg[!is.DEG, ]) /
+
> norm.factors <- norm.factors / mean(norm.factors)
> norm.factors

is.DEG <- as.logical(rank(pval, ties.method = "min") <=

is.DEG <- as.logical(qval < FDR)

nrow(hypoData_mg) * floorPDEG)

colSums(hypoData_mg)

15

G1_rep1

G3_rep2
1.0203839 0.9119700 0.7810479 0.8330077 1.1751542 1.2022200 1.0218448 1.0290122

G1_rep2

G2_rep1

G2_rep2

G1_rep3

G2_rep3

G3_rep1

G3_rep3
1.0253592

3.4 Retrieving normalized data

Similar functions for calculating normalization factors are the calcNormFactors function
in edgeR and the estimateSizeFactors function in DESeq2. Note that the terminology
used in DESeq2 (i.e., size factors) is different from that used in edgeR (i.e., effective li-
brary sizes) and ours. The effective library size in edgeR is calculated as the library size
multiplied by the normalization factor. The size factors in both DESeq2 package are compa-
rable to the normalized effective library sizes wherein the summary statistics for the effective
library sizes are adjusted to one. Our normalization factors, which can be obtained from
tcc$norm.factors, have the same names as those in edgeR. Accordingly, the normaliza-
tion factors calculated from TCC with arbitrary options should be manipulated together
with the library sizes when normalized read counts are to be obtained. Since biologists are
often interested in such information (Dillies et al., 2012), we provide the getNormalizedData
function for retrieving normalized data.

Note that the hypoData consists of 1, 000 genes and a total of six samples (three bio-
logical replicates for G1 and three biological replicates for G2); i.e., {G1_rep1, G1_rep2,
G1_rep3} vs. {G2_rep1, G2_rep2, G2_rep3}. These simulation data have basically the
same conditions as shown in Fig. 1 of the TbT paper (Kadota et al., 2012); i.e., (i) the first
200 genes are DEGs (PDEG = 200/1000 = 20%), (ii) the first 180 genes of the 200 DEGs are
higher in G1 (PG1 = 180/200 = 90%), and the remaining 20 DEGs are higher in G2, and (iii)
the level of DE is four-fold. The last 800 genes were designed to be non-DEGs. The different
normalization strategies can roughly be evaluated in terms of the similarity of their summary
statistics for normalized data labeled as non-DEGs in one group (e.g., G1) to those of the
other group (e.g., G2). The basic statistics for the non-DEGs are as follows.

> library(TCC)
> data(hypoData)
> nonDEG <- 201:1000
> summary(hypoData[nonDEG, ])

G1_rep2

0
Min.
:
1st Qu.:
4
Median : 20
Mean
: 105
3rd Qu.: 68
Max.
:9548
G2_rep3

G1_rep3

0.00
Min.
:
1st Qu.:
3.00
Median : 20.00
Mean
: 104.45
3rd Qu.: 73.25
:8810.00
Max.

G2_rep1

0.0
Min.
:
1st Qu.:
3.0
Median : 21.0
Mean
: 113.8
3rd Qu.: 68.0
:9304.0
Max.

G1_rep1

0.00
Min.
:
1st Qu.:
3.00
Median : 20.50
Mean
: 103.36
3rd Qu.: 74.25
:8815.00
Max.

G2_rep2

0
Min.
:
1st Qu.:
3
Median : 21
Mean
: 105
3rd Qu.: 70
:9466
Max.

0.0
Min.
:
1st Qu.:
3.0
Median : 20.0
Mean
: 104.6
3rd Qu.: 70.0
:9320.0
Max.

From now on, we will display only the median values for simplicity, i.e.,

> apply(hypoData[nonDEG, ], 2, median)

16

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3
20.0

21.0

20.0

21.0

20.5

20.0

In what follows, we show detailed examples using hypoData. Note, however, that the

basic usage is simple.

> normalized.count <- getNormalizedData(tcc)

3.4.1 Retrieving two-group DEGES/edgeR-normalized data with replicates

The getNormalizedData function can be applied to the TCC class object after the normal-
ization factors have been calculated. The DEGES/edgeR-normalized data can be retrieved
as follows.

> library(TCC)
> data(hypoData)
> nonDEG <- 201:1000
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> normalized.count <- getNormalizedData(tcc)
> apply(normalized.count[nonDEG, ], 2, median)

iteration = 1, FDR = 0.1, floorPDEG = 0.05)

G1_rep1

G2_rep3
20.17847 19.69062 19.44889 21.23188 21.68569 20.35503

G2_rep1 G2_rep2

G1_rep3

G1_rep2

> range(apply(normalized.count[nonDEG, ], 2, median))

[1] 19.44889 21.68569

For comparison, the summary statistics for TMM-normalized data produced using the

original normalization method (i.e., TMM) in edgeR can be obtained as follows.

> library(TCC)
> data(hypoData)
> nonDEG <- 201:1000
> group <- c(1, 1, 1, 2, 2, 2)
> d <- DGEList(count = hypoData, group = group)
> d <- calcNormFactors(d)
> norm.factors <- d$samples$norm.factors
> effective.libsizes <- colSums(hypoData) * norm.factors
> normalized.count <- sweep(hypoData, 2,
+
> apply(normalized.count[nonDEG, ], 2, median)

mean(effective.libsizes) / effective.libsizes, "*")

G1_rep1

G2_rep3
19.35893 19.01078 18.59060 22.98591 22.16273 21.00685

G2_rep1 G2_rep2

G1_rep3

G1_rep2

> range(apply(normalized.count[nonDEG, ], 2, median))

[1] 18.59060 22.98591

It is obvious that the summary statistics (ranging from 19.44889 to 21.68569 ) from
DEGES/edgeR-normalized data are closer to the truth (i.e., ranging from 20.0 to 21.0) than
those (ranging from 18.59060 to 22.98591 from TMM-normalized data.

17

3.4.2 Retrieving two-group DEGES/edgeR-normalized data without replicates

(paired)

We here analyze the hypoData object provided in TCC. As described in 3.2, we regard
hypoData as a hypothetical paired data. The DEGES/edgeR-normalized data can be re-
trieved as follows.
> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> nonDEG <- 201:1000
> group <- c(1, 1, 1, 2, 2, 2)
> pair <- c(1, 2, 3, 1, 2, 3)
> cl <- data.frame(group = group, pair = pair)
> tcc <- new("TCC", hypoData, cl)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> normalized.count <- getNormalizedData(tcc)
> head(normalized.count, n = 4)

iteration = 1, FDR = 0.1, floorPDEG = 0.05, paired = TRUE)

T_dogB

T_dogA
32.97064

N_dogC
gene_1
14.37695 28.93472
25.67313 67.84694
gene_2
gene_3 1109.36514 918.45203 974.41555 383.13682 492.92410 238.46204
0.00000
gene_4

N_dogA
16.39088
21.65368 36.87948

T_dogC
44.97317 120.07949

347.16147 387.76865

0.00000 43.30736

18.43974

0.00000

0.00000

N_dogB

> apply(normalized.count[nonDEG, ], 2, median)

T_dogA

N_dogC
19.87936 19.98807 19.68516 21.51303 21.56543 19.95498

N_dogA

N_dogB

T_dogC

T_dogB

> range(apply(normalized.count[nonDEG, ], 2, median))

[1] 19.68516 21.56543

For comparison, the summary statistics for TMM-normalized data produced using the

original normalization method (i.e., TMM) in edgeR can be obtained as follows.
> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> nonDEG <- 201:1000
> group <- factor(c(1, 1, 1, 2, 2, 2))
> d <- DGEList(counts = hypoData, group = group)
> d <- calcNormFactors(d)
> norm.factors <- d$samples$norm.factors
> effective.libsizes <- colSums(hypoData) * norm.factors
> normalized.count <- sweep(hypoData, 2,
+
> apply(normalized.count[nonDEG, ], 2, median)

mean(effective.libsizes) / effective.libsizes, "*")

T_dogA

N_dogC
19.35893 19.01078 18.59060 22.98591 22.16273 21.00685

N_dogA

N_dogB

T_dogB

T_dogC

> range(apply(normalized.count[nonDEG, ], 2, median))

[1] 18.59060 22.98591

It is obvious that the summary statistics (ranging from 19.68516 to 21.56543 ) from
DEGES/edgeR-normalized data are closer to the truth (i.e., ranging from 20.0 to 21.0) than
those (ranging from 18.59060 to 22.98591) from TMM-normalized data.

18

3.4.3 Retrieving multi-group iDEGES/edgeR-normalized data with replicates

Here, we analyze another hypothetical three-group count matrix, the hypoData_mg object,
provided in TCC. It consists of 1, 000 genes and a total of nine columns for testing any
difference among three groups that each have triplicates. Similar to the hypoData object, the
first 200 genes are DEGs and the remaining 800 genes are non-DEGs. The basic statistics
for the non-DEGs are as follows.

> library(TCC)
> data(hypoData_mg)
> nonDEG <- 201:1000
> summary(hypoData_mg[nonDEG, ])

G1_rep2

Min.
:
1st Qu.:
Median :
Mean
:
3rd Qu.:
Max.

0.0
2.0
13.0
150.5
53.0
:27987.0

G2_rep3

:
Min.
1st Qu.:
Median :
Mean
:
3rd Qu.:
Max.

0.0
2.0
14.0
138.4
55.0
:24979.0

G1_rep3

Min.
:
1st Qu.:
Median :
Mean
:
3rd Qu.:
Max.

0.0
2.0
14.5
190.6
55.0
:66273.0

G3_rep1

:
Min.
1st Qu.:
Median :
Mean
:
3rd Qu.:
Max.

0
2
14
164
52
:49398

G2_rep1

Min.
:
1st Qu.:
Median :
Mean
3rd Qu.:
Max.

0.0
2.0
13.0
: 199.4
52.0
:75148.0

G3_rep2

:
Min.
1st Qu.:
Median :
Mean
3rd Qu.:
Max.

0.0
2.0
15.0
: 166.2
55.0
:49709.0

G1_rep1

Min.
:
1st Qu.:
Median :
Mean
3rd Qu.:
Max.

0.00
2.00
14.00
: 135.41
51.25
:27218.00

G2_rep2

:
Min.
1st Qu.:
Median :
Mean
3rd Qu.:
Max.

0.00
2.00
13.00
: 132.53
52.25
:22381.00

G3_rep3

Min.
:
1st Qu.:
Median :
Mean
3rd Qu.:
Max.

0.0
2.0
15.0
: 152.1
50.0
:39299.0

From now on, we will display only the median values for simplicity, i.e.,

> apply(hypoData_mg[nonDEG, ], 2, median)

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3 G3_rep1 G3_rep2 G3_rep3
15.0

13.0

13.0

14.5

14.0

14.0

13.0

14.0

15.0

The iDEGES/edgeR-normalized data can be retrieved as follows.

> library(TCC)
> data(hypoData_mg)
> nonDEG <- 201:1000
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> tcc <- new("TCC", hypoData_mg, group)
> design <- model.matrix(~ as.factor(group))
> coef <- 2:length(unique(group))
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> normalized.count <- getNormalizedData(tcc)
> apply(normalized.count[nonDEG, ], 2, median)

iteration = 3)

G1_rep1

G3_rep2
G2_rep1 G2_rep2
13.98572 13.09136 14.19500 12.99153 13.29936 13.51934 13.96559 14.73326

G2_rep3 G3_rep1

G1_rep3

G1_rep2

G3_rep3
15.78603

19

> range(apply(normalized.count[nonDEG, ], 2, median))

[1] 12.99153 15.78603

For comparison, the summary statistics for TMM-normalized data produced using the

original normalization method (i.e., TMM) in edgeR are obtained as follows.

> library(TCC)
> data(hypoData_mg)
> nonDEG <- 201:1000
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> d <- DGEList(tcc$count, group = group)
> d <- calcNormFactors(d)
> norm.factors <- d$samples$norm.factors
> effective.libsizes <- colSums(hypoData) * norm.factors
> normalized.count <- sweep(hypoData, 2,
+
> apply(normalized.count[nonDEG, ], 2, median)

mean(effective.libsizes) / effective.libsizes, "*")

T_dogA

N_dogC
21.12359 19.78313 19.69837 20.59855 20.66165 19.89551

N_dogA

N_dogB

T_dogB

T_dogC

> range(apply(normalized.count[nonDEG, ], 2, median))

[1] 19.69837 21.12359

It is obvious that the summary statistics (ranging from 12.99153 to 15.78603) from
iDEGES/edgeR-normalized data are closer to the truth (i.e., ranging from 13.0 to 15.0)
than those (ranging from 19.69837 to 21.12359) from TMM-normalized data.

20

4 Differential expression (DE)

The particular feature of TCC is that it calculates robust normalization factors. Moreover,
end users would like to have some accessory functions for subsequent analyses. Here, we
provide the estimateDE function for identifying DEGs. Specifically, the function internally
uses the corresponding functions implemented in three packages. Similar to the usage in the
calcNormFactors function with the test.method argument in TCC, those DE methods in
edgeR can be performed by using the estimateDE function with test.method = "edger",
and "deseq2", respectively. Here, we show some examples of DE analysis for two-group data
with replicates (4.1), two-group data without replicates (??), paired two-group data without
replicates (4.2), and multi-group data with replicates (4.3).

4.1 DE analysis for two-group data with replicates

4.1.1

edgeR coupled with iDEGES/edgeR normalization

We give a procedure for DE analysis using the exact test implemented in edgeR together
with iDEGES/edgeR normalization factors (i.e., the iDEGES/edgeR-edgeR combination) for
the hypothetical two-group count data with replicates (i.e., the hypoData object). If the user
wants to determine the genes having an FDR threshold of < 10% as DEGs, one can do as
follows.

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)

iteration = 3, FDR = 0.1, floorPDEG = 0.05)

The results of the DE analysis are stored in the TCC class object. The summary statistics

for top-ranked genes can be retrieved by using the getResult function.

> result <- getResult(tcc, sort = TRUE)
> head(result)

gene_id

a.value

m.value

p.value

1 gene_151 9.736230 -2.749909 6.080655e-06 0.001169953
2 gene_168 8.903595 -1.965453 7.079033e-06 0.001169953
3 gene_144 7.588262 -2.126825 7.651455e-06 0.001169953
4
gene_11 8.772243 -2.101167 9.417202e-06 0.001169953
5 gene_123 8.213530 -2.148411 1.052097e-05 0.001169953
6 gene_143 9.284689 -1.970371 1.053439e-05 0.001169953

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

The DE results can be broken down as follows.

> table(tcc$estimatedDEG)

0

1
864 136

This means 864 non-DEGs and 136 DEGs satisfy FDR < 0.1. The plot function generates
an M-A plot, where "M" indicates the log-ratio (i.e., M = log2 G2−log2 G1) and "A" indicates
average read count (i.e., A = (log2 G2 + log2 G1)/2), from the normalized count data. The
magenta points indicate the identified DEGs at FDR < 0.1.

21

> plot(tcc)

Since we know the true information for hypoData (i.e., 200 DEGs and 800 non-DEGs), we
can calculate the area under the ROC curve (i.e., AUC; 0 ≤ AUC ≤ 1) between the ranked
gene list and the truth and thereby evaluate the sensitivity and specificity simultaneously. A
well-ranked gene list should have a high AUC value (i.e., high sensitivity and specificity).

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))

[1] 0.8901906

For comparison, the DE results from the original procedure in edgeR can be obtained as

follows.

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> design <- model.matrix(~ as.factor(group))
> d <- DGEList(count = hypoData, group = group)
> d <- calcNormFactors(d)
> d <- estimateDisp(d, design)
> fit <- glmQLFit(d, design)
> out <- glmQLFTest(fit, coef = 2)
> result <- as.data.frame(topTags(out, n = nrow(hypoData), sort.by = "PValue"))
> head(result)

22

F

logFC

logCPM

FDR
gene_151 -2.600042 13.268812 87.52273 9.876253e-06 0.001851116
gene_168 -1.820357 12.186563 83.82698 1.167120e-05 0.001851116
gene_144 -1.979302 10.925554 81.02456 1.332253e-05 0.001851116
gene_189
9.661868 80.67547 1.372531e-05 0.001851116
-2.034189 15.740774 79.65752 1.420299e-05 0.001851116
gene_63
-1.956549 12.094762 78.52928 1.500692e-05 0.001851116
gene_11

2.545445

PValue

This is the same as

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", iteration = 0)
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> result <- getResult(tcc, sort = TRUE)
> head(result)

gene_id

a.value

m.value

p.value

1 gene_151 9.740529 -2.600366 9.876253e-06 0.001851116
2 gene_168 8.905896 -1.820884 1.167120e-05 0.001851116
3 gene_144 7.591264 -1.980620 1.332253e-05 0.001851116
4 gene_189 6.127498
2.550316 1.372531e-05 0.001851116
gene_63 12.402707 -2.034277 1.420299e-05 0.001851116
5
gene_11 8.774575 -1.957134 1.500692e-05 0.001851116
6

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

> AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))

[1] 0.8723094

The results of the DE analysis are stored in the TCC class object. The summary statistics

for top-ranked genes can be retrieved by using the getResult function.

> result <- getResult(tcc, sort = TRUE)
> head(result)

gene_id

a.value

m.value

p.value

1 gene_151 9.740529 -2.600366 9.876253e-06 0.001851116
2 gene_168 8.905896 -1.820884 1.167120e-05 0.001851116
3 gene_144 7.591264 -1.980620 1.332253e-05 0.001851116
4 gene_189 6.127498
2.550316 1.372531e-05 0.001851116
gene_63 12.402707 -2.034277 1.420299e-05 0.001851116
5
gene_11 8.774575 -1.957134 1.500692e-05 0.001851116
6

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

The DE results can be broken down as follows.

> table(tcc$estimatedDEG)

0

1
877 123

This means 877 non-DEGs and 123 DEGs satisfy FDR < 0.1. The plot function generates
an M-A plot, where "M" indicates the log-ratio (i.e., M = log2 G2−log2 G1) and "A" indicates
average read count (i.e., A = (log2 G2 + log2 G1)/2), from the normalized count data. The
magenta points indicate the identified DEGs at FDR < 0.1.

23

> plot(tcc)

Since we know the true information for hypoData (i.e., 200 DEGs and 800 non-DEGs), we
can calculate the area under the ROC curve (i.e., AUC; 0 ≤ AUC ≤ 1) between the ranked
gene list and the truth and thereby evaluate the sensitivity and specificity simultaneously. A
well-ranked gene list should have a high AUC value (i.e., high sensitivity and specificity).

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))

[1] 0.8723094

4.1.2 DESeq2 coupled with iDEGES/DESeq2 normalization

For comparison, the DE results from the original procedure in DESeq2 can be obtained as
follows.

> library(TCC)
> data(hypoData)
> group <- factor(c(1, 1, 1, 2, 2, 2))
> cl <- data.frame(group = group)
> design <- formula(~ group)

24

> dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
+
> dds <- estimateSizeFactors(dds)
> sizeFactors(dds) <- sizeFactors(dds) / mean(sizeFactors(dds))
> dds <- estimateDispersions(dds)
> dds <- nbinomWaldTest(dds)
> result <- results(dds)
> head(result[order(result$pvalue),])

design = design)

log2 fold change (MLE): group 2 vs 1
Wald test p-value: group 2 vs 1
DataFrame with 6 rows and 6 columns

gene_168
gene_144
gene_11
gene_143
gene_115
gene_109

<numeric>
577.362
239.748
541.281
752.478
574.796
763.275

baseMean log2FoldChange

stat
<numeric> <numeric> <numeric>

lfcSE

pvalue
<numeric>

padj
<numeric>
0.188923 -9.58750 9.02463e-22 7.58971e-19
0.220284 -8.95678 3.34295e-19 1.40571e-16
0.230809 -8.43287 3.37280e-17 9.45507e-15
0.218271 -8.32181 8.66293e-17 1.82138e-14
0.216748 -8.25749 1.48766e-16 2.50224e-14
0.214623 -8.04432 8.67290e-16 1.21565e-13

-1.81130
-1.97304
-1.94638
-1.81641
-1.78980
-1.72650

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> result$pvalue[is.na(result$pvalue)] <- 1
> AUC(rocdemo.sca(truth = truth, data = -rank(result$pvalue)))

[1] 0.8632313

This is the same as

> library(TCC)
> data(hypoData)
> group <- c(1, 1, 1, 2, 2, 2)
> tcc <- new("TCC", hypoData, group)
> tcc <- calcNormFactors(tcc, norm.method = "deseq2", iteration = 0)
> tcc <- estimateDE(tcc, test.method = "deseq2", FDR = 0.1)
> result <- getResult(tcc, sort = TRUE)
> head(result)

gene_id

a.value

m.value

p.value

1 gene_168 8.905999 -1.811262 9.024627e-22 9.024627e-19
2 gene_144 7.591478 -1.973100 3.342948e-19 1.671474e-16
3
gene_11 8.774276 -1.946228 3.372796e-17 1.124265e-14
4 gene_143 9.286710 -1.816512 8.662935e-17 2.165734e-14
5 gene_115 8.905535 -1.789730 1.487657e-16 2.975314e-14
6 gene_109 9.331890 -1.726446 8.672896e-16 1.445483e-13

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))

[1] 0.8632219

> tcc$norm.factors

25

G1_rep1

G2_rep3
0.9271692 0.9147550 0.8753592 1.0217885 1.1069052 1.1540229

G2_rep2

G2_rep1

G1_rep3

G1_rep2

As described in 3.4, the size factors termed in DESeq2 is comparable to the normalized
effective library sizes termed in TCC and edgeR. The effective library size in edgeR is
calculated as the library size multiplied by the normalization factor. The normalization
factors and effective library sizes in DESeq2 can be retrieved as follows.

> library(TCC)
> data(hypoData)
> group <- factor(c(1, 1, 1, 2, 2, 2))
> cl <- data.frame(group = group)
> design <- formula(~ group)
> dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
+
> dds <- estimateSizeFactors(dds)
> size.factors <- sizeFactors(dds)
> size.factors

design = design)

G1_rep1

G2_rep3
1.0830730 1.0919605 1.0779951 0.9411006 0.9468033 0.9668911

G2_rep2

G2_rep1

G1_rep3

G1_rep2

> hoge <- size.factors / colSums(hypoData)
> norm.factors <- hoge / mean(hoge)
> norm.factors

G1_rep1

G2_rep3
0.9271692 0.9147550 0.8753592 1.0217885 1.1069052 1.1540229

G1_rep3

G2_rep2

G2_rep1

G1_rep2

> ef.libsizes <- norm.factors * colSums(hypoData)
> ef.libsizes

G1_rep1

G2_rep3
131822.1 132903.8 131204.1 114542.5 115236.6 117681.5

G2_rep1 G2_rep2

G1_rep3

G1_rep2

Note that the following commands should be the simplest procedure provided in DESeq2.

> library(TCC)
> data(hypoData)
> group <- factor(c(1, 1, 1, 2, 2, 2))
> cl <- data.frame(group = group)
> design <- formula(~ group)
> dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
+
> dds <- estimateSizeFactors(dds)
> sizeFactors(dds) <- sizeFactors(dds) / mean(sizeFactors(dds))
> dds <- estimateDispersions(dds)
> dds <- nbinomWaldTest(dds)
> result <- results(dds)
> head(result[order(result$pvalue),])

design = design)

26

log2 fold change (MLE): group 2 vs 1
Wald test p-value: group 2 vs 1
DataFrame with 6 rows and 6 columns

gene_168
gene_144
gene_11
gene_143
gene_115
gene_109

<numeric>
577.362
239.748
541.281
752.478
574.796
763.275

baseMean log2FoldChange

stat
<numeric> <numeric> <numeric>

lfcSE

pvalue
<numeric>

padj
<numeric>
0.188923 -9.58750 9.02463e-22 7.58971e-19
0.220284 -8.95678 3.34295e-19 1.40571e-16
0.230809 -8.43287 3.37280e-17 9.45507e-15
0.218271 -8.32181 8.66293e-17 1.82138e-14
0.216748 -8.25749 1.48766e-16 2.50224e-14
0.214623 -8.04432 8.67290e-16 1.21565e-13

-1.81130
-1.97304
-1.94638
-1.81641
-1.78980
-1.72650

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> result$pvalue[is.na(result$pvalue)] <- 1
> AUC(rocdemo.sca(truth = truth, data = -rank(result$pvalue)))

[1] 0.8632313

4.2 DE analysis for two-group data without replicates (paired)

edgeR and DESeq2 employs generalized linear models (GLMs) which can apply to detect
DEGs from paired two-group count data. The analysis for paired samples can be performed
by indicating (1) the pair information when constructing the TCC class object and (2) paired
= TRUE when performing the calcNormFactors and estimateDE functions. For analyzing
paired data, we here use the hypothetical count data (hypoData; for details see 2.2) by
changing the label information, i.e.,

> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> head(hypoData)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

T_dogA T_dogB T_dogC N_dogA N_dogB N_dogC
29
68
239
0
5
69

34
358
1144
0
98
296

122
22
990
44
17
216

14
25
480
0
8
62

45
388
919
0
48
282

16
36
374
18
1
86

This count data consists of three individuals (or sibships), dogA, dogB, and dogC. "T"

and "N" indicate tumor and normal tissues, respectively.

We give a procedure for DE analysis using the likelihood ratio test for GLMs implemented
in edgeR together with iDEGES/edgeR normalization factors (i.e., the iDEGES/edgeR-
edgeR combination) for the paired two-group count data without replicates (i.e., the above
If the user wants to determine the genes having an FDR threshold of
hypoData object).
< 10% as DEGs, one can do as follows.

> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> group <- c(1, 1, 1, 2, 2, 2)
> pair <- c(1, 2, 3, 1, 2, 3)

27

> cl <- data.frame(group = group, pair = pair)
> tcc <- new("TCC", hypoData, cl)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1, paired = TRUE)

iteration = 3, FDR = 0.1, floorPDEG = 0.05, paired = TRUE)

The results of the DE analysis are stored in the TCC class object. The summary statistics

for top-ranked genes can be retrieved by using the getResult function.

> result <- getResult(tcc, sort = TRUE)
> head(result)

gene_id

a.value

m.value

p.value

1 gene_151 9.737803 -2.748750 1.828957e-05 0.008160203
gene_63 12.401791 -2.173985 3.773256e-05 0.008160203
2
gene_68 6.209074 -2.861730 5.759222e-05 0.008160203
3
gene_11 8.772408 -2.099626 6.229838e-05 0.008160203
4
5 gene_105 9.350474 -1.990018 6.830645e-05 0.008160203
gene_16 7.348146 -2.339941 8.210415e-05 0.008160203
6

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

The DE results can be broken down as follows.

> table(tcc$estimatedDEG)

0

1
870 130

This means 870 non-DEGs and 130 DEGs satisfy FDR < 0.1. The plot function generates
an M-A plot, where "M" indicates the log-ratio (i.e., M = log2 G2−log2 G1) and "A" indicates
average read count (i.e., A = (log2 G2 + log2 G1)/2), from the normalized count data. The
magenta points indicate the identified DEGs at FDR < 0.1.

> plot(tcc)

28

Since we know the true information for hypoData (i.e., 200 DEGs and 800 non-DEGs), we
can calculate the area under the ROC curve (i.e., AUC; 0 ≤ AUC ≤ 1) between the ranked
gene list and the truth and thereby evaluate the sensitivity and specificity simultaneously. A
well-ranked gene list should have a high AUC value (i.e., high sensitivity and specificity).

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))

[1] 0.8864406

For comparison, the DE results from the original procedure in edgeR can be obtained as

follows.

> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> group <- factor(c(1, 1, 1, 2, 2, 2))
> pair <- factor(c(1, 2, 3, 1, 2, 3))
> design <- model.matrix(~ group + pair)
> coef <- 2
> d <- DGEList(counts = hypoData, group = group)
> d <- calcNormFactors(d)
> d <- estimateDisp(d, design)
> fit <- glmQLFit(d, design)
> out <- glmQLFTest(fit, coef=2)
> topTags(out, n = 6)

29

Coefficient: group2

F

logFC

logCPM

FDR
gene_151 -2.572320 13.268838 105.29165 2.589706e-05 0.01150968
81.10261 5.848064e-05 0.01150968
gene_63
74.45975 7.711169e-05 0.01150968
gene_68
69.02043 9.654024e-05 0.01150968
gene_196
67.78335 1.015699e-04 0.01150968
gene_11
67.55705 1.033359e-04 0.01150968
gene_189

-2.073043 15.740778
9.808735
-2.760148
9.964259
2.503636
-1.953231 12.094808
9.661587

2.539059

PValue

> p.value <- out$table$PValue
> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> AUC(rocdemo.sca(truth = truth, data = -rank(p.value)))

[1] 0.8672281

This is the same as

> library(TCC)
> data(hypoData)
> colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
+
"N_dogA", "N_dogB", "N_dogC")
> group <- c(1, 1, 1, 2, 2, 2)
> pair <- c(1, 2, 3, 1, 2, 3)
> cl <- data.frame(group = group, pair = pair)
> tcc <- new("TCC", hypoData, cl)
> tcc <- calcNormFactors(tcc, norm.method = "tmm", iteration = 0, paired = TRUE)
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1, paired = TRUE)
> result <- getResult(tcc, sort = TRUE)
> head(result)

gene_id

a.value

p.value

m.value
1 gene_151 9.740529 -2.600366 2.589706e-05 0.01150968
gene_63 12.402707 -2.034277 5.848064e-05 0.01150968
2
gene_68 6.209636 -2.723799 7.711169e-05 0.01150968
3
4 gene_196 6.461462
2.475704 9.654024e-05 0.01150968
gene_11 8.774575 -1.957134 1.015699e-04 0.01150968
5
2.550316 1.033359e-04 0.01150968
6 gene_189 6.127498

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

> library(ROC)
> truth <- c(rep(1, 200), rep(0, 800))
> AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))

[1] 0.8672281

4.3 DE analysis for multi-group data with replicates

Here, we give three examples of DE analysis coupled with DEGES/edgeR normalization for
the hypothetical three-group data with replicates, i.e., the hypoData_mg object. The use of
the DEGES/edgeR normalization factors is simply for reducing the computation time.

30

4.3.1

edgeR coupled with DEGES/edgeR normalization

The exact test implemented in edgeR after executing the DEGES/edgeR normalization (i.e.,
the DEGES/edgeR-edgeR combination) can be performed as follows.

Normalization

> library(TCC)
> data(hypoData_mg)
> group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
> tcc <- new("TCC", hypoData_mg, group)
> ###
> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> ###
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> result <- getResult(tcc, sort = TRUE)
> head(result)

iteration = 1)

DE analysis

###

###

gene_id a.value m.value

p.value

1 gene_140
2 gene_121
gene_39
3
gene_64
4
5 gene_134
gene_27
6

NA
NA
NA
NA
NA
NA

NA 2.402933e-07 8.349189e-05
NA 2.405169e-07 8.349189e-05
NA 3.253656e-07 8.349189e-05
NA 3.339675e-07 8.349189e-05
NA 5.457863e-07 9.231899e-05
NA 6.507854e-07 9.231899e-05

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

> table(tcc$estimatedDEG)

0

1
851 149

5 Generation of simulation data

5.1

Introduction and basic usage

As demonstrated in our previous study (Kadota et al., 2012), the DEGES-based normaliza-
tion methods implemented in TCC theoretically outperform the other normalization meth-
ods when the numbers of DEGs (G1 vs. G2) in the tag count data are biased. However,
it is difficult to determine whether the up- and down-regulated DEGs in one of the groups
are actually biased in their number when analyzing real data (Dillies et al., 2012). This
means we have to evaluate the potential performance of our DEGES-based methods using
mainly simulation data. The simulateReadCounts function generates simulation data under
various conditions. This function can generate simulation data analyzed in the TbT paper
(Kadota et al., 2012), and that means it enables other researchers to compare the meth-
ods they develop with our DEGES-based methods. For example, the hypoData object, a
hypothetical count dataset provided in TCC, was generated by using this function. The
output of the simulateReadCounts function is stored as a TCC class object and is therefore
ready-to-analyze.

Note that different trials of simulation analysis generally yield different count data even
under the same simulation conditions. We can call the set.seed function in order to obtain
reproducible results (i.e., the tcc$count) with the simulateReadCounts function.

31

> set.seed(1000)
> library(TCC)
> tcc <- simulateReadCounts(Ngene = 1000, PDEG = 0.2,
+
+
+
> dim(tcc$count)

DEG.assign = c(0.9, 0.1),
DEG.foldchange = c(4, 4),
replicates = c(3, 3))

[1] 1000

6

> head(tcc$count)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G1_rep2 G1_rep3 G2_rep1 G2_rep2 G2_rep3
57
3
13
12
5
77

65
114
44
18
4
338

267
87
84
7
11
212

347
10
121
62
2
353

14
4
17
19
3
50

3
4
15
1
1
59

> tcc$group

G1_rep1
G1_rep2
G1_rep3
G2_rep1
G2_rep2
G2_rep3

group
1
1
1
2
2
2

The simulation conditions for comparing two groups (G1 vs. G2) with biological replicates
are as follows: (i) the number of genes is 1, 000 (i.e., Ngene = 1000), (ii) the first 20% of
genes are DEGs (PDEG = 0.2), (iii) the first 90% of the DEGs are up-regulated in G1, and the
remaining 10% are up-regulated in G2 (DEG.assign = c(0.9, 0.1)), (iv) the levels of DE
are four-fold in both groups (DEG.foldchange = c(4, 4)), and (v) there are a total of six
samples (three biological replicates for G1 and three biological replicates for G2) (replicates
= c(3, 3)). The variance of the NB distribution can be modeled as V = µ + ϕµ2. The
empirical distribution of the read counts for producing the mean (µ) and dispersion (ϕ)
parameters of the model was obtained from Arabidopsis data (three biological replicates for
each of the treated and non-treated groups) in NBPSeq (Di et al., 2011).

The tcc$count object is essentially the same as the hypoData object of TCC. The

information about the simulation conditions can be viewed as follows.

> str(tcc$simulation)

List of 4

$ trueDEG

: Named num [1:1000] 1 1 1 1 1 1 1 1 1 1 ...
..- attr(*, "names")= chr [1:1000] "gene_1" "gene_2" "gene_3" "gene_4" ...

$ DEG.foldchange: num [1:1000, 1:6] 4 4 4 4 4 4 4 4 4 4 ...

..- attr(*, "dimnames")=List of 2
.. ..$ : chr [1:1000] "gene_1" "gene_2" "gene_3" "gene_4" ...
.. ..$ : chr [1:6] "G1_rep1" "G1_rep2" "G1_rep3" "G2_rep1" ...

$ PDEG
$ params

: num [1:2] 0.18 0.02
:'data.frame':

1000 obs. of 2 variables:

..$ mean: num [1:1000] 30.82 14.06 16.98 12.97 1.94 ...
..$ disp: num [1:1000] 0.8363 1.8306 0.0962 0.5087 0.5527 ...

32

Specifically, the entries for 0 and 1 in the tcc$simulation$trueDEG object are for non-
DEGs and DEGs respectively. The breakdowns for individual entries are the same as stated
above: 800 entries are non-DEGs, 200 entries are DEGs.

> table(tcc$simulation$trueDEG)

0

1
800 200

This information can be used to evaluate the performance of the DEGES-based normal-
ization methods in terms of the sensitivity and specificity of the results of their DE analysis.
A good normalization method coupled with a DE method such as the exact test (Robin-
son and Smyth, 2008) and the empirical Bayes (Hardcastle and Kelly, 2010) should produce
well-ranked gene lists in which the true DEGs are top-ranked and non-DEGs are bottom-
ranked when all genes are ranked according to the degree of DE. The ranked gene list after
performing the DEGES/edgeR-edgeR combination can be obtained as follows.

> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> result <- getResult(tcc, sort = TRUE)
> head(result)

iteration = 1, FDR = 0.1, floorPDEG = 0.05)

a.value

m.value

p.value

gene_id
1
gene_63 10.935920 -2.157532 7.679323e-07 0.0007394115
2 gene_170 10.192642 -1.933620 2.061991e-06 0.0007394115
gene_83 12.299893 -1.881799 2.218234e-06 0.0007394115
3
gene_57 11.525386 -1.963334 3.090409e-06 0.0007726022
4
gene_23 8.701274 -2.124998 8.580802e-06 0.0013337690
5
1.969640 9.217568e-06 0.0013337690
6 gene_190 8.467266

q.value rank estimatedDEG
1
1
1
1
1
1

1
2
3
4
5
6

We can now calculate the area under the ROC curve (i.e., AUC; 0 ≤AUC≤ 1) between the
ranked gene list and the truth (i.e., DEGs or non-DEGs) and thereby evaluate the sensitivity
and specificity simultaneously. A well-ranked gene list should have a high AUC value (i.e.,
high sensitivity and specificity). The calcAUCValue function calculates the AUC value based
on the information stored in the TCC class object.

> calcAUCValue(tcc)

[1] 0.9128375

This is essentially the same as

> AUC(rocdemo.sca(truth = as.numeric(tcc$simulation$trueDEG != 0),
+

data = -tcc$stat$rank))

[1] 0.9128375

The following classic edgeR procedure (i.e., the TMM-edgeR combination) make it clear
that the DEGES-based normalization method (i.e., the DEGES/edgeR pipeline) outperforms
the default normalization method (i.e., TMM) implemented in edgeR.

33

> tcc <- calcNormFactors(tcc, norm.method = "tmm", iteration = 0)
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> calcAUCValue(tcc)

[1] 0.8972375

The following is an alternative procedure for edgeR users.

> design <- model.matrix(~ as.factor(tcc$group$group))
> d <- DGEList(counts = tcc$count, group = tcc$group$group)
> d <- calcNormFactors(d)
> d$samples$norm.factors <- d$samples$norm.factors /
+
> d <- estimateDisp(d, design)
> fit <- glmQLFit(d, design)
> result <- glmQLFTest(fit, coef = 2)
> result$table$PValue[is.na(result$table$PValue)] <- 1
> AUC(rocdemo.sca(truth = as.numeric(tcc$simulation$trueDEG != 0),
+

data = -rank(result$table$PValue)))

mean(d$samples$norm.factors)

[1] 0.8972375

5.2 Multi-group data with and without replicates

The simulateReadCounts function can generate simulation data with a more complex design.
First, we generate a dataset consisting of three groups. The simulation conditions for this
dataset are as follows: (i) the number of genes is 1, 000 (i.e., Ngene = 1000), (ii) the first
30% of genes are DEGs (PDEG = 0.3), (iii) the breakdowns of the up-regulated DEGs are
respectively 70%, 20%, and 10% in Groups 1-3 (DEG.assign = c(0.7, 0.2, 0.1)), (iv) the
levels of DE are 3-, 10-, and 6-fold in individual groups (DEG.foldchange = c(3, 10, 6)),
and (v) there are a total of nine libraries (2, 4, and 3 replicates for Groups 1-3) (replicates
= c(2, 4, 3)).

> set.seed(1000)
> library(TCC)
> tcc <- simulateReadCounts(Ngene = 1000, PDEG = 0.3,
+
+
+
> dim(tcc$count)

DEG.assign = c(0.7, 0.2, 0.1),
DEG.foldchange = c(3, 10, 6),
replicates = c(2, 4, 3))

[1] 1000

9

> tcc$group

G1_rep1
G1_rep2
G2_rep1
G2_rep2
G2_rep3
G2_rep4
G3_rep1
G3_rep2
G3_rep3

group
1
1
2
2
2
2
3
3
3

34

> head(tcc$count)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G1_rep2 G2_rep1 G2_rep2 G2_rep3 G2_rep4 G3_rep1 G3_rep2 G3_rep3
3
24
20
5
0
108

259
8
92
48
2
264

63
12
64
43
6
237

37
2
23
14
4
81

5
13
14
24
3
82

66
22
20
8
5
87

4
0
23
6
7
38

12
2
18
12
0
60

24
47
18
9
2
73

The pseudo-color image for the generated simulation data regarding the DEGs can be
obtained from the plotFCPseudocolor function. The right bar (from white to magenta)
indicates the degree of fold-change (FC). As expected, it can be seen that the first 210, 60,
and 30 genes are up-regulated in G1, G2, and G3, respectively.

> plotFCPseudocolor(tcc)

Now let us see how the DEGES/edgeR-edgeR combination with the original edgeR-edgeR
combination performs. First we calculate the AUC value for the ranked gene list obtained
from the DEGES/edgeR-edgeR combination.

> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> calcAUCValue(tcc)

iteration = 1)

35

[1] 0.8788714

Next, we calculate the corresponding value using the original edgeR procedure for single

factor experimental design (i.e., the edgeR-edgeR combination).

> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
> calcAUCValue(tcc)

iteration = 0)

[1] 0.863919

It can be seen that the DEGES/edgeR-edgeR combination outperforms the original
edgeR procedure under the given simulation conditions. Note that the test.method ar-
gument will be ignored when iteration = 0 is specified.

Next, let us generate another dataset consisting of a total of eight groups. The simulation
conditions for this dataset are as follows: (i) the number of genes is 10, 000 (i.e., Ngene =
10000), (ii) the first 34% of genes are DEGs (PDEG = 0.34), (iii) the breakdowns of the
up-regulated DEGs are respectively 10%, 30%, 5%, 10%, 5%, 21%, 9%, and 10% in Groups
1-8 (DEG.assign = c(0.1, 0.3, 0.05, 0.1, 0.05, 0.21, 0.09, 0.1)), (iv) the levels of
DE are 3.1-, 13-, 2-, 1.5-, 9-, 5.6-, 4-, and 2-fold in individual groups (DEG.foldchange =
c(3.1, 13, 2, 1.5, 9, 5.6, 4, 2)), and (v) there are a total of nine libraries (except for
G3, none of the groups have replicates) (replicates = c(1, 1, 2, 1, 1, 1, 1, 1)).

> set.seed(1000)
> library(TCC)
> tcc <- simulateReadCounts(Ngene = 10000, PDEG = 0.34,
+
+
+
> dim(tcc$count)

DEG.assign = c(0.1, 0.3, 0.05, 0.1, 0.05, 0.21, 0.09, 0.1),
DEG.foldchange = c(3.1, 13, 2, 1.5, 9, 5.6, 4, 2),
replicates = c(1, 1, 2, 1, 1, 1, 1, 1))

[1] 10000

9

> tcc$group

G1_rep1
G2_rep1
G3_rep1
G3_rep2
G4_rep1
G5_rep1
G6_rep1
G7_rep1
G8_rep1

group
1
2
3
3
4
5
6
7
8

> head(tcc$count)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

G1_rep1 G2_rep1 G3_rep1 G3_rep2 G4_rep1 G5_rep1 G6_rep1 G7_rep1 G8_rep1
9
3
12
22
8
76

16
3
20
18
2
107

63
10
17
7
0
158

16
0
27
16
1
182

42
40
20
0
1
147

16
2
72
32
0
327

14
24
25
6
6
172

62
22
20
6
0
87

64
14
10
1
4
72

36

> plotFCPseudocolor(tcc)

This kind of simulation data may be useful for evaluating methods aimed at identifying

tissue-specific (or tissue-selective) genes.

5.3 Multi-factor data

The simulateReadCounts function can also generate simulation data in multi-factor exper-
imental design. Different from above single-factor experimental design, the group argument
should be used instead of replicates for specifying sample conditions (or factors) when
generating simulation data in multi-factor design. In relation to the group specification, the
DEG.foldchange argument should also be specified as a data frame object.

We generate a dataset consisting of two factors for comparing (i) two Groups (i.e., "WT"
vs. "KO") as the first factor, at (ii) two time points (i.e., "1d" vs. "2d") as the second factor,
with all samples obtained from independent subjects. There are a total of four conditions
("WT_1d", "WT_2d", "KO_1d", and "KO_2d") each of which has two biological repli-
cates, comprising a total of eight samples. The group argument for this experimental design
can be described as follows:

> group <- data.frame(
+
+
+ )

GROUP = c("WT", "WT", "WT", "WT", "KO", "KO", "KO", "KO"),
TIME = c("1d", "1d", "2d", "2d", "1d", "1d", "2d", "2d")

37

Next, we design the number of types of DEGs and the levels of fold-change by the
DEG.foldchange argument. We here introduce three types of DEGs: (a) 2-fold up-regulation
in the first four samples (i.e., "WT"), (b) 3-fold up-regulation in the last four samples (i.e.,
"KO"), and (c) 2-fold down-regulation at "2d" in "WT" and 4-fold up-regulation at "2d"
in "KO". This implies that the first two types of DEGs are related to the first factor (i.e.,
"WT" vs. "KO") and the third type of DEG is related to the second factor (i.e., "1d" vs.
"2d").

> DEG.foldchange <- data.frame(
+
+
+
+ )

FACTOR1.1 = c(2, 2, 2, 2, 1, 1, 1, 1),
FACTOR1.2 = c(1, 1, 1, 1, 3, 3, 3, 3),
FACTOR2 = c(1, 1, 0.5, 0.5, 1, 1, 4, 4)

The other simulation conditions for this dataset are as follows: (1) the number of gene
is 1,000 (i.e., Ngene = 1000), (2) the first 20% of genes are DEGs (i.e., PDEG = 0.2), and
(3) the breakdowns of the three types of DEGs are 50%, 20%, and 30% (i.e., DEG.assign =
c(0.5, 0.2, 0.3)).

> set.seed(1000)
> tcc <- simulateReadCounts(Ngene = 10000, PDEG = 0.2,
+
+
+

DEG.assign = c(0.5, 0.2, 0.3),
DEG.foldchange = DEG.foldchange,
group = group)

Since the first six rows in the dataset corresponds to the first type of DEGs, we can see
the 2-fold up-regulation in the first four columns (i.e., WT-related samples) compared to the
last four columns (i.e., KO-related samples).

> head(tcc$count)

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

gene_1
gene_2
gene_3
gene_4
gene_5
gene_6

WT1d_rep1 WT1d_rep2 WT2d_rep1 WT2d_rep2 KO1d_rep1 KO1d_rep2 KO2d_rep1
40
2
10
16
0
69

130
19
27
10
2
115

33
23
64
36
0
110

14
1
26
47
1
197

39
13
11
8
1
58

4
2
16
15
4
30

12
14
21
12
2
174
KO2d_rep2
42
40
20
0
1
147

> tcc$group

WT1d_rep1
WT1d_rep2
WT2d_rep1
WT2d_rep2
KO1d_rep1
KO1d_rep2
KO2d_rep1
KO2d_rep2

GROUP TIME
1d
1d
2d
2d
1d
1d
2d
2d

WT
WT
WT
WT
KO
KO
KO
KO

38

> plotFCPseudocolor(tcc)

5.4 Other utilities

Recall that the simulation framework can handle different levels of DE for DEGs in individual
groups, and the shape of the distribution for these DEGs is the same as that of non-DEGs.
Let us confirm those distributions by introducing more drastic simulation conditions for
comparing two groups (G1 vs. G2) with biological replicates; i.e., (i) the number of genes is
20, 000 (i.e., Ngene = 20000), (ii) the first 30% of genes are DEGs (PDEG = 0.30), (iii) the
first 85% of the DEGs are up-regulated in G1 and the remaining 15% are up-regulated in
G2 (DEG.assign = c(0.85, 0.15)), (iv) the levels of DE are eight-fold in G1 and sixteen-
fold in G2 (DEG.foldchange = c(8, 16)), and (v) there are a total of four samples (two
biological replicates for G1 and two biological replicates for G2) (replicates = c(2, 2)).

> set.seed(1000)
> library(TCC)
> tcc <- simulateReadCounts(Ngene = 20000, PDEG = 0.30,
+
+
+
> head(tcc$count)

DEG.assign = c(0.85, 0.15),
DEG.foldchange = c(8, 16),
replicates = c(2, 2))

gene_1

G1_rep1 G1_rep2 G2_rep1 G2_rep2
140

415

238

0

39

gene_2
gene_3
gene_4
gene_5
gene_6

0
148
134
32
467

73
110
189
18
363

0
10
28
1
93

9
31
3
0
53

An M-A plot for the simulation data can be viewed as follows; the points for DEGs are

colored red and the non-DEGs are colored black:

> plot(tcc)

This plot is generated from simulation data that has been scaled in such a way that the
library sizes of each sample are the same as the mean library size of the original data. That
is,

> normalized.count <- getNormalizedData(tcc)
> colSums(normalized.count)

G1_rep1 G1_rep2 G2_rep1 G2_rep2
4155848 4155848 4155848 4155848

> colSums(tcc$count)

40

G1_rep1 G1_rep2 G2_rep1 G2_rep2
4954709 5152169 3226887 3289627

> mean(colSums(tcc$count))

[1] 4155848

The summary statistics for non-DEGs and up-regulated DEGs in G1 and G2 are upshifted
compared with the original intentions of the user (i.e., respective M values of 0, −3, and 4
for non-DEGs and up-regulated DEGs in G1 and G2). Indeed, the median values, indicated
as horizontal lines, are respectively 0.637, −2.373, and 4.454 for non-DEGs and up-regulated
DEGs in G1 and G2.

> plot(tcc, median.lines = TRUE)

These upshifted M values for non-DEGs can be modified after performing the iDEGES/edgeR

normalization, e.g., the median M value (= 0.036) for non-DEGs based on the iDEGES/edgeR-
normalized data is nearly zero.

> tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
+
> plot(tcc, median.line = TRUE)

iteration = 3, FDR = 0.1, floorPDEG = 0.05)

41

The comparison of those values obtained from different normalization methods might be

another evaluation metric.

42

6 Session info

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
[8] base

stats

graphics

grDevices utils

datasets methods

other attached packages:

[1] TCC_1.50.0
[3] edgeR_4.8.0
[5] DESeq2_1.50.0
[7] Biobase_2.70.0
[9] matrixStats_1.5.0

[11] Seqinfo_1.0.0
[13] S4Vectors_0.48.0
[15] generics_0.1.4

ROC_1.86.0
limma_3.66.0
SummarizedExperiment_1.40.0
MatrixGenerics_1.22.0
GenomicRanges_1.62.0
IRanges_2.44.0
BiocGenerics_0.56.0

loaded via a namespace (and not attached):

dplyr_1.1.4
Rcpp_1.1.0
scales_1.4.0

[1] Matrix_1.7-4
[4] compiler_4.5.1
[7] parallel_4.5.1

[10] statmod_1.5.1
[13] ggplot2_4.0.0
[16] S4Arrays_1.10.0
[19] DelayedArray_0.36.0 pillar_1.11.1
[22] rlang_1.1.6
[25] SparseArray_1.10.0
[28] locfit_1.5-9.12
[31] vctrs_0.6.5
[34] farver_2.1.2
[37] pkgconfig_2.0.3

xfun_0.53
cli_3.6.5
grid_4.5.1
evaluate_1.0.5
codetools_0.2-20
tools_4.5.1

gtable_0.3.6
tidyselect_1.2.1
dichromat_2.0-0.1
BiocParallel_1.44.0 lattice_0.22-7
XVector_0.50.0
R6_2.6.1
tibble_3.3.0
knitr_1.50
RColorBrewer_1.1-3
S7_0.2.0
magrittr_2.0.4
lifecycle_1.0.4
glue_1.8.0
abind_1.4-8

43

7 References

[1] Anders S, Huber W. 2010. Differential expression analysis for sequence count data.

Genome Biol 11: R106.

[2] Love MI, Huber W, Anders S. 2014. Moderated estimation of fold change and dispersion

for RNA-seq data with DESeq2. Genome Biol 15: R550.

[3] Di Y, Schafer DW, Cumbie JS, Chang JH. 2011. The NBP negative binomial model for
assessing differential gene expression from RNA-Seq. Stat Appl Genet Mol Biol 10.

[4] Dillies MA, Rau A, Aubert J, Hennequet-Antier C, Jeanmougin M, Servant N, Keime
C, Marot G, Castel D, Estelle J, Guernec G, Jagla B, Jouneau L, Laloë D, Le Gall C,
Schaëffer B, Le Crom S, Guedj M, Jaffrézic F; French StatOmique Consortium. 2013. A
comprehensive evaluation of normalization methods for Illumina high-throughput RNA
sequencing data analysis. Brief Bioinform 14: 671-683.

[5] Glaus P, Honkela A, and Rattray M. 2012. Identifying differentially expressed transcripts

from RNA-seq data with biological variation. Bioinformatics 28: 1721-1728.

[6] Kadota K, Nakai Y, Shimizu K. 2008. A weighted average difference method for detecting

differentially expressed genes from microarray data. Algorithms Mol Biol 3: 8.

[7] Kadota K, Nishimura SI, Bono H, Nakamura S, Hayashizaki Y, Okazaki Y, Takahashi
K. 2003. Detection of genes with tissue-specific expression patterns using Akaike’s In-
formation Criterion (AIC) procedure. Physiol Genomics 12: 251-259.

[8] Kadota K, Nishiyama T, and Shimizu K. 2012. A normalization strategy for comparing

tag count data. Algorithms Mol Biol 7: 5.

[9] Kadota K, Ye J, Nakai Y, Terada T, Shimizu K. 2006. ROKU: a novel method for

identification of tissue-specific genes. BMC Bioinformatics 7: 294.

[10] McCarthy DJ, Chen Y, Smyth GK. 2012. Differential expression analysis of multifactor
RNA-Seq experiments with respect to biological variation. Nucleic Acids Res 40: 4288-
4297.

[11] Robinson MD, McCarthy DJ, Smyth GK. 2010. edgeR: A Bioconductor package for
differential expression analysis of digital gene expression data. Bioinformatics 26: 139-
140.

[12] Robinson MD and Oshlack A. 2010. A scaling normalization method for differential

expression analysis of RNA-seq data. Genome Biol 11: R25.

[13] Robinson MD and Smyth GK. 2008. Small-sample estimation of negative binomial dis-

persion, with applications to SAGE data. Biostatistics 9: 321-332.

[14] Sun J, Nishiyama T, Shimizu K, and Kadota K. TCC: an R package for comparing tag

count data with robust normalization strategies. BMC Bioinformatics 14: 219.

[15] Ueda T. 1996. Simple method for the detection of outliers. Japanese J Appl Stat 25:

17-26.

44

