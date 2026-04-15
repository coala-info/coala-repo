---
name: miru-hero
description: miru-hero identifies MIRU-VNTR loci and spoligotypes from Mycobacterium tuberculosis genome assemblies to determine phylogenetic lineages. Use when user asks to perform genomic surveillance, identify molecular signatures from FASTA sequences, or predict tuberculosis lineages.
homepage: https://gitlab.com/LPCDRP/miru-hero
metadata:
  docker_image: "quay.io/biocontainers/miru-hero:0.10.0--pyh5e36f6f_0"
---

# miru-hero

## Overview
The `miru-hero` tool is a specialized heuristic engine designed for the genomic surveillance of *Mycobacterium tuberculosis*. It automates the identification of Mycobacterial Interspersed Repetitive Units (MIRU) and CRISPR-associated spacers (Spoligotyping) directly from assembly data. This skill provides the necessary command-line patterns to process FASTA sequences and interpret the resulting molecular signatures.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install -c bioconda miru-hero
```

## Core Usage Patterns

### Basic Analysis
To run a standard analysis on a single genome assembly:
```bash
miru-hero -i input_genome.fasta -n "Sample_ID" -o output_directory
```

### Command Line Arguments
- `-i`, `--input`: Path to the input FASTA file (required).
- `-o`, `--outdir`: Directory where result files will be saved.
- `-n`, `--run-name`: A label for the specific run, used to prefix output files.

## Understanding Outputs
The tool provides three primary types of data in its output:
1.  **MIRU Results**: The count and position of repeats for the 24 standard MIRU-VNTR loci.
2.  **Spoligotype Results**: An octal representation of the presence/absence of the 43 spacers in the DR locus.
3.  **Lineage Results**: A predicted phylogenetic lineage (e.g., Indo-Oceanic, East-Asian, Euro-American) based on the identified patterns.

## Expert Tips
- **Input Quality**: Ensure your FASTA files are high-quality assemblies. While `miru-hero` can handle partial sequences, fragmented assemblies may lead to undercounting of repeats if a locus is split across multiple contigs.
- **Output Management**: In version 0.10.0+, use the `-n` flag to distinguish between different samples processed into the same output directory to prevent file overwriting.
- **Species Differentiation**: The tool includes specific logic to differentiate between *M. tuberculosis* sensu stricto and *M. canettii*.

## Reference documentation
- [Bioconda miru-hero Overview](./references/anaconda_org_channels_bioconda_packages_miru-hero_overview.md)
- [miru-hero Tags and Version History](./references/gitlab_com_LPCDRP_miru-hero_-_tags.md)