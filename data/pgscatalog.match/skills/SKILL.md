---
name: pgscatalog.match
description: This tool automates the alignment and matching of polygenic score files with target genomic variant data across different coordinate systems and orientations. Use when user asks to match scoring files against target genomes, merge match results from multiple chromosomes, or find the intersection of variants between two datasets.
homepage: https://github.com/PGScatalog/pygscatalog
metadata:
  docker_image: "quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0"
---

# pgscatalog.match

## Overview

The `pgscatalog.match` toolset provides a robust framework for the "variant matching" problem in polygenic score application. Because genomic data often varies in coordinate systems (GRCh37 vs. GRCh38), strand orientation, and allele representation, this tool automates the alignment of PGS scoring files with target variant information. It is designed to handle complex scenarios like strand flips, ambiguous variants, and multi-allelic sites, ensuring that the resulting matches are accurate for downstream score calculation.

## CLI Usage Patterns

The package provides three primary executable commands:

### 1. pgscatalog-match
The core command used to match structured scoring files against target genomes.

*   **Basic Workflow**: Typically follows `pgscatalog-format` (from the core package). It takes formatted scoring files and variant information files (like `.pvar` or `.bim`) as input.
*   **Handling Ambiguity**: Use the `--keep_ambiguous` and `--keep_multiallelic` flags to control how the matcher handles difficult variants. By default, the tool is conservative to ensure high-quality matches.
*   **Coordinate Systems**: Ensure your input files are in the same genome build. The tool relies on 1-based positioning for genomic coordinates.

### 2. pgscatalog-matchmerge
Used for large-scale datasets where matching has been performed in chunks (e.g., by chromosome).

*   **Efficiency**: Instead of matching a massive dataset in one go, run `pgscatalog-match` on individual chromosomes and use `matchmerge` to aggregate the results into a single consistent set of matches.

### 3. pgscatalog-intersect
A utility for finding the intersection of variants across two different variant information files.

*   **Use Case**: Use this when you need to compare a reference panel (like 1000 Genomes) against your target dataset to identify overlapping variants before applying a score.

## Expert Tips and Best Practices

*   **OmicsPred Integration**: The tool supports scoring files from OmicsPred. It includes aliases for `pgs_id` metadata and `rsID` columns to ensure compatibility with these specific formats.
*   **1-Based Positions**: Always verify that your input positions are 1-based. The tool enforces 1-based logic in its internal `hm_pos` (harmonized position) calculations.
*   **Overwrite Logic**: When re-running analyses, the `--overwrite` flag is available. Note that future updates may implement MD5 checksum comparisons to only overwrite if remote and local files differ.
*   **Memory Management**: For very large target datasets, prefer processing by chromosome and then using `pgscatalog-matchmerge` to avoid memory exhaustion.
*   **Installation**: The tool is best installed via `pipx install pgscatalog.match` for isolated environments or `conda install bioconda::pgscatalog.match` for bioinformatics pipelines.



## Subcommands

| Command | Description |
|---------|-------------|
| pgscatalog-intersect | Program to find matched variants (same strand) between a set of reference and target data .pvar/bim files. This also evaluate whether the variants in the TARGET are suitable for inclusion in a PCA analysis (excludes strand ambiguous and multi-allelic/INDEL variants), and can also uses the .afreq and .vmiss files exclude variants with missingness and MAF filters. |
| pgscatalog-match | Match variants from a combined scoring file against a set of target genomes from the same fileset, and output scoring files compatible with the plink2 --score function. |
| pgscatalog-matchmerge | Match and merge score files with target genomic datasets. |

## Reference documentation

- [pgscatalog.match Overview](./references/anaconda_org_channels_bioconda_packages_pgscatalog.match_overview.md)
- [pygscatalog GitHub Repository](./references/github_com_PGScatalog_pygscatalog.md)
- [pygscatalog Tags and Version History](./references/github_com_PGScatalog_pygscatalog_tags.md)