---
name: ucsc-chainswap
description: This tool inverts the target and query sequences within a chain alignment file. Use when user asks to swap alignment coordinates, invert the relationship between reference and source genomes, or prepare files for reciprocal best-hit pipelines.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chainswap

## Overview
The `chainSwap` utility is a specialized tool from the UCSC Genome Browser "kent" source tree used in comparative genomics. Its primary function is to invert the relationship between the target (reference) and query (source) sequences within a `.chain` alignment file. 

This is a critical step in reciprocal best-hit pipelines or when you have an alignment generated in one direction but require the coordinates to be relative to the other genome for downstream analysis, such as lifting over coordinates or creating reciprocal nets.

## Usage Instructions

### Basic Command
The tool follows a simple positional argument structure:

```bash
chainSwap input.chain output.chain
```

### Functional Mechanics
- **Role Reversal**: The sequence identified as the "target" in the input becomes the "query" in the output, and vice versa.
- **Coordinate Recalculation**: The tool automatically handles the recalculation of start/end positions and strand orientations to ensure the alignment remains biologically accurate in the swapped orientation.
- **Header Updates**: The chain header lines are updated to reflect the new target and query sequence names and sizes.

### Expert Tips and Best Practices
- **Sorting Requirement**: Swapping a chain file often breaks the target-coordinate sorting order. Most downstream UCSC tools (like `chainNet` or `chainMergeSort`) require chains to be sorted by target chrom, then start position. Always pipe to or follow up with `chainSort`:
  ```bash
  chainSwap in.chain stdout | chainSort stdin out.chain
  ```
- **Validation**: Use `checkChain` on the output to ensure that the swapped coordinates do not exceed the sequence sizes defined in the headers.
- **Reciprocal Best Chains**: `chainSwap` is the first step in creating "Reciprocal Best" alignments. The standard workflow is:
  1. `chainSwap` the original alignments.
  2. `chainSort` the swapped alignments.
  3. Run `chainNet` on the swapped, sorted alignments.
  4. Use `netChainSubset` to extract the reciprocal best set.

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-chainswap Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chainswap_overview.md)
- [UCSC Kent Source Utilities List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.aarch64.v492.md)