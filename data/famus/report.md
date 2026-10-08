# famus CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| famus_famus-classify | Failed | image problem: PyTorch is not installed in the image, so classification cannot run; models also need a download of 2.5 GB or more |
| famus_famus-convert-sdf | Not completed | needs installed models (2.5 GB or more download); training preprocessing writes only the pickle it would create |
| famus_famus-install | Not completed | the smallest model download is 2.5 GB (up to 11.7 GB), too large for this test |
| famus_famus-train | Failed | image problem: PyTorch is not installed in the image, so training cannot run; preprocessing with --stop-before-training works |

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


## famus_famus-train

### Tool Description
Train a FAMUS model

### Metadata
- **Docker Image**: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
- **Homepage**: https://github.com/burstein-lab/famus
- **Package**: https://anaconda.org/channels/bioconda/packages/famus/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: PyTorch is not installed. Please install PyTorch to use the model module.
WARNING: PyTorch is not installed. Please install PyTorch to use the classification module.
WARNING: PyTorch is not installed. Please install PyTorch to use the training module.
usage: famus-train [-h] [--no-log] [--log-dir LOG_DIR] [--config CONFIG]
                   [--models-dir MODELS_DIR] [--n-processes N_PROCESSES]
                   [--device DEVICE] [--chunksize CHUNKSIZE]
                   [--create-subclusters | --no-create-subclusters]
                   [--model-name MODEL_NAME]
                   [--unknown-sequences-fasta-path UNKNOWN_SEQUENCES_FASTA_PATH]
                   [--num-epochs NUM_EPOCHS]
                   [--batches-per-epoch BATCHES_PER_EPOCH]
                   [--stop-before-training]
                   [--mmseqs-n-processes MMSEQS_N_PROCESSES]
                   [--sampled-sequences-per-subcluster SAMPLED_SEQUENCES_PER_SUBCLUSTER]
                   [--fraction-of-sampled-unknown-sequences FRACTION_OF_SAMPLED_UNKNOWN_SEQUENCES]
                   [--samples-profiles-product-limit SAMPLES_PROFILES_PRODUCT_LIMIT]
                   [--sequences-max-len-product-limit SEQUENCES_MAX_LEN_PRODUCT_LIMIT]
                   [--mmseqs-cluster-coverage MMSEQS_CLUSTER_COVERAGE]
                   [--mmseqs-cluster-identity MMSEQS_CLUSTER_IDENTITY]
                   [--mmseqs-coverage-subclusters MMSEQS_COVERAGE_SUBCLUSTERS]
                   [--log-to-wandb | --no-log-to-wandb]
                   [--wandb-project WANDB_PROJECT]
                   [--wandb-api-key-path WANDB_API_KEY_PATH]
                   [--overwrite-checkpoint] [--continue-from-checkpoint]
                   input_fasta_dir_path

Train a FAMUS model

positional arguments:
  input_fasta_dir_path  Path to directory containing input fasta files
                        representing protein families. Must only include fasta
                        files.

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
  --create-subclusters, --no-create-subclusters
                        Whether to create subclusters within each protein
                        family (--create-subclusters for comprehensive model,
                        --no-create-subclusters for light model). [default:
                        True]
  --model-name MODEL_NAME
                        Optional name for the model which will be used to
                        request it during classification. The default value is
                        the name of the input directory.
  --unknown-sequences-fasta-path UNKNOWN_SEQUENCES_FASTA_PATH
                        Path to fasta file containing sequences not belonging
                        to any given protein family.
  --num-epochs NUM_EPOCHS
                        Number of epochs to train the model. If not specified,
                        will use cfg.yaml parameter. [50]
  --batches-per-epoch BATCHES_PER_EPOCH
                        Number of batches per epoch to train the model. If not
                        specified, will use cfg.yaml parameter. [10000]
  --stop-before-training
                        Stop right before training the model. Useful for
                        running preprocess and train separately. [False]
  --mmseqs-n-processes MMSEQS_N_PROCESSES
                        Number of processes to use for MMseqs2 during
                        preprocessing. [4]
  --sampled-sequences-per-subcluster SAMPLED_SEQUENCES_PER_SUBCLUSTER
                        Number of sequences to sample per subcluster for
                        training during preprocessing. [60]
  --fraction-of-sampled-unknown-sequences FRACTION_OF_SAMPLED_UNKNOWN_SEQUENCES
                        Fraction of unknown sequences to sample for training
                        during preprocessing. [1.0]
  --samples-profiles-product-limit SAMPLES_PROFILES_PRODUCT_LIMIT
                        Limit on the product of number of sampled sequences
                        and number of profiles during preprocessing.
                        [150000000000000]
  --sequences-max-len-product-limit SEQUENCES_MAX_LEN_PRODUCT_LIMIT
                        Limit on the product of number of sequences and their
                        maximum length during preprocessing. [500000000]
  --mmseqs-cluster-coverage MMSEQS_CLUSTER_COVERAGE
                        MMseqs2 cluster coverage parameter during
                        preprocessing. [0.8]
  --mmseqs-cluster-identity MMSEQS_CLUSTER_IDENTITY
                        MMseqs2 cluster identity parameter during
                        preprocessing. [0.9]
  --mmseqs-coverage-subclusters MMSEQS_COVERAGE_SUBCLUSTERS
                        MMseqs2 coverage for subclusters parameter during
                        preprocessing. [0.5]
  --log-to-wandb, --no-log-to-wandb
                        Whether to log training to Weights & Biases. [False]
  --wandb-project WANDB_PROJECT
                        Weights & Biases project name to use if logging to
                        wandb. [famus]
  --wandb-api-key-path WANDB_API_KEY_PATH
                        Path to file containing Weights & Biases API key to
                        use if logging to wandb. [wandb_api_key.txt]
  --overwrite-checkpoint
                        Whether to overwrite existing checkpoints during
                        training if they exist. [False]
  --continue-from-checkpoint
                        Whether to continue training from the latest
                        checkpoint if it exists. [False]

Example usage:

  # famus-train --unknown-sequences-fasta-path examples/unknowns.fasta --log-dir logs/ --n-processes 32 --models-dir models/ --device cpu --num-epochs 20 --batch-size 32 --create-subclusters examples/example_orthologs/

  Full description of arguments can be found at https://github.com/burstein-lab/famus
```

## Metadata
- **Skill**: generated
