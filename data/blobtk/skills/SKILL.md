---
name: blobtk
description: blobtk is a high-performance Rust-based toolkit that provides the engine for the BlobToolKit ecosystem.
homepage: https://github.com/genomehubs/blobtk
---

# blobtk

## Overview

blobtk is a high-performance Rust-based toolkit that provides the engine for the BlobToolKit ecosystem. It is used to process genomic assemblies to identify contaminants, calculate coverage metrics, and generate taxon-annotated visualizations. Use this skill to navigate its command-line interface for assembly QC, taxonomy matching (specifically with ENA metadata), and configuration validation.

## Core CLI Usage

The `blobtk` binary uses a subcommand-based structure. You can access help for any subcommand using `blobtk <subcommand> --help`.

### Visualization with `plot`
The `plot` subcommand is used to generate blob plots and snail plots to visualize assembly statistics.
- **Basic Plotting**: Use `blobtk plot` to generate visualizations of your dataset.
- **Grid Layouts**: Use the `--shape grid` flag to organize multiple plots, though be aware this feature is sensitive to configuration parameters.
- **Taxon Levels**: You can generate plots at different taxonomic ranks (genus, family, order) by specifying the appropriate attributes in your input data.

### Taxonomy Management
The `taxonomy` subcommand handles NCBI-style taxdump files and metadata matching.
- **ENA Matching**: Use this to match ENA JSONL metadata against a taxonomy database.
- **Taxdump Modification**: Supports adding new species or finding/creating genus nodes within an existing taxdump.
- **Multi-format Output**: Capable of producing taxonomy data in multiple formats for downstream compatibility.

### Assembly Processing
- **`depth`**: Used for calculating sequence depth/coverage across scaffolds or contigs.
- **`filter`**: Used to subset or filter genomic assemblies based on specific criteria (e.g., coverage, GC content, or taxonomic assignment).
- **`validate`**: Essential for checking the integrity of GenomeHubs configuration files before starting large-scale imports or analyses.

## Expert Tips and Best Practices

- **Performance**: Since `blobtk` is written in Rust, it is significantly faster than older Python-based iterations. Prefer it for large-scale depth calculations and filtering tasks.
- **Environment Setup**: On Apple Silicon (M1/M2) Macs, if installing via Conda, you may need to set the architecture to `osx-64` using `conda config --env --set subdir osx-64` to ensure compatibility with certain bioconda builds.
- **Error Handling**: When using the `taxonomy` subcommand, ensure your `out_dir` exists before execution, as the tool may fail when attempting to write exception logs to non-existent paths.
- **Python Integration**: If you need to use `blobtk` within a script, it is available as a Python module via `pip install blobtk`, providing a bridge between the Rust performance and Python's data science ecosystem.

## Reference documentation
- [BlobTk Wiki Home](./references/github_com_genomehubs_blobtk_wiki.md)
- [BlobTk GitHub Repository](./references/github_com_genomehubs_blobtk.md)
- [Bioconda blobtk Overview](./references/anaconda_org_channels_bioconda_packages_blobtk_overview.md)