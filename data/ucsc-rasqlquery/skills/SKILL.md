---
name: ucsc-rasqlquery
description: ucsc-rasqlquery queries Record-Attribute (RA) files using SQL-like syntax. Use when user asks to extract specific fields, filter records, join multiple RA files, or audit track configuration files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-rasqlquery:482--h0b57e2e_0"
---

# ucsc-rasqlquery

## Overview
The `raSqlQuery` utility treats RA (Record-Attribute) files as flat-file databases, allowing you to use SQL-like syntax to query text-based records. In the UCSC ecosystem, RA files are the standard format for track configurations and metadata. This tool eliminates the need for complex grep/awk chains by providing a structured way to select specific attributes, filter records based on values, and even perform joins between multiple RA files.

## Command Line Usage

The basic syntax for the tool follows a standard SQL structure:
`raSqlQuery "select [fields] from [file.ra] where [conditions]"`

### Common Patterns
- **Field Selection**: Extract only specific tags from a large configuration file.
  `raSqlQuery "select track,shortLabel,type from trackDb.ra"`
- **Filtering**: Find tracks of a specific type or with specific attributes.
  `raSqlQuery "select track from trackDb.ra where type='bigWig'"`
- **Wildcards**: Use `*` to select all fields in a record.
  `raSqlQuery "select * from trackDb.ra where visibility='dense'"`

### Tool-Specific Best Practices
- **Record Separation**: Remember that `raSqlQuery` identifies records based on blank lines. Ensure your input RA file is properly formatted; otherwise, multiple records may be treated as one.
- **Field Names**: Field names in the query must exactly match the tags in the RA file (e.g., `track`, `shortLabel`, `bigDataUrl`).
- **Quoting**: Always wrap the entire SQL statement in double quotes to prevent the shell from interpreting special characters like `*` or parentheses.
- **Performance**: For extremely large RA files, `raSqlQuery` is significantly faster than custom Python or Perl parsers because it is a compiled C binary optimized for the Kent library's RA parser.

### Expert Tips
- **Joins**: You can join two RA files if they share a common key. This is useful for merging metadata files with track configuration files.
- **Output Formatting**: The output is typically returned in a tab-separated format when selecting specific fields, making it easy to pipe into `cut`, `sort`, or `datamash`.
- **Validation**: Use `raSqlQuery` to audit your `trackDb` files. For example, you can quickly find all tracks missing a `longLabel` or those pointing to a specific data directory.

## Reference documentation
- [ucsc-rasqlquery Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-rasqlquery_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)