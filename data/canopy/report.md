# canopy CWL Generation Report

## canopy_build

### Tool Description
Converts OCI blobs to SIF format and builds a container image.

### Metadata
- **Docker Image**: quay.io/biocontainers/canopy:0.25--h077b44d_1
- **Homepage**: https://github.com/hildebra/canopy2/
- **Package**: https://anaconda.org/channels/bioconda/packages/canopy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/canopy/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hildebra/canopy2
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/canopy:0.25--h077b44d_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:a56887daaa80d38151b70c4c4481c202a4e4c9e2f5466263bab3c64a0f67508d: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-3044087807/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```


## Metadata
- **Skill**: generated

## canopy_cc.bin

### Tool Description
The provided text does not contain help information or a description for the tool; it is a log of a failed container build process (Apptainer/Singularity) due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/canopy:0.25--h077b44d_1
- **Homepage**: https://github.com/hildebra/canopy2/
- **Package**: https://anaconda.org/channels/bioconda/packages/canopy/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/canopy:0.25--h077b44d_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:a56887daaa80d38151b70c4c4481c202a4e4c9e2f5466263bab3c64a0f67508d: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-2218338515/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

