---
name: ucsc-chromgraphtobin
description: The tool converts human-readable chromosome graph data into a binary format. Use when user asks to 'convert chromosome graph data to binary', 'transform chromosome graph data', 'prepare genomic data for visualization', or 'compress genomic signal data'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chromgraphtobin

## Overview
The `chromGraphToBin` utility is a specialized tool from the UCSC Genome Browser "kent" source suite. It transforms human-readable chromosome graph data (typically tab-separated values representing genomic coordinates and associated scores) into a binary format. This conversion is essential for improving the performance of genomic data visualization and is a prerequisite for workflows involving the `chromGraphFromBin` tool. It is particularly useful for researchers handling high-density genomic signals where text-based formats become too bulky for efficient processing.

## Usage Instructions

### Basic Command Syntax
The tool is typically executed from the command line with the following structure:
```bash
chromGraphToBin input.txt output.bin
```

### Input Data Requirements
To ensure a successful conversion, your input text file should follow these conventions:
- **Format**: Tab-separated values (TSV).
- **Columns**: Usually requires chromosome, start position, and the data value (score).
- **Sorting**: It is a best practice to ensure your input file is sorted by chromosome and then by start position to prevent errors during binary indexing.

### Permissions and Execution
If you have downloaded the binary directly from the UCSC server:
1. **Grant Execution Rights**:
   ```bash
   chmod +x chromGraphToBin
   ```
2. **Run without arguments**: To see the specific usage statement and any version-specific flags, run the binary alone:
   ```bash
   ./chromGraphToBin
   ```

### Expert Tips
- **Binary Portability**: Note that binary files created by this tool are often architecture-specific. If you move data between a Linux server and a macOS workstation, you may need to re-generate the binary on the target system.
- **Integration**: This tool is the first half of a two-part workflow. Use it to compress your data, and use `chromGraphFromBin` to read or manipulate the resulting binary.
- **Database Connectivity**: While this specific tool is a file converter, many UCSC utilities require an `.hg.conf` file in your home directory if they need to pull chromosome sizes or metadata from the UCSC MySQL servers.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_ucsc-chromgraphtobin_overview.md)