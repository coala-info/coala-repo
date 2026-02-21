OUTRIDER - OUTlier in RNA-Seq fInDER

Felix Brechtmann1, Christian Mertes1, Agne Matuseviciute1,
Vicente Yepez1,2, Julien Gagneur1,2

1 Technical University Munich, Department of Informatics, Munich, Germany
2 Quantitative Biosciences Munich, Gene Center, Ludwig-Maximilians Universität München,
Munich, Germany

February 12, 2026

Abstract

In the field of diagnostics of rare diseases, RNA-seq is emerging as an important and
complementary tool for whole exome and whole genome sequencing. OUTRIDER
is a framework that detects aberrant gene expression within a group of samples. It
uses the negative binomial distribution which is fitted for each gene over all samples.
We additionally provide an autoencoder, which automatically controls for co-variation
before fitting. After fitting, each sample can be tested for aberrantly expressed genes.
Furthermore, OUTRIDER provides functionality to easily filter unexpressed genes, to
analyse the data as well as to visualize the results.

If you use OUTRIDER in published research, please cite:

Brechtmann F*, Mertes C*, Matuseviciute A*, Yepez V, Avsec Z, Herzog M,
Bader D M, Prokisch H, Gagneur J; OUTRIDER: A statistical method
for detecting aberrantly expressed genes in RNA sequencing data;
AJHG; 2018; DOI: https://doi.org/10.1016/j.ajhg.2018.10.025

OUTRIDER - OUTlier in RNA-Seq fInDER

Contents

1

2

3

4

Introduction .

.

Prerequisites .

A quick tour .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

An OUTRIDER analysis in detail .

OutriderDataSet

Preprocessing .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Controlling for Confounders .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

4.1

4.2

4.3

4.4

4.5

4.6

4.7

5.1

5.2

5.3

5.4

6.1

6.2

Finding the right encoding dimension q .
4.4.1

.
Excluding samples from the autoencoder fit .

.

.

.

Fitting the negative binomial model

P-value calculation .

Z-score calculation .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

5

Results.

.

.

.

.

.

.

.

Results table .

Number of aberrant genes per sample .

Volcano plots .

.

Gene level plots.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

6

Additional features .

.

Using PEER to control for confounders .

Power anaylsis .

References .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

3

4

4

6

7

7

10

13
13

14

14

15

15

15

18

18

19

21

21

23

23

2

OUTRIDER - OUTlier in RNA-Seq fInDER

1

Introduction

OUTRIDER (OUTlier in RNA-seq fInDER) is a tool for finding aberrantly expressed
genes in RNA-seq samples. It does so by fitting a negative binomial model to RNA-seq
read counts, correcting for variations in sequencing depth and apparent co-variations
across samples. Read counts that significantly deviate from the distribution are de-
tected as outliers. OUTRIDER makes use of an autoencoder to control automatically
for confounders within the data. A scheme of this approach is given in Figure 1.

Figure 1: Context-dependent outlier detection. The algorithm identifies gene expression outliers
whose read counts are significantly aberrant given the co-variations typically observed across genes
in an RNA sequencing data set. This is illustrated by a read count (left panel, fifth column, second
row from the bottom) that is exceptionally high in the context of correlated samples (left six sam-
ples) but not in absolute terms for this given gene. To capture commonly seen biological and tech-
nical contexts, an autoencoder models co-variations in an unsupervised fashion and predicts read
count expectations. By comparing the earlier mentioned read count with these context-dependent
expectations, it is revealed as exceptionally high (right panel). The lower panels illustrate the dis-
tribution of read counts before and after applying the correction for the relevant gene. The red
dotted lines depict significance cutoffs.

Differential gene expression analysis from RNA-seq data is well-established. The
packages DESeq2 [1] or edgeR[2] provide effective workflows and preprocessing steps
to perform differential gene expression analysis. However, these methods aim at
detecting significant differences between groups of samples. In contrast, OUTRIDER
aims at detecting outliers within a given population. A scheme of this difference is
given in figure 2.

3

OUTRIDER - OUTlier in RNA-Seq fInDER

Figure 2: Scheme of workflow differences. Differences between differential gene expression analysis
and outlier detection.

2

Prerequisites

To get started on the preprocessing step, we recommend to read the introductions
of DESeq2 [1], edgeR[2] or the RNA-seq workflow from Bioconductor: rnaseqGene.
In brief, one usually starts with the raw FASTQ files from the RNA sequencing run.
Those are then aligned to a given reference genome. At the time of writing (October
2018), we recommend the STAR aligner[3]. After obtaining the aligned BAM files,
one can map the reads to exons or genes of a GTF annotation file using HT-seq or
by using summarizedOverlaps from GenomicAlignments. The resulting count table
can then be loaded into the OUTRIDER package as we will describe below.

3

A quick tour

Here we assume that we already have a count table and no additional preprocessing
needs to be done. We can start and obtain results with 3 commands. First, create
an OutriderDataSet from a count table or a Summarized Experiment object. Sec-
ond, run the full pipeline using the command OUTRIDER.
In the third and last step
the results table is extracted from the OutriderDataSet with the results function.
Furthermore, analysis plots that are described in section 5 can be directly created
from the OutriderDataSet object.

