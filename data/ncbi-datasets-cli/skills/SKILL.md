---
name: ncbi-datasets-cli
description: The ncbi-datasets-cli tool automates the retrieval, filtering, and organization of genome assemblies and metadata from NCBI databases. Use when user asks to download reference genomes, filter assemblies by quality or annotation status, and retrieve taxonomic reports for specific organisms.
homepage: https://github.com/metagenlab/assembly_finder
---


# ncbi-datasets-cli

## Overview
The `ncbi-datasets-cli` skill (powered by the `assembly_finder` utility) provides a streamlined interface for interacting with NCBI's vast genomic databases. Unlike raw API calls, this tool automates the retrieval, organization, and logging of genome assemblies. It allows users to target specific taxonomic groups and apply filters to ensure only high-quality or specific types of genomic data (such as reference genomes or annotated sequences) are downloaded. The tool organizes outputs into a structured directory format, including metadata files like assembly summaries and taxonomic reports.

## Usage Guidelines

### Basic Assembly Download
To download the reference genome for a specific taxon, use the `-i` (input) flag followed by the organism name and the `--reference` filter.
```bash
assembly_finder -i "staphylococcus_aureus" --reference
```

### Filtering and Quality Control
Use specific flags to refine the quality of the assemblies retrieved:
- **Reference Genomes**: Use `--reference` to limit results to NCBI-defined reference assemblies.
- **Assembly Level**: Use `--level` to specify the completeness (e.g., complete, chromosome, scaffold, contig).
- **Best Available**: Use the `--best` flag to automatically iterate through assembly levels until a genome is found.
- **Annotation Status**: Use `--annotated` to only download genomes with available functional annotations.
- **Exclude Atypical**: Use `--atypical` to filter out assemblies marked as atypical by NCBI.

### Batch Processing
The tool supports processing lists of taxons. Provide a file containing taxon names (one per line) to the `-i` argument. The tool can handle lists without headers.

### Output Structure
The tool creates a directory named after the input taxon containing:
- `download/`: The actual genomic sequences (`.fna.gz`).
- `assembly_summary.tsv`: Metadata for all found assemblies.
- `sequence_report.tsv`: Detailed sequence-level information.
- `taxonomy.tsv`: Taxonomic lineage information.
- `logs/`: Detailed execution logs for troubleshooting lineage, rsync, and unzipping processes.

## Expert Tips
- **Snakemake Integration**: Since this tool is a Snakemake wrapper, it manages dependencies and checkpoints automatically. If a download is interrupted, re-running the command will resume from the last successful step.
- **Conda Environments**: For reproducible research, it is recommended to run the tool within its dedicated Conda environment to ensure all dependencies (like `ncbi-datasets` and `snakemake`) are correctly versioned.
- **Resource Management**: When downloading large numbers of genomes, monitor the `logs/rsync.log` to track the progress of data transfers from NCBI servers.

## Reference documentation
- [assembly_finder GitHub Home](./references/github_com_metagenlab_assembly_finder.md)
- [assembly_finder Commits and Updates](./references/github_com_metagenlab_assembly_finder_commits_main.md)