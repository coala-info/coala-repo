# demultiplexer2 CWL Generation Report

## demultiplexer2_create_primerset

### Tool Description
Create a primerset

### Metadata
- **Docker Image**: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/DominikBuchner/demultiplexer2
- **Package**: https://anaconda.org/channels/bioconda/packages/demultiplexer2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/demultiplexer2/overview
- **Total Downloads**: 389
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/DominikBuchner/demultiplexer2
- **Stars**: N/A
### Original Help Text
```text
usage: demultiplexer2 create_primerset [-h] --name NAME --n_primers N_PRIMERS

options:
  -h, --help            show this help message and exit
  --name NAME           Define the name for the primerset to create.
  --n_primers N_PRIMERS
                        Define the number of forward and reverse primers in
                        the primerset.
```


## demultiplexer2_create_tagging_scheme

### Tool Description
Create a tagging scheme for demultiplexing.

### Metadata
- **Docker Image**: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/DominikBuchner/demultiplexer2
- **Package**: https://anaconda.org/channels/bioconda/packages/demultiplexer2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: demultiplexer2 create_tagging_scheme [-h] --name NAME --data_dir
                                            DATA_DIR --primerset_path
                                            PRIMERSET_PATH

options:
  -h, --help            show this help message and exit
  --name NAME           Define the name for the tagging scheme to create
  --data_dir DATA_DIR   Path to the directory that contains the files to
                        demultiplex.
  --primerset_path PRIMERSET_PATH
                        Path to the primerset to be used for demultiplexing.
```


## demultiplexer2_demultiplex

### Tool Description
Demultiplexes sequencing reads based on primer and tagging schemes.

### Metadata
- **Docker Image**: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/DominikBuchner/demultiplexer2
- **Package**: https://anaconda.org/channels/bioconda/packages/demultiplexer2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: demultiplexer2 demultiplex [-h] --primerset_path PRIMERSET_PATH
                                  --tagging_scheme_path TAGGING_SCHEME_PATH
                                  --output_dir OUTPUT_DIR

options:
  -h, --help            show this help message and exit
  --primerset_path PRIMERSET_PATH
                        Path to the primerset to be used for demultiplexing.
  --tagging_scheme_path TAGGING_SCHEME_PATH
                        Path to the tagging scheme to be used for
                        demultiplexing.
  --output_dir OUTPUT_DIR
                        Directory to write the demultiplexed files to.
```

