---
name: ucsc-chainfilter
description: The `chainFilter` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to process `.chain` files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-chainfilter

## Overview
The `chainFilter` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to process `.chain` files. These files represent pairwise genomic alignments, often used to map coordinates between different genome assemblies. This skill provides guidance on using the command-line interface to filter these alignments, allowing researchers to remove low-quality mappings or isolate specific genomic regions of interest.

## Command Line Usage

The basic syntax for the tool is:
```bash
chainFilter [options] input.chain
```
By default, the filtered results are sent to `stdout`.

### Common Filtering Patterns

*   **Filter by Alignment Score:**
    Remove low-scoring alignments to increase the reliability of a liftover or comparative analysis.
    ```bash
    chainFilter -minScore=5000 input.chain > filtered.chain
    ```

*   **Isolate Specific Chromosomes:**
    Filter for alignments involving a specific target (`tName`) or query (`qName`) sequence.
    ```bash
    chainFilter -tName=chr1 -qName=chr1 input.chain > chr1_only.chain
    ```

*   **Filter by Alignment Dimensions:**
    Restrict results based on the span of the alignment on the target or query.
    ```bash
    chainFilter -tMinSize=1000 -qMinSize=1000 input.chain > long_alignments.chain
    ```

### Available Options

| Option | Description |
| :--- | :--- |
| `-minScore=N` | Minimum score to keep a chain. |
| `-tName=str` | Keep only chains where the target sequence name matches `str`. |
| `-qName=str` | Keep only chains where the query sequence name matches `str`. |
| `-tMinSize=N` | Minimum span on the target sequence. |
| `-qMinSize=N` | Minimum span on the query sequence. |
| `-tMaxSize=N` | Maximum span on the target sequence. |
| `-qMaxSize=N` | Maximum span on the query sequence. |
| `-strand=s` | Filter by query strand (usually `+` or `-`). |

## Best Practices

*   **Standard Output Redirection:** Since `chainFilter` writes to `stdout`, always remember to redirect the output to a file or pipe it into another tool (like `chainMergeSort` or `chainNet`) to avoid flooding the terminal.
*   **Permission Handling:** If using the binary directly from the UCSC download server, ensure it is executable: `chmod +x chainFilter`.
*   **Integration with Kent Tools:** `chainFilter` is often the first step in a pipeline. A common workflow involves filtering a raw `axtChain` output before running `chainNet` to create a reciprocal best alignment.
*   **Score Thresholds:** Alignment scores are dependent on the substitution matrix used during the initial alignment (e.g., `lastz`). Always check the distribution of scores in your input file before setting a `-minScore` threshold.

## Reference documentation
- [ucsc-chainfilter - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-chainfilter_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)