library(OUTRIDER)

4

OUTRIDER - OUTlier in RNA-Seq fInDER

# get data

ctsFile <- system.file('extdata', 'KremerNBaderSmall.tsv',

package='OUTRIDER')

ctsTable <- read.table(ctsFile, check.names=FALSE)

ods <- OutriderDataSet(countData=ctsTable)

# filter out non expressed genes

ods <- filterExpression(ods, minCounts=TRUE, filterGenes=TRUE)

# run full OUTRIDER pipeline (control, fit model, calculate P-values)

ods <- OUTRIDER(ods)

## Optimal encoding dimension: 16

## [1] "Thu Feb 12 19:42:29 2026: Initial PCA loss: 4.76571576945417"

## [1] "Thu Feb 12 19:42:35 2026: Iteration: 1 loss: 4.30331847282119"

## [1] "Thu Feb 12 19:42:39 2026: Iteration: 2 loss: 4.28378422424423"

## [1] "Thu Feb 12 19:42:46 2026: Iteration: 3 loss: 4.27208177244429"

## [1] "Thu Feb 12 19:42:51 2026: Iteration: 4 loss: 4.26761320026353"

## [1] "Thu Feb 12 19:42:55 2026: Iteration: 5 loss: 4.26560930986516"

## [1] "Thu Feb 12 19:42:56 2026: Iteration: 6 loss: 4.2645160768791"

## [1] "Thu Feb 12 19:42:58 2026: Iteration: 7 loss: 4.2626136239941"

## [1] "Thu Feb 12 19:42:59 2026: Iteration: 8 loss: 4.26253826837135"

## [1] "Thu Feb 12 19:43:01 2026: Iteration: 9 loss: 4.26227148748526"

## [1] "Thu Feb 12 19:43:03 2026: Iteration: 10 loss: 4.26086733859095"

## [1] "Thu Feb 12 19:43:04 2026: Iteration: 11 loss: 4.26086335505808"

## Time difference of 33.80553 secs

## [1] "Thu Feb 12 19:43:04 2026: 11 Final nb-AE loss: 4.26086335505808"

# results (only significant)

res <- results(ods)

head(res)

##

##

geneID sampleID

<char>

<char>

pValue

<num>

padjust zScore

l2fc rawcounts

<num>

<num> <num>

<int>

## 1: ATAD3C MUC1360 2.201878e-13 1.224834e-09

5.85

2.23

## 2: MSTO1 MUC1367 2.496968e-09 1.388983e-05

-6.32 -0.86

## 3: NBPF15 MUC1351 5.251500e-09 2.921239e-05

5.44

0.77

## 4: DCAF6 MUC1374 7.585427e-08 4.219528e-04

-5.70 -0.67

## 5: NBPF16 MUC1351 5.013004e-07 1.394286e-03

4.69

0.68

## 6: HDAC1 MUC1403 8.249594e-07 4.588982e-03

-5.25 -0.96

948

761

7591

2348

4014

982

##

##

## 1:

## 2:

## 3:

## 4:

meanRawcounts normcounts meanCorrected

theta aberrant AberrantBySample

<num>

82.29

1327.87

4224.88

4869.53

<num>

320.02

704.26

7020.33

2976.48

<num>

<num>

<lgcl>

<num>

67.90

12.72

1276.47 137.97

4123.33 100.89

4726.34 166.87

TRUE

TRUE

TRUE

TRUE

1

1

2

1

5

OUTRIDER - OUTlier in RNA-Seq fInDER

## 5:

## 6:

##

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

2459.90

3853.31

2403.46

98.31

3805.56

1882.01
AberrantByGene padj_rank
<num>
<num>

3660.97

72.27

TRUE

TRUE

2

2

1

1

1

1

1

2

1

1

1

1

2

1

# example of a Q-Q plot for the most significant outlier

plotQQ(ods, res[1, geneID])

4

An OUTRIDER analysis in detail

Apart from running the full pipeline using the single wrapper function OUTRIDER, the
analysis can also be run step by step. The wrapper function does not include any
preprocessing functions. Discarding non expressed genes or samples failing quality
measurements should be done manually before running the OUTRIDER function or
starting the analysis pipeline.

In this section we will explain the analysis functions step by step.

For this tutorial we will use the rare disease data set from Kremer et al.[4]. For
testing purposes, this package contains a small subset of it.

6

OUTRIDER - OUTlier in RNA-Seq fInDER

4.1

OutriderDataSet
To use OUTRIDER create an OutriderDataSet, which derives from a RangedSum-
marizedExperiment object. The OutriderDataSetcan be created by supplying a count
matrix and optional sample annotation matrices. Alternatively, an existing Summa-
rized experiment object from other Biocnductor backages can be used.

# small testing data set

odsSmall <- makeExampleOutriderDataSet(dataset="Kremer")

# full data set from Kremer et al.

baseURL <- paste0("https://static-content.springer.com/esm/",

"art%3A10.1038%2Fncomms15824/MediaObjects/")

