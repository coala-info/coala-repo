---
name: sdust
description: "sdust identifies low-complexity regions in DNA sequences using the symmetric DUST algorithm. Use when user asks to find low-complexity regions, mask genomic sequences, or identify simple repeats in FASTA files."
homepage: https://github.com/lh3/sdust
---


# sdust

## Overview

`sdust` is a high-performance implementation of the symmetric DUST algorithm used to identify regions of low linguistic complexity within DNA sequences (such as simple repeats). It is designed to be a faster, standalone replacement for NCBI's `dustmasker`, producing identical results except in assembly gaps. It is particularly useful in bioinformatics pipelines where genomic sequences must be masked before alignment or assembly to prevent non-specific mapping.

## Common CLI Patterns

### Basic Usage
The most common way to run `sdust` is to provide a FASTA file. By default, it outputs the coordinates of low-complexity regions to standard output.

```bash
sdust input.fasta > low_complexity_regions.bed
```

### Adjusting Sensitivity
While the default parameters are suitable for most genomic applications, you can tune the algorithm using the following flags:

*   **Threshold (`-t`)**: Controls the complexity score threshold. A lower threshold is more aggressive, identifying more regions as low-complexity. (Default: 20).
*   **Window Size (`-w`)**: Sets the window size for the DUST algorithm. (Default: 64).

```bash
# More aggressive masking with a lower threshold
sdust -t 15 input.fasta > masked_regions.bed
```

## Expert Tips and Best Practices

### Masking Sequences
`sdust` identifies coordinates but does not modify the FASTA file itself. To "mask" a genome (convert low-complexity regions to lowercase or Ns), pipe the output to a tool like `bedtools`:

```bash
sdust genome.fasta | bedtools maskfasta -fi genome.fasta -bed stdin -out masked_genome.fasta
```

### Performance Advantage
Use `sdust` when processing large-scale genomic data or many small contigs. It is approximately four times faster than NCBI's `dustmasker`, making it the preferred choice for high-throughput sequencing (HTS) workflows.

### Handling Multi-FASTA Files
`sdust` natively handles multi-FASTA files, processing each record sequentially and including the sequence identifier in the output coordinates.

## Reference documentation
- [sdust - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sdust_overview.md)
- [GitHub - lh3/sdust: Symmetric DUST for finding low-complexity regions in DNA sequences](./references/github_com_lh3_sdust_blob_master_README.md)
- [Issues · lh3/sdust · GitHub](./references/github_com_lh3_sdust_issues.md)