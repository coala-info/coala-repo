---
name: local-cd-search
description: This tool performs high-throughput protein functional annotation by automating PSSM retrieval and RPS-BLAST execution. Use when user asks to annotate protein sequences, download conserved domain databases, or identify functional sites and distant homologs.
homepage: https://github.com/apcamargo/local-cd-search
---

# local-cd-search

## Overview

The `local-cd-search` tool provides a streamlined command-line interface for high-throughput protein functional annotation. It automates the retrieval of Position-Specific Scoring Matrices (PSSMs) from NCBI and handles the execution of RPS-BLAST and `rpsbproc` post-processing. This allows for sensitive detection of distant homologs using curated bit-score thresholds, which is more robust than simple sequence-to-sequence searches and faster than HMM-based methods.

## Database Management

Before annotating sequences, you must download the required PSSM models.

- **Download all**: Use `local-cd-search download database cdd` to get the full collection (NCBI-curated, COG, Pfam, PRK, SMART, and TIGR).
- **Targeted download**: Specify individual databases to save space or focus on specific taxa:
  - `cog`: Prokaryotic orthologous groups.
  - `pfam`: Broad collection of protein families.
  - `tigr`: Microbial protein functional annotation.
  - `kog`: Eukaryotic orthologous groups.
- **Force Update**: Use the `--force` flag if you need to re-download or update existing database files.

## Protein Annotation Workflow

The core command for processing sequences is `annotate`.

### Basic Usage
```bash
local-cd-search annotate proteins.faa results.tsv /path/to/db_dir
```

### Advanced Configuration
- **Functional Sites**: To identify specific residues involved in catalysis or binding, use the `--sites-output` (or `-s`) flag to generate a secondary report.
- **Sensitivity Tuning**: 
  - Adjust the E-value threshold with `--evalue` (default is 0.01).
  - Use `--ns` to include non-specific hits.
  - Use `--sf` to include superfamily-level clusters.
- **Performance**: Use `--threads` to specify the number of CPU cores for the underlying `rpsblast` process.
- **Data Redundancy**: Control hit density using `--data-mode`:
    - `rep`: Best model per region.
    - `std` (Default): Best model per source per region.
    - `full`: All significant models.

## Interpreting Results

The output TSV includes several critical columns for quality control:
- **hit_type**: "Specific" hits indicate high confidence that the query belongs to that exact family.
- **incomplete**: Look for `N`, `C`, or `NC` values, which indicate that more than 20% of the domain is missing from the respective terminals of your query sequence.
- **coordinates**: In the sites output, this provides the specific residue and position (e.g., H94, Y96).



## Subcommands

| Command | Description |
|---------|-------------|
| local-cd-search annotate | Run the annotation pipeline. |
| local-cd-search download | Download one or more PSSM databases and CDD metadata into DB_DIR. |

## Reference documentation

- [local-cd-search README](./references/github_com_apcamargo_local-cd-search_blob_main_README.md)
- [local-cd-search Changelog](./references/github_com_apcamargo_local-cd-search_blob_main_CHANGELOG.md)