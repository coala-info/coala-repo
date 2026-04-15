---
name: ntstat
description: ntStat is a bioinformatics toolkit for efficient k-mer analysis and genome characterization using Bloom filters. Use when user asks to generate k-mer statistics, filter k-mers by frequency, estimate genome size and heterozygosity, or query Bloom filters for specific sequences.
homepage: https://github.com/bcgsc/ntStat
metadata:
  docker_image: "quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2"
---

# ntstat

## Overview

ntStat is a specialized bioinformatics toolkit designed for efficient k-mer analysis using Bloom filters. It allows researchers to track both k-mer counts (Term Frequency) and depth information (Document Frequency) across sequencing datasets. Beyond simple counting, it provides a mixture model to analyze k-mer histograms, which is essential for de novo genome characterization—estimating genome size, heterozygosity, and identifying erroneous k-mers. It is particularly useful for preparing filtered k-mer sets for downstream assembly or alignment tasks where memory efficiency is critical.

## Core Workflows

### 1. Generating k-mer Statistics (count)
Use the `count` module to generate two counting Bloom filters (CBFs): one for k-mer counts and one for depths.
*   **Requirement**: You must first run `ntCard` to generate a k-mer spectrum file (`-f`).
*   **Pattern**: `ntstat count -k <length> -f <ntcard_hist> -o <output_prefix> <reads.fastq>`
*   **Optimization**: For PacBio or Nanopore data, always include the `--long` flag to optimize the data structure for long-read error profiles.

### 2. Filtering k-mers (filter)
Extract a specific subset of k-mers based on their frequency. This is often used to remove low-frequency (likely erroneous) k-mers or high-frequency (repetitive) k-mers.
*   **Thresholds**: Use `-cmin` and `-cmax`. Setting `-cmin 0` will automatically attempt to find the first minimum in the histogram to separate error k-mers from genomic k-mers.
*   **Memory Trade-off**: By default, `filter` outputs a standard Bloom filter (1 bit per k-mer). Use `--counts` to output a Counting Bloom filter (8 bits per k-mer) if you need to preserve the actual frequency values.

### 3. Histogram Analysis (hist)
Fit a mixture model to the k-mer spectrum to infer genomic properties.
*   **Usage**: `ntstat hist <ntcard_hist>`
*   **Insights**: This command provides estimates for genome size, heterozygosity, and the probability of a k-mer being an error given its count.
*   **Visualization**: Use `-o <plot.png>` to generate a visual representation of the model fit.

### 4. Querying Filters (query)
Convert the binary Bloom filter data back into a human-readable TSV format for specific sequences.
*   **Usage**: `ntstat query -b <filter.bf> -o <output.tsv> <query_sequences.fasta>`

## Expert Tips and Best Practices

*   **Spaced Seeds**: For increased sensitivity in certain comparative genomics tasks, use spaced seeds instead of contiguous k-mers by providing a seed pattern file with `-s`. When using seeds, the `-k` parameter is ignored.
*   **False Positive Control**: The default false positive rate is `0.0001` (`-e`). If you are working with extremely large genomes or limited RAM, you can manually set the filter size in bytes using `-b`.
*   **Thread Scaling**: ntStat is multi-threaded. Use `-t` to match your available CPU cores, especially during the `count` and `filter` stages which are compute-intensive.
*   **Input Support**: The tool natively supports FASTA, FASTQ, and BAM formats, including compressed (`.gz`) versions. You can stream data via stdin using `-`.



## Subcommands

| Command | Description |
|---------|-------------|
| count | Count k-mers from sequencing data using a k-mer spectrum file. |
| filter | Filters k-mer spectra based on various criteria. |
| ntstat | Generates a histogram from k-mer spectrum data. |
| query | Query ntstat database |

## Reference documentation

- [ntStat README](./references/github_com_BirolLab_ntStat_blob_main_README.md)
- [ntStat Main Repository](./references/github_com_BirolLab_ntStat.md)