count_URL <- paste0(baseURL, "41467_2017_BFncomms15824_MOESM390_ESM.txt")
anno_URL <- paste0(baseURL, "41467_2017_BFncomms15824_MOESM397_ESM.txt")

ctsTable <- read.table(count_URL, sep="\t")
annoTable <- read.table(anno_URL, sep="\t", header=TRUE)
annoTable$sampleID <- annoTable$RNA_ID

# create OutriderDataSet object

ods <- OutriderDataSet(countData=ctsTable, colData=annoTable)

4.2

Preprocessing
It is recommended to preprocess the data before fitting. Our model requires that for
every gene at least one sample has a non-zero count and that we observe at least
one read for every 100 samples. Therefore, all genes that are not expressed must be
discarded.

We provide the function filterExpression to remove genes that have low FPKM
(Fragments Per Kilobase of transcript per Million mapped reads) expression values.
The needed annotation to estimate FPKM values from the counts should be the
same as for the counting. Here, we normalize by the total exon length of a gene. To
do so the joint lenght of all exons needs to be provided. When providing a gtf, gff
or TxDb object to the filterExpression, we extract this information automatically.
But therfore the geneID’s of the count table and the gtf need to match.

By default the cutoff is set to an FPKM value of one and only the filtered Outrid-
erDataSet object is returned.
If required, the FPKM values can be stored in the
OutriderDataSet object and the full object can be returned to visualize the distribu-
tion of reads before and after filtering.

# get annotation

library(TxDb.Hsapiens.UCSC.hg19.knownGene)

library(org.Hs.eg.db)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

7

OUTRIDER - OUTlier in RNA-Seq fInDER

map <- select(org.Hs.eg.db, keys=keys(txdb, keytype = "GENEID"),

keytype="ENTREZID", columns=c("SYMBOL"))

However, the TxDb.Hsapiens.UCSC.hg19.knownGene contains only well annotated
genes. This annotation will miss a lot of genes captured by RNA-seq. To include all
predicted annotations as well as non-coding RNAs please download the txdb object
from our homepage1 or create it yourself from the UCSC website2,3.

try({

library(RMariaDB)

library(AnnotationDbi)

con <- dbConnect(MariaDB(), host='genome-mysql.cse.ucsc.edu',

dbname="hg19", user='genome')

map <- dbGetQuery(con, 'select kgId AS TXNAME, geneSymbol from kgXref')

txdbUrl <- paste0("https://cmm.in.tum.de/public/",

"paper/mitoMultiOmics/ucsc.knownGenes.db")

download.file(txdbUrl, "ucsc.knownGenes.db")

txdb <- loadDb("ucsc.knownGenes.db")

})

# calculate FPKM values and label not expressed genes

ods <- filterExpression(ods, txdb, mapping=map,

filterGenes=FALSE, savefpkm=TRUE)

# display the FPKM distribution of counts.

plotFPKM(ods)

1https://cmm.in.tum.de/public/paper/mitoMultiOmics/ucsc.knownGenes.db
2https://genome.ucsc.edu/cgi-bin/hgTables
3http://genomewiki.ucsc.edu/index.php/Genes_in_gtf_or_gff_format

8

OUTRIDER - OUTlier in RNA-Seq fInDER

# display gene filter summary statistics

plotExpressedGenes(ods)

# do the actual subsetting based on the filtering labels

ods <- ods[mcols(ods)$passedFilter,]

9

OUTRIDER - OUTlier in RNA-Seq fInDER

4.3

Controlling for Confounders
The next step in any analysis workflow is to visualize the correlations between samples.
In most RNA-seq experiments correlations between the samples can be observed.
These are often due to technical confounders (e.g. sequencing batch) or biological
confounders (e.g. sex, age). These confounders can adversely affect the detection of
aberrant features. Therefore, we provide options to control for them.

# Heatmap of the sample correlation

# it can also annotate the clusters resulting from the dendrogram
ods <- plotCountCorHeatmap(ods, colGroups=c("SEX", "RNA_HOX_GROUP"),

normalized=FALSE, nRowCluster=4)

# Heatmap of the gene/sample expression
ods <- plotCountGeneSampleHeatmap(ods, colGroups=c("SEX", "RNA_HOX_GROUP"),

normalized=FALSE, nRowCluster=4)

10

OUTRIDER - OUTlier in RNA-Seq fInDER

We have different ways to control for confounders present in the data. The first and
standard way is to calculate the sizeFactors as done in DESeq2 [1].

Additionally, the controlForConfounders function calls a denoising autoencoder that
controls for confounders by exploiting correlations in the data to reconstruct corrupted
read-counts. The encoding dimension q can be set manually or can be calculated with
the estimateBestQ function using the Optimal Hard Thresholding (OHT) procedure
established by Gavish and Donoho[5]. Alternatively, the optimal value of q can
be determined by testing different values for q and calculating the one that recalls
the highest number of injected outliers. The deterministic approach using OHT
is much faster than the iterative procedure. After controlling for confounders, the
heatmap should be plotted again. If it worked, no batches should be present and the
correlations between samples should be reduced and close to zero.

