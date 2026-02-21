---
name: bactopia-sketcher
description: bactopia-sketcher is a specialized utility within the Bactopia framework designed to generate "sketches" of genomic data using minmer (MinHash) algorithms.
homepage: https://bactopia.github.io/
---

# bactopia-sketcher

## Overview
bactopia-sketcher is a specialized utility within the Bactopia framework designed to generate "sketches" of genomic data using minmer (MinHash) algorithms. These sketches act as compact digital signatures of raw sequencing reads or assembled contigs, allowing for near-instantaneous comparison of large genomic datasets. It is primarily used to estimate genetic distance, identify species, and screen for contamination before committing to more computationally expensive alignment-based analyses.

## Usage Guidelines

### Core Functionality
The tool automates the creation of Mash and Sourmash sketches. These sketches are essential for:
- **Rapid Distance Estimation**: Quickly calculating how closely related two samples are.
- **Taxonomic Screening**: Comparing a sample against a reference database (like RefSeq) to confirm species identity.
- **Quality Control**: Detecting potential sample mix-ups or significant contamination.

### Common CLI Patterns
While typically invoked as part of the `bactopia` workflow, the standalone tool follows standard Conda-based execution patterns.

1. **Installation**
   Ensure the tool is available in your environment:
   ```bash
   conda install -c bioconda bactopia-sketcher
   ```

2. **Sketch Generation**
   When using the tool, you generally provide genomic fasta or fastq files. The tool processes these into `.msh` (Mash) or `.sig` (Sourmash) formats.

### Best Practices
- **Input Quality**: Ensure raw reads have undergone basic QC (e.g., adapter trimming) before sketching to avoid signatures dominated by sequencing artifacts.
- **K-mer Size**: Use the default k-mer sizes (typically k=21 for species identification) unless your specific organism requires higher sensitivity for closely related strains (k=31).
- **Sketch Size**: A sketch size of 10,000 is standard for bacterial genomes to balance accuracy and file size.
- **Integration**: Use these sketches as the input for `bactopia-tools` modules like `mashdist` or `gtdb` to automate taxonomic classification.

## Reference documentation
- [bactopia-sketcher Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-sketcher_overview.md)
- [Bactopia Introduction](./references/bactopia_github_io_index.md)