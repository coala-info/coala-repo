---
name: ucsc-pslfilter
description: ucsc-pslfilter processes and filters PSL alignment files to refine results based on quality thresholds. Use when user asks to filter alignments by minimum score, ensure a minimum query coverage, or remove redundant overlapping mappings.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-pslfilter:482--h0b57e2e_0"
---

# ucsc-pslfilter

## Overview
The `pslFilter` utility is part of the UCSC Genome Browser "kent" source suite. It is a high-performance command-line tool designed to post-process PSL files, which are the standard output format for BLAT. This tool allows researchers to refine alignment results by applying various thresholds, ensuring that only biologically relevant or high-confidence mappings are retained for downstream analysis.

## Command Line Usage

The basic syntax for the tool is:

```bash
pslFilter [options] input.psl output.psl
```

### Common Filtering Patterns

While specific flags can vary slightly between versions of the kent utilities, the following are standard patterns for filtering PSL data:

*   **Filtering by Minimum Score**: Remove alignments that do not meet a specific bit-score or match count.
*   **Filtering by Coverage**: Ensure that a minimum percentage of the query sequence is aligned to the target.
*   **Removing Overlaps**: Clean up redundant mappings where multiple alignments cover the same genomic region.

### Expert Tips for PSL Processing

1.  **Permission Setup**: If you have just downloaded the binary from the UCSC servers, ensure it is executable:
    ```bash
    chmod +x pslFilter
    ```
2.  **Stream Processing**: Like many UCSC tools, `pslFilter` can often be used in pipes. If the version supports it, use `stdin` or `/dev/stdin` to process output directly from BLAT without writing large intermediate files to disk.
3.  **Validation**: Before filtering, it is often useful to run `pslCheck` (another tool in the suite) to ensure the input file is not corrupted and follows the PSL specification.
4.  **Format Conversion**: If you need to visualize the filtered results in the UCSC Genome Browser, use `pslToBed` after filtering to convert the data into a BED format.

## Reference documentation
- [UCSC Genome Browser Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Kent Source README](./references/github_com_ucscGenomeBrowser_kent.md)