---
name: pyfastx
description: pyfastx is a lightweight Python C extension designed for efficient parsing and random access of plain or gzipped FASTA and FASTQ files.
homepage: https://github.com/lmdu/pyfastx
---

# pyfastx

## Overview
pyfastx is a lightweight Python C extension designed for efficient parsing and random access of plain or gzipped FASTA and FASTQ files. By building a small SQLite index, it allows for near-instantaneous retrieval of sequences and subsequences without loading entire files into memory. It is particularly useful for bioinformatics workflows involving large-scale genomic datasets where memory efficiency and speed are critical.

## Command Line Interface (CLI) Patterns

The `pyfastx` command provides several subcommands for common sequence manipulation tasks.

### 1. Sequence Statistics
Generate comprehensive statistics for a FASTA or FASTQ file, including N50, L50, GC content, and nucleotide composition.
```bash
pyfastx stat input.fa.gz
```

### 2. Extracting Subsequences
Extract a specific region from a sequence using the format `name:start-end`.
```bash
pyfastx subseq input.fa.gz chr1:100-500
```

### 3. Splitting Files
Split a large FASTA/Q file into multiple smaller files by sequence count.
```bash
# Split into 10 files
pyfastx split -n 10 input.fq.gz
```

### 4. Format Conversion
Convert FASTQ files to FASTA format efficiently.
```bash
pyfastx fq2fa input.fq.gz output.fa
```

### 5. Random Sampling
Randomly sample a specific number of sequences or reads from a file.
```bash
# Sample 1000 reads
pyfastx sample -n 1000 input.fq.gz -o sampled.fq
```

## Python API Best Practices

### Efficient Iteration
Use `pyfastx.Fastx` for simple, fast iteration when random access is not required. It automatically detects whether the input is FASTA or FASTQ.
```python
import pyfastx

# Auto-detects format and handles gzip automatically
for name, seq in pyfastx.Fastx('data.fa.gz'):
    print(name, seq)

# For FASTQ, it returns (name, seq, qual)
for name, seq, qual in pyfastx.Fastx('data.fq.gz'):
    pass
```

### Random Access with Indexing
Use `pyfastx.Fasta` or `pyfastx.Fastq` to enable random access. The first time this is run, it will create a `.fxi` (index) file.
```python
fa = pyfastx.Fasta('genome.fa.gz')

# Fetch sequence by name
seq = fa['chr1']

# Fetch subsequence (1-based indexing, slice-like)
# Returns the sequence from 100 to 200
sub = fa['chr1'][99:200]

# Get sequence attributes
print(seq.name, seq.gc_content, len(seq))
```

### Memory Management
- **Index Reuse**: Once the `.fxi` file is created, subsequent loads are nearly instantaneous.
- **Iteration without Indexing**: If you only need to read a file once and want to avoid the overhead of building an index, set `build_index=False` in the `Fasta` constructor.

## Expert Tips
- **Uppercase Normalization**: When iterating, use `uppercase=True` in the constructor to ensure all sequences are returned in uppercase, avoiding issues with soft-masked genomes.
- **Comment Parsing**: If your FASTA/Q headers contain extra metadata (e.g., from Trinity or NCBI), use `comment=True` to capture the text following the sequence ID.
- **Gzip Performance**: pyfastx uses `zran` for random access in gzipped files. While fast, building the initial index for a very large gzipped file (e.g., >10GB) may take a few minutes.

## Reference documentation
- [pyfastx GitHub Repository](./references/github_com_lmdu_pyfastx.md)
- [pyfastx Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyfastx_overview.md)