---
name: decoypyrat
description: DecoyPYrat generates decoy protein databases for estimating false discovery rates in proteomics experiments. Use when user asks to create decoy protein sequences, generate a target-decoy database, or perform sequence shuffling and reversal for mass spectrometry analysis.
homepage: https://github.com/tdido/DecoyPYrat
metadata:
  docker_image: "quay.io/biocontainers/decoypyrat:1.0.1--py_0"
---

# decoypyrat

## Overview
DecoyPYrat is a high-speed tool used in proteomics to create "decoy" protein databases. These decoys are essential for statistical evaluation, allowing researchers to estimate the number of false positive peptide identifications in tandem mass spectrometry experiments. The tool employs a hybrid approach: it reverses protein sequences and swaps cleavage sites with the preceding amino acid. To ensure the decoys are effective, it iteratively shuffles any decoy peptides that happen to match real target sequences until they are unique.

## Installation and Setup
The most efficient way to deploy decoypyrat is via the Bioconda repository.

```bash
# Install using conda
conda install -c bioconda decoypyrat
```

## Command Line Usage
Once installed, the tool can be invoked directly from the command line.

### Basic Execution
To view all available parameters and specific flag requirements (such as input FASTA files and output paths), use the help flag:

```bash
decoypyrat -h
```

If running from a cloned repository source:
```bash
python decoypyrat/decoyPYrat.py -h
```

### Workflow Integration
1. **Input**: Provide a FASTA file containing your target protein sequences.
2. **Processing**: The tool will reverse the sequences, adjust cleavage sites, and perform iterative shuffling to eliminate matches with the target database.
3. **Output**: The resulting decoy FASTA file should typically be concatenated with your target FASTA file to create a "target-decoy" database for use in your search engine (e.g., Mascot, SEQUEST, or MaxQuant).

## Expert Tips and Best Practices
- **Cleavage Site Preservation**: Unlike simple reversal, DecoyPYrat's method of switching cleavage sites ensures that the resulting decoy peptides have similar mass distributions and lengths to the target peptides, which is critical for accurate FDR modeling.
- **Redundancy Check**: The tool's iterative shuffling is a key feature. Always ensure the tool completes its uniqueness check to prevent "decoy hits" that are actually identical to target peptides, which would deflate your FDR.
- **Large Scale Analysis**: DecoyPYrat is optimized for speed and is suitable for large-scale proteomic datasets where traditional shuffling methods might be computationally expensive.

## Reference documentation
- [DecoyPYrat Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_decoypyrat_overview.md)
- [DecoyPYrat GitHub Repository](./references/github_com_tdido_DecoyPYrat.md)