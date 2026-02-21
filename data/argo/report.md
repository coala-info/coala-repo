# argo CWL Generation Report

## argo

### Tool Description
The provided text does not contain help information or usage instructions for the tool 'argo'. It appears to be a system error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/argo:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/xinehc/argo
- **Package**: https://anaconda.org/channels/bioconda/packages/argo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/argo/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/xinehc/argo
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/argo:0.2.1--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ad53277ad81080f1c3412dbc5a2adcee7a5f0be35255ddc74100bb94e050300b: unpack entry: usr/local/lib/ncbi-blast+/libseqcode.so: unpack to regular file: short write: write /tmp/build-temp-3211654481/rootfs/usr/local/lib/ncbi-blast+/libseqcode.so: no space left on device
```


## Metadata
- **Skill**: generated
