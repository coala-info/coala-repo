---
name: ucsc-lavtopsl
description: The `lavToPsl` utility is a specialized conversion tool within the UCSC Kent Toolkit.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-lavtopsl

## Overview
The `lavToPsl` utility is a specialized conversion tool within the UCSC Kent Toolkit. It bridges the gap between the legacy `.lav` output format (commonly produced by the blastz and lastz aligners) and the standard `.psl` (Pattern Space Layout) format used by the UCSC Genome Browser. This conversion is essential for researchers who need to calculate alignment statistics, lift coordinates, or create custom tracks for genome visualization from raw blastz/lastz data.

## Usage Instructions

### Basic Command Pattern
The tool follows a standard input-output file pattern:
```bash
lavToPsl input.lav output.psl
```

### Common CLI Workflow
1.  **Permission Setup**: If using the binary directly from the UCSC download server, ensure it is executable:
    ```bash
    chmod +x lavToPsl
    ```
2.  **Batch Processing**: To convert multiple `.lav` files in a directory:
    ```bash
    for f in *.lav; do lavToPsl "$f" "${f%.lav}.psl"; done
    ```

### Expert Tips
*   **No Arguments for Help**: Running the command without any arguments will display the usage statement and any available optional flags (such as those for handling specific scoring schemas).
*   **PSL Validation**: After conversion, it is a best practice to run `pslCheck` on the output to ensure the resulting file is well-formed before attempting to upload it to the Genome Browser.
*   **Pipeline Integration**: `lavToPsl` is often the first step in a chain of tools. For example, you might follow it with `pslSort` and `pslCDnaFilter` to refine your alignment results.
*   **Architecture Matching**: Ensure you are using the binary that matches your system architecture (e.g., `linux.x86_64` vs `macOSX.arm64`).

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-lavtopsl_overview.md)