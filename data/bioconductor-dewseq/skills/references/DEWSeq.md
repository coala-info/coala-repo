# Analyzing eCLIP and iCLIP data with DEWSeq

Sudeep Sahadevan1 and Thomas Schwarzl1\*

1European Molecular Biology Laboratory, Heidelberg, Germany

\*schwarzl@embl.de

#### 10/29/2025

#### Abstract

The target identification of RNA-binding proteins is very similar in methodology to the detection of differentially expressed regions. Protocols such as eCLIP or iCLIP sequencing provide count data for individual nucleotides. DEWSeq implements a sliding window approach for the analysis of enriched regions in the immunoprecipitation (IP) sample compared to its size-matched input (SMI) control samples. This vignette explains properties of eCLIP and iCLIP data related methods and shows how to perform a differentially expressed sliding-window approach to detect RNA-binding protein’s binding sites.

#### Package

DEWSeq 1.24.0

# 1 Preface

## 1.1 Related packages

Other Bioconductor package with similar aim:

* *[csaw](https://bioconductor.org/packages/3.22/csaw)*

Please get familiar with this Bioconductor package before you are using DEWSeq

* *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*
* *[IHW](https://bioconductor.org/packages/3.22/IHW)*

## 1.2 Acknowledgements

Wolfgang Huber and Matthias Hentze for mentoring, advice and discussion.
Benjamin Lang and Gian Tartaglia for great help with functional analysis
and benchmarking, as well as feedback on the vignette. Ina Huppertz for
helpful feedback and language improvement on the vignette. Mike Love,
Simon Anders, Bernd Klaus and Frederick Ziebell for comments and discussion.

# 2 Introduction

## 2.1 Introduction to eCLIP sequencing

RNA-binding proteins (RBPs) play a key role in the life-time
of RNAs. They are involved in RNA synthesis, stability,
degradation, transport and translation and add an
important layer of regulation in the cell. Over 1,900 murine
and over 1,400 human RBPs were detected in different high-throughput
detection studies, many of them without known RNA-binding
function (Hentze et al. [2018](#ref-Hentze2018)).

It is of great interest to detect an RBP’s binding sites to
study the underlying mechanism of its regulatory potential. Individual
nucleotide resolution crosslinking and immunoprecipitation (iCLIP)
(König et al. [2010](#ref-Konig2010)) and
the further enhanced CLIP (eCLIP) protocol (Van Nostrand et al. [2016](#ref-VanNostrand2016))
rely on UV crosslinking inducing covalent
bonds of RNA and proteins in close proximity. When reverse
transcribing the RNA fragment bound to the protein, a majority
of the time the reverse transcriptase will terminate at the
crosslink site. Although
eCLIP introduces updates in chemistry, the use of a size-matched
input (SMI) control sample is an essential addition to the protocol
which can be also adapted to iCLIP or similar protocols.

![Crosslink site trunction at reverse transcription](data:image/png;base64...)

Figure 1: Crosslink site trunction at reverse transcription

In iCLIP and eCLIP, truncation events are extracted as one nucleotide position
next to the cDNA fragment (aligned read). In the classical protocols real
truncations cannot be distinguished from read-through reads or other
reads coming from otherwise truncated reads, which might be caused by
RNA modifications or the crosslinking sites of other proteins.
This might be different for each individual proteins (and the
remaining polypeptide of the digested protein). Other protocols like HITS-CLIP
and PAR-CLIP (Hafner et al. [2010](#ref-Hafner2010)) rely exclusively on read-through events
(although using other reverse transcriptases). While hybrid approaches exist,
the technical difficulty of these protocols requires many optimizations steps,
which makes them rather hard to combine.

![Truncation sites (referred to as crosslink sites) are the neighboring position of the aligned read](data:image/png;base64...)

Figure 2: Truncation sites (referred to as crosslink sites) are the neighboring position of the aligned read

In summary, iCLIP and eCLIP protocols provide count data for single-nucleotide
positions which might be the result of many heuristic events. These are described
in the next chapter.

## 2.2 The idea behind DEWSeq

### 2.2.1 Understanding the signal

#### 2.2.1.1 Binding modes

Unlike transcription factors, RNA-binding proteins have many different binding
modes (Hentze et al. [2018](#ref-Hentze2018)), some bind in a sequence specific manner, some have preference for
structures (like stem-loops), some prefer to bind RNA modifications,
others are mostly found at UTRs. A large portion of RBPs do not have
a known RNA-binding domain and bind using disordered regions with unknown
target preferences.

![Different binding modes of RNA-binding proteins](data:image/png;base64...)

Figure 3: Different binding modes of RNA-binding proteins

All these different binding modes can result in different crosslinking patterns,
hence different truncation event patterns.

#### 2.2.1.2 Chance of crosslinking

UV crosslinking at 254 nm is used to induce covalent chemical
bonds within very close proximity of RNAs to proteins. This provides a “snapshot”
of the RNA binding event and ensures that no disassociation of the RNA-protein complexes
takes place in further steps. Typically, crosslinking with Stratlinker(R) UV crosslinkers has
a limited efficiency of around 1% or less (depending on UV lamp intensity and time of
irradiation). Newer crosslinkers with lasers reach up to 5-20% crosslinking
efficiency depending on the protein and experimental setup.

![Chance of crosslinking](data:image/png;base64...)

Figure 4: Chance of crosslinking

Depending on the type of protein and the binding mode, this can result in
different crosslinking patterns for each protein. While crosslinking affects
all RBPs, the immunoprecipitation (IP) step should only enrich for RNA fragments
bound to the RBP of interest. In turn, this means that crosslinked samples show a
certain background which is different to normal expression patterns measured
by RNA-sequencing.

#### 2.2.1.3 Background and antibodies

##### 2.2.1.3.1 Enrichment of targets

Immunoprecipitating your (crosslinked) protein and performing sequencing
without any RNA digestion is called RIP-seq (without crosslinking) or
HITS-CLIP (with crosslinking). These studies nicely show that the
enrichment of your protein with antibodies, recognizing protein tags or
native epitops will enrich RNA fragments bound to the protein.
However, the immunoprecipitated (’IP’ed) samples closely resemble a full transcriptomic
background. Depending on the specificity of your antibody, purification method
(e.g. type of beads) and many other factors, this degree of resemblance can vary
for different proteins. The authors do not know any cases where IP steps exclusively purify
targets. If you find any such cases, please contact the authors, for further discussions
(we would really like to know).

##### 2.2.1.3.2 Contaminants vs background

If you take a closer look at the first iCLIP analysis protocols
(and lot of protocols to date), you will notice that snoRNAs, lincRNAs
and other short RNAs are excluded from the analysis, although they
make up a majority of the signal. They were either treated as contaminants
and dismissed right away, or more recently it was recommended to compare the
i/eCLIP data with an orthogonal dataset like an RNA-seq knockout data and only look at the
regions of interest that are common in both. As already mentioned, it was shown that size-matched
input (SMI) controls can control for different artifacts coming from crosslinking
and library preparation (Van Nostrand et al. [2016](#ref-VanNostrand2016)). After applying an enrichment correction it is
possible to detect lincRNA, snoRNA binders.

As we previously discussed, crosslinked samples do have a different background
compared to expressionlevels (as detected with RNA-seq). Therefore, it is of great
importance to compare the IPed sample to a proper input control.

#### 2.2.1.4 RNA fragment length and RNase concentrations

To narrow down the target RNAs to the binding site region, RNase is used
to digest RNA not protected by your protein. Using different RNase
concentrations will result in different RNA fragment lengths.
In addition, it was shown that the crosslinking pattern will be affected by
longer RNA fragments, which occurs as a result of the protein of interest binding
closely together, protecting a larger RNA region from digestion (Haberman et al. [2017](#ref-Haberman2017)).

![Different RNase concentrations will result in different fragment sizes.](data:image/png;base64...)

Figure 5: Different RNase concentrations will result in different fragment sizes

#### 2.2.1.5 Read-throughs

iCLIP and eCLIP depend on the termination of the reverse transcriptase
at crosslink sites. In contrast, HITS-CLIP and PAR-CLIP need reverse
transcriptases reading through the crosslink sites.
Both methods use different reverse transcriptases with
different likelihood of truncating or reading through (Hocq et al. [2018](#ref-Hocq2018)).
The chance of this event will also be affected by the
polypeptide which is left after protein digestion of the protein of interest.

![Read-throughs](data:image/png;base64...)

Figure 6: Read-throughs

“Read-through” events can truncate at crosslink sites from the same protein,
a different protein, an RNA modification, any other unknown events or
finish at the end of an RNA fragment. Due to the low efficiency
the crosslinking of multiple proteins is usually less likely, however
not improbable.

##### 2.2.1.5.1 Early truncations

Early truncations can also occur on a long RNA fragment with multiple
crosslink sites from different proteins or multiple crosslink sites
from the same protein. Again, although low crosslinking
efficiency reduces the chance of having multiple crosslink sites
at once, those events occur stochastically.

![Early truncation events](data:image/png;base64...)

Figure 7: Early truncation events

### 2.2.2 Method

#### 2.2.2.1 Differentially expressed sliding windows

Because of the properties of i/eCLIP data described above, we use a
sliding window approach (where different window and step sizes can be chosen in
the preprocessing step) and test for significant enrichment in the IP over the
control. For this, we extended *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* for a one-sided
test: first, we filter windows with negative wald test statistic values (windows with negative log2FoldChange)
followed a right-tailed test on the remaining windows. The advantage is that the filtering step increases performance
when testing millions of windows.

![Sliding window approach with single-nucleotide position count data](data:image/png;base64...)

Figure 8: Sliding window approach with single-nucleotide position count data

#### 2.2.2.2 Combining significant windows

In contrast to large fragments detected in ChIP-seq, the truncation sites
are only one nucleotide. To combine windows in ChIP-seq dataset, *[csaw](https://bioconductor.org/packages/3.22/csaw)*
defines binding regions which are then subjected to multiple
hypothesis correction. In ChIP-seq many windows share coverage from large
cDNA fragments and therefore *[csaw](https://bioconductor.org/packages/3.22/csaw)* performs multiple hypothesis
correction on binding site with the SIMES method (SIMES [1986](#ref-SIMES1986)). SIMES joins coverage blocks
and treats them as one entity for multiple hypothesis correction. In large,
SIMES punished p-values for long stretches of overlapping windows. Please
refer to the *[csawUserGuide](https://bioconductor.org/packages/3.22/csawUserGuide)* for detailed description.

Single-nucleotide truncation events do not have the same property as cDNA
fragments and the transcriptomic background for each gene in eCLIP or iCLIP
often results in large coverage blocks. As seen in the picture below, the
windows do only share information with the overlapping windows. Therefore,
DEWSeq corrects the p-value for each
overlapping window with the number of overlaps using Bonferroni correction.

![Combining significant windows](data:image/png;base64...)

Figure 9: Combining significant windows

We then apply FDR correction on the p-values corrected for overlaps using Bonferroni correction.

## 2.3 Prerequisits for DEWSeq

Most importantly, replicates and input controls are required for the
significance testing for DEWSeq. Currently, we only allow the use of
*[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*’s wald test and LRT test. Please contact the authors if you would like
to use more complex models in your analysis.

### 2.3.1 Input controls

Typically, CLIP-seq sa mples show a background which comes from
a mix of various transcripts with different expression levels.
Additionally, UV crosslinking does not affect RNAs in a linear fashion,
therefore an appropriate input control is needed for the analysis of
eCLIP/iCLIP data. Unfortunately, total RNA-seq does not reflect the
UV crosslinked background. Also neither IgG-, empty beads,
nor similar controls seem to be appropriate input controls. Mostly,
IgG and empty bead controls suggest that the IP input is very clean,
which is not what is seen in the data. IP sample often have a
broad background signal and bias towards sno and lincRNAs, as well
as other RNA types. Often, a majority of the reads in the IP come
from such background, although the IgG and empty bead control samples
cannot correct for that.

We recommend size-matched input controls (SMI) controls as performed in
the eCLIP protocol (Van Nostrand et al. [2016](#ref-VanNostrand2016)).
This type of input control is not protocol specific, therefore can be
easily adapted to iCLIP or other CLIP studies. It proves useful to
exclude many false positives and can
control for truncations caused by interferences.

![Combining significant windows](data:image/png;base64...)

Figure 10: Combining significant windows

*Empty beads* controls are usually crosslinked and control for unspecific
background caused through beads, *IgG* controls are usually crosslinked
and control additionally for background caused by the invariable region
of the antibody. *No crosslink* (noCL) controls for background
caused by the protein and the functional antibody. *SMI* controls are
crosslinked but not enriched, it controls among others for the
background caused by crosslinked RNA.

*[DEWSeq](https://bioconductor.org/packages/3.22/DEWSeq)* uses SMI controls to calculate enrichment in the
IPed samples. We recommend to use IgG or empty beads controls to flag
(expression dependent) regions for optional removal.

### 2.3.2 Replicates

Biological replicates in high-throughput studies are needed in the
significance testing process to ensure reproducibility of the results.
Please refer to the *[csaw](https://bioconductor.org/packages/3.22/csaw)* package for discussion on this topic.

In general, we recommend to ask yourself how many replicates would you
use when performing RNA-seq. Usually, the answer is, at least three
for the sample and three for the control (depending on many experimental
factors which also will apply for your CLIP study). As a rule of thumb,
your number of replicates should not be less if you are
interested in an transcriptome wide analysis of your RNA-binding protein.

# 3 Data pre-processing

DEWSeq needs a countmatrix and preprocessed annotation. The
preprocessing is done in two general steps.

1. Raw data preprocessing, alignment and PCR duplication removal
2. Extraction of crosslink sites, preprocessing of annotation and counting.

## 3.1 Raw data pre-processing

**From fastq to bam files**

eCLIP or iCLIP data preprocessing can be time-consuming.
Generally, the pre-processing steps are:

* Unique Molecular Identifiers (UMIs) extraction and demultiplexing
  ([Je Suite](https://gbcs.embl.de/portal/tiki-index.php?page=Je), or other
  tools). Usually, the UMI is extracted from the fasta sequence and added to
  the header. Different tools add the UMI at different locations (beginning or
  end of fastq header).
* Read quality filtering (optional)
* Trimming of sequencing adapters (with tools like
  [cutadapt](https://cutadapt.readthedocs.io))
* Second trimming step (**extremely important** for standard paired-end eCLIP
  libraries). This is needed because a ‘bug’ in the standard paired-end eCLIP
  protocol.
* Quality Control ([fastqc](https://github.com/s-andrews/FastQC) with
  [multiqc](https://multiqc.info/) summary statistics or similar).
* Alignment ([Novoalign](http://www.novocraft.com/products/novoalign/),
  [STAR](https://github.com/alexdobin/STAR), or other (splice-aware) aligners,
  depending on your organism).
* PCR duplication removal also called UMI evaluation
  [Je Suite](https://gbcs.embl.de/portal/tiki-index.php?page=Je) or
  custom tools depending on your protocol and single-read or paired-end setup.
  Please use tools which consider sequencing errors in the UMI and read
  sequences.
* Sort and index bam files ([samtools](http://samtools.sourceforge.net) or
  similar)

Eventually, you will end up with sorted *.bam* files.

## 3.2 Crosslink site extraction and counting

**From bam and gff3 files to count matrix and annotation**

[htseq-clip](https://pypi.org/project/htseq-clip/) is the
preprocessing pipeline developed for the use for
DEWSeq, but other tools may be used.
htseq-clip performs the following steps:

* extract sites (typically crosslink sites)
* flatten the annotation and create a mapping file for later use
* generate sliding windows from the flattened annotation
* count sites in sliding windows
* create count matrices

![htseq-clip workflow](data:image/png;base64...)

Figure 11: htseq-clip workflow

In addition, htseq-clip can also:

* split the annotation into UTRs, CDS
* count non-overlapping regions (UTRs, CDS, exons, introns, etc) for
  enrichment plots or DESeq2 analysis

htseq-clip can be installed via Python package installer as:

```
pip install htseq-clip
```

Additional details on htseq-clip functions and required input files are [described here](https://htseq-clip.readthedocs.io/en/latest/)

All you need is

* .bam files (PCR duplication removed, sorted)
* .bam.bai index files
* .gff3 files (Preferrably from Gencode or similar)

Tip: You can use Sailfish, Kallisto, RSEM, Salmon or any (pseudo)aligner to
get an estimation of the different expression levels of transcripts. Use this to
filter the annotation before flattening it.

# 4 Detection of enriched regions with DEWSeq

DEWSeq uses a sliding window approach with DESeq2 for enriched binding sites.

## 4.1 Installation

DEWSeq can be installed from Bioconductor as follows:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DEWSeq")
```

## 4.2 Load the library

First step is to load the required libraries with this command

```
require(DEWSeq)
require(IHW)
require(tidyverse)
```

## 4.3 Importing data for DEWSeq

This example uses ENCODE SLBP data set, contains two IP and one input control (SMI) samples which
is not ideal, however it is small enough as test data.

```
countFile <- file.path(system.file('extdata',package='DEWSeq'),'SLBP_K562_w50s20_counts.txt.gz')
annotationFile <- file.path(system.file('extdata',package='DEWSeq'),'SLBP_K562_w50s20_annotation.txt.gz')
```

### 4.3.1 Read data

We need to read in the

* count matrix and the (UNIQUE\_ID, counts per sample)
* annotation file (UNIQUE\_ID, chromosome locations, other info)

which can be prepared with htseq-clip (see above)

For this, we recommend `data.table` or `tidyr` packages to read in the data swiftly.
In our experience, data.table is significantly faster than tidyr.

```
require(data.table)
```

First we read in counts

```
countData <- fread(countFile, sep = "\t")
```

Then we read in the annotation data frame

```
annotationData <- fread(annotationFile, sep = "\t")
```

Let’s take a look at the data files:
count data

```
head(countData)
```

```
##                           unique_ID   IP1   IP2   SMI
##                              <char> <int> <int> <int>
## 1: ENSG00000225630.1:exon0001W00014     5     1     4
## 2: ENSG00000225630.1:exon0001W00015     4     0     4
## 3: ENSG00000248527.1:exon0001W00013     2     1     5
## 4: ENSG00000248527.1:exon0001W00014    12     1    54
## 5: ENSG00000248527.1:exon0001W00015    12     1    79
## 6: ENSG00000248527.1:exon0001W00016     9     0    59
```

```
dim(countData)
```

```
## [1] 28569     4
```

and then annotation data

```
head(annotationData)
```

```
##    chromosome  begin    end width strand                        unique_id
##        <char>  <int>  <int> <int> <char>                           <char>
## 1:       chr1 629900 629949    50      + ENSG00000225630.1:exon0001W00014
## 2:       chr1 629920 629969    50      + ENSG00000225630.1:exon0001W00015
## 3:       chr1 633936 633985    50      + ENSG00000248527.1:exon0001W00013
## 4:       chr1 633956 634005    50      + ENSG00000248527.1:exon0001W00014
## 5:       chr1 633976 634025    50      + ENSG00000248527.1:exon0001W00015
## 6:       chr1 633996 634045    50      + ENSG00000248527.1:exon0001W00016
##              gene_id gene_name              gene_type gene_region Nr_of_region
##               <char>    <char>                 <char>      <char>        <int>
## 1: ENSG00000225630.1  MTND2P28 unprocessed_pseudogene        exon            1
## 2: ENSG00000225630.1  MTND2P28 unprocessed_pseudogene        exon            1
## 3: ENSG00000248527.1  MTATP6P1 unprocessed_pseudogene        exon            1
## 4: ENSG00000248527.1  MTATP6P1 unprocessed_pseudogene        exon            1
## 5: ENSG00000248527.1  MTATP6P1 unprocessed_pseudogene        exon            1
## 6: ENSG00000248527.1  MTATP6P1 unprocessed_pseudogene        exon            1
##    Total_nr_of_region window_number
##                 <int>         <int>
## 1:                  1            14
## 2:                  1            15
## 3:                  1            13
## 4:                  1            14
## 5:                  1            15
## 6:                  1            16
```

```
dim(annotationData)
```

```
## [1] 28569    13
```

Finally we have to create a sample description

```
colData <- data.frame(
  row.names = colnames(countData)[-1], # since the first column is unique_id
  type      = factor(
                c(rep("IP", 2),    ##  change this accordingly
                  rep("SMI", 1)),  ##
                levels = c("IP", "SMI"))
)
```

This function will parse the annotation file and create a DESeq object

```
ddw <- DESeqDataSetFromSlidingWindows(countData  = countData,
                                      colData    = colData,
                                      annotObj   = annotationData,
                                      tidy       = TRUE,
                                      design     = ~type)
```

```
## Warning in DESeqDataSetFromSlidingWindows(countData = countData, colData =
## colData, : countData is a data.table or tibble object, converting it to
## data.frame. First column will be used as rownames
```

```
ddw
```

```
## class: DESeqDataSet
## dim: 28569 3
## metadata(1): version
## assays(1): counts
## rownames(28569): ENSG00000225630.1:exon0001W00014
##   ENSG00000225630.1:exon0001W00015 ... ENSG00000210196.2:exon0001W00001
##   ENSG00000210196.2:exon0001W00002
## rowData names(8): unique_id gene_id ... Total_nr_of_region
##   window_number
## colnames(3): IP1 IP2 SMI
## colData names(1): type
```

This will return a DESeq object with the coordinates and annotation stores as
rowAnnotation.

## 4.4 Estimating Size Factors

For library normalisation, rather than modifying the raw counts,
DESeq2 estimates size factors which are incorportated in the anlaysis.
For more information, please refer to the DESeq2 vignette.

The standard procedure to estimate size factors is

```
ddw <- estimateSizeFactors(ddw)
sizeFactors(ddw)
```

```
##       IP1       IP2       SMI
## 0.8434327 0.5000000 2.3811016
```

## 4.5 Prefiltering

### 4.5.1 DESeq2 approach

Prefiltering becomes even more important with large numbers of sliding windows.
Please find more details here:
[DESeq2 vignette on pre-filtering](http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#pre-filtering)

```
keep <- rowSums(counts(ddw)) >= 10
ddw <- ddw[keep,]
```

### 4.5.2 max window count approach

Prefiltering can also be done based on [htseq-clip](https://htseq-clip.readthedocs.io/en/latest/documentation.html#helper-functions)
output files. `htseq-clip` helper function [createMaxCountMatrix](https://htseq-clip.readthedocs.io/en/latest/documentation.html#createmaxcountmatrix)
outputs count matrix based on `crosslink_count_position_max` column in the output files
from [count function](https://htseq-clip.readthedocs.io/en/latest/documentation.html#count).

This filtering can be done as follows:

```
maxCountFile <- file.path(system.file('extdata',package='DEWSeq'),'SLBP_K562_w50s20_max_counts.txt.gz')
ddw <- filterCounts( object = ddw,maxCountFile = maxCountFile,
                      countThresh = 5,nsamples = 2)
dim(ddw)
```

```
## [1] 6033    3
```

Based on data.frame in `maxCountFile` this function filters out all the windows with less than `5` counts in atleast `2` samples (out of a total of `3` in this example)

### 4.5.3 Estimate size factors based on a specific set of RNAs

CLIP data often shows high expression levels of small RNAs like snoRNAs,
lincRNAs etc, therefore you might want to normalise based on protein coding
genes only.

```
ddw_mRNAs <- ddw[ rowData(ddw)[,"gene_type"] == "protein_coding", ]
ddw_mRNAs <- estimateSizeFactors(ddw_mRNAs)
sizeFactors(ddw) <- sizeFactors(ddw_mRNAs)
sizeFactors(ddw)
```

```
##       IP1       IP2       SMI
## 0.8105928 0.4311170 3.6384426
```

### 4.5.4 Estimate size factor for assymetric data

In general, when there is asymmetry in the data,
like enrichment in IP over control,
it is a good pratice to call differentially
expressed features with DESeq2 and then exclude them for
normalisation. This might be adjusted for your proteins.

First we identify significant windows in IP or the controls.

```
ddw_tmp <- ddw
ddw_tmp <- estimateDispersions(ddw_tmp, fitType = "local", quiet = TRUE)
ddw_tmp <- nbinomWaldTest(ddw_tmp)
ddw_tmp_results <- results(ddw_tmp,contrast = c("type", "IP", "SMI"),
                           tidy = TRUE, filterFun =  ihw)
tmp_significant_windows <- ddw_tmp_results %>%
                           dplyr::filter(padj < 0.05) %>%
                           dplyr::pull(row)
rm(list = c("ddw_tmp", "ddw_tmp_results"))
```

Then we exclude those for the estimation of the size factors

```
ddw_mRNAs <- ddw_mRNAs[ !rownames(ddw_mRNAs) %in% tmp_significant_windows, ]
ddw_mRNAs <- estimateSizeFactors(ddw_mRNAs)
sizeFactors(ddw) <- sizeFactors(ddw_mRNAs)

rm( list = c("tmp_significant_windows", "ddw_mRNAs"))

sizeFactors(ddw)
```

```
##       IP1       IP2       SMI
## 0.6659833 0.3525594 4.5150388
```

## 4.6 Differential expressed windows analysis

### 4.6.1 Estimate dispersion

We fit parametric and local fit, and decide the best fit following this [Bioconductor post](https://support.bioconductor.org/p/81094/)

First of all, define a variable called `decide_fit` and based on whether the value assigned
to it is `TRUE` or `FALSE` dispersion fit can be decided

```
decide_fit <- TRUE
```

```
parametric_ddw  <- estimateDispersions(ddw, fitType="parametric")
if(decide_fit){
  local_ddw  <- estimateDispersions(ddw, fitType="local")
}
```

This is the dispersion estimate for parametric fit

```
plotDispEsts(parametric_ddw, main="Parametric fit")
```

![](data:image/png;base64...)

This is the dispersion estimate for local fit, given automated decision fitting is enabled:

```
if(decide_fit){
  plotDispEsts(local_ddw, main="Local fit")
}
```

![](data:image/png;base64...)

This will get the residuals for either fit, only for automated decision fitting

```
parametricResid <- na.omit(with(mcols(parametric_ddw),abs(log(dispGeneEst)-log(dispFit))))
if(decide_fit){
  localResid <- na.omit(with(mcols(local_ddw),abs(log(dispGeneEst)-log(dispFit))))
  residDf <- data.frame(residuals=c(parametricResid,localResid),
                        fitType=c(rep("parametric",length(parametricResid)),
                                  rep("local",length(localResid))))
  summary(residDf)
}
```

```
##    residuals           fitType
##  Min.   :5.540e-05   Length:12066
##  1st Qu.:1.130e+00   Class :character
##  Median :1.705e+01   Mode  :character
##  Mean   :1.168e+01
##  3rd Qu.:1.817e+01
##  Max.   :2.122e+01
```

and we plot histograms of the fits

```
if(decide_fit){
  ggplot(residDf, aes(x = residuals, fill = fitType)) +
    scale_fill_manual(values = c("darkred", "darkblue")) +
    geom_histogram(alpha = 0.5, position='identity', bins = 100) + theme_bw()
}
```

![](data:image/png;base64...)

Now, we will decide for the better fit based on median

```
summary(parametricResid)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
## 9.002e-04 1.123e+00 1.743e+01 1.202e+01 1.863e+01 2.122e+01
```

```
if(decide_fit){
  summary(localResid)
  if (median(localResid) <= median(parametricResid)){
    cat("chosen fitType: local")
    ddw <- local_ddw
  }else{
    cat("chosen fitType: parametric")
    ddw <- parametric_ddw
  }
  rm(local_ddw,parametric_ddw,residDf,parametricResid,localResid)
}else{
  ddw <- parametric_ddw
  rm(parametric_ddw)
}
```

```
## chosen fitType: local
```

### 4.6.2 Call differentially bingind regions using wald test

The next step is to estimate the dispersions and perform the wald test
with these two functions.

Please read up on fitType in the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package and adjust
according to your data set.

```
ddw <- estimateDispersions(ddw, fitType = "local", quiet = TRUE)
ddw <- nbinomWaldTest(ddw)
```

You can check the dispersion estimates with the following function:

```
plotDispEsts(ddw)
```

![Dispersion Estimates](data:image/png;base64...)

Figure 12: Dispersion Estimates

### 4.6.3 Significance testing

In the next step we perform a one-sided signficance test, looking for
enrichment in the IP samples vs the SMI controls.
Also it will perform a correction
for p-values of overlapping windows: The function will determine how many
overlapping windows for each window there are (this can vary at the end of
features, e.g. a gene) and then perform Bonferroni for each window.

These family-wise corrected windows will corrected for multiple testing
with Benjamini-Hochberg.

```
resultWindows <- resultsDEWSeq(ddw,
                              contrast = c("type", "IP", "SMI"),
                              tidy = TRUE) %>% as_tibble

resultWindows
```

```
## # A tibble: 3,169 × 20
##    chromosome    begin    end width strand unique_id gene_id gene_name gene_type
##    <chr>         <dbl>  <int> <int> <chr>  <chr>     <chr>   <chr>     <chr>
##  1 chr1        1055024 1.06e6    49 +      ENSG0000… ENSG00… AGRN      protein_…
##  2 chr1        1055033 1.06e6    49 +      ENSG0000… ENSG00… AL645608… sense_in…
##  3 chr1        1055044 1.06e6    49 +      ENSG0000… ENSG00… AGRN      protein_…
##  4 chr1        1055053 1.06e6    49 +      ENSG0000… ENSG00… AL645608… sense_in…
##  5 chr1        1055064 1.06e6    49 +      ENSG0000… ENSG00… AGRN      protein_…
##  6 chr1       11908152 1.19e7    49 +      ENSG0000… ENSG00… RNU5E-1   snRNA
##  7 chr1       11908172 1.19e7    49 +      ENSG0000… ENSG00… RNU5E-1   snRNA
##  8 chr1       11908192 1.19e7    49 +      ENSG0000… ENSG00… RNU5E-1   snRNA
##  9 chr1       11908212 1.19e7    49 +      ENSG0000… ENSG00… RNU5E-1   snRNA
## 10 chr1       11908232 1.19e7    39 +      ENSG0000… ENSG00… RNU5E-1   snRNA
## # ℹ 3,159 more rows
## # ℹ 11 more variables: gene_region <chr>, Nr_of_region <int>,
## #   Total_nr_of_region <int>, window_number <int>, baseMean <dbl>,
## #   log2FoldChange <dbl>, lfcSE <dbl>, stat <dbl>, pvalue <dbl>,
## #   pSlidingWindows <dbl>, pSlidingWindows.adj <dbl>
```

You might be interested to correct for multiple hypothesis testing with IHW.

```
resultWindows[,"p_adj_IHW"] <- adj_pvalues(ihw(pSlidingWindows ~ baseMean,
                     data = resultWindows,
                     alpha = 0.05,
                     nfolds = 10))
```

Here some basic stats about the differentially expressed windows:

```
resultWindows <- resultWindows %>%
                      mutate(significant = resultWindows$p_adj_IHW < 0.01)

sum(resultWindows$significant)
```

```
## [1] 1088
```

1088 windows are significant.

Here are the top 20 from
143
genes:

```
resultWindows %>%
   filter(significant) %>%
   arrange(desc(log2FoldChange)) %>%
   .[["gene_name"]] %>%
   unique %>%
   head(20)
```

```
##  [1] "HIST1H4J"  "HIST1H2BF" "HIST1H3J"  "HIST1H4H"  "HIST1H2BD" "HIST1H2BL"
##  [7] "HIST1H4B"  "HIST1H2BJ" "HIST1H2BG" "HIST1H2AG" "HIST1H4C"  "HIST1H3D"
## [13] "HIST1H3H"  "HIST1H4I"  "HIST1H2BN" "HIST1H1E"  "H2AFX"     "HIST1H4E"
## [19] "HIST2H2BE" "HIST1H2BC"
```

SLBP is an histone-RNA binding protein, so we are quite happy to see that the
majority of the hits are coming from histone genes.

## 4.7 Combining regions

`resultWindows` contains information about the differential expression of
windows. Now we would like to combine overlapping windows to a binding region.

```
resultRegions <- extractRegions(windowRes  = resultWindows,
                                padjCol    = "p_adj_IHW",
                                padjThresh = 0.01,
                                log2FoldChangeThresh = 0.5) %>% as_tibble
```

```
## Warning in extractRegions(windowRes = resultWindows, padjCol = "p_adj_IHW", :
## windowRes is a data.table or tibble object, converting it to data.frame
```

Since we already corrected for the family wise error, we use the
`extractRegions` function to combine the overlapping significant windows and
provide metrics for best and worst p-adjusted value, as well as best and
worst log2 fold change.

```
resultRegions
```

```
## # A tibble: 228 × 21
##    chromosome region_begin region_end strand windows_in_region region_length
##    <chr>             <dbl>      <int> <fct>              <dbl>         <int>
##  1 chr1           21727931   21728020 -                      3            89
##  2 chr1           28508719   28508762 +                      1            43
##  3 chr1           28508721   28508770 +                      1            49
##  4 chr1           28648620   28648730 +                      5           110
##  5 chr1           28648620   28648733 +                      5           113
##  6 chr1           44721786   44721855 -                      2            69
##  7 chr1           44731055   44731124 -                      2            69
##  8 chr1           44819864   44819933 -                      2            69
##  9 chr1           44819883   44819932 -                      1            49
## 10 chr1           75787879   75787948 +                      2            69
## # ℹ 218 more rows
## # ℹ 15 more variables: padj_min <dbl>, padj_mean <dbl>, padj_max <dbl>,
## #   log2FoldChange_min <dbl>, log2FoldChange_mean <dbl>,
## #   log2FoldChange_max <dbl>, regionStartId <chr>, gene_id <fct>,
## #   gene_name <chr>, gene_type <chr>, gene_region <chr>, Nr_of_region <dbl>,
## #   Total_nr_of_region <dbl>, window_number <dbl>, unique_ids <chr>
```

228 binding regions were found which can exported as
BED file so you can browse the regions in your genome browser of choice
or use it for further analyses.

```
toBED(windowRes = resultWindows,
      regionRes = resultRegions,
      fileName  = "enrichedWindowsRegions.bed")
```

Further analyses which can be done is enrichment of gene types, sequence
motif analysis of the regions, secondary structure analysis of binding
regions and other functional analyses.

# 5 Discussion

The authors very much welcome any feedback, comments and suggestions.

# 6 Session Info

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
##  [1] data.table_1.17.8           lubridate_1.9.4
##  [3] forcats_1.0.1               stringr_1.5.2
##  [5] dplyr_1.1.4                 purrr_1.1.0
##  [7] readr_2.1.5                 tidyr_1.3.1
##  [9] tibble_3.3.0                ggplot2_4.0.0
## [11] tidyverse_2.0.0             IHW_1.38.0
## [13] DEWSeq_1.24.0               BiocParallel_1.44.0
## [15] DESeq2_1.50.0               SummarizedExperiment_1.40.0
## [17] Biobase_2.70.0              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           GenomicRanges_1.62.0
## [21] Seqinfo_1.0.0               IRanges_2.44.0
## [23] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [25] generics_0.1.4              R.utils_2.13.0
## [27] R.oo_1.27.1                 R.methodsS3_1.8.2
## [29] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] lattice_0.22-7      tzdb_0.5.0          vctrs_0.6.5
##  [7] tools_4.5.1         parallel_4.5.1      pkgconfig_2.0.3
## [10] Matrix_1.7-4        RColorBrewer_1.1-3  S7_0.2.0
## [13] lifecycle_1.0.4     lpsymphony_1.38.0   compiler_4.5.1
## [16] farver_2.1.2        tinytex_0.57        codetools_0.2-20
## [19] htmltools_0.5.8.1   sass_0.4.10         fdrtool_1.2.18
## [22] yaml_2.3.10         pillar_1.11.1       jquerylib_0.1.4
## [25] DelayedArray_0.36.0 cachem_1.1.0        magick_2.9.0
## [28] abind_1.4-8         tidyselect_1.2.1    locfit_1.5-9.12
## [31] digest_0.6.37       stringi_1.8.7       slam_0.1-55
## [34] bookdown_0.45       labeling_0.4.3      fastmap_1.2.0
## [37] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
## [40] magrittr_2.0.4      S4Arrays_1.10.0     utf8_1.2.6
## [43] dichromat_2.0-0.1   withr_3.0.2         scales_1.4.0
## [46] timechange_0.3.0    rmarkdown_2.30      XVector_0.50.0
## [49] hms_1.1.4           evaluate_1.0.5      knitr_1.50
## [52] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [55] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
```

# References

Haberman, Nejc, Ina Huppertz, Jan Attig, Julian König, Zhen Wang, Christian Hauer, Matthias W. Hentze, et al. 2017. “Insights into the design and interpretation of iCLIP experiments.” *Genome Biology* 18 (1). <https://doi.org/10.1186/s13059-016-1130-x>.

Hafner, Markus, Markus Landthaler, Lukas Burger, Mohsen Khorshid, Jean Hausser, Philipp Berninger, Andrea Rothballer, et al. 2010. “Transcriptome-wide Identification of RNA-Binding Protein and MicroRNA Target Sites by PAR-CLIP.” *Cell* 141 (1): 129–41. <https://doi.org/10.1016/j.cell.2010.03.009>.

Hentze, Matthias W., Alfredo Castello, Thomas Schwarzl, and Thomas Preiss. 2018. “A brave new world of RNA-binding proteins.” <https://doi.org/10.1038/nrm.2017.130>.

Hocq, Rémi, Janio Paternina, Quentin Alasseur, Auguste Genovesio, and Hervé Le Hir. 2018. “Monitored ECLIP: High accuracy mapping of RNA-protein interactions.” *Nucleic Acids Research*. <https://doi.org/10.1093/nar/gky858>.

König, Julian, Kathi Zarnack, Gregor Rot, Toma Curk, Melis Kayikci, Blaž Zupan, Daniel J. Turner, Nicholas M. Luscombe, and Jernej Ule. 2010. “ICLIP reveals the function of hnRNP particles in splicing at individual nucleotide resolution.” *Nature Structural and Molecular Biology* 17 (7): 909–15. <https://doi.org/10.1038/nsmb.1838>.

SIMES, R. J. 1986. “An improved Bonferroni procedure for multiple tests of significance.” *Biometrika* 73 (3): 751–54. <https://doi.org/10.1093/biomet/73.3.751>.

Van Nostrand, Eric L., Thai B. Nguyen, Chelsea Gelboin-Burkhart, Ruth Wang, Steven M. Blue, Gabriel A. Pratt, Ashley L. Louie, and Gene W. Yeo. 2017. “Robust, cost-effective profiling of RNA binding protein targets with single-end enhanced crosslinking and immunoprecipitation (SeCLIP)” 1648: 177–200. <https://doi.org/10.1007/978-1-4939-7204-3_14>.

Van Nostrand, Eric L, Gabriel A Pratt, Alexander A Shishkin, Chelsea Gelboin-Burkhart, Mark Y Fang, Balaji Sundararaman, Steven M Blue, et al. 2016. “Robust transcriptome-wide discovery of RNA-binding protein binding sites with enhanced CLIP (eCLIP).” *Nature Methods* 13 (November 2015): 1–9. <https://doi.org/10.1038/nmeth.3810>.