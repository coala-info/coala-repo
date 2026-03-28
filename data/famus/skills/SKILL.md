---
name: famus
description: FAMUS is a bioinformatics framework that uses supervised contrastive learning and neural networks to assign functional annotations to protein sequences. Use when user asks to install pre-trained models, classify unknown protein sequences, or train custom models on specific protein families.
homepage: https://github.com/burstein-lab/famus
---


# famus

## Overview

FAMUS (Functional Annotation Method Using Supervised contrastive learning) is a bioinformatics framework designed to assign functional annotations to protein sequences. Unlike traditional homology-based methods that rely solely on sequence alignment, FAMUS uses Siamese neural networks and supervised contrastive learning to transform sequences into numeric vectors. These vectors are then compared against a reference database to find the most functionally similar matches. This skill provides the necessary procedural knowledge to install pre-trained models, classify unknown sequences, and train new models on custom datasets.

## Installation and Setup

Before running classification or training, ensure the environment is prepared and models are downloaded.

### Model Installation
Use `famus-install` to fetch pre-trained models from Zenodo.
```bash
# Download specific models to a local directory
famus-install --models kegg_comprehensive,interpro_light --models-dir ./famus_models
```

### Performance Optimization
Convert downloaded JSON data to pickle format to significantly decrease data loading times during execution.
```bash
famus-convert-sdf --models-dir ./famus_models
```

## Classifying Sequences

The `famus-classify` tool is the primary interface for annotating sequences.

### Basic Classification
```bash
famus-classify <input.fasta> <output_directory> --models kegg,interpro --model-type comprehensive
```

### Expert Tips for Classification
- **Model Selection**: Use `light` models for faster processing with a minor trade-off in accuracy. Use `comprehensive` models for maximum sensitivity.
- **Hardware Acceleration**: Always specify `--device cuda` if a GPU is available to speed up the neural network inference.
- **Resource Management**: Adjust `--n-processes` to match your CPU core count and `--chunksize` (default 20,000) to manage memory usage when dealing with very large FASTA files.
- **Explicit Models**: You must explicitly list the models you wish to use via the `--models` flag or they will not be loaded.

## Training Custom Models

FAMUS allows for the creation of specialized models for niche protein families.

### Training Requirements
- **Positive Examples**: One FASTA file per protein family.
- **Negative Examples**: A large set of sequences known not to belong to the target families.
- **Resuming**: FAMUS tracks progress; running the same command on the same data directory will automatically resume an interrupted job.

### Training Execution
```bash
famus-train --data-dir <path_to_fastas> --output-dir <model_output> --num-epochs 10
```

## Configuration Management

FAMUS uses a hierarchy for parameters:
1. Command line arguments (Highest priority)
2. YAML Configuration file
3. Default parameters (Lowest priority)

To view the current active defaults, run:
```bash
famus-defaults
```



## Subcommands

| Command | Description |
|---------|-------------|
| famus | Default FAMUS configuration parameters. These parameters can be customized by creating a YAML config file. |
| famus-classify | Classify protein sequences using installed models. |
| famus-convert-sdf | Convert sdf_train.json files of installed models to pickle format. |
| famus-install | Download and install FAMUS pre-trained models |

## Reference documentation

- [FAMUS GitHub README](./references/github_com_burstein-lab_famus_blob_main_README.md)
- [Example Configuration](./references/github_com_burstein-lab_famus_blob_main_example_cfg.yaml.md)
- [Setup and Entry Points](./references/github_com_burstein-lab_famus_blob_main_setup.py.md)