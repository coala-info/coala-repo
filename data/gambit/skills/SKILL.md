---
name: gambit
description: "GAMBIT rapidly classifies bacterial isolates by comparing genomic assemblies against a reference database using an efficient distance metric. Use when user asks to identify bacterial species, calculate genomic distance matrices, or construct hierarchical clustering trees from assemblies."
homepage: https://github.com/jlumpe/gambit
---

# gambit

## Overview

GAMBIT (Genomic Approximation Method for Bacterial Identification and Tracking) is a high-performance bioinformatics tool designed for the rapid classification of bacterial isolates. It leverages an efficient genomic distance metric to compare query assemblies against a curated database of approximately 50,000 reference genomes derived from NCBI RefSeq. Beyond simple identification, GAMBIT allows users to compute pairwise distance matrices and construct hierarchical clustering trees, making it a versatile tool for both clinical diagnostics and genomic epidemiology.

## Core Instructions and Best Practices

### 1. Database Configuration
GAMBIT requires a reference database consisting of two files: a `.gdb` (database) and a `.gs` (signatures) file.
- **Environment Variable**: Set `GAMBIT_DB_PATH` to the directory containing these files to avoid using the `-d` flag in every command.
- **Manual Flag**: If the environment variable is not set, provide the path before the subcommand:
  `gambit -d /path/to/database/ query genome.fasta`

### 2. Taxonomic Identification (query)
The `query` command is the primary tool for identifying unknown bacterial assemblies.
- **Basic Usage**: `gambit query genome1.fasta genome2.fasta`
- **Output Formats**: Use `-o` to specify a filename. GAMBIT defaults to CSV, but also supports JSON for more detailed results (including the list of closest reference genomes).
- **Batch Processing**: You can pass multiple FASTA files or a text file containing a list of paths.
- **Gzipped Input**: GAMBIT natively supports gzipped FASTA files (`.fasta.gz`).

### 3. Distance Matrices and Trees
For comparative genomics, use the `dist` and `tree` subcommands.
- **Distance Calculation**: `gambit dist -o distances.csv *.fasta`
- **Tree Generation**: Generate a Newick-format tree from a distance matrix:
  `gambit tree distances.csv -o phylogeny.nwk`

### 4. Managing Signatures
Signatures are the k-mer representations of genomes used for distance calculations.
- **Pre-calculating Signatures**: If you plan to query the same genomes multiple times, create a signature file (`.gs`) first to save time:
  `gambit signatures create -o query_sigs.gs *.fasta`
- **Querying with Signatures**: Use the created `.gs` file as input for a query:
  `gambit query query_sigs.gs`

### 5. Performance Optimization
- **Parallelism**: Use the `-p` or `--cores` option (available in newer versions) to specify the number of CPU cores for signature calculation and distance matrix computation.
- **Memory Management**: GAMBIT is designed to be memory-efficient by reading reference signatures in chunks, but ensure your system has enough RAM when processing very large batches of query genomes.

## Expert Tips
- **ID Stripping**: GAMBIT automatically strips directory paths and extensions from input files to create clean IDs in the output.
- **Taxonomic Thresholds**: Pay attention to the "next_taxon" attribute in JSON output; it indicates the next most specific taxon for which the identification threshold was not met, which can be useful for borderline classifications.
- **K-mer Specs**: When creating signatures manually, ensure the `-k` (k-mer size) and `--prefix` parameters match those used in your reference database (typically the RefSeq curated defaults).



## Subcommands

| Command | Description |
|---------|-------------|
| gambit dist | Calculate the GAMBIT distances between a set of query geneomes and a set of reference genomes. |
| gambit query | Predict taxonomy of microbial samples from genome sequences. |
| gambit tree | Estimate a relatedness tree for a set of genomes and output in Newick format. |

## Reference documentation
- [GAMBIT README](./references/github_com_jlumpe_gambit_blob_master_README.md)
- [GAMBIT Changelog](./references/github_com_jlumpe_gambit_blob_master_CHANGELOG.md)