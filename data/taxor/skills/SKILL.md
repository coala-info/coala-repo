---
name: taxor
description: Taxor is a bioinformatics tool designed for fast, memory-efficient taxonomic assignment and profiling using hierarchical indexing. Use when user asks to build a k-mer index, search DNA sequences against a reference database, or generate taxonomic abundance profiles.
homepage: https://github.com/JensUweUlrich/Taxor
---

# taxor

## Overview
Taxor is a specialized bioinformatics tool designed for fast and space-efficient taxonomic assignment. It leverages an optimized hierarchical indexing structure (HIXF) to store k-mers, allowing for low false-positive rates and a significantly smaller memory footprint compared to traditional classifiers. It is ideal for workflows involving large reference sets (like RefSeq or GenBank) and requires precise classification by combining k-mer similarity with genome coverage analysis.

## Core Workflows

### 1. Building a Database Index
The `build` command creates the HIXF index required for searching.

**Input File Requirements:**
You must provide a tab-separated (TSV) file with the following 6 columns:
1. Assembly Accession (e.g., GCF_000002495.2)
2. NCBI Taxonomy ID
3. FTP Path (used to derive file names)
4. Organism Name
5. Taxonomy String (k__;p__;...)
6. Taxonomy ID String (semicolon-separated IDs)

**Execution Pattern:**
```bash
taxor build \
    --input-file taxonomy_info.tsv \
    --input-sequence-dir ./fasta_files/ \
    --output-filename my_index.hixf \
    --threads 8 \
    --kmer-size 22 \
    --syncmer-size 12 \
    --use-syncmer
```

### 2. Searching Sequences
The `search` command queries DNA sequences (FASTA/FASTQ) against the generated `.hixf` index.

*   **Input**: A sequence file and the pre-built index.
*   **Output**: Search results containing k-mer matches and similarity scores.

### 3. Taxonomic Profiling
The `profile` command processes search results to generate abundance reports.

*   **EM Algorithm**: Taxor uses an Expectation-Maximization algorithm to reassign reads that match multiple taxa.
*   **Abundance**: It provides both taxonomic and sequence abundance, corrected for genome size.

## Expert Tips and Best Practices

*   **Syncmer Selection**: Always use the `--use-syncmer` flag for large databases. This enables open canonical syncmers, which significantly reduces the index size on disk and in memory without a major loss in sensitivity.
*   **Parameter Constraints**: When using syncmers, both `--kmer-size` and `--syncmer-size` must be **even numbers**. The syncmer size must always be smaller than the k-mer size (max k=30, max s=26).
*   **File Naming**: Ensure the file stems of your FASTA files in the `--input-sequence-dir` exactly match the last part of the FTP path provided in column 3 of your input TSV.
*   **Memory Optimization**: Taxor is designed to be more memory-efficient than tools like Kraken2. If working on a machine with limited RAM, prioritize using the pre-built HIXF indices for Viruses or RefSeq ABFV.
*   **Long-Read Advantage**: While Taxor works for various lengths, its scoring system (combining k-mer similarity and genome coverage) is specifically optimized to reduce false positives in long-read datasets (Oxford Nanopore/PacBio).



## Subcommands

| Command | Description |
|---------|-------------|
| taxor | This program must be invoked with one of the following subcommands: - build - search - profile See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser. |
| taxor | This program must be invoked with one of the following subcommands: build, search, profile. See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser. |
| taxor | This program must be invoked with one of the following subcommands: build, search, profile. See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser. |
| taxor | This program must be invoked with one of the following subcommands: - build - search - profile See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser. |
| taxor-build | Creates an HIXF index of a given set of fasta files |

## Reference documentation
- [Taxor GitHub Repository Overview](./references/github_com_JensUweUlrich_Taxor_blob_main_README.md)
- [Taxor Docker Configuration](./references/github_com_JensUweUlrich_Taxor_blob_main_Dockerfile.md)