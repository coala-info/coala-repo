---
name: downpore
description: Downpore is a high-speed suite of tools for processing long-read sequencing data during genome assembly and consensus. Use when user asks to trim adapters or barcodes, de-multiplex sequencing reads, align reads to a reference, or find overlaps for genomic assembly.
homepage: https://github.com/jteutenberg/downpore
---


# downpore

## Overview

`downpore` is a specialized suite of tools written in Go, designed to handle the heavy lifting of genome assembly and consensus. It excels at processing long-read sequencing data, offering high-speed alternatives to common bioinformatics tasks. Its primary strengths lie in its efficient k-mer based trimming engine, which identifies and removes adapters or barcodes, and its mapping and overlapping modules which facilitate the reconstruction of genomic sequences.

## General Usage

The tool follows a standard command-line structure:
`downpore <command> [arguments]`

To discover available arguments for any specific module, use:
`downpore help <command>`

### Input Requirements
- **Formats**: Supports FASTA, FASTQ, and GZIP-compressed versions (.gz).
- **Sequence Content**: Only DNA sequences (A, C, G, T) are accepted.
- **Formatting**: FASTA files must have sequences on a single line; multi-line sequences are not supported and must be linearized before processing.

## Command: trim

The `trim` module is used to clean reads by removing adapters and barcodes. It is significantly faster than Porechop and can split chimeric reads where adapters are found internally.

### Basic Trimming
```bash
downpore trim -i reads.fastq -f adapters_front.fasta -b adapters_back.fasta > trimmed.fastq
```

### De-multiplexing
To sort reads into separate files based on barcodes (adapters named starting with "Barcode"):
```bash
downpore trim -i reads.fastq -f barcodes.fasta --demultiplex ./output_dir --tag_adapters true
```

### Performance Optimization
- **Multi-threading**: Use `--num_workers <N>` to specify the number of threads for index building.
- **Memory**: Use `--himem true` to cache input reads in memory for faster processing if RAM allows.

## Command: map and overlap

These modules are used for sequence alignment and assembly preparation.

- **map**: Align reads to a reference genome.
- **overlap**: Find overlaps between reads to facilitate de novo assembly.

Both modules utilize seed selection and chaining algorithms similar to Minimap2 but are optimized within the `downpore` ecosystem.

## Expert Tips and Best Practices

- **Internal Adapters**: By default, `downpore` is conservative with internal adapters. If an adapter is found in the middle of a read, the read is split, and both sides are treated as potentially "bad" (trimmed) to ensure high-quality output.
- **Barcode Precision**: If you encounter ambiguous barcodes (two barcodes within 5% identity), `downpore` will refrain from writing adapter labels to the read header to prevent misassignment.
- **K-mer Tuning**: If demultiplexing a very large number of barcodes is slow, increase the k-mer size using the `-k` argument to improve search efficiency.
- **Edge Sensitivity**: The trimmer is specifically tuned for high recall within the first and last 150 bases of a read, where adapters are most likely to reside.



## Subcommands

| Command | Description |
|---------|-------------|
| downpore_align | Aligns sequences using dynamic time warping. |
| downpore_consensus | Generates a consensus sequence from multiple input sequences using dynamic time warping. |
| downpore_kmers | Compute k-mers from a FASTQ file. |

## Reference documentation
- [README.md](./references/github_com_jteutenberg_downpore_blob_master_README.md)
- [downpore.go](./references/github_com_jteutenberg_downpore_blob_master_downpore.go.md)