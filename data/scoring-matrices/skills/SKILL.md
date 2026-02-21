---
name: scoring-matrices
description: The `scoring-matrices` library provides a "batteries-included" collection of scoring matrices used to evaluate matches and mismatches in biological sequence alignments.
homepage: https://github.com/althonos/scoring-matrices
---

# scoring-matrices

## Overview
The `scoring-matrices` library provides a "batteries-included" collection of scoring matrices used to evaluate matches and mismatches in biological sequence alignments. It is designed for high-performance bioinformatics applications, offering a simple Python interface for general use and raw pointer access for Cython-based performance optimizations. Use this skill to load standard matrices, retrieve substitution scores by residue letters, or integrate matrix data into low-level sequence processing workflows.

## Installation
Install the package via PyPI or Bioconda:
```bash
pip install scoring-matrices
# OR
conda install -c bioconda scoring-matrices
```

## Python Usage Patterns
The primary interface is the `ScoringMatrix` class.

### Loading Built-in Matrices
Load standard matrices by their common names (e.g., "BLOSUM62", "PAM250", "VTML160", "EDNAFULL").
```python
from scoring_matrices import ScoringMatrix

# Load a specific matrix
matrix = ScoringMatrix.from_name("BLOSUM62")
```

### Accessing Scores
You can retrieve scores using either residue characters or their integer indices in the alphabet.
```python
# Access by residue letters
score = matrix['A', 'W']

# Access by index
score = matrix[0, 4]

# Get an entire row for a residue
row = matrix['M']
```

## Cython Integration
For performance-critical applications, `scoring-matrices` allows direct memory access to avoid Python overhead.

### Direct Pointer Access
Use `cimport` to access the underlying C data structures.
```cython
from scoring_matrices cimport ScoringMatrix

cdef ScoringMatrix blosum = ScoringMatrix.from_name("BLOSUM62")

# Access as a raw pointer to a dense array
cdef const float * data = blosum.data_ptr()

# Access as an array of pointers (matrix style)
cdef const float ** matrix_ptr = blosum.matrix_ptr()
```

### Buffer Protocol
In modern Python/Cython, you can access the weights as a typed memoryview:
```cython
cdef const float[:, :] weights = blosum
```

## Supported Matrices
The library includes several families of substitution matrices:
- **BLOSUM**: BLOSUM45, BLOSUM50, BLOSUM62, BLOSUM80, BLOSUM90.
- **PAM**: PAM30, PAM70, PAM250.
- **VTML**: VTML10, VTML20, VTML40, VTML80, VTML160.
- **PFASUM**: PFASUM31, PFASUM43, PFASUM60.
- **Specialized**: 3Di (for structural alignment), EDNAFULL (for nucleotide sequences), BENNER matrices.

## Best Practices
- **Avoid Manual Parsing**: Instead of parsing NCBI or EMBOSS matrix files manually, use `ScoringMatrix.from_name()` to ensure consistent indexing and alphabet handling.
- **Memory Efficiency**: The library is dependency-free; use it in lightweight containers or Lambda functions where installing NumPy or Biopython would be overkill.
- **Alphabet Awareness**: Always check the `alphabet` attribute of the loaded matrix to ensure your sequence characters match the matrix's expected residues.

## Reference documentation
- [GitHub Repository - althonos/scoring-matrices](./references/github_com_althonos_scoring-matrices.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_scoring-matrices_overview.md)