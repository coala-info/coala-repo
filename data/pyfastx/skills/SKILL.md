---
name: pyfastx
description: pyfastx provides fast random access and indexing for plain or gzipped FASTA and FASTQ files using a lightweight Python C extension. Use when user asks to build sequence indexes, calculate assembly statistics, extract subsequences, sample reads, split large files, or convert FASTQ to FASTA.
homepage: https://github.com/lmdu/pyfastx
---

# pyfastx

## Overview
pyfastx is a lightweight Python C extension designed for fast, random access to plain and gzipped FASTA/FASTQ files. By building a persistent SQLite3 index, it allows for efficient sequence retrieval and manipulation without loading entire files into memory. It is an essential tool for bioinformaticians working with large-scale genomic data who require speed and low memory footprints for tasks like assembly evaluation, sequence subsetting, and format conversion.

## Core CLI Patterns

The `pyfastx` command-line interface provides several subcommands for common sequence processing tasks.

### 1. Indexing and Statistics
Before performing random access, pyfastx usually builds an index file (`.fxi`).
*   **Build an index**: `pyfastx index <file.fa/fq>`
*   **Get assembly statistics**: `pyfastx stat <file.fa>`
    *   Provides: Total sequence length, sequence count, average length, N50, L50, and GC content.

### 2. Sequence Extraction and Subsetting
*   **Extract by region**: `pyfastx subseq <file.fa> <region>`
    *   Example: `pyfastx subseq genome.fa chr1:100-500`
*   **Extract by ID list**: `pyfastx extract --list <ids.txt> <file.fa> -o output.fa`
*   **Random sampling**: `pyfastx sample --number 1000 <file.fq> -o sampled.fq`
    *   Use `--proportion 0.1` to sample a percentage of the total reads.

### 3. File Manipulation
*   **Split files**: `pyfastx split --number 10 <large.fa> -o output_dir`
    *   Splits a large file into a specific number of smaller files.
*   **Convert FASTQ to FASTA**: `pyfastx fq2fa <file.fq> -o <file.fa>`

## Python API Best Practices

For programmatic use, pyfastx offers high-level objects that behave like Python dictionaries or lists.

### Efficient Iteration
Use the `Fastx` object for format-agnostic iteration (automatically detects FASTA or FASTQ):
```python
import pyfastx
for name, seq in pyfastx.Fastx('data.fa.gz'):
    # Process sequence
    pass
```

### Random Access (FASTA)
The `Fasta` object creates an index for instant retrieval by name or index:
```python
fa = pyfastx.Fasta('genome.fa.gz')
# Get sequence by name
s = fa['chr1']
# Get subsequence (1-based, inclusive)
sub = s[10:50].seq
# Get reverse complement
rc = s[10:50].reverse_complement
```

### FASTQ Handling
The `Fastq` object allows access to reads and their quality scores:
```python
fq = pyfastx.Fastq('reads.fq.gz')
read = fq[0]
print(read.name, read.seq, read.qual)
```

## Expert Tips
*   **Persistent Indexes**: Indexing large files can take time. pyfastx saves `.fxi` files in the same directory as the source. Reuse these files across different sessions to skip the indexing step.
*   **Gzip Performance**: pyfastx uses `indexed_gzip` logic. It is significantly faster than standard Python `gzip` for random access because it doesn't need to decompress the file from the beginning to reach a specific offset.
*   **Memory Management**: Because it uses a disk-based SQLite index, you can process files much larger than your available RAM.
*   **Non-standard FASTA**: pyfastx is robust against "messy" FASTA files where sequence lines have varying lengths.



## Subcommands

| Command | Description |
|---------|-------------|
| pyfastx fq2fa | Converts FASTQ to FASTA format. |
| pyfastx split | Split a fasta or fastq file into multiple smaller files. |
| pyfastx_extract | Extract sequences from FASTA/FASTQ files. |
| pyfastx_index | Build index for fasta or fastq files |
| pyfastx_sample | Sample sequences from a FASTA or FASTQ file. |
| pyfastx_stat | Show statistics for fasta or fastq files. |
| pyfastx_subseq | Extract subsequences from FASTA/FASTQ files. |

## Reference documentation
- [github_com_lmdu_pyfastx_blob_master_README.rst.md](./references/github_com_lmdu_pyfastx_blob_master_README.rst.md)
- [pyfastx_readthedocs_io_en_latest_commandline.html.md](./references/pyfastx_readthedocs_io_en_latest_commandline.html.md)
- [pyfastx_readthedocs_io_en_latest_usage.html.md](./references/pyfastx_readthedocs_io_en_latest_usage.html.md)