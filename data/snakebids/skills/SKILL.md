---
name: snakebids
description: Snakebids integrates BIDS datasets into Snakemake workflows to automate the discovery of neuroimaging data and create standardized BIDS Apps. Use when user asks to build Snakemake workflows for BIDS data, automate subject and session discovery, or generate BIDS-compliant file paths.
homepage: https://github.com/khanlab/snakebids
---


# snakebids

## Overview
Snakebids is a specialized framework that integrates BIDS datasets into Snakemake workflows. It automates the discovery of subjects, sessions, and modalities, allowing you to write generic Snakemake rules that scale across complex neuroimaging datasets. By using Snakebids, you transform a standard Snakemake script into a "BIDS App," providing a standardized CLI for end-users while maintaining the parallel execution and reproducibility of Snakemake.

## Core CLI Usage
Snakebids workflows are typically executed through a Python entry point (e.g., `run.py`) that wraps the Snakemake execution.

### Standard Execution Pattern
The basic syntax for running a Snakebids-based BIDS App is:
`python run.py <input_bids_dir> <output_dir> <analysis_level> [options]`

*   **analysis_level**: Usually `participant` or `group`.
*   **--participant-label**: Filter the dataset to specific subjects (e.g., `--participant-label 01 02`).
*   **--bids-filter-file**: Path to a JSON file for complex Pybids filtering.

### Advanced Filtering via CLI
You can provide entity-specific filters directly on the command line to narrow down inputs:
`python run.py data/bids out/ participant --filter-<entity>=<value>`

Example:
`python run.py data/bids out/ participant --filter-t1w acquisition=preproc`

## Workflow Development Best Practices

### BIDS Path Construction
Use the `bids()` function within your Snakefile to ensure all output paths follow BIDS naming conventions. This avoids manual string formatting and ensures consistency.

```python
from snakebids import bids

# Example: Constructing a derivative path
rule align_t1:
    input:
        t1w = bids(subject="{subject}", suffix="T1w.nii.gz")
    output:
        aligned = bids(root="derivatives", subject="{subject}", desc="aligned", suffix="T1w.nii.gz")
```

### Input Generation
Leverage `generate_inputs()` to automatically populate Snakemake wildcards based on the contents of the BIDS directory. This function queries the BIDS layout and returns a `BidsDataset` object containing the discovered entities.

### Handling Optional Entities
When working with entities that may not exist for all subjects (like `session` or `acquisition`), use the `SnakemakeWildcards` class or the `get()` method on `BidsComponent` to handle runtime file retrieval without breaking the Snakemake DAG.

## Expert Tips
*   **Dry Runs**: Since Snakebids wraps Snakemake, you can pass standard Snakemake arguments like `-n` (dry-run) or `-p` (print commands) through the CLI.
*   **Plugin System**: Use the Snakebids plugin system to extend CLI functionality, such as adding custom version reporting or specialized data validation steps.
*   **UV Integration**: For development, Snakebids utilizes `uv`. Use `uv run poe quality` and `uv run poe test` to maintain code standards if contributing to or extending the core library.

## Reference documentation
- [Snakebids GitHub Repository](./references/github_com_khanlab_snakebids.md)
- [Snakebids Wiki](./references/github_com_khanlab_snakebids_wiki.md)
- [Bioconda Snakebids Overview](./references/anaconda_org_channels_bioconda_packages_snakebids_overview.md)