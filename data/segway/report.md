# segway CWL Generation Report

## segway

### Tool Description
The provided text does not contain help information for the 'segway' tool; it is an error log from a container build process (Apptainer/Singularity) indicating a 'no space left on device' failure.

### Metadata
- **Docker Image**: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
- **Homepage**: http://segway.hoffmanlab.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Total Downloads**: 51.7K
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
FATAL:   Unable to handle docker://quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:2af3a547619853a4037706b2bf6c459886421142fa0e434c08f13d03360ae7b0: unpack entry: usr/local/bin/python3.10: unpack to regular file: short write: write /tmp/build-temp-2014057401/rootfs/usr/local/bin/python3.10: no space left on device
```


## Metadata
- **Skill**: generated

## segway_genomedata-load

### Tool Description
The provided text does not contain help information for the tool; it contains a fatal error log from a container runtime (Apptainer/Singularity) indicating a 'no space left on device' failure during image extraction. No arguments could be parsed from the input text.

### Metadata
- **Docker Image**: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
- **Homepage**: http://segway.hoffmanlab.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:2af3a547619853a4037706b2bf6c459886421142fa0e434c08f13d03360ae7b0: unpack entry: usr/local/bin/python3.10: unpack to regular file: short write: write /tmp/build-temp-3848910042/rootfs/usr/local/bin/python3.10: no space left on device
```

