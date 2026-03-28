---
name: smafa
description: Smafa is a high-performance sequence aligner and clusterer optimized for fixed-length biological sequences. Use when user asks to cluster sequences by similarity, create a searchable sequence database, or query sequences against a database.
homepage: https://github.com/wwood/smafa
---


# smafa

## Overview
Smafa is a high-performance sequence aligner and clusterer specifically optimized for biological sequences that have already been aligned and share a uniform length. Unlike general-purpose aligners that handle variable lengths and indels, smafa leverages the fixed-length nature of its input to perform extremely fast distance computations and searches. It is primarily used within the SingleM ecosystem but is a powerful standalone tool for any workflow involving fixed-length sequence blocks.

## Installation
Smafa can be installed via Bioconda or Rust's package manager:

```bash
# Via Bioconda
conda install -c bioconda smafa

# Via Cargo
cargo install smafa
```

## Core Workflow

### 1. Database Creation
Before querying, you must initialize a database from your reference sequences. The input must be a FASTA file where every sequence is the same length.

```bash
smafa makedb reference_sequences.fasta database_output.smafa
```

### 2. Querying the Database
Once the database is created, you can search against it using a query FASTA file.

```bash
smafa query database_output.smafa query_sequences.fasta > results.tsv
```

## Expert Tips and Best Practices

- **Sequence Length Consistency**: Smafa will error if it encounters sequences of varying lengths. Ensure your preprocessing pipeline (e.g., trimming or padding) guarantees identical lengths across the entire dataset.
- **Case Sensitivity**: Modern versions of smafa support both uppercase and lowercase nucleotide symbols (A, C, G, T/U).
- **Performance**: Smafa is written in Rust and uses bitfield encoding for nucleotides, making it exceptionally fast for large-scale metagenomic datasets.
- **SingleM Integration**: If you are using smafa to troubleshoot SingleM results, remember that smafa handles the underlying "OTU" clustering logic for the marker genes.
- **Help Documentation**: For specific flag details (such as identity thresholds or output formatting), use the built-in help commands:
  - `smafa makedb --help`
  - `smafa query --help`



## Subcommands

| Command | Description |
|---------|-------------|
| smafa cluster | Cluster sequences by similarity |
| smafa makedb | Generate a searchable database |
| smafa_count | Print the number of reads/bases in a possibly gzipped FASTX file |
| smafa_query | This command searches a database for query sequences. The database must be generated with the `makedb` command. The query sequences can be in FASTA or FASTQ format. The output is a tab-separated file with the following columns: |

## Reference documentation
- [github_com_wwood_smafa.md](./references/github_com_wwood_smafa.md)
- [github_com_wwood_smafa_blob_main_README.md](./references/github_com_wwood_smafa_blob_main_README.md)
- [github_com_wwood_smafa_blob_main_Cargo.toml.md](./references/github_com_wwood_smafa_blob_main_Cargo.toml.md)