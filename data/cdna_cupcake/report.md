# cdna_cupcake CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cdna_cupcake_collapse_isoforms_by_sam.py | PASS |  |
| cdna_cupcake_fa2fq.py | PASS |  |
| cdna_cupcake_get_abundance_post_collapse.py | PASS |  |

## Metadata
- **Skill**: generated

## cdna_cupcake_collapse_isoforms_by_sam.py

### Tool Description
Collapse redundant isoforms based on SAM alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
- **Homepage**: https://github.com/Magdoll/cDNA_Cupcake
- **Package**: https://anaconda.org/channels/bioconda/packages/cdna_cupcake/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:798675d4d65b9cbec2e86ff2d5ce3471c63079a5ce8eea7e3e57fdfd2b9f7f73: unpack entry: usr/local/bin/img2webp: unpack to regular file: short write: write /tmp/build-temp-4137329448/rootfs/usr/local/bin/img2webp: no space left on device
```

## cdna_cupcake_get_abundance_post_collapse.py

### Tool Description
Calculate transcript abundance after collapsing redundant isoforms by mapping back to the original cluster reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
- **Homepage**: https://github.com/Magdoll/cDNA_Cupcake
- **Package**: https://anaconda.org/channels/bioconda/packages/cdna_cupcake/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:798675d4d65b9cbec2e86ff2d5ce3471c63079a5ce8eea7e3e57fdfd2b9f7f73: unpack entry: usr/local/bin/img2webp: unpack to regular file: short write: write /tmp/build-temp-3444720414/rootfs/usr/local/bin/img2webp: no space left on device
```

## cdna_cupcake_fa2fq.py

### Tool Description
Convert FASTA format files to FASTQ format. (Note: The provided help text contained system error logs; arguments are derived from the tool's standard usage).

### Metadata
- **Docker Image**: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
- **Homepage**: https://github.com/Magdoll/cDNA_Cupcake
- **Package**: https://anaconda.org/channels/bioconda/packages/cdna_cupcake/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:798675d4d65b9cbec2e86ff2d5ce3471c63079a5ce8eea7e3e57fdfd2b9f7f73: unpack entry: usr/local/bin/icuinfo: unpack to regular file: short write: write /tmp/build-temp-3223362429/rootfs/usr/local/bin/icuinfo: no space left on device
```

