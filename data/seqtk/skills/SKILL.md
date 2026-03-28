---
name: seqtk
description: Seqtk is a fast and lightweight toolkit for processing and transforming genomic sequences in FASTA and FASTQ formats. Use when user asks to convert sequence formats, subsample reads, trim low-quality bases, or extract specific genomic regions and sequences by name.
homepage: https://github.com/lh3/seqtk
---


# seqtk

## Overview

Seqtk is a lightweight and exceptionally fast toolkit written in C for processing genomic sequences. It is a staple in bioinformatics pipelines for its ability to handle both FASTA and FASTQ formats seamlessly, including gzip-compressed files. Use this skill to perform rapid sequence manipulations without the overhead of heavy libraries. It is particularly effective for preparing datasets for assembly, mapping, or quality control by filtering reads, masking low-quality bases, or extracting specific genomic subsets.

## Common CLI Patterns

### Format Conversion and Transformation
*   **Convert FASTQ to FASTA**: `seqtk seq -a in.fq.gz > out.fa`
*   **Reverse Complement**: `seqtk seq -r in.fq > out.fq`
*   **Fold FASTA/Q lines**: Use `-l` to set line length (e.g., 60 characters): `seqtk seq -l 60 in.fa > out.fa`
*   **Convert multi-line FASTQ to standard 4-line format**: `seqtk seq -l0 in.fq > out.fq`

### Quality Control and Masking
*   **Trim low-quality bases**: Uses the Phred algorithm to trim ends: `seqtk trimfq in.fq > out.fq`
*   **Fixed-length trimming**: Trim 5bp from the start and 10bp from the end: `seqtk trimfq -b 5 -e 10 in.fa > out.fa`
*   **Quality masking**: Mask bases with quality < 20 to lowercase: `seqtk seq -aQ64 -q20 in.fq > out.fa`
*   **Mask regions to N**: Use a BED file to specify regions: `seqtk seq -M reg.bed in.fa > out.fa`

### Subsetting and Sampling
*   **Subsample reads**: Randomly select 10,000 reads (use `-s` for a repeatable seed):
    `seqtk sample -s100 read1.fq 10000 > sub1.fq`
    *Note: Always use the same seed for paired-end files to keep reads synchronized.*
*   **Extract sequences by name**: Provide a list of IDs (one per line): `seqtk subseq in.fq name.lst > out.fq`
*   **Extract sequences by region**: Provide a BED file: `seqtk subseq in.fa reg.bed > out.fa`

### Advanced Analysis
*   **Find Telomeres**: Identify (TTAGGG)n repeats: `seqtk telo seq.fa > telo.bed`
*   **Identify Gaps**: Output positions of 'N' blocks: `seqtk gap in.fa > gaps.bed`
*   **Homopolymer-compressed (HPC) sequence**: Generate HPC sequences: `seqtk hpc in.fq > out.fa`

## Expert Tips

*   **Piping**: Seqtk is designed for Unix pipes. You can stream gzipped data in and out efficiently: `zcat in.fq.gz | seqtk seq -a - | gzip > out.fa.gz`
*   **Paired-end Synchronization**: When using `seqtk sample`, if you do not use the exact same `-s` integer for both R1 and R2 files, your paired-end synchronization will be broken, rendering the output useless for most aligners.
*   **Handling Illumina 1.3+**: For older Illumina data using Phred+64 offsets, ensure you use the `-Q64` flag during conversion or masking to avoid quality score errors.
*   **Memory Efficiency**: `seqtk` is highly memory-efficient, but for the `subseq` command with a large list of names, ensure your `name.lst` is sorted if memory is extremely limited, though `seqtk` generally handles large lists well by default.



## Subcommands

| Command | Description |
|---------|-------------|
| comp | Get the nucleotide composition of a FASTA/FASTQ file |
| cutN | Cut sequences at long N tracts |
| dropse | Drop single-end reads from interleaved FASTQ |
| famask | Apply a mask to a FASTA sequence file |
| fqchk | Fastq quality check and distribution analysis |
| gap | Find gaps in a FASTA file |
| gc | Identify GC-rich or AT-rich regions in a FASTA file |
| hety | Analyze heterozygosity in a FASTA file |
| listhet | Identify and list heterozygous sites from a sequence file. |
| mergefa | Merge two FASTA/Q files |
| mergepe | Merge paired-end reads from two separate FASTQ files |
| mutfa | Mutate a FASTA file based on a SNP list. The SNP file should contain at least four columns: 'chr', '1-based-pos', 'any', and 'base-changed-to'. |
| randbase | Randomize bases in a sequence file (usually part of the seqtk toolkit) |
| rename | Rename sequences in a FASTA/FASTQ file |
| sample | Subsample sequences from FASTA/FASTQ files |
| seq | Common transformation of FASTA/FASTQ sequences, including masking, partitioning, and format conversion. |
| seqtk_hpc | A tool for processing biological sequences (HPC version). |
| size | Calculate the total number of bases and sequences in a FASTA/FASTQ file |
| split | Split a FASTA/FASTQ file into multiple files |
| subseq | Extract subsequences from FASTA/FASTQ files using a BED file or a list of names |
| trimfq | Trim low-quality regions from FASTQ sequences |

## Reference documentation

- [Main README and Examples](./references/github_com_lh3_seqtk.md)
- [Recent Updates and Command Additions](./references/github_com_lh3_seqtk_commits_master.md)