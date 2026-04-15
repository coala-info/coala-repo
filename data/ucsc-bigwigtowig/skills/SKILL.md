---
name: ucsc-bigwigtowig
description: This tool converts binary bigWig files into the text-based wiggle (wig) format. Use when user asks to convert bigWig to wig, extract specific genomic regions from a bigWig file, or maintain specific wiggle format structures.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bigwigtowig:482--h0b57e2e_0"
---

# ucsc-bigwigtowig

## Overview
The `ucsc-bigwigtowig` utility is part of the UCSC Genome Browser "kent" toolset. It is designed to decompress and convert binary bigWig files into the original wiggle (wig) format. While `bigWigToBedGraph` is often used to extract signal data into a 4-column BED format, `bigWigToWig` is preferred when you need to maintain the specific wiggle structure (such as `variableStep` or `fixedStep` headers). Note that for very large continuous sections, the tool may still break them into smaller stepped blocks to manage memory and processing.

## Usage Instructions

### Basic Conversion
To convert a bigWig file to a standard wiggle file:
```bash
bigWigToWig input.bw output.wig
```

### Extracting Specific Regions
If you only need data for a specific chromosome or genomic range, use the coordinate flags to avoid generating an unnecessarily large text file:
```bash
bigWigToWig -chrom=chr1 -start=100000 -end=200000 input.bw output.wig
```

### Common CLI Options
- `-chrom=chrN`: Restrict output to a specific chromosome.
- `-start=N`: Start coordinate (0-indexed).
- `-end=N`: End coordinate.
- `-udcDir=/path/to/cache`: Specify a directory for the universal data cache if working with remote files (e.g., via URL).

### Best Practices and Expert Tips
- **File Size Warning**: Wiggle files are text-based and significantly larger than their bigWig counterparts. Ensure you have sufficient disk space before converting whole-genome files.
- **Format Choice**: Use `bigWigToWig` if your downstream application specifically requires `fixedStep` or `variableStep` declarations. If you just need the coordinates and values for a script, `bigWigToBedGraph` is often easier to parse.
- **Permissions**: If you downloaded the binary directly from the UCSC server instead of using a package manager like Conda, you must set execution permissions: `chmod +x bigWigToWig`.
- **Remote Access**: This tool supports URLs as input. If you provide an `http` or `ftp` link, it will fetch only the necessary parts of the bigWig file, which is highly efficient when combined with the `-chrom` flag.

## Reference documentation
- [ucsc-bigwigtowig overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwigtowig_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)