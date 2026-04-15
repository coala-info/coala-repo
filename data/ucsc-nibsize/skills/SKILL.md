---
name: ucsc-nibsize
description: The ucsc-nibsize tool reports the size and nucleotide composition of UCSC .nib files. Use when user asks to 'get the size of a nib file', 'count nucleotides in a nib file', or 'create chromosome size files from nib files'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-nibsize:482--h0b57e2e_0"
---

# ucsc-nibsize

## Overview
The `nibSize` utility is a specialized tool from the UCSC Genome Browser "kent" source suite. It is designed specifically to read `.nib` files—a binary format used by UCSC to store DNA sequences where each byte represents two nucleotides. This tool is essential for bioinformaticians working with legacy UCSC data pipelines or custom genome builds that utilize the nib format instead of the more common 2bit or FASTA formats.

## Usage Patterns

### Basic Command
To get the size of a nib file, run the command with the path to the file:
```bash
nibSize sequence.nib
```

### Interpreting Output
The tool typically returns the following information:
1. **File Name**: The path to the file being queried.
2. **Total Bases**: The total number of nucleotides in the file.
3. **N Count**: The number of unknown or masked bases (N's).
4. **A, C, G, T Counts**: The frequency of each specific nucleotide.

### Batch Processing
Since `nibSize` is a lightweight binary, it is often used in shell loops to generate a chromosome size file for a directory of nib files:
```bash
for f in *.nib; do
    echo -n "$f "
    nibSize "$f" | awk '{print $2}'
done
```

## Expert Tips
*   **Format Specificity**: Ensure you are using this on `.nib` files. For `.2bit` files, use `twoBitInfo` instead.
*   **Permissions**: If you have downloaded the binary directly from the UCSC server, you must grant execution permissions before use: `chmod +x nibSize`.
*   **Database Connection**: Unlike some other UCSC utilities (like `hgsql`), `nibSize` operates entirely on local files and does not require an `.hg.conf` file or a connection to the UCSC MySQL server.
*   **Binary Availability**: This tool is available for multiple architectures including Linux (x86_64, aarch64) and macOS (Intel and Apple Silicon). Always ensure the binary version matches your system architecture.

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda ucsc-nibsize Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-nibsize_overview.md)