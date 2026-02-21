---
name: ucsc-bigwigmerge
description: `bigWigMerge` is a specialized utility from the UCSC Genome Browser "kent" toolset designed to aggregate signal values from multiple BigWig files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bigwigmerge

## Overview

`bigWigMerge` is a specialized utility from the UCSC Genome Browser "kent" toolset designed to aggregate signal values from multiple BigWig files. It identifies overlapping genomic intervals across all input files and sums their signal scores, producing a unified BedGraph file as output. This tool is primarily used in bioinformatics workflows to create consensus tracks from biological replicates or to merge signal data from different experimental conditions for comparative visualization.

## Usage Instructions

### Basic Command Syntax
The tool follows a straightforward positional argument pattern where all input BigWig files are listed followed by the desired output BedGraph filename.

```bash
bigWigMerge input1.bw input2.bw input3.bw output.bedGraph
```

### Common CLI Patterns

1.  **Merging Multiple Replicates**:
    When dealing with many files, use wildcards to simplify the command:
    ```bash
    bigWigMerge replicates/*.bw merged_signal.bedGraph
    ```

2.  **Converting Output back to BigWig**:
    Because `bigWigMerge` outputs a BedGraph (text-based), you must use `bedGraphToBigWig` if you require a binary BigWig for visualization in genome browsers:
    ```bash
    # 1. Merge
    bigWigMerge in1.bw in2.bw out.bedGraph
    # 2. Sort (required for conversion)
    bedSort out.bedGraph out.sorted.bedGraph
    # 3. Convert
    bedGraphToBigWig out.sorted.bedGraph chrom.sizes out.bw
    ```

### Expert Tips and Best Practices

*   **Coordinate Consistency**: Ensure all input BigWig files are mapped to the same genome assembly (e.g., hg38 or mm10). The tool does not perform coordinate lifting or validation between different assemblies.
*   **Sorting Requirements**: While `bigWigMerge` produces a BedGraph, the output is not necessarily sorted in the specific way required by `bedGraphToBigWig`. Always run `bedSort` on the resulting BedGraph before attempting to convert it back to a BigWig.
*   **Memory Considerations**: For a very large number of input files or extremely dense signal data, ensure the environment has sufficient memory, as the tool must track overlapping intervals across all inputs.
*   **Binary Availability**: Binaries are platform-specific. If you encounter "permission denied" errors after downloading, remember to set executable permissions using `chmod +x bigWigMerge`.

## Reference documentation

- [ucsc-bigwigmerge Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwigmerge_overview.md)
- [UCSC Binary Downloads](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)