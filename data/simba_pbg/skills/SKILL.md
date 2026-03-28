---
name: simba_pbg
description: simba_pbg generates high-dimensional feature vectors from large-scale graph data using a memory-efficient PyTorch-BigGraph engine. Use when user asks to train knowledge graph embedding models, convert TSV files into PBG binary format, or process graphs that exceed available RAM through partitioning.
homepage: https://github.com/pinellolab/simba_pbg
---

# simba_pbg

## Overview
The `simba_pbg` skill provides a specialized workflow for utilizing the customized PyTorch-BigGraph engine. Unlike standard embedding tools, `simba_pbg` is optimized for memory efficiency through graph partitioning, allowing it to process graphs that exceed the RAM of a single machine. It transforms graph edges (source, target, and relation type) into high-dimensional feature vectors where proximity in vector space reflects structural similarity in the graph. This skill is essential for users working within the SIMBA ecosystem or those requiring high-performance CPU-based graph embedding generation.

## Installation and Setup
Install the package via bioconda to ensure all dependencies for the SIMBA suite are correctly resolved:

```bash
conda install -c bioconda simba_pbg
```

For development or GPU-enabled versions (experimental), install from source:
```bash
# Standard CPU version
pip install .

# GPU-enabled version (requires C++ compilation)
PBG_INSTALL_CPP=1 pip install .
```

## Core CLI Operations
The tool provides several entry points for training and evaluation.

### Running Examples
To verify the installation and understand the workflow, run the built-in FB15k knowledge base example:
```bash
torchbiggraph_example_fb15k
```

### Training Workflows
The primary training command varies depending on your hardware configuration:

- **CPU Training (Standard):**
  ```bash
  torchbiggraph_train <config_file_path>
  ```
- **GPU Training (Experimental):**
  ```bash
  torchbiggraph_train_gpu <config_file_path>
  ```

### Data Preparation
Before training, input TSV files (source \t relation \t target) must be converted into the PBG binary format:
```bash
torchbiggraph_import_from_tsv <config_file_path> <input_tsv_path>
```

## Expert Tips and Best Practices
- **Graph Scale:** Do not use `simba_pbg` for small graphs (under 100,000 nodes). For smaller datasets, models like ComplEx implemented in the KBC package are more effective.
- **Memory Management:** If you encounter Out-of-Memory (OOM) errors, increase the number of partitions in your configuration. This forces the engine to swap disjoint parts of the graph to disk.
- **Hardware Optimization:** PBG is heavily optimized for CPU multi-threading. Ensure your environment has a high core count and high-bandwidth interconnect (10 Gbps+) if running in a distributed setup.
- **Negative Sampling:** Use batched negative sampling to maintain high throughput. PBG can process over 1 million edges per second per machine when configured with 100 negatives per edge.
- **Relation Types:** Leverage multiple relation types to share entity embeddings across different interaction categories, which improves the "proximity score" accuracy.



## Subcommands

| Command | Description |
|---------|-------------|
| torchbiggraph_import_from_tsv | Imports edges from TSV files into a format suitable for TorchBigGraph. |
| torchbiggraph_train | Train a knowledge graph embedding model. |

## Reference documentation
- [PyTorch-BigGraph README](./references/github_com_pinellolab_simba_pbg_blob_master_README.md)
- [Installation Guide](./references/anaconda_org_channels_bioconda_packages_simba_pbg_overview.md)
- [FB15k Example Script](./references/github_com_pinellolab_simba_pbg_blob_master_torchbiggraph_examples_fb15k.py.md)