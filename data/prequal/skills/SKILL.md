---
name: prequal
description: PREQUAL is a specialized quality control tool designed to be used on raw, unaligned homologous sequences.
homepage: https://github.com/simonwhelan/prequal
---

# prequal

## Overview
PREQUAL is a specialized quality control tool designed to be used on raw, unaligned homologous sequences. It identifies regions within sequences that lack evidence of homology with other sequences in the set by calculating posterior probabilities of homology. By masking these problematic regions (typically with 'X') before alignment, it prevents non-homologous characters from being forced into an alignment, which significantly improves the accuracy of subsequent phylogenetic and evolutionary analyses.

## Installation
The recommended way to install prequal is via Bioconda:
```bash
conda install bioconda::prequal
```

## Basic Usage
The simplest execution uses default parameters, which are optimized for most sequence sets:
```bash
prequal input_file.fasta
```
This generates `input_file.fasta.filtered` by default.

## Command Line Options

### Filtering and Core Regions
*   `-filterthresh X`: Sets the posterior probability threshold for masking. The default is **0.994**. Lowering this value makes the filter more aggressive.
*   `-corerun X`: Defines the number of high-posterior sites required at the start and end to establish a "core region" (default is 3).
*   `-nocore`: Disables the core region requirement, allowing filtering across the entire sequence length.
*   `-filterjoin X`: Bridges gaps between filtered regions if the intervening unfiltered sequence is shorter than X (default is 25).

### Posterior Probability Algorithms
The `-pptype` flag determines how sequences are compared to calculate homology evidence:
*   `-pptype closest [Y]`: (Default) Compares each sequence against its Y closest relatives (default Y=10). Best for large, diverse datasets.
*   `-pptype all`: Performs all-against-all comparisons. Highly accurate but computationally expensive for large datasets.
*   `-pptype longest [Y]`: Compares sequences against the Y longest sequences in the file.

### Output and Statistics
*   `-outsuffix .ext`: Customizes the output filename suffix.
*   `-dosummary`: Generates a summary file (`.summary`) containing basic statistics on masked regions.
*   `-dodetail`: Generates a detailed report (`.detail`) of the filtering process per sequence.
*   `-noPP`: Disables the output of the posterior probability matrix to save disk space.

### Selective Filtering
*   `-nofilterlist file.txt`: Provide a file with one taxon name per line to exclude specific sequences from being masked.
*   `-nofilterword word`: Exclude any sequence whose header contains the specified word.

## Best Practices
*   **Run before alignment**: Always run PREQUAL on unaligned FASTA files. Running it on aligned files is not the intended use case and will not yield correct homology assessments.
*   **Check Summary Stats**: Use `-dosummary` to check how much of your data is being masked. If a significant portion of a critical sequence is masked, consider if the sequence is truly homologous or if the `-filterthresh` needs adjustment.
*   **Large Datasets**: For very large datasets, stick with the default `-pptype closest` to maintain reasonable execution times.
*   **DNA vs Protein**: While often used for proteins, PREQUAL supports DNA sequences. Ensure your input file contains valid IUPAC characters.

## Reference documentation
- [PREQUAL GitHub Repository](./references/github_com_simonwhelan_prequal.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_prequal_overview.md)