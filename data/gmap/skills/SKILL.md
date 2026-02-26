---
name: gmap
description: "GMAP provides high-speed genomic mapping and alignment for long mRNA/EST sequences and short-read sequencing data. Use when user asks to build a genome index, map cDNA to a reference genome, align short reads with SNP tolerance, or detect splice sites and gene fusions."
homepage: http://research-pub.gene.com/gmap
---


# gmap

## Overview
The `gmap` suite provides high-speed genomic mapping and alignment capabilities. It is primarily used for two distinct tasks: `GMAP`, which is optimized for long mRNA/EST sequences (cDNA-to-genome), and `GSNAP`, which is designed for short-read sequencing data (NGS). This skill guides the workflow from indexing a reference genome to executing complex alignments with specific biological constraints like splicing and SNPs.

## Core Workflow

### 1. Genome Database Preparation
Before alignment, you must build a genome index using `gmap_build`.
- **Basic Indexing**: `gmap_build -d <dbname> <fasta_file>`
- **Custom Location**: Use `-D <directory>` to specify where the database should be stored.
- **Transcriptome Guidance**: For GSNAP, you can incorporate known transcripts during indexing to improve splice detection.

### 2. GMAP: mRNA and EST Alignment
Use `gmap` for mapping longer sequences where high-quality splice site detection is required.
- **Standard Usage**: `gmap -d <dbname> <query.fasta>`
- **Output Formats**: Use `-f` to specify output (e.g., `sam`, `gff3_gene`, `gff3_match_cdna`).
- **Cross-Species**: Use the `--min-intronlength` and `--max-intronlength` flags to tune for specific organisms.

### 3. GSNAP: Short-Read Alignment
Use `gsnap` for Illumina-style short reads, particularly when looking for SNPs or complex splicing.
- **Basic Alignment**: `gsnap -d <dbname> <reads.fastq>`
- **Paired-End**: `gsnap -d <dbname> <reads_1.fastq> <reads_2.fastq>`
- **Two-Pass Mode**: Use `--two-pass` to allow the tool to learn splice sites and indels from the data itself.
- **SNP-Tolerance**: Requires a pre-computed SNP database. Use `-v <snp_database>` to align against a reference while allowing for known variants.

## Expert Tips and CLI Patterns

### Splicing and Fusions
- **Splice Site Dumping**: Use `--splices-dump` in GSNAP to produce a splice junction file compatible with other downstream tools like STAR.
- **Fusion Detection**: Enable `--fusions-genes` in GSNAP to identify chimeric transcripts or genomic rearrangements.
- **Non-Canonical Splices**: GSNAP identifies AT-AC introns in addition to standard GT-AG/GC-AG sites.

### Performance Optimization
- **Memory Management**: For large genomes, ensure the system has sufficient RAM. GSNAP uses SIMD instructions (AVX-512/AVX2) automatically if the hardware supports it.
- **Threading**: Use `-t <threads>` to parallelize the alignment process.
- **Random Sampling**: Use `--align-fraction <float>` to align only a subset of reads for quick QC or parameter testing.

### SAM Output Customization
- **Mate CIGAR**: GSNAP uses the `MC` field for mate CIGAR strings in SAM output.
- **MD Strings**: MD strings report 'N's in the query sequence as mismatches by default.
- **Hard Clipping**: GSNAP supports hard-clipping in SAM output, which can be toggled based on downstream tool requirements.

## Reference documentation
- [GMAP and GSNAP Home](./references/research-pub_gene_com_gmap.md)
- [Bioconda GMAP Overview](./references/anaconda_org_channels_bioconda_packages_gmap_overview.md)