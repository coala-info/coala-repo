# cutesv CWL Generation Report

## cutesv

### Tool Description
The provided text does not contain help information for the tool. It is an error log from a container runtime (Singularity/Apptainer) indicating a failure to extract the image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/tjiangHIT/cuteSV
- **Package**: https://anaconda.org/channels/bioconda/packages/cutesv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cutesv/overview
- **Total Downloads**: 52.8K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/tjiangHIT/cuteSV
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/lib/x86_64-linux-gnu/libmvec.so.1: unpack to regular file: short write: write /tmp/build-temp-2865411440/rootfs/usr/lib/x86_64-linux-gnu/libmvec.so.1: no space left on device
```


## Metadata
- **Skill**: generated

## cutesv_cuteFC

### Tool Description
The provided text does not contain help information for the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract the OCI image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/tjiangHIT/cuteSV
- **Package**: https://anaconda.org/channels/bioconda/packages/cutesv/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/lib/x86_64-linux-gnu/libmvec.so.1: unpack to regular file: short write: write /tmp/build-temp-2097661307/rootfs/usr/lib/x86_64-linux-gnu/libmvec.so.1: no space left on device
```

