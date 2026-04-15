---
name: ribotaper
description: RiboTaper identifies translated regions and open reading frames by leveraging the periodicity of ribosome profiling data. Use when user asks to identify translated regions, create specialized annotation files, perform metagene analysis for P-site definition, or find ORFs in coding and non-coding genomic regions.
homepage: https://github.com/boboppie/RiboTaper
metadata:
  docker_image: "quay.io/biocontainers/ribotaper:1.3.1--0"
---

# ribotaper

## Overview
RiboTaper is a computational method designed to identify translated regions by leveraging the high-resolution periodicity of Ribosome Profiling data. It integrates transcript annotations, genomic sequences, and Ribo-seq/RNA-seq alignments to distinguish true translation from background noise. Use this skill to execute the multi-step pipeline, which includes creating specialized annotation files, performing metagene analysis for P-site definition, and identifying ORFs in both coding and non-coding genomic regions.

## Requirements and Environment
RiboTaper runs on Linux and requires specific versions of bioinformatics tools and R packages:
- **Tools**: Samtools (0.1.19, must be in PATH) and Bedtools (v2.17.0).
- **R (3.0.1)**: Requires `multitaper`, `seqinr`, `ade4`, `doMC`, `iterators`, `foreach`, and `XNomial`.
- **Resources**: Recommended 7 cores and 8GB RAM per core (approx. 56GB total) for standard datasets.

## Core Workflow

### 1. Create Annotation Files
This is the first step to build the necessary coordinate and sequence files from a GTF and Genome Fasta.

**Command:**
```bash
./create_annotation_files.bash <gencode_gtf_file> <genome_fasta_file_indexed> <use_ccdsid?> <use_appris?> <dest_folder> <bedtools_path> <scripts_dir>
```

**Best Practices:**
- **GTF Format**: Ensure the GTF contains both coding and non-coding genes. Every "exon" and "CDS" row must have `transcript_id` and `gene_id` fields.
- **Isoform Filtering**: For Human (Gencode v19) or Mouse (Gencode M3), set `<use_ccdsid?>` and `<use_appris?>` to `true` to filter out low-confidence isoforms and improve ORF detection accuracy.
- **Scaffolds**: Remove or minimize scaffolds in the GTF/Fasta to prevent significant pipeline slowdowns.

### 2. Metagene Analysis (P-site Definition)
Defining the P-site offset for different Ribo-seq read lengths is the most critical step for the pipeline's success.

**Command:**
```bash
./create_metaplots.bash <ribo.bam> <bedtools_dir> <scripts_dir>
```

**Expert Tips:**
- **Read Lengths**: Use the resulting metaplots to visualize the frame precision of different read lengths.
- **Distance Cutoffs**: Only use read lengths that show a clear 3-nucleotide periodicity and high frame preference at the start codon.

### 3. Main Analysis and ORF Finding
The full workflow proceeds to:
1. Create data tracks from Ribo-seq and RNA-seq.
2. Analyze translation on exonic regions.
3. Perform ORF finding in coding and non-coding regions.
4. Generate a custom peptide FASTA database.

## Troubleshooting and Limitations
- **Memory Usage**: RiboTaper is memory-intensive. If encountering "C stack overflow" or memory errors, ensure the environment meets the 8GB per core requirement.
- **Transcript Isoforms**: RiboTaper identifies ORFs on transcripts but does not perform isoform deconvolution. If an ORF is found on multiple isoforms, it may be reported for all of them.
- **Execution Time**: Expect a full run (from BAM to results) to take approximately 24 hours for standard eukaryotic datasets on a cluster.

## Reference documentation
- [RiboTaper Main Documentation](./references/github_com_boboppie_RiboTaper.md)