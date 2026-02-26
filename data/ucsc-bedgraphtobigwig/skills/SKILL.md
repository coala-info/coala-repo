---
name: ucsc-bedgraphtobigwig
description: ucsc-bedgraphtobigwig transforms bedGraph files into bigWig files. Use when user asks to transform bedGraph to bigWig, convert genomic signal tracks for visualization, or create indexed binary files for large-scale data sharing.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedgraphtobigwig

## Overview
The `bedGraphToBigWig` utility is a core tool from the UCSC Genome Browser "kent" suite designed for high-performance genomic data management. It transforms bedGraph files—which represent continuous-valued genomic data in a four-column text format—into bigWig files. BigWig files are binary, indexed, and compressed, making them the standard for sharing and visualizing large-scale signal tracks (like ChIP-seq or RNA-seq coverage) because they allow for rapid data retrieval over specific genomic coordinates without loading the entire dataset into memory.

## Usage Instructions

### Basic Command Syntax
The tool requires three arguments: the input bedGraph file, a file containing chromosome sizes, and the desired output filename.

```bash
bedGraphToBigWig input.bedGraph chrom.sizes output.bw
```

### Critical Prerequisites
1.  **Sorted Input**: The input bedGraph file **must** be sorted by chromosome and then by start position. If the file is not sorted, the tool will fail.
    *   **Expert Tip**: Use the following command to ensure proper sorting compatible with UCSC tools:
        ```bash
        LC_COLLATE=C sort -k1,1 -k2,2n input.bedGraph > input.sorted.bedGraph
        ```
2.  **Chromosome Sizes File**: This is a two-column tab-separated text file where each line contains `<chromosome_name> <size_in_bp>`.
    *   You can often generate this using the UCSC `fetchChromSizes` utility for standard assemblies (e.g., `fetchChromSizes hg38 > hg38.chrom.sizes`).

### Common CLI Options
*   `-blockSize=N`: Sets the number of items bundled into a r-tree index node. Default is 256. Increasing this can slightly speed up queries on very large files but increases index size.
*   `-itemsPerSlot=N`: Sets the number of data points bundled at the lowest level. Default is 1024.
*   `-unc`: If specified, the output file will not be compressed. This results in faster creation but significantly larger files.

### Troubleshooting and Best Practices
*   **Permission Denied**: If running a freshly downloaded binary, ensure it is executable: `chmod +x bedGraphToBigWig`.
*   **Memory Usage**: `bedGraphToBigWig` is generally memory-efficient as it processes the file in a single pass, but it requires the input to be on a local or high-speed filesystem for optimal performance.
*   **Validation**: After creation, you can verify the bigWig file metadata using `bigWigInfo output.bw`.

## Reference documentation
- [ucsc-bedgraphtobigwig overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedgraphtobigwig_overview.md)
- [UCSC Binary Utilities Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)