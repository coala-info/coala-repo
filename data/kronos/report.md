# kronos CWL Generation Report

## kronos_make_component

### Tool Description
make a template component

### Metadata
- **Docker Image**: quay.io/biocontainers/kronos:2.3.0--py_0
- **Homepage**: https://github.com/jtaghiyar/kronos
- **Package**: https://anaconda.org/channels/bioconda/packages/kronos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kronos/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jtaghiyar/kronos
- **Stars**: N/A
### Original Help Text
```text
usage: kronos make_component [-h] component_name

make a template component

positional arguments:
  component_name  a name for the component to be generated

optional arguments:
  -h, --help      show this help message and exit
```


## kronos_make_config

### Tool Description
make a template config file

### Metadata
- **Docker Image**: quay.io/biocontainers/kronos:2.3.0--py_0
- **Homepage**: https://github.com/jtaghiyar/kronos
- **Package**: https://anaconda.org/channels/bioconda/packages/kronos/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kronos make_config [-h] -o OUTPUT_FILENAME components [components ...]

make a template config file

positional arguments:
  components            list of component names

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FILENAME, --output_filename OUTPUT_FILENAME
                        a name for the resultant config file
```


## kronos_update_config

### Tool Description
update the fields of a config file based on the ones from another one

### Metadata
- **Docker Image**: quay.io/biocontainers/kronos:2.3.0--py_0
- **Homepage**: https://github.com/jtaghiyar/kronos
- **Package**: https://anaconda.org/channels/bioconda/packages/kronos/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kronos update_config [-h] -o OUTPUT_FILENAME FILE [FILE ...]

update the fields of a config file based on the ones from another one

positional arguments:
  FILE                  paths to the config files, e.g. update_config
                        <old_config.yaml> <new_config.yaml>

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FILENAME, --output_filename OUTPUT_FILENAME
                        a name for the output file
```


## kronos_init

### Tool Description
initialize a pipeline from a given config file

### Metadata
- **Docker Image**: quay.io/biocontainers/kronos:2.3.0--py_0
- **Homepage**: https://github.com/jtaghiyar/kronos
- **Package**: https://anaconda.org/channels/bioconda/packages/kronos/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kronos init [-h] -e PIPELINE_NAME [-i FILE] [-s FILE] -y FILE

initialize a pipeline from a given config file

optional arguments:
  -h, --help            show this help message and exit
  -e PIPELINE_NAME, --pipeline_name PIPELINE_NAME
                        a name for the resultant pipeline
  -i FILE, --input_samples FILE
                        path to the samples file
  -s FILE, --setup_file FILE
                        path to the setup file
  -y FILE, --config_file FILE
                        path to the config_file.yaml
```


## kronos_run

### Tool Description
run kronos-made pipelines with optional initialization

### Metadata
- **Docker Image**: quay.io/biocontainers/kronos:2.3.0--py_0
- **Homepage**: https://github.com/jtaghiyar/kronos
- **Package**: https://anaconda.org/channels/bioconda/packages/kronos/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kronos run [-h] [-b {sge,drmaa}] -c COMPONENTS_DIR
                  [-d DRMAA_LIBRARY_PATH] [-e PIPELINE_NAME] [-i FILE]
                  [-j NUM_JOBS] [-k FILE] [-n NUM_PIPELINES]
                  [-p PYTHON_INSTALLATION] [-q QSUB_OPTIONS] [-r RUN_ID]
                  [-s FILE] [-w WORKING_DIR] [-y FILE] [--no_prefix]

run kronos-made pipelines with optional initialization

optional arguments:
  -h, --help            show this help message and exit
  -b {sge,drmaa}, --job_scheduler {sge,drmaa}
                        job scheduler used to manage jobs on the cluster
  -c COMPONENTS_DIR, --components_dir COMPONENTS_DIR
                        path to components_dir
  -d DRMAA_LIBRARY_PATH, --drmaa_library_path DRMAA_LIBRARY_PATH
                        path of drmaa library
  -e PIPELINE_NAME, --pipeline_name PIPELINE_NAME
                        pipeline name
  -i FILE, --input_samples FILE
                        path to the input samples file
  -j NUM_JOBS, --num_jobs NUM_JOBS
                        maximum number of simultaneous jobs per pipeline
  -k FILE, --kronos_pipeline FILE
                        path to kronos-made pipeline script.
  -n NUM_PIPELINES, --num_pipelines NUM_PIPELINES
                        maximum number of simultaneous running pipelines
  -p PYTHON_INSTALLATION, --python_installation PYTHON_INSTALLATION
                        path to python executable
  -q QSUB_OPTIONS, --qsub_options QSUB_OPTIONS
                        native qsub specifications for the cluster in a single
                        string
  -r RUN_ID, --run_id RUN_ID
                        pipeline run id
  -s FILE, --setup_file FILE
                        path to the setup file
  -w WORKING_DIR, --working_dir WORKING_DIR
                        path to the working_dir
  -y FILE, --config_file FILE
                        path to the config_file.yaml
  --no_prefix           switch off the prefix that is added to all the output
                        files.
```

