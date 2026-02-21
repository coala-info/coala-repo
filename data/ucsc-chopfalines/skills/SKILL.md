---
name: ucsc-chopfalines
description: `ucsc-chopfalines` (commonly executed as the command `chopFaLines`) is a specialized utility from the UCSC Genome Browser "kent" tool suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-chopfalines

## Overview
`ucsc-chopfalines` (commonly executed as the command `chopFaLines`) is a specialized utility from the UCSC Genome Browser "kent" tool suite. Its primary function is to take a FASTA file containing long, unwrapped sequence lines and rewrite it so that the sequences are broken into shorter, uniform lines of a specified width. This is a critical preprocessing step for many legacy bioinformatics applications that cannot handle extremely long sequence strings or for improving the human readability of genomic data.

## Command Line Usage

The tool follows a simple positional argument structure:

```bash
chopFaLines <lineLength> <input.fa> <output.fa>
```

### Common Patterns

*   **Standard Wrapping (60 characters):**
    Most NCBI and standard bioinformatics formats prefer 60-character widths.
    ```bash
    chopFaLines 60 long_lines.fa formatted.fa
    ```

*   **Legacy Compatibility (50 characters):**
    Some older tools require 50-character widths.
    ```bash
    chopFaLines 50 input.fa output.fa
    ```

*   **Readability (80 characters):**
    For modern terminal viewing or general documentation.
    ```bash
    chopFaLines 80 input.fa output.fa
    ```

## Expert Tips and Best Practices

*   **Binary Execution:** If you have downloaded the binary directly from the UCSC servers, ensure it has execution permissions:
    ```bash
    chmod +x ./chopFaLines
    ```
*   **Validation:** Always run `faSize` (another UCSC utility) before and after chopping to ensure the total base count remains identical and no data was lost during reformatting.
*   **Input Format:** The tool expects standard FASTA format. If your file has non-standard headers or hidden control characters, use `cat -v` to inspect the file before processing.
*   **Piping:** While many UCSC tools support `stdin` and `stdout` via the `stdin` or `stdout` keywords, `chopFaLines` typically requires explicit file paths. If you need to use it in a pipeline, check your specific version's help output by running the command with no arguments.
*   **Memory Efficiency:** This tool is highly efficient and can handle chromosome-scale FASTA files (like the human genome) with minimal memory overhead because it processes the file as a stream.

## Reference documentation
- [ucsc-chopfalines - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-chopfalines_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)