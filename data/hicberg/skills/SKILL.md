---
name: hicberg
description: hicberg transforms raw sequencing reads into high-quality genomic contact maps through a unified pipeline of alignment, filtering, and normalization. Use when user asks to process Hi-C data, generate COOL format matrices from FASTQ files, or reconstruct genomic contact data.
homepage: https://github.com/sebgra/hicberg
metadata:
  docker_image: "quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0"
---

# hicberg

## Overview

hicberg is a bioinformatics tool designed for the statistical profiling and reconstruction of genomic contact data. It provides a streamlined workflow to transform raw sequencing reads into high-quality contact maps. By integrating alignment, filtering, and normalization into a unified pipeline, hicberg allows researchers to move from FASTQ files to COOL format matrices with a single command. It is particularly effective for handling various Hi-C protocols and restriction enzyme configurations, offering a robust statistical framework for data reconstruction.

## Installation and Environment

To ensure all functional dependencies are met, install hicberg along with its required alignment and processing tools via Mamba or Conda:

```bash
mamba install -c bioconda hicberg bowtie2 samtools bedtools ucsc-bedgraphtobigwig
```

For users preferring alternative aligners, `bwa` or `minimap2` should also be installed in the environment.

## Core Pipeline Usage

The primary interface for the tool is the `hicberg pipeline` command. It handles the process from raw reads to the final matrix.

### Basic Command Structure
```bash
hicberg pipeline [options] <genome.fa> <forward_reads.fq> <reverse_reads.fq>
```

### Common CLI Patterns

*   **Standard Hi-C Run (e.g., ARIMA kit):**
    Use multiple `-e` flags to specify the restriction enzymes used in the experiment.
    ```bash
    hicberg pipeline -e DpnII -e HinfI --cpus 8 -o output_dir/ genome.fa R1.fq R2.fq
    ```

*   **Adjusting Resolution:**
    Control the bin size of the resulting contact matrix using the `--bins` parameter (default is 2000 bp).
    ```bash
    hicberg pipeline --bins 5000 -o output_5kb/ genome.fa R1.fq R2.fq
    ```

*   **Aligner Selection and Sensitivity:**
    Switch between aligners and set sensitivity levels for the mapping phase.
    ```bash
    hicberg pipeline --aligner bwa --sensitivity very-sensitive -o bwa_out/ genome.fa R1.fq R2.fq
    ```

## Expert Tips and Best Practices

*   **Filtering Quality:** The default Mapping Quality (`--mapq`) is set to 35. For highly repetitive genomes, you may need to adjust this to balance between data volume and alignment reliability.
*   **Circular Genomes:** When working with bacterial genomes or organelles, always specify the circular chromosomes using the `--circular` flag to avoid artifacts at the sequence edges.
*   **Stage Management:** Use `--start-stage` and `--exit-stage` to resume interrupted runs or to perform only specific parts of the pipeline (e.g., stopping after alignment to inspect BAM files).
*   **Resource Allocation:** Always specify `--cpus` to match your environment; the alignment phase is the most computationally intensive part of the workflow.
*   **Blacklisting:** For organisms with known assembly issues or highly repetitive regions that cause artifacts, provide a BED file to the `--blacklist` argument to improve reconstruction quality.



## Subcommands

| Command | Description |
|---------|-------------|
| hicberg alignment | Perform alignment of Hi-C reads. |
| hicberg benchmark | Perform benchmarking of the statistical model (this can be time consuming). |
| hicberg build-matrix | Create matrix (.cool) from pairs files. |
| hicberg build-pairs | Create pair files from a pair of alignment files. |
| hicberg chunk | Chunk provided inputs in a desired number of pieces. |
| hicberg classify | Perform classification of Hi-C reads (pairs). 3 groups wil be defined and 2 alignment files (.bam) will be created per group: |
| hicberg create-folder | Create a folder to save results. Folder will be set as <output>/<name>. |
| hicberg pipeline | Hi-C pipeline to generate enhanced contact matrix from fastq files. |
| hicberg plot | Plot results from analysis. |
| hicberg rescue | Reallocate ambiguous reads to the most plausible position according to   model. |
| hicberg statistics | Extract statistics from non ambiguous Hi-C data. |
| hicberg tidy | Tidy output folder. |
| hicberg_get-tables | Create tables for the genome length detail and the bins. |

## Reference documentation
- [hicberg - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_hicberg_overview.md)
- [GitHub - sebgra/hicberg: Statistical profiling based program for contact (Hi-C) and pair ended genomic data reconstruction](./references/github_com_sebgra_hicberg.md)