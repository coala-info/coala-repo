---
name: ucsc-hgfakeagp
description: ucsc-hgfakeagp creates a synthetic AGP file by scanning a FASTA file for sequences of 'N's. Use when user asks to create an AGP file from a FASTA file, generate an AGP file, or identify gaps in a FASTA.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-hgfakeagp

## Overview
The `ucsc-hgfakeagp` tool (binary name `hgFakeAgp`) is a specialized utility from the UCSC Genome Browser "kent" source tree. It allows researchers to create a "fake" or synthetic AGP file by scanning a FASTA file for sequences of 'N's. In bioinformatics, an AGP file is essential for describing the layout of an assembly, specifying which parts of a sequence are biological contigs and which parts are gaps (and the length of those gaps). This tool is particularly useful when you have a scaffolded FASTA file but lack the original assembly instructions required by certain databases or pipelines.

## Usage Instructions

### Basic Command Pattern
The standard invocation for the tool follows the common UCSC utility pattern of `tool [input] [output]`:

```bash
hgFakeAgp input.fa output.agp
```

### Identifying Gaps
The tool operates by:
1. Scanning the input FASTA for contiguous non-N characters (defined as contigs).
2. Identifying runs of 'N' characters (defined as gaps).
3. Assigning coordinates and incrementing component IDs to produce a valid AGP format.

### Viewing Advanced Options
UCSC command-line utilities are self-documenting. To see specific version information or available flags (such as minimum gap size thresholds), run the binary with no arguments:

```bash
hgFakeAgp
```

## Best Practices and Expert Tips
- **Permissions**: If you have just downloaded the binary from the UCSC server, you must grant execution permissions before use: `chmod +x hgFakeAgp`.
- **FASTA Formatting**: Ensure your input FASTA has clear headers. The tool uses the sequence identifiers in the FASTA headers to populate the "object" column in the resulting AGP file.
- **Gap Sensitivity**: Be aware that even a single 'N' might be interpreted as a gap depending on the tool's default settings. If your sequence contains ambiguous bases that are not intended to represent assembly gaps, you may need to pre-process the FASTA or check for flags that define a minimum gap length.
- **Database Connectivity**: While `hgFakeAgp` is a standalone file-processing utility, other UCSC tools in the same suite may require an `.hg.conf` file in your home directory to connect to public MySQL servers. For simple AGP generation, this is typically not required.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgfakeagp Package Summary](./references/anaconda_org_channels_bioconda_packages_ucsc-hgfakeagp_overview.md)