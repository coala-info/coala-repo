# dammet CWL Generation Report

## dammet

### Tool Description
The provided text does not contain help information or usage instructions for the tool 'dammet'. It contains system log messages and a fatal error regarding a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/dammet:1.0.1a--h1fa8866_0
- **Homepage**: https://gitlab.com/KHanghoj/DamMet
- **Package**: https://anaconda.org/channels/bioconda/packages/dammet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dammet/overview
- **Total Downloads**: 8.9K
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
2026/02/11 17:14:34  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/dammet:1.0.1a--h1fa8866_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:971edf39df0addb583ef2eab37196bfdbe37b53744d8cfbf31497a9e6981d7cd: unpack entry: usr/local/bin/bunzip2: unpack to regular file: short write: write /tmp/build-temp-1716391426/rootfs/usr/local/bin/bunzip2: no space left on device
```


## Metadata
- **Skill**: not generated
