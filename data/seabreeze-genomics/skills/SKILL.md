---
name: seabreeze-genomics
description: Seabreeze-genomics is a bioinformatics pipeline for analyzing structural mutations and genetic variation in bacterial genomes. Use when user asks to identify structural mutations, predict insertion sequences, visualize genomic synteny, or analyze bacterial replichores.
homepage: https://github.com/barricklab/seabreeze
metadata:
  docker_image: "quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0"
---

# seabreeze-genomics

## Overview
seabreeze-genomics is a specialized bioinformatics pipeline for the comprehensive analysis of genetic variation among bacterial genomes. It automates a complex workflow that combines existing genomic tools with custom scripts to identify structural mutations that are often missed by standard SNP-calling pipelines. The tool is particularly useful for evolutionary microbiology and comparative genomics, providing not just mutation calls but also functional annotations and mechanistic insights into how these variations occurred.

## Installation and Environment
The tool is distributed via Bioconda. It is highly recommended to use `mamba` for installation to handle the complex dependency tree efficiently.

```bash
# Recommended installation
mamba install -c bioconda seabreeze-genomics

# Alternative conda installation
conda install -c bioconda seabreeze-genomics
```

## Core Capabilities
When using seabreeze, you can perform the following analyses:
- **Size Comparison**: Calculate total genome size differences between assembly pairs.
- **IS Element Prediction**: Identify the location and type of insertion sequences.
- **Structural Mutation Detection**: Predict inversions, deletions, translocations, and duplications.
- **Synteny Visualization**: Generate plots to visualize genomic alignments and rearrangements.
- **Replichore Analysis**: Evaluate how structural mutations affect the balance of the two bacterial replichores.
- **Mechanism Prediction**: Determine putative mechanisms (e.g., homologous recombination) for inversions and deletions.
- **Functional Annotation**: Annotate genes located within or affected by mutated regions.

## CLI Usage Patterns
The primary entry point is the `seabreeze` command. 

### Getting Help
To see available subcommands and options, use the built-in help:
```bash
seabreeze --help
```

### Common Workflow Steps
While seabreeze is designed as an integrated pipeline, it involves several internal processes:
1. **Input Preparation**: Ensure you have high-quality bacterial genome assemblies (typically in FASTA or GenBank format).
2. **IS Prediction**: The pipeline uses `ISEscan` internally to locate insertion sequences.
3. **Synteny Mapping**: It utilizes `plotsr` for generating visual representations of structural variations.
4. **Batch Testing**: For verifying installations or running example data, the `seabreeze_batch_test` command may be available.

## Expert Tips and Best Practices
- **Mamba Requirement**: If the tool fails to run or resolve dependencies, ensure `mamba` is installed in your base environment, as some internal rules may expect it for environment management.
- **Directory Context**: Earlier versions of the tool required execution from within the repository directory; ensure you are using the latest version (v1.5.0+) which aims to remove this restriction.
- **Resource Management**: Since the pipeline uses Snakemake internally, you can often pass Snakemake-specific parameters (like `--cores`) if the CLI wrapper supports them, or configure the environment to handle parallel processing of multiple genome pairs.
- **Input Validation**: Ensure your genome headers are consistent. Structural variation detection is sensitive to contig naming, especially when comparing a query assembly against a reference.

## Reference documentation
- [seabreeze GitHub Repository](./references/github_com_barricklab_seabreeze.md)
- [seabreeze-genomics Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seabreeze-genomics_overview.md)
- [seabreeze Issues and Troubleshooting](./references/github_com_barricklab_seabreeze_issues.md)