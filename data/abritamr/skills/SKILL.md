---
name: abritamr
description: abritamr is a bioinformatics pipeline that identifies antimicrobial resistance genes and point mutations from genomic contigs by wrapping and collating results from AMRFinderPlus. Use when user asks to identify AMR genes, detect chromosomal point mutations in specific species, or generate structured resistome reports from assembly files.
homepage: https://github.com/MDU-PHL/abritamr
---

# abritamr

## Overview
abritamr is a specialized bioinformatics pipeline designed to streamline the identification of AMR genes from genomic contigs. It acts as a wrapper and collator for NCBI's AMRFinderPlus, transforming raw search results into structured, functionally-grouped tables. This tool is essential for researchers and clinicians who need to move beyond simple gene presence/absence to understand the functional implications of a resistome, including the detection of point mutations in specific species and the identification of partial gene matches that may indicate assembly breaks.

## Command Line Usage and Best Practices

### Core Execution Patterns
The primary command is `abritamr run`. You can process a single assembly or a batch of isolates.

**Single Sample Run:**
```bash
abritamr run --contigs sample.fasta --prefix MySample --species Staphylococcus_aureus
```
*   **Tip**: Always provide the `--species` flag if you want to detect chromosomal point mutations. Without it, only acquired genes are reported.

**Batch Processing:**
Create a tab-delimited file (e.g., `isolates.txt`) where column 1 is the Sample ID and column 2 is the path to the assembly file.
```bash
abritamr run --contigs isolates.txt --jobs 8
```
*   **Tip**: Adjust `--jobs` based on your CPU availability to parallelize the underlying AMRFinderPlus tasks.

### Reporting and Collation
If you have existing abritamr outputs and need to generate a standardized report (e.g., for NATA/MDU standards):
```bash
abritamr report --qc qc_results.csv --matches summary_matches.txt --partials summary_partials.txt --sop general
```
*   **SOP Options**: Use `general` for standard reporting or `plus` for inferred AST (Antimicrobial Susceptibility Testing) based on validated logic.

### Expert Tips for Interpretation
*   **Identity and Coverage**: By default, abritamr uses a 90% identity and 90% coverage threshold for "matches."
*   **The Asterisk (*)**: Genes marked with `*` in the output indicate a match that meets the thresholds (>90%) but is not a 100% identical match to the reference allele.
*   **The Caret (^)**: Genes marked with `^` indicate partial matches (50-90% coverage). These often represent genes split across contig boundaries and may require manual assembly inspection.
*   **Point Mutations**: These are reported in the format `gene_AAchange` (e.g., `gyrA_S83L`). Ensure the `--species` name matches the supported list (e.g., `Klebsiella`, `Salmonella`, `Acinetobacter_baumannii`).

### Database Management
abritamr comes with a packaged version of the AMRFinder DB. To use a custom or updated version:
```bash
abritamr run --contigs isolates.txt --amrfinder_db /path/to/external/db
```



## Subcommands

| Command | Description |
|---------|-------------|
| abritamr report | Generate reports for abritamr results |
| abritamr run | Run AMR detection using abritamr and amrfinderplus |

## Reference documentation
- [abritamr Wiki - Home](./references/github_com_MDU-PHL_abritamr_wiki.md)
- [abritamr Wiki - Running](./references/github_com_MDU-PHL_abritamr_wiki_Running.md)
- [abritamr Wiki - Interpretation](./references/github_com_MDU-PHL_abritamr_wiki_Interpretation.md)
- [abritamr GitHub README](./references/github_com_MDU-PHL_abritamr.md)