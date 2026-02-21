# cell2cell CWL Generation Report

## cell2cell_build

### Tool Description
The provided text appears to be a log of a failed container build process (Singularity/Apptainer) rather than CLI help text for the tool 'cell2cell_build'. No command-line arguments, flags, or usage instructions were found in the input.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/earmingol/cell2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/cell2cell/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cell2cell/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-11-05
- **GitHub**: https://github.com/earmingol/cell2cell
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/localedef: unpack to regular file: short write: write /tmp/build-temp-2478702980/rootfs/usr/bin/localedef: no space left on device
```


## Metadata
- **Skill**: generated

## cell2cell

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It appears to be a system error log from a container runtime (Singularity/Apptainer) indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/earmingol/cell2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/cell2cell/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/localedef: unpack to regular file: short write: write /tmp/build-temp-1733232322/rootfs/usr/bin/localedef: no space left on device
```

