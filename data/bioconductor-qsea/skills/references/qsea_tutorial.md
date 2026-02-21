# QSEA Tutorial

Matthias Lienhard, Lukas Chavez and Ralf Herwig

#### 30 October 2025

#### Abstract

QSEA (quantitative sequencing enrichment analysis) was developed as the successor of the MEDIPS package for analyzing data derived from methylated DNA immunoprecipitation (MeDIP) experiments followed by sequencing (MeDIP-seq). However, qsea provides functionality for the analysis of other kinds of quantitative sequencing data (e.g. ChIP-seq, MBD-seq, CMS-seq and others) including calculation of differential enrichment between groups of samples.

#### Package

qsea 1.36.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 QSEA workflow](#qsea-workflow)
  + [3.1 Preparation and import of short reads](#preparation-and-import-of-short-reads)
* [References](#references)

# 1 Introduction

QSEA stands for “Quantitative Sequencing Enrichment Analysis” and implements
a statistical framework for modeling and transformation of MeDIP-seq enrichment
data to absolute methylation levels similar to BS-sequencing read-outs.
Furthermore, QSEA comprises functionality for data normalization that accounts
for the effect of CNVs on the read-counts as well as for the detection and
annotation of differently methylated regions (DMRs).
The transformation is based on a Bayesian model, that explicitly takes
background reads and CpG density dependent enrichment profiles
of the experiments into account.

# 2 Installation

To install the QSEA package in your R environment, start R and enter:

```
BiocManager::install("qsea")
```

Next, it is necessary to have the genome of interest
available in your R environment.
As soon as you have the *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* package installed and the
library loaded using

```
BiocManager::install("BSgenome")
library("BSgenome")
```

you can list all available genomes by typing

```
available.genomes()
```

In case a genome of interest is not available as a BSgenome
package but the sequence of the genome is available,
a custom BSgenome package can be generated, please see the
“How to forge a BSgenome data package” manual of the *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* package.

In the given example, we mapped the short
reads against the human genome build hg19.
Therefore, we download and install this genome build:

```
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
```

This takes some time, but has to be done only once for each reference genome.

In order to specify genomic regions of interest,
QSEA utilitzes the GenomicRanges package

```
BiocManager::install("GenomicRanges")
```

Finally, the QSEA work flow described below requires access to example data
available in the *[MEDIPSData](https://bioconductor.org/packages/3.22/MEDIPSData)* package which can be installed by typing:

```
BiocManager::install("MEDIPSData")
```

# 3 QSEA workflow

Here, we show the most important steps of the QSEA work-flow for the analysis of
MeDIP seq data. We assume that the reads have been aligned to reference genome hg19
and are on hand in .bam format.

## 3.1 Preparation and import of short reads

In order to describe the samples, we must provide
a data.frame object with at least 3 columns:

* sample\_name: unique names of the samples,
* file\_name: path to the alignment files of MeDIP seq, typically bam files
* group: assignment of samples to groups, such as “treatment” and “control”.

Further columns describing the samples are optional, and can be considered
in downstream analysis:

* sex: if provided, the number of sex chromosomes is taken into account.
* input files: If sequencing of the input libraries (before enrichment) are
  available, this data can be used in the addCNV function, by specifying the respective column.
* alternative group arrangements or clinical data can be used in the statistical
  test, or when creating result tables.

To demonstrate the QSEA analysis steps,
we use data available in the *[MEDIPSData](https://bioconductor.org/packages/3.22/MEDIPSData)* package.
This package contains aligned MeDIP seq data for chromosomes 20, 21 and 22 of 3 NSCLC
tumor samples and adjacent normal tissue.

```
data(samplesNSCLC, package="MEDIPSData")
knitr::kable(samples_NSCLC)
```

| sample\_name | file\_name | group | sex |
| --- | --- | --- | --- |
| 1T | NSCLC\_MeDIP\_1T\_fst\_chr\_20\_21\_22.bam | Tumor | male |
| 1N | NSCLC\_MeDIP\_1N\_fst\_chr\_20\_21\_22.bam | Normal | male |
| 2T | NSCLC\_MeDIP\_2T\_fst\_chr\_20\_21\_22.bam | Tumor | female |
| 2N | NSCLC\_MeDIP\_2N\_fst\_chr\_20\_21\_22.bam | Normal | female |
| 3T | NSCLC\_MeDIP\_3T\_fst\_chr\_20\_21\_22.bam | Tumor | female |
| 3N | NSCLC\_MeDIP\_3N\_fst\_chr\_20\_21\_22.bam | Normal | female |

```
path=system.file("extdata", package="MEDIPSData")
samples_NSCLC$file_name=paste0(path,"/",samples_NSCLC$file_name )
```

Now, the QSEA package has to be loaded.

```
library(qsea)
```

To access information of the reference genome, we load the pre-installed
(see chapter [Installation](#hg19install)) hg19 library:

```
library(BSgenome.Hsapiens.UCSC.hg19)
```

All relevant information of the enrichment experiment, including
sample information, the genomic read coverage, CpG density and other
parameters are stored in a “qseaSet” object.
To create such an object, call the function “createQseaSet”,
that takes the following parameters:

* BSgenome: The reference genome name as defined by BSgenome. (required)
* window\_size: defines the genomic resolution by which
  short read coverage is calculated. (default:250 bases)
* chr.select: Only data at the specified
  chromosomes will be processed. (default: NULL=all chromosomes)
* Regions: If specified, only data in the specified
  regions will be processed.

```
qseaSet=createQseaSet(sampleTable=samples_NSCLC,
        BSgenome="BSgenome.Hsapiens.UCSC.hg19",
        chr.select=paste0("chr", 20:22),
        window_size=500)
## ==== Creating qsea set ====
## restricting analysis on chr20, chr21, chr22
## Dividing selected chromosomes of BSgenome.Hsapiens.UCSC.hg19 in 500nt windows
qseaSet
## qseaSet
## =======================================
## 6 Samples:
## 1T, 1N, 2T, 2N, 3T, 3N
## 324919 Regions in 3 chromosomes of BSgenome.Hsapiens.UCSC.hg19
```

We now read the alignment files and compute the MeDIP coverage for each window.
For this step, we have to specify the following parameters:

* qs: the QSEA set, as prepared in the step above
* uniquePos: if set, fragments at the exact same start and end position are
  considered to be PCR duplicates and replaced by one representative
* minMapQual: minimum mapping quality for a read to be considered.
  Commonly, a mapping quality of 0 reflects ambigious alignments in
  most alignment tools.
* paired: if set, reads are considered to be paired end. In this case, exact
  fragment sizes are imported.
* fragment\_size: for single end sequencing data (paired=FALSE), this parameter
  provides the fragment size.

```
qseaSet=addCoverage(qseaSet, uniquePos=TRUE, paired=TRUE)
```

##Normalization

###Copy Number Variation
The QSEA model can consider Copy Number Variation (CNV), and account for their
influence on MeDIP read density.
CNV can either be computed externally and imported into QSEA,
or estimated directly within QSEA.
QSEA internally uses the bioconductor package *[HMMcopy](https://bioconductor.org/packages/3.22/HMMcopy)*
to estimate CNV from sequencing data of the input library,
or from the MeDIP library (parameter “MeDIP”=TRUE).
In the latter case, only fragments that do not contain CpG dinucleotides are considered.

Externally computed CNVs can be imported with the addCNV function
by specifying the “cnv” parameter:

* cnv: externally computed CNVs as a GRange object, containing a metadata
  column with log2 CNV values (relative to normal Copy Number).
  for each sample in the analysis.
  The names of the columns must match the sample names, as specified in the sample table.

If no “cnv” object is provided, the following parameters control the internal
CNV analysis:

* file\_name: specify the column in the sample table, containing the sequencing
  alignment files, to be used for the CNV analysis.
* window\_size: window size used for the CNV analysis.
* paired, “fragment\_size”: see addCoverage step above
* mu: Suggested median for copy numbers in states, see HMMcopy::HMMsegment
* normal\_idx: samples, that presumably do not have copy number variations.
  By default, samples grouped as “normal” or “control” in the sample table
  are selected,
* MeDIP: Estimate CNV from CpG methylation enriched sequencing data
  (e.g. MeDIP seq)
* plot\_dir: optionally, chromosome wise CNV plots are generated in the specified
  directory

```
qseaSet=addCNV(qseaSet, file_name="file_name",window_size=2e6,
        paired=TRUE, parallel=FALSE, MeDIP=TRUE)
```

Note, that CNV estimation will benefit from analysing the whole genome.
For this step, limiting the estimation to single chromosomes is not recommendable
in general.

###Scaling Library Factor
QSEA accounts for differences in sequencing depth and library
composition by estimating the effective library size
for each sample using the trimmed mean of m-values approach
(TMM, Robinson and Oshlack [2010](#ref-robinson2010)).
Alternatively, QSEA can import user provided normalization factors, using
the “factors” parameter in addLibraryFactors.

```
qseaSet=addLibraryFactors(qseaSet)
```

###Estimating model parameters for transformation to absolute methylation values

As MeDIP seq read coverage is dependent on the CpG density of the fragment,
we estimate the average CpG density per fragment for each genomic window.

```
qseaSet=addPatternDensity(qseaSet, "CG", name="CpG")
```

From the regions without CpGs we can estimate the coverage
offset from background reads.

```
qseaSet = addOffset(qseaSet, enrichmentPattern = "CpG")
## selecting windows with low CpG density for background read estimation
## 1.511% of the windows have enrichment pattern density of at most 0.01 per fragment
## and are used for background reads estimation
```

In order to estimate the relative enrichment, we need to model the
enrichment efficiency, which is dependent on the CpG density.
The parameters for this model can be estimated using the
addEnrichmentParameters() function.
For this task we need to provide known values for a subset of windows,
for example gained by validation experiments or from other studies.
QSEA then fits a sigmoidal function to these values, in order to smooth
and extrapolate the provided values.
The enrichment parameters, together with the estimated offset of background
reads are applied in the transformation to absolute methylation values.

For the example dataset, we can make use of methylation data from the
TCGA lung adenocarcinoma (LUAD, Collisson EA [2014](#ref-TCGA_LUAD) ) and squamous cell carcinoma
(LUSC, Hammerman et al. [2012](#ref-TCGA_LUSC)) studies. For this purpose, DNA methylation datasets
have been downloaded from <https://gdc.cancer.gov/>, and averaged in 500 base
windows, and filtered for highly methylated windows across all samples.
The relevant chromosomes of this data is contained in the “tcga\_lung” object
of the *[MEDIPSData](https://bioconductor.org/packages/3.22/MEDIPSData)* package.

```
data(tcga_luad_lusc_450kmeth, package="MEDIPSData")

wd=findOverlaps(tcga_luad_lusc_450kmeth, getRegions(qseaSet), select="first")
signal=as.matrix(mcols(tcga_luad_lusc_450kmeth)[,rep(1:2,3)])
qseaSet=addEnrichmentParameters(qseaSet, enrichmentPattern="CpG",
    windowIdx=wd, signal=signal)
```

In case such information is not available for the analyzed data set,
the enrichment model can be calibrated using rough estimates
(“blind calibration”).
For instance, in adult tissue samples, we can assume high methylation at
regions with low CpG density, and linearly decreasing average methylation
levels for higher CpG density.
However, for different types of samples, such as cell lines or embryonic cells,
these assumptions would be a poor fit and lead to false results.

```
wd=which(getRegions(qseaSet)$CpG_density>1 &
    getRegions(qseaSet)$CpG_density<15)
signal=(15-getRegions(qseaSet)$CpG_density[wd])*.55/15+.25
qseaSet_blind=addEnrichmentParameters(qseaSet, enrichmentPattern="CpG",
    windowIdx=wd, signal=signal)
```

##Quality control
In order to review the quality of the MeDIP enrichment and the model assumptions,
made in the previous steps, we can check the model parameters estimated by QSEA,
which describe the signal to noise ratio, and the enrichment efficiency.
At first, we check the estimated fraction of background reads:

```
getOffset(qseaSet, scale="fraction")
##         1T         1N         2T         2N         3T         3N
## 0.13407727 0.10738857 0.11573308 0.09726356 0.10060349 0.10387696
```

This reveals, that between 9% and 13% of the fragments are due to the
background rather than enrichment. High values (e.g. > 0.9) would
indicate a lack of enrichment efficiency.

To examine the the sample-wise CpG density dependent enrichment profiles,
as estimated by addEnrichmentParameters(), QSEA provides the plotEPmatrix()
function:

```
plotEPmatrix(qseaSet)
## 1T
## 1N
## 2T
## 2N
## 3T
## 3N
```

![CpG density dependent Enrichment Profiles](data:image/png;base64...)

Figure 1: CpG density dependent Enrichment Profiles

The average enrichment, observed in the provided “signal”, is depicted in
black, and the fitted sigmoidal function in green. Samples with flat profiles
might indicate low enrichment efficiency,
or poor agreement with the calibration data.

##Exploratory Analysis

In order to analyze the main characteristics of the data, and to visualize
the relationships between the samples, QSEA provides a set of tools for
exploratory data analysis.

The plotCNV() function provides a genome wide overview on CNV.
Deletations are depicted in green shades, while amplifications are green, and
normal copy numbers are blue. Each sample is represented as a row,
which is ordered based on the similarity of CNV profiles.

```
plotCNV(qseaSet)
```

![Overview representation of Copy Number Variation](data:image/png;base64...)

Figure 2: Overview representation of Copy Number Variation

This plot shows, that one half of chr 20 is amplified in sample 2T, while a large part of
chr21 is deleted in sample 1T. The other samples, including 3T, have normal copy numbers.
Regions without information (e.g. that are masked in the reference) are represented in gray.

To explore the relationship between samples,
a principal component plot can be intuitive.
By default, principal component analysis (PCA) is computed based on
log transformed normalized count values.
In order to use the transformation to absolute methylation values, the
“norm\_method” parameter is set to “beta”.
To get an impression of the effects on different levels of annotation,
the PCA can be restricted on regions
of interest, provided as a GRanges object. To demonstrate this feature, we
import an annotation object, containing different UCSC annotation tracks.
To obtain CpG Island promoter regions, we intersect CpG Islands with
transcription start sites(TSS).

```
data(annotation, package="MEDIPSData")
CGIprom=intersect(ROIs[["CpG Island"]], ROIs[["TSS"]],ignore.strand=TRUE)
pca_cgi=getPCA(qseaSet, norm_method="beta", ROIs=CGIprom)
col=rep(c("red", "green"), 3)
plotPCA(pca_cgi, bg=col, main="PCA plot based on CpG Island Promoters")
```

![](data:image/png;base64...)

In this plot, we can that DNA methylation is different between
Tumor and Normal samples, and that the Tumor samples are a heterogeneous group,
while the Normal samples cluster tightly together.

##Differential Methylation Analysis
Differential Methylation Analysis in QSEA is based on generalized linear models
(GLMs), and a likelihood ratio test, similar to tests performed to detect
deferentially expressed genes, implemented in *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* or
*[edgeR](https://bioconductor.org/packages/3.22/edgeR)*.
Briefly, we model read counts with a negative binomial distribution with mean
and dispersion parameter. For each window, we fit a GLM with logarithmic link
function.
For significance testing, we fit a reduced model, and compare the
likelihood ratio (LR) of the models to a Chi-squared distribution.
These steps are implemented in the following functions:

```
design=model.matrix(~group, getSampleTable(qseaSet) )
qseaGLM=fitNBglm(qseaSet, design, norm_method="beta")
qseaGLM=addContrast(qseaSet,qseaGLM, coef=2, name="TvN" )
```

At fist, the model matrix (“design”) for the full model is defined,
using the group column of the sample table. The model contains two coeficients:
an intercept, and a dummy variable, distinguishing between “Normal” and “Tumor”.
“fitNBglm” simultaneously fits the dispersion parameters and the model coefficients
for the full model. In the next step, “addContrast” fits a model, reduced by the 2nd
component (thus, only intercept remains). In addition, the likelihood ratio test
is performed. All results are stored in a QSEA GLM object. Note, that one GLM object can
contain several contrasts and test results (for more complex experimental designs).

##Annotating, Exploring and Exporting Results

We can now create a results table with raw counts
(\_reads) estimated % methylation values (\_beta),
as well as an 95% credibility interval [\_betaLB, \_betaUB]
for the estimates for all deferentially methylated windows.
“isSignificant” selects windows below the defined significance threshold.

```
library(GenomicRanges)
sig=isSignificant(qseaGLM, fdr_th=.01)
## selecting regions from contrast TvN
## selected 1006/169189 windows

result=makeTable(qseaSet,
    glm=qseaGLM,
    groupMeans=getSampleGroups(qseaSet),
    keep=sig,
    annotation=ROIs,
    norm_method="beta")
## adding test results from TvN
## obtaining raw values for 6 samples in 1006 windows
## deriving beta values...
## adding annotation
## creating table...
knitr::kable(head(result))
```

| chr | window\_start | window\_end | CpG\_density | gene body | exon | intron | TSS | TFBS | CpG Island | TvN\_log2FC | TvN\_pvalue | TvN\_adjPval | Normal\_beta\_means | Tumor\_beta\_means |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr20 | 592501 | 593000 | 3.821083 |  |  |  |  |  |  | 2.586027 | 0.00e+00 | 0.0000128 | 0.2528913 | 0.8372013 |
| chr20 | 644501 | 645000 | 29.940668 | SCRT2 | 2 |  |  | EZH2, GABPA, SUZ12, USF1 | yes | 3.392660 | 2.20e-06 | 0.0008549 | 0.0168942 | 0.1607370 |
| chr20 | 645001 | 645500 | 13.798166 | SCRT2 | 2 | yes |  | EZH2 | yes | 2.397406 | 1.73e-05 | 0.0040450 | 0.1539132 | 0.7086153 |
| chr20 | 749001 | 749500 | 4.807033 | SLC52A3 | 1 |  | yes | POLR2A, STAT3, ZNF263, MYC, BHLHE40, MAZ, CTCF, RAD21, SMC3 |  | -2.780616 | 3.19e-05 | 0.0064917 | 0.5087188 | 0.0755328 |
| chr20 | 822001 | 822500 | 13.225572 | FAM110A |  | yes |  | YY1, POLR2A, HDAC2, TAF1, CEBPB, GABPA, NR2C2, BACH1, E2F1 | yes | -3.083029 | 7.00e-07 | 0.0003581 | 0.3007324 | 0.0586008 |
| chr20 | 822501 | 823000 | 14.196844 | FAM110A |  | yes |  | BACH1, E2F1, TCF7L2, MEF2A, CEBPB, RBBP5, ZNF217, POLR2A, RAD21, CTCF, EP300, MYC, SP1, GATA3, FOXA1, ESR1 | yes | -3.801025 | 0.00e+00 | 0.0000001 | 0.3556845 | 0.0454443 |

The makeTable function is implemented quite generically, and provides the
following options, to specify the regions and the content of the table:

* norm\_methods: a vector of normalization method names. Valid names include
  \*\* counts: raw (un-normalized) read counts.
  \*\* nrpkm: CNV normalized reads per kilobase (genomic window) per million mapped reads.
  \*\* beta: transformation to absolute methylation.
* samples: sample names to be included in the table as individual columns.
* groupMeans: named list of sample names, that are summarized as group averages.
* glm: optional argument, to include test statistics in the result table.
* keep: vector of window ids, as obtained by isSignificant()
* ROIs: GRange object defining regions of interest, to which the result table will be restricted.
* annotation: A named list of GRange objects, containing genomic annotations.

To assess the enrichment of differentially methylated regions within
genomic annotations, the regionsStats() functions

```
sigList=list(gain=isSignificant(qseaGLM, fdr_th=.1,direction="gain"),
             loss=isSignificant(qseaGLM, fdr_th=.1,direction="loss"))
## selecting regions from contrast TvN
## selected 725/169189 windows
## selecting regions from contrast TvN
## selected 2842/169189 windows
roi_stats=regionStats(qseaSet, subsets=sigList, ROIs=ROIs)
## getting numbers of overlaps with total qs
## getting numbers of overlaps with gain
## getting numbers of overlaps with loss
knitr::kable(roi_stats)
```

|  | total | gain | loss |
| --- | --- | --- | --- |
| all Regions | 324919 | 725 | 2842 |
| gene body | 127838 | 478 | 972 |
| exon | 20266 | 188 | 194 |
| intron | 122332 | 400 | 919 |
| TSS | 1870 | 29 | 26 |
| TFBS | 84727 | 601 | 940 |
| CpG Island | 9672 | 337 | 180 |

```
roi_stats_rel=roi_stats[,-1]/roi_stats[,1]
x=barplot(t(roi_stats_rel)*100,ylab="fraction of ROIs[%]",
    names.arg=rep("", length(ROIs)+1),  beside=TRUE, legend=TRUE,
    las=2, args.legend=list(x="topleft"),
    main="Feature enrichment Tumor vs Normal DNA methylation")
text(x=x[2,],y=-.15,labels=rownames(roi_stats_rel), xpd=TRUE, srt=30, cex=1, adj=c(1,0))
```

![](data:image/png;base64...)
As expected for tumor samples, hypomethylated regions are more
frequent genome wide, while CpG islands are enriched for hypermethylation.

If we are interested in a particular genomic region, it can be depicted
in a genome browser like manner as follows:
(find a more interesting example, add annotations …)

```
plotCoverage(qseaSet, samples=getSampleNames(qseaSet),
    chr="chr20", start=38076001, end=38090000, norm_method="beta",
    col=rep(c("red", "green"), 3), yoffset=1,space=.1, reorder="clust",
    regions=ROIs["TFBS"],regions_offset=.5, cex=.7 )
## selecting specified Region
## selecting specified ROIs
## obtaining raw values for 6 samples in 28 windows
## deriving beta values...
## creating table...
## TFBS
```

![](data:image/png;base64...)

#Parallelization

A large part of the run time is required for processing the alignment files.
These steps can be parallelized using the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package:

```
library("BiocParallel")
register(MulticoreParam(workers=3))
qseaSet=addCoverage(qseaSet, uniquePos=TRUE, paired=TRUE, parallel=TRUE)
```

The “parallel” parameter is also available for the addCNV function.
Note, that for parallel scanning of files,
reading speed might be a limiting factor.

# References

Collisson EA, Brooks AN, Campbell JD. 2014. “Comprehensive molecular profiling of lung adenocarcinoma.” *Nature* 511 (7511): 543–50.

Hammerman, P. S., M. S. Lawrence, D. Voet, R. Jing, K. Cibulskis, A. Sivachenko, P. Stojanov, et al. 2012. “Comprehensive genomic characterization of squamous cell lung cancers.” *Nature* 489 (7417): 519–25.

Robinson, Mark D, and Alicia Oshlack. 2010. “A Scaling Normalization Method for Differential Expression Analysis of Rna-Seq Data.” *Genome Biology*, March.