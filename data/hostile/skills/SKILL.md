---
name: hostile
description: Hostile decontaminates (meta)genomic datasets by identifying and removing reads that align to a host reference genome. Use when user asks to remove host contamination from sequencing data, decontaminate short or long reads, or mask human genetic information for privacy.
homepage: https://github.com/bede/hostile
---


# hostile

## Overview
Hostile is a specialized tool for decontaminating (meta)genomic datasets by identifying and removing reads that align to a host reference genome. It utilizes high-performance aligners—Bowtie2 for short reads and Minimap2 for long reads—to process data efficiently. This skill should be used during the preprocessing stage of bioinformatics workflows, especially when working with clinical samples where human DNA contamination is prevalent, or when privacy concerns require the removal of host genetic information.

## Installation
The recommended way to install Hostile is via Conda/Mamba to ensure all non-Python dependencies (Bowtie2, Minimap2, Samtools, Bedtools) are correctly configured:
```bash
conda create -y -n hostile -c conda-forge -c bioconda hostile
conda activate hostile
```

## Common CLI Patterns

### Decontaminating Long Reads (ONT)
By default, Hostile uses Minimap2 for long reads.
```bash
# Basic decontamination (creates long.clean.fastq.gz)
hostile clean --fastq1 long.fastq.gz

# Using a specific index (e.g., Mouse)
hostile clean --fastq1 long.fastq.gz --index mouse-mm39
```

### Decontaminating Short Reads (Illumina)
For short reads, Hostile defaults to Bowtie2.
```bash
# Paired-end reads
hostile clean --fastq1 short_R1.fastq.gz --fastq2 short_R2.fastq.gz

# Single-end or unpaired reads
hostile clean --fastq1 short.fastq.gz --aligner bowtie2
```

### Handling Streams (Piping)
Hostile supports stdin and stdout for integration into larger command-line pipes.
```bash
# Read from stdin
cat reads.fastq | hostile clean --fastq1 -

# Write to stdout (uncompressed)
hostile clean --fastq1 reads.fastq.gz -o - > clean.fastq
```

### Privacy and Optimization
- **Privacy**: Use `--rename` to replace read headers with integers, reducing file size and removing potential metadata.
- **Performance**: Use `-t` or `--threads` to specify alignment threads (default is 8).
- **Inversion**: Use `--invert` to keep only the host reads and discard the microbial reads (useful for host-only studies).

## Index Management
Hostile automatically downloads the `human-t2t-hla` index on first run, but you can manage indexes manually to save time or work offline.

- **List available standard indexes**: `hostile index list`
- **Pre-fetch an index**: `hostile index fetch --name human-t2t-hla-argos985`
- **Custom Indexes**: 
  - For Minimap2: Provide the path to a FASTA or `.mmi` file: `--index path/to/genome.fa`
  - For Bowtie2: Provide the path to the index prefix: `--index path/to/bt2-index-name`

## Best Practices
- **Microbial Retention**: If your research involves pathogens that might be similar to the host, use a "masked" index (e.g., `human-t2t-hla-argos985`) which prevents the removal of known bacterial or viral sequences.
- **Memory Requirements**: Ensure your environment has at least 4GB of RAM for short reads (Bowtie2) and 13GB for long reads (Minimap2).
- **Storage**: Set the `HOSTILE_CACHE_DIR` environment variable if you need to store large index files on a specific drive or shared partition.

## Reference documentation
- [Hostile GitHub Repository](./references/github_com_bede_hostile.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hostile_overview.md)