---
name: sfs
description: The sfs tool is a high-performance utility for manipulating and analyzing Site Frequency Spectra to generate population genetics summaries. Use when user asks to view or fold spectra, calculate population genetics statistics like Tajima's D, or perform formal tests of admixture such as f3 and f4.
homepage: https://github.com/malthesr/sfs
---


# sfs

## Overview
The `sfs` tool is a high-performance Rust-based command-line utility designed for the manipulation and analysis of Site Frequency Spectra. It allows researchers to transform raw genomic frequency data into meaningful population genetics summaries. The tool is particularly useful for workflows involving demographic inference, selection detection, and formal tests of admixture.

## Core CLI Commands

The `sfs` tool follows a standard subcommand structure: `sfs <subcommand> [options]`.

### Inspecting and Transforming Spectra
*   **view**: Use this to read and display SFS files.
    *   `--normalize`: Scales the spectra so the sum of entries equals 1, useful for comparing datasets with different total site counts.
    *   `--mask-monomorphic`: Excludes the 0-frequency (and potentially fixed) bins from the output to focus on polymorphic variation.
*   **fold**: Converts an unfolded SFS (where ancestral/derived states are known) into a folded SFS (based on minor allele frequencies). This is essential when an outgroup is unavailable or polarization is unreliable.

### Calculating Statistics
*   **stat**: Calculates standard population genetics summary statistics from the SFS.
    *   Includes support for **Thetas** (e.g., Watterson's theta, $\pi$).
    *   Includes **Neutrality Tests** like Tajima's D and Fu/Li's D.
*   **pi_xy / Dxy**: Calculates the absolute genetic differentiation between two populations. Note that `pi_xy` is often used as an alias for `Dxy` within the tool.
*   **f3 / f4**: Performs formal tests of migration and tree topology.
    *   Use `f3` for 3-population tests to detect admixture in a target population.
    *   Use `f4` for 4-population tests to evaluate treeness and gene flow between clades.

## Best Practices and Tips
*   **Installation**: For the most stable experience, install via Bioconda (`conda install -c bioconda sfs`). If you need experimental features mentioned in recent commits, build from source using `cargo install --git https://github.com/malthesr/sfs`.
*   **Data Integrity**: When calculating statistics like Tajima's D, ensure your input SFS correctly accounts for missing data or "masked" sites, as the tool's builders rely on the provided site counts to determine the denominator for frequency calculations.
*   **Performance**: Since the tool is written in Rust, it is optimized for large genomic datasets. For very large spectra, prefer the binary SFS formats if supported by your upstream pipeline to reduce I/O overhead compared to text-based formats.

## Reference documentation
- [github_com_malthesr_sfs.md](./references/github_com_malthesr_sfs.md)
- [github_com_malthesr_sfs_commits_main.md](./references/github_com_malthesr_sfs_commits_main.md)
- [anaconda_org_channels_bioconda_packages_sfs_overview.md](./references/anaconda_org_channels_bioconda_packages_sfs_overview.md)