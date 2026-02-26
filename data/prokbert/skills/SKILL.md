---
name: prokbert
description: ProkBERT is a genomic language model architecture designed to process and analyze microbiome sequences using local context-aware tokenization. Use when user asks to process raw FASTA sequences into genomic representations, identify bacterial promoters, or detect phage sequences within complex datasets.
homepage: https://github.com/nbrg-ppcu/prokbert
---


# prokbert

## Overview

ProkBERT is a specialized genomic language model architecture based on BERT, specifically optimized for microbiome applications. It introduces Local Context-Aware (LCA) tokenization, which allows the model to capture rich local genomic context without the typical context size limitations of standard transformers. Use this skill to process raw FASTA sequences into meaningful representations, identify bacterial promoters, or detect phage sequences within complex datasets.

## Installation and Setup

ProkBERT can be installed via pip or conda. For GPU support, ensure the appropriate CUDA-enabled PyTorch version is installed first.

```bash
# Recommended installation via pip
pip install git+https://github.com/nbrg-ppcu/prokbert.git

# Installation via Bioconda
conda install prokbert -c bioconda
```

## Core Workflows

### 1. Loading Pre-trained Models
ProkBERT models are hosted on Hugging Face under the `neuralbioinfo` organization. The `prokbert-mini` model is the standard starting point.

```python
import torch
from transformers import AutoTokenizer, AutoModel

# Load model and tokenizer (requires trust_remote_code=True for LCA tokenizer)
tokenizer = AutoTokenizer.from_pretrained("neuralbioinfo/prokbert-mini", trust_remote_code=True)
model = AutoModel.from_pretrained("neuralbioinfo/prokbert-mini", trust_remote_code=True)

# Example sequence processing
segment = "TATGTAACATAATGCGACCAATAATCGTAATGAATATGAGAAGTGTGATATTATAACATTTCATGACTACTGCAAGACTAA"
inputs = tokenizer(segment, return_tensors="pt")
outputs = model(**inputs)
```

### 2. Sequence Segmentation and Tokenization
Before feeding sequences into the model, they must be segmented. ProkBERT uses k-mer based tokenization with specific shifts.

*   **Segmentation**: Breaking long genomic sequences (FASTA) into manageable chunks.
*   **LCA Tokenization**: Converting segments into tokens while preserving local context.

### 3. Fine-tuning for Classification
To adapt ProkBERT for specific tasks like promoter prediction, use the provided fine-tuning utilities.

**CLI Pattern for Fine-tuning:**
```bash
python examples/finetuning.py \
    --model_name neuralbioinfo/prokbert-mini \
    --ftmodel my_promoter_model \
    --model_outputpath ./output \
    --num_train_epochs 5 \
    --per_device_train_batch_size 128
```

## Best Practices and Expert Tips

*   **Tokenizer Trust**: Always set `trust_remote_code=True` when loading ProkBERT models via the `transformers` library, as the LCA tokenizer uses custom implementation logic not present in the base library.
*   **Model Selection**: 
    *   `prokbert-mini`: Standard 6-mer model with a shift of 1.
    *   `prokbert-mini-c`: 1-mer model for different resolution needs.
*   **Performance**: For large-scale training or inference on genomic datasets, utilize `DistributedDataParallel` (DDP) to scale across multiple GPUs.
*   **Zero-shot Capabilities**: ProkBERT can be used to generate embeddings for sequences to visualize phylogenetic relationships or genomic features without additional training.

## Reference documentation
- [GitHub Repository - nbrg-ppcu/prokbert](./references/github_com_nbrg-ppcu_prokbert.md)
- [ProkBERT Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_prokbert_overview.md)