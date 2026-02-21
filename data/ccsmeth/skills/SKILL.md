---
name: ccsmeth
description: The `ccsmeth` tool is a deep learning-based pipeline designed to identify epigenetic modifications in PacBio HiFi data.
homepage: https://github.com/PengNi/ccsmeth
---

# ccsmeth

## Overview
The `ccsmeth` tool is a deep learning-based pipeline designed to identify epigenetic modifications in PacBio HiFi data. It leverages the kinetic information (IPD and Pulse Width) preserved in CCS reads to distinguish methylated bases from unmethylated ones. The tool provides two primary workflows: a **denovo mode** (calling modifications before genomic alignment) and an **align mode** (calling modifications using aligned BAM files). It is particularly useful for researchers performing long-read epigenomics who need high-accuracy 5mCpG detection and frequency calculation at the genomic level.

## Core Workflows

### 1. Denovo Workflow (Modification-First)
Use this mode when you want to generate a "modBAM" before final alignment.
1. **Generate HiFi with Kinetics**:
   `ccsmeth call_hifi --subreads subreads.bam --threads 10 --output output.hifi.bam`
2. **Call Modifications**:
   `ccsmeth call_mods --input output.hifi.bam --model_file model_call_mods.ckpt --output output.hifi.call_mods --threads 10 --model_type attbigru2s --mode denovo`
3. **Align modBAM**:
   `ccsmeth align_hifi --hifireads output.hifi.call_mods.modbam.bam --ref genome.fa --output output.aligned.modbam.bam`

### 2. Align Workflow (Alignment-First)
Use this mode when you already have aligned HiFi reads or prefer reference-informed calling.
1. **Align HiFi Reads**:
   `ccsmeth align_hifi --hifireads output.hifi.bam --ref genome.fa --output output.hifi.pbmm2.bam`
2. **Call Modifications**:
   `ccsmeth call_mods --input output.hifi.pbmm2.bam --ref genome.fa --model_file model_call_mods.ckpt --output output.hifi.pbmm2.call_mods --threads 10 --mode align`

## Modification Frequency Calculation
After generating a modBAM, use `call_freqb` to generate genomic methylation frequencies in BED format.

*   **Count Mode (Fast)**: Simple ratio of methylated vs. unmethylated calls.
    `ccsmeth call_freqb --input_bam input.modbam.bam --ref genome.fa --output output.freq --threads 10 --sort --bed`
*   **Aggregate Mode (Accurate)**: Uses a secondary model to refine frequencies.
    `ccsmeth call_freqb --input_bam input.modbam.bam --ref genome.fa --output output.freq --threads 10 --sort --bed --call_mode aggregate --aggre_model model_aggregate.ckpt`

## Expert Tips and Best Practices
*   **GPU Acceleration**: Always set `CUDA_VISIBLE_DEVICES` before running `call_mods` to significantly speed up the deep learning inference.
*   **Model Selection**: Ensure the model version matches your `ccsmeth` version. Version 0.5.0+ uses `v3.ckpt` models, while older versions use `v2.ckpt`.
*   **Haplotype Awareness**: If your input BAM contains haplotags (HP tags), `call_freqb` will automatically generate separate BED files for each haplotype (`hp1.bed` and `hp2.bed`).
*   **Resource Management**: `ccsmeth` is memory-intensive. For human-scale genomes, 128GB RAM and a GPU with at least 8GB VRAM are recommended.
*   **Kinetics Requirement**: `ccsmeth` requires IPD and Pulse Width information. If your HiFi reads were generated without kinetics, you must re-run `call_hifi` from the original subreads.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_PengNi_ccsmeth.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_ccsmeth_overview.md)