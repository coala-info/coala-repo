---
name: ucsc-hgvstovcf
description: The `ucsc-hgvstovcf` tool (internally executed as `hgvsToVcf`) is a specialized utility from the UCSC Genome Browser "kent" suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hgvstovcf

# ucsc-hgvstovcf

## Overview
The `ucsc-hgvstovcf` tool (internally executed as `hgvsToVcf`) is a specialized utility from the UCSC Genome Browser "kent" suite. It provides a bridge between the HGVS nomenclature, which is commonly used in clinical reporting and biological research, and the VCF format required for most high-throughput sequencing analysis tools. It is particularly effective for batch-processing variant lists and resolving coordinates against specific reference assemblies like hg19 or hg38.

## Usage Instructions

### Basic Command Structure
The tool typically requires a target database (reference assembly) and input/output specifications.

```bash
hgvsToVcf db hgvsInput vcfOutput
```

*   **db**: The UCSC assembly name (e.g., `hg19`, `hg38`).
*   **hgvsInput**: A file containing HGVS terms (one per line) or a single HGVS string.
*   **vcfOutput**: The filename for the resulting VCF data.

### Common CLI Patterns
1.  **Batch Processing**:
    To convert a list of variants stored in a text file:
    ```bash
    hgvsToVcf hg38 my_variants.txt results.vcf
    ```

2.  **Viewing Help**:
    UCSC tools are self-documenting. If you are unsure of specific flags or supported HGVS types (genomic vs. coding vs. protein), run the binary without arguments:
    ```bash
    hgvsToVcf
    ```

### Best Practices and Expert Tips
*   **Assembly Consistency**: Ensure the `db` argument matches the assembly used to generate the HGVS terms. Using `hg19` for `hg38` terms will result in coordinate errors or failed lookups.
*   **Permissions**: If you have downloaded the binary directly from the UCSC server rather than using Conda, you must set execution permissions:
    ```bash
    chmod +x hgvsToVcf
    ```
*   **Database Access**: Some versions of this tool may attempt to connect to the UCSC public MySQL server to resolve transcripts. If you are working behind a firewall, ensure port 3306 is open or check if the tool supports local metadata files.
*   **Input Formatting**: Ensure there are no trailing spaces in your HGVS input file, as the parser can be sensitive to whitespace.

## Reference documentation
- [ucsc-hgvstovcf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-hgvstovcf_overview.md)
- [UCSC Admin Executable Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)