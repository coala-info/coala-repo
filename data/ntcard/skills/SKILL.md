---
name: ntcard
description: ntCard is a memory-efficient streaming algorithm designed to analyze the k-mer composition of genomic data.
homepage: https://github.com/bcgsc/ntCard
---

# ntcard

## Overview
ntCard is a memory-efficient streaming algorithm designed to analyze the k-mer composition of genomic data. Instead of performing a full k-mer count, which is computationally expensive, ntCard provides statistical estimates of k-mer abundance. It is primarily used for genome size estimation, assessing library complexity, and identifying the frequency distribution of k-mers (the "k-mer spectrum") to inform downstream assembly or analysis parameters.

## Basic Usage

The standard command structure requires a k-mer size and an output prefix:

```bash
ntcard -k<kmer_size> -p <output_prefix> <input_files>
```

### Common Examples

**Single k-mer analysis:**
```bash
ntcard -k64 -p sample_k64 reads.fastq
```

**Multiple k-mer sizes in one pass:**
ntCard can efficiently calculate statistics for multiple k-mer lengths simultaneously.
```bash
ntcard -k32,64,96,128 -p multi_k reads.fq.gz
```

**Processing a large list of files:**
If you have many input files, provide a text file containing the paths, prefixed with `@`.
```bash
ntcard -k48 -t16 -p project_stats @file_list.txt
```

## Command Line Options

| Option | Description | Default |
| :--- | :--- | :--- |
| `-t, --threads=N` | Number of parallel threads. Use N >= 2 for multiple input files. | 1 |
| `-k, --kmer=N` | The length of k-mer (comma-separated for multiple). | Required |
| `-c, --cov=N` | The maximum coverage frequency to include in the histogram. | 1000 |
| `-p, --pref=STR` | Prefix for output file names. | None |
| `-o, --output=STR` | Specific name for a single compact output file. | None |

## Best Practices and Expert Tips

- **Thread Optimization**: For optimal performance, set `-t` to match the number of available CPU cores, especially when processing multiple input files or compressed data.
- **Input Formats**: ntCard natively supports `.fasta`, `.fastq`, `.sam`, and `.bam`. It can also handle compressed versions (`.gz`, `.bz2`, `.xz`) automatically.
- **Memory Efficiency**: Because it uses a streaming approach (HyperLogLog and Bloom filters), ntCard uses significantly less RAM than tools like Jellyfish or KMC, making it suitable for very large datasets on standard workstations.
- **Output Interpretation**:
    - **F0**: Number of distinct k-mers (useful for genome size estimation).
    - **F1**: Total number of k-mers in the dataset.
    - **F2**: Gini index of variation (diversity of k-mers).
    - **F∞**: Frequency of the most abundant k-mer.
- **Histogram Files**: The output `.hist` files are tab-separated with three columns: `k` (k-mer size), `f` (frequency), and `n` (number of k-mers with that frequency). These are easily plotted in R or Python to visualize the k-mer spectrum.

## Reference documentation
- [ntCard GitHub Repository](./references/github_com_bcgsc_ntCard.md)
- [ntCard Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ntcard_overview.md)