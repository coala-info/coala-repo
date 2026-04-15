---
name: isoncorrect
description: isONcorrect performs de novo error correction on Oxford Nanopore cDNA sequencing data to improve base-level accuracy across transcript isoforms. Use when user asks to error correct long-read transcriptome data, improve the accuracy of ONT cDNA reads, or process clustered isoforms for high-quality consensus sequences.
homepage: https://github.com/ksahlin/isONcorrect
metadata:
  docker_image: "quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0"
---

# isoncorrect

## Overview
isONcorrect is a specialized tool designed to improve the base-level accuracy of Oxford Nanopore cDNA sequencing data. While standard genomic error-correctors often struggle with the uneven coverage and alternative splicing patterns found in transcriptomes, isONcorrect leverages shared regions across different isoforms to correct even low-abundance transcripts. It is typically used as the final step in a pipeline following transcript classification (pychopper) and clustering (isONclust).

## Installation and Environment
The tool is primarily distributed via Conda and Pip. It requires `spoa` as a core dependency.

```bash
# Recommended setup
conda create -n isoncorrect python=3.9 pip
conda activate isoncorrect
pip install isONcorrect
conda install -c bioconda spoa
```

## Core Usage Patterns

### Correcting a Single Cluster
Use the base command when processing a single FASTQ file (usually representing one gene cluster).
```bash
isONcorrect --fastq path/to/cluster.fastq --outfolder output_dir
```

### Parallel Processing (Recommended)
For full datasets, use the `run_isoncorrect` wrapper to process multiple clusters in parallel.
```bash
run_isoncorrect --t 16 --fastq_folder path/to/clusters_dir/ --outfolder output_dir/
```

## Parameter Optimization
The tool provides two main profiles depending on your computational resources and accuracy requirements:

*   **Default Profile (v0.0.8+):** Optimized for speed and memory efficiency.
    *   Parameters: `--k 9 --w 20 --max_seqs 2000`
    *   Performance: 2-3x faster, 3-8x less memory, ~98.5-99.3% accuracy.
*   **High Accuracy Profile:** Matches the original published results.
    *   Parameters: `--k 9 --w 10 --max_seqs 1000`
    *   Performance: Higher resource usage, ~98.9-99.6% accuracy.

## Recommended Workflow
To achieve optimal results with ONT cDNA reads, follow this sequential pipeline:
1.  **Classification:** Run `pychopper` to identify full-length reads and orient them.
2.  **Clustering:** Run `isONclust` to group reads by gene or gene family.
3.  **Extraction:** Use `isONclust write_fastq` to generate individual FASTQ files for each cluster.
4.  **Correction:** Run `run_isoncorrect` on the folder of clustered FASTQ files.

## Expert Tips
*   **Memory Management:** If the tool crashes on very large clusters, reduce the `--max_seqs` parameter to limit the number of sequences used for the correction of a single read.
*   **Input Quality:** While isONcorrect does not strictly require full-length reads, using `pychopper` first is highly recommended for downstream transcriptome analysis to ensure biological validity.
*   **Output Headers:** The tool preserves the original read headers in the output FASTQ, making it easy to map corrected reads back to their original metadata.



## Subcommands

| Command | Description |
|---------|-------------|
| isONcorrect | De novo error correction of long-read transcriptome reads |
| run_isoncorrect | De novo clustering of long-read transcriptome reads |

## Reference documentation
- [isONcorrect README](./references/github_com_ksahlin_isONcorrect_blob_master_README.md)
- [Correction Pipeline Script](./references/github_com_ksahlin_isONcorrect_blob_master_scripts_correction_pipeline.sh.md)
- [Project Configuration](./references/github_com_ksahlin_isONcorrect_blob_master_pyproject.toml.md)