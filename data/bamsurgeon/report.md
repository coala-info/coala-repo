# bamsurgeon CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bamsurgeon_addsnv.py | PASS |  |
| bamsurgeon_addsv.py | PASS |  |

## Metadata
- **Skill**: generated

## bamsurgeon_addsnv.py

### Tool Description
Add SNVs to a BAM file to create a synthetic dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/bamsurgeon
- **Package**: https://anaconda.org/channels/bioconda/packages/bamsurgeon/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:802d99b6554650cc5aa4d9efdedacc14bc459c338967c565793cbe745eaae7f1: unpack entry: usr/local/bin/x86_64-conda-linux-gnu-ld.gold: unpack to regular file: short write: write /scratch/21813747/build-temp-1135720992/rootfs/usr/local/bin/x86_64-conda-linux-gnu-ld.gold: no space left on device
```

## bamsurgeon_addsv.py

### Tool Description
Add structural variants to existing BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/bamsurgeon
- **Package**: https://anaconda.org/channels/bioconda/packages/bamsurgeon/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:802d99b6554650cc5aa4d9efdedacc14bc459c338967c565793cbe745eaae7f1: unpack entry: usr/local/bin/x86_64-conda-linux-gnu-ld.gold: unpack to regular file: short write: write /scratch/21813747/build-temp-3936428654/rootfs/usr/local/bin/x86_64-conda-linux-gnu-ld.gold: no space left on device
```

