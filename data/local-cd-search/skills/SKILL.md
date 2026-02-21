---
name: local-cd-search
description: `local-cd-search` is a command-line utility designed for high-throughput protein annotation.
homepage: https://github.com/apcamargo/local-cd-search
---

# local-cd-search

## Overview
`local-cd-search` is a command-line utility designed for high-throughput protein annotation. It bridges the gap between the NCBI CD-Search web interface and local bioinformatics pipelines by automating the retrieval of PSSM databases and the execution of the RPS-BLAST/rpsbproc workflow. It ensures that hits are filtered according to CDD's specific bit-score thresholds, providing high-confidence functional assignments.

## Installation
The recommended installation method is via Pixi or Conda to ensure all binary dependencies (like `rpsblast` and `rpsbproc`) are correctly managed.

```bash
# Using Pixi
pixi global install -c conda-forge -c bioconda local-cd-search

# Using Conda
conda install bioconda::local-cd-search
```

## Database Management
Before annotating, you must download the PSSM databases. You can download the entire CDD collection or specific subsets to save time and disk space.

- **Full Collection**: `local-cd-search download database cdd`
- **Specific Subsets**: `local-cd-search download database cog pfam tigr`

| Database | Description |
|----------|-------------|
| `cdd` | Full collection (excluding KOG) |
| `cog` | Prokaryotic orthologous groups |
| `kog` | Eukaryotic orthologous groups |
| `pfam` | Large collection of protein families |
| `smart` | Signaling and regulatory domains |

## Annotation Workflow
The primary command for processing sequences is `annotate`.

```bash
local-cd-search annotate proteins.faa results.tsv /path/to/db_dir
```

### Expert CLI Patterns
- **Performance Tuning**: Always specify `--threads` to utilize multi-core processors, as RPS-BLAST is computationally intensive.
- **Functional Site Mapping**: Use the `--sites-output` flag to generate a second file containing residue-level annotations (e.g., active sites, binding sites).
- **Sensitivity Control**: 
    - Use `--ns` to include non-specific hits (statistically significant but not the top-ranking hit for a region).
    - Use `--sf` to include superfamily-level assignments.
- **Data Redundancy**: Adjust `--data-mode` if you need more than the default "best model per source" (`std`). Use `full` to see every model that meets the E-value threshold.

### Interpreting Results
- **Specific Hits**: High-confidence family assignments.
- **Incomplete Column**: Check for `N`, `C`, or `NC` values to identify domains that are truncated by more than 20% at the terminals.
- **Bit-score Filtering**: Unlike raw BLAST, the default output is already filtered by CDD's curated thresholds, reducing false positives.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_apcamargo_local-cd-search.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_local-cd-search_overview.md)