# DAMEfinder Workflow

Stephany Orjuela1,2\*, Dania Machlab2,3 and Mark Robinson2,4

1Oncobit AG
2SIB Swiss Institute of Bioinformatics, Switzerland
3Friedrich Miescher Institute for Biomedical Research, Basel
4Department of Molecular Life Sciences, University of Zurich

\*sorjuelal@gmail.com

#### 2025-10-29

#### Package

DAMEfinder 1.22.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 What is allele-specific methylation?](#what-is-allele-specific-methylation)
* [2 Overview](#overview)
  + [2.1 Why **SNP-based**?](#why-snp-based)
  + [2.2 Why **tuple-based**?](#why-tuple-based)
  + [2.3 Installation](#installation)
* [3 Get bam files](#get-bam-files)
* [4 SNP-based (aka slow-mode)](#snp-based-aka-slow-mode)
  + [4.1 Example Workflow](#example-workflow)
    - [4.1.1 Obtain allele-based methylation calls](#obtain-allele-based-methylation-calls)
    - [4.1.2 Summarize methylation calls across samples](#summarize-methylation-calls-across-samples)
    - [4.1.3 Find DAMEs](#find-dames)
* [5 tuple-based (aka fast-mode)](#tuple-based-aka-fast-mode)
  + [5.1 Run Methtuple on bam files](#run-methtuple-on-bam-files)
  + [5.2 Example Workflow](#example-workflow-1)
    - [5.2.1 Read methtuple files](#read-methtuple-files)
    - [5.2.2 Calculate ASM Score](#calculate-asm-score)
    - [5.2.3 Find DAMEs](#find-dames-1)
* [6 Visualization](#visualization)
  + [6.1 DAME tracks](#dame-tracks)
  + [6.2 Methyl-circle plot](#methyl-circle-plot)
  + [6.3 MDS plot](#mds-plot)
* [7 Session Info](#session-info)
* [References](#references)

# 1 Introduction

## 1.1 What is allele-specific methylation?

The phenomenon occurs when there is an asymmetry in methylation between one
specific allele and the alternative allele (Hu et al. [2013](#ref-hu2013)). The best studied example
of allele-specific methylation (ASM) is genomic imprinting. When a gene is
imprinted, one of the parental alleles is hyper-methylated compared to the other
allele, which leads to parent-allele-specific expression. This asymmetry is
conferred in the gametes or very early in embryogenesis, and will remain for the
lifetime of the individual (Kelsey and Feil [2013](#ref-kelsey2013)). ASM not related to
imprinting, exhibits parental-specific methylation,
but is not inherited from the germline (Hanna and Kelsey [2017](#ref-hanna2017)). Another example of ASM is X
chromosome inactivation in females. DAMEfinder detects ASM for several
bisulfite-sequenced (BS-seq) samples in a cohort, and performs differential
detection for regions that exhibit loss or gain of ASM.

# 2 Overview

We focus on any case of ASM in which there is an imbalance in the methylation
level between two alleles, regardless of the allele of origin.

DAMEfinder runs in two modes: **SNP-based** (exhaustive-mode) and
**tuple-based** (fast-mode), which converge when differential ASM is detected.

## 2.1 Why **SNP-based**?

This is the exhaustive mode because it extracts an ASM score for every CpG site
in the reads containing the SNPs in a VCF file. Based on this score, DAMEs are
detected. From a biological point of view, you might want to run this mode if
you are interested in loss or gain of allele-specificity linked to somatic or
germline heterozygous SNPs (sequence-dependent ASM). More specifically, you
could detect genes that exhibit loss of imprinting (e.g. as in colorectal cancer
(Cui et al. [2002](#ref-cui2002))).

## 2.2 Why **tuple-based**?

To run the **tuple-based** mode you have to run
[methtuple](https://github.com/PeteHaitch/methtuple)(Hickey [2015](#ref-hickey2015)) first. The
methtuple output is the only thing needed for this mode. I call this the
fast-mode because you don’t need SNP information. The assumption is that
intermediate levels of methylation represent ASM along the genome. For example,
we have shown (paper in prep) that the ASM score can distinguish females from
males in the X chromosome. Using SNP information this wouldn’t be possible.

## 2.3 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DAMEfinder")
```

# 3 Get bam files

In order to run any of the two modes, you must obtain aligned bam files using
[`bismark`](http://www.bioinformatics.babraham.ac.uk/projects/bismark/). Here we
demonstrate how to generate these starting from paired-end fastq files of
bisulfite-treated reads:

```
#Check quality of reads
fastqc -t 2  sample1_R1.fastq.gz sample1_R2.fastq.gz

#Trim reads to remove bad quality regions and adapter sequence
trim_galore --paired sample1_R1.fastq.gz sample2_R2.fastq.gz
```

To trim the reads we use [`Trim Galore`](https://github.com/FelixKrueger/TrimGalore) and specify the use of
paired reads. By default it will remove any adapter sequence it recognizes.
Please refer to the user guide for further specifications.

```
#Build bisulfite reference
bismark_genome_preparation <path_to_genome_folder>

#run Bismark
bismark -B sample1 --genome <path_to_genome_folder>
    -1 sample1_R1_val_1.fq.gz
    -2 sample1_R2_val_2.fq.gz

#deduplicate (optional)
deduplicate_bismark -p --bam sample1_pe.bam

#sort and index files
samtools sort -m 20G -O bam -T _tmp
    -o sample1_pe.dedupl_s.bam sample1_pe.deduplicated.bam
samtools index file1_pe.dedupl_s.bam
```

Before the alignment, you must download a reference fasta file from
[Ensembl](https://www.ensembl.org/info/data/ftp/index.html) or
[Gencode](https://www.gencodegenes.org/), and generate a bisulfite converted
reference. For this we use `bismark_genome_preparation` from the `bismark`
suite, and specify the folder that contains the fasta file with its index
file. Depending on the library type and kit used to obtain the reads, you may
want to deduplicate your bam files (e.g. TruSeq). Please refer to the [user
guide](http://www.bioinformatics.babraham.ac.uk/projects/bismark/)
for further explanation and specifications.

# 4 SNP-based (aka slow-mode)

To run the SNP-based mode, you need to additionally have a VCF file including
the heterozygous SNPs per sample. If you do not have this, we recommend using
the tuple-based mode, or running
[`Bis-SNP`](http://people.csail.mit.edu/dnaase/bissnp2011/) to obtain variant
calls from bisulfite-converted reads.

## 4.1 Example Workflow

In this example we use samples from two patients with colorectal cancer from a
published dataset (Parker et al. [2018](#ref-parker2018)). For each patient two samples were taken:
`NORM#` corresponds to normal mucosa tissue and `CRC#` corresponds to the paired
adenoma lesion. Each of these samples was sequenced using targeted BS-seq
followed by variant calling using `Bis-SNP`.

### 4.1.1 Obtain allele-based methylation calls

Similar to the `bismark_methylation_extractor`, we obtain methylation calls.
However since we are interested in allele-specific methylation, we only extract
methylation for CpG sites that fall within reads including a SNP. For every SNP
in the VCF file an independent methylation call is performed by using
`extract_bams`, which “extracts” reads from the bam file according to the
alleles, and generates a `list` of `GRangesList`s:

```
suppressPackageStartupMessages({
  library(DAMEfinder)
  library(SummarizedExperiment)
  library(GenomicRanges)
  library(BSgenome.Hsapiens.UCSC.hg19)
  })

bam_files <- c(system.file("extdata", "NORM1_chr19_trim.bam",
                           package = "DAMEfinder"),
               system.file("extdata", "CRC1_chr19_trim.bam",
                           package = "DAMEfinder"))

vcf_files <- c(system.file("extdata", "NORM1.chr19.trim.vcf",
                           package = "DAMEfinder"),
               system.file("extdata", "CRC1.chr19.trim.vcf",
                           package = "DAMEfinder"))

sample_names <- c("NORM1", "CRC1")

#Use another reference file for demonstration, and fix the seqnames
genome <- BSgenome.Hsapiens.UCSC.hg19
seqnames(genome) <- gsub("chr","",seqnames(genome))
reference_file <- DNAStringSet(genome[[19]], use.names = TRUE)
names(reference_file) <- 19

#Extract reads and extract methylation according to allele
snp.list <- extract_bams(bam_files, vcf_files, sample_names, reference_file,
                       coverage = 2)
```

```
## Reading reference file
```

```
## Running sample NORM1
```

```
## Reading VCF file
```

```
## Extracting methylation per SNP
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   3 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Done with sample NORM1
```

```
## Running sample CRC1
```

```
## Reading VCF file
```

```
## Extracting methylation per SNP
```

```
## Done with sample CRC1
```

```
#CpG sites for first SNP in VCF file from sample NORM1
snp.list$NORM1[[1]]
```

```
## GRanges object with 24 ranges and 5 metadata columns:
##        seqnames    ranges strand |   cov.ref   cov.alt  meth.ref  meth.alt
##           <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
##    [1]       19    266963      * |         2         4         0         0
##    [2]       19    266999      * |         7        15         0         0
##    [3]       19    267087      * |        37        42         0         1
##    [4]       19    267097      * |        36        42         2         4
##    [5]       19    267103      * |        35        41         1         2
##    ...      ...       ...    ... .       ...       ...       ...       ...
##   [20]       19    267207      * |         5         3         0         0
##   [21]       19    267215      * |         4         2         0         0
##   [22]       19    267224      * |         4         2         0         0
##   [23]       19    267229      * |         3         2         0         0
##   [24]       19    267234      * |         3         2         0         0
##                snp
##        <character>
##    [1]   19.267039
##    [2]   19.267039
##    [3]   19.267039
##    [4]   19.267039
##    [5]   19.267039
##    ...         ...
##   [20]   19.267039
##   [21]   19.267039
##   [22]   19.267039
##   [23]   19.267039
##   [24]   19.267039
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
#CpG sites for first SNP in VCF file from sample CRC1
snp.list$CRC1[[1]]
```

```
## GRanges object with 19 ranges and 5 metadata columns:
##        seqnames    ranges strand |   cov.ref   cov.alt  meth.ref  meth.alt
##           <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
##    [1]       19    266999      * |        21        13         2         1
##    [2]       19    267087      * |        51        37         0         0
##    [3]       19    267097      * |        50        37         1         0
##    [4]       19    267103      * |        50        38         0         0
##    [5]       19    267109      * |        49        38         1         1
##    ...      ...       ...    ... .       ...       ...       ...       ...
##   [15]       19    267162      * |        26        18         1         1
##   [16]       19    267164      * |        26        18         0         0
##   [17]       19    267178      * |        16        10         0         0
##   [18]       19    267181      * |        13         8         0         0
##   [19]       19    267207      * |         4         2         0         0
##                snp
##        <character>
##    [1]   19.267039
##    [2]   19.267039
##    [3]   19.267039
##    [4]   19.267039
##    [5]   19.267039
##    ...         ...
##   [15]   19.267039
##   [16]   19.267039
##   [17]   19.267039
##   [18]   19.267039
##   [19]   19.267039
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

For demonstration, we include bam files from chromosome 19, and shortened VCF
files. Typically we would run the function on an entire bam and VCF file, which
would generate a large output.

The function also takes as input the reference file used to generate the
alignments. For demonstration we use chromosome 19 of the `GRCh37.91` reference
fasta file.

### 4.1.2 Summarize methylation calls across samples

We use `calc_derivedasm()` to generate a `RangedSummarizedExperiment` from the
large list we generated above:

```
derASM <- calc_derivedasm(snp.list)
```

```
## ..Summarizing scores
## Summarizing coverages
## Summarizing SNP info
## Returning 158 CpG sites for 2 samples
```

```
derASM
```

```
## class: RangedSummarizedExperiment
## dim: 158 2
## metadata(0):
## assays(7): der.ASM z.ASM ... ref.meth alt.meth
## rownames(158): 19.266963 19.266999 ... 19.292625 19.292645
## rowData names(0):
## colnames(2): NORM1 CRC1
## colData names(1): samples
```

```
assays(derASM)
```

```
## List of length 7
## names(7): der.ASM z.ASM snp.table ref.cov alt.cov ref.meth alt.meth
```

Every row in the object is a single CpG site, and each column a sample. It
contains 6 matrices in `assays`:

* `der.ASM`: A derived SNP-based ASM defined as \(abs(\frac{X^{r}\_M}{X^{r}} - \frac{X^{a}\_M}{X^{a}})\), where \(X\) is the coverage in the reference \(r\) or
  alternative allele \(a\), and \(X\_M\) the number of methylated reads in \(r\) or \(a\).
  Basically, CpG sites with values of 1 or close to 1 have more
  allele-specificity. ASM of 1 represents the perfect scenario in which none of
  the reads belonging to one allele are methylated, and the reads of the other
  allele are completely methylated.
* NEW `z.ASM`: SNP-based ASM defined as a Z score in a two-proportions test:
  \(abs(\frac{p^{r}-p^{a}} {p(1-p)(1/X^{r} + 1/X^{a})})\), where \(p\) is
  \(\frac{X\_M}{X}\) of either the reference, the alternative or both alleles. This
  score is more sensitive to the coverage at each CpG site, and has no upper
  limit.
* `snp.table`: Location of the SNP associated to the CpG site.
* `ref.cov`: Coverage of the “reference” allele.
* `alt.cov`: Covearage of the “alternative” allele.
* `ref.meth`: Methylated reads from the “reference” allele.
* `alt.meth`: Methylated reads from the “alternative” allele.

You can access these assays as:

```
x <- assay(derASM, "der.ASM")
head(x)
```

```
##                NORM1        CRC1
## 19.266963 0.00000000          NA
## 19.266999 0.00000000 0.018315018
## 19.267087 0.02380952 0.000000000
## 19.267097 0.03968254 0.020000000
## 19.267103 0.02020906 0.000000000
## 19.267109 0.05000000 0.005907626
```

### 4.1.3 Find DAMEs

Now we detect regions that show differential ASM. The function `find_dames()`
performs several steps:

1. Obtains a moderated t-statistic per CpG site using `lmFit()` and `eBayes()`
   from the `limma` package. The statistic reflects a measure of difference
   between the conditions being compared, in this case normal Vs cancer. The
   t-statistic is optionally smoothed (`smooth` parameter).

After this, two methods can be chosen (`pvalAssign` parameter):

* Simes method:
  2. (Default) Clusters of CpG sites are determined by closeness (`maxGap`),
     and a p-value for each cluster is calculated using the simes method, similar
     to the package `csaw` from Lun and Smyth ([2014](#ref-lun2014)). With this approach, the p-value
     represents evidence against the null hypothesis that no sites are
     differential in the cluster.
* Bumphunting method:
  2. CpG sites with a t-statistic above and below a certain cutoff (set with
     `Q`), are grouped into segments (after being clustered). This is done with
     the `regionFinder()` function from `bumphunter` (Jaffe et al. [2012](#ref-jaffe2012)).
  3. For each of these segments, a p-value is calculated empirically by
     permuting the groups (covariate) of interest. Depending on the number of
     samples, this can take longer than the Simes method. However the number of
     permutations can be controlled with `maxPerms`.

Here we show an example with a pre-processed set of samples: 4 colorectal cancer
samples, and their paired normal mucosa:

```
data(extractbams_output)

#The data loaded is an output from `split_bams()`, therefore we run
#`calc_derivedasm` to get the SummarizedExperiment
derASM <- calc_derivedasm(extractbams_output, cores = 1, verbose = FALSE)

#We remove all CpG sites with any NA values, but not 0s
filt <- rowSums(!is.na(assay(derASM, "der.ASM"))) == 8
derASM <- derASM[filt,]

#set the design matrix
grp <- factor(c(rep("CRC",4),rep("NORM",4)), levels = c("NORM", "CRC"))
mod <- model.matrix(~grp)
mod
```

```
##   (Intercept) grpCRC
## 1           1      1
## 2           1      1
## 3           1      1
## 4           1      1
## 5           1      0
## 6           1      0
## 7           1      0
## 8           1      0
## attr(,"assign")
## [1] 0 1
## attr(,"contrasts")
## attr(,"contrasts")$grp
## [1] "contr.treatment"
```

```
#Run default
dames <- find_dames(derASM, mod)
```

```
## Using ASMsnp
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Detecting DAMEs
```

```
## 12 DAMEs found.
```

```
head(dames)
```

```
##   chr  start    end  meanTstat   sumTstat pvalSimes clusterL numup numdown
## 9  19 388375 388375  1.6961319  1.6961319 0.1256264        1     1       0
## 7  19 388049 388094  0.7068111  3.5340553 0.1625003        5     3       2
## 3  19 292528 292528 -0.9472183 -0.9472183 0.3693545        1     0       1
## 2  19 292499 292499  0.9428371  0.9428371 0.3714680        1     1       0
## 4  19 292578 292578 -0.7244911 -0.7244911 0.4879850        1     0       1
## 5  19 387966 387983  0.8596840  3.4387358 0.6238076        4     4       0
##         FDR
## 9 0.9750021
## 7 0.9750021
## 3 0.9803244
## 2 0.9803244
## 4 0.9803244
## 5 0.9803244
```

```
#Run empirical method
dames <- find_dames(derASM, mod, pvalAssign = "empirical")
```

```
## Using ASMsnp
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Detecting DAMEs
```

```
## getSegments: segmenting
```

```
## getSegments: splitting
```

```
## Generating 10 permutations
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## Calculating moderated t-statistics
```

```
## Smoothing moderated t-statistics
```

```
## 11 DAMEs found.
```

```
head(dames)
```

```
##    chr  start    end  meanTstat sumTstat segmentL clusterL    pvalEmp      FDR
## 5   19 388049 388055  1.4428937 2.885787        2        5 0.09259259 0.662037
## 6   19 388094 388094  2.4413268 2.441327        1        5 0.19444444 0.662037
## 8   19 388375 388375  1.6961319 1.696132        1        1 0.31481481 0.662037
## 11  19 388073 388090 -0.8965295 1.793059        2        5 0.31481481 0.662037
## 3   19 387983 387983  1.5547490 1.554749        1        4 0.36111111 0.662037
## 7   19 388340 388350  0.7805881 1.561176        2        8 0.36111111 0.662037
```

A significant p-value represent regions where samples belonging to
one group (in this case the cancer samples), gain or lose allele-specificity
compared to the other group (here the normal group).

# 5 tuple-based (aka fast-mode)

Before running the tuple-based mode, you must obtain files from the `methtuple`
tool to input them in the `read_tuples` function.

## 5.1 Run Methtuple on bam files

Methtuple requires the input `BAM` files of paired-end reads to be sorted by
query name. For more information on the options in `methtuple`, refer to the
user [guide](https://github.com/PeteHaitch/methtuple). For example the `--sc`
option combines strand information.

```
# Sort bam file by query name
samtools sort -n -@ 10 -m 20G -O bam -T _tmp
    -o sample1_pe_sorted.bam sample1_pe.deduplicated.bam

# Run methtuple
methtuple --sc --gzip -m 2 sample1_pe_sorted.bam
```

## 5.2 Example Workflow

### 5.2.1 Read methtuple files

We use the same samples as above to run `methtuple` and obtain `.tsv.gz` files.
We read in these files using `read_tuples` and obtain a list of `tibble`s, each
one for every sample:

```
tuple_files <- c(system.file("extdata", "NORM1_chr19.qs.CG.2.tsv.gz",
                             package = "DAMEfinder"),
                 system.file("extdata", "CRC1_chr19.qs.CG.2.tsv.gz",
                             package = "DAMEfinder"))

sample_names <- c("NORM1", "CRC1")

tuple_list <- read_tuples(tuple_files, sample_names)
```

```
## Reading /tmp/Rtmp2ag2jU/Rinst3e29116741b9c2/DAMEfinder/extdata/NORM1_chr19.qs.CG.2.tsv.gz
```

```
## Reading /tmp/Rtmp2ag2jU/Rinst3e29116741b9c2/DAMEfinder/extdata/CRC1_chr19.qs.CG.2.tsv.gz
```

```
## Filtering and sorting: .. done.
```

```
head(tuple_list$NORM1)
```

```
## # A tibble: 6 × 10
##   chr   strand   pos1   pos2    MM    MU    UM    UU   cov inter_dist
##   <chr> <chr>   <int>  <int> <int> <int> <int> <int> <int>      <int>
## 1 19    *      267086 267096     1     0     4    93    98         10
## 2 19    *      267096 267102     2     3     0    94    99          6
## 3 19    *      267102 267108     1     1     1    95    98          6
## 4 19    *      267108 267113     2     0     2    94    98          5
## 5 19    *      267113 267116     1     3     0    94    98          3
## 6 19    *      267116 267120     0     1     1    95    97          4
```

Each row in the `tibble` displays a tuple. The chromosome name and strand are
shown followed by `pos1` and `pos2`, which refer to the genomic positions of the
first and second CpG in the tuple. The `MM`, `MU`, `UM`, and `UU` counts of the
tuple are displayed where `M` stands for methylated and `U` for unmethylated.
For example, `UM` shows the read counts for the instances where `pos1` is
unmethylated and `pos2` is methylated. The coverage and distance between the two
genomic positions in the tuple are shown under `cov` and `inter_dist`
respectively.

### 5.2.2 Calculate ASM Score

The `calc_asm` function takes the output from `read_tuples()`, and as in the
SNP-based mode, generates a `RangedSummarizedExperiment` where each row is a
tuple and each column is a sample. The object contains 6 assays including the
`MM`, `MU`, `UM`, and `UU` counts, as well as the total coverage and the
tuple-based ASM score. This score is a measure of ASM calculated directly from
the reads without the need of SNP information. Because of this, it is a lot
quicker than the SNP-based ASM, and is useful for more explorative purposes.

Equations [(1)](#eq:asmGeneral), [(2)](#eq:asmWeight) and [(3)](#eq:asmTheta) show
how the score is calculated. The log odds ratio in equation [(1)](#eq:asmGeneral)
provides a higher score the more `MM` and `UU` counts the tuple has, whereas a
higher `UM` and `MU` would indicate “random” methylation. The weight further
adds allele-specificity where a rather balanced MM:UU increases the score.

\[\begin{equation}
ASM^{(i)} = log{ \Big\{ \frac{X\_{MM}^{(i)} \cdot X\_{UU}^{(i)}}{X\_{MU}^{(i)}
\cdot X\_{UM}^{(i)}} \Big\} \cdot w\_i }
\tag{1}
\end{equation}\]

\[\begin{equation}
w\_i = P(0.5-\epsilon < \theta < 0.5+\epsilon~|~ X\_{MM}^{(i)}, X\_{UU}^{(i)},
\beta\_1, \beta\_2)
\tag{2}
\end{equation}\]

\[\begin{equation}
\theta^{(i)} | X\_{MM}^{(i)}, X\_{UU}^{(i)},\beta\_1, \beta\_2 \sim
Beta(\beta\_1+X\_{MM}^{(i)}, \beta\_2+X\_{UU}^{(i)})
\tag{3}
\end{equation}\]

where \(\theta^{(i)}\) represents the moderated proportion of MM to MM+UU alleles.
The weight, \(w\_i\) is set such that the observed split between MM and UU alleles
can depart somewhat from 50/50, while fully methylated or unmethylated tuples,
which represents evidence for absence of allele-specificity, are attenuated to
0. The degree of allowed departure can be set according to \(\epsilon\), the
deviation from 50/50 allowed and the level of moderation, \(\beta\_1\) and
\(\beta\_2\).

```
ASM_mat <- calc_asm(tuple_list)
```

```
## Calculating log odds.
```

```
## Calculating ASM score: .. done.
## Creating position pair keys: .. done.
## Assembling table: .. done.
## Transforming.
## Assembling coverage tables: ..........Returning SummarizedExperiment with 3005 CpG pairs
```

```
ASM_mat
```

```
## class: RangedSummarizedExperiment
## dim: 1825 2
## metadata(0):
## assays(6): asm cov ... UM UU
## rownames(1825): 19.267086.267096 19.267096.267102 ... 19.469008.469024
##   19.469051.469066
## rowData names(1): midpt
## colnames(2): NORM1 CRC1
## colData names(0):
```

### 5.2.3 Find DAMEs

As above, the `RangedSummarizedExperiment` is used to detect differential ASM.
Here we show an example with a pre-processed set of samples: 3 colorectal cancer
samples, an 2 normal mucosa samples

```
#load package data
data(readtuples_output)

#run calc_asm and filter object
ASMscore <- calc_asm(readtuples_output)
```

```
## Calculating log odds.
```

```
## Calculating ASM score: ..... done.
## Creating position pair keys: ..... done.
## Assembling table: ..... done.
## Transforming.
## Assembling coverage tables: .........................Returning SummarizedExperiment with 3361 CpG pairs
```

```
filt <- rowSums(!is.na(assay(ASMscore, "asm"))) == 5 #filt to avoid warnings
ASMscore <- ASMscore[filt,]

#make design matrix (or specify a contrast)
grp <- factor(c(rep("CRC",3),rep("NORM",2)), levels = c("NORM", "CRC"))
mod <- model.matrix(~grp)

#run default and increase maxGap to get longer, more sparse regions
dames <- find_dames(ASMscore, mod, maxGap = 300)
```

```
## Using ASMtuple
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Detecting DAMEs
## 78 DAMEs found.
```

```
head(dames)
```

```
##    chr  start    end meanTstat  sumTstat   pvalSimes clusterL numup numdown
## 52  19 424232 424419  2.060434  14.42304 0.005531465        7     7       0
## 33  19 385930 385974  3.325203  16.62602 0.008697161        5     4       1
## 18  19 323736 324622  1.913688  44.01483 0.021421423       23    23       0
## 23  19 359435 359579  1.976496  11.85897 0.025508984        6     6       0
## 38  19 400995 401194  1.770387  19.47425 0.030898659       11    11       0
## 42  19 407086 407360 -1.290909 -25.81818 0.042587680       20     0      20
##          FDR
## 52 0.3391893
## 33 0.3391893
## 18 0.4820191
## 23 0.4820191
## 38 0.4820191
## 42 0.4995466
```

```
#run alternative mode
dames <- find_dames(ASMscore, mod,  maxGap = 300, pvalAssign = "empirical")
```

```
## Using ASMtuple
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Detecting DAMEs
## getSegments: segmenting
## getSegments: splitting
## Generating 6 permutations
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## Calculating moderated t-statistics
## Smoothing moderated t-statistics
## 78 DAMEs found.
```

```
head(dames)
```

```
##    chr  start    end meanTstat sumTstat segmentL clusterL     pvalEmp       FDR
## 56  19 460493 461064 1.0292896 96.75322       94      112 0.003539823 0.2070796
## 42  19 428886 430321 0.9433651 59.43200       63       67 0.005309735 0.2070796
## 17  19 360074 360660 0.9417149 45.20231       48      150 0.015929204 0.3451327
## 12  19 323736 324622 1.9136883 44.01483       23       23 0.017699115 0.3451327
## 36  19 418902 419309 1.0129308 25.32327       25       27 0.053097345 0.4693805
## 7   19 308732 308925 1.1983194 25.16471       21       35 0.054867257 0.4693805
```

# 6 Visualization

## 6.1 DAME tracks

After detecting a set of DAMEs you want to look at them individually. We do this
with the function `dame_track`.

Depending on which object I used to obtain my DAMEs (tuple or SNP mode), I
choose which SummarizedExperiment to input in the field `ASM` (for tuple), or
`derASM` (for SNP). Either way, the SummarizedExperiment must have the columns
`group` and `samples` in the `colData` field:

```
#Here I will use the tuple-ASM SummExp
colData(ASMscore)$group <- grp
colData(ASMscore)$samples <- colnames(ASMscore)

#Set a DAME as a GRanges. I choose a one from the tables we obtained above
dame <- GRanges(19,IRanges(323736,324622))

dame_track(dame = dame,
           ASM = ASMscore)
```

```
## Using ASMtuple score
```

![](data:image/png;base64...)

Because we used the tuple-ASM object, we get by default two tracks: the ASM
score, and the marginal methylation (aka beta-value).

The shaded square delimits the DAME we defined to plot. We can look at the
flanking regions of the DAME by changing `window` or `positions`. With `window`
we specify the number of CpG positions we want to add to the plot up and
down-stream. With `positions` we specify the number of base pairs.

```
dame_track(dame = dame,
           ASM = ASMscore,
           window = 2)
```

```
## Using ASMtuple score
```

![](data:image/png;base64...)

If we use the SNP-ASM as input we get different tracks:

```
dame <- GRanges(19,IRanges(387966,387983))

grp <- factor(c(rep("CRC",4),rep("NORM",4)), levels = c("NORM", "CRC"))
colData(derASM)$group <- grp

dame_track(dame = dame,
           derASM = derASM)
```

```
## Using ASMsnp score
```

![](data:image/png;base64...)

Here we get three tracks: the SNP-ASM score, and the methylation levels for each
allele. Since the ASM score here depends on SNPs, we can see what SNPs are
involved in the ASM calculation at each CpG position:

```
dame_track(dame = dame,
           derASM = derASM,
           plotSNP = TRUE)
```

```
## Using ASMsnp score
```

![](data:image/png;base64...)

We see that the SNP located at `chr19:388,065` was the one used to split the
allele methylation.

If you put both SummarizedExperiments with a single DAME, you would get all the
tracks:

```
dame_track(dame = dame,
           derASM = derASM,
           ASM = ASMscore)
```

```
## Using both scores
```

![](data:image/png;base64...)

Notice that the first two tracks depend on the tuple-ASM, hence each point
represents the midpoint between a pair of CpG sites.

If you think plotting all the samples separately is difficult to see, you can
use the function `dame_track_mean` to summarize:

```
dame_track_mean(dame = dame,
           derASM = derASM,
           ASM = ASMscore)
```

```
## Using both scores
```

![](data:image/png;base64...)

As you can see, this region is not a very good DAME.

## 6.2 Methyl-circle plot

A typical way of visualizing ASM is to look at the reads overlapping a
particular SNP, and the methylation state of the CpG sites in those reads (black
circles for methylated and white for unmethylated, see Shoemaker et al. ([2010](#ref-shoemaker2010)) for
examples). Here we offer this option with the function `methyl_circle_plot()`.
As input it takes a `GRanges` with the SNP of interest, and the bam, VCF and
reference files as in the `extract_bams()` function.

```
#put SNP in GRanges (you can find the SNP with the dame_track function)
snp <- GRanges(19, IRanges(267039, width = 1)) #always set the width if your
#GRanges has 1 site

snp
```

```
## GRanges object with 1 range and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]       19    267039      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
bam.file <- system.file("extdata", "CRC1_chr19_trim.bam",
                        package = "DAMEfinder")

vcf.file <- system.file("extdata", "CRC1.chr19.trim.vcf",
                        package = "DAMEfinder")

methyl_circle_plot(snp = snp, vcfFile = vcf.file, bamFile = bam.file,
                   refFile = reference_file)
```

```
## Reading vcf file
```

```
## Getting reads
```

```
## Sorting reads
```

```
## Reading reference
```

```
## Getting meth state per read-pair
```

```
## Plotting
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the DAMEfinder package.
##   Please report the issue at
##   <https://github.com/markrobinsonuzh/DAMEfinder/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 1081 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

You can reduce the number of reads included with the option `sampleReads`, which
performs a random sampling of the number of reads to be shows per allele. The
number of reads can be specified with `numReads`.

If you are interested in a specific CpG site within this plot, you can include
an extra `GRanges` with its location, and the triangle at the bottom will point
to it:

```
cpgsite <- GRanges(19, IRanges(266998, width = 1))

methyl_circle_plot(snp = snp, vcfFile = vcf.file, bamFile = bam.file,
                   refFile = reference_file, cpgsite = cpgsite)
```

```
## Reading vcf file
```

```
## Getting reads
```

```
## Sorting reads
```

```
## Reading reference
```

```
## Getting meth state per read-pair
```

```
## Plotting
```

```
## Warning: Removed 1081 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

If you are instead interested in reads overlapping a CpG site, you can use
`methyl_circle_plotCpG()`, which is useful if you run the tuple-mode:

```
cpgsite <- GRanges(19, IRanges(266998, width = 1))

methyl_circle_plotCpG(cpgsite = cpgsite, bamFile = bam.file,
                      refFile = reference_file)
```

```
## Reading reference
```

```
## Getting meth state per read-pair
```

```
## Plotting
```

```
## Warning: Removed 230 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

You can also limit both the SNP plot and the CpG plot to a specific window of
interest (to zoom in or out), or if you want to look at the specific DAME
region:

```
#a random region
dame <- GRanges(19, IRanges(266998,267100))

methyl_circle_plot(snp = snp, vcfFile = vcf.file, bamFile = bam.file,
                   refFile = reference_file, dame = dame)
```

```
## Reading vcf file
```

```
## Getting reads
```

```
## Sorting reads
```

```
## Reading reference
```

```
## Getting meth state per read-pair
```

```
## Plotting
```

```
## Warning: Removed 61 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

## 6.3 MDS plot

To plot a multidimensional scaling plot (MDS), we provide a wrapper to
`plotMDS()` from `limma`, which adjusts the ASM score to calculate the euclidean
distances. The input is a SummarizedExperiment, and the vector of covariates
to color the points by:

```
grp <- factor(c(rep("CRC",3),rep("NORM",2)), levels = c("NORM", "CRC"))
methyl_MDS_plot(ASMscore, group = grp)
```

![](data:image/png;base64...)

# 7 Session Info

```
utils::sessionInfo()
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
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] SummarizedExperiment_1.40.0       Biobase_2.70.0
##  [9] GenomicRanges_1.62.0              Seqinfo_1.0.0
## [11] IRanges_2.44.0                    S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0               generics_0.1.4
## [15] MatrixGenerics_1.22.0             matrixStats_1.5.0
## [17] DAMEfinder_1.22.0                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             rlang_1.1.6
##  [4] magrittr_2.0.4           compiler_4.5.1           RSQLite_2.4.3
##  [7] GenomicFeatures_1.62.0   png_0.1-8                vctrs_0.6.5
## [10] reshape2_1.4.4           stringr_1.5.2            pkgconfig_2.0.3
## [13] crayon_1.5.3             fastmap_1.2.0            magick_2.9.0
## [16] labeling_0.4.3           utf8_1.2.6               Rsamtools_2.26.0
## [19] rmarkdown_2.30           tzdb_0.5.0               tinytex_0.57
## [22] bit_4.6.0                xfun_0.53                cachem_1.1.0
## [25] cigarillo_1.0.0          jsonlite_2.0.0           blob_1.2.4
## [28] DelayedArray_0.36.0      BiocParallel_1.44.0      parallel_4.5.1
## [31] R6_2.6.1                 VariantAnnotation_1.56.0 bslib_0.9.0
## [34] stringi_1.8.7            RColorBrewer_1.1-3       limma_3.66.0
## [37] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
## [40] iterators_1.0.14         knitr_1.50               readr_2.1.5
## [43] Matrix_1.7-4             tidyselect_1.2.1         dichromat_2.0-0.1
## [46] abind_1.4-8              yaml_2.3.10              codetools_0.2-20
## [49] curl_7.0.0               doRNG_1.8.6.2            lattice_0.22-7
## [52] tibble_3.3.0             plyr_1.8.9               withr_3.0.2
## [55] KEGGREST_1.50.0          S7_0.2.0                 evaluate_1.0.5
## [58] archive_1.1.12           pillar_1.11.1            BiocManager_1.30.26
## [61] rngtools_1.5.2           foreach_1.5.2            vroom_1.6.6
## [64] RCurl_1.98-1.17          hms_1.1.4                ggplot2_4.0.0
## [67] scales_1.4.0             bumphunter_1.52.0        glue_1.8.0
## [70] tools_4.5.1              locfit_1.5-9.12          GenomicAlignments_1.46.0
## [73] XML_3.99-0.19            cowplot_1.2.0            grid_4.5.1
## [76] AnnotationDbi_1.72.0     restfulr_0.0.16          cli_3.6.5
## [79] S4Arrays_1.10.0          dplyr_1.1.4              gtable_0.3.6
## [82] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
## [85] rjson_0.2.23             farver_2.1.2             memoise_2.0.1
## [88] htmltools_0.5.8.1        lifecycle_1.0.4          httr_1.4.7
## [91] statmod_1.5.1            bit64_4.6.0-1
```

# References

Cui, Hengmi, Patrick Onyango, Sheri Brandenburg, Yiqian Wu, Chih-Lin Hsieh, and Andrew P. Feinberg. 2002. “Loss of Imprinting in Colorectal Cancer Linked to Hypomethylation of H19 and IGF2.” *Cancer Research* 62 (22): 6442–6. <http://cancerres.aacrjournals.org/content/62/22/6442>.

Hanna, Courtney W., and Gavin Kelsey. 2017. “Genomic Imprinting Beyond DNA Methylation: A Role for Maternal Histones.” *Genome Biology* 18 (1): 177. <https://doi.org/10.1186/s13059-017-1317-9>.

Hickey, Peter. 2015. “Methtuple.” <https://github.com/PeteHaitch/methtuple>.

Hu, Bo, Yuan Ji, Yaomin Xu, and Angela H. Ting. 2013. “Screening for SNPs with Allele-Specific Methylation Based on Next-Generation Sequencing Data.” *Statistics in Biosciences* 5 (1): 179–97. <https://doi.org/10.1007/s12561-013-9086-9>.

Jaffe, Andrew E, Andrew P Feinberg, Hwajin Lee, Jeffrey T Leek, M Daniele Fallin, Peter Murakami, and Rafael A Irizarry. 2012. “Bump Hunting to Identify Differentially Methylated Regions in Epigenetic Epidemiology Studies.” *International Journal of Epidemiology* 41 (1): 200–209. <https://doi.org/10.1093/ije/dyr238>.

Kelsey, Gavin, and Robert Feil. 2013. “New Insights into Establishment and Maintenance of DNA Methylation Imprints in Mammals.” *Philosophical Transactions of the Royal Society of London B: Biological Sciences* 368 (1609). <https://doi.org/10.1098/rstb.2011.0336>.

Lun, Aaron T. L., and Gordon K. Smyth. 2014. “De Novo Detection of Differentially Bound Regions for ChIP-seq Data Using Peaks and Windows: Controlling Error Rates Correctly.” *Nucleic Acids Research* 42 (11): e95. <https://doi.org/10.1093/nar/gku351>.

Parker, Hannah R., Stephany Orjuela, Andreia Martinho Oliveira, Fabrizio Cereatti, Matthias Sauter, Henriette Heinrich, Giulia Tanzi, et al. 2018. “The Proto CpG Island Methylator Phenotype of Sessile Serrated Adenomas/Polyps.” *Epigenetics* 13 (10-11): 1088–1105. <https://doi.org/10.1080/15592294.2018.1543504>.

Shoemaker, Robert, Jie Deng, Wei Wang, and Kun Zhang. 2010. “Allele-Specific Methylation Is Prevalent and Is Contributed by CpG-SNPs in the Human Genome.” *Genome Research* 20 (7): 883–89. <https://doi.org/10.1101/gr.104695.109>.