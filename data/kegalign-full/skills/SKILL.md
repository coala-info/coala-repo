---
name: kegalign-full
description: KegAlign-full is a GPU-accelerated genomic alignment system designed for high-performance whole-genome comparisons using the seed-filter-extend paradigm. Use when user asks to perform whole-genome alignments, accelerate LASTZ workflows with NVIDIA GPUs, or manage complex genomic partitioning and load balancing.
homepage: https://github.com/galaxyproject/KegAlign
---


# kegalign-full

## Overview

KegAlign is a high-performance genomic alignment system that leverages NVIDIA GPUs to accelerate the seed-filter-extend paradigm originally established by LASTZ. It is designed to handle whole-genome comparisons by partitioning the workload and utilizing GPU resources efficiently. The "full" version includes a suite of Python scripts to manage complex workflows, including input splitting, diagonal partitioning for load balancing, and support for Multi-Instance GPU (MIG) and Multi-Process Service (MPS) to maximize hardware utilization.

## Core Workflow

The standard KegAlign process involves four distinct stages: sequence conversion, command generation, partitioning, and alignment execution.

### 1. Pre-processing Sequences
KegAlign requires input sequences in `.2bit` format for random access. Use `faToTwoBit` (included in the environment) to convert compressed or raw FASTA files.

```bash
# Convert reference and query to 2bit
faToTwoBit <(gzip -cdfq ref.fasta.gz) ref.2bit
faToTwoBit <(gzip -cdfq query.2bit.gz) query.2bit
```

### 2. Generating and Partitioning Commands
KegAlign identifies candidate alignment regions and generates a list of LASTZ commands. These commands must be partitioned to ensure balanced CPU/GPU load.

**Option A: Using the Integrated Runner (Recommended for Galaxy-like workflows)**
```bash
python runner.py --diagonal-partition --format maf- --num-cpu 16 --num-gpu 1 --output-file data_package.tgz --output-type tarball --tool_directory ./scripts target.fasta.gz query.fasta.gz
```

**Option B: Manual CLI Execution**
```bash
# 1. Generate raw commands
kegalign target.fasta.gz query.fasta.gz work_dir/ --num_gpu 1 --num_threads 16 > lastz-commands.txt

# 2. Apply diagonal partitioning
xargs -d "\n" -n 1 python ./scripts/diagonal_partition.py -1 < lastz-commands.txt > partitioned-commands.txt
```

### 3. Executing the Alignment
Run the generated commands using LASTZ. For high throughput, use GNU Parallel.

```bash
parallel --max-procs 16 < partitioned-commands.txt
# Combine outputs into a single MAF file
(echo "##maf version=1"; cat *.maf-) > final_alignment.maf
```

## Advanced GPU Optimization (MIG/MPS)

To increase GPU utilization by up to 20%, use the MIG/MPS scripts. This is critical when the GPU has significantly more memory than a single KegAlign instance requires (typically 12-16 GiB).

1.  **Split Input:** Divide chromosomes into chunks based on base-pair goals.
    ```bash
    ./scripts/mps-mig/split_input.py --input query.fasta.gz --out query_split --to_2bit --goal_bp 200000000 --max_chunks 30
    ```
2.  **Run with MIG/MPS:**
    ```bash
    # Run on specific GPUs with 4 MPS processes per GPU
    python ./scripts/mps-mig/run_mig.py [GPU-UUID1],[GPU-UUID2] --MPS 4 --target ./target_split --query ./query_split --output ./output.maf --num_threads 64
    ```

## Expert Tips and Best Practices

*   **Memory Management:** Each KegAlign instance requires 12-16 GiB of VRAM. Ensure your `--MPS` count multiplied by 12 GiB does not exceed total GPU memory.
*   **Load Balancing:** When using `split_input.py`, set `--goal_bp` to be roughly the size of your largest chromosome (e.g., 200M for human) to prevent uneven chunking, as individual chromosomes are not split.
*   **Scoring Matrices:** By default, KegAlign uses HOXD70. You can provide a custom LASTZ scoring file using the `--scoring` parameter.
*   **Thread Scaling:** Use `--num_threads` to limit CPU usage. This is particularly important in shared HPC environments to prevent over-subscription when multiple GPU processes are running.
*   **Segment Size:** If CPU load balancing is an issue, use `--segment_size` to limit the maximum number of High-scoring Segment Pairs (HSPs) per segment file.

## Reference documentation
- [KegAlign Overview](./references/anaconda_org_channels_bioconda_packages_kegalign-full_overview.md)
- [KegAlign GitHub Documentation](./references/github_com_galaxyproject_KegAlign.md)