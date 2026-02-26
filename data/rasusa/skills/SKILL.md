---
name: rasusa
description: "Rasusa performs unbiased downsampling of genomic sequencing data to a target coverage, base count, or fraction. Use when user asks to subsample reads to a specific coverage, downsample FastQ or BAM files, or reduce sequencing data volume while maintaining read length distribution."
homepage: https://github.com/mbhall88/rasusa
---


# rasusa

## Overview
`rasusa` is a high-performance utility designed for the unbiased downsampling of genomic sequencing data. While many tools subsample by a simple percentage or read count, `rasusa` allows users to target a specific fold-coverage (e.g., 30x). It achieves this by calculating the required base count based on a provided genome size and then randomly selecting reads until that threshold is met. This ensures that the resulting subset maintains the original library's length distribution, which is critical for long-read applications like de novo assembly.

## Common CLI Patterns

### Subsampling Reads (FastQ/Fasta)
To subsample reads to a specific coverage, you must provide the target coverage and the estimated genome size.

```bash
# Subsample to 30x coverage for an E. coli (4.6Mb) genome
rasusa reads --coverage 30 --genome-size 4.6mb input.fq -o output.fq

# Subsample paired-end Illumina reads to 50x coverage
rasusa reads -c 50 -g 3gb -o out.R1.fq -o out.R2.fq in.R1.fq in.R2.fq
```

### Subsampling by Base Count or Fraction
If the genome size is unknown or you prefer a specific volume of data:

```bash
# Subsample to exactly 1Gb of data
rasusa reads --bases 1gb input.fq > output.fq

# Subsample to 10% of the original reads
rasusa reads --frac 0.1 input.fq -o output.fq

# Subsample to a specific number of reads
rasusa reads --num 1000000 input.fq -o output.fq
```

### Subsampling Alignments (SAM/BAM)
The `aln` command subsamples an indexed alignment file to a maximum depth per position.

```bash
# Subsample BAM to 20x coverage and pipe to samtools for sorting
rasusa aln --coverage 20 input.bam | samtools sort -o output.bam
```

## Expert Tips and Best Practices

- **Genome Size Suffixes**: The `--genome-size` (-g) and `--bases` (-b) flags accept human-readable suffixes: `kb`, `mb`, `gb`, and `tb` (case-insensitive).
- **Reproducibility**: Use the `--seed` (-s) flag with a specific integer to ensure the random subsampling produces the same result across different runs.
- **Output Compression**: Use `-O` or `--output-type` to specify the output format (e.g., `g` for gzip, `z` for zstd, `b` for bzip2, `u` for uncompressed). You can also control the compression level with `-l`.
- **Alignment Requirements**: For the `aln` command, the input must be a valid, indexed SAM or BAM file.
- **Streaming**: `rasusa` writes to `stdout` by default if no output file is specified, allowing it to be integrated into pipelines without creating intermediate files.
- **Long-Read Advantage**: Unlike `seqtk`, `rasusa` accounts for read length. This prevents the bias toward shorter or longer reads that can occur when simply taking the first N reads of a file.

## Reference documentation
- [Rasusa GitHub Repository](./references/github_com_mbhall88_rasusa.md)
- [Bioconda Rasusa Overview](./references/anaconda_org_channels_bioconda_packages_rasusa_overview.md)