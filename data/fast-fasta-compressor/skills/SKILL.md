---
name: fast-fasta-compressor
description: Fast FASTA Compressor is a high-throughput utility designed to efficiently compress and decompress genomic data in FASTA format. Use when user asks to compress DNA sequences, decompress .ffc files, or integrate fasta compression into bioinformatics pipelines using streams.
homepage: https://github.com/kowallus/ffc
---


# fast-fasta-compressor

## Overview
The Fast FASTA Compressor (FFC) is a specialized utility designed for speed and efficiency in genomic data management. It excels at compressing non-redundant DNA sequences by packing nucleotides into bytes, while automatically switching to a zstd-based adaptive mode for redundant data like viral strains. It is particularly useful in bioinformatics pipelines because it supports standard input/output streams and maintains high throughput (often exceeding 1500 MB/s) even on standard hardware.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::fast-fasta-compressor
```

## Core Usage Patterns

### Basic Compression
Compress a FASTA file to the default `.ffc` format:
```bash
ffc -i input.fa -o output.ffc
```
*Tip: If `-o` is omitted, it defaults to `input.fa.ffc`.*

### Basic Decompression
Restore the original FASTA file:
```bash
ffc -d -i input.ffc -o output.fa
```

### Pipeline Integration (Stdin/Stdout)
Use a single hyphen `-` to stream data through FFC without creating intermediate files:
```bash
cat genome.fa | ffc -i - -o genome.ffc
ffc -d -i genome.ffc -o - | some_bioinformatics_tool
```

## Performance Tuning

### Thread Management
FFC is multi-threaded. By default, it uses 12 threads for compression and 4 for decompression. Adjust this based on your CPU availability:
```bash
ffc -i large.fa -t 16
```

### Compression Levels
The tool uses an "adaptive" mode by default. For specific needs, you can manually set the zstd backend level (0-22):
- **Level 0**: No zstd compression (fastest, nucleotide packing only).
- **Level 1-4**: Recommended for most redundant datasets (good balance).
- **Level 22**: Maximum compression (extremely slow).

```bash
ffc -i viral_strains.fa -l 3
```

### Block Size
FFC processes data in blocks (default is 2^22 bytes / 4 MiB). 
- **Larger blocks** (`-b 24` to `-b 30`): Improve compression ratios on highly redundant data (e.g., large bacterial genome collections) but increase memory usage.
- **Smaller blocks**: Reduce memory footprint.

```bash
ffc -i pangenome.fa -b 25
```

## Expert Tips
- **Lossless Guarantee**: FFC preserves irregular End-of-Line (EOL) locations and all IUPAC ambiguity codes, making it safe for strict archival purposes.
- **Force Overwrite**: Use the `-f` flag to overwrite existing output files without prompting.
- **Memory Efficiency**: Because FFC works on blocks, memory usage remains stable regardless of the total file size, provided the block size (`-b`) and thread count (`-t`) are kept at reasonable levels.

## Reference documentation
- [Fast FASTA Compressor (FFC) Overview](./references/github_com_kowallus_ffc.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fast-fasta-compressor_overview.md)