---
name: snakebids
description: Snakebids is a framework that extends Snakemake to build portable BIDS Apps for neuroimaging data processing. Use when user asks to create BIDS-compliant workflows, automate path construction, filter participants for analysis, or generate Boutiques descriptors.
homepage: https://github.com/khanlab/snakebids
---


# snakebids

## Overview
Snakebids is a specialized framework that extends Snakemake to handle the complexities of BIDS-formatted neuroimaging data. It transforms standard Snakemake workflows into portable BIDS Apps, providing a consistent command-line interface for data processing. By using snakebids, developers can automate path construction, handle complex dataset queries via Pybids, and ensure their pipelines are reproducible and scalable across different computing environments.

## CLI Usage Patterns
Snakebids workflows typically expose a CLI that follows the BIDS App standard.

### Basic Execution
Run a snakebids-based pipeline by specifying the input BIDS directory, output directory, and analysis level:
`python run.py /path/to/bids_root /path/to/output participant`

### Participant Filtering
Process specific subjects using the `--participant-label` flag (do not include the `sub-` prefix):
`python run.py /path/to/bids_root /path/to/output participant --participant-label 01 02`

### Snakemake Passthrough
To pass arguments directly to the underlying Snakemake engine (like core count, dry-runs, or cluster configuration), use the `--` separator:
`python run.py /path/to/bids_root /path/to/output participant -- --cores 8 --dry-run`

## Path Construction Best Practices
Use the `bids()` function within your Snakefile to generate valid BIDS paths. This ensures that your workflow remains compliant with BIDS naming conventions and handles optional entities gracefully.

### Standard Path Generation
`bids(root='results', subject='{subject}', session='{session}', suffix='T1w.nii.gz')`

### Handling Transforms (ANTs style)
When working with registration outputs, follow the `from-<modality>_to-<target>` pattern for clarity and compliance:
`bids(root='work', subject='{subject}', from_='T1w', to='MNI152', suffix='1Warp.nii.gz')`

## Directory Organization
Follow the standardized structure to ensure compatibility with BIDS validators and workflow modularity:
- **results/**: Contains final derivative datasets and the required `dataset_description.json`.
- **sourcedata/**: Stores intermediate files generated during the workflow. This directory is named to be ignored by BIDS validators while keeping the workspace organized.

## Expert Tips
- **Plugin System**: Leverage the plugin system to extend CLI functionality, such as adding custom versioning or specialized filtering logic without modifying the core workflow.
- **Pybids Querying**: Snakebids leverages Pybids for data discovery. If the workflow fails to find files, verify that the input dataset passes the BIDS validator.
- **Development Workflow**: For developers contributing to snakebids or building complex apps, use `uv` for dependency management. Run `uv run poe quality` to check code standards and `uv run poe test` for validation.



## Subcommands

| Command | Description |
|---------|-------------|
| snakebids boutiques | Generate a Boutiques descriptor for a Snakebids app. |
| snakebids_create | Create a new snakebids project. |

## Reference documentation
- [Snakebids GitHub Repository](./references/github_com_khanlab_snakebids.md)
- [Directory Structure Wiki](./references/github_com_khanlab_snakebids_wiki_Directory-Structure.md)
- [File Naming Wiki](./references/github_com_khanlab_snakebids_wiki_File-Naming.md)
- [Snakebids Documentation Index](./references/snakebids_readthedocs_io_en_stable_index.html.md)