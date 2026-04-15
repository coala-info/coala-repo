---
name: kipoi
description: Kipoi is a standardized repository and software framework for accessing, managing, and running trained machine learning models in genomics. Use when user asks to list available genomic models, manage model-specific Conda environments, or execute predictions on DNA sequences using the command-line interface or Python API.
homepage: https://github.com/kipoi/kipoi
metadata:
  docker_image: "quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0"
---

# kipoi

## Overview
Kipoi is a standardized repository and software framework designed to facilitate the exchange and reuse of trained machine learning models in genomics. It provides a unified interface to a vast "zoo" of models (such as Basset, DeepSEA, and Xpresso) that predict genomic features from DNA sequences. This skill enables the management of model-specific dependencies via Conda, the execution of predictions on genomic data, and the integration of these models into bioinformatics pipelines using either the command-line interface or the Python library.

## Installation and Environment Management
Kipoi relies heavily on Conda to manage the complex and often conflicting dependencies of different genomic models.

- **Install Kipoi**: `pip install kipoi`
- **Create a model environment**: `kipoi env create <model_name>`
- **Get environment name**: `kipoi env get <model_name>`
- **Activate environment**: `source activate $(kipoi env get <model_name>)`

### Common Shared Environments
Instead of creating an environment for every single model, you can use shared environments for common frameworks:
- `kipoi env create shared/envs/kipoi-py3-keras2-tf1`
- `kipoi env create shared/envs/kipoi-py3-keras2-tf2`

## Command Line Interface (CLI) Patterns
The CLI is the primary way to interact with Kipoi for quick predictions and model exploration.

- **List available models**: `kipoi list`
- **Search for models**: `kipoi ls | grep <keyword>`
- **Run prediction**:
  ```bash
  kipoi predict <model_name> \
    --dataloader_args='{"intervals_file": "data/intervals.bed", "fasta_file": "data/genome.fa"}' \
    --output <output_file.h5>
  ```
- **Use Singularity/Apptainer**: Add the `--singularity` flag to run models in isolated containers without local dependency issues.
  `kipoi predict <model_name> --singularity ...`

## Python API Usage
For deeper integration, use the Python API within the appropriate Conda environment.

```python
import kipoi

# Load a model
model = kipoi.get_model("Basset")

# Access model metadata
print(model.info.authors)
print(model.schema.inputs)

# Run prediction on a batch of data
# Note: Data must be formatted according to the model's dataloader
prediction = model.predict_on_batch(data)
```

## Expert Tips and Troubleshooting
- **h5py Compatibility**: For Python 3.6/3.7, if you encounter Keras/TensorFlow loading errors, downgrade h5py: `pip install h5py==2.10.0`.
- **Dependency Prerequisites**: On newer Python versions (3.8-3.10), ensure `hdf5` and `pkgconfig` are installed via Conda before installing Kipoi.
- **Source Permalinks**: To ensure reproducibility, load models from specific GitHub commits:
  `kipoi.get_model("https://github.com/kipoi/models/tree/<commit>/<model>", source='github-permalink')`
- **Data Loaders**: Every model has a specific dataloader. Use `kipoi get_dataloader <model_name>` to inspect required arguments like FASTA files or BED intervals.



## Subcommands

| Command | Description |
|---------|-------------|
| kipoi env | Kipoi model-zoo command line tool |
| kipoi ls | Lists available models |
| kipoi predict | Run the model prediction. |
| kipoi preproc | Run the dataloader and save the output to an hdf5 file. |
| kipoi pull | Downloads the directory associated with the model. |
| kipoi test | script to test model zoo submissions. Example usage: `kipoi test model/directory`, where `model/directory` is the path to a directory containing a model.yaml file. |
| kipoi test-source | Test models in model source |
| kipoi_get-example | Get example files |
| kipoi_info | Prints dataloader keyword arguments. |
| kipoi_init | Initializing a new Kipoi model |
| kipoi_list_plugins | List installed Kipoi plugins |

## Reference documentation
- [Kipoi GitHub README](./references/github_com_kipoi_kipoi_blob_master_README.md)
- [Contributing to Kipoi](./references/github_com_kipoi_kipoi_blob_master_CONTRIBUTING.md)
- [Python API Notebook](./references/github_com_kipoi_kipoi_blob_master_notebooks_python-api.ipynb.md)