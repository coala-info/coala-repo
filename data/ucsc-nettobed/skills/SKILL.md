---
name: ucsc-nettobed
description: The `netToBed` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to extract target coverage information from alignment net files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-nettobed

## Overview
The `netToBed` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to extract target coverage information from alignment net files. Alignment nets represent the best orthologous chains between two genomes, organized hierarchically. This tool flattens that relationship into a BED file, making it easy to see which parts of the target genome are covered by alignments in the net.

## Usage Instructions

### Basic Command Line Pattern
The tool follows the standard UCSC binary convention where the input and output are positional arguments:

```bash
netToBed input.net output.bed
```

### Common Workflow Integration
`netToBed` is typically used after the `chainNet` utility. A common comparative genomics pipeline looks like:
1. Generate alignments (e.g., using `lastz`).
2. Chain alignments (using `axtChain`).
3. Create nets (using `chainNet`).
4. **Convert to BED** (using `netToBed`) to visualize the final alignment coverage.

### Expert Tips
- **Binary Execution**: If you encounter a "permission denied" error when running a downloaded binary, ensure it is executable using `chmod +x netToBed`.
- **No Arguments**: Running the command without any arguments will display the built-in help text and version information, which is the most reliable way to check for specific flags supported by your local version.
- **BED Compatibility**: The resulting BED file is compatible with `bedtools`, `bigBed` conversion tools (`bedToBigBed`), and can be uploaded directly as a custom track to the UCSC Genome Browser.

## Reference documentation
- [UCSC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-nettobed_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Tool List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)