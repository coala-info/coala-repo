# ccmetagen CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ccmetagen_CCMetagen.py | Failed | tool bug: CCMetagen 1.5.0 runs on the tutorial KMA .res file but writes unk_sk as Superkingdom for every hit with the current NCBI taxonomy (fixed upstream, not released), and it ignores --local_taxfile for lineages. |

## Metadata
- **Skill**: generated

## ccmetagen_CCMetagen.py

### Tool Description
CCMetagen is a pipeline for accurate taxonomic classification and abundance estimation of metagenomic data, typically using KMA (K-mer Alignment) results.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccmetagen:1.5.0--pyh7cba7a3_0
- **Homepage**: https://github.com/vrmarcelino/CCMetagen
- **Package**: https://anaconda.org/channels/bioconda/packages/ccmetagen/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/ccmetagen:1.5.0--pyh7cba7a3_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:a61e43061a78ce4af086276d9868307e32d735233aa29ff25245f3ac306c8e61: unpack entry: usr/local/bin/linguist: unpack to regular file: short write: write /tmp/build-temp-2490919503/rootfs/usr/local/bin/linguist: no space left on device
```

