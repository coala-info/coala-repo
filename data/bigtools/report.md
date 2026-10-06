# bigtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bigtools_bigbedtobed | PASS |  |

## Metadata
- **Skill**: generated

## bigtools_bigbedtobed

### Tool Description
Converts a bigBed file to a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
- **Homepage**: https://github.com/jackh726/bigtools/
- **Package**: https://anaconda.org/channels/bioconda/packages/bigtools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:2a9640ebe614dbec52760ed66bdc99919367e927e6c8ff9ba0be7c9232461a41: unpack entry: usr/local/bin/bedtobigbed: unpack to regular file: short write: write /scratch/21813747/build-temp-2701490827/rootfs/usr/local/bin/bedtobigbed: no space left on device
```

