---
name: anvio-minimal
description: Anvi'o is a comprehensive platform for integrating sequence data, coverage, and functional annotations into unified databases for microbial omics analysis. Use when user asks to generate contigs databases, profile mapping results, perform pangenomic analyses, or visualize and refine metagenomic bins.
homepage: http://merenlab.org/software/anvio/index.html
---


# anvio-minimal

## Overview
anvi'o is a comprehensive platform designed to bridge the gap between data generation and biological insight. It excels at integrating diverse information—such as sequence composition, coverage, and functional annotation—into a unified database structure. Use this skill to navigate the multi-step process of transforming raw assemblies into interactive, searchable projects where you can perform manual binning, comparative genomics, and metabolic reconstruction.

## Core Database Workflows

### 1. Contigs Database (`anvi-gen-contigs-database`)
The foundation of any anvi'o project. It stores DNA sequences and their basic statistics.
- **Best Practice**: Always use a simple, clean FASTA file (short headers, no special characters).
- **Command**: `anvi-gen-contigs-database -f contigs.fa -o contigs.db -n "Project Name"`
- **Functional Annotation**: After creation, use `anvi-run-hmms` to identify single-copy core genes and `anvi-run-ncbi-cogs` or `anvi-run-kegg-kofams` for functional hits.

### 2. Profile Database (`anvi-profile`)
Stores mapping results (BAM files) to link coverage and SNV data to the contigs database.
- **Requirement**: Requires an indexed BAM file and the corresponding contigs.db.
- **Command**: `anvi-profile -i sample.bam -c contigs.db`
- **Merging**: If you have multiple samples, profile each individually, then use `anvi-merge` to create a single merged profile for visualization.

### 3. Pangenomics Workflow
Used to compare multiple genomes (internal or external).
- **Sequence**: `anvi-gen-genomes-storage` -> `anvi-pan-genome`.
- **Tip**: Use `--use-ncbi-blast` or `--diamond` for the search step depending on your computational resources.

## Interactive Visualization
The hallmark of anvi'o is the interactive interface.
- **Launch**: `anvi-interactive -p MERGED-PROFILE/PROFILE.db -c contigs.db`
- **Remote Access**: If running on a server, use SSH tunneling (e.g., `ssh -L 8080:localhost:8080 user@server`) to view the interface in your local browser at `http://localhost:8080`.

## Expert Tips
- **Database Integrity**: Use `anvi-db-info` to check the version and contents of any `.db` file.
- **Refining Bins**: Use `anvi-refine` to manually clean up metagenome-assembled genomes (MAGs) based on coverage patterns and GC content.
- **Exporting Data**: Use `anvi-summarize` to generate a static HTML report and text files containing all information stored in your databases (abundances, taxonomy, functions).

## Reference documentation
- [anvi'o Software Overview](./references/merenlab_org_software_anvio_index.html.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_anvio-minimal_overview.md)