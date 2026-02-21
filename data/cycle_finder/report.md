# cycle_finder CWL Generation Report

## cycle_finder

### Tool Description
The provided text does not contain help information or a description of the tool; it is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract the image due to insufficient disk space.

### Metadata
- **Docker Image**: biocontainers/cycle:v0.3.1-14-deb_cv1
- **Homepage**: https://github.com/rkajitani/cycle_finder
- **Package**: https://anaconda.org/channels/bioconda/packages/cycle_finder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cycle_finder/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-09-03
- **GitHub**: https://github.com/rkajitani/cycle_finder
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://biocontainers/cycle:v0.3.1-14-deb_cv1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:478cd0aa93c0da2489a29b95d43a21a942cece28ecb0ba0f99770f52eb8ee3dc: unpack entry: lib/x86_64-linux-gnu/libc-2.28.so: unpack to regular file: short write: write /tmp/build-temp-3763739495/rootfs/lib/x86_64-linux-gnu/libc-2.28.so: no space left on device
```


## Metadata
- **Skill**: generated
