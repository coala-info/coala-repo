---
name: metacache
description: MetaCache is a specialized classification system designed to map genomic sequences from metagenomic samples to their most likely taxon of origin.
homepage: https://github.com/muellan/metacache
---

# metacache

## Overview

MetaCache is a specialized classification system designed to map genomic sequences from metagenomic samples to their most likely taxon of origin. It utilizes locality-sensitive hashing to identify candidate regions within reference genomes, providing a balance between the speed of k-mer based methods and significantly reduced memory requirements. It supports both CPU and multi-GPU acceleration, making it suitable for processing hundreds of millions of reads against massive databases like the full NCBI RefSeq.

## Installation and Setup

Install via Bioconda for the most stable CPU version:
```bash
conda install bioconda::metacache
```

To build from source for GPU support or custom configurations:
1. Clone the repository: `git clone https://github.com/muellan/metacache.git`
2. Compile for CPU: `make -j`
3. Compile for GPU: Follow specific CUDA instructions in the documentation.

## Database Management

### Building the Standard RefSeq Database
Use the provided helper script to automate the download and construction of a database containing bacterial, viral, and archaeal genomes:
```bash
./metacache-build-refseq
```

### Handling Large Databases with Limited RAM
If the system has less than 128GB of RAM, use database partitioning to split the reference into manageable chunks:
```bash
./metacache-partition-genomes <input_genomes> <output_dir>
```

### Inspecting Databases
Verify the contents and configuration of an existing MetaCache database:
```bash
./metacache-db-info <database_path>
```

## Querying and Classification

### Basic Classification
Map a single FASTA or FASTQ file against a built database:
```bash
./metacache query <database_name> <input_reads.fa> -out <results.txt>
```

### Processing Directories
Classify all supported files within a specific folder:
```bash
./metacache query <database_name> <input_folder> -out <results.txt>
```

### Paired-End Reads
Handle paired-end data using the appropriate flag based on file structure:
- **Separate files**: `./metacache query <db> R1.fq R2.fq -pairfiles -out <results.txt>`
- **Interleaved file**: `./metacache query <db> interleaved.fq -pairseq -out <results.txt>`

## Post-Processing and Visualization

### Summarizing Results
Generate a taxonomic abundance summary from the raw classification output:
```bash
./summarize-results <results.txt>
```

### Creating Krona Plots
Transform abundance data into an interactive Krona visualization:
```bash
python3 krona-from-abundances.py <abundance_file> -o <output.html>
```

## Expert Tips and Best Practices

- **Memory Optimization**: If working with a small number of targets (under 65,535), recompile with `make MACROS="-DMC_TARGET_ID_TYPE=uint16_t"` to save memory.
- **Large Scale Targets**: For databases exceeding 4.2 billion reference sequences, recompile using `uint64_t` for the target ID type.
- **Compressed Input**: MetaCache supports gzipped files (`.gz`) natively only if compiled with zlib. If `make` fails to find zlib, use `make MC_ZLIB=NO`, but note that you must then provide uncompressed input files.
- **K-mer Length**: The default k-mer size limit is 16. For longer k-mers (up to 32), recompile with `MACROS="-DMC_KMER_TYPE=uint64_t"`.
- **Consistency**: A database must be queried using the same MetaCache variant (same data type sizes) used during the build process.

## Reference documentation
- [MetaCache GitHub Repository](./references/github_com_muellan_metacache.md)
- [Bioconda MetaCache Overview](./references/anaconda_org_channels_bioconda_packages_metacache_overview.md)