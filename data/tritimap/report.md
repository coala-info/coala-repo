# tritimap CWL Generation Report

## tritimap_init

### Tool Description
Generate snakemake configuration file and other needed file. The command will generate three configuration files(config.yaml, sample.csv and region.csv) in the running directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/tritimap:0.9.7--pyh5e36f6f_0
- **Homepage**: https://github.com/fei0810/Triti-Map
- **Package**: https://anaconda.org/channels/bioconda/packages/tritimap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tritimap/overview
- **Total Downloads**: 22.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fei0810/Triti-Map
- **Stars**: N/A
### Original Help Text
```text
Usage: tritimap init [OPTIONS]

  Generate snakemake configuration file and other needed file. The command
  will generate three configuration files(config.yaml, sample.csv and
  region.csv) in the running directory.

Options:
  -d, --working-dir PATH  Triti-Map running directory.
  -h, --help              Show this message and exit.
```


## tritimap_run

### Tool Description
Triti-Map main command. The pipeline supports three execute modules: all, only_mapping and only_assembly. First, you need to fill in the configuration file correctly.

### Metadata
- **Docker Image**: quay.io/biocontainers/tritimap:0.9.7--pyh5e36f6f_0
- **Homepage**: https://github.com/fei0810/Triti-Map
- **Package**: https://anaconda.org/channels/bioconda/packages/tritimap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tritimap run [OPTIONS] [[all|only_mapping|only_assembly]]
                    [SNAKEMAKE_ARGS]...

  Triti-Map main command. The pipeline supports three execute modules: all,
  only_mapping and only_assembly. First, you need to fill in the configuration
  file correctly.

Options:
  -d, --working-dir PATH  Triti-Map running directory.
  -c, --config-file PATH  Triti-Map config file, generated with tritimap init.
  -j, --jobs INTEGER      Use at most N CPU cores/jobs in parallel.
  -n, --dryrun            Do not execute anything, and display what would be
                          done.  [default: False]
  --profile TEXT          Name of profile to use for configuring Snakemake.
  -h, --help              Show this message and exit.
```

