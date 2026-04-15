---
name: sfs
description: sfs is a high-performance utility for creating, transforming, and analyzing Site Frequency Spectra in population genomics workflows. Use when user asks to view SFS files, normalize spectra, mask monomorphic sites, calculate nucleotide divergence, or perform Fu and Li's D neutrality tests.
homepage: https://github.com/malthesr/sfs
metadata:
  docker_image: "quay.io/biocontainers/sfs:0.1.0--h9ee0642_0"
---

# sfs

## Overview

`sfs` is a high-performance Rust-based command-line utility designed for population genomics workflows. It provides a specialized interface for creating and working with Site Frequency Spectra, which are essential for inferring demographic history and identifying the footprints of natural selection. The tool supports the calculation of standard population genetic summary statistics and provides utilities for transforming and inspecting SFS data.

## CLI Usage and Best Practices

### Core Subcommands

The tool is structured around subcommands. Based on the implementation history, the following patterns are central to the workflow:

*   **Viewing and Inspection**: Use the `view` subcommand to output the contents of an SFS file in a human-readable format.
*   **Data Transformation**: When inspecting spectra, use the following flags to clean or scale the data:
    *   `--normalize`: Scales the SFS components so they sum to 1, useful for comparing shapes of spectra across different sample sizes or populations.
    *   `--mask-monomorphic`: Excludes the 0 and $n$ bins (sites where all samples share the same allele), focusing the analysis strictly on polymorphic sites.

### Calculating Statistics

`sfs` supports several key population genetic metrics directly from the frequency spectra:

*   **Divergence Metrics**: Use the `pi_xy` (aliased as `Dxy`) functionality to calculate the average number of nucleotide substitutions per site between two populations.
*   **Neutrality Tests**: The tool implements **Fu and Li's D** statistic, which is used to test the neutral theory of molecular evolution by comparing different estimates of population genetic diversity.

### Installation and Environment

For optimal performance in bioinformatics pipelines, `sfs` can be managed via several environments:

*   **Conda**: Available on the `bioconda` channel (`conda install -c bioconda sfs`).
*   **Docker**: Use the BioContainers image (`quay.io/biocontainers/sfs`) for reproducible execution in containerized environments.
*   **Source**: If experimental features are required, install directly via Cargo:
    `cargo install --git https://github.com/malthesr/sfs`

## Expert Tips

*   **Workspace Structure**: The project is split into `core` (logic) and `cli` (interface). If you are developing custom scripts to wrap `sfs`, refer to the `core` crate for the underlying data structures.
*   **Performance**: As a Rust tool, `sfs` is designed for memory efficiency. It is preferred over Python-based SFS scripts when processing large-scale genomic datasets or high-dimensional folded spectra.



## Subcommands

| Command | Description |
|---------|-------------|
| sfs | Command-line tool for sfs operations. |
| sfs | For more information, try '--help'. |
| sfs | Command-line tool for sequence similarity analysis. |
| sfs | For more information, try '--help'. |
| sfs | For more information, try '--help'. |
| sfs_create | Tools for working with site frequency spectra |
| sfs_fold | Tools for working with site frequency spectra |
| sfs_stat | Tools for working with site frequency spectra |
| sfs_view | Format, marginalize, project, and convert SFS. |

## Reference documentation

- [GitHub Repository Overview](./references/github_com_malthesr_sfs.md)
- [Installation and README](./references/github_com_malthesr_sfs_blob_main_README.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sfs_overview.md)