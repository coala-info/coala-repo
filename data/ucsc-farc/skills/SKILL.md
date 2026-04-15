---
name: ucsc-farc
description: The ucsc-farc tool generates the reverse complement of DNA sequences in FASTA format. Use when user asks to 'reverse complement DNA sequences'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-farc:482--h0b57e2e_0"
---

# ucsc-farc

## Overview
The `faRc` (ucsc-farc) utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed for a single, high-performance task: generating the reverse complement of DNA sequences stored in FASTA format. It is particularly useful in genomic pipelines where sequence orientation needs to be flipped to match a specific strand or reference orientation.

## Usage Patterns

### Basic Reverse Complement
To reverse complement an entire FASTA file and save the output:
```bash
faRc input.fa output.fa
```

### Common CLI Workflow
1.  **Installation**: Usually available via Bioconda as `ucsc-farc`.
2.  **Execution**: The tool reads the input FASTA, calculates the complement of each base (A↔T, C↔G), reverses the string order, and writes to the output file.
3.  **Permissions**: If using the standalone binary downloaded from UCSC, ensure it is executable:
    ```bash
    chmod +x faRc
    ./faRc input.fa output.fa
    ```

## Best Practices
-   **File Extensions**: While the tool is named `faRc` (FASTA Reverse Complement), it handles standard `.fa` and `.fasta` files.
-   **Validation**: Use `faSize` (another UCSC utility) before and after processing to ensure sequence lengths remain identical, as reverse complementing should not change the base count.
-   **Batch Processing**: For multiple files, use a simple shell loop:
    ```bash
    for f in *.fa; do faRc "$f" "${f%.fa}_rc.fa"; done
    ```
-   **Memory Efficiency**: Like most UCSC kent utilities, `faRc` is optimized for speed and can handle large genomic files efficiently.

## Reference documentation
- [Bioconda ucsc-farc Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-farc_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)