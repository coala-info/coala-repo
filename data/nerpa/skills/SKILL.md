---
name: nerpa
description: Nerpa identifies nonribosomal peptides by linking biosynthetic gene clusters in genomic data to known chemical structures. Use when user asks to discover nonribosomal peptides, link BGC predictions to chemical structures, or identify known compounds within microbial genomes.
homepage: https://cab.spbu.ru/software/nerpa/
metadata:
  docker_image: "quay.io/biocontainers/nerpa:1.0.0--py39h2de1943_7"
---

# nerpa

## Overview
Nerpa facilitates the discovery of nonribosomal peptides by bridging the gap between genomic data and chemical structures. It integrates BGC prediction (via antiSMASH) with peptide monomer analysis (via rBAN) to provide a specialized pipeline for natural product discovery. It is particularly useful for researchers looking to automate the identification of known compounds within newly sequenced microbial genomes.

## Usage Guidelines

### Input Requirements
- **Genomic Data**: Accepts genome sequences in FASTA or GenBank (GBK) formats.
- **Chemical Structures**: Known NRPs must be provided in SMILES format.

### Core Workflow
1. **BGC Prediction**: The tool utilizes antiSMASH logic to identify potential biosynthetic gene clusters within the input genome.
2. **Monomer Analysis**: It processes the chemical structures of known peptides to determine their constituent monomers.
3. **Linking**: Nerpa performs a matching algorithm to correlate the predicted assembly line of the BGC with the chemical structure of the peptide.

### Command Line Best Practices
- Ensure all input SMILES strings are properly formatted and validated before running the analysis.
- When working with large FASTA files, ensure sufficient computational resources are available for the antiSMASH-based prediction step.
- For high-confidence results, use complete GenBank files containing rich metadata when available, rather than raw FASTA sequences.

## Reference documentation
- [nerpa - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_nerpa_overview.md)