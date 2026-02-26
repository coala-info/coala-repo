---
name: pyfasta
description: pyfasta provides fast, memory-efficient random access and manipulation of FASTA sequence files using indexing and memory-mapping. Use when user asks to extract sub-sequences, split FASTA files, flatten sequences, or retrieve sequence statistics and information.
homepage: https://github.com/brentp/pyfasta
---


# pyfasta

## Overview

`pyfasta` is a specialized tool designed for "pythonic" and high-performance access to FASTA sequence files. It avoids high memory overhead by using memory-mapping (mmap) or direct file seeking (fseek/fread) to access sequence data on disk. When first used on a file, it creates a flattened version of the sequence (removing newlines and headers) and a pickle-based index (`.gdx`) to allow for near-instantaneous random access. It is an excellent choice for bioinformatics workflows requiring rapid retrieval of sub-sequences from large genomes.

## Command Line Interface (CLI) Patterns

The `pyfasta` executable provides several sub-commands for file manipulation and inspection.

### File Information and Statistics
Use the `info` command to get a summary of the FASTA file, including sequence counts and lengths.
```bash
# Show basic info and GC content for all sequences
pyfasta info --gc sequence.fasta
```

### Splitting FASTA Files
`pyfasta` offers flexible splitting options based on file count, headers, or k-mer sizes.
```bash
# Split into 6 files of roughly equal size
pyfasta split -n 6 input.fasta

# Split into one file per header, using the sequence ID as the filename
pyfasta split --header "%(seqid)s.fasta" input.fasta

# Create 10K-mers with a 2K overlap
pyfasta split -n 1 -k 10000 -o 2000 input.fasta
```

### Extracting Sequences
Extract specific sequences by their header IDs.
```bash
# Extract specific sequences into a new FASTA file
pyfasta extract --header --fasta input.fasta seq_id_1 seq_id_2

# Extract all sequences EXCEPT those listed in a file
pyfasta extract --header --fasta input.fasta --exclude --file ids_to_ignore.txt

# Handle complex headers by splitting on space (lookup by first word only)
pyfasta extract --header --fasta input.fasta --space --file ids.txt
```

### Performance Optimization
To save disk space and speed up later access, you can flatten a file "in-place". This removes newlines within the original file while keeping it a valid FASTA.
```bash
pyfasta flatten input.fasta
```

## Python API Usage

The Python interface allows for dictionary-like access and slicing.

### Basic Access
```python
from pyfasta import Fasta
f = Fasta('data.fasta')

# List all sequence IDs (keys)
ids = sorted(f.keys())

# Get sequence as a string (standard Python 0-based slicing)
seq = f['chr1'][10:20]
```

### Biological Coordinate Queries
Use the `sequence` method for 1-based coordinates or strand-specific retrieval.
```python
# 1-based coordinates (biological standard)
f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9})

# 0-based coordinates (Python standard)
f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9}, one_based=False)

# Reverse complement (automatic for negative strand)
f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9, 'strand': '-'})
```

### Handling Complex Headers
If your FASTA headers contain extra metadata (e.g., `>ID123 | description | metadata`), use a `key_fn` to define how IDs are indexed.
```python
# Key off only the first word of the header
f = Fasta('data.fasta', key_fn=lambda key: key.split()[0])
```

## Expert Tips

*   **Backend Selection**: By default, `pyfasta` uses `NpyFastaRecord` (numpy memmap). If you have an extremely high number of records (headers) that make the pickle index too large for memory, use `record_class=TCRecord` to store the index in a TokyoCabinet database.
*   **Numpy Integration**: You can treat a record as a numpy array for masking or mathematical operations:
    ```python
    import numpy as np
    f = Fasta('data.fasta')
    f['chr1'].as_string = False
    arr = np.array(f['chr1'])
    ```
*   **Index Files**: `pyfasta` creates `.flat` and `.gdx` files. If the underlying FASTA file changes, you must delete these index files to force `pyfasta` to re-index.
*   **Alternative**: The author of `pyfasta` suggests using `pyfaidx` for newer projects unless there is a specific reason to use `pyfasta`'s numpy-backed features.

## Reference documentation
- [pyfasta README](./references/github_com_brentp_pyfasta.md)