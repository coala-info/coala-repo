# bioconda2biocontainer CWL Generation Report

## bioconda2biocontainer

### Tool Description
Find Biocontainers images from Bioconda packages

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda2biocontainer:0.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/BioContainers/bioconda2biocontainer
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda2biocontainer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioconda2biocontainer/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BioContainers/bioconda2biocontainer
- **Stars**: N/A
### Original Help Text
```text
usage: bioconda2biocontainer [-h] [-v] --package_name PACKAGE_NAME
                             [--package_version PACKAGE_VERSION]
                             [--container_type CONTAINER_TYPE]
                             [--registry_host REGISTRY_HOST] [--json] [--all]
                             [--sort_by_size] [--sort_by_download]

Find Biocontainers images from Bioconda packages

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --package_name PACKAGE_NAME
                        Bioconda package name
  --package_version PACKAGE_VERSION
                        Bioconda package version
  --container_type CONTAINER_TYPE
                        Container type. Default: Docker. Values: Docker,
                        Conda, Singularity
  --registry_host REGISTRY_HOST
                        Registry host. Default: quay.io.Values:
  --json                Print json format
  --all                 Print all images
  --sort_by_size        Sort by size instead of by date
  --sort_by_download    Sort by number of downloads instead of by date
```


## Metadata
- **Skill**: generated

## bioconda2biocontainer_biocontainers-search

### Tool Description
Find Biocontainers tools

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda2biocontainer:0.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/BioContainers/bioconda2biocontainer
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda2biocontainer/overview
- **Validation**: PASS
### Original Help Text
```text
usage: biocontainers-search [-h] [-v] --search_term SEARCH_TERM [--json]
                            [--show_images]

Find Biocontainers tools

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --search_term SEARCH_TERM
                        Search term
  --json                Print json format
  --show_images         Show all available images
```

