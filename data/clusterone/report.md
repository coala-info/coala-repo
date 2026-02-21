# clusterone CWL Generation Report

## clusterone

### Tool Description
The provided text does not contain help information for the tool 'clusterone'. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterone:1.0--hdfd78af_0
- **Homepage**: https://paccanarolab.org/cluster-one/
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterone/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clusterone/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/clusterone:1.0--hdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:c1a16a04cedd950c541fa85e64b62b17eb3b73a7f7e29ea3db23dc9b83dfcade: unpack entry: bin/bash: unpack to regular file: short write: write /tmp/build-temp-1372989678/rootfs/bin/bash: no space left on device
```


## Metadata
- **Skill**: not generated
