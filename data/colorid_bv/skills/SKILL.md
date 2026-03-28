---
name: colorid_bv
description: colorid_bv manages and queries large-scale genomic datasets using a Bit-Vector based BIGSI implementation for rapid k-mer similarity inference. Use when user asks to build a BIGSI index, search sequences against an index, identify the taxonomic origin of reads, or filter genomic datasets.
homepage: https://github.com/hcdenbakker/colorid_bv
---

# colorid_bv

## Overview
The `colorid_bv` skill provides a specialized workflow for managing and querying large-scale genomic datasets using a Bit-Vector based BIGSI implementation. This tool is essential for researchers needing to rapidly identify the presence of specific genes or sequences across hundreds or thousands of unassembled genomes. It excels at k-mer similarity inference and read classification, allowing for efficient taxonomic filtering and isolate identification without the need for full genome assembly.

## Core Workflows

### 1. Building a BIGSI Index
Before searching, you must index your reference sequences.
- **Reference File Format**: Create a tab-delimited file (`ref_list.txt`) where each line is: `Accession_Name /path/to/fasta`.
- **Standard Build**:
  `colorid_bv build -r ref_list.txt -b index_name -k 31 -s 50000000 -n 4 -c 4`
- **High-Performance Build**: Use the `-t` flag for multi-threading:
  `colorid_bv build -r ref_list.txt -b index_name -k 21 -s 30000000 -n 2 -t 24 -c 24`

### 2. Searching Sequences
Search query files (FASTQ/FASTA) against a built index.
- **General Search**:
  `colorid_bv search -b index_name -q query_1.fastq.gz -r query_2.fastq.gz`
- **Gene Presence Interrogation**: Use `-g` for imperfect matches (reports k-mer proportions) or `-s` for fast perfect matches.
  `colorid_bv search -b index_name -q gene_of_interest.fasta -g`
- **Multi-fasta Query**: Use `-m` to treat each entry in a multi-fasta file as a separate query.

### 3. Read Classification and Filtering
Identify the taxonomic origin of individual reads.
- **Identify Reads**:
  `colorid_bv read_id -b index_name -q query.fastq.gz --prefix output_prefix`
- **Optimization**: Use `-H` (High Memory Load) to load the index into RAM (requires ~2x index size) for significantly faster processing.
- **False Positive Correction**: Adjust `-p` (default 3) for larger datasets to maintain accuracy.

## Expert Tips and Best Practices
- **K-mer Selection**: Use `k=31` for species-level identification and mixed samples. Use `k=21` for specific gene searches in cleaner datasets to increase sensitivity.
- **Index Sizing**: The `-s` parameter (Bloom filter size) and `-n` (number of hashes) are critical. For complex metagenomes, increase these to lower the false positive rate.
- **Memory Management**: If the system has sufficient RAM, always use the `-H` flag during `read_id` operations to avoid slow disk I/O.
- **Batch Processing**: When using `read_id`, the default batch size is 50,000 reads. Adjust with `-c` based on available CPU threads.



## Subcommands

| Command | Description |
|---------|-------------|
| colorid_bv batch_id | classifies batch of samples reads |
| colorid_bv build | builds a bigsi |
| colorid_bv info | dumps index parameters and accessions |
| colorid_bv merge | merges (concatenates) indices |
| colorid_bv read_filter | filters reads |
| colorid_bv read_id | id's reads |
| colorid_bv search | does a bigsi search on one or more fasta/fastq.gz files |

## Reference documentation
- [colorid_bv README](./references/github_com_hcdenbakker_colorid_bv_blob_master_README.md)
- [Reference File Example](./references/github_com_hcdenbakker_colorid_bv_blob_master_ref_file_example.txt.md)