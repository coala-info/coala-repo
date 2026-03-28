[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## *Stacks* Manual

Julian Catchen1, Nicolas Rochette1, Angel G. Rivera-Colón1,2, William A. Cresko2, Paul A. Hohenlohe3,
Angel Amores4, Susan Bassham2, John Postlethwait4

|  |  |  |  |
| --- | --- | --- | --- |
| 1Department of Evolution, Ecology, and Behavior  University of Illinois at Urbana-Champaign  Urbana, Illinois, 61820  USA | 2Institute of Ecology and Evolution  University of Oregon  Eugene, Oregon, 97403-5289  USA | 3Biological Sciences  University of Idaho  875 Perimeter Drive MS 3051  Moscow, ID 83844-3051  USA | 4Institute of Neuroscience  University of Oregon  Eugene, Oregon, 97403-1254  USA |

1. [Introduction](#intro)
2. [Installation](#install)
3. [What types of data does Stacks v2 support?](#data)
   1. Sequencer Type
   2. Paried-end Reads
   3. Protocol Type
4. [Running the pipeline](#pipe)
   1. [Clean the data](#clean)
   1. [Understanding barcodes/indexes](#barcode)
   2. [Specifying the barcodes](#specbc)
   3. [Running process\_radtags](#procrad)2. [Align data against a reference genome](#align)
   3. [Run the pipeline](#prun)
      1. denovo\_map.pl versus ref\_map.pl
      2. [The Population Map](#popmap)
      3. Examples
      4. [Choosing parameters for building stacks *de novo*](#params)
   4. [Run the pipeline by hand](#phand)
      1. [*De novo* Population Data](#denovobyhand)
      2. [Reference-aligned Population Data](#refmapbyhand)
      3. [*De novo* Genetic Mapping Cross](#genmapbyhand)
   5. [Whitelists and Blacklists](#wl)
   6. [Exporting data from Stacks](#export)
      1. Exporting data for STRUCTURE
      2. Exporting data for Adegenet
   7. [Evaluating sequencing coverage](#cov)
   8. [A protocol for running a RAD analysis](#prot)
5. [Pipeline Components](#comps)
6. [What do the fields mean in Stacks output files?](#files)

1. [ustacks](#ufiles)
   1. XXX.tags.tsv
   2. XXX.snps.tsv
   3. XXX.alleles.tsv
2. [cstacks](#cfiles)
3. [sstacks](#sfiles)
   1. XXX.matches.tsv
4. [tsv2bam](#tfiles)
5. [gstacks](#gfiles)
6. [populations](#pfiles)
   1. Summary statistics: populations.sumstats.tsv
   2. Summarized summary statistics: populations.sumstats\_summary.tsv
   3. SNP-based FST statistics: populations.fst\_Y-Z.tsv
   4. Haplotype statistics: populations.hapstats.tsv
   5. Haplotype-based, pairwise FST statistics: populations.phistats\_Y-Z.tsv
   6. Haplotype-based FST statistics: populations.phistats.tsv
   7. [RAD loci FASTA output](#pop_fasta)
      1. Per-locus consensus sequence: populations.loci.fa
      2. Per-locus, per-haplotype sequences: populations.samples.fa
      3. Per-locus, raw sequences: populations.samples-raw.fa
   8. [Mapping cross details: populations.markers.tsv](#markers)

7. [How to interpret basepair coordinates for Stacks variant sites](#coords)

### Introduction [[⇑top](#top)]

---

Several molecular approaches have been developed to focus short reads to specific, restriction-enzyme anchored positions
in the genome. Reduced representation techniques such as CRoPS, RAD-seq, GBS, double-digest RAD-seq, and 2bRAD
effectively subsample the genome of multiple individuals at homologous locations, allowing for single nucleotide
polymorphisms (SNPs) to be identified and typed for tens or hundreds of thousands of markers spread evenly throughout
the genome in large numbers of individuals. This family of reduced representation genotyping approaches has generically
been called genotype-by-sequencing (GBS) or Restriction-site Associated DNA sequencing (RAD-seq). For a review of these
technologies, see [Davey et al. 2011](http://www.nature.com/nrg/journal/v12/n7/abs/nrg3012.html) or
[Andrews, et al., 2016](http://doi.org/10.1038/nrg.2015.28).

*Stacks* is designed to work with any restriction-enzyme based data, such as GBS, CRoPS, and both single and
double digest RAD. *Stacks* is designed as a modular pipeline to efficiently curate and assemble large numbers of
short-read sequences from multiple samples. *Stacks* identifies loci in a set of individuals, either *de novo* or
aligned to a reference genome (including gapped alignments), and then genotypes each locus. *Stacks* incorporates
a maximum likelihood statistical model to identify sequence polymorphisms and distinguish them from sequencing
errors. *Stacks* employs a Catalog to record all loci identified in a population and matches individuals to that
Catalog to determine which haplotype alleles are present at every locus in each individual.

*Stacks* is implemented in C++ with wrapper programs written in Perl. The core algorithms are multithreaded via
OpenMP libraries and the software can handle data from hundreds of individuals, comprising millions of
genotypes.

A *de novo* analysis in *Stacks* proceeds in six major stages. First, reads are demultiplexed and cleaned
by the process\_radtags program. The next three stages comprise the main *Stacks* pipeline:
building loci (ustacks), creating the catalog of loci (cstacks), and matching
against the catalog (sstacks). In the fifth stage, the gstacks
program is executed to assemble and merge paired-end contigs, call variant sites in the population and genotypes in each
sample. In the final stage, the populations program is executed, which can filter data, calculate
population genetics statistics, and export a variety of data formats.

A reference-based analysis in *Stacks* proceeds in three major stages. The process\_radtags
program is executed as in a *de novo* analysis, then the gstacks program is executed, which
will read in aligned reads to assemble loci (and genotype them as in a *de novo* analysis), followed by the
populations program.

The image below diagrams the options.

![Stacks Pipeline](stacks_full_pipeline.png)

The *Stacks* pipeline.

---

### Installation [[⇑top](#top)]

---

#### Prerequisites

*Stacks* should build on any standard UNIX-like environment (Apple OS X, Linux,
etc.) *Stacks* is an independent pipeline and can be run without any additional
external software.

#### Build the software

*Stacks* uses the standard autotools install:

% tar xfvz stacks-2.xx.tar.gz
% cd stacks-2.xx
% ./configure
% make
(become root)
# make install
(or, use sudo)
% sudo make install

You can change the root of the install location (/usr/local/ on most
operating systems) by specifying the --prefix command line option to
the configure script.

% ./configure --prefix=/home/smith/local

You can speed up the build if you have more than one processor:

% make -j 8

A default install will install files in the following way:

|  |  |
| --- | --- |
| /usr/local/bin | Stacks executables and Perl scripts. |

The pipeline is now ready to run.

---

### What types of data does *Stacks v2* support? [[⇑top](#top)]

---

*Stacks* is designed to process data that *stacks* together. Primarily this consists of restriction
enzyme-digested DNA. There are a few similar types of data that will stack-up and could be processed by
*Stacks*, such as DNA flanked by primers as is produced in metagenomic 16S rRNA studies.

The goal in *Stacks* is to assemble loci in large numbers of individuals in a population or
genetic cross, call SNPs within those loci, and then read haplotypes from them. Therefore *Stacks*
wants data that is a uniform length, with coverage high enough to confidently call SNPs. Although it is very
useful in other bioinformatic analyses to variably trim raw reads, this creates loci that have variable coverage,
particularly at the 3’ end of the locus. In a population analysis, this results in SNPs that are
called in some individuals but not in others, depending on the amount of trimming that went into the reads
assembled into each locus, and this interferes with SNP and haplotype calling in large populations.

#### Protocol Type

*Stacks* supports all the major restriction-enzyme digest protocols such as RAD-seq, double-digest
RAD-seq, and a subset of GBS protocols, among others.

#### Sequencer Type

*Stacks* is optimized for short-read, Illumina-style sequencing. There is no limit to the length
the sequences can be, although there is a hard-coded limit of 1024bp in the source code now for efficency
reasons, but this limit could be raised if the technology warranted it.

*Stacks* can also be used with data produced by the Ion Torrent platform, but that platform
produces reads of multiple lengths so to use this data with *Stacks* the reads have to be
truncated to a particular length, discarding those reads below the chosen length. The
process\_radtags program can truncate the reads from an Ion Torrent run.

Other sequencing technologies could be used in theory, but often the cost versus the number of
reads obtained is prohibitive for building stacks and calling SNPs.

#### Paired-end Reads

*Stacks* directly supports paired-end reads, for both single and double digest protocols. In the case
of a single-digest protocol, *Stacks* will use the staggered paired-end reads to assemble a contig across all of
the individuals in the population. For double-digest RAD, both the single-end and paired-end reads are anchored
by a contig and Stacks will assemble them into two loci. In both cases, the paired-end contig/locus will be
merged with the single-end locus. If the loci do not overlap, they will be merged with a small buffer of
Ns in between them.

---

### Running the pipeline [[⇑top](#top)]

---

#### Clean the data

In a typical analysis, data will be received from an Illumina sequencer, or some other
type of sequencer as FASTQ files. The first requirement is to demultiplex, or sort, the
raw data to recover the individual samples in the Illumina library. While doing this, we
will use the [Phred](http://en.wikipedia.org/wiki/Phred_quality_score) scores
provided in the FASTQ files to discard sequencing reads of low
quality. These tasks are accomplished using the process\_radtags program.

![](process_radtags.png)

Some things to consider when running this program:

* process\_radtags can handle both single-end or paired-end Illumina sequencing.
* The raw data can be compressed, or gzipped (files end with a ".gz" suffix).
* You can supply a list of barcodes, or indexes, to process\_radtags in order for it
  to demultiplex your samples. These barcodes can be single-end barcodes or combinatorial
  barcodes (pairs of barcodes, one on each of the paired reads). Barcodes are specified,
  one per line (or in tab separated pairs per line), in a text file.

+ If, in addition to your barcodes, you also supply a sample name in an extra column within the barcodes file,
  process\_radtags will name your output files according to sample name instead of barcode.
+ If you supply the same sample name for multiple barcodes, reads containing those barcodes will be consolidated
  into a single output file, merging them.

* If you believe your reads may contain adapter contamination, process\_radtags can filter it out.
* You can supply the restriction enzyme used to construct the library. In the case
  of double-digest RAD, you can supply both restriction enzymes.
* If instructed, (-r command line option), process\_radtags will correct barcodes and
  restriction enzyme sites that are within a certain distance from the true barcode or
  restriction enzyme cutsite.
* By default, process\_radtags will identify and filter reads containing runs of poly-Gs.
  These runs are often indicative of synethesis termination in two-channel sequencing platforms — they represent
  the absence of sequence once the DNA molecule "runs out" during sequencing. The presence of these poly-G runs is
  platform dependent, thus process\_radtags will use the FASTQ headers to identify the correct
  platorm whenever possible and adjust filters accordingly. This behavior can be modified in the advanced options.

##### Understanding barcodes/indexes and specifying the barcode type

Genotype by sequencing libraries sample the genome by selecting DNA adjacent to one or more restriction enzyme
cutsites. By reducing the amount of total DNA sampled, most researchers will multiplex many samples into one
molecular library. Individual samples are demarcated in the library by ligating an oligo barcode onto the
restriction enzyme-associated DNA for each sample. Alternatively, an index barcode is used, where the barcode is
located upstream of the sample DNA within the sequencing adaptor. Regardless of the type of barcode used, after
sequencing, the data must be demultiplexed so the samples are again separated. The process\_radtags program will perform this task, but we much specify the type of barcodes used,
and where to find them in the sequencing data.

There are a number of different configurations possible, each of them is detailed below.

1. If your data are **single-end** or **paired-end**, with an inline barcode present only on the single-end (marked in red):

   @HWI-ST0747:188:C09HWACXX:1:1101:2968:2083 1:N:0:
   TTATGATGCAGGACCAGGATGACGTCAGCACAGTGCGGGTCCTCCATGGATGCTCCTCGGTCGTGGTTGGGGGAGGAGGCA
   +
   @@@DDDDDBHHFBF@CCAGEHHHBFGIIFGIIGIEDBBGFHCGIIGAEEEDCC;A?;;5,:@A?=B5559999B@BBBBBA
   @HWI-ST0747:188:C09HWACXX:1:1101:2863:2096 1:N:0:
   TTATGATGCAGGCAAATAGAGTTGGATTTTGTGTCAGTAGGCGGTTAATCCCATACAATTTTACACTTTATTCAAGGTGGA
   +
   CCCFFFFFHHHHHJJGHIGGAHHIIGGIIJDHIGCEGHIFIJIH7DGIIIAHIJGEDHIDEHJJHFEEECEFEFFDECDDD
   @HWI-ST0747:188:C09HWACXX:1:1101:2837:2098 1:N:0:
   GTGCCTTGCAGGCAATTAAGTTAGCCGAGATTAAGCGAAGGTTGAAAATGTCGGATGGAGTCCGGCAGCAGCGAATGTAAA

   Then you can specify the --inline\_null flag to process\_radtags. This is also the
   default behavior and the flag can be ommitted in this case.
2. If your data are **single-end** or **paired-end**, with a single index barcode (in blue):

   @9432NS1:54:C1K8JACXX:8:1101:6912:1869 1:N:0:ATGACT
   TCAGGCATGCTTTCGACTATTATTGCATCAATGTTCTTTGCGTAATCAGCTACAATATCAGGTAATATCAGGCGCA
   +
   CCCFFFFFHHHHHJJJJJJJJIJJJJJJJJJJJHIIJJJJJJIJJJJJJJJJJJJJJJJJJJGIJJJJJJJHHHFF
   @9432NS1:54:C1K8JACXX:8:1101:6822:1873 1:N:0:ATGACT
   CAGCGCATGAGCTAATGTATGTTTTACATTCCAGAAAGAGAGCTACTGCTGCAGGTTGTGATAAAATAAAGTAAGA
   +
   B@@FFFFFHFFHHJJJJFHIJHGGGHIJIIJIJCHJIIGGIIIGGIJEHIJJHII?FFHICHFFGGHIIGG@DEHH
   @9432NS1:54:C1K8JACXX:8:1101:6793:1916 1:N:0:ATGACT
   TTTCGCATGCCCTATCCTTTTATCACTCTGTCATTCAGTGTGGCAGCGGCCATAGTGTATGGCGTACTAAGCGAAA
   +
   @C@DFFFFHGHHHGIGHHJJJJJJJGIJIJJIGIJJJJHIGGGHGII@GEHIGGHDHEHIHD6?493;AAA?;=;=

   Then you can specify the --index\_null flag to process\_radtags.
3. If your data are **single-end** with both an inline barcode (in red) and an index barcode (in blue):

   @9432NS1:54:C1K8JACXX:8:1101:6912:1869 1:N:0:ATCACG
   TCACGCATGCTTTCGACTATTATTGCATCAATGTTCTTTGCGTAATCAGCTACAATATCAGGTAATATCAGGCGCA
   +
   CCCFFFFFHHHHHJJJJJJJJIJJJJJJJJJJJHIIJJJJJJIJJJJJJJJJJJJJJJJJJJGIJJJJJJJHHHFF
   @9432NS1:54:C1K8JACXX:8:1101:6822:1873 1:N:0:ATCACG
   GTCCGCATGAGCTAATGTATGTTTTACATTCCAGAAAGAGAGCTACTGCTGCAGGTTGTGATAAAATAAAGTAAGA
   +
   B@@FFFFFHFFHHJJJJFHIJHGGGHIJIIJIJCHJIIGGIIIGGIJEHIJJHII?FFHICHFFGGHIIGG@DEHH
   @9432NS1:54:C1K8JACXX:8: