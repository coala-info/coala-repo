---
name: igfinder
description: igfinder identifies and extracts functional immunoglobulin sequences from transcriptomic data. Use when user asks to identify immunoglobulin sequences, extract heavy and light chain sequences from assembled transcripts, or profile immune repertoires.
homepage: https://tx.bioreg.kyushu-u.ac.jp/igfinder
metadata:
  docker_image: "quay.io/biocontainers/igfinder:1.0--pyhdfd78af_0"
---

# igfinder

## Overview
igfinder is a specialized bioinformatics tool designed to identify and extract functional Immunoglobulin (Ig) sequences from transcriptomic data. It specifically targets the heavy chain (Igh) and both light chains (Igk and Igl). This tool is essential for researchers working on antibody discovery, immune repertoire profiling, and B-cell immunology who need to move from raw assembled contigs to annotated gene sequences.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels:
```bash
conda install -c bioconda igfinder
```

### Core Workflow
igfinder typically operates on assembled transcript sequences (FASTA format). While specific CLI flags vary by version, the standard execution pattern involves:

1.  **Input**: Assembled transcripts (e.g., from Trinity, SPAdes, or Flye).
2.  **Processing**: The tool scans sequences for conserved Ig motifs and structural features.
3.  **Output**: Extracted sequences for Igh, Igk, and Igl chains.

### Best Practices
*   **Assembly Quality**: The sensitivity of igfinder depends on the quality of the input assembly. Ensure transcripts are properly filtered for length and chimera-free before processing.
*   **Chain Identification**: Use the tool to distinguish between different isotypes and light chain types, which is critical for downstream monoclonal antibody synthesis or repertoire diversity analysis.
*   **Species Context**: While optimized for common model organisms, verify compatibility if working with non-traditional species, as Ig loci can vary significantly.

## Reference documentation
- [igfinder Overview](./references/anaconda_org_channels_bioconda_packages_igfinder_overview.md)