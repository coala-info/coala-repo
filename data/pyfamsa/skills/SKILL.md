---
name: pyfamsa
description: PyFAMSA provides a high-performance Python interface for large-scale protein multiple sequence alignment using the FAMSA algorithm. Use when user asks to perform fast protein sequence alignments, align large protein families in memory, or generate guide trees for sequence sets.
homepage: https://github.com/althonos/pyfamsa
metadata:
  docker_image: "quay.io/biocontainers/pyfamsa:0.5.3.post1--py312h9c9b0c2_0"
---

# pyfamsa

## Overview

PyFAMSA is a high-performance Python interface to the FAMSA algorithm, designed for large-scale protein sequence alignments. It provides Cython bindings that allow for in-memory alignment without the need for external binaries or temporary files. This skill should be used when you need to perform fast, accurate alignments of huge protein families while maintaining a Pythonic workflow, especially in multi-threaded environments.

## Core Usage Pattern

To perform an alignment, you must wrap your raw sequences in `Sequence` objects and then use an `Aligner` instance.

```python
from pyfamsa import Aligner, Sequence

# 1. Prepare sequences (ID and Sequence as bytes)
sequences = [
    Sequence(b"seq1", b"GLGKVIVYGIVLGTKSDQFSNWVVWLFPWNGLQIHMMGII"),
    Sequence(b"seq2", b"DPAVLFVIMLGTITKFSSEWFFAWLGLEINMMVII"),
]

# 2. Initialize the aligner with desired parameters
aligner = Aligner(guide_tree="upgma")

# 3. Execute alignment
msa = aligner.align(sequences)

# 4. Access results
for seq in msa:
    print(f"{seq.id.decode()}: {seq.sequence.decode()}")
```

## Configuration and Optimization

### Guide Tree Methods
The `Aligner` supports different heuristics for building the guide tree, which impacts the speed/accuracy trade-off:
- `guide_tree="sl"`: Single Linkage (fastest).
- `guide_tree="upgma"`: Unweighted Pair Group Method with Arithmetic Mean (balanced).
- `guide_tree="nj"`: Neighbor Joining.

### Heuristics
For extremely large datasets, enable heuristics to reduce memory and time:
- `medoid`: Uses medoid-based tree construction.
- `fast`: Enables FAMSA's fast heuristic mode.

### Custom Scoring Matrices
By default, PyFAMSA uses `PFASUM43`. You can provide custom matrices from the `scoring-matrices` library to fine-tune alignment for specific protein families.

## Parallel Processing

`Aligner` objects are thread-safe and the `align` method is re-entrant. For batch processing multiple families, use a `multiprocessing.pool.ThreadPool` to leverage multiple CPU cores without duplicating the aligner object.

```python
import multiprocessing.pool
from pyfamsa import Aligner

aligner = Aligner()
# families is a list of lists of Sequence objects
with multiprocessing.pool.ThreadPool() as pool:
    alignments = pool.map(aligner.align, families)
```

## Expert Tips

- **Memory Management**: Since PyFAMSA operates entirely in memory, ensure your environment has sufficient RAM for the distance matrix when aligning tens of thousands of sequences. Use the `sl` (Single Linkage) guide tree to minimize memory footprint for ultra-scale tasks.
- **Input Types**: Always provide sequence IDs and residues as `bytes`. While the library may handle `str` in some versions, using `bytes` avoids unnecessary encoding overhead.
- **Integration**: If you need to process the resulting MSA further, PyFAMSA's output is compatible with other tools in the `althonos` ecosystem, such as `pytrimal` for alignment trimming or `pyhmmer` for HMM construction.

## Reference documentation
- [PyFAMSA GitHub Repository](./references/github_com_althonos_pyfamsa.md)
- [Bioconda PyFAMSA Overview](./references/anaconda_org_channels_bioconda_packages_pyfamsa_overview.md)