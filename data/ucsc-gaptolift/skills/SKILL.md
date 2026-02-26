---
name: ucsc-gaptolift
description: The ucsc-gaptolift utility generates lift files from genomic gap data to facilitate coordinate transformations across assembly structures. Use when user asks to create lift files from gap tables, generate mapping files for liftUp, or convert assembly gap coordinates into lift format.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-gaptolift

## Overview
The `gapToLift` utility is a specialized tool from the UCSC Genome Browser "kent" source suite. It automates the generation of lift files by reading gap data, which defines regions of unknown sequence or assembly breaks. By identifying these gaps, the tool helps construct the mapping necessary to translate coordinates across genomic regions where the underlying sequence remains consistent despite changes in the overall assembly structure.

## Usage Patterns

### Basic Command Structure
The tool typically requires the input gap table and the name of the output lift file.

```bash
gapToLift gapTable.txt output.lift
```

### Common Workflow: Generating Lift Files for Assembly Updates
When working with UCSC assembly data, the gap table (often named `gap.txt.gz`) contains the coordinates of gaps between contigs or scaffolds.

1. **Download the gap table**: Obtain the gap data for your specific organism and assembly from the UCSC GoldenPath downloads.
2. **Run gapToLift**:
   ```bash
   gapToLift gap.txt out.lift
   ```
3. **Verify Output**: The resulting `.lift` file can be used with the `liftUp` utility to adjust coordinates in associated files (like `.fa` or `.agp`).

## Expert Tips
- **Input Format**: Ensure your input file follows the UCSC gap table schema (chrom, chromStart, chromEnd, ix, n, size, type, bridge). If your data is in a different format, use `awk` or `sed` to reformat it to match the expected tab-separated columns.
- **Coordinate Systems**: Remember that UCSC tools generally use 0-based, half-open coordinates. Ensure your input gap table adheres to this convention to avoid off-by-one errors in the resulting lift file.
- **Integration with liftUp**: `gapToLift` is frequently the first step in a pipeline where the output `.lift` file is passed to `liftUp` to perform the actual coordinate transformations on sequence or annotation files.
- **Permission Handling**: If running the binary directly from a download, ensure it has execution permissions: `chmod +x gapToLift`.

## Reference documentation
- [ucsc-gaptolift overview](./references/anaconda_org_channels_bioconda_packages_ucsc-gaptolift_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)