---
name: libgab
description: libgab is a specialized C++ library providing a suite of subroutines tailored for bioinformatics data processing.
homepage: https://github.com/grenaud/libgab
---

# libgab

## Overview
libgab is a specialized C++ library providing a suite of subroutines tailored for bioinformatics data processing. It serves as a foundational component for various genomic analysis tools, offering optimized classes for handling common file formats and metadata. Use this skill to understand the library's structure, manage its compilation requirements (specifically its dependency on bamtools), and identify the correct modules for tasks like FastQ parsing or BAM header modification.

## Installation and Build Patterns

### Conda Installation
The most efficient way to deploy the library for use in other projects is via Bioconda:
```bash
conda install bioconda::libgab
```

### Building from Source
When building from the GitHub repository, the library requires `bamtools`. If `bamtools` is not in a standard system path, you must provide the include and library paths to `make`:

```bash
make BAMTOOLSINC="/path/to/bamtools/include/bamtools/" BAMTOOLSLIB="/path/to/bamtools/lib/"
```

Common system-wide paths for Debian/Ubuntu systems:
```bash
make BAMTOOLSINC="/usr/include/bamtools/" BAMTOOLSLIB="/usr/lib/x86_64-linux-gnu/"
```

## Core Functional Modules

The library is organized into several key components that can be included in C++ projects:

*   **BAM Manipulation**: `BamFunctions.h` and `PutProgramInHeaderHTS.h` provide utilities for reading/writing BAM files and injecting program metadata into HTS headers.
*   **FastQ Processing**: `FastQParser.h` and `FastQObj.h` offer high-performance parsing of FastQ sequences.
*   **Reference Reconstruction**: `ReconsReferenceBAM.h` contains logic for reconstructing reference sequences directly from BAM alignments.
*   **General Utilities**: `libgab.h` (formerly `utils.h`) contains general-purpose C++ helper functions used across the library.

## Best Practices

*   **Dependency Management**: Always ensure `bamtools` is installed and accessible before attempting to compile `libgab`.
*   **Linking**: When linking against the compiled library, ensure you include both the `libgab.a` object and the necessary `bamtools` shared libraries.
*   **Header Inclusion**: Use the specific headers (e.g., `#include "FastQParser.h"`) rather than including the entire library if only specific functionality is needed, to keep compilation times efficient.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_grenaud_libgab.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_libgab_overview.md)