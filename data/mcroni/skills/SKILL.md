---
name: mcroni
description: mcroni automates the characterization of the mcr-1 gene's local genomic environment and identifies associated insertion sequences and plasmid replicons. Use when user asks to characterize mcr-1 genetic contexts, identify ISApl1 insertion sequences, or analyze colistin resistance transposition.
homepage: https://github.com/liampshaw/mcroni
---


# mcroni

## Overview

`mcroni` is a specialized bioinformatics tool designed to automate the characterization of the *mcr-1* gene's local environment. It serves as a wrapper for assessing variation within the genomic context of *mcr-1*, specifically looking for ISApl1 insertion sequences and nearby plasmid replicons. This is essential for understanding the evolutionary history and transposition of colistin resistance, as the composite transposon structure often degrades over time.

## Usage Patterns

### Basic Analysis
To analyze a single genome assembly in FASTA format:

```bash
mcroni --fasta genome.fa --output results_prefix
```

### Batch Processing
To process multiple genomes simultaneously, provide a text file containing the paths to your FASTA files (one per line):

```bash
mcroni --filelist list-of-files.txt --output batch_results
```

### Output Files
The tool generates two primary outputs:
1.  `[prefix]_table.tsv`: A summary table containing information about the *mcr-1* context, including promoter variants and ISApl1 classification.
2.  `[prefix]_sequence.fa`: The extracted local genomic sequences for the identified regions.

## Expert Tips and Best Practices

- **Contig Linearity**: `mcroni` assumes contigs are linear. If *mcr-1* is located near the start or end of a circularized contig (e.g., a complete plasmid), the tool may produce incorrect results or fail to capture the full context.
- **Copy Number**: The tool is designed with the assumption of one *mcr-1* copy per file. While it will provide a warning if multiple copies are detected (often due to high ISApl1 activity), results for multi-copy samples should be scrutinized manually.
- **ISApl1 Identification**: Use the output table to determine if the *mcr-1* gene is part of a full composite transposon or a "degraded" structure where one or both ISApl1 elements have been lost.
- **Input Validation**: Ensure your file list for `--filelist` contains absolute paths or paths relative to the execution directory to avoid file-not-found errors during batch runs.

## Reference documentation
- [mcroni GitHub Repository](./references/github_com_liampshaw_mcroni.md)
- [mcroni Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mcroni_overview.md)