---
name: ucsc-fatotab
description: The ucsc-fatotab tool converts biological sequences from FASTA format into a simple two-column table. Use when user asks to convert FASTA to a tab-separated table, transform FASTA sequences into a two-column format, or parse sequence data as structured text.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fatotab:482--h0b57e2e_0"
---

# ucsc-fatotab

## Overview
The `ucsc-fatotab` skill provides instructions for using the `faToTab` utility, a specialized tool from the UCSC Genome Browser "kent" suite. Its primary function is to transform biological sequences from the FASTA format into a simple two-column table. This conversion is a critical step in bioinformatics pipelines when sequence data needs to be parsed as structured text rather than multi-line blocks.

## Usage Instructions

### Basic Command Line Pattern
The tool follows a straightforward input-output syntax:

```bash
faToTab input.fa output.tab
```

### Common CLI Options
While the tool is simple, the following flags are standard for UCSC FASTA utilities to control output quality:

*   **-keepCase**: By default, many UCSC tools may normalize sequence case. Use this to preserve the original upper/lower case masking found in the input FASTA.
*   **-type=[dna|rna|protein]**: Explicitly define the sequence type if the tool fails to auto-detect it.

### Expert Tips and Best Practices
1.  **Handling Large Genomes**: `faToTab` is highly efficient. When working with whole-genome files, it is often faster to convert to tab format first and then use `grep` to find specific headers than to use complex FASTA parsers.
2.  **Integration with Unix Pipes**: Since the output is tab-separated, you can immediately pipe the results into other tools. For example, to count the length of every sequence:
    ```bash
    faToTab input.fa stdout | awk '{print $1, length($2)}'
    ```
3.  **Permissions**: If you have downloaded the binary directly from the UCSC servers (as noted in the reference documentation), ensure the execution bit is set:
    ```bash
    chmod +x faToTab
    ```
4.  **Input Validation**: Ensure your FASTA headers do not contain internal tabs, as this will break the two-column structure of the output file.

## Reference documentation
- [Bioconda ucsc-fatotab Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fatotab_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)