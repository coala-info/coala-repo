---
name: deepbinner
description: Deepbinner is a demultiplexer that uses a deep convolutional neural network to identify barcodes from raw Oxford Nanopore signal data. Use when user asks to demultiplex fast5 files, classify raw squiggle signals, or perform real-time barcode identification during a sequencing run.
homepage: https://github.com/rrwick/Deepbinner
---


# deepbinner

## Overview
Deepbinner is a specialized demultiplexer that utilizes a deep convolutional neural network to identify barcodes directly from the raw "squiggle" signal of Oxford Nanopore reads. Unlike sequence-based tools, it operates on fast5 files, providing higher sensitivity for reads where basecalling might fail to resolve the barcode. It is most effective when working with the 12 native or rapid barcodes it was specifically trained on. While newer tools like Guppy have integrated demultiplexing, Deepbinner remains a powerful option for maximizing read recovery and handling raw signal workflows.

## Installation and Requirements
Deepbinner requires Python 3.5+ and TensorFlow. It is available via Bioconda or source.
- **Conda**: `conda install -c bioconda deepbinner`
- **Source**: `pip3 install git+https://github.com/rrwick/Deepbinner.git`
- **Note**: CPU-based TensorFlow is sufficient for classification; GPUs are recommended only for training new models.

## Common CLI Patterns

### 1. Standard Demultiplexing (Post-Basecalling)
If you have already basecalled your reads but want the accuracy of signal-level demultiplexing, use the two-step classify and bin approach.

**Step 1: Classify the raw signals**
```bash
deepbinner classify --native fast5_dir/ > classifications.tab
```
*Use `--native` for the EXP-NBD103 kit or `--rapid` for the SQK-RBK004 kit.*

**Step 2: Bin the FASTQ reads based on classifications**
```bash
deepbinner bin --classes classifications.tab --reads basecalled_reads.fastq.gz --out_dir demultiplexed_fastq/
```

### 2. Real-time Demultiplexing
To demultiplex during a sequencing run, Deepbinner can monitor a directory and process fast5 files as they are created.
```bash
deepbinner realtime --in_dir fast5_pass/ --out_dir demultiplexed_fast5s/ --native
```

### 3. Handling Multi-read Fast5s
For modern Nanopore data stored in multi-read fast5 format, you must convert them to single-read files first using the `ont_fast5_api`.
```bash
multi_to_single_fast5 --input_path multi_fast5_dir/ --save_path single_fast5_dir/
deepbinner classify --native single_fast5_dir/ > classifications.tab
```

## Expert Tips and Best Practices
- **Hybrid Demultiplexing**: For maximum stringency, cross-reference Deepbinner results with Albacore/Guppy demultiplexing. Only keep reads where both tools agree on the barcode assignment to virtually eliminate misclassified reads.
- **Signal Length**: Deepbinner looks at the ends of the raw signal. If your reads are heavily trimmed or the signal is corrupted at the start/end, classification will fail.
- **Model Limitations**: Deepbinner is pre-trained for 12 barcodes. If using 96-barcode kits, Deepbinner is not the appropriate tool unless you intend to train a custom model.
- **Performance**: If processing is slow on a CPU, ensure you are using the `classify` command on a directory rather than individual files to reduce overhead.

## Reference documentation
- [Deepbinner GitHub Repository](./references/github_com_rrwick_Deepbinner.md)
- [Deepbinner Wiki and Usage](./references/github_com_rrwick_Deepbinner_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepbinner_overview.md)