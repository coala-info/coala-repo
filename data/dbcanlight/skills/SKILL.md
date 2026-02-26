---
name: dbcanlight
description: dbcanlight identifies Carbohydrate-Active Enzymes (CAZymes) and their potential substrates within protein sequence datasets using optimized HMM and DIAMOND searches. Use when user asks to build dbCAN databases, search for CAZyme families, predict enzyme substrates, or summarize search results into a consolidated table.
homepage: https://github.com/chtsai0105/dbcanLight/tree/main
---


# dbcanlight

## Overview
dbcanlight is a lightweight, performance-optimized rewrite of the `run_dbcan` tool. It is designed to identify CAZymes and their potential substrates within protein sequence datasets. Unlike the original tool, dbcanlight uses `pyhmmer` for faster multithreading and automatically handles large input files without requiring manual splitting. It follows a modular workflow: building databases, searching sequences, and concluding with a consolidated summary.

## Core Workflow

### 1. Database Initialization
Before running searches, you must download and process the required dbCAN databases. This module handles HMM pressing and DIAMOND index building automatically.

```bash
# Download and prepare databases in $HOME/.dbcanlight
dbcanlight build
```

### 2. Sequence Searching
The `search` module supports three distinct modes. Results are output as TSV files (`cazymes.tsv`, `substrates.tsv`, or `diamond.tsv`).

*   **CAZyme HMM Search**: Identifies CAZyme families.
*   **Substrate HMM Search**: Predicts potential substrates.
*   **DIAMOND Search**: Fast protein-to-protein alignment.

**Common Patterns:**
```bash
# Standard CAZyme search with 8 threads
dbcanlight search -i input.faa -m cazyme -t 8 -o output_dir

# Substrate search with custom thresholds
dbcanlight search -i input.faa -m sub -e 1e-20 -c 0.4 -o output_dir

# DIAMOND search for fast annotation
dbcanlight search -i input.faa -m diamond -t 16 -o output_dir
```

### 3. Result Summarization
The `conclude` module gathers outputs from at least two different search modes to provide a final summary table.

```bash
# Generate summary from the output directory containing .tsv files
dbcanlight conclude output_dir
```

## Expert Tips and Optimization

### Handling Massive Datasets
When processing metagenomes with >1,000,000 sequences, use the blocksize (`-b`) parameter to prevent memory exhaustion. This processes sequences in batches.

```bash
# Process in batches of 50,000 sequences
dbcanlight search -i large_metagenome.faa -m cazyme -b 50000 -t 16
```

### Parsing External HMMER3 Results
If you have already run `hmmsearch` using the standard HMMER3 CLI, use the standalone parsers to format the data for dbCAN compatibility.

*   **dbcanlight-hmmparser**: Filters overlapped hits (>50% overlap) and converts `domtblout` to 10-column dbCAN format.
*   **dbcanlight-subparser**: Maps HMM profiles to specific substrates using the conversion table.

```bash
# Parse standard HMMER output
dbcanlight-hmmparser -i external_hmm.out -o parsed_hits.tsv

# Map parsed hits to substrates
dbcanlight-subparser -i parsed_hits.tsv -o substrate_mapping.tsv
```

### Default Thresholds
dbcanlight uses empirically validated defaults from the dbCAN project. Only adjust these if specific sensitivity is required:
*   **HMM (cazyme/sub)**: E-value < 1e-15, Coverage > 0.35
*   **DIAMOND**: E-value < 1e-102, Coverage > 0.35

## Reference documentation
- [dbcanlight GitHub Repository](./references/github_com_chtsai0105_dbcanlight.md)