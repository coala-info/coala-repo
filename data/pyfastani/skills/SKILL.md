---
name: pyfastani
description: pyfastani provides a Python interface and Cython bindings for FastANI to perform fast whole-genome similarity estimation in memory. Use when user asks to compute average nucleotide identity, sketch reference genomes, or perform fast genomic similarity searches without using command-line wrappers.
homepage: https://github.com/althonos/pyfastani
---


# pyfastani

## Overview

`pyfastani` provides Cython bindings and a native Python interface for FastANI, a popular method for fast whole-genome similarity estimation. It allows users to compute ANI without the overhead of CLI wrappers or temporary file I/O by interacting directly with FastANI internals in memory. This implementation is particularly useful for scaling genomic analyses, as it introduces multithreading at the fragment mapping stage, providing performance gains even when querying a single genome against a small reference set.

## Installation

Install `pyfastani` via PyPI or Bioconda:

```bash
# Using pip
pip install pyfastani

# Using conda
conda install -c bioconda pyfastani
```

## Core Workflow

The library uses a two-step process: sketching/indexing references and then querying.

1.  **Initialize a Sketch**: Create a `pyfastani.Sketch` object to hold reference genomes.
2.  **Add References**: Use `add_draft(name, sequences)` to add genomes. The `sequences` argument should be an iterable of byte-like objects (contigs).
3.  **Index**: Call `sketch.index()` to produce a `Mapper` object.
4.  **Query**: Use the `Mapper` to query a genome and retrieve hits containing identity scores and fragment counts.

## Usage Patterns

### Working with Biopython
Biopython sequences must be converted to `bytes` before being passed to `pyfastani`.

```python
import pyfastani
from Bio import SeqIO

# 1. Prepare Sketch
sketch = pyfastani.Sketch()
ref_records = list(SeqIO.parse("reference.fna", "fasta"))
sketch.add_draft("Ref1", (bytes(r.seq) for r in ref_records))

# 2. Create Mapper
mapper = sketch.index()

# 3. Query
query_record = SeqIO.read("query.fna", "fasta")
hits = mapper.query_genome(bytes(query_record.seq))

for hit in hits:
    print(f"Identity: {hit.identity}, Matches: {hit.matches}/{hit.fragments}")
```

### Working with Scikit-bio
Scikit-bio sequences should be viewed as raw bytes (`'B'`) for compatibility with the underlying C++ code.

```python
import pyfastani
import skbio.io

sketch = pyfastani.Sketch()
ref_seqs = list(skbio.io.read("reference.fna", "fasta"))
sketch.add_draft("Ref1", (s.values.view('B') for s in ref_seqs))

mapper = sketch.index()
query_seq = next(skbio.io.read("query.fna", "fasta"))
hits = mapper.query_genome(query_seq.values.view('B'))
```

## Expert Tips and Best Practices

*   **In-Memory Efficiency**: Avoid writing intermediate FASTA files. If your sequences are already in memory (e.g., from a de novo assembler or a database), pass them directly to `add_draft` or `query_genome`.
*   **Reference Indexing**: The `index()` step is computationally expensive. If you are comparing many queries against the same set of references, create the `Mapper` once and reuse it for all queries.
*   **Multithreading**: `pyfastani` parallelizes the fragment mapping step. This is a significant improvement over the original FastANI tool, which primarily parallelized across different reference genomes.
*   **Draft Genomes**: Use `add_draft` for any reference that consists of multiple contigs. Use `query_genome` for a single-contig query or `query_draft` if the query itself is composed of multiple contigs.
*   **Memory Mapping**: For very large reference sets, ensure your environment has sufficient RAM, as `pyfastani` stores the k-mer sketches in memory to avoid disk I/O bottlenecks.

## Reference documentation
- [pyfastani GitHub Repository](./references/github_com_althonos_pyfastani.md)
- [Bioconda pyfastani Overview](./references/anaconda_org_channels_bioconda_packages_pyfastani_overview.md)