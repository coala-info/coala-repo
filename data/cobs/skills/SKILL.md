---
name: cobs
description: COBS is a specialized indexing tool that enables rapid membership queries of k-mers across large-scale sequencing datasets. Use when user asks to construct a bit-sliced signature index, query DNA sequences against multiple experiments, or search for k-mer membership in genomic data.
homepage: https://panthema.net/cobs
metadata:
  docker_image: "quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0"
---

# cobs

## Overview
COBS is a specialized indexing tool designed for bioinformatics that allows for rapid membership queries of k-mers across thousands of experiments. Unlike traditional Bloom filter indices, COBS uses a bit-sliced signature index that is more compact and provides faster query performance. It is particularly effective for searching large-scale sequencing data where you need to determine which datasets contain a specific sequence or set of k-mers.

## Core CLI Patterns

### Index Construction
To build an index from a set of FASTA/FASTQ files:
```bash
cobs construct -i <input_directory> -o <output_index.cobs_classic> -k <kmer_size> -f <false_positive_rate>
```
- Use `.cobs_classic` for the standard index format.
- The `-k` parameter (default 31) defines the k-mer length.
- The `-f` parameter (default 0.3) controls the false positive rate per document.

### Querying the Index
To search for a DNA sequence within a constructed index:
```bash
cobs query -i <index_file.cobs_classic> -s <query_sequence> -t <threshold>
```
- The `-t` threshold (0.0 to 1.0) determines the minimum fraction of k-mers from the query that must match a document for it to be reported.
- For batch queries, provide a file containing sequences: `cobs query -i <index> -f <query_file.fasta>`.

### Compact Indexing
For even smaller memory footprints, use the compact construction mode which adapts the number of hash functions per document:
```bash
cobs construct -i <input_dir> -o <output.cobs_compact> --compact
```

## Expert Tips
- **Memory Mapping**: COBS uses `mmap` for queries. This means you can query indices larger than your RAM, as the OS handles paging.
- **K-mer Selection**: Ensure the k-mer size used during construction matches the k-mer size used during queries.
- **False Positives**: While a default FPR of 0.3 seems high, the probability of a long sequence (many k-mers) matching by chance is exponentially lower.
- **Preprocessing**: For best results, ensure input files are cleaned of low-complexity sequences or sequencing adapters before indexing.



## Subcommands

| Command | Description |
|---------|-------------|
| cobs benchmark-fpr | Calculate false positive distribution for COBS |
| cobs classic-combine | Combines multiple COBS indices into a single index. |
| cobs classic-construct | Constructs a COBS index for a given input directory or file. |
| cobs classic-construct-random | Constructs a random COBS index. |
| cobs compact-construct | Constructs a COBS compact index. |
| cobs compact-construct-combine | Constructs and combines compact indexes from input directory to output file. |
| cobs doc-dump | Dump documents from a path |
| cobs doc-list | list documents |
| cobs generate-queries | Generates positive and negative queries from base documents. |
| cobs print-kmers | Prints all k-mers of a given DNA sequence. |
| cobs print-parameters | Prints parameters for COBS. |
| cobs query | Query the COBS index |

## Reference documentation
- [COBS: A Compact Bit-Sliced Signature Index](./references/panthema_net_cobs.md)
- [Bioconda COBS Package Overview](./references/anaconda_org_channels_bioconda_packages_cobs_overview.md)