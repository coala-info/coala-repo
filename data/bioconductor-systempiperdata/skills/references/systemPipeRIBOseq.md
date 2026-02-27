Code

* Show All Code
* Hide All Code

# RIBO-Seq Workflow Template

Author: First Last Name

#### Last update: 24 February, 2026

#### Package

systemPipeR 2.16.3

# 1 Introduction

Ribo-Seq and polyRibo-Seq are a specific form of RNA-Seq gene expression
experiments utilizing mRNA subpopulations directly bound to ribosomes.
Compared to standard RNA-Seq, their readout of gene expression provides a
better approximation of downstream protein abundance profiles due to their
close association with translational processes. The most important difference
among the two is that polyRibo-Seq utilizes polyribosomal RNA for sequencing,
whereas Ribo-Seq is a footprinting approach restricted to sequencing RNA
fragments protected by ribosomes (Ingolia et al. [2009](#ref-Ingolia2009-cb); Aspden et al. [2014](#ref-Aspden2014-uu); Juntawong et al. [2015](#ref-Juntawong2015-ru)).

The workflow presented in this vignette contains most of the data analysis
steps described by (Juntawong et al. [2014](#ref-Juntawong2014-ny)) including functionalities useful for
processing both polyRibo-Seq and Ribo-Seq experiments. To improve re-usability
and adapt to recent changes of software versions (*e.g.* R, Bioconductor and
short read aligners), the code has been optimized accordingly. Thus, the
results obtained with the updated workflow are expected to be similar but not
necessarily identical with the published results described in the original
paper.

Relevant analysis steps of this workflow include read preprocessing, read
alignments against a reference genome, counting of reads overlapping with a
wide range of genomic features (*e.g.* CDSs, UTRs, uORFs, rRNAs, etc.),
differential gene expression and differential ribosome binding analyses, as
well as a variety of genome-wide summary plots for visualizing RNA expression
trends. Functions are provided for evaluating the quality of Ribo-seq data,
for identifying novel expressed regions in the genomes, and for gaining
insights into gene regulation at the post-transcriptional and translational
levels. For example, the functions `genFeatures` and
`featuretypeCounts` can be used to quantify the expression output for
all feature types included in a genome annotation (`e.g.` genes,
introns, exons, miRNAs, intergenic regions, etc.). To determine the approximate
read length of ribosome footprints in Ribo-Seq experiments, these feature type
counts can be obtained and plotted for specific read lengths separately.
Typically, the most abundant read length obtained for translated features
corresponds to the approximate footprint length occupied by the ribosomes of a
given organism group. Based on the results from several Ribo-Seq studies, these
ribosome footprints are typically ~30 nucleotides long
(Ingolia, Lareau, and Weissman [2011](#ref-Ingolia2011-fc); Ingolia et al. [2009](#ref-Ingolia2009-cb); Juntawong et al. [2014](#ref-Juntawong2014-ny)). However, their
length can vary by several nucleotides depending upon the optimization of the
RNA digestion step and various factors associated with translational
regulation. For quality control purposes of Ribo-Seq experiments it is also
useful to monitor the abundance of reads mapping to rRNA genes due to the high
rRNA content of ribosomes. This information can be generated with the
`featuretypeCounts` function described above.

Coverage trends along transcripts summarized for any number of transcripts can
be obtained and plotted with the functions `featureCoverage` and
`plotfeatureCoverage`, respectively. Their results allow monitoring
of the phasing of ribosome movements along triplets of coding sequences.
Commonly, high quality data will display here for the first nucleotide of each
codon the highest depth of coverage computed for the 5’ ends of the aligned
reads.

Ribo-seq data can also be used to evaluate various aspects of translational
control due to ribosome occupancy in upstream open reading frames (uORFs). The
latter are frequently present in (or near) 5’ UTRs of transcripts. For this,
the function `predORFs` can be used to identify ORFs in the
nucleotide sequences of transcripts or their subcomponents such as UTR regions.
After scaling the resulting ORF coordinates back to the corresponding genome
locations using `scaleRanges`, one can use these novel features
(*e.g.* uORFs) for expression analysis routines similar to those
employed for pre-existing annotations, such as the exonic regions of genes. For
instance, in Ribo-Seq experiments one can use this approach to systematically identify all transcripts occupied by ribosomes in their uORF regions. The binding of
ribosomes to uORF regions may indicate a regulatory role in the translation of
the downstream main ORFs and/or translation of the uORFs into functionally
relevant peptides.

## 1.1 Experimental design

Typically, users want to specify here all information relevant for the analysis
of their NGS study. This includes detailed descriptions of FASTQ files,
experimental design, reference genome, gene annotations, etc.

# 2 Workflow environment

## 2.1 Load packages and sample data

The `systemPipeR` package needs to be loaded to perform the analysis
steps shown in this report (H Backman and Girke [2016](#ref-H_Backman2016-bt)). The package allows users
to run the entire analysis workflow interactively or with a single command
while also generating the corresponding analysis report. For details
see `systemPipeR's` main [vignette](http://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html).

```
library(systemPipeR)
```

## 2.2 Generate workflow environment

[*systemPipeRdata*](http://bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html) package is a helper package to generate a fully populated [*systemPipeR*](http://bioconductor.org/packages/release/bioc/html/systemPipeR.html)
workflow environment in the current working directory with a single command.
All the instruction for generating the workflow template are provide in the *systemPipeRdata* vignette [here](http://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html#1_Introduction).

```
systemPipeRdata::genWorkenvir(workflow = "riboseq", mydirname = "riboseq")
setwd("riboseq")
```

After building and loading the workflow environment generated by `genWorkenvir`
from *systemPipeRdata* all data inputs are stored in
a `data/` directory and all analysis results will be written to a separate
`results/` directory, while the `systemPipeRIBOseq.Rmd` script and the `targets` file are expected to be located in the parent directory. The R session is expected to run from this parent
directory. Additional parameter files are stored under `param/`.

To work with real data, users want to organize their own data similarly
and substitute all test data for their own data. To rerun an established
workflow on new data, the initial `targets` file along with the corresponding
FASTQ files are usually the only inputs the user needs to provide. Please check
the initial `targets` file details below.

For more details, please consult the documentation
[here](http://www.bioconductor.org/packages/release/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html). More information about the `targets` files from *systemPipeR* can be found [here](http://www.bioconductor.org/packages/release/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#42_Structure_of_initial_targets_data).

## 2.3 Experiment definition provided by `targets` file

The `targets` file defines all FASTQ files and sample comparisons of the analysis workflow.

```
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment.char = "#")[, 1:4]
targets
```

```
##                      FileName1                   FileName2
## 1  ./data/SRR446027_1.fastq.gz ./data/SRR446027_2.fastq.gz
## 2  ./data/SRR446028_1.fastq.gz ./data/SRR446028_2.fastq.gz
## 3  ./data/SRR446029_1.fastq.gz ./data/SRR446029_2.fastq.gz
## 4  ./data/SRR446030_1.fastq.gz ./data/SRR446030_2.fastq.gz
## 5  ./data/SRR446031_1.fastq.gz ./data/SRR446031_2.fastq.gz
## 6  ./data/SRR446032_1.fastq.gz ./data/SRR446032_2.fastq.gz
## 7  ./data/SRR446033_1.fastq.gz ./data/SRR446033_2.fastq.gz
## 8  ./data/SRR446034_1.fastq.gz ./data/SRR446034_2.fastq.gz
## 9  ./data/SRR446035_1.fastq.gz ./data/SRR446035_2.fastq.gz
## 10 ./data/SRR446036_1.fastq.gz ./data/SRR446036_2.fastq.gz
## 11 ./data/SRR446037_1.fastq.gz ./data/SRR446037_2.fastq.gz
## 12 ./data/SRR446038_1.fastq.gz ./data/SRR446038_2.fastq.gz
## 13 ./data/SRR446039_1.fastq.gz ./data/SRR446039_2.fastq.gz
## 14 ./data/SRR446040_1.fastq.gz ./data/SRR446040_2.fastq.gz
## 15 ./data/SRR446041_1.fastq.gz ./data/SRR446041_2.fastq.gz
## 16 ./data/SRR446042_1.fastq.gz ./data/SRR446042_2.fastq.gz
## 17 ./data/SRR446043_1.fastq.gz ./data/SRR446043_2.fastq.gz
## 18 ./data/SRR446044_1.fastq.gz ./data/SRR446044_2.fastq.gz
##    SampleName Factor
## 1         M1A     M1
## 2         M1B     M1
## 3         A1A     A1
## 4         A1B     A1
## 5         V1A     V1
## 6         V1B     V1
## 7         M6A     M6
## 8         M6B     M6
## 9         A6A     A6
## 10        A6B     A6
## 11        V6A     V6
## 12        V6B     V6
## 13       M12A    M12
## 14       M12B    M12
## 15       A12A    A12
## 16       A12B    A12
## 17       V12A    V12
## 18       V12B    V12
```

# 3 Workflow environment

*`systemPipeR`* workflows can be designed and built from start to finish with a
single command, importing from an R Markdown file or stepwise in interactive
mode from the R console.

This tutorial will demonstrate how to build the workflow in an interactive mode,
appending each step. The workflow is constructed by connecting each step via
`appendStep` method. Each `SYSargsList` instance contains instructions needed
for processing a set of input files with a specific command-line or R software
and the paths to the corresponding outfiles generated by a particular tool/step.

To create a Workflow within *`systemPipeR`*, we can start by defining an empty
container and checking the directory structure:

```
library(systemPipeR)
sal <- SPRproject()
sal
```

## 3.1 Required packages and resources

The `systemPipeR` package needs to be loaded (H Backman and Girke [2016](#ref-H_Backman2016-bt)).

```
cat(crayon::blue$bold("To use this workflow, following R packages are expected:\n"))
cat(c("'rtracklayer", "GenomicFeatures", "grid", "BiocParallel",
    "DESeq2", "ape", "edgeR", "biomaRt", "BBmisc", "pheatmap",
    "ggplot2'\n"), sep = "', '")
### pre-end
appendStep(sal) <- LineWise(code = {
    library(systemPipeR)
    library(rtracklayer)
    library(GenomicFeatures)
    library(ggplot2)
    library(grid)
    library(DESeq2, quietly = TRUE)
    library(ape, warn.conflicts = FALSE)
    library(edgeR)
    library(biomaRt)
    library(BBmisc)  # Defines suppressAll()
    library(pheatmap)
    library(BiocParallel)
}, step_name = "load_SPR")
```

## 3.2 Read preprocessing

### 3.2.1 Preprocessing with `preprocessReads` function

The function `preprocessReads` allows to apply predefined or custom
read preprocessing functions to all FASTQ files referenced in a
`SYSargsList` container, such as quality filtering or adapter trimming
routines. Internally, `preprocessReads` uses the `FastqStreamer` function from
the `ShortRead` package to stream through large FASTQ files in a
memory-efficient manner.

Here, we are appending a new step to the `SYSargsList` object created previously.
All the parameters are defined on the `preprocessReads/preprocessReads-pe_riboseq.yml` file.

```
appendStep(sal) <- SYSargsList(step_name = "preprocessing", targets = "targetsPE.txt",
    dir = TRUE, wf_file = "preprocessReads/preprocessReads-pe.cwl",
    input_file = "preprocessReads/preprocessReads-pe_riboseq.yml",
    dir_path = system.file("extdata/cwl", package = "systemPipeR"),
    inputvars = c(FileName1 = "_FASTQ_PATH1_", FileName2 = "_FASTQ_PATH2_",
        SampleName = "_SampleName_"), dependency = c("load_SPR"))
```

The function `trimbatch` used trims adapters hierarchically from the longest to
the shortest match of the right end of the reads. If `internalmatch=TRUE` then
internal matches will trigger the same behavior. The argument `minpatternlength`
defines the shortest adapter match to consider in this iterative process. In
addition, the function removes reads containing Ns or homopolymer regions.
More detailed information on read preprocessing is provided in `systemPipeR's` main vignette.

```
yamlinput(sal, step = "preprocessing")$Fct
# [1] ''trimbatch(fq, pattern=\'ACACGTCT\',
# internalmatch=FALSE, minpatternlength=6, Nnumber=1,
# polyhomo=50, minreadlength=16, maxreadlength=101)''
cmdlist(sal, step = "preprocessing", targets = 1)
```

### 3.2.2 FASTQ quality report

The following `seeFastq` and `seeFastqPlot` functions generate and plot a series of useful
quality statistics for a set of FASTQ files, including per cycle quality box
plots, base proportions, base-level quality trends, relative k-mer
diversity, length, and occurrence distribution of reads, number of reads
above quality cutoffs and mean quality distribution. The results are
written to a png file named `fastqReport.png`.

This is the pre-trimming fastq report. Another post-trimming fastq report step
is not included in the default. It is recommended to run this step first to
decide whether the trimming is needed.

Please note that initial targets files are being used here. In this case,
we used the `getColumn` function to extract a named vector.

```
appendStep(sal) <- LineWise(code = {
    fq_files <- getColumn(sal, "preprocessing", "targetsWF",
        column = 1)
    fqlist <- seeFastq(fastq = fq_files, batchsize = 10000, klength = 8)
    png("./results/fastqReport.png", height = 162, width = 288 *
        length(fqlist))
    seeFastqPlot(fqlist)
    dev.off()
}, step_name = "fastq_report", dependency = "preprocessing")
```

![](data:image/png;base64...)

**Figure 1:** FASTQ quality report. To zoom in, right click image and open it in a separate browser tab.

## 3.3 Alignments

### 3.3.1 Read mapping with `HISAT2`

The following steps will demonstrate how to use the short read aligner `Hisat2`
(Kim, Langmead, and Salzberg [2015](#ref-Kim2015-ve)). First, the `Hisat2` index needs to be created.

```
appendStep(sal) <- SYSargsList(step_name = "hisat2_index", dir = FALSE,
    targets = NULL, wf_file = "hisat2/hisat2-index.cwl", input_file = "hisat2/hisat2-index.yml",
    dir_path = "param/cwl", dependency = "load_SPR")
```

### 3.3.2 `HISAT2` mapping

The parameter settings of the aligner are defined in the `workflow_hisat2-pe.cwl`
and `workflow_hisat2-pe.yml` files. The following shows how to construct the
corresponding *SYSargsList* object.

```
appendStep(sal) <- SYSargsList(step_name = "hisat2_mapping",
    dir = TRUE, targets = "targetsPE.txt", wf_file = "workflow-hisat2/workflow_hisat2-pe.cwl",
    input_file = "workflow-hisat2/workflow_hisat2-pe.yml", dir_path = "param/cwl",
    inputvars = c(FileName1 = "_FASTQ_PATH1_", FileName2 = "_FASTQ_PATH2_",
        SampleName = "_SampleName_"), dependency = c("hisat2_index"))
```

To double-check the command line for each sample, please use the following:

```
cmdlist(sal, step = "hisat2_mapping", targets = 1)
```

### 3.3.3 Read and alignment stats

The following provides an overview of the number of reads in each sample
and how many of them aligned to the reference.

```
appendStep(sal) <- LineWise(code = {
    fqpaths <- getColumn(sal, step = "hisat2_mapping", "targetsWF",
        column = "FileName1")
    bampaths <- getColumn(sal, step = "hisat2_mapping", "outfiles",
        column = "samtools_sort_bam")
    read_statsDF <- alignStats(args = bampaths, fqpaths = fqpaths,
        pairEnd = TRUE)
    write.table(read_statsDF, "results/alignStats.xls", row.names = FALSE,
        quote = FALSE, sep = "\t")
}, step_name = "align_stats", dependency = "hisat2_mapping")
```

## 3.4 Create symbolic links for viewing BAM files in IGV

The `symLink2bam` function creates symbolic links to view the BAM alignment files in a
genome browser such as IGV without moving these large files to a local
system. The corresponding URLs are written to a file with a path
specified under `urlfile`, here `IGVurl.txt`.
Please replace the directory and the user name.

```
appendStep(sal) <- LineWise(code = {
    bampaths <- getColumn(sal, step = "hisat2_mapping", "outfiles",
        column = "samtools_sort_bam")
    symLink2bam(sysargs = bampaths, htmldir = c("~/.html/", "somedir/"),
        urlbase = "http://cluster.hpcc.ucr.edu/~tgirke/", urlfile = "./results/IGVurl.txt")
}, step_name = "bam_IGV", dependency = "hisat2_mapping", run_step = "optional")
```

## 3.5 Read distribution across genomic features

The `genFeatures` function generates a variety of feature types from
`TxDb` objects using utilities provided by the `GenomicFeatures` package.

### 3.5.1 Obtain feature types

The first step is the generation of the feature type ranges based on
annotations provided by a GFF file that can be transformed into a
`TxDb` object. This includes ranges for mRNAs, exons, introns, UTRs,
CDSs, miRNAs, rRNAs, tRNAs, promoter and intergenic regions. In addition, any
number of custom annotations can be included in this routine.

```
appendStep(sal) <- LineWise(code = {
    txdb <- suppressWarnings(makeTxDbFromGFF(file = "data/tair10.gff",
        format = "gff3", dataSource = "TAIR", organism = "Arabidopsis thaliana"))
    feat <- genFeatures(txdb, featuretype = "all", reduce_ranges = TRUE,
        upstream = 1000, downstream = 0, verbose = TRUE)
}, step_name = "genFeatures", dependency = "hisat2_mapping",
    run_step = "mandatory")
```

### 3.5.2 Count and plot reads of any length

The `featuretypeCounts` function counts how many reads in short read
alignment files (BAM format) overlap with entire annotation categories. This
utility is useful for analyzing the distribution of the read mappings across
feature types, *e.g.* coding versus non-coding genes. By default the
read counts are reported for the sense and antisense strand of each feature
type separately. To minimize memory consumption, the BAM files are processed in
a stream using utilities from the `Rsamtools` and `GenomicAlignment` packages.
The counts can be reported for each read length separately or as a single value
for reads of any length. Subsequently, the counting results can be plotted with
the associated `plotfeaturetypeCounts` function.

The following generates and plots feature counts for any read length.

```
appendStep(sal) <- LineWise(code = {
    outpaths <- getColumn(sal, step = "hisat2_mapping", "outfiles",
        column = "samtools_sort_bam")
    fc <- featuretypeCounts(bfl = BamFileList(outpaths, yieldSize = 50000),
        grl = feat, singleEnd = FALSE, readlength = NULL, type = "data.frame")
    p <- plotfeaturetypeCounts(x = fc, graphicsfile = "results/featureCounts.png",
        graphicsformat = "png", scales = "fixed", anyreadlength = TRUE,
        scale_length_val = NULL)
}, step_name = "featuretypeCounts", dependency = "genFeatures",
    run_step = "mandatory")
```

![](data:image/png;base64...)

Figure 2: Read distribution plot across annotation features for any read length.

### 3.5.3 Count and plot reads of specific lengths

To determine the approximate read length of ribosome footprints in Ribo-Seq
experiments, one can generate and plot the feature counts for specific read lengths
separately. Typically, the most abundant read length obtained for translated
features corresponds to the approximate footprint length occupied by the ribosomes.

```
appendStep(sal) <- LineWise(code = {
    fc2 <- featuretypeCounts(bfl = BamFileList(outpaths, yieldSize = 50000),
        grl = feat, singleEnd = TRUE, readlength = c(74:76, 99:102),
        type = "data.frame")
    p2 <- plotfeaturetypeCounts(x = fc2, graphicsfile = "results/featureCounts2.png",
        graphicsformat = "png", scales = "fixed", anyreadlength = FALSE,
        scale_length_val = NULL)
}, step_name = "featuretypeCounts_length", dependency = "featuretypeCounts",
    run_step = "mandatory")
```

![](data:image/png;base64...)

Figure 3: Read distribution plot across annotation features for specific read lengths.

## 3.6 Adding custom features to workflow

### 3.6.1 Predicting uORFs in 5’ UTR regions

The function `predORF` can be used to identify open reading frames (ORFs) and
coding sequences (CDSs) in DNA sequences provided as `DNAString` or `DNAStringSet`
objects. The setting `mode='ORF'` returns continuous reading frames that begin
with a start codon and end with a stop codon, while `mode='CDS'` returns continuous
reading frames that do not need to begin or end with start or stop codons,
respectively. Non-canonical start and stop condons are supported by allowing
the user to provide any custom set of triplets under the `startcodon` and
`stopcodon` arguments (`i.e.` non-ATG start codons). The argument `n` defines
the maximum number of ORFs to return for each input sequence (*e.g.* `n=1`
returns only the longest ORF). It also supports the identification of overlapping
and nested ORFs. Alternatively, one can return all non-overlapping ORFs including
the longest ORF for each input sequence with `n="all"` and `longest_disjoint=TRUE`.

```
appendStep(sal) <- LineWise(code = {
    txdb <- suppressWarnings(makeTxDbFromGFF(file = "data/tair10.gff",
        format = "gff3", organism = "Arabidopsis"))
    futr <- fiveUTRsByTranscript(txdb, use.names = TRUE)
    dna <- extractTranscriptSeqs(FaFile("data/tair10.fasta"),
        futr)
    uorf <- predORF(dna, n = "all", mode = "orf", longest_disjoint = TRUE,
        strand = "sense")
}, step_name = "pred_ORF", dependency = "featuretypeCounts_length")
```

To use the predicted ORF ranges for expression analysis given genome alignments
as input, it is necessary to scale them to the corresponding genome
coordinates. The function `scaleRanges` does this by transforming the
mappings of spliced features (query ranges) to their corresponding genome
coordinates (subject ranges). The method accounts for introns in the subject
ranges that are absent in the query ranges. The above uORFs predicted in the
provided 5’ UTRs sequences using `predORF` are a typical use case
for this application. These query ranges are given relative to the 5’ UTR
sequences and `scaleRanges` will convert them to the corresponding
genome coordinates. The resulting `GRangesList` object (here `grl_scaled`)
can be directly used for read counting.

```
appendStep(sal) <- LineWise(code = {
    grl_scaled <- scaleRanges(subject = futr, query = uorf, type = "uORF",
        verbose = TRUE)
    export.gff3(unlist(grl_scaled), "results/uorf.gff")
}, step_name = "scale_ranges", dependency = "pred_ORF")
```

To confirm the correctness of the obtained uORF ranges, one can parse their
corresponding DNA sequences from the reference genome with the `getSeq`
function and then translate them with the `translate` function into
proteins. Typically, the returned protein sequences should start with a
`M` (corresponding to start codon) and end with `*` (corresponding to stop codon).
The following example does this for a single uORF containing three exons.

```
appendStep(sal) <- LineWise(code = {
    translate(unlist(getSeq(FaFile("data/tair10.fasta"), grl_scaled[[7]])))
}, step_name = "translate", dependency = "scale_ranges")
```

### 3.6.2 Adding custom features to other feature types

If required custom feature ranges can be added to the standard features generated
with the `genFeatures` function above. The following does this for the uORF ranges
predicted with `predORF`.

```
appendStep(sal) <- LineWise(code = {
    feat <- genFeatures(txdb, featuretype = "all", reduce_ranges = FALSE)
    feat <- c(feat, GRangesList(uORF = unlist(grl_scaled)))
}, step_name = "add_features", dependency = c("genFeatures",
    "scale_ranges"))
```

### 3.6.3 Predicting sORFs in intergenic regions

The following identifies continuous ORFs in intergenic regions. Note,
`predORF` can only identify continuous ORFs in query sequences. The
function does not identify and remove introns prior to the ORF prediction.

```
appendStep(sal) <- LineWise(code = {
    feat <- genFeatures(txdb, featuretype = "intergenic", reduce_ranges = TRUE)
    intergenic <- feat$intergenic
    strand(intergenic) <- "+"
    dna <- getSeq(FaFile("data/tair10.fasta"), intergenic)
    names(dna) <- mcols(intergenic)$feature_by
    sorf <- suppressWarnings(predORF(dna, n = "all", mode = "orf",
        longest_disjoint = TRUE, strand = "both"))
    sorf <- sorf[width(sorf) > 60]  # Remove sORFs below length cutoff, here 60bp
    intergenic <- split(intergenic, mcols(intergenic)$feature_by)
    grl_scaled_intergenic <- scaleRanges(subject = intergenic,
        query = sorf, type = "sORF", verbose = TRUE)
    export.gff3(unlist(grl_scaled_intergenic), "sorf.gff")
    translate(getSeq(FaFile("data/tair10.fasta"), unlist(grl_scaled_intergenic)))
}, step_name = "pred_sORFs", dependency = c("add_features"))
```

## 3.7 Genomic read coverage along transripts or CDSs

The `featureCoverage` function computes the read coverage along
single and multi component features based on genomic alignments. The coverage
segments of component features are spliced to continuous ranges, such as exons
to transcripts or CDSs to ORFs. The results can be obtained with single
nucleotide resolution (*e.g.* around start and stop codons) or as mean coverage
of relative bin sizes, such as 100 bins for each feature. The latter allows
comparisons of coverage trends among transcripts of variable length. Additionally,
the results can be obtained for single or many features (*e.g.* any number of
transcripts) at once. Visualization of the coverage results is facilitated by
the downstream `plotfeatureCoverage` function.

### 3.7.1 Binned CDS coverage to compare many transcripts

```
appendStep(sal) <- LineWise(code = {
    grl <- cdsBy(txdb, "tx", use.names = TRUE)
    fcov <- featureCoverage(bfl = BamFileList(outpaths[1:2]),
        grl = grl[1:4], resizereads = NULL, readlengthrange = NULL,
        Nbins = 20, method = mean, fixedmatrix = FALSE, resizefeatures = TRUE,
        upstream = 20, downstream = 20, outfile = "results/featureCoverage.xls",
        overwrite = TRUE)
}, step_name = "binned_CDS_coverage", dependency = c("add_features"))
```

### 3.7.2 Coverage upstream and downstream of start and stop codons

```
appendStep(sal) <- LineWise(code = {
    fcov <- featureCoverage(bfl = BamFileList(outpaths[1:4]),
        grl = grl[1:12], resizereads = NULL, readlengthrange = NULL,
        Nbins = NULL, method = mean, fixedmatrix = TRUE, resizefeatures = TRUE,
        upstream = 20, downstream = 20, outfile = "results/featureCoverage.xls",
        overwrite = TRUE)
    png("./results/coverage_upstream_downstream.png", height = 12,
        width = 24, units = "in", res = 72)
    plotfeatureCoverage(covMA = fcov, method = mean, scales = "fixed",
        extendylim = 2, scale_count_val = 10^6)
    dev.off()
}, step_name = "coverage_upstream_downstream", dependency = c("binned_CDS_coverage"))
```

### 3.7.3 Combined coverage for both binned CDS and start/stop codons

```
appendStep(sal) <- LineWise(code = {
    fcov <- featureCoverage(bfl = BamFileList(outpaths[1:4]),
        grl = grl[1:4], resizereads = NULL, readlengthrange = NULL,
        Nbins = 20, method = mean, fixedmatrix = TRUE, resizefeatures = TRUE,
        upstream = 20, downstream = 20, outfile = "results/featureCoverage.xls",
        overwrite = TRUE)
    png("./results/featurePlot.png", height = 12, width = 24,
        units = "in", res = 72)
    plotfeatureCoverage(covMA = fcov, method = mean, scales = "fixed",
        extendylim = 2, scale_count_val = 10^6)
    dev.off()
}, step_name = "coverage_combined", dependency = c("binned_CDS_coverage",
    "coverage_upstream_downstream"))
```

![](data:image/png;base64...)

Figure 4: Feature coverage plot with single nucleotide resolution around start and stop codons and binned coverage between them.

## 3.8 Nucleotide level coverage along entire transcripts/CDSs

```
appendStep(sal) <- LineWise(code = {
    fcov <- featureCoverage(bfl = BamFileList(outpaths[1:2]),
        grl = grl[1], resizereads = NULL, readlengthrange = NULL,
        Nbins = NULL, method = mean, fixedmatrix = FALSE, resizefeatures = TRUE,
        upstream = 20, downstream = 20, outfile = NULL)
}, step_name = "coverage_nuc_level", dependency = c("coverage_combined"))
```

## 3.9 Read quantification per annotation range

### 3.9.1 Read counting with `summarizeOverlaps` in parallel mode using multiple cores

Reads overlapping with annotation ranges of interest are counted for each
sample using the `summarizeOverlaps` function (Lawrence et al. [2013](#ref-Lawrence2013-kt)). The
read counting is preformed for exonic gene regions in a non-strand-specific
manner while ignoring overlaps among different genes. Subsequently, the
expression count values are normalized by (RPKM). The raw read count table (`countDFeByg.xls`) and the corresponding
RPKM table (`rpkmDFeByg.xls`) are written to separate files in the `results`
directory of this project.
Parallelization is achieved with the `BiocParallel` package, here using 8 CPU cores.

```
appendStep(sal) <- LineWise(code = {
    txdb <- loadDb("./data/tair10.sqlite")
    eByg <- exonsBy(txdb, by = c("gene"))
    bfl <- BamFileList(outpaths, yieldSize = 50000, index = character())
    multicoreParam <- MulticoreParam(workers = 8)
    register(multicoreParam)
    registered()
    counteByg <- bplapply(bfl, function(x) summarizeOverlaps(eByg,
        x, mode = "Union", ignore.strand = TRUE, inter.feature = FALSE,
        singleEnd = FALSE, BPPARAM = multicoreParam))
    countDFeByg <- sapply(seq(along = counteByg), function(x) assays(counteByg[[x]])$counts)
    rownames(countDFeByg) <- names(rowRanges(counteByg[[1]]))
    colnames(countDFeByg) <- names(bfl)
    rpkmDFeByg <- apply(countDFeByg, 2, function(x) returnRPKM(counts = x,
        ranges = eByg))
    write.table(countDFeByg, "results/countDFeByg.xls", col.names = NA,
        quote = FALSE, sep = "\t")
    write.table(rpkmDFeByg, "results/rpkmDFeByg.xls", col.names = NA,
        quote = FALSE, sep = "\t")
    ## Creating a SummarizedExperiment object
    colData <- data.frame(row.names = SampleName(sal, "hisat2_mapping"),
        condition = getColumn(sal, "hisat2_mapping", position = "targetsWF",
            column = "Factor"))
    colData$condition <- factor(colData$condition)
    countDF_se <- SummarizedExperiment::SummarizedExperiment(assays = countDFeByg,
        colData = colData)
    ## Add results as SummarizedExperiment to the workflow
    ## object
    SE(sal, "read_counting") <- countDF_se
}, step_name = "read_counting", dependency = c("featuretypeCounts"))
```

When providing a `BamFileList` as in the example above, `summarizeOverlaps` methods
use by default `bplapply` and use the register interface from BiocParallel package.
If the number of workers is not set, `MulticoreParam` will use the number of cores
returned by `parallel::detectCores()`. For more information,
please check `help("summarizeOverlaps")` documentation.

Sample of data slice of count table:

```
read.delim(system.file("extdata/countDFeByg.xls", package = "systemPipeR"),
    row.names = 1, check.names = FALSE)[1:4, 1:5]
```

```
##           M1A M1B A1A A1B V1A
## AT1G01010  57 244 201 169 365
## AT1G01020  23  93  69 126 107
## AT1G01030  41  98  73  58  94
## AT1G01040 180 684 522 664 585
```

Sample of data slice of RPKM table

```
read.delim(system.file("extdata/rpkmDFeByg.xls", package = "systemPipeR"),
    row.names = 1, check.names = FALSE)[1:4, 1:5]
```

Note, for most statistical differential expression or abundance analysis
methods, such as `edgeR` or `DESeq2`, the raw count values
should be used as input. The usage of RPKM values should be restricted to
specialty applications required by some users, *e.g.* manually comparing
the expression levels among different genes or features.

### 3.9.2 Sample-wise correlation analysis

The following computes the sample-wise Spearman correlation coefficients from
the `rlog` transformed expression values generated with the
`DESeq2` package. After transformation to a distance matrix,
hierarchical clustering is performed with the `hclust` function and
the result is plotted as a dendrogram and written to a file named `sample_tree.png`
in the `results` directory.

```
appendStep(sal) <- LineWise(code = {
    ## Extracting SummarizedExperiment object
    se <- SE(sal, "read_counting")
    dds <- DESeqDataSet(se, design = ~condition)
    d <- cor(assay(rlog(dds)), method = "spearman")
    hc <- hclust(dist(1 - d))
    png("results/sample_tree.png")
    plot.phylo(as.phylo(hc), type = "p", edge.col = "blue", edge.width = 2,
        show.node.label = TRUE, no.margin = TRUE)
    dev.off()
}, step_name = "sample_tree", dependency = "read_counting")
```

![](data:image/png;base64...)

Figure 5: Correlation dendrogram of samples.

## 3.10 Analysis of differentially expressed genes with `edgeR`

The analysis of differentially expressed genes (DEGs) is performed with the glm
method from the `edgeR` package (Robinson, McCarthy, and Smyth [2010](#ref-Robinson2010-uk)). The sample
comparisons used by this analysis are defined in the header lines of the
`targetsPE.txt` file starting with `<CMP>`.

```
appendStep(sal) <- LineWise(code = {
    countDF <- read.delim("results/countDFeByg.xls", row.names = 1,
        check.names = FALSE)
    cmp <- readComp(stepsWF(sal)[["hisat2_mapping"]], format = "matrix",
        delim = "-")
    edgeDF <- run_edgeR(countDF = countDF, targets = targetsWF(sal)[["hisat2_mapping"]],
        cmp = cmp[[1]], independent = FALSE, mdsplot = "")
}, step_name = "run_edgeR", dependency = "read_counting")
```

Add functional gene descriptions, here from `biomaRt`.

```
appendStep(sal) <- LineWise(code = {
    m <- useMart("plants_mart", dataset = "athaliana_eg_gene",
        host = "https://plants.ensembl.org")
    desc <- getBM(attributes = c("tair_locus", "description"),
        mart = m)
    desc <- desc[!duplicated(desc[, 1]), ]
    descv <- as.character(desc[, 2])
    names(descv) <- as.character(desc[, 1])
    edgeDF <- data.frame(edgeDF, Desc = descv[rownames(edgeDF)],
        check.names = FALSE)
    write.table(edgeDF, "./results/edgeRglm_allcomp.xls", quote = FALSE,
        sep = "\t", col.names = NA)
}, step_name = "custom_annot", dependency = "run_edgeR")
```

### 3.10.1 Plot DEG results

Filter and plot DEG results for up and down regulated genes. The
definition of *up* and *down* is given in the corresponding help
file. To open it, type `?filterDEGs` in the R console.

```
appendStep(sal) <- LineWise(code = {
    edgeDF <- read.delim("results/edgeRglm_allcomp.xls", row.names = 1,
        check.names = FALSE)
    png("results/DEGcounts.png")
    DEG_list <- filterDEGs(degDF = edgeDF, filter = c(Fold = 2,
        FDR = 20))
    dev.off()
    write.table(DEG_list$Summary, "./results/DEGcounts.xls",
        quote = FALSE, sep = "\t", row.names = FALSE)
}, step_name = "filter_degs", dependency = "custom_annot")
```

![](data:image/png;base64...)

Figure 6: Up and down regulated DEGs.

### 3.10.2 Venn diagrams of DEG sets

The `overLapper` function can compute Venn intersects for large numbers of sample
sets (up to 20 or more) and plots 2-5 way Venn diagrams. A useful
feature is the possibility to combine the counts from several Venn
comparisons with the same number of sample sets in a single Venn diagram
(here for 4 up and down DEG sets).

```
appendStep(sal) <- LineWise(code = {
    vennsetup <- overLapper(DEG_list$Up[6:9], type = "vennsets")
    vennsetdown <- overLapper(DEG_list$Down[6:9], type = "vennsets")
    png("results/vennplot.png")
    vennPlot(list(vennsetup, vennsetdown), mymain = "", mysub = "",
        colmode = 2, ccol = c("blue", "red"))
    dev.off()
}, step_name = "venn_diagram", dependency = "filter_degs")
```

![](data:image/png;base64...)

Figure 7: Venn Diagram for 4 Up and Down DEG Sets

## 3.11 GO term enrichment analysis of DEGs

### 3.11.1 Obtain gene-to-GO mappings

The following shows how to obtain gene-to-GO mappings from `biomaRt`
(here for *A. thaliana*) and how to organize them for the downstream GO
term enrichment analysis. Alternatively, the gene-to-GO mappings can be
obtained for many organisms from Bioconductor’s `*.db` genome
annotation packages or GO annotation files provided by various genome
databases. For each annotation this relatively slow preprocessing step needs to
be performed only once. Subsequently, the preprocessed data can be loaded with
the `load` function as shown in the next subsection.

```
appendStep(sal) <- LineWise(code = {
    # listMarts() # To choose BioMart database
    # listMarts(host='plants.ensembl.org') m <-
    # useMart('plants_mart',
    # host='https://plants.ensembl.org') listDatasets(m)
    m <- useMart("plants_mart", dataset = "athaliana_eg_gene",
        host = "https://plants.ensembl.org")
    # listAttributes(m) # Choose data types you want to
    # download
    go <- getBM(attributes = c("go_id", "tair_locus", "namespace_1003"),
        mart = m)
    go <- go[go[, 3] != "", ]
    go[, 3] <- as.character(go[, 3])
    go[go[, 3] == "molecular_function", 3] <- "F"
    go[go[, 3] == "biological_process", 3] <- "P"
    go[go[, 3] == "cellular_component", 3] <- "C"
    go[1:4, ]
    if (!dir.exists("./data/GO"))
        dir.create("./data/GO")
    write.table(go, "data/GO/GOannotationsBiomart_mod.txt", quote = FALSE,
        row.names = FALSE, col.names = FALSE, sep = "\t")
    catdb <- makeCATdb(myfile = "data/GO/GOannotationsBiomart_mod.txt",
        lib = NULL, org = "", colno = c(1, 2, 3), idconv = NULL)
    save(catdb, file = "data/GO/catdb.RData")
}, step_name = "get_go_annot", dependency = "filter_degs")
```

### 3.11.2 Batch GO term enrichment analysis

Apply the enrichment analysis to the DEG sets obtained the above differential
expression analysis. Note, in the following example the `FDR` filter is set
here to an unreasonably high value, simply because of the small size of the toy
data set used in this vignette. Batch enrichment analysis of many gene sets is
performed with the function. When `method=all`, it returns all GO terms passing
the p-value cutoff specified under the `cutoff` arguments. When `method=slim`,
it returns only the GO terms specified under the `myslimv` argument. The given
example shows how a GO slim vector for a specific organism can be obtained from
`BioMart`.

```
appendStep(sal) <- LineWise(code = {
    load("data/GO/catdb.RData")
    DEG_list <- filterDEGs(degDF = edgeDF, filter = c(Fold = 2,
        FDR = 50), plot = FALSE)
    up_down <- DEG_list$UporDown
    names(up_down) <- paste(names(up_down), "_up_down", sep = "")
    up <- DEG_list$Up
    names(up) <- paste(names(up), "_up", sep = "")
    down <- DEG_list$Down
    names(down) <- paste(names(down), "_down", sep = "")
    DEGlist <- c(up_down, up, down)
    DEGlist <- DEGlist[sapply(DEGlist, length) > 0]
    BatchResult <- GOCluster_Report(catdb = catdb, setlist = DEGlist,
        method = "all", id_type = "gene", CLSZ = 2, cutoff = 0.9,
        gocats = c("MF", "BP", "CC"), recordSpecGO = NULL)
    m <- useMart("plants_mart", dataset = "athaliana_eg_gene",
        host = "https://plants.ensembl.org")
    goslimvec <- as.character(getBM(attributes = c("goslim_goa_accession"),
        mart = m)[, 1])
    BatchResultslim <- GOCluster_Report(catdb = catdb, setlist = DEGlist,
        method = "slim", id_type = "gene", myslimv = goslimvec,
        CLSZ = 10, cutoff = 0.01, gocats = c("MF", "BP", "CC"),
        recordSpecGO = NULL)
}, step_name = "go_enrich", dependency = "get_go_annot")
```

### 3.11.3 Plot batch GO term results

The `data.frame` generated by `GOCluster` can be plotted with the `goBarplot` function.
Because of the variable size of the sample sets, it may not always be desirable to show
the results from different DEG sets in the same bar plot. Plotting single sample
sets is achieved by subsetting the input data frame as shown in the first line
of the following example.

```
appendStep(sal) <- LineWise(code = {
    gos <- BatchResultslim[grep("M6-V6_up_down", BatchResultslim$CLID),
        ]
    gos <- BatchResultslim
    png("results/GOslimbarplotMF.png", height = 8, width = 10)
    goBarplot(gos, gocat = "MF")
    goBarplot(gos, gocat = "BP")
    goBarplot(gos, gocat = "CC")
    dev.off()
}, step_name = "go_plot", dependency = "go_enrich")
```

![](data:image/png;base64...)

Figure 8: GO Slim Barplot for MF Ontology.

## 3.12 Differential ribosome loading analysis (translational efficiency)

Combined with mRNA-Seq data, Ribo-Seq or polyRibo-Seq experiments can be used
to study changes in translational efficiencies of genes and/or transcripts for
different treatments. For test purposes the following generates a small test
data set from the sample data used in this vignette, where two types of RNA
samples (`assays`) are considered: polyribosomal mRNA (`Ribo`)
and total mRNA (`mRNA`). In addition, there are two treatments
(`conditions`): `M1` and `A1`.

```
appendStep(sal) <- LineWise(code = {
    countDFeByg <- read.delim("results/countDFeByg.xls", row.names = 1,
        check.names = FALSE)
    coldata <- S4Vectors::DataFrame(assay = factor(rep(c("Ribo",
        "mRNA"), each = 4)), condition = factor(rep(as.character(targetsWF(sal)[["hisat2_mapping"]]$Factor[1:4]),
        2)), row.names = as.character(targetsWF(sal)[["hisat2_mapping"]]$SampleName)[1:8])
    coldata
}, step_name = "diff_loading", dependency = "go_plot")
```

Differences in translational efficiencies can be calculated by ratios of ratios
for the two conditions:

\[(Ribo\\_A1 / mRNA\\_A1) / (Ribo\\_M1 / mRNA\\_M1)\]

The latter can be modeled with the `DESeq2` package using the design
\(\sim assay + condition + assay:condition\), where the interaction term
\(assay:condition\) represents the ratio of ratios. Using the likelihood ratio
test of `DESeq2`, which removes the interaction term in the reduced model,
one can test whether the translational efficiency (ribosome loading) is different
in condition `A1` than in `M1`.

```
appendStep(sal) <- LineWise(code = {
    dds <- DESeq2::DESeqDataSetFromMatrix(countData = as.matrix(countDFeByg[,
        rownames(coldata)]), colData = coldata, design = ~assay +
        condition + assay:condition)
    # model.matrix(~ assay + condition + assay:condition,
    # coldata) # Corresponding design matrix
    dds <- DESeq2::DESeq(dds, test = "LRT", reduced = ~assay +
        condition)
    res <- DESeq2::results(dds)
    head(res[order(res$padj), ], 4)
    write.table(res, file = "transleff.xls", quote = FALSE, col.names = NA,
        sep = "\t")
}, step_name = "diff_translational_eff", dependency = "diff_loading")
```

## 3.13 Clustering and heat maps

The following example performs hierarchical clustering on the `rlog` transformed
expression matrix subsetted by the DEGs identified in the above differential
expression analysis. It uses a Pearson correlation-based distance measure and
complete linkage for cluster joining.

```
appendStep(sal) <- LineWise(code = {
    geneids <- unique(as.character(unlist(DEG_list[[1]])))
    y <- assay(rlog(dds))[geneids, ]
    y <- y[rowSums(y[]) > 0, ]
    png("results/heatmap1.png")
    pheatmap(y, scale = "row", clustering_distance_rows = "correlation",
        clustering_distance_cols = "correlation")
    dev.off()
}, step_name = "heatmap", dependency = "diff_translational_eff")
```

![](data:image/png;base64...)

Figure 9: Heat map with hierarchical clustering dendrograms of DEGs

## 3.14 Version Information

```
appendStep(sal) <- LineWise(code = {
    sessionInfo()
}, step_name = "sessionInfo", dependency = "heatmap")
```

# 4 Running workflow

## 4.1 Interactive job submissions in a single machine

For running the workflow, `runWF` function will execute all the steps store in
the workflow container. The execution will be on a single machine without
submitting to a queuing system of a computer cluster.

```
sal <- runWF(sal, run_step = "mandatory")
```

## 4.2 Parallelization on clusters

Alternatively, the computation can be greatly accelerated by processing many files
in parallel using several compute nodes of a cluster, where a scheduling/queuing
system is used for load balancing.

The `resources` list object provides the number of independent parallel cluster
processes defined under the `Njobs` element in the list. The following example
will run 18 processes in parallel using each 4 CPU cores.
If the resources available on a cluster allow running all 18 processes at the
same time, then the shown sample submission will utilize in a total of 72 CPU cores.

Note, `runWF` can be used with most queueing systems as it is based on utilities
from the `batchtools` package, which supports the use of template files (*`*.tmpl`*)
for defining the run parameters of different schedulers. To run the following
code, one needs to have both a `conffile` (see *`.batchtools.conf.R`* samples [here](https://mllg.github.io/batchtools/))
and a `template` file (see *`*.tmpl`* samples [here](https://github.com/mllg/batchtools/tree/master/inst/templates))
for the queueing available on a system. The following example uses the sample
`conffile` and `template` files for the Slurm scheduler provided by this package.

The resources can be appended when the step is generated, or it is possible to
add these resources later, as the following example using the `addResources`
function:

```
# wall time in mins, memory in MB
resources <- list(conffile = ".batchtools.conf.R", template = "batchtools.slurm.tmpl",
    Njobs = 18, walltime = 120, ntasks = 1, ncpus = 4, memory = 1024,
    partition = "short")
sal <- addResources(sal, c("hisat2_mapping"), resources = resources)
sal <- runWF(sal, run_step = "mandatory")
```

## 4.3 Visualize workflow

*`systemPipeR`* workflows instances can be visualized with the `plotWF` function.

```
plotWF(sal, rstudio = TRUE)
```

## 4.4 Checking workflow status

To check the summary of the workflow, we can use:

```
sal
statusWF(sal)
```

## 4.5 Accessing logs report

*`systemPipeR`* compiles all the workflow execution logs in one central location,
making it easier to check any standard output (`stdout`) or standard error
(`stderr`) for any command-line tools used on the workflow or the R code stdout.

```
sal <- renderLogs(sal)
```

## 4.6 Tools used

To check command-line tools used in this workflow, use `listCmdTools`, and use `listCmdModules`
to check if you have a modular system.

The following code will print out tools required in your custom SPR project in the report.
In case you are running the workflow for the first time and do not have a project yet, or you
just want to browser this workflow, following code displays the tools required by default.

```
if (file.exists(file.path(".SPRproject", "SYSargsList.yml"))) {
    local({
        sal <- systemPipeR::SPRproject(resume = TRUE)
        systemPipeR::listCmdTools(sal)
        systemPipeR::listCmdModules(sal)
    })
} else {
    cat(crayon::blue$bold("Tools and modules required by this workflow are:\n"))
    cat(c("hisat2/2.1.0", "samtools/1.14"), sep = "\n")
}
```

```
## Tools and modules required by this workflow are:
## hisat2/2.1.0
## samtools/1.14
```

## 4.7 Report Information

This is the session information for rendering this report. To access the session information
of workflow running, check HTML report of `renderLogs`.

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] systemPipeR_2.16.3          ShortRead_1.68.0
##  [3] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           BiocParallel_1.44.0
##  [9] Rsamtools_2.26.0            Biostrings_2.78.0
## [11] XVector_0.50.0              GenomicRanges_1.62.1
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] Seqinfo_1.0.0               BiocGenerics_0.56.0
## [17] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.56
##  [3] bslib_0.10.0        hwriter_1.3.2.1
##  [5] ggplot2_4.0.2       htmlwidgets_1.6.4
##  [7] latticeExtra_0.6-31 lattice_0.22-9
##  [9] vctrs_0.7.1         tools_4.5.2
## [11] bitops_1.0-9        parallel_4.5.2
## [13] tibble_3.3.1        pkgconfig_2.0.3
## [15] Matrix_1.7-4        RColorBrewer_1.1-3
## [17] S7_0.2.1            cigarillo_1.0.0
## [19] lifecycle_1.0.5     stringr_1.6.0
## [21] compiler_4.5.2      farver_2.1.2
## [23] deldir_2.0-4        codetools_0.2-20
## [25] htmltools_0.5.9     sass_0.4.10
## [27] yaml_2.3.12         pillar_1.11.1
## [29] crayon_1.5.3        jquerylib_0.1.4
## [31] DelayedArray_0.36.0 cachem_1.1.0
## [33] abind_1.4-8         tidyselect_1.2.1
## [35] digest_0.6.39       stringi_1.8.7
## [37] dplyr_1.2.0         bookdown_0.46
## [39] fastmap_1.2.0       grid_4.5.2
## [41] cli_3.6.5           SparseArray_1.10.8
## [43] magrittr_2.0.4      S4Arrays_1.10.1
## [45] dichromat_2.0-0.1   scales_1.4.0
## [47] rmarkdown_2.30      pwalign_1.6.0
## [49] jpeg_0.1-11         interp_1.1-6
## [51] otel_0.2.0          png_0.1-8
## [53] evaluate_1.0.5      knitr_1.51
## [55] rlang_1.1.7         Rcpp_1.1.1
## [57] glue_1.8.0          BiocManager_1.30.27
## [59] formatR_1.14        jsonlite_2.0.0
## [61] R6_2.6.1
```

# 5 Funding

This research was funded by National Science Foundation Grants IOS-0750811 and
MCB-1021969, and a Marie Curie European Economic Community Fellowship
PIOF-GA-2012-327954.

# References

Aspden, Julie L, Ying Chen Eyre-Walker, Rose J Phillips, Unum Amin, Muhammad Ali S Mumtaz, Michele Brocard, and Juan-Pablo Couso. 2014. “Extensive Translation of Small Open Reading Frames Revealed by Poly-Ribo-Seq.” *Elife* 3: e03528. <https://doi.org/10.7554/eLife.03528>.

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

Ingolia, N T, S Ghaemmaghami, J R Newman, and J S Weissman. 2009. “Genome-Wide Analysis in Vivo of Translation with Nucleotide Resolution Using Ribosome Profiling.” *Science* 324 (5924): 218–23. <https://doi.org/10.1016/j.ymeth.2009.03.016>.

Ingolia, N T, L F Lareau, and J S Weissman. 2011. “Ribosome Profiling of Mouse Embryonic Stem Cells Reveals the Complexity and Dynamics of Mammalian Proteomes.” *Cell* 147 (4): 789–802. <https://doi.org/10.1016/j.cell.2011.10.002>.

Juntawong, Piyada, Thomas Girke, Jérémie Bazin, and Julia Bailey-Serres. 2014. “Translational Dynamics Revealed by Genome-Wide Profiling of Ribosome Footprints in Arabidopsis.” *Proc. Natl. Acad. Sci. U. S. A.* 111 (1): E203–12. <https://doi.org/10.1073/pnas.1317811111>.

Juntawong, Piyada, Maureen Hummel, Jeremie Bazin, and Julia Bailey-Serres. 2015. “Ribosome Profiling: A Tool for Quantitative Evaluation of Dynamics in mRNA Translation.” *Methods Mol. Biol.* 1284: 139–73. [https://doi.org/10.1007/978-1-4939-2444-8\\_7](https://doi.org/10.1007/978-1-4939-2444-8%5C_7).

Kim, Daehwan, Ben Langmead, and Steven L Salzberg. 2015. “HISAT: A Fast Spliced Aligner with Low Memory Requirements.” *Nat. Methods* 12 (4): 357–60.

Lawrence, Michael, Wolfgang Huber, Hervé Pagès, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T Morgan, and Vincent J Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Comput. Biol.* 9 (8): e1003118. <https://doi.org/10.1371/journal.pcbi.1003118>.

Robinson, M D, D J McCarthy, and G K Smyth. 2010. “EdgeR: A Bioconductor Package for Differential Expression Analysis of Digital Gene Expression Data.” *Bioinformatics* 26 (1): 139–40. <https://doi.org/10.1093/bioinformatics/btp616>.