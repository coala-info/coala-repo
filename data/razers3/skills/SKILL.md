---
name: razers3
description: RazerS 3 is a high-sensitivity read mapper designed for aligning genomic sequences to a reference without the need for pre-built indexing. Use when user asks to map single-end or paired-end reads, perform sensitive sequence alignment with guaranteed error thresholds, or align reads to frequently changing reference sets.
homepage: https://www.seqan.de/apps/razers3.html
---


# razers3

## Overview
RazerS 3 is a versatile read mapper designed for high-sensitivity alignment of genomic sequences. Unlike many other mappers, it does not require a pre-built index of the reference genome, making it ideal for one-off mappings or working with frequently changing reference sets. It excels at handling reads of arbitrary lengths and provides a predictable tradeoff between sensitivity and runtime, allowing you to guarantee the detection of all matches within a specific error threshold.

## Common CLI Patterns

### Basic Mapping
Map single-end reads to a reference genome using default settings:
```bash
razers3 [options] <reference.fasta> <reads.fastq>
```

### Sensitivity and Error Control
RazerS 3 allows precise control over how many mismatches or indels are permitted:
- `-i <percent>`: Set the maximum allowed error rate (percent).
- `-m <number>`: Set the maximum number of matches to report for each read.
- `-rr <percent>`: Set the recognition rate (sensitivity). 100% ensures no valid matches are lost according to the Rabema definition.
- `-distance-range <int>`: Choose between Hamming distance (0) or Edit distance (1).

### Output Formats
The tool supports multiple output formats to integrate with downstream bioinformatics pipelines:
- `-o <output.sam>`: Output in SAM format (recommended for most workflows).
- `-o <output.razers>`: Use the native RazerS format.
- `-o <output.gff>`: Output in GFF format.

### Performance Optimization
Since RazerS 3 supports shared-memory parallelism, always specify the thread count on multi-core systems:
- `-tc <number>`: Set the number of threads to use.

### Paired-End Mapping
To map paired-end reads, provide both read files:
```bash
razers3 [options] <reference.fasta> <reads_1.fastq> <reads_2.fastq>
```

## Expert Tips
- **No Indexing Required**: You can run RazerS 3 directly on FASTA files. This saves disk space and setup time compared to tools like BWA or Bowtie2, though it may be slower for very large genomes.
- **Long Read Handling**: Use RazerS 3 when dealing with long reads that have high indel rates, as the banded Myers’ bit-vector algorithm is optimized for these cases.
- **Memory Management**: If running on a machine with limited RAM, monitor usage closely as the tool loads the reference and reads into memory to perform the q-gram counting and filtering.

## Reference documentation
- [RazerS 3 Application Page](./references/www_seqan_de_apps_razers3.html.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_razers3_overview.md)