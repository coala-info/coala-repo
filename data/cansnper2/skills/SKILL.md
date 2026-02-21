---
name: cansnper2
description: CanSNPer2 is a bioinformatics suite used for the high-resolution classification of bacterial pathogens based on single nucleotide polymorphisms (SNPs).
homepage: https://github.com/FOI-Bioinformatics/CanSNPer2
---

# cansnper2

## Overview
CanSNPer2 is a bioinformatics suite used for the high-resolution classification of bacterial pathogens based on single nucleotide polymorphisms (SNPs). It facilitates the transition from raw genomic assemblies to actionable typing results by aligning query sequences against reference genomes and identifying diagnostic SNPs defined in a database. The tool is particularly effective for epidemiological surveillance and forensic microbiology, providing both tabular summaries and visual phylogenetic trees to indicate the placement of a sample within a known hierarchy.

## Core Workflows

### 1. Using Pre-built Databases
To analyze genomes using existing schemes (e.g., from the CanSNPer2-data repository), follow this sequence:

**Download references for the database:**
```bash
CanSNPer2-download --database path/to/downloaded_database.db
```

**Run the analysis on FASTA files:**
```bash
CanSNPer2 --database path/to/database.db path/to/fastadir/*.fasta --summary
```
*   **Note**: The `--summary` flag is essential for generating a final result file and a colored PDF tree showing confirmed SNPs.

### 2. Creating Custom Databases
If you have a custom SNP scheme, use `CanSNPer2-database` to initialize the SQLite database.

**Required input files:**
*   `--annotation`: A text file defining SNP positions and bases.
*   `--tree`: A text file defining the phylogenetic tree structure.
*   `--reference`: A text file mapping strains to GenBank/RefSeq IDs.

**Command:**
```bash
CanSNPer2-database --database custom.db --annotation snps.txt --tree tree.txt --reference references.txt --source_type CanSNPer --create
```

## CLI Reference and Best Practices

### Essential Arguments
- `-db, --database`: Path to the SNP database file (required).
- `--summary`: Produces a comprehensive summary file and a PDF tree.
- `--save_tree`: Explicitly saves the phylogenetic tree as a PDF using ETE3.
- `-o, --outdir`: Specifies the directory for output files.
- `--min_required_hits`: Sets the minimum number of sequential hits required to call a SNP (useful for filtering noise in lower-quality assemblies).

### Operational Tips
- **Input Format**: Currently, CanSNPer2 primarily supports FASTA assemblies. While read-based input (`--read_input`) is listed in help menus, it may not be fully implemented in all versions; prefer using high-quality assemblies for reliable typing.
- **Performance**: Use `--skip_mauve` if you are re-running an analysis where the `.xmfa` alignment files have already been generated to save significant computation time.
- **Error Handling**: Use `--keep_going` when processing large batches of genomes to ensure the entire run doesn't fail if a single sample encounters an alignment error.
- **Temporary Files**: The tool generates significant intermediate data. Use `--tmpdir` to point to a high-speed scratch disk if working with many samples, and `--keep_temp` only if you need to debug alignment issues.

## Troubleshooting Common Issues
- **Missing Nodes**: If the tree output warns of missing nodes, ensure your `tree.txt` uses tab-separation rather than semicolons.
- **Database Connection**: If encountering rare SQLite connection errors, ensure the database file is not on a network drive with restrictive locking protocols.
- **ProgressiveMauve Errors**: Ensure `progressiveMauve` is in your system PATH, as it is the primary engine for the underlying whole-genome alignments.

## Reference documentation
- [CanSNPer2 GitHub Readme](./references/github_com_FOI-Bioinformatics_CanSNPer2.md)
- [CanSNPer2 Wiki Home](./references/github_com_FOI-Bioinformatics_CanSNPer2_wiki.md)