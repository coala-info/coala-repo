---
name: kipoi
description: Kipoi provides a standardized API and repository for accessing and running trained genomic models across various deep learning frameworks. Use when user asks to list available models, create model-specific environments, or run predictions on genomic data using the CLI or Python API.
homepage: https://github.com/kipoi/kipoi
---


# kipoi

## Overview
Kipoi is a standardized API and repository for sharing and using trained models in genomics. It addresses the challenge of model portability by providing a unified interface for different frameworks (Keras, PyTorch, TensorFlow) and automating the setup of model-specific dependencies. Although the project has entered a "sunset" phase and is archived, the existing model zoo remains a valuable resource for researchers to reuse and benchmark established predictive models. This skill enables efficient interaction with the Kipoi ecosystem via its CLI and Python API.

## Installation and Setup
Kipoi relies on Conda to manage the complex dependencies of various genomic models.

- **Install Kipoi**: `pip install kipoi`
- **System Dependencies**: For Python >= 3.8, install HDF5 and pkgconfig first:
  `conda install -c conda-forge hdf5 pkgconfig`
- **Legacy Support**: For Python 3.6/3.7 using Keras/TensorFlow models, you may need to downgrade h5py:
  `pip install h5py==2.10.0`

## CLI Usage Patterns
The command-line interface is the primary way to manage environments and run batch predictions.

### Model Exploration
- **List all models**: `kipoi ls`
- **View model details**: `kipoi info <model_name>`
- **Download example files**: `kipoi get-example <model_name> -o output_dir`

### Environment Management
Each model often requires a specific software stack. Use the `env` command to avoid dependency conflicts.
- **Create model environment**: `kipoi env create <model_name>`
- **Activate environment**: `source activate $(kipoi env get <model_name>)`
- **Common environments**: Kipoi provides shared environments for standard stacks:
  - `kipoi env create shared/envs/kipoi-py3-keras2-tf2`

### Running Predictions
- **Standard prediction**:
  `kipoi predict <model_name> --dataloader_args='{"intervals_file": "input.bed", "fasta_file": "genome.fa"}' -o results.h5`
- **Using Singularity**: If Apptainer/Singularity is installed, run models without local dependency installation:
  `kipoi predict <model_name> --dataloader_args='...' --singularity -o results.h5`

## Python API
For integration into bioinformatics pipelines, use the Python interface.

```python
import kipoi

# Load a model
model = kipoi.get_model("Basset")

# Access metadata
print(model.info.authors)

# Run prediction on a batch of numpy arrays
# predictions = model.predict_on_batch(x)

# Run the full pipeline (Dataloader + Model)
# This handles raw genomic files directly
predictions = model.pipeline.predict({"fasta_file": "hg19.fa", "intervals_file": "intervals.bed"})
```

## Expert Tips
- **Sunset Status**: Be aware that the main repository is archived. If a model fails to download, check the `github-permalink` source to load from a specific historical commit.
- **Data Loading**: For custom sequence-based modeling, use `kipoiseq`, which remains the active standard for Kipoi-compatible data loaders.
- **Containerization**: Prefer the `--singularity` flag for CLI predictions to ensure reproducibility and avoid local Conda environment bloat.
- **Slim vs Full Docker**: When using Docker, "slim" images are optimized for running predictions, while "full" images include the Conda manager for experimentation.

## Reference documentation
- [Kipoi GitHub Repository](./references/github_com_kipoi_kipoi.md)
- [Kipoi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kipoi_overview.md)