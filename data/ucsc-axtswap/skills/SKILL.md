---
name: ucsc-axtswap
description: The `axtSwap` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to manipulate AXT alignment files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-axtswap

## Overview
The `axtSwap` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to manipulate AXT alignment files. In a standard AXT file, the first sequence is considered the "target" (source) and the second is the "query." This tool reorients the alignment so that the original query becomes the target and vice versa. This is a critical step in comparative genomics workflows, particularly when generating reciprocal best alignments or when integrating alignments into a database where the coordinate system must match a specific assembly.

## Usage Patterns

### Basic Swapping
To swap the target and query in an AXT file, use the following syntax:

```bash
axtSwap input.axt output.axt
```

### Handling Large Datasets
When working with whole-genome alignments, AXT files can become extremely large. It is common practice to pipe the output to a sorting utility, as swapping the sequences often breaks the coordinate-based ordering required by downstream UCSC tools.

```bash
axtSwap input.axt stdout | axtSort stdin output.sorted.axt
```

## Expert Tips and Best Practices

### Coordinate System Awareness
*   **Orientation:** `axtSwap` automatically handles the strand orientation. If the original query was on the minus strand relative to the target, the new query (the original target) will be adjusted accordingly to maintain the biological integrity of the alignment.
*   **Sorting Requirement:** Most UCSC tools (like `axtChain` or `axtToMaf`) expect AXT files to be sorted by the target chromosome and then by the target start position. Always run `axtSort` after `axtSwap` if you plan to perform further processing.

### Integration with Other UCSC Tools
*   **Reciprocal Best Hits:** `axtSwap` is a prerequisite for finding reciprocal best alignments. The workflow typically involves:
    1.  `axtBest` on the original alignment.
    2.  `axtSwap` the result.
    3.  `axtSort` the swapped file.
    4.  `axtBest` again on the swapped/sorted file.
*   **Format Conversion:** If you need the final output in MAF or PSL format, perform the swap while the data is still in AXT format, as `axtSwap` is more efficient than swapping coordinates in other formats.

### Troubleshooting "Permission Denied"
If you have downloaded the binary directly from the UCSC server, ensure it has execution permissions:
```bash
chmod +x axtSwap
```

## Reference documentation
- [ucsc-axtswap - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-axtswap_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)