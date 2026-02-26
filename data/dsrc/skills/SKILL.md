---
name: dsrc
description: The dsrc tool provides high-efficiency compression and decompression for FASTQ files using domain-specific algorithms for genomic data. Use when user asks to compress DNA sequence reads, decompress .dsrc archives, or optimize storage for large-scale genomic datasets.
homepage: https://github.com/refresh-bio/DSRC
---


# dsrc

## Overview
The `dsrc` (DNA Sequence Reads Compressor) tool is a specialized utility designed for the efficient handling of FASTQ files. It provides significantly better compression ratios than general-purpose tools like gzip by utilizing domain-specific knowledge of DNA sequences, quality scores, and read identifiers. It is particularly useful for large-scale genomic datasets from Illumina, ABI SOLiD, and 454/Ion Torrent platforms.

## Command Line Usage

The basic syntax for `dsrc` follows a mode-based structure:
`dsrc <c|d> [options] <input> <output>`

### Core Modes
- **c**: Compress a FASTQ file into a `.dsrc` archive.
- **d**: Decompress a `.dsrc` archive back into a FASTQ file.

### Automated Compression Presets
Instead of manual tuning, use the `-m` flag to select a balance between speed and compression ratio:
- `-m0`: **Fast Mode**. Optimized for speed (equivalent to `-d0 -q0 -b8`).
- `-m1`: **Medium Mode**. Balanced approach (equivalent to `-d2 -q2 -b64`).
- `-m2`: **Best Mode**. Maximum compression (equivalent to `-d3 -q2 -b256`).

### Manual Optimization Options
- **DNA Compression (`-d<0-3>`)**: Sets the level for nucleotide sequence compression.
- **Quality Compression (`-q<0-2>`)**: Sets the level for quality score compression.
- **Lossy Quality (`-l`)**: Enables Illumina binning scheme for quality values to further reduce size.
- **ID Filtering (`-f<fields>`)**: Keep only specific fields in the ID string (e.g., `-f1,2,5`).
- **Threading (`-t<n>`)**: Specify the number of threads. By default, it uses all available hardware threads.
- **Buffer Size (`-b<n>`)**: Set the FASTQ input buffer in MB. Larger buffers (e.g., 64 or 256) generally improve compression ratios in multithreaded environments.

## Common CLI Patterns

### Standard Compression
To compress a file using default settings:
```bash
dsrc c input.fastq output.dsrc
```

### High-Efficiency Compression
For archival purposes where file size is the priority:
```bash
dsrc c -m2 -t 8 input.fastq output.dsrc
```

### Streaming with Pipes
Use the `-s` flag to read from stdin or write to stdout, allowing integration with other bioinformatics tools without intermediate disk I/O:
```bash
cat input.fastq | dsrc c -s - output.dsrc
dsrc d -s input.dsrc - | fastqc stdin
```

### Decompression
To restore the original FASTQ data:
```bash
dsrc d input.dsrc output.fastq
```

## Expert Tips
- **Integrity Checks**: Use the `-c` flag during compression to calculate and store CRC32 checksums. Note that this can slow down the compression process by approximately 50%.
- **Memory Management**: When working on shared HPC nodes, explicitly set the buffer size (`-b`) and thread count (`-t`) to stay within allocated resource limits.
- **Quality Offsets**: If the tool fails to identify the quality score encoding, manually set the offset using `-o` (e.g., `-o33` for modern Illumina data).

## Reference documentation
- [DSRC GitHub Repository](./references/github_com_refresh-bio_DSRC.md)
- [Bioconda DSRC Package](./references/anaconda_org_channels_bioconda_packages_dsrc_overview.md)