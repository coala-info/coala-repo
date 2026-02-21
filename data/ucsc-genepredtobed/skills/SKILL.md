---
name: ucsc-genepredtobed
description: The `ucsc-genepredtobed` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed for format interoperability.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-genepredtobed

## Overview

The `ucsc-genepredtobed` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed for format interoperability. It transforms gene models stored in the `genePred` format—a table structure used by UCSC to define gene coordinates, exon starts, and exon ends—into standard BED files. This conversion is essential because while `genePred` is efficient for database storage, BED is the industry standard for most downstream genomic analysis software.

## Command Line Usage

The tool is typically invoked using the binary name `genePredToBed`.

### Basic Conversion
To convert a genePred file to a BED file:
```bash
genePredToBed input.genePred output.bed
```

### Common Workflow Patterns
1. **Handling Permissions**: If you have downloaded the binary directly from the UCSC server, ensure it is executable:
   ```bash
   chmod +x genePredToBed
   ./genePredToBed input.gp output.bed
   ```

2. **Sorting Output**: BED files generated from genePred often need to be sorted by chromosome and start position for use with indexing tools (like `tabix`) or for creating `bigBed` files:
   ```bash
   genePredToBed input.gp stdout | bedSort stdin output.sorted.bed
   ```

## Best Practices and Expert Tips

*   **Format Limitation**: This specific version of the tool does not support `genePredExt` (the extended genePred format). If your input file contains additional fields like gene name or protein ID in an extended schema, the tool may fail or truncate data.
*   **Zero-Based Coordinates**: Remember that both `genePred` and `BED` use 0-based, half-open coordinates. The tool performs a direct structural transformation without shifting the coordinate system.
*   **Exon Structure**: The resulting BED file will be a "BED12" format file if the input contains exon information, preserving the block structure (exons) of the gene models.
*   **Verification**: You can verify the integrity of your input genePred file before conversion using the companion tool `genePredCheck`.
*   **Help Menu**: To see the most up-to-date options for your specific build, run the command with no arguments:
   ```bash
   genePredToBed
   ```

## Reference documentation

- [ucsc-genepredtobed Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-genepredtobed_overview.md)
- [UCSC Genome Browser Binaries Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)