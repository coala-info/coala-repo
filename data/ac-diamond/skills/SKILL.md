---
name: ac-diamond
description: AC-DIAMOND is a high-performance sequence alignment tool optimized for aligning DNA reads or contigs against protein reference databases using enhanced SIMD parallelization. Use when user asks to build a protein database, align DNA sequences to protein references, or convert DAA alignment files into tabular or SAM formats.
homepage: https://github.com/Maihj/AC-DIAMOND
---

# ac-diamond

## Overview
AC-DIAMOND (Accelerated DIAMOND) is a high-performance sequence alignment tool that improves upon DIAMOND v0.7.9 through enhanced SIMD parallelization and compressed indexing. It is specifically optimized for aligning DNA reads or contigs against protein reference databases, offering a 6-7x speed increase while maintaining comparable sensitivity levels.

## Core Workflow

### 1. Database Construction (`makedb`)
Before alignment, you must create a formatted database from a protein FASTA file.

**Fast Mode:**
```bash
./ac-diamond makedb --in reference.fa -d db_name -b 4
```

**Sensitive Mode:**
```bash
./ac-diamond makedb --in reference.fa -d db_name --sensitive -b 4
```
*   `--in`: Path to protein reference database (FASTA).
*   `-d`: Path for the output AC-DIAMOND database.
*   `-b`: Block size in billions of sequence letters (default is 4).

### 2. Sequence Alignment (`align`)
Align DNA queries against the protein database. The primary output is a DAA (DIAMOND Alignment Archive) file.

```bash
./ac-diamond align -d db_name -q query.fa -a output_prefix -e 0.001 -z 6 -t /tmp
```
*   `-q`: Path to query input (FASTA/FASTQ).
*   `-a`: Output file prefix (will append `.daa`).
*   `-e`: Maximum e-value to keep an alignment (default 0.001).
*   `-z`: Query sequence block size in billions of letters.
*   `-t`: Temporary directory for storage.
*   `--sensitive`: Use this flag if the database was built with the sensitive option.

### 3. Result Visualization (`view`)
Convert the binary DAA file into human-readable formats like BLAST tabular or SAM.

```bash
./ac-diamond view -a output_prefix.daa -o results.m8 -f tab
```
*   `-f`: Output format (`tab` for BLAST tabular, `sam` for SAM format).
*   `--compress`: Set to `1` to gzip the output.

## Search Modes
*   **Fast Mode**: The default setting, optimized for maximum throughput.
*   **Sensitive-2 Mode**: Provides higher sensitivity for divergent sequences. Requires the `--sensitive` flag during both `makedb` and `align` steps.
*   **Sensitive-1 Mode**: A hybrid pipeline that runs Fast mode first and then uses Sensitive-2 mode for the remaining unaligned queries. This is typically executed via the `scripts/sensitive1_search.sh` script.

## Expert Tips & Performance
*   **Temporary Storage**: For maximum performance, point the `--tmpdir` (`-t`) to a RAM-backed file system like `/dev/shm`.
*   **Thread Management**: Use `-p` to specify the number of CPU threads. It defaults to the maximum available, but limiting it can be useful in shared environments.
*   **Memory Tuning**: If you encounter memory issues, decrease the block size (`-b` for reference, `-z` for query).
*   **Scoring**: You can override e-value filtering by using `--min-score` to set a hard bit-score threshold.



## Subcommands

| Command | Description |
|---------|-------------|
| ac-diamond | AC-DIAMOND is a tool for aligning DNA query sequences against a protein reference database, featuring database building, alignment, and viewing capabilities. |
| ac-diamond | AC-DIAMOND is a tool for aligning DNA query sequences against a protein reference database, building databases, and viewing alignment archives. |
| ac-diamond | AC-DIAMOND: A tool for building databases, aligning DNA sequences against protein databases, and viewing alignment archives. |
| ac-diamond align | Align DNA query sequences against a protein reference database |
| ac-diamond makedb | Build AC-DIAMOND database from a FASTA file |
| ac-diamond view | View AC-DIAMOND alignment archive (DAA) formatted file |

## Reference documentation
- [AC-DIAMOND README](./references/github_com_Maihj_AC-DIAMOND_blob_master_README.rst.md)