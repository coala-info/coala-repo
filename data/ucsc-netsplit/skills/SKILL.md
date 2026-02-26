---
name: ucsc-netsplit
description: UCSC-netsplit splits large whole-genome alignment net files into chromosome-specific files. Use when user asks to 'split whole-genome alignment net files by chromosome', 'prepare alignment data for chromosome-specific workflows', 'create manageable data chunks for the UCSC Genome Browser', or 'speed up alignment pipelines'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-netsplit

## Overview
ucsc-netsplit is a specialized utility from the UCSC Kent toolset used to manage large-scale genomic alignment data. After generating a whole-genome "net" file (which represents the best hierarchical alignments between a query and target genome), the data is often too large for efficient single-threaded processing. This tool automates the process of splitting that master net file into separate files for each target chromosome or scaffold. Use this tool to prepare alignment data for chromosome-specific workflows or to create manageable data chunks for the UCSC Genome Browser.

## Command Line Usage

The primary command for this tool is `netSplit`.

### Basic Syntax
```bash
netSplit input.net outputDir
```

### Common Workflow Pattern
1. **Installation**: The most reliable way to access the tool is via Bioconda.
   ```bash
   conda install -c bioconda ucsc-netsplit
   ```
2. **Preparation**: Ensure your output directory exists before running the command.
   ```bash
   mkdir -p split_nets
   netSplit whole_genome.net split_nets/
   ```

## Expert Tips and Best Practices
* **Pipeline Integration**: `netSplit` is typically used after `chainNet` has produced the initial net file. Once split, you can run tools like `netToAxt` or `netSyntenic` in parallel across the resulting chromosome files to significantly speed up your alignment pipeline.
* **File Permissions**: If you are using the standalone binaries downloaded directly from the UCSC server instead of the Conda package, you must set execution permissions:
  ```bash
  chmod +x netSplit
  ```
* **Output Verification**: After splitting, the output directory will contain files named after the target chromosomes (e.g., `chr1.net`, `chr2.net`). Verify that the number of files matches your target genome's chromosome count to ensure a complete split.
* **Help Statement**: To see the most up-to-date internal documentation and any version-specific flags, run the binary with no arguments:
  ```bash
  netSplit
  ```

## Reference documentation
- [UCSC Genome Browser Binary Downloads](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-netsplit Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-netsplit_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)