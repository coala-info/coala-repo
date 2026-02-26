---
name: ucsc-mktime
description: The `ucsc-mktime` utility transforms human-readable date strings into Unix timestamps. Use when user asks to convert date strings to timestamps, sort records by time, calculate time intervals, prepare time-based data for databases, or transform date columns in tabular files.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-mktime

## Overview
The `ucsc-mktime` utility is a specialized command-line tool from the UCSC Genome Browser "kent" source tree. It serves a singular, high-reliability purpose: transforming human-readable date strings into Unix timestamps. This is particularly useful in bioinformatics pipelines for sorting records by time, calculating intervals between genomic data updates, or preparing data for SQL databases that utilize epoch time.

## Usage Patterns

### Basic Conversion
The tool typically expects a date string as its primary argument. If run without arguments, it will display its specific usage requirements (which can vary slightly by build version).

```bash
mktime "YYYY-MM-DD HH:MM:SS"
```

### Common Workflow Integration
Because `ucsc-mktime` is a lightweight binary, it is best used within shell pipes to transform columns in tabular data (like BED or metadata files).

**Example: Converting a date column in a TSV**
If you have a file where the 3rd column is a date string:
```bash
cat metadata.tsv | while read -r line; do
    date_str=$(echo "$line" | cut -f3)
    timestamp=$(mktime "$date_str")
    echo -e "$line\t$timestamp"
done
```

## Expert Tips
*   **Permission Handling**: If you have just downloaded the binary from the UCSC server, you must grant execution permissions before use: `chmod +x mktime`.
*   **Timezone Sensitivity**: Like the standard C `mktime` function it wraps, this tool typically interprets input based on the local system timezone unless specified otherwise in the environment. For consistent results across different servers, ensure your `TZ` environment variable is set (e.g., `export TZ=UTC`).
*   **Standard Output**: The tool outputs the integer timestamp to `stdout`. You can capture this directly into variables in Bash scripts using `VAR=$(mktime "...")`.
*   **Complementary Tools**: In the UCSC toolset, `ucsc-mktime` is often used alongside `tickToDate` (which performs the inverse operation) and `gmtime` or `localtime`.

## Reference documentation
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-mktime Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-mktime_overview.md)