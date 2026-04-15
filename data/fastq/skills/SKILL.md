---
name: fastq
description: The fastq library provides a lightweight Python toolbox for reading, writing, and analyzing FASTQ files and their associated quality scores. Use when user asks to read or write FASTQ files, calculate sequence statistics like GC content and mean quality, or convert FASTQ entries to FASTA format.
homepage: https://github.com/not-a-feature/fastq
metadata:
  docker_image: "quay.io/biocontainers/fastq:2.0.4--pyhdfd78af_0"
---

# fastq

## Overview
The `fastq` library is a lightweight, zero-dependency Python toolbox designed for handling FASTQ files in small to medium-sized bioinformatics projects. It provides a streamlined alternative to heavier packages, focusing on core functionality: reading, writing, and analyzing nucleotide sequences and their associated quality scores. The skill is particularly useful for rapid script development where minimal environment overhead is required.

## Core Functional Usage

### Reading Sequences
The `read()` function is an iterator that handles both plain text and compressed files automatically.

```python
import fastq as fq

# Read from a standard FASTQ file
for entry in fq.read("data.fastq"):
    print(entry.head)  # Header line
    print(entry.body)  # Sequence string

# Read from compressed archives (supports .gz, .zip, .tar, .tar.gz)
# If an archive contains multiple files, all are read sequentially
entries = list(fq.read("samples.tar.gz"))
```

### Working with the fastq_object
Each entry returned by the reader is a `fastq_object`.

- **Attributes**: Access data via `head` (header), `body` (sequence), and `qstr` (quality string).
- **Sequence Length**: Use `len(obj)` to get the nucleotide count.
- **String Representation**: `str(obj)` returns the valid 4-line FASTQ format string.
- **Equality**: `obj1 == obj2` compares the sequence `body` only (ignoring headers and quality).

### Sequence Statistics and Info
The `.info` property (or `getInfo()` method) computes summary statistics lazily.

```python
stats = entry.info
# Returns a dictionary containing:
# 'a_num', 'g_num', 't_num', 'c_num': Absolute base counts
# 'gc_content', 'at_content': Relative content (0.0 to 1.0)
# 'qual': Mean quality score (Illumina encoding)
# 'qual_median', 'qual_variance', 'qual_min', 'qual_max': Quality distribution
```

### Writing and Appending
The `write()` function handles single objects or lists of objects.

```python
# Overwrite/Create new file
fq.write(entries, "output.fastq")

# Append to existing file
fq.write(new_entries, "output.fastq", mode="a")
```

### Format Conversion
Use the `toFasta()` method on a `fastq_object` to generate FASTA-formatted strings.

```python
with open("output.fasta", "w") as f:
    for entry in fq.read("input.fastq"):
        f.write(entry.toFasta())
```

## Expert Tips
- **Memory Efficiency**: Always treat `fq.read()` as an iterator when processing large files to avoid loading the entire dataset into RAM. Only cast to a `list()` if random access is strictly necessary.
- **Lazy Evaluation**: Accessing `.info` triggers calculations. If you only need the sequence, avoid accessing `.info` to improve performance.
- **Archive Handling**: When reading from a `.zip` or `.tar`, the library extracts and reads every file inside. Ensure your archives only contain relevant FASTQ data to avoid errors.

## Reference documentation
- [github_com_not-a-feature_fastq.md](./references/github_com_not-a-feature_fastq.md)
- [anaconda_org_channels_bioconda_packages_fastq_overview.md](./references/anaconda_org_channels_bioconda_packages_fastq_overview.md)