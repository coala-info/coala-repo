---
name: cogent3
description: cogent3 is a high-performance Python library designed for the analysis of genomic sequence data.
homepage: https://pypi.org/project/cogent3/
---

# cogent3

## Overview
cogent3 is a high-performance Python library designed for the analysis of genomic sequence data. It is particularly powerful for users needing to model sequence evolution using non-stationary or non-reversible Markov models, including specialized codon models. The library is structured to support both interactive exploration in Jupyter notebooks and massive parallelization on compute clusters. A key feature is the `cogent3.app` module, which provides a functional programming interface to compose complex bioinformatics pipelines from discrete, reusable components.

## Core Usage Patterns

### Working with Sample Data
cogent3 includes built-in datasets for testing and demonstration.
```python
import cogent3

# List available datasets
print(cogent3.available_datasets())

# Load a specific dataset
data = cogent3.get_dataset("BRCA1.fasta")
```

### The cogent3.app Framework
The "app" interface is the preferred way to build reproducible workflows. Apps are composed by piping them together.

```python
from cogent3.app import get_app

# Define a pipeline: Load -> Align -> Model -> Write
loader = get_app("load_unaligned", format="fasta")
aligner = get_app("progressive_align", model="HKY85")
writer = get_app("write_seqs", format="fasta", path="aligned.fasta")

# Execute the pipeline
seqs = loader("input.fasta")
aln = aligner(seqs)
writer(aln)
```

### Evolutionary Modeling
cogent3 is unique in its support for complex substitution models.
- **Time-reversible models**: Standard models like HKY85, GTR.
- **Non-stationary models**: Models where nucleotide frequencies can change across the tree.
- **Codon models**: For analyzing selective pressures (dN/dS).

### Sequence Manipulation and Annotations
Sequences can be manipulated based on their genomic annotations (e.g., exons, introns).
```python
# Accessing features on a sequence
for feature in seq.get_features(type="exon"):
    exon_seq = feature.get_slice()
```

### High-Performance Plugins
Use specialized plugins for performance-critical tasks:
- **K-mer counting**: Use `cogent3-pykmertools` for Rust-based speed.
  ```python
  # Requires pip install cogent3-pykmertools
  counts = seqs.count_kmers(k=3, use_hook="cogent3_pykmertools")
  ```
- **Phylogeny**: Use `piqtree` for rapid Neighbor-Joining.
  ```python
  # Requires piqtree installed
  tree = aln.quick_tree(use_hook="piqtree")
  ```
- **Storage**: Use `cogent3-h5seqs` for HDF5-backed storage of massive alignments.

## Best Practices
- **Installation**: Use `pip install "cogent3[extra]"` for local workstations to include visualization and Jupyter support. Use `pip install cogent3` for headless HPC environments.
- **Functional Composition**: Prefer `cogent3.app` components over manual loops for data processing to ensure compatibility with parallel execution providers.
- **Large Datasets**: For very large sequence collections, utilize the HDF5 plugin to avoid memory exhaustion.
- **Model Selection**: When analyzing long-term evolution, consider non-stationary models if base composition varies significantly between taxa.

## Reference documentation
- [cogent3 · PyPI](./references/pypi_org_project_cogent3.md)
- [cogent3 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cogent3_overview.md)