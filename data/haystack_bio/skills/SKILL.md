---
name: haystack_bio
description: Haystack identifies epigenetic variability hotspots and enriched transcription factor motifs by integrating DNA sequence, epigenomic signals, and transcriptomic data. Use when user asks to identify chromatin variability across cell types, find enriched TF motifs in genomic regions, or correlate motif presence with gene expression.
homepage: https://github.com/rfarouni/haystack_bio
metadata:
  docker_image: "quay.io/biocontainers/haystack_bio:0.5.5--0"
---

# haystack_bio

## Overview
Haystack is a specialized bioinformatics suite used to study the plasticity of chromatin states and the regulatory logic of cellular identity. By integrating DNA sequence, epigenomic signals, and transcriptomic data, it identifies "hotspots" of epigenetic variability across different cell types. The tool then highlights enriched TF motifs within these variable regions to provide mechanistic insights into gene regulation and chromatin structure.

## Installation and Environment
Haystack is implemented in Python 2.7. Because many modern environments use Python 3, it is best managed via a dedicated Conda environment.

- **Conda Setup**:
  ```bash
  conda create -n haystack_env python=2.7
  conda activate haystack_env
  conda config --add channels defaults
  conda config --add channels conda-forge
  conda config --add channels bioconda
  conda install haystack_bio
  ```
- **Docker**: For Windows users or those avoiding Python 2.7 dependency issues, use the official Docker image provided in the repository.

## Core Workflow and CLI Patterns

### 1. Genome Preparation
Before running analysis, you must download the required reference genome data.
- **Command**: `haystack_download_genome <genome_build>`
- **Example**: `haystack_download_genome hg19`
- **Note**: Genomes are stored by default in your site-packages directory under `haystack/haystack_data/genomes`. Ensure you have sufficient disk space (approx. 800MB per genome).

### 2. Identifying Hotspots
The `haystack_hotspots` module identifies regions that vary significantly across different cell types or conditions.
- **Input**: Aligned data from ChIP-seq, DNase-seq, or ATAC-seq.
- **Usage**:
  ```bash
  haystack_hotspots --input_files file1.bam file2.bam --genome hg19 --output_dir ./hotspots_output
  ```

### 3. Motif Analysis
The `haystack_motifs` module identifies enriched transcription factor motifs within the variable regions or cell-type-specific regions identified in the previous step.
- **Functionality**: It calculates p-values, q-values, motif logos, and average profiles.

### 4. Integrated Pipeline
For a complete analysis from raw signals to TF activity, use the main pipeline wrapper.
- **Command**: `haystack_pipeline.py`
- **Integration**: If RNA-seq data is provided, the pipeline can quantify TF activity by correlating motif presence with the expression of nearby genes.

## Expert Tips and Best Practices
- **Verification**: Always run `haystack_run_test` after installation to ensure all dependencies (like MEME for motif analysis) are correctly configured.
- **Resource Management**: Use the `--n_processes` argument in supported scripts to enable multi-threading and speed up processing of large genomic datasets.
- **Blacklist Regions**: When running hotspot analysis, consider providing a "blacklist" of problematic genomic regions (e.g., high-signal artifacts) to improve the signal-to-noise ratio.
- **Output Interpretation**:
    - **Specificity (z-score)**: Indicates how unique a TF's expression is to a specific cell type.
    - **Effect (z-score)**: Indicates the impact of the TF on nearby gene expression.



## Subcommands

| Command | Description |
|---------|-------------|
| haystack_download_genome | download_genome parameters |
| haystack_hotspots | HAYSTACK Parameters |
| haystack_motifs | Haystack Motifs Parameters |

## Reference documentation
- [Haystack Bio Main Repository](./references/github_com_rfarouni_haystack_bio.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_haystack_bio_overview.md)