---
name: ucsc-bigpsltopsl
description: This tool converts bigPsl binary alignment files into the psl text format. Use when user asks to convert bigPsl to psl, transform bigPsl alignment data, or revert binary alignment tracks to text format.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bigpsltopsl

## Overview
The `bigPslToPsl` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to transform alignment data. While `bigPsl` is a binary format (a variant of BigBed) optimized for performance and indexing in genome browsers, the `psl` format is a traditional, tab-delimited text format used for sequence alignments. This skill allows you to revert binary alignment tracks back into a format suitable for text-processing tools like `awk`, `grep`, or custom parsing scripts.

## Usage Instructions

### Basic Command Line Pattern
The tool follows the standard UCSC utility pattern of taking an input file and an output file as positional arguments:

```bash
bigPslToPsl input.bigPsl output.psl
```

### Installation and Setup
If the tool is not already in your environment, it is most easily managed via Bioconda:

```bash
conda install bioconda::ucsc-bigpsltopsl
```

If you are using a standalone binary downloaded directly from the UCSC servers, ensure the file has execution permissions:

```bash
chmod +x bigPslToPsl
./bigPslToPsl input.bigPsl output.psl
```

### Best Practices and Expert Tips
*   **Help Documentation**: Like most UCSC tools, running the command with no arguments will display the built-in help and version information.
*   **Storage Considerations**: Be aware that `psl` files are uncompressed text and will be significantly larger than the source `bigPsl` files. Ensure you have adequate disk space before converting large alignment tracks.
*   **Format Validation**: `bigPsl` files are technically BigBed files with a specific schema. If the tool fails, verify that the input file is a valid BigBed file using `bigBedInfo`.
*   **Piping**: While UCSC tools often support `stdout` by using `/dev/stdout` or `-` as the output filename, verify the specific version's behavior by checking the help text if you intend to pipe the output directly into another tool.

## Reference documentation
- [ucsc-bigpsltopsl overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigpsltopsl_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)