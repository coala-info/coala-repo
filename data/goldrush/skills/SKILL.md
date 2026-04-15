---
name: goldrush
description: GoldRush is a bioinformatics tool for the memory-efficient assembly of long-read sequencing data using a linear-time algorithm. Use when user asks to assemble long-read sequencing data, run the GoldRush pipeline, generate a golden path of reads, or perform polishing and scaffolding on genomic assemblies.
homepage: https://github.com/bcgsc/goldrush
metadata:
  docker_image: "quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0"
---

# goldrush

## Overview
GoldRush is a specialized bioinformatics tool designed for the memory-efficient assembly of long-read sequencing data (such as Oxford Nanopore). Unlike traditional assemblers that can be computationally expensive, GoldRush uses a linear-time algorithm to identify a representative "golden path" of reads covering the genome. It then executes a multi-stage pipeline to polish these reads, correct structural errors, and link them into large scaffolds. This skill provides the necessary patterns to execute the full pipeline or specific sub-modules like GoldPath and GoldPolish.

## Core CLI Usage
The primary interface for GoldRush uses an `OPTION=VALUE` syntax.

### The Standard Pipeline
To run the complete assembly pipeline (Path + Polish + Tigmint + ntLink + Target Polish):
```bash
goldrush run reads=<read_prefix> G=<genome_size> t=<threads>
```

### Required Parameters
- `reads`: The prefix of your input file. **Important**: The file must end in `.fq` or `.fastq`, but you must **not** include the extension in the command (e.g., use `reads=sample` for `sample.fq`).
- `G`: The estimated haploid genome size in base pairs. Scientific notation is supported (e.g., `G=3e9` for human, `G=1.2e8` for Arabidopsis).

### Common Sub-commands
If you do not need the full pipeline, you can run specific stages:
- `goldrush-path`: Generates the initial "golden path" (GoldPath).
- `path-polish`: Runs GoldPath followed by GoldPolish.
- `path-tigmint`: Runs Path, Polish, and Tigmint-long (misassembly correction).
- `path-tigmint-ntLink`: Adds scaffolding via ntLink (default 5 rounds).

## Expert Tips and Best Practices

### Input Preparation
- **Randomize Reads**: GoldRush requires input reads to be in random order. If your FASTQ files are sorted by chromosome or position, you must shuffle them before starting the assembly.
- **Decompression**: Input files must be uncompressed FASTQ. If your data is in `.fastq.gz`, decompress it first.
- **Working Directory**: Ensure all input files are in the current working directory. Use symbolic links (`ln -s`) if the original files are stored elsewhere.

### Performance Tuning
- **Threading**: Use at least 48 threads (`t=48`) for large genomes to optimize the polishing and scaffolding stages.
- **Memory Management**: For a human-sized genome (~3Gb), ensure the system has at least 64GB of RAM.
- **Shared Memory**: GoldPolish performs operations in shared memory. By default, it uses `/dev/shm`. If your environment has a different shared memory path, specify it with `shared_mem=/your/path`.

### Parameter Optimization
- **Read Length (`m`)**: By default, GoldPath filters for reads. If working with ultra-long reads, you may want to adjust the minimum read length threshold.
- **Scaffolding (`z`)**: The `z` parameter controls the minimum contig size to be considered for scaffolding. The default is 1000bp.
- **ntLink Rounds**: The default is 5 rounds. Increasing this may improve continuity but increases runtime.

## Troubleshooting
- **File Suffix Error**: If the tool fails immediately, verify that you haven't included `.fq` in the `reads=` argument.
- **L50 Check**: After a successful run, check the output assembly. A good assembly should ideally have a low L50 (e.g., L50 of 1 for small, well-assembled segments).
- **Time/Memory Tracking**: Use `track_time=1` to output resource usage statistics for benchmarking.

## Reference documentation
- [GoldRush GitHub Overview](./references/github_com_bcgsc_goldrush.md)
- [Bioconda GoldRush Package](./references/anaconda_org_channels_bioconda_packages_goldrush_overview.md)