# automatically control for confounders

# we use only 3 iterations to make the vignette faster. The default is 15.

ods <- estimateSizeFactors(ods)

ods <- controlForConfounders(ods, q=21, iterations=3)

## [1] "Thu Feb 12 19:43:56 2026: Initial PCA loss: 5.98882764830451"

11

OUTRIDER - OUTlier in RNA-Seq fInDER

## [1] "Thu Feb 12 19:45:02 2026: Iteration: 1 loss: 5.3992110393167"

## [1] "Thu Feb 12 19:45:35 2026: Iteration: 2 loss: 5.38494537555225"

## [1] "Thu Feb 12 19:45:57 2026: Iteration: 3 loss: 5.37874198316502"

## Time difference of 1.767441 mins

## [1] "Thu Feb 12 19:45:57 2026: 3 Final nb-AE loss: 5.37874198316502"

# Heatmap of the sample correlation after controlling

ods <- plotCountCorHeatmap(ods, normalized=TRUE,

colGroups=c("SEX", "RNA_HOX_GROUP"))

Alternatively, other methods can be used to control for confounders. In addition to
the autoencoder, we implemented a PCA based approach. The PCA implementation
can be utilized by setting implementation="pca". Also PEER can be used together
with the OUTRIDER framework. A detailed description on how to do this can be
found in section 6.1. Furthermore, any other method can be used by providing the
normalizationFactor matrix. This matrix must be computed beforehand using the
Its purpose is to normalize for technical effects or control for
appropriate method.
additional expression patterns.

12

OUTRIDER - OUTlier in RNA-Seq fInDER

4.4

Finding the right encoding dimension q
In the previous section, we fixed the encoding dimension q = 21. However, having
the right encoding dimension is crucial in finding outliers in the data. On the one
hand, if q is too big the autoencoder will learn the identity matrix and will overfit the
data. On the other hand, if q is too small the autoencoder cannot learn the necessary
covariates existing in the data. Therefore, it is recommended for any new dataset
to estimate the optimal encoding dimension to gain the best performance. With the
function estimateBestQ one can find the optimal encoding dimension using Optimal
Hard Thresholding[5]. Alternatively, the function can perform a hyperparameter
optimization based on a grid-search. To this end, we artificially introduce corrupted
counts randomly into the dataset and monitor the performance calling those corrupted
counts. The optimal dimension q is then selected as the dimension maximizing the
area under the precision-recall curve for identifying corrupted counts. Since this
method runs a full OUTRIDER fit for a variety of encoding dimensions, it is quite
CPU-intensive. Thus, it is recommended to use the faster default method relying on
OHT.

# Optimal Hard Thresholding (default)

ods <- estimateBestQ(ods)

# Hyperparameter Optimization

ods <- estimateBestQ(ods, useOHT=FALSE)

# visualize the estimation of the optimal encoding dimension

plotEncDimSearch(ods)

4.4.1 Excluding samples from the autoencoder fit

Since OUTRIDER expects that each sample within the population is independent of
all others, replicates could mask effects specific to this sample. This is also true if
trios are present in the data, where the parents can be seen as biological replicates.
Here, we recommend to exclude the sample of interest or the replicates from the
fitting. Later on, for all samples P-values are calculated.

In this rare disease data set we know that two samples (MUC1344 and MUC1365)
have the same defect. To exclude one or both of them, we can use the sampleExclu
sionMask function.

# set exclusion mask

sampleExclusionMask(ods) <- FALSE

sampleExclusionMask(ods[,"MUC1365"]) <- TRUE

# check which samples are excluded from the autoencoder fit

sampleExclusionMask(ods)

##

35834

57415

61695

61982

65937

66623

69245

69248

69456

13

OUTRIDER - OUTlier in RNA-Seq fInDER

##

##

##

##

##

##

##

FALSE

70038

FALSE

76623

FALSE

76632

FALSE

FALSE

70041

FALSE

76624

FALSE

76633

FALSE

FALSE

72748

FALSE

76625

FALSE

76635

FALSE

FALSE

74123

FALSE

76626

FALSE

76636

FALSE

FALSE

74172

FALSE

76627

FALSE

76637

FALSE

FALSE

76619

FALSE

76628

FALSE

FALSE

76620

FALSE

76629

FALSE

FALSE

76621

FALSE

76630

FALSE

FALSE

76622

FALSE

76631

FALSE

76638 MUC0486 MUC0487 MUC0488

FALSE

FALSE

FALSE

FALSE

## MUC0489 MUC0490 MUC0491 MUC1342 MUC1343 MUC1344 MUC1345 MUC1346 MUC1347

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1348 MUC1349 MUC1350 MUC1351 MUC1352 MUC1354 MUC1355 MUC1357 MUC1358

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1359 MUC1360 MUC1361 MUC1362 MUC1363 MUC1364 MUC1365 MUC1367 MUC1368

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

TRUE

FALSE

FALSE

