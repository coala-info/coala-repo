---
name: microhapulator
description: MicroHapulator is a specialized bioinformatics suite designed for the forensic analysis of microhaplotypes.
homepage: https://github.com/bioforensics/MicroHapulator/
---

# microhapulator

## Overview
MicroHapulator is a specialized bioinformatics suite designed for the forensic analysis of microhaplotypes. It provides a streamlined workflow for calling haplotypes from raw Illumina sequencing data, interpreting results for forensic applications, and generating simulated datasets for testing and development. The tool is built to be flexible, supporting both standard marker panels via MicroHapDB and custom user-defined panels.

## Core CLI Usage
The primary command-line interface for the toolkit is `mhpl8r`.

### Primary Subcommands
- `mhpl8r pipe`: The main entry point for running the full analysis pipeline. Use this for automated, end-to-end processing of sequencing samples.
- `mhpl8r seq`: Used for empirical haplotype calling. This command processes sequence data to identify specific microhaplotype alleles.
- `mhpl8r filter`: Applies filters to called haplotypes or sequence reads. 
- `mhpl8r contribution`: (Inferred) Used for simulating or analyzing multi-contributor samples and forensic mixtures.

### Common CLI Patterns
- **Filtering with References**: Use the `--reference` flag with the filter command to specify a reference genome or marker set:
  `mhpl8r filter --reference <ref.fasta> <input_file>`
- **Custom Targets**: The pipeline supports custom marker definitions. Ensure your target files are formatted according to MicroHapDB standards before passing them to `mhpl8r pipe`.
- **Identifier Validation**: When calling sequences with `mhpl8r seq`, ensure sample identifiers are unique and valid to prevent downstream reporting errors.

## Workflow Best Practices
- **Environment Management**: Install MicroHapulator via Conda (`conda install -c bioconda microhapulator`). For Windows environments, the tool must be run within Windows Subsystem for Linux (WSL2).
- **Marker Preparation**: Use MicroHapDB to prepare marker definitions, population frequencies, and reference sequences. This ensures compatibility with the `mhpl8r` internal logic.
- **Simulation for Testing**: Before analyzing critical forensic samples, use the simulation tools to construct mock genotypes. This helps in establishing baseline performance for single- and multiple-contributor samples.
- **Snakemake Integration**: MicroHapulator supports Snakemake 8+. If running large batches, ensure your Snakemake environment is correctly configured to handle the tool's parallelization.

## Expert Tips
- **Portable Reports**: When generating final analysis reports, use the portable report directory feature to ensure that HTML summaries and associated assets can be shared without breaking links.
- **Coordinate Systems**: Ensure that all marker coordinates are provided in GRCh38 format, as this is the mandatory coordinate system for recent versions of the tool.
- **Handling Gaps**: In recent versions (0.8.1+), the tool marks gaps in sequences rather than discarding the reads entirely, which can improve the recovery of information in low-coverage regions.

## Reference documentation
- [MicroHapulator Overview](./references/anaconda_org_channels_bioconda_packages_microhapulator_overview.md)
- [GitHub Repository and README](./references/github_com_bioforensics_MicroHapulator.md)
- [CLI and Issue Reference](./references/github_com_bioforensics_MicroHapulator_issues.md)