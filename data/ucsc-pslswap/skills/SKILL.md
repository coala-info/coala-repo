---
name: ucsc-pslswap
description: The `ucsc-pslswap` tool is a utility from the UCSC Genome Browser "kent" source suite designed to transpose the target and query fields within a PSL file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-pslswap

## Overview
The `ucsc-pslswap` tool is a utility from the UCSC Genome Browser "kent" source suite designed to transpose the target and query fields within a PSL file. In a standard PSL file, the "target" is typically the reference genome and the "query" is the sequence aligned to it (like an EST or mRNA). Swapping these fields is a common requirement in bioinformatics pipelines when the relationship between the two sequences needs to be inverted for specific tools that expect a particular sequence type in the target position.

## Usage Instructions

### Basic Command Pattern
The tool follows a straightforward input-output positional argument structure:

```bash
pslSwap input.psl output.psl
```

### Expert Tips and Best Practices
1.  **Binary Execution**: If installed via Bioconda, the tool is available as `pslSwap`. If downloaded directly from the UCSC servers, ensure the binary has execution permissions:
    ```bash
    chmod +x pslSwap
    ./pslSwap input.psl output.psl
    ```
2.  **Header Handling**: PSL files sometimes contain a header (the first 5 lines starting with `psLayout version`). `pslSwap` is designed to handle standard PSL formats, but always verify the output if your input file has non-standard headers or comments.
3.  **Coordinate Systems**: Note that swapping target and query also swaps their respective coordinate systems, strand information, and block offsets. The tool handles these transformations automatically to maintain the integrity of the alignment.
4.  **Validation**: After swapping, it is recommended to use `pslCheck` (another UCSC utility) to ensure the resulting file is still a valid PSL format.
5.  **Piping**: While UCSC tools often support `stdin` and `stdout`, `pslSwap` typically expects explicit file paths. To use it in a pipe, check your specific version's support for `/dev/stdin` or `/dev/stdout`.

## Reference documentation
- [ucsc-pslswap - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-pslswap_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)