---
name: abritamr
description: "A tool for antimicrobial resistance gene detection (Note: The provided text is a container build error log and does not contain the tool's help documentation)."
homepage: https://github.com/MDU-PHL/abritamr
---

# abritamr

## Overview

abritamr is a specialized bioinformatics pipeline that simplifies the process of screening bacterial isolates for resistance mechanisms. While it relies on the NCBI AMRFinderPlus engine, its primary value lies in its ability to "tame" the complex output by binning genes into drug classes and providing clear distinctions between full matches, partial matches, and virulence factors. It is particularly useful for high-throughput labs requiring standardized reporting, as it includes a dedicated reporting mode that generates spreadsheets compatible with clinical accreditation standards (e.g., NATA).

## Usage Guidelines

### Core Execution Patterns

The primary command is `abritamr run`. You can process a single assembly or a batch of isolates.

**1. Single Sample Analysis**
To run a single assembly, provide the path to the contigs and a prefix for the output directory.
```bash
abritamr run --contigs path/to/assembly.fasta --prefix MySample
```

**2. Batch Processing**
For multiple samples, create a tab-delimited file (e.g., `isolates.txt`) where column 1 is the Sample ID and column 2 is the path to the assembly file.
```bash
abritamr run --contigs isolates.txt --jobs 16
```

**3. Detecting Point Mutations**
Point mutation detection is not automatic; you must specify the species. If the species is not in the supported list, only acquired genes will be reported.
```bash
abritamr run --contigs sample.fasta --species Salmonella --prefix Sal_Results
```
*Supported species include: Neisseria, Clostridioides_difficile, Acinetobacter_baumannii, Campylobacter, Enterococcus_faecalis, Enterococcus_faecium, Escherichia, Klebsiella, Salmonella, Staphylococcus_aureus, Staphylococcus_pseudintermedius, Streptococcus_agalactiae, Streptococcus_pneumoniae, and Streptococcus_pyogenes.*

### Generating Reports

The `report` sub-command transforms the raw collation into a formatted Excel spreadsheet. This requires a quality control (QC) file.

```bash
abritamr report --qc mdu_qc_file.csv --runid RUN_001 --matches summary_matches.txt --partials summary_partials.txt
```
*   **--sop**: Choose `general` for standard reporting or `plus` for inferred AST based on MDU validation.

## Expert Tips and Best Practices

*   **Database Versions**: abritamr comes with a specific version of the AMRFinder DB for consistency. To use a newer or custom database, use the `-d` or `--amrfinder_db` flag to point to the directory containing the NCBI data.
*   **Interpreting Symbols**:
    *   `*` (Asterisk): Indicates a match with >90% coverage and >90% identity, but less than 100% identity.
    *   `^` (Caret): Found in virulence and partial files, indicating 50-90% coverage.
    *   No symbol: Indicates a 100% identity and 100% coverage match.
*   **Partial Matches**: Always check `summary_partials.txt`. These are genes with 50-90% coverage. In short-read assemblies, resistance genes often fall on contig boundaries; a partial match may indicate a functional gene split across two contigs.
*   **Identity Thresholds**: The default identity threshold is 0.9 (90%). You can tighten this using the `-i` flag (e.g., `-i 0.95`) if you require higher stringency for specific surveillance tasks.
*   **Resource Management**: Use the `--jobs` flag to utilize multiple cores, especially when processing large batches of isolates, as AMRFinderPlus can be computationally intensive.

## Reference documentation

- [Main Usage and CLI Reference](./references/github_com_MDU-PHL_abritamr.md)
- [Interpretation and Logic Guide](./references/github_com_MDU-PHL_abritamr_wiki.md)
- [Package Overview](./references/anaconda_org_channels_bioconda_packages_abritamr_overview.md)