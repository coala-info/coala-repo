---
name: pyrodigal
description: Pyrodigal is a Python module providing Cython bindings to Prodigal, the industry-standard ORF finder for prokaryotic sequences.
homepage: https://github.com/althonos/pyrodigal
---

# pyrodigal

## Overview

Pyrodigal is a Python module providing Cython bindings to Prodigal, the industry-standard ORF finder for prokaryotic sequences. It allows for gene prediction directly within Python environments, eliminating the need for external binary calls, temporary FASTA files, or subprocess management. It is particularly useful for high-throughput bioinformatics pipelines where performance and memory efficiency are critical, as it utilizes SIMD instructions to accelerate dynamic programming tasks and offers more compact data structures than the original C implementation.

## Core Usage Patterns

### Python API Integration
The primary way to use Pyrodigal is through the `GeneFinder` class. It supports two main operational modes:

1.  **Single Mode (Isolates)**: Requires a training step on the specific sequence to calculate nucleotide hexamers.
2.  **Metagenomic Mode (Anonymous)**: Uses pre-trained models for various organisms, suitable for fragments or environmental samples.

#### Single Mode Workflow
```python
import pyrodigal

# Initialize the finder
gene_finder = pyrodigal.GeneFinder()

# 1. Train on the sequence (Required for single mode)
# Input should be bytes or a memory-view
gene_finder.train(sequence_bytes)

# 2. Find genes
genes = gene_finder.find_genes(sequence_bytes)
```

#### Metagenomic Mode Workflow
```python
import pyrodigal

# Initialize in meta mode
gene_finder = pyrodigal.GeneFinder(meta=True)

# Find genes directly without training
genes = gene_finder.find_genes(sequence_bytes)
```

### Parallel Processing
`pyrodigal.GeneFinder` instances are thread-safe and the `find_genes` method is re-entrant. For large-scale genomic datasets, use a thread pool to process multiple sequences simultaneously:

```python
import multiprocessing.pool
import pyrodigal

gene_finder = pyrodigal.GeneFinder(meta=True)
with multiprocessing.pool.ThreadPool() as pool:
    results = pool.map(gene_finder.find_genes, list_of_sequences)
```

## Tool-Specific Best Practices

### Memory Management
*   **Input Types**: Pass sequences as `bytes` or `bytearray`. Pyrodigal interacts with raw memory, avoiding the overhead of string conversions.
*   **Compact Objects**: Pyrodigal's `Gene` objects are significantly smaller (~1KiB saved per gene) than the original Prodigal structures. When processing thousands of genomes, this reduces the total memory footprint of the Python process.

### Handling Results
The `genes` object returned by `find_genes` is a collection of `Gene` objects. You can iterate through them to extract specific data:
*   **Translations**: Use `gene.translate()` to get the protein sequence.
*   **Coordinates**: Access `gene.begin`, `gene.end`, and `gene.strand`.
*   **Scores**: Access detailed scoring information via `gene.score`.

### Advanced Configuration
*   **Custom Gene Size**: Unlike the original Prodigal (fixed at 90bp/60bp), Pyrodigal allows customizing the minimum gene size threshold during initialization.
*   **Translation Tables**: Specify the genetic code using the `g` parameter (e.g., `gene_finder.train(seq, translation_table=11)`).
*   **Masking**: Use the `mask=True` parameter in `find_genes` to prevent gene prediction across regions of unknown nucleotides (N's).

## Expert Tips
*   **SIMD Acceleration**: Pyrodigal automatically uses SIMD instructions (SSE, AVX, or NEON) to speed up the scoring of dynamic programming nodes. Ensure your environment allows for these instructions to achieve 30-50% faster runtimes compared to the original Prodigal.
*   **Training Persistence**: You can save training data from one sequence and apply it to others using the `TrainingInfo` objects, mimicking the `prodigal -t` functionality but entirely in-memory.
*   **Metagenomic Models**: If working with non-standard organisms (e.g., giant viruses), you can load external metagenomic models into the `GeneFinder` to improve prediction accuracy.

## Reference documentation
- [pyrodigal - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pyrodigal_overview.md)
- [GitHub - althonos/pyrodigal: Cython bindings and Python interface to Prodigal](./references/github_com_althonos_pyrodigal.md)