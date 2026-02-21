---
name: clipkit
description: ClipKIT is a specialized alignment trimming tool designed to enhance phylogenomic inference.
homepage: https://github.com/jlsteenwyk/clipkit
---

# clipkit

## Overview

ClipKIT is a specialized alignment trimming tool designed to enhance phylogenomic inference. Unlike traditional methods that may aggressively remove data based on gap frequency or site consistency, ClipKIT focuses on the evolutionary signal. It identifies and preserves sites that are phylogenetically informative while discarding those that introduce noise. This tool is essential for researchers building phylogenetic trees who need to balance data quantity with signal quality.

## Installation

ClipKIT can be installed via pip or conda. It is recommended to use a virtual environment to manage dependencies.

```bash
# Via pip
pip install clipkit

# Via Conda
conda install bioconda::clipkit
```

## Common CLI Patterns

### Basic Trimming
The most straightforward usage takes an input alignment file (e.g., FASTA) and produces a trimmed version.

```bash
clipkit input.fa
```

### Specifying Output Format
By default, ClipKIT may output in the same format as the input or as an Evolutionary Compression (.ecomp) archive. To force a specific text format like FASTA:

```bash
clipkit input.fa -of fasta
```

### Working with Evolutionary Compression (.ecomp)
ClipKIT natively supports `.ecomp` archives, which bundle the alignment payload with a metadata sidecar.

```bash
# Trim an ecomp archive directly
clipkit input.ecomp

# Note: If the archive uses zstd encoding, ensure the 'zstandard' python module is installed.
```

## Best Practices and Expert Tips

- **Preserve Signal**: Use ClipKIT when your primary goal is accurate tree topology. It is specifically tuned to keep sites that help resolve evolutionary relationships.
- **Storage Efficiency**: Utilize the `.ecomp` format for large-scale phylogenomic projects. It significantly reduces file size while maintaining all necessary metadata for the trimming process.
- **Environment Management**: Always run ClipKIT within a dedicated `venv` or `conda` environment to avoid conflicts with other bioinformatics packages.
- **Citation**: If using ClipKIT for published research, cite: *Steenwyk et al. 2020, PLOS Biology. doi: 10.1371/journal.pbio.3001007*.

## Reference documentation
- [ClipKIT GitHub Repository](./references/github_com_JLSteenwyk_ClipKIT.md)
- [ClipKIT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_clipkit_overview.md)