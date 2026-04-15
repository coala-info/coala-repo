---
name: winnowmap
description: Winnowmap is an alignment tool designed for accurate mapping of sequences in repetitive genomic regions. Use when user asks to 'map ONT reads', 'map PacBio HiFi reads', or 'perform genome-to-genome alignment'.
homepage: https://github.com/marbl/Winnowmap
metadata:
  docker_image: "quay.io/biocontainers/winnowmap:2.03--h5ca1c30_4"
---

# winnowmap

## Overview

Winnowmap is a specialized alignment tool designed to overcome the limitations of standard minimizer sampling in repetitive genomic regions. It uses a weighted minimizer sampling algorithm to down-weight frequently occurring k-mers, ensuring more uniform coverage and higher mapping accuracy in complex repeats like long tandem repeats. Version 2.0+ further improves accuracy by using Minimal Confidently Alignable Substrings (MCAS) to handle structural variations and paralog-specific variants (PSVs) more effectively than standard pairwise alignment scoring.

## Installation and Setup

Winnowmap is available via Bioconda or can be compiled from source. It requires the `meryl` k-mer counting tool for pre-processing the reference.

```bash
# Installation via Conda
conda install -c bioconda winnowmap

# Manual Compilation
git clone https://github.com/marbl/Winnowmap.git
cd Winnowmap && make -j8
# Executables 'winnowmap' and 'meryl' will be in the bin folder
```

## Core Workflow

Mapping with Winnowmap is a two-step process: identifying repetitive k-mers in the reference, then performing the alignment.

### 1. Pre-computing Repetitive K-mers
You must identify the top frequent k-mers (typically the top 0.02%) to allow the weighted sampling to function.

**For Long Reads (ONT/PacBio):**
```bash
meryl count k=15 output merylDB ref.fa
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt
```

**For Genome Assemblies:**
```bash
meryl count k=19 output merylDB ref.fa
meryl print greater-than distinct=0.9998 merylDB > repetitive_k19.txt
```

### 2. Mapping Reads
Use the `-W` flag to provide the repetitive k-mer file generated in step 1.

**Oxford Nanopore (ONT):**
```bash
winnowmap -W repetitive_k15.txt -ax map-ont ref.fa reads.fq.gz > output.sam
```

**PacBio HiFi:**
```bash
winnowmap -W repetitive_k15.txt -ax map-pb ref.fa hifi.fq.gz > output.sam
```

**Genome-to-Genome Alignment:**
```bash
winnowmap -W repetitive_k19.txt -ax asm20 ref.fa query_asm.fa > output.sam
```

## Expert Tips and Best Practices

- **K-mer Size Selection**: Use $k=15$ for most long-read mapping tasks. For genome-to-genome alignments (assembly vs. assembly), $k=19$ is recommended for higher specificity.
- **Repetitive Threshold**: The `distinct=0.9998` parameter in meryl filters for the top 0.02% most frequent k-mers. This is the recommended starting point for the human genome and similarly complex eukaryotes.
- **Memory and Performance**: Pre-computing k-mers with meryl is fast (2-3 minutes for human genome). Winnowmap itself is optimized for competitive runtimes with minimap2 while providing better accuracy in centromeric and telomeric regions.
- **Output Formats**: While `-ax` outputs SAM format, you can omit the `-a` to get PAF (Pairwise Mapping Format) output, which is useful for dot plots and rapid overlap analysis.
- **Handling Allelic Bias**: If you are working with non-reference alleles in repetitive regions, Winnowmap's MCAS approach (default in v2.0+) is specifically designed to avoid the "highest scoring alignment" trap that often leads to incorrect repeat copy placement.

## Reference documentation
- [Winnowmap GitHub Repository](./references/github_com_marbl_Winnowmap.md)
- [Bioconda Winnowmap Package](./references/anaconda_org_channels_bioconda_packages_winnowmap_overview.md)