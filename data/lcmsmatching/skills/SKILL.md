---
name: lcmsmatching
description: The lcmsmatching tool matches experimental mass spectrometry data against reference databases to facilitate metabolite identification. Use when user asks to match m/z and retention time values, query metabolite databases, or identify compounds using local or remote libraries.
homepage: https://github.com/workflow4metabolomics/lcmsmatching
---


# lcmsmatching

## Overview
The `lcmsmatching` tool is a specialized R-based utility developed for the Workflow4Metabolomics project. It provides algorithms for matching experimental mass spectrometry data—specifically mass-to-charge ratios (m/z) and retention times (RT)—against reference databases to facilitate metabolite identification. The tool utilizes the `biodb` R library to interface with various database backends and supports both remote queries and local file-based libraries.

## Command Line Usage
The primary interface is the `lcmsmatching` script.

### Basic Syntax
```bash
lcmsmatching [options]
```

### Common Options and Patterns
*   **Help and Documentation**: Run `lcmsmatching -h` to view a comprehensive list of options and usage examples.
*   **Database Selection**: Specify the database type (e.g., PeakForest). Note that as of version 4.0.0, the tool uses `biodb` for database connectivity.
*   **Retention Time (RT) Units**: You must specify the units for RT values in both your input file and your database. Supported units are typically `minutes` or `seconds`.
*   **In-house File Databases**: When using a local file as a database, use a comma-separated list of key/value pairs to map column names (e.g., `mz=col1,rt=col2`).

## Best Practices and Expert Tips
*   **Dependency Management**: Ensure R (version 3.5.1 or higher) is installed along with the `getopt` (>= 1.20.2) and `biodb` (>= 1.2.0) packages.
*   **Handling Missing Data**: The tool is designed to return an empty match if `mz.low` or `mz.high` values are `NA`. Ensure your input data is cleaned if you expect matches for every row.
*   **Column Mapping**: For in-house databases, the tool attempts to guess field names, but explicit mapping via the comma-separated key/value string is more reliable for complex schemas.
*   **Performance**: If generating HTML reports, be aware that version 3.4.3 and later include optimizations for faster HTML output writing.
*   **Database Connectivity**: If using PeakForest, ensure you are using the updated URL provided in version 4.0.0+ to avoid connection errors.
*   **M/Z Tolerance**: Double-check the m/z tolerance units in your parameters to ensure they align with the precision of your mass spectrometer data.

## Reference documentation
- [lcmsmatching README](./references/github_com_workflow4metabolomics_lcmsmatching.md)
- [lcmsmatching Issues](./references/github_com_workflow4metabolomics_lcmsmatching_issues.md)