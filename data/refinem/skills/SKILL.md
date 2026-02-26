---
name: refinem
description: RefineM is a suite of tools designed to improve the quality of metagenome-assembled genomes by identifying and removing contaminating scaffolds. Use when user asks to refine genomic bins, filter scaffolds based on genomic properties or taxonomic consistency, and remove outliers from population genomes.
homepage: http://pypi.python.org/pypi/refinem/
---


# refinem

## Overview
RefineM is a specialized suite of tools designed to improve the quality of population genomes recovered from metagenomes. It identifies and removes "outlier" scaffolds that likely represent contamination within a genomic bin. The refinement process typically relies on three primary signals: divergent genomic properties (like GC content or coding density), inconsistent taxonomic assignments, and anomalous sequence composition (tetranucleotide frequencies).

## Core Workflow and CLI Patterns

The standard refinement workflow follows a sequential execution of modules. Ensure you have your genomic bins (FASTA) and the original metagenomic reads (BAM/SAM) or pre-calculated statistics ready.

### 1. Genomic Property Filtering
Identify scaffolds with anomalous properties compared to the rest of the bin.
```bash
# Calculate genomic properties (GC, coding density, etc.)
refinem stats <bins_dir> <metagenome_fasta> <bam_files> <output_dir>

# Identify outliers based on the calculated stats
refinem filter <stats_output_dir> <output_dir>
```

### 2. Taxonomic Filtering
Remove scaffolds that are taxonomically inconsistent with the majority of the bin. This requires a reference database (e.g., GTDB).
```bash
# Assign taxonomy to scaffolds within bins
refinem taxon_profile <bins_dir> <scaffold_stats> <reference_db> <output_dir>

# Filter bins based on taxonomic consistency
refinem taxon_filter <taxon_profile_dir> <output_dir>
```

### 3. Sequence Composition (SSM)
Use the Scaffold Selection Module (SSM) to refine bins based on tetranucleotide frequencies (TNF).
```bash
refinem ssm <bins_dir> <output_dir>
```

## Expert Tips
- **Iterative Refinement**: It is often more effective to run `stats` and `filter` first to remove obvious outliers before proceeding to the more computationally intensive `taxon_profile`.
- **Resource Management**: Taxonomic profiling is memory-intensive. Ensure the environment has sufficient RAM to load the reference database.
- **Input Validation**: Ensure scaffold names in your BAM files match the names in your FASTA bins exactly; mismatched headers are the most common cause of empty stats files.

## Reference documentation
- [RefineM PyPI Project](./references/pypi_org_project_refinem.md)
- [Bioconda RefineM Overview](./references/anaconda_org_channels_bioconda_packages_refinem_overview.md)