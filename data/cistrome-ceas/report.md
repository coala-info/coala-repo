# cistrome-ceas CWL Generation Report

## cistrome-ceas

### Tool Description
The provided text does not contain help information for the tool. It contains system logs and a fatal error regarding a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1
- **Homepage**: https://bitbucket.org/cistrome/cistrome-applications-harvard/overview
- **Package**: https://anaconda.org/channels/bioconda/packages/cistrome-ceas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cistrome-ceas/overview
- **Total Downloads**: 6.4K
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
2026/02/11 16:54:49  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b0dc45cd432d14fb6df7d3239dc15d09c63906f8e7bfd373a4647b107fc3746c: unpack entry: lib/libc-2.18.so: unpack to regular file: short write: write /tmp/build-temp-4031268847/rootfs/lib/libc-2.18.so: no space left on device
```


## Metadata
- **Skill**: generated
