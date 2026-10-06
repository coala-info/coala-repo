# biobb_io CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biobb_io_alphafold | PASS |  |

## Metadata
- **Skill**: generated

## biobb_io_alphafold

### Tool Description
The biobb_io_alphafold tool fetches a PDB file from the AlphaFold Protein Structure Database using a UniProt ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_io
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_io/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ac576891c012159cbef88529847b47eb3c434f9ebdaf349cfde675121b180367: unpack entry: usr/local/bin/python3.14: unpack to regular file: short write: write /scratch/21813747/build-temp-2360034514/rootfs/usr/local/bin/python3.14: no space left on device
```

