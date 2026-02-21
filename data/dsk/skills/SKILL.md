---
name: dsk
description: DSK (Disk Streaming K-mer counter) is a resource-efficient tool designed to count k-mers in reads or genomes.
homepage: https://github.com/GATB/dsk/
---

# dsk

## Overview

DSK (Disk Streaming K-mer counter) is a resource-efficient tool designed to count k-mers in reads or genomes. Unlike in-memory counters, DSK uses a disk-based approach to handle large datasets on standard hardware with limited RAM. It identifies "solid" k-mers—those appearing more than a specified number of times—and provides utilities for frequency histograms and k-mer comparison plots.

## Core CLI Usage

### Basic K-mer Counting
The primary command identifies k-mers of a specific size that meet a minimum abundance threshold.

```bash
dsk -file input.fastq -kmer-size 31 -abundance-min 3 -out results
```

### Handling Multiple Inputs
DSK accepts multiple files in two ways:
1.  **Comma-separated list**: `dsk -file A1.fa,A2.fa,A3.fa -kmer-size 31`
2.  **Input list file**: Create a text file with one path per line.
    ```bash
    ls -1 *.fastq > read_list.txt
    dsk -file read_list.txt -kmer-size 31
    ```

### Output Conversion
DSK outputs results in a binary HDF5 format by default. Use `dsk2ascii` to convert these to a human-readable format.

```bash
dsk2ascii -file results.h5 -out results.txt
```

## Advanced Workflows

### Generating Histograms
To analyze k-mer coverage distribution, use the `-histo` flag and the provided R scripts for visualization.

```bash
# Generate the histogram data
dsk -file reads.fa -kmer-size 31 -histo 1 -out output_prefix

# Plot using the utility script
Rscript utils/plot-histo.R output_prefix.histo
```

### Assembly vs. Read Comparison (2D Histograms)
To visualize duplication levels or assembly completeness, compare an assembly against a read set. **Note**: The assembly file must be listed first.

```bash
dsk -file assembly.fa,reads.fq -kmer-size 31 -histo2D 1 -out comparison
Rscript utils/plot-histo2D.R comparison.histo2D
```

## Expert Tips and Best Practices

*   **Disk Management**: DSK performance depends on available disk space. Ensure the output or temporary directory (`-out-tmp`) has space several times the size of the input dataset.
*   **Canonical K-mers**: DSK automatically converts k-mers to their canonical representation (the lexicographically smaller of the k-mer and its reverse complement). A count of 5 for "AAA" includes occurrences of "TTT".
*   **Large K-mer Sizes**: If you need k-mer sizes larger than 32 or 64, DSK must be compiled from source with the `DKSIZE_LIST` parameter (e.g., `-DKSIZE_LIST="32 64 96 128"`).
*   **Tuning Performance**: If the execution log shows a high number of "passes" (above 10), increase the `-max-disk` parameter to allow DSK to use more scratch space, which will significantly speed up the process.
*   **Direct HDF5 Access**: If you have `gatb-core` installed, you can inspect specific partitions of the HDF5 output without converting the whole file:
    ```bash
    gatb-h5dump -y -d dsk/solid/0 results.h5
    ```

## Reference documentation
- [DSK Overview on Anaconda](./references/anaconda_org_channels_bioconda_packages_dsk_overview.md)
- [DSK GitHub Repository and Documentation](./references/github_com_GATB_dsk.md)