# A walkthrough the easyRNASeq package functionalities

#### Nicolas Delhomme

#### 2025-10-29

* [Introduction](#introduction)
* [Annotation parameters - AnnotParam](#annotation-parameters---annotparam)
* [Synthetic transcripts - createSyntheticTranscripts](#synthetic-transcripts---createsynthetictranscripts)
  + [Alternatives](#alternatives)
* [Bam Parameters - BamParam](#bam-parameters---bamparam)
* [RNA-Seq parameters - RnaSeqParam](#rna-seq-parameters---rnaseqparam)
* [simple RNA-Seq](#simple-rna-seq)
* [Session Info](#session-info)
* [Appendix](#appendix)
* [References](#references)

# Introduction

This vignette provides the implementation of the procedure described in point 7 of our **Guidelines for RNA-Seq data analysis**[1](#fn1) protocol available from the **Epigenesys** [website](http://www.epigenesys.eu).

Briefly, it details the step necessary to: 1. create a non-redundant annotation

2. count reads per feature
3. pre-analyse the data, i.e. assess the pertinence of the samples’ charateristics in the light of their biological provenance; *i.e.* in other words perform a so called *“biological QA”* using assessment methods such as *Principal Component Analysis*, *Multi-dimensional Scaling*, *Hierarcical Clustering*, *etc.*

The aim of this vignette is to go through these steps using the **easyRNASeq** package, hence the rationale of the implementation will not be discussed, albeit relevant litterature will be pointed at when necessarry.

Throughout this vignette we are going to replicate the analysis conducted in Robinson, Delhomme et al.(Robinson et al. 2014), a study looking at *sexual dimorphism* in *Eurasian aspen*.

To perform the listed steps, we need to instantiate a number of objects to store the minimal set of parameters describing the conducted **RNA-Seq** experiment, *e.g.* the BAM files location, the annotation location and type, the sequencing parameters, *etc.*

To get started with this process, we load the package into our R session:

```
library(easyRNASeq)
```

before instantiating an **AnnotParam** object informing on the location and type of the annotation to be used.

---

# Annotation parameters - AnnotParam

The **AnnotParam** class is meant to store the minimal set of information necessary to retrieve the annotation

The minimal information to provide is:

1. a datasource: a path to a file provided as a character string or if the *type* is biomaRt, the datasource you want to connect to, as retrieved using the **biomaRt** **datasource** function.
2. a type: one of “gff3”,“gtf”,“rda”, and “biomaRt”. *gff3* is the default. If *rda* is used, it expects the corresponding file to contain a *GRanges* object by the name of *gAnnot*.

In this tutorial, we will reproduce the analysis performed in *Robinson, Delhomme et al.* (Robinson et al. 2014). For that we will start by downloading the original annotation gff3 file for *P. trichocarpa*, a close related species of the trees used in the study into the current directory.

```
download.file(url=paste0("ftp://ftp.plantgenie.org/Data/PopGenIE/",
                         "Populus_trichocarpa/v3.0/v10.1/GFF3/",
                         "Ptrichocarpa_210_v3.0_gene_exons.gff3.gz"),
                  destfile=,"./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz")
```

```
## [1] TRUE
```

Before instantiating an “AnnotParam” object.

```
    annotParam <- AnnotParam(
        datasource="./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz")
```

This annotation file however contains multiple copy of the same exons, *i.e.* when exons are shared by several isoforms of a gene. This might result in so-called “multiple-counting” and as described in these guidelines[2](#fn2), we will to circumvent that issue create a set of synthetic transcripts.

---

# Synthetic transcripts - createSyntheticTranscripts

One major caveat of estimating gene expression using aligned RNA-Seq reads is that a single read, which originated from a single mRNA molecule, might sometimes align to several features (e.g. transcripts or genes) with alignments of equivalent quality.

This, for example, might happen as a result of gene duplication and the presence of repetitive or common domains. To avoid counting unique mRNA fragments multiple times, the stringent approach is to keep only uniquely mapping reads - being aware of potential consequences, see the note below.

Not only can multiple counting arise from a biological reason, but also from technical artifacts, introduced mostly by poorly formatted gff3/gtf annotation files. To avoid this, it is best practice to adopt a conservative approach by collapsing all existing transcripts of a single gene locus into a **synthetic** transcript containing every exon of that gene. In the case of overlapping exons, the longest genomic interval is kept, i.e. an artificial exon is created. This process results in a flattened transcript: a gene structure with a one to one relationship.

To create such a structure, we use the **createSyntheticTranscripts** function on the file we just downloaded, simply by passing our **annotParam** object as argument.

```
annotParam <- createSyntheticTranscripts(annotParam,verbose=FALSE)
```

This function returns an updated annotParam object that contains the newly created, flattened transcript annotation. This object can then be saved as an *rda* file for later re-use or for sharing with collaborators.

```
save(annotParam,
file="./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda")
```

## Alternatives

Instead of updating the *annotParam* object, we could have created an object of class **Genome\_Intervals** from the **genomeIntervals** package, using the same function but using the actual *datasource* of the previous *annotParam* object as argument rather than the object itself.

```
gI <- createSyntheticTranscripts(
    "./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
    verbose=FALSE)
```

This *gI* object can then be exported as a gff3 file.

```
writeGff3(gI,
          file="./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts.gff3.gz")
```

---

**Note:** Ignoring multi-mapping reads may introduce biases in the read counts of some genes (such as that of paralogs or of very conserved gene families), but in the context of a conservative first analysis we are of the current opinion that they are best ignored. One should of course assess how many reads are multi-mapping (check for example the STAR output) and possibly extract them from the alignment read file to visualize them using a genome browser so as to understand where they are located and how they may affect any analysis. Based on this, one may, at a later stage, decide to relax the counting parameters to accept multi-mapping reads.

---

# Bam Parameters - BamParam

High throughput sequencing RNA-Seq data comes in a multitude of *flavours*, *i.e.* even from a single provider, protocol - *e.g.* strand specific, paired-end - reads characteristics - *e.g.* read length - will vary.

The **easyRNASeq simpleRNASeq** method will infer these information based on excerpts sampled from the data. However, it is always best to provide these information, as 1. the inference is done on small excerpt and can fail 2. it is always good to document an analysis

By default **easyRNASeq simpleRNASeq** will keep the inferred parameters over the user-provided parameters if these do not agree and emit corresponding warnings. The choice to rely on inferred parameters over user-provided one is to enforce user to cross-validate their knowledge of the data characteristics, as these are crucial for an adequate processing. Remember GIGO[3](#fn3).

If the *automatic inference* does fail, please let me know, so that I optimise it. Meanwhile, you can use the **override** argument to enforce the use of user-passed parameters.

To reproduce the results from *Robinson, Delhomme et al.* (Robinson et al. 2014), we first need to download an excerpt of the data.

We first retrieve the file listing and md5 codes

```
download.file(url=paste0("ftp://ftp.plantgenie.org/Tutorials/RnaSeqTutorial/",
                         "data/star/md5.txt"),
                  destfile="md5.txt")
```

In this part of the vignette, we will *NOT* process all the data, albeit it would be possible, but for the sake of brevity, we will only retrieve the six first datasets. We get these from the sample information contained within this package.

```
data(RobinsonDelhomme2014)
lapply(RobinsonDelhomme2014[1:6,"Filename"],function(f){
    # BAM files
    download.file(url=paste0("ftp://ftp.plantgenie.org/Tutorials/",
                             "RnaSeqTutorial/data/star/",f),
                  destfile=as.character(f))
    # BAM index files
    download.file(url=paste0("ftp://ftp.plantgenie.org/Tutorials/",
                             "RnaSeqTutorial/data/star/",f,".bai"),
                  destfile=as.character(paste0(f,".bai")))
})
```

```
## [[1]]
## [1] TRUE
##
## [[2]]
## [1] TRUE
##
## [[3]]
## [1] TRUE
##
## [[4]]
## [1] TRUE
##
## [[5]]
## [1] TRUE
##
## [[6]]
## [1] TRUE
```

These six files - as the rest of the dataset - have been sequenced on an Illumina HiSeq 2500 in paired-end mode using a non-strand specific library protocol with a read length of 100 bp. The raw data have been processed as described in the aforementioned guidelines[4](#fn4) and as such have been filtered for rRNA sequences, trimmed for adapters and clipped for quality. The resulting reads (of length 50-100bp) have then been aligned using STAR [Dobin:2013p5293].

Using these information, we finally generate the **BamParam** object.

```
bamParam <- BamParam(paired = TRUE,
                     stranded = FALSE)
```

A third parameter *yieldSize* can be set to speed up the processing on multi-CPU or multi-core computers. It splits and processed the BAM files in chunk of size *yieldSize* with a default of 1M reads.

Finally, we create the list of BAM files we just retrieved.

```
bamFiles <- getBamFileList(dir(".","*\\.bam$"),
                           dir(".","*\\.bai$"))
```

---

# RNA-Seq parameters - RnaSeqParam

The final set of parameters we need to define encapsulate the **AnnotParam** and **BamParam** and detail how the read summarization should be performed. **simpleRNASeq** supports A) 2 modes of counting:

1. by read
2. by bp

the latter of which, was the default counting method the **easyRNASeq** function. Due to the more complex implementation required, the non-evidence of increase in counting accuracy and the extended support of the *read-based* approach by the mainstream, standardised *Bioconductor* package has led the *read* method to be the default in **simpleRNASeq**. Due to lack of time for maintenance and improvement, the *bp-based* method is also not recommended.

over B) 4 feature types: exon, transcript, gene or any **feature** provided by the user. The latter may be for example used for counting reads in promoter regions.

Given a flattened transcript structure - as created in a previous section - summarizing by *transcripts* or *genes* is equivalent. **Note that using a non flattened annotation with any feature type will result in multiple counting!!** *i.e.* the product of a single mRNA fragment will be counted for every features it overlap, hence introducing a significant **bias** in downstream analyses.

Given a flattened transcript structure, summarizing by exon enables the use of the resulting count table for processes such as differential exon usage analyses, as implemented in the **DEXSeq** package.

For the Robinson, Delhomme *et al.* dataset, we are interested in the gene expression, hence we create our **RnaSeqParam** object as follows:

```
rnaSeqParam <- RnaSeqParam(annotParam = annotParam,
                           bamParam = bamParam,
                           countBy = "genes",
                           precision = "read")
```

---

# simple RNA-Seq

We can now run the quantification

```
sexp1 <- simpleRNASeq(bamFiles=bamFiles,
                      param=rnaSeqParam,
                      verbose=TRUE)
```

```
## ==========================
```

```
## simpleRNASeq version 2.46.0
```

```
## ==========================
```

```
## Creating a RangedSummarizedExperiment.
```

```
## ==========================
```

```
## Processing the alignments.
```

```
## ==========================
```

```
## Pre-processing 6 BAM files.
```

```
## Validating the BAM files.
```

```
## Extracted 1446 reference sequences information.
```

```
## Extracting parameter from 202_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Extracting parameter from 207_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Extracting parameter from 213.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Extracting parameter from 221_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Extracting parameter from 226.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Extracting parameter from 229.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Found 0 single-end BAM files.
```

```
## Found 6 paired-end BAM files.
```

```
## Bam file: 202_subset_sortmerna_trimmomatic_sorted.bam has reads of length 50bp-101bp
```

```
## Bam file: 207_subset_sortmerna_trimmomatic_sorted.bam has reads of length 50bp-101bp
```

```
## Bam file: 213.1_subset_sortmerna_trimmomatic_sorted.bam has reads of length 50bp-101bp
```

```
## Bam file: 221_subset_sortmerna_trimmomatic_sorted.bam has reads of length 50bp-101bp
```

```
## Bam file: 226.1_subset_sortmerna_trimmomatic_sorted.bam has reads of length 50bp-101bp
```

```
## Bam file: 229.1_subset_sortmerna_trimmomatic_sorted.bam has reads of length 50bp-101bp
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 202_subset_sortmerna_trimmomatic_sorted.bam is considered unstranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 202_subset_sortmerna_trimmomatic_sorted.bam Strandedness could not be
## determined using 4492 regions spanning 1379593 bp on either strand at a 90%
## cutoff; 23.35 percent appear to be stranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 207_subset_sortmerna_trimmomatic_sorted.bam is considered unstranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 207_subset_sortmerna_trimmomatic_sorted.bam Strandedness could not be
## determined using 4706 regions spanning 1462563 bp on either strand at a 90%
## cutoff; 20.61 percent appear to be stranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 213.1_subset_sortmerna_trimmomatic_sorted.bam is considered unstranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 213.1_subset_sortmerna_trimmomatic_sorted.bam Strandedness could not be
## determined using 4457 regions spanning 1338599 bp on either strand at a 90%
## cutoff; 23.02 percent appear to be stranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 221_subset_sortmerna_trimmomatic_sorted.bam is considered unstranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 221_subset_sortmerna_trimmomatic_sorted.bam Strandedness could not be
## determined using 4458 regions spanning 1368624 bp on either strand at a 90%
## cutoff; 23.1 percent appear to be stranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 226.1_subset_sortmerna_trimmomatic_sorted.bam is considered unstranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 226.1_subset_sortmerna_trimmomatic_sorted.bam Strandedness could not be
## determined using 4431 regions spanning 1368899 bp on either strand at a 90%
## cutoff; 22.3 percent appear to be stranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 229.1_subset_sortmerna_trimmomatic_sorted.bam is considered unstranded.
```

```
## Warning in FUN(X[[i]], ...): Bam file:
## 229.1_subset_sortmerna_trimmomatic_sorted.bam Strandedness could not be
## determined using 4378 regions spanning 1346291 bp on either strand at a 90%
## cutoff; 19.96 percent appear to be stranded.
```

```
## Warning in simpleRNASeq(bamFiles = bamFiles, param = rnaSeqParam, verbose =
## TRUE): As of version 2.15.5, easyRNASeq assumes that, if the data is strand
## specific, the sequencing was done using a protocol such as the Illumina TruSeq,
## where the reverse strand is quantified - i.e. the strandProtocol argument of
## the BamParam class defaults to 'reverse'.
```

```
## Streaming 202_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Read 44496 reads
```

```
## Streaming 207_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Read 49318 reads
```

```
## Streaming 213.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Read 43300 reads
```

```
## Streaming 221_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Read 47521 reads
```

```
## Streaming 226.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Read 45860 reads
```

```
## Streaming 229.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Read 49077 reads
```

```
## Bam file: 202_subset_sortmerna_trimmomatic_sorted.bam has 44496 reads.
```

```
## Bam file: 207_subset_sortmerna_trimmomatic_sorted.bam has 49318 reads.
```

```
## Bam file: 213.1_subset_sortmerna_trimmomatic_sorted.bam has 43300 reads.
```

```
## Bam file: 221_subset_sortmerna_trimmomatic_sorted.bam has 47521 reads.
```

```
## Bam file: 226.1_subset_sortmerna_trimmomatic_sorted.bam has 45860 reads.
```

```
## Bam file: 229.1_subset_sortmerna_trimmomatic_sorted.bam has 49077 reads.
```

```
## ==========================
```

```
## Processing the annotation
```

```
## ==========================
```

```
## Validating the annotation source
```

```
## No validation performed at that stage
```

```
## Fetching the annotation
```

```
## Using the provided annotation as such
```

```
## ==========================
```

```
## Sanity checking
```

```
## ==========================
## ==========================
```

```
## Creating the count table
```

```
## ==========================
```

```
## Using 1 CPU core
```

```
## Streaming 202_subset_sortmerna_trimmomatic_sorted.bam
```

```
## The data is paired-end; only valid mates will be kept.
```

```
## The data is unstranded; overlapping features will be ignored.
```

```
## The summarization is by 'read' and the mode is: Union.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   542 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Processing 21977 reads
```

```
## Done with 202_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Streaming 207_subset_sortmerna_trimmomatic_sorted.bam
```

```
## The data is paired-end; only valid mates will be kept.
```

```
## The data is unstranded; overlapping features will be ignored.
```

```
## The summarization is by 'read' and the mode is: Union.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   816 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Processing 24251 reads
```

```
## Done with 207_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Streaming 213.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## The data is paired-end; only valid mates will be kept.
```

```
## The data is unstranded; overlapping features will be ignored.
```

```
## The summarization is by 'read' and the mode is: Union.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   476 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Processing 21412 reads
```

```
## Done with 213.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Streaming 221_subset_sortmerna_trimmomatic_sorted.bam
```

```
## The data is paired-end; only valid mates will be kept.
```

```
## The data is unstranded; overlapping features will be ignored.
```

```
## The summarization is by 'read' and the mode is: Union.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   680 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Processing 23420 reads
```

```
## Done with 221_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Streaming 226.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## The data is paired-end; only valid mates will be kept.
```

```
## The data is unstranded; overlapping features will be ignored.
```

```
## The summarization is by 'read' and the mode is: Union.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   532 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Processing 22664 reads
```

```
## Done with 226.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## Streaming 229.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## The data is paired-end; only valid mates will be kept.
```

```
## The data is unstranded; overlapping features will be ignored.
```

```
## The summarization is by 'read' and the mode is: Union.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   798 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Processing 24139 reads
```

```
## Done with 229.1_subset_sortmerna_trimmomatic_sorted.bam
```

```
## ==========================
```

```
## Returning a
```

```
##       RangedSummarizedExperiment
```

```
## ==========================
```

```
## Warning in file.remove(c("./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
## "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda", :
## cannot remove file '1', reason 'No such file or directory'
```

```
## Warning in file.remove(c("./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
## "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda", :
## cannot remove file '2', reason 'No such file or directory'
```

```
## Warning in file.remove(c("./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
## "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda", :
## cannot remove file '3', reason 'No such file or directory'
```

```
## Warning in file.remove(c("./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
## "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda", :
## cannot remove file '4', reason 'No such file or directory'
```

```
## Warning in file.remove(c("./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
## "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda", :
## cannot remove file '5', reason 'No such file or directory'
```

```
## Warning in file.remove(c("./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
## "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda", :
## cannot remove file '6', reason 'No such file or directory'
```

```
##  [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE
## [13]  TRUE  TRUE  TRUE
```

# Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] easyRNASeq_2.46.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  genomeIntervals_1.66.0
##  [5] filelock_1.0.3              Biostrings_2.78.0
##  [7] bitops_1.0-9                fastmap_1.2.0
##  [9] BiocFileCache_3.0.0         GenomicAlignments_1.46.0
## [11] digest_0.6.37               lifecycle_1.0.4
## [13] pwalign_1.6.0               statmod_1.5.1
## [15] KEGGREST_1.50.0             RSQLite_2.4.3
## [17] magrittr_2.0.4              compiler_4.5.1
## [19] rlang_1.1.6                 sass_0.4.10
## [21] progress_1.2.3              tools_4.5.1
## [23] yaml_2.3.10                 knitr_1.50
## [25] prettyunits_1.2.0           S4Arrays_1.10.0
## [27] bit_4.6.0                   interp_1.1-6
## [29] curl_7.0.0                  DelayedArray_0.36.0
## [31] RColorBrewer_1.1-3          ShortRead_1.68.0
## [33] abind_1.4-8                 BiocParallel_1.44.0
## [35] withr_3.0.2                 purrr_1.1.0
## [37] hwriter_1.3.2.1             BiocGenerics_0.56.0
## [39] grid_4.5.1                  stats4_4.5.1
## [41] latticeExtra_0.6-31         edgeR_4.8.0
## [43] biomaRt_2.66.0              SummarizedExperiment_1.40.0
## [45] cli_3.6.5                   rmarkdown_2.30
## [47] crayon_1.5.3                intervals_0.15.5
## [49] generics_0.1.4              httr_1.4.7
## [51] DBI_1.2.3                   cachem_1.1.0
## [53] stringr_1.5.2               parallel_4.5.1
## [55] AnnotationDbi_1.72.0        BiocManager_1.30.26
## [57] XVector_0.50.0              matrixStats_1.5.0
## [59] vctrs_0.6.5                 Matrix_1.7-4
## [61] jsonlite_2.0.0              IRanges_2.44.0
## [63] hms_1.1.4                   S4Vectors_0.48.0
## [65] bit64_4.6.0-1               jpeg_0.1-11
## [67] locfit_1.5-9.12             LSD_4.1-0
## [69] limma_3.66.0                jquerylib_0.1.4
## [71] glue_1.8.0                  codetools_0.2-20
## [73] stringi_1.8.7               deldir_2.0-4
## [75] GenomicRanges_1.62.0        tibble_3.3.0
## [77] pillar_1.11.1               rappdirs_0.3.3
## [79] htmltools_0.5.8.1           Seqinfo_1.0.0
## [81] R6_2.6.1                    dbplyr_2.5.1
## [83] httr2_1.2.1                 evaluate_1.0.5
## [85] lattice_0.22-7              Biobase_2.70.0
## [87] png_0.1-8                   Rsamtools_2.26.0
## [89] cigarillo_1.0.0             memoise_2.0.1
## [91] bslib_0.9.0                 Rcpp_1.1.0
## [93] SparseArray_1.10.0          xfun_0.53
## [95] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# Appendix

# References

Robinson, Kathryn, Nicolas Delhomme, Niklas Mähler, Bastian Schiffthaler, Jenny Önskog, Benedicte Albrectsen, Pär Ingvarsson, Torgeir Hvidsten, Stefan Jansson, and Nathaniel Street. 2014. “Populus Tremula (European Aspen) Shows No Evidence of Sexual Dimorphism.” *BMC Plant Biology* 14 (1): 276–76. <https://doi.org/10.1186/s12870-014-0276-5>.

---

1. <http://www.epigenesys.eu/en/protocols/bio-informatics/1283-guidelines-for-rna-seq-data-analysis>[↩︎](#fnref1)
2. <http://www.epigenesys.eu/en/protocols/bio-informatics/1283-guidelines-for-rna-seq-data-analysis>[↩︎](#fnref2)
3. Garbage In Garbage Out[↩︎](#fnref3)
4. <http://www.epigenesys.eu/en/protocols/bio-informatics/1283-guidelines-for-rna-seq-data-analysis>[↩︎](#fnref4)