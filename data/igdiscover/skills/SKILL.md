---
name: igdiscover
description: igdiscover is a specialized bioinformatics pipeline designed for the discovery of new V gene alleles and the comprehensive analysis of antibody and T-cell receptor repertoires.
homepage: https://igdiscover.se/
---

# igdiscover

## Overview
igdiscover is a specialized bioinformatics pipeline designed for the discovery of new V gene alleles and the comprehensive analysis of antibody and T-cell receptor repertoires. It is particularly effective for non-model organisms or individuals with highly divergent germline sets, as it can "discover" novel sequences by analyzing the variation in expressed repertoires and refining the starting database.

## Core Workflow
The tool operates through a series of subcommands that manage the project lifecycle from initialization to final report generation.

### Project Initialization
To start a new analysis, create a project directory and populate it with a configuration file and starting database.
```bash
igdiscover init --database path/to/database/ --species human my_project
```
*   **Tip**: The database directory should contain FASTA files for V, D, and J genes.
*   **Configuration**: Edit the generated `igdiscover.yaml` to specify input file paths (FASTQ) and adjust parameters like error rates or barcode lengths.

### Running the Pipeline
Execute the main analysis pipeline within the project directory.
```bash
cd my_project
igdiscover run
```
*   This command uses Snakemake internally to manage dependencies and can be resumed if interrupted.
*   Use `-j N` to specify the number of CPU cores to utilize.

### Common Subcommands
- `igdiscover discover`: The core engine for identifying novel V gene candidates based on mutation patterns and expression frequency.
- `igdiscover clono`: Groups sequences into clonotypes based on V/J assignment and CDR3 similarity.
- `igdiscover filter`: Removes low-quality or chimeric sequences from the discovered candidates.
- `igdiscover union`: Combines discovered sequences from multiple libraries or individuals to create a consensus database.

## Best Practices
- **Starting Database**: Even if you expect novel genes, start with the most closely related known germline database (e.g., IMGT) to provide a scaffold for the discovery process.
- **Quality Control**: Always inspect the `stats.csv` and the generated plots in the `plots/` directory to ensure high assignment rates and expected CDR3 length distributions.
- **Iterative Discovery**: For complex repertoires, consider running the pipeline, updating your database with high-confidence discovered alleles, and re-running the analysis for higher precision.

## Reference documentation
- [igdiscover Overview](./references/anaconda_org_channels_bioconda_packages_igdiscover_overview.md)
- [igdiscover Documentation Index](./references/igdiscover_se_index.md)