---
name: deepbinner
description: Deepbinner demultiplexes Oxford Nanopore sequencing data by identifying barcodes within the raw electrical signal. Use when user asks to classify raw fast5 signals, bin reads into barcode-specific files, or perform real-time demultiplexing during a sequencing run.
homepage: https://github.com/rrwick/Deepbinner
metadata:
  docker_image: "quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0"
---

# deepbinner

## Overview
Deepbinner is a specialized tool designed to identify barcodes in Oxford Nanopore sequencing data by analyzing the raw electrical signal (the "squiggle") rather than the basecalled sequence. By operating at the signal level, it often achieves higher sensitivity than sequence-based demultiplexers, especially in cases where basecalling quality is low at the ends of reads. It is particularly useful for users performing signal-level downstream analyses (like Nanopolish) or those working with legacy datasets where standard basecallers struggle to identify barcodes.

## Core Workflows

### 1. Standard Demultiplexing (Post-Basecalling)
If you already have basecalled FASTQ files but want the accuracy of signal-level classification, use a two-step process:

**Step A: Classify the raw signal**
```bash
deepbinner classify --native fast5_dir > classifications.tsv
```
*Use `--native` for EXP-NBD103/104 or `--rapid` for SQK-RBK004.*

**Step B: Bin the FASTQ reads**
```bash
deepbinner bin --classes classifications.tsv --reads basecalled_reads.fastq.gz --out_dir demultiplexed_fastq
```

### 2. Real-time Demultiplexing
To demultiplex raw fast5 files during a sequencing run:
```bash
deepbinner realtime --in_dir fast5_dir --out_dir demultiplexed_fast5s --native
```

### 3. Handling Native Barcoding Logic
Native barcodes can appear at both ends of a read. Control how Deepbinner handles these with the following flags:
*   `--require_either`: (Default) Bins if a barcode is found at either the start or end.
*   `--require_start`: Stricter; requires a barcode at the start of the read.
*   `--require_both`: Strictest; requires matching barcodes at both ends.

## Expert Tips and Best Practices

*   **GPU Acceleration**: Deepbinner relies on TensorFlow. While CPU execution is possible for classification, training custom models effectively requires an NVIDIA GPU.
*   **Multi-read Fast5s**: If using modern multi-read fast5 files, you must first convert them to single-read fast5 files using the `ont_fast5_api` tool (`multi_to_single_fast5`) before running Deepbinner.
*   **Hybrid Demultiplexing**: For maximum precision, run both Deepbinner and a sequence-based demultiplexer (like Guppy or Albacore) and only keep reads where both tools agree on the barcode assignment.
*   **Model Limitations**: Pre-trained models typically cover 12 barcodes. If using 96-barcode kits, you may need to train a custom model or use a more modern basecaller like Guppy.
*   **Memory Management**: If you encounter `ResourceExhaustedError` on a GPU, reduce the batch size during classification or training.



## Subcommands

| Command | Description |
|---------|-------------|
| deepbinner balance | Select balanced training set |
| deepbinner bin | Bin fasta/q reads |
| deepbinner classify | Classify fast5 reads |
| deepbinner prep | Prepare training data |
| deepbinner realtime | Sort fast5 files during sequencing |
| deepbinner refine | Refine the training set |
| deepbinner train | Train the neural network |

## Reference documentation
- [Deepbinner GitHub Repository](./references/github_com_rrwick_Deepbinner.md)
- [Combining start and end barcodes](./references/github_com_rrwick_Deepbinner_wiki_Combining-start-and-end-barcodes.md)
- [Creating a native barcoding training set](./references/github_com_rrwick_Deepbinner_wiki_Creating-a-native-barcoding-training-set.md)
- [Deepbinner Classify Usage](./references/github_com_rrwick_Deepbinner_wiki_deepbinner-classify.md)