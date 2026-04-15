---
name: prymer
description: Prymer is a specialized toolset for designing genomic primers with high specificity and thermodynamic stability. Use when user asks to design primers for targeted sequencing, validate primer pairs for off-target binding, calculate melting temperatures, or optimize multiplex PCR assays.
homepage: https://pypi.org/project/prymer/
metadata:
  docker_image: "quay.io/biocontainers/prymer:3.0.2--pyhdfd78af_1"
---

# prymer

## Overview
Prymer is a specialized toolset for genomic primer design that prioritizes specificity and thermodynamic stability. It is particularly useful for designing primers for targeted sequencing panels, multiplex PCR, and clinical assays where avoiding off-target binding is critical. The tool automates the selection of optimal primer pairs based on user-defined melting temperature (Tm) ranges, GC content, and length constraints.

## Core Workflows

### Primer Design
To design primers for a specific genomic region, use the `design` command. You must provide a reference genome and the target coordinates.
- **Basic Design**: `prymer design --reference ref.fasta --targets targets.bed --output primers.txt`
- **Multiplex Optimization**: When designing for multiplex PCR, use the `--check-interactions` flag to minimize primer-dimer formation between different pairs in the pool.

### Validation and In-Silico PCR
Before synthesizing primers, validate them against the genome to identify potential mispriming sites.
- **Off-target Analysis**: `prymer search --reference ref.fasta --primers primers.fasta`
- **Tm Calculation**: Use the `calc-tm` utility for precise thermodynamic calculations using nearest-neighbor models.

## Best Practices
- **Reference Indexing**: Ensure your reference FASTA is indexed (using `samtools faidx`) for faster coordinate lookups during the design phase.
- **Tm Matching**: For multiplex reactions, keep the $T_m$ of all primers within a $2^\circ C$ window to ensure uniform amplification efficiency.
- **Masking**: Use soft-masked genomes to avoid designing primers over repetitive elements or known SNPs that could interfere with binding.

## Reference documentation
- [Prymer Project Overview](./references/pypi_org_project_prymer.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_prymer_overview.md)