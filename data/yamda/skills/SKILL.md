---
name: yamda
description: YAMDA (Yet Another Motif Discovery Algorithm) is a specialized bioinformatics tool designed for the high-throughput identification of sequence motifs.
homepage: https://github.com/daquang/YAMDA
---

# yamda

## Overview
YAMDA (Yet Another Motif Discovery Algorithm) is a specialized bioinformatics tool designed for the high-throughput identification of sequence motifs. Unlike traditional motif discovery tools that can be computationally bottlenecked by large datasets, YAMDA leverages deep learning libraries—specifically PyTorch—to offload intensive Expectation-Maximization (EM) calculations to the GPU. This allows for a thousandfold speedup in processing thousands of sequences, making it an ideal choice for modern genomic assays that produce vast amounts of data.

## Installation and Environment Setup
The most reliable way to deploy YAMDA is via Conda or Docker to ensure all PyTorch and Python dependencies are correctly versioned.

### Conda Installation
```bash
conda install bioconda::yamda
```

### Manual Environment Setup
If installing from source, create a dedicated environment to manage the specific Python 3.6 and PyTorch 1.0 requirements:
```bash
conda create -n YAMDA-env python=3.6.5 numpy=1.13.3 scipy=0.19.1 pyfaidx tqdm pytorch torchvision -c pytorch
source activate YAMDA-env
```

## Core Workflow and CLI Usage
The YAMDA workflow typically involves sequence preprocessing followed by the core motif discovery execution.

### 1. Sequence Preprocessing
Before running motif discovery, it is critical to clean the input FASTA files. YAMDA provides a utility to remove sequences that may cause errors during the EM process (e.g., sequences with excessive Ns or invalid characters).
- **Script**: `erase_annoying_sequences.py`
- **Action**: Run this on your raw FASTA file before passing it to the discovery engine.

### 2. Motif Discovery Execution
The primary entry point for discovery is `run_em.py`. 
- **Execution**: `python run_em.py [options]`
- **Hardware**: By default, the tool will attempt to use a GPU if available via PyTorch. Ensure `CUDA_VISIBLE_DEVICES` is set correctly in multi-GPU environments.
- **Input**: Requires a FASTA file of sequences (e.g., centered ChIP-seq peaks).

### 3. Working with Genomic Intervals
For ChIP-seq or DGF (Digital Genomic Footprinting) data, use `bedtools` or `pyfaidx` to prepare your sequences:
- Extract sequences from a genome FASTA using BED coordinates of peaks.
- Ensure the genome FASTA is indexed (`samtools faidx`).

## Expert Tips and Best Practices
- **GPU Memory Management**: When working with very long sequences or extremely large batches, monitor GPU VRAM. YAMDA is optimized for scalability, but the PyTorch backend's memory usage scales with sequence length and batch size.
- **Protein Sequences**: While primarily used for DNA, YAMDA has specific handling for protein sequences. Ensure your input alphabet is correctly specified if working with peptides.
- **Negative Controls**: For robust motif discovery, use the `fasta-shuffle-letters` utility from the MEME suite (an optional dependency) to generate shuffled control sequences to validate the significance of discovered motifs.
- **Docker Deployment**: For reproducible research, use the provided Dockerfile.
  ```bash
  make yamda-dock
  sudo docker run -it yamda-dock bash
  source activate YAMDA-env
  ```

## Reference documentation
- [YAMDA GitHub Repository](./references/github_com_daquang_YAMDA.md)
- [Bioconda YAMDA Package Overview](./references/anaconda_org_channels_bioconda_packages_yamda_overview.md)