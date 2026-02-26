---
name: csblast
description: CS-BLAST performs protein sequence searches using context-specific amino acid substitution matrices to increase sensitivity for finding distant evolutionary relationships. Use when user asks to search protein databases for remote homologs, generate context-specific profiles, or perform sensitive sequence alignments.
homepage: http://wwwuser.gwdg.de/~compbiol/data/csblast/
---


# csblast

## Overview
CS-BLAST extends the standard BLAST algorithm by using context-specific amino acid substitution matrices. It increases sensitivity by a factor of two or more compared to standard BLAST, reaching levels comparable to profile-based methods like PSI-BLAST while maintaining similar speed. It is particularly effective for searching single protein sequences against large databases to find distant evolutionary relationships.

## Command Line Usage

### Basic Search
The primary workflow involves generating a context-specific profile from a query sequence and then searching a database.

```bash
# 1. Generate a context-specific profile (.csi) from a query fasta
csblast -i query.fasta -o query.csi -p

# 2. Search a database using the generated profile
csblast -i query.csi -d database_path -o results.txt
```

### Common Options
- `-i <file>`: Input query sequence (FASTA) or profile (.csi).
- `-d <database>`: Path to the BLAST-formatted protein database.
- `-o <file>`: Output file for results or profiles.
- `-p`: Generate a context-specific profile (required for the first step of sensitive searches).
- `-e <double>`: Expectation value (E-value) threshold (default: 10.0).
- `-m <int>`: Alignment view options (0-11, similar to standard BLAST).

### Expert Tips
- **Database Preparation**: CS-BLAST uses standard NCBI BLAST databases. Ensure your database is formatted using `makeblastdb` before running `csblast`.
- **Sensitivity vs. Speed**: For maximum sensitivity, use the `-p` flag to generate a profile. If speed is the absolute priority and remote homology is not expected, standard BLAST may be used, but CS-BLAST is generally preferred for protein sequences.
- **Library Files**: CS-BLAST relies on context-specific mutation matrices (usually `.crf` files). Ensure the environment variable `CSBLAST_LIB` is set to the directory containing these library files if they are not in the default path.

## Reference documentation
- [csblast - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_csblast_overview.md)
- [Index of /~compbiol/data/csblast](./references/wwwuser_gwdguser_de__compbiol_data_csblast.md)