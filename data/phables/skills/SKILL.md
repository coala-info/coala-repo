---
name: phables
description: Phables resolves complete bacteriophage genomes from fragmented metagenomic assembly graphs using flow networks and integer linear programming. Use when user asks to resolve phage paths from assembly graphs, identify phage-like components in metagenomes, or reconstruct viral genomes from unitig coverage and GFA files.
homepage: https://github.com/Vini2/phables
---

# phables

## Overview

Phables is a specialized bioinformatics tool designed to bridge the gap between fragmented metagenomic assemblies and complete bacteriophage genomes. While standard assemblers often struggle with repetitive regions or closely related viral strains, Phables uses the underlying assembly graph structure to identify phage-like components. It treats these components as flow networks, applying Integer Linear Programming (ILP) to find the most likely genomic paths. This approach is particularly effective for resolving complex viral communities where traditional binning or scaffolding might fail.

## Installation and Setup

Phables is best managed via Conda to handle its dependencies, including the MFD-ILP solver.

```bash
# Create and activate environment
conda create -n phables -c bioconda -c conda-forge phables
conda activate phables

# Verify installation
phables --version
phables --help
```

## Core Workflow

The standard Phables workflow requires an assembly graph and the corresponding read mapping information.

### 1. Prepare Input Data
Ensure you have the following files ready:
- **Assembly Graph**: A `.gfa` file (typically from MetaSPAdes or Megahit).
- **Read Mappings**: `.bam` files of your metagenomic reads mapped back to the assembly unitigs.
- **Unitig Coverage**: A CSV file containing coverage information (often generated during the mapping step).

### 2. Run Phables
Execute the main pipeline to resolve phage paths:

```bash
phables run --graph assembly_graph.gfa --coverage coverage.csv --bams mapping_folder/ --outdir phables_output
```

### 3. Key Parameters
- `--minlength`: Minimum length of a resolved phage genome (default is often 5000bp).
- `--maxlength`: Maximum length for the flow decomposition.
- `--threads`: Number of CPU cores to utilize for the ILP solver and processing.

## Common CLI Patterns

### Testing the Installation
Always run the built-in test suite to ensure the ILP solver and environment are configured correctly:
```bash
phables test
```

### Generating Graph Statistics
To understand the complexity of your assembly before running the full resolution:
```bash
phables graph-stats --graph assembly_graph.gfa --outdir stats_output
```

### Post-Processing
Phables outputs resolved paths in FASTA format. You should evaluate these using quality control tools:
- Check `phables_output/resolved_paths.fasta` for the final sequences.
- Review `phables_output/phables.log` for details on which components were successfully decomposed.

## Expert Tips

- **Graph Quality**: Phables performs best on MetaSPAdes graphs. If using Megahit, ensure you convert the output to a compatible GFA format.
- **Coverage Consistency**: The accuracy of the flow model depends heavily on accurate unitig coverage. Ensure your read mapping is performed with high sensitivity.
- **Component Filtering**: Phables automatically identifies "phage-like" components based on graph topology. If you have specific viral markers (e.g., from CheckV or VIBRANT), you can use them to cross-reference Phables' output.



## Subcommands

| Command | Description |
|---------|-------------|
| phables config | Copy system default config to phables.out/config.yaml |
| phables run | Run Phables |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation

- [Phables GitHub Repository](./references/github_com_Vini2_phables.md)
- [Phables Usage Guide](./references/phables_readthedocs_io_en_latest_usage.md)
- [Installation Instructions](./references/phables_readthedocs_io_en_latest_install.md)
- [Contributing Guidelines](./references/github_com_Vini2_phables_blob_develop_CONTRIBUTING.md)