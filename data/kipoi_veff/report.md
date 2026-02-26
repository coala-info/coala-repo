# kipoi_veff CWL Generation Report

## kipoi_veff_kipoi

### Tool Description
Kipoi model-zoo command line tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
- **Homepage**: https://github.com/kipoi/kipoi-veff
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi_veff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kipoi_veff/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kipoi/kipoi-veff
- **Stars**: N/A
### Original Help Text
```text
usage: kipoi <command> [-h] ...

    # Kipoi model-zoo command line tool. Available sub-commands:
    # - using models:
    ls               List all the available models
    list_plugins     List all the available plugins
    info             Print dataloader keyword argument info
    get-example      Download example files
    predict          Run the model prediction
    pull             Download the directory associated with the model
    preproc          Run the dataloader and save the results to an hdf5 array
    env              Tools for managing Kipoi conda environments

    # - contributing models:
    init             Initialize a new Kipoi model
    test             Runs a set of unit-tests for the model
    test-source      Runs a set of unit-tests for many/all models in a source
    
    # - plugin commands:
No plugins installed. Install them using pip install <plugin>. Available plugins: kipoi_interpret

Kipoi model-zoo command line tool

positional arguments:
  command     Subcommand to run; possible commands: preproc, predict, pull,
              ls, list_plugins, info, env, test, get-example, test-source,
              init

options:
  -h, --help  show this help message and exit
```

