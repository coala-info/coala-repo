---
name: needle
description: Needle performs semi-quantitative analysis of large nucleotide sequence datasets using Interleaved Bloom Filters to efficiently store and query sequence information. Use when user asks to calculate minimizers, build or update an index, and estimate gene or transcript expression levels across experiments.
homepage: https://github.com/seqan/needle
---


# needle

## Overview
Needle is a bioinformatics tool designed for the semi-quantitative analysis of massive nucleotide sequence datasets. It utilizes Interleaved Bloom Filters (IBF)—a probabilistic data structure—combined with a minimizer-based windowing scheme to store and query sequence information efficiently. It is particularly useful for researchers needing to "pre-filter" large collections of expression experiments to identify where specific genes or transcripts are likely expressed without performing full alignment.

## CLI Usage and Best Practices

### 1. Minimizer Calculation (Recommended First Step)
While you can build an index directly from sequence files, it is significantly more efficient to pre-calculate minimizers. This process generates `.minimiser` binary files containing hashes and occurrence counts.

```bash
# Calculate minimisers for paired-end experiments
needle minimiser path/to/data/*.fasta --paired
```

### 2. Building the Needle Index
The index is built using specific expression thresholds (`-e`). Data is stored in the IBF based on whether its occurrence meets these thresholds.

**Using Minimizer Files (Efficient):**
```bash
# Build a compressed index with thresholds 16 and 32 and a 0.3 false positive rate
needle ibfmin *.minimiser -e 16 -e 32 -f 0.3 -c -o my_index
```

**Directly from Sequence Files:**
```bash
needle ibf path/to/data/*.fasta --paired -e 16 -e 32 -f 0.3 -c -o my_index
```

### 3. Estimating Expression
To query the index for a specific transcript or gene, use the `estimate` command. This compares the query sequence against the stored IBF levels.

```bash
# Estimate expression of a gene against the built index
needle estimate path/to/gene.fasta -i my_index -o results.out
```

### 4. Updating an Index
You can add new experiments to an existing **uncompressed** index. Note that the false positive rate and hash functions cannot be changed once the index is created.

```bash
needle insert new_experiment.minimiser -i my_index
```

## Expert Tips
- **Threshold Selection**: The thresholds (`-e`) define the "bins" of expression. If you set `-e 16 -e 32`, Needle will categorize sequences into those with occurrences $\ge 16$ and $\ge 32$.
- **Compression**: Always use the `-c` flag for the final index unless you plan to use `needle insert` later, as insertion requires an uncompressed index.
- **False Positive Rate (`-f`)**: A lower FPR increases the size of the index. 0.3 is a common starting point for large-scale pre-filtering where space efficiency is a priority.
- **Paired-end Data**: Ensure the `--paired` flag is used consistently if your library preparation is paired-end to ensure correct minimizer counting.



## Subcommands

| Command | Description |
|---------|-------------|
| needle | Needle allows you to build an Interleaved Bloom Filter (IBF) with the command ibf or estimate the expression of transcripts with the command estimate. |
| needle | Needle allows you to build an Interleaved Bloom Filter (IBF) with the command ibf or estimate the expression of transcripts with the command estimate. |
| needle | Needle allows you to build an Interleaved Bloom Filter (IBF) with the command ibf or estimate the expression of transcripts with the command estimate. |
| needle | Needle allows you to build an Interleaved Bloom Filter (IBF) with the command ibf or estimate the expression of transcripts with the command estimate. |
| needle-count | Get expression value depending on minimizers. This function is only used to test the validity of Needle's estimation approach. It estimates the expression value for all sequences in the genome file based on the exact minimiser occurrences of the given sequence files. |

## Reference documentation
- [Needle GitHub Repository](./references/github_com_seqan_needle_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_needle_overview.md)