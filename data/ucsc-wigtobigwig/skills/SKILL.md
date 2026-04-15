---
name: ucsc-wigtobigwig
description: ucsc-wigtobigwig converts ASCII-formatted Wiggle files into the compressed, binary BigWig format. Use when user asks to convert Wiggle files to BigWig, prepare genomic signal data for the UCSC Genome Browser, or create BigWig files for rapid random access.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-wigtobigwig:482--hdc0a859_1"
---

# ucsc-wigtobigwig

## Overview
The `wigToBigWig` utility is a core component of the UCSC Kent toolkit. It transforms ASCII-formatted Wiggle files (supporting both `fixedStep` and `variableStep` formats) into a compressed, binary BigWig format. This conversion is a standard requirement for hosting data tracks on the UCSC Genome Browser or for any application requiring rapid random access to large-scale genomic signal data.

## Command Line Usage

The basic syntax for the tool requires an input WIG file, a chromosome sizes file, and the desired output filename:

```bash
wigToBigWig input.wig chrom.sizes output.bw
```

### Required Inputs
1.  **input.wig**: The ASCII Wiggle file. It must be properly formatted as `fixedStep` or `variableStep`.
2.  **chrom.sizes**: A two-column tab-separated text file containing `<chromosome_name> <size_in_bp>`. You can typically generate this using the `fetchChromSizes` utility for standard assemblies (e.g., `fetchChromSizes hg38 > hg38.chrom.sizes`).

### Common Options
-   `-clip`: If the WIG file contains data points extending beyond the chromosome sizes defined in `chrom.sizes`, this flag will clip them rather than throwing an error.
-   `-fixedSummaries`: Use this to generate a BigWig with a fixed number of summary levels, which can be faster for certain visualization use cases.
-   `-keepAllChromosomes`: Ensures that all chromosomes listed in the `chrom.sizes` file are included in the output, even if they have no data in the WIG file.

## Expert Tips and Best Practices

### Input Sorting
The input WIG file must be sorted by chromosome and then by start position. If your data is unsorted, the tool will fail. For `variableStep` data, ensure the positions are strictly increasing within each chromosome block.

### Memory Management
`wigToBigWig` can be memory-intensive because it builds the B+ tree index in memory. For extremely large datasets or systems with limited RAM, ensure you are using the 64-bit version of the binary and monitor swap usage.

### Validation
Before conversion, you can validate your WIG file structure. A common point of failure is a mismatch between the chromosome names in the WIG headers (e.g., `chr1`) and the names in the `chrom.sizes` file. They must match exactly.

### BigWig vs. BedGraph
If your signal data is in four-column BED format (chrom, start, end, score), use `bedGraphToBigWig` instead. `wigToBigWig` is specifically optimized for the more structured `fixedStep` and `variableStep` Wiggle formats.

## Reference documentation
- [ucsc-wigtobigwig Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-wigtobigwig_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)