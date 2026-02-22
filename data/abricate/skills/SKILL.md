---
name: abricate
description: ABRicate is a command-line tool designed for the rapid identification of acquired antibiotic resistance and virulence genes within DNA contigs.
homepage: https://github.com/tseemann/abricate
---

# abricate

## Overview

ABRicate is a command-line tool designed for the rapid identification of acquired antibiotic resistance and virulence genes within DNA contigs. It functions by screening assembly files (FASTA, Genbank, or EMBL) against a variety of integrated databases. This skill provides the necessary procedural knowledge to execute screenings, manage databases, and aggregate results into presence/absence matrices. Note that ABRicate detects acquired genes via DNA-to-DNA search and is not intended for detecting point mutations or analyzing raw FASTQ reads.

## Usage and CLI Patterns

### Database Management
Before running an analysis, verify available databases and their synchronization status.
- **List databases**: `abricate --list` (Shows sequences, type, and last update date).
- **Check dependencies**: `abricate --check` (Ensures BLAST+ and any2fasta are functional).
- **Update/Download**: `abricate-get_db --db [dbname] --force` (Forces a fresh download of the specified database).

### Screening Contigs
ABRicate accepts single files, multiple files, or a "File of File Names" (FOFN).
- **Basic screening**: `abricate assembly.fasta > results.tab`
- **Specify a database**: `abricate --db card assembly.fasta` (Default is `ncbi`).
- **Batch processing**: `abricate *.fna > combined_results.tab`
- **Using a FOFN**: `abricate --fofn list_of_files.txt`

### Generating Summaries
To compare gene presence across multiple samples, use the summary mode.
- **Create matrix**: `abricate --summary results.tab > summary.tab`
- **Identity-based matrix**: `abricate --summary --identity results.tab` (Uses %IDENTITY instead of %COVERAGE in the matrix).

## Expert Tips and Best Practices

- **Input Formats**: ABRicate uses `any2fasta` internally. You can provide gzipped (`.gz`) or bzipped (`.bz2`) files directly without manual decompression.
- **Filtering Thresholds**: The default thresholds are 80% identity and 80% coverage. Adjust these for stricter or more relaxed searching:
  - `abricate --minid 95 --mincov 95 assembly.fasta`
- **Output Interpretation**:
  - **GAPS**: If the GAPS column shows values (e.g., 1/4), the hit might be a pseudogene or contain a frameshift.
  - **COVERAGE_MAP**: Use this visual representation in the TSV output to quickly identify if a gene is fragmented across contig boundaries.
- **Performance**: Use the `--threads [N]` flag to speed up BLAST+ searches on multi-core systems.
- **Suppression**: Use `--quiet` to suppress status messages to stderr, which is useful when piping output to other tools.

## Reference documentation
- [ABRicate GitHub Repository](./references/github_com_tseemann_abricate.md)
- [Bioconda ABRicate Package](./references/anaconda_org_channels_bioconda_packages_abricate_overview.md)