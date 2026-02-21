---
name: amaranth-assembler
description: Amaranth is a specialized transcriptome assembler built upon the Scallop2 framework, specifically tuned to handle the nuances of single-cell RNA-seq datasets.
homepage: https://github.com/Shao-Group/amaranth
---

# amaranth-assembler

## Overview
Amaranth is a specialized transcriptome assembler built upon the Scallop2 framework, specifically tuned to handle the nuances of single-cell RNA-seq datasets. It excels at reconstructing high-quality transcripts from reference-aligned BAM files. Use this skill to navigate installation via modern package managers like Pixi or Mamba and to execute assembly commands for single-cell research workflows.

## Installation Patterns

### Pixi (Recommended)
Pixi is the preferred method for fast, reproducible installation.
```bash
# Initialize project and add channels
pixi init . --channel conda-forge --channel bioconda

# Install the assembler
pixi add bioconda::amaranth-assembler

# Run via pixi
pixi run amaranth -i input.bam -o output.gtf
```

### Mamba/Micromamba
Use Mamba for faster environment resolution compared to standard Conda.
```bash
# Create environment
micromamba create -n amaranth_env -c conda-forge -c bioconda amaranth-assembler

# Activate and run
micromamba activate amaranth_env
amaranth -i input.bam -o output.gtf
```

### Docker
For containerized environments, use the BioContainers image.
```bash
docker pull quay.io/biocontainers/amaranth-assembler:0.1.0--h5ca1c30_0
```

## Core CLI Usage

### Basic Assembly
The primary workflow requires a coordinate-sorted BAM file as input.
```bash
amaranth -i <input.bam> -o <output.gtf>
```

### Verification
To verify the installation and view all available algorithmic parameters:
```bash
amaranth --help
```

## Expert Tips and Best Practices
- **Input Preparation**: Ensure your BAM files are coordinate-sorted and indexed. Amaranth, like its predecessor Scallop, relies on the spatial arrangement of reads to build splice graphs.
- **Single-Cell Optimization**: Amaranth is specifically optimized for scRNA-seq. If working with multi-cell data or standard bulk RNA-seq, consider if Scallop2 might be more appropriate, though Amaranth retains the core strengths of the Scallop series.
- **Environment Management**: Avoid installing Amaranth in a heavily populated base Conda environment. Use a fresh environment or Pixi to prevent dependency conflicts and slow solve times.
- **Resource Allocation**: Transcriptome assembly can be memory-intensive depending on the depth of the single-cell library. Ensure your environment has sufficient RAM for building splice graphs from high-coverage regions.

## Reference documentation
- [Amaranth GitHub Repository](./references/github_com_Shao-Group_amaranth.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_amaranth-assembler_overview.md)