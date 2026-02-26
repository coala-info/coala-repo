---
name: ucsc-chainsort
description: The ucsc-chainsort tool organizes pairwise genomic alignment records within .chain files. Use when user asks to organize genomic alignment records, sort .chain files, or prepare alignment data for comparative genomics workflows.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chainsort

## Overview
The `ucsc-chainsort` utility (often invoked as `chainSort`) is a specialized tool from the UCSC Genome Browser "kent" source tree. It is designed to organize pairwise genomic alignment records within `.chain` files. By default, it sorts alignments by their score in descending order. This organization is a critical prerequisite for many comparative genomics workflows, particularly when generating alignment "nets" or merging multiple alignment sets.

## Usage Instructions

### Basic Command Pattern
The tool follows a simple input/output file pattern:
```bash
chainSort input.chain output.chain
```

### Key Functional Details
- **Default Sorting**: If no specific flags are provided, the tool sorts by the alignment score.
- **Input Format**: Expects standard UCSC `.chain` format files.
- **Output Format**: Produces a `.chain` file with records reordered.

### Expert Tips and Best Practices
- **Workflow Integration**: In a standard UCSC alignment pipeline, `chainSort` is typically used after `axtChain` (which creates the initial chains) and before `chainNet` (which requires sorted chains to identify the best orthologous alignments).
- **Memory Considerations**: `chainSort` generally loads the entire chain set into memory to perform the sort. For extremely large whole-genome alignments, ensure your environment has sufficient RAM.
- **Binary Execution**: If you have downloaded the binary directly from the UCSC server, ensure it has execution permissions:
  ```bash
  chmod +x chainSort
  ./chainSort in.chain out.chain
  ```
- **Verification**: You can verify the sort order by inspecting the first few lines of the output file; the `score` field (the second column in the header line of each chain block) should be in descending order.

## Reference documentation
- [Bioconda ucsc-chainsort Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chainsort_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)