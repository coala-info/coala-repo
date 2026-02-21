---
name: gembs
description: gemBS is a high-performance bioinformatics pipeline optimized for processing large-scale WGBS datasets.
homepage: https://github.com/heathsc/gemBS
---

# gembs

## Overview
gemBS is a high-performance bioinformatics pipeline optimized for processing large-scale WGBS datasets. It integrates the GEM3 aligner and the bs_call engine to provide a streamlined workflow from raw fastq files to methylation calls and SNP detection. This skill provides guidance on the native command-line interface (CLI) for managing the pipeline, indexing references, and executing the mapping and calling stages efficiently.

## Installation and Setup
The most reliable way to deploy gembs is via Conda or by building from source to ensure all submodules (GEM3, bs_call) are correctly compiled.

- **Conda**: `conda install -c bioconda gembs`
- **Source**: Use `git clone --recursive` to ensure submodules are included, then run `python3 setup.py install --user`.

## Core Workflow Commands
The gembs pipeline operates through a master wrapper script that manages the project database and task execution.

### 1. Project Initialization
Prepare the environment and project database.
- `gemBS prepare`: Initializes the project and creates the `.gemBS` hidden directory containing the SQLite database.
- `gemBS db-sync`: Synchronizes the database if manual changes are made to the configuration or if a run was interrupted.

### 2. Indexing the Reference
Before mapping, the reference genome must be indexed for both the GEM3 mapper and the bs_call engine.
- `gemBS index`: Generates the GEM3 index and the required `.fai` (faidx) index for the reference.

### 3. Mapping and Calling
- `gemBS map`: Executes the alignment of bisulfite-converted reads.
- `gemBS call`: Performs the methylation and variant calling.
- `gemBS extract`: Extracts methylation values into various formats (e.g., bedGraph, bigWig).

## Expert Tips and Best Practices

### Resource Management
- **Thread Control**: Use the `-t` or `--threads` flag in the mapping and calling stages to maximize throughput. gemBS is designed for high-concurrency environments.
- **Memory Optimization**: For large genomes, ensure you have sufficient RAM for the GEM3 index. If memory is a bottleneck, use the `--memory` switches available in version 3.4.0+ to cap usage during the calling stage.

### Handling Large Contigs
- gemBS processes contig pools from largest to smallest to prevent "tailing" (where one large chromosome remains processing long after others are finished). If you restart a run, always redo `gemBS prepare` and `gemBS db-sync` to ensure the database format is consistent with the pool ordering.

### Output Formats
- **CRAM Support**: To save disk space, enable CRAM output by setting the `make_cram` option in your configuration file.
- **Benchmark Mode**: Use the `--benchmark-mode` flag to produce deterministic output files (removing timestamps and version strings from headers), which is essential for pipeline validation and diff-testing.

### Troubleshooting bs_call
- If `bs_call` fails with range check errors, ensure your conversion parameters (under-conversion and over-conversion rates) are between 0 and 1.
- For strand-specific analysis, verify if your library is a standard or reverse conversion protocol. Use the `reverse_conversion` option if Read 1 is G2A converted and Read 2 is C2T converted.

## Reference documentation
- [gemBS GitHub Repository](./references/github_com_heathsc_gemBS.md)
- [Bioconda gembs Overview](./references/anaconda_org_channels_bioconda_packages_gembs_overview.md)