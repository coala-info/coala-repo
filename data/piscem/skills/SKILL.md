---
name: piscem
description: Piscem is a high-performance tool for genomic indexing and read mapping using a compacted colored de Bruijn graph. Use when user asks to build a genomic index, map bulk RNA-seq reads, or perform single-cell read mapping to generate RAD files.
homepage: https://github.com/COMBINE-lab/piscem
---


# piscem

## Overview
Piscem is a high-performance, memory-efficient tool written in Rust designed for the next generation of genomic indexing and read mapping. It constructs a compacted colored de Bruijn graph and provides a fast mapper for both bulk and single-cell sequencing data. It is a key component in modern bioinformatics pipelines, often serving as the upstream mapper for quantification tools like alevin-fry.

## System Preparation
Before running piscem, ensure your environment is configured to handle the large number of file descriptors required during the indexing phase:

```bash
# Increase the file handle limit to at least 2048
ulimit -n 2048
```

**Hardware Note:** Pre-compiled binaries require the BMI2 instruction set (Intel Haswell/AMD Excavator or newer). If running on older hardware, piscem must be compiled from source using `NO_BMI2=TRUE cargo build --release`.

## Indexing Reference Sequences
The `build` command creates a piscem index from FASTA files.

### Common CLI Pattern
```bash
piscem build -k 31 -m 19 -t 8 -o index_prefix -s reference.fa
```

### Key Parameters
- `-k, --klen`: The k-mer size for the de Bruijn graph (default is often 31).
- `-m, --mlen`: The minimizer length used for the sshash data structure.
- `-t, --threads`: Number of threads. **Expert Tip:** On Apple Silicon, set this to the number of high-performance cores only; using efficiency cores can significantly degrade performance.
- `-s, --ref-seqs`: Comma-separated list of FASTA files.
- `-d, --ref-dirs`: Comma-separated list of directories containing FASTA files.

## Mapping Reads
Piscem supports specialized mapping modes for different sequencing protocols.

### Single-Cell Mapping (`map-sc`)
Used to produce RAD (Reduced Alignment Data) files for processing with `alevin-fry`.

```bash
piscem map-sc -i index_prefix -g <GEOMETRY> -1 read1.fq.gz -2 read2.fq.gz -t 16 -o output_dir
```
- **Geometry:** Defines the barcode and UMI structure (e.g., `10xv3`).
- **Output:** Generates a `map.rad` file in the specified output directory.

### Bulk Mapping (`map-bulk`)
Used for standard bulk RNA-seq read alignment.

```bash
piscem map-bulk -i index_prefix -1 reads_R1.fq.gz -2 reads_R2.fq.gz -t 8 -o output_prefix
```

## Best Practices and Tips
- **Memory Management:** Piscem is designed to be space-efficient, but the `build` step is the most resource-intensive. Use the `--work-dir` flag to point to a high-speed SSD if temporary file I/O becomes a bottleneck.
- **Intermediate Files:** By default, piscem removes intermediate GFA files. Use `--keep-intermediate-dbg` if you need to inspect the underlying de Bruijn graph structure.
- **Thread Scaling:** While piscem scales well, avoid over-subscribing threads beyond physical core counts, especially during the `sshash` indexing phase.
- **Overwrite Safety:** Use the `--overwrite` flag if you need to re-run an index build into an existing output directory, otherwise the tool will error to prevent data loss.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Index a reference sequence |
| map-bulk | map reads for bulk processing |
| map-sc | map reads for single-cell processing |
| map-sc-atac | map reads for scAtac processing |

## Reference documentation
- [Piscem GitHub Repository](./references/github_com_COMBINE-lab_piscem.md)
- [Piscem README](./references/github_com_COMBINE-lab_piscem_blob_main_README.md)