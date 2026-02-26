# samblaster CWL Generation Report

## samblaster

### Tool Description
Tool to mark duplicates and optionally output split reads and/or discordant pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/samblaster:0.1.26--h9948957_7
- **Homepage**: https://github.com/GregoryFaust/samblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/samblaster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samblaster/overview
- **Total Downloads**: 223.8K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/GregoryFaust/samblaster
- **Stars**: N/A
### Original Help Text
```text
samblaster: Version 0.1.26
Author: Greg Faust (gf4ea@virginia.edu)
Tool to mark duplicates and optionally output split reads and/or discordant pairs.
Input sam file must contain sequence header and be grouped by read ids (QNAME).
Input typicallly contains paired-end data, although singleton data is allowed with --ignoreUnmated option.
Output will be all alignments in the same order as input, with duplicates marked with FLAG 0x400.

Usage:
For use as a post process on an aligner (eg. bwa mem):
     bwa mem <idxbase> samp.r1.fq samp.r2.fq | samblaster [-e] [-d samp.disc.sam] [-s samp.split.sam] | samtools view -Sb - > samp.out.bam
     bwa mem -M <idxbase> samp.r1.fq samp.r2.fq | samblaster -M [-e] [-d samp.disc.sam] [-s samp.split.sam] | samtools view -Sb - > samp.out.bam
For use with a pre-existing bam file to pull split, discordant and/or unmapped reads without marking duplicates:
     samtools view -h samp.bam | samblaster -a [-e] [-d samp.disc.sam] [-s samp.split.sam] [-u samp.umc.fasta] -o /dev/null
For use with a bam file of singleton long reads to pull split and/or unmapped reads with/without marking duplicates:
     samtools view -h samp.bam | samblaster --ignoreUnmated [-e] --maxReadLength 100000 [-s samp.split.sam] [-u samp.umc.fasta] | samtools view -Sb - > samp.out.bam
     samtools view -h samp.bam | samblaster --ignoreUnmated -a [-e] [-s samp.split.sam] [-u samp.umc.fasta] -o /dev/null
Input/Output Options:
-i --input           FILE Input sam file [stdin].
-o --output          FILE Output sam file for all input alignments [stdout].
-d --discordantFile  FILE Output discordant read pairs to this file. [no discordant file output]
-s --splitterFile    FILE Output split reads to this file abiding by paramaters below. [no splitter file output]
-u --unmappedFile    FILE Output unmapped/clipped reads as FASTQ to this file abiding by parameters below. [no unmapped file output].
                          Requires soft clipping in input file.  Will output FASTQ if QUAL information available, otherwise FASTA.

Other Options:
-a --acceptDupMarks       Accept duplicate marks already in input file instead of looking for duplicates in the input.
-e --excludeDups          Exclude reads marked as duplicates from discordant, splitter, and/or unmapped file.
-r --removeDups           Remove duplicates reads from all output files. (Implies --excludeDups).
   --addMateTags          Add MC and MQ tags to all output paired-end SAM lines.
   --ignoreUnmated        Suppress abort on unmated alignments. Use only when sure input is read-id grouped,
                          and either paired-end alignments have been filtered or the input file contains singleton reads.
-M                        Run in compatibility mode; both 0x100 and 0x800 are considered chimeric. Similar to BWA MEM -M option.
   --maxReadLength    INT Maximum allowed length of the SEQ/QUAL string in the input file. [500]
                          Primarily useful for marking duplicates in files containing singleton long reads.
   --maxSplitCount    INT Maximum number of split alignments for a read to be included in splitter file. [2]
   --maxUnmappedBases INT Maximum number of un-aligned bases between two alignments to be included in splitter file. [50]
   --minIndelSize     INT Minimum structural variant feature size for split alignments to be included in splitter file. [50]
   --minNonOverlap    INT Minimum non-overlaping base pairs between two alignments for a read to be included in splitter file. [20]
   --minClipSize      INT Minumum number of bases a mapped read must be clipped to be included in unmapped file. [20]
-q --quiet                Output fewer statistics.
```

