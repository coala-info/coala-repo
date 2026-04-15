---
name: kegalign-full
description: KegAlign is a GPU-accelerated genome alignment tool that identifies highly sensitive pairs to generate optimized LASTZ alignment commands. Use when user asks to perform high-performance sequence alignment, convert FASTA files to 2bit format, or parallelize genomic seed-and-extend processes using GPU hardware.
homepage: https://github.com/galaxyproject/KegAlign
metadata:
  docker_image: "quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0"
---

# kegalign-full

## Overview
KegAlign is a high-performance genome alignment tool designed to accelerate the seed-and-extend alignment process by leveraging GPU hardware. It serves as a modern, optimized fork of SegAlign, specifically enhanced for better GPU utilization and integration into bioinformatics pipelines like Galaxy. The tool functions by identifying Highly Sensitive Pairs (HSPs) on the GPU and then generating commands for LASTZ to perform the final gapped alignment. Use this skill to navigate the multi-step process of sequence conversion, seed filtering, and parallelized alignment execution.

## CLI Usage and Best Practices

### 1. Sequence Preparation
Before alignment, input FASTA files must be converted to the `.2bit` format for random access.
```bash
# Convert target and query sequences
faToTwoBit reference.fasta ref.2bit
faToTwoBit query.fasta query.2bit
```

### 2. Generating Alignment Commands
KegAlign does not produce the final alignment file directly; it generates a list of optimized `lastz` commands.
```bash
# Basic command generation
kegalign reference.fasta query.fasta work_dir/ --num_gpu 1 --num_threads 16 > lastz-commands.txt
```
*   **Expert Tip**: Use `--segment_size` to limit the maximum number of HSPs per segment file. This helps balance the CPU load during the subsequent LASTZ phase.

### 3. Diagonal Partitioning
To improve efficiency, apply diagonal partitioning to the generated commands. This prevents redundant computations in large genomic blocks.
```bash
xargs -d "\n" -n 1 python ./scripts/diagonal_partition.py -1 < lastz-commands.txt > partitioned-commands.txt
```

### 4. Executing the Alignment
Run the partitioned commands in parallel to maximize throughput.
```bash
# Using GNU Parallel for high-efficiency execution
parallel --max-procs 16 < partitioned-commands.txt

# Combine outputs into a single MAF file
(echo "##maf version=1"; cat *.maf-) > final_alignment.maf
```

### 5. GPU Optimization (MIG/MPS)
For users with high-end NVIDIA GPUs (e.g., A100, H100), KegAlign supports Multi-Instance GPU (MIG) and Multi-Process Service (MPS).
*   **Split Inputs**: Use `split_input.py` to break large genomes into chunks (e.g., 200Mbp for human genomes) to run multiple KegAlign instances on a single GPU.
*   **Memory Management**: Each KegAlign instance typically requires 12-16 GiB of GPU memory. Ensure your MIG partition or MPS limit accounts for this.

## Scoring and Customization
KegAlign supports custom substitution matrices via the `--scoring` option, compatible with LASTZ scoring files.
```bash
kegalign ref.fasta query.fasta out/ --scoring=HOXD70.scoring
```



## Subcommands

| Command | Description |
|---------|-------------|
| diagonal_partition.py | Partitions a large alignment file into smaller chunks based on diagonal blocks. |
| faToTwoBit | Convert DNA from fasta to 2bit format |
| run_kegalign | You must specify a target file and a query file |
| runner.py | Runner script for kegalign-full |

## Reference documentation
- [KegAlign README](./references/github_com_galaxyproject_KegAlign_blob_main_README.md)
- [KegAlign Overview](./references/anaconda_org_channels_bioconda_packages_kegalign-full_overview.md)