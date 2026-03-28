---
name: eagle
description: Eagle is a bioinformatics utility designed for rapid k-mer counting and genomic sequence analysis. Use when user asks to count k-mers, query sequence occurrences, or analyze k-mer distributions in genomic datasets.
homepage: https://bitbucket.org/christopherschroeder/eagle
---


# eagle

## Overview
Eagle is a specialized bioinformatics utility designed for rapid k-mer counting and genomic sequence analysis. It excels in processing massive datasets with a low memory footprint by employing efficient data structures. This skill provides the necessary command-line patterns to execute k-mer distribution analysis, count occurrences across multiple genomic files, and manage high-throughput sequencing data.

## Command Line Usage

### Basic K-mer Counting
To count k-mers in a sequencing file, use the primary count command.
```bash
eagle count -k <kmer_length> -o <output_prefix> <input.fastq>
```
*   **-k**: Specifies the length of the k-mer (typically 21, 31, or 51).
*   **-o**: Defines the prefix for the generated output files.

### Multi-threaded Processing
Eagle is optimized for multi-core systems. Always specify threads to decrease processing time.
```bash
eagle count -k 31 -t <num_threads> -o sample_output input.fastq.gz
```

### Handling Compressed Files
Eagle natively supports gzipped input files, allowing for direct processing without manual decompression.
```bash
eagle count -k 31 <(zcat reads.fastq.gz)
# Or if the version supports direct input:
eagle count -k 31 reads.fastq.gz
```

### Querying K-mer Counts
Once a database or count file is created, you can query specific sequences.
```bash
eagle query -db <database_file> -f <query_sequences.fasta>
```

## Best Practices
*   **Memory Management**: For extremely large genomes, monitor the memory usage; Eagle is efficient, but k-mer tables grow exponentially with $k$ if the genome is highly repetitive.
*   **K-mer Length Selection**: Use $k=21$ or $k=31$ for standard genomic assembly and error correction tasks. Higher $k$ values increase specificity but require more memory and higher coverage.
*   **Input Validation**: Ensure input files are in valid FASTA or FASTQ format. Eagle expects standard bioinformatics formatting.



## Subcommands

| Command | Description |
|---------|-------------|
| eagle | A command-line tool with subcommands for various operations. |
| eagle convert | Convert VCF files to other formats. |
| eagle interface | Starts the EAGLE web interface. |
| eagle meta | Manage meta information for eagle-data-files. |
| eagle_extract | Extracts regions from BAM/SAM/CRAM files based on a capture kit file. |

## Reference documentation
- [Eagle Bitbucket Repository](./references/bitbucket_org_christopherschroeder_eagle.md)
- [Bioconda Eagle Package Overview](./references/anaconda_org_channels_bioconda_packages_eagle_overview.md)