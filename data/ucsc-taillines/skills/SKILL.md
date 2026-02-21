---
name: ucsc-taillines
description: The `ucsc-taillines` utility is a high-performance command-line tool from the UCSC Genome Browser "kent" source tree.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-taillines

## Overview
The `ucsc-taillines` utility is a high-performance command-line tool from the UCSC Genome Browser "kent" source tree. While its primary purpose in the UCSC ecosystem is to extract the last N lines of a file (similar to the Unix `tail` command), it is optimized for the large-scale text files common in genomics. It provides a deterministic and lightweight way to sample data from the end of files or remove leading metadata by specifying line counts.

## Usage Instructions

### Getting Help
The most accurate usage information for your specific version can be found by running the binary with no arguments:
```bash
tailLines
```

### Basic Command Pattern
To extract the last N lines from a file:
```bash
tailLines [N] [filename]
```
*   **N**: The number of lines to extract from the end of the file.
*   **filename**: The path to the input text file.

### Common Workflow Patterns
1.  **Extracting the last 10 lines of a BED file**:
    ```bash
    tailLines 10 input.bed > output_tail.bed
    ```
2.  **Piping into other UCSC utilities**:
    `tailLines` is often used as a filter in a pipeline. For example, to see the last 5 alignments in a PSL file:
    ```bash
    tailLines 5 alignments.psl | pslCheck stdin
    ```

### Expert Tips
*   **Performance**: Unlike some versions of standard `tail`, the UCSC `tailLines` is built to handle the extremely long lines often found in genomic sequence files without crashing or memory overflow.
*   **Permissions**: If you encounter a "permission denied" error after downloading the binary, ensure it is executable:
    ```bash
    chmod +x ./tailLines
    ```
*   **Standard Input**: Many UCSC tools accept `stdin` as a filename. If `tailLines` supports this, you can use it at the end of a pipe:
    ```bash
    cat large_file.txt | tailLines 100 stdin
    ```

## Reference documentation
- [Bioconda ucsc-taillines Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-taillines_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)