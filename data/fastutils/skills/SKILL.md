---
name: fastutils
description: fastutils is a lightweight C++ toolkit for the rapid processing, analysis, and reformatting of FASTA and FASTQ genomic sequence files. Use when user asks to generate sequence statistics, filter reads by length, subsample data to a specific coverage, interleave paired-end files, or extract specific genomic regions.
homepage: https://github.com/haghshenas/fastutils
---


# fastutils

## Overview
fastutils is a lightweight C++ toolkit designed for the rapid processing and analysis of genomic sequence files. It provides a suite of command-line utilities to handle common bioinformatics tasks such as generating summary statistics, filtering reads by length, interleaving paired-end data, and extracting specific genomic regions. It is particularly useful for initial data assessment and preprocessing of FASTA and FASTQ datasets.

## Common CLI Patterns

### Sequence Statistics and Metrics
To get a quick summary of a dataset, including read counts, total bases, and GC content:
```bash
fastutils stat -i reads.fastq
```

To extract read lengths for distribution analysis (often piped to tools like `datamash` or `R`):
```bash
fastutils length -i reads.fastq
```

### Reformatting and Filtering
Convert FASTQ to FASTA while filtering for a minimum length and wrapping the output:
```bash
fastutils format -i reads.fastq -m 1000 -w 60 > filtered.fasta
```

Common `format` flags:
- `-q`: Force FASTQ output if the input allows.
- `-n`: Remove sequences containing 'N' bases.
- `-d`: Replace read names with a digital index (useful for reducing file size).
- `-p` / `-s`: Add prefixes or suffixes to read headers.

### Coverage-Based Subsampling
fastutils can downsample reads to a specific coverage depth. This requires the estimated genome size (supporting k, m, g suffixes).

Subsample to 25x coverage using the longest reads:
```bash
fastutils subsample -i reads.fastq -d 25 -g 4.6m -l > subsampled.fastq
```

Subsample randomly (use `-s` for reproducibility):
```bash
fastutils subsample -i reads.fastq -d 10 -g 3g -r -s 42 > random_subsample.fastq
```

### Sequence Manipulation
**Reverse Complement**: Generate the reverse complement of all sequences. Use `-l` to output the lexicographically smaller sequence (useful for canonical k-mer representation).
```bash
fastutils revcomp -i input.fa -l > canonical.fa
```

**Subsequence Extraction**: Extract specific coordinates from a large FASTA file.
```bash
fastutils subseq -i genome.fa chr1:100-500 chr2:1000-2000
```

**Scaffold Splitting**: Break sequences into contigs at every occurrence of 'N' bases.
```bash
fastutils cutN -i scaffolds.fa -o contigs.fa
```

### Paired-End Interleaving
Combine two separate R1 and R2 files into a single interleaved file:
```bash
fastutils interleave -1 reads_R1.fastq -2 reads_R2.fastq -q > interleaved.fastq
```

## Expert Tips
- **Piping**: fastutils is designed for streaming. Use `-i -` to read from stdin and `-o -` (or omit `-o` where stdout is default) to pipe between fastutils commands or other tools.
- **Memory Efficiency**: The `subsample` command is optimized for low memory usage, making it suitable for large datasets where other tools might fail.
- **PacBio Headers**: When working with PacBio data, use the `-P` flag in the `format` command to ensure header compatibility.
- **Contig Extraction**: A powerful pattern for extracting contigs from specific chromosomes involves piping:
  `cat genome.fa | fastutils format | grep ">chrX" -A1 | fastutils cutN -i - > chrX_contigs.fa`



## Subcommands

| Command | Description |
|---------|-------------|
| cutN | Cut Ns from fastx sequences |
| fastutils length | Calculates length statistics for sequences in FASTA/FASTQ files. |
| fastutils_format | Format FASTA/FASTQ files |
| fastutils_revcomp | Reverse complement sequences in FASTA/Q format. |
| fastutils_stat | Compute statistics for fasta/q files. |
| interleave | Interleaves paired-end sequencing reads. |
| subsample | Subsamples reads from an input file based on coverage depth and genome size. |
| subseq | Extract subsequences from FASTX files. |

## Reference documentation
- [fastutils README](./references/github_com_haghshenas_fastutils_blob_master_README.md)
- [fastutils Overview](./references/github_com_haghshenas_fastutils.md)