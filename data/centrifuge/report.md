# centrifuge CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| centrifuge_centrifuge-build | PASS |  |

## Metadata
- **Skill**: generated

## centrifuge_centrifuge-build

### Tool Description
Builds a Centrifuge index from a set of DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
- **Homepage**: https://github.com/DaehwanKimLab/centrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuge/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/getent: unpack to regular file: short write: write /tmp/build-temp-3926687323/rootfs/usr/bin/getent: no space left on device
```

