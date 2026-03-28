# refgenieserver CWL Generation Report

## refgenieserver_serve

### Tool Description
run the server

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenieserver:0.7.0--pyhdfd78af_0
- **Homepage**: https://refgenie.databio.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenieserver/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/refgenieserver/overview
- **Total Downloads**: 20.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: refgenieserver serve [-h] [-c CONFIG] [-d] [-p PORT]

run the server

options:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        A path to the refgenie config file (YAML). If not
                        provided, the first available environment variable
                        among: 'REFGENIE' will be used if set. Currently: not
                        set
  -d, --dbg             Set logger verbosity to debug
  -p PORT, --port PORT  The port the webserver should be run on.
```


## refgenieserver_archive

### Tool Description
prepare servable archives

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenieserver:0.7.0--pyhdfd78af_0
- **Homepage**: https://refgenie.databio.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenieserver/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenieserver archive [-h] [-c CONFIG] [-d]
                              [--genomes-desc GENOMES_DESC] [-f] [-r]
                              [asset-registry-paths ...]

prepare servable archives

positional arguments:
  asset-registry-paths  One or more registry path strings that identify
                        assets, e.g. hg38/fasta:tag

options:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        A path to the refgenie config file (YAML). If not
                        provided, the first available environment variable
                        among: 'REFGENIE' will be used if set. Currently: not
                        set
  -d, --dbg             Set logger verbosity to debug
  --genomes-desc GENOMES_DESC
                        Path to a CSV file with genomes descriptions. Format:
                        genome_name, genome description
  -f, --force           whether the server file tree should be rebuilt even if
                        exists
  -r, --remove          Remove selected genome, genome/asset or
                        genome/asset:tag
```


## Metadata
- **Skill**: generated
