# decom CWL Generation Report

## decom_decOM

### Tool Description
Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods

### Metadata
- **Docker Image**: quay.io/biocontainers/decom:0.0.32--pyhdfd78af_2
- **Homepage**: https://github.com/CamilaDuitama/decOM
- **Package**: https://anaconda.org/channels/bioconda/packages/decom/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/decom/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CamilaDuitama/decOM
- **Stars**: N/A
### Original Help Text
```text
usage: decOM [-h] (-s SINK | -p_sinks PATH_SINKS) -p_sources PATH_SOURCES
             (-k KEY | -p_keys PATH_KEYS) -mem MEMORY -t THREADS [-o OUTPUT]
             [-p {False,True}] [-V] [-v]

Microbial source tracking for contamination assessment of ancient oral samples
using k-mer-based methods

options:
  -h, --help            show this help message and exit
  -s SINK, --sink SINK  Write down the name of your sink. It must be the same
                        as the first element of key.fof. When this argument is
                        set, -k/--key must be defined too
  -p_sinks PATH_SINKS, --path_sinks PATH_SINKS
                        .txt file with a list of sinks limited by a newline
                        (\n). When this argument is set, -p_keys/--path_keys
                        must be defined too.
  -p_sources PATH_SOURCES, --path_sources PATH_SOURCES
                        path to folder downloaded from https://zenodo.org/reco
                        rd/6513520/files/decOM_sources.tar.gz
  -k KEY, --key KEY     filtering key (a kmtricks fof with only one sample).
                        When this argument is set, -s/--sink must be defined
                        too.
  -p_keys PATH_KEYS, --path_keys PATH_KEYS
                        Path to folder with filtering keys (a kmtricks fof
                        with only one sample). You should have as many .fof
                        files as sinks. When this argument is set,
                        -p_sinks/--path_sinks must be defined too.
  -mem MEMORY, --memory MEMORY
                        Write down how much memory you want to use for this
                        process. Ex: 10GB
  -t THREADS, --threads THREADS
                        Number of threads to use. Ex: 5
  -o OUTPUT, --output OUTPUT
                        Path to output folder, where you want decOM to write
                        the results. Folder must not exist, it won't be
                        overwritten.
  -p {False,True}, --plot {False,True}
                        True if you want a plot (in pdf and html format) with
                        the source proportions of the sink, else False
  -V, --version         Show version number and exit
  -v, --verbose         Verbose output
```

