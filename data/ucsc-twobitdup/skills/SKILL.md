---
name: ucsc-twobitdup
description: The `ucsc-twobitdup` tool (often referred to as `twoBitDup` in the Kent source suite) is a specialized utility designed to scan .2bit files for redundant genomic sequences.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-twobitdup

## Overview
The `ucsc-twobitdup` tool (often referred to as `twoBitDup` in the Kent source suite) is a specialized utility designed to scan .2bit files for redundant genomic sequences. A .2bit file is a highly compressed binary format used by the UCSC Genome Browser to store DNA sequences. This tool identifies if any two sequences (such as scaffolds or chromosomes) within the file are bit-for-bit identical, which is a common requirement for validating new genome assemblies or troubleshooting mapping issues caused by redundant references.

## Usage and Best Practices

### Basic Command Line Usage
The tool is straightforward and typically requires only the input file as an argument.

```bash
twoBitDup input.2bit
```

### Common Workflow Patterns
1.  **Assembly Validation**: Run this tool immediately after converting a FASTA file to .2bit (using `faToTwoBit`) to ensure the assembly does not contain duplicate scaffolds that could confound downstream analysis.
2.  **Permission Handling**: If you have downloaded the binary directly from the UCSC servers rather than via a package manager, ensure it has execution permissions:
    ```bash
    chmod +x twoBitDup
    ./twoBitDup input.2bit
    ```
3.  **Viewing Help**: Like most UCSC Kent utilities, running the command without any arguments will display the version and any available optional flags.

### Expert Tips
*   **Input Format**: Ensure your sequence data is in the `.2bit` format. If you have a FASTA file, you must first convert it using `faToTwoBit`.
*   **Output Interpretation**: If the tool finds duplicates, it will list the names of the identical sequences. If no output is produced, no identical sequences were detected.
*   **Integration**: This tool is best used as a "gatekeeper" step in automated pipelines before performing large-scale alignments or database indexing.

## Reference documentation
- [ucsc-twobitdup Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-twobitdup_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)