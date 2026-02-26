---
name: cyushuffle
description: cyushuffle is a high-performance Cython wrapper that randomizes biological sequences while preserving their exact k-let composition. Use when user asks to shuffle sequences, generate null sequences for statistical significance testing, or preserve dinucleotide and trinucleotide frequencies in randomized controls.
homepage: https://github.com/guma44/ushuffle
---


# cyushuffle

# cyushuffle

## Overview
`cyushuffle` is a high-performance Cython wrapper for the uShuffle algorithm. It provides a computationally efficient way to randomize biological sequences while maintaining their exact k-let (k-mer) composition. This tool is a standard requirement in bioinformatics for generating "null" sequences used to calculate the statistical significance of motifs, structural elements, or sequence alignments.

## Installation
The package is available via Bioconda or PyPI:

```bash
# Via Conda
conda install bioconda::cyushuffle

# Via Pip
pip install ushuffle
```

## Usage Best Practices

### 1. Handling Sequence Types
In Python 3, `cyushuffle` requires sequences to be passed as `bytes` objects rather than standard strings.

```python
from ushuffle import shuffle

seq = b"ATGCATGCATGC"
k = 2
result = shuffle(seq, k)
```

### 2. Efficient Repeated Shuffling
If you need to generate multiple shuffled versions of the same sequence, do not call `shuffle()` repeatedly. Instead, use the `Shuffler` object. This pre-computes the sequence graph, significantly increasing performance for large-scale simulations.

```python
from ushuffle import Shuffler

seq = b"GCTAGCTAGCTAGCTA"
k = 2
# Initialize the shuffler once
shuffler = Shuffler(seq, k)

# Generate 1000 permutations efficiently
results = [shuffler.shuffle() for _ in range(1000)]
```

### 3. Ensuring Reproducibility
Use `set_seed` to ensure that your randomized controls are reproducible across different runs. Note that `set_seed` sets the seed globally for the library.

```python
from ushuffle import set_seed

set_seed(42)
```

### 4. Choosing the Right 'k'
*   **k=1**: Simple shuffling (preserves only individual character counts/GC content).
*   **k=2**: Preserves dinucleotide counts (common for DNA/RNA to maintain CpG density or stacking energies).
*   **k=3**: Preserves codon usage/trinucleotide frequencies.
*   **Constraint**: The value of `k` must be less than or equal to the length of the sequence.

## Expert Tips
*   **Memory Management**: The `Shuffler` object is particularly useful when working with very long sequences (e.g., whole chromosomes or large scaffolds) because it avoids the overhead of re-parsing the sequence for every permutation.
*   **Input Validation**: Always ensure your input sequence does not contain unexpected characters (like 'N' in genomic data) unless you intend for them to be treated as distinct characters in the k-let graph.
*   **Performance**: Because this is a Cython wrapper around C code, it is significantly faster than pure Python implementations of the uShuffle algorithm, making it suitable for integration into large-scale pipelines.

## Reference documentation
- [Bioconda cyushuffle Overview](./references/anaconda_org_channels_bioconda_packages_cyushuffle_overview.md)
- [uShuffle GitHub Repository](./references/github_com_guma44_ushuffle.md)