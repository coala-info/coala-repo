---
name: ribodetector
description: RiboDetector is a deep learning tool designed to rapidly identify and filter rRNA sequences from sequencing data. Use when user asks to detect ribosomal RNA, remove rRNA contamination, or filter reads for transcriptomic analysis.
homepage: https://github.com/hzi-bifo/RiboDetector
---


# ribodetector

## Overview

RiboDetector is a high-performance tool powered by deep learning (specifically LSTMs) designed to rapidly identify rRNA sequences. It serves as a modern alternative to alignment-based tools, offering significantly faster processing speeds—approximately 10x faster on CPUs and up to 50x faster on GPUs. It is highly accurate across various GO functional groups and is optimized for both single-end and paired-end sequencing data.

## Installation and Setup

RiboDetector can be installed via Conda or Pip. For GPU acceleration, PyTorch must be installed separately to match your CUDA version.

```bash
# Installation via Conda
conda install -c bioconda ribodetector

# Installation via Pip
pip install ribodetector
```

## Command Line Usage

RiboDetector provides two distinct executables depending on your hardware: `ribodetector` for GPU-accelerated processing and `ribodetector_cpu` for standard processor usage.

### Basic GPU Execution
Use this for maximum throughput when a CUDA-capable GPU is available.

```bash
ribodetector -t 20 -l 100 -i input_1.fq.gz input_2.fq.gz -e rrna -m 10 -o output_1.fq output_2.fq
```

### Basic CPU Execution
Use this for standard server environments or when GPU resources are unavailable.

```bash
ribodetector_cpu -t 20 -l 100 -i input_1.fq.gz input_2.fq.gz -e rrna --chunk_size 256 -o output_1.fq output_2.fq
```

### Key Parameters

- `-l, --len`: **Critical.** Set this to the mean sequencing read length. Accuracy significantly decreases for reads shorter than 40bp.
- `-i, --input`: Path to input files (FASTA/FASTQ). Provide two files for paired-end data.
- `-o, --output`: Path for non-rRNA output files (cleaned data).
- `-r, --rrna`: Path for detected rRNA output files (if you wish to keep the ribosomal reads).
- `-e, --ensure`: Confidence mode for paired-end reads:
    - `rrna`: High confidence for rRNA (rest are non-rRNA).
    - `norrna`: High confidence for non-rRNA (rest are rRNA).
    - `both`: Both must be high confidence.
    - `none`: Label based on mean probability (default).
- `-t, --threads`: Number of CPU threads (default is 10 for GPU, 20 for CPU mode).
- `-m, --memory`: Amount of GPU RAM to allocate in GB (default: 12).

## Expert Tips and Best Practices

- **Memory Management**: If your free RAM is less than 5 times the uncompressed size of your input files, use the `--chunk_size` parameter to prevent out-of-memory errors. A value of `256` is a common starting point.
- **Output Compression**: While RiboDetector supports writing to `.gz` files directly, be aware that this is approximately 2 times slower than writing uncompressed files.
- **Variable Read Lengths**: RiboDetector supports variable-length reads. Always set the `-l` parameter to the *average* length of your library for the best results.
- **SLURM Environments**: When running on a SLURM cluster, ensure you set `--cpus-per-task` to your desired thread count and set `--threads-per-core=1` to avoid resource contention.
- **Custom Models**: If you have a specific trained model, use `--model-file` to point to your model base (exclude the `.pth` or `.onnx` extension).

## Reference documentation
- [RiboDetector GitHub Repository](./references/github_com_hzi-bifo_RiboDetector.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ribodetector_overview.md)