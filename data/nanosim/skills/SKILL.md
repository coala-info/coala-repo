---
name: nanosim
description: NanoSim is a high-performance read simulator designed to replicate the specific error profiles and characteristics of Oxford Nanopore sequencing data. Use when user asks to simulate ONT genomic reads, characterize error profiles from training datasets, or generate synthetic transcriptome and metagenome sequences.
homepage: https://github.com/bcgsc/NanoSim
---


# nanosim

## Overview

NanoSim is a high-performance read simulator designed to replicate the specific characteristics of Oxford Nanopore sequencing. Unlike general-purpose simulators, NanoSim uses a two-stage process: it first "learns" the error profiles, length distributions, and quality scores from a provided training dataset (Characterization), and then applies these statistical models to a reference sequence to generate synthetic reads (Simulation). It supports a wide range of biological contexts, including genomic DNA, cDNA, direct RNA, and complex metagenomic communities.

## Installation

The most reliable way to install NanoSim and its dependencies (including `minimap2`, `samtools`, and `HTSeq`) is via Bioconda:

```bash
conda install -c bioconda nanosim
```

**Note on Scikit-learn**: If using pre-trained models provided by the developers (v3.0.2 and earlier), ensure `scikit-learn==0.22.1` is installed to avoid compatibility errors regarding `sklearn.neighbors.kde`.

## Core Workflow

### 1. Characterization Stage
Before simulation, you must profile real ONT data to create a model. This stage aligns reads to a reference and builds statistical distributions of errors.

*   **Script**: `read_analysis.py`
*   **Key Inputs**: 
    *   `-i`: Input FASTQ/FASTA reads.
    *   `-r`: Reference genome/transcriptome.
    *   `-t`: Number of threads.
*   **Output**: A set of model files (prefixed) used for the simulation stage.

### 2. Simulation Stage
Generate synthetic reads using the models created in the characterization stage or using pre-trained models.

*   **Script**: `simulator.py`
*   **Common Modes**:
    *   `genome`: For standard genomic DNA simulation.
    *   `transcriptome`: For cDNA or direct RNA, modeling intron retention and expression levels.
    *   `metagenome`: For multi-species communities with varying abundance.

## Common CLI Patterns

### Genomic Simulation
To simulate genomic reads with a specific coverage:
```bash
python simulator.py genome -rg reference.fasta -c model_prefix -o output_dir --coverage 30
```

### Transcriptome Simulation
To simulate RNA-seq data, providing an expression profile:
```bash
python simulator.py transcriptome -rt reference_transcriptome.fasta -c model_prefix -e expression_profile.txt -o output_dir
```

### Metagenome Simulation
To simulate a community with specific abundance levels:
```bash
python simulator.py metagenome -rg reference_list.txt -c model_prefix -a abundance_list.txt -o output_dir
```

## Expert Tips and Best Practices

*   **Model Selection**: Always match the model to your chemistry and basecaller. A model trained on R9.4 Guppy data will not accurately simulate R10.4 Dorado data.
*   **Homopolymer Simulation**: Use the `--homopolymer` option to simulate expansion and contraction events, which are common artifacts in Nanopore sequencing.
*   **Chimeric Reads**: In `genome` or `metagenome` modes, NanoSim can simulate chimeric reads (joined fragments). Ensure your training data includes these if you want them represented in the output.
*   **Memory Management**: For large metagenomic simulations or human-scale genomes, ensure sufficient RAM is available for `minimap2` during the characterization phase.
*   **Fastq Output**: Use the `--fastq` flag in newer versions (v2.6+) to generate reads with simulated base qualities (represented as truncated log-normal distributions).

## Reference documentation

- [NanoSim GitHub Repository](./references/github_com_bcgsc_NanoSim.md)
- [Bioconda NanoSim Overview](./references/anaconda_org_channels_bioconda_packages_nanosim_overview.md)