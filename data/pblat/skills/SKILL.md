---
name: pblat
description: pblat is a multi-threaded implementation of the Blast-Like Alignment Tool designed for high-performance genomic sequence alignment. Use when user asks to perform fast DNA or protein alignments, run BLAT with multiple CPU threads, or search large query files against a reference genome.
homepage: https://github.com/icebert/pblat
---


# pblat

## Overview
`pblat` is a performance-optimized implementation of the BLAT (Blast-Like Alignment Tool) designed for modern multi-core systems. While the original BLAT is single-threaded, `pblat` allows users to distribute the workload across multiple threads, achieving near-linear speed improvements. It is specifically designed for Linux and macOS environments and maintains the memory efficiency of the original tool, making it suitable for large-scale genomic searches where query files are substantial.

## Command Line Usage
The primary syntax for `pblat` follows the original BLAT structure but introduces the `-threads` parameter to control parallelization.

### Basic Alignment
To run an alignment using multiple threads:
`pblat -threads=8 reference.fa query.fa output.psl`

### Using Docker
If the tool is not installed locally, you can run it via Docker. Ensure you mount your local directory to the container's `/data` path:
`docker run -u $(id -u):$(id -g) -v $(pwd):/data icebert/pblat -threads=4 database.fa query.fa out.psl`

## Best Practices and Tips
- **Input Format Requirement**: Multi-threading is specifically supported when the query file is in **FASTA** format. Ensure your input is correctly formatted to see performance gains.
- **Thread Allocation**: For optimal performance, set `-threads` to match the number of available physical CPU cores. The tool is designed to reduce runtime linearly as thread count increases.
- **Memory Efficiency**: One of `pblat`'s core strengths is that it uses nearly the same amount of memory as the original single-threaded BLAT, even when using many threads. This makes it ideal for aligning against large references like the human genome on systems with limited RAM per core.
- **Platform Compatibility**: `pblat` is natively supported on Linux and Mac OS.
- **Output Consistency**: The tool ensures that the output order for translated queries remains consistent with the original BLAT results.
- **Installation**: If building from source, simply run `make` in the source directory to generate the `pblat` executable.

## Reference documentation
- [pblat Main Repository](./references/github_com_icebert_pblat.md)