---
name: pantax
description: PanTax performs high-resolution taxonomic profiling of microbial strains in metagenomic samples using pangenome graphs and path abundance optimization. Use when user asks to preprocess reference genomes, construct pangenome databases, or perform species and strain-level profiling on metagenomic reads.
homepage: https://github.com/LuoGroup2023/PanTax
metadata:
  docker_image: "quay.io/biocontainers/pantax:2.0.1--py310h3e1df6f_1"
---

# pantax

## Overview
PanTax is a high-resolution taxonomic profiling tool designed to identify microbial strains in metagenomic samples. By utilizing pangenome graphs instead of traditional linear references, it better represents genetic variation and improves classification accuracy. The tool is optimized for speed via a Rust-based core (v2.0+) and uses Integer Linear Programming (ILP) for path abundance optimization. Use this skill to guide the end-to-end workflow of database preparation, genome clustering, and sample profiling.

## Installation and Environment
PanTax requires several bioinformatics dependencies (pggb, vg, graphaligner) and an ILP solver.

- **Solver Selection**: Gurobi is the recommended solver for speed. Academic users should obtain a free license. Open-source solvers (highs, cbc, glpk) are supported but significantly slower.
- **Conda Setup**:
  ```bash
  conda install -c bioconda -c conda-forge pantax
  conda install -c gurobi gurobi=11
  ```
- **License Activation**: Ensure the `GRB_LICENSE_FILE` environment variable is set before running profiling tasks.

## Genome Preprocessing
Before building a pangenome, clean and cluster your reference genomes to reduce redundancy and remove non-chromosomal elements.

- **Standard NCBI Input**: Use `-r` to point to a directory of RefSeq genomes.
  ```bash
  data_preprocessing -r /path/to/ref_dir --remove --cluster
  ```
- **Custom Genome Input**: Provide a tab-delimited `genomes_info.txt` file.
  - Fields: `Genome ID`, `Strain TaxID`, `Species TaxID`, `Organism Name`, `Absolute Path`.
  ```bash
  data_preprocessing -c genomes_info.txt --remove --cluster
  ```

## Database Construction
Once genomes are preprocessed, initialize the pangenome graph database.

- **Create Database**:
  ```bash
  pantax -f genomes_info.txt --create
  ```
- **Output**: This generates `reference_pangenome.gfa` and serialized graph node/path information required for profiling.

## Taxonomic Profiling
PanTax supports both short-read and long-read metagenomic data.

- **Basic Profiling**:
  ```bash
  pantax -i reads.fastq -d /path/to/database -o output_dir
  ```
- **Rust-powered Profiling (v2.0+)**: The `pantaxr` subcommand handles the rewritten high-speed modules for species and strain profiling.
- **Long Read Filtering**: Use the GAF filtering module within `pantaxr` to improve precision for Nanopore or PacBio data.

## Expert Tips and Best Practices
- **Memory Management**: Pangenome graph construction is memory-intensive. For large databases, ensure the environment has sufficient RAM or use the `--cluster` option during preprocessing to group highly similar genomes.
- **Solver Performance**: If profiling hangs or is extremely slow, verify that Gurobi is being used instead of GLPK.
- **Path Abundance Optimization (PAO)**: This is the core of PanTax's strain resolution. If results show unexpected strain distributions, check the `unique_trio_nodes_fraction` parameter.
- **Version Compatibility**: Version 2.0+ is significantly faster (up to 25x) than v1.x due to the Rust implementation. Always prefer the `rust_dev` branch or latest bioconda release.

## Reference documentation
- [PanTax GitHub Repository](./references/github_com_LuoGroup2023_PanTax.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pantax_overview.md)