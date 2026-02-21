# scrappie CWL Generation Report

## scrappie

### Tool Description
The provided text does not contain help information or usage instructions. It appears to be a system error log from a container runtime (Apptainer/Singularity) indicating a 'no space left on device' failure during image extraction.

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Total Downloads**: 23.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/scrappie
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:e05851e3eec5f11731e7bad3018542561f263a6429d57edd7526a143e6338ea4: unpack entry: usr/local/lib/libmkl_intel_thread.so.2: unpack to regular file: short write: write /tmp/build-temp-3686024052/rootfs/usr/local/lib/libmkl_intel_thread.so.2: no space left on device
```


## Metadata
- **Skill**: generated
