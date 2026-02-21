# The DSS User’s Guide

Hao Wu, hao.wu@emory.edu

#### 29 October 2025

#### Abstract

This vignette introduces the use of the Bioconductor package DSS (Dispersion Shrinkage for Sequencing data), which is designed for differential analysis on high-throughput sequencing data. It provide functionalities for RNA-seq differential expression, and bisulfite sequencing (BS-seq) differential methylation. The core of DSS is a procedure based on Bayesian hierarchical model to estimate and shrink gene- or CpG site-specific dispersions, then conduct Wald tests for detecting differential expression/methylation.

#### Package

DSS 2.58.0

# 1 Introduction

## 1.1 Background

Recent advances in various high-throughput sequencing technologies have
revolutionized genomics research. Among them,
RNA-seq is designed to measure the the abundance of RNA products,
and Bisulfite sequencing (BS-seq) is for measuring DNA methylation.
A fundamental question in functional genomics research
is whether gene expression or DNA methylation
vary under different biological contexts.
Thus, identifying differential expression genes (DEGs)
or differential methylation loci/regions (DML/DMRs)
are key tasks in RNA-seq or BS-seq data analyses.

The differential expression (DE) or differential methylation (DM) analyses
are often based on gene- or CpG-specific statistical test.
A key limitation in RNA- or BS-seq experiments
is that the number of biological replicates is usually limited due to cost constraints.
This can lead to unstable estimation of within group variance,
and subsequently undesirable results from hypothesis testing.
Variance shrinkage methods have been widely applied in DE analyses in
microarray data to improve the estimation of gene-specific within group variances.
These methods are typically based on a Bayesian hierarchical model,
with a prior imposed on the gene-specific variances to provide
a basis for information sharing across all genes.

A distinct feature of RNA-seq or BS-seq data is that the measurements are
in the form of counts and have to be modeld by discrete distributions.
Unlike continuous distributions such as Gaussian,
the variances depend on means in these distributions.
This implies that the sample variances do not account for biological variation,
and shrinkage cannot be applied on variances directly.
In DSS, we assume that the count data are
from the negative-binomial (for RNA-seq) or beta-binomial (for BS-seq) distribution.
We then parameterize the distributions by a mean and a dispersion parameters.
The dispersion parameters, which represent the biological variation for
replicates within a treatment group, play a central role in the differential analyses.

DSS implements a series of DE/DM detection algorithms based on the
dispersion shrinkage method followed by Wald statistical test
to test each gene/CpG site for differential expression/methylation.
It provides functions for RNA-seq DE analysis for both two group comparision and multi-factor design,
BS-seq DM analysis for two group comparision, multi-factor design, and data without biological replicate.

