---
name: genmap
description: GenMap computes the mappability and uniqueness of genomic sequences by calculating how often k-mers appear in a genome with a specified number of mismatches. Use when user asks to quantify sequence uniqueness, build a genome index for mappability analysis, or identify repetitive and unique regions in a FASTA file.
homepage: https://github.com/cpockrandt/genmap
---


# genmap

## Overview

GenMap is a high-performance tool designed to quantify the uniqueness of genomic sequences. It calculates the (k, e)-mappability for every position in a genome, which represents how many times a k-mer of length *k* appears in the sequence allowing for up to *e* mismatches. A mappability value of 1.0 indicates a unique region, while lower values signify repetitive elements. This tool is particularly useful for filtering variant calls in "unmappable" regions or for any task requiring high-confidence sequence specificity.

## Core Workflow

### 1. Building the Index
Before computing mappability, you must create an index of your FASTA file(s). This is a one-time operation per genome.

```bash
genmap index -F /path/to/genome.fasta -I /path/to/index_folder
```

**Expert Tips for Indexing:**
*   **Algorithm Selection (`-A`):** 
    *   `divsufsort` (Default): Fastest, but requires significant RAM (approx. 6x to 10x the genome size).
    *   `skew`: Uses secondary memory (disk). Slower but essential if you are RAM-constrained.
*   **Memory Management (`-S`):** Increase the sampling value (e.g., `-S 20`) to reduce the index size and RAM usage during construction, though this will slightly slow down the subsequent mapping step.
*   **Multiple Genomes:** To index a collection of genomes, use `-FD /path/to/folder/` to index all FASTA files in a directory.

### 2. Computing Mappability
Once the index is built, compute the mappability by specifying the k-mer length (*K*) and allowed mismatches (*E*).

```bash
genmap map -K 30 -E 2 -I /path/to/index_folder -O /path/to/output_folder -t -w -bg
```

**Parameter Guide:**
*   `-K`: K-mer length (e.g., 30-150 for typical NGS reads).
*   `-E`: Number of allowed mismatches (errors). Note: High *E* values significantly increase computation time.
*   **Output Formats:**
    *   `-t`: Plain text file.
    *   `-w`: Wiggle (WIG) format, ideal for genome browsers.
    *   `-bg`: bedGraph format, efficient for large-scale visualization.
    *   `-fl`: Output frequency (number of occurrences) instead of mappability (1/frequency).
    *   `--csv`: Generates a detailed CSV listing exactly where every k-mer maps.

## Advanced Usage

### Multi-Genome Analysis
When working with multiple indexed files, GenMap counts occurrences across the entire set.
*   **Species Specificity:** Use `--exclude-pseudo` to count how many *files* (genomes) a k-mer appears in, rather than the total number of occurrences. This is useful for finding k-mers unique to a specific strain or shared across a genus.

### Handling Ambiguous Bases
GenMap supports nucleotide sequences (A, C, G, T/U, N). Any other IUPAC ambiguous characters (like R, Y, S) are automatically converted to 'N' during indexing.

### Performance Optimization
*   **Reverse Strand:** By default, GenMap searches both strands.
*   **Temporary Files:** If using the `skew` algorithm or running out of space, redirect temporary files using the `TMPDIR` environment variable:
    ```bash
    export TMPDIR=/path/to/large_disk/tmp
    ```

## Reference documentation
- [GenMap GitHub README](./references/github_com_cpockrandt_genmap.md)
- [GenMap Wiki](./references/github_com_cpockrandt_genmap_wiki.md)