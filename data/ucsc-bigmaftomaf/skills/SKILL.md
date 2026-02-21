---
name: ucsc-bigmaftomaf
description: The `ucsc-bigmaftomaf` skill facilitates the restoration of genomic alignments from the compressed, indexed bigMaf format into the human-readable Multiple Alignment Format (MAF).
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-bigmaftomaf

## Overview
The `ucsc-bigmaftomaf` skill facilitates the restoration of genomic alignments from the compressed, indexed bigMaf format into the human-readable Multiple Alignment Format (MAF). bigMaf files are typically used within the UCSC Genome Browser for efficient visualization of large-scale multiple species alignments, but many command-line analysis tools require the original MAF text format. This tool performs a deterministic conversion to recover that data.

## Usage Instructions

### Basic Conversion
The primary use case is a direct conversion of a bigMaf file to a MAF file.
```bash
bigMafToMaf input.bigMaf output.maf
```

### Common Patterns and Best Practices
*   **Permissions**: Since these are often downloaded as standalone binaries from the UCSC Kent suite, ensure the execution bit is set:
    ```bash
    chmod +x bigMafToMaf
    ./bigMafToMaf input.bigMaf output.maf
    ```
*   **Environment**: The tool is part of the UCSC Kent Utilities. If installed via Bioconda, it will be available in your PATH. If downloaded manually, you may need to reference the specific path to the binary.
*   **Large Files**: MAF files are text-heavy and can become extremely large. Ensure you have sufficient disk space before converting large bigMaf tracks (e.g., 100-way alignments).
*   **Verification**: You can verify the conversion by checking the first few lines of the output, which should start with the MAF header `##maf version=1`.

### Expert Tips
*   **Binary Compatibility**: Ensure you are using the version of the tool that matches your architecture (e.g., `linux.x86_64` vs `macOSX.arm64`). The UCSC repository provides specific builds for different kernels.
*   **Integration**: This tool is often the final step in a pipeline where genomic regions were first extracted using `bigBedToBed` (since bigMaf is a specialized BigBed format) and then need to be restored to alignment format for tools like `phastCons` or `basewise`.

## Reference documentation
- [ucsc-bigmaftomaf overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_ucsc-bigmaftomaf_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)