---
name: bronko
description: bronko is a kmer-based bioinformatic tool used for rapid, alignment-free viral variant calling and iSNV detection from raw sequencing reads. Use when user asks to detect viral variants, identify intrahost single nucleotide variants, or generate VCF files without performing traditional read alignment.
homepage: https://github.com/treangenlab/bronko
---


# bronko

## Overview
bronko is a specialized bioinformatic tool designed for the rapid detection of viral variants without the computational overhead of traditional read alignment. By utilizing a kmer-based approach with small edit distances, it generates a "mapping-free" pileup to produce VCF files directly from raw reads and reference genomes. It is particularly effective for identifying intrahost single nucleotide variants (iSNVs) and handling datasets with high sequencing depth or numerous samples.

## Installation and Requirements
The most reliable way to install bronko is via Bioconda. It requires KMC3 as a dependency, which is automatically handled by the conda installation.

```bash
conda create -n bronko bioconda::bronko
conda activate bronko
```

## Core Workflows

### 1. Building a Reference Database
If you are working with multiple strains or want to allow bronko to automatically select the most appropriate reference for each sample, you should first build a database.

```bash
# Build a database from multiple FASTA files
bronko build -g /path/to/references/*.fa -o viral_db
```
*   **Expert Tip**: Use the `-k` parameter to adjust kmer size if dealing with highly divergent or extremely conserved regions (default is usually sufficient for most viral applications).
*   **Batch Input**: For large numbers of genomes, use `--file-input` with a text file containing paths to your FASTA files.

### 2. Variant Calling
You can perform variant calling using a pre-built database or by providing a single reference genome directly.

**Using a Database (Recommended for speed/accuracy):**
```bash
# Paired-end reads
bronko call -d viral_db.bkdb -1 sample_R1.fastq -2 sample_R2.fastq -o output_dir

# Single-end reads
bronko call -d viral_db.bkdb -r sample.fastq -o output_dir
```

**Using a Direct Genome (No pre-built index):**
```bash
bronko call -g reference.fasta -1 sample_R1.fastq -2 sample_R2.fastq -o output_dir
```

## Best Practices and Constraints

### Pre-processing Requirements
*   **Primer Removal**: You must remove primer sequences before running bronko. Because it is kmer-based, primer contamination will significantly bias variant calls and depth calculations.
*   **Quality Trimming**: Ensure base quality scores are high (Q > 25 or 30). bronko does not incorporate base quality scores during the kmer transformation process, so low-quality input will lead to false positive calls.

### Functional Limitations
*   **Indels**: Current versions of bronko do not report novel insertions or deletions. It is strictly optimized for SNPs and iSNVs.
*   **iSNV Interpretation**: While bronko is precise in identifying putative intrahost variants, users should manually validate biological relevance, as library preparation and PCR biases can affect kmer-based calling.

### Performance Optimization
*   **Thread Allocation**: bronko is highly parallelizable. Use the `-t` flag (if available in your version) or ensure your environment allows multi-threading to take advantage of its 10-1000x speed increase over traditional pipelines.
*   **Reference Selection**: When dealing with historical or evolving viral data, include multiple reference genomes in your `.bkdb`. bronko will automatically select the genome with the highest identity for each specific sample.

## Reference documentation
- [Main Repository and Usage](./references/github_com_treangenlab_bronko.md)
- [Installation and Versioning](./references/anaconda_org_channels_bioconda_packages_bronko_overview.md)
- [Wiki and Parameter Details](./references/github_com_treangenlab_bronko_wiki.md)