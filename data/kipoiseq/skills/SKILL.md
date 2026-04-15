---
name: kipoiseq
description: kipoiseq provides standardized data-loaders to transform genomic files into tensors for DNA sequence-based models. Use when user asks to extract sequences from FASTA and BED files, perform one-hot encoding, integrate variants from VCF files, or implement parallel data loading for genomic deep learning.
homepage: https://github.com/kipoi/kipoiseq
metadata:
  docker_image: "quay.io/biocontainers/kipoiseq:0.7.1--pyhdfd78af_0"
---

# kipoiseq

## Overview

kipoiseq is a specialized library providing standardized data-loaders for DNA sequence-based models. It simplifies the process of transforming raw genomic files—such as FASTA (sequences), BED (regions), and VCF (variants)—into tensors or arrays suitable for training and inference. Use this skill to efficiently handle genomic data extraction, implement one-hot encoding, and manage parallel data loading for deep learning workflows in genomics.

## Installation and Setup

Install kipoiseq via bioconda or pip. Note that certain features require optional dependencies like `cyvcf2` and `pyranges`.

```bash
# Recommended installation via conda
conda install -c bioconda kipoiseq

# Optional dependencies for VCF and range processing
conda install cyvcf2 pyranges
```

## Core Data Loading Patterns

The primary interface for sequence extraction is the `SeqIntervalDl` class.

### Basic Sequence Extraction
To load sequences defined by a BED file from a reference genome:

```python
from kipoiseq.dataloaders import SeqIntervalDl

# Initialize the dataloader
dl = SeqIntervalDl("intervals.bed", "genome.fa")

# Access a single instance
# Returns: {'inputs': <array>, 'targets': <cols>, 'metadata': <ranges>}
first_item = dl[0]

# Load the entire dataset into memory
all_data = dl.load_all()
```

### Efficient Batching and Parallelism
For training loops, use the built-in iterators which support multi-processing.

```python
# Standard batch iterator (returns dictionaries)
it = dl.batch_iter(batch_size=32, num_workers=8)

# Training-specific iterator (returns (inputs, targets) tuples)
# Ideal for direct use with keras model.fit()
train_it = dl.batch_train_iter(batch_size=32, num_workers=8)
```

## Expert Tips and Best Practices

- **One-Hot Encoding**: By default, `SeqIntervalDl` returns one-hot encoded DNA sequences. If you require raw strings, use `StringSeqIntervalDl`.
- **Memory Management**: For large genomic datasets, avoid `load_all()`. Use `batch_iter` with a reasonable number of `num_workers` to balance CPU pre-processing and GPU training.
- **Variant Integration**: When working with variants, use `VariantSeqExtractor` to construct sample-specific genotypes by applying VCF records to the reference FASTA sequence.
- **Interval Resizing**: If your model requires a fixed input length (e.g., 1000bp) but your BED file contains variable lengths, use the `auto_resize_len` parameter during initialization to center and crop/pad intervals automatically.
- **Strand Awareness**: Ensure your BED file has the strand column if your model is strand-specific; kipoiseq can automatically handle reverse-complementing sequences based on the strand.

## Reference documentation
- [kipoiseq GitHub Repository](./references/github_com_kipoi_kipoiseq.md)
- [kipoiseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kipoiseq_overview.md)