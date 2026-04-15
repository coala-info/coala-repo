---
name: ucsc-ratolines
description: The ucsc-ratolines tool converts multi-line .ra file stanzas into single pipe-separated lines. Use when user asks to filter records in .ra files, extract specific fields from .ra files, or flatten .ra file stanzas.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-ratolines:482--h0b57e2e_0"
---

# ucsc-ratolines

## Overview
The `ucsc-ratolines` tool (internally known as `raToLines`) is a specialized utility from the UCSC Kent toolset designed to transform the structure of `.ra` files. In their native format, `.ra` files consist of stanzas where each attribute is on a new line and records are separated by blank lines. This tool collapses each stanza into a single line of text, using a pipe (`|`) character to separate the original fields. This is particularly useful for bioinformaticians working with UCSC Genome Browser metadata, such as `trackDb.ra` or `hub.txt` files, where record-level filtering is required.

## Usage Patterns and Best Practices

### Basic Command Structure
The tool typically reads from a file and outputs the flattened records to standard output.

```bash
raToLines input.ra > flattened_output.txt
```

### Common CLI Workflows
Because the output is line-oriented, it is ideal for piping into other utilities:

1.  **Filtering Records**: To find all stanzas containing a specific attribute (e.g., a specific track type) and see the entire record on one line:
    ```bash
    raToLines trackDb.ra | grep "type bigWig"
    ```

2.  **Extracting Specific Fields**: Use `cut` with the pipe delimiter to isolate specific columns after flattening:
    ```bash
    raToLines input.ra | cut -d'|' -f1,2
    ```

3.  **Processing via Stdin**: Like most UCSC Kent utilities, you can pipe data into it by using `stdin` as the filename:
    ```bash
    cat metadata.ra | raToLines stdin
    ```

### Expert Tips
*   **Record Separation**: Remember that `raToLines` relies on blank lines to identify the end of one stanza and the start of the next. Ensure your input `.ra` file is properly formatted with at least one empty line between records.
*   **Permissions**: If you have downloaded the binary directly from the UCSC server rather than installing via Bioconda, you must grant execution permissions: `chmod +x raToLines`.
*   **Database Connectivity**: While `raToLines` is a text-processing utility, other tools in this suite may require a `.hg.conf` file in your home directory to connect to the UCSC public MySQL server. For simple file conversion with `raToLines`, this is generally not necessary.

## Reference documentation
- [UCSC Genome Browser Admin Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-ratolines Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-ratolines_overview.md)
- [UCSC Linux x86_64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)