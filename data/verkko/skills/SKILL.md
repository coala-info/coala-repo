---
name: verkko
description: Verkko automates the generation of phased, diploid, and telomere-to-telomere genome assemblies. Use when user asks to generate genome assemblies, integrate phasing data (Trio, Hi-C, or Pore-C), specify telomere motifs, or perform reference-guided scaffolding.
homepage: https://github.com/marbl/verkko
---


# verkko

## Overview

Verkko is a sophisticated assembly pipeline that automates the generation of phased, diploid, and telomere-to-telomere genome assemblies. It functions by constructing a multiplex de Bruijn graph from accurate long reads and then using ultra-long reads to resolve loops and tangles within that graph. This skill provides the necessary command-line patterns for initializing assemblies, integrating phasing data (Trio, Hi-C, or Pore-C), and fine-tuning scaffolding parameters for non-model organisms.

## Installation and Setup

Install verkko via Bioconda to ensure all dependencies (Snakemake, MBG, GraphAligner, etc.) are correctly configured:

```bash
conda create -n verkko -c conda-forge -c bioconda -c defaults verkko
conda activate verkko
```

## Core Assembly Workflows

### Basic Hybrid Assembly
To run a standard assembly with HiFi and ONT ultra-long reads:

```bash
verkko -d <work-directory> --hifi <hifi-reads.fastq.gz> --nano <ont-ul-reads.fastq.gz>
```

### Trio Phasing
Trio-binning requires pre-computed meryl databases for maternal and paternal k-mers.

1. **Generate Hapmers**: Use the Merqury toolset to create `.meryl` hapmer databases from parental data.
2. **Run Verkko**:
```bash
verkko -d <work-directory> \
  --hifi <hifi-reads.fastq.gz> \
  --nano <ont-ul-reads.fastq.gz> \
  --hap-kmers <paternal.hapmer.meryl> <maternal.hapmer.meryl> trio
```

### Hi-C or Pore-C Phasing
For samples without parental data, use Hi-C or Pore-C for scaffolding and phasing.

*   **Hi-C**: `verkko -d <work-directory> --hifi <hifi.fq.gz> --nano <ont.fq.gz> --hic1 <R1.fq.gz> --hic2 <R2.fq.gz>`
*   **Pore-C**: `verkko -d <work-directory> --hifi <hifi.fq.gz> --nano <ont.fq.gz> --porec <porec.fq.gz>`

## Expert Configuration and Best Practices

### Handling Non-Vertebrate Species
Verkko defaults to the vertebrate telomeric repeat (CCCTAA). If assembling other taxa, specify the motif to improve telomere detection and scaffolding:

```bash
verkko -d <work-directory> --hifi <reads.fq.gz> --telomere-motif <MOTIF>
```

### Reference-Guided Scaffolding
You can provide a closely related genome to guide the scaffolding process. This is not a reference-based assembly; the reference only assists in resolving ambiguities in the diploid structure:

```bash
verkko -d <work-directory> --hifi <hifi.fq.gz> --ref <related_genome.fasta>
```

### Corrected ONT Simplex Reads
If using HERRO or Hifiasm corrected ONT simplex reads, treat the corrected reads as the high-accuracy input:
*   Provide corrected reads via `--hifi`.
*   Provide original uncorrected reads via `--nano`.

### Resource Management
Verkko is a Snakemake-based pipeline. To pass specific resource constraints or cluster configurations, you can often interact with the underlying Snakemake logic or use the wrapper's resource flags if available in the specific version.

## Reference documentation
- [Verkko GitHub Repository](./references/github_com_marbl_verkko.md)
- [Verkko Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_verkko_overview.md)