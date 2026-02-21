# crossmap CWL Generation Report

## crossmap

### Tool Description
The provided text does not contain help information for the tool. It contains error logs related to a container runtime (Apptainer/Singularity) failing to pull or build the image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Total Downloads**: 103.3K
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/liguowang/CrossMap
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:24ac73aba4bafbdd5a004b641e3762d91bfb0306cabef45f7dde94c2c1cb78a4: unpack entry: usr/local/lib/libopenblasp-r0.3.30.so: unpack to regular file: short write: write /tmp/build-temp-1745997539/rootfs/usr/local/lib/libopenblasp-r0.3.30.so: no space left on device
```


## Metadata
- **Skill**: generated
