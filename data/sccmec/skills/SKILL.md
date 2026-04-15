---
name: sccmec
description: sccmec automates the typing and subtyping of SCCmec cassettes in bacterial genome assemblies using BLAST-based searches against a curated database. Use when user asks to type SCCmec cassettes, characterize MRSA genomic assemblies, or identify SCCmec regions and targets in bacterial sequences.
homepage: https://github.com/rpetit3/sccmec
metadata:
  docker_image: "quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0"
---

# sccmec

## Overview

sccmec is a specialized bioinformatics tool designed to automate the typing of SCCmec cassettes in bacterial assemblies. It replaces more complex workflows by utilizing the camlhmp API with pre-configured reference targets and regions specific to SCCmec. The tool performs BLAST-based searches against a curated database to provide a final predicted type and subtype, making it an essential utility for genomic surveillance and characterization of methicillin-resistant Staphylococcus aureus (MRSA).

## Installation

The tool is available via Bioconda. It is recommended to install it within a dedicated Conda environment:

```bash
conda create -n sccmec -c conda-forge -c bioconda sccmec
conda activate sccmec
```

## Common CLI Patterns

### Basic Typing
The tool is designed for ease of use; while it has many parameters, the reference data paths are pre-set. You typically only need to provide the input assembly.

```bash
sccmec --input assembly.fasta
```

### Using Compressed Inputs and Custom Prefixes
sccmec natively supports GZip compressed FASTA files. Use the `--prefix` flag to organize outputs when processing multiple samples.

```bash
sccmec --input sample_01.fasta.gz --prefix sample_01 --outdir results/
```

### Adjusting Stringency
If you are working with divergent sequences or low-quality assemblies, you can modify the identity and coverage thresholds for both targets and regions.

```bash
sccmec --input assembly.fasta \
  --min-targets-pident 95 \
  --min-targets-coverage 90 \
  --min-regions-pident 90 \
  --min-regions-coverage 85
```

## Expert Tips and Best Practices

- **Input Requirements**: Ensure your input is a genome assembly (contigs/scaffolds) rather than raw reads. The tool is optimized for finding cassette structures within assembled sequences.
- **Output Interpretation**: The tool generates five files. The primary file to check is `{PREFIX}.tsv`, which contains the final predicted type. The `.details.tsv` files are useful for troubleshooting "Unknown" results or identifying partial hits.
- **Default Parameters**: The default thresholds (Targets: 90% ID, 80% Cov; Regions: 85% ID, 83% Cov) are the recommended values for standard SCCmec typing. Only adjust these if you have a specific biological reason to expect lower homology.
- **Avoid Redundant Flags**: Although the help menu shows flags like `--yaml-targets` and `--targets`, these are automatically populated with SCCmec defaults. Do not manually specify these unless you are an advanced user implementing a custom typing scheme.
- **Batch Processing**: When processing multiple assemblies, always use the `--prefix` flag to prevent the tool from overwriting the default `sccmec.tsv` output file.

## Reference documentation
- [sccmec - A tool for typing SCCmec cassettes in assemblies](./references/github_com_rpetit3_sccmec.md)
- [sccmec - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sccmec_overview.md)