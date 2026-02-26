---
name: nanospring
description: NanoSpring is a specialized tool for the reference-free compression of Oxford Nanopore Technologies sequencing data. Use when user asks to compress ONT FASTQ files, decompress NanoSpring archives, or archive genomic sequences without quality scores.
homepage: https://github.com/qm2/NanoSpring
---


# nanospring

## Overview

NanoSpring is a specialized compression tool tailored for Oxford Nanopore Technologies (ONT) sequencing data. It utilizes MinHash-based clustering and Minimap2-based reference-free alignment to achieve high compression ratios for genomic sequences. Note that NanoSpring is designed to compress only the read sequences; it intentionally ignores quality values and read identifiers to maximize space savings. This makes it an excellent choice for long-term archival of sequence data where the raw sequence is the primary asset.

## Installation and Setup

The most reliable way to access NanoSpring is via Bioconda:

```bash
conda install -c bioconda nanospring
```

If installed via Conda, the executable is invoked as `NanoSpring`. If built from source, use `./NanoSpring`.

## Common CLI Patterns

### Basic Compression
Compress a standard FASTQ file or a gzipped FASTQ file using the default 20 threads:

```bash
NanoSpring -c -i input.fastq -o output.NanoSpring
NanoSpring -c -i input.fastq.gz -o output.NanoSpring
```

### Decompression
Restore the sequences from a `.NanoSpring` archive:

```bash
NanoSpring -d -i output.NanoSpring -o restored.reads
```

### Resource Management
Adjust thread count and memory limits based on your environment:

```bash
# Use 8 threads for a smaller workstation
NanoSpring -c -i input.fastq -o output.NanoSpring -t 8

# Limit peak memory usage during decompression to 10GB
NanoSpring -d -i output.NanoSpring -o restored.reads --decompression-memory 10
```

## Expert Tips and Best Practices

### Lossless Verification
Since NanoSpring only stores sequences, you cannot use a simple `diff` against the original FASTQ. To verify the integrity of the compressed sequences, compare the decompressed output against the second line of every four-line block in the original FASTQ:

```bash
cmp restored.reads <(cat input.fastq | sed -n '2~4p')
```

### Tuning Compression Ratios
For specific datasets, you can tune the MinHash and Minimap2 parameters to balance speed and compression:
- **K-mer Size**: Use `-k` (default 23) to adjust the MinHash k-mer size.
- **Minimap2 Window**: Use `--minimap-w` (default 50) to change the window size for alignment.
- **Edge Threshold**: For very high-coverage datasets, increasing `--edge-thr` (default 4,000,000) may improve the consensus graph construction at the cost of memory.

### Temporary Files
NanoSpring creates temporary files during the compression process. If your `/tmp` directory is small or on a slow disk, specify a different working directory:

```bash
NanoSpring -c -i input.fastq -o output.NanoSpring -w /path/to/large_scratch_disk/
```

## Reference documentation
- [NanoSpring Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanospring_overview.md)
- [NanoSpring GitHub Repository](./references/github_com_qm2_NanoSpring.md)