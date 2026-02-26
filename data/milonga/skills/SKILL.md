---
name: milonga
description: MiLongA is an automated Snakemake pipeline for assembling and polishing microbial genomes from long-read sequencing data. Use when user asks to assemble microbial genomes from Nanopore reads, perform hybrid or long-read-only assembly, or polish consensus sequences.
homepage: https://gitlab.com/bfr_bioinformatics/milonga
---


# milonga

## Overview
MiLongA (Microbial Long-read Assembly) is a specialized Snakemake-based pipeline designed to automate the assembly of microbial genomes from long-read sequencing data. It integrates multiple bioinformatics tools—including Flye for assembly, Unicycler for hybrid or long-read-only modes, and Medaka/Dorado for polishing—into a single reproducible workflow. This tool is ideal for researchers who need to move from raw Nanopore reads to high-quality consensus sequences with minimal manual intervention.

## Installation and Initialization
Install the package via Bioconda:
`conda install bioconda::milonga`

Before the first run, ensure the environment is properly configured using the setup script:
`milonga_setup.sh`

## Core CLI Usage and Patterns

### Basic Assembly
Run the pipeline by invoking the main executable with your input data:
`milonga --input [path_to_reads] [options]`

### Long-Read Only Mode
By default, the pipeline may attempt hybrid logic. To force the workflow to work exclusively with long reads:
`milonga --no-unicycler`

### Handling High-Accuracy Reads
For modern Oxford Nanopore data (HAC or SUP basecalling), ensure the Flye read type is set to high-quality mode. In recent versions (v1.0.4+), this is the default:
`milonga --flye-read-type nano-hq`

### Workflow Control
Because MiLongA is a Snakemake wrapper, you can utilize standard Snakemake execution flags:
- **Parallelization**: Use `--cores [N]` to define available CPU resources.
- **Dry Run**: Use `-n` to preview the steps without executing them.
- **Note**: Avoid using the `--reason` flag if running on Snakemake v8.0 or higher, as it has been deprecated.

## Expert Tips and Troubleshooting
- **Polishing Selection**: When using the Medaka module, ensure your model selection matches the flowcell and kit used during sequencing for optimal consensus accuracy.
- **Trimming Issues**: If you encounter cyclic dependencies or errors during the trimming phase, ensure you are using version 1.0.4 or later, which addressed specific trimming logic bugs.
- **Environment Errors**: If the tool fails to find helper functions, re-run `milonga_setup.sh` to refresh the internal pathing and dependency links.
- **Read Type Overrides**: If working with older, noisier Nanopore data, you may need to manually change the read type from `nano-hq` to `nano-raw`.

## Reference documentation
- [MiLongA Overview](./references/anaconda_org_channels_bioconda_packages_milonga_overview.md)
- [MiLongA GitLab Repository](./references/gitlab_com_bfr_bioinformatics_milonga.md)
- [MiLongA README](./references/gitlab_com_bfr_bioinformatics_milonga_-_blob_master_README.md)