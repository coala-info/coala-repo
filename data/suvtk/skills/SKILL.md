---
name: suvtk
description: The Submission of Uncultivated Viral genomes toolkit (`suvtk`) is a specialized command-line utility designed to streamline the transition from viral genomic assemblies to formal GenBank submissions.
homepage: https://github.com/LanderDC/suvtk
---

# suvtk

## Overview
The Submission of Uncultivated Viral genomes toolkit (`suvtk`) is a specialized command-line utility designed to streamline the transition from viral genomic assemblies to formal GenBank submissions. It automates the technical hurdles of NCBI submission by integrating gene prediction (via Pyrodigal-rv) and metadata formatting, ensuring that uncultivated viral data meets the specific structural requirements of the GenBank database.

## Installation and Setup
Install `suvtk` via Bioconda for the most stable environment:
```bash
conda install bioconda::suvtk
```
For development or testing the latest features, install from the repository:
```bash
pip install -e .
```

## Core CLI Usage
The primary entry point for the tool is the `suvtk` command.

### Getting Help
Access the full list of subcommands and options:
```bash
suvtk --help
# OR
python -m suvtk --help
```

### ORF Prediction Patterns
`suvtk` uses `pyrodigal-rv` for robust gene calling in viral genomes. 
- **Phage Genomics**: When working with bacteriophages, ensure you utilize the phage-specific ORF prediction logic.
- **Translation Tables**: Recent versions (v0.1.6+) automatically determine the appropriate translation table via `pyrodigal-rv`, so manual specification is typically no longer required.

### Performance Optimization
- **Threading**: The tool defaults to `auto` for thread counts, which optimizes performance based on the available CPU resources. You do not need to manually specify thread counts unless you need to restrict the tool's footprint on a shared cluster.

### Data Preparation Best Practices
- **Metadata Validation**: `suvtk` includes a `safe_read_csv` function that validates ASCII characters. Ensure your metadata CSV files are encoded in standard ASCII to avoid submission errors.
- **Sequence Input**: Ensure your viral sequences are in standard FASTA format before processing.

## Expert Tips
- **Uncultivated Viruses**: The tool is specifically tuned for "uncultivated" viral genomes. If your sequences are from isolated cultures, verify if standard GenBank submission tools (like Table2asn) might be more appropriate, though `suvtk` handles the metadata overhead for environmental samples more efficiently.
- **Version Checking**: Use `suvtk --version` to ensure you are on at least v0.1.6, as this version includes critical updates to the ORF prediction engine and threading logic.

## Reference documentation
- [suvtk Overview](./references/anaconda_org_channels_bioconda_packages_suvtk_overview.md)
- [suvtk GitHub Repository](./references/github_com_LanderDC_suvtk.md)
- [suvtk Commit History](./references/github_com_LanderDC_suvtk_commits_main.md)