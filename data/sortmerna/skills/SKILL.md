---
name: sortmerna
description: SortMeRNA is a high-throughput tool used to filter and sort ribosomal RNA from transcriptomic sequencing data. Use when user asks to filter rRNA from reads, separate non-rRNA sequences, or manage reference databases for transcriptomic datasets.
homepage: http://bioinfo.lifl.fr/RNA/sortmerna
---


# sortmerna

## Overview

SortMeRNA is a high-throughput tool used primarily to separate ribosomal RNA (rRNA) from other types of RNA in transcriptomic datasets. It utilizes a fast local alignment algorithm based on approximate seeds to identify and sort reads against a set of reference databases. This skill provides the necessary command-line patterns to execute filtering workflows, manage reference databases, and optimize performance for large-scale sequencing projects.

## Core Usage Patterns

### Basic rRNA Filtering
To filter rRNA from a set of reads, you must provide the reference databases and the input files.

```bash
sortmerna --ref ./rRNA_databases/silva-arc-16s-id95.fasta \
          --reads ./input_reads.fastq \
          --aligned ./output/rRNA_reads \
          --other ./output/non_rRNA_reads \
          --fastx --workdir ./tmp_sortmerna
```

### Paired-End Reads
When working with paired-end data, use the `--reads` flag twice or provide a merged file. Use `--paired_in` or `--paired_out` to maintain pair integrity.

```bash
sortmerna --ref ./db1.fasta --ref ./db2.fasta \
          --reads forward.fastq --reads reverse.fastq \
          --aligned ./output/aligned_paired \
          --other ./output/filtered_paired \
          --fastx --paired_in --out2
```

### Key Parameters
- `--ref`: Path to the reference database (FASTA). Multiple references can be specified by repeating the flag.
- `--reads`: Input NGS reads (FASTA/FASTQ).
- `--aligned`: Base name for the output file containing reads that matched the reference.
- `--other`: Base name for the output file containing reads that did not match (the "filtered" data).
- `--fastx`: Output the results in the same format as the input (FASTA or FASTQ).
- `--threads`: Number of CPU threads to use (default is 2).
- `--workdir`: Directory for temporary files and indexing (highly recommended to manage disk space).

## Expert Tips

- **Indexing**: SortMeRNA requires indexed databases. If an index does not exist in the `workdir`, the tool will create one automatically. To save time in repetitive runs, point to a consistent `--workdir` where indices are already stored.
- **Memory Management**: For very large datasets, monitor the `--kvdb` (Key-Value Database) settings. If you encounter memory errors, ensure the `workdir` is on a filesystem with sufficient space and high I/O performance.
- **Database Selection**: Common databases include SILVA (16S/18S, 23S/28S), Greengenes, and RFAM. Using a concatenated reference or multiple `--ref` flags allows for comprehensive depletion in a single pass.
- **OTU Picking**: Use the `--otu_map` flag to generate an OTU table for taxonomic downstream analysis.

## Reference documentation

- [SortMeRNA Overview](./references/anaconda_org_channels_bioconda_packages_sortmerna_overview.md)