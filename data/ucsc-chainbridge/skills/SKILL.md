---
name: ucsc-chainbridge
description: The `ucsc-chainbridge` tool refines genomic alignments by identifying and closing double-sided gaps to extend alignment blocks. Use when user asks to stitch together alignment fragments, refine genomic alignments, or maximize alignment coverage and continuity.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-chainbridge

## Overview
The `ucsc-chainbridge` tool is a specialized utility from the UCSC Genome Browser "Kent" source tree designed to refine genomic alignments. Its primary function is to identify and close "double-sided gaps"—instances where both the target and query sequences have gaps of approximately the same length—thereby extending the alignment blocks. This is particularly useful in comparative genomics workflows where maximizing alignment coverage and continuity is required after initial chain generation.

## Command Line Usage
The tool operates on standard UCSC chain format files. While specific flags are often discovered via the binary's help output, the standard execution pattern follows this structure:

```bash
chainBridge input.chain output.chain
```

### Common Patterns
- **Standard Refinement**: Run `chainBridge` after `axtChain` or `blat` to stitch together alignment fragments that are separated by small, balanced gaps.
- **Pipeline Integration**: It is typically used as an intermediate step before `chainNet` to ensure the highest quality chains are passed into the netting process.

## Expert Tips and Best Practices
- **Gap Symmetry**: This tool is most effective when the gaps in the target and query are of similar size. If gaps are highly asymmetrical (e.g., a large insertion in one sequence but not the other), `chainBridge` will likely leave them as separate blocks to maintain alignment integrity.
- **Binary Permissions**: If installing manually from the UCSC servers rather than via Conda, ensure the binary is executable using `chmod +x chainBridge`.
- **MySQL Configuration**: While `chainBridge` primarily processes local files, other UCSC utilities in the same suite may require an `.hg.conf` file in your home directory to connect to public genomic databases.
- **Architecture Matching**: Ensure you download the version matching your system architecture (e.g., `linux.x86_64` or `macOSX.arm64`) to avoid "cannot execute binary file" errors.

## Reference documentation
- [ucsc-chainbridge - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-chainbridge_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)