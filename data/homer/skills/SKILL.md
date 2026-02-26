---
name: homer
description: HOMER is a suite of command-line tools designed for motif discovery, peak calling, and genomic annotation in large-scale functional genomics datasets. Use when user asks to find enriched motifs, call peaks from ChIP-Seq or Hi-C data, annotate peaks with genomic features, or perform functional enrichment analysis.
homepage: http://homer.ucsd.edu/homer/index.html
---


# homer

## Overview
The HOMER (Hypergeometric Optimization of Motif EnRichment) suite is a collection of command-line utilities for UNIX-style systems. It excels at identifying 8-20 bp motifs in large-scale genomic datasets and provides a comprehensive workflow for processing various functional genomics assays. This skill provides the necessary patterns for motif enrichment, peak calling, and genomic annotation using HOMER's native Perl and C++ tools.

## Core Workflows and CLI Patterns

### 1. Motif Discovery (findMotifsGenome.pl)
The primary tool for finding enriched sequences within genomic coordinates.
- **Basic Command**: `findMotifsGenome.pl <peaks.bed> <genome> <output_dir> -size 200 -mask`
- **Best Practices**:
    - Use `-mask` to ignore repeats and avoid artifacts.
    - Use `-size given` if your input regions are already trimmed to the exact area of interest; otherwise, `-size 200` is standard for ChIP-Seq.
    - For RNA-Seq gene lists (not coordinates), use `findMotifs.pl <gene_list.txt> <organism> <output_dir>`.

### 2. Peak Calling and Analysis (findPeaks)
Used to identify regions of enrichment from Tag Directories.
- **Create Tag Directory**: `makeTagDirectory <DirectoryName> <alignment.sam/bam>`
- **Call Peaks (ChIP-Seq)**: `findPeaks <TagDir> -style factor -o auto -i <ControlTagDir>`
- **Call Histone Marks**: Use `-style histone` for broader enrichment patterns.
- **Quantification**: Use `analyzeRepeats.pl` to create a count matrix for differential expression or binding analysis.

### 3. Genomic Annotation (annotatePeaks.pl)
Assigns peaks to the nearest gene and provides genomic context (intron, exon, promoter, etc.).
- **Basic Annotation**: `annotatePeaks.pl <peaks.bed> <genome> > <output.txt>`
- **Gene Ontology**: Add `-go <output_dir>` to perform functional enrichment analysis on the genes associated with the peaks.
- **Motif Scanning**: Use `-m <motif_file>` to find specific motif occurrences within your peak set.

### 4. Hi-C and Chromatin Interaction
HOMER includes specialized routines for processing Hi-C data.
- **Interaction Matrix**: `analyzeHiC <TagDir> -res 1000000 -coverageNorm`
- **TAD Calling**: Use `findTADsAndLoops.pl` to identify topological domains.

## Expert Tips
- **Memory Management**: When working with large Hi-C datasets or high-resolution genomes, ensure your environment has sufficient RAM, as HOMER loads significant portions of the genome into memory for certain operations.
- **Genome Installation**: Before running genome-specific commands, ensure the genome is configured via `perl /path/to/homer/configureHomer.pl -install <genome_name>` (e.g., hg38, mm10).
- **Custom Motifs**: You can combine known motifs with de novo results by pointing to custom `.motif` files using the `-m` or `-find` flags in annotation and discovery scripts.

## Reference documentation
- [Homer Software and Data Download](./references/homer_ucsd_edu_homer_index.html.md)
- [bioconda / homer Overview](./references/anaconda_org_channels_bioconda_packages_homer_overview.md)