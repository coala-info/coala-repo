---
name: crabz
description: crabz is a high-speed, parallelized tool for compressing and decompressing data across multiple CPU threads. Use when user asks to compress or decompress files, process BGZF genomic data, or perform multi-threaded gzip operations.
homepage: https://github.com/sstadick/crabz
metadata:
  docker_image: "quay.io/biocontainers/crabz:0.9.0"
---

# crabz

## Overview
crabz is a high-speed, cross-platform tool written in Rust that serves as a modern alternative to pigz. It specializes in parallelized data compression and decompression, significantly reducing processing time by distributing workloads across multiple CPU threads. It is particularly useful for handling large datasets, bioinformatics files (via BGZF), and system logs where standard single-threaded tools like gzip would be too slow.

## Common CLI Patterns

### Basic Compression and Decompression
The most frequent use cases involve standard Gzip operations.
- **Compress a file**: `crabz input.txt -o input.txt.gz`
- **Decompress a file**: `crabz -d input.txt.gz -o input.txt`
- **In-place compression**: `crabz -I data.log` (Note: This removes the original file upon completion)

### Working with Streams
crabz integrates seamlessly into shell pipelines using the `-` convention for stdin/stdout.
- **Compress from a pipe**: `cat large_file | crabz -f gzip > large_file.gz`
- **Decompress to a pipe**: `crabz -d compressed_data.gz -o - | process_script.sh`

### Format Selection
While Gzip is the default, crabz supports several high-performance formats via the `-f` flag:
- **BGZF (Blocked GNU Zip Format)**: `crabz -f bgzf genomic_data.txt` (Common in bioinformatics)
- **Snappy**: `crabz -f snap backup.tar` (Use for maximum speed when compression ratio is less critical)
- **Zlib**: `crabz -f zlib archive.dat`

## Performance Optimization

### Thread Management
By default, crabz attempts to use 32 threads. You should tune this based on your hardware:
- **Limit CPU usage**: `crabz -p 4 big_file.txt`
- **Decompression Tip**: Increasing decompression threads beyond 4 often yields diminishing returns. Stick to `-p 4` for most decompression tasks unless using specific block formats.

### CPU Pinning
For maximum performance on dedicated processing nodes, use the `-P` flag to pin threads to specific physical cores. This reduces context switching overhead.
- **Pin to first 8 cores**: `crabz -p 8 -P 0 input.file`
- **Running parallel instances**: If running two instances, offset the pins to avoid contention:
  - Instance 1: `crabz -p 4 -P 0 ...`
  - Instance 2: `crabz -p 4 -P 4 ...`

### Compression Levels
Balance speed vs. file size using the `-l` flag (1-9):
- **Fastest (Lower ratio)**: `crabz -l 1 input.file`
- **Best compression (Slower)**: `crabz -l 9 input.file`
- **Balanced (Default)**: Level 6 is the standard trade-off.

## Reference documentation
- [Main Documentation](./references/github_com_sstadick_crabz.md)