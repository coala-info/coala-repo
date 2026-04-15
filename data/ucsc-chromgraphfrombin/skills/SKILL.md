---
name: ucsc-chromgraphfrombin
description: `ucsc-chromgraphfrombin` converts binary chromGraph files into an ASCII text representation. Use when user asks to decode binary chromGraph files, convert binary chromGraph to text, inspect binary track data, or debug genomic visualization issues.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-chromgraphfrombin:482--h0b57e2e_0"
---

# ucsc-chromgraphfrombin

## Overview
The `ucsc-chromgraphfrombin` utility is a specialized tool within the UCSC Kent command-line suite used to decode binary chromGraph files. ChromGraph files are typically used to represent genome-wide data points (like signal tracks) for display on the UCSC Genome Browser. While the binary version of this format is optimized for storage and rapid access by the browser, it is opaque to standard text-processing tools. This skill allows you to revert those files to an ASCII representation for manual inspection, editing, or analysis with common Unix utilities like `awk`, `sed`, or `grep`.

## Usage Instructions

### Basic Command Pattern
The tool follows the standard UCSC Kent utility convention of taking an input file and an output file as positional arguments:

```bash
chromGraphFromBin input.bin output.txt
```

### Environment Setup
1.  **Permissions**: If you have downloaded the binary directly from the UCSC server, ensure it has execution permissions:
    ```bash
    chmod +x ./chromGraphFromBin
    ```
2.  **Installation**: The tool is most easily managed via Bioconda. If it is not in your path, you can install it using:
    ```bash
    conda install -c bioconda ucsc-chromgraphfrombin
    ```

### Workflow Integration
*   **Data Inspection**: Use this tool to verify the contents of a binary track before uploading it to a track hub or the UCSC Genome Browser.
*   **Inverse Operation**: If you need to convert ASCII data back into the optimized binary format for browser performance, use the companion tool `chromGraphToBin`.
*   **Pipeline Debugging**: If a genomic visualization is appearing incorrectly, convert the binary source to ASCII to check for coordinate shifts or malformed data values.

### Expert Tips
*   **No Arguments**: Running the command without any arguments will display the specific version and any available internal flags.
*   **Standard Output**: In many Kent utilities, using `stdout` as the output filename allows you to pipe the ASCII data directly into other tools (e.g., `chromGraphFromBin input.bin stdout | head`).
*   **Binary Compatibility**: Ensure the binary was built for your specific architecture (e.g., linux.x86_64 or macOSX.arm64) as these utilities are platform-dependent.

## Reference documentation
- [ucsc-chromgraphfrombin - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-chromgraphfrombin_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)