---
name: plass
description: PLASS performs de novo assembly of sequencing reads at the protein level to overcome high diversity and low coverage in metagenomic datasets. Use when user asks to assemble protein sequences from nucleotide reads, perform protein-guided nucleotide assembly, or reconstruct viral genomes and 16S rRNA sequences.
homepage: https://github.com/soedinglab/plass
---


# plass

## Overview

PLASS (Protein-Level ASSembler) is a specialized tool for de novo assembly of sequencing reads at the amino acid level. By translating reads into six frames and performing assembly in protein space, it overcomes the high diversity and low coverage issues that often cause traditional nucleotide assemblers to fail in metagenomic contexts. The toolset also includes PenguiN, which leverages protein information to guide the assembly of nucleotide contigs, making it highly effective for reconstructing viral genomes and 16S rRNA sequences.

## Installation

The most reliable way to install PLASS is via Bioconda:

```bash
conda install -c conda-forge -c bioconda plass
```

Alternatively, use the official Docker image:
`docker pull ghcr.io/soedinglab/plass:latest`

## Core Workflows

### Protein Assembly (PLASS)
To assemble protein sequences directly from nucleotide reads:

```bash
# Paired-end reads
plass assemble forward.fastq.gz reverse.fastq.gz assembly.fas tmp

# Single-end reads
plass assemble reads.fastq.gz assembly.fas tmp
```

### Nucleotide Assembly (PenguiN)
To assemble nucleotide contigs using protein guidance:

```bash
# Protein-guided nucleotide assembly
penguin guided_nuclassemble forward.fastq reverse.fastq assembly.fas tmp

# Pure nucleotide assembly
penguin nuclassemble forward.fastq reverse.fastq assembly.fas tmp
```

## Parameter Optimization

- **--min-length**: Sets the minimum codon length for ORF prediction. The default is 40 (120bp). If working with very short reads, you must lower this value, though it increases the risk of spurious ORFs.
- **--num-iterations**: Increasing the number of assembly iterations can improve contig length but may introduce SNPs in some datasets.
- **--min-seq-id**: Adjust this to control the stringency of overlaps. Higher values increase precision; lower values increase sensitivity in highly diverse samples.
- **--filter-proteins**: By default, a neural network filter is used to remove spurious ORFs. For specific niche assemblies, you may want to toggle this.

## Expert Tips and Best Practices

- **Memory Management**: PLASS requires approximately 1 byte of RAM per residue. It automatically scales based on available system memory, but ensure your environment has sufficient overhead for large metagenomes.
- **ORF Reliability**: Assembled sequences longer than 100 amino acids are generally genuine. Sequences shorter than 60 amino acids should be treated with caution and verified using secondary methods (e.g., HMMER or alignment against known databases).
- **Hardware Requirements**: The binaries require a CPU with at least SSE4.1 support. For maximum performance, use the AVX2-optimized builds if your hardware supports it.
- **Temporary Files**: The `tmp` directory can grow quite large. Ensure it is located on a high-speed disk with ample space. If running via MPI across multiple nodes, the `tmp` folder must be on a shared filesystem (e.g., NFS).

## Reference documentation
- [plass - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_plass_overview.md)
- [soedinglab/plass: sensitive and precise assembly of short sequencing reads](./references/github_com_soedinglab_plass.md)