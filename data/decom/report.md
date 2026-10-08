# decom CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| decom_decOM | Not completed | decOM needs the 1.3 GB decOM_sources k-mer matrix from Zenodo, which is too large for this test. |
| decom_decOM-CV | Not completed | decOM-CV needs the 1.3 GB decOM_sources k-mer matrix from Zenodo, which is too large for this test. |
| decom_decOM-LOO | PASS | Partly synthetic data: the repo's D1/D2 test sequences, each used as two samples so every environment has two. |
| decom_decOM-MST | PASS |  |
| decom_decOM-aOralOut | Not completed | decOM-aOralOut needs the 1 GB aOralOut_sources k-mer matrix from Zenodo, which is too large for this test. |
| decom_decOM-format | PASS |  |

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

## decom_decOM-aOralOut

### Tool Description
Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods (aOralOut sources).

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
usage: decOM-aOralOut [-h] (-s SINK | -p_sinks PATH_SINKS) -p_sources
                      PATH_SOURCES (-k KEY | -p_keys PATH_KEYS) -mem MEMORY -t
                      THREADS [-o OUTPUT] [-p {False,True}] [-V] [-v]

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
                        rd/6772124/files/aOralOut_sources.tar.gz
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

## decom_decOM-format

### Tool Description
Feature of decOM to compare and adapt the output format of FEAST and ST results

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
usage: decOM-format [-h] -m {FEAST,ST} -mst MST_TABLE -map MAPFILE -out
                    OUTFILE [-v]

Feature of decOM to compare and adapt the output format of FEAST and ST
results

options:
  -h, --help            show this help message and exit
  -m {FEAST,ST}, --method {FEAST,ST}
                        Write down the method used to produce the output table
                        you want to reformat. Options are FEAST or ST. Ex: -m
                        FEAST
  -mst MST_TABLE, --MST_table MST_TABLE
                        Path to output table you are interested in
                        reformatting. It should be a tab ( ) separated file.
  -map MAPFILE, --map MAPFILE
                        Path to map.txt used by ST/FEAST. It should be a tab (
                        ) separated file.
  -out OUTFILE, --output_file OUTFILE
                        Name of output file
  -v, --verbose         Verbose output
```

## decom_decOM-LOO

### Tool Description
Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods (leave-one-out on a user-built matrix of sources).

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
usage: decOM-LOO [-h] -p_sources PATH_SOURCES -m MAP_FILE -mem MEMORY -t
                 THREADS [-o OUTPUT] [-p {True,False}] [-V] [-v]

Microbial source tracking for contamination assessment of ancient oral samples
using k-mer-based methods

options:
  -h, --help            show this help message and exit
  -p_sources PATH_SOURCES, --path_sources PATH_SOURCES
                        path to matrix of sources created using kmtricks
  -m MAP_FILE, --map MAP_FILE
                        .csv file with two columns: SampleID and Env. All the
                        samples used to build the input matrix of sources
                        p_sources should be present in this table.
  -mem MEMORY, --memory MEMORY
                        Write down how much memory you want to use for this
                        process. Ex: 10GB
  -t THREADS, --threads THREADS
                        Number of threads to use. Ex: 5
  -o OUTPUT, --output OUTPUT
                        Path to output folder, where you want decOM to write
                        the results. Folder must not exist, it won't be
                        overwritten.
  -p {True,False}, --plot {True,False}
                        True if you want a plot (in pdf and html format) with
                        the source proportions of the sink, else False
  -V, --version         Show version number and exit
  -v, --verbose         Verbose output
```

## decom_decOM-CV

### Tool Description
Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods (5-fold cross validation).

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
usage: decOM-CV [-h] -p_sinks PATH_SINKS -p_sources PATH_SOURCES -p_keys
                PATH_KEYS -mem MEMORY -t THREADS [-o OUTPUT] -f FOLD
                [-p {False,True}] [-V] [-v]

Microbial source tracking for contamination assessment of ancient oral samples
using k-mer-based methods

options:
  -h, --help            show this help message and exit
  -p_sinks PATH_SINKS, --path_sinks PATH_SINKS
                        .txt file with a list of sinks limited by a newline
                        (\n). When this argument is set, -p_keys/--path_keys
                        must be defined too.
  -p_sources PATH_SOURCES, --path_sources PATH_SOURCES
                        path to folder downloaded from https://zenodo.org/reco
                        rd/6513520/files/decOM_sources.tar.gz
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
  -f FOLD, --fold FOLD  Fold being processed from 5-fold cross validation. It
                        must be one of the following numbers: 1,2,3,4 or 5
  -p {False,True}, --plot {False,True}
                        True if you want a plot (in pdf and html format) with
                        the source proportions of the sink, else False
  -V, --version         Show version number and exit
  -v, --verbose         Verbose output
```

## decom_decOM-MST

### Tool Description
Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods (user-built matrix of sources).

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
usage: decOM-MST [-h] (-s SINK | -p_sinks PATH_SINKS) -p_sources PATH_SOURCES
                 -m MAP_FILE (-k KEY | -p_keys PATH_KEYS) -mem MEMORY -t
                 THREADS [-o OUTPUT] [-p {True,False}] [-V] [-v]

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
                        path to matrix of sources created using kmtricks
  -m MAP_FILE, --map MAP_FILE
                        .csv file with two columns: SampleID and Env. All the
                        samples used to build the input matrix of sources
                        p_sources should be present in this table.
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
  -p {True,False}, --plot {True,False}
                        True if you want a plot (in pdf and html format) with
                        the source proportions of the sink, else False
  -V, --version         Show version number and exit
  -v, --verbose         Verbose output
```

