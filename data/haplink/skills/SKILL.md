---
name: haplink
description: haplink is a bioinformatics toolset used to identify genetic variants and reconstruct viral haplotypes using physical linkage information from sequencing reads. Use when user asks to identify single nucleotide variants, reconstruct viral haplotypes, or generate a consensus sequence for a dominant viral strain.
homepage: https://ksumngs.github.io/HapLink.jl
---


# haplink

## Overview
haplink is a bioinformatics toolset designed to identify genetic variants and reconstruct haplotypes in viral samples. Unlike tools that rely solely on frequency, haplink utilizes the physical linkage of mutations on individual sequencing reads to determine which variants co-occur. This approach provides a more accurate representation of the viral population's genetic structure, which is critical for studying evolution, drug resistance, and transmission dynamics.

## Installation and Setup
Install haplink via Bioconda for the most stable environment:
```bash
conda install bioconda::haplink
```

## Core Workflow and CLI Patterns

### 1. Variant Calling
Identify single nucleotide variants (SNVs) and indels from aligned reads. This step is a prerequisite for haplotype reconstruction.
```bash
haplink variants <reference.fasta> <sample.bam> --output <variants.vcf>
```
*   **Tip**: Ensure your BAM file is sorted and indexed (`samtools index`) before running.
*   **Quality Control**: Use the `--min-reads` or `--min-freq` flags to filter out low-confidence variants early in the process.

### 2. Haplotype Reconstruction
Reconstruct the viral haplotypes using the linkage information from the BAM file and the identified variants.
```bash
haplink haplotypes <reference.fasta> <sample.bam> <variants.vcf> --output <haplotypes.fasta>
```
*   **Linkage Analysis**: The tool analyzes overlapping reads to bridge variants. If variants are too far apart for the library's insert size, linkage cannot be established.

### 3. Consensus Generation
Generate a consensus sequence for the dominant viral strain in the sample.
```bash
haplink consensus <reference.fasta> <sample.bam> --output <consensus.fasta>
```

## Expert Tips and Best Practices
- **Coverage Requirements**: Linkage-based calling is sensitive to depth. Aim for high coverage (e.g., >1000x) to ensure enough overlapping reads exist between distant polymorphic sites.
- **Read Length Matters**: Longer reads or paired-end reads with significant overlap greatly improve the ability of haplink to resolve complex haplotypes.
- **Filtering Strategy**: When dealing with high-diversity samples, use a more stringent p-value threshold for variant calling to avoid incorporating sequencing errors into the reconstructed haplotypes.
- **Memory Management**: For very large BAM files, ensure you allocate sufficient memory, as linkage calculations across the entire genome can be computationally intensive.

## Reference documentation
- [haplink - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_haplink_overview.md)
- [HapLink.jl Documentation](./references/ksumngs_github_io_HapLink.jl.md)