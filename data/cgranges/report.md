# cgranges CWL Generation Report

## cgranges

### Tool Description
The provided text does not contain help information or a description of the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity) indicating a 'no space left on device' failure during image extraction.

### Metadata
- **Docker Image**: quay.io/biocontainers/cgranges:0.1.1--py39hbcbf7aa_3
- **Homepage**: https://github.com/lh3/cgranges
- **Package**: https://anaconda.org/channels/bioconda/packages/cgranges/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cgranges/overview
- **Total Downloads**: 28.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/cgranges
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cgranges:0.1.1--py39hbcbf7aa_3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/bash: unpack to regular file: short write: write /tmp/build-temp-4098059152/rootfs/usr/bin/bash: no space left on device
```


## Metadata
- **Skill**: generated

## cgranges_bedcov-cr

### Tool Description
The provided text does not contain help information for the tool. It is a system error log indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/cgranges:0.1.1--py39hbcbf7aa_3
- **Homepage**: https://github.com/lh3/cgranges
- **Package**: https://anaconda.org/channels/bioconda/packages/cgranges/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cgranges:0.1.1--py39hbcbf7aa_3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/bash: unpack to regular file: short write: write /tmp/build-temp-2683755843/rootfs/usr/bin/bash: no space left on device
```

