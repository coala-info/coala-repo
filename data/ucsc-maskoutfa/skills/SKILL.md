---
name: ucsc-maskoutfa
description: The `ucsc-maskoutfa` tool (commonly executed as `maskOutFa`) is a high-performance utility from the UCSC Genome Browser "kent" source tree.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-maskoutfa

## Overview
The `ucsc-maskoutfa` tool (commonly executed as `maskOutFa`) is a high-performance utility from the UCSC Genome Browser "kent" source tree. It allows researchers to apply masking to genomic sequences. Masking is typically used to prevent non-specific alignments by converting repetitive elements—identified by tools like RepeatMasker—into lowercase letters (soft-masking) or 'N' characters (hard-masking).

## Usage Patterns

### Basic Command Syntax
The tool generally follows a positional argument structure. To view the specific help message and version-specific options, run the binary without arguments:

```bash
maskOutFa input.fa maskingSource output.fa
```

### Common Masking Sources
*   **.out files**: Standard output from RepeatMasker.
*   **.bed files**: Genomic coordinates defining regions to be masked.

### Best Practices
*   **Soft-masking vs. Hard-masking**: By default, UCSC tools often perform soft-masking (converting to lowercase). Check for flags like `-hard` if your downstream analysis requires 'N' characters.
*   **Permissions**: If you have downloaded the binary directly from the UCSC server, ensure it is executable:
    ```bash
    chmod +x maskOutFa
    ```
*   **Environment**: If installed via Bioconda, the tool is available in the path as `maskOutFa`. If using the UCSC binary downloads, ensure you have the correct version for your architecture (e.g., `linux.x86_64` or `macOSX.arm64`).

### Expert Tips
*   **Input Validation**: Use `faSize` (another UCSC utility) before and after masking to verify that the number of bases remains the same and to check the percentage of the genome that has been masked.
*   **Large Genomes**: This tool is optimized for speed and can handle chromosome-scale FASTA files efficiently. Ensure you have sufficient disk space for the output file, as it will be approximately the same size as the input.

## Reference documentation
- [Bioconda ucsc-maskoutfa Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-maskoutfa_overview.md)
- [UCSC Binary Downloads (Linux x86_64)](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Executable Instructions](./references/hgdownload_cse_ucsc_edu_admin_exe.md)