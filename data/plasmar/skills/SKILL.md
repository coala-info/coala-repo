---
name: plasmar
description: PLASMAR identifies plasmid-like contigs in genomic assemblies and cross-references them with antimicrobial resistance markers. Use when user asks to identify plasmids, filter assembly contigs for mobile genetic elements, or find resistance sequences within plasmid-like structures.
homepage: https://https://github.com/rastanton/PLASMAR
---


# plasmar

## Overview
PLASMAR is a specialized bioinformatics tool used to bridge the gap between raw genomic assemblies and the identification of mobile genetic elements carrying resistance markers. It streamlines the process of filtering assembly contigs to find those that behave like plasmids and cross-referencing them with known resistance sequences. This skill provides the necessary CLI patterns to execute the algorithm and manage its output within a bioconda-supported environment.

## Installation and Setup
The tool is distributed via the Bioconda channel. Ensure your environment is configured to prioritize bioconda and conda-forge.

```bash
conda install bioconda::plasmar
```

## Common CLI Patterns
While specific subcommands depend on the version, the core execution typically follows this pattern:

- **Standard Analysis**: Run PLASMAR against a FASTA assembly file to identify plasmid-like contigs.
- **Database Matching**: Ensure you have the required resistance databases (like ResFinder or CARD) indexed if the tool requires local paths for matching.
- **Output Interpretation**: PLASMAR typically generates tabular reports or filtered FASTA files containing the identified plasmid-like sequences.

## Expert Tips
- **Assembly Quality**: For best results, use high-quality assemblies (e.g., from Unicycler or Flye) as fragmented assemblies can lead to false negatives in plasmid identification.
- **Resource Management**: As a sequence matching algorithm, PLASMAR can be memory-intensive depending on the size of the reference database. Monitor RAM usage when processing large batches of environmental samples.
- **Version Consistency**: Ensure you are using version 1.5 or higher for the most up-to-date resistance matching logic.

## Reference documentation
- [PLASMAR Overview](./references/anaconda_org_channels_bioconda_packages_plasmar_overview.md)