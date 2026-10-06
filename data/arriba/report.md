# arriba CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| arriba_draw_fusions.r | PASS |  |

## Metadata
- **Skill**: generated

## arriba_draw_fusions.r

### Tool Description
A script to visualize fusions detected by Arriba in PDF format, showing genomic context, protein domains, and read support.

### Metadata
- **Docker Image**: quay.io/biocontainers/arriba:2.5.1--h87b9561_0
- **Homepage**: https://github.com/suhrig/arriba
- **Package**: https://anaconda.org/channels/bioconda/packages/arriba/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/arriba:2.5.1--h87b9561_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:5589846bc3eccadd9baed799445e9d81ddea92d75b8307407295ba3e34110abd: unpack entry: usr/local/lib/gcc/x86_64-conda-linux-gnu/15.1.0/libstdc++.a: unpack to regular file: short write: write /tmp/build-temp-2111966034/rootfs/usr/local/lib/gcc/x86_64-conda-linux-gnu/15.1.0/libstdc++.a: no space left on device
```

