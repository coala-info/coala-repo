---
name: biobloomtools
description: BioBloom Tools provides a high-performance workflow for sequence classification and filtering using Bloom filters. Use when user asks to create Bloom filters from reference genomes, classify sequencing reads, filter host DNA from metagenomic samples, or identify contaminants in datasets.
homepage: https://github.com/bcgsc/biobloom
---


# biobloomtools

## Overview

BioBloom Tools (BBT) provides a high-performance workflow for sequence classification using Bloom filters. By representing reference genomes as probabilistic data structures, it allows for extremely fast k-mer based lookups. This approach is significantly faster than traditional alignment-based methods, making it an excellent choice for filtering out host DNA from metagenomic samples or identifying specific contaminants in large sequencing datasets.

## Core Workflows

### 1. Generating Bloom Filters (biobloommaker)

Before categorizing reads, you must create a Bloom filter from your reference sequences (FastA).

```bash
biobloommaker -p <filter_id> <reference1.fasta> <reference2.fasta>
```

- **-p**: Sets the prefix/ID for the generated files.
- **Output**: Creates a binary filter file (`.bf`) and a metadata information file (`.txt`).
- **Note**: The `.txt` file must always remain in the same directory as the `.bf` file for the categorizer to function.

### 2. Categorizing Sequences (biobloomcategorizer)

Use the generated filters to classify your input reads (FastA/FastQ).

```bash
biobloomcategorizer --fa -p <output_prefix> -f "filter1.bf filter2.bf" <input_reads.fastq>
```

- **--fa / --fq**: Specifies the output format for categorized reads.
- **-f**: A space-separated list of filters to check against.
- **-p**: The directory/prefix for output files.
- **Output**: Generates a `summary.tsv` (classification statistics) and separate sequence files for reads matching each filter.

### 3. Handling Paired-End Data

For paired-end reads, use the `-e` flag to ensure consistency between pairs.

```bash
biobloomcategorizer -e -p <output_prefix> -f "filter.bf" <reads_1.fq> <reads_2.fq>
```

- **-e (--paired)**: Requires both reads in a pair to match the filter to be categorized as a match.
- **-i (--inclusive)**: Use in conjunction with `-e` if you want to count the pair as a match even if only one of the two reads matches the filter.

## Expert Tips and Best Practices

- **Version Compatibility**: Bloom filters are sensitive to version changes. A filter created with version 2.1.x may not work with version 2.2.x. Always regenerate filters if you upgrade the tool to a version where the second digit has changed.
- **Memory Management**: The memory usage of the categorizer is determined by the size of the Bloom filters loaded. Ensure your system has enough RAM to hold all specified `.bf` files simultaneously.
- **Piping Compressed Input**: For `.gz` or `.bz2` files, use process substitution to avoid manual decompression:
  ```bash
  biobloomcategorizer -f "ref.bf" <(zcat reads.fq.gz)
  ```
- **False Positive Rates**: The default false positive rate is 0.075. While sufficient for most QC tasks, you can adjust this during the `biobloommaker` step if your application requires higher precision, though this will increase the filter's memory footprint.

## Reference documentation

- [BioBloom Tools Overview](./references/anaconda_org_channels_bioconda_packages_biobloomtools_overview.md)
- [BioBloom Tools GitHub Repository](./references/github_com_bcgsc_biobloom.md)