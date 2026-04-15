---
name: ucsc-maftopsl
description: ucsc-maftopsl transforms MAF alignment blocks into PSL records. Use when user asks to convert MAF to PSL, process comparative genomics data, or prepare alignments for Genome Browser visualization.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-maftopsl:482--h0b57e2e_0"
---

# ucsc-maftopsl

## Overview
The `mafToPsl` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to transform MAF alignment blocks into PSL records. You should use this skill when you need to process comparative genomics data (like whole-genome alignments) for use in tools that require PSL input, such as `pslCheck`, `pslMap`, or for custom track visualization in the Genome Browser.

## Usage Instructions

### Basic Command Pattern
The tool follows the standard UCSC binary convention of taking an input file and an output file as positional arguments:

```bash
mafToPsl input.maf output.psl
```

### Installation and Setup
If the tool is not already in your environment, it can be installed via Bioconda:
```bash
conda install bioconda::ucsc-maftopsl
```

If using the standalone binary downloaded directly from the UCSC servers:
1. Ensure the binary has execution permissions: `chmod +x mafToPsl`
2. If the tool requires connection to the UCSC public MySQL server (though typically not needed for simple format conversion), ensure an `.hg.conf` file is present in your home directory.

### Expert Tips
- **Help Menu**: Since this tool is part of the kent suite, running the command with no arguments will display the most current usage statement and available options directly in the terminal.
- **MAF Requirements**: Ensure your MAF file is properly formatted with 's' lines (sequence lines). The tool parses these to calculate the coordinates and block sizes required for the PSL format.
- **PSL Output**: The resulting PSL file will represent the alignments from the perspective of the first sequence in each MAF block (the "target").

## Reference documentation
- [ucsc-maftopsl Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-maftopsl_overview.md)
- [UCSC Admin Executable Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)