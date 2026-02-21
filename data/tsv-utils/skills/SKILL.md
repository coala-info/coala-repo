---
name: tsv-utils
description: The `tsv-utils` toolkit is a suite of high-performance, header-aware command-line tools designed for manipulating large tabular datasets.
homepage: https://github.com/eBay/tsv-utils
---

# tsv-utils

## Overview

The `tsv-utils` toolkit is a suite of high-performance, header-aware command-line tools designed for manipulating large tabular datasets. These utilities are optimized for speed and memory efficiency, often outperforming standard Unix tools like `awk`, `cut`, and `grep`. They are particularly effective for data preparation, exploratory analysis, and processing files with millions of rows where Unicode support and field-based operations are required.

## Core Toolset and Usage Patterns

### 1. Filtering Data (`tsv-filter`)
Use `tsv-filter` for complex numeric, string, or regular expression comparisons.
- **Header awareness**: Use `-H` to treat the first line as a header.
- **Named fields**: Reference columns by name instead of index.
- **Multiple tests**: Combine conditions (AND logic by default).

```bash
# Find rows where 'color' is red AND 'year' is between 1850 and 1950
tsv-filter -H --str-eq color:red --ge year:1850 --lt year:1950 data.tsv
```

### 2. Selecting and Reordering Columns (`tsv-select`)
A more powerful version of `cut` that supports reordering and field exclusion.
- **Reorder**: `tsv-select -H -f color,id,count data.tsv`
- **Exclude**: `tsv-select -H -e year data.tsv` (keeps everything except 'year')

### 3. Summary Statistics (`tsv-summarize`)
Calculate aggregates across the whole file or grouped by specific keys.
- **Common operators**: `sum`, `min`, `max`, `mean`, `median`, `stdev`, `count`, `unique-count`.

```bash
# Calculate total count and average year grouped by color
tsv-summarize -H --group-by color --sum count --mean year data.tsv
```

### 4. Joining Files (`tsv-join`)
Join a "data file" with a "filter file" based on a common key.
- **Filter-only**: Use `--filter-file` to keep only rows in the data file that have a match in the filter file.
- **Append fields**: Use `--append-fields` to pull columns from the filter file into the data file.

```bash
# Join data.tsv with lookup.tsv on the 'id' field, appending the 'name' column
tsv-join -H --filter-file lookup.tsv --key-fields id --append-fields name data.tsv
```

### 5. Sampling and Randomization (`tsv-sample`)
Efficiently sample lines without loading the entire file into memory.
- **Randomize order**: `tsv-sample data.tsv`
- **Fixed size sample**: `tsv-sample -n 100 data.tsv`

## Expert Tips and Best Practices

- **CSV to TSV First**: The toolkit is optimized for TSV. If starting with CSV, use `csv2tsv` first to convert the data, as subsequent TSV operations will be significantly faster.
- **Piping for Performance**: These tools follow Unix philosophy. Pipe them together to build complex pipelines (e.g., `tsv-filter ... | tsv-summarize ... | tsv-pretty`).
- **Field Identification**: While named fields (via `-H`) are more readable, you can always use 1-based indices (e.g., `--eq 3:2008`) for files without headers or for quicker typing.
- **Visual Inspection**: Use `tsv-pretty` at the end of a pipeline to view results in an aligned, readable format on the terminal.
- **Header Preservation**: When concatenating multiple files with headers, use `tsv-append -H` to ensure only one header remains in the output and to optionally track the source file.

## Reference documentation
- [eBay's TSV Utilities Overview](./references/github_com_eBay_tsv-utils.md)
- [tsv-utils Bioconda Package](./references/anaconda_org_channels_bioconda_packages_tsv-utils_overview.md)