# galaxy-workflow-executor CWL Generation Report

## galaxy-workflow-executor_generate_params_from_workflow.py

### Tool Description
Generate parameters from a Galaxy workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
- **Homepage**: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor
- **Package**: https://anaconda.org/channels/bioconda/packages/galaxy-workflow-executor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galaxy-workflow-executor/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor
- **Stars**: N/A
### Original Help Text
```text
usage: generate_params_from_workflow.py [-h] -C CONF [-G GALAXY_INSTANCE]
                                        [-o OUTPUT_DIR] -W WORKFLOW [--debug]
                                        [--include-internals]

optional arguments:
  -h, --help            show this help message and exit
  -C CONF, --conf CONF  A yaml file describing the galaxy credentials
  -G GALAXY_INSTANCE, --galaxy-instance GALAXY_INSTANCE
                        Galaxy server instance name
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Path to output directory
  -W WORKFLOW, --workflow WORKFLOW
                        Workflow to run
  --debug               Print debug information
  --include-internals   Include internal parameters
```


## galaxy-workflow-executor_run_galaxy_workflow.py

### Tool Description
Runs a Galaxy workflow based on provided configuration and inputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
- **Homepage**: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor
- **Package**: https://anaconda.org/channels/bioconda/packages/galaxy-workflow-executor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_galaxy_workflow.py [-h] -C CONF [-G GALAXY_INSTANCE] -i
                              YAML_INPUTS_PATH [-o OUTPUT_DIR] -H HISTORY -W
                              WORKFLOW [-P PARAMETERS] [--parameters-yaml]
                              [--debug] [-a ALLOWED_ERRORS] [-s STATE_FILE]
                              [-k] [-w] [--publish] [--accessible]

optional arguments:
  -h, --help            show this help message and exit
  -C CONF, --conf CONF  A yaml file describing the galaxy credentials
  -G GALAXY_INSTANCE, --galaxy-instance GALAXY_INSTANCE
                        Galaxy server instance name
  -i YAML_INPUTS_PATH, --yaml-inputs-path YAML_INPUTS_PATH
                        Path to Yaml detailing inputs
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Path to output directory
  -H HISTORY, --history HISTORY
                        Name of the history to create
  -W WORKFLOW, --workflow WORKFLOW
                        Workflow to run
  -P PARAMETERS, --parameters PARAMETERS
                        parameters file, by default json
  --parameters-yaml     read parameters file as yaml instead of json
  --debug               Print debug information
  -a ALLOWED_ERRORS, --allowed-errors ALLOWED_ERRORS
                        Yaml file with allowed steps that can have errors.
  -s STATE_FILE, --state-file STATE_FILE
                        Path to read and save the execution state file.
  -k, --keep-histories  Keeps histories created, they will be purged if not.
  -w, --keep-workflow   Keeps workflow created, it will be purged if not.
  --publish             Keep result history and make it public/accesible.
  --accessible          Keep result history and make it accessible via link
                        only.
```

