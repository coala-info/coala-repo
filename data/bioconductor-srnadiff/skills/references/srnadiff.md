# “Finding differentially expressed unannotated genomic regions from RNA-seq data with srnadiff”

Matthias Zytnicki and Ignacio González

#### 30 October 2025

#### Package

srnadiff 1.30.0

# 1 Version info

* **R version**: R version 4.5.1 Patched (2025-08-23 r88802)
* **Bioconductor version**: 3.22
* **Package version**: 1.30.0

# 2 Abstract

*[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* is an *R* package that finds differently expressed
regions from RNA-seq data at *base-resolution* level without relying
on existing annotation. To do so, the package implements the
*identify-then-annotate* methodology that builds on the idea of
combining two pipelines approach: differential expressed regions detection
and differential expression quantification.

# 3 Introduction

There is no real method for finding differentially expressed short RNAs. The
most used method focusses on miRNAs, and only uses a standard RNA-Seq pipe-line
on these genes.

However, annotated tRF, siRNAs, piRNA, etc. are thus out of the scope of these
analyses. Several ad hoc method have been used, and this package implements a
unifying method, finding differentially expressed genes or regions of any kind.

The *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* package implements two major methods to produce
potential differentially expressed regions: the HMM and IR method.
Briefly, these methods identify contiguous base-pairs in the genome that
present differential expression signal, then these are regrouped into
genomic intervals called differentially expressed regions (DERs).

Once DERs are detected, the second step in a *sRNA-diff* approach is to
quantify the signification of these. To do so, reads (including fractions
of reads) that overlap each expressed region are counted to arrive at a
count matrix with one row per region and one column per sample. Then, this
count matrix is analyzed using the standard workflow of *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*
for differential expression of RNA-seq data, assigning a p-value to each
candidate DER.

The main functions for finds differently expressed regions are
`srnadiffExp` and `srnadiff`. The first one
creates an S4 class providing the infrastructure (slots) to store the
input data, methods parameters, intermediate calculations and results
of an *sRNA-diff* approach. The second one implement four methods to find
candidate differentially expressed regions and quantify the statistic
signification of the finded regions.

This vignette explains the basics of using *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* by
showing an example, including advanced material for fine tuning some options.
The vignette also includes description of the methods behind the package.

## 3.1 Citing *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)*

We hope that *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* will be useful for your research. Please
use the following information to cite *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* and the overall
approach when you publish results obtained using this package, as such citation
is the main means by which the authors receive credit for their work. Thank
you!

Zytnicki, M., and I. González. (2021).
“Finding differentially expressed sRNA-Seq regions with srnadiff.” .

## 3.2 How to get help for *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)*

Most questions about individual functions will hopefully be answered by the
documentation. To get more information on any specific named function, for
example `MIMFA`, you can bring up the documentation by typing at the
*R*.

```
help("srnadiff")
```

or

```
?srnadiff
```

The authors of *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* always appreciate receiving reports
of bugs in the package functions or in the documentation. The same goes
for well-considered suggestions for improvements. If you’ve run into a
question that isn’t addressed by the documentation, or you’ve found a
conflict between the documentation and what the software does, then there
is an active community that can offer help. Send your questions or problems
concerning *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* to the Bioconductor support site at
.

Please send requests for general assistance and advice to the support site,
rather than to the individual authors. It is particularly critical that you
provide a small reproducible example and your session information so package
developers can track down the source of the error. Users posting to the
support site for the first time will find it helpful to read the posting
guide at
[the Bioconductor help page](http://www.bioconductor.org/help/support/posting-guide).

## 3.3 Quick start

A typical *sRNA-diff* session can be divided into three steps:

1. **Data preparation:** In this first step, a convenient *R* object of
   class `srnadiffExp` is created containing all the information required
   for the two remaining steps. The user needs to provide a vector with the full
   paths to the BAM files (which should be coordinate sorted), a `data.frame`
   with sample and experimental design information and optionally annotated
   regions as a `GRanges` object.
2. **Performing srnadiff:** Using the object created in the first step
   the user can perform `srnadiff` to find potential DERs and quantify the
   statistic signification of these.
3. **Visualization of the results:** The DERs obtained in the second
   step are visualized by plotting the coverage information surrounding genomic
   regions.

A typical *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* session might look like the following.
Here we assume that `bamFiles` is a vector with the full paths to the
BAM files and the sample and experimental design information are stored in a
data frame `sampleInfo`.

# 4 Using *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)*

## 4.1 Installation

We assume that the user has the *R* program (see the
[*R* project](http://www.r-project.org)) already installed.

The *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* package is available from the
[Bioconductor repository](http://www.bioconductor.org).
To be able to install the package one needs first to install the core
*[Bioconductor](https://CRAN.R-project.org/package%3DBioconductor)* packages. If you have already installed
*[Bioconductor](https://CRAN.R-project.org/package%3DBioconductor)* packages on your system then you can
skip the two lines below.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
```

Once the core *[Bioconductor](https://CRAN.R-project.org/package%3DBioconductor)* packages are installed, you can
install the *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* package by

```
BiocManager::install("srnadiff")
```

Load the *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* package in your *R* session:

```
library(srnadiff)
```

A list of all accessible vignettes and methods is available with the
following command:

```
help.search("srnadiff")
```

## 4.2 Data overview

To help demonstrate the functionality of *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)*, the package
includes datasets of published by (Viollet et al. [2015](#ref-data)).

Briefly, these data consist of three replicates of sRNA-Seq of SLK (human) cell
lines, and three replicates of SLK cell lines infected with Kaposi’s sarcoma
associated herpesvirus. The analysis shows that several loci are repressed in
the infected cell lines, including the 14q32 miRNA cluster.

Raw data have been downloaded from the GEO data set
[GSE62830](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE62830).
Adapters were removed with
[fastx\_clipper](http://hannonlab.cshl.edu/fastx_toolkit/commandline.html)
and mapped with (Salzberg and Langmead [2012](#ref-bowtie2)) on the human genome version GRCh38.

This data is restricted to a small locus on chr14.
It uses the whole genome annotation (with coding genes, etc.)
and extracts miRNAs.

The file `dataInfo.csv` contains three columns for each BAM file:

* the file name (`FileName`)
* a human readable sample name (`SampleName`)
* a condition, e.g. `WT` (`Condition`)

## 4.3 Data preparation: the `srnadiffExp` object

The first step in an *sRNA-diff* approach is to create a
`srnadiffExp` object. `srnadiffExp` is an `S4` class
providing the infrastructure to store the input data, methods parameters,
intermediate calculations and results of a *sRNA-diff* approach. This
object will be also the input of the visualization function.

### 4.3.1 Content

The object `srnadiffExp` will usually be represented in the code here
as `srnaExp`. To build such an object the user needs the following:

1. **paths to the BAM files:** a vector with the full paths to the sample BAM
   files, which should be coordinate sorted. Please use the `sortBam` function
   of the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* package to sort the reads.
2. **sample information:** a `data.frame` with three columns labelled
   `FileName`, `SampleName` and `Condition`. The first column
   is the BAM file name (without extension), the second column the sample name,
   and the third column the condition to which sample belongs. Each row describes
   one sample.
3. **annotation:** optionally annotation information. A *[GRanges](https://bioconductor.org/packages/3.22/GRanges)*
   object containing annotated regions.

Here, we demonstrate how to construct a `srnadiffExp` object from (Viollet et al. [2015](#ref-data)).

```
## Specifiy path to data files
basedir <- system.file("extdata", package="srnadiff", mustWork=TRUE)

## Read sample information file, and create a data frame
sampleInfo <- read.csv(file.path(basedir, "dataInfo.csv"))

## Vector with the full paths to the BAM files to use
bamFiles <- file.path(basedir, sampleInfo$FileName)

## Creates an srnadiffExp object
srnaExp <- srnadiffExp(bamFiles, sampleInfo)
```

### 4.3.2 Adding an annotation

Optionally, if annotation information is available as a *[GRanges](https://bioconductor.org/packages/3.22/GRanges)*
object, `annotReg` say, then a `srnadiffExp` object can be
created by

```
srnaExp <- srnadiffExp(bamFiles, sampleInfo, annotReg)
```

or by

```
srnaExp <- srnadiffExp(bamFiles, sampleInfo)
annotReg(srnaExp) <- annotReg
```

### 4.3.3 Directionality

`srnadiff` chooses a reference condition, which is the control, or wild type
condition.
The results reflect the comparison of the other condition *versus* the reference
condition.
By default, the reference condition is the first condition, when the conditions
are sorted by the alphabetical order.
It is thus advisable to specify the reference condition.

As mentionned in *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*, you can select the reference condition
using factors:

```
sampleInfo$Condition <- factor(sampleInfo$Condition,
                               levels = c("control", "infected"))
```

Internally, `srnadiff` (through *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*) computes the
log-fold-change of the comparison.
The log-fold-change is positive when the reference condition is less expressed
than the other condition.

### 4.3.4 The `srnaExp` object

A summary of the `srnaExp` object can be seen by typing the object name
at the *R* prompt

```
srnaExp
```

```
## Object of class srnadiffExp.
##  Sample information
##         FileName SampleName Condition
## 1 SRR1634756.bam      ctr_1   control
## 2 SRR1634757.bam      ctr_2   control
## 3 SRR1634758.bam      ctr_3   control
## 4 SRR1634759.bam      inf_1  infected
## 5 SRR1634760.bam      inf_2  infected
## 6 SRR1634761.bam      inf_3  infected
```

For your conveniance and illustrative purposes, an example of an
`srnadiffExp` object can be loaded with an only command, so the script
boils down to:

```
srnaExp <- srnadiffExample()
```

The `srnadiffExp` object in this example was constructed by:

```
basedir    <- system.file("extdata", package="srnadiff", mustWork=TRUE)
sampleInfo <- read.csv(file.path(basedir, "dataInfo.csv"))
gtfFile    <- file.path(basedir, "Homo_sapiens.GRCh38.76.gtf.gz")
annotReg   <- readAnnotation(gtfFile, feature="gene", source="miRNA")
bamFiles   <- file.path(basedir, sampleInfo$FileName)
srnaExp    <- srnadiffExp(bamFiles, sampleInfo, annotReg)
```

## 4.4 Read annotation

*[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)* offers the `readAnnotation` function related to
loading annotation data. This accepts two annotation format files: GTF and GFF
formats. Specification of GTF/GFF format can be found at the
[UCSC dedicated page](https://genome.ucsc.edu/FAQ/FAQformat.html).

`readAnnotation` reads and parses content of GTF/GFF files
and stores annotated genomic features (regions) in a `GRanges`
object. This has three main arguments: the first argument indicates the path,
URL or connection to the GTF/GFF annotation file. The second and third
argument, `feature` and `source` respectively, are of type
character string, these specify the feature and attribute type used to
select rows in the GTF/GFF annotation which will be imported. `feature`
and `source` can be `NULL`, in this case, no selection is
performed and all content into the file is imported.

### 4.4.1 Extraction of putative regions using an GTF annotation file

This method simply provides the genomic regions corresponding to the
annotation file that is optionally given by the user. It can be a set
of known miRNAs, siRNAs, piRNAs, genes, or a combination thereof.

### 4.4.2 Whole genome file annotation

This GTF file can be found in the central repositories
([NCBI](https://www.ncbi.nlm.nih.gov/),
[Ensembl](https://www.ensembl.org/index.html)) and
contains all the annotation found in an organism (coding genes, tranposable
element, etc.).
The following function reads the annotation file and extracts the miRNAs.
Annotation files may have different formats, but this command has been tested
on several model organisms (including human) from Ensembl.

```
gtfFile  <- file.path(basedir, "Homo_sapiens.GRCh38.76.gtf.gz")
annotReg <- readAnnotation(gtfFile, feature="gene", source="miRNA")
```

### 4.4.3 Extraction of precursor miRNAs using a miRBase-formatted GFF file

[miRBase](http://www.mirbase.org/) (Kozomara and Griffiths-Jones [2014](#ref-mirbase)) is the central repository for
miRNAs. If your organism is available, you can download their miRNA annotation
in GFF3 format (check the “Browse” tab). The following code parses a GFF3
miRBase file, and extracts the precursor miRNAs.

```
gffFile  <- file.path(basedir, "mirbase21_GRCh38.gff3")
annotReg <- readAnnotation(gffFile, feature="miRNA_primary_transcript")
```

### 4.4.4 Extraction of mature miRNAs using a miRBase-formatted GFF file

In the previous example, the reads will be counted per pre-miRNA, and the 5’ and
3’ arms, the miRNA and the miRNA\* will be merged in the same feature.
If you want to separate the two, use:

```
gffFile  <- file.path(basedir, "mirbase21_GRCh38.gff3")
annotReg <- readAnnotation(gffFile, feature="miRNA")
```

### 4.4.5 Other format

When the previous functions do not work, you can use your own parser with:

```
annotation <- readAnnotation(gtfFile, source="miRNA", feature="gene")
```

The `source` parameter keeps all the lines such that the second field matches
the given parameter (e.g. `miRNA`).
The `feature` parameter keeps all the lines such that the third field matches
the given parameter (e.g. `gene`).
The name of the feature will be given by the tag `name` (e.g. `gene_name`).
`source`, `feature` and `name` can be `NULL`.
In this case, no selection is performed on `source` or `feature`.
If `name` is null, then a systematic name is given (`annotation_N`).

## 4.5 Performing *sRNA-diff*

The main function for performing an *sRNA-diff* analysis is
`srnadiff`, this the wrapper for running several key functions from
this package. `srnadiff` implement four methods to produce potential
DERs: the *annotation*, *naive*, *hmm* and *IR* method
(see bellow).
Once potential DERs are detected, the second step in `srnadiff` is to
quantify the statistic signification of these.

`srnadiff` has three main arguments. The first argument is an instance
of class `srnadiffExp`. The second argument is of type character
vector, it specify the segmentation methods to use, one of `annotation`,
`naive`, `hmm`, `IR` or combinations thereof.
The default `all`, all methods are used.
The third arguments is of type list, it contain named components for the
methods parameters to use. If missing, default parameter values are supplied.
Details about the methods parameters are further described in the manual page
of the `parameters` function and in *Methods to produce
differentially expressed regions* section.

We then performs an *sRNA-diff* analysis on the input data contained in
`srnaExp` by

```
srnaExp <- srnadiff(srnaExp)
```

`srnadiff` returns an object of class `srnadiffExp` again
containing additional slots for:

* `regions`
* `parameters`
* `countMatrix`

# 5 Working with the `srnadiffExp` object

Once the `srnadiffExp` object is created the user can use the methods
defined for this class to access the information encapsulated in the object.

By example, the sample information is accessed by

```
sampleInfo(srnaExp)
```

```
##         FileName SampleName Condition
## 1 SRR1634756.bam      ctr_1   control
## 2 SRR1634757.bam      ctr_2   control
## 3 SRR1634758.bam      ctr_3   control
## 4 SRR1634759.bam      inf_1  infected
## 5 SRR1634760.bam      inf_2  infected
## 6 SRR1634761.bam      inf_3  infected
```

For accessing the `chromosomeSize` slot

```
chromosomeSizes(srnaExp)
```

```
##        14
## 107043718
```

The list of parameters can be exported by the function
`parameters`

```
parameters(srnaExp)
```

## 5.1 Extracting regions

The regions, together with log2-fold-changes and adjusted p-values, can be
extracted with this command:

```
regions <- regions(srnaExp, pvalue=0.5)
```

where `padj` is the (adjusted) p-value threshold. The output in a
*[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* object, and the information is accessible with the
`mcols()` function.

You can export the regions to a BED file with the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)*
function `export`.

```
library(rtracklayer)
export(regions, "file.bed")
```

You can either export to GFF, GFF3, or GTF formats. Simply change the file
suffix.

## 5.2 Data visualization

An insightful way of looking at the results of `srnadiff` is to
investigate how the coverage information surrounding finded regions
are distributed on the genomic coordinates.

`plotRegions` provides a flexible genomic visualization framework by
displaying tracks in the sense of the `Gviz` package. Given
a region (or regions), four separate tracks are represented:

1. `GenomeAxisTrack, a horizontal axis with genomic
   coordinate tickmarks for reference location to the displayed genomic
   regions;
2. `GeneRegionTrack, if the`annot` argument is
   passed, a track displaying all gene and/or sRNA annotation information
   in a particular region;
3. `AnnotationTrack, regions are plotted as simple
   boxes if no strand information is available, or as arrows to indicate
   their direction; and
4. `DataTrack, plot the sample coverages surrounding
   the genomic regions.

The sample coverages can be plotted in various different forms as well
as combinations thereof. Supported plotting types are:

The sample coverages can be plotted in various different forms as well
as combinations thereof. Supported plotting types are:

`p: simple dot plot;

`l: lines plot;

`b: combination of dot and lines plot;

`a: lines plot of the sample-groups average (i.e., mean) values;

`confint: confidence intervals for average values.

The default visualization for results from `srnadiff` is a lines plot
of the sample-groups average.

```
plotRegions(srnaExp, regions(srnaExp)[1])
```

![](data:image/png;base64...)

# 6 Methods behind *[srnadiff](https://bioconductor.org/packages/3.22/srnadiff)*

## 6.1 Pre-processing data

As input, `srnadiffExp` expects BAM files as obtained, *e.g.*, from
RNA-Seq or another high-throughput sequencing experiment. Reading and
processing of BAM files uses current *[Bioconductor](https://CRAN.R-project.org/package%3DBioconductor)* infrastructure
for processing sequencing reads: *[RSamtools](https://bioconductor.org/packages/3.22/RSamtools)*,
*[IRanges](https://bioconductor.org/packages/3.22/IRanges)* and *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* libraries.
At this stage BAM files are summarized into base-resolution coverage and
stored in a run-length encoding format in order to enhance computational
performance. Run-length encoding is a compact way to store an atomic vector
as a pairs of vectors (value, length). It is based on the `rle`
function from the base *R* package.

As a second pre-processing step, `srnadiffExp` estimate the size
factors (the effective library size) from the coverage data, such that
count values in each sample coverage can be brought to a common scale by
dividing by the corresponding size (normalization) factor. This step is
also called normalization, its purpose is to render coverages (counts)
from different samples, which may have been sequenced to different depths,
comparable. Normalization factors are estimated using the *median ratio
method* described by Equation 5 in (Anders and Huber [2010](#ref-deseq)).

## 6.2 Methods to produce differentially expressed regions

### 6.2.1 HMM method: `hmm`

The first step in HMM method is quantifying the evidence for differential
expression at the base-resolution level. To do this, `srnadiff` use
the common approach in comparative analysis of transcriptomics data: test
the null hypothesis that the logarithmic fold change between condition groups
for a nucleotide expression is exactly zero.

The next step in the HMM approach enforces a smoothness assumption over the
state of nucleotides: differential expression does not randomly switch along
the chromosome, rather, continuous regions of RNA are either “differentially
expressed” or “not”. This is captured with a hidden Markov model (HMM) with
binary latent state corresponding to the true state of each nucleotide:
differentially expressed or not differentially expressed.

The observations of the HMM are then the empirical p-values arising from the
differential expression analysis corresponding to each nucleotide position.
Modelling p-values directly enabled us to define the emission of each state
as follows: the differentially expressed state emits a p-value \(< t\) with
probability \(p\), and the not differentially expressed state emits a p-value
\(\geqslant t\) with probability \(1-p\), where \(t\) is a real number between 0
and 1.

The HMM approach normally needs emission, transition, and starting
probabilities values. They can be tuned by the user according to the
overall p-values from differential analysis. We then run the Viterbi
algorithm [ref] in order to finding the most likely sequence of states
from the HMM. This essentially segments the genome into regions, where
a region is defined as a set of consecutive bases showing a common expression
signature. A region of bases with differentially expressed state is referred
as an expressed region and is given as output of the method.

To run the HMM approach, `srnadiff` first form a large matrix, with
rows corresponding to bases, columns corresponding to samples and entries
are the coverage from a nucleotide of a particular sample. This count matrix
is then analyzed as into feature-level counts using the feature-level RNA-seq
differential expression analysis from *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*. In practice, the
p-value is not computed for every nucleotide. Nucleotides for which the sum
of the coverage across all samples is less than a threshold are given a
p-value of 1, because these poorly expressed bases are unlikely to provide a
differentially expressed sRNA.

The parameters for the HMM method are:

`noDiffToDiff`: Initial transition probability from
“no differentially expressed” state to “differentially expressed”
state.

`diffToNoDiff`: Initial transition probability from
“differentially expressed” state to no “differentially expressed”
state.

`emission`: Is the probability to emit a p-value \(<t\) in
the “differentially expressed” state, and a p-value \(\geq t\) in the
“not differentially expressed” state.

`emissionThreshold`: Is the threshold \(t\) that limits each
state.

This parameters can be changed using using the assignment function
`parameters<-`

```
parameters(srnaExp) <- list(noDiffToDiff=0.01, emissionThreshold=0.2)
```

### 6.2.2 IR method: `IR`

In this approach, for each base, the average from the normalized coverage is
calculated across all samples into each condition. This generates a vector of
(normalized) mean coverage expression per condition. These two vectors are
then used to compute per-nucleotide log-ratios (in absolute value) across the
genome. For the computed log-ratio expression, the method uses a sliding
threshold *h* that run across the log-ratio levels identifying bases with
log-ratio value above of *h*.
Regions of contiguous bases passing this threshold are then analyzed using an
adaptation of Aumann and Lindell algorithm for irreducibility property
(Aumann and Lindell [2003](#ref-irreducible)).

The minimun sliding threshold, `minLogFC`, used in the IR method can
be changed using the assignment function `parameters<-`

```
parameters(srnaExp) <- list(minLogFC=1)
```

### 6.2.3 Naive method: `naive`

This method is the simplest, gived a fixed threshold *h*, contiguous
bases with log-ratio expression (in absolute value) passing this threshold
are then considered as candidate differentially expressed regions.

The fixed threshold, `cutoff`, used in this method can be changed using
the assignment function `parameters<-`

```
parameters(srnaExp) <- list(cutoff=1.5)
```

## 6.3 Quantifying DERs

The result of the ER step is a list of genomic regions which were chosen
with a specific use, to quantify their expression for subsequent testing
for differential expression. The selected regions are then quantified using
the `summarizeOverlaps` function of the *[GenomicAlignments](https://bioconductor.org/packages/3.22/GenomicAlignments)*
package. Notice that a read can overlap two different regions (*e.g.* extracted
from the HMM and the IR methods), and thus can be counted twice for the
quantification. The result is ultimately a matrix with rows corresponding
to ERs and columns corresponding to samples; entries of this matrix are the
number of aligned reads from a particular sample that overlap a particular
region. Then, this count matrix is analyzed using the standard
*[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* workflow for differential expression of RNA-seq data,
assigning a p-value to each DER.

## 6.4 General parameters

The three last strategies can be tuned by specifying:

* the minimum and maximum regions sizes,
* the minimum depth of the most expressed condition.

The default values can be changed using these functions:

```
parameters(srnaExp) <- list(minDepth=1)
parameters(srnaExp) <- list(minSize=15, maxSize=1000)
```

## 6.5 Combination of strategies

### 6.5.1 Choice of the strategies

All the regions given by each strategies are then combined into a list of
regions.
You can choose not to use some strategies, use the parameter `segMethod` of the
function `srnadiff`.

```
srnaExp <- srnadiffExample()
srnaExp <- srnadiff(srnaExp, segMethod=c("hmm", "IR"))
```

### 6.5.2 Quantification of the features

The selected regions are then quantified using of the `summarizeOverlaps`
function of the *[GenomicAlignments](https://bioconductor.org/packages/3.22/GenomicAlignments)* package.
Notice that a read can overlap two different regions (e.g. extracted from the
naive and the slicing methods), and thus can be counted twice for the
quantification.

You can adjust the minimum number of overlapping nucleotides between a read and
a region to declare a hit, using:

```
parameters(srnaExp) <- list(minOverlap=1000)
```

*[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* is then used to get the adjusted p-values of these
regions.

## 6.6 Using an other method to compute adjusted p-values

p-values are computed twice in the process:
first, when preparing the HMM observed values;
second, when comparing putative regions.

The defaut method uses *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*.
You can choose instead *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*.

The method can be chosen using the parameter `diffMethod` of the function
`srnadiff`:

```
srnaExp <- srnadiffExample()
srnaExp <- srnadiff(srnaExp, diffMethod="edgeR")
```

The parameter `diffMethod` is case-insensitive.

# 7 Misc

## 7.1 Using several cores

The quantification and differential expression steps can be accelerated using
several cores and the following command:

```
exp <- setNThreads(exp, nThreads=4)
```

## 7.2 Troubleshooting

While installing the package, if the compiler complains and says

```
#error This file requires compiler and library support for the ISO C++ 2011 standard.
This support is currently experimental, and must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
```

Add this line

```
Sys.setenv("PKG_CXXFLAGS"="-std=c++11")
```

before installing the package.

# 8 Session information

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
## [1] stats4    grid      stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] rtracklayer_1.70.0   GenomicRanges_1.62.0 Seqinfo_1.0.0
##  [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
##  [7] generics_0.1.4       rmarkdown_2.30       knitr_1.50
## [10] BiocManager_1.30.26  srnadiff_1.30.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] magick_2.9.0                GenomicFeatures_1.62.0
##   [7] farver_2.1.2                BiocIO_1.20.0
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] base64enc_0.1-3             tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] progress_1.2.3              curl_7.0.0
##  [19] SparseArray_1.10.0          Formula_1.2-5
##  [21] sass_0.4.10                 bslib_0.9.0
##  [23] htmlwidgets_1.6.4           Gviz_1.54.0
##  [25] httr2_1.2.1                 cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [29] pkgconfig_2.0.3             Matrix_1.7-4
##  [31] R6_2.6.1                    fastmap_1.2.0
##  [33] MatrixGenerics_1.22.0       digest_0.6.37
##  [35] colorspace_2.1-2            AnnotationDbi_1.72.0
##  [37] DESeq2_1.50.0               Hmisc_5.2-4
##  [39] RSQLite_2.4.3               filelock_1.0.3
##  [41] httr_1.4.7                  abind_1.4-8
##  [43] compiler_4.5.1              bit64_4.6.0-1
##  [45] htmlTable_2.4.3             S7_0.2.0
##  [47] backports_1.5.0             BiocParallel_1.44.0
##  [49] DBI_1.2.3                   biomaRt_2.66.0
##  [51] rappdirs_0.3.3              DelayedArray_0.36.0
##  [53] rjson_0.2.23                tools_4.5.1
##  [55] foreign_0.8-90              nnet_7.3-20
##  [57] glue_1.8.0                  restfulr_0.0.16
##  [59] checkmate_2.3.3             cluster_2.1.8.1
##  [61] gtable_0.3.6                BSgenome_1.78.0
##  [63] ensembldb_2.34.0            data.table_1.17.8
##  [65] hms_1.1.4                   XVector_0.50.0
##  [67] pillar_1.11.1               stringr_1.5.2
##  [69] limma_3.66.0                dplyr_1.1.4
##  [71] BiocFileCache_3.0.0         lattice_0.22-7
##  [73] bit_4.6.0                   deldir_2.0-4
##  [75] biovizBase_1.58.0           tidyselect_1.2.1
##  [77] locfit_1.5-9.12             Biostrings_2.78.0
##  [79] gridExtra_2.3               bookdown_0.45
##  [81] ProtGenerics_1.42.0         edgeR_4.8.0
##  [83] SummarizedExperiment_1.40.0 xfun_0.53
##  [85] Biobase_2.70.0              statmod_1.5.1
##  [87] matrixStats_1.5.0           stringi_1.8.7
##  [89] UCSC.utils_1.6.0            lazyeval_0.2.2
##  [91] yaml_2.3.10                 evaluate_1.0.5
##  [93] codetools_0.2-20            cigarillo_1.0.0
##  [95] interp_1.1-6                tibble_3.3.0
##  [97] cli_3.6.5                   rpart_4.1.24
##  [99] jquerylib_0.1.4             dichromat_2.0-0.1
## [101] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
## [103] dbplyr_2.5.1                png_0.1-8
## [105] XML_3.99-0.19               parallel_4.5.1
## [107] ggplot2_4.0.0               blob_1.2.4
## [109] prettyunits_1.2.0           latticeExtra_0.6-31
## [111] jpeg_0.1-11                 AnnotationFilter_1.34.0
## [113] bitops_1.0-9                VariantAnnotation_1.56.0
## [115] scales_1.4.0                crayon_1.5.3
## [117] rlang_1.1.6                 KEGGREST_1.50.0
```

# References

Anders, S., and W. Huber. 2010. “Differential Expression Analysis for Sequence Count Data.” *Genome Biology* 11 (10): R106.

Aumann, Y., and Y. Lindell. 2003. “A statistical theory for quantitative association rules.” *Journal of Intelligent Information Systems* 20: 255–83.

Kozomara, A., and S. Griffiths-Jones. 2014. “Base: annotating high confidence microRNAs using deep sequencing data.” *NAR* 42: D68–D73.

Salzberg, S., and B. Langmead. 2012. “Fast gapped-read alignment with Bowtie 2.” *Nature Methods* 9: 357–59.

Viollet, C., Davis D. A., M. Reczko, J. M. Ziegelbauer, F. Pezzella, J. Ragoussis, and R. Yarchoan. 2015. “Next-generation sequencing analysis reveals differential expression profiles of miRNA-mRNA target pairs in KSHV-infected cells.” *PLOS ONE* 10: 1–23.