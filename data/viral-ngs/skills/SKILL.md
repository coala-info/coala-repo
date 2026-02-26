---
name: viral-ngs
description: viral-ngs is a comprehensive suite of bioinformatics tools designed for viral genomics, streamlining analysis from raw sequencing reads to polished assemblies and phylogenetic trees. Use when user asks to process reads, assemble viral genomes, perform metagenomic classification, or analyze phylogenetics and variation.
homepage: https://github.com/broadinstitute/viral-ngs
---


# viral-ngs

## Overview

viral-ngs is a comprehensive suite of bioinformatics tools and wrappers designed specifically for viral genomics. It streamlines the transition from raw sequencing reads to polished assemblies and phylogenetic trees by integrating numerous specialized tools (like SPAdes, Kraken2, and LoFreq) into a consistent environment. Use this skill to determine the appropriate tool modules for specific analysis stages and to execute commands via the recommended Docker-based workflow.

## Core Execution Patterns

The primary and recommended method for using viral-ngs is through Docker to ensure all complex bioinformatics dependencies are correctly configured.

### Docker Execution Template
To run any viral-ngs tool, use the following pattern to mount your local data into the container:

```bash
docker run -it --rm -v $(pwd)/data:/data quay.io/broadinstitute/viral-ngs:[tag] [command]
```

### Selecting the Right Image Tag
To minimize download size and memory overhead, use the specialized image corresponding to your task:
- `core`: Basic read manipulation, Illumina demultiplexing, and file handling.
- `assemble`: Genome assembly, scaffolding, and gap filling.
- `classify`: Metagenomic classification and taxonomic filtering.
- `phylo`: Variant calling, consensus generation, and annotation.
- `latest`: The "mega" image containing all tools.

## Functional Modules and Tools

### 1. Read Processing (Core)
Use the `core` module for initial data handling and quality control.
- **Tools**: `read_utils`, `samtools` wrappers.
- **Common Tasks**: Converting formats (BAM/Fastq), cleaning reads, and demultiplexing Illumina runs.

### 2. Assembly
Use the `assemble` module to reconstruct viral genomes.
- **Wrapped Tools**: SPAdes (assembly), MUMmer (scaffolding), MAFFT (alignment).
- **Workflow**: Perform de novo assembly followed by scaffolding against a reference genome to fill gaps.

### 3. Metagenomic Classification
Use the `classify` module to identify viral species or filter out host contamination.
- **Wrapped Tools**: Kraken2, BLAST, BMTagger.
- **Workflow**: Run Kraken2 for rapid taxonomic assignment of raw reads to identify the viral content in a sample.

### 4. Phylogenetics and Variation
Use the `phylo` module for downstream analysis of assembled genomes.
- **Wrapped Tools**: LoFreq (variant calling), SnpEff (annotation), MUSCLE (alignment).
- **Workflow**: Call variants from mapped reads to generate a consensus sequence and annotate functional impacts of mutations.

## Expert Tips and Best Practices

- **Data Persistence**: Always use the `-v` flag in Docker to mount a local directory. viral-ngs tools inside the container should read from and write to the mounted path (e.g., `/data/input.bam`) to ensure results are saved to your host machine.
- **Architecture Support**: viral-ngs supports both `linux/amd64` and `linux/arm64`. If you are on Apple Silicon (M1/M2/M3), the images will run natively, though specific x86-only tools like `novoalign` or `mvicuna` will be automatically skipped.
- **Environment Verification**: Before starting a long-running pipeline, verify the tool version and environment:
  ```bash
  docker run --rm quay.io/broadinstitute/viral-ngs:core read_utils --version
  ```
- **Development and Testing**: If modifying the tools, use the `main-core` or `main-assemble` tags to access the most recent builds from the repository's primary branch.

## Reference documentation
- [viral-ngs Main Repository](./references/github_com_broadinstitute_viral-ngs.md)