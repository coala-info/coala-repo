---
name: sourmash
description: sourmash is a versatile bioinformatics tool for searching, comparing, and analyzing genomic data through k-mer based MinHash and FracMinHash sketching.
homepage: https://github.com/sourmash-bio/sourmash
---

# sourmash

## Overview

sourmash is a versatile bioinformatics tool for searching, comparing, and analyzing genomic data through k-mer based MinHash and FracMinHash sketching. It transforms large sequence files (FASTA/FASTQ) into compact, mathematical representations called signatures. These signatures allow for extremely fast comparisons that are memory-efficient and scale to millions of sequences. It is the preferred tool for estimating similarity between datasets of different sizes and performing combinatorial k-mer searches to profile complex environmental samples.

## Core CLI Workflows

### 1. Sketching Sequences
The first step is always creating a signature from your raw data. Use `dna` for nucleotide sequences.

*   **Basic Sketching:**
    `sourmash sketch dna sample.fastq.gz`
*   **Recommended Parameters (FracMinHash):**
    Use `scaled` to enable comparisons between datasets of different sizes (e.g., a single genome vs. a metagenome).
    `sourmash sketch dna *.fq.gz -p k=21,k=31,scaled=1000 --name-from-first`
    *   `k=21`: Good for genus-level sensitivity.
    *   `k=31`: Standard for species-level identification.
    *   `scaled=1000`: Keeps 1 out of every 1000 k-mers.

### 2. Comparing Datasets
Once signatures are created, you can calculate the similarity between them.

*   **Compare multiple signatures:**
    `sourmash compare *.sig -o comparison_results.cmp`
*   **Generate a distance matrix (CSV):**
    `sourmash compare *.sig --csv distances.csv`
*   **Visualize results:**
    `sourmash plot comparison_results.cmp`

### 3. Metagenomic Profiling (Gather)
The `gather` command is the "special sauce" of sourmash. It identifies the minimum set of genomes that explain the k-mers in a metagenomic sample.

*   **Search a query against a database:**
    `sourmash gather query.sig database.sbt.zip`
*   **Output results to CSV:**
    `sourmash gather query.sig database.zip -o results.csv`

### 4. Signature Management (sig)
Use the `sig` subcommands to inspect, manipulate, and filter signature files.

*   **Inspect signature metadata:**
    `sourmash sig describe sample.sig`
*   **Merge multiple signatures into one:**
    `sourmash sig merge *.sig -o merged.sig`
*   **Filter signatures by k-size:**
    `sourmash sig filter -k 31 sample.sig -o filtered.sig`
*   **Extract specific signatures by name/pattern:**
    `sourmash sig grep "Staphylococcus" database.sig > staph.sig`

## Expert Tips and Best Practices

*   **Scaled vs. Num:** Always prefer `scaled` (FracMinHash) over `num` (MinHash) for genomic data. `scaled` allows you to compare a small query against a large database accurately, whereas `num` is only reliable for datasets of similar size.
*   **K-mer Sizes:** 
    *   Use **k=21** for broad taxonomic searches.
    *   Use **k=31** for specific species identification.
    *   Use **k=51** for strain-level differentiation.
*   **Database Formats:** sourmash supports `.zip` and `.sbt.zip` formats for databases. Using indexed databases (SBT or LCA) significantly speeds up searches against large collections like GenBank or GTDB.
*   **Memory Efficiency:** If you are running out of memory during `compare`, increase the `scaled` value (e.g., `scaled=2000`) to reduce the number of k-mers stored in the signatures.
*   **ANI Estimation:** sourmash can estimate Average Nucleotide Identity (ANI) from k-mer containment. This is much faster than traditional alignment-based methods for large-scale screening.

## Reference documentation

- [sourmash GitHub Repository](./references/github_com_sourmash-bio_sourmash.md)
- [sourmash Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sourmash_overview.md)