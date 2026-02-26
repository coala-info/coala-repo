# famus CWL Generation Report

## famus_famus-install

### Tool Description
Download and install FAMUS pre-trained models

### Metadata
- **Docker Image**: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
- **Homepage**: https://github.com/burstein-lab/famus
- **Package**: https://anaconda.org/channels/bioconda/packages/famus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/famus/overview
- **Total Downloads**: 136
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/burstein-lab/famus
- **Stars**: N/A
### Original Help Text
```text
usage: famus-install [-h] [--no-log] [--log-dir LOG_DIR] [--config CONFIG]
                     [--models-dir MODELS_DIR] --models MODELS [--keep-tars]
                     [--download-dir DOWNLOAD_DIR]

Download and install FAMUS pre-trained models

options:
  -h, --help            show this help message and exit
  --no-log              Disable logging. [False]
  --log-dir LOG_DIR     Directory to save logs. [/root/.famus/logs]
  --config CONFIG       Path to config file
  --models-dir MODELS_DIR
                        Directory to save the installed models to
  --models MODELS       Models to install (format: model_type, e.g.,
                        kegg_comprehensive,orthodb_light)
  --keep-tars           Keep downloaded tar files after extraction
  --download-dir DOWNLOAD_DIR
                        Directory to download tar files to (default: current
                        directory)

Examples:

  # Install specific models
  famus-install --models kegg_comprehensive,orthodb_light
  
  # Install all comprehensive models
  famus-install --models kegg_comprehensive,orthodb_comprehensive,interpro_comprehensive,eggnog_comprehensive
  
  # Install to custom directory
  famus-install --models kegg_light --models-dir /path/to/my/models
  
  # Keep downloaded tar files
  famus-install --models kegg_light --keep-tars

Available models: kegg, orthodb, interpro, eggnog
Available types: comprehensive, light

Format: <model>_<type> (e.g., kegg_comprehensive, orthodb_light)

Full description of arguments can be found at https://github.com/burstein-lab/famus
```


## famus_famus-convert-sdf

### Tool Description
Convert sdf_train.json files of installed models to pickle format.

### Metadata
- **Docker Image**: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
- **Homepage**: https://github.com/burstein-lab/famus
- **Package**: https://anaconda.org/channels/bioconda/packages/famus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: famus-convert-sdf [-h] [--no-log] [--log-dir LOG_DIR] [--config CONFIG]
                         [--models-dir MODELS_DIR] [--n-processes N_PROCESSES]
                         [--device DEVICE] [--chunksize CHUNKSIZE]

Convert sdf_train.json files of installed models to pickle format.

options:
  -h, --help            show this help message and exit
  --no-log              Disable logging. [False]
  --log-dir LOG_DIR     Directory to save logs. [/root/.famus/logs]
  --config CONFIG       Path to config file
  --models-dir MODELS_DIR
                        Directory to save or load models.
                        [/root/.famus/models]
  --n-processes N_PROCESSES
                        Number of processes to use. [4]
  --device DEVICE       Device to use (cpu or cuda). [cuda]
  --chunksize CHUNKSIZE
                        Number of sequences to process at once for
                        classification or threshold calculation. [20000]

Example usage:

  # famus-convert-sdf

  Full description of this module can be found at https://github.com/burstein-lab/famus
```


## famus_famus-classify

### Tool Description
Classify protein sequences using installed models.

### Metadata
- **Docker Image**: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
- **Homepage**: https://github.com/burstein-lab/famus
- **Package**: https://anaconda.org/channels/bioconda/packages/famus/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: PyTorch is not installed. Please install PyTorch to use the model module.
WARNING: PyTorch is not installed. Please install PyTorch to use the classification module.
usage: famus-classify [-h] [--no-log] [--log-dir LOG_DIR] [--config CONFIG]
                      [--models-dir MODELS_DIR] [--n-processes N_PROCESSES]
                      [--device DEVICE] [--chunksize CHUNKSIZE]
                      [--models MODELS] [--model-type MODEL_TYPE]
                      [--load-sdf-from-pickle | --no-load-sdf-from-pickle]
                      input_fasta_file_path output_dir

Classify protein sequences using installed models.

positional arguments:
  input_fasta_file_path
                        Path to input fasta file
  output_dir            Output directory

options:
  -h, --help            show this help message and exit
  --no-log              Disable logging. [False]
  --log-dir LOG_DIR     Directory to save logs. [/root/.famus/logs]
  --config CONFIG       Path to config file
  --models-dir MODELS_DIR
                        Directory to save or load models.
                        [/root/.famus/models]
  --n-processes N_PROCESSES
                        Number of processes to use. [4]
  --device DEVICE       Device to use (cpu or cuda). [cuda]
  --chunksize CHUNKSIZE
                        Number of sequences to process at once for
                        classification or threshold calculation. [20000]
  --models MODELS       Models to use for classification separated by commas
  --model-type MODEL_TYPE
                        Type of model(s) to use (comprehensive or light).
                        [comprehensive]
  --load-sdf-from-pickle, --no-load-sdf-from-pickle
                        Load sdf_train from pickle instead of json for
                        slightly faster classification preprocessing. Requires
                        first running famus-convert-sdf for conda users or
                        python -m famus.cli.convert_sdf for source code users
                        after models have been downloaded / trained. [False]

Example usage:

  # famus-classify --log-dir logs/ --n-processes 32 --device cpu --model-type comprehensive --models-dir models/ --models kegg examples/example_for_classification.fasta output/

  Full description of arguments can be found at https://github.com/burstein-lab/famus
```


## famus_famus-defaults

### Tool Description
Default FAMUS configuration parameters. These parameters can be customized by creating a YAML config file.

### Metadata
- **Docker Image**: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
- **Homepage**: https://github.com/burstein-lab/famus
- **Package**: https://anaconda.org/channels/bioconda/packages/famus/overview
- **Validation**: PASS

### Original Help Text
```text
Default FAMUS configuration:
log_dir: /root/.famus/logs
no_log: False
n_processes: 4
models_dir: /root/.famus/models
num_epochs: 50
batches_per_epoch: 10000
chunksize: 20000
device: cuda
model_type: comprehensive
create_subclusters: True
mmseqs_n_processes: 4
sampled_sequences_per_subcluster: 60
fraction_of_sampled_unknown_sequences: 1.0
samples_profiles_product_limit: 150000000000000
sequences_max_len_product_limit: 500000000
mmseqs_cluster_coverage: 0.8
mmseqs_cluster_identity: 0.9
mmseqs_coverage_subclusters: 0.5
log_to_wandb: False
wandb_project: famus
wandb_api_key_path: wandb_api_key.txt
stop_before_training: False
load_sdf_from_pickle: False
overwrite_checkpoint: False
continue_from_checkpoint: False
========================================
You can customize these parameters by creating a YAML config file.
See https://github.com/burstein-lab/famus for more information.
```

