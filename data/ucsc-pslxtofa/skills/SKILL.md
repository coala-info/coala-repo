---
name: ucsc-pslxtofa
description: The `pslxToFa` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to bridge the gap between alignment data and sequence retrieval.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-pslxtofa

## Overview
The `pslxToFa` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to bridge the gap between alignment data and sequence retrieval. While standard PSL files contain only alignment coordinates, the `pslx` format includes the actual sequence strings for the query and target. This tool parses those sequence fields and generates a standard FASTA file, which is essential for tasks like sequence reconstruction, motif analysis, or verifying alignment content without needing to refer back to the original source genomes.

## Command Line Usage

The basic syntax for the tool is:

```bash
pslxToFa input.pslx output.fa
```

### Requirements for Input
*   **Format**: The input must be a `pslx` file. A standard `psl` file (21 columns) does not contain sequence data and will not work with this tool.
*   **Column Count**: A valid `pslx` file typically contains 23 columns. The last two columns contain the query sequence and the target sequence.

### Common Workflow Patterns

1.  **Extracting Sequences from Blat Results**:
    If you ran `blat` with the `-out=pslx` flag, use this tool to convert those results directly to FASTA:
    ```bash
    blat target.2bit query.fa -out=pslx output.pslx
    pslxToFa output.pslx sequences_from_alignment.fa
    ```

2.  **Handling Permissions**:
    If using the standalone binary downloaded directly from the UCSC servers, ensure the file has execution permissions:
    ```bash
    chmod +x pslxToFa
    ./pslxToFa in.pslx out.fa
    ```

## Expert Tips and Best Practices
*   **Verification**: If you are unsure if your file is a standard PSL or a PSLX, check the column count. You can use `awk '{print NF; exit}' yourfile.psl`. If it returns 21, it is standard; if it returns 23, it is PSLX.
*   **Memory Efficiency**: Like most UCSC "kent" utilities, `pslxToFa` is optimized for speed and can handle very large alignment files efficiently.
*   **Downstream Compatibility**: The resulting FASTA file uses the sequence names provided in the PSLX file. Ensure your alignment names are unique to avoid duplicate headers in the FASTA output.
*   **Installation**: While available via Bioconda as `ucsc-pslxtofa`, the binary itself is often named `pslxToFa` in the environment.

## Reference documentation
- [ucsc-pslxtofa Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslxtofa_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)