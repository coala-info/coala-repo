# cgpbigwig CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cgpbigwig_bwjoin | PASS |  |

## Metadata
- **Skill**: generated

## cgpbigwig_bwjoin

### Tool Description
Join multiple bigWig files into a single bigWig file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
- **Homepage**: https://github.com/cancerit/cgpBigWig
- **Package**: https://anaconda.org/channels/bioconda/packages/cgpbigwig/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/bash: unpack to regular file: short write: write /tmp/build-temp-1594431752/rootfs/usr/bin/bash: no space left on device
```

