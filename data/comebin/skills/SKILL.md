---
name: comebin
description: COMEBin is a deep learning framework that bins metagenomic contigs by integrating nucleotide composition and coverage profiles through contrastive multi-view representation learning. Use when user asks to bin metagenomic contigs, recover genomes from microbial communities, or generate genomic bins from assembly and coverage data.
homepage: https://github.com/ziyewang/COMEBin
metadata:
  docker_image: "quay.io/biocontainers/comebin:1.0.4--hdfd78af_1"
---

# comebin

## Overview

COMEBin is a deep learning-based framework designed for the effective binning of metagenomic contigs. It utilizes contrastive multi-view representation learning to integrate heterogeneous data types, specifically nucleotide composition (k-mer frequencies) and contig coverage profiles across samples. The tool works by augmenting data to create multiple "views" of each contig, training a neural network to produce robust low-dimensional embeddings, and finally clustering these embeddings using the Leiden community detection algorithm. This approach is particularly effective for recovering high-quality genomes from complex microbial communities.

## Installation and Environment

COMEBin is available via Bioconda. For optimal performance, a GPU-enabled environment is recommended.

```bash
# CPU-only installation
conda create -n comebin_env comebin -c bioconda -c conda-forge

# GPU-accelerated installation
conda create -n comebin_env comebin pytorch pytorch-cuda=11.8 -c pytorch -c nvidia -c bioconda -c conda-forge
```

## Preprocessing

Before running the binning pipeline, ensure your contigs are filtered by length and you have generated the necessary coverage information.

### 1. Filter Short Contigs
Binning performance degrades with very short sequences. It is standard practice to filter out contigs shorter than 1000bp.

```bash
python Filter_tooshort.py final.contigs.fa 1000
```

### 2. Generate BAM Files
If you only have raw reads, use the provided helper script to align reads to your assembly and generate BAM files.

```bash
bash gen_cov_file.sh -a assembly.fasta -o output_bam_dir -t 40 [reads_1.fastq reads_2.fastq ...]
```

## Running the Binning Pipeline

The primary entry point is the `run_comebin.sh` script.

### Basic Usage
```bash
run_comebin.sh -a assembly.fasta -p path_to_bam_files -o output_dir -t 40
```

### Advanced Parameter Tuning
- **Temperature (`-l`)**: This is a critical hyperparameter for the contrastive loss function.
  - Use `0.07` (default) for high-quality assemblies where N50 > 10,000.
  - Use `0.15` for more fragmented assemblies with lower N50.
- **Multi-view Count (`-n`)**: Default is 6. Increasing this may improve representation robustness at the cost of computational time.
- **Embedding Sizes (`-e`, `-c`)**: Default is 2048. For extremely large datasets, these can be adjusted to manage memory and model capacity.

### GPU Execution
To ensure the tool uses a specific GPU, prepend the command with the CUDA environment variable:
```bash
CUDA_VISIBLE_DEVICES=0 run_comebin.sh -a assembly.fasta -p bam_dir -o out_dir
```

## Output Interpretation

The pipeline produces two primary result files in the `comebin_res` subdirectory:
- `comebin_res_bins/`: A directory containing the final genomic bins in FASTA format.
- `comebin_res.tsv`: A tab-separated file mapping each contig ID to its assigned bin.

## Expert Tips
- **Memory Management**: If you encounter out-of-memory (OOM) errors during the training phase, reduce the batch size using the `-b` flag (default is 1024).
- **Input Consistency**: Ensure that the BAM files provided in the `-p` directory were generated using the exact same assembly file provided with `-a`.
- **Thread Allocation**: While `-t` controls CPU threads, the deep learning components benefit most from GPU acceleration. If running on a CPU, ensure `-t` matches your available physical cores for the clustering and augmentation steps.



## Subcommands

| Command | Description |
|---------|-------------|
| bash run_comebin.sh | COMEBin version: 1.0.4 |
| gen_coverage_file.sh | Generates coverage files from reads and a metagenomic assembly. |

## Reference documentation
- [COMEBin README](./references/github_com_ziyewang_COMEBin_blob_master_README.md)
- [COMEBin Environment Schema](./references/github_com_ziyewang_COMEBin_blob_master_comebin_env.yaml.md)