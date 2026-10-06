# biobb_mem CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biobb_mem_lipyphilic_flipflop | PASS |  |

## Metadata
- **Skill**: generated

## biobb_mem_lipyphilic_flipflop

### Tool Description
Analyze flip-flop of lipids using the LiPyphilic library.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/bioexcel/biobb_mem
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_mem/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:39c1eba46e738de08f7ccd98a84ea1db29b1e124b6a414d7f04f933192fab9d6: unpack entry: usr/local/AmberTools/src/quick/basis/6-311GD.SAD/KR: unpack to regular file: short write: write /scratch/21813747/build-temp-1212180570/rootfs/usr/local/AmberTools/src/quick/basis/6-311GD.SAD/KR: no space left on device
```