For more details of the data model, the shrinkage method, and test procedures,
please read (Wu, Wang, and Wu [2012](#ref-DE)) for differential expression from RNA-seq,
(Feng, Conneely, and Wu [2014](#ref-DML)) for differential methylation for two-group comparison from BS-seq,
(Wu et al. [2015](#ref-DMR1)) for differential methylation for data without biological replicate,
and (Park and Wu [2016](#ref-DML-general)) for differential methylation for general experimental design.

## 1.2 Citation

* For differential expression in RNA-seq, cite Wu, Wang, and Wu ([2012](#ref-DE)).
* For general differential methylation in BS-seq, cite Feng, Conneely, and Wu ([2014](#ref-DML)).
* For differential methylation in BS-seq when there’s no biological replicate, cite Wu et al. ([2015](#ref-DMR1)).
* For differential methylation in BS-seq under general experimental design, cite Park and Wu ([2016](#ref-DML-general)).

# 2 Using DSS for RNA-seq differential expression analysis

## 2.1 Input data preparation

DSS requires a count table (a matrix of integers) for gene expression values
(rows are for genes and columns are for samples).
This is different from the isoform expression based analysis such as in cufflink/cuffdiff,
where the gene expressions are represented as non-integers values.

There are a number of ways to obtain the count table from raw sequencing data (fastq file).
Aligners such as [STAR](https://github.com/alexdobin/STAR) automatically output a count table.
Several Bioconductor packages serve this purpose,
for example, [Rsubread](http://bioconductor.org/packages/release/bioc/html/Rsubread.html),
[QuasR](http://bioconductor.org/packages/release/bioc/html/QuasR.html),
and [easyRNASeq](http://bioconductor.org/packages/release/bioc/html/easyRNASeq.html).
Other tools like
[Salmon](http://combine-lab.github.io/salmon/),
[Kallisto](https://pachterlab.github.io/kallisto/about.html),
or [RSEM](http://deweylab.github.io/RSEM/) can also be used.
Please refer to the package manuals for more details.

## 2.2 Single factor experiment

In single factor RNA-seq experiment, DSS requires
a vector representing experimental designs. The length of the
design vector must match the number of columns of the count table.
Optionally, normalization factors or additional annotation for genes can be supplied.

The basic data container in the package is `SeqCountSet` class,
which is directly inherited from `ExpressionSet` class
defined in `Biobase`. An object of the class contains all necessary
information for a DE analysis: gene expression values, experimental designs,
and additional annotations.

A typical DE analysis contains the following simple steps.
- Create a `SeqCountSet` object using `newSeqCountSet`.
- Estimate normalization factor using `estNormFactors`.
- Estimate and shrink gene-wise dispersion using `estDispersion`.
- Two-group comparison using `waldTest`.

The usage of DSS is demonstrated in the simple simulation below.

* First load in the library, and make a `SeqCountSet`
  object from simulated counts for 2000 genes and 6 samples.

```
library(DSS)
counts1 = matrix(rnbinom(300, mu=10, size=10), ncol=3)
counts2 = matrix(rnbinom(300, mu=50, size=10), ncol=3)
X1 = cbind(counts1, counts2)
X2 = matrix(rnbinom(11400, mu=10, size=10), ncol=6)
X = rbind(X1,X2)  ## these are 100 DE genes
designs = c(0,0,0,1,1,1)
seqData = newSeqCountSet(X, designs)
seqData
```

```
## SeqCountSet (storageMode: lockedEnvironment)
## assayData: 2000 features, 6 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: 1 2 ... 6 (6 total)
##   varLabels: designs
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation:
```

* Estimate normalization factor.

```
seqData = estNormFactors(seqData)
```

* Estimate and shrink gene-wise dispersions

```
seqData = estDispersion(seqData)
```

* With the normalization factors and dispersions ready, the two-group comparison can be
  conducted via a Wald test:

```
result=waldTest(seqData, 0, 1)
head(result,5)
```

```
##    geneIndex       muA      muB       lfc   difExpr     stats         pval
## 25        25  8.000000 74.91111 -2.182888 -66.91111 -5.797308 6.738783e-09
## 38        38  7.333333 60.04444 -2.044990 -52.71111 -5.659758 1.515869e-08
## 26        26 10.333333 72.73333 -1.911023 -62.40000 -5.588516 2.290184e-08
## 40        40  5.333333 54.33333 -2.240710 -49.00000 -5.577542 2.439412e-08
## 36        36  7.333333 60.37778 -2.050480 -53.04444 -5.573443 2.497540e-08
##             fdr
## 25 8.113575e-06
## 38 8.113575e-06
## 26 8.113575e-06
## 40 8.113575e-06
## 36 8.113575e-06
```

A higher level wrapper function `DSS.DE` is provided
for simple RNA-seq DE analysis in a two-group comparison.
User only needs to provide a count matrix and a vector of 0’s and 1’s representing the
design, and get DE test results in one line. A simple example is listed below:

```
counts = matrix(rpois(600, 10), ncol=6)
designs = c(0,0,0,1,1,1)
result = DSS.DE(counts, designs)
head(result)
```

```
##    geneIndex       muA       muB        lfc   difExpr     stats        pval
## 77        77  4.666667 12.000000 -0.8835009 -7.333333 -2.693152 0.007078002
## 99        99  8.333333 16.000000 -0.6248279 -7.666667 -2.236996 0.025286606
## 39        39 10.000000  4.666667  0.7091475  5.333333  2.132935 0.032930048
## 18        18  7.333333 12.666667 -0.5193003 -5.333333 -1.771252 0.076518765
## 54        54 12.000000  7.000000  0.5108256  5.000000  1.715826 0.086193969
## 98        98 12.000000  7.333333  0.4673405  4.666667  1.585475 0.112858366
##          fdr
## 77 0.7078002
## 99 0.9755682
## 39 0.9755682
## 18 0.9755682
## 54 0.9755682
## 98 0.9755682
```

## 2.3 Multifactor experiment

`DSS` provides functionalities for dispersion shrinkage for multifactor experimental designs.
Downstream model fitting (through genearlized linear model)
and hypothesis testing can be performed using other packages such as `edgeR`,
with the dispersions estimated from DSS.

Below is an example, based a simple simulation, to illustrate the DE analysis of
a crossed design.

* First simulate data for a 2x2 crossed experiments. Note the
  counts are randomly generated.

```
library(DSS)
library(edgeR)
counts = matrix(rpois(800, 10), ncol=8)
design = data.frame(gender=c(rep("M",4), rep("F",4)),
                    strain=rep(c("WT", "Mutant"),4))
X = model.matrix(~gender+strain, data=design)
```

* make SeqCountSet, then estimate size factors and dispersion

```
seqData = newSeqCountSet(counts, as.data.frame(X))
seqData = estNormFactors(seqData)
seqData = estDispersion(seqData)
```

* Using edgeR’s function to do glm model fitting, but plugging in the estimated dispersion
  from DSS.

```
fit.edgeR = glmFit(counts, X, dispersion=dispersion(seqData))
```

* Using edgeR’s function to do hypothesis testing on the second parameter of the model (gender).

```
lrt.edgeR = glmLRT(glmfit=fit.edgeR, coef=2)
head(lrt.edgeR$table)
```

```
##         logFC   logCPM         LR     PValue
## 1  0.10864466 13.91615 0.11562497 0.73382887
## 2 -0.16180787 13.45000 0.18694467 0.66547180
## 3 -0.58279203 13.87871 3.08697194 0.07892155
## 4  0.16618096 13.61760 0.22176125 0.63770120
## 5 -0.15192245 13.54358 0.17660172 0.67431009
## 6 -0.06340442 13.71501 0.03429311 0.85308473
```

# 3 Using DSS for BS-seq differential methylation analysis

## 3.1 Overview

To detect differential methylation, statistical tests are conducted at each CpG site,
and then the differential methylation loci (DML) or differential methylation regions (DMR)
are called based on user specified threshold.
A rigorous statistical tests should account for
biological variations among replicates and the sequencing depth.
Most existing methods for DM analysis are based on ad hoc methods.
For example, using Fisher’s exact ignores the biological variations,
using t-test on estimated methylation levels ignores the sequencing depth.
Sometimes arbitrary filtering are implemented: loci with depth
lower than an arbitrary threshold are filtered out, which results in information loss

The DM detection procedure implemented in DSS is based on
a rigorous Wald test for beta-binomial distributions.
The test statistics depend on the biological variations (characterized by dispersion parameter)
as well as the sequencing depth. An important part of the algorithm
is the estimation of dispersion parameter, which is achieved through a
shrinkage estimator based on a Bayesian hierarchical model (Feng, Conneely, and Wu [2014](#ref-DML)).
An advantage of DSS is that the test can be performed even when
there is no biological replicates. That’s because by smoothing,
the neighboring CpG sites can be viewed as ***pseudo-replicates***, and the dispersion
can still be estimated with reasonable precision.

DSS also works for general experimental design, based on a beta-binomial
regression model with ***arcsine*** link function.
Model fitting is performed on transformed data with generalized least
square method, which achieves much improved computational performance compared
with methods based on generalized linear model.

DSS depends on [bsseq](http://bioconductor.org/packages/release/bioc/html/bsseq.html)
Bioconductor package, which has neat definition of
data structures and many useful utility functions. In order to use the DM detection functionalities,
`bsseq` needs to be pre-installed.

## 3.2 Input data preparation

DSS requires data from each BS-seq experiment to be summarized
into following information for each CG position:
chromosome number, genomic coordinate, total number of reads,
and number of reads showing methylation. For a sample, this information
are saved in a simple text file, with each row representing a CpG site.
Below shows an example of a small part of such a file:

```
chr     pos     N       X
chr18   3014904 26      2
chr18   3031032 33      12
chr18   3031044 33      13
chr18   3031065 48      24
```

One can follow below steps to obtain such data from raw sequence file (fastq file),
using [bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)
(version 0.10.0, commands for newer versions could be different)
for BS-seq alignment and count extraction. These steps require installation
of [bowtie](http://bowtie-bio.sourceforge.net/index.shtml)
or [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml),
`bismark`, and the fasta file for reference genome.

1. Prepare Bisulfite reference genome. This can be done using the
   `bismark_genome_preparation` function (details in bismark manual). Example command is:

```
bismark_genome_preparation --path_to_bowtie /usr/local/bowtie/ \
  --verbose /path/to/refgenomes/
```

2. BS-seq alignment. Example command is:

```
bismark -q -n 1 -l 50  --path_to_bowtie \
  /path/bowtie/ BS-refGenome reads.fastq
```

This step will produce two text files `reads.fastq_bismark.sam` and
`reads.fastq_bismark_SE_report.txt`.

3. Extract methylation counts using `bismark_methylation_extractor` function:

```
bismark_methylation_extractor -s --bedGraph reads.fastq_bismark.sam
```

This will create multiple txt files to summarize methylation call and cytosine context,
a bedGraph file to display methylation percentage, and a coverage file containing counts information.
The count file contain following columns: `chr, start, end, methylation%, count methylated, count unmethylated`.
This file can be modified to make the input file for DSS.

A typical DML detection contains two simple steps. First one conduct
DM test at each CpG site, then DML/DMR are called based on the test result
and user specified threshold.

## 3.3 DML/DMR detection from two-group comparison

**Step 1**. Load in library. Read in text files and create an object of `BSseq` class, which is
defined in `bsseq` Bioconductor package.

```
library(DSS)
require(bsseq)
path = file.path(system.file(package="DSS"), "extdata")
dat1.1 = read.table(file.path(path, "cond1_1.txt"), header=TRUE)
dat1.2 = read.table(file.path(path, "cond1_2.txt"), header=TRUE)
dat2.1 = read.table(file.path(path, "cond2_1.txt"), header=TRUE)
dat2.2 = read.table(file.path(path, "cond2_2.txt"), header=TRUE)
BSobj = makeBSseqData( list(dat1.1, dat1.2, dat2.1, dat2.2),
     c("C1","C2", "N1", "N2") )[1:1000,]
BSobj
```

```
## An object of type 'BSseq' with
##   1000 methylation loci
##   4 samples
## has not been smoothed
## All assays are in-memory
```

**Step 2**. Perform statistical test for DML by calling `DMLtest` function.
This function basically performs following steps: (1) estimate mean methylation levels
for all CpG site; (2) estimate dispersions at each CpG sites; (3) conduct Wald test.
For the first step, there’s an option for smoothing or not. Because the methylation levels
show strong spatial correlations, smoothing can often help obtain better estimates
of mean methylation.

To perform DML test without smoothing, do:

```
dmlTest = DMLtest(BSobj, group1=c("C1", "C2"), group2=c("N1", "N2"))
```

To perform statistical test for DML with smoothing, do:

```
dmlTest.sm = DMLtest(BSobj, group1=c("C1", "C2"), group2=c("N1", "N2"),
                     smoothing=TRUE)
```

User has the option to smooth the methylation levels or not.
A simple moving average algorithm is implemented for smoothing.
For WGBS data, smoothing is always recommended
so that information from nearby CpG sites can be combined to improve the estimation of methylation levels.
For data with sparse CpG coverage such as RRBS or hydroxymethylation,
smoothing might not alter the results much, but is still recommended.
In RRBS, CpG sites are likely to be clustered locally within small genomic regions,
so smoothing can potentially help the methylation estimation.

If smoothing is requested, smoothing span is an important parameter which has non-trivial
impact on DMR calling. We use 500 bp as default, because it performs well in real data tests
according to our experience.

**Step 3**. With the test results, one can call DML by using `callDML` function.
The results DMLs are sorted by the significance.

```
  dmls = callDML(dmlTest, p.threshold=0.001)
  head(dmls)
```

```
##       chr     pos        mu1       mu2       diff    diff.se      stat
## 450 chr18 3976129 0.01027497 0.9390339 -0.9287590 0.06544340 -14.19179
## 451 chr18 3976138 0.01027497 0.9390339 -0.9287590 0.06544340 -14.19179
## 638 chr18 4431501 0.01331553 0.9430566 -0.9297411 0.09273779 -10.02548
## 639 chr18 4431511 0.01327049 0.9430566 -0.9297862 0.09270080 -10.02997
## 710 chr18 4564237 0.91454619 0.0119300  0.9026162 0.05260037  17.15988
## 782 chr18 4657576 0.98257334 0.0678355  0.9147378 0.06815000  13.42242
##            phi1       phi2         pval          fdr postprob.overThreshold
## 450 0.052591567 0.02428826 1.029974e-45 2.499403e-43                      1
## 451 0.052591567 0.02428826 1.029974e-45 2.499403e-43                      1
## 638 0.053172411 0.07746835 1.177826e-23 1.429096e-21                      1
## 639 0.053121697 0.07746835 1.125518e-23 1.429096e-21                      1
## 710 0.009528898 0.04942849 5.302004e-66 3.859859e-63                      1
## 782 0.010424723 0.06755651 4.468885e-41 8.133371e-39                      1
```

By default, the test is based on the null hypothesis that the difference in methylation levels is 0.
Alternatively, users can specify a threshold for difference. For example, to
detect loci with difference greater than 0.1, do:

```
  dmls2 = callDML(dmlTest, delta=0.1, p.threshold=0.001)
  head(dmls2)
```

```
##       chr     pos        mu1       mu2       diff    diff.se      stat
## 450 chr18 3976129 0.01027497 0.9390339 -0.9287590 0.06544340 -14.19179
## 451 chr18 3976138 0.01027497 0.9390339 -0.9287590 0.06544340 -14.19179
## 638 chr18 4431501 0.01331553 0.9430566 -0.9297411 0.09273779 -10.02548
## 639 chr18 4431511 0.01327049 0.9430566 -0.9297862 0.09270080 -10.02997
## 710 chr18 4564237 0.91454619 0.0119300  0.9026162 0.05260037  17.15988
## 782 chr18 4657576 0.98257334 0.0678355  0.9147378 0.06815000  13.42242
##            phi1       phi2         pval          fdr postprob.overThreshold
## 450 0.052591567 0.02428826 1.029974e-45 2.499403e-43                      1
## 451 0.052591567 0.02428826 1.029974e-45 2.499403e-43                      1
## 638 0.053172411 0.07746835 1.177826e-23 1.429096e-21                      1
## 639 0.053121697 0.07746835 1.125518e-23 1.429096e-21                      1
## 710 0.009528898 0.04942849 5.302004e-66 3.859859e-63                      1
## 782 0.010424723 0.06755651 4.468885e-41 8.133371e-39                      1
```

When delta is specified, the function will compute the posterior probability that the
difference of the means is greater than delta. So technically speaking,
the threshold for p-value here actually refers to the threshold for 1-posterior probability,
or the local FDR. Here we use the same parameter name for the sake of
the consistence of function syntax.

**Step 4**. DMR detection is also Based on the DML test results, by calling `callDMR` function.
Regions with many statistically significant CpG sites are identified as DMRs.
Some restrictions are provided by users, including the minimum
length, minimum number of CpG sites, percentage of CpG site being significant
in the region, etc. There are some post hoc procedures to merge nearby DMRs into longer ones.

```
dmrs = callDMR(dmlTest, p.threshold=0.01)
head(dmrs)
```

```
##      chr   start     end length nCG meanMethy1 meanMethy2 diff.Methy areaStat
## 27 chr18 4657576 4657639     64   4   0.506453   0.318348   0.188105 14.34236
```

Here the DMRs are sorted by `areaStat`, which is defined in `bsseq`
as the sum of the test statistics of all CpG sites within the DMR.

Similarly, users can specify a threshold for difference. For example, to
detect regions with difference greater than 0.1, do:

```
  dmrs2 = callDMR(dmlTest, delta=0.1, p.threshold=0.05)
  head(dmrs2)
```

```
##      chr   start     end length nCG meanMethy1 meanMethy2 diff.Methy areaStat
## 31 chr18 4657576 4657639     64   4  0.5064530  0.3183480   0.188105 14.34236
## 19 chr18 4222533 4222608     76   4  0.7880276  0.3614195   0.426608 12.91667
```

Note that the distribution of test statistics (and p-values) depends on
the differences in methylation levels and biological variations,
as well as technical factors such as coverage depth. It is very difficulty
to select a natural and rigorous threshold for defining DMRs. We recommend
users try different thresholds in order to obtain satisfactory results.

The DMRs can be visualized using `showOneDMR` function,
This function provides more information than the `plotRegion` function in `bsseq`.
It plots the methylation percentages as well as the coverage depths
at each CpG sites, instead of just the smoothed curve.
So the coverage depth information will be available in the figure.

To use the function, do

```
  showOneDMR(dmrs[1,], BSobj)
```

The result figure looks like the following.
**Note that the figure below is not generated from the above example.
The example data are from RRBS experiment so the DMRs are much shorter.**

![](data:image/png;base64...)

### 3.3.1 Parallel computing for DML/DMR detection from two-group comparison

We implement parallel computing for two-group DML test to speed up the computation.
The parallelism is achieved by specifying the `ncores` parameter in `DMLtest` function,
through the functionalities provided in `parallel` package.
Please see the help for `DMLtest` function for more description and example codes.
Note that older version of DSS (<2.4x) used the `bplapply` function in `BiocParallel`
package. However, that function somehow has significantly reduced
performance in the newer release (>1.25), so we switched to `mcapply`.
A drawback is that the progress bar cannot be displayed under the paralelle computing setting.
Another problem is that users might experience problems using parallel computing on Windows,
since the mcapply function relies on forking but Windows does not support forking.
Thus, we suggest to use ncores=1 on Windows. For more details,
please read the `parallel` package documentation.

We did some simple tests. The figure below shows the time spent in `DMLtest` function,
for different numbers of CpG sites in the data and using different number of cores.
It shows significant improvements using multiple cores.

![](data:image/png;base64...)

## 3.4 DML/DMR detection from general experimental design

In DSS, BS-seq data from a general experimental design (such as crossed experiment,
or experiment with covariates) is modeled through a generalized linear model framework.
We use **arcsine** link function instead of the typical logit link for it better deals with data
at boundaries (methylation levels close to 0 or 1). Linear model fitting is done
through ordinary least square on transformed methylation levels.
Variance/covariance matrices for the estimates are derived with consideration
of count data distribution and transformation.

### 3.4.1 Hypothesis testing in general experimental design

In a general design, the data are modeled through a multiple regression framework,
thus there are several regression coefficients. In contrast, there is only one parameter
in two-group comparison which is the difference between two groups.
Under this type of design, hypothesis testing can be performed for one, multiple,
or any linear combination of the parameters.

DSS provides flexible functionalities for hypothesis testing.
User can test one parameter in the model through a Wald test,
or any linear combination of the parameters through an F-test.

The `DMLtest.multiFactor` function provide interfaces for testing one parameter
(through `coef` parameter), one term in the model (through `term` parameter),
or linear combinations of the parameters (through `Contrast` parameter).
We illustrate the usage of these parameters through a simple example below.
Assume we have an experiment from three strains (A, B, C) and two sexes (M and F),
each has 2 biological replicates (so there are 12 datasets in total).

```
Strain = rep(c("A", "B", "C"), 4)
Sex = rep(c("M", "F"), each=6)
design = data.frame(Strain,Sex)
design
```

```
##    Strain Sex
## 1       A   M
## 2       B   M
## 3       C   M
## 4       A   M
## 5       B   M
## 6       C   M
## 7       A   F
## 8       B   F
## 9       C   F
## 10      A   F
## 11      B   F
## 12      C   F
```

To test the additive effect of Strain and Sex, a design formula is `~Strain+Sex`,
and the corresponding design matrix for the linear model is:

```
X = model.matrix(~Strain+ Sex, design)
X
```

```
##    (Intercept) StrainB StrainC SexM
## 1            1       0       0    1
## 2            1       1       0    1
## 3            1       0       1    1
## 4            1       0       0    1
## 5            1       1       0    1
## 6            1       0       1    1
## 7            1       0       0    0
## 8            1       1       0    0
## 9            1       0       1    0
## 10           1       0       0    0
## 11           1       1       0    0
## 12           1       0       1    0
## attr(,"assign")
## [1] 0 1 1 2
## attr(,"contrasts")
## attr(,"contrasts")$Strain
## [1] "contr.treatment"
##
## attr(,"contrasts")$Sex
## [1] "contr.treatment"
```

Under this design, we can do different tests using the `DMLtest.multiFactor` function:

* If we want to test the sex effect, we can either specify `coef=4`
  (because the 4th column in the design matrix corresponds to sex),
  `coef="SexM"`, or `term="Sex"`. It is important to note that when using character for coef,
  the character must match the column name of the
  design matrix, i.e., one cannot do `coef="Sex"`. It is also important to
  note that using `term="Sex"` only tests a single paramter in the model
  because sex only has two levels.
* If we want to test the effect of Strain B versus Strain A (this is also testing a single parameter),
  we do `coef=2` or `coef="StrainB"`.
* If we want to test the whole Strain effect, it becomes a compound test because Strain has three levels.
  We do `term="Strain"`, which tests `StrainB` and `StrainC` simultaneously.
  We can also make a Contrast matrix L as following. It’s clear that testing \(L^T \beta = 0\) is equivalent
  to testing StrainB=0 and StrainC=0.

```
L = cbind(c(0,1,0,0),c(0,0,1,0))
L
```

```
##      [,1] [,2]
## [1,]    0    0
## [2,]    1    0
## [3,]    0    1
## [4,]    0    0
```

* One can perform more general test, for example, to test StrainB=StrainC,
  or that strains B and C has no difference (but they could be different from Strain A).
  In this case, we need to make following contrast matrix:

```
matrix(c(0,1,-1,0), ncol=1)
```

```
##      [,1]
## [1,]    0
## [2,]    1
## [3,]   -1
## [4,]    0
```

### 3.4.2 Example analysis for data from general experimental design

**Step 1**. Load in data distributed with `DSS`. This is a small portion of a set of
RRBS experiments. There are 5000 CpG sites and 16 samples.
The experiment is a \(2\times2\) design (2 cases and 2 cell types).
There are 4 replicates in each case-by-cell combination.

```
data(RRBS)
RRBS
```

```
## An object of type 'BSseq' with
##   5000 methylation loci
##   16 samples
## has not been smoothed
## All assays are in-memory
```

```
design
```

```
##    case cell
## 1    HC   rN
## 2    HC   rN
## 3    HC   rN
## 4   SLE   aN
## 5   SLE   rN
## 6   SLE   aN
## 7   SLE   rN
## 8   SLE   aN
## 9   SLE   rN
## 10  SLE   aN
## 11  SLE   rN
## 12   HC   aN
## 13   HC   aN
## 14   HC   aN
## 15   HC   aN
## 16   HC   rN
```

**Stepp 2**. Fit a linear model using `DMLfit.multiFactor` function, include
case, cell, and case by cell interaction. Similar to in a multiple regression,
the model only needs to be fit once, and then the parameters can be tested
based on the model fitting results.

```
DMLfit = DMLfit.multiFactor(RRBS, design=design, formula=~case+cell+case:cell)
```

```
## Fitting DML model for CpG site:
```

**Step 3**. Use `DMLtest.multiFactor` function to test the cell effect.
It is important to note that the `coef` parameter is the index
of the coefficient to be tested for being 0. Because the model
(as specified by `formula` in `DMLfit.multiFactor`) include intercept,
the cell effect is the 3rd column in the design matrix, so we use
`coef=3` here.

```
DMLtest.cell = DMLtest.multiFactor(DMLfit, coef=3)
```

Alternatively, one can specify the name of the parameter to be tested.
In this case, the input `coef` is a character, and it must match one of
the column names in the design matrix. The column names of the design matrix
can be viewed by

```
colnames(DMLfit$X)
```

```
## [1] "(Intercept)"    "caseSLE"        "cellrN"         "caseSLE:cellrN"
```

The following line also works. Specifying `coef="cellrN"` is the same as
specifying {coef=3}.

```
DMLtest.cell = DMLtest.multiFactor(DMLfit, coef="cellrN")
```

Result from this step is a data frame with chromosome number, CpG site position,
test statistics, p-values (from normal distribution), and FDR.
Rows are sorted by chromosome/position of the CpG sites.
To obtain top ranked CpG sites, one can sort the data frame using following codes:

```
ix=sort(DMLtest.cell[,"pvals"], index.return=TRUE)$ix
head(DMLtest.cell[ix,])
```

```
##       chr     pos     stat        pvals         fdrs
## 1273 chr1 2930315 5.280301 1.289720e-07 0.0006448599
## 4706 chr1 3321251 5.037839 4.708164e-07 0.0011770409
## 3276 chr1 3143987 4.910412 9.088510e-07 0.0015147517
## 2547 chr1 3069876 4.754812 1.986316e-06 0.0024828953
## 3061 chr1 3121473 4.675736 2.929010e-06 0.0029290097
## 527  chr1 2817715 4.441198 8.945925e-06 0.0065858325
```

\*\*Step 4\*. DMRs for multifactor design can be called using {callDMR} function:

```
callDMR(DMLtest.cell, p.threshold=0.05)
```

```
##      chr   start     end length nCG   areaStat
## 33  chr1 2793724 2793907    184   5  12.619968
## 413 chr1 3309867 3310133    267   7 -12.093850
## 250 chr1 3094266 3094486    221   4  11.691413
## 262 chr1 3110129 3110394    266   5  11.682579
## 180 chr1 2999977 3000206    230   4  11.508302
## 121 chr1 2919111 2919273    163   4   9.421873
## 298 chr1 3146978 3147236    259   5   8.003469
## 248 chr1 3090627 3091585    959   5  -7.963547
## 346 chr1 3200758 3201006    249   4  -4.451691
## 213 chr1 3042371 3042459     89   5   4.115296
## 169 chr1 2995532 2996558   1027   4  -2.988665
```

Note that for results from for multifactor design, {delta} is NOT supported.
This is because in multifactor design, the estimated
coefficients in the regression are based on a GLM framework (loosely
speaking), thus they don’t have clear meaning of methylation level
differences. So when the input DMLresult is from {DMLtest.multiFactor},
{delta} cannot be specified.

### 3.4.3 More flexible way to construct a hypothesis test

Following 4 tests should produce the same results, since ‘case’ only has two levels.
However the p-values from F-tests (using term or Contrast) are
slightly different, due to normal approximation in Wald test.

```
## fit a model with additive effect only
DMLfit = DMLfit.multiFactor(RRBS, design, ~case+cell)
```

```
## Fitting DML model for CpG site:
```

```
## test case effect
test1 = DMLtest.multiFactor(DMLfit, coef=2)
test2 = DMLtest.multiFactor(DMLfit, coef="caseSLE")
test3 = DMLtest.multiFactor(DMLfit, term="case")
Contrast = matrix(c(0,1,0), ncol=1)
test4 = DMLtest.multiFactor(DMLfit, Contrast=Contrast)
cor(cbind(test1$pval, test2$pval, test3$pval, test4$pval))
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    1    1    1
## [2,]    1    1    1    1
## [3,]    1    1    1    1
## [4,]    1    1    1    1
```

The model fitting and hypothesis test procedures are computationally very efficient.
For a typical RRBS dataset with 4 million CpG sites,
it usually takes less than half hour. In comparison, other similar software such as RADMeth or BiSeq
takes at least 10 times longer.

### 3.4.4 For paired design

DSS can handle paired design using a **fixed effect model**.
To be specific, assuming you have a design with 3 control and 3 treated samples,
and the control and treated samples are paired.
The design data frame will be constructed as the following.
**It’s important to make the pair information as factor**.

```
Treatment = factor(rep(c("Control","Treated"), 3))
pair = factor( rep(1:3, each=2) )
design = data.frame(Treatment, pair)
design
```

```
##   Treatment pair
## 1   Control    1
## 2   Treated    1
## 3   Control    2
## 4   Treated    2
## 5   Control    3
## 6   Treated    3
```

To fit the model, “pair” variable needs to be included in the formula.
Then the treatment effect can be tested adjusted for pairing.
Note, the following is for illustration purpose only since the data
are not really paired. The input
`BSobj` needs to match the dimension of `design`, i.e.,
the number of samples in `BSobj` should equal to the number of
rows of `design`.

```
BSobj=RRBS[,1:6]
DMLfit = DMLfit.multiFactor(BSobj, design, formula = ~ Treatment + pair)
dmlTest = DMLtest.multiFactor(DMLfit, term="Treatment")
```

Moreover, datasets with repeated measurements (such as longituinal data)
can be analyzed using similar fashion under fixed effect model.
We acknowledge that mixed effect models are potentially more efficient,
but we have not implemented mixed model in DSS.

# 4 Frequently Asked Questions

## 4.1 For BS-seq data analysis

**Q: Do I need to filter out CpG sites with low or no coverage?**

A: No. DSS will take care of the coverage depth information.
The depth will be factored into the statistical computation.

**Q: Can I use estimated methylation levels (beta values) with DSS?**

A: No. DSS only takes count data. I don’t recommend compute methylation levels out of the counts
and then use the point estimates as input, since that will complete ignore the
sequencing depth information. For example, 1 out 2 and 100 out of 200 both give 50% methylation level,
but the precision of the point estimates are very different.

**Q: Should I always do smoothing, even for RRBS data?**

A: Smoothing is always recommended, even for RRBS. In RRBS, CpG sites are likely to be clustered
locally within small genomic regions, so smoothing will still help to improve the methylation estimation.

**Q: Why doesn’t `DMLtest.multiFactor` function return the relative methylation levels?**

A: There are several reasons. First, in functions for general design, we use arcsin
link function with a multiple regression setting, thus the estimated regression coefficients
are not relative methylation levels. Returning these values will not be very meaningful.
Secondly, the relative methylation levels in a multiple regression setting is a
quantity to difficult to comprehend for user without formal statistical training.
It is similar to a multiple regression, where the interpretation of the
coefficient is something like “the change of Y with 1 unit increase of X,
adjusting for other covariates”. Considering X can be anything (even continuous),
we don’t feel there is a clear definition of relative methylation level,
unlike in two-group comparison setting.
Due to these reasons, we decided not to compute and return those values.

**Q: Why doesn’t callDMR function return FDR for identified DMRs?**

A: In DMR calling, the statistical test is perform for each CpG, and then the significant CpG are
merged into regions. It is very difficult to estimate FDR at the
region-level, based on the site level test results (p-values or FDR).
This is a difficult question for all types of genome-wide assays such as the ChIP-seq.
So I rather not to report a DMR-level FDR if it’s not accurate.

**Q: What’s the meaning of areaStat parameter?**

A: We adapt that from the `bsseq` package. It is the sum of the
test statistics of all CpG sites within a DMR.
It doesn’t have a direct biological meaning. One can imagine when we try to rank the DMRs,
we don’t know whether the height or the width is more important?
AreaStat is a combination of the two. This is an ad hoc way to rank DMRs,
but larger AreaStat is more likely to be a DMR

**Q: How can I get genome annotation (like the nearby genes) for the DMRs?**

A: DSS doesn’t provide this functionality. There are many other tools can do this,
for example, HOMER.

**Q: What’s the memory requirement for DSS?**

A: It is really difficult to tell. According to my experience,
a whole genome BS-seq dataset with 20+ million CpG sites and 4 samples
can run on my laptop with 16G RAM. I once used DelayedArray in DSS
to reduce the memory usage. But it makes the computation significantly slower so I changed back.

**Q: How to consider the batch effect with DSS?**

A: I think the best strategy will be using the multifactor functions
with batch as a covariate in the model.

**Q: Does DSS work for survival data?**

A. No. But these are on our future development plan.

# 5 Session Info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] edgeR_4.8.0                 limma_3.66.0
##  [3] DSS_2.58.0                  bsseq_1.46.0
##  [5] SummarizedExperiment_1.40.0 MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocParallel_1.44.0
## [13] Biobase_2.70.0              BiocGenerics_0.56.0
## [15] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rjson_0.2.23              xfun_0.53
##  [3] bslib_0.9.0               rhdf5_2.54.0
##  [5] lattice_0.22-7            bitops_1.0-9
##  [7] rhdf5filters_1.22.0       tools_4.5.1
##  [9] curl_7.0.0                R.oo_1.27.1
## [11] Matrix_1.7-4              data.table_1.17.8
## [13] BSgenome_1.78.0           RColorBrewer_1.1-3
## [15] cigarillo_1.0.0           sparseMatrixStats_1.22.0
## [17] lifecycle_1.0.4           compiler_4.5.1
## [19] farver_2.1.2              Rsamtools_2.26.0
## [21] Biostrings_2.78.0         statmod_1.5.1
## [23] codetools_0.2-20          permute_0.9-8
## [25] htmltools_0.5.8.1         sass_0.4.10
## [27] RCurl_1.98-1.17           yaml_2.3.10
## [29] crayon_1.5.3              jquerylib_0.1.4
## [31] R.utils_2.13.0            DelayedArray_0.36.0
## [33] cachem_1.1.0              abind_1.4-8
## [35] gtools_3.9.5              locfit_1.5-9.12
## [37] digest_0.6.37             restfulr_0.0.16
## [39] bookdown_0.45             splines_4.5.1
## [41] fastmap_1.2.0             grid_4.5.1
## [43] cli_3.6.5                 SparseArray_1.10.0
## [45] S4Arrays_1.10.0           XML_3.99-0.19
## [47] dichromat_2.0-0.1         h5mread_1.2.0
## [49] DelayedMatrixStats_1.32.0 scales_1.4.0
## [51] httr_1.4.7                rmarkdown_2.30
## [53] XVector_0.50.0            R.methodsS3_1.8.2
## [55] beachmat_2.26.0           HDF5Array_1.38.0
## [57] evaluate_1.0.5            knitr_1.50
## [59] BiocIO_1.20.0             rtracklayer_1.70.0
## [61] rlang_1.1.6               Rcpp_1.1.0
## [63] glue_1.8.0                BiocManager_1.30.26
## [65] jsonlite_2.0.0            R6_2.6.1
## [67] Rhdf5lib_1.32.0           GenomicAlignments_1.46.0
```

# References

Feng, Hao, Karen N Conneely, and Hao Wu. 2014. “A Bayesian Hierarchical Model to Detect Differentially Methylated Loci from Single Nucleotide Resolution Sequencing Data.” *Nucleic Acids Research* 42 (8): e69–e69.

Park, Yongseok, and Hao Wu. 2016. “Differential Methylation Analysis for Bs-Seq Data Under General Experimental Design.” *Bioinformatics* 32 (10): 1446–53.

Wu, Hao, Chi Wang, and Zhijin Wu. 2012. “A New Shrinkage Estimator for Dispersion Improves Differential Expression Detection in Rna-Seq Data.” *Biostatistics* 14 (2): 232–43.

Wu, Hao, Tianlei Xu, Hao Feng, Li Chen, Ben Li, Bing Yao, Zhaohui Qin, Peng Jin, and Karen N Conneely. 2015. “Detection of Differentially Methylated Regions from Whole-Genome Bisulfite Sequencing Data Without Replicates.” *Nucleic Acids Research* 43 (21): e141–e141.