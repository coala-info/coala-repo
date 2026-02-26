---
name: microhapdb
description: MicroHapDB is a portable database and toolkit for managing human microhaplotype variation and population frequency data. Use when user asks to search for specific markers, filter alleles by population frequency, rank markers for ancestry inference, or access microhaplotype data programmatically.
homepage: https://github.com/bioforensics/MicroHapDB/
---


# microhapdb

## Overview
MicroHapDB is a portable, plain-text database and toolkit designed for the management of human microhaplotype variation data. It integrates marker information and population frequency data from various published sources, providing a unified interface to query allele frequency estimates and allelic diversity statistics ($A_e$) for 26 global populations. The tool is designed for minimal infrastructure requirements and can be accessed via a command-line interface (CLI), a Python API, or by direct inspection of its underlying text tables.

## Usage Instructions

### Installation and Setup
The recommended way to install MicroHapDB is via Bioconda:
```bash
conda install -c bioconda microhapdb
```
To verify the installation and run internal tests:
```bash
pytest --pyargs microhapdb --doctest-modules
```

### Command Line Interface (CLI)
The `microhapdb` command provides several subcommands for interacting with the database. The primary workflows involve:
- **Searching**: Locate specific markers or alleles based on genomic coordinates or identifiers.
- **Filtering**: Narrow down markers based on population-specific frequency thresholds or diversity metrics.
- **Browsing**: View the contents of the database tables directly from the terminal.

### Python API
For programmatic access within bioinformatics pipelines, use the Python interface:
```python
import microhapdb
# Access marker and frequency data programmatically
```

### Data Characteristics
- **Populations**: Data is computed for 26 global populations.
- **Metrics**: Use the Effective Number of Alleles ($A_e$) to rank markers for applications like individual identification or ancestry inference.
- **Format**: The database is distributed as plain text, making it compatible with standard Unix text-processing tools (grep, awk, sed) and spreadsheet software like Microsoft Excel.

## Expert Tips
- **Marker Ranking**: When designing a custom panel, prioritize markers with high $A_e$ values in your target populations to maximize discriminatory power.
- **Direct Table Access**: Since the database is stored in plain text within the package distribution, you can locate the raw CSV/TSV files for bulk processing if the CLI or API does not support a specific complex query.
- **Citations**: If using the database for publication, ensure you cite the primary reference: Standage & Mitchell (2020), Frontiers in Genetics.

## Reference documentation
- [MicroHapDB GitHub Repository](./references/github_com_bioforensics_MicroHapDB.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_microhapdb_overview.md)