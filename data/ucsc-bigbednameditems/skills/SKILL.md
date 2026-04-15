---
name: ucsc-bigbednameditems
description: The ucsc-bigbednameditems tool extracts specific features from a bigBed file by their names. Use when user asks to extract specific features from a bigBed file by name, retrieve multiple features from a list of names, or query a bigBed file for named items.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bigbednameditems:482--h0b57e2e_0"
---

# ucsc-bigbednameditems

## Overview
The `bigBedNamedItems` utility is a specialized tool from the UCSC Genome Browser suite designed for efficient, name-based queries against bigBed files. While standard bigBed tools typically retrieve data based on genomic coordinates (chrom, start, end), this tool leverages the internal name index of a bigBed file to pull specific records. This is the most efficient method for fetching individual features—such as specific gene transcripts, SNPs, or regulatory elements—without needing to convert the entire binary file back to a text-based BED format.

## Command Line Usage

The basic syntax for the tool is:
```bash
bigBedNamedItems input.bb name output.bed
```

### Common Patterns

1.  **Single Item Extraction**:
    To extract a single feature by its name:
    ```bash
    bigBedNamedItems example.bb "MYC" result.bed
    ```

2.  **Batch Extraction**:
    If you have a list of names in a text file (one per line), you can use the `-nameFile` flag (standard in most versions of this utility):
    ```bash
    bigBedNamedItems -nameFile list_of_names.txt input.bb output.bed
    ```

### Expert Tips and Best Practices

*   **Index Requirement**: This tool requires the bigBed file to have been created with a name index. If the bigBed was built using `bedToBigBed` without the `-extraIndex=name` option, this tool will not be able to locate items by name.
*   **Performance**: Querying by name is significantly faster than converting a bigBed to BED and using `grep`, especially for files containing millions of features, as it uses a B+ tree index to jump directly to the data.
*   **Output Format**: The output is a standard tab-separated BED file containing only the records that matched the provided name(s).
*   **Permissions**: If running a freshly downloaded binary from the UCSC server, ensure you have execution permissions:
    ```bash
    chmod +x bigBedNamedItems
    ./bigBedNamedItems
    ```
*   **Remote Access**: The tool supports HTTPS and FTP URLs as input, allowing you to query remote files (like those hosted on the UCSC Genome Browser) without downloading the entire dataset:
    ```bash
    bigBedNamedItems https://path.to/data.bb "ItemName" output.bed
    ```

## Reference documentation
- [ucsc-bigbednameditems overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigbednameditems_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)