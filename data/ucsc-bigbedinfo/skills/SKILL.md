---
name: ucsc-bigbedinfo
description: The `bigBedInfo` utility is a specialized tool from the UCSC Genome Browser group used to retrieve header information and summary statistics from bigBed files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bigbedinfo

## Overview
The `bigBedInfo` utility is a specialized tool from the UCSC Genome Browser group used to retrieve header information and summary statistics from bigBed files. Since bigBed files are binary, indexed versions of BED files, this tool is essential for "peeking" into the file to understand its internal structure, field definitions, and data density without needing to convert the entire file back to a text-based BED format.

## Command Line Usage

The basic syntax for the tool is:
`bigBedInfo [options] file.bb`

### Common Options
- `-chroms`: Lists all chromosomes/sequences present in the bigBed file along with their internal IDs and sizes.
- `-extraIndex`: Lists any additional indices created for the file (e.g., for searching by name or other fields).
- `-as`: Displays the AutoSql ( .as) schema used to define the fields in the file. This is particularly useful for bigBed files with custom columns beyond the standard BED12.
- `-minMax`: Shows the minimum and maximum values for the fields.

### Standard Output Fields
When run without options, the tool provides:
- **version**: The bigBed format version.
- **fieldCount**: The number of columns in the file.
- **hasTheIndex**: Indicates if a primary spatial index is present.
- **hasNameIndex**: Indicates if an index on the 'name' field exists.
- **itemCount**: The total number of features/intervals in the file.
- **summary**: Statistics including min, max, mean, and standard deviation of the values (if applicable).

## Expert Tips and Best Practices

### Validating Chromosome Naming
Before running intersection tools or uploading to a genome browser, use `bigBedInfo -chroms` to verify the chromosome naming convention. This allows you to quickly see if the file uses "chr1" vs "1", preventing common "chromosome not found" errors in downstream analysis.

### Inspecting Custom Fields
For non-standard bigBed files (like those containing GWAS data or specialized annotations), use the `-as` flag. This reveals the labels and data types of custom columns, which is necessary for correctly filtering or querying the file using other tools like `bigBedToBed`.

### Quick Data Audits
The `itemCount` field is the most efficient way to verify that a file conversion or download was successful. If you expect 1 million peaks and `bigBedInfo` reports 500,000, you can immediately identify a truncated file or a failed upstream process without parsing the multi-gigabyte binary data.

### Performance Note
`bigBedInfo` only reads the file headers and indices. It is extremely fast even on very large files (multi-gigabyte) because it does not scan the actual data records unless summary statistics are requested.

## Reference documentation
- [ucsc-bigbedinfo overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigbedinfo_overview.md)
- [UCSC Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)