---
name: tsv-utils
description: tsv-utils is a suite of high-performance command-line utilities designed for rapid processing, filtering, and manipulation of large tabular datasets. Use when user asks to select columns, filter rows, join files, generate summary statistics, or convert CSV files to TSV format.
homepage: https://github.com/eBay/tsv-utils
metadata:
  docker_image: "quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0"
---

# tsv-utils

## Overview

tsv-utils is a suite of specialized command-line utilities designed for the rapid processing of large tabular datasets. Developed by eBay, these tools are optimized for speed and memory efficiency, often significantly outperforming standard Unix utilities. They are particularly effective in machine learning and data mining workflows where datasets exceed several gigabytes. The toolkit provides a robust alternative to complex awk scripts or slow Python/R processing for common data manipulation tasks like column selection, filtering, joining, and statistical summarization.

## Core Tool Usage and Patterns

### 1. Column Selection (tsv-select)
Use `tsv-select` to extract specific columns by index or name.
- **By index**: `tsv-select -f 1,3,5 data.tsv`
- **By name (requires header)**: `tsv-select -H --fields "Date,User,Action" data.tsv`
- **Exclude columns**: `tsv-select -e 2,4 data.tsv`

### 2. Advanced Filtering (tsv-filter)
`tsv-filter` is the primary tool for row selection based on column values.
- **Numeric comparisons**: `tsv-filter --ge 3:100 --lt 3:500 data.tsv` (Column 3 is between 100 and 500).
- **String matching**: `tsv-filter --str-eq 1:active data.tsv`
- **Regex**: `tsv-filter --regex 2:'^ID_[0-9]+$' data.tsv`
- **Multiple criteria (AND)**: `tsv-filter --ge 3:10 --str-ne 4:pending data.tsv`

### 3. Joining Files (tsv-join)
Join a "data" file with a "reference" file based on a common key.
- **Basic join**: `tsv-join --filter-file ref.tsv --key-fields 1 --data-fields 2 data.tsv`
- **Append columns from ref**: `tsv-join --filter-file ref.tsv --key-fields 1 --data-fields 1 --append-fields 2,3 data.tsv`

### 4. Aggregation and Statistics (tsv-summarize)
Generate summary statistics for grouped data.
- **Global stats**: `tsv-summarize --sum 2 --mean 2 --max 2 data.tsv`
- **Grouped stats**: `tsv-summarize -H --group-by "Category" --sum "Amount" --count data.tsv`

### 5. Format Conversion (csv2tsv)
Always convert CSVs to TSV before processing with other tools to ensure maximum performance and correct handling of delimiters.
- **Standard conversion**: `csv2tsv data.csv > data.tsv`
- **Custom delimiter**: `csv2tsv -d '|' data.txt > data.tsv`

## Expert Tips and Best Practices

- **Header Handling**: Most tools support the `-H` or `--header` flag. Use it to keep headers intact during operations or to reference columns by name rather than index.
- **Performance Optimization**:
    - Use `tsv-filter` instead of `awk` for simple column-based logic; it is significantly faster.
    - When joining, ensure the `--filter-file` (the one loaded into memory) is the smaller of the two files.
- **Piping**: Chain tools together for complex transformations:
  `csv2tsv data.csv | tsv-select -f 1,3 | tsv-filter --gt 2:10 | tsv-summarize --group-by 1 --count`
- **Sampling**: Use `tsv-sample` for large files when you need a representative subset without loading the entire file into memory.
- **Pretty Printing**: Use `tsv-pretty` at the end of a pipeline to view results in a human-readable aligned format, but never use it in the middle of a pipeline as it breaks the TSV format.



## Subcommands

| Command | Description |
|---------|-------------|
| csv2tsv | Convert CSV (comma separated values) to TSV (tab separated values). |
| tsv-append | Concatenate TSV files, maintaining the header of the first file and optionally tracking the source of each row. (Note: The provided help text contained system error logs rather than tool usage; arguments list is based on standard tsv-append functionality). |
| tsv-filter | A tool for filtering TSV files based on field content using various operators (equality, numeric comparison, regular expressions, etc.). |
| tsv-join | Joins lines from files based on a common key. It is similar to the Unix 'join' tool, but works on TSV files and supports multiple fields and non-sorted input. |

## Reference documentation
- [Tools Reference](./references/opensource_ebay_com_tsv-utils_docs_ToolReference.html.md)
- [Tips and Tricks](./references/opensource_ebay_com_tsv-utils_docs_TipsAndTricks.html.md)
- [Comparing TSV and CSV](./references/opensource_ebay_com_tsv-utils_docs_comparing-tsv-and-csv.html.md)
- [tsv-filter Reference](./references/opensource_ebay_com_tsv-utils_docs_tool_reference_tsv-filter.html.md)
- [tsv-summarize Reference](./references/opensource_ebay_com_tsv-utils_docs_tool_reference_tsv-summarize.html.md)