---
name: nanolyse
description: NanoLyse is a tool designed to decontaminate Nanopore sequencing datasets by removing reads that align to the lambda phage genome, a common internal control.
homepage: https://github.com/wdecoster/NanoLyse
---

# nanolyse

## Overview
NanoLyse is a tool designed to decontaminate Nanopore sequencing datasets by removing reads that align to the lambda phage genome, a common internal control. It functions as a stream processor, reading FASTQ data from standard input and writing the filtered results to standard output. By utilizing the minimap2 aligner via mappy, it efficiently identifies and discards control reads while preserving the target sequences.

## Usage Instructions

### Basic Command Structure
NanoLyse is designed to work within a command-line pipe. It does not take input file paths as positional arguments; it requires data to be piped in.

```bash
# Basic usage with uncompressed FASTQ
cat reads.fastq | NanoLyse > reads_filtered.fastq

# Standard usage with compressed FASTQ (recommended)
gunzip -c reads.fastq.gz | NanoLyse | gzip > reads_filtered.fastq.gz
```

### Filtering Against Custom References
While the default behavior targets the lambda phage genome, you can use the `-r` or `--reference` flag to filter against any specific contaminant genome (e.g., human contaminants in a microbial sample).

```bash
gunzip -c reads.fastq.gz | NanoLyse --reference contaminant_genome.fa.gz | gzip > clean_reads.fastq.gz
```

### Integration with NanoFilt
NanoLyse is often used in conjunction with `NanoFilt` to perform both contaminant removal and quality filtering in a single command string.

```bash
gunzip -c reads.fastq.gz | NanoLyse | NanoFilt -q 12 -l 500 | gzip > processed_reads.fastq.gz
```

## Best Practices and Tips

- **Performance Note**: The developer has indicated that NanoLyse is no longer actively updated because its functionality has been integrated into `chopper`, which offers better performance. If speed is a bottleneck, consider suggesting `chopper` to the user.
- **Reference Selection**: When using a custom reference with `-r`, ensure the reference file is in FASTA format (can be gzipped).
- **Data Loss Warning**: If the organism being sequenced has high genomic similarity to the lambda phage (or the custom reference provided), legitimate target reads may be erroneously removed.
- **Memory Efficiency**: Because it uses a streaming approach, NanoLyse is memory-efficient, but the alignment process still relies on the size of the reference genome provided.

## Reference documentation
- [NanoLyse GitHub Repository](./references/github_com_wdecoster_nanolyse.md)
- [NanoLyse Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanolyse_overview.md)