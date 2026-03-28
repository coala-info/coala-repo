---
name: pgscatalog.core
description: This tool automates the retrieval, standardization, and relabeling of polygenic scoring files from the PGS Catalog. Use when user asks to download scoring files for specific genome builds, format diverse scoring files into a consistent schema, or relabel variant identifiers to match genotype data.
homepage: https://github.com/PGScatalog/pygscatalog/
---


# pgscatalog.core

## Overview
The `pgscatalog.core` package provides a suite of command-line tools designed to streamline the initial stages of polygenic score calculation. It handles the "heavy lifting" of interacting with the PGS Catalog API and normalizing the resulting data. Use this skill when you need to automate the retrieval of polygenic scores, ensure that scoring files from different sources follow a unified format for downstream tools like `pgscatalog.match`, or perform bulk relabeling of variant IDs.

## CLI Usage and Best Practices

### Downloading Scoring Files
The `pgscatalog-download` tool fetches scoring files and their associated metadata.

*   **Specify Genome Builds**: Always define the target build to ensure compatibility with your target genotype data.
    ```bash
    pgscatalog-download -a PGS000001 PGS000002 -b GRCh38
    ```
*   **Rate Limiting**: The tool includes built-in rate limiting to prevent API throttling. When downloading hundreds of scores, allow the process to run without interruption; it will manage the connection automatically.
*   **Output Management**: By default, files are saved to the current directory. Use the `-o` flag to keep your workspace organized.

### Formatting and Standardizing Scores
The `pgscatalog-format` tool (which replaces the deprecated `pgscatalog-combine`) converts various scoring file versions into a consistent, pydantic-validated schema.

*   **Multiprocessing**: For large batches of scores, `pgscatalog-format` utilizes multiple cores. Each input file is processed and written to a separate output file to maintain efficiency.
    ```bash
    pgscatalog-format -i scoring_file_*.txt.gz -o formatted_scores/
    ```
*   **Custom Scoring Files**: You can use this tool to format local, non-catalog scoring files. It supports files even if they are missing the `other_allele` column, provided the rest of the required fields are present.
*   **Validation**: The tool automatically validates data models. If a file fails formatting, check the logs for specific pydantic validation errors (e.g., invalid effect weights or missing coordinates).

### Relabeling Variant Identifiers
Use `pgscatalog-relabel` when your scoring files use one set of IDs (e.g., rsIDs) but your target genotypes use another (e.g., CHR_POS_REF_ALT).

*   **Mapping Files**: Requires a mapping file that contains both the current labels and the new labels.
    ```bash
    pgscatalog-relabel -i scoring_file.txt -m mapping_table.csv --col_from rsid --col_to target_id
    ```

## Expert Tips
*   **Natural Sorting**: When processing multiple files, the library uses natural sorting for chromosomes (e.g., 1, 2, 10 instead of 1, 10, 2). This is handled internally but ensures that merged outputs follow standard genomic ordering.
*   **Memory Efficiency**: The tool has moved away from heavy dependencies like `pyarrow` for basic reading tasks to reduce the memory footprint during the formatting of large scoring files.
*   **OmicsPred Support**: The core library supports OmicsPred scoring files, allowing you to apply the same formatting and download workflows to proteomic and transcriptomic scores.



## Subcommands

| Command | Description |
|---------|-------------|
| pgscatalog-download | Download a set of scoring files from the PGS Catalog using PGS Scoring IDs, traits, or publication accessions. |
| pgscatalog-format | Format multiple scoring files in PGS Catalog format (see https://www.pgscatalog.org/downloads/ for details) to a standard column set needed for variant matching and subsequent calculation. During this process Variants are checked to make sure they pass data validation using the PGS Catalog standard data models. Custom scorefiles in PGS Catalog format can be combined with PGS Catalog scoring files, and optionally liftover genomic coordinates to GRCh37 or GRCh38. The script can accept a mix of unharmonised and harmonised PGS Catalog data. By default all variants are output (including positions with duplicated data [often caused by rsID/liftover collions across builds]) and variants with missing positions. |
| pgscatalog-relabel | Relabel the column values in one file based on a pair of columns in another |

## Reference documentation
- [pgscatalog.core README](./references/github_com_PGScatalog_pygscatalog_blob_main_pgscatalog.utils_packages_pgscatalog.core_README.md)
- [pygscatalog Main README](./references/github_com_PGScatalog_pygscatalog_blob_main_README.md)
- [Changelog](./references/github_com_PGScatalog_pygscatalog_blob_main_CHANGELOG.md)