---
name: fastmlst
description: FastMLST is a high-speed tool designed for the rapid identification of bacterial sequence types from draft genome assemblies.
homepage: https://github.com/EnzoAndree/FastMLST
---

# fastmlst

## Overview

FastMLST is a high-speed tool designed for the rapid identification of bacterial sequence types from draft genome assemblies. It automates the scanning of assemblies against PubMLST schemes and is optimized for performance through multi-core processing. Beyond simple typing, it facilitates downstream evolutionary studies by providing concatenated or split allele sequences ready for alignment and phylogenetic analysis.

## Installation

Install via Conda (recommended) or pip:

```bash
conda install -c bioconda fastmlst
# OR
pip install git+https://github.com/EnzoAndree/FastMLST.git
```

## Common CLI Patterns

### Basic Typing
Run a simple scan on a single assembly or a directory of assemblies:

```bash
# Single file
fastmlst assembly.fasta

# Compressed files
fastmlst assembly.fasta.gz

# Batch processing
fastmlst *.fasta
```

### Scheme Management
Identify the correct scheme for your organism:

```bash
# List all 150+ supported schemes
fastmlst --scheme-list

# Force a specific scheme (useful if species is ambiguous)
fastmlst --scheme cdifficile assembly.fasta
```

### Output Customization
Modify the output format for compatibility with other tools:

```bash
# Change separator to tab (default is comma)
fastmlst -s '\t' assembly.fasta

# Save results to a file
fastmlst -to results.csv assembly.fasta

# Use the modern table format (easier for PHYLOViZ)
fastmlst --scheme cdifficile assembly.fasta
```

### Phylogenetic Preparation
Generate files for downstream sequence alignment:

```bash
# Generate concatenated alleles for all analyzed genomes
fastmlst --scheme cdifficile *.fasta

# Export alleles into individual FASTA files (one per locus)
fastmlst --scheme cdifficile *.fasta --splited-output output_dir
```

## Expert Tips

- **Performance**: FastMLST attempts to use all available CPU cores by default. Use `-t <threads>` to limit resource usage in shared environments.
- **Phylogenetics**: The tool automatically handles allele concatenation. If a genome is missing from the concatenated output, check for "N" bases in the alleles, missing alleles, or potential contamination (multiple alleles detected for a single locus).
- **Legacy Support**: If your downstream pipeline requires the older FastMLST output format while using the `--scheme` flag, append the `--legacy` option.
- **Input Flexibility**: The tool natively supports `.fasta`, `.gz`, and `.bz2` formats, eliminating the need for manual decompression before scanning.

## Reference documentation
- [FastMLST GitHub Repository](./references/github_com_EnzoAndree_FastMLST.md)
- [FastMLST Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastmlst_overview.md)