## MUC1369 MUC1370 MUC1371 MUC1372 MUC1373 MUC1374 MUC1375 MUC1376 MUC1377

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1378 MUC1379 MUC1380 MUC1381 MUC1382 MUC1383 MUC1384 MUC1390 MUC1391

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1392 MUC1393 MUC1394 MUC1395 MUC1396 MUC1397 MUC1398 MUC1400 MUC1401

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1402 MUC1403 MUC1404 MUC1405 MUC1407 MUC1408 MUC1409 MUC1410 MUC1411

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1412 MUC1413 MUC1414 MUC1415 MUC1416 MUC1417 MUC1418 MUC1419 MUC1420

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1421 MUC1422 MUC1423 MUC1424 MUC1425 MUC1426 MUC1427 MUC1428 MUC1429

##

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

## MUC1436 MUC1437

##

FALSE

FALSE

4.5

Fitting the negative binomial model
The fit of the negative binomial model is done during the autoencoder fitting. This
step is only needed if alternative methods to control the data are used. To fit the
dispersion and the mean, the fit function is applied to the OutriderDataSet.

# fit the model when alternative methods where used in the control step

ods <- fit(ods)

hist(theta(ods))

4.6

P-value calculation
After determining the fit parameters, two-sided P-values are computed using the
following equation:

14

OUTRIDER - OUTlier in RNA-Seq fInDER

pij = 2 · min






1
2

,

kij
(cid:88)

0

N B(µij, θi), 1 −

kij−1
(cid:88)

0

N B(µij, θi)






,

1

where the 1
term handles the case of both terms exceeding 0.5, which can happen
2
due to the discrete nature of counts. Here µij are computed as the product of the
fitted correction values from the autoencoder and the fitted mean adjustements. If
required a one-sided test can be performed using the argument alternative and
specifying ’less’ or ’greater’ depending on the research question. Multiple testing
correction is done across all genes in a per-sample fashion using Benjamini-Yekutieli’s
false discovery rate method[6]. Alternatively, all adjustment methods supported by
p.adjust can be used via the method argument.

# compute P-values (nominal and adjusted)

ods <- computePvalues(ods, alternative="two.sided", method="BY")

4.7

Z-score calculation
The Z-scores on the log transformed counts can be used for visualization, filtering,
and ranking of samples. By running the computeZscores function, the Z-scores are
computed and stored in the OutriderDataSet object. The Z-scores are calculated
using:

zij =

lij = log2 (

lij − µl
j
σl
j
kij + 1
cij + 1

2

),

where µl
j
transformed count after correction for confounders.

is the mean and σl
j

the standard deviation of gene j and lij is the log

# compute the Z-scores

ods <- computeZscores(ods)

5

Results

The OUTRIDER package offers multiple ways to display the results.
It creates a
results table containing all the values computed during the analysis. Furthermore, it
offers various plot functions that guide the user through the analysis.

5.1

Results table
The results function gathers all the previously computed values and combines them
into one table.

15

OUTRIDER - OUTlier in RNA-Seq fInDER

# get results (default only significant, padj < 0.05)

res <- results(ods)

head(res)

##

##

geneID sampleID

<char>

<char>

pValue

<num>

padjust zScore

l2fc rawcounts

<num>

<num> <num>

<int>

## 1: NUDT12

65937 2.046091e-22 2.332782e-17 -10.33 -7.94

## 2:

STAG2

MUC0490 3.815899e-21 4.350571e-16

-9.73 -1.87

## 3: TALDO1 MUC1427 6.869831e-18 7.832410e-13

-9.43 -3.28

## 4: MCOLN1 MUC1361 1.146348e-15 1.306970e-10

-8.79 -2.41

## 5: RETSAT MUC1374 1.311939e-15 1.495763e-10

-8.93 -3.63

0

622

482

150

76

## 6: CSNK2A1 MUC1358 3.026921e-15 1.725522e-10

-8.11 -0.67

2060

meanRawcounts normcounts meanCorrected

theta aberrant AberrantBySample

1108.33

4066.07

83.34

<num>

<num>

<lgcl>

<num>

453.36

19.42

4556.74

27.86

841.08

41.85

1869.73

21.86

3208.52 383.06

TRUE

TRUE

TRUE

TRUE

TRUE

TRUE

2

6

1

1

2

4

##

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

##

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

<num>

470.22

4184.49

4699.52

912.70

1959.22

<num>

0.00

468.66

157.87

149.65

3277.50

2016.55
AberrantByGene padj_rank
<num>
<num>

1

1

1

1

1

1

1.0

1.0

1.0

1.0

1.0

1.5

dim(res)

## [1] 243

15

# setting a different significance level and filtering by Z-scores

res <- results(ods, padjCutoff=0.1, zScoreCutoff=2)

head(res)

##

##

geneID sampleID

<char>

<char>

pValue

<num>

padjust zScore

l2fc rawcounts

<num>

<num> <num>

<int>

## 1: NUDT12

65937 2.046091e-22 2.332782e-17 -10.33 -7.94

## 2:

STAG2

MUC0490 3.815899e-21 4.350571e-16

-9.73 -1.87

## 3: TALDO1 MUC1427 6.869831e-18 7.832410e-13

