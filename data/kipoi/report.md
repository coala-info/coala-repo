# kipoi CWL Generation Report

## kipoi_ls

### Tool Description
Lists available models

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Total Downloads**: 85.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kipoi/kipoi
- **Stars**: N/A
### Original Help Text
```text
usage: kipoi ls [-h] [--tsv] [--source {kipoi,github-permalink,dir}]
                [group_filter]

Lists available models

positional arguments:
  group_filter          A relative path to the model group used to subset the
                        model list. Use 'all' to show all models

options:
  -h, --help            show this help message and exit
  --tsv                 Print the output in the tsv format.
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=kipoi). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
```


## kipoi_list_plugins

### Tool Description
List installed Kipoi plugins

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
plugin  installed  cli                                                                            description                                      url
kipoi_interpret      False True Model interpretation using feature importance scores like ISM, grad*input or DeepLIFT. https://github.com/kipoi/kipoi-interpret
```


## kipoi_info

### Tool Description
Prints dataloader keyword arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi info [-h] [--source {kipoi,github-permalink,dir}]
                  [--dataloader DATALOADER]
                  [--dataloader_source DATALOADER_SOURCE]
                  model

Prints dataloader keyword arguments.

positional arguments:
  model                 Model name.

options:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=kipoi). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
  --dataloader DATALOADER
                        Dataloader name. If not specified, the model's
                        defaultDataLoader will be used
  --dataloader_source DATALOADER_SOURCE
                        Dataloader source
```


## kipoi_get-example

### Tool Description
Get example files

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi get-example [-h] [--source {kipoi,github-permalink,dir}]
                         [-o OUTPUT]
                         model

Get example files

positional arguments:
  model                 Model name.

options:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=kipoi). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
  -o OUTPUT, --output OUTPUT
                        Output directory where to store the examples. Default:
                        'example'
```


## kipoi_predict

### Tool Description
Run the model prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi predict [-h] [--source {kipoi,github-permalink,dir}]
                     [--dataloader DATALOADER]
                     [--dataloader_source DATALOADER_SOURCE]
                     [--dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]]
                     [--batch_size BATCH_SIZE] [-n NUM_WORKERS] [-k] [-m]
                     [-l LAYER] [--singularity] -o OUTPUT [OUTPUT ...]
                     model

Run the model prediction.

positional arguments:
  model                 Model name.

options:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=kipoi). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
  --dataloader DATALOADER
                        Dataloader name. If not specified, the model's
                        defaultDataLoader will be used
  --dataloader_source DATALOADER_SOURCE
                        Dataloader source
  --dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]
                        DataLoader arguments either as a json string:'{"arg1":
                        1} or as a file path to a json file
  --batch_size BATCH_SIZE
                        Batch size to use in prediction
  -n NUM_WORKERS, --num_workers NUM_WORKERS
                        Number of parallel workers for loading the dataset
  -k, --keep_inputs     Keep the inputs in the output file.
  -m, --keep_metadata   Keep the metadata in the output file.
  -l LAYER, --layer LAYER
                        Which output layer to use to make the predictions. If
                        specified,`model.predict_activation_on_batch` will be
                        invoked instead of `model.predict_on_batch`
  --singularity         Run `kipoi predict` in the appropriate singularity
                        container. Containters will get downloaded to
                        ~/.kipoi/envs/ or to $SINGULARITY_CACHEDIR if set
  -o OUTPUT [OUTPUT ...], --output OUTPUT [OUTPUT ...]
                        Output files. File format is inferred from the file
                        path ending. Available file formats are: .h5, .hdf5,
                        .pq, .parquet, .zarr, .pqt, .tsv, .bed
```


## kipoi_pull

### Tool Description
Downloads the directory associated with the model.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi pull [-h] [--source {kipoi,github-permalink,dir}] model

Downloads the directory associated with the model.

positional arguments:
  model                 Model name. <model> can also refer to a model-group -
                        e.g. if you specify MaxEntScan then the dependencies
                        for MaxEntScan/5prime and MaxEntScan/3prime will be
                        installed

options:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=kipoi). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
```


## kipoi_preproc

### Tool Description
Run the dataloader and save the output to an hdf5 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi preproc [-h] [--source {kipoi,github-permalink,dir}]
                     [--dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]]
                     [--batch_size BATCH_SIZE] [-m] [-n NUM_WORKERS] -o OUTPUT
                     dataloader

Run the dataloader and save the output to an hdf5 file.

positional arguments:
  dataloader            Dataloader name.

options:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Dataloader source to use. Specified in
                        ~/.kipoi/config.yaml under model_sources. 'dir' is an
                        additional source referring to the local folder.
  --dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]
                        DataLoader arguments either as a json string:'{"arg1":
                        1} or as a file path to a json file
  --batch_size BATCH_SIZE
                        Batch size to use in data loading
  -m, --keep_metadata   Keep the metadata in the output file.
  -n NUM_WORKERS, --num_workers NUM_WORKERS
                        Number of parallel workers for loading the dataset
  -o OUTPUT, --output OUTPUT
                        Output hdf5 file
```


## kipoi_env

### Tool Description
Kipoi model-zoo command line tool

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi env <command> [-h] ...

    # Available sub-commands:
    export       Export the environment.yaml file for a specific model
    create       Create a conda environment for a model
    cleanup      Remove environments that failed during installation
    remove       Remove environment compatible with a model
    list         List all kipoi-induced conda environments
    get          Get environment name for given model
    get_cli      Get path to Kipoi CLI for a given model
    install      Install all the dependencies for a model into the current conda environment
    

Kipoi model-zoo command line tool

positional arguments:
  command     Subcommand to run; possible commands: export, create, cleanup,
              remove, list, get, get_cli, install, name

options:
  -h, --help  show this help message and exit
```


## kipoi_init

### Tool Description
Initializing a new Kipoi model

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
[32mINFO[0m [44m[kipoi.cli.main][0m Initializing a new Kipoi model[0m

Please answer the questions below. Defaults are shown in square brackets.

You might find the following links useful: 
- getting started: http://www.kipoi.org/docs/contributing/01_Getting_started/
- model_type: http://www.kipoi.org/docs/contributing/02_Writing_model.yaml/#type
- dataloader_type: http://www.kipoi.org/docs/contributing/04_Writing_dataloader.py/#dataloader-types
--------------------------------------------

model_name [my_model]:
```


## kipoi_test

### Tool Description
script to test model zoo submissions. Example usage: `kipoi test
model/directory`, where `model/directory` is the path to a directory
containing a model.yaml file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi test [-h] [--source {kipoi,github-permalink,dir}]
                  [--batch_size BATCH_SIZE] [--keep_metadata] [-o OUTPUT] [-s]
                  [-e EXPECT]
                  model

script to test model zoo submissions. Example usage: `kipoi test
model/directory`, where `model/directory` is the path to a directory
containing a model.yaml file.

positional arguments:
  model                 Model name.

options:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=dir). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
  --batch_size BATCH_SIZE
                        Batch size to use in prediction
  --keep_metadata       Keep the metadata in the output file.
  -o OUTPUT, --output OUTPUT
                        Output hdf5 file
  -s, --skip-expect     Skip validating the expected predictions if
                        test.expect field is specified under model.yaml
  -e EXPECT, --expect EXPECT
                        File path to the hdf5 file of predictions produced by
                        kipoi test -o file.h5 or kipoi predict -o file.h5
                        --keep_inputs. Overrides test.expect in model.yaml
```


## kipoi_test-source

### Tool Description
Test models in model source

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi test-source [-h] [--git-range GIT_RANGE [GIT_RANGE ...]] [-n]
                         [-b BATCH_SIZE] [-x] [-k K] [-c] [--vep VEP]
                         [--common_env] [--all] [-v] [--shard_id SHARD_ID]
                         [--num_of_shards NUM_OF_SHARDS] [--singularity]
                         source

Test models in model source

positional arguments:
  source                Which source to test

options:
  -h, --help            show this help message and exit
  --git-range GIT_RANGE [GIT_RANGE ...]
                        Git range (e.g. commits or something like "master
                        HEAD" to check commits in HEAD vs master, or just
                        "HEAD" to include uncommitted changes). All models
                        modified within this range will be tested.
  -n, --dry_run         Dont run model testing
  -b BATCH_SIZE, --batch_size BATCH_SIZE
                        Batch size
  -x, --exitfirst       exit instantly on first error or failed test.
  -k K                  only run tests which match the given substring
                        expression
  -c, --clean_env       clean the environment after running.
  --vep VEP             This argument is deprecated. Please use
                        https://github.com/kipoi/kipoi-veff2 directly
  --common_env          Test models in common environments.
  --all                 Test all models in the source
  -v, --verbose         Increase output verbosity. Show conda stdout during
                        env installation.
  --shard_id SHARD_ID   Shard id
  --num_of_shards NUM_OF_SHARDS
                        Number of shards
  --singularity         Test models within their singularity containers
```


## Metadata
- **Skill**: generated
