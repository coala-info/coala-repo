# CAGEr: an R package for CAGE (Cap Analysis of Gene Expression) data analysis and promoterome mining

Vanja Haberle, Charles Plessy and Sarvesh Nikumbh

#### 29 October 2025

#### Package

CAGEr 2.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Input data for *CAGEr*](#input-formats)
* [3 The *CAGEr* workflow](#the-cager-workflow)
  + [3.1 Getting started](#getting-started)
  + [3.2 Creating a *CAGEexp* object](#create-CAGEexp)
    - [3.2.1 Specifying a genome assembly](#specifying-a-genome-assembly)
    - [3.2.2 Specifying input files](#specifying-input-files)
    - [3.2.3 Creating the object](#creating-the-object)
  + [3.3 Reading in the data](#reading-in-the-data)
  + [3.4 Quality controls and preliminary analyses](#quality-controls-and-preliminary-analyses)
    - [3.4.1 Genome annotations](#genome-annotations)
    - [3.4.2 Correlation between samples](#correlation-between-samples)
    - [3.4.3 Sequence distribution at the transcription start site.](#sequence-distribution-at-the-transcription-start-site.)
  + [3.5 Merging of replicates](#merging-of-replicates)
  + [3.6 Normalization](#normalization)
  + [3.7 CTSS flagging](#ctss-flagging)
  + [3.8 CTSS clustering](#ctss-clustering)
  + [3.9 Promoter width](#promoter-width)
  + [3.10 Creating consensus promoters across samples](#creating-consensus-promoters-across-samples)
  + [3.11 Track export for genome browsers](#track-export-for-genome-browsers)
  + [3.12 Expression profiling](#expression-profiling)
  + [3.13 Differential expression analysis](#differential-expression-analysis)
  + [3.14 Shifting promoters](#shifting-promoters)
  + [3.15 Enhancers](#enhancers)
* [4 Appendix](#appendix)
  + [4.1 Creating a `CAGEexp` object by coercing a data frame](#coerce-CAGEexp)
  + [4.2 Summary of the CAGEr accessor functions](#summary-of-the-cager-accessor-functions)
    - [4.2.1 CTSS data](#ctss-data)
    - [4.2.2 Cluster data](#cluster-data)
    - [4.2.3 Gene data](#gene-data)
  + [4.3 Summary of the *CAGEexp* experiment slots and assays](#summary-of-the-cageexp-experiment-slots-and-assays)
    - [4.3.1 CAGEexp assays](#cageexp-assays)
  + [4.4 Summary of the CAGEr classes](#summary-of-the-cager-classes)
  + [4.5 Paired-end CAGE read alignment with the *nf-core/rnaseq* pipeline](#paired-end-cage-read-alignment-with-the-nf-corernaseq-pipeline)
* [Session info](#session-info)
* [References](#references)

# 1 Introduction

This document describes how to use *[CAGEr](https://bioconductor.org/packages/3.22/CAGEr)* *CAGEr*, a Bioconductor package designed
to process, analyse and visualise Cap Analysis of Gene Expression (CAGE) sequencing data.
CAGE (Kodzius et al. [2006](#ref-Kodzius:2006)) is a high-throughput method for transcriptome analysis that utilizes
*cap trapping* (Carninci et al. [1996](#ref-Carninci:1996)), a technique based on the biotinylation of the 7-methylguanosine
cap of Pol II transcripts, to pulldown the 5′-complete cDNAs reversely transcribed from
the captured transcripts. A linker sequence is ligated to the 5′ end of the cDNA and a specific
restriction enzyme is used to cleave off a short fragment from the 5′ end. Resulting fragments
are then amplified and sequenced using massive parallel high-throughput sequencing technology,
which results in a large number of short sequenced tags that can be mapped back to the referent
genome to infer the exact position of the transcription start sites (TSSs) used for transcription
of captured RNAs (Figure [1](#fig:CAGEprotocol)). The number of CAGE tags supporting each TSS
gives the information on the relative frequency of its usage and can be used as a measure of
expression from that specific TSS. Thus, CAGE provides information on two aspects of capped
transcriptome: genome-wide 1bp-resolution map of TSSs and transcript expression levels. This
information can be used for various analyses, from 5′ centered expression profiling
(Takahashi et al. [2012](#ref-Takahashi:2012)) to studying promoter architecture (Carninci et al. [2006](#ref-Carninci:2006)).

![Overview of CAGE experiment](data:image/svg+xml;base64...)

Figure 1: Overview of CAGE experiment

CAGE samples derived from various organisms (genomes) can be analysed by *CAGEr* and the only
limitation is the availability of the referent genome as a *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* package in case
when raw mapped CAGE tags are processed. *CAGEr* provides a comprehensive workflow that starts from
mapped CAGE tags and includes reconstruction of TSSs and promoters and their visualisation, as well
as more specialized downstream analyses like promoter width, expression profiling and differential
TSS usage. It can use both Binary Sequence Alignment Map (BAM) files of aligned CAGE tags or files
with genomic locations of TSSs and number of supporting CAGE tags as input. If BAM files are provided
*CAGEr* constructs TSSs from aligned CAGE tags and counts the number of tags supporting each TSS,
while allowing filtering out low-quality tags and removing technology-specific bias. It further
performs normalization of raw CAGE tag count, clustering of TSSs into tag clusters (TC) and their
aggregation across multiple CAGE experiments into promoters to construct the promoterome. Various
methods for normalization and clustering of TSSs are supported. Exporting data into different types
of track objects allows export and various visualisations of TSSs and clusters (promoters) in the UCSC Genome
Browser, which facilitate generation of hypotheses. *CAGEr* manipulates multiple CAGE experiments
at once and performs analyses across datasets, including expression profiling and detection of
differential TSS usage (promoter shifting). Multicore option for parallel processing is supported on
Unix-like platforms, which significantly reduces computing time.

Here are some of the functionalities provided in this package:

* Reading in multiple CAGE datasets from various sources; user provided BAM or TSS input files,
  public CAGE datasets from accompanying data package.
* Correcting systematic G nucleotide addition bias at the 5′ end of CAGE tags.
* Plotting pairwise scatter plots, calculating correlation between datasets and merging datasets.
* Normalizing raw CAGE tag count: simple tag per million (tpm) or power-law based normalization
  (Balwierz et al. [2009](#ref-Balwierz:2009)).
* Clustering individual TSSs into tag clusters (TCs) and aggregating clusters across multiple CAGE
  datasets to create a set of consensus promoters.
* Making bedGraph or BED files of individual TSSs or clusters for visualisation in the genome
  browser.
* Expression clustering of individual TSSs or consensus promoters into distinct expression
  profiles using common clustering algorithms.
* Calculating promoter width based on the cumulative distribution of CAGE signal along the
  promoter.
* Scoring and statistically testing differential TSS usage (promoter shifting) and detecting
  promoters that shift between two samples.

Several data packages are accompanying *CAGEr* package. They contain majority of the up-to-date
publicly available CAGE data produced by major consortia including FANTOM and ENCODE. These include
*[FANTOM3and4CAGE](https://bioconductor.org/packages/3.22/FANTOM3and4CAGE)* package available from Bioconductor, as well as
*[ENCODEprojectCAGE](https://bioconductor.org/packages/3.22/ENCODEprojectCAGE)* and *[ZebrafishDevelopmentalCAGE](https://bioconductor.org/packages/3.22/ZebrafishDevelopmentalCAGE)* packages
available from <http://promshift.genereg.net/CAGEr/>. In addition, direct fetching of TSS data from
FANTOM5 web resource (the largest collection of TSS data for human and mouse) from within *CAGEr* is
also available. These are all valuable resources of genome-wide TSSs in various tissue/cell types
for various model organisms that can be used directly in R. A separate vignette describes how
these public datasets can be included into a workflow provided by *CAGEr*. For further
information on the content of the data packages and the list of available CAGE datasets please refer
to the vignette of the corresponding data package.

For further details on the implemented methods and for citing the *CAGEr* package in your work
please refer to (Haberle et al. [2015](#ref-Haberle:2015)).

# 2 Input data for *CAGEr*

*CAGEr* package supports three types of CAGE data input:

* *Sequenced CAGE tags mapped to the genome*: either BAM (Binary Sequence Alignment Map) files of
  sequenced CAGE tags aligned to the referent genome (including the paired-end data such as
  CAGEscan) or BED files of CAGE tags (fragments).
* *CAGE detected TSSs (CTSSs)*: tab separated files with genomic coordinates of TSSs and number of
  tags supporting each TSS. The file should not contain a header and the data must be organized in
  four columns:

  + name of the chromosome: names must match the names of chromosomes in the corresponding
    *BSgenome* package.
  + 1-based coordinate of the TSS on the chromosome
  + genomic strand: should be either + or -
  + number of CAGE tags supporting that TSS
* *Publicly available CAGE datasets from R data package*: Several data packages containing CAGE
  data for various organisms produced by major consortia are accompanying this package. Selected
  subset of these data can be used as input for .

The type and the format of the input files is specified at the beginning of the workflow, when the
`CAGEset` object is created (section 3.2). This is done by setting the `inputFilesType` argument,
which accepts the following self-explanatory options referring to formats mentioned above:
`"bam", "bamPairedEnd", "bigwig", "bed", "ctss", "CTSStable"`.

In addition, the package provides a method for coercing a `data.frame` object containing single
base-pair TSS information into a `CAGEset` object (as described in section 4.1), which can be
further used in the workflow described below.

# 3 The *CAGEr* workflow

## 3.1 Getting started

We start the workflow by creating a *CAGEexp* object, which is a container for
storing CAGE datasets and all the results that will be generated by applying
specific functions. The *CAGEexp* objects are an extension of the
*[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* class, and therefore can use all their
methods. The expression data is stored in *CAGEexp* using
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* objects, and can also access their methods.

To load the *CAGEr* package and the other libraries into your R environment type:

```
library(CAGEr)
```

## 3.2 Creating a *CAGEexp* object

### 3.2.1 Specifying a genome assembly

In this tutorial we will be using data from zebrafish *Danio rerio* that was
mapped to the `danRer7` assembly of the genome. Therefore, the corresponding
genome package *[BSgenome.Drerio.UCSC.danRer7](https://bioconductor.org/packages/3.22/BSgenome.Drerio.UCSC.danRer7)* has to be installed.
It will be automatically loaded by *CAGEr* commands when needed.

In case the data is mapped to a genome that is not readily available through
*BSgenome* package (not in the list returned by `BSgenome::available.genomes()`
function), a custom *BSgenome* package can be build and installed first.
(See the vignette within the *BSgenome* package for instructions on how to build
a custom genome package). The `genomeName` argument can then be set to the name
of the build genome package when creating a `CAGEexp` object (see the section
*Creating `CAGEexp` object* below). It can also be set to `NULL` as a last
resort when no *BSgenome* package is available.

The *BSgenome* package is required by the *CAGEr* functions that need access to
the genome sequence, for instance for *G-correction*. It is also used provide
`seqinfo` information to the various Bioconductor objects produced by *CAGEr*.
For this reason, *CAGEr* will discard alignments that are not on chromosomes
named in the *BSgenome* package. If this is not desirable, set `genomeName`
to `NULL`.

### 3.2.2 Specifying input files

The subset of zebrafish (*Danio rerio*) developmental time-series CAGE data
generated by (Nepal et al. [2013](#ref-Nepal:2013)) will be used in the following demonstration of the
*CAGEr* workflow.

Files with genomic coordinates of TSSs detected by CAGE in 4 zebrafish
developmental stages are included in this package in the `extdata` subdirectory.
The files contain TSSs from a part of chromosome 17 (26,000,000-46,000,000), and
there are two files for one of the developmental stages (two independent
replicas). The data in files is organized in four tab-separated columns as
described above in section [2](#input-formats).

```
inputFiles <- list.files( system.file("extdata", package = "CAGEr")
                        , "ctss$"
                        , full.names = TRUE)
```

### 3.2.3 Creating the object

The *CAGEexp* object is crated with the `CAGEexp` constructor, that requires
information on file path and type, sample names and reference genome name.

```
ce <- CAGEexp( genomeName     = "BSgenome.Drerio.UCSC.danRer7"
             , inputFiles     = inputFiles
             , inputFilesType = "ctss"
             , sampleLabels   = sub( ".chr17.ctss", "", basename(inputFiles))
)
```

To display the created object type:

```
ce
```

```
## A CAGEexp object of 0 listed
##  experiments with no user-defined names and respective classes.
##  Containing an ExperimentList class object of length 0:
##  Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

The supplied information can be seen with the `colData` accessor, whereas all other
slots are still empty, since no data has been read yet and no analysis conducted.

```
colData(ce)
```

```
## DataFrame with 5 rows and 3 columns
##                                 inputFiles inputFilesType        sampleLabels
##                                <character>    <character>         <character>
## Zf.30p.dome         /tmp/RtmplElZTv/Rins..           ctss         Zf.30p.dome
## Zf.high             /tmp/RtmplElZTv/Rins..           ctss             Zf.high
## Zf.prim6.rep1       /tmp/RtmplElZTv/Rins..           ctss       Zf.prim6.rep1
## Zf.prim6.rep2       /tmp/RtmplElZTv/Rins..           ctss       Zf.prim6.rep2
## Zf.unfertilized.egg /tmp/RtmplElZTv/Rins..           ctss Zf.unfertilized.egg
```

## 3.3 Reading in the data

In case when the CAGE / TSS data is to be read from input files, an empty *CAGEexp* object with
information about the files is first created as described above in section [3.2](#create-CAGEexp).
To actually read in the data into the object we use `getCTSS()` function, that will add
an experiment called `tagCountMatrix` to the *CAGEexp* object.

```
ce <- getCTSS(ce)
ce
```

```
## A CAGEexp object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] tagCountMatrix: RangedSummarizedExperiment with 23343 rows and 5 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

This function reads the provided files in the order they were specified in the
`inputFiles` argument. It creates a single set of all TSSs detected across all
input datasets (union of TSSs) and a table with counts of CAGE tags supporting
each TSS in every dataset. (Note that in case when a *CAGEr* object is
created by coercion from an existing expression table there is no need to call
`getCTSS()`).

Genomic coordinates of all TSSs and numbers of supporting CAGE tags in every input
sample can be retrieved using the `CTSStagCountSE()` function. `CTSScoordinatesGR()` accesses
the CTSS coordinates and `CTSStagCountDF()` accesses the CTSS expression values.111 Data can also
be accessed directly using the native methods of the `MultiAssayExperiment` and
`SummarizedExperiment` classes, for example `ce[["tagCountMatrix"]]`,
`rowRanges(ce[["tagCountMatrix"]])` and `assay(ce[["tagCountMatrix"]])`.

```
CTSStagCountSE(ce)
```

```
## class: RangedSummarizedExperiment
## dim: 23343 5
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames(5): Zf.30p.dome Zf.high Zf.prim6.rep1 Zf.prim6.rep2
##   Zf.unfertilized.egg
## colData names(0):
```

```
CTSScoordinatesGR(ce)
```

```
## CTSS object with 23343 positions and 0 metadata columns:
##           seqnames       pos strand
##              <Rle> <integer>  <Rle>
##       [1]    chr17  26027430      +
##       [2]    chr17  26050540      +
##       [3]    chr17  26118088      +
##       [4]    chr17  26142853      +
##       [5]    chr17  26166954      +
##       ...      ...       ...    ...
##   [23339]    chr17  45975041      -
##   [23340]    chr17  45975540      -
##   [23341]    chr17  45975544      -
##   [23342]    chr17  45982697      -
##   [23343]    chr17  45999921      -
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##   BSgenome name: BSgenome.Drerio.UCSC.danRer7
```

```
CTSStagCountDF(ce)
```

```
## DataFrame with 23343 rows and 5 columns
##       Zf.30p.dome Zf.high Zf.prim6.rep1 Zf.prim6.rep2 Zf.unfertilized.egg
##             <Rle>   <Rle>         <Rle>         <Rle>               <Rle>
## 1               0       0             1             0                   0
## 2               0       0             0             0                   1
## 3               0       0             1             0                   0
## 4               0       0             0             1                   0
## 5               0       0             1             0                   0
## ...           ...     ...           ...           ...                 ...
## 23339           1       0             0             0                   0
## 23340           0       2             0             0                   0
## 23341           0       1             0             0                   0
## 23342           0       0             1             0                   0
## 23343           1       0             0             0                   0
```

```
CTSStagCountGR(ce, 1)  # GRanges for one sample with expression count.
```

```
## CTSS object with 7277 positions and 1 metadata column:
##          seqnames       pos strand | score
##             <Rle> <integer>  <Rle> | <Rle>
##      [1]    chr17  26222417      + |     1
##      [2]    chr17  26323229      + |     1
##      [3]    chr17  26453603      + |     2
##      [4]    chr17  26453615      + |     1
##      [5]    chr17  26453632      + |     3
##      ...      ...       ...    ... .   ...
##   [7273]    chr17  45901810      - |     1
##   [7274]    chr17  45901814      - |     1
##   [7275]    chr17  45901816      - |     1
##   [7276]    chr17  45975041      - |     1
##   [7277]    chr17  45999921      - |     1
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##   BSgenome name: BSgenome.Drerio.UCSC.danRer7
```

Note that the samples are ordered in the way they were supplied when creating the *CAGEexp* object
and will be presented in that order in all the results and plots. To check sample labels and their
ordering type:

```
sampleLabels(ce)
```

```
##               #FF0000               #CCFF00               #00FF66
##         "Zf.30p.dome"             "Zf.high"       "Zf.prim6.rep1"
##               #0066FF               #CC00FF
##       "Zf.prim6.rep2" "Zf.unfertilized.egg"
```

In addition, a colour is assigned to each sample, which is consistently used to depict that sample
in all the plots. By default a rainbow palette of colours is used and the hexadecimal format of
the assigned colours can be seen as names attribute of sample labels shown above. The colours can
be changed to taste at any point in the workflow using the `setColors()` function.

## 3.4 Quality controls and preliminary analyses

### 3.4.1 Genome annotations

By design, CAGE tags map transcription start sites and therefore detect promoters.
Quantitatively, the proportion of tags that map to promoter regions will depend both on the
quality of the libraries and the quality of the genome annotation, which may be incomplete.
Nevertheless, strong variations between libraries prepared in the same experiment may be
used for quality controls.

*CAGEr* can intersect CTSSes with reference transcript models and annotate them with
the name(s) of the models, and the region categories *promoter*, *exon*, *intron* and
*unknown*, by using the `annotateCTSS` function. The reference models can be GENCODE
loaded with the `import.gff` function of the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package,
or any other input that has the same structure, see `help("annotateCTSS")` for details.
In this example, we will use a sample annotation for zebrafish (see `help("exampleZv9_annot")`).

```
ce <- annotateCTSS(ce, exampleZv9_annot)
```

The annotation results are stored as tag counts in the sample metadata, and as new
columns in the CTSS genomic ranges

```
colData(ce)[,c("librarySizes", "promoter", "exon", "intron", "unknown")]
```

```
## DataFrame with 5 rows and 5 columns
##                     librarySizes  promoter      exon    intron   unknown
##                        <integer> <integer> <integer> <integer> <integer>
## Zf.30p.dome                41814     37843      2352       594      1025
## Zf.high                    45910     41671      2848       419       972
## Zf.prim6.rep1              34053     29531      2714       937       871
## Zf.prim6.rep2              34947     30799      2320       834       994
## Zf.unfertilized.egg        56140     51114      2860       400      1766
```

```
CTSScoordinatesGR(ce)
```

```
## CTSS object with 23343 positions and 2 metadata columns:
##           seqnames       pos strand |  genes annotation
##              <Rle> <integer>  <Rle> |  <Rle>      <Rle>
##       [1]    chr17  26027430      + |           unknown
##       [2]    chr17  26050540      + | grid1a   promoter
##       [3]    chr17  26118088      + | grid1a       exon
##       [4]    chr17  26142853      + | grid1a     intron
##       [5]    chr17  26166954      + | grid1a       exon
##       ...      ...       ...    ... .    ...        ...
##   [23339]    chr17  45975041      - |           unknown
##   [23340]    chr17  45975540      - |           unknown
##   [23341]    chr17  45975544      - |           unknown
##   [23342]    chr17  45982697      - |           unknown
##   [23343]    chr17  45999921      - |           unknown
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##   BSgenome name: BSgenome.Drerio.UCSC.danRer7
```

A function `plotAnnot` is provided to plot the annotations as stacked bar plots.
Here, all the CAGE libraries look very promoter-specific.

```
plotAnnot(ce, "counts")
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the CAGEr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • main = all
## ℹ Did you misspell an argument name?
```

```
## Warning: Removed 20 rows containing missing values or values outside the scale range
## (`geom_segment()`).
```

```
## Warning: Removed 20 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

### 3.4.2 Correlation between samples

As part of the basic sanity checks, we can explore the data by looking at the
correlation between the samples. The `plotCorrelation2()` function will plot
pairwise scatter plots of expression scores per TSS or consensus cluster and
calculate correlation coefficients between all possible pairs of
samples222 Alternatively, the `plotCorrelation()` function does the same and
colors the scatterplots according to point density, but is much slower.. A
threshold can be set, so that only regions with an expression score (raw or
normalized) above the threshold (either in one or both samples) are
considered when calculating correlation. Three different correlation measures
are supported: Pearson’s, Spearman’s and Kendall’s correlation coefficients.
Note that while the scatterplots are on a logarithmic scale with pseudocount
added to the zero values, the correlation coefficients are calculated on
untransformed (but thresholded) data.

```
corr.m <- plotCorrelation2( ce, samples = "all"
                          , tagCountThreshold = 1, applyThresholdBoth = FALSE
                          , method = "pearson")
```

![Correlation of raw CAGE tag counts per TSS](data:image/png;base64...)

Figure 2: Correlation of raw CAGE tag counts per TSS

### 3.4.3 Sequence distribution at the transcription start site.

The presence of the core promoter motifs can be checked with the `TSSlogo()`
function, provided that the *CAGEexp* object was built with a *BSgenome*
package allowing access to the sequence flanking the transcription start sites.

```
TSSlogo(CTSScoordinatesGR(ce) |> subset(annotation == "promoter"), upstream = 35)
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the ggseqlogo package.
##   Please report the issue at <https://github.com/omarwagih/ggseqlogo/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![Sequence logo at the transcription start site](data:image/png;base64...)

Figure 3: Sequence logo at the transcription start site

The `TSSlogo()` function can also be used later. When passed *tag clusters*
or *consensus clusters*, it will automatically center the regions on their
*dominant peak*.

## 3.5 Merging of replicates

Based on calculated correlation we might want to merge and/or rearrange some of the datasets. To
rearrange the samples in the temporal order of the zebrafish development (unfertilized egg -> high
-> 30 percent dome -> prim6) and to merge the two replicas for the prim6 developmental stage we use
the `mergeSamples()` function:

```
ce <- mergeSamples(ce, mergeIndex = c(3,2,4,4,1),
                   mergedSampleLabels = c("Zf.unfertilized.egg", "Zf.high", "Zf.30p.dome", "Zf.prim6"))
ce <- annotateCTSS(ce, exampleZv9_annot)
```

The `mergeIndex` argument controls which samples will be merged and how the final dataset will be
ordered. Samples labeled by the same number (in our case samples three and four) will be merged
together by summing number of CAGE tags per TSS. The final set of samples will be ordered in the
ascending order of values provided in `mergeIndex` and will be labeled by the labels provided in
the `mergedSampleLabels` argument. Note that `mergeSamples` function resets all slots with results
of downstream analyses, so in case there were any results in the *CAGEexp* object prior to merging,
they will be removed. Thus, annotation has to be redone.

## 3.6 Normalization

Library sizes (number of total sequenced tags) of individual experiments differ, thus
normalization is required to make them comparable. The `librarySizes` function returns the total
number of CAGE tags in each sample:

```
librarySizes(ce)
```

```
## [1] 56140 45910 41814 69000
```

The *CAGEr* package supports both simple tags per million normalization and power-law based
normalization. It has been shown that many CAGE datasets follow a power-law distribution
(Balwierz et al. [2009](#ref-Balwierz:2009)). Plotting the number of CAGE tags (X-axis) against the number of TSSs that are
supported by <= of that number of tags (Y-axis) results in a distribution that can be approximated
by a power-law. On a log-log scale this reverse cumulative distribution will manifest as a
monotonically decreasing linear function, which can be defined as

\[y = -1 \* \alpha \* x + \beta\]

and is fully determined by the slope \(\alpha\) and total number of tags T (which together with
\(\alpha\) determines the value of \(\beta\)).

To check whether our CAGE datasets follow power-law distribution and in which range of values, we
can use the `plotReverseCumulatives` function:

```
plotReverseCumulatives(ce, fitInRange = c(5, 1000))
```

![Reverse cumulative distribution of CAGE tags](data:image/png;base64...)

Figure 4: Reverse cumulative distribution of CAGE tags

In addition to the reverse cumulative plots (Figure [4](#fig:ReverseCumulatives)), a power-law
distribution will be fitted to each reverse cumulative using values in the specified range
(denoted with dashed lines in Figure [4](#fig:ReverseCumulatives)) and the value of \(\alpha\)
will be reported for each sample (shown in the brackets in the Figure [4](#fig:ReverseCumulatives)
legend). The plots can help in choosing the optimal parameters for power-law based normalization.
We can see that the reverse cumulative distributions look similar and follow the power-law in the
central part of the CAGE tag counts values with a slope between -1.1 and -1.3. Thus, we choose a
range from 5 to 1000 tags to fit a power-law, and we normalize all samples to a referent power-law
distribution with a total of 50,000 tags and slope of -1.2 (\(\alpha = 1.2\)).333 Note that since this
example dataset contains only data from one part of chromosome 17 and the total number of tags is
very small, we normalize to a referent distribution with a similarly small number of tags. When
analyzing full datasets it is reasonable to set total number of tags for referent distribution to
one million to get normalized tags per million values.

To perform normalization we pass these parameters to the `normalizeTagCount` function.

```
ce <- normalizeTagCount(ce, method = "powerLaw", fitInRange = c(5, 1000), alpha = 1.2, T = 5*10^4)
```

```
## Warning in dim(assays): The dim() method for DataFrameList objects is deprecated. Please use dims()
##   on these objects instead.
```

```
## Warning in nrow(x): The nrow() method for DataFrameList objects is deprecated. Please use nrows()
##   on these objects instead.
```

```
## Warning in ncol(x): The ncol() method for DataFrameList objects is deprecated. Please use ncols()
##   on these objects instead.
```

```
## Warning in dim(assays): The dim() method for DataFrameList objects is deprecated. Please use dims()
##   on these objects instead.
```

```
## Warning in nrow(x): The nrow() method for DataFrameList objects is deprecated. Please use nrows()
##   on these objects instead.
```

```
## Warning in ncol(x): The ncol() method for DataFrameList objects is deprecated. Please use ncols()
##   on these objects instead.
```

```
ce[["tagCountMatrix"]]
```

```
## class: RangedSummarizedExperiment
## dim: 23343 4
## metadata(0):
## assays(2): counts normalizedTpmMatrix
## rownames: NULL
## rowData names(2): genes annotation
## colnames(4): Zf.unfertilized.egg Zf.high Zf.30p.dome Zf.prim6
## colData names(0):
```

The normalization is performed as described in (Balwierz et al. [2009](#ref-Balwierz:2009)):

* Power-law is fitted to the reverse cumulative distribution in the specified range of CAGE tags
  values to each sample separately.
* A referent power-law distribution is defined based on the provided `alpha` (slope in the
  log-log representation) and `T` (total number of tags) parameters. Setting `T` to
  1 million results in normalized tags per million (tpm) values.
* Every sample is normalized to the defined referent distribution, *i.e.* given the parameters
  that approximate its own power-law distribution it is calculated how many tags would each TSS
  have in the referent power-law distribution.

In addition to the two provided normalization methods, a pass-through option `none` can be set as
`method` parameter to keep using raw tag counts in all downstream steps. Note that
`normalizeTagCount()` has to be applied to `CAGEr` object before moving to next steps. Thus, in
order to keep using raw tag counts run the function with `method="none"`. In that case, all
results and parameters in the further steps that would normally refer to normalized CAGE signal
(denoted as tpm), will actually be raw tag counts.

## 3.7 CTSS flagging

Some CTSSes have a low expression score, and are found in only a few libraries.
In non-PCR-amplified CAGE libraries, a CTSS found in a single library with an
expression score of 1 tag represents the detection of a single mRNA molecule’s
5-prime end. But it could also represent the mismapping one molecule because of
a sequencing error. To flag CTSSes that have poor reproducibility support so
that other steps of the analysis can ignore them, the `filterLowExpCTSS`
function is provided. It will add an internal flag in the `filteredCTSSidx`
column of the `CTSS` objects, set to `FALSE` where expression is lower than a
given threshold in a given number of samples. This flag is later used by CTSS
clustering and export functions.

Let’s flag low-fidelity TSSs supported by less than 1 normalized tag counts in
all of the samples.

```
ce <- filterLowExpCTSS(ce, thresholdIsTpm = TRUE, nrPassThreshold = 1, threshold = 1)
CTSSnormalizedTpmGR(ce,1)
```

```
## CTSS object with 8395 positions and 4 metadata columns:
##          seqnames       pos strand |           genes annotation filteredCTSSidx
##             <Rle> <integer>  <Rle> |           <Rle>      <Rle>           <Rle>
##      [1]    chr17  26050540      + |          grid1a   promoter           FALSE
##      [2]    chr17  26391265      + | si:ch73-34j14.2       exon           FALSE
##      [3]    chr17  26446219      + |                    unknown           FALSE
##      [4]    chr17  26453605      + |                   promoter            TRUE
##      [5]    chr17  26453632      + |                   promoter            TRUE
##      ...      ...       ...    ... .             ...        ...             ...
##   [8391]    chr17  45901781      - |           arf6b   promoter           FALSE
##   [8392]    chr17  45901784      - |           arf6b   promoter            TRUE
##   [8393]    chr17  45901800      - |           arf6b   promoter           FALSE
##   [8394]    chr17  45901814      - |           arf6b   promoter            TRUE
##   [8395]    chr17  45901816      - |           arf6b   promoter            TRUE
##                      score
##                      <Rle>
##      [1] 0.658379223965292
##      [2] 0.658379223965292
##      [3] 0.658379223965292
##      [4]  1.30374775871268
##      [5]  1.30374775871268
##      ...               ...
##   [8391] 0.658379223965292
##   [8392] 0.658379223965292
##   [8393] 0.658379223965292
##   [8394]  1.30374775871268
##   [8395]  1.94429500559247
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##   BSgenome name: BSgenome.Drerio.UCSC.danRer7
```

## 3.8 CTSS clustering

Transcription start sites are found in the promoter region of a gene and reflect the
transcriptional activity of that promoter (Figure [6](#fig:CTSSbedGraph)). TSSs in the close
proximity of each other give rise to a functionally equivalent set of transcripts and are
likely regulated by the same promoter elements. Thus, TSSs can be spatially clustered into
larger transcriptional units, called tag clusters (TCs) that correspond to individual promoters.
*CAGEr* supports two methods for sample-specific spatial clustering of TSSs along the genome:

* `distclu()`: simple distance-based clustering in which two neighbouring TSSs are joined together if they
  are closer than some specified distance (greedy algorithm);
* `paraclu()`: parametric clustering of data attached to sequences based on the density of the signal
  (Frith et al. [2007](#ref-Frith:2007)), <http://www.cbrc.jp/paraclu/>;

We will perform a simple distance-based clustering using 20 bp as a maximal allowed distance
between two neighbouring TSSs.

```
ce <- distclu(ce, maxDist = 20, keepSingletonsAbove = 5)
```

Our final set of tag clusters will not include singletons (clusters with only one TSS), unless the
normalized signal is above 5, it is a reasonably supported TSS. The CTSS clustering functions
function creates a set of clusters for each sample separately; for each cluster it returns the
genomic coordinates, counts the number of TSSs within the cluster, determines the (1-based) position of the
most frequently used (dominant) TSS, calculates the total CAGE signal within the cluster and CAGE
signal supporting the dominant TSS only. We can extract tag clusters for a desired sample from
`CAGEexp` object by calling the `tagClustersGR` function:

```
tagClustersGR(ce, sample = "Zf.unfertilized.egg")
```

```
## TagClusters object with 517 ranges and 3 metadata columns:
##       seqnames            ranges strand |            score    dominant_ctss
##          <Rle>         <IRanges>  <Rle> |            <Rle>           <CTSS>
##     1    chr17 26453632-26453708      + | 26.9709371501973 chr17:26453667:+
##     2    chr17 26564508-26564610      + | 128.637202208017 chr17:26564585:+
##     3    chr17 26595637-26595793      + | 216.999442534332 chr17:26595750:+
##     4    chr17 26596033-26596091      + | 10.4200035230486 chr17:26596070:+
##     5    chr17 26596118-26596127      + | 12.1994648486481 chr17:26596118:+
##   ...      ...               ...    ... .              ...              ...
##   513    chr17 45700182-45700187      - | 9.61820033171689 chr17:45700182:-
##   514    chr17 45901329-45901330      - | 1.96212698267798 chr17:45901329:-
##   515    chr17 45901698-45901710      - | 27.6544648890639 chr17:45901698:-
##   516    chr17 45901732-45901784      - |  119.96944736195 chr17:45901749:-
##   517    chr17 45901814-45901816      - | 3.24804276430515 chr17:45901816:-
##         nr_ctss
##       <integer>
##     1        12
##     2        24
##     3        35
##     4         9
##     5         4
##   ...       ...
##   513         3
##   514         2
##   515         4
##   516        15
##   517         2
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

## 3.9 Promoter width

Genome-wide mapping of TSSs using CAGE has initially revealed two major classes of promoters in
mammals (Carninci et al. [2006](#ref-Carninci:2006)), with respect to the number and distribution of TSSs within the promoter.
They have been further correlated with differences in the underlying sequence and the functional
classes of the genes they regulate, as well as the organization of the chromatin around them.

* “broad” promoters with multiple TSSs characterized by a high GC content and overlap with a
  CpG island, which are associated with widely expressed or developmentally regulated genes;
* “sharp” promoters with one dominant TSS often associated with a TATA-box at a fixed upstream
  distance, which often regulate tissue-specific transcription.

Thus, the width of the promoter is an important characteristic that distinguishes different
functional classes of promoters. *CAGEr* analyzes promoter width across all samples present
in the `CAGEexp` object. It defines promoter width by taking into account both the positions
and the CAGE signal at TSSs along the tag cluster, thus making it more robust with respect
to total expression and local level of noise at the promoter. Width of every tag cluster is
calculated as following:

1. Cumulative distribution of CAGE signal along the cluster is calculated.
2. A “lower” (`qLow`) and an “upper” (`qUp`) quantile are selected by the user.
3. From the 5′ end the position, the position of a quantile \(q\) is determined as
   the first base in which of the cumulative expression is higher or equal to
   \(q\%\) of the total CAGE signal of that cluster.
4. Promoter *interquantile width* is defined as the distance (in base pairs)
   between the two quantile positions.

The procedure is schematically shown in Figure [5](#fig:CumulativeDistribution).

![Cumulative distribution of CAGE signal and definition of interquantile width](data:image/svg+xml;base64...)

Figure 5: Cumulative distribution of CAGE signal and definition of interquantile width

Required computations are done using `cumulativeCTSSdistribution` and `quantilePositions`
functions, which calculate cumulative distribution for every tag cluster in each of the
samples and determine the positions of selected quantiles, respectively:

```
ce <- cumulativeCTSSdistribution(ce, clusters = "tagClusters", useMulticore = T)
ce <- quantilePositions(ce, clusters = "tagClusters", qLow = 0.1, qUp = 0.9)
```

Tag clusters and their interquantile width can be retrieved by calling `tagClusters` function:

```
tagClustersGR(ce, "Zf.unfertilized.egg",  qLow = 0.1, qUp = 0.9)
```

```
## TagClusters object with 517 ranges and 6 metadata columns:
##       seqnames            ranges strand |            score    dominant_ctss
##          <Rle>         <IRanges>  <Rle> |            <Rle>           <CTSS>
##     1    chr17 26453632-26453708      + | 26.9709371501973 chr17:26453667:+
##     2    chr17 26564508-26564610      + | 128.637202208017 chr17:26564585:+
##     3    chr17 26595637-26595793      + | 216.999442534332 chr17:26595750:+
##     4    chr17 26596033-26596091      + | 10.4200035230486 chr17:26596070:+
##     5    chr17 26596118-26596127      + | 12.1994648486481 chr17:26596118:+
##   ...      ...               ...    ... .              ...              ...
##   513    chr17 45700182-45700187      - | 9.61820033171689 chr17:45700182:-
##   514    chr17 45901329-45901330      - | 1.96212698267798 chr17:45901329:-
##   515    chr17 45901698-45901710      - | 27.6544648890639 chr17:45901698:-
##   516    chr17 45901732-45901784      - |  119.96944736195 chr17:45901749:-
##   517    chr17 45901814-45901816      - | 3.24804276430515 chr17:45901816:-
##         nr_ctss q_0.1 q_0.9 interquantile_width
##       <integer> <Rle> <Rle>               <Rle>
##     1        12    36    72                  37
##     2        24    17    81                  65
##     3        35    37   114                  78
##     4         9     1    50                  50
##     5         4     1    10                  10
##   ...       ...   ...   ...                 ...
##   513         3     1     6                   6
##   514         2     1     2                   2
##   515         4     1     2                   2
##   516        15     2    21                  20
##   517         2     1     3                   3
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

Once the cumulative distributions and the positions of quantiles have been calculated, the
histograms of interquantile width can be plotted to globally compare the promoter width across
different samples (Figure [**??**](#fig:TagClustersInterquantileWidth):

```
plotInterquantileWidth(ce, clusters = "tagClusters", tpmThreshold = 3, qLow = 0.1, qUp = 0.9)
```

![](data:image/png;base64...)

Significant difference in the promoter width might indicate global differences in the modes of
gene regulation between the two samples. The histograms can also help in choosing an appropriate
width threshold for separating sharp and broad promoters.

## 3.10 Creating consensus promoters across samples

Tag clusters are created for each sample individually and they are often sample-specific, thus can
be present in one sample but absent in another. In addition, in many cases tag clusters do not
coincide perfectly within the same promoter region, or there might be two clusters in one sample
and only one larger in the other. To be able to compare genome-wide transcriptional activity
across samples and to perform expression profiling, a single set of consensus clusters needs to
be created. This is done using the `aggregateTagClusters` function, which aggregates tag clusters
from all samples into a single set of non-overlapping consensus clusters:

```
ce <- aggregateTagClusters(ce, tpmThreshold = 5, qLow = 0.1, qUp = 0.9, maxDist = 100)
ce$outOfClusters / ce$librarySizes *100
```

```
## Zf.unfertilized.egg             Zf.high         Zf.30p.dome            Zf.prim6
##                23.0                23.3                23.9                26.6
```

Tag clusters can be aggregated using their full span (from start to end) or using positions of
previously calculated quantiles as their boundaries. Only tag clusters above given tag count
threshold will be considered and two clusters will be aggregated together if their boundaries
(i.e. either starts and ends or positions of quantiles) are `<= maxDist` apart. Final set
of consensus clusters can be retrieved by:

```
consensusClustersGR(ce)
```

```
## ConsensusClusters object with 285 ranges and 3 metadata columns:
##                             seqnames            ranges strand |
##                                <Rle>         <IRanges>  <Rle> |
##   chr17:26453647-26453719:+    chr17 26453647-26453719      + |
##   chr17:26564524-26564591:+    chr17 26564524-26564591      + |
##   chr17:26595673-26595750:+    chr17 26595673-26595750      + |
##   chr17:26596033-26596339:+    chr17 26596033-26596339      + |
##   chr17:26645157-26645514:+    chr17 26645157-26645514      + |
##                         ...      ...               ...    ... .
##   chr17:45534727-45534729:-    chr17 45534727-45534729      - |
##   chr17:45545922-45545996:-    chr17 45545922-45545996      - |
##   chr17:45554314-45554345:-    chr17 45554314-45554345      - |
##   chr17:45700092-45700187:-    chr17 45700092-45700187      - |
##   chr17:45901695-45901752:-    chr17 45901695-45901752      - |
##                                        score    dominant_ctss   nr_ctss
##                                        <Rle>           <CTSS> <integer>
##   chr17:26453647-26453719:+ 174.694216150624 chr17:26453701:+        22
##   chr17:26564524-26564591:+ 308.691093930439 chr17:26564585:+        27
##   chr17:26595673-26595750:+ 891.067717359328 chr17:26595750:+        34
##   chr17:26596033-26596339:+ 321.610459357019 chr17:26596198:+        57
##   chr17:26645157-26645514:+ 2818.40482968203 chr17:26645160:+        92
##                         ...              ...              ...       ...
##   chr17:45534727-45534729:- 176.502992017265 chr17:45534727:-         3
##   chr17:45545922-45545996:- 919.561599189015 chr17:45545991:-        32
##   chr17:45554314-45554345:- 44.0059397386966 chr17:45554339:-         6
##   chr17:45700092-45700187:- 39.7367855448721 chr17:45700182:-         8
##   chr17:45901695-45901752:- 846.564852543874 chr17:45901749:-        22
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

which will return genomic coordinates and sum of CAGE signal across all samples for each consensus
cluster (the `tpm` column).

Analogously to tag clusters, analysis of promoter width can be performed for consensus clusters
as well, using the same `cumulativeCTSSdistribution`, `quantilePositions`
and `plotInterquantileWidth` functions as described above, but by setting
the `clusters` parameter to `"consensusClusters"`. Like the CTSS, the consensus clusters can
also be annotated:

```
ce <- annotateConsensusClusters(ce, exampleZv9_annot)
ce <- cumulativeCTSSdistribution(ce, clusters = "consensusClusters", useMulticore = TRUE)
ce <- quantilePositions(ce, clusters = "consensusClusters", qLow = 0.1, qUp = 0.9, useMulticore = TRUE)
```

Although consensus clusters are created to represent consensus across all samples, they obviously
have different CAGE signal and can have different width or position of the dominant TSS in the
different samples. Sample-specific information on consensus clusters can be retrieved with the
function, by specifying desired sample name (analogous to retrieving
tag clusters):

```
consensusClustersGR(ce, sample = "Zf.unfertilized.egg", qLow = 0.1, qUp = 0.9)
```

```
## ConsensusClusters object with 285 ranges and 9 metadata columns:
##                             seqnames            ranges strand |     score
##                                <Rle>         <IRanges>  <Rle> | <numeric>
##   chr17:26453647-26453719:+    chr17 26453647-26453719      + |   19.1354
##   chr17:26564524-26564591:+    chr17 26564524-26564591      + |   96.9145
##   chr17:26595673-26595750:+    chr17 26595673-26595750      + |  177.6584
##   chr17:26596033-26596339:+    chr17 26596033-26596339      + |   30.6125
##   chr17:26645157-26645514:+    chr17 26645157-26645514      + |  585.4393
##                         ...      ...               ...    ... .       ...
##   chr17:45534727-45534729:-    chr17 45534727-45534729      - |   0.00000
##   chr17:45545922-45545996:-    chr17 45545922-45545996      - | 208.58390
##   chr17:45554314-45554345:-    chr17 45554314-45554345      - |   8.31445
##   chr17:45700092-45700187:-    chr17 45700092-45700187      - |   6.37016
##   chr17:45901695-45901752:-    chr17 45901695-45901752      - | 132.65464
##                                dominant_ctss   nr_ctss annotation   genes q_0.1
##                                       <CTSS> <integer>      <Rle>   <Rle> <Rle>
##   chr17:26453647-26453719:+ chr17:26453701:+        22   promoter   ttc7b    21
##   chr17:26564524-26564591:+ chr17:26564585:+        27   promoter   nrde2     1
##   chr17:26595673-26595750:+ chr17:26595750:+        34   promoter  larp1b    12
##   chr17:26596033-26596339:+ chr17:26596198:+        57   promoter  larp1b    38
##   chr17:26645157-26645514:+ chr17:26645160:+        92   promoter  pgrmc2     1
##                         ...              ...       ...        ...     ...   ...
##   chr17:45534727-45534729:- chr17:45534727:-         3     intron znf106a     1
##   chr17:45545922-45545996:- chr17:45545991:-        32   promoter znf106a    24
##   chr17:45554314-45554345:- chr17:45554339:-         6   promoter tmem206    26
##   chr17:45700092-45700187:- chr17:45700182:-         8       exon   susd4     4
##   chr17:45901695-45901752:- chr17:45901749:-        22   promoter   arf6b     4
##                             q_0.9 interquantile_width       tpm
##                             <Rle>               <Rle> <numeric>
##   chr17:26453647-26453719:+    57                  37   19.1354
##   chr17:26564524-26564591:+    65                  65   96.9145
##   chr17:26595673-26595750:+    78                  67  177.6584
##   chr17:26596033-26596339:+   272                 235   30.6125
##   chr17:26645157-26645514:+   109                 109  585.4393
##                         ...   ...                 ...       ...
##   chr17:45534727-45534729:-     1                   1   0.00000
##   chr17:45545922-45545996:-    70                  47 208.58390
##   chr17:45554314-45554345:-    32                   7   8.31445
##   chr17:45700092-45700187:-    93                  90   6.37016
##   chr17:45901695-45901752:-    55                  52 132.65464
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

This will, in addition to genomic coordinates of the consensus clusters, which are constant across all samples, also return the position of the dominant TSS, the CAGE signal (tpm) and the interquantile width specific for a given sample. Note that when specifying individual sample, only the consensus clusters that have some CAGE signal in that sample will be returned (which will be a subset of all consensus clusters).
When setting `sample = NULL` sample-agnostic information per consensus cluster
is provided.
This includes the interquantile width and dominant TSS information for each
consensus cluster independent of the samples when specifying interquantile boundaries `qLow` and `qUp`.

## 3.11 Track export for genome browsers

CAGE data can be visualized in the genomic context by converting raw or
normalized CAGE tag counts to a track object and exporting it to a file format
such as *BED*, *bedGraph* or *BigWig* for uploading (or linking) to a genome
browser`444 Note that the [ZENBU genome browser](http://fantom.gsc.riken.jp/zenbu)
can also display natively data from BAM or BED files as coverage tracks.. The
(exportToTrack) function can take a variety of inputs representing
*CTSS*, *Tag Clusters* or *Consensus Clusters*, with raw or normalised
expression scores. When asked to export multiple samples it will return
a list of tracks.

```
trk <- exportToTrack(CTSSnormalizedTpmGR(ce, "Zf.30p.dome"))
ce |> CTSSnormalizedTpmGR("all") |> exportToTrack(ce, oneTrack = FALSE)
```

```
## GRangesList object of length 4:
## [[1]]
## UCSC track 'Zf.unfertilized.egg (TC)'
## UCSCData object with 8395 ranges and 6 metadata columns:
##          seqnames    ranges strand |           genes annotation filteredCTSSidx
##             <Rle> <IRanges>  <Rle> |           <Rle>      <Rle>           <Rle>
##      [1]    chr17  26050540      + |          grid1a   promoter           FALSE
##      [2]    chr17  26391265      + | si:ch73-34j14.2       exon           FALSE
##      [3]    chr17  26446219      + |                    unknown           FALSE
##      [4]    chr17  26453605      + |                   promoter            TRUE
##      [5]    chr17  26453632      + |                   promoter            TRUE
##      ...      ...       ...    ... .             ...        ...             ...
##   [8391]    chr17  45901781      - |           arf6b   promoter           FALSE
##   [8392]    chr17  45901784      - |           arf6b   promoter            TRUE
##   [8393]    chr17  45901800      - |           arf6b   promoter           FALSE
##   [8394]    chr17  45901814      - |           arf6b   promoter            TRUE
##   [8395]    chr17  45901816      - |           arf6b   promoter            TRUE
##          cluster     score     itemRgb
##            <Rle> <numeric> <character>
##      [1]          0.658379      grey50
##      [2]          0.658379      grey50
##      [3]          0.658379      grey50
##      [4]          1.303748       black
##      [5]          1.303748       black
##      ...     ...       ...         ...
##   [8391]          0.658379      grey50
##   [8392]          0.658379       black
##   [8393]          0.658379      grey50
##   [8394]          1.303748       black
##   [8395]          1.944295       black
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##
## ...
## <3 more elements>
```

Some track file format, for instance *bigWig* or *bedGraph* require the `+` and
`-` strands to be separated, because they do not allow overlapping ranges.
This can be done with the (split) function like in the following
example555 The `drop = TRUE` option is needed to remove the `*` level..

```
split(trk, strand(trk), drop = TRUE)
```

```
## GRangesList object of length 2:
## $`+`
## UCSC track 'Zf.30p.dome (TC)'
## UCSCData object with 3778 ranges and 6 metadata columns:
##          seqnames    ranges strand | genes annotation filteredCTSSidx
##             <Rle> <IRanges>  <Rle> | <Rle>      <Rle>           <Rle>
##      [1]    chr17  26222417      + |          unknown           FALSE
##      [2]    chr17  26323229      + |          unknown           FALSE
##      [3]    chr17  26453603      + |         promoter            TRUE
##      [4]    chr17  26453615      + |         promoter           FALSE
##      [5]    chr17  26453632      + |         promoter            TRUE
##      ...      ...       ...    ... .   ...        ...             ...
##   [3774]    chr17  45975288      + |          unknown            TRUE
##   [3775]    chr17  45975289      + |          unknown            TRUE
##   [3776]    chr17  45975290      + |          unknown            TRUE
##   [3777]    chr17  45975292      + |          unknown            TRUE
##   [3778]    chr17  45975293      + |          unknown            TRUE
##                         cluster     score     itemRgb
##                           <Rle> <numeric> <character>
##      [1]                         0.680723      grey50
##      [2]                         0.680723      grey50
##      [3]                         1.394796       black
##      [4]                         0.680723      grey50
##      [5]                         2.122024       black
##      ...                    ...       ...         ...
##   [3774] chr17:45975252-45975..  10.44998       black
##   [3775] chr17:45975252-45975..   1.39480       black
##   [3776] chr17:45975252-45975..   4.34801       black
##   [3777] chr17:45975252-45975..   1.39480       black
##   [3778] chr17:45975252-45975..   2.85793       black
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##
## $`-`
## UCSC track 'Zf.30p.dome (TC)'
## UCSCData object with 3499 ranges and 6 metadata columns:
##          seqnames    ranges strand | genes annotation filteredCTSSidx cluster
##             <Rle> <IRanges>  <Rle> | <Rle>      <Rle>           <Rle>   <Rle>
##      [1]    chr17  26068225      - |          unknown           FALSE
##      [2]    chr17  26068227      - |          unknown           FALSE
##      [3]    chr17  26068233      - |          unknown           FALSE
##      [4]    chr17  26074127      - |          unknown            TRUE
##      [5]    chr17  26113371      - |          unknown           FALSE
##      ...      ...       ...    ... .   ...        ...             ...     ...
##   [3495]    chr17  45901810      - | arf6b   promoter           FALSE
##   [3496]    chr17  45901814      - | arf6b   promoter            TRUE
##   [3497]    chr17  45901816      - | arf6b   promoter            TRUE
##   [3498]    chr17  45975041      - |          unknown           FALSE
##   [3499]    chr17  45999921      - |          unknown           FALSE
##              score     itemRgb
##          <numeric> <character>
##      [1]  0.680723      grey50
##      [2]  0.680723      grey50
##      [3]  0.680723      grey50
##      [4]  1.394796       black
##      [5]  0.680723      grey50
##      ...       ...         ...
##   [3495]  0.680723      grey50
##   [3496]  0.680723       black
##   [3497]  0.680723       black
##   [3498]  0.680723      grey50
##   [3499]  0.680723      grey50
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

For *bigWig* export, the (rtracklayer::export.bw) needs to be run
on each element of the list returned by the (split) command.

For *bedGraph* export, the (rtracklayer::export.bedGraph) command
can take the list as input and will produce a single file containing the
two tracks. (Figure [6](#fig:CTSSbedGraph)) shows an example of *bedGraph*
visualisation.

For *BED* export, the (rtracklayer::export.bed) can operate directly
on the track object.

Other export format probably operate in a way similar to one of the cases
above.

![CAGE data bedGraph track visualized in the UCSC Genome Browser](data:image/svg+xml;base64...)

Figure 6: CAGE data bedGraph track visualized in the UCSC Genome Browser

Interquantile width can also be visualized in a gene-like representation in the
genome browsers by passing quantile information during data conversion to
the *UCSCData* format and then exporting it into a *BED* file:

```
iqtrack <- exportToTrack(ce, what = "tagClusters", qLow = 0.1, qUp = 0.9, oneTrack = FALSE)
iqtrack
```

```
## GRangesList object of length 4:
## $Zf.unfertilized.egg
## UCSC track 'TC'
## UCSCData object with 517 ranges and 8 metadata columns:
##         seqnames            ranges strand |     score   nr_ctss q_0.1 q_0.9
##            <Rle>         <IRanges>  <Rle> | <numeric> <integer> <Rle> <Rle>
##     [1]    chr17 26453632-26453708      + |   26.9709        12    36    72
##     [2]    chr17 26564508-26564610      + |  128.6372        24    17    81
##     [3]    chr17 26595637-26595793      + |  216.9994        35    37   114
##     [4]    chr17 26596033-26596091      + |   10.4200         9     1    50
##     [5]    chr17 26596118-26596127      + |   12.1995         4     1    10
##     ...      ...               ...    ... .       ...       ...   ...   ...
##   [513]    chr17 45700182-45700187      - |   9.61820         3     1     6
##   [514]    chr17 45901329-45901330      - |   1.96213         2     1     2
##   [515]    chr17 45901698-45901710      - |  27.65446         4     1     2
##   [516]    chr17 45901732-45901784      - | 119.96945        15     2    21
##   [517]    chr17 45901814-45901816      - |   3.24804         2     1     3
##         interquantile_width     thick      name        blocks
##                       <Rle> <IRanges> <logical> <IRangesList>
##     [1]                  37  26453667      <NA>    1,36-72,77
##     [2]                  65  26564585      <NA>   1,17-81,103
##     [3]                  78  26595750      <NA>  1,37-114,157
##     [4]                  50  26596070      <NA>       1-50,59
##     [5]                  10  26596118      <NA>          1-10
##     ...                 ...       ...       ...           ...
##   [513]                   6  45700182      <NA>           1-6
##   [514]                   2  45901329      <NA>           1-2
##   [515]                   2  45901698      <NA>        1-2,13
##   [516]                  20  45901749      <NA>     1,2-21,53
##   [517]                   3  45901816      <NA>           1-3
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
##
## ...
## <3 more elements>
```

```
#rtracklayer::export.bed(iqtrack, "outputFileName.bed")
```

In this gene-like representation (Figure [7](#fig:tagClustersBed)), the oriented line shows the
full span of the cluster, filled block marks the interquantile width and a single base-pair thick
block denotes the position of the dominant TSS.

![Tag clusters visualization in the genome browser](data:image/svg+xml;base64...)

Figure 7: Tag clusters visualization in the genome browser

## 3.12 Expression profiling

The CAGE signal is a quantitative measure of promoter activity. In *CAGEr*,
normalised expression scores of individual CTSSs or consensus clusters can be
clustered in *expression classes*. Two unsupervised clustering algorithms are
supported: kmeans and self-organizing maps (SOM). Both require to specify a
number of clusters in advance. Results are stored in the `exprClass` *metadata
column* of the CTSS or consensus clusters genomic ranges, and the
`expressionClass` accessor function is provided for convenience.

In the example below, we perform expression clustering at the level of entire
promoters using SOM algorithm with 4 × 2 dimensions and applying it only to
consensus clusters with a normalized CAGE signal of at least 10 TPM in at least
one sample.

```
ce <- getExpressionProfiles(ce, what = "consensusClusters", tpmThreshold = 10,
  nrPassThreshold = 1, method = "som", xDim = 4, yDim = 2)

consensusClustersGR(ce)$exprClass |> table(useNA = "always")
```

```
##
##  0_0  0_1  1_0  1_1  2_0  2_1  3_0  3_1 <NA>
##   46   49   25   19   15    5    6   45   75
```

Distribution of expression across samples for the 8 clusters returned by SOM can
be visualized using the `plotExpressionProfiles` function
as shown in Figure [**??**](#fig:ConsensusClustersExpressionProfiles):

```
plotExpressionProfiles(ce, what = "consensusClusters")
```

```
## Warning in ggplot2::scale_x_log10(): log-10 transformation introduced infinite
## values.
```

```
## Warning: Removed 103 rows containing non-finite outside the scale range
## (`stat_ydensity()`).
```

![](data:image/png;base64...)

![Expression clusters](data:image/svg+xml;base64...)

(#fig:ConsensusClustersExpressionProfiles\_svg)Expression clusters

Each cluster is shown in different color and is marked by its label and the
number of elements (promoters) in the cluster. We can extract promoters
belonging to a specific cluster by typing commands like:

```
consensusClustersGR(ce) |> subset(consensusClustersGR(ce)$exprClass ==  "0_1")
```

```
## ConsensusClusters object with 49 ranges and 8 metadata columns:
##                             seqnames            ranges strand |
##                                <Rle>         <IRanges>  <Rle> |
##   chr17:26645157-26645514:+    chr17 26645157-26645514      + |
##   chr17:26651964-26652050:+    chr17 26651964-26652050      + |
##   chr17:28161574-28161757:+    chr17 28161574-28161757      + |
##   chr17:28670871-28670986:+    chr17 28670871-28670986      + |
##   chr17:28683436-28683585:+    chr17 28683436-28683585      + |
##                         ...      ...               ...    ... .
##   chr17:43639501-43639675:-    chr17 43639501-43639675      - |
##   chr17:43910083-43910371:-    chr17 43910083-43910371      - |
##   chr17:44487317-44487409:-    chr17 44487317-44487409      - |
##   chr17:45175977-45175990:-    chr17 45175977-45175990      - |
##   chr17:45545922-45545996:-    chr17 45545922-45545996      - |
##                                        score    dominant_ctss   nr_ctss
##                                        <Rle>           <CTSS> <integer>
##   chr17:26645157-26645514:+ 2818.40482968203 chr17:26645160:+        92
##   chr17:26651964-26652050:+ 72.8417558520884 chr17:26652002:+        13
##   chr17:28161574-28161757:+ 1305.40900274216 chr17:28161692:+        53
##   chr17:28670871-28670986:+ 3142.30648416071 chr17:28670882:+        52
##   chr17:28683436-28683585:+  822.70299120256 chr17:28683496:+        44
##                         ...              ...              ...       ...
##   chr17:43639501-43639675:- 297.617148143508 chr17:43639621:-        39
##   chr17:43910083-43910371:- 2488.62120758589 chr17:43910245:-        94
##   chr17:44487317-44487409:- 1619.09807160225 chr17:44487371:-        37
##   chr17:45175977-45175990:- 35.1668012378721 chr17:45175986:-         4
##   chr17:45545922-45545996:- 919.561599189015 chr17:45545991:-        32
##                             annotation    genes q_0.1 q_0.9 exprClass
##                                  <Rle>    <Rle> <Rle> <Rle>     <Rle>
##   chr17:26645157-26645514:+   promoter   pgrmc2     1   110       0_1
##   chr17:26651964-26652050:+       exon   pgrmc2    22    81       0_1
##   chr17:28161574-28161757:+   promoter  TMEM30B    64   181       0_1
##   chr17:28670871-28670986:+   promoter MIS18BP1     3    65       0_1
##   chr17:28683436-28683585:+   promoter  heatr5a    49    77       0_1
##                         ...        ...      ...   ...   ...       ...
##   chr17:43639501-43639675:-   promoter  zfyve28    90   164       0_1
##   chr17:43910083-43910371:-   promoter   ahsa1l   115   252       0_1
##   chr17:44487317-44487409:-   promoter    exoc5     1    70       0_1
##   chr17:45175977-45175990:-   promoter  fam161b    10    14       0_1
##   chr17:45545922-45545996:-   promoter  znf106a    27    70       0_1
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

Consensus clusters and information on their expression profile can be exported
to a BED file, which allows visualization of the promoters in the genome browser
colored in the color of the expression cluster they belong to
(Figure [8](#fig:ConsensusClustersBed):

```
cc_iqtrack <- exportToTrack(ce, what = "consensusClusters", colorByExpressionProfile = TRUE)
cc_iqtrack
```

```
## UCSC track 'TC'
## UCSCData object with 285 ranges and 9 metadata columns:
##         seqnames            ranges strand |     score   nr_ctss annotation
##            <Rle>         <IRanges>  <Rle> | <numeric> <integer>      <Rle>
##     [1]    chr17 26453647-26453719      + |   174.694        22   promoter
##     [2]    chr17 26564524-26564591      + |   308.691        27   promoter
##     [3]    chr17 26595673-26595750      + |   891.068        34   promoter
##     [4]    chr17 26596033-26596339      + |   321.610        57   promoter
##     [5]    chr17 26645157-26645514      + |  2818.405        92   promoter
##     ...      ...               ...    ... .       ...       ...        ...
##   [281]    chr17 45534727-45534729      - |  176.5030         3     intron
##   [282]    chr17 45545922-45545996      - |  919.5616        32   promoter
##   [283]    chr17 45554314-45554345      - |   44.0059         6   promoter
##   [284]    chr17 45700092-45700187      - |   39.7368         8       exon
##   [285]    chr17 45901695-45901752      - |  846.5649        22   promoter
##           genes q_0.1 q_0.9 exprClass     thick      name
##           <Rle> <Rle> <Rle>     <Rle> <IRanges> <logical>
##     [1]   ttc7b    21    57       1_1  26453701      <NA>
##     [2]   nrde2     1    64       0_0  26564585      <NA>
##     [3]  larp1b    12    78       1_0  26595750      <NA>
##     [4]  larp1b    34   266       1_0  26596198      <NA>
##     [5]  pgrmc2     1   110       0_1  26645160      <NA>
##     ...     ...   ...   ...       ...       ...       ...
##   [281] znf106a     1     3       3_1  45534727      <NA>
##   [282] znf106a    27    70       0_1  45545991      <NA>
##   [283] tmem206     1    32       2_0  45554339      <NA>
##   [284]   susd4     4    93      <NA>  45700182      <NA>
##   [285]   arf6b     4    55       1_1  45901749      <NA>
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

```
#rtracklayer::export.bed(cc_iqtrack, "outputFileName.bed")
```

![Consensus clusters colored by expression profile in the genome browser](data:image/svg+xml;base64...)

Figure 8: Consensus clusters colored by expression profile in the genome browser

Expression profiling of individual TSSs is done using the same procedure as
described above for consensus clusters, only by setting `wha = "CTSS"` in all
of the functions.

## 3.13 Differential expression analysis

The raw expression table for the consensus clusters can be exported to the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*
package for differential expression analysis. For this, the column data needs to contain
factors that can group the samples. They can have any name.

```
ce$group <- factor(c("a", "a", "b", "b"))
dds <- consensusClustersDESeq2(ce, ~group)
```

## 3.14 Shifting promoters

As shown in Figure [7](#fig:tagClustersBed), TSSs within the same promoter
region can be used differently in different samples. Thus, although the overall
transcription level from a promoter does not change between the samples, the
differential usage of TSSs or *promoter shifting* may indicate changes in the
regulation of transcription from that promoter, which cannot be detected by
expression profiling. To detect this promoter shifting, a method described in
@[Haberle:2014] has been implemented in *CAGEr*. Shifting can be detected
between two individual samples or between two groups of samples. In the latter
case, samples are first merged into groups and then compared in the same way as
two individual samples. For all promoters a shifting score is calculated based
on the difference in the cumulative distribution of CAGE signal along that
promoter in the two samples. In addition, a more general assessment of
differential TSS usage is obtained by performing Kolmogorov-Smirnov test on the
cumulative distributions of CAGE signal, as described below. Thus, prior to
shifting score calculation and statistical testing, we have to calculate
cumulative distribution along all consensus clusters:

```
ce <- cumulativeCTSSdistribution(ce, clusters = "consensusClusters")
```

Next, we calculate a shifting score and P-value of Kolmogorov-Smirnov test for
all promoters comparing two specified samples:

```
ce <- scoreShift(ce, groupX = "Zf.unfertilized.egg", groupY = "Zf.prim6",
        testKS = TRUE, useTpmKS = FALSE)
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x[nrow(x), ]): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x[, less.tpm]): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupX"]): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
## Warning in max(x[, "groupY"]): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

```
## Warning in max(cumsum.matrix[, 1]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(cumsum.matrix[, 2]): no non-missing arguments to max; returning
## -Inf
```

```
## Warning in max(abs(z)): no non-missing arguments to max; returning -Inf
```

This function will calculate shifting score as illustrated in
Figure [9](#fig:ShiftingScore). Values of shifting score are in range between
`-Inf` and `1`. Positive values can be interpreted as the proportion of
transcription initiation in the sample with lower expression that is happening
“outside” (either upstream or downstream) of the region used for transcription
initiation in the other sample. In contrast, negative values indicate no
physical separation, *i.e.* the region used for transcription initiation in the
sample with lower expression is completely contained within the region used for
transcription initiation in the other sample. Thus, shifting score detects only
the degree of upstream or downstream shifting, but does not detect more general
changes in TSS rearrangement in the region, *e.g.* narrowing or broadening of
the region used for transcription.

![Calculation of shifting score](data:image/svg+xml;base64...)

Figure 9: Calculation of shifting score

We can select a subset of promoters with shifting score and/or FDR above specified threshold:

```
# Not supported yet for CAGEexp objects, sorry.
shifting.promoters <- getShiftingPromoters(ce,
    groupX = "Zf.unfertilized.egg", groupY = "Zf.prim6",
        tpmThreshold = 5, scoreThreshold = 0.6,
        fdrThreshold = 0.01)
head(shifting.promoters)
```

```
## DataFrame with 6 rows and 10 columns
##                                consensus.cluster            score
##                                      <character>            <Rle>
## chr17:26595673-26595750:+ chr17:26595673-26595.. 891.067717359328
## chr17:33502378-33502474:+ chr17:33502378-33502.. 44.2579848065936
## chr17:33581354-33581420:+ chr17:33581354-33581.. 85.2931212908049
## chr17:35410890-35410920:+ chr17:35410890-35410.. 302.462154410648
## chr17:37383275-37383398:+ chr17:37383275-37383.. 83.1331472328768
## chr17:37395388-37395497:+ chr17:37395388-37395.. 295.076875810844
##                                      score
##                                      <Rle>
## chr17:26595673-26595750:+ 891.067717359328
## chr17:33502378-33502474:+ 44.2579848065936
## chr17:33581354-33581420:+ 85.2931212908049
## chr17:35410890-35410920:+ 302.462154410648
## chr17:37383275-37383398:+ 83.1331472328768
## chr17:37395388-37395497:+ 295.076875810844
##                           shifting.score.Zf.unfertilized.egg.Zf.prim6
##                                                             <numeric>
## chr17:26595673-26595750:+                                    0.703858
## chr17:33502378-33502474:+                                    0.654196
## chr17:33581354-33581420:+                                    0.602743
## chr17:35410890-35410920:+                                    0.609506
## chr17:37383275-37383398:+                                    0.733289
## chr17:37395388-37395497:+                                    0.659035
##                           groupX.pos.Zf.unfertilized.egg groupY.pos.Zf.prim6
##                                                <integer>           <integer>
## chr17:26595673-26595750:+                       26595751            26595710
## chr17:33502378-33502474:+                       33502455            33502379
## chr17:33581354-33581420:+                       33581375            33581408
## chr17:35410890-35410920:+                       35410921            35410894
## chr17:37383275-37383398:+                       37383278            37383376
## chr17:37395388-37395497:+                       37395411            37395469
##                           groupX.tpm.Zf.unfertilized.egg groupY.tpm.Zf.prim6
##                                                <numeric>           <numeric>
## chr17:26595673-26595750:+                       188.0397            233.7861
## chr17:33502378-33502474:+                        15.2911              9.3698
## chr17:33581354-33581420:+                        22.5912             15.1074
## chr17:35410890-35410920:+                        93.1385             67.0356
## chr17:37383275-37383398:+                        14.0695             44.9775
## chr17:37395388-37395497:+                        58.4980            134.5016
##                           pvalue.KS.Zf.unfertilized.egg.Zf.prim6
##                                                        <numeric>
## chr17:26595673-26595750:+                            0.00000e+00
## chr17:33502378-33502474:+                            2.09475e-05
## chr17:33581354-33581420:+                            1.04406e-05
## chr17:35410890-35410920:+                            0.00000e+00
## chr17:37383275-37383398:+                            2.68232e-11
## chr17:37395388-37395497:+                            0.00000e+00
##                           fdr.KS.Zf.unfertilized.egg.Zf.prim6
##                                                     <numeric>
## chr17:26595673-26595750:+                         0.00000e+00
## chr17:33502378-33502474:+                         4.94267e-05
## chr17:33581354-33581420:+                         2.49150e-05
## chr17:35410890-35410920:+                         0.00000e+00
## chr17:37383275-37383398:+                         1.11803e-10
## chr17:37395388-37395497:+                         0.00000e+00
```

The `getShiftingPromoters` function returns genomic coordinates, shifting score
and P-value (FDR) of the promoters, as well as the value of CAGE signal and
position of the dominant TSS in the two compared (groups of) samples.
Figure [10](#fig:ShiftingPromoter) shows the difference in the CAGE signal
between the two compared samples for one of the selected high-scoring shifting
promoters.

![Example of shifting promoter](data:image/svg+xml;base64...)

Figure 10: Example of shifting promoter

## 3.15 Enhancers

The FANTOM5 project reported that “*enhancer activity can be detected through
the presence of balanced bidirectional capped transcripts*” (Andersson et al. [2014](#ref-Andersson:2014)).
The *CAGEr* package is providing a wrapper to the *CAGEfightR* package’s
function `quickEnhancers` so that it can run directly on *CAGEexp* objects.
The wrapper returns a modified *CAGEexp* object in which the results are stored
in its `enhancers` experiment slot.

```
ce <- quickEnhancers(ce)
ce[["enhancers"]]
```

```
## class: RangedSummarizedExperiment
## dim: 35 4
## metadata(0):
## assays(1): counts
## rownames(35): chr17:26596449-26596878 chr17:26690165-26690757 ...
##   chr17:45175861-45176390 chr17:45611150-45611574
## rowData names(4): score thick balance bidirectionality
## colnames(4): Zf.unfertilized.egg Zf.high Zf.30p.dome Zf.prim6
## colData names(11): inputFiles inputFilesType ... group Name
```

# 4 Appendix

## 4.1 Creating a `CAGEexp` object by coercing a data frame

A *CAGEexp* object can also be created directly by coercing a data frame containing single base-pair
TSS information. To be able to do the coercion into a *CAGEexp*, the data frame must conform with
the following:

* The data frame must have at least 4 columns;
* the first three columns must be named `chr`, `pos` and `strand`, and contain chromosome name,
  1-based genomic coordinate of the TSS (positive integer) and TSS strand information (`+` or
  `-`), respectively;
* these first three columns must be of the class `character`, `integer` and `character`,
  respectively;
* all additional columns must be of the class `integer` and should contain raw CAGE tag counts
  (non-negative integer) supporting each TSS in different samples (columns). At least one such
  column with tag counts must be present;
* the names of the columns containing tag counts must begin with a letter, and these column names
  are used as sample labels in the resulting *CAGEexp* object.

An example of such data frame is shown below:

```
TSS.df <- read.table(system.file( "extdata/Zf.unfertilized.egg.chr17.ctss"
                                , package = "CAGEr"))
# make sure the column names are as required
colnames(TSS.df) <- c("chr", "pos", "strand", "Zf.unfertilized.egg")
# make sure the column classes are as required
TSS.df$chr <- as.character(TSS.df$chr)
TSS.df$pos <- as.integer(TSS.df$pos)
TSS.df$strand <- as.character(TSS.df$strand)
TSS.df$Zf.unfertilized.egg <- as.integer(TSS.df$Zf.unfertilized.egg)
head(TSS.df)
```

```
##     chr      pos strand Zf.unfertilized.egg
## 1 chr17 26050540      +                   1
## 2 chr17 26074127      -                   2
## 3 chr17 26074129      -                   3
## 4 chr17 26222545      -                   1
## 5 chr17 26322780      -                   1
## 6 chr17 26322832      -                   2
```

This data.frame can now be coerced to a *CAGEexp* object, which will fill the corresponding slots
of the object with provided TSS information:

```
ce.coerced <- as(TSS.df, "CAGEexp")
ce.coerced
```

```
## A CAGEexp object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] tagCountMatrix: RangedSummarizedExperiment with 8395 rows and 1 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## 4.2 Summary of the CAGEr accessor functions

Originally there was one accessor per slot in *CAGEset* objects (the original
*CAGEr* format), but now that I added the *CAGEexp* class, that uses different
underlying formats, the number of accessors increased because a) I provide
the old ones for backwards compatibility and b) there multiple possible output
formats.

Before releasing this CAGEr update in Bioconductor, I would like to be sure
that the number of accessors and the name scheme are good enough.

Please let me know your opinion about the names and scope of the accessors below:

### 4.2.1 CTSS data

| Name | Output |
| --- | --- |
| CTSScoordinatesGR | Coordinate table in GRanges format. |
| CTSStagCountDF | Raw CTSS counts in integer Rle DataFrame format. |
| CTSStagCountGR | Raw CTSS counts in GRanges format (single samples). |
| CTSStagCountSE | RangedSummarizedExperiment containing an assay for the Raw CTSS counts. |
| CTSSnormalizedTpmDF | Normalised CTSS values in Rle DataFrame format. |
| CTSSnormalizedTpmGR | Normalised CTSS values in GRanges format (single samples). |

### 4.2.2 Cluster data

| Name | Output |
| --- | --- |
| consensusClustersDESeq2 | Consensus cluster coordinates and expression matrix in DESeq2 format. |
| consensusClustersGR | Consensus cluster coordinates in GRanges format. |
| consensusClustersSE | Consensus cluster coordinates and expression matrix in RangedSummarizedExperiment format. |
| consensusClustersTpm | Consensus cluster coordinates and raw expression matrix. |
| tagClustersGR | Per-sample GRangesList of tag cluster coordinates. |

### 4.2.3 Gene data

| Name | Output |
| --- | --- |
| GeneExpDESeq2 | Gene expression data in DESeq2 format. |
| GeneExpSE | Gene expression data in SummarizedExperiment format. |

## 4.3 Summary of the *CAGEexp* experiment slots and assays

A *CAGEexp* object can contain the following experiments.

Please let me know your opinion about the names

| Name | Assays | Comment |
| --- | --- | --- |
| tagCountMatrix | counts, normalizedTpmMatrix | RangedSummarizedExperiment |
| seqNameTotals | counts, norm | SummarizedExperiment |
| consensusClusters | counts, normalized, q\_x, q\_y | RangedSummarizedExperiment |
| geneExpMatrix | counts | SummarizedExperiment |

### 4.3.1 CAGEexp assays

| Name | Experiment | Comment |
| --- | --- | --- |
| counts | tagCountMatrix | Integer Rle DataFrame of CTSS raw counts. |
| counts | seqNameTotals | Numeric matrix of total counts per chromosome. |
| counts | consensusClusters | Integer matrix of consensus cluster expression counts. |
| counts | geneExpMatrix | Integer matrix of gene expression counts. |
| normalizedTpmMatrix | tagCountMatrix | Numeric matrix of normalised CTSS expression scores. |
| norm | seqNameTotals | Numeric matrix of percent total counts per chromosome. |
| normalized | consensusClusters | Numeric matrix of normalised CC expression scores. |
| q\_x, q\_y, q\_z, … | consensusClusters | Interger Rle DataFrame of relative quantile positions |

## 4.4 Summary of the CAGEr classes

The CTSS, CTSS.chr, TagCluster and ConsensusClsuters are mostly used internally
or type safety and preventing me (Charles) from mixing up inputs. They
are visible from the outside. Should they be used more extensively ? Can they
be replaced by more “core” Bioconductor classes ?

| Name | Comment |
| --- | --- |
| CAGEset | The original CAGEr class, based on data frames and matrices. |
| CAGEexp | The new CAGEr class, based on GRanges, DataFrames, etc. |
| CAGEr | Union class for functions that accept both CAGEset and CAGEexp. |
| CTSS | Wraps GRanges and guarantees that width equals 1. |
| CTSS.chr | Same as CTSS but also guarantees the there is only one chromosome (useful in some loops) |
| TagClusters | Wraps GRanges, represents the fact that each sample has their own tag clusters. |
| ConsensusClusters | Wraps GRanges, represents the fact that they are valid for all the samples. |
| CAGErCluster | Union class for functions that accept both TagClusters and ConsensusClusters. |

## 4.5 Paired-end CAGE read alignment with the *nf-core/rnaseq* pipeline

The modern CAGE protocols starting from *nAnTi-CAGE* (Murata et al. [2014](#ref-Murata:2014)) onward can be
sequenced paired-end when they are random-primed. Many aligners can map the
read pairs but it is important to pay attention to the way they encode the
existence of unmapped extra G bases in their output (typically in BAM format).

*CAGEr* is able to read the BAM files of the HiSAT2 aligner produced by the
[*nf-co.re/rnaseq* pipeline](https://nf-co.re/rnaseq). One of the benefits of
using a full pipeline to produce the alignment files is that the results will
include some quality controls that can be used to identify defects before
investing more time in the *CAGEr* analysis. Optionally, the first 6 or 9 bases
(depending on the protocol) of Read 2 may be clipped, as they originate from the
random primer and not from the RNA. However, forgetting to do so has very
little impact on the results.

# Session info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Drerio.UCSC.danRer7_1.4.0 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                 BiocIO_1.20.0
##  [5] Biostrings_2.78.0                  XVector_0.50.0
##  [7] FANTOM3and4CAGE_1.45.0             CAGEr_2.16.0
##  [9] MultiAssayExperiment_1.36.0        SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0                     GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                      IRanges_2.44.0
## [15] S4Vectors_0.48.0                   BiocGenerics_0.56.0
## [17] generics_0.1.4                     MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       rstudioapi_0.17.1        jsonlite_2.0.0
##   [4] magrittr_2.0.4           magick_2.9.0             GenomicFeatures_1.62.0
##   [7] farver_2.1.2             rmarkdown_2.30           vctrs_0.6.5
##  [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
##  [13] base64enc_0.1-3          tinytex_0.57             htmltools_0.5.8.1
##  [16] S4Arrays_1.10.0          BiocBaseUtils_1.12.0     progress_1.2.3
##  [19] curl_7.0.0               SparseArray_1.10.0       Formula_1.2-5
##  [22] sass_0.4.10              KernSmooth_2.23-26       bslib_0.9.0
##  [25] htmlwidgets_1.6.4        plyr_1.8.9               Gviz_1.54.0
##  [28] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [31] lifecycle_1.0.4          pkgconfig_2.0.3          Matrix_1.7-4
##  [34] R6_2.6.1                 fastmap_1.2.0            digest_0.6.37
##  [37] colorspace_2.1-2         AnnotationDbi_1.72.0     DESeq2_1.50.0
##  [40] Hmisc_5.2-4              RSQLite_2.4.3            vegan_2.7-2
##  [43] labeling_0.4.3           filelock_1.0.3           mgcv_1.9-3
##  [46] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [49] withr_3.0.2              bit64_4.6.0-1            htmlTable_2.4.3
##  [52] S7_0.2.0                 backports_1.5.0          CAGEfightR_1.30.0
##  [55] BiocParallel_1.44.0      DBI_1.2.3                biomaRt_2.66.0
##  [58] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [61] rjson_0.2.23             permute_0.9-8            gtools_3.9.5
##  [64] tools_4.5.1              foreign_0.8-90           ggseqlogo_0.2
##  [67] nnet_7.3-20              glue_1.8.0               restfulr_0.0.16
##  [70] nlme_3.1-168             stringdist_0.9.15        grid_4.5.1
##  [73] checkmate_2.3.3          reshape2_1.4.4           cluster_2.1.8.1
##  [76] operator.tools_1.6.3     gtable_0.3.6             formula.tools_1.7.1
##  [79] ensembldb_2.34.0         data.table_1.17.8        hms_1.1.4
##  [82] pillar_1.11.1            stringr_1.5.2            splines_4.5.1
##  [85] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [88] bit_4.6.0                deldir_2.0-4             biovizBase_1.58.0
##  [91] tidyselect_1.2.1         locfit_1.5-9.12          knitr_1.50
##  [94] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [97] xfun_0.53                VGAM_1.1-13              stringi_1.8.7
## [100] UCSC.utils_1.6.0         lazyeval_0.2.2           yaml_2.3.10
## [103] som_0.3-5.2              evaluate_1.0.5           codetools_0.2-20
## [106] cigarillo_1.0.0          interp_1.1-6             tibble_3.3.0
## [109] BiocManager_1.30.26      cli_3.6.5                rpart_4.1.24
## [112] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
## [115] GenomeInfoDb_1.46.0      dbplyr_2.5.1             png_0.1-8
## [118] XML_3.99-0.19            parallel_4.5.1           ggplot2_4.0.0
## [121] assertthat_0.2.1         blob_1.2.4               prettyunits_1.2.0
## [124] latticeExtra_0.6-31      jpeg_0.1-11              AnnotationFilter_1.34.0
## [127] bitops_1.0-9             VariantAnnotation_1.56.0 scales_1.4.0
## [130] crayon_1.5.3             rlang_1.1.6              KEGGREST_1.50.0
```

# References

Andersson, Robin, Claudia Gebhard, Irene Miguel-Escalada, Ilka Hoof, Jette Bornholdt, Mette Boyd, Yun Chen, et al. 2014. “An atlas of active enhancers across human cell types and tissues.” *Nature* 507 (7493): 455–61.

Balwierz, Piotr J, Piero Carninci, Carsten O Daub, Jun Kawai, Yoshihide Hayashizaki, Werner Van Belle, Christian Beisel, and Erik van Nimwegen. 2009. “Methods for analyzing deep sequencing expression data: constructing the human and mouse promoterome with deepCAGE data.” *Genome Biology* 10 (7): R79.

Carninci, Piero, Albin Sandelin, Boris Lenhard, Shintaro Katayama, Kazuro Shimokawa, Jasmina Ponjavic, Colin A M Semple, et al. 2006. “Genome-wide analysis of mammalian promoter architecture and evolution.” *Nature Genetics* 38 (6): 626–35.

Carninci, P, C Kvam, A Kitamura, T Ohsumi, Y Okazaki, M Itoh, M Kamiya, et al. 1996. “High-efficiency full-length cDNA cloning by biotinylated CAP trapper.” *Genomics* 37 (3): 327–36.

Frith, M C, E Valen, A Krogh, Y Hayashizaki, P Carninci, and A Sandelin. 2007. “A code for transcription initiation in mammalian genomes.” *Genome Research* 18 (1): 1–12.

Haberle, Vanja, Alistair R R Forrest, Yoshihide Hayashizaki, Piero Carninci, and Boris Lenhard. 2015. “CAGEr: precise TSS data retrieval and high-resolution promoterome mining for integrative analyses.” *Nucleic Acids Research* Epub ahead of print (2015 Feb 4). <https://doi.org/10.1093/nar/gkv054>.

Kodzius, Rimantas, Miki Kojima, Hiromi Nishiyori, Mari Nakamura, Shiro Fukuda, Michihira Tagami, Daisuke Sasaki, et al. 2006. “CAGE: cap analysis of gene expression.” *Nature Methods* 3 (3): 211–22.

Murata, Mitsuyoshi, Hiromi Nishiyori-Sueki, Miki Kojima-Ishiyama, Piero Carninci, Yoshihide Hayashizaki, and Masayoshi Itoh. 2014. “Detecting Expressed Genes Using CAGE.” In *Transcription Factor Regulatory Networks: Methods and Protocols*, edited by Etsuko Miyamoto-Sato, Hiroyuki Ohashi, Hirotaka Sasaki, Jun-ichi Nishikawa, and Hiroshi Yanagawa, 67–85. Methods in Molecular Biology. New York, NY: Springer. <https://doi.org/10.1007/978-1-4939-0805-9_7>.

Nepal, Chirag, Yavor Hadzhiev, Christopher Previti, Vanja Haberle, Nan Li, Hazuki Takahashi, Ana Maria S. Suzuki, et al. 2013. “Dynamic regulation of coding and non-coding transcription initiation landscape at single nucleotide resolution during vertebrate embryogenesis.” *Genome Research* 23 (11): 1938–50.

Takahashi, Hazuki, Timo Lassmann, Mitsuyoshi Murata, and Piero Carninci. 2012. “5’ end-centered expression profiling using cap-analysis gene expression and next-generation sequencing.” *Nature Protocols* 7 (3): 542–61.