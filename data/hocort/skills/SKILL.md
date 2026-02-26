---
name: hocort
description: HoCoRT automates the removal of host contamination from sequencing data by mapping reads against a reference genome. Use when user asks to remove host DNA from FastQ files, filter contaminant sequences, or extract specific organism reads using various bioinformatic aligners.
homepage: https://github.com/ignasrum/hocort
---


# hocort

## Overview

HoCoRT (Host Contamination Removal Tool) is a specialized wrapper designed to simplify the process of cleaning sequencing data. It automates the workflow of mapping reads against a reference genome and separating the "contaminant" (host) sequences from the sequences of interest. It is particularly useful in microbiome research to ensure human DNA is removed before analysis or public release. The tool supports both single-end and paired-end FastQ files, handles compressed inputs automatically, and allows for fine-tuned control over underlying bioinformatic aligners.

## Installation and Setup

HoCoRT is best managed via Conda to handle its numerous dependencies (Bowtie2, HISAT2, Kraken2, etc.).

```bash
# Create a dedicated environment to avoid dependency conflicts
conda create -n hocort -c conda-forge -c bioconda hocort
conda activate hocort
```

## Common CLI Patterns

### 1. Building an Index
Before filtering, you must build an index for the organism(s) you wish to remove. If removing multiple organisms, concatenate their FASTA files first.

```bash
# Combine multiple genomes if necessary
cat human_chr1.fasta human_chr2.fasta > combined_host.fasta

# Build the index (example using bowtie2)
hocort index bowtie2 --input combined_host.fasta --output indexes/host_idx
```

### 2. Removing Host Contamination (Filtering)
To remove reads that match the index, set `--filter true`. This outputs only the unmapped reads.

```bash
# Paired-end filtering with Bowtie2
hocort map bowtie2 -x indexes/host_idx -i input_R1.fastq.gz input_R2.fastq.gz -o clean_R1.fastq.gz clean_R2.fastq.gz --filter true

# Single-end filtering
hocort map bowtie2 -x indexes/host_idx -i input.fastq -o clean.fastq --filter true
```

### 3. Extracting Specific Organisms
To keep only the reads that match the index (e.g., extracting specific viral reads from a sample), set `--filter false`.

```bash
hocort map bowtie2 -x indexes/target_idx -i input.fastq -o target_only.fastq --filter false
```

## Expert Tips and Best Practices

- **Pipeline Selection**: Choose the underlying tool based on your needs:
  - `bowtie2` or `hisat2`: Standard for high-accuracy mapping.
  - `kraken2`: Fast classification-based filtering.
  - `minimap2`: Preferred for long-read data (Oxford Nanopore/PacBio).
  - `kraken2bowtie2`: A hybrid pipeline for increased sensitivity.
- **Passing Native Arguments**: Use the `-c` or `--config` flag to pass specific parameters directly to the underlying tool.
  ```bash
  # Example: Using Bowtie2's local alignment mode for higher sensitivity
  hocort map bowtie2 -x idx -i in.fq -o out.fq -c="--local --very-fast-local"
  ```
- **Compression**: HoCoRT detects `.gz` extensions automatically. Always use compressed formats for large sequencing datasets to save disk space and I/O time.
- **Memory Management**: Some aligners (like Kraken2 with large databases) require significant RAM. Ensure your environment has sufficient resources before starting the mapping process.

## Reference documentation
- [HoCoRT GitHub README](./references/github_com_ignasrum_hocort.md)
- [HoCoRT Wiki](./references/github_com_ignasrum_hocort_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hocort_overview.md)