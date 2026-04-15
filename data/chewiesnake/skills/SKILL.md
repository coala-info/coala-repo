---
name: chewiesnake
description: chewieSnake is a Snakemake workflow that performs cgMLST allele calling to transform genome assemblies into standardized allele profiles. Use when user asks to perform allele calling, generate distance matrices, perform cluster analysis, or merge multiple allele calling runs.
homepage: https://gitlab.com/bfr_bioinformatics/chewieSnake
metadata:
  docker_image: "quay.io/biocontainers/chewiesnake:3.0.0--hdfd78af_2"
---

# chewiesnake

## Overview
chewieSnake is a specialized Snakemake workflow designed to streamline the process of cgMLST allele calling. By leveraging chewBBACA, it transforms raw genome assemblies into standardized allele profiles. This tool is essential for researchers and bioinformaticians who need to compare bacterial isolates at high resolution, generate distance matrices, and perform cluster analysis within a reproducible pipeline.

## Installation and Setup
The recommended way to install chewieSnake is via Conda through the Bioconda channel:

```bash
conda install bioconda::chewiesnake
```

## Core Usage Patterns
chewieSnake is typically invoked as a command-line wrapper that manages the underlying Snakemake execution.

### Basic Execution
While specific positional arguments depend on the version, the workflow generally requires a directory of assembled genomes (FASTA format) and a reference schema.

### Advanced CLI Flags
Based on recent updates and harmonization efforts, the following flags provide specialized functionality:
- `--use_ceph_db`: Enables the use of a Ceph-based database for large-scale storage environments.
- `--use_ceph_exec`: Directs the workflow to use execution binaries optimized for Ceph environments.
- `-cdb`: Creates a schema symlink within the repository, useful for managing local schema references.
- `--proxy`: Allows the workflow to pass proxy settings to internal steps (e.g., downloading schemas or dependencies).

## Best Practices and Expert Tips
- **Workflow Selection**: Use the `chewieSnake_join` workflow when you need to merge multiple allele calling runs or integrate new samples into an existing dataset.
- **Sample Naming**: Ensure sample filenames do not resemble scientific notation (e.g., avoiding names like `123e4`), as this can cause parsing errors in the underlying `read_csv` operations.
- **Schema Management**: When working with EFSA-specific datasets, ensure your schema directory naming reflects the required subsetting to maintain compatibility with the internal validation logic.
- **Resource Optimization**: Since the tool is Snakemake-based, you can pass standard Snakemake parameters (like `--cores`) through the wrapper to manage computational load.
- **Output Validation**: Always check the `pipeline_status.txt` file in the output directory to verify the completion status of the Snakemake rules and locate log files for specific failures.

## Reference documentation
- [chewieSnake Overview](./references/anaconda_org_channels_bioconda_packages_chewiesnake_overview.md)
- [chewieSnake GitLab Repository](./references/gitlab_com_bfr_bioinformatics_chewieSnake.md)
- [Project Changelog](./references/gitlab_com_bfr_bioinformatics_chewieSnake_-_blob_master_CHANGELOG.md)