---
name: pyfasta
description: pyfasta provides fast, memory-efficient access to FASTA files through indexing and memory-mapping. Use when user asks to extract sub-sequences, split FASTA files into chunks, calculate GC content, or access genomic data via a Pythonic API.
homepage: https://github.com/brentp/pyfasta
metadata:
  docker_image: "quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2"
---

# pyfasta

## Overview

pyfasta is a tool designed for fast, memory-efficient, and "pythonic" access to FASTA files. It works by creating a flattened version of the sequence (removing newlines and headers) and an index file (.gdx), allowing for random access via memory-mapping (mmap) or direct file seeking (fseek). This ensures that sequence data is never fully read into RAM, making it suitable for large-scale genomic data.

Use this skill when you need to:
- Access specific sub-sequences from large FASTA files using Python.
- Split FASTA files into smaller chunks or by individual headers.
- Extract specific sequences from a multi-FASTA file via the command line.
- Calculate basic statistics like GC content for genomic sequences.

## CLI Usage Patterns

### File Information
Get basic statistics, including sequence lengths and GC content:
```bash
pyfasta info --gc input.fasta
```

### Splitting FASTA Files
Split a file into a specific number of relatively even-sized files:
```bash
pyfasta split -n 6 original.fasta
```

Split into one file per header, using the sequence ID in the filename:
```bash
pyfasta split --header "%(seqid)s.fasta" original.fasta
```

Split into 10K-mers with a 2K overlap:
```bash
pyfasta split -n 1 -k 10000 -o 2000 original.fasta
```

### Extracting Sequences
Extract specific sequences by ID into a new FASTA file:
```bash
pyfasta extract --header --fasta input.fasta seq_id_1 seq_id_2
```

Extract sequences using a text file containing IDs to exclude:
```bash
pyfasta extract --header --fasta input.fasta --exclude --file ids_to_ignore.txt
```

### Optimization
Flatten a file "inplace" to speed up future access without creating a second large sequence file:
```bash
pyfasta flatten input.fasta
```

## Python API Best Practices

### Basic Access
```python
from pyfasta import Fasta
f = Fasta('data.fasta')

# Access by header (returns a record object)
chr1 = f['chr1']

# Pythonic slicing (0-based)
seq = chr1[10:20]

# Get full sequence
full_seq = str(chr1)
```

### Coordinate-Based Queries
Use the `sequence` method for flexible queries, including strand-aware reverse complements:
```python
# One-based coordinates (standard in biology)
f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9}, one_based=True)

# Negative strand (returns reverse complement)
f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9, 'strand': '-'})
```

### Handling Complex Headers
If FASTA headers are long (e.g., ">ID123 | description | coords"), use `key_fn` to simplify keys:
```python
f = Fasta('data.fasta', key_fn=lambda key: key.split()[0])
# Now accessible via f['ID123']
```

### Memory and Storage Management
- **In-place flattening**: For massive files (e.g., >5GB), use `Fasta('data.fasta', flatten_inplace=True)` to avoid doubling disk usage.
- **Index Files**: pyfasta creates `.gdx` (index) and `.flat` (flattened sequence) files. If the source FASTA changes, delete these files to force a re-index.
- **Numpy Integration**: By default, pyfasta uses a memmapped numpy array. You can cast records directly to numpy arrays for vectorized operations:
  ```python
  import numpy as np
  arr = np.array(f['chr1'])
  ```

## Expert Tips
- **Modern Alternative**: The author of pyfasta suggests using `pyfaidx` for newer projects unless specific pyfasta features are required.
- **Duplicate Headers**: pyfasta will check for and warn about duplicate headers during indexing.
- **Performance**: For high-frequency random access to thousands of small records, consider using the `TCRecord` backend (requires TokyoCabinet) to avoid memory overhead from the standard pickle index.



## Subcommands

| Command | Description |
|---------|-------------|
| pyfasta_extract | Extract some sequences from a fasta file. |
| pyfasta_info | Print headers and lengths of the given fasta file in order of length. |
| pyfasta_split | split a fasta file into separated files. |

## Reference documentation
- [pyfasta GitHub README](./references/github_com_brentp_pyfasta.md)
- [pyfasta PyPI Overview](./references/pypi_org_project_pyfasta.md)