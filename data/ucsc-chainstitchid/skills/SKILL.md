---
name: ucsc-chainstitchid
description: The ucsc-chainstitchid tool stitches together fragmented alignment records in .chain files. Use when user asks to consolidate fragmented alignment chains, prepare chain files for chainNet, or ensure unique chain IDs after merging alignments.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-chainstitchid:482--h0b57e2e_0"
---

# ucsc-chainstitchid

## Overview
The `chainStitchId` utility is a specialized tool within the UCSC Kent genome processing suite. Its primary function is to resolve fragmentation in `.chain` files. During large-scale genome alignments, a single logical alignment (represented by a unique ID) may be split into multiple fragments due to parallel processing or merging steps. `chainStitchId` scans the input file and "stitches" these fragments back together into a single continuous record per ID. This ensures that downstream analysis tools see a unified alignment rather than disconnected pieces.

## Usage Instructions

### Basic Command Line
The tool follows the standard UCSC utility pattern of taking an input file and an output file as positional arguments:

```bash
chainStitchId input.chain output.chain
```

### Common Workflow Integration
In a standard comparative genomics pipeline (such as generating liftover files), `chainStitchId` is almost always used after `chainMergeSort`.

1. **Merge and Sort**: Combine multiple chain files and sort them by score/position.
   ```bash
   chainMergeSort file1.chain file2.chain > merged.chain
   ```
2. **Stitch IDs**: Consolidate fragments sharing IDs.
   ```bash
   chainStitchId merged.chain stitched.chain
   ```
3. **Generate Nets**: Proceed to netting.
   ```bash
   chainNet stitched.chain target.sizes query.sizes target.net query.net
   ```

## Expert Tips and Best Practices

### When to Use
* **Post-Parallelization**: If you split your genome into chunks for alignment (e.g., using `blat` or `lastz`) and then merged the results, you must run `chainStitchId` to ensure IDs are unique and records are contiguous.
* **Requirement for chainNet**: The `chainNet` tool often requires that chain IDs be unique. If your pipeline produces duplicate IDs for fragments of the same alignment, `chainNet` may fail or produce incorrect results unless you stitch them first.

### Data Integrity
* **Input Sorting**: While `chainStitchId` is robust, it is best practice to provide a sorted chain file (via `chainMergeSort` or `chainSort`) to ensure the stitching process is efficient and logically sound.
* **File Permissions**: If you encounter a "permission denied" error when running the binary downloaded from UCSC, ensure the execution bit is set: `chmod +x chainStitchId`.

### Troubleshooting
* **Empty Output**: If the output file is empty or identical to the input, it usually indicates that no duplicate IDs were found or that the fragments sharing IDs were not in a state that allowed for stitching (e.g., overlapping in a way that violates chain format logic).
* **Memory Usage**: For extremely large whole-genome alignments, ensure your environment has sufficient memory, as the tool may need to track many IDs simultaneously during the stitching process.

## Reference documentation
- [UCSC Genome Browser Binary Downloads](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-chainstitchid Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chainstitchid_overview.md)
- [UCSC Linux x86_64 Utilities Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)