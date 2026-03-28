---
name: fq
description: The fq utility is a command-line tool designed for the efficient validation, filtering, and subsampling of FASTQ biological sequence files. Use when user asks to validate FASTQ file integrity, filter reads by name or sequence pattern, or subsample datasets to a specific record count or probability.
homepage: https://github.com/stjude-rust-labs/fq
---


# fq

## Overview

The `fq` utility is a Rust-based command-line tool designed for efficient processing of FASTQ files, which are the standard format for biological sequence data. It excels at three primary tasks:
1. **Validation (lint)**: Ensuring files follow the FASTQ specification and that paired-end files remain synchronized.
2. **Filtering**: Extracting reads based on an allowlist of names or regular expression patterns in the sequences.
3. **Subsampling**: Creating smaller, representative datasets using either a target record count or a sampling probability.

It natively supports both raw and gzipped (`.gz`) inputs, making it a lightweight alternative to heavier bioinformatics suites for initial data QC and manipulation.

## Core CLI Patterns

### Validating FASTQ Files (lint)
Use `lint` to check for common errors like mismatched sequence/quality lengths, duplicate names, or corrupted file structures.

*   **Basic validation**: `fq lint r1.fq.gz r2.fq.gz`
*   **Non-stop logging**: To see all errors instead of stopping at the first one:
    `fq lint --lint-mode log r1.fq r2.fq`
*   **Custom separators**: If your headers use non-standard characters to separate the ID from the description:
    `fq lint --record-definition-separator ":" r1.fq`
*   **Disabling specific checks**: Use the validator codes (e.g., S007 for DuplicateName) to skip specific tests:
    `fq lint --disable-validator S007 r1.fq`

### Filtering Records
The `filter` command requires a destination (`--dsts`) and a condition.

*   **By Name**: Provide a text file containing one record name per line.
    `fq filter --names allowlist.txt --dsts out.fq in.fq`
*   **By Sequence Pattern**: Keep reads matching a regex (e.g., starting with a specific barcode).
    `fq filter --sequence-pattern ^GATTACA --dsts filtered.fq in.fq`
*   **Paired-end Filtering**: When filtering pairs, the match is determined by the first file (R1), and the corresponding record is kept/dropped in both.
    `fq filter --sequence-pattern ^ATG --dsts out.1.fq --dsts out.2.fq in.1.fq in.2.fq`

### Subsampling Datasets
Useful for creating "light" versions of datasets for pipeline testing.

*   **Exact Count**: Get exactly 10,000 records.
    `fq subsample -n 10000 --r1-dst out.1.fq --r2-dst out.2.fq in.1.fq in.2.fq`
*   **By Probability**: Keep approximately 10% of reads (faster for very large files as it only requires one pass).
    `fq subsample -p 0.1 --r1-dst out.fq in.fq`
*   **Deterministic Sampling**: Use a seed to ensure the same subset is generated every time.
    `fq subsample -n 5000 --seed 42 --r1-dst out.fq in.fq`

## Expert Tips

*   **Gzip Handling**: `fq` automatically detects gzipped input. For output, if you want compressed files, ensure your destination path ends in `.gz` or pipe the output to `gzip`.
*   **Validation Levels**: Use `--single-read-validation-level` or `--paired-read-validation-level` with values `low`, `medium`, or `high` to trade off between strictness and execution speed.
*   **Exit Codes**: In `lint --lint-mode log`, the tool will still return a non-zero exit code if any errors were found, allowing it to be used reliably in shell scripts.



## Subcommands

| Command | Description |
|---------|-------------|
| fq subsample | Outputs a subset of records |
| fq_filter | Filters a FASTQ file |
| fq_generate | Generates a random FASTQ file pair |
| lint | Validates a FASTQ file pair |

## Reference documentation
- [fq README and Usage Guide](./references/github_com_stjude-rust-labs_fq_blob_master_README.md)
- [fq Changelog and Version History](./references/github_com_stjude-rust-labs_fq_blob_master_CHANGELOG.md)