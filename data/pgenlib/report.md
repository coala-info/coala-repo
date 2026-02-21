# pgenlib CWL Generation Report

## pgenlib

### Tool Description
The provided text does not contain help information for pgenlib. It appears to be a fatal error log from a container runtime (Apptainer/Singularity) indicating a failure to build or pull the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/pgenlib:0.93.0--py39h475c85d_0
- **Homepage**: https://github.com/chrchang/plink-ng
- **Package**: https://anaconda.org/channels/bioconda/packages/pgenlib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgenlib/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2025-06-10
- **GitHub**: https://github.com/chrchang/plink-ng
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/pgenlib:0.93.0--py39h475c85d_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:62c3765c976bfe233140b951830ad29e4c4542fa8648195963439d30acd6202f: unpack entry: usr/local/lib/python3.9/lib-dynload/_curses.cpython-39-x86_64-linux-gnu.so: unpack to regular file: short write: write /tmp/build-temp-2936101572/rootfs/usr/local/lib/python3.9/lib-dynload/_curses.cpython-39-x86_64-linux-gnu.so: no space left on device
```


## Metadata
- **Skill**: generated
