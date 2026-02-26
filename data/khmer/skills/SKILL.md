---
name: khmer
description: khmer is a suite of command-line tools that uses memory-efficient probabilistic data structures to process and streamline DNA shotgun sequencing data. Use when user asks to perform digital normalization, filter reads by k-mer abundance, partition metagenomic graphs, or interleave paired-end reads.
homepage: https://khmer.readthedocs.io/
---


# khmer

## Overview
The khmer software is a specialized suite of command-line tools designed to streamline the assembly and analysis of DNA shotgun sequencing data. By utilizing probabilistic data structures like Bloom filters and Count-Min Sketches, khmer allows for memory-efficient processing of genomes, transcriptomes, and metagenomes. It is most effective when used to "slim down" massive datasets through digital normalization or to isolate independent biological components via graph partitioning before assembly.

## Core CLI Patterns and Best Practices

### Memory Management
The most critical parameter in khmer is `-M` (or `--max-memory-usage`). Since khmer uses fixed-size hash tables without collision detection, providing insufficient memory leads to high false-positive rates.
- **Rule of thumb**: Set `-M` to the maximum available RAM on your machine (e.g., `-M 32e9` for 32GB).
- **Small counts**: Use `--small-count` to reduce memory if you only need to know if a k-mer exists or has a low count (counts capped at 255).

### Digital Normalization
Use `normalize-by-median.py` to reduce the coverage of high-depth regions to a specified cutoff, which speeds up assembly without losing unique information.
- **Standard usage**: `normalize-by-median.py -k 20 -C 20 -M 4e9 -o norm.fastq input.fastq`
- **Paired-end data**: Always use the `--paired` flag if your reads are interleaved to ensure both mates are kept or discarded together.

### Abundance Filtering and Error Trimming
Remove likely sequencing errors by filtering out low-abundance k-mers.
- **Two-step process**:
  1. Build the countgraph: `load-into-counting.py -k 20 -M 4e9 counts.ct input.fastq`
  2. Filter reads: `filter-abund.py counts.ct input.fastq`
- **Variable coverage**: For transcriptomes or metagenomes, use the `-V` flag in `filter-abund.py` to avoid stripping low-depth biological signal.

### Metagenomic Partitioning
For complex metagenomes, use partitioning to split reads into disjoint sets that do not share k-mers.
- **Workflow**:
  1. `load-graph.py -k 32 -M 20e9 graph.ht input.fastq`
  2. `partition-graph.py graph.ht`
  3. `merge-partition.py graph`
  4. `extract-partitions.py input.fastq graph`

### Read Handling Utilities
- **Interleaving**: `interleave-reads.py forward.fq reverse.fq > interleaved.fq`
- **Splitting**: `split-paired-reads.py interleaved.fq`
- **Conversion**: `fastq-to-fasta.py input.fq -o output.fa`

## Expert Tips
- **K-mer Size**: For most applications, a k-size between 20 and 32 is optimal. Graph-based operations (partitioning) are generally limited to $k \le 32$.
- **Compression**: khmer scripts natively handle `.gz` and `.bz2` files. You do not need to decompress data before processing.
- **Threaded Loading**: Use `-T` with `load-into-counting.py` to parallelize the initial table construction.
- **Bigcount**: By default, khmer stops counting at 255. If you need exact high-abundance counts, ensure you do **not** use the `-b` or `--no-bigcount` flag.

## Reference documentation
- [khmer's command-line interface](./references/khmer_readthedocs_io_en_latest_user_scripts.html.md)
- [Introduction to khmer](./references/khmer_readthedocs_io_en_latest_introduction.html.md)
- [Installing and running khmer](./references/khmer_readthedocs_io_en_latest_user_install.html.md)