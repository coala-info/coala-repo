---
name: pyskani
description: pyskani is a Python interface to skani, a high-performance method for genomic identity calculation using sparse chaining.
homepage: https://github.com/althonos/pyskani/
---

# pyskani

## Overview

pyskani is a Python interface to skani, a high-performance method for genomic identity calculation using sparse chaining. It is designed to be faster and more memory-efficient than FastANI while maintaining high accuracy. By providing direct PyO3 bindings, pyskani allows bioinformaticians to perform ANI calculations entirely in memory, making it suitable for integration into larger Python-based analysis pipelines and web services where disk I/O should be minimized.

## Installation

Install pyskani via pip or conda:

```python
# Using pip
pip install pyskani

# Using conda
conda install -c bioconda pyskani
```

## Core Workflows

### 1. Creating and Sketching a Database

A `Database` object stores genomic "sketches" used for comparison. You can create one in memory and add sequences directly.

**Single Genome (Closed):**
```python
import pyskani
from Bio import SeqIO

database = pyskani.Database()
record = SeqIO.read("genome.fasta", "fasta")
# Sketching requires the sequence as bytes
database.sketch("Genome_ID", bytes(record.seq))
```

**Draft Genomes (Multiple Contigs):**
Use the splat operator to pass multiple sequences for a single organism.
```python
records = SeqIO.parse("draft_genome.fasta", "fasta")
sequences = (bytes(record.seq) for record in records)
database.sketch("Draft_ID", *sequences)
```

### 2. Database Persistence

Databases can be saved to disk and reloaded later.

```python
# Save to a directory
database.save("path/to/sketches")

# Load entirely into memory (Fastest querying)
database = pyskani.Database.load("path/to/sketches")

# Open lazily (Memory efficient for large databases)
database = pyskani.Database.open("path/to/sketches")
```

### 3. Querying for ANI

Once a database is populated or loaded, you can query it with new sequences to find the closest matches.

```python
query_record = SeqIO.read("query.fasta", "fasta")
hits = database.query("Query_Name", bytes(query_record.seq))

for hit in hits:
    print(f"Reference: {hit.name}, ANI: {hit.identity:.2f}%, Coverage: {hit.coverage:.2f}%")
```

## Expert Tips and Best Practices

- **In-Memory Advantage**: Unlike the skani CLI, pyskani does not require writing sequences to temporary files. Always prefer passing `bytes` objects directly from your sequence parser (like Biopython or screed) to `database.sketch` or `database.query`.
- **Memory Management**: For very large reference sets (e.g., All-RefSeq), use `pyskani.Database.open()` instead of `.load()`. This maps the database files lazily, preventing your Python process from consuming excessive RAM.
- **Draft Genome Handling**: When working with draft genomes, ensure you pass all contigs in a single `sketch` call. Skani's sparse chaining is specifically optimized to handle fragmented assemblies more robustly than k-mer based methods.
- **Thread Safety**: pyskani leverages Rust's concurrency under the hood. For large-scale batch processing, you can often rely on the internal parallelization of the library rather than implementing complex Python multiprocessing.

## Reference documentation
- [pyskani GitHub Repository](./references/github_com_althonos_pyskani.md)
- [pyskani Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyskani_overview.md)