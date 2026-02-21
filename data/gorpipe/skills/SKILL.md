---
name: gorpipe
description: GORpipe is a high-performance parallel execution engine designed for genomic data based on a Genomic Ordered Relations (GOR) architecture.
homepage: https://github.com/gorpipe/gor
---

# gorpipe

## Overview
GORpipe is a high-performance parallel execution engine designed for genomic data based on a Genomic Ordered Relations (GOR) architecture. It allows you to treat genomic data as ordered relations, enabling efficient seek-able queries and complex joins between variants and segments. The query language blends SQL-like declarations with Unix-style pipe syntax, making it powerful for batch analysis and range-specific lookups without the overhead of a traditional database.

## Core CLI Usage

### Basic Query Execution
The primary entry point is the `gorpipe` command, which takes a query string as its main argument.

```bash
# Query a GOR file and view the first 10 rows
gorpipe "gor path/to/data.gor | top 10"

# Query non-genomic tabular data
gorpipe "nor path/to/data.txt | top 10"
```

### Genomic Range Queries
Use `gorrows` to generate or filter specific genomic coordinates efficiently.

```bash
# Generate rows for a specific region and pipe into a command
gorpipe "gor <(gorrows -p chr1:1000-20000 -segment 100)"
```

### Using Aliases
For repetitive references to standard datasets (like gene sets or reference genomes), use an alias file to keep queries clean.

```bash
# Use #alias_name# syntax
gorpipe "gor #genes# | top 10" -aliases config/gor_aliases.txt
```

## Common Query Patterns

| Task | Command Pattern |
| :--- | :--- |
| **Filtering** | `gor <file> | where column_name == 'value'` |
| **Aggregation** | `gor <file> | group -lis -sc #column` |
| **Joining** | `gor <file1> | multimap -cartesian <(gor <file2>)` |
| **Limiting** | `gor <file> | top 100` or `select * from <file> limit 100` |

## Expert Tips
- **Interactive Exploration**: Use `gorshell` to start a REPL environment. This is significantly faster for iterating on complex queries than re-running `gorpipe` repeatedly.
- **Dictionary Files**: When working with massive datasets, query the `.gord` (GOR Dictionary) file instead of the raw data for faster metadata-driven access.
- **Spark Integration**: If the environment supports it, use `select` statements (SQL-style) which are often optimized for the GORspark parallel engine.
- **Nested Queries**: GORpipe supports seek-able nested queries using the `<(query)` syntax, similar to Bash process substitution, which is essential for complex joins.

## Reference documentation
- [GORpipe GitHub Repository](./references/github_com_gorpipe_gor.md)
- [Bioconda Gorpipe Overview](./references/anaconda_org_channels_bioconda_packages_gorpipe_overview.md)