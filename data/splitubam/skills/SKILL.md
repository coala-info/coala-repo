---
name: splitubam
description: splitubam is a high-performance utility written in Rust designed to rapidly partition unmapped BAM files.
homepage: https://github.com/fellen31/splitubam
---

# splitubam

## Overview
splitubam is a high-performance utility written in Rust designed to rapidly partition unmapped BAM files. It is specifically optimized for speed, using parallel decompression and writing threads to split a single input file into a user-defined number of output files. This is essential for distributed processing environments where large datasets must be processed across multiple compute nodes.

## Usage and Best Practices

### Basic Command Structure
The primary requirement is the input file and the number of desired splits.
```bash
splitubam <INPUT_BAM> --split <NUMBER_OF_FILES>
```

### Performance Optimization
*   **Threading**: By default, the tool uses 4 threads. For large datasets on high-core systems, increase this to match your available CPU resources to speed up decompression and writing.
    ```bash
    splitubam input.bam --split 8 --threads 16
    ```
*   **Compression Levels**: The default compression level is 6. If disk space is a concern, increase this (up to 9). If processing speed is the priority and you have ample storage, decrease it (e.g., 1 or 2).
    ```bash
    splitubam input.bam --split 4 --compression 1
    ```

### Output Convention
When you run `splitubam test.bam --split 4`, the tool automatically generates files with a three-digit prefix:
*   `001.test.bam`
*   `002.test.bam`
*   `003.test.bam`
*   `004.test.bam`

### Expert Tips and Limitations
*   **Read Count vs. Split Count**: If the number of reads in your input BAM is less than the number of splits requested, the tool will only create as many files as there are reads.
*   **Empty Files**: Be cautious with empty input files; the tool currently requires at least one read to function as expected in standard pipelines.
*   **uBAM Focus**: While designed for unmapped BAMs (uBAM), it functions by line/record. It does not perform coordinate-based splitting; it is strictly for partitioning data for parallel processing.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_fellen31_splitubam.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_splitubam_overview.md)