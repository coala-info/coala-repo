---
name: ucsc-chainmergesort
description: The `ucsc-chainmergesort` tool merges multiple sorted pairwise alignment files in `.chain` format. Use when user asks to merge chain files, combine alignment chains, or sort and merge chain files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chainmergesort

## Overview
The `chainMergeSort` utility is a specialized tool from the UCSC Kent Utilities designed to merge multiple pairwise alignment files in the `.chain` format. It is a critical component of the UCSC alignment pipeline, typically used after initial alignments are generated in parallel chunks. The tool performs a merge sort, which is computationally efficient and preserves the internal sorting required by subsequent tools like `chainNet` or `chainPreNet`.

## CLI Usage and Best Practices

### Basic Command Pattern
The tool accepts a list of input chain files and outputs the merged result to standard output.

```bash
chainMergeSort file1.chain file2.chain file3.chain > merged.chain
```

### Handling Large Numbers of Files
If you have hundreds of individual chain files (common in whole-genome alignments), use wildcards or a file list:

```bash
chainMergeSort chunk_*.chain > all_chunks.merged.chain
```

### Input Requirements
*   **Pre-sorting**: `chainMergeSort` assumes that the input files are already individually sorted. If your input chains are unsorted, you must run `chainSort` on them first.
*   **Format**: The tool is strictly for `.chain` files. Do not use it for `.psl` or `.axt` files without first converting them to chain format.

### Expert Tips
*   **Memory Efficiency**: Because it uses a merge sort algorithm, `chainMergeSort` is highly memory-efficient even when handling very large datasets, as it does not need to load the entire dataset into RAM simultaneously.
*   **Pipeline Integration**: This tool is almost always followed by `chainPreNet`. You can pipe the output directly to save disk space:
    ```bash
    chainMergeSort *.chain | chainPreNet stdin target.sizes query.sizes stdout | chainNet stdin target.sizes query.sizes target.net query.net
    ```
*   **Validation**: After merging, it is good practice to verify the integrity of the output if it is being used for a `liftOver` file. A malformed merge will cause `liftOver` to fail or produce incorrect mappings.

## Reference documentation
- [ucsc-chainmergesort overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chainmergesort_overview.md)
- [UCSC Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)