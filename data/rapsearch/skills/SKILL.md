---
name: rapsearch
description: RAPSearch2 performs high-speed protein similarity searches using a reduced amino acid alphabet to align query sequences against a reference database. Use when user asks to index a protein database, perform a fast protein similarity search, or align translated nucleotide queries against a protein index.
homepage: https://github.com/zhaoyanswill/RAPSearch2
metadata:
  docker_image: "quay.io/biocontainers/rapsearch:2.24--1"
---

# rapsearch

## Overview
RAPSearch2 (Reduced Alphabet based Protein similarity Search) is a specialized tool for identifying protein similarities at high speeds. By utilizing a reduced amino acid alphabet, it significantly reduces the computational overhead compared to traditional BLAST while maintaining comparable sensitivity for many applications. The workflow involves a pre-processing step to index a reference database and a search step to align query sequences against that index.

## Database Preparation
Before searching, you must convert a FASTA protein database into the RAPSearch binary format using `prerapsearch`.

- **Basic Indexing**:
  `prerapsearch -d <database.fasta> -n <output_db_name>`
- **Memory Optimization**:
  For extremely large databases (e.g., NCBI nr) on systems with limited RAM, use the `-s` flag to split the database into smaller chunks during the indexing process.

## Similarity Search
The `rapsearch` command performs the alignment. It supports both protein and translated nucleotide queries.

- **Standard Search**:
  `rapsearch -q <query.fasta> -d <db_name> -o <output_prefix> -z <threads>`
- **Output Formats**:
  - `.m8`: Tabular format (similar to BLAST `-m 8`). **Note**: The E-value column contains `log10(E-value)`.
  - `.aln`: Detailed pairwise alignments.
- **Performance Tuning**:
  - Use `-z` to specify the number of CPU threads.
  - Use `-e` to set the `log10(E-value)` threshold (default is 1, which equals an E-value of 10).
  - Use `-b 0` to suppress the generation of the `.aln` file if only tabular results are needed.
  - Use `-v` to limit the number of database sequences reported.

## Advanced CLI Patterns
- **Piping Input**:
  Integrate into pipelines by reading from stdin:
  `cat query.fasta | rapsearch -q stdin -d db_name -o output`
- **Streaming Output**:
  To output the tabular results directly to stdout for downstream processing without creating a file:
  `rapsearch -q query.fasta -d db_name -u 1`

## Reference documentation
- [RAPSearch2 README](./references/github_com_zhaoyanswill_RAPSearch2.md)