---
name: ucsc-qactoqa
description: The `qacToQa` utility is a specialized tool from the UCSC Genome Browser "kent" source tree.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-qactoqa

## Overview
The `qacToQa` utility is a specialized tool from the UCSC Genome Browser "kent" source tree. It serves as the decompression bridge for sequence quality data. In bioinformatics workflows involving the UCSC toolset, quality scores are often stored in `.qac` (Quality Assurance Compressed) files to save disk space. This skill allows you to revert those files to the human-readable or downstream-compatible `.qa` format for analysis, troubleshooting, or integration with other sequence processing pipelines.

## Usage Patterns

### Basic Conversion
The primary use case is converting a single compressed file back to its original state.
```bash
qacToQa input.qac output.qa
```

### Viewing Usage and Versioning
Since this tool is part of the UCSC binary suite, running it without arguments provides the built-in help text.
```bash
qacToQa
```

### Integration in Pipelines
When processing large batches of genomic data, `qacToQa` is typically used after initial quality assessment steps that produced compressed outputs.
1. **Identify target files**: Locate `.qac` files in your assembly or track data directories.
2. **Decompress**: Run `qacToQa` to generate the text-based `.qa` files.
3. **Analyze**: Use standard Unix tools (grep, awk, etc.) or custom scripts on the resulting `.qa` file to inspect quality metrics.

## Expert Tips
*   **Permissions**: If you have just downloaded the binary from the UCSC servers, ensure it is executable using `chmod +x qacToQa`.
*   **Binary Compatibility**: Ensure you are using the version corresponding to your architecture (e.g., `linux.x86_64` vs `macOSX.arm64`).
*   **Complementary Tools**: This tool is the inverse of `qaToQac`. If you need to save space after your analysis, use `qaToQac` to re-compress the data.
*   **Database Connectivity**: While `qacToQa` is a standalone file converter, many related UCSC tools require an `.hg.conf` file in your home directory to connect to the public MySQL server (genome-mysql.soe.ucsc.edu).

## Reference documentation
- [UCSC Genome Browser Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-qactoqa Package Details](./references/anaconda_org_channels_bioconda_packages_ucsc-qactoqa_overview.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)