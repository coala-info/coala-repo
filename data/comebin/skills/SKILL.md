---
name: comebin
description: COMEBin is a tool for binning metagenomic contigs using contrastive multi-view representation learning and deep learning embeddings. Use when user asks to bin metagenomic contigs, recover genomes from microbial communities, or generate low-dimensional embeddings for contig clustering.
homepage: https://github.com/ziyewang/COMEBin
---


# comebin

## Overview
COMEBin is a specialized tool for the binning of metagenomic contigs. It leverages contrastive multi-view representation learning to integrate heterogeneous information, specifically nucleotide frequency (k-mer) and coverage features. By generating multiple augmented "views" of each contig and using a deep learning framework (including "Coverage" and "Combine" networks), it produces low-dimensional embeddings that are subsequently clustered using the Leiden community detection algorithm. This approach is particularly effective for recovering high-quality genomes from complex microbial communities.

## Installation and Environment
The most reliable way to use COMEBin is via Bioconda.

```bash
# Create and activate environment
conda create -n comebin_env
conda activate comebin_env

# Install COMEBin
conda install -c conda-forge -c bioconda comebin

# Optional: Install GPU support for faster performance
conda install pytorch pytorch-cuda=11.8 -c pytorch -c nvidia -c conda-forge
```

## Preprocessing Workflow
Before running the main binning algorithm, you must prepare your input data.

### 1. Filter Short Contigs
Binning performance degrades significantly with very short sequences. It is standard practice to filter out contigs shorter than 1000bp.
```bash
python Filter_tooshort.py input_assembly.fasta 1000
```

### 2. Generate Coverage Files
COMEBin requires BAM files as input. If you only have raw sequencing reads, use the provided helper script to align them to your assembly.
```bash
bash gen_cov_file.sh -a contigs.fasta -o output_cov_dir -t 40 [reads_1.fastq reads_2.fastq ...]
```
*   **-a**: Metagenomic assembly file.
*   **-o**: Output directory for coverage files.
*   **-t**: Number of threads.
*   **--single-end**: Use this flag for non-paired reads.

## Running COMEBin
The primary execution script is `run_comebin.sh`.

### Basic Command
```bash
run_comebin.sh -a assembly.fasta -o output_dir -p path_to_bamfiles -t 40
```

### Key Parameters and Tuning
*   **Temperature (-l)**: This is the most critical parameter for the loss function.
    *   Use **0.07** (default) if your assembly is relatively contiguous (N50 > 10,000).
    *   Use **0.15** if your assembly is fragmented (N50 < 10,000).
*   **Views (-n)**: Number of augmented views for contrastive learning. Default is 6.
*   **Embedding Sizes (-e, -c)**: Default is 2048 for both the combine and coverage networks. Adjust only if dealing with extremely large or small datasets.
*   **GPU Acceleration**: If a GPU is available, ensure `CUDA_VISIBLE_DEVICES` is set correctly to speed up the training process.

## Output Interpretation
The results are stored in the specified output directory:
*   `comebin_res/comebin_res_bins/`: Contains the final genomic bins in FASTA format.
*   `comebin_res/comebin_res.tsv`: A summary file mapping each contig to its assigned bin.

## Expert Tips
*   **Memory Management**: For large metagenomes, ensure the system has sufficient RAM for in-memory operations during the contrastive learning phase.
*   **BAM Pathing**: Ensure the `-p` flag points to a directory containing *only* the BAM files relevant to the assembly provided in `-a`.
*   **Thread Usage**: While `-t` controls threads for the main script, the underlying clustering (Leiden) and data loading can be CPU-intensive; allocate at least 20-40 threads for complex samples.

## Reference documentation
- [COMEBin Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_comebin_overview.md)
- [COMEBin GitHub Repository](./references/github_com_ziyewang_COMEBin.md)