---
name: vulcan
description: "Vulcan is a long-read mapping pipeline that melds two popular aligners: minimap2 and NGMLR."
homepage: https://gitlab.com/treangenlab/vulcan
---

# vulcan

## Overview

Vulcan is a long-read mapping pipeline that melds two popular aligners: minimap2 and NGMLR. It is designed to "map long reads and prosper" by leveraging the strengths of both tools to improve alignment accuracy, particularly in the context of structural variant (SV) detection. Use this skill when you need to process noisy long-read data (FASTQ) against a reference genome (FASTA) and require a more robust alignment than a single tool might provide.

## Installation

Vulcan is primarily distributed via Bioconda:

```bash
conda install -c bioconda vulcan
```

## Common CLI Patterns

### Basic Alignment
The most common usage involves specifying the reference, input reads, and an output prefix.

```bash
vulcan -r reference.fasta -i reads.fastq -o output_prefix
```

### Full Command Specification
For production runs, it is recommended to specify threads and a dedicated working directory to manage intermediate files.

```bash
vulcan -r /path/to/ref.fa \
       -i /path/to/reads.fastq \
       -w ./vulcan_work_dir/ \
       -o ./results/sample_name \
       -t 16 \
       -ont
```

### Key Arguments
- `-i`: Input FASTQ file(s). Supports wildcards (e.g., `path/to/*.fastq`).
- `-r`: Reference genome in FASTA format.
- `-o`: Output file name or prefix.
- `-w`: Working directory for intermediate files (minimap2 and NGMLR temporary outputs).
- `-t`: Number of threads/CPU cores to use.
- `-ont`: Use Oxford Nanopore technology presets.
- `-pacbio`: Use PacBio technology presets.

## Expert Tips and Best Practices

### Technology Presets
Always specify the sequencing technology flag (`-ont` or `-pacbio`). This ensures that the underlying calls to `minimap2` (e.g., `-ax map-ont`) and `ngmlr` (e.g., `-x ont`) use the correct error models and alignment parameters.

### Handling Large Input Sets
If you have thousands of small FASTQ files (common in some Nanopore runs), Vulcan may occasionally encounter issues with very large file lists. If you encounter errors when passing thousands of files via wildcards, consider concatenating them into a single FASTQ file or a few larger batches before running Vulcan.

### Large Reference Genomes
When working with large reference genomes (e.g., >4GB like certain plant genomes), ensure your system has significant RAM. Vulcan relies on `minimap2` for the initial mapping phase; for a 5GB genome, you may need 64GB-100GB of RAM depending on the indexing parameters.

### Customizing Underlying Tools
Vulcan supports a custom command mode if you need to pass specific, non-standard arguments to the underlying aligners.
- Use the `--custom_cmd` flag to trigger an interactive prompt or configuration for specific `minimap2` and `ngmlr` parameters.

### Resource Management
The working directory (`-w`) can accumulate significant data during the alignment process. Ensure the partition hosting the working directory has at least 2-3x the space of your input FASTQ files to accommodate intermediate SAM/BAM files before they are merged and cleaned.

## Reference documentation
- [Vulcan Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vulcan_overview.md)
- [Vulcan GitLab README](./references/gitlab_com_treangenlab_vulcan_-_blob_master_README.md)