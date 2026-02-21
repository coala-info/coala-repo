# scvi-tools CWL Generation Report

## scvi-tools

### Tool Description
The provided text does not contain help information or usage instructions for scvi-tools. It is an error log from a container build process (Singularity/Apptainer) indicating a 'no space left on device' failure while extracting a Docker image.

### Metadata
- **Docker Image**: quay.io/biocontainers/scvi-tools:0.14.5--pyhdfd78af_1
- **Homepage**: https://github.com/YosefLab/scvi-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/scvi-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scvi-tools/overview
- **Total Downloads**: 53.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/YosefLab/scvi-tools
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/scvi-tools:0.14.5--pyhdfd78af_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:95f5e290a2c43073ca190cf39020e97cb996ba85e77615f8a5a05725a471068e: unpack entry: usr/local/bin/pandoc: unpack to regular file: short write: write /tmp/build-temp-2453104083/rootfs/usr/local/bin/pandoc: no space left on device
```


## Metadata
- **Skill**: generated
