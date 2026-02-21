# translate-gard CWL Generation Report

## translate-gard

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It consists of system logs and a fatal error message regarding a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/translate-gard:1.0.4--0
- **Homepage**: https://github.com/veg/translate-gard/
- **Package**: https://anaconda.org/channels/bioconda/packages/translate-gard/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/translate-gard/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/veg/translate-gard
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 05:55:47  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/translate-gard:1.0.4--0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:26befa9a56273d17ed3a2f7c78e834c388cc5dcef3dcc2dac08173183a85b469: unpack entry: usr/local/lib/libtsan.so.0.0.0: unpack to regular file: short write: write /tmp/build-temp-2350998356/rootfs/usr/local/lib/libtsan.so.0.0.0: no space left on device
```


## Metadata
- **Skill**: generated
