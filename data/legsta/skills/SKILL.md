---
name: legsta
description: `legsta` is a specialized bioinformatics tool designed for the rapid epidemiological typing of *Legionella pneumophila*.
homepage: https://github.com/tseemann/legsta
---

# legsta

## Overview
`legsta` is a specialized bioinformatics tool designed for the rapid epidemiological typing of *Legionella pneumophila*. It automates the Sequence Based Typing (SBT) scheme by identifying alleles across seven specific genes. This tool is essential for comparing clinical and environmental isolates to track the source of Legionnaires' disease outbreaks. It simplifies the workflow by accepting a wide variety of input formats and providing easily parsable tabular output.

## Usage Instructions

### Basic Command Syntax
The primary way to run `legsta` is by passing one or more sequence files to the executable:
```bash
legsta [options] <input_files>
```

### Input File Support
`legsta` uses `any2fasta` internally, allowing it to process a broad range of genomic file formats without manual conversion:
- **Formats**: FASTA (.fna, .fasta), Genbank (.gbk, .gb), EMBL, GFF.
- **Compression**: Supports files compressed with `gzip`, `bzip2`, or `zip` automatically.

### Common CLI Patterns
- **Standard Tab-Separated Output**:
  `legsta isolates/*.fna > sbt_results.tsv`
- **Comma-Separated Output (for Excel/Spreadsheets)**:
  `legsta --csv sample1.gbk.gz sample2.fasta > report.csv`
- **Batch Processing without Headers**:
  Useful when appending results to an existing file.
  `legsta --noheader new_isolate.fasta >> master_results.tsv`
- **Quiet Mode**:
  Suppresses informational messages to stderr, leaving only the result table.
  `legsta --quiet input.fasta`

### Interpreting Results
The output table contains the filename, the determined SBT (Sequence Type), and the individual allele numbers for the seven genes: `flaA`, `pilE`, `asd`, `mip`, `mompS`, `proA`, and `neuA`.
- **`-` (Dash)**: Indicates that no in silico product was detected for that specific allele.
- **`?` (Question Mark)**: Indicates a novel allele that does not match the current database.

## Expert Tips
- **Database Updates**: `legsta` relies on a specific database of profiles and sequences. If you consistently see `?` for known strains, ensure your installation is up to date to include the latest alleles from the PHE (Public Health England) database.
- **Mixed Inputs**: You can mix and match file formats in a single command (e.g., passing a `.fasta` and a `.gbk.gz` simultaneously); the tool handles the conversion seamlessly.
- **Standardizing Output**: When building automated pipelines, use the `--csv` flag to ensure consistent parsing if your downstream tools prefer comma-separated values over tabs.

## Reference documentation
- [github_com_tseemann_legsta.md](./references/github_com_tseemann_legsta.md)
- [anaconda_org_channels_bioconda_packages_legsta_overview.md](./references/anaconda_org_channels_bioconda_packages_legsta_overview.md)