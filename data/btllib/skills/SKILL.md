---
name: btllib
description: `btllib` is a high-performance C++ library with Python wrappers developed by the Bioinformatics Technology Lab.
homepage: https://github.com/bcgsc/btllib
---

# btllib

## Overview
`btllib` is a high-performance C++ library with Python wrappers developed by the Bioinformatics Technology Lab. It serves as a foundational toolkit for bioinformatics software development, offering optimized implementations of essential algorithms. Use this skill to navigate its Python API, manage its environment dependencies (like SAMtools and various compression utilities), and configure the library for either standalone Python scripts or integration into larger C++ projects.

## Installation and Environment Setup
The most reliable way to deploy `btllib` is via the Bioconda channel.

```bash
# Recommended installation
conda install -c bioconda -c conda-forge btllib
```

### Runtime Dependencies
Ensure the following tools are available in your PATH for full functionality:
- **Sequence Processing**: `SAMtools` (required for SAM, BAM, and CRAM support).
- **Compression**: `gzip`, `pigz`, `bzip2`, `xz`, or `7zip` (depending on the formats you intend to process).
- **Network**: `wget` (required for downloading sequences directly from URLs).

## Python API Best Practices
The Python wrappers generally map one-to-one with the C++ API, with specific naming conventions for compatibility.

### Class Naming Conventions
- **Nested Classes**: In Python, nested C++ classes are accessed by prefixing the inner class with the outer class name.
  - *C++*: `btllib::SeqReader::Flag`
  - *Python*: `btllib.SeqReaderFlag`
- **Bloom Filters**: Specific bit-width variants are exposed directly.
  - Use `CountingBloomFilter8`, `CountingBloomFilter16`, or `CountingBloomFilter32` based on your counter depth requirements.
  - K-mer specific versions follow the same pattern: `KmerCountingBloomFilter8`, etc.

### Sequence Reading
Use `SeqReader` for efficient iteration through genomic files. If you have compiled from source and not installed via pip, you must manually point to the library:
```python
import sys
# Replace $PREFIX with your installation path
sys.path.append('$PREFIX/lib/btllib/python')
import btllib
```

## C++ Integration Patterns
When linking `btllib` into external C++ projects, use the following environment configurations:

- **Compiler Requirement**: Use GCC 6+ or Clang 5+ with C++17 support.
- **Linking**: Link against `libbtllib.a`.
- **Flags**:
  ```bash
  export CPPFLAGS="-isystem /path/to/btllib/install/include $CPPFLAGS"
  export LDFLAGS="-L/path/to/btllib/install/lib -lbtllib $LDFLAGS"
  ```

## Expert Tips
- **Thread Safety**: When using `ntHash` or Bloom filter operations, ensure you are leveraging the library's OpenMP support for parallel processing of large sequence sets.
- **Memory Efficiency**: Choose the smallest bit-width for `CountingBloomFilter` (e.g., 8-bit) that can accommodate your expected maximum k-mer count to minimize the memory footprint.
- **Path Handling**: Note that some components (like `indexlr`) may have issues with spaces in file paths; always use sanitized or quoted paths for genomic input files.

## Reference documentation
- [btllib GitHub Repository](./references/github_com_bcgsc_btllib.md)
- [btllib Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_btllib_overview.md)