---
name: jellyfish
description: Jellyfish is a specialized bioinformatics tool designed to handle the high-computational demands of k-mer counting in large-scale genomic data.
homepage: http://www.genome.umd.edu/jellyfish.html
---

# jellyfish

## Overview
Jellyfish is a specialized bioinformatics tool designed to handle the high-computational demands of k-mer counting in large-scale genomic data. It utilizes a hash table implementation to provide high-speed performance while maintaining a low memory footprint. This skill provides the necessary command-line patterns to initialize k-mer counts, merge intermediate results, and query the resulting databases for genomic analysis.

## Core Workflow and Commands

### 1. Counting k-mers
The `count` command is the primary entry point. It processes input fasta or fastq files.

- **Basic Count**:
  `jellyfish count -m <k-mer_length> -s <hash_size> -t <threads> <input_file>`
  - `-m`: Length of the k-mer (e.g., 21, 31).
  - `-s`: Initial hash size (e.g., 100M). Use a size that fits your expected unique k-mer count to avoid rehashing.
  - `-t`: Number of threads for parallel processing.
  - `-C`: Canonical k-mers (counts both the k-mer and its reverse complement as the same entity).

### 2. Merging Results
If counting was performed on multiple files or in chunks, use `merge` to combine the output files.

- **Merge Command**:
  `jellyfish merge -o <output_name>.jf <input_part1>.jf <input_part2>.jf`

### 3. Generating Statistics and Histograms
To understand the k-mer distribution (useful for genome size estimation or error profiling):

- **Histogram**:
  `jellyfish histo <input>.jf > <output>.histo`
- **Statistics**:
  `jellyfish stats <input>.jf`

### 4. Querying the Database
To find the frequency of specific k-mers within a generated jellyfish database:

- **Query**:
  `jellyfish query <input>.jf <k-mer_sequence>`

### 5. Dumping Sequences
To convert the binary jellyfish format back into a human-readable fasta format:

- **Dump**:
  `jellyfish dump <input>.jf > <output>.fa`

## Best Practices
- **Memory Management**: The `-s` parameter is critical. If set too low, Jellyfish will create multiple intermediate files on disk. Aim for a hash size that accommodates the estimated number of unique k-mers in your sample.
- **Canonical K-mers**: Always use the `-C` flag for genomic DNA sequencing data unless your analysis specifically requires strand-specific k-mer counts.
- **Input Formats**: Jellyfish natively handles both `.fasta` and `.fastq` formats. It can also handle gzipped files directly if the system supports transparent decompression.

## Reference documentation
- [Jellyfish Overview](./references/anaconda_org_channels_bioconda_packages_jellyfish_overview.md)