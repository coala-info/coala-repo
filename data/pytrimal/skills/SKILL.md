---
name: pytrimal
description: "pytrimal is a high-performance Python interface for automated alignment trimming in phylogenetics and comparative genomics. Use when user asks to trim alignments using heuristics like gappyout or strict, remove columns based on gap and similarity thresholds, or select representative sequences to reduce redundancy."
homepage: https://github.com/althonos/pytrimal
---


# pytrimal

## Overview
pytrimal is a high-performance Python interface to trimAl, a tool widely used for automated alignment trimming in phylogenetics and comparative genomics. By using Cython bindings, it allows for the manipulation of alignments directly in memory, avoiding the need for temporary files and subprocess calls. It is particularly effective for large datasets due to its SIMD-optimized backend, which accelerates the calculation of sequence similarity and gap statistics.

## Installation
Install pytrimal via pip or conda:
```bash
pip install pytrimal
# OR
conda install -c bioconda pytrimal
```

## Core Usage Patterns

### Automated Trimming
The `AutomaticTrimmer` class provides access to the standard trimAl heuristics.

```python
from pytrimal import Alignment, AutomaticTrimmer

# Load an alignment (supports FASTA, Clustal, etc.)
ali = Alignment.load("input.fasta")

# Initialize trimmer with a specific method
# Methods include: "gappyout", "strict", "strictplus", "automated1", "automated2"
trimmer = AutomaticTrimmer(method="strictplus")

# Execute trimming
trimmed = trimmer.trim(ali)

# Save the result
trimmed.dump("output.fasta", format="fasta")
```

### Manual Trimming
For fine-grained control, use specific thresholds for gaps and conservation.

```python
from pytrimal import ManualTrimmer

# Trim based on gap threshold (e.g., keep columns with < 10% gaps)
# and conservation threshold (e.g., keep columns with > 60% similarity)
trimmer = ManualTrimmer(gap_threshold=0.9, similarity_threshold=0.6)
trimmed = trimmer.trim(ali)
```

### Representative Sequence Selection
Use `RepresentativeTrimmer` to reduce redundancy in an alignment.

```python
from pytrimal import RepresentativeTrimmer

# Keep at most 10 representative sequences
trimmer = RepresentativeTrimmer(clusters=10)
trimmed = trimmer.trim(ali)
```

## Expert Tips and Best Practices

- **SIMD Acceleration**: pytrimal automatically uses SIMD (SSE/AVX/NEON) instructions. This is significantly faster than the original trimAl for alignments with thousands of sequences. Ensure your environment allows for these instructions to maximize performance.
- **Thread Safety**: `Trimmer` objects are thread-safe. You can use a `multiprocessing.pool.ThreadPool` to process multiple alignments in parallel using a single trimmer instance.
- **Memory Efficiency**: Since pytrimal works in-memory, it is more efficient than CLI-based wrappers for small-to-medium alignments. However, for extremely large alignments, monitor RAM usage as the SIMD implementation may consume slightly more memory than the generic C++ version.
- **Format Support**: When using `.dump()`, you can specify formats such as `fasta`, `clustal`, `pir`, or `phylip`.
- **Alphabet Detection**: pytrimal automatically detects if an alignment is Protein or DNA/RNA. You can check this via the `Alignment.sequence_type` property.

## Reference documentation
- [pytrimal GitHub Repository](./references/github_com_althonos_pytrimal.md)
- [Bioconda pytrimal Overview](./references/anaconda_org_channels_bioconda_packages_pytrimal_overview.md)