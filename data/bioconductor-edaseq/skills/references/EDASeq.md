# EDASeq: Exploratory Data Analysis and Normalization for RNA-Seq

Davide Risso

#### Last modified: May 17, 2018; Compiled: October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Reading in unaligned and aligned read data](#secRead)
  + [2.1 Unaligned reads](#unaligned-reads)
  + [2.2 Aligned reads](#aligned-reads)
* [3 Read-level EDA](#read-level-eda)
  + [3.1 Numbers of unaligned and aligned reads](#numbers-of-unaligned-and-aligned-reads)
  + [3.2 Read quality scores](#read-quality-scores)
  + [3.3 Individual lane summaries](#individual-lane-summaries)
  + [3.4 Read nucleotide distributions](#read-nucleotide-distributions)
* [4 Gene-level EDA](#gene-level-eda)
  + [4.1 Classes and methods for gene-level counts](#classes-and-methods-for-gene-level-counts)
  + [4.2 Between-lane distribution of gene-level counts](#between-lane-distribution-of-gene-level-counts)
  + [4.3 Over-dispersion](#over-dispersion)
  + [4.4 Gene-specific effects on read counts](#gene-specific-effects-on-read-counts)
* [5 Normalization](#normalization)
  + [5.1 Offset](#offset)
* [6 Differential expression analysis](#differential-expression-analysis)
  + [6.1 edgeR](#edger)
  + [6.2 DESeq2](#deseq2)
* [7 Definitions and conventions](#definitions-and-conventions)
  + [7.1 Rounding](#rounding)
  + [7.2 Zero counts](#zero-counts)
  + [7.3 Offset](#offset-1)
* [8 Retrieving gene length and GC-content](#retrieving-gene-length-and-gc-content)
* [9 SessionInfo](#sessioninfo)
* [References](#references)

# 1 Introduction

In this document, we show how to conduct Exploratory Data Analysis
(EDA) and normalization for a typical RNA-Seq experiment using the
package `EDASeq`.

One can think of EDA for RNA-Seq as a two-step process: “read-level”
EDA helps in discovering lanes with low sequencing depths, quality
issues, and unusual nucleotide frequencies, while ``gene-level’’ EDA
can capture mislabeled lanes, issues with distributional assumptions
(e.g., over-dispersion), and GC-content bias.

The package also implements both “within-lane” and “between-lane”
normalization procedures, to account, respectively, for within-lane
gene-specific (and possibly lane-specific) effects on read counts
(e.g., related to gene length or GC-content) and for between-lane
distributional differences in read counts (e.g., sequencing depths).

To illustrate the functionality of the `EDASeq` package, we
make use of the *Saccharomyces cerevisiae* RNA-Seq data from
(Lee et al. [2008](#ref-lee2008novel)). Briefly, a wild-type strain and three mutant
strains were sequenced using the Solexa 1G Genome Analyzer. For each
strain, there are four technical replicate lanes from the same library
preparation. The reads were aligned using `Bowtie`
(Langmead et al. [2009](#ref-langmead2009ultrafast)), with unique mapping and allowing up to
two mismatches.

The `leeBamViews` package provides a subset of the aligned
reads in BAM format. In particular, only the reads mapped between
bases 800,000 and 900,000 of chromosome XIII are considered. We use
these reads to illustrate read-level EDA.

The `yeastRNASeq` package contains gene-level read counts for
four lanes: two replicates of the wild-type strain (“wt”) and
two replicates of one of the mutant strains (“mut”). We use
these data to illustrate gene-level EDA.

```
library(EDASeq)
library(yeastRNASeq)
library(leeBamViews)
```

# 2 Reading in unaligned and aligned read data

## 2.1 Unaligned reads

Unaligned (unmapped) reads stored in FASTQ format may be managed via
the class `FastqFileList` imported from `ShortRead`.
Information related to the libraries sequenced in each lane can be
stored in the `elementMetadata` slot of the
`FastqFileList` object.

```
files <- list.files(file.path(system.file(package = "yeastRNASeq"),
                              "reads"), pattern = "fastq", full.names = TRUE)
names(files) <- gsub("\\.fastq.*", "", basename(files))
met <- DataFrame(conditions=c(rep("mut",2), rep("wt",2)),
                 row.names=names(files))
fastq <- FastqFileList(files)
elementMetadata(fastq) <- met
fastq
```

```
## FastqFileList of length 4
## names(4): mut_1_f mut_2_f wt_1_f wt_2_f
```

## 2.2 Aligned reads

The package can deal with aligned (mapped) reads in BAM format, using
the class `BamFileList` from `Rsamtools`. Again, the
`elementMetadata` slot can be used to store lane-level sample
information.

```
files <- list.files(file.path(system.file(package = "leeBamViews"), "bam"),
                    pattern = "bam$", full.names = TRUE)
names(files) <- gsub("\\.bam", "", basename(files))

gt <- gsub(".*/", "", files)
gt <- gsub("_.*", "", gt)
lane <- gsub(".*(.)$", "\\1", gt)
geno <- gsub(".$", "", gt)

pd <- DataFrame(geno=geno, lane=lane,
                row.names=paste(geno,lane,sep="."))

bfs <- BamFileList(files)
elementMetadata(bfs) <- pd
bfs
```

```
## BamFileList of length 8
## names(8): isowt5_13e isowt6_13e ... xrn1_13e xrn2_13e
```

# 3 Read-level EDA

## 3.1 Numbers of unaligned and aligned reads

One important check for quality control is to look at the total number
of reads produced in each lane, the number and the percentage of reads mapped to a
reference genome. A low total
number of reads might be a symptom of low quality of the input RNA,
while a low mapping percentage might indicate poor quality of the
reads (low complexity), problems with the reference genome, or
mislabeled lanes.

```
colors <- c(rep(rgb(1,0,0,alpha=0.7),2),
            rep(rgb(0,0,1,alpha=0.7),2),
            rep(rgb(0,1,0,alpha=0.7),2),
            rep(rgb(0,1,1,alpha=0.7),2))
barplot(bfs,las=2,col=colors)
```

![](data:image/png;base64...)

The figure, produced using the `barplot` method for the
`BamFileList` class, displays the number of mapped reads for
the subset of the yeast dataset included in the package
`leeBamViews`. Unfortunately, `leeBamViews` does
not provide unaligned reads, but barplots of the total number of reads
can be obtained using the `barplot` method for the
`FastqFileList` class. Analogously, one can plot the percentage
of mapped reads with the `plot` method with signature
`c(x="BamFileList", y="FastqFileList")`. See the manual pages for
details.

## 3.2 Read quality scores

As an additional quality check, one can plot the mean per-base (i.e.,
per-cycle) quality of the unmapped or mapped reads in every lane.

```
plotQuality(bfs,col=colors,lty=1)
legend("topright",unique(elementMetadata(bfs)[,1]), fill=unique(colors))
```

![](data:image/png;base64...)

## 3.3 Individual lane summaries

If one is interested in looking more thoroughly at one lane, it is
possible to display the per-base distribution of quality scores for
each lane and the number of mapped reads
stratified by chromosome or strand. As expected,
all the reads are mapped to chromosome XIII.

```
plotQuality(bfs[[1]],cex.axis=.8)
```

![](data:image/png;base64...)

```
barplot(bfs[[1]],las=2)
```

![](data:image/png;base64...)

## 3.4 Read nucleotide distributions

A potential source of bias is related to the sequence composition of
the reads. The function `plotNtFrequency` plots the
per-base nucleotide frequencies for all the reads in a given
lane.

```
plotNtFrequency(bfs[[1]])
```

![](data:image/png;base64...)

# 4 Gene-level EDA

Examining statistics and quality metrics at a read level can help in
discovering problematic libraries or systematic biases in one or more
lanes. Nevertheless, some biases can be difficult to detect at this
scale and gene-level EDA is equally important.

## 4.1 Classes and methods for gene-level counts

There are several Bioconductor packages for aggregating reads over
genes (or other genomic regions, such as, transcripts and exons) given
a particular genome annotation, e.g., `IRanges`,
`ShortRead`, `Genominator`, `Rsubread`. See
their respective vignettes for details.

Here, we consider this step done and load the object
`geneLevelData` from `yeastRNASeq`, which provides
gene-level counts for 2 wild-type and 2 mutant lanes from the yeast
dataset of `lee2008novel` (see the `Genominator`
vignette for an example on the same dataset).

```
data(geneLevelData)
head(geneLevelData)
```

```
##         mut_1 mut_2 wt_1 wt_2
## YHR055C     0     0    0    0
## YPR161C    38    39   35   34
## YOL138C    31    33   40   26
## YDR395W    55    52   47   47
## YGR129W    29    26    5    5
## YPR165W   189   180  151  180
```

Since it is useful to explore biases related to length and GC-content,
the `EDASeq` package provides, for illustration purposes,
length and GC-content for *S. cerevisiae* genes (based on SGD
annotation, version r64 (“Saccharomyces Genome Database,” [n.d.](#ref-sgd))).

Functionality for automated retrieval of gene length and GC-content
is introduced in the last section of the vignette.

```
data(yeastGC)
head(yeastGC)
```

```
##   YAL001C   YAL002W   YAL003W   YAL004W   YAL005C   YAL007C
## 0.3712317 0.3717647 0.4460548 0.4490741 0.4406428 0.3703704
```

```
data(yeastLength)
head(yeastLength)
```

```
## YAL001C YAL002W YAL003W YAL004W YAL005C YAL007C
##    3483    3825     621     648    1929     648
```

First, we filter the non-expressed genes, i.e., we consider only the
genes with an average read count greater than 10 across the four lanes
and for which we have length and GC-content information.

```
filter <- apply(geneLevelData,1,function(x) mean(x)>10)
table(filter)
```

```
## filter
## FALSE  TRUE
##  1988  5077
```

```
common <- intersect(names(yeastGC),
                    rownames(geneLevelData[filter,]))
length(common)
```

```
## [1] 4994
```

This leaves us with 4994 genes.

The `EDASeq` package provides the `SeqExpressionSet`
class to store gene counts, (lane-level) information on the sequenced
libraries, and (gene-level) feature information. We use the data
frame `met` created in Section `secRead` for the
lane-level data. As for the feature data, we use gene length and
GC-content.

```
feature <- data.frame(gc=yeastGC,length=yeastLength)
data <- newSeqExpressionSet(counts=as.matrix(geneLevelData[common,]),
                            featureData=feature[common,],
                            phenoData=data.frame(
                              conditions=factor(c(rep("mut",2),rep("wt",2))),
                              row.names=colnames(geneLevelData)))
data
```

```
## SeqExpressionSet (storageMode: lockedEnvironment)
## assayData: 4994 features, 4 samples
##   element names: counts, normalizedCounts, offset
## protocolData: none
## phenoData
##   sampleNames: mut_1 mut_2 wt_1 wt_2
##   varLabels: conditions
##   varMetadata: labelDescription
## featureData
##   featureNames: YAL001C YAL002W ... YPR201W (4994
##     total)
##   fvarLabels: gc length
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

Note that the row names of `counts` and `featureData`
must be the same; likewise for the row names of `phenoData`
and the column names of `counts`. The expression values can be accessed with `counts`, the lane information with `pData`,
and the feature information with `fData`.

```
head(counts(data))
```

```
##         mut_1 mut_2 wt_1 wt_2
## YAL001C    80    83   27   40
## YAL002W    33    38   53   66
## YAL003W  1887  1912  270  270
## YAL004W    90   110  276  295
## YAL005C   325   316  874  935
## YAL007C    27    30   19   24
```

```
pData(data)
```

```
##       conditions
## mut_1        mut
## mut_2        mut
## wt_1          wt
## wt_2          wt
```

```
head(fData(data))
```

```
##                gc length
## YAL001C 0.3712317   3483
## YAL002W 0.3717647   3825
## YAL003W 0.4460548    621
## YAL004W 0.4490741    648
## YAL005C 0.4406428   1929
## YAL007C 0.3703704    648
```

The `SeqExpressionSet` class has two additional slots:
`normalizedCounts` and `offset` (matrices of the same dimension as `counts`),
which may be used to store a matrix of normalized counts and of
normalization offsets, respectively, to be used for subsequent analyses (see Section
and the `edgeR` vignette for details on the
role of offsets). If not specified, the offset is initialized as a matrix
of zeros.

```
head(offst(data))
```

```
##         mut_1 mut_2 wt_1 wt_2
## YAL001C     0     0    0    0
## YAL002W     0     0    0    0
## YAL003W     0     0    0    0
## YAL004W     0     0    0    0
## YAL005C     0     0    0    0
## YAL007C     0     0    0    0
```

## 4.2 Between-lane distribution of gene-level counts

One of the main considerations when dealing with gene-level counts is
the difference in count distributions between lanes. The
`boxplot` method provides an easy way to produce boxplots of
the logarithms of the gene counts in each lane.

```
boxplot(data,col=colors[1:4])
```

![](data:image/png;base64...)

The `MDPlot` method produces a mean-difference plot (MD-plot)
of read counts for two lanes.

```
MDPlot(data,c(1,3))
```

![](data:image/png;base64...)

## 4.3 Over-dispersion

Although the Poisson distribution is a natural and simple way to model
count data, it has the limitation of assuming equality of the mean and
variance. For this reason, the negative binomial distribution has been
proposed as an alternative when the data show over-dispersion. The
function `meanVarPlot` can be used to check whether the
count data are over-dispersed (for the Poisson distribution, one would
expect the points in the following Figures to be evenly
scattered around the black line).

```
meanVarPlot(data[,1:2], log=TRUE, ylim=c(0,16))
```

![](data:image/png;base64...)

```
meanVarPlot(data, log=TRUE, ylim=c(0,16))
```

![](data:image/png;base64...)

Note that the mean-variance relationship should be examined within
replicate lanes only (i.e., conditional on variables expected to
contribute to differential expression). For the yeast dataset, it is
not surprising to see no evidence of over-dispersion for the two
mutant technical replicate lanes; likewise for
the two wild-type lanes. However, one expects over-dispersion in the
presence of biological variability, when considering at once all four mutant and wild-type lanes
(**???**).

## 4.4 Gene-specific effects on read counts

Several authors have reported selection biases related to sequence
features such as gene length, GC-content, and mappability
(Bullard et al. [2010](#ref-bullard2010evaluation), @hansen2011removing, @oshlack2009transcript, @risso2011gc).

In the following figure, obtained using `biasPlot`, one can
see the dependence of gene-level counts on GC-content. The same plot
could be created for gene length or mappability instead of GC-content.

```
biasPlot(data, "gc", log=TRUE, ylim=c(1,5))
```

![](data:image/png;base64...)

To show that GC-content dependence can bias differential expression
analysis, one can produce stratified boxplots of the log-fold-change
of read counts from two lanes using the `biasBoxplot` method.
Again, the same type of plots can be created
for gene length or mappability.

```
lfc <- log(counts(data)[,3]+0.1) - log(counts(data)[,1]+0.1)
biasBoxplot(lfc, fData(data)$gc)
```

![](data:image/png;base64...)

# 5 Normalization

Following (Risso et al. [2011](#ref-risso2011gc)), we consider two main types of effects
on gene-level counts: (1) within-lane gene-specific (and possibly
lane-specific) effects, e.g., related to gene length or GC-content,
and (2) effects related to between-lane distributional differences,
e.g., sequencing depth. Accordingly,
`withinLaneNormalization` and
`betweenLaneNormalization` adjust for the first and second
type of effects, respectively. We recommend to normalize for
within-lane effects prior to between-lane normalization.

We implemented four within-lane normalization methods, namely: loess
robust local regression of read counts (log) on a gene feature such as
GC-content (`loess`), global-scaling between feature strata
using the median (`median`), global-scaling between feature
strata using the upper-quartile (`upper`), and full-quantile
normalization between feature strata (`full`). For a discussion
of these methods in context of GC-content normalization see
(Risso et al. [2011](#ref-risso2011gc)).

```
dataWithin <- withinLaneNormalization(data,"gc", which="full")
dataNorm <- betweenLaneNormalization(dataWithin, which="full")
```

Regarding between-lane normalization, the package implements three of
the methods introduced in (Bullard et al. [2010](#ref-bullard2010evaluation)):
global-scaling using the median (`median`), global-scaling using
the upper-quartile (`upper`), and full-quantile normalization
(`full`).

The next figure shows how after full-quantile within- and
between-lane normalization, the GC-content bias is reduced and the
distribution of the counts is the same in each lane.

```
biasPlot(dataNorm, "gc", log=TRUE, ylim=c(1,5))
```

![](data:image/png;base64...)

```
boxplot(dataNorm, col=colors)
```

![](data:image/png;base64...)

## 5.1 Offset

Some authors have argued that it is better to leave the count data
unchanged to preserve their sampling properties and instead use an
offset for normalization purposes in the statistical model for read
counts
(**???**). This
can be achieved easily using the argument `offset` in both
normalization functions.

```
dataOffset <- withinLaneNormalization(data,"gc",
                                      which="full",offset=TRUE)
dataOffset <- betweenLaneNormalization(dataOffset,
                                       which="full",offset=TRUE)
```

Note that the `dataOffset` object will have both normalized
counts and offset stored in their respective slots.

# 6 Differential expression analysis

One of the main applications of RNA-Seq is differential expression
analysis. The normalized counts (or the original counts and the
offset) obtained using the `EDASeq` package can be supplied
to packages such as `edgeR` (Robinson, McCarthy, and Smyth [2010](#ref-robinson2010edger)) or
`DESeq2` (Love, Huber, and Anders [2014](#ref-deseq2)) to find differentially
expressed genes. This section should be considered only as an
illustration of the compatibility of the results of `EDASeq`
with two of the most widely used packages for differential expression;
we refer ther reader to the edgeR’s user guide and to the DESeq2 vignettes for more details on the methods implemented there.

## 6.1 edgeR

We can perform a differential expression analysis with
`edgeR` based on the original counts by passing an offset to
the generalized linear model. See the `edgeR` vignette for details
about how to perform a differential expression analysis with more complex designs or more robust approaches.

```
library(edgeR)
design <- model.matrix(~conditions, data=pData(dataOffset))

y <- DGEList(counts=counts(dataOffset),
             group=pData(dataOffset)$conditions)
y$offset <- -offst(dataOffset)
y <- estimateDisp(y, design)

fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2)
topTags(lrt)
```

```
## Coefficient:  conditionswt
##               logFC    logCPM       LR        PValue
## YPL198W   -7.425029 10.437912 1991.255  0.000000e+00
## YGL088W   -5.554418 11.444995 3001.192  0.000000e+00
## YAL003W   -2.991238 11.609151 2899.918  0.000000e+00
## YCL040W    1.938459 13.172063 3286.985  0.000000e+00
## YFL014W   -1.492220 13.156236 2724.811  0.000000e+00
## YMR013W-A -6.236295  9.920053 1458.349 4.397036e-319
## YLR110C   -1.079939 13.004727 1320.927 3.202620e-289
## YLR167W   -2.009235 11.080563 1299.033 1.833950e-284
## YGL076C   -4.206627  9.966608 1245.094 9.666641e-273
## YNL036W   -2.403405 10.350078 1002.868 4.273342e-220
##                     FDR
## YPL198W    0.000000e+00
## YGL088W    0.000000e+00
## YAL003W    0.000000e+00
## YCL040W    0.000000e+00
## YFL014W    0.000000e+00
## YMR013W-A 3.659800e-316
## YLR110C   2.284840e-286
## YLR167W   1.144843e-281
## YGL076C   5.363912e-270
## YNL036W   2.134107e-217
```

## 6.2 DESeq2

We can perform the same differential expression analysis with
`DESeq2`.

```
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = counts(dataOffset),
                              colData = pData(dataOffset),
                              design = ~ conditions)

normFactors <- exp(-1 * offst(dataOffset))
normFactors <- normFactors / exp(rowMeans(log(normFactors)))
normalizationFactors(dds) <- normFactors

dds <- DESeq(dds)
res <- results(dds)
res
```

```
## log2 fold change (MLE): conditions wt vs mut
## Wald test p-value: conditions wt vs mut
## DataFrame with 4994 rows and 6 columns
##          baseMean log2FoldChange     lfcSE      stat
##         <numeric>      <numeric> <numeric> <numeric>
## YAL001C   56.0099      -1.101637  0.378950  -2.90708
## YAL002W   53.3486       1.614092  0.386722   4.17377
## YAL003W 1136.8612      -2.991780  0.146400 -20.43569
## YAL004W  178.9912       0.990713  0.233707   4.23912
## YAL005C  560.4825       0.814788  0.164510   4.95281
## ...           ...            ...       ...       ...
## YPR196W  10.61537       0.597979  0.810533  0.737760
## YPR197C  18.52248       0.905072  0.620132  1.459483
## YPR198W  62.69788       0.607913  0.347310  1.750348
## YPR199C  33.25060      -1.192572  0.485729 -2.455222
## YPR201W   9.56508       0.165297  0.862888  0.191562
##              pvalue        padj
##           <numeric>   <numeric>
## YAL001C 3.64821e-03 2.57142e-02
## YAL002W 2.99595e-05 4.37100e-04
## YAL003W 8.05405e-93 1.93297e-89
## YAL004W 2.24395e-05 3.40854e-04
## YAL005C 7.31511e-07 1.59602e-05
## ...             ...         ...
## YPR196W   0.4606602          NA
## YPR197C   0.1444323   0.3593960
## YPR198W   0.0800583   0.2442976
## YPR199C   0.0140797   0.0725916
## YPR201W   0.8480851          NA
```

# 7 Definitions and conventions

## 7.1 Rounding

After either within-lane or between-lane normalization, the expression
values are not counts
anymore. However, their distribution still shows some typical features
of counts distribution (e.g., the variance depends on the mean).
Hence, for most applications, it is useful to round the normalized
values to recover count-like values, which we refer to as “pseudo-counts”.

By default, both
`withinLaneNormalization` and
`betweenLaneNormalization` round the normalized values to
the closest integer. This behavior can be changed by specifying
`round=FALSE`. This gives the user more flexibility and assures
that rounding approximations do not affect subsequent computations
(e.g., recovering the offset from the normalized counts).

## 7.2 Zero counts

To avoid problems in the computation of logarithms (e.g. in log-fold-changes), we add a small positive constant (namely \(0.1\)) to the
counts. For instance, the log-fold-change between \(y\_1\) and \(y\_2\) is
defined as
\[\begin{equation\*}
\frac{\log(y\_1 + 0.1)}{\log(y\_2 + 0.1)}.
\end{equation\*}\]

## 7.3 Offset

We define an offset in the normalization as
\[\begin{equation\*}
o = \log(y\_{norm} + 0.1) - \log(y\_{raw} + 0.1),
\end{equation\*}\]
where \(y\_{norm}\) and \(y\_{raw}\) are the normalized and raw counts, respectively.

One can easily recover the normalized data from the raw counts and
offset, as shown here:

```
dataNorm <- betweenLaneNormalization(data, round=FALSE, offset=TRUE)

norm1 <- normCounts(dataNorm)
norm2 <- exp(log(counts(dataNorm) + 0.1 ) + offst(dataNorm)) - 0.1

head(norm1 - norm2)
```

```
##                 mut_1         mut_2          wt_1
## YAL001C -1.421085e-14 -1.421085e-14  0.000000e+00
## YAL002W  3.552714e-15 -7.105427e-15 -2.131628e-14
## YAL003W  4.547474e-13 -2.273737e-13  1.136868e-13
## YAL004W -2.842171e-14 -1.421085e-14  5.684342e-14
## YAL005C -1.136868e-13  5.684342e-14 -3.410605e-13
## YAL007C  3.552714e-15  3.552714e-15 -3.552714e-15
##                  wt_2
## YAL001C  0.000000e+00
## YAL002W  0.000000e+00
## YAL003W -5.684342e-14
## YAL004W -5.684342e-14
## YAL005C -1.136868e-13
## YAL007C  3.552714e-15
```

Note that the small constant added in the definition of offset does
not matter when pseudo-counts are considered, i.e.,

```
head(round(normCounts(dataNorm)) - round(counts(dataNorm) * exp(offst(dataNorm))))
```

```
##         mut_1 mut_2 wt_1 wt_2
## YAL001C     0     0    0    0
## YAL002W     0     0    0    0
## YAL003W     0     0    0    0
## YAL004W     0     0    0    0
## YAL005C     0     0    0    0
## YAL007C     0     0    0    0
```

We defined the offset as the log-ratio between normalized and raw
counts. However, the `edgeR` functions expect as offset
argument the log-ratio between raw and normalized counts. One must use
`-offst(offsetData)` as the offset argument of `edgeR`.

# 8 Retrieving gene length and GC-content

Two essential features the gene-level EDA normalizes for are gene length and
GC-content. As users might wish to automatically retrieve this information, we
provide the function `getGeneLengthAndGCContent`. Given selected
ENTREZ or ENSEMBL gene IDs and the organism under investigation, this can be
done either based on BioMart (default) or using BioC annotation utilities.

```
getGeneLengthAndGCContent(id=c("ENSG00000012048", "ENSG00000139618"), org="hsa")
```

Accordingly, we can retrieve the precalculated yeast data that has been used
throughout the vignette via

```
fData(data) <- getGeneLengthAndGCContent(featureNames(data),
                                              org="sacCer3", mode="org.db")
```

# 9 SessionInfo

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils
## [6] datasets  methods   base
##
## other attached packages:
##  [1] DESeq2_1.50.0               edgeR_4.8.0
##  [3] limma_3.66.0                leeBamViews_1.45.0
##  [5] BSgenome_1.78.0             rtracklayer_1.70.0
##  [7] BiocIO_1.20.0               yeastRNASeq_0.47.0
##  [9] EDASeq_2.44.0               ShortRead_1.68.0
## [11] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] Rsamtools_2.26.0            GenomicRanges_1.62.0
## [17] Biostrings_2.78.0           Seqinfo_1.0.0
## [19] XVector_0.50.0              IRanges_2.44.0
## [21] S4Vectors_0.48.0            BiocParallel_1.44.0
## [23] Biobase_2.70.0              BiocGenerics_0.56.0
## [25] generics_0.1.4              knitr_1.50
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3              bitops_1.0-9
##  [3] deldir_2.0-4           httr2_1.2.1
##  [5] biomaRt_2.66.0         rlang_1.1.6
##  [7] magrittr_2.0.4         compiler_4.5.1
##  [9] RSQLite_2.4.3          GenomicFeatures_1.62.0
## [11] png_0.1-8              vctrs_0.6.5
## [13] stringr_1.5.2          pwalign_1.6.0
## [15] pkgconfig_2.0.3        crayon_1.5.3
## [17] fastmap_1.2.0          dbplyr_2.5.1
## [19] magick_2.9.0           rmarkdown_2.30
## [21] tinytex_0.57           bit_4.6.0
## [23] xfun_0.53              cachem_1.1.0
## [25] cigarillo_1.0.0        jsonlite_2.0.0
## [27] progress_1.2.3         blob_1.2.4
## [29] DelayedArray_0.36.0    jpeg_0.1-11
## [31] parallel_4.5.1         prettyunits_1.2.0
## [33] R6_2.6.1               bslib_0.9.0
## [35] stringi_1.8.7          RColorBrewer_1.1-3
## [37] jquerylib_0.1.4        Rcpp_1.1.0
## [39] bookdown_0.45          R.utils_2.13.0
## [41] Matrix_1.7-4           tidyselect_1.2.1
## [43] dichromat_2.0-0.1      abind_1.4-8
## [45] yaml_2.3.10            codetools_0.2-20
## [47] hwriter_1.3.2.1        curl_7.0.0
## [49] lattice_0.22-7         tibble_3.3.0
## [51] S7_0.2.0               KEGGREST_1.50.0
## [53] evaluate_1.0.5         BiocFileCache_3.0.0
## [55] pillar_1.11.1          BiocManager_1.30.26
## [57] filelock_1.0.3         KernSmooth_2.23-26
## [59] RCurl_1.98-1.17        ggplot2_4.0.0
## [61] hms_1.1.4              scales_1.4.0
## [63] glue_1.8.0             tools_4.5.1
## [65] interp_1.1-6           locfit_1.5-9.12
## [67] XML_3.99-0.19          grid_4.5.1
## [69] latticeExtra_0.6-31    AnnotationDbi_1.72.0
## [71] restfulr_0.0.16        cli_3.6.5
## [73] rappdirs_0.3.3         S4Arrays_1.10.0
## [75] dplyr_1.1.4            gtable_0.3.6
## [77] R.methodsS3_1.8.2      sass_0.4.10
## [79] digest_0.6.37          aroma.light_3.40.0
## [81] SparseArray_1.10.0     farver_2.1.2
## [83] rjson_0.2.23           memoise_2.0.1
## [85] htmltools_0.5.8.1      R.oo_1.27.1
## [87] lifecycle_1.0.4        httr_1.4.7
## [89] statmod_1.5.1          bit64_4.6.0-1
```

# References

Bullard, James H, Elizabeth Purdom, Kasper D Hansen, and Sandrine Dudoit. 2010. “Evaluation of Statistical Methods for Normalization and Differential Expression in mRNA-Seq Experiments.” *BMC Bioinformatics* 11 (1): 94.

Langmead, Ben, Cole Trapnell, Mihai Pop, and Steven L Salzberg. 2009. “Ultrafast and Memory-Efficient Alignment of Short Dna Sequences to the Human Genome.” *Genome Biology* 10 (3): R25.

Lee, Albert, Kasper Daniel Hansen, James Bullard, Sandrine Dudoit, and Gavin Sherlock. 2008. “Novel Low Abundance and Transient Rnas in Yeast Revealed by Tiling Microarrays and Ultra High–Throughput Sequencing Are Not Conserved Across Closely Related Yeast Species.” *PLoS Genetics* 4 (12): e1000299.

Love, Michael I., Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

Oshlack, Alicia, and Matthew J Wakefield. 2009. “Transcript Length Bias in Rna-Seq Data Confounds Systems Biology.” *Biology Direct* 4 (1): 14.

Risso, Davide, Katja Schwartz, Gavin Sherlock, and Sandrine Dudoit. 2011. “GC-Content Normalization for Rna-Seq Data.” *BMC Bioinformatics* 12 (1): 480.

Robinson, Mark D, Davis J McCarthy, and Gordon K Smyth. 2010. “EdgeR: A Bioconductor Package for Differential Expression Analysis of Digital Gene Expression Data.” *Bioinformatics* 26 (1): 139–40.

“Saccharomyces Genome Database.” n.d. <http://www.yeastgenome.org>.