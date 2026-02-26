---
name: ncbi-blast-plus
description: NCBI BLAST+ compares biological sequences to identify regions of local similarity and infer functional or evolutionary relationships. Use when user asks to retrieve sequences from NCBI, create custom BLAST databases, or perform sequence searches using tools like blastn and blastp.
homepage: https://github.com/ncbi/blast_plus_docs
---


# ncbi-blast-plus

## Overview
The Basic Local Alignment Search Tool (BLAST+) is a suite of command-line applications used to compare biological sequences. It identifies regions of local similarity between a query sequence and a database, calculating statistical significance to help infer functional and evolutionary relationships. This skill focuses on the native CLI usage of BLAST+, particularly when deployed via the official `ncbi/blast` Docker image, which ensures a reproducible and platform-independent analytical environment.

## Core CLI Workflows

### 1. Sequence Retrieval
Use the `efetch` utility (part of the E-utilities included in the BLAST+ image) to download sequences from NCBI databases.

```bash
# Retrieve a protein sequence in FASTA format
docker run --rm ncbi/blast efetch -db protein -format fasta -id [ACCESSION_ID] > query.fsa
```

### 2. Creating Custom Databases
Before running a search against local data, you must transform FASTA files into a BLAST-formatted database using `makeblastdb`.

```bash
docker run --rm \
  -v $(pwd)/fasta:/blast/fasta:ro \
  -v $(pwd)/blastdb_custom:/blast/blastdb_custom:rw \
  -w /blast/blastdb_custom \
  ncbi/blast \
  makeblastdb -in /blast/fasta/input.fsa -dbtype [prot|nucl] \
  -parse_seqids -out db_name -title "Database Title" -blastdb_version 5
```
*   **-dbtype**: Use `prot` for amino acids or `nucl` for nucleotides.
*   **-parse_seqids**: Recommended to enable retrieval of sequences by ID.
*   **-blastdb_version 5**: The current standard version for BLAST databases.

### 3. Running Sequence Searches
The most common search applications are `blastp` (protein-protein) and `blastn` (nucleotide-nucleotide).

```bash
docker run --rm \
  -v $(pwd)/blastdb:/blast/blastdb:ro \
  -v $(pwd)/queries:/blast/queries:ro \
  -v $(pwd)/results:/blast/results:rw \
  ncbi/blast \
  blastp -query /blast/queries/query.fsa -db [db_name] -out /blast/results/output.txt
```

## Expert Tips and Best Practices

### Volume Mounting Strategy
When using Docker, always use absolute paths for volume mounting (`-v`). 
*   Mount input data (databases, queries) as read-only (`:ro`).
*   Mount output directories as read-write (`:rw`).
*   Use the `-w` flag to set the working directory inside the container to simplify file path references in the command.

### Performance Optimization
*   **Thread Count**: Use the `-num_threads` parameter to speed up searches on multi-core systems.
*   **Search Sensitivity**: For `blastn`, remember that `megablast` is the default. It is optimized for finding very similar sequences (e.g., intraspecies). For more divergent sequences, switch to `blastn` or `discontiguous-megablast` using the `-task` parameter.

### Database Management
*   **Metadata**: Version 5 databases include metadata files. When transferring databases, ensure all constituent files (e.g., .pdb, .phr, .pin, .pjs, .pot, .psq, .ptf, .pto) are moved together.
*   **Taxonomy**: Use the `-taxid` flag during `makeblastdb` to associate sequences with specific NCBI Taxonomy IDs, enabling downstream taxonomic filtering.

## Reference documentation
- [Official NCBI BLAST+ Docker Image Documentation](./references/github_com_ncbi_blast_plus_docs_blob_master_README.md)