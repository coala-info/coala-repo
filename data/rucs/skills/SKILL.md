---
name: rucs
description: RUCS automates the discovery of unique core sequences across large genomic datasets.
homepage: https://bitbucket.org/genomicepidemiology/rucs/src/master/
---

# rucs

## Overview
RUCS automates the discovery of unique core sequences across large genomic datasets. Unlike traditional primer design which often focuses on single genes, RUCS identifies sequences that define a specific clade or group of organisms. It is particularly effective for developing highly specific diagnostic assays where you must distinguish a pathogen from its close relatives.

## Core Workflow
The tool operates by comparing a "positive" set of genomes (the targets) against a "negative" set (the background/non-targets).

1.  **Input Preparation**: Organize your genomic data into two distinct directories:
    *   `positive/`: Contains FASTA files of the target organisms.
    *   `negative/`: Contains FASTA files of the non-target organisms.
2.  **Execution**: Run the main rucs command pointing to these directories.
3.  **Filtering**: RUCS applies k-mer based subtraction to eliminate sequences found in the negative set, then identifies the core sequences remaining in the positive set.

## Common CLI Patterns
The basic execution requires paths to your positive and negative datasets:

```bash
rucs -p /path/to/positive_folder -n /path/to/negative_folder -o /path/to/output_directory
```

### Key Parameters
*   `-p, --pos`: Path to the directory containing target genomes (FASTA).
*   `-n, --neg`: Path to the directory containing non-target genomes (FASTA).
*   `-o, --out`: Output directory for results.
*   `-k, --kmer`: Set the k-mer size (default is usually 25). Adjust based on the desired specificity and computational resources.
*   `-m, --min_length`: Minimum length of the unique core sequences to be identified.
*   `-t, --threads`: Number of CPU threads to use for parallel processing.

## Best Practices
*   **Representative Datasets**: The specificity of the primers depends entirely on the quality of the negative set. Include the closest known relatives of your target to minimize false positives.
*   **Memory Management**: RUCS can be memory-intensive when processing hundreds of genomes. Ensure your environment has sufficient RAM or limit the number of concurrent threads.
*   **Sequence Validation**: While RUCS identifies unique sequences, always validate the resulting primer candidates using tools like Primer3 or BLAST to check for secondary structures and melting temperature (Tm) compatibility.

## Reference documentation
- [RUCS Source and Documentation](./references/bitbucket_org_genomicepidemiology_rucs_src_master.md)
- [Bioconda RUCS Package Overview](./references/anaconda_org_channels_bioconda_packages_rucs_overview.md)