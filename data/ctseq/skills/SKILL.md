---
name: ctseq
description: ctseq is a bioinformatics pipeline that processes methylation patch PCR data to generate methylation profiles and visualizations. Use when user asks to analyze methylation patch PCR data, extract UMI sequences, align reads to PCR fragment references, or generate methylation density heatmaps.
homepage: https://github.com/ryanhmiller/ctseq
metadata:
  docker_image: "quay.io/biocontainers/ctseq:0.0.2--py_0"
---

# ctseq

## Overview

ctseq is a specialized bioinformatics pipeline designed to streamline the analysis of methylation patch PCR data. It transforms raw sequencing output into interpretable methylation profiles by automating the extraction of UMI sequences, trimming specific adapters, and aligning reads to a provided reference of PCR fragments. This tool is essential for researchers working with targeted methylation assays who need to account for molecular duplicates and visualize methylation density across specific genomic loci.

## CLI Usage and Patterns

The primary entry point for the pipeline is the `ctseq analyze` command.

### Core Analysis Command
To run a standard analysis, use the following structure:

```bash
ctseq analyze \
    --refDir /path/to/reference_folder \
    --dir /path/to/fastq_folder \
    --umiType [separate|inline] \
    --umiLength 12 \
    --forwardExt R1_001.fastq.gz \
    --reverseExt R3_001.fastq.gz \
    --umiExt R2_001.fastq.gz \
    --nameRun MyRunName \
    --processes 10
```

### Key Parameters
- `--refDir`: Path to the directory containing your `.fa` reference file.
- `--dir`: Path to the directory containing input fastq files.
- `--umiType`: Set to `separate` if UMIs are in a dedicated fastq file, or `inline` if they are part of the read header.
- `--forwardExt / --reverseExt`: The suffix used to identify forward and reverse read files (e.g., `_R1.fastq.gz`).
- `--cutadaptCores / --bismarkCores`: Use these to tune performance for specific steps of the pipeline.

## Data Preparation Best Practices

### 1. Reference Fasta Requirements
The pipeline requires specific adapter sequences to be manually appended to your target fragment sequences in the reference `.fa` file to ensure proper alignment and trimming:
- **Prefix**: `AGAGAATGAGGAAGGTGGGGAGT`
- **Suffix**: `AGTGTGGGAGGGTAGTTGGTGTT`

### 2. Fastq Naming Convention
Files must be named with the **Sample Name** first, followed by an underscore (`_`).
- **Correct**: `SampleA_L001_R1.fastq.gz`
- **Incorrect**: `Run01_SampleA_R1.fastq.gz` (This would treat 'Run01' as the sample name).

### 3. UMI Handling
- If UMIs are not in a separate file, they must be appended to the end of the read name in the fastq header (e.g., `@Header:UMI:N:0:Index`).
- Ensure read names are in the same order across forward, reverse, and UMI files.

### 4. Visualization Requirements
To generate heatmaps and molecule depth plots, provide a fragment info file (e.g., `fragInfo.txt`) containing:
- A `Fragment` column (matching the names in your `.fa` file).
- A `fragOrder` column (numeric) to define the display sequence in plots.

## Performance Tuning
- **Parallelization**: Use the `--processes` flag to define how many samples to process simultaneously.
- **Resource Allocation**: For high-depth data, increase `--cutadaptCores` (for trimming) and `--bismarkCores` (for alignment) to reduce bottlenecks in the most computationally intensive steps.



## Subcommands

| Command | Description |
|---------|-------------|
| ctseq analyze | Analyze sequencing data from ctseq. |
| ctseq call_methylation | Call methylation status for molecules. |
| ctseq call_molecules | Call methylation states for molecules based on UMIs and consensus threshold. |
| ctseq make_methyl_ref | Build a reference methylation genome. |
| ctseq plot_multiple | Create plots for multiple samples combined. |
| ctseq_add_umis | Add UMIs to fastq files. |
| ctseq_align | Aligns sequencing reads to a reference genome and prepares methylation calls. |
| ctseq_plot | Generate plots from CT-seq data. |

## Reference documentation
- [Main README and Usage Guide](./references/github_com_ryanhmiller_ctseq_blob_master_README.md)
- [Environment and Dependency Specifications](./references/github_com_ryanhmiller_ctseq_blob_master_Dockerfile.md)