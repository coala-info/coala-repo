---
name: needle
description: Needle is a specialized bioinformatics tool designed for high-throughput sequence analysis.
homepage: https://github.com/seqan/needle
---

# needle

## Overview
Needle is a specialized bioinformatics tool designed for high-throughput sequence analysis. It leverages Interleaved Bloom Filters (IBF) and a windowing scheme (minimizers) to store and query sequence occurrences across many experiments simultaneously. It is particularly effective for researchers who need to screen large sequence collections for specific transcripts or genes to approximate expression levels without the computational overhead of full sequence alignment.

## Core Workflows

### 1. Building a Needle Index (Recommended Workflow)
For better performance and data management, it is recommended to calculate minimizers before building the final index.

**Step A: Calculate Minimizers**
Generate binary `.minimiser` files from your sequence data.
```bash
needle minimiser path/to/experiments/*.fasta --paired
```

**Step B: Build the IBF Index**
Construct the index using the pre-calculated minimizer files.
```bash
needle ibfmin *.minimiser -e 16 -e 32 -f 0.3 -c -o my_index
```
*   `-e`: Sets expression thresholds (multiple thresholds allowed).
*   `-f`: Specifies the false positive rate (e.g., 0.3).
*   `-c`: Enables index compression.
*   `-o`: Defines the output directory for the index.

### 2. Direct Index Construction
You can build an index directly from sequence files in one step, though this is less flexible for large datasets.
```bash
needle ibf path/to/data/*.fastq -e 10 -f 0.05 -o direct_index
```

### 3. Estimating Expression (Querying)
Once an index is built, use the `estimate` command to find the expression levels of specific transcripts.
```bash
needle estimate query_transcripts.fasta -i my_index -o results.out
```
*   `-i`: Path to the existing Needle index.
*   `-o`: Output file for the expression results (defaults to `expressions.out`).

### 4. Index Maintenance
Needle allows for the modification of existing uncompressed indices.

**Inserting New Data:**
```bash
# Using sequence files
needle insert new_data/*.fasta --paired -i my_index

# Using minimizer files
needle insertmin new_data.minimiser -i my_index
```

**Deleting Experiments:**
Remove an experiment by its position in the index. Note that this frees space for future insertions but does not shrink the physical file size.
```bash
needle delete -i my_index 0
```

## Expert Tips and Best Practices
*   **Threshold Selection**: Use multiple `-e` flags to create a tiered index. Needle stores minimizers based on their occurrence frequency relative to these thresholds, allowing for semi-quantitative analysis.
*   **False Positive Rate (FPR)**: A lower `-f` value increases accuracy but results in a larger index size. Balance this based on your available memory and required precision.
*   **Paired-End Data**: Always use the `--paired` flag when working with paired-end experiments to ensure both files in a pair are treated as a single experiment.
*   **Compression**: Use the `-c` flag during the `ibf` or `ibfmin` stage to significantly reduce the disk footprint of your index, especially when dealing with many experiments.
*   **Input Formats**: Needle supports all sequence formats compatible with SeqAn3, including FASTA, FASTQ, and EMBL, as well as their Gzip-compressed versions.

## Reference documentation
- [Needle GitHub Repository](./references/github_com_seqan_needle.md)
- [Bioconda Needle Overview](./references/anaconda_org_channels_bioconda_packages_needle_overview.md)