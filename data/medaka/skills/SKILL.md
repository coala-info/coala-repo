---
name: medaka
description: Medaka creates consensus sequences and identifies variants from Nanopore sequencing data using neural networks applied to basecalled reads. Use when user asks to polish a draft assembly, generate consensus sequences, or call variants from Nanopore data.
homepage: https://github.com/nanoporetech/medaka
metadata:
  docker_image: "quay.io/biocontainers/medaka:2.2.0--py311h1d3aea1_0"
---

# medaka

## Overview

Medaka is a suite of tools designed to create consensus sequences and identify variants from Nanopore sequencing data. Unlike signal-based polishers, Medaka operates on basecalled data (FASTA or FASTQ), making it significantly faster while maintaining high accuracy. It applies neural networks to a pileup of reads against a reference or draft assembly to correct errors and refine the sequence.

## Installation and Setup

Medaka is best installed via `conda` to ensure all dependencies (samtools, minimap2, tabix, bgzip) are correctly bundled:

```bash
conda create -n medaka -c conda-forge -c nanoporetech -c bioconda medaka
conda activate medaka
```

For GPU acceleration, ensure the environment has access to NVIDIA CUDA libraries. If running on a CPU-only system, use `pip install medaka-cpu`.

## Common CLI Patterns

### 1. Generating Consensus (Polishing)
The primary workflow for polishing a draft assembly involves the `medaka_consensus` command.

```bash
medaka_consensus -i basecalls.fastq -d draft_assembly.fasta -o output_dir -t 8
```
- `-i`: Input basecalled reads (FASTQ or FASTA).
- `-d`: The draft assembly to be polished.
- `-o`: Output directory (results saved as `consensus.fasta`).
- `-t`: Number of CPU threads.

### 2. Variant Calling
For identifying variants in haploid samples:

```bash
medaka_variant -i reads.fastq -r reference.fasta -o variant_output
```

### 3. GPU Optimization
If encountering "Out of Memory" errors on a GPU, reduce the inference batch size using the `-b` flag. A value of 100 is typically safe for 11GB GPUs.

```bash
medaka_consensus -i reads.fastq -d draft.fasta -o out -b 100
```

## Expert Tips and Best Practices

- **Model Selection**: Accuracy depends heavily on using the correct model for your data. Models are specific to the flowcell (e.g., R9.4.1, R10.4.1), kit, and basecaller version used. Use `medaka tools list_models` to see available options.
- **Input Quality**: Medaka is a polisher, not an assembler. For the best results, start with a high-quality draft assembly from tools like Flye.
- **Region-Specific Polishing**: If you only need to polish specific genomic regions, use the `-r` (region) string or a BED file to save time and compute resources.
- **Memory Management**: When running on large genomes (e.g., Human), ensure sufficient RAM is available for the pileup stage, or process the genome in chunks using the region arguments.

## Reference documentation
- [Medaka GitHub Repository](./references/github_com_nanoporetech_medaka.md)
- [Bioconda Medaka Overview](./references/anaconda_org_channels_bioconda_packages_medaka_overview.md)