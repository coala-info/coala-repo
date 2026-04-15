---
name: staphopia-sccmec
description: staphopia-sccmec identifies the Staphylococcal Cassette Chromosome mec type in Staphylococcus aureus genomic assemblies using a primer-based scheme. Use when user asks to predict SCCmec types, identify MRSA subtypes, or analyze Staphopia pipeline results.
homepage: https://github.com/staphopia/staphopia-sccmec
metadata:
  docker_image: "quay.io/biocontainers/staphopia-sccmec:1.0.0--hdfd78af_0"
---

# staphopia-sccmec

## Overview
The `staphopia-sccmec` tool provides a streamlined command-line interface for identifying the Staphylococcal Cassette Chromosome mec (SCCmec) type in *Staphylococcus aureus*. It bridges the gap between raw sequence data and typing logic by using a primer-based scheme. The tool automates the process of running BLAST searches for specific SCCmec primers against your assemblies and then applies internal logic to call the specific type (I-IX) and various subtypes.

## Installation
The recommended way to install the tool is via Bioconda:
```bash
conda install -c bioconda staphopia-sccmec
```

## Common CLI Patterns

### Typing Genomic Assemblies
To predict the SCCmec type directly from a FASTA assembly file:
```bash
staphopia-sccmec --assembly path/to/assembly.fna
```

To process an entire directory of assemblies (default extension is `.fna`):
```bash
staphopia-sccmec --assembly path/to/assembly_dir/
```

### Typing Staphopia Pipeline Results
If you have already processed samples through the Staphopia Analysis Pipeline, you can use the existing BLAST results to make the call:
```bash
staphopia-sccmec --staphopia path/to/staphopia_results/
```

### Output Configuration
By default, the tool produces a tab-delimited table. For automated downstream processing, use the JSON flag:
```bash
staphopia-sccmec --assembly sample.fna --json
```

## Expert Tips and Best Practices

- **Assembly Extensions**: If your assembly files do not end in `.fna` (e.g., they use `.fasta` or `.fa`), specify the extension using the `--ext` flag:
  ```bash
  staphopia-sccmec --assembly ./my_files/ --ext fasta
  ```
- **Sensitivity Tuning**: If you are getting unexpected "False" results for known MRSA strains, consider adjusting the BLAST evalue (default is usually sufficient, but can be modified):
  ```bash
  staphopia-sccmec --assembly sample.fna --evalue 0.01
  ```
- **Mismatch Analysis**: Use the `--hamming` flag to report the Hamming distance (number of mismatches) for each type. This is useful for identifying close matches that might not meet the strict default criteria.
- **Dependency Check**: Before running large batches, verify that BLAST and other dependencies are correctly mapped in your environment:
  ```bash
  staphopia-sccmec --depends
  ```
- **Reference Data**: The tool relies on a specific set of primer data. If you are running the tool from source or in a custom environment, ensure the `--sccmec` path points to the directory containing the SCCmec reference data.

## Reference documentation
- [staphopia-sccmec - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_staphopia-sccmec_overview.md)
- [staphopia/staphopia-sccmec: Predicts Staphylococcus aureus SCCmec type based on primers](./references/github_com_staphopia_staphopia-sccmec.md)