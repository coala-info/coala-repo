---
name: assembly_finder
description: assembly_finder is a command-line utility that simplifies the retrieval of genomic data from NCBI by wrapping the NCBI Datasets API within a Snakemake workflow.
homepage: https://github.com/metagenlab/assembly_finder
---

# assembly_finder

## Overview
assembly_finder is a command-line utility that simplifies the retrieval of genomic data from NCBI by wrapping the NCBI Datasets API within a Snakemake workflow. It automates the process of searching for, downloading, and organizing genome assemblies based on taxonomic names or IDs. This tool is particularly effective for ensuring that downloads are reproducible and that associated metadata—such as assembly summaries and taxonomic lineages—are preserved in a structured directory format.

## Installation
The tool is primarily distributed via Bioconda or as a container:

```bash
# Via Conda
conda install -c bioconda assembly_finder

# Via Apptainer/Singularity
apptainer pull docker://ghcr.io/metagenlab/assembly_finder:latest
```

## Common CLI Patterns

### Basic Genome Download
To download assemblies for a specific organism using its taxonomic name:
```bash
assembly_finder -i "staphylococcus_aureus"
```

### Fetching Reference Genomes
To restrict the download to only the NCBI reference or representative genome:
```bash
assembly_finder -i "staphylococcus_aureus" --reference
```

### Filtering by Assembly Quality
Use the `--level` flag to specify the assembly completeness (e.g., complete, chromosome, scaffold, contig):
```bash
assembly_finder -i "Escherichia coli" --level complete
```

### Advanced Filtering Options
*   **Annotated Genomes**: Only download assemblies that have functional annotation.
    ```bash
    assembly_finder -i "taxon_name" --annotated
    ```
*   **Exclude Atypical**: Skip assemblies flagged by NCBI as atypical.
    ```bash
    assembly_finder -i "taxon_name" --atypical
    ```
*   **Best Assembly**: Use the `--best` flag to automatically select the highest quality assembly available if multiple exist.

## Expert Tips
*   **Output Structure**: The tool creates a directory named after your input taxon. Inside, you will find a `download/` folder containing the `.fna.gz` files, a `logs/` folder for troubleshooting, and several TSV files (`assembly_summary.tsv`, `taxonomy.tsv`) which are essential for downstream data provenance.
*   **Batch Processing**: While the primary input is a taxon string, the tool supports lists. Ensure taxon names with spaces are enclosed in quotes.
*   **Snakemake Integration**: Since it is powered by Snakemake, the tool inherently handles job restarts and can resume interrupted downloads without re-fetching existing files.
*   **NCBI Datasets Versioning**: The tool relies on the `ncbi-datasets` CLI. If you encounter errors related to metadata retrieval, ensure your environment is updated to the latest version of `assembly_finder` to maintain compatibility with NCBI's API changes.

## Reference documentation
- [assembly_finder GitHub Repository](./references/github_com_metagenlab_assembly_finder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_assembly_finder_overview.md)