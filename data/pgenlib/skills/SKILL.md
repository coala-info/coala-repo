---
name: pgenlib
description: pgenlib is a Python wrapper for the core C++ library used by PLINK 2.0.
homepage: https://github.com/chrchang/plink-ng
---

# pgenlib

## Overview
pgenlib is a Python wrapper for the core C++ library used by PLINK 2.0. It provides a high-performance interface for interacting with PGEN files, which are the successor to the classic PLINK BED format. This skill enables the efficient handling of large-scale genomic datasets, including support for multiallelic variants, phased data, and dosage information that traditional formats cannot represent.

## Installation
The library is primarily distributed via Bioconda.
```bash
conda install bioconda::pgenlib
```

## Core Usage Patterns

### Reading PGEN Files
The library uses a structured initialization process. You typically interact with `PgenReader` to access genotype data.

1.  **Initialization**: Use `PgenReader` to open the file.
2.  **Metadata**: Ensure you have the corresponding `.pvar` (variant info) and `.psam` (sample info) files, as the `.pgen` file itself contains the compressed genotypes.
3.  **Data Extraction**: Use methods like `PgrGet` to retrieve specific variant data.

### Performance Best Practices
*   **GIL Management**: Recent versions of pgenlib release the Global Interpreter Lock (GIL) during multithreaded PGEN reading, allowing for significant speedups in parallel processing workflows.
*   **Memory Allocation**: Be aware of memory allocation when calling initialization phases (e.g., `PgfiInitPhase2`). Ensure your buffers are correctly sized for the number of samples in the dataset.
*   **Chunking**: When dealing with massive datasets (e.g., UK Biobank scale), read samples in chunks to avoid memory exhaustion.

### Common Troubleshooting
*   **Segfaults**: Often caused by incorrect buffer sizes or calling getter methods before the reader is fully initialized. Always verify the number of variants and samples from the header before attempting to read genotypes.
*   **Architecture Support**: The library supports `linux-64`, `macOS-64`, `linux-aarch64`, and `macOS-arm64`. Ensure your environment matches these supported platforms.

## Expert Tips
*   **Dosage Data**: Unlike the older BED format, pgenlib can handle dosage data. When working with imputed data, ensure you are using the appropriate methods to extract dosages rather than just hard-call genotypes.
*   **VCF Conversion**: PLINK 2.0 uses pgenlib internally for VCF to PGEN conversion. If you encounter issues with contig names or irregular BCF flag encoding, check for the latest updates in the `plink-ng` repository, as these are frequently addressed in alpha releases.

## Reference documentation
- [pgenlib Overview](./references/anaconda_org_channels_bioconda_packages_pgenlib_overview.md)
- [PLINK-NG Repository](./references/github_com_chrchang_plink-ng.md)
- [pgenlib Discussions](./references/github_com_chrchang_plink-ng_discussions.md)