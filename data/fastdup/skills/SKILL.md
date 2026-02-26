---
name: fastdup
description: FastDup is a high-throughput bioinformatics utility designed to mark duplicate reads in coordinate-sorted genomic alignment data while maintaining compatibility with Picard MarkDuplicates. Use when user asks to mark duplicates in BAM files, identify PCR or optical duplicates, or speed up duplicate marking in sequencing pipelines.
homepage: https://github.com/zzhofict/FastDup
---


# fastdup

## Overview
FastDup is a specialized bioinformatics utility designed for marking duplicate reads in genomic alignment data. It utilizes a "speculation-and-test" mechanism to achieve high throughput while maintaining strict algorithmic compatibility with the industry-standard Picard MarkDuplicates. It is particularly useful in high-throughput sequencing pipelines where processing speed and Picard-identical metrics are required.

## Installation
The tool can be installed via Bioconda or built from source.

**Conda installation:**
```bash
conda install -c bioconda fastdup
```

**Source build (requires C++17):**
```bash
git clone https://github.com/zzhofict/FastDup.git
cd FastDup
# Build bundled htslib
cd ext/htslib && autoreconf -i && ./configure && make && cd ../..
# Build FastDup
mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release && make
```

## Common CLI Patterns

### Basic Duplicate Marking
The most common use case involves taking a coordinate-sorted BAM file and producing a marked BAM along with a metrics file.
```bash
fastdup \
  --input sample_sorted.bam \
  --output sample_marked.bam \
  --metrics sample_metrics.txt \
  --num-threads 8
```

### Performance Optimization
FastDup scales effectively with thread count. Always specify `--num-threads` to match the available CPU cores for maximum speedup.
```bash
fastdup -i input.bam -o output.bam -m stats.txt -t 16
```

## Expert Tips and Best Practices

### Input Requirements
*   **Coordinate Sorting**: FastDup **requires** the input SAM/BAM file to be coordinate-sorted. Its performance gains are derived from the data characteristics of sorted files. If the file is queryname-sorted or unsorted, use `samtools sort` first.
*   **Memory Usage**: While FastDup is memory-efficient and processes data in-memory, ensure the system has enough RAM to hold the necessary read-end information for the specific library size being processed.

### Picard Compatibility
*   **Identical Results**: The duplicate sets and metrics generated are identical to Picard MarkDuplicates.
*   **Marking Stability**: While the *sets* of duplicates are identical, the specific read chosen as the "representative" (non-duplicate) might differ from Picard due to differences in sorting stability. This does not affect downstream variant calling or metrics.
*   **Optical Duplicates**: FastDup intentionally retains a known Picard "overflow bug" when parsing large coordinates to maintain 100% compatibility.

### Troubleshooting
*   **Logging**: FastDup uses `spdlog` for logging. The default level is `info`. Monitor the console output for warnings regarding malformed records or coordinate issues.
*   **Help Command**: Use the help flag to see all available parameters:
    ```bash
    fastdup --help
    ```

## Reference documentation
- [FastDup GitHub Repository](./references/github_com_zzhofict_FastDup.md)
- [FastDup Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastdup_overview.md)