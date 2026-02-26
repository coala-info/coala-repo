---
name: pifcosm
description: PifCoSm automates the construction of supermatrix phylogenetic trees by integrating sequence processing, alignment, and maximum likelihood inference using GenBank data. Use when user asks to build multi-locus phylogenies from GenBank records, automate sequence alignment and tree construction, or perform maximum likelihood searches with RAxML.
homepage: https://github.com/RybergGroup/PifCoSm
---


# pifcosm

## Overview
PifCoSm (Pipeline for Construction of Supermatrices) is a bioinformatics tool designed to automate the creation of supermatrix phylogenetic trees using data sourced from GenBank. It integrates sequence processing, alignment, and maximum likelihood tree inference into a unified Perl-based workflow. It is particularly useful for researchers working with large-scale GenBank datasets who need to generate multi-locus phylogenies.

## Installation
The recommended way to install pifcosm is through the Bioconda channel:

```bash
conda install bioconda::pifcosm
```

## Basic Usage
The primary interface for the pipeline is the `PifCoSm.pl` script.

### Getting Help
To view all available command-line arguments and configuration options:
```bash
PifCoSm.pl -h
# or
PifCoSm.pl --help
```

### Core Workflow Patterns
*   **Input Data**: The pipeline typically operates on GenBank files (`gb_file`) or data directories (`gb_data`).
*   **Parallelization**: When performing Maximum Likelihood (ML) searches with RAxML, utilize the `PTHREAD` option to enable multi-threaded execution and reduce computation time.
*   **Bootstrapping**: You can include bootstrap replicates as an option during the alignment phase to assess branch support.
*   **Taxonomy**: The pipeline includes modules to automatically retrieve and assign taxonomy to each Operational Taxonomic Unit (OTU).

## Expert Tips and Best Practices
*   **Species Name Parsing**: The tool is configured to parse species names while ignoring infraspecific annotations like `f.`, `var.`, and `ssp.` to ensure consistency across GenBank records.
*   **External Dependencies**: PifCoSm relies on external programs for alignment and tree building (e.g., RAxML). Ensure these are in your PATH or correctly defined in the tool's configuration modules.
*   **HMM Profiles**: The pipeline utilizes HMM (Hidden Markov Model) profiles located in the `hmms/` directory for sequence identification and alignment.
*   **Batch Processing**: If processing multiple GenBank files, ensure file paths do not contain conflicting characters that might interfere with the Perl file-reading logic.

## Reference documentation
- [pifcosm - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pifcosm_overview.md)
- [RybergGroup/PifCoSm GitHub Repository](./references/github_com_RybergGroup_PifCoSm.md)
- [PifCoSm Commit History](./references/github_com_RybergGroup_PifCoSm_commits_master.md)