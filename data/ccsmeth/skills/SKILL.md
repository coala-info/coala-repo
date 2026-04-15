---
name: ccsmeth
description: ccsmeth identifies DNA methylation patterns in PacBio HiFi reads using deep learning models and kinetic signals. Use when user asks to generate HiFi reads with kinetics, predict 5mCpG methylation sites, align modified reads to a reference, or calculate genomic methylation frequencies.
homepage: https://github.com/PengNi/ccsmeth
metadata:
  docker_image: "quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0"
---

# ccsmeth

## Overview

ccsmeth is a specialized toolset for identifying DNA methylation patterns in PacBio HiFi reads. Unlike standard basecalling, ccsmeth utilizes the kinetic signals (Inter-Pulse Duration and Pulse Width) preserved during the CCS generation process. It employs deep learning models (Attention-based Bi-GRU) to predict 5mCpG sites and provides modules to aggregate these calls into genomic methylation frequencies. Use this skill to guide the transition from raw subreads to actionable methylation data.

## Core Workflow: The Denovo Pipeline

The standard "denovo" workflow consists of four primary stages.

### 1. Generate HiFi Reads with Kinetics
If starting from raw subreads, you must generate HiFi reads that include kinetic information.
```bash
ccsmeth call_hifi --subreads /path/to/subreads.bam \
  --threads 10 \
  --output /path/to/output.hifi.bam
```

### 2. Call Modifications (Methylation Prediction)
This step uses a pre-trained model to predict methylation. It is computationally intensive; using a GPU is highly recommended.
```bash
# Use CUDA_VISIBLE_DEVICES to specify GPU
CUDA_VISIBLE_DEVICES=0 ccsmeth call_mods \
  --input /path/to/output.hifi.bam \
  --model_file /path/to/models/model_ccsmeth_5mCpG_call_mods_attbigru2s_b21.v3.ckpt \
  --output /path/to/output.hifi.call_mods \
  --threads 10 --threads_call 2 \
  --model_type attbigru2s \
  --mode denovo
```
*Note: The output will be a `.modbam.bam` file containing MM and ML tags.*

### 3. Align Modified HiFi Reads
Align the ModBAM file to your reference genome using `pbmm2` (default) or `minimap2`.
```bash
ccsmeth align_hifi \
  --hifireads /path/to/output.hifi.call_mods.modbam.bam \
  --ref /path/to/genome.fa \
  --output /path/to/output.aligned.modbam.bam \
  --threads 10
```

### 4. Calculate Methylation Frequency
Aggregate the single-read calls into site-specific frequencies.
```bash
ccsmeth call_freqb \
  --input_bam /path/to/output.aligned.modbam.bam \
  --ref /path/to/genome.fa \
  --output /path/to/output.freq \
  --threads 10 \
  --call_mode count
```

## Expert Tips and Best Practices

### Model Selection
*   **Version Compatibility**: For ccsmeth version >= 0.5.0, use the `.v3.ckpt` models. For older versions (<= 0.4.1), use `.v2.ckpt`.
*   **Aggregate Mode**: When using `call_freqb`, you can use the `--call_mode aggregate` with a specific aggregate model (e.g., `model_ccsmeth_5mCpG_aggregate_attbigru_b11.v2p.ckpt`) for potentially higher accuracy than simple counting.

### Performance Optimization
*   **GPU Acceleration**: The `call_mods` module is the bottleneck. Ensure `pytorch-cuda` is installed and use `--threads_call` to manage the number of calling processes feeding the GPU.
*   **Multi-threading**: Most modules support `--threads`. For `call_mods`, distinguish between `--threads` (data processing) and `--threads_call` (model inference).

### Handling Haplotypes
*   If your input BAM contains `HP` (haplotag) tags from tools like WhatsHap, `call_freqb` will automatically detect them and generate separate frequency files for each haplotype (e.g., `.hp1.bed` and `.hp2.bed`).

### Troubleshooting
*   **Missing Kinetics**: If `call_mods` fails or produces no results, verify that the input BAM contains the `fi`, `ri`, `fp`, and `rp` tags (kinetics).
*   **Memory Usage**: `ccsmeth` performs in-memory operations. For large genomes or high coverage, ensure the system has at least 128GB RAM.



## Subcommands

| Command | Description |
|---------|-------------|
| ccsmeth call_freqt | call frequency of modifications at genome level from per_readsite text files |
| ccsmeth call_hifi | call hifi reads with kinetics from subreads.bam using CCS, save in bam/sam format. |
| ccsmeth train | train a model, need two independent datasets for training and validating |
| ccsmeth trainm | [EXPERIMENTAL]train a model using multi gpus |
| ccsmeth_align_hifi | align hifi reads using pbmm2/minimap2/bwa, default pbmm2 |
| ccsmeth_call_freqb | call frequency of modifications at genome level from modbam.bam file |
| ccsmeth_call_mods | call modifications |
| ccsmeth_extract | extract features from hifi reads. |

## Reference documentation
- [ccsmeth Main Documentation](./references/github_com_PengNi_ccsmeth_blob_master_README.md)
- [Changelog and Version History](./references/github_com_PengNi_ccsmeth_blob_master_README.rst.md)
- [Conda Environment Specifications](./references/github_com_PengNi_ccsmeth_blob_master_environment.yml.md)