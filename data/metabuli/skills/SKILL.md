---
name: metabuli
description: Metabuli is a metagenomic classifier that performs taxonomic profiling by simultaneously analyzing DNA and amino acid sequences using a metamer k-mer structure. Use when user asks to classify metagenomic reads, build custom reference databases, refine classification results, or extract reads assigned to specific taxonomic IDs.
homepage: https://github.com/steineggerlab/Metabuli
---


# metabuli

## Overview

Metabuli is a specialized metagenomic classifier that utilizes a novel k-mer structure called a "metamer." By analyzing both DNA and amino acid (AA) sequences simultaneously, it achieves high sensitivity for homology detection through AA conservation while maintaining high specificity via DNA mutations. It is designed to be resource-efficient, capable of running on standard laptops by adhering to user-specified RAM limits.

## Installation

The recommended way to install Metabuli is via Bioconda:

```bash
conda install -c conda-forge -c bioconda metabuli
```

## Database Management

Before classification, you must obtain or build a reference database.

### Downloading Pre-built Databases
Use the `databases` workflow to fetch standard datasets (RefSeq or GTDB):

```bash
# Usage: metabuli databases <DB_NAME> <OUTDIR> <TMPDIR>
metabuli databases RefSeq_virus ./db ./tmp
```

Available database names: `RefSeq_virus`, `RefSeq`, `GTDB`, `RefSeq_release`.

### Building Custom Databases
To build a database from your own FASTA files:
1. **NCBI-based**: Requires access to NCBI taxonomy files (`names.dmp`, `nodes.dmp`).
2. **GTDB-based**: Uses GTDB taxonomy.

```bash
metabuli build <reference_fasta> <taxonomy_dir> <db_dir> [options]
```

## Classification Patterns

The `classify` command is the primary entry point for taxonomic profiling.

### Common CLI Workflows

**Paired-End Reads (Default)**
```bash
metabuli classify read_1.fq read_2.fq db_dir out_dir job_id
```

**Single-End Reads**
```bash
metabuli classify --seq-mode 1 read.fq db_dir out_dir job_id
```

**Long Reads (Nanopore/PacBio)**
```bash
metabuli classify --seq-mode 3 read.fq db_dir out_dir job_id
```

### Performance and Accuracy Tuning

*   **Memory Control**: Use `--max-ram` to prevent the process from exceeding system limits (e.g., `--max-ram 8GiB`).
*   **Input Validation**: Use `--validate-input 1` to ensure FASTA/Q files are not corrupted before starting long runs.
*   **Sensitivity**: Adjust `--min-score` (minimum score for classification) and `--min-sp-score` (minimum score for species-level assignment) to filter low-confidence hits.
*   **Parallelization**: Use `--threads` to specify CPU usage (defaults to all available cores).

## Post-Processing

### Refining Results
Use the `classifiedRefiner` module to improve the precision of the initial classification:
```bash
metabuli classifiedRefiner <classify_out_dir> <db_dir> <job_id>
```

### Extracting Specific Reads
To extract reads assigned to a specific TaxID for downstream analysis:
```bash
metabuli extract <classify_out_dir> <input_reads> <tax_id> <output_file>
```

## Best Practices

1.  **Preprocessing**: Always run quality control and adapter trimming (e.g., using `fastp`) before running Metabuli.
2.  **RAM Management**: If running on a shared cluster or a laptop, explicitly set `--max-ram` to avoid OOM (Out of Memory) errors.
3.  **Taxonomy Compatibility**: Ensure your taxonomy dump files match the database version. When using custom databases, `taxonkit` can be used to prepare compatible taxonomy files.
4.  **Validation**: For large-scale production runs, use `--validate-db` once to ensure the reference database integrity.

## Reference documentation

- [Metabuli GitHub Repository](./references/github_com_steineggerlab_Metabuli.md)
- [Metabuli Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metabuli_overview.md)