---
name: dbcan
description: The dbcan skill facilitates the automated annotation of CAZymes from sequence data.
homepage: http://bcb.unl.edu/dbCAN2/
---

# dbcan

## Overview
The dbcan skill facilitates the automated annotation of CAZymes from sequence data. It utilizes the `run_dbcan` pipeline to compare input sequences against the dbCAN database using multiple search algorithms (HMMER, DIAMOND, and dbCAN-PUL). This tool is essential for researchers studying carbohydrate metabolism, biomass degradation, and glycan biosynthesis in bacteria, fungi, and archaea.

## Command Line Usage
The primary command for the standalone tool is `run_dbcan`.

### Basic Syntax
```bash
run_dbcan [input_fasta] [input_type] --out_dir [output_directory]
```

### Input Types
Specify the type of input sequence to ensure correct processing:
- `protein`: For proteome sequences (amino acids).
- `prok`: For prokaryotic genomes (DNA; will trigger gene prediction via Prodigal).
- `meta`: For metagenomic sequences (DNA; will trigger gene prediction via FragGeneScan).

### Common Options
- `--db_dir`: Path to the dbCAN database files (essential if not in default location).
- `--dia_cpu`: Number of CPUs for DIAMOND searches.
- `--hmm_cpu`: Number of CPUs for HMMER searches.
- `--tools`: Specify which tools to run (e.g., `hmmer`, `diamond`, `dbcanpulp`, `all`).

## Best Practices
- **Database Preparation**: Ensure the dbCAN database is downloaded and formatted using the `test_dbcan` or setup scripts provided with the installation before running annotations.
- **Output Interpretation**: Focus on the `overview.txt` file in the output directory. This file summarizes results from all tools; CAZyme hits supported by multiple tools (e.g., HMMER + DIAMOND) are generally considered high-confidence.
- **E-value Thresholds**: The default E-value is typically 1e-15 with a coverage > 0.35 for HMMER. Adjust these using `--hmm_eval` and `--hmm_cov` if you require higher sensitivity or specificity.
- **Subfamily Annotation**: Use the latest version of the database to benefit from dbCAN-sub, which provides higher resolution classification into CAZyme subfamilies.

## Reference documentation
- [dbcan Overview](./references/anaconda_org_channels_bioconda_packages_dbcan_overview.md)