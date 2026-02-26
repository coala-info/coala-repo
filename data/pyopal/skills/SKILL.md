---
name: pyopal
description: PyOpal provides SIMD-accelerated Python bindings for the Opal library to perform fast sequence alignments using multi-sequence vectorization. Use when user asks to align sequences, search a query against a database, or perform high-throughput protein and nucleotide sequence comparisons.
homepage: https://github.com/althonos/pyopal
---


# pyopal

## Overview
PyOpal provides Python bindings for the Opal library, a SIMD-accelerated aligner. It is designed for bioinformatics workflows where speed is critical, such as searching a query sequence against a large database of proteins or nucleotides. Unlike standard libraries, PyOpal uses multi-sequence vectorization (SWIPE-like) to process multiple alignments in parallel on the CPU, supporting SSE2, SSE4.1, and NEON extensions.

## Installation
Install via `pip` or `conda` (bioconda channel):
```bash
pip install pyopal
# OR
conda install -c bioconda pyopal
```

## Core Workflow Patterns

### 1. Basic Database Search
For one-off searches, use the high-level `pyopal.align` function. It accepts strings or bytes.
```python
import pyopal

query = "MAGFLKVVQLLAKYGSKAVQWAWANKGKILDWLNAGQAIDWVVSKIKQILGIK"
database = [
    "MESILDLQELETSEEESALMAASTVSNNC",
    "MAGFLKVVQILAKYGSKAVQWAWANKGKILDWINAGQAIDWVVEKIKQILGIK"
]

# Returns an iterator of ScoreResult objects
for result in pyopal.align(query, database):
    print(f"Score: {result.score}, Index: {result.target_index}")
```

### 2. Optimized Database Reuse
If searching multiple queries against the same database, pre-encode the database into a `pyopal.Database` object to save overhead.
```python
# Initialize database once
db = pyopal.Database(database)

# Align query against the pre-encoded database
results = pyopal.align(query, db)
```

### 3. Parallel Processing (Thread-Safety)
PyOpal is thread-safe and releases the GIL during alignment. Use a `ThreadPool` for concurrent queries.
```python
import multiprocessing.pool
from pyopal import Aligner, Database

db = Database(large_sequence_list)
aligner = Aligner()
queries = ["SEQ1", "SEQ2", "SEQ3"]

with multiprocessing.pool.ThreadPool() as pool:
    # aligner.align is re-entrant
    all_hits = pool.map(lambda q: aligner.align(q, db), queries)
```

## Expert Tips
- **Alphabet Selection**: PyOpal automatically detects the alphabet (DNA/Protein), but you can specify it in the `Database` constructor if needed.
- **Algorithm Choice**: The `Aligner` supports different modes. Ensure you select the correct one (local vs. global) based on your biological question.
- **Memory Management**: `Database` objects use a C++17 read/write lock. While they are thread-safe for searching, avoid modifying the database while a search is active in another thread.
- **SIMD Dispatch**: PyOpal handles CPU feature detection at runtime. You do not need to compile specific versions for SSE or NEON; the library selects the best implementation for the host machine automatically.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_althonos_pyopal.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pyopal_overview.md)