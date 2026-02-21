---
name: ucsc-fetchchromsizes
description: The `fetchChromSizes` utility is a specialized script from the UCSC Genome Browser "kent" tool suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-fetchchromsizes

## Overview
The `fetchChromSizes` utility is a specialized script from the UCSC Genome Browser "kent" tool suite. It automates the retrieval of chromosome length information for a specified database (e.g., hg38, mm10). This information is typically output as a two-column, tab-separated text file where the first column is the chromosome name and the second is the size in base pairs.

## Usage Instructions

### Basic Command Pattern
To fetch sizes for a specific genome assembly, provide the UCSC database name as the single argument:

```bash
fetchChromSizes hg38 > hg38.chrom.sizes
```

### Common Database Identifiers
*   **Human**: `hg38`, `hg19`
*   **Mouse**: `mm36`, `mm10`, `mm9`
*   **Rat**: `rn7`, `rn6`
*   **Zebrafish**: `danRer11`
*   **Fruit Fly**: `dm6`

### Expert Tips and Best Practices
*   **Standardize Output**: Always redirect the output to a file (usually named `<db>.chrom.sizes`). The tool writes to stdout by default.
*   **Verify Assembly Names**: Ensure you are using the exact UCSC database string. If you use an Ensembl or NCBI name that differs from UCSC (e.g., `GRCh38` vs `hg38`), the tool will fail to find the database.
*   **Downstream Compatibility**: The output of this tool is the primary input required for `bedGraphToBigWig` and `bedToBigBed`.
*   **Network Dependency**: This tool requires an active internet connection to query the UCSC servers. If working in a restricted environment, fetch the sizes once and store them locally.
*   **Permissions**: If you downloaded the binary directly from the UCSC repository instead of using a package manager like Conda, ensure the file is executable:
    ```bash
    chmod +x fetchChromSizes
    ```

## Reference documentation
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-fetchchromsizes Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fetchchromsizes_overview.md)