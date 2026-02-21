# Documentation

Jianqiang Sun1

1Research Center for Agricultural Information Technology,
National Agriculture and Food Research Organization, Japan

#### Updated: 2025-05-09. Compiled: 2025-10-29

#### Abstract

CircSeqAlignTk is an end-to-end toolkit for the analysis of RNA-Seq data
derived from circular genome sequences, with a primary focus on viroids,
circular RNAs typically consisting of a few hundred nucleotides.
In addition to analysis capabilities, CircSeqAlignTk provides a streamlined
interface for generating synthetic RNA-Seq data that simulate real
datasets. This functionality enables developers to benchmark alignment
tools, test novel alignment algorithms, and validate new workflows.

#### Package

CircSeqAlignTk 1.12.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Preparation of working directory](#preparation-of-working-directory)
* [4 Quick start](#quick-start)
* [5 Implementation](#implementation)
  + [5.1 Two-stage alignment process](#two-stage-alignment-process)
  + [5.2 Generation of reference sequences](#generation-of-reference-sequences)
  + [5.3 Alignment](#alignment)
  + [5.4 Summarization and visualization of alignment results](#summarization-and-visualization-of-alignment-results)
* [6 Synthetic small RNA-Seq data](#synthetic-small-rna-seq-data)
  + [6.1 Generation of synthetic sequence reads](#generation-of-synthetic-sequence-reads)
  + [6.2 Examples of sequence read generation with additional paramaters](#examples-of-sequence-read-generation-with-additional-paramaters)
  + [6.3 Performance evaluation with the synthetic data](#performance-evaluation-with-the-synthetic-data)
* [7 Case studies](#case-studies)
  + [7.1 A simulation study to evaluate the performance of the workflow](#a-simulation-study-to-evaluate-the-performance-of-the-workflow)
  + [7.2 Analysis of small RNA-Seq data from vioid-infected tomato plants](#analysis-of-small-rna-seq-data-from-vioid-infected-tomato-plants)
* [8 GUI mode of CircSeqAlignTk](#gui-mode-of-circseqaligntk)
* [9 Session Information](#session-information)
* [References](#references)

# 1 Introduction

Viroids are small, single-stranded, circular non-coding RNAs, typically composed
of only a few hundred nucleotides (Hull [2014](#ref-Hull_2014); Flores et al. [2015](#ref-Flores_2015); Gago-Zachert [2016](#ref-Gago_2016)).
Lacking protein-coding ability, they hijack host plant enzymes for replication,
spreading systemically within the plant and transmitting to other individuals.
Because there are no effective treatments for viroid infections,
all infected plants must be destroyed, posing a serious threat to agriculture.
Moreover, each viroid species harbors many genetic variants,
which differ in virulence—ranging from asymptomatic
to causing severe stunting or even plant death.

Sequencing small RNAs from viroid-infected plants can help uncover the molecular
mechanisms of infection and ultimately inform prevention strategies.
A standard RNA-Seq approach involves aligning viroid-derived short reads
to the viroid RNA reference to quantify expression abundance.
However, since viroids are circular RNAs, alignment must account for reads
that span the artificial “ends” of linearized reference sequences.

*[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* is an R package that provides an end-to-end
solution for RNA-Seq data analysis of circular genomes,
especially for viroids (Sun, Fu, and Cao [2024](#ref-circseqaligntk)).
It includes both command-line and graphical interfaces,
covering steps from read alignment to visualization.
The toolkit is user-friendly and well-documented,
making it accessible to both beginners and experienced users.
Additionally, it features a simulation engine
that generates synthetic sequencing data resembling real RNA-Seq output,
enabling robust benchmarking of alignment tools, algorithm development,
and workflow testing.

# 2 Installation

To install the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package,
start R (≥ 4.2) and run the following steps:

```
if (!requireNamespace('BiocManager', quietly = TRUE))
    install.packages('BiocManager')

BiocManager::install('CircSeqAlignTk')
```

Note that to install the latest version of the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)*
package, the latest version of R is required.

# 3 Preparation of working directory

*[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* is designed for end-to-end RNA-Seq data analysis
of circular genome sequences, from alignment to visualization.
The whole processes will generate many files
including genome sequence indexes, and intermediate and final alignment results.
Thus, it is recommended to specify a working directory to save these files.
Here, for convenience in package development and validation,
we use a temporary folder
which is automatically arranged by the `tempdir()` function
as the working directory.

```
ws <- tempdir()
```

However, instead of using a temporary folder,
users can specify a folder on the desktop or elsewhere,
depending on the analysis project.
For example:

```
ws <- '/home/username/desktop/viroid_project'
```

# 4 Quick start

The typical workflow for analyzing RNA-Seq data from viroid-infected plants,
particularly small RNA sequencing, consists of the following steps:

1. filter reads to retain only those between 21 and 24 nucleotides in length,
   as viroid-derived small RNAs predominantly fall within this range
2. align the filtered reads to viroid genome sequences
3. visualize read coverage across the genome to identify regions associated
   with pathogenicity

This section demonstrates the complete workflow using a sample RNA-Seq dataset.
It covers the full analysis pipeline, from a FASTQ file to coverage visualization,
tailored for studying small RNAs derived from viroid-infected plant cells.

The FASTQ format file used in this section is included in the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)*
package and can be accessed using the `system.file()` function.
This file contains 29,178 sequence reads, randomly sampled from an original study
in which small RNA was sequenced from a tomato plant infected with
the potato spindle tuber viroid (PSTVd) isolate Cen-1 (FR851463) (Sun and Matsushita [2024](#ref-pstvtomato)).

```
fq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'srna.fq.gz')
```

The genome sequence of PSTVd isolate Cen-1 in FASTA format can be downloaded
from [GenBank](https://www.ncbi.nlm.nih.gov/nuccore/FR851463)
or [ENA](https://www.ebi.ac.uk/ena/browser/view/FR851463)
using the accession number FR851463.
It is also attached in the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package,
and can be obtained using the `system.file()` function.

```
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
```

To ensure alignment quality,
trimming adapter sequences from the sequence reads is required,
because most sequence reads in this FASTQ format file contain adapters
with sequence “AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC”.
Here, we use [AdapterRemoval](https://adapterremoval.readthedocs.io/en/stable/)
(Schubert, Lindgreen, and Orlando [2016](#ref-adapterremoval)) implemented in the *[Rbowtie2](https://bioconductor.org/packages/3.22/Rbowtie2)* package (Wei et al. [2018](#ref-rbowtie2))
to trim the adapters before aligning the sequence reads.
Note that the length of small RNAs derived from viroids
is known to be in the range of 21–24 nt.
Therefore, we set an argument to remove sequence reads with lengths
outside this range after adapter removal.

```
library(R.utils)
library(Rbowtie2)
adapter <- 'AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC'

# decompressed the gzip file for trimming to avoid errors from `remove_adapters`
gunzip(fq, destname = file.path(ws, 'srna.fq'), overwrite = TRUE, remove = FALSE)

trimmed_fq <- file.path(ws, 'srna_trimmed.fq')
params <- '--maxns 1 --trimqualities --minquality 30 --minlength 21 --maxlength 24'
remove_adapters(file1 = file.path(ws, 'srna.fq'),
                adapter1 = adapter,
                adapter2 = NULL,
                output1 = trimmed_fq,
                params,
                basename = file.path(ws, 'AdapterRemoval.log'),
                overwrite = TRUE)
```

After obtaining the cleaned FASTQ format file (i.e., `srna_trimmed.fq.gz`),
we build index files and perform alignment
using the `build_index()` and `align_reads()` functions
implemented in the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package.
To precisely align the reads to the circular genome sequence of the viroid,
the alignment is performed in [two stages](#two-stage-alignment-process).

```
ref_index <- build_index(input = genome_seq,
                         output = file.path(ws, 'index'))
aln <- align_reads(input = trimmed_fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'))
```

The index files are stored in a directory specified by the `output` argument
of the `build_index()` function.
The intermediate files (e.g., FASTQ format files used as inputs)
and alignment results (e.g., BAM format files) are stored in
the directory specified by the `output` argument of the `align_reads()` function.
BAM format files with the suffixes of `.clean.t1.bam` and `.clean.t2.bam` are
the final results obtained after alignment.
Refer to the sections
[5.2](#generation-of-reference-sequences) and [5.3](#alignment)
for a detailed description of each of the files generated by each function.

The alignment coverage can be summarized with the `calc_coverage()` function.
This function loads the alignment results
(i.e., `*.clean.t1.bam` and `*.clean.t2.bam`),
calculates alignment coverage from these BAM format files,
and combines them into two data frames according to the aligned strands.

```
alncov <- calc_coverage(aln)
head(slot(alncov, 'forward'))  # alignment coverage in forward strand
```

```
##      L21 L22 L23 L24
## [1,]  11  12   1   2
## [2,]  11  12   1   2
## [3,]  11  12   1   2
## [4,]  11  13   1   2
## [5,]  11  13   1   2
## [6,]  11  13   1   2
```

```
head(slot(alncov, 'reverse'))  # alignment coverage in reverse strand
```

```
##      L21 L22 L23 L24
## [1,]   7   5   0   1
## [2,]   7   5   0   1
## [3,]   7   5   0   1
## [4,]   7   5   0   1
## [5,]   7   5   0   1
## [6,]   7   5   0   1
```

The alignment coverage can be then visualized using the `plot()` function
(Figure [1](#fig:quickStartVisualization)).
The scale of the upper and lower directions indicate alignment coverage of
the forward and reverse strands, respectively.

```
plot(alncov)
```

![Alignment coverage. The alignment coverage of the case study.](data:image/png;base64...)

Figure 1: Alignment coverage
The alignment coverage of the case study.

# 5 Implementation

## 5.1 Two-stage alignment process

Circular genome sequences are generally represented as linear sequences in the
FASTA format during analysis.
Consequently, sequence reads obtained from organelles or organisms
with circular genome sequences can be aligned anywhere,
including at both ends of the sequence represented in the FASTA format.
Using existing alignment tools such as
[Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) (Langmead and Salzberg [2012](#ref-bowtie2)) and
[HISAT2](https://daehwankimlab.github.io/hisat2/) (Kim et al. [2019](#ref-hisat2)) to align such
sequence reads onto circular sequences may fail, because these tools are
designed to align sequence reads to linear genome sequences and their
implementation does not assume that a single read can be aligned to both ends
of a linear sequence.
To solve this problem, that is, allowing reads to be aligned to both ends,
the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package implements a two-stage
alignment process (Figure [2](#fig:packageImplementation)),
using these existing alignment tools
(i.e., [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
and [HISAT2](https://daehwankimlab.github.io/hisat2/)).

![Two-stage alignment process. Overview of the two-stage alignment process and the related functions in the CircSeqAlignTk package](data:image/png;base64...)

Figure 2: Two-stage alignment process
Overview of the two-stage alignment process and the related functions in the CircSeqAlignTk package

To prepare for the two-stage alignment process, two types of reference
sequences are generated from the same circular genome sequence.
The type 1 reference sequence is a linear sequence generated
by cutting a circular sequence at an arbitrary location.
The type 2 reference is generated
by restoring the type 1 reference sequence into a circular sequence and
cutting the circle at the opposite position to type 1 reference sequence.
The type 1 reference sequence is the input genome sequence itself,
while the type 2 reference sequence is newly created
by the `build_index()` function.

Once the two reference sequences are generated,
the sequence reads are aligned to the two types of reference sequences
in two stages:
(i) aligning all sequence reads onto the type 1 reference sequences,
and (ii) collecting the unaligned sequence reads
and aligning them to the type 2 reference.
Alignment can be performed with
[Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) or
[HISAT2](https://daehwankimlab.github.io/hisat2/) depending on the options
specified by the user.

## 5.2 Generation of reference sequences

The `build_index()` function is designed
to generate type 1 and type 2 reference sequences for alignment.
This function has two required arguments,
`input` and `output` which are used for
specifying a file path to a genome sequence in FASTA format and
a directory path to save the generated type 1 and type 2 reference sequences,
respectively.
The type 1 and type 2 reference sequences are saved in files
`refseq.t1.fa` and `refseq.t2.fa` in FASTA format, respectively.

Following the generation of reference sequences,
The `build_index()` function then creates index files
for each reference sequence for alignment.
The index files are saved with the prefix `refseq.t1.*` and `refseq.t2.*`.
They correspond to the type 1 and 2 reference sequences
(i.e., `refseq.t1.fa` and `refseq.t2.fa`), respectively.
The extension of index files depends on the alignment tool.

Two alignment tools
([Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) and
[HISAT2](https://daehwankimlab.github.io/hisat2/)) can be specified for
creating index files through the `aligner` argument.
If [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
is specified, then the extension is `.bt2` or `.bt2l`;
if [HISAT2](https://daehwankimlab.github.io/hisat2/) is specified,
then the extension is `.ht2` or `.ht2l`.
By default, [HISAT2](https://daehwankimlab.github.io/hisat2/) is used.

The `build_index()` function first attempts to call the specified alignment tool
directly installed on the operation system; however, if the tool is not
installed, the function will then attempt to call the `bowtie2_build()` or
`hisat2_build()` functions implemented in *[Rbowtie2](https://bioconductor.org/packages/3.22/Rbowtie2)*
or *[Rhisat2](https://bioconductor.org/packages/3.22/Rhisat2)* packages for indexing.

For example, to generate reference sequences and index files for alignment
against the viroid PSTVd isolate Cen-1 (FR851463) using
[HISAT2](https://daehwankimlab.github.io/hisat2/),
we set the argument `input` to the FASTA format file containing the sequence
of FR851463 and execute the `build_index()` function.
The generated index files will be saved into the folder
specified by the argument `output`.

```
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq, output = file.path(ws, 'index'))
```

The function returns a `CircSeqAlignTkRefIndex` class object that contains the
file path to type 1 and 2 reference sequences and corresponding index files.
The data structure of `CircSeqAlignTkRefIndex` can be verified using the
`str()` function.

```
str(ref_index)
```

```
## Formal class 'CircSeqAlignTkRefIndex' [package "CircSeqAlignTk"] with 6 slots
##   ..@ name   : chr "FR851463"
##   ..@ seq    : chr "CGGAACTAAACTCGTGGTTCCTGTGGTTCACACCTGACCTCCTGAGCAGGAAAGAAAAAAGAATTGCGGCTCGGAGGAGCGCTTCAGGGATCCCCGGGGAAACCTGGAGCG"| __truncated__
##   ..@ length : int 361
##   ..@ fasta  : chr [1:2] "/tmp/RtmpUEQ8JX/index/refseq.t1.fa" "/tmp/RtmpUEQ8JX/index/refseq.t2.fa"
##   ..@ index  : chr [1:2] "/tmp/RtmpUEQ8JX/index/refseq.t1" "/tmp/RtmpUEQ8JX/index/refseq.t2"
##   ..@ cut_loc: num 180
```

The file path to type 1 and type 2 reference sequences, `refseq.type1.fa` and
`refseq.type2.fa`, can be checked through the `fasta` slot
using the `slot()` function.

```
slot(ref_index, 'fasta')
```

```
## [1] "/tmp/RtmpUEQ8JX/index/refseq.t1.fa" "/tmp/RtmpUEQ8JX/index/refseq.t2.fa"
```

The file path (prefix) to the index files, `refseq.t1.*.bt2` and
`refseq.t2.*.bt2`, can be checked through `index` slot.

```
slot(ref_index, 'index')
```

```
## [1] "/tmp/RtmpUEQ8JX/index/refseq.t1" "/tmp/RtmpUEQ8JX/index/refseq.t2"
```

Note that, users can simply use the `@` operator to access these slot contents
instead of using the `slot()` function. For example,

```
ref_index@fasta
ref_index@index
```

As mentioned previously,
the type 2 reference is generated
by restoring the type 1 reference sequence to a circular sequence
and cutting the circular sequence at the opposite position of type 1.
The cutting position based on the type 1 reference
sequence coordinate can be checked from the `@cut_loc` slot.

```
slot(ref_index, 'cut_loc')
```

```
## [1] 180
```

By default, [HISAT2](https://daehwankimlab.github.io/hisat2/)/*[Rhisat2](https://bioconductor.org/packages/3.22/Rhisat2)*
is used for indexing.
This can be changed to
[Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)/*[Rbowtie2](https://bioconductor.org/packages/3.22/Rbowtie2)*
using the `aligner` argument, for example:

```
ref_bt2index <- build_index(input = genome_seq,
                            output = file.path(ws, 'bt2index'),
                            aligner = 'bowtie2')
```

## 5.3 Alignment

The `align_reads()` function is used to align sequence reads onto a circular
genome sequence.
This function requires three arguments: `input`, `index`, and `output`,
which are used to specify a file path to RNA-Seq reads in FASTQ format,
a `CircSeqAlignTkRefIndex` class object generated by the `build_index()` function,
and a directory path to save the intermediate and final results, respectively.

This function aligns sequence reads within
the [two-stage alignment process](#two-stage-alignment-process) described above.
Thus, it (i) aligns reads to the type 1 reference sequence (i.e., `refseq.t1.fa`)
and (ii) collects the unaligned reads and aligns
them with the type 2 reference sequence (i.e., `refseq.t2.fa`).

By default, [HISAT2](https://daehwankimlab.github.io/hisat2/)
is used, and it can be changed with the `alinger` argument.
Similar to the `build_index()` function,
the `align_reads()` function first attempts to call the specified alignment tool
directly installed on the operation system;
however, if the tool is not installed,
the function then attempts to call alignment functions implemented in
*[Rbowtie2](https://bioconductor.org/packages/3.22/Rbowtie2)* or *[Rhisat2](https://bioconductor.org/packages/3.22/Rhisat2)* packages.

The following example is aligning RNA-Seq reads in FASTQ format (`fq`)
on the reference index (`ref_index`) of PSTVd isolate Cen-1 (FR851463) which was generated
at the section [5.2](#generation-of-reference-sequences).
The alignment results will be stored into the folder specified
by the argument `output`.

```
fq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'srna.fq.gz')
# trimming the adapter sequences if needed before alignment, omitted here.

aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'))
```

This function returns a `CircSeqAlignTkAlign` class object containing the
path to the intermediate files and final alignment results.

```
str(aln)
```

```
## Formal class 'CircSeqAlignTkAlign' [package "CircSeqAlignTk"] with 6 slots
##   ..@ input_fastq: chr "/tmp/RtmpbaaCcb/Rinst3a7b241e3a1183/CircSeqAlignTk/extdata/srna.fq.gz"
##   ..@ fastq      : chr [1:2] "/tmp/RtmpbaaCcb/Rinst3a7b241e3a1183/CircSeqAlignTk/extdata/srna.fq.gz" "/tmp/RtmpUEQ8JX/align_results/srna.t2.fq.gz"
##   ..@ bam        : chr [1:2] "/tmp/RtmpUEQ8JX/align_results/srna.t1.bam" "/tmp/RtmpUEQ8JX/align_results/srna.t2.bam"
##   ..@ clean_bam  : chr [1:2] "/tmp/RtmpUEQ8JX/align_results/srna.clean.t1.bam" "/tmp/RtmpUEQ8JX/align_results/srna.clean.t2.bam"
##   ..@ stats      :'data.frame':  4 obs. of  5 variables:
##   .. ..$ n_reads       : num [1:4] 29178 29007 171 29
##   .. ..$ aligned_fwd   : num [1:4] 93 20 93 20
##   .. ..$ aligned_rev   : num [1:4] 78 9 78 9
##   .. ..$ unaligned     : num [1:4] 29007 28978 0 0
##   .. ..$ unsorted_reads: num [1:4] 0 0 0 0
##   ..@ reference  :Formal class 'CircSeqAlignTkRefIndex' [package "CircSeqAlignTk"] with 6 slots
##   .. .. ..@ name   : chr "FR851463"
##   .. .. ..@ seq    : chr "CGGAACTAAACTCGTGGTTCCTGTGGTTCACACCTGACCTCCTGAGCAGGAAAGAAAAAAGAATTGCGGCTCGGAGGAGCGCTTCAGGGATCCCCGGGGAAACCTGGAGCG"| __truncated__
##   .. .. ..@ length : int 361
##   .. .. ..@ fasta  : chr [1:2] "/tmp/RtmpUEQ8JX/index/refseq.t1.fa" "/tmp/RtmpUEQ8JX/index/refseq.t2.fa"
##   .. .. ..@ index  : chr [1:2] "/tmp/RtmpUEQ8JX/index/refseq.t1" "/tmp/RtmpUEQ8JX/index/refseq.t2"
##   .. .. ..@ cut_loc: num 180
```

The alignment results are saved as BAM format files
in the specified directory with the suffixes of `*.t1.bam` and `*.t2.bam`.
The original alignment results may contain mismatches.
Hence, this function performs filtering
to remove alignment with the mismatches over the specified value
from the BAM format file.
Filtering results for `*.t1.bam` and `*.t2.bam`
are saved as `*.clean.t1.bam` and `*.clean.t2.bam`, respectively.
The path to the original and filtered BAM format files
can be checked using `@bam` and `@clean_bam` slots, respectively.

```
slot(aln, 'bam')
```

```
## [1] "/tmp/RtmpUEQ8JX/align_results/srna.t1.bam"
## [2] "/tmp/RtmpUEQ8JX/align_results/srna.t2.bam"
```

```
slot(aln, 'clean_bam')
```

```
## [1] "/tmp/RtmpUEQ8JX/align_results/srna.clean.t1.bam"
## [2] "/tmp/RtmpUEQ8JX/align_results/srna.clean.t2.bam"
```

The alignment statistics (for example, number of input sequence reads,
number of aligned reads) can be checked using the `@stats` slot.

```
slot(aln, 'stats')
```

```
##                   n_reads aligned_fwd aligned_rev unaligned unsorted_reads
## srna.t1.bam         29178          93          78     29007              0
## srna.t2.bam         29007          20           9     28978              0
## srna.clean.t1.bam     171          93          78         0              0
## srna.clean.t2.bam      29          20           9         0              0
```

By default, the `align_read()` function allows a single mismatch in the alignment
of each read (i.e., `n_mismatch = 1`).
To forbid a mismatch or allow more mismatches,
assign `0` or a large number to the `n_mismatch` argument.

```
aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_mismatch = 0)
```

The number of threads for alignment
can be specified using the `n_threads` argument.
Setting a large number of threads
(but not exceeding the computer limits)
can accelerate the speed of alignment.

```
aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_threads = 4)
```

Additional arguments to be directly passed on to the alignment tool can be
specified with the `add_args` argument.
For example, to disable spliced alignment for HISAT2, we set `--no-spliced-alignment`
for HISAT alinger as follows.

```
aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   add_args = '--no-spliced-alignment')
```

For additional parameters available with HISAT2, refer to the [HISAT2 Online Manual](https://daehwankimlab.github.io/hisat2/manual/).

Alternatively, user can use [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
for alignment by setting the `aligner` argument to `"bowtie2"`.
Similar to HISAT2, user can specify additional alignment parameters
using the appropriate arguments. For a full list of Bowtie2 options,
refer to the [Bowtie2 Online Manual](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#command-line).

```
aln <- align_reads(input = fq,
                   index = ref_bt2index ,
                   output = file.path(ws, 'align_results'),
                   aligner = 'bowtie2',
                   add_args = '-L 20 -N 1')
```

## 5.4 Summarization and visualization of alignment results

Summarization and visualization of the alignment results can be performed with
the `calc_coverage()` and `plot()` functions, respectively.
The `calc_coverage()` function calculates alignment coverage
from the two BAM files, `*.clean.t1.bam` and `*.clean.t2.bam`,
generated by the `align_reads()` function.

```
alncov <- calc_coverage(aln)
```

This function returns a `CircSeqAlignTkCoverage` class object.
Alignment coverage of the reads aligned in the forward and reverse strands
are stored in the `@forward` and `@reverse` slots, respectively,
as a data frame.

```
head(slot(alncov, 'forward'))
```

```
##      L21 L22 L23 L24
## [1,]  10   8   1   1
## [2,]  10   8   1   1
## [3,]  10   8   1   1
## [4,]  10   9   1   1
## [5,]  10   9   1   1
## [6,]  10   9   1   1
```

```
head(slot(alncov, 'reverse'))
```

```
##      L21 L22 L23 L24
## [1,]   5   4   0   0
## [2,]   5   4   0   0
## [3,]   5   4   0   0
## [4,]   5   4   0   0
## [5,]   5   4   0   0
## [6,]   5   4   0   0
```

Coverage can be visualized with an area chart using the `plot()` function.
In the chart, the upper and lower directions of the y-axis
represent the alignment coverage of reads with forward and reverse strands,
respectively.

```
plot(alncov)
```

![Alignment coverage.](data:image/png;base64...)

Figure 3: Alignment coverage

To plot alignment coverage of the reads with a specific length,
assign the targeted length to the `read_lengths` argument.

```
plot(alncov, read_lengths = c(21, 22))
```

![Alignment coverage of reads with the specific lengths.](data:image/png;base64...)

Figure 4: Alignment coverage of reads with the specific lengths

As the `plot()` function returns a ggplot2 class object,
we can use additional functions
implemented in the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* package (Wickham [2016](#ref-ggplot2))
to decorate the chart, for example:

```
library(ggplot2)
plot(alncov) + facet_grid(strand ~ read_length, scales = 'free_y')
```

![Alignment coverage arranged with ggplot2.](data:image/png;base64...)

Figure 5: Alignment coverage arranged with ggplot2

```
plot(alncov) + coord_polar()
```

![Alignment coverage represented in polar coordinate system.](data:image/png;base64...)

Figure 6: Alignment coverage represented in polar coordinate system

# 6 Synthetic small RNA-Seq data

## 6.1 Generation of synthetic sequence reads

The *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package implements the `generate_fastq()`
function to generate synthetic sequence reads in FASTQ format
to simulate RNA-Seq data sequenced from organelles or organisms
with circular genome sequences.
This function is intended for the use of developers,
to help them evaluate the performance of alignment tools,
new alignment algorithms, and new workflows.

To generate synthetic sequence reads with default parameters
and save them into a file named `synthetic_reads.fq.gz`
in GZIP-compressed FASTQ format,
run the following command.
By default, it generates 10,000 reads.

```
sim <- generate_reads(output = file.path(ws, 'synthetic_reads.fq.gz'))
```

This function returns a `CircSeqAlignTkSim` class object whose
data structure can be checked with the `str()` function, as follows:

```
str(sim)
```

```
## Formal class 'CircSeqAlignTkSim' [package "CircSeqAlignTk"] with 6 slots
##   ..@ seq      : chr "CGGAACTAAACTCGTGGTTCCTGTGGTTCACACCTGACCTCCTGAGCAGGAAAGAAAAAAGAATTGCGGCTCGGAGGAGCGCTTCAGGGATCCCCGGGGAAACCTGGAGCG"| __truncated__
##   ..@ adapter  : chr "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC"
##   ..@ read_info:'data.frame':    10000 obs. of  8 variables:
##   .. ..$ mean  : num [1:10000] 341 74 227 65 341 239 341 239 239 341 ...
##   .. ..$ std   : num [1:10000] 4 4 4 4 4 3 4 3 3 4 ...
##   .. ..$ strand: chr [1:10000] "+" "+" "+" "+" ...
##   .. ..$ prob  : num [1:10000] 0.108 0.195 0.11 0.15 0.108 ...
##   .. ..$ start : num [1:10000] 703 436 589 422 701 602 699 598 598 701 ...
##   .. ..$ end   : num [1:10000] 726 458 609 443 724 625 722 621 621 722 ...
##   .. ..$ sRNA  : chr [1:10000] "TGGAACCGCAGTTGGTTCCTCGGA" "AGGAGCGCTTCAGGGATCCCCGG" "CCCTCGCCCCCTTTGCGCTGT" "GAATTGCGGCTCGGAGGAGCGC" ...
##   .. ..$ length: num [1:10000] 24 23 21 22 24 24 24 24 24 22 ...
##   ..@ peak     :'data.frame':    8 obs. of  4 variables:
##   .. ..$ mean  : num [1:8] 74 324 341 239 227 23 75 65
##   .. ..$ std   : num [1:8] 4 3 4 3 4 5 3 4
##   .. ..$ strand: chr [1:8] "+" "+" "+" "+" ...
##   .. ..$ prob  : num [1:8] 0.1947 0.0762 0.1079 0.1342 0.1105 ...
##   ..@ coverage :Formal class 'CircSeqAlignTkCoverage' [package "CircSeqAlignTk"] with 3 slots
##   .. .. ..@ forward : num [1:361, 1:4] 56 30 10 3 0 0 0 0 0 0 ...
##   .. .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. .. ..$ : NULL
##   .. .. .. .. ..$ : chr [1:4] "L21" "L22" "L23" "L24"
##   .. .. ..@ reverse : num [1:361, 1:4] 0 0 0 0 0 0 0 0 0 0 ...
##   .. .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. .. ..$ : NULL
##   .. .. .. .. ..$ : chr [1:4] "L21" "L22" "L23" "L24"
##   .. .. ..@ .figdata:'data.frame':   2888 obs. of  4 variables:
##   .. .. .. ..$ position   : int [1:2888] 1 2 3 4 5 6 7 8 9 10 ...
##   .. .. .. ..$ read_length: Factor w/ 4 levels "21","22","23",..: 1 1 1 1 1 1 1 1 1 1 ...
##   .. .. .. ..$ coverage   : num [1:2888] 56 30 10 3 0 0 0 0 0 0 ...
##   .. .. .. ..$ strand     : chr [1:2888] "+" "+" "+" "+" ...
##   ..@ fastq    : chr "/tmp/RtmpUEQ8JX/synthetic_reads.fq.gz"
```

The parameters for generating the peaks of alignment coverage
can be checked using `@peak` slot.

```
head(slot(sim, 'peak'))
```

```
##   mean std strand       prob
## 1   74   4      + 0.19467997
## 2  324   3      + 0.07618699
## 3  341   4      + 0.10791345
## 4  239   3      + 0.13421258
## 5  227   4      + 0.11047903
## 6   23   5      + 0.04168474
```

The parameters for sequence-read sampling
can be checked using the `@read_info` slot.
The first four columns (i.e., `mean`, `std`, `strand`, and `prob`)
represent peak information used for sampling sequence reads;
the next two columns (i.e., `start` and `end`) are
the exact start and end position of the sampled sequence reads, respectively;
and the last two columns (i.e., `sRNA` and `length`) are
the nucleotides and length of the sampled sequence reads.

```
dim(slot(sim, 'read_info'))
```

```
## [1] 10000     8
```

```
head(slot(sim, 'read_info'))
```

```
##   mean std strand      prob start end                     sRNA length
## 1  341   4      + 0.1079135   703 726 TGGAACCGCAGTTGGTTCCTCGGA     24
## 2   74   4      + 0.1946800   436 458  AGGAGCGCTTCAGGGATCCCCGG     23
## 3  227   4      + 0.1104790   589 609    CCCTCGCCCCCTTTGCGCTGT     21
## 4   65   4      + 0.1496360   422 443   GAATTGCGGCTCGGAGGAGCGC     22
## 5  341   4      + 0.1079135   701 724 CTTGGAACCGCAGTTGGTTCCTCG     24
## 6  239   3      + 0.1342126   602 625 TGCGCTGTCGCTTCGGCTACTACC     24
```

The alignment coverage of the synthetic sequence reads
are stored in the `@coverage` slot as a `CircSeqAlignTkCoverage` class object.
This can be visualized using the `plot()` function.

```
alncov <- slot(sim, 'coverage')
head(slot(alncov, 'forward'))
```

```
##      L21 L22 L23 L24
## [1,]  56 125 212 446
## [2,]  30  88 166 376
## [3,]  10  43 116 291
## [4,]   3  14  63 206
## [5,]   0   1  28 122
## [6,]   0   0   6  44
```

```
head(slot(alncov, 'reverse'))
```

```
##      L21 L22 L23 L24
## [1,]   0   0   0   0
## [2,]   0   0   0   0
## [3,]   0   0   0   0
## [4,]   0   0   0   0
## [5,]   0   0   0   0
## [6,]   0   0   0   0
```

```
plot(alncov)
```

![Alignment coverage of the synthetic data.](data:image/png;base64...)

Figure 7: Alignment coverage of the synthetic data

## 6.2 Examples of sequence read generation with additional paramaters

To change the number of sequence reads that need to be generated,
use the `n` argument in the `generate_reads()` function.

```
sim <- generate_reads(n = 1e3, output = file.path(ws, 'synthetic_reads.fq.gz'))
```

By default, the `generate_reads()` function generates sequence reads from the
genome sequence of the viroid PSTVd isolate Cen-1
([FR851463](https://www.ebi.ac.uk/ena/browser/view/FR851463)).
To change the seed genome sequence for sequence read sampling,
users can specify a sequence as characters or as a file path to the FASTA
format file containing a sequence using the `seq` argument.

```
genome_seq <- 'CGGAACTAAACTCGTGGTTCCTGTGGTTCACACCTGACCTCCTGACAAGAAAAGAAAAAAGAAGGCGGCTCGGAGGAGCGCTTCAGGGATCCCCGGGGAAACCTGGAGCGAACTGGCAAAAAAGGACGGTGGGGAGTGCCCAGCGGCCGACAGGAGTAATTCCCGCCGAAACAGGGTTTTCACCCTTCCTTTCTTCGGGTGTCCTTCCTCGCGCCCGCAGGACCACCCCTCGCCCCCTTTGCGCTGTCGCTTCGGCTACTACCCGGTGGAAACAACTGAAGCTCCCGAGAACCGCTTTTTCTCTATCTTACTTGCTCCGGGGCGAGGGTGTTTAGCCCTTGGAACCGCAGTTGGTTCCT'

sim <- generate_reads(seq = genome_seq,
                      output = file.path(ws, 'synthetic_reads.fq.gz'))
```

By default, `generate_reads()` function generates sequence reads
with the adapter sequence “AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC”.
To change the adapter sequence, specify a sequence as characters
or as a file path to a FASTA format file containing a adapter sequence
using the `adapter` argument.
For example, the following scripts generate reads with 150 nt,
containing the adapter sequence “AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA”.

```
adapter <- 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
sim <- generate_reads(adapter = adapter,
                      output = file.path(ws, 'synthetic_reads.fq.gz'),
                      read_length = 150)
```

In contrast, to generate sequence reads without adapter sequences,
run the `generate_reads()` function with `adapter = NA`.

```
sim <- generate_reads(adapter = NA,
                      output = file.path(ws, 'synthetic_reads.fq.gz'),
                      read_length = 150)
```

The `generate_reads()` function also implements a process that introduces several
mismatches into the reads after sequence-read sampling.
To introduce a single mismatch for each sequence read
with a probability of 0.05,
set the `mismatch_prob` argument to `0.05`.

```
sim <- generate_reads(output = file.path(ws, 'synthetic_reads.fq.gz'),
                      mismatch_prob = 0.05)
```

To allow a single sequence read to have multiple mismatches,
assign multiple values to the `mismatch_prob` argument.
For example, using the following scripts,
the function first generates 10,000 reads.
Then, introduce the first mismatches against all sequence reads
with the probability of 0.05.
This will generate approximately 500 (i.e., 10,000 x 0.05) sequence reads
containing a mismatch.
Next, the function introduces a second mismatch against the sequence reads
with a single mismatch with the probability of 0.1.
Thus, this will generate approximately 50 (i.e., 500 x 0.1) sequence reads
containing two mismatches.

```
sim <- generate_reads(output = file.path(ws, 'synthetic_reads.fq.gz'),
                      mismatch_prob = c(0.05, 0.1))
```

In addition, the `generate_reads()` provide some groundbreaking arguments,
`srna_length` and `peaks`,
to specify the length and strand of sequence reads
and the positions of peaks of the alignment coverage, respectively.
Using these arguments allows users to generate synthetic sequence reads
that are very close to the real small RNA-Seq data
sequenced from viroid-infected plants.
The following is an example of how to use these arguments:

```
peaks <- data.frame(
    mean   = c(   0,   25,   70,   90,  150,  240,  260,  270,  330,  350),
    std    = c(   5,    5,    5,    5,   10,    5,    5,    1,    2,    1),
    strand = c( '+',  '+',  '-',  '-',  '+',  '+',  '-',  '+',  '+',  '-'),
    prob   = c(0.10, 0.10, 0.18, 0.05, 0.03, 0.18, 0.15, 0.10, 0.06, 0.05)
)
srna_length <- data.frame(
    length = c(  21,   22,   23,   24),
    prob   = c(0.45, 0.40, 0.10, 0.05)
)

sim <- generate_reads(n = 1e4,
                      output = file.path(ws, 'synthetic_reads.fq.gz'),
                      srna_length = srna_length,
                      peaks = peaks)
```

```
plot(slot(sim, 'coverage'))
```

![Alignment coverage of the synthetic data.](data:image/png;base64...)

Figure 8: Alignment coverage of the synthetic data

In the synthetic data generated by the `generate_reads()` function,
every peak contains a relatively equal proportion of sequence reads
with different sequence read lengths (Figure [8](#fig:simSetLengthAndPeaks)).
However, in real data, composition of the reads differs from peak to peak.
The *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package provides a `merge` function
to generate such synthetic data.
This feature can be used,
to first generate multiple synthetic data with various features
with the `generate_reads()` function
and then merge these synthetic data with the `merge()` function.

```
peaks_1 <- data.frame(
    mean   = c( 100,  150,  250,  300),
    std    = c(   5,    5,    5,    5),
    strand = c( '+',  '+',  '-',  '-'),
    prob   = c(0.25, 0.25, 0.40, 0.05)
)
srna_length_1 <- data.frame(
    length = c(  21,   22),
    prob   = c(0.45, 0.65)
)
sim_1 <- generate_reads(n = 1e4,
                        output = file.path(ws, 'synthetic_reads_1.fq.gz'),
                        srna_length = srna_length_1,
                        peaks = peaks_1)

peaks_2 <- data.frame(
    mean   = c(  50,  200,  300),
    std    = c(   5,    5,    5),
    strand = c( '+',  '-',  '+'),
    prob   = c(0.80, 0.10, 0.10)
)
srna_length_2 <- data.frame(
    length = c(  21,   22,   23),
    prob   = c(0.10, 0.10, 0.80)
)
sim_2 <- generate_reads(n = 1e3,
                        output = file.path(ws, 'synthetic_reads_2.fq.gz'),
                        srna_length = srna_length_2,
                        peaks = peaks_2)

peaks_3 <- data.frame(
    mean   = c(   80,  100,  220,  270),
    std    = c(    5,    5,    1,    2),
    strand = c(  '-',  '+',  '+',  '-'),
    prob   = c( 0.20, 0.30, 0.20, 0.30)
)
srna_length_3 <- data.frame(
    length = c(  19,   20,   21,   22),
    prob   = c(0.30, 0.30, 0.20, 0.20)
)
sim_3 <- generate_reads(n = 5e3,
                        output = file.path(ws, 'synthetic_reads_3.fq.gz'),
                        srna_length = srna_length_3,
                        peaks = peaks_3)

# merge the three data sets
sim <- merge(sim_1, sim_2, sim_3,
             output = file.path(ws, 'synthetic_reads.fq.gz'))
```

```
plot(slot(sim, 'coverage'))
```

![Alignment coverage of the synthetic data.](data:image/png;base64...)

Figure 9: Alignment coverage of the synthetic data

From Figure [9](#fig:simMergeMultiSimObjects),
it can be seen that the lengths of the sequence reads
that constitute the peaks vary from peak to peak.
For example, the first peak of the forward strand is mainly composed of
sequence reads with a length of 23 nt,
and the third peak of the forward strand is mainly composed of sequence reads
with lengths of 21 nt and 22 nt.

## 6.3 Performance evaluation with the synthetic data

Here we show how to use the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package
to evaluate the performance of the workflow,
from aligning sequence reads to calculating alignment coverage,
as shown in the [Quick Start](#quick-start) section.
First, to validate that the workflow is working correctly,
we generate sequence reads without adapter sequences and mismatches
using the `generate_reads()` function and apply the workflow to
these synthetic reads.

```
sim <- generate_reads(adapter = NA,
                      mismatch_prob = 0,
                      output = file.path(ws, 'synthetic_reads.fq.gz'))

genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq,
                         output = file.path(ws, 'index'))
aln <- align_reads(input = file.path(ws, 'synthetic_reads.fq.gz'),
                   index = ref_index,
                   output = file.path(ws, 'align_results'))
alncov <- calc_coverage(aln)
```

The true alignment coverage of this synthetic data is stored in the `@coverage`
slot of the `sim` variable,
whereas the predicted alignment coverage is stored in the `alncov` variable.
Here, we can calculate the root mean squared error (RMSE)
between the true and predicted values for validation.

```
# coverage of reads in forward strand
fwd_pred <- slot(alncov, 'forward')
fwd_true <- slot(slot(sim, 'coverage'), 'forward')
sqrt(sum((fwd_pred - fwd_true) ^ 2) / length(fwd_true))
```

```
## [1] 0
```

```
# coverage of reads in reverse strand
rev_pred <- slot(alncov, 'reverse')
rev_true <- slot(slot(sim, 'coverage'), 'reverse')
sqrt(sum((rev_pred - rev_true) ^ 2) / length(rev_true))
```

```
## [1] 1.34597
```

We observed only a small discrepancy between the true and predicted alignment coverage
when the simulated dataset does not contain adapter sequences and mismatches.

Next, we evaluate the performance of this workflow under conditions similar to
those of real RNA-Seq data by concatenating adapter sequences and introducing
mismatches into the reads.
We first generate synthetic sequence reads with a
length of 150 nt that contain at most two mismatches and
have adapter sequences.

```
sim <- generate_reads(mismatch_prob = c(0.1, 0.2),
                      output = file.path(ws, 'synthetic_reads.fq'))
```

Next, we follow the [Quick Start](#quick-start) chapter
to trim the adapter sequences, perform alignment,
and calculate the alignment coverage.

```
library(R.utils)
library(Rbowtie2)

# quality control
params <- '--maxns 1 --trimqualities --minquality 30 --minlength 21 --maxlength 24'
remove_adapters(file1 = file.path(ws, 'synthetic_reads.fq'),
                adapter1 = slot(sim, 'adapter'),
                adapter2 = NULL,
                output1 = file.path(ws, 'srna_trimmed.fq'),
                params,
                basename = file.path(ws, 'AdapterRemoval.log'),
                overwrite = TRUE)

# alignment
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq,
                         output = file.path(ws, 'index'))
aln <- align_reads(input = file.path(ws, 'srna_trimmed.fq'),
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_mismatch = 2)

# calculate alignment coverage
alncov <- calc_coverage(aln)
```

We then calculate the RMSE between the true and the predicted values of the
alignment coverage.

```
# coverage of reads in forward strand
fwd_pred <- slot(alncov, 'forward')
fwd_true <- slot(slot(sim, 'coverage'), 'forward')
sqrt(sum((fwd_pred - fwd_true) ^ 2) / length(fwd_true))
```

```
## [1] 14.25471
```

```
# coverage of reads in reverse strand
rev_pred <- slot(alncov, 'reverse')
rev_true <- slot(slot(sim, 'coverage'), 'reverse')
sqrt(sum((rev_pred - rev_true) ^ 2) / length(rev_true))
```

```
## [1] 29.16496
```

When sequence reads contained adapter sequences and mismatches,
some reads failed to align.
As a result, the coverage derived from the alignment output (`aln`) showed
slightly larger deviations from the true alignment coverage (`slot(sim, 'coverage')`).

# 7 Case studies

## 7.1 A simulation study to evaluate the performance of the workflow

Synthetic sequence reads for various scenarios can be generated by repeating
the `generate_reads()` function.
These synthetic sequence reads can be used to evaluate the workflow,
from aligning reads to calculating alignment coverage as shown in the
[Quick Start](#quick-start) chapter, more reliably.
Given below is an example for generating 10 sets of synthetic sequence reads,
performing alignment,
and calculating alignment coverage for performance evaluation.
Note that two mismatches are introduced here with probabilities
of 0.1 and 0.2, respectively;
and adapter sequences are added until the length of the reads reaches 150 nt.

```
library(R.utils)
library(Rbowtie2)

params <- '--maxns 1 --trimqualities --minquality 30 --minlength 21 --maxlength 24'
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq,
                         output = file.path(ws, 'index'))

fwd_rmse <- rev_rmse <- rep(NA, 10)

for (i in seq(fwd_rmse)) {
    # prepare file names and directory to store the simulation results
    simset_dpath <- file.path(ws, paste0('sim_tries_', i))
    dir.create(simset_dpath)
    syn_fq <- file.path(simset_dpath, 'synthetic_reads.fq')
    trimmed_syn_fq <- file.path(simset_dpath, 'srna_trimmed.fq')
    align_result <- file.path(simset_dpath, 'align_results')
    fig_coverage <- file.path(simset_dpath, 'alin_coverage.png')

    # generate synthetic reads
    set.seed(i)
    sim <- generate_reads(mismatch_prob = c(0.1, 0.2),
                          output = syn_fq)

    # quality control
    remove_adapters(file1 = syn_fq,
                    adapter1 = slot(sim, 'adapter'),
                    adapter2 = NULL,
                    output1 = trimmed_syn_fq,
                    params,
                    basename = file.path(ws, 'AdapterRemoval.log'),
                    overwrite = TRUE)

    # alignment
    aln <- align_reads(input = trimmed_syn_fq,
                       index = ref_index,
                       output = align_result,
                       n_mismatch = 2)

    # calculate alignment coverage
    alncov <- calc_coverage(aln)

    # calculate RMSE
    fwd_pred <- slot(alncov, 'forward')
    fwd_true <- slot(slot(sim, 'coverage'), 'forward')
    fwd_rmse[i] <- sqrt(sum((fwd_pred - fwd_true) ^ 2) / length(fwd_true))
    rev_pred <- slot(alncov, 'reverse')
    rev_true <- slot(slot(sim, 'coverage'), 'reverse')
    rev_rmse[i] <- sqrt(sum((rev_pred - rev_true) ^ 2) / length(rev_true))
}
```

```
rmse <- data.frame(forward = fwd_rmse, reverse = rev_rmse)
rmse
```

```
##     forward   reverse
## 1  25.67048  9.505721
## 2  30.96219  8.047771
## 3  23.38621 13.727033
## 4  23.77073 13.673376
## 5  14.50012 27.662013
## 6  12.06891 22.706684
## 7  19.44217 23.387306
## 8  11.46840 22.131626
## 9  21.24969 15.588346
## 10 18.25235 16.705221
```

The RMSE between the true (i.e., simulation condition) and predicted coverage
for the sequence reads in forward strand and reverse strand are
20.08 ±
6.23
and
17.31 ±
6.43,
respectively.
The result indicates that performance of this workflow
is worse when the sequence reads
contain up to two mismatches as compared with no mismatches
(i.e., RMSE shown in the section
[6.3](#performance-evaluation-with-the-synthetic-data)).
To examine detailed changes in performance,
users can change the number of mismatches and
the probabilities of mismatches to estimate how the performance changes.

## 7.2 Analysis of small RNA-Seq data from vioid-infected tomato plants

The damage caused by viroids to plants is thought to occur
during the replication process of the viroid that infects the plants.
Sequencing of small RNAs, including viroid-derived small RNAs (vd-sRNAs),
siRNAs, and miRNAs from viroid-infected plants could offer insights regarding
the mechanism of infection and eventually help in preventing plant damage.
The common workflow for analyzing such sequencing data is to
(i) limit the read-length (e.g., between 21 and 24 nt),
(ii) align these reads to viroid genome sequences,
and (iii) visualize coverage of alignment
to identify the pathogenic region in the viroid.

Adkar-Purushothama et al. reported viroid-host interactions by infecting potato
spindle tuber viroid (PSTVd) RG1 variant in tomato plants (Adkar-Purushothama, Iyer, and Perreault [2017](#ref-Adkar_2017)).
In their study, small RNAs were sequenced from viroid-infected tomato plants
to investigate the expression profiles (i.e., alignment coverage) of vd-sRNAs.
In this case study, we demonstrate the manner in which such expression
profiles can be calculated using the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package.

First, we prepare a directory to store the initial data, intermediate,
and final results. Then, we use the `download.file` function to download
the genome sequence of PSTVd RG1 and small RNA-Seq data of
viroid-infected tomato plants that are registered in GenBank with
accession number [U23058](https://www.ncbi.nlm.nih.gov/nuccore/U23058)
and gene expression omnibus (GEO) with accession number
[GSE70166](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE70166),
respectively. The downloaded genome sequence is saved as `U23058.fa`
and the small RNA-Seq data is saved as `GSM1717894_PSTVd_RG1.txt.gz`
by running the following scripts:

```
library(utils)

project_dpath <- tempdir()

dir.create(project_dpath)

options(timeout = 60 * 10)
download.file(url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=U23058&rettype=fasta&retmode=text',
              destfile = file.path(project_dpath, 'U23058.fa'))
download.file(url = 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE70166&format=file',
              destfile = file.path(project_dpath, 'GSE70166.tar'))
untar(file.path(project_dpath, 'GSE70166.tar'), exdir = project_dpath)
```

Following the preparation, we specify the genome sequence of the viroid
(i.e., `U23058.fa`) to build index files,
and align the reads of the small RNA-Seq data (`GSM1717894_PSTVd_RG1.txt.gz`)
against the viroid genome.
Note that this process may take a few minutes, depending on machine power.

```
genome_seq <- file.path(project_dpath, 'U23058.fa')
fq <- file.path(project_dpath, 'GSM1717894_PSTVd_RG1.txt.gz')

ref_index <- build_index(input = genome_seq,
                         output = file.path(project_dpath, 'index'))
aln <- align_reads(input = fq, index = ref_index,
                   output = file.path(project_dpath, 'align_results'))
```

The number of sequence reads that can align with the viroid genome sequences
can be checked using the following script.
From the alignment results saved in the cleaned BAM format file,
we can see that the numbers of
63,862 +
11,614 =
75,476 and
11,046 +
1,370 =
12,416
reads in forward and reverse strands
that were successfully aligned to the viroid genome sequences, respectively.

```
slot(aln, 'stats')
```

```
##                                       n_reads aligned_fwd aligned_rev unaligned
## GSM1717894_PSTVd_RG1.txt.t1.bam        730499       63862       11046    655591
## GSM1717894_PSTVd_RG1.txt.t2.bam        655591       11614        1370    642607
## GSM1717894_PSTVd_RG1.txt.clean.t1.bam   74908       63862       11046         0
## GSM1717894_PSTVd_RG1.txt.clean.t2.bam   12984       11614        1370         0
##                                       unsorted_reads
## GSM1717894_PSTVd_RG1.txt.t1.bam                    0
## GSM1717894_PSTVd_RG1.txt.t2.bam                    0
## GSM1717894_PSTVd_RG1.txt.clean.t1.bam              0
## GSM1717894_PSTVd_RG1.txt.clean.t2.bam              0
```

The `calc_coverage()` and `plot()` functions can be used
to calculate and visualize the alignment coverage.

```
alncov <- calc_coverage(aln)
```

```
head(slot(alncov, 'forward'))
```

```
##        L21  L22 L23 L24
## [1,]  8795 3898 120 335
## [2,]  8831 3898 120 335
## [3,]  8847 3901 125 337
## [4,]  8975 4436 129 344
## [5,] 11358 4483 138 379
## [6,] 11427 4532 144 387
```

```
head(slot(alncov, 'reverse'))
```

```
##      L21 L22 L23 L24
## [1,] 760 565  34  60
## [2,] 760 565  34  60
## [3,] 761 567  34  60
## [4,] 761 567  34  61
## [5,] 761 566  34  61
## [6,] 755 566  33  61
```

```
plot(alncov)
```

![Alignment coverage of small RNA-Seq data obtained from the viroid-infected tomato plants.](data:image/png;base64...)

Figure 10: Alignment coverage of small RNA-Seq data obtained from the viroid-infected tomato plants

We can confirm that the results with the *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package
are the same as the results shown in
[Figure 1B](https://www.nature.com/articles/s41598-017-08823-z/figures/1)
of the original paper (Adkar-Purushothama, Iyer, and Perreault [2017](#ref-Adkar_2017)) based on
the above figure [10](#fig:tutorialViroidCoverage).

# 8 GUI mode of CircSeqAlignTk

The *[CircSeqAlignTk](https://bioconductor.org/packages/3.22/CircSeqAlignTk)* package also provides
a graphical user interface (GUI) mode.
To use the GUI mode, we can run the following script:

```
library(shiny)
library(CircSeqAlignTk)
app <- build_app()
shiny::runApp(app)
```

In the GUI mode, users are required to
set a working directory (default is the current directory),
a FASTQ file for small RNA-Seq data,
and a FASTA file of the viroid genome sequence.
After setting up the working directory and files,
users can click the “Run” buttons
to start the FASTQ quality control and alignment process.
If required, the parameters of quality control and alignment can be adjusted.
The results will be displayed in the application
and saved in the working directory.

# 9 Session Information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_4.0.0         Rbowtie2_2.16.0       R.utils_2.13.0
## [4] R.oo_1.27.1           R.methodsS3_1.8.2     CircSeqAlignTk_1.12.0
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              fs_1.6.6
##   [9] BiocIO_1.20.0               vctrs_0.6.5
##  [11] memoise_2.0.1               Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17             tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] progress_1.2.3              curl_7.0.0
##  [19] SparseArray_1.10.0          sass_0.4.10
##  [21] shinyFiles_0.9.3            bslib_0.9.0
##  [23] htmlwidgets_1.6.4           httr2_1.2.1
##  [25] plotly_4.11.0               cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    igraph_2.2.1
##  [29] mime_0.13                   lifecycle_1.0.4
##  [31] pkgconfig_2.0.3             Matrix_1.7-4
##  [33] R6_2.6.1                    fastmap_1.2.0
##  [35] MatrixGenerics_1.22.0       shiny_1.11.1
##  [37] digest_0.6.37               ShortRead_1.68.0
##  [39] AnnotationDbi_1.72.0        S4Vectors_0.48.0
##  [41] GenomicRanges_1.62.0        RSQLite_2.4.3
##  [43] hwriter_1.3.2.1             labeling_0.4.3
##  [45] filelock_1.0.3              httr_1.4.7
##  [47] abind_1.4-8                 compiler_4.5.1
##  [49] withr_3.0.2                 bit64_4.6.0-1
##  [51] S7_0.2.0                    BiocParallel_1.44.0
##  [53] DBI_1.2.3                   biomaRt_2.66.0
##  [55] Rhisat2_1.26.0              rappdirs_0.3.3
##  [57] DelayedArray_0.36.0         rjson_0.2.23
##  [59] tools_4.5.1                 otel_0.2.0
##  [61] httpuv_1.6.16               glue_1.8.0
##  [63] restfulr_0.0.16             promises_1.4.0
##  [65] grid_4.5.1                  generics_0.1.4
##  [67] gtable_0.3.6                tidyr_1.3.1
##  [69] data.table_1.17.8           hms_1.1.4
##  [71] XVector_0.50.0              BiocGenerics_0.56.0
##  [73] pillar_1.11.1               stringr_1.5.2
##  [75] later_1.4.4                 dplyr_1.1.4
##  [77] BiocFileCache_3.0.0         lattice_0.22-7
##  [79] rtracklayer_1.70.0          bit_4.6.0
##  [81] deldir_2.0-4                tidyselect_1.2.1
##  [83] Biostrings_2.78.0           knitr_1.50
##  [85] bookdown_0.45               IRanges_2.44.0
##  [87] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
##  [89] stats4_4.5.1                xfun_0.53
##  [91] Biobase_2.70.0              matrixStats_1.5.0
##  [93] stringi_1.8.7               UCSC.utils_1.6.0
##  [95] lazyeval_0.2.2              yaml_2.3.10
##  [97] evaluate_1.0.5              codetools_0.2-20
##  [99] cigarillo_1.0.0             interp_1.1-6
## [101] tibble_3.3.0                BiocManager_1.30.26
## [103] cli_3.6.5                   xtable_1.8-4
## [105] jquerylib_0.1.4             dichromat_2.0-0.1
## [107] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
## [109] dbplyr_2.5.1                png_0.1-8
## [111] XML_3.99-0.19               RUnit_0.4.33.1
## [113] parallel_4.5.1              blob_1.2.4
## [115] prettyunits_1.2.0           latticeExtra_0.6-31
## [117] jpeg_0.1-11                 SGSeq_1.44.0
## [119] bitops_1.0-9                pwalign_1.6.0
## [121] txdbmaker_1.6.0             viridisLite_0.4.2
## [123] scales_1.4.0                purrr_1.1.0
## [125] crayon_1.5.3                rlang_1.1.6
## [127] KEGGREST_1.50.0             shinyjs_2.1.0
```

# References

Adkar-Purushothama, C. R., P. S. Iyer, and J. P. Perreault. 2017. “Potato Spindle Tuber Viroid Infection Triggers Degradation of Chloride Channel Protein Clc-B-Like and Ribosomal Protein S3a-Like mRNAs in Tomato Plants.” *Sci Rep* 7: 8341. <https://doi.org/10.1038/s41598-017-08823-z>.

Flores, R., S. Minoia, A. Carbonell, A. Gisel, S. Delgado, A. López-Carrasco, B. Navarro, and F. Di Serio. 2015. “Viroids, the Simplest Rna Replicons: How They Manipulate Their Hosts for Being Propagated and How Their Hosts React for Containing the Infection.” *Virus Research* 209: 136–45. [https://doi.org/https://doi.org/10.1016/j.virusres.2015.02.027](https://doi.org/https%3A//doi.org/10.1016/j.virusres.2015.02.027).

Gago-Zachert, Selma. 2016. “Viroids, Infectious Long Non-Coding Rnas with Autonomous Replication.” *Virus Research* 212: 12–24. <https://doi.org/10.1016/j.virusres.2015.08.018>.

Hull, Roger. 2014. *Plant Virology*. Massachusetts: Academic Press. <https://doi.org/10.1016/C2010-0-64974-1>.

Kim, Daehwan, Joseph M. Paggi, Chanhee Park, Christopher Bennett, and Steven L. Salzberg. 2019. “Graph-Based Genome Alignment and Genotyping with Hisat2 and Hisat-Genotype.” *Nat. Biotechnol.* 37: 907–15. <https://doi.org/10.1038/s41587-019-0201-4>.

Langmead, Ben, and Steven L. Salzberg. 2012. “Fast Gapped-Read Alignment with Bowtie 2.” *Nat Methods* 4: 357–59. <https://doi.org/10.1038/nmeth.1923>.

Schubert, Mikkel, Stinus Lindgreen, and Ludovic Orlando. 2016. “AdapterRemoval V2: Rapid Adapter Trimming, Identification, and Read Merging.” *BMC Research Notes* 9: 88. <https://doi.org/10.1186/s13104-016-1900-2>.

Sun, Jianqiang, Xi Fu, and Wei Cao. 2024. “An R Package for End-to-End Analysis of Rna-Seq Data for Circular Genomes.” *F1000Research* 11: 1221. <https://doi.org/10.12688/f1000research.127348.2>.

Sun, Jianqiang, and Yosuke Matsushita. 2024. “Predicting Symptom Severity in Pstvd-Infected Tomato Plants Using the Pstvd Genome Sequence.” *Molecular Plant Pathology*, no. 7: e13469. <https://doi.org/10.1111/mpp.13469>.

Wei, Zheng, Wei Zhang, Huan Fang, Yanda Li, and Xiaowo Wang. 2018. “EsATAC: An Easy-to-Use Systematic Pipeline for Atac-Seq Data Analysis.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/bty141>.

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. <https://ggplot2.tidyverse.org>.