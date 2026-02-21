# abruijn CWL Generation Report

## abruijn

### Tool Description
The provided text does not contain help information for the tool 'abruijn'. It contains error logs related to a failed container build (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/abruijn:2.1b--py27_0
- **Homepage**: https://github.com/fenderglass/ABruijn/
- **Package**: https://anaconda.org/channels/bioconda/packages/abruijn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abruijn/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fenderglass/ABruijn
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 12:01:53  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/abruijn:2.1b--py27_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b0b0dec5e9ee4bae6f5a5b8ca1890fb4b307f53566183a256fac617121a28880: unpack entry: usr/local/lib/tk8.5/demos/goldberg.tcl: unpack to regular file: short write: write /tmp/build-temp-4004277076/rootfs/usr/local/lib/tk8.5/demos/goldberg.tcl: no space left on device
```


## Metadata
- **Skill**: generated

## abruijn_flye

### Tool Description
The provided text is an error log from a container runtime (Singularity/Apptainer) indicating a failure to build or extract the image due to insufficient disk space. It does not contain the help text or usage information for the tool 'abruijn'.

### Metadata
- **Docker Image**: quay.io/biocontainers/abruijn:2.1b--py27_0
- **Homepage**: https://github.com/fenderglass/ABruijn/
- **Package**: https://anaconda.org/channels/bioconda/packages/abruijn/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 12:03:10  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/abruijn:2.1b--py27_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b0b0dec5e9ee4bae6f5a5b8ca1890fb4b307f53566183a256fac617121a28880: unpack entry: usr/local/lib/tcl8.5/msgs/es_hn.msg: unpack to regular file: short write: write /tmp/build-temp-2512118008/rootfs/usr/local/lib/tcl8.5/msgs/es_hn.msg: no space left on device
```

