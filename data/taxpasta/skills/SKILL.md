---
name: taxpasta
description: Taxpasta standardises and merges taxonomic profiles from various metagenomic profilers into a unified format. Use when user asks to standardise profiler outputs, aggregate multiple samples into a single matrix, or convert taxonomic results to BIOM, Parquet, or Excel formats.
homepage: https://github.com/taxprofiler/taxpasta
---


# taxpasta

## Overview
Taxpasta is a specialized tool designed to solve the "pasta" of inconsistent metagenomic profiling outputs. It provides a unified interface to convert diverse profiler formats into a common schema and aggregate multiple samples into a single comparative matrix. This is essential for downstream statistical analysis and visualization where consistent taxonomy IDs and rank reporting are required.

## Core Commands

### Standardise
Converts a single profiler output into a standard taxpasta format.
```bash
taxpasta standardise --profiler <PROFILER> --output <FILE> <INPUT>
```
- **Supported Profilers**: `bracken`, `centrifuge`, `diamond`, `ganon`, `kaiju`, `kmcp`, `kraken2`, `krakenuniq`, `megan6`, `metaphlan`, `motus`.
- **Output Formats**: `.tsv`, `.csv`, `.ods`, `.xlsx`, `.arrow`, `.parquet`.

### Merge
Aggregates multiple profiles into a single table.
```bash
taxpasta merge --profiler <PROFILER> --output <FILE> <INPUT1> <INPUT2> ...
```
- **Wildcard support**: Use `*.txt` or similar to batch process samples.
- **Sample Names**: By default, filenames are used. Use `--samplesheet <FILE>` (a TSV with `sample` and `file` columns) for custom naming.

## Expert Tips & Best Practices

### Taxonomy Integration
To add taxonomic names and ranks to your output (which usually only contain IDs), provide a path to a directory containing NCBI-style taxonomy files (`nodes.dmp` and `names.dmp`):
```bash
taxpasta merge -p kraken2 --taxonomy <PATH_TO_TAXDB> --add-name --add-rank -o merged_results.tsv *.kraken2.report
```

### BIOM Output
For compatibility with QIIME2 or other ecology tools, export to BIOM format. This requires the `--taxonomy` argument to populate the observation metadata:
```bash
taxpasta merge -p metaphlan --taxonomy <TAXDB> -o results.biom *.txt
```

### Handling Multi-Profiler Projects
If you have results from different tools (e.g., Kraken2 and MetaPhlAn) and want to compare them, standardise them individually first using the same taxonomy database to ensure ID consistency before manual joining.

### Performance
For very large datasets (hundreds of samples), prefer `.parquet` or `.arrow` output formats. These are significantly faster to write and read in downstream Python (Pandas) or R (Arrow) workflows compared to TSV.

## Common CLI Patterns

**Summarizing to a specific rank:**
While taxpasta standardises the input, it generally preserves the ranks provided by the profiler. Use the `--summarise-at` flag (if supported by the specific profiler module) to collapse counts to a specific level like 'genus' or 'species'.

**Quick validation:**
Check if your profiles are compatible with taxpasta before a long merge:
```bash
taxpasta standardise -p kraken2 -o /dev/null sample.report
```



## Subcommands

| Command | Description |
|---------|-------------|
| standardise | Standardise a taxonomic profile (alias: 'standardize') |
| taxpasta merge | Standardise and merge two or more taxonomic profiles. |

## Reference documentation
- [Taxpasta Commands Overview](./references/taxpasta_readthedocs_io_en_latest_commands.md)
- [Merging Profiles Guide](./references/taxpasta_readthedocs_io_en_latest_commands_merge.md)
- [Standardisation Details](./references/taxpasta_readthedocs_io_en_latest_commands_standardise.md)
- [Supported Profilers List](./references/taxpasta_readthedocs_io_en_latest_supported_profilers.md)
- [How-to: Adding Taxonomy Names](./references/taxpasta_readthedocs_io_en_latest_how-tos_how-to-add-names.md)