-9.43 -3.28

## 4: MCOLN1 MUC1361 1.146348e-15 1.306970e-10

-8.79 -2.41

## 5: RETSAT MUC1374 1.311939e-15 1.495763e-10

-8.93 -3.63

0

622

482

150

76

## 6: CSNK2A1 MUC1358 3.026921e-15 1.725522e-10

-8.11 -0.67

2060

##

##

meanRawcounts normcounts meanCorrected

theta aberrant AberrantBySample

<num>

<num>

<num>

<num>

<lgcl>

<num>

16

453.36

19.42

4066.07

83.34

4556.74

27.86

841.08

41.85

1869.73

21.86

3208.52 383.06

TRUE

TRUE

TRUE

TRUE

TRUE

TRUE

2

6

1

1

2

4

OUTRIDER - OUTlier in RNA-Seq fInDER

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

##

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

470.22

4184.49

4699.52

912.70

1959.22

0.00

1108.33

468.66

157.87

149.65

3277.50

2016.55
AberrantByGene padj_rank
<num>
<num>

1

1

1

1

1

1

1.0

1.0

1.0

1.0

1.0

1.5

dim(res)

## [1] 308

15

In details the table contains:

• sampleID / geneID: The gene or sample ID as provided by the user, e.g. row-

Data(ods) and colData(ods) respectively.

• pValue / padjust: The nominal P-value and the FDR corrected P-value indi-

cating the outlier status. Find more details at computePvalues.

• zScore / l2fc: The z score and log2

cores.

fold change as computed by computeZs-

• rawcounts: The observed read counts.

• normcounts: The expected count given the fitted autoencoder model for the

given gene-sample combination.

• meanRawcounts / meanCorrected: For this gene, the mean of the observed or

expected counts, respectively, given the fitted autoencoder model.

• theta: The dispersion parameter of the NB distribution for the given gene.

• aberrant: The outlier status of this event: TRUE or FALSE.

• AberrantBySample / AberrantByGene: Number of outliers for the given sample

or gene, respectively.

• padj rank: Rank of this outlier event within the given sample.

• FDR set: The subset-name used for the P-value computation.

17

OUTRIDER - OUTlier in RNA-Seq fInDER

5.2

Number of aberrant genes per sample
One quantity of interest is the number of aberrantly expressed genes per sam-
ple. This can be displayed using the plotting function plotAberrantPerSample.
Alternatively, the function aberrant can be used to identify aberrant events,
which can be summed by sample or gene using the paramter by. These numbers
depend on the cutoffs, which can be specified in both functions (padjCutoff
and zScoreCutoff).

# number of aberrant genes per sample

tail(sort(aberrant(ods, by="sample")))

## MUC1367 MUC1381 MUC1368 MUC1363 MUC1364

76633

##

6

6

7

8

10

28

tail(sort(aberrant(ods, by="gene", zScoreCutoff=1)))

##

##

PBK

2

ZFAT

2

DNAJC3 SLMO2-ATP5E

2

2

NXT2

2

PRKY

2

# plot the aberrant events per sample

plotAberrantPerSample(ods, padjCutoff=0.05)

5.3

Volcano plots
To view the distribution of P-values on a sample level, volcano plots can be
displayed. Most of the plots make use of the plotly framework to create in-
teractive plots. To only use basic R functionality from graphics the basePlot
argument can be set to TRUE.

18

OUTRIDER - OUTlier in RNA-Seq fInDER

# MUC1344 is a diagnosed sample from Kremer et al.

plotVolcano(ods, "MUC1344", basePlot=TRUE)

5.4

Gene level plots
Additionally, we include two plots at the gene level. plotExpressionRank plots
the counts in ascending order. By default, the controlled counts are plotted.
To plot raw counts, the argument normalized can be set to FALSE.

When using the plotly framework for plotting, all computed values are displayed
for each data point. The user can access this information by hovering over each
data point with the mouse.

# expression rank of a gene with outlier events

plotExpressionRank(ods, "TIMMDC1", basePlot=TRUE)

19

OUTRIDER - OUTlier in RNA-Seq fInDER

The quantile-quantile plot can be used to see whether the fit converged well. In
presence of an outlier, it can happen that most of the points end up below the
confidence band. This is fine and indicates that we have conservative P-values
for the other points. Here is an example with two outliers:

## QQ-plot for a given gene

plotQQ(ods, "TIMMDC1")

Since we do test how fare the observed count is away from the exprected ex-
pression level, it is also helpful to visualize the predictions against the observed
counts.

20

OUTRIDER - OUTlier in RNA-Seq fInDER

## Observed versus expected gene expression

plotExpectedVsObservedCounts(ods, "TIMMDC1", basePlot=TRUE)

6

6.1

Additional features

Using PEER to control for confounders
PEER[7] is a well known tool to control for unknown effects in RNA-seq data.
PEER is only available through the peer GitHub repository. The R source
code can be downloaded form here: https://github.com/downloads/PMBio/
peer/R_peer_source_1.3.tgz. The installation of the package has to be done
manually by the user. After the installation one can use the following function
to control for confounders with PEER.

