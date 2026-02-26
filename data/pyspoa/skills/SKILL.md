---
name: pyspoa
description: pyspoa provides Python bindings for the spoa library to generate consensus sequences and multiple sequence alignments using directed acyclic graphs. Use when user asks to generate a consensus sequence, perform multiple sequence alignment, or use partial order alignment for genomic sequences.
homepage: https://github.com/nanoporetech/pyspoa
---


# pyspoa

## Overview

pyspoa provides high-performance Python bindings for the `spoa` (Simplicial Partial Order Alignment) C++ library. It allows for the rapid generation of a consensus sequence and a multiple sequence alignment from a set of related sequences. By representing the alignment as a directed acyclic graph (DAG) rather than a linear matrix, it handles complex insertions and deletions more effectively, making it a standard tool in genomic assembly and error correction workflows.

## Installation

Install the package via pip or conda:

```bash
pip install pyspoa
# OR
conda install -c bioconda pyspoa
```

## Basic Usage

The primary interface is the `poa` function, which accepts a list of sequences and returns both the consensus string and the aligned sequences.

```python
from spoa import poa

# Define a list of related sequences
sequences = [
    'AACTTATA',
    'AACTTATG',
    'AACTATA'
]

# Perform Partial Order Alignment
consensus, msa = poa(sequences)

print(f"Consensus: {consensus}")
# Output: AACTTATA

print("Multiple Sequence Alignment:")
for row in msa:
    print(row)
# Output:
# AACTTATA-
# AACTTAT-G
# AAC-TATA-
```

## Advanced Configuration

### Minimum Coverage
Starting with version 0.2.0, the library supports a `min_coverage` parameter. This is useful for filtering out low-confidence bases in the consensus sequence that are only supported by a small number of reads.

```python
# Only include bases in the consensus supported by at least 2 sequences
consensus, msa = poa(sequences, min_coverage=2)
```

## Best Practices

- **Input Format**: Ensure all input sequences are strings. While the algorithm is robust, pre-trimming extremely low-quality ends of reads can improve the clarity of the resulting consensus.
- **Memory Efficiency**: POA is generally memory-efficient, but when aligning thousands of very long sequences (e.g., >50kb), monitor memory usage as the underlying graph grows.
- **Gap Handling**: The `msa` output uses the hyphen (`-`) character to represent gaps. If you are piping this output to other tools, ensure they are compatible with standard FASTA/CLUSTAL gap representations.
- **Research Release**: Note that `pyspoa` is maintained as a research release by Oxford Nanopore Technologies; for production-critical pipelines, always validate the consensus against a known reference if available.

## Reference documentation
- [pyspoa GitHub Repository](./references/github_com_nanoporetech_pyspoa.md)
- [Bioconda pyspoa Overview](./references/anaconda_org_channels_bioconda_packages_pyspoa_overview.md)