---
name: ucsc-bigbedtobed
description: The `bigBedToBed` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to reverse the bigBed creation process.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bigbedtobed

## Overview
The `bigBedToBed` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to reverse the bigBed creation process. While bigBed files are optimized for high-performance visualization and remote access, they are binary and cannot be read by standard text editors or tools like `awk` and `grep`. This skill provides the procedural knowledge to decompress these files back into standard tab-delimited BED format, including support for coordinate-based sub-setting and remote file handling.

## Command Line Usage

The basic syntax for the tool is:
`bigBedToBed input.bb output.bed`

### Common Patterns and Options

*   **Extract Specific Regions**: To avoid converting a massive file when you only need a specific locus, use coordinate flags:
    `bigBedToBed -chrom=chr1 -start=1000 -end=5000 input.bb output.bed`
*   **Include Column Headers**: If the bigBed file contains an autoSql schema or specific field names, use the header flag to make the output more interpretable:
    `bigBedToBed -header input.bb output.bed`
*   **Remote Access**: The tool natively supports HTTP, HTTPS, and FTP URLs. You do not need to download the file first:
    `bigBedToBed https://path.to/data/file.bb output.bed`

## Expert Tips and Best Practices

*   **Permission Errors**: If using the standalone binary downloaded from the UCSC server, ensure it is executable:
    `chmod +x bigBedToBed`
*   **Memory Efficiency**: `bigBedToBed` is highly memory-efficient because it uses the internal B+ tree index of the bigBed file to fetch only the required data blocks. When working with large datasets, always prefer using the `-chrom`, `-start`, and `-end` flags to minimize I/O.
*   **Pipe Integration**: While the tool requires an output filename, you can often use `/dev/stdout` on Unix-like systems to pipe the results directly into another tool:
    `bigBedToBed input.bb /dev/stdout | grep "target_motif" > filtered.bed`
*   **Schema Inspection**: If you are unsure of the extra columns (beyond the standard BED3 or BED6) in a bigBed file, use the `bigBedInfo` tool (often bundled with this package) to see the field definitions before conversion.

## Reference documentation
- [ucsc-bigbedtobed Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigbedtobed_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Listing](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)