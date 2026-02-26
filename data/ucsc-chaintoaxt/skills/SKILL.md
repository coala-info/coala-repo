---
name: ucsc-chaintoaxt
description: `ucsc-chaintoaxt` converts alignment data from `.chain` format to `.axt` format. Use when user asks to convert alignment data from chain format to axt format.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chaintoaxt

## Overview
The `chainToAxt` utility is a specialized tool from the UCSC Genome Browser "kent" source suite. It facilitates the conversion of alignment data from the hierarchical, gap-compressed `.chain` format into the more explicit, block-based `.axt` format. This conversion is essential when working with comparative genomics workflows where the target application requires the specific coordinate and sequence representation provided by AXT, which includes the actual aligned sequences for both the target and query.

## Usage Patterns

### Basic Command Structure
The tool requires the input chain file, the target sequence, the query sequence, and the output filename.

```bash
chainToAxt input.chain target.2bit query.2bit output.axt
```

### Key Requirements
*   **Sequence Files**: The target and query sequences are typically provided in `.2bit` format for efficient random access. You can also use `.nib` files if working with older assemblies.
*   **Coordinate Systems**: Ensure that the sequence files correspond exactly to the assembly versions used to generate the original chain file.

### Expert Tips
*   **Memory Efficiency**: When processing very large chain files, ensure your sequence files are indexed (like `.2bit`) rather than raw FASTA to prevent excessive memory consumption.
*   **Permissions**: If you have just downloaded the binary from the UCSC servers, you must grant execution permissions before use:
    ```bash
    chmod +x chainToAxt
    ```
*   **Help Statement**: To see specific version information or additional flags (if available in your specific build), run the command with no arguments:
    ```bash
    ./chainToAxt
    ```

## Reference documentation
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-chaintoaxt Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chaintoaxt_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)