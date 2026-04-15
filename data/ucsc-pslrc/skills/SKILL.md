---
name: ucsc-pslrc
description: The `ucsc-pslrc` tool transforms PSL alignment files by reverse-complementing the query sequences. Use when user asks to 'reverse-complement query sequences in PSL files', 'recalculate coordinates in PSL files', or 'recalculate strand information in PSL files'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-pslrc:482--h0b57e2e_0"
---

# ucsc-pslrc

## Overview
The `ucsc-pslrc` skill provides guidance for using the UCSC `pslRc` utility, a specialized tool within the Kent Utilities suite. Its primary function is to transform PSL alignment files by reverse-complementing the query sequences. This ensures that coordinates and strand information are correctly recalculated for downstream analysis, such as when working with sequences derived from the negative strand of a genome.

## Usage Instructions

### Basic Command Syntax
The tool follows a standard input/output pattern. If no arguments are provided, the tool typically prints its usage statement.

```bash
pslRc input.psl output.psl
```

### Common Workflow Patterns

**1. Processing Compressed Files**
Since PSL files can be quite large, they are often stored in a compressed format. You can use standard Unix pipes to process them without manual decompression:
```bash
zcat input.psl.gz | pslRc stdin output.psl
```

**2. Batch Processing**
To process multiple PSL files in a directory:
```bash
for f in *.psl; do pslRc "$f" "${f%.psl}.rc.psl"; done
```

### Expert Tips and Best Practices

*   **Coordinate Systems:** PSL files use a 0-indexed, half-open coordinate system. `pslRc` is designed to handle the complex coordinate shifts required when flipping a sequence, which is more reliable than attempting to use generic text-processing tools (like `awk`) for this task.
*   **Validation:** After running `pslRc`, it is best practice to validate the output using `pslCheck` (another UCSC utility) to ensure the resulting file maintains structural integrity.
*   **Strand Orientation:** Remember that `pslRc` primarily affects the query sequence orientation. If you are trying to align sequences to a genome, ensure you understand whether your specific analysis requires the query, the target, or both to be reoriented.
*   **Permissions:** If you have downloaded the binary directly from the UCSC servers rather than via Conda, ensure the execution bit is set: `chmod +x pslRc`.

## Reference documentation
- [ucsc-pslrc Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslrc_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)