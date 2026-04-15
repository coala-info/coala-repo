---
name: pyfaidx
description: pyfaidx provides efficient random access and manipulation of genomic sequences in FASTA files using a samtools-compatible index. Use when user asks to extract sequence slices, retrieve specific genomic coordinates, or perform reverse-complementation on FASTA records.
homepage: https://github.com/mdshw5/pyfaidx
metadata:
  docker_image: "quay.io/biocontainers/pyfaidx:0.9.0.3--pyhdfd78af_0"
---

# pyfaidx

## Overview

The `pyfaidx` skill enables efficient interaction with FASTA format genomic data. It utilizes a samtools-compatible index (`.fai`) to provide random access to any part of a sequence. This is particularly useful for bioinformatics tasks where memory efficiency is paramount, as it allows you to treat large FASTA files as persistent, dictionary-like objects. Use this skill to perform sequence slicing, coordinate-based retrieval, and reverse-complementation with minimal overhead.

## Python API Best Practices

### Basic Access and Slicing
Initialize a `Fasta` object to treat the file as a dictionary. Slicing is 0-based and follows standard Python conventions.

```python
from pyfaidx import Fasta

# Load the FASTA file (creates .fai index if missing)
genes = Fasta('data.fasta')

# Access by record ID and slice (0-based)
# Returns a Sequence object
seq_record = genes['NM_001282543.1'][200:230]

# Get raw string
sequence_string = seq_record.seq

# Get metadata
name = seq_record.name
start = seq_record.start # 1-based by default
end = seq_record.end     # 0-based by default
```

### Coordinate Systems
By default, `Sequence` object attributes use 1-based starts and 0-based ends. For consistency with Python slicing, you can toggle this:

```python
# Use 0-based attributes for .start and .end
genes = Fasta('data.fasta', one_based_attributes=False)
```

### Sequence Transformations
`pyfaidx` provides built-in methods for common genomic transformations:

```python
record = genes['chr1'][100:200]

# Complement
comp = record.complement

# Reverse
rev = record.reverse

# Reverse Complement (using unary minus operator)
rev_comp = -record
```

### Advanced Retrieval
For complex extraction, such as joining exons or using custom key formatting:

```python
# Spliced sequences from multiple coordinate pairs
segments = [[1, 10], [50, 70]]
spliced = genes.get_spliced_seq('NM_001282543.1', segments)

# Custom key function (e.g., ignore version numbers in IDs)
genes = Fasta('data.fasta', key_function=lambda x: x.split('.')[0])

# Handling duplicate keys after transformation
genes = Fasta('data.fasta', split_char='|', duplicate_action='longest')
```

## Command Line Interface (faidx)

The `faidx` command-line tool is installed alongside the module for quick terminal-based manipulation.

- **Index a file**: `faidx data.fasta` (creates `data.fasta.fai`)
- **Extract a region**: `faidx data.fasta chr1:100-200`
- **List sequence names**: `faidx -i data.fasta`
- **Reverse complement output**: `faidx -r data.fasta chr1:100-200`

## Expert Tips

1. **Memory Efficiency**: `pyfaidx` does not load the sequence into memory until you slice it. For very large files, always use slicing rather than loading the full record.
2. **Strict Bounds**: Use `Fasta('file.fasta', strict_bounds=True)` to raise an error if requested coordinates are outside the actual sequence length.
3. **BGZF Support**: Recent versions support BGZF compressed FASTA files if a `.gzi` index is present or created.
4. **In-place Modification**: `pyfaidx` can modify FASTA files in-place, but use this with caution as it alters the source file.

## Reference documentation
- [pyfaidx GitHub Repository](./references/github_com_mdshw5_pyfaidx.md)
- [pyfaidx Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyfaidx_overview.md)