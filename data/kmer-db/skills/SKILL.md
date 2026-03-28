---
name: kmer-db
description: kmer-db is a high-performance bioinformatics tool for estimating genomic similarities and distances using k-mer counting and MinHash-based dimensionality reduction. Use when user asks to build a k-mer database, compare genomic sequences without alignment, or calculate Jaccard similarity indices between large datasets.
homepage: https://github.com/refresh-bio/kmer-db
---


# kmer-db

## Overview
kmer-db is a high-performance bioinformatics utility designed to handle massive genomic datasets by representing them as sets of k-mers. It is particularly effective for estimating similarities between thousands of genomes without the need for traditional sequence alignment. The tool leverages SIMD extensions (AVX2/NEON) to accelerate the counting of common k-mers and supports MinHash-based dimensionality reduction to reduce memory footprints while maintaining high accuracy in distance estimations.

## Core CLI Patterns

### Database Construction
Building a database is the first step for any analysis. You can create a new database or extend an existing one.

- **Standard Build**:
  `kmer-db build <input_list> <output_db>`
  *Note: `<input_list>` should be a text file containing paths to FASTA/FASTQ files.*

- **Custom K-mer Size and Sampling**:
  `kmer-db build -k 25 -f 0.1 -t 16 <input_list> <output_db>`
  *`-k`: K-mer length (default 18).*
  *`-f`: Fraction of k-mers to retain (0.1 = 10% sampling via MinHash).*
  *`-t`: Number of threads.*

- **Updating a Database**:
  `kmer-db build -extend <new_sequences_list> <existing_db>`

### Sequence Comparison
Once a database is built, you can compare new sequences against it or perform internal comparisons.

- **New Sequences vs. Database (new2all)**:
  `kmer-db new2all <database> <query_list> <output_csv>`
  *Outputs a matrix of common k-mer counts between query sequences and database entries.*

- **Internal Database Comparison (all2all)**:
  `kmer-db all2all <database> <output_csv>`
  *Computes common k-mer counts for every pair within the database.*

- **Single Sequence Query (one2all)**:
  `kmer-db one2all <database> <query_fasta> <output_csv>`

### Distance and Similarity Estimation
Convert raw k-mer counts into biological metrics.

- **Jaccard Index**:
  `kmer-db distance jaccard <counts_csv> <output_jaccard>`
  *Calculates the Jaccard similarity coefficient ($J = \frac{|A \cap B|}{|A \cup B|}$).*

## Expert Tips
- **Memory Management**: For extremely large datasets, use the `-f` parameter (MinHash) during the `build` step. A fraction of 0.01 to 0.1 is often sufficient for accurate Jaccard estimation while significantly reducing RAM usage.
- **Sparse Mode**: When dealing with many partial databases, use `all2all-parts` with a list of database files to trigger sparse computation mode, which is more efficient for non-overlapping datasets.
- **Input Formatting**: Ensure your `.list` files contain absolute paths or paths relative to the execution directory to avoid "file not found" errors during the build process.
- **Alphabet Support**: As of v2.3.1, the tool supports amino acid alphabets for protein-level k-mer analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Building a database |
| kmer-db all2all | Counting common k-mers for all the samples in the database |
| kmer-db all2all-parts | Counting common k-mers for all the samples in the database parts (sparse computation) |
| kmer-db all2all-sp | Counting common k-mers for all the samples in the database (sparse computation) |
| kmer-db distance | Calculating similarities/distances on the basis of common k-mers |
| kmer-db one2all | Counting common kmers between single sample and all the samples in the database |
| kmer-db_new2all | Counting common kmers between set of new samples and all the samples in the database |
| minhash | Storing minhashed k-mers |

## Reference documentation
- [Kmer-db GitHub README](./references/github_com_refresh-bio_kmer-db_blob_master_README.md)
- [Kmer-db Quick Start Guide](./references/github_com_refresh-bio_kmer-db_blob_master_quick-start.sh.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_kmer-db_overview.md)