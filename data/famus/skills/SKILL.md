---
name: famus
description: FAMUS is a specialized tool for protein function prediction that maps sequences into a high-dimensional vector space to identify functional categories. Use when user asks to download protein family models, convert model data for performance optimization, classify protein sequences, or train custom models for specific protein databases.
homepage: https://github.com/burstein-lab/famus
---


# famus

## Overview
FAMUS (Functional Annotation Method Using Supervised contrastive learning) is a specialized tool for protein function prediction. It maps protein sequences into a high-dimensional vector space using pre-trained models and identifies functional categories by finding the nearest neighbors in reference databases. This skill provides the necessary commands and best practices for managing models and running high-throughput annotations.

## Model Installation and Setup
Before classification, you must download the specific protein family models.

- **Download Models**: Use `famus-install` to fetch pre-trained models.
  ```bash
  famus-install --models kegg_light,interpro_light --models-dir ./famus_models
  ```
  *Available models:* `kegg`, `interpro`, `orthodb`, `eggnog` (each available as `_comprehensive` or `_light`).

- **Performance Optimization**: Convert downloaded JSON data to pickle format to significantly decrease loading times during inference.
  ```bash
  famus-convert-sdf --models-dir ./famus_models
  ```

## Sequence Classification
The primary tool for annotation is `famus-classify`.

- **Basic Usage**:
  ```bash
  famus-classify <input.fasta> <output_dir> --models kegg_light --models-dir ./famus_models
  ```

- **Advanced Options**:
  - `--device`: Set to `cuda` for GPU acceleration or `cpu`.
  - `--n-processes`: Specify CPU cores for parallel processing.
  - `--load-sdf-from-pickle`: Use this flag if you have previously run `famus-convert-sdf`.
  - `--model-type`: Choose `light` (faster) or `comprehensive` (more accurate).

## Model Training
FAMUS allows training custom models for specific protein databases.

- **Requirements**: One FASTA file per protein family and a set of negative examples.
- **Resuming**: If a training or classification run is interrupted, re-running the command with the same parameters and directory will attempt to resume. **Do not rename or move files** in the working directory if you intend to resume, as file names are often hardcoded for state tracking.

## Best Practices
- **PyTorch Dependency**: Ensure PyTorch is installed separately and matches your system's CUDA version, as the Conda package does not bundle it.
- **Memory Management**: Comprehensive models and large HMM profiles require several GBs of disk space and significant RAM. Use `light` models for initial screens or resource-constrained environments.
- **Logging**: By default, logs are created in the output directory. Use `--no-log` to disable or `--log-dir` to redirect them.
- **Default Parameters**: Run `famus-defaults` to view the current configuration and default paths (typically `~/.famus/models/`).

## Reference documentation
- [famus Overview](./references/anaconda_org_channels_bioconda_packages_famus_overview.md)
- [famus GitHub Repository](./references/github_com_burstein-lab_famus.md)