# hocort CWL Generation Report

## hocort_map

### Tool Description
map reads to a reference genome and output mapped/unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Total Downloads**: 14.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ignasrum/hocort
- **Stars**: N/A
### Original Help Text
```text
usage: hocort map [pipeline] [options]

hocort map: map reads to a reference genome and output mapped/unmapped reads

positional arguments:
  pipeline              str: pipeline to run (required)

optional arguments:
  -h, --help            flag: print help
  -d, --debug           flag: verbose output
  -q, --quiet           flag: quiet output (overrides -d/--debug)
  -l LOG_FILE, --log-file LOG_FILE
                        str: path to log file

available pipelines:
    bbmap
    biobloom
    bowtie2
    bwamem2
    hisat2
    kraken2
    kraken2bowtie2
    kraken2hisat2
    kraken2minimap2
    minimap2

Linux-6.8.0-100-generic-x86_64-with-glibc2.28
Python 3.9.15
Available threads: 20

hocort: error: argument -h/--help: ignored explicit argument 'elp'
```


## hocort_index

### Tool Description
build index/-es for supported tools

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort index [tool] [options]

hocort index: build index/-es for supported tools

positional arguments:
  tool                  str: tool to generate index for (required)

optional arguments:
  -h, --help            flag: print help
  -d, --debug           flag: verbose output
  -q, --quiet           flag: quiet output (overrides -d/--debug)
  -l LOG_FILE, --log-file LOG_FILE
                        str: path to log file

available tools:
    bbmap
    biobloom
    bowtie2
    bwamem2
    hisat2
    kraken2
    minimap2

Linux-6.8.0-100-generic-x86_64-with-glibc2.28
Python 3.9.15
Available threads: 20

hocort: error: argument -h/--help: ignored explicit argument 'elp'
```


## Metadata
- **Skill**: generated
