# RSEM

# README for RSEM

[Bo Li](https://lilab-bcb.github.io/) (bli28 at mgh dot harvard dot edu)

---

## Table of Contents

* [Introduction](#introduction)
* [Compilation & Installation](#compilation)
* [Usage](#usage)
  + [Build RSEM references using RefSeq, Ensembl, or GENCODE annotations](#built)
  + [Build RSEM references for untypical organisms](#untypical)
* [Example](#example-main)
* [Simulation](#simulation)
* [Generate Transcript-to-Gene-Map from Trinity Output](#gen_trinity)
* [Differential Expression Analysis](#de)
* [Prior-Enhanced RSEM (pRSEM)](#pRSEM)
* [Authors](#authors)
* [Acknowledgements](#acknowledgements)
* [License](#license)

---

## Introduction

RSEM is a software package for estimating gene and isoform expression levels from RNA-Seq data. The RSEM package provides an user-friendly interface, supports threads for parallel computation of the EM algorithm, single-end and paired-end read data, quality scores, variable-length reads and RSPD estimation. In addition, it provides posterior mean and 95% credibility interval estimates for expression levels. For visualization, It can generate BAM and Wiggle files in both transcript-coordinate and genomic-coordinate. Genomic-coordinate files can be visualized by both UCSC Genome browser and Broad Institute’s Integrative Genomics Viewer (IGV). Transcript-coordinate files can be visualized by IGV. RSEM also has its own scripts to generate transcript read depth plots in pdf format. The unique feature of RSEM is, the read depth plots can be stacked, with read depth contributed to unique reads shown in black and contributed to multi-reads shown in red. In addition, models learned from data can also be visualized. Last but not least, RSEM contains a simulator.

## Compilation & Installation

To compile RSEM, simply run

```
make
```

For Cygwin users, run

```
make cygwin=true
```

To compile EBSeq, which is included in the RSEM package, run

```
make ebseq
```

To install RSEM, simply put the RSEM directory in your environment’s PATH variable. Alternatively, run

```
make install
```

By default, RSEM executables are installed to `/usr/local/bin`. You can change the installation location by setting `DESTDIR` and/or `prefix` variables. The RSEM executables will be installed to `${DESTDIR}${prefix}/bin`. The default values of `DESTDIR` and `prefix` are `DESTDIR=` and `prefix=/usr/local`. For example,

```
make install DESTDIR=/home/my_name prefix=/software
```

will install RSEM executables to `/home/my_name/software/bin`.

**Note** that `make install` does not install `EBSeq` related scripts, such as `rsem-generate-ngvector`, `rsem-run-ebseq`, and `rsem-control-fdr`. But `rsem-generate-data-matrix`, which generates count matrix for differential expression analysis, is installed.

### Prerequisites

C++, Perl and R are required to be installed.

To use the `--gff3` option of `rsem-prepare-reference`, Python is also required to be installed.

To take advantage of RSEM’s built-in support for the Bowtie/Bowtie 2/STAR/HISAT2 alignment program, you must have [Bowtie](http://bowtie-bio.sourceforge.net)/[Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2)/[STAR](https://github.com/alexdobin/STAR)/[HISAT2](https://ccb.jhu.edu/software/hisat2/manual.shtml) installed.

## Usage

### I. Preparing Reference Sequences

RSEM can extract reference transcripts from a genome if you provide it with gene annotations in a GTF/GFF3 file. Alternatively, you can provide RSEM with transcript sequences directly.

Please note that GTF files generated from the UCSC Table Browser do not contain isoform-gene relationship information. However, if you use the UCSC Genes annotation track, this information can be recovered by downloading the knownIsoforms.txt file for the appropriate genome.

To prepare the reference sequences, you should run the `rsem-prepare-reference` program. Run

```
rsem-prepare-reference --help
```

to get usage information or visit the [rsem-prepare-reference documentation page](rsem-prepare-reference.html).

#### Build RSEM references using RefSeq, Ensembl, or GENCODE annotations

RefSeq and Ensembl are two frequently used annotations. For human and mouse, GENCODE annotaions are also available. In this section, we show how to build RSEM references using these annotations. Note that it is important to pair the genome with the annotation file for each annotation source. In addition, we recommend users to use the primary assemblies of genomes. Without loss of generality, we use human genome as an example and in addition build Bowtie indices.

For **RefSeq**, the genome and annotation file in GFF3 format can be found at RefSeq genomes FTP:

```
ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/
```

For example, the human genome and GFF3 file locate at the subdirectory `vertebrate_mammalian/Homo_sapiens/all_assembly_versions/GCF_000001405.31_GRCh38.p5`. `GCF_000001405.31_GRCh38.p5` is the latest annotation version when this section was written.

Download and decompress the genome and annotation files to your working directory:

```
ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/all_assembly_versions/GCF_000001405.31_GRCh38.p5/GCF_000001405.31_GRCh38.p5_genomic.fna.gz
ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/all_assembly_versions/GCF_000001405.31_GRCh38.p5/GCF_000001405.31_GRCh38.p5_genomic.gff.gz
```

`GCF_000001405.31_GRCh38.p5_genomic.fna` contains all top level sequences, including patches and haplotypes. To obtain the primary assembly, run the following RSEM python script:

```
rsem-refseq-extract-primary-assembly GCF_000001405.31_GRCh38.p5_genomic.fna GCF_000001405.31_GRCh38.p5_genomic.primary_assembly.fna
```

Then type the following command to build RSEM references:

```
rsem-prepare-reference --gff3 GCF_000001405.31_GRCh38.p5_genomic.gff \
               --trusted-sources BestRefSeq,Curated\ Genomic \
               --bowtie \
               GCF_000001405.31_GRCh38.p5_genomic.primary_assembly.fna \
               ref/human_refseq
```

In the above command, `--trusted-sources` tells RSEM to only extract transcripts from RefSeq sources like `BestRefSeq` or `Curated Genomic`. By default, RSEM trust all sources. There is also an `--gff3-RNA-patterns` option and its default is `mRNA`. Setting `--gff3-RNA-patterns mRNA,rRNA` will allow RSEM to extract all mRNAs and rRNAs from the genome. Visit [here](rsem-prepare-reference.html) for more details.

Because the gene and transcript IDs (e.g. gene1000, rna28655) extracted from RefSeq GFF3 files are hard to understand, it is recommended to turn on the `--append-names` option in `rsem-calculate-expression` for better interpretation of quantification results.

For **Ensembl**, the genome and annotation files can be found at [Ensembl FTP](http://uswest.ensembl.org/info/data/ftp/index.html).

Download and decompress the human genome and GTF files:

```
ftp://ftp.ensembl.org/pub/release-83/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
ftp://ftp.ensembl.org/pub/release-83/gtf/homo_sapiens/Homo_sapiens.GRCh38.83.gtf.gz
```

Then use the following command to build RSEM references:

```
rsem-prepare-reference --gtf Homo_sapiens.GRCh38.83.gtf \
               --bowtie \
               Homo_sapiens.GRCh38.dna.primary_assembly.fa \
               ref/human_ensembl
```

If you want to use GFF3 file instead, which is unnecessary and not recommended, you should add option `--gff3-RNA-patterns transcript` because `mRNA` is replaced by `transcript` in Ensembl GFF3 files.

**GENCODE** only provides human and mouse annotations. The genome and annotation files can be found from [GENCODE website](http://www.gencodegenes.org/).

Download and decompress the human genome and GTF files:

```
ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_24/GRCh38.primary_assembly.genome.fa.gz
ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_24/gencode.v24.annotation.gtf.gz
```

Then type the following command:

```
rsem-prepare-reference --gtf gencode.v24.annotation.gtf \
               --bowtie \
               GRCh38.primary_assembly.genome.fa \
               ref/human_gencode
```

Similar to Ensembl annotation, if you want to use GFF3 files (not recommended), add option `--gff3-RNA-patterns transcript`.

#### Build RSEM references for untypical organisms

For untypical organisms, such as viruses, you may only have a GFF3 file that containing only genes but not any transcripts. You need to turn on `--gff3-genes-as-transcripts` so that RSEM will make each gene as a unique transcript.

Here is an example command:

```
rsem-prepare-reference --gff3 virus.gff \
               --gff3-genes-as-transcripts \
               --bowtie \
               virus.genome.fa \
               ref/virus
```

### II. Calculating Expression Values

To calculate expression values, you should run the `rsem-calculate-expression` program. Run

```
rsem-calculate-expression --help
```

to get usage information or visit the [rsem-calculate-expression documentation page](rsem-calculate-expression.html).

#### Calculating expression values from single-end data

For single-end models, users have the option of providing a fragment length distribution via the `--fragment-length-mean` and `--fragment-length-sd` options. The specification of an accurate fragment length distribution is important for the accuracy of expression level estimates from single-end data. If the fragment length mean and sd are not provided, RSEM will not take a fragment length distribution into consideration.

#### Using an alternative aligner

By default, RSEM automates the alignment of reads to reference transcripts using the Bowtie aligner. Turn on `--bowtie2` for `rsem-prepare-reference` and `rsem-calculate-expression` will allow RSEM to use the Bowtie 2 alignment program instead. Please note that indel alignments, local alignments and discordant alignments are disallowed when RSEM uses Bowtie 2 since RSEM currently cannot handle them. See the description of `--bowtie2` option in `rsem-calculate-expression` for more details. Similarly, turn on `--star` will allow RSEM to use the STAR aligner. Turn on `--hisat2-hca` will allow RSEM to use the HISAT2 aligner according to Human Cell Atals SMART-Seq2 pipeline. To use an alternative alignment program, align the input reads against the file `reference_name.idx.fa` generated by `rsem-prepare-reference`, and format the alignment output in SAM/BAM/CRAM format. Then, instead of providing reads to `rsem-calculate-expression`, specify the `--alignments` option and provide the SAM/BAM/CRAM file as an argument.

RSEM requires the alignments of a read to be adjacent. For paired-end reads, RSEM also requires the two mates of any alignment be adjacent. To check if your SAM/BAM/CRAM file satisfy the requirements, run

```
rsem-sam-validator <input.sam/input.bam/input.cram>
```

If your file does not satisfy the requirements, you can use `convert-sam-for-rsem` to convert it into a BAM file which RSEM can process. Run

```
convert-sam-for-rsem --help
```

to get usage information or visit the [convert-sam-for-rsem documentation page](convert-sam-for-rsem.html).

Note that RSEM does \*\* not \*\* support gapped alignments. So make sure that your aligner does not produce alignments with intersions/deletions. In addition, you should make sure that you use `reference_name.idx.fa`, which is generated by RSEM, to build your aligner’s indices.

### III. Visualization

RSEM includes a copy of SAMtools. When `--no-bam-output` is not specified and `--sort-bam-by-coordinate` is specified, RSEM will produce these three files:`sample_name.transcript.bam`, the unsorted BAM file, `sample_name.transcript.sorted.bam` and `sample_name.transcript.sorted.bam.bai` the sorted BAM file and indices generated by the SAMtools included. All three files are in transcript coordinates. When users in addition specify the `--output-genome-bam` option, RSEM will produce three more files: `sample_name.genome.bam`, the unsorted BAM file, `sample_name.genome.sorted.bam` and `sample_name.genome.sorted.bam.bai` the sorted BAM file and indices. All these files are in genomic coordinates.

#### a) Converting transcript BAM file into genome BAM file

Normally, RSEM will do this for you via `--output-genome-bam` option of `rsem-calculate-expression`. However, if you have run `rsem-prepare-reference` and use `reference_name.idx.fa` to build indices for your aligner, you can use `rsem-tbam2gbam` to convert your transcript coordinate BAM alignments file into a genomic coordinate BAM alignments file without the need to run the whole RSEM pipeline.

Usage:

```
rsem-tbam2gbam reference_name unsorted_transcript_bam_input genome_bam_output
```

reference\_name : The name of reference built by `rsem-prepare-reference`
unsorted\_transcript\_bam\_input : This file should satisfy: 1) the alignments of a same read are grouped together, 2) for any paired-end alignment, the two mates should be adjacent to each other, 3) this file should not be sorted by samtools genome\_bam\_output : The output genomic coordinate BAM file’s name

#### b) Generating a Wiggle file

A wiggle plot representing the expected number of reads overlapping each position in the genome/transcript set can be generated from the sorted genome/transcript BAM file output. To generate the wiggle plot, run the `rsem-bam2wig` program on the `sample_name.genome.sorted.bam`/`sample_name.transcript.sorted.bam` file.

Usage:

```
rsem-bam2wig sorted_bam_input wig_output wiggle_name [--no-fractional-weight]
```

sorted\_bam\_input : Input BAM format file, must be sorted
wig\_output : Output wiggle file’s name, e.g. output.wig
wiggle\_name : The name of this wiggle plot
–no-fractional-weight : If this is set, RSEM will not look for “ZW” tag and each alignment appeared in the BAM file has weight 1. Set this if your BAM file is not generated by RSEM. Please note that this option must be at the end of the command line

#### c) Loading a BAM and/or Wiggle file into the UCSC Genome Browser or Integrative Genomics Viewer(IGV)

For UCSC genome browser, please refer to the [UCSC custom track help page](http://genome.ucsc.edu/goldenPath/help/customTrack.html).

For integrative genomics viewer, please refer to the [IGV home page](http://www.broadinstitute.org/software/igv/home). Note: Although IGV can generate read depth plot from the BAM file given, it cannot recognize “ZW” tag RSEM puts. Therefore IGV counts each alignment as weight 1 instead of the expected weight for the plot it generates. So we recommend to use the wiggle file generated by RSEM for read depth visualization.

Here are some guidance for visualizing transcript coordinate files using IGV:

1. Import the transcript sequences as a genome

Select File -> Import Genome, then fill in ID, Name and Fasta file. Fasta file should be `reference_name.idx.fa`. After that, click Save button. Suppose ID is filled as `reference_name`, 