#'

#' PEER implementation

#'

peer <- function(ods, maxFactors=NA, maxItr=1000){

# check for PEER

if(!require(peer)){

stop("Please install the 'peer' package from GitHub to use this ",

"functionality.")

}

# default and recommendation by PEER: min(0.25*n, 100)
if(is.na(maxFactors)){

21

OUTRIDER - OUTlier in RNA-Seq fInDER

maxFactors <- min(as.integer(0.25* ncol(ods)), 100)

}

# log counts

logCts <- log2(t(t(counts(ods)+1)/sizeFactors(ods)))

# prepare PEER model

model <- PEER()
PEER_setNmax_iterations(model, maxItr)
PEER_setNk(model, maxFactors)
PEER_setPhenoMean(model, logCts)
PEER_setAdd_mean(model, TRUE)

# run fullpeer pipeline
PEER_update(model)

# extract PEER data
peerResiduals <- PEER_getResiduals(model)
peerMean <- t(t(2^(logCts - peerResiduals)) * sizeFactors(ods))

# save model in object

normalizationFactors(ods) <- pmax(peerMean, 1E-8)
metadata(ods)[["PEER_model"]] <- list(

= PEER_getAlpha(model),

alpha
residuals = PEER_getResiduals(model),
= PEER_getW(model))
W

return(ods)

}

With the function above we can run the full OUTRIDER pipeline as follows:

# Control for confounders with PEER

ods <- estimateSizeFactors(ods)

ods <- peer(ods)

ods <- fit(ods)

ods <- computeZscores(ods, peerResiduals=TRUE)

ods <- computePvalues(ods)

# Heatmap of the sample correlation after controlling

ods <- plotCountCorHeatmap(ods, normalized=TRUE)

22

OUTRIDER - OUTlier in RNA-Seq fInDER

6.2

Power anaylsis
We provide the plotPowerAnalysis function to show, what kind of changes
can be significant depending on the mean count.

## P-values versus Mean Count

plotPowerAnalysis(ods)

Here, we see that it is only for sufficiently high expressed genes possible, to
obtain significant P-values, especially for the downregulation cases.

References

[1] Michael

I Love, Wolfgang Huber, and Simon Anders. Moderated
fold change and dispersion for RNA-seq data with
URL: http://

estimation of
DESeq2.
genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0550-8,
doi:10.1186/s13059-014-0550-8.

Genome Biology, 15(12):550, dec 2014.

[2] Mark D Robinson, Davis J. McCarthy, and Gordon K Smyth. edgeR: a
Bioconductor package for differential expression analysis of digital gene
expression data. Bioinformatics (Oxford, England), 26(1):139–40,
jan
2010. URL: https://doi.org/10.1093/bioinformatics/btp616, doi:10.1093/
bioinformatics/btp616.

23

OUTRIDER - OUTlier in RNA-Seq fInDER

[3] Alexander Dobin, Carrie A. Davis, Felix Schlesinger, Jorg Drenkow, Chris
Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R.
Gingeras. STAR: Ultrafast universal RNA-seq aligner. Bioinformatics,
29(1):15–21, 2013. URL: https://doi.org/10.1093/bioinformatics/bts635,
doi:10.1093/bioinformatics/bts635.

[4] Laura S Kremer, Daniel M Bader, Christian Mertes, Robert Kopajtich,
Garwin Pichler, Arcangela Iuso, Tobias B Haack, Elisabeth Graf, Thomas
Schwarzmayr, Caterina Terrile, Eliška Koňaříková, Birgit Repp, Gabi Kas-
tenmüller, Jerzy Adamski, Peter Lichtner, Christoph Leonhardt, Benoit
Funalot, Alice Donati, Valeria Tiranti, Anne Lombes, Claude Jardel, Di-
eter Gläser, Robert W Taylor, Daniele Ghezzi, Johannes A Mayr, Agnes
Rötig, Peter Freisinger, Felix Distelmaier, Tim M Strom, Thomas Meitinger,
Julien Gagneur, and Holger Prokisch. Genetic diagnosis of Mendelian
jun
disorders via RNA sequencing. Nature Communications, 8:15824,
2017. URL: https://www.nature.com/articles/ncomms15824.pdf, doi:
10.1038/ncomms15824.

[5] Matan Gavish and David L. Donoho. The Optimal Hard Threshold for

Singular Values is 4/sqrt(3). URL: http://arxiv.org/pdf/1305.5870.

[6] Yoav Benjamini and Daniel Yekutieli. The control of the false dis-
covery rate in multiple testing under dependency. Annals of Statis-
tics, 29(4):1165–1188, 2001. URL: https://projecteuclid.org/euclid.aos/
1013699998, arXiv:0801.1095, doi:10.1214/aos/1013699998.

[7] Oliver Stegle, Leopold Parts, Matias Piipari, John Winn, and Richard
Durbin. Using probabilistic estimation of expression residuals (PEER) to
obtain increased power and interpretability of gene expression analyses. Na-
ture Protocols, 7(3):500–507, 2012. doi:10.1038/nprot.2011.457.

Session info

