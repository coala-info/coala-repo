---
name: pylibseq
description: pylibseq provides high-performance Python bindings for calculating evolutionary statistics on genomic polymorphism data. Use when user asks to calculate population genetic statistics, analyze site frequency spectra, or estimate linkage disequilibrium and haplotype diversity.
homepage: http://pypi.python.org/pypi/pylibseq
---


# pylibseq

## Overview
pylibseq provides high-performance Python bindings for the C++11 library `libsequence`. It is designed for researchers who need to calculate evolutionary statistics on large-scale genomic polymorphism data. While the underlying engine is C++, this skill allows for seamless integration of these calculations into Python-based bioinformatics pipelines, particularly for data manipulation and population genetic inference.

## Core Usage Patterns

### Installation
The package is best installed via bioconda to ensure all C++ dependencies are correctly linked:
```bash
conda install -c bioconda pylibseq
```

### Data Handling
*   **Input Structure**: pylibseq typically operates on objects representing sequence polymorphism (e.g., `SimData` or `PolyData`).
*   **No Native I/O**: Note that pylibseq does not provide built-in file parsers (like FASTA or VCF readers). You must use standard Python libraries (like `pysam` or `biopython`) to load your data and then pass the relevant polymorphism information to pylibseq objects.

### Common Statistics
The library is optimized for calculating:
*   **Site Frequency Spectrum (SFS) based stats**: Tajima's D, $\theta_w$, $\theta_{\pi}$.
*   **Linkage Disequilibrium**: $r^2$, $D'$.
*   **Haplotype Diversity**: Number of haplotypes and haplotype homozygosity.
*   **Divergence**: Statistics comparing multiple populations.

### Performance Tips
*   **Memory Management**: As of version 0.2.0, the library uses `pybind11` and `unique_ptr` for robust memory management. However, when working with extremely large datasets, process data in genomic windows to minimize the memory footprint of the C++ objects.
*   **GIL Handling**: Many underlying C++ functions are declared "nogil," meaning they can run in parallel across multiple Python threads if you use a threading library.

## Expert Tips
*   **Version Compatibility**: Ensure your Python environment is 3.4 or higher. If building from source, a C++11 compatible compiler (GCC 4.8+ or Clang 3.5+) is mandatory.
*   **Unit Testing**: If you suspect calculation errors, run the internal suite to verify the bindings: `python -m unittest discover tests`.
*   **Class Naming**: Class names in pylibseq are "Pythonic" but map directly to `libsequence` types. If you are familiar with the C++ library, the transition to the Python API is 1:1.

## Reference documentation
- [pylibseq PyPI Project Description](./references/pypi_org_project_pylibseq.md)
- [pylibseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pylibseq_overview.md)