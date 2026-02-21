---
name: kart
description: Kart is an ultra-efficient NGS read mapper that employs a divide-and-conquer strategy.
homepage: https://github.com/hsinnan75/Kart
---

# kart

## Overview
Kart is an ultra-efficient NGS read mapper that employs a divide-and-conquer strategy. By separating reads into simple regions and those requiring gapped alignment, it maintains high speed regardless of read length. It is highly tolerant of sequencing errors and is optimized for both standard Illumina short reads and longer, more error-prone sequences like those from PacBio systems.

## Installation
The most reliable way to install Kart is via Bioconda:
```bash
conda install bioconda::kart
```

## Indexing a Reference Genome
Before mapping, you must create a BWT-based index of your reference FASTA file.
```bash
# Syntax: kart index <reference.fa> <index_prefix>
kart index reference.fa hg38_index
```
*Note: This creates several files starting with the specified prefix.*

## Mapping Reads
Kart supports various input configurations and output formats.

### Standard Paired-End Mapping (SAM)
```bash
kart -i hg38_index -f read1.fq -f2 read2.fq -o output.sam
```

### Direct BAM Output
To save disk space and skip manual conversion, use the `-bo` flag for compressed BAM output.
```bash
kart -i hg38_index -f read1.fq -f2 read2.fq -bo output.bam
```

### Handling Long Reads (PacBio)
When working with PacBio data, use the `-pacbio` flag to optimize the alignment algorithm for higher error rates and long-read characteristics.
```bash
kart -i hg38_index -f pacbio_reads.fq -pacbio -bo output.bam
```

### Interleaved Paired-End Reads
If your paired-end reads are in a single file (interleaved), use the `-p` flag.
```bash
kart -i hg38_index -p interleaved_reads.fq -bo output.bam
```

## Parameter Best Practices
- **Threads**: Use `-t` to specify the number of threads. The default is 16. For high-performance clusters, match this to your allocated CPU cores.
- **Multiple Inputs**: You can provide multiple files to `-f` and `-f2` simultaneously.
  ```bash
  kart -i index -f r1_a.fq r1_b.fq -f2 r2_a.fq r2_b.fq -o out.sam
  ```
- **Memory/Performance**: Kart is designed to process long reads as fast as short reads. If performance stalls, ensure your index prefix includes the full directory path if the index is not in the current working directory.
- **Input Formats**: 
  - FASTQ files can be gzipped (`.fq.gz` or `.fastq.gz`).
  - FASTA files must be uncompressed.
  - Ensure read sequences use capital letters for optimal processing.

## Troubleshooting
- **Unexpected Characters**: If your read data contains non-standard IUPAC characters, ensure you are using version 2.5.6 or later, which includes fixes for unexpected character handling.
- **Exit Codes**: Kart uses exit code 1 for errors. If a command fails, check the terminal output for "Error" messages rather than "Warning" messages.

## Reference documentation
- [Kart GitHub Repository](./references/github_com_hsinnan75_Kart.md)
- [Kart Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kart_overview.md)