Here is the output of sessionInfo() on the system on which this document
was compiled:

## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB

LC_NUMERIC=C
LC_COLLATE=C

24

OUTRIDER - OUTlier in RNA-Seq fInDER

## [5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
##
[9] LC_ADDRESS=C

LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

[2] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1

## other attached packages:
## [1] org.Hs.eg.db_3.22.0
##
## [3] beeswarm_0.4.0
[4] OUTRIDER_1.28.1
##
[5] SummarizedExperiment_1.40.0

##
## [6] MatrixGenerics_1.22.0
[7] matrixStats_1.5.0
##
## [8] GenomicFeatures_1.62.0
[9] AnnotationDbi_1.72.0
##
## [10] Biobase_2.70.0
## [11] GenomicRanges_1.62.1
## [12] Seqinfo_1.0.0
## [13] IRanges_2.44.0
## [14] S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0
## [16] generics_0.1.4
## [17] BiocParallel_1.44.0
## [18] knitr_1.51
##

## loaded via a namespace (and not attached):

##

##

##

##

##

##

[1] RColorBrewer_1.1-3
[3] magrittr_2.0.4
[5] farver_2.1.2
[7] BiocIO_1.20.0
[9] memoise_2.0.1
[11] RCurl_1.98-1.17
[13] tinytex_0.58
##
## [15] htmltools_0.5.9
## [17] progress_1.2.3
##

[19] SparseArray_1.10.8
[21] htmlwidgets_1.6.4
[23] httr2_1.2.2

##

##

jsonlite_2.0.0
magick_2.9.0
rmarkdown_2.30
vctrs_0.7.1
Rsamtools_2.26.0
PRROC_1.4
webshot_0.5.5
S4Arrays_1.10.1
curl_7.0.0
pracma_2.4.6
plyr_1.8.9
plotly_4.12.0

25

OUTRIDER - OUTlier in RNA-Seq fInDER

## [25] cachem_1.1.0
##

[27] lifecycle_1.0.5
[29] pkgconfig_2.0.3

##
## [31] R6_2.6.1
## [33] digest_0.6.39
[35] DESeq2_1.50.2
##
## [37] seriation_1.5.8
## [39] filelock_1.0.3
[41] httr_1.4.7
##
## [43] abind_1.4-8
## [45] withr_3.0.2
[47] S7_0.2.1
##
[49] viridis_0.6.5
[51] heatmaply_1.6.0

##
## [53] highr_0.11
## [55] rappdirs_0.3.4
[57] rjson_0.2.23
##
[59] otel_0.2.0
[61] restfulr_0.0.16
[63] grid_4.5.2
[65] reshape2_1.4.5

##

##

##

##

##
## [67] ca_0.71.1
##

[69] data.table_1.18.2.1
[71] XVector_0.50.0
##
## [73] foreach_1.5.2
## [75] stringr_1.6.0
## [77] dplyr_1.2.0
## [79] BiocFileCache_3.0.0
## [81] rtracklayer_1.70.1
## [83] tidyselect_1.2.1
## [85] locfit_1.5-9.12
## [87] gridExtra_2.3
[89] pheatmap_1.0.13
##
## [91] UCSC.utils_1.6.1
## [93] yaml_2.3.12
## [95] codetools_0.2-20
## [97] tibble_3.3.1
[99] cli_3.6.5
##
## [101] Rcpp_1.1.1
## [103] dbplyr_2.5.1
## [105] XML_3.99-0.22
## [107] ggplot2_4.0.2
## [109] blob_1.3.0
## [111] bitops_1.0-9
## [113] viridisLite_0.4.3

GenomicAlignments_1.46.0
iterators_1.0.14
Matrix_1.7-4
fastmap_1.2.0
pcaMethods_2.2.0
RSQLite_2.4.6
labeling_0.4.3
mgcv_1.9-4
RMTstat_0.3.1
compiler_4.5.2
bit64_4.6.0-1
backports_1.5.0
DBI_1.2.3
dendextend_1.19.1
biomaRt_2.66.1
DelayedArray_0.36.0
tools_4.5.2
glue_1.8.0
nlme_3.1-168
checkmate_2.3.4
gtable_0.3.6
tidyr_1.3.2
hms_1.1.4
ggrepel_0.9.6
pillar_1.11.1
splines_4.5.2
BBmisc_1.13.1
lattice_0.22-9
bit_4.6.0
registry_0.5-1
Biostrings_2.78.0
xfun_0.56
stringi_1.8.7
lazyeval_0.2.2
evaluate_1.0.5
cigarillo_1.0.0
BiocManager_1.30.27
dichromat_2.0-0.1
GenomeInfoDb_1.46.2
png_0.1-8
parallel_4.5.2
assertthat_0.2.1
prettyunits_1.2.0
txdbmaker_1.6.2
scales_1.4.0

26

OUTRIDER - OUTlier in RNA-Seq fInDER

## [115] purrr_1.2.1
## [117] BiocStyle_2.38.0
## [119] KEGGREST_1.50.0

crayon_1.5.3
rlang_1.1.7
TSP_1.2.6

27

