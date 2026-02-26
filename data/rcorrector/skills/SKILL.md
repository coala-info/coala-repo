---
name: rcorrector
description: Rcorrector is a kmer-based tool designed to correct sequencing errors in Illumina RNA-seq reads while accounting for non-uniform expression levels. Use when user asks to correct errors in RNA-seq data, fix sequencing mistakes in transcriptomic reads, or process non-uniform sequencing data like single-cell reads.
homepage: https://github.com/mourisl/Rcorrector/
---


# rcorrector

## Overview

Rcorrector (RNA-seq error CORRECTOR) is a specialized tool for correcting sequencing errors in Illumina RNA-seq reads. Unlike many genomic error correctors that assume uniform coverage, Rcorrector utilizes a kmer-based method that accounts for the highly variable expression levels found in transcriptomes. It is also effective for other non-uniform sequencing types, such as single-cell data.

The tool identifies "weak" kmers (those likely containing errors) and attempts to fix them by finding the most likely "solid" kmer path. If a read contains errors that cannot be confidently corrected, it is tagged as unfixable.

## Installation

Rcorrector is most easily installed via Bioconda:

```bash
conda install -c conda-forge -c bioconda rcorrector
```

Alternatively, it can be compiled from source by running `make` in the repository directory. It requires Jellyfish 2 to be available in your PATH.

## Command Line Usage

The primary interface is the Perl wrapper script `run_rcorrector.pl`.

### Basic Execution Patterns

**Paired-end reads (most common):**
```bash
perl run_rcorrector.pl -1 reads_R1.fq -2 reads_R2.fq -t 8
```

**Single-end reads:**
```bash
perl run_rcorrector.pl -s single_reads.fa -t 4
```

**Interleaved paired-end reads:**
```bash
perl run_rcorrector.pl -i interleaved.fq
```

### Key Parameters

| Option | Description | Default |
| :--- | :--- | :--- |
| `-k` | Kmer length (maximum 32). | 23 |
| `-t` | Number of threads to use. | 1 |
| `-od` | Output directory for corrected files. | ./ |
| `-maxcorK` | Maximum number of corrections allowed within a k-bp window. | 4 |
| `-wk` | Proportion of kmers used to estimate the weak kmer threshold. | 0.95 |
| `-ek` | Expected number of kmers (affects memory allocation, not correctness). | 100,000,000 |
| `-tmpd` | Directory for temporary files. | ./ |

## Expert Tips and Best Practices

### Handling Output
Rcorrector generates new files with the extension `.cor.fq` or `.cor.fa`. It modifies the read headers to include metadata about the correction:
- `cor`: Indicates at least one base was corrected.
- `unfixable_error`: Indicates the tool found errors but could not determine the correct base.
- `l:INT m:INT h:INT`: Provides the lowest, median, and highest kmer counts for that read.

### Memory Management
The `-ek` parameter is crucial for large datasets. If the program crashes or runs slowly due to memory swapping, estimate the number of unique kmers in your dataset and provide that value to `-ek` to optimize the Bloom filter and hash table sizes.

### Dealing with Divergent Genomes
For organisms with high heterozygosity or more divergent genomes, consider lowering the `-wk` (weak kmer) threshold. This allows the tool to be more conservative in what it labels as an "error" versus a natural variant.

### Workflow Integration
It is generally recommended to run Rcorrector **before** adapter trimming or quality trimming. Correcting errors first can prevent the loss of reads that might otherwise be discarded due to low-quality scores caused by fixable sequencing errors.

### Resuming Failed Jobs
Use the `-stage` option to restart a process that was interrupted:
- `0`: Start from the beginning.
- `1`: Start from counting kmers.
- `2`: Start from dumping kmer counts.
- `3`: Start from the error correction phase itself.

## Reference documentation
- [Rcorrector GitHub Repository](./references/github_com_mourisl_Rcorrector.md)
- [Bioconda Rcorrector Overview](./references/anaconda_org_channels_bioconda_packages_rcorrector_overview.md)