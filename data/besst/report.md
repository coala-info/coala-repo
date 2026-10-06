# besst CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| besst_runBESST | Failed | image problem: the image has networkx 2.1, but BESST 2.2.8 uses the networkx 1.x G.edge API and crashes while building the contig graph. |

## Metadata
- **Skill**: generated

## besst_runBESST

### Tool Description
BESST (Scaffolding Tool) - Scaffolding of genomic assemblies using different types of libraries (e.g., paired-end, mate-pairs).

### Metadata
- **Docker Image**: quay.io/biocontainers/besst:2.2.8--py27_0
- **Homepage**: https://github.com/ksahlin/BESST
- **Package**: https://anaconda.org/channels/bioconda/packages/besst/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/10 04:51:00  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/besst:2.2.8--py27_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:bd3e0de34727aee9c4c67256c29fa6636ae13ac1a8e031a16bc85d4eda99f3f7: unpack entry: usr/local/bin/md5fa: unpack to regular file: short write: write /scratch/21813747/build-temp-4245895399/rootfs/usr/local/bin/md5fa: no space left on device
```

