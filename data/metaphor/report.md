# metaphor CWL Generation Report

## metaphor_execute

### Tool Description
Execute a Metaphor workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
- **Homepage**: https://github.com/vinisalazar/metaphor
- **Package**: https://anaconda.org/channels/bioconda/packages/metaphor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaphor/overview
- **Total Downloads**: 27.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vinisalazar/metaphor
- **Stars**: N/A
### Original Help Text
```text
usage: metaphor execute [-h] [-i INPUT_DIR] [-f CONFIGFILE] [-e EXTRAS] [-j]
                        [-c CORES] [-l PROFILE] [-m MAX_MB] [-y]
                        [--skip-report] [--unlock]
                        [--conda-prefix CONDA_PREFIX]

options:
  -h, --help            show this help message and exit
  -i INPUT_DIR, --input-dir INPUT_DIR
                        Input directory containing FASTQ files. (default:
                        None)
  -f CONFIGFILE, --configfile CONFIGFILE
                        Configuration file to run the workflow. (default:
                        metaphor_settings.yaml)
  -e EXTRAS, --extras EXTRAS
                        String of extra arguments to be passed on to
                        Snakemake. (default: )
  -j, --join-units      Whether to join units (S001, S002) with the same
                        preffix as the same file. (default: False)
  -c CORES, --cores CORES
                        Number of cores to be used. (default: 4)
  -l PROFILE, --profile PROFILE
                        Profile to be used to run Metaphor. (default: None)
  -m MAX_MB, --max_mb MAX_MB
                        Max amount of MB RAM to be used. Can be set in config.
                        (default: None)
  -y, --confirm         Don't ask for confirmation when running tests.
                        (default: False)
  --skip-report         Don't create report when run finishes. (default:
                        False)
  --unlock              Unlock the working directory. For more information,
                        see the Snakemake '--unlock' flag. (default: False)
  --conda-prefix CONDA_PREFIX
                        Conda prefix where conda environments will be
                        installed. Default is config directory, this way
                        multiple runs of Metaphor will share the same
                        environments. (default: None)
```


## metaphor_test

### Tool Description
Run Metaphor tests.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
- **Homepage**: https://github.com/vinisalazar/metaphor
- **Package**: https://anaconda.org/channels/bioconda/packages/metaphor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaphor test [-h] [-d DIRECTORY] [-c CORES] [-m MAX_MB] [-l PROFILE]
                     [-co] [-y] [-j] [-dry] [-e EXTRAS]

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --directory DIRECTORY
                        Directory to run tests. (default: test_data_metaphor)
  -c CORES, --cores CORES
                        Number of processors to use in tests. (default: 3)
  -m MAX_MB, --max_mb MAX_MB
                        Amount of RAM to use in tests. (default: 8192)
  -l PROFILE, --profile PROFILE
                        Profile to be used to run Metaphor. (default: None)
  -co, --coassembly     Whether to run tests in coassembly mode, i.e. all
                        samples are pooled together and assembled. (default:
                        False)
  -y, --confirm         Don't ask for confirmation when running tests.
                        (default: False)
  -j, --join-units      Also known as 'run merging' in some workflows. If this
                        option is on, files with the same preffix but with
                        S001, S002, S00N distinctions in the filenames will be
                        treated as different units of the same sample, i.e.
                        they will be joined into a single file. This is useful
                        for multiple sequencing lanes for the same sample.
                        (default: False)
  -dry, --dry-run       Whether to run tests as a dry-run only (used for CI).
                        (default: False)
  -e EXTRAS, --extras EXTRAS
                        String of extra arguments to be passed on to
                        Snakemake. (default: )
```


## metaphor_config

### Tool Description
Metaphor configuration commands.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
- **Homepage**: https://github.com/vinisalazar/metaphor
- **Package**: https://anaconda.org/channels/bioconda/packages/metaphor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaphor config [-h] {input,settings,show} ...

positional arguments:
  {input,settings,show}
                        Config command to be executed.
    input               Create Metaphor input table from directory of fastq
                        files.
    settings            Generate Metaphor settings YAML file.
    show                Show path of Metaphor installation, Snakefile, config
                        files, and a sample input file.

options:
  -h, --help            show this help message and exit
```


## Metadata
- **Skill**: generated
