---
name: agc
description: The Assembled Genomes Compressor (AGC) performs multi-genome compression of de-novo assemblies while providing rapid random access to specific sequences. Use when user asks to create compressed genome archives, append new assemblies to existing collections, extract specific samples or contigs, and list metadata from compressed datasets.
homepage: https://github.com/refresh-bio/agc
---


# agc

## Overview
The Assembled Genomes Compressor (AGC) is a specialized tool for the multi-genome compression of de-novo assemblies. Unlike general-purpose compressors, AGC leverages the high similarity between genomes in a collection to achieve massive space savings—often reducing hundreds of gigabytes to just a few gigabytes—while maintaining random access to individual samples or contigs. Use this skill to automate the creation of `.agc` archives, append new assemblies to existing collections, and perform targeted extraction of sequences without decompressing the entire dataset.

## Core Workflows

### Creating Archives
To create a new compressed collection, you must provide a reference genome followed by the target genomes.

- **Basic creation**: `agc create ref.fa sample1.fa sample2.fa > collection.agc`
- **Using an input list**: If you have many files, list them in a text file (one per line) and use the `-i` flag:
  `agc create -i file_list.txt -o collection.agc ref.fa`
- **Bacterial/Diverse data**: Use the **adaptive mode** (`-a`) for datasets with lower similarity or smaller genomes (e.g., bacteria) to optimize the compression ratio:
  `agc create -a -i bacteria_list.txt ref.fa > bacteria.agc`

### Appending Data
AGC allows adding new genomes to an existing archive without full re-compression.
- `agc append existing.agc new_sample.fa > updated.agc`
- **In-place style**: `agc append -i new_list.txt existing.agc -o updated.agc`

### Extraction and Retrieval
Extraction is the primary advantage of AGC, allowing for sub-second retrieval of specific sequences.

- **Extract specific samples**: `agc getset collection.agc sample_name1 sample_name2 > output.fa`
- **Extract specific contigs**: `agc getctg collection.agc contig_id > contig.fa`
- **Extract by genome-specific contig**: Use the `@` syntax if contig names are not unique across the archive:
  `agc getctg collection.agc contig_id@genome_id > output.fa`
- **Partial extraction**: Extract specific coordinates using the `:from-to` syntax:
  `agc getctg collection.agc contig_id:1000-5000 > fragment.fa`

### Inspection and Metadata
- **List genomes**: `agc listset collection.agc`
- **List contigs in a genome**: `agc listctg collection.agc genome_id`
- **Archive info**: `agc info collection.agc` (Displays compression parameters, stats, and the command history used to build the archive).

## Expert Tips and Best Practices
- **Reference Selection**: The first genome provided during `create` is the reference. For best compression, choose a high-quality, representative assembly as the reference.
- **Memory Management**: In version 3.2+, use the streaming mode if working in memory-constrained environments, though it may be slower than the default mode.
- **Multi-threading**: Use the `-t` parameter to specify the number of threads. AGC scales well with high core counts during compression.
- **Gzipped Input**: AGC natively supports `.fa.gz` files. You do not need to decompress them before adding them to an archive.
- **File Extensions**: While AGC often outputs to stdout, it is best practice to use the `.agc` extension for archives to distinguish them from standard compressed formats like `.gz` or `.bz2`.



## Subcommands

| Command | Description |
|---------|-------------|
| append | Assembled Genomes Compressor - append genomes to an existing archive |
| create | AGC (Assembled Genomes Compressor) - Create a compressed archive from assembled genomes in FASTA format. |
| getcol | Assembled Genomes Compressor - get collection of sequences |
| getctg | Extract contigs from an AGC (Assembled Genomes Compressor) file. Supports various formats for specifying contigs, samples, and ranges. |
| getset | Assembled Genomes Compressor - extract a set of samples from an AGC file |
| info | AGC (Assembled Genomes Compressor) - Get information about an AGC file |
| listctg | List contigs in an AGC (Assembled Genomes Compressor) file for specified samples. |
| listref | List reference genomes in an AGC (Assembled Genomes Compressor) file |
| listset | List datasets in an Assembled Genomes Compressor (AGC) file |

## Reference documentation
- [Assembled Genomes Compressor README](./references/github_com_refresh-bio_agc_blob